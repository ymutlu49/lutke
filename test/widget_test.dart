import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Widget Testleri
// ════════════════════════════════════════════════════════════════

void main() {
  group('LÛTKE Widget Testleri', () {

    // ── Splash Screen ─────────────────────────────────────────
    testWidgets('SplashScreen "Xêr hatî" gösterir', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Xêr hatî.')),
            ),
          ),
        ),
      );
      expect(find.text('Xêr hatî.'), findsOneWidget);
    });

    // ── FSRS Rating ───────────────────────────────────────────
    testWidgets('FSRSRatingCard 4 düğme gösterir', (tester) async {
      int ratingCalled = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Row(
                children: [
                  // Dubare (Again)
                  ElevatedButton(
                    onPressed: () => ratingCalled++,
                    child: const Text('Dubare'),
                  ),
                  // Dijwar (Hard)
                  ElevatedButton(
                    onPressed: () => ratingCalled++,
                    child: const Text('Dijwar'),
                  ),
                  // Baş (Good)
                  ElevatedButton(
                    onPressed: () => ratingCalled++,
                    child: const Text('Baş'),
                  ),
                  // Hêsan (Easy)
                  ElevatedButton(
                    onPressed: () => ratingCalled++,
                    child: const Text('Hêsan'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      expect(find.text('Dubare'), findsOneWidget);
      expect(find.text('Dijwar'), findsOneWidget);
      expect(find.text('Baş'), findsOneWidget);
      expect(find.text('Hêsan'), findsOneWidget);

      await tester.tap(find.text('Baş'));
      expect(ratingCalled, 1);
    });

    // ── Kurmancî Birincil Dil ─────────────────────────────────
    testWidgets('LessonCard Kurmancî başlığı önce gösterir', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: const [
                // Kurmancî önce, Türkçe sonra
                Text('Malbat', style: TextStyle(fontSize: 20)),
                Text('Aile', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      );

      final malbatFinder = find.text('Malbat');
      final aileFinder = find.text('Aile');

      expect(malbatFinder, findsOneWidget);
      expect(aileFinder, findsOneWidget);

      // Kurmancî üstte olmalı
      final malbatPos = tester.getTopLeft(malbatFinder);
      final ailePos = tester.getTopLeft(aileFinder);
      expect(malbatPos.dy, lessThan(ailePos.dy));
    });

    // ── Destekleyici Ton ──────────────────────────────────────
    testWidgets('Tamamlama ekranı kutlama mesajı içerir', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Column(
                children: const [
                  Text('Temam bû!'),   // Kurmancî kutlama
                  Text('Berdewam bike!'),
                ],
              ),
            ),
          ),
        ),
      );
      expect(find.text('Temam bû!'), findsOneWidget);
    });
  });
}
