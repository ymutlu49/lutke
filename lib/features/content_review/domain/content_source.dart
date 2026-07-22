import '../../lessons/domain/a1_kelime_db.dart';
import '../../lessons/domain/a2_kelime_db.dart';
import '../../lessons/domain/b1_kelime_db.dart';
import '../../lessons/domain/b2_kelime_db.dart';
import '../../lessons/domain/c1_kelime_db.dart';
import '../../lessons/domain/c2_kelime_db.dart';
import '../../lessons/domain/child_a1_kelime_db.dart';
import '../../lessons/domain/child_a2_kelime_db.dart';
import 'review_models.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Review edilebilir Kurmancî içerik kaynağı
//
// Review Hub, bu sınıftan içerik listesi çeker. Her `ReviewContentType`
// kendi adaptor fonksiyonuyla `ReviewableItem`'a normalize edilir.
// ════════════════════════════════════════════════════════════════

class ContentSource {
  /// Verilen tür + seviye için inceleme listesi getir.
  /// Level: 'A1'|'A2'|'B1'|'B2'|'C1'|'C2'|'child'|'ui'|'all'
  static List<ReviewableItem> list({
    required ReviewContentType type,
    required String level,
    String? search,
  }) {
    final raw = switch (type) {
      ReviewContentType.wordKu => _wordsKu(level),
      ReviewContentType.childWordKu => _childWordsKu(level),
      ReviewContentType.exampleSentenceKu => _exampleSentences(level),
      ReviewContentType.quizKu => _quizItems(level),
      ReviewContentType.dialogueKu => _dialogues(level),
      ReviewContentType.grammarKu => _grammar(level),
      ReviewContentType.readingKu => _reading(level),
      ReviewContentType.culturalKu => _cultural(),
      ReviewContentType.uiKu => _uiStrings(),
    };

    if (search == null || search.trim().isEmpty) return raw;
    final q = search.trim().toLowerCase();
    return raw
        .where((it) =>
            it.text.toLowerCase().contains(q) ||
            it.contentId.toLowerCase().contains(q) ||
            (it.context?.toLowerCase().contains(q) ?? false))
        .toList();
  }

  // ────────────────────────────────────────────────────────
  // Adaptörler
  // ────────────────────────────────────────────────────────

  static List<ReviewableItem> _wordsKu(String level) {
    // Her seviye için Kurmancî kelime listesi.
    final all = _levelToKuList(level);
    return all.map((w) {
      final id = _extractId(w);
      final ku = _extractKu(w);
      final tr = _extractTr(w);
      final kategori = _extractKategori(w);
      return ReviewableItem(
        contentId: id,
        text: ku,
        context: tr.isNotEmpty ? 'TR: $tr' : null,
        level: level,
        kategori: kategori,
      );
    }).toList();
  }

  static List<ReviewableItem> _childWordsKu(String level) {
    final list = switch (level) {
      'A1' => kChildA1Kelimeler,
      'A2' => kChildA2Kelimeler,
      _ => [...kChildA1Kelimeler, ...kChildA2Kelimeler],
    };
    return list.map((w) {
      final id = _extractId(w);
      final ku = _extractKu(w);
      final tr = _extractTr(w);
      return ReviewableItem(
        contentId: id,
        text: ku,
        context: tr.isNotEmpty ? 'TR: $tr' : null,
        level: 'child',
        kategori: _extractKategori(w),
      );
    }).toList();
  }

  static List<ReviewableItem> _exampleSentences(String level) {
    // Heritage örnek cümleler (her kelimenin `her[]`/`herKu[]` alanı).
    final words = _levelToKuList(level);
    final items = <ReviewableItem>[];
    for (final w in words) {
      final id = _extractId(w);
      final ku = _extractKu(w);
      final herKu = _extractHerKu(w);
      for (int i = 0; i < herKu.length; i++) {
        items.add(ReviewableItem(
          contentId: '$id#s$i',
          text: herKu[i],
          context: 'Peyv: $ku',
          level: level,
        ));
      }
    }
    return items;
  }

  static List<ReviewableItem> _quizItems(String level) {
    // Quiz items runtime'da kelime DB'sinden üretiliyor; her soru için
    // ayrı statik liste yok. Onun yerine kelime DB'sindeki notKu alanı
    // (grammar hints) + soru şablonlarını review'e açıyoruz.
    final words = _levelToKuList(level);
    final items = <ReviewableItem>[];
    for (final w in words) {
      final id = _extractId(w);
      final ku = _extractKu(w);
      final notKu = _extractNotKu(w);
      if (notKu != null && notKu.isNotEmpty) {
        items.add(ReviewableItem(
          contentId: '$id#note',
          text: notKu,
          context: 'Peyv: $ku · Nota zimanî',
          level: level,
        ));
      }
    }
    return items;
  }

  static List<ReviewableItem> _dialogues(String level) {
    // Placeholder: proje genelinde merkezî dialogue DB yok.
    // Dialogue_screen'den elle kopyalanmış örnekler buraya eklenecek.
    return const [];
  }

  static List<ReviewableItem> _grammar(String level) {
    // grammar_tips_screen verileri runtime'da üretiliyor.
    return const [];
  }

  static List<ReviewableItem> _reading(String level) {
    return const [];
  }

  static List<ReviewableItem> _cultural() {
    // Kültürel içerik (gotinên pêşiyan, çîrok, lorî) — TODO: import yolu
    return const [];
  }

  static List<ReviewableItem> _uiStrings() {
    // .arb dosyalarından UI metinleri — TODO
    return const [];
  }

  // ────────────────────────────────────────────────────────
  // Yardımcı fonksiyonlar — kelime DB'leri typedef olduğu için
  // runtime'da alanları dynamic okuyoruz.
  // ────────────────────────────────────────────────────────

  static List<dynamic> _levelToKuList(String level) {
    try {
      return switch (level) {
        'A1' => kA1TamListe,
        'A2' => kA2TamListe,
        'B1' => kB1All,
        'B2' => kB2All,
        'C1' => kC1All,
        'C2' => kC2All,
        _ => [...kA1TamListe, ...kA2TamListe],
      } as List<dynamic>;
    } catch (_) {
      return const [];
    }
  }

  static String _extractId(dynamic w) {
    try {
      final d = w as dynamic;
      return (d.id as String?) ?? '';
    } catch (_) {
      return '';
    }
  }

  static String _extractKu(dynamic w) {
    try {
      final d = w as dynamic;
      return (d.ku as String?) ?? '';
    } catch (_) {
      return '';
    }
  }

  static String _extractTr(dynamic w) {
    try {
      final d = w as dynamic;
      return (d.tr as String?) ?? '';
    } catch (_) {
      return '';
    }
  }

  static String? _extractKategori(dynamic w) {
    try {
      final d = w as dynamic;
      return d.kategori as String?;
    } catch (_) {
      try {
        final d = w as dynamic;
        return d.kat as String?;
      } catch (_) {
        return null;
      }
    }
  }

  static List<String> _extractHerKu(dynamic w) {
    try {
      final d = w as dynamic;
      final raw = d.herKu;
      if (raw is List) return raw.whereType<String>().toList();
      return const [];
    } catch (_) {
      return const [];
    }
  }

  static String? _extractNotKu(dynamic w) {
    try {
      final d = w as dynamic;
      return d.notKu as String?;
    } catch (_) {
      return null;
    }
  }
}
