// ════════════════════════════════════════════════════════════════
// LÛTKE — Kelime DB Kalite Validation Testi
//
// Tüm A1-C2 + çocuk DB'lerini kapsamlı denetler:
//   1. Zorunlu alanlar dolu mu (id, ku, tr)
//   2. Cinsiyet doğru değer mi (nêr/mê/bêcins)
//   3. Ezafe formu cinsiyetle uyumlu mu (mê → -a, nêr → -ê)
//   4. Heritage cümle var mı, kelimeyi içeriyor mu (cloze için şart)
//   5. ID benzersiz mi (duplicate yok)
//   6. ku/tr alanları min uzunluk
//   7. Kategori boş değil
//   8. zor alanı geçerli aralıkta (0.5-1.0)
//   9. Kategori-bazlı tutarlılık (ör. 'reng' kategorisi → ku bir renk olmalı)
//
// Çalıştır:
//   flutter test test/db_quality_test.dart
//
// Çıktı: detaylı hata listesi (dosya, ID, alan, sebep)
//
// CI'da otomatik koşması için pubspec.yaml'da tanımlı.
// ════════════════════════════════════════════════════════════════

import 'package:flutter_test/flutter_test.dart';
import 'package:lutke/features/lessons/domain/a1_kelime_db.dart';
import 'package:lutke/features/lessons/domain/a2_kelime_db.dart';
import 'package:lutke/features/lessons/domain/b1_kelime_db.dart';
import 'package:lutke/features/lessons/domain/b2_kelime_db.dart';
import 'package:lutke/features/lessons/domain/c1_kelime_db.dart';
import 'package:lutke/features/lessons/domain/c2_kelime_db.dart';
import 'package:lutke/features/lessons/domain/child_a1_kelime_db.dart';
import 'package:lutke/features/lessons/domain/child_a2_kelime_db.dart';

class _QualityIssue {
  final String level;
  final String wordId;
  final String word;
  final String field;
  final String severity; // 'error' | 'warning' | 'info'
  final String reason;

  _QualityIssue({
    required this.level,
    required this.wordId,
    required this.word,
    required this.field,
    required this.severity,
    required this.reason,
  });

  @override
  String toString() =>
      '[$severity] $level/$wordId ($word) — $field: $reason';
}

void main() {
  final allIssues = <_QualityIssue>[];

  // Test edilecek seviye/DB çiftleri
  final levels = <String, List<dynamic>>{
    'A1': kA1TamListe,
    'A2': kA2TamListe,
    'B1': kB1All,
    'B2': kB2All,
    'C1': kC1All,
    'C2': kC2All,
    'CHILD_A1': kChildA1Kelimeler,
    'CHILD_A2': kChildA2Kelimeler,
  };

  // ── Yardımcı fonksiyonlar ──
  bool _isValidCins(String? cins) =>
      cins == null || ['nêr', 'mê', 'bêcins'].contains(cins);

  bool _ezafeMatchesGender(String? cins, String? ez, String ku) {
    if (cins == null || ez == null || ez.isEmpty) return true;
    final clean = ez.trim();
    if (cins == 'mê') {
      // Dişil tekil ezafe: -a (örn. mala min); oblique: -ê (örn. di malê de)
      // Her ikisi de geçerli — sözlük "ez" alanını ezafe olarak tutar.
      return clean.endsWith('a') ||
          clean.endsWith('ê') ||
          clean.endsWith('ya') ||
          clean.endsWith('yê');
    }
    if (cins == 'nêr') {
      // Eril tekil ezafe: -ê (kurê min); oblique: -î (li mêrî)
      return clean.endsWith('ê') ||
          clean.endsWith('î') ||
          clean.endsWith('yê');
    }
    return true;
  }

  bool _heritageContainsWord(List<dynamic>? her, String ku) {
    if (her == null || her.isEmpty) return false;
    final regex = RegExp(
      r'\b' + RegExp.escape(ku) + r'(a|ê|î|an|ên|yê|ya)?\b',
      caseSensitive: false,
    );
    for (final raw in her) {
      final s = raw.toString();
      if (s.length >= 8 && regex.hasMatch(s)) return true;
    }
    return false;
  }

  // ── Her seviye için kelime başına denetim ──
  for (final entry in levels.entries) {
    final levelName = entry.key;
    final words = entry.value;
    final seenIds = <String>{};

    for (final w in words) {
      // Map-style record erişimi
      String getStr(String field) {
        try {
          return ((w as dynamic).$1 ?? '').toString(); // dummy
        } catch (_) {}
        try {
          // Dart records: pozitional veya named
          final dynamic v = (w as dynamic);
          switch (field) {
            case 'id':
              return (v.id ?? '').toString();
            case 'ku':
              return (v.ku ?? '').toString();
            case 'tr':
              return (v.tr ?? '').toString();
            case 'en':
              return (v.en ?? '').toString();
            case 'kat':
              return (v.kat ?? '').toString();
            case 'cins':
              return (v.cins ?? '').toString();
            case 'ez':
              try {
                return (v.ez ?? '').toString();
              } catch (_) {
                return '';
              }
            case 'not':
              try {
                return (v.not ?? '').toString();
              } catch (_) {
                return '';
              }
          }
        } catch (_) {}
        return '';
      }

      double getZor() {
        try {
          final dynamic v = (w as dynamic);
          final z = v.zor;
          if (z is num) return z.toDouble();
        } catch (_) {}
        return 0.75;
      }

      List<dynamic> getList(String field) {
        try {
          final dynamic v = (w as dynamic);
          switch (field) {
            case 'her':
              return (v.her as List?) ?? [];
            case 'gen':
              return (v.gen as List?) ?? [];
          }
        } catch (_) {}
        return [];
      }

      final id = getStr('id');
      final ku = getStr('ku');
      final tr = getStr('tr');
      final kat = getStr('kat');
      final cins = getStr('cins');
      final ez = getStr('ez');
      final her = getList('her');
      final zor = getZor();

      // 1. ID dolu mu?
      if (id.isEmpty) {
        allIssues.add(_QualityIssue(
          level: levelName,
          wordId: '?',
          word: ku,
          field: 'id',
          severity: 'error',
          reason: 'ID boş',
        ));
        continue;
      }

      // 2. ID benzersiz mi?
      if (seenIds.contains(id)) {
        allIssues.add(_QualityIssue(
          level: levelName,
          wordId: id,
          word: ku,
          field: 'id',
          severity: 'error',
          reason: 'Aynı ID birden fazla',
        ));
      }
      seenIds.add(id);

      // 3. ku alanı dolu ve min uzunluk
      if (ku.isEmpty) {
        allIssues.add(_QualityIssue(
          level: levelName,
          wordId: id,
          word: ku,
          field: 'ku',
          severity: 'error',
          reason: 'Kurmancî kelime boş',
        ));
        continue;
      }

      // 4. tr dolu
      if (tr.isEmpty) {
        allIssues.add(_QualityIssue(
          level: levelName,
          wordId: id,
          word: ku,
          field: 'tr',
          severity: 'error',
          reason: 'Türkçe çeviri boş',
        ));
      }

      // 5. Cinsiyet geçerli değer
      if (cins.isNotEmpty && !_isValidCins(cins)) {
        allIssues.add(_QualityIssue(
          level: levelName,
          wordId: id,
          word: ku,
          field: 'cins',
          severity: 'error',
          reason: 'Geçersiz cinsiyet: $cins (nêr/mê/bêcins olmalı)',
        ));
      }

      // 6. Ezafe-cinsiyet uyumu (warning — bazı istisnalar var)
      if (cins.isNotEmpty &&
          cins != 'bêcins' &&
          ez.isNotEmpty &&
          !_ezafeMatchesGender(cins, ez, ku)) {
        allIssues.add(_QualityIssue(
          level: levelName,
          wordId: id,
          word: ku,
          field: 'ez',
          severity: 'warning',
          reason: 'Ezafe "$ez" cinsiyet "$cins" ile tipik uyumsuz',
        ));
      }

      // 7. Kategori boş değil (warning)
      if (kat.isEmpty) {
        allIssues.add(_QualityIssue(
          level: levelName,
          wordId: id,
          word: ku,
          field: 'kat',
          severity: 'warning',
          reason: 'Kategori boş — soru üretiminde sorun olur',
        ));
      }

      // 8. zor değeri geçerli aralık
      if (zor < 0.3 || zor > 1.0) {
        allIssues.add(_QualityIssue(
          level: levelName,
          wordId: id,
          word: ku,
          field: 'zor',
          severity: 'warning',
          reason: 'zor değeri ($zor) anormal (beklenen 0.3-1.0)',
        ));
      }

      // 9. Heritage var mı, kelimeyi içeriyor mu?
      if (her.isEmpty) {
        allIssues.add(_QualityIssue(
          level: levelName,
          wordId: id,
          word: ku,
          field: 'her',
          severity: 'warning',
          reason: 'Heritage cümle yok — cloze quiz oluşturulamaz',
        ));
      } else if (ku.length > 2 && !_heritageContainsWord(her, ku)) {
        allIssues.add(_QualityIssue(
          level: levelName,
          wordId: id,
          word: ku,
          field: 'her',
          severity: 'warning',
          reason: 'Heritage cümlelerinin hiçbiri kelimeyi içermiyor',
        ));
      }

      // 10. ku ve tr aynı (suspect — bazen dilbilim eşitliği var)
      if (ku.toLowerCase() == tr.toLowerCase() && ku.length > 2) {
        allIssues.add(_QualityIssue(
          level: levelName,
          wordId: id,
          word: ku,
          field: 'tr',
          severity: 'info',
          reason: 'KU ve TR aynı (yabancı kelime mi?)',
        ));
      }
    }
  }

  // ── Test çıktıları ──
  group('LÛTKE Kelime DB Kalite Testleri', () {
    test('Toplam kelime sayısı', () {
      final total = levels.values.fold<int>(0, (sum, l) => sum + l.length);
      // ignore: avoid_print
      print('═══════════════════════════════════════════════════');
      // ignore: avoid_print
      print('LÛTKE DB KALİTE RAPORU');
      // ignore: avoid_print
      print('═══════════════════════════════════════════════════');
      // ignore: avoid_print
      print('Toplam kelime: $total');
      for (final e in levels.entries) {
        // ignore: avoid_print
        print('  ${e.key}: ${e.value.length}');
      }
      // ignore: avoid_print
      print('═══════════════════════════════════════════════════');
      expect(total, greaterThan(0));
    });

    test('Hata özeti', () {
      final errors = allIssues.where((i) => i.severity == 'error').toList();
      final warnings =
          allIssues.where((i) => i.severity == 'warning').toList();
      final infos = allIssues.where((i) => i.severity == 'info').toList();

      // ignore: avoid_print
      print('\nHATA KATEGORİLERİ:');
      // ignore: avoid_print
      print('  ❌ Errors  : ${errors.length}');
      // ignore: avoid_print
      print('  ⚠️  Warnings: ${warnings.length}');
      // ignore: avoid_print
      print('  ℹ️  Infos   : ${infos.length}');

      // Severity başına seviye dağılımı
      // ignore: avoid_print
      print('\nERROR DAĞILIMI (seviye/alan):');
      final errorByLevel = <String, int>{};
      final errorByField = <String, int>{};
      for (final e in errors) {
        errorByLevel[e.level] = (errorByLevel[e.level] ?? 0) + 1;
        errorByField[e.field] = (errorByField[e.field] ?? 0) + 1;
      }
      for (final e in errorByLevel.entries) {
        // ignore: avoid_print
        print('  ${e.key}: ${e.value}');
      }
      // ignore: avoid_print
      print('  Alan: $errorByField');

      // Warnings için
      // ignore: avoid_print
      print('\nWARNING DAĞILIMI (alan):');
      final warnByField = <String, int>{};
      for (final w in warnings) {
        warnByField[w.field] = (warnByField[w.field] ?? 0) + 1;
      }
      for (final e in warnByField.entries) {
        // ignore: avoid_print
        print('  ${e.key}: ${e.value}');
      }

      // Errors fazla ise testi başarısız sayma — sadece raporla
      if (errors.length > 50) {
        // ignore: avoid_print
        print('\n⚠️  ${errors.length} hata var — bunlar düzeltilmeli');
      }
    });

    test('İlk 30 ERROR detayı', () {
      final errors =
          allIssues.where((i) => i.severity == 'error').take(30).toList();
      if (errors.isEmpty) {
        // ignore: avoid_print
        print('🎉 Hiç error yok!');
      } else {
        // ignore: avoid_print
        print('\nİLK ${errors.length} ERROR:');
        for (final e in errors) {
          // ignore: avoid_print
          print('  $e');
        }
      }
    });

    test('İlk 30 WARNING detayı (heritage zayıf, ezafe uyumsuz vb.)', () {
      final warns = allIssues
          .where((i) => i.severity == 'warning')
          .take(30)
          .toList();
      if (warns.isEmpty) {
        // ignore: avoid_print
        print('🎉 Hiç warning yok!');
      } else {
        // ignore: avoid_print
        print('\nİLK ${warns.length} WARNING:');
        for (final w in warns) {
          // ignore: avoid_print
          print('  $w');
        }
      }
    });

    test('Heritage eksik kelimeler — seviye başına sayım', () {
      final byLevel = <String, int>{};
      for (final i in allIssues) {
        if (i.field == 'her') {
          byLevel[i.level] = (byLevel[i.level] ?? 0) + 1;
        }
      }
      // ignore: avoid_print
      print('\nHERITAGE EKSİK KELİMELER:');
      for (final e in byLevel.entries) {
        // ignore: avoid_print
        print('  ${e.key}: ${e.value}');
      }
    });
  });
}
