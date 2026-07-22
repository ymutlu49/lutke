import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/js_eval_stub.dart'
    if (dart.library.html) '../services/js_eval_web.dart' as js;

// ════════════════════════════════════════════════════════════════
// SOUND SERVICE — Web Audio API ile sentezlenmiş UI sesleri
//
// Ses dosyası gerektirmez; tarayıcıda programatik olarak üretilir.
// Mobil/masaüstü platformlarda no-op (kIsWeb == false).
//
// 2026-04 genişletme:
// • Zengin palet: pentatonik akor, arpejler, level-up, milestone, session.
// • Mute toggle (SharedPreferences, key: 'sound_muted').
// • Debounce — saniyede 5 sesin üstüne çıkılmaz.
// ════════════════════════════════════════════════════════════════

class SoundService {
  // ── Mute kontrolü ──────────────────────────────────────────────
  static const String _kMutedPrefKey = 'sound_muted';
  static bool _muted = false;
  static bool _initialized = false;

  /// Uygulama başlangıcında çağrılmalı — persisted mute durumunu yükler.
  static Future<void> init() async {
    if (_initialized) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      _muted = prefs.getBool(_kMutedPrefKey) ?? false;
    } catch (_) {
      _muted = false;
    }
    _initialized = true;
  }

  static bool get isMuted => _muted;

  /// Mute durumunu değiştirir ve persist eder.
  static Future<void> setMuted(bool value) async {
    _muted = value;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_kMutedPrefKey, value);
    } catch (_) {/* ignore */}
  }

  /// Toggle mute — dönüş: yeni durum.
  static Future<bool> toggleMuted() async {
    await setMuted(!_muted);
    return _muted;
  }

  // ── Debounce: max 5 ses / saniye (rapid-fire koruması) ─────────
  static final List<int> _recentPlaysMs = <int>[];
  static const int _maxPerSecond = 5;

  static bool _canPlay() {
    if (_muted) return false;
    if (!kIsWeb) return false;
    final now = DateTime.now().millisecondsSinceEpoch;
    _recentPlaysMs.removeWhere((t) => now - t > 1000);
    if (_recentPlaysMs.length >= _maxPerSecond) return false;
    _recentPlaysMs.add(now);
    return true;
  }

  // ══════════════════════════════════════════════════════════════
  // Public API — ses efektleri
  // ══════════════════════════════════════════════════════════════

  /// Küçük tık sesi — sekme/buton tap (800Hz sine, 50ms).
  static void playClick() {
    if (!_canPlay()) return;
    js.evalJs(_clickSound);
  }

  /// Doğru cevap — C-E-G pentatonik akor, 200ms, sıcak major.
  static void playCorrect() {
    if (!_canPlay()) return;
    js.evalJs(_correctSound);
  }

  /// Yanlış cevap — yumuşak inen minör ikili (G→F♯), 150ms.
  static void playWrong() {
    if (!_canPlay()) return;
    js.evalJs(_wrongSound);
  }

  /// Kısa pop — UI tap (1000Hz, 30ms).
  static void playTap() {
    if (!_canPlay()) return;
    js.evalJs(_tapSound);
  }

  /// Streak milestone — ardışık doğru cevap kutlaması.
  /// • 3 streak: 3-nota arpej (C-E-G), 300ms
  /// • 5 streak: 4-nota arpej (C-E-G-C octave), 400ms
  /// • 10+ streak: tam fanfar arpej, 600ms
  static void playStreakMilestone(int streak) {
    if (!_canPlay()) return;
    if (streak >= 10) {
      js.evalJs(_milestone10Sound);
    } else if (streak >= 5) {
      js.evalJs(_milestone5Sound);
    } else {
      js.evalJs(_milestone3Sound);
    }
  }

  /// Seviye atlama — muhteşem major akor, 800ms, 3 harmonikli sparkle kuyruğu.
  static void playLevelUp() {
    if (!_canPlay()) return;
    js.evalJs(_levelUpSound);
  }

  /// XP kazanma — kısa parlak ding (E-A kısa, 100ms).
  static void playXpGain() {
    if (!_canPlay()) return;
    js.evalJs(_xpGainSound);
  }

  /// Oturum tamamlama — muhteşem çan (C major akor, 500ms).
  static void playSessionComplete() {
    if (!_canPlay()) return;
    js.evalJs(_sessionCompleteSound);
  }

  /// Başarısızlık — kalp kaybı için yumuşak inen minör, 300ms.
  static void playFail() {
    if (!_canPlay()) return;
    js.evalJs(_failSound);
  }

  /// Reveal — flashcard flip için ince sine (440Hz, 80ms).
  static void playReveal() {
    if (!_canPlay()) return;
    js.evalJs(_revealSound);
  }

  /// Kart flip — whoosh (beyaz gürültü patlaması, 80ms).
  /// Backward-compat: önceki sürüm `playFlip` kullanıyordu, alias bırakıldı.
  static void playFlip() {
    if (!_canPlay()) return;
    js.evalJs(_flipSound);
  }

  /// Countdown tick — ince kısa bip (1200Hz, 25ms).
  static void playTick() {
    if (!_canPlay()) return;
    js.evalJs(_tickSound);
  }

  // ══════════════════════════════════════════════════════════════
  // JavaScript Web Audio API ses tanımları
  //
  // Frekans referansları:
  //   C5=523.25, D5=587.33, E5=659.25, F5=698.46, F#5=739.99,
  //   G5=783.99, A5=880.00, B5=987.77, C6=1046.50, E6=1318.51
  // ══════════════════════════════════════════════════════════════

  // 1. Click — 800Hz sine, 50ms
  static const _clickSound = '''
(function(){
  var c=new AudioContext(),g=c.createGain(),o=c.createOscillator();
  o.type='sine';o.frequency.value=800;
  g.gain.setValueAtTime(0.15,c.currentTime);
  g.gain.exponentialRampToValueAtTime(0.001,c.currentTime+0.05);
  o.connect(g);g.connect(c.destination);
  o.start();o.stop(c.currentTime+0.05);
})();
''';

  // 2. Correct — C5(523)+E5(659)+G5(784) pentatonik akor, sine, 200ms
  static const _correctSound = '''
(function(){
  var c=new AudioContext(),t=c.currentTime;
  function tone(f,a,d){
    var o=c.createOscillator(),g=c.createGain();
    o.type='sine';o.frequency.value=f;
    g.gain.setValueAtTime(0.0001,t);
    g.gain.exponentialRampToValueAtTime(a,t+0.01);
    g.gain.exponentialRampToValueAtTime(0.0001,t+d);
    o.connect(g);g.connect(c.destination);
    o.start(t);o.stop(t+d);
  }
  tone(523.25,0.12,0.2);
  tone(659.25,0.10,0.2);
  tone(783.99,0.08,0.2);
})();
''';

  // 3. Wrong — yumuşak inen minör ikili G5(784)→F#5(740), triangle, 150ms
  static const _wrongSound = '''
(function(){
  var c=new AudioContext(),t=c.currentTime;
  var o=c.createOscillator(),g=c.createGain();
  o.type='triangle';
  o.frequency.setValueAtTime(783.99,t);
  o.frequency.linearRampToValueAtTime(739.99,t+0.15);
  g.gain.setValueAtTime(0.0001,t);
  g.gain.exponentialRampToValueAtTime(0.09,t+0.02);
  g.gain.exponentialRampToValueAtTime(0.0001,t+0.15);
  o.connect(g);g.connect(c.destination);
  o.start(t);o.stop(t+0.15);
})();
''';

  // 4. Tap — 1000Hz pop, 30ms
  static const _tapSound = '''
(function(){
  var c=new AudioContext(),g=c.createGain(),o=c.createOscillator();
  o.type='sine';o.frequency.value=1000;
  g.gain.setValueAtTime(0.10,c.currentTime);
  g.gain.exponentialRampToValueAtTime(0.001,c.currentTime+0.03);
  o.connect(g);g.connect(c.destination);
  o.start();o.stop(c.currentTime+0.03);
})();
''';

  // 5a. Milestone 3 — C5-E5-G5 yükselen arpej, 300ms
  static const _milestone3Sound = '''
(function(){
  var c=new AudioContext(),t=c.currentTime;
  function n(f,s,d){
    var o=c.createOscillator(),g=c.createGain();
    o.type='sine';o.frequency.value=f;
    g.gain.setValueAtTime(0.0001,s);
    g.gain.exponentialRampToValueAtTime(0.14,s+0.01);
    g.gain.exponentialRampToValueAtTime(0.0001,s+d);
    o.connect(g);g.connect(c.destination);
    o.start(s);o.stop(s+d);
  }
  n(523.25,t,0.1);
  n(659.25,t+0.08,0.1);
  n(783.99,t+0.16,0.18);
})();
''';

  // 5b. Milestone 5 — C5-E5-G5-C6 yükselen arpej + son nota sustain, 400ms
  static const _milestone5Sound = '''
(function(){
  var c=new AudioContext(),t=c.currentTime;
  function n(f,s,d,a){
    var o=c.createOscillator(),g=c.createGain();
    o.type='sine';o.frequency.value=f;
    g.gain.setValueAtTime(0.0001,s);
    g.gain.exponentialRampToValueAtTime(a,s+0.01);
    g.gain.exponentialRampToValueAtTime(0.0001,s+d);
    o.connect(g);g.connect(c.destination);
    o.start(s);o.stop(s+d);
  }
  n(523.25,t,0.09,0.13);
  n(659.25,t+0.08,0.09,0.13);
  n(783.99,t+0.16,0.09,0.13);
  n(1046.50,t+0.24,0.22,0.15);
})();
''';

  // 5c. Milestone 10 — tam fanfar: C5-E5-G5-C6 + harmonikler, 600ms
  static const _milestone10Sound = '''
(function(){
  var c=new AudioContext(),t=c.currentTime;
  function n(f,s,d,a,type){
    var o=c.createOscillator(),g=c.createGain();
    o.type=type||'sine';o.frequency.value=f;
    g.gain.setValueAtTime(0.0001,s);
    g.gain.exponentialRampToValueAtTime(a,s+0.01);
    g.gain.exponentialRampToValueAtTime(0.0001,s+d);
    o.connect(g);g.connect(c.destination);
    o.start(s);o.stop(s+d);
  }
  // Ana arpej
  n(523.25,t,0.10,0.12,'sine');
  n(659.25,t+0.08,0.10,0.12,'sine');
  n(783.99,t+0.16,0.10,0.12,'sine');
  n(1046.50,t+0.24,0.36,0.14,'sine');
  // Harmonik kuyruk
  n(1318.51,t+0.28,0.32,0.06,'triangle');
  n(1567.98,t+0.34,0.26,0.04,'sine');
  // Tonik bass
  n(261.63,t+0.24,0.36,0.10,'sine');
})();
''';

  // 6. Level Up — C5+E5+G5+C6 triad + sparkle harmonics, 800ms
  static const _levelUpSound = '''
(function(){
  var c=new AudioContext(),t=c.currentTime;
  function n(f,s,d,a,type){
    var o=c.createOscillator(),g=c.createGain();
    o.type=type||'sine';o.frequency.value=f;
    g.gain.setValueAtTime(0.0001,s);
    g.gain.exponentialRampToValueAtTime(a,s+0.02);
    g.gain.exponentialRampToValueAtTime(0.0001,s+d);
    o.connect(g);g.connect(c.destination);
    o.start(s);o.stop(s+d);
  }
  // Major triad (ana akor) 500ms sustain
  n(523.25,t,0.5,0.11,'sine');
  n(659.25,t,0.5,0.10,'sine');
  n(783.99,t,0.5,0.10,'sine');
  n(1046.50,t+0.15,0.65,0.13,'sine');
  // 3 sparkle harmonik tail
  n(1318.51,t+0.40,0.40,0.06,'triangle');
  n(1975.53,t+0.50,0.30,0.04,'sine');
  n(2637.02,t+0.60,0.20,0.03,'sine');
})();
''';

  // 7. XP Gain — E5(659) + A5(880) kısa parlak ding, 100ms
  static const _xpGainSound = '''
(function(){
  var c=new AudioContext(),t=c.currentTime;
  function n(f,s,d,a){
    var o=c.createOscillator(),g=c.createGain();
    o.type='sine';o.frequency.value=f;
    g.gain.setValueAtTime(0.0001,s);
    g.gain.exponentialRampToValueAtTime(a,s+0.005);
    g.gain.exponentialRampToValueAtTime(0.0001,s+d);
    o.connect(g);g.connect(c.destination);
    o.start(s);o.stop(s+d);
  }
  n(659.25,t,0.08,0.13);
  n(880.00,t+0.03,0.10,0.12);
})();
''';

  // 8. Session Complete — C major bell (C5-E5-G5-C6), 500ms sustain
  static const _sessionCompleteSound = '''
(function(){
  var c=new AudioContext(),t=c.currentTime;
  function n(f,s,d,a){
    var o=c.createOscillator(),g=c.createGain();
    o.type='sine';o.frequency.value=f;
    g.gain.setValueAtTime(0.0001,s);
    g.gain.exponentialRampToValueAtTime(a,s+0.01);
    g.gain.exponentialRampToValueAtTime(0.0001,s+d);
    o.connect(g);g.connect(c.destination);
    o.start(s);o.stop(s+d);
  }
  n(523.25,t,0.5,0.12);
  n(659.25,t+0.06,0.5,0.11);
  n(783.99,t+0.12,0.5,0.10);
  n(1046.50,t+0.20,0.5,0.10);
})();
''';

  // 9. Fail — yumuşak inen minör (A4→F4), 300ms
  static const _failSound = '''
(function(){
  var c=new AudioContext(),t=c.currentTime;
  var o=c.createOscillator(),g=c.createGain();
  o.type='sine';
  o.frequency.setValueAtTime(440.00,t);
  o.frequency.linearRampToValueAtTime(349.23,t+0.3);
  g.gain.setValueAtTime(0.0001,t);
  g.gain.exponentialRampToValueAtTime(0.10,t+0.02);
  g.gain.exponentialRampToValueAtTime(0.0001,t+0.3);
  o.connect(g);g.connect(c.destination);
  o.start(t);o.stop(t+0.3);
})();
''';

  // 10. Reveal — flashcard flip sine 440Hz, 80ms
  static const _revealSound = '''
(function(){
  var c=new AudioContext(),t=c.currentTime;
  var o=c.createOscillator(),g=c.createGain();
  o.type='sine';o.frequency.value=440;
  g.gain.setValueAtTime(0.0001,t);
  g.gain.exponentialRampToValueAtTime(0.09,t+0.01);
  g.gain.exponentialRampToValueAtTime(0.0001,t+0.08);
  o.connect(g);g.connect(c.destination);
  o.start(t);o.stop(t+0.08);
})();
''';

  // 11. Flip — whoosh (white noise, bandpass 1500Hz, 80ms)
  static const _flipSound = '''
(function(){
  var c=new AudioContext(),t=c.currentTime;
  var buf=c.createBuffer(1,c.sampleRate*0.08,c.sampleRate);
  var data=buf.getChannelData(0);
  for(var i=0;i<data.length;i++) data[i]=(Math.random()*2-1)*0.3;
  var src=c.createBufferSource();src.buffer=buf;
  var f=c.createBiquadFilter();f.type='bandpass';f.frequency.value=1500;f.Q.value=0.8;
  var g=c.createGain();
  g.gain.setValueAtTime(0.18,t);
  g.gain.exponentialRampToValueAtTime(0.001,t+0.08);
  src.connect(f);f.connect(g);g.connect(c.destination);
  src.start();src.stop(t+0.08);
})();
''';

  // 12. Tick — 1200Hz pop, 25ms (countdown)
  static const _tickSound = '''
(function(){
  var c=new AudioContext(),g=c.createGain(),o=c.createOscillator();
  o.type='square';o.frequency.value=1200;
  g.gain.setValueAtTime(0.05,c.currentTime);
  g.gain.exponentialRampToValueAtTime(0.001,c.currentTime+0.025);
  o.connect(g);g.connect(c.destination);
  o.start();o.stop(c.currentTime+0.025);
})();
''';
}
