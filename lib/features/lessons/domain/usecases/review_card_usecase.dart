import '../../../../core/errors/failures.dart';
import '../../../../core/utils/fsrs_algorithm.dart';
import '../entities/vocabulary_card.dart';
import '../repositories/lesson_repository_interface.dart';

// ════════════════════════════════════════════════════════════════
// KART TEKRAR USE CASE — LÛTKE
//
// İş mantığı: Kullanıcı cevap verdi → FSRS güncelle → XP ekle
// Presentation katmanı bu detayları bilmez.
//
// İlke §3.2: FSRS-5 — %90 hatırlama oranı hedefi
// İlke §4.3: XP kuralları
// ════════════════════════════════════════════════════════════════

class ReviewCardUseCase {
  final ICardRepository _cardRepo;
  final IUserRepository _userRepo;

  const ReviewCardUseCase({
    required ICardRepository cardRepo,
    required IUserRepository userRepo,
  })  : _cardRepo = cardRepo,
        _userRepo = userRepo;

  /// Kullanıcı bir karta cevap verdiğinde çağrılır.
  ///
  /// 1. FSRS algoritmasını çalıştırır
  /// 2. Veritabanını günceller
  /// 3. XP hesaplar ve ekler
  Future<Result<ReviewResult>> call({
    required String userId,
    required VocabularyCard card,
    required Rating rating,
    required Duration responseTime,
  }) async {
    // 1. FSRS güncelle
    final updateResult = await _cardRepo.updateAfterReview(
      userId, card.id, rating,
    );

    if (updateResult.isFailure) {
      return Err(updateResult.failureOrNull!);
    }

    // 2. XP hesapla (İlke §4.3)
    final xp = _calculateXP(rating, card, responseTime);

    // 3. XP ekle
    final xpResult = await _userRepo.updateXP(userId, xp);
    if (xpResult.isFailure) {
      return Err(xpResult.failureOrNull!);
    }

    return Success(ReviewResult(
      cardId: card.id,
      rating: rating,
      xpEarned: xp,
      isCorrect: rating != Rating.again,
      responseTime: responseTime,
    ));
  }

  int _calculateXP(Rating rating, VocabularyCard card, Duration responseTime) {
    var xp = 0;

    // Doğru cevap
    if (rating != Rating.again) {
      xp += 10;

      // Easy bonus
      if (rating == Rating.easy) xp += 5;

      // Hızlı cevap bonusu (< 5 saniye)
      if (responseTime.inSeconds < 5) xp += 3;
    }

    // İlk kez görülen kart bonusu
    if (card.isNew) xp += 8;

    return xp;
  }
}

class ReviewResult {
  final String cardId;
  final Rating rating;
  final int xpEarned;
  final bool isCorrect;
  final Duration responseTime;

  const ReviewResult({
    required this.cardId,
    required this.rating,
    required this.xpEarned,
    required this.isCorrect,
    required this.responseTime,
  });
}
