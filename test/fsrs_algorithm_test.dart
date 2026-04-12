import 'package:flutter_test/flutter_test.dart';
import 'package:lutke/core/utils/fsrs_algorithm.dart';

void main() {
  group('LutkeScheduler — FSRS-5 Testi', () {

    // ── Kart Oluşturma ──────────────────────────────────────────
    group('createCard', () {
      test('Heritage kullanıcı için selamlama kartı doğru başlangıç zorluğuna sahip', () {
        final card = LutkeScheduler.createCard(
          cardId: 'silav_001',
          category: KurmanjiCategory.greeting,
          isHeritageUser: true,
        );
        expect(card.cardId, 'silav_001');
        expect(card.state, CardState.newCard);
        // Heritage bonus uygulandı mı?
        final nonHeritageDifficulty = LutkeScheduler.createCard(
          cardId: 'silav_001',
          category: KurmanjiCategory.greeting,
          isHeritageUser: false,
        ).difficulty;
        // Heritage kullanıcı daha düşük zorluk almalı (daha az yoğun tekrar)
        expect(card.difficulty, lessThan(nonHeritageDifficulty));
      });

      test('Ergatif kart selamlama kartından daha zor', () {
        final greetingCard = LutkeScheduler.createCard(
          cardId: 'silav_001',
          category: KurmanjiCategory.greeting,
        );
        final ergativeCard = LutkeScheduler.createCard(
          cardId: 'ergative_001',
          category: KurmanjiCategory.grammar_ergative,
        );
        expect(ergativeCard.difficulty, greaterThan(greetingCard.difficulty));
      });

      test('Tüm kategoriler geçerli zorluk aralığında (1.0–10.0)', () {
        for (final category in KurmanjiCategory.values) {
          final card = LutkeScheduler.createCard(
            cardId: 'test_$category',
            category: category,
          );
          expect(card.difficulty, greaterThanOrEqualTo(1.0));
          expect(card.difficulty, lessThanOrEqualTo(10.0));
        }
      });
    });

    // ── Zamanlama ───────────────────────────────────────────────
    group('schedule — Yeni kart', () {
      test('Again: kart 1 dakika sonraya zamanlanır, learning state', () {
        final card = LutkeScheduler.createCard(
          cardId: 'test_001',
          category: KurmanjiCategory.general,
        );
        final scheduled = LutkeScheduler.schedule(
          card: card,
          rating: Rating.again,
        );
        expect(scheduled.state, CardState.learning);
        expect(scheduled.dueDate, isNotNull);
        expect(
          scheduled.dueDate!.difference(DateTime.now()).inMinutes,
          closeTo(1, 1),
        );
        expect(scheduled.reviewCount, 1);
      });

      test('Good: kart en az 1 gün sonraya zamanlanır, review state', () {
        final card = LutkeScheduler.createCard(
          cardId: 'test_001',
          category: KurmanjiCategory.family,
        );
        final scheduled = LutkeScheduler.schedule(
          card: card,
          rating: Rating.good,
        );
        expect(scheduled.state, CardState.review);
        expect(
          scheduled.dueDate!.difference(DateTime.now()).inDays,
          greaterThanOrEqualTo(1),
        );
      });

      test('Easy: kart Good\'dan daha uzun aralıkla zamanlanır', () {
        final card = LutkeScheduler.createCard(
          cardId: 'test_001',
          category: KurmanjiCategory.greeting,
        );
        final scheduledGood = LutkeScheduler.schedule(
          card: card,
          rating: Rating.good,
        );
        final scheduledEasy = LutkeScheduler.schedule(
          card: card,
          rating: Rating.easy,
        );
        expect(
          scheduledEasy.dueDate!.millisecondsSinceEpoch,
          greaterThanOrEqualTo(scheduledGood.dueDate!.millisecondsSinceEpoch),
        );
      });
    });

    group('schedule — Review kartı', () {
      test('Again: lapse sayısı artar, relearning state', () {
        final newCard = LutkeScheduler.createCard(
          cardId: 'test_001',
          category: KurmanjiCategory.general,
        );
        // Önce Good ile review state'e al
        final reviewCard = LutkeScheduler.schedule(
          card: newCard,
          rating: Rating.good,
        );
        // Şimdi again
        final lapsedCard = LutkeScheduler.schedule(
          card: reviewCard,
          rating: Rating.again,
        );
        expect(lapsedCard.state, CardState.relearning);
        expect(lapsedCard.lapseCount, greaterThan(0));
      });
    });

    // ── Retrievability ──────────────────────────────────────────
    group('currentRetrievability', () {
      test('Yeni kart için 0 döner', () {
        final card = LutkeScheduler.createCard(
          cardId: 'test_001',
          category: KurmanjiCategory.general,
        );
        expect(LutkeScheduler.currentRetrievability(card), 0.0);
      });

      test('Review sonrası 1.0\'a yakın başlar ve azalır', () {
        final card = LutkeScheduler.createCard(
          cardId: 'test_001',
          category: KurmanjiCategory.general,
        );
        final scheduled = LutkeScheduler.schedule(
          card: card,
          rating: Rating.good,
        );
        final r = LutkeScheduler.currentRetrievability(scheduled);
        // Hemen sonra %90 civarında olmalı (FSRS hedefi)
        expect(r, greaterThan(0.85));
        expect(r, lessThanOrEqualTo(1.0));
      });
    });

    // ── Kurmancî Özel ───────────────────────────────────────────
    group('Kurmancî pedagoji', () {
      test('Minimal çift selamlama kartından daha zor', () {
        final minimalPair = LutkeScheduler.createCard(
          cardId: 'ker_keer',
          category: KurmanjiCategory.minimal_pair,
        );
        final greeting = LutkeScheduler.createCard(
          cardId: 'silav',
          category: KurmanjiCategory.greeting,
        );
        expect(minimalPair.difficulty, greaterThan(greeting.difficulty));
      });

      test('sortByUrgency: düşük retrievability önce gelir', () {
        final card1 = LutkeScheduler.createCard(
          cardId: 'card_1',
          category: KurmanjiCategory.general,
        );
        final card1Scheduled = LutkeScheduler.schedule(
          card: card1,
          rating: Rating.easy,
        );
        final card2 = LutkeScheduler.createCard(
          cardId: 'card_2',
          category: KurmanjiCategory.general,
        );
        final card2Scheduled = LutkeScheduler.schedule(
          card: card2,
          rating: Rating.again,
        );
        final sorted = LutkeScheduler.sortByUrgency(
            [card1Scheduled, card2Scheduled]);
        // 'Again' ile zamanlanan daha acil olmalı
        expect(sorted.first.cardId, 'card_2');
      });
    });
  });
}
