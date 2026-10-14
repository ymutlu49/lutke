// İngilizce yol — biçim alıştırmaları ve düzey sınavı (Ekim 2026).
//
// Kurmancî yolda yapılanların İngilizce karşılığı: düzey/konu başına
// dilbilgisi alıştırmaları, 20 soruluk düzey sınavı ve sertifikanın bu
// sınava bağlanması.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lutke/core/constants/app_theme.dart';
import 'package:lutke/features/certificate/certificate_screen.dart';
import 'package:lutke/features/en_learning/domain/en_quiz_items.dart';
import 'package:lutke/features/lessons/domain/en_ders.dart';
import 'package:lutke/features/lessons/domain/lesson_catalog.dart';
import 'package:lutke/features/lessons/domain/olcme.dart';
import 'package:lutke/features/lessons/presentation/wane_list_screen.dart';
import 'package:lutke/shared/providers/learning_track_provider.dart';
import 'package:lutke/shared/providers/lesson_progress_provider.dart';

void main() {
  group('alıştırmalar', () {
    test('her düzeyde en az bir alıştırma; konular test merkezinin Kurmancî adlarıyla', () {
      expect(enBicimDersKimlikleri('A1'), ['bicim_en_article_a1', 'bicim_en_plural_a1', 'bicim_en_prep_a1']);
      expect(enBicimDersKimlikleri('C1'), ['bicim_en_reziman_c1']);
      for (final d in kLessonLevels) {
        expect(enBicimDersKimlikleri(d), isNotEmpty, reason: d);
      }
      expect(lessonById('bicim_en_article_a1')!.kurmanjTitle, 'Artîkel · A1');
      expect(lessonById('bicim_en_past_a2')!.kurmanjTitle, 'Dema borî · A2');
      expect(lessonById('bicim_en_reziman_c1')!.kurmanjTitle, 'Rêziman · C1');
    });

    test('her alıştırma: düzeyin ve konunun soruları, seçenekler ayrık, cevap belirli', () {
      final kaynak = {for (final q in kEnQuizItems) q.id: q};
      for (final d in kLessonLevels) {
        for (final id in enBicimDersKimlikleri(d)) {
          final ders = enBicimDersi(id, rng: Random(1))!;
          expect(ders.exercises.length, inInclusiveRange(6, kEnBicimSoruSayisi), reason: id);
          expect(ders.exercises.map((e) => e.id).toSet(), hasLength(ders.exercises.length));
          for (final e in ders.exercises) {
            final q = kaynak[e.id]!;
            expect(q.level, d, reason: e.id);
            expect(e.options.toSet(), hasLength(e.options.length), reason: e.id);
            expect(e.options[e.correctIndex!], q.correctAnswer, reason: e.id);
          }
        }
      }
    });

    test('alıştırma her açılışta yeniden örneklenir; tanınmayan kimlik null', () {
      final a = enBicimDersi('bicim_en_past_a2', rng: Random(1))!.exercises.map((e) => e.id).toList();
      final b = enBicimDersi('bicim_en_past_a2', rng: Random(2))!.exercises.map((e) => e.id).toList();
      expect(a, isNot(b));
      expect(enBicimDersi('bicim_en_past_a1'), isNull); // A1'de dema borî alıştırması yok
      expect(enBicimDersi('bicim_en_yok_a1'), isNull);
    });
  });

  group('düzey sınavı', () {
    test('her düzeyde 20 soru: dilbilgisi en çok 10, kalanı kelime; kimlikler benzersiz', () {
      for (final d in kLessonLevels) {
        final s = ezmunEnDersi(ezmunEnKimligi(d), rng: Random(3))!;
        expect(s.id, 'ezmun_en_${d.toLowerCase()}');
        expect(s.kurmanjTitle, 'Ezmûna astê · $d');
        expect(s.exercises, hasLength(kEzmunSoruSayisi), reason: d);
        expect(s.exercises.map((e) => e.id).toSet(), hasLength(kEzmunSoruSayisi), reason: d);
        final kelime = s.exercises.where((e) => e.id.startsWith('ezmun_en_peyv_')).length;
        expect(kEzmunSoruSayisi - kelime, lessThanOrEqualTo(10), reason: d);
        expect(kelime, greaterThanOrEqualTo(10), reason: d);
        for (final e in s.exercises) {
          expect(e.options[e.correctIndex!], e.correctAnswer, reason: e.id);
        }
      }
    });

    test('katalogdan bulunur; Kurmancî sınav ve alıştırmalar etkilenmez', () {
      expect(lessonById('ezmun_en_b1')!.kurmanjTitle, 'Ezmûna astê · B1');
      expect(lessonById('ezmun_en_x9'), isNull);
      expect(lessonById(ezmunKimligi('A1'))!.id, 'ezmun_a1');
      expect(lessonById('bicim_izafe_a2'), isNotNull);
    });
  });

  group('ekran', () {
    Future<ProviderContainer> ac(WidgetTester tester, Widget ekran) async {
      SharedPreferences.setMockInitialValues({});
      tester.view.physicalSize = const Size(480, 12000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      final container = ProviderContainer(overrides: [
        currentTrackProvider.overrideWithValue(LearningTrack.englishAdult),
      ]);
      addTearDown(container.dispose);
      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: MaterialApp(theme: AppTheme.light, home: ekran),
      ));
      await tester.pump(const Duration(milliseconds: 500));
      return container;
    }

    testWidgets('İngilizce yolda ders listesi: alıştırmalar ve düzey sınavı', (tester) async {
      await ac(tester, const WaneListScreen(level: 'A1'));
      expect(find.text('Artîkel · A1'), findsOneWidget);
      expect(find.text('Pirjimar · A1'), findsOneWidget);
      expect(find.text('Daçek · A1'), findsOneWidget);
      expect(find.text('Ezmûna astê · A1'), findsOneWidget);
      expect(find.text('Wane tune ye.'), findsNothing);
    });

    testWidgets('İngilizce yolda da sertifika sınav geçilmeden verilmez', (tester) async {
      final c = await ac(tester, const CertificateScreen(level: 'A1'));
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Dest bi ezmûnê bike'), findsOneWidget);

      // Kurmancî sınavı geçmek İngilizce sertifikayı açmaz.
      await c.read(lessonProgressProvider.notifier).record(ezmunKimligi('A1'), 90);
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Dest bi ezmûnê bike'), findsOneWidget);

      await c.read(lessonProgressProvider.notifier).record(ezmunEnKimligi('A1'), 85);
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Dest bi ezmûnê bike'), findsNothing);
      await tester.pump(const Duration(seconds: 2));
    });
  });
}
