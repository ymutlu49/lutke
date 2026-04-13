import '../../../../core/errors/failures.dart';
import '../entities/lesson.dart';
import '../repositories/lesson_repository_interface.dart';

// ════════════════════════════════════════════════════════════════
// DERS TAMAMLAMA USE CASE — LÛTKE
//
// İş mantığı: Oturum bitti → dersi tamamla → XP topla →
//             rozet kontrolü → kültürel ödül göster
//
// İlke §4: Gamification — destekleyici, ceza değil
// İlke §7.1: Her birim sonunda zorunlu kültürel içerik
// ════════════════════════════════════════════════════════════════

class CompleteLessonUseCase {
  final ILessonRepository _lessonRepo;
  final IUserRepository _userRepo;

  const CompleteLessonUseCase({
    required ILessonRepository lessonRepo,
    required IUserRepository userRepo,
  })  : _lessonRepo = lessonRepo,
        _userRepo = userRepo;

  Future<Result<LessonCompletionResult>> call({
    required String userId,
    required LessonSessionState session,
  }) async {
    if (!session.isCompleted) {
      return const Err(DatabaseFailure(message: 'Wane hêj temam nebûye'));
    }

    // 1. Dersi tamamlandı olarak işaretle
    final markResult = await _lessonRepo.markCompleted(
      userId, session.lesson.id,
    );
    if (markResult.isFailure) {
      return Err(markResult.failureOrNull!);
    }

    // 2. Toplam XP hesapla
    var totalXP = session.earnedXP;

    // Mükemmel ders bonusu (İlke §4.3: %100 doğruluk → +15 XP)
    final isPerfect = session.accuracy == 1.0;
    if (isPerfect) totalXP += 15;

    // Yüksek doğruluk bonusu (%90+ → +5 XP)
    if (session.accuracy >= 0.9 && !isPerfect) totalXP += 5;

    // 3. XP kaydet
    final xpResult = await _userRepo.updateXP(userId, totalXP);
    if (xpResult.isFailure) {
      return Err(xpResult.failureOrNull!);
    }

    // 4. Rozet kontrolü (kazanılabilecek rozetler)
    final earnedBadges = _checkBadges(session);

    return Success(LessonCompletionResult(
      lessonId: session.lesson.id,
      totalXP: totalXP,
      correctCount: session.correctCount,
      totalExercises: session.totalExercises,
      accuracy: session.accuracy,
      duration: session.elapsed,
      isPerfect: isPerfect,
      earnedBadgeIds: earnedBadges,
      culturalRewardId: session.lesson.culturalRewardId,
    ));
  }

  List<String> _checkBadges(LessonSessionState session) {
    final badges = <String>[];

    // Destpêker: İlk ders tamamlandı
    if (session.results.length <= session.totalExercises) {
      badges.add('destpeker');
    }

    // Mükemmel ders
    if (session.accuracy == 1.0) {
      badges.add('perfect_lesson');
    }

    return badges;
  }
}

/// Ders tamamlama sonucu — UI'da kutlama ekranı için veri.
class LessonCompletionResult {
  final String lessonId;
  final int totalXP;
  final int correctCount;
  final int totalExercises;
  final double accuracy;
  final Duration duration;
  final bool isPerfect;
  final List<String> earnedBadgeIds;
  final String? culturalRewardId;

  const LessonCompletionResult({
    required this.lessonId,
    required this.totalXP,
    required this.correctCount,
    required this.totalExercises,
    required this.accuracy,
    required this.duration,
    required this.isPerfect,
    this.earnedBadgeIds = const [],
    this.culturalRewardId,
  });

  bool get hasCulturalReward => culturalRewardId != null;
  bool get hasNewBadges => earnedBadgeIds.isNotEmpty;
}
