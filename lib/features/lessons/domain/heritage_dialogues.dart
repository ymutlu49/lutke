// ════════════════════════════════════════════════════════════════
// LÛTKE — A1 Heritage Diyalogları (Rêya Malê)
//
// Asimile Kürtler için gerçek aile sahneleri.
// Araştırma bulgusu #4: "Büyükanneyle hal hatır sormak,
// türkünün sözlerini anlamak" — asıl öğrenme motivasyonu.
//
// Tüm diyaloglar:
// ✓ A1 kelime havuzundan (kA1TamListe + kA1EkKelimeler)
// ✓ SOV cümle düzeni — Bedir Han & Lescot §295–299
// ✓ Bûn fiili doğru çekimi — Thackston §62
// ✓ Ezafe formları dilbilgisel açıdan doğru
// ✓ Keyf xweş im (kullanıcı tercihi, iki kelime)
// ════════════════════════════════════════════════════════════════

class DialogueLine {
  final String speaker;
  final String speakerRole;
  final String kurmanci;
  final String turkish;
  final String? grammarNote;
  final String? culturalNote;
  final String? audioAsset;

  const DialogueLine({
    required this.speaker,
    required this.speakerRole,
    required this.kurmanci,
    required this.turkish,
    this.grammarNote,
    this.culturalNote,
    this.audioAsset,
  });
}

class HeritageDialogue {
  final String id;
  final String kurmanjTitle;
  final String turkishTitle;
  final String scene;
  final String culturalContext;
  final List<String> keyWords;
  final String lessonId;
  final List<DialogueLine> lines;

  const HeritageDialogue({
    required this.id,
    required this.kurmanjTitle,
    required this.turkishTitle,
    required this.scene,
    required this.culturalContext,
    required this.keyWords,
    required this.lessonId,
    required this.lines,
  });
}

// ════════════════════════════════════════════════════════════════
// DİYALOG 1 — Çayê Pîrê
// Büyükanneyle çay — en duygusal sahne
// Persona: Elif (24, İstanbul) büyükannesini ziyaret ediyor.
// ════════════════════════════════════════════════════════════════

const kDialoguePiree = HeritageDialogue(
  id: 'dlg_piree_cay',
  kurmanjTitle: 'Çayê Pîrê',
  turkishTitle: 'Büyükannenin Çayı',
  lessonId: 'a1_l10',
  scene:
      'Büyükannenin evi, öğleden sonra. '
      'Elif büyükannesini ziyaret etti, Kurmancî denemek istiyor.',
  culturalContext:
      'Kürt kültüründe misafir gelince çay zorunlu ikramdır. '
      '"Çay bikeve!" — ilk söylenen sözlerden biridir. '
      'Büyükanneler ile diyalog, asimile nesil için '
      'en değerli pratik ortamdır.',
  keyWords: ['silav', 'pîrê', 'çay', 'spas', 'baş', 'germ', 'xweş', 'hîn bûn'],
  lines: [
    DialogueLine(
      speaker: 'Elif',
      speakerRole: 'Nevî',
      kurmanci: 'Silav, pîrê!',
      turkish: 'Merhaba, büyükanne!',
      grammarNote: '"Silav" = merhaba. Hitap: "pîrê" sona gelir.',
      audioAsset: 'assets/audio/heritage/dlg1_01.mp3',
    ),
    DialogueLine(
      speaker: 'Pîrê',
      speakerRole: 'Pîrê',
      kurmanci: 'Silav, keça min! Bi xêr hatî!',
      turkish: 'Merhaba, kızım! Hoş geldin!',
      grammarNote: '"Keça min" = kızım (dişil ezafe: keç + -a + min).',
      culturalNote: '"Keça min" sözü derin sevgi ifadesidir — "kızım" dışında anlam taşır.',
      audioAsset: 'assets/audio/heritage/dlg1_02.mp3',
    ),
    DialogueLine(
      speaker: 'Elif',
      speakerRole: 'Nevî',
      kurmanci: 'Pîrê, tu çawa yî?',
      turkish: 'Büyükanne, nasılsın?',
      grammarNote: '"Tu çawa yî?" — "yî" bûn 2.tekil.',
      audioAsset: 'assets/audio/heritage/dlg1_03.mp3',
    ),
    DialogueLine(
      speaker: 'Pîrê',
      speakerRole: 'Pîrê',
      kurmanci: 'Ez baş im, spas. Tu çawa yî, kuro?',
      turkish: 'İyiyim, teşekkürler. Sen nasılsın, yavrum?',
      grammarNote: '"Kuro" — sevgi hitabı, cinsiyetten bağımsız kullanılır.',
      audioAsset: 'assets/audio/heritage/dlg1_04.mp3',
    ),
    DialogueLine(
      speaker: 'Elif',
      speakerRole: 'Nevî',
      kurmanci: 'Ez baş im jî, spas.',
      turkish: 'Ben de iyiyim, teşekkürler.',
      grammarNote: '"Jî" = de/da (pekiştirme). "Ez baş im jî" = ben de iyiyim.',
      audioAsset: 'assets/audio/heritage/dlg1_05.mp3',
    ),
    DialogueLine(
      speaker: 'Pîrê',
      speakerRole: 'Pîrê',
      kurmanci: 'Rûne, rûne! Ezê çay bikim.',
      turkish: 'Otur, otur! Çay yapayım.',
      grammarNote: '"Rûne!" = otur! (emir). "Ezê … bikim" = yapacağım (gelecek).',
      culturalNote: 'Oturmaya davet etmeden çay teklifi — Kürt misafirperverliğinin özü.',
      audioAsset: 'assets/audio/heritage/dlg1_06.mp3',
    ),
    DialogueLine(
      speaker: 'Elif',
      speakerRole: 'Nevî',
      kurmanci: 'Spas, pîrê. Çayê te gelek xweş e!',
      turkish: 'Teşekkürler büyükanne. Senin çayın çok güzel!',
      grammarNote: '"Çayê te" = senin çayın (ezafe: çay + -ê + te). "Gelek xweş" = çok güzel.',
      audioAsset: 'assets/audio/heritage/dlg1_07.mp3',
    ),
    DialogueLine(
      speaker: 'Pîrê',
      speakerRole: 'Pîrê',
      kurmanci: 'Gelek spas, keça min. Tu Kurmancî hîn dibî?',
      turkish: 'Çok teşekkürler kızım. Kurmancî öğreniyor musun?',
      grammarNote: '"Hîn dibî" = öğreniyorsun.',
      audioAsset: 'assets/audio/heritage/dlg1_08.mp3',
    ),
    DialogueLine(
      speaker: 'Elif',
      speakerRole: 'Nevî',
      kurmanci: 'Erê, pîrê! Ez Kurmancî hîn dibim. Zehmet e, lê ez gelek hez dikim!',
      turkish: 'Evet büyükanne! Kurmancî öğreniyorum. Zor ama çok seviyorum!',
      grammarNote: '"Lê" = ama. "Ji X hez dikim" = X-i seviyorum.',
      audioAsset: 'assets/audio/heritage/dlg1_09.mp3',
    ),
    DialogueLine(
      speaker: 'Pîrê',
      speakerRole: 'Pîrê',
      kurmanci: 'Gelek xweş e! Ziman dermanê dilê mirov e.',
      turkish: 'Çok güzel! Dil, insanın kalbinin ilacıdır.',
      culturalNote: 'Atalar sözü — heritage kullanıcı için diyaloğun doruk noktası.',
      audioAsset: 'assets/audio/heritage/dlg1_10.mp3',
    ),
  ],
);

// ════════════════════════════════════════════════════════════════
// DİYALOG 2 — Li Sifrê
// Sofrada — aile yemeği
// Persona: Mehmet (43) annesiyle akşam yemeğinde.
// ════════════════════════════════════════════════════════════════

const kDialogueSifre = HeritageDialogue(
  id: 'dlg_sofra_xwarin',
  kurmanjTitle: 'Li Sifrê',
  turkishTitle: 'Sofrada',
  lessonId: 'a1_l17',
  scene:
      'Akşam yemeği vakti. Anne pişirdi, '
      'hep birlikte sofraya oturuyorlar.',
  culturalContext:
      '"Nan û xwê" — ekmek ve tuz — birlikteliğin simgesi. '
      '"Destê te xweş be!" yemekten önce söylenen zorunlu saygı. '
      'Büyükler önce alır, küçükler bekler.',
  keyWords: ['nan', 'xwarin', 'germ', 'destê te xweş be', 'birçî', 'av', 'goşt', 'nûş be'],
  lines: [
    DialogueLine(
      speaker: 'Dê',
      speakerRole: 'Dê',
      kurmanci: 'Werin, werin! Xwarin amade ye!',
      turkish: 'Gelin, gelin! Yemek hazır!',
      grammarNote: '"Werin!" = gelin (çoğul emir). "Amade ye" = hazır.',
      audioAsset: 'assets/audio/heritage/dlg2_01.mp3',
    ),
    DialogueLine(
      speaker: 'Mehmet',
      speakerRole: 'Kur',
      kurmanci: 'Destê te xweş be, dayê!',
      turkish: 'Elinize sağlık, anneciğim!',
      grammarNote: '"Destê te xweş be" = elinize sağlık.',
      culturalNote: 'Yemek yapana ilk söylenen söz — atlamak büyük ayıp sayılır.',
      audioAsset: 'assets/audio/heritage/dlg2_02.mp3',
    ),
    DialogueLine(
      speaker: 'Dê',
      speakerRole: 'Dê',
      kurmanci: 'Ser çavim, kurê min! Rûne, rûne.',
      turkish: 'Baş üstüne, oğlum! Otur, otur.',
      grammarNote: '"Ser çavim" = baş üstüne — teşekküre kibar yanıt.',
      audioAsset: 'assets/audio/heritage/dlg2_03.mp3',
    ),
    DialogueLine(
      speaker: 'Bav',
      speakerRole: 'Bav',
      kurmanci: 'Çi xwarin e? Germ e?',
      turkish: 'Ne yemek var? Sıcak mı?',
      grammarNote: '"Çi xwarin e?" = ne yemek? "Germ e?" = sıcak mı?',
      audioAsset: 'assets/audio/heritage/dlg2_04.mp3',
    ),
    DialogueLine(
      speaker: 'Dê',
      speakerRole: 'Dê',
      kurmanci: 'Goşt û birinc. Erê, germ e!',
      turkish: 'Et ve pilav. Evet, sıcak!',
      grammarNote: '"Û" = ve. "Goşt û birinc" = et ve pilav.',
      culturalNote: 'Pilavlı et Kürt sofrasında en onurlu yemektir.',
      audioAsset: 'assets/audio/heritage/dlg2_05.mp3',
    ),
    DialogueLine(
      speaker: 'Mehmet',
      speakerRole: 'Kur',
      kurmanci: 'Ez gelek birçî me!',
      turkish: 'Ben çok açım!',
      grammarNote: '"Birçî" = aç (yiyecek anlamında). "Gelek" = çok.',
      audioAsset: 'assets/audio/heritage/dlg2_06.mp3',
    ),
    DialogueLine(
      speaker: 'Dê',
      speakerRole: 'Dê',
      kurmanci: 'Bixwe, bixwe! Nan jî heye.',
      turkish: 'Ye, ye! Ekmek de var.',
      grammarNote: '"Bixwe!" = ye! (emir). "Jî heye" = de var.',
      culturalNote: '"Bixwe, bixwe!" derken yemek zorlamak Kürt misafirperverliğidir.',
      audioAsset: 'assets/audio/heritage/dlg2_07.mp3',
    ),
    DialogueLine(
      speaker: 'Mehmet',
      speakerRole: 'Kur',
      kurmanci: 'Dêyê, av heye?',
      turkish: 'Anneciğim, su var mı?',
      grammarNote: '"Dêyê" = anneciğim (sevgi hitabı). "Av heye?" = su var mı?',
      audioAsset: 'assets/audio/heritage/dlg2_08.mp3',
    ),
    DialogueLine(
      speaker: 'Dê',
      speakerRole: 'Dê',
      kurmanci: 'Erê, li cem te ye. Av sar e.',
      turkish: 'Evet, yanında. Su soğuk.',
      grammarNote: '"Li cem te" = yanında. "Sar e" = soğuk.',
      audioAsset: 'assets/audio/heritage/dlg2_09.mp3',
    ),
    DialogueLine(
      speaker: 'Mehmet',
      speakerRole: 'Kur',
      kurmanci: 'Xwarin gelek xweş bû! Destê te xweş be, dayê.',
      turkish: 'Yemek çok güzeldi! Elinize sağlık, anneciğim.',
      grammarNote: '"Xweş bû" = güzeldi (geçmiş zaman, bûn).',
      audioAsset: 'assets/audio/heritage/dlg2_10.mp3',
    ),
    DialogueLine(
      speaker: 'Dê',
      speakerRole: 'Dê',
      kurmanci: 'Ser çavim! Nûş be!',
      turkish: 'Baş üstüne! Afiyet olsun!',
      grammarNote: '"Nûş be" = afiyet olsun (yemek sonrası).',
      culturalNote: '"Nûş be" Farsça kökenli — Kurmancîde çok yaygın.',
      audioAsset: 'assets/audio/heritage/dlg2_11.mp3',
    ),
  ],
);

// ════════════════════════════════════════════════════════════════
// DİYALOG 3 — Bi Telefon
// Telefonda Annem
// Persona: Zeynep (17, Mersin) annesiyle telefon görüşüyor.
// ════════════════════════════════════════════════════════════════

const kDialogueTelefon = HeritageDialogue(
  id: 'dlg_telefon_de',
  kurmanjTitle: 'Bi Telefon',
  turkishTitle: 'Telefonda',
  lessonId: 'a1_l03',
  scene:
      'Zeynep annesiyle telefon görüşüyor. '
      'Uygulamadan öğrendiklerini ilk kez deniyor.',
  culturalContext:
      'Telefon, asimile neslin büyüklerle dil kurduğu en pratik alan. '
      'Anne çocuğunun Kurmancî konuşma çabasını görünce duygulanır. '
      'Hata yapmak normal — anlaşmaya çalışmak yeterli.',
  keyWords: ['silav', 'baş', 'malbat', 'sibê', 'hîn', 'Kurmancî', 'keyf xweş'],
  lines: [
    DialogueLine(
      speaker: 'Zeynep',
      speakerRole: 'Keç',
      kurmanci: 'Silav, dêyê!',
      turkish: 'Merhaba anneciğim!',
      grammarNote: '"Dêyê" = anneciğim (sevgi hitabı).',
      audioAsset: 'assets/audio/heritage/dlg3_01.mp3',
    ),
    DialogueLine(
      speaker: 'Dê',
      speakerRole: 'Dê',
      kurmanci: 'Silav, keça min! Tu çawa yî?',
      turkish: 'Merhaba kızım! Nasılsın?',
      audioAsset: 'assets/audio/heritage/dlg3_02.mp3',
    ),
    DialogueLine(
      speaker: 'Zeynep',
      speakerRole: 'Keç',
      kurmanci: 'Ez… ez baş im. Tu çawa yî?',
      turkish: 'Ben… ben iyiyim. Sen nasılsın?',
      grammarNote: 'Duraksama normaldir — öğrenci yeni başladı.',
      audioAsset: 'assets/audio/heritage/dlg3_03.mp3',
    ),
    DialogueLine(
      speaker: 'Dê',
      speakerRole: 'Dê',
      kurmanci: 'Baş im, spas! Keça min Kurmancî dipeyive!',
      turkish: 'İyiyim, teşekkürler! Kızım Kurmancî konuşuyor!',
      grammarNote: '"Dipeyive" = konuşuyor (peyvîn fiili).',
      culturalNote: 'Annenin sürprizi ve sevinci — asimile çocuğun dili konuşması en büyük armağan.',
      audioAsset: 'assets/audio/heritage/dlg3_04.mp3',
    ),
    DialogueLine(
      speaker: 'Zeynep',
      speakerRole: 'Keç',
      kurmanci: 'Erê, dêyê! Ez Kurmancî hîn dibim. Zehmet e, lê xweş e!',
      turkish: 'Evet anneciğim! Kurmancî öğreniyorum. Zor ama güzel!',
      grammarNote: '"Hîn dibim" = öğreniyorum. "Lê" = ama.',
      audioAsset: 'assets/audio/heritage/dlg3_05.mp3',
    ),
    DialogueLine(
      speaker: 'Dê',
      speakerRole: 'Dê',
      kurmanci: 'Gelek xweş e, keça min. Keyf xweş î?',
      turkish: 'Çok güzel kızım. Keyifli misin?',
      grammarNote: '"Keyf xweş î?" = keyifli misin? (keyf xweş + bûn 2.tekil -î)',
      audioAsset: 'assets/audio/heritage/dlg3_06.mp3',
    ),
    DialogueLine(
      speaker: 'Zeynep',
      speakerRole: 'Keç',
      kurmanci: 'Erê, keyf xweş im! Dêyê, sibê em tên malê.',
      turkish: 'Evet, keyfim yerinde! Anneciğim, yarın eve geleceğiz.',
      grammarNote: '"Keyf xweş im" = keyfim yerinde. "Em tên" = geliyoruz.',
      audioAsset: 'assets/audio/heritage/dlg3_07.mp3',
    ),
    DialogueLine(
      speaker: 'Dê',
      speakerRole: 'Dê',
      kurmanci: 'Gelek baş! Bi xêr werin!',
      turkish: 'Çok güzel! Hoş gelin!',
      grammarNote: '"Bi xêr werin" = hoş gelin (çoğul).',
      audioAsset: 'assets/audio/heritage/dlg3_08.mp3',
    ),
    DialogueLine(
      speaker: 'Zeynep',
      speakerRole: 'Keç',
      kurmanci: 'Spas, dêyê. Xatirê te!',
      turkish: 'Teşekkürler anneciğim. Güle güle!',
      audioAsset: 'assets/audio/heritage/dlg3_09.mp3',
    ),
    DialogueLine(
      speaker: 'Dê',
      speakerRole: 'Dê',
      kurmanci: 'Xatirê te, keça min. Ji te hez dikim!',
      turkish: 'Güle git kızım. Seni seviyorum!',
      grammarNote: '"Ji te hez dikim" = seni seviyorum.',
      culturalNote: 'Kürtçede "hez dikim" söylemek — yıllarca söyleyememenin ardından ilk kez.',
      audioAsset: 'assets/audio/heritage/dlg3_10.mp3',
    ),
  ],
);

// ════════════════════════════════════════════════════════════════
// DİYALOG 4 — Malbat Tê
// Aile Ziyareti
// Persona: Hasan (58) ve ailesi büyükanneyi ziyaret ediyor.
// ════════════════════════════════════════════════════════════════

const kDialogueMalbat = HeritageDialogue(
  id: 'dlg_malbat_te',
  kurmanjTitle: 'Malbat Tê',
  turkishTitle: 'Aile Geliyor',
  lessonId: 'a1_l09',
  scene:
      'Hasan ve ailesi büyükannenin evini ziyaret ediyor. '
      'Kapıda karşılaşıyorlar.',
  culturalContext:
      'Kürt kültüründe aile ziyareti en kutsal toplumsal ritüellerden biri. '
      'Kapıdan girildiğinde büyüklere önce selam verilir. '
      'Ziyarette hediye getirmek zorunlu sayılır.',
  keyWords: ['bi xêr hatîn', 'rûne', 'malbat', 'kur', 'keç', 'ji bo te', 'ser çavim'],
  lines: [
    DialogueLine(
      speaker: 'Hasan',
      speakerRole: 'Kur',
      kurmanci: 'Silav, dêyê! Bi xêr hatîn?',
      turkish: 'Merhaba anneciğim! İyi misin?',
      grammarNote: '"Bi xêr hatîn?" burada "nasılsın" anlamında kullanılır.',
      audioAsset: 'assets/audio/heritage/dlg4_01.mp3',
    ),
    DialogueLine(
      speaker: 'Pîrê',
      speakerRole: 'Pîrê',
      kurmanci: 'Bi xêr hatîn, malbato! Werin hundurê!',
      turkish: 'Hoş geldiniz, ailem! İçeri gelin!',
      grammarNote: '"Malbato" = ailem (sevgi hitabı). "Hundurê" = içeri.',
      audioAsset: 'assets/audio/heritage/dlg4_02.mp3',
    ),
    DialogueLine(
      speaker: 'Jina Hasan',
      speakerRole: 'Bûk',
      kurmanci: 'Pîrê, tu çawa yî? Roja te baş be!',
      turkish: 'Büyükanne, nasılsın? İyi günler!',
      grammarNote: '"Roja te baş be" = günün iyi olsun.',
      culturalNote: 'Gelin büyükanneye "pîrê" der — "dêyê" değil.',
      audioAsset: 'assets/audio/heritage/dlg4_03.mp3',
    ),
    DialogueLine(
      speaker: 'Pîrê',
      speakerRole: 'Pîrê',
      kurmanci: 'Ez baş im, keça min. Spas. Zarokên we çawa ne?',
      turkish: 'İyiyim kızım. Teşekkürler. Çocuklarınız nasıl?',
      grammarNote: '"Zarokên we" = çocuklarınız (zarok + -ên çoğul + we sizin).',
      culturalNote: '"Keça min" — büyükanne gelini de "kızım" diye hitap eder.',
      audioAsset: 'assets/audio/heritage/dlg4_04.mp3',
    ),
    DialogueLine(
      speaker: 'Hasan',
      speakerRole: 'Kur',
      kurmanci: 'Hemî baş in, spas. Dêyê, ev ji bo te ye.',
      turkish: 'Hepsi iyidir, teşekkürler. Anneciğim, bu sana.',
      grammarNote: '"Ji bo te" = senin için.',
      culturalNote: 'Ziyarette hediye getirmek Kürt geleneğinde zorunlu sayılır.',
      audioAsset: 'assets/audio/heritage/dlg4_05.mp3',
    ),
    DialogueLine(
      speaker: 'Pîrê',
      speakerRole: 'Pîrê',
      kurmanci: 'Çi ye ev? Lazim nebû! Gelek spas, kurê min.',
      turkish: 'Bu ne? Gerekmezdi! Çok teşekkürler, oğlum.',
      grammarNote: '"Lazim nebû" = gerekmezdi (geçmiş olumsuz).',
      culturalNote: '"Lazim nebû!" demek kibarlık gereği — hediyeyi memnuniyetle alıyor.',
      audioAsset: 'assets/audio/heritage/dlg4_06.mp3',
    ),
    DialogueLine(
      speaker: 'Pîrê',
      speakerRole: 'Pîrê',
      kurmanci: 'Hemî rûnin! Ezê çay bikim.',
      turkish: 'Hepiniz oturun! Çay yapayım.',
      grammarNote: '"Hemî rûnin!" = hepiniz oturun (çoğul emir).',
      audioAsset: 'assets/audio/heritage/dlg4_07.mp3',
    ),
  ],
);

// ════════════════════════════════════════════════════════════════
// DİYALOG 5 — Pîrê Mamostayê Min e
// Büyükannem Öğretmenim
// Persona: Narin (31) büyükannesinden kelime öğreniyor.
// ════════════════════════════════════════════════════════════════

const kDialogueDersa = HeritageDialogue(
  id: 'dlg_dersa_piree',
  kurmanjTitle: 'Pîrê Mamostayê Min e',
  turkishTitle: 'Büyükannem Öğretmenim',
  lessonId: 'a1_l05',
  scene:
      'Narin büyükannesinin yanında oturmuş, '
      'sözcükler soruyor.',
  culturalContext:
      'Büyükanneler, dili aktaran en doğal öğretmenlerdir. '
      'Bu sahne pek çok asimile Kürdün hayalindeki andır: '
      '"Zimanê malbata min" — ailenin dilini geri almak.',
  keyWords: ['hîn bûn', 'nav', 'çi ye', 'rast', 'baş', 'mamosta', 'xwendekar'],
  lines: [
    DialogueLine(
      speaker: 'Narin',
      speakerRole: 'Nevî',
      kurmanci: 'Pîrê, "kapı" bi Kurmancî çi ye?',
      turkish: 'Büyükanne, "kapı" Kurmancîde ne demek?',
      grammarNote: '"... bi Kurmancî çi ye?" = Kurmancîde ne demek?',
      audioAsset: 'assets/audio/heritage/dlg5_01.mp3',
    ),
    DialogueLine(
      speaker: 'Pîrê',
      speakerRole: 'Pîrê',
      kurmanci: '"Derî" ye. Ev derî ye.',
      turkish: '"Derî". Bu kapıdır.',
      grammarNote: '"Ev derî ye" = bu kapıdır (gösterme + isim + bûn).',
      audioAsset: 'assets/audio/heritage/dlg5_02.mp3',
    ),
    DialogueLine(
      speaker: 'Narin',
      speakerRole: 'Nevî',
      kurmanci: 'Derî… derî… Rast e?',
      turkish: 'Derî… derî… Doğru mu?',
      grammarNote: '"Rast e?" = doğru mu?',
      audioAsset: 'assets/audio/heritage/dlg5_03.mp3',
    ),
    DialogueLine(
      speaker: 'Pîrê',
      speakerRole: 'Pîrê',
      kurmanci: 'Erê, rast e! Tu baş dibêjî!',
      turkish: 'Evet, doğru! Çok iyi söylüyorsun!',
      grammarNote: '"Tu baş dibêjî" = iyi söylüyorsun (bêjin 2.tekil).',
      culturalNote: 'Teşvik etmek — öğrencinin motivasyonu için kritik.',
      audioAsset: 'assets/audio/heritage/dlg5_04.mp3',
    ),
    DialogueLine(
      speaker: 'Narin',
      speakerRole: 'Nevî',
      kurmanci: '"Pencere" çi ye bi Kurmancî?',
      turkish: '"Pencere" Kurmancîde ne?',
      audioAsset: 'assets/audio/heritage/dlg5_05.mp3',
    ),
    DialogueLine(
      speaker: 'Pîrê',
      speakerRole: 'Pîrê',
      kurmanci: '"Pencere" ye — heman e! Weke Tirkî.',
      turkish: '"Pencere" — aynısı! Türkçe gibi.',
      grammarNote: '"Heman e" = aynısı. "Weke" = gibi.',
      culturalNote: 'Bazı kelimeler her iki dilde aynı — büyükannenin tatlı sürprizi.',
      audioAsset: 'assets/audio/heritage/dlg5_06.mp3',
    ),
    DialogueLine(
      speaker: 'Narin',
      speakerRole: 'Nevî',
      kurmanci: 'Pîrê, tu mamostayê min î!',
      turkish: 'Büyükanne, sen benim öğretmeninim!',
      grammarNote: '"Mamostayê min î" = benim öğretmeninim (ezafe + bûn 2.tekil).',
      audioAsset: 'assets/audio/heritage/dlg5_07.mp3',
    ),
    DialogueLine(
      speaker: 'Pîrê',
      speakerRole: 'Pîrê',
      kurmanci: 'Û tu xwendekarê baştirîn î!',
      turkish: 'Ve sen en iyi öğrencisin!',
      grammarNote: '"Baştirîn" = en iyi (üstünlük derecesi: baş + -tirîn).',
      audioAsset: 'assets/audio/heritage/dlg5_08.mp3',
    ),
    DialogueLine(
      speaker: 'Narin',
      speakerRole: 'Nevî',
      kurmanci: 'Spas, pîrê. Ez ji te hez dikim.',
      turkish: 'Teşekkürler büyükanne. Seni seviyorum.',
      grammarNote: '"Ji te hez dikim" = seni seviyorum.',
      audioAsset: 'assets/audio/heritage/dlg5_09.mp3',
    ),
    DialogueLine(
      speaker: 'Pîrê',
      speakerRole: 'Pîrê',
      kurmanci: 'Ez jî ji te hez dikim, keça min. Ziman jiyana me ye.',
      turkish: 'Ben de seni seviyorum kızım. Dil, bizim hayatımız.',
      grammarNote: '"Ez jî" = ben de. "Jiyana me ye" = bizim hayatımız.',
      culturalNote: 'Final — dil ve sevgi birlikte, A1\'in son armağanı.',
      audioAsset: 'assets/audio/heritage/dlg5_10.mp3',
    ),
  ],
);

// ════════════════════════════════════════════════════════════════
// TÜM DİYALOGLAR
// ════════════════════════════════════════════════════════════════

  kDialogueB1Ninni,
  kDialogueB1Mezar,
  kDialogueB1Heval,
];

// ════════════════════════════════════════════════════════════════
// B1 DİYALOGLARI — 3 Sahne
// ════════════════════════════════════════════════════════════════

// B1 Sahne 1: Pîrê û Ninni — Büyükanne ninni söylerken
// Odak: sürekli geçmiş (digot), ergatif, kültürel bellek
const kDialogueB1Ninni = HeritageDialogue(
  id: 'b1_dlg_ninni',
  title: 'Loriya Pîrê',
  turkishTitle: 'Büyükannenin Ninnisi',
  level: 3,
  lessonId: 'b1_l18',
  characters: [
    DialogueCharacter(
      id: 'narin31', name: 'Narin', age: 31,
      description: 'Almanya\'dan gelmiş, Kurmancî öğreniyor',
      avatarAsset: 'assets/avatars/narin.png', isHeritage: true,
    ),
    DialogueCharacter(
      id: 'piree2', name: 'Pîrêya Fatma', age: 82,
      description: 'Narin\'in büyükannesi — anadili Kurmancî',
      avatarAsset: 'assets/avatars/piree_fatma.png', isHeritage: false,
    ),
  ],
  lines: [
    DialogueLine(speakerId: 'narin31',
      kurmanci: 'Pîrê, berê tu lorî jî digotî?',
      turkish: 'Büyükanne, önce ninni de söyler miydin?',
      grammarNote: '"Digotî" — sürekli geçmiş 2.tekil: "di-got-î". Berê = eskiden.',
      audioAsset: 'assets/audio/heritage/b1_ninni_1.mp3'),
    DialogueLine(speakerId: 'piree2',
      kurmanci: 'Erê keça min. Dema bavê te biçûk bû, ez lorî jê re digotim.\n"Ninîno, ninîno, kurê dayika min…"',
      turkish: 'Evet kızım. Baban küçükken, ona ninni söylerdim.\n"Ninîno, ninîno, annenin oğlu…"',
      grammarNote: '"Digotim" — sürekli geçmiş 1.tekil. "Jê re" = ona.',
      culturalNote: 'A1\'de öğrenilen ninni B1\'de sürekli geçmiş bağlamında geri döner.',
      audioAsset: 'assets/audio/heritage/b1_ninni_2.mp3'),
    DialogueLine(speakerId: 'narin31',
      kurmanci: 'Te ev lorî ji kû fêr bû? Ji dêya te?',
      turkish: 'Bu ninniyi nereden öğrendin? Annenden mi?',
      grammarNote: '"Te fêr bû" — ergatif (te = tu\'nun eğik hali) + geçmiş mükemmel.',
      audioAsset: 'assets/audio/heritage/b1_ninni_3.mp3'),
    DialogueLine(speakerId: 'piree2',
      kurmanci: 'Erê. Dêya min jî ji dêya xwe fêr bibû. Ev lorî ji nifşekî bo nifşekî çûye.\nNu wî lorî tu jî fêr bibî keça min.',
      turkish: 'Evet. Annem de kendi annesinden öğrenmişti. Bu ninni nesilden nesile geçmiş.\nŞimdi sen de bunu öğren kızım.',
      grammarNote: '"Fêr bibû" = öğrenmişti (geçmiş mükemmel). "Ji nifşekî bo nifşekî" = nesilden nesile.',
      culturalNote: 'Sözlü aktarım zinciri — B1\'in kültürel teması.',
      audioAsset: 'assets/audio/heritage/b1_ninni_4.mp3'),
    DialogueLine(speakerId: 'narin31',
      kurmanci: 'Pîrê, em bi hev re vê loriyê dibêjin?',
      turkish: 'Büyükanne, bu ninnisi birlikte söyleriz mi?',
      grammarNote: '"Em bi hev re dibêjin" = birlikte söyleriz (şimdiki subjunctive teklif).',
      audioAsset: 'assets/audio/heritage/b1_ninni_5.mp3'),
    DialogueLine(speakerId: 'piree2',
      kurmanci: 'Bê guman, keça dilê min. Ninîno, ninîno, kurê dayika min…\nNu tu jî bibêje!',
      turkish: 'Şüphesiz, kalbimin kızı. Ninîno, ninîno, annenin oğlu…\nŞimdi sen de söyle!',
      grammarNote: '"Bibêje!" = söyle! (2.tekil subjunctive emir). "Keça dilê min" = kalbimin kızı — Kürt sevgi ifadesi.',
      culturalNote: 'Öğrenme ve aktarma bir arada — B1\'in kalıcı mesajı.',
      audioAsset: 'assets/audio/heritage/b1_ninni_6.mp3'),
  ],
);

// B1 Sahne 2: Goran û Dîroka Malbatê — Vatan meselesi
// Odak: ergatif tam, geçmiş türleri, kimlik
const kDialogueB1Mezar = HeritageDialogue(
  id: 'b1_dlg_welat',
  title: 'Mezarê Bapîrê',
  turkishTitle: 'Dedenin Mezarı',
  level: 3,
  lessonId: 'b1_l21',
  characters: [
    DialogueCharacter(
      id: 'goran', name: 'Goran', age: 35,
      description: 'Hollanda\'da doğmuş — ilk kez köye gidiyor',
      avatarAsset: 'assets/avatars/goran.png', isHeritage: true,
    ),
    DialogueCharacter(
      id: 'ap45', name: 'Apê Xelîl', age: 72,
      description: 'Goran\'ın amcası — köyde yaşıyor',
      avatarAsset: 'assets/avatars/ap_halil.png', isHeritage: false,
    ),
  ],
  lines: [
    DialogueLine(speakerId: 'goran',
      kurmanci: 'Apê, ev goristan kû ye? Ez dixwazim mezarê bapîrê xwe bibînim.',
      turkish: 'Amca, bu mezarlık nerede? Dedemin mezarını görmek istiyorum.',
      grammarNote: '"Ez dixwazim bibînim" = görmek istiyorum (istek + subjunctive).',
      audioAsset: 'assets/audio/heritage/b1_welat_1.mp3'),
    DialogueLine(speakerId: 'ap45',
      kurmanci: 'Bavo, ez te dibirm. Bapîrê te li vê goristandê ye.\nWî gelek caran gotibû ku dixwaze te bibîne.',
      turkish: 'Oğlum, seni götüreyim. Deden bu mezarlıkta.\nSeni görmek istediğini defalarca söylemişti.',
      grammarNote: '"Gotibû" = söylemişti (geçmiş mükemmel ergatif). "Dixwaze bibîne" = görmek istiyor.',
      culturalNote: 'Nesiller arası kopuşun acısı — diaspora deneyimi.',
      audioAsset: 'assets/audio/heritage/b1_welat_2.mp3'),
    DialogueLine(speakerId: 'goran',
      kurmanci: 'Apê… [ramanên wî hatin birîn]\nEz nizanibûm ku ew heta ko ez vegerdim ne mabû.',
      turkish: 'Amca… [sesi kesildi]\nDönene kadar onu kaybetmiş olduğumu bilmiyordum.',
      grammarNote: '"Nizanibûm" = bilmiyordum (geçmiş mükemmel). "Ne mabû" = kalmamıştı.',
      audioAsset: 'assets/audio/heritage/b1_welat_3.mp3'),
    DialogueLine(speakerId: 'ap45',
      kurmanci: 'Wî her tim bi Kurmancî gotibû: "Goran dê were, dê were."\nÊdî tu hatî, û ew ji nû ve di te de ye.',
      turkish: 'O hep Kurmancî ile söylerdi: "Goran gelecek, gelecek."\nArtık geldin, ve o yeniden sende yaşıyor.',
      grammarNote: '"Gotibû" = söylemişti. "Di te de ye" = sende yaşıyor (şimdiki zaman).',
      culturalNote: 'Dil aktarımı = ruhun aktarımı. B1\'in en derin mesajı.',
      audioAsset: 'assets/audio/heritage/b1_welat_4.mp3'),
    DialogueLine(speakerId: 'goran',
      kurmanci: 'Apê, ez dê ji niha pê ve Kurmancî bipeyivim. Soz didim te û wî.',
      turkish: 'Amca, bundan böyle Kurmancî konuşacağım. Sana ve ona söz veriyorum.',
      grammarNote: '"Ji niha pê ve" = bundan böyle. "Soz didim" = söz veriyorum.',
      culturalNote: 'Söz verme — heritage öğrenicinin kişisel bağlılığı.',
      audioAsset: 'assets/audio/heritage/b1_welat_5.mp3'),
    DialogueLine(speakerId: 'ap45',
      kurmanci: 'Xwedê spas. Ev soz ya pîrozê ye keça min. Bapîrê te jî bi kêfxweşî guhdarî dike.',
      turkish: 'Allah\'a şükür. Bu kutsal bir sözdür oğlum. Deden de sevinçle dinliyor.',
      grammarNote: '"Guhdarî dike" = dinliyor (şimdiki zaman — mecazi). "Kêfxweşî" = sevinçle.',
      audioAsset: 'assets/audio/heritage/b1_welat_6.mp3'),
  ],
);

// B1 Sahne 3: Heval û Ziman — İki arkadaş arasında
// Odak: subjunctive kullanımı, karmaşık bağlaçlar, kimlik
const kDialogueB1Heval = HeritageDialogue(
  id: 'b1_dlg_heval',
  title: 'Hevalan û Ziman',
  turkishTitle: 'Arkadaşlar ve Dil',
  level: 3,
  lessonId: 'b1_l20',
  characters: [
    DialogueCharacter(
      id: 'selin', name: 'Selin', age: 27,
      description: 'Kurmancî bilmiyor — öğrenmek istiyor',
      avatarAsset: 'assets/avatars/selin.png', isHeritage: true,
    ),
    DialogueCharacter(
      id: 'ruken', name: 'Rûken', age: 26,
      description: 'Büyükannesinden öğrenmiş — hâlâ konuşuyor',
      avatarAsset: 'assets/avatars/ruken.png', isHeritage: true,
    ),
  ],
  lines: [
    DialogueLine(speakerId: 'selin',
      kurmanci: 'Rûken, tu çawa Kurmancî dizanî? Ji kê fêr bûyî?',
      turkish: 'Rûken, Kurmancîyi nasıl biliyorsun? Kimden öğrendin?',
      grammarNote: '"Ji kê fêr bûyî?" = kimden öğrendin? Ergatif: fêr bûn geçişsiz ama "ji kê" kaynak.',
      audioAsset: 'assets/audio/heritage/b1_heval_1.mp3'),
    DialogueLine(speakerId: 'ruken',
      kurmanci: 'Ji pîrêya xwe. Ew her dem bi Kurmancî dipeyivî û ez jî bi wê re dipeyivîm.\nBi deng û dengbêj, bi stran û çîrok.',
      turkish: 'Büyükannemden. O hep Kurmancî konuşurdu ve ben de onunla konuşurdum.\nSes ve dengbêjle, şarkı ve hikâyeyle.',
      grammarNote: '"Dipeyivî" = konuşurdu (sürekli geçmiş). "Bi wê re dipeyivîm" = onunla konuşurdum.',
      audioAsset: 'assets/audio/heritage/b1_heval_2.mp3'),
    DialogueLine(speakerId: 'selin',
      kurmanci: 'Ez şerm dikim ku Kurmancî nizanim.\nLê berî ku pîrêya min çe, ez dixwazim ji wê fêr bibim.',
      turkish: 'Kurmancî bilmediğim için utanıyorum.\nAma büyükannem gitmeden önce ondan öğrenmek istiyorum.',
      grammarNote: '"Şerm dikim" = utanıyorum. "Berî ku çe" = gitmeden önce (subjunctive). "Fêr bibim" = öğreneyim.',
      culturalNote: 'Utanç → karar → eylem. Heritage yolculuğunun üç aşaması.',
      audioAsset: 'assets/audio/heritage/b1_heval_3.mp3'),
    DialogueLine(speakerId: 'ruken',
      kurmanci: 'Şermezar nebe! Ger berê fêr bibûya, şerm dixwastin.\nNiha dest pê bike — ji nû ve.',
      turkish: 'Utanma! Önce öğrenseydin, utanmak gerekirdi.\nŞimdi başla — yeniden.',
      grammarNote: '"Ger fêr bibûya" = öğrenmiş olsaydı (gerçekleşmemiş şart). "Ji nû ve" = yeniden.',
      audioAsset: 'assets/audio/heritage/b1_heval_4.mp3'),
    DialogueLine(speakerId: 'selin',
      kurmanci: 'Tu rast dibêjî. Divê ez dest pê bikim. Dê alîkariya min bikî?',
      turkish: 'Haklısın. Başlamam gerekiyor. Yardım edecek misin?',
      grammarNote: '"Divê ez dest pê bikim" = başlamam gerekiyor (divê + subjunctive). "Alîkarî" = yardım.',
      audioAsset: 'assets/audio/heritage/b1_heval_5.mp3'),
    DialogueLine(speakerId: 'ruken',
      kurmanci: 'Bê guman! Bila em bi hev re dest pê bikin.\nZiman jiyan e — û jiyan divê bê jiyan bibe!',
      turkish: 'Şüphesiz! Birlikte başlayalım.\nDil hayattır — ve hayat yaşanmalıdır!',
      grammarNote: '"Bila em dest pê bikin" = başlayalım (subjunctive çoğul). "Bê jiyan bibe" = yaşanmalı (pasif + subjunctive).',
      culturalNote: 'B1\'in özeti: dil, topluluk, eylem — birlikte.',
      audioAsset: 'assets/audio/heritage/b1_heval_6.mp3'),
  ],
);

// ════════════════════════════════════════════════════════════════
// A2 DİYALOGLARI — 4 Sahne
// ════════════════════════════════════════════════════════════════

// A2 Sahne 1: Bazarda — Elif (24) ve xaltî (teyze)
// Odak: fiyat sorma, pazarlık, ergatif (min xwand), karşılaştırma
const kDialogueA2Bazar = HeritageDialogue(
  id: 'a2_dlg_bazar',
  title: 'Li Bazarê',
  turkishTitle: 'Pazarda',
  level: 2,
  lessonId: 'a2_l11',
  characters: [
    DialogueCharacter(
      id: 'elif', name: 'Elif', age: 24,
      description: 'Büyükannesini ziyarete gelmiş diaspora Kürdü',
      avatarAsset: 'assets/avatars/elif.png', isHeritage: true,
    ),
    DialogueCharacter(
      id: 'xalti', name: 'Xaltî Bêrîvan', age: 58,
      description: 'Elif\'in teyzesi — pazarda satıcı tanır',
      avatarAsset: 'assets/avatars/xalti.png', isHeritage: false,
    ),
    DialogueCharacter(
      id: 'firoskar', name: 'Firoşkar Sêlim', age: 45,
      description: 'Pazar esnafı',
      avatarAsset: 'assets/avatars/frokar.png', isHeritage: false,
    ),
  ],
  lines: [
    DialogueLine(speakerId: 'xalti',
      kurmanci: 'Elif, em hatine bazarê. Tu dibêjî, tu çi dixwazî?',
      turkish: 'Elif, pazara geldik. Söyle, ne istiyorsun?',
      grammarNote: '"Tu dibêjî, tu çi dixwazî?" — şimdiki zaman soru kalıbı.',
      audioAsset: 'assets/audio/heritage/a2_bazar_1.mp3'),
    DialogueLine(speakerId: 'elif',
      kurmanci: 'Xaltî, min berê pêlav dîtibûn li bazarê — dixwazim wan pêlavan bibînim.',
      turkish: 'Teyze, daha önce pazarda ayakkabı görmüştüm — o ayakkabıları görmek istiyorum.',
      grammarNote: '"Min … dîtibûn" — geçmiş mükemmel ergatif (B1 önizleme). "Dixwazim bibînim" — istek + subjunctive.',
      audioAsset: 'assets/audio/heritage/a2_bazar_2.mp3'),
    DialogueLine(speakerId: 'firoskar',
      kurmanci: 'Xêr hatî, xanim! Ev pêlavên nû — baş in û xweş in. Ev bi çendê ye?',
      turkish: 'Hoş geldiniz, hanım! Bunlar yeni ayakkabılar — güzel ve kaliteli. Bu ne kadar?',
      grammarNote: '"Xêr hatî" = hoş geldiniz. "Bi çendê ye?" = ne kadar?',
      audioAsset: 'assets/audio/heritage/a2_bazar_3.mp3'),
    DialogueLine(speakerId: 'elif',
      kurmanci: 'Ev bi çendê ye, apê?',
      turkish: 'Bu ne kadar, amca?',
      grammarNote: '"Apê" = amca (sesleniş hali — vokative). Yabancıya saygı için kullanılır.',
      audioAsset: 'assets/audio/heritage/a2_bazar_4.mp3'),
    DialogueLine(speakerId: 'firoskar',
      kurmanci: 'Pêncsed lîre. Lê ji bo te — çarîsed û pêncî lîre!',
      turkish: 'Beş yüz lira. Ama sana — dört yüz elli lira!',
      grammarNote: '"Ji bo te" = senin için. Kürt pazarında tanıdık indirimi.',
      audioAsset: 'assets/audio/heritage/a2_bazar_5.mp3'),
    DialogueLine(speakerId: 'elif',
      kurmanci: 'Biha gelek e. Tu dikarî kêmtir bikî?',
      turkish: 'Çok pahalı. Biraz indirebilir misin?',
      grammarNote: '"Biha gelek e" = çok pahalı. "Kêmtir" = daha az. "Dikarî + subjunctive".',
      audioAsset: 'assets/audio/heritage/a2_bazar_6.mp3'),
    DialogueLine(speakerId: 'xalti',
      kurmanci: 'Elif, bi Kurmancî baş dipeyivî ha! Min nizanibû ku tu wisa dizanî!',
      turkish: 'Elif, Kurmancî çok iyi konuşuyorsun ha! Böyle bildiğini bilmiyordum!',
      grammarNote: '"Min nizanibû" — geçmiş mükemmel ergatif. "Wisa dizanî" = bu kadar biliyorsun.',
      culturalNote: 'Teyzenin şaşkınlığı heritage öğrenicinin yolculuğunu temsil eder.',
      audioAsset: 'assets/audio/heritage/a2_bazar_7.mp3'),
    DialogueLine(speakerId: 'elif',
      kurmanci: 'Spas, xaltî! Ez hîn dixwînim — ji nû ve dest pê kiriye.',
      turkish: 'Teşekkürler, teyze! Hâlâ öğreniyorum — yeniden başladım.',
      grammarNote: '"Ji nû ve dest pê kiriye" — yeniden başlamış (şimdiki mükemmel).',
      culturalNote: '"Ji nû ve" — asimile Kürtlerin yeniden bağlanma yolculuğu.',
      audioAsset: 'assets/audio/heritage/a2_bazar_8.mp3'),
  ],
);

// A2 Sahne 2: Nexweşxanede — Mehmet (43) ve doktor
// Odak: sağlık ifadeleri, "Ji … re alerjiya min heye", ergatif pratik
const kDialogueA2Nexweş = HeritageDialogue(
  id: 'a2_dlg_nexwes',
  title: 'Li Nexweşxanê',
  turkishTitle: 'Hastanede',
  level: 2,
  lessonId: 'a2_l18',
  characters: [
    DialogueCharacter(
      id: 'mehmet', name: 'Mehmet', age: 43,
      description: 'Orta yaşlı, temel Kurmancî biliyor',
      avatarAsset: 'assets/avatars/mehmet.png', isHeritage: true,
    ),
    DialogueCharacter(
      id: 'bijisk', name: 'Dr. Ronahî', age: 38,
      description: 'Kürt doktor',
      avatarAsset: 'assets/avatars/bijisk.png', isHeritage: false,
    ),
  ],
  lines: [
    DialogueLine(speakerId: 'bijisk',
      kurmanci: 'Xêr hatî. Tu çawa yî? Çi pirsgirêka te heye?',
      turkish: 'Hoş geldiniz. Nasılsın? Ne sorunun var?',
      grammarNote: '"Çi pirsgirêka te heye?" = ne sorunun var? A2 soru kalıbı.',
      audioAsset: 'assets/audio/heritage/a2_nexwes_1.mp3'),
    DialogueLine(speakerId: 'mehmet',
      kurmanci: 'Bijîşk, serêşiya min heye û germahî jî heye. Ji duh ve wiha ye.',
      turkish: 'Doktor, baş ağrım var ve ateşim de var. Dünden beri böyle.',
      grammarNote: '"Ji duh ve" = dünden beri. "Wiha ye" = böyledir.',
      audioAsset: 'assets/audio/heritage/a2_nexwes_2.mp3'),
    DialogueLine(speakerId: 'bijisk',
      kurmanci: 'Fêm dikim. Ji bo te derman dinivîsim. Tu ji tiştekî re alerjî dikî?',
      turkish: 'Anlıyorum. Sana ilaç yazıyorum. Herhangi bir şeye alerjin var mı?',
      grammarNote: '"Ji bo te derman dinivîsim" — şimdiki zaman + ergatif yok (geçişsiz değil, "ji bo te" var).',
      audioAsset: 'assets/audio/heritage/a2_nexwes_3.mp3'),
    DialogueLine(speakerId: 'mehmet',
      kurmanci: 'Erê, bijîşk. Ji penîsîlînê re alerjiya min heye.',
      turkish: 'Evet, doktor. Penisiline alerjim var.',
      grammarNote: '"Ji penîsîlînê re alerjiya min heye" — [AS] s.35 kritik cümle.',
      culturalNote: 'Bu cümle seyahat eden her Kürt için hayat kurtarıcı olabilir.',
      audioAsset: 'assets/audio/heritage/a2_nexwes_4.mp3'),
    DialogueLine(speakerId: 'bijisk',
      kurmanci: 'Baş e, min nivîsand. Dermanê te li dermangehê hazir e. Xweş be!',
      turkish: 'Tamam, yazdım. İlacın eczanede hazır. İyi olun!',
      grammarNote: '"Min nivîsand" — ergatif geçmiş: min (ez eğik) + nivîsand.',
      audioAsset: 'assets/audio/heritage/a2_nexwes_5.mp3'),
    DialogueLine(speakerId: 'mehmet',
      kurmanci: 'Spas bijîşk. Xwedê ji we razî be.',
      turkish: 'Teşekkürler doktor. Allah sizden razı olsun.',
      grammarNote: '"Xwedê ji we razî be" — Kürt kültüründe yaygın teşekkür duası.',
      culturalNote: 'Dini ifadeler Kürt günlük dilinin ayrılmaz parçasıdır.',
      audioAsset: 'assets/audio/heritage/a2_nexwes_6.mp3'),
  ],
);

// A2 Sahne 3: Kürt Okulunda — Narin (31) ve annesinin eski öğretmeni
// Odak: eğitim bağlamı, geçmiş zaman, "berê", karşılaştırma
const kDialogueA2Mekteb = HeritageDialogue(
  id: 'a2_dlg_mekteb',
  title: 'Li Dibistana Kurdî',
  turkishTitle: 'Kürt Okulunda',
  level: 2,
  lessonId: 'a2_l20',
  characters: [
    DialogueCharacter(
      id: 'narin', name: 'Narin', age: 31,
      description: 'Almanya\'da doğmuş, Kurmancî öğreniyor',
      avatarAsset: 'assets/avatars/narin.png', isHeritage: true,
    ),
    DialogueCharacter(
      id: 'mamosta', name: 'Mamosta Leyla', age: 55,
      description: 'Kürt okulu öğretmeni',
      avatarAsset: 'assets/avatars/mamosta.png', isHeritage: false,
    ),
  ],
  lines: [
    DialogueLine(speakerId: 'mamosta',
      kurmanci: 'Narin, tu ji Almanyayê yî? Çawa Kurmancî hîn dibî?',
      turkish: 'Narin, Almanya\'dan mısın? Nasıl Kurmancî öğreniyorsun?',
      grammarNote: '"Tu ji Almanyayê yî?" — ji + yer adı + yî. Köken sorusu.',
      audioAsset: 'assets/audio/heritage/a2_mekteb_1.mp3'),
    DialogueLine(speakerId: 'narin',
      kurmanci: 'Erê mamosta. Berê min Kurmancî nizanibû — lê niha hîn dibim.',
      turkish: 'Evet öğretmenim. Önce Kurmancî bilmiyordum — ama şimdi öğreniyorum.',
      grammarNote: '"Berê" = önce/eskiden. "Nizanibû" = bilmiyordu. "Niha" = şimdi.',
      audioAsset: 'assets/audio/heritage/a2_mekteb_2.mp3'),
    DialogueLine(speakerId: 'mamosta',
      kurmanci: 'Gelek baş e! Malbata te Kurmancî dipeyive?',
      turkish: 'Çok güzel! Ailen Kurmancî konuşuyor mu?',
      grammarNote: '"Malbata te" = ailen (ezafe). "Dipeyive" = konuşuyor (3.tekil).',
      audioAsset: 'assets/audio/heritage/a2_mekteb_3.mp3'),
    DialogueLine(speakerId: 'narin',
      kurmanci: 'Dêya min dipeyive — lê bavê min kêmtir. Pîrêya min — gelek baş dipeyivî!',
      turkish: 'Annem konuşuyor — ama babam daha az. Büyükannem — çok iyi konuşurdu!',
      grammarNote: '"Dipeyivî" = konuşurdu (sürekli geçmiş — B1 önizleme). "Kêmtir" = daha az.',
      culturalNote: 'Büyükanne nesli son akıcı konuşuculardır — heritage öğrenicinin motivasyonu buradan gelir.',
      audioAsset: 'assets/audio/heritage/a2_mekteb_4.mp3'),
    DialogueLine(speakerId: 'mamosta',
      kurmanci: 'Tu di dersa me de gelek pêşde çûyî. Bila ziman bijî!',
      turkish: 'Dersimizde çok ilerlemiş birisin. Dil yaşasın!',
      grammarNote: '"Pêşde çûyî" = ilerlemiş birisin. "Bila bijî!" = yaşasın! (subjunctive).',
      audioAsset: 'assets/audio/heritage/a2_mekteb_5.mp3'),
    DialogueLine(speakerId: 'narin',
      kurmanci: 'Spas, mamosta. Bila ziman bijî — û bila em hemî bi Kurmancî dipeyivin!',
      turkish: 'Teşekkürler, öğretmenim. Dil yaşasın — ve hepimiz Kurmancî konuşalım!',
      grammarNote: '"Bila em hemî dipeyivin" = hepimiz konuşalım (subjunctive çoğul).',
      culturalNote: 'Heritage öğrenicinin en büyük hayali — dilin toplulukta yaşaması.',
      audioAsset: 'assets/audio/heritage/a2_mekteb_6.mp3'),
  ],
);

// A2 Sahne 4: Havalimanında — Hasan (58) ve kızı
// Odak: seyahat ifadeleri, gelecek zaman, yön sorma
const kDialogueA2Rêwîtî = HeritageDialogue(
  id: 'a2_dlg_rewiti',
  title: 'Li Balafirgehê',
  turkishTitle: 'Havalimanında',
  level: 2,
  lessonId: 'a2_l06',
  characters: [
    DialogueCharacter(
      id: 'hasan', name: 'Hasan', age: 58,
      description: 'Vatanını ziyarete gidiyor — yıllardır ilk kez',
      avatarAsset: 'assets/avatars/hasan.png', isHeritage: true,
    ),
    DialogueCharacter(
      id: 'keça', name: 'Keça Hasan — Zêynep', age: 28,
      description: 'Türkiye\'de büyümüş, babası kadar bilmiyor',
      avatarAsset: 'assets/avatars/zeynep.png', isHeritage: true,
    ),
    DialogueCharacter(
      id: 'karker', name: 'Karkera Balafirgehê', age: 35,
      description: 'Havalimanı görevlisi',
      avatarAsset: 'assets/avatars/karker.png', isHeritage: false,
    ),
  ],
  lines: [
    DialogueLine(speakerId: 'hasan',
      kurmanci: 'Zêynep, em li balafirgehê ne. Balet me amade ne?',
      turkish: 'Zeynep, havalimanındayız. Biletlerimiz hazır mı?',
      grammarNote: '"Em li balafirgehê ne" — "li" + yer. "Amade ne?" = hazır mı? (çoğul).',
      audioAsset: 'assets/audio/heritage/a2_rewiti_1.mp3'),
    DialogueLine(speakerId: 'keça',
      kurmanci: 'Erê bavo, biletên me di destên min de ne. Balafir kengî difire?',
      turkish: 'Evet babacım, biletlerimiz elimde. Uçuş ne zaman?',
      grammarNote: '"Di destên min de" = elimde (çoğul iyelik). "Sefer kengî ye?" = uçuş ne zaman?',
      audioAsset: 'assets/audio/heritage/a2_rewiti_2.mp3'),
    DialogueLine(speakerId: 'hasan',
      kurmanci: 'Du saet mane. Bavo, ez gelek heyecan im — ez diçim welatê xwe piştî bîst û pênc salan.',
      turkish: 'İki saat kaldı. Kızım, çok heyecanlıyım — yirmi beş yıl sonra vatanıma gidiyorum.',
      grammarNote: '"Piştî bîst û pênc salan" = yirmi beş yıldan sonra. Zaman edatı + sayı.',
      culturalNote: 'Onlarca yıl sonra vatana dönüş Kürt diasporasının ortak deneyimidir.',
      audioAsset: 'assets/audio/heritage/a2_rewiti_3.mp3'),
    DialogueLine(speakerId: 'keça',
      kurmanci: 'Bavo, ez jî bi te re şa me. Tu dê bi Kurmancî dipeyivî li wir?',
      turkish: 'Babacım, ben de seninle mutluyum. Orada Kurmancî konuşacak mısın?',
      grammarNote: '"Tu dê … dipeyivî" = konuşacak mısın? Gelecek zaman + soru.',
      audioAsset: 'assets/audio/heritage/a2_rewiti_4.mp3'),
    DialogueLine(speakerId: 'hasan',
      kurmanci: 'Bê guman! Û tu jî dê hîn bibî — welatê me dersên çêtirîn dide!',
      turkish: 'Şüphesiz! Ve sen de öğreneceksin — vatanımız en iyi dersleri verir!',
      grammarNote: '"Bê guman" = şüphesiz. "Dersên çêtirîn" = en iyi dersler (üstünlük).',
      audioAsset: 'assets/audio/heritage/a2_rewiti_5.mp3'),
    DialogueLine(speakerId: 'karker',
      kurmanci: 'Balet xwe amade bikin — balafir saetek din dê were.',
      turkish: 'Biletlerinizi hazırlayın — uçak bir saat sonra gelecek.',
      grammarNote: '"Dê were" = gelecek (gelecek zaman geçişsiz).',
      audioAsset: 'assets/audio/heritage/a2_rewiti_6.mp3'),
    DialogueLine(speakerId: 'hasan',
      kurmanci: 'Spas. Keça min, rêwîtiya baş bixwazin ji bo me!',
      turkish: 'Teşekkürler. Kızım, bizim için iyi yolculuklar dileyin!',
      grammarNote: '"Rêwîtiya baş bixwazin" = iyi yolculuklar dileyin (subjunctive çoğul).',
      culturalNote: 'Vatan yolculuğu — Kürt diasporasının en anlamlı anlarından biri.',
      audioAsset: 'assets/audio/heritage/a2_rewiti_7.mp3'),
  ],
);

// ── ID'ye göre getir ─────────────────────────────────────────────

HeritageDialogue? getDialogueById(String id) {
  try {
    return kHeritageDiyaloglar.firstWhere((d) => d.id == id);
  } catch (_) {
    return null;
  }
}


// ════════════════════════════════════════════════════════════════
// B2 DİYALOGLARI — 3 Sahne
// Odak: pasif yapı, bileşik fiiller, şartlı cümle, ileri ergatif
// ════════════════════════════════════════════════════════════════

// B2 Sahne 1: Goran (35) — Diaspora kimlik tartışması
const kDialogueB2Nasnameya = HeritageDialogue(
  id: 'b2_dlg_nasname',
  title: 'Nasnameya Cot',
  turkishTitle: 'Çift Kimlik',
  level: 4,
  lessonId: 'b2_l17',
  characters: [
    DialogueCharacter(
      id: 'goran35', name: 'Goran', age: 35,
      description: 'Hollanda doğumlu araştırmacı — kimlik üzerine düşünüyor',
      avatarAsset: 'assets/avatars/goran.png', isHeritage: true,
    ),
    DialogueCharacter(
      id: 'prof', name: 'Prof. Dr. Leyla', age: 52,
      description: 'Kürt sosyoloji profesörü',
      avatarAsset: 'assets/avatars/prof_leyla.png', isHeritage: false,
    ),
  ],
  lines: [
    DialogueLine(speakerId: 'goran35',
      kurmanci: 'Prof. Dr. Leyla, nasnameya cot çi ye? Ez hem kurd im hem Hollandî.',
      turkish: 'Prof. Dr. Leyla, çift kimlik nedir? Hem Kürt hem Hollandalıyım.',
      grammarNote: '"Hem...hem" yapısı Kurmancîde: "Hem... hem jî..." veya "û jî" ile.',
      audioAsset: 'assets/audio/heritage/b2_nasname_1.mp3'),
    DialogueLine(speakerId: 'prof',
      kurmanci: 'Nasnameya cot tê gotin ku kes di navbera du çandan de dijî.
Ne ev e ne ew e — her du jî ye.',
      turkish: 'Çift kimlik denilir ki kişi iki kültür arasında yaşar.
Ne bu ne o — her ikisi de.',
      grammarNote: '"Tê gotin ku..." = denilir ki (pasif şimdiki). "Di navbera... de" = arasında.',
      culturalNote: 'Heritage öğrenicinin akademik düzeyde kimlik sorusunu ele alması.',
      audioAsset: 'assets/audio/heritage/b2_nasname_2.mp3'),
    DialogueLine(speakerId: 'goran35',
      kurmanci: 'Lê ger nasnameya Kurdistanî xwe bigiranda, çi diguheriya?',
      turkish: 'Ama Kürdistan kimliği kendini daha güçlü tutsa, ne değişirdi?',
      grammarNote: '"Bigiranda" = gerçekleşmemiş şart (geçmiş). "Diguheriya" = değişirdi.',
      audioAsset: 'assets/audio/heritage/b2_nasname_3.mp3'),
    DialogueLine(speakerId: 'prof',
      kurmanci: 'Heke nasname bihêz bûya, ziman jî bihêztir bûya.
Weke ku Xanî gotibû: "yekîtî" temel e.',
      turkish: 'Kimlik güçlü olsaydı, dil de daha güçlü olurdu.
Xanî'nin dediği gibi: "birlik" temeldir.',
      grammarNote: '"Bihêz bûya" = güçlü olsaydı (gerçekleşmemiş şart -ya eki). "Weke ku gotibû" = dediği gibi (geçmiş mükemmel).',
      audioAsset: 'assets/audio/heritage/b2_nasname_4.mp3'),
    DialogueLine(speakerId: 'goran35',
      kurmanci: 'Dest avêtim hînbûna Kurmancî — û êdî ez bi xwe li ser sekinîme.',
      turkish: 'Kurmancî öğrenimine başladım — ve artık kendim üzerinde duruyorum.',
      grammarNote: '"Dest avêtim" = başladım (bileşik fiil). "Li ser sekinîme" = üzerinde duruyorum.',
      audioAsset: 'assets/audio/heritage/b2_nasname_5.mp3'),
    DialogueLine(speakerId: 'prof',
      kurmanci: 'Ev têkoşerin e! Weke ku tê zanîn, ziman nasnameya mezintirîn e.',
      turkish: 'Bu mücadeledir! Bilindiği gibi, dil en büyük kimliktir.',
      grammarNote: '"Weke ku tê zanîn" = bilindiği gibi (pasif kalıp). "Mezintirîn" = en büyük (üstünlük).',
      culturalNote: 'B2'nin sentezi: pasif, bileşik fiil, şartlı cümle, kimlik.',
      audioAsset: 'assets/audio/heritage/b2_nasname_6.mp3'),
  ],
);

// B2 Sahne 2: Selin (27) — Edebiyat üzerine sohbet
const kDialogueB2Edebiyat = HeritageDialogue(
  id: 'b2_dlg_edebiyat',
  title: 'Li Ser Wêjeyê',
  turkishTitle: 'Edebiyat Üzerine',
  level: 4,
  lessonId: 'b2_l14',
  characters: [
    DialogueCharacter(
      id: 'selin27', name: 'Selin', age: 27,
      description: 'Edebiyat öğrencisi — Kürtçe okumaya başlıyor',
      avatarAsset: 'assets/avatars/selin.png', isHeritage: true,
    ),
    DialogueCharacter(
      id: 'mamosta2', name: 'Mamosta Dîlan', age: 44,
      description: 'Edebiyat dersi veriyor',
      avatarAsset: 'assets/avatars/mamosta_dilan.png', isHeritage: false,
    ),
  ],
  lines: [
    DialogueLine(speakerId: 'selin27',
      kurmanci: 'Mamosta, min Mem û Zîn xwend — lê hin caran zehmet bû fêm bikim.',
      turkish: 'Öğretmenim, Mem û Zîn okudum — ama bazen anlamak zordu.',
      grammarNote: '"Min xwend" = okudum (ergatif). "Fêm bikim" = anlayayım (subjunctive).',
      audioAsset: 'assets/audio/heritage/b2_edebiyat_1.mp3'),
    DialogueLine(speakerId: 'mamosta2',
      kurmanci: 'Normal e! Mem û Zîn di 1695an de hatiye nivîsandin.
Zimana wê kevnar e lê bedew e.',
      turkish: 'Normal! Mem û Zîn 1695'te yazılmıştır.
Dili eski ama güzeldir.',
      grammarNote: '"Hatiye nivîsandin" = yazılmıştır (şimdiki mükemmel pasif). "Di 1695an de" = 1695'te.',
      audioAsset: 'assets/audio/heritage/b2_edebiyat_2.mp3'),
    DialogueLine(speakerId: 'selin27',
      kurmanci: 'Xanî çima ev berhem nivîsand? Tenê ji bo aşqê?',
      turkish: 'Xanî neden bu eseri yazdı? Sadece aşk için mi?',
      grammarNote: '"Çima... nivîsand?" — geçmiş ergatif: Xanî (özne) + nivîsand (kök). Ama isim özne dişil değil, eğik yok burada.',
      audioAsset: 'assets/audio/heritage/b2_edebiyat_3.mp3'),
    DialogueLine(speakerId: 'mamosta2',
      kurmanci: 'Na! Di pêşgotinê de Xanî gotiye:
"Kurd çima di nav gelên din de paşde mane?"
Bersiv: yekîtî tune ye. Û ziman yekîtiyê ava dike.',
      turkish: 'Hayır! Önsözde Xanî şunu söylemiştir:
"Kürtler neden diğer halklar arasında geri kaldı?"
Cevap: birlik yok. Ve dil birliği kurar.',
      grammarNote: '"Gotiye" = söylemiştir (şimdiki mükemmel ergatif). "Ava dike" = kurar/inşa eder.',
      culturalNote: 'Xanî'nin siyasi mesajı B2'de derinlemesine analiz edilir.',
      audioAsset: 'assets/audio/heritage/b2_edebiyat_4.mp3'),
    DialogueLine(speakerId: 'selin27',
      kurmanci: 'Ger Xanî îro bijiya, dê çi bibêja?',
      turkish: 'Xanî bugün yaşıyor olsaydı, ne derdi?',
      grammarNote: '"Bijiya" = yaşıyor olsaydı (gerçekleşmemiş şart). "Dê bibêja" = derdi (şartlı gelecek).',
      audioAsset: 'assets/audio/heritage/b2_edebiyat_5.mp3'),
    DialogueLine(speakerId: 'mamosta2',
      kurmanci: 'Belkî dê got: "Ziman dijî — lewre em jî dijîn!"
Ev pirsa te gelek kûr e. Bila berdewam bikî.',
      turkish: 'Belki derdi: "Dil yaşıyor — bu yüzden biz de yaşıyoruz!"
Bu sorun çok derin. Devam et.',
      grammarNote: '"Dê got" = derdi (şartlı geçmiş). "Bila berdewam bikî" = devam et (subjunctive).',
      audioAsset: 'assets/audio/heritage/b2_edebiyat_6.mp3'),
  ],
);

// B2 Sahne 3: Hasan (58) — Vatan dönüşünde konuşma
const kDialogueB2Welat = HeritageDialogue(
  id: 'b2_dlg_welat',
  title: 'Vegerîna Welatê',
  turkishTitle: 'Vatana Dönüş',
  level: 4,
  lessonId: 'b2_l18',
  characters: [
    DialogueCharacter(
      id: 'hasan58', name: 'Hasan', age: 58,
      description: 'Yirmi beş yıl sonra vatanında',
      avatarAsset: 'assets/avatars/hasan.png', isHeritage: true,
    ),
    DialogueCharacter(
      id: 'apekhalid', name: 'Apê Xalid', age: 72,
      description: 'Köyde kalan ağabeyi',
      avatarAsset: 'assets/avatars/ap_halid.png', isHeritage: false,
    ),
  ],
  lines: [
    DialogueLine(speakerId: 'hasan58',
      kurmanci: 'Apê Xalid, bîst û pênc sal borîn. Gund gelek guherîye.',
      turkish: 'Ağabeyim Xalid, yirmi beş yıl geçti. Köy çok değişmiş.',
      grammarNote: '"Borîn" = geçtiler (geçişsiz, yalın). "Guherîye" = değişmiş (şimdiki mükemmel geçişsiz).',
      audioAsset: 'assets/audio/heritage/b2_welat_1.mp3'),
    DialogueLine(speakerId: 'apekhalid',
      kurmanci: 'Erê, gelek tişt guherîye. Lê ax û çiya û ziman — ev neguherîye.',
      turkish: 'Evet, çok şey değişti. Ama toprak, dağ ve dil — bunlar değişmedi.',
      grammarNote: '"Neguherîye" = değişmemiş (olumsuz şimdiki mükemmel). "Ax û çiya û ziman" paralel yapı.',
      audioAsset: 'assets/audio/heritage/b2_welat_2.mp3'),
    DialogueLine(speakerId: 'hasan58',
      kurmanci: 'Li Almanyayê ez dixwestim Kurmancî hîn bibûma — lê destê min neketibû.',
      turkish: 'Almanya'da Kurmancî öğrenmek istemiştim — ama fırsat bulamamıştım.',
      grammarNote: '"Dixwestim" = istiyordum (sürekli geçmiş). "Hîn bibûma" = öğrenmiş olsaydım. "Neketibû" = düşmemişti (geçmiş mükemmel olumsuz).',
      culturalNote: 'Pişmanlık ve dönüş — diaspora deneyiminin derin boyutu.',
      audioAsset: 'assets/audio/heritage/b2_welat_3.mp3'),
    DialogueLine(speakerId: 'apekhalid',
      kurmanci: 'Niha tu hatî — û ev bes e. Weke ku tê zanîn, der hate girtin,
lê pencere vebûye.',
      turkish: 'Şimdi geldin — ve bu yeter. Bilindiği gibi, kapı kapandı ama pencere açıldı.',
      grammarNote: '"Tê zanîn" = bilinir (pasif şimdiki). "Hate girtin" = kapandı (geçmiş pasif). "Vebûye" = açılmış (şimdiki mükemmel).',
      audioAsset: 'assets/audio/heritage/b2_welat_4.mp3'),
    DialogueLine(speakerId: 'hasan58',
      kurmanci: 'Ger min berê dest avêtana, îro baştir bidizanî.
Lê ji niha pê ve, ezê hînbûnê berdewam bikim.',
      turkish: 'Önce başlamış olsaydım, bugün daha iyi bilirdim.
Ama bundan böyle öğrenmeye devam edeceğim.',
      grammarNote: '"Dest avêtana" = başlamış olsaydım (gerçekleşmemiş). "Ezê berdewam bikim" = devam edeceğim (gelecek + subjunctive).',
      audioAsset: 'assets/audio/heritage/b2_welat_5.mp3'),
    DialogueLine(speakerId: 'apekhalid',
      kurmanci: 'Bila ber bi riya welatê xwe ve here, Hasan.
Ziman bi te re ye — û tu bi zimên li vir î.',
      turkish: 'Vatanının yoluna gid, Hasan.
Dil seninle — ve dille burdasın.',
      grammarNote: '"Ber bi ... ve here" = bileşik fiil yön. "Bila here" = gitsin (subjunctive dilek). "Bi zimên li vir î" = dille burdasın.',
      culturalNote: 'B2'nin son mesajı: dil = mekan. Nerede konuşursan orası vatandır.',
      audioAsset: 'assets/audio/heritage/b2_welat_6.mp3'),
  ],
);

const kHeritageDiyaloglar = [
  kDialoguePiree, kDialogueSifre, kDialogueTelefon,
  kDialogueMalbat, kDialogueDersa,
  kDialogueA2Bazar, kDialogueA2Nexweş, kDialogueA2Mekteb, kDialogueA2Rêwîtî,
  kDialogueB1Ninni, kDialogueB1Mezar, kDialogueB1Heval,
  kDialogueB2Nasnameya, kDialogueB2Edebiyat, kDialogueB2Welat,
];