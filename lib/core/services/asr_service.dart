import 'package:flutter/foundation.dart';

import 'web_speech_session.dart';

/// LÛTKE — Otomatik Telaffuz Değerlendirme Servisi (ASR)
///
/// "Telaffuzumuzu kendisi tespit etse" isteği için: kullanıcının
/// konuşmasını tanır, hedef metinle karşılaştırır ve yüzde skoru üretir.
///
/// ── FİZİBİLİTE NOTU (Temmuz 2026) ────────────────────────────
/// HuggingFace Kurmancî ASR yolu araştırıldı:
///   - Model: amedcj/whisper-kurmanji (AppConfig.whisperKurmanciEndpoint)
///     mevcut; ama serverless Inference API HF token ister — web istemci
///     koduna token gömmek güvensiz.
///   - Space: amedcj/Kurmnji-ASR-Demo (Gradio, transcribe_audio fonksiyonu)
///     yazar tarafından PAUSED durumda — istekle uyanmaz.
///   - Space: amedcj/kurmanji_asr_tts → runtime hatasıyla çöküyor.
/// Bu yüzden HF yolu ŞİMDİLİK devre dışı. Space yeniden açılırsa
/// tts_service.dart desenine göre (/gradio_api/upload + /gradio_api/call/
/// transcribe_audio) buraya eklenebilir; AppConfig.enableKurmanciAsr
/// toggle'ı bunun için hazır bekliyor. HF token'lı Inference API iskeleti
/// zaten kurmanci_asr_service.dart'ta duruyor (DisabledKurmanciAsrService
/// varsayılan) — o yol aktifleşince bu servis oradan beslenebilir.
///
/// ── AKTİF YOL: Tarayıcı SpeechRecognition (Web Speech API) ───
/// Kurmancî ('ku') tarayıcılarda desteklenmez; en yakın fallback 'tr-TR'
/// kullanılır (proje genelinde ku_speaking_screen ile aynı yaklaşım).
/// Bu YAKLAŞIK bir tanımadır — diakritik toleranslı normalizasyon
/// (ê→e î→i û→u ç→c ş→s + Türkçe harf katlaması) ile skorlanır ve
/// UI'da "deneysel/yaklaşık" olarak etiketlenmelidir.
///
/// Başarısızlıkta (destek yok, mikrofon izni yok, zaman aşımı, ağ hatası)
/// null döner — çağıran taraf SESSİZCE mevcut öz-değerlendirme akışına
/// düşmelidir. Hata kullanıcıya asla engel olmaz.

/// Skor eşiği: %80+ = başarılı, %50-80 = yaklaştın, altı = tekrar dene.
enum PronunciationVerdict { excellent, close, tryAgain }

/// Otomatik değerlendirme sonucu.
class PronunciationResult {
  /// Tanınan metin (en iyi alternatif).
  final String transcript;

  /// Hedef metinle benzerlik: 0.0 - 1.0 (normalize + Levenshtein).
  final double similarity;

  /// Eşiklere göre karar.
  final PronunciationVerdict verdict;

  /// tr-TR fallback ile mi tanındı (Kurmancî için her zaman true).
  final bool isApproximate;

  const PronunciationResult({
    required this.transcript,
    required this.similarity,
    required this.verdict,
    required this.isApproximate,
  });

  /// UI için yüzde değeri.
  int get percent => (similarity * 100).round();
}

class AsrService {
  AsrService._(); // Statik kullanım — SpeechRecognitionService ile tutarlı

  /// Ortak dinleme motoru — SpeechRecognitionService ile çakışmasın diye
  /// ayrı window anahtarı (`_lutkeAsr*`) kullanılır.
  static final WebSpeechSession _speech = WebSpeechSession('_lutkeAsr');

  static bool get isListening => _speech.isActive;

  /// Tarayıcı desteği (gerçek kontrol JS tarafında yapılır;
  /// desteklenmiyorsa assess() sessizce null döner).
  static bool get isSupported => kIsWeb;

  /// Kullanıcıyı dinle, [target] metniyle karşılaştır, skorla.
  ///
  /// [language]: 'tr-TR' (Kurmancî yakın fallback) veya 'en-US' (İngilizce).
  /// [approximate]: tr-TR fallback kullanılıyorsa true bırak.
  ///
  /// Dinleme sürekli kipte yapılır: öğrenci cümle ortasında duraksasa da
  /// kesilmez; konuşma başladıktan sonra ~1.8 sn sessizlikte, [stop] ile
  /// veya [timeout] dolunca biter ve o ana kadar söylenenler skorlanır.
  ///
  /// Her türlü hatada (ve [cancel] ile iptalde) null döner — çağıran
  /// sessizce fallback yapmalı.
  static Future<PronunciationResult?> assess({
    required String target,
    String language = 'tr-TR',
    bool approximate = true,
    Duration timeout = const Duration(seconds: 15),
  }) async {
    if (!kIsWeb) return null;
    final trimmedTarget = target.trim();
    if (trimmedTarget.isEmpty) return null;

    final outcome = await _speech.listen(
      language: language,
      maxAlternatives: 5,
      timeout: timeout,
    );
    if (outcome == null) return null; // iptal edildi / yeni oturum başladı

    if (!outcome.hasSpeech) {
      // 'not-allowed', 'no-speech', 'unsupported', 'network', 'timeout' vb.
      if (kDebugMode) {
        debugPrint('ASR: sonuç yok — ${outcome.error.isEmpty ? 'ses algılanmadı' : outcome.error}');
      }
      return null;
    }

    // Alternatifler içinden hedefe en yakın olanı seç —
    // tr-TR fallback'te doğru okunuşa en yakın hipotez genelde
    // ilk sırada olmaz.
    var bestText = outcome.transcript;
    var bestSim = 0.0;
    for (final alt in outcome.candidates) {
      final sim = similarity(alt, trimmedTarget);
      if (sim > bestSim) {
        bestSim = sim;
        bestText = alt;
      }
    }

    return PronunciationResult(
      transcript: bestText.trim(),
      similarity: bestSim,
      verdict: verdictFor(bestSim),
      isApproximate: approximate,
    );
  }

  /// Dinlemeyi ZARİF bitir: mikrofon kapanır, o ana kadar söylenenler
  /// skorlanır ve bekleyen [assess] sonucu döndürür (durdur düğmesi için).
  static void stop() => _speech.stop();

  /// Aktif dinlemeyi iptal et (ekran kapanırken/faz değişince çağır).
  /// Bekleyen [assess] null döner.
  static void cancel() => _speech.cancel();

  // ── Skorlama ────────────────────────────────────────────────

  /// İki metnin benzerliği (0.0 - 1.0): normalize + Levenshtein oranı.
  static double similarity(String a, String b) {
    final na = normalize(a);
    final nb = normalize(b);
    if (na.isEmpty || nb.isEmpty) return 0.0;
    if (na == nb) return 1.0;
    final dist = _levenshtein(na, nb);
    final maxLen = na.length > nb.length ? na.length : nb.length;
    // clamp num döndürür — double'a çevir
    return (1.0 - dist / maxLen).clamp(0.0, 1.0).toDouble();
  }

  /// Eşik kararı: %80+ başarılı, %50-80 yaklaştın, altı tekrar dene.
  static PronunciationVerdict verdictFor(double sim) {
    if (sim >= 0.80) return PronunciationVerdict.excellent;
    if (sim >= 0.50) return PronunciationVerdict.close;
    return PronunciationVerdict.tryAgain;
  }

  /// Diakritik toleranslı normalizasyon.
  ///
  /// Kurmancî: ê→e, î→i, û→u, ç→c, ş→s
  /// Türkçe transkript katlaması (tr-TR fallback): ı→i, ö→o, ü→u, ğ→g
  /// Yaklaşık ses katlaması: w→v, x→h (tr-TR tanıyıcısı bu sesleri
  /// Türkçe harflerle yazar; iki taraf da katlandığı için adildir).
  static String normalize(String input) {
    var s = input.toLowerCase().trim();
    // Türkçe 'İ'.toLowerCase() → 'i' + combining dot (U+0307) — temizle
    s = s.replaceAll('\u0307', '');
    const folds = {
      'ê': 'e', 'î': 'i', 'û': 'u', 'ç': 'c', 'ş': 's',
      'ı': 'i', 'ö': 'o', 'ü': 'u', 'ğ': 'g', 'â': 'a', 'é': 'e',
      'w': 'v', 'x': 'h',
    };
    final sb = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      final ch = s[i];
      sb.write(folds[ch] ?? ch);
    }
    s = sb.toString();
    // Noktalama → boşluk, çoklu boşluk → tek boşluk
    s = s.replaceAll(RegExp("[.,!?;:'\"()\\-–—…]"), ' ');
    s = s.replaceAll(RegExp(r'\s+'), ' ').trim();
    return s;
  }

  /// Levenshtein edit mesafesi — iki satırlı bellek-verimli sürüm.
  static int _levenshtein(String a, String b) {
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;
    var prev = List<int>.generate(b.length + 1, (j) => j);
    var curr = List<int>.filled(b.length + 1, 0);
    for (var i = 1; i <= a.length; i++) {
      curr[0] = i;
      for (var j = 1; j <= b.length; j++) {
        final cost = a[i - 1] == b[j - 1] ? 0 : 1;
        var best = prev[j] + 1; // silme
        if (curr[j - 1] + 1 < best) best = curr[j - 1] + 1; // ekleme
        if (prev[j - 1] + cost < best) best = prev[j - 1] + cost; // değiştirme
        curr[j] = best;
      }
      final tmp = prev;
      prev = curr;
      curr = tmp;
    }
    return prev[b.length];
  }
}
