// ════════════════════════════════════════════════════════════════
// KURDISH LEGENDS & EPICS DATABASE — DESTAN Û EFSANEYÊN KURDAN
//
// 12 destan û efsane ji çanda gelê Kurd: ji Gilgameş heta Mem û Zîn.
// Her giriş: Kurmancî vegêran + Türkçe özet + kültürel arka plan.
//
// Kaynaklar: Institut Kurde de Paris, Firdevsî (Şahname), Ehmedê Xanî
// (Mem û Zîn 1695), Ordîxanê Celîl dengbêj arşivleri, Kurdipedia,
// Celîl Celîl & Kurdish Heritage Institute yayınları.
// ════════════════════════════════════════════════════════════════

import '../cultural_entities.dart';

const kKurdishLegends = <CulturalItem>[
  // ── l_001: Gilgameş — Destana herî kevn ───────────────────
  CulturalItem(
    id: 'l_001',
    type: CulturalContentType.story,
    kurmanjTitle: 'Destana Gilgameş',
    turkishTitle: 'Gilgameş Destanı',
    kurmanjContent:
        'Gilgameş, destana herî kevn a mirovatiyê ye; nêzîkî 4000 sal '
        'berî niha li Mezopotamyayê li ser tabletên xwendekaran hatiye '
        'nivîsandin. Gilgameş, serokê bajarê Urûk bû, nîvî xwedê û '
        'nîvî mirov.\n\n'
        'Çîrok: Enkîdû, hevalê wî yê berze, dimire. Gilgameş li dû '
        'bêmiriniyê digere, rêwîtiyeke dirêj dike û di dawiyê de fêm '
        'dike ku bêmirinî ne ji bo mirovan e — lê navdarî û berhem '
        'dikarin bimînin.\n\n'
        'Girîngiya wê ji bo Kurdan: Destan li ser axa niha jî ya '
        'Kurdistanê (Mezopotamya) hatiye çêkirin. Gelek motîf — '
        'lehiya mezin, hevaltiya nemir, gerîn bi çiyan de — di çanda '
        'Kurd de dewam dikin.',
    turkishContent:
        'Gilgameş, insanlığın en eski destanıdır; yaklaşık 4000 yıl '
        'önce Mezopotamya\'da öğrenci tabletlerine yazıldı. Gilgameş, '
        'Uruk kentinin kralı, yarı tanrı yarı insandı.\n\n'
        'Hikâye: En yakın dostu Enkidu ölünce Gilgameş ölümsüzlüğü '
        'aramaya çıkar. Uzun bir yolculuktan sonra anlar ki '
        'ölümsüzlük insanlar için değil — ama şöhret ve eserler '
        'kalıcı olabilir.\n\n'
        'Kürtler için önemi: Destan bugün de Kürdistan toprağı olan '
        'Mezopotamya\'da doğdu. Büyük tufan, ölümsüz dostluk, '
        'dağlarda arayış gibi motifler Kürt kültüründe yaşamaya '
        'devam ediyor.',
    backgroundNote:
        'Sümerce ve Akadca yazılmış olan Gilgameş tabletleri '
        '19. yy\'da Ninova\'da bulundu. Destan, Tevrat\'taki Nuh\'un '
        'Tufanı anlatısıyla ortak kökler paylaşır.',
    level: 3,
    unitId: 'dest_efs',
    keywords: ['Gilgameş', 'Urûk', 'Enkîdû', 'Mezopotamya', 'destan'],
  ),

  // ── l_002: Şahmaran — Şaheke marên ────────────────────────
  CulturalItem(
    id: 'l_002',
    type: CulturalContentType.story,
    kurmanjTitle: 'Şahmaran',
    turkishTitle: 'Şahmaran',
    kurmanjContent:
        'Şahmaran, şahbanûya marên bi aqil e: serê wê serê jinekê '
        'ye, beden û dûvê wê yê mar. Di efsaneyan de, di şikeftekê de '
        'dijîya û xwedîya zanîna derman bû.\n\n'
        'Çîrok: Camasp (Tehmasib) bi rêyeke xeletî ket şikefta '
        'Şahmaran. Salan li cem wê ma, zanîna giyayan û dermanan hîn '
        'bû. Dema ku vegeriya cîhanê, soza xwe ya ku Şahmaranê nede '
        'dest mîrê zalim naşkîne — lê dawiyê de bi zorê vedibêje. '
        'Şahmaran tê kuştin, lê xwîna wê dibe derman.\n\n'
        'Sembolîka: Şahmaran nîşana aqil, veşartin û wefadariyê ye. '
        'Di malên Mêrdîn, Wan û Bazîdê de wêneyê Şahmaranê li hember '
        'nezakî tê daleqandin.',
    turkishContent:
        'Şahmaran, akıllı yılanların kraliçesidir: kadın başlı, '
        'gövdesi ve kuyruğu yılan. Efsanelerde bir mağarada yaşar '
        've bitki ile ilaç bilgisine sahiptir.\n\n'
        'Hikâye: Camasp (Tehmasib) yanlışlıkla Şahmaran\'ın '
        'mağarasına düşer. Yıllarca yanında kalır, bitkilerin ve '
        'ilaçların sırrını öğrenir. Dünyaya döndüğünde Şahmaran\'ı '
        'zalim hükümdara ele vermeme sözünü bozmamak için direnir — '
        'ama sonunda zorla söyletilir. Şahmaran öldürülür, ancak '
        'kanı şifa olur.\n\n'
        'Sembol: Şahmaran akıl, sır ve sadakatin simgesidir. '
        'Mardin, Van ve Doğubeyazıt evlerinde Şahmaran resimleri '
        'nazara karşı asılır.',
    backgroundNote:
        'Şahmaran efsanesi Kürt, Ermeni, Süryani ve Anadolu '
        'topluluklarının ortak mirasıdır. Mardin\'de Şahmaran cam '
        'altı resimleri bir el sanatı geleneği haline gelmiştir.',
    level: 2,
    unitId: 'dest_efs',
    keywords: ['Şahmaran', 'mar', 'derman', 'Mêrdîn', 'efsane'],
  ),

  // ── l_003: Ristemê Zal — leheng ji Zagros ─────────────────
  CulturalItem(
    id: 'l_003',
    type: CulturalContentType.story,
    kurmanjTitle: 'Ristemê Zal',
    turkishTitle: 'Rüstem-i Zal',
    kurmanjContent:
        'Ristem (Rüstem), kurê Zalê porspî ye. Zal dema ji dayik bû '
        'bi porên spî hat dinyayê û bavê wî ew li çiyayê Elbûrzê '
        'derxist. Sîmira efsaneyî Zal mezin kir.\n\n'
        'Rûstem gihîşte lehengekî pir xurt: bi hespê xwe Rexşê, bi '
        'debançeya xwe, dijberên cinîkî û peyan ji hev re rakir. '
        'Heft karên Ristem (Heft Xwanî) di Şahnameya Firdewsî de '
        'hatine nivîsandin.\n\n'
        'Trajediya wî: Bi zanebûnî kurê xwe Sohrab kuşt, lê hey '
        'gava bavîtiya xwe fêm kir, heyamek dereng bû.',
    turkishContent:
        'Rüstem, Zal-ı Zer\'in (ak saçlı Zal) oğludur. Zal beyaz '
        'saçlarla doğunca babası onu Elburz Dağı\'na bıraktı. '
        'Efsanevi kuş Simurg onu büyüttü.\n\n'
        'Rüstem büyük bir kahramana dönüştü: atı Rahş ile, '
        'gürzüyle devlere ve insan düşmanlara karşı savaştı. '
        'Rüstem\'in Yedi İşi (Heft Hân), Firdevsî\'nin '
        'Şehnamesi\'nde anlatılır.\n\n'
        'Trajedisi: Farkında olmadan kendi oğlu Sohrab\'ı öldürdü, '
        'baba olduğunu anladığında geç kalmıştı.',
    backgroundNote:
        'Rüstem, Fars destanı olmakla birlikte Kürt halk kültüründe '
        'derin yer tutar. Zagros Dağları\'ndan yükselen kahraman '
        'figürü olarak görülür; dengbêjler destanı Kurmancî olarak '
        'da icra ederler. Kurdish bölgesindeki "Zal", "Rustem" '
        'isimleri bu mirastan gelir.',
    level: 3,
    unitId: 'dest_efs',
    keywords: ['Rüstem', 'Zal', 'Sîmir', 'Şahname', 'Zagros'],
  ),

  // ── l_004: Kawayê Hesinkar — Destana Newrozê ──────────────
  CulturalItem(
    id: 'l_004',
    type: CulturalContentType.story,
    kurmanjTitle: 'Kawayê Hesinkar',
    turkishTitle: 'Demirci Kawa',
    kurmanjContent:
        'Kawa, hesinkarekî ji gelê Kurd bû. Li serdema Dehakê zalim, '
        'ji milên Dehakê du mar derketibûn; her roj divabûn mejiyê '
        'du xortan bixwin. Gelê Kurd hemû dihat qirkirin.\n\n'
        'Dema ku dora kurê Kawa hat, Kawa li hember zilmê rabû. Bi '
        'hesinkariya xwe, ciwanan xapand û reviand, di berê wan de '
        'li ser çiyan şopa şerê xwe vekir. Ji pişta wî bîst û yek '
        'xort û ciwanên din gihîştin; Dehak hat kuştin û gel rizgar '
        'bû.\n\n'
        'Di 21ê Adarê de, agirên Newrozê li ser çiyan hatin vêxistin '
        '— ew agir heta îro tê pêxistin. Newroz, roja nû, roja '
        'rizgariyê ye.',
    turkishContent:
        'Kawa, Kürt halkından bir demirciydi. Zalim Dehak\'ın '
        'döneminde, Dehak\'ın omuzlarından iki yılan çıkmıştı; her '
        'gün iki gencin beyniyle beslenmesi gerekiyordu. Kürt halkı '
        'yok ediliyordu.\n\n'
        'Sıra Kawa\'nın oğluna gelince Kawa zulme başkaldırdı. '
        'Demirciliğiyle gençleri kandırıp kaçırdı, önlerinde '
        'dağlarda savaş izini açtı. Ardından yirmi bir genç daha '
        'ona katıldı; Dehak öldürüldü ve halk kurtuldu.\n\n'
        '21 Mart\'ta dağların üzerinde Newroz ateşleri yakıldı — '
        'bu ateş bugün hâlâ yakılmaktadır. Newroz, yeni gün, '
        'kurtuluş günüdür.',
    backgroundNote:
        'Kawa efsanesi, Newroz bayramının mitolojik temelidir. '
        'Firdevsî Şehnâme\'sinde geçer; Kürt kültüründe Newroz '
        'direniş ve yeniden doğuşun en güçlü sembolüdür. '
        'Her yıl 21 Mart\'ta dünyanın her yerinde Kürtler bu '
        'ateşi yakarak Kawa\'yı anarlar.',
    level: 2,
    unitId: 'dest_efs',
    keywords: ['Kawa', 'Dehak', 'Newroz', 'hesinkar', 'rizgarî'],
  ),

  // ── l_005: Sîmir — çûka ji aqil ───────────────────────────
  CulturalItem(
    id: 'l_005',
    type: CulturalContentType.story,
    kurmanjTitle: 'Sîmir',
    turkishTitle: 'Simurg',
    kurmanjContent:
        'Sîmir (Sîmurx), çûkeke efsaneyî ye ku li ser çiyayê Qaf '
        'an Elbûrzê dijî. Baskên wê ji her reng û ji her mirîşkê '
        'mezintir; zanîna wê ji hemû zanistiyan kevn e.\n\n'
        'Di çîroka Ristemê Zal de: Zalê porspî, ji aliyê bavê xwe '
        've li çiya hat avêtin. Sîmir wî dît, birêz rakir, mezin '
        'kir. Dema Zal zewicî û kurê wî Rûstem biçûk bû, Sîmir '
        'berê xwe jê bir û perrek ji baskên xwe jê re hişt: "Dema '
        'ku karekî giran were, vî perrî bişewitîne, ez ê werim."\n\n'
        'Sembolîka: Sîmir aqil, veşartinên kevn û tenêtiyê temsîl '
        'dike. Di helbestvaniya Kurdî de, Sîmira Kurda sembola '
        'dengê gelê bêxwedî ye.',
    turkishContent:
        'Simurg, Kaf Dağı ya da Elburz Dağı üzerinde yaşayan '
        'efsanevi bir kuştur. Kanatları her renkten ve her '
        'kuştan büyüktür; bilgisi tüm bilimlerden daha eskidir.\n\n'
        'Rüstem-i Zal hikâyesinde: Ak saçlı Zal, babası tarafından '
        'dağa atıldı. Simurg onu buldu, kol kanat gerdi, büyüttü. '
        'Zal evlenip oğlu Rüstem küçük olunca Simurg ondan uzaklaştı '
        've kanatlarından bir tüy bıraktı: "Büyük bir iş olursa bu '
        'tüyü yak, gelirim."\n\n'
        'Sembol: Simurg bilgeliği, eski sırları ve yalnızlığı '
        'temsil eder. Kürt şiirinde Simurg, sahipsiz halkın sesinin '
        'sembolüdür.',
    backgroundNote:
        'Simurg, İran-Kürt mitolojisinde merkezi bir figürdür. '
        'Feridüddin Attar\'ın "Mantıku\'t-Tayr" (Kuşların Dili) '
        'eserinde otuz kuşun Simurg\'u ararken kendilerinin Simurg '
        'olduklarını fark etmeleri Sûfî geleneğinin simgesidir.',
    level: 3,
    unitId: 'dest_efs',
    keywords: ['Sîmir', 'Simurg', 'Zal', 'Qaf', 'çûk', 'aqil'],
  ),

  // ── l_006: Mîrza Mihemed ──────────────────────────────────
  CulturalItem(
    id: 'l_006',
    type: CulturalContentType.story,
    kurmanjTitle: 'Mîrza Mihemed',
    turkishTitle: 'Mirza Muhammed',
    kurmanjContent:
        'Mîrza Mihemed, destaneke gelêrî ya Kurd e, ji herêma '
        'Behdînan û Şemzînan tê vegotin. Mîrza, kurê mîrekî ciwan '
        'û bi dilê pak bû.\n\n'
        'Ji ber xerabiya bavê xwe yê nû-zewicî, derkete riya xwe. '
        'Li ser çiyayan rastî dêwan hat, lê bi aqil û wêrekiya xwe '
        'bi ser ket. Di dawiyê de, keçek bi navê Perîxatûn dît û '
        'evînekê kir. Bi hev re, welatê xwe ji destê neyaran '
        'rizgar kirin.\n\n'
        'Dengbêjên Behdînan (Şivan, Mehmûd, vd.) destana Mîrza '
        'Mihemed di xezelên xwe de digotin.',
    turkishContent:
        'Mirza Muhammed, Behdinan ve Şemzînan yöresinde anlatılan '
        'bir Kürt halk destanıdır. Mirza, genç ve temiz yürekli '
        'bir beyin oğluydu.\n\n'
        'Yeni evlenen babasının kötülükleri yüzünden yollara düştü. '
        'Dağlarda devlerle karşılaştı, ama zekâ ve cesaretiyle '
        'onları yendi. Sonunda Perihan adlı bir kızla karşılaştı '
        've ona âşık oldu. Birlikte vatanlarını düşmanlardan '
        'kurtardılar.\n\n'
        'Behdinan dengbêjleri (Şivan, Mahmud vb.) Mirza Muhammed '
        'destanını gazel biçiminde söylerlerdi.',
    backgroundNote:
        'Mîrza Mihemed destanı, Başur (Güney Kürdistan) ve Rojhilat '
        '(Doğu Kürdistan) sözlü anlatı geleneğinin önemli '
        'eserlerindendir. Orta ve Kuzey Kürdistan\'daki Memê Alan '
        'kadar yaygın olmamakla birlikte kendi bölgesinde güçlü bir '
        'halk hafızasına sahiptir.',
    level: 3,
    unitId: 'dest_efs',
    keywords: ['Mîrza', 'Mihemed', 'Behdînan', 'Perîxatûn', 'leheng'],
  ),

  // ── l_007: Kela Dimdimê — berxwedana 1608 ─────────────────
  CulturalItem(
    id: 'l_007',
    type: CulturalContentType.story,
    kurmanjTitle: 'Kela Dimdimê',
    turkishTitle: 'Dimdim Kalesi',
    kurmanjContent:
        'Dimdim, keleheke Kurd li herêma Bradostê ye, li rojavayê '
        'Gola Urmiyê. Di salên 1608–1610an de, Mîr Xanê Lepzêrîn, '
        'mîrê Bradostê, li hember padîşahê Îranê Şah Abbasê Yekem '
        'berxwedan da.\n\n'
        'Li kelehê, Mîr Xan û hevalên xwe zêdetirî du salan li '
        'ber hêzên mezin ên Îranê sekinîn. Dijmin ava wan qut kir, '
        'lê Kurd teslîm nebûn. Di dawiyê de, kel hat dagîrkirin — '
        'lê tu yek ji parêzvanên wê nesilandin: hemû heta mirinê '
        'li ber xistin.\n\n'
        'Destana Dimdimê di dengbêjiya Kurmancî de bi salan hatiye '
        'gotin; sembola berxwedana Kurdî ya li hember zordestiyê ye.',
    turkishContent:
        'Dimdim, Bradost yöresinde, Urmiye Gölü\'nün batısında '
        'yer alan bir Kürt kalesidir. 1609–1610 yıllarında '
        'Bradost Beyi Emir Han Lepzerîn ("altın pençe"), '
        'İran Şahı I. Abbas\'a karşı direndi.\n\n'
        'Han Lepzerîn ve yoldaşları kalede iki yıldan fazla süre '
        'boyunca İran\'ın büyük kuvvetlerine direndiler. Düşman '
        'sularını kesti, ama Kürtler teslim olmadı. Sonunda kale '
        'düştü — ama tek bir savunucu teslim olmadı: hepsi ölene '
        'kadar savaştılar.\n\n'
        'Dimdim destanı yıllarca Kurmancî dengbêjlerinde söylendi; '
        'Kürt\'ün zulme karşı direnişinin simgesidir.',
    backgroundNote:
        'Kela Dimdimê, Kürt tarihinde direnişin en önemli '
        'simgelerinden biridir. Destanın yazılı versiyonları '
        'Mele Mehmûdê Bazîdî ve sonrasında Ereb Şemo tarafından '
        '20. yüzyılda kitaplaştırılmıştır. Bugün hâlâ Bradost '
        'dengbêjleri bu destanı icra eder.',
    level: 3,
    unitId: 'dest_efs',
    keywords: ['Dimdim', 'Bradost', 'Lepzêrîn', 'berxwedan', 'kel'],
  ),

  // ── l_008: Zembîlfiroş — pakbûna li hember tacîzê ─────────
  CulturalItem(
    id: 'l_008',
    type: CulturalContentType.story,
    kurmanjTitle: 'Zembîlfiroş',
    turkishTitle: 'Zembilfiroş (Sepetçi)',
    kurmanjContent:
        'Zembîlfiroş, zilamekî dîndar û xebatkar bû; ji avdarî û '
        'heske zembîl çêdikirin û difirotin. Jina wî gelek delal '
        'bû; digel vê, Zembîlfiroş her di xebatê û duayê de bû.\n\n'
        'Jina mîrekî zewicî, dilê wê ket Zembîlfiroş. Di odeya '
        'xwe de ew xapand, lê Zembîlfiroş berxwedan da û direviya. '
        'Jina mîr ji lêkolîna dilê xwe şerm kir; Zembîlfiroş jî '
        'ji şerê giyanê xwe ve herikî û li ser riya xwe mir.\n\n'
        'Destan di dengbêjiya Kurmancî de tim wekî kilameke pakiyê '
        'hatiye gotin. Tara Jaff, Şivan Perwer, Nezahat û gelek '
        'dengên din ew vegotin.',
    turkishContent:
        'Zembilfiroş, dindar ve çalışkan bir adamdı; söğüt ve '
        'saman dallarından sepet örüp satardı. Karısı çok güzeldi; '
        'buna rağmen Zembilfiroş sürekli çalışır ve ibadet ederdi.\n\n'
        'Bir beyin karısı Zembilfiroş\'a âşık olur. Odasında onu '
        'baştan çıkarmaya çalışır, ama Zembilfiroş direnip kaçar. '
        'Bey\'in karısı kendi kalbinin arzusundan utanır; '
        'Zembilfiroş da kendi ruhsal savaşından tükenip yolda '
        'ölür.\n\n'
        'Destan Kurmancî dengbêj geleneğinde daima bir iffet '
        'klamı olarak söylendi. Tara Jaff, Şivan Perwer, Nezahat '
        've daha birçok ses bu destanı icra ettiler.',
    backgroundNote:
        'Zembîlfiroş destanı, İslâmî dindarlıkla Kürt halk '
        'ahlâkının birleştiği bir metindir. Yazılı en eski versiyon '
        'Feqiyê Teyran\'a atfedilir (17. yy). Modern dönemde Tara '
        'Jaff\'ın yorumu en bilinen kayıtlardandır.',
    level: 3,
    unitId: 'dest_efs',
    keywords: ['Zembîlfiroş', 'pakbûn', 'Feqiyê Teyran', 'destan'],
  ),

  // ── l_009: Derwêşê Evdî û Edûle ───────────────────────────
  CulturalItem(
    id: 'l_009',
    type: CulturalContentType.story,
    kurmanjTitle: 'Derwêşê Evdî û Edûle',
    turkishTitle: 'Derviş Abdi ve Edule',
    kurmanjContent:
        'Derwêşê Evdî, şervanek ji aşîreta Mîlan ê herêma Rihayê '
        'bû; bi pêlwaniya xwe û dengê xwe yê helbestî tê naskirin. '
        'Edûle, keça mîrê aşîretê bû; ew herdu evîndarê hev bûn.\n\n'
        'Lê zemanê şer bû: dijminê aşîretê — aşîreta Şeddadiyan — '
        'hêrîşek mezin kir. Derwêşê Evdî bi cesaret li hember wan '
        'şer kir, lê bi birîneke kûr ket. Edûle, ji evînê û '
        'dilxemîniyê, hilbeza ser birînê çû û bang li Derwêş kir:\n'
        '"Derwêşê min, çavên te wekî du hêlîn in…"\n\n'
        'Derwêş mir; Edûle jî nedijiya. Destana wan bi dengbêjên '
        'Rihayê û Siwêregê hatiye gotin.',
    turkishContent:
        'Derviş Abdi, Urfa yöresi Milan aşiretinden bir savaşçıydı; '
        'pehlivanlığı ve şairane sesiyle tanınırdı. Edule, aşiret '
        'beyinin kızıydı; ikisi birbirini seviyordu.\n\n'
        'Ama savaş çağıydı: aşiretin düşmanı — Şeddadîler aşireti — '
        'büyük bir saldırı düzenledi. Derviş Abdi cesaretle '
        'savaştı, ama derin bir yara aldı. Edule, aşktan ve '
        'kederden, yaranın başına koştu ve Derviş\'e seslendi:\n'
        '"Dervişim, gözlerin iki yuva gibi…"\n\n'
        'Derviş öldü; Edule de yaşamadı. Destan Urfa ve Siverek '
        'dengbêjleri tarafından söylenegeldi.',
    backgroundNote:
        'Derwêşê Evdî destanı, 19. yüzyıl ortası Kurmancî sözlü '
        'edebiyatının güçlü bir örneğidir. Mehmûd Berazî\'nin '
        '"Edûlê" isimli kilamı bu destanı modern döneme taşıdı. '
        'Siverek-Urfa dengbêj okulunun ayırt edici eserlerindendir.',
    level: 3,
    unitId: 'dest_efs',
    keywords: ['Derwêş', 'Evdî', 'Edûle', 'Riha', 'Mîlan', 'dengbêj'],
  ),

  // ── l_010: Siyabend û Xecê ────────────────────────────────
  CulturalItem(
    id: 'l_010',
    type: CulturalContentType.story,
    kurmanjTitle: 'Siyabend û Xecê',
    turkishTitle: 'Siyabend ile Hece',
    kurmanjContent:
        'Siyabend, şivanek ji herêma Serhedê — nêzîkî çiyayê Sîpanê '
        '— bû. Bi fîqa xwe û dengbêjiya xwe, dilê Xecê, keçeke ji '
        'malbateke mîrî, jê re kişand.\n\n'
        'Xecê bi yekî din re soz dabû, lê evîna wê bi Siyabend re '
        'bû. Wan bi hev re reviyan û çûn nav çiyayê Sîpanê. Li ser '
        'çiyê, Siyabend û Xecê dixwestin bijîn, lê destê qederê '
        'dirêj bû.\n\n'
        'Siyabend li pey xezalekê digeriya, li ber qêrîneka Xecê '
        'li ser zinarekî şemitî û ket. Xecê gihîşt cesedê wî: '
        'bê Siyabend jiyan jê re ne pêkan bû, wê jî xwe ji zinar '
        'berda.\n\n'
        'Heta îro, li çiyayê Sîpanê ba dihere wekî gazîyê Xecê.',
    turkishContent:
        'Siyabend, Serhat yöresinde — Süphan Dağı civarında — bir '
        'çobandı. Kavalıyla ve şarkılarıyla, bey ailesinden bir '
        'kız olan Hece\'nin gönlünü kazandı.\n\n'
        'Hece başka biriyle sözlenmişti, ama aşkı Siyabend\'leydi. '
        'Birlikte kaçıp Süphan Dağı\'na çıktılar. Dağda Siyabend '
        've Hece yaşamak istediler, ama kader erdi.\n\n'
        'Siyabend bir ceylanın peşine düşerken, Hece\'nin '
        'çığlığı üzerine bir kayadan kayıp düştü. Hece cesedine '
        'ulaştı: Siyabend\'siz yaşam ona imkânsızdı, o da kendini '
        'kayadan bıraktı.\n\n'
        'Bugün hâlâ Süphan Dağı\'nda rüzgâr Hece\'nin ağıdı gibi '
        'eser.',
    backgroundNote:
        'Siyabend û Xecê, Kurmancî\'nin "Romeo ve Juliet"i olarak '
        'anılır. Serhat bölgesinin (Ağrı, Muş, Bitlis) en meşhur '
        'aşk destanıdır. Dengbêj Egîdê Cimo ve Şeroyê Biro\'nun '
        'kayıtları destanın klasik icralarıdır. Ermenice ve '
        'Türkçe varyantları da bulunur.',
    level: 3,
    unitId: 'dest_efs',
    keywords: ['Siyabend', 'Xecê', 'Sîpan', 'Serhed', 'şivan', 'evîn'],
  ),

  // ── l_011: Memê Alan / Mem û Zîn ──────────────────────────
  CulturalItem(
    id: 'l_011',
    type: CulturalContentType.story,
    kurmanjTitle: 'Memê Alan / Mem û Zîn',
    turkishTitle: 'Memê Alan / Mem ile Zin',
    kurmanjContent:
        'Memê Alan, destana herî mezin a gelê Kurd e. Wekî kilameke '
        'devkî li ser dengbêjan belav bû; di sala 1694an de '
        '(sala hicrî 1106), Ehmedê Xanî ew wekî helbesteke nûjen — '
        '"Mem û Zîn" — nivîsand.\n\n'
        'Mem, kurê mîrê aşîreta Alan; Zîn, xwişka Mîrê Botanê. Di '
        'şeveke Newrozê de, bi kirasên xelat, rûyê xwe veşartine — '
        'di çarşîyê de dîtin hev û derbasî hev bûn. Dilê her du '
        'ket evînekê.\n\n'
        'Bekoyê Ewan, xeynikirê mîr, li hember vê evînê rabû. Mem '
        'ket zîndanê û li wir mir. Zîn li ser gora wî xwe berda û '
        'mir. Bekir jî hat kuştin û hersê li ber hev hatin '
        'definkirin — heta şopa evîn û hîlekariyê bikevin bîra '
        'gel.\n\n'
        'Ehmedê Xanî pirs dike: "Çima Kurd ne xwedî padîşah in?" '
        'Bersivên wî: "Ji ber ku ne yekgirtî ne." Bi vê re, Mem û '
        'Zîn ne tenê destaneke evînê ye — lê jî pirsek siyasî ya '
        'ku heta îro hêjayî dibersivandinê ye.',
    turkishContent:
        'Memê Alan, Kürt halkının en büyük destanıdır. Sözlü bir '
        'klam olarak dengbêjlerde yayıldı; 1694\'te (hicri 1106) '
        'Ehmedê Xanî onu modern bir manzum eser — "Mem û Zîn" — '
        'olarak kaleme aldı.\n\n'
        'Mem, Alan aşiretinin beyinin oğlu; Zin, Botan Beyi\'nin '
        'kız kardeşidir. Bir Newroz gecesinde, kıyafet değiştirip '
        'yüzlerini örtmüşken — pazarda birbirlerini gördüler ve '
        'yüzüklerini değiştirdiler. İkisinin kalbi aşka düştü.\n\n'
        'Bey\'in hain danışmanı Beko bu aşka karşı çıktı. Mem '
        'zindana atıldı ve orada öldü. Zin mezarının üstüne '
        'kendini bıraktı ve öldü. Beko da öldürüldü ve üçü yan '
        'yana gömüldü — aşk ve ihanetin izi halkın hafızasına '
        'kazınsın diye.\n\n'
        'Ehmedê Xanî sorar: "Kürtler neden kralları yok?" '
        'Cevabı: "Çünkü birlik değiller." Böylece Mem û Zîn salt '
        'bir aşk destanı değildir — aynı zamanda bugün bile '
        'cevap bekleyen siyasal bir sorudur.',
    backgroundNote:
        'Mem û Zîn, Kürt edebiyatının en önemli eseridir. '
        'Ehmedê Xanî\'nin (1651-1707) 2655 beyitlik manzum '
        'versiyonu modern Kürt ulusal bilincinin temel '
        'metinlerindendir. UNESCO 2020\'de "İnsanlığın Sözlü '
        've Somut Olmayan Kültürel Mirası" bağlamında Kürt '
        'dengbêj geleneğini tanıdı.',
    level: 4,
    unitId: 'dest_efs',
    keywords: ['Mem', 'Zîn', 'Ehmedê Xanî', 'Botan', 'Alan', 'Beko'],
  ),

  // ── l_012: Binevşa Narîn û Cembelî ────────────────────────
  CulturalItem(
    id: 'l_012',
    type: CulturalContentType.story,
    kurmanjTitle: 'Binevşa Narîn û Cembelî',
    turkishTitle: 'Binevşa Narin ve Cembeli',
    kurmanjContent:
        'Binevşa Narîn (Menekşe Narîn), keçeke ji herêma Colemêrgê '
        '(Hakkari) bû; bi hestiyariya xwe û delaliya xwe, dilê '
        'Cembelî, kurê mîrekî din, jê re kişand.\n\n'
        'Malbatên wan ji hev dûr bûn; riya bi hev re diyar ne '
        'asan bû. Binevşa Narîn tim bi hêvî dima, kewên wê dişand '
        'ku nameyan bigihîne Cembelî. Cembelî bi xezalên çiyê re '
        'peyv dikir ku bigihîje Binevşayê.\n\n'
        'Di dawiyê de, rastiya zilmê zewacên bi zorê, her du ji '
        'hev veqetand. Binevşa Narîn, bi dilê şikestî, ji pencereya '
        'xaniyê xwe xwe avêt. Cembelî, dema xebera wê hat, li ser '
        'çiyayan reviya û wenda bû.\n\n'
        'Destana wan li Colemêrg û Behdînanê bi salan hatiye '
        'gotin. Bi taybetî di kilamên dengbêjên Hekariyê de '
        'şopên destanê tim hene.',
    turkishContent:
        'Binevşa Narin (Narin Menekşe), Hakkari (Colemêrg) '
        'yöresinden bir kızdı; duyarlılığı ve zarafetiyle, başka '
        'bir beyin oğlu olan Cembeli\'nin gönlünü kazandı.\n\n'
        'Aileleri birbirine uzaktı; buluşma yolu kolay değildi. '
        'Binevşa Narin hep umut içinde kaldı, kekliklerini '
        'gönderip Cembeli\'ye mektup ulaştırdı. Cembeli, '
        'dağdaki ceylanlara seslenerek Binevşa\'ya ulaşmaya '
        'çalıştı.\n\n'
        'Sonunda, zorla yapılan evliliklerin gerçeği ikisini '
        'birbirinden ayırdı. Binevşa Narin, kalbi kırılmış bir '
        'halde, evinin penceresinden kendini bıraktı. Cembeli, '
        'haberi aldığında dağlara kaçtı ve kayboldu.\n\n'
        'Destanları Hakkari ve Behdinan\'da yıllarca söylendi. '
        'Özellikle Hakkari dengbêjlerinin klamlarında destanın '
        'izleri hâlâ vardır.',
    backgroundNote:
        'Binevşa Narîn û Cembelî destanı, Botan ve Hakkari '
        'kuşağında yaygın bir aşk hikâyesidir. Mem û Zîn kadar '
        'bilinmese de yerel dengbêj geleneğinin omurgasındadır. '
        'Kuş metaforu (keklik) Kürt halk edebiyatında haberci '
        'sembolüdür.',
    level: 3,
    unitId: 'dest_efs',
    keywords: ['Binevşa', 'Cembelî', 'Colemêrg', 'Hekarî', 'evîn'],
  ),

  // ── l_013: Şingal 2014 — Qirkirina Êzîdiyan ──────────────
  CulturalItem(
    id: 'l_013',
    type: CulturalContentType.story,
    kurmanjTitle: 'Şingala 2014 — Qirkirina Êzîdiyan',
    turkishTitle: 'Şengal 2014 — Êzidî Soykırımı',
    kurmanjContent:
        'Di 3ê Tebaxa 2014an de, DAÎŞ êrîş kir ser herêma Şingalê '
        '(Sincar) a Başûrê Kurdistanê. Gelê Êzîdî — yek ji kevintirîn '
        'neteweyên herêmê, xwedî ayîn û ziman û çand — hat qirkirin.\n\n'
        'Zêdetirî 5000 mêr hatin kuştin, 7000 jin û keç hatin '
        'revandin û li bazarên DAÎŞê hatin firotin. Bi sed hezaran '
        'mirov ji Şingalê reviyan û ji bo rojan li Çiyayê Sincarê '
        'bê av û xwarin man.\n\n'
        'Hêzên YPJ/YPG ji Rojavayê Kurdistanê rêkên rizgariyê '
        'vekirin. Nadîa Mûrad, keçeke Êzîdî ya ji Koço, ji destê '
        'DAÎŞê xilas bû û paşê bû Xelata Nobel a Aştiyê (2018).\n\n'
        'Êzîdîtî: ayîneke kevnar a Kurdî ye, Tawûsî Melek sembola '
        'xweda ye, Lalîş cihê pîroz e. UN di sala 2021an de '
        'qirkirina Êzîdîyan fermî nas kir.',
    turkishContent:
        '3 Ağustos 2014\'te DAİŞ, Güney Kürdistan\'ın Şengal (Sincar) '
        'bölgesine saldırdı. Êzidî halkı — bölgenin en kadim '
        'topluluklarından biri, kendine has dini, dili ve kültürüyle — '
        'soykırıma uğradı.\n\n'
        '5000\'den fazla erkek öldürüldü, 7000 kadın ve kız '
        'kaçırılarak DAİŞ pazarlarında satıldı. Yüz binlerce kişi '
        'Şengal\'den kaçarak Sincar Dağı\'nda günlerce susuz ve '
        'açlık içinde kaldı.\n\n'
        'Batı Kürdistan\'dan (Rojava) gelen YPJ/YPG güçleri kurtuluş '
        'koridorları açtı. Kocho köyünden bir Êzidî kızı olan '
        'Nadia Murad, DAİŞ\'in elinden kurtulup 2018 Nobel Barış '
        'Ödülü\'nü aldı.\n\n'
        'Êzidîlik: eski bir Kürt dinidir, Tavus Melek (Tawûsî Melek) '
        'kutsallığın sembolü, Laleş kutsal merkezdir. BM, 2021\'de '
        'Êzidî soykırımını resmen tanıdı.',
    backgroundNote:
        'Şengal soykırımı, 73. Êzidî soykırımı (ferman) olarak '
        'tanınır — halk tarihlerini yaşadıkları katliamlarla sayar. '
        'Halen binlerce Êzidî kadın-çocuk kayıp. Bu kayıt, bir '
        'masal değil; halen süren bir yaradır ve Kürt kültürünün '
        'çoğulluğunun öğretilmesinin etik zorunluluğudur.',
    level: 4,
    unitId: 'dest_efs',
    keywords: ['Şingal', 'Êzîdî', 'qirkirin', 'Nadîa Mûrad', 'Lalîş', 'DAÎŞ'],
  ),

  // ── l_014: Helebce 1988 — Enfala Kurd ─────────────────────
  CulturalItem(
    id: 'l_014',
    type: CulturalContentType.story,
    kurmanjTitle: 'Helebceya 1988 — Qirkirina bi Gaza Jehrî',
    turkishTitle: 'Halepçe 1988 — Kimyasal Katliam',
    kurmanjContent:
        'Di 16ê Adara 1988an de, hêzên Îraqê yên Sedam Huseyn '
        'bajarê Helebceyê — li Başûrê Kurdistanê — bi gaza jehrî '
        '(sarin, mustard, tabun) bombardiman kirin. Tenê di rojekê '
        'de 5000 mirov, piranîya wan jin û zarok, hatin kuştin. '
        'Bi hezaran birîndar hîn jî bi nexweşiyên kirêt dijîn.\n\n'
        'Helebce beşek ji operasyona "Enfalê" bû (1986–1989): '
        'li Kurdistana Başûr 4500 gundên Kurdî hatin wêrankirin, '
        '182 000 kes hatin kuştin an wenda bûn.\n\n'
        'Wêneya "Ömer Xawer bi zarokê xwe ye" — mirî li ber '
        'deriyê mala xwe ketiye — bû sembola qirkirinê.\n\n'
        'Di sala 2010an de dadgeha Iraqê qirkirina Enfalê fermî '
        'nas kir. 16ê Adarê niha li seranserê cîhanê wekî "Roja '
        'Helebceyê" tê bîranîn.',
    turkishContent:
        '16 Mart 1988\'de Saddam Hüseyin\'in Irak güçleri Güney '
        'Kürdistan\'daki Halepçe kentini zehirli gazla (sarin, '
        'hardal, tabun) bombaladı. Tek bir günde 5000 kişi, çoğu '
        'kadın ve çocuk, katledildi. Binlerce yaralı hâlâ ağır '
        'hastalıklarla yaşıyor.\n\n'
        'Halepçe, "Enfal" operasyonunun parçasıydı (1986–1989): '
        'Güney Kürdistan\'da 4500 Kürt köyü yıkıldı, 182.000 kişi '
        'öldürüldü ya da kayboldu.\n\n'
        '"Çocuğuyla Ömer Xawer" fotoğrafı — kapının önünde ölü '
        'düşmüş — soykırımın simgesi oldu.\n\n'
        '2010\'da Irak mahkemesi Enfal\'i resmi soykırım olarak '
        'tanıdı. 16 Mart günü artık dünyanın dört bir yanında '
        '"Halepçe Günü" olarak anılıyor.',
    backgroundNote:
        'Halepçe ve Enfal, 20. yüzyılın en büyük kimyasal '
        'silah saldırılarından ve belgelenmiş bir soykırımdır. '
        'Uluslararası Adalet Divanı, Britanya, Kanada, İsveç ve '
        'Norveç parlamentoları bunu soykırım olarak tanıdı. '
        'Kürt hafızasının en ağır yüküdür; dil öğrenen her '
        'Kürt bu tarihi bilmek zorundadır.',
    level: 4,
    unitId: 'dest_efs',
    keywords: ['Helebce', 'Enfal', 'qirkirin', 'Sedam', 'kîmyewî', '1988'],
  ),

  // ── l_015: Jin Jiyan Azadî ───────────────────────────────
  CulturalItem(
    id: 'l_015',
    type: CulturalContentType.story,
    kurmanjTitle: 'Jin, Jiyan, Azadî',
    turkishTitle: 'Jin, Jiyan, Azadî — Kadın, Yaşam, Özgürlük',
    kurmanjContent:
        '"Jin, Jiyan, Azadî" — sê peyvên ku ji Rojhilatê '
        'Kurdistanê derketin û bûn bangewaziyeke cîhanî.\n\n'
        'Di 16ê Îlona 2022an de, Jîna Amînî — keçeke 22 salî ya '
        'Kurd ji Seqizê — li Tehranê ji aliyê "polîsê exlaqê" '
        'ya Komara Îslamî ya Îranê ve hat kuştin, ji ber ku '
        'hicaba xwe "baş nedaniye". Li gora wê xwîşkên Kurd '
        'di cinazê de gotin: "Jin, Jiyan, Azadî!"\n\n'
        'Hinde wêjeyî: ev slogan rehên xwe ji têkoşîna jinên '
        'Kurd digire — Sakîne Cansiz (kolîne li Parîsê di 2013an '
        'de), Arîn Mîrkan (şehîd li Kobanê di 2014an de), '
        'Hevrîn Xelef (kuştî li Efrînê di 2019an de).\n\n'
        'Piştî kuştina Jînayê, xelkê Îranê — nemaze jin û xort — '
        'bi mehan dest bi şoreşê kir. Şoreş ji Rojhilatê '
        'Kurdistanê belav bû çar quncên cîhanê. Berhemên hunerî, '
        'stranên Shervin Hajipour "Baraye" li hember hêzên dewletê '
        'rabûn.',
    turkishContent:
        '"Jin, Jiyan, Azadî" — Doğu Kürdistan\'dan doğan ve '
        'küresel bir çağrıya dönüşen üç kelime.\n\n'
        '16 Eylül 2022\'de Jîna Amînî — Sakız\'dan 22 yaşında '
        'Kürt bir kız — İran İslam Cumhuriyeti\'nin "ahlak '
        'polisi" tarafından Tahran\'da "başörtüsünü uygun '
        'takmadığı" için öldürüldü. Mezarında Kürt kız '
        'kardeşleri şöyle haykırdı: "Jin, Jiyan, Azadî!"\n\n'
        'Tarihsel kökeni: bu slogan Kürt kadın mücadelesinden '
        'beslenir — Sakine Cansız (2013 Paris suikastı), '
        'Arîn Mirkan (2014 Kobanê şehidi), Hevrîn Xelef '
        '(2019 Afrin\'de katledildi).\n\n'
        'Jîna\'nın öldürülmesinin ardından İran halkı — özellikle '
        'kadınlar ve gençler — aylarca süren bir devrim başlattı. '
        'Devrim Doğu Kürdistan\'dan dünyanın dört bir yanına '
        'yayıldı. Shervin Hajipour\'un "Baraye" şarkısı gibi '
        'sanatsal direniş devleti karşısına aldı.',
    backgroundNote:
        '"Jin Jiyan Azadî" 21. yüzyılın Kürt feminizminin '
        'manifestosudur. Kürt kadın hareketinin (Tev-Dem, Kongra '
        'Star, KJK) ideolojik mirasıdır. 2022 İran devrimi '
        'şehitleri arasında çoğu Kürt genç kadın vardır. '
        'Bugün dünyanın her meydanında söylenen bu slogan, '
        'Kurmancî kökenlidir ve Kürt dilinin küresel tanıklığıdır.',
    level: 4,
    unitId: 'dest_efs',
    keywords: ['Jina Amini', 'Jin Jiyan Azadî', 'Kobanê', 'Sakîne', 'şoreş'],
  ),

  // ════════════════════════════════════════════════════════════════
  // FAZ 2 — Edebiyat geleneğinden 8 yeni destan
  // (Klasik mesnevi + dengbêjî repertuarı + folklorik miras)
  // ════════════════════════════════════════════════════════════════

  // ── l_016: Şêxê Senan ───────────────────────────────────────
  CulturalItem(
    id: 'l_016',
    type: CulturalContentType.story,
    kurmanjTitle: 'Şêxê Senan',
    turkishTitle: 'Şeyh Senan',
    kurmanjContent:
        'Destana Şêxê Senan, mesnewîyek tesewufî ye ji aliyê '
        'Feqiyê Teyran (1590–1660) ve hatiye nivîsîn. Ji destanên '
        'sereke yên edebiyata Kurdî ya klasîk e û li gor adetê '
        'Atarê Nîşaburî hatiye sazandin.\n\n'
        'Çîrok:\n'
        'Şêx Senan, alimekî sofî yê navdar ê heyamê xwe ye, li '
        'Kabê dijî û 400 mirîd dişopîne. Rojekê di xewnê de '
        'keçeke xiristîanê ya Romê dibîne û jê re dilê xwe dide.\n\n'
        'Ji bo wê keçê, dest ji Kabê û meqamê xwe ber dide. Diçe '
        'welatê wê yê Romê. Li wir, ji bo dîtina wê, çar şertên '
        'giran qebûl dike: meya tirş vexwe, butperestiyê bike, '
        'Quranê biteqîne, û berazan biçêrîne.\n\n'
        'Mirîdên wî dûra wî diçin Kabê û li ber Mihrabê Kê\'beyê '
        'duayan dikin. Bi kerameta vê duayê, Şêx ji şaşîya xwe '
        'difikire, vedigere îslamê. Keçik jî bi kerameta evînê '
        'misilman dibe û her dû dilketî bi hev re ber bi rûyê '
        'Xwedê ve diçin.\n\n'
        'Sembolîk: Destan dibêje ku evîn rê û pergalan dişikîne — '
        'lê di dawiyê de ber bi heqîqetê ve dibe.',
    turkishContent:
        'Şeyh Senan destanı, Feqiyê Teyran (1590-1660) tarafından '
        'yazılmış tasavvufi bir mesnevidir. Klasik Kürt edebiyatının '
        'temel destanlarından biridir; Attar-ı Nişaburi geleneğine '
        'göre düzenlenmiştir.\n\n'
        'Hikâye:\n'
        'Şeyh Senan, devrin tanınmış sufi alimi, Kâbe\'de yaşar ve '
        '400 müridi vardır. Bir gün rüyasında Romalı Hıristiyan bir '
        'kız görür ve gönlünü ona kaptırır.\n\n'
        'O kız için Kâbe\'yi ve makamını terk eder. Romanya\'ya, '
        'kızın memleketine gider. Orada onu görmek için dört ağır '
        'şartı kabul eder: ekşi şarap içmek, putperestlik etmek, '
        'Kuran\'ı yakmak ve domuz çobanlığı yapmak.\n\n'
        'Müritleri ondan sonra Kâbe\'ye giderek Mihrap önünde dua '
        'ederler. Bu duanın kerametiyle Şeyh hatasından döner, '
        'İslam\'a geri döner. Kız da aşkın kerametiyle Müslüman '
        'olur ve iki âşık birlikte Tanrı\'ya yönelir.\n\n'
        'Sembol: Destan, aşkın kuralları ve düzenleri yıktığını — '
        'ama sonunda hakikate götürdüğünü söyler.',
    backgroundNote:
        'Feqiyê Teyran, "Şêxê Senan" mesnewisinde Kurmancî klasik '
        'şiirinin yüksek bir örneğini verir. Eser, Mela Mahmûdê '
        'Beyazîdî tarafından 19. yüzyılda derlenmiş ve günümüzde '
        'Mehmed Uzun, Selîm Birîn gibi araştırmacılarca '
        'incelenmektedir.',
    level: 4,
    unitId: 'dest_efs',
    keywords: ['Şêxê Senan', 'Feqiyê Teyran', 'tesewuf', 'mesnewî', 'evîn'],
  ),

  // ── l_017: Filîtê Quto ──────────────────────────────────────
  CulturalItem(
    id: 'l_017',
    type: CulturalContentType.story,
    kurmanjTitle: 'Filîtê Quto',
    turkishTitle: 'Filîtê Quto Destanı',
    kurmanjContent:
        'Filîtê Quto, destana modernîya berxwedanê ya Botanê ye, '
        'li ser bûyerên reş ên dawiya sedsala 19\'an dest pê dike. '
        'Ji repertuara dengbêjên klasîk: Şakiro, Karapetê Xaço, '
        'Mihemed Arif Cizrawî di gel xwe parastine.\n\n'
        'Filîtê Quto kî bû?\n'
        'Filît, lawê Quto, ji eşîreta Heskan (Cizîr-Botan) bû. '
        'Lawekî nemir, mêrxas û ji bo gelê xwe sernewistî bû. '
        'Bi paşê ve, di şerekî dij-zalim de êşeke giran kişand.\n\n'
        'Çîrok:\n'
        'Filît di dema xwe de bi navê "şervanê gelî" naskirî bû. '
        'Roja şer, di pêşberî hêzeke pir-jimar de, bi tenê maye '
        'û birîndar dibe. Berî mirinê bi xwişk û daya xwe re '
        'peyivîn dike — gotinên wî yên dawî dengbêjan paşê dike '
        'kilam.\n\n'
        'Vegotin: Çîrok bi awayekî klasîk-dengbêjî tê vegotin: '
        'pirsa "Lê Filîto, ka tu li ku derê yî?" wek refrein '
        'çend caran tê dûbarekirin.\n\n'
        'Wateya çandî: Filîtê Quto sembola lawê Botan ê ku ji bo '
        'rûmeta gel canê xwe da ye. Stran her sal di govenda '
        'cejnê de tê stran.',
    turkishContent:
        'Filîtê Quto, Botan\'ın modern direniş destanıdır; 19. '
        'yüzyılın sonlarındaki kara olaylarda başlar. Klasik '
        'dengbêjlerin repertuarından: Şakiro, Karapetê Xaço, '
        'Mihemed Arif Cizrawî tarafından yaşatılmıştır.\n\n'
        'Filîtê Quto kimdi?\n'
        'Filît, Quto\'nun oğlu, Heskan aşiretindendi (Cizre-Botan). '
        'Yiğit, mert ve halkı için fedakâr bir gençti. Sonradan, '
        'zalime karşı bir savaşta ağır bir acı çekti.\n\n'
        'Hikâye:\n'
        'Filît döneminde "halk savaşçısı" olarak biliniyordu. '
        'Savaş gününde, kalabalık bir kuvvete karşı yalnız kalır '
        've yaralanır. Ölmeden önce kız kardeşi ve annesiyle '
        'konuşur — son sözleri sonradan dengbêjlerin şarkısı '
        'olur.\n\n'
        'Anlatım: Hikâye klasik dengbêj tarzıyla anlatılır: "Lê '
        'Filîto, neredesin?" sorusu nakarat olarak birkaç kez '
        'tekrarlanır.\n\n'
        'Kültürel anlam: Filîtê Quto, halk onuru için canını '
        'veren Botan oğlunun simgesidir. Şarkı her yıl bayram '
        'halayında söylenir.',
    backgroundNote:
        'Filîtê Quto destanı 1980\'lerden itibaren Şakiro, sonra '
        'Şivan Perwer ve Aynur Doğan tarafından modernize edilerek '
        'kaydedilmiştir. Botan halk müziğinin en bilinen '
        'eserlerinden biridir.',
    level: 3,
    unitId: 'dest_efs',
    keywords: ['Filît', 'Quto', 'Botan', 'Heskan', 'dengbêj'],
  ),

  // ── l_018: Lawkê Metînî ─────────────────────────────────────
  CulturalItem(
    id: 'l_018',
    type: CulturalContentType.story,
    kurmanjTitle: 'Lawkê Metînî',
    turkishTitle: 'Metînî Genci',
    kurmanjContent:
        'Lawkê Metînî, lawikeke (epîka kurt) dengbêjî ye ji çiyayê '
        'Metînî (Hekarî-Cizîr). Ev kilam yek ji klasîkên repertuara '
        'dengbêjiya Botanê ye.\n\n'
        'Çîrok:\n'
        'Çîrok li ser lawekî ciwan a Metînî dest pê dike. Ev law, '
        'ji bo evîna xwe an ji bo namûsa malê, ji gund derdikeve '
        'û li ser çiyayê Metînî bi dijminên xwe re şer dike.\n\n'
        'Di dema şer de, lawik birîn dibe û li serê çiyê tenê '
        'dimîne. Berî mirinê, ji daya xwe û keça xwe ya hezkirî '
        're peyamê dişîne — peyamên ku paşê dengbêj wek kilam '
        'dûbare dikin.\n\n'
        'Refrein: "Lawê Metînî, lawê min î hêja, çima tu ne li '
        'mal î?"\n\n'
        'Cûreyê edebî: Lawik (lawikê dengbêjî) ji çîrokê kintir e '
        'û bi awayê stranê tê pêşkêş kirin. Bi taybetî dengbêjên '
        'jin ev kilam dibêjin — Ayşe Şan, Meryem Xan û Şehrîbana '
        'Kurdî nimûneyên wê neqil kirine.',
    turkishContent:
        'Lawkê Metînî, Metînî Dağı\'ndan (Hakkari-Cizre) bir '
        'dengbêj lawiki (kısa epiği)\'dır. Botan dengbêj '
        'repertuarının klasiklerinden biridir.\n\n'
        'Hikâye:\n'
        'Hikâye, Metînî\'li genç bir oğlanla başlar. Bu genç, '
        'aşkı ya da ev namusu için köyden çıkar ve Metînî '
        'Dağı\'nda düşmanlarıyla savaşır.\n\n'
        'Savaş sırasında genç yaralanır ve dağ tepesinde yalnız '
        'kalır. Ölmeden önce annesine ve sevdiği kıza mesaj '
        'gönderir — bu mesajları sonradan dengbêjler şarkı '
        'olarak tekrarlar.\n\n'
        'Nakarat: "Metînî\'nin oğlu, değerli oğlum, neden evde '
        'değilsin?"\n\n'
        'Edebi tür: Lawik (dengbêj lawiki) hikâyeden kısadır ve '
        'şarkı tarzında sunulur. Özellikle kadın dengbêjler bu '
        'eseri söyler — Ayşe Şan, Meryem Xan ve Şehrîbana Kurdî '
        'örneklerini aktarmıştır.',
    backgroundNote:
        'Metînî Dağı, Hakkari sınırında bir doruk olup, Kürt '
        'dengbêj geleneğinde yiğitlik mekânının simgesidir. Lawkê '
        'Metînî, "lawik" türünün — kısa, hüzünlü, karakteristik '
        'olarak savaşçı genç teması işleyen — temsilcilerindendir.',
    level: 3,
    unitId: 'dest_efs',
    keywords: ['Lawkê Metînî', 'Metînî', 'lawik', 'dengbêj', 'çiya'],
  ),

  // ── l_019: Lawkê Birîndar ───────────────────────────────────
  CulturalItem(
    id: 'l_019',
    type: CulturalContentType.story,
    kurmanjTitle: 'Lawkê Birîndar',
    turkishTitle: 'Yaralı Genç',
    kurmanjContent:
        'Lawkê Birîndar, ji lawikên herî navdar ên dengbêjiya '
        'Kurdî ye. Çîroka lawekî birîndar dike — ku li çiyê maye '
        'û nikare vegere malê.\n\n'
        'Bingeh:\n'
        'Lawik, ji ber sedemekî (şer, dijminatî, an evîn) birîndar '
        'bûye. Li çiyayan tenê maye, bê alikar. Roj û şev derbas '
        'dibin, lê kes nayê alikariyê.\n\n'
        'Vegotina kilamê:\n'
        'Lawik bi mêla dûr re peyivîn dike: ji çiya, ji bayê, ji '
        'kanîya, ji çûkan re — ji her tiştî alikariyê dipirse, '
        'lê tu bersiv jê re nayê.\n\n'
        'Yek ji rêzikên navdar:\n'
        '"Lê dayê, ez birîndarim, lê dayê / Birîna min ne sade ye, '
        'ji birînê dilê min e..."\n\n'
        'Wateya çandî:\n'
        'Birîn di vê kilamê de ne tenê fizîkî ye — "birîna dil" '
        'gotina sereke ye. Ev sembola dûriya ji welat, ji ev, ji '
        'evîn û ji daya xwe ye. Bi taybetî di nav koçberên Kurd '
        'de gelek tê stran.',
    turkishContent:
        'Lawkê Birîndar, Kürt dengbêjliğinin en tanınmış '
        'lawiklerinden biridir. Yaralanmış bir gencin hikâyesini '
        'anlatır — dağda kalmış, eve dönemeyen.\n\n'
        'Arka plan:\n'
        'Genç, bir sebepten (savaş, düşmanlık veya aşk) '
        'yaralanmıştır. Dağlarda yalnız kalmış, yardımcısız. Gün '
        've geceler geçer, ama kimse yardıma gelmez.\n\n'
        'Şarkının anlatımı:\n'
        'Genç uzaktaki şeylerle konuşur: dağa, rüzgâra, kaynağa, '
        'kuşlara — her şeyden yardım ister, ama hiçbir cevap '
        'gelmez.\n\n'
        'Ünlü mısralarından biri:\n'
        '"Anneciğim, ben yaralıyım, anneciğim / Yaram basit '
        'değil, yaram kalbimin yarasıdır..."\n\n'
        'Kültürel anlam:\n'
        'Bu şarkıda yara sadece fiziksel değildir — "kalbin '
        'yarası" temel temadır. Bu, vatandan, evden, aşktan ve '
        'anneden uzaklığın simgesidir. Özellikle Kürt göçmenler '
        'arasında çok söylenir.',
    backgroundNote:
        '"Lawkê Birîndar" 1990\'lardan beri Şivan Perwer, Ciwan '
        'Haco, Aynur Doğan tarafından kaydedilmiştir. Klasik '
        'dengbêj versiyonları Şakiro ve Mihemed Arif Cizrawî '
        'tarafından yaşatılmıştır.',
    level: 3,
    unitId: 'dest_efs',
    keywords: ['Lawkê Birîndar', 'birîn', 'çiya', 'dûrî', 'koçberî'],
  ),

  // ── l_020: Ferxendê ─────────────────────────────────────────
  CulturalItem(
    id: 'l_020',
    type: CulturalContentType.story,
    kurmanjTitle: 'Ferxendê',
    turkishTitle: 'Ferxendê — Kahraman Kadın',
    kurmanjContent:
        'Ferxendê, ji destanên kêm ên Kurdî yên bi jin-leheng e. '
        'Ji aliyê Heciyê Cindî (1908–1990) ve di antolojiya '
        '"Folklora Kurdî" (1957, Yêrêvan) de hate berhevkirin.\n\n'
        'Çîrok:\n'
        'Ferxendê, keça mîrekî Kurd e. Bi mêrxasî û aqilê xwe '
        'navdar e. Gava bavê wê mir, birayên wê ji mîrekiyê '
        'derkevin û Ferxendê bi tenê xwedî bavê xwe û namûsa '
        'malê dimîne.\n\n'
        'Şer:\n'
        'Dijminên malê, bi îstîfade ji vê rewşê, êrîşî mîrekiyê '
        'dikin. Ferxendê cilên şervanan li xwe dike, li ser hespê '
        'rûnê û bi tenê li hember leşkerê dijmin radibe.\n\n'
        'Bi sêwêya xwe û aqilê xwe, ne tenê dijminan dêhandide, '
        'lê hêza wan ya leşkerî jî dişikîne. Ji wê demê û pê ve, '
        '"qehremaniya Ferxendê" gotineke kevin a navdariya jinên '
        'Kurd dibe.\n\n'
        'Wateya çandî: Ferxendê di destana folklorî ya Kurdî de '
        'sembola jina aqil û berxwedanê ye. Ji destanên Mem û '
        'Zîn û Siyabend û Xecê re cûda dibe — di vir de jin '
        'qehreman e, ne yek ji hîsên evîna mirin.',
    turkishContent:
        'Ferxendê, Kürt destanlarının az sayıdaki kadın-kahraman '
        'anlatılarından biridir. Heciyê Cindî (1908-1990) '
        'tarafından "Folklora Kurdî" antolojisinde (1957, Yerevan) '
        'derlenmiştir.\n\n'
        'Hikâye:\n'
        'Ferxendê, bir Kürt mîrekinin kızıdır. Yiğitliği ve '
        'aklıyla tanınır. Babası ölünce, erkek kardeşleri '
        'mîrekilikten ayrılır ve Ferxendê babasının evini ve namusu '
        'tek başına korur.\n\n'
        'Savaş:\n'
        'Düşmanlar bu durumdan yararlanarak mîrekiliğe saldırır. '
        'Ferxendê savaşçı kıyafetini giyer, ata biner ve düşman '
        'ordusuna tek başına karşı durur.\n\n'
        'Cesaret ve aklıyla sadece düşmanları geri püskürtmekle '
        'kalmaz, onların askeri gücünü de kırar. O günden sonra '
        '"Ferxendê\'nin kahramanlığı" Kürt kadınlarının ünlü '
        'sözüne dönüşür.\n\n'
        'Kültürel anlam: Ferxendê, Kürt folklor destanında akıl '
        've direnişin sembolüdür. Mem û Zîn ve Siyabend û Xecê '
        'destanlarından farklıdır — burada kadın kahraman, ölüm '
        'duygularından biri değil.',
    backgroundNote:
        'Heciyê Cindî, Sovyet Ermenistan\'ında doğmuş Kürt '
        'folklorcudur. "Folklora Kurdî" eseri Sovyet Kürt '
        'arşivinin en önemli kaynaklarındandır. Ferxendê destanı '
        'birkaç bölgesel varyantta kayıt altına alınmıştır.',
    level: 3,
    unitId: 'dest_efs',
    keywords: ['Ferxendê', 'jin-leheng', 'Heciyê Cindî', 'mîrekî', 'folklor'],
  ),

  // ── l_021: Eyşan û Bezo ─────────────────────────────────────
  CulturalItem(
    id: 'l_021',
    type: CulturalContentType.story,
    kurmanjTitle: 'Eyşan û Bezo',
    turkishTitle: 'Eyşan ve Bezo',
    kurmanjContent:
        'Eyşan û Bezo, çîrokeke evînê ya gelêrî ye ji gundên '
        'Botan û Hekarî. Ji destanên dengbêjiyê yên evînê.\n\n'
        'Çîrok:\n'
        'Eyşan, keçeke ji gundê piçûk, bi Bezo, lawekî gunêwer ê '
        'jor diçiya, dilketî dibe. Lê Bezo dûr e — di nav '
        'çiyayan de şivan e û ji bo serdarîya gund pêşbazî dike.\n\n'
        'Eyşan li bin lîla pîvanê (lîlandanê) li bende Bezo dimîne. '
        'Çiya gewre ye, demên wexta dirêj. Eyşan bi xwe re — '
        'rojan, mehan, salan — peyivîn dike: "Bezo, ka tu li ku '
        'derê yî?"\n\n'
        'Encam:\n'
        'Çend versiyon hene:\n'
        '• Yek dibêje Bezo vedigere û her dû dilketî dewatê dikin.\n'
        '• Yek dibêje Bezo di şer de mir, Eyşan li ser gora wî '
        '  saqas dirêjîne û dîlana xwe ya dawiyê dike.\n'
        '• Yek dibêje, di dawiyê de, Eyşan diçe çiya û bi Bezo '
        '  re bibe yek — bi laş an jî bi ruh.\n\n'
        'Wateya çandî: Eyşan û Bezo destana pîvana evîna jina '
        'Kurd e — pîvanek ku ne hewceyî maddî ye, lê di hundir '
        'de tê meşandin.',
    turkishContent:
        'Eyşan ve Bezo, Botan ve Hekkari köylerinden bir halk '
        'aşk hikâyesidir. Aşk dengbêj destanlarındandır.\n\n'
        'Hikâye:\n'
        'Küçük bir köyden Eyşan, dağa giden köylü genç Bezo\'ya '
        'âşık olur. Ama Bezo uzaktadır — dağlarda çobandır ve '
        'köy reisliği için yarışır.\n\n'
        'Eyşan, "lîlandan" (özlem ezgileri) eşliğinde Bezo\'yu '
        'beklemekte kalır. Dağ büyüktür, zaman uzun. Eyşan kendi '
        'kendisiyle — günler, aylar, yıllar — konuşur: "Bezo, '
        'neredesin?"\n\n'
        'Sonuç:\n'
        'Birkaç versiyon vardır:\n'
        '• Biri der ki Bezo döner ve iki âşık düğün yapar.\n'
        '• Biri der ki Bezo savaşta öldü, Eyşan mezarında uzanır '
        '  ve son halayını yapar.\n'
        '• Biri der ki sonunda Eyşan dağa gider ve Bezo\'yla '
        '  birleşir — bedence ya da ruhça.\n\n'
        'Kültürel anlam: Eyşan ve Bezo, Kürt kadınının aşk '
        '"lîlandan"ının destanıdır — maddi olmaya gerek duymayan, '
        'içte yaşayan bir özlem.',
    backgroundNote:
        '"Lîlandan" (uzun süreli özlem ezgisi) Kürt kadın '
        'müzikgeleneğinin yapısal bir öğesidir. Eyşan ve Bezo '
        'destanı çeşitli bölgesel varyantlarda — Hekarî, Botan, '
        'Berazî — kayıt altına alınmıştır.',
    level: 3,
    unitId: 'dest_efs',
    keywords: ['Eyşan', 'Bezo', 'evîn', 'lîlandan', 'şivan'],
  ),

  // ── l_022: Çiyayê Cûdî ──────────────────────────────────────
  CulturalItem(
    id: 'l_022',
    type: CulturalContentType.story,
    kurmanjTitle: 'Çiyayê Cûdî',
    turkishTitle: 'Cudi Dağı Mitolojisi',
    kurmanjContent:
        'Çiyayê Cûdî, çiyayekî pîroz e li herêma Cizîrê (Şirnex). '
        'Di mîtolojiya Kurd, Êzîdî, Misilman û Xirîstîanan de '
        'navdar e wek "cihê dakeftina keştiya Nuh".\n\n'
        'Bingeh:\n'
        'Li gor Quranê (Hûd 11:44), keştiya Nuh piştî tofanê '
        'li ser "Cûdî" dakeve. Ev cihê pîroz li gor kevneşopiya '
        'Misilman, Cudi-Şirnex e — ne Ararat (li gor Tewratê).\n\n'
        'Mîtolojiya kurdî:\n'
        '• Êzîdî bawer dikin ku Cûdî, cihê yekem mirovahiya nû '
        '  ye — li ser wê çiyê, Tawisî Melek û Adem têkilî pê re '
        '  bûn.\n'
        '• Di destanên Botan de, Cûdî wek "çiyayê dilan" tê '
        '  pejirandin — kesê ku di dilxweşiyê de ye, dile xwe '
        '  diçe Cûdî.\n'
        '• Stranên gelêrî dibêjin: "Cûdiyê min, çiyayê min, '
        '  ronîya çavên min."\n\n'
        'Çand îro:\n'
        'Her sal di rojên cejnê de, malbatên Kurd ji Cizîrê û '
        'Şirnexê dikin pîroziya Cûdiyê. Li ber çiyê govend '
        'tê meşandin. Şikeftên çiyê wek "ziyaretgehên dînî" tê '
        'naskirin.\n\n'
        'Mîras: Çiyayê Cûdî sembola yekîtiya dînî-çandî ye li '
        'hêwana Mezopotamyayê — Kurd, Asurî, Êzîdî û Misilman '
        'tev Cûdî pîroz dipejirînin.',
    turkishContent:
        'Cudi Dağı, Cizre bölgesinde (Şirnak) kutsal bir dağdır. '
        'Kürt, Yezidi, Müslüman ve Hıristiyan mitolojisinde '
        '"Nuh\'un gemisinin indiği yer" olarak bilinir.\n\n'
        'Arka plan:\n'
        'Kuran\'a göre (Hud 11:44), Nuh\'un gemisi tufandan '
        'sonra "Cudi"ye iner. Bu kutsal yer, Müslüman geleneğine '
        'göre Cizre-Şirnak\'taki Cudi\'dir — Tevrat\'ın Ararat '
        'değil.\n\n'
        'Kürt mitolojisi:\n'
        '• Yezidiler, Cudi\'nin yeni insanlığın ilk yeri olduğuna '
        '  inanır — dağda Tawusî Melek ve Adem\'le ilişki kurdu.\n'
        '• Botan destanlarında Cudi "kalplerin dağı" olarak '
        '  geçer — mutlu olan kalbini Cudi\'ye götürür.\n'
        '• Halk türküleri: "Cudim benim, dağım benim, gözlerimin '
        '  ışığı."\n\n'
        'Günümüz kültürü:\n'
        'Her yıl bayram günlerinde Cizre ve Şirnak\'tan Kürt '
        'aileleri Cudi\'yi kutsar. Dağın eteğinde halay '
        'oynanır. Dağ mağaraları "dini ziyaret yerleri" olarak '
        'bilinir.\n\n'
        'Miras: Cudi Dağı, Mezopotamya havzasında dini-kültürel '
        'birlik sembolüdür — Kürt, Asurî, Yezidi ve Müslümanlar '
        'birlikte Cudi\'yi kutsal sayar.',
    backgroundNote:
        'Cudi Dağı arkeolojik açıdan Erken Tunç Çağı (M.Ö. '
        '3000) yerleşim izleri taşır. UNESCO Doğal-Kültürel '
        'Miras adayı listesinde yer alır. Akademik kaynak: '
        'Hossein M. Kordlou — "Sacred Mountains of Mesopotamia" '
        '(2018).',
    level: 4,
    unitId: 'dest_efs',
    keywords: ['Cûdî', 'Nuh', 'Êzîdî', 'çiya', 'pîroz'],
  ),

  // ── l_023: Pir Hesen ────────────────────────────────────────
  CulturalItem(
    id: 'l_023',
    type: CulturalContentType.story,
    kurmanjTitle: 'Pir Hesen',
    turkishTitle: 'Pir Hesen — Aziz Hikâyesi',
    kurmanjContent:
        'Pir Hesen (an: Hesenê Pîr), ji efsaneyên gelêrî yên '
        'Kurdî ye. Pîr-merivekî pîroz û aqilê wî ye, ku di nav '
        'gel de wek "kesayetekî kerameta xwedayî" tê pejirandin.\n\n'
        'Çîrok:\n'
        'Pir Hesen, di dema xwe de pîrekî pir kal e, lê dilê wî '
        'ronî ye. Li gundê xwe ji bo aramiya gel, hevûduxulamên '
        'malbatî, û qewîna dilê belengazan kar dike.\n\n'
        'Keramet:\n'
        'Ji nav çîrokên Pir Hesen, çend rûpel ev in:\n'
        '• Rojekê, di şewata zivistanê de, gundê wî ji nan û '
        '  xwarinê dûr ket. Pir Hesen ji bo gel duayan kir; '
        '  sibehê, li ber deriyê her malê torbeyek nan dîtin.\n'
        '• Carekê, du gundî li ser axê di nav xwe de şer dikirin. '
        '  Pir Hesen rabû, axa nav herdu da ber çiya — ne yek û '
        '  ne yê din. Bi vî awayî her dû gundî bi hev re aşitî kir.\n'
        '• Êrîşek dujmin tê li ser gund. Pir Hesen ber bi '
        '  dujmin ve diçe û tenê bi peyvên xwe yên aşitî, '
        '  dujmin bê şer vedigere.\n\n'
        'Wateya çandî:\n'
        'Pir Hesen sembola "aqilê pîran" e di çanda Kurdî de — '
        'ne tenê hêza fizîkî, lê hêza ramîn û dîna jî pîroz e. '
        '"Pir Hesen ji me re bibêje" gotina pîr û pîrejinan e '
        'dema ku zarokek ji wan tiştek dixwaze fêr bibe.',
    turkishContent:
        'Pir Hesen (veya Hesenê Pîr), Kürt halk efsanelerinden '
        'biridir. Yaşlı bir kutsal ve akıl insanıdır — halk '
        'tarafından "ilahi keramet sahibi kişi" olarak '
        'tanınır.\n\n'
        'Hikâye:\n'
        'Pir Hesen, döneminde çok yaşlı bir pîrdir, ama gönlü '
        'aydındır. Köyünde halkın huzuru, aile uzlaşması ve '
        'fakirlerin kalbinin güçlenmesi için çalışır.\n\n'
        'Keramet:\n'
        'Pir Hesen hikâyelerinden bazıları:\n'
        '• Bir gün, kış kıtlığında köyü ekmek ve yiyecekten '
        '  uzak düştü. Pir Hesen halkı için dua etti; sabah '
        '  her evin kapısında bir torba ekmek bulundu.\n'
        '• Bir keresinde iki köylü toprak yüzünden kavga '
        '  ediyordu. Pir Hesen kalktı, ortadaki toprağı dağa '
        '  verdi — ne birinin ne diğerinin. Böylece iki köylü '
        '  barıştı.\n'
        '• Bir düşman saldırısı köye gelir. Pir Hesen düşmana '
        '  doğru gider ve sadece barış sözleriyle düşmanı '
        '  savaşmadan geri çevirir.\n\n'
        'Kültürel anlam:\n'
        'Pir Hesen, Kürt kültüründe "yaşlıların aklı"nın '
        'sembolüdür — fiziksel güç değil, düşünce ve gözlem '
        'gücünün de kutsal olduğu. Bir çocuk bir şey öğrenmek '
        'isterse, yaşlılar "Pir Hesen bize anlatır" der.',
    backgroundNote:
        'Pir Hesen efsanesi, Kürt-Alevî, Yezidi ve İslami '
        'geleneklerde benzer figürlerle paralel gider — Hızır, '
        'Pîr Sultan Abdal, Şêx Adî gibi. Bölgesel varyasyonlar '
        'farklı isimlerle aynı motifi taşır.',
    level: 2,
    unitId: 'dest_efs',
    keywords: ['Pir Hesen', 'aqil', 'aşitî', 'pîr', 'efsane'],
  ),
];
