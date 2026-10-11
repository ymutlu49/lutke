// LÛTKE — Matematîk bi Kurmancî (OTOMATİK ÜRETİLMİŞTİR)
//
// `python tools/qa/fermat.py` üzerine yazar; elle düzenleme.
// Kaynak: Kurmanci/Ziman/terim.tsv (FerMat terim tabanı). Tanım ve örnek
// cümleler FerMat'tan aynen alınır; burada Kurmancî metin yazılmaz.

// ignore_for_file: constant_identifier_names

/// A2 — okul öncesi ve 1. sınıf düzeyindeki matematik terimleri.
const kA2Matematik = [
  (id:'a2_mt_01', ku:'Cihwara', tr:'Konum', en:'Position',
   cins:'bêcins', ez:null, kat:'matematîk', zor:0.75,
   not:'Matematik terimi: konum. Tanım ve örnek FerMat terim tabanından.',
   her:['Top li bin maseyê ye — cihwara topê \'li bin maseyê\' ye. Pisîk li ser kursiyê ye — \'li ser kursiyê\'.', 'Cihê ku tiştekî lê ye; bi peyvên wekî jor, jêr, çep, rast, nav, derveyî tê ravekirin.'],
   gen:['Di lîstikê de zarok dipirsin: \'Top li ku ye?\' — \'Li bin maseyê!\' — \'Na, li paş dîwêr!\' — cihwara topê bibîne!']),

  (id:'a2_mt_02', ku:'Dabeşkirin', tr:'Paylaşma', en:'Sharing',
   cins:'mê', ez:'dabeşkirina', kat:'matematîk', zor:0.75,
   not:'Matematik terimi: paylaşma. Tanım ve örnek FerMat terim tabanından.',
   her:['6 sêvan li 2 zarokan wekhev dabeş bike: her yekî 3 sêv digire.', 'Tiştên wekhev di nav koman an kesan de parvekirin; her kesî heman hejmar digire.'],
   gen:['Li malê: \'Dê 8 gûzan anîn — li 4 zarokan wekhev dabeş bike!\' Zarok yek bi yek belav dikin: her yekî 2 gûz!']),

  (id:'a2_mt_03', ku:'Deste', tr:'Onluk grup', en:'Group of ten',
   cins:'mê', ez:'desteya', kat:'matematîk', zor:0.75,
   not:'Matematik terimi: onluk grup. Tanım ve örnek FerMat terim tabanından.',
   her:['Yek deste hêk = 10 hêk. Du deste sêv = 20 sêv.', 'Koma deh tiştan; di jiyana rojane de deh tiştên hev cins bi hev re deste ne.'],
   gen:['Li bazarê: \'Yek deste hêk bide, ji kerema xwe!\' — firoşkar 10 hêkan dihejmêre û dide — yek deste!']),

  (id:'a2_mt_04', ku:'Gav', tr:'Adım', en:'Step / pace',
   cins:'mê', ez:'gava', kat:'matematîk', zor:0.75,
   not:'Matematik terimi: adım. Tanım ve örnek FerMat terim tabanından.',
   her:['Odeyê bi gavên min 10 gav e, bi gavên hevalê min 8 gav e — gavên me ne wekhev in!', 'Yekeya ne-standart a dirêjahiyê; dema gavek biavêjî dûrahiya di navbêna du lingan de.'],
   gen:['Li hewşê zarok dipirsin: \'Ji vir heta darê çend gav e?\' Her zarokî dihejmêre — encamên cuda! Ji ber ku lingên wan cuda ne!']),

  (id:'a2_mt_05', ku:'Gilover', tr:'Daire', en:'Circle',
   cins:'bêcins', ez:null, kat:'matematîk', zor:0.75,
   not:'Matematik terimi: daire. Tanım ve örnek FerMat terim tabanından.',
   her:['Têkerê gilover e — hem derdor hem jî hundirê. Goşe û hêl tune!', 'Teşeya gilover a girtî; hem xêza derdorê hem jî rûberê hundirê digire. Hemû xalên derdorê ji navendekê hevdûr in.'],
   gen:['Di govendê de zarok dest bi hev digirin û giloverekê çêdikin — teşeya govendê gilover e!']),

  (id:'a2_mt_06', ku:'Hevaltî', tr:'Sayı ikilileri / eş', en:'Number pairs / complement',
   cins:'mê', ez:'hevaltiya', kat:'matematîk', zor:0.75,
   not:'Matematik terimi: sayı ikilileri / eş. Tanım ve örnek FerMat terim tabanından.',
   her:['Hevaltiyên 10ê: 1+9, 2+8, 3+7, 4+6, 5+5.', 'Du hejmarên ku gava li hev tên zêdekirin, hejmarekî taybet didin; wekî hevaltiyên 10ê.'],
   gen:['Di lîstikê de: 10 zarok hene — çend li hundirê ne, çend li derveyî? 4 li hundirê, 6 li derveyî — hevaltiyên 10ê!']),

  (id:'a2_mt_07', ku:'Hêl', tr:'Doğru', en:'Line',
   cins:'mê', ez:'hêla', kat:'matematîk', zor:0.75,
   not:'Matematik terimi: doğru. Tanım ve örnek FerMat terim tabanından.',
   her:['Hêl wekî rêçeke rast e ku qet naqede — ji her du aliyan bêdawî ye.', 'Xêza rast ku ji her du aliyan bêdawî diçe; ne destpêk û ne dawiya wê heye.'],
   gen:['Li ser kilîmê rêzên dirêj hene ku ji destpêkê heta dawiyê diçin — wekî hêlan!']),

  (id:'a2_mt_08', ku:'Jimarîbûn', tr:'Sayı duyusu', en:'Number sense',
   cins:'mê', ez:'jimarîbûna', kat:'matematîk', zor:0.75,
   not:'Matematik terimi: sayı duyusu. Tanım ve örnek FerMat terim tabanından.',
   her:['Bêyî jimartinê dizanî ku 8 ji 3 zêdetir e! Li komekê binêre û tavilê texmîn bike: nêzîkî 20!', 'Hestkirina xwezayî bi hejmaran, mezinahî û têkiliyên wan; bêyî hesabkirinê zanîna nêzîkahiyê.'],
   gen:['Li bazarê: firoşkar bêyî teraziyê dibêje \'ev nêzîkî 1 kîlo ye\' — jimarîbûna wî/wê ji ezmûnê ye!']),

  (id:'a2_mt_09', ku:'Jê derxistin', tr:'Eksiltme', en:'Take away',
   cins:'mê', ez:null, kat:'matematîk', zor:0.75,
   not:'Matematik terimi: eksiltme. Tanım ve örnek FerMat terim tabanından.',
   her:['Li ser masê 8 sêv hene — 3 jê derxe, 5 dimînin: 8 − 3 = 5.', 'Tiştên ji komekê rakirin; gava ji komê hejmaran jê derdixî, ev jê derxistin e. Yek ji awayên fêmkirina kemkirinê ye.'],
   gen:['Li hewşê: \'8 zarok dilîzin, 3 çûn malê — çend li hewşê man? 8 − 3 = 5!\'']),

  (id:'a2_mt_10', ku:'Kare', tr:'Kare', en:'Square',
   cins:'mê', ez:'kareya', kat:'matematîk', zor:0.75,
   not:'Matematik terimi: kare. Tanım ve örnek FerMat terim tabanından.',
   her:['Kaxezdank kare ye: 4 hêl hevdirêj in, hemû goşe 90° ne.', 'Çarçikê taybetî ku hemû çar hêl hevdirêj in û hemû goşe rast (90°) in.'],
   gen:['Di kilîma kurdî de motîfên kare yên rengîn hene — zarok dibêje: \'Çend kare di kilîmê de hene?\' û dihejmêre!']),

  (id:'a2_mt_11', ku:'Kom', tr:'Küme / grup', en:'Set / group',
   cins:'mê', ez:'koma', kat:'matematîk', zor:0.75,
   not:'Matematik terimi: küme / grup. Tanım ve örnek FerMat terim tabanından.',
   her:['3 sêv li hev danê — koma sêvan çêbû! 5 kevir li hev danê — koma keviran!', 'Çend tiştên ku bi hev re têne danîn û berhev dibin; koma tiştan.'],
   gen:['Li malê: \'Pêlavên xwe kom bike!\' — hemû pêlav bi hev re = koma pêlavan. \'Lîstikên xwe kom bike!\' — koma lîstikan!']),

  (id:'a2_mt_12', ku:'Nav', tr:'Iç', en:'Inside',
   cins:'bêcins', ez:null, kat:'matematîk', zor:0.75,
   not:'Matematik terimi: iç. Tanım ve örnek FerMat terim tabanından.',
   her:['Pisîk di nav qutiyê de ye — li hundirê! Top li derveyî qutiyê ye — li derê!', 'Du cihên berevajî: nav = di hundirê tiştekî de, derveyî = li derveyî tiştekî.'],
   gen:['Li malê dê dibêje: \'Pisîk di nav malê de ye an li derveyî?\' Zarok li pencereyê dinêre: \'Li derveyî ye, li baxçê ye!\'']),

  (id:'a2_mt_13', ku:'Neyeksan', tr:'Eşit değil', en:'Not equal',
   cins:'bêcins', ez:null, kat:'matematîk', zor:0.75,
   not:'Matematik terimi: eşit değil. Tanım ve örnek FerMat terim tabanından.',
   her:['3 sêv û 5 porteqal — hejmar ne wekhev e: 3 ≠ 5.', 'Rewşa ku du hejmar an du kom heman mîqdarê ne ne; ne wekhev in.'],
   gen:['Li bazarê: \'Min 3 kîlo kirî, te 5 kîlo — yên me ne wekhev in! Yên te zêdetir in!\'']),

  (id:'a2_mt_14', ku:'Sêgoşe', tr:'Üçgen', en:'Triangle',
   cins:'mê', ez:'sêgoşeya', kat:'matematîk', zor:0.75,
   not:'Matematik terimi: üçgen. Tanım ve örnek FerMat terim tabanından.',
   her:['Sêgoşeyê 3 hêl û 3 goşe hene. Çadira koçeran sêgoşe ye.', 'Teşeya girtî ku sê hêl û sê goşe hene; herî hêsan pirgoşe ye.'],
   gen:['Çadira koçerên kurd sêgoşe ye: sê hêlên darîn û li serê wan goşeyek — sêgoşeya xwezayê!']),

  (id:'a2_mt_15', ku:'Teşe', tr:'Şekil', en:'Shape',
   cins:'mê', ez:'teşeya', kat:'matematîk', zor:0.75,
   not:'Matematik terimi: şekil. Tanım ve örnek FerMat terim tabanından.',
   her:['Sêgoşe, çarçik û gilover teşeyên dudîmen in. Kûb, gilor û lûle teşeyên sêdîmen in.', 'Forma tiştekî; teşeyên dudîmen (li ser kaxezê: sêgoşe, çarçik, gilover) û sêdîmen (di destê de: kûb, gilor, lûle) hene.'],
   gen:['Li kilîma kurdî binêre: motîfên rengîn hene — sêgoşe, çarçik, kare — hemû teşe ne!']),

  (id:'a2_mt_16', ku:'Tîlî', tr:'Karış', en:'Span',
   cins:'bêcins', ez:null, kat:'matematîk', zor:0.75,
   not:'Matematik terimi: karış. Tanım ve örnek FerMat terim tabanından.',
   her:['Pirtûk 2 tîlî dirêj e. Masê 5 tîlî fireh e. Lê tîliyên te û yên min ne wekhev in!', 'Yekeya ne-standart a dirêjahiyê; dema dest tam vebû, dûrahiya ji tiliya mezîn heta tiliya biçûk.'],
   gen:['Li gund dapîr dibêje: \'Ev qumaş çend tîlî ye?\' û bi destê xwe dipive — wekî xêzkeşa kevnar!']),

  (id:'a2_mt_17', ku:'Yekane', tr:'Birler basamağı', en:'Ones place',
   cins:'bêcins', ez:null, kat:'matematîk', zor:0.75,
   not:'Matematik terimi: birler basamağı. Tanım ve örnek FerMat terim tabanından.',
   her:['Di 47 de, 7 li yekane ye = 7 yek.', 'Xaneya yekan; jimareya herî rastê ya di hejmarê de. Ew diyar dike çend yek hene.'],
   gen:['Li malê: \'Di destê te de çend pere hene?\' — \'7 sikke\' — ew 7 li xaneya yekan e, wekî sikkeyên yek-perekî!']),

  (id:'a2_mt_18', ku:'Yeksan', tr:'Eşit', en:'Equal',
   cins:'bêcins', ez:null, kat:'matematîk', zor:0.75,
   not:'Matematik terimi: eşit. Tanım ve örnek FerMat terim tabanından.',
   her:['3 sêv û 3 porteqal — hejmarên wan yeksan e: 3 = 3.', 'Rewşa ku du hejmar an du kom heman mîqdarê ne; wekhev in.'],
   gen:['Li malê nan belav dikin: \'Her zarokî du perçe nan — hemû wekhev in, yeksan e! Kes ji yê din zêdetir negirt!\'']),

  (id:'a2_mt_19', ku:'Çarçik', tr:'Dikdörtgen', en:'Rectangle',
   cins:'bêcins', ez:null, kat:'matematîk', zor:0.75,
   not:'Matematik terimi: dikdörtgen. Tanım ve örnek FerMat terim tabanından.',
   her:['Derî çarçik e: du hêlên dirêj (bilindahî) û du hêlên kurt (firehî), hemû goşe 90°.', 'Teşeya girtî ku çar hêl û çar goşeyên rast (90°) hene; du hêlên berember dirêj in, du hêlên din kurt in.'],
   gen:['Li malê: derî çarçik e, textê çarçik e, pencere çarçik e — li derdora xwe çend çarçik dibînî?']),

  (id:'a2_mt_20', ku:'Çep', tr:'Sol', en:'Left',
   cins:'bêcins', ez:null, kat:'matematîk', zor:0.75,
   not:'Matematik terimi: sol. Tanım ve örnek FerMat terim tabanından.',
   her:['Destê çep li aliyê çepê ye, destê rast li aliyê rastê — du arah!', 'Du arahên berevajî yên leqî: çep = aliyê destê çepê, rast = aliyê destê rastê.'],
   gen:['Di trafîkê de dê dibêje: \'Li çepê biçe, paşê li rastê!\' — zarok arahên xwe dizane!']),

  (id:'a2_mt_21', ku:'Şaşî', tr:'Hata', en:'Error',
   cins:'mê', ez:'şaşiya', kat:'matematîk', zor:0.75,
   not:'Matematik terimi: hata. Tanım ve örnek FerMat terim tabanından.',
   her:['3+4=8 — şaşî ye! Lê ne xirab e: sererast bike: 3+4=7. Ji şaşiyê hîn bû!', 'Bersîva ku ne rast e; firsendek ji bo fêrbûnê ye — ji şaşiyan em hîn dibin!'],
   gen:['Zarokên ku şaşî dikin û sererast dikin, zûtir hîn dibin! Mamoste dibêje: \'Şaşî ne xirab e — girîng e ku sererast bikî!\'']),

];
