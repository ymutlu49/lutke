/// LÛTKE — İngilizce öğrenme modülü kelime tipi (EnWord).
///
/// Hedef auditor: Kurmancî anadilli kullanıcı → İngilizce öğreniyor.
/// Bütün açıklayıcı alanlar (ku, notKu, herKu) Kurmancî; hedef dil alanları
/// (en, her, ipa) İngilizce. Türkçe bu modülde tutulmaz.
///
/// Veri kaynakları:
///   - Oxford 3000/5000 (CEFR etiketli, kamuya açık)
///   - Cambridge English Vocabulary Profile (referans)
///   - Kurmancî çeviriler: LLM batch (Claude API) + uzman review
///
/// Invariant (test/en_db_quality_test.dart tarafından doğrulanır):
///   - id, en, ku boş olamaz
///   - ipa `/…/` formatında
///   - zor ∈ [0.3, 1.0]
///   - her.length == herKu.length (paralel cümle çiftleri)
///   - her en az bir örnek içermeli
///
/// ### `zor` semantiği (CURRICULUM-WIDE META rehberi — DEĞİŞTİRME):
///
/// `zor` = "kolaylık/tanıdıklık" skoru (Kurmancî L1 açısından).
/// Yani YÜKSEK zor = ÖĞRENCİYE KOLAY geliyor, DÜŞÜK zor = ÖĞRENCİYE ZOR.
/// Bu, FSRS aralık algoritmasıyla uyumludur — kolaya giden kart sık geçilir.
///
/// Hedef ortalama zor değerleri (seviye başına):
///   A1 ≈ 0.85 (yeni başlayan; çoğu kelime kolay/aşina)
///   A2 ≈ 0.78 (pre-intermediate)
///   B1 ≈ 0.70 (intermediate — threshold)
///   B2 ≈ 0.62 (upper-intermediate — vantage)
///   C1 ≈ 0.55 (advanced — effective operational)
///   C2 ≈ 0.45 (mastery — bazı kelimeler 0.30-0.35 düşebilir)
///
/// SAKLAYIN — zor aralıkları seviyeleri karıştırmamalı:
///   - A1 DB'de zor < 0.75 varsa: kelime muhtemelen A2+ seviyesine ait, yanlış yerde.
///   - B1 DB'de zor > 0.82 varsa: kelime muhtemelen A2 seviyesine ait, yanlış yerde.
///   - B1 DB'de zor > 0.82 var AMA kelime (örn. "scarcely", "merely") gerçekten
///     C1 EVP'ye aitse: zor ~0.60-0.65'e düzeltilmeli (hard for B1 learner).
///
/// ### `kat` semantiği (CURRICULUM META):
/// Kategori sözcüğü FSRS key + tema filtreleme için kullanılır.
/// Teknoloji kelimeleri ("computer", "internet", "email", "phone", "text",
/// "message", "video") kat:'teknolojî' olmalı — kat:'ziman' (dil) DEĞİL.
/// kat:'ziman' sadece gerçek dil/dilbilgisi kelimeleri için: "language",
/// "English", "Kurdish", "translate", "word", "sentence" vb.
///
/// ### BICS/CALP ayrımı (CEFR uyumu):
/// A1-B1: heavy BICS (günlük iletişim) — `malbat`, `xwarin`, `rêwîtî`, `civakî`
/// B2+:   CALP bileşeni (akademik) — `akademîk`, `felsefe`, `zanist`, `aborî`,
///        `ramyarî`, `teknîkî`, `huquq`, `pijîşkî`
typedef EnWord = ({
  String id,           // 'en_a1_001' — global benzersiz, level prefix'li
  String en,           // 'water' — hedef kelime (öğrenilen)
  String ku,           // 'av' — Kurmancî karşılık (anadildeki açıklama)
  String ipa,          // '/ˈwɔːtər/' — IPA telaffuz, // ile çevrili
  String pos,          // 'n', 'v', 'adj', 'adv', 'prep', 'interj'...
  String? form,        // 'countable', 'uncountable', 'irregular: go-went-gone'
                       // B1+ için OLMALI; C2 için 0% null kabul edilmez.
  String kat,          // kategori: 'malbat', 'xwarin', 'teknolojî'... (FSRS key)
  double zor,          // 0.3-1.0 kolaylık/tanıdıklık; YÜKSEK = kolay (yukarıdaki
                       // seviye ortalamalarına uyun).
  String? notKu,       // Kurmancî dilbilgisi/kullanım notu + B1+ için
                       // Collocation ipucu verin (ör. "Colloc: make a decision").
  List<String> her,    // Heritage cümleler — İngilizce; mümkünse her 10
                       // kelimeden en az 1'i Kurdî kültürel bağlam içersin
                       // (Newroz, dengbêj, çiya, mitfak, dostanî vb.).
  List<String> herKu,  // Heritage cümlelerin Kurmancî çevirisi (paralel)
  String? emoji,       // Görsel ipucu (opsiyonel, çocuk modu için kritik)
});
