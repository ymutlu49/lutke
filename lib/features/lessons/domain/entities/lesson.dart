import 'exercise.dart';
import 'vocabulary_card.dart';

// ════════════════════════════════════════════════════════════════
// DERS MODELİ — LÛTKE
//
// İlke §4.5: Birimler ilişki senaryosuna göre adlandırılıyor
// İlke §7.1: Her birimin sonunda kültürel içerik zorunlu
// ════════════════════════════════════════════════════════════════

/// İçerik yolu — Heritage / General / Kültürel
enum LessonPath {
  heritage(labelKu: 'Rêya Malê', labelTr: 'Ev Yolu'),
  general(labelKu: 'Rêya Nû', labelTr: 'Yeni Yol'),
  cultural(labelKu: 'Rêya Çandê', labelTr: 'Kültür Yolu');

  final String labelKu;
  final String labelTr;

  const LessonPath({required this.labelKu, required this.labelTr});
}

/// Tek bir ders — egzersizler, hedef kelimeler ve kültürel ödül içerir.
class Lesson {
  final String id;
  final String titleKu;
  final String titleTr;
  final int unitNumber;
  final int lessonNumber;
  final CEFRLevel level;
  final LessonPath path;
  final List<Exercise> exercises;
  final String? culturalRewardId;
  final List<String> targetCardIds;
  final int estimatedMinutes;
  final String? emoji;

  const Lesson({
    required this.id,
    required this.titleKu,
    required this.titleTr,
    required this.unitNumber,
    required this.lessonNumber,
    required this.level,
    required this.path,
    required this.exercises,
    this.culturalRewardId,
    this.targetCardIds = const [],
    this.estimatedMinutes = 8,
    this.emoji,
  });

  /// Toplam XP ödülü.
  int get totalXP => exercises.fold(0, (sum, e) => sum + e.xpReward);

  /// Heritage içeriği olan egzersiz var mı?
  bool get hasHeritageContent => path == LessonPath.heritage;

  /// Egzersiz sayısı.
  int get exerciseCount => exercises.length;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Lesson && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Lesson($id: $titleKu [${level.label}])';
}

// ════════════════════════════════════════════════════════════════
// DERS OTURUM DURUMU — Riverpod state olarak kullanılır
// ════════════════════════════════════════════════════════════════

/// Bir ders oturumunun tüm durumunu immutable olarak taşır.
/// LessonScreen artık 7+ mutable değişken yerine bunu kullanır.
class LessonSessionState {
  final Lesson lesson;
  final int currentIndex;
  final List<ExerciseResult> results;
  final bool isCompleted;
  final DateTime startedAt;

  const LessonSessionState({
    required this.lesson,
    this.currentIndex = 0,
    this.results = const [],
    this.isCompleted = false,
    required this.startedAt,
  });

  Exercise get currentExercise => lesson.exercises[currentIndex];
  bool get hasNext => currentIndex < lesson.exercises.length - 1;
  int get totalExercises => lesson.exercises.length;
  double get progress => (currentIndex + 1) / totalExercises;

  int get correctCount => results.where((r) => r.isCorrect).length;
  double get accuracy =>
      results.isEmpty ? 0.0 : correctCount / results.length;
  int get earnedXP => results.fold(0, (sum, r) => sum + r.xpEarned);

  Duration get elapsed => DateTime.now().difference(startedAt);

  LessonSessionState advance(ExerciseResult result) {
    final newResults = [...results, result];
    final nextIndex = currentIndex + 1;
    return LessonSessionState(
      lesson: lesson,
      currentIndex: nextIndex >= totalExercises ? currentIndex : nextIndex,
      results: newResults,
      isCompleted: nextIndex >= totalExercises,
      startedAt: startedAt,
    );
  }
}

/// Tek bir egzersiz sonucu.
class ExerciseResult {
  final String exerciseId;
  final bool isCorrect;
  final int xpEarned;
  final Duration responseTime;
  final String? cardId;

  const ExerciseResult({
    required this.exerciseId,
    required this.isCorrect,
    required this.xpEarned,
    required this.responseTime,
    this.cardId,
  });
}
