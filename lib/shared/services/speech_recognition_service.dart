import 'package:flutter/foundation.dart';

import '../../core/services/web_speech_session.dart';

/// Web Speech API (SpeechRecognition) kullanarak kullanıcının
/// konuşmasını tanır ve metne dönüştürür.
///
/// Chrome/Edge: tam destek
/// Firefox: kısmi
/// Safari: iOS 14.5+
///
/// Offline değil — Google Cloud Speech API'ye istek gider.
///
/// Ekim 2026: dinleme ortak [WebSpeechSession] motoruna taşındı (sürekli
/// kip + sessizlikte zarif bitiş). Eskiden `continuous = false` idi ve
/// Chrome ilk kısa duraksamada kaydı kesiyordu. Window anahtarı
/// `_lutkeSpeech*` — AsrService'in `_lutkeAsr*` oturumuyla çakışmaz.
class SpeechRecognitionService {
  static final WebSpeechSession _speech = WebSpeechSession('_lutkeSpeech');

  /// Her start() yeni nesil — eski oturumun geç gelen sonucu
  /// yeni oturumun callback'lerine düşmesin.
  static int _generation = 0;

  static bool get isListening => _speech.isActive;

  /// Tarayıcı desteği var mı kontrol et.
  static bool get isSupported {
    if (!kIsWeb) return false;
    // Gerçek kontrol JS'de yapılır; burada web olduğunu varsay
    return true;
  }

  /// Dinlemeyi başlat.
  /// [language]: 'en-US', 'ku-KU' (Kurmancî için 'tr-TR' yakın fallback)
  /// [onResult]: konuşma bitince (sessizlik, [stop] veya zaman bütçesi)
  ///   toplanan metinle BİR KEZ çağrılır
  /// [onError]: hata ('not-allowed', 'no-speech', 'network', 'timeout' …)
  ///
  /// [cancel] ile iptal edilirse hiçbir callback çağrılmaz.
  static void start({
    required String language,
    required void Function(String transcript) onResult,
    required void Function(String error) onError,
    Duration timeout = const Duration(seconds: 15),
  }) {
    if (!kIsWeb) {
      onError("Speech recognition sadece web'de çalışır");
      return;
    }
    final gen = ++_generation;
    _speech
        .listen(language: language, maxAlternatives: 3, timeout: timeout)
        .then((outcome) {
      if (outcome == null || gen != _generation) return; // iptal edildi
      if (outcome.hasSpeech) {
        onResult(outcome.transcript);
      } else if (outcome.error == 'timeout') {
        onError('Zeman qediya (timeout)');
      } else {
        onError(outcome.error.isEmpty ? 'no-speech' : outcome.error);
      }
    });
  }

  /// Dinlemeyi ZARİF bitir: mikrofon kapanır ve o ana kadar söylenenler
  /// [start]'ın `onResult`'ına iletilir (durdur düğmesi için).
  static void stop() {
    if (!kIsWeb) return;
    _speech.stop();
  }

  /// Dinlemeyi iptal et — sonuç atılır, callback çağrılmaz
  /// (ekran kapanırken / dispose'ta kullan).
  static void cancel() {
    if (!kIsWeb) return;
    _generation++;
    _speech.cancel();
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
    for (var i = 0; i <= m; i++) {
      dp[i][0] = i;
    }
    for (var j = 0; j <= n; j++) {
      dp[0][j] = j;
    }
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
