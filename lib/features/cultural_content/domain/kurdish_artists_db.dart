// ════════════════════════════════════════════════════════════════
// KURDISH ARTISTS DATABASE — STRANBÊJ, HELBESTVAN, NIVÎSKAR
//
// Kurmancî kültürün üç sütunu: Müzik, Şiir, Edebiyat.
// Her giriş profesyonel biyografi + 3 eser (şarkı / şiir / kitap)
// + Türkçe çevirileri içerir.
//
// Kaynak: Kamu alanında bilinen biyografik bilgiler;
// Institut Kurde de Paris, KurdîPedia, sanatçıların yayınlanmış
// eserleri, akademik antolojiler.
//
// Politika: Sanatsal katkıya odaklanır; tartışmalı siyasi yorumlardan
// kaçınır. Yaşayan figürler için yalnızca kamuoyuna açık biyografi.
// ════════════════════════════════════════════════════════════════

import '../cultural_entities.dart';

// ────────────────────────────────────────────────────────────────
// STRANBÊJ (Şarkıcılar) — 12 figür × 3 şarkı
// ────────────────────────────────────────────────────────────────

const kKurdishSingers = <CulturalItem>[
  CulturalItem(
    id: 's_001',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Şivan Perwer (j.d. 1955)',
    turkishTitle: 'Şivan Perwer (d. 1955)',
    kurmanjContent:
        'Şivan Perwer, ji navçeya Vîranşar a Riha ye.\n'
        'Yek ji stranbêjên herî navdar ên Kurmancî ye.\n'
        'Bi tembûr û dengê xwe yê bilind, stranên welatperwerî,\n'
        'evînî û dengbêjiyê li seranserê dinyayê belav kir.\n\n'
        '★ Stranên navdar:\n'
        '1. "Kirîvê" — sembola hevaltî û birayîtiyê.\n'
        '2. "Herne Pêş" — bangewazî ji bo hêvî û rabûnê.\n'
        '3. "Megrî Dayê" — ji dayika koçberî dûr re.',
    turkishContent:
        'Şivan Perwer, Urfa\'nın Viranşehir ilçesindendir.\n'
        'En tanınmış Kurmancî şarkıcılardan biridir.\n'
        'Tembur ve gür sesiyle vatan, aşk ve dengbêj\n'
        'ezgilerini dünyaya yaydı.\n\n'
        '★ Ünlü şarkılar:\n'
        '1. "Kirîvê" — dostluk ve kardeşliğin sembolü.\n'
        '2. "Herne Pêş" — umut ve dirilişe çağrı.\n'
        '3. "Megrî Dayê" — göçmenliğin uzağındaki anneye.',
    backgroundNote:
        'Şivan Perwer modern Kürt müziğinin küresel sesidir. '
        '1976\'dan beri Avrupa\'da yaşar, onlarca albüm üretti. '
        'Sahne adındaki "şivan" (çoban) sözcüğü kırsal kökenini ifade eder.',
    level: 2,
    unitId: 'art_singer',
    keywords: ['Şivan', 'Perwer', 'Kirîvê', 'tembûr', 'Vîranşar'],
  ),

  CulturalItem(
    id: 's_002',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Ciwan Haco (j.d. 1957)',
    turkishTitle: 'Ciwan Haco (d. 1957)',
    kurmanjContent:
        'Ciwan Haco li Qamişlo (Rojavayê Kurdistanê) ji dayîk bûye.\n'
        'Tarz û dengê wî yê nerm û jazz-îhamî,\n'
        'modernîteyê li nav muzîka kurdî anî.\n\n'
        '★ Stranên navdar:\n'
        '1. "Girtî" — aramî û pesnê azadiyê.\n'
        '2. "Welatê Min" — evîna welêt.\n'
        '3. "Çavreşê" — dîlana evînê.',
    turkishContent:
        'Ciwan Haco Kamışlı\'da (Batı Kürdistan) doğmuştur.\n'
        'Yumuşak, jazz esintili tarzıyla\n'
        'modern duyarlılığı Kürt müziğine taşıdı.\n\n'
        '★ Ünlü şarkılar:\n'
        '1. "Girtî" — sükûnet ve özgürlük güzellemesi.\n'
        '2. "Welatê Min" — vatan sevgisi.\n'
        '3. "Çavreşê" — aşkın halayı.',
    backgroundNote:
        'Ciwan Haco\'nun stili, geleneksel Kürt makamlarını '
        'caz, blues ve pop ile harmanlar. 1980\'lerden bu yana '
        'Norveç\'te yaşamakta ve birçok genç müzisyene esin kaynağı oldu.',
    level: 2,
    unitId: 'art_singer',
    keywords: ['Ciwan', 'Haco', 'Qamişlo', 'jazz', 'modern'],
  ),

  CulturalItem(
    id: 's_003',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Ayşe Şan (1938–1996)',
    turkishTitle: 'Ayşe Şan (1938–1996)',
    kurmanjContent:
        'Ayşe Şan li Diyarbekirê (Amed) ji dayîk bûye.\n'
        '"Diyarbekirê Bilbila" tê navkirin.\n'
        'Dengê wê yê bi êş û dîrokî, jiyaneke dijwar û\n'
        'evîneke nedîtî vediguherîne stranan.\n\n'
        '★ Stranên navdar:\n'
        '1. "Qederê" — gilîya çarenûsê.\n'
        '2. "Were Dotmam" — gazîkirina yara malê.\n'
        '3. "Sînem" — evîn û veqetîn.',
    turkishContent:
        'Ayşe Şan Diyarbakır (Amed) doğumludur.\n'
        '"Diyarbakır\'ın Bülbülü" olarak anılır.\n'
        'Acılı, tarihsel sesi zorlu bir hayatı ve\n'
        'görkemli aşkı şarkılara dönüştürdü.\n\n'
        '★ Ünlü şarkılar:\n'
        '1. "Qederê" — kadere serzeniş.\n'
        '2. "Were Dotmam" — amca kızı yâre çağrı.\n'
        '3. "Sînem" — aşk ve ayrılık.',
    backgroundNote:
        'Ayşe Şan, kadın dengbêj geleneğinin en güçlü temsilcilerindendir. '
        'Sürgün dolu yaşamı (Türkiye, Almanya) ses kayıtlarına derin bir hüzün katar. '
        'Halk tarafından "Bilbila Kurd" lakabı verilmiştir.',
    level: 2,
    unitId: 'art_singer',
    keywords: ['Ayşe', 'Şan', 'Amed', 'dengbêj', 'jin'],
  ),

  CulturalItem(
    id: 's_004',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Meryem Xan (1904–1949)',
    turkishTitle: 'Meryem Xan (1904–1949)',
    kurmanjContent:
        'Meryem Xan, ji gundê Axtepeyê, navçeya Miksê ya Wanê ye.\n'
        'Dengbêjeke pêşeng a Kurmancî; di salên 1940\'an de\n'
        'di Radyoya Bexdayê de stranên xwe qeyd kirin.\n'
        'Deng û hestiyariya wê, rê li ber hemû dengbêjên jin\n'
        'ên paşê vekir.\n\n'
        '★ Stranên navdar:\n'
        '1. "Lê Dayê" — kilameke evîna dayikî.\n'
        '2. "Lorî Lorî" — dilorîn ji bo pitikan.\n'
        '3. "Ez Xezalim" — pesnê delaliyê û azadiyê.',
    turkishContent:
        'Meryem Xan, Van\'ın Bahçesaray (Miks) ilçesine bağlı Axtepe\n'
        'köyündendir. Kurmancî\'nin öncü kadın dengbêjlerindendir;\n'
        '1940\'larda Bağdat Radyosu\'nda kayıtlar yaptı.\n'
        'Sesi ve duygu derinliği, kendisinden sonraki tüm\n'
        'Kürt kadın seslerin yolunu açtı.\n\n'
        '★ Ünlü şarkılar:\n'
        '1. "Lê Dayê" — anne sevgisine ağıt.\n'
        '2. "Lorî Lorî" — bebekler için ninni.\n'
        '3. "Ez Xezalim" — özgürlük ve zarafet övgüsü.',
    backgroundNote:
        'Meryem Xan, Kurmancî kadın dengbêj geleneğinin miladı '
        'kabul edilir. Kısa ömrüne rağmen (45\'te vefat) kayıtları '
        'Bağdat, Erivan ve Kahire arşivlerinde korunmuştur. '
        'Ayşe Şan\'dan Aynur Doğan\'a kadar pek çok Kürt kadın '
        'sanatçı onu öncü sayar.',
    level: 2,
    unitId: 'art_singer',
    keywords: ['Meryem', 'Xan', 'Miks', 'dengbêj', 'jin', 'Bexda'],
  ),

  CulturalItem(
    id: 's_005',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Karapetê Xaço (1908–2005)',
    turkishTitle: 'Karapetê Xaço (1908–2005)',
    kurmanjContent:
        'Karapetê Xaço dengbêjekî Ermenî ye ku\n'
        'bi Kurmancî stran gotin û çend kilamên\n'
        'mezin ên dengbêjiyê bi xêra wî gihîştin nifşên nû.\n\n'
        '★ Stranên navdar:\n'
        '1. "Lo Dilo" — gazîkirina dilê birîndar.\n'
        '2. "Siwaro" — efsaneya merdaniya kurdan.\n'
        '3. "Filîtê Quto" — destana dîrokî.',
    turkishContent:
        'Karapetê Xaço, Kurmancî söyleyen Ermeni asıllı\n'
        'bir dengbêjdir. Onun sayesinde pek çok dengbêj klamı\n'
        'yeni kuşaklara ulaştı.\n\n'
        '★ Ünlü şarkılar:\n'
        '1. "Lo Dilo" — yaralı gönle çağrı.\n'
        '2. "Siwaro" — Kürt yiğitliğinin destanı.\n'
        '3. "Filîtê Quto" — tarihi destan.',
    backgroundNote:
        'Karapetê Xaço, dengbêj geleneğinin son büyük temsilcilerindendir. '
        'Ermeni kökenli olmasına rağmen Kurmancî dilinde derin bir miras bıraktı. '
        'Kayıtları Ermenistan Radyosu arşivlerinde korunmaktadır.',
    level: 2,
    unitId: 'art_singer',
    keywords: ['Karapet', 'Xaço', 'dengbêj', 'kilam', 'Ermenistan'],
  ),

  CulturalItem(
    id: 's_006',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Nizamettin Ariç (j.d. 1956)',
    turkishTitle: 'Nizamettin Ariç (d. 1956)',
    kurmanjContent:
        'Nizamettin Ariç ji Agirî ye.\n'
        'Stranbêj, bestekar û lîstikvanê fîlmên Kurdî ye.\n'
        'Ji sala 1980an ve li Almanyayê dijî.\n\n'
        '★ Stranên navdar:\n'
        '1. "Serhad" — pesnê dewara Bakur.\n'
        '2. "Welatê min Kurdistan" — evîna welêt.\n'
        '3. "Bê Deng" — dengê bêdengiya çiyayan.',
    turkishContent:
        'Nizamettin Ariç Ağrı doğumludur.\n'
        'Şarkıcı, besteci ve Kürt sineması oyuncusudur.\n'
        '1980\'den beri Almanya\'da yaşamaktadır.\n\n'
        '★ Ünlü şarkılar:\n'
        '1. "Serhad" — Kuzey yaylasına övgü.\n'
        '2. "Welatê min Kurdistan" — vatan aşkı.\n'
        '3. "Bê Deng" — dağların sessiz sesi.',
    backgroundNote:
        '"Klamek ji bo Beko" (Beko için bir şarkı, 1992) filminin '
        'yönetmenliğini de yapmıştır. Almanya\'da yaşayan sanatçı, '
        'sürgün edebiyatının önemli bir sesidir. NOT: "Feqiyê Teyran" '
        '17. yüzyıl Kürt şairidir (p_003); Ariç ile karıştırılmamalıdır.',
    level: 2,
    unitId: 'art_singer',
    keywords: ['Nizamettin', 'Ariç', 'Agirî', 'Serhad', 'fîlm'],
  ),

  CulturalItem(
    id: 's_007',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Aram Tîgran (1934–2009)',
    turkishTitle: 'Aram Tigran (1934–2009)',
    kurmanjContent:
        'Aram Tîgran li Qamişlo ji dayîk bû, kurê malbateke Ermenî bû\n'
        'ku ji koşkirina 1915an filitî bûn.\n'
        'Bi sed stranên Kurmancî, dengê hevjiyana gelan e.\n\n'
        '★ Stranên navdar:\n'
        '1. "Dîlan" — şahiya halayê.\n'
        '2. "Ma tu wê Carê" — vegera bi bîranînê.\n'
        '3. "Hevalê Min" — pesnê hevaltiyê.',
    turkishContent:
        'Aram Tigran Kamışlı doğumlu bir Ermeni\n'
        '1915 sürgünlerinden hayatta kalmış bir aileye mensuptu.\n'
        'Kurmancî söylediği yüzlerce şarkıyla halkların\n'
        'birlikte yaşamının sesi oldu.\n\n'
        '★ Ünlü şarkılar:\n'
        '1. "Dîlan" — halay coşkusu.\n'
        '2. "Ma tu wê Carê" — anılarla geri dönüş.\n'
        '3. "Hevalê Min" — dostluğa övgü.',
    backgroundNote:
        'Aram Tigran, Kürt-Ermeni kardeşliğinin müzikal sembolüdür. '
        'Atina\'da yaşayıp orada vefat etmiştir; vasiyetiyle Diyarbakır\'a defnedildi. '
        'Cenazesi binlerce kişi tarafından karşılandı.',
    level: 2,
    unitId: 'art_singer',
    keywords: ['Aram', 'Tîgran', 'Qamişlo', 'Ermenî', 'hevjiyan'],
  ),

  CulturalItem(
    id: 's_008',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Mihemed Arif Cizrawî (1912–1986)',
    turkishTitle: 'Mihemed Arif Cizrawi (1912–1986)',
    kurmanjContent:
        'Mihemed Arif Cizrawî ji Cizîrê ye.\n'
        'Yek ji mezintirîn dengên muzîka klasîk\n'
        'û meqamê kurdî ye, "Qeyserê dengbêjan".\n\n'
        '★ Stranên navdar:\n'
        '1. "Lê Lê Yarê" — gazîkirina yarê.\n'
        '2. "Êzdînê Mîr" — destana mîrê Botan.\n'
        '3. "Dewranê" — bêhewarên jiyanê.',
    turkishContent:
        'Mihemed Arif Cizrawi Cizre kökenlidir.\n'
        'Klasik Kürt müziğinin ve makam geleneğinin\n'
        'en büyük seslerindendir; "Dengbêjlerin Kayseri".\n\n'
        '★ Ünlü şarkılar:\n'
        '1. "Lê Lê Yarê" — yâre seslenme.\n'
        '2. "Êzdînê Mîr" — Botan beyinin destanı.\n'
        '3. "Dewranê" — hayatın iniş çıkışları.',
    backgroundNote:
        'Cizrawî, Bağdat Radyosu\'nun klasik Kürt repertuvarının '
        'temel taşlarındandır. Sesindeki makam derinliği, klasik '
        'Kurmancî müziğin akademik kayıtlarında referans alınır.',
    level: 2,
    unitId: 'art_singer',
    keywords: ['Cizrawî', 'klasîk', 'meqam', 'Bexda', 'dengbêj'],
  ),

  // NOT: s_009 (Meryem Xan duplicate) kaldırıldı — s_004'te tek kayıt
  // tutuluyor. 20 Nisan 2026 eleştirel denetim bulgusu.
  // s_009 slot'u Şakiro için kullanılıyor (aşağıda).

  // ── s_009: Şakiro — 20. yy'ın en büyük Kurmancî dengbêjlerinden ─
  CulturalItem(
    id: 's_009',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Şakiro (1936–1996)',
    turkishTitle: 'Şakiro (1936–1996)',
    kurmanjContent:
        'Şakiro (navê rastî: Şikroyê Xudedî), li gundê Heldê '
        'yê navçeya Mûşê ji dayîk bû.\n'
        'Dengê wî yê kûr û dilxweş, wî kir yek ji navdartirîn '
        'dengbêjên Kurmancî. Ji kilamên şer heta kilamên evîn, '
        'her cureyê dengbêjiyê bi ustadî distira.\n\n'
        '★ Kilamên navdar:\n'
        '1. "Lawikê Metînî" — kilameke klasîk a şer û evînê.\n'
        '2. "Emê" — stranek evînê ya kûr.\n'
        '3. "Edûlê" — destana evîna winda.',
    turkishContent:
        'Şakiro (gerçek adı: Şikroyê Xudedî), Muş iline bağlı '
        'Heldê köyünde doğdu.\n'
        'Derin ve etkileyici sesiyle Kurmancî\'nin en tanınmış '
        'dengbêjlerinden biri oldu. Savaş klamlarından aşk '
        'ezgilerine, her türün ustasıydı.\n\n'
        '★ Ünlü klamlar:\n'
        '1. "Lawikê Metînî" — savaş ve aşk klasiği.\n'
        '2. "Emê" — derin bir aşk ezgisi.\n'
        '3. "Edûlê" — kayıp aşk destanı.',
    backgroundNote:
        'Şakiro, Serhat bölgesi dengbêj okulunun zirve figürüdür. '
        'Stüdyo kaydı yapma fırsatı az oldu — kayıtları çoğunlukla '
        'amatör bant kayıtları olarak dolaşır. Ölümünden sonra '
        'Muş\'ta adına çok sayıda anma düzenlendi. Şivan Perwer '
        've Nizamettin Ariç onu öncü sayar.',
    level: 3,
    unitId: 'art_singer',
    keywords: ['Şakiro', 'Heldê', 'Mûş', 'dengbêj', 'Serhed'],
  ),

  CulturalItem(
    id: 's_010',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Tara Jaff (j.d. 1958)',
    turkishTitle: 'Tara Jaff (d. 1958)',
    kurmanjContent:
        'Tara Jaff ji Silêmaniyê ye, lê piranî bi Kurmancî jî dixwîne.\n'
        'Çenglêjeneke (harpîst) klasîk e û li Brîtanyayê dijî.\n\n'
        '★ Stranên navdar:\n'
        '1. "Zembîlfiroş" — destana evîn û pîşeyî.\n'
        '2. "Hawar" — bangewazî ji bo dengê dîrokî.\n'
        '3. "Lale" — pesnê biharê.',
    turkishContent:
        'Tara Jaff Süleymaniye kökenlidir, ağırlıkla Kurmancî de söyler.\n'
        'Klasik harp icracısıdır ve İngiltere\'de yaşar.\n\n'
        '★ Ünlü şarkılar:\n'
        '1. "Zembîlfiroş" — aşk ve zanaat destanı.\n'
        '2. "Hawar" — tarihi sese çağrı.\n'
        '3. "Lale" — bahara övgü.',
    backgroundNote:
        'Tara Jaff, Kürt müziğini batı klasik harp ile birleştiren '
        'öncü icracıdır. BBC ve uluslararası festival sahnelerinde '
        'Kürt repertuvarını sunar.',
    level: 3,
    unitId: 'art_singer',
    keywords: ['Tara', 'Jaff', 'çeng', 'harp', 'klasîk'],
  ),

  CulturalItem(
    id: 's_011',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Mehmûd Berazî (1955–2003)',
    turkishTitle: 'Mehmûd Berazî (1955–2003)',
    kurmanjContent:
        'Mehmûd Berazî dengbêjekî Rojavayê Kurdistanê ye.\n'
        'Bi dengê xwe yê herêmî, kilamên kevn ên devkî\n'
        'qeyd kirin û parastin.\n\n'
        '★ Stranên navdar:\n'
        '1. "Edûlê" — destana evînê.\n'
        '2. "Heyran" — kilameke dengbêjiyê.\n'
        '3. "Mehmûd Axa" — destana mîrê herêmê.',
    turkishContent:
        'Mehmûd Berazî, Batı Kürdistan kökenli bir dengbêjdir.\n'
        'Yöresel sesiyle eski sözlü klamları kayıt altına alıp\n'
        'sonraki kuşaklara aktardı.\n\n'
        '★ Ünlü şarkılar:\n'
        '1. "Edûlê" — aşk destanı.\n'
        '2. "Heyran" — bir dengbêj klamı.\n'
        '3. "Mehmûd Axa" — yöre beyinin destanı.',
    backgroundNote:
        'Berazî, Kobanê ve çevresinin sözlü mirasını '
        'kayıt altına alan en önemli isimlerdendir. '
        'Kayıtları Hawar Müzik Arşivi\'nde korunur.',
    level: 3,
    unitId: 'art_singer',
    keywords: ['Mehmûd', 'Berazî', 'dengbêj', 'kilam', 'Kobanê'],
  ),

  CulturalItem(
    id: 's_012',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Koma Berxwedan',
    turkishTitle: 'Koma Berxwedan (Kürt müzik grubu)',
    kurmanjContent:
        'Koma Berxwedan komeke muzîka kurdî ye\n'
        'ku di salên 1980\'an de li Ewropayê hatiye damezirandin.\n'
        'Bi stranên koral ên modern, dengeke nû da muzîka kurdî.\n\n'
        '★ Stranên navdar:\n'
        '1. "Ey Reqîb" — sirûda neteweyî (versîyona koral).\n'
        '2. "Bira Bira" — pesnê biratiyê.\n'
        '3. "Dilberê" — pesnê delaliyê.',
    turkishContent:
        'Koma Berxwedan, 1980\'lerde Avrupa\'da kurulmuş\n'
        'bir Kürt müzik grubudur. Modern koral parçalarıyla\n'
        'Kürt müziğine yeni bir ses kattı.\n\n'
        '★ Ünlü şarkılar:\n'
        '1. "Ey Reqîb" — milli marş (koral versiyon).\n'
        '2. "Bira Bira" — kardeşliğe övgü.\n'
        '3. "Dilberê" — sevgiliye övgü.',
    backgroundNote:
        'Koma Berxwedan, sürgündeki Kürt diasporasının kolektif '
        'müzik üretiminin sembollerindendir. Koro disiplini ve '
        'modern düzenlemeleriyle Kürt halk müziğini güncelledi.',
    level: 3,
    unitId: 'art_singer',
    keywords: ['Koma', 'Berxwedan', 'koral', 'Ewropa', 'modern'],
  ),

  // NOT: s_013 Ayşe Şan kaydı s_003 ile yinelendiği için kaldırıldı
  // (akademik denetim 19 Nisan 2026). Tek kayıt s_003'te tutulur.

  // NOT: s_014 (Aram Tîgran) ve s_015 (Karapetê Xaço) s_007 + s_005
  // ile yinelendiği için kaldırıldı — academic audit 19 Nisan 2026.
  // Aynı kişiye iki biyografi verilmesi akademik güvenilirliği yıkar.

  // ── s_016: Mihemed Şêxo — dengê Rojava ────────────────────
  CulturalItem(
    id: 's_016',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Mihemed Şêxo (1948–1989)',
    turkishTitle: 'Mihemed Şêxo (1948–1989)',
    kurmanjContent:
        'Mihemed Şêxo, li Amûdê ya Rojavayê Kurdistanê\n'
        'ji dayîk bû. Stranên wî hem devkî, hem nûjen bûn;\n'
        'bi tembûr û bi pênûsa xwe ya helbestî,\n'
        'dengê Rojava bû.\n\n'
        '★ Stranên navdar:\n'
        '1. "Hevalno Hûn Pir Bûn" — gazîya hevrêtiyê.\n'
        '2. "Qederê" — hestên tal ên jiyanê.\n'
        '3. "Bilbilê Kurdistanê" — pesnê welat.',
    turkishContent:
        'Mihemed Şêxo, Batı Kürdistan (Rojava) Amûdê\n'
        'doğumludur. Şarkıları hem halk kökenli hem de\n'
        'moderndi; tembur ve kendi şiir kalemiyle\n'
        'Rojava\'nın sesi oldu.\n\n'
        '★ Ünlü şarkılar:\n'
        '1. "Hevalno Hûn Pir Bûn" — yoldaşlığa çağrı.\n'
        '2. "Qederê" — yaşamın acı tatları.\n'
        '3. "Bilbilê Kurdistanê" — vatana övgü.',
    backgroundNote:
        'Mihemed Şêxo, Suriye Kürtleri arasında ikonik '
        'bir figürdür. Kendi bestelerini yaparak Kurmancî '
        'stran geleneğini Rojava\'da modernize etti. '
        '41 yaşında genç vefatı geniş yankı uyandırdı.',
    level: 3,
    unitId: 'art_singer',
    keywords: ['Mihemed', 'Şêxo', 'Amûdê', 'Rojava', 'tembûr'],
  ),

  // ── s_017: Aynur Doğan — dengê nû yê Kurmancî ─────────────
  CulturalItem(
    id: 's_017',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Aynur Doğan (j.d. 1975)',
    turkishTitle: 'Aynur Doğan (d. 1975)',
    kurmanjContent:
        'Aynur Doğan, li Dêrsimê (Tunceli) ji dayîk bû.\n'
        'Yek ji dengên herî bihêz ên Kurmancî yê sedsala 21an e.\n'
        'Bi albûma "Keçê Kurdan" (2005) cîhanî bû û\n'
        'li Fatih Akin ê fîlma "Crossing the Bridge" de (2005)\n'
        'dengê xwe da dinyayê.\n\n'
        '★ Stranên navdar:\n'
        '1. "Keçê Kurdan" — pesnê keçên Kurd.\n'
        '2. "Ahmedo" — stranek evînê ya kevnar.\n'
        '3. "Dar Hejîrok" — kilameke Dêrsimî.',
    turkishContent:
        'Aynur Doğan, Dersim (Tunceli) doğumludur.\n'
        '21. yüzyılın en güçlü Kurmancî seslerinden biridir.\n'
        '"Keçê Kurdan" (2005) albümüyle uluslararası ün kazandı;\n'
        'Fatih Akın\'ın "Crossing the Bridge" (2005) belgeselinde\n'
        'sesi dünyaya ulaştı.\n\n'
        '★ Ünlü şarkılar:\n'
        '1. "Keçê Kurdan" — Kürt kızlarına övgü.\n'
        '2. "Ahmedo" — eski bir aşk ezgisi.\n'
        '3. "Dar Hejîrok" — Dersim klamı.',
    backgroundNote:
        'Aynur Doğan, Kurmancî müziğini 21. yüzyılın uluslararası '
        'sahnesine taşıyan tek isim sayılır. Jazz, rock ve dengbêj '
        'geleneğini harmanladı. "Keçê Kurdan" şarkısı bazı illerde '
        'yasaklandı; 2010\'dan beri Avrupa\'da yaşıyor. Dersim '
        'Alevî-Kırmancki mirasını Kurmancî ile birlikte temsil eder.',
    level: 2,
    unitId: 'art_singer',
    keywords: ['Aynur', 'Doğan', 'Dêrsim', 'Keçê Kurdan', 'cîhanî'],
  ),

  // ── s_018: Mem Ararat — dengê nûjen ê nifşa nû ────────────
  CulturalItem(
    id: 's_018',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Mem Ararat (j.d. 1979)',
    turkishTitle: 'Mem Ararat (d. 1979)',
    kurmanjContent:
        'Mem Ararat, li Agiriyê ji dayîk bû.\n'
        'Stranbêj û bestekarekî nûjen ê Kurmancî ye;\n'
        'folk û pop hev re tîne — nifşê nû pir jê hez dike.\n\n'
        '★ Stranên navdar:\n'
        '1. "Narîn" — evîneke nazik.\n'
        '2. "Zulemî" — stranek derd û hesreta welat.\n'
        '3. "Dayê Dayê" — gazîya dayikan.',
    turkishContent:
        'Mem Ararat, Ağrı doğumludur.\n'
        'Modern Kurmancî şarkıcı ve besteci; folk ile pop\'u '
        'harmanlıyor — yeni nesil tarafından çok seviliyor.\n\n'
        '★ Ünlü şarkılar:\n'
        '1. "Narîn" — ince bir aşk.\n'
        '2. "Zulemî" — vatan özlemi ve derdi.\n'
        '3. "Dayê Dayê" — annelere çağrı.',
    backgroundNote:
        'Mem Ararat, 2010\'lardan beri yayın platformlarında en çok '
        'dinlenen Kurmancî sanatçılardan biridir. Klasik dengbêj '
        'mirasını modern prodüksiyonla buluşturur. YouTube ve '
        'Spotify çağında Kurmancî müziğinin görünürlüğünü artırdı.',
    level: 2,
    unitId: 'art_singer',
    keywords: ['Mem', 'Ararat', 'Agirî', 'nûjen', 'pop'],
  ),

  // ── s_019: Mikail Aslan — dengbêjê Dêrsimî ────────────────
  CulturalItem(
    id: 's_019',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Mikail Aslan (j.d. 1972)',
    turkishTitle: 'Mikail Aslan (d. 1972)',
    kurmanjContent:
        'Mikail Aslan, li Dêrsimê ji dayîk bû.\n'
        'Dengbêjê mezin ê Kirmanckî (Zazakî) û Kurmancî ye;\n'
        'mîrasa muzîka Dêrsima kevn tomar dike û dipêşkêşe.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Petag" (2007) — kolektif Dêrsim albûm.\n'
        '2. "Zazaname" — mîrasa Kirmanckî.\n'
        '3. "Miraz" — stranek kevnar ji Xozatê.',
    turkishContent:
        'Mikail Aslan, Dersim doğumludur.\n'
        'Büyük bir Kirmancki (Zazaca) ve Kurmancî dengbêjidir;\n'
        'kadim Dersim müziğinin mirasını kayıt altına alıp '
        'yeniden yorumluyor.\n\n'
        '★ Ünlü eserler:\n'
        '1. "Petag" (2007) — kolektif Dersim albümü.\n'
        '2. "Zazaname" — Kirmancki mirası.\n'
        '3. "Miraz" — Hozat\'tan eski bir ezgi.',
    backgroundNote:
        'Mikail Aslan, LÛTKE\'nin Kurmancî-merkezli odağının '
        'ötesine çıkar: Zazakî/Kirmancki mirasını da temsil '
        'eden az sayıdaki çağdaş sanatçıdan biridir. Dersim '
        'soykırımının (1937-38) torunu olarak sözlü hafızayı '
        'müzik olarak taşıyor.',
    level: 3,
    unitId: 'art_singer',
    keywords: ['Mikail', 'Aslan', 'Dêrsim', 'Kirmanckî', 'Zazakî'],
  ),

  // ── s_020: Evdalê Zeynikê — pîrê dengbêjan ────────────────
  CulturalItem(
    id: 's_020',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Evdalê Zeynikê (1800–1913)',
    turkishTitle: 'Evdalê Zeynikê (1800–1913)',
    kurmanjContent:
        'Evdalê Zeynikê, pîrê hemû dengbêjên Kurmancî tê naskirin.\n'
        'Li gundê Karmiştê ya Serhedê ji dayîk bû û 113 sal jiya.\n'
        'Kurê Zeynê bû; ji ber vê yekê "yê Zeynikê".\n'
        'Stranên wî û kilamên bi navê wî hatine gotin, eslê\n'
        'dengbêjiya Kurmancî ava kirin.\n\n'
        '★ Kilamên navdar:\n'
        '1. "Lawikê Metînî" — destana evîn û şerê.\n'
        '2. "Edûlê" — evîna winda a Derwêşê Evdî û Edûlê.\n'
        '3. "Zembîlfiroş" — destana pakbûnê.',
    turkishContent:
        'Evdalê Zeynikê, tüm Kurmancî dengbêjlerinin piri (ustası) '
        'sayılır. Serhat yöresinin Karmiş köyünde doğdu ve '
        '113 yıl yaşadı. Zeynê\'nin oğluydu; bu yüzden "Zeynê\'nin."\n'
        'Onun söylediği ve adıyla anılan klamlar Kurmancî '
        'dengbêj geleneğinin özünü kurdu.\n\n'
        '★ Ünlü klamlar:\n'
        '1. "Lawikê Metînî" — aşk ve savaş destanı.\n'
        '2. "Edûlê" — Derviş Abdi ile Edule\'nin kayıp aşkı.\n'
        '3. "Zembîlfiroş" — iffet destanı.',
    backgroundNote:
        'Evdalê Zeynikê, Kurmancî sözlü kültürünün efsanevi '
        'atasıdır. 19. yy Kürt beyliklerinin sarayında söyledi. '
        'Ölümünden sonra Ordîxanê Celîl ve diğer Ermenistan '
        'Kürdolojisi araştırmacıları onun repertuvarını kayıt '
        'altına aldı. Şakiro, Karapetê Xaço, Şivan Perwer — '
        'hepsi onu kök kaynak sayar.',
    level: 3,
    unitId: 'art_singer',
    keywords: ['Evdal', 'Zeynikê', 'Karmiş', 'Serhed', 'pîrê dengbêj'],
  ),

  // ── s_021: Egîdê Cimo — Yêrêvan radyoya dengbêjê ──────────
  CulturalItem(
    id: 's_021',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Egîdê Cimo (1920s–2005)',
    turkishTitle: 'Egîdê Cimo (1920\'ler–2005)',
    kurmanjContent:
        'Egîdê Cimo (Egîtê Cimo), dengbêjekî Kurmancî ji Ermenistanê.\n'
        'Bavê wî Cimo jî dengbêj bû. Di Radyoya Yêrêvanê de\n'
        'bi dehan kilamên kevn qeyd kirin û şopa xwe li ser\n'
        'arşîva dengbêjiyê hişt.\n\n'
        '★ Kilamên navdar:\n'
        '1. "Siyabend û Xecê" — destana evîna trajîk.\n'
        '2. "Derwêşê Evdî" — destana pêlwanî.\n'
        '3. "Lawikê Metînî" — kilama şer û evînê.',
    turkishContent:
        'Egîdê Cimo (Egîtê Cimo), Ermenistan\'dan bir Kurmancî '
        'dengbêjidir. Babası Cimo da dengbêjdi. Erivan '
        'Radyosu\'nda onlarca eski klamı kaydederek dengbêj '
        'arşivinde iz bıraktı.\n\n'
        '★ Ünlü klamlar:\n'
        '1. "Siyabend û Xecê" — trajik aşk destanı.\n'
        '2. "Derwêşê Evdî" — pehlivanlık destanı.\n'
        '3. "Lawikê Metînî" — savaş ve aşk klamı.',
    backgroundNote:
        'Egîdê Cimo, Sovyet dönemi Ermenistan\'ındaki Kürt '
        'kültürel üretiminin kilit isimlerindendir. Erivan '
        'Radyosu\'nun Kürtçe yayınlarında onlarca saatlik '
        'kayıt bıraktı. Bugün Institut Kurde de Paris ve '
        'Kurdipedia arşivlerinde kayıtları mevcut.',
    level: 3,
    unitId: 'art_singer',
    keywords: ['Egîd', 'Cimo', 'Yêrêvan', 'dengbêj', 'Ermenistan'],
  ),

  // ── s_022: Şeroyê Biro — Yêrêvan Kurd dengbêj ─────────────
  CulturalItem(
    id: 's_022',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Şeroyê Biro (1920s–1990s)',
    turkishTitle: 'Şeroyê Biro (1920\'ler–1990\'lar)',
    kurmanjContent:
        'Şeroyê Biro, dengbêjekî navdar ê Kurmancî bû\n'
        'li Ermenistana Sovyetê. Bi Egîdê Cimo û dengbêjên din\n'
        'li Radyoya Yêrêvanê hevkarî kir û repertuvara kevn\n'
        'parast.\n\n'
        '★ Kilamên navdar:\n'
        '1. "Filîtê Quto" — destana berxwedanê.\n'
        '2. "Siyabend û Xecê" — evîna ji çiyayê Sîpanê.\n'
        '3. "Memê Alan" — destana klasîk.',
    turkishContent:
        'Şeroyê Biro, Sovyet Ermenistanı\'nda tanınmış bir '
        'Kurmancî dengbêjdi. Egîdê Cimo ve diğer dengbêjlerle '
        'Erivan Radyosu\'nda birlikte çalıştı ve eski '
        'repertuvarı korudu.\n\n'
        '★ Ünlü klamlar:\n'
        '1. "Filîtê Quto" — direniş destanı.\n'
        '2. "Siyabend û Xecê" — Süphan Dağı\'ndan bir aşk.\n'
        '3. "Memê Alan" — klasik destan.',
    backgroundNote:
        'Şeroyê Biro, 20. yy Sovyet Ermenistanı\'nın dengbêj '
        'geleneğinin taşıyıcılarındandır. Kayıtları daha sonra '
        'Hasanê Cindî ve Ordîxanê Celîl gibi akademisyenler '
        'tarafından folklor araştırmaları için kullanıldı.',
    level: 3,
    unitId: 'art_singer',
    keywords: ['Şeroyê', 'Biro', 'Yêrêvan', 'dengbêj', 'folklor'],
  ),

  // ── s_023: Reso — dengbêjê kilamên şer ────────────────────
  CulturalItem(
    id: 's_023',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Resoyê Gopalî / Reso Mezin (1902–1982)',
    turkishTitle: 'Resoyê Gopalî (1902–1982)',
    kurmanjContent:
        'Reso, dengbêjekî Kurd ê navdar ji herêma Serhedê bû.\n'
        'Bi dengê xwe yê bilind û hestiyarî, bi taybetî di\n'
        'kilamên şer û qehremanî de ustad bû.\n'
        'Stranên wî bi zimanê gel, şopê li hişmendiya kolektîf\n'
        'hiştin.\n\n'
        '★ Kilamên navdar:\n'
        '1. "Lawikê Qasim" — destana pêlwaniyê.\n'
        '2. "Gozelê" — kilameke delaliyê.\n'
        '3. "Emê Gozê" — evîneke bêserûber.',
    turkishContent:
        'Reso, Serhat bölgesinden tanınmış bir Kürt dengbêjdi.\n'
        'Yüksek ve duyarlı sesiyle, özellikle savaş ve kahramanlık '
        'klamlarının ustasıydı.\n'
        'Halk dilindeki şarkıları kolektif hafızada iz bıraktı.\n\n'
        '★ Ünlü klamlar:\n'
        '1. "Lawikê Qasim" — pehlivanlık destanı.\n'
        '2. "Gozelê" — güzellik klamı.\n'
        '3. "Emê Gozê" — başıboş bir aşk.',
    backgroundNote:
        'Reso (Resoyê Gopalî), Serhat dengbêj okulunun önde '
        'gelenlerinden. Sözlü gelenekte öğrencilerin öğrencileri '
        'hâlâ onun klamlarını icra eder. Şakiro\'nun çağdaşı ve '
        'saygı duyduğu ustadır.',
    level: 3,
    unitId: 'art_singer',
    keywords: ['Reso', 'Gopalî', 'Serhed', 'dengbêj', 'kilamên şer'],
  ),

  // ════════════════════════════════════════════════════════════════
  // FAZ 2 — Stranbêjên zêde (7 nû): klasîk û nûjen, dengbêj û jin
  // ════════════════════════════════════════════════════════════════

  // ── s_022: Reşîdê Baso ─────────────────────────────────────
  CulturalItem(
    id: 's_022',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Reşîdê Baso (1900–1973)',
    turkishTitle: 'Reşîdê Baso (1900-1973)',
    kurmanjContent:
        'Reşîdê Baso, ji dengbêjên klasîk ên Serhed (Wan-Bazîd) e.\n'
        'Yek ji ustadên kevneşopiya dengbêjiyê ya bê amûr e.\n'
        'Bi dengê xwe yê bilind û şîroveya xwe ya hêkdar, sedan\n'
        'kilam û destan parastine.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Heyamo lê" — kilamê dengbêjiyê yê dirêj.\n'
        '2. "Lê dîlberê" — kilama evînê.\n'
        '3. "Filîtê Quto" — versiyona Reşîdê Baso ya destana Botanê.',
    turkishContent:
        'Reşîdê Baso, Serhed (Van-Beyazıt) klasik dengbêjlerindendir.\n'
        'Enstrümansız dengbêj geleneğinin ustalarından.\n'
        'Gür sesi ve duygulu yorumuyla yüzlerce kilam ve destan\n'
        'kaydı altına almıştır.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "Heyamo lê" — uzun dengbêj kilamı.\n'
        '2. "Lê dîlberê" — aşk kilamı.\n'
        '3. "Filîtê Quto" — Botan destanının Reşîdê Baso versiyonu.',
    backgroundNote:
        'Reşîdê Baso, 20. yüzyılın ilk yarısında Wan-Bazid bölgesi '
        'dengbêj geleneğinin temel taşıyıcılarındandır. Kayıtları '
        '1950-60\'larda Sovyet Ermeni Radyosu tarafından alınmış, '
        'Heciyê Cindî tarafından arşivlenmiştir.',
    level: 3,
    unitId: 'art_singer',
    keywords: ['Reşîd', 'Baso', 'Serhed', 'dengbêj', 'klasîk'],
  ),

  // ── s_022: Kawês Aga ───────────────────────────────────────
  CulturalItem(
    id: 's_022',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Kawês Aga (1889–1936)',
    turkishTitle: 'Kawês Aga (1889-1936)',
    kurmanjContent:
        'Kawês Aga, ji dengbêjên klasîk ên Hekarî ye.\n'
        'Bi dengê xwe yê tij, kûr û şîroveya stranan a derûnî,\n'
        'di nav ji jêr-binikiya dengbêjiya Hekarî de bingehek\n'
        'mezin daniye.\n\n'
        '★ Berhemên parastî:\n'
        '1. "Lawkê Metînî" — versiyona Kawês Aga ya çiyayê Metînî.\n'
        '2. "Eyşan û Bezo" — kilama evînê ya Hekarî.\n'
        '3. "Şerê Şemzînan" — kilama dîrokî ya berxwedanê.',
    turkishContent:
        'Kawês Aga, Hakkari klasik dengbêjlerindendir.\n'
        'Boğuk, derin sesi ve şarkıların duygusal yorumuyla\n'
        'Hakkari dengbêj geleneğine büyük bir temel atmıştır.\n\n'
        '★ Korunan eserleri:\n'
        '1. "Lawkê Metînî" — Kawês Aga\'nın Metînî dağı versiyonu.\n'
        '2. "Eyşan û Bezo" — Hakkari aşk kilamı.\n'
        '3. "Şerê Şemzînan" — direnişin tarihi kilamı.',
    backgroundNote:
        'Kawês Aga\'nın kayıtları Roger Lescot tarafından 1930\'larda '
        'Beyrut\'ta toplanmış, "Textes Kurdes" (1942, Paris) '
        'antolojisinde yer almıştır. Çağdaş Hakkari dengbêjliğinin '
        'köşe taşı sayılır.',
    level: 4,
    unitId: 'art_singer',
    keywords: ['Kawês', 'Aga', 'Hekarî', 'Lescot', 'klasîk'],
  ),

  // ── s_023: Beytocan ────────────────────────────────────────
  CulturalItem(
    id: 's_023',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Beytocan (1962–2021)',
    turkishTitle: 'Beytocan (1962-2021)',
    kurmanjContent:
        'Beytocan, navê stranbêjekî nûjen ê Botanî ye.\n'
        'Ji Cizîrê hatibû dinyayê. Bi dengê xwe yê dilrast û\n'
        'tarza dengbêjî ya nûjen, di salên 1990 û 2000î de\n'
        'beşek mezin a guhdarên Kurd qezenc kir.\n\n'
        '★ Stranên navdar:\n'
        '1. "Kebaniya min" — kilama evîna jinê.\n'
        '2. "Ax dayê" — bi yadê re govend.\n'
        '3. "Welatê min" — sembola welatperweriyê.',
    turkishContent:
        'Beytocan, modern Botani şarkıcılardandır.\n'
        'Cizre\'de doğmuştur. Samimi sesi ve modern dengbêj\n'
        'tarzıyla 1990 ve 2000\'lerde Kürt dinleyicilerinin\n'
        'önemli bir kısmını kazandı.\n\n'
        '★ Ünlü şarkıları:\n'
        '1. "Kebaniya min" — kadın aşkı kilamı.\n'
        '2. "Ax dayê" — anne özlemi halayı.\n'
        '3. "Welatê min" — vatan sevgisi sembolü.',
    backgroundNote:
        'Beytocan, modern dengbêj tarzının önemli temsilcilerinden '
        'biri olarak Şivan Perwer\'den sonraki nesli temsil etti. '
        '2021\'de hayatını kaybetti; cenazesinde binlerce hayranı '
        'toplandı.',
    level: 3,
    unitId: 'art_singer',
    keywords: ['Beytocan', 'Cizîr', 'nûjen', 'dengbêj', 'Botan'],
  ),

  // ── s_024: Hozan Mizgîn ────────────────────────────────────
  CulturalItem(
    id: 's_024',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Hozan Mizgîn (j.d. 1968)',
    turkishTitle: 'Hozan Mizgîn (d. 1968)',
    kurmanjContent:
        'Hozan Mizgîn, stranbêjeke jin a nûjen e ji Hekarî.\n'
        'Bi dengê xwe yê germ û berhemên xwe yên evînî,\n'
        'di nav stranbêjên jin ên paşê yên Şivan Perwer û\n'
        'Aynur Doganê de cîhek girîng girtiye.\n\n'
        '★ Stranên navdar:\n'
        '1. "Lê dîlberê" — kilama evînê ya nûjen.\n'
        '2. "Were keçê" — bangewazî bo dîlanê.\n'
        '3. "Bûka biharê" — strana cejna baharê.',
    turkishContent:
        'Hozan Mizgîn, Hakkari\'den modern bir kadın şarkıcıdır.\n'
        'Sıcak sesi ve aşk şarkılarıyla Şivan Perwer ve Aynur\n'
        'Doğan\'ın ardından gelen kuşak kadın şarkıcıları\n'
        'arasında önemli bir yer almıştır.\n\n'
        '★ Ünlü şarkıları:\n'
        '1. "Lê dîlberê" — modern aşk kilamı.\n'
        '2. "Were keçê" — düğüne çağrı.\n'
        '3. "Bûka biharê" — bahar bayramı şarkısı.',
    backgroundNote:
        'Hozan Mizgîn, modern Kürt müziğinde kadın seslerinin '
        'çoğalmasına katkı yapmıştır. Avrupa diasporasında konser '
        'turneleri yapar; Kurmancî dilinin görünürlüğüne katkı '
        'sağlar.',
    level: 3,
    unitId: 'art_singer',
    keywords: ['Hozan Mizgîn', 'jin', 'Hekarî', 'nûjen', 'evîn'],
  ),

  // ── s_025: Diyar Dersim ────────────────────────────────────
  CulturalItem(
    id: 's_025',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Diyar Dersim (j.d. 1966)',
    turkishTitle: 'Diyar Dersim (d. 1966)',
    kurmanjContent:
        'Diyar Dersim, navê hunerî yê stranbêjekî Kurd-Elewî ye.\n'
        'Ji Dêrsimê (Tunceli) hatiye dinyayê. Stranên xwe yên\n'
        'Kurmancî, Zazakî û Kirmanckî bi awayekî sentetîk\n'
        'pêşkêş dike.\n\n'
        '★ Stranên navdar:\n'
        '1. "Dêrsim Dêrsim" — strana welatê xwe.\n'
        '2. "Lo lo birayê min" — kilama bira-bûnê.\n'
        '3. "Kemalê Pîr" — kilama bîranînê.',
    turkishContent:
        'Diyar Dersim, Kürt-Alevi bir şarkıcının sahne adıdır.\n'
        'Dersim\'de (Tunceli) doğmuştur. Kurmancî, Zazaca ve\n'
        'Kirmanckî şarkılarını sentezci bir tarzla sunar.\n\n'
        '★ Ünlü şarkıları:\n'
        '1. "Dêrsim Dêrsim" — vatan şarkısı.\n'
        '2. "Lo lo birayê min" — kardeşlik kilamı.\n'
        '3. "Kemalê Pîr" — anma kilamı.',
    backgroundNote:
        'Diyar Dersim, Kürt-Alevi kimliğinin şarkıdaki temsilcisidir. '
        'Çok-dillilik (Kurmancî+Zazaca) yaklaşımıyla modern Kürt '
        'müziğinde özgün bir yer tutar.',
    level: 3,
    unitId: 'art_singer',
    keywords: ['Diyar Dersim', 'Dêrsim', 'elewî', 'Zazakî', 'sentez'],
  ),

  // ── s_026: Şehrîbana Kurdî ─────────────────────────────────
  CulturalItem(
    id: 's_026',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Şehrîbana Kurdî (j.d. 1955)',
    turkishTitle: 'Şehrîbana Kurdî (d. 1955)',
    kurmanjContent:
        'Şehrîbana Kurdî, stranbêjeke jin a kevneşop û nûjen e\n'
        'ji Mêrdînê. Bi dengê xwe yê germ û şîroveya kilamên\n'
        'klasîk, hem mîrasê dengbêjiyê parastiye hem nûjeniya\n'
        'wê pêşkêş kiriye.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Yêmen yêmen" — kilama dûriya welêt.\n'
        '2. "Hayno" — kilama jinê di şer de.\n'
        '3. "Lê dayê" — bi yadê re — sembola koçberiyê.',
    turkishContent:
        'Şehrîbana Kurdî, Mardin\'den geleneksel ve modern bir\n'
        'kadın şarkıcıdır. Sıcak sesi ve klasik kilamları\n'
        'yorumlamasıyla hem dengbêj mirasını korumuş hem de\n'
        'modernleştirmiştir.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "Yêmen yêmen" — vatan özlemi kilamı.\n'
        '2. "Hayno" — savaşta kadın kilamı.\n'
        '3. "Lê dayê" — anne özlemi — göçmenliğin sembolü.',
    backgroundNote:
        'Şehrîbana Kurdî, 1980\'lerden beri Avrupa\'da yaşar, '
        'Kurmancî ve Soranî repertuvarını birleştirir. Klasik '
        'kilamları modern çalgılarla yorumlayarak yeni nesle '
        'aktarır.',
    level: 3,
    unitId: 'art_singer',
    keywords: ['Şehrîbana', 'Mêrdîn', 'jin', 'klasîk', 'koçberî'],
  ),

  // ── s_027: Salihê Qubînî ───────────────────────────────────
  CulturalItem(
    id: 's_027',
    type: CulturalContentType.singer,
    kurmanjTitle: 'Salihê Qubînî (1908–1985)',
    turkishTitle: 'Salihê Qubînî (1908-1985)',
    kurmanjContent:
        'Salihê Qubînî, ji dengbêjên klasîk ên Hekarî-Çolemêrgê ye.\n'
        'Sedsala xwe ya 20\'î yek ji ustadên dengbêjiya bê amûr\n'
        'bû. Sedan kilam û destan parastiye.\n\n'
        '★ Berhemên parastî:\n'
        '1. "Lê dilberê" — kilama klasîk a evînê.\n'
        '2. "Şerê Botanê" — destana dîrokî.\n'
        '3. "Hesoyê Hêsenan" — kilama eşîretî.',
    turkishContent:
        'Salihê Qubînî, Hakkari-Çukurca klasik dengbêjlerindendir.\n'
        'Yüzyılında enstrümansız dengbêjlik ustalarından biriydi.\n'
        'Yüzlerce kilam ve destan kaydetmiştir.\n\n'
        '★ Korunan eserleri:\n'
        '1. "Lê dilberê" — klasik aşk kilamı.\n'
        '2. "Şerê Botanê" — tarihi destan.\n'
        '3. "Hesoyê Hêsenan" — aşiret kilamı.',
    backgroundNote:
        'Salihê Qubînî\'nin kayıtları 1970\'lerde Sovyet Ermenistan '
        'Radyosu ve Diyarbakır radyosu tarafından alınmıştır. Şakiro '
        've Mihemed Arif Cizrawî üzerinde önemli bir etki '
        'bırakmıştır.',
    level: 4,
    unitId: 'art_singer',
    keywords: ['Salihê Qubînî', 'Hekarî', 'klasîk', 'dengbêj', 'kilam'],
  ),
];

// ────────────────────────────────────────────────────────────────
// HELBESTVAN (Şairler) — 12 figür × 1-2 şiir alıntısı
// ────────────────────────────────────────────────────────────────

const kKurdishPoets = <CulturalItem>[
  CulturalItem(
    id: 'p_001',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Ehmedê Xanî (1651–1707)',
    turkishTitle: 'Ehmedê Xanî (1651–1707)',
    kurmanjContent:
        'Ji Hekarî, helbestvanê herî mezin ê edebiyata Kurmancî.\n'
        'Berhema wî "Mem û Zîn" (1695) destana neteweyî ye.\n\n'
        '★ Ji "Mem û Zîn":\n'
        '"Ger me yekîtî bicîh bikira,\n'
        'Yekî ji me bibûya serdar û pêşeng,\n'
        'Em ê bibana xwedî tac û text,\n'
        'Tu mîr û şah ji dor wan dernedikan."',
    turkishContent:
        'Hakkari kökenli; Kurmancî edebiyatının en büyük şairi.\n'
        'Eseri "Mem û Zîn" (1695) ulusal destandır.\n\n'
        '★ "Mem û Zîn"den:\n'
        '"Eğer birliği kursaydık,\n'
        'Bizden biri önder ve baş olsaydı,\n'
        'Tac ve taht sahibi olurduk,\n'
        'Hiçbir bey ve şah karşımızda duramazdı."',
    backgroundNote:
        '"Mem û Zîn" Kürt Romeo ve Juliet\'i sayılır. Xanî bu eserle '
        'sadece bir aşk hikâyesi değil, siyasi-ulusal bir manifesto da yazdı. '
        'Önsözündeki "yekîtî" (birlik) çağrısı Kürt siyasi düşüncesinin temelidir.',
    level: 3,
    unitId: 'art_poet',
    keywords: ['Xanî', 'Mem û Zîn', 'yekîtî', 'destan', 'Hekarî'],
  ),

  CulturalItem(
    id: 'p_002',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Melayê Cizîrî (1570–1640)',
    turkishTitle: 'Melayê Cizîrî (1570–1640)',
    kurmanjContent:
        'Ji Cizîrê (Botan), helbestvanê mezin ê tasewifî.\n'
        'Bi "Dîwan"a xwe ya Kurmancî, edebiyata mîstîk damezirand.\n\n'
        '★ Ji "Dîwan":\n'
        '"Ev dilê min ê mecruh, gulistana wê ye,\n'
        'Tê de bilbil dixwînin, sersala wê ye.\n'
        'Hubba dilberê min ev tu sirra Xwedê,\n'
        'Roniya çavên min, bihar û hewa ye."',
    turkishContent:
        'Cizre (Botan) kökenli; büyük tasavvuf şairi.\n'
        'Kurmancî "Dîwan"ı ile mistik edebiyatı kurdu.\n\n'
        '★ "Dîwan"dan:\n'
        '"Bu yaralı gönlüm onun gül bahçesidir,\n'
        'İçinde bülbüller okur, onun bahar başıdır.\n'
        'Sevgilime aşk Tanrı\'nın gizli bir sırrı,\n'
        'Gözümün ışığı, bahar ve hava."',
    backgroundNote:
        'Melayê Cizîrî, Kurmancî klasik şiirinin atasıdır. '
        'Mevlana ve Hafız geleneğine paralel bir mistisizmle '
        'aşk-Tanrı temalarını işler. Dîwanı 2000+ beyit içerir.',
    level: 3,
    unitId: 'art_poet',
    keywords: ['Cizîrî', 'Dîwan', 'tasewif', 'mîstîk', 'Botan'],
  ),

  CulturalItem(
    id: 'p_003',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Feqiyê Teyran (1590–1632)',
    turkishTitle: 'Feqiyê Teyran (1590–1632)',
    kurmanjContent:
        'Ji Hekarî, helbestvan û muteseuwifekî navdar.\n'
        '"Feqîyê Teyran" tê wateya "fekîhê balindeyan".\n\n'
        '★ Ji "Şêxê Sen\'an":\n'
        '"Ez im evdê dilberê,\n'
        'Bê wê ez im sergerdan.\n'
        'Çavê min li riya wê ne,\n'
        'Dilê min ji bo wê pêketî."',
    turkishContent:
        'Hakkari kökenli; tanınmış şair ve mutasavvıf.\n'
        '"Feqiyê Teyran" "kuşların fakihi" demektir.\n\n'
        '★ "Şêxê Sen\'an"dan:\n'
        '"Sevgilinin kuluyum,\n'
        'O olmadan yolumu kaybetmişim.\n'
        'Gözüm onun yolunda,\n'
        'Gönlüm onun için yanmış."',
    backgroundNote:
        '"Şêxê Sen\'an" — Şeyh San\'an destanı — Kürt edebiyatının '
        'en bilinen mistik manzumelerindendir. Şair, doğa ve hayvanlarla '
        'kurduğu derin ilişkiyle "kuşların dilini bilen" lakabını almıştır.',
    level: 3,
    unitId: 'art_poet',
    keywords: ['Feqî', 'Teyran', 'Şêxê Senan', 'mîstîk', 'Hekarî'],
  ),

  CulturalItem(
    id: 'p_004',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Ali Herîrî (sedsala 11–12)',
    turkishTitle: 'Ali Heriri (11.–12. yüzyıl)',
    kurmanjContent:
        'Ji Herîrê (li deverên Behdînan).\n'
        'Yek ji yekem helbestvanên Kurdî yên ku navê wî gihîştiye îro.\n\n'
        '★ Helbestek (kurte):\n'
        '"Ezê biçim li ber pencerê,\n'
        'Çavên xwe bidim asîman.\n'
        'Belkî yarê min bibîne,\n'
        'Dengê min bibihîse li ezman."',
    turkishContent:
        'Heriri (Behdinan bölgesi) kökenlidir.\n'
        'Adı bugüne ulaşan ilk Kürt şairlerinden biridir.\n\n'
        '★ Şiirinden (kısa):\n'
        '"Pencerenin önüne gideceğim,\n'
        'Gözlerimi göğe vereceğim.\n'
        'Belki yârim beni görür,\n'
        'Sesimi gökyüzünde işitir."',
    backgroundNote:
        'Ali Herîrî, Kürt edebiyat tarihinin "kurucu atalarından" sayılır. '
        'Hakkında elimizde fazla biyografik bilgi olmasa da yazılı Kurmancî şiirin '
        'en eski örneklerinden bazıları ona atfedilir.',
    level: 3,
    unitId: 'art_poet',
    keywords: ['Ali', 'Herîrî', 'klasîk', 'Behdînan'],
  ),

  CulturalItem(
    id: 'p_005',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Cegerxwîn (1903–1984)',
    turkishTitle: 'Cegerxwîn (1903–1984)',
    kurmanjContent:
        'Ji Hesarî (Mêrdîn), helbestvanê neteweyî yê modern.\n'
        'Navê wî yê esil "Şêxmûs Hesen" e.\n\n'
        '★ Ji "Kîme Ez":\n'
        '"Kîme ez? Kurd im, ez Kurd im,\n'
        'Welatê min Kurdistan e.\n'
        'Zimanê min Kurdî ye,\n'
        'Êdî bes e şerm û nefret im."',
    turkishContent:
        'Hesar (Mardin) kökenli, modern ulusal şair.\n'
        'Asıl adı "Şêxmûs Hesen"dir.\n\n'
        '★ "Kîme Ez"den:\n'
        '"Ben kimim? Kürt\'üm, Kürt\'üm,\n'
        'Vatanım Kürdistan\'dır.\n'
        'Dilim Kürtçedir,\n'
        'Artık utanç ve nefret bana yeter."',
    backgroundNote:
        '"Cegerxwîn" "ciğeri yanık" demektir. Cegerxwîn modern Kurmancî '
        'şiirin kurucu babasıdır. Söz dağarcığını sadeleştirmiş, halkın anladığı '
        'dille milli ve toplumsal şiirler yazmıştır.',
    level: 3,
    unitId: 'art_poet',
    keywords: ['Cegerxwîn', 'Kîme Ez', 'modern', 'neteweyî', 'Mêrdîn'],
  ),

  CulturalItem(
    id: 'p_006',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Hejar Mukriyanî (1920–1991)',
    turkishTitle: 'Hejar Mukriyanî (1920–1991)',
    kurmanjContent:
        'Ji Mihabadê (Rojhilatê Kurdistanê).\n'
        'Helbestvan, ferhengnivîs û wergêr e.\n'
        'Ji Soranî diaxive lê Kurmancî jî dipejirand û dipeyivî.\n\n'
        '★ Ji helbesteke wî:\n'
        '"Ez ne dewlemend im, ne hejar im,\n'
        'Ez ji vî welatî dilê xwe danî.\n'
        'Ev welatê min e, ev gel ê min e,\n'
        'Tevî her tiştê hatiye serê me."',
    turkishContent:
        'Mahabad (Doğu Kürdistan) kökenlidir.\n'
        'Şair, sözlükçü ve çevirmendir.\n'
        'Sorani ile yazdı ama Kurmancî de bilirdi.\n\n'
        '★ Bir şiirinden:\n'
        '"Ne zenginim, ne yoksulum,\n'
        'Bu vatana gönlümü verdim.\n'
        'Bu benim vatanım, bu benim halkım,\n'
        'Başımıza gelen her şeye rağmen."',
    backgroundNote:
        'Hejar, "Henbane Borîne" sözlüğüyle Kürt sözlük çalışmalarına '
        'temel attı. Hayyam\'ın Rubaileri\'ni de Kürtçeye çevirdi. '
        'Sorani-Kurmancî köprüsünün önemli bir ismidir.',
    level: 4,
    unitId: 'art_poet',
    keywords: ['Hejar', 'Mukriyanî', 'Mihabad', 'ferheng', 'Soranî'],
  ),

  CulturalItem(
    id: 'p_007',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Hemîn Mukriyanî (1921–1986)',
    turkishTitle: 'Hemîn Mukriyanî (1921–1986)',
    kurmanjContent:
        'Birayê Hejar, helbestvanê Mihabadê yê navdar.\n'
        'Stranên welatperwerî û romantîk nivîsîn.\n\n'
        '★ Ji helbesteke wî:\n'
        '"Bihar hat, lê dilê min sar e,\n'
        'Çiyayên welatê min hîn berf in.\n'
        'Ez li hêviya rojeke ronî me —\n'
        'Roja ku gelê min azad bibe."',
    turkishContent:
        'Hejar\'ın kardeşi; Mahabad\'ın tanınmış şairi.\n'
        'Vatansever ve romantik şiirler yazdı.\n\n'
        '★ Bir şiirinden:\n'
        '"Bahar geldi, fakat gönlüm soğuk,\n'
        'Vatanımın dağları hâlâ karlıdır.\n'
        'Aydınlık bir günü beklemekteyim —\n'
        'Halkımın özgür olacağı günü."',
    backgroundNote:
        'Hemîn ve Hejar kardeşler birlikte Mahabad Cumhuriyeti döneminin '
        'kültürel atmosferinde yetişti. Hemîn\'in şiirleri lirik soyluluğuyla '
        'tanınır ve Sorani edebiyatının klasiklerindendir.',
    level: 4,
    unitId: 'art_poet',
    keywords: ['Hemîn', 'Mukriyanî', 'Mihabad', 'lîrîk'],
  ),

  CulturalItem(
    id: 'p_008',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Abdulla Peşêw (j.d. 1946)',
    turkishTitle: 'Abdulla Peşêw (d. 1946)',
    kurmanjContent:
        'Ji Hewlêrê (Başûrê Kurdistanê).\n'
        'Yek ji helbestvanên hevçax ên herî navdar.\n'
        'Bi Soranî dinivîsîne lê berhemên wî bo Kurmancî hatine wergerandin.\n\n'
        '★ Helbestek wî (werger):\n'
        '"Ez nehatime ku te bibim,\n'
        'Ez hatime ku xwe bibînim.\n'
        'Ez hatime ku ji nû ve\n'
        'Pirsên xwe yên kevn bipirsim."',
    turkishContent:
        'Erbil (Güney Kürdistan) kökenlidir.\n'
        'Çağdaş Kürt şiirinin en tanınan isimlerinden biridir.\n'
        'Sorani yazar, eserleri Kurmancî\'ye çevrildi.\n\n'
        '★ Şiirinden (çeviri):\n'
        '"Seni almaya gelmedim,\n'
        'Kendimi görmeye geldim.\n'
        'Yeniden eski sorularımı\n'
        'sormaya geldim."',
    backgroundNote:
        'Peşêw, modern Kürt şiirinin en yaygın çevrilen isimlerinden biridir. '
        'Şiirleri 25\'ten fazla dile çevrildi. Halen Finlandiya\'da yaşamaktadır.',
    level: 4,
    unitId: 'art_poet',
    keywords: ['Peşêw', 'Hewlêr', 'modern', 'Soranî'],
  ),

  CulturalItem(
    id: 'p_009',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Berken Bereh (j.d. 1954)',
    turkishTitle: 'Berken Bereh (d. 1954)',
    kurmanjContent:
        'Ji Mêrdînê, helbestvanê Kurmancî yê hevçax.\n'
        'Ji 1980\'an de bi mehkemane bi Kurmancî dinivîsîne.\n\n'
        '★ Ji "Bûka Baranê":\n'
        '"Hêdî hêdî tê reş dibe esman,\n'
        'Bûka baranê ji ezman dadikeve.\n'
        'Ax û ax ji bin baranê dipirise:\n'
        'Ev kîjan deşt e, ev kîjan welat e?"',
    turkishContent:
        'Mardin kökenli, çağdaş Kurmancî şair.\n'
        '1980\'lerden beri kararlılıkla Kurmancî yazıyor.\n\n'
        '★ "Bûka Baranê"den:\n'
        '"Yavaş yavaş gökyüzü kararıyor,\n'
        'Yağmurun gelini gökten iniyor.\n'
        'Toprak yağmurun altında soruyor:\n'
        'Bu hangi ova, bu hangi vatandır?"',
    backgroundNote:
        'Berken Bereh, modern Kurmancî şiirinin sadelik ve görsel '
        'imge zenginliği ile tanınan bir sesidir. "Bûka Baranê" (Yağmurun Gelini) '
        'en bilinen şiir derlemesidir.',
    level: 4,
    unitId: 'art_poet',
    keywords: ['Berken', 'Bereh', 'baran', 'modern', 'Mêrdîn'],
  ),

  CulturalItem(
    id: 'p_010',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Arjen Arî (1956–2012)',
    turkishTitle: 'Arjen Arî (1956–2012)',
    kurmanjContent:
        'Ji Batmanê. Yek ji helbestvanên hevçax\n'
        'ku bi Kurmancî helbestên civakî nivîsîn.\n\n'
        '★ Ji helbesteke wî:\n'
        '"Min ji te tenê peyvek xwest,\n'
        'Te jî ew peyv ji min veşart.\n'
        'Niha ez bi bêdengî dipeyivim,\n'
        'Bêdengiya min jî tu dibihîzî."',
    turkishContent:
        'Batman kökenli; Kurmancî yazan toplumsal\n'
        'duyarlılığı yüksek çağdaş şairlerdendir.\n\n'
        '★ Şiirinden:\n'
        '"Senden sadece bir söz istedim,\n'
        'Sen o sözü de benden gizledin.\n'
        'Şimdi sessizlikle konuşuyorum,\n'
        'Sessizliğimi de duyuyorsun."',
    backgroundNote:
        'Arjen Arî, modern Kurmancî şiirinin çağdaş kuşağında '
        'sadece dilsel değil aynı zamanda toplumsal tema duyarlılığıyla '
        'öne çıkmıştır. Çok genç yaşta hayatını kaybetti.',
    level: 4,
    unitId: 'art_poet',
    keywords: ['Arjen', 'Arî', 'Batman', 'modern', 'civakî'],
  ),

  CulturalItem(
    id: 'p_011',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Rojen Barnas (j.d. 1945)',
    turkishTitle: 'Rojen Barnas (d. 1945)',
    kurmanjContent:
        'Ji Diyarbekirê (Amed). Helbestvan û nivîskar.\n'
        'Yek ji ronakbîrên Kurmancî yê piştî 1960\'î.\n\n'
        '★ Ji helbesteke wî:\n'
        '"Bajarê min, bajarê min,\n'
        'Suriyên te kevn in, lê dilê te ciwan e.\n'
        'Ez li ser wan keviran rûniştime,\n'
        'Min dîroka te di kevirên te de xwendiye."',
    turkishContent:
        'Diyarbakır (Amed) kökenli; şair ve yazar.\n'
        '1960 sonrası Kurmancî aydınlardandır.\n\n'
        '★ Şiirinden:\n'
        '"Şehrim, şehrim,\n'
        'Surların eskidir, fakat gönlün gençtir.\n'
        'O taşların üzerinde oturdum,\n'
        'Tarihini taşlarında okudum."',
    backgroundNote:
        'Rojen Barnas, sürgün edebiyatının ve Kurmancî nesir-şiir '
        'arakesitinin önemli bir ismidir. İsveç\'te uzun yıllar yaşadı '
        've Kürt diaspora edebiyatına katkıda bulundu.',
    level: 4,
    unitId: 'art_poet',
    keywords: ['Rojen', 'Barnas', 'Amed', 'Suriyê', 'modern'],
  ),

  CulturalItem(
    id: 'p_012',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Osman Sebrî (1905–1993)',
    turkishTitle: 'Osman Sebrî (1905–1993)',
    kurmanjContent:
        'Ji Diyarbekirê. Helbestvan, lêkolîner û çalakvan.\n'
        'Bi Hawarê re hevkar bû, hevalê Celadet Bedirxan bû.\n\n'
        '★ Ji helbesteke wî:\n'
        '"Em ji vê axê hatine derketin,\n'
        'Lê ev ax di nav me de ye.\n'
        'Em ku diçin, axa Kurdistan\n'
        'Pê re diçin, di hindurê me de."',
    turkishContent:
        'Diyarbakır kökenli; şair, araştırmacı ve aktivisttir.\n'
        'Hawar dergisinin yazarlarından, Celadet Bedirhan\'ın yoldaşıdır.\n\n'
        '★ Şiirinden:\n'
        '"Bu topraktan çıkarıldık,\n'
        'Fakat bu toprak içimizdedir.\n'
        'Nereye gitsek, Kürdistan toprağı\n'
        'bizimle birlikte gider, içimizde."',
    backgroundNote:
        'Osman Sebrî, Hawar kuşağının önemli bir kalemidir. '
        'Hayatının büyük bölümünü Şam\'da sürgünde geçirdi. '
        'Anıları Kürt edebiyat tarihçiliği için temel kaynak sayılır.',
    level: 4,
    unitId: 'art_poet',
    keywords: ['Osman', 'Sebrî', 'Hawar', 'Şam', 'Amed'],
  ),

  // ════════════════════════════════════════════════════════════════
  // FAZ 2 — Helbestvanên zêde (10 nû): klasîk, Soranî, modern û jin
  // ════════════════════════════════════════════════════════════════

  // ── p_013: Goran (Abdulla Goran) ──────────────────────────
  CulturalItem(
    id: 'p_013',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Goran — Abdulla Goran (1904–1962)',
    turkishTitle: 'Goran — Abdulla Goran (1904-1962)',
    kurmanjContent:
        'Goran (navê wî yê tam: Abdulla Sileymanê Goran), bavê\n'
        'helbesta nûjen a Soranî tê hesibîn. Ji Helebceyê hatibû\n'
        'dinyayê. Bi şikandina formên klasîk ên dîwanê û bikaranîna\n'
        'zimanê gel, helbesta Kurd ber bi modernîteyê ve bir.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Beheşt û Bîranîn" (1950) — koleksîyona helbestên\n'
        '   modernîst.\n'
        '2. "Firmêsk û Hunêr" (1949) — helbestên rexnegirî.\n'
        '3. "Lawik û Sirûd" — helbestên gelêrî yên nûjen.',
    turkishContent:
        'Goran (tam adı: Abdullah Süleyman Goran), modern Soranî\n'
        'şiirinin babası sayılır. Halepçe\'de doğmuştur. Klasik\n'
        'divan formlarını kırarak halk dilini kullanmasıyla Kürt\n'
        'şiirini moderniteye taşıdı.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "Beheşt û Bîranîn" (1950) — modernist şiir koleksiyonu.\n'
        '2. "Firmêsk û Hunêr" (1949) — eleştirel şiirler.\n'
        '3. "Lawik û Sirûd" — modern halk şiirleri.',
    backgroundNote:
        'Goran, Soranî için 20. yüzyılın en etkili şairi olarak '
        'kabul edilir. Eserlerinde aşk, sosyal eleştiri ve modern '
        'imgeler iç içedir. Şêrko Bêkes ve Bextiyar Elî gibi '
        'sonraki kuşakları doğrudan etkilemiştir.',
    level: 4,
    unitId: 'art_poet',
    keywords: ['Goran', 'Soranî', 'modern', 'Helebce', 'helbest'],
  ),

  // ── p_014: Mela Mehmûdê Beyazîdî ──────────────────────────
  CulturalItem(
    id: 'p_014',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Mela Mehmûdê Beyazîdî (1797–1867)',
    turkishTitle: 'Mela Mahmud Beyazidi (1797-1867)',
    kurmanjContent:
        'Mela Mehmûdê Beyazîdî, ji ulema û nivîskarên klasîk ên\n'
        'Kurdistanê ye. Ji Bazîdê (Doğubeyazıt) hatibû dinyayê. Hem\n'
        'helbest, hem prozra çand-folklorîk nivîsîye.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Adat û Rusûmatnameê Ekradiyye" (1858) — pirtûka\n'
        '   yekem a etnografya Kurd. Wêneya çand û adetên Kurdan\n'
        '   ya wê dema.\n'
        '2. "Tewarîxê Cedîdê Kurdistan" — dîroka Kurdistanê.\n'
        '3. Wergerandina Şerefnameyê ji Farisî bo Kurmancî.',
    turkishContent:
        'Mela Mahmud Beyazidi, klasik Kürdistan ulema ve\n'
        'yazarlarındandır. Doğubeyazıt\'ta doğmuştur. Hem şiir, hem\n'
        'kültür-folklorik düzyazı yazmıştır.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "Adat û Rusûmatnameê Ekradiyye" (1858) — Kürt etnografisi\n'
        '   üzerine ilk kitap. O dönemin Kürt kültür ve adetlerinin\n'
        '   tablosu.\n'
        '2. "Tewarîxê Cedîdê Kurdistan" — Kürdistan tarihi.\n'
        '3. Şerefname\'nin Farsça\'dan Kurmancî\'ye çevirisi.',
    backgroundNote:
        '"Adat û Rusûmatnameê Ekradiyye" 1858\'de Rus oryantalist '
        'Auguste Jaba\'nın talebi üzerine yazıldı. Petersburg arşivinde '
        'el yazması korunmaktadır. Modern Kürt etnografisinin '
        'kaynaklarındandır.',
    level: 4,
    unitId: 'art_poet',
    keywords: ['Mela Mehmûd', 'Beyazîdî', 'etnografya', 'Adat', 'Bazîd'],
  ),

  // ── p_015: Şex Reza Talebanî ──────────────────────────────
  CulturalItem(
    id: 'p_015',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Şex Reza Talebanî (1837–1910)',
    turkishTitle: 'Şeyh Rıza Talebani (1837-1910)',
    kurmanjContent:
        'Şex Reza Talebanî, helbestvanê Soranî yê hicwê û hejaweyê\n'
        'navdar e. Ji eşîreta Talebanan a Kerkukê. Bi gotinên xwe\n'
        'yên hejaweyî, mîr û şêxên zalim rexne kirine.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Hicwê" — koleksiyona helbestên hejaweyî.\n'
        '2. "Şîîr û Bend" — helbestên klasîk ên evînê.\n'
        '3. Helbestên di nav Dîwanê de — şîroveya bi zimanê gel.',
    turkishContent:
        'Şeyh Rıza Talebani, ünlü hicvi ve nükteci Soranî\n'
        'şairidir. Kerkük Talebani aşiretindendir. Nükteli\n'
        'sözleriyle zalim mîrekleri ve şeyhleri eleştirmiştir.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "Hicwê" — hicvi şiir koleksiyonu.\n'
        '2. "Şîîr û Bend" — klasik aşk şiirleri.\n'
        '3. Divan içindeki şiirler — halk diliyle yorum.',
    backgroundNote:
        'Şex Reza Talebanî, klasik Kürt edebiyatında hiciv geleneğinin '
        'son büyük temsilcisidir. Soranî modern şiir akımına geçişi '
        'sembolize eder. Kerkük\'te mezarı ziyaretgâhtır.',
    level: 4,
    unitId: 'art_poet',
    keywords: ['Şex Reza', 'Talebanî', 'hicw', 'Kerkuk', 'Soranî'],
  ),

  // ── p_016: Heciyê Cindî ───────────────────────────────────
  CulturalItem(
    id: 'p_016',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Heciyê Cindî (1908–1990)',
    turkishTitle: 'Heciyê Cindî (1908-1990)',
    kurmanjContent:
        'Heciyê Cindî, helbestvan û folklorzanê Kurd ê Sovyet\n'
        'Ermenistanê ye. Yek ji bingehkarên edebiyata Kurmancî ya\n'
        'nûjen a Sovyet bû. Hem helbest, hem berhevkirina folklorê\n'
        'kir.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Folklora Kurdî" (1957) — antolojiya yekem a folklora\n'
        '   Kurd. 600 rûpel — çîrok, gotinên pêşiyan, destan.\n'
        '2. "Hewarî" (1967) — koleksîyona helbestên xwe.\n'
        '3. "Edebiyata Kurdî ya Sovyetê" — wek perwerdekar nivîsî.',
    turkishContent:
        'Heciyê Cindî, Sovyet Ermenistanlı Kürt şair ve folklorcudur.\n'
        'Sovyet modern Kurmancî edebiyatının temel kurucularından\n'
        'biridir. Hem şiir yazmış, hem folklor derlemiştir.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "Folklora Kurdî" (1957) — Kürt folkloru ilk antolojisi.\n'
        '   600 sayfa — hikâye, atasözü, destan.\n'
        '2. "Hewarî" (1967) — kendi şiir koleksiyonu.\n'
        '3. "Sovyet Kürt Edebiyatı" — pedagog olarak yazdı.',
    backgroundNote:
        'Heciyê Cindî\'nin "Folklora Kurdî" eseri Sovyet Kürtçesi '
        'standardının temel taşıdır. Bugün araştırmacılar onun '
        'arşivinden Ferxendê, Eyşan û Bezo gibi destanları yeniden '
        'keşfetmektedir.',
    level: 4,
    unitId: 'art_poet',
    keywords: ['Heciyê Cindî', 'folklor', 'Sovyet', 'Yêrêvan', 'antolojî'],
  ),

  // ── p_017: Lal Laleş ──────────────────────────────────────
  CulturalItem(
    id: 'p_017',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Lal Laleş (j.d. 1975)',
    turkishTitle: 'Lal Laleş (d. 1975)',
    kurmanjContent:
        'Lal Laleş, helbestvan û çapxaneya Kurmancî ya nûjen e.\n'
        'Ji Çolemêrgê (Hakkari) hatibû dinyayê. Yek ji dengên\n'
        'feministen serdest yên helbesta Kurmancî ye.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Berbejna Sêvê" (2003) — koleksîyona yekem a helbestê.\n'
        '2. "Tasa Bûka Baranê" (2007) — helbestên feminîst.\n'
        '3. "Şahmaran" (2014) — destana mîtolojîk a nûjen kirin.',
    turkishContent:
        'Lal Laleş, modern bir Kurmancî şair ve yayıncıdır.\n'
        'Hakkari\'de doğmuştur. Modern Kurmancî şiirinin önde gelen\n'
        'feminist seslerinden biridir.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "Berbejna Sêvê" (2003) — ilk şiir koleksiyonu.\n'
        '2. "Tasa Bûka Baranê" (2007) — feminist şiirler.\n'
        '3. "Şahmaran" (2014) — modernize edilmiş mitolojik destan.',
    backgroundNote:
        'Lal Laleş, "Lîs Yayınevi"nin (Diyarbekir) kurucularındandır. '
        'Modern Kurmancî yayıncılığında öncü bir rol oynar; '
        'kadın yazarların görünürlüğüne katkı sağlar.',
    level: 3,
    unitId: 'art_poet',
    keywords: ['Lal Laleş', 'jin', 'feminîst', 'Lîs', 'nûjen'],
  ),

  // ── p_018: Bekes ──────────────────────────────────────────
  CulturalItem(
    id: 'p_018',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Bekes — Faiq Bekes (1905–1948)',
    turkishTitle: 'Bekes — Faik Bekes (1905-1948)',
    kurmanjContent:
        'Bekes (navê wî yê tam: Faiq Bekes), ji helbestvanên\n'
        'klasîk ên Soranî ye. Ji Silêmaniyê hatibû dinyayê. Bi\n'
        'helbestên welatperwerî û aboriya gelî navdar e.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Şêrê Min" — helbesta sembolîk a netewî.\n'
        '2. "Welatê Min" — pîrozî bo welêt.\n'
        '3. "Pir Telhe" — helbesteke êşek a civakî.',
    turkishContent:
        'Bekes (tam adı: Faik Bekes), klasik Soranî şairlerdendir.\n'
        'Süleymaniye\'de doğmuştur. Vatan ve halk yoksulluğu\n'
        'temalı şiirleriyle tanınır.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "Şêrê Min" — milli sembolik şiir.\n'
        '2. "Welatê Min" — vatana adanmış.\n'
        '3. "Pir Telhe" — toplumsal ızdırap şiiri.',
    backgroundNote:
        'Bekes, 20. yüzyılın ilk yarısında Soranî şiirinin önemli '
        'temsilcilerindendir. Oğlu Şêrko Bêkes (1940-2013) modern '
        'Soranî şiirinin büyük temsilcisi olmuştur.',
    level: 4,
    unitId: 'art_poet',
    keywords: ['Bekes', 'Faiq', 'Silêmanî', 'Soranî', 'klasîk'],
  ),

  // ── p_019: Şêrko Bêkes ────────────────────────────────────
  CulturalItem(
    id: 'p_019',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Şêrko Bêkes (1940–2013)',
    turkishTitle: 'Şêrko Bêkes (1940-2013)',
    kurmanjContent:
        'Şêrko Bêkes, helbestvanê Soranî yê herî navdar ê sedsala\n'
        '20\'î ye. Ji Silêmaniyê hatibû dinyayê. Hem helbestên\n'
        'lîrîk hem prozra modernîst nivîsîne. Di sala 2001\'î de\n'
        'Xelata Tucholsky (Swêd) wergirt.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Sersala Bêkes" — destana modernîzmê.\n'
        '2. "Stranên Welatê Min" — helbestên welatperwerî.\n'
        '3. "Roj û Heyv û Stêrk" — helbestên sembolîk.',
    turkishContent:
        'Şêrko Bêkes, 20. yüzyılın en tanınmış Soranî şairidir.\n'
        'Süleymaniye\'de doğmuştur. Hem lirik şiir hem modernist\n'
        'düzyazı yazdı. 2001\'de Tucholsky Ödülü\'nü (İsveç) aldı.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "Sersala Bêkes" — modernizmin destanı.\n'
        '2. "Stranên Welatê Min" — vatansever şiirler.\n'
        '3. "Roj û Heyv û Stêrk" — sembolik şiirler.',
    backgroundNote:
        'Şêrko Bêkes, babası Faik Bekes\'ten gelen şiir geleneğini '
        'modern bir biçime taşıdı. Eserleri 20\'den fazla dile '
        'çevrilmiştir. Modern Kürt şiirinin küresel temsilcisidir.',
    level: 4,
    unitId: 'art_poet',
    keywords: ['Şêrko', 'Bêkes', 'Soranî', 'Tucholsky', 'modern'],
  ),

  // ── p_020: Selîm Berekat ──────────────────────────────────
  CulturalItem(
    id: 'p_020',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Selîm Berekat (j.d. 1951)',
    turkishTitle: 'Selim Berekat (d. 1951)',
    kurmanjContent:
        'Selîm Berekat, helbestvan û romannivîsê Kurd ê Sûriyê ye.\n'
        'Bi Erebî dinivîse, lê mijara Kurd û nasnameya Kurd '
        'navendî ye. Yek ji navên herî mezin ên edebiyata Erebî\n'
        'ya nûjen e.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Fuqara\'a" — koleksîyona helbestê.\n'
        '2. "Sîresû\'l Subyân" (Çocukluğun Kıvılcımları) — roman.\n'
        '3. "Heristan û Bostan" — şiirsel düzyazı.',
    turkishContent:
        'Selim Berekat, Suriyeli Kürt şair ve romancıdır. Arapça\n'
        'yazar, ancak Kürt kimliği ve teması merkezdedir. Modern\n'
        'Arap edebiyatının en büyük isimlerindendir.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "Fuqara\'a" — şiir koleksiyonu.\n'
        '2. "Sîresû\'l Subyân" (Çocukluğun Kıvılcımları) — roman.\n'
        '3. "Heristan û Bostan" — şiirsel nesir.',
    backgroundNote:
        'Selim Berekat\'ın romanları Kürt göçmenliği, Kürt-Arap '
        'çelişkileri ve kuşaklar arası kırılmalar üzerinedir. '
        'Eserleri 10\'dan fazla dile çevrilmiştir.',
    level: 5,
    unitId: 'art_poet',
    keywords: ['Selîm Berekat', 'Sûriye', 'Erebî', 'roman', 'Kurd'],
  ),

  // ── p_021: Pîramêrd ───────────────────────────────────────
  CulturalItem(
    id: 'p_021',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Pîramêrd — Hacî Tewfîq (1867–1950)',
    turkishTitle: 'Pîramêrd — Hacı Tevfik (1867-1950)',
    kurmanjContent:
        'Pîramêrd (Pîr-Mêr, "kalê pîr"), navê edebî yê Hacî Tewfîq e.\n'
        'Ji helbestvanên klasîk ên Soranî ye, û yek ji bavên\n'
        'rojnamevaniya Kurdî ye.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Jîn" rojnameya Kurdî (1929–1939) — bingehkar û\n'
        '   redaktor.\n'
        '2. "Dîwana Pîramêrd" — helbestên klasîk.\n'
        '3. Wergerandinên Sad\'î Şîrazî bo Kurdî.',
    turkishContent:
        'Pîramêrd (Pir-Mêr, "yaşlı erkek"), Hacı Tevfik\'in edebi\n'
        'adıdır. Klasik Soranî şairlerdendir, Kürt gazeteciliğinin\n'
        'babalarından biridir.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "Jîn" Kürtçe gazete (1929-1939) — kurucu ve editör.\n'
        '2. "Dîwana Pîramêrd" — klasik şiirler.\n'
        '3. Sa\'di Şirazi\'nin Kürtçe çevirileri.',
    backgroundNote:
        'Pîramêrd\'in "Jîn" gazetesi, Soranî modern gazeteciliğinin '
        'temelini attı. Süleymaniye\'de uzun yıllar yaşadı; mezarı '
        'ziyaretgâhtır. 1950\'deki ölümü Soranî kültürel dünyasında '
        'büyük üzüntüyle karşılandı.',
    level: 4,
    unitId: 'art_poet',
    keywords: ['Pîramêrd', 'Hacî Tewfîq', 'Jîn', 'Soranî', 'rojname'],
  ),

  // ── p_022: Mela Eyûbê Hekarî ──────────────────────────────
  CulturalItem(
    id: 'p_022',
    type: CulturalContentType.poet,
    kurmanjTitle: 'Mela Eyûbê Hekarî (sedsala 16)',
    turkishTitle: 'Mela Eyûbê Hekarî (16. yüzyıl)',
    kurmanjContent:
        'Mela Eyûbê Hekarî, helbestvanê klasîk ê Kurmancî ye, ji\n'
        'sedsala 16\'î. Ji Hekarîyê hatibû dinyayê. Bi helbestên\n'
        'xwe yên dîwanî û tesewufî ji nav dîwanên klasîk ên Kurd\n'
        'derketibû.\n\n'
        '★ Berhemên parastî:\n'
        '1. Helbestên dîwanî — naskirin bi qasîde û xezelan.\n'
        '2. Helbestên tesewufî — bi rêya pîrê tarîqetan.\n'
        '3. "Şahidiya Hekarî" — eserên helbestî yên çiyê.',
    turkishContent:
        'Mela Eyûbê Hekarî, 16. yüzyıldan klasik Kurmancî şairdir.\n'
        'Hakkari\'de doğmuştur. Divan ve tasavvufi şiirleriyle\n'
        'klasik Kürt divanları arasında yer almıştır.\n\n'
        '★ Korunan eserleri:\n'
        '1. Divan şiirleri — kaside ve gazel olarak tanınır.\n'
        '2. Tasavvufi şiirler — tarikat pîrî yoluyla.\n'
        '3. "Şahidiya Hekarî" — dağ şiir eserleri.',
    backgroundNote:
        'Mela Eyûbê Hekarî\'nin eserleri Bedlîs ve Hekarî '
        'medreselerinde el yazması olarak korunmuştur. Çağdaş '
        'araştırmacı Tahsin İbrahim Doski tarafından 2010\'larda '
        'yayımlandı.',
    level: 5,
    unitId: 'art_poet',
    keywords: ['Mela Eyûbê', 'Hekarî', 'sedsala 16', 'tesewuf', 'dîwan'],
  ),
];

// ────────────────────────────────────────────────────────────────
// NIVÎSKAR (Yazarlar) — 10 figür × başlıca eserler
// ────────────────────────────────────────────────────────────────

const kKurdishWriters = <CulturalItem>[
  CulturalItem(
    id: 'w_001',
    type: CulturalContentType.writer,
    kurmanjTitle: 'Mehmed Uzun (1953–2007)',
    turkishTitle: 'Mehmed Uzun (1953–2007)',
    kurmanjContent:
        'Ji Sêwregê (Riha). Romanivîsê herî navdar ê Kurmancî.\n'
        'Ji 1977\'an heta dawiya jiyana xwe li sirgûnê li Swêd jiya.\n\n'
        '★ Berhemên sereke:\n'
        '1. "Rojek ji Rojên Evdalê Zeynikê" (1991)\n'
        '   — jiyana dengbêjê navdar Evdalê Zeynikê.\n'
        '2. "Bîra Qederê" (1995)\n'
        '   — jiyana Celadet Bedirxan, modernkirina kurdî.\n'
        '3. "Hawara Dîcleyê" I-II (2002)\n'
        '   — destana çand û dîroka Mezopotamyayê.',
    turkishContent:
        'Siverek (Urfa) kökenli; en tanınmış Kurmancî romancısıdır.\n'
        '1977\'den vefatına kadar İsveç\'te sürgünde yaşadı.\n\n'
        '★ Başlıca eserler:\n'
        '1. "Rojek ji Rojên Evdalê Zeynikê" (1991)\n'
        '   — ünlü dengbêj Evdalê Zeynikê\'nin hayatı.\n'
        '2. "Bîra Qederê" (1995)\n'
        '   — Celadet Bedirhan ve Kürtçenin modernleşmesi.\n'
        '3. "Hawara Dîcleyê" I-II (2002)\n'
        '   — Mezopotamya kültür ve tarihinin destanı.',
    backgroundNote:
        'Mehmed Uzun, Kurmancî romanı modern bir tür olarak yeniden kurdu. '
        'Eserleri 20\'den fazla dile çevrildi. Yaşamının sonunda Türkiye\'ye '
        'döndü ve Diyarbakır\'da vefat etti. Mezarı Mardinkapı\'dadır.',
    level: 3,
    unitId: 'art_writer',
    keywords: ['Mehmed', 'Uzun', 'roman', 'Bîra Qederê', 'Hawara Dîcleyê'],
  ),

  CulturalItem(
    id: 'w_002',
    type: CulturalContentType.writer,
    kurmanjTitle: 'Ereb Şemo (1897–1978)',
    turkishTitle: 'Ereb Şemo (1897–1978)',
    kurmanjContent:
        'Ji Qersê (di paş re Sovyetistan).\n'
        'Yekem romanivîsê Kurmancî yê modern.\n\n'
        '★ Berhemên sereke:\n'
        '1. "Şivanê Kurmancan" (1935)\n'
        '   — yekem romana Kurmancî; jiyana şivanan û koçeran.\n'
        '2. "Jiyana Bextewar" (1959)\n'
        '   — jiyaneke nû di nav civata kurd a Sovyetê de.\n'
        '3. "Dimdim" (1966)\n'
        '   — destana dîrokî ya kela Dimdimê.',
    turkishContent:
        'Kars kökenlidir (sonra Sovyetler Birliği topraklarında).\n'
        'İlk modern Kurmancî romancısıdır.\n\n'
        '★ Başlıca eserler:\n'
        '1. "Şivanê Kurmancan" (1935)\n'
        '   — ilk Kurmancî roman; çobanların ve göçerlerin hayatı.\n'
        '2. "Jiyana Bextewar" (1959)\n'
        '   — Sovyet Kürt toplumunda yeni bir hayat.\n'
        '3. "Dimdim" (1966)\n'
        '   — Dimdim Kalesi\'nin tarihi destanı.',
    backgroundNote:
        'Ereb Şemo, Sovyet Ermenistan\'ında Kurmancî yayıncılığın öncülerindendir. '
        '"Şivanê Kurmancan", Kiril alfabesiyle yayımlanan ilk Kürt romanıdır. '
        'Daha sonra Latin Kurmancî\'ye uyarlandı.',
    level: 3,
    unitId: 'art_writer',
    keywords: ['Ereb', 'Şemo', 'Şivan', 'Sovyet', 'roman'],
  ),

  CulturalItem(
    id: 'w_003',
    type: CulturalContentType.writer,
    kurmanjTitle: 'Celadet Alî Bedirxan (1893–1951)',
    turkishTitle: 'Celadet Ali Bedirhan (1893–1951)',
    kurmanjContent:
        'Ji malbata mîrên Bedirxaniyên Cizîrê.\n'
        'Damezirînerê alfabeya Hawarê — Kurmancî bi tîpên latînî.\n\n'
        '★ Berhemên sereke:\n'
        '1. Kovara "Hawar" (1932–1943, 57 hejmar)\n'
        '   — kovara çand û rêzimanê ya yekem.\n'
        '2. "Bingehên Gramera Kurdmancî" (1928, bi K.A. Bedirxan)\n'
        '   — yekem rêzimaname ya zanistî.\n'
        '3. "Elîfba" (1932)\n'
        '   — yekem destpêk-pirtûka latînî bo zarokan.',
    turkishContent:
        'Bedirhanî mîrleri ailesindendir, Cizre kökenlidir.\n'
        'Hawar alfabesinin (Latin Kurmancî) kurucusudur.\n\n'
        '★ Başlıca eserler:\n'
        '1. "Hawar" Dergisi (1932–1943, 57 sayı)\n'
        '   — ilk Kürt kültür ve gramer dergisi.\n'
        '2. "Bingehên Gramera Kurdmancî" (1928, K.A. Bedirhan ile)\n'
        '   — ilk bilimsel Kurmancî dilbilgisi.\n'
        '3. "Elîfba" (1932)\n'
        '   — çocuklar için ilk Latin Kurmancî alfabe kitabı.',
    backgroundNote:
        'Celadet Bedirxan, modern Kurmancî yazılı kültürünün mimarıdır. '
        'Bugün LÛTKE\'nin de kullandığı alfabeyi onun çalışmaları belirledi. '
        '"Hawar" sözcüğünün anlamı "yardım çağrısı"dır — dilin imdadına çağrı.',
    level: 3,
    unitId: 'art_writer',
    keywords: ['Celadet', 'Bedirxan', 'Hawar', 'alfabe', 'gramer'],
  ),

  CulturalItem(
    id: 'w_004',
    type: CulturalContentType.writer,
    kurmanjTitle: 'Kamûran Alî Bedirxan (1895–1978)',
    turkishTitle: 'Kamuran Ali Bedirhan (1895–1978)',
    kurmanjContent:
        'Birayê Celadet, hiqûqnas, dîplomat û nivîskar.\n'
        'Bi birayê xwe re kovara Hawarê damezirand.\n\n'
        '★ Berhemên sereke:\n'
        '1. "Le Kurde et Le Droit Kurde" (Parîs, 1949)\n'
        '   — pirtûka huqûqa kurdî bi Frensî.\n'
        '2. Gotarên "Hawar" (1932–1943)\n'
        '   — gotarên çand û siyaseteke nû.\n'
        '3. "Tarîxa Kurdistanê" (gotarên dîrokî)\n'
        '   — kurteyên dîroka kurdî bi Kurmancî.',
    turkishContent:
        'Celadet\'in kardeşi; hukukçu, diplomat ve yazar.\n'
        'Kardeşiyle birlikte Hawar dergisini kurdu.\n\n'
        '★ Başlıca eserler:\n'
        '1. "Le Kurde et Le Droit Kurde" (Paris, 1949)\n'
        '   — Fransızca Kürt hukuku üzerine kitap.\n'
        '2. "Hawar" yazıları (1932–1943)\n'
        '   — yeni kültür ve siyaset makaleleri.\n'
        '3. "Tarîxa Kurdistanê" (tarih makaleleri)\n'
        '   — Kurmancî Kürt tarih özetleri.',
    backgroundNote:
        'Kamûran Bedirxan, Kürt davasını uluslararası hukuk arenasında '
        'savundu. Paris Sorbonne\'da Kürt etüdleri kürsüsünü destekledi. '
        'Avrupa\'da Kürt akademik geleneğinin temelini attı.',
    level: 3,
    unitId: 'art_writer',
    keywords: ['Kamûran', 'Bedirxan', 'Hawar', 'huqûq', 'Parîs'],
  ),

  CulturalItem(
    id: 'w_005',
    type: CulturalContentType.writer,
    kurmanjTitle: 'Hesenê Metê (j.d. 1957)',
    turkishTitle: 'Hesenê Metê (d. 1957)',
    kurmanjContent:
        'Ji Êlihê (Batman). Romanivîs û çîroknivîsê hevçax.\n'
        'Li Swêdê dijî, bi Kurmancî dinivîsîne.\n\n'
        '★ Berhemên sereke:\n'
        '1. "Labîrenta Cinan" (1994)\n'
        '   — roman; lêgerîna nasnameyê.\n'
        '2. "Tofan" (2000)\n'
        '   — romaneke piralî; civaka kurd a Êlihê.\n'
        '3. "Ardû" (2008)\n'
        '   — komeke çîrokan li ser jin û jiyanê.',
    turkishContent:
        'Batman (Êlih) kökenlidir. Çağdaş roman ve öykü yazarıdır.\n'
        'İsveç\'te yaşar, Kurmancî yazar.\n\n'
        '★ Başlıca eserler:\n'
        '1. "Labîrenta Cinan" (1994)\n'
        '   — roman; kimlik arayışı.\n'
        '2. "Tofan" (2000)\n'
        '   — çok katmanlı roman; Batman\'da Kürt toplumu.\n'
        '3. "Ardû" (2008)\n'
        '   — kadın ve hayat üzerine öykü derlemesi.',
    backgroundNote:
        'Hesenê Metê, modern Kurmancî romanının lirik-felsefi kanadının '
        'önde gelen sesidir. Eserleri Almanca, İsveççe ve Türkçeye çevrildi. '
        'Modern Kürt edebiyat eleştirisinde sıkça referans gösterilir.',
    level: 4,
    unitId: 'art_writer',
    keywords: ['Hesenê', 'Metê', 'roman', 'Êlih', 'Swêd'],
  ),

  CulturalItem(
    id: 'w_006',
    type: CulturalContentType.writer,
    kurmanjTitle: 'Helîm Yûsiv (j.d. 1967)',
    turkishTitle: 'Helîm Yûsiv (d. 1967)',
    kurmanjContent:
        'Ji Amûdê (Rojavayê Kurdistanê).\n'
        'Romanivîs, çîroknivîs û rojnamevan.\n\n'
        '★ Berhemên sereke:\n'
        '1. "Sobarto" (1999)\n'
        '   — yekem romana wî; jiyana çîroka Amûdê.\n'
        '2. "Kuçeya Welatê Min" (2008)\n'
        '   — koçberî û nasname.\n'
        '3. "Mêrê Avis" (2012)\n'
        '   — romaneke civakî li ser jin û azadiyê.',
    turkishContent:
        'Amude (Batı Kürdistan) kökenlidir.\n'
        'Romancı, öykücü ve gazetecidir.\n\n'
        '★ Başlıca eserler:\n'
        '1. "Sobarto" (1999)\n'
        '   — ilk romanı; Amude\'nin hayatı.\n'
        '2. "Kuçeya Welatê Min" (2008)\n'
        '   — göç ve kimlik.\n'
        '3. "Mêrê Avis" (2012)\n'
        '   — kadın ve özgürlük üzerine toplumsal roman.',
    backgroundNote:
        'Helîm Yûsiv, Rojava Kürt edebiyatının çağdaş seslerinden '
        'biridir. Eserleri Arapça, Almanca ve Türkçeye çevrildi. '
        'Almanya\'da yaşamakta ve yazmaya devam etmektedir.',
    level: 4,
    unitId: 'art_writer',
    keywords: ['Helîm', 'Yûsiv', 'Amûd', 'Rojava', 'roman'],
  ),

  CulturalItem(
    id: 'w_007',
    type: CulturalContentType.writer,
    kurmanjTitle: 'Jan Dost (j.d. 1965)',
    turkishTitle: 'Jan Dost (d. 1965)',
    kurmanjContent:
        'Ji Kobanê (Rojavayê Kurdistanê).\n'
        'Romanivîs, helbestvan û wergêr.\n'
        'Bi Kurmancî û Erebî dinivîsîne.\n\n'
        '★ Berhemên sereke:\n'
        '1. "Mîrname" (1995)\n'
        '   — romana dîrokî li ser jiyana Ehmedê Xanî.\n'
        '2. "Mijabad" (2004)\n'
        '   — roman li ser Komara Mihabadê (1946).\n'
        '3. "Kobanî" (2017)\n'
        '   — roman; berxwedana bajarê wî.',
    turkishContent:
        'Kobanê (Batı Kürdistan) kökenlidir.\n'
        'Romancı, şair ve çevirmendir.\n'
        'Kurmancî ve Arapça yazar.\n\n'
        '★ Başlıca eserler:\n'
        '1. "Mîrname" (1995)\n'
        '   — Ehmedê Xanî hayatı üzerine tarihi roman.\n'
        '2. "Mijabad" (2004)\n'
        '   — Mahabad Cumhuriyeti (1946) üzerine roman.\n'
        '3. "Kobanî" (2017)\n'
        '   — şehrinin direnişine adanmış roman.',
    backgroundNote:
        'Jan Dost, çağdaş tarihi roman türünün Kurmancî\'deki en üretken yazarıdır. '
        '"Mem û Zîn"i Arapçaya çevirdi. Almanya\'da yaşamakta ve hem akademik '
        'hem edebi alanda üretmektedir.',
    level: 4,
    unitId: 'art_writer',
    keywords: ['Jan', 'Dost', 'Kobanê', 'roman', 'dîrok'],
  ),

  CulturalItem(
    id: 'w_008',
    type: CulturalContentType.writer,
    kurmanjTitle: 'Bavê Nazê (1938–2001)',
    turkishTitle: 'Bavê Nazê (1938–2001)',
    kurmanjContent:
        'Ji Mêrdînê. Çîroknivîs û nivîskarê pêşeng ê Kurmancî.\n'
        'Navê wî yê esil "Mihemed Çapan" e.\n\n'
        '★ Berhemên sereke:\n'
        '1. "Çîrokên Bavê Nazê" (1980\'an)\n'
        '   — komeke çîrokên kurdî bi devkî tê veguhastin.\n'
        '2. "Cembelî" (1992)\n'
        '   — destana evînê bi pexşan.\n'
        '3. "Şervîn" (1996)\n'
        '   — çîrokên gund û jiyana kurdî.',
    turkishContent:
        'Mardin kökenli; Kurmancî öykü yazarı ve öncüsüdür.\n'
        'Asıl adı "Mihemed Çapan"dır.\n\n'
        '★ Başlıca eserler:\n'
        '1. "Çîrokên Bavê Nazê" (1980\'ler)\n'
        '   — sözel gelenekten derlenen Kürt öyküleri.\n'
        '2. "Cembelî" (1992)\n'
        '   — düz yazı aşk destanı.\n'
        '3. "Şervîn" (1996)\n'
        '   — köy ve Kürt yaşamı öyküleri.',
    backgroundNote:
        'Bavê Nazê (Naz\'ın babası) takma adıyla tanınır. '
        'Sözlü Kurmancî mirasını yazılı edebiyata aktarmada '
        'köprü görevi gören önemli bir nesir yazarıdır.',
    level: 4,
    unitId: 'art_writer',
    keywords: ['Bavê Nazê', 'Çapan', 'çîrok', 'devkî', 'Mêrdîn'],
  ),

  CulturalItem(
    id: 'w_009',
    type: CulturalContentType.writer,
    kurmanjTitle: 'Firat Cewerî (j.d. 1959)',
    turkishTitle: 'Firat Cewerî (d. 1959)',
    kurmanjContent:
        'Ji Mêrdînê. Romanivîs û edîtorê hevçax.\n'
        'Edîtorê kovara "Nûdem" (1992–2003) ya li Stockholmê.\n\n'
        '★ Berhemên sereke:\n'
        '1. "Payîza Dereng" (2005)\n'
        '   — roman; bîranîn û demên derbasbûyî.\n'
        '2. "Lehî" (2009)\n'
        '   — roman; jiyaneke koçberiyê.\n'
        '3. "Nûdem" (kovara, 1992–2003)\n'
        '   — yek ji kovarên ferehbûyî yên Kurmancî.',
    turkishContent:
        'Mardin kökenlidir. Romancı ve çağdaş editördür.\n'
        'Stockholm\'da çıkan "Nûdem" dergisinin (1992–2003) editörüdür.\n\n'
        '★ Başlıca eserler:\n'
        '1. "Payîza Dereng" (2005)\n'
        '   — roman; anılar ve geçmiş zamanlar.\n'
        '2. "Lehî" (2009)\n'
        '   — roman; bir göç hayatı.\n'
        '3. "Nûdem" (dergi, 1992–2003)\n'
        '   — çağdaş Kurmancî\'nin başlıca dergilerinden biri.',
    backgroundNote:
        'Firat Cewerî, Kurmancî yayıncılığın diasporadaki kurumsallaşmasında '
        'kilit bir rol oynadı. "Nûdem" dergisi, Kurmancî düzyazı ve şiir için '
        'temel bir mecra oldu.',
    level: 4,
    unitId: 'art_writer',
    keywords: ['Firat', 'Cewerî', 'Nûdem', 'roman', 'Stockholm'],
  ),

  CulturalItem(
    id: 'w_010',
    type: CulturalContentType.writer,
    kurmanjTitle: 'Nûredîn Zaza (1919–1988)',
    turkishTitle: 'Nureddin Zaza (1919–1988)',
    kurmanjContent:
        'Ji Madenê (Êlazîz). Çîroknivîs, zimannas û siyasetmedar.\n'
        'Pêşengê çîroka modern a Kurmancî.\n\n'
        '★ Berhemên sereke:\n'
        '1. "Bîranînên Min" (otobiyografî, 1980)\n'
        '   — bîranîn ji jiyana wî ya bextê û siyasî.\n'
        '2. Çîrokên kurt di Hawarê de\n'
        '   — yekemîn nimûneyên çîroka modern a Kurmancî.\n'
        '3. "Ferhenga Kurmancî"yê li Lozanê\n'
        '   — ferheng û lêkolînên zimanî.',
    turkishContent:
        'Maden (Elazığ) kökenlidir. Öykücü, dilbilimci ve siyasetçidir.\n'
        'Modern Kurmancî öykücülüğünün öncüsüdür.\n\n'
        '★ Başlıca eserler:\n'
        '1. "Bîranînên Min" (otobiyografi, 1980)\n'
        '   — yaşamından siyasi ve özel anılar.\n'
        '2. Hawar\'daki kısa öyküler\n'
        '   — modern Kurmancî öykünün ilk örnekleri.\n'
        '3. Lozan\'daki Kurmancî sözlük çalışmaları\n'
        '   — sözlük ve dilbilim araştırmaları.',
    backgroundNote:
        'Nûredîn Zaza, Hawar dergisinde yayımlanan kısa öyküleriyle '
        'modern Kurmancî nesrinin sınırlarını çizdi. Lozan Üniversitesi\'nde '
        'Kürt edebiyatı doktorası yaptı; Suriye Kürdistanı Demokrat Partisi\'ni kurdu.',
    level: 4,
    unitId: 'art_writer',
    keywords: ['Nûredîn', 'Zaza', 'çîrok', 'Hawar', 'Lozan'],
  ),

  // ════════════════════════════════════════════════════════════════
  // FAZ 2 — Nivîskarên zêde (8 nû): roman-nivîs û çîrok-nivîs nûjen
  // ════════════════════════════════════════════════════════════════

  // ── w_011: Yaşar Kemal ────────────────────────────────────
  CulturalItem(
    id: 'w_011',
    type: CulturalContentType.writer,
    kurmanjTitle: 'Yaşar Kemal (1923–2015)',
    turkishTitle: 'Yaşar Kemal (1923-2015)',
    kurmanjContent:
        'Yaşar Kemal (navê wî yê tam: Kemal Sadık Gökçeli), ji\n'
        'romanvîsên herî mezin ên dinyayê û nêzî nasnameya Kurd\n'
        'a xwe ye. Ji Hemîtêyê (Adana) hatibû dinyayê, malbat ji\n'
        'Wanê. Bi Tirkî dinivîsî, lê mijarên gelê Kurd û Toros\n'
        'navendî ne.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Înce Memed" (4 cild, 1955–1987) — destana lawekî kurd\n'
        '   ku li dijî zalim radibe.\n'
        '2. "Demirciler Çarşısı Cinayeti" (1973) — roman.\n'
        '3. "Bin boğaların efsanesi" — destana çiyayê Bingol.',
    turkishContent:
        'Yaşar Kemal (tam adı: Kemal Sadık Gökçeli), dünyanın\n'
        'en büyük romancılarından ve Kürt kimliğine yakındır.\n'
        'Hemite\'de (Adana) doğmuş, ailesi Van\'dandır. Türkçe\n'
        'yazardı, ama Kürt halkı ve Toroslar konuları merkezdedir.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "İnce Memed" (4 cilt, 1955-1987) — zalime karşı duran\n'
        '   bir Kürt gencin destanı.\n'
        '2. "Demirciler Çarşısı Cinayeti" (1973) — roman.\n'
        '3. "Bin Boğaların Efsanesi" — Bingöl Dağı destanı.',
    backgroundNote:
        'Yaşar Kemal eserleri 40\'tan fazla dile çevrilmiştir. Nobel '
        'Edebiyat Ödülü\'ne defalarca aday gösterildi. 1971\'de '
        'Kürt kimliğini açıkça savunan beyanları nedeniyle hapse '
        'düştü. Mezarı İstanbul Karacaahmet\'tedir.',
    level: 4,
    unitId: 'art_writer',
    keywords: ['Yaşar Kemal', 'roman', 'İnce Memed', 'Adana', 'Toros'],
  ),

  // ── w_012: Şener Özmen ────────────────────────────────────
  CulturalItem(
    id: 'w_012',
    type: CulturalContentType.writer,
    kurmanjTitle: 'Şener Özmen (j.d. 1971)',
    turkishTitle: 'Şener Özmen (d. 1971)',
    kurmanjContent:
        'Şener Özmen, ji nivîskarên Kurd ên nûjen ên konseptûalîst\n'
        'e. Ji Bismilê (Diyarbekir) hatibû dinyayê. Hem nivîskar,\n'
        'hem hunermendê hunerê yê dîjîtal e.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Rojnivîska Spinoza" (Rûs-roman, 2008) — gerek û cûrê\n'
        '   sînor di nav nasname û ramanê de.\n'
        '2. "Pêvajoya Avêtina Donkîşot li Kurdistanê" — proje hunerî.\n'
        '3. "Folklora Sêwiyê" — kurte-roman.',
    turkishContent:
        'Şener Özmen, modern Kürt yazarların konseptüalist\n'
        'kanadından gelen biridir. Bismil\'de (Diyarbakır) doğmuştur.\n'
        'Hem yazar, hem dijital sanatçıdır.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "Rojnivîska Spinoza" (Rüs-roman, 2008) — kimlik ve\n'
        '   düşünce arasındaki sınır ve çözüm.\n'
        '2. "Donkişot\'u Kürdistan\'a Atma Süreci" — sanat projesi.\n'
        '3. "Folklora Sêwiyê" — kısa roman.',
    backgroundNote:
        'Şener Özmen, Kurmancî modern edebiyatının kavramsal sınırlarını '
        'zorlayan eserleriyle uluslararası galerilerde sergilenmiş '
        'çağdaş bir Kürt sanatçıdır. Lîs Yayınevi\'nin önemli '
        'yazarlarındandır.',
    level: 4,
    unitId: 'art_writer',
    keywords: ['Şener Özmen', 'konseptûal', 'roman', 'Bismil', 'Lîs'],
  ),

  // ── w_013: Lokman Polat ───────────────────────────────────
  CulturalItem(
    id: 'w_013',
    type: CulturalContentType.writer,
    kurmanjTitle: 'Lokman Polat (j.d. 1950)',
    turkishTitle: 'Lokman Polat (d. 1950)',
    kurmanjContent:
        'Lokman Polat, ji nivîskarên Kurd ên dîasporayê ye. Ji\n'
        'Mêrdînê hatibû dinyayê, ji 1980\'î ve li Swêdê dijî.\n'
        'Yek ji nivîskarên herî bidualî yên Kurmancî yên dîjital e.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Robîn" (1991) — romana yekem a Kurmancî li Swêdê.\n'
        '2. "Sêvên Sor" — kurte-çîrok.\n'
        '3. Bi sedan rexne û şîroveyên edebî.',
    turkishContent:
        'Lokman Polat, diaspora Kürt yazarlarındandır. Mardin\'de\n'
        'doğmuştur, 1980\'den beri İsveç\'te yaşar. Dijital alanda\n'
        'en üretken Kurmancî yazarlardan biridir.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "Robîn" (1991) — İsveç\'te yazılmış ilk Kurmancî roman.\n'
        '2. "Sêvên Sor" — kısa öyküler.\n'
        '3. Yüzlerce edebi eleştiri ve yorum.',
    backgroundNote:
        'Lokman Polat\'ın "Robîn" adlı romanı diaspora Kurmancî '
        'edebiyatının bir kilometre taşıdır. Stockholm Kürt '
        'PEN\'in kurucu üyelerindendir.',
    level: 3,
    unitId: 'art_writer',
    keywords: ['Lokman Polat', 'Swêd', 'Robîn', 'dîaspora', 'roman'],
  ),

  // ── w_014: Ata Nehayî ─────────────────────────────────────
  CulturalItem(
    id: 'w_014',
    type: CulturalContentType.writer,
    kurmanjTitle: 'Ata Nehayî (1960–2021)',
    turkishTitle: 'Ata Nehayî (1960-2021)',
    kurmanjContent:
        'Ata Nehayî, ji romanvîsên Soranî yên herî navdar e. Ji\n'
        'Bokanê (Rojhilatê Kurdistanê, Îran) hatibû dinyayê. Bi\n'
        'romanên xwe yên realîst û fikrî, edebiyata Soranî pêşî\n'
        'kişand.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Gulî Şewran" (Şevran Gülü, 1998) — roman.\n'
        '2. "Ev Bi Tenê Çîrok e" — koleksîyona kurte-çîrok.\n'
        '3. "Bûka Demê" — roman.',
    turkishContent:
        'Ata Nehayî, en tanınmış Soranî romancılardandır. Bokan\'da\n'
        '(Doğu Kürdistan, İran) doğmuştur. Realist ve düşünsel\n'
        'romanlarıyla Soranî edebiyatını ileri taşıdı.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "Gulî Şewran" (Şevran Gülü, 1998) — roman.\n'
        '2. "Bu Sadece Bir Hikâyedir" — kısa öykü koleksiyonu.\n'
        '3. "Bûka Demê" — roman.',
    backgroundNote:
        'Ata Nehayî, Doğu Kürdistan\'da Kürtçe yayın yasakları '
        'altında yazdı. "Gulî Şewran" Farsçaya da çevrilerek geniş '
        'kitleye ulaştı. 2021\'de Boykat\'ta vefat etti.',
    level: 4,
    unitId: 'art_writer',
    keywords: ['Ata Nehayî', 'Soranî', 'Bokan', 'Gulî Şewran', 'roman'],
  ),

  // ── w_015: Bextiyar Elî ───────────────────────────────────
  CulturalItem(
    id: 'w_015',
    type: CulturalContentType.writer,
    kurmanjTitle: 'Bextiyar Elî (j.d. 1960)',
    turkishTitle: 'Bahtiyar Ali (d. 1960)',
    kurmanjContent:
        'Bextiyar Elî, romanvîsê Soranî yê navdar ê dema me ye.\n'
        'Ji Silêmaniyê hatibû dinyayê, niha li Almanyayê dijî. Bi\n'
        'romanên xwe yên felsefî û realîzma sêhrek (magic realism)\n'
        'naskirî ye.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Êvara Perwaneyê" (1998) — roman, ku 17 zimanan re\n'
        '   hate wergerandin.\n'
        '2. "Şehrî Mosîqarê Spî" (Beyaz Müzisyenler Şehri) — roman.\n'
        '3. "Awirê Tenuriya Dîwan" — koleksîyona helbestê.',
    turkishContent:
        'Bahtiyar Ali, dönemimizin tanınmış Soranî romancısıdır.\n'
        'Süleymaniye\'de doğmuştur, şu an Almanya\'da yaşar.\n'
        'Felsefi romanları ve büyülü gerçekçilik (magic realism)\n'
        'tarzıyla bilinir.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "Êvara Perwaneyê" (Kelebeğin Akşamı, 1998) — roman, 17\n'
        '   dile çevrildi.\n'
        '2. "Şehrî Mosîqarê Spî" (Beyaz Müzisyenler Şehri) — roman.\n'
        '3. "Awirê Tenuriya Dîwan" — şiir koleksiyonu.',
    backgroundNote:
        'Bahtiyar Ali, Kürt edebiyatının uluslararası tanınırlığa '
        'ulaşan birkaç isminden biridir. "Êvara Perwaneyê" Almanca\'ya '
        'çevirisinin ardından Avrupa edebiyat çevrelerinde geniş '
        'yankı uyandırdı.',
    level: 5,
    unitId: 'art_writer',
    keywords: ['Bextiyar Elî', 'Soranî', 'Silêmanî', 'roman', 'magic realism'],
  ),

  // ── w_016: Murat Özyaşar ──────────────────────────────────
  CulturalItem(
    id: 'w_016',
    type: CulturalContentType.writer,
    kurmanjTitle: 'Murat Özyaşar (j.d. 1979)',
    turkishTitle: 'Murat Özyaşar (d. 1979)',
    kurmanjContent:
        'Murat Özyaşar, ji nivîskarên Kurd ên nûjen e ku bi Tirkî\n'
        'dinivîsin. Ji Diyarbekirê hatibû dinyayê. Mijara wî:\n'
        'jiyana bajarê Kurd ê hemdem û têgihîştina nasnameyê.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Ayna Çarpması" (2008) — koleksîyona kurte-çîrok.\n'
        '2. "Sarı Kahkaha" (2015) — kurte-çîrok.\n'
        '3. "Aslında" (2022) — roman.',
    turkishContent:
        'Murat Özyaşar, modern Türkçe yazan Kürt yazarlarındandır.\n'
        'Diyarbakır\'da doğmuştur. Konusu: çağdaş Kürt kentinin\n'
        'yaşamı ve kimlik kavrayışı.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "Ayna Çarpması" (2008) — kısa öykü koleksiyonu.\n'
        '2. "Sarı Kahkaha" (2015) — kısa öykü.\n'
        '3. "Aslında" (2022) — roman.',
    backgroundNote:
        'Murat Özyaşar, "Ayna Çarpması" ile 2008 Yunus Nadi Öykü '
        'Ödülü\'nü kazandı. Modern Türk-Kürt edebiyatının önemli '
        'kavşak yazarlarındandır.',
    level: 4,
    unitId: 'art_writer',
    keywords: ['Murat Özyaşar', 'Diyarbekir', 'çîrok', 'nasname', 'Tirkî'],
  ),

  // ── w_017: Edip Polat ─────────────────────────────────────
  CulturalItem(
    id: 'w_017',
    type: CulturalContentType.writer,
    kurmanjTitle: 'Edip Polat (j.d. 1959)',
    turkishTitle: 'Edip Polat (d. 1959)',
    kurmanjContent:
        'Edip Polat, ji nivîskarên Kurd ên nûjen e ku hem bi\n'
        'Kurmancî hem bi Tirkî dinivîse. Ji Bingol-Solhanê hatibû\n'
        'dinyayê. Bi pirtûkên xwe yên dîrokî-civakî naskirî ye.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Kurd Olabilmek" (1991) — esereke dîrokî-civakî ya\n'
        '   nirxandinê. Pirtûka yekem a wî.\n'
        '2. "Genç Bir Kürdün Romanı" — roman ya nasnameya kurd.\n'
        '3. "Kurdistan: Tarih, Kültür, Edebiyat" — eser-belge.',
    turkishContent:
        'Edip Polat, hem Kurmancî hem Türkçe yazan modern Kürt\n'
        'yazarlardandır. Bingöl-Solhan\'da doğmuştur. Tarihi-toplumsal\n'
        'kitaplarıyla tanınır.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "Kürt Olabilmek" (1991) — değerlendirme niteliğinde\n'
        '   tarihi-toplumsal eser. İlk kitabıdır.\n'
        '2. "Genç Bir Kürdün Romanı" — Kürt kimliği üzerine roman.\n'
        '3. "Kürdistan: Tarih, Kültür, Edebiyat" — belge-eser.',
    backgroundNote:
        'Edip Polat\'ın "Kürt Olabilmek" eseri 1991\'de yayımlanması '
        'sebebiyle Türkiye\'de hapis cezasına çarptırıldı. Eseri '
        'Kürt aydınlanması üzerinde önemli etki bıraktı.',
    level: 4,
    unitId: 'art_writer',
    keywords: ['Edip Polat', 'Bingol', 'Solhan', 'nasname', 'dîrok'],
  ),

  // ── w_018: Riza Çolpan ────────────────────────────────────
  CulturalItem(
    id: 'w_018',
    type: CulturalContentType.writer,
    kurmanjTitle: 'Riza Çolpan (j.d. 1953)',
    turkishTitle: 'Rıza Çolpan (d. 1953)',
    kurmanjContent:
        'Riza Çolpan, ji nivîskarên Kurd ên dîasporayê yê Almanyayê\n'
        'ye. Ji Mêrdîn-Cizîrê hatibû dinyayê, ji 1980\'î ve li\n'
        'Almanyayê dijî. Bi kurte-çîrokên xwe yên Kurmancî naskirî\n'
        'ye.\n\n'
        '★ Berhemên navdar:\n'
        '1. "Şevê Reş" — koleksîyona kurte-çîrok.\n'
        '2. "Welatê Min" — koleksîyona helbestê û kurte-çîrok.\n'
        '3. Werger û rexne ji bo edebiyata Almanî bo Kurmancî.',
    turkishContent:
        'Rıza Çolpan, Almanya\'daki diaspora Kürt yazarlardandır.\n'
        'Mardin-Cizre\'de doğmuştur, 1980\'den beri Almanya\'da\n'
        'yaşar. Kurmancî kısa öyküleriyle tanınır.\n\n'
        '★ Ünlü eserleri:\n'
        '1. "Şevê Reş" — kısa öykü koleksiyonu.\n'
        '2. "Welatê Min" — şiir ve kısa öykü koleksiyonu.\n'
        '3. Almanca\'dan Kurmancî\'ye çeviriler ve eleştiriler.',
    backgroundNote:
        'Rıza Çolpan, Köln Kürt PEN merkezinin aktif üyelerindendir. '
        'Almanya\'da Kurmancî atölyeleri düzenleyerek genç nesil '
        'yazarlara mentörluk yapar.',
    level: 3,
    unitId: 'art_writer',
    keywords: ['Riza Çolpan', 'Almanya', 'kurte-çîrok', 'dîaspora', 'Mêrdîn'],
  ),
];

// ────────────────────────────────────────────────────────────────
// Hemû berhemên hunermendan — yek lîste
// ────────────────────────────────────────────────────────────────

const kKurdishArtistItems = <CulturalItem>[
  ...kKurdishSingers,
  ...kKurdishPoets,
  ...kKurdishWriters,
];
