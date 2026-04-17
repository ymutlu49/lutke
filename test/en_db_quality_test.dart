// ════════════════════════════════════════════════════════════════
// LÛTKE — İngilizce Modülü Kalite Validation Testi
//
// Tüm A1-C2 + çocuk EN DB'lerini kapsamlı denetler:
//   1. Zorunlu alanlar dolu mu (id, en, ku, ipa, pos)
//   2. ID benzersiz mi
//   3. IPA formatı doğru mu (// ile çevrili)
//   4. Heritage cümlelerin sayısı ve kalitesi
//   5. herKu (Kurmancî çeviri) eşleşmiş mi
//   6. zor değeri 0-1 arası
//   7. Tekrar olmayan kelimeler
//
// Çalıştır:
//   flutter test test/en_db_quality_test.dart
// ════════════════════════════════════════════════════════════════

import 'package:flutter_test/flutter_test.dart';
import 'package:lutke/features/en_learning/domain/en_a1_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_a2_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_b1_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_b2_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_c1_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_c2_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_child_a1_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_child_a2_kelime_db.dart';

class _Issue {
  final String level;
  final String wid;
  final String severity;
  final String reason;
  _Issue(this.level, this.wid, this.severity, this.reason);
  @override
  String toString() => '[$severity] $level/$wid — $reason';
}

void main() {
  final issues = <_Issue>[];

  final levels = {
    'A1': kEnA1Liste,
    'A2': kEnA2Liste,
    'B1': kEnB1Liste,
    'B2': kEnB2Liste,
    'C1': kEnC1Liste,
    'C2': kEnC2Liste,
    'CHILD_A1': kEnChildA1Liste,
    'CHILD_A2': kEnChildA2Liste,
  };

  // ── Tüm seviyelerdeki tekrar kontrolü için global set ──
  final globalEnSet = <String, String>{}; // en → "level/id"

  for (final entry in levels.entries) {
    final lvl = entry.key;
    final words = entry.value;
    final seenIds = <String>{};
    final seenEn = <String>{};

    for (final w in words) {
      // 1. ID benzersiz seviyede
      if (seenIds.contains(w.id)) {
        issues.add(_Issue(lvl, w.id, 'error', 'Duplicate ID'));
      }
      seenIds.add(w.id);

      // 2. en alanı dolu
      if (w.en.isEmpty) {
        issues.add(_Issue(lvl, w.id, 'error', 'en boş'));
        continue;
      }

      // 3. ku (Kurmancî) dolu — KRİTİK (ana dil açıklama)
      if (w.ku.isEmpty) {
        issues.add(_Issue(lvl, w.id, 'error', 'ku (Kurmancî) boş'));
      }

      // 4. IPA formatı /...../
      if (w.ipa.isEmpty) {
        issues.add(_Issue(lvl, w.id, 'warning', 'IPA boş'));
      } else if (!w.ipa.startsWith('/') || !w.ipa.endsWith('/')) {
        issues.add(
            _Issue(lvl, w.id, 'warning', 'IPA format hatalı: ${w.ipa}'));
      }

      // 5. POS geçerli
      const validPos = [
        'noun', 'verb', 'adj', 'adv', 'pronoun', 'prep', 'conj',
        'interjection', 'num', 'phrasal verb', 'phrasal',
        'v', 'n', 'adjective', 'adverb', 'preposition', 'conjunction'
      ];
      if (!validPos.contains(w.pos)) {
        issues.add(_Issue(lvl, w.id, 'warning', 'POS bilinmiyor: ${w.pos}'));
      }

      // 6. zor 0-1
      if (w.zor < 0.0 || w.zor > 1.0) {
        issues.add(_Issue(lvl, w.id, 'warning', 'zor anormal: ${w.zor}'));
      }

      // 7. her ve herKu sayıları eşit
      if (w.her.length != w.herKu.length) {
        issues.add(_Issue(lvl, w.id, 'warning',
            'her ve herKu sayısı eşit değil: ${w.her.length} vs ${w.herKu.length}'));
      }

      // 8. Heritage cümleleri kelimeyi içermeli (case-insensitive)
      if (w.her.isNotEmpty) {
        final enLow = w.en.toLowerCase();
        final stem = enLow.replaceAll(RegExp(r'(s|ed|ing|er|est)$'), '');
        bool found = false;
        for (final s in w.her) {
          if (s.toLowerCase().contains(stem) ||
              s.toLowerCase().contains(enLow)) {
            found = true;
            break;
          }
        }
        if (!found && enLow.length > 2) {
          issues.add(_Issue(lvl, w.id, 'info',
              'Heritage cümleleri "${w.en}" içermiyor olabilir'));
        }
      } else {
        issues.add(_Issue(lvl, w.id, 'warning', 'her boş'));
      }

      // 9. Aynı seviyede tekrar EN
      if (seenEn.contains(w.en.toLowerCase())) {
        issues.add(
            _Issue(lvl, w.id, 'warning', 'Aynı seviyede tekrar EN: ${w.en}'));
      }
      seenEn.add(w.en.toLowerCase());

      // 10. Tüm seviyeler arası tekrar
      final globalKey = w.en.toLowerCase();
      if (globalEnSet.containsKey(globalKey) &&
          !lvl.startsWith('CHILD')) {
        // Çocuk modu yetişkin ile çakışabilir, OK
        final other = globalEnSet[globalKey];
        if (!other!.startsWith('CHILD')) {
          issues.add(_Issue(lvl, w.id, 'info',
              'Başka seviyede tekrar: $globalKey ($other)'));
        }
      }
      globalEnSet[globalKey] = '$lvl/${w.id}';
    }
  }

  group('LÛTKE EN DB Kalite', () {
    test('Toplam kelime', () {
      final total = levels.values.fold<int>(0, (s, l) => s + l.length);
      // ignore: avoid_print
      print('═══════════════════════════════════════');
      // ignore: avoid_print
      print('LÛTKE — İngilizce Modülü Kalite Raporu');
      // ignore: avoid_print
      print('═══════════════════════════════════════');
      // ignore: avoid_print
      print('Toplam: $total kelime');
      for (final e in levels.entries) {
        // ignore: avoid_print
        print('  ${e.key}: ${e.value.length}');
      }
      // ignore: avoid_print
      print('═══════════════════════════════════════');
      expect(total, greaterThan(0));
    });

    test('Hata özeti', () {
      final errors = issues.where((i) => i.severity == 'error').toList();
      final warnings = issues.where((i) => i.severity == 'warning').toList();
      final infos = issues.where((i) => i.severity == 'info').toList();

      // ignore: avoid_print
      print('\nKATEGORİLER:');
      // ignore: avoid_print
      print('  ❌ Errors  : ${errors.length}');
      // ignore: avoid_print
      print('  ⚠️  Warnings: ${warnings.length}');
      // ignore: avoid_print
      print('  ℹ️  Infos   : ${infos.length}');
    });

    test('İlk 30 ERROR', () {
      final errors = issues.where((i) => i.severity == 'error').take(30);
      if (errors.isEmpty) {
        // ignore: avoid_print
        print('🎉 Hiç error yok!');
      } else {
        for (final e in errors) {
          // ignore: avoid_print
          print('  $e');
        }
      }
    });

    test('İlk 20 WARNING', () {
      final warns = issues.where((i) => i.severity == 'warning').take(20);
      if (warns.isEmpty) {
        // ignore: avoid_print
        print('🎉 Hiç warning yok!');
      } else {
        for (final w in warns) {
          // ignore: avoid_print
          print('  $w');
        }
      }
    });
  });
}
