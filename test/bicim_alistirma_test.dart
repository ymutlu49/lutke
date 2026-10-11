// Veriden üretilen biçim alıştırmaları (iyileştirme planı Faz 4.6).
//
// Sorular rastgele üretildiği için tek tek değil, değişmezleriyle sınanır:
//   1. veri — tabloya giren her ad ve fiil kendi kanıtıyla tutarlı
//   2. üretim — her soruda doğru cevap tek, seçenekler farklı, cevap veriyle aynı
//   3. katalog — üretilen ders elle yazılmış ders gibi bulunur ve oynanır

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lutke/core/constants/app_theme.dart';
import 'package:lutke/features/lessons/domain/bicim_alistirma.dart';
import 'package:lutke/features/lessons/domain/cins_kanit_db.dart';
import 'package:lutke/features/lessons/domain/fiil_db.dart';
import 'package:lutke/features/lessons/domain/lesson_catalog.dart';
import 'package:lutke/features/lessons/presentation/wane_list_screen.dart';
import 'package:lutke/features/lessons/presentation/wane_screen.dart';
import 'package:lutke/shared/providers/activity_outcome.dart';
import 'package:lutke/shared/providers/lesson_progress_provider.dart';

const _cekimli = {'Min', 'Te', 'Wî', 'Wê', 'Me', 'Wan'};

void main() {
  tearDown(() => bicimTohumu = null);

  group('kanıt tabloları', () {
    test('cinsiyet tablosu: her kimlik gerçek bir kelime, kanıtı dolu', () {
      final kimlikler = <String>{
        for (final d in kLessonLevels)
          for (final w in wordsForLevel(d)) w.id as String,
      };
      expect(kCinsKaniti.length, greaterThan(500));
      for (final e in kCinsKaniti.entries) {
        expect(kimlikler, contains(e.key));
        expect(e.value.trim(), isNotEmpty, reason: e.key);
      }
    });

    test('fiil tablosu: geçişli fiil çekimli özneyle, geçişsiz yalın özneyle tanıklı', () {
      expect(kFiiller.length, greaterThanOrEqualTo(25));
      for (final f in kFiiller.values) {
        expect(f.gecmis, isNotEmpty, reason: f.mastar);
        expect(f.tr, isNotEmpty, reason: f.mastar);
        if (f.gecisli) {
          expect(f.tanikCekimli, greaterThanOrEqualTo(3), reason: f.mastar);
          expect(f.tanikYalin * 10, lessThanOrEqualTo(f.tanikCekimli + f.tanikYalin),
              reason: '${f.mastar}: yalın zamirle kullanım %10\'u geçiyor');
        } else {
          expect(f.tanikYalin, greaterThanOrEqualTo(3), reason: f.mastar);
          expect(f.tanikCekimli, 0, reason: f.mastar);
        }
      }
      // Çekirdek fiiller tabloda olmalı.
      for (final m in ['kirin', 'gotin', 'hatin', 'çûn', 'dîtin', 'xwarin']) {
        expect(kFiiller, contains(m));
      }
      expect(kFiiller['gotin']!.gecisli, isTrue);
      expect(kFiiller['hatin']!.gecisli, isFalse);
    });
  });

  group('izafe', () {
    test('tersIzafe: -a ile -ê yer değiştirir', () {
      expect(tersIzafe('mala'), 'malê');
      expect(tersIzafe('bavê'), 'bava');
      expect(tersIzafe('dêya'), 'dêyê');
      expect(tersIzafe('baxçeyê'), 'baxçeya');
    });

    test('alıştırmaya giren her adın etiketi, izafe biçimi ve kanıtı tutarlı', () {
      var toplam = 0;
      for (final d in kLessonLevels) {
        for (final w in izafeAdlari(d)) {
          toplam++;
          final ez = w.ez as String;
          final ku = (w.ku as String).toLowerCase();
          expect(kCinsKaniti, contains(w.id));
          expect(ez.endsWith(w.cins == 'mê' ? 'a' : 'ê'), isTrue, reason: '${w.id} $ez');
          expect(ez.toLowerCase().startsWith(ku), isTrue, reason: '${w.id} $ez');
          // Üç seçenek birbirinden farklı olmalı.
          expect({ez.toLowerCase(), tersIzafe(ez).toLowerCase(), ku}.length, 3,
              reason: '${w.id}: seçenekler çakışıyor');
        }
      }
      expect(toplam, greaterThan(300));
    });

    test('üretilen sorularda doğru cevap adın kendi izafe biçimi', () {
      for (final d in ['A1', 'A2', 'B1']) {
        final adlar = {for (final w in izafeAdlari(d)) w.id as String: w};
        for (var tohum = 0; tohum < 5; tohum++) {
          final sorular = izafeSorulari(d, Random(tohum));
          expect(sorular.length, kBicimSoruSayisi);
          expect(sorular.map((s) => s.id).toSet().length, sorular.length);
          for (final s in sorular) {
            final w = adlar[s.cardId]!;
            expect(s.options.toSet().length, 3);
            expect(s.options[s.correctIndex!], s.correctAnswer);
            expect(s.correctAnswer.startsWith('${w.ez} '), isTrue);
            expect(s.grammarNote, contains(w.cins == 'mê' ? '-a' : '-ê'));
            expect(s.grammarNote, contains('Kanıt:'));
          }
        }
      }
    });
  });

  group('ergatif', () {
    test('geçişli fiilde doğru özne çekimli, geçişsizde yalın', () {
      for (var tohum = 0; tohum < 20; tohum++) {
        final sorular = ergatifSorulari(Random(tohum));
        expect(sorular.length, kBicimSoruSayisi);
        for (final s in sorular) {
          final mastar = s.id.split('_')[2];
          final f = kFiiller[mastar]!;
          final ozne = s.correctAnswer.split(' ').first;
          expect(s.options.toSet().length, 2);
          expect(s.options[s.correctIndex!], s.correctAnswer);
          expect(_cekimli.contains(ozne), f.gecisli,
              reason: '${s.correctAnswer} — $mastar ${f.gecisli ? 'geçişli' : 'geçişsiz'}');
          // Fiil biçimi tablodan: geçmiş kök ya da 1. kişi.
          final bicim = s.correctAnswer.substring(ozne.length + 1).replaceAll('.', '');
          expect([f.gecmis, f.gecmis1], contains(bicim));
          expect(s.grammarNote, contains('Korpusta'));
        }
      }
    });

    test('her derste hem geçişli hem geçişsiz fiil var', () {
      final sorular = ergatifSorulari(Random(3));
      final turler = {for (final s in sorular) kFiiller[s.id.split('_')[2]]!.gecisli};
      expect(turler, {true, false});
    });
  });

  group('katalog', () {
    test('üretilen ders kimliğiyle bulunur; tanınmayan kimlik null', () {
      final d = lessonById('bicim_izafe_a1')!;
      expect(d.exercises.length, kBicimSoruSayisi);
      expect(d.exercises.every(isScored), isTrue);
      expect(lessonById('bicim_ergatif_a2'), isNotNull);
      expect(lessonById('bicim_ergatif_a1'), isNull, reason: 'ergatif A1\'de sunulmuyor');
      expect(lessonById('bicim_yok_a1'), isNull);
      expect(lessonById('bicim_izafe_z9'), isNull);
    });

    test('düzeye göre sunulan alıştırmalar', () {
      expect(bicimDersKimlikleri('A1'), ['bicim_izafe_a1']);
      expect(bicimDersKimlikleri('A2'), ['bicim_izafe_a2', 'bicim_ergatif_a2']);
      // Elle yazılmış derslerin sayısı değişmedi.
      expect([for (final d in kLessonLevels) ...lessonsForLevel(d)].length, 105);
    });

    test('aynı tohum aynı dersi üretir', () {
      bicimTohumu = 11;
      final a = lessonById('bicim_ergatif_a2')!.exercises.map((e) => e.correctAnswer).toList();
      final b = lessonById('bicim_ergatif_a2')!.exercises.map((e) => e.correctAnswer).toList();
      expect(a, b);
    });
  });

  group('ekran', () {
    Future<ProviderContainer> ac(WidgetTester tester, Widget ekran) async {
      SharedPreferences.setMockInitialValues({});
      ActivityOutcome.clear();
      tester.view.physicalSize = const Size(480, 3200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: MaterialApp(theme: AppTheme.light, home: ekran),
      ));
      await tester.pump(const Duration(milliseconds: 400));
      return container;
    }

    testWidgets('ders listesinde alıştırmalar başta görünür', (tester) async {
      await ac(tester, const WaneListScreen(level: 'A2'));
      expect(find.text('Veqetandek: -a an -ê?'), findsOneWidget);
      expect(find.text('Ergatîf: Min an Ez?'), findsOneWidget);
    });

    testWidgets('üretilen ders oynanır; açıklama kanıtı gösterir; puan kaydedilir',
        (tester) async {
      const id = 'bicim_ergatif_a2';
      bicimTohumu = 5;
      final ders = lessonById(id)!;
      final c = await ac(tester, const WaneScreen(lessonId: id));

      for (var i = 0; i < ders.exercises.length; i++) {
        final e = ders.exercises[i];
        await tester.tap(find.text(e.correctAnswer).last);
        await tester.pump(const Duration(milliseconds: 400));
        if (i == 0) {
          expect(find.text('Rêziman'), findsOneWidget);
          expect(find.textContaining('Korpusta'), findsOneWidget);
        }
        await tester.tap(find.text('Berdewam'));
        await tester.pump(const Duration(milliseconds: 400));
      }
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.text('Wane qediya!'), findsOneWidget);
      expect(c.read(lessonProgressProvider)[id], 100);
      expect(ActivityOutcome.take()!.passed, isTrue);
      await tester.pump(const Duration(seconds: 3));
    });
  });
}
