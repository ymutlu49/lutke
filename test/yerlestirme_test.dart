// Düzey belirleme testi — Ekim 2026 yenilemesi.
//
//   1. Aşamalı karar: bant başına 6 soru, bant kesinleşince beklenmez;
//      geçilemeyen ilk bant başlanacak düzeydir.
//   2. Sorular: Kurmancî bantları düzeyin kendi içeriğinden tamamlanır,
//      İngilizce havuz 36 sorudur.
//   3. Ekran: "Nizanim" ile ilerleme, erken bitiş, sonuç.
//   4. Gönüllülük: ana ekrandaki davet kartı.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lutke/core/constants/app_theme.dart';
import 'package:lutke/features/en_learning/domain/en_a1_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_a2_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_b1_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_b2_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_c1_kelime_db.dart';
import 'package:lutke/features/en_learning/domain/en_c2_kelime_db.dart';
import 'package:lutke/features/lessons/domain/lesson_catalog.dart';
import 'package:lutke/features/lessons/domain/olcme.dart';
import 'package:lutke/features/onboarding/placement_questions.dart';
import 'package:lutke/features/onboarding/placement_test_screen.dart';
import 'package:lutke/shared/widgets/placement_invite_card.dart';
import 'package:lutke/shared/providers/learning_track_provider.dart';

void main() {
  group('aşamalı karar', () {
    test('bandı geçmek için gereken doğru: 2→2, 4→3, 5→4, 6→5', () {
      expect(bantGerekli(1), 1);
      expect(bantGerekli(2), 2);
      expect(bantGerekli(4), 3);
      expect(bantGerekli(5), 4);
      expect(bantGerekli(6), 5);
    });

    test('bant kararı kesinleşince verilir, kesinleşmeden verilmez', () {
      // 6 soruluk bant: 5 doğru geçer, 2 yanlış geçemez.
      expect(bantKarari(dogru: 0, yanlis: 0, toplam: 6), isNull);
      expect(bantKarari(dogru: 4, yanlis: 1, toplam: 6), isNull);
      expect(bantKarari(dogru: 5, yanlis: 0, toplam: 6), isTrue);
      expect(bantKarari(dogru: 5, yanlis: 1, toplam: 6), isTrue);
      expect(bantKarari(dogru: 0, yanlis: 2, toplam: 6), isFalse);
      expect(bantKarari(dogru: 4, yanlis: 2, toplam: 6), isFalse);
      expect(bantKarari(dogru: 0, yanlis: 1, toplam: 6), isNull);
    });

    test('adım: alttan başlar, geçilen bandın üstüne çıkar, geçilemeyende biter', () {
      (int, int, int) b(int d, int y) => (d, y, 6);
      final bos = {for (final d in kLessonLevels) d: b(0, 0)};
      expect(yerlestirmeAdimi(bos), (bant: 'A1', sonuc: null));
      // Hiç bilmeyen: iki yanlışta A1.
      expect(yerlestirmeAdimi({...bos, 'A1': b(0, 2)}), (bant: null, sonuc: 'A1'));
      // A1 geçildi → A2 sorulur.
      expect(yerlestirmeAdimi({...bos, 'A1': b(5, 0)}), (bant: 'A2', sonuc: null));
      // A1, A2 geçildi; B1'de iki yanlış → B1.
      expect(yerlestirmeAdimi({...bos, 'A1': b(5, 1), 'A2': b(5, 0), 'B1': b(3, 2)}), (bant: null, sonuc: 'B1'));
      // Hepsi geçildi → en üst düzey.
      expect(yerlestirmeAdimi({for (final d in kLessonLevels) d: b(5, 1)}), (bant: null, sonuc: 'C2'));
      // Üst bantta doğrular alt bant geçilmeden düzeyi yükseltmez.
      expect(yerlestirmeAdimi({...bos, 'A1': b(1, 2), 'C1': b(6, 0)}), (bant: null, sonuc: 'A1'));
    });

    test('adımın sonucu oran kuralıyla (yerlestirmeDuzeyi) aynıdır', () {
      final rng = Random(5);
      for (var t = 0; t < 2000; t++) {
        final bantlar = <String, (int, int, int)>{};
        for (final d in kLessonLevels) {
          final dogru = rng.nextInt(7);
          bantlar[d] = (dogru, 6 - dogru, 6);
        }
        final adim = yerlestirmeAdimi(bantlar);
        expect(adim.sonuc, yerlestirmeDuzeyi({for (final e in bantlar.entries) e.key: (e.value.$1, e.value.$3)}));
      }
    });

    test('rastgele işaretleyen A1\'de kalır (10 000 denemede en çok %2 üstüne çıkar)', () {
      final rng = Random(42);
      var ustunde = 0;
      for (var t = 0; t < 10000; t++) {
        // Aşamalı oynat: her soruda dört seçenekten biri rastgele.
        final bantlar = {for (final d in kLessonLevels) d: (0, 0, 6)};
        String? sonuc;
        while (sonuc == null) {
          final adim = yerlestirmeAdimi(bantlar);
          if (adim.sonuc != null) {
            sonuc = adim.sonuc;
            break;
          }
          final b = bantlar[adim.bant!]!;
          bantlar[adim.bant!] = rng.nextInt(4) == 0 ? (b.$1 + 1, b.$2, 6) : (b.$1, b.$2 + 1, 6);
        }
        if (sonuc != 'A1') ustunde++;
      }
      expect(ustunde, lessThan(200));
    });
  });

  group('sorular', () {
    test('İngilizce havuz: 36 soru, bant başına 6, kimlikler benzersiz, cevaplar belirli', () {
      expect(kPlacementEn, hasLength(36));
      expect(kPlacementEn.map((q) => q.id).toSet(), hasLength(36));
      expect(kPlacementEn.map((q) => q.prompt).toSet(), hasLength(36));
      for (final c in PlacementCefr.values) {
        expect(kPlacementEn.where((q) => q.cefr == c), hasLength(kBantSoruSayisi), reason: c.label);
      }
      final konum = [0, 0, 0, 0];
      for (final q in kPlacementEn) {
        expect(q.options, hasLength(4), reason: q.id);
        expect(q.options.toSet(), hasLength(4), reason: q.id);
        expect(q.correctIndex, inInclusiveRange(0, 3), reason: q.id);
        konum[q.correctIndex]++;
      }
      // Doğru cevap hep aynı sırada değil: her konum en az 6 kez.
      expect(konum.every((k) => k >= 6), isTrue, reason: '$konum');
    });

    test('Kurmancî elle yazılmış sorular yerinde: 10 soru, her bantta en az bir', () {
      expect(kPlacementKuEl, hasLength(10));
      for (final c in PlacementCefr.values) {
        expect(kPlacementKuEl.where((q) => q.cefr == c), isNotEmpty, reason: c.label);
      }
    });

    test('her düzeyde, her tohumda bant eksiksiz üretilir; seçenekler ayrık, cevap belirli', () {
      for (final d in kLessonLevels) {
        for (var tohum = 0; tohum < 60; tohum++) {
          final bant = yerlestirmeBandi(d, 5, Random(tohum));
          expect(bant, hasLength(5), reason: '$d tohum $tohum');
          expect(bant.map((e) => e.id).toSet(), hasLength(5), reason: '$d tohum $tohum');
          for (final e in bant) {
            expect(e.options.length, greaterThanOrEqualTo(2), reason: e.id);
            expect(e.options.toSet(), hasLength(e.options.length), reason: e.id);
            expect(e.correctIndex, isNotNull, reason: e.id);
            expect(e.options[e.correctIndex!], e.correctAnswer, reason: e.id);
          }
          // Bant başına en çok bir biçim sorusu; gerisi kelime.
          expect(bant.where((e) => !e.id.startsWith('yerlestirme_peyv_')).length, lessThanOrEqualTo(1));
        }
      }
    });

    test('kelime sorusunun doğru cevabı kelimenin veritabanındaki karşılığıdır', () {
      for (final d in kLessonLevels) {
        final kelimeler = {for (final w in wordsForLevel(d)) w.id as String: w};
        for (final e in yerlestirmeBandi(d, 5, Random(9))) {
          if (!e.id.startsWith('yerlestirme_peyv_')) continue;
          final w = kelimeler[e.cardId]!;
          expect(e.kurmanjPrompt, (w.ku as String).trim());
          expect(e.correctAnswer, (w.tr as String).trim());
          expect(e.options, hasLength(4));
        }
      }
    });

    test('Türkçe akrabası olan sözcük sorulmaz (hefte/hafta, çetel/çatal)', () {
      final gorulen = <String>{};
      for (final d in kLessonLevels) {
        for (var tohum = 0; tohum < 150; tohum++) {
          for (final e in yerlestirmeBandi(d, 5, Random(tohum))) {
            if (e.id.startsWith('yerlestirme_peyv_')) gorulen.add(e.kurmanjPrompt.toLowerCase());
          }
        }
      }
      expect(gorulen, isNot(contains('hefte')));
      expect(gorulen, isNot(contains('çetel')));
      expect(gorulen, isNot(contains('mîtolojî')));
      // Akraba olmayanlar soruluyor.
      expect(gorulen.length, greaterThan(500));
    });

    test('test: her iki dilde 36 soru, bant sırasıyla, bant başına 6; aynı tohum aynı test', () {
      for (final en in [false, true]) {
        final s = buildPlacementQuestions(english: en, rng: Random(3));
        expect(s, hasLength(36));
        expect(s.map((q) => q.id).toSet(), hasLength(36));
        for (var i = 0; i < 36; i++) {
          expect(s[i].cefr, PlacementCefr.values[i ~/ 6], reason: 'sıra $i');
        }
        final t = buildPlacementQuestions(english: en, rng: Random(3));
        expect(t.map((q) => q.id).toList(), s.map((q) => q.id).toList());
      }
      // Kurmancî: elle yazılmış soruların hepsi testte.
      final ku = buildPlacementQuestions(english: false, rng: Random(1)).map((q) => q.id).toSet();
      expect(ku.containsAll(kPlacementKuEl.map((q) => q.id)), isTrue);
      // Farklı tohum farklı test (üretilen sorular yeniden örneklenir).
      final ku2 = buildPlacementQuestions(english: false, rng: Random(2)).map((q) => q.id).toSet();
      expect(ku2, isNot(ku));
    });
  });

  group('İngilizce: düzeyin kelime listesinden üretilen sorular', () {
    test('her düzeyde, her tohumda 3 kelime sorusu; cevap veritabanındaki Kurmancî karşılık', () {
      final listeler = {
        'A1': kEnA1Liste, 'A2': kEnA2Liste, 'B1': kEnB1Liste,
        'B2': kEnB2Liste, 'C1': kEnC1Liste, 'C2': kEnC2Liste,
      };
      for (final e in listeler.entries) {
        final kayit = {for (final w in e.value) w.id: w};
        for (var tohum = 0; tohum < 40; tohum++) {
          final bant = enYerlestirmeBandi(e.key, 3, Random(tohum));
          expect(bant, hasLength(3), reason: '${e.key} tohum $tohum');
          for (final s in bant) {
            final w = kayit[s.cardId]!;
            expect(s.kurmanjPrompt, w.en.trim());
            expect(s.correctAnswer, w.ku.trim());
            expect(s.options, hasLength(4));
            expect(s.options.toSet(), hasLength(4));
            expect(s.options[s.correctIndex!], s.correctAnswer);
            expect(s.turkishPrompt, 'Ev peyv bi Kurmancî çi ye?');
          }
        }
      }
    });

    test('Kurmancîde akrabası olan sözcük sorulmaz (internet, computer, telephone)', () {
      final sorulan = <String>{};
      for (final d in ['A1', 'A2', 'B1']) {
        for (var tohum = 0; tohum < 300; tohum++) {
          sorulan.addAll(enYerlestirmeBandi(d, 3, Random(tohum)).map((e) => e.kurmanjPrompt));
        }
      }
      expect(sorulan, isNot(contains('internet')));
      expect(sorulan, isNot(contains('computer')));
      expect(sorulan, isNot(contains('telephone')));
      expect(sorulan.length, greaterThan(500));
    });

    test('bant: 3 elle yazılmış dilbilgisi sorusu + 3 kelime sorusu; tohum değişince test değişir', () {
      final elKimlik = kPlacementEn.map((q) => q.id).toSet();
      for (var tohum = 0; tohum < 20; tohum++) {
        final s = buildPlacementQuestions(english: true, rng: Random(tohum));
        expect(s, hasLength(36));
        for (final c in PlacementCefr.values) {
          final bant = s.where((q) => q.cefr == c).toList();
          expect(bant, hasLength(6));
          expect(bant.where((q) => elKimlik.contains(q.id)), hasLength(kEnElSayisi), reason: '${c.label} tohum $tohum');
          expect(bant.where((q) => q.id.startsWith('yerlestirme_en_')), hasLength(6 - kEnElSayisi));
        }
      }
      final a = buildPlacementQuestions(english: true, rng: Random(1)).map((q) => q.id).toSet();
      final b = buildPlacementQuestions(english: true, rng: Random(2)).map((q) => q.id).toSet();
      expect(a, isNot(b));
    });
  });

  group('ekran', () {
    Future<void> ac(WidgetTester tester, Widget ekran, {Map<String, Object> prefs = const {}}) async {
      SharedPreferences.setMockInitialValues(prefs);
      tester.view.physicalSize = const Size(520, 3000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(ProviderScope(
        child: MaterialApp(theme: AppTheme.light, home: ekran),
      ));
      await tester.pump(const Duration(milliseconds: 600));
    }

    testWidgets('hiç bilmeyen: iki "Nizanim" ile test biter, düzey A1', (tester) async {
      await ac(tester, PlacementTestScreen(retake: true, rng: Random(1)));
      expect(find.textContaining('A1 · 1 / 6'), findsOneWidget);
      await tester.tap(find.text('Nizanim · Bilmiyorum'));
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.textContaining('A1 · 2 / 6'), findsOneWidget);
      await tester.tap(find.text('Nizanim · Bilmiyorum'));
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.text('Asta te: A1'), findsOneWidget);
      expect(find.text('0 ji 2 rast'), findsOneWidget);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('placement_level_ku'), 'a1');
      await tester.pump(const Duration(seconds: 2));
    });

    testWidgets('İngilizce yolda: kelime sorusu Kurmancî yönergeyle gelir; iki "Nizanim" A1', (tester) async {
      SharedPreferences.setMockInitialValues({});
      tester.view.physicalSize = const Size(520, 3000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      final sorular = buildPlacementQuestions(english: true, rng: Random(4));
      await tester.pumpWidget(ProviderScope(
        overrides: [currentTrackProvider.overrideWithValue(LearningTrack.englishAdult)],
        child: MaterialApp(
          theme: AppTheme.light,
          home: PlacementTestScreen(retake: true, rng: Random(4)),
        ),
      ));
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.text('Asta xwe bibîne — Îngilîzî'), findsOneWidget);
      expect(find.text(sorular.first.prompt), findsWidgets);
      await tester.tap(find.text('Nizanim · Bilmiyorum'));
      await tester.pump(const Duration(milliseconds: 400));
      await tester.tap(find.text('Nizanim · Bilmiyorum'));
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.text('Asta te: A1'), findsOneWidget);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('placement_level_en'), 'a1');
      await tester.pump(const Duration(seconds: 2));
    });

    testWidgets('A1 beş doğruyla geçilir (altıncı sorulmaz), A2 iki yanlışla biter: düzey A2', (tester) async {
      final sorular = buildPlacementQuestions(english: false, rng: Random(7));
      await ac(tester, PlacementTestScreen(retake: true, rng: Random(7)));
      final a1 = sorular.where((q) => q.cefr == PlacementCefr.a1).toList();
      for (var i = 0; i < 5; i++) {
        expect(find.textContaining('A1 · ${i + 1} / 6'), findsOneWidget);
        expect(find.text(a1[i].prompt), findsWidgets);
        await tester.tap(find.text(a1[i].options[a1[i].correctIndex]).last);
        await tester.pump(const Duration(milliseconds: 200));
        await tester.tap(find.text('Berdewam bike'));
        await tester.pump(const Duration(milliseconds: 400));
      }
      // Altıncı A1 sorusu sorulmadı; A2'ye geçildi.
      expect(find.textContaining('A2 · 1 / 6'), findsOneWidget);
      await tester.tap(find.text('Nizanim · Bilmiyorum'));
      await tester.pump(const Duration(milliseconds: 400));
      await tester.tap(find.text('Nizanim · Bilmiyorum'));
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.text('Asta te: A2'), findsOneWidget);
      expect(find.text('5 ji 7 rast'), findsOneWidget);
      await tester.pump(const Duration(seconds: 2));
    });
  });

  group('gönüllü davet', () {
    Future<void> ac(WidgetTester tester, Map<String, Object> prefs) async {
      SharedPreferences.setMockInitialValues(prefs);
      await tester.pumpWidget(ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(body: PlacementInviteCard()),
        ),
      ));
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump(const Duration(milliseconds: 300));
    }

    testWidgets('düzey testi yapılmamışsa davet görünür; "Paşê" ile kapanır ve kapalı kalır', (tester) async {
      await ac(tester, {});
      expect(find.text('Asta xwe bibîne'), findsOneWidget);
      expect(find.text('Dest pê bike'), findsOneWidget);
      await tester.tap(find.text('Paşê'));
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Asta xwe bibîne'), findsNothing);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(placementInviteDismissedKeyFor('ku')), isTrue);
    });

    testWidgets('test sonucu yazılınca davet kendiliğinden kalkar', (tester) async {
      await ac(tester, {});
      expect(find.text('Asta xwe bibîne'), findsOneWidget);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('placement_level_ku', 'a2');
      final container = ProviderScope.containerOf(tester.element(find.byType(PlacementInviteCard)));
      container.read(placementRevisionProvider.notifier).state++;
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Asta xwe bibîne'), findsNothing);
    });

    testWidgets('düzey belliyse ya da davet kapatıldıysa görünmez', (tester) async {
      await ac(tester, {'placement_level_ku': 'b1'});
      expect(find.text('Asta xwe bibîne'), findsNothing);
      await ac(tester, {placementInviteDismissedKeyFor('ku'): true});
      expect(find.text('Asta xwe bibîne'), findsNothing);
    });
  });
}
