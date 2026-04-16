/// LÛTKE — İngilizce öğrenme modülü kelime tipi.
///
/// Kurmancî anadilli kullanıcılar için İngilizce öğrenme.
/// Açıklamalar Kurmancî, hedef dil İngilizce.
///
/// Veri kaynakları:
/// - Oxford 3000/5000 (CEFR etiketli, kamuya açık)
/// - Cambridge Vocabulary Profile (referans)
/// - Kurmancî çeviriler: LLM batch (Claude API) + uzman review
typedef EnWord = ({
  String id,           // 'en_a1_001'
  String en,           // 'water'
  String ku,           // 'av'
  String ipa,          // '/ˈwɔːtər/' — telaffuz
  String pos,          // 'noun', 'verb', 'adj', 'adv', 'prep'...
  String? form,        // 'irregular: go-went-gone' gibi
  String kat,          // kategori: 'food', 'family', 'travel'...
  double zor,          // 0.3-1.0 zorluk
  String? notKu,       // Kurmancî dilbilgisi notu
  List<String> her,    // heritage cümleler (İngilizce)
  List<String> herKu,  // heritage cümlelerin Kurmancî çevirisi
  String? emoji,       // görsel ipucu
});
