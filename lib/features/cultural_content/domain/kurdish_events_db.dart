// ════════════════════════════════════════════════════════════════
// KURDISH HISTORICAL EVENTS DATABASE — BÛYERÊN DÎROKÎ YÊN KURDAN
//
// 13 bûyerên dîrokî yên girîng: ji Şerê Çaldiranê (1514) heta
// Şerê Kobanê (2014). Her giriş: dîrok + têgih + bandora çandî.
//
// Standard: Bedirxan-Hawar (Latînî 1932). Diakritikên rast.
// Polîtîka: Rastiya dîrokî, ne şîroveya siyasî.
//
// Kaynak: Mehrdad R. Izady "The Kurds: A Concise Handbook" (1992),
// David McDowall "A Modern History of the Kurds" (1996), Wadie
// Jwaideh "The Kurdish National Movement" (2006), Kurdipedia.
// ════════════════════════════════════════════════════════════════

import '../cultural_entities.dart';

const kKurdishEvents = <CulturalItem>[
  // ── e_001: Şerê Çaldiranê — 1514 ─────────────────────────
  CulturalItem(
    id: 'evt_001',
    type: CulturalContentType.historicalEvent,
    kurmanjTitle: 'Şerê Çaldiranê — 1514',
    turkishTitle: 'Çaldıran Savaşı — 1514',
    kurmanjContent:
        'Şerê Çaldiranê di 23ê Tebaxa 1514\'an de, di navbera '
        'Osmanî (Sultan Selîmê I) û Sefewî (Şah Îsmaîl) de pêk '
        'hat. Çaldiran li bakurê Wanê ye.\n\n'
        'Beriya şer:\n'
        'Mîrekiyên Kurd di navbera du împaratoriyan de mabûn. '
        'Îdrîsê Bedlîsî, alimê Kurd, peymana di navbera Sultan '
        'Selîm û 16 mîrekiyên Kurd de çêkir: piştevaniya '
        'leşkerî bidin Osmanî, di berdêla otonomiya hundirîn de.\n\n'
        'Encam:\n'
        '• Sefewî hatin têkbirin.\n'
        '• Mîrekiyên Kurd ên wek Botan, Hekarî, Bedlîs, Sêwregî '
        '  bûn beşek otonom a Osmanî.\n'
        '• Sînorên Kurdistanê ber bi rojhilatê ve hatin diyar '
        '  kirin — sînora ku îro jî heye.\n\n'
        'Mîras:\n'
        'Peymana Çaldiranê 300 salan otonomiya Kurd parast (1514–'
        '1839). Lê bi navendîbûna Tanzîmatê (1839) re, mîrekiyên '
        'Kurd hatin betalkirin — ev sedema serhildanên paşî bû.',
    turkishContent:
        'Çaldıran Savaşı, 23 Ağustos 1514\'te Osmanlı (I. Selim) '
        've Safevi (Şah İsmail) arasında yaşandı. Çaldıran Van\'ın '
        'kuzeyindedir.\n\n'
        'Savaş öncesi:\n'
        'Kürt mîrekleri (beylikleri) iki imparatorluk arasında '
        'kalmıştı. Kürt âlimi İdris-i Bidlisi, Sultan Selim ile '
        '16 Kürt mîreki arasında antlaşma yaptı: askeri destek '
        'verecekler, karşılığında iç özerklik alacaklardı.\n\n'
        'Sonuç:\n'
        '• Safeviler yenildi.\n'
        '• Botan, Hekarî, Bidlis, Soran gibi Kürt mîrekleri '
        '  Osmanlı\'nın özerk parçası oldu.\n'
        '• Kürdistan\'ın doğu sınırı belirlendi — bugün de var '
        '  olan sınır.\n\n'
        'Miras:\n'
        'Çaldıran antlaşması 300 yıl Kürt özerkliğini korudu '
        '(1514-1839). Ancak Tanzimat\'ın merkeziyetçiliği (1839) '
        'ile Kürt mîrekleri kaldırıldı — sonraki ayaklanmaların '
        'sebebi bu oldu.',
    backgroundNote:
        'Çaldıran çağdaş Kürt-Osmanlı ilişkilerinin temeli '
        'sayılır. Şerefname (Şerefxan Bidlîsî, 1597), bu peymanın '
        'önemini kayıt altına alır. Pasifik bir özerklik dönemi '
        'olarak modern Kürt tarihçilerince incelenir.',
    level: 4,
    unitId: 'event',
    keywords: ['Çaldiran', 'Selîm', 'Îsmaîl', 'Bedlîsî', 'mîrekî'],
  ),

  // ── e_002: Şerefname — 1597 ──────────────────────────────
  CulturalItem(
    id: 'evt_002',
    type: CulturalContentType.historicalEvent,
    kurmanjTitle: 'Şerefname — 1597',
    turkishTitle: 'Şerefname — 1597',
    kurmanjContent:
        'Şerefname, pirtûka yekem a dîroka Kurdan e. Di 1597\'an '
        'de ji aliyê Şerefxanê Bidlîsî ve hate nivîsîn — bi '
        'Farisî, lê li ser Kurdan û mîrekiyên wan.\n\n'
        'Şerefxan kî bû?\n'
        'Şerefxan Bidlîsî (1543–1599), mîrê Bidlîsê û rewşenbîrekî '
        'bilind bû. Li dîwana Şahê Sefewî mezin bû, paşê vegeriya '
        'Bedlîsê wek mîrê otonom.\n\n'
        'Naveroka pirtûkê:\n'
        '• 4 beş in: ji destpêka mîrekiyên Kurd heta dema wî.\n'
        '• Ji 16 malbatên mîrî bi hûrgilî dabeşkirin.\n'
        '• Tarîxa Eyûbiyan (Selahaddîn).\n'
        '• Adetên çand û jiyanê yên Kurdan.\n\n'
        'Girîngî:\n'
        'Şerefname yekem berhema xwe-naskirina Kurd e — beriya wê, '
        'Kurd di nav berhemên Erebî, Farisî û Yewnanî de wek '
        'koma jêr-bin tê nasîn. Şerefname dibêje: "Em xwedî '
        'dîrokê ne, em xwedî nasnameyê ne."',
    turkishContent:
        'Şerefname, Kürt tarihinin ilk kitabıdır. 1597\'de '
        'Şerefxan Bidlîsî tarafından — Farsça, ama Kürtler ve '
        'mîrekleri hakkında — yazılmıştır.\n\n'
        'Şerefxan kimdir?\n'
        'Şerefxan Bidlîsî (1543-1599), Bidlis mîreki ve büyük bir '
        'aydındı. Safevi sarayında büyüdü, sonra Bidlis\'e mîr '
        'olarak döndü.\n\n'
        'Kitabın içeriği:\n'
        '• 4 bölümden oluşur: Kürt mîrekiliklerinin başlangıcından '
        '  kendi dönemine.\n'
        '• 16 mîr ailesini ayrıntılı sınıflandırır.\n'
        '• Eyyûbîler tarihi (Selahaddin).\n'
        '• Kürtlerin kültür ve yaşam adetleri.\n\n'
        'Önemi:\n'
        'Şerefname, Kürtlerin ilk kendini tanıma eseridir — '
        'öncesinde Kürtler Arap, Fars ve Yunan eserlerinde alt-grup '
        'olarak geçerdi. Şerefname şöyle der: "Tarihimiz var, '
        'kimliğimiz var."',
    backgroundNote:
        'Şerefname el yazması Bibliothèque Nationale de France\'ta '
        'korunmaktadır. Farsça\'dan ilk Türkçe çevirisi 19. yy\'da, '
        'Kurmancî çevirisi ise 20. yy başında yapılmıştır. Modern '
        'Kürt tarihçiliğinin bir köşe taşıdır.',
    level: 4,
    unitId: 'event',
    keywords: ['Şerefname', 'Bidlîsî', 'mîrekî', 'dîrok', 'kitêb'],
  ),

  // ── e_003: Serhildana Bedirxan — 1843 ────────────────────
  CulturalItem(
    id: 'evt_003',
    type: CulturalContentType.historicalEvent,
    kurmanjTitle: 'Serhildana Bedirxan Beg — 1843',
    turkishTitle: 'Bedirxan Bey Ayaklanması — 1843',
    kurmanjContent:
        'Serhildana yekem a modern a Kurdan, di sala 1843\'an de '
        'li mîrekiya Botanê (Cizre) dest pê kir. Lîderê wê: Mîr '
        'Bedirxan Beg (1802–1869).\n\n'
        'Sedem:\n'
        'Bi navendîbûna Tanzîmatê (1839), Osmanî mîrekiyên Kurd '
        'betal kirin. Bedirxan, mîrê Botanê, dîn û çanda Kurdan '
        'wek piştgiriyê tevliyî vê serhildanê dît.\n\n'
        'Aktîvîte:\n'
        '• Bedirxan li Cizre dewleta xwe ya otonom îlan kir.\n'
        '• Bi mîrekiyên Hekarî, Bohtan, Soran re hevkarî kir.\n'
        '• Pere û tîpên xwe yên çapkirinê hebûn.\n'
        '• Pênc salan li hember leşkerê Osmanî berxwedan kir.\n\n'
        'Encam:\n'
        '• 1847: Osmanî bi 100,000 leşker hêz peyda kirin.\n'
        '• Bedirxan teslîm bû, hate sirgûn kirin Stembol, paşê '
        '  Şamê.\n'
        '• Mîrekiyên Kurd hate hilweşandin.\n\n'
        'Mîras:\n'
        'Lawên Bedirxan — Mîr Celadet û Kamûran — paşê damezrînerên '
        'kovara Hawar û alfabeya Latînî bûn (1932). Bi vî awayî, '
        'serhildana 1843 mîrasê xwe heta îro daye.',
    turkishContent:
        'Modern Kürtlerin ilk ayaklanması 1843\'te Botan mîrekiliği '
        '(Cizre)\'de başladı. Lider: Mîr Bedirxan Beg (1802-1869).\n\n'
        'Sebep:\n'
        'Tanzimat merkeziyetçiliği (1839) ile Osmanlı, Kürt '
        'mîrekiliklerini kaldırdı. Botan mîreki Bedirxan, dini ve '
        'kültürel Kürt birikimini ayaklanmanın temeline koydu.\n\n'
        'Faaliyet:\n'
        '• Bedirxan Cizre\'de özerk devletini ilan etti.\n'
        '• Hakkari, Bohtan, Soran mîrekleriyle işbirliği yaptı.\n'
        '• Kendi parası ve matbaa harfleri vardı.\n'
        '• Beş yıl Osmanlı ordusuna direndi.\n\n'
        'Sonuç:\n'
        '• 1847: Osmanlı 100.000 askerlik kuvvet topladı.\n'
        '• Bedirxan teslim oldu, İstanbul\'a, sonra Şam\'a sürgün '
        '  edildi.\n'
        '• Kürt mîrekilikleri kaldırıldı.\n\n'
        'Miras:\n'
        'Bedirxan\'ın oğulları — Mîr Celadet ve Kamûran — sonradan '
        'Hawar dergisi ve Latin alfabesinin kurucuları oldular '
        '(1932). Böylece 1843 ayaklanması mirasını günümüze taşıdı.',
    backgroundNote:
        'Bedirxan Beg\'in sürgünde yazdığı mektuplar Kürt aydınlanma '
        'hareketinin ilk belgeleridir. Ailesi 20. yy boyunca Şam, '
        'Kahire ve Avrupa\'da Kürt davasını sürdürdü — Bedirxanlar '
        'modern Kürt kültürünün kurucu hanedanıdır.',
    level: 4,
    unitId: 'event',
    keywords: ['Bedirxan', 'Botan', 'serhildan', '1843', 'Cizîr'],
  ),

  // ── e_004: Serhildana Şêx Ubeydullah — 1880 ──────────────
  CulturalItem(
    id: 'evt_004',
    type: CulturalContentType.historicalEvent,
    kurmanjTitle: 'Serhildana Şêx Ubeydullah — 1880',
    turkishTitle: 'Şeyh Ubeydullah Ayaklanması — 1880',
    kurmanjContent:
        'Serhildana Şêx Ubeydullahê Nehrî, di sala 1880\'î de pêk '
        'hat — destpêka yekem a fikra "Kurdistana yekgirtî" ye.\n\n'
        'Şêx Ubeydullah:\n'
        '(1826–1883) Şêxê Neqşbendî yê Şemzînan, di nav Kurd û '
        'misilmanên Anadoluyê de bi şopandinên xwe yên dînî navdar '
        'bû.\n\n'
        'Vîzyona wî:\n'
        'Yekem caran, Şêx Ubeydullah ji "Kurdên Tirkiye, Iran û '
        'Iraqê" wek "yek netew" peyivî — fikra "Kurdistana '
        'mezin" pêşniyar kir.\n\n'
        'Aktîvîte (1880):\n'
        '• Bi 30,000 şervanên Kurd ji Hekarî dakeve Îranê.\n'
        '• Bajarên Mehabad, Mîyando Av, Sereiş girtin.\n'
        '• Plana wî: dewleta Kurd a serbixwe damezrandin.\n\n'
        'Encam:\n'
        '• Pêkenînên dûdilî yên Osmanî/Îranî, û pîrozê pîkanîna '
        '  navbera wan.\n'
        '• Şêx Ubeydullah hate girtin, sirgûn kirin Stembol, paşê '
        '  Mekkê. Li wir di 1883\'an de mir.\n\n'
        'Mîras:\n'
        'Mektûba wî ji Konsulosê Brîtanî re, ku tê de wî gotina '
        '"Kurd millet in" diyar dike, wek "Manîfestoya yekem a '
        'neteweparêziya Kurd" tê hesibîn.',
    turkishContent:
        'Şeyh Ubeydullah Nehri Ayaklanması, 1880\'de gerçekleşti — '
        '"Birleşik Kürdistan" fikrinin ilk başlangıcıdır.\n\n'
        'Şeyh Ubeydullah:\n'
        '(1826-1883) Şemdinli Nakşi şeyhi, Kürt ve Anadolu '
        'müslümanları arasında dini takipleriyle tanındı.\n\n'
        'Vizyonu:\n'
        'İlk kez Şeyh Ubeydullah "Türkiye, İran ve Irak Kürtleri"ni '
        '"tek millet" olarak konuştu — "büyük Kürdistan" fikrini '
        'öne sürdü.\n\n'
        'Faaliyet (1880):\n'
        '• Hakkari\'den 30.000 Kürt savaşçıyla İran\'a indi.\n'
        '• Mahabad, Miyando Av, Saqqız\'ı ele geçirdi.\n'
        '• Planı: bağımsız Kürt devleti kurmaktı.\n\n'
        'Sonuç:\n'
        '• Osmanlı/İran kararsız tepkileri ve aralarındaki '
        '  pazarlık.\n'
        '• Şeyh Ubeydullah yakalandı, İstanbul\'a, sonra Mekke\'ye '
        '  sürgün edildi. 1883\'te orada öldü.\n\n'
        'Miras:\n'
        'İngiliz Konsolosu\'na yazdığı mektup — "Kürtler bir '
        'millettir" — "İlk Kürt milliyetçilik manifestosu" sayılır.',
    backgroundNote:
        'Şeyh Ubeydullah\'ın mektubu British National Archives\'ta '
        'korunmaktadır. Modern Kürt siyasi tarihinin başlangıcı '
        'olarak kabul edilir. Dr. Wadie Jwaideh\'in "The Kurdish '
        'National Movement" eseri bu olayı çok ayrıntılı '
        'incelemektedir.',
    level: 5,
    unitId: 'event',
    keywords: ['Şêx Ubeydullah', 'Neqşbendî', 'Hekarî', '1880', 'netew'],
  ),

  // ── e_005: Serhildana Şêx Seîd — 1925 ────────────────────
  CulturalItem(
    id: 'evt_005',
    type: CulturalContentType.historicalEvent,
    kurmanjTitle: 'Serhildana Şêx Seîd — 1925',
    turkishTitle: 'Şeyh Said Ayaklanması — 1925',
    kurmanjContent:
        'Serhildana Şêx Seîd, di Sibata 1925\'an de li bakurê '
        'Kurdistanê dest pê kir. Lîder: Şêx Seîd Pîranî (1865–1925), '
        'şêxê Neqşbendî yê Pîranê.\n\n'
        'Sedem:\n'
        'Komara Tirkiyeyê (1923) li dijî Kurdan polîtîkayên '
        'asîmîlasyonê meşandin: alfabeya Erebî hate qedexe kirin, '
        'medreseyên dînî hatin girtin, paytextê Kurdistanê '
        '(Diyarbekir) hate guhertin.\n\n'
        'Aktîvîte:\n'
        '• Şubat 1925: serhildan li Pîranê dest pê kir.\n'
        '• Bajarên Lice, Hênê (Hani), Çapakçur (Bingöl), Diyarbekir '
        '  hatin avêtin.\n'
        '• Pêncî hezar şervanên Kurd tev li serhildanê bûn.\n'
        '• Plana wî: dewleta Kurd a serbixwe damezrandin.\n\n'
        'Encam:\n'
        '• Avrîl 1925: Tirkiye fermana "Tedbîrê Sukûn" derxist, '
        '  bi alikariya Fransî bi rê û şerê hêzdar serhildan kuşt.\n'
        '• Şêx Seîd û 46 hevalê wî di 29ê Hezîranê 1925\'an de li '
        '  meydana Diyarbekirê hatin dardakirin.\n'
        '• Bi sed hezaran Kurd hatin sirgûn kirin ji rojhilatê '
        '  Tirkiyeyê.\n\n'
        'Mîras:\n'
        '"Daxuyaniya Şêx Seîd" — di rojên xwe yên dawî de — bi '
        'pirtûka "Kemal\'in cumhuriyet kuranlarına eleştirisi" '
        'ye, hîn di nav arşîvên dîrokî de heye.',
    turkishContent:
        'Şeyh Said Ayaklanması, Şubat 1925\'te Kuzey Kürdistan\'da '
        'başladı. Lider: Şeyh Said Pîranî (1865-1925), Piran\'ın '
        'Nakşi şeyhi.\n\n'
        'Sebep:\n'
        'Türkiye Cumhuriyeti (1923) Kürtlere karşı asimilasyon '
        'politikaları uyguladı: Arap alfabesi yasaklandı, dini '
        'medreseler kapatıldı, Kürdistan başkenti (Diyarbakır) '
        'değiştirildi.\n\n'
        'Faaliyet:\n'
        '• Şubat 1925: Ayaklanma Piran\'da başladı.\n'
        '• Lice, Hani, Bingöl, Diyarbakır kuşatıldı.\n'
        '• 50.000 Kürt savaşçı ayaklanmaya katıldı.\n'
        '• Planı: bağımsız Kürt devleti kurmaktı.\n\n'
        'Sonuç:\n'
        '• Nisan 1925: Türkiye "Takrir-i Sükun" yasası çıkardı, '
        '  Fransız desteği ve sıkıyönetimle ayaklanma bastırıldı.\n'
        '• Şeyh Said ve 46 yoldaşı 29 Haziran 1925\'te Diyarbakır '
        '  meydanında idam edildi.\n'
        '• Yüz binlerce Kürt Doğu Türkiye\'den sürgün edildi.\n\n'
        'Miras:\n'
        '"Şeyh Said Bildirgesi" — son günlerinde — Cumhuriyet '
        'kurucularına yöneltilen ilk Kürt eleştirisidir, hâlâ '
        'tarih arşivlerindedir.',
    backgroundNote:
        'Şeyh Said Ayaklanması Cumhuriyet döneminin ilk büyük '
        'Kürt direnişidir. Ayaklanmanın bastırılması 1925-1938 '
        'dönemindeki Kürt politikasının (Şark Islahat Planı) '
        'temelini oluşturdu. Şeyh Said\'in mezarı 1995\'e kadar '
        'gizliydi.',
    level: 5,
    unitId: 'event',
    keywords: ['Şêx Seîd', 'Pîran', '1925', 'Diyarbekir', 'serhildan'],
  ),

  // ── e_006: Serhildana Araratê — 1930 ─────────────────────
  CulturalItem(
    id: 'evt_006',
    type: CulturalContentType.historicalEvent,
    kurmanjTitle: 'Serhildana Araratê — 1927–1930',
    turkishTitle: 'Ararat Ayaklanması — 1927-1930',
    kurmanjContent:
        'Serhildana Araratê (an Komara Araratê), di navbera 1927 '
        'û 1930\'î de li bakurê Çiyayê Araratê pêk hat. Ev tevger '
        'ji aliyê rêxistina Hoybûn (Xoybûn) ve hate rêbazandin.\n\n'
        'Hoybûn (Xoybûn):\n'
        'Rêxistina yekem a siyasî ya Kurd-neteweparêz e, di '
        '1927\'an de li Lubnanê hate damezrandin. Damezrîner: '
        'Mîr Celadet Bedirxan, Memdûh Selîm Beg, Îhsan Nûrî Paşa, '
        'û rewşenbîrên Ermenî yên ku piştgiriya Kurdan didan.\n\n'
        'Lîderê leşkerî: Îhsan Nûrî Paşa (1893–1976), efserê '
        'berê yê Osmanî yê Kurd.\n\n'
        'Aktîvîte:\n'
        '• 1927: Hoybûn fermî dest bi tevgerê kir.\n'
        '• 1928: "Komara Araratê" hate îlan kirin li ser çiyayê '
        '  Araratê — destpêka cîhana sembolîk.\n'
        '• 1929–1930: şerên dij-Tirkiyeyê û Îranê.\n\n'
        'Encam:\n'
        '• 1930: Tirkiye, bi alîkariya hawayî ya yekem (bombe) '
        '  bi kar anî, û bi peymana Tirkiye-Îran ya hevkariyê, '
        '  serhildan hate kuştin.\n'
        '• Îhsan Nûrî Paşa li Îranê sirgûn ma.\n'
        '• Hoybûn 1944\'an de hate hilweşandin.\n\n'
        'Mîras:\n'
        '"Komara Araratê" jixwe sembolê yekem a "dewleta Kurd" e '
        'di sedsala 20\'î de — fikra ku 16 sal paşê di Mehabad '
        '(1946) de jî hate ceribandin.',
    turkishContent:
        'Ararat Ayaklanması (veya Ararat Cumhuriyeti), 1927-1930 '
        'arasında Ağrı Dağı\'nın kuzeyinde gerçekleşti. Hareket '
        'Hoybûn (Xoybûn) örgütü tarafından yürütüldü.\n\n'
        'Hoybûn (Xoybûn):\n'
        'İlk Kürt-milliyetçi siyasi örgüttür, 1927\'de Lübnan\'da '
        'kuruldu. Kurucular: Mîr Celadet Bedirxan, Memdûh Selîm '
        'Beg, İhsan Nuri Paşa ve Kürtleri destekleyen Ermeni '
        'aydınlar.\n\n'
        'Askeri lider: İhsan Nuri Paşa (1893-1976), eski Osmanlı '
        'Kürt subayı.\n\n'
        'Faaliyet:\n'
        '• 1927: Hoybûn resmi olarak harekete geçti.\n'
        '• 1928: "Ararat Cumhuriyeti" Ağrı Dağı\'nda ilan edildi — '
        '  sembolik dünyanın başlangıcı.\n'
        '• 1929-1930: Türkiye ve İran\'a karşı savaşlar.\n\n'
        'Sonuç:\n'
        '• 1930: Türkiye ilk hava bombardımanını kullandı ve '
        '  Türkiye-İran işbirliği antlaşmasıyla ayaklanma '
        '  bastırıldı.\n'
        '• İhsan Nuri Paşa İran\'a sığındı.\n'
        '• Hoybûn 1944\'te kapatıldı.\n\n'
        'Miras:\n'
        '"Ararat Cumhuriyeti" 20. yüzyılda "Kürt devleti"nin '
        'sembolik ilk örneğidir — 16 yıl sonra Mahabad\'da (1946) '
        'da denendi.',
    backgroundNote:
        'Ararat Ayaklanması, Türkiye Cumhuriyeti\'nin uluslararası '
        'arenadaki ilk askeri operasyonudur. Hava kuvvetlerinin '
        'kullanımı önemli bir teknolojik adımdı. Hoybûn arşivleri '
        'bugün Beyrut ve Paris\'te korunmaktadır.',
    level: 5,
    unitId: 'event',
    keywords: ['Ararat', 'Hoybûn', 'Îhsan Nûrî', '1930', 'komar'],
  ),

  // ── e_007: Komkujiya Dêrsim — 1937–1938 ──────────────────
  CulturalItem(
    id: 'evt_007',
    type: CulturalContentType.historicalEvent,
    kurmanjTitle: 'Komkujiya Dêrsim — 1937–1938',
    turkishTitle: 'Dersim Katliamı — 1937-1938',
    kurmanjContent:
        'Komkujiya Dêrsim, ji aliyê hêzên leşkerî yên Komara '
        'Tirkiyeyê ve, li dijî kurd-elewîyên Dêrsimê (Tunceli) '
        'pêk hat. Bûyera herî tirsnak a sedsala 20\'î ji bo '
        'Kurdan li Tirkiyeyê.\n\n'
        'Bingeh:\n'
        'Dêrsim, herêmek autonom a kurd-elewî bû, lê 1934\'an '
        'qanûna "îskan" tê derxistin: nifûsa Kurd dê tê belav '
        'kirin, ziman dê tê qedexe kirin.\n\n'
        'Lîder: Seyîd Riza (1862–1937), şêx-mîrê herêmê.\n\n'
        'Aktîvîte:\n'
        '• 1937: Dêrsim li dijî qanûna "îskan" rabû.\n'
        '• Tirkiye 50,000 leşker bi tankan, bombe û çekên jehrî '
        '  tê de barkirin.\n'
        '• Gund-bi-gund hatin şewitandin, jin û zarok hatin '
        '  kuştin.\n\n'
        'Hejmar:\n'
        '• Hesabên fermî yên Tirkiyeyê: 13,000 mirin.\n'
        '• Hesabên dîrokzanên serbixwe: 40,000–70,000.\n'
        '• Bi hezaran zarokên Kurd hatin "tirkîzandin" — bi '
        '  alîkariya rêxistina dewletê.\n\n'
        'Dawiyê:\n'
        'Seyîd Riza û şeş hevalê wî di 15ê Mijdarê 1937\'an de '
        'hatin dardakirin. Berî dardakirinê, gotina wî ya navdar: '
        '"Ev şerm ji bo we ye!"\n\n'
        'Mîras:\n'
        '2011: Serokwezîrê Tirkiyeyê yê wê demê, "lêborînê" ji '
        'malbatên Dêrsimê xwest. Lê hîn jî gelek dosye, lîsteyên '
        'kuştîyan û goristanên kom yên belengaz nedîyar in.',
    turkishContent:
        'Dersim Katliamı, Türkiye Cumhuriyeti askeri kuvvetlerince '
        'Dersimli Kürt-Aleviler\'e (Tunceli) karşı gerçekleştirildi. '
        'Türkiye Kürtleri için 20. yüzyılın en korkunç olayıdır.\n\n'
        'Arka plan:\n'
        'Dersim özerk Kürt-Alevi bölgesiydi, ama 1934\'te "iskân" '
        'yasası çıkarıldı: Kürt nüfusu dağıtılacak, dil '
        'yasaklanacaktı.\n\n'
        'Lider: Seyîd Riza (1862-1937), bölgenin şeyh-mîrek\'i.\n\n'
        'Faaliyet:\n'
        '• 1937: Dersim "iskân" yasasına karşı ayaklandı.\n'
        '• Türkiye 50.000 askeri tank, bomba ve kimyasal silahla '
        '  dağıttı.\n'
        '• Köy köy yakıldı, kadın ve çocuklar öldürüldü.\n\n'
        'Sayılar:\n'
        '• Türkiye resmi rakamı: 13.000 ölü.\n'
        '• Bağımsız tarihçilerin tahmini: 40.000-70.000.\n'
        '• Binlerce Kürt çocuğu devlet aracılığıyla "Türkleştirildi".\n\n'
        'Sonu:\n'
        'Seyîd Riza ve altı yoldaşı 15 Kasım 1937\'de idam edildi. '
        'İdamdan önce ünlü sözü: "Bu utanç sizindir!"\n\n'
        'Miras:\n'
        '2011: Dönemin Türkiye Başbakanı, Dersim ailelerinden '
        '"özür" diledi. Ama hâlâ pek çok dosya, ölü listeleri ve '
        'toplu mezarlar açıklanmamıştır.',
    backgroundNote:
        'Seyîd Riza\'nın "Bu utanç sizindir!" sözü Kürt direniş '
        'kültürünün simgesi haline gelmiştir. Dersim katliamı '
        'Türkiye\'de sansürlü bir konu olarak kalmıştır; ilk resmi '
        'devlet kabulü 2011\'de gerçekleşti. Belgesel ve roman '
        'olarak Hasan Saltık ve Mehmet Uzun bu konuyu işlediler.',
    level: 5,
    unitId: 'event',
    keywords: ['Dêrsim', 'Seyîd Riza', '1937', 'komkujî', 'elewî'],
  ),

  // ── e_008: Komara Mehabad — 1946 ─────────────────────────
  CulturalItem(
    id: 'evt_008',
    type: CulturalContentType.historicalEvent,
    kurmanjTitle: 'Komara Mehabad — 1946',
    turkishTitle: 'Mahabad Cumhuriyeti — 1946',
    kurmanjContent:
        'Komara Mehabad, dewleta yekem û tenê ya rojavayî ya '
        'tarîxa Kurdan e. Di 22ê Çile 1946\'an de li bajarê '
        'Mehabad (Rojhilatê Kurdistanê, Îran) hate avakirin.\n\n'
        'Pêkanîn:\n'
        'Piştî Şerê Cîhanê yê Duyem, Hêzên Sovyetê li bakurê '
        'Îranê hebûn — fersand ji bo Kurdan da ku "Komeleya '
        'Jiyana Kurd" (KJK) damezrînin.\n\n'
        'Lîder: Qazî Mihemed (1893–1947), kesayetekî dînî û '
        'neteweyî, mîrê Mehabadê.\n\n'
        'Komar 11 mehan domand:\n'
        '• 22ê Çile 1946: îlan kirin li meydana Çar Çiraya '
        '  Mehabadê. Dîlanên kêfê, ezeldarên gelî.\n'
        '• Dibistanên Kurdî vebûn — yekem caran zimanê Kurdî di '
        '  perwerdeyê de bi kar hat.\n'
        '• Kovara "Kurdistan" hat çapkirin (rojnameya yekem a '
        '  bi Kurdî li Îranê).\n'
        '• Alaya Kurdî (sor-kesk-zer bi rojê li navê) hate dadan.\n'
        '• Mistefa Barzanî bi pêşmergeyên xwe leşkerê komarê bû.\n\n'
        'Dawî:\n'
        '• 31ê Adar 1947: hêzên Şahê Pehlewî yê Îranî bajar girtin '
        '  (piştî Sovyet hêzên xwe vekişandin).\n'
        '• Qazî Mihemed û birayên wî hatin dardakirin li meydana '
        '  Çar Çiraya Mehabadê — eynî meydana ku komar lê hate '
        '  îlan kirin.\n'
        '• Mistefa Barzanî bi 500 pêşmergeyên xwe ber bi Sovyetê '
        '  ve revî, ku salan paşê vegere serhildanê.\n\n'
        'Mîras:\n'
        '• Alaya Kurdî ya niha — sor-kesk-zer — ji Komara Mehabad '
        '  e.\n'
        '• Fikra "Kurdistana yekgirtî" ji wê serdemê dimîne.\n'
        '• Mistefa Barzanî dê salan paşê damezrînerê PDKê û '
        '  serokê herêma Başûrê Kurdistanê (Iraq) be.',
    turkishContent:
        'Mahabad Cumhuriyeti, Kürt tarihinin ilk ve tek batılı '
        'tarzdaki devletidir. 22 Ocak 1946\'da Mahabad\'da '
        '(Doğu Kürdistan, İran) kuruldu.\n\n'
        'Kuruluş:\n'
        'II. Dünya Savaşı\'ndan sonra Sovyet kuvvetleri Kuzey '
        'İran\'daydı — Kürtler için "Kürt Hayatı Cemiyeti" (KJK) '
        'kurma fırsatı doğdu.\n\n'
        'Lider: Qazî Mihemed (1893-1947), dini ve milli kişilik, '
        'Mahabad mîreki.\n\n'
        'Cumhuriyet 11 ay sürdü:\n'
        '• 22 Ocak 1946: Mahabad Çar Çira meydanında ilan edildi. '
        '  Mutluluk dansları, halk meclisleri.\n'
        '• Kürt okulları açıldı — Kürt dili ilk kez eğitimde '
        '  kullanıldı.\n'
        '• "Kurdistan" dergisi çıktı (İran\'da ilk Kürtçe gazete).\n'
        '• Kürt bayrağı (kırmızı-yeşil-sarı, ortada güneş) '
        '  çekildi.\n'
        '• Mustafa Barzanî peşmergeleriyle cumhuriyet ordusu oldu.\n\n'
        'Son:\n'
        '• 31 Mart 1947: Pehlevi Şah\'ın İran kuvvetleri kenti '
        '  ele geçirdi (Sovyet kuvvetlerinin çekilmesinden sonra).\n'
        '• Qazî Mihemed ve kardeşleri Mahabad Çar Çira meydanında '
        '  asıldı — cumhuriyetin ilan edildiği aynı meydanda.\n'
        '• Mustafa Barzanî 500 peşmergesiyle Sovyetler\'e sığındı, '
        '  yıllar sonra ayaklanmaya geri döndü.\n\n'
        'Miras:\n'
        '• Bugünkü Kürt bayrağı — kırmızı-yeşil-sarı — Mahabad\'dan '
        '  kalmadır.\n'
        '• "Birleşik Kürdistan" fikri o dönemden gelir.\n'
        '• Mustafa Barzanî yıllar sonra KDP\'nin kurucusu ve '
        '  Güney Kürdistan (Irak) bölgesinin lideri olacaktır.',
    backgroundNote:
        'Mahabad Cumhuriyeti, Soğuk Savaş\'ın ilk Kürt vakasıdır. '
        'Kuruluşu Sovyet desteğiyle, çöküşü Sovyet çekilmesiyle '
        'oldu. Qazî Mihemed\'in idamı, Kürt belleğinde "ihanet '
        'edilen cumhuriyet" sembolü olarak kazınmıştır.',
    level: 4,
    unitId: 'event',
    keywords: ['Mehabad', 'Qazî Mihemed', '1946', 'komar', 'Barzanî'],
  ),

  // ── e_009: Pêkanîna Hawarê — 1932 ────────────────────────
  CulturalItem(
    id: 'evt_009',
    type: CulturalContentType.historicalEvent,
    kurmanjTitle: 'Pêkanîna Kovara Hawar — 1932',
    turkishTitle: 'Hawar Dergisinin Kuruluşu — 1932',
    kurmanjContent:
        'Hawar, kovara yekem a Kurmancî bi alfabeya Latînî, di '
        '15ê Gulanê 1932\'yan de li Şamê (Sûriye) hate weşandin.\n\n'
        'Damezrîner:\n'
        'Mîr Celadet Alî Bedirxan (1893–1951), bi alîkariya:\n'
        '• Birayê wî Kamûran Bedirxan.\n'
        '• Roger Lescot (Fransî, Kurd-zan).\n'
        '• Cegerxwîn (helbestvanê genc).\n'
        '• Qedrîcan û Osman Sebrî (rewşenbîr).\n\n'
        'Berhem:\n'
        'Hawar di sala 1932 û 1943\'an de 57 hejmar weşand. '
        'Tê de:\n'
        '• Alfabeya Bedirxan (Latînî, 31 tîp): bingeh ji bo '
        '  standardîzasyona Kurmancî.\n'
        '• Helbest, çîrok, gotinên gelêrî.\n'
        '• Ferhengoka piçûk a Kurmancî-Fransî.\n'
        '• Berhemên Cegerxwîn, Qedrîcan, Osman Sebrî pêşî li wir '
        '  derketin.\n\n'
        'Cûdahî:\n'
        'Beriya Hawarê, Kurmancî bi alfabeya Erebî dihate '
        'nivîsîn — lê di nav heman alfabeyê de 4-5 standardên '
        'cuda hebûn. Hawar pêşniyara "yek alfabe, yek standard" '
        'kir.\n\n'
        'Mîras:\n'
        '• 15ê Gulanê wek "Roja Zimanê Kurdî" tê pîroz kirin.\n'
        '• Alfabeya Hawar îro standarda Kurmancîya nivîskî ye '
        '  li seranserê dinyayê.\n'
        '• Tîpên ç, ş, î, û, ê, x, q — hemû ji Hawarê tên.',
    turkishContent:
        'Hawar, Latin alfabesiyle ilk Kurmancî dergidir, 15 Mayıs '
        '1932\'de Şam\'da (Suriye) yayımlandı.\n\n'
        'Kurucu:\n'
        'Mîr Celadet Alî Bedirxan (1893-1951), şu kişilerin '
        'yardımıyla:\n'
        '• Kardeşi Kamûran Bedirxan.\n'
        '• Roger Lescot (Fransız, Kürdolog).\n'
        '• Cegerxwîn (genç şair).\n'
        '• Qedrîcan ve Osman Sebrî (aydınlar).\n\n'
        'Eserler:\n'
        'Hawar 1932-1943 arası 57 sayı yayımladı. İçeriği:\n'
        '• Bedirxan alfabesi (Latin, 31 harf): Kurmancî '
        '  standardizasyonunun temeli.\n'
        '• Şiir, hikâye, atasözü.\n'
        '• Küçük Kurmancî-Fransızca sözlük.\n'
        '• Cegerxwîn, Qedrîcan, Osman Sebrî eserleri ilk burada '
        '  yayımlandı.\n\n'
        'Fark:\n'
        'Hawar\'dan önce Kurmancî Arap alfabesiyle yazılırdı — '
        'aynı alfabe içinde 4-5 farklı standart vardı. Hawar '
        '"tek alfabe, tek standart" önerisini getirdi.\n\n'
        'Miras:\n'
        '• 15 Mayıs "Kürt Dili Günü" olarak kutlanır.\n'
        '• Hawar alfabesi bugün dünya çapında yazılı Kurmancî\'nin '
        '  standardıdır.\n'
        '• ç, ş, î, û, ê, x, q harflerinin hepsi Hawar\'dan gelir.',
    backgroundNote:
        'Hawar, Türkiye Cumhuriyeti\'nde Kürtçe yasaklandığı için '
        'Şam\'da çıkarıldı. Bedirxan kardeşler sürgündeydi. Dergi '
        'gizlice Türkiye\'ye sokulurdu — el yazısı kopyalar '
        'çoğaltılırdı. Tıpkıbasımları Institut Kurde de Paris '
        've Diyarbakır\'da Kürt Enstitüsü\'nde mevcuttur.',
    level: 3,
    unitId: 'event',
    keywords: ['Hawar', 'Bedirxan', 'alfabe', '1932', 'Şam'],
  ),

  // ── e_010: Anfal — 1986–1989 ─────────────────────────────
  CulturalItem(
    id: 'evt_010',
    type: CulturalContentType.historicalEvent,
    kurmanjTitle: 'Anfal — Operasyonên Komkujiyê 1986–1989',
    turkishTitle: 'Enfal — Soykırım Operasyonları 1986-1989',
    kurmanjContent:
        'Anfal (ji peyva Erebî "ganîmet"), navê operasyonên ku '
        'rejîma Saddam Husên ve, di navbera 1986 û 1989\'î de, '
        'li dijî gelê Kurd ên Iraqê meşandin. Komkujiyek mezin '
        'a sedsalê.\n\n'
        'Bingeh:\n'
        'Piştî şerê Iran-Iraq (1980–1988), Saddam îdîa kir ku '
        'Kurd "alîgirên Iranê" ne û divê tasfiye bibin.\n\n'
        'Aktîvîte:\n'
        '• 8 operasyonên cuda di navbera Sibata 1986 û Hezîrana '
        '  1989\'î de.\n'
        '• 4,500 gund hatin şewitandin.\n'
        '• Bi hezaran goristanên kom — kemikên hîn jî tên dîtin.\n'
        '• Çekên jehrî yên Halepçe (16ê Adarê 1988): 5,000 '
        '  sivîl di yek rojê de mirin.\n'
        '• Bi mîlyonan Kurd hatin sirgûn kirin ji çiyayên Iraqê '
        '  ber bi kampên belengaz ve.\n\n'
        'Hejmar:\n'
        '• Hesabên dîrokzanan: 100,000–182,000 mirin.\n'
        '• Bi mîlyonan Kurd ji gundên xwe hatin avêtin.\n\n'
        'Encam:\n'
        '• Saddam Husên 2003 hate girtin, 2006 hate dardakirin.\n'
        '• 2007: Iraq, Anfal wek "komkujî" pejirand.\n'
        '• 2014: Brîtanya jî pejirand.\n'
        '• 2010\'î de, dadgehên Iraqê 17 efserên rejîmê wek '
        '  "kuştiyên komkujiyê" mehkûm kirin.\n\n'
        'Mîras:\n'
        'Anfal di bîranîna kolektîv a Kurdan de wek "Holocaustê '
        'Kurd" tê hesibîn. Bûyer di her sala 14ê Avrîlê de tê '
        'bîranîn.',
    turkishContent:
        'Enfal (Arapça "ganimet"den), Saddam Hüseyin rejimi\'nin '
        '1986-1989 arası Iraklı Kürtlere karşı gerçekleştirdiği '
        'operasyonların adıdır. Yüzyılın büyük soykırımlarından.\n\n'
        'Arka plan:\n'
        'İran-Irak Savaşı (1980-1988) sonrasında Saddam, Kürtleri '
        '"İran taraftarı" ilan etti ve tasfiye edilmeleri '
        'gerektiğini söyledi.\n\n'
        'Faaliyet:\n'
        '• Şubat 1986-Haziran 1989 arası 8 ayrı operasyon.\n'
        '• 4.500 köy yakıldı.\n'
        '• Binlerce toplu mezar — kemikler hâlâ bulunuyor.\n'
        '• Halepçe kimyasal saldırısı (16 Mart 1988): bir günde '
        '  5.000 sivil öldü.\n'
        '• Milyonlarca Kürt Irak dağlarından sefil kamplara '
        '  sürgün edildi.\n\n'
        'Sayılar:\n'
        '• Tarihçi tahminleri: 100.000-182.000 ölü.\n'
        '• Milyonlarca Kürt köyünden çıkarıldı.\n\n'
        'Sonuç:\n'
        '• Saddam Hüseyin 2003\'te yakalandı, 2006\'da idam edildi.\n'
        '• 2007: Irak, Enfal\'ı "soykırım" olarak kabul etti.\n'
        '• 2014: İngiltere de kabul etti.\n'
        '• 2010\'da Irak mahkemeleri 17 rejim subayını "soykırım '
        '  katili" olarak mahkûm etti.\n\n'
        'Miras:\n'
        'Enfal Kürtlerin kolektif belleğinde "Kürt Holokostu" '
        'olarak kabul edilir. Olay her yıl 14 Nisan\'da anılır.',
    backgroundNote:
        'Halepçe saldırısı (16 Mart 1988) tek bir günde sivillere '
        'yapılan en büyük kimyasal saldırıdır. Belgeleyen '
        'fotoğrafçı Iranian-Kurdish Sayeed Janbozorgi\'nin '
        'fotoğrafları dünya çapında soykırımın simgesi haline '
        'gelmiştir. Halepçe Anıtı 2003\'te dikildi.',
    level: 5,
    unitId: 'event',
    keywords: ['Anfal', 'Saddam', 'komkujî', 'Halepçe', '1988'],
  ),

  // ── e_011: Şingal 2014 — Qirkirina Êzîdiyan ──────────────
  CulturalItem(
    id: 'evt_011',
    type: CulturalContentType.historicalEvent,
    kurmanjTitle: 'Şingal — Qirkirina Êzîdiyan 2014',
    turkishTitle: 'Şingal — 2014 Yezidi Soykırımı',
    kurmanjContent:
        'Di 3ê Tebaxa 2014\'an de, hêzên DAEŞê (rêxistina '
        'terorîst a îslamî) êrîşî herêma Şingala (Sîncar) Êzîdî '
        'kirin. Qirkirineke pir-mezin pêk hat.\n\n'
        'Bûyera:\n'
        '• 3ê Tebaxa 2014: DAEŞ ji aliyê başûr ve êrîşî Şingalê '
        '  kir.\n'
        '• Mêr û lawên Êzîdî hatin kuştin (sed bi hezaran).\n'
        '• Jin û keçên Êzîdî hatin revandin û bi koleyî firotin.\n'
        '• Zarokên Êzîdî hatin destxistin û "tirkîkirin" '
        '  (asîmîlasyon).\n'
        '• 50,000 Êzîdî li çiyayê Şingalê li hev kom bûn — '
        '  bê av, bê xwarin.\n\n'
        'Hejmar (Komeleya Mafên Mirovan):\n'
        '• 5,000 mêr hatin kuştin.\n'
        '• 6,800 jin hatin revandin (3,500 hîn winda ne).\n'
        '• 360,000 Êzîdî hatin sirgûn kirin.\n'
        '• Lalîş, cihê pîroz ê Êzîdiyan, hate parastin lê '
        '  Şingalê hate rûxandin.\n\n'
        'Lehengê civakî: Komên YPJ (Yekîneyên Parastina Jin) û '
        'YPG (Yekîneyên Parastina Gel) ji Rojavayê Kurdistanê '
        'hatin û rêya rizgariyê li çiyayê Şingalê vekirin.\n\n'
        'Mîras:\n'
        '• 2016: Parlamentoya Brîtanyayê wek "qirkirin" pejirand.\n'
        '• 2021: Almanya yekem dadgehek wek "qirkirin" mehkûm kir.\n'
        '• Nadia Murad (jin-yekem ji Şingalê), di 2018\'an de '
        '  Xelata Aramî ya Nobel wergirt.\n'
        '• Hîn jî bi hezaran jin û keç winda ne — daxwaza '
        '  rizgariyê dewam dike.',
    turkishContent:
        '3 Ağustos 2014\'te DAEŞ kuvvetleri (İslamcı terör örgütü) '
        'Şingal (Sincar) Yezidi bölgesine saldırdı. Çok büyük bir '
        'soykırım gerçekleşti.\n\n'
        'Olay:\n'
        '• 3 Ağustos 2014: DAEŞ güneyden Şingal\'a saldırdı.\n'
        '• Erkek ve genç Yezidiler öldürüldü (binlerce).\n'
        '• Yezidi kadın ve kızlar kaçırılıp köle olarak satıldı.\n'
        '• Yezidi çocuklar kaçırılıp "Türkleştirildi" '
        '  (asimilasyon).\n'
        '• 50.000 Yezidi Şingal Dağı\'nda toplandı — susuz, '
        '  yemeksiz.\n\n'
        'Sayılar (İnsan Hakları Cemiyeti):\n'
        '• 5.000 erkek öldürüldü.\n'
        '• 6.800 kadın kaçırıldı (3.500\'ü hâlâ kayıp).\n'
        '• 360.000 Yezidi sürgün edildi.\n'
        '• Yezidilerin kutsal yeri Lalîş korundu, ama Şingal '
        '  yıkıldı.\n\n'
        'Toplumsal kahraman: YPJ (Kadın Koruma Birlikleri) ve YPG '
        '(Halk Koruma Birlikleri) Batı Kürdistan\'dan geldi ve '
        'Şingal Dağı\'nda kurtuluş yolu açtı.\n\n'
        'Miras:\n'
        '• 2016: İngiltere Parlamentosu "soykırım" olarak kabul '
        '  etti.\n'
        '• 2021: Almanya ilk mahkemeyi "soykırım" olarak mahkûm '
        '  etti.\n'
        '• Nadia Murad (Şingal\'lı kadın), 2018\'de Nobel Barış '
        '  Ödülü\'nü aldı.\n'
        '• Hâlâ binlerce kadın ve kız kayıp — kurtarma talebi '
        '  devam ediyor.',
    backgroundNote:
        'Şingal soykırımı, 21. yüzyılın en açık şekilde belgelenmiş '
        'soykırımlarından biridir. BM Komisyonu (2016) raporu '
        'Bağdat-Erbil-Cenevre arşivlerindedir. Nadia Murad\'ın '
        'BM\'deki konuşması ve "The Last Girl" anı kitabı '
        'uluslararası farkındalığı yarattı.',
    level: 4,
    unitId: 'event',
    keywords: ['Şingal', 'Êzîdî', 'DAEŞ', '2014', 'qirkirin'],
  ),

  // ── e_012: Şerê Kobanê — 2014 ────────────────────────────
  CulturalItem(
    id: 'evt_012',
    type: CulturalContentType.historicalEvent,
    kurmanjTitle: 'Şerê Kobanê — 2014',
    turkishTitle: 'Kobani Savaşı — 2014',
    kurmanjContent:
        'Şerê Kobanê di navbera Îlon 2014 û Çile 2015\'an de, di '
        'navbera hêzên YPJ/YPG (Kurd) û DAEŞ de pêk hat. '
        'Berxwedanek dîrokî, ku DAEŞ wek "tu kar pê dernayê" '
        'pêşkêş kirin lê têk çû.\n\n'
        'Bingeh:\n'
        'Kobanê (an: Eyn el-Ereb), bajarekî sînor di Rojavayê '
        'Kurdistanê de ye. Sîstema xwe-rêvebir piştî 2012\'an '
        'damezrîn.\n\n'
        'Bûyera:\n'
        '• Îlon 2014: DAEŞ bi 9,000 şervan, tank û bombe êrîşî '
        '  Kobanê kir.\n'
        '• Bi sed hezar Kurd ber bi sînorê Tirkiyeyê ve revîn.\n'
        '• Bajar 70%-ê hate rûxandin.\n'
        '• YPJ (jin) û YPG (mêr) hêz li dijî DAEŞ — bi tenê 1,500 '
        '  şervan.\n'
        '• Bombebarana hawayî ya Hêzên Hevbeş (Coalition) destek '
        '  da YPGê.\n\n'
        'Encam:\n'
        '• 26ê Çile 2015: YPG/YPJ Kobanê azad kir. Yekem têkçûna '
        '  mezin a DAEŞ a sembolîk.\n'
        '• 5,000 DAEŞî hatin kuştin (li gor amaran).\n'
        '• 1,200 şervanên YPG/YPJ canê xwe da. Di nav wan de '
        '  Arîn Mîrkan, jina yekem ku xwe teqand li dijî DAEŞ.\n\n'
        'Mîras:\n'
        '• Kobanê wek "Stalîngrada DAEŞ" hate naskirin.\n'
        '• Têkçûna sembolîk a DAEŞ; di salên paşî de, DAEŞ pir '
        '  bidualî.\n'
        '• YPJ — yekîneya kadın — wek model li seranserê dinyayê '
        '  hate naskirin.\n'
        '• "Kobanê", peyveke berxwedaniyê li seranserê cîhanê.',
    turkishContent:
        'Kobani Savaşı, Eylül 2014 ile Ocak 2015 arasında YPJ/YPG '
        '(Kürt) ile DAEŞ arasında gerçekleşti. DAEŞ\'ın "yenilmez" '
        'gösterildiği bir tarihi direniş, ancak yenildi.\n\n'
        'Arka plan:\n'
        'Kobani (Ayn el-Arab), Batı Kürdistan\'da sınır kentidir. '
        '2012\'den sonra öz yönetim sistemini kurdu.\n\n'
        'Olay:\n'
        '• Eylül 2014: DAEŞ 9.000 savaşçı, tank ve bombayla '
        '  Kobani\'ye saldırdı.\n'
        '• Yüz binlerce Kürt Türkiye sınırına kaçtı.\n'
        '• Şehrin %70\'i yıkıldı.\n'
        '• YPJ (kadın) ve YPG (erkek) DAEŞ\'a karşı — sadece 1.500 '
        '  savaşçı.\n'
        '• Koalisyon hava bombardımanı YPG\'yi destekledi.\n\n'
        'Sonuç:\n'
        '• 26 Ocak 2015: YPG/YPJ Kobani\'yi kurtardı. DAEŞ\'ın '
        '  ilk büyük sembolik yenilgisi.\n'
        '• 5.000 DAEŞ\'lı öldürüldü (rakamlara göre).\n'
        '• 1.200 YPG/YPJ savaşçısı şehit oldu. İçlerinde Arîn '
        '  Mîrkan — DAEŞ\'a karşı kendini patlatan ilk kadın.\n\n'
        'Miras:\n'
        '• Kobani "DAEŞ\'ın Stalingrad\'ı" olarak anıldı.\n'
        '• DAEŞ\'ın sembolik yenilgisi; sonraki yıllarda DAEŞ '
        '  geriledi.\n'
        '• YPJ — kadın birliği — dünya çapında model olarak '
        '  tanındı.\n'
        '• "Kobani" tüm dünyada direniş sözcüğü oldu.',
    backgroundNote:
        'Kobani Savaşı, 21. yüzyılın "moral savaşı" olarak '
        'kabul edilir. Kadın savaşçıların ön cephede yer alması '
        'feminist tarih yazımının önemli olaylarındandır. Arîn '
        'Mîrkan\'ın anısı belgesel ve filmlere konu olmuştur.',
    level: 4,
    unitId: 'event',
    keywords: ['Kobanê', 'YPJ', 'DAEŞ', 'Arîn Mîrkan', '2014'],
  ),

  // ── e_013: Tevgera Jin Jiyan Azadî — 2022 ────────────────
  CulturalItem(
    id: 'evt_013',
    type: CulturalContentType.historicalEvent,
    kurmanjTitle: 'Jin, Jiyan, Azadî — 2022',
    turkishTitle: 'Jin, Jiyan, Azadî — 2022',
    kurmanjContent:
        'Di 16ê Îlonê 2022\'an de, Jîna (Mahsa) Eminî, jineke '
        'Kurd a 22-salî, li Tehranê (Îran) hate kuştin ji aliyê '
        'polîsên "Gasht-e Erşad" (polîsê exlaq) ve.\n\n'
        'Sedem: Hicaba xwe ne baş danîn — bi îdîa.\n\n'
        'Tevger:\n'
        'Bûyera Jîna bûye sebebê tevgera mezin a li hember '
        'rejîma Îslamî ya Îranê. Şîara giştî:\n'
        '"Jin, Jiyan, Azadî!"\n\n'
        'Ev şîar ji Kurdistanê tê — bi Kurmancî tê. Di 1980\'î '
        'de ji aliyê tevgera azadiya jinên Kurd ve hatibû '
        'çêkirin.\n\n'
        'Aktîvîte:\n'
        '• Îlon 2022 - Adar 2023: protestoyên giştî li Îranê û '
        '  cîhanê.\n'
        '• Jin hicaba xwe avêtin, porê xwe birîn — sembolên '
        '  azadiyê.\n'
        '• Şîar "Jin, Jiyan, Azadî" li 80 welatan tê hejmartin.\n'
        '• Pêşbirka Nobela Aramiyê 2023: Narges Mohammadi (jina '
        '  Îranî), bi alîkariya tevgera Jin Jiyan Azadî.\n\n'
        'Encam:\n'
        '• 500+ kuştî di nav protestoyan de (Hesabên Mafên '
        '  Mirovan).\n'
        '• 20,000+ girtiyên siyasî.\n'
        '• Sembola "Jin, Jiyan, Azadî" cîhanî bû — sembola '
        '  azadiya jinan li seranserê dinyayê.\n\n'
        'Mîras:\n'
        'Tevgera "Jin, Jiyan, Azadî" yekem sembola siyasî ya '
        'Kurdî ye ku cîhana giştî nas dike — wek "Liberté" ya '
        'Frensî an "Solidarność" ya Polonî.',
    turkishContent:
        '16 Eylül 2022\'de, 22 yaşındaki Kürt kadın Jîna (Mahsa) '
        'Emînî, Tahran\'da (İran) "Gasht-e Erşad" (ahlak polisi) '
        'tarafından öldürüldü.\n\n'
        'Sebep: Başörtüsünü iyi takmamak — iddiasıyla.\n\n'
        'Hareket:\n'
        'Jîna olayı İran İslam rejimine karşı büyük hareketin '
        'sebebi oldu. Genel slogan:\n'
        '"Jin, Jiyan, Azadî!" (Kadın, Yaşam, Özgürlük!)\n\n'
        'Bu slogan Kürdistan\'dan gelir — Kurmancî\'dir. '
        '1980\'lerde Kürt kadın özgürlük hareketi tarafından '
        'üretilmiştir.\n\n'
        'Faaliyet:\n'
        '• Eylül 2022 - Mart 2023: İran\'da ve dünyada genel '
        '  protestolar.\n'
        '• Kadınlar başörtülerini attı, saçlarını kesti — '
        '  özgürlük sembolleri.\n'
        '• "Jin, Jiyan, Azadî" sloganı 80 ülkede haykırıldı.\n'
        '• Nobel Barış Ödülü 2023: Narges Mohammadi (İranlı '
        '  kadın), Jin Jiyan Azadî hareketinin desteğiyle.\n\n'
        'Sonuç:\n'
        '• 500+ ölü protestolarda (İnsan Hakları raporları).\n'
        '• 20.000+ siyasi tutuklu.\n'
        '• "Jin, Jiyan, Azadî" sembolü dünya çapında oldu — '
        '  kadın özgürlüğünün küresel sembolü.\n\n'
        'Miras:\n'
        '"Jin, Jiyan, Azadî" hareketi, küresel olarak tanınan '
        'ilk Kürt siyasi semboldür — Fransa\'nın "Liberté"si '
        'veya Polonya\'nın "Solidarność"u gibi.',
    backgroundNote:
        '"Jin, Jiyan, Azadî" sloganı 1990\'lardan beri PKK ve '
        'YPJ tarafından kullanılıyordu. 2022 olaylarında küresel '
        'kabul gördü. BBC\'nin "100 etkili kadın 2022" listesinde, '
        'Jîna Emînî ve protesto kadınları yer aldı.',
    level: 4,
    unitId: 'event',
    keywords: ['Jin Jiyan Azadî', 'Jîna Eminî', '2022', 'Îran', 'azadî'],
  ),
];
