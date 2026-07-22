import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_config.dart';

// ════════════════════════════════════════════════════════════════
// Kurmancî TTS Kaynak Tercihi — Kullanıcı seçimli.
//
// Varsayılan: assetFirst (ön-üretilmiş asset + HF fallback).
// Kullanıcı "orijinal ses" tercih ediyorsa assetOnly seçebilir.
// ════════════════════════════════════════════════════════════════

class TtsSourceNotifier extends StateNotifier<KurmanciTtsSource> {
  static const _kKey = 'kurmanci_tts_source_v1';

  // Varsayılan: assetFirst — ön-üretilmiş orijinal amedcj/kmr_tts sesi.
  // Bu asset'ler kullanıcının aradığı Kurmancî gırtlak erkek sesini taşır.
  TtsSourceNotifier() : super(KurmanciTtsSource.assetFirst) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kKey);
    if (raw == null) return;
    state = KurmanciTtsSource.values.firstWhere(
      (s) => s.id == raw,
      orElse: () => KurmanciTtsSource.assetFirst,
    );
  }

  Future<void> set(KurmanciTtsSource source) async {
    state = source;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kKey, source.id);
  }
}

final ttsSourceProvider =
    StateNotifierProvider<TtsSourceNotifier, KurmanciTtsSource>(
  (ref) => TtsSourceNotifier(),
);
