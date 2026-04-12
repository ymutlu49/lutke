import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// Otomatik oluşturulan kod: dart run build_runner build
part 'app_database.g.dart';

// ════════════════════════════════════════════════════════════════
// TABLOLAR
// ════════════════════════════════════════════════════════════════

class VocabularyCards extends Table {
  TextColumn get id => text()();
  TextColumn get kurmanji => text()();
  TextColumn get turkish => text()();
  TextColumn get english => text().nullable()();
  TextColumn get audioUrl => text().nullable()();
  TextColumn get gender => text().withDefault(const Constant('bêcins'))();
  TextColumn get category => text()();
  IntColumn get level => integer().withDefault(const Constant(1))();
  TextColumn get sentencesHeritage => text().withDefault(const Constant('[]'))();
  TextColumn get sentencesGeneral => text().withDefault(const Constant('[]'))();
  RealColumn get initialDifficulty => real().withDefault(const Constant(0.75))();

  @override
  Set<Column> get primaryKey => {id};
}

class FsrsReviews extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get cardId => text()();
  TextColumn get userId => text()();
  RealColumn get stability => real().withDefault(const Constant(1.0))();
  RealColumn get difficulty => real().withDefault(const Constant(5.0))();
  RealColumn get retrievability => real().withDefault(const Constant(0.9))();
  TextColumn get state => text().withDefault(const Constant('new'))();
  // new / learning / review / relearning
  IntColumn get reviewCount => integer().withDefault(const Constant(0))();
  IntColumn get lapseCount => integer().withDefault(const Constant(0))();
  BoolColumn get wasCorrect => boolean().withDefault(const Constant(true))();
  DateTimeColumn get lastReview => dateTime().nullable()();
  DateTimeColumn get dueDate => dateTime()();
}

class CompletedLessons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get lessonId => text()();
  DateTimeColumn get completedAt => dateTime()();
  IntColumn get correctCount => integer().withDefault(const Constant(0))();
  IntColumn get totalCount => integer().withDefault(const Constant(0))();
  IntColumn get xpEarned => integer().withDefault(const Constant(0))();
  IntColumn get durationSeconds => integer().withDefault(const Constant(0))();
}

class UserProgress extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get lessonId => text()();
  IntColumn get completedAt => integer()();
  IntColumn get correctCount => integer()();
  IntColumn get totalCount => integer()();
  IntColumn get xpEarned => integer()();
  IntColumn get durationSeconds => integer()();
}

class UserProfiles extends Table {
  TextColumn get userId => text()();
  TextColumn get displayName => text().withDefault(const Constant(''))();
  TextColumn get segment => text().withDefault(const Constant('heritageKurdish'))();
  TextColumn get currentLevel => text().withDefault(const Constant('a1'))();
  TextColumn get interfaceLanguage => text().withDefault(const Constant('tr'))();
  IntColumn get dailyGoalCards => integer().withDefault(const Constant(20))();
  IntColumn get streakDays => integer().withDefault(const Constant(0))();
  IntColumn get totalXp => integer().withDefault(const Constant(0))();
  BoolColumn get dyslexiaMode => boolean().withDefault(const Constant(false))();
  BoolColumn get animationsEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get isHeritage => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastActiveDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {userId};
}

class EarnedBadges extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get badgeId => text()();
  DateTimeColumn get earnedAt => dateTime()();
}

// ════════════════════════════════════════════════════════════════
// DATABASE
// ════════════════════════════════════════════════════════════════

@DriftDatabase(tables: [
  VocabularyCards,
  FsrsReviews,
  CompletedLessons,
  UserProgress,
  UserProfiles,
  EarnedBadges,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) await m.createTable(completedLessons);
      if (from < 3) await m.addColumn(fsrsReviews, fsrsReviews.wasCorrect);
    },
  );

  // ── KELIME KARTLARI ──────────────────────────────────────────

  Future<List<VocabularyCard>> getCardsByLevel(int level) =>
      (select(vocabularyCards)..where((t) => t.level.equals(level))).get();

  Future<List<VocabularyCard>> getCardsByCategory(
          String category, int level) =>
      (select(vocabularyCards)
            ..where((t) =>
                t.category.equals(category) & t.level.equals(level)))
          .get();

  Future<VocabularyCard?> getCard(String id) =>
      (select(vocabularyCards)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<void> batchInsertCards(
      List<VocabularyCardsCompanion> cards) async {
    await batch((b) => b.insertAllOnConflictUpdate(vocabularyCards, cards));
  }

  Future<List<VocabularyCard>> getNewCardsByLevel(
      int level, int limit) async {
    // "Yeni" = hiç review kaydı olmayan kartlar
    final reviewed = await (select(fsrsReviews)
          ..where((t) => t.state.isNotIn(['new'])))
        .map((r) => r.cardId)
        .get();

    return (select(vocabularyCards)
          ..where((t) =>
              t.level.equals(level) & t.id.isNotIn(reviewed))
          ..limit(limit))
        .get();
  }

  Future<List<VocabularyCard>> searchCards(String query) {
    final q = '%$query%';
    return (select(vocabularyCards)
          ..where((t) =>
              t.kurmanji.like(q) | t.turkish.like(q)))
        .get();
  }

  // ── FSRS REVIEW ───────────────────────────────────────────

  Future<FsrsReview?> getReview(String userId, String cardId) =>
      (select(fsrsReviews)
            ..where((t) =>
                t.userId.equals(userId) & t.cardId.equals(cardId)))
          .getSingleOrNull();

  Future<List<FsrsReview>> getDueCards(String userId) {
    final now = DateTime.now();
    return (select(fsrsReviews)
          ..where((t) =>
              t.userId.equals(userId) &
              t.dueDate.isSmallerOrEqualValue(now)))
        .get();
  }

  Future<int> getDueCardCount(String userId) async {
    final cards = await getDueCards(userId);
    return cards.length;
  }

  Future<void> createReview(
      String userId, String cardId, dynamic fsrsCard) async {
    await into(fsrsReviews).insert(FsrsReviewsCompanion.insert(
      userId: userId,
      cardId: cardId,
      stability: Value(fsrsCard.stability),
      difficulty: Value(fsrsCard.difficulty),
      retrievability: Value(fsrsCard.retrievability),
      state: Value(fsrsCard.state.name),
      reviewCount: Value(fsrsCard.reviewCount),
      lapseCount: Value(fsrsCard.lapseCount),
      dueDate: fsrsCard.dueDate,
      wasCorrect: Value(fsrsCard.lastRatingWasCorrect),
      lastReview: Value(DateTime.now()),
    ));
  }

  Future<void> updateReview(
      String userId, String cardId, dynamic fsrsCard) async {
    await (update(fsrsReviews)
          ..where((t) =>
              t.userId.equals(userId) & t.cardId.equals(cardId)))
        .write(FsrsReviewsCompanion(
      stability: Value(fsrsCard.stability),
      difficulty: Value(fsrsCard.difficulty),
      retrievability: Value(fsrsCard.retrievability),
      state: Value(fsrsCard.state.name),
      reviewCount: Value(fsrsCard.reviewCount),
      lapseCount: Value(fsrsCard.lapseCount),
      dueDate: Value(fsrsCard.dueDate),
      wasCorrect: Value(fsrsCard.lastRatingWasCorrect),
      lastReview: Value(DateTime.now()),
    ));
  }

  Future<List<FsrsReview>> getReviewsForDate(
      String userId, DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return (select(fsrsReviews)
          ..where((t) =>
              t.userId.equals(userId) &
              t.lastReview.isBiggerOrEqualValue(start) &
              t.lastReview.isSmallerThanValue(end)))
        .get();
  }

  Future<int> getLearnedCardCount(String userId, int level) async {
    final levelCards =
        await getCardsByLevel(level).then((c) => c.map((x) => x.id).toSet());
    final reviews = await (select(fsrsReviews)
          ..where((t) =>
              t.userId.equals(userId) &
              t.reviewCount.isBiggerOrEqualValue(1)))
        .get();
    return reviews.where((r) => levelCards.contains(r.cardId)).length;
  }

  Future<int> getMasteredCardCount(String userId, int level) async {
    final levelCards =
        await getCardsByLevel(level).then((c) => c.map((x) => x.id).toSet());
    final reviews = await (select(fsrsReviews)
          ..where((t) =>
              t.userId.equals(userId) &
              t.state.equals('review') &
              t.stability.isBiggerThanValue(21.0)))
        .get();
    return reviews.where((r) => levelCards.contains(r.cardId)).length;
  }

  Future<int> getStreakDays(String userId) async {
    final profile = await getUserProfile(userId);
    return profile?.streakDays ?? 0;
  }

  // ── TAMAMLANAN DERSLER ────────────────────────────────────

  Future<void> markLessonComplete(String userId, String lessonId) async {
    // Zaten tamamlandıysa güncelle
    final existing = await (select(completedLessons)
          ..where((t) =>
              t.userId.equals(userId) & t.lessonId.equals(lessonId)))
        .getSingleOrNull();
    if (existing != null) return;

    await into(completedLessons).insert(CompletedLessonsCompanion.insert(
      userId: userId,
      lessonId: lessonId,
      completedAt: DateTime.now(),
    ));
  }

  Future<Set<String>> getCompletedLessons(String userId) async {
    final rows = await (select(completedLessons)
          ..where((t) => t.userId.equals(userId)))
        .get();
    return rows.map((r) => r.lessonId).toSet();
  }

  Future<void> saveLessonResult({
    required String userId,
    required String lessonId,
    required int correctCount,
    required int totalCount,
    required int xpEarned,
    required int durationSeconds,
  }) async {
    await markLessonComplete(userId, lessonId);
    await into(userProgress).insert(UserProgressCompanion.insert(
      userId: userId,
      lessonId: lessonId,
      completedAt: DateTime.now().millisecondsSinceEpoch,
      correctCount: correctCount,
      totalCount: totalCount,
      xpEarned: xpEarned,
      durationSeconds: durationSeconds,
    ));
    // XP güncelle
    await _addXP(userId, xpEarned);
  }

  // ── KULLANICI PROFİLİ ─────────────────────────────────────

  Future<UserProfile?> getUserProfile(String userId) =>
      (select(userProfiles)..where((t) => t.userId.equals(userId)))
          .getSingleOrNull();

  Future<void> upsertUserProfile(UserProfilesCompanion profile) =>
      into(userProfiles).insertOnConflictUpdate(profile);

  Future<void> updateStreak(String userId) async {
    final profile = await getUserProfile(userId);
    if (profile == null) return;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastActive = profile.lastActiveDate;

    int streak = profile.streakDays;
    if (lastActive != null) {
      final last = DateTime(lastActive.year, lastActive.month, lastActive.day);
      final diff = today.difference(last).inDays;
      if (diff == 1) {
        streak++; // Seri devam ediyor
      } else if (diff > 1) {
        streak = 1; // Seri bozuldu
      }
      // diff == 0 → aynı gün, değişmez
    } else {
      streak = 1;
    }

    await (update(userProfiles)
          ..where((t) => t.userId.equals(userId)))
        .write(UserProfilesCompanion(
      streakDays: Value(streak),
      lastActiveDate: Value(now),
    ));
  }

  Future<void> _addXP(String userId, int xp) async {
    final profile = await getUserProfile(userId);
    if (profile == null) return;
    await (update(userProfiles)
          ..where((t) => t.userId.equals(userId)))
        .write(UserProfilesCompanion(
      totalXp: Value(profile.totalXp + xp),
    ));
  }

  // ── ROZETLER ─────────────────────────────────────────────

  Future<List<EarnedBadge>> getUserBadges(String userId) =>
      (select(earnedBadges)..where((t) => t.userId.equals(userId))).get();

  Future<bool> hasBadge(String userId, String badgeId) async {
    final result = await (select(earnedBadges)
          ..where((t) =>
              t.userId.equals(userId) & t.badgeId.equals(badgeId)))
        .getSingleOrNull();
    return result != null;
  }

  Future<void> awardBadge(String userId, String badgeId) async {
    if (await hasBadge(userId, badgeId)) return;
    await into(earnedBadges).insert(EarnedBadgesCompanion.insert(
      userId: userId,
      badgeId: badgeId,
      earnedAt: DateTime.now(),
    ));
  }
}

// ════════════════════════════════════════════════════════════════
// BAĞLANTI
// ════════════════════════════════════════════════════════════════

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'lutke_v3.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
