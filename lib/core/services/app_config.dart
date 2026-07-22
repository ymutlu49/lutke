/// LÛTKE — Global Feature Flag ve Yapılandırma.
///
/// AI ve opsiyonel özelliklerin merkezi toggle'ı. Production'da
/// Firebase Remote Config ile dinamik olabilir; şu an sabitler.

class AppConfig {
  // ── AI / ASR Özellikleri ──────────────────────────────────

  /// Whisper Kurmancî ASR (HuggingFace amedcj/whisper-kurmanji, 10.5% WER)
  /// Etkinleştirmek için: bu flag + HF API key gerekir.
  static const bool enableKurmanciAsr = false;

  /// HF endpoint — `amedcj/whisper-kurmanji` Inference API.
  /// Gerçek kullanımda env/secret'ta tutulmalı.
  static const String whisperKurmanciEndpoint =
      'https://api-inference.huggingface.co/models/amedcj/whisper-kurmanji';

  /// LLM "Explain My Answer" — Claude Haiku / Gemini Flash.
  /// Etkinleştirmek için: API key + billing setup.
  static const bool enableLlmExplanation = false;
  static const String llmModel = 'claude-haiku-3-5';
  static const double llmCostPerM = 0.80; // USD (input tokens)

  // ── Sosyal Özellikler ─────────────────────────────────────

  /// Friends Quest (5 günlük ortak XP hedefi). Firebase Firestore gerekir.
  static const bool enableFriendsQuest = false;

  /// Leaderboard (haftalık XP). Duolingo tarzı. Yetişkin modda kapalı.
  static const bool enableLeaderboard = false;

  // ── Çocuk Modu Kısıtları (COPPA/GDPR-K uyumu) ───────────

  /// Çocuk modunda LLM çağrısı — varsayılan KAPALI (FTC COPPA 2025).
  static const bool allowLlmInChildMode = false;

  /// Çocuk modunda konuşma kaydı bulut transferi — varsayılan KAPALI.
  /// Voiceprint biyometrik veri kabul edilir.
  static const bool allowCloudAsrInChildMode = false;

  // ── Bilgi Sürümü ──────────────────────────────────────────

  static const String contentVersion = '2026.04.18';
  static const String appVersion = '1.0.0-beta';
}

// ════════════════════════════════════════════════════════════════
// KURMANCÎ TTS KAYNAK SEÇİMİ
// ════════════════════════════════════════════════════════════════

enum KurmanciTtsSource {
  /// Önceden üretilmiş asset'ler (amedcj/kmr_tts ile render edildi) +
  /// bilinmeyen kelimelerde klasik HF fallback.
  /// ORİJİNAL SES — Kurmancî erkek gırtlak tonu. Önerilen default.
  assetFirst(
    id: 'asset_first',
    labelKu: 'Asayî (dengê resen — asset pêşîn) ⭐',
    labelTr: 'Standart (orijinal ses — asset öncelikli) ⭐',
  ),
  /// Yalnız ön-üretilmiş asset'ler. Hiçbir ağ çağrısı yapılmaz.
  /// %100 tutarlı, offline.
  assetOnly(
    id: 'asset_only',
    labelKu: 'Tenê asset (offline, hevdest)',
    labelTr: 'Sadece asset (offline, tutarlı)',
  ),
  /// Klasik amedcj/kmr_tts HuggingFace Space — asset'leri atla, her zaman HF.
  huggingface(
    id: 'hf_only',
    labelKu: 'amedcj/kmr_tts (rastevok runtime)',
    labelTr: 'amedcj/kmr_tts (güncel runtime)',
  ),
  /// Google Gemini 2.5 Flash "Fenrir" — deneysel, farklı bir ses verir.
  /// Orijinal Kurmancî modelden farklı tonda; yedek/alternatif.
  geminiFenrir(
    id: 'gemini_fenrir',
    labelKu: 'Gemini — Fenrir (alternatîf)',
    labelTr: 'Gemini — Fenrir (alternatif)',
  );

  final String id;
  final String labelKu;
  final String labelTr;
  const KurmanciTtsSource({
    required this.id,
    required this.labelKu,
    required this.labelTr,
  });
}
