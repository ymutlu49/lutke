import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/fsrs_algorithm.dart';
import '../domain/entities/exercise.dart';
import '../domain/entities/lesson.dart';

// ════════════════════════════════════════════════════════════════
// DERS OTURUM YÖNETİCİSİ — Riverpod StateNotifier
//
// Önceki LessonScreen'de 7+ mutable değişken vardı:
//   _currentIndex, _showAnswer, _correctCount, _totalSeen,
//   _ratings, _cardStartTime, _exercises
//
// Artık tüm durum tek bir immutable state'te. UI sadece izler.
//
// İlke §4: Gamification — seri, XP, rozet durumu burada takip edilir
// İlke §3.2: FSRS derecelendirme → kaydet → sonraki kart
// ════════════════════════════════════════════════════════════════

/// Bir ders oturumunun tüm durumu.
class LessonSessionNotifier extends StateNotifier<LessonSessionState> {
  LessonSessionNotifier(Lesson lesson)
      : super(LessonSessionState(
          lesson: lesson,
          startedAt: DateTime.now(),
        ));

  DateTime _exerciseStartedAt = DateTime.now();

  /// Kullanıcı bir egzersizi yanıtladığında.
  void submitAnswer({
    required bool isCorrect,
    required int xpEarned,
    Rating? rating,
  }) {
    final responseTime = DateTime.now().difference(_exerciseStartedAt);
    final result = ExerciseResult(
      exerciseId: state.currentExercise.id,
      isCorrect: isCorrect,
      xpEarned: xpEarned,
      responseTime: responseTime,
      cardId: state.currentExercise.cardId,
    );

    state = state.advance(result);
    _exerciseStartedAt = DateTime.now();
  }

  /// FSRS derecelendirme ile cevap.
  void submitRating(Rating rating) {
    final isCorrect = rating != Rating.again;
    final xp = _calculateXP(rating);
    submitAnswer(isCorrect: isCorrect, xpEarned: xp, rating: rating);
  }

  int _calculateXP(Rating rating) {
    var xp = 0;
    if (rating != Rating.again) {
      xp += 10;
      if (rating == Rating.easy) xp += 5;
    }
    return xp;
  }

  /// Oturumu sıfırla (tekrar çöz).
  void reset() {
    _exerciseStartedAt = DateTime.now();
    state = LessonSessionState(
      lesson: state.lesson,
      startedAt: DateTime.now(),
    );
  }
}

/// Ders oturumu provider'ı — her ders için yeni bir instance.
final lessonSessionProvider = StateNotifierProvider.autoDispose
    .family<LessonSessionNotifier, LessonSessionState, Lesson>(
  (ref, lesson) => LessonSessionNotifier(lesson),
);
