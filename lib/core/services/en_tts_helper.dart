import 'dart:convert';

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
///
/// NOT (Ekim 2026): Yalnızca web'de ses üretir. Android uygulamasında
/// İngilizce TTS yolu henüz yok (flutter_tts eklenmedi) — `speak` orada
/// sessizce hiçbir şey yapmaz.
class EnTtsHelper {
  EnTtsHelper._();

  /// Normal hızda bir parçanın en fazla karakter sayısı. Chrome'un uzak
  /// ("Google US English") sesleri ~15 sn'yi aşan utterance'ı yarıda
  /// keser; ~160 karakter normal hızda ~10 sn'dir.
  static const int defaultMaxChunk = 160;

  /// Yavaş hızda (rate < 0.8) parça sınırı — aynı süre bütçesi için kısa.
  static const int slowMaxChunk = 110;

  /// İngilizce metni browser SpeechSynthesis API ile seslendirir.
  ///
  /// [rate] — 0.6 (yavaş) ile 1.0 (normal) arası. Default: 1.0.
  /// Yerel (cihaz üstü) en-US / en-GB ses tercih edilir.
  ///
  /// "METİN YARIDA KESİLİYOR" FIX (Ekim 2026):
  ///   • Metin Dart'ta cümle boyu parçalara bölünür ([chunkText]) ve JS'de
  ///     SIRALI bir kuyrukla okunur (bir parça bitince sonraki). Tek dev
  ///     utterance Chrome'da ~15 sn'de kesiliyordu.
  ///   • Tüm utterance'lar okuma bitene dek `window._lutkeEnTts.queue`
  ///     dizisinde tutulur — Chrome yerel değişkendeki utterance'ı çöpe
  ///     toplayıp `onend`'i hiç ateşlemeden konuşmayı bitirebiliyordu.
  ///   • Eski "10 sn'de bir pause()/resume()" dürtmesi kaldırıldı: Android
  ///     Chrome'da konuşmayı kalıcı olarak durdurabiliyordu.
  ///   • Yerel (`localService`) ses tercih edilir — uzak seslerdeki süre
  ///     sınırı ve ağ kesintisi riski yok.
  ///   • İlk çağrıda `getVoices()` boş dönebilir — `voiceschanged` (en çok
  ///     500 ms) beklenir; ilk tıklama boşa düşmez.
  ///   • `onend` hiç gelmezse bekçi zamanlayıcı kuyruğu ilerletir.
  static void speak(String text, {double rate = 1.0}) {
    if (!kIsWeb) return;
    final chunks = chunkText(
      text,
      maxLength: rate < 0.8 ? slowMaxChunk : defaultMaxChunk,
    );
    if (chunks.isEmpty) return;
    js_bridge.evalJs(_speakScript(chunks, rate));
  }

  /// Aktif konuşmayı ve bekleyen kuyruğu iptal et.
  static void cancel() {
    if (!kIsWeb) return;
    js_bridge.evalJs('''
      (function() {
        try {
          var job = window._lutkeEnTts;
          if (job) {
            job.cancelled = true;
            clearTimeout(job.watchdog);
            clearTimeout(job.startTimer);
            job.queue = [];
          }
          if (window.speechSynthesis) window.speechSynthesis.cancel();
        } catch (e) {}
      })();
    ''');
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

  // ── Parçalama (saf Dart — test edilebilir) ─────────────────────

  /// Bölmeyi yanıltan yaygın kısaltmalar ("Mr. Smith" iki parçaya
  /// ayrılmasın).
  static const Set<String> _abbreviations = {
    'mr', 'mrs', 'ms', 'dr', 'st', 'jr', 'sr', 'prof', 'mt', 'vs', 'etc',
    'e.g', 'i.e', 'approx',
  };

  /// Metni seslendirme parçalarına böler.
  ///
  /// Sıra: (1) paragraf / satır sonu, (2) cümle sonu `. ! ? …`,
  /// (3) uzun cümlede `, ; : — –` gibi yan cümle sınırları, (4) hâlâ uzunsa
  /// sözcük sınırı. Hiçbir parça [maxLength]'i aşmaz ve sözcük ortasından
  /// kesilmez (tek başına [maxLength]'ten uzun "sözcük" hariç).
  /// Boşluklar sadeleştirilir; boş parça üretilmez.
  static List<String> chunkText(String text, {int maxLength = defaultMaxChunk}) {
    assert(maxLength >= 20);
    final out = <String>[];
    for (final para in text.split(RegExp(r'\n+'))) {
      final p = para.replaceAll(RegExp(r'\s+'), ' ').trim();
      if (p.isEmpty) continue;
      for (final sentence in _sentences(p)) {
        if (sentence.length <= maxLength) {
          out.add(sentence);
        } else {
          out.addAll(_splitLong(sentence, maxLength));
        }
      }
    }
    return out;
  }

  /// Cümlelere ayır; kısaltmadan sonra gelen bölmeleri geri birleştir.
  static List<String> _sentences(String p) {
    final raw = p
        .split(RegExp(r'''(?<=[.!?…]["'”’)\]]*)\s+'''))
        .where((s) => s.isNotEmpty)
        .toList();
    final merged = <String>[];
    for (final s in raw) {
      if (merged.isNotEmpty && _endsWithAbbreviation(merged.last)) {
        merged[merged.length - 1] = '${merged.last} $s';
      } else {
        merged.add(s);
      }
    }
    return merged;
  }

  static bool _endsWithAbbreviation(String s) {
    final m = RegExp(r'(?:^|\s)([A-Za-z]+(?:\.[A-Za-z]+)*)\.$').firstMatch(s);
    if (m == null) return false;
    final word = m.group(1)!;
    // Tek büyük harf + nokta ("J. Smith") de kısaltmadır.
    if (word.length == 1 && word.toUpperCase() == word) return true;
    return _abbreviations.contains(word.toLowerCase());
  }

  /// Uzun cümleyi önce yan cümle sınırlarından, sonra sözcüklerden böl;
  /// parçaları [maxLength]'e kadar açgözlü biçimde birleştir.
  static List<String> _splitLong(String sentence, int maxLength) {
    final clauses = sentence
        .split(RegExp(r'(?<=[,;:—–])\s+|\s+(?=[—–]\s)'))
        .where((c) => c.isNotEmpty);
    final pieces = <String>[];
    for (final c in clauses) {
      if (c.length <= maxLength) {
        pieces.add(c);
      } else {
        pieces.addAll(c.split(' ').where((w) => w.isNotEmpty));
      }
    }
    final out = <String>[];
    var buf = '';
    for (final piece in pieces) {
      if (buf.isEmpty) {
        buf = piece;
      } else if (buf.length + 1 + piece.length <= maxLength) {
        buf = '$buf $piece';
      } else {
        out.add(buf);
        buf = piece;
      }
      // Tek başına sınırı aşan sözcük (URL vb.) — mecburen sert kes.
      while (buf.length > maxLength) {
        out.add(buf.substring(0, maxLength));
        buf = buf.substring(maxLength);
      }
    }
    if (buf.isNotEmpty) out.add(buf);
    return out;
  }

  // ── JS kuyruğu ─────────────────────────────────────────────────

  static String _speakScript(List<String> chunks, double rate) {
    // jsonEncode → güvenli JS dizi literali (tırnak, ters bölü, Unicode).
    final chunksJs = jsonEncode(chunks);
    final rateJs = rate.clamp(0.1, 2.0).toString();
    return '''
      (function() {
        try {
          var ss = window.speechSynthesis;
          if (!ss || !window.SpeechSynthesisUtterance) return;
          var chunks = $chunksJs;
          var rate = $rateJs;

          // Önceki iş (varsa) iptal — yeni okuma eskisini keser.
          var prev = window._lutkeEnTts;
          var hadActive = !!(ss.speaking || ss.pending);
          if (prev) {
            prev.cancelled = true;
            clearTimeout(prev.watchdog);
            clearTimeout(prev.startTimer);
            prev.queue = [];
          }
          ss.cancel();
          // Utterance referansları burada tutulur (GC koruması).
          var job = { cancelled: false, index: 0, queue: [], watchdog: null,
                      startTimer: null };
          window._lutkeEnTts = job;

          function norm(l) { return String(l || '').replace('_', '-').toLowerCase(); }
          function pickVoice(voices) {
            if (!voices || !voices.length) return null;
            var en = voices.filter(function(v) { return norm(v.lang).indexOf('en') === 0; });
            if (!en.length) return null;
            function first(pred) { for (var i = 0; i < en.length; i++) if (pred(en[i])) return en[i]; return null; }
            return first(function(v) { return v.localService && norm(v.lang) === 'en-us'; })
                || first(function(v) { return v.localService && norm(v.lang) === 'en-gb'; })
                || first(function(v) { return v.localService; })
                || first(function(v) { return norm(v.lang) === 'en-us'; })
                || first(function(v) { return norm(v.lang) === 'en-gb'; })
                || en[0];
          }

          function speakNext(voice) {
            if (job.cancelled || window._lutkeEnTts !== job) return;
            if (job.index >= chunks.length) { job.queue = []; return; }
            var text = chunks[job.index];
            var u = new SpeechSynthesisUtterance(text);
            u.lang = voice ? voice.lang : 'en-US';
            if (voice) u.voice = voice;
            u.rate = rate;
            u.pitch = 1.0;
            u.volume = 1.0;
            job.queue.push(u);
            var advanced = false;
            function advance() {
              if (advanced) return;
              advanced = true;
              clearTimeout(job.watchdog);
              job.index++;
              speakNext(voice);
            }
            u.onend = advance;
            u.onerror = function(e) {
              // cancel() kaynaklı 'interrupted'/'canceled' → iş zaten iptal.
              if (job.cancelled) return;
              if (window.console) console.log('EN TTS chunk error:', e && e.error);
              advance();
            };
            ss.speak(u);
            // Bekçi: onend bazı tarayıcılarda hiç gelmez. Tahmini süre
            // dolunca konuşma bitmişse ilerle; sürüyorsa bekle (en çok 2x).
            var est = Math.ceil(text.length * 85 / rate) + 4000;
            var waited = 0;
            function check() {
              if (advanced || job.cancelled) return;
              waited += (waited === 0 ? est : 1000);
              if (!ss.speaking && !ss.pending) { advance(); return; }
              if (waited > est * 2) { advance(); return; } // sıraya ekler, kesmez
              job.watchdog = setTimeout(check, 1000);
            }
            job.watchdog = setTimeout(check, est);
          }

          function begin(voices) {
            if (job.cancelled) return;
            speakNext(pickVoice(voices));
          }

          function start() {
            var voices = ss.getVoices();
            if (voices && voices.length) { begin(voices); return; }
            // Sesler henüz yüklenmedi — voiceschanged ya da 500 ms.
            var started = false;
            function go() {
              if (started) return;
              started = true;
              try { ss.removeEventListener('voiceschanged', go); } catch (e) {}
              begin(ss.getVoices());
            }
            try { ss.addEventListener('voiceschanged', go); } catch (e) {}
            job.startTimer = setTimeout(go, 500);
          }

          // Chrome: cancel()'dan hemen sonraki speak() bazen yutulur —
          // gerçekten bir şey kesildiyse kısa bir nefes ver. Aksi hâlde
          // eşzamanlı başla (iOS Safari kullanıcı jesti içinde ister).
          if (hadActive) { job.startTimer = setTimeout(start, 80); } else { start(); }
        } catch (e) { console.log('EN TTS error:', e); }
      })();
    ''';
  }
}
