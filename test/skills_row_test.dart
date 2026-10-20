// Ana ekrandaki beceri satırı — İngilizce yolda da (Ekim 2026).

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lutke/core/constants/app_theme.dart';
import 'package:lutke/core/router/app_router.dart';
import 'package:lutke/features/en_learning/presentation/en_listening_screen.dart';
import 'package:lutke/features/en_learning/presentation/en_reading_screen.dart';
import 'package:lutke/features/en_learning/presentation/en_speaking_screen.dart';
import 'package:lutke/features/en_learning/presentation/en_writing_screen.dart';
import 'package:lutke/features/lessons/presentation/skills_row.dart';

void main() {
  test('İngilizce yol: okuma, dinleme, yazma, konuşma — İngilizce ekranlara', () {
    final e = skillEntries(english: true);
    expect([for (final x in e) x.$2], ['Xwendin', 'Guhdarîkirin', 'Nivîsîn', 'Axaftin']);
    expect([for (final x in e) x.$3], ['Reading', 'Listening', 'Writing', 'Speaking']);
    expect([for (final x in e) x.$4],
        [AppRoutes.enReading, AppRoutes.enListening, AppRoutes.enWriting, AppRoutes.enSpeaking]);
  });

  test('Kurmancî yol değişmedi', () {
    final k = skillEntries(english: false);
    expect([for (final x in k) x.$2], ['Nivîsîn', 'Axaftin', 'Çîrok', 'Xwendin']);
    expect([for (final x in k) x.$4],
        [AppRoutes.writing, AppRoutes.speaking, AppRoutes.story, AppRoutes.xwendin]);
  });

  Future<void> ac(WidgetTester tester, {required bool english, double genislik = 360}) async {
    SharedPreferences.setMockInitialValues({});
    tester.view.physicalSize = Size(genislik, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    final router = GoRouter(routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => Scaffold(body: SkillsRow(level: 'A1', english: english)),
      ),
      for (final x in skillEntries(english: english))
        GoRoute(path: x.$4, builder: (_, __) => Scaffold(body: Text('ekran ${x.$4}'))),
    ]);
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
    ));
    await tester.pump(const Duration(milliseconds: 600));
  }

  testWidgets('İngilizce satır dar ekranda taşmadan görünür; dokununca ilgili ekran açılır', (tester) async {
    await ac(tester, english: true);
    expect(tester.takeException(), isNull);
    for (final ad in ['Xwendin', 'Guhdarîkirin', 'Nivîsîn', 'Axaftin', 'Reading', 'Listening', 'Writing', 'Speaking']) {
      expect(find.text(ad), findsOneWidget, reason: ad);
    }
    await tester.tap(find.text('Guhdarîkirin'));
    await tester.pumpAndSettle();
    expect(find.text('ekran ${AppRoutes.enListening}'), findsOneWidget);
  });

  testWidgets('Kurmancî satırda Türkçe ikinci satır dil ayarına bağlı kalır', (tester) async {
    await ac(tester, english: false);
    expect(find.text('Çîrok'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  // Ana ekrandan artık doğrudan açılan dört İngilizce ekran hatasız kurulur.
  for (final (ad, ekran) in <(String, Widget)>[
    ('okuma', const EnReadingScreen()),
    ('dinleme', const EnListeningScreen()),
    ('yazma', const EnWritingScreen()),
    ('konuşma', const EnSpeakingScreen()),
  ]) {
    testWidgets('İngilizce $ad ekranı hatasız açılır', (tester) async {
      SharedPreferences.setMockInitialValues({});
      tester.view.physicalSize = const Size(420, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(ProviderScope(
        child: MaterialApp(theme: AppTheme.light, home: ekran),
      ));
      await tester.pump(const Duration(milliseconds: 800));
      expect(tester.takeException(), isNull);
      expect(find.byType(Scaffold), findsWidgets);
      await tester.pump(const Duration(seconds: 2));
    });
  }
}
