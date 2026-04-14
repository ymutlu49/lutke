import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// LÛTKE — Kurmancî TTS Servisi
///
/// Tek kaynak: HuggingFace Gradio API (amedcj/kmr_tts)
/// Türkçe fallback YOKTUR — yanlış telaffuz olmasın diye kasıtlı.
/// Başarısız olursa null döner, ses çalınmaz.

enum TtsState { idle, loading, playing, error }

class TtsService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 45),
  ));

  // HuggingFace Gradio endpoint — Kurmancî TTS
  static const _hfSpaceUrl = 'https://amedcj-kmr-tts.hf.space';
  static const _gradioApi = '/gradio_api/call/predict';

  TtsState _state = TtsState.idle;
  TtsState get state => _state;

  // Basit önbellek — aynı kelimeyi tekrar sentezlemek gereksiz
  final Map<String, String> _cache = {};

  /// Kurmancî metni seslendir.
  /// Başarılı: audio URL döner. Başarısız: null döner.
  Future<String?> synthesize(String text) async {
    final key = text.trim().toLowerCase();
    if (key.isEmpty) return null;

    // Önbellekte varsa hemen döndür
    if (_cache.containsKey(key)) {
      _state = TtsState.playing;
      return _cache[key];
    }

    _state = TtsState.loading;

    try {
      final audioUrl = await _synthesizeHuggingFace(text);
      if (audioUrl != null) {
        _cache[key] = audioUrl; // Önbelleğe ekle
        _state = TtsState.playing;
        return audioUrl;
      }
    } catch (e) {
      if (kDebugMode) debugPrint('TTS error: $e');
    }

    _state = TtsState.error;
    return null;
  }

  /// HuggingFace Gradio API — Kurmancî TTS
  Future<String?> _synthesizeHuggingFace(String text) async {
    // Adım 1: İş gönder
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

    // Adım 2: Sonucu bekle (polling)
    final resultUrl = '$_hfSpaceUrl/gradio_api/call/predict/$eventId';

    for (int i = 0; i < 40; i++) {
      await Future.delayed(const Duration(milliseconds: 500));

      try {
        final resultResponse = await _dio.get(resultUrl);
        final body = resultResponse.data.toString();

        if (body.contains('event: complete')) {
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

        if (body.contains('event: error')) return null;
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
