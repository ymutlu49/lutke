// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Çocuk Kültürel İçerik
//
// 7-10 yaş grubuna uygun kültürel içerikler:
//   - Lorî (ninniler)
//   - Kısa çîrok (halk masalları)
//   - Basit atasözleri
//   - Newroz ve bayram açıklamaları
// ════════════════════════════════════════════════════════════════

enum ChildCulturalType {
  lori,         // Ninni
  cirok,        // Kısa masal
  gotin,        // Basit atasözü
  cejna,        // Bayram/kutlama
  stran,        // Çocuk şarkısı
}

class ChildCulturalItem {
  final String id;
  final ChildCulturalType type;
  final String titleKu;
  final String titleTr;
  final String contentKu;
  final String contentTr;
  final String emoji;
  final String? audioAsset;
  final int level; // 1=A1, 2=A2

  const ChildCulturalItem({
    required this.id,
    required this.type,
    required this.titleKu,
    required this.titleTr,
    required this.contentKu,
    required this.contentTr,
    required this.emoji,
    this.audioAsset,
    this.level = 1,
  });
}

/// Çocuk kültürel içerik koleksiyonu.
const kChildCulturalItems = [

  // ── Lorî (Ninniler) ───────────────────────────────────────

  ChildCulturalItem(
    id: 'child_c_001',
    type: ChildCulturalType.lori,
    titleKu: 'Lorî — Lawo Lawo',
    titleTr: 'Ninni — Yavrum Yavrum',
    contentKu: 'Lawo lawo, rahêje,\nDê li ber derê ye,\nBav li ser banê ye,\nRazê lawo, razê.',
    contentTr: 'Yavrum yavrum, sus,\nAnne kapının önünde,\nBaba damın üstünde,\nUyu yavrum, uyu.',
    emoji: '🌙',
  ),

  ChildCulturalItem(
    id: 'child_c_002',
    type: ChildCulturalType.lori,
    titleKu: 'Lorî — Heyva min',
    titleTr: 'Ninni — Ay\'ım',
    contentKu: 'Heyva min, stêra min,\nTu xweşiya dêya min,\nRazê lawo, bêdeng be,\nSibê roj dê were.',
    contentTr: 'Ay\'ım, yıldızım,\nAnnemin güzelliğisin,\nUyu yavrum, sessiz ol,\nYarın güneş gelecek.',
    emoji: '⭐',
  ),

  // ── Çîrok (Kısa Masallar) ─────────────────────────────────

  ChildCulturalItem(
    id: 'child_c_010',
    type: ChildCulturalType.cirok,
    titleKu: 'Rovî û Tirî',
    titleTr: 'Tilki ve Üzüm',
    contentKu: 'Rovî li tirî dinêre.\nTirî bilind e.\nRovî napêje.\nRovî dibêje: "Tirî tirş e!"',
    contentTr: 'Tilki üzüme bakıyor.\nÜzüm yüksekte.\nTilki yetişemiyor.\nTilki diyor: "Üzüm ekşi!"',
    emoji: '🦊',
  ),

  ChildCulturalItem(
    id: 'child_c_011',
    type: ChildCulturalType.cirok,
    titleKu: 'Karîkê Biçûk',
    titleTr: 'Küçük Oğlak',
    contentKu: 'Karîkê biçûk li çiyê ye.\nEw dixwaze stêrkan bibîne.\nŞev tê, stêr derdikevin.\nKarîk kêfxweş e!',
    contentTr: 'Küçük oğlak dağda.\nYıldızları görmek istiyor.\nGece oluyor, yıldızlar çıkıyor.\nOğlak mutlu!',
    emoji: '🐐',
  ),

  // ── Gotinên Pêşiyan (Basit Atasözleri) ────────────────────

  ChildCulturalItem(
    id: 'child_c_020',
    type: ChildCulturalType.gotin,
    titleKu: 'Ziman dermanê dilê mirov e',
    titleTr: 'Dil, insanın kalbinin ilacıdır',
    contentKu: 'Ziman dermanê dilê mirov e.\nHer kes bi zimanê xwe xweş e.',
    contentTr: 'Dil, insanın kalbinin ilacıdır.\nHerkes kendi dilinde güzeldir.',
    emoji: '💬',
  ),

  ChildCulturalItem(
    id: 'child_c_021',
    type: ChildCulturalType.gotin,
    titleKu: 'Yek û yek du dike',
    titleTr: 'Bir ve bir iki eder (Birlik güçtür)',
    contentKu: 'Yek û yek du dike.\nEm bi hev re bihêztir in!',
    contentTr: 'Bir ve bir iki eder.\nBirlikte daha güçlüyüz!',
    emoji: '🤝',
  ),

  // ── Cejna (Bayramlar) ─────────────────────────────────────

  ChildCulturalItem(
    id: 'child_c_030',
    type: ChildCulturalType.cejna,
    titleKu: 'Newroz — Cejna Biharê',
    titleTr: 'Nevruz — Bahar Bayramı',
    contentKu: 'Newroz — 21ê Adarê.\nBihar tê! Roj mezin dibe.\nEm agir vêdixin.\nEm stranan dibêjin û dilîzin.\nNewroz pîroz be!',
    contentTr: 'Nevruz — 21 Mart.\nBahar geliyor! Günler uzuyor.\nAteş yakıyoruz.\nŞarkı söylüyor ve oynuyoruz.\nNevruz kutlu olsun!',
    emoji: '🔥',
  ),

  // ── Stran (Çocuk Şarkısı) ─────────────────────────────────

  ChildCulturalItem(
    id: 'child_c_040',
    type: ChildCulturalType.stran,
    titleKu: 'Strana Hejmaran',
    titleTr: 'Sayı Şarkısı',
    contentKu: 'Yek, du, sê — were pê re!\nÇar, pênc, şeş — em şa ne!\nHeft, heşt, neh — werin hev!\nDeh! Em hejmaran dizanin!',
    contentTr: 'Bir, iki, üç — gel birlikte!\nDört, beş, altı — mutluyuz!\nYedi, sekiz, dokuz — gelin birlikte!\nOn! Sayıları biliyoruz!',
    emoji: '🎵',
  ),
];
