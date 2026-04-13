// ════════════════════════════════════════════════════════════════
// KÜLTÜREL İÇERİK ENTITY'LERİ
//
// Araştırma Bulgusu #6: Kültürel içerik (türküler, atasözleri)
// "olsa güzel" değil, asıl öğrenme motivasyonu.
// Zeynep TikTok'tan öğreniyor, Hasan türküler "içinde bir yerde
// duruyor" diyor. Bu içerik ek özellik değil, zorunlu çekirdek.
//
// Kaynak: Institut Kurde Paris, Osman Aslanoğlu Dil Kartları,
// Bedir Han & Lescot, Kürt edebiyat geleneği
// ════════════════════════════════════════════════════════════════

enum CulturalContentType {
  proverb,       // Gotinên pêşiyan — Atasözü
  song,          // Stran — Türkü
  poem,          // Helbest — Şiir
  story,         // Çîrok — Hikaye
  celebration,   // Cejna — Kutlama (Newroz, Îd...)
  foodTradition, // Xwarina — Yemek geleneği
  culturalNote,  // Nîşe — Kültürel not
  historicalFigure, // Kesayetên Dîrokî — Tarihi Kişilikler
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
        CulturalContentType.story => 'Çîrok',
        CulturalContentType.celebration => 'Cejna',
        CulturalContentType.foodTradition => 'Xwarina',
        CulturalContentType.culturalNote => 'Nîşe',
        CulturalContentType.historicalFigure => 'Kesayetên Dîrokî',
      };

  String get typeTurkish => switch (type) {
        CulturalContentType.proverb => 'Atasözü',
        CulturalContentType.song => 'Türkü',
        CulturalContentType.poem => 'Şiir',
        CulturalContentType.story => 'Hikaye',
        CulturalContentType.celebration => 'Kutlama',
        CulturalContentType.foodTradition => 'Yemek Geleneği',
        CulturalContentType.culturalNote => 'Kültürel Not',
        CulturalContentType.historicalFigure => 'Tarihi Kişilik',
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

  // ── Birim 4: Reng ────────────────────────────────────────────
  // unitId: 'u4' — YENİ EKLENDI
  // Kaynak: Institut Kurde Paris; Kürdistan bayrağı renkleri
  CulturalItem(
    id: 'c_006',
    type: CulturalContentType.culturalNote,
    kurmanjTitle: 'Rengên Kurdistanê',
    turkishTitle: 'Kürdistan\'ın Renkleri',
    kurmanjContent:
        'Ala Kurdistanê sê rengî ye:\n'
        'Kesk — çiya û çêra Kurdistanê,\n'
        'Spî — aştî û paqijî,\n'
        'Sor — xwîna şehîdan.\n\n'
        'Di navenda alayê de Tav heye — stêrkeke zer.\n'
        'Tav jiyan û ronahiyê temsîl dike.',
    turkishContent:
        'Kürdistan bayrağı üç renklidir:\n'
        'Yeşil — Kürdistan\'ın dağları ve çayırları,\n'
        'Beyaz — barış ve saflık,\n'
        'Kırmızı — şehitlerin kanı.\n\n'
        'Bayrağın ortasında Güneş var — sarı bir yıldız.\n'
        'Güneş, yaşamı ve aydınlığı temsil eder.',
    backgroundNote:
        'Kürdistan bayrağının her rengi derin bir anlam taşır. '
        '"Kesk" (yeşil) Kürdistan dağlarının bereketli doğasını, '
        '"sor" (kırmızı) bağımsızlık mücadelesi için dökülen kanı, '
        '"spî" (beyaz) arayışı ve arılığı simgeler. '
        'Ortasındaki "tav" (güneş/yıldız) Newroz ateşiyle bağlantılıdır.',
    level: 1,
    unitId: 'u4',
    keywords: ['reng', 'kesk', 'sor', 'spî', 'zer', 'tav', 'ala'],
    audioAsset: 'assets/audio/cultural/c_006.mp3',
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

  // ── Birim 7: Pîşe û Perwerdehî ───────────────────────────────
  // unitId: 'u7' — YENİ EKLENDI
  // Kürt eğitim geleneği ve Celadet Bedir Han'ın katkısı
  CulturalItem(
    id: 'c_008',
    type: CulturalContentType.culturalNote,
    kurmanjTitle: 'Elfabeya Kurdî û Celadet Bedir Han',
    turkishTitle: 'Kürt Alfabesi ve Celadet Bedir Han',
    kurmanjContent:
        'Celadet Alî Bedir Han di sala 1932an de\n'
        'elfabeya Kurmancî ya Latînî ava kir.\n\n'
        'Ew alfabe îro jî tê bikaranîn.\n'
        'Bi vê alfabeyê em Kurmancî dinivîsin û dixwînin.\n\n'
        '"Ziman û alfabe — azadiya me ye."',
    turkishContent:
        'Celadet Ali Bedir Han 1932\'de\n'
        'Latin tabanlı Kurmancî alfabesini oluşturdu.\n\n'
        'O alfabe bugün hâlâ kullanılmaktadır.\n'
        'Bu alfabeyle Kurmancî yazıyor ve okuyoruz.\n\n'
        '"Dil ve alfabe — bizim özgürlüğümüz."',
    backgroundNote:
        'Celadet Ali Bedir Han (1897–1951) Kürt kültürü tarihinin '
        'en önemli isimlerinden biridir. 1932\'de Hawar dergisiyle '
        'yayımladığı Latin alfabesi bugün standart Kurmancî alfabesidir. '
        'Bu alfabeyi kullanarak Kurmancî öğrenmek, '
        'onun mirasını yaşatmak demektir.',
    level: 1,
    unitId: 'u7',
    keywords: ['alfabe', 'nivîsîn', 'xwendin', 'ziman', 'Bedir Han'],
    audioAsset: 'assets/audio/cultural/c_008.mp3',
  ),

  // ── Birim 8: Dem û Rojen ─────────────────────────────────────
  // unitId: 'u8' — YENİ EKLENDI
  // Newroz = Yeni Gün — zaman ve kutlama
  CulturalItem(
    id: 'c_newroz',
    type: CulturalContentType.celebration,
    kurmanjTitle: 'Newroz — Sala Nû ya Kurdî',
    turkishTitle: 'Newroz — Kürt Yeni Yılı',
    kurmanjContent:
        'Newroz pîroz be!\n\n'
        'Newroz roja yekem a biharê ye.\n'
        'Di 21ê Adara her salê de tê pîrozkirin.\n\n'
        'Kawa hesinkar agirê azadiyê vêxist.\n'
        'Agir nîşana serkeftinê ye.',
    turkishContent:
        'Newroz kutlu olsun!\n\n'
        'Newroz baharın ilk günüdür.\n'
        'Her yılın 21 Martında kutlanır.\n\n'
        'Demirci Kawa özgürlük ateşini yaktı.\n'
        'Ateş zaferin simgesidir.',
    backgroundNote:
        'Newroz (nû=yeni + roj=gün) Kürtlerin en önemli kutlamasıdır. '
        '21 Mart\'ta ateşler yakılır, halk dağ başlarında bir araya gelir. '
        'Efsaneye göre Kawa adlı bir demirci, zalim Dehhak\'a karşı '
        'ayaklanmış ve özgürlük ateşini yakmıştır. '
        'Newroz hem baharın hem de direnişin simgesidir.',
    level: 1,
    unitId: 'u8',
    keywords: ['newroz', 'agir', 'bihar', 'azadî', 'Kawa', 'roj'],
    audioAsset: 'assets/audio/cultural/c_newroz.mp3',
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

  // ── Birim 11: Mal û Cih ──────────────────────────────────────
  // unitId: 'u11' — YENİ EKLENDI
  // Kürt ev ve ocak kültürü
  CulturalItem(
    id: 'c_010',
    type: CulturalContentType.culturalNote,
    kurmanjTitle: 'Malê kurd — Ocax û Mêvanxane',
    turkishTitle: 'Kürt Evi — Ocak ve Misafirhane',
    kurmanjContent:
        'Di mala kurdî de du cih girîng hene:\n\n'
        'Ocax — agirê malê ye.\n'
        'Li dora ocaxê malbat dicive.\n\n'
        'Mêvanxane — ji bo mêvanan e.\n'
        'Mêvan muqedes e — "Mêvan xwedayê malê ye."',
    turkishContent:
        'Kürt evinde iki önemli yer vardır:\n\n'
        'Ocak — evin ateşi.\n'
        'Ocak başında aile toplanır.\n\n'
        'Misafirhane — misafirler içindir.\n'
        'Misafir kutsaldır — "Misafir evin tanrısıdır."',
    backgroundNote:
        'Geleneksel Kürt evinde ocak (ocax) sadece ısınma yeri değil, '
        'ailenin merkezi ve kutsal alanıdır. Misafirhane (mêvanxane) '
        'ise Kürt misafirperverliğinin mekânsal ifadesidir. '
        '"Mêvan xwedayê malê ye" — misafir evin tanrısıdır — '
        'bu kültürel norm bugün de geçerliliğini korur.',
    level: 1,
    unitId: 'u11',
    keywords: ['mal', 'ocax', 'mêvanxane', 'mêvan', 'agir'],
    audioAsset: 'assets/audio/cultural/c_010.mp3',
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
  // ── B1 Kültürel İçerikler ────────────────────────────────────

  CulturalItem(
    id: 'c_b1_001',
    type: CulturalContentType.culturalNote,
    kurmanjTitle: 'Ehmedê Xanî û Birêkûpêkiya Kurmancî',
    turkishTitle: 'Ehmedê Xanî ve Kurmancî\'nin Sistematizasyonu',
    kurmanjContent:
        'Ehmedê Xanî di 1695an de "Mem û Zîn" nivîsand.\n'
        'Lê berî vê, di 1683an de "Nûbahara Biçûkan" nivîsand —\n'
        'pirtûkeke fêrbûnê ji zarokan re.\n\n'
        'Xanî di pêşgotina Mem û Zîn de gotiye:\n'
        '"Çima ji Curcan heta Misirê û ji Hind heta Romayê\n'
        'Kurd ji hemî miletan kêm mane?"\n\n'
        'Bersiva wî: Ji ber ku yekîtî tune. Û ziman bingeha yekîtiyê ye.',
    turkishContent:
        'Ehmedê Xanî 1695\'te "Mem û Zîn"i yazdı.\n'
        'Ama bundan önce, 1683\'te çocuklar için\n'
        '"Nûbahara Biçûkan" adlı bir öğretici kitap yazdı.\n\n'
        'Xanî Mem û Zîn\'in önsözünde dedi ki:\n'
        '"Neden Cürcan\'dan Mısır\'a ve Hindistan\'dan Roma\'ya\n'
        'Kürtler tüm milletlerden geri kaldı?"\n\n'
        'Cevabı: Birlik olmadığı için. Ve dil birliğin temelidir.',
    backgroundNote:
        'Xanî\'nin bu önsözü Kürt edebiyatında siyasi farkındalığın '
        'ilk büyük ifadesidir. B1 öğrenicisi bu metni ergatif ve '
        'dolaylı anlatım yapılarıyla çözümler. '
        '"Xanî gotiye ku…" (Xanî söyledi ki) yapısı B1\'in kritik hedefidir.',
    level: 3,
    unitId: 'b1_u1',
    keywords: ['Xanî', 'yekîtî', 'ziman', 'Mem û Zîn', 'pêşgotin', 'kurd'],
    audioAsset: 'assets/audio/cultural/c_b1_001.mp3',
  ),

  CulturalItem(
    id: 'c_b1_002',
    type: CulturalContentType.culturalNote,
    kurmanjTitle: 'Dengbêj — Zindiya Devkî ya Kurd',
    turkishTitle: 'Dengbêj — Kürtlerin Yaşayan Sözlü Geleneği',
    kurmanjContent:
        'Dema nivîsîn qedexe bû,\n'
        'dengbêj bûn pirtûkên zindî.\n\n'
        'Şakiro, Aram Tigran, Ayşe Şan —\n'
        'dîrok û sevda û êş\n'
        'di dengê wan de ma.\n\n'
        '"Gule, gule, welê min Kurdistan,\n'
        'Çiyayên te şîn in, deştên te şîn in…"\n\n'
        'Ev dengbêjî ne stran e tenê —\n'
        'ev belgeya miletê me ye.',
    turkishContent:
        'Yazı yasaklandığında,\n'
        'dengbêjler diri kitaplar oldu.\n\n'
        'Şakiro, Aram Tigran, Ayşe Şan —\n'
        'tarih, sevda ve acı\n'
        'onların sesinde kaldı.\n\n'
        '"Güzel, güzel, vatanım Kürdistan,\n'
        'Dağların yeşil, ovalar yeşil…"\n\n'
        'Bu dengbêjlik sadece şarkı değil —\n'
        'milletimizin belgesidir.',
    backgroundNote:
        'Dengbêj geleneği UNESCO tarafından da tanınan '
        'somut olmayan kültürel mirastır. '
        'Şakiro (1921–2005) "Kürtlerin Frank Sinatra\'sı" olarak bilinir. '
        'B1 öğrenicisi sürekli geçmiş (-digot, -dihat) zaman yapılarını '
        'dengbêj söylemine uygular.',
    level: 3,
    unitId: 'b1_u2',
    keywords: ['dengbêj', 'Şakiro', 'stran', 'dîrok', 'zindî', 'belge'],
    audioAsset: 'assets/audio/cultural/c_b1_002.mp3',
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

  CulturalItem(
    id: 'c_b1_004',
    type: CulturalContentType.culturalNote,
    kurmanjTitle: 'Koçberî û Dîaspora',
    turkishTitle: 'Göç ve Diaspora',
    kurmanjContent:
        'Mîlyonên Kurdan ji welatê xwe derçûne —\n'
        'Ewropa, Amerîka, Awustralya.\n\n'
        'Lê ziman bi wan re çûye.\n'
        'Di destê malbatê de ma;\n'
        'di dengê pîrêyê de;\n'
        'di loriya dayikê de.\n\n'
        '"Em li gurbetê ne, lê Kurdistan li dilê me ye."\n\n'
        'Ev gotin ya diasporaya kurdî ye.',
    turkishContent:
        'Milyonlarca Kürt vatanlarından çıktı —\n'
        'Avrupa, Amerika, Avustralya.\n\n'
        'Ama dil onlarla birlikte gitti.\n'
        'Ailenin elinde kaldı;\n'
        'büyükannenin sesinde;\n'
        'annenin ninnisin de.\n\n'
        '"Gurbetteyiz, ama Kürdistan kalbimizde."\n\n'
        'Bu, Kürt diasporasının sözüdür.',
    backgroundNote:
        'B1 öğrenicisinin büyük çoğunluğu bu deneyimi yaşamıştır. '
        '"Ziman bi wan re çûye" = dil onlarla birlikte gitti — '
        'sürekli geçmiş (digot, dihat) zaman biçimleri ile. '
        'Heritage öğrenicinin motivasyonunun kaynağı budur.',
    level: 3,
    unitId: 'b1_u4',
    keywords: ['koçberî', 'diaspora', 'gurbet', 'ziman', 'malbat', 'dil'],
    audioAsset: 'assets/audio/cultural/c_b1_004.mp3',
  ),

  CulturalItem(
    id: 'c_b1_005',
    type: CulturalContentType.culturalNote,
    kurmanjTitle: 'Hawar û Alfabeya Bedir Han',
    turkishTitle: 'Hawar Dergisi ve Bedir Han Alfabesi',
    kurmanjContent:
        'Di sala 1932an de, Celadet Alî Bedir Han\n'
        'li Şamê kovarekê weşand: Hawar.\n\n'
        '"Hawar" bi kurdî tê wateya "daxwaza arîkariyê".\n'
        'Kovara Hawarê alfabe, rêziman û çand da Kurdan.\n\n'
        'Ev alfabe ku hûn îro bi wê dixwînin —\n'
        'ev alfeba Bedir Han e.\n\n'
        'Heta îro her tîpa we nivîsandiye\n'
        'mîrata wî ye.',
    turkishContent:
        '1932\'de Celadet Ali Bedir Han\n'
        'Şam\'da bir dergi yayımladı: Hawar.\n\n'
        '"Hawar" Kurmancîde "yardım çağrısı" demektir.\n'
        'Hawar dergisi Kürtlere alfabe, gramer ve kültür verdi.\n\n'
        'Bugün okumaya kullandığınız bu alfabe —\n'
        'Bedir Han alfabesidir.\n\n'
        'Bugüne kadar yazdığınız her harf\n'
        'onun mirasıdır.',
    backgroundNote:
        'Bedir Han (1897–1951) modern Kurmancîyi sistematize etti. '
        'Hawar (1932–1943) 57 sayı çıktı ve tüm dünyaya dağıtıldı. '
        'B1\'de "hatiye weşandin" (yayımlanmıştır), '
        '"hate nivîsandin" (yazılmıştır) pasif yapıları bu bağlamda öğrenilir.',
    level: 3,
    unitId: 'b1_u5',
    keywords: ['Bedir Han', 'Hawar', 'alfabe', 'kovar', 'mîrat', 'Şam'],
    audioAsset: 'assets/audio/cultural/c_b1_005.mp3',
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

  CulturalItem(
    id: 'c_b2_002',
    type: CulturalContentType.culturalNote,
    kurmanjTitle: 'Ziman û Siyaset — Têkiliya Sereke',
    turkishTitle: 'Dil ve Siyaset — Temel İlişki',
    kurmanjContent:
        'Di dîroka kurdî de, ziman û siyaset\n'
        'her tim bi hev re hatine dîtin.\n\n'
        'Dema ku zimanekî tê qedexekirin —\n'
        'ev ne tenê çandeke tune dike:\n'
        'ev miletekî kund û bêhêz dike.\n\n'
        'Lewre têkoşîna zimanî\n'
        'xwe wek têkoşîna siyasî dide nîşandan.\n\n'
        '"Zimanê azad, miletê azad."',
    turkishContent:
        'Kürt tarihinde, dil ve siyaset\n'
        'her zaman birlikte görülmüştür.\n\n'
        'Bir dil yasaklandığında —\n'
        'bu sadece bir kültürü yok etmez:\n'
        'bir halkı çaresiz ve güçsüz bırakır.\n\n'
        'Bu yüzden dil mücadelesi\n'
        'kendini siyasi mücadele olarak ortaya koyar.\n\n'
        '"Özgür dil, özgür millet."',
    backgroundNote:
        'Bu metin B2 düzeyinde gazete ve akademik dil stilini öğretir. '
        '"Tê qedexekirin" (yasaklanıyor), "hate qedexekirin" (yasaklandı), '
        '"dê bête qedexekirin" (yasaklanacak) — pasif üç zaman. '
        '"Lewre" discourse bağlacı, "xwe dide nîşandan" bileşik fiil.',
    level: 4,
    unitId: 'b2_u2',
    keywords: ['ziman', 'siyaset', 'qedexe', 'têkoşîn', 'azad', 'millet'],
    audioAsset: 'assets/audio/cultural/c_b2_002.mp3',
  ),

  CulturalItem(
    id: 'c_b2_003',
    type: CulturalContentType.culturalNote,
    kurmanjTitle: 'Kurdistana Çar Beşî',
    turkishTitle: 'Dört Parçalı Kürdistan',
    kurmanjContent:
        'Piştî Şerê Cîhanê yê Yekem,\n'
        'Kurdistan di navbera çar dewletên cuda de hat dabeşkirin:\n\n'
        '🔴 Bakur — Tirkiye\n'
        '🟡 Başûr — Iraq\n'
        '🟢 Rojhilat — Iran\n'
        '🔵 Rojava — Suriye\n\n'
        'Lê ziman sînoran nas nake.\n'
        '"Li her derê ku Kurd hebe, Kurdistan heye."',
    turkishContent:
        'Birinci Dünya Savaşı\'ndan sonra,\n'
        'Kürdistan dört farklı devlet arasında bölündü:\n\n'
        '🔴 Kuzey — Türkiye\n'
        '🟡 Güney — Irak\n'
        '🟢 Doğu — İran\n'
        '🔵 Batı — Suriye\n\n'
        'Ama dil sınırları tanımaz.\n'
        '"Kürdün olduğu her yerde Kürdistan vardır."',
    backgroundNote:
        'Kürdistan\'ın coğrafi dağılımı B2 öğrenicisinin tarihsel '
        'bağlamı anlaması için kritiktir. "Hat dabeşkirin" (bölündü) '
        'geçmiş pasif. "Sînoran nas nake" — ergatif değil çünkü '
        '"nas kirin" burada idiyomatik kullanım.',
    level: 4,
    unitId: 'b2_u3',
    keywords: ['Bakur', 'Başûr', 'Rojhilat', 'Rojava', 'sînor', 'dabeşkirin'],
    audioAsset: 'assets/audio/cultural/c_b2_003.mp3',
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
    id: 'c_a2_003',
    type: CulturalContentType.culturalNote,
    kurmanjTitle: 'Newroz û Şoreş',
    turkishTitle: 'Newroz ve Direniş',
    kurmanjContent:
        'Newroz ne tenê cejn e —\n'
        'Newroz dengê azadiyê ye.\n\n'
        'Kawa li hemberî Dehhakî sekinî.\n'
        'Agirê wî êdî newestiya.\n\n'
        'Em jî wek Kawa disekinîn:\n'
        '"Zimanê me tune nakin!"',
    turkishContent:
        'Newroz sadece bayram değil —\n'
        'Newroz özgürlüğün sesidir.\n\n'
        'Kawa Dehhak\'a karşı durdu.\n'
        'Onun ateşi bir daha sönmedi.\n\n'
        'Biz de Kawa gibi duruyoruz:\n'
        '"Dilimizi yok edemezsiniz!"',
    backgroundNote:
        'Newroz\'un siyasi boyutu A1\'den daha derin işlenir. '
        'Kawa efsanesi "direniş" sembolü olarak Kürt kimliğinin merkezindedir. '
        'A2 öğrenicisi "Li hemberî sekinîn" (karşı durmak), '
        '"agir vêxistin" (ateş yakmak) gibi yapıları bu bağlamda öğrenir.',
    level: 2,
    unitId: 'a2_u2',
    keywords: ['Newroz', 'agir', 'Kawa', 'azadî', 'sekinîn', 'Dehhak'],
    audioAsset: 'assets/audio/cultural/c_a2_003.mp3',
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
    id: 'c_a2_006',
    type: CulturalContentType.culturalNote,
    kurmanjTitle: 'Li Bazarê — Çanda Bazarê ya Kurdî',
    turkishTitle: 'Pazarda — Kürt Çarşı Geleneği',
    kurmanjContent:
        'Bazarê Kurdî ne tenê cihê kirîn û firoştinê ye —\n'
        'bazar cihê civîn û axaftinê ye jî.\n\n'
        '"Ev bi çendê ye?" — "Ji bo te erzan!"  \n'
        '"Xêr e, ez dizanim!" — û her du jî dikene.\n\n'
        'Pazarlık Kurmancîde: "Kêmtir bike!"',
    turkishContent:
        'Kürt pazarı sadece alışveriş yeri değil —\n'
        'pazar buluşma ve sohbet yeridir de.\n\n'
        '"Bu ne kadar?" — "Sana ucuz!"\n'
        '"Biliyorum!" — ve ikisi de güler.\n\n'
        'Pazarlık Kurmancîce: "Azalt biraz!"',
    backgroundNote:
        'Kürt pazarında alışveriş bir sosyal ritüeldir. '
        'Pazarlık yapmak nezaketsizlik değil, katılımdır. '
        '"Kêmtir bike!" (biraz indir), "biha gelek e" (çok pahalı) '
        'gibi kalıplar alışveriş kültürünün parçasıdır. '
        'A2 öğrenicisi fiyat sorma ve pazarlık cümlelerini burada pekiştirir.',
    level: 2,
    unitId: 'a2_u5',
    keywords: ['bazar', 'kirîn', 'firoştin', 'erzan', 'biha', 'kêmtir'],
    audioAsset: 'assets/audio/cultural/c_a2_006.mp3',
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
    id: 'c_a2_008',
    type: CulturalContentType.culturalNote,
    kurmanjTitle: 'Rêwîtî û Vedîtin — Çanda Rêwîtiyê',
    turkishTitle: 'Yolculuk ve Buluşma',
    kurmanjContent:
        'Dema ku Kurd ji welatên cûda tên ba hev,\n'
        'pêşî bi Kurmancî silavê didin:\n\n'
        '"Bi xêr hatî! Tu ji kû yî?"\n'
        '"Ez ji Amedê me — tu?"\n'
        '"Ez ji Dersimê me."\n\n'
        '"Jidayikbûna te kû ye? Bajarê bavan."',
    turkishContent:
        'Kürtler farklı ülkelerden bir araya geldiklerinde,\n'
        'önce Kurmancî ile selamlaşırlar:\n\n'
        '"Hoş geldin! Nerelisin?"\n'
        '"Ben Amedliyim — sen?"\n'
        '"Ben Dersimli."\n\n'
        '"Doğum yerin neresi? Ataların şehri."',
    backgroundNote:
        '"Jidayikbûna te kû ye?" (doğum yerin nerede?) Kürt kimliği '
        'konuşmalarında kritik bir sorudur. Diyaspora Kürtleri genellikle '
        'hem yaşadıkları ülkeyi hem de atalarının köyünü söylerler. '
        'A2\'de seyahat, tanışma ve kimlik ifade kalıpları bu bağlamda birleşir.',
    level: 2,
    unitId: 'a2_u7',
    keywords: ['rêwîtî', 'silav', 'jidayikbûn', 'welat', 'bajar', 'Amed', 'Dersim'],
    audioAsset: 'assets/audio/cultural/c_a2_008.mp3',
  ),

  CulturalItem(
    id: 'c_a2_009',
    type: CulturalContentType.celebration,
    kurmanjTitle: 'Cejna Îdê — Bayram Kutlaması',
    turkishTitle: 'Bayram Kutlaması',
    kurmanjContent:
        'Cejn hat — malbat û heval tên ba hev.\n'
        'Zarok cil û bergên nû li xwe dikin.\n\n'
        '"Cejna te pîroz be!"\n'
        '"Cejna we jî pîroz be!"\n\n'
        'Destên mezinên malbatê tên ramuskirin.\n'
        '"Xêr û bereket bê malê te!"',
    turkishContent:
        'Bayram geldi — aile ve arkadaşlar bir araya gelir.\n'
        'Çocuklar yeni kıyafetler giyer.\n\n'
        '"Bayramın kutlu olsun!"\n'
        '"Sizin bayramınız da kutlu olsun!"\n\n'
        'Aile büyüklerinin elleri öpülür.\n'
        '"Evinize hayır ve bereket gelsin!"',
    backgroundNote:
        'Kürt bayramlarında büyüklerin elini öpmek (ramuskirin) zorunlu '
        'bir saygı ifadesidir. Küçükler büyüklere gider — büyükler küçüklere gelmez. '
        '"Xêr û bereket bê malê te" yaygın bir bayram duasıdır. '
        'A2\'de "cil li xwe kirin" (giymek), "ramuskirin" (el öpmek) pekişir.',
    level: 2,
    unitId: 'a2_u8',
    keywords: ['cejn', 'pîroz', 'zarok', 'cil', 'bereket', 'ramuskirin'],
    audioAsset: 'assets/audio/cultural/c_a2_009.mp3',
  ),

  CulturalItem(
    id: 'c_a2_010',
    type: CulturalContentType.culturalNote,
    kurmanjTitle: 'Bijîşk û Nexweşî — Çanda Tenduristiyê',
    turkishTitle: 'Doktor ve Hastalık',
    kurmanjContent:
        'Di nav Kurdan de dema kes nexweş dikeve,\n'
        'malbat û cînar tên serdanê.\n\n'
        '"Tu çawa yî? Çi heye?"\n'
        '"Ez baştir im, spas."\n\n'
        '"Xwedê şifayê bide te!"\n'
        'Ev dua di mala kurdî de her tê gotin.',
    turkishContent:
        'Kürtlerde biri hastalandığında,\n'
        'aile ve komşular ziyarete gelir.\n\n'
        '"Nasılsın? Ne var?"\n'
        '"Daha iyiyim, teşekkürler."\n\n'
        '"Allah şifa versin!"\n'
        'Bu dua Kürt evinde her zaman söylenir.',
    backgroundNote:
        '"Serî lêdan" (baş koymak → ziyaret etmek) hasta ziyareti için '
        'deyimsel ifadedir. "Xwedê şifayê bide te!" en yaygın sağlık duasıdır. '
        'A2\'de "dema ku" (zaman bağlacı), sağlık ifadeleri ve ziyaret diyalogları '
        'bu kültürel bağlamda öğrenilir.',
    level: 2,
    unitId: 'a2_u9',
    keywords: ['nexweş', 'bijîşk', 'şifa', 'cînar', 'serî lêdan', 'baştir'],
    audioAsset: 'assets/audio/cultural/c_a2_010.mp3',
  ),

  CulturalItem(
    id: 'c_a2_011',
    type: CulturalContentType.culturalNote,
    kurmanjTitle: 'Dibistan û Mamosta',
    turkishTitle: 'Okul ve Öğretmen',
    kurmanjContent:
        'Di dibistana kurdî de mamosta gotiye:\n'
        '"Hûn ji bo çi hatine vir?"\n'
        'Zarokên Kurdên diasporayê bersiv dan:\n'
        '"Me hatiye da ku zimanê xwe hîn bibin."\n\n'
        '"Gelek baş e. Bila ziman bijî!"',
    turkishContent:
        'Kürt okulunda öğretmen dedi ki:\n'
        '"Neden buraya geldiniz?"\n'
        'Diaspora Kürtlerinin çocukları cevap verdi:\n'
        '"Dilimizi öğrenmek için geldik."\n\n'
        '"Çok güzel. Dil yaşasın!"',
    backgroundNote:
        'Diaspora Kürt okulları — Almanya, İsveç, Hollanda — '
        'Kürt çocuklarının dillerini öğrendiği özel kurumlardır. '
        '"Bila ziman bijî!" (Dil yaşasın!) bu okulların sloganıdır. '
        'A2\'de "ji bo ku" (amaç), "hîn bûn" (öğrenmek) ve '
        'okul diyalogları pekişir.',
    level: 2,
    unitId: 'a2_u10',
    keywords: ['dibistan', 'mamosta', 'ziman', 'hîn bûn', 'diaspora', 'bijî'],
    audioAsset: 'assets/audio/cultural/c_a2_011.mp3',
  ),

  CulturalItem(
    id: 'c_a2_012',
    type: CulturalContentType.culturalNote,
    kurmanjTitle: 'Malê Kurd û Cînar',
    turkishTitle: 'Kürt Evi ve Komşuluk',
    kurmanjContent:
        'Di nava mala kurdî de:\n'
        'Derî her vekirî ye ji bo cîranan.\n\n'
        '"Bê, bê! Kafe vexwe, çay bixwe!"\n'
        '"Spas, spas — heta carek din."\n\n'
        'Cînar wek malbat in.\n'
        '"Cînarê baş ji birayê dûr çêtir e."',
    turkishContent:
        'Kürt evinde:\n'
        'Kapı komşulara hep açıktır.\n\n'
        '"Gel, gel! Kahve iç, çay içersin!"\n'
        '"Teşekkürler — bir dahaki sefere."\n\n'
        'Komşular aile gibidir.\n'
        '"İyi komşu uzak kardeşten iyidir."',
    backgroundNote:
        '"Cînarê baş ji birayê dûr çêtir e" (iyi komşu uzak kardeşten iyidir) '
        'Kürt kültüründe komşuluk ilişkisinin önemini vurgular. '
        'Kapı her zaman açık bırakmak ve davet etmek temel değerdir. '
        'A2\'de ev, komşu, davet ifadeleri ve karşılaştırmalar pekişir.',
    level: 2,
    unitId: 'a2_u11',
    keywords: ['cînar', 'mal', 'derî', 'vexwandin', 'çêtir', 'bira'],
    audioAsset: 'assets/audio/cultural/c_a2_012.mp3',
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
    kurmanjTitle: 'Ehmedê Xanî (1650–1707)',
    turkishTitle: 'Ahmed-i Hani (1650–1707)',
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
