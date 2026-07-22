import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lutke/features/admin/data/content_override_service.dart';
import 'package:lutke/features/lessons/domain/a1_kelime_db.dart';

void main() {
  group('Content Override — entegrasyon', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('WordOverride toJson ↔ fromJson round trip', () {
      const o = WordOverride(
        tr: 'yeni-çeviri',
        en: 'new-translation',
        not: 'gramer notu',
        zor: 0.65,
        cins: 'mê',
        ez: '-a',
      );
      final j = o.toJson();
      final back = WordOverride.fromJson(j);
      expect(back.tr, 'yeni-çeviri');
      expect(back.en, 'new-translation');
      expect(back.not, 'gramer notu');
      expect(back.zor, 0.65);
      expect(back.cins, 'mê');
      expect(back.ez, '-a');
    });

    test('isEmpty / isNotEmpty kontrolleri', () {
      const empty = WordOverride();
      expect(empty.isEmpty, isTrue);
      expect(empty.isNotEmpty, isFalse);

      const partial = WordOverride(tr: 'x');
      expect(partial.isEmpty, isFalse);
      expect(partial.isNotEmpty, isTrue);
    });

    test('ContentOverrideService save + loadAll round-trip', () async {
      final svc = ContentOverrideService();
      await svc.save(
        'a1_001',
        const WordOverride(tr: 'yeni TR', en: 'new EN', zor: 0.4),
      );
      final all = await svc.loadAll();
      expect(all.containsKey('a1_001'), isTrue);
      expect(all['a1_001']!.tr, 'yeni TR');
      expect(all['a1_001']!.en, 'new EN');
      expect(all['a1_001']!.zor, 0.4);
    });

    test('ContentOverrideService delete', () async {
      final svc = ContentOverrideService();
      await svc.save('a1_001', const WordOverride(tr: 'x'));
      await svc.delete('a1_001');
      final all = await svc.loadAll();
      expect(all.containsKey('a1_001'), isFalse);
    });

    test('ContentOverrideService clearAll', () async {
      final svc = ContentOverrideService();
      await svc.save('a1_001', const WordOverride(tr: 'a'));
      await svc.save('a1_002', const WordOverride(tr: 'b'));
      await svc.clearAll();
      final all = await svc.loadAll();
      expect(all, isEmpty);
    });

    test('applyOverride — gerçek A1 kelime kaydına uygulanır', () {
      // Gerçek DB'den bir kayıt al ve üzerine override bindir.
      final rec = kA1TamListe.first;
      final originalKu = rec.ku;
      final originalKat = rec.kat;
      final originalId = rec.id;

      const override = WordOverride(
        tr: 'OVERRIDE_TR',
        en: 'OVERRIDE_EN',
        not: 'test gramer notu',
        zor: 0.88,
      );
      final o = applyOverride(rec, override);

      // Yapısal alanlar DOKUNULMAZ
      expect(o.id, originalId, reason: 'id strukturaldır');
      expect(o.ku, originalKu, reason: 'ku strukturaldır (TTS + arama)');
      expect(o.kat, originalKat, reason: 'kat strukturaldır (ders eşleşmesi)');

      // Override edilen alanlar değişir
      expect(o.tr, 'OVERRIDE_TR');
      expect(o.en, 'OVERRIDE_EN');
      expect(o.not, 'test gramer notu');
      expect(o.zor, 0.88);

      // Override edilmeyen alanlar orijinalden gelir (her, gen)
      expect(o.her, rec.her);
      expect(o.gen, rec.gen);
    });

    test('applyOverride — null/empty override raw objeyi döner', () {
      final rec = kA1TamListe.first;
      expect(applyOverride(rec, null), same(rec));
      expect(applyOverride(rec, const WordOverride()), same(rec));
    });

    test('applyOverride — kısmi override: sadece tr set, en orijinalden gelir',
        () {
      final rec = kA1TamListe.first;
      final originalEn = rec.en;
      const override = WordOverride(tr: 'PARTIAL');
      final o = applyOverride(rec, override);
      expect(o.tr, 'PARTIAL');
      expect(o.en, originalEn, reason: 'en override edilmedi');
    });

    test('SharedPreferences direct read — doğru JSON format', () async {
      SharedPreferences.setMockInitialValues({
        'content_overrides_v1': jsonEncode({
          'a1_042': {'tr': 'injected', 'zor': 0.3},
        }),
      });
      final svc = ContentOverrideService();
      final all = await svc.loadAll();
      expect(all['a1_042']!.tr, 'injected');
      expect(all['a1_042']!.zor, 0.3);
      expect(all['a1_042']!.en, isNull,
          reason: 'ayarlanmamış alanlar null kalır');
    });
  });
}
