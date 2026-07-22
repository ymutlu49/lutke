// ════════════════════════════════════════════════════════════════
// LÛTKE — EnWord → LearningRecord adaptör testi
//
// Kapsam:
//   1. Alan eşlemesi doğruluğu (ku ← en, tr ← ku, en ← en, her ← her,
//      gen ← herKu, not ← notKu).
//   2. Cinsiyet alanı non-null (String) — downstream `as String` cast
//      güvenli çalışsın (flashcard_screen.dart:1668 kontrol edildi).
//   3. Seviye switch'i tüm seviyeleri döndürür, bilinmeyen seviye
//      defensively A1'e düşer.
//   4. childOnly parametresi A1/A2'ye clamp eder.
//   5. Cache idempotent — aynı seviye çağrısı aynı liste referansı döner.
//   6. Record listesi growable:false — yanlışlıkla mutate edilemez.
//
// Çalıştır:
//   flutter test test/en_to_quiz_adapter_test.dart
// ════════════════════════════════════════════════════════════════

import 'package:flutter_test/flutter_test.dart';

import 'package:lutke/features/en_learning/domain/en_a1_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_b1_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_child_a1_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_to_quiz_adapter.dart';

void main() {
  setUp(() {
    // Her testte taze cache — deterministik.
    debugClearEnAdapterCache();
  });

  group('Alan eşlemesi (EnWord → LearningRecord)', () {
    test('ku ← en (hedef dil İngilizce)', () {
      final records = getEnWordsForLevel('A1');
      expect(records, isNotEmpty);
      final source = kEnA1Liste.first;
      final adapted = records.first;
      expect(adapted.ku, source.en,
          reason: 'record.ku İngilizce hedef kelime olmalı',);
      expect(adapted.tr, source.ku,
          reason: 'record.tr Kurmancî çeviri olmalı',);
      expect(adapted.en, source.en,
          reason: 'record.en İngilizce yedek — en == ku bilinçli',);
    });

    test('her ve gen paralel — her = EN örnek, gen = KU çeviri', () {
      final records = getEnWordsForLevel('A1');
      final source = kEnA1Liste.first;
      final adapted = records.first;
      expect(adapted.her, source.her);
      expect(adapted.gen, source.herKu);
      expect(adapted.her!.length, adapted.gen!.length,
          reason: 'her ve gen her zaman aynı uzunlukta olmalı',);
    });

    test('not ← notKu, zor ve kat değişmeden geçer', () {
      final records = getEnWordsForLevel('B1');
      final source = kEnB1Liste.first;
      final adapted = records.first;
      expect(adapted.not, source.notKu);
      expect(adapted.zor, source.zor);
      expect(adapted.kat, source.kat);
    });

    test('cins non-null boş string — downstream cast güvenli', () {
      // flashcard_screen.dart:1668 `record.cins as String` — null atar TypeError.
      // Adaptör her zaman '' set etmeli, null DEĞİL.
      final records = getEnWordsForLevel('A1');
      for (final r in records) {
        expect(r.cins, isNotNull,
            reason: 'EN record.cins null olamaz (downstream cast kırılır)',);
        expect(r.cins, '',
            reason: 'İngilizce\'de cinsiyet yok; convention \'\' (empty)',);
        expect(r.ez, isNull,
            reason: 'İngilizce\'de ezafe yok; null doğru',);
      }
    });
  });

  group('Seviye dispatch', () {
    test('Tüm seviyeler dolu liste döner', () {
      for (final lvl in [
        'A1', 'A2', 'B1', 'B2', 'C1', 'C2', 'CHILD_A1', 'CHILD_A2',
      ]) {
        final records = getEnWordsForLevel(lvl);
        expect(records, isNotEmpty, reason: '$lvl boş liste döndü');
      }
    });

    test('Büyük-küçük harf duyarsız', () {
      final upper = getEnWordsForLevel('A1');
      final lower = getEnWordsForLevel('a1');
      final mixed = getEnWordsForLevel('A1');
      expect(upper.length, lower.length);
      expect(upper.length, mixed.length);
    });

    test('Bilinmeyen seviye A1\'e düşer (defensive)', () {
      final fallback = getEnWordsForLevel('Z99');
      final a1 = getEnWordsForLevel('A1');
      expect(fallback.length, a1.length);
      expect(fallback.first.id, a1.first.id);
    });

    test('childOnly=true A1/A2 dışındaki seviyeleri CHILD_A1\'e clamp eder',
        () {
      final b1Child = getEnWordsForLevel('B1', childOnly: true);
      final a1Child = getEnWordsForLevel('A1', childOnly: true);
      expect(b1Child.length, a1Child.length,
          reason: 'B1 child yok — A1 child\'a düşmeli',);
      // A1 child kelimelerinin "en_child_a1_" prefix'i olmalı.
      expect(b1Child.first.id, startsWith('en_child_a1_'));
    });

    test('childOnly=true + A2 → CHILD_A2', () {
      final a2Child = getEnWordsForLevel('A2', childOnly: true);
      expect(a2Child, isNotEmpty);
      expect(a2Child.first.id, startsWith('en_child_a2_'));
    });

    test('kEnChildA1AsRecords getter kEnChildA1Liste\'yi yansıtır', () {
      expect(kEnChildA1AsRecords.length, kEnChildA1Liste.length);
      expect(kEnChildA1AsRecords.first.ku, kEnChildA1Liste.first.en);
    });
  });

  group('Cache davranışı', () {
    test('Aynı seviye çağrısı aynı liste referansı döner (memoization)', () {
      final a = getEnWordsForLevel('B1');
      final b = getEnWordsForLevel('B1');
      expect(identical(a, b), isTrue,
          reason:
              'Cache miss başına yeniden oluşturulmamalı — perf regresyonu',);
    });

    test('growable:false — downstream yanlışlıkla mutate edemez', () {
      final records = getEnWordsForLevel('A1');
      expect(() => records.add(records.first),
          throwsA(isA<UnsupportedError>()),
          reason: 'Cache\'lenmiş listeye add edilememeli',);
    });

    test('debugClearEnAdapterCache listeyi yeniden oluşturur', () {
      final first = getEnWordsForLevel('A1');
      debugClearEnAdapterCache();
      final second = getEnWordsForLevel('A1');
      expect(identical(first, second), isFalse,
          reason: 'Cache temizlendi — yeni liste üretilmeli',);
      expect(first.length, second.length); // ama içerik aynı
    });
  });

  group('Veri bütünlüğü (post-adapt)', () {
    test('Hiçbir record.ku (target) boş değil', () {
      for (final lvl in ['A1', 'A2', 'B1', 'CHILD_A1']) {
        final records = getEnWordsForLevel(lvl);
        final empties = records.where((r) => r.ku.isEmpty).toList();
        expect(empties, isEmpty,
            reason: '$lvl: ${empties.length} record\'da ku (hedef) boş',);
      }
    });

    test('Hiçbir record.tr (mother tongue) boş değil', () {
      for (final lvl in ['A1', 'B1']) {
        final records = getEnWordsForLevel(lvl);
        final empties = records.where((r) => r.tr.isEmpty).toList();
        expect(empties, isEmpty,
            reason: '$lvl: ${empties.length} record\'da tr (KU) boş',);
      }
    });

    test('id benzersiz (adaptör duplicate üretmez)', () {
      final records = getEnWordsForLevel('A1');
      final ids = records.map((r) => r.id).toSet();
      expect(ids.length, records.length,
          reason: 'Adaptör duplicate id üretmemeli',);
    });
  });
}
