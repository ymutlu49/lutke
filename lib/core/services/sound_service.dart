import 'package:flutter/foundation.dart';
import '../services/js_eval_stub.dart'
    if (dart.library.js_interop) '../services/js_eval_web.dart' as js;

// ════════════════════════════════════════════════════════════════
// SOUND SERVICE — Web Audio API ile sentezlenmiş UI sesleri
//
// Ses dosyası gerektirmez; tarayıcıda programatik olarak üretilir.
// Mobil/masaüstü platformlarda no-op (kIsWeb == false).
// ════════════════════════════════════════════════════════════════

class SoundService {
  // ── 1. Tab click — kısa yumuşak tık (50ms, 800Hz sine) ─────
  static void playClick() {
    if (!kIsWeb) return;
    js.evalJs(_clickSound);
  }

  // ── 2. Correct answer — yükselen iki nota (C5→E5) ─────────
  static void playCorrect() {
    if (!kIsWeb) return;
    js.evalJs(_correctSound);
  }

  // ── 3. Wrong answer — alçak buzz (200Hz, vibrato) ──────────
  static void playWrong() {
    if (!kIsWeb) return;
    js.evalJs(_wrongSound);
  }

  // ── 4. Button tap — çok kısa pop (1000Hz, 30ms) ───────────
  static void playTap() {
    if (!kIsWeb) return;
    js.evalJs(_tapSound);
  }

  // ── 5. Level up — yükselen üç nota fanfar (C5→E5→G5) ─────
  static void playLevelUp() {
    if (!kIsWeb) return;
    js.evalJs(_levelUpSound);
  }

  // ── 6. XP gain — madeni para ding (2000Hz, 80ms) ──────────
  static void playXpGain() {
    if (!kIsWeb) return;
    js.evalJs(_xpGainSound);
  }

  // ── 7. Session complete — başarı melodisi (C5→E5→G5→C6) ───
  static void playSessionComplete() {
    if (!kIsWeb) return;
    js.evalJs(_sessionCompleteSound);
  }

  // ── 8. Card flip — whoosh (beyaz gürültü patlaması, 80ms) ─
  static void playFlip() {
    if (!kIsWeb) return;
    js.evalJs(_flipSound);
  }

  // ══════════════════════════════════════════════════════════════
  // JavaScript Web Audio API ses tanımları
  // ══════════════════════════════════════════════════════════════

  // 1. Tab click — 800Hz sine, 50ms, quick decay
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

  // 2. Correct answer — ascending C5(523Hz) → E5(659Hz), 100ms each
  static const _correctSound = '''
(function(){
  var c=new AudioContext(),t=c.currentTime;
  function note(freq,start,dur){
    var o=c.createOscillator(),g=c.createGain();
    o.type='sine';o.frequency.value=freq;
    g.gain.setValueAtTime(0.18,start);
    g.gain.exponentialRampToValueAtTime(0.001,start+dur);
    o.connect(g);g.connect(c.destination);
    o.start(start);o.stop(start+dur);
  }
  note(523.25,t,0.1);
  note(659.25,t+0.1,0.12);
})();
''';

  // 3. Wrong answer — 200Hz low buzz, 150ms, slight vibrato
  static const _wrongSound = '''
(function(){
  var c=new AudioContext(),t=c.currentTime;
  var o=c.createOscillator(),g=c.createGain();
  o.type='sawtooth';o.frequency.value=200;
  o.frequency.setValueAtTime(200,t);
  o.frequency.linearRampToValueAtTime(180,t+0.075);
  o.frequency.linearRampToValueAtTime(210,t+0.15);
  g.gain.setValueAtTime(0.12,t);
  g.gain.exponentialRampToValueAtTime(0.001,t+0.15);
  o.connect(g);g.connect(c.destination);
  o.start();o.stop(t+0.15);
})();
''';

  // 4. Button tap — 1000Hz pop, 30ms
  static const _tapSound = '''
(function(){
  var c=new AudioContext(),g=c.createGain(),o=c.createOscillator();
  o.type='sine';o.frequency.value=1000;
  g.gain.setValueAtTime(0.12,c.currentTime);
  g.gain.exponentialRampToValueAtTime(0.001,c.currentTime+0.03);
  o.connect(g);g.connect(c.destination);
  o.start();o.stop(c.currentTime+0.03);
})();
''';

  // 5. Level up — ascending C5→E5→G5 (523→659→784Hz), 150ms each
  static const _levelUpSound = '''
(function(){
  var c=new AudioContext(),t=c.currentTime;
  function note(freq,start,dur){
    var o=c.createOscillator(),g=c.createGain();
    o.type='sine';o.frequency.value=freq;
    g.gain.setValueAtTime(0.18,start);
    g.gain.exponentialRampToValueAtTime(0.001,start+dur);
    o.connect(g);g.connect(c.destination);
    o.start(start);o.stop(start+dur);
  }
  note(523.25,t,0.15);
  note(659.25,t+0.15,0.15);
  note(783.99,t+0.3,0.2);
})();
''';

  // 6. XP gain — coin ding, 2000Hz, 80ms with decay
  static const _xpGainSound = '''
(function(){
  var c=new AudioContext(),t=c.currentTime;
  var o=c.createOscillator(),g=c.createGain();
  o.type='sine';o.frequency.value=2000;
  g.gain.setValueAtTime(0.15,t);
  g.gain.exponentialRampToValueAtTime(0.001,t+0.08);
  o.connect(g);g.connect(c.destination);
  o.start();o.stop(t+0.08);
})();
''';

  // 7. Session complete — C5→E5→G5→C6 (523→659→784→1047Hz), 100ms each
  static const _sessionCompleteSound = '''
(function(){
  var c=new AudioContext(),t=c.currentTime;
  function note(freq,start,dur){
    var o=c.createOscillator(),g=c.createGain();
    o.type='sine';o.frequency.value=freq;
    g.gain.setValueAtTime(0.18,start);
    g.gain.exponentialRampToValueAtTime(0.001,start+dur);
    o.connect(g);g.connect(c.destination);
    o.start(start);o.stop(start+dur);
  }
  note(523.25,t,0.1);
  note(659.25,t+0.1,0.1);
  note(783.99,t+0.2,0.1);
  note(1046.50,t+0.3,0.15);
})();
''';

  // 8. Card flip — white noise whoosh, 80ms, bandpass filtered
  static const _flipSound = '''
(function(){
  var c=new AudioContext(),t=c.currentTime;
  var buf=c.createBuffer(1,c.sampleRate*0.08,c.sampleRate);
  var data=buf.getChannelData(0);
  for(var i=0;i<data.length;i++) data[i]=(Math.random()*2-1)*0.3;
  var src=c.createBufferSource();src.buffer=buf;
  var f=c.createBiquadFilter();f.type='bandpass';f.frequency.value=1500;f.Q.value=0.8;
  var g=c.createGain();
  g.gain.setValueAtTime(0.2,t);
  g.gain.exponentialRampToValueAtTime(0.001,t+0.08);
  src.connect(f);f.connect(g);g.connect(c.destination);
  src.start();src.stop(t+0.08);
})();
''';
}
