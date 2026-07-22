import 'package:flutter_test/flutter_test.dart';
import 'package:lutke/features/exercises/domain/listening_exercise_db.dart';

void main() {
  group('Listening Exercise DB — Yapı ve İçerik Testleri', () {

    test('kListeningAll hedef sayıya ulaşmış (>= 100)', () {
      expect(kListeningAll.length, greaterThanOrEqualTo(100));
    });

    test('Her seviye en az 10 exercise içeriyor', () {
      for (final level in ['A1', 'A2', 'B1', 'B2', 'C1', 'C2']) {
        final items = listeningForLevel(level);
        expect(items.length, greaterThanOrEqualTo(10),
            reason: 'Level $level en az 10 exercise olmalı');
      }
    });

    test('Tüm id\'ler benzersiz', () {
      final ids = kListeningAll.map((e) => e.id).toSet();
      expect(ids.length, kListeningAll.length,
          reason: 'Duplicate id tespit edildi');
    });

    test('correctIndex options aralığında', () {
      for (final ex in kListeningAll) {
        expect(ex.correctIndex, greaterThanOrEqualTo(0));
        expect(ex.correctIndex, lessThan(ex.options.length),
            reason: '${ex.id}: correctIndex options.length\'den büyük');
      }
    });

    test('Her exercise 4 option içeriyor', () {
      for (final ex in kListeningAll) {
        expect(ex.options.length, 4,
            reason: '${ex.id}: 4 seçenek zorunlu');
      }
    });

    test('audioText boş değil', () {
      for (final ex in kListeningAll) {
        expect(ex.audioText.trim().isNotEmpty, true,
            reason: '${ex.id}: audioText boş');
      }
    });

    test('question boş değil', () {
      for (final ex in kListeningAll) {
        expect(ex.question.trim().isNotEmpty, true,
            reason: '${ex.id}: question boş');
      }
    });

    test('Seviye etiketleri doğru', () {
      for (final ex in kListeningAll) {
        expect(['A1', 'A2', 'B1', 'B2', 'C1', 'C2'].contains(ex.level), true,
            reason: '${ex.id}: geçersiz level ${ex.level}');
      }
    });

    test('correctAnswer getter doğru çalışıyor', () {
      for (final ex in kListeningAll) {
        expect(ex.correctAnswer, ex.options[ex.correctIndex]);
      }
    });

    test('Kurmancî metinlerde Türkçe özel karakter yok', () {
      // audioText Kurmancî olmalı — Türkçe ö/ğ/ü/ı sızıntısı yok
      for (final ex in kListeningAll) {
        final text = ex.audioText;
        expect(text.contains('ö'), false, reason: '${ex.id}: Türkçe "ö"');
        expect(text.contains('ğ'), false, reason: '${ex.id}: Türkçe "ğ"');
        expect(text.contains('ı'), false, reason: '${ex.id}: Türkçe "ı"');
      }
    });
  });
}
