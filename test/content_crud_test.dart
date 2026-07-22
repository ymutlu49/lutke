import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lutke/features/admin/data/content_override_service.dart';
import 'package:lutke/features/admin/data/custom_quiz_service.dart';
import 'package:lutke/features/admin/data/lesson_override_service.dart';
import 'package:lutke/features/lessons/domain/a1_kelime_db.dart';

void main() {
  group('Content CRUD — custom word CRUD', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('saveCustomWord → loadCustomWords round trip', () async {
      final svc = ContentOverrideService();
      final w = CustomWord(
        id: CustomWord.newId(),
        ku: 'xêr',
        tr: 'hayır (iyilik)',
        en: 'goodness',
        cins: 'mê',
        kat: 'custom',
        zor: 0.6,
        level: 'A1',
      );
      await svc.saveCustomWord(w);
      final all = await svc.loadCustomWords();
      expect(all.containsKey(w.id), isTrue);
      expect(all[w.id]!.ku, 'xêr');
      expect(all[w.id]!.level, 'A1');
    });

    test('deleteCustomWord siler', () async {
      final svc = ContentOverrideService();
      final w = CustomWord(id: 'custom_1', ku: 'a', tr: 'a');
      await svc.saveCustomWord(w);
      await svc.deleteCustomWord('custom_1');
      final all = await svc.loadCustomWords();
      expect(all.isEmpty, isTrue);
    });

    test('CustomWord.newId çakışmaz prefix "custom_" ile başlar', () {
      final a = CustomWord.newId();
      expect(a.startsWith('custom_'), isTrue);
      expect(isCustomWordId(a), isTrue);
    });

    test('CustomWord JSON round trip', () {
      final w = CustomWord(
        id: 'custom_42',
        ku: 'nîvro',
        tr: 'öğle',
        en: 'noon',
        cins: 'bêcins',
        ez: null,
        kat: 'dem',
        zor: 0.7,
        level: 'A2',
        her: const ['Nîvro baş e.'],
        gen: const ['Nîvro hat.'],
      );
      final back = CustomWord.fromJson(w.toJson());
      expect(back.id, 'custom_42');
      expect(back.ku, 'nîvro');
      expect(back.level, 'A2');
      expect(back.her, ['Nîvro baş e.']);
    });
  });

  group('Content CRUD — deleted ids (soft delete)', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('addDeletedId + loadDeletedIds', () async {
      final svc = ContentOverrideService();
      await svc.addDeletedId('a1_001');
      await svc.addDeletedId('a1_002');
      final all = await svc.loadDeletedIds();
      expect(all.contains('a1_001'), isTrue);
      expect(all.contains('a1_002'), isTrue);
      expect(all.length, 2);
    });

    test('removeDeletedId geri alır', () async {
      final svc = ContentOverrideService();
      await svc.addDeletedId('a1_001');
      await svc.removeDeletedId('a1_001');
      final all = await svc.loadDeletedIds();
      expect(all.isEmpty, isTrue);
    });

    test('applyVocabulary silinen id\'yi filtreler', () {
      final rec = kA1TamListe.first;
      final String id = rec.id;
      final out = applyVocabulary(
        List<dynamic>.from(kA1TamListe),
        level: 'A1',
        deletedIds: {id},
      );
      expect(out.any((w) => w.id == id), isFalse,
          reason: 'silinen id listede olmamalı');
      expect(out.length, kA1TamListe.length - 1);
    });
  });

  group('Content CRUD — applyVocabulary merge', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('custom kelime eklenir (aynı level)', () {
      final custom = CustomWord(
        id: 'custom_99',
        ku: 'dibistan',
        tr: 'okul',
        level: 'A1',
      );
      final out = applyVocabulary(
        List<dynamic>.from(kA1TamListe),
        level: 'A1',
        customWords: {custom.id: custom},
      );
      final hit = out.where((w) => w.id == 'custom_99').toList();
      expect(hit.length, 1);
      expect(hit.first.ku, 'dibistan');
      expect(hit.first.tr, 'okul');
    });

    test('custom kelime farklı level\'dayken eklenmez', () {
      final custom = CustomWord(id: 'custom_77', ku: 'x', tr: 'y', level: 'B1');
      final out = applyVocabulary(
        List<dynamic>.from(kA1TamListe),
        level: 'A1',
        customWords: {custom.id: custom},
      );
      expect(out.any((w) => w.id == 'custom_77'), isFalse);
    });

    test('override + delete + custom aynı anda uygulanır', () {
      final first = kA1TamListe.first;
      final String firstId = first.id;
      final second = kA1TamListe[1];
      final String secondId = second.id;

      final custom = CustomWord(
          id: 'custom_5', ku: 'pêşî', tr: 'ilk', level: 'A1');
      final out = applyVocabulary(
        List<dynamic>.from(kA1TamListe),
        level: 'A1',
        overrides: {
          secondId: const WordOverride(tr: 'OVERRIDE_TR'),
        },
        deletedIds: {firstId},
        customWords: {custom.id: custom},
      );
      // İlk silinmiş olmalı
      expect(out.any((w) => w.id == firstId), isFalse);
      // İkinci override edilmiş olmalı
      final overridden = out.firstWhere((w) => w.id == secondId);
      expect(overridden.tr, 'OVERRIDE_TR');
      // Custom eklenmiş olmalı
      expect(out.any((w) => w.id == 'custom_5'), isTrue);
    });

    test('kat filtresi custom kelimelerde çalışır', () {
      final a = CustomWord(
          id: 'custom_a', ku: 'x', tr: 'y', level: 'A1', kat: 'malbat');
      final b = CustomWord(
          id: 'custom_b', ku: 'x', tr: 'y', level: 'A1', kat: 'xwarin');
      final out = applyVocabulary(
        const <dynamic>[],
        level: 'A1',
        kat: 'malbat',
        customWords: {a.id: a, b.id: b},
      );
      expect(out.any((w) => w.id == 'custom_a'), isTrue);
      expect(out.any((w) => w.id == 'custom_b'), isFalse);
    });

    test('boş override/delete/custom → rawList aynen döner', () {
      final out = applyVocabulary(
        List<dynamic>.from(kA1TamListe),
        level: 'A1',
      );
      expect(out.length, kA1TamListe.length);
      // Aynı referanslar döner (override yok)
      expect(out.first, same(kA1TamListe.first));
    });
  });

  group('Content CRUD — lesson override', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('LessonOverride save + load', () async {
      final svc = LessonOverrideService();
      await svc.save(
        'a1_l01',
        const LessonOverride(targetCardIds: ['a1_010', 'a1_011']),
      );
      final all = await svc.loadAll();
      expect(all['a1_l01']!.targetCardIds, ['a1_010', 'a1_011']);
    });

    test('applyLessonOverride targetCardIds\'i override eder', () {
      const lesson = _FakeLesson(id: 'l01', targetCardIds: ['x', 'y']);
      final wrapped = applyLessonOverride(
        lesson,
        const LessonOverride(targetCardIds: ['a', 'b', 'c']),
      );
      final ids = (wrapped.targetCardIds as List).cast<String>();
      expect(ids, ['a', 'b', 'c']);
    });

    test('null override raw lesson objesini döner', () {
      const lesson = _FakeLesson(id: 'l01', targetCardIds: ['x']);
      expect(applyLessonOverride(lesson, null), same(lesson));
      expect(applyLessonOverride(lesson, const LessonOverride()), same(lesson));
    });

    test('delete kaldırır', () async {
      final svc = LessonOverrideService();
      await svc.save('l01', const LessonOverride(targetCardIds: ['x']));
      await svc.delete('l01');
      final all = await svc.loadAll();
      expect(all, isEmpty);
    });

    test('SharedPreferences direct read — doğru JSON format', () async {
      SharedPreferences.setMockInitialValues({
        'lesson_overrides_v1': jsonEncode({
          'a1_l05': {
            'targetCardIds': ['a1_100', 'a1_101'],
          },
        }),
      });
      final svc = LessonOverrideService();
      final all = await svc.loadAll();
      expect(all['a1_l05']!.targetCardIds, ['a1_100', 'a1_101']);
    });
  });

  group('Content CRUD — custom quiz', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('CustomQuizQuestion save + load', () async {
      final svc = CustomQuizService();
      final q = CustomQuizQuestion(
        id: CustomQuizQuestion.newId(),
        questionKu: 'Ev çi ye?',
        options: const ['Av', 'Nan', 'Çay', 'Sêv'],
        correctIndex: 0,
        explanationTr: 'Av = su',
        kat: 'xwarin',
      );
      await svc.save(q);
      final all = await svc.loadAll();
      expect(all.length, 1);
      expect(all[q.id]!.questionKu, 'Ev çi ye?');
      expect(all[q.id]!.correctIndex, 0);
    });

    test('CustomQuizQuestion isValid', () {
      const ok = CustomQuizQuestion(
        id: 'cq_1',
        questionKu: 'x',
        options: ['a', 'b', 'c', 'd'],
        correctIndex: 2,
        explanationTr: '',
        kat: 'x',
      );
      expect(ok.isValid, isTrue);

      const emptyQ = CustomQuizQuestion(
        id: 'cq_2',
        questionKu: '   ',
        options: ['a', 'b', 'c', 'd'],
        correctIndex: 0,
        explanationTr: '',
        kat: 'x',
      );
      expect(emptyQ.isValid, isFalse);

      const wrongCount = CustomQuizQuestion(
        id: 'cq_3',
        questionKu: 'x',
        options: ['a', 'b'],
        correctIndex: 0,
        explanationTr: '',
        kat: 'x',
      );
      expect(wrongCount.isValid, isFalse);

      const indexOut = CustomQuizQuestion(
        id: 'cq_4',
        questionKu: 'x',
        options: ['a', 'b', 'c', 'd'],
        correctIndex: 5,
        explanationTr: '',
        kat: 'x',
      );
      expect(indexOut.isValid, isFalse);
    });

    test('delete quiz question', () async {
      final svc = CustomQuizService();
      final q = CustomQuizQuestion(
        id: 'cq_del',
        questionKu: 'x',
        options: const ['a', 'b', 'c', 'd'],
        correctIndex: 0,
        explanationTr: '',
        kat: 'custom',
      );
      await svc.save(q);
      await svc.delete('cq_del');
      final all = await svc.loadAll();
      expect(all, isEmpty);
    });

    test('clearAll quiz questions', () async {
      final svc = CustomQuizService();
      for (int i = 0; i < 3; i++) {
        await svc.save(CustomQuizQuestion(
          id: 'cq_$i',
          questionKu: 'x',
          options: const ['a', 'b', 'c', 'd'],
          correctIndex: 0,
          explanationTr: '',
          kat: 'custom',
        ));
      }
      await svc.clearAll();
      final all = await svc.loadAll();
      expect(all, isEmpty);
    });

    test('JSON round trip', () {
      final q = CustomQuizQuestion(
        id: 'cq_rt',
        questionKu: 'Çi ye?',
        options: const ['a', 'b', 'c', 'd'],
        correctIndex: 3,
        explanationTr: 'test',
        kat: 'xwarin',
      );
      final back = CustomQuizQuestion.fromJson(q.toJson());
      expect(back.id, q.id);
      expect(back.questionKu, q.questionKu);
      expect(back.correctIndex, 3);
      expect(back.kat, 'xwarin');
    });
  });

  group('Content CRUD — combined (edit + delete + custom)', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('aynı anda 3 özellik: edit, delete, custom kayıtlı kalır', () async {
      final svc = ContentOverrideService();

      // 1) Edit
      await svc.save(
        'a1_001',
        const WordOverride(tr: 'EDITED_TR', zor: 0.3),
      );

      // 2) Delete
      await svc.addDeletedId('a1_002');

      // 3) Custom
      final custom = CustomWord(
        id: 'custom_999',
        ku: 'mît',
        tr: 'efsane',
        level: 'A1',
      );
      await svc.saveCustomWord(custom);

      // loadAll her üçü için çalışmalı
      final edits = await svc.loadAll();
      final deleted = await svc.loadDeletedIds();
      final customs = await svc.loadCustomWords();

      expect(edits['a1_001']!.tr, 'EDITED_TR');
      expect(deleted.contains('a1_002'), isTrue);
      expect(customs['custom_999']!.ku, 'mît');

      // applyVocabulary tümünü tek pasta birleştirir
      final out = applyVocabulary(
        List<dynamic>.from(kA1TamListe),
        level: 'A1',
        overrides: edits,
        deletedIds: deleted,
        customWords: customs,
      );
      // a1_002 silinmiş
      expect(out.any((w) => w.id == 'a1_002'), isFalse);
      // a1_001 override edilmiş
      final edited = out.firstWhere((w) => w.id == 'a1_001');
      expect(edited.tr, 'EDITED_TR');
      // custom_999 eklenmiş
      final customHit = out.firstWhere((w) => w.id == 'custom_999');
      expect(customHit.ku, 'mît');
    });
  });
}

// ── Test yardımcıları ──────────────────────────────────────

class _FakeLesson {
  final String id;
  final List<String> targetCardIds;
  const _FakeLesson({required this.id, required this.targetCardIds});

  // LessonModel pass-through getter'ları (applyLessonOverride wrapper için
  // tüm alanlar gerekmiyor — sadece targetCardIds ve id kullanılıyor).
  String get kurmanjTitle => 'test';
  String get turkishTitle => 'test';
  int get unitNumber => 1;
  int get lessonNumber => 1;
  int get level => 1;
  dynamic get path => null;
  List<dynamic> get exercises => const [];
  String? get culturalRewardId => null;
  int get estimatedMinutes => 0;
  String? get emoji => null;
  String get titleKu => 'test';
  String get titleTr => 'test';
  String get kuTitle => 'test';
  String get trTitle => 'test';
  String? get icon => null;
  int get totalXP => 0;
  int get xpReward => 0;
  bool get hasHeritageContent => false;
  dynamic get culturalReward => null;
  List<dynamic> Function() get buildExercises => () => const [];
}
