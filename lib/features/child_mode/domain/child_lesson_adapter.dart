import '../../lessons/domain/entities/exercise.dart';
import '../../lessons/domain/entities/lesson.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Ders Adaptörü
//
// Mevcut A1/A2 derslerini çocuklar için adapte eder:
//   - Typing ve MinimalPair egzersizlerini filtreler
//   - Ders başına max 4 egzersiz (7-8 yaş sustained attention ~15-20
//     dk, 1.5 dk/egzersiz → 6 dk hedef — Ruff-Rothbart 1996)
//   - SentenceOrder max 4 kelime
// ════════════════════════════════════════════════════════════════

abstract class ChildLessonAdapter {
  /// Çocuklar için uygun egzersiz tipleri.
  /// - PictureMatch: görsel eşleştirme — disleksi dostu, 7-10 yaş için ideal
  /// - MemoryMatch: klasik hafıza oyunu — yazı yükü yok, dikkat+bellek
  /// Typing: çıkarıldı — Piaget somut-işlem evresinde orthographic
  /// production yükü henüz erken; FillInBlank (seçmeli) yeter.
  static const _allowedTypes = {
    ExerciseType.listenAndSelect,
    ExerciseType.multipleChoice,
    ExerciseType.sentenceOrder,
    ExerciseType.fillInBlank,
    ExerciseType.culturalContent,
    ExerciseType.pictureMatch,
    ExerciseType.memoryMatch,
  };

  /// Bir dersi çocuk moduna adapte eder.
  static Lesson adaptLesson(Lesson lesson) {
    final filtered = lesson.exercises.where(_isChildSafe).toList();

    // Max 4 egzersiz (attention span, Ruff-Rothbart 1996 ve
    // Anderson 2010: 7 yaş sürdürülebilir dikkat 15-20 dk).
    final limited = filtered.length > 4 ? filtered.sublist(0, 4) : filtered;

    // En az 2 egzersiz yoksa mevcut haliyle dön
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
