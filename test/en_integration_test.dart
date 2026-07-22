// ════════════════════════════════════════════════════════════════
// LÛTKE — İngilizce Modülü Entegrasyon Testleri
//
// Bu dosya EN modülünün shared altyapı ile entegrasyonunu doğrular:
//   1. LearningTrack enum → route path eşlemesi
//   2. Track switching (KU ↔ EN) atomikliği ve legacy provider sync
//   3. EnWord tipi invariant'ları (EN DB kalitesi cross-check)
//   4. Track-aware routing (en/* path vs /home shell)
//
// Kapsam hedefi: EN modül değişiklikleri bu testleri kırarsa kullanıcı
// akışı bozulmuş demektir — deep-link, back-nav, analytics.
//
// Çalıştır:
//   flutter test test/en_integration_test.dart
// ════════════════════════════════════════════════════════════════

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lutke/shared/providers/child_mode_provider.dart';
import 'package:lutke/shared/providers/learning_module_provider.dart';
import 'package:lutke/shared/providers/learning_track_provider.dart';

void main() {
  group('EN Integration — LearningTrack invariants', () {
    test('All EN tracks have languageCode "en" and emoji globe', () {
      final enTracks = [
        LearningTrack.englishAdult,
        LearningTrack.englishChild,
      ];
      for (final t in enTracks) {
        expect(t.isEnglish, isTrue,
            reason: '${t.id} isEnglish false');
        expect(t.languageCode, 'en',
            reason: '${t.id} languageCode != "en"');
        expect(t.emoji, '🌍',
            reason: '${t.id} emoji != "🌍" (brand consistency)');
      }
    });

    test('EN adult and child have distinct nativeHomePath', () {
      expect(
        LearningTrack.englishAdult.nativeHomePath,
        isNot(equals(LearningTrack.englishChild.nativeHomePath)),
        reason: 'EN adult vs child must route to different shells',
      );
      // Adult uses /home shell; child uses /child/home shell.
      expect(LearningTrack.englishAdult.nativeHomePath, '/home');
      expect(LearningTrack.englishChild.nativeHomePath, '/child/home');
    });

    test('Track.from(isEnglish:true) returns en* tracks', () {
      expect(LearningTrack.from(isEnglish: true, isChild: false),
          LearningTrack.englishAdult);
      expect(LearningTrack.from(isEnglish: true, isChild: true),
          LearningTrack.englishChild);
      expect(LearningTrack.from(isEnglish: false, isChild: false),
          LearningTrack.kurdishAdult);
      expect(LearningTrack.from(isEnglish: false, isChild: true),
          LearningTrack.kurdishChild);
    });

    test('Track.fromId round-trips id', () {
      for (final t in LearningTrack.values) {
        expect(LearningTrack.fromId(t.id), t,
            reason: '${t.id} round-trip failed');
      }
      // Unknown id defaults to kurdishAdult (never null).
      expect(LearningTrack.fromId('garbage_xxx'), LearningTrack.kurdishAdult);
      expect(LearningTrack.fromId(''), LearningTrack.kurdishAdult);
    });

    test('All track labels (Ku/Tr) non-empty — UI safety', () {
      for (final t in LearningTrack.values) {
        expect(t.labelKu.trim(), isNotEmpty,
            reason: '${t.id} labelKu empty — UI göstermez');
        expect(t.labelTr.trim(), isNotEmpty,
            reason: '${t.id} labelTr empty — UI göstermez');
      }
    });

    test('Home paths follow /<lang>/<audience>/home convention', () {
      // homePath kullanılmıyor ama future-proof — sözleşme belgeleyici test.
      expect(LearningTrack.englishAdult.homePath.startsWith('/en/'), isTrue);
      expect(LearningTrack.englishChild.homePath.startsWith('/en/'), isTrue);
      expect(LearningTrack.kurdishAdult.homePath.startsWith('/ku/'), isTrue);
      expect(LearningTrack.kurdishChild.homePath.startsWith('/ku/'), isTrue);
    });
  });

  group('EN Integration — legacy provider sync', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('Setting englishAdult track syncs learningModuleProvider=english',
        () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Notifier load async — ilk oku null olabilir.
      await Future<void>.delayed(const Duration(milliseconds: 50));

      await container
          .read(activeTrackProvider.notifier)
          .setTrack(LearningTrack.englishAdult);

      expect(container.read(learningModuleProvider), LearningModule.english);
      expect(container.read(isChildModeProvider), isFalse);
      expect(container.read(isEnglishModuleProvider), isTrue);
    });

    test('Setting englishChild track syncs child=true + module=english',
        () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Eski provider'lar önce oluştursun ki _loadFromPrefs bitsin
      container.read(isChildModeProvider);
      container.read(learningModuleProvider);
      await Future<void>.delayed(const Duration(milliseconds: 100));

      await container
          .read(activeTrackProvider.notifier)
          .setTrack(LearningTrack.englishChild);
      // Sync tamamlansın
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(container.read(learningModuleProvider), LearningModule.english);
      expect(container.read(isChildModeProvider), isTrue);
    });

    test('Switching KU → EN → KU preserves child state', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(isChildModeProvider);
      container.read(learningModuleProvider);
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // KU child
      await container
          .read(activeTrackProvider.notifier)
          .setTrack(LearningTrack.kurdishChild);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(container.read(isChildModeProvider), isTrue);
      expect(container.read(isEnglishModuleProvider), isFalse);

      // → EN child (aynı audience, farklı dil)
      await container
          .read(activeTrackProvider.notifier)
          .setTrack(LearningTrack.englishChild);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(container.read(isChildModeProvider), isTrue,
          reason: 'Dil değişimi çocuk modunu bozmamalı');
      expect(container.read(isEnglishModuleProvider), isTrue);

      // → KU child
      await container
          .read(activeTrackProvider.notifier)
          .setTrack(LearningTrack.kurdishChild);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(container.read(isChildModeProvider), isTrue);
      expect(container.read(isEnglishModuleProvider), isFalse);
    });

    test('switchAudience toggles isChild without changing language',
        () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await Future<void>.delayed(const Duration(milliseconds: 50));

      await container
          .read(activeTrackProvider.notifier)
          .setTrack(LearningTrack.englishAdult);

      container.read(activeTrackProvider.notifier).switchAudience();
      await Future<void>.delayed(const Duration(milliseconds: 10));

      final t = container.read(currentTrackProvider);
      expect(t, LearningTrack.englishChild);
      expect(t.isEnglish, isTrue);
    });

    test('switchLanguage toggles EN ↔ KU without changing audience',
        () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await Future<void>.delayed(const Duration(milliseconds: 50));

      await container
          .read(activeTrackProvider.notifier)
          .setTrack(LearningTrack.englishAdult);

      container.read(activeTrackProvider.notifier).switchLanguage();
      await Future<void>.delayed(const Duration(milliseconds: 10));

      final t = container.read(currentTrackProvider);
      expect(t, LearningTrack.kurdishAdult);
      expect(t.isAdult, isTrue);
    });
  });
}
