import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// LÛTKE — Kurmancî TTS Servisi
///
/// Strateji (sırasıyla):
/// 1. HuggingFace Gradio API (amedcj/kmr_tts) — Kurmancî'ye özel model
/// 2. Web SpeechSynthesis fallback (Türkçe seslendirici, fonetik yakın)
///
/// Kurmancî Fonetik Notlar:
/// - x → gırtlaktan gelen "h" (velar fricative /x/)
/// - q → kalın gırtlak "k" (uvular stop /q/)
/// - xw → dudak yuvarlak gırtlak h (labialized /xʷ/)
/// - ê → uzun "e" (/eː/)
/// - î → uzun "i" (/iː/)
/// - û → uzun "u" (/uː/)
/// - ç → "ç" (Türkçe ile aynı)
/// - ş → "ş" (Türkçe ile aynı)
/// - j → Fransızca "j" (voiced postalveolar /ʒ/)

enum TtsState { idle, loading, playing, error }

class TtsService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 30),
  ));

  // HuggingFace Gradio endpoint
  static const _hfSpaceUrl = 'https://amedcj-kmr-tts.hf.space';
  static const _gradioApi = '/gradio_api/call/predict';

  TtsState _state = TtsState.idle;
  TtsState get state => _state;

  /// Kurmancî metni seslendir.
  ///
  /// Önce HuggingFace Kurmancî TTS modelini dener,
  /// başarısız olursa Web SpeechSynthesis kullanır.
  Future<String?> synthesize(String text) async {
    if (text.trim().isEmpty) return null;
    _state = TtsState.loading;

    // 1. HuggingFace Gradio API
    try {
      final audioUrl = await _synthesizeHuggingFace(text);
      if (audioUrl != null) {
        _state = TtsState.playing;
        return audioUrl;
      }
    } catch (e) {
      if (kDebugMode) debugPrint('HF TTS error: $e');
    }

    // 2. Web SpeechSynthesis fallback — null döner, JS tarafında çalıştırılır
    _state = TtsState.idle;
    return null; // Caller should use web speech synthesis
  }

  /// HuggingFace Gradio API ile Kurmancî TTS
  Future<String?> _synthesizeHuggingFace(String text) async {
    // Step 1: Submit job
    final submitResponse = await _dio.post(
      '$_hfSpaceUrl$_gradioApi',
      data: jsonEncode({'data': [text]}),
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );

    if (submitResponse.statusCode != 200) return null;

    final eventId = submitResponse.data['event_id'] as String?;
    if (eventId == null) return null;

    // Step 2: Poll for result
    final resultUrl = '$_hfSpaceUrl/gradio_api/call/predict/$eventId';

    for (int i = 0; i < 30; i++) {
      await Future.delayed(const Duration(milliseconds: 500));

      try {
        final resultResponse = await _dio.get(resultUrl);
        final body = resultResponse.data.toString();

        if (body.contains('event: complete')) {
          // Parse the data line
          final lines = body.split('\n');
          for (final line in lines) {
            if (line.startsWith('data:')) {
              final jsonStr = line.substring(5).trim();
              final data = jsonDecode(jsonStr);
              if (data is List && data.isNotEmpty) {
                final audioPath = data[0];
                if (audioPath is Map && audioPath.containsKey('url')) {
                  return audioPath['url'] as String;
                }
                if (audioPath is String) {
                  return '$_hfSpaceUrl/file=$audioPath';
                }
              }
            }
          }
        }

        if (body.contains('event: error')) {
          return null;
        }
      } catch (_) {
        continue;
      }
    }

    return null;
  }

  void reset() {
    _state = TtsState.idle;
  }
}

final ttsServiceProvider = Provider<TtsService>((_) => TtsService());

/// Web SpeechSynthesis — Kurdish-first voice strategy
///
/// Strateji:
/// 1. Önce Kurdish (ku-*) seslendirici aranır
/// 2. Bulunamazsa Türkçe (tr-TR) fallback — Kurmancî'ye fonetik yakın
/// 3. O da yoksa lang='tr-TR' ile varsayılan ses
///
/// Bu fonksiyon web ortamında dart:js_interop ile çağrılır.
String getWebTtsScript(String text) {
  final escaped = text
      .replaceAll("'", "\\'")
      .replaceAll('"', '\\"')
      .replaceAll('\n', ' ');

  return '''
    (function() {
      const u = new SpeechSynthesisUtterance('$escaped');
      const voices = speechSynthesis.getVoices();
      const kurdish = voices.find(v => v.lang.startsWith('ku'));
      const turkish = voices.find(v => v.lang.startsWith('tr'));
      if (kurdish) {
        u.voice = kurdish;
        u.lang = kurdish.lang;
      } else if (turkish) {
        u.voice = turkish;
        u.lang = 'tr-TR';
      } else {
        u.lang = 'tr-TR';
      }
      u.rate = 0.82;
      u.pitch = 1.0;
      speechSynthesis.cancel();
      speechSynthesis.speak(u);
    })();
  ''';
}

/// Yavaş seslendirme — öğrenci için ekstra yavaş tempo
///
/// Dinleme alıştırmalarında "yavaş mod" için kullanılır.
/// rate: 0.6 — belirgin şekilde yavaş, heceler duyulabilir.
String getWebTtsScriptSlow(String text) {
  final escaped = text
      .replaceAll("'", "\\'")
      .replaceAll('"', '\\"')
      .replaceAll('\n', ' ');

  return '''
    (function() {
      const u = new SpeechSynthesisUtterance('$escaped');
      const voices = speechSynthesis.getVoices();
      const kurdish = voices.find(v => v.lang.startsWith('ku'));
      const turkish = voices.find(v => v.lang.startsWith('tr'));
      if (kurdish) {
        u.voice = kurdish;
        u.lang = kurdish.lang;
      } else if (turkish) {
        u.voice = turkish;
        u.lang = 'tr-TR';
      } else {
        u.lang = 'tr-TR';
      }
      u.rate = 0.6;
      u.pitch = 1.0;
      speechSynthesis.cancel();
      speechSynthesis.speak(u);
    })();
  ''';
}
