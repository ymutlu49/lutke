import 'package:flutter/foundation.dart';
import '../../core/services/js_eval_stub.dart'
    if (dart.library.html) '../../core/services/js_eval_web.dart' as js_bridge;

/// Web Speech API (SpeechRecognition) kullanarak kullanıcının
/// konuşmasını tanır ve metne dönüştürür.
///
/// Chrome/Edge: tam destek
/// Firefox: kısmi
/// Safari: iOS 14.5+
///
/// Offline değil — Google Cloud Speech API'ye istek gider.
class SpeechRecognitionService {
  static bool _isListening = false;
  static String _lastResult = '';

  /// Tarayıcı desteği var mı kontrol et.
  static bool get isSupported {
    if (!kIsWeb) return false;
    // Gerçek kontrol JS'de yapılır; burada web olduğunu varsay
    return true;
  }

  /// Dinlemeyi başlat.
  /// [language]: 'en-US', 'ku-KU' (Kurmancî için 'tr-TR' yakın fallback)
  /// [onResult]: transcript geldiğinde çağrılır
  /// [onError]: hata
  static void start({
    required String language,
    required void Function(String transcript) onResult,
    required void Function(String error) onError,
  }) {
    if (!kIsWeb) {
      onError('Speech recognition sadece web\'de çalışır');
      return;
    }
    if (_isListening) stop();

    // Global callback hook via JS bridge
    // We use a simple polling approach: store result in window._lutkeSpeech
    _lastResult = '';
    _isListening = true;

    js_bridge.evalJs('''
      (function() {
        try {
          var SR = window.SpeechRecognition || window.webkitSpeechRecognition;
          if (!SR) {
            window._lutkeSpeechError = 'Tarayıcı desteklemiyor';
            return;
          }
          if (window._lutkeRecognition) {
            try { window._lutkeRecognition.stop(); } catch(e) {}
          }
          window._lutkeSpeechResult = '';
          window._lutkeSpeechError = '';
          window._lutkeSpeechDone = false;
          var r = new SR();
          r.lang = '$language';
          r.continuous = false;
          r.interimResults = false;
          r.maxAlternatives = 3;
          r.onresult = function(e) {
            var t = e.results[0][0].transcript;
            window._lutkeSpeechResult = t;
            window._lutkeSpeechDone = true;
          };
          r.onerror = function(e) {
            window._lutkeSpeechError = e.error || 'unknown';
            window._lutkeSpeechDone = true;
          };
          r.onend = function() {
            window._lutkeSpeechDone = true;
          };
          window._lutkeRecognition = r;
          r.start();
        } catch (e) {
          window._lutkeSpeechError = String(e);
          window._lutkeSpeechDone = true;
        }
      })();
    ''');

    // Polling for result (max 10s)
    _pollResult(onResult, onError, 0);
  }

  static void _pollResult(
    void Function(String) onResult,
    void Function(String) onError,
    int elapsedMs,
  ) {
    if (!_isListening) return;
    if (elapsedMs > 15000) {
      _isListening = false;
      onError('Zeman qediya (timeout)');
      return;
    }
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!_isListening) return;
      // Check window._lutkeSpeechDone
      final script = '''
        (function() {
          return JSON.stringify({
            done: !!window._lutkeSpeechDone,
            result: window._lutkeSpeechResult || '',
            error: window._lutkeSpeechError || ''
          });
        })()
      ''';
      try {
        final raw = js_bridge.evalJsSync(script);
        if (raw != null && raw.toString().contains('"done":true')) {
          _isListening = false;
          final err = RegExp(r'"error":"([^"]*)"').firstMatch(raw.toString());
          if (err != null && err.group(1)!.isNotEmpty) {
            onError(err.group(1)!);
            return;
          }
          final res = RegExp(r'"result":"([^"]*)"').firstMatch(raw.toString());
          onResult(res?.group(1) ?? '');
          return;
        }
      } catch (_) {}
      _pollResult(onResult, onError, elapsedMs + 300);
    });
  }

  static void stop() {
    if (!kIsWeb) return;
    _isListening = false;
    js_bridge.evalJs('''
      (function() {
        try { if (window._lutkeRecognition) window._lutkeRecognition.stop(); } catch(e) {}
      })();
    ''');
  }

  /// İki metnin ne kadar benzediğini (0.0-1.0) döner.
  static double similarity(String a, String b) {
    a = a.toLowerCase().trim();
    b = b.toLowerCase().trim();
    if (a == b) return 1.0;
    if (a.isEmpty || b.isEmpty) return 0.0;
    final dist = _levenshtein(a, b);
    final maxLen = a.length > b.length ? a.length : b.length;
    return 1.0 - (dist / maxLen);
  }

  static int _levenshtein(String a, String b) {
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;
    final m = a.length;
    final n = b.length;
    final dp = List.generate(m + 1, (_) => List.filled(n + 1, 0));
    for (var i = 0; i <= m; i++) dp[i][0] = i;
    for (var j = 0; j <= n; j++) dp[0][j] = j;
    for (var i = 1; i <= m; i++) {
      for (var j = 1; j <= n; j++) {
        final cost = a[i - 1] == b[j - 1] ? 0 : 1;
        dp[i][j] = [
          dp[i - 1][j] + 1,
          dp[i][j - 1] + 1,
          dp[i - 1][j - 1] + cost,
        ].reduce((v, e) => v < e ? v : e);
      }
    }
    return dp[m][n];
  }
}
