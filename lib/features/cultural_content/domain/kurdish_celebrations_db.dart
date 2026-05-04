// ════════════════════════════════════════════════════════════════
// KURDISH CELEBRATIONS DATABASE — CEJN Û FESTÎVALÊN KURDÎ
//
// 8 cejn û festîval ji çanda Kurdan: ji Newrozê heta Roja Zimanê
// Kurdî. Her giriş: dîrok + adetên rojane + nirxa sembolîk.
//
// Standard: Bedirxan-Hawar (Latînî 1932). Diakritikên rast.
//
// Kaynak: Institut Kurde de Paris yayınları, Ronî Welat —
// "Cejnên Kurdan" (2008), Bedirxan Lescot etnografya kayıtları,
// Kurdipedia bayram sayfaları.
// ════════════════════════════════════════════════════════════════

import '../cultural_entities.dart';

const kKurdishCelebrations = <CulturalItem>[
  // ── c_001: Newroz — 21 Adar ───────────────────────────────
  CulturalItem(
    id: 'cel_001',
    type: CulturalContentType.celebration,
    kurmanjTitle: 'Newroz — 21 Adar',
    turkishTitle: 'Newroz — 21 Mart',
    kurmanjContent:
        'Newroz, cejna gelêrî ya kurdî ye, di 21ê Adarê de tê '
        'pîroz kirin. Peyva "Newroz" ji du parçeyan tê: "now" '
        '(nû) û "roz" (roj) — yanî "Roja Nû".\n\n'
        'Mîtolojî:\n'
        'Li gor destana Şahnameyê (Firdewsî), Kawayê hesinkar '
        'di vê rojê de li dijî dîktatorê zalim Dehakê Tazî rabû. '
        'Kawa bi bizmara xwe Dehak kuşt û azadiyê li gel anî. Ji '
        'wê rojê û pê ve, agirên Newrozê li ser çiyan tên dadan — '
        'wek nîşana azadî û ronîya ku tariyê dûr dixe.\n\n'
        'Adetên îro:\n'
        '• Malbat li deşt û çiyan kom dibin.\n'
        '• Agir tê dadan, zarokan ji ser agir bazdayîna xwe dikin '
        '  (sembola paqijbûn û nûjeniyê).\n'
        '• Govend û dawet tê meşandin: govenda Newrozê.\n'
        '• Cilên Kurdî tên lixwekirin: keçik fîstan û kofî, '
        '  lawik şal û şepik.\n'
        '• Hêkên rengîn — sor, kesk, zer — tên amade kirin.\n\n'
        'Bawerî: Ev roj destpêka biharê ye — gulîlk dest bi geşbûnê '
        'dikin, jiyana nû dest pê dike. Kurd Newrozê wek "destpêka '
        'sala xwe" jî dipejirînin.',
    turkishContent:
        'Newroz, Kürt halk bayramıdır; 21 Mart\'ta kutlanır. '
        '"Newroz" sözcüğü iki parçadan oluşur: "now" (yeni) ve '
        '"roz" (gün) — yani "Yeni Gün".\n\n'
        'Mitoloji:\n'
        'Şehname destanına göre (Firdevsî), demirci Kawa bu günde '
        'zalim diktatör Dehak\'a karşı ayaklandı. Kawa çekiciyle '
        'Dehak\'ı öldürdü ve halka özgürlüğü getirdi. O günden bu '
        'yana, Newroz ateşleri dağlarda yakılır — özgürlüğün ve '
        'karanlığı kovan ışığın sembolü.\n\n'
        'Günümüz adetleri:\n'
        '• Aileler ova ve dağlarda toplanır.\n'
        '• Ateş yakılır, çocuklar ateşin üzerinden atlar (arınma '
        '  ve yenilenme sembolü).\n'
        '• Halay ve şenlikler düzenlenir: Newroz halayı.\n'
        '• Geleneksel Kürt kıyafetleri giyilir: kız fîstan ve kofî, '
        '  oğlan şal û şepik.\n'
        '• Kırmızı, yeşil, sarı boyalı yumurtalar hazırlanır.\n\n'
        'İnanç: Bu gün baharın başlangıcıdır — çiçekler açar, yeni '
        'hayat başlar. Kürtler Newroz\'u "yılbaşı" olarak da kabul '
        'eder.',
    backgroundNote:
        'Newroz, Kürtler dışında Farslar, Tacikler, Afganlar, '
        'Azeriler ve Orta Asya halkları tarafından da kutlanır. '
        'BM 2010\'da 21 Mart\'ı "Uluslararası Newroz Günü" ilan '
        'etti. Cegerxwîn ve Hêmîn Mukriyanî Newroz şiirleri '
        'yazmıştır; "Newroz Newroz" Şivan Perwer\'in en tanınmış '
        'şarkılarındandır.',
    level: 1,
    unitId: 'celebration',
    keywords: ['Newroz', 'Kawa', 'Adar', 'agir', 'cejn'],
  ),

  // ── c_002: Roja Zimanê Kurdî — 15 Gulan ──────────────────
  CulturalItem(
    id: 'cel_002',
    type: CulturalContentType.celebration,
    kurmanjTitle: 'Roja Zimanê Kurdî — 15 Gulan',
    turkishTitle: 'Kürt Dili Günü — 15 Mayıs',
    kurmanjContent:
        'Roja Zimanê Kurdî, di 15ê Gulanê de tê pîroz kirin. Ev '
        'roj sembola çapkirina kovara "Hawar" e — kovara yekem a '
        'Kurmancî bi alfabeya Latînî, ku di 15ê Gulanê 1932\'yan '
        'de li Şamê hate weşandin.\n\n'
        'Dîrok:\n'
        'Mîr Celadet Alî Bedirxan, bi alîkariya birayê xwe Kamûran '
        'Bedirxan û rewşenbîrên Kurd ên xerîb, Hawar damezrand. '
        'Tê de:\n'
        '• Alfabeya Bedirxan (Latînî, 31 tîp).\n'
        '• Helbest, çîrok, gotinên gelêrî.\n'
        '• Ferhengoka piçûk a Kurmancî-Fransî.\n'
        '• Berhemên Cegerxwîn, Qedrîcan, Osman Sebrî.\n\n'
        'Adetên îro:\n'
        '• Sempozyumên akademîk li ser zimanê Kurdî.\n'
        '• Pêşbirka helbest û ceribandinê.\n'
        '• Belavkirina pirtûkên nû yên Kurmancî.\n'
        '• Bername yên zarokan li ser xwendin û nivîsîna Kurmancî.\n\n'
        'Çavkanî: Ev roj her sal ji aliyê Enstîtuya Kurdî ya Parîsê, '
        'PEN Kurd û saziyên ziman ve tê pîroz kirin.',
    turkishContent:
        'Kürt Dili Günü 15 Mayıs\'ta kutlanır. Bu gün "Hawar" '
        'dergisinin yayımlanma sembolüdür — Latin alfabesiyle ilk '
        'Kurmancî dergi, 15 Mayıs 1932\'de Şam\'da çıkmıştır.\n\n'
        'Tarih:\n'
        'Mîr Celadet Alî Bedirxan, kardeşi Kamûran Bedirxan ve '
        'sürgündeki Kürt aydınların yardımıyla Hawar\'ı kurdu. '
        'İçeriği:\n'
        '• Bedirxan alfabesi (Latin, 31 harf).\n'
        '• Şiir, hikâye, atasözü.\n'
        '• Küçük Kurmancî-Fransızca sözlük.\n'
        '• Cegerxwîn, Qedrîcan, Osman Sebrî eserleri.\n\n'
        'Günümüz adetleri:\n'
        '• Kürt dili akademik sempozyumları.\n'
        '• Şiir ve deneme yarışmaları.\n'
        '• Yeni Kurmancî kitap yayınlanması.\n'
        '• Çocuklar için Kurmancî okuma-yazma programları.\n\n'
        'Kaynak: Bu gün her yıl Paris Kürt Enstitüsü, PEN Kürt ve '
        'dil kurumları tarafından kutlanır.',
    backgroundNote:
        'Hawar 1932-1943 arası 57 sayı çıktı. Bedirxan alfabesi '
        'günümüz Kurmancî yazımının standardıdır. Kovara Hawarê '
        'tıpkıbasımları Institut Kurde de Paris arşivinde '
        'mevcuttur.',
    level: 2,
    unitId: 'celebration',
    keywords: ['Hawar', 'Bedirxan', 'ziman', 'Kurmancî', 'kovar'],
  ),

  // ── c_003: Çarşema Sor (Yezidî Yeni Yılı) ────────────────
  CulturalItem(
    id: 'cel_003',
    type: CulturalContentType.celebration,
    kurmanjTitle: 'Çarşema Sor — Sersala Êzîdiyan',
    turkishTitle: 'Çarşema Sor — Yezidî Yeni Yılı',
    kurmanjContent:
        'Çarşema Sor, cejna nû ya gelê Êzîdî ye. Di yekem çarşemiya '
        'meha Nîsanê de tê pîroz kirin (li gor salnameya kevneşopî '
        'a Şargo).\n\n'
        'Bawerî:\n'
        'Li gor mîtolojiya Êzîdî, Tawisî Melek (Periyê Tawûs) di '
        'vê rojê de hate xelifîn ji bo parastina cîhanê. Ev nîşana '
        'destpêka cîhanê û xelasiya mirovahiyê ye. Tawisî Melek, '
        'di baweriya Êzîdî de, periyê herî bilind e — wek peyamberê '
        'navberê di navbera Xwedê û mirov de.\n\n'
        'Adetên rojane:\n'
        '• Hêkên rengîn tên amade kirin: sor, kesk, zer — sembola '
        '  baharê û jiyanê.\n'
        '• Li ser gorên bav û bapîran xwarin tê danîn — sembola '
        '  bîranînê û peywendiya bi peywendiyên berê re.\n'
        '• Govenda Hewlê û dîlanên kevneşopî tên kirin.\n'
        '• Şewatên piçûk li ber deriyên malan tên dadan.\n'
        '• Şîr û şîranî ji zarokan re tê belavkirin.\n\n'
        'Cih: Lalîş (cihê pîroz ê Êzîdiyan), Şingal (Sîncar), '
        'Şêxan û Hewlêr navendên sereke ne. Roja Çarşema Sor li '
        'her cîhana Êzîdiyan tê pîroz kirin.',
    turkishContent:
        'Çarşema Sor, Yezidi halkının yeni yıl bayramıdır. Nisan '
        'ayının ilk Çarşamba\'sında kutlanır (geleneksel Şargo '
        'takvimi).\n\n'
        'İnanç:\n'
        'Yezidi mitolojisine göre, Tawusî Melek (Tavus Periye) bu '
        'günde dünyayı korumak için yaratıldı. Bu, dünyanın '
        'başlangıcının ve insanlığın kurtuluşunun sembolüdür. '
        'Tawusî Melek, Yezidi inancında en yüce melektir — Tanrı '
        've insan arasındaki aracı peygamber gibidir.\n\n'
        'Günlük adetler:\n'
        '• Renkli yumurtalar hazırlanır: kırmızı, yeşil, sarı — '
        '  bahar ve hayatın sembolü.\n'
        '• Atalar mezarlığında yemekler bırakılır — anma ve '
        '  geçmiş kuşaklarla bağ sembolü.\n'
        '• Hewlê halayı ve geleneksel danslar yapılır.\n'
        '• Ev kapılarının önünde küçük ateşler yakılır.\n'
        '• Süt ve tatlılar çocuklara dağıtılır.\n\n'
        'Yer: Lalîş (Yezidilerin kutsal yeri), Şingal (Sincar), '
        'Şêxan ve Hewlêr başlıca merkezlerdir. Çarşema Sor tüm '
        'Yezidi diasporasında kutlanır.',
    backgroundNote:
        'Yezidi inancı kadim Mezopotamya, Zerdüşt ve İslam '
        'sentezidir. Çarşema Sor 6700 yıl öncesine dayanan '
        'tarihiyle dünyanın en eski yeni yıl kutlamalarından '
        'biridir. 2014 Şingal soykırımı sonrası Yezidi diasporası '
        'için bu bayramın korunması varlığın simgesi haline gelmiştir.',
    level: 3,
    unitId: 'celebration',
    keywords: ['Çarşema Sor', 'Êzîdî', 'Tawisî Melek', 'Lalîş', 'Nîsan'],
  ),

  // ── c_004: Roja Şehîdên Kurdistan ────────────────────────
  CulturalItem(
    id: 'cel_004',
    type: CulturalContentType.celebration,
    kurmanjTitle: 'Roja Şehîdên Kurdistan — 14 Gulan',
    turkishTitle: 'Kürdistan Şehitler Günü — 14 Mayıs',
    kurmanjContent:
        'Roja Şehîdên Kurdistan, di 14ê Gulanê de tê pîroz kirin. '
        'Ev roj ji bo bîranîna hemû kesên ku jiyana xwe ji bo '
        'azadî, ziman û nasnameya Kurdan dane ye.\n\n'
        'Bîranîn:\n'
        '14ê Gulanê wek "roja bîranîna giştî" tê pejirandin. Ev '
        'roj nîşaneke wê ye ku bedelên azadiyê û berxwedaniyê '
        'dîrokê pir bilind bûne — ji şexsiyetên dîrokî yên wek '
        'Şêx Seîd û Qazî Mihemed, heta nasnameyên gelekî yên '
        'kêm-naskirî.\n\n'
        'Adetên rojane:\n'
        '• Goristanên şehîdan tên ziyaret kirin.\n'
        '• Çiçek û şamdan li ser goran tê danîn.\n'
        '• Aramî û kêliyên bêdengî tê parastin.\n'
        '• Helbest û şîroveyên dîrokî tên xwendin.\n'
        '• Pirtûk û dokumanterên dîrokî yên Kurd tên belavkirin.\n\n'
        'Wateya çandî: Ji bo gelek malbatên Kurd, ev roj nîşana '
        'mîratê ye — ya ku bav û bapîran ji bo aşitî û pasportekî '
        'aramtir li dûv hiştine.',
    turkishContent:
        'Kürdistan Şehitler Günü 14 Mayıs\'ta anılır. Bu gün, '
        'Kürtlerin özgürlüğü, dili ve kimliği için hayatını veren '
        'tüm bireylerin anısına ayrılmıştır.\n\n'
        'Anma:\n'
        '14 Mayıs "genel anma günü" olarak kabul edilir. Bu gün, '
        'özgürlük ve direnişin bedellerinin tarih boyunca ne kadar '
        'yüksek olduğunun bir sembolüdür — Şêx Seîd, Qazî Mihemed '
        'gibi tarihi kişiliklerden, halkın az tanınan isimlerine '
        'kadar.\n\n'
        'Günlük adetler:\n'
        '• Şehit mezarlıkları ziyaret edilir.\n'
        '• Çiçek ve mum mezarlara konur.\n'
        '• Sessizlik anıtları korunur.\n'
        '• Tarihi şiir ve yorumlar okunur.\n'
        '• Kürt kitap ve belgeselleri dağıtılır.\n\n'
        'Kültürel anlam: Birçok Kürt aile için bu gün miras '
        'sembolüdür — dedeler ve babalar barış ve huzurlu bir '
        'pasaport için geride bıraktıkları.',
    backgroundNote:
        'Tarih bağlam: 14 Mayıs 1971\'de Diyarbakır\'da Sait Elçi, '
        'Sait Kırmızıtoprak ve diğerlerinin kayıp/öldürülmesi '
        'olayı bu günün kabul edilmesinde önemli rol oynamıştır. '
        'Günümüzde tüm Kürt diasporasında ve bölgede sembolik bir '
        'anma günü olarak kabul edilmektedir.',
    level: 4,
    unitId: 'celebration',
    keywords: ['şehîd', 'bîranîn', 'azadî', 'mîras', 'goristan'],
  ),

  // ── c_005: Mihrcan (Sonbahar Bayramı) ────────────────────
  CulturalItem(
    id: 'cel_005',
    type: CulturalContentType.celebration,
    kurmanjTitle: 'Mihrcan — Cejna Payîzê',
    turkishTitle: 'Mihrcan — Sonbahar Bayramı',
    kurmanjContent:
        'Mihrcan, cejna kevneşopî ya payîzê ye, ji salnameya '
        'kevin a Îranî. Di 2 Cotmehê de (16ê Mihrê li gor '
        'salnameya Şemsî) tê pîroz kirin.\n\n'
        'Bingeh:\n'
        'Peyva "Mihrcan" ji "Mîtra" tê — xwedayê ronî û rastiyê '
        'di olê Zerdeştî de. Ev roj nîşana berhevkirina dahatê '
        'û şikrîya berxwedariya zivistanê ye.\n\n'
        'Adetên kevneşopî:\n'
        '• Sofreya Mihrcan: hêjîr, gûz, sêv, hingiv, şîr.\n'
        '• Çepîk û dîlan li bin daran.\n'
        '• Hilmijandina sembola "Sîromîr" — yek ji heft maddeyên '
        '  pîroz: gelî mîr (taze çayır), şîr, hêk, pîvaz, sîr, '
        '  rûnê heywanan, av.\n'
        '• Mêvanperwerî: cîran û malbat hev tên ziyaret kirin.\n\n'
        'Çand îro: Cejn li herêmên kurd-îranî yên Rojhilatê '
        'Kurdistanê, bi taybetî Mehabad û Sine, hîn jî tê '
        'meşandin. Li herêmên Bakurî kêm e lê hê tê bîr.',
    turkishContent:
        'Mihrcan, eski İran takviminden gelen geleneksel '
        'sonbahar bayramıdır. 2 Ekim\'de (Şemsi takvimine göre '
        'Mihr ayının 16\'sında) kutlanır.\n\n'
        'Köken:\n'
        '"Mihrcan" sözcüğü "Mîtra"dan gelir — Zerdüşt dininde '
        'aydınlık ve doğruluğun tanrısı. Bu gün hasadın toplanması '
        've kışa hazırlığın şükür sembolüdür.\n\n'
        'Geleneksel adetler:\n'
        '• Mihrcan sofrası: incir, ceviz, elma, bal, süt.\n'
        '• Ağaçların altında alkış ve dans.\n'
        '• Yedi kutsal maddenin "Sîromîr" sembolü: taze çayır '
        '  (gelî mîr), süt, yumurta, soğan, sarımsak, hayvansal '
        '  yağ, su.\n'
        '• Misafirperverlik: komşular ve aile birbirini ziyaret '
        '  eder.\n\n'
        'Günümüz: Bayram, Doğu Kürdistan\'ın Kürt-İran '
        'bölgelerinde — özellikle Mahabad ve Sine\'de — hâlâ '
        'kutlanır. Kuzeyde nadiren ama hatırlanır.',
    backgroundNote:
        'Mihrcan, Newroz\'un kardeş bayramıdır: Newroz baharın, '
        'Mihrcan sonbaharın bayramıdır. İkisi de 12. yüzyıldan '
        'önce her Kürt bölgesinde kutlanırdı. İslam\'ın '
        'yayılmasıyla Mihrcan zayıfladı, Newroz korundu.',
    level: 3,
    unitId: 'celebration',
    keywords: ['Mihrcan', 'Mîtra', 'payîz', 'Zerdeşt', 'dahat'],
  ),

  // ── c_006: Cejna Qurbanê (Kürt Adetleri) ─────────────────
  CulturalItem(
    id: 'cel_006',
    type: CulturalContentType.celebration,
    kurmanjTitle: 'Cejna Qurbanê — Adetên Kurdî',
    turkishTitle: 'Kurban Bayramı — Kürt Adetleri',
    kurmanjContent:
        'Cejna Qurbanê, ji cejnên sereke yên îslamî ye, lê di '
        'çanda Kurdî de gelek adetên xwe yên taybet hene.\n\n'
        'Adetên rojên cejnê:\n'
        '• Sibehê zû: hemû malbat di cilên cejnê de kom dibin. '
        '  Pîr û zarok, mêr û jin, hemû derdikevin xebatê.\n'
        '• Goştê qurbanê li sê parçeyan tê dabeş kirin: '
        '  yek ji bo malbatê, yek ji bo cîranan, yek ji bo '
        '  belengazan û feqîran.\n'
        '• Mêvanperwerî: deriyên malan vekirî dimînin. Her kes '
        '  di her malê de mêvan e — heval, cîran û nas.\n'
        '• "Kurr û keç" — zarokên cîranan tên malê û şîranî tê '
        '  belavkirin: topîk, kade, baqlewa.\n'
        '• Govend: piştî firavînê, govenda cejnê li meydanê tê '
        '  meşandin.\n\n'
        'Taybetiyên Kurdî:\n'
        '• Stranên cejnê: "Cejna Pîroz", "Em ji bo cejnê hatin".\n'
        '• "Cejnemandin" — gava kal û pîr ji bo cejnê pere an '
        '  diyariyek didin zarokan.\n'
        '• "Bezma cejnê" — ziyareta goristanan, gora bav û '
        '  bapîran tê paqij kirin.',
    turkishContent:
        'Kurban Bayramı temel İslami bayramlardan biridir, '
        'ancak Kürt kültüründe kendine has birçok adet vardır.\n\n'
        'Bayram günleri adetleri:\n'
        '• Sabah erken: Tüm aile bayramlık kıyafetlerle toplanır. '
        '  Yaşlı-genç, kadın-erkek herkes hazırlığa başlar.\n'
        '• Kurban eti üç parçaya bölünür: biri aile için, biri '
        '  komşular için, biri yoksul ve fakirler için.\n'
        '• Misafirperverlik: ev kapıları açık tutulur. Herkes '
        '  her evde misafirdir — dost, komşu, tanıdık.\n'
        '• "Kurr û keç" — komşu çocuklar eve gelir, tatlılar '
        '  dağıtılır: topik, kade, baklava.\n'
        '• Halay: öğle yemeğinden sonra meydanda bayram halayı '
        '  oynanır.\n\n'
        'Kürt özellikleri:\n'
        '• Bayram türküleri: "Cejna Pîroz", "Em ji bo cejnê hatin".\n'
        '• "Cejnemandin" — yaşlılar bayramda çocuklara para veya '
        '  hediye verir.\n'
        '• "Bezma cejnê" — mezarlık ziyareti, dede-babaların '
        '  mezarları temizlenir.',
    backgroundNote:
        '"Bezma cejnê" (mezarlık ziyareti) Kürt kültürüne özgü '
        'bir gelenektir — ataya saygı ve kuşaklar arası bağ '
        'sembolüdür. Türk-Arap İslam pratiğinde bu kadar belirgin '
        'değildir. Halayın bayramda mutlaka oynanması da Kürt '
        'kimliğinin işaretlerinden.',
    level: 2,
    unitId: 'celebration',
    keywords: ['cejna qurbanê', 'qurban', 'mêvanperwerî', 'goristan', 'govend'],
  ),

  // ── c_007: Cejna Remezanê (Kürt iftarı) ──────────────────
  CulturalItem(
    id: 'cel_007',
    type: CulturalContentType.celebration,
    kurmanjTitle: 'Cejna Remezanê û Sofraya Îftarê',
    turkishTitle: 'Ramazan Bayramı ve İftar Sofrası',
    kurmanjContent:
        'Meha Remezanê û Cejna piştî wê, di çanda Kurdî de bi '
        'sofraya xwe ya taybet û rîtuela "îftarê" tê naskirin.\n\n'
        'Sofraya îftarê:\n'
        'Di sofraya îftara Kurdî de hin xwarin her tim hene:\n'
        '• Hêjîrên hişk an xurmê — ji bo destpêka îftarê.\n'
        '• Şorbeya nehniyê an awxa — sivik û saxlemî.\n'
        '• Nan û penîr.\n'
        '• Tom û kifte (di rojên taybet de).\n'
        '• Çay û şîranî — di dawiyê de.\n\n'
        'Adetên Kurdî:\n'
        '• "Telheyê îftarê" — pênc deqîqe beriya azanê, malbat '
        '  hev tê dor sofreyê. Ev kêlî ji bo dua û bîranînê ye.\n'
        '• "Mêvanê Remezanê" — gava mêvan tê di Remezanê de, '
        '  ne tenê wek mêvan e, lê wek "ezmûneka pîroz" tê '
        '  pejirandin.\n'
        '• Şevê 27\'an (Leyleyê Qedrê): malbat tev de hîn dimîne, '
        '  qehwe û şîranî tê pêşkêş kirin, bîranînên malbatî '
        '  tên parvekirin.\n\n'
        'Cejn:\n'
        'Sê rojên Cejna Remezanê:\n'
        '• Roja yekem: çapkirina cilên nû, ziyareta goristanê.\n'
        '• Roja duyem: ziyareta xizm û cîranan.\n'
        '• Roja sêyem: govend û şahî ya giştî.',
    turkishContent:
        'Ramazan ayı ve sonrasındaki Bayram, Kürt kültüründe '
        'kendine has sofrası ve "iftar" ritüeli ile bilinir.\n\n'
        'İftar sofrası:\n'
        'Kürt iftar sofrasında daima bulunan bazı yiyecekler:\n'
        '• Kuru incir veya hurma — iftarın başlangıcı için.\n'
        '• Nane çorbası veya awxa — hafif ve sağlıklı.\n'
        '• Ekmek ve peynir.\n'
        '• Dolma ve köfte (özel günlerde).\n'
        '• Çay ve tatlı — sona doğru.\n\n'
        'Kürt adetleri:\n'
        '• "Telheyê îftarê" — ezandan beş dakika önce, aile sofra '
        '  başında toplanır. Bu an dua ve anma içindir.\n'
        '• "Ramazan misafiri" — Ramazan\'da gelen misafir, sadece '
        '  misafir değil, "kutsal bir sınav" olarak kabul edilir.\n'
        '• 27. Gece (Kadir Gecesi): aile birlikte uyanık kalır, '
        '  kahve ve tatlı sunulur, aile anıları paylaşılır.\n\n'
        'Bayram:\n'
        'Ramazan Bayramı\'nın üç günü:\n'
        '• Birinci gün: yeni kıyafet giyme, mezarlık ziyareti.\n'
        '• İkinci gün: akraba ve komşu ziyareti.\n'
        '• Üçüncü gün: halay ve genel şenlik.',
    backgroundNote:
        '"Telheyê îftarê" (iftar öncesi dua anı) ve mezarlık '
        'ziyareti bayramın ilk günü — Kürt İslam pratiğinin '
        'ayırt edici unsurlarındandır. Sofraya nane çorbası '
        '(şorbeya nehniyê) konması Mezopotamya kökenlidir, '
        'binlerce yıllık geleneğin İslami ritüele eklemlenmesidir.',
    level: 2,
    unitId: 'celebration',
    keywords: ['Remezan', 'îftar', 'cejn', 'malbat', 'mêvanperwerî'],
  ),

  // ── c_008: Sersal — Mîlat ──────────────────────────────────
  CulturalItem(
    id: 'cel_008',
    type: CulturalContentType.celebration,
    kurmanjTitle: 'Sersal — Mîlata Sala Nû',
    turkishTitle: 'Sersal — Yeni Yıl (1 Ocak)',
    kurmanjContent:
        'Sersal, mîlata sala nû ye li gor salnameya Mîladî — di '
        '1ê Çileyê de tê pîroz kirin. Di Kurdistanê de ev cejnek '
        'nû ye, lê di nav diasporayê de gelek belav e.\n\n'
        'Adetên kurdî yên Sersalê:\n'
        '• Şevê 31ê Kanûnê: malbat li mal kom dibe.\n'
        '• Sofreya taybet: kifte, dolme, salate, baklawa.\n'
        '• Pêşkêşkirina diyarîyan ji zarokan re.\n'
        '• Diraxsana Sersalê: "Sala nû ji we re pîroz be!" '
        '  ("Yeni yılınız kutlu olsun!").\n'
        '• Telefonkirin bi xizmên ku dûr in.\n\n'
        'Diaspora:\n'
        'Ji bo Kurdên ku li Ewropa û Amerîkayê dijîn, Sersal '
        'firsetekî ye ji bo:\n'
        '• Bîranîna welêt û bîranîna kal û pîran.\n'
        '• Hevdîtina malbatî bi platforman dîjîtal.\n'
        '• Tomarkirina helbesta nû ya zimanê Kurdî.\n\n'
        'Cûdahî ji Newrozê: Sersal cejneke navneteweyî ye, '
        'Newroz cejneke neteweyî-Kurdî. Lê di salên dawî de, '
        'Kurdistan herdu jî dipejirîne — biçûk û mezin tev '
        'pîroz dikin.',
    turkishContent:
        'Sersal, Miladi takvime göre yeni yılın başlangıcıdır — '
        '1 Ocak\'ta kutlanır. Kürdistan\'da yeni bir bayram, ama '
        'diasporada oldukça yaygın.\n\n'
        'Kürt Sersal adetleri:\n'
        '• 31 Aralık gecesi: aile evde toplanır.\n'
        '• Özel sofra: köfte, dolma, salata, baklava.\n'
        '• Çocuklara hediye sunma.\n'
        '• Sersal kutlaması: "Sala nû ji we re pîroz be!" '
        '  (Yeni yılınız kutlu olsun!).\n'
        '• Uzaktaki akrabaları telefonla arama.\n\n'
        'Diaspora:\n'
        'Avrupa ve Amerika\'da yaşayan Kürtler için Sersal bir '
        'fırsattır:\n'
        '• Vatanın ve dedelerin anılması.\n'
        '• Dijital platformlarla aile buluşması.\n'
        '• Yeni Kürtçe şiir kaydetme.\n\n'
        'Newroz\'dan farkı: Sersal uluslararası bir bayramdır, '
        'Newroz Kürt-ulusal bir bayramdır. Ancak son yıllarda '
        'Kürdistan ikisini de kabul ediyor — çocuk ve büyük '
        'birlikte kutluyor.',
    backgroundNote:
        'Sersal\'in Kürt diasporasında yaygınlaşması 1980\'lerden '
        'itibarendir. Geleneksel olarak Kürt yıl başlangıcı '
        'Newroz (21 Mart) ve Mihrcan (2 Ekim)\'dur, ancak '
        'küreselleşmeyle birlikte 1 Ocak da bir aile buluşma '
        'günü haline gelmiştir.',
    level: 2,
    unitId: 'celebration',
    keywords: ['Sersal', 'sala nû', 'Çile', 'diaspora', 'Mîlat'],
  ),
];
