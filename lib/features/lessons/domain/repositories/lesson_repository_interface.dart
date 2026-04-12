import '../../../../core/errors/failures.dart';
import '../../../../core/utils/fsrs_algorithm.dart';
import '../entities/vocabulary_card.dart';
import '../entities/lesson.dart';
import '../entities/user_profile.dart';

// ════════════════════════════════════════════════════════════════
// REPOSITORY INTERFACES — LÛTKE
//
// Clean Architecture: Domain katmanı veri kaynağını bilmez.
// Bu arayüzler domain'de yaşar, implementasyon data/'da.
// Test'te mock'lanır — veritabanı olmadan birim testi yapılır.
// ════════════════════════════════════════════════════════════════

/// Kelime kartı operasyonları.
abstract interface class ICardRepository {
  Future<Result<void>> seedLevel(CEFRLevel level);
  Future<Result<List<VocabularyCard>>> getDueCards(String userId);
  Future<Result<List<VocabularyCard>>> getNewCards(CEFRLevel level, int limit);
  Future<Result<List<VocabularyCard>>> getByCategory(
      KurmanjiCategory category, CEFRLevel level);
  Future<Result<List<VocabularyCard>>> search(String query);
  Future<Result<void>> updateAfterReview(
      String userId, String cardId, Rating rating);
}

/// Ders operasyonları.
abstract interface class ILessonRepository {
  List<Lesson> getLessonsForLevel(CEFRLevel level);
  Future<Result<Set<String>>> getCompletedLessons(String userId);
  Future<Result<void>> markCompleted(String userId, String lessonId);
}

/// İstatistik operasyonları.
abstract interface class IStatsRepository {
  Future<Result<DailyStats>> getDailyStats(String userId);
  Future<Result<LevelProgress>> getLevelProgress(String userId, CEFRLevel level);
}

/// Kullanıcı profili operasyonları.
abstract interface class IUserRepository {
  Future<Result<UserProfile?>> getProfile(String userId);
  Future<Result<void>> saveProfile(UserProfile profile);
  Future<Result<void>> updateXP(String userId, int xpDelta);
  Future<Result<void>> updateStreak(String userId, int streakDays);
}

// ════════════════════════════════════════════════════════════════
// İSTATİSTİK MODELLERİ
// ════════════════════════════════════════════════════════════════

/// Günlük istatistikler.
class DailyStats {
  final int totalReviewed;
  final int correctCount;
  final int dueCount;
  final int streakDays;
  final int xpToday;

  const DailyStats({
    required this.totalReviewed,
    required this.correctCount,
    required this.dueCount,
    required this.streakDays,
    required this.xpToday,
  });

  double get accuracy =>
      totalReviewed > 0 ? correctCount / totalReviewed : 0.0;

  static const empty = DailyStats(
    totalReviewed: 0, correctCount: 0,
    dueCount: 0, streakDays: 0, xpToday: 0,
  );
}

/// Seviye ilerleme bilgisi.
class LevelProgress {
  final CEFRLevel level;
  final int totalCards;
  final int learnedCards;
  final int masteredCards;

  const LevelProgress({
    required this.level,
    required this.totalCards,
    required this.learnedCards,
    required this.masteredCards,
  });

  double get completionPercent =>
      totalCards > 0 ? learnedCards / totalCards : 0.0;

  String get levelName => level.label;
}
