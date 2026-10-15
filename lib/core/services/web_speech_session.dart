import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'js_eval_stub.dart'
    if (dart.library.html) 'js_eval_web.dart' as js_bridge;

/// Tarayıcı SpeechRecognition (Web Speech API) için ORTAK dinleme motoru.
///
/// `AsrService` (telaffuz skoru) ve `SpeechRecognitionService` (konuşma
/// ekranları) bu motoru kullanır; her biri kendi window anahtarıyla
/// (`_lutkeAsr*`, `_lutkeSpeech*`) çalışır, birbirinin oturumunu bozmaz.
///
/// ── NEDEN (Ekim 2026 — "kayıt yarıda kesiliyor" hatası) ─────────
/// Eski yol `continuous = false` kullanıyordu: Chrome ilk kısa duraksamada
/// tanımayı bitiriyor, öğrencinin cümlesi yarıda kalıyordu. Yeni yol:
///   • `continuous = true` + `interimResults = true`; nihai sonuçlar
///     segmentler boyunca biriktirilir.
///   • Konuşma başladıktan sonra [silence] kadar sessizlik → zarif durdurma
///     (`stop()`; bekleyen nihai sonuç gelir, sonra biter).
///   • Chrome sürekli oturumu kendiliğinden kapatırsa (ağ, Android Chrome'un
///     kısa sessizlikte kapatması) zaman bütçesi içindeyse yeniden başlatılır;
///     toplanan metin korunur.
///   • `no-speech` ölümcül sayılmaz (öğrenci düşünürken başlamamış olabilir).
///   • Elle durdurma ([stop]) toplanan metni DÖNDÜRÜR; yalnız [cancel] atar.
class WebSpeechSession {
  WebSpeechSession(this.key);

  /// window anahtar öneki — ör. `_lutkeAsr` → `window._lutkeAsrState`.
  final String key;

  int _generation = 0;
  bool _active = false;

  bool get isActive => _active;

  String get _state => 'window.${key}State';

  /// Dinle; bitince sonucu döndür. [cancel] çağrıldıysa veya yeni bir
  /// [listen] başladıysa null döner. Web dışında hemen `unsupported`.
  ///
  /// [timeout]: toplam dinleme bütçesi. Bütçe dolunca JS tarafı zarif
  /// durdurur; toplanan metin yine döner (hata değil).
  Future<WebSpeechOutcome?> listen({
    required String language,
    int maxAlternatives = 5,
    Duration silence = const Duration(milliseconds: 1800),
    Duration timeout = const Duration(seconds: 15),
  }) async {
    if (!kIsWeb) return const WebSpeechOutcome(error: 'unsupported');
    cancel(); // varsa önceki oturumu kapat
    final gen = ++_generation;
    _active = true;

    js_bridge.evalJs(
      startScript(
        key: key,
        language: language,
        maxAlternatives: maxAlternatives,
        silence: silence,
        budget: timeout,
      ),
    );

    // JS bütçesi dolunca kendisi durur; bu yalnızca köprü/olay hiç
    // gelmezse diye son emniyet (zarif durdurma + nihai sonuç payı).
    final hardDeadline = DateTime.now().add(timeout + const Duration(seconds: 3));
    try {
      while (true) {
        await Future<void>.delayed(const Duration(milliseconds: 200));
        if (gen != _generation || !_active) return null; // iptal / yeni oturum

        final snap = _poll();
        if (snap == null) {
          return const WebSpeechOutcome(error: 'bridge'); // JS köprüsü yok
        }
        if (snap.done) return snap.toOutcome();

        if (DateTime.now().isAfter(hardDeadline)) {
          if (kDebugMode) debugPrint('WebSpeech($key): sert zaman aşımı');
          // Elde ne varsa onu kullan — öğrencinin söyledikleri boşa gitmesin.
          final out = snap.toOutcome();
          return out.hasSpeech ? out : const WebSpeechOutcome(error: 'timeout');
        }
      }
    } finally {
      if (gen == _generation) {
        _active = false;
        js_bridge.evalJs(abortScript(key));
      }
    }
  }

  /// Zarif durdurma: mikrofon kapanır, bekleyen nihai sonuç gelir ve
  /// [listen] TOPLANAN METİNLE tamamlanır (durdur düğmesi için).
  void stop() {
    if (!kIsWeb || !_active) return;
    js_bridge.evalJs(stopScript(key));
  }

  /// İptal: [listen] null döner, sonuç atılır (ekran kapanırken).
  void cancel() {
    _generation++;
    final wasActive = _active;
    _active = false;
    if (kIsWeb && wasActive) js_bridge.evalJs(abortScript(key));
  }

  WebSpeechSnapshot? _poll() {
    final raw = js_bridge.evalJsSync(
      '(function(){ try { var s = $_state; if (!s) return null; '
      'return JSON.stringify({done: !!s.done, error: s.error || "", '
      'segments: s.committed.concat(s.current)}); } '
      'catch (e) { return null; } })()',
    );
    if (raw == null) return null;
    try {
      return WebSpeechSnapshot.fromJson(
        jsonDecode(raw.toString()) as Map<String, dynamic>,
      );
    } catch (_) {
      // Geçici parse hatası — boş ama sürmekte olan bir anlık görüntü.
      return const WebSpeechSnapshot(done: false, error: '', segments: []);
    }
  }

  // ── JS betikleri ─────────────────────────────────────────────

  /// Dinleme oturumunu başlatan betik. Durum `window.<key>State`'te durur.
  @visibleForTesting
  static String startScript({
    required String key,
    required String language,
    required int maxAlternatives,
    required Duration silence,
    required Duration budget,
  }) {
    final lang = jsonEncode(language);
    return '''
(function() {
  var K = '${key}State';
  try {
    var old = window[K];
    if (old) {
      old.cancelled = true; old.done = true;
      try { clearTimeout(old.silenceTimer); clearTimeout(old.budgetTimer);
            clearTimeout(old.stopTimer); } catch (e) {}
      try { if (old.rec) old.rec.abort(); } catch (e) {}
    }
    var s = {
      committed: [], current: [], error: '', done: false, cancelled: false,
      stopping: false, heard: false, lastSpeechAt: 0, startedAt: Date.now(),
      fastFails: 0, rec: null, silenceTimer: null, budgetTimer: null,
      stopTimer: null
    };
    window[K] = s;
    var SILENCE = ${silence.inMilliseconds};
    var BUDGET = ${budget.inMilliseconds};
    var SR = window.SpeechRecognition || window.webkitSpeechRecognition;
    if (!SR) { s.error = 'unsupported'; s.done = true; return; }

    function clearTimers() {
      clearTimeout(s.silenceTimer); clearTimeout(s.budgetTimer);
      clearTimeout(s.stopTimer);
    }
    function finish(err) {
      if (s.done) return;
      if (err) s.error = err;
      s.done = true;
      clearTimers();
      try { if (s.rec) s.rec.abort(); } catch (e) {}
    }
    // Zarif durdurma: bekleyen nihai sonuç gelsin, onend'de bitsin.
    // onend gelmezse 1.5 sn sonra elde olanla bitir.
    function requestStop() {
      if (s.done || s.stopping) return;
      s.stopping = true;
      clearTimeout(s.silenceTimer);
      try { if (s.rec) s.rec.stop(); } catch (e) { finish(); return; }
      s.stopTimer = setTimeout(function() { finish(); }, 1500);
    }
    s.requestStop = requestStop;
    s.finish = finish;

    function armSilence() {
      clearTimeout(s.silenceTimer);
      s.silenceTimer = setTimeout(requestStop, SILENCE);
    }

    function startRec() {
      var r = new SR();
      r.lang = $lang;
      r.continuous = true;
      r.interimResults = true;
      r.maxAlternatives = $maxAlternatives;
      var bornAt = Date.now();
      var gotResult = false;
      r.onresult = function(e) {
        if (s.done || s.rec !== r) return;
        // e.results bu örneğin TÜM sonuçlarını taşır — her olayda yeniden kur.
        var segs = [];
        for (var i = 0; i < e.results.length; i++) {
          var res = e.results[i];
          var alts = [];
          for (var j = 0; j < res.length; j++) alts.push(res[j].transcript || '');
          segs.push({ f: !!res.isFinal, a: alts });
        }
        s.current = segs;
        gotResult = true;
        s.heard = true;
        s.lastSpeechAt = Date.now();
        if (!s.stopping) armSilence();
      };
      r.onerror = function(e) {
        if (s.done || s.rec !== r) return;
        var err = e.error || 'unknown';
        // no-speech ölümcül değil — onend bütçe içinde yeniden başlatır.
        if (err === 'no-speech') return;
        // aborted: başka bir tanıma mikrofonu aldı — kavga etme, elde
        // olanla bitir (kendi abort'larımız zaten s.done ile elenir).
        if (err === 'aborted') { finish(); return; }
        finish(err);
      };
      r.onend = function() {
        if (s.done || s.rec !== r) return;
        // Bu örneğin sonuçlarını kalıcı listeye al (bitmemiş interim dahil —
        // elimizdeki en iyi tahmin odur).
        s.committed = s.committed.concat(s.current);
        s.current = [];
        if (s.stopping) { finish(); return; }
        var now = Date.now();
        if (now - s.startedAt >= BUDGET) { finish(); return; }
        if (s.heard && now - s.lastSpeechAt >= SILENCE * 0.8) { finish(); return; }
        // Anında kapanma döngüsüne karşı: sonuçsuz çok kısa ömürler sayılır.
        if (!gotResult && now - bornAt < 400) {
          s.fastFails++;
          if (s.fastFails >= 3) { finish(s.heard ? '' : 'no-speech'); return; }
        }
        // Chrome sürekli oturumu kendiliğinden kapattı — bütçe içinde yeniden.
        try { startRec(); } catch (e) { finish(); }
      };
      s.rec = r;
      r.start();
    }

    s.budgetTimer = setTimeout(requestStop, BUDGET);
    startRec();
  } catch (e) {
    var st = window[K];
    if (st && !st.done) { st.error = String(e); st.done = true; }
  }
})();
''';
  }

  /// Zarif durdurma betiği.
  @visibleForTesting
  static String stopScript(String key) =>
      '(function(){ try { var s = window.${key}State; '
      'if (s && !s.done && s.requestStop) s.requestStop(); } catch (e) {} })();';

  /// İptal betiği — oturumu sonuçsuz kapatır.
  @visibleForTesting
  static String abortScript(String key) =>
      '(function(){ try { var s = window.${key}State; if (!s) return; '
      's.cancelled = true; if (s.finish) s.finish(); else s.done = true; '
      '} catch (e) {} })();';

  // ── Saf Dart yardımcıları (test edilebilir) ──────────────────

  /// Segmentleri tek bir metne + skor için alternatif listesine çevirir.
  ///
  /// • Boş segmentler atılır.
  /// • Android Chrome sürekli modda bazen BİRİKİMLİ sonuç verir
  ///   ("bav", "bav û", "bav û dê") veya aynı sonucu tekrarlar —
  ///   önceki segmenti kapsayan segment onun yerine geçer, birebir tekrar
  ///   atılır.
  /// • İlk aday = her segmentin en iyi hipotezlerinin birleşimi; ardından
  ///   her segmentte tek bir alternatif değiştirilmiş varyantlar gelir
  ///   (en çok [maxCandidates]). Tek segmentte bu, tarayıcının kendi
  ///   alternatif listesiyle aynıdır.
  static List<String> mergeCandidates(
    List<List<String>> segments, {
    int maxCandidates = 12,
  }) {
    final segs = <List<String>>[];
    for (final raw in segments) {
      final alts = raw
          .map((a) => a.replaceAll(RegExp(r'\s+'), ' ').trim())
          .where((a) => a.isNotEmpty)
          .toList();
      if (alts.isEmpty) continue;
      if (segs.isNotEmpty) {
        final prev = _cmp(segs.last.first);
        final cur = _cmp(alts.first);
        if (cur == prev) continue; // birebir tekrar
        if (prev.isNotEmpty && cur.startsWith('$prev ')) {
          segs[segs.length - 1] = alts; // birikimli sonuç — öncekini kapsar
          continue;
        }
      }
      segs.add(alts);
    }
    if (segs.isEmpty) return const [];

    final out = <String>[];
    void add(List<String> parts) {
      final s = parts.join(' ').trim();
      if (s.isNotEmpty && !out.contains(s) && out.length < maxCandidates) {
        out.add(s);
      }
    }

    final top = [for (final s in segs) s.first];
    add(top);
    for (var i = 0; i < segs.length; i++) {
      for (var j = 1; j < segs[i].length; j++) {
        add([...top]..[i] = segs[i][j]);
      }
    }
    return out;
  }

  static String _cmp(String s) =>
      s.toLowerCase().replaceAll(RegExp(r'[.,!?;:]'), '').trim();
}

/// JS durumunun anlık görüntüsü.
class WebSpeechSnapshot {
  final bool done;
  final String error;

  /// Her segment: `(isFinal, alternatifler)`.
  final List<List<String>> segments;

  const WebSpeechSnapshot({
    required this.done,
    required this.error,
    required this.segments,
  });

  factory WebSpeechSnapshot.fromJson(Map<String, dynamic> json) {
    final segs = <List<String>>[];
    for (final s in (json['segments'] as List?) ?? const []) {
      if (s is Map && s['a'] is List) {
        segs.add((s['a'] as List).whereType<String>().toList());
      }
    }
    return WebSpeechSnapshot(
      done: json['done'] == true,
      error: (json['error'] as String?) ?? '',
      segments: segs,
    );
  }

  /// Metin toplandıysa sonradan gelen hata (ör. oturum sonunda 'network')
  /// yok sayılır — öğrencinin söyledikleri değerlendirilir.
  WebSpeechOutcome toOutcome() {
    final candidates = WebSpeechSession.mergeCandidates(segments);
    return WebSpeechOutcome(
      error: candidates.isEmpty ? error : '',
      candidates: candidates,
    );
  }
}

/// Dinleme sonucu.
class WebSpeechOutcome {
  /// Boş değilse tarayıcı hatası: 'not-allowed', 'network',
  /// 'unsupported', 'timeout', 'bridge' …
  final String error;

  /// Aday metinler — ilki en iyi hipotez. Boşsa konuşma duyulmadı.
  final List<String> candidates;

  const WebSpeechOutcome({this.error = '', this.candidates = const []});

  bool get hasSpeech => candidates.isNotEmpty;
  String get transcript => candidates.isEmpty ? '' : candidates.first;
}
