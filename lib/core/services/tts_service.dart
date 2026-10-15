import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_config.dart';
import 'ses_manifest.dart';
import 'tts_asset_manifest.dart';

/// LÛTKE — Kurmancî TTS Servisi
///
/// Tek kaynak: HuggingFace Gradio API (amedcj/kmr_tts)
/// Türkçe fallback YOKTUR — yanlış telaffuz olmasın diye kasıtlı.
///
/// Güvenilirlik iyileştirmeleri (Nisan 2026):
///   - Warm-up ping: uygulama açılışında HF Space uykudan uyandırılır
///   - Cold-start tolerance: ilk istek 90 saniye, sonrakiler 30 saniye
///   - Retry: 3 deneme, exponential backoff (1s, 2s, 4s) — 503/timeout için
///   - Text preprocessing: UTF-8 normalize, tek-kelime sentez kalitesini
///     artırmak için nokta eklenir (prosody için)
///   - Persistent cache: SharedPreferences ile URL'ler kalıcı
///   - Hard timeout: tüm HTTP çağrıları üst sınıra bağlıdır
///   - Error telemetry: debug modda HTTP fail sebebi + path loglanır
///
/// Başarısız olursa null döner, ses çalınmaz.

enum TtsState { idle, loading, playing, error, warmingUp }

class TtsService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 90), // Cold start için
  ));

  // Kurmancî TTS endpoint'leri — kaynak seçimine göre dispatch
  static const _hfClassicUrl = 'https://amedcj-kmr-tts.hf.space';
  static const _hfClassicApi = '/gradio_api/call/text_to_speech';
  // Gemini 2.5 Flash — Fenrir voice (derin Kurmancî erkek ses)
  static const _geminiSpaceUrl = 'https://amedcj-gemini-tts.hf.space';
  static const _geminiApi = '/gradio_api/call/gemini_tts_kurmanji';

  // Hangi endpoint aktif — `source` tarafından belirlenir.
  // SADECE `geminiFenrir` seçilince Gemini space'e gider.
  // Varsayılan ve diğer tüm durumlarda klasik amedcj/kmr_tts kullanılır
  // (asset'leri üreten aynı model — orijinal Kurmancî erkek sesi).
  String get _hfSpaceUrl => source == KurmanciTtsSource.geminiFenrir
      ? _geminiSpaceUrl : _hfClassicUrl;
  String get _gradioApi => source == KurmanciTtsSource.geminiFenrir
      ? _geminiApi : _hfClassicApi;

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

  /// HF Space(ler)'i uyandırmak için GET isteği.
  /// Uygulama açılışında çağrılmalı — hem Gemini hem klasik space'i paralel uyandır.
  Future<void> warmUp() async {
    if (_warmedUp) return;
    // Varsayılan yol kendi seslerimizi (SesManifest) kullanır; dış servisi uyandırmaya gerek yok.
    if (source == KurmanciTtsSource.assetFirst ||
        source == KurmanciTtsSource.assetOnly) {
      _warmedUp = true;
      return;
    }
    _state = TtsState.warmingUp;
    try {
      // Her iki space'e paralel uyandırma isteği — kullanıcı hangisini
      // seçerse seçsin hazır olsun.
      await Future.wait([
        _dio.get(_geminiSpaceUrl,
            options: Options(
              receiveTimeout: const Duration(seconds: 10),
              validateStatus: (_) => true,
            )),
        _dio.get(_hfClassicUrl,
            options: Options(
              receiveTimeout: const Duration(seconds: 10),
              validateStatus: (_) => true,
            )),
      ]);
      _warmedUp = true;
      if (kDebugMode) debugPrint('TTS warmed up (both spaces)');
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
  ///
  /// Öncelik sırası:
  ///   1. Asset manifest (ön-üretilmiş MP3) → 0ms, çevrimdışı
  ///   2. SharedPreferences cache (HF URL) → anında
  ///   3. HuggingFace API → 2-90s (cold start'a göre)
  /// TTS kaynak tercihi — sabit varsayılan: assetFirst.
  /// Bu ayar orijinal Kurmancî "gırtlak erkek" sesini (önceden üretilmiş
  /// asset'leri) kullanır. Yetişkin + çocuk mod aynı ses akışını paylaşır.
  /// Değişiklik için: Profîl > Mîheng > Dengê Kurmancî.
  KurmanciTtsSource source = KurmanciTtsSource.assetFirst;

  Future<String?> synthesize(String text) async {
    final processed = _preprocessText(text);
    final key = processed.toLowerCase();
    if (key.isEmpty) return null;

    // 0) Jimaro ses fabrikası (Ziman/ses/fabrika) — kendi ürettiğimiz sesler,
    //    Cloudflare R2'den. Dış servise bağımlı değil; varsayılan yolun ilk adımı.
    if (source == KurmanciTtsSource.assetFirst ||
        source == KurmanciTtsSource.assetOnly) {
      final sesUrl = SesManifest.url(processed);
      if (sesUrl != null) {
        _state = TtsState.playing;
        return sesUrl;
      }
    }

    // 1) Asset manifest — ön üretilmiş ses (0ms, orijinal kalite)
    // `huggingface` kaynağı seçilirse atla; asset'leri hiç kullanma.
    if (source != KurmanciTtsSource.huggingface) {
      final stripped = key.replaceAll(RegExp(r'[.,!?]+$'), '').trim();
      final assetPath = TtsAssetManifest.lookup(stripped) ??
          TtsAssetManifest.lookup(key);
      if (assetPath != null) {
        _state = TtsState.playing;
        if (kIsWeb) return 'asset:$assetPath';
        // Mobil paket boyutu: assets/audio/words APK/AAB'ye GÖMÜLMEZ
        // (1.3GB). Aynı dosyalar canlıdan çalınır (dist/app kopyası).
        return 'https://lutke.app/app/assets/$assetPath';
      }
    }

    // assetOnly kaynağı: HF çağırma, sessiz geç.
    if (source == KurmanciTtsSource.assetOnly) {
      _state = TtsState.error;
      return null;
    }
    // geminiFenrir + huggingface için HF Space çağrısı yapılır (endpoint farklı).
    // assetFirst için asset bulunamazsa HF (gemini default) çağrılır.

    await _loadCache();

    // 2) SharedPreferences cache
    if (_cache.containsKey(key)) {
      _state = TtsState.playing;
      return _cache[key];
    }

    _state = TtsState.loading;

    // 3) HuggingFace — 3 deneme, exponential backoff (1s, 2s, 4s)
    // HF Space cold start'ta 503 döner; retry ile atlanabilir.
    // Timeout veya network hatası da retry tetikler.
    const maxAttempts = 3;
    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      try {
        final audioUrl = await _synthesizeHuggingFace(processed);
        if (audioUrl != null) {
          _cache[key] = audioUrl;
          await _persistCache(key, audioUrl);
          _state = TtsState.playing;
          _isFirstRequest = false;
          return audioUrl;
        }
        // Null = submit 200'du ama event yok/error; retry yararsız
        if (kDebugMode) {
          debugPrint('TTS attempt ${attempt + 1}: no audioUrl (event error?)');
        }
        break;
      } on DioException catch (e) {
        // 503 = HF cold start → retry-friendly
        // timeout/connectionError → retry-friendly
        final status = e.response?.statusCode;
        final retryable = status == 503 ||
            status == 502 ||
            status == 504 ||
            e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.connectionError;
        if (kDebugMode) {
          debugPrint('TTS attempt ${attempt + 1} DioException '
              '(${e.type}, status=$status, path=${e.requestOptions.path}) — '
              'retryable=$retryable');
        }
        if (!retryable) break;
      } catch (e) {
        if (kDebugMode) debugPrint('TTS attempt ${attempt + 1} error: $e');
      }
      // Exponential backoff: 1s, 2s, 4s — son denemeden sonra bekleme
      if (attempt < maxAttempts - 1) {
        final waitMs = 1000 * (1 << attempt); // 1000, 2000, 4000
        await Future<void>.delayed(Duration(milliseconds: waitMs));
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

    // Adım 1: İş gönder — hem connect hem receive timeout zorunlu
    final submitResponse = await _dio.post(
      '$_hfSpaceUrl$_gradioApi',
      data: jsonEncode({'data': [text]}),
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
        },
        receiveTimeout: receiveTimeout,
        sendTimeout: const Duration(seconds: 15),
        // 503 submit döndürebilir — retry layer tetiklenmeli (exception fırlat)
        validateStatus: (s) => s != null && s >= 200 && s < 300,
      ),
    );

    if (submitResponse.statusCode != 200) {
      if (kDebugMode) {
        debugPrint(
          'TTS submit failed: status=${submitResponse.statusCode} path=$_gradioApi',
        );
      }
      return null;
    }

    final eventId = submitResponse.data['event_id'] as String?;
    if (eventId == null) {
      if (kDebugMode) {
        debugPrint('TTS submit: no event_id in response body');
      }
      return null;
    }

    // Adım 2: Sonucu bekle (polling)
    // İlk istek: 60 saniye (120 × 500ms), sonraki: 30 saniye (60 × 500ms)
    final maxPolls = _isFirstRequest ? 120 : 60;
    final resultUrl = '$_hfSpaceUrl/gradio_api/call/text_to_speech/$eventId';

    for (int i = 0; i < maxPolls; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 500));

      try {
        final resultResponse = await _dio.get(
          resultUrl,
          options: Options(
            receiveTimeout: const Duration(seconds: 10),
            sendTimeout: const Duration(seconds: 10),
            // Polling sırasında geçici 503 tolere et — continue
            validateStatus: (_) => true,
          ),
        );
        if (resultResponse.statusCode != null &&
            resultResponse.statusCode! >= 500) {
          if (kDebugMode) {
            debugPrint('TTS poll $i: HTTP ${resultResponse.statusCode}');
          }
          continue;
        }
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

        if (body.contains('event: error')) {
          if (kDebugMode) debugPrint('TTS poll: event: error');
          return null;
        }
      } catch (e) {
        // Tek bir poll başarısız — diğerlerine devam et
        if (kDebugMode && i % 20 == 0) {
          debugPrint('TTS poll $i exception: $e');
        }
        continue;
      }
    }

    if (kDebugMode) debugPrint('TTS: polling timed out after $maxPolls tries');
    return null;
  }

  /// Cold start gösterge — UI'da kullanıcıya ipucu vermek için.
  bool get isColdStart => _isFirstRequest && !_warmedUp;

  void reset() {
    _state = TtsState.idle;
  }

  /// Kurmancî TTS cache'ini tamamen sil — kullanıcı "ses kötü" dediğinde
  /// asset-only path'e düşebilmek için HF cache'ini temizler.
  Future<void> clearCache() async {
    _cache.clear();
    _cacheLoaded = false;
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys()
          .where((k) => k.startsWith(_cacheKeyPrefix))
          .toList();
      for (final k in keys) {
        await prefs.remove(k);
      }
    } catch (_) {}
  }

  /// Cache boyutunu döndürür (UI için).
  int get cacheSize => _cache.length;
}

final ttsServiceProvider = Provider<TtsService>((_) => TtsService());
