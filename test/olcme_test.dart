// Ölçme (iyileştirme planı Faz 6): yerleştirme kararı, düzey sınavı ve
// sertifikanın sınava bağlanması.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lutke/core/constants/app_theme.dart';
import 'package:lutke/features/certificate/certificate_screen.dart';
import 'package:lutke/features/lessons/domain/bicim_alistirma.dart';
import 'package:lutke/features/lessons/domain/lesson_catalog.dart';
import 'package:lutke/features/lessons/domain/olcme.dart';
import 'package:lutke/features/lessons/presentation/wane_list_screen.dart';
import 'package:lutke/features/onboarding/placement_test_screen.dart';
import 'package:lutke/shared/providers/lesson_progress_provider.dart';

/// Yerleştirme testinin soru dağılımı: 2×A1 + 2×A2 + 2×B1 + 2×B2 + 1×C1 + 1×C2.
const _dagilim = {'A1': 2, 'A2': 2, 'B1': 2, 'B2': 2, 'C1': 1, 'C2': 1};

void main() {
  tearDown(() => bicimTohumu = null);

  group('yerleştirme kararı', () {
    test('hiç doğru yoksa A1; hepsi doğruysa C2', () {
      expect(yerlestirmeDuzeyi({for (final e in _dagilim.entries) e.key: (0, e.value)}), 'A1');
      expect(yerlestirmeDuzeyi({for (final e in _dagilim.entries) e.key: (e.value, e.value)}), 'C2');
    });

    test('başlanacak düzey, aşağıdan yukarı bilinmeyen ilk bant', () {
      expect(yerlestirmeDuzeyi({'A1': (2, 2), 'A2': (1, 2), 'B1': (2, 2)}), 'A2');
      expect(yerlestirmeDuzeyi({'A1': (2, 2), 'A2': (2, 2), 'B1': (0, 2)}), 'B1');
      expect(yerlestirmeDuzeyi({'A1': (2, 2), 'A2': (2, 2), 'B1': (2, 2), 'B2': (2, 2), 'C1': (0, 1)}), 'C1');
    });

    test('üst bantta şans eseri doğrular düzeyi yükseltmez', () {
      // Eski kural: 3 doğru → A2.
      expect(yerlestirmeDuzeyi({'A1': (1, 2), 'A2': (0, 2), 'B1': (1, 2), 'C1': (1, 1)}), 'A1');
      expect(yerlestirmeDuzeyi({'A1': (0, 2), 'C1': (1, 1), 'C2': (1, 1)}), 'A1');
    });

    test('eşik dörtte üç: 4 soruda 3 yeter, 2 yetmez; sorusuz bant karar vermez', () {
      expect(yerlestirmeDuzeyi({'A1': (3, 4), 'A2': (0, 4)}), 'A2');
      expect(yerlestirmeDuzeyi({'A1': (2, 4), 'A2': (4, 4)}), 'A1');
      expect(yerlestirmeDuzeyi({'A1': (2, 2), 'A2': (0, 0), 'B1': (0, 2)}), 'B1');
    });

    test('rastgele işaretleyen öğrenci A1\'de kalır', () {
      final r = Random(42);
      var ustunde = 0, eskiKuralUstunde = 0;
      const deneme = 20000;
      for (var i = 0; i < deneme; i++) {
        final bantlar = <String, (int, int)>{};
        var toplamDogru = 0;
        for (final e in _dagilim.entries) {
          var d = 0;
          for (var k = 0; k < e.value; k++) {
            if (r.nextInt(4) == 0) d++;
          }
          toplamDogru += d;
          bantlar[e.key] = (d, e.value);
        }
        if (yerlestirmeDuzeyi(bantlar) != 'A1') ustunde++;
        if (toplamDogru >= 2) eskiKuralUstunde++; // eski: 2+ doğru → A2 ve üstü
      }
      // Yeni kural: A1 bandında 2/2 şansla tutmalı → 1/16 ≈ %6.
      expect(ustunde / deneme, lessThan(0.08));
      // Eski kuralda rastgele işaretleyenlerin dörtte üçü A2 ya da üstüne çıkıyordu.
      expect(eskiKuralUstunde / deneme, greaterThan(0.70));
    });

    test('ekranın kullandığı işlev aynı kararı verir', () {
      expect(
        computePlacementLevel({
          PlacementCefr.a1: (2, 2),
          PlacementCefr.a2: (2, 2),
          PlacementCefr.b1: (1, 2),
          PlacementCefr.c2: (1, 1),
        }),
        PlacementCefr.b1,
      );
      expect(computePlacementLevel({PlacementCefr.a1: (1, 2)}), PlacementCefr.a1);
    });
  });

  group('düzey sınavı', () {
    test('her düzeyde 20 soru; kimlikler benzersiz; cevaplar belirli', () {
      for (final d in kLessonLevels) {
        for (var tohum = 0; tohum < 3; tohum++) {
          final sinav = ezmunDersi(ezmunKimligi(d), rng: Random(tohum))!;
          expect(sinav.id, 'ezmun_${d.toLowerCase()}');
          expect(sinav.exercises.length, kEzmunSoruSayisi, reason: d);
          expect(sinav.exercises.map((e) => e.id).toSet().length, kEzmunSoruSayisi, reason: d);
          for (final e in sinav.exercises) {
            expect(isScored(e), isTrue, reason: e.id);
            expect(e.options.length, greaterThanOrEqualTo(2), reason: e.id);
            expect(e.options.toSet().length, e.options.length, reason: e.id);
            final i = e.correctIndex ?? e.options.indexOf(e.correctAnswer);
            expect(i, inInclusiveRange(0, e.options.length - 1), reason: e.id);
          }
        }
      }
    });

    test('bileşim: ders egzersizi en çok 10; kelime sorusunun cevabı kelimenin karşılığı', () {
      final sinav = ezmunDersi('ezmun_a2', rng: Random(1))!;
      final dersKimlikleri = {
        for (final l in lessonsForLevel('A2'))
          for (final e in l.exercises) e.id,
      };
      final derstenGelen = sinav.exercises.where((e) => dersKimlikleri.contains(e.id)).length;
      expect(derstenGelen, inInclusiveRange(1, 10));
      final kelimeler = {for (final w in wordsForLevel('A2')) w.id as String: w};
      final peyv = sinav.exercises.where((e) => e.id.startsWith('ezmun_peyv_')).toList();
      expect(peyv, isNotEmpty);
      for (final e in peyv) {
        final w = kelimeler[e.cardId]!;
        expect(e.correctAnswer, (w.tr as String).trim());
        expect(e.options.length, 4);
      }
      // A2'de biçim soruları da var (izafe + ergatif).
      expect(sinav.exercises.where((e) => e.id.startsWith(kBicimOneki)).length, 4);
    });

    test('katalogdan bulunur; tanınmayan kimlik null; aynı tohum aynı sınav', () {
      expect(lessonById('ezmun_b1'), isNotNull);
      expect(lessonById('ezmun_z9'), isNull);
      bicimTohumu = 9;
      final a = lessonById('ezmun_b1')!.exercises.map((e) => e.id).toList();
      final b = lessonById('ezmun_b1')!.exercises.map((e) => e.id).toList();
      expect(a, b);
    });
  });

  group('ekran', () {
    Future<ProviderContainer> ac(WidgetTester tester, Widget ekran) async {
      SharedPreferences.setMockInitialValues({});
      tester.view.physicalSize = const Size(480, 12000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: MaterialApp(theme: AppTheme.light, home: ekran),
      ));
      await tester.pump(const Duration(milliseconds: 500));
      return container;
    }

    testWidgets('ders listesinin sonunda düzey sınavı var', (tester) async {
      await ac(tester, const WaneListScreen(level: 'A1'));
      expect(find.text('Ezmûna astê · A1'), findsOneWidget);
    });

    testWidgets('sertifika sınav geçilmeden gösterilmez; geçilince açılır', (tester) async {
      final c = await ac(tester, const CertificateScreen(level: 'A1'));
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Dest bi ezmûnê bike'), findsOneWidget);
      expect(find.textContaining('ezmûna astê derbas bikî'), findsOneWidget);

      // %69 yetmez.
      await c.read(lessonProgressProvider.notifier).record(ezmunKimligi('A1'), 69);
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Dest bi ezmûnê bike'), findsOneWidget);

      await c.read(lessonProgressProvider.notifier).record(ezmunKimligi('A1'), 85);
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Dest bi ezmûnê bike'), findsNothing);
      await tester.pump(const Duration(seconds: 2));
    });
  });
}
