import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'child_mode_provider.dart';
import 'learning_module_provider.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Learning Track (Öğrenme Yolu)
//
// 4 farklı öğrenme yolu birbirinden tamamen ayrık:
//   1. kurdishAdult — Kurmancî / Mezinan  (🐐 Genel)
//   2. kurdishChild — Kurmancî / Zarokan  (🐐👶 Çocuk)
//   3. englishAdult — İngilizce / Mezinan (🌍 Genel)
//   4. englishChild — İngilizce / Zarokan (🌍👶 Çocuk)
//
// Bu provider:
//   - Tek kaynak (TEK source of truth) — UI/router/içerik hepsi buna bakar
//   - Persistent (SharedPreferences)
//   - Geriye uyumlu: eski `learningModuleProvider` ve `isChildModeProvider`
//     bu track'ten türetilen değerler döner.
//
// **Kural:** Uygulamada "hangi modda çalışıyorum?" sorusunun TEK yanıtı
// `activeTrackProvider`'dır. Bu karıştırmayı engeller.
// ════════════════════════════════════════════════════════════════

enum LearningTrack {
  kurdishAdult(
    id: 'ku_adult',
    languageCode: 'ku',
    isChild: false,
    emoji: '🐐',
    labelKu: 'Kurmancî',
    labelTr: 'Kürtçe — Yetişkinler',
    homePath: '/ku/adult/home',
    nativeHomePath: '/home',
  ),
  kurdishChild(
    id: 'ku_child',
    languageCode: 'ku',
    isChild: true,
    emoji: '🐐',
    labelKu: 'Kurmancî',
    labelTr: 'Kürtçe — Çocuklar',
    homePath: '/ku/child/home',
    nativeHomePath: '/child/home',
  ),
  englishAdult(
    id: 'en_adult',
    languageCode: 'en',
    isChild: false,
    emoji: '🌍',
    labelKu: 'Îngilîzî',
    labelTr: 'İngilizce — Yetişkinler',
    homePath: '/en/adult/home',
    // Ortak shell kullanılır (bottom nav tutarlı); içerik modül-aware.
    nativeHomePath: '/home',
  ),
  englishChild(
    id: 'en_child',
    languageCode: 'en',
    isChild: true,
    emoji: '🌍',
    labelKu: 'Îngilîzî',
    labelTr: 'İngilizce — Çocuklar',
    homePath: '/en/child/home',
    // Ortak child shell kullanılır; içerik track-aware render edilir.
    nativeHomePath: '/child/home',
  );

  /// Stable id ('ku_adult', 'en_child' ...) — SharedPreferences anahtarı.
  final String id;

  /// 'ku' veya 'en' — TTS, kelime DB, UI dili.
  final String languageCode;

  /// Çocuk modu mu? → child theme + 3-tab shell + büyük emoji.
  final bool isChild;

  final String emoji;
  final String labelKu;
  final String labelTr;

  /// Track'in mantıksal ana sayfa path'i (gelecek refactor için).
  final String homePath;

  /// Mevcut uygulamanın gerçek route path'i (bugün navigate için).
  final String nativeHomePath;

  const LearningTrack({
    required this.id,
    required this.languageCode,
    required this.isChild,
    required this.emoji,
    required this.labelKu,
    required this.labelTr,
    required this.homePath,
    required this.nativeHomePath,
  });

  bool get isKurdish => languageCode == 'ku';
  bool get isEnglish => languageCode == 'en';
  bool get isAdult => !isChild;

  static LearningTrack fromId(String id) {
    return LearningTrack.values.firstWhere(
      (t) => t.id == id,
      orElse: () => LearningTrack.kurdishAdult,
    );
  }

  static LearningTrack from({
    required bool isEnglish,
    required bool isChild,
  }) {
    if (isEnglish) {
      return isChild ? LearningTrack.englishChild : LearningTrack.englishAdult;
    }
    return isChild ? LearningTrack.kurdishChild : LearningTrack.kurdishAdult;
  }
}

/// Notifier — SharedPreferences ile persist + eski provider'lara senkronize eder.
class LearningTrackNotifier extends StateNotifier<LearningTrack?> {
  final Ref ref;
  LearningTrackNotifier(this.ref) : super(null) {
    _load();
  }

  static const _key = 'learning_track_v1';

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      if (raw == null || raw.isEmpty) {
        // İlk açılış — eski provider'lardan türet (geriye uyum)
        final isEn = ref.read(learningModuleProvider) == LearningModule.english;
        final isChild = ref.read(isChildModeProvider);
        state = LearningTrack.from(isEnglish: isEn, isChild: isChild);
      } else {
        state = LearningTrack.fromId(raw);
      }
      // Eski provider'ları güncel track ile sıkıla
      await _syncLegacyProviders(state!);
    } catch (_) {
      state = LearningTrack.kurdishAdult;
    }
  }

  Future<void> setTrack(LearningTrack track) async {
    state = track;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, track.id);
    } catch (_) {}
    await _syncLegacyProviders(track);
  }

  /// Eski API'yi (learningModuleProvider + isChildModeProvider) track'e senkronla.
  /// Böylece tüm eski ekranlar ve widget'lar aynı gerçeklikle çalışır.
  Future<void> _syncLegacyProviders(LearningTrack track) async {
    try {
      await ref.read(learningModuleProvider.notifier).setModule(
            track.isEnglish ? LearningModule.english : LearningModule.kurmanci,
          );
    } catch (_) {}
    try {
      await ref.read(isChildModeProvider.notifier).setChildMode(track.isChild);
    } catch (_) {}
  }

  /// Hızlı yardımcılar:
  void switchLanguage() {
    final t = state ?? LearningTrack.kurdishAdult;
    setTrack(LearningTrack.from(
      isEnglish: !t.isEnglish,
      isChild: t.isChild,
    ));
  }

  void switchAudience() {
    final t = state ?? LearningTrack.kurdishAdult;
    setTrack(LearningTrack.from(
      isEnglish: t.isEnglish,
      isChild: !t.isChild,
    ));
  }
}

/// Uygulamanın aktif track'i — TEK kaynak.
/// null = henüz yüklenmedi (SharedPreferences bekleniyor).
final activeTrackProvider =
    StateNotifierProvider<LearningTrackNotifier, LearningTrack?>(
  (ref) => LearningTrackNotifier(ref),
);

/// Kısa: etkin track (null ise default Kurmancî Mezinan).
final currentTrackProvider = Provider<LearningTrack>((ref) {
  return ref.watch(activeTrackProvider) ?? LearningTrack.kurdishAdult;
});
