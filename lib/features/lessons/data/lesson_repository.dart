import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;

import '../../../core/database/app_database.dart' hide UserProfile;
import '../../../core/utils/fsrs_algorithm.dart';
import '../../../core/utils/user_segment.dart';
import '../domain/lesson_entities.dart';

// ── Kelime veritabanları A1-C2 ───────────────────────────────
import '../domain/a1_kelime_db.dart';
import '../domain/a2_kelime_db.dart';
import '../domain/b1_kelime_db.dart';
import '../domain/b2_kelime_db.dart';
import '../domain/c1_kelime_db.dart';
import '../domain/c2_kelime_db.dart';

// ── Ders tanımları A1-C2 ─────────────────────────────────────
import '../domain/a1_lesson_definitions.dart';
import '../domain/a2_lesson_definitions.dart';
import '../domain/b1_lesson_definitions.dart';
import '../domain/b2_lesson_definitions.dart';
import '../domain/c1_lesson_definitions.dart';
import '../domain/c2_lesson_definitions.dart';

// ════════════════════════════════════════════════════════════════
// SEVİYE SABİTLERİ
// ════════════════════════════════════════════════════════════════

const Map<String, int> kLevelNumbers = {
  'a1': 1, 'a2': 2, 'b1': 3, 'b2': 4, 'c1': 5, 'c2': 6,
};

const Map<int, String> kLevelNames = {
  1: 'A1', 2: 'A2', 3: 'B1', 4: 'B2', 5: 'C1', 6: 'C2',
};

const Map<int, int> kLevelWordCount = {
  1: 400, 2: 700, 3: 1500, 4: 500, 5: 500, 6: 300,
};

// ════════════════════════════════════════════════════════════════
// PROVIDERS
// ════════════════════════════════════════════════════════════════

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final lessonRepositoryProvider = Provider<LessonRepository>((ref) {
  return LessonRepository(ref.watch(databaseProvider));
});

/// Kullanıcı profili — auth_service'ten gelecek
final userProfileProvider = Provider<UserProfile>((ref) {
  return const UserProfile(
    userId: 'anonymous',
    currentLevel: 'a1',
    targetLevel: 'b2',
    isHeritage: false,
    dailyGoal: 20,
  );
});

// ════════════════════════════════════════════════════════════════
// LESSON REPOSITORY
// ════════════════════════════════════════════════════════════════

class LessonRepository {
  final AppDatabase _db;
  LessonRepository(this._db);

  // ── SEED ──────────────────────────────────────────────────

  /// İlk açılışta tüm seviyeleri yükle
  Future<void> seedAllLevels() async {
    for (var i = 1; i <= 6; i++) {
      await _seedLevel(i);
    }
  }

  Future<void> _seedLevel(int levelNum) async {
    final existing = await _db.getCardsByLevel(levelNum);
    if (existing.isNotEmpty) return;

    final words = _wordsForLevel(levelNum);
    final companions = words.map((k) => VocabularyCardsCompanion.insert(
      id: k.id,
      kurmanji: k.ku,
      turkish: k.tr,
      category: k.kat,
      initialDifficulty: Value(k.zor),
      sentencesHeritage: Value(jsonEncode(k.her)),
      sentencesGeneral: Value(jsonEncode(k.gen)),
      level: Value(levelNum),
      gender: Value(k.cins),
    )).toList();

    await _db.batchInsertCards(companions);
  }

  List<dynamic> _wordsForLevel(int level) => switch (level) {
    1 => kA1TamKelimeler,
    2 => kA2TamListe,
    3 => kB1Temam,
    4 => kB2Temam2,
    5 => kC1Nihayi5,
    6 => kC2Temam,
    _ => kA1TamKelimeler,
  };

  // ── KARTLAR ───────────────────────────────────────────────

  Future<List<VocabularyCardModel>> getDueCards({
    required String userId,
    required UserProfile profile,
  }) async {
    final reviews = await _db.getDueCards(userId);
    final result = <VocabularyCardModel>[];
    for (final r in reviews) {
      final card = await _db.getCard(r.cardId);
      if (card == null) continue;
      result.add(_toModel(card, FSRSCard(
        cardId: r.cardId,
        stability: r.stability,
        difficulty: r.difficulty,
        retrievability: r.retrievability,
        state: _parseState(r.state),
        lastReview: r.lastReview,
        dueDate: r.dueDate,
        reviewCount: r.reviewCount,
        lapseCount: r.lapseCount,
      )));
    }
    return result;
  }

  Future<List<VocabularyCardModel>> getNewCards({
    required int level,
    required int limit,
  }) async {
    final cards = await _db.getNewCardsByLevel(level, limit);
    return cards.map((c) => _toModel(c, FSRSCard.newCard(c.id))).toList();
  }

  Future<List<VocabularyCardModel>> getCardsByCategory(
      String category, int level) async {
    final cards = await _db.getCardsByCategory(category, level);
    return cards.map((c) => _toModel(c, FSRSCard.newCard(c.id))).toList();
  }

  Future<List<VocabularyCardModel>> searchCards(String query) async {
    if (query.trim().isEmpty) return [];
    final cards = await _db.searchCards(query.trim());
    return cards.map((c) => _toModel(c, FSRSCard.newCard(c.id))).toList();
  }

  // ── FSRS GÜNCELLEME ───────────────────────────────────────

  Future<void> updateCardAfterReview({
    required String userId,
    required String cardId,
    required Rating rating,
  }) async {
    final existing = await _db.getReview(userId, cardId);
    if (existing == null) {
      final updated = FSRSAlgorithm.schedule(FSRSCard.newCard(cardId), rating);
      await _db.createReview(userId, cardId, updated);
    } else {
      final fsrs = FSRSCard(
        cardId: cardId,
        stability: existing.stability,
        difficulty: existing.difficulty,
        retrievability: existing.retrievability,
        state: _parseState(existing.state),
        lastReview: existing.lastReview,
        dueDate: existing.dueDate,
        reviewCount: existing.reviewCount,
        lapseCount: existing.lapseCount,
      );
      await _db.updateReview(userId, cardId, FSRSAlgorithm.schedule(fsrs, rating));
    }
  }

  // ── DERSLER ───────────────────────────────────────────────

  List<LessonModel> getLessonsForLevel(int level) => switch (level) {
    1 => kA1Lessons,
    2 => kA2Lessons,
    3 => kB1Lessons,
    4 => kB2Lessons,
    5 => kC1Lessons,
    6 => kC2Lessons,
    _ => kA1Lessons,
  };

  List<LessonModel> getAllLessons() => [
    ...kA1Lessons, ...kA2Lessons, ...kB1Lessons,
    ...kB2Lessons, ...kC1Lessons, ...kC2Lessons,
  ];

  Future<void> markLessonComplete(String userId, String lessonId) =>
      _db.markLessonComplete(userId, lessonId);

  Future<Set<String>> getCompletedLessons(String userId) =>
      _db.getCompletedLessons(userId);

  // ── İSTATİSTİK ───────────────────────────────────────────

  Future<DailyStats> getDailyStats(String userId) async {
    final reviews = await _db.getReviewsForDate(userId, DateTime.now());
    return DailyStats(
      totalReviewed: reviews.length,
      correctCount: reviews.where((r) => r.wasCorrect).length,
      dueCount: await _db.getDueCardCount(userId),
      streakDays: await _db.getStreakDays(userId),
      xpToday: reviews.length * 10,
    );
  }

  Future<LevelProgress> getLevelProgress(String userId, int level) async {
    final total = kLevelWordCount[level] ?? 0;
    return LevelProgress(
      level: level,
      levelName: kLevelNames[level] ?? 'A1',
      totalCards: total,
      learnedCards: await _db.getLearnedCardCount(userId, level),
      masteredCards: await _db.getMasteredCardCount(userId, level),
      completionPercent: total > 0
          ? (await _db.getLearnedCardCount(userId, level)) / total
          : 0.0,
    );
  }

  // ── YARDIMCI ─────────────────────────────────────────────

  VocabularyCardModel _toModel(dynamic card, FSRSCard fsrs) =>
      VocabularyCardModel(
        id: card.id,
        kurmanji: card.kurmanji,
        turkish: card.turkish,
        category: card.category,
        gender: card.gender,
        level: card.level,
        fsrsCard: fsrs,
        sentencesHeritage: _parseSentences(card.sentencesHeritage),
        sentencesGeneral: _parseSentences(card.sentencesGeneral),
      );

  CardState _parseState(String s) => switch (s) {
    'learning' => CardState.learning,
    'review' => CardState.review,
    'relearning' => CardState.relearning,
    _ => CardState.newCard,
  };

  List<String> _parseSentences(String? json) {
    if (json == null || json.isEmpty) return [];
    try {
      final d = jsonDecode(json);
      return d is List ? d.cast<String>() : [];
    } catch (_) { return []; }
  }
}

// ════════════════════════════════════════════════════════════════
// MODEL SINIFLARI
// ════════════════════════════════════════════════════════════════

class VocabularyCardModel {
  final String id;
  final String kurmanji;
  final String turkish;
  final String category;
  final String gender;
  final int level;
  final FSRSCard fsrsCard;
  final List<String> sentencesHeritage;
  final List<String> sentencesGeneral;

  const VocabularyCardModel({
    required this.id, required this.kurmanji, required this.turkish,
    required this.category, required this.gender, required this.level,
    required this.fsrsCard, required this.sentencesHeritage,
    required this.sentencesGeneral,
  });

  String get levelName => kLevelNames[level] ?? 'A1';
  bool get isMastered =>
      fsrsCard.state == CardState.review && fsrsCard.stability > 21.0;
}

class DailyStats {
  final int totalReviewed;
  final int correctCount;
  final int dueCount;
  final int streakDays;
  final int xpToday;

  const DailyStats({
    required this.totalReviewed, required this.correctCount,
    required this.dueCount, required this.streakDays, required this.xpToday,
  });

  double get accuracy => totalReviewed > 0 ? correctCount / totalReviewed : 0.0;
}

class LevelProgress {
  final int level;
  final String levelName;
  final int totalCards;
  final int learnedCards;
  final int masteredCards;
  final double completionPercent;

  const LevelProgress({
    required this.level, required this.levelName, required this.totalCards,
    required this.learnedCards, required this.masteredCards,
    required this.completionPercent,
  });
}

// ════════════════════════════════════════════════════════════════
// RIVERPOD FEATURE PROVIDERS
// ════════════════════════════════════════════════════════════════

final dueCardsProvider =
    FutureProvider.family<List<VocabularyCardModel>, String>((ref, userId) {
  return ref.watch(lessonRepositoryProvider).getDueCards(
    userId: userId,
    profile: ref.watch(userProfileProvider),
  );
});

final levelLessonsProvider =
    Provider.family<List<LessonModel>, int>((ref, level) {
  return ref.watch(lessonRepositoryProvider).getLessonsForLevel(level);
});

final levelProgressProvider =
    FutureProvider.family<LevelProgress, ({String userId, int level})>(
        (ref, args) {
  return ref.watch(lessonRepositoryProvider)
      .getLevelProgress(args.userId, args.level);
});

final dailyStatsProvider =
    FutureProvider.family<DailyStats, String>((ref, userId) {
  return ref.watch(lessonRepositoryProvider).getDailyStats(userId);
});

final searchResultsProvider =
    FutureProvider.family<List<VocabularyCardModel>, String>((ref, query) {
  return ref.watch(lessonRepositoryProvider).searchCards(query);
});
