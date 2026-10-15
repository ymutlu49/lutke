import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';

import 'en_ses_manifest.dart';

// Conditional JS import — web üzerinde speechSynthesis API'sine erişim
import 'js_eval_stub.dart'
    if (dart.library.html) 'js_eval_web.dart' as js_bridge;

/// İngilizce TTS tek merkezli yardımcı.
///
/// Mimari kural: İngilizce seslendirmenin TAMAMI bu helper üzerinden akar —
/// en_* ekranlarında ham `js_bridge.evalJs` / `FlutterTts` çağrılmamalı.
/// `SpeakButton(lang: 'en')` ve diğer İngilizce aktiviteler bu helper'ı
/// kullanır; kod tekrarı ve yanlış aksan sızıntısı önlenir.
///
/// SES YOLU (Ekim 2026 — web ve Android'de aynı ses):
///   1. Metin [EnSesManifest]'te varsa ÖNCEDEN ÜRETİLMİŞ dosya
///      (lutke.app/ses/…) paylaşılan bir just_audio `AudioPlayer` ile çalınır.
///      Web'de de Android'de de aynı kayıt — profesyonel, tutarlı telaffuz.
///   2. Manifestte yoksa (ya da dosya yüklenemezse) cihaz TTS'ine düşülür:
///      • web → tarayıcı speechSynthesis (parçalı, sıralı kuyruk)
///      • Android/iOS → flutter_tts (en-US, parçalar sırayla, iptal edilebilir)
class EnTtsHelper {
  EnTtsHelper._();

  /// Normal hızda bir parçanın en fazla karakter sayısı. Chrome'un uzak
  /// ("Google US English") sesleri ~15 sn'yi aşan utterance'ı yarıda
  /// keser; ~160 karakter normal hızda ~10 sn'dir.
  static const int defaultMaxChunk = 160;

  /// Yavaş hızda (rate < 0.8) parça sınırı — aynı süre bütçesi için kısa.
  static const int slowMaxChunk = 110;

  /// Ses arka ucu — testlerde sahte arka uçla değiştirilir (dikiş).
  @visibleForTesting
  static EnSesArkaUcu arkaUc = _GercekArkaUc();

  /// Metin → hazır ses adresi araması (manifestte yoksa null). Testlerde
  /// sahte manifestle değiştirilir.
  @visibleForTesting
  static String? Function(String metin) sesAdresi = EnSesManifest.url;

  /// İstek nesli: her [speak] / [cancel] artırır. Bekleyen (ağdan yüklenen)
  /// eski istek nesli eskimişse ÇALINMAZ — bayat ses yeni sesin üstüne binmez.
  static int _nesil = 0;

  /// İngilizce metni seslendirir — önce hazır dosya, yoksa cihaz TTS'i.
  ///
  /// [rate] — 0.6 (yavaş) ile 1.1 (hızlı) arası; 1.0 normal. Hazır dosyada
  /// [oynatmaHizi] ile oynatma hızına çevrilir; cihaz TTS'inde doğrudan
  /// konuşma hızıdır. Önceki okuma (dosya ya da TTS) her zaman kesilir.
  ///
  /// Ateşle-unut: çağıranlar beklemez (onTap içinde kullanılır).
  static void speak(String text, {double rate = 1.0}) {
    unawaited(seslendir(text, rate: rate));
  }

  /// [speak]'in beklenebilir hâli — yönlendirme kararını test etmek için.
  ///
  /// Web notu: manifest ıskasında cihaz TTS'i ilk `await`'ten ÖNCE
  /// (eşzamanlı) başlatılır — iOS Safari speechSynthesis'i yalnızca
  /// kullanıcı jesti içinde konuşturur.
  @visibleForTesting
  static Future<void> seslendir(String text, {double rate = 1.0}) async {
    final nesil = ++_nesil;
    bool hala() => nesil == _nesil;
    if (text.trim().isEmpty) return;

    final url = sesAdresi(text);
    if (url != null) {
      // Hazır dosya: önce cihaz TTS'i sustur (yarım kalan okuma üst üste
      // binmesin), sonra dosyayı çal.
      unawaited(_sessiz(arkaUc.cihazTtsDurdur()));
      bool calindi;
      try {
        calindi = await arkaUc.dosyaCal(url, oynatmaHizi(rate), hala);
      } catch (e) {
        if (kDebugMode) debugPrint('EN ses dosyası çalınamadı: $e');
        calindi = false;
      }
      // Dosya çaldı ya da araya yeni istek/iptal girdi → iş bitti.
      if (calindi || !hala()) return;
      // Dosya yüklenemedi (ağ yok, dosya henüz yayında değil…) → TTS'e düş.
    } else {
      unawaited(_sessiz(arkaUc.dosyaDurdur()));
    }
    await _sessiz(arkaUc.cihazTts(text, rate, hala));
  }

  /// TTS hızını ([speak] `rate`) hazır dosyanın oynatma hızına çevirir.
  ///
  /// rate 1.0 → 1.0. Yavaş hızlar yumuşatılır (×0.8): kayıt zaten doğal
  /// tempoda; 0.6'ya germek sesi bozar. 0.6 → 0.68, 0.7 → 0.76,
  /// 0.85 → 0.88, 0.9 → 0.92, 1.1 → 1.08. Perde korunur (web: preservesPitch,
  /// Android: ExoPlayer hız parametresi).
  static double oynatmaHizi(double rate) =>
      (1.0 + (rate - 1.0) * 0.8).clamp(0.5, 2.0).toDouble();

  /// Aktif konuşmayı / çalan dosyayı ve bekleyen kuyruğu iptal et.
  static void cancel() {
    _nesil++;
    unawaited(_sessiz(arkaUc.dosyaDurdur()));
    unawaited(_sessiz(arkaUc.cihazTtsDurdur()));
  }

  /// Browser voices'in önceden yüklenmesi — uygulama açılışında bir kez
  /// çağrılır. `getVoices()` ilk tıklama için hazır olur.
  /// INTEGRATION FIX (Nisan 2026): iOS Safari ve Chrome'da voices lazy
  /// yüklenir — ilk "Listen" click'i ses üretmez. Bu prime ile önlenir.
  static void warmUp() {
    if (!kIsWeb) return;
    js_bridge.evalJs(_warmUpScript);
  }

  /// Arka uç hatası okumayı / uygulamayı düşürmesin (eklenti yok, ağ yok…).
  static Future<void> _sessiz(Future<void> f) =>
      f.catchError((Object e) {
        if (kDebugMode) debugPrint('EN TTS: $e');
      });

  static const String _warmUpScript = '''
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
    ''';

  static const String _cancelScript = '''
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
    ''';

  /// Parça için tahmini konuşma süresi + pay — bekçi zamanlayıcı
  /// (web JS kuyruğundaki `est` ile aynı formül).
  static Duration _tahminiSure(String parca, double rate) => Duration(
        milliseconds: (parca.length * 85 / rate.clamp(0.1, 2.0)).ceil() + 4000,
      );

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

// ── Arka uçlar ───────────────────────────────────────────────────

/// İngilizce ses arka ucu — [EnTtsHelper]'ın yönlendirme kararını
/// platformdan ayıran dikiş. Üretimde [_GercekArkaUc]; testlerde sahte.
abstract class EnSesArkaUcu {
  /// Hazır ses dosyasını [hiz] oynatma hızında çalar. Dosya yüklenemezse
  /// `false` döner (çağıran cihaz TTS'ine düşer). Yükleme bitince [hala]
  /// `false` ise (araya yeni istek / iptal girdi) çalma başlatılmaz.
  Future<bool> dosyaCal(String url, double hiz, bool Function() hala);

  /// Çalan hazır dosyayı durdurur.
  Future<void> dosyaDurdur();

  /// Cihaz TTS'i ile okur (web: speechSynthesis, mobil: flutter_tts).
  /// [hala] `false` olunca sıradaki parçalar okunmaz.
  Future<void> cihazTts(String text, double rate, bool Function() hala);

  /// Cihaz TTS'ini (ve bekleyen parçaları) durdurur.
  Future<void> cihazTtsDurdur();
}

/// Üretim arka ucu: just_audio (dosya) + speechSynthesis / flutter_tts.
///
/// Oynatıcı ve TTS motoru TEMBEL kurulur — İngilizce hiç çalınmazsa ya da
/// yalnızca [EnTtsHelper.cancel] çağrılırsa eklenti kanalına dokunulmaz.
class _GercekArkaUc implements EnSesArkaUcu {
  AudioPlayer? _oyuncu;
  FlutterTts? _tts;
  Future<FlutterTts>? _ttsHazir;

  /// Paylaşılan tek oynatıcı — her yeni dosya öncekinin yerini alır.
  AudioPlayer get _paylasilanOyuncu => _oyuncu ??= AudioPlayer();

  @override
  Future<bool> dosyaCal(String url, double hiz, bool Function() hala) async {
    final oyuncu = _paylasilanOyuncu;
    try {
      await oyuncu.setSpeed(hiz);
      // setUrl önceki kaynağı keser ve yeni dosyayı yükler; ağ/404
      // hatasında fırlatır → false → TTS yedeği.
      await oyuncu.setUrl(url);
    } catch (e) {
      if (kDebugMode) debugPrint('EN ses dosyası yüklenemedi ($url): $e');
      return false;
    }
    if (!hala()) return true; // bayat istek — çalma, yedeğe de düşme
    unawaited(
      oyuncu.play().catchError((Object e) {
        if (kDebugMode) debugPrint('EN ses dosyası çalma hatası: $e');
      }),
    );
    return true;
  }

  @override
  Future<void> dosyaDurdur() async {
    final oyuncu = _oyuncu;
    if (oyuncu == null) return;
    await oyuncu.stop();
  }

  @override
  Future<void> cihazTts(String text, double rate, bool Function() hala) async {
    final chunks = EnTtsHelper.chunkText(
      text,
      maxLength: rate < 0.8
          ? EnTtsHelper.slowMaxChunk
          : EnTtsHelper.defaultMaxChunk,
    );
    if (chunks.isEmpty) return;

    if (kIsWeb) {
      // Eşzamanlı — kullanıcı jesti içinde kalır (iOS Safari).
      js_bridge.evalJs(EnTtsHelper._speakScript(chunks, rate));
      return;
    }

    // Android / iOS: flutter_tts. awaitSpeakCompletion(true) ile her parça
    // bitince sıradaki okunur; iptal (nesil değişimi) parça aralarında
    // yakalanır, o anki parça cihazTtsDurdur → stop() ile kesilir.
    final FlutterTts tts;
    try {
      tts = await (_ttsHazir ??= _ttsKur());
    } catch (_) {
      // Kurulum başarısız (motor yok / eklenti yok) — sonraki çağrı yeniden
      // denesin; bozuk future önbellekte kalmasın.
      _ttsHazir = null;
      _tts = null;
      rethrow;
    }
    if (!hala()) return;
    await tts.stop();
    // flutter_tts hız ölçeği: 0.5 = normal (Android'de ×2 → TextToSpeech
    // 1.0; iOS'ta AVSpeechUtterance varsayılanı 0.5). rate 1.0 → 0.5.
    await tts.setSpeechRate((rate * 0.5).clamp(0.1, 1.0).toDouble());
    for (final parca in chunks) {
      if (!hala()) return;
      // Bekçi: flutter_tts stop()/hata sonrası speak future'ını hiç
      // tamamlamayabiliyor — tahmini süre dolunca sıradakine geç.
      await tts
          .speak(parca)
          .timeout(EnTtsHelper._tahminiSure(parca, rate), onTimeout: () => 0);
    }
  }

  Future<FlutterTts> _ttsKur() async {
    final tts = _tts = FlutterTts();
    await tts.setLanguage('en-US');
    await tts.setPitch(1.0);
    await tts.setVolume(1.0);
    await tts.awaitSpeakCompletion(true);
    return tts;
  }

  @override
  Future<void> cihazTtsDurdur() async {
    if (kIsWeb) {
      js_bridge.evalJs(EnTtsHelper._cancelScript);
      return;
    }
    final tts = _tts;
    if (tts == null) return;
    await tts.stop();
  }
}
