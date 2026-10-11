// Okuma metinleri ("Xwendin") — iyileştirme planı Faz 5.
//
//   1. katalog — yazılmış ama açılmayan yedi metin erişilir; soruların
//      doğru cevabı belirli
//   2. ekran — metin okunur, çeviri istenince açılır, sorular ders ekranında
//      oynanır ve sonuç metnin kimliğiyle kaydedilir

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lutke/core/constants/app_theme.dart';
import 'package:lutke/core/router/app_router.dart';
import 'package:lutke/features/lessons/domain/gotar_baglanti_db.dart';
import 'package:lutke/features/lessons/domain/lesson_catalog.dart';
import 'package:lutke/features/lessons/domain/xwendin_catalog.dart';
import 'package:lutke/features/lessons/presentation/wane_screen.dart';
import 'package:lutke/features/lessons/presentation/xwendin_screen.dart';
import 'package:lutke/shared/providers/activity_outcome.dart';
import 'package:lutke/shared/providers/lesson_progress_provider.dart';

void main() {
  group('katalog', () {
    test('yedi metin; kimlikler benzersiz; her düzeyde en az bir metin', () {
      expect(kXwendinMetinleri.length, 7);
      expect(kXwendinMetinleri.map((m) => m.id).toSet().length, 7);
      for (final d in kLessonLevels) {
        expect(xwendinForLevel(d), isNotEmpty, reason: d);
      }
    });

    test('her satırın Kurmancîsi ve Türkçesi dolu', () {
      for (final m in kXwendinMetinleri) {
        expect(m.satirlar, isNotEmpty, reason: m.id);
        for (final s in m.satirlar) {
          expect(s.ku.trim(), isNotEmpty, reason: m.id);
          expect(s.tr.trim(), isNotEmpty, reason: m.id);
        }
      }
    });

    test('her sorunun doğru cevabı belirli ve seçenekler farklı', () {
      var soru = 0;
      for (final m in kXwendinMetinleri) {
        for (final e in m.sorular) {
          soru++;
          expect(e.options.length, greaterThanOrEqualTo(2), reason: e.id);
          expect(e.options.toSet().length, e.options.length, reason: e.id);
          expect(e.correctIndex, inInclusiveRange(0, e.options.length - 1), reason: e.id);
          expect(e.options[e.correctIndex!], e.correctAnswer, reason: e.id);
        }
      }
      expect(soru, greaterThan(0));
    });

    test('Gotar bağlantıları: yayındaki portala gider, benzersiz', () {
      expect(kGotarBaglantilari.length, greaterThanOrEqualTo(12));
      expect(kGotarBaglantilari.map((g) => g.$2).toSet().length, kGotarBaglantilari.length);
      for (final (sernav, url) in kGotarBaglantilari) {
        expect(sernav.trim(), isNotEmpty);
        expect(url.startsWith(kGotarBingeh), isTrue, reason: url);
        expect(url.endsWith('/'), isTrue, reason: url);
      }
    });

    test('soru dersi kimlikle bulunur; sorusu olmayan metnin dersi yok', () {
      final hikaye = kXwendinMetinleri.firstWhere((m) => m.sorular.isNotEmpty);
      final ders = lessonById(hikaye.dersKimligi)!;
      expect(ders.exercises.length, hikaye.sorular.length);
      expect(ders.exercises.every(isScored), isTrue);

      final sorusuz = kXwendinMetinleri.firstWhere((m) => m.sorular.isEmpty);
      expect(lessonById(sorusuz.dersKimligi), isNull);
      expect(lessonById('xwendin_yok'), isNull);
    });
  });

  group('ekran', () {
    Future<ProviderContainer> ac(WidgetTester tester, String id) async {
      SharedPreferences.setMockInitialValues({});
      ActivityOutcome.clear();
      tester.view.physicalSize = const Size(480, 6000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(path: '/', builder: (_, __) => XwendinScreen(id: id)),
          GoRoute(
            path: AppRoutes.wanePlay,
            builder: (_, state) => WaneScreen(
                lessonId: (state.extra as Map<String, dynamic>)['lessonId'] as String),
          ),
        ],
      );
      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
      ));
      await tester.pump(const Duration(milliseconds: 400));
      return container;
    }

    testWidgets('liste: düzeyin metni başlığı ve soru sayısıyla görünür', (tester) async {
      SharedPreferences.setMockInitialValues({});
      tester.view.physicalSize = const Size(480, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(ProviderScope(
        child: MaterialApp(theme: AppTheme.light, home: const XwendinListScreen(level: 'A1')),
      ));
      await tester.pump(const Duration(milliseconds: 400));
      final m = xwendinForLevel('A1').first;
      expect(find.text(m.titleKu), findsOneWidget);
      expect(find.textContaining('${m.sorular.length} pirs'), findsOneWidget);
    });

    testWidgets('Gotar bağlantıları B2 ve üstünde görünür, A1 düzeyinde görünmez', (tester) async {
      SharedPreferences.setMockInitialValues({});
      tester.view.physicalSize = const Size(480, 6000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      Future<void> ac(String d) async {
        await tester.pumpWidget(ProviderScope(
          key: ValueKey(d),
          child: MaterialApp(theme: AppTheme.light, home: XwendinListScreen(level: d)),
        ));
        await tester.pump(const Duration(milliseconds: 400));
      }

      await ac('B2');
      expect(find.text('Gotar · gavbigav.com'), findsOneWidget);
      expect(find.text(kGotarBaglantilari.first.$1), findsOneWidget);
      await ac('A1');
      expect(find.text('Gotar · gavbigav.com'), findsNothing);
    });

    testWidgets('çeviri başta kapalı, "Werger" ile açılır', (tester) async {
      final m = xwendinForLevel('A1').first;
      await ac(tester, m.id);
      expect(find.text(m.satirlar.first.ku), findsOneWidget);
      expect(find.text(m.satirlar.first.tr), findsNothing);
      await tester.tap(find.text('Werger'));
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text(m.satirlar.first.tr), findsOneWidget);
    });

    testWidgets('sorular oynanır; sonuç metnin kimliğiyle kaydedilir', (tester) async {
      final m = xwendinForLevel('A1').first;
      final c = await ac(tester, m.id);
      await tester.tap(find.text('Pirs (${m.sorular.length})'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      for (final e in m.sorular) {
        await tester.tap(find.text(e.correctAnswer).last);
        await tester.pump(const Duration(milliseconds: 400));
        await tester.tap(find.text('Berdewam'));
        await tester.pump(const Duration(milliseconds: 400));
      }
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.text('Wane qediya!'), findsOneWidget);
      expect(c.read(lessonProgressProvider)[m.dersKimligi], 100);
      await tester.pump(const Duration(seconds: 3));
    });

    testWidgets('sorusu olmayan metin "Min xwend" ile tamamlanır', (tester) async {
      final m = kXwendinMetinleri.firstWhere((x) => x.sorular.isEmpty);
      final c = await ac(tester, m.id);
      await tester.tap(find.text('Min xwend'));
      await tester.pump(const Duration(milliseconds: 400));
      expect(c.read(lessonProgressProvider)[m.dersKimligi], 100);
      expect(ActivityOutcome.take()!.passed, isTrue);
    });

    testWidgets('bilinmeyen kimlik yolu kilitlemez', (tester) async {
      await ac(tester, 'yok_boyle_metin');
      expect(find.text('Metn tune ye.'), findsOneWidget);
      expect(ActivityOutcome.take()!.passed, isTrue);
    });
  });
}
