// ════════════════════════════════════════════════════════════════
// KÜLTÜREL İÇERİK ENTITY'LERİ
//
// Araştırma Bulgusu #6: Kültürel içerik (türküler, atasözleri)
// "olsa güzel" değil, asıl öğrenme motivasyonu.
// Zeynep TikTok'tan öğreniyor, Hasan türküler "içinde bir yerde
// duruyor" diyor. Bu içerik ek özellik değil, zorunlu çekirdek.
//
// Kaynak: Institut Kurde Paris, Bedir Han & Lescot, Kürt edebiyat geleneği
// ════════════════════════════════════════════════════════════════

enum CulturalContentType {
  // ── 1. Gotin û Edebiyat (Söz ve Edebiyat) ─────────────────
  proverb,       // Gotinên Pêşiyan — Atasözü
  story,         // Destan û Çîrok — Destan/Hikâye
  poem,          // Helbest — Şiir metni
  song,          // Stran — Türkü/şarkı metni

  // ── 2. Kesayet (Kişiler) ──────────────────────────────────
  singer,        // Stranbêj — Türkücü
  poet,          // Helbestvan — Şair
  writer,        // Nivîskar — Yazar
  historicalFigure, // Kesayetên Dîrokî — Tarihi Kişi

  // ── 3. Jiyan û Adet (Yaşam ve Gelenek) ────────────────────
  foodTradition, // Xwarinên Kurdî — Geleneksel Yemekler
  celebration,   // Cejn — Bayram/Festival (Newroz, Çarşema Sor...)
  folkDance,     // Govend & Cil û Berg — Halay & Geleneksel Kıyafet

  // ── 4. Dîrok û Mîras (Tarih ve Miras) ─────────────────────
  historicalEvent, // Bûyerên Dîrokî — Tarihi Olay
  architecture,    // Mîmariya Kurdî — Kürt Mimarisi
}

/// Çand sayfasındaki gruplar — UI tab navigation için.
/// Her grup ilgili CulturalContentType'ları kapsar.
enum CulturalGroup {
  all,            // Hemû
  literature,     // Gotin û Edebiyat
  people,         // Kesayet
  lifeTradition,  // Jiyan û Adet
  historyHeritage, // Dîrok û Mîras
}

extension CulturalGroupX on CulturalGroup {
  String get labelKu => switch (this) {
        CulturalGroup.all => 'Hemû',
        CulturalGroup.literature => 'Gotin û Edebiyat',
        CulturalGroup.people => 'Kesayet',
        CulturalGroup.lifeTradition => 'Jiyan û Adet',
        CulturalGroup.historyHeritage => 'Dîrok û Mîras',
      };

  String get labelTr => switch (this) {
        CulturalGroup.all => 'Hepsi',
        CulturalGroup.literature => 'Söz & Edebiyat',
        CulturalGroup.people => 'Kişiler',
        CulturalGroup.lifeTradition => 'Yaşam & Gelenek',
        CulturalGroup.historyHeritage => 'Tarih & Miras',
      };

  /// Gruba ait alt-tipler.
  List<CulturalContentType> get types => switch (this) {
        CulturalGroup.all => CulturalContentType.values,
        CulturalGroup.literature => const [
            CulturalContentType.proverb,
            CulturalContentType.story,
            CulturalContentType.poem,
            CulturalContentType.song,
          ],
        CulturalGroup.people => const [
            CulturalContentType.singer,
            CulturalContentType.poet,
            CulturalContentType.writer,
            CulturalContentType.historicalFigure,
          ],
        CulturalGroup.lifeTradition => const [
            CulturalContentType.foodTradition,
            CulturalContentType.celebration,
            CulturalContentType.folkDance,
          ],
        CulturalGroup.historyHeritage => const [
            CulturalContentType.historicalEvent,
            CulturalContentType.architecture,
          ],
      };
}

/// İçerik türünden grubuna ulaşma — UI filtreleme için.
CulturalGroup groupOf(CulturalContentType type) {
  for (final g in CulturalGroup.values) {
    if (g == CulturalGroup.all) continue;
    if (g.types.contains(type)) return g;
  }
  return CulturalGroup.all;
}

class CulturalItem {
  final String id;
  final CulturalContentType type;
  final String kurmanjTitle;     // Kurmancî başlık — birincil
  final String turkishTitle;     // Türkçe başlık — ikincil
  final String kurmanjContent;   // Ana içerik (Kurmancî)
  final String turkishContent;   // Türkçe çeviri/açıklama
  final String? audioAsset;      // Ses dosyası
  final String? backgroundNote;  // Kültürel arka plan notu
  final int level;               // 1=A1, 2=A2, 3=B1, 4=B2
  final String unitId;           // Hangi birimle bağlantılı
  final List<String> keywords;   // İlgili kelimeler

  const CulturalItem({
    required this.id,
    required this.type,
    required this.kurmanjTitle,
    required this.turkishTitle,
    required this.kurmanjContent,
    required this.turkishContent,
    this.audioAsset,
    this.backgroundNote,
    required this.level,
    required this.unitId,
    this.keywords = const [],
  });

  String get typeLabel => switch (type) {
        CulturalContentType.proverb => 'Gotinên Pêşiyan',
        CulturalContentType.song => 'Stran',
        CulturalContentType.poem => 'Helbest',
        CulturalContentType.story => 'Destan û Çîrok',
        CulturalContentType.foodTradition => 'Xwarinên Kurdî',
        CulturalContentType.historicalFigure => 'Kesayetên Dîrokî',
        CulturalContentType.singer => 'Stranbêj',
        CulturalContentType.poet => 'Helbestvan',
        CulturalContentType.writer => 'Nivîskar',
        CulturalContentType.celebration => 'Cejn',
        CulturalContentType.folkDance => 'Govend û Cil û Berg',
        CulturalContentType.historicalEvent => 'Bûyerên Dîrokî',
        CulturalContentType.architecture => 'Mîmariya Kurdî',
      };

  String get typeTurkish => switch (type) {
        CulturalContentType.proverb => 'Atasözü',
        CulturalContentType.song => 'Türkü',
        CulturalContentType.poem => 'Şiir',
        CulturalContentType.story => 'Destan/Hikâye',
        CulturalContentType.foodTradition => 'Geleneksel Yemek',
        CulturalContentType.historicalFigure => 'Tarihi Kişilik',
        CulturalContentType.singer => 'Türkücü',
        CulturalContentType.poet => 'Şair',
        CulturalContentType.writer => 'Yazar',
        CulturalContentType.celebration => 'Bayram/Festival',
        CulturalContentType.folkDance => 'Halay & Kıyafet',
        CulturalContentType.historicalEvent => 'Tarihi Olay',
        CulturalContentType.architecture => 'Mimari Eser',
      };
}

// ════════════════════════════════════════════════════════════════
// A1 KÜLTÜREL İÇERİK — SEED VERİSİ
// Her birim için en az 1 kültürel içerik
// Kaynak: Institut Kurde Paris, Lescot Textes Kurdes
// ════════════════════════════════════════════════════════════════

const kCulturalItems = [

  // ── Birim 1: Alfabe û Dengên Kurmancî ────────────────────────
  // unitId: 'u1' ✓
  CulturalItem(
    id: 'c_001',
    type: CulturalContentType.proverb,
    kurmanjTitle: 'Ziman dermanê dilê mirov e',
    turkishTitle: 'Dil, kalbin ilacıdır',
    kurmanjContent: 'Ziman dermanê dilê mirov e.',
    turkishContent: 'Dil, insanın kalbinin ilacıdır.',
    backgroundNote:
        'Kurmancî yazılı edebiyatta yüzyıllardır yaşayan bu söz, '
        'dilin yalnızca iletişim değil, ruh sağlığı için de hayati '
        'olduğunu anlatır. Asimile edilmiş Kürtlerin dilleriyle '
        'yeniden buluşmasının neden bu kadar önemli olduğunu '
        'tek bir cümleyle özetler.',
    level: 1,
    unitId: 'u1',
    keywords: ['ziman', 'derman', 'dil', 'mirov'],
    audioAsset: 'assets/audio/cultural/c_001.mp3',
  ),

  // ── Birim 2: Silavdan û Pêşkêşkirin ──────────────────────────
  // unitId: 'u2' ✓
  CulturalItem(
    id: 'c_002',
    type: CulturalContentType.proverb,
    kurmanjTitle: 'Silav keça xweşbextiyê ye',
    turkishTitle: 'Selamlama mutluluğun kızıdır',
    kurmanjContent:
        'Silav keça xweşbextiyê ye.\n'
        'Her silav deriyekê vedike.',
    turkishContent:
        'Selamlama mutluluğun kızıdır.\n'
        'Her selamlama bir kapı açar.',
    backgroundNote:
        'Kürt kültüründe selamlama yalnızca nezaket değil, toplumsal '
        'bağı kuran ritüeldir. Köylerde yolda karşılaşanlar birbirini '
        'selamlamadan geçmez — bu sosyal sözleşmenin parçasıdır. '
        '"Silav" sözü söylenmek için büyük veya küçük fark etmez.',
    level: 1,
    unitId: 'u2',
    keywords: ['silav', 'xweşbextî', 'derî', 'malbat'],
    audioAsset: 'assets/audio/cultural/c_002.mp3',
  ),

  // ── Birim 3: Jimar ───────────────────────────────────────────
  // unitId: 'u3' ✓ (önceki 'u5' yanlıştı)
  CulturalItem(
    id: 'c_005',
    type: CulturalContentType.proverb,
    kurmanjTitle: 'Yek û yek du dike',
    turkishTitle: 'Birlik kuvvettir',
    kurmanjContent:
        'Yek û yek du dike,\n'
        'Du û du çar dike.\n'
        'Bi hev re em hêztir in.',
    turkishContent:
        'Bir ve bir iki eder,\n'
        'İki ve iki dört eder.\n'
        'Birlikte daha güçlüyüz.',
    backgroundNote:
        'Kürt kültüründe dayanışma (hevkarî) temel değerdir. '
        'Bu atasözü sayı öğretirken birlik vurgusunu da taşır. '
        'Kürt tarihinde dağınıklık ve birliktelik sürekli bir gerilim '
        'olmuş; bu söz bu gerilimi basit sayılarla ifade eder.',
    level: 1,
    unitId: 'u3',
    keywords: ['yek', 'du', 'çar', 'hev', 'hêz'],
    audioAsset: 'assets/audio/cultural/c_005.mp3',
  ),

  // ── Birim 5: Malbat ──────────────────────────────────────────
  // unitId: 'u5' ✓ (önceki 'u3' yanlıştı)
  CulturalItem(
    id: 'c_003',
    type: CulturalContentType.song,
    kurmanjTitle: 'Lorî — Ninîno',
    turkishTitle: 'Ninni — Ninîno',
    kurmanjContent:
        'Ninîno, ninîno,\n'
        'Kuro, kurê dayika min,\n'
        'Ninîno, ninîno,\n'
        'Çavên te bên xewê...',
    turkishContent:
        'Ninîno, ninîno,\n'
        'Oğlum, annemin oğlu,\n'
        'Ninîno, ninîno,\n'
        'Gözlerine uyku gelsin...',
    backgroundNote:
        'Kürt ninnileri (lorî) Kürt annelerinin ve büyükanelerin '
        'en kadim sözlü geleneğidir. Kuşaktan kuşağa ağızdan '
        'aktarılan bu ninniler, asimilasyon döneminde bile '
        'pek çok çocuğun duyduğu ilk Kurmancî sözlerdi. '
        '"Ninîno" sesi — anlamsız ama sonsuz teselli eden.',
    level: 1,
    unitId: 'u5',
    keywords: ['ninî', 'kur', 'dayik', 'çav', 'xew'],
    audioAsset: 'assets/audio/cultural/c_003.mp3',
  ),

  // ── Birim 6: Cînavk ──────────────────────────────────────────
  // unitId: 'u6' — YENİ EKLENDI
  // Kürtçede "xwe" zamirinin önemi
  CulturalItem(
    id: 'c_007',
    type: CulturalContentType.proverb,
    kurmanjTitle: 'Xwe nas bike',
    turkishTitle: 'Kendini tanı',
    kurmanjContent:
        'Xwe nas bike, paşê dinyayê nas bike.\n'
        'Kesê xwe nenas, tu tiştî nenas.',
    turkishContent:
        'Önce kendini tanı, sonra dünyayı tanı.\n'
        'Kendini tanımayan, hiçbir şeyi tanımaz.',
    backgroundNote:
        'Kürt felsefi geleneğinde öz-bilinç (xwe nasîn) temel erdemdir. '
        '"Xwe" dönüşlü zamiri — "kendim, kendi" — Kurmancîde '
        'kimliği ifade eden en önemli kelimelerden biridir. '
        'Asimile Kürtler için bu atasözü özellikle anlamlıdır.',
    level: 1,
    unitId: 'u6',
    keywords: ['xwe', 'nas', 'kes', 'dunya'],
    audioAsset: 'assets/audio/cultural/c_007.mp3',
  ),

  // ── Birim 9: Xwarin û Vexwarin ───────────────────────────────
  // unitId: 'u9' ✓ (önceki 'u4' yanlıştı)
  CulturalItem(
    id: 'c_004',
    type: CulturalContentType.foodTradition,
    kurmanjTitle: 'Nan û xwê — Ekmek ve tuz',
    turkishTitle: 'Kürt sofrasının kutsallığı',
    kurmanjContent:
        'Mêvanê xwe nan û xwê bide.\n'
        'Nan û xwê girêdanê digire.\n\n'
        'Destê te xweş be!',
    turkishContent:
        'Misafirine ekmek ve tuz sun.\n'
        'Ekmek ve tuz bağ kurar.\n\n'
        'Elinize sağlık!',
    backgroundNote:
        'Kürt kültüründe "nan û xwê" (ekmek ve tuz) misafirperverliğin '
        'simgesidir. Birine ekmek tuzla ikram etmek derin bir bağ '
        'kurmak anlamına gelir. Sofrada büyüklere önce tabak '
        'uzatmak ve "Destê te xweş be" demek temel saygı ifadesidir. '
        '"Nûş be!" — afiyet olsun — yemek sonrası zorunlu vedadır.',
    level: 1,
    unitId: 'u9',
    keywords: ['nan', 'xwê', 'mêvan', 'girêdan', 'destê te xweş be'],
    audioAsset: 'assets/audio/cultural/c_004.mp3',
  ),

  // ── Birim 10: Endamên Bedenê û Tenduristî ───────────────────
  // unitId: 'u10' — YENİ EKLENDI
  CulturalItem(
    id: 'c_009',
    type: CulturalContentType.proverb,
    kurmanjTitle: 'Tenduristî dewlemendiya mezin e',
    turkishTitle: 'Sağlık en büyük zenginliktir',
    kurmanjContent:
        'Tenduristî dewlemendiya mezin e.\n'
        'Kesê nexweş, her tişt nexweş e.\n\n'
        'Dê û bav, zarokên xwe biparêzin.',
    turkishContent:
        'Sağlık en büyük zenginliktir.\n'
        'Hasta olan, her şeyi hasta görür.\n\n'
        'Anne babalar, çocuklarını korusunlar.',
    backgroundNote:
        'Kürt kültüründe sağlık (tenduristî) manevi ve fiziksel bütünlüğü '
        'ifade eder. Aile büyüklerinin sağlığına önem vermek, '
        'ziyaret etmek ve hal hatır sormak temel görev sayılır. '
        '"Tu çawa yî?" sorusu bu ilginin somut ifadesidir.',
    level: 1,
    unitId: 'u10',
    keywords: ['tenduristî', 'nexweş', 'dewlemendî', 'parastin'],
    audioAsset: 'assets/audio/cultural/c_009.mp3',
  ),

  // ── Birim 12: Rengdêr û Peyvên Bingehîn ─────────────────────
  // unitId: 'u12' — YENİ EKLENDI
  // Ehmedê Xanî'den sıfat kullanımı + Kürtçe atasözleri
  CulturalItem(
    id: 'c_011',
    type: CulturalContentType.poem,
    kurmanjTitle: 'Ehmedê Xanî — Mem û Zîn\'den',
    turkishTitle: 'Ehmedê Xanî — Mem ve Zin\'den',
    kurmanjContent:
        'Kurd û kurdanî gelek baş in,\n'
        'Lê bê yekîtî, bê hêz in.\n\n'
        'Zimanê me xweş e, dewlemend e —\n'
        'Em divê wî biparêzin.',
    turkishContent:
        'Kürtler ve Kürtlük çok iyidir,\n'
        'Ama birliksiz, güçsüzdür.\n\n'
        'Dilimiz güzel, zengindir —\n'
        'Onu korumalıyız.',
    backgroundNote:
        'Ehmedê Xanî (1651–1707) Kürt edebiyatının en büyük ismidir. '
        '"Mem û Zîn" (1695) — Kürt Romeo ve Juliet\'i — '
        'sıfatları ustalıkla kullanan bir başyapıttır. '
        'Xanî bu eserinde "baş, xerab, mezin, biçûk, xweş, zehmet" '
        'gibi sıfatlarla duygusal derinlik yaratmıştır. '
        'B1\'de tam metin çalışılır.',
    level: 1,
    unitId: 'u12',
    keywords: ['baş', 'hêz', 'xweş', 'dewlemend', 'Xanî', 'ziman'],
    audioAsset: 'assets/audio/cultural/c_011.mp3',
  ),

  // ── A2 Önizleme ──────────────────────────────────────────────
  CulturalItem(
    id: 'c_a2_001',
    type: CulturalContentType.poem,
    kurmanjTitle: 'Cegerxwîn — Ji "Kurdistan"',
    turkishTitle: 'Cegerxwîn — "Kurdistan\'dan"',
    kurmanjContent:
        'Kurdistan welê min e,\n'
        'Çiyayên wê çiyayên min in,\n'
        'Çemên wê çemên min in...',
    turkishContent:
        'Kürdistan benim vatanım,\n'
        'Onun dağları benim dağlarım,\n'
        'Onun nehirleri benim nehirlerim...',
    backgroundNote:
        'Cegerxwîn (1903-1984) Kürt edebiyatının en büyük şairlerinden '
        'biridir. Modern Kurmancî şiirinin öncüsü sayılır. Bu dizeler '
        'onun en tanınmış şiirinden alınmıştır.',
    level: 2,
    unitId: 'u_a2',
    keywords: ['welat', 'çiya', 'çem', 'Kurdistan'],
    audioAsset: 'assets/audio/cultural/c_a2_001.mp3',
  ),

  CulturalItem(
    id: 'c_b1_003',
    type: CulturalContentType.poem,
    kurmanjTitle: 'Cegerxwîn — "Ev Welat"',
    turkishTitle: 'Cegerxwîn — "Bu Vatan"',
    kurmanjContent:
        'Ev welat welê min e, ev welat welê te ye,\n'
        'Ev welat welê me ye, em jê ciyanêbin?\n\n'
        'Çemên wî çemên min in,\n'
        'Çiyayên wî çiyayên min in.\n\n'
        'Heta jiyan hebe, ziman bijî —\n'
        'û ziman bijî, em bijîn.',
    turkishContent:
        'Bu vatan benim vatanım, bu vatan senin vatanın,\n'
        'Bu vatan bizim vatanımız, nasıl ayrılalım?\n\n'
        'Nehirleri benim nehirlerim,\n'
        'Dağları benim dağlarım.\n\n'
        'Yaşam oldukça dil yaşasın —\n'
        've dil yaşadıkça, biz yaşarız.',
    backgroundNote:
        'Cegerxwîn\'in şiiri vatan, dil ve kimliği özdeşleştirir. '
        '"Heta jiyan hebe, ziman bijî" (yaşam oldukça dil yaşasın) '
        'Kürt dil aktivizminin sloganıdır. '
        'B1\'de "heta ku" (sürece) yapısı ve subjunctive bu şiir üzerinden pekişir.',
    level: 3,
    unitId: 'b1_u3',
    keywords: ['welat', 'ziman', 'bijî', 'çem', 'çiya', 'Cegerxwîn'],
    audioAsset: 'assets/audio/cultural/c_b1_003.mp3',
  ),

  // ── B2 Kültürel İçerikler ────────────────────────────────────

  CulturalItem(
    id: 'c_b2_001',
    type: CulturalContentType.poem,
    kurmanjTitle: 'Ehmedê Xanî — Pêşgotina Mem û Zîn',
    turkishTitle: 'Xanî\'nin Önsözünden',
    kurmanjContent:
        'Me xwest ku bê xemilîne dîwaneke\n'
        'Ji bo navê kurdî, ji bo meqameke.\n\n'
        'Şêx û mîr û axayên kurdan hemî\n'
        'Çima di nav gelên din de kêm û kemî?\n\n'
        'Ew ev e ku yek û yekî, wan xwe nenas —\n'
        'Û yekîtî tune, lewre êş û telas.',
    turkishContent:
        'Kürt adına, bir makam için\n'
        'Süslü bir divan oluşturmak istedik.\n\n'
        'Kürtlerin şeyh, mir ve ağaları neden\n'
        'Diğer milletler arasında eksik ve yetersiz?\n\n'
        'Şundandır ki biri ötekini bilmez —\n'
        'Birlik yok, bu yüzden acı ve bunalım.',
    backgroundNote:
        'Bu dizeler Kürt siyasi felsefesinin doğuşunu temsil eder. '
        'Xanî 17. yüzyılda yenilginin nedenini birlik eksikliğine bağlar. '
        '"Yekîtî tune, lewre êş û telas" — '
        'B2\'de "lewre" (bu yüzden) discourse bağlacı ve '
        'pasif yapı ("hate nivîsandin") analiz edilir.',
    level: 4,
    unitId: 'b2_u1',
    keywords: ['Xanî', 'yekîtî', 'êş', 'mîr', 'kêm', 'pêşgotin'],
    audioAsset: 'assets/audio/cultural/c_b2_001.mp3',
  ),

  // ── A2+ Ek Kültürel İçerik ─────────────────────────────────

  CulturalItem(
    id: 'c_a2_002',
    type: CulturalContentType.proverb,
    kurmanjTitle: 'Mêvan xwedayê malê ye',
    turkishTitle: 'Misafir evin tanrısıdır',
    kurmanjContent:
        'Mêvan xwedayê malê ye.\n'
        'Mêvanê roj û şevê em pêşwazî dikin.\n\n'
        'Destê te xweş be, xaltî — nan û xwê kir.',
    turkishContent:
        'Misafir evin tanrısıdır.\n'
        'Gün ve gecelik misafiri karşılarız.\n\n'
        'Elinize sağlık, teyze — ekmek ve tuz sundu.',
    backgroundNote:
        'Kürt misafirperverliği derin bir kültürel yükümlülüktür. '
        '"Mêvan xwedayê malê ye" bu geleneğin en bilinen ifadesidir. '
        'Misafiri reddetmek büyük ayıp sayılır. '
        'A2 öğrenicisi bu bağlamda mêvanxane, nan û xwê ve silavdan kalıplarını pekiştirir.',
    level: 2,
    unitId: 'a2_u1',
    keywords: ['mêvan', 'xwedê', 'mal', 'nan', 'xwê', 'pêşwazî'],
    audioAsset: 'assets/audio/cultural/c_a2_002.mp3',
  ),

  CulturalItem(
    id: 'c_a2_004',
    type: CulturalContentType.foodTradition,
    kurmanjTitle: 'Dawet û Xwarin',
    turkishTitle: 'Düğün ve Yemek Geleneği',
    kurmanjContent:
        'Di dawetê de xwarin gelek e:\n'
        'Goştê beriyan, birinc û dew.\n'
        'Piştî xwarinê stranbêj distirê.\n\n'
        '"Destê we xweş be!" — xwarin xweş bû.\n'
        '"Nûş be!" — hevdu pîroz dikin.',
    turkishContent:
        'Düğünde yemek boldur:\n'
        'Kuzu eti, pirinç ve yoğurt ayranı.\n'
        'Yemekten sonra dengbêj türkü söyler.\n\n'
        '"Elinize sağlık!" — yemek güzeldi.\n'
        '"Afiyet olsun!" — birbirini tebrik ederler.',
    backgroundNote:
        'Kürt düğün yemekleri kolektif hazırlanır. '
        '"Goşt" (et), "birinc" (pirinç) ve "dew" (ayran) klasik '
        'düğün sofrası öğeleridir. Yemek bitince dengbêj sahne alır — '
        'yemek ve müzik ayrılmaz. A2\'de "piştî xwarinê" (yemekten sonra) '
        'zaman edatı pekiştirilir.',
    level: 2,
    unitId: 'a2_u3',
    keywords: ['dawet', 'goşt', 'birinc', 'dew', 'stranbêj', 'nûş be'],
    audioAsset: 'assets/audio/cultural/c_a2_004.mp3',
  ),

  CulturalItem(
    id: 'c_a2_005',
    type: CulturalContentType.proverb,
    kurmanjTitle: 'Çavê kor dilê kor',
    turkishTitle: 'Kör göz kör kalp',
    kurmanjContent:
        'Çavê kor, dilê kor.\n'
        'Kesê ku nabîne, nahise jî.\n\n'
        'Lê kesê ku hez dike —\n'
        'her tiştî dibîne.',
    turkishContent:
        'Kör göz, kör kalp.\n'
        'Görmeyen, hissetmez de.\n\n'
        'Ama seven kişi —\n'
        'her şeyi görür.',
    backgroundNote:
        'Kürt kültüründe "çav" (göz) ve "dil" (gönül) çifti '
        'şiirde ve atasözünde sürekli birlikte kullanılır. '
        '"Çav" hem fiziksel görme hem de anlayış/empatidir. '
        'A2 öğrenicisi "kesê ku" (sıfat cümlesi girişi) yapısını '
        'bu atasözünde ilk defa karşılar.',
    level: 2,
    unitId: 'a2_u4',
    keywords: ['çav', 'dil', 'kor', 'hiskirin', 'dîtin', 'hez'],
    audioAsset: 'assets/audio/cultural/c_a2_005.mp3',
  ),

  CulturalItem(
    id: 'c_a2_007',
    type: CulturalContentType.song,
    kurmanjTitle: 'Strana Kurdî — Li Gundê Me',
    turkishTitle: 'Kürt Türküsü — Köyümüzde',
    kurmanjContent:
        'Li gundê me çem diherike,\n'
        'Çiyayên me kesk û bilind in.\n'
        'Dêya min li malê stranê dibêje,\n'
        'Dengê wê dilê min tijî dike.\n\n'
        '"Gundo, gundo, gundê min xweş—\n'
        'Dilê min timî li te ye."',
    turkishContent:
        'Köyümüzde nehir akar,\n'
        'Dağlarımız yeşil ve yüksek.\n'
        'Annem evde türkü söyler,\n'
        'Onun sesi kalbimi doldurur.\n\n'
        '"Köyüm, köyüm, güzel köyüm —\n'
        'Kalbim hep sendedir."',
    backgroundNote:
        'Köy türküleri (stranên gundî) Kürt kültüründe nostaljinin ve '
        'toprağa bağlılığın dilidir. Diaspora Kürtleri için bu türküler '
        'kaybedilen çocukluk ve vatan anısını taşır. '
        '"Li gundê me" yapısı A2\'de "li" edatının yer belirtme kullanımını pekiştirir.',
    level: 2,
    unitId: 'a2_u6',
    keywords: ['gund', 'çem', 'çiya', 'stran', 'dê', 'dil', 'kesk'],
    audioAsset: 'assets/audio/cultural/c_a2_007.mp3',
  ),

  CulturalItem(
    id: 'c_a2_013',
    type: CulturalContentType.poem,
    kurmanjTitle: 'Cegerxwîn — Zimanê Kurdî',
    turkishTitle: 'Cegerxwîn — Kürt Dili',
    kurmanjContent:
        'Zimanê min zimanekî qedîm e,\n'
        'Li serê çiyayan hat gotin.\n'
        'Di çemên me de diherike,\n'
        'Di dilê me de dimîne.\n\n'
        'Bila her kes bizane:\n'
        'Ziman mirov e, mirov ziman e.',
    turkishContent:
        'Dilim kadim bir dildir,\n'
        'Dağların tepesinde söylenmiştir.\n'
        'Nehirlerimizde akar,\n'
        'Kalbimizde kalır.\n\n'
        'Herkes bilsin:\n'
        'Dil insandır, insan dildir.',
    backgroundNote:
        'Cegerxwîn (1903–1984) modern Kurmancî şiirinin kurucusudur. '
        '"Ziman mirov e" ifadesi dil ve kimliğin özdeşliğini vurgular — '
        'heritage öğrenicinin merkezi deneyimi. '
        'A2\'de geçmiş zaman kullanımı (hat gotin, hate gotin) '
        'bu şiir üzerinden pekişir.',
    level: 2,
    unitId: 'a2_u12',
    keywords: ['ziman', 'qedîm', 'çiya', 'çem', 'dil', 'Cegerxwîn'],
    audioAsset: 'assets/audio/cultural/c_a2_013.mp3',
  ),

  // ── Kesayetên Dîrokî — Tarihi Kürt Kişilikleri ──────────────

  CulturalItem(
    id: 'cf_001',
    type: CulturalContentType.historicalFigure,
    kurmanjTitle: 'Ehmedê Xanî (1651–1707)',
    turkishTitle: 'Ahmed-i Hani (1651–1707)',
    kurmanjContent:
        '"Heke yek ji me Kurdan bihatana, pêşeng biketana, '
        'ger me yekîtî biketana, ew ê me desthilatdar biketana."\n\n'
        'Ehmedê Xanî helbestvan û fîlozofê kurd ê sedsala 17an e. '
        'Berhema wî ya herî navdar Mem û Zîn e — destana evînê ya '
        'ku di heman demê de bangê yekîtiya kurdan dike. '
        'Xanî di medreseyê de mamostetî dikir û bi sê zimanan '
        '(Kurmancî, Erebî, Farisî) dinivîsî.',
    turkishContent:
        '"Eğer bizden bir Kürt öne çıksaydı, önder olsaydı, '
        'birlik sağlasaydık, bizi egemen kılarlardı."\n\n'
        'Ahmed-i Hani, 17. yüzyılın Kürt şair ve filozofudur. '
        'En ünlü eseri Mem ve Zin\'dir — aynı zamanda Kürt birliğine '
        'çağrı yapan bir aşk destanıdır. '
        'Hani medresede öğretmenlik yapmış ve üç dilde '
        '(Kürtçe, Arapça, Farsça) eser vermiştir.',
    backgroundNote:
        'Mem û Zîn Kürt edebiyatının en önemli eseridir. '
        'Xanî aynı zamanda Nûbihara Biçûkan adlı ilk Kürtçe '
        'sözlüğü de yazmıştır. UNESCO tarafından tanınan bir eserdir.',
    level: 3,
    unitId: 'b1_u1',
    keywords: ['Xanî', 'Mem û Zîn', 'yekîtî', 'helbest', 'pêşeng', 'desthilatdar'],
  ),

  CulturalItem(
    id: 'cf_002',
    type: CulturalContentType.historicalFigure,
    kurmanjTitle: 'Melayê Cizîrî (1570–1640)',
    turkishTitle: 'Molla Ciziri (1570–1640)',
    kurmanjContent:
        '"Dîwana min ew bihişta adimê ye, '
        'Ku tê de gul û sunbul û nesrîn e."\n\n'
        'Melayê Cizîrî helbestvanê mezin ê tasewufê ye. '
        'Dîwana wî bi Kurmancî ye û di edebiyata kurdî de '
        'cihekî sereke digire. Melayê Cizîrî li Cizîrê (Botan) jiyaye '
        'û helbestên wî li ser evîn, Xwedê û xwezayê ne.',
    turkishContent:
        '"Divanım Adem\'in cennetidir, '
        'İçinde güller, sümbüller ve nergisler vardır."\n\n'
        'Molla Ciziri büyük bir tasavvuf şairidir. '
        'Divanı Kürtçe olup Kürt edebiyatında temel bir yere sahiptir. '
        'Cizre\'de (Botan) yaşamış olup şiirleri aşk, Tanrı ve '
        'doğa üzerinedir.',
    backgroundNote:
        'Melayê Cizîrî Kurmancî edebiyatının ilk büyük şairi kabul edilir. '
        'Dîwanı 2000\'den fazla beyit içerir ve Kürt kimliğinin '
        'edebî temellerinden biridir.',
    level: 3,
    unitId: 'b1_u1',
    keywords: ['Cizîrî', 'Dîwan', 'tasewuf', 'helbest', 'Botan', 'gul'],
  ),

  CulturalItem(
    id: 'cf_003',
    type: CulturalContentType.historicalFigure,
    kurmanjTitle: 'Seîdê Kurdî / Bediüzzaman Said Nursî (1878–1960)',
    turkishTitle: 'Said Nursi / Bediüzzaman (1878–1960)',
    kurmanjContent:
        '"Meşrûtîyet û hurrîyet û dadperwerî — '
        'ev bingehên pêşveçûna gelan in."\n\n'
        'Seîdê Kurdî zanayekî kurd ê sedsala 19–20an e. '
        'Ji Bîtlîsê ye û li ser perwerde, mafên gelan û '
        'azadiya ramanê gelek nivîsiye. Wî dixwest ku '
        'zanîngeha kurdî li Rojhilata Anadoliyê were avakirin.',
    turkishContent:
        '"Meşrutiyet, hürriyet ve adalet — '
        'bunlar milletlerin ilerlemesinin temellerdir."\n\n'
        'Said-i Kürdi, 19–20. yüzyılın Kürt düşünürüdür. '
        'Bitlisli olup eğitim, halkların hakları ve düşünce '
        'özgürlüğü üzerine çok yazmıştır. Doğu Anadolu\'da '
        'bir Kürt üniversitesi kurulmasını savunmuştur.',
    backgroundNote:
        'Said Nursî erken dönemde Kürt kimliğiyle tanınmış, '
        'daha sonra İslami düşünce eserleriyle (Risale-i Nur) '
        'geniş kitlelere ulaşmıştır. Kürt eğitim tarihinde '
        'önemli bir figürdür.',
    level: 3,
    unitId: 'b1_u2',
    keywords: ['Seîdê Kurdî', 'perwerde', 'hurrîyet', 'zanîngeh', 'dadperwerî'],
  ),

  CulturalItem(
    id: 'cf_004',
    type: CulturalContentType.historicalFigure,
    kurmanjTitle: 'Mistefa Barzanî (1903–1979)',
    turkishTitle: 'Mustafa Barzani (1903–1979)',
    kurmanjContent:
        '"Divê em ji bo azadî û mafên xwe bişewitin."\n\n'
        'Mistefa Barzanî serokê tevgera neteweyî ya kurdî ye. '
        'Li Başûrê Kurdistanê (Iraqê) ji bo mafên kurdan '
        'bi dehsalan şer kir. Di sala 1946an de Komara Mehabadê '
        'de wezîfedar bû. Navê wî di dîroka kurdan de '
        'wek sembolê berxwedanê tê zanîn.',
    turkishContent:
        '"Özgürlük ve haklarımız için yanmalıyız."\n\n'
        'Mustafa Barzani, Kürt ulusal hareketinin lideridir. '
        'Güney Kürdistan\'da (Irak) Kürt hakları için onlarca yıl '
        'mücadele etmiştir. 1946\'da Mahabad Cumhuriyeti\'nde '
        'görev almıştır. Adı Kürt tarihinde direniş sembolü '
        'olarak bilinir.',
    backgroundNote:
        'Barzanî ailesi Kürt siyasi tarihinin en önemli '
        'ailelerinden biridir. Mistefa Barzanî\'nin mirası '
        'bugünkü Kürdistan Bölgesel Yönetimi\'nin temelini oluşturur.',
    level: 3,
    unitId: 'b1_u2',
    keywords: ['Barzanî', 'azadî', 'berxwedan', 'Mehabad', 'maf', 'neteweyî'],
  ),

  CulturalItem(
    id: 'cf_005',
    type: CulturalContentType.historicalFigure,
    kurmanjTitle: 'Celadet Alî Bedirxan (1893–1951)',
    turkishTitle: 'Celadet Ali Bedirhan (1893–1951)',
    kurmanjContent:
        '"Ziman jiyana neteweye ye. Bê ziman neteweyekê nikare bijî."\n\n'
        'Celadet Alî Bedirxan alfabeya latînî ya Kurmancî '
        'afirandiye. Kovara Hawar (1932–1943) li Şamê weşand '
        'û bi vê rêyê Kurmancî bi tîpên latînî hat standardkirin. '
        'Ew di dîroka zimanê kurdî de kesayetekî sereke ye.',
    turkishContent:
        '"Dil bir milletin hayatıdır. Dil olmadan bir millet yaşayamaz."\n\n'
        'Celadet Ali Bedirhan, Kurmancî Latin alfabesini '
        'oluşturmuştur. Şam\'da Hawar dergisini (1932–1943) yayımlamış '
        've bu sayede Kurmancî Latin harfleriyle standartlaşmıştır. '
        'Kürt dil tarihinin en önemli isimlerinden biridir.',
    backgroundNote:
        'Hawar dergisi modern Kurmancî yazı dilinin temelini atmıştır. '
        'Bedirxan\'ın oluşturduğu alfabe bugün hâlâ kullanılmaktadır. '
        'LUTKE uygulamasında kullanılan harfler de bu alfabeye dayanır.',
    level: 3,
    unitId: 'b1_u3',
    keywords: ['Bedirxan', 'Hawar', 'alfabe', 'ziman', 'latînî', 'neteweyî'],
  ),

  CulturalItem(
    id: 'cf_006',
    type: CulturalContentType.historicalFigure,
    kurmanjTitle: 'Cegerxwîn (1903–1984)',
    turkishTitle: 'Cegerxwin (1903–1984)',
    kurmanjContent:
        '"Ez im çiya, ez im çem, ez im Kurdistan."\n\n'
        'Cegerxwîn (navê wî yê rastî Şêxmûs Hesen e) '
        'helbestvanê şoreşger ê kurd e. Bi sedan helbest nivîsîne '
        'ku tê de evîna welêt, azadî û berxwedanê vedibêje. '
        'Wî Kurmancî wek zimanê edebî û siyasî pêş xistiye.',
    turkishContent:
        '"Ben dağım, ben nehirim, ben Kürdistan\'ım."\n\n'
        'Cegerxwin (asıl adı Şeyhmus Hasan), Kürt devrimci '
        'şairidir. Yüzlerce şiir yazmış olup şiirlerinde '
        'vatan sevgisi, özgürlük ve direniş işlenmiştir. '
        'Kurmancîyi edebi ve siyasi bir dil olarak geliştirmiştir.',
    backgroundNote:
        'Cegerxwîn adı "ciğeri yanık" anlamına gelir. '
        'Kürt şiirinde ulusal bilincin sembolüdür. '
        'Eserleri Kürt diasporasında nesiller boyu okunmuştur.',
    level: 3,
    unitId: 'b1_u3',
    keywords: ['Cegerxwîn', 'şoreş', 'çiya', 'Kurdistan', 'azadî', 'helbest'],
  ),

  CulturalItem(
    id: 'cf_007',
    type: CulturalContentType.historicalFigure,
    kurmanjTitle: 'Şêx Seîd (1865–1925)',
    turkishTitle: 'Şeyh Said (1865–1925)',
    kurmanjContent:
        'Şêx Seîd di sala 1925an de li Bakurê Kurdistanê '
        'serhildanekê rêxistin kir. Ew ji bo mafên kurdan '
        'û azadiya olî rabû. Serhildana wî yek ji '
        'tevgerên herî girîng ên dîroka kurdî ye.\n\n'
        'Navê wî di bîra gelê kurd de wek sembolê '
        'berxwedanê dimîne.',
    turkishContent:
        'Şeyh Said 1925 yılında Kuzey Kürdistan\'da '
        'bir ayaklanma düzenlemiştir. Kürt hakları ve '
        'dini özgürlük için ayağa kalkmıştır. Ayaklanması '
        'Kürt tarihinin en önemli hareketlerinden biridir.\n\n'
        'Adı Kürt halkının hafızasında direniş sembolü '
        'olarak yaşamaktadır.',
    backgroundNote:
        '1925 serhildanı Cumhuriyet tarihinde önemli bir dönüm '
        'noktasıdır. Şêx Seîd Kürt kimlik bilincinin '
        'erken dönem figürlerinden biridir.',
    level: 3,
    unitId: 'b1_u4',
    keywords: ['Şêx Seîd', 'serhildan', 'berxwedan', 'Bakur', 'azadî', '1925'],
  ),

  CulturalItem(
    id: 'cf_008',
    type: CulturalContentType.historicalFigure,
    kurmanjTitle: 'Nûredîn Zaza (1919–2000)',
    turkishTitle: 'Nureddin Zaza (1919–2000)',
    kurmanjContent:
        'Nûredîn Zaza zimannasê kurd ê navdar e. '
        'Li ser zimanê kurdî gelek lêkolîn kiriye û '
        'ferhengên kurdî amade kiriye. Di heman demê de '
        'siyasetmedarekî kurd bû û '
        'di damezrandina Partiya Demokrat a Kurdistana Sûriyê de '
        'rolê wî hebû.\n\n'
        'Berhemên wî ji bo standardkirina Kurmancî girîng in.',
    turkishContent:
        'Nureddin Zaza ünlü bir Kürt dilbilimci ve sözlükçüdür. '
        'Kürt dili üzerine çok sayıda araştırma yapmış ve '
        'Kürtçe sözlükler hazırlamıştır. Aynı zamanda Kürt '
        'siyasetçisi olup Suriye Kürdistan Demokrat Partisi\'nin '
        'kuruluşunda rolü olmuştur.\n\n'
        'Eserleri Kurmancînin standartlaşması için önemlidir.',
    backgroundNote:
        'Zaza\'nın otobiyografisi Kürt aydın tarihinin '
        'önemli kaynaklarından biridir. Kürt dilinin akademik '
        'çalışmasına büyük katkıda bulunmuştur.',
    level: 3,
    unitId: 'b1_u4',
    keywords: ['Zaza', 'zimannas', 'ferheng', 'lêkolîn', 'standardkirin'],
  ),

  CulturalItem(
    id: 'cf_009',
    type: CulturalContentType.historicalFigure,
    kurmanjTitle: 'Rewşen Bedirxan (1909–1992)',
    turkishTitle: 'Rewşen Bedirhan (1909–1992)',
    kurmanjContent:
        'Rewşen Bedirxan yekem rojnamevanê jin ê kurd e. '
        'Di kovara Hawar de nivîsiye û ji bo mafên jinên kurd '
        'xebat kiriye. Ew keça Emîn Alî Bedirxan û '
        'xwişka Celadet Alî Bedirxan e.\n\n'
        'Rewşen ji bo perwerde û wekheviya jinê li nav '
        'civaka kurdî pêşeng bû.',
    turkishContent:
        'Rewşen Bedirhan ilk Kürt kadın gazetecisidir. '
        'Hawar dergisinde yazılar yazmış ve Kürt kadın hakları '
        'için mücadele etmiştir. Emin Ali Bedirhan\'ın kızı ve '
        'Celadet Ali Bedirhan\'ın kız kardeşidir.\n\n'
        'Rewşen, Kürt toplumunda kadın eğitimi ve eşitliği '
        'için öncü olmuştur.',
    backgroundNote:
        'Rewşen Bedirxan Kürt kadın hareketinin sembol isimlerindendir. '
        'Bedirxan ailesi Kürt kültür ve siyaset tarihinde '
        'merkezi bir rol oynamıştır.',
    level: 3,
    unitId: 'b1_u5',
    keywords: ['Rewşen', 'Bedirxan', 'rojnamevan', 'jin', 'Hawar', 'maf'],
  ),

  CulturalItem(
    id: 'cf_010',
    type: CulturalContentType.historicalFigure,
    kurmanjTitle: 'Yilmaz Güney (1937–1984)',
    turkishTitle: 'Yilmaz Güney (1937–1984)',
    kurmanjContent:
        'Yilmaz Güney derhênerê kurd ê cîhanî ye. '
        'Fîlmê wî yê Yol di sala 1982an de li Cannesê '
        'Xelata Palmê ya Zêrîn wergirt. Di fîlmên xwe de '
        'jiyana kurdan, hejarî û berxwedanê nîşan daye.\n\n'
        'Güney gotiye ku sînema divê dengê '
        'kesên bêdeng be.',
    turkishContent:
        'Yilmaz Güney dünyaca ünlü Kürt yönetmendir. '
        'Yol filmi 1982\'de Cannes\'da Altın Palmiye ödülünü '
        'kazanmıştır. Filmlerinde Kürt yaşamını, yoksulluğu '
        've direnişi işlemiştir.\n\n'
        'Güney sinemanın sessiz kalanların sesi '
        'olması gerektiğini söylemiştir.',
    backgroundNote:
        'Yilmaz Güney Kürt kültürel kimliğinin uluslararası '
        'arenada tanınmasında önemli bir rol oynamıştır. '
        'Palme d\'Or alan ilk Türkiyeli yönetmendir.',
    level: 3,
    unitId: 'b1_u5',
    keywords: ['Güney', 'sînema', 'Yol', 'Cannes', 'Palmê Zêrîn', 'derhêner'],
  ),
];

// ════════════════════════════════════════════════════════════════
// YARDIMCI FONKSİYONLAR
// ════════════════════════════════════════════════════════════════

/// Belirli bir birim için kültürel içerikleri getir
List<CulturalItem> getCulturalItemsForUnit(String unitId) =>
    kCulturalItems.where((item) => item.unitId == unitId).toList();

/// Belirli bir düzey için tüm kültürel içerikleri getir
List<CulturalItem> getCulturalItemsByLevel(int level) =>
    kCulturalItems.where((item) => item.level == level).toList();
