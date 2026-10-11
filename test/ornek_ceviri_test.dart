// Cümle havuzu (iyileştirme planı Faz 3): örnek cümlelerin Türkçe çevirisi.
//
// Çeviri cümlenin kendisiyle eşleşir (hazır ses gibi). Bu yüzden iki şey
// sınanır:
//   1. veri — çevirisi olan her cümle gerçekten bir kelimenin örneğidir
//      (havuz uygulanmış, içerikle çeviri dosyası birbirinden kopmamış)
//   2. ekran — kelime ayrıntısında çeviri cümlenin altında görünür

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lutke/core/constants/app_theme.dart';
import 'package:lutke/features/lessons/presentation/word_detail_screen.dart';
import 'package:lutke/shared/providers/language_mode_provider.dart';

import 'package:lutke/features/lessons/domain/a2_kelime_db.dart';
import 'package:lutke/features/lessons/domain/lesson_catalog.dart';
import 'package:lutke/features/lessons/domain/ornek_ceviri_db.dart';

void main() {
  group('örnek çevirileri', () {
    test('boş değil; çeviriler dolu ve cümleden farklı', () {
      expect(kOrnekTr, isNotEmpty);
      for (final e in kOrnekTr.entries) {
        expect(e.key.trim(), isNotEmpty);
        expect(e.value.trim(), isNotEmpty, reason: e.key);
        expect(e.value, isNot(e.key));
      }
    });

    test('çevirisi olan her cümle bir kelimenin örneğidir', () {
      // Havuz bütün düzeylerden cümle taşıyabilir.
      final ornekler = <String>{
        for (final d in kLessonLevels)
          for (final w in wordsForLevel(d)) ...(w.her as List).cast<String>(),
      };
      final kopuk = kOrnekTr.keys.where((c) => !ornekler.contains(c)).toList();
      expect(kopuk, isEmpty,
          reason: 'içerikte bulunmayan cümlelerin çevirisi var: '
              'cumle.py --uygula sonrası duzelt.py çalıştırılmamış olabilir');
    });

    test('ornekCevirisi: havuzdaki cümle çevirisini verir, olmayan null', () {
      final ilk = kOrnekTr.entries.first;
      expect(ornekCevirisi(ilk.key), ilk.value);
      expect(ornekCevirisi('  ${ilk.key}  '), ilk.value);
      expect(ornekCevirisi('Ev hevok di hewzê de tune ye.'), isNull);
    });
  });

  group('kelime ayrıntısı', () {
    // Havuzdan cümlesi olan bir kelime: a2_211 Tarî.
    final kelime = kA2TamListe.firstWhere((w) => (w as dynamic).id == 'a2_211');
    final cumle = ((kelime as dynamic).her as List).cast<String>()[1];

    Future<void> ac(WidgetTester tester, {required bool turkce}) async {
      SharedPreferences.setMockInitialValues({});
      tester.view.physicalSize = const Size(480, 4000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(ProviderScope(
        overrides: [showTurkishProvider.overrideWith((ref) => turkce)],
        child: MaterialApp(
          theme: AppTheme.light,
          home: WordDetailScreen(word: kelime, levelColor: Colors.teal),
        ),
      ));
      await tester.pump(const Duration(seconds: 1));
    }

    testWidgets('çeviri cümlenin altında görünür', (tester) async {
      await ac(tester, turkce: true);
      expect(ornekCevirisi(cumle), isNotNull);
      expect(find.textContaining(cumle), findsWidgets);
      expect(find.text(ornekCevirisi(cumle)!), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));
    });

    testWidgets('Türkçe kapalıyken çeviri gösterilmez', (tester) async {
      await ac(tester, turkce: false);
      expect(find.textContaining(cumle), findsWidgets);
      expect(find.text(ornekCevirisi(cumle)!), findsNothing);
      await tester.pump(const Duration(seconds: 3));
    });
  });
}
