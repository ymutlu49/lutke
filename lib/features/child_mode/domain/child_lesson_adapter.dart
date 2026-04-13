import '../../lessons/domain/entities/exercise.dart';
import '../../lessons/domain/entities/lesson.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Ders Adaptörü
//
// Mevcut A1/A2 derslerini çocuklar için adapte eder:
//   - Typing ve MinimalPair egzersizlerini filtreler
//   - Ders başına 3-5 egzersiz sınırı
//   - SentenceOrder max 4 kelime
// ════════════════════════════════════════════════════════════════

abstract class ChildLessonAdapter {
  /// Çocuklar için uygun egzersiz tipleri.
  static const _allowedTypes = {
    ExerciseType.listenAndSelect,
    ExerciseType.multipleChoice,
    ExerciseType.sentenceOrder,
    ExerciseType.fillInBlank,
    ExerciseType.culturalContent,
  };

  /// Bir dersi çocuk moduna adapte eder.
  static Lesson adaptLesson(Lesson lesson) {
    final filtered = lesson.exercises.where(_isChildSafe).toList();

    // Max 5 egzersiz
    final limited = filtered.length > 5 ? filtered.sublist(0, 5) : filtered;

    // En az 3 egzersiz yoksa mevcut haliyle dön
    if (limited.length < 2) return lesson;

    return Lesson(
      id: lesson.id,
      titleKu: lesson.titleKu,
      titleTr: lesson.titleTr,
      unitNumber: lesson.unitNumber,
      lessonNumber: lesson.lessonNumber,
      level: lesson.level,
      path: lesson.path,
      exercises: limited,
      culturalRewardId: lesson.culturalRewardId,
      targetCardIds: lesson.targetCardIds,
      estimatedMinutes: (limited.length * 1.5).ceil(), // ~1.5 dk/egzersiz
      emoji: lesson.emoji,
    );
  }

  /// Egzersiz çocuklar için uygun mu?
  static bool _isChildSafe(Exercise exercise) {
    // Tip kontrolü
    if (!_allowedTypes.contains(exercise.type)) return false;

    // SentenceOrder: max 4 kelime
    if (exercise is SentenceOrderExercise) {
      return exercise.correctOrder.length <= 4;
    }

    return true;
  }

  /// Doğruluk oranından yıldız sayısı hesapla.
  static int starsFromAccuracy(double accuracy) {
    if (accuracy >= 0.9) return 3;
    if (accuracy >= 0.5) return 2;
    if (accuracy > 0) return 1;
    return 0;
  }
}
