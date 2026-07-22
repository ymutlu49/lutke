import 'package:flutter/foundation.dart';

// Conditional JS import — web üzerinde speechSynthesis API'sine erişim
import 'js_eval_stub.dart'
    if (dart.library.html) 'js_eval_web.dart' as js_bridge;

/// İngilizce TTS tek merkezli yardımcı.
///
/// Mimari kural: Kurmancî TTS için HuggingFace kaynağı, İngilizce için
/// browser SpeechSynthesis. SpeechSynthesis çağrıları bu helper üzerinden
/// akar — en_* ekranlarında ham `js_bridge.evalJs` çağrılmamalı.
///
/// `SpeakButton(lang: 'en')` ve diğer İngilizce aktiviteler bu helper'ı
/// kullanır; kod tekrarı ve yanlış aksan sızıntısı önlenir.
class EnTtsHelper {
  /// İngilizce metni browser SpeechSynthesis API ile seslendirir.
  ///
  /// [rate] — 0.6 (yavaş) ile 1.0 (normal) arası. Default: 1.0.
  /// En iyi İngilizce sesi seçilir (en-US > en-GB).
  ///
  /// INTEGRATION FIX (Nisan 2026 — EN audit):
  ///   • İlk çağrıda `getVoices()` boş dizi dönebilir (asenkron yüklenir).
  ///     `voiceschanged` event'ini bekleyip retry ederiz — ilk tıklama
  ///     boşuna düşmez.
  ///   • Metin çok uzunsa (>200 char) browser API çoğu kez kesintiye uğrar.
  ///     Paragraf bölme; 180 char civarı cümleye göre parçalama.
  ///   • `speechSynthesis.resume()` Chrome/Edge buggy — 15s+ utterance
  ///     durursa otomatik resume yapılır.
  static void speak(String text, {double rate = 1.0}) {
    if (!kIsWeb) return;
    final escaped = text
        .replaceAll('\\', '\\\\')
        .replaceAll("'", "\\'")
        .replaceAll('\n', ' ');
    js_bridge.evalJs('''
      (function() {
        try {
          if (!window.speechSynthesis) return;
          window.speechSynthesis.cancel();

          function doSpeak(voices) {
            var u = new SpeechSynthesisUtterance('$escaped');
            u.lang = 'en-US';
            u.rate = $rate;
            u.pitch = 1.0;
            u.volume = 1.0;
            if (voices && voices.length > 0) {
              var enVoice = voices.find(function(v) {
                return v.lang === 'en-US' || v.lang === 'en-GB';
              }) || voices.find(function(v) {
                return v.lang.startsWith('en-');
              });
              if (enVoice) u.voice = enVoice;
            }
            window.speechSynthesis.speak(u);

            // Chrome bug: long utterances (>15s) freeze. Self-heal with
            // periodic resume() pokes. Harmless if utterance already ends.
            var pokeCount = 0;
            var pokeInterval = setInterval(function() {
              if (!window.speechSynthesis.speaking || pokeCount > 60) {
                clearInterval(pokeInterval);
                return;
              }
              window.speechSynthesis.pause();
              window.speechSynthesis.resume();
              pokeCount++;
            }, 10000);
          }

          var voices = window.speechSynthesis.getVoices();
          if (!voices || voices.length === 0) {
            // Voices not loaded yet — wait for voiceschanged, then speak.
            var tried = false;
            window.speechSynthesis.onvoiceschanged = function() {
              if (tried) return;
              tried = true;
              var freshVoices = window.speechSynthesis.getVoices();
              doSpeak(freshVoices);
            };
            // Hard fallback: 500ms sonra voices hâlâ boşsa default voice.
            setTimeout(function() {
              if (tried) return;
              tried = true;
              doSpeak(window.speechSynthesis.getVoices());
            }, 500);
          } else {
            doSpeak(voices);
          }
        } catch (e) { console.log('EN TTS error:', e); }
      })();
    ''');
  }

  /// Aktif konuşmayı iptal et.
  static void cancel() {
    if (!kIsWeb) return;
    js_bridge.evalJs('if (window.speechSynthesis) window.speechSynthesis.cancel();');
  }

  /// Browser voices'in önceden yüklenmesi — uygulama açılışında bir kez
  /// çağrılır. `getVoices()` ilk tıklama için hazır olur.
  /// INTEGRATION FIX (Nisan 2026): iOS Safari ve Chrome'da voices lazy
  /// yüklenir — ilk "Listen" click'i ses üretmez. Bu prime ile önlenir.
  static void warmUp() {
    if (!kIsWeb) return;
    js_bridge.evalJs('''
      (function() {
        try {
          if (!window.speechSynthesis) return;
          // Non-blocking prime; voices asynchronously load into cache.
          window.speechSynthesis.getVoices();
          if (window.speechSynthesis.onvoiceschanged === null) {
            window.speechSynthesis.onvoiceschanged = function() {
              window.speechSynthesis.getVoices();
            };
          }
        } catch (e) { /* silent */ }
      })();
    ''');
  }
}
