// ════════════════════════════════════════════════════════════════
// KURDISH FOODS DATABASE — XWARINÊN KURDÎ
//
// 15 xwarinên gelêrî yên kurdî: ji nan û xwê heta birîyaniya dawetê.
// Her xwarin: navê Kurmancî + navê Tirkî + amadekarî + çand û meraq.
//
// Standard: Bedirxan-Hawar (Latînî 1932). Diakritikên rast.
//
// Kaynak: Institut Kurde de Paris yayınları, Mehrdad Izady "Kurdish
// Cuisine" (2014), Yılmaz Mutlu Botan halk sofrası araştırmaları,
// Kurdipedia mutfak girişleri.
// ════════════════════════════════════════════════════════════════

import '../cultural_entities.dart';

const kKurdishFoods = <CulturalItem>[
  // ── f_001: Nan û xwê ──────────────────────────────────────
  CulturalItem(
    id: 'f_001',
    type: CulturalContentType.foodTradition,
    kurmanjTitle: 'Nan û xwê',
    turkishTitle: 'Ekmek ve tuz — paylaşım sembolü',
    kurmanjContent:
        'Nan û xwê, herî kevin nîşana mêvanperweriya kurdî ye. '
        'Gava mêvan tê malê, pêşî nan û xwê tê pêşkêş kirin — ev '
        'wateya peyman û ewlehiyê dide.\n\n'
        'Gotin: "Em nanê hev xwarine" tê wateya: em birayên hev in, '
        'em ji hev re xwedî derdikevin. Ji wê demê û pê ve, kes '
        'destê xwe nade aliyê wê malê.\n\n'
        'Cure: Nanê tenûrê, nanê sêlê, nanê savêj — her herêm xwedî '
        'cureyê xwe ye. Xwê li gor herêmê: xwêya çiyê (Sêmêl), '
        'xwêya behrê (Wan).',
    turkishContent:
        'Ekmek ve tuz, Kürt misafirperverliğinin en eski sembolüdür. '
        'Misafir eve gelince ilk önce ekmek ve tuz sunulur — bu, '
        'antlaşma ve güvenlik anlamına gelir.\n\n'
        'Söz: "Em nanê hev xwarine" (Birbirimizin ekmeğini yedik) '
        'cümlesi şu anlama gelir: biz kardeşiz, birbirimizi koruruz. '
        'O andan sonra kimse o eve kötülük yapamaz.\n\n'
        'Çeşitler: Tandır ekmeği, sac ekmeği, savêj ekmeği — her '
        'bölgenin kendine has türü vardır.',
    backgroundNote:
        'Nan û xwê geleneği Mezopotamya kökenlidir, 4000 yıl öncesine '
        'kadar gider. Aynı gelenek Asurî, Ermeni ve Süryani halklarında '
        'da görülür — bölgenin paylaşılan mirası.',
    level: 1,
    unitId: 'food',
    keywords: ['nan', 'xwê', 'mêvanperwerî', 'peyman', 'birayîtî'],
  ),

  // ── f_002: Tomê dewer (dolma) ─────────────────────────────
  CulturalItem(
    id: 'f_002',
    type: CulturalContentType.foodTradition,
    kurmanjTitle: 'Tomê dewer',
    turkishTitle: 'Yaprak dolması (Kürt usulü)',
    kurmanjContent:
        'Tomê dewer, xwarineke kevneşopî ye ji deşta Botan û Mêrdînê. '
        'Bi pelên rezê yên teze tê pêçandin; tê de savar, goştê hûr, '
        'pîvazê hûrkirî, tomate, sîr û baharat hene.\n\n'
        'Awayê amadekirinê:\n'
        '1. Pelên rezê yên paqij di ava germ de tên nermkirin.\n'
        '2. Savar, goştê hûr û pîvaz tên tevlihev kirin.\n'
        '3. Her pel bi tijîkirinê tê pêçandin.\n'
        '4. Bi sîr, lîmon û îsotê re di şewatê de tê pijandin.\n\n'
        'Çand: Di dawetan de jin bi hev re kar dikin — ev wek '
        '"karê hevkariyê" tê hesibîn û nîşana civakîbûna jinan e.',
    turkishContent:
        'Tomê dewer, Botan ve Mardin ovasının geleneksel yemeğidir. '
        'Taze asma yapraklarına bulgur, ince kıyma, soğan, domates, '
        'sarımsak ve baharat sarılır.\n\n'
        'Hazırlama:\n'
        '1. Temiz asma yaprakları sıcak suda yumuşatılır.\n'
        '2. Bulgur, ince kıyma ve soğan harmanlanır.\n'
        '3. Her yaprak içine harç konup sarılır.\n'
        '4. Sarımsak, limon ve acı biberle kısık ateşte pişirilir.\n\n'
        'Kültür: Düğünlerde kadınlar birlikte sarar — buna '
        '"yardımlaşma işi" denir; kadınların sosyalleşme sembolüdür.',
    backgroundNote:
        'Asma yaprağı yerine ekşi şalgam yaprağı (li herêmên çiyayî) '
        'veya kabak yaprağı da kullanılır. Süryani ve Ermeni mutfağı '
        'ile paylaşılan ortak miras.',
    level: 2,
    unitId: 'food',
    keywords: ['tom', 'dewer', 'savar', 'pelê rezê', 'dawet'],
  ),

  // ── f_003: Savar ──────────────────────────────────────────
  CulturalItem(
    id: 'f_003',
    type: CulturalContentType.foodTradition,
    kurmanjTitle: 'Savar',
    turkishTitle: 'Bulgur — temel besin',
    kurmanjContent:
        'Savar, ji genimê hilberî tê çêkirin: genim tê kelandin, '
        'tav tê dîtin (ziwa kirin) û tê hêran. Du celeb sereke hene:\n'
        '• Savara hûr — ji bo şorbê û pîlavê.\n'
        '• Savara stûr — ji bo tomê dewer û kifte.\n\n'
        'Çand: Savar wek "nanê duyemîn" tê hesibîn. Beriya zivistanê, '
        'jinên gund li ser banî savara malê amade dikirin — bi salan. '
        'Ev kar wek "kar û barê keçikan" dihat zanîn û pêdivîya '
        'malbatê ya yek-salî bû.\n\n'
        'Gotina pêşiyan: "Dema savar di goncalan de be, malbat dewlemend e."',
    turkishContent:
        'Savar (bulgur), kaynatılıp kurutulan ve öğütülen buğdaydan '
        'yapılır. İki ana çeşidi vardır:\n'
        '• İnce bulgur — çorba ve pilav için.\n'
        '• İri bulgur — dolma ve köfte için.\n\n'
        'Kültür: Bulgur "ikinci ekmek" sayılır. Kış öncesi köy '
        'kadınları damlarda yıllık ihtiyacı hazırlardı — buna '
        '"kız çocuklarının işi" denirdi ve evin bir yıllık temel '
        'ihtiyacıydı.\n\n'
        'Atasözü: "Bulgur ambarda olunca aile zengindir."',
    backgroundNote:
        'Bulgurun ortaya çıkışı Mezopotamya tarımıyla aynı dönemde — '
        '7000-8000 yıl öncesine gider. Buğday-bulgur dönüşümü besinin '
        'yıllarca saklanmasına olanak verdi, çiftçi medeniyetin temel '
        'gıda teknolojilerindendir.',
    level: 2,
    unitId: 'food',
    keywords: ['savar', 'genim', 'pîlav', 'malbat', 'hilberî'],
  ),

  // ── f_004: Kutilk (Kibbe) ─────────────────────────────────
  CulturalItem(
    id: 'f_004',
    type: CulturalContentType.foodTradition,
    kurmanjTitle: 'Kutilk',
    turkishTitle: 'İçli köfte (Kibbe)',
    kurmanjContent:
        'Kutilk, ji savara hûr û goştê hêrayî tê çêkirin. Hundirê '
        'wê bi goştê hûr, gûzê û pîvazê tê tijî kirin. Du awayên '
        'pijandinê: di rûnê germ de sorkirin, an di ava şorbê de '
        'kelandin.\n\n'
        'Cure:\n'
        '• Kutilka qelandî — ji bo cejn û dawetê.\n'
        '• Kutilka şîn — di nav şorbeya rûnê û lîmonê de.\n'
        '• Kutilka kebabê — bi qelî û pîvazê li ser sêlê.\n\n'
        'Çand: Kutilk xwarineke "fexrê ji bo mêvan" e — gava '
        'mêvanê girîng tê, kutilk tê pêşkêş kirin.',
    turkishContent:
        'Kutilk (içli köfte), ince bulgur ve döğme etten yapılır. '
        'İçi ince kıyma, ceviz ve soğanla doldurulur. İki pişirme '
        'yöntemi: kızgın yağda kızartma, ya da çorba suyunda haşlama.\n\n'
        'Çeşitler:\n'
        '• Kızarmış içli köfte — bayram ve düğün için.\n'
        '• Çorbalı içli köfte — yağ-limon çorbasının içinde.\n'
        '• Kebap içli köfte — kavurma ve soğanla saç üzerinde.\n\n'
        'Kültür: Kutilk "misafir gururlandıran" yemektir — önemli '
        'misafir gelince kutilk sunulur.',
    backgroundNote:
        'Cizre, Şirnak ve Mardin\'de en yaygın çeşittir. Süryani '
        'mutfağıyla "kibbe" adıyla paylaşılır — ancak Kürtçe varyantı '
        'genellikle daha az ekşilidir, ceviz öne çıkar.',
    level: 3,
    unitId: 'food',
    keywords: ['kutilk', 'savar', 'goşt', 'gûz', 'mêvanperwerî'],
  ),

  // ── f_005: Birîyanî ───────────────────────────────────────
  CulturalItem(
    id: 'f_005',
    type: CulturalContentType.foodTradition,
    kurmanjTitle: 'Birîyanî',
    turkishTitle: 'Biryani — düğün pirinçi',
    kurmanjContent:
        'Birîyanî, xwarina sereke ya dawetan li herêmên Hekarî, '
        'Şemzînan û Akrê. Ji birinc, goştê berxê, pîvaz, baharatên '
        'germ (zincebîl, kimîn, darçîn) û rûnê heywanan tê çêkirin.\n\n'
        'Awayê pijandinê:\n'
        '1. Goşt di rûnê germ de bi pîvazê re tê qelandin.\n'
        '2. Birinc bi şîlanê (zaferan) tê reng kirin.\n'
        '3. Du tehsî tên kom kirin: jêr birinc, jor goşt.\n'
        '4. Bi avê re di tendûrê de saetekê tê pijandin.\n\n'
        'Çand: Di dawetan de "tehsiya birîyanî" li navenda sofreyê '
        'tê danîn — wek nîşana mêvanperweriya malbatê.',
    turkishContent:
        'Biryani, Hakkari, Şemdinli ve Akre bölgelerinde düğünlerin '
        'baş yemeğidir. Pirinç, kuzu eti, soğan, sıcak baharatlar '
        '(zencefil, kimyon, tarçın) ve hayvansal yağdan yapılır.\n\n'
        'Pişirme:\n'
        '1. Et kızgın yağda soğanla kavrulur.\n'
        '2. Pirinç safranla renklendirilir.\n'
        '3. İki tabaka oluşturulur: alt pirinç, üst et.\n'
        '4. Suyla tandırda bir saat pişirilir.\n\n'
        'Kültür: Düğünlerde "biryani tepsisi" sofranın merkezine '
        'konur — ailenin misafirperverliğinin sembolüdür.',
    backgroundNote:
        'Biryaninin Hindistan kökenli olduğu sanılır ama Hekarî '
        'biryanisi yerel adaptasyondur: safran yerine yabani şilan, '
        'baharat oranı daha hafif. Düğün geleneği 17. yy\'a kadar '
        'gider.',
    level: 3,
    unitId: 'food',
    keywords: ['birîyanî', 'birinc', 'dawet', 'Hekarî', 'sofre'],
  ),

  // ── f_006: Harîse ─────────────────────────────────────────
  CulturalItem(
    id: 'f_006',
    type: CulturalContentType.foodTradition,
    kurmanjTitle: 'Harîse',
    turkishTitle: 'Harise — kış paylaşım yemeği',
    kurmanjContent:
        'Harîse, xwarineke zivistanê ye ji genim û goştê tevlihev. '
        'Heft-heşt saetan li ser êgir bi şewata sivik tê pijandin '
        'heta ku tev di nav avê de bibe yek.\n\n'
        'Maddey:\n'
        '• Genimê hilberî (savara stûr).\n'
        '• Goştê berxê an goştê dêwer (bizin).\n'
        '• Av, xwê, baharat (kimîn, darçîn).\n'
        '• Rûnê heywanan ji bo serê wê.\n\n'
        'Çand: Harîse "xwarina civakê" ye — gund-bi-gund tê pijandin '
        'û li mêvanan û cîranan tê parvekirin. Di rojên sar de, '
        'gava berf dibare, harîse her malê germ dike.',
    turkishContent:
        'Harise, kış aylarında buğday ve etin birlikte uzun süre '
        'pişirilmesiyle yapılan yemektir. Yedi-sekiz saat kısık '
        'ateşte hepsi suda eriyene kadar pişirilir.\n\n'
        'Malzemeler:\n'
        '• Hilberî buğday (iri bulgur).\n'
        '• Kuzu veya keçi eti.\n'
        '• Su, tuz, baharat (kimyon, tarçın).\n'
        '• Üzerine hayvansal yağ.\n\n'
        'Kültür: Harise "topluluk yemeğidir" — köy köy pişirilir, '
        'misafir ve komşulara dağıtılır. Kar yağan günlerde her '
        'evi ısıtır.',
    backgroundNote:
        'Harise Ermeni-Süryani-Kürt ortak yemeğidir. Çiya bölgelerinde '
        'kış solstisi geleneği olarak dağıtılır — yardımlaşma ve '
        'paylaşım sembolü.',
    level: 3,
    unitId: 'food',
    keywords: ['harîse', 'genim', 'goşt', 'zivistan', 'parvekirin'],
  ),

  // ── f_007: Awxa (yoğurt çorbası) ──────────────────────────
  CulturalItem(
    id: 'f_007',
    type: CulturalContentType.foodTradition,
    kurmanjTitle: 'Awxa',
    turkishTitle: 'Awxa — yoğurt çorbası',
    kurmanjContent:
        'Awxa, şorbeya kevneşopî ye ji mast, savar û nehniyê. '
        'Bi taybetî ji bo nexweşan û kesên ku ji ber zikan diêşin '
        'tê amade kirin — sivik û saxlemiya zik e.\n\n'
        'Maddey:\n'
        '• Mastê kelandî (bi rûnê heywan).\n'
        '• Savara hûr.\n'
        '• Nehniyê ziwa.\n'
        '• Sîr û îsotê germ.\n\n'
        'Awa: Mast hêdî hêdî tê hejandin da ku nepişke. Savar tê '
        'avêtin, paşê nehniyê ziwa û li dawiyê sîrê di rûnê de '
        'sorkirî tê li ser dirêjandin.\n\n'
        'Çand: "Awxa ji bo dilê dilovîn" — wek dîyariyek ji '
        'cîranên nexweş re tê şandin.',
    turkishContent:
        'Awxa, yoğurt, bulgur ve nane ile yapılan geleneksel '
        'çorbadır. Özellikle hastalar ve mide rahatsızlıkları için '
        'hazırlanır — hafif ve mide dostudur.\n\n'
        'Malzemeler:\n'
        '• Pişirilmiş yoğurt (hayvansal yağda).\n'
        '• İnce bulgur.\n'
        '• Kuru nane.\n'
        '• Sarımsak ve acı biber.\n\n'
        'Yapılışı: Yoğurt yavaşça çırpılarak kesmemesi sağlanır. '
        'Bulgur eklenir, ardından kuru nane, en üste yağda kavrulmuş '
        'sarımsak gezdirilir.\n\n'
        'Kültür: "Şefkatli kalp için awxa" — hasta komşulara '
        'hediye olarak gönderilir.',
    backgroundNote:
        'Yoğurt çorbası tüm Doğu Akdeniz ve Mezopotamya halklarında '
        'ortaktır. Kürt awxasının ayırt edici özelliği bulgurun ince '
        'olmasıdır — kentsel "yayla çorbası"ndan farkı budur.',
    level: 2,
    unitId: 'food',
    keywords: ['awxa', 'mast', 'şorbe', 'nexweş', 'cîran'],
  ),

  // ── f_008: Çayê dêlokê ────────────────────────────────────
  CulturalItem(
    id: 'f_008',
    type: CulturalContentType.foodTradition,
    kurmanjTitle: 'Çayê dêlokê',
    turkishTitle: 'Köy çayı geleneği',
    kurmanjContent:
        'Çayê dêlokê (an: çayê gundî), nîşana mêvanperweriya '
        'kurdî ya rojane ye. Çay di kapika sor a hesin de tê amade '
        'kirin: ava kelandî, çaya reş, û şekirê paqij.\n\n'
        'Awayê pêşkêşkirinê:\n'
        '• Îstîkana zer a piçûk — ji bo mêvan.\n'
        '• Şekir li tenişt, ne di hundir de — her kes li gor xwe '
        'şekir bavêje.\n'
        '• Çay tu carî nayê pêşkêşkirin tenê — her dem bi qehwê an '
        'şîranî re.\n\n'
        'Çand: "Çay venekîye" — eger mêvan çayê venexwe, ev '
        'wateya nelihevkirinê dide. Mêvanperwerî dixwaze ku herî '
        'kêm sê îstîkan bên vexwarin: yek ji bo silavê, yek ji bo '
        'sohbetê, yek ji bo xatirê.',
    turkishContent:
        'Köy çayı (çayê gundî), günlük Kürt misafirperverliğinin '
        'sembolüdür. Çay demir kırmızı çaydanlıkta hazırlanır: '
        'kaynamış su, siyah çay ve kesme şeker.\n\n'
        'Sunum:\n'
        '• Küçük altın bardak — misafir için.\n'
        '• Şeker yanında, içinde değil — herkes kendine göre atar.\n'
        '• Çay asla yalnız sunulmaz — kahve veya tatlıyla birlikte.\n\n'
        'Kültür: "Çayı içmemek" anlaşmazlık anlamına gelir. '
        'Misafirperverlik en az üç bardağı gerektirir: biri selam '
        'için, biri sohbet için, biri vedalaşma için.',
    backgroundNote:
        'Demlikli çay geleneği 19. yy sonlarında Çarlık Rusya\'sı '
        'üzerinden Kürt bölgesine girdi. Öncesinde "qehwa Erebî" '
        '(Arap kahvesi) ve "şîr-bira" (sütlü buğday) yaygındı.',
    level: 1,
    unitId: 'food',
    keywords: ['çay', 'gundî', 'mêvanperwerî', 'îstîkan', 'silav'],
  ),

  // ── f_009: Kade ───────────────────────────────────────────
  CulturalItem(
    id: 'f_009',
    type: CulturalContentType.foodTradition,
    kurmanjTitle: 'Kade',
    turkishTitle: 'Kade — yolcu ekmeği',
    kurmanjContent:
        'Kade, nanê yêkpar yê ziwakirî ye, ji ardê genim û nikê '
        'piçûk ê xwêyî. Ji bo rêwîtiyên dirêj û şivanên çiyê '
        'amade dibe — meh û salan jî nayê xirakirin.\n\n'
        'Awayê amadekirinê:\n'
        '1. Hevîr ji ard, av û xwê tê çêkirin (bê hevîr-îxlas).\n'
        '2. Bi destê tê yek-li-yek belav kirin, gelek tenik.\n'
        '3. Li ser sêlê an di tendûrê de tê pijandin heta ku qarçik '
        '   bibe.\n'
        '4. Tê hejmartin û di torbeyên kanê de tê parastin.\n\n'
        'Çand: Şivanên çiyê meh-mehan bi kadê dijîn. "Kadeyê dilê '
        'min" wek nîşana mertaliya kar û barê çiyê tê hesibîn.',
    turkishContent:
        'Kade, mayasız kuru ekmektir; tam buğday ununa az tuz '
        'eklenerek yapılır. Uzun yolculuklar ve dağ çobanları için '
        'hazırlanır — aylar hatta yıllar bozulmadan kalır.\n\n'
        'Hazırlama:\n'
        '1. Hamur un, su ve tuzdan (mayasız) yoğurulur.\n'
        '2. Elle ince ince açılır, çok ince.\n'
        '3. Saç üzerinde veya tandırda gevrekleşene kadar pişirilir.\n'
        '4. Sayılır ve keten torbalarda saklanır.\n\n'
        'Kültür: Dağ çobanları aylarca kadeyle yaşar. "Kalbimin '
        'kadesi" deyimi dağ emeğinin sembolüdür.',
    backgroundNote:
        'Kadenin ortaya çıkışı transhumance (yaylacılık) kültürüyle '
        'ilgilidir. Aynı geleneği Anadolu Yörükleri "yufka", İran '
        'göçebeleri "lavaş" adıyla yaşatır — Kürt kadesinin farkı '
        'tuz oranı ve saç pişirme süresidir.',
    level: 2,
    unitId: 'food',
    keywords: ['kade', 'şivan', 'çiya', 'rêwîtî', 'parastin'],
  ),

  // ── f_010: Hingiv ─────────────────────────────────────────
  CulturalItem(
    id: 'f_010',
    type: CulturalContentType.foodTradition,
    kurmanjTitle: 'Hingiv',
    turkishTitle: 'Bal — doğum ve misafir geleneği',
    kurmanjContent:
        'Hingivê çiyayê Hekarî û Kotur navdar e li seranserê '
        'rojhilatê. Ji kulîlkên çiyê yên xwezayî tê — meşên kovî '
        'di şikeftan de hingiv çêdikin, ji bo xwedaniya hingiv '
        'kêf û metane pêwîst e.\n\n'
        'Bikaranîna çandî:\n'
        '• Doğum: Pîrê dergûş bi hingiv tê pîrozkirin — yekem '
        '  tama dergûşê hingiv e ("ji bo dilxweşiya jiyanê").\n'
        '• Mêvan: "Mêvan, hingivê pîrozê ji ber tê" — hingiv tê '
        '  pêşkêş kirin.\n'
        '• Derman: Hingiv bi zincefirê re ji bo qixîn û kêmasiya '
        '  enerjiyê.\n\n'
        'Cure:\n'
        '• Hingivê çiyê — ji kulîlkên xwezayî, tama wê tûj û fireh.\n'
        '• Hingivê çolê — ji kulîlkên çolê, tama wê şîrîn.\n'
        '• Hingivê darçînê — ji bedema darçînê, ji bo derman.',
    turkishContent:
        'Hakkari ve Kotur dağlarının balı tüm doğuda meşhurdur. '
        'Yabani arılar mağaralarda bal yapar — bala sahip olmak '
        'için cesaret ve sabır gerekir.\n\n'
        'Kültürel kullanım:\n'
        '• Doğum: Bebek balla kutsanır — bebeğin ilk tadı bal olur '
        '  ("hayatın tatlı olması için").\n'
        '• Misafir: "Misafir, kutsal balın geliş sebebidir" — bal '
        '  ikram edilir.\n'
        '• İlaç: Bal ve zencefil öksürük ve enerji düşüklüğü için.\n\n'
        'Çeşitler:\n'
        '• Dağ balı — yabani çiçeklerden, sert ve geniş tatlı.\n'
        '• Çöl balı — bozkır çiçeklerinden, hafif tatlı.\n'
        '• Tarçın balı — şifa için.',
    backgroundNote:
        'Hakkari balcılığı 3000 yıllık bir gelenektir. Geleneksel '
        '"şikefta hingiv" (bal mağarası) yöntemi UNESCO Somut Olmayan '
        'Kültürel Miras adayı listesindedir.',
    level: 2,
    unitId: 'food',
    keywords: ['hingiv', 'meş', 'Hekarî', 'dergûş', 'mêvan'],
  ),

  // ── f_011: Dengo ──────────────────────────────────────────
  CulturalItem(
    id: 'f_011',
    type: CulturalContentType.foodTradition,
    kurmanjTitle: 'Dengo',
    turkishTitle: 'Dengo — yaz serinleticisi',
    kurmanjContent:
        'Dengo, vexwarineke kevneşopî ye ji mast û savara hûr a '
        'kelandî. Bi taybetî di havîna germ de tê amade kirin — '
        'serîn û têrxwarin e.\n\n'
        'Maddey:\n'
        '• Mast (girjker, ne çêkerê).\n'
        '• Savara hûr a kelandî.\n'
        '• Av (sard).\n'
        '• Xwê û nehniyê germ.\n\n'
        'Awayê amadekirinê:\n'
        '1. Savar di avê de tê kelandin heta ku nerm bibe.\n'
        '2. Mast bi avê re tê tevlihev kirin.\n'
        '3. Savara nerm tê tevlihev kirin.\n'
        '4. Bi nehniyê û xwê tê pêşkêş kirin.\n\n'
        'Çand: Dengo "vexwarina karkeran" e — di mehên Tîr-Gulanê de, '
        'gava karkerên gund li bin tava germ kar dikin, dengo wek '
        'enerjî û av tê pêşkêş kirin.',
    turkishContent:
        'Dengo, yoğurt ve haşlanmış ince bulgurdan yapılan geleneksel '
        'içecektir. Özellikle sıcak yazda hazırlanır — serinletir ve '
        'doyurur.\n\n'
        'Malzemeler:\n'
        '• Yoğurt (kesmiş, taze değil).\n'
        '• Haşlanmış ince bulgur.\n'
        '• Soğuk su.\n'
        '• Tuz ve sıcak nane.\n\n'
        'Hazırlama:\n'
        '1. Bulgur suda yumuşayana kadar haşlanır.\n'
        '2. Yoğurt suyla çırpılır.\n'
        '3. Yumuşamış bulgur eklenir.\n'
        '4. Nane ve tuzla sunulur.\n\n'
        'Kültür: Dengo "işçi içeceği"dir — Haziran-Ağustos\'ta köy '
        'işçileri sıcak güneş altında çalışırken dengo enerji ve '
        'su olarak ikram edilir.',
    backgroundNote:
        'Dengo türevleri tüm Mezopotamya\'da görülür: Türklerde '
        '"ayran çorbası", Asurîlerde "abush", Araplarda "shanina". '
        'Kürt dengosunun farkı bulgur eklenmesidir.',
    level: 2,
    unitId: 'food',
    keywords: ['dengo', 'mast', 'savar', 'havîn', 'karker'],
  ),

  // ── f_012: Pelûda ─────────────────────────────────────────
  CulturalItem(
    id: 'f_012',
    type: CulturalContentType.foodTradition,
    kurmanjTitle: 'Pelûda',
    turkishTitle: 'Pelûda — Diyarbakır yaz tatlısı',
    kurmanjContent:
        'Pelûda, şîraniyek havînê ye ji Amedê (Diyarbekirê). '
        'Ji ardê genim, ava şekir û şîranî tê çêkirin. Sar tê '
        'pêşkêş kirin — bi qeşê re.\n\n'
        'Maddey:\n'
        '• Ardê hilberî (genim).\n'
        '• Av û şekirê paqij.\n'
        '• Tama gulavê an dengê lîmonê.\n'
        '• Qeş û fistiqê hêrayî ji bo ser.\n\n'
        'Awayê amadekirinê:\n'
        '1. Ard û av tên kelandin heta ku qewat bibe.\n'
        '2. Şekir tê avêtin, hêdî tê tevlihev kirin.\n'
        '3. Tama gulavê tê dirêjkirin.\n'
        '4. Di tasên zer de tê parvekirin, paşê di sarinê de '
        '   bi qeş tê pêşkêş kirin.\n\n'
        'Çand: Pelûdaya Amedê li bazaran tê firotin — di mehên '
        'Tîr û Gulanê de, gava roj germtir dibe.',
    turkishContent:
        'Pelûda, Diyarbakır\'ın yaz tatlısıdır. Buğday unu, şekerli '
        'su ve esanstan yapılır. Buzlu olarak sunulur.\n\n'
        'Malzemeler:\n'
        '• Hilberî (buğday) unu.\n'
        '• Su ve kesme şeker.\n'
        '• Gül suyu veya limon kabuğu.\n'
        '• Üzerine buz ve dövülmüş antep fıstığı.\n\n'
        'Hazırlama:\n'
        '1. Un ve su koyulaşıncaya kadar kaynatılır.\n'
        '2. Şeker eklenir, yavaşça karıştırılır.\n'
        '3. Gül suyu damlatılır.\n'
        '4. Altın bardaklarda dağıtılır, soğukta buzla sunulur.\n\n'
        'Kültür: Diyarbakır pelûdasi çarşılarda satılır — Haziran '
        've Mayıs aylarında, güneş kızdığında.',
    backgroundNote:
        'Pelûda Eyyûbî dönemine kadar uzanır (12. yy). Diyarbakır '
        'surları içinde 800 yıllık bir tatlı geleneğidir. Kürt-Arap '
        '-Türk mutfaklarının buluşma noktasıdır.',
    level: 2,
    unitId: 'food',
    keywords: ['pelûda', 'Amed', 'şîranî', 'havîn', 'gulav'],
  ),

  // ── f_013: Şîlanê ─────────────────────────────────────────
  CulturalItem(
    id: 'f_013',
    type: CulturalContentType.foodTradition,
    kurmanjTitle: 'Şîlanê',
    turkishTitle: 'Yabani gül reçeli',
    kurmanjContent:
        'Şîlanê, fêkiya gulê kovî ye ku di payîzê de tê berhev kirin. '
        'Reçela wê li herêmên Erzeromê û Botanê navdar e — sembola '
        'jiyana çiyê û aqilê dayîkan e.\n\n'
        'Awayê amadekirinê:\n'
        '1. Şîlanê di Cotmehê de tê berhev kirin (piştî sermayê).\n'
        '2. Tovê wê tê derxistin (kar zehmet).\n'
        '3. Bi şekir û lîmonê re saetan tê pijandin.\n'
        '4. Di şûşeyên paqij de tê parastin, sal-bi-sal.\n\n'
        'Bikaranîn:\n'
        '• Wek şîranî bi nan re — taştêya zarokan.\n'
        '• Wek derman ji bo qixîn û saxlemiya rû — vîtamîn C zêde ye.\n'
        '• Di çay û şorbeyê de — tama tirş.\n\n'
        'Çand: "Reçela şîlanê" — gava dayîk reçela xwe ya kêfxweş '
        'pêşkêş dike, "ev şahidê havîna xweş e" tê gotin.',
    turkishContent:
        'Şîlanê, sonbaharda toplanan yabani gülün meyvesidir. '
        'Reçeli Erzurum ve Botan bölgelerinde meşhurdur — dağ '
        'yaşamının ve anne aklının sembolüdür.\n\n'
        'Hazırlama:\n'
        '1. Şîlanê Ekim\'de toplanır (soğuktan sonra).\n'
        '2. Çekirdekleri çıkarılır (zor iş).\n'
        '3. Şeker ve limonla saatlerce pişirilir.\n'
        '4. Temiz cam kavanozlarda yıllarca saklanır.\n\n'
        'Kullanım:\n'
        '• Tatlı olarak ekmekle — çocuk kahvaltısı.\n'
        '• Öksürük ve cilt sağlığı için ilaç — C vitamini bol.\n'
        '• Çay ve çorbada — ekşi tat.\n\n'
        'Kültür: "Şîlanê reçeli" — anne özene bezene yaptığı reçelini '
        'sunduğunda "bu güzel yazın tanığıdır" denir.',
    backgroundNote:
        'Yabani gül (Rosa canina) dağ ekosisteminin temel bitkilerinden '
        'biridir. Toplanma ve işleme bilgisi sözel kültürle nesilden '
        'nesile aktarılır — özellikle anne-kız bağı.',
    level: 2,
    unitId: 'food',
    keywords: ['şîlanê', 'reçel', 'gulê kovî', 'dayîk', 'derman'],
  ),

  // ── f_014: Topîk ──────────────────────────────────────────
  CulturalItem(
    id: 'f_014',
    type: CulturalContentType.foodTradition,
    kurmanjTitle: 'Topîk',
    turkishTitle: 'Topik — bayram tatlısı',
    kurmanjContent:
        'Topîk, şîraniya cejnê ye ji nikê û qalê tirikê. Li herêmên '
        'Mêrdîn, Cizîr û Şirnex tê amade kirin — bi taybetî di '
        'Cejna Remezanê û Cejna Qurbanê de.\n\n'
        'Maddey:\n'
        '• Nikê (qalê tirikê).\n'
        '• Şekir, darçîn, gûz û kişmîş.\n'
        '• Ardê genim û rûnê heywanan.\n'
        '• Hingiv ji bo ser.\n\n'
        'Awayê amadekirinê:\n'
        '1. Nikê di avê de tê kelandin heta ku nerm bibe.\n'
        '2. Bi şeker, darçîn û gûzê re tê tevlihev kirin.\n'
        '3. Wek gulokên piçûk tê dorpêçandin (tope).\n'
        '4. Di rûn de tê sorkirin an di firnê de tê pijandin.\n\n'
        'Çand: Di sibehên cejnê de, topîk bi qehwê re ji mêvanan re '
        'tê pêşkêş kirin. Her gulokek "doza dilxweşiyê" ye.',
    turkishContent:
        'Topîk, nohuttan ve nohut kabuğundan yapılan bayram tatlısıdır. '
        'Mardin, Cizre ve Şirnak\'ta hazırlanır — özellikle Ramazan ve '
        'Kurban Bayramı\'nda.\n\n'
        'Malzemeler:\n'
        '• Nohut (kabuk).\n'
        '• Şeker, tarçın, ceviz ve kuru üzüm.\n'
        '• Buğday unu ve hayvansal yağ.\n'
        '• Üzerine bal.\n\n'
        'Hazırlama:\n'
        '1. Nohut suda yumuşayana kadar haşlanır.\n'
        '2. Şeker, tarçın ve cevizle harmanlanır.\n'
        '3. Küçük toplar şeklinde yuvarlanır.\n'
        '4. Yağda kızartılır veya fırında pişirilir.\n\n'
        'Kültür: Bayram sabahları topîk kahveyle birlikte misafirlere '
        'sunulur. Her top "mutluluk dileğidir".',
    backgroundNote:
        'Topîk Ermenice "topig"ten alınmıştır ama Kürt-Süryani '
        'mutfağında özgün bir varyant gelişmiştir. Mardin\'de bayram '
        'kahvaltısının vazgeçilmezidir.',
    level: 2,
    unitId: 'food',
    keywords: ['topîk', 'cejn', 'nikê', 'Mêrdîn', 'şîranî'],
  ),

  // ── f_015: Mîr-zengî ──────────────────────────────────────
  CulturalItem(
    id: 'f_015',
    type: CulturalContentType.foodTradition,
    kurmanjTitle: 'Mîr-zengî',
    turkishTitle: 'Kuru fasulye yemeği',
    kurmanjContent:
        'Mîr-zengî, xwarineke gelêrî ye ji deşta Botan. Ji '
        'fasûlyeya hilberî (mîr-zengî), pîvaz, tomate û goştê '
        'hûr tê amade kirin. Sembola sofraya zivistanê ya malbatê '
        'ye.\n\n'
        'Awayê amadekirinê:\n'
        '1. Fasûlye di şevê de tê hîlandin (12 saet).\n'
        '2. Pîvaz û tomate di rûnê germ de tên qelandin.\n'
        '3. Goştê hûr tê avêtin, paşê fasûlye.\n'
        '4. Bi avê re du saetan tê pijandin.\n'
        '5. Bi savara hûr an birinc tê pêşkêş kirin.\n\n'
        'Çand: Di mehên zivistanê — Çile, Sibat, Adar — mîr-zengî '
        'her hefte di sofraya gund de heye. Ji ber ku fasûlye '
        'parastinaê ya dirêj heye, "xezîneya zivistanê" tê hesibîn.',
    turkishContent:
        'Mîr-zengî, Botan ovasının halk yemeğidir. Hilberî (kuru) '
        'fasulye, soğan, domates ve ince kıymadan yapılır. Aile '
        'kış sofrasının sembolüdür.\n\n'
        'Hazırlama:\n'
        '1. Fasulye gece boyu ıslatılır (12 saat).\n'
        '2. Soğan ve domates kızgın yağda kavrulur.\n'
        '3. İnce kıyma eklenir, sonra fasulye.\n'
        '4. Suyla iki saat pişirilir.\n'
        '5. İnce bulgur veya pirinçle sunulur.\n\n'
        'Kültür: Kış aylarında — Ocak, Şubat, Mart — mîr-zengî her '
        'hafta köy sofrasında olur. Fasulye uzun süre saklandığı '
        'için "kışın hazinesi" sayılır.',
    backgroundNote:
        'Fasulyenin Kürt mutfağına girişi 17. yy\'da Yeni Dünya\'dan '
        'Anadolu üzerinden olur. Mîr-zengî, bulgur ve fasulye '
        'kombinasyonuyla protein bakımından zengin, "fakir aile '
        'yemeği" olarak da bilinir.',
    level: 2,
    unitId: 'food',
    keywords: ['mîr-zengî', 'fasûlye', 'zivistan', 'Botan', 'malbat'],
  ),
];
