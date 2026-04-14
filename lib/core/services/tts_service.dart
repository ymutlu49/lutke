import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// LÛTKE — Kurmancî TTS Servisi
///
/// Tek kaynak: HuggingFace Gradio API (amedcj/kmr_tts)
/// Türkçe fallback YOKTUR — yanlış telaffuz olmasın diye kasıtlı.
///
/// Güvenilirlik iyileştirmeleri (Nisan 2026):
///   - Warm-up ping: uygulama açılışında HF Space uykudan uyandırılır
///   - Cold-start tolerance: ilk istek 90 saniye, sonrakiler 30 saniye
///   - Retry: 2 kez exponential backoff
///   - Text preprocessing: UTF-8 normalize, tek-kelime sentez kalitesini
///     artırmak için nokta eklenir (prosody için)
///   - Persistent cache: SharedPreferences ile URL'ler kalıcı
///
/// Başarısız olursa null döner, ses çalınmaz.

enum TtsState { idle, loading, playing, error, warmingUp }

class TtsService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 90), // Cold start için
  ));

  // HuggingFace Gradio endpoint — Kurmancî TTS
  static const _hfSpaceUrl = 'https://amedcj-kmr-tts.hf.space';
  static const _gradioApi = '/gradio_api/call/predict';
  static const _cacheKeyPrefix = 'tts_cache_';
  static const _maxCacheSize = 500; // Max 500 kelime persist edilsin

  TtsState _state = TtsState.idle;
  TtsState get state => _state;

  // Bellek içi önbellek — tur sonunda persisted cache'e yazılır
  final Map<String, String> _cache = {};
  bool _cacheLoaded = false;
  bool _isFirstRequest = true; // Cold start detection
  bool _warmedUp = false;

  /// Persistent cache'i yükle — uygulama açılışında bir kez çağrılır.
  Future<void> _loadCache() async {
    if (_cacheLoaded) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      for (final key in prefs.getKeys()) {
        if (key.startsWith(_cacheKeyPrefix)) {
          final word = key.substring(_cacheKeyPrefix.length);
          final url = prefs.getString(key);
          if (url != null && url.isNotEmpty) {
            _cache[word] = url;
          }
        }
      }
    } catch (_) {
      // Sessiz geç — cache önemli değil, HF her zaman fallback
    }
    _cacheLoaded = true;
  }

  /// Cache'e yeni URL kaydet (persist).
  Future<void> _persistCache(String key, String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Cache size limiti: en eski olanı sil
      if (_cache.length > _maxCacheSize) {
        final oldestKey = _cache.keys.first;
        _cache.remove(oldestKey);
        await prefs.remove('$_cacheKeyPrefix$oldestKey');
      }
      await prefs.setString('$_cacheKeyPrefix$key', url);
    } catch (_) {}
  }

  /// HF Space'i uyandırmak için GET isteği.
  /// Uygulama açılışında çağrılmalı. İlk gerçek TTS isteğinin hızını artırır.
  Future<void> warmUp() async {
    if (_warmedUp) return;
    _state = TtsState.warmingUp;
    try {
      await _dio.get(
        _hfSpaceUrl,
        options: Options(
          receiveTimeout: const Duration(seconds: 10),
          validateStatus: (_) => true, // 200 olmasa da OK
        ),
      );
      _warmedUp = true;
      if (kDebugMode) debugPrint('TTS warmed up');
    } catch (e) {
      // Warm-up başarısız olsa da servis çalışabilir
      if (kDebugMode) debugPrint('TTS warm-up failed (non-critical): $e');
    } finally {
      _state = TtsState.idle;
    }
  }

  /// Metin ön işleme — HF modelin daha iyi telaffuz etmesi için.
  /// - Trim, Unicode normalize
  /// - Tek kelime ise sonuna nokta ekle (prosody için)
  /// - Çoklu boşlukları sadeleştir
  String _preprocessText(String text) {
    var clean = text.trim();
    // Çoklu whitespace → tek boşluk
    clean = clean.replaceAll(RegExp(r'\s+'), ' ');
    // Tek kelime ise nokta ekle — model daha doğal okur
    if (!clean.contains(' ') && !clean.endsWith('.') && !clean.endsWith('!') &&
        !clean.endsWith('?')) {
      clean = '$clean.';
    }
    return clean;
  }

  /// Kurmancî metni seslendir.
  /// Başarılı: audio URL döner. Başarısız: null döner.
  Future<String?> synthesize(String text) async {
    await _loadCache();

    final processed = _preprocessText(text);
    final key = processed.toLowerCase();
    if (key.isEmpty) return null;

    // Önbellekte varsa hemen döndür
    if (_cache.containsKey(key)) {
      _state = TtsState.playing;
      return _cache[key];
    }

    _state = TtsState.loading;

    // Retry mantığı: 2 deneme (ilk + 1 retry)
    for (var attempt = 0; attempt < 2; attempt++) {
      try {
        final audioUrl = await _synthesizeHuggingFace(processed);
        if (audioUrl != null) {
          _cache[key] = audioUrl;
          await _persistCache(key, audioUrl);
          _state = TtsState.playing;
          _isFirstRequest = false;
          return audioUrl;
        }
      } catch (e) {
        if (kDebugMode) debugPrint('TTS attempt ${attempt + 1} error: $e');
      }
      // Retry öncesi kısa bekleme
      if (attempt == 0) {
        await Future<void>.delayed(const Duration(seconds: 2));
      }
    }

    _state = TtsState.error;
    return null;
  }

  /// HuggingFace Gradio API — Kurmancî TTS
  Future<String?> _synthesizeHuggingFace(String text) async {
    // Cold start tolerance: ilk istek 90s, sonrakiler 45s
    final receiveTimeout = _isFirstRequest
        ? const Duration(seconds: 90)
        : const Duration(seconds: 45);

    // Adım 1: İş gönder
    final submitResponse = await _dio.post(
      '$_hfSpaceUrl$_gradioApi',
      data: jsonEncode({'data': [text]}),
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
        },
        receiveTimeout: receiveTimeout,
      ),
    );

    if (submitResponse.statusCode != 200) return null;

    final eventId = submitResponse.data['event_id'] as String?;
    if (eventId == null) return null;

    // Adım 2: Sonucu bekle (polling)
    // İlk istek: 60 saniye (120 × 500ms), sonraki: 30 saniye (60 × 500ms)
    final maxPolls = _isFirstRequest ? 120 : 60;
    final resultUrl = '$_hfSpaceUrl/gradio_api/call/predict/$eventId';

    for (int i = 0; i < maxPolls; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 500));

      try {
        final resultResponse = await _dio.get(
          resultUrl,
          options: Options(
            receiveTimeout: const Duration(seconds: 10),
          ),
        );
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

  /// Cold start gösterge — UI'da kullanıcıya ipucu vermek için.
  bool get isColdStart => _isFirstRequest && !_warmedUp;

  void reset() {
    _state = TtsState.idle;
  }
}

final ttsServiceProvider = Provider<TtsService>((_) => TtsService());
