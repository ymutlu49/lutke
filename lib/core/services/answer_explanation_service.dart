/// LÛTKE — "Açıkla Cevabım" (Explain My Answer) Servisi
///
/// Duolingo Max tarzı özellik — yanlış cevaba Kurmancî gramer açıklaması.
/// Şu an rule-based (deterministic, offline, $0). İleride LLM (Claude
/// Haiku / Gemini Flash) ile değiştirilebilecek arayüz hazır.
///
/// Kural Tabanı:
/// 1. Ergatif fark (min/te/wî/wê farkı)
/// 2. Veqetandek zinciri (-ê, -a, -ên, -î)
/// 3. Subjunctive "bi-" vs indicative "di-"
/// 4. Past perfect "-bû" eki
/// 5. Diakritik (ê vs e, î vs i, û vs u)
/// 6. Ergatif olumsuz "ne-" eki
/// 7. Pasif "tê + mastar"
/// 8. Karşılaştırma -tir/-tirîn
/// 9. Feminen/Maskülen nesne uyumu
/// 10. Genel — kategorik fark (anlam benzerliği)

class AnswerExplanation {
  final String explanationKu;
  final String explanationTr;
  final String? grammarRule;     // "[BH] §170" gibi
  final String? tipKu;           // Ek ipucu

  const AnswerExplanation({
    required this.explanationKu,
    required this.explanationTr,
    this.grammarRule,
    this.tipKu,
  });
}

abstract class AnswerExplanationService {
  /// Yanlış cevap için açıklama üret.
  /// Offline rule-based veya (ileride) LLM çağrısı yapar.
  Future<AnswerExplanation> explain({
    required String prompt,
    required String userAnswer,
    required String correctAnswer,
    String? grammarNote,
  });
}

// ════════════════════════════════════════════════════════════════
// RULE-BASED IMPLEMENTATION (varsayılan — LLM gerekmez)
// ════════════════════════════════════════════════════════════════

class RuleBasedExplanationService extends AnswerExplanationService {
  @override
  Future<AnswerExplanation> explain({
    required String prompt,
    required String userAnswer,
    required String correctAnswer,
    String? grammarNote,
  }) async {
    final u = userAnswer.trim();
    final c = correctAnswer.trim();

    // ── 1. Ergatif zamir farkları ─────────────────────────
    const ergativeMap = {
      'ez': 'min', 'tu': 'te', 'ew': 'wî/wê',
      'em': 'me', 'hûn': 'we', 'ew (pl)': 'wan',
    };
    final uLow = u.toLowerCase();
    if (ergativeMap.containsKey(uLow) && ergativeMap[uLow] == c) {
      return AnswerExplanation(
        explanationKu:
            'Di dema borî ya gerguhêz (ergatîf) de kirde di halê tewangê de ye: '
            '"$uLow" → "$c".',
        explanationTr:
            'Ergatif geçmişte özne eğik halde olur: "$uLow" → "$c".',
        grammarRule: '[BH] §170 Ergatif Sistem',
        tipKu: 'Wek: ez → min xwend, tu → te dît, ew → wî got.',
      );
    }

    // ── 2. Olumsuzluk "ne-" eki ───────────────────────────
    if (c.startsWith('ne') && !u.startsWith('ne') &&
        c.substring(2) == u) {
      return AnswerExplanation(
        explanationKu:
            'Forma neyînî ya dema borî bi pêşgira "ne-" tê çêkirin: "$u" → "$c".',
        explanationTr:
            'Geçmiş zaman olumsuzluğu "ne-" öneki ile kurulur: "$u" → "$c".',
        grammarRule: '[TH] §77 Dema Borî ya Neyînî',
      );
    }

    // ── 3. Subjunctive "bi-" eki ──────────────────────────
    if (c.startsWith('bi') && !u.startsWith('bi') &&
        _similarTail(u, c, 2)) {
      return AnswerExplanation(
        // NOT: Standard Kurmancî grammar term is "Dema Bilanî" (subjunctive).
        explanationKu:
            'Dema bilanî (subjunctive) bi pêşgira "bi-" tê çêkirin: "$c".',
        explanationTr:
            'Dilek-şart kipi "bi-" öneki ile kurulur: "$c".',
        grammarRule: '[BH] §190 Dema Bilanî',
        tipKu: 'Mînak: "ez dikim" (niha) → "ez bikim" (bilanî).',
      );
    }

    // ── 4. Karşılaştırma -tir ────────────────────────────
    if (c.endsWith('tir') && !u.endsWith('tir')) {
      return AnswerExplanation(
        explanationKu:
            'Berawirdkirin (comparative) bi paşgira "-tir" tê çêkirin: "$c".',
        explanationTr:
            'Karşılaştırma "-tir" ekiyle yapılır: "$c".',
        grammarRule: '[TH] §85 Rengdêrê Berawirdkirinê',
      );
    }
    if (c.endsWith('tirîn') && !u.endsWith('tirîn')) {
      return AnswerExplanation(
        // NOT: "Bilindahî" = yükseklik/irtifa; superlative için "Pileya herî bilind".
        explanationKu:
            'Pileya herî bilind (superlative) bi paşgira "-tirîn" tê çêkirin: "$c".',
        explanationTr:
            '"En" ifadesi "-tirîn" ekiyle yapılır: "$c".',
        grammarRule: '[TH] §86 Pileya Herî Bilind',
      );
    }

    // ── 5. Past perfect "-bû" ────────────────────────────
    if (c.endsWith('bû') && !u.endsWith('bû')) {
      return AnswerExplanation(
        explanationKu:
            'Dema borî ya dûr (past perfect) bi paşgira "-bû" tê çêkirin: "$c".',
        explanationTr:
            'Uzak geçmiş "-bû" ekiyle oluşur: "$c" (gelmişti).',
        grammarRule: '[TH] §73',
      );
    }

    // ── 6. Perfect "-iye/-ye" ────────────────────────────
    if ((c.endsWith('iye') || c.endsWith('ye')) &&
        !(u.endsWith('iye') || u.endsWith('ye'))) {
      return AnswerExplanation(
        explanationKu:
            'Dema temambûyî (perfect) bi paşgira "-iye/-ye" tê çêkirin: "$c".',
        explanationTr:
            'Şimdiki mükemmel "-iye/-ye" ekiyle: "$c" (gelmiş).',
        grammarRule: '[TH] §72',
      );
    }

    // ── 7. Sürekli geçmiş "di-" ──────────────────────────
    if (c.startsWith('di') && !u.startsWith('di') &&
        _similarTail(u, c, 2)) {
      return AnswerExplanation(
        explanationKu:
            'Dema berdewam a borî bi pêşgira "di-" tê çêkirin: "$c".',
        explanationTr:
            'Sürekli geçmiş (hikaye) "di-" önekiyle: "$c" (yapıyordu).',
        grammarRule: '[TH] §70',
      );
    }

    // ── 8. Diakritik fark ────────────────────────────────
    final diaDiff = _diacriticDiff(u, c);
    if (diaDiff != null) {
      return AnswerExplanation(
        explanationKu:
            'Diakritîk cihê girîng e: "$u" ≠ "$c". Ferq: "$diaDiff".',
        explanationTr:
            'Diakritik farkı önemli: "$u" ≠ "$c". Fark: "$diaDiff".',
        grammarRule: 'Bedirxan-Hawar Norm',
        tipKu: 'ê/e, î/i, û/u ayrı fonemlerdir.',
      );
    }

    // ── 9. Veqetandek (kısmî) ─────────────────────────────────
    if (_hasVeqetandekDiff(u, c)) {
      return AnswerExplanation(
        explanationKu:
            'Paşgira veqetandekê (veqetandek) divê bi zayend û hejmar re li hev be: "$c".',
        explanationTr:
            'Veqetandek eki cins ve sayıyla uyumlu olmalı: eril "-ê", dişil "-a", '
            'çoğul "-ên". Doğrusu: "$c".',
        grammarRule: '[BH] §160 Veqetandek',
      );
    }

    // ── 10. GENEL / Fallback ─────────────────────────────
    // grammarNote varsa onu kullan.
    if (grammarNote != null && grammarNote.isNotEmpty) {
      return AnswerExplanation(
        explanationKu: 'Bersiva rast: "$c".',
        explanationTr: grammarNote,
        tipKu: 'Wek: $c',
      );
    }

    return AnswerExplanation(
      // Nazik û perwerdeyî — çewtî ne xirab e, firsendek e ji bo fêrbûnê.
      explanationKu:
          'Bersiva rast "$c" ye. "$u" ne rast bû — bala xwe bide forma peyvê û watayê. Careke din diceribîne!',
      explanationTr:
          'Doğru cevap "$c". "$u" yanlıştı — kelimenin formuna ve anlamına dikkat et. Tekrar deneyelim!',
    );
  }

  /// Son 2 harfi hariç tut, gövdenin benzer olup olmadığına bak.
  bool _similarTail(String a, String b, int prefixLen) {
    if (b.length <= prefixLen) return false;
    final bBody = b.substring(prefixLen);
    return a.contains(bBody) || bBody.contains(a);
  }

  /// Diakritik farkı kontrol et.
  String? _diacriticDiff(String a, String b) {
    if (a.length != b.length) return null;
    final map = {'ê': 'e', 'î': 'i', 'û': 'u', 'ç': 'c', 'ş': 's'};
    for (int i = 0; i < a.length; i++) {
      final ca = a[i];
      final cb = b[i];
      if (ca == cb) continue;
      if (map[cb] == ca || map[ca] == cb) {
        return '$ca ≠ $cb';
      }
    }
    return null;
  }

  /// Kısmi veqetandek farkı (basit heuristic).
  bool _hasVeqetandekDiff(String a, String b) {
    final ezafes = ['ê', 'a', 'ên', 'î', 'ya', 'yê'];
    for (final e in ezafes) {
      if (b.endsWith(' $e') && !a.endsWith(' $e')) return true;
    }
    return false;
  }
}

/// Gelecekte LLM desteği için iskelet.
/// Claude Haiku / Gemini Flash entegrasyonunda kullanılacak.
class LlmExplanationService extends AnswerExplanationService {
  final String apiKey;
  final String model; // 'claude-haiku-3-5' | 'gemini-2.0-flash'
  final AnswerExplanationService fallback;

  LlmExplanationService({
    required this.apiKey,
    required this.model,
    AnswerExplanationService? fallback,
  }) : fallback = fallback ?? RuleBasedExplanationService();

  @override
  Future<AnswerExplanation> explain({
    required String prompt,
    required String userAnswer,
    required String correctAnswer,
    String? grammarNote,
  }) async {
    // TODO: HTTP POST → Claude/Gemini endpoint
    // Şimdilik fallback'e düş — feature flag hazır
    return fallback.explain(
      prompt: prompt,
      userAnswer: userAnswer,
      correctAnswer: correctAnswer,
      grammarNote: grammarNote,
    );
  }
}

/// Feature flag: `lib/core/services/app_config.dart` üzerinden aktif edilebilir.
AnswerExplanationService get defaultAnswerExplanationService =>
    RuleBasedExplanationService();
