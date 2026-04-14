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
// DİYALOG 1 — Çayê Dapîrê
// Büyükanneyle çay — en duygusal sahne
// Persona: Elif (24, İstanbul) büyükannesini ziyaret ediyor.
// ════════════════════════════════════════════════════════════════

const kDialoguePiree = HeritageDialogue(
  id: 'dlg_piree_cay',
  kurmanjTitle: 'Çayê Dapîrê',
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
      speaker: 'Dapîr',
      speakerRole: 'Dapîr',
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
      speaker: 'Dapîr',
      speakerRole: 'Dapîr',
      kurmanci: 'Ez baş im, spas. Tu çawa yî, keçê?',
      turkish: 'İyiyim, teşekkürler. Sen nasılsın, kızım?',
      grammarNote: '"Keçê" — kız çocuğuna sevgi hitabı (vokatif). Erkek için "kuro" kullanılır.',
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
      speaker: 'Dapîr',
      speakerRole: 'Dapîr',
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
      speaker: 'Dapîr',
      speakerRole: 'Dapîr',
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
      speaker: 'Dapîr',
      speakerRole: 'Dapîr',
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
      kurmanci: 'Ser çavan, kurê min! Rûne, rûne.',
      turkish: 'Baş üstüne, oğlum! Otur, otur.',
      grammarNote: '"Ser çavan" = baş/gözler üstüne — teşekküre kibar yanıt (standart Kurmancî).',
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
      kurmanci: 'Ser çavan! Nûş be!',
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
      speaker: 'Dapîr',
      speakerRole: 'Dapîr',
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
      speaker: 'Dapîr',
      speakerRole: 'Dapîr',
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
      speaker: 'Dapîr',
      speakerRole: 'Dapîr',
      kurmanci: 'Çi ye ev? Lazim nebû! Gelek spas, kurê min.',
      turkish: 'Bu ne? Gerekmezdi! Çok teşekkürler, oğlum.',
      grammarNote: '"Lazim nebû" = gerekmezdi (geçmiş olumsuz).',
      culturalNote: '"Lazim nebû!" demek kibarlık gereği — hediyeyi memnuniyetle alıyor.',
      audioAsset: 'assets/audio/heritage/dlg4_06.mp3',
    ),
    DialogueLine(
      speaker: 'Dapîr',
      speakerRole: 'Dapîr',
      kurmanci: 'Hemî rûnin! Ezê çay bikim.',
      turkish: 'Hepiniz oturun! Çay yapayım.',
      grammarNote: '"Hemî rûnin!" = hepiniz oturun (çoğul emir).',
      audioAsset: 'assets/audio/heritage/dlg4_07.mp3',
    ),
  ],
);

// ════════════════════════════════════════════════════════════════
// DİYALOG 5 — Dapîr Mamostayê Min e
// Büyükannem Öğretmenim
// Persona: Narin (31) büyükannesinden kelime öğreniyor.
// ════════════════════════════════════════════════════════════════

const kDialogueDersa = HeritageDialogue(
  id: 'dlg_dersa_piree',
  kurmanjTitle: 'Dapîr Mamostayê Min e',
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
      speaker: 'Dapîr',
      speakerRole: 'Dapîr',
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
      speaker: 'Dapîr',
      speakerRole: 'Dapîr',
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
      speaker: 'Dapîr',
      speakerRole: 'Dapîr',
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
      speaker: 'Dapîr',
      speakerRole: 'Dapîr',
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
      speaker: 'Dapîr',
      speakerRole: 'Dapîr',
      kurmanci: 'Ez jî ji te hez dikim, keça min. Ziman jiyana me ye.',
      turkish: 'Ben de seni seviyorum kızım. Dil, bizim hayatımız.',
      grammarNote: '"Ez jî" = ben de. "Jiyana me ye" = bizim hayatımız.',
      culturalNote: 'Final — dil ve sevgi birlikte, A1\'in son armağanı.',
      audioAsset: 'assets/audio/heritage/dlg5_10.mp3',
    ),
  ],
);

// ════════════════════════════════════════════════════════════════
// A1 TÜM DİYALOGLAR
// ════════════════════════════════════════════════════════════════

const kHeritageDiyaloglar = [
  kDialoguePiree, kDialogueSifre, kDialogueTelefon,
  kDialogueMalbat, kDialogueDersa,
];
