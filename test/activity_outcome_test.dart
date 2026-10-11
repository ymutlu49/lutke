// Tamamlama ölçütü: etkinlik yalnız oturum bitirilip eşik geçildiyse
// tamamlanmış sayılır (iyileştirme planı Faz 1.5).
//
// İki katman sınanır:
//   1. ActivityOutcome — eşik, "en iyi sonuç kalır", içerik yok durumu
//   2. UnitHubScreen — etkinlikten dönüşte basamağın işaretlenip işaretlenmediği

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lutke/core/constants/app_theme.dart';
import 'package:lutke/features/lessons/presentation/unit_hub_screen.dart';
import 'package:lutke/shared/providers/activity_outcome.dart';
import 'package:lutke/shared/providers/progression_provider.dart';

void main() {
  group('ActivityOutcome', () {
    setUp(ActivityOutcome.clear);

    test('eşik %70: 7/10 geçer, 6/10 geçmez', () {
      expect(const ActivityOutcome(7, 10).passed, isTrue);
      expect(const ActivityOutcome(6, 10).passed, isFalse);
      expect(const ActivityOutcome(5, 6).passed, isTrue);
      expect(const ActivityOutcome(4, 6).passed, isFalse);
    });

    test('hiç deneme yoksa geçilmez', () {
      expect(const ActivityOutcome(0, 0).passed, isFalse);
    });

    test('puansız etkinlik bitirilince geçer', () {
      expect(const ActivityOutcome.completed().passed, isTrue);
    });

    test('bildirim yoksa take() null döner', () {
      expect(ActivityOutcome.take(), isNull);
    });

    test('take() tutucuyu boşaltır', () {
      ActivityOutcome.report(const ActivityOutcome(8, 10));
      expect(ActivityOutcome.take()!.percent, 80);
      expect(ActivityOutcome.take(), isNull);
    });

    test('aynı ekranda yeniden denenirse en iyi sonuç kalır', () {
      ActivityOutcome.report(const ActivityOutcome(9, 10));
      ActivityOutcome.report(const ActivityOutcome(3, 10));
      expect(ActivityOutcome.take()!.passed, isTrue);

      ActivityOutcome.report(const ActivityOutcome(3, 10));
      ActivityOutcome.report(const ActivityOutcome(8, 10));
      expect(ActivityOutcome.take()!.passed, isTrue);
    });

    test('içerik yoksa basamak yolu kilitlemez', () {
      ActivityOutcome.reportNoContent();
      expect(ActivityOutcome.take()!.passed, isTrue);
    });
  });

  group('UnitHubScreen tamamlama ölçütü', () {
    const lessonId = 'a1_silav_1';

    // Etkinlik ekranının yerine geçen sahte ekran: üç çıkış yolu.
    Widget sahteEtkinlik(BuildContext context) => Scaffold(
          body: Column(
            children: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('erken-cik'),
              ),
              TextButton(
                onPressed: () {
                  ActivityOutcome.report(const ActivityOutcome(5, 10));
                  context.pop();
                },
                child: const Text('dusuk-puan'),
              ),
              TextButton(
                onPressed: () {
                  ActivityOutcome.report(const ActivityOutcome(8, 10));
                  context.pop();
                },
                child: const Text('gecer-puan'),
              ),
            ],
          ),
        );

    Future<ProviderContainer> hubuAc(WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      ActivityOutcome.clear();
      tester.view.physicalSize = const Size(480, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final container = ProviderContainer();
      addTearDown(container.dispose);
      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => const UnitHubScreen(
              category: 'silav',
              titleKu: 'Silav',
              level: 'A1',
            ),
          ),
          GoRoute(
            path: '/activity/flashcard',
            builder: (context, __) => sahteEtkinlik(context),
          ),
        ],
      );
      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
      ));
      // Aktif basamak sürekli nabız animasyonu oynatır; pumpAndSettle bitmez.
      await tester.pump(const Duration(seconds: 2));
      return container;
    }

    Future<void> etkinligiAcVe(WidgetTester tester, String cikis) async {
      // NavGuard çift tıklamayı GERÇEK saatle (600 ms) yutar; sahte zaman onu
      // ilerletmez. Art arda açılışlar arasında gerçekten beklenir.
      await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 700)));
      await tester.tap(find.text('Peld'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.text(cikis));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
    }

    testWidgets('erken çıkılırsa basamak tamamlanmaz', (tester) async {
      final c = await hubuAc(tester);
      await etkinligiAcVe(tester, 'erken-cik');
      expect(c.read(progressionProvider), isNot(contains(lessonId)));
      expect(find.textContaining('neqediya'), findsOneWidget);
    });

    testWidgets('eşiğin altında kalınırsa basamak tamamlanmaz', (tester) async {
      final c = await hubuAc(tester);
      await etkinligiAcVe(tester, 'dusuk-puan');
      expect(c.read(progressionProvider), isNot(contains(lessonId)));
      expect(find.textContaining('Ji sedî 50'), findsOneWidget);
    });

    testWidgets('eşik geçilirse basamak tamamlanır', (tester) async {
      final c = await hubuAc(tester);
      await etkinligiAcVe(tester, 'gecer-puan');
      expect(c.read(progressionProvider), contains(lessonId));
    });

    testWidgets('önce başarısız, sonra başarılı: ikinci denemede tamamlanır',
        (tester) async {
      final c = await hubuAc(tester);
      await etkinligiAcVe(tester, 'dusuk-puan');
      expect(c.read(progressionProvider), isNot(contains(lessonId)));
      await etkinligiAcVe(tester, 'gecer-puan');
      expect(c.read(progressionProvider), contains(lessonId));
    });
  });
}
