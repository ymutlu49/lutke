import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import 'app_config.dart';

/// LÛTKE — Kurmancî Otomatik Konuşma Tanıma (ASR) Servisi
///
/// Model: `amedcj/whisper-kurmanji` — %10.5 WER / %5.7 CER
/// (arXiv 2410.16330, Interspeech 2025, 68 saat Kurmancî korpus).
///
/// Mimari:
/// 1. Client mikrofondan ses kaydeder (`audio_service` veya web API)
/// 2. Ses WAV/MP3 byte array'i bu servise gelir
/// 3. HF Inference API'a POST edilir
/// 4. Transcript + telaffuz skoru döndürülür
///
/// **Feature flag**: `AppConfig.enableKurmanciAsr`.
/// **Çocuk modu**: `AppConfig.allowCloudAsrInChildMode = false`
/// (COPPA — voiceprint biyometrik veri).
///
/// TODO (next sprint): HF API key env'den, cevap parse'ı (word timestamps).

class AsrResult {
  final String transcript;       // Tanınan metin
  final double confidence;        // 0.0 - 1.0
  final double? pronunciationScore; // Hedef metinle benzerlik
  final bool success;
  final String? errorMessage;

  const AsrResult({
    required this.transcript,
    required this.confidence,
    this.pronunciationScore,
    this.success = true,
    this.errorMessage,
  });

  factory AsrResult.error(String message) => AsrResult(
        transcript: '',
        confidence: 0.0,
        success: false,
        errorMessage: message,
      );
}

abstract class KurmanciAsrService {
  /// Ses byte array'inden Kurmancî metne dönüştür.
  Future<AsrResult> transcribe(Uint8List audioBytes);

  /// Hedef metinle karşılaştırıp telaffuz skoru ver.
  Future<AsrResult> score({
    required Uint8List audioBytes,
    required String targetText,
  });

  bool get isAvailable;
}

/// No-op / disabled implementation — varsayılan.
/// Feature flag kapalıyken veya Kurmancî ASR hazır olmadığında döner.
class DisabledKurmanciAsrService extends KurmanciAsrService {
  @override
  bool get isAvailable => false;

  @override
  Future<AsrResult> transcribe(Uint8List audioBytes) async {
    return AsrResult.error(
        'Kurmancî ASR henüz aktif değil. AppConfig.enableKurmanciAsr ile aç.');
  }

  @override
  Future<AsrResult> score({
    required Uint8List audioBytes,
    required String targetText,
  }) async {
    return AsrResult.error('Telaffuz skoru henüz aktif değil.');
  }
}

/// HuggingFace Inference API implementation.
/// Gerçek entegrasyon için `http` paketi + API key gerekir.
class HuggingFaceKurmanciAsrService extends KurmanciAsrService {
  final String apiKey;
  final String endpoint;

  HuggingFaceKurmanciAsrService({
    required this.apiKey,
    this.endpoint = AppConfig.whisperKurmanciEndpoint,
  });

  @override
  bool get isAvailable => apiKey.isNotEmpty && AppConfig.enableKurmanciAsr;

  @override
  Future<AsrResult> transcribe(Uint8List audioBytes) async {
    if (!isAvailable) {
      return AsrResult.error('ASR devre dışı');
    }

    // TODO: Gerçek HTTP POST → HF Inference API
    //   final response = await http.post(
    //     Uri.parse(endpoint),
    //     headers: {'Authorization': 'Bearer $apiKey'},
    //     body: audioBytes,
    //   );
    //   final json = jsonDecode(response.body);
    //   return AsrResult(
    //     transcript: json['text'] as String,
    //     confidence: 1.0,
    //   );
    if (kDebugMode) {
      debugPrint('Kurmancî ASR: ${audioBytes.length} bytes (stub)');
    }
    return AsrResult.error('HF ASR entegrasyonu next sprint');
  }

  @override
  Future<AsrResult> score({
    required Uint8List audioBytes,
    required String targetText,
  }) async {
    final result = await transcribe(audioBytes);
    if (!result.success) return result;

    // Basit Levenshtein benzerliği (hedef metinle)
    final similarity = _levenshteinSimilarity(
        result.transcript.toLowerCase(), targetText.toLowerCase());

    return AsrResult(
      transcript: result.transcript,
      confidence: result.confidence,
      pronunciationScore: similarity,
    );
  }

  static double _levenshteinSimilarity(String a, String b) {
    final d = _levenshtein(a, b);
    final maxLen = a.length > b.length ? a.length : b.length;
    if (maxLen == 0) return 1.0;
    return 1.0 - (d / maxLen);
  }

  static int _levenshtein(String a, String b) {
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;
    final m = List.generate(a.length + 1,
        (_) => List.filled(b.length + 1, 0));
    for (int i = 0; i <= a.length; i++) m[i][0] = i;
    for (int j = 0; j <= b.length; j++) m[0][j] = j;
    for (int i = 1; i <= a.length; i++) {
      for (int j = 1; j <= b.length; j++) {
        final cost = a[i - 1] == b[j - 1] ? 0 : 1;
        m[i][j] = [
          m[i - 1][j] + 1,
          m[i][j - 1] + 1,
          m[i - 1][j - 1] + cost,
        ].reduce((x, y) => x < y ? x : y);
      }
    }
    return m[a.length][b.length];
  }
}

/// Factory — feature flag'a göre doğru implementasyonu döndürür.
KurmanciAsrService createKurmanciAsrService({String? apiKey}) {
  if (!AppConfig.enableKurmanciAsr || apiKey == null || apiKey.isEmpty) {
    return DisabledKurmanciAsrService();
  }
  return HuggingFaceKurmanciAsrService(apiKey: apiKey);
}
