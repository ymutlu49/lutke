// Elle yazılmış dersler (wane) öğrencinin yoluna bağlandı
// (iyileştirme planı Faz 1.1). Üç katman sınanır:
//   1. katalog — 105 dersin tamamı erişilir, her biri bir birime bağlı
//   2. veri — her puanlı egzersizin doğru cevabı belirlenebilir
//   3. ekran — ders oynanır, sonuç kaydedilir, eşik uygulanır

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lutke/core/constants/app_theme.dart';
import 'package:lutke/features/lessons/domain/lesson_catalog.dart';
import 'package:lutke/features/lessons/domain/lesson_entities.dart';
import 'package:lutke/features/lessons/presentation/wane_screen.dart';
import 'package:lutke/shared/providers/activity_outcome.dart';
import 'package:lutke/shared/providers/lesson_progress_provider.dart';

void main() {
  final tumDersler = [
    for (final d in kLessonLevels) ...lessonsForLevel(d),
  ];

  group('katalog', () {
    test('105 ders, kimlikler benzersiz', () {
      expect(tumDersler.length, 105);
      expect(tumDersler.map((d) => d.id).toSet().length, 105);
    });

    test('her ders kimliğiyle bulunur', () {
      for (final d in tumDersler) {
        expect(lessonById(d.id), same(d));
      }
      expect(lessonById('yok_boyle_ders'), isNull);
    });

    test('her dersin bir birimi var ve birim listeleri dersleri tam kapsar', () {
      for (final duzey in kLessonLevels) {
        final dersler = lessonsForLevel(duzey);
        final birimlerden = <String>{};
        for (final d in dersler) {
          final kat = dominantCategory(d, duzey);
          expect(kat, isNotNull, reason: '${d.id} hiçbir birime bağlanmıyor');
          birimlerden
              .addAll(lessonsForUnit(duzey, kat!).map((x) => x.id));
        }
        expect(birimlerden, dersler.map((d) => d.id).toSet(),
            reason: '$duzey: birim listeleri dersleri tam kapsamıyor');
      }
    });
  });

  group('ders verisi', () {
    test('her puanlı egzersizin doğru cevabı belirlenebilir', () {
      final sorunlu = <String>[];
      for (final d in tumDersler) {
        for (final e in d.exercises.where(isScored)) {
          if (e.type == ExerciseType.dragAndDrop) {
            if ((e.wordPieces ?? e.options).length < 2) sorunlu.add(e.id);
            continue;
          }
          final i = e.correctIndex ?? e.options.indexOf(e.correctAnswer);
          if (i < 0 || i >= e.options.length) sorunlu.add(e.id);
        }
      }
      expect(sorunlu, isEmpty, reason: 'doğru cevabı belirsiz egzersizler');
    });

    test('her dersin en az bir puanlı egzersizi var', () {
      for (final d in tumDersler) {
        expect(d.exercises.where(isScored), isNotEmpty, reason: d.id);
      }
    });
  });

  group('WaneScreen', () {
    final ders = lessonById('a1_l04')!; // Tu çawa yî?

    Future<ProviderContainer> ac(WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      ActivityOutcome.clear();
      // Uygulamanın gerçek çerçevesi (480 genişlik) ve GERÇEK teması: tema
      // düğmelere tam genişlik verdiği için varsayılan temayla geçen bir
      // yerleşim uygulamada çökebiliyor.
      tester.view.physicalSize = const Size(480, 3200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light,
          home: WaneScreen(lessonId: ders.id),
        ),
      ));
      await tester.pump(const Duration(milliseconds: 400));
      return container;
    }

    /// Dersi baştan sona oynar; `dogru` false ise her seçmeli soruda yanlış
    /// seçeneğe dokunur.
    Future<void> oyna(WidgetTester tester, {required bool dogru}) async {
      for (final e in ders.exercises) {
        if (e.type == ExerciseType.speakingPractice) {
          await tester.tap(find.text('Min got'));
        } else {
          final i = e.correctIndex ?? e.options.indexOf(e.correctAnswer);
          final secilecek = dogru ? i : (i + 1) % e.options.length;
          await tester.tap(find.text(e.options[secilecek]).last);
        }
        await tester.pump(const Duration(milliseconds: 400));
        await tester.tap(find.text('Berdewam'));
        await tester.pump(const Duration(milliseconds: 400));
      }
      await tester.pump(const Duration(milliseconds: 400));
    }

    testWidgets('hepsi doğru: ders geçilir, puan kaydedilir', (tester) async {
      final c = await ac(tester);
      await oyna(tester, dogru: true);

      expect(find.text('Wane qediya!'), findsOneWidget);
      expect(c.read(lessonProgressProvider)[ders.id], 100);
      expect(lessonPassed(c.read(lessonProgressProvider), ders.id), isTrue);
      expect(ActivityOutcome.take()!.passed, isTrue);
    });

    testWidgets('hepsi yanlış: ders geçilmez, yeniden deneme önerilir',
        (tester) async {
      final c = await ac(tester);
      await oyna(tester, dogru: false);

      expect(find.text('Hema hema!'), findsOneWidget);
      expect(find.text('Dîsa biceribîne'), findsOneWidget);
      expect(lessonPassed(c.read(lessonProgressProvider), ders.id), isFalse);
      expect(ActivityOutcome.take()!.passed, isFalse);
    });

    testWidgets('cevaptan sonra dilbilgisi notu görünür', (tester) async {
      await ac(tester);
      final ilk = ders.exercises.first;
      expect(ilk.grammarNote, isNotNull);
      expect(find.text('Rêziman'), findsNothing);
      final i = ilk.correctIndex ?? ilk.options.indexOf(ilk.correctAnswer);
      await tester.tap(find.text(ilk.options[i]).last);
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.text('Rêziman'), findsOneWidget);
      expect(find.text(ilk.grammarNote!), findsOneWidget);
      // Bekleyen zamanlayıcılar (ses, animasyon) test bitmeden boşalsın.
      await tester.pump(const Duration(seconds: 3));
    });

    testWidgets('bilinmeyen ders kimliği yolu kilitlemez', (tester) async {
      SharedPreferences.setMockInitialValues({});
      ActivityOutcome.clear();
      await tester.pumpWidget(const ProviderScope(
        child: MaterialApp(home: WaneScreen(lessonId: 'yok_boyle_ders')),
      ));
      expect(find.text('Wane tune ye.'), findsOneWidget);
      expect(ActivityOutcome.take()!.passed, isTrue);
    });
  });
}
