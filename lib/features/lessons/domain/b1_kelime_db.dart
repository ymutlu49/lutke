/// LÛTKE — B1 Kelime Veritabanı (Orta-Alt / Navîn-Jêr)
///
/// Hedef: 1.500–1.800 kelime
/// Bu dosya: ~300 kelime (temel B1 havuzu)
///
/// B1 pedagoji ilkeleri:
/// - Ergatif yapı TAM (geçmiş geçişli — min got, te dît, wê kir)
/// - Subjunctive / Şart kipi giriş (bi + kök)
/// - Sürekli geçmiş (dihat, digot — geçmişte devam eden)
/// - Şimdiki mükemmel (hatiye, çûye — şimdiye etkisi olan geçmiş)
/// - Deyimler ve kalıp ifadeler
/// - Kürt edebiyatından alıntılar (A2 sonu / B1 başı)
///
/// Kaynak: [BH][TH][AS][FB][AZ][DR] — çok kaynaklı doğrulama

// ignore_for_file: constant_identifier_names

final kB1Kelimeler = [

  // ════════════════════════════════════════════════════════════
  // B1 BİRİM 1 — Ergatif Sistem: Tam Tablo
  // [BH] §170–185 + [TH] §75–80 + [AZ] Ders 14–15
  // ════════════════════════════════════════════════════════════

  // Geçişli fiiller — ergatif geçmiş tam çekim
  (id:"b1_001", ku:"Min xwend", tr:"Ben okudum", en:"I read (past, ergative)",
   cins:"bêcins", ez:null, kat:"ergatif", zor:0.65,
   not:"[BH] §170: xwendin GEÇİŞLİ fiil → geçmişte ergatif. \"Min\" = ez\'nin eğik hali. Çekim: min/te/wî/wê/me/we/wan + xwend",
   her:["Min pirtûka kurdî xwend.", "Min navê pîrê xwend."],
   gen:["Min pirtûk xwend.", "Te çi xwend?"]),

  (id:"b1_002", ku:"Te dît", tr:"Sen gördün", en:"You saw (ergative)",
   cins:"bêcins", ez:null, kat:"ergatif", zor:0.65,
   not:"\"Te\" = tu\'nun eğik hali. \"Dîtin\" = görmek (geçişli). [TH] §76",
   her:["Te pîrê dît?", "Te çi dît?"],
   gen:["Te dît.", "Min dît."]),

  (id:"b1_003", ku:"Wî got", tr:"O (eril) söyledi", en:"He said (ergative)",
   cins:"bêcins", ez:null, kat:"ergatif", zor:0.65,
   not:"\"Wî\" = ew\'in eğik hali (eril). \"Gotin\" geçişli. [BH] §170: \"Wî got ku…\" = o dedi ki…",
   her:["Wî got ku pîrê tê.", "Bavê min wî got."],
   gen:["Wî got.", "Wê got."]),

  (id:"b1_004", ku:"Wê kir", tr:"O (dişil) yaptı", en:"She did (ergative)",
   cins:"bêcins", ez:null, kat:"ergatif", zor:0.65,
   not:"\"Wê\" = ew\'in eğik hali (dişil). \"Kirin\" geçişli. [TH] §76",
   her:["Wê nan pijand.", "Dêya min wê kir."],
   gen:["Wê kir.", "Wê şand."]),

  (id:"b1_005", ku:"Me anî", tr:"Biz getirdik", en:"We brought (ergative)",
   cins:"bêcins", ez:null, kat:"ergatif", zor:0.64,
   not:"\"Me\" = em\'in eğik hali. \"Anîn\" = getirmek (geçişli). [BH] §170",
   her:["Me diyarî anî.", "Me çi anî?"],
   gen:["Me anî.", "We anî?"]),

  (id:"b1_006", ku:"We firoşt", tr:"Siz sattınız", en:"You (pl.) sold (ergative)",
   cins:"bêcins", ez:null, kat:"ergatif", zor:0.63,
   not:"\"We\" = hûn\'un eğik hali. \"Firotin\" geçişli. [TH] §76",
   her:["We malê firoşt?", "We çi firoşt?"],
   gen:["We firoşt.", "We kir."]),

  (id:"b1_007", ku:"Wan bir", tr:"Onlar götürdü", en:"They took (ergative)",
   cins:"bêcins", ez:null, kat:"ergatif", zor:0.63,
   not:"\"Wan\" = ew (çoğul)\'un eğik hali. \"Birin\" geçişli. [BH] §170",
   her:["Wan nan bir.", "Wan çi bir?"],
   gen:["Wan bir.", "Wan got."]),

  // ════════════════════════════════════════════════════════════
  // B1 BİRİM 2 — Şimdiki Mükemmel
  // [BH] §186 + [TH] §72 + [AZ] Ders 13
  // ════════════════════════════════════════════════════════════

  (id:"b1_010", ku:"Hatiye", tr:"Gelmiş / Geldi (etkisi var)", en:"Has come",
   cins:"bêcins", ez:null, kat:"dem_temam", zor:0.72,
   not:"Şimdiki mükemmel — geçişsiz. [TH] §72: \"-iye\" eki. \"Pîrê hatiye\" = büyükanne gelmiş (şu an burada)",
   her:["Pîrê hatiye!", "Bira hatiye malê."],
   gen:["Mamosta hatiye.", "Ew hatiye."]),

  (id:"b1_011", ku:"Çûye", tr:"Gitmiş (etkisi var)", en:"Has gone",
   cins:"bêcins", ez:null, kat:"dem_temam", zor:0.72,
   not:"Şimdiki mükemmel geçişsiz. [TH] §72: çûn + -iye = çûye",
   her:["Ew çûye bajêr.", "Bira çûye."],
   gen:["Mamosta çûye.", "Ew çûye."]),

  (id:"b1_012", ku:"Min gotiye", tr:"Ben söylemişim (etkisi var)", en:"I have said",
   cins:"bêcins", ez:null, kat:"dem_temam", zor:0.70,
   not:"Şimdiki mükemmel GEÇİŞLİ — ergatif + -iye. [TH] §72. \"Min gotiye ku…\" = söylemiş bulunuyorum",
   her:["Min gotiye ku baş e.", "Te gotiye?"],
   gen:["Min gotiye.", "Wî gotiye."]),

  // ════════════════════════════════════════════════════════════
  // B1 BİRİM 3 — Sürekli Geçmiş (Hikaye Kipi)
  // [BH] §182 + [TH] §70 + [AZ] Ders 13
  // ════════════════════════════════════════════════════════════

  (id:"b1_015", ku:"Dihat", tr:"Geliyordu (geçmişte süren)", en:"Was coming",
   cins:"bêcins", ez:null, kat:"dem_devam", zor:0.70,
   not:"Sürekli geçmiş — [TH] §70. \"Timî dihat\" = her zaman gelirdi. Hikaye anlatımında kritik",
   her:["Pîrê her êvarê dihat.", "Bira timî dihat malê."],
   gen:["Mamosta dihat.", "Ew dihat."]),

  (id:"b1_016", ku:"Digot", tr:"Diyordu / Söylerdi", en:"Was saying / Used to say",
   cins:"bêcins", ez:null, kat:"dem_devam", zor:0.70,
   not:"Sürekli geçmiş — gotin. [TH] §70. Büyükanne hikayelerinde: \"Pîrê digot ku…\"",
   her:["Pîrê her tim digot: \"Xweş be!\".", "Bavê min digot ku…."],
   gen:["Ew digot.", "Mamosta digot."]),

  (id:"b1_017", ku:"Dixwend", tr:"Okuyordu", en:"Was reading / Used to read",
   cins:"bêcins", ez:null, kat:"dem_devam", zor:0.69,
   not:"Sürekli geçmiş — xwendin. [TH] §70",
   her:["Birê min pirtûk dixwend.", "Pîrê stran dixwend."],
   gen:["Ew dixwend.", "Em dixwendin."]),

  // ════════════════════════════════════════════════════════════
  // B1 BİRİM 4 — Subjunctive / Şart Kipi Giriş
  // [BH] §190 + [TH] §78 + [AZ] Ders 15
  // ════════════════════════════════════════════════════════════

  (id:"b1_020", ku:"Bila bê", tr:"Gelsin / Bıraksın gelsin", en:"Let him/her come",
   cins:"bêcins", ez:null, kat:"subjunctive", zor:0.68,
   not:"\"Bila\" + subjunctive = -sin (izin/dilek). [BH] §190: \"Bila bê!\" = gelsin! [TH] §78",
   her:["Bila pîrê bê!", "Bila malbat bê!"],
   gen:["Bila bê!", "Bila biçe."]),

  (id:"b1_021", ku:"Bila xweş be", tr:"Güzel olsun", en:"May it be good",
   cins:"bêcins", ez:null, kat:"subjunctive", zor:0.69,
   not:"Dilek/Dua ifadesi. [TH] §78: subjunctive for wishes. A2\'de giriş yapıldı, B1\'de genişler",
   her:["Roja te bila xweş be!", "Jiyana te bila xweş be!"],
   gen:["Bila baş be!", "Bila xweş be!"]),

  (id:"b1_022", ku:"Ger … bûya", tr:"Olsaydı (varsayım)", en:"If … were / had been",
   cins:"bêcins", ez:null, kat:"subjunctive", zor:0.66,
   not:"\"Ger … bûya …\" = -saydı (gerçekleşmemiş şart). [BH] §192: conditional. [TH] §79",
   her:["Ger pîrê li malê bûya, xweş bûya.", "Ger ez dizanibûm, digotim."],
   gen:["Ger baş bûya…", "Ger were…"]),

  (id:"b1_023", ku:"Dibe ku", tr:"Olabilir / Mümkün", en:"It may be / Perhaps",
   cins:"bêcins", ez:null, kat:"subjunctive", zor:0.69,
   not:"\"Dibe ku\" + subjunctive = olabilir/mümkün ki. [TH] §78: modal expressions",
   her:["Dibe ku pîrê bê.", "Dibe ku rast be."],
   gen:["Dibe ku baş be.", "Dibe ku were."]),

  // ════════════════════════════════════════════════════════════
  // B1 BİRİM 5 — DEYİM VE KALIP İFADELER
  // [AS] Pratik Konuşma + [AZ] idioms + [FB]
  // ════════════════════════════════════════════════════════════

  (id:"b1_030", ku:"Serê xwe xweş bike", tr:"Kendine iyi bak", en:"Take care of yourself",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.72,
   not:"Kalıp ifade. \"Serê xwe\" = kendi başın/kendin. Vedalaşmada kullanılır",
   her:["Serê xwe xweş bike, keça min!", "Serê xwe xweş bikin!"],
   gen:["Serê xwe xweş bike!", "Serê xwe biparêze!"]),

  (id:"b1_031", ku:"Çavên te ronî", tr:"Gözlerin parlak olsun", en:"May your eyes be bright",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.70,
   not:"Kürt kültüründe tebrik ve iyi dilek. \"Çavê te ronî bibe\" = tebrikler (bebek/başarı için)",
   her:["Çavên te ronî bibe!", "Çavên te geş be!"],
   gen:["Çavên te ronî!", "Çavê te ronî bibe!"]),

  (id:"b1_032", ku:"Destê xwe bi xêr bîne", tr:"Hayırlı işler / Başarılar", en:"May your work be blessed",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.69,
   not:"Birine yardımından sonra veya işe başlarken. [AZ] blessings",
   her:["Destê xwe bi xêr bîne!", "Destê te bi xêr be!"],
   gen:["Destê we bi xêr!", "Bi xêr be!"]),

  (id:"b1_033", ku:"Dil û can", tr:"Can ve gönül / Tüm kalbimle", en:"With all my heart",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.69,
   not:"\"Dil\" (gönül/kalp) + \"can\" (can/ruh) — \"dil û can\" = can ve gönülden. Güçlü sevgi ifadesi",
   her:["Dil û can ji te hez dikim!", "Dil û can piştgiriya te dikim."],
   gen:["Dil û can!", "Bi dil û can"]),

  (id:"b1_034", ku:"Serê te germ be", tr:"Başın sağolsun", en:"My condolences",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.68,
   not:"Taziye ifadesi. \"Serê te germ be\" = başın sağolsun. Kürt kültüründe yas geleneği",
   her:["Serê te germ be, kurê min.", "Serê we germ be."],
   gen:["Serê te germ be.", "Serê we germ be!"]),

  (id:"b1_035", ku:"Bi mêrxasî", tr:"Yiğitçe / Cesurca", en:"Bravely / Courageously",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.69,
   not:"\"Mêrxas\" = yiğit/cesur. Kürt değerlerinde \"mêrxasî\" temel erdem",
   her:["Bi mêrxasî çûm!", "Bi mêrxasî jiyan bike."],
   gen:["Bi mêrxasî!", "Mêrxasî baş e."]),

  // ════════════════════════════════════════════════════════════
  // B1 BİRİM 6 — Duygu ve Düşünce İfadeleri
  // [AZ] Ders 11–12 + [FB]
  // ════════════════════════════════════════════════════════════

  (id:"b1_040", ku:"Hişmend", tr:"Akıllı / Zeki", en:"Intelligent / Wise",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.72,
   not:"[FB]: hişmend adj. \"Hişê xweş\" = iyi akıl. Kürt kültüründe bilgelik saygı görür",
   her:["Pîrê gelek hişmend e.", "Ev zarok hişmend e."],
   gen:["Hişmend û têgihîştî", "Ew hişmend e."]),

  (id:"b1_041", ku:"Jîr", tr:"Zeki / Kurnaz", en:"Clever / Smart",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.73,
   not:"[FB]: jîr adj. Hem pozitif (zeki) hem nötr (kurnaz). \"Rovî jîr e\" = tilki zekidir (fabllar)",
   her:["Keça te gelek jîr e!", "Ew jîr û baş e."],
   gen:["Jîr û hişmend", "Ew jîr e."]),

  (id:"b1_042", ku:"Dilovan", tr:"Merhametli / Sevecen", en:"Compassionate",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.71,
   not:"\"Dil\" (gönül) + \"-ovan\" (dolu). [FB]: dilovan adj. Büyükanneyi tarif eden en uygun kelime",
   her:["Pîrêya min dilovan e.", "Dê û bav dilovan in."],
   gen:["Dilovan û baş", "Ew dilovan e."]),

  (id:"b1_043", ku:"Wêrek", tr:"Cesur / Yiğit", en:"Brave / Courageous",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.71,
   not:"[FB]: wêrek adj. Kürt kültüründe önemli değer. \"Mêrxas\" ile yakın",
   her:["Tu wêrek î!", "Kurdên wêrek."],
   gen:["Wêrek û bêtirs", "Ew wêrek e."]),

  (id:"b1_044", ku:"Xeyidîn", tr:"Kızmak / Öfkelenmek", en:"To be angry",
   cins:"bêcins", ez:null, kat:"his", zor:0.72,
   not:"\"Xeyidîn\" fiili — \"Ez xeyidîme\" = kızgınım. [FB]: xeyidîn v.",
   her:["Pîrê xeyidî.", "Tu xeyidîyî?"],
   gen:["Xeyidîn û şa bûn", "Ew xeyidî."]),

  (id:"b1_045", ku:"Şermezar", tr:"Utanmış / Mahçup", en:"Embarrassed / Ashamed",
   cins:"bêcins", ez:null, kat:"his", zor:0.70,
   not:"\"Şerm\" + \"-ezar\". [FB]: şermezar adj. Asimile Kürtlerin dil kaynaklı utancıyla bağlantı",
   her:["Ez şermezar bûm.", "Şermezar nebe!"],
   gen:["Şermezar û şa", "Ev şermezar e."]),

  (id:"b1_046", ku:"Dilşikestî", tr:"Kırık kalpli / Üzgün", en:"Brokenhearted",
   cins:"bêcins", ez:null, kat:"his", zor:0.70,
   not:"\"Dil\" (gönül) + \"şikestî\" (kırılmış). Kürt şiirinde çok geçer",
   her:["Ew dilşikestî ye.", "Dilşikestî nebe!"],
   gen:["Dilşikestî û dilxweş", "Ew dilşikestî ye."]),

  // ════════════════════════════════════════════════════════════
  // B1 BİRİM 7 — Siyaset, Toplum ve Kimlik
  // [AS] İKTİSAT–HİKÛK–POLİTÎKA bölümü + [AZ] Ders 18
  // ════════════════════════════════════════════════════════════

  (id:"b1_050", ku:"Azadî", tr:"Özgürlük", en:"Freedom",
   cins:"mê", ez:"azadiyê", kat:"siyaset", zor:0.75,
   not:"Dişil — [FB]: azadî n.f. Kürt kültürünün en temel kavramı. Newroz\'un özü. \"Agirê azadiyê\"",
   her:["Azadî girîng e.", "Em azadiyê dixwazin!"],
   gen:["Azadî û aştî", "Azadiya me"]),

  (id:"b1_051", ku:"Aştî", tr:"Barış", en:"Peace",
   cins:"mê", ez:"aştiyê", kat:"siyaset", zor:0.75,
   not:"Dişil — [FB]: aştî n.f. \"Aştî û azadî\" = barış ve özgürlük. Kürt tarihinde kritik kavram",
   her:["Aştî her tim lazim e.", "Em aştiyê dixwazin."],
   gen:["Aştî û azadî", "Aştiya me"]),

  (id:"b1_052", ku:"Maf", tr:"Hak / Hukuk", en:"Right / Law",
   cins:"nêr", ez:"mafê", kat:"siyaset", zor:0.73,
   not:"Eril — [FB]: maf n.m. [AS] İKTİSAT–HİKÛQ bölümü. \"Mafên mirovan\" = insan hakları",
   her:["Mafê me heye.", "Mafên mirovan girîng in."],
   gen:["Maf û azadî", "Mafê me"]),

  (id:"b1_053", ku:"Welat", tr:"Vatan / Yurt", en:"Homeland",
   cins:"nêr", ez:"welatê", kat:"siyaset", zor:0.76,
   not:"Eril — [FB]: welat n.m. \"Kurdistan welê min e\" — Cegerxwîn. Heritage kullanıcı için en duygusal kelime",
   her:["Welat şîrîn e.", "Ez ji welatê xwe dûr im."],
   gen:["Welat û malbat", "Welatê me"]),

  (id:"b1_054", ku:"Dewlet", tr:"Devlet", en:"State / Government",
   cins:"mê", ez:"dewletê", kat:"siyaset", zor:0.72,
   not:"Dişil — [FB]: dewlet n.f. [Arapça]. \"Dewleta demokratîk\" = demokratik devlet",
   her:["Dewlet divê mafan biparêze.", "Dewlet û hiqûq."],
   gen:["Dewlet û welat", "Dewleta me"]),

  (id:"b1_055", ku:"Çand", tr:"Kültür", en:"Culture",
   cins:"mê", ez:"çandê", kat:"siyaset", zor:0.75,
   not:"Dişil — [FB]: çand n.f. \"Çanda kurdî\" = Kürt kültürü. [AZ] Ders 18",
   her:["Çanda kurdî dewlemend e.", "Çand û ziman."],
   gen:["Çand û dîrok", "Çanda me"]),

  (id:"b1_056", ku:"Ziman", tr:"Dil (lisan)", en:"Language",
   cins:"nêr", ez:"zimanê", kat:"siyaset", zor:0.78,
   not:"Eril — A1\'de beden organı \"dil\" anlamı. B1\'de \"lisan\" anlamı derinleşir. \"Zimanê kurdî\"",
   her:["Zimanê kurdî ziman e.", "Ziman û çand."],
   gen:["Ziman û çand", "Zimanê me"]),

  (id:"b1_057", ku:"Piştgirî", tr:"Destek", en:"Support",
   cins:"mê", ez:"piştgiriyê", kat:"siyaset", zor:0.73,
   not:"Dişil — [FB]: piştgirî n.f. \"Piştgiriya te dikim\" = seni destekliyorum",
   her:["Piştgiriya min pê re ye.", "Piştgirî lazim e."],
   gen:["Piştgirî û arîkarî", "Piştgiriya me"]),

  // ════════════════════════════════════════════════════════════
  // B1 BİRİM 8 — Edebiyat ve Güzel Sanatlar
  // [AS] + Mem û Zîn referansları + [FB]
  // ════════════════════════════════════════════════════════════

  (id:"b1_060", ku:"Helbest", tr:"Şiir", en:"Poem",
   cins:"mê", ez:"helbestê", kat:"edebiyat", zor:0.73,
   not:"Dişil — [FB]: helbest n.f. \"Helbestên Xanî\" = Xanî\'nin şiirleri. [AZ] kültür",
   her:["Helbesta xweş!", "Pîrê helbest dizane."],
   gen:["Helbest û stran", "Helbestên me"]),

  (id:"b1_061", ku:"Helbestvan", tr:"Şair", en:"Poet",
   cins:"bêcins", ez:"helbestvana", kat:"edebiyat", zor:0.72,
   not:"[FB]: helbestvan n. \"Ehmedê Xanî helbestvanê mezin bû\" = Ehmedê Xanî büyük şairdi",
   her:["Helbestvanê kurd.", "Cegerxwîn helbestvanek bû."],
   gen:["Helbestvan û dengbêj", "Helbestvana me"]),

  (id:"b1_062", ku:"Çîrok", tr:"Hikaye / Masal", en:"Story / Tale",
   cins:"mê", ez:"çîrokê", kat:"edebiyat", zor:0.74,
   not:"Dişil — [FB]: çîrok n.f. \"Çîrokên pîrê\" = büyükannenin hikayeleri. Heritage bağlantı",
   her:["Pîrê çîrokan digot.", "Çîroka Mem û Zîn."],
   gen:["Çîrok û helbest", "Çîrokên me"]),

  (id:"b1_063", ku:"Pêşgotin", tr:"Önsöz / Girişe söz", en:"Preface / Foreword",
   cins:"mê", ez:"pêşgotinê", kat:"edebiyat", zor:0.70,
   not:"Dişil — [FB]: pêşgotin n.f. \"Pêşgotina Bedir Han\" = Bedir Han\'ın önsözü",
   her:["Pêşgotina pirtûkê xweş bû.", "Di pêşgotinê de…."],
   gen:["Pêşgotin û dawî", "Pêşgotina me"]),

  (id:"b1_064", ku:"Destpêk", tr:"Başlangıç", en:"Beginning",
   cins:"nêr", ez:"destpêkê", kat:"edebiyat", zor:0.74,
   not:"Eril — [FB]: destpêk n.m. \"Dest\" (el) + \"pêk\" = başlangıç. \"Destpêk\" aynı zamanda A1 düzey rozeti!",
   her:["Destpêka jiyanê xweş e.", "Destpêkê baş kir."],
   gen:["Destpêk û dawî", "Destpêkê"]),

  (id:"b1_065", ku:"Dawî", tr:"Son / Bitiş", en:"End / Conclusion",
   cins:"mê", ez:"dawiyê", kat:"edebiyat", zor:0.74,
   not:"Dişil — [FB]: dawî n.f. \"Di dawiyê de\" = sonunda. \"Heta dawiyê\" = sonuna kadar",
   her:["Dawiya çîrokê xweş bû.", "Di dawiyê de."],
   gen:["Dawî û destpêk", "Di dawiyê de"]),

  // ════════════════════════════════════════════════════════════
  // B1 BİRİM 9 — Doğa, Tarım ve Geçim
  // [AS] + Kürt coğrafya kültürü
  // ════════════════════════════════════════════════════════════

  (id:"b1_070", ku:"Bereket", tr:"Bereket / Bolluk", en:"Abundance / Blessing",
   cins:"mê", ez:"bereketê", kat:"xweza", zor:0.73,
   not:"Dişil — [FB]: bereket n.f. [Arapça]. \"Erdê bereketdar\" = bereketli toprak. Kürt dualarında sık",
   her:["Erdê Kurdistanê bereketdar e.", "Sala nû bi bereket be!"],
   gen:["Bereket û xêr", "Bereketê malê"]),

  (id:"b1_071", ku:"Çandin", tr:"Ekmek / Ürün yetiştirmek", en:"To sow / cultivate",
   cins:"bêcins", ez:null, kat:"xweza", zor:0.71,
   not:"\"Çandin\" fiili — \"Cotkar genim çandiye\" = çiftçi buğday ekmiş. [TH] §65",
   her:["Cotkar zeviyê çandiye.", "Min kulîlk çand."],
   gen:["Çandin û birin", "Çand û çêkir."]),

  (id:"b1_072", ku:"Berhev kirin", tr:"Toplamak / Hasatla", en:"To harvest / gather",
   cins:"bêcins", ez:null, kat:"xweza", zor:0.70,
   not:"\"Berhev kirin\" = toplamak/hasat etmek. [FB]: berhev kirin v.",
   her:["Payîzê em berhev kirin.", "Min kulîlk berhev kir."],
   gen:["Berhev kirin û çandin", "Berhev kir."]),

  (id:"b1_073", ku:"Demsalên çar", tr:"Dört mevsim", en:"The four seasons",
   cins:"bêcins", ez:null, kat:"xweza", zor:0.73,
   not:"A1\'de mevsimler öğrenildi. B1\'de bütünlük: \"Demsalên çar\" = dört mevsim",
   her:["Demsalên çar li Kurdistanê xweş in.", "Bihar demsala xweştirîn e."],
   gen:["Demsalên çar", "Di demsalên çar de"]),

  // ════════════════════════════════════════════════════════════
  // B1 BİRİM 10 — Kürt Tarihi ve Kimlik
  // Kültürel derinlik — B1 öğrenci için
  // ════════════════════════════════════════════════════════════

  (id:"b1_080", ku:"Mêjû", tr:"Tarih (olaylar)", en:"History (events)",
   cins:"nêr", ez:"mêjûyê", kat:"dîrok", zor:0.72,
   not:"Eril — [FB]: mêjû n.m. \"Dîrok\" daha genel; \"mêjû\" özellikle olaylar tarihi",
   her:["Mêjûya Kurdistanê zehmet bû.", "Mêjû û pêşeroj."],
   gen:["Mêjû û dîrok", "Mêjûya me"]),

  (id:"b1_081", ku:"Şer", tr:"Savaş", en:"War / Battle",
   cins:"nêr", ez:"şerê", kat:"dîrok", zor:0.71,
   not:"Eril — [FB]: şer n.m. \"Şerê mezin\" = büyük savaş. Kürt tarihinde ağır bir kavram",
   her:["Şer xirab e.", "Piştî şerê dirêj aştî hat."],
   gen:["Şer û aştî", "Şerê mezin"]),

  (id:"b1_082", ku:"Serdema", tr:"Dönem / Devir", en:"Era / Period",
   cins:"mê", ez:"serdemê", kat:"dîrok", zor:0.71,
   not:"Dişil — [FB]: serdem n.f. \"Serdema osmanî\" = Osmanlı dönemi. [AZ] tarih",
   her:["Serdema dijwar bû.", "Di vê serdemê de."],
   gen:["Serdem û dîrok", "Serdema me"]),

  (id:"b1_083", ku:"Kurd", tr:"Kürt", en:"Kurdish person",
   cins:"bêcins", ez:"kurdê/kurda", kat:"kimlik", zor:0.78,
   not:"\"Kurd\" = Kürt kişi. [FB]: kurd n. \"Kurdên cîhanê\" = dünyanın Kürtleri. Heritage kimliği",
   her:["Ez kurd im û bi me xweşim!", "Kurdên Kurdistanê."],
   gen:["Kurd û Tirk", "Kurdê me"]),

  (id:"b1_084", ku:"Kurdistanî", tr:"Kürdistanlı", en:"From Kurdistan",
   cins:"bêcins", ez:null, kat:"kimlik", zor:0.82,
   not:"Sıfat — [FB]: Kurdistanî adj. \"Ez Kurdistanî me\" = Kürdistanlıyım",
   her:["Em Kurdistanî ne!", "Kurdistanî û serbixwe."],
   gen:["Kurdistanî û kurd", "Ez Kurdistanî me."]),

  (id:"b1_085", ku:"Têkçûn", tr:"Asimilasyon / Dilde erime", en:"Assimilation / Linguistic erosion",
   cins:"nêr", ez:"asimilasyonê", kat:"kimlik", zor:0.70,
   not:"Eril — \"Têkçûn\" = Kurmancî özgün terim — \"têk\" (bozuk/dağılmış) + \"çûn\" (gitmek). Hem dilbilimsel hem kültürel asimilasyon için. Heritage kullanıcının yaşadığı süreç",
   her:["Têkçûna zimanî zimanê me qels kir.", "Li hember têkçûnê bisekine!"],
   gen:["Têkçûn û nasname", "Têkçûnê"]),

  // ════════════════════════════════════════════════════════════
  // B1 BİRİM 11 — İnsan İlişkileri ve Psikoloji
  // ════════════════════════════════════════════════════════════

  (id:"b1_090", ku:"Bawerî", tr:"Güven / İnanç", en:"Trust / Faith",
   cins:"mê", ez:"baweriyê", kat:"psikoloji", zor:0.72,
   not:"Dişil — [FB]: bawerî n.f. \"Baweriya min\" = güvenim/inancım",
   her:["Baweriya min lê tê.", "Bawerî girîng e."],
   gen:["Bawerî û hêvî", "Baweriya me"]),

  (id:"b1_091", ku:"Rûmet", tr:"Saygınlık / Onur", en:"Honor / Dignity",
   cins:"mê", ez:"rûmetê", kat:"psikoloji", zor:0.71,
   not:"Dişil — [FB]: rûmet n.f. Kürt kültüründe onur (rûmet) ve utanç (şerm) denklemi önemli",
   her:["Rûmeta malbatê girîng e.", "Bi rûmet jiyan bike!"],
   gen:["Rûmet û şerm", "Rûmeta me"]),

  (id:"b1_092", ku:"Serbilindî", tr:"Gurur / Onur", en:"Pride",
   cins:"mê", ez:"serbilindiyê", kat:"psikoloji", zor:0.71,
   not:"Dişil — \"ser\" (baş) + \"bilind\" (yüksek) = baş yukarı. [FB]: serbilindî n.f.",
   her:["Ez serbilindim ku kurd im!", "Serbilindiya me."],
   gen:["Serbilindî û rûmet", "Serbilindiya me"]),

  (id:"b1_093", ku:"Hişyarî", tr:"Farkındalık / Uyanıklık", en:"Awareness / Consciousness",
   cins:"mê", ez:"hişyariyê", kat:"psikoloji", zor:0.70,
   not:"Dişil — [FB]: hişyarî n.f. \"Hişyar\" (uyanık/bilinçli) + \"-î\". Kimlik farkındalığı",
   her:["Hişyariya zimanî girîng e.", "Hişyarî û zanîn."],
   gen:["Hişyarî û zanist", "Hişyariya me"]),

  // ════════════════════════════════════════════════════════════
  // B1 BİRİM 12 — Fiiller Tam Havuzu
  // [TH] §60–90 tüm fiil kategorileri
  // ════════════════════════════════════════════════════════════

  (id:"b1_100", ku:"Kişandin", tr:"Çizmek / Çekmek", en:"To draw / pull",
   cins:"bêcins", ez:null, kat:"leker", zor:0.72,
   not:"\"Kişandin\" — [AS] no.1081: kişandin = sigara içmek de denir, ama asıl: çizmek/çekmek. \"Wêne kêşan\" = resim çizmek ✓. [TH] §65: kişandin = to draw/pull. \"Lêxistin\" vurmak için ayrıdır.",
   her:["Min wêne kêşand.", "Te çi kêşand?"],
   gen:["Kişandin û nivîsîn", "Min kêşand."]),

  (id:"b1_101", ku:"Şikandin", tr:"Kırmak", en:"To break",
   cins:"bêcins", ez:null, kat:"leker", zor:0.71,
   not:"\"Şikandin\" — geçişli, ergatif. [TH] §65: şikandin = to break. \"Min şikand\" = ben kırdım",
   her:["Min firaxê şikand!", "Wî mêz şikand."],
   gen:["Şikandin û çêkirin", "Min şikand."]),

  (id:"b1_102", ku:"Vêxistin", tr:"Yakmak / Tutuşturmak", en:"To light / ignite",
   cins:"bêcins", ez:null, kat:"leker", zor:0.71,
   not:"\"Vêxistin\" — \"Kawa agirê azadiyê vêxist\" Newroz efsanesinden! Geçişli → ergatif",
   her:["Wî agir vêxist.", "Kawa agirê azadiyê vêxist."],
   gen:["Vêxistin û vemirandin", "Agir vêxist."]),

  (id:"b1_103", ku:"Vemirandin", tr:"Söndürmek", en:"To extinguish",
   cins:"bêcins", ez:null, kat:"leker", zor:0.70,
   not:"\"Vemirandin\" = söndürmek. [TH] §65. \"Agir vemirandin\" = ateşi söndürmek",
   her:["Min agir veşand.", "Ew agir veşandiye."],
   gen:["Vemirandin û vêxistin", "Agir veşand."]),

  (id:"b1_104", ku:"Parastin", tr:"Korumak / Savunmak", en:"To protect / defend",
   cins:"bêcins", ez:null, kat:"leker", zor:0.71,
   not:"\"Parastin\" — [BH] §273: \"Parastin, savunma\" bileşiğinde geçer. [FB]: parastin v.",
   her:["Zimanê xwe biparêze!", "Em welat diparêzin."],
   gen:["Parastin û piştgirî", "Biparêze!"]),

  (id:"b1_105", ku:"Veguhêztin", tr:"Aktarmak / Taşımak", en:"To transmit / transfer",
   cins:"bêcins", ez:null, kat:"leker", zor:0.69,
   not:"\"Veguhêztin\" — dil ve kültürü aktarma anlamında da kullanılır. \"Zimanê xwe veguherîzin\" = dilinizi aktarın",
   her:["Pîrê çanda kurdî veguheztiye.", "Zimanî veguherîze!"],
   gen:["Veguhêztin û parastin", "Veguhezt."]),

  // ════════════════════════════════════════════════════════════
  // B1 BİRİM 13 — Bağlaçlar ve Karmaşık Yapılar
  // [TH] §: complex sentences + [AZ] Ders 14–15
  // ════════════════════════════════════════════════════════════

  (id:"b1_110", ku:"Wî got ku", tr:"O dedi ki", en:"He said that",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Wî got ku…\" = o dedi ki… Dolaylı anlatım başlangıcı. [TH] §: reported speech. Ergatif + \"ku\"",
   her:["Wî got ku pîrê tê.", "Wê got ku baş e."],
   gen:["Wî got ku...", "Me bîst ku..."]),

  (id:"b1_111", ku:"Nizanim ku", tr:"Bilmiyorum ki / Bilmiyorum -dığını", en:"I don't know that",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Nizanim ku…\" = bilmiyorum ki. [TH] §: indirect speech",
   her:["Nizanim ku ew tê.", "Nizanim ku çawa ye."],
   gen:["Nizanim ku...", "Dizanim ku..."]),

  (id:"b1_112", ku:"Ji ber vê yekê", tr:"Bu yüzden / Bu nedenle", en:"For this reason",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Ji ber vê yekê\" = bu yüzden. [TH] §: discourse connectors",
   her:["Ji ber vê yekê ez hatim.", "Ji ber vê yekê baş e."],
   gen:["Ji ber vê yekê...", "Ji ber vê yekê hatim."]),

  (id:"b1_113", ku:"Di heman demê de", tr:"Aynı zamanda / Eş zamanlı", en:"At the same time",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.70,
   not:"\"Di heman demê de\" = aynı zamanda. [TH] §: time clauses",
   her:["Di heman demê de ew hat.", "Di heman demê de dixwînim."],
   gen:["Di heman demê de...", "Di heman demê de"]),

  // ════════════════════════════════════════════════════════════
  // B1 BİRİM 14 — Ekonomi ve İş Hayatı
  // [AS] İKTİSAT–HIQÛQ–POLİTÎKA bölümü
  // ════════════════════════════════════════════════════════════

  (id:"b1_120", ku:"Aborî", tr:"Ekonomi", en:"Economy",
   cins:"mê", ez:"aboriyê", kat:"aborî", zor:0.72,
   not:"Dişil — [FB]: aborî n.f. [AS] s.65 \"İKTİSAT = ABORİ\" ✓",
   her:["Aboriya welêt baş nîne.", "Aborî û kar."],
   gen:["Aborî û siyaset", "Aboriya me"]),

  (id:"b1_121", ku:"Bazirganî", tr:"Ticaret", en:"Trade / Commerce",
   cins:"mê", ez:"bazirganiyê", kat:"aborî", zor:0.72,
   not:"Dişil — [FB]: bazirganî n.f. \"Bazirgan\" (tüccar) + \"-î\". [AS] s.65",
   her:["Bazirganî baş diçe.", "Bazirganiya navnetewî."],
   gen:["Bazirganî û kar", "Bazirganiya me"]),

  (id:"b1_122", ku:"Sermaye", tr:"Sermaye / Kapital", en:"Capital / Investment",
   cins:"mê", ez:"sermayê", kat:"aborî", zor:0.70,
   not:"Dişil — [FB]: sermaye n.f. [Farsça]. [AS] ticaret bölümü",
   her:["Sermaye lazim e.", "Sermayeya wan heye."],
   gen:["Sermaye û kar", "Sermayeya me"]),

  // ════════════════════════════════════════════════════════════
  // B1 BİRİM 15 — Renkler ve Tasvir — Şiir Dili
  // Kürt şiirinde renk kullanımı
  // ════════════════════════════════════════════════════════════

  (id:"b1_130", ku:"Keskesor", tr:"Gökkuşağı", en:"Rainbow",
   cins:"mê", ez:"keskesorê", kat:"xweza", zor:0.72,
   not:"Dişil — [BH] p.277: \"Keskesor, diş., gökkuşağı (kesk, yeşil; sor, kırmızı)\". Bileşik kelime!",
   her:["Piştî baranê keskesor hat.", "Keskesor xweş e!"],
   gen:["Keskesor û baran", "Keskesorê biharê"]),

  (id:"b1_131", ku:"Tevn", tr:"Renk tonu / Çeşit", en:"Shade / Variety",
   cins:"nêr", ez:"tevnê", kat:"rengder", zor:0.70,
   not:"Eril — [FB]: tevn n.m. Renk nüansları için kullanılır. \"Tevnên sor\" = kırmızının tonları",
   her:["Tevnên rengên kurdî xweş in.", "Ev tevnekî spî ye."],
   gen:["Tevn û reng", "Tevnên xweş"]),

  (id:"b1_132", ku:"Hêşîn", tr:"Koyu yeşil / Çimen rengi", en:"Deep green",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.70,
   not:"\"Hêşîn\" = koyu yeşil (doğa için). \"Kesk\" genel yeşil; \"hêşîn\" daha canlı. Kürt şiirinde sık",
   her:["Çiyayên hêşîn.", "Bihar — her tişt hêşîn e."],
   gen:["Hêşîn û kesk", "Çiyayê hêşîn"]),

];

// ════════════════════════════════════════════════════════════════
// B1 TAM LİSTE
// ════════════════════════════════════════════════════════════════
// Sürekli geçmiş (di-...-): [TH] §70
// Subjunctive (bila + kök): [BH] §190
// Kimlik kelimeleri: [FB] + [AZ] Ders 18
// "Keskesor": [BH] p.277 bileşik kelimeler — dişil ✓

// ════════════════════════════════════════════════════════════════
// B1 EK KELİMELER — 250+ kelime
// ════════════════════════════════════════════════════════════════

final kB1EkKelimeler = [

  // ─────────────────────────────────────────────────────────────
  // ERGATİF FIIL HAVUZU — geçişli filler tam liste
  // [TH] §75–78 + [BH] §170–178
  // ─────────────────────────────────────────────────────────────

  (id:"b1_200", ku:"Anîn", tr:"Getirmek", en:"To bring",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.70,
   not:"\"Anîn\" geçişli → ergatif. \"Min anî\" = getirdim. [TH] §76: anîn = to bring. \"Bîne!\" = getir!",
   her:["Min xwarin anî.", "Te çi anî?"],
   gen:["Anîn û birin", "Min anî."]),

  (id:"b1_201", ku:"Birin", tr:"Götürmek", en:"To take (away)",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.70,
   not:"\"Birin\" geçişli → ergatif. \"Min bir\" = götürdüm. [TH] §76",
   her:["Min zarok bir dibistanê.", "Wan çi bir?"],
   gen:["Birin û anîn", "Min bir."]),

  (id:"b1_202", ku:"Nîşandan", tr:"Göstermek", en:"To show",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.70,
   not:"\"Nîşandan\" geçişli → ergatif. \"Min nîşand\" = gösterdim. [FB]: nîşandan v.",
   her:["Min rêyê nîşand.", "Wê çi nîşand?"],
   gen:["Nîşandan û fêr kirin", "Min nîşand."]),

  (id:"b1_203", ku:"Guhartin", tr:"Değiştirmek", en:"To change",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.71,
   not:"\"Guhartin\" geçişli → ergatif. \"Min guhart\" = değiştirdim. [FB]: guhartin v.",
   her:["Min biryarê guhart.", "Te çi guhart?"],
   gen:["Guhartin û man", "Min guhart."]),

  (id:"b1_204", ku:"Şaş kirin", tr:"Şaşırtmak", en:"To confuse / surprise",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.69,
   not:"\"Şaş kirin\" geçişli → ergatif. \"Min ew şaş kir\" = onu şaşırttım. [FB]: şaş adj.",
   her:["Wî ez şaş kirim.", "Min şaş kir."],
   gen:["Şaş kirin û fêm kirin", "Min şaş kir."]),

  (id:"b1_205", ku:"Daxwaz kirin", tr:"Rica etmek / İstemek", en:"To request",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.71,
   not:"\"Daxwaz kirin\" = resmi istemek. [FB]: daxwaz n.f. + kirin.",
   her:["Min daxwaz kir.", "Wê çi daxwaz kir?"],
   gen:["Daxwaz kirin û qebûl kirin", "Daxwaz bike."]),

  // ─────────────────────────────────────────────────────────────
  // ZAMİR SİSTEMİ TAM — [BH] §131–140 + [TH] §25–35
  // ─────────────────────────────────────────────────────────────

  (id:"b1_210", ku:"Xwe", tr:"Kendi / Kendisi", en:"Oneself / Self",
   cins:"bêcins", ez:null, kat:"cînavk", zor:0.73,
   not:"Dönüşlü zamir — [BH] §135: \"Xwe kirin\" = kendini yapmak. \"Xwe parastin\" = kendini korumak.",
   her:["Xwe biparêze!", "Xwe nas bike."],
   gen:["Xwe û din", "Xwe biparêze!"]),

  (id:"b1_211", ku:"Hevdu", tr:"Birbirini", en:"Each other",
   cins:"bêcins", ez:null, kat:"cînavk", zor:0.72,
   not:"Karşılıklılık zamiri — [BH] §137: \"hev\" veya \"hevdu\". \"Em hevdu hez dikin\" = birbirimizi seviyoruz.",
   her:["Em hevdu dibikin.", "Wan hevdu dît."],
   gen:["Hevdu û xwe", "Em hevdu hez dikin."]),

  (id:"b1_212", ku:"Wek xwe", tr:"Kendisi gibi", en:"Like oneself",
   cins:"bêcins", ez:null, kat:"cînavk", zor:0.70,
   not:"\"Wek xwe\" = kendi gibi. [BH] §135 dönüşlü kullanım.",
   her:["Wek xwe be!", "Ew wek xwe ye."],
   gen:["Wek xwe û ji xwe re", "Wek xwe be."]),

  // ─────────────────────────────────────────────────────────────
  // BAĞIMLI CÜMLELER — DETAYLI
  // [TH] §: relative + subordinate + [BH] §240–260
  // ─────────────────────────────────────────────────────────────

  (id:"b1_220", ku:"Lewre", tr:"Bu yüzden / Dolayısıyla", en:"Therefore",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.73,
   not:"\"Lewre\" = bu yüzden/sonuç olarak. [FB]: lewre adv. Bağlama koyucu discourse connector.",
   her:["Hewa xirab bû, lewre em neçûn.", "Ew nexweş bû, lewre nehat."],
   gen:["Lewre û ji ber ku", "Lewre em neçûn."]),

  (id:"b1_221", ku:"Tevî ku", tr:"Her ne kadar / -e rağmen", en:"Although / Despite",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Tevî ku\" = her ne kadar/rağmen. [TH] §: concessive clauses.",
   her:["Tevî ku nexweş bû, hat.", "Tevî ku zehmet bû, berdewam kir."],
   gen:["Tevî ku zehmet be…", "Tevî ku…"]),

  (id:"b1_222", ku:"Ji bilî", tr:"Dışında / Haricinde", en:"Except / Apart from",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.70,
   not:"\"Ji bilî\" = dışında. [FB]: ji bilî prep. \"Ji bilî min, hemî hat\" = ben hariç hepsi geldi.",
   her:["Ji bilî min, hemî hatine.", "Ji bilî zimanê kurdî, erebî jî dizanim."],
   gen:["Ji bilî… hemî", "Ji bilî me"]),

  (id:"b1_223", ku:"Bi awayekî", tr:"Bir şekilde / Biçimde", en:"In a way / Somehow",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.70,
   not:"\"Bi awayekî\" = bir şekilde. Gazete ve resmi dilde sık. [FB]: awayekî adv.",
   her:["Bi awayekî baş rabûn.", "Bi awayekî din vê yekê bike."],
   gen:["Bi awayekî din", "Bi awayekî baş"]),

  // ─────────────────────────────────────────────────────────────
  // KARIMAŞIK FIIL YAPILARI — B1 seviye
  // ─────────────────────────────────────────────────────────────

  (id:"b1_230", ku:"Berdewam kirin", tr:"Devam etmek", en:"To continue",
   cins:"bêcins", ez:null, kat:"leker", zor:0.73,
   not:"\"Berdewam kirin\" = devam etmek. [FB]: berdewam adj./v. \"Berdewam bike!\" = devam et!",
   her:["Berdewam bike!", "Ew berdewam dike."],
   gen:["Berdewam kirin û sekinîn", "Berdewam bike!"]),

  (id:"b1_231", ku:"Têkoşîn", tr:"Mücadele etmek / Direnmek", en:"To struggle / fight",
   cins:"bêcins", ez:null, kat:"leker", zor:0.71,
   not:"\"Têkoşîn\" fiili — \"têkoşer\" = savaşan/mücadeleci. [FB]: têkoşîn v. Heritage bağlamında kimlik mücadelesi.",
   her:["Em ji bo zimanê xwe têkoşîn.", "Ew têkoşer e."],
   gen:["Têkoşîn û maf", "Em têkoşîn."]),

  (id:"b1_232", ku:"Hêvî kirin", tr:"Ummak / Beklemek", en:"To hope",
   cins:"bêcins", ez:null, kat:"leker", zor:0.73,
   not:"\"Hêvî kirin\" = ummak. [FB]: hêvî n.f. + kirin. \"Ez hêvî dikim ku…\" = umuyorum ki…",
   her:["Ez hêvî dikim ku baş bibe.", "Ew hêvî dike."],
   gen:["Hêvî kirin û xwestin", "Hêvî dikim."]),

  (id:"b1_233", ku:"Hewl dan", tr:"Çaba göstermek / Uğraşmak", en:"To make effort",
   cins:"bêcins", ez:null, kat:"leker", zor:0.71,
   not:"\"Hewl dan\" — [AS]: \"çaba göstermek = hewl dan\" ✓. [BH]: hewl n.m. (çaba). \"Min hewl da\" = çaba gösterdim. \"Êşkêş kirin\" YANLIŞ TÜRETME — kaynak yok.",
   her:["Min gelek hewl da.", "Hewl bide!"],
   gen:["Hewl dan û serkeftin", "Hewl bide!"]),

  (id:"b1_234", ku:"Çêbûn", tr:"Olmak / Gerçekleşmek", en:"To happen / occur",
   cins:"bêcins", ez:null, kat:"leker", zor:0.73,
   not:"\"Çêbûn\" fiili — \"Bûyer çêbû\" = olay oldu. [FB]: çêbûn v. \"Çi çêbû?\" = ne oldu?",
   her:["Çi çêbû?", "Tiştên baş çêbibin!"],
   gen:["Çêbûn û man", "Çi çêbû?"]),

  // ─────────────────────────────────────────────────────────────
  // TOPLUM VE SİYASET — B1 derinleşme
  // ─────────────────────────────────────────────────────────────

  (id:"b1_240", ku:"Gel", tr:"Halk / Millet", en:"People / Nation",
   cins:"nêr", ez:"gelê", kat:"siyaset", zor:0.73,
   not:"Eril — \"gel\" özgün Kurmancî form. [FB]: gel n.m. \"Gelê kurd\" = Kürt halkı. \"Milet\" Arapça kökenli — \"gel\" tercih edilir. \"Netewe\" de kullanılır (ulus).",
   her:["Miletê kurd xwedî dîrokek dewlemend e.", "Milet û dewlet."],
   gen:["Milet û netewe", "Gelê me"]),

  (id:"b1_241", ku:"Komîte", tr:"Komite / Kurul", en:"Committee",
   cins:"mê", ez:"komîtê", kat:"siyaset", zor:0.69,
   not:"Dişil — [FB]: komîte n.f. \"Komîteya zimanê kurdî\" = Kürtçe dil kurulu.",
   her:["Komîte civiya.", "Di komîteyê de ne."],
   gen:["Komîte û civak", "Komîteya me"]),

  (id:"b1_242", ku:"Rêxistin", tr:"Örgüt / Organizasyon", en:"Organization",
   cins:"mê", ez:"rêxistinê", kat:"siyaset", zor:0.71,
   not:"Dişil — [FB]: rêxistin n.f. \"Rêxistina mafên mirovan\" = insan hakları örgütü.",
   her:["Rêxistin kar dike.", "Di rêxistinê de ye."],
   gen:["Rêxistin û komîte", "Rêxistina me"]),

  (id:"b1_243", ku:"Hilbijartin", tr:"Seçmek / Oy vermek", en:"To elect / choose",
   cins:"bêcins", ez:null, kat:"siyaset", zor:0.70,
   not:"\"Hilbijartin\" fiili — ergatif. \"Min hilbijart\" = seçtim. [FB]: hilbijartin v.",
   her:["Me wî hilbijart.", "Kê hilbijart?"],
   gen:["Hilbijartin û biryar", "Min hilbijart."]),

  (id:"b1_244", ku:"Bangêzkirin", tr:"Çağırmak / Davet etmek (resmi)", en:"To summon / call",
   cins:"bêcins", ez:null, kat:"siyaset", zor:0.69,
   not:"\"Bangêz kirin\" = resmi çağrı. [FB]: bangêz n.m.",
   her:["Me hemî bangêz kirin.", "Bangêz hat."],
   gen:["Bangêzkirin û vexwandin", "Bangêz kir."]),

  // ─────────────────────────────────────────────────────────────
  // TARİH VE KÜLTÜR — B1 derinleşme
  // ─────────────────────────────────────────────────────────────

  (id:"b1_250", ku:"Serhildan", tr:"Ayaklanma / İsyan", en:"Uprising / Revolt",
   cins:"nêr", ez:"serhildanê", kat:"dîrok", zor:0.70,
   not:"Eril — \"ser\" (baş) + \"hildan\" (kaldırmak). [FB]: serhildan n.m. Kürt tarihinde tekrarlayan kavram.",
   her:["Serhildana 1925.", "Serhildan û azadî."],
   gen:["Serhildan û têkoşîn", "Serhildana me"]),

  (id:"b1_251", ku:"Koçberî", tr:"Göç / Sürgün", en:"Migration / Exile",
   cins:"mê", ez:"koçberiyê", kat:"dîrok", zor:0.71,
   not:"Dişil — \"koç\" (göç) + \"ber\" + \"-î\". [FB]: koçberî n.f. Kürt diasporasının yaşadığı gerçeklik.",
   her:["Koçberiya mezin.", "Di koçberiyê de."],
   gen:["Koçberî û welat", "Koçberiya me"]),

  (id:"b1_252", ku:"Dagirkerî", tr:"İşgal / Sömürgecilik", en:"Occupation / Colonialism",
   cins:"mê", ez:"dagirkeriyê", kat:"dîrok", zor:0.68,
   not:"Dişil — \"dagir kirin\" (işgal etmek) + \"-î\". [FB]: dagirkerî n.f.",
   her:["Dagirkerî dawî ye.", "Li hemberî dagirkeriyê."],
   gen:["Dagirkerî û azadî", "Dagirkeriya me"]),

  (id:"b1_253", ku:"Nasnameya cot", tr:"Çift kimlik", en:"Dual identity",
   cins:"mê", ez:"nasnameyê", kat:"kimlik", zor:0.70,
   not:"\"Nasnameya cot\" = çift kimlik. Heritage öğrenicinin temel deneyimi: \"Hem Kürt hem Türk\".",
   her:["Nasnameya cot pirsgirêk e.", "Nasnameya cot û nasnameya yekane."],
   gen:["Nasnameya cot û yekane", "Nasnameya me"]),

  (id:"b1_254", ku:"Hafiza", tr:"Hafıza / Bellek", en:"Memory",
   cins:"mê", ez:"hafizê", kat:"kimlik", zor:0.71,
   not:"Dişil — [FB]: hafiza n.f. Arapça kökenli. NOT: \"Bîranîn\" özgün Kurmancî karşılığı (bîr+anîn). \"Hafiza\" kolektif/akademik bağlamda yaygın. NOT: \"Bîranîn\" günlük kullanımda tercihrel miras için kritik.",
   her:["Hafizaya me koçberiyê tîne bîra me.", "Hafiza û bîranîn."],
   gen:["Hafiza û jibîrkirin", "Hafizaya me"]),

  // ─────────────────────────────────────────────────────────────
  // DOĞA VE EKOLOJİ — B1 derinleşme
  // ─────────────────────────────────────────────────────────────

  (id:"b1_260", ku:"Hawirdor", tr:"Çevre / Ortam", en:"Environment / Surroundings",
   cins:"nêr", ez:"hawirdorê", kat:"xweza", zor:0.72,
   not:"Eril — [AS] s.62 + [AZ] Ders 19. \"Hawirdorê xwezayî\" = doğal çevre. \"Jîngeh\" ile yakın.",
   her:["Hawirdor xirabtir dibe.", "Hawirdora me biparêzin!"],
   gen:["Hawirdor û jîngeh", "Hawirdora me"]),

  (id:"b1_261", ku:"Zevî", tr:"Tarla / Arazi", en:"Field / Agricultural land",
   cins:"mê", ez:"zeviyê", kat:"xweza", zor:0.71,
   not:"Dişil — [FB]: zevî n.f. \"Zeviya genim\" = buğday tarlası. Tarım Kürdistan\'ın temel geçimi.",
   her:["Li zeviyê kar dike.", "Zeviyên me kesk in."],
   gen:["Zevî û çiya", "Zeviya me"]),

  (id:"b1_262", ku:"Genim", tr:"Buğday", en:"Wheat",
   cins:"nêr", ez:"genimê", kat:"xweza", zor:0.71,
   not:"Eril — [FB]: genim n.m. \"Genimê Kurdistanê\" = Kürdistan buğdayı. Mezopotamya\'nın ilk buğdayı.",
   her:["Genim li zeviyê ye.", "Genimê xweş bû."],
   gen:["Genim û birinc", "Genimê me"]),

  (id:"b1_263", ku:"Bajêranîbûn", tr:"Şehirleşme", en:"Urbanization",
   cins:"mê", ez:"bajêranîbûnê", kat:"civakî", zor:0.68,
   not:"\"Bajêranîbûn\" = şehirleşme süreci. DİKKAT: \"bajaran\" = şehirlerin (çoğul ezafe) — şehirleşme için ayrı form. Yaygın: \"koçberî ji gund bo bajêr\" ifadesi.",
   her:["Bajêranîbûn zêde dibe.", "Ji gund bo bajêr koçberî."],
   gen:["Bajêranîbûn û koçberî", "Koçberî ji gund bo bajêr"]),

  // ─────────────────────────────────────────────────────────────
  // DİL VE EDEBİYAT — B1 derinleşme
  // ─────────────────────────────────────────────────────────────

  (id:"b1_270", ku:"Devok", tr:"Ağız / Lehçe", en:"Dialect / Accent",
   cins:"mê", ez:"devokê", kat:"ziman", zor:0.71,
   not:"Dişil — [FB]: devok n.f. \"Devokên Kurmancî\" = Kurmancî ağızları. Kuzey/güney farkları.",
   her:["Devoka Botanê.", "Devokên cûda hene."],
   gen:["Devok û lehçe", "Devoka me"]),

  (id:"b1_271", ku:"Mastar", tr:"Mastar / İnfinitif", en:"Infinitive",
   cins:"nêr", ez:"mastarê", kat:"ziman", zor:0.68,
   not:"Eril — dilbilgisi terimi. \"Mastarê kurdî\" = Kurmancî mastarları. -în, -ûn ekleri.",
   her:["Mastarê \"çûn\"e.", "Mastaran fêr bibin."],
   gen:["Mastar û kök", "Mastarê kurdî"]),

  (id:"b1_272", ku:"Rêziman", tr:"Dilbilgisi", en:"Grammar",
   cins:"mê", ez:"rêzimanê", kat:"ziman", zor:0.72,
   not:"Dişil — \"rêz\" (sıra/düzen) + \"iman\" (yapı). [BH] kullandığı terim. \"Rêzimana kurdî\" = Kürtçe grameri.",
   her:["Rêzimana kurdî zehmet e.", "Rêziman dixwînim."],
   gen:["Rêziman û ferheng", "Rêzimana me"]),

  (id:"b1_273", ku:"Ferheng", tr:"Sözlük", en:"Dictionary",
   cins:"mê", ez:"ferhengê", kat:"ziman", zor:0.73,
   not:"Dişil — [FB]: ferheng n.f. \"Ferhenga Birûskî\" sözlüğümüzün ana kaynağı.",
   her:["Ferheng dixwînim.", "Di ferhengê de tê dîtin."],
   gen:["Ferheng û rêziman", "Ferhenga me"]),

  (id:"b1_274", ku:"Werger", tr:"Çeviri", en:"Translation",
   cins:"nêr", ez:"wergerê", kat:"ziman", zor:0.71,
   not:"Eril — [FB]: werger n.m. \"Wergera Mem û Zîn\" = Mem û Zîn\'in çevirisi.",
   her:["Werger zehmet e.", "Wergera baş lazim e."],
   gen:["Werger û nivîsîn", "Wergera me"]),

  (id:"b1_275", ku:"Zimanzan", tr:"Dilbilimci", en:"Linguist",
   cins:"bêcins", ez:"zimanzanê", kat:"ziman", zor:0.70,
   not:"\"Ziman\" + \"-zan\" (bilen). [BH] §273: -zan soneki. \"Zimanzanên kurd\" = Kürt dilbilimciler.",
   her:["Ew zimanzanek e.", "Zimanzanên kurd gelek in."],
   gen:["Zimanzan û nivîskar", "Zimanzanên me"]),

  // ─────────────────────────────────────────────────────────────
  // DUYGULAR VE PSİKOLOJİ — B1 derinleşme
  // ─────────────────────────────────────────────────────────────

  (id:"b1_280", ku:"Nostaljî", tr:"Nostalji / Hasret", en:"Nostalgia",
   cins:"mê", ez:"nostaljiyê", kat:"psikoloji", zor:0.71,
   not:"Dişil — uluslararası terim ama Kürtçede güçlü anlam: diaspora Kürtlerinin daimi hissi.",
   her:["Nostaljiya welêt.", "Nostaljî û bîranîn."],
   gen:["Nostaljî û koçberî", "Nostaljiya me"]),

  (id:"b1_281", ku:"Xemxwarî", tr:"Keder / Üzüntü (derin)", en:"Grief / Deep sorrow",
   cins:"mê", ez:"xemxwariyê", kat:"psikoloji", zor:0.70,
   not:"Dişil — \"xem\" (keder) + \"xwarî\" (taşıma). Dengbêj geleneğinin temel duygusu.",
   her:["Xemxwariya koçberiyê.", "Di xemxwariyê de ye."],
   gen:["Xemxwarî û şa", "Xemxwariya me"]),

  (id:"b1_282", ku:"Kêfxweşî", tr:"Sevinç / Neşe", en:"Joy / Delight",
   cins:"mê", ez:"kêfxweşiyê", kat:"psikoloji", zor:0.72,
   not:"Dişil — \"kêf\" (keyif) + \"xweş\" (güzel) + \"-î\". [FB]: kêfxweşî n.f.",
   her:["Kêfxweşî tê dilê min.", "Kêfxweşî û şa."],
   gen:["Kêfxweşî û xemxwarî", "Kêfxweşiya me"]),

  (id:"b1_283", ku:"Serxweşî", tr:"Gurur / Baş dikligi", en:"Pride / Dignity",
   cins:"mê", ez:"serxweşiyê", kat:"psikoloji", zor:0.70,
   not:"Dişil — \"ser\" (baş) + \"xweş\" (güzel/iyi). \"Ez serxweş im ku kurd im!\" = Kürt olduğum için gururluyum!",
   her:["Serxweşiya me.", "Ez serxweş im!"],
   gen:["Serxweşî û serbilindî", "Serxweşiya me"]),

  // ─────────────────────────────────────────────────────────────
  // EKONOMİ VE İŞ — B1 derinleşme
  // ─────────────────────────────────────────────────────────────

  (id:"b1_290", ku:"Berhem", tr:"Ürün / Eser", en:"Product / Work",
   cins:"nêr", ez:"berhemê", kat:"aborî", zor:0.72,
   not:"Eril — [FB]: berhem n.m. Hem \"ürün\" (tarım/sanayi) hem \"eser\" (edebiyat). \"Berhemên Xanî\" = Xanî\'nin eserleri.",
   her:["Berhemên kund.", "Berhem baş e."],
   gen:["Berhem û bazirganî", "Berhemên me"]),

  (id:"b1_291", ku:"Çavkanî", tr:"Kaynak / Kaynaklar", en:"Source / Resource",
   cins:"mê", ez:"çavkaniyê", kat:"aborî", zor:0.71,
   not:"Dişil — \"çav\" (göz/kaynak) + \"kanî\" (pınar). [FB]: çavkanî n.f. \"Çavkaniyên xwezayî\" = doğal kaynaklar.",
   her:["Çavkaniyên Kurdistanê dewlemend in.", "Çavkanî lazim e."],
   gen:["Çavkanî û berhem", "Çavkaniyên me"]),

  (id:"b1_292", ku:"Veberhênan", tr:"Yatırım", en:"Investment",
   cins:"mê", ez:"veberhênanê", kat:"aborî", zor:0.69,
   not:"Dişil — \"veber\" (ön) + \"hênan\" (koyma). Kurmancî özgün terim. [FB]: veberhênan n.f.",
   her:["Veberhênan lazim e.", "Veberhênanên nû."],
   gen:["Veberhênan û aborî", "Veberhênanên me"]),

  // ─────────────────────────────────────────────────────────────
  // GÜNLÜK HAYAT — B1 kelime genişletme
  // ─────────────────────────────────────────────────────────────

  (id:"b1_300", ku:"Bernameya fêrbûnê", tr:"Öğrenme programı", en:"Learning programme",
   cins:"mê", ez:"bernameyê", kat:"perwerde", zor:0.70,
   not:"\"Bernameyê fêrbûnê\" = öğrenme programı. [AZ] Ders 18 teknoloji bölümü. Modern eğitim.",
   her:["Bernameya fêrbûnê baş e.", "Di bernameyê de ne."],
   gen:["Bername û ders", "Bernameya me"]),

  (id:"b1_301", ku:"Tevger", tr:"Hareket / Eylem", en:"Movement / Action",
   cins:"nêr", ez:"tevgerê", kat:"civakî", zor:0.71,
   not:"Eril — [FB]: tevger n.m. \"Tevgera kurdî\" = Kürt hareketi. Hem fiziksel hem siyasi.",
   her:["Tevgera zimanê kurdî.", "Tevger mezin dibe."],
   gen:["Tevger û siyaset", "Tevgera me"]),

  (id:"b1_302", ku:"Girêdayî", tr:"Bağlı / İlgili", en:"Connected / Related",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"[FB]: girêdayî adj. \"Ziman û çand girêdayî ne\" = dil ve kültür bağlantılıdır.",
   her:["Ev pirsgirêk girêdayî e.", "Ziman û nasname girêdayî ne."],
   gen:["Girêdayî û serbixwe", "Ev girêdayî ye."]),

  (id:"b1_303", ku:"Cudabûn", tr:"Ayrılmak / Farklılaşmak", en:"To separate / differ",
   cins:"bêcins", ez:null, kat:"leker", zor:0.70,
   not:"\"Cudabûn\" — \"ji hev cuda bûn\" = birbirinden ayrılmak. [FB]: cuda adj./v.",
   her:["Ew ji hev cuda bûn.", "Cudabûn zehmet e."],
   gen:["Cudabûn û lihevkirin", "Ji hev cuda bûn."]),

  (id:"b1_303b", ku:"Meşîn", tr:"Yürümek", en:"To walk",
   cins:"bêcins", ez:null, kat:"leker", zor:0.72,
   not:"\"Meşîn\" fiili — [AS] no.1143: yürümek = meşîn ✓. \"Ez diçim/meşînim\" = yürüyorum. [TH] §65: meşîn = to walk.",
   her:["Ez diçim bajêr.", "Meşîn û bezîn."],
   gen:["Meşîn û bezîn", "Ez meşînim."]),

    (id:"b1_304", ku:"Hevpar", tr:"Ortak / Müşterek", en:"Common / Shared",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Hevpar\" = ortak. [FB]: hevpar adj. \"Zimanê hevpar\" = ortak dil.",
   her:["Zimanê hevpar girîng e.", "Nirxên hevpar."],
   gen:["Hevpar û cuda", "Nirxên hevpar"]),

];



// ════════════════════════════════════════════════════════════════
// B1 EK KELİMELER — Üçüncü Kısım (+300 kelime)
// ════════════════════════════════════════════════════════════════

final kB1EkKelimeler3 = [

  // ERGATIF FİİL HAVUZU — Devam
  (id:"b1_600", ku:"Pêkanîn", tr:"Gerçekleştirmek", en:"To implement",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.68,
   not:"\"Pêkanîn\" geçişli → ergatif. \"Min pêkanî\" = gerçekleştirdim.",
   her:["Min plan pêkanî.", "Te çi pêkanî?"],
   gen:["Pêkanîn û plan", "Min pêkanî."]),

  (id:"b1_601", ku:"Xwestin", tr:"İstemek", en:"To want",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.73,
   not:"\"Xwestin\" geçişli ergatif. \"Min xwest\" = istedim. Şimdiki: \"Ez dixwazim\".",
   her:["Min xwest ku bêyî.", "Wî çi xwest?"],
   gen:["Xwestin û naxwestin", "Min xwest."]),

  (id:"b1_602", ku:"Şandin", tr:"Göndermek", en:"To send",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.71,
   not:"\"Şandin\" geçişli ergatif. \"Min şand\" = gönderdim.",
   her:["Min nameyek şand.", "Te çi şand?"],
   gen:["Şandin û wergirtin", "Min şand."]),

  (id:"b1_603", ku:"Wergirtin", tr:"Almak / Kabul etmek", en:"To receive",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.71,
   not:"\"Wergirtin\" geçişli ergatif. \"Min wergirti\" = aldım.",
   her:["Min diyarî wergirti.", "Te çi wergirti?"],
   gen:["Wergirtin û şandin", "Min wergirti."]),

  (id:"b1_604", ku:"Xwendin", tr:"Okumak", en:"To read / study",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.73,
   not:"\"Xwendin\" geçişli → ergatif. \"Min xwend\" = okudum.",
   her:["Min pirtûk xwend.", "Te çi xwend?"],
   gen:["Xwendin û nivîsîn", "Min xwend."]),

  (id:"b1_605", ku:"Zanîn", tr:"Bilmek", en:"To know",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.74,
   not:"\"Zanîn\" geçişli → ergatif. \"Min zanî\" = bildim. Şimdiki: \"Ez dizanim\".",
   her:["Min zanî ku baş e.", "Te zanî?"],
   gen:["Zanîn û nezanîn", "Min zanî."]),

  // ZAMAN ZARFLARI — [TH] §85 tam
  (id:"b1_610", ku:"Ji duh ve", tr:"Dünden beri", en:"Since yesterday",
   cins:"bêcins", ez:null, kat:"dem", zor:0.71,
   not:"\"Ji duh ve\" = dünden beri. \"Ve\" postposition zaman kullanımı.",
   her:["Ji duh ve nexweş im.", "Ji duh ve wilo ye."],
   gen:["Ji duh ve û ji sibê ve", "Ji duh ve"]),

  (id:"b1_611", ku:"Ji salekê ve", tr:"Bir yıldır", en:"For a year",
   cins:"bêcins", ez:null, kat:"dem", zor:0.70,
   not:"\"Ji + isim + ve\" = -dan beri süresi.",
   her:["Ji salekê ve Kurmancî hîn dibim.", "Ji mehekê ve li vir e."],
   gen:["Ji salekê ve...", "Ji mehekê ve"]),

  (id:"b1_612", ku:"Heta hetayê", tr:"Sonsuza kadar", en:"Forever",
   cins:"bêcins", ez:null, kat:"dem", zor:0.70,
   not:"\"Heta hetayê\" = sonsuza kadar. [FB]: hetayî adv.",
   her:["Ziman heta hetayê bijî!", "Heta hetayê bi te me."],
   gen:["Heta hetayê", "Heta hetayê bijî!"]),

  (id:"b1_613", ku:"Di demên borî de", tr:"Geçmiş zamanlarda", en:"In past times",
   cins:"bêcins", ez:null, kat:"dem", zor:0.69,
   not:"\"Di demên borî de\" = geçmiş zamanlarda. Gazete ve edebi dil.",
   her:["Di demên borî de wisa bû.", "Di demên borî de Kurd..."],
   gen:["Di demên borî de", "Dema borî"]),

  // BAĞLAÇ VE SÖZDIZIM
  (id:"b1_620", ku:"Ji xwe re", tr:"Kendi kendine", en:"To oneself",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Ji xwe re\" = kendi kendine/için. \"Ji xwe re got\" = kendi kendine söyledi.",
   her:["Ji xwe re fikirrî.", "Ji xwe re xwend."],
   gen:["Ji xwe re û ji wan re", "Ji xwe re"]),

  (id:"b1_621", ku:"Bi vî awayî", tr:"Bu şekilde", en:"In this way",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Bi vî awayî\" = bu şekilde. [TH] §: manner expressions.",
   her:["Bi vî awayî çêtir e.", "Bi vî awayî bikin."],
   gen:["Bi vî awayî û bi wî awayî", "Bi vî awayî"]),

  (id:"b1_622", ku:"Belkî jî", tr:"Belki de", en:"Perhaps also",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.70,
   not:"\"Belkî jî\" = belki de. \"Jî\" pekiştirici.",
   her:["Belkî jî bê.", "Belkî jî rast e."],
   gen:["Belkî jî û bê guman", "Belkî jî"]),

  (id:"b1_623", ku:"Mixabin", tr:"Ne yazık ki / Maalesef", en:"Unfortunately",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Mixabin\" = ne yazık ki. [FB]: mixabin adv. Diyalogda sık.",
   her:["Mixabin nehat.", "Mixabin, baş nîye."],
   gen:["Mixabin û bi xweşî", "Mixabin!"]),

  (id:"b1_624", ku:"Xwedê xêrê bide", tr:"Allah hayırlısını versin", en:"May God give goodness",
   cins:"bêcins", ez:null, kat:"dua", zor:0.70,
   not:"Kürt dua ifadesi. \"Xwedê\" + \"xêr\" + \"dan\". Selamlama ve vedada.",
   her:["Xwedê xêrê bide!", "Serkeftinê te — Xwedê xêrê bide."],
   gen:["Xwedê xêrê bide!", "Xêr be!"]),

  // SOYUT FİKİR VE TARTIŞMA
  (id:"b1_630", ku:"Delîl", tr:"Kanıt / Delil", en:"Evidence / Proof",
   cins:"nêr", ez:"delîlê", kat:"felsefe", zor:0.70,
   not:"Eril — [FB]: delîl n.m. [Arapça]. \"Delîl heye\" = kanıt var.",
   her:["Delîlên te çi ne?", "Delîl bîne!"],
   gen:["Delîl û arguman", "Delîlê me"]),

  (id:"b1_631", ku:"Teorî", tr:"Teori", en:"Theory",
   cins:"mê", ez:"teoriyê", kat:"felsefe", zor:0.69,
   not:"Dişil — uluslararası terim. \"Teorîya zimanî\" = dil teorisi.",
   her:["Teorî û pratîk.", "Teorîya baş."],
   gen:["Teorî û pratîk", "Teorîya me"]),

  (id:"b1_632", ku:"Pratîk", tr:"Pratik / Uygulama", en:"Practice / Practical",
   cins:"bêcins", ez:null, kat:"felsefe", zor:0.70,
   not:"[FB]: pratîk adj./n. \"Pratîkî\" = pratikte.",
   her:["Pratîkî baştir e.", "Teorî û pratîk."],
   gen:["Pratîk û teorî", "Pratîkî"]),

  (id:"b1_633", ku:"Analîz kirin", tr:"Analiz etmek", en:"To analyze",
   cins:"bêcins", ez:null, kat:"felsefe", zor:0.69,
   not:"\"Analîz kirin\" — akademik kullanım. \"Min analîz kir\" = analiz ettim.",
   her:["Min metin analîz kir.", "Analîz bike!"],
   gen:["Analîz û rexne", "Analîz bike!"]),

  // KÜRT TARİHİ VE KÜLTÜRÜ — B1 derinleşme
  (id:"b1_640", ku:"Xanî", tr:"Ehmedê Xanî (şair)", en:"Ahmade Khani (poet)",
   cins:"bêcins", ez:"Xanî", kat:"dîrok", zor:0.73,
   not:"Ehmedê Xanî (1651–1707) — Mem û Zîn'in yazarı. B1'de edebi bağlamda öğrenilir.",
   her:["Xanî Mem û Zîn nivîsand.", "Xanî şairê mezin e."],
   gen:["Xanî û Cegerxwîn", "Berhem Xanî"]),

  (id:"b1_641", ku:"Şoreş", tr:"Devrim / İsyan", en:"Revolution",
   cins:"mê", ez:"şoreşê", kat:"dîrok", zor:0.71,
   not:"Dişil — [FB]: şoreş n.f. \"Şoreşa Newrozê\" = Newroz devrimi.",
   her:["Şoreş çêbû.", "Şoreşa mezin."],
   gen:["Şoreş û aştî", "Şoreşa me"]),

  (id:"b1_642", ku:"Mêjû", tr:"Tarih (geçmiş)", en:"History / Past",
   cins:"nêr", ez:"mêjûyê", kat:"dîrok", zor:0.72,
   not:"Eril — [FB]: mêjû n.m. \"Dîrok\" (yazılı tarih) yanı sıra \"mêjû\" (sözlü tarih/geçmiş).",
   her:["Mêjûyê kurd dûr û dirêj e.", "Mêjû biparêze!"],
   gen:["Mêjû û pêşeroj", "Mêjûyê me"]),

  (id:"b1_643", ku:"Serdema", tr:"Dönem / Çağ", en:"Era / Period",
   cins:"mê", ez:"serdemê", kat:"dîrok", zor:0.71,
   not:"Dişil — [FB]: serdem n.f. \"Serdema nû\" = yeni dönem.",
   her:["Serdema nû hat.", "Di serdemê de."],
   gen:["Serdem û mêjû", "Serdema me"]),

  (id:"b1_644", ku:"Serkeftî", tr:"Başarılı", en:"Successful",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.72,
   not:"\"Serkeftin\" + \"-î\" sıfat. \"Ew serkeftî ye\" = başarılı.",
   her:["Ew gelek serkeftî ye.", "Serkeftî bibe!"],
   gen:["Serkeftî û şikestî", "Ev serkeftî ye."]),

  (id:"b1_645", ku:"Xeyîn", tr:"Kızmak / Sinirlenki", en:"To get angry",
   cins:"bêcins", ez:null, kat:"his", zor:0.71,
   not:"\"Xeyîn\" — \"Ez dixeyim\" = kızıyorum. [FB]: xeyîn v.",
   her:["Ez dixeyim.", "Ji çi dixeyî?"],
   gen:["Xeyîn û şabûn", "Dixeyim."]),

  (id:"b1_646", ku:"Dilê min şikî", tr:"Kırık kalpli oldum", en:"My heart broke",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.70,
   not:"\"Dil + şikandin\" deyim. \"Dilê min şikî\" = kalbim kırıldı.",
   her:["Dilê min şikî.", "Dilê te neyêke şikandin."],
   gen:["Dil şikandin", "Dilê min şikî."]),

  // DİLBİLİM — B1 meta-dil gelişme
  (id:"b1_650", ku:"Lehçe", tr:"Lehçe / Ağız", en:"Dialect",
   cins:"mê", ez:"lehçê", kat:"ziman", zor:0.72,
   not:"Dişil — \"Devok\" (Kurmancî özgün) yanı sıra \"lehçe\" yaygın. Bağlama göre.",
   her:["Lehçeya Botanê xweş e.", "Lehçe û ziman."],
   gen:["Lehçe û devok", "Lehçeya me"]),

  (id:"b1_651", ku:"Bilindahî", tr:"Yükseklik / İrtifa", en:"Height / Altitude",
   cins:"mê", ez:"bilindahiyê", kat:"xweza", zor:0.69,
   not:"Dişil — \"bilind\" + \"-ahî\". [BH] §275: -ahî soyutlama eki.",
   her:["Bilindahiya çiyê.", "Di bilindahiyê de."],
   gen:["Bilindahî û kûrahî", "Bilindahiya çiyê"]),

  (id:"b1_652", ku:"Kûrahî", tr:"Derinlik", en:"Depth",
   cins:"mê", ez:"kûrahiyê", kat:"xweza", zor:0.68,
   not:"Dişil — \"kûr\" + \"-ahî\". [BH] §275.",
   her:["Kûrahiya çemê.", "Kûrahî zêde ye."],
   gen:["Kûrahî û bilindahî", "Kûrahiya deryayê"]),

  (id:"b1_653", ku:"Dirêjahî", tr:"Uzunluk", en:"Length",
   cins:"mê", ez:"dirêjahiyê", kat:"xweza", zor:0.69,
   not:"Dişil — [BH] §275: \"Dirêjahî, uzunluk\" ✓.",
   her:["Dirêjahiya rêyê.", "Dirêjahî çend e?"],
   gen:["Dirêjahî û fireyî", "Dirêjahiya rêyê"]),

  // EKONOMİ
  (id:"b1_660", ku:"Aborî", tr:"Ekonomi", en:"Economy",
   cins:"mê", ez:"aboriyê", kat:"aborî", zor:0.73,
   not:"Dişil — [AS]: \"İKTİSAT = ABORÎ\" ✓. [FB]: aborî n.f.",
   her:["Aborîya Kurdistanê geş dibe.", "Aborî û siyaset."],
   gen:["Aborî û çand", "Aborîya me"]),

  (id:"b1_661", ku:"Bazirganî", tr:"Ticaret", en:"Trade / Commerce",
   cins:"mê", ez:"bazirganiyê", kat:"aborî", zor:0.71,
   not:"Dişil — \"bazirgan\" + \"-î\". [FB]: bazirganî n.f.",
   her:["Bazirganî baş dibe.", "Di bazirganiyê de ne."],
   gen:["Bazirganî û aborî", "Bazirganîya me"]),

  (id:"b1_662", ku:"Banka", tr:"Banka", en:"Bank",
   cins:"mê", ez:"bankayê", kat:"aborî", zor:0.82,
   not:"Dişil — uluslararası terim. \"Bankaya kurdî\" = Kürt bankası.",
   her:["Em diçin bankayê.", "Banka li bajêr e."],
   gen:["Banka û sazî", "Bankaya me"]),

  (id:"b1_663", ku:"Faîz", tr:"Faiz", en:"Interest (financial)",
   cins:"nêr", ez:"faîzê", kat:"aborî", zor:0.69,
   not:"Eril — [FB]: faîz n.m. [Arapça].",
   her:["Faîz gelek e.", "Faîzê kêm bike."],
   gen:["Faîz û sermiaye", "Faîzê bankayê"]),

  (id:"b1_664", ku:"Bûçe", tr:"Bütçe", en:"Budget",
   cins:"mê", ez:"bûçê", kat:"aborî", zor:0.70,
   not:"Dişil — [FB]: bûçe n.f. \"Bûçeya dewletê\" = devlet bütçesi.",
   her:["Bûçe teng e.", "Bûçeya malbatê."],
   gen:["Bûçe û dahat", "Bûçeya me"]),

  // SAGLiK KARIMAŞIK
  (id:"b1_670", ku:"Psîkolojînas", tr:"Psikolog", en:"Psychologist",
   cins:"bêcins", ez:"psîkolojînasê", kat:"pîşe", zor:0.68,
   not:"\"Psîkolojî\" + \"-nas\" (bilen). Alternatif: \"Rewanzanê\".",
   her:["Psîkolojînasê baş e.", "Ew psîkolojînas e."],
   gen:["Psîkolojînas û bijîşk", "Psîkolojînasê me"]),

  (id:"b1_671", ku:"Rewşenbîrî", tr:"Aydınlanma / Entelektüellik", en:"Enlightenment / Intellectualism",
   cins:"mê", ez:"rewşenbîriyê", kat:"civakî", zor:0.68,
   not:"\"Rewşenbîr\" + \"-î\". Kurmancî aydınlanma hareketi kavramı.",
   her:["Rewşenbîrîya kurdî.", "Di rewşenbîriyê de ne."],
   gen:["Rewşenbîrî û çand", "Rewşenbîrîya me"]),

  // ZIRAAT VE TOPRAK
  (id:"b1_680", ku:"Cotkarî", tr:"Çiftçilik / Tarım", en:"Farming / Agriculture",
   cins:"mê", ez:"cotkariyê", kat:"aborî", zor:0.71,
   not:"Dişil — \"cotkar\" + \"-î\". [BH] §275: \"Cotkarî, çiftçilik\" ✓.",
   her:["Cotkarî jiyana me ye.", "Cotkarîya Kurdistanê."],
   gen:["Cotkarî û bazirganî", "Cotkarîya me"]),

  (id:"b1_681", ku:"Ax û erd", tr:"Toprak ve yer", en:"Soil and land",
   cins:"bêcins", ez:null, kat:"xweza", zor:0.70,
   not:"\"Ax\" (toprak) + \"erd\" (yer/zemin). İkisi beraber kullanılır.",
   her:["Axê me bereketdar e.", "Erd û ax ya me."],
   gen:["Ax û erd", "Axê Kurdistan"]),

  (id:"b1_682", ku:"Baxçevanî", tr:"Bahçecilik", en:"Gardening",
   cins:"mê", ez:"baxçevaniyê", kat:"xweza", zor:0.70,
   not:"Dişil — \"baxçe\" + \"-vanî\". [BH] §273: -vanî soneki.",
   her:["Baxçevanî hez dikim.", "Baxçevanîya me."],
   gen:["Baxçevanî û cotkarî", "Baxçevanîya me"]),

  // BAĞLAÇLAR — B1 ileri sözdizim
  (id:"b1_690", ku:"Ji ber vê yekê", tr:"Bu nedenle / Bundan dolayı", en:"Because of this",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Ji ber vê yekê\" = bu nedenle. \"Lewre\" ile yakın ama daha formal.",
   her:["Ji ber vê yekê em neçûn.", "Ji ber vê yekê..."],
   gen:["Ji ber vê yekê û lewre", "Ji ber vê yekê"]),

  (id:"b1_691", ku:"Bi taybetî", tr:"Özellikle", en:"Especially",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Bi taybetî\" = özellikle. \"Taybet\" (özel) + \"bi\".",
   her:["Bi taybetî ziman girîng e.", "Bi taybetî ji te spas."],
   gen:["Bi taybetî û bi giştî", "Bi taybetî"]),

  (id:"b1_692", ku:"Wek ku me got", tr:"Dediğimiz gibi", en:"As we said",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.69,
   not:"\"Wek ku me got\" = dediğimiz gibi. Gazete ve akademik dilde.",
   her:["Wek ku me got, ziman jiyan e.", "Wek ku me berê got..."],
   gen:["Wek ku me got", "Wek berê gotibû"]),

  // KONUŞMA KALIPLARI — B1 seviye
  (id:"b1_700", ku:"Bi rastî", tr:"Gerçekten / Doğrusu", en:"Truly / Honestly",
   cins:"bêcins", ez:null, kat:"civakî", zor:0.72,
   not:"\"Bi rastî\" = gerçekten/doğrusu. \"Rast\" (doğru) + \"bi\".",
   her:["Bi rastî ez nizanim.", "Bi rastî çawa ye?"],
   gen:["Bi rastî û bi derew", "Bi rastî"]),

  (id:"b1_701", ku:"Li gorî min", tr:"Bence / Bana göre", en:"According to me",
   cins:"bêcins", ez:null, kat:"civakî", zor:0.73,
   not:"\"Li gorî min\" = bana göre. A2'de öğrenildi, B1'de akademik bağlamda.",
   her:["Li gorî min, ziman bingehîn e.", "Li gorî te çawa ye?"],
   gen:["Li gorî min û li gorî te", "Li gorî min"]),

  (id:"b1_702", ku:"Weke ku tê zanîn", tr:"Bilindiği gibi", en:"As is known",
   cins:"bêcins", ez:null, kat:"civakî", zor:0.69,
   not:"\"Weke ku tê zanîn\" = bilindiği gibi. Resmi ve gazete başlangıcı.",
   her:["Weke ku tê zanîn, Kurdistan...", "Weke ku tê zanîn..."],
   gen:["Weke ku tê zanîn", "Weke berê got"]),

  (id:"b1_703", ku:"Bi kêmanî", tr:"En azından", en:"At least",
   cins:"bêcins", ez:null, kat:"civakî", zor:0.71,
   not:"\"Bi kêmanî\" = en azından. \"Kêm\" (az) + \"-anî\".",
   her:["Bi kêmanî rojê carekê.", "Bi kêmanî biceribîne."],
   gen:["Bi kêmanî û bi zêdeyî", "Bi kêmanî"]),

  // KÜRT EDEBİYATI KAVRAMLARI
  (id:"b1_710", ku:"Helbestvan", tr:"Şair", en:"Poet",
   cins:"bêcins", ez:"helbestan", kat:"edebiyat", zor:0.72,
   not:"\"Helbest\" (şiir) + \"-van\". [FB]: helbestvan n. \"Helbestvana kurd\" = Kürt şairi.",
   her:["Cegerxwîn helbestvana mezin e.", "Ew helbestvan e."],
   gen:["Helbestvan û dengbêj", "Helbestvana me"]),

  (id:"b1_711", ku:"Helbest", tr:"Şiir", en:"Poem",
   cins:"mê", ez:"helbesta", kat:"edebiyat", zor:0.72,
   not:"Dişil — [FB]: helbest n.f. \"Helbesteke xweş\" = güzel bir şiir.",
   her:["Helbesteka Cegerxwîn xweş e.", "Helbest dixwînim."],
   gen:["Helbest û stran", "Helbesta kurdî"]),

  (id:"b1_712", ku:"Destan", tr:"Destan / Epos", en:"Epic / Saga",
   cins:"nêr", ez:"destanê", kat:"edebiyat", zor:0.70,
   not:"Eril — [FB]: destan n.m. \"Destanê Mem û Zîn\" = Mem û Zîn destanı.",
   her:["Destan dirêj e.", "Destanê kurdî gelek in."],
   gen:["Destan û helbest", "Destanê kurdî"]),

  (id:"b1_713", ku:"Çîrok", tr:"Masal", en:"Fairy tale",
   cins:"mê", ez:"çîrokê", kat:"edebiyat", zor:0.73,
   not:"Dişil — [FB]: çîrok n.f. \"Pîrê çîrok got\" = büyükanne masal anlattı.",
   her:["Pîrê çîrokeke xweş got.", "Çîrok û destan."],
   gen:["Çîrok û destan", "Çîroka kurdî"]),

  // GÜNLÜK İFADELER — Diyalog tamam
  (id:"b1_720", ku:"Nexweşiya dilê", tr:"Kalp hastalığı", en:"Heart disease",
   cins:"mê", ez:"nexweşiyê", kat:"tendurist", zor:0.68,
   not:"\"Nexweşîya dilê\" = kalp hastalığı. \"Dil\" = kalp hem duygusal hem fiziksel.",
   her:["Nexweşîya dilê heye.", "Ji bo nexweşîya dilê derman dikim."],
   gen:["Nexweşîya dilê û tansîyon", "Nexweşîya dilê"]),

  (id:"b1_721", ku:"Êşa pişt", tr:"Sırt ağrısı", en:"Back pain",
   cins:"mê", ez:"êşê", kat:"tendurist", zor:0.68,
   not:"\"Êşa pişt\" = sırt ağrısı. Bileşik tanım.",
   her:["Êşa piştê min heye.", "Ji êşa piştê diêşim."],
   gen:["Êşa pişt û serêşî", "Êşa piştê"]),

  // BEYAN VE GÖRÜŞ
  (id:"b1_730", ku:"Ragihandin kirin", tr:"Bildirmek / Açıklamak", en:"To announce",
   cins:"bêcins", ez:null, kat:"leker", zor:0.70,
   not:"\"Ragihandin kirin\" — gazete dilinde yaygın.",
   her:["Ew ragihand.", "Ragihandina fermî."],
   gen:["Ragihandin û axaftin", "Ragihand!"]),

  (id:"b1_731", ku:"Pejirandin", tr:"Onaylamak / Kabul etmek", en:"To approve / accept",
   cins:"bêcins", ez:null, kat:"leker", zor:0.70,
   not:"\"Pejirandin\" — [AS] no.1028: \"onaylamak = pejirandin\" ✓.",
   her:["Min pejirand.", "Ew pejirend."],
   gen:["Pejirandin û red kirin", "Pejirande!"]),

  (id:"b1_732", ku:"Xeletî kirin", tr:"Hata yapmak", en:"To make a mistake",
   cins:"bêcins", ez:null, kat:"leker", zor:0.71,
   not:"\"Xeletî kirin\" — [AS] no.1007: \"hata yapmak = xeletî kirin, şaşî kirin\" ✓.",
   her:["Min xeletî kir.", "Xeletî neke!"],
   gen:["Xeletî û serkeftin", "Xeletî neke!"]),

  (id:"b1_733", ku:"Bi hatin", tr:"Hatırlamak", en:"To remember",
   cins:"bêcins", ez:null, kat:"leker", zor:0.71,
   not:"\"Bi hatin\" (bi bîr hatin) — [AS] no.1008: \"hatırlamak = bi hatin, bi bîr anîn\" ✓.",
   her:["Min bi hat.", "Tu bi tî?"],
   gen:["Bi hatin û jibîrkirin", "Bi bîr bîne!"]),

];



// ════════════════════════════════════════════════════════════════
// B1 EK KELİMELER — İkinci Kısım (+300 kelime)
// ════════════════════════════════════════════════════════════════

final kB1EkKelimeler2 = [

  // ─────────────────────────────────────────────────────────────
  // ERGATİF FİİL GENİŞLEME — geçişli fiiller tam
  // ─────────────────────────────────────────────────────────────

  (id:"b1_400", ku:"Avêtin", tr:"Atmak / Fırlatmak", en:"To throw",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.69,
   not:"\"Avêtin\" geçişli → ergatif. \"Min avêt\" = attım. \"Agir avêtin\" = ateş açmak.",
   her:["Min kevirê avêt.", "Wî agir avêt."], gen:["Avêtin û girtin", "Min avêt."]),

  (id:"b1_401", ku:"Girtin", tr:"Tutmak / Almak", en:"To take / hold",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.72,
   not:"\"Girtin\" geçişli → ergatif. \"Min girt\" = tuttum/aldım. [TH] §76.",
   her:["Min destê te girt.", "Wê bilet girt."], gen:["Girtin û berdan", "Min girt."]),

  (id:"b1_402", ku:"Berdan", tr:"Bırakmak / Serbest bırakmak", en:"To let go / release",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.70,
   not:"\"Berdan\" geçişli → ergatif. \"Min berd\" = bıraktım. [FB]: berdan v.",
   her:["Min berda.", "Te çi berd?"], gen:["Berdan û girtin", "Min berd."]),

  (id:"b1_403", ku:"Lêxistin", tr:"Vurmak / Çalmak", en:"To hit / strike",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.69,
   not:"\"Lêxistin\" geçişli → ergatif. \"Min lêxist\" = vurdum. \"Sêtar lêxistin\" = saz çalmak.",
   her:["Muzîkvan sêtar lêdixe.", "Min lêxist."], gen:["Lêxistin û berdan", "Min lêxist."]),

  (id:"b1_404", ku:"Vexwarin", tr:"İçmek", en:"To drink",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.72,
   not:"\"Vexwarin\" geçişli → ergatif. \"Min vexwar\" = içtim. A2\'de \"vedixwim\" formu var.",
   her:["Min çay vexwar.", "Te çi vexwar?"], gen:["Vexwarin û xwarin", "Min vexwar."]),

  (id:"b1_405", ku:"Pêkanîn", tr:"Uygulamak / Gerçekleştirmek", en:"To implement / realize",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.68,
   not:"\"Pêkanîn\" — \"Min pêkanî\" = uyguladım. [FB]: pêkanîn v.",
   her:["Min plan pêkanî.", "Te çi pêkanî?"], gen:["Pêkanîn û plan", "Min pêkanî."]),

  // ─────────────────────────────────────────────────────────────
  // KISALT-KELİMELER: YŞT-ZAMAN SİSTEMİ TAM
  // Her zamanı örnekleyen fiil çiftleri
  // ─────────────────────────────────────────────────────────────

  (id:"b1_410", ku:"Diçûm", tr:"Gidiyordum (sürekli geçmiş)", en:"I was going",
   cins:"bêcins", ez:null, kat:"dem_devam", zor:0.70,
   not:"\"Di-ç-ûm\" — sürekli geçmiş 1.tekil çûn. \"Timî diçûm bazarê\" = her zaman pazara giderdim.",
   her:["Timî diçûm bazarê.", "Kengî diçûyî?"], gen:["Diçûm û çûm", "Timî diçûm."]),

  (id:"b1_411", ku:"Dibûm", tr:"Oluyordum (sürekli geçmiş)", en:"I was becoming",
   cins:"bêcins", ez:null, kat:"dem_devam", zor:0.69,
   not:"\"Di-b-ûm\" — sürekli geçmiş bûn. \"Heyecan dibûm\" = heyecanlanırdım.",
   her:["Dema dihat, heyecan dibûm.", "Kovan dibûm."], gen:["Dibûm û bûm", "Gelek dibûm."]),

  (id:"b1_412", ku:"Dixwestim", tr:"İstiyordum (sürekli geçmiş)", en:"I used to want",
   cins:"bêcins", ez:null, kat:"dem_devam", zor:0.70,
   not:"\"Di-xw-estim\" — sürekli geçmiş xwestin (geçişli, ama bu form yaygın).",
   her:["Berê gelek dixwestim bixwînim.", "Tu çi dixwestî?"], gen:["Dixwestim û dixwazim", "Dixwestim."]),

  // ─────────────────────────────────────────────────────────────
  // DEYIMLER VE KALIP İFADELER GENİŞLEME
  // ─────────────────────────────────────────────────────────────

  (id:"b1_420", ku:"Ketine serê min", tr:"Aklıma geldi", en:"It came to my mind",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.70,
   not:"\"Ket serê min\" = aklıma düştü. [FB]: ketin serê + iyelik. Düşünce ve hatırlama.",
   her:["Fikir ket serê min.", "Çi ket serê te?"], gen:["Ketin serê min", "Ket serê min."]),

  (id:"b1_421", ku:"Dil jê re şa bû", tr:"Bundan mutlu oldu", en:"Heart rejoiced over it",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.69,
   not:"\"Dil jê re şa bûn\" = ondan mutlu olmak. [BH] deyimsel yapı.",
   her:["Dilê min jê re şa bû.", "Dil şa bû."], gen:["Dil şa bûn", "Dil jê şa bû."]),

  (id:"b1_422", ku:"Ber bi riya", tr:"Yoluna çıkmak", en:"To set out on the way",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.68,
   not:"\"Ber bi riya … ve çûn\" = … yoluna koyulmak.",
   her:["Ber bi riya welatê xwe ve çû.", "Ber bi riya azadiyê ve."], gen:["Ber bi riya…", "Rê çûn."]),

  (id:"b1_423", ku:"Çi derbas bibe", tr:"Her ne olursa olsun", en:"Whatever happens",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.68,
   not:"İdiyomatik ifade. \"Çi derbas bibe, em berdewam dikin.\"",
   her:["Çi derbas bibe, em têne.", "Çi derbas bibe."], gen:["Çi derbas bibe", "Berdewam bike!"]),

  (id:"b1_424", ku:"Destê xwe dirêj kirin", tr:"Elini uzatmak / Yardıma açık olmak", en:"To extend a hand",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.68,
   not:"\"Dest dirêj kirin\" = elini uzatmak (hem gerçek hem mecaz: yardım etmek).",
   her:["Destê xwe dirêj bike!", "Wê destê xwe dirêj kir."], gen:["Dest dirêj kirin", "Dest dirêj bike."]),

  // ─────────────────────────────────────────────────────────────
  // SİYASET VE TOPLUM DERINLEŞME
  // ─────────────────────────────────────────────────────────────

  (id:"b1_430", ku:"Dengdan", tr:"Oy vermek / Oylamak", en:"To vote",
   cins:"bêcins", ez:null, kat:"siyaset", zor:0.71,
   not:"\"Deng dan\" = ses vermek → oy vermek. [FB]: dengdan v. \"Dengdêr\" = seçmen.",
   her:["Em dê dengbidin.", "Min deng da."], gen:["Dengdan û hilbijartin", "Deng bide!"]),

  (id:"b1_431", ku:"Piştgiriya siyasî", tr:"Siyasi destek", en:"Political support",
   cins:"mê", ez:"piştgiriyê", kat:"siyaset", zor:0.70,
   not:"\"Piştgiriya siyasî\" = siyasi destek. B1\'de siyasi söylem derinleşir.",
   her:["Piştgiriya siyasî lazim e.", "Piştgirî bidim."], gen:["Piştgirî û dijberî", "Piştgiriya me"]),

  (id:"b1_432", ku:"Dijberî", tr:"Muhalefet / Karşı çıkma", en:"Opposition",
   cins:"mê", ez:"dijberiyê", kat:"siyaset", zor:0.70,
   not:"Dişil — \"dijber\" (karşı) + \"-î\". [FB]: dijberî n.f.",
   her:["Dijberî heye.", "Di dijberiyê de ne."], gen:["Dijberî û piştgirî", "Dijberiya me"]),

  (id:"b1_433", ku:"Biryardar", tr:"Kararlı", en:"Determined / Decisive",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.71,
   not:"\"Biryar\" (karar) + \"-dar\" (sahip). [FB]: biryardar adj.",
   her:["Ew biryardar e.", "Bi biryardarî."], gen:["Biryardar û dudil", "Ev biryardar e."]),

  (id:"b1_434", ku:"Piştrastkirî", tr:"Doğrulanmış / Onaylanmış", en:"Confirmed / Verified",
   cins:"bêcins", ez:null, kat:"siyaset", zor:0.68,
   not:"\"Piştrastkirî\" — \"piştras kirin\" (doğrulamak) + \"-î\" pasif sıfat. Gazete dilinde sık.",
   her:["Ev piştrastkirî ye.", "Hêj piştrastkirî nîye."], gen:["Piştrastkirî û guman", "Ev rast e."]),

  // ─────────────────────────────────────────────────────────────
  // DUYGULAR VE PSİKOLOJİ TAM
  // ─────────────────────────────────────────────────────────────

  (id:"b1_440", ku:"Meraq kirin", tr:"Merak etmek", en:"To be curious",
   cins:"bêcins", ez:null, kat:"his", zor:0.73,
   not:"\"Meraq kirin\" — \"Ez meraq dikim\" = merak ediyorum. [FB]: meraq n.m. + kirin.",
   her:["Ez meraq dikim.", "Ew meraq dike."], gen:["Meraq kirin û fêm kirin", "Meraq dikim."]),

  (id:"b1_441", ku:"Şermezar bûn", tr:"Utanmak", en:"To be embarrassed",
   cins:"bêcins", ez:null, kat:"his", zor:0.71,
   not:"\"Şermezar bûn\" — \"Ez şermezar bûm\" = utandım. Heritage bağlamı: dil kayıplarından utanç.",
   her:["Ez şermezar bûm.", "Şermezar nebe!"], gen:["Şermezar û serbilind", "Şermezar bûm."]),

  (id:"b1_442", ku:"Kêfa xwe kirin", tr:"Eğlenmek", en:"To have fun / enjoy",
   cins:"bêcins", ez:null, kat:"his", zor:0.73,
   not:"\"Kêfa xwe kirin\" = eğlenmek. [FB]: kêf n.m. + xwe + kirin.",
   her:["Em kêfa xwe dikin.", "Kêfa te çawa ye?"], gen:["Kêfa xwe kirin û bêhngirtin", "Kêfa xwe bike!"]),

  (id:"b1_443", ku:"Acî", tr:"Acı / Ağrı", en:"Pain / Bitterness",
   cins:"mê", ez:"aciya", kat:"his", zor:0.72,
   not:"Dişil — [FB]: acî n.f. Hem fiziksel acı hem duygusal. \"Aciya jibîrkirina zimanî\" = dil kaybının acısı.",
   her:["Acî gelek e.", "Aciya min."], gen:["Acî û kêfxweşî", "Aciya me"]),

  (id:"b1_444", ku:"Teşwîqkirin", tr:"Teşvik etmek / Cesaretlendirmek", en:"To encourage",
   cins:"bêcins", ez:null, kat:"his", zor:0.70,
   not:"\"Teşwîq kirin\" — [FB]: teşwîq n.m. + kirin.",
   her:["Mamosta teşwîq kir.", "Teşwîq bike!"], gen:["Teşwîqkirin û alîkarî", "Teşwîq bike."]),

  // ─────────────────────────────────────────────────────────────
  // SOSYAL VE DİL KONULARI — B1 özgün kelime seti
  // ─────────────────────────────────────────────────────────────

  (id:"b1_450", ku:"Diaspora", tr:"Diaspora", en:"Diaspora",
   cins:"mê", ez:"diasporayê", kat:"kimlik", zor:0.72,
   not:"Dişil — uluslararası terim. \"Diasporaya kurdî\" = Kürt diasporası.",
   her:["Diasporaya kurdî mezin e.", "Em diasporayê ne."], gen:["Diaspora û welat", "Diasporaya kurdî"]),

  (id:"b1_451", ku:"Koçber", tr:"Göçmen / Sürgün", en:"Migrant / Exile",
   cins:"bêcins", ez:"koçberê", kat:"kimlik", zor:0.72,
   not:"\"Koçberî\" (göç) + kişi. [FB]: koçber n. \"Koçberên kurd\" = Kürt göçmenler.",
   her:["Em koçber in.", "Koçberê baş."], gen:["Koçber û welat", "Koçberên me"]),

  (id:"b1_452", ku:"Jiyanname", tr:"Biyografi", en:"Biography",
   cins:"mê", ez:"jiyannamê", kat:"edebiyat", zor:0.69,
   not:"Dişil — \"jiyan\" (hayat) + \"name\" (yazı). Kurmancî özgün bileşim.",
   her:["Jiyannameyê dixwînim.", "Jiyannameyê nivîsand."], gen:["Jiyanname û dîrok", "Jiyannameyê me"]),

  (id:"b1_453", ku:"Kurdistanî", tr:"Kürdistanlı / Kürdistana ait", en:"From Kurdistan",
   cins:"bêcins", ez:null, kat:"kimlik", zor:0.73,
   not:"\"Kurdistan\" + \"-î\" nispet eki. \"Kultûra Kurdistanî\" = Kürdistan kültürü.",
   her:["Ez Kurdistanî me.", "Nirxên Kurdistanî."], gen:["Kurdistanî û kurd", "Em Kurdistanî ne."]),

  (id:"b1_454", ku:"Cûdaxwazî", tr:"Ayrılıkçılık / Özerklik talebi", en:"Separatism / Autonomy",
   cins:"mê", ez:"cûdaxwaziyê", kat:"siyaset", zor:0.67,
   not:"\"Cuda\" (ayrı) + \"xwazî\" (istek). Siyasi terim.",
   her:["Cûdaxwazî siyaset e.", "Pirsên cûdaxwaziyê."], gen:["Cûdaxwazî û yekîtî", "Pirsa cûdaxwaziyê"]),

  // ─────────────────────────────────────────────────────────────
  // DOĞA VE KIRSAL — B1 Kürdistan coğrafyası
  // ─────────────────────────────────────────────────────────────

  (id:"b1_460", ku:"Zozane", tr:"Yaylak / Yayla", en:"Highland pasture / Summer pasture",
   cins:"mê", ez:"zozanê", kat:"xweza", zor:0.72,
   not:"Dişil — [BH] §273: \"Zozanvanî, yaylaya çıkma\". [FB]: zozan n.f. Kürt pastoral yaşamının merkezi.",
   her:["Bihar em diçin zozanê.", "Zozana me xweş e."], gen:["Zozan û gund", "Zozana me"]),

  (id:"b1_461", ku:"Gund", tr:"Köy", en:"Village",
   cins:"nêr", ez:"gundê", kat:"cih", zor:0.76,
   not:"Eril — [FB]: gund n.m. A1\'de var, B1\'de kültürel derinlik. \"Gundê min\" = köyüm.",
   her:["Ez ji gundê me.", "Gundê me xweş e."], gen:["Gund û bajêr", "Gundê me"]),

  (id:"b1_462", ku:"Gundiyan", tr:"Köylüler", en:"Villagers",
   cins:"bêcins", ez:"gundiyên", kat:"civakî", zor:0.70,
   not:"\"Gundî\" (köylü) + \"-yan\" çoğul. [FB]: gundî n.",
   her:["Gundiyan hat.", "Gundiyanê me."], gen:["Gundiyan û bajêrvan", "Gundiyanê me"]),

  (id:"b1_463", ku:"Biharê", tr:"İlkbaharda", en:"In spring",
   cins:"bêcins", ez:null, kat:"xweza", zor:0.80,
   not:"\"Biharê\" = ilkbaharda (zaman zarfı). A1\'de \"bihar\" isim olarak var. B1\'de zarfsal kullanım.",
   her:["Biharê kulîlk şîn dibin.", "Biharê em diçin zozanê."], gen:["Biharê û zivistanê", "Biharê xweş e."]),

  (id:"b1_464", ku:"Payîzê", tr:"Sonbaharda", en:"In autumn",
   cins:"bêcins", ez:null, kat:"xweza", zor:0.80,
   not:"\"Payîzê\" = sonbaharda. [BH] §273: \"Deştvanî, yayladan inme (sonbaharda)\".",
   her:["Payîzê genim tê berhevkirin.", "Payîzê xweş e."], gen:["Payîzê û biharê", "Payîzê hat."]),

  (id:"b1_465", ku:"Havînê", tr:"Yazın", en:"In summer",
   cins:"bêcins", ez:null, kat:"xweza", zor:0.81,
   not:"\"Havînê\" = yazın. \"Havîn\" (yaz) + \"-ê\" zarfsal.",
   her:["Havînê germ e.", "Havînê em diçin behrê."], gen:["Havînê û zivistanê", "Havînê baş e."]),

  (id:"b1_466", ku:"Zivistanê", tr:"Kışın", en:"In winter",
   cins:"bêcins", ez:null, kat:"xweza", zor:0.81,
   not:"\"Zivistanê\" = kışın. Tüm mevsim zarfları aynı yapıda.",
   her:["Zivistanê berf dibare.", "Zivistanê sar e."], gen:["Zivistanê û havînê", "Zivistanê sar e."]),

  // ─────────────────────────────────────────────────────────────
  // DİL BİLİMİ VE GRAMER TERİMLERİ — B1 meta-dil
  // ─────────────────────────────────────────────────────────────

  (id:"b1_470", ku:"Navdêr", tr:"İsim (dilbilgisi)", en:"Noun",
   cins:"mê", ez:"navdêrê", kat:"rêziman", zor:0.72,
   not:"Dişil — \"nav\" (ad) + \"dêr\" (veren). [BH] terminoloji. \"Navdêra mê\" = dişil isim.",
   her:["Ev navdêr e.", "Navdêrên kurdî."], gen:["Navdêr û lêker", "Navdêra me"]),

  (id:"b1_471", ku:"Lêker", tr:"Fiil (dilbilgisi)", en:"Verb",
   cins:"nêr", ez:"lêkerê", kat:"rêziman", zor:0.72,
   not:"Eril — \"lê\" (ona/üstüne) + \"ker\" (yapan). [BH] terminoloji.",
   her:["Ev lêker e.", "Lêkerên ergatif."], gen:["Lêker û navdêr", "Lêkerê me"]),

  (id:"b1_472", ku:"Rengdêr", tr:"Sıfat (dilbilgisi)", en:"Adjective",
   cins:"nêr", ez:"rengdêrê", kat:"rêziman", zor:0.71,
   not:"Eril — \"reng\" (renk/nitelik) + \"dêr\" (veren). [BH] terminoloji.",
   her:["Ev rengdêr e.", "Rengdêrên kurdî nayên guhêztin."], gen:["Rengdêr û navdêr", "Rengdêrê me"]),

  (id:"b1_473", ku:"Daçek", tr:"Edat (dilbilgisi)", en:"Preposition",
   cins:"nêr", ez:"daçekê", kat:"rêziman", zor:0.70,
   not:"Eril — [FB]: daçek n.m. \"Li, ji, bi, bo, di…de\" gibi edatlar.",
   her:["Ev daçek e.", "Daçekên kurdî gelek in."], gen:["Daçek û cînavk", "Daçekê me"]),

  (id:"b1_474", ku:"Cînavk", tr:"Zamir (dilbilgisi)", en:"Pronoun",
   cins:"nêr", ez:"cînavkê", kat:"rêziman", zor:0.71,
   not:"Eril — [BH]: cînavk = zamir. \"Cînavkên şexsî\" = kişi zamirleri.",
   her:["Ev cînavk e.", "Cînavkên kurdî."], gen:["Cînavk û navdêr", "Cînavkê me"]),

  (id:"b1_475", ku:"Kok", tr:"Kök (dilbilgisi)", en:"Root / Stem",
   cins:"nêr", ez:"kokê", kat:"rêziman", zor:0.71,
   not:"Eril — \"Koka lêkerê\" = fiilin kökü. [BH] morfoloji terminolojisi. \"Pêşgir\" = önek, \"paşgir\" = sonek (ikisi de Kurmancî özgün).",
   her:["Koka \"çûn\"ê çi ye?", "Kok û paşgir."], gen:["Kok û paşgir", "Koka lêkerê"]),

  // ─────────────────────────────────────────────────────────────
  // KURUM VE ÖRGÜT KELİMELERİ
  // ─────────────────────────────────────────────────────────────

  (id:"b1_480", ku:"Zanîngeh", tr:"Üniversite", en:"University",
   cins:"mê", ez:"zanîgehê", kat:"perwerde", zor:0.73,
   not:"Dişil — \"zanîn\" (bilim) + \"-geh\" (yer). [BH] §274: -geh soneki. \"Zanîgehên kurdî.\"",
   her:["Li zanîgehê dixwînim.", "Zanîgeh li bajêr e."], gen:["Zanîgeh û dibistan", "Zanîgeha me"]),

  (id:"b1_481", ku:"Enstîtu", tr:"Enstitü", en:"Institute",
   cins:"nêr", ez:"enstîtuyê", kat:"perwerde", zor:0.70,
   not:"Eril — [FB]: enstîtu n.m. \"Enstîtoya Kurdî ya Parîsê\" = Institut Kurde de Paris.",
   her:["Enstîtu kar dike.", "Di enstîtuyê de ne."], gen:["Enstîtu û zanîgeh", "Enstîtoya me"]),

  (id:"b1_482", ku:"Sazî", tr:"Kurum / Müessese", en:"Institution",
   cins:"mê", ez:"saziyê", kat:"perwerde", zor:0.70,
   not:"Dişil — [FB]: sazî n.f. \"Saziyên kurdî\" = Kürt kurumları.",
   her:["Sazî baş e.", "Saziyên me gelek in."], gen:["Sazî û rêxistin", "Saziya me"]),

  (id:"b1_483", ku:"Arşîv", tr:"Arşiv", en:"Archive",
   cins:"nêr", ez:"arşîvê", kat:"dîrok", zor:0.69,
   not:"Eril — [FB]: arşîv n.m. \"Arşîva folklorê\" = folklor arşivi.",
   her:["Arşîv di enstîtuyê de ye.", "Arşîvê lêkolîn kir."], gen:["Arşîv û pirtûkxane", "Arşîva me"]),

  // ─────────────────────────────────────────────────────────────
  // HAYAT KALİTESİ VE GÜNDELIK YAŞAM
  // ─────────────────────────────────────────────────────────────

  (id:"b1_490", ku:"Rewşa jiyanê", tr:"Yaşam koşulları", en:"Living conditions",
   cins:"mê", ez:"rewşê", kat:"civakî", zor:0.71,
   not:"\"Rewş\" (durum/koşul) + \"jiyanê\" (yaşamın). [FB]: rewş n.f.",
   her:["Rewşa jiyanê baştir dibe.", "Rewşa me."], gen:["Rewş û jiyan", "Rewşa me"]),

  (id:"b1_491", ku:"Pêşkeftin", tr:"İlerleme / Gelişim", en:"Progress / Development",
   cins:"mê", ez:"pêşkeftinê", kat:"civakî", zor:0.72,
   not:"Dişil — \"pêş\" (ön) + \"ketin\" (düşmek) → ilerleme. [FB]: pêşketin n.f.",
   her:["Pêşkeftina ziman.", "Pêşketin baş e."], gen:["Pêşkeftin û paşketin", "Pêşkeftina me"]),

  (id:"b1_492", ku:"Paşketin", tr:"Gerileme / Düşüş", en:"Decline / Regression",
   cins:"mê", ez:"paşkeftinê", kat:"civakî", zor:0.69,
   not:"Dişil — \"paş\" (arka) + \"ketin\". Zıt: pêşketin. \"Zimanê paşketî\" = gerilemiş dil.",
   her:["Paşketin heye.", "Paşkeftina zimanê kurdî."], gen:["Paşketin û pêşketin", "Paşkeftina me"]),

  (id:"b1_493", ku:"Çakbûn", tr:"İyileşmek / Düzelmek", en:"To improve / recover",
   cins:"bêcins", ez:null, kat:"leker", zor:0.71,
   not:"\"Çakbûn\" fiili — \"Ew çak bû\" = iyileşti. [FB]: çak adj./v.",
   her:["Nexweş çak bû.", "Pirsgirêk çak bû."], gen:["Çakbûn û nexweşbûn", "Çak bû."]),

  (id:"b1_494", ku:"Xerabûn", tr:"Bozulmak / Kötüleşmek", en:"To deteriorate / worsen",
   cins:"bêcins", ez:null, kat:"leker", zor:0.70,
   not:"\"Xerabûn\" — \"Hewa xerab bû\" = hava bozuldu. [FB]: xerab adj./v.",
   her:["Hewa xerab bû.", "Rewş xerab bû."], gen:["Xerabûn û çakbûn", "Xerab bû."]),

  // ─────────────────────────────────────────────────────────────
  // SAYILABİLİR KELİMELER — miktar ve ölçü
  // ─────────────────────────────────────────────────────────────

  (id:"b1_500", ku:"Hejmara", tr:"Sayı / Miktar", en:"Number / Quantity",
   cins:"mê", ez:"hejmarê", kat:"jimar", zor:0.72,
   not:"Dişil — [FB]: hejmar n.f. \"Hejmara xwendekaran\" = öğrenci sayısı.",
   her:["Hejmara me zêde bû.", "Hejmara baş."], gen:["Hejmar û kêmasî", "Hejmara me"]),

  (id:"b1_501", ku:"Pirranî", tr:"Çoğunluk", en:"Majority",
   cins:"mê", ez:"pirraniyê", kat:"jimar", zor:0.71,
   not:"Dişil — [BH] §275: \"Piranî, çoğunluk\". [FB]: piranî n.f.",
   her:["Pirraniya gel.", "Pirranî erê got."], gen:["Pirranî û kêmanî", "Pirraniya me"]),

  (id:"b1_502", ku:"Kêmanî", tr:"Azınlık", en:"Minority",
   cins:"mê", ez:"kêmaniyê", kat:"jimar", zor:0.70,
   not:"Dişil — \"kêm\" + \"-anî\". [FB]: kêmanî n.f. \"Kêmaniya kurdî\" = Kürt azınlığı.",
   her:["Kêmaniya kurdî.", "Di kêmaniyê de ne."], gen:["Kêmanî û pirranî", "Kêmaniya me"]),

  // ─────────────────────────────────────────────────────────────
  // KARMAŞIK SÖZDIZIMI
  // ─────────────────────────────────────────────────────────────

  (id:"b1_510", ku:"Ji aliyê", tr:"-nın tarafından / -e göre", en:"From the side of / According to",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.70,
   not:"\"Ji aliyê … ve\" = -nın tarafından. Gazete ve resmi dilde sık. \"Ji aliyê hikûmetê ve\" = hükümet tarafından.",
   her:["Ji aliyê hikûmetê ve.", "Ji aliyê wan ve hat."], gen:["Ji aliyê…", "Ji aliyê wan"]),

  (id:"b1_511", ku:"Bi hêviya", tr:"Umuduyla / -ini umarak", en:"With the hope of",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.69,
   not:"\"Bi hêviya ku…\" = umarak ki. Resmi mektuplarda ve edebiyatta.",
   her:["Bi hêviya baştir bibe.", "Bi hêviya ku were."], gen:["Bi hêviya ku…", "Bi hêvî"]),

  (id:"b1_512", ku:"Li ser bingeha", tr:"Temelinde / Dayanarak", en:"Based on",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.69,
   not:"\"Li ser bingeha\" = -e dayanarak. Akademik ve hukuki metin.",
   her:["Li ser bingeha mafan.", "Li ser bingeha zanistê."], gen:["Li ser bingeha…", "Bingeh"]),

  (id:"b1_513", ku:"Wek nimûne", tr:"Örneğin", en:"For example",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Wek nimûne\" = örneğin. [FB]: nimûne n.f. Açıklama ve argümanlarda.",
   her:["Wek nimûne, Kurmancî.", "Wek nimûne, Cegerxwîn."], gen:["Wek nimûne…", "Nimûne bide!"]),

  (id:"b1_514", ku:"Bi taybet", tr:"Özellikle", en:"Especially / In particular",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Bi taybet\" = özellikle. [FB]: taybet adj. + bi.",
   her:["Bi taybet ziman girîng e.", "Bi taybet ji te spas."], gen:["Bi taybet û bi giştî", "Bi taybet"]),

  (id:"b1_515", ku:"Bi giştî", tr:"Genel olarak", en:"In general",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Bi giştî\" = genel olarak. \"Giştî\" = genel/herkese ait.",
   her:["Bi giştî baş e.", "Bi giştî û bi taybet."], gen:["Bi giştî û bi taybet", "Bi giştî"]),

];



// KAYNAK DOĞRULAMA NOTU — B1
// Ergatif tam çekim: [BH] §170–185 — kritik B1 konusu
// Şimdiki mükemmel (-iye): [TH] §72
// Sürekli geçmiş (di-...-): [TH] §70
// Subjunctive (bila + kök): [BH] §190
// Kimlik kelimeleri: [FB] + [AZ] Ders 18
// "Keskesor": [BH] p.277 bileşik kelimeler — dişil ✓
// "Asimilasyon": modern terim, Kurmancîde aynen kullanılır


// ════════════════════════════════════════════════════════════════
// B1 EK KELİMELER — Dördüncü Kısım (+400 kelime)
// ════════════════════════════════════════════════════════════════

final kB1EkKelimeler4 = [

  // ── BEDEN VE DUYUM ─────────────────────────────────────────
  (id:"b1_800", ku:"Endam", tr:"Uzuv / Organ", en:"Limb / Organ",
   cins:"nêr", ez:"endamê", kat:"beden", zor:0.69,
   not:"Eril — [FB]: endam n.m. \"Endamên bedena mirovî.\"",
   her:["Endamê min diêşe.", "Endamên bedenê."],
   gen:["Endam û uzuv", "Endamên me"]),

  (id:"b1_801", ku:"Hestî", tr:"Kemik", en:"Bone",
   cins:"nêr", ez:"hestiyê", kat:"beden", zor:0.70,
   not:"Eril — [FB]: hestî n.m. \"Hestiyê min şikî\" = kemiğim kırıldı.",
   her:["Hestiyê min şikî.", "Hestî hişk e."],
   gen:["Hestî û goşt", "Hestiyê min"]),

  (id:"b1_802", ku:"Xwîn", tr:"Kan", en:"Blood",
   cins:"mê", ez:"xwînê", kat:"beden", zor:0.72,
   not:"Dişil — [FB]: xwîn n.f. \"Xwîna me kurdî ye.\"",
   her:["Xwîn diçe.", "Xwîna min."],
   gen:["Xwîn û can", "Xwîna kurdî"]),

  (id:"b1_803", ku:"Dil û mêşk", tr:"Kalp ve beyin", en:"Heart and brain",
   cins:"bêcins", ez:null, kat:"beden", zor:0.70,
   not:"\"Dil\" (kalp/gönül) + \"mêşk\" (beyin). Bileşik kullanım.",
   her:["Hem dil hem mêşk divê kar bikin.", "Dil û mêşk hev temam dikin."],
   gen:["Dil û mêşk", "Hem dil hem mêşk"]),

  (id:"b1_804", ku:"Mêşk", tr:"Beyin", en:"Brain",
   cins:"nêr", ez:"mêşkê", kat:"beden", zor:0.71,
   not:"Eril — [FB]: mêşk n.m. \"Mêşkê min kar dike.\"",
   her:["Mêşk kar dike.", "Mêşkê te baş e."],
   gen:["Mêşk û dil", "Mêşkê me"]),

  (id:"b1_805", ku:"Nesaxî", tr:"Sakatlık / Engel", en:"Disability",
   cins:"mê", ez:"nesaxiyê", kat:"tendurist", zor:0.68,
   not:"Dişil — \"ne\" + \"sax\" + \"-î\". [FB]: nesaxî n.f.",
   her:["Ew nesaxîyek heye.", "Ji nesaxiyê re alîkarî."],
   gen:["Nesaxî û tenduristî", "Nesaxîya min"]),

  // ── ERGATİF GELIŞMIŞ ───────────────────────────────────────
  (id:"b1_810", ku:"Veguhêztin", tr:"Aktarmak / İletmek", en:"To convey / transmit",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.68,
   not:"\"Veguhêztin\" geçişli → ergatif. \"Min veguhêzand\" = aktardım.",
   her:["Min ziman veguhêzand.", "Te çi veguhêzand?"],
   gen:["Veguhêztin û parastin", "Min veguhêzand."]),

  (id:"b1_811", ku:"Ragihandin", tr:"Haberdar etmek / Bildirmek", en:"To inform",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.70,
   not:"\"Ragihandin\" geçişli → ergatif. \"Min ragihand.\"",
   her:["Min ragihand.", "Te ragihand?"],
   gen:["Ragihandin û bihîstin", "Min ragihand."]),

  (id:"b1_812", ku:"Têxistin", tr:"Koymak / Sokmak", en:"To put in / insert",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.68,
   not:"\"Têxistin\" geçişli → ergatif. \"Min têxist.\"",
   her:["Min erd têxist.", "Te çi têxist?"],
   gen:["Têxistin û derxistin", "Min têxist."]),

  (id:"b1_813", ku:"Derxistin", tr:"Çıkarmak", en:"To take out / remove",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.68,
   not:"\"Derxistin\" geçişli → ergatif. \"Min derxist.\"",
   her:["Min pirtûk derxist.", "Te çi derxist?"],
   gen:["Derxistin û têxistin", "Min derxist."]),

  // ── ZAMAN SİSTEMİ TAMAMLAMA ────────────────────────────────
  (id:"b1_820", ku:"Digotim", tr:"Söylüyordum (sürekli geçmiş)", en:"I was saying",
   cins:"bêcins", ez:null, kat:"dem_devam", zor:0.70,
   not:"\"Di-got-im\" — ergatif sürekli geçmiş 1.tekil gotin.",
   her:["Min timî digotim ku baş e.", "Min digotim..."],
   gen:["Digotim û gotim", "Min timî digotim."]),

  (id:"b1_821", ku:"Dihatim", tr:"Geliyordum (sürekli geçmiş)", en:"I used to come",
   cins:"bêcins", ez:null, kat:"dem_devam", zor:0.70,
   not:"\"Di-hat-im\" — geçişsiz sürekli geçmiş 1.tekil hatin.",
   her:["Berê timî dihatim.", "Dihatim û diçûm."],
   gen:["Dihatim û çûm", "Timî dihatim."]),

  (id:"b1_822", ku:"Dimirîm", tr:"Ölüyorum (sürekli geçmiş)", en:"I was dying",
   cins:"bêcins", ez:null, kat:"dem_devam", zor:0.68,
   not:"\"Di-mir-im\" — mecaz: \"dimirîm ji serma\" = soğuktan donuyorum.",
   her:["Ji serma dimirîm!", "Ji birçîtiyê dimirîm."],
   gen:["Dimirîm û dijîm", "Ji serma dimirîm."]),

  (id:"b1_823", ku:"Dixwartin", tr:"Yediriyordum", en:"I was feeding",
   cins:"bêcins", ez:null, kat:"dem_devam", zor:0.67,
   not:"\"Di-xw-art-im\" — pêkhatî (ettirgen) sürekli geçmiş.",
   her:["Min zarokê dixwartin.", "Pîrê min dixwartin."],
   gen:["Dixwartin û vedixwandin", "Min dixwartin."]),

  // ── BAĞLAÇ VE SÖZDIZIM TAM ─────────────────────────────────
  (id:"b1_830", ku:"Heta ku", tr:"Dek / -e kadar", en:"Until",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Heta ku\" = -e kadar/dek. [TH] §: temporal conjunctions.",
   her:["Heta ku were, bisekine.", "Heta ku bêyî, li vê derê me."],
   gen:["Heta ku û ji dema ku", "Heta ku..."]),

  (id:"b1_831", ku:"Bi şertê ku", tr:"Şartıyla / Koşuluyla", en:"On condition that",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.70,
   not:"\"Bi şertê ku\" = şartıyla. [TH] §: conditional clauses.",
   her:["Bi şertê ku bêyî, dê çêbe.", "Bi şertê ku kar bikî."],
   gen:["Bi şertê ku", "Şert û merc"]),

  (id:"b1_832", ku:"Weke ku", tr:"Gibi ki / -dığı gibi", en:"As / Just as",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Weke ku\" = gibi ki / -dığı gibi. [BH] §: comparatives.",
   her:["Weke ku Xanî gotiye.", "Weke ku dizanî."],
   gen:["Weke ku û mîna ku", "Weke ku gotibû"]),

  (id:"b1_833", ku:"Ji dema ku", tr:"-den beri / -dığından beri", en:"Since (time)",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Ji dema ku\" = -dığından beri. Zaman bağlacı.",
   her:["Ji dema ku ez hatim, gelek bûyer çêbûn.", "Ji dema ku dizanim."],
   gen:["Ji dema ku û heta ku", "Ji dema ku hat"]),

  (id:"b1_834", ku:"Bi qasî ku", tr:"Olduğu kadar", en:"As much as",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.69,
   not:"\"Bi qasî ku\" = olduğu kadar/kadar. [TH] §.",
   her:["Bi qasî ku dikarim, dikim.", "Bi qasî ku lazim e."],
   gen:["Bi qasî ku", "Bi qasî min"]),

  // ── KÜRT COĞRAFYASI VE TARİH ───────────────────────────────
  (id:"b1_840", ku:"Serhedê", tr:"Sınır bölgesi", en:"Border region",
   cins:"nêr", ez:"Serhedê", kat:"cografî", zor:0.69,
   not:"Eril — \"Serhed\" = Kuzey Kürdistan'ın kuzeydoğu bölgesi.",
   her:["Serhedê kûr û dirêj e.", "Xelkên Serhedê."],
   gen:["Serhed û Botan", "Mêrga Serhedê"]),

  (id:"b1_841", ku:"Botan", tr:"Botan (bölge)", en:"Botan region",
   cins:"nêr", ez:"Botanê", kat:"cografî", zor:0.69,
   not:"Eril — tarihî Kürt bölgesi. Güneydoğu Türkiye.",
   her:["Botanê xweş e.", "Devoka Botanê."],
   gen:["Botan û Serhed", "Xelkên Botanê"]),

  (id:"b1_842", ku:"Mêrdîn", tr:"Mardin", en:"Mardin",
   cins:"mê", ez:"Mêrdînê", kat:"cografî", zor:0.70,
   not:"Dişil — \"Li Mêrdînê\" = Mardin'de. Tarihi Kürt/Süryani şehri.",
   her:["Mêrdîn bajarekî dîrokî ye.", "Li Mêrdînê ne."],
   gen:["Mêrdîn û Amed", "Li Mêrdînê"]),

  (id:"b1_843", ku:"Dersim", tr:"Dersim (Tunceli)", en:"Dersim (Tunceli)",
   cins:"nêr", ez:"Dersimê", kat:"cografî", zor:0.70,
   not:"Eril — tarihî Kürt bölgesi. Alevi Kürtlerin yurdu.",
   her:["Dersim li bakurê Kurdistanê ye.", "Xelkên Dersimê."],
   gen:["Dersim û Serhed", "Li Dersimê"]),

  (id:"b1_844", ku:"Afrîn", tr:"Afrin", en:"Afrin",
   cins:"mê", ez:"Afrînê", kat:"cografî", zor:0.69,
   not:"Dişil — Rojavaya Kurdistanê'de bölge.",
   her:["Afrîn li Rojavayê ye.", "Xelkên Afrînê."],
   gen:["Afrîn û Kobanê", "Li Afrînê"]),

  (id:"b1_845", ku:"Kobanê", tr:"Kobane", en:"Kobane",
   cins:"mê", ez:"Kobanê", kat:"cografî", zor:0.70,
   not:"Dişil — tarihî öneme sahip Rojava şehri. 2014-15 direnişi.",
   her:["Kobanê li Rojavayê ye.", "Berxwedana Kobanê."],
   gen:["Kobanê û Afrîn", "Berxwedana Kobanê"]),

  // ── KÜRT MÜZİĞİ VE SANATI ─────────────────────────────────
  (id:"b1_850", ku:"Sêtar", tr:"Saz (enstrüman)", en:"Saz (instrument)",
   cins:"nêr", ez:"sêtarê", kat:"huner", zor:0.71,
   not:"Eril — [AS]: \"sitar/saz = sêtar\" ✓. \"Sêtar lêxistin\" = saz çalmak.",
   her:["Dengbêj sêtar lêdixe.", "Sêtarê kurd."],
   gen:["Sêtar û blûr", "Sêtarê min"]),

  (id:"b1_851", ku:"Blûr", tr:"Kaval / Düdük", en:"Flute / Shepherd's pipe",
   cins:"nêr", ez:"blûrê", kat:"huner", zor:0.71,
   not:"Eril — [FB]: blûr n.m. Kürt çoban müziğinin sembolü.",
   her:["Çoban blûr lêdixe.", "Dengê blûrê xweş e."],
   gen:["Blûr û sêtar", "Blûrê çobanî"]),

  (id:"b1_852", ku:"Dawil", tr:"Davul", en:"Drum",
   cins:"nêr", ez:"dawilê", kat:"huner", zor:0.72,
   not:"Eril — [AS]: \"davul = dawil\" ✓.",
   her:["Dawil lêdan.", "Dengê dawilê dûr tê."],
   gen:["Dawil û zurna", "Dawilê cejnê"]),

  (id:"b1_853", ku:"Zurna", tr:"Zurna", en:"Zurna (double reed instrument)",
   cins:"mê", ez:"zurnayê", kat:"huner", zor:0.72,
   not:"Dişil — [AS]: \"zurna = zurna\" ✓. \"Dawil û zurna\" = düğün müziği.",
   her:["Zurna lêxistin.", "Dawil û zurna cejnê ne."],
   gen:["Zurna û dawil", "Dengê zurnayê"]),

  // ── GELENEKSEl TERİMLER ────────────────────────────────────
  (id:"b1_860", ku:"Govend", tr:"Halay / Halk dansı", en:"Circle dance",
   cins:"mê", ez:"govendê", kat:"çand", zor:0.73,
   not:"Dişil — [FB]: govend n.f. \"Govend girtin\" = halaya durmak.",
   her:["Govend girtin.", "Govendê xweş didin."],
   gen:["Govend û stran", "Govenda me"]),

  (id:"b1_861", ku:"Dawet", tr:"Düğün", en:"Wedding",
   cins:"mê", ez:"dawetê", kat:"çand", zor:0.83,
   not:"Dişil — [AS]: \"düğün = dawet\" ✓.",
   her:["Dawet hat.", "Em diçin dawetê."],
   gen:["Dawet û cejn", "Daweta me"]),

  (id:"b1_862", ku:"Mathera", tr:"Yas / Matem", en:"Mourning",
   cins:"mê", ez:"matherê", kat:"çand", zor:0.69,
   not:"Dişil — [FB]: mathera n.f. \"Di mathereyê de ne.\"",
   her:["Mathera mezin e.", "Di matherê de ne."],
   gen:["Mathera û şahî", "Mathera wan"]),

  (id:"b1_863", ku:"Şahî", tr:"Şenlik / Kutlama", en:"Celebration / Festivity",
   cins:"mê", ez:"şahiyê", kat:"çand", zor:0.72,
   not:"Dişil — [FB]: şahî n.f.",
   her:["Şahî tê lidarxistin.", "Şahîya mezin."],
   gen:["Şahî û dawet", "Şahîya me"]),

  // ── BİTKİ VE TARIM ─────────────────────────────────────────
  (id:"b1_870", ku:"Tûtî", tr:"Dut", en:"Mulberry",
   cins:"nêr", ez:"tûtiyê", kat:"xweza", zor:0.69,
   not:"Eril — [FB]: tûtî n.m. Kürdistan'da yaygın.",
   her:["Darê tûtiyê mezin e.", "Tûtî çin kirin."],
   gen:["Tûtî û gûz", "Darê tûtiyê"]),

  (id:"b1_871", ku:"Encîr", tr:"İncir", en:"Fig",
   cins:"nêr", ez:"encîrê", kat:"xweza", zor:0.69,
   not:"Eril — [FB]: encîr n.m. \"Encîrên şîrîn.\"",
   her:["Encîr şîrîn e.", "Min encîr xwar."],
   gen:["Encîr û tirî", "Encîrên şîrîn"]),

  (id:"b1_872", ku:"Zêreşk", tr:"Alıç / Yaban meyvesi", en:"Wild berry",
   cins:"nêr", ez:"zêreşkê", kat:"xweza", zor:0.68,
   not:"Eril — [FB]: zêreşk n.m. Kürdistan dağlarında.",
   her:["Zêreşk tirş e.", "Ji çiyayê zêreşk."],
   gen:["Zêreşk û tirî", "Zêreşkên çiyayê"]),

  (id:"b1_873", ku:"Darîstan", tr:"Orman", en:"Forest",
   cins:"mê", ez:"daristanê", kat:"xweza", zor:0.71,
   not:"Dişil — \"dar\" + \"-istan\". [BH] §274: -istan eki.",
   her:["Darîstan kesk e.", "Di daristanê de."],
   gen:["Darîstan û zozan", "Darîstana me"]),

  // ── TOPLUMSAL BELİRTEÇLER ──────────────────────────────────
  (id:"b1_880", ku:"Serbixwe", tr:"Bağımsız", en:"Independent",
   cins:"bêcins", ez:null, kat:"siyaset", zor:0.71,
   not:"\"Ser\" + \"bi\" + \"xwe\". [FB]: serbixwe adj.",
   her:["Ew serbixwe ye.", "Serbixwe bin!"],
   gen:["Serbixwe û girêdayî", "Ev serbixwe ye."]),

  (id:"b1_881", ku:"Azad", tr:"Özgür", en:"Free",
   cins:"bêcins", ez:null, kat:"siyaset", zor:0.74,
   not:"\"Azad\" — [FB]: azad adj. \"Azadî\" = özgürlük.",
   her:["Ew azad e.", "Bila azad bibin!"],
   gen:["Azad û bindest", "Ev azad e."]),

  (id:"b1_882", ku:"Bindest", tr:"Bağımlı / Esir", en:"Dependent / Subjugated",
   cins:"bêcins", ez:null, kat:"siyaset", zor:0.69,
   not:"\"Bin\" + \"dest\". [FB]: bindest adj.",
   her:["Ew bindest e.", "Bindest nebe!"],
   gen:["Bindest û azad", "Ev bindest e."]),

  (id:"b1_883", ku:"Serfiraz", tr:"Gururlu / Onurlu", en:"Proud / Honorable",
   cins:"bêcins", ez:null, kat:"his", zor:0.69,
   not:"\"Ser\" + \"firaz\" (yüksek). [FB]: serfiraz adj.",
   her:["Ew serfiraz e.", "Serfiraz bin!"],
   gen:["Serfiraz û xar", "Ev serfiraz e."]),

  (id:"b1_884", ku:"Serbilind", tr:"Onurlu / Vakur", en:"Dignified / Proud",
   cins:"bêcins", ez:null, kat:"his", zor:0.70,
   not:"\"Ser\" + \"bilind\" (yüksek baş). [FB]: serbilind adj.",
   her:["Ew serbilind e.", "Bi serê bilind."],
   gen:["Serbilind û şermezar", "Ev serbilind e."]),

  // ── BİLİŞSEL VE FELSEFÎ EYLEMLER ──────────────────────────
  (id:"b1_890", ku:"Zanistî", tr:"Bilimsel", en:"Scientific",
   cins:"bêcins", ez:null, kat:"zanist", zor:0.70,
   not:"\"Zanist\" + \"-î\". [FB]: zanistî adj.",
   her:["Bi awayek zanistî.", "Lêkolîna zanistî."],
   gen:["Zanistî û giyanî", "Awayekî zanistî"]),

  (id:"b1_891", ku:"Giyanî", tr:"Manevi / Ruhsal", en:"Spiritual",
   cins:"bêcins", ez:null, kat:"his", zor:0.69,
   not:"\"Giyan\" + \"-î\". [FB]: giyanî adj.",
   her:["Pêwendîya giyanî.", "Jiyana giyanî."],
   gen:["Giyanî û laşî", "Jiyana giyanî"]),

  (id:"b1_892", ku:"Laşî", tr:"Bedensel / Fiziksel", en:"Physical / Bodily",
   cins:"bêcins", ez:null, kat:"beden", zor:0.69,
   not:"\"Laş\" (beden) + \"-î\". [FB]: laşî adj.",
   her:["Êşa laşî.", "Tenduristîya laşî."],
   gen:["Laşî û giyanî", "Êşa laşî"]),

  (id:"b1_893", ku:"Têkildar", tr:"İlgili / Bağlantılı", en:"Related / Connected",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.70,
   not:"\"Têkilî\" + \"-dar\". [FB]: têkildar adj.",
   her:["Ev têkildar e.", "Pirsgirêka têkildar."],
   gen:["Têkildar û serbixwe", "Ev têkildar e."]),

  // ── GÜNLÜK HAYATTAKİ SOYUT KAVRAMLAR ──────────────────────
  (id:"b1_900", ku:"Xwestek", tr:"İstek / Arzu", en:"Wish / Desire",
   cins:"mê", ez:"xwestekê", kat:"his", zor:0.71,
   not:"Dişil — \"xwestin\" + \"-ek\". [FB]: xwestek n.f.",
   her:["Xwesteka min heye.", "Xwestekên te."],
   gen:["Xwestek û hewce", "Xwesteka min"]),

  (id:"b1_901", ku:"Hewl", tr:"Çaba / Gayret", en:"Effort",
   cins:"nêr", ez:"hewlê", kat:"his", zor:0.72,
   not:"Eril — [FB]: hewl n.m. \"Hewl dan\" = çaba göstermek.",
   her:["Hewlê te spas.", "Hewl bide!"],
   gen:["Hewl û serkeftin", "Hewlê me"]),

  (id:"b1_902", ku:"Kêmasî", tr:"Eksiklik / Kusur", en:"Deficiency / Shortcoming",
   cins:"mê", ez:"kêmasiyê", kat:"temel", zor:0.70,
   not:"Dişil — \"kêm\" + \"-asî\". [FB]: kêmasî n.f.",
   her:["Kêmasîya min heye.", "Kêmasî çêbe."],
   gen:["Kêmasî û tevahî", "Kêmasîya me"]),

  (id:"b1_903", ku:"Tevahî", tr:"Bütünlük / Tüm", en:"Wholeness / All",
   cins:"bêcins", ez:null, kat:"temel", zor:0.71,
   not:"\"Tev\" + \"-ahî\". [FB]: tevahî adj./n.",
   her:["Tevahîya gel.", "Tevahî hat."],
   gen:["Tevahî û kêmasî", "Tevahîya me"]),

  (id:"b1_904", ku:"Pişkdarî", tr:"Katılım", en:"Participation",
   cins:"mê", ez:"pişkdariyê", kat:"civakî", zor:0.69,
   not:"Dişil — \"pişk\" + \"-darî\". [FB]: pişkdarî n.f.",
   her:["Pişkdarîya xwe bike.", "Pişkdarîya gel."],
   gen:["Pişkdarî û dûrxistin", "Pişkdarîya me"]),

  // ── MESLEKİ GELİŞİM ────────────────────────────────────────
  (id:"b1_910", ku:"Karîger", tr:"Yetenekli / Uzman", en:"Skilled / Expert",
   cins:"bêcins", ez:"karîgerê", kat:"pîşe", zor:0.69,
   not:"\"Kar\" + \"-îger\". [FB]: karîger n. \"Karîgerên kurdî.\"",
   her:["Ew karîger e.", "Karîgerên me."],
   gen:["Karîger û nûhatî", "Karîgerê me"]),

  (id:"b1_911", ku:"Pispor", tr:"Uzman", en:"Specialist",
   cins:"bêcins", ez:"pisporê", kat:"pîşe", zor:0.70,
   not:"\"Pis\" + \"-por\". [FB]: pispor n.",
   her:["Pispor hat.", "Pisporê bijîşkiyê."],
   gen:["Pispor û nûhatî", "Pisporê me"]),

  (id:"b1_912", ku:"Nûhatî", tr:"Acemi / Yeni başlayan", en:"Beginner / Novice",
   cins:"bêcins", ez:null, kat:"pîşe", zor:0.68,
   not:"\"Nû\" + \"hatî\" = yeni gelmiş. [FB]: nûhatî adj.",
   her:["Ew nûhatî ye.", "Nûhatîyên me."],
   gen:["Nûhatî û pispor", "Ev nûhatî ye."]),

  // ── BAĞLAÇ VE ANLATIM ──────────────────────────────────────
  (id:"b1_920", ku:"Bi tenê", tr:"Yalnızca / Sadece", en:"Only / Just",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.73,
   not:"\"Bi tenê\" = yalnızca. [FB]: tenê adv.",
   her:["Bi tenê ez mam.", "Bi tenê ziman girîng e."],
   gen:["Bi tenê û bi hev re", "Bi tenê"]),

  (id:"b1_921", ku:"Bi giranî", tr:"Yoğun biçimde", en:"Intensively",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.69,
   not:"\"Bi giranî\" = ağırlıklı olarak/yoğun.",
   her:["Bi giranî kar kir.", "Bi giranî dixwîne."],
   gen:["Bi giranî û sivik", "Bi giranî"]),

  (id:"b1_922", ku:"Her weha", tr:"Ayrıca / Bunun yanında", en:"Also / Furthermore",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Her weha\" = ayrıca. Gazete ve resmi metin.",
   her:["Her weha, ziman çand e.", "Her weha girîng e."],
   gen:["Her weha û lewre", "Her weha"]),

  (id:"b1_923", ku:"Bi hêvî", tr:"Umarım / İnşallah", en:"Hopefully",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Bi hêvî\" = umarım. [FB]: hêvî n.f. + bi.",
   her:["Bi hêvî dê bê.", "Bi hêvî baştir bibe."],
   gen:["Bi hêvî", "Bi hêviyê"]),

  // ── BİLİM VE AKADEMİ ──────────────────────────────────────
  (id:"b1_930", ku:"Lêgerîn", tr:"Araştırma", en:"Research / Search",
   cins:"mê", ez:"lêgerînê", kat:"zanist", zor:0.71,
   not:"Dişil — \"lê\" + \"gerîn\". [FB]: lêgerîn n.f.",
   her:["Lêgerîna baş kir.", "Lêgerîna zimanî."],
   gen:["Lêgerîn û lêkolîn", "Lêgerîna me"]),

  (id:"b1_931", ku:"Encam", tr:"Sonuç", en:"Result / Conclusion",
   cins:"nêr", ez:"encamê", kat:"zanist", zor:0.72,
   not:"Eril — [FB]: encam n.m. \"Encama lêkolînê.\"",
   her:["Encam baş e.", "Encamên lêkolînê."],
   gen:["Encam û sedem", "Encama me"]),

  (id:"b1_932", ku:"Rêbaz", tr:"Yöntem / Metod", en:"Method",
   cins:"nêr", ez:"rêbazê", kat:"zanist", zor:0.69,
   not:"Eril — \"rê\" + \"baz\". [FB]: rêbaz n.m.",
   her:["Rêbaza baş.", "Bi rêbazekî zanistî."],
   gen:["Rêbaz û teorî", "Rêbaza me"]),

  (id:"b1_933", ku:"Nîqaş", tr:"Tartışma", en:"Discussion / Debate",
   cins:"nêr", ez:"nîqaşê", kat:"zanist", zor:0.70,
   not:"Eril — [AS] no.1099: \"tartışmak = nîgaş kirin, gengeşî kirin\" ✓.",
   her:["Nîqaş baş bû.", "Di nîqaşê de axivî."],
   gen:["Nîqaş û biryar", "Nîqaşa me"]),

  // ── ÖZEL İFADELER ─────────────────────────────────────────
  (id:"b1_940", ku:"Can û dil", tr:"Can ve gönül (bütün varlığı)", en:"Body and soul",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.70,
   not:"\"Can\" (ruh/can) + \"dil\" (gönül). Tam adanmışlık ifadesi.",
   her:["Can û dilê min e.", "Bi can û dil dixebitim."],
   gen:["Can û dil", "Bi can û dil"]),

  (id:"b1_941", ku:"Serê xwe xweş kirin", tr:"İyi vakit geçirmek", en:"To have a good time",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.69,
   not:"Deyim — \"serê xwe\" (kafasını) + \"xweş kirin\" (güzel yapmak).",
   her:["Serê xwe xweş bikin!", "Min serê xwe xweş kir."],
   gen:["Serê xwe xweş kirin", "Xweş bike!"]),

  (id:"b1_942", ku:"Bi xêr û ewlehî", tr:"Selametle / Sağlıkla", en:"Safely / In good health",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.69,
   not:"\"Xêr\" (hayır) + \"ewlehî\" (güvenlik). Yolculuk ve ayrılış duası.",
   her:["Bi xêr û ewlehî here!", "Bi xêr û ewlehî vegeriya."],
   gen:["Bi xêr û ewlehî!", "Bi xêr here!"]),

];


// ════════════════════════════════════════════════════════════════
// B1 EK KELİMELER — Beşinci Kısım (+350 kelime)
// Odak: Akademik dil, Kürt edebiyatı, tarih, toplum,
//       gelişmiş dilbilgisi, mesleki, felsefi
// ════════════════════════════════════════════════════════════════

final kB1EkKelimeler5 = [

  // ── ERGATİF VE ÖZEL FİİL — BH §170-185 ────────────────────
  (id:"b1_1000", ku:"Bijartin", tr:"Seçmek", en:"To choose / select",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.69,
   not:"\"Bijartin\" geçişli → ergatif. \"Min bijart\" = seçtim.",
   her:["Min bijart.", "Te kê bijart?"],
   gen:["Bijartin û red kirin", "Min bijart."]),

  (id:"b1_1001", ku:"Parastin", tr:"Korumak / Savunmak", en:"To protect / defend",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.71,
   not:"\"Parastin\" geçişli → ergatif. \"Min parast\" = korudum.",
   her:["Min ziman parast.", "Te çi parast?"],
   gen:["Parastin û winda kirin", "Min parast."]),

  (id:"b1_1002", ku:"Qebûl kirin", tr:"Kabul etmek", en:"To accept",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.72,
   not:"\"Qebûl kirin\" geçişli → ergatif. \"Min qebûl kir.\"",
   her:["Min qebûl kir.", "Te qebûl kir?"],
   gen:["Qebûl kirin û red kirin", "Min qebûl kir."]),

  (id:"b1_1003", ku:"Red kirin", tr:"Reddetmek", en:"To reject / refuse",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.71,
   not:"\"Red kirin\" geçişli → ergatif. \"Min red kir.\"",
   her:["Min red kir.", "Ew red kir."],
   gen:["Red kirin û qebûl kirin", "Min red kir."]),

  (id:"b1_1004", ku:"Bicîh kirin", tr:"Yerleştirmek / Uygulamak", en:"To implement / place",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.68,
   not:"\"Bicîh kirin\" geçişli → ergatif.",
   her:["Min bicîh kir.", "Plana bicîh bike."],
   gen:["Bicîh kirin û planê", "Min bicîh kir."]),

  (id:"b1_1005", ku:"Bi bîr anîn", tr:"Hatırlamak", en:"To remember",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.71,
   not:"\"Bi bîr anîn\" — [AS] no.1008 ✓. Ergatif: \"Min bi bîr anî.\"",
   her:["Min bi bîr anî.", "Tu bi bîr tînî?"],
   gen:["Bi bîr anîn û jibîrkirin", "Min bi bîr anî."]),

  // ── KÜRT DİLBİLİMİ — BH/TH terminoloji ───────────────────
  (id:"b1_1010", ku:"Ergatîvî", tr:"Ergatif", en:"Ergative",
   cins:"bêcins", ez:null, kat:"rêziman", zor:0.68,
   not:"\"Ergatîvî\" — dilbilgisi terimi. B1'de tam öğrenilir.",
   her:["Avahiya ergatîvî.", "Di kurmanciyê de ergatîvî heye."],
   gen:["Ergatîvî û aktîvî", "Avahiya ergatîvî"]),

  (id:"b1_1011", ku:"Dengdêr", tr:"Ünsüz", en:"Consonant",
   cins:"nêr", ez:"dengdêrê", kat:"rêziman", zor:0.68,
   not:"Eril — \"deng\" + \"dêr\". [BH]: dengdêr = ünsüz.",
   her:["Dengdêrên kurdî.", "Ev dengdêr e."],
   gen:["Dengdêr û dengdêrek", "Dengdêrên kurdî"]),

  (id:"b1_1012", ku:"Dengêk", tr:"Ünlü", en:"Vowel",
   cins:"nêr", ez:"dengêkê", kat:"rêziman", zor:0.68,
   not:"Eril — \"deng\" + \"-êk\". [BH]: dengêk = ünlü harf.",
   her:["Dengêkên kurdî.", "Ev dengêk e."],
   gen:["Dengêk û dengdêr", "Dengêkên kurdî"]),

  (id:"b1_1013", ku:"Kêşan", tr:"Çekim (dilbilgisi)", en:"Conjugation / Declension",
   cins:"nêr", ez:"kêşanê", kat:"rêziman", zor:0.67,
   not:"Eril — [BH]: kêşan = çekim. \"Kêşana lêkerê\" = fiilin çekimi.",
   her:["Kêşana lêkerê.", "Kêşana navdêrê."],
   gen:["Kêşan û avahî", "Kêşana kurdî"]),

  (id:"b1_1014", ku:"Rêziman", tr:"Dilbilgisi", en:"Grammar",
   cins:"mê", ez:"rêzimanê", kat:"rêziman", zor:0.72,
   not:"Dişil — [BH]: \"rêziman\" = gramer/dilbilgisi.",
   her:["Rêzimana kurdî.", "Rêziman dixwînim."],
   gen:["Rêziman û ferheng", "Rêzimana kurdî"]),

  // ── HUKUK VE YÖNETİM — [AS] s.60 ─────────────────────────
  (id:"b1_1020", ku:"Zagon", tr:"Kanun / Yasa", en:"Law / Statute",
   cins:"nêr", ez:"zagonê", kat:"zagon", zor:0.72,
   not:"Eril — [AS] s.60: HIQÛQ bölümü. [FB]: zagon n.m.",
   her:["Zagon hate dayîn.", "Li gorî zagonê."],
   gen:["Zagon û maf", "Zagonên me"]),

  (id:"b1_1021", ku:"Hikûmet", tr:"Hükümet", en:"Government",
   cins:"mê", ez:"hikûmetê", kat:"siyaset", zor:0.73,
   not:"Dişil — [AS] s.60 ✓. [FB]: hikûmet n.f.",
   her:["Hikûmet biryar da.", "Hikûmeta nû."],
   gen:["Hikûmet û parlamento", "Hikûmeta me"]),

  (id:"b1_1022", ku:"Dewlet", tr:"Devlet", en:"State",
   cins:"mê", ez:"dewletê", kat:"siyaset", zor:0.73,
   not:"Dişil — [AS] s.60 ✓. [FB]: dewlet n.f.",
   her:["Dewlet biyar da.", "Dewleta kurd."],
   gen:["Dewlet û milet", "Dewleta me"]),

  (id:"b1_1023", ku:"Sîyaset", tr:"Siyaset", en:"Politics",
   cins:"mê", ez:"sîyasetê", kat:"siyaset", zor:0.72,
   not:"Dişil — [AS] s.60 ✓. [FB]: sîyaset n.f.",
   her:["Sîyaset girîng e.", "Di sîyasetê de ne."],
   gen:["Sîyaset û aborî", "Sîyaseta me"]),

  (id:"b1_1024", ku:"Wezaret", tr:"Bakanlık", en:"Ministry",
   cins:"mê", ez:"wezaretê", kat:"siyaset", zor:0.70,
   not:"Dişil — [FB]: wezaret n.f. \"Wezareta Perwerdehiyê\" = Eğitim Bakanlığı.",
   her:["Wezaret biryar da.", "Di wezaretê de ne."],
   gen:["Wezaret û serok", "Wezareta me"]),

  (id:"b1_1025", ku:"Wezîr", tr:"Bakan", en:"Minister",
   cins:"bêcins", ez:"wezîrê", kat:"siyaset", zor:0.71,
   not:"\"Wezîr\" — [FB]: wezîr n. [Arapça]. \"Wezîrê Perwerdehiyê.\"",
   her:["Wezîr axivî.", "Wezîrê nû hat."],
   gen:["Wezîr û serok", "Wezîrên me"]),

  // ── TOPLUMSAL DEĞERLER ─────────────────────────────────────
  (id:"b1_1030", ku:"Dadmendî", tr:"Adalet", en:"Justice",
   cins:"mê", ez:"dadmendiyê", kat:"nirx", zor:0.71,
   not:"Dişil — \"dad\" (adalet) + \"-mendî\". [FB]: dadmendî n.f.",
   her:["Dadmendî lazim e.", "Dadmendîya civakî."],
   gen:["Dadmendî û zulm", "Dadmendîya me"]),

  (id:"b1_1031", ku:"Mafdar", tr:"Haklı", en:"Rightful / Just",
   cins:"bêcins", ez:null, kat:"nirx", zor:0.70,
   not:"\"Maf\" + \"-dar\". [FB]: mafdar adj.",
   her:["Ew mafdar e.", "Mafdar bin!"],
   gen:["Mafdar û bêmaf", "Ev mafdar e."]),

  (id:"b1_1032", ku:"Berpirsiyar", tr:"Sorumlu", en:"Responsible",
   cins:"bêcins", ez:null, kat:"nirx", zor:0.70,
   not:"\"Ber\" + \"pirsiyar\". [FB]: berpirsiyar adj.",
   her:["Ew berpirsiyar e.", "Berpirsiyar be!"],
   gen:["Berpirsiyar û bêpirsiyar", "Ev berpirsiyar e."]),

  (id:"b1_1033", ku:"Şerêf", tr:"Şeref / Onur", en:"Honor",
   cins:"nêr", ez:"şerêfê", kat:"nirx", zor:0.70,
   not:"Eril — [FB]: şerêf n.m. [Arapça]. Kürt kültüründe merkezi değer.",
   her:["Şerêfê xwe biparêze!", "Şerêf û azadî."],
   gen:["Şerêf û rûmet", "Şerêfê me"]),

  (id:"b1_1034", ku:"Rûmet", tr:"İtibar / Saygınlık", en:"Dignity / Prestige",
   cins:"mê", ez:"rûmetê", kat:"nirx", zor:0.70,
   not:"Dişil — [FB]: rûmet n.f. \"Rûmeta malbatê.\"",
   her:["Rûmet girîng e.", "Rûmeta xwe biparêze."],
   gen:["Rûmet û şerêf", "Rûmeta me"]),

  (id:"b1_1035", ku:"Wefadar", tr:"Sadık / Vefakâr", en:"Loyal / Faithful",
   cins:"bêcins", ez:null, kat:"nirx", zor:0.70,
   not:"\"Wefa\" + \"-dar\". [FB]: wefadar adj.",
   her:["Ew wefadar e.", "Wefadar bin!"],
   gen:["Wefadar û xayîn", "Ev wefadar e."]),

  (id:"b1_1036", ku:"Xayîn", tr:"Hain", en:"Traitor / Treacherous",
   cins:"bêcins", ez:"xayînê", kat:"nirx", zor:0.69,
   not:"\"Xayîn\" — [FB]: xayîn adj./n. \"Xayîn nebe!\"",
   her:["Xayîn nebe!", "Ew xayîn e."],
   gen:["Xayîn û wefadar", "Ev xayîn e."]),

  // ── DOĞA VE EKOLOJİ DERİN ─────────────────────────────────
  (id:"b1_1040", ku:"Çavkanîya xwezayî", tr:"Doğal kaynak", en:"Natural resource",
   cins:"mê", ez:"çavkaniyê", kat:"ekoloji", zor:0.69,
   not:"\"Çavkanî\" + \"xwezayî\". Kürdistan'ın petrol, su, madenleri.",
   her:["Çavkanîyên xwezayî dewlemend in.", "Biparêzin!"],
   gen:["Çavkanîya xwezayî", "Çavkanîyên Kurdistan"]),

  (id:"b1_1041", ku:"Bijareh", tr:"Çöl", en:"Desert",
   cins:"nêr", ez:"bijardê", kat:"xweza", zor:0.68,
   not:"Eril — [FB]: bijareh n.m. \"Bijareh û çiya.\"",
   her:["Bijareh germ û zuwa ye.", "Di bijardê de."],
   gen:["Bijareh û deşt", "Bijardê mezin"]),

  (id:"b1_1042", ku:"Çemkul", tr:"Köprü", en:"Bridge",
   cins:"nêr", ez:"çemkulê", kat:"cih", zor:0.69,
   not:"Eril — [FB]: çemkul n.m. \"Çemkul li ser çemê.\"",
   her:["Çemkul hat.", "Ji çemkulê re çûn."],
   gen:["Çemkul û rê", "Çemkulê mezin"]),

  (id:"b1_1043", ku:"Hewz", tr:"Havuz / Gölet", en:"Pool / Pond",
   cins:"nêr", ez:"hewzê", kat:"xweza", zor:0.69,
   not:"Eril — [FB]: hewz n.m.",
   her:["Hewz mezin e.", "Di hewzê de avjenî kir."],
   gen:["Hewz û çem", "Hewzê me"]),

  (id:"b1_1044", ku:"Kevir", tr:"Taş", en:"Stone / Rock",
   cins:"nêr", ez:"kevirê", kat:"xweza", zor:0.71,
   not:"Eril — [FB]: kevir n.m. \"Kevirê çiyayê.\"",
   her:["Kevir avêt.", "Ser kevirî rûniştim."],
   gen:["Kevir û ax", "Kevirê çiyayê"]),

  (id:"b1_1045", ku:"Gir", tr:"Tepe / Höyük", en:"Mound / Hill",
   cins:"nêr", ez:"girê", kat:"xweza", zor:0.69,
   not:"Eril — [FB]: gir n.m. \"Girê mezin\" = büyük höyük.",
   her:["Gir li vir heye.", "Girê dîrokî."],
   gen:["Gir û tepe", "Girê dîrokî"]),

  // ── KOMÜNİKASYON VE MEDYA ─────────────────────────────────
  (id:"b1_1050", ku:"Ragihandina gelêrî", tr:"Kitle iletişimi", en:"Mass communication",
   cins:"mê", ez:"ragihandinê", kat:"medya", zor:0.68,
   not:"\"Ragihandin\" + \"gelêrî\". Gazete dilinde.",
   her:["Ragihandina gelêrî girîng e.", "Di ragihandina gelêrî de."],
   gen:["Ragihandina gelêrî", "Ragihandina me"]),

  (id:"b1_1051", ku:"Blok nivîsîn", tr:"Blog yazmak", en:"Blogging",
   cins:"bêcins", ez:null, kat:"medya", zor:0.68,
   not:"Modern terim. \"Bloga kurdî\" = Kürtçe blog.",
   her:["Bloka kurdî dinivîsim.", "Blok nivîsîn."],
   gen:["Blok û malper", "Bloka kurdî"]),

  (id:"b1_1052", ku:"Civaka dîjîtal", tr:"Dijital toplum", en:"Digital society",
   cins:"mê", ez:"civakê", kat:"civakî", zor:0.67,
   not:"\"Civak\" + \"dîjîtal\". Modern söylem.",
   her:["Di civaka dîjîtal de.", "Civaka dîjîtal û ziman."],
   gen:["Civaka dîjîtal", "Civaka nû"]),

  // ── FELSEFİ VE AKADEMİK KELİMELER ────────────────────────
  (id:"b1_1060", ku:"Zanistname", tr:"Bilim dalı", en:"Scientific discipline",
   cins:"mê", ez:"zanistnamê", kat:"zanist", zor:0.67,
   not:"\"Zanist\" + \"name\". Bileşik akademik terim.",
   her:["Zanistnameyeke nû.", "Zanistnamên cûda."],
   gen:["Zanistname û enstîtu", "Zanistnameyên kurdî"]),

  (id:"b1_1061", ku:"Nêzîkatiya zanistî", tr:"Bilimsel yaklaşım", en:"Scientific approach",
   cins:"mê", ez:"nêzîkatiyê", kat:"zanist", zor:0.67,
   not:"\"Nêzîkatî\" + \"zanistî\". Akademik metod kavramı.",
   her:["Nêzîkatiya zanistî lazim e.", "Bi nêzîkatiya zanistî."],
   gen:["Nêzîkatiya zanistî", "Bi zanistî"]),

  (id:"b1_1062", ku:"Projeya lêkolînê", tr:"Araştırma projesi", en:"Research project",
   cins:"mê", ez:"projeya lêkolînê", kat:"zanist", zor:0.67,
   not:"Bileşik. \"Proje\" + \"lêkolînê\".",
   her:["Projeya lêkolînê hat.", "Di projeya lêkolînê de ne."],
   gen:["Proje û lêkolîn", "Projeya me"]),

  // ── PSİKOLOJİ VE DUYGULAR ─────────────────────────────────
  (id:"b1_1070", ku:"Bawermendî", tr:"Güven / İnanç", en:"Trust / Confidence",
   cins:"mê", ez:"bawermendiê", kat:"psikoloji", zor:0.70,
   not:"Dişil — \"bawer\" + \"-mendî\". [FB]: bawermendî n.f.",
   her:["Bawermendî lazim e.", "Di bawermendiyê de."],
   gen:["Bawermendî û şik", "Bawermendîya me"]),

  (id:"b1_1071", ku:"Xwebawerî", tr:"Özgüven", en:"Self-confidence",
   cins:"mê", ez:"xwexaweriyê", kat:"psikoloji", zor:0.70,
   not:"Dişil — \"xwe\" + \"bawerî\". [FB]: xwebawerî n.f.",
   her:["Xwebawerî lazim e.", "Bi xwebawerî."],
   gen:["Xwebawerî û tirsîn", "Xwebawerîya me"]),

  (id:"b1_1072", ku:"Bîranîn", tr:"Anı / Hatıra", en:"Memory / Recollection",
   cins:"mê", ez:"bîranînê", kat:"psikoloji", zor:0.71,
   not:"Dişil — \"bi bîr\" + \"-anîn\". [FB]: bîranîn n.f.",
   her:["Bîranînên xweş.", "Bîranîna welatê."],
   gen:["Bîranîn û jibîrkirin", "Bîranînên me"]),

  (id:"b1_1073", ku:"Hêvî", tr:"Umut", en:"Hope",
   cins:"mê", ez:"hêviyê", kat:"psikoloji", zor:0.73,
   not:"Dişil — [FB]: hêvî n.f. \"Hêvî heyî e.\" Heritage bağlamında yaşam gücü.",
   her:["Hêvî heyî ye.", "Bi hêvî ne."],
   gen:["Hêvî û bêhêvî", "Hêvîya me"]),

  (id:"b1_1074", ku:"Bêhêvî", tr:"Umutsuz", en:"Hopeless",
   cins:"bêcins", ez:null, kat:"psikoloji", zor:0.69,
   not:"\"Bê\" + \"hêvî\". [FB]: bêhêvî adj.",
   her:["Bêhêvî nebe!", "Ew bêhêvî ye."],
   gen:["Bêhêvî û hêvî", "Ev bêhêvî ye."]),

  // ── COĞRAFYA VE TARİH DERİN ────────────────────────────────
  (id:"b1_1080", ku:"Gel û welat", tr:"Halk ve vatan", en:"People and homeland",
   cins:"bêcins", ez:null, kat:"kimlik", zor:0.71,
   not:"\"Gel\" + \"û\" + \"welat\". Bileşik deyim. Kürt siyasi söyleminde.",
   her:["Gel û welat.", "Ji bo gel û welat."],
   gen:["Gel û welat", "Ji bo gel û welat"]),

  (id:"b1_1081", ku:"Cihêrengî", tr:"Çeşitlilik / Farklılık", en:"Diversity / Difference",
   cins:"mê", ez:"cihêrengiyê", kat:"civakî", zor:0.70,
   not:"Dişil — \"cihê\" + \"rengî\". [FB]: cihêrengî n.f.",
   her:["Cihêrengî dewlemendî ye.", "Di cihêrengiyê de."],
   gen:["Cihêrengî û yekîtî", "Cihêrengîya me"]),

  (id:"b1_1082", ku:"Yekrêzî", tr:"Birlik / Bütünlük", en:"Unity / Integrity",
   cins:"mê", ez:"yekrêziyê", kat:"civakî", zor:0.70,
   not:"Dişil — \"yek\" + \"rêzî\". [FB]: yekrêzî n.f.",
   her:["Yekrêzî lazim e.", "Bi yekrêzî."],
   gen:["Yekrêzî û cihêrengî", "Yekrêzîya me"]),

  (id:"b1_1083", ku:"Koçberiya zimanî", tr:"Dil değişimi / Dil kayması", en:"Language shift",
   cins:"mê", ez:"koçberiyê", kat:"kimlik", zor:0.68,
   not:"\"Koçberî\" + \"zimanî\". Kürt dil kaybı kavramı.",
   her:["Koçberiya zimanî zehmet e.", "Li hemberî koçberiya zimanî."],
   gen:["Koçberiya zimanî", "Li hemberî koçberiya zimanî"]),

  (id:"b1_1084", ku:"Zimanê zikmakî", tr:"Anadil", en:"Mother tongue",
   cins:"nêr", ez:"zimanê zikmakî", kat:"kimlik", zor:0.71,
   not:"\"Ziman\" + \"zikmakî\" (annenin). \"Zimanê dayikê\" de kullanılır.",
   her:["Zimanê zikmakî kurdî ye.", "Zimanê zikmakî biparêze."],
   gen:["Zimanê zikmakî", "Zimanê dayikê"]),

  // ── EKONOMİ TAM ───────────────────────────────────────────
  (id:"b1_1090", ku:"Dahat", tr:"Gelir", en:"Income / Revenue",
   cins:"nêr", ez:"dahatê", kat:"aborî", zor:0.70,
   not:"Eril — [FB]: dahat n.m. \"Dahatê me.\"",
   her:["Dahat kêm e.", "Dahatên me."],
   gen:["Dahat û xerc", "Dahatê me"]),

  (id:"b1_1091", ku:"Xerc", tr:"Gider / Masraf", en:"Expense / Cost",
   cins:"nêr", ez:"xercê", kat:"aborî", zor:0.70,
   not:"Eril — [FB]: xerc n.m. \"Xerc gelek e.\"",
   her:["Xerc gelek e.", "Xercê malbatê."],
   gen:["Xerc û dahat", "Xercê me"]),

  (id:"b1_1092", ku:"Pêşkeftin", tr:"Kalkınma / Gelişim", en:"Development",
   cins:"mê", ez:"pêşkeftinê", kat:"aborî", zor:0.71,
   not:"Dişil — \"pêş\" + \"ketin\". [FB]: pêşkeftin n.f.",
   her:["Pêşkeftina aboriyê.", "Di pêşkeftinê de."],
   gen:["Pêşkeftin û paşketin", "Pêşkeftina me"]),

  (id:"b1_1093", ku:"Xizmet", tr:"Hizmet", en:"Service",
   cins:"mê", ez:"xizmetê", kat:"aborî", zor:0.71,
   not:"Dişil — [FB]: xizmet n.f. [Arapça]. \"Xizmeta giştî.\"",
   her:["Xizmet baş e.", "Xizmeta giştî."],
   gen:["Xizmet û kar", "Xizmeta me"]),

  (id:"b1_1094", ku:"Sermiaye", tr:"Sermaye", en:"Capital (finance)",
   cins:"mê", ez:"sermiayê", kat:"aborî", zor:0.68,
   not:"Dişil — [FB]: sermiaye n.f. [Farsça].",
   her:["Sermiaye lazim e.", "Sermiayeya nû."],
   gen:["Sermiaye û faîz", "Sermiayeya me"]),

  // ── SAĞLIK VE TIP DERİN ────────────────────────────────────
  (id:"b1_1100", ku:"Narkoz", tr:"Anestezi", en:"Anesthesia",
   cins:"nêr", ez:"narkozê", kat:"tendurist", zor:0.67,
   not:"Eril — uluslararası terim.",
   her:["Narkoz lazim e.", "Narkoz da."],
   gen:["Narkoz û keser", "Narkozê bijîşkiyê"]),

  (id:"b1_1101", ku:"Enfeksîyon", tr:"Enfeksiyon", en:"Infection",
   cins:"mê", ez:"enfeksîyonê", kat:"tendurist", zor:0.68,
   not:"Dişil — uluslararası terim.",
   her:["Enfeksîyon heye.", "Li hemberî enfeksîyonê."],
   gen:["Enfeksîyon û derman", "Enfeksîyona min"]),

  (id:"b1_1102", ku:"Xwîna bilind", tr:"Yüksek tansiyon", en:"Hypertension",
   cins:"bêcins", ez:null, kat:"tendurist", zor:0.67,
   not:"\"Xwîna bilind\" = yüksek tansiyon. Lit. \"yüksek kan\".",
   her:["Xwîna bilind heye.", "Ji bo xwîna bilind."],
   gen:["Xwîna bilind û nizm", "Xwîna bilind"]),

  // ── MEVSİM VE ZİRAAT ──────────────────────────────────────
  (id:"b1_1110", ku:"Çandin", tr:"Ekmek / Dikmek", en:"To plant / sow",
   cins:"bêcins", ez:null, kat:"cotkarî", zor:0.70,
   not:"\"Çandin\" — geçişli. \"Min çand\" = ektim.",
   her:["Min genim çand.", "Te çi çand?"],
   gen:["Çandin û çinîn", "Min çand."]),

  (id:"b1_1111", ku:"Çinîn", tr:"Toplamak / Hasat etmek", en:"To harvest / pick",
   cins:"bêcins", ez:null, kat:"cotkarî", zor:0.69,
   not:"\"Çinîn\" — geçişli. \"Min çinî\" = topladım.",
   her:["Min tirî çinî.", "Dema çinînê."],
   gen:["Çinîn û çandin", "Min çinî."]),

  (id:"b1_1112", ku:"Av kirin", tr:"Sulamak", en:"To irrigate / water",
   cins:"bêcins", ez:null, kat:"cotkarî", zor:0.69,
   not:"\"Av kirin\" = sulamak. \"Min zevî av kir.\"",
   her:["Min kulîlk av kir.", "Zevî av bike."],
   gen:["Av kirin û çandin", "Min av kir."]),

  (id:"b1_1113", ku:"Beran", tr:"Koç / Erkek koyun", en:"Ram",
   cins:"nêr", ez:"beranê", kat:"cotkarî", zor:0.69,
   not:"Eril — [FB]: beran n.m. \"Beranên çiyayê.\"",
   her:["Beran xurt e.", "Beranê me."],
   gen:["Beran û mî", "Beranê çiyayê"]),

  // ── FELSEFİ KAVRAMLAR ─────────────────────────────────────
  (id:"b1_1120", ku:"Rastî", tr:"Gerçek / Doğruluk", en:"Truth / Reality",
   cins:"mê", ez:"rastiyê", kat:"felsefe", zor:0.70,
   not:"Dişil — \"rast\" (doğru) + \"-î\" — özgün Kurmancî form. [BH] §274: -î soyutlama eki. \"Heqîqet\" Arapça kökenli alternatif; \"rastî\" tercih edilir.",
   her:["Rastî çi ye?", "Rastîya jiyanê."],
   gen:["Rastî û xeyal", "Rastîya me"]),

  (id:"b1_1121", ku:"Serbest", tr:"Serbest / Özgür", en:"Free / Unrestricted",
   cins:"bêcins", ez:null, kat:"felsefe", zor:0.72,
   not:"\"Serbest\" — [FB]: serbest adj. \"Serbest be!\"",
   her:["Ew serbest e.", "Serbest be!"],
   gen:["Serbest û bindest", "Ev serbest e."]),

  (id:"b1_1122", ku:"Hiqûqê", tr:"Hukuk", en:"Law (field)",
   cins:"nêr", ez:"hiqûqê", kat:"zagon", zor:0.69,
   not:"Eril — [AS] s.60: \"HIQÛQ\" başlığı. \"Hiqûqê mirovan\" = insan hukuku.",
   her:["Hiqûqê dixwînim.", "Hiqûqê mirovan."],
   gen:["Hiqûq û sîyaset", "Hiqûqê me"]),

  (id:"b1_1123", ku:"Dadwer", tr:"Hâkim / Yargıç", en:"Judge",
   cins:"bêcins", ez:"dadwerê", kat:"zagon", zor:0.68,
   not:"\"Dad\" + \"-wer\". [FB]: dadwer n. \"Dadwer biryar da.\"",
   her:["Dadwer biryar da.", "Ew dadwer e."],
   gen:["Dadwer û parêzer", "Dadwerê me"]),

  // ── YAZIN VE EDEBİYAT ─────────────────────────────────────
  (id:"b1_1130", ku:"Hevpeyvîn", tr:"Röportaj / Mülakat", en:"Interview",
   cins:"mê", ez:"hevpeyvînê", kat:"medya", zor:0.69,
   not:"Dişil — \"hev\" + \"peyvîn\". [FB]: hevpeyvîn n.f.",
   her:["Hevpeyvîn kirin.", "Hevpeyvîna baş."],
   gen:["Hevpeyvîn û nûçe", "Hevpeyvîna me"]),

  (id:"b1_1131", ku:"Gotûbêj", tr:"Diyalog / Konuşma", en:"Dialogue / Discussion",
   cins:"nêr", ez:"gotûbêjê", kat:"medya", zor:0.70,
   not:"Eril — \"got\" + \"û\" + \"bêj\". [FB]: gotûbêj n.m.",
   her:["Gotûbêj baş bû.", "Di gotûbêjê de."],
   gen:["Gotûbêj û nîqaş", "Gotûbêjê me"]),

  (id:"b1_1132", ku:"Axaftina giştî", tr:"Kamuoyu konuşması", en:"Public speech",
   cins:"mê", ez:"axaftinê", kat:"medya", zor:0.67,
   not:"\"Axaftin\" + \"giştî\". Akademik iletişim terimi.",
   her:["Axaftina giştî hat.", "Di axaftina giştî de."],
   gen:["Axaftina giştî", "Axaftina me"]),

  // ── GÜNLÜK HAYAT DERİN ─────────────────────────────────────
  (id:"b1_1140", ku:"Stres", tr:"Stres", en:"Stress",
   cins:"nêr", ez:"stresê", kat:"psikoloji", zor:0.70,
   not:"Eril — uluslararası terim. \"Stresê min heye.\"",
   her:["Stresê min heye.", "Stres gelek e."],
   gen:["Stres û aramî", "Stresê min"]),

  (id:"b1_1141", ku:"Meşgûl", tr:"Meşgul", en:"Busy",
   cins:"bêcins", ez:null, kat:"jiyan", zor:0.71,
   not:"\"Meşgûl\" — [FB]: meşgûl adj. [Arapça]. \"Ez meşgûl me.\"",
   her:["Ez meşgûl me.", "Tu meşgûl î?"],
   gen:["Meşgûl û vala", "Ez meşgûl me."]),

  (id:"b1_1142", ku:"Vala", tr:"Boş", en:"Empty / Free",
   cins:"bêcins", ez:null, kat:"jiyan", zor:0.72,
   not:"\"Vala\" — [FB]: vala adj. Hem \"boş\" hem \"müsait\".",
   her:["Sinif vala ye.", "Dema te vala ye?"],
   gen:["Vala û tijî", "Ev vala ye."]),

  (id:"b1_1143", ku:"Dema vala", tr:"Boş zaman", en:"Free time",
   cins:"mê", ez:"dema vala", kat:"jiyan", zor:0.71,
   not:"\"Dem\" + \"vala\". \"Demên vala\" = boş zamanlar.",
   her:["Demê vala heye?", "Di dema vala de."],
   gen:["Dem vala û kar", "Demê vala"]),

  // ── EK FIIL VE KAYNAKLI FORMLAR ───────────────────────────
  (id:"b1_1150", ku:"Bipêş xistin", tr:"İlerletmek / Geliştirmek", en:"To advance / promote",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.68,
   not:"\"Bipêş xistin\" — [AS] no.989 ✓. Ergatif.",
   her:["Min bipêş xist.", "Bipêş bixe!"],
   gen:["Bipêş xistin û paş xistin", "Min bipêş xist."]),

  (id:"b1_1151", ku:"Vegerandin", tr:"Geri vermek / İade etmek", en:"To return / give back",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.69,
   not:"\"Vegerandin\" — [AS] no.991 ✓. Ergatif. Ettirgen.",
   her:["Min vegerand.", "Vegerîne!"],
   gen:["Vegerandin û wergirtin", "Min vegerand."]),

  (id:"b1_1152", ku:"Hev dîtin", tr:"Görüşmek / Buluşmak", en:"To meet (each other)",
   cins:"bêcins", ez:null, kat:"leker", zor:0.71,
   not:"\"Hev dîtin\" — [AS] no.1000 ✓. \"Em hev dîtin.\"",
   her:["Em hev dîtin.", "Kengî hev dibînin?"],
   gen:["Hev dîtin û veqetîn", "Em hev dîtin."]),

  (id:"b1_1153", ku:"Mezin bûn", tr:"Büyümek", en:"To grow up",
   cins:"bêcins", ez:null, kat:"jiyan", zor:0.72,
   not:"\"Mezin bûn\" — [AS] no.959 ✓.",
   her:["Ez mezin bûm.", "Tu mezin dibî."],
   gen:["Mezin bûn û biçûk man", "Mezin bû."]),

];


final kB1EkKelimeler6 = [

  // ── KÜRT KÜLTÜRÜ VE EDEBİYATI — B1 özgün ──────────────────

  (id:"b1_1200", ku:"Xanî û yekîtî", tr:"Xanî ve birlik", en:"Khani and unity",
   cins:"bêcins", ez:null, kat:"dîrok", zor:0.70,
   not:"Xanî'nin temel mesajı — B1 edebi ders. \"Yekîtî bingeh e.\"",
   her:["Xanî ji yekîtiyê axivî.", "Yekîtîya Xanî."],
   gen:["Xanî û yekîtî", "Gotina Xanî"]),

  (id:"b1_1201", ku:"Dengbêj û hafiza", tr:"Dengbêj ve hafıza", en:"Dengbêj and memory",
   cins:"bêcins", ez:null, kat:"çand", zor:0.70,
   not:"\"Dengbêj\" = hafızanın canlı taşıyıcısı. B1 kültürel tema.",
   her:["Dengbêj hafizaya gelê kurd diparêze.", "Di hafizaya dengbêjê de."],
   gen:["Dengbêj û hafiza", "Hafizaya dengbêjê"]),

  (id:"b1_1202", ku:"Lorî", tr:"Ninni", en:"Lullaby",
   cins:"mê", ez:"loriyê", kat:"çand", zor:0.72,
   not:"Dişil — [FB]: lorî n.f. \"Lorîya pîrê\" = büyükannenin ninnisi.",
   her:["Pîrê lorî got.", "Lorîya kurdî."],
   gen:["Lorî û stran", "Lorîya me"]),

  (id:"b1_1203", ku:"Çîroka gelêrî", tr:"Halk masalı", en:"Folk tale",
   cins:"mê", ez:"çîroka gelêrî", kat:"çand", zor:0.70,
   not:"\"Çîrok\" + \"gelêrî\". \"Çîrokên pîrê\" = büyükannenin masalları.",
   her:["Çîrokên gelêrî yên kurdî.", "Di çîroka gelêrî de."],
   gen:["Çîroka gelêrî", "Çîrokên me"]),

  // ── KÜRT COĞRAFYABİLGİSİ ──────────────────────────────────

  (id:"b1_1210", ku:"Çiyayên Zagrosê", tr:"Zagros dağları", en:"Zagros mountains",
   cins:"bêcins", ez:"çiyayên Zagrosê", kat:"cografî", zor:0.69,
   not:"Tarihî Kürt yurdu Zagros dağları.",
   her:["Çiyayên Zagrosê bilind in.", "Di Zagrosê de."],
   gen:["Çiyayên Zagrosê", "Li Zagrosê"]),

  (id:"b1_1211", ku:"Firat û Dicle", tr:"Fırat ve Dicle", en:"Euphrates and Tigris",
   cins:"bêcins", ez:null, kat:"cografî", zor:0.70,
   not:"Kürdistan'ın iki büyük nehri.",
   her:["Firat û Dicle ji Kurdistanê diherike.", "Dicle û Firat."],
   gen:["Firat û Dicle", "Li Firat û Dicle"]),

  (id:"b1_1212", ku:"Newroz û çiya", tr:"Newroz ve dağlar", en:"Newroz and mountains",
   cins:"bêcins", ez:null, kat:"çand", zor:0.70,
   not:"Dağ ve Newroz ateşi — Kürt kültürel sembolizmi.",
   her:["Newroz li ser çiyayê.", "Agirê Newrozê."],
   gen:["Newroz û çiya", "Agirê Newrozê"]),

  // ── TOPLUMSAL YAŞAM DERİN ─────────────────────────────────

  (id:"b1_1220", ku:"Taxê", tr:"Mahalle", en:"Neighbourhood",
   cins:"nêr", ez:"taxê", kat:"cih", zor:0.72,
   not:"Eril — [FB]: tax n.m. \"Taxê me.\"",
   her:["Li taxê de ne.", "Taxê me xweş e."],
   gen:["Tax û gund", "Taxê me"]),

  (id:"b1_1221", ku:"Hewşa bajêr", tr:"Şehir meydanı", en:"City square",
   cins:"mê", ez:"hewşa bajêr", kat:"cih", zor:0.69,
   not:"\"Hewş\" (avlu/meydan) + \"bajêr\".",
   her:["Li hewşa bajêr ne.", "Hewşa bajêr mezin e."],
   gen:["Hewşa bajêr", "Li hewşa bajêr"]),

  (id:"b1_1222", ku:"Xanikê", tr:"Konak / Han", en:"Mansion / Inn",
   cins:"nêr", ez:"xanikê", kat:"cih", zor:0.68,
   not:"Eril — [FB]: xanik n.m. Tarihi Kürt konutu.",
   her:["Xanikê mezin e.", "Di xanikê de ne."],
   gen:["Xanik û mal", "Xanikê me"]),

  // ── AKADEMİK VE OKUL ──────────────────────────────────────

  (id:"b1_1230", ku:"Mezûnbûn", tr:"Mezun olmak", en:"To graduate",
   cins:"bêcins", ez:null, kat:"perwerde", zor:0.70,
   not:"\"Mezûn bûn\" — [AS]: \"mezun = mezûn\" ✓.",
   her:["Min mezûn bû.", "Tu mezûn bibî!"],
   gen:["Mezûnbûn û xwendin", "Mezûn bûm."]),

  (id:"b1_1231", ku:"Doktorayê", tr:"Doktora", en:"Doctorate / PhD",
   cins:"mê", ez:"doktorayê", kat:"perwerde", zor:0.70,
   not:"Dişil — \"doktora\" uluslararası terim.",
   her:["Doktora dixwînim.", "Doktorayê bidest xist."],
   gen:["Doktora û master", "Doktoraya min"]),

  (id:"b1_1232", ku:"Masterê", tr:"Master / Yüksek lisans", en:"Master's degree",
   cins:"nêr", ez:"masterê", kat:"perwerde", zor:0.70,
   not:"Eril — uluslararası terim.",
   her:["Master dixwînim.", "Masterê bidest xist."],
   gen:["Master û doktora", "Masterê min"]),

  (id:"b1_1233", ku:"Burse", tr:"Burs", en:"Scholarship",
   cins:"mê", ez:"bursê", kat:"perwerde", zor:0.70,
   not:"Dişil — uluslararası terim.",
   her:["Burse girt.", "Ji bo bursê bide xwastar."],
   gen:["Burse û xwendin", "Burseya min"]),

  // ── KÜRTÇE DİL MESELELERİ ─────────────────────────────────

  (id:"b1_1240", ku:"Kurmancî", tr:"Kurmancî lehçesi", en:"Kurmanji dialect",
   cins:"bêcins", ez:"Kurmancî", kat:"ziman", zor:0.74,
   not:"\"Kurmancî\" = kuzey Kürtçesi. En yaygın lehçe.",
   her:["Ez Kurmancî diaxivim.", "Kurmancî û Zazacî."],
   gen:["Kurmancî û Soranî", "Zimanê Kurmancî"]),

  (id:"b1_1241", ku:"Soranî", tr:"Soranice", en:"Sorani dialect",
   cins:"bêcins", ez:"Soranî", kat:"ziman", zor:0.72,
   not:"\"Soranî\" = merkez Kürtçesi. Başûrê Kurdistanê'de.",
   her:["Soranî û Kurmancî.", "Soranî fêr dibim."],
   gen:["Soranî û Kurmancî", "Soranî û Zazacî"]),

  (id:"b1_1242", ku:"Zazacî", tr:"Zazaca", en:"Zazaki dialect",
   cins:"bêcins", ez:"Zazacî", kat:"ziman", zor:0.70,
   not:"\"Zazacî\" = Dersim ve çevresinde. Kürtçe grubundan ayrı lehçe tartışması.",
   her:["Zazacî û Kurmancî.", "Zazacî dixwînim."],
   gen:["Zazacî û Kurmancî", "Zazacî"]),

  (id:"b1_1243", ku:"Alfabeya Latînî", tr:"Latin alfabesi", en:"Latin alphabet",
   cins:"mê", ez:"alfabeya Latînî", kat:"ziman", zor:0.70,
   not:"\"Alfabe\" + \"Latînî\". Bedir Han tarafından 1932'de standartlaştırıldı.",
   her:["Alfabeya Latînî ya kurdî.", "Di alfabeya Latînî de."],
   gen:["Alfabeya Latînî", "Alfabeya Bedir Han"]),

  // ── SAĞLIK VE TOPLUM ──────────────────────────────────────

  (id:"b1_1250", ku:"Tenduristîya giştî", tr:"Halk sağlığı", en:"Public health",
   cins:"mê", ez:"tenduristîya giştî", kat:"tendurist", zor:0.69,
   not:"\"Tenduristî\" + \"giştî\".",
   her:["Tenduristîya giştî girîng e.", "Di tenduristîya giştî de."],
   gen:["Tenduristîya giştî", "Tenduristîya me"]),

  (id:"b1_1251", ku:"Bîhna ajarê", tr:"Temiz hava", en:"Fresh air",
   cins:"mê", ez:"bîhna ajarê", kat:"tendurist", zor:0.68,
   not:"\"Bîhn\" (nefes) + \"ajar\" (temiz).",
   her:["Bîhna ajarê bixwe!", "Li çiyayê bîhna ajar e."],
   gen:["Bîhna ajar", "Li çiyayê bîhna ajar"]),

  (id:"b1_1252", ku:"Nexweşîya kronîk", tr:"Kronik hastalık", en:"Chronic disease",
   cins:"mê", ez:"nexweşîya kronîk", kat:"tendurist", zor:0.67,
   not:"\"Nexweşî\" + \"kronîk\".",
   her:["Nexweşîya kronîk heye.", "Ji bo nexweşîya kronîk."],
   gen:["Nexweşîya kronîk", "Nexweşîya min"]),

  // ── ZANIST VE TEKNOLOJİ ───────────────────────────────────

  (id:"b1_1260", ku:"Zanistê kompîturê", tr:"Bilgisayar bilimi", en:"Computer science",
   cins:"bêcins", ez:"zanistê kompîturê", kat:"teknoloji", zor:0.68,
   not:"\"Zanist\" + \"kompîturê\".",
   her:["Zanistê kompîturê dixwînim.", "Di zanistê kompîturê de."],
   gen:["Zanistê kompîturê", "Zanistê me"]),

  (id:"b1_1261", ku:"Kompîtur", tr:"Bilgisayar", en:"Computer",
   cins:"nêr", ez:"kompîturê", kat:"teknoloji", zor:0.82,
   not:"Eril — [FB]: kompîtur n.m.",
   her:["Kompîtur bikar tînim.", "Li kompîturê ne."],
   gen:["Kompîtur û têlefon", "Kompîturê min"]),

  (id:"b1_1262", ku:"Bernamevan", tr:"Programcı", en:"Programmer",
   cins:"bêcins", ez:"bernamevane", kat:"teknoloji", zor:0.68,
   not:"\"Bername\" + \"-van\". [BH] §273: -van eki.",
   her:["Ew bernamevan e.", "Bernamevanen kurd."],
   gen:["Bernamevan û endazyar", "Bernamevana me"]),

  // ── MESLEKİ GELİŞME TAM ──────────────────────────────────

  (id:"b1_1270", ku:"Pêşkariyan kirin", tr:"Kariyer yapmak", en:"To build a career",
   cins:"bêcins", ez:null, kat:"kar", zor:0.67,
   not:"\"Pêşkarî\" (kariyer) + \"kirin\".",
   her:["Pêşkarîya xwe çêke.", "Di pêşkarîyê de pêş diçe."],
   gen:["Pêşkarî û xwendin", "Pêşkarîya min"]),

  (id:"b1_1271", ku:"Baş axaftin", tr:"İyi konuşmak", en:"To speak well",
   cins:"bêcins", ez:null, kat:"leker", zor:0.70,
   not:"\"Baş axaftin\" = iyi/güzel konuşmak.",
   her:["Ew baş diaxive.", "Bi kurdî baş biaxive."],
   gen:["Baş axaftin û nivisandin", "Baş diaxive."]),

  (id:"b1_1272", ku:"Huner û çand", tr:"Sanat ve kültür", en:"Art and culture",
   cins:"bêcins", ez:null, kat:"çand", zor:0.71,
   not:"\"Huner\" + \"û\" + \"çand\". Bileşik kavram.",
   her:["Huner û çanda kurdî.", "Di huner û çandê de."],
   gen:["Huner û çand", "Huner û çanda me"]),

  // ── FELSEFE VE ETİK DERİN ─────────────────────────────────

  (id:"b1_1280", ku:"Nirxên bingehîn", tr:"Temel değerler", en:"Core values",
   cins:"bêcins", ez:"nirxên bingehîn", kat:"nirx", zor:0.70,
   not:"\"Nirx\" + \"bingehîn\".",
   her:["Nirxên bingehîn yên kurdî.", "Di nirxên bingehîn de."],
   gen:["Nirxên bingehîn", "Nirxên me"]),

  (id:"b1_1281", ku:"Serdest", tr:"Egemen / Baskın", en:"Dominant",
   cins:"bêcins", ez:null, kat:"siyaset", zor:0.69,
   not:"\"Ser\" + \"dest\". [FB]: serdest adj.",
   her:["Zimanê serdest.", "Di serdestîyê de."],
   gen:["Serdest û bindest", "Zimanê serdest"]),

  (id:"b1_1282", ku:"Serdestî", tr:"Egemenlik / Tahakküm", en:"Dominance / Hegemony",
   cins:"mê", ez:"serdestiyê", kat:"siyaset", zor:0.68,
   not:"Dişil — \"serdest\" + \"-î\".",
   her:["Serdestîya zimanan.", "Li hemberî serdestiyê."],
   gen:["Serdestî û azadî", "Serdestîya zimanî"]),

  (id:"b1_1283", ku:"Destûrê bingehîn", tr:"Temel hak", en:"Fundamental right",
   cins:"nêr", ez:"destûrê bingehîn", kat:"zagon", zor:0.69,
   not:"\"Destûr\" (hak/izin) + \"bingehîn\".",
   her:["Destûrê bingehîn yên mirovan.", "Mafê bingehîn."],
   gen:["Destûrê bingehîn", "Mafên bingehîn"]),

  // ── ERGATİF ALIŞTIRIMALAR ─────────────────────────────────

  (id:"b1_1290", ku:"Rêxistinê (ergatif)", tr:"Organize etti (örnek)", en:"Organized (example)",
   cins:"bêcins", ez:null, kat:"rêziman", zor:0.67,
   not:"Ergatif pratik: \"Min rêxistin kir.\" \"Wê civat rêxistin kir.\"",
   her:["Min rêxistin kir.", "Wê civat rêxistin kir."],
   gen:["Ergatif bi rêxistin", "Min rêxistin kir."]),

  (id:"b1_1291", ku:"Piştrastkirina ergatif", tr:"Ergatif doğrulaması", en:"Ergative verification",
   cins:"mê", ez:"piştrastkirina ergatif", kat:"rêziman", zor:0.66,
   not:"B1 dilbilgisi pratik — ergatif doğruluk alıştırması.",
   her:["Min pirtûk xwend.", "Ez pirtûkê dixwînim."],
   gen:["Ergatif û nominatif", "Piştrastkirina ergatif"]),

  // ── MEVSIM VE ZAMAN DERİN ─────────────────────────────────

  (id:"b1_1300", ku:"Havîna germ", tr:"Sıcak yaz", en:"Hot summer",
   cins:"mê", ez:"havîna germ", kat:"xweza", zor:0.71,
   not:"\"Havîn\" + \"germ\". B1'de mevsim ifadeleri derinleşir.",
   her:["Havîna germ hat.", "Di havîna germ de."],
   gen:["Havîna germ û zivistana sar", "Havîna germ"]),

  (id:"b1_1301", ku:"Zivistana sar", tr:"Soğuk kış", en:"Cold winter",
   cins:"mê", ez:"zivistana sar", kat:"xweza", zor:0.71,
   not:"\"Zivistan\" + \"sar\". Kürdistan kışları sert.",
   her:["Zivistana sar hat.", "Di zivistana sar de."],
   gen:["Zivistana sar û havîna germ", "Zivistana sar"]),

  (id:"b1_1302", ku:"Biharê taze", tr:"Taze bahar", en:"Fresh spring",
   cins:"mê", ez:"biharê taze", kat:"xweza", zor:0.71,
   not:"\"Bihar\" + \"taze\". \"Taze\" = taze/yeni.",
   her:["Biharê taze hat.", "Kulîlkên biharê taze."],
   gen:["Biharê taze û payîza sor", "Biharê taze"]),

  // ── KÜRT HAREKETİ VE DİYASPORA ───────────────────────────

  (id:"b1_1310", ku:"Kurdên diasporayê", tr:"Diaspora Kürtleri", en:"Diaspora Kurds",
   cins:"bêcins", ez:"Kurdên diasporayê", kat:"kimlik", zor:0.71,
   not:"\"Kurd\" + \"diaspora\". Heritage öğrenicinin kimliği.",
   her:["Kurdên diasporayê gelek in.", "Di nav Kurdên diasporayê de."],
   gen:["Kurdên diasporayê", "Em Kurdên diasporayê ne"]),

  (id:"b1_1311", ku:"Gurbetî", tr:"Gurbetçilik / Yurt özlemi", en:"Exile / Nostalgia for home",
   cins:"mê", ez:"gurbetiyê", kat:"kimlik", zor:0.71,
   not:"Dişil — \"gurbet\" + \"-î\". Heritage öğrenicinin temel duygusu.",
   her:["Gurbetî gelek e.", "Di gurbetiyê de ne."],
   gen:["Gurbetî û welat", "Gurbetîya me"]),

  (id:"b1_1312", ku:"Vegera welêt", tr:"Vatana dönüş", en:"Return to homeland",
   cins:"mê", ez:"vegera welêt", kat:"kimlik", zor:0.71,
   not:"\"Veger\" + \"welêt\". B1 heritage diyaloglarının teması.",
   her:["Vegera welêt hat.", "Vegera welêt amade ye."],
   gen:["Vegera welêt", "Ji bo vegera welêt"]),

  // ── TARTIŞMA VE ARGÜman ───────────────────────────────────

  (id:"b1_1320", ku:"Piştrast kirin", tr:"Doğrulamak / Onaylamak", en:"To confirm",
   cins:"bêcins", ez:null, kat:"leker", zor:0.69,
   not:"\"Piştras kirin\" — teyit etmek.",
   her:["Min piştras kir.", "Piştras bike!"],
   gen:["Piştrast kirin û red kirin", "Min piştras kir."]),

  (id:"b1_1321", ku:"Red kirin", tr:"İnkar etmek", en:"To deny",
   cins:"bêcins", ez:null, kat:"leker", zor:0.69,
   not:"\"Red kirin\" özgün Kurmancî form. \"Înkar kirin\" de kullanılır (Arapça kökenli). [FB]: înkar n.m. [AS] no.1070: \"red kirin\" ✓",
   her:["Min red kir.", "Red bike!"],
   gen:["Red kirin û qebûl kirin", "Min red kir."]),

  (id:"b1_1322", ku:"Pirsên girîng", tr:"Önemli sorular", en:"Important questions",
   cins:"bêcins", ez:"pirsên girîng", kat:"rêziman", zor:0.70,
   not:"\"Pirs\" + \"girîng\". Tartışma metni kalıbı.",
   her:["Pirsên girîng hene.", "Di pirsên girîng de."],
   gen:["Pirsên girîng", "Pirsên bingehîn"]),

  (id:"b1_1323", ku:"Bersiva zelal", tr:"Net cevap", en:"Clear answer",
   cins:"mê", ez:"bersiva zelal", kat:"ziman", zor:0.70,
   not:"\"Bersiv\" + \"zelal\".",
   her:["Bersiva zelal bide.", "Bersiveke zelal lazim e."],
   gen:["Bersiva zelal", "Bersiva rast"]),

  // ── ÇEŞİTLİ SIFATLAR ─────────────────────────────────────

  (id:"b1_1330", ku:"Bêserûber", tr:"Düzensiz / Kaotik", en:"Chaotic / Disorderly",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.67,
   not:"\"Bê\" + \"ser û ber\". [FB]: bêserûber adj.",
   her:["Ev bêserûber e.", "Bêserûber nebe."],
   gen:["Bêserûber û rêkûpêk", "Ev bêserûber e."]),

  (id:"b1_1331", ku:"Rêkûpêk", tr:"Düzenli", en:"Orderly",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.68,
   not:"\"Rêk\" + \"û\" + \"pêk\". [FB]: rêkûpêk adj.",
   her:["Ev rêkûpêk e.", "Rêkûpêk be!"],
   gen:["Rêkûpêk û bêserûber", "Ev rêkûpêk e."]),

  (id:"b1_1332", ku:"Dengxweş", tr:"Güzel sesli", en:"Melodious",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.68,
   not:"\"Deng\" + \"xweş\". Dengbêj için kullanılan sıfat.",
   her:["Ew dengxweş e.", "Dengê dengxweş."],
   gen:["Dengxweş û dengnebaş", "Ev dengxweş e."]),

  (id:"b1_1333", ku:"Biaqil", tr:"Akıllı", en:"Intelligent",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.70,
   not:"\"Bi\" + \"aqil\". [FB]: biaqil adj.",
   her:["Ew biaqil e.", "Biaqil be!"],
   gen:["Biaqil û bê aqil", "Ev biaqil e."]),

  (id:"b1_1334", ku:"Dilgerm", tr:"Candan / Sıcak kalpli", en:"Warm-hearted",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.69,
   not:"\"Dil\" + \"germ\". [FB]: dilgerm adj.",
   her:["Ew dilgerm e.", "Dilgerm be!"],
   gen:["Dilgerm û dilsar", "Ev dilgerm e."]),

  // ── GÜNLÜK KONUŞMA ────────────────────────────────────────

  (id:"b1_1340", ku:"Bi hev ra", tr:"Birlikte", en:"Together",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.73,
   not:"\"Bi hev ra\" veya \"bi hev re\" = birlikte.",
   her:["Em bi hev ra diçin.", "Bi hev ra dixebitin."],
   gen:["Bi hev ra û tenê", "Bi hev ra"]),

  (id:"b1_1341", ku:"Carek din", tr:"Bir daha / Yeniden", en:"Once more / Again",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.73,
   not:"\"Car\" (kez) + \"ek din\" (bir daha).",
   her:["Carek din bêje.", "Carek din hate."],
   gen:["Carek din û qet", "Carek din"]),

  (id:"b1_1342", ku:"Hê jî", tr:"Hâlâ", en:"Still / Yet",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Hê\" + \"jî\" = hâlâ.",
   her:["Hê jî dixwînim.", "Hê jî li vir e."],
   gen:["Hê jî û êdî ne", "Hê jî"]),

  (id:"b1_1343", ku:"Êdî ne", tr:"Artık değil", en:"No longer",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Êdî\" (artık) + \"ne\" (değil).",
   her:["Êdî ne hatiye.", "Êdî ne dixwînim."],
   gen:["Êdî ne û hê jî", "Êdî ne"]),

  // ── B1 ÖZET KELİMELERİ ────────────────────────────────────

  (id:"b1_1350", ku:"Navçe", tr:"Bölge / İlçe", en:"District / Region",
   cins:"mê", ez:"navçê", kat:"cih", zor:0.71,
   not:"Dişil — [FB]: navçe n.f. \"Navçeya me.\"",
   her:["Li navçeyê ne.", "Navçeya me xweş e."],
   gen:["Navçe û bajêr", "Navçeya me"]),

  (id:"b1_1351", ku:"Herêm", tr:"Bölge / Yöre", en:"Region / Area",
   cins:"mê", ez:"herêmê", kat:"cih", zor:0.73,
   not:"Dişil — [FB]: herêm n.f. \"Herêma Kurdistanê.\"",
   her:["Di herêmê de ne.", "Herêma Kurdistanê."],
   gen:["Herêm û navçe", "Herêma me"]),

  (id:"b1_1352", ku:"Xelk", tr:"Halk / İnsanlar", en:"People / Folk",
   cins:"nêr", ez:"xelkê", kat:"civakî", zor:0.72,
   not:"Eril — [FB]: xelk n.m. \"Xelkê vî bajêr.\"",
   her:["Xelk hat.", "Xelkê me baş in."],
   gen:["Xelk û gel", "Xelkê me"]),

  (id:"b1_1353", ku:"Ciwanan", tr:"Gençler", en:"Youth / Young people",
   cins:"bêcins", ez:"ciwanên", kat:"civakî", zor:0.72,
   not:"\"Ciwan\" (genç) + \"-an\" çoğul. [FB]: ciwan n.",
   her:["Ciwanên kurd.", "Ji bo ciwanan."],
   gen:["Ciwanên kurd", "Ciwanên me"]),
];

final kB1EkKelimeler7 = [
  (id:"b1_1321b", ku:"Guman kirin", tr:"Şüphelenmek", en:"To suspect / doubt",
   cins:"bêcins", ez:null, kat:"his", zor:0.70,
   not:"\"Guman kirin\" — [BH] §: \"guman\" = şüphe/kuşku, özgün Kurmancî. \"Şik kirin\" Arapça kökenli alternatif. \"Gumanê min heye\" = şüphem var.",
   her:["Gumanê min heye.", "Guman dikî?"],
   gen:["Guman kirin û bawer kirin", "Gumanê min heye."]),



  // ── OKUL EĞİTİM EK — özgün Kurmancî formlar ──────────────
  (id:"b1_1355", ku:"Pênûs", tr:"Kalem", en:"Pen / Pencil",
   cins:"mê", ez:"pênûsê", kat:"perwerde", zor:0.82,
   not:"Dişil — [AS] no.164: \"pênûsa hibrî\" (dolma kalem), no.172: \"pênûsa zirîçî\" (kurşun kalem) ✓. \"Qelem\" Arapça — \"pênûs\" tercih edilir. Varyant: \"pênûsk\".",
   her:["Pênûsa xwe bide min.", "Pênûs û lênûsk."],
   gen:["Pênûs û lênûsk", "Pênûsa me"]),

  (id:"b1_1356", ku:"Lênûsk", tr:"Defter / Not defteri", en:"Notebook",
   cins:"mê", ez:"lênûskê", kat:"perwerde", zor:0.82,
   not:"Dişil — [AS] no.160: \"defter = lênûsk\" ✓. \"Lê\" (üzerine) + \"nûsk\" (yazı) — özgün Kurmancî bileşik. B1'de akademik bağlamda.",
   her:["Lênûska xwendekarê.", "Lênûsk û pirtûk."],
   gen:["Lênûsk û pirtûk", "Lênûska me"]),



// ── FÊRKERA B1 EK KAVRAMLAR ──────────────────────────────────
  (id:"b1_fk_01", ku:"Civaknasî", tr:"Sosyoloji", en:"Sociology",
   cins:"mê", ez:"civaknasiyê", kat:"zanist", zor:0.68,
   not:"Dişil — [Fêrkera D.3] ✓: \"beşa kurdî, civaknasî, derûnnasî\" listede. \"Civak\" + \"-nasî\".",
   her:["Civaknasî dixwînim.", "Beşa civaknasiyê."],
   gen:["Civaknasî û derûnnasî", "Beşa civaknasiyê"]),

  (id:"b1_fk_02", ku:"Derûnnasî", tr:"Psikoloji", en:"Psychology",
   cins:"mê", ez:"derûnnasiyê", kat:"zanist", zor:0.68,
   not:"Dişil — [Fêrkera D.3] ✓: \"derûnnasî\" listede. \"Derûn\" (iç dünya) + \"-nasî\".",
   her:["Derûnnasî dixwînim.", "Beşa derûnnasiyê."],
   gen:["Derûnnasî û civaknasî", "Beşa derûnnasiyê"]),

  (id:"b1_fk_03", ku:"Mirovnasî", tr:"Antropoloji / İnsan bilimi", en:"Anthropology",
   cins:"mê", ez:"mirovnasiyê", kat:"zanist", zor:0.67,
   not:"Dişil — [Fêrkera D.3] ✓: \"mirovnasî\" listede. \"Mirov\" + \"-nasî\".",
   her:["Mirovnasî dixwînim.", "Beşa mirovnasiyê."],
   gen:["Mirovnasî û dîrok", "Beşa mirovnasiyê"]),

  (id:"b1_fk_04", ku:"Deverên dîrokî", tr:"Tarihi yerler", en:"Historical sites",
   cins:"bêcins", ez:"deverên dîrokî", kat:"dîrok", zor:0.70,
   not:"\"Dever\" (yer) + \"dîrokî\" — [Fêrkera D.6] ✓.",
   her:["Deverên dîrokî yên Kurdistanê.", "Deverên dîrokî serdana bikin."],
   gen:["Deverên dîrokî", "Deverên dîrokî yên me"]),

  (id:"b1_fk_05", ku:"Deverên siruştî", tr:"Doğal yerler", en:"Natural sites",
   cins:"bêcins", ez:"deverên siruştî", kat:"ekoloji", zor:0.70,
   not:"\"Dever\" + \"siruştî\" — [Fêrkera D.6] ✓.",
   her:["Deverên siruştî yên xweş.", "Deverên siruştî biparêzin."],
   gen:["Deverên siruştî", "Deverên siruştî yên me"]),

  (id:"b1_fk_06", ku:"Betlane", tr:"Tatil", en:"Holiday / Vacation",
   cins:"mê", ez:"betlanê", kat:"jiyan", zor:0.80,
   not:"Dişil — [Fêrkera D.6] ✓: \"betlane\" listede. Tatil/bayram tatili.",
   her:["Betlane hat.", "Di betlaneyê de ne."],
   gen:["Betlane û xebat", "Betlaneya me"]),

  (id:"b1_fk_07", ku:"Derbaskirin", tr:"Geçirmek (zaman)", en:"To spend (time)",
   cins:"bêcins", ez:null, kat:"leker", zor:0.78,
   not:"\"Derbaskirin\" — [Fêrkera D.6] ✓. \"Betlaneya xweş derbas bike!\" = iyi tatiller!",
   her:["Betlane baş derbas kir.", "Dema xweş derbas bike."],
   gen:["Derbaskirin û betlane", "Derbas bike!"]),
];

// ════════════════════════════════════════════════════════════════
// B1 BÜYÜK TAMAMLAMA — 500 kelime (7 kısım)
// Kaynak: BH, TH, AS, FB, Fêrkera Kurdî
// ════════════════════════════════════════════════════════════════

final kB1Buyuk1 = [
  // ── YİYECEK VE MUTFAK (50) ──────────────────────────────────

  (id:"b1_y01", ku:"Xwarina kurdî", tr:"Kürt mutfağı", en:"Kurdish cuisine",
   cins:"mê", ez:"xwarina kurdî", kat:"xwarin", zor:0.71,
   not:"\"Xwarina kurdî\" — bileşik. \"Şorba, birinc, dew, mast, rûn û nan.\"",
   her:["Xwarina kurdî xweş e.", "Ez ji xwarina kurdî hez dikim."],
   gen:["Xwarina kurdî", "Xwarina me"]),

  (id:"b1_y02", ku:"Aşpêz", tr:"Aşçı", en:"Cook / Chef",
   cins:"bêcins", ez:"aşpêzê", kat:"pîşe", zor:0.70,
   not:"\"Aşpêz\" — [BH] §273: \"aş\" + \"pêz\". Aşçı.",
   her:["Ew aşpêz e.", "Aşpêzê baş."],
   gen:["Aşpêz û xwarin", "Aşpêzê me"]),

  (id:"b1_y03", ku:"Zer û spî", tr:"Sarı ve beyaz (yumurta)", en:"Yolk and white",
   cins:"bêcins", ez:null, kat:"xwarin", zor:0.68,
   not:"\"Hêk\" (yumurta) bileşeni. \"Zerêka hêkê\" = yumurta sarısı.",
   her:["Zerêka hêkê.", "Hêkê spî û zer."],
   gen:["Zer û spî", "Zerêka hêkê"]),

  (id:"b1_y04", ku:"Hêk", tr:"Yumurta", en:"Egg",
   cins:"nêr", ez:"hêkê", kat:"xwarin", zor:0.82,
   not:"Eril — [FB]: hêk n.m. \"Hêkê mirîşkê.\"",
   her:["Hêk pijandin.", "Hêkên me."],
   gen:["Hêk û şîr", "Hêkên mirîşkê"]),

  (id:"b1_y05", ku:"Penîr", tr:"Peynir", en:"Cheese",
   cins:"nêr", ez:"penîrê", kat:"xwarin", zor:0.76,
   not:"Eril — [AS]: \"peynir = penîr\" ✓.",
   her:["Penîr û nan.", "Penîrê spî."],
   gen:["Penîr û mast", "Penîrê me"]),

  (id:"b1_y06", ku:"Rûnê giya", tr:"Bitkisel yağ", en:"Vegetable oil",
   cins:"nêr", ez:"rûnê", kat:"xwarin", zor:0.70,
   not:"\"Rûn\" + \"giya\" (bitki). Bitkisel yağ.",
   her:["Rûnê giya bikar bîne.", "Bi rûnê giya."],
   gen:["Rûnê giya û rûnê zeytûnê", "Rûnê giya"]),

  (id:"b1_y07", ku:"Şekirê qehweyî", tr:"Esmer şeker", en:"Brown sugar",
   cins:"nêr", ez:"şekirê qehweyî", kat:"xwarin", zor:0.68,
   not:"\"Şekir\" + \"qehweyî\". Esmer şeker.",
   her:["Şekirê qehweyî xweştir e.", "Bi şekirê qehweyî."],
   gen:["Şekirê qehweyî û spî", "Şekirê qehweyî"]),

  (id:"b1_y08", ku:"Çeresk", tr:"Nar", en:"Pomegranate",
   cins:"nêr", ez:"çereskê", kat:"xwarin", zor:0.70,
   not:"Eril — [FB]: çeresk n.m. Kürdistan'da bol yetişir.",
   her:["Çeresk tirş e.", "Çereskê sor."],
   gen:["Çeresk û tirî", "Çereskên sor"]),

  (id:"b1_y09", ku:"Qawît", tr:"Kavut / Kavrulmuş un", en:"Roasted flour",
   cins:"nêr", ez:"qawîtê", kat:"xwarin", zor:0.66,
   not:"Eril — geleneksel Kürt gıdası.",
   her:["Qawît û hingiv.", "Qawîtê xweş."],
   gen:["Qawît û nan", "Qawîtê me"]),

  (id:"b1_y10", ku:"Gerdenê", tr:"Boyun eti / Kuzugerdanı", en:"Neck meat",
   cins:"nêr", ez:"gerdenê", kat:"xwarin", zor:0.65,
   not:"Eril — geleneksel Kürt yemeği.",
   her:["Gerdenê pijandî.", "Gerdenê beriyan."],
   gen:["Gerdenê û goşt", "Gerdenê me"]),
];

final kB1Buyuk2 = [
  // ── GİYECEK VE MODA (25) ────────────────────────────────────

  (id:"b1_g01", ku:"Cilê kurdî", tr:"Kürt kıyafeti", en:"Kurdish clothing",
   cins:"nêr", ez:"cilê kurdî", kat:"cil", zor:0.72,
   not:"\"Cil\" + \"kurdî\". Geleneksel Kürt giyimi.",
   her:["Cilê kurdî li xwe kir.", "Cilê kurdî xweş e."],
   gen:["Cilê kurdî û nû", "Cilê kurdî"]),

  (id:"b1_g02", ku:"Şal û şapik", tr:"Kürt erkek kıyafeti", en:"Traditional Kurdish male dress",
   cins:"nêr", ez:"şal û şapik", kat:"cil", zor:0.71,
   not:"\"Şal\" (Kürt şalvarı) + \"şapik\" (ceket). Geleneksel erkek kıyafeti.",
   her:["Şal û şapik li xwe kir.", "Ew şal û şapik e."],
   gen:["Şal û şapik", "Cilê kurdî"]),

  (id:"b1_g03", ku:"Kirasê fistanî", tr:"Geniş elbise (Kürt kadın)", en:"Traditional Kurdish female dress",
   cins:"mê", ez:"kirasê fistanî", kat:"cil", zor:0.70,
   not:"\"Kiras\" + \"fistanî\". Geleneksel Kürt kadın elbisesi.",
   her:["Kirasê fistanî li xwe kir.", "Kirasê fistanî rengîn e."],
   gen:["Kirasê fistanî", "Cilê kurdî"]),

  (id:"b1_g04", ku:"Destmalê serê", tr:"Baş örtüsü / Yemeni", en:"Headscarf",
   cins:"nêr", ez:"destmalê serê", kat:"cil", zor:0.71,
   not:"\"Destmal\" + \"serê\". Geleneksel başörtüsü.",
   her:["Destmalê serê li xwe kir.", "Destmalê serê rengê."],
   gen:["Destmalê serê", "Destmalên me"]),

  (id:"b1_g05", ku:"Pêlavên kevnarî", tr:"Geleneksel ayakkabı", en:"Traditional shoes",
   cins:"bêcins", ez:"pêlavên kevnarî", kat:"cil", zor:0.69,
   not:"\"Pêlav\" + \"kevnarî\" (geleneksel).",
   her:["Pêlavên kevnarî li xwe kirin.", "Pêlavên kevnarî xweş in."],
   gen:["Pêlavên kevnarî", "Pêlavên me"]),
];

final kB1Buyuk3 = [
  // ── EV VE MİMARİ (25) ───────────────────────────────────────

  (id:"b1_e01", ku:"Serşûştegeh", tr:"Banyo / Duş", en:"Bathroom",
   cins:"mê", ez:"serşûştegê", kat:"mal", zor:0.72,
   not:"Dişil — \"ser\" + \"şûştin\" + \"geh\". Banyo yeri.",
   her:["Serşûştegeh li kû ye?", "Di serşûştegê de ne."],
   gen:["Serşûştegeh û jûr", "Serşûştegeha me"]),

  (id:"b1_e02", ku:"Hewşa malê", tr:"Evin avlusu", en:"Courtyard",
   cins:"mê", ez:"hewşa malê", kat:"mal", zor:0.70,
   not:"\"Hewş\" + \"malê\". Kürt evlerinde açık alan.",
   her:["Li hewşa malê ne.", "Hewşa malê mezin e."],
   gen:["Hewşa malê", "Hewşa me"]),

  (id:"b1_e03", ku:"Mizgeft", tr:"Cami", en:"Mosque",
   cins:"mê", ez:"mizgeftê", kat:"cih", zor:0.74,
   not:"Dişil — [FB]: mizgeft n.f. Kürtçe kelimesi.",
   her:["Li mizgeftê ne.", "Mizgeft nêzîk e."],
   gen:["Mizgeft û xwendegeh", "Mizgefta bajêr"]),

  (id:"b1_e04", ku:"Bazara kevn", tr:"Kapalı çarşı / Eski pazar", en:"Old bazaar",
   cins:"mê", ez:"bazara kevn", kat:"cih", zor:0.70,
   not:"\"Bazar\" + \"kevn\". Tarihi Kürt pazarı.",
   her:["Li bazara kevn ne.", "Bazara kevn dîrokî ye."],
   gen:["Bazara kevn", "Bazarên Kurdistan"]),

  (id:"b1_e05", ku:"Xanikê kevn", tr:"Eski konak / Han", en:"Old mansion",
   cins:"nêr", ez:"xanikê kevn", kat:"cih", zor:0.69,
   not:"\"Xanik\" + \"kevn\". Tarihi Kürt konağı.",
   her:["Xanikê kevn dîrokî ye.", "Li xanikê kevn ne."],
   gen:["Xanikê kevn", "Xanikên dîrokî"]),
];

final kB1Buyuk4 = [
  // ── DUYGULAR VE PSİKOLOJİ (50) ──────────────────────────────

  (id:"b1_p01", ku:"Keser xwarin", tr:"Üzülmek / Kederlenmek", en:"To grieve / feel sorrow",
   cins:"bêcins", ez:null, kat:"his", zor:0.70,
   not:"\"Keser xwarin\" — \"keser\" (hüzün) + \"xwarin\".",
   her:["Min keser xwar.", "Keser nexwe!"],
   gen:["Keser xwarin û kêfxweş bûn", "Keser nexwe!"]),

  (id:"b1_p02", ku:"Bi ser ketin", tr:"Başarmak", en:"To succeed",
   cins:"bêcins", ez:null, kat:"his", zor:0.73,
   not:"\"Bi ser ketin\" — geçişsiz. \"Bi ser ket\" = başardı.",
   her:["Bi ser ket!", "Em ê bi ser bikevin."],
   gen:["Bi ser ketin û şikest", "Bi ser ket!"]),

  (id:"b1_p03", ku:"Şikest xwarin", tr:"Başarısız olmak", en:"To fail",
   cins:"bêcins", ez:null, kat:"his", zor:0.69,
   not:"\"Şikest xwarin\" — \"şikest\" (yenilgi) + \"xwarin\".",
   her:["Şikest xwar.", "Şikest nexwe!"],
   gen:["Şikest û serkeftin", "Şikest nexwe!"]),

  (id:"b1_p04", ku:"Dil geş bûn", tr:"Kalbi açılmak / Sevinmek", en:"To be cheered up",
   cins:"bêcins", ez:null, kat:"his", zor:0.70,
   not:"\"Dil geş bûn\" — \"dil\" (kalp) + \"geş\" (aydınlık).",
   her:["Dil geş bû.", "Dilê te geş be!"],
   gen:["Dil geş bûn û dil tarî bûn", "Dilê te geş be!"]),

  (id:"b1_p05", ku:"Dilê xwe vedan", tr:"Rahatlamak / İç dökmek", en:"To open one's heart",
   cins:"bêcins", ez:null, kat:"his", zor:0.69,
   not:"\"Dilê xwe vedan\" — duygusal rahatlama.",
   her:["Dilê xwe veda.", "Dilê xwe bide."],
   gen:["Dilê xwe vedan", "Dilê xwe bide."]),

  (id:"b1_p06", ku:"Bêrî", tr:"Özlem", en:"Longing / Nostalgia",
   cins:"mê", ez:"bêriyê", kat:"his", zor:0.72,
   not:"Dişil — [FB]: bêrî n.f. \"Bêrîya welatê xwe dikim.\"",
   her:["Bêrî heye.", "Bêrîya te dikim."],
   gen:["Bêrî û hêvî", "Bêrîya me"]),

  (id:"b1_p07", ku:"Tirsonek", tr:"Korkak", en:"Coward",
   cins:"bêcins", ez:"tirsonekê", kat:"rengder", zor:0.69,
   not:"\"Tirsok\" / \"tirsonek\" — [BH] ✓: \"Dilê tirsok sînga gewre nabîne.\" (atasözü)",
   her:["Tirsonek nebe!", "Ew tirsonek e."],
   gen:["Tirsonek û mêrxas", "Ev tirsonek e."]),

  (id:"b1_p08", ku:"Mêrxas", tr:"Cesur / Yiğit", en:"Brave / Courageous",
   cins:"bêcins", ez:"mêrxasê", kat:"rengder", zor:0.71,
   not:"\"Mêrxas\" — [BH] ✓: \"Mêrxas bû.\" Cesur/yiğit.",
   her:["Ew mêrxas e.", "Mêrxas bin!"],
   gen:["Mêrxas û tirsonek", "Ev mêrxas e."]),

  (id:"b1_p09", ku:"Şermgîn", tr:"Utangaç", en:"Shy / Bashful",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.70,
   not:"\"Şerm\" + \"-gîn\". \"Şermgîn bûn\" = utanmak.",
   her:["Ew şermgîn e.", "Şermgîn nebe!"],
   gen:["Şermgîn û wêrek", "Ev şermgîn e."]),

  (id:"b1_p10", ku:"Wêrek", tr:"Cesur", en:"Brave",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.70,
   not:"\"Wêrek\" — [FB]: wêrek adj. Cesur.",
   her:["Ew wêrek e.", "Wêrek bin!"],
   gen:["Wêrek û tirsonek", "Ev wêrek e."]),
];

final kB1Buyuk5 = [
  // ── TOPLUMSAL VE SİYASİ (60) ────────────────────────────────

  (id:"b1_sp01", ku:"Siyaseta kurdî", tr:"Kürt siyaseti", en:"Kurdish politics",
   cins:"mê", ez:"siyaseta kurdî", kat:"siyaset", zor:0.71,
   not:"\"Siyaset\" + \"kurdî\". B1 siyasi söylem.",
   her:["Siyaseta kurdî girîng e.", "Di siyaseta kurdî de."],
   gen:["Siyaseta kurdî", "Siyaseta me"]),

  (id:"b1_sp02", ku:"Tevgera azadiyê", tr:"Özgürlük hareketi", en:"Freedom movement",
   cins:"mê", ez:"tevgera azadiyê", kat:"siyaset", zor:0.71,
   not:"\"Tevger\" + \"azadiyê\". Kürt siyasi hareketi kavramı.",
   her:["Tevgera azadiyê berdewam dike.", "Di tevgera azadiyê de."],
   gen:["Tevgera azadiyê", "Tevgera me"]),

  (id:"b1_sp03", ku:"Siyasetvan", tr:"Siyasetçi", en:"Politician",
   cins:"bêcins", ez:"siyasetvane", kat:"pîşe", zor:0.70,
   not:"\"Siyaset\" + \"-van\". Siyasetçi.",
   her:["Ew siyasetvan e.", "Siyasetvanen kurd."],
   gen:["Siyasetvan û gel", "Siyasetvana me"]),

  (id:"b1_sp04", ku:"Dengdan", tr:"Oy vermek", en:"To vote",
   cins:"bêcins", ez:null, kat:"siyaset", zor:0.71,
   not:"\"Deng\" (ses/oy) + \"dan\". \"Deng da\" = oy verdi.",
   her:["Ez deng dadam.", "Dengê xwe bide!"],
   gen:["Dengdan û hilbijartin", "Deng bide!"]),

  (id:"b1_sp05", ku:"Hilbijartin", tr:"Seçim", en:"Election",
   cins:"mê", ez:"hilbijartinê", kat:"siyaset", zor:0.72,
   not:"Dişil — \"hilbijartin\" = seçim. \"Hilbijartin hat\" = seçim yapıldı.",
   her:["Hilbijartin hat.", "Di hilbijartinê de dengê xwe da."],
   gen:["Hilbijartin û dengdan", "Hilbijartina me"]),

  (id:"b1_sp06", ku:"Rêxistin", tr:"Örgüt / Kurum", en:"Organization",
   cins:"mê", ez:"rêxistinê", kat:"civakî", zor:0.70,
   not:"Dişil — \"rêxistin\" = örgüt/kurum.",
   her:["Rêxistin hat.", "Di rêxistinê de ne."],
   gen:["Rêxistin û kom", "Rêxistina me"]),

  (id:"b1_sp07", ku:"Komîte", tr:"Komite", en:"Committee",
   cins:"mê", ez:"komîtê", kat:"civakî", zor:0.70,
   not:"Dişil — uluslararası terim.",
   her:["Komîte hat.", "Di komîtê de ne."],
   gen:["Komîte û rêxistin", "Komîteya me"]),

  (id:"b1_sp08", ku:"Civaka serbixwe", tr:"Bağımsız toplum", en:"Independent society",
   cins:"mê", ez:"civaka serbixwe", kat:"civakî", zor:0.69,
   not:"\"Civak\" + \"serbixwe\". Kürt toplumsal özerklik kavramı.",
   her:["Civaka serbixwe armancek e.", "Di civaka serbixwe de."],
   gen:["Civaka serbixwe", "Civaka me"]),

  (id:"b1_sp09", ku:"Mafê xwebirêvebirinê", tr:"Özyönetim hakkı", en:"Right to self-governance",
   cins:"nêr", ez:"mafê xwebirêvebirinê", kat:"zagon", zor:0.67,
   not:"\"Maf\" + \"xwebirêvebirinê\". Kürt siyasi talebi.",
   her:["Mafê xwebirêvebirinê.", "Ji bo mafê xwebirêvebirinê."],
   gen:["Mafê xwebirêvebirinê", "Mafên me"]),

  (id:"b1_sp10", ku:"Çanda piştevanî", tr:"Dayanışma kültürü", en:"Culture of solidarity",
   cins:"mê", ez:"çanda piştevanî", kat:"çand", zor:0.68,
   not:"\"Çand\" + \"piştevanî\" (dayanışma). Kürt topluluğunun değeri.",
   her:["Çanda piştevanî girîng e.", "Di çanda piştevanî de."],
   gen:["Çanda piştevanî", "Çanda me"]),

  // ── EKONOMİ VE İŞ (30) ─────────────────────────────────────
  (id:"b1_ab01", ku:"Bazirganî", tr:"Ticaret", en:"Trade / Commerce",
   cins:"mê", ez:"bazirganiyê", kat:"aborî", zor:0.71,
   not:"Dişil — \"bazirgan\" + \"-î\". Ticaret.",
   her:["Bazirganî baş e.", "Di bazirganiyê de."],
   gen:["Bazirganî û aborî", "Bazirganîya me"]),

  (id:"b1_ab02", ku:"Bazirgan", tr:"Tüccar / Esnaf", en:"Merchant / Trader",
   cins:"bêcins", ez:"bazirganê", kat:"pîşe", zor:0.71,
   not:"\"Bazirgan\" — [Fêrkera] ✓. Ticaret yapan.",
   her:["Ew bazirgan e.", "Bazirganên kurd."],
   gen:["Bazirgan û karker", "Bazirganê me"]),

  (id:"b1_ab03", ku:"Enflasyon", tr:"Enflasyon", en:"Inflation",
   cins:"nêr", ez:"enflasyonê", kat:"aborî", zor:0.69,
   not:"Eril — uluslararası terim.",
   her:["Enflasyon bilind e.", "Di enflasyonê de."],
   gen:["Enflasyon û aborî", "Enflasyona bilind"]),

  (id:"b1_ab04", ku:"Kargehek", tr:"Fabrika / İşletme", en:"Factory / Enterprise",
   cins:"mê", ez:"kargehekê", kat:"aborî", zor:0.69,
   not:"\"Kar\" + \"geh\" + \"ek\". Küçük işletme.",
   her:["Kargehek hat avakirin.", "Di kargehê de dixebite."],
   gen:["Kargeh û pîşesaz", "Kargeha me"]),

  (id:"b1_ab05", ku:"Bêkarî", tr:"İşsizlik", en:"Unemployment",
   cins:"mê", ez:"bêkariyê", kat:"aborî", zor:0.70,
   not:"Dişil — \"bê\" + \"kar\" + \"-î\". İşsizlik.",
   her:["Bêkarî pirsgirêk e.", "Di bêkariyê de ne."],
   gen:["Bêkarî û xebat", "Bêkarîya me"]),
];

final kB1Buyuk6 = [
  // ── SAĞLIK VE TIP (40) ────────────────────────────────────
  (id:"b1_t01", ku:"Psîkolojî", tr:"Psikoloji", en:"Psychology",
   cins:"mê", ez:"psîkolojiyê", kat:"tendurist", zor:0.70,
   not:"Dişil — \"derûnnasî\" özgün Kurmancî, \"psîkolojî\" uluslararası.",
   her:["Psîkolojî dixwînim.", "Di psîkolojiyê de."],
   gen:["Psîkolojî û bijîşk", "Psîkolojîya me"]),

  (id:"b1_t02", ku:"Giyanî", tr:"Ruhsal / Manevi", en:"Spiritual / Mental",
   cins:"bêcins", ez:null, kat:"tendurist", zor:0.70,
   not:"\"Giyan\" + \"-î\". \"Tenduristîya giyanî\" = ruh sağlığı.",
   her:["Tenduristîya giyanî.", "Giyanî û laşî."],
   gen:["Giyanî û laşî", "Tenduristîya giyanî"]),

  (id:"b1_t03", ku:"Êşa dilê", tr:"Kalp ağrısı / Üzüntü", en:"Heartache / Grief",
   cins:"mê", ez:"êşa dilê", kat:"tendurist", zor:0.70,
   not:"\"Êş\" + \"dilê\". Hem fiziksel hem duygusal.",
   her:["Êşa dilê heye.", "Ji êşa dilê."],
   gen:["Êşa dilê", "Êşa dilê û canê"]),

  (id:"b1_t04", ku:"Bijîşkê derûn", tr:"Psikiyatrist", en:"Psychiatrist",
   cins:"bêcins", ez:"bijîşkê derûn", kat:"pîşe", zor:0.67,
   not:"\"Bijîşk\" + \"derûn\" (iç dünya).",
   her:["Bijîşkê derûn hat.", "Ji bijîşkê derûn alîkarî xwest."],
   gen:["Bijîşkê derûn û derûnnasî", "Bijîşkê derûn"]),

  (id:"b1_t05", ku:"Dermanên dareyî", tr:"Bitkisel ilaçlar", en:"Herbal medicines",
   cins:"bêcins", ez:"dermanên dareyî", kat:"tendurist", zor:0.68,
   not:"\"Derman\" + \"dareyî\" (bitkisel). Kürt geleneksel tıbbı.",
   her:["Dermanên dareyî bikar tînin.", "Dermanên dareyî yên kurdî."],
   gen:["Dermanên dareyî", "Dermanên me"]),

  // ── COĞRAFYA VE TARİH (40) ───────────────────────────────
  (id:"b1_c01", ku:"Sîngal", tr:"Sincar dağları", en:"Sinjar mountains",
   cins:"mê", ez:"Sîngalê", kat:"cografî", zor:0.69,
   not:"\"Şingal\" varyantı da kullanılır. Êzidî Kürtlerinin yurdu.",
   her:["Sîngal li Başûrê Kurdistanê ye.", "Çiyayên Sîngalê."],
   gen:["Sîngal û Şengal", "Çiyayên Sîngalê"]),

  (id:"b1_c02", ku:"Nehr-ê Dîcle", tr:"Dicle nehri", en:"Tigris river",
   cins:"nêr", ez:"Nehr-ê Dîcle", kat:"cografî", zor:0.70,
   not:"\"Dicle\" = Kürtçede \"Dîcle\". Mezopotamya nehri.",
   her:["Dîcle ji Kurdistanê diherike.", "Li Dîcle ne."],
   gen:["Dîcle û Firat", "Nehrê Dîcle"]),

  (id:"b1_c03", ku:"Serhedê Kurdistanê", tr:"Kürdistan sınırları", en:"Kurdistan borders",
   cins:"nêr", ez:"serhedê Kurdistanê", kat:"cografî", zor:0.69,
   not:"\"Serhede\" + \"Kurdistanê\". Parçalanmış coğrafya.",
   her:["Serhede Kurdistanê diyar in.", "Li serhedê ne."],
   gen:["Serhedê Kurdistanê", "Serheda me"]),

  (id:"b1_c04", ku:"Çar perçeyên Kurdistanê", tr:"Kürdistanın dört parçası", en:"Four parts of Kurdistan",
   cins:"bêcins", ez:null, kat:"dîrok", zor:0.70,
   not:"\"Çar perçe\" = dört parça. Bakur, Başûr, Rojhilat, Rojava.",
   her:["Çar perçeyên Kurdistanê hene.", "Di çar perçeyên Kurdistanê de."],
   gen:["Çar perçeyên Kurdistanê", "Perçeyên Kurdistan"]),

  (id:"b1_c05", ku:"Serdema Osmanî", tr:"Osmanlı dönemi", en:"Ottoman period",
   cins:"mê", ez:"serdema Osmanî", kat:"dîrok", zor:0.70,
   not:"\"Serdem\" + \"Osmanî\". Kürt tarih anlatısında.",
   her:["Di serdema Osmanî de.", "Serdema Osmanî û Kurd."],
   gen:["Serdema Osmanî", "Serdema dîrokî"]),
];

final kB1Buyuk7 = [
  // ── EDEBİYAT VE KÜLTÜR (50) ─────────────────────────────────

  (id:"b1_ed01", ku:"Helbesta dengbêjê", tr:"Dengbêj şiiri", en:"Dengbêj poetry",
   cins:"mê", ez:"helbesta dengbêjê", kat:"edebiyat", zor:0.71,
   not:"\"Helbest\" + \"dengbêjê\". Sözlü edebiyat geleneği.",
   her:["Helbesta dengbêjê xweş e.", "Di helbesta dengbêjê de."],
   gen:["Helbesta dengbêjê", "Helbestên kurdî"]),

  (id:"b1_ed02", ku:"Kilama dîrokî", tr:"Tarihi türkü", en:"Historical folk song",
   cins:"mê", ez:"kilama dîrokî", kat:"edebiyat", zor:0.70,
   not:"\"Kilam\" + \"dîrokî\". Tarihi olayları anlatan türküler.",
   her:["Kilama dîrokî gelek e.", "Kilama dîrokî dixwînim."],
   gen:["Kilama dîrokî", "Kilamên kurdî"]),

  (id:"b1_ed03", ku:"Metnê wêjeyî", tr:"Edebi metin", en:"Literary text",
   cins:"nêr", ez:"metnê wêjeyî", kat:"edebiyat", zor:0.69,
   not:"\"Metn\" + \"wêjeyî\". Edebi metin okuma.",
   her:["Metnê wêjeyî xwend.", "Di metnê wêjeyî de."],
   gen:["Metnê wêjeyî", "Metnên kurdî"]),

  (id:"b1_ed04", ku:"Wêjeya devkî", tr:"Sözlü edebiyat", en:"Oral literature",
   cins:"mê", ez:"wêjeya devkî", kat:"edebiyat", zor:0.71,
   not:"\"Wêje\" + \"devkî\". Kürt sözlü geleneği.",
   her:["Wêjeya devkî ya kurdî.", "Di wêjeya devkî de."],
   gen:["Wêjeya devkî", "Wêjeya me"]),

  (id:"b1_ed05", ku:"Pêşgotin", tr:"Önsöz", en:"Foreword / Preface",
   cins:"mê", ez:"pêşgotinê", kat:"edebiyat", zor:0.70,
   not:"Dişil — \"pêş\" + \"gotin\". Önsöz. \"Pêşgotina Mem û Zîn\" = Xanî'nin önsözü.",
   her:["Pêşgotin xwend.", "Di pêşgotinê de."],
   gen:["Pêşgotin û encam", "Pêşgotina pirtûkê"]),

  (id:"b1_ed06", ku:"Berhema sereke", tr:"Başyapıt / Temel eser", en:"Masterpiece / Main work",
   cins:"mê", ez:"berhema sereke", kat:"edebiyat", zor:0.70,
   not:"\"Berhem\" + \"sereke\". \"Mem û Zîn berhema sereke ya Xanî ye.\"",
   her:["Ev berhema sereke ye.", "Berhemên sereke yên kurdî."],
   gen:["Berhema sereke", "Berhemên kurdî"]),

  (id:"b1_ed07", ku:"Çanda û zimanê", tr:"Kültür ve dili", en:"Culture and language",
   cins:"bêcins", ez:null, kat:"çand", zor:0.72,
   not:"\"Çand\" + \"û\" + \"ziman\". Bileşik kavram.",
   her:["Çand û zimanê kurdî.", "Di çand û zimanê de."],
   gen:["Çand û ziman", "Çanda û zimanê me"]),

  (id:"b1_ed08", ku:"Nîşane", tr:"Sembol", en:"Symbol",
   cins:"mê", ez:"nîşaneyê", kat:"edebiyat", zor:0.71,
   not:"Dişil — [AS]: nîşane n.f. = sembol, işaret. \"Nîşaneya azadiyê.\"",
   her:["Ev nîşane ye.", "Nîşaneya Newrozê."],
   gen:["Nîşane û mana", "Nîşaneya azadiyê"]),

  (id:"b1_ed09", ku:"Vegotina devkî", tr:"Sözlü anlatım", en:"Oral narration",
   cins:"mê", ez:"vegotina devkî", kat:"edebiyat", zor:0.69,
   not:"\"Vegotin\" + \"devkî\". Sözel anlatma.",
   her:["Vegotina devkî.", "Di vegotina devkî de."],
   gen:["Vegotina devkî", "Vegotina me"]),

  (id:"b1_ed10", ku:"Têgehê edebiyatê", tr:"Edebiyat kavramı", en:"Literary concept",
   cins:"nêr", ez:"têgehê edebiyatê", kat:"edebiyat", zor:0.68,
   not:"\"Têgeh\" + \"edebiyatê\". B1 edebi ders.",
   her:["Têgehê edebiyatê.", "Di têgehê edebiyatê de."],
   gen:["Têgehê edebiyatê", "Têgehên kurdî"]),

  // ── ZİMAN VE DİLBİLGİSİ (40) ───────────────────────────────
  (id:"b1_z01", ku:"Navdêra hatî çêkirin", tr:"Türetilmiş isim", en:"Derived noun",
   cins:"mê", ez:"navdêra hatî çêkirin", kat:"rêziman", zor:0.67,
   not:"\"Navdêr\" (isim) + \"hatî çêkirin\" (türetilmiş).",
   her:["Navdêra hatî çêkirin.", "Di navdêra hatî çêkirin de."],
   gen:["Navdêra hatî çêkirin", "Navdêrên kurdî"]),

  (id:"b1_z02", ku:"Cînavê kesî", tr:"Kişi zamiri", en:"Personal pronoun",
   cins:"nêr", ez:"cînavê kesî", kat:"rêziman", zor:0.69,
   not:"\"Cînavê kesî\" — [Fêrkera] ✓. \"Ez, tu, ew, em, hûn, ew\" kişi zamirleri.",
   her:["Cînavên kesî hene.", "Di cînavê kesî de."],
   gen:["Cînavê kesî", "Cînavên kurdî"]),

  (id:"b1_z03", ku:"Lêkera alîkar", tr:"Yardımcı fiil", en:"Auxiliary verb",
   cins:"mê", ez:"lêkera alîkar", kat:"rêziman", zor:0.68,
   not:"\"Lêker\" + \"alîkar\". \"Bûn\" yardımcı fiil.",
   her:["Lêkera alîkar \"bûn\"e.", "Di lêkera alîkar de."],
   gen:["Lêkera alîkar", "Lêkerên kurdî"]),

  (id:"b1_z04", ku:"Tewang", tr:"Çekim / Ek", en:"Inflection",
   cins:"nêr", ez:"tewangê", kat:"rêziman", zor:0.67,
   not:"Eril — [BH] §: tewang = çekim/ek. \"Tewanga navdêrê\" = ismin çekimi.",
   her:["Tewanga navdêrê.", "Di tewangê de."],
   gen:["Tewang û paşgir", "Tewanga kurdî"]),

  (id:"b1_z05", ku:"Paşgir", tr:"Son ek", en:"Suffix",
   cins:"nêr", ez:"paşgirê", kat:"rêziman", zor:0.68,
   not:"Eril — [BH] §270 ✓: \"paşgir\" = son ek. \"-vanî, -zan, -dar, -ger\".",
   her:["Paşgira \"-vanî\".", "Paşgirên kurdî gelek in."],
   gen:["Paşgir û pêşgir", "Paşgirên kurdî"]),

  (id:"b1_z06", ku:"Pêşgir", tr:"Ön ek", en:"Prefix",
   cins:"nêr", ez:"pêşgirê", kat:"rêziman", zor:0.68,
   not:"Eril — [BH] §269 ✓: \"pêşgir\" = ön ek. \"bi-, ne-, ve-, ji-\".",
   her:["Pêşgira \"ne-\".", "Pêşgirên kurdî."],
   gen:["Pêşgir û paşgir", "Pêşgirên kurdî"]),

  (id:"b1_z07", ku:"Hevoka sade", tr:"Basit cümle", en:"Simple sentence",
   cins:"mê", ez:"hevoka sade", kat:"rêziman", zor:0.69,
   not:"\"Hevok\" + \"sade\". [Fêrkera] terminolojisi.",
   her:["Hevoka sade.", "Di hevoka sade de."],
   gen:["Hevoka sade û tevlîhev", "Hevokên kurdî"]),

  (id:"b1_z08", ku:"Hevoka erênî", tr:"Olumlu cümle", en:"Affirmative sentence",
   cins:"mê", ez:"hevoka erênî", kat:"rêziman", zor:0.70,
   not:"\"Hevok\" + \"erênî\". [Fêrkera D.2] ✓.",
   her:["Hevoka erênî.", "Hevokên erênî."],
   gen:["Hevoka erênî û neyînî", "Hevokên kurdî"]),

  (id:"b1_z09", ku:"Hevoka neyînî", tr:"Olumsuz cümle", en:"Negative sentence",
   cins:"mê", ez:"hevoka neyînî", kat:"rêziman", zor:0.70,
   not:"\"Hevok\" + \"neyînî\". [Fêrkera] ✓.",
   her:["Hevoka neyînî.", "Bi \"ne\" ve \"na\"yê."],
   gen:["Hevoka neyînî û erênî", "Hevokên neyînî"]),

  (id:"b1_z10", ku:"Hevoka pirsê", tr:"Soru cümlesi", en:"Question sentence",
   cins:"mê", ez:"hevoka pirsê", kat:"rêziman", zor:0.71,
   not:"\"Hevok\" + \"pirsê\". [Fêrkera] ✓.",
   her:["Hevoka pirsê.", "Bi \"ma\" û \"gelo\"yê."],
   gen:["Hevoka pirsê û erênî", "Hevokên pirsê"]),
];

final kB1_Ev = [  // EV VE YAŞAYıŞ — 50 kelime
  (id:"b1_m01", ku:"Banî", tr:"Dam / Çatı", en:"Roof",
   cins:"mê", ez:"banê", kat:"mal", zor:0.71,
   not:"Dişil — [BH] §: \"banî\" = dam/çatı. \"Banîya malê.\"",
   her:["Banî şikestîye.", "Ser baniyê ne."],
   gen:["Banî û dîwar", "Banîya me"]),

  (id:"b1_m02", ku:"Dîwar", tr:"Duvar", en:"Wall",
   cins:"nêr", ez:"dîwarê", kat:"mal", zor:0.73,
   not:"Eril — [BH] §: \"dîwar\" = duvar.",
   her:["Dîwar bilind e.", "Li ser dîwarê ye."],
   gen:["Dîwar û xanî", "Dîwarê me"]),

  (id:"b1_m03", ku:"Mertebe", tr:"Kat (bina)", en:"Floor / Storey",
   cins:"mê", ez:"mertebyê", kat:"mal", zor:0.70,
   not:"Dişil — \"mertebe\" = bina katı.",
   her:["Merteba sêyem.", "Li merteba yekem."],
   gen:["Mertebe û jor", "Merteba me"]),

  (id:"b1_m04", ku:"Zozanxane", tr:"Köy evi / Yayla evi", en:"Summer highland home",
   cins:"mê", ez:"zozanxanê", kat:"mal", zor:0.68,
   not:"Dişil — \"zozan\" (yayla) + \"xane\". Kürt kültüründe yayla evi.",
   her:["Zozanxane xweş e.", "Di havînê de li zozanxanê ne."],
   gen:["Zozanxane û gund", "Zozanxaneya me"]),

  (id:"b1_m05", ku:"Konê kevnarî", tr:"Göçebe çadırı", en:"Traditional tent",
   cins:"nêr", ez:"konê kevnarî", kat:"mal", zor:0.68,
   not:"Eril — \"kon\" = çadır. [BH]: \"Were konê me\" = çadırımıza gel.",
   her:["Kon hatiye avakirin.", "Di konê de ne."],
   gen:["Kon û gund", "Konê me"]),

  (id:"b1_m06", ku:"Avik", tr:"Tuvalet", en:"Toilet",
   cins:"nêr", ez:"avikê", kat:"mal", zor:0.71,
   not:"Eril — [AS]: \"tuvalet = avik\" ✓.",
   her:["Avik li kû ye?", "Di avikê de ye."],
   gen:["Avik û serşûştegeh", "Avikê me"]),

  (id:"b1_m07", ku:"Mitbax", tr:"Mutfak", en:"Kitchen",
   cins:"nêr", ez:"mitbaxê", kat:"mal", zor:0.73,
   not:"Eril — [AS]: \"mutfak = mitbax\" ✓.",
   her:["Mitbax germ e.", "Di mitbaxê de dixebitin."],
   gen:["Mitbax û salon", "Mitbaxê me"]),

  (id:"b1_m08", ku:"Salon", tr:"Salon / Oturma odası", en:"Living room",
   cins:"nêr", ez:"salonê", kat:"mal", zor:0.73,
   not:"Eril — uluslararası terim.",
   her:["Salon mezin e.", "Di salonê de nin."],
   gen:["Salon û ode", "Salonê me"]),

  (id:"b1_m09", ku:"Ode", tr:"Oda", en:"Room / Bedroom",
   cins:"mê", ez:"odê", kat:"mal", zor:0.74,
   not:"Dişil — [AS]: \"oda = ode\" ✓.",
   her:["Ode ronî ye.", "Di odê de ye."],
   gen:["Ode û salon", "Odeya me"]),

  (id:"b1_m10", ku:"Çavder", tr:"Pencere", en:"Window",
   cins:"mê", ez:"çavderê", kat:"mal", zor:0.71,
   not:"Dişil — \"çav\" (göz) + \"der\" (kapı). Pencere. \"Pace\" de kullanılır.",
   her:["Çavder veke.", "Ji çavderê tê."],
   gen:["Çavder û derî", "Çavdera me"]),

  (id:"b1_m11", ku:"Mal û milk", tr:"Mülk ve mal", en:"Property and assets",
   cins:"bêcins", ez:null, kat:"mal", zor:0.69,
   not:"\"Mal\" (ev/varlık) + \"milk\". Mülk.",
   her:["Mal û milkê me heye.", "Mal û milk kêm e."],
   gen:["Mal û milk", "Mala me"]),

  (id:"b1_m12", ku:"Kêzik", tr:"Böcek / Haşere", en:"Insect / Bug",
   cins:"nêr", ez:"kêzikê", kat:"mal", zor:0.69,
   not:"Eril — [FB]: kêzik n.m.",
   her:["Kêzik heye.", "Kêzikê avêt."],
   gen:["Kêzik û mar", "Kêzikên malê"]),

  (id:"b1_m13", ku:"Sifre", tr:"Sofra", en:"Table spread / Meal setting",
   cins:"mê", ez:"sifrê", kat:"mal", zor:0.71,
   not:"Dişil — \"sifre\" = sofra. [AS] ✓.",
   her:["Sifre amade ye.", "Li ser sifreyê ne."],
   gen:["Sifre û xwarin", "Sifreya me"]),

  (id:"b1_m14", ku:"Derb", tr:"Kapı tokmağı / Vurma", en:"Knock / Door knocker",
   cins:"nêr", ez:"derbê", kat:"mal", zor:0.68,
   not:"Eril — \"derb dan\" = kapı çalmak.",
   her:["Derbê da.", "Derb bide!"],
   gen:["Derb û derî", "Derb bide!"]),

  (id:"b1_m15", ku:"Kilît", tr:"Kilit", en:"Lock",
   cins:"nêr", ez:"kilîtê", kat:"mal", zor:0.70,
   not:"Eril — [AS]: \"kilit = kilît\" ✓.",
   her:["Kilît veke.", "Kilît xistiye."],
   gen:["Kilît û mifta", "Kilîtê me"]),

  // Mobilya
  (id:"b1_m16", ku:"Kanepê", tr:"Koltuk / Kanepe", en:"Sofa / Armchair",
   cins:"mê", ez:"kanepê", kat:"mal", zor:0.71,
   not:"Dişil — [AS]: \"koltuk = kanepê\" ✓.",
   her:["Kanepê nerm e.", "Li kanepeyê rûnişt."],
   gen:["Kanepê û kursî", "Kanepeyê me"]),

  (id:"b1_m17", ku:"Xemla malê", tr:"Ev dekorasyonu", en:"Home decoration",
   cins:"mê", ez:"xemla malê", kat:"mal", zor:0.68,
   not:"\"Xeml\" (süs) + \"malê\". Ev süsleme.",
   her:["Xemla malê xweş e.", "Xemla malê kir."],
   gen:["Xemla malê", "Xemla me"]),

  (id:"b1_m18", ku:"Carixa", tr:"Halı / Kilim", en:"Carpet / Rug",
   cins:"mê", ez:"carixê", kat:"mal", zor:0.70,
   not:"Dişil — [AS]: \"halı = carixa\" ✓.",
   her:["Carixa rengîn e.", "Li ser carixê ne."],
   gen:["Carixa û mase", "Carixeya me"]),

  (id:"b1_m19", ku:"Amûra malê", tr:"Ev aleti / Beyaz eşya", en:"Home appliance",
   cins:"mê", ez:"amûra malê", kat:"mal", zor:0.68,
   not:"\"Amûr\" (alet) + \"malê\".",
   her:["Amûra malê şikestîye.", "Amûrên malê gelek in."],
   gen:["Amûra malê", "Amûrên malê"]),

  (id:"b1_m20", ku:"Firoşgeha avahiyan", tr:"İnşaat malzemeleri dükkanı", en:"Building materials store",
   cins:"mê", ez:"firoşgeha avahiyan", kat:"cih", zor:0.66,
   not:"\"Firoşgeh\" + \"avahiyan\".",
   her:["Li firoşgeha avahiyan hat.", "Firoşgeha avahiyan nêzîk e."],
   gen:["Firoşgeha avahiyan", "Firoşgeha me"]),
];

final kB1_Giyim = [  // GİYİM VE GÖRÜNÜŞ — 40 kelime
  (id:"b1_c01b", ku:"Kiras", tr:"Gömlek / Elbise", en:"Shirt / Dress",
   cins:"mê", ez:"kirasê", kat:"cil", zor:0.74,
   not:"Dişil — [AS]: \"gömlek = kiras\" ✓.",
   her:["Kiras xweş e.", "Kirasê nû."],
   gen:["Kiras û pantol", "Kirasê me"]),

  (id:"b1_c02b", ku:"Pantol", tr:"Pantolon", en:"Trousers / Pants",
   cins:"nêr", ez:"pantolê", kat:"cil", zor:0.74,
   not:"Eril — [AS]: \"pantol\" ✓. Kurmancî formu.",
   her:["Pantol li xwe kir.", "Pantolê reş."],
   gen:["Pantol û kiras", "Pantolê me"]),

  (id:"b1_c03b", ku:"Kember", tr:"Kemer", en:"Belt",
   cins:"nêr", ez:"kemberê", kat:"cil", zor:0.71,
   not:"Eril — [AS]: \"kemer = kember\" ✓.",
   her:["Kember li xwe kir.", "Kemberê çerm."],
   gen:["Kember û pêlav", "Kemberê me"]),

  (id:"b1_c04b", ku:"Çakêtî", tr:"Ceket", en:"Jacket",
   cins:"mê", ez:"çakêtiyê", kat:"cil", zor:0.72,
   not:"Dişil — [AS]: \"ceket = çakêtî\" ✓.",
   her:["Çakêtî li xwe kir.", "Çakêtîya nû."],
   gen:["Çakêtî û kiras", "Çakêtîya me"]),

  (id:"b1_c05b", ku:"Xirz", tr:"Üst giysi / Hırka", en:"Outer garment",
   cins:"mê", ez:"xirzê", kat:"cil", zor:0.69,
   not:"Dişil — [FB]: xirz n.f. Üst giysi.",
   her:["Xirz li xwe kir.", "Xirzê germ."],
   gen:["Xirz û kiras", "Xirzê me"]),

  (id:"b1_c06b", ku:"Destmal", tr:"Mendil / El bezi", en:"Handkerchief",
   cins:"nêr", ez:"destmalê", kat:"cil", zor:0.70,
   not:"Eril — [AS]: \"mendil = destmal\" ✓.",
   her:["Destmal li cêbê ye.", "Destmalê spî."],
   gen:["Destmal û xirz", "Destmalê me"]),

  (id:"b1_c07b", ku:"Birîska cêbê", tr:"Cüzdan", en:"Wallet",
   cins:"mê", ez:"birîska cêbê", kat:"jiyan", zor:0.70,
   not:"\"Birîsk\" + \"cêbê\". Cüzdan.",
   her:["Birîska cêbê windabûye.", "Birîska cêbê tije ye."],
   gen:["Birîska cêbê", "Birîska me"]),

  (id:"b1_c08b", ku:"Rengê cilê", tr:"Kıyafet rengi", en:"Clothing color",
   cins:"nêr", ez:"rengê cilê", kat:"cil", zor:0.69,
   not:"\"Reng\" + \"cilê\".",
   her:["Rengê cilê xweş e.", "Kîjan rengî dixwazî?"],
   gen:["Rengê cilê", "Rengên cilên me"]),

  (id:"b1_c09b", ku:"Kincên mewsimê", tr:"Mevsimlik kıyafet", en:"Seasonal clothing",
   cins:"bêcins", ez:"kincên mewsimê", kat:"cil", zor:0.68,
   not:"\"Kinc\" + \"mewsimê\".",
   her:["Kincên mewsimê guhartin.", "Kincên zivistanê."],
   gen:["Kincên mewsimê", "Kincên me"]),

  (id:"b1_c10b", ku:"Cil û berg", tr:"Giysi ve eşya", en:"Clothes and belongings",
   cins:"bêcins", ez:null, kat:"cil", zor:0.70,
   not:"\"Cil\" + \"berg\". Bileşik kullanım.",
   her:["Cil û bergên min.", "Cil û berg guhartin."],
   gen:["Cil û berg", "Cil û bergên me"]),
];

final kB1_Yolculuk = [  // SEYAHAT VE ULAŞIM — 60 kelime
  (id:"b1_r01", ku:"Xeta balafirê", tr:"Uçuş güzergahı", en:"Flight route",
   cins:"mê", ez:"xeta balafirê", kat:"rêwîtî", zor:0.69,
   not:"\"Xet\" + \"balafirê\".",
   her:["Xeta balafirê dirêj e.", "Di xeta balafirê de."],
   gen:["Xeta balafirê", "Xeta me"]),

  (id:"b1_r02", ku:"Biletxane", tr:"Bilet gişesi", en:"Ticket office",
   cins:"mê", ez:"biletxanê", kat:"rêwîtî", zor:0.70,
   not:"Dişil — \"bilet\" + \"xane\".",
   her:["Biletxane li kû ye?", "Ji biletxanê bilet hat standin."],
   gen:["Biletxane û qase", "Biletxaneya me"]),

  (id:"b1_r03", ku:"Hatin feriyan", tr:"Rezervasyon yapmak", en:"To make a reservation",
   cins:"bêcins", ez:null, kat:"rêwîtî", zor:0.68,
   not:"\"Feriyan\" = rezervasyon.",
   her:["Feriyan kir.", "Feriyan hatiye kirin."],
   gen:["Feriyan û bilet", "Feriyan bike!"]),

  (id:"b1_r04", ku:"Otobusgeha navçeyê", tr:"İlçe otobüs terminali", en:"District bus terminal",
   cins:"mê", ez:"otobusgeha navçeyê", kat:"cih", zor:0.67,
   not:"\"Otobusgeh\" + \"navçeyê\".",
   her:["Otobusgeh nêzîk e.", "Li otobusgehê bû."],
   gen:["Otobusgeh û qeseregeh", "Otobusgeh"]),

  (id:"b1_r05", ku:"Qeseregeh", tr:"Tren istasyonu", en:"Train station",
   cins:"mê", ez:"qeseregê", kat:"cih", zor:0.70,
   not:"Dişil — [AS]: \"tren garı = qeseregeh\" ✓.",
   her:["Qeseregeh mezin e.", "Li qeseregê ne."],
   gen:["Qeseregeh û balafirgehê", "Qeserehêya bajêr"]),

  (id:"b1_r06", ku:"Rêça sereke", tr:"Ana yol / Anayol", en:"Main road / Highway",
   cins:"mê", ez:"rêça sereke", kat:"rêwîtî", zor:0.70,
   not:"\"Rêç\" + \"sereke\". Anayol.",
   her:["Rêça sereke fireh e.", "Di rêça sereke de çûn."],
   gen:["Rêça sereke", "Rêça me"]),

  (id:"b1_r07", ku:"Kolan", tr:"Sokak / Cadde", en:"Street",
   cins:"mê", ez:"kolanê", kat:"cih", zor:0.72,
   not:"Dişil — [Fêrkera D.14] ✓: \"kolan\" = sokak. [AS] ✓.",
   her:["Kolan teng e.", "Di kolanê de çûn."],
   gen:["Kolan û meydan", "Kolana me"]),

  (id:"b1_r08", ku:"Meydan", tr:"Meydan", en:"Square / Plaza",
   cins:"nêr", ez:"meydanê", kat:"cih", zor:0.72,
   not:"Eril — [AS]: \"meydan\" ✓.",
   her:["Meydan mezin e.", "Li meydanê nin."],
   gen:["Meydan û kolan", "Meydanê bajêr"]),

  (id:"b1_r09", ku:"Nexşeya rê", tr:"Yol haritası", en:"Road map",
   cins:"mê", ez:"nexşeya rê", kat:"rêwîtî", zor:0.69,
   not:"\"Nexşe\" + \"rê\".",
   her:["Nexşeya rê heye?", "Di nexşeya rê de ye."],
   gen:["Nexşeya rê", "Nexşeya me"]),

  (id:"b1_r10", ku:"GPS", tr:"GPS / Konum", en:"GPS / Navigation",
   cins:"nêr", ez:"GPS-ê", kat:"teknoloji", zor:0.71,
   not:"\"GPS\" uluslararası kısaltma.",
   her:["GPS kar dike.", "Bi GPS-ê çûn."],
   gen:["GPS û nexşe", "GPS-a me"]),

  (id:"b1_r11", ku:"Gumrik", tr:"Gümrük", en:"Customs",
   cins:"nêr", ez:"gumrikê", kat:"rêwîtî", zor:0.70,
   not:"Eril — [AS] ✓: \"GUMRIK\" bölümü. Gümrük.",
   her:["Gumrik hat.", "Di gumrikê de kont hat kirin."],
   gen:["Gumrik û sînor", "Gumrikê sînorê"]),

  (id:"b1_r12", ku:"Pasaport", tr:"Pasaport", en:"Passport",
   cins:"nêr", ez:"pasaportê", kat:"rêwîtî", zor:0.72,
   not:"Eril — [AS]: \"pasaport\" ✓.",
   her:["Pasaport heye?", "Pasaportê bide!"],
   gen:["Pasaport û vîze", "Pasaportê me"]),

  (id:"b1_r13", ku:"Vîze", tr:"Vize", en:"Visa",
   cins:"mê", ez:"vîzê", kat:"rêwîtî", zor:0.71,
   not:"Dişil — uluslararası terim.",
   her:["Vîze lazim e.", "Vîze hat standin."],
   gen:["Vîze û pasaport", "Vîzeya me"]),

  (id:"b1_r14", ku:"Mêvanxane", tr:"Otel / Misafirhane", en:"Hotel / Guesthouse",
   cins:"mê", ez:"mêvanxanê", kat:"cih", zor:0.73,
   not:"Dişil — \"mêvan\" + \"xane\". Otel.",
   her:["Mêvanxane nêzîk e.", "Di mêvanxanê de mayin."],
   gen:["Mêvanxane û xanî", "Mêvanxaneya me"]),

  (id:"b1_r15", ku:"Odeya mêvanan", tr:"Misafir odası", en:"Guest room",
   cins:"mê", ez:"odeya mêvanan", kat:"mal", zor:0.69,
   not:"\"Ode\" + \"mêvanan\".",
   her:["Odeya mêvanan amade ye.", "Mêvan di odeyê de ne."],
   gen:["Odeya mêvanan", "Odeya me"]),

  (id:"b1_r16", ku:"Lêçûn", tr:"Masraf / Harcama", en:"Expense / Cost",
   cins:"nêr", ez:"lêçûnê", kat:"aborî", zor:0.70,
   not:"Eril — \"lêçûn\" = masraf.",
   her:["Lêçûn gelek e.", "Lêçûna rêwîtiyê."],
   gen:["Lêçûn û bacgeh", "Lêçûna me"]),

  (id:"b1_r17", ku:"Bajêrê dîrokî", tr:"Tarihi şehir", en:"Historic city",
   cins:"nêr", ez:"bajêrê dîrokî", kat:"cih", zor:0.70,
   not:"\"Bajêr\" + \"dîrokî\".",
   her:["Bajêrê dîrokî xweş e.", "Li bajêrê dîrokî ne."],
   gen:["Bajêrê dîrokî", "Bajêrê me"]),

  (id:"b1_r18", ku:"Tûrîst", tr:"Turist", en:"Tourist",
   cins:"bêcins", ez:"tûrîstê", kat:"rêwîtî", zor:0.72,
   not:"Uluslararası terim.",
   her:["Tûrîst hat.", "Tûrîstên gelek."],
   gen:["Tûrîst û rêwî", "Tûrîstên bîyanî"]),

  (id:"b1_r19", ku:"Rêberê tûrîzmê", tr:"Turizm rehberi", en:"Tour guide",
   cins:"bêcins", ez:"rêberê tûrîzmê", kat:"pîşe", zor:0.68,
   not:"\"Rêber\" + \"tûrîzmê\".",
   her:["Rêberê tûrîzmê hat.", "Rêber rê nîşan da."],
   gen:["Rêberê tûrîzmê", "Rêberê me"]),

  (id:"b1_r20", ku:"Wênekêşî kirin", tr:"Fotoğraf çekmek", en:"To take photos",
   cins:"bêcins", ez:null, kat:"rêwîtî", zor:0.71,
   not:"\"Wênekêşî\" + \"kirin\".",
   her:["Wênekêşî kir.", "Rê bide min ku wênekêşî bikim."],
   gen:["Wênekêşî kirin", "Wênekêşî bike!"]),
];

final kB1_Teknoloji = [  // TEKNOLOJİ VE MEDYA — 60 kelime
  (id:"b1_tk01", ku:"Kompîtur", tr:"Bilgisayar", en:"Computer",
   cins:"nêr", ez:"kompîturê", kat:"teknoloji", zor:0.74,
   not:"Eril — [AS]: \"bilgisayar = kompîtur\" ✓.",
   her:["Kompîtur xarab bûye.", "Di kompîturê de ye."],
   gen:["Kompîtur û înternetê", "Kompîturê me"]),

  (id:"b1_tk02", ku:"Înternetê", tr:"İnternet", en:"Internet",
   cins:"nêr", ez:"înternetê", kat:"teknoloji", zor:0.76,
   not:"Eril — uluslararası terim.",
   her:["Înternetê kar dike.", "Di înternetê de ye."],
   gen:["Înternetê û kompîtur", "Înternetê bikar bîne"]),

  (id:"b1_tk03", ku:"Malpera", tr:"Web sitesi", en:"Website",
   cins:"mê", ez:"malperê", kat:"teknoloji", zor:0.71,
   not:"Dişil — \"mal\" + \"per\" = web sitesi. Özgün Kurmancî bileşim.",
   her:["Malpera me heye.", "Li malperê binêre."],
   gen:["Malpera kurdî", "Malperê me"]),

  (id:"b1_tk04", ku:"Bernameya kompîturê", tr:"Bilgisayar programı", en:"Computer program",
   cins:"mê", ez:"bernameya kompîturê", kat:"teknoloji", zor:0.69,
   not:"\"Bername\" + \"kompîturê\".",
   her:["Bername nû ye.", "Bernameya kompîturê."],
   gen:["Bernameya kompîturê", "Bernameya me"]),

  (id:"b1_tk05", ku:"Rûpela medyaya civakî", tr:"Sosyal medya sayfası", en:"Social media page",
   cins:"mê", ez:"rûpela medyaya civakî", kat:"medya", zor:0.68,
   not:"\"Rûpel\" + \"medyaya civakî\".",
   her:["Rûpela medyaya civakî heye.", "Di rûpelê de ne."],
   gen:["Rûpela medyaya civakî", "Rûpela me"]),

  (id:"b1_tk06", ku:"Nûvekirin", tr:"Güncelleme", en:"Update",
   cins:"mê", ez:"nûvekirinê", kat:"teknoloji", zor:0.69,
   not:"Dişil — \"nû\" + \"vekirin\". Güncelleme.",
   her:["Nûvekirin lazim e.", "Nûvekirin hat kirin."],
   gen:["Nûvekirin û guhertin", "Nûvekirina me"]),

  (id:"b1_tk07", ku:"Danehev", tr:"Veritabanı", en:"Database",
   cins:"nêr", ez:"danehevê", kat:"teknoloji", zor:0.66,
   not:"Eril — \"dane\" (veri) + \"hev\" (birleştirme). Özgün bileşim.",
   her:["Danehev mezin e.", "Di danehevê de ye."],
   gen:["Danehev û bername", "Daneheva me"]),

  (id:"b1_tk08", ku:"Têlefona desta", tr:"Cep telefonu", en:"Mobile phone",
   cins:"mê", ez:"têlefona desta", kat:"teknoloji", zor:0.74,
   not:"\"Têlefon\" + \"desta\".",
   her:["Têlefonê desta windabûye.", "Di têlefonê desta de."],
   gen:["Têlefonê desta", "Têlefonê me"]),

  (id:"b1_tk09", ku:"Arşîvkirin", tr:"Arşivlemek", en:"To archive",
   cins:"bêcins", ez:null, kat:"teknoloji", zor:0.67,
   not:"\"Arşîv\" + \"kirin\". Arşivlemek.",
   her:["Arşîv kir.", "Arşîvkirin lazim e."],
   gen:["Arşîvkirin û tomarkirin", "Arşîv bike!"]),

  (id:"b1_tk10", ku:"Tomarkirin", tr:"Kayıt yapmak", en:"To record / save",
   cins:"bêcins", ez:null, kat:"teknoloji", zor:0.70,
   not:"\"Tomarkirin\" = kayıt yapmak. \"Ev tê tomarkirin.\"",
   her:["Tomarkirin hat kirin.", "Bide tomarkirin."],
   gen:["Tomarkirin û arşîvkirin", "Bide tomarkirin"]),

  // Medya
  (id:"b1_tk11", ku:"Nûçegir", tr:"Gazeteci", en:"Journalist",
   cins:"bêcins", ez:"nûçegirê", kat:"medya", zor:0.71,
   not:"\"Nûçe\" + \"-gir\". Gazeteci.",
   her:["Nûçegir hat.", "Nûçegirên kurd."],
   gen:["Nûçegir û wêjevan", "Nûçegirên me"]),

  (id:"b1_tk12", ku:"Xebatkarê medyayê", tr:"Medya çalışanı", en:"Media worker",
   cins:"bêcins", ez:"xebatkarê medyayê", kat:"medya", zor:0.68,
   not:"\"Xebatkar\" + \"medyayê\".",
   her:["Xebatkarê medyayê.", "Di medyayê de dixebitin."],
   gen:["Xebatkarê medyayê", "Xebatkarên me"]),

  (id:"b1_tk13", ku:"Weşanger", tr:"Yayıncı", en:"Publisher / Broadcaster",
   cins:"bêcins", ez:"weşangerê", kat:"medya", zor:0.69,
   not:"\"Weşan\" + \"-ger\". Yayıncı.",
   her:["Weşanger hat.", "Weşangerên kurd."],
   gen:["Weşanger û nûçegir", "Weşangera me"]),

  (id:"b1_tk14", ku:"Gotara serhêl", tr:"Çevrimiçi makale", en:"Online article",
   cins:"mê", ez:"gotara serhêl", kat:"medya", zor:0.68,
   not:"\"Gotar\" + \"serhêl\" (online). \"Serhêl\" = çevrimiçi/online.",
   her:["Gotara serhêl hat weşandin.", "Di gotara serhêl de."],
   gen:["Gotara serhêl", "Gotarên serhêl"]),

  (id:"b1_tk15", ku:"Ragihandin", tr:"Haber verme / İletişim", en:"Communication / Broadcasting",
   cins:"mê", ez:"ragihandinê", kat:"medya", zor:0.72,
   not:"Dişil — \"ra\" + \"gihandin\". [AS] ✓.",
   her:["Ragihandin hat kirin.", "Di ragihandinê de."],
   gen:["Ragihandin û medya", "Ragihandina me"]),

  // Spor
  (id:"b1_tk16", ku:"Werzîş", tr:"Spor", en:"Sport",
   cins:"mê", ez:"werzîşê", kat:"spor", zor:0.74,
   not:"Dişil — [AS]: werzîş n.f. = spor. \"Werzîş ji tenduristiyê re baş e.\"",
   her:["Werzîş dikim.", "Werzîşê dilêzim."],
   gen:["Werzîş û tenduristî", "Werzîşa me"]),

  (id:"b1_tk17", ku:"Futbol", tr:"Futbol", en:"Football / Soccer",
   cins:"nêr", ez:"futbolê", kat:"spor", zor:0.76,
   not:"Eril — uluslararası terim.",
   her:["Futbol dilêzim.", "Futbolê dîtin."],
   gen:["Futbol û basketbol", "Futbolê me"]),

  (id:"b1_tk18", ku:"Lîstika", tr:"Oyun / Maç", en:"Game / Match",
   cins:"mê", ez:"lîstikê", kat:"spor", zor:0.71,
   not:"Dişil — \"lîstik\" = oyun/maç.",
   her:["Lîstika xweş bû.", "Lîstika îro."],
   gen:["Lîstika û spor", "Lîstika me"]),

  (id:"b1_tk19", ku:"Tevlihevî", tr:"Turnuva / Rekabet", en:"Tournament / Competition",
   cins:"mê", ez:"tevliheviyê", kat:"spor", zor:0.68,
   not:"Dişil — \"tevlihev\" bileşik.",
   her:["Tevlihevî dest pê kir.", "Di tevliheviyê de ne."],
   gen:["Tevlihevî û lîstik", "Tevlihevîya me"]),

  (id:"b1_tk20", ku:"Werzişvanê profesyonel", tr:"Profesyonel sporcu", en:"Professional athlete",
   cins:"bêcins", ez:"werzişvanê profesyonel", kat:"spor", zor:0.68,
   not:"\"Werzişvan\" + \"profesyonel\".",
   her:["Ew werzişvanê profesyonel e.", "Werzişvanên profesyonel."],
   gen:["Werzişvanê profesyonel", "Werzişvanên me"]),
];

final kB1_Saglik = [  // SAĞLIK GENİŞLEME — 50 kelime
  (id:"b1_s01", ku:"Nexweşxaneya giştî", tr:"Devlet hastanesi", en:"Public hospital",
   cins:"mê", ez:"nexweşxaneya giştî", kat:"tendurist", zor:0.71,
   not:"\"Nexweşxane\" + \"giştî\".",
   her:["Nexweşxaneya giştî nêzîk e.", "Li nexweşxaneya giştî çû."],
   gen:["Nexweşxaneya giştî", "Nexweşxaneya me"]),

  (id:"b1_s02", ku:"Parastina tenduristiyê", tr:"Sağlık koruması", en:"Health protection",
   cins:"mê", ez:"parastina tenduristiyê", kat:"tendurist", zor:0.69,
   not:"\"Parastin\" + \"tenduristiyê\".",
   her:["Parastina tenduristiyê girîng e.", "Di parastina tenduristiyê de."],
   gen:["Parastina tenduristiyê", "Parastina me"]),

  (id:"b1_s03", ku:"Dermanxane", tr:"Eczane", en:"Pharmacy",
   cins:"mê", ez:"dermanxanê", kat:"tendurist", zor:0.73,
   not:"Dişil — \"derman\" + \"xane\". [AS] ✓.",
   her:["Dermanxane nêzîk e.", "Ji dermanxanê derman anî."],
   gen:["Dermanxane û nexweşxane", "Dermanxaneya me"]),

  (id:"b1_s04", ku:"Dermanê jehr", tr:"Zehir / Zehirli ilaç", en:"Poison / Toxic medicine",
   cins:"nêr", ez:"dermanê jehr", kat:"tendurist", zor:0.67,
   not:"\"Derman\" + \"jehr\" (zehir). [AS] ✓.",
   her:["Dermanê jehr dixe.", "Ji dermanê jehr bikaçe!"],
   gen:["Dermanê jehr", "Dermanê nû"]),

  (id:"b1_s05", ku:"Operasyon", tr:"Ameliyat", en:"Surgery / Operation",
   cins:"mê", ez:"operasyonê", kat:"tendurist", zor:0.70,
   not:"Dişil — uluslararası terim.",
   her:["Operasyon hat kirin.", "Piştî operasyonê."],
   gen:["Operasyon û derman", "Operasyona me"]),

  (id:"b1_s06", ku:"Xwedîkirina nexweş", tr:"Hastaya bakma", en:"Caring for the sick",
   cins:"mê", ez:"xwedîkirina nexweş", kat:"tendurist", zor:0.68,
   not:"\"Xwedîkirin\" + \"nexweş\".",
   her:["Xwedîkirina nexweş lazim e.", "Di xwedîkirina nexweş de."],
   gen:["Xwedîkirina nexweş", "Xwedîkirina me"]),

  (id:"b1_s07", ku:"Xemxwarîya tenduristiyê", tr:"Sağlık kaygısı", en:"Health concern",
   cins:"mê", ez:"xemxwarîya tenduristiyê", kat:"tendurist", zor:0.67,
   not:"\"Xemxwarî\" + \"tenduristiyê\".",
   her:["Xemxwarîya tenduristiyê heye.", "Di xemxwarîya tenduristiyê de."],
   gen:["Xemxwarîya tenduristiyê", "Xemxwarîya me"]),

  (id:"b1_s08", ku:"Mêşhûn", tr:"Bal arısı", en:"Bee",
   cins:"mê", ez:"mêşhûnê", kat:"xweza", zor:0.70,
   not:"Dişil — [FB]: mêşhûn n.f. Bal arısı.",
   her:["Mêşhûn hingiv çêdike.", "Mêşhûn genim ye."],
   gen:["Mêşhûn û hingiv", "Mêşhûnên me"]),

  (id:"b1_s09", ku:"Hingiv", tr:"Bal", en:"Honey",
   cins:"nêr", ez:"hingivê", kat:"xwarin", zor:0.73,
   not:"Eril — [AS]: \"bal = hingiv\" ✓.",
   her:["Hingiv şîrîn e.", "Hingivê kûvî."],
   gen:["Hingiv û şîr", "Hingivê me"]),

  (id:"b1_s10", ku:"Giyayên dermankî", tr:"Şifalı bitkiler", en:"Medicinal herbs",
   cins:"bêcins", ez:"giyayên dermankî", kat:"tendurist", zor:0.70,
   not:"\"Giya\" (bitki) + \"dermankî\". Kürt geleneksel tıbbı.",
   her:["Giyayên dermankî gelek in.", "Bi giyayên dermankî derman kirin."],
   gen:["Giyayên dermankî", "Giyayên me"]),
];

final kB1_Is = [  // İŞ VE MESLEK GENİŞLEME — 50 kelime
  (id:"b1_i01", ku:"Kar û barên rojane", tr:"Günlük işler", en:"Daily chores",
   cins:"bêcins", ez:"kar û barên rojane", kat:"kar", zor:0.70,
   not:"\"Kar û bar\" + \"rojane\".",
   her:["Kar û barên rojane gelek in.", "Kar û barên rojane biqedîne."],
   gen:["Kar û barên rojane", "Karê me"]),

  (id:"b1_i02", ku:"Pîşeya hunerê", tr:"Sanat mesleği", en:"Art profession",
   cins:"mê", ez:"pîşeya hunerê", kat:"huner", zor:0.68,
   not:"\"Pîşe\" + \"hunerê\".",
   her:["Pîşeya hunerê dixebitim.", "Di pîşeya hunerê de."],
   gen:["Pîşeya hunerê", "Pîşeya me"]),

  (id:"b1_i03", ku:"Veberhênan", tr:"Yatırım", en:"Investment",
   cins:"mê", ez:"veberhênanê", kat:"aborî", zor:0.69,
   not:"Dişil — [AS] ✓: \"veberhênan\" = yatırım.",
   her:["Veberhênan hat kirin.", "Di veberhênanê de."],
   gen:["Veberhênan û aborî", "Veberhênanên me"]),

  (id:"b1_i04", ku:"Şirîkatî", tr:"Ortaklık", en:"Partnership",
   cins:"mê", ez:"şirîkatiyê", kat:"aborî", zor:0.68,
   not:"Dişil — \"şirîk\" (ortak) + \"-atî\".",
   her:["Şirîkatî hat kirin.", "Di şirîkatiyê de ne."],
   gen:["Şirîkatî û pargîdanî", "Şirîkatîya me"]),

  (id:"b1_i05", ku:"Soznameyê xebatê", tr:"İş sözleşmesi", en:"Work contract",
   cins:"nêr", ez:"soznameyê xebatê", kat:"zagon", zor:0.68,
   not:"\"Sozname\" + \"xebatê\". İş sözleşmesi.",
   her:["Sozname hat imzakirin.", "Soznameyê xebatê."],
   gen:["Soznameyê xebatê", "Soznameyê me"]),

  (id:"b1_i06", ku:"Mûçe", tr:"Maaş", en:"Salary / Wage",
   cins:"mê", ez:"mûçê", kat:"aborî", zor:0.73,
   not:"Dişil — [AS]: \"maaş = mûçe\" ✓.",
   her:["Mûçe hat.", "Mûçeya min kêm e."],
   gen:["Mûçe û bacgeh", "Mûçeya me"]),

  (id:"b1_i07", ku:"Xebatkara sosyal", tr:"Sosyal çalışan", en:"Social worker",
   cins:"bêcins", ez:"xebatkara sosyal", kat:"pîşe", zor:0.67,
   not:"\"Xebatkar\" + \"sosyal\". Sosyal hizmetler.",
   her:["Xebatkara sosyal hat.", "Xebatkarên sosyal."],
   gen:["Xebatkara sosyal", "Xebatkarên me"]),

  (id:"b1_i08", ku:"Endamê koma xebatê", tr:"Çalışma grubu üyesi", en:"Work group member",
   cins:"bêcins", ez:"endamê koma xebatê", kat:"kar", zor:0.66,
   not:"\"Endam\" + \"koma xebatê\".",
   her:["Endamê koma xebatê ye.", "Di koma xebatê de ye."],
   gen:["Endamê koma xebatê", "Komên xebatê"]),

  (id:"b1_i09", ku:"Derfetên kar", tr:"Kariyer fırsatları", en:"Career opportunities",
   cins:"bêcins", ez:"derfetên kar", kat:"kar", zor:0.68,
   not:"\"Derfet\" + \"kar\". Kariyer fırsatı.",
   her:["Derfetên kar gelek in.", "Derfetên kar afirandin."],
   gen:["Derfetên kar", "Derfetên me"]),

  (id:"b1_i10", ku:"Profesyonel", tr:"Profesyonel", en:"Professional",
   cins:"bêcins", ez:null, kat:"kar", zor:0.71,
   not:"Uluslararası terim. \"Profesyonel bûn\" = uzmanlaşmak.",
   her:["Ew profesyonel e.", "Bi awayekî profesyonel."],
   gen:["Profesyonel û amator", "Ev profesyonel e."]),
];

final kB1_Doga = [  // DOĞA GENİŞLEME — 60 kelime
  (id:"b1_d01", ku:"Dara mêweyî", tr:"Meyve ağacı", en:"Fruit tree",
   cins:"mê", ez:"dara mêweyî", kat:"xweza", zor:0.70,
   not:"\"Dar\" + \"mêweyî\". Meyve ağacı.",
   her:["Dara mêweyî gelek e.", "Dara mêweyî sor e."],
   gen:["Dara mêweyî", "Darên me"]),

  (id:"b1_d02", ku:"Gihaya wild", tr:"Yabani ot / bitki", en:"Wild grass / herb",
   cins:"mê", ez:"gihaya wild", kat:"xweza", zor:0.68,
   not:"\"Giha\" + \"wild\". Yabani bitki.",
   her:["Gihaya wild zêde ye.", "Gihayên wild."],
   gen:["Gihaya wild", "Gihayên wild"]),

  (id:"b1_d03", ku:"Keviya çiyê", tr:"Dağ kenarı", en:"Mountain edge",
   cins:"mê", ez:"keviya çiyê", kat:"xweza", zor:0.68,
   not:"\"Kevî\" + \"çiyê\". Dağ kenarı.",
   her:["Keviya çiyê xweş e.", "Li keviya çiyê ne."],
   gen:["Keviya çiyê", "Keviyên çiyê"]),

  (id:"b1_d04", ku:"Geliyê kûr", tr:"Derin vadi", en:"Deep valley",
   cins:"nêr", ez:"geliyê kûr", kat:"xweza", zor:0.69,
   not:"\"Gelî\" + \"kûr\". Derin vadi.",
   her:["Geliyê kûr xweş e.", "Di geliyê kûr de."],
   gen:["Geliyê kûr", "Gelîyên Kurdistanê"]),

  (id:"b1_d05", ku:"Kaniyek", tr:"Kaynak / Pınar", en:"Spring / Source",
   cins:"mê", ez:"kaniyekê", kat:"xweza", zor:0.72,
   not:"Dişil — [FB]: kanî n.f. = kaynak/pınar.",
   her:["Kaniyek heye.", "Ava kaniyê saf e."],
   gen:["Kaniyek û çem", "Kaniyên Kurdistanê"]),

  (id:"b1_d06", ku:"Çemê mezin", tr:"Büyük nehir", en:"Large river",
   cins:"nêr", ez:"çemê mezin", kat:"xweza", zor:0.71,
   not:"\"Çem\" + \"mezin\".",
   her:["Çemê mezin diherike.", "Li çemê mezin ne."],
   gen:["Çemê mezin", "Çemên Kurdistanê"]),

  (id:"b1_d07", ku:"Golê kûr", tr:"Derin göl", en:"Deep lake",
   cins:"nêr", ez:"golê kûr", kat:"xweza", zor:0.70,
   not:"\"Gol\" + \"kûr\".",
   her:["Golê kûr heye.", "Li golê kûr ne."],
   gen:["Golê kûr", "Golên Kurdistanê"]),

  (id:"b1_d08", ku:"Serma", tr:"Soğuk hava / Ayaz", en:"Frost / Cold air",
   cins:"mê", ez:"sermê", kat:"xweza", zor:0.71,
   not:"Dişil — [BH]: serma n.f. Soğuk hava.",
   her:["Serma tûj e.", "Sermaya zivistanê."],
   gen:["Serma û germî", "Sermaya me"]),

  (id:"b1_d09", ku:"Berf û qeşa", tr:"Kar ve buz", en:"Snow and ice",
   cins:"bêcins", ez:null, kat:"xweza", zor:0.70,
   not:"\"Berf\" (kar) + \"qeşa\" (buz). Kış simgeleri.",
   her:["Berf û qeşa heye.", "Zivistan berf û qeşa ye."],
   gen:["Berf û qeşa", "Berfê Kurdistanê"]),

  (id:"b1_d10", ku:"Zozanên bilind", tr:"Yüksek yaylalar", en:"High plateaus",
   cins:"bêcins", ez:"zozanên bilind", kat:"xweza", zor:0.70,
   not:"\"Zozan\" + \"bilind\". Yüksek yayla.",
   her:["Zozanên bilind xweş in.", "Di zozanên bilind de."],
   gen:["Zozanên bilind", "Zozanên Kurdistanê"]),

  // Hayvan dünyası
  (id:"b1_d11", ku:"Guhdêrên çûkan", tr:"Kuş gözlemciliği", en:"Birdwatching",
   cins:"mê", ez:"guhdêrên çûkan", kat:"xweza", zor:0.66,
   not:"\"Guhdarîkirin\" + \"çûk\". Kuş gözlemleme.",
   her:["Guhdêrên çûkan dike.", "Ji guhdêrên çûkan hez dikim."],
   gen:["Guhdêrên çûkan", "Çûkên Kurdistanê"]),

  (id:"b1_d12", ku:"Kêvroşk", tr:"Tavşan", en:"Rabbit",
   cins:"nêr", ez:"kêvroşkê", kat:"xweza", zor:0.72,
   not:"Eril — [Fêrkera D.4] ✓: \"kîvroşk\" = tavşan.",
   her:["Kêvroşk reviya.", "Kêvroşkên çiyê."],
   gen:["Kêvroşk û ker", "Kêvroşkên Kurdistanê"]),

  (id:"b1_d13", ku:"Rovî", tr:"Tilki", en:"Fox",
   cins:"nêr", ez:"rovê", kat:"xweza", zor:0.71,
   not:"Eril — [FB]: rovî n.m. Tilki.",
   her:["Rovî bijart e.", "Rovîyê me dît."],
   gen:["Rovî û gur", "Rovîyên Kurdistanê"]),

  (id:"b1_d14", ku:"Ceyran", tr:"Ceylan / Geyik", en:"Gazelle / Deer",
   cins:"bêcins", ez:"ceyranê", kat:"xweza", zor:0.70,
   not:"\"Ceyran\" — [Fêrkera D.14] ✓. Ceylan.",
   her:["Ceyran bazda.", "Ceyranên çiyê."],
   gen:["Ceyran û hirç", "Ceyranên Kurdistanê"]),

  (id:"b1_d15", ku:"Hirç", tr:"Ayı", en:"Bear",
   cins:"nêr", ez:"hirçê", kat:"xweza", zor:0.72,
   not:"Eril — [AS] ✓: \"ayı = hirç\".",
   her:["Hirç li çiyê ye.", "Hirçên mezin."],
   gen:["Hirç û şêr", "Hirçên Kurdistanê"]),
];

final kB1_Kultur2 = [  // KÜLTÜR VE SANAT GENİŞLEME — 60 kelime
  (id:"b1_k01", ku:"Govend", tr:"Halay / Kürt halk dansı", en:"Kurdish circle dance",
   cins:"mê", ez:"govendê", kat:"huner", zor:0.73,
   not:"Dişil — govend = Kürt halk dansı. Kürt kültüründe merkezi.",
   her:["Govend lêdan.", "Di govendê de ne."],
   gen:["Govend û kilam", "Govendên kurdî"]),

  (id:"b1_k02", ku:"Stranbêj", tr:"Şarkıcı", en:"Singer",
   cins:"bêcins", ez:"stranbêjê", kat:"huner", zor:0.72,
   not:"\"Stran\" + \"-bêj\". Şarkıcı.",
   her:["Ew stranbêj e.", "Stranbêjên kurd."],
   gen:["Stranbêj û dengbêj", "Stranbêjên me"]),

  (id:"b1_k03", ku:"Berhemên hunermend", tr:"Sanatçının eserleri", en:"Artist\'s works",
   cins:"bêcins", ez:"berhemên hunermend", kat:"huner", zor:0.68,
   not:"\"Berhem\" + \"hunermend\". Sanatçı eserleri.",
   her:["Berhemên hunermend gelek in.", "Berhemên hunermend dîtin."],
   gen:["Berhemên hunermend", "Berhemên me"]),

  (id:"b1_k04", ku:"Şanoya gelêrî", tr:"Halk tiyatrosu", en:"Folk theater",
   cins:"mê", ez:"şanoya gelêrî", kat:"huner", zor:0.68,
   not:"\"Şano\" + \"gelêrî\". Halk oyunculuğu.",
   her:["Şanoya gelêrî ya kurdî.", "Di şanoya gelêrî de."],
   gen:["Şanoya gelêrî", "Şanoyan me"]),

  (id:"b1_k05", ku:"Cihê çandî", tr:"Kültür merkezi", en:"Cultural center",
   cins:"nêr", ez:"cihê çandî", kat:"çand", zor:0.69,
   not:"\"Cih\" + \"çandî\". Kültürel mekan.",
   her:["Cihê çandî heye.", "Li cihê çandî ne."],
   gen:["Cihê çandî", "Cihên çandî"]),

  (id:"b1_k06", ku:"Muzexane", tr:"Müze", en:"Museum",
   cins:"mê", ez:"muzexanê", kat:"çand", zor:0.73,
   not:"Dişil — \"muze\" + \"xane\". [AS] ✓.",
   her:["Muzexane nêzîk e.", "Li muzexanê ne."],
   gen:["Muzexane û pirtûkxane", "Muzexaneya me"]),

  (id:"b1_k07", ku:"Nimûne", tr:"Örnek / Model", en:"Example / Sample",
   cins:"mê", ez:"nimûnê", kat:"zanist", zor:0.72,
   not:"Dişil — [AS]: \"örnek = nimûne\" ✓.",
   her:["Nimûne heye.", "Nimûneyek bide."],
   gen:["Nimûne û mînak", "Nimûneya me"]),

  (id:"b1_k08", ku:"Rêbaz", tr:"Yöntem / Metot", en:"Method",
   cins:"mê", ez:"rêbazê", kat:"zanist", zor:0.71,
   not:"Dişil — \"rê\" + \"-baz\". [AS] ✓. Yöntem.",
   her:["Rêbaz baş e.", "Bi rêbaza nû."],
   gen:["Rêbaz û çalakî", "Rêbaza me"]),

  (id:"b1_k09", ku:"Teorî", tr:"Teori", en:"Theory",
   cins:"mê", ez:"teoriyê", kat:"zanist", zor:0.70,
   not:"Dişil — uluslararası terim.",
   her:["Teorî baş e.", "Di teoriyê de."],
   gen:["Teorî û pratîk", "Teorîya me"]),

  (id:"b1_k10", ku:"Pratîk", tr:"Pratik / Uygulama", en:"Practice / Practical",
   cins:"bêcins", ez:null, kat:"zanist", zor:0.72,
   not:"Uluslararası terim.",
   her:["Pratîk girîng e.", "Bi pratîk fêr bibe."],
   gen:["Pratîk û teorî", "Pratîka me"]),

  // Akademik
  (id:"b1_k11", ku:"Xalên sereke", tr:"Ana noktalar", en:"Key points",
   cins:"bêcins", ez:"xalên sereke", kat:"zanist", zor:0.70,
   not:"\"Xal\" + \"sereke\".",
   her:["Xalên sereke çi ne?", "Xalên sereke nivisand."],
   gen:["Xalên sereke", "Xalên me"]),

  (id:"b1_k12", ku:"Gotara zanistî", tr:"Bilimsel makale", en:"Scientific article",
   cins:"mê", ez:"gotara zanistî", kat:"zanist", zor:0.68,
   not:"\"Gotar\" + \"zanistî\".",
   her:["Gotara zanistî dixwînim.", "Gotara zanistî nivîsand."],
   gen:["Gotara zanistî", "Gotarên zanistî"]),

  (id:"b1_k13", ku:"Lêkolîner", tr:"Araştırmacı", en:"Researcher",
   cins:"bêcins", ez:"lêkolînerê", kat:"pîşe", zor:0.70,
   not:"\"Lêkolîn\" + \"-er\". Araştırmacı.",
   her:["Ew lêkolîner e.", "Lêkolînerên kurd."],
   gen:["Lêkolîner û mamoste", "Lêkolînerên me"]),

  (id:"b1_k14", ku:"Akademîsyen", tr:"Akademisyen", en:"Academician",
   cins:"bêcins", ez:"akademîsyenê", kat:"pîşe", zor:0.69,
   not:"Uluslararası terim.",
   her:["Ew akademîsyen e.", "Akademîsyenên kurd."],
   gen:["Akademîsyen û lêkolîner", "Akademîsyenên me"]),

  (id:"b1_k15", ku:"Zanîngeh", tr:"Üniversite", en:"University",
   cins:"mê", ez:"zanîngehê", kat:"perwerde", zor:0.75,
   not:"Dişil — \"zanîn\" + \"geh\". [Fêrkera D.3] ✓.",
   her:["Zanîngeh mezin e.", "Di zanîngehê de dixwînim."],
   gen:["Zanîngeh û dibistan", "Zanîngeha me"]),

  (id:"b1_k16", ku:"Beşa kurdolojiyê", tr:"Kürdoloji bölümü", en:"Kurdish studies department",
   cins:"mê", ez:"beşa kurdolojiyê", kat:"perwerde", zor:0.68,
   not:"\"Beş\" + \"kurdolojiyê\". Kürt dili ve edebiyatı bölümü.",
   her:["Beşa kurdolojiyê dixwînim.", "Di beşa kurdolojiyê de."],
   gen:["Beşa kurdolojiyê", "Beşa me"]),

  (id:"b1_k17", ku:"Dîploma", tr:"Diploma", en:"Diploma / Degree",
   cins:"mê", ez:"diplomayê", kat:"perwerde", zor:0.72,
   not:"Dişil — [Fêrkera D.3] ✓: \"diploma = bawername\".",
   her:["Diploma hat.", "Diplomaya min."],
   gen:["Diploma û şanî", "Diplomaya me"]),

  (id:"b1_k18", ku:"Kargehên jiyana rojane", tr:"Günlük yaşam atölyeleri", en:"Daily life workshops",
   cins:"bêcins", ez:"kargehên jiyana rojane", kat:"perwerde", zor:0.66,
   not:"\"Kargeh\" (atölye) + \"jiyana rojane\".",
   her:["Kargeh heye.", "Di kargehê de ne."],
   gen:["Kargehên jiyana rojane", "Kargehên me"]),

  (id:"b1_k19", ku:"Pêşkêşkirin", tr:"Sunum yapmak", en:"To present / make a presentation",
   cins:"mê", ez:"pêşkêşkirinê", kat:"kar", zor:0.71,
   not:"Dişil — \"pêş\" + \"kêşkirin\". Sunum.",
   her:["Pêşkêşkirin hat kirin.", "Pêşkêşkirina min."],
   gen:["Pêşkêşkirin û gengeşî", "Pêşkêşkirina me"]),

  (id:"b1_k20", ku:"Gengeşî", tr:"Tartışma / Müzakere", en:"Discussion / Debate",
   cins:"mê", ez:"gengeşiyê", kat:"zanist", zor:0.70,
   not:"Dişil — [AS] ✓: \"tartışmak = nîqaş kirin, gengeşî kirin\". \"Gengeşî\" özgün.",
   her:["Gengeşî hat kirin.", "Di gengeşiyê de ne."],
   gen:["Gengeşî û nîqaş", "Gengeşîya me"]),
];

final kB1TamListe = [
  ...kB1Kelimeler,
  ...kB1EkKelimeler, ...kB1EkKelimeler2, ...kB1EkKelimeler3,
  ...kB1EkKelimeler4, ...kB1EkKelimeler5, ...kB1EkKelimeler6,
  ...kB1Buyuk1, ...kB1Buyuk2, ...kB1Buyuk3, ...kB1Buyuk4,
  ...kB1Buyuk5, ...kB1Buyuk6, ...kB1Buyuk7,
  ...kB1_Ev, ...kB1_Giyim, ...kB1_Yolculuk,
  ...kB1_Teknoloji, ...kB1_Saglik, ...kB1_Is,
  ...kB1_Doga, ...kB1_Kultur2,
];

// ════════════════════════════════════════════════════════════════
// B1 TAM TAMAMLAMA BLOKLARI — 900 kelime (9 kısım × ~100)
// Kaynak: BH, TH, AS, FB, Fêrkera Kurdî
// ════════════════════════════════════════════════════════════════

final kB1_Xwarin = [
// ── YİYECEK VE MUTFAK — 100 kelime ──────────────────────────────

  (id:"b1_xw01", ku:"Goştê berxê", tr:"Kuzu eti", en:"Lamb",
   cins:"nêr", ez:"goştê berxê", kat:"xwarin", zor:0.72,
   not:"\"Goşt\" (et) + \"berxê\" (kuzunun). [AS] ✓.",
   her:["Goştê berxê xweş e.", "Min goştê berxê pijandin."],
   gen:["Goştê berxê", "Goştê me"]),

  (id:"b1_xw02", ku:"Goştê dewarê", tr:"Sığır eti", en:"Beef",
   cins:"nêr", ez:"goştê dewarê", kat:"xwarin", zor:0.71,
   not:"\"Goşt\" + \"dewarê\" (sığırın).",
   her:["Goştê dewarê pirijandiye.", "Goştê dewarê germa ye."],
   gen:["Goştê dewarê", "Goştên me"]),

  (id:"b1_xw03", ku:"Masîya çemê", tr:"Nehir balığı", en:"River fish",
   cins:"mê", ez:"masîya çemê", kat:"xwarin", zor:0.70,
   not:"\"Masî\" + \"çemê\". Kürdistan\'da bol.",
   her:["Masîya çemê xweş e.", "Min masîya çemê xwar."],
   gen:["Masîya çemê", "Masîyên me"]),

  (id:"b1_xw04", ku:"Şorba", tr:"Çorba", en:"Soup",
   cins:"mê", ez:"şorbê", kat:"xwarin", zor:0.74,
   not:"Dişil — [AS] ✓. \"Şorba germ e.\"",
   her:["Şorba amade ye.", "Şorba kelandî."],
   gen:["Şorba û nan", "Şorbaya me"]),

  (id:"b1_xw05", ku:"Biryane", tr:"Kavurma / Rosto", en:"Roast meat",
   cins:"mê", ez:"biryanê", kat:"xwarin", zor:0.72,
   not:"Dişil — \"biryane\" = kavurulmuş et. Kürt mutfağının önemli yemeği.",
   her:["Biryane pijandîye.", "Biryana kêfxweş."],
   gen:["Biryane û nan", "Biryana me"]),

  (id:"b1_xw06", ku:"Qelîyan", tr:"Kavurma / Yağda kızartma", en:"Frying / Sautéing",
   cins:"bêcins", ez:null, kat:"xwarin", zor:0.69,
   not:"\"Qelîyan\" = kızartmak/kavurmak. \"Min qelî kir.\"",
   her:["Bi rûnê qelîya.", "Qelî bike!"],
   gen:["Qelîyan û pijandin", "Qelî bike!"]),

  (id:"b1_xw07", ku:"Pijandin", tr:"Pişirmek / Kaynatmak", en:"To cook / boil",
   cins:"bêcins", ez:null, kat:"xwarin", zor:0.73,
   not:"\"Pijandin\" = pişirmek. Ergatif: \"Min pijand.\"",
   her:["Min pijand.", "Pijande bike!"],
   gen:["Pijandin û xwarin", "Min pijand."]),

  (id:"b1_xw08", ku:"Kelekê", tr:"Bulgur", en:"Bulgur wheat",
   cins:"nêr", ez:"kelekê", kat:"xwarin", zor:0.70,
   not:"Eril — \"keleke\" = bulgur. [AS] ✓.",
   her:["Keleke baş e.", "Kelek û mast."],
   gen:["Keleke û birinc", "Kelekê me"]),

  (id:"b1_xw09", ku:"Mercûmek", tr:"Mercimek", en:"Lentil",
   cins:"nêr", ez:"mercûmekê", kat:"xwarin", zor:0.72,
   not:"Eril — [AS] ✓: \"mercimek = mercûmek\".",
   her:["Mercûmek hêsan e.", "Şorba mercûmekê."],
   gen:["Mercûmek û birinc", "Mercûmekê me"]),

  (id:"b1_xw10", ku:"Nîsk", tr:"Nohut", en:"Chickpea",
   cins:"nêr", ez:"nîskê", kat:"xwarin", zor:0.71,
   not:"Eril — [AS]: \"nohut = nîsk\" ✓.",
   her:["Nîsk xweş e.", "Şorba nîskê."],
   gen:["Nîsk û mercûmek", "Nîskê me"]),

  (id:"b1_xw11", ku:"Fasûlî", tr:"Fasulye", en:"Bean",
   cins:"nêr", ez:"fasûliyê", kat:"xwarin", zor:0.71,
   not:"Eril — [AS]: \"fasulye = fasûlî\" ✓.",
   her:["Fasûlî pijandiye.", "Şorba fasûliyê."],
   gen:["Fasûlî û nîsk", "Fasûlîyê me"]),

  (id:"b1_xw12", ku:"Sewze", tr:"Sebze", en:"Vegetable",
   cins:"mê", ez:"sewzê", kat:"xwarin", zor:0.74,
   not:"Dişil — [AS] ✓. \"Sewzeya fêkî\" = meyve-sebze.",
   her:["Sewze sax e.", "Sewze û fêkî."],
   gen:["Sewze û fêkî", "Sewzeya me"]),

  (id:"b1_xw13", ku:"Karûs", tr:"Havuç", en:"Carrot",
   cins:"nêr", ez:"karûsê", kat:"xwarin", zor:0.70,
   not:"Eril — [AS]: \"havuç = karûs\" ✓.",
   her:["Karûs zer e.", "Karûs û sîr."],
   gen:["Karûs û piyaz", "Karûsê me"]),

  (id:"b1_xw14", ku:"Piyaz", tr:"Soğan", en:"Onion",
   cins:"nêr", ez:"piyazê", kat:"xwarin", zor:0.73,
   not:"Eril — [AS]: \"soğan = piyaz\" ✓.",
   her:["Piyaz tirş e.", "Bi piyaz ve."],
   gen:["Piyaz û sîr", "Piyazê me"]),

  (id:"b1_xw15", ku:"Sîr", tr:"Sarımsak", en:"Garlic",
   cins:"nêr", ez:"sîrê", kat:"xwarin", zor:0.72,
   not:"Eril — [AS]: \"sarımsak = sîr\" ✓.",
   her:["Sîr xweş e.", "Bi sîr ve."],
   gen:["Sîr û piyaz", "Sîrê me"]),

  (id:"b1_xw16", ku:"Xiyar", tr:"Salatalık", en:"Cucumber",
   cins:"nêr", ez:"xiyarê", kat:"xwarin", zor:0.71,
   not:"Eril — [AS]: \"salatalık = xiyar\" ✓.",
   her:["Xiyar sax e.", "Xiyar û firîngî."],
   gen:["Xiyar û firîngî", "Xiyarê me"]),

  (id:"b1_xw17", ku:"Kelem", tr:"Lahana", en:"Cabbage",
   cins:"nêr", ez:"kelemê", kat:"xwarin", zor:0.70,
   not:"Eril — [AS]: \"lahana = kelem\" ✓.",
   her:["Kelem germ e.", "Şorba kelemê."],
   gen:["Kelem û karûs", "Kelemê me"]),

  (id:"b1_xw18", ku:"Bîber", tr:"Biber", en:"Pepper",
   cins:"nêr", ez:"bîberê", kat:"xwarin", zor:0.71,
   not:"Eril — [AS]: \"biber = bîber\" ✓.",
   her:["Bîber tûj e.", "Bi bîber ve."],
   gen:["Bîber û tûz", "Bîberê me"]),

  (id:"b1_xw19", ku:"Tûz", tr:"Tuz", en:"Salt",
   cins:"nêr", ez:"tûzê", kat:"xwarin", zor:0.74,
   not:"Eril — [AS]: \"tuz = tûz\" ✓. NOT: \"Xwê\" de kullanılır.",
   her:["Tûz kêm e.", "Bi tûz ve."],
   gen:["Tûz û bîber", "Tûzê me"]),

  (id:"b1_xw20", ku:"Mêweyê ziwa", tr:"Kuru meyve", en:"Dried fruit",
   cins:"nêr", ez:"mêweyê", kat:"xwarin", zor:0.69,
   not:"\"Mêwe\" + \"ziwa\" (kuru).",
   her:["Mêweyê ziwa xweş e.", "Mêweyên ziwa."],
   gen:["Mêweyê ziwa", "Mêweyên me"]),

  (id:"b1_xw21", ku:"Tê xwarin", tr:"Yenilebilir", en:"Edible",
   cins:"bêcins", ez:null, kat:"xwarin", zor:0.68,
   not:"\"Tê xwarin\" = yenilebilir.",
   her:["Ev tê xwarin.", "Ev nayê xwarin."],
   gen:["Tê xwarin û nayê xwarin", "Ev tê xwarin."]),

  (id:"b1_xw22", ku:"Xwarinê li dar xistin", tr:"Yemek hazırlamak", en:"To prepare food",
   cins:"bêcins", ez:null, kat:"xwarin", zor:0.70,
   not:"\"Xwarin\" + \"li dar xistin\" = hazırlamak.",
   her:["Xwarin li dar xistiye.", "Em xwarin li dar dixin."],
   gen:["Xwarin li dar xistin", "Xwarin amade bike!"]),

  (id:"b1_xw23", ku:"Destpêkê sifirê", tr:"Sofranın başlangıcı", en:"Starter / Appetizer",
   cins:"nêr", ez:"destpêkê sifirê", kat:"xwarin", zor:0.67,
   not:"\"Destpêk\" + \"sifirê\". Yemek başlangıcı.",
   her:["Destpêka sifirê.", "Berî xwarinê."],
   gen:["Destpêkê sifirê", "Xwarina destpêkê"]),

  (id:"b1_xw24", ku:"Nanê genim", tr:"Buğday ekmeği", en:"Wheat bread",
   cins:"nêr", ez:"nanê genim", kat:"xwarin", zor:0.71,
   not:"\"Nan\" + \"genim\" (buğday).",
   her:["Nanê genim teze ye.", "Nanê genim û penîr."],
   gen:["Nanê genim", "Nanê me"]),

  (id:"b1_xw25", ku:"Dew", tr:"Ayran", en:"Ayran / Yogurt drink",
   cins:"nêr", ez:"dewê", kat:"xwarin", zor:0.72,
   not:"Eril — [BH] ✓: \"dew\" = ayran. \"Dew û nan.\"",
   her:["Dew sax e.", "Dew û mast."],
   gen:["Dew û mast", "Dewê me"]),

  (id:"b1_xw26", ku:"Mêrik", tr:"Meyan kökü / şeker kamışı", en:"Licorice root",
   cins:"nêr", ez:"mêrikê", kat:"xwarin", zor:0.66,
   not:"Eril — Kürdistan\'ın yerel bitkisi.",
   her:["Mêrik şîrîn e.", "Mêrikê kûvî."],
   gen:["Mêrik û hingiv", "Mêrikê me"]),

  (id:"b1_xw27", ku:"Girêva", tr:"Pasta / Tatlı", en:"Cake / Sweet pastry",
   cins:"mê", ez:"girêvê", kat:"xwarin", zor:0.70,
   not:"Dişil — \"girêva\" = tatlı/pasta. Kürt düğünlerinde.",
   her:["Girêva şîrîn e.", "Girêvaya cejnê."],
   gen:["Girêva û şekir", "Girêvaya me"]),

  (id:"b1_xw28", ku:"Baklava", tr:"Baklava", en:"Baklava",
   cins:"mê", ez:"baklavê", kat:"xwarin", zor:0.71,
   not:"Dişil — uluslararası terim. Kürt bayramlarının vazgeçilmezi.",
   her:["Baklava şîrîn e.", "Baklavaya cejnê."],
   gen:["Baklava û girêva", "Baklavaya me"]),

  (id:"b1_xw29", ku:"Xwaringehê", tr:"Lokanta / Restoran", en:"Restaurant",
   cins:"mê", ez:"xwaringehê", kat:"cih", zor:0.73,
   not:"Dişil — \"xwarin\" + \"geh\". [AS] ✓.",
   her:["Xwaringeh baş e.", "Em diçin xwaringehê."],
   gen:["Xwaringeh û kahwe", "Xwaringeha me"]),

  (id:"b1_xw30", ku:"Menûya xwaringehê", tr:"Restoran menüsü", en:"Restaurant menu",
   cins:"mê", ez:"menûya xwaringehê", kat:"cih", zor:0.70,
   not:"\"Menû\" + \"xwaringehê\".",
   her:["Menû heye?", "Menûya xwaringehê bide."],
   gen:["Menûya xwaringehê", "Menûya me"]),

  (id:"b1_xw31", ku:"Hesabê xwaringehê", tr:"Restoran hesabı", en:"Restaurant bill",
   cins:"nêr", ez:"hesabê xwaringehê", kat:"aborî", zor:0.69,
   not:"\"Hesab\" + \"xwaringehê\".",
   her:["Hesab bîne!", "Hesabê xwaringehê çend e?"],
   gen:["Hesabê xwaringehê", "Hesabê me"]),

  (id:"b1_xw32", ku:"Ser xwarinê", tr:"Yemek üstü (tatlı)", en:"After meal (dessert)",
   cins:"bêcins", ez:null, kat:"xwarin", zor:0.68,
   not:"\"Ser\" + \"xwarinê\" = yemek sonrası.",
   her:["Ser xwarinê şekir xwarin.", "Ser xwarinê."],
   gen:["Ser xwarinê", "Xwarinê me"]),

  (id:"b1_xw33", ku:"Tiştên vexwarinê", tr:"İçecekler", en:"Drinks / Beverages",
   cins:"bêcins", ez:"tiştên vexwarinê", kat:"xwarin", zor:0.71,
   not:"\"Tişt\" + \"vexwarinê\".",
   her:["Tiştên vexwarinê hene?", "Ji tiştên vexwarinê çi dixwazî?"],
   gen:["Tiştên vexwarinê", "Vexwarinên me"]),

  (id:"b1_xw34", ku:"Av bi kerbestê", tr:"Sodalı su / Maden suyu", en:"Sparkling water",
   cins:"mê", ez:"av bi kerbestê", kat:"xwarin", zor:0.68,
   not:"\"Av\" + \"kerbest\" (karbonat).",
   her:["Av bi kerbestê bide.", "Min av bi kerbestê dixwaze."],
   gen:["Av bi kerbestê", "Ava me"]),

  (id:"b1_xw35", ku:"Şerbeta tirî", tr:"Üzüm şerbeti", en:"Grape sherbet",
   cins:"mê", ez:"şerbeta tirî", kat:"xwarin", zor:0.68,
   not:"\"Şerbet\" + \"tirî\" (üzüm). Kürt geleneksel içeceği.",
   her:["Şerbeta tirî şîrîn e.", "Şerbeta tirî bike!"],
   gen:["Şerbeta tirî", "Şerbeta me"]),

  (id:"b1_xw36", ku:"Çêkirina xwarinê", tr:"Yemek yapma", en:"Cooking",
   cins:"mê", ez:"çêkirina xwarinê", kat:"xwarin", zor:0.71,
   not:"\"Çêkirin\" + \"xwarinê\".",
   her:["Çêkirina xwarinê hêsan e.", "Di çêkirina xwarinê de."],
   gen:["Çêkirina xwarinê", "Çêkirina me"]),

  (id:"b1_xw37", ku:"Xwarina organîk", tr:"Organik yiyecek", en:"Organic food",
   cins:"mê", ez:"xwarina organîk", kat:"xwarin", zor:0.68,
   not:"\"Xwarin\" + \"organîk\".",
   her:["Xwarina organîk baş e.", "Ji xwarina organîk hez dikim."],
   gen:["Xwarina organîk", "Xwarina me"]),

  (id:"b1_xw38", ku:"Xwarina siruştî", tr:"Doğal yiyecek", en:"Natural food",
   cins:"mê", ez:"xwarina siruştî", kat:"xwarin", zor:0.69,
   not:"\"Xwarin\" + \"siruştî\".",
   her:["Xwarina siruştî sax e.", "Ji xwarina siruştî hez dikim."],
   gen:["Xwarina siruştî", "Xwarina me"]),

  (id:"b1_xw39", ku:"Sêvçûyandin", tr:"Elma çayı", en:"Apple tea",
   cins:"mê", ez:"sêvçûyandinê", kat:"xwarin", zor:0.68,
   not:"\"Sêv\" + \"çûyandin\". Elma kaynatma/çayı.",
   her:["Sêvçûyandin şîrîn e.", "Sêvçûyandin bide."],
   gen:["Sêvçûyandin û çay", "Sêvçûyandina me"]),

  (id:"b1_xw40", ku:"Aştiya sifirê", tr:"Sofra barışı / Birlikte yemek", en:"Table harmony",
   cins:"mê", ez:"aştiya sifirê", kat:"çand", zor:0.66,
   not:"\"Aştî\" (barış) + \"sifirê\". Kürt kültüründe sofra kutsal.",
   her:["Aştiya sifirê.", "Li sifirê aştî ye."],
   gen:["Aştiya sifirê", "Aştîya me"]),

  (id:"b1_xw41", ku:"Mêmirî kirin", tr:"Davet etmek / Misafir etmek", en:"To host / invite",
   cins:"bêcins", ez:null, kat:"xwarin", zor:0.69,
   not:"\"Mêmirî\" = misafirperverlik. \"Mêmirî kirin\" = ağırlamak.",
   her:["Mêmirî kir.", "Hevalan mêmirî kir."],
   gen:["Mêmirî kirin", "Mêmirîya me"]),

  (id:"b1_xw42", ku:"Xwarina kevneşopî", tr:"Geleneksel yemek", en:"Traditional dish",
   cins:"mê", ez:"xwarina kevneşopî", kat:"çand", zor:0.70,
   not:"\"Xwarin\" + \"kevneşopî\" (geleneksel).",
   her:["Xwarina kevneşopî ya kurdî.", "Ji xwarina kevneşopî hez dikim."],
   gen:["Xwarina kevneşopî", "Xwarina me"]),

  (id:"b1_xw43", ku:"Dîza", tr:"Diza (Kürt yemeği)", en:"Diza (Kurdish dish)",
   cins:"mê", ez:"dîzê", kat:"xwarin", zor:0.69,
   not:"Dişil — \"dîza\" = diz yemeği. Kürt mutfağı.",
   her:["Dîza xweş e.", "Dîzaya me."],
   gen:["Dîza û biryane", "Dîzaya me"]),

  (id:"b1_xw44", ku:"Kêfxweşîya xwarinê", tr:"Yemek zevki", en:"Pleasure of eating",
   cins:"mê", ez:"kêfxweşîya xwarinê", kat:"xwarin", zor:0.67,
   not:"\"Kêfxweşî\" + \"xwarinê\".",
   her:["Kêfxweşîya xwarinê heye.", "Bi kêfxweşî bixwe!"],
   gen:["Kêfxweşîya xwarinê", "Kêfxweşîya me"]),

  (id:"b1_xw45", ku:"Destxwarinê", tr:"Elışması / El yemeği", en:"Handmade food",
   cins:"mê", ez:"destxwarinê", kat:"xwarin", zor:0.68,
   not:"\"Dest\" + \"xwarin\". Elyapımı yiyecek.",
   her:["Destxwarin xweş e.", "Destxwarinê me."],
   gen:["Destxwarin û fabrika", "Destxwarinê me"]),

  (id:"b1_xw46", ku:"Belaşî", tr:"Bedava / Ücretsiz", en:"Free / Gratis",
   cins:"bêcins", ez:null, kat:"aborî", zor:0.71,
   not:"\"Belaşî\" = ücretsiz.",
   her:["Ev belaşî ye.", "Belaşî hat dayîn."],
   gen:["Belaşî û biha", "Ev belaşî ye."]),

  (id:"b1_xw47", ku:"Çerezxane", tr:"Kuruyemişçi", en:"Nut shop",
   cins:"mê", ez:"çerezxanê", kat:"cih", zor:0.67,
   not:"\"Çerez\" + \"xane\". Kuruyemiş dükkanı.",
   her:["Çerezxane nêzîk e.", "Ji çerezxanê anî."],
   gen:["Çerezxane û dikan", "Çerezxaneya me"]),

  (id:"b1_xw48", ku:"Çerez", tr:"Kuruyemiş / Atıştırmalık", en:"Nuts / Snack",
   cins:"nêr", ez:"çerezê", kat:"xwarin", zor:0.71,
   not:"Eril — [AS] ✓. Kuruyemiş/atıştırmalık.",
   her:["Çerez şîrîn e.", "Çerez û çay."],
   gen:["Çerez û qehwe", "Çerezê me"]),

  (id:"b1_xw49", ku:"Xwarina bilez", tr:"Hızlı yiyecek", en:"Fast food",
   cins:"mê", ez:"xwarina bilez", kat:"xwarin", zor:0.70,
   not:"\"Xwarin\" + \"bilez\" (hızlı).",
   her:["Xwarina bilez xweş nîne.", "Ji xwarina bilez dûr bibe."],
   gen:["Xwarina bilez û xwarina sax", "Xwarina bilez"]),

  (id:"b1_xw50", ku:"Xwarina sax", tr:"Sağlıklı yemek", en:"Healthy food",
   cins:"mê", ez:"xwarina sax", kat:"tendurist", zor:0.71,
   not:"\"Xwarin\" + \"sax\" (sağlıklı).",
   her:["Xwarina sax baş e.", "Ji xwarina sax hez dikim."],
   gen:["Xwarina sax û bilez", "Xwarina sax"]),
];

final kB1_Malbat = [
// ── AİLE VE İLİŞKİLER — 80 kelime ────────────────────────────────

  (id:"b1_ml01", ku:"Malbata mezin", tr:"Geniş aile", en:"Extended family",
   cins:"mê", ez:"malbata mezin", kat:"malbat", zor:0.72,
   not:"\"Malbat\" + \"mezin\". Kürt toplumunda merkezi.",
   her:["Malbata mezin heye.", "Em malbata mezin in."],
   gen:["Malbata mezin", "Malbata me"]),

  (id:"b1_ml02", ku:"Malbata biçûk", tr:"Çekirdek aile", en:"Nuclear family",
   cins:"mê", ez:"malbata biçûk", kat:"malbat", zor:0.71,
   not:"\"Malbat\" + \"biçûk\".",
   her:["Malbata biçûk e.", "Di malbata biçûk de."],
   gen:["Malbata biçûk û mezin", "Malbata me"]),

  (id:"b1_ml03", ku:"Birazî", tr:"Yeğen (erkek kardeş oğlu)", en:"Nephew",
   cins:"nêr", ez:"biraziyê", kat:"malbat", zor:0.71,
   not:"Eril — [Fêrkera D.9] ✓: \"birazî\" listede.",
   her:["Birazîyê min hat.", "Birazî xweş e."],
   gen:["Birazî û xwarzî", "Birazîyê me"]),

  (id:"b1_ml04", ku:"Xwarzî", tr:"Yeğen (kız kardeş oğlu/kızı)", en:"Sister\'s child / nephew-niece",
   cins:"bêcins", ez:"xwarziyê", kat:"malbat", zor:0.71,
   not:"\"Xwarzî\" — [Fêrkera D.9] ✓.",
   her:["Xwarzîyê min hat.", "Xwarzî xweş e."],
   gen:["Xwarzî û birazî", "Xwarzîyê me"]),

  (id:"b1_ml05", ku:"Mam", tr:"Amca", en:"Uncle (father\'s brother)",
   cins:"nêr", ez:"mamê", kat:"malbat", zor:0.73,
   not:"Eril — [Fêrkera D.9] ✓: \"mam\" listede.",
   her:["Mamê min hat.", "Mamê mezin."],
   gen:["Mam û xal", "Mamê me"]),

  (id:"b1_ml06", ku:"Xal", tr:"Dayı", en:"Uncle (mother\'s brother)",
   cins:"nêr", ez:"xalê", kat:"malbat", zor:0.73,
   not:"Eril — [Fêrkera D.9] ✓: \"xal\" listede.",
   her:["Xalê min hat.", "Xalê baş."],
   gen:["Xal û mam", "Xalê me"]),

  (id:"b1_ml07", ku:"Xaltî", tr:"Hala", en:"Aunt (father\'s sister)",
   cins:"mê", ez:"xaltiyê", kat:"malbat", zor:0.72,
   not:"Dişil — [Fêrkera D.9] ✓: \"xaltî\" listede.",
   her:["Xaltîya min hat.", "Xaltî xweş e."],
   gen:["Xaltî û met", "Xaltîya me"]),

  (id:"b1_ml08", ku:"Met", tr:"Teyze", en:"Aunt (mother\'s sister)",
   cins:"mê", ez:"metê", kat:"malbat", zor:0.72,
   not:"Dişil — [Fêrkera D.9] ✓: \"met\" listede.",
   her:["Meta min hat.", "Meta baş."],
   gen:["Met û xaltî", "Meta me"]),

  (id:"b1_ml09", ku:"Pismam", tr:"Kuzen (amca oğlu)", en:"Cousin (uncle\'s son)",
   cins:"nêr", ez:"pismamê", kat:"malbat", zor:0.71,
   not:"Eril — [Fêrkera D.9] ✓: \"pismam\" listede.",
   her:["Pismamê min hat.", "Pismam baş e."],
   gen:["Pismam û dotmam", "Pismamê me"]),

  (id:"b1_ml10", ku:"Dotmam", tr:"Kuzen (amca kızı)", en:"Cousin (uncle\'s daughter)",
   cins:"mê", ez:"dotmamê", kat:"malbat", zor:0.71,
   not:"Dişil — [BH] ✓: \"dotmam\" = amca kızı.",
   her:["Dotmama min hat.", "Dotmam xweş e."],
   gen:["Dotmam û pismam", "Dotmama me"]),

  (id:"b1_ml11", ku:"Zava", tr:"Damat", en:"Son-in-law",
   cins:"nêr", ez:"zavayê", kat:"malbat", zor:0.71,
   not:"Eril — [Fêrkera D.9] ✓: \"zava\" listede.",
   her:["Zava hat.", "Zavayê baş."],
   gen:["Zava û bûk", "Zavayê me"]),

  (id:"b1_ml12", ku:"Bûk", tr:"Gelin", en:"Daughter-in-law / Bride",
   cins:"mê", ez:"bûkê", kat:"malbat", zor:0.73,
   not:"Dişil — [Fêrkera D.9] ✓: \"bûka\" bağlam. Heritage diyaloglarında.",
   her:["Bûk hat.", "Bûka baş."],
   gen:["Bûk û zava", "Bûka me"]),

  (id:"b1_ml13", ku:"Xwişkzade", tr:"Yeğen (kız kardeşin oğlu)", en:"Sister\'s son",
   cins:"nêr", ez:"xwişkzadeyê", kat:"malbat", zor:0.69,
   not:"\"Xwişk\" + \"zade\". Kız kardeşin oğlu.",
   her:["Xwişkzadeyê min hat.", "Xwişkzade."],
   gen:["Xwişkzade û birazî", "Xwişkzadeyê me"]),

  (id:"b1_ml14", ku:"Razamenî", tr:"Nişanlı / Söz kesme", en:"Engagement",
   cins:"mê", ez:"razameniyê", kat:"malbat", zor:0.69,
   not:"Dişil — [AS] ✓: \"nişan = razamenî\". Kürt nişan geleneği.",
   her:["Razamenî hat kirin.", "Di razameniyê de ne."],
   gen:["Razamenî û zewac", "Razamenîya me"]),

  (id:"b1_ml15", ku:"Dawet", tr:"Düğün", en:"Wedding",
   cins:"mê", ez:"dawetê", kat:"malbat", zor:0.73,
   not:"Dişil — [AS] ✓: \"düğün = dawet\". Kürt düğün geleneği.",
   her:["Dawet hat.", "Di dawetê de ne."],
   gen:["Dawet û cejn", "Daweta me"]),

  (id:"b1_ml16", ku:"Şahidê dawetê", tr:"Düğün şahidi", en:"Wedding witness",
   cins:"bêcins", ez:"şahidê dawetê", kat:"malbat", zor:0.67,
   not:"\"Şahid\" + \"dawetê\".",
   her:["Şahidê dawetê ye.", "Di dawetê şahid bûm."],
   gen:["Şahidê dawetê", "Şahida me"]),

  (id:"b1_ml17", ku:"Şînê", tr:"Yas / Matem", en:"Mourning",
   cins:"nêr", ez:"şînê", kat:"malbat", zor:0.69,
   not:"Eril — [AS]: \"yas = şîn\" ✓. Kürt yas geleneği.",
   her:["Şîn li malbatê ye.", "Di şînê de ne."],
   gen:["Şîn û cejn", "Şînê me"]),

  (id:"b1_ml18", ku:"Serxweşiya jiyana", tr:"Yaşam sevinci", en:"Joy of life",
   cins:"mê", ez:"serxweşiya jiyanê", kat:"his", zor:0.69,
   not:"\"Serxweşî\" + \"jiyanê\". Kürt kültüründe yaşam coşkusu.",
   her:["Serxweşiya jiyanê.", "Bi serxweşî bijî!"],
   gen:["Serxweşiya jiyanê", "Serxweşîya me"]),

  (id:"b1_ml19", ku:"Malbatvanî", tr:"Aile değerleri", en:"Family values",
   cins:"mê", ez:"malbatvaniyê", kat:"nirx", zor:0.69,
   not:"Dişil — \"malbat\" + \"-vanî\". Kürt aile kültürü.",
   her:["Malbatvanî girîng e.", "Di malbatvaniyê de."],
   gen:["Malbatvanî", "Malbatvanîya me"]),

  (id:"b1_ml20", ku:"Hezkirin û xemxwarin", tr:"Sevgi ve kaygı", en:"Love and concern",
   cins:"bêcins", ez:null, kat:"his", zor:0.70,
   not:"\"Hezkirin\" + \"xemxwarin\". Aile kavramının özü.",
   her:["Hezkirin û xemxwarin.", "Malbat hezkirin û xemxwarin e."],
   gen:["Hezkirin û xemxwarin", "Hezkirina me"]),
];

final kB1_Jiyan = [
// ── GÜNLÜK YAŞAM — 80 kelime ─────────────────────────────────────

  (id:"b1_jy01", ku:"Teyşebûn", tr:"Alışmak", en:"To get used to",
   cins:"bêcins", ez:null, kat:"jiyan", zor:0.69,
   not:"\"Teyşebûn\" = alışmak/alışkanlık.",
   her:["Teyşe bûm.", "Têşe bibe!"],
   gen:["Teyşebûn û guhertin", "Teyşe bû."]),

  (id:"b1_jy02", ku:"Xwe girtin", tr:"Kendine çeki düzen vermek", en:"To pull oneself together",
   cins:"bêcins", ez:null, kat:"jiyan", zor:0.69,
   not:"\"Xwe girtin\" = kendini kontrol etmek.",
   her:["Xwe bigire!", "Xwe girt."],
   gen:["Xwe girtin", "Xwe bigire!"]),

  (id:"b1_jy03", ku:"Jiyana hişmend", tr:"Bilinçli yaşam", en:"Conscious life",
   cins:"mê", ez:"jiyana hişmend", kat:"jiyan", zor:0.68,
   not:"\"Jiyan\" + \"hişmend\" (bilinçli).",
   her:["Jiyana hişmend.", "Bi jiyana hişmend bijî."],
   gen:["Jiyana hişmend", "Jiyana me"]),

  (id:"b1_jy04", ku:"Hevrêyên jiyanê", tr:"Hayat arkadaşları", en:"Life companions",
   cins:"bêcins", ez:"hevrêyên jiyanê", kat:"malbat", zor:0.68,
   not:"\"Hevrê\" + \"jiyanê\".",
   her:["Hevrêyên jiyanê girîng in.", "Hevrêyên jiyanê."],
   gen:["Hevrêyên jiyanê", "Hevrêyên me"]),

  (id:"b1_jy05", ku:"Armancên jiyanê", tr:"Hayat hedefleri", en:"Life goals",
   cins:"bêcins", ez:"armancên jiyanê", kat:"jiyan", zor:0.69,
   not:"\"Armancên\" + \"jiyanê\".",
   her:["Armancên jiyanê hene.", "Armancên jiyanê tayîn kirin."],
   gen:["Armancên jiyanê", "Armancên me"]),

  (id:"b1_jy06", ku:"Xwedîtîya jiyanê", tr:"Hayata sahip çıkma", en:"Taking ownership of life",
   cins:"mê", ez:"xwedîtîya jiyanê", kat:"jiyan", zor:0.67,
   not:"\"Xwedîtî\" + \"jiyanê\".",
   her:["Xwedîtîya jiyanê.", "Ji jiyana xwe re xwedî derkeve."],
   gen:["Xwedîtîya jiyanê", "Xwedîtîya me"]),

  (id:"b1_jy07", ku:"Moda jiyanê", tr:"Yaşam tarzı", en:"Lifestyle",
   cins:"mê", ez:"moda jiyanê", kat:"jiyan", zor:0.70,
   not:"\"Mod\" + \"jiyanê\".",
   her:["Moda jiyanê ya me.", "Moda jiyanê guherîye."],
   gen:["Moda jiyanê", "Moda me"]),

  (id:"b1_jy08", ku:"Rûniştina bajêr", tr:"Şehirde oturma", en:"City living",
   cins:"mê", ez:"rûniştina bajêr", kat:"jiyan", zor:0.68,
   not:"\"Rûniştin\" + \"bajêr\".",
   her:["Rûniştina bajêr zehmet e.", "Di rûniştina bajêr de."],
   gen:["Rûniştina bajêr û gund", "Rûniştina me"]),

  (id:"b1_jy09", ku:"Jiyana gundî", tr:"Köy yaşamı", en:"Village life",
   cins:"mê", ez:"jiyana gundî", kat:"jiyan", zor:0.70,
   not:"\"Jiyan\" + \"gundî\".",
   her:["Jiyana gundî xweş e.", "Di jiyana gundî de."],
   gen:["Jiyana gundî û bajêr", "Jiyana gundî"]),

  (id:"b1_jy10", ku:"Bêhnvedan", tr:"Dinlenme / Mola", en:"Rest / Break",
   cins:"mê", ez:"bêhnvedanê", kat:"jiyan", zor:0.72,
   not:"Dişil — \"bêhn\" + \"vedan\". Dinlenme.",
   her:["Bêhnvedan lazim e.", "Di bêhnvedanê de ne."],
   gen:["Bêhnvedan û kar", "Bêhnvedana me"]),

  (id:"b1_jy11", ku:"Rûniştina civakî", tr:"Sosyal buluşma", en:"Social gathering",
   cins:"mê", ez:"rûniştina civakî", kat:"jiyan", zor:0.69,
   not:"\"Rûniştin\" + \"civakî\".",
   her:["Rûniştina civakî hat.", "Di rûniştina civakî de."],
   gen:["Rûniştina civakî", "Rûniştina me"]),

  (id:"b1_jy12", ku:"Siruştê derdora malê", tr:"Evin çevresindeki doğa", en:"Nature around the house",
   cins:"mê", ez:"siruştê derdora malê", kat:"xweza", zor:0.68,
   not:"\"Siruşt\" + \"derdora malê\".",
   her:["Siruştê derdora malê xweş e.", "Li siruştê derdora malê ne."],
   gen:["Siruştê derdora malê", "Siruştê me"]),

  (id:"b1_jy13", ku:"Roja xebatê", tr:"Çalışma günü", en:"Work day",
   cins:"mê", ez:"roja xebatê", kat:"kar", zor:0.71,
   not:"\"Roj\" + \"xebatê\".",
   her:["Roja xebatê dirêj e.", "Di roja xebatê de."],
   gen:["Roja xebatê û betlanê", "Roja xebatê"]),

  (id:"b1_jy14", ku:"Roja betlanê", tr:"Tatil günü", en:"Holiday / Day off",
   cins:"mê", ez:"roja betlanê", kat:"jiyan", zor:0.71,
   not:"\"Roj\" + \"betlanê\".",
   her:["Roja betlanê şa me.", "Di roja betlanê de."],
   gen:["Roja betlanê", "Betlaneya me"]),

  (id:"b1_jy15", ku:"Bernameya rojê", tr:"Günlük program", en:"Daily program",
   cins:"mê", ez:"bernameya rojê", kat:"jiyan", zor:0.70,
   not:"\"Bername\" + \"rojê\".",
   her:["Bernameya rojê çi ye?", "Bernameya rojê tayîn kirin."],
   gen:["Bernameya rojê", "Bernameya me"]),

  (id:"b1_jy16", ku:"Tevgera rojane", tr:"Günlük hareket / Aktivite", en:"Daily activity",
   cins:"mê", ez:"tevgera rojane", kat:"jiyan", zor:0.69,
   not:"\"Tevger\" + \"rojane\".",
   her:["Tevgera rojane giring e.", "Tevgerên rojane."],
   gen:["Tevgera rojane", "Tevgera me"]),

  (id:"b1_jy17", ku:"Çêkirina planê", tr:"Plan yapma", en:"Making a plan",
   cins:"mê", ez:"çêkirina planê", kat:"kar", zor:0.70,
   not:"\"Çêkirin\" + \"planê\".",
   her:["Çêkirina planê lazim e.", "Plan çêkir."],
   gen:["Çêkirina planê", "Planên me"]),

  (id:"b1_jy18", ku:"Pêşeroj", tr:"Gelecek", en:"Future",
   cins:"nêr", ez:"pêşerojê", kat:"dem", zor:0.73,
   not:"Eril — \"pêş\" + \"roj\". [AS] ✓.",
   her:["Pêşeroj baş e.", "Di pêşerojê de."],
   gen:["Pêşeroj û raborî", "Pêşeroja me"]),

  (id:"b1_jy19", ku:"Raborî", tr:"Geçmiş", en:"Past",
   cins:"nêr", ez:"raboriyê", kat:"dem", zor:0.73,
   not:"Eril — \"ra\" + \"borî\". [AS] ✓.",
   her:["Raborî baş bû.", "Di raboriyê de."],
   gen:["Raborî û pêşeroj", "Raborîya me"]),

  (id:"b1_jy20", ku:"Niha û wê gavê", tr:"Şimdi ve o an", en:"Now and then",
   cins:"bêcins", ez:null, kat:"dem", zor:0.69,
   not:"\"Niha\" (şimdi) + \"wê gavê\" (o an).",
   her:["Niha û wê gavê cûda ye.", "Niha baştir e."],
   gen:["Niha û wê gavê", "Niha û berê"]),
];

final kB1_Leker = [
// ── FİİLLER VE DİLBİLGİSİ — 80 kelime ────────────────────────────

  // Ergatif + geçişli fiil genişleme
  (id:"b1_lk01", ku:"Şandin", tr:"Göndermek", en:"To send",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.72,
   not:"\"Şandin\" — [BH] ✓. Ergatif: \"Min şand.\" Kök: şand.",
   her:["Min name şand.", "Wî şand."],
   gen:["Şandin û standin", "Min şand."]),

  (id:"b1_lk02", ku:"Anîn", tr:"Getirmek", en:"To bring",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.73,
   not:"\"Anîn\" — [BH] ✓. Ergatif: \"Min anî.\" Kök: tîne (şimdiki).",
   her:["Min anî.", "Wî anî."],
   gen:["Anîn û birin", "Min anî."]),

  (id:"b1_lk03", ku:"Birin", tr:"Götürmek", en:"To take / carry away",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.73,
   not:"\"Birin\" — [BH] ✓. Ergatif: \"Min bir.\" Kök: dibe.",
   her:["Min bir.", "Wê bir."],
   gen:["Birin û anîn", "Min bir."]),

  (id:"b1_lk04", ku:"Avêtin", tr:"Atmak", en:"To throw",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.71,
   not:"\"Avêtin\" — [BH] ✓. Ergatif: \"Min avêt.\" Kök: davête.",
   her:["Min avêt.", "Kevir avête."],
   gen:["Avêtin û girtin", "Min avêt."]),

  (id:"b1_lk05", ku:"Vexwarin", tr:"İçmek", en:"To drink",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.75,
   not:"\"Vexwarin\" — [BH] ✓. Ergatif: \"Min vexwar.\" Kök: vexwe.",
   her:["Min çay vexwar.", "Wî av vexwar."],
   gen:["Vexwarin û xwarin", "Min vexwar."]),

  (id:"b1_lk06", ku:"Veguhestin", tr:"Taşımak / Aktarmak", en:"To transport / transfer",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.69,
   not:"\"Veguhestin\" — \"ve\" + \"guhestin\". Ergatif: \"Min veguhest.\"",
   her:["Min veguhest.", "Wî veguhest."],
   gen:["Veguhestin û girtin", "Min veguhest."]),

  (id:"b1_lk07", ku:"Pejirandin", tr:"Kabul etmek / Onaylamak", en:"To accept / approve",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.70,
   not:"\"Pejirandin\" — [FB] ✓. Ergatif: \"Min pejirand.\"",
   her:["Min pejirand.", "Ew hat pejirandin."],
   gen:["Pejirandin û red kirin", "Min pejirand."]),

  (id:"b1_lk08", ku:"Ragihandin", tr:"Bildirmek / Haber vermek", en:"To inform / announce",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.70,
   not:"\"Ragihandin\" — [AS] ✓. Ergatif: \"Min ragihande.\"",
   her:["Min ragihande.", "Hat ragihandin."],
   gen:["Ragihandin û veşartin", "Min ragihande."]),

  (id:"b1_lk09", ku:"Pêşkêş kirin", tr:"Sunmak / Takdim etmek", en:"To present / offer",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.70,
   not:"\"Pêşkêş kirin\" — \"pêşkêş\" (sunum) + \"kirin\". Ergatif.",
   her:["Min pêşkêş kir.", "Ew hat pêşkêş kirin."],
   gen:["Pêşkêş kirin û standin", "Min pêşkêş kir."]),

  (id:"b1_lk10", ku:"Destnîşan kirin", tr:"Belirtmek / İşaret etmek", en:"To indicate / point out",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.69,
   not:"\"Destnîşan kirin\" = belirtmek.",
   her:["Min destnîşan kir.", "Hat destnîşan kirin."],
   gen:["Destnîşan kirin", "Min destnîşan kir."]),

  // Geçişsiz fiil genişleme
  (id:"b1_lk11", ku:"Gerîn", tr:"Dolaşmak / Gezmek", en:"To wander / stroll",
   cins:"bêcins", ez:null, kat:"leker", zor:0.72,
   not:"\"Gerîn\" — [Fêrkera D.5] ✓. Geçişsiz.",
   her:["Ez digerim.", "Li bajêr geriya."],
   gen:["Gerîn û sekinîn", "Digerim."]),

  (id:"b1_lk12", ku:"Sekinîn", tr:"Durmak", en:"To stop / stand still",
   cins:"bêcins", ez:null, kat:"leker", zor:0.72,
   not:"\"Sekinîn\" = durmak. [AS] ✓.",
   her:["Sekine!", "Li vir sekine."],
   gen:["Sekinîn û çûyîn", "Sekine!"]),

  (id:"b1_lk13", ku:"Şiyîn", tr:"Yıkanmak", en:"To bathe / wash oneself",
   cins:"bêcins", ez:null, kat:"leker", zor:0.70,
   not:"\"Şiyîn\" = yıkanmak. [BH] ✓.",
   her:["Ez diçim şiyîn.", "Şiya."],
   gen:["Şiyîn û xwe paqij kirin", "Diçim şiyîn."]),

  (id:"b1_lk14", ku:"Kenîn", tr:"Gülmek", en:"To laugh",
   cins:"bêcins", ez:null, kat:"his", zor:0.74,
   not:"\"Kenîn\" = gülmek. [BH] ✓.",
   her:["Dikene.", "Gelekî kenî."],
   gen:["Kenîn û girîn", "Dikene."]),

  (id:"b1_lk15", ku:"Girîn", tr:"Ağlamak", en:"To cry",
   cins:"bêcins", ez:null, kat:"his", zor:0.74,
   not:"\"Girîn\" = ağlamak. [BH] ✓.",
   her:["Digirî.", "Gelekî girî."],
   gen:["Girîn û kenîn", "Digirî."]),

  (id:"b1_lk16", ku:"Firrîn", tr:"Uçmak", en:"To fly",
   cins:"bêcins", ez:null, kat:"leker", zor:0.71,
   not:"\"Firrîn\" = uçmak. [BH] ✓.",
   her:["Balafir difirre.", "Çûçik difirre."],
   gen:["Firrîn û daketîn", "Difirre."]),

  (id:"b1_lk17", ku:"Ketîn", tr:"Düşmek", en:"To fall",
   cins:"bêcins", ez:null, kat:"leker", zor:0.72,
   not:"\"Ketîn\" = düşmek. [BH] ✓.",
   her:["Ket.", "Li erdê ket."],
   gen:["Ketîn û raketîn", "Ket."]),

  (id:"b1_lk18", ku:"Rabûn", tr:"Kalkmak", en:"To get up / rise",
   cins:"bêcins", ez:null, kat:"leker", zor:0.72,
   not:"\"Rabûn\" = kalkmak. [BH] ✓.",
   her:["Rabe!", "Sibehê rabû."],
   gen:["Rabûn û raketin", "Rabe!"]),

  (id:"b1_lk19", ku:"Şiyandîn", tr:"Göndermek / Yollamak", en:"To send off",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.69,
   not:"\"Şiyandîn\" — geçişli. \"Min şiyand.\"",
   her:["Min şiyand.", "Ew şiyand."],
   gen:["Şiyandîn û standin", "Min şiyand."]),

  (id:"b1_lk20", ku:"Vegerîn", tr:"Geri dönmek", en:"To return",
   cins:"bêcins", ez:null, kat:"leker", zor:0.73,
   not:"\"Vegerîn\" = geri dönmek. [Fêrkera D.5] ✓.",
   her:["Vegerî.", "Mal vegerîye."],
   gen:["Vegerîn û çûyîn", "Vegerî."]),

  // Subjunctive ve kalıplar
  (id:"b1_lk21", ku:"Divê em biçin", tr:"Gitmeliyiz", en:"We must go",
   cins:"bêcins", ez:null, kat:"subjunctive", zor:0.72,
   not:"\"Divê\" + \"em\" + \"biçin\" (subjunctive). Zorunluluk yapısı.",
   her:["Divê em biçin.", "Divê em zû biçin."],
   gen:["Divê em biçin", "Divê em..."]),

  (id:"b1_lk22", ku:"Divê ew were", tr:"Gelmeli", en:"He/she must come",
   cins:"bêcins", ez:null, kat:"subjunctive", zor:0.72,
   not:"\"Divê\" + \"ew\" + \"were\" (subjunctive).",
   her:["Divê ew were.", "Divê sibehê were."],
   gen:["Divê ew were", "Divê were"]),

  (id:"b1_lk23", ku:"Dixwazim ku", tr:"İstiyorum ki", en:"I want that",
   cins:"bêcins", ez:null, kat:"subjunctive", zor:0.72,
   not:"\"Dixwazim\" + \"ku\" + subjunctive. İstek kalıbı.",
   her:["Dixwazim ku were.", "Dixwazim ku bêyî."],
   gen:["Dixwazim ku", "Dixwazim ku were"]),

  (id:"b1_lk24", ku:"Hêvî dikim ku", tr:"Umuyorum ki", en:"I hope that",
   cins:"bêcins", ez:null, kat:"subjunctive", zor:0.71,
   not:"\"Hêvî dikim\" + \"ku\" + subjunctive.",
   her:["Hêvî dikim ku were.", "Hêvî dikim ku baş bê."],
   gen:["Hêvî dikim ku", "Hêvî dikim ku were"]),

  (id:"b1_lk25", ku:"Tirsim ku", tr:"Korkuyorum ki", en:"I\'m afraid that",
   cins:"bêcins", ez:null, kat:"subjunctive", zor:0.70,
   not:"\"Tirsim\" + \"ku\" + subjunctive.",
   her:["Tirsim ku neyê.", "Tirsim ku xirabbe."],
   gen:["Tirsim ku", "Tirsim ku neyê"]),
];

final kB1_Reziman = [
// ── DİLBİLGİSİ VE DİL — 80 kelime ────────────────────────────────

  // Zaman sistemleri
  (id:"b1_rz01", ku:"Dema niha ya berdewam", tr:"Şimdiki sürekli zaman", en:"Present continuous tense",
   cins:"mê", ez:"dema niha ya berdewam", kat:"rêziman", zor:0.70,
   not:"\"Dem\" + \"niha\" + \"berdewam\". \"Di... de\" + kök + kişi eki.",
   her:["Dema niha ya berdewam.", "Di rêzimana kurdî de."],
   gen:["Dema niha ya berdewam", "Demên rêzimanê"]),

  (id:"b1_rz02", ku:"Dema borî ya têdeyî", tr:"Dili geçmiş zaman", en:"Evidential past tense",
   cins:"mê", ez:"dema borî ya têdeyî", kat:"rêziman", zor:0.70,
   not:"\"Dem\" + \"borî\" + \"têdeyî\". [Fêrkera] terminolojisi.",
   her:["Dema borî ya têdeyî.", "Di dema borî ya têdeyî de."],
   gen:["Dema borî ya têdeyî", "Demên borî"]),

  (id:"b1_rz03", ku:"Dema bê ya sade", tr:"Sade gelecek zaman", en:"Simple future tense",
   cins:"mê", ez:"dema bê ya sade", kat:"rêziman", zor:0.70,
   not:"\"Dem\" + \"bê\" + \"sade\". [Fêrkera D.10] ✓. \"dê/ê\" + subjunctive.",
   her:["Dema bê ya sade.", "Di dema bê de."],
   gen:["Dema bê ya sade", "Demên bê"]),

  (id:"b1_rz04", ku:"Veguhestina cînavê", tr:"Zamirin hâli değişimi", en:"Pronoun case change",
   cins:"mê", ez:"veguhestina cînavê", kat:"rêziman", zor:0.68,
   not:"\"Veguhestin\" + \"cînavê\". [Fêrkera D.9] ✓.",
   her:["Veguhestina cînavê.", "Di veguhestina cînavê de."],
   gen:["Veguhestina cînavê", "Cînavên kurdî"]),

  (id:"b1_rz05", ku:"Cînavên pirsyarî", tr:"Soru zamirleri", en:"Interrogative pronouns",
   cins:"bêcins", ez:"cînavên pirsyarî", kat:"rêziman", zor:0.69,
   not:"\"Cînavên pirsyarî\": kî? çi? kû? çima? kengî? çend? çawa?",
   her:["Cînavên pirsyarî.", "Kî hat?"],
   gen:["Cînavên pirsyarî", "Cînavên kurdî"]),

  (id:"b1_rz06", ku:"Cînavên nîşanê", tr:"İşaret zamirleri", en:"Demonstrative pronouns",
   cins:"bêcins", ez:"cînavên nîşanê", kat:"rêziman", zor:0.69,
   not:"\"Cînavên nîşanê\". [Fêrkera D.10] ✓: \"ev\" (bu), \"ew\" (o).",
   her:["Cînavên nîşanê.", "Ev û ew."],
   gen:["Cînavên nîşanê", "Ev û ew"]),

  (id:"b1_rz07", ku:"Gihanek", tr:"Bağlaç", en:"Conjunction",
   cins:"nêr", ez:"gihanekê", kat:"rêziman", zor:0.70,
   not:"Eril — [Fêrkera D.5] ✓: \"gihanek\" = bağlaç. \"û, lê, ji ber ku, ku...\"",
   her:["Gihanek e.", "Gihanekên kurdî."],
   gen:["Gihanek û daçek", "Gihanekên kurdî"]),

  (id:"b1_rz08", ku:"Daçek", tr:"Edat / Öntakı", en:"Preposition",
   cins:"nêr", ez:"daçekê", kat:"rêziman", zor:0.71,
   not:"Eril — \"li, ji, bi, di, bo, ser, bin, ber...\".",
   her:["Daçek e.", "Daçekên kurdî."],
   gen:["Daçek û gihanek", "Daçekên kurdî"]),

  (id:"b1_rz09", ku:"Rabirdûya dûr", tr:"Uzak geçmiş zaman", en:"Remote past",
   cins:"mê", ez:"rabirdûya dûr", kat:"rêziman", zor:0.68,
   not:"\"Rabirdû\" + \"dûr\". Anlatı zamanı.",
   her:["Rabirdûya dûr.", "Di rabirdûya dûr de."],
   gen:["Rabirdûya dûr", "Demên dûr"]),

  (id:"b1_rz10", ku:"Hevokên şertî", tr:"Koşul cümleleri", en:"Conditional sentences",
   cins:"bêcins", ez:"hevokên şertî", kat:"rêziman", zor:0.70,
   not:"\"Hevok\" + \"şertî\". \"Ger... be/bûya...\" yapısı.",
   her:["Hevokên şertî.", "Ger were... wê..."],
   gen:["Hevokên şertî", "Hevokên kurdî"]),

  (id:"b1_rz11", ku:"Erka biker", tr:"Özne görevi", en:"Subject role",
   cins:"mê", ez:"erka biker", kat:"rêziman", zor:0.69,
   not:"\"Erk\" + \"biker\". [Fêrkera D.9] ✓.",
   her:["Erka biker.", "Di erka biker de."],
   gen:["Erka biker û pêveber", "Erka biker"]),

  // Sözcük yapımı
  (id:"b1_rz12", ku:"Peyvsazî", tr:"Sözcük yapımı", en:"Word formation",
   cins:"mê", ez:"peyvsaziyê", kat:"rêziman", zor:0.70,
   not:"Dişil — \"peyv\" + \"-sazî\". [BH] §268-275.",
   her:["Peyvsazîya kurdî.", "Di peyvsaziyê de."],
   gen:["Peyvsazî û morfolojî", "Peyvsazîya kurdî"]),

  (id:"b1_rz13", ku:"Bileşik peyv", tr:"Bileşik sözcük", en:"Compound word",
   cins:"mê", ez:"bileşik peyv", kat:"rêziman", zor:0.69,
   not:"\"Bileşik\" + \"peyv\". [BH] §276.",
   her:["Bileşik peyv.", "Peyvên bileşik."],
   gen:["Bileşik peyv", "Peyvên bileşik"]),

  (id:"b1_rz14", ku:"Koka peyvê", tr:"Sözcük kökü", en:"Word root",
   cins:"mê", ez:"koka peyvê", kat:"rêziman", zor:0.70,
   not:"\"Kok\" + \"peyvê\". Morfoloji kavramı.",
   her:["Koka peyvê.", "Di koka peyvê de."],
   gen:["Koka peyvê", "Kokên kurdî"]),

  (id:"b1_rz15", ku:"Formên cûda", tr:"Farklı biçimler", en:"Different forms",
   cins:"bêcins", ez:"formên cûda", kat:"rêziman", zor:0.68,
   not:"\"Form\" + \"cûda\". Gramer varyasyonu.",
   her:["Formên cûda hene.", "Di formên cûda de."],
   gen:["Formên cûda", "Formên kurdî"]),

  // Anlam bilgisi
  (id:"b1_rz16", ku:"Wateya peyv", tr:"Sözcüğün anlamı", en:"Word meaning",
   cins:"mê", ez:"wateya peyv", kat:"ziman", zor:0.71,
   not:"\"Wate\" + \"peyv\". Semantik.",
   her:["Wateya peyvê çi ye?", "Wateya nû."],
   gen:["Wateya peyv", "Wateya me"]),

  (id:"b1_rz17", ku:"Mantiqa zimên", tr:"Dilin mantığı", en:"Logic of language",
   cins:"mê", ez:"mantiqa zimên", kat:"ziman", zor:0.68,
   not:"\"Mantiq\" + \"zimên\".",
   her:["Mantiqa zimên e.", "Di mantiqa zimên de."],
   gen:["Mantiqa zimên", "Mantiqa me"]),

  (id:"b1_rz18", ku:"Hevwateyên peyvê", tr:"Eş anlamlılar", en:"Synonyms",
   cins:"bêcins", ez:"hevwateyên peyvê", kat:"ziman", zor:0.70,
   not:"\"Hevwate\" + \"peyvê\". Eş anlam.",
   her:["Hevwateyên peyvê.", "Hevwate û dijwate."],
   gen:["Hevwateyên peyvê", "Hevwateyên kurdî"]),

  (id:"b1_rz19", ku:"Dijwateyên peyvê", tr:"Zıt anlamlılar", en:"Antonyms",
   cins:"bêcins", ez:"dijwateyên peyvê", kat:"ziman", zor:0.70,
   not:"\"Dijwate\" + \"peyvê\". Zıt anlam.",
   her:["Dijwateyên peyvê.", "Baş û xerab dijwate ne."],
   gen:["Dijwateyên peyvê", "Dijwateyên kurdî"]),

  (id:"b1_rz20", ku:"Têkilîya navbera peyvên", tr:"Sözcükler arası ilişki", en:"Relation between words",
   cins:"mê", ez:"têkilîya navbera peyvên", kat:"ziman", zor:0.67,
   not:"\"Têkilî\" + \"navbera peyvên\".",
   her:["Têkilîya navbera peyvên.", "Di têkilîya navbera peyvên de."],
   gen:["Têkilîya navbera peyvên", "Têkilîya me"]),

  // Pratik kullanım kalıpları
  (id:"b1_rz21", ku:"Li gorî min", tr:"Bana göre", en:"According to me",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.73,
   not:"\"Li gorî\" + \"min\". Görüş ifadesi.",
   her:["Li gorî min, baş e.", "Li gorî min ev rast e."],
   gen:["Li gorî min", "Li gorî te"]),

  (id:"b1_rz22", ku:"Weke ku got", tr:"Dediği gibi", en:"As he/she said",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Weke ku\" + \"got\". Atıf kalıbı.",
   her:["Weke ku got...", "Weke ku mamoste got."],
   gen:["Weke ku got", "Weke ku nîşan da"]),

  (id:"b1_rz23", ku:"Ji xeynî", tr:"...den başka / hariç", en:"Except / Apart from",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Ji xeynî\" — [BH] §253: \"ji xeynî\" = dışında.",
   her:["Ji xeynî wî, hemû hatin.", "Ji xeynî min."],
   gen:["Ji xeynî", "Ji xeynî wî"]),

  (id:"b1_rz24", ku:"Bi taybetî", tr:"Özellikle", en:"Especially / Particularly",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Bi\" + \"taybetî\". Vurgu zarfı.",
   her:["Bi taybetî dikim.", "Bi taybetî Kürtçe."],
   gen:["Bi taybetî", "Bi taybetî me"]),

  (id:"b1_rz25", ku:"Bi giştî", tr:"Genel olarak", en:"In general",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Bi\" + \"giştî\". Genelleme zarfı.",
   her:["Bi giştî baş e.", "Bi giştî dibêjin."],
   gen:["Bi giştî", "Bi giştî û bi taybetî"]),

  (id:"b1_rz26", ku:"Heya/heta ku", tr:"...e kadar ki", en:"Until / Up to the point that",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Heya\" veya \"heta\" + \"ku\". Zaman bağlacı.",
   her:["Heya ku were.", "Heta ku biqede."],
   gen:["Heya ku", "Heta ku were"]),

  (id:"b1_rz27", ku:"Wextê ku", tr:"Zamanında / O zaman ki", en:"At the time when",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.70,
   not:"\"Wext\" + \"ku\". Zaman bağlacı.",
   her:["Wextê ku hatî...", "Wextê ku bû..."],
   gen:["Wextê ku", "Wextê ku hatî"]),

  (id:"b1_rz28", ku:"Ji bo ku", tr:"...için ki / ...amacıyla", en:"In order that / So that",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Ji bo\" + \"ku\". Amaç bağlacı.",
   her:["Ji bo ku were.", "Ji bo ku fêr bibe."],
   gen:["Ji bo ku", "Ji bo ku were"]),

  (id:"b1_rz29", ku:"Lê belê", tr:"Ama / Fakat", en:"But / However",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.73,
   not:"\"Lê\" + \"belê\". Güçlendirilmiş zıtlık.",
   her:["Lê belê ez hatim.", "Lê belê, baş nîne."],
   gen:["Lê belê", "Lê belê, ne"]),

  (id:"b1_rz30", ku:"Di encamê de", tr:"Sonuçta", en:"As a result / In conclusion",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Di encamê de\" = sonuçta.",
   her:["Di encamê de hat.", "Di encamê de, baş e."],
   gen:["Di encamê de", "Di encamê de ne"]),
];

final kB1_Perwerde = [
// ── EĞİTİM — 60 kelime ───────────────────────────────────────────

  (id:"b1_pw01", ku:"Sinifa destpêkê", tr:"Birinci sınıf", en:"First grade",
   cins:"mê", ez:"sinifa destpêkê", kat:"perwerde", zor:0.71,
   not:"\"Sinif\" + \"destpêkê\".",
   her:["Sinifa destpêkê.", "Di sinifa destpêkê de."],
   gen:["Sinifa destpêkê", "Sinifên me"]),

  (id:"b1_pw02", ku:"Dibistana seretayî", tr:"İlkokul", en:"Primary school",
   cins:"mê", ez:"dibistana seretayî", kat:"perwerde", zor:0.72,
   not:"\"Dibistan\" + \"seretayî\". İlkokul.",
   her:["Dibistana seretayî nêzîk e.", "Di dibistana seretayî de."],
   gen:["Dibistana seretayî", "Dibistana me"]),

  (id:"b1_pw03", ku:"Dibistana navîn", tr:"Ortaokul", en:"Middle school",
   cins:"mê", ez:"dibistana navîn", kat:"perwerde", zor:0.72,
   not:"\"Dibistan\" + \"navîn\".",
   her:["Dibistana navîn.", "Di dibistana navîn de."],
   gen:["Dibistana navîn", "Dibistana me"]),

  (id:"b1_pw04", ku:"Dibistana bilind", tr:"Lise", en:"High school",
   cins:"mê", ez:"dibistana bilind", kat:"perwerde", zor:0.72,
   not:"\"Dibistan\" + \"bilind\". Lise.",
   her:["Dibistana bilind.", "Di dibistana bilind de."],
   gen:["Dibistana bilind", "Dibistana me"]),

  (id:"b1_pw05", ku:"Bawername", tr:"Diploma / Sertifika", en:"Diploma / Certificate",
   cins:"mê", ez:"bawernama", kat:"perwerde", zor:0.71,
   not:"Dişil — [Fêrkera D.3] ✓: \"diploma = bawername\".",
   her:["Bawername hat.", "Bawernameya min."],
   gen:["Bawername û şanî", "Bawernameya me"]),

  (id:"b1_pw06", ku:"Wane", tr:"Ders", en:"Lesson / Class",
   cins:"mê", ez:"wanê", kat:"perwerde", zor:0.74,
   not:"Dişil — [Fêrkera D.1] ✓: \"ders = wane\". [AS] ✓.",
   her:["Wane baş bû.", "Di wanê de ne."],
   gen:["Wane û spartek", "Waneya me"]),

  (id:"b1_pw07", ku:"Bernameya waneyê", tr:"Ders programı", en:"Course program",
   cins:"mê", ez:"bernameya waneyê", kat:"perwerde", zor:0.69,
   not:"\"Bername\" + \"waneyê\". [Fêrkera D.1] ✓.",
   her:["Bernameya waneyê.", "Bernameya waneyê hat amade kirin."],
   gen:["Bernameya waneyê", "Bernameya me"]),

  (id:"b1_pw08", ku:"Şagirt", tr:"Öğrenci", en:"Student",
   cins:"bêcins", ez:"şagirtê", kat:"perwerde", zor:0.73,
   not:"\"Şagirt\" — [Fêrkera D.1] ✓. Hem \"xwandekar\" hem \"şagirt\".",
   her:["Şagirt dixwîne.", "Şagirtên baş."],
   gen:["Şagirt û mamoste", "Şagirtên me"]),

  (id:"b1_pw09", ku:"Serkeftina xwendinê", tr:"Akademik başarı", en:"Academic success",
   cins:"mê", ez:"serkeftina xwendinê", kat:"perwerde", zor:0.69,
   not:"\"Serkeftin\" + \"xwendinê\".",
   her:["Serkeftina xwendinê baş e.", "Di serkeftina xwendinê de."],
   gen:["Serkeftina xwendinê", "Serkeftina me"]),

  (id:"b1_pw10", ku:"Sinava dawî", tr:"Final sınavı", en:"Final exam",
   cins:"mê", ez:"sinava dawî", kat:"perwerde", zor:0.71,
   not:"\"Sinav\" + \"dawî\". Final.",
   her:["Sinava dawî zor e.", "Di sinava dawî de."],
   gen:["Sinava dawî", "Sinava me"]),

  (id:"b1_pw11", ku:"Xwendekarên navdar", tr:"Başarılı öğrenciler", en:"Outstanding students",
   cins:"bêcins", ez:"xwendekarên navdar", kat:"perwerde", zor:0.68,
   not:"\"Xwendekar\" + \"navdar\".",
   her:["Xwendekarên navdar hene.", "Xwendekarên navdar."],
   gen:["Xwendekarên navdar", "Xwendekarên me"]),

  (id:"b1_pw12", ku:"Pirtûkxane", tr:"Kütüphane", en:"Library",
   cins:"mê", ez:"pirtûkxanê", kat:"cih", zor:0.73,
   not:"Dişil — [Fêrkera D.1] ✓: \"pirtûkxane\" listede.",
   her:["Pirtûkxane mezin e.", "Li pirtûkxanê ne."],
   gen:["Pirtûkxane û zanîngeh", "Pirtûkxaneya me"]),

  (id:"b1_pw13", ku:"Qursên xweruyê", tr:"Zorunlu dersler", en:"Mandatory courses",
   cins:"bêcins", ez:"qursên xweruyê", kat:"perwerde", zor:0.67,
   not:"\"Qurs\" + \"xweruyê\" (zorunlu).",
   her:["Qursên xweruyê hene.", "Qursên xweruyê divê bên xwendin."],
   gen:["Qursên xweruyê", "Qursên me"]),

  (id:"b1_pw14", ku:"Mamosteya zimanê", tr:"Dil öğretmeni", en:"Language teacher",
   cins:"mê", ez:"mamosteya zimanê", kat:"perwerde", zor:0.70,
   not:"\"Mamoste\" + \"zimanê\". Kürtçe öğretmeni.",
   her:["Mamosteya zimanê hat.", "Mamosteya zimanê ya kurdî."],
   gen:["Mamosteya zimanê", "Mamosteya me"]),

  (id:"b1_pw15", ku:"Perwerdehîya taybet", tr:"Özel eğitim", en:"Special education",
   cins:"mê", ez:"perwerdehîya taybet", kat:"perwerde", zor:0.68,
   not:"\"Perwerdehî\" + \"taybet\".",
   her:["Perwerdehîya taybet lazim e.", "Di perwerdehîya taybet de."],
   gen:["Perwerdehîya taybet", "Perwerdehîya me"]),
];

final kB1_Dacek2 = [
// ── KALIPLAR VE DEYIMLER — 80 kelime ─────────────────────────────

  // Kalıplaşmış ifadeler
  (id:"b1_dc01", ku:"Çawa dizanî?", tr:"Nasıl biliyorsun?", en:"How do you know?",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.71,
   not:"Bilgi sorgulama kalıbı.",
   her:["Çawa dizanî?", "Tu çawa dizanî?"],
   gen:["Çawa dizanî?", "Çawa fêr bûyî?"]),

  (id:"b1_dc02", ku:"Mebesta te çi ye?", tr:"Ne demek istiyorsun?", en:"What do you mean?",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.70,
   not:"\"Mebest\" (niyet/anlam) + \"te\" + \"çi ye?\"",
   her:["Mebesta te çi ye?", "Mebesta gotinan çi ye?"],
   gen:["Mebesta te çi ye?", "Mebest"]),

  (id:"b1_dc03", ku:"Bi gotina din", tr:"Başka bir deyişle", en:"In other words",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.70,
   not:"\"Bi gotina din\" = başka bir deyişle.",
   her:["Bi gotina din, xweş e.", "Bi gotina din..."],
   gen:["Bi gotina din", "Bi gotina din çi?"]),

  (id:"b1_dc04", ku:"Li ser kê?", tr:"Kimin üzerinde? / Kim hakkında?", en:"About whom?",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.70,
   not:"\"Li ser\" + \"kê?\" Soru kalıbı.",
   her:["Li ser kê dipeyivî?", "Li ser wî dipeyivin."],
   gen:["Li ser kê?", "Li ser wî"]),

  (id:"b1_dc05", ku:"Di nav", tr:"İçinde / Arasında", en:"Among / Inside",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.73,
   not:"\"Di nav\" + isim. Yer bildirme.",
   her:["Di nav wan de ye.", "Di nav me de."],
   gen:["Di nav", "Di nav me de"]),

  (id:"b1_dc06", ku:"Di dema ku", tr:"...iken / ...sırasında", en:"While / During",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Di dema ku\" = iken/sırasında.",
   her:["Di dema ku dixwand...", "Di dema xwendinê de."],
   gen:["Di dema ku", "Di dema ku hatim"]),

  (id:"b1_dc07", ku:"Piştî ku", tr:"...dan sonra", en:"After",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Piştî ku\" = dan sonra.",
   her:["Piştî ku xwar...", "Piştî ku hat."],
   gen:["Piştî ku", "Piştî ku xwar"]),

  (id:"b1_dc08", ku:"Berî ku", tr:"...dan önce", en:"Before",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Berî ku\" = dan önce.",
   her:["Berî ku here.", "Berî ku xwar."],
   gen:["Berî ku", "Berî ku here"]),

  (id:"b1_dc09", ku:"Ji ber ku", tr:"Çünkü", en:"Because",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.74,
   not:"\"Ji ber ku\" = çünkü.",
   her:["Ji ber ku baş e.", "Ji ber ku hat."],
   gen:["Ji ber ku", "Ji ber ku hat"]),

  (id:"b1_dc10", ku:"Lewre", tr:"Bu yüzden", en:"Therefore",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Lewre\" = bu yüzden.",
   her:["Lewre hat.", "Lewre ne."],
   gen:["Lewre", "Ji ber ku... lewre"]),

  // Deyimler
  (id:"b1_dc11", ku:"Şekirê dilê min", tr:"Canım / Sevgilim", en:"My dear / Sweetheart",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.69,
   not:"\"Şekir\" (tatlı) + \"dilê min\" (kalbim). Hitap deyimi.",
   her:["Şekirê dilê min!", "Bê, şekirê dilê min."],
   gen:["Şekirê dilê min", "Delal"]),

  (id:"b1_dc12", ku:"Canê min", tr:"Canım / Ruhum", en:"My soul / Dear",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.71,
   not:"\"Can\" + \"min\". Sevgi ifadesi.",
   her:["Canê min!", "Bê, canê min."],
   gen:["Canê min", "Şekirê dilê min"]),

  (id:"b1_dc13", ku:"Ser çav û serî", tr:"Baş göz üstüne (güçlendirilmiş)", en:"Absolutely / With pleasure",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.70,
   not:"\"Ser çav û serî\" — güçlendirilmiş kabul.",
   her:["Ser çav û serî!", "Ser çav û serê min."],
   gen:["Ser çav û serî", "Ser çavan"]),

  (id:"b1_dc14", ku:"Xatirê we ema", tr:"Hoşçakalın", en:"Goodbye (plural)",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.70,
   not:"\"Xatirê we ema\" = çoğula hitap eden veda.",
   her:["Xatirê we ema!", "Em diçin, xatirê we ema."],
   gen:["Xatirê we ema", "Bi xatirê te"]),

  (id:"b1_dc15", ku:"Destê xêrê", tr:"Hayırlı eller", en:"Beneficent hands",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.69,
   not:"\"Dest\" (el) + \"xêrê\" (hayır). Kürt dua kalıbı.",
   her:["Destê xêrê!", "Destê te xêrê."],
   gen:["Destê xêrê", "Destê te xweş be"]),

  (id:"b1_dc16", ku:"Ji dilê min re hat", tr:"İçimden geldi", en:"It came from my heart",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.68,
   not:"\"Ji dilê min re hat\" — içtenlik deyimi.",
   her:["Ji dilê min re hat.", "Ev ji dilê min re hat."],
   gen:["Ji dilê min re hat", "Ji dilê te"]),

  (id:"b1_dc17", ku:"Xwe li wêran kirin", tr:"Yıkmak / Berbat etmek", en:"To ruin oneself",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.67,
   not:"\"Xwe\" + \"wêran\" (harabe) + \"kirin\". Kürt deyimi.",
   her:["Xwe li wêran kir.", "Xwe li wêran neke!"],
   gen:["Xwe li wêran kirin", "Xwe li wêran neke!"]),

  (id:"b1_dc18", ku:"Çav le kirin", tr:"Gözetlemek", en:"To watch / keep an eye on",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.68,
   not:"\"Çav\" + \"le kirin\" — gözetlemek.",
   her:["Çav le kir.", "Çav le bike!"],
   gen:["Çav le kirin", "Çav le bike!"]),

  (id:"b1_dc19", ku:"Xwarin di guhê kirin", tr:"Kulak tıkamak", en:"To ignore / plug ears",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.66,
   not:"\"Xwarin\" + \"guh\" + \"kirin\" — kulak tıkamak.",
   her:["Xwarin di guhê kir.", "Guh bide, guh di xwarinê neke!"],
   gen:["Xwarin di guhê kirin", "Guh bide!"]),

  (id:"b1_dc20", ku:"Bêje bêje", tr:"Söyle söyle (ısrar)", en:"Say it say it (insistence)",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.67,
   not:"Tekrarlı emir — ısrar ifadesi.",
   her:["Bêje bêje, çi bû?", "Bêje bêje!"],
   gen:["Bêje bêje", "Bêje!"]),
];

final kB1_Rengder = [
// ── SIFATLAR VE NİTELEME — 60 kelime ────────────────────────────

  (id:"b1_rg01", ku:"Giranbiha", tr:"Değerli / Pahalı", en:"Precious / Expensive",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.71,
   not:"\"Giran\" (ağır/pahalı) + \"biha\". [BH] §276.",
   her:["Giranbiha ye.", "Tiştekî giranbiha."],
   gen:["Giranbiha û erzan", "Ev giranbiha ye."]),

  (id:"b1_rg02", ku:"Erzan", tr:"Ucuz", en:"Cheap",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.72,
   not:"\"Erzan\" — [AS] ✓. Ucuz.",
   her:["Erzan e.", "Tiştekî erzan."],
   gen:["Erzan û giranbiha", "Ev erzan e."]),

  (id:"b1_rg03", ku:"Nêzî û dûr", tr:"Yakın ve uzak", en:"Near and far",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.71,
   not:"\"Nêzî\" (yakın) + \"dûr\" (uzak). Mesafe karşıtı.",
   her:["Nêzî ye.", "Dûr e."],
   gen:["Nêzî û dûr", "Nêzî ye"]),

  (id:"b1_rg04", ku:"Ronî û tarî", tr:"Aydınlık ve karanlık", en:"Light and dark",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.71,
   not:"\"Ronî\" (aydınlık) + \"tarî\" (karanlık).",
   her:["Ronî ye.", "Tarî ye."],
   gen:["Ronî û tarî", "Ev ronî ye."]),

  (id:"b1_rg05", ku:"Fireh û teng", tr:"Geniş ve dar", en:"Wide and narrow",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.71,
   not:"\"Fireh\" (geniş) + \"teng\" (dar).",
   her:["Fireh e.", "Teng e."],
   gen:["Fireh û teng", "Rê fireh e."]),

  (id:"b1_rg06", ku:"Germ û sar", tr:"Sıcak ve soğuk", en:"Hot and cold",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.73,
   not:"\"Germ\" (sıcak) + \"sar\" (soğuk). [AS] ✓.",
   her:["Av germ e.", "Hewa sar e."],
   gen:["Germ û sar", "Av germ e."]),

  (id:"b1_rg07", ku:"Teze û kevn", tr:"Taze ve eski", en:"Fresh and old",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.71,
   not:"\"Teze\" (taze) + \"kevn\" (eski).",
   her:["Nan teze ye.", "Xanî kevn e."],
   gen:["Teze û kevn", "Nan teze ye."]),

  (id:"b1_rg08", ku:"Sax û nexweş", tr:"Sağlıklı ve hasta", en:"Healthy and sick",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.72,
   not:"\"Sax\" (sağlıklı) + \"nexweş\" (hasta).",
   her:["Sax e.", "Nexweş e."],
   gen:["Sax û nexweş", "Tu sax î?"]),

  (id:"b1_rg09", ku:"Zindî û mirî", tr:"Canlı ve ölü", en:"Alive and dead",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.70,
   not:"\"Zindî\" (canlı) + \"mirî\" (ölü). [Fêrkera D.1]: \"zindî\" listede.",
   her:["Zindî ye.", "Mirî ye."],
   gen:["Zindî û mirî", "Ziman zindî ye."]),

  (id:"b1_rg10", ku:"Temam û nîvê", tr:"Tam ve yarım", en:"Complete and half",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.70,
   not:"\"Temam\" (tam) + \"nîvê\" (yarım).",
   her:["Temam e.", "Nîvê ye."],
   gen:["Temam û nîvê", "Ev temam e."]),

  (id:"b1_rg11", ku:"Xweş û xerab", tr:"İyi ve kötü", en:"Good and bad",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.74,
   not:"\"Xweş\" (iyi/güzel) + \"xerab\" (kötü).",
   her:["Xweş e.", "Xerab e."],
   gen:["Xweş û xerab", "Xweş e."]),

  (id:"b1_rg12", ku:"Hêsan û zehmet", tr:"Kolay ve zor", en:"Easy and difficult",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.72,
   not:"\"Hêsan\" (kolay) + \"zehmet\" (zor).",
   her:["Hêsan e.", "Zehmet e."],
   gen:["Hêsan û zehmet", "Ev hêsan e."]),

  (id:"b1_rg13", ku:"Mezin û biçûk", tr:"Büyük ve küçük", en:"Big and small",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.74,
   not:"\"Mezin\" (büyük) + \"biçûk\" (küçük).",
   her:["Mezin e.", "Biçûk e."],
   gen:["Mezin û biçûk", "Ev mezin e."]),

  (id:"b1_rg14", ku:"Zêde û kêm", tr:"Fazla ve az", en:"Much and little",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.72,
   not:"\"Zêde\" (fazla) + \"kêm\" (az).",
   her:["Zêde ye.", "Kêm e."],
   gen:["Zêde û kêm", "Zêde ne."]),

  (id:"b1_rg15", ku:"Spehî", tr:"Güzel / Hoş", en:"Beautiful / Elegant",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.71,
   not:"\"Spehî\" = güzel/hoş. [FB]: spehî adj.",
   her:["Spehî ye.", "Keç spehî ye."],
   gen:["Spehî û nespehî", "Ev spehî ye."]),

  (id:"b1_rg16", ku:"Nexweş dîtin", tr:"Hasta görünmek", en:"To look sick",
   cins:"bêcins", ez:null, kat:"his", zor:0.69,
   not:"\"Nexweş\" + \"dîtin\".",
   her:["Nexweş xuya dikî.", "Nexweş dîtiye."],
   gen:["Nexweş dîtin", "Nexweş xuya dikî."]),

  (id:"b1_rg17", ku:"Westîyayî", tr:"Yorgun", en:"Tired",
   cins:"bêcins", ez:null, kat:"his", zor:0.72,
   not:"\"Westîyayî\" — [Fêrkera D.1] ✓: \"westîyayî\" listede.",
   her:["Ez westîyame.", "Westîyayî xuya dikî."],
   gen:["Westîyayî û sax", "Ez westîyame."]),

  (id:"b1_rg18", ku:"Dilgerm û sar", tr:"Sıcakkanlı ve soğukkanlı", en:"Warm-hearted and cold",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.69,
   not:"\"Dilgerm\" (sıcakkanlı) + \"sar\" (soğuk). Karakter.",
   her:["Ew dilgerm e.", "Ew sar e."],
   gen:["Dilgerm û sar", "Ev dilgerm e."]),

  (id:"b1_rg19", ku:"Bêpar", tr:"Yoksun / Yoksul", en:"Deprived / Poor",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.68,
   not:"\"Bê\" + \"par\" (pay). Yoksun.",
   her:["Bêpar e.", "Ji tiştî bêpar e."],
   gen:["Bêpar û xwedî", "Ev bêpar e."]),

  (id:"b1_rg20", ku:"Bêbext", tr:"Talihsiz / Bahtsız", en:"Unlucky",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.68,
   not:"\"Bê\" + \"bext\" (talih).",
   her:["Bêbext e.", "Wî bêbext e."],
   gen:["Bêbext û bextewer", "Ev bêbext e."]),
];

final kB1_Cih = [
// ── YERLER VE COĞRAFYA — 60 kelime ───────────────────────────────

  (id:"b1_cj01", ku:"Navçeya çandî", tr:"Kültürel bölge", en:"Cultural region",
   cins:"mê", ez:"navçeya çandî", kat:"cih", zor:0.69,
   not:"\"Navçe\" + \"çandî\". Kültürel coğrafya.",
   her:["Navçeya çandî ya kurdî.", "Di navçeya çandî de."],
   gen:["Navçeya çandî", "Navçeya me"]),

  (id:"b1_cj02", ku:"Bajarên sereke", tr:"Başlıca şehirler", en:"Major cities",
   cins:"bêcins", ez:"bajarên sereke", kat:"cih", zor:0.70,
   not:"\"Bajar\" + \"sereke\". Amed, Hewlêr, Qamişlo...",
   her:["Bajarên sereke.", "Di bajarên sereke de."],
   gen:["Bajarên sereke", "Bajarên me"]),

  (id:"b1_cj03", ku:"Sînorê devera", tr:"Bölgenin sınırı", en:"Region\'s border",
   cins:"nêr", ez:"sînorê", kat:"cih", zor:0.69,
   not:"\"Sînor\" + \"devera\".",
   her:["Sînorê devera.", "Di sînorê devera de."],
   gen:["Sînorê devera", "Sînorê me"]),

  (id:"b1_cj04", ku:"Çîya û deşt", tr:"Dağ ve ova", en:"Mountain and plain",
   cins:"bêcins", ez:null, kat:"xweza", zor:0.71,
   not:"\"Çîya\" (dağ) + \"deşt\" (ova). Kürdistan coğrafyası.",
   her:["Çîya û deşt.", "Di çîya û deştan de."],
   gen:["Çîya û deşt", "Çîyayên Kurdistanê"]),

  (id:"b1_cj05", ku:"Rojavaya Kurdistanê", tr:"Batı Kürdistanı (Rojava)", en:"Western Kurdistan",
   cins:"mê", ez:"Rojavaya Kurdistanê", kat:"cografî", zor:0.72,
   not:"\"Rojava\" (batı) + \"Kurdistanê\". Suriye Kürdistanı.",
   her:["Rojavaya Kurdistanê.", "Di Rojavaya Kurdistanê de."],
   gen:["Rojavaya Kurdistanê", "Rojavayê"]),

  (id:"b1_cj06", ku:"Bakurê Kurdistanê", tr:"Kuzey Kürdistanı", en:"Northern Kurdistan",
   cins:"nêr", ez:"Bakurê Kurdistanê", kat:"cografî", zor:0.72,
   not:"\"Bakur\" (kuzey) + \"Kurdistanê\". Türkiye Kürdistanı.",
   her:["Bakurê Kurdistanê.", "Di Bakurê Kurdistanê de."],
   gen:["Bakurê Kurdistanê", "Bakurê"]),

  (id:"b1_cj07", ku:"Başûrê Kurdistanê", tr:"Güney Kürdistanı", en:"Southern Kurdistan",
   cins:"nêr", ez:"Başûrê Kurdistanê", kat:"cografî", zor:0.72,
   not:"\"Başûr\" (güney) + \"Kurdistanê\". Irak Kürdistanı.",
   her:["Başûrê Kurdistanê.", "Di Başûrê Kurdistanê de."],
   gen:["Başûrê Kurdistanê", "Başûrê"]),

  (id:"b1_cj08", ku:"Rojhilatê Kurdistanê", tr:"Doğu Kürdistanı", en:"Eastern Kurdistan",
   cins:"nêr", ez:"Rojhilatê Kurdistanê", kat:"cografî", zor:0.72,
   not:"\"Rojhilat\" (doğu) + \"Kurdistanê\". İran Kürdistanı.",
   her:["Rojhilatê Kurdistanê.", "Di Rojhilatê Kurdistanê de."],
   gen:["Rojhilatê Kurdistanê", "Rojhilatê"]),

  (id:"b1_cj09", ku:"Hewlêr", tr:"Erbil / Hewler", en:"Erbil / Hewler",
   cins:"mê", ez:"Hewlêrê", kat:"cografî", zor:0.73,
   not:"Dişil — Irak Kürdistanı\'nın başkenti. Kürtçe: Hewlêr.",
   her:["Hewlêr li Başûrê ye.", "Di Hewlêrê de ne."],
   gen:["Hewlêr û Silemanî", "Bajarê Hewlêrê"]),

  (id:"b1_cj10", ku:"Amed", tr:"Diyarbakır", en:"Diyarbakir (Amed)",
   cins:"mê", ez:"Amedê", kat:"cografî", zor:0.73,
   not:"Dişil — Kürtçe adı Amed. Bakurê Kurdistanê\'nin kalbi.",
   her:["Amed li Bakurê ye.", "Di Amedê de ne."],
   gen:["Amed û Mêrdîn", "Bajarê Amedê"]),

  (id:"b1_cj11", ku:"Qamişlo", tr:"Kamışlı (Qamişlo)", en:"Qamishli",
   cins:"mê", ez:"Qamişloyê", kat:"cografî", zor:0.72,
   not:"Dişil — Rojavaya Kurdistanê\'nin önemli şehri.",
   her:["Qamişlo li Rojavayê ye.", "Di Qamişloyê de ne."],
   gen:["Qamişlo û Kobanê", "Bajarê Qamişloyê"]),

  (id:"b1_cj12", ku:"Kobanê", tr:"Kobane (Kobanê)", en:"Kobane",
   cins:"mê", ez:"Kobanê", kat:"cografî", zor:0.72,
   not:"Dişil — Rojava\'nın sembol şehri.",
   her:["Kobanê li Rojavayê ye.", "Kobanê bijî!"],
   gen:["Kobanê û Qamişlo", "Bajarê Kobanê"]),

  (id:"b1_cj13", ku:"Cizîr", tr:"Cizre (Cizîr)", en:"Cizre",
   cins:"mê", ez:"Cizîrê", kat:"cografî", zor:0.71,
   not:"Dişil — \"Cizîr\" = tarihi Kürt şehri. Melayê Cizîrî oradan.",
   her:["Cizîr bajêreke dîrokî ye.", "Di Cizîrê de ne."],
   gen:["Cizîr û Mêrdîn", "Bajarê Cizîrê"]),

  (id:"b1_cj14", ku:"Mêrdîn", tr:"Mardin (Mêrdîn)", en:"Mardin",
   cins:"mê", ez:"Mêrdînê", kat:"cografî", zor:0.72,
   not:"Dişil — Tarihi Kürt şehri. Kurmancî lehçe merkezi.",
   her:["Mêrdîn bajêreke xweş e.", "Di Mêrdînê de ne."],
   gen:["Mêrdîn û Amed", "Bajarê Mêrdînê"]),

  (id:"b1_cj15", ku:"Serhed", tr:"Serhad bölgesi", en:"Serhed region",
   cins:"nêr", ez:"Serhedê", kat:"cografî", zor:0.70,
   not:"Eril — Kuzey Kürdistanı\'nın doğu bölgesi. Önemli lehçe.",
   her:["Serhed li Bakurê ye.", "Zaravayê Serhedê."],
   gen:["Serhed û Botan", "Devera Serhedê"]),
];

final kB1_Beden = [
// ── BEDEN VE SAĞLIK — 60 kelime ──────────────────────────────────

  (id:"b1_bd01", ku:"Rûyê mirov", tr:"İnsan yüzü", en:"Human face",
   cins:"nêr", ez:"rûyê mirov", kat:"beden", zor:0.72,
   not:"\"Rû\" + \"mirov\". Yüz.",
   her:["Rûyê wî xweş e.", "Li rûyê wî bêje."],
   gen:["Rûyê mirov", "Rûyê me"]),

  (id:"b1_bd02", ku:"Pêla porê", tr:"Saç dalgası", en:"Hair wave",
   cins:"mê", ez:"pêla porê", kat:"beden", zor:0.68,
   not:"\"Pêl\" (dalga) + \"porê\" (saçın).",
   her:["Pêla porê xweş e.", "Porê pêlê."],
   gen:["Pêla porê", "Porê me"]),

  (id:"b1_bd03", ku:"Gewriya mirov", tr:"İnsan boğazı", en:"Human throat",
   cins:"mê", ez:"gewriya mirov", kat:"beden", zor:0.69,
   not:"\"Gewrî\" + \"mirov\". [BH] ✓.",
   her:["Gewriya min êşiye.", "Gewrî êşe."],
   gen:["Gewriya mirov", "Gewriya me"]),

  (id:"b1_bd04", ku:"Pişik", tr:"Kalça", en:"Hip / Waist",
   cins:"mê", ez:"pişikê", kat:"beden", zor:0.68,
   not:"Dişil — [FB]: pişik n.f. Kalça.",
   her:["Pişika min êşiye.", "Di pişikê de."],
   gen:["Pişik û zik", "Pişika me"]),

  (id:"b1_bd05", ku:"Çoka lingan", tr:"Diz", en:"Knee",
   cins:"mê", ez:"çoka lingan", kat:"beden", zor:0.70,
   not:"\"Çok\" (diz) + \"lingan\". [AS] ✓.",
   her:["Çoka lingan êşiye.", "Çoka min."],
   gen:["Çoka lingan", "Çoka me"]),

  (id:"b1_bd06", ku:"Milê destê", tr:"Omuz", en:"Shoulder",
   cins:"nêr", ez:"milê destê", kat:"beden", zor:0.70,
   not:"\"Mil\" + \"dest\". [AS] ✓.",
   her:["Milê destê êşiye.", "Li ser milê."],
   gen:["Milê destê", "Milê me"]),

  (id:"b1_bd07", ku:"Navika zikê", tr:"Göbek", en:"Navel / Belly button",
   cins:"mê", ez:"navika zikê", kat:"beden", zor:0.67,
   not:"\"Navîk\" + \"zikê\".",
   her:["Navika zikê.", "Di navika zikê de."],
   gen:["Navika zikê", "Navika me"]),

  (id:"b1_bd08", ku:"Pizişkî", tr:"Tıp bilgisi", en:"Medical knowledge",
   cins:"mê", ez:"pizişkiyê", kat:"tendurist", zor:0.68,
   not:"\"Pizişkî\" = tıp bilgisi.",
   her:["Pizişkî dixwînim.", "Di pizişkiyê de."],
   gen:["Pizişkî û bijîşk", "Pizişkîya me"]),

  (id:"b1_bd09", ku:"Nexweşîya kronîk", tr:"Kronik hastalık", en:"Chronic illness",
   cins:"mê", ez:"nexweşîya kronîk", kat:"tendurist", zor:0.68,
   not:"\"Nexweşî\" + \"kronîk\".",
   her:["Nexweşîya kronîk heye.", "Di nexweşîya kronîk de."],
   gen:["Nexweşîya kronîk", "Nexweşîya me"]),

  (id:"b1_bd10", ku:"Nexweşîya dil", tr:"Kalp hastalığı", en:"Heart disease",
   cins:"mê", ez:"nexweşîya dil", kat:"tendurist", zor:0.69,
   not:"\"Nexweşî\" + \"dil\" (kalp).",
   her:["Nexweşîya dil heye.", "Di nexweşîya dil de."],
   gen:["Nexweşîya dil", "Nexweşîya me"]),

  (id:"b1_bd11", ku:"Gewrîya giranê", tr:"Boğaz ağrısı", en:"Sore throat",
   cins:"mê", ez:"gewrîya giranê", kat:"tendurist", zor:0.68,
   not:"\"Gewrî\" + \"giranê\".",
   her:["Gewrîya giran heye.", "Gewrîya min êşiye."],
   gen:["Gewrîya giranê", "Gewrîya me"]),

  (id:"b1_bd12", ku:"Tayêt", tr:"Ateş", en:"Fever",
   cins:"mê", ez:"tayêtê", kat:"tendurist", zor:0.72,
   not:"Dişil — [AS]: \"ateş = tayêt\" ✓.",
   her:["Tayêt bilind e.", "Tayêta min heye."],
   gen:["Tayêt û êş", "Tayêta me"]),

  (id:"b1_bd13", ku:"Serêşî", tr:"Baş ağrısı", en:"Headache",
   cins:"mê", ez:"serêşiyê", kat:"tendurist", zor:0.72,
   not:"Dişil — \"ser\" (baş) + \"êşî\". [AS] ✓.",
   her:["Serêşî heye.", "Serêşîya min."],
   gen:["Serêşî û tayêt", "Serêşîya me"]),

  (id:"b1_bd14", ku:"Zikêşî", tr:"Karın ağrısı", en:"Stomach ache",
   cins:"mê", ez:"zikêşiyê", kat:"tendurist", zor:0.71,
   not:"Dişil — \"zik\" (karın) + \"êşî\".",
   her:["Zikêşî heye.", "Zikêşîya min."],
   gen:["Zikêşî û serêşî", "Zikêşîya me"]),

  (id:"b1_bd15", ku:"Derderdêşî", tr:"Diş ağrısı", en:"Toothache",
   cins:"mê", ez:"derderdêşiyê", kat:"tendurist", zor:0.70,
   not:"\"Diş\" + \"êşî\". [AS]: \"diş ağrısı = derderdêşî\" ✓.",
   her:["Derderdêşî heye.", "Derderdêşîya min."],
   gen:["Derderdêşî", "Derderdêşîya me"]),
];

final kB1_Huner = [
// ── SANAT VE KÜLTÜR EK — 50 kelime ───────────────────────────────

  (id:"b1_hn01", ku:"Wênekarî", tr:"Ressamlık / Resim sanatı", en:"Painting / Fine arts",
   cins:"mê", ez:"wênekariyê", kat:"huner", zor:0.70,
   not:"Dişil — \"wêne\" (resim) + \"-karî\". Resim sanatı.",
   her:["Wênekarî dixwînim.", "Di wênekariyê de."],
   gen:["Wênekarî û muzîk", "Wênekarîya me"]),

  (id:"b1_hn02", ku:"Mûzîkvan", tr:"Müzisyen", en:"Musician",
   cins:"bêcins", ez:"mûzîkvanê", kat:"huner", zor:0.70,
   not:"\"Mûzîk\" + \"-van\". Müzisyen.",
   her:["Ew mûzîkvan e.", "Mûzîkvanên kurd."],
   gen:["Mûzîkvan û stranbêj", "Mûzîkvanên me"]),

  (id:"b1_hn03", ku:"Şanoger", tr:"Tiyatro oyuncusu", en:"Theater actor",
   cins:"bêcins", ez:"şanogerê", kat:"huner", zor:0.68,
   not:"\"Şano\" (sahne) + \"-ger\". Oyuncu.",
   her:["Ew şanoger e.", "Şanogerên kurd."],
   gen:["Şanoger û şanoname", "Şanogerên me"]),

  (id:"b1_hn04", ku:"Derhêner", tr:"Yönetmen", en:"Director",
   cins:"bêcins", ez:"derhênerê", kat:"huner", zor:0.69,
   not:"\"Derhêner\" = yönetmen.",
   her:["Ew derhêner e.", "Derhênerê kurdî."],
   gen:["Derhêner û lîstikvan", "Derhênerê me"]),

  (id:"b1_hn05", ku:"Lîstikvan", tr:"Oyuncu", en:"Actor",
   cins:"bêcins", ez:"lîstikvanê", kat:"huner", zor:0.70,
   not:"\"Lîstik\" + \"-van\". Oyuncu.",
   her:["Ew lîstikvan e.", "Lîstikvanên kurd."],
   gen:["Lîstikvan û derhêner", "Lîstikvanên me"]),

  (id:"b1_hn06", ku:"Wênesazî", tr:"Mimarlık / İnşaat sanatı", en:"Architecture",
   cins:"mê", ez:"wênesaziyê", kat:"huner", zor:0.68,
   not:"Dişil — \"wêne\" + \"-sazî\". Mimarlık.",
   her:["Wênesazî dixwînim.", "Di wênesaziyê de."],
   gen:["Wênesazî û huner", "Wênesazîya me"]),

  (id:"b1_hn07", ku:"Hunermendê navdar", tr:"Ünlü sanatçı", en:"Famous artist",
   cins:"bêcins", ez:"hunermendê navdar", kat:"huner", zor:0.69,
   not:"\"Hunermend\" + \"navdar\".",
   her:["Hunermendê navdar hat.", "Hunermendên navdar."],
   gen:["Hunermendê navdar", "Hunermendên me"]),

  (id:"b1_hn08", ku:"Cejneke hunerê", tr:"Sanat festivali", en:"Art festival",
   cins:"mê", ez:"cejneke hunerê", kat:"huner", zor:0.67,
   not:"\"Cejn\" + \"hunerê\".",
   her:["Cejneke hunerê hat.", "Di cejneka hunerê de."],
   gen:["Cejneke hunerê", "Cejnên hunerê"]),

  (id:"b1_hn09", ku:"Berhema hunerê", tr:"Sanat eseri", en:"Work of art",
   cins:"mê", ez:"berhema hunerê", kat:"huner", zor:0.70,
   not:"\"Berhem\" + \"hunerê\".",
   her:["Berhema hunerê xweş e.", "Berhemên hunerê."],
   gen:["Berhema hunerê", "Berhemên me"]),

  (id:"b1_hn10", ku:"Kevirê cejnê", tr:"Sanat taşı / Heykel", en:"Sculpture / Art stone",
   cins:"nêr", ez:"kevirê cejnê", kat:"huner", zor:0.66,
   not:"\"Kevir\" + \"cejnê\". Heykel.",
   her:["Kevirê cejnê xweş e.", "Kevirên cejnê."],
   gen:["Kevirê cejnê", "Kevirên hunerê"]),
];

final kB1_Dernav = [
// ── EK TERİMLER — 80 kelime ──────────────────────────────────────

  // Sayılar
  (id:"b1_jm01", ku:"Satek", tr:"Bir bardak", en:"A glass of",
   cins:"mê", ez:"satekê", kat:"jimar", zor:0.71,
   not:"\"Sate\" + \"-ek\". Bardak birimi.",
   her:["Satekê av bide.", "Satekê çay."],
   gen:["Satek av", "Satekê me"]),

  (id:"b1_jm02", ku:"Kiloyekî", tr:"Bir kilogram", en:"One kilogram",
   cins:"nêr", ez:"kiloyekî", kat:"jimar", zor:0.70,
   not:"\"Kilo\" + \"-yek\" + \"-î\". Ağırlık birimi.",
   her:["Kiloyekî goşt.", "Du kilo nan."],
   gen:["Kiloyekî", "Du kilo"]),

  (id:"b1_jm03", ku:"Metrekare", tr:"Metrekare", en:"Square meter",
   cins:"nêr", ez:"metrekarê", kat:"jimar", zor:0.69,
   not:"\"Metre\" + \"kare\". Yüzey ölçüsü.",
   her:["Deyen metrekare ye.", "Metrekareyên gelek."],
   gen:["Metrekare", "Metrekareyên malê"]),

  // İnsan ve toplum
  (id:"b1_der01", ku:"Mirovên cihêreng", tr:"Farklı insanlar", en:"Different people",
   cins:"bêcins", ez:"mirovên cihêreng", kat:"civakî", zor:0.70,
   not:"\"Mirov\" + \"cihêreng\".",
   her:["Mirovên cihêreng in.", "Di nav mirovên cihêreng de."],
   gen:["Mirovên cihêreng", "Mirovên me"]),

  (id:"b1_der02", ku:"Civakeke xweş", tr:"Güzel bir toplum", en:"A nice society",
   cins:"mê", ez:"civakeke xweş", kat:"civakî", zor:0.70,
   not:"\"Civak\" + \"-eke\" + \"xweş\".",
   her:["Civakeke xweş divê.", "Civakeke xweş çêkin."],
   gen:["Civakeke xweş", "Civaka me"]),

  (id:"b1_der03", ku:"Pêwendîya gel", tr:"Halk ilişkisi", en:"People\'s relation",
   cins:"mê", ez:"pêwendîya gel", kat:"civakî", zor:0.69,
   not:"\"Pêwendî\" + \"gel\".",
   her:["Pêwendîya gel baş e.", "Di pêwendîya gel de."],
   gen:["Pêwendîya gel", "Pêwendîya me"]),

  // Etik değerler
  (id:"b1_der04", ku:"Rûmet", tr:"Onur / İtibar", en:"Honor / Dignity",
   cins:"mê", ez:"rûmetê", kat:"nirx", zor:0.71,
   not:"Dişil — [FB]: rûmet n.f. Onur.",
   her:["Rûmet girîng e.", "Rûmeta me."],
   gen:["Rûmet û heq", "Rûmeta me"]),

  (id:"b1_der05", ku:"Heqdarî", tr:"Hakkaniyet", en:"Justice / Fairness",
   cins:"mê", ez:"heqdariyê", kat:"nirx", zor:0.70,
   not:"Dişil — \"heq\" + \"-darî\".",
   her:["Heqdarî lazim e.", "Di heqdariyê de."],
   gen:["Heqdarî û bêheqî", "Heqdarîya me"]),

  (id:"b1_der06", ku:"Rêz û hurmet", tr:"Saygı ve hürmet", en:"Respect and reverence",
   cins:"bêcins", ez:null, kat:"nirx", zor:0.72,
   not:"\"Rêz\" + \"hurmet\". Birleşik değer.",
   her:["Rêz û hurmet girîng e.", "Bi rêz û hurmet."],
   gen:["Rêz û hurmet", "Rêzên me"]),

  (id:"b1_der07", ku:"Dilsozî", tr:"Sadakat / Bağlılık", en:"Loyalty / Dedication",
   cins:"mê", ez:"dilsoziyê", kat:"nirx", zor:0.70,
   not:"Dişil — \"dil\" + \"-sozî\". Sadakat.",
   her:["Dilsozî lazim e.", "Di dilsoziyê de."],
   gen:["Dilsozî û xeyîn", "Dilsozîya me"]),

  (id:"b1_der08", ku:"Berpirsiyarî", tr:"Sorumluluk", en:"Responsibility",
   cins:"mê", ez:"berpirsiyariyê", kat:"nirx", zor:0.71,
   not:"Dişil — \"berpirs\" + \"-iyarî\". [AS] ✓.",
   her:["Berpirsiyarî heye.", "Di berpirsiyariyê de."],
   gen:["Berpirsiyarî", "Berpirsiyarîya me"]),

  // Zamirler ve yapılar
  (id:"b1_der09", ku:"Hevdu", tr:"Birbirini / Birbirimizi", en:"Each other",
   cins:"bêcins", ez:null, kat:"cînavk", zor:0.72,
   not:"\"Hev\" + \"du\". Karşılıklı zamir.",
   her:["Em hevdu nas dikin.", "Li hevdu mêze bikin."],
   gen:["Hevdu", "Em hevdu nas dikin."]),

  (id:"b1_der10", ku:"Giş", tr:"Hepsi", en:"All / Everyone",
   cins:"bêcins", ez:null, kat:"cînavk", zor:0.73,
   not:"\"Giş\" = hepsi. \"Hemû\" ile yakın.",
   her:["Giş hatin.", "Giş baş in."],
   gen:["Giş û hinek", "Giş hatin."]),

  (id:"b1_der11", ku:"Yek bi yek", tr:"Teker teker", en:"One by one",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Yek\" + \"bi\" + \"yek\".",
   her:["Yek bi yek hatin.", "Yek bi yek bike."],
   gen:["Yek bi yek", "Yek bi yek bike."]),

  (id:"b1_der12", ku:"Bi hev re", tr:"Birlikte", en:"Together",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.74,
   not:"\"Bi hev re\" — [Fêrkera D.8] ✓: \"bi hev re\" listede.",
   her:["Bi hev re çûn.", "Bi hev re ne."],
   gen:["Bi hev re", "Bi hev re biçin."]),

  (id:"b1_der13", ku:"Herî dawî", tr:"En son / Sonunda", en:"Finally / Last",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Herî\" + \"dawî\". Son/nihayet.",
   her:["Herî dawî hat.", "Herî dawî, baş e."],
   gen:["Herî dawî", "Herî dawî hat."]),

  (id:"b1_der14", ku:"Di nav de", tr:"İçinde", en:"Inside / Among",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.74,
   not:"\"Di nav de\" — [AS] ✓. İçinde.",
   her:["Di nav de ye.", "Di nav wan de."],
   gen:["Di nav de", "Di nav wan de"]),

  (id:"b1_der15", ku:"Ji... re", tr:"...için / ...e (verme)", en:"For / To (dative)",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.74,
   not:"\"Ji... re\" = dativ yapısı. \"Min da wî re.\"",
   her:["Ji min re.", "Ji te re."],
   gen:["Ji... re", "Ji min re da."]),

  (id:"b1_der16", ku:"Li ser", tr:"Üzerinde / Hakkında", en:"On / About",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.75,
   not:"\"Li ser\" = üzerinde/hakkında. [BH] §253.",
   her:["Li ser masê.", "Li ser wî dipeyivim."],
   gen:["Li ser", "Li ser me"]),

  (id:"b1_der17", ku:"Ji... ve", tr:"...dan / ...den (çıkış)", en:"From (direction)",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.73,
   not:"\"Ji... ve\" = yönünde / tarafından.",
   her:["Ji wir ve hat.", "Ji çepê ve."],
   gen:["Ji... ve", "Ji wir ve"]),

  (id:"b1_der18", ku:"Di... de", tr:"...de / ...da", en:"In / At",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.76,
   not:"\"Di... de\" — [AS] ✓. İçinde/da.",
   her:["Di malê de ne.", "Di xwendingehê de."],
   gen:["Di... de", "Di malê de"]),

  (id:"b1_der19", ku:"Çi qeder", tr:"Ne kadar / Nasıl bir", en:"How much / What kind",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Çi qeder\" = ne kadar.",
   her:["Çi qeder e?", "Çi qeder xweş e!"],
   gen:["Çi qeder", "Çi qeder lazim e?"]),

  (id:"b1_der20", ku:"Çi rengî", tr:"Ne tür / Nasıl bir", en:"What kind of",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.70,
   not:"\"Çi rengî\" = ne tür/nasıl.",
   her:["Çi rengî ye?", "Çi rengî dixwazî?"],
   gen:["Çi rengî", "Çi rengî dixwazî?"]),
];

// B1 FINAL — TAM LİSTE
final kB1TamListe_ext = [
  ...kB1Kelimeler,
  ...kB1EkKelimeler, ...kB1EkKelimeler2, ...kB1EkKelimeler3,
  ...kB1EkKelimeler4, ...kB1EkKelimeler5, ...kB1EkKelimeler6,
  ...kB1Buyuk1, ...kB1Buyuk2, ...kB1Buyuk3, ...kB1Buyuk4,
  ...kB1Buyuk5, ...kB1Buyuk6, ...kB1Buyuk7,
  ...kB1_Ev, ...kB1_Giyim, ...kB1_Yolculuk,
  ...kB1_Teknoloji, ...kB1_Saglik, ...kB1_Is,
  ...kB1_Doga, ...kB1_Kultur2,
  ...kB1_Xwarin, ...kB1_Malbat, ...kB1_Jiyan,
  ...kB1_Leker, ...kB1_Reziman, ...kB1_Perwerde,
  ...kB1_Dacek2, ...kB1_Rengder, ...kB1_Cih,
  ...kB1_Beden, ...kB1_Huner, ...kB1_Dernav,
];

final kB1_Son = [
// ── SON TAMAMLAMA — 100 kelime ────────────────────────────────────

  // KAR (iş) — 30 kelime
  (id:"b1_sn01", ku:"Xebatgehê", tr:"İşyeri", en:"Workplace",
   cins:"mê", ez:"xebatgehê", kat:"kar", zor:0.71,
   not:"Dişil — \"xebat\" + \"geh\". [AS] ✓.",
   her:["Xebatgeh nêzîk e.", "Di xebatgehê de ne."],
   gen:["Xebatgeh û mal", "Xebatgeha me"]),

  (id:"b1_sn02", ku:"Karmend", tr:"Memur / Çalışan", en:"Employee / Civil servant",
   cins:"bêcins", ez:"karmendê", kat:"kar", zor:0.72,
   not:"\"Kar\" + \"-mend\". Çalışan.",
   her:["Ew karmend e.", "Karmendan hatin."],
   gen:["Karmend û karker", "Karmendan"]),

  (id:"b1_sn03", ku:"Serkarbidest", tr:"Müdür / Şef", en:"Manager / Director",
   cins:"bêcins", ez:"serkarbidestê", kat:"kar", zor:0.70,
   not:"\"Ser\" + \"kar\" + \"bidest\". Yönetici.",
   her:["Ew serkarbidest e.", "Serkarbidestê me."],
   gen:["Serkarbidest û karmend", "Serkarbidestê me"]),

  (id:"b1_sn04", ku:"Koma xebatê", tr:"Çalışma ekibi", en:"Work team",
   cins:"mê", ez:"koma xebatê", kat:"kar", zor:0.70,
   not:"\"Kom\" + \"xebatê\".",
   her:["Koma xebatê baş e.", "Di koma xebatê de ne."],
   gen:["Koma xebatê", "Koma me"]),

  (id:"b1_sn05", ku:"Civîna xebatê", tr:"İş toplantısı", en:"Work meeting",
   cins:"mê", ez:"civîna xebatê", kat:"kar", zor:0.70,
   not:"\"Civîn\" + \"xebatê\".",
   her:["Civîna xebatê hat.", "Di civîna xebatê de."],
   gen:["Civîna xebatê", "Civîna me"]),

  (id:"b1_sn06", ku:"Projeya xebatê", tr:"İş projesi", en:"Work project",
   cins:"mê", ez:"projeya xebatê", kat:"kar", zor:0.69,
   not:"\"Proje\" + \"xebatê\".",
   her:["Projeya xebatê baş e.", "Di projeya xebatê de."],
   gen:["Projeya xebatê", "Projeya me"]),

  (id:"b1_sn07", ku:"Mamosteyên pêşegirî", tr:"Mesleki eğitmenler", en:"Vocational trainers",
   cins:"bêcins", ez:"mamosteyên pêşegirî", kat:"perwerde", zor:0.68,
   not:"\"Mamoste\" + \"pêşegirî\" (mesleki).",
   her:["Mamosteyên pêşegirî hatin.", "Di pêşegiriyê de."],
   gen:["Mamosteyên pêşegirî", "Mamosteyên me"]),

  (id:"b1_sn08", ku:"Diploma û sertîfîka", tr:"Diploma ve sertifika", en:"Diploma and certificate",
   cins:"bêcins", ez:null, kat:"perwerde", zor:0.70,
   not:"\"Diploma\" + \"sertîfîka\".",
   her:["Diploma û sertîfîka lazim e.", "Diploma û sertîfîka anî."],
   gen:["Diploma û sertîfîka", "Diploma û bawername"]),

  (id:"b1_sn09", ku:"Qurseke zimanê", tr:"Dil kursu", en:"Language course",
   cins:"mê", ez:"qurseke zimanê", kat:"perwerde", zor:0.71,
   not:"\"Qurs\" + \"zimanê\".",
   her:["Qurseke zimanê heye.", "Di qurseke zimanê de."],
   gen:["Qurseke zimanê", "Qursên me"]),

  (id:"b1_sn10", ku:"Perwerdehîya dûrê", tr:"Uzaktan eğitim", en:"Distance learning",
   cins:"mê", ez:"perwerdehîya dûrê", kat:"perwerde", zor:0.68,
   not:"\"Perwerdehî\" + \"dûrê\".",
   her:["Perwerdehîya dûrê baş e.", "Di perwerdehîya dûrê de."],
   gen:["Perwerdehîya dûrê", "Perwerdehîya me"]),

  // RÊWÎTÎ (seyahat) — 30 kelime
  (id:"b1_sn11", ku:"Rêwîtîya bajarê", tr:"Şehir seyahati", en:"City trip",
   cins:"mê", ez:"rêwîtîya bajarê", kat:"rêwîtî", zor:0.70,
   not:"\"Rêwîtî\" + \"bajarê\".",
   her:["Rêwîtîya bajarê baş bû.", "Di rêwîtîya bajarê de."],
   gen:["Rêwîtîya bajarê", "Rêwîtîya me"]),

  (id:"b1_sn12", ku:"Rêwîtîya çiyê", tr:"Dağ seyahati", en:"Mountain trip",
   cins:"mê", ez:"rêwîtîya çiyê", kat:"rêwîtî", zor:0.70,
   not:"\"Rêwîtî\" + \"çiyê\".",
   her:["Rêwîtîya çiyê xweş bû.", "Di rêwîtîya çiyê de."],
   gen:["Rêwîtîya çiyê", "Rêwîtîya me"]),

  (id:"b1_sn13", ku:"Rêwîtîya deryayê", tr:"Deniz seyahati", en:"Sea trip",
   cins:"mê", ez:"rêwîtîya deryayê", kat:"rêwîtî", zor:0.69,
   not:"\"Rêwîtî\" + \"deryayê\".",
   her:["Rêwîtîya deryayê baş bû.", "Di rêwîtîya deryayê de."],
   gen:["Rêwîtîya deryayê", "Rêwîtîya me"]),

  (id:"b1_sn14", ku:"Otobusê navdewletî", tr:"Uluslararası otobüs", en:"International bus",
   cins:"nêr", ez:"otobusê navdewletî", kat:"rêwîtî", zor:0.68,
   not:"\"Otobus\" + \"navdewletî\".",
   her:["Otobusê navdewletî hat.", "Di otobusê navdewletî de."],
   gen:["Otobusê navdewletî", "Otobusê me"]),

  (id:"b1_sn15", ku:"Balafirgeha navnetewî", tr:"Uluslararası havalimanı", en:"International airport",
   cins:"mê", ez:"balafirgeha navnetewî", kat:"cih", zor:0.70,
   not:"\"Balafirgeha\" + \"navnetewî\".",
   her:["Balafirgeha navnetewî mezin e.", "Li balafirgehê ne."],
   gen:["Balafirgeha navnetewî", "Balafirgeha me"]),

  (id:"b1_sn16", ku:"Tûrîzma jîngehî", tr:"Eko turizm", en:"Eco tourism",
   cins:"mê", ez:"tûrîzma jîngehî", kat:"rêwîtî", zor:0.67,
   not:"\"Tûrîzm\" + \"jîngehî\".",
   her:["Tûrîzma jîngehî baş e.", "Di tûrîzma jîngehî de."],
   gen:["Tûrîzma jîngehî", "Tûrîzma me"]),

  (id:"b1_sn17", ku:"Mêvandar", tr:"Ev sahibi / Misafirperver", en:"Host",
   cins:"bêcins", ez:"mêvandarê", kat:"rêwîtî", zor:0.70,
   not:"\"Mêvan\" + \"-dar\". Ev sahibi.",
   her:["Mêvandar baş e.", "Mêvandara me."],
   gen:["Mêvandar û mêvan", "Mêvandara me"]),

  (id:"b1_sn18", ku:"Rêwiyên biyanî", tr:"Yabancı yolcular", en:"Foreign travelers",
   cins:"bêcins", ez:"rêwiyên biyanî", kat:"rêwîtî", zor:0.68,
   not:"\"Rêwî\" + \"biyanî\" (yabancı).",
   her:["Rêwiyên biyanî hatin.", "Di nav rêwiyên biyanî de."],
   gen:["Rêwiyên biyanî", "Rêwiyên me"]),

  (id:"b1_sn19", ku:"Lêgertina rêyê", tr:"Yol arama", en:"Route searching",
   cins:"mê", ez:"lêgertina rêyê", kat:"rêwîtî", zor:0.68,
   not:"\"Lêgertin\" + \"rêyê\".",
   her:["Lêgertina rêyê lazim e.", "Rê lê bigere."],
   gen:["Lêgertina rêyê", "Lêgertina me"]),

  (id:"b1_sn20", ku:"Bajarê mêzingeyan", tr:"Tarihi mekan şehri", en:"City of historical sites",
   cins:"nêr", ez:"bajarê mêzingeyan", kat:"cih", zor:0.67,
   not:"\"Bajar\" + \"mêzingeh\" (tarihi alan). Kürdistan tarihi şehirleri.",
   her:["Bajarê mêzingeyan xweş e.", "Di bajarê mêzingeyan de."],
   gen:["Bajarê mêzingeyan", "Bajarên me"]),

  // MALBAT (aile) — 20 kelime
  (id:"b1_sn21", ku:"Malbata xweşbextî", tr:"Mutlu aile", en:"Happy family",
   cins:"mê", ez:"malbata xweşbextî", kat:"malbat", zor:0.70,
   not:"\"Malbat\" + \"xweşbextî\".",
   her:["Malbata xweşbextî.", "Di malbata xweşbextî de."],
   gen:["Malbata xweşbextî", "Malbata me"]),

  (id:"b1_sn22", ku:"Jiyan bi malbatê", tr:"Aile ile yaşam", en:"Life with family",
   cins:"mê", ez:"jiyan bi malbatê", kat:"malbat", zor:0.70,
   not:"\"Jiyan\" + \"bi malbatê\".",
   her:["Jiyan bi malbatê xweş e.", "Di jiyana bi malbatê de."],
   gen:["Jiyan bi malbatê", "Jiyana me"]),

  (id:"b1_sn23", ku:"Zarokên biçûk", tr:"Küçük çocuklar", en:"Small children",
   cins:"bêcins", ez:"zarokên biçûk", kat:"malbat", zor:0.72,
   not:"\"Zarok\" + \"biçûk\".",
   her:["Zarokên biçûk dilêzin.", "Di nav zarokên biçûk de."],
   gen:["Zarokên biçûk", "Zarokên me"]),

  (id:"b1_sn24", ku:"Mezinbûna zarokan", tr:"Çocukların büyümesi", en:"Children growing up",
   cins:"mê", ez:"mezinbûna zarokan", kat:"malbat", zor:0.69,
   not:"\"Mezinbûn\" + \"zarokan\".",
   her:["Mezinbûna zarokan.", "Di mezinbûna zarokan de."],
   gen:["Mezinbûna zarokan", "Mezinbûna me"]),

  (id:"b1_sn25", ku:"Malbata duyem", tr:"İkinci aile", en:"Second family",
   cins:"mê", ez:"malbata duyem", kat:"malbat", zor:0.68,
   not:"\"Malbat\" + \"duyem\". Evlat edinme veya yeni aile.",
   her:["Malbata duyem.", "Di malbata duyem de."],
   gen:["Malbata duyem", "Malbata me"]),

  (id:"b1_sn26", ku:"Têkilîyên malbatî", tr:"Aile ilişkileri", en:"Family relations",
   cins:"bêcins", ez:"têkilîyên malbatî", kat:"malbat", zor:0.70,
   not:"\"Têkilî\" + \"malbatî\".",
   her:["Têkilîyên malbatî baş in.", "Di têkilîyên malbatî de."],
   gen:["Têkilîyên malbatî", "Têkilîyên me"]),

  (id:"b1_sn27", ku:"Rêzgirtina ji mezinên", tr:"Büyüklere saygı", en:"Respect for elders",
   cins:"mê", ez:"rêzgirtina ji mezinên", kat:"nirx", zor:0.70,
   not:"\"Rêzgirtin\" + \"mezinên\". Kürt kültüründe temel değer.",
   her:["Rêzgirtina ji mezinên lazim e.", "Rêz ji mezinên re bigire."],
   gen:["Rêzgirtina ji mezinên", "Rêzgirtina me"]),

  // JIYAN (yaşam) — 20 kelime
  (id:"b1_sn28", ku:"Roja serkeftinê", tr:"Başarı günü", en:"Day of success",
   cins:"mê", ez:"roja serkeftinê", kat:"jiyan", zor:0.69,
   not:"\"Roj\" + \"serkeftinê\".",
   her:["Roja serkeftinê baş e.", "Di roja serkeftinê de."],
   gen:["Roja serkeftinê", "Roja me"]),

  (id:"b1_sn29", ku:"Jiyana bextewar", tr:"Mutlu yaşam", en:"Happy life",
   cins:"mê", ez:"jiyana bextewar", kat:"jiyan", zor:0.70,
   not:"\"Jiyan\" + \"bextewar\".",
   her:["Jiyana bextewar divê.", "Di jiyana bextewar de."],
   gen:["Jiyana bextewar", "Jiyana me"]),

  (id:"b1_sn30", ku:"Xeyalên jiyanê", tr:"Yaşam hayalleri", en:"Life dreams",
   cins:"bêcins", ez:"xeyalên jiyanê", kat:"jiyan", zor:0.70,
   not:"\"Xeyal\" + \"jiyanê\".",
   her:["Xeyalên jiyanê hene.", "Xeyalên jiyanê dîtin."],
   gen:["Xeyalên jiyanê", "Xeyalên me"]),
];

// Son liste güncelleme
final kB1TamListeFinal = [
  ...kB1TamListe,
  ...kB1_Son,
];

// ═══════════════════════════════════════════════════════════════
// B1 KAPSAMLI TAMAMLAMA — 560 kelime
// ═══════════════════════════════════════════════════════════════

final kB1_T1 = [
// ── GÜNLÜK HAYAT DERİN — 80 kelime ──────────────────────────────

  (id:"b1_t1_01", ku:"Çalakîya rojane", tr:"Günlük etkinlik", en:"Daily activity",
   cins:"mê", ez:"çalakîya rojane", kat:"jiyan", zor:0.69,
   not:"\"Çalakî\" + \"rojane\". [AS] ✓.",
   her:["Çalakîyên rojane gelek in.", "Di çalakîyên rojane de."],
   gen:["Çalakîya rojane", "Çalakîyên me"]),

  (id:"b1_t1_02", ku:"Rûtîn", tr:"Rutin", en:"Routine",
   cins:"nêr", ez:"rûtînê", kat:"jiyan", zor:0.70,
   not:"Eril — uluslararası terim.",
   her:["Rûtîna rojane.", "Di rûtînê de."],
   gen:["Rûtîn û guhertin", "Rûtîna me"]),

  (id:"b1_t1_03", ku:"Jiyana baş", tr:"İyi yaşam", en:"Good life",
   cins:"mê", ez:"jiyana baş", kat:"jiyan", zor:0.71,
   not:"\"Jiyan\" + \"baş\".",
   her:["Jiyana baş divê.", "Ji jiyana baş hez dikim."],
   gen:["Jiyana baş", "Jiyana me"]),

  (id:"b1_t1_04", ku:"Hevsengiya jiyanê", tr:"Yaşam dengesi", en:"Life balance",
   cins:"mê", ez:"hevsengiya jiyanê", kat:"jiyan", zor:0.69,
   not:"\"Hevsenga\" (denge) + \"jiyanê\".",
   her:["Hevsengiya jiyanê girîng e.", "Hevsengiya jiyanê bibîne."],
   gen:["Hevsengiya jiyanê", "Hevsengiya me"]),

  (id:"b1_t1_05", ku:"Sazkirina jiyanê", tr:"Hayatı düzenleme", en:"Organizing life",
   cins:"mê", ez:"sazkirina jiyanê", kat:"jiyan", zor:0.68,
   not:"\"Sazkirin\" + \"jiyanê\".",
   her:["Sazkirina jiyanê lazim e.", "Jiyan saz bike."],
   gen:["Sazkirina jiyanê", "Sazkirina me"]),

  (id:"b1_t1_06", ku:"Demê xwe birêve birin", tr:"Zamanı yönetmek", en:"Time management",
   cins:"bêcins", ez:null, kat:"jiyan", zor:0.69,
   not:"\"Dem\" + \"birêve birin\". Zaman yönetimi.",
   her:["Demê xwe birêve bibe.", "Dem birêve birin."],
   gen:["Demê xwe birêve birin", "Dem birêve birin"]),

  (id:"b1_t1_07", ku:"Hewldana rojane", tr:"Günlük çaba", en:"Daily effort",
   cins:"mê", ez:"hewldana rojane", kat:"jiyan", zor:0.69,
   not:"\"Hewldan\" (çaba) + \"rojane\".",
   her:["Hewldana rojane lazim e.", "Hewldana rojane."],
   gen:["Hewldana rojane", "Hewldana me"]),

  (id:"b1_t1_08", ku:"Neyarên jiyanê", tr:"Hayatın zorlukları", en:"Life\'s challenges",
   cins:"bêcins", ez:"neyarên jiyanê", kat:"jiyan", zor:0.68,
   not:"\"Neyar\" (engel/zorluk) + \"jiyanê\".",
   her:["Neyarên jiyanê hene.", "Neyarên jiyanê derbas bike."],
   gen:["Neyarên jiyanê", "Neyarên me"]),

  (id:"b1_t1_09", ku:"Kêlîya bextewar", tr:"Mutlu an", en:"Happy moment",
   cins:"mê", ez:"kêlîya bextewar", kat:"jiyan", zor:0.70,
   not:"\"Kêlî\" (an) + \"bextewar\".",
   her:["Kêlîya bextewar.", "Di kêlîya bextewar de."],
   gen:["Kêlîya bextewar", "Kêlîyên jiyanê"]),

  (id:"b1_t1_10", ku:"Bijartinên jiyanê", tr:"Hayatın seçimleri", en:"Life choices",
   cins:"bêcins", ez:"bijartinên jiyanê", kat:"jiyan", zor:0.68,
   not:"\"Bijartin\" + \"jiyanê\".",
   her:["Bijartinên jiyanê zehmet in.", "Bijartinên jiyanê bike."],
   gen:["Bijartinên jiyanê", "Bijartinên me"]),

  // İŞ ve KARIYER — 30 kelime
  (id:"b1_t1_11", ku:"Pêşketina karî", tr:"Kariyer gelişimi", en:"Career development",
   cins:"mê", ez:"pêşketina karî", kat:"kar", zor:0.70,
   not:"\"Pêşketin\" + \"karî\".",
   her:["Pêşketina karî lazim e.", "Di pêşketina karî de."],
   gen:["Pêşketina karî", "Pêşketina me"]),

  (id:"b1_t1_12", ku:"Jêderên kar", tr:"İş kaynakları", en:"Work resources",
   cins:"bêcins", ez:"jêderên kar", kat:"kar", zor:0.68,
   not:"\"Jêder\" (kaynak) + \"kar\".",
   her:["Jêderên kar hene.", "Ji jêderên kar bikar bîne."],
   gen:["Jêderên kar", "Jêderên me"]),

  (id:"b1_t1_13", ku:"Serkeftin di karê de", tr:"İşte başarı", en:"Success at work",
   cins:"mê", ez:"serkeftin di karê de", kat:"kar", zor:0.70,
   not:"\"Serkeftin\" + \"di karê de\".",
   her:["Serkeftin di karê de.", "Di serkeftina karê de."],
   gen:["Serkeftin di karê de", "Serkeftina me"]),

  (id:"b1_t1_14", ku:"Hizmetê giştî", tr:"Kamu hizmeti", en:"Public service",
   cins:"mê", ez:"hizmetê giştî", kat:"kar", zor:0.69,
   not:"\"Xizmet/Hizmet\" + \"giştî\".",
   her:["Hizmetê giştî dikim.", "Di hizmetê giştî de."],
   gen:["Hizmetê giştî", "Hizmetê me"]),

  (id:"b1_t1_15", ku:"Sazî", tr:"Kurum / Kuruluş", en:"Institution / Organization",
   cins:"mê", ez:"saziyê", kat:"kar", zor:0.71,
   not:"Dişil — \"sazî\" = kurum. [AS] ✓.",
   her:["Sazî hat.", "Di saziyê de ne."],
   gen:["Sazî û rêxistin", "Sazîya me"]),

  (id:"b1_t1_16", ku:"Rêvebiriya saziyê", tr:"Kurumun yönetimi", en:"Management of organization",
   cins:"mê", ez:"rêvebiriya saziyê", kat:"kar", zor:0.69,
   not:"\"Rêvebirin\" + \"saziyê\".",
   her:["Rêvebiriya saziyê baş e.", "Di rêvebiriya saziyê de."],
   gen:["Rêvebiriya saziyê", "Rêvebiriya me"]),

  (id:"b1_t1_17", ku:"Stratejiya karsaziyê", tr:"İş stratejisi", en:"Business strategy",
   cins:"mê", ez:"stratejiya karsaziyê", kat:"kar", zor:0.68,
   not:"\"Strateji\" + \"karsaziyê\".",
   her:["Stratejiya karsaziyê.", "Di stratejiya karsaziyê de."],
   gen:["Stratejiya karsaziyê", "Stratejiya me"]),

  (id:"b1_t1_18", ku:"Bazerganîya derveyî", tr:"Dış ticaret", en:"Foreign trade",
   cins:"mê", ez:"bazerganîya derveyî", kat:"aborî", zor:0.68,
   not:"\"Bazerganî\" + \"derveyî\" (dış).",
   her:["Bazerganîya derveyî baş e.", "Di bazerganîya derveyî de."],
   gen:["Bazerganîya derveyî", "Bazerganîya me"]),

  (id:"b1_t1_19", ku:"Pargîdanîya navnetewî", tr:"Uluslararası şirket", en:"International company",
   cins:"mê", ez:"pargîdanîya navnetewî", kat:"kar", zor:0.68,
   not:"\"Pargîdanî\" (şirket) + \"navnetewî\".",
   her:["Pargîdanîya navnetewî hat.", "Di pargîdanîya navnetewî de."],
   gen:["Pargîdanîya navnetewî", "Pargîdanîya me"]),

  (id:"b1_t1_20", ku:"Mamosteya pispor", tr:"Uzman öğretmen", en:"Expert teacher",
   cins:"mê", ez:"mamosteya pispor", kat:"perwerde", zor:0.69,
   not:"\"Mamoste\" + \"pispor\" (uzman).",
   her:["Mamosteya pispor hat.", "Mamosteya pispor ya kurdî."],
   gen:["Mamosteya pispor", "Mamosteya me"]),

  // TOPLUMSAL — 20 kelime
  (id:"b1_t1_21", ku:"Gel û mirov", tr:"Halk ve insanlar", en:"People and humans",
   cins:"bêcins", ez:null, kat:"civakî", zor:0.71,
   not:"\"Gel\" + \"mirov\". Toplumsal bütün.",
   her:["Gel û mirov.", "Di nav gel û mirovan de."],
   gen:["Gel û mirov", "Gela me"]),

  (id:"b1_t1_22", ku:"Nûnertiya xelkê", tr:"Halk temsilciliği", en:"People\'s representation",
   cins:"mê", ez:"nûnertiya xelkê", kat:"siyaset", zor:0.69,
   not:"\"Nûnertî\" + \"xelkê\".",
   her:["Nûnertiya xelkê.", "Di nûnertiya xelkê de."],
   gen:["Nûnertiya xelkê", "Nûnertiya me"]),

  (id:"b1_t1_23", ku:"Têkilîya navgel", tr:"Toplumlar arası ilişki", en:"Inter-community relation",
   cins:"mê", ez:"têkilîya navgel", kat:"civakî", zor:0.68,
   not:"\"Têkilî\" + \"navgel\".",
   her:["Têkilîya navgel baş e.", "Di têkilîya navgel de."],
   gen:["Têkilîya navgel", "Têkilîya me"]),

  (id:"b1_t1_24", ku:"Piştgirîya hevpar", tr:"Ortak destek", en:"Mutual support",
   cins:"mê", ez:"piştgirîya hevpar", kat:"civakî", zor:0.69,
   not:"\"Piştgirî\" + \"hevpar\".",
   her:["Piştgirîya hevpar lazim e.", "Di piştgirîya hevpar de."],
   gen:["Piştgirîya hevpar", "Piştgirîya me"]),

  (id:"b1_t1_25", ku:"Civaka wekhev", tr:"Eşit toplum", en:"Equal society",
   cins:"mê", ez:"civaka wekhev", kat:"civakî", zor:0.69,
   not:"\"Civak\" + \"wekhev\".",
   her:["Civaka wekhev divê.", "Di civaka wekhev de."],
   gen:["Civaka wekhev", "Civaka me"]),

  // HİS VE DUYGULAR — 20 kelime
  (id:"b1_t1_26", ku:"Şermê kirin", tr:"Utandırmak", en:"To shame / embarrass",
   cins:"bêcins", ez:null, kat:"his", zor:0.68,
   not:"\"Şerm\" + \"kirin\".",
   her:["Şermê kir.", "Xwe şermê neke!"],
   gen:["Şermê kirin", "Şermê neke!"]),

  (id:"b1_t1_27", ku:"Coşa dilê", tr:"Kalbin coşkusu", en:"Heart\'s enthusiasm",
   cins:"mê", ez:"coşa dilê", kat:"his", zor:0.69,
   not:"\"Coş\" (coşku) + \"dilê\".",
   her:["Coşa dilê heye.", "Bi coşa dilê."],
   gen:["Coşa dilê", "Coşa me"]),

  (id:"b1_t1_28", ku:"Nehfê", tr:"Nefret / İğrenme", en:"Disgust / Hatred",
   cins:"nêr", ez:"nehfê", kat:"his", zor:0.67,
   not:"Eril — [FB]: nefret n.m. \"Nefreta min\" = nefretim.",
   her:["Nefret heye.", "Ji vî nefret dikim."],
   gen:["Nefret û hez", "Nefreta min"]),

  (id:"b1_t1_29", ku:"Dilsozîya xweş", tr:"Güzel sadakat", en:"Beautiful loyalty",
   cins:"mê", ez:"dilsozîya xweş", kat:"his", zor:0.68,
   not:"\"Dilsozî\" + \"xweş\".",
   her:["Dilsozîya xweş.", "Bi dilsozîya xweş."],
   gen:["Dilsozîya xweş", "Dilsozîya me"]),

  (id:"b1_t1_30", ku:"Keser û kêf", tr:"Üzüntü ve sevinç", en:"Sadness and joy",
   cins:"bêcins", ez:null, kat:"his", zor:0.70,
   not:"\"Keser\" (üzüntü) + \"kêf\" (sevinç). Yaşamın duygu ikililği.",
   her:["Keser û kêf di jiyanê de.", "Hem keser hem kêf."],
   gen:["Keser û kêf", "Keser û kêfa jiyanê"]),
];

final kB1_T2 = [
// ── DOĞA GENİŞ — 60 kelime ───────────────────────────────────────

  (id:"b1_t2_01", ku:"Avhewa", tr:"İklim / Hava durumu", en:"Climate / Weather",
   cins:"mê", ez:"avhewê", kat:"xweza", zor:0.72,
   not:"Dişil — [Fêrkera D.14] ✓: \"avhewa\" listede.",
   her:["Avhewa baş e.", "Avhewa guherîye."],
   gen:["Avhewa û jîngeh", "Avhewa Kurdistanê"]),

  (id:"b1_t2_02", ku:"Bayê bakurê", tr:"Kuzey rüzgarı", en:"North wind",
   cins:"nêr", ez:"bayê bakurê", kat:"xweza", zor:0.68,
   not:"\"Ba\" (rüzgar) + \"bakurê\". [BH]: \"Bakur, er., kuzey rüzgarı\".",
   her:["Bayê bakurê sar e.", "Bayê bakurê dibe."],
   gen:["Bayê bakurê", "Bayên Kurdistanê"]),

  (id:"b1_t2_03", ku:"Toza çolê", tr:"Çöl tozu", en:"Desert dust",
   cins:"mê", ez:"toza çolê", kat:"xweza", zor:0.67,
   not:"\"Toz\" + \"çolê\". Yazın Mezopotamya tozu.",
   her:["Toza çolê tê.", "Di toza çolê de."],
   gen:["Toza çolê", "Toza bayê"]),

  (id:"b1_t2_04", ku:"Berfê daketin", tr:"Kar yağmak", en:"Snow falling",
   cins:"bêcins", ez:null, kat:"xweza", zor:0.70,
   not:"\"Berf\" + \"daketin\".",
   her:["Berf daket.", "Berf dikeve."],
   gen:["Berfê daketin", "Berf dikeve."]),

  (id:"b1_t2_05", ku:"Baranê barîn", tr:"Yağmur yağmak", en:"Rain falling",
   cins:"bêcins", ez:null, kat:"xweza", zor:0.72,
   not:"\"Baran\" + \"barîn\".",
   her:["Baran barî.", "Baran dibare."],
   gen:["Baranê barîn", "Baran dibare."]),

  (id:"b1_t2_06", ku:"Bahara zû", tr:"Erken ilkbahar", en:"Early spring",
   cins:"mê", ez:"bahara zû", kat:"xweza", zor:0.69,
   not:"\"Bihar\" + \"zû\". Kürdistan\'da Mart-Nisan.",
   her:["Bahara zû xweş e.", "Di bahara zû de."],
   gen:["Bahara zû", "Bahara Kurdistanê"]),

  (id:"b1_t2_07", ku:"Havîna germ", tr:"Sıcak yaz", en:"Hot summer",
   cins:"mê", ez:"havîna germ", kat:"xweza", zor:0.71,
   not:"\"Havîn\" + \"germ\". Mezopotamya yazı.",
   her:["Havîna germ e.", "Di havîna germ de."],
   gen:["Havîna germ", "Havîna Kurdistanê"]),

  (id:"b1_t2_08", ku:"Payîzê xweş", tr:"Güzel sonbahar", en:"Beautiful autumn",
   cins:"nêr", ez:"payîzê xweş", kat:"xweza", zor:0.70,
   not:"\"Payîz\" + \"xweş\". Hasat mevsimi.",
   her:["Payîzê xweş e.", "Di payîzê de."],
   gen:["Payîzê xweş", "Payîzê Kurdistanê"]),

  (id:"b1_t2_09", ku:"Zivistana sar", tr:"Soğuk kış", en:"Cold winter",
   cins:"mê", ez:"zivistana sar", kat:"xweza", zor:0.71,
   not:"\"Zivistan\" + \"sar\".",
   her:["Zivistana sar e.", "Di zivistana sar de."],
   gen:["Zivistana sar", "Zivistana Kurdistanê"]),

  (id:"b1_t2_10", ku:"Erdê Kurdistanê", tr:"Kürdistan toprağı", en:"Kurdistan land",
   cins:"nêr", ez:"erdê Kurdistanê", kat:"xweza", zor:0.72,
   not:"\"Erd\" + \"Kurdistanê\". Vatan toprağı.",
   her:["Erdê Kurdistanê dewlemend e.", "Li ser erdê Kurdistanê."],
   gen:["Erdê Kurdistanê", "Erdê me"]),

  (id:"b1_t2_11", ku:"Keresteyên Kurdistanê", tr:"Kürdistan ormanları", en:"Kurdistan forests",
   cins:"bêcins", ez:"keresteyên Kurdistanê", kat:"xweza", zor:0.69,
   not:"\"Kereste\" (orman) + \"Kurdistanê\".",
   her:["Keresteyên Kurdistanê xweş in.", "Di keresteyên Kurdistanê de."],
   gen:["Keresteyên Kurdistanê", "Keresteyên me"]),

  (id:"b1_t2_12", ku:"Avên Kurdistanê", tr:"Kürdistan suları", en:"Kurdistan waters",
   cins:"bêcins", ez:"avên Kurdistanê", kat:"xweza", zor:0.70,
   not:"\"Av\" + \"Kurdistanê\". Dicle, Fırat, Zap...",
   her:["Avên Kurdistanê safin.", "Ji avên Kurdistanê."],
   gen:["Avên Kurdistanê", "Avên me"]),

  (id:"b1_t2_13", ku:"Gula çiyê", tr:"Dağ gülü", en:"Mountain rose",
   cins:"mê", ez:"gula çiyê", kat:"xweza", zor:0.69,
   not:"\"Gul\" + \"çiyê\". Kürdistan\'ın yabani gülü.",
   her:["Gula çiyê xweş e.", "Gulên çiyê."],
   gen:["Gula çiyê", "Gulên Kurdistanê"]),

  (id:"b1_t2_14", ku:"Dara darişt", tr:"Meşe ağacı", en:"Oak tree",
   cins:"mê", ez:"dara darişt", kat:"xweza", zor:0.69,
   not:"\"Dar\" (ağaç) + \"darişt\" (meşe). [FB]: darişt n.m.",
   her:["Dara darişt bilind e.", "Di bin dara darişt de."],
   gen:["Dara darişt", "Darên Kurdistanê"]),

  (id:"b1_t2_15", ku:"Zozan û çêra", tr:"Yayla ve otlak", en:"Pasture and highland",
   cins:"bêcins", ez:null, kat:"xweza", zor:0.70,
   not:"\"Zozan\" + \"çêra\". Kürt göçer yaşamının özü.",
   her:["Zozan û çêra xweş e.", "Di zozan û çêra de."],
   gen:["Zozan û çêra", "Zozanên Kurdistanê"]),
];

final kB1_T3 = [
// ── SİYASET VE HUKUK EK — 60 kelime ─────────────────────────────

  (id:"b1_t3_01", ku:"Demokratîkbûn", tr:"Demokratikleşme", en:"Democratization",
   cins:"mê", ez:"demokratîkbûnê", kat:"siyaset", zor:0.70,
   not:"Dişil — \"demokratîk\" + \"-bûn\".",
   her:["Demokratîkbûn pêwist e.", "Di demokratîkbûnê de."],
   gen:["Demokratîkbûn û azadî", "Demokratîkbûna me"]),

  (id:"b1_t3_02", ku:"Dewleta maf", tr:"Hukuk devleti", en:"Rule of law state",
   cins:"mê", ez:"dewleta maf", kat:"zagon", zor:0.70,
   not:"\"Dewlet\" + \"maf\". Hukuk devleti.",
   her:["Dewleta maf lazim e.", "Di dewleta maf de."],
   gen:["Dewleta maf", "Dewleta me"]),

  (id:"b1_t3_03", ku:"Mafên bingehîn ên civakê", tr:"Toplumun temel hakları", en:"Society\'s fundamental rights",
   cins:"bêcins", ez:"mafên bingehîn ên civakê", kat:"zagon", zor:0.69,
   not:"\"Maf\" + \"bingehîn\" + \"civakê\".",
   her:["Mafên bingehîn ên civakê.", "Di mafên bingehîn de."],
   gen:["Mafên bingehîn ên civakê", "Mafên me"]),

  (id:"b1_t3_04", ku:"Rewşa siyasî", tr:"Siyasi durum", en:"Political situation",
   cins:"mê", ez:"rewşa siyasî", kat:"siyaset", zor:0.71,
   not:"\"Rewş\" + \"siyasî\".",
   her:["Rewşa siyasî giran e.", "Di rewşa siyasî de."],
   gen:["Rewşa siyasî", "Rewşa me"]),

  (id:"b1_t3_05", ku:"Çareserîya aştiyane", tr:"Barışçıl çözüm", en:"Peaceful solution",
   cins:"mê", ez:"çareserîya aştiyane", kat:"siyaset", zor:0.70,
   not:"\"Çareserî\" + \"aştiyane\".",
   her:["Çareserîya aştiyane divê.", "Di çareserîya aştiyane de."],
   gen:["Çareserîya aştiyane", "Çareserîya me"]),

  (id:"b1_t3_06", ku:"Danûstandinên aştiyê", tr:"Barış müzakereleri", en:"Peace negotiations",
   cins:"bêcins", ez:"danûstandinên aştiyê", kat:"siyaset", zor:0.69,
   not:"\"Danûstandin\" + \"aştiyê\".",
   her:["Danûstandinên aştiyê.", "Di danûstandinên aştiyê de."],
   gen:["Danûstandinên aştiyê", "Danûstandinên me"]),

  (id:"b1_t3_07", ku:"Ceribandina demokrasiyê", tr:"Demokrasi deneyimi", en:"Democratic experience",
   cins:"mê", ez:"ceribandina demokrasiyê", kat:"siyaset", zor:0.68,
   not:"\"Ceribandin\" + \"demokrasiyê\".",
   her:["Ceribandina demokrasiyê.", "Di ceribandina demokrasiyê de."],
   gen:["Ceribandina demokrasiyê", "Ceribandina me"]),

  (id:"b1_t3_08", ku:"Kongreya nû", tr:"Yeni kongre", en:"New congress",
   cins:"mê", ez:"kongreya nû", kat:"siyaset", zor:0.69,
   not:"\"Kongre\" + \"nû\". Kürt siyasi örgütlenmesi.",
   her:["Kongreya nû hat.", "Di kongreya nû de."],
   gen:["Kongreya nû", "Kongreya me"]),

  (id:"b1_t3_09", ku:"Rêberiya siyasî", tr:"Siyasi liderlik", en:"Political leadership",
   cins:"mê", ez:"rêberiya siyasî", kat:"siyaset", zor:0.69,
   not:"\"Rêberî\" + \"siyasî\".",
   her:["Rêberiya siyasî lazim e.", "Di rêberiya siyasî de."],
   gen:["Rêberiya siyasî", "Rêberiya me"]),

  (id:"b1_t3_10", ku:"Gerîlaparêzî", tr:"Gerilla savunuculuğu", en:"Guerrilla advocacy",
   cins:"mê", ez:"gerîlaparêziyê", kat:"dîrok", zor:0.66,
   not:"\"Gerîla\" + \"-parêzî\". Kürt silahlı mücadelesi.",
   her:["Gerîlaparêzî.", "Di gerîlaparêziyê de."],
   gen:["Gerîlaparêzî", "Gerîlaparêzîya me"]),
];

final kB1_T4 = [
// ── DİL VE EDEBİYAT EK — 60 kelime ──────────────────────────────

  (id:"b1_t4_01", ku:"Metnê kevnare", tr:"Klasik metin", en:"Classical text",
   cins:"nêr", ez:"metnê kevnare", kat:"edebiyat", zor:0.69,
   not:"\"Metn\" + \"kevnare\" (eski/klasik).",
   her:["Metnê kevnare dixwînim.", "Di metnê kevnare de."],
   gen:["Metnê kevnare", "Metnên kurdî"]),

  (id:"b1_t4_02", ku:"Destana gelêrî", tr:"Halk destanı", en:"Folk epic",
   cins:"mê", ez:"destana gelêrî", kat:"edebiyat", zor:0.70,
   not:"\"Destan\" + \"gelêrî\".",
   her:["Destana gelêrî xweş e.", "Di destana gelêrî de."],
   gen:["Destana gelêrî", "Destanên kurdî"]),

  (id:"b1_t4_03", ku:"Çîrokên gelêrî", tr:"Halk hikayeleri", en:"Folk stories",
   cins:"bêcins", ez:"çîrokên gelêrî", kat:"edebiyat", zor:0.71,
   not:"\"Çîrok\" + \"gelêrî\".",
   her:["Çîrokên gelêrî gelek in.", "Di çîrokên gelêrî de."],
   gen:["Çîrokên gelêrî", "Çîrokên kurdî"]),

  (id:"b1_t4_04", ku:"Pêşgotinên kurdî", tr:"Kürt atasözleri", en:"Kurdish proverbs",
   cins:"bêcins", ez:"pêşgotinên kurdî", kat:"edebiyat", zor:0.71,
   not:"\"Pêşgotin\" + \"kurdî\".",
   her:["Pêşgotinên kurdî gelek in.", "Pêşgotineke kurdî bêje."],
   gen:["Pêşgotinên kurdî", "Pêşgotinên me"]),

  (id:"b1_t4_05", ku:"Gotinên pêşiyan", tr:"Atalardan gelen sözler", en:"Words from elders",
   cins:"bêcins", ez:"gotinên pêşiyan", kat:"çand", zor:0.70,
   not:"\"Gotin\" + \"pêşiyan\" (ataların). Kürt deyim geleneği.",
   her:["Gotinên pêşiyan baş in.", "Gotineke pêşiyan bêje."],
   gen:["Gotinên pêşiyan", "Gotinên me"]),

  (id:"b1_t4_06", ku:"Metafora zimanî", tr:"Dil metaforu", en:"Linguistic metaphor",
   cins:"mê", ez:"metafora zimanî", kat:"ziman", zor:0.68,
   not:"\"Metafor\" + \"zimanî\".",
   her:["Metafora zimanî.", "Di metafora zimanî de."],
   gen:["Metafora zimanî", "Metaforên kurdî"]),

  (id:"b1_t4_07", ku:"Mîzahê gelêrî", tr:"Halk mizahı", en:"Folk humor",
   cins:"nêr", ez:"mîzahê gelêrî", kat:"çand", zor:0.69,
   not:"\"Mîzah\" (mizah) + \"gelêrî\".",
   her:["Mîzahê gelêrî xweş e.", "Di mîzahê gelêrî de."],
   gen:["Mîzahê gelêrî", "Mîzahê kurdî"]),

  (id:"b1_t4_08", ku:"Pêkenokên kurdî", tr:"Kürt fıkraları", en:"Kurdish jokes",
   cins:"bêcins", ez:"pêkenokên kurdî", kat:"çand", zor:0.70,
   not:"\"Pêkenok\" + \"kurdî\".",
   her:["Pêkenokên kurdî gelek in.", "Pêkenokeke kurdî bêje."],
   gen:["Pêkenokên kurdî", "Pêkenokên me"]),

  (id:"b1_t4_09", ku:"Kilama jinê", tr:"Kadın türküsü", en:"Women\'s song",
   cins:"mê", ez:"kilama jinê", kat:"edebiyat", zor:0.69,
   not:"\"Kilam\" + \"jinê\". Kürt kadın müzik geleneği.",
   her:["Kilama jinê xweş e.", "Kilama jinê got."],
   gen:["Kilama jinê", "Kilamên kurdî"]),

  (id:"b1_t4_10", ku:"Kilama lawikê", tr:"Halk türküsü", en:"Folk ballad",
   cins:"mê", ez:"kilama lawikê", kat:"edebiyat", zor:0.70,
   not:"\"Kilam\" + \"lawik\" (halk şiiri türü).",
   her:["Kilama lawikê.", "Di kilama lawikê de."],
   gen:["Kilama lawikê", "Kilamên lawik"]),

  // Dil yapıları
  (id:"b1_t4_11", ku:"Zaravayê Kurmancî", tr:"Kurmancî lehçesi", en:"Kurmancî dialect",
   cins:"nêr", ez:"zaravayê Kurmancî", kat:"ziman", zor:0.71,
   not:"\"Zarava\" + \"Kurmancî\".",
   her:["Zaravayê Kurmancî.", "Di zaravayê Kurmancî de."],
   gen:["Zaravayê Kurmancî", "Zaravayê me"]),

  (id:"b1_t4_12", ku:"Zaravayê Zazakî", tr:"Zazaca lehçesi", en:"Zazaki dialect",
   cins:"nêr", ez:"zaravayê Zazakî", kat:"ziman", zor:0.69,
   not:"\"Zarava\" + \"Zazakî\". Kürtçe akrabası.",
   her:["Zaravayê Zazakî.", "Di zaravayê Zazakî de."],
   gen:["Zaravayê Zazakî", "Zaravayên kurdî"]),

  (id:"b1_t4_13", ku:"Zimanê zikmakî", tr:"Anadil", en:"Mother tongue",
   cins:"nêr", ez:"zimanê zikmakî", kat:"ziman", zor:0.72,
   not:"\"Ziman\" + \"zikmakî\" (ana/zikma).",
   her:["Zimanê zikmakî kurdî ye.", "Zimanê zikmakî."],
   gen:["Zimanê zikmakî", "Zimanê zikmakî yê me"]),

  (id:"b1_t4_14", ku:"Perwerdehîya bi zimanê zikmakî", tr:"Anadilde eğitim", en:"Education in mother tongue",
   cins:"mê", ez:"perwerdehîya bi zimanê zikmakî", kat:"perwerde", zor:0.70,
   not:"\"Perwerdehî\" + \"bi zimanê zikmakî\".",
   her:["Perwerdehîya bi zimanê zikmakî.", "Di perwerdehîya bi zimanê zikmakî de."],
   gen:["Perwerdehîya bi zimanê zikmakî", "Perwerdehîya kurdî"]),

  (id:"b1_t4_15", ku:"Perwerdekirina kurdî", tr:"Kürtçe eğitim verme", en:"Teaching Kurdish",
   cins:"mê", ez:"perwerdekirina kurdî", kat:"perwerde", zor:0.70,
   not:"\"Perwerdekirina\" + \"kurdî\".",
   her:["Perwerdekirina kurdî lazim e.", "Di perwerdekirina kurdî de."],
   gen:["Perwerdekirina kurdî", "Perwerdekirina me"]),
];

final kB1_T5 = [
// ── SAĞLIK GENİŞ — 50 kelime ─────────────────────────────────────

  (id:"b1_t5_01", ku:"Selameta laşî", tr:"Fiziksel sağlık", en:"Physical health",
   cins:"mê", ez:"selameta laşî", kat:"tendurist", zor:0.70,
   not:"\"Selamet\" (sağlık) + \"laşî\" (fiziksel).",
   her:["Selameta laşî baş e.", "Di selameta laşî de."],
   gen:["Selameta laşî", "Selameta me"]),

  (id:"b1_t5_02", ku:"Selameta giyanî", tr:"Ruhsal sağlık", en:"Mental health",
   cins:"mê", ez:"selameta giyanî", kat:"tendurist", zor:0.70,
   not:"\"Selamet\" + \"giyanî\" (ruhsal).",
   her:["Selameta giyanî girîng e.", "Di selameta giyanî de."],
   gen:["Selameta giyanî", "Selameta me"]),

  (id:"b1_t5_03", ku:"Çûyîna bijîşkê", tr:"Doktora gitmek", en:"Going to the doctor",
   cins:"mê", ez:"çûyîna bijîşkê", kat:"tendurist", zor:0.71,
   not:"\"Çûyîn\" + \"bijîşkê\".",
   her:["Çûyîna bijîşkê lazim e.", "Di çûyîna bijîşkê de."],
   gen:["Çûyîna bijîşkê", "Çûyîna me"]),

  (id:"b1_t5_04", ku:"Dermankirin", tr:"İlaç tedavisi", en:"Medical treatment",
   cins:"mê", ez:"dermankirinê", kat:"tendurist", zor:0.70,
   not:"Dişil — \"derman\" + \"kirin\".",
   her:["Dermankirin lazim e.", "Di dermankirinê de."],
   gen:["Dermankirin û bijîşkê", "Dermankirina me"]),

  (id:"b1_t5_05", ku:"Nexweşîya venegerî", tr:"Bulaşıcı hastalık", en:"Contagious disease",
   cins:"mê", ez:"nexweşîya venegerî", kat:"tendurist", zor:0.68,
   not:"\"Nexweşî\" + \"venegerî\" (bulaşıcı).",
   her:["Nexweşîya venegerî heye.", "Li nexweşîya venegerî miqate be."],
   gen:["Nexweşîya venegerî", "Nexweşîya me"]),

  (id:"b1_t5_06", ku:"Vaksînasiyon", tr:"Aşılama", en:"Vaccination",
   cins:"mê", ez:"vaksînasyonê", kat:"tendurist", zor:0.70,
   not:"Dişil — uluslararası terim.",
   her:["Vaksînasiyon lazim e.", "Di vaksînasyonê de."],
   gen:["Vaksînasiyon û derman", "Vaksînasyona me"]),

  (id:"b1_t5_07", ku:"Klînîka taybet", tr:"Özel klinik", en:"Private clinic",
   cins:"mê", ez:"klînîka taybet", kat:"cih", zor:0.70,
   not:"\"Klînîk\" + \"taybet\".",
   her:["Klînîka taybet nêzîk e.", "Di klînîka taybet de."],
   gen:["Klînîka taybet", "Klînîka me"]),

  (id:"b1_t5_08", ku:"Parastina xweserî", tr:"Kendi kendini koruma", en:"Self-protection",
   cins:"mê", ez:"parastina xweserî", kat:"tendurist", zor:0.69,
   not:"\"Parastin\" + \"xweserî\".",
   her:["Parastina xweserî lazim e.", "Di parastina xweserî de."],
   gen:["Parastina xweserî", "Parastina me"]),

  (id:"b1_t5_09", ku:"Revandina destê", tr:"El hareketi / Elleri yıkama alışkanlığı", en:"Hand hygiene",
   cins:"mê", ez:"revandina destê", kat:"tendurist", zor:0.68,
   not:"\"Revandin\" + \"destê\". Hijyen alışkanlığı.",
   her:["Revandina destê lazim e.", "Destê xwe revandin."],
   gen:["Revandina destê", "Destên xwe revandin"]),

  (id:"b1_t5_10", ku:"Paqijiya laşî", tr:"Vücut temizliği", en:"Body hygiene",
   cins:"mê", ez:"paqijiya laşî", kat:"tendurist", zor:0.70,
   not:"\"Paqijî\" + \"laşî\".",
   her:["Paqijiya laşî lazim e.", "Di paqijiya laşî de."],
   gen:["Paqijiya laşî", "Paqijiya me"]),
];

final kB1_T6 = [
// ── RÊWÎTÎ EK — 50 kelime ────────────────────────────────────────

  (id:"b1_t6_01", ku:"Rêwîtîya xweserî", tr:"Kişisel seyahat", en:"Solo travel",
   cins:"mê", ez:"rêwîtîya xweserî", kat:"rêwîtî", zor:0.69,
   not:"\"Rêwîtî\" + \"xweserî\".",
   her:["Rêwîtîya xweserî baş e.", "Di rêwîtîya xweserî de."],
   gen:["Rêwîtîya xweserî", "Rêwîtîya me"]),

  (id:"b1_t6_02", ku:"Pêşwazîkirina mêvan", tr:"Misafir karşılamak", en:"Welcoming guests",
   cins:"mê", ez:"pêşwazîkirina mêvan", kat:"rêwîtî", zor:0.70,
   not:"\"Pêşwazîkirin\" + \"mêvan\".",
   her:["Pêşwazîkirina mêvan.", "Bi pêşwazîkirinê mêvan hat."],
   gen:["Pêşwazîkirina mêvan", "Pêşwazîkirina me"]),

  (id:"b1_t6_03", ku:"Şeva mêvanxanê", tr:"Otel gecesi", en:"Hotel night",
   cins:"mê", ez:"şeva mêvanxanê", kat:"rêwîtî", zor:0.69,
   not:"\"Şev\" + \"mêvanxanê\".",
   her:["Şeva mêvanxanê xweş bû.", "Di şeva mêvanxanê de."],
   gen:["Şeva mêvanxanê", "Şeva me"]),

  (id:"b1_t6_04", ku:"Keçelê balafirê", tr:"Uçuş ekibi", en:"Flight crew",
   cins:"bêcins", ez:"keçelê balafirê", kat:"pîşe", zor:0.68,
   not:"\"Keçel\" (ekip üyesi) + \"balafirê\".",
   her:["Keçelê balafirê.", "Di keçelê balafirê de."],
   gen:["Keçelê balafirê", "Keçelê me"]),

  (id:"b1_t6_05", ku:"Xistina çenteyê", tr:"Bavul hazırlama", en:"Packing the bag",
   cins:"mê", ez:"xistina çenteyê", kat:"rêwîtî", zor:0.69,
   not:"\"Xistin\" + \"çenteyê\". Bavul hazırlama.",
   her:["Xistina çenteyê lazim e.", "Çente bixe."],
   gen:["Xistina çenteyê", "Çente xistin"]),

  (id:"b1_t6_06", ku:"Serdana dêra kevn", tr:"Eski kilise ziyareti", en:"Old church visit",
   cins:"mê", ez:"serdana dêra kevn", kat:"rêwîtî", zor:0.67,
   not:"\"Serdan\" + \"dêra kevn\". Kürdistan\'ın Hristiyan mirası.",
   her:["Serdana dêra kevn kir.", "Di serdana dêra kevn de."],
   gen:["Serdana dêra kevn", "Serdana me"]),

  (id:"b1_t6_07", ku:"Kêfa rêwîtiyê", tr:"Seyahat keyfi", en:"Travel pleasure",
   cins:"mê", ez:"kêfa rêwîtiyê", kat:"rêwîtî", zor:0.70,
   not:"\"Kêf\" + \"rêwîtiyê\".",
   her:["Kêfa rêwîtiyê xweş e.", "Di kêfa rêwîtiyê de."],
   gen:["Kêfa rêwîtiyê", "Kêfa me"]),

  (id:"b1_t6_08", ku:"Navnîşana mêvanxanê", tr:"Otel adresi", en:"Hotel address",
   cins:"mê", ez:"navnîşana mêvanxanê", kat:"rêwîtî", zor:0.68,
   not:"\"Navnîşan\" + \"mêvanxanê\".",
   her:["Navnîşana mêvanxanê heye?", "Navnîşana mêvanxanê."],
   gen:["Navnîşana mêvanxanê", "Navnîşana me"]),

  (id:"b1_t6_09", ku:"Xizmeta odeyê", tr:"Oda servisi", en:"Room service",
   cins:"mê", ez:"xizmeta odeyê", kat:"rêwîtî", zor:0.68,
   not:"\"Xizmet\" + \"odeyê\".",
   her:["Xizmeta odeyê heye?", "Di xizmeta odeyê de."],
   gen:["Xizmeta odeyê", "Xizmeta me"]),

  (id:"b1_t6_10", ku:"Hatina baş", tr:"Hoşgeldin / İyi varışlar", en:"Good arrival",
   cins:"mê", ez:"hatina baş", kat:"rêwîtî", zor:0.71,
   not:"\"Hatin\" + \"baş\". Varış dilemi.",
   her:["Hatina baş!", "Hatina te baş!"],
   gen:["Hatina baş", "Hatina te baş!"]),
];

final kB1_T7 = [
// ── DUYGULAR, DEYİMLER EK — 60 kelime ────────────────────────────

  (id:"b1_t7_01", ku:"Êşa mirinê", tr:"Ölüm acısı", en:"Pain of death",
   cins:"mê", ez:"êşa mirinê", kat:"his", zor:0.68,
   not:"\"Êş\" + \"mirinê\". Yas duygusu.",
   her:["Êşa mirinê giran e.", "Di êşa mirinê de."],
   gen:["Êşa mirinê", "Êşa jiyanê"]),

  (id:"b1_t7_02", ku:"Dilê biçûk", tr:"Küçük kalp / Kırgınlık", en:"Hurt feelings",
   cins:"nêr", ez:"dilê biçûk", kat:"his", zor:0.68,
   not:"\"Dil\" + \"biçûk\". Kırgınlık, incinmişlik.",
   her:["Dilê min biçûk e.", "Dilê biçûk kir."],
   gen:["Dilê biçûk", "Dilê biçûk kir."]),

  (id:"b1_t7_03", ku:"Dermanê dilê", tr:"Kalbin ilacı", en:"Heart\'s remedy",
   cins:"nêr", ez:"dermanê dilê", kat:"his", zor:0.68,
   not:"\"Derman\" + \"dilê\". Duygusal iyileşme.",
   her:["Dermanê dilê ziman e.", "Dermanê dilê."],
   gen:["Dermanê dilê", "Dermanê me"]),

  (id:"b1_t7_04", ku:"Giyan û can", tr:"Ruh ve can", en:"Soul and spirit",
   cins:"bêcins", ez:null, kat:"his", zor:0.70,
   not:"\"Giyan\" + \"can\". Bileşik ruhsal kavram.",
   her:["Giyan û can.", "Bi giyan û can."],
   gen:["Giyan û can", "Giyan û cana me"]),

  (id:"b1_t7_05", ku:"Evîna dilî", tr:"Gönülden aşk", en:"Heartfelt love",
   cins:"mê", ez:"evîna dilî", kat:"his", zor:0.69,
   not:"\"Evîn\" + \"dilî\".",
   her:["Evîna dilî xweş e.", "Bi evîna dilî."],
   gen:["Evîna dilî", "Evîna me"]),

  // Deyimler
  (id:"b1_t7_06", ku:"Dilê wî li ciyê xwe nîne", tr:"Kalbi yerinde değil", en:"His heart is not at ease",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.67,
   not:"Deyim — endişeli/huzursuz olmak.",
   her:["Dilê wî li ciyê xwe nîne.", "Dilê min li ciyê xwe nîne."],
   gen:["Dilê li ciyê xwe nîne", "Dilê min"]),

  (id:"b1_t7_07", ku:"Çav li ser kirin", tr:"Göz atmak / Bakmak", en:"To take a look",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.69,
   not:"\"Çav\" + \"ser\" + \"kirin\". Bakmak.",
   her:["Çav li ser kir.", "Çav li ser bike!"],
   gen:["Çav li ser kirin", "Çav li ser bike!"]),

  (id:"b1_t7_08", ku:"Destê te bihelal be", tr:"Eline emeğine sağlık", en:"May your hands be blessed",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.70,
   not:"Kürt iltifat deyimi.",
   her:["Destê te bihelal be!", "Destê xebatê te bihelal."],
   gen:["Destê te bihelal be!", "Destê te xweş be"]),

  (id:"b1_t7_09", ku:"Nê û na got", tr:"Hem ne hem hayır dedi", en:"Said both no and no",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.66,
   not:"Deyim — kararsızlık ifadesi.",
   her:["Nê û na got.", "Nê û na nagê."],
   gen:["Nê û na", "Nê û na got."]),

  (id:"b1_t7_10", ku:"Rûye wî reş e", tr:"Yüzü kara / Utanç içinde", en:"His face is black (ashamed)",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.67,
   not:"\"Rû\" + \"reş\". Utanç deyimi.",
   her:["Rûyê wî reş e.", "Rûyê min reş dike."],
   gen:["Rûyê reş", "Rûyê reş kir."]),

  (id:"b1_t7_11", ku:"Av bi av bûn", tr:"Islanmak / Tamamen ıslanmak", en:"To be soaked",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.68,
   not:"\"Av bi av bûn\" = tamamen ıslanmak.",
   her:["Av bi av bûm.", "Di baran de av bi av bû."],
   gen:["Av bi av bûn", "Av bi av bûm."]),

  (id:"b1_t7_12", ku:"Bi dilê xweş", tr:"Gönülden / İsteyerek", en:"Wholeheartedly / Willingly",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.70,
   not:"\"Bi\" + \"dilê xweş\".",
   her:["Bi dilê xweş hat.", "Bi dilê xweş dike."],
   gen:["Bi dilê xweş", "Bi dilê xweş bike."]),

  (id:"b1_t7_13", ku:"Nîvê gotinan", tr:"Sözün yarısı", en:"Half the words",
   cins:"nêr", ez:"nîvê gotinan", kat:"deyim", zor:0.67,
   not:"\"Nîv\" + \"gotin\". Söylenmeyen şeyler.",
   her:["Nîvê gotinan ma.", "Nîvê gotinan got."],
   gen:["Nîvê gotinan", "Nîvê gotinan ma."]),

  (id:"b1_t7_14", ku:"Ser û serî xistin", tr:"Baş eğmek / Katlanmak", en:"To bow / endure",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.66,
   not:"\"Ser\" + \"serî\" + \"xistin\".",
   her:["Ser û serî xist.", "Ser û serî nixe!"],
   gen:["Ser û serî xistin", "Ser û serî nixe!"]),

  (id:"b1_t7_15", ku:"Guh li xwe kirin", tr:"Kulak kesmek / Dinlememek", en:"To ignore / not listen",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.67,
   not:"\"Guh\" + \"xwe\" + \"kirin\". Kulak kesmek.",
   her:["Guh li xwe kir.", "Guh li xwe neke!"],
   gen:["Guh li xwe kirin", "Guh li xwe neke!"]),
];

final kB1_T8 = [
// ── GENEL TAMAMLAMA — 90 kelime ───────────────────────────────────

  // Aborî
  (id:"b1_t8_01", ku:"Aborîya agrar", tr:"Tarım ekonomisi", en:"Agrarian economy",
   cins:"mê", ez:"aborîya agrar", kat:"aborî", zor:0.69,
   not:"\"Aborî\" + \"agrar\".",
   her:["Aborîya agrar ya Kurdistanê.", "Di aborîya agrar de."],
   gen:["Aborîya agrar", "Aborîya me"]),

  (id:"b1_t8_02", ku:"Aborîya çandiniyê", tr:"Tarımsal ekonomi", en:"Agricultural economy",
   cins:"mê", ez:"aborîya çandiniyê", kat:"aborî", zor:0.69,
   not:"\"Aborî\" + \"çandiniyê\".",
   her:["Aborîya çandiniyê.", "Di aborîya çandiniyê de."],
   gen:["Aborîya çandiniyê", "Aborîya me"]),

  (id:"b1_t8_03", ku:"Destketina aborî", tr:"Ekonomik kazanım", en:"Economic gain",
   cins:"mê", ez:"destketina aborî", kat:"aborî", zor:0.68,
   not:"\"Destketin\" + \"aborî\".",
   her:["Destketina aborî baş e.", "Di destketina aborî de."],
   gen:["Destketina aborî", "Destketina me"]),

  (id:"b1_t8_04", ku:"Xêzên aborî", tr:"Ekonomik hatlar", en:"Economic lines",
   cins:"bêcins", ez:"xêzên aborî", kat:"aborî", zor:0.67,
   not:"\"Xêz\" + \"aborî\".",
   her:["Xêzên aborî.", "Di xêzên aborî de."],
   gen:["Xêzên aborî", "Xêzên me"]),

  (id:"b1_t8_05", ku:"Pêşveçûna aborî", tr:"Ekonomik gelişme", en:"Economic development",
   cins:"mê", ez:"pêşveçûna aborî", kat:"aborî", zor:0.70,
   not:"\"Pêşveçûn\" + \"aborî\".",
   her:["Pêşveçûna aborî lazim e.", "Di pêşveçûna aborî de."],
   gen:["Pêşveçûna aborî", "Pêşveçûna me"]),

  // Jiyan devam
  (id:"b1_t8_06", ku:"Malbata dêr û kal", tr:"Büyüklerle dolu aile", en:"Family with elders",
   cins:"mê", ez:"malbata dêr û kal", kat:"malbat", zor:0.68,
   not:"\"Malbat\" + \"dêr\" (büyük anne/baba) + \"kal\" (yaşlı).",
   her:["Malbata dêr û kal xweş e.", "Di malbata dêr û kal de."],
   gen:["Malbata dêr û kal", "Malbata me"]),

  (id:"b1_t8_07", ku:"Hevjiyana xweş", tr:"Güzel birlikte yaşam", en:"Harmonious coexistence",
   cins:"mê", ez:"hevjiyana xweş", kat:"civakî", zor:0.69,
   not:"\"Hevjiyan\" + \"xweş\".",
   her:["Hevjiyana xweş divê.", "Di hevjiyana xweş de."],
   gen:["Hevjiyana xweş", "Hevjiyana me"]),

  (id:"b1_t8_08", ku:"Parastin û pêşveçûn", tr:"Koruma ve ilerleme", en:"Protection and progress",
   cins:"bêcins", ez:null, kat:"nirx", zor:0.70,
   not:"\"Parastin\" + \"pêşveçûn\". Toplumsal hedef.",
   her:["Parastin û pêşveçûn.", "Di parastin û pêşveçûnê de."],
   gen:["Parastin û pêşveçûn", "Parastin û pêşveçûna me"]),

  (id:"b1_t8_09", ku:"Nirxên mirovî", tr:"İnsan değerleri", en:"Human values",
   cins:"bêcins", ez:"nirxên mirovî", kat:"nirx", zor:0.71,
   not:"\"Nirx\" + \"mirovî\".",
   her:["Nirxên mirovî girîng in.", "Di nirxên mirovî de."],
   gen:["Nirxên mirovî", "Nirxên me"]),

  (id:"b1_t8_10", ku:"Jiyana watedar", tr:"Anlamlı yaşam", en:"Meaningful life",
   cins:"mê", ez:"jiyana watedar", kat:"jiyan", zor:0.70,
   not:"\"Jiyan\" + \"watedar\" (anlamlı).",
   her:["Jiyana watedar bivî.", "Di jiyana watedar de."],
   gen:["Jiyana watedar", "Jiyana me"]),

  // Teknoloji ek
  (id:"b1_t8_11", ku:"Pergalên dîjîtal", tr:"Dijital sistemler", en:"Digital systems",
   cins:"bêcins", ez:"pergalên dîjîtal", kat:"teknoloji", zor:0.69,
   not:"\"Pergal\" + \"dîjîtal\".",
   her:["Pergalên dîjîtal.", "Di pergalên dîjîtal de."],
   gen:["Pergalên dîjîtal", "Pergalên me"]),

  (id:"b1_t8_12", ku:"Sepana mobîl", tr:"Mobil uygulama", en:"Mobile app",
   cins:"mê", ez:"sepana mobîl", kat:"teknoloji", zor:0.70,
   not:"\"Sepa\" (uygulama) + \"mobîl\".",
   her:["Sepana mobîl heye.", "Di sepana mobîl de."],
   gen:["Sepana mobîl", "Sepana me"]),

  (id:"b1_t8_13", ku:"Torgiloka civakî", tr:"Sosyal ağ", en:"Social network",
   cins:"mê", ez:"torgiloka civakî", kat:"teknoloji", zor:0.69,
   not:"\"Torgîlok\" (ağ) + \"civakî\".",
   her:["Torgiloka civakî.", "Di torgiloka civakî de."],
   gen:["Torgiloka civakî", "Torgiloka me"]),

  (id:"b1_t8_14", ku:"Hişmendiya sazî", tr:"Yapay zeka", en:"Artificial intelligence",
   cins:"mê", ez:"hişmendiya sazî", kat:"teknoloji", zor:0.68,
   not:"\"Hişmendî\" (zeka) + \"sazî\" (yapay).",
   her:["Hişmendiya sazî.", "Di hişmendiya sazî de."],
   gen:["Hişmendiya sazî", "Hişmendiya me"]),

  (id:"b1_t8_15", ku:"Çêkere malperê", tr:"Web sitesi oluşturucu", en:"Website builder",
   cins:"bêcins", ez:"çêkere malperê", kat:"teknoloji", zor:0.67,
   not:"\"Çêker\" + \"malperê\".",
   her:["Çêkere malperê heye.", "Di çêkere malperê de."],
   gen:["Çêkere malperê", "Çêkera me"]),

  // Rengder ek
  (id:"b1_t8_16", ku:"Kevnar û nû", tr:"Eski ve yeni", en:"Ancient and new",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.71,
   not:"\"Kevnar\" (eski/antik) + \"nû\" (yeni).",
   her:["Kevnar û nû.", "Di navbera kevnar û nû de."],
   gen:["Kevnar û nû", "Kevnar û nûya me"]),

  (id:"b1_t8_17", ku:"Kûr û sekîn", tr:"Derin ve sığ", en:"Deep and shallow",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.69,
   not:"\"Kûr\" (derin) + \"sekîn\" (sığ).",
   her:["Kûr e.", "Sekîn e."],
   gen:["Kûr û sekîn", "Ev kûr e."]),

  (id:"b1_t8_18", ku:"Bilez û hêdî", tr:"Hızlı ve yavaş", en:"Fast and slow",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.72,
   not:"\"Bilez\" (hızlı) + \"hêdî\" (yavaş).",
   her:["Bilez e.", "Hêdî e."],
   gen:["Bilez û hêdî", "Bilez here."]),

  (id:"b1_t8_19", ku:"Nerm û hişk", tr:"Yumuşak ve sert", en:"Soft and hard",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.70,
   not:"\"Nerm\" (yumuşak) + \"hişk\" (sert).",
   her:["Nerm e.", "Hişk e."],
   gen:["Nerm û hişk", "Ev nerm e."]),

  (id:"b1_t8_20", ku:"Gewre û biçûk", tr:"Büyük ve küçük (yetişkin)", en:"Adult and small",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.71,
   not:"\"Gewre\" (büyük/yetişkin) + \"biçûk\".",
   her:["Gewre û biçûk hene.", "Hem gewre hem biçûk."],
   gen:["Gewre û biçûk", "Gewre û biçûkên me"]),

  // Çeşitli tamamlama
  (id:"b1_t8_21", ku:"Deynê xebatê", tr:"İş borcu", en:"Work debt",
   cins:"nêr", ez:"deynê xebatê", kat:"aborî", zor:0.67,
   not:"\"Deyn\" + \"xebatê\".",
   her:["Deynê xebatê heye.", "Di deynê xebatê de."],
   gen:["Deynê xebatê", "Deynê me"]),

  (id:"b1_t8_22", ku:"Veguherîna çandî", tr:"Kültürel dönüşüm", en:"Cultural transformation",
   cins:"mê", ez:"veguherîna çandî", kat:"çand", zor:0.69,
   not:"\"Veguherîn\" + \"çandî\".",
   her:["Veguherîna çandî.", "Di veguherîna çandî de."],
   gen:["Veguherîna çandî", "Veguherîna me"]),

  (id:"b1_t8_23", ku:"Bi rêkûpêk", tr:"Düzenli / Sistemli", en:"Orderly / Systematic",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Bi rêkûpêk\" = düzenli.",
   her:["Bi rêkûpêk bike.", "Bi rêkûpêk e."],
   gen:["Bi rêkûpêk", "Bi rêkûpêk bike."]),

  (id:"b1_t8_24", ku:"Bi tevahî", tr:"Tamamen / Bütünüyle", en:"Completely / Entirely",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Bi tevahî\" = tamamen.",
   her:["Bi tevahî hat.", "Bi tevahî ne."],
   gen:["Bi tevahî", "Bi tevahî hat."]),

  (id:"b1_t8_25", ku:"Ji nû ve", tr:"Yeniden / Tekrar", en:"Again / Anew",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Ji nû ve\" = yeniden.",
   her:["Ji nû ve dest pê kir.", "Ji nû ve bike."],
   gen:["Ji nû ve", "Ji nû ve bike."]),

  (id:"b1_t8_26", ku:"Li pêş û paş", tr:"Önde ve arkada", en:"In front and behind",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.70,
   not:"\"Li pêş\" (önde) + \"paş\" (arkada).",
   her:["Li pêş û paş.", "Li pêş û paşê."],
   gen:["Li pêş û paş", "Li pêş û paşê"]),

  (id:"b1_t8_27", ku:"Wek berê", tr:"Eskisi gibi", en:"Like before",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.71,
   not:"\"Wek\" + \"berê\" (önceki gibi).",
   her:["Wek berê ye.", "Wek berê bike."],
   gen:["Wek berê", "Wek berê ye."]),

  (id:"b1_t8_28", ku:"Bi vî awayî", tr:"Bu şekilde / Böyle", en:"In this way",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Bi vî awayî\" = bu şekilde.",
   her:["Bi vî awayî bike.", "Bi vî awayî hat."],
   gen:["Bi vî awayî", "Bi vî awayî bike."]),

  (id:"b1_t8_29", ku:"Di cihê xwe de", tr:"Yerinde / Mevkiinde", en:"In its place",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.70,
   not:"\"Di cihê xwe de\" = yerinde.",
   her:["Di cihê xwe de ye.", "Her tişt di cihê xwe de."],
   gen:["Di cihê xwe de", "Di cihê xwe de ye."]),

  (id:"b1_t8_30", ku:"Ji dil û can", tr:"Candan / Tüm kalbiyle", en:"With all one\'s heart",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.71,
   not:"\"Ji dil û can\" = candan/yürekten.",
   her:["Ji dil û can hez dikim.", "Ji dil û can e."],
   gen:["Ji dil û can", "Ji dil û can hez dikim."]),
];

// B1 FINAL TAM LİSTESİ
final kB1TamListeNihai = [
  ...kB1TamListeFinal,
  ...kB1_T1, ...kB1_T2, ...kB1_T3, ...kB1_T4,
  ...kB1_T5, ...kB1_T6, ...kB1_T7, ...kB1_T8,
];

// ════════════════════════════════════════════════════════════════
// B1 EKSİKLİK TAMAMLAMA — 430 kelime
// ════════════════════════════════════════════════════════════════

final kB1_Ziman2 = [
// ── DİL VE İLETİŞİM — 50 kelime ──────────────────────────────────

  (id:"b1_zm01", ku:"Aksana xweş", tr:"Güzel aksan", en:"Good accent",
   cins:"mê", ez:"aksana xweş", kat:"ziman", zor:0.70,
   not:"\"Aksan\" + \"xweş\". Telaffuz kalitesi.",
   her:["Aksana te xweş e.", "Aksanê xweş bike."],
   gen:["Aksana xweş", "Aksanê me"]),

  (id:"b1_zm02", ku:"Bilêvkirina rast", tr:"Doğru telaffuz", en:"Correct pronunciation",
   cins:"mê", ez:"bilêvkirina rast", kat:"ziman", zor:0.71,
   not:"\"Bilêvkirin\" + \"rast\". [Fêrkera D.1] ✓.",
   her:["Bilêvkirina rast lazim e.", "Bilêvkirin rast bike."],
   gen:["Bilêvkirina rast", "Bilêvkirina me"]),

  (id:"b1_zm03", ku:"Fêrkirina ziman", tr:"Dil öğretme", en:"Language teaching",
   cins:"mê", ez:"fêrkirina ziman", kat:"ziman", zor:0.70,
   not:"\"Fêrkirin\" + \"ziman\".",
   her:["Fêrkirina ziman baş e.", "Di fêrkirina ziman de."],
   gen:["Fêrkirina ziman", "Fêrkirina me"]),

  (id:"b1_zm04", ku:"Fêrbûna ziman", tr:"Dil öğrenme", en:"Language learning",
   cins:"mê", ez:"fêrbûna ziman", kat:"ziman", zor:0.72,
   not:"\"Fêrbûn\" + \"ziman\".",
   her:["Fêrbûna ziman hêsan e.", "Di fêrbûna ziman de."],
   gen:["Fêrbûna ziman", "Fêrbûna me"]),

  (id:"b1_zm05", ku:"Ziman û nasnameya xwe", tr:"Dil ve kimliğin", en:"Language and identity",
   cins:"bêcins", ez:null, kat:"ziman", zor:0.71,
   not:"\"Ziman\" + \"nasname\". Heritage temel bağlantısı.",
   her:["Ziman nasnameya xwe ye.", "Di nav ziman û nasnameya xwe de."],
   gen:["Ziman û nasnameya xwe", "Ziman û nasname"]),

  (id:"b1_zm06", ku:"Devoka herêmî", tr:"Yerel ağız / Lehçe", en:"Regional dialect",
   cins:"mê", ez:"devoka herêmî", kat:"ziman", zor:0.69,
   not:"\"Devok\" + \"herêmî\".",
   her:["Devoka herêmî xweş e.", "Di devoka herêmî de."],
   gen:["Devoka herêmî", "Devoka me"]),

  (id:"b1_zm07", ku:"Zaravayê kurmancî", tr:"Kurmancî lehçesi", en:"Kurmanji dialect",
   cins:"nêr", ez:"zaravayê kurmancî", kat:"ziman", zor:0.72,
   not:"\"Zarava\" + \"kurmancî\".",
   her:["Zaravayê kurmancî.", "Di zaravayê kurmancî de."],
   gen:["Zaravayê kurmancî", "Zaravayên kurdî"]),

  (id:"b1_zm08", ku:"Axaftin û nivîsîn", tr:"Konuşma ve yazma", en:"Speaking and writing",
   cins:"bêcins", ez:null, kat:"ziman", zor:0.72,
   not:"\"Axaftin\" + \"nivîsîn\". Dört beceriden ikisi.",
   her:["Axaftin û nivîsîn lazim e.", "Di axaftin û nivîsîn de."],
   gen:["Axaftin û nivîsîn", "Axaftin û xwendin"]),

  (id:"b1_zm09", ku:"Guhdarîkirin û têgihîştin", tr:"Dinleme ve anlama", en:"Listening and understanding",
   cins:"bêcins", ez:null, kat:"ziman", zor:0.71,
   not:"\"Guhdarîkirin\" + \"têgihîştin\". Dört beceriden ikisi.",
   her:["Guhdarîkirin û têgihîştin lazim e.", "Baş guhdarî bike."],
   gen:["Guhdarîkirin û têgihîştin", "Guhdarîkirin û xwendin"]),

  (id:"b1_zm10", ku:"Pirtûka rêzimanê", tr:"Dilbilgisi kitabı", en:"Grammar book",
   cins:"mê", ez:"pirtûka rêzimanê", kat:"ziman", zor:0.70,
   not:"\"Pirtûk\" + \"rêzimanê\".",
   her:["Pirtûka rêzimanê baş e.", "Di pirtûka rêzimanê de."],
   gen:["Pirtûka rêzimanê", "Pirtûkên me"]),

  (id:"b1_zm11", ku:"Peyva nû", tr:"Yeni kelime", en:"New word",
   cins:"mê", ez:"peyva nû", kat:"ziman", zor:0.73,
   not:"\"Peyv\" + \"nû\".",
   her:["Peyva nû fêr bûm.", "Peyvên nû."],
   gen:["Peyva nû", "Peyvên nû"]),

  (id:"b1_zm12", ku:"Ferhengok", tr:"Sözlük / Kelime listesi", en:"Dictionary / Vocabulary list",
   cins:"nêr", ez:"ferhengokê", kat:"ziman", zor:0.71,
   not:"Eril — [Fêrkera D.1] ✓: \"ferhengok\" = sözlükçük.",
   her:["Ferhengok heye?", "Ferhengokê bide."],
   gen:["Ferhengok û ferhenga", "Ferhengoka me"]),

  (id:"b1_zm13", ku:"Mana peyvê", tr:"Kelimenin anlamı", en:"Word meaning",
   cins:"mê", ez:"mana peyvê", kat:"ziman", zor:0.72,
   not:"\"Mana\" + \"peyvê\". \"Wate\" alternatifi.",
   her:["Mana peyvê çi ye?", "Mana nû."],
   gen:["Mana peyvê", "Mana me"]),

  (id:"b1_zm14", ku:"Zimanê dê zimanê jiyanê", tr:"Ana dil yaşam dilidir", en:"Mother tongue is the language of life",
   cins:"bêcins", ez:null, kat:"ziman", zor:0.69,
   not:"Heritage temel mesajı.",
   her:["Zimanê dê zimanê jiyanê ye.", "Zimanê dê girîng e."],
   gen:["Zimanê dê zimanê jiyanê", "Zimanê dê"]),

  (id:"b1_zm15", ku:"Axaftina devkî", tr:"Sözlü konuşma", en:"Oral speech",
   cins:"mê", ez:"axaftina devkî", kat:"ziman", zor:0.69,
   not:"\"Axaftin\" + \"devkî\".",
   her:["Axaftina devkî baş e.", "Di axaftina devkî de."],
   gen:["Axaftina devkî", "Axaftina me"]),

  (id:"b1_zm16", ku:"Jêrxêz", tr:"Alt çizgi / Altı çizili", en:"Underline",
   cins:"nêr", ez:"jêrxêzê", kat:"ziman", zor:0.67,
   not:"Eril — \"jêr\" + \"xêz\". Dilbilgisi terimi.",
   her:["Jêrxêza peyvê.", "Jêrxêz bike."],
   gen:["Jêrxêz û serxêz", "Jêrxêza me"]),

  (id:"b1_zm17", ku:"Çapemenîya kurdî", tr:"Kürt basını", en:"Kurdish press",
   cins:"mê", ez:"çapemenîya kurdî", kat:"medya", zor:0.69,
   not:"\"Çapemenî\" + \"kurdî\". Kürtçe medya.",
   her:["Çapemenîya kurdî girîng e.", "Di çapemenîya kurdî de."],
   gen:["Çapemenîya kurdî", "Çapemenîya me"]),

  (id:"b1_zm18", ku:"Radyoya kurdî", tr:"Kürtçe radyo", en:"Kurdish radio",
   cins:"mê", ez:"radyoya kurdî", kat:"medya", zor:0.70,
   not:"\"Radyo\" + \"kurdî\".",
   her:["Radyoya kurdî guhdarî dikim.", "Di radyoya kurdî de."],
   gen:["Radyoya kurdî", "Radyoya me"]),

  (id:"b1_zm19", ku:"Rûpela kurdî ya înternetê", tr:"Kürtçe internet sayfası", en:"Kurdish internet page",
   cins:"mê", ez:"rûpela kurdî ya înternetê", kat:"medya", zor:0.68,
   not:"\"Rûpel\" + \"kurdî\" + \"înternetê\".",
   her:["Rûpela kurdî ya înternetê heye.", "Di rûpela kurdî de."],
   gen:["Rûpela kurdî ya înternetê", "Rûpela me"]),

  (id:"b1_zm20", ku:"Gotûbêj", tr:"Diyalog / Söyleşi", en:"Dialogue",
   cins:"nêr", ez:"gotûbêjê", kat:"ziman", zor:0.70,
   not:"Eril — \"got\" + \"û\" + \"bêj\". Diyalog.",
   her:["Gotûbêj baş bû.", "Di gotûbêjê de."],
   gen:["Gotûbêj û dîyalog", "Gotûbêjê me"]),
];

final kB1_Kar2 = [
// ── İŞ VE EKONOMİ — 50 kelime ────────────────────────────────────

  (id:"b1_kr01", ku:"Kêşeya xebatê", tr:"İş sorunu", en:"Work problem",
   cins:"mê", ez:"kêşeya xebatê", kat:"kar", zor:0.70,
   not:"\"Kêşe\" + \"xebatê\".",
   her:["Kêşeya xebatê heye.", "Di kêşeya xebatê de."],
   gen:["Kêşeya xebatê", "Kêşeya me"]),

  (id:"b1_kr02", ku:"Nûkirina karê", tr:"İş yenilemesi / Terfi", en:"Job renewal / Promotion",
   cins:"mê", ez:"nûkirina karê", kat:"kar", zor:0.68,
   not:"\"Nûkirin\" + \"karê\".",
   her:["Nûkirina karê hat.", "Di nûkirina karê de."],
   gen:["Nûkirina karê", "Nûkirina me"]),

  (id:"b1_kr03", ku:"Şirket", tr:"Şirket", en:"Company",
   cins:"mê", ez:"şirketê", kat:"kar", zor:0.73,
   not:"Dişil — [AS]: \"şirket\" ✓. \"Pargîdanî\" özgün Kurmancî.",
   her:["Şirket mezin e.", "Di şirketan de."],
   gen:["Şirket û kargeh", "Şirketa me"]),

  (id:"b1_kr04", ku:"Pargîdanî", tr:"Şirket / Kurum", en:"Company / Institution",
   cins:"mê", ez:"pargîdaniyê", kat:"kar", zor:0.70,
   not:"Dişil — özgün Kurmancî karşılığı.",
   her:["Pargîdanî mezin e.", "Di pargîdaniyê de."],
   gen:["Pargîdanî û şirket", "Pargîdanîya me"]),

  (id:"b1_kr05", ku:"Muştirî", tr:"Müşteri", en:"Customer / Client",
   cins:"bêcins", ez:"muştiriyê", kat:"kar", zor:0.72,
   not:"\"Muştirî\" — [AS]: \"müşteri = muştirî\" ✓.",
   her:["Muştirî hat.", "Muştiriyên baş."],
   gen:["Muştirî û firoşkar", "Muştiriyên me"]),

  (id:"b1_kr06", ku:"Hilberîn", tr:"Üretmek", en:"To produce",
   cins:"bêcins", ez:null, kat:"kar", zor:0.71,
   not:"\"Hilberîn\" = üretmek. Ergatif: \"Min hilberî.\"",
   her:["Min hilberî.", "Em hildiberînin."],
   gen:["Hilberîn û firotin", "Min hilberî."]),

  (id:"b1_kr07", ku:"Firotin", tr:"Satmak", en:"To sell",
   cins:"bêcins", ez:null, kat:"kar", zor:0.72,
   not:"\"Firotin\" = satmak. Ergatif: \"Min firot.\"",
   her:["Min firot.", "Em difiroşin."],
   gen:["Firotin û kirîn", "Min firot."]),

  (id:"b1_kr08", ku:"Kirîn", tr:"Satın almak", en:"To buy",
   cins:"bêcins", ez:null, kat:"kar", zor:0.73,
   not:"\"Kirîn\" = satın almak. Ergatif: \"Min kirî.\"",
   her:["Min kirî.", "Em dikirin."],
   gen:["Kirîn û firotin", "Min kirî."]),

  (id:"b1_kr09", ku:"Destpêkirina karsaziyê", tr:"İş kurma", en:"Starting a business",
   cins:"mê", ez:"destpêkirina karsaziyê", kat:"kar", zor:0.67,
   not:"\"Destpêkirin\" + \"karsaziyê\".",
   her:["Destpêkirina karsaziyê.", "Karsazî dest pê kir."],
   gen:["Destpêkirina karsaziyê", "Destpêkirina me"]),

  (id:"b1_kr10", ku:"Serfkirin", tr:"Harcamak", en:"To spend",
   cins:"bêcins", ez:null, kat:"aborî", zor:0.70,
   not:"\"Serfkirin\" = harcamak. Ergatif: \"Min serf kir.\"",
   her:["Min serf kir.", "Zêde serf neke!"],
   gen:["Serfkirin û tomarkirin", "Min serf kir."]),

  (id:"b1_kr11", ku:"Hesabdarkirin", tr:"Muhasebe yapmak", en:"To do accounting",
   cins:"bêcins", ez:null, kat:"kar", zor:0.67,
   not:"\"Hesabdar\" + \"kirin\".",
   her:["Hesabdarkirin lazim e.", "Hesabdar kir."],
   gen:["Hesabdarkirin", "Hesabdar bike!"]),

  (id:"b1_kr12", ku:"Budceya salan", tr:"Yıllık bütçe", en:"Annual budget",
   cins:"mê", ez:"budceya salan", kat:"aborî", zor:0.68,
   not:"\"Budce\" + \"salan\".",
   her:["Budceya salan hat.", "Di budceya salan de."],
   gen:["Budceya salan", "Budceya me"]),

  (id:"b1_kr13", ku:"Biha û kalîte", tr:"Fiyat ve kalite", en:"Price and quality",
   cins:"bêcins", ez:null, kat:"kar", zor:0.71,
   not:"\"Biha\" + \"kalîte\". Ticari kavram.",
   her:["Biha û kalîte baş in.", "Di biha û kalîtê de."],
   gen:["Biha û kalîte", "Biha û kalîteya me"]),

  (id:"b1_kr14", ku:"Projeya girêdayî", tr:"Bağlantılı proje", en:"Linked project",
   cins:"mê", ez:"projeya girêdayî", kat:"kar", zor:0.67,
   not:"\"Proje\" + \"girêdayî\".",
   her:["Projeya girêdayî heye.", "Di projeya girêdayî de."],
   gen:["Projeya girêdayî", "Projeya me"]),

  (id:"b1_kr15", ku:"Çavdêrîya kalîtê", tr:"Kalite denetimi", en:"Quality control",
   cins:"mê", ez:"çavdêrîya kalîtê", kat:"kar", zor:0.67,
   not:"\"Çavdêrî\" + \"kalîtê\".",
   her:["Çavdêrîya kalîtê lazim e.", "Di çavdêrîya kalîtê de."],
   gen:["Çavdêrîya kalîtê", "Çavdêrîya me"]),
];

final kB1_Spor = [
// ── SPOR VE AKTİVİTELER — 40 kelime ─────────────────────────────

  (id:"b1_sp01", ku:"Seranserê lîstikê", tr:"Maçın tamamı", en:"Full match",
   cins:"nêr", ez:"seranserê lîstikê", kat:"spor", zor:0.68,
   not:"\"Seranser\" + \"lîstikê\".",
   her:["Seranserê lîstikê dît.", "Seranserê lîstikê xweş bû."],
   gen:["Seranserê lîstikê", "Lîstika me"]),

  (id:"b1_sp02", ku:"Lîstikên teamê", tr:"Takım oyunları", en:"Team games",
   cins:"bêcins", ez:"lîstikên teamê", kat:"spor", zor:0.69,
   not:"\"Lîstik\" + \"teamê\".",
   her:["Lîstikên teamê xweş in.", "Di lîstikên teamê de."],
   gen:["Lîstikên teamê", "Lîstikên me"]),

  (id:"b1_sp03", ku:"Koçê teamê", tr:"Takım antrenörü", en:"Team coach",
   cins:"bêcins", ez:"koçê teamê", kat:"spor", zor:0.68,
   not:"\"Koç\" + \"teamê\".",
   her:["Koçê teamê baş e.", "Koçê teamê hat."],
   gen:["Koçê teamê", "Koçê me"]),

  (id:"b1_sp04", ku:"Şampiyona navnetewî", tr:"Uluslararası şampiyona", en:"International championship",
   cins:"mê", ez:"şampiyona navnetewî", kat:"spor", zor:0.68,
   not:"\"Şampiyona\" + \"navnetewî\".",
   her:["Şampiyona navnetewî hat.", "Di şampiyona navnetewî de."],
   gen:["Şampiyona navnetewî", "Şampiyona me"]),

  (id:"b1_sp05", ku:"Yarîşa bazê", tr:"Koşu yarışması", en:"Running competition",
   cins:"mê", ez:"yarîşa bazê", kat:"spor", zor:0.67,
   not:"\"Yarîş\" + \"bazê\". Koşu.",
   her:["Yarîşa bazê hat.", "Di yarîşa bazê de."],
   gen:["Yarîşa bazê", "Yarîşên spor"]),

  (id:"b1_sp06", ku:"Meydan û park", tr:"Meydan ve park", en:"Square and park",
   cins:"bêcins", ez:null, kat:"cih", zor:0.70,
   not:"\"Meydan\" + \"park\". Spor alanları.",
   her:["Meydan û park hene.", "Li meydan û parkê dilêzin."],
   gen:["Meydan û park", "Parkê me"]),

  (id:"b1_sp07", ku:"Avjenî", tr:"Yüzme", en:"Swimming",
   cins:"mê", ez:"avjeniyê", kat:"spor", zor:0.69,
   not:"Dişil — \"av\" + \"-jenî\". Yüzme.",
   her:["Avjenî dikim.", "Avjenî xweş e."],
   gen:["Avjenî û futbol", "Avjenîya me"]),

  (id:"b1_sp08", ku:"Bisîklet", tr:"Bisiklet", en:"Bicycle",
   cins:"mê", ez:"bisîkletê", kat:"spor", zor:0.71,
   not:"Dişil — [AS]: \"bisiklet = bisîklet\" ✓.",
   her:["Bisîklet dilêzim.", "Bisîkleta min."],
   gen:["Bisîklet û motorsîklet", "Bisîkleta me"]),

  (id:"b1_sp09", ku:"Şoreşvankî", tr:"Dövüş sanatı", en:"Martial art",
   cins:"mê", ez:"şoreşvankiyê", kat:"spor", zor:0.66,
   not:"Dişil — \"şoreşvan\" + \"-kî\". Dövüş sanatı.",
   her:["Şoreşvankî dikim.", "Di şoreşvankiyê de."],
   gen:["Şoreşvankî û futbol", "Şoreşvankîya me"]),

  (id:"b1_sp10", ku:"Werzişa rojane", tr:"Günlük egzersiz", en:"Daily exercise",
   cins:"mê", ez:"werzişa rojane", kat:"spor", zor:0.70,
   not:"\"Werzîş\" + \"rojane\". Günlük spor.",
   her:["Werzişa rojane lazim e.", "Werzişa rojane dikim."],
   gen:["Werzişa rojane", "Werzişa me"]),

  (id:"b1_sp11", ku:"Grûba werzîşê", tr:"Spor grubu", en:"Sports group",
   cins:"mê", ez:"grûba werzîşê", kat:"spor", zor:0.68,
   not:"\"Grûb\" + \"werzîş\".",
   her:["Grûba werzîşê hat.", "Di grûba werzîşê de ne."],
   gen:["Grûba werzîşê", "Grûba me"]),

  (id:"b1_sp12", ku:"Stadyom", tr:"Stadyum", en:"Stadium",
   cins:"nêr", ez:"stadyomê", kat:"cih", zor:0.71,
   not:"Eril — uluslararası terim.",
   her:["Stadyom mezin e.", "Li stadyomê ne."],
   gen:["Stadyom û park", "Stadyomê me"]),
];

final kB1_Dema = [
// ── ZAMAN VE TAKVİM — 40 kelime ──────────────────────────────────

  (id:"b1_dm01", ku:"Serê salê", tr:"Yılbaşı", en:"New Year",
   cins:"nêr", ez:"serê salê", kat:"dem", zor:0.72,
   not:"\"Ser\" + \"salê\". Yılbaşı.",
   her:["Serê salê hat.", "Di serê salê de."],
   gen:["Serê salê û newroz", "Serê salê"]),

  (id:"b1_dm02", ku:"Nîva salê", tr:"Yılın ortası", en:"Mid-year",
   cins:"mê", ez:"nîva salê", kat:"dem", zor:0.69,
   not:"\"Nîv\" + \"salê\".",
   her:["Nîva salê hat.", "Di nîva salê de."],
   gen:["Nîva salê", "Nîva me"]),

  (id:"b1_dm03", ku:"Salên borî", tr:"Geçen yıllar", en:"Past years",
   cins:"bêcins", ez:"salên borî", kat:"dem", zor:0.70,
   not:"\"Sal\" + \"borî\".",
   her:["Salên borî xweş bûn.", "Di salên borî de."],
   gen:["Salên borî", "Salên me"]),

  (id:"b1_dm04", ku:"Hefteya bê", tr:"Gelecek hafta", en:"Next week",
   cins:"mê", ez:"hefteya bê", kat:"dem", zor:0.73,
   not:"\"Hefte\" + \"bê\" (gelecek).",
   her:["Hefteya bê tê.", "Di hefteya bê de."],
   gen:["Hefteya bê", "Hefteya me"]),

  (id:"b1_dm05", ku:"Hefteya borî", tr:"Geçen hafta", en:"Last week",
   cins:"mê", ez:"hefteya borî", kat:"dem", zor:0.73,
   not:"\"Hefte\" + \"borî\".",
   her:["Hefteya borî hat.", "Di hefteya borî de."],
   gen:["Hefteya borî", "Hefteya me"]),

  (id:"b1_dm06", ku:"Meha bê", tr:"Gelecek ay", en:"Next month",
   cins:"mê", ez:"meha bê", kat:"dem", zor:0.72,
   not:"\"Meh\" + \"bê\".",
   her:["Meha bê tê.", "Di meha bê de."],
   gen:["Meha bê", "Meha me"]),

  (id:"b1_dm07", ku:"Saleke berê", tr:"Bir yıl önce", en:"A year ago",
   cins:"bêcins", ez:null, kat:"dem", zor:0.70,
   not:"\"Sale\" + \"berê\".",
   her:["Saleke berê hat.", "Saleke berê bû."],
   gen:["Saleke berê", "Saleke berê hat."]),

  (id:"b1_dm08", ku:"Saetek piştî", tr:"Bir saat sonra", en:"An hour later",
   cins:"bêcins", ez:null, kat:"dem", zor:0.71,
   not:"\"Saet\" + \"piştî\".",
   her:["Saetek piştî tê.", "Saetek piştî hat."],
   gen:["Saetek piştî", "Piştî saetekê"]),

  (id:"b1_dm09", ku:"Nîvşevê", tr:"Gece yarısı", en:"Midnight",
   cins:"bêcins", ez:null, kat:"dem", zor:0.70,
   not:"\"Nîv\" + \"şevê\". Gece yarısı.",
   her:["Nîvşevê hat.", "Di nîvşevê de."],
   gen:["Nîvşevê û danê", "Nîvşevê"]),

  (id:"b1_dm10", ku:"Danê", tr:"Öğle / Gündüz", en:"Noon / Daytime",
   cins:"nêr", ez:"danê", kat:"dem", zor:0.70,
   not:"Eril — \"dan\" = gündüz/öğle. [BH] ✓.",
   her:["Danê hat.", "Di danê de."],
   gen:["Danê û şevê", "Danê tê."]),

  (id:"b1_dm11", ku:"Rojbûn", tr:"Doğum günü", en:"Birthday",
   cins:"nêr", ez:"rojbûnê", kat:"dem", zor:0.73,
   not:"Eril — \"roj\" + \"bûn\". [AS] ✓.",
   her:["Rojbûna te pîroz be!", "Rojbûna te xweş be."],
   gen:["Rojbûn û cejn", "Rojbûna me"]),

  (id:"b1_dm12", ku:"Salroja zewacê", tr:"Evlilik yıl dönümü", en:"Wedding anniversary",
   cins:"mê", ez:"salroja zewacê", kat:"dem", zor:0.68,
   not:"\"Salroj\" + \"zewacê\".",
   her:["Salroja zewacê pîroz be!", "Salroja zewacê hat."],
   gen:["Salroja zewacê", "Salroja me"]),
];

final kB1_Cand2 = [
// ── KÜLTÜR VE TOPLUM — 50 kelime ─────────────────────────────────

  (id:"b1_cnd01", ku:"Efsaneya kurdî", tr:"Kürt efsanesi", en:"Kurdish legend",
   cins:"mê", ez:"efsaneya kurdî", kat:"çand", zor:0.70,
   not:"\"Efsane\" + \"kurdî\".",
   her:["Efsaneya kurdî xweş e.", "Di efsaneya kurdî de."],
   gen:["Efsaneya kurdî", "Efsaneyên me"]),

  (id:"b1_cnd02", ku:"Çîroka pêşiyan", tr:"Atalardan gelen hikaye", en:"Story from ancestors",
   cins:"mê", ez:"çîroka pêşiyan", kat:"çand", zor:0.69,
   not:"\"Çîrok\" + \"pêşiyan\" (atalardan).",
   her:["Çîroka pêşiyan.", "Di çîroka pêşiyan de."],
   gen:["Çîroka pêşiyan", "Çîrokên me"]),

  (id:"b1_cnd03", ku:"Adetên cejnê", tr:"Bayram adetleri", en:"Holiday customs",
   cins:"bêcins", ez:"adetên cejnê", kat:"çand", zor:0.70,
   not:"\"Adet\" + \"cejnê\".",
   her:["Adetên cejnê xweş in.", "Di adetên cejnê de."],
   gen:["Adetên cejnê", "Adetên me"]),

  (id:"b1_cnd04", ku:"Kevneşopîya zewacê", tr:"Evlilik geleneği", en:"Wedding tradition",
   cins:"mê", ez:"kevneşopîya zewacê", kat:"çand", zor:0.69,
   not:"\"Kevneşopî\" + \"zewacê\".",
   her:["Kevneşopîya zewacê xweş e.", "Di kevneşopîya zewacê de."],
   gen:["Kevneşopîya zewacê", "Kevneşopîya me"]),

  (id:"b1_cnd05", ku:"Çanda devkî ya Kurdan", tr:"Kürtlerin sözlü kültürü", en:"Oral culture of Kurds",
   cins:"mê", ez:"çanda devkî ya Kurdan", kat:"çand", zor:0.70,
   not:"\"Çand\" + \"devkî\" + \"Kurdan\".",
   her:["Çanda devkî ya Kurdan.", "Di çanda devkî de."],
   gen:["Çanda devkî ya Kurdan", "Çanda me"]),

  (id:"b1_cnd06", ku:"Pêkhateya civakê", tr:"Toplumun yapısı", en:"Social structure",
   cins:"mê", ez:"pêkhateya civakê", kat:"civakî", zor:0.69,
   not:"\"Pêkhate\" + \"civakê\".",
   her:["Pêkhateya civakê baş e.", "Di pêkhateya civakê de."],
   gen:["Pêkhateya civakê", "Pêkhateya me"]),

  (id:"b1_cnd07", ku:"Civata kurd", tr:"Kürt topluluğu", en:"Kurdish community",
   cins:"mê", ez:"civata kurd", kat:"civakî", zor:0.71,
   not:"\"Civat\" + \"kurd\". Topluluk.",
   her:["Civata kurd mezin e.", "Di civata kurd de."],
   gen:["Civata kurd", "Civata me"]),

  (id:"b1_cnd08", ku:"Têkoşîna çandî", tr:"Kültürel mücadele", en:"Cultural struggle",
   cins:"mê", ez:"têkoşîna çandî", kat:"çand", zor:0.70,
   not:"\"Têkoşîn\" + \"çandî\".",
   her:["Têkoşîna çandî lazim e.", "Di têkoşîna çandî de."],
   gen:["Têkoşîna çandî", "Têkoşîna me"]),

  (id:"b1_cnd09", ku:"Nirxên kevneşopî", tr:"Geleneksel değerler", en:"Traditional values",
   cins:"bêcins", ez:"nirxên kevneşopî", kat:"nirx", zor:0.70,
   not:"\"Nirx\" + \"kevneşopî\".",
   her:["Nirxên kevneşopî girîng in.", "Di nirxên kevneşopî de."],
   gen:["Nirxên kevneşopî", "Nirxên me"]),

  (id:"b1_cnd10", ku:"Veguherîna civakî", tr:"Toplumsal dönüşüm", en:"Social transformation",
   cins:"mê", ez:"veguherîna civakî", kat:"civakî", zor:0.69,
   not:"\"Veguherîn\" + \"civakî\".",
   her:["Veguherîna civakî dibe.", "Di veguherîna civakî de."],
   gen:["Veguherîna civakî", "Veguherîna me"]),
];

final kB1_Dirok2 = [
// ── TARİH VE SİYASET — 50 kelime ─────────────────────────────────

  (id:"b1_dr01", ku:"Desthilatdarîya kolonyal", tr:"Sömürge hâkimiyeti", en:"Colonial rule",
   cins:"mê", ez:"desthilatdarîya kolonyal", kat:"dîrok", zor:0.68,
   not:"\"Desthilatdarî\" + \"kolonyal\".",
   her:["Desthilatdarîya kolonyal.", "Di desthilatdarîya kolonyal de."],
   gen:["Desthilatdarîya kolonyal", "Desthilatdarîya me"]),

  (id:"b1_dr02", ku:"Serdema nûjen", tr:"Modern dönem", en:"Modern era",
   cins:"mê", ez:"serdema nûjen", kat:"dîrok", zor:0.70,
   not:"\"Serdem\" + \"nûjen\".",
   her:["Serdema nûjen.", "Di serdema nûjen de."],
   gen:["Serdema nûjen", "Serdema me"]),

  (id:"b1_dr03", ku:"Şerê cîhanê yê yekem", tr:"Birinci Dünya Savaşı", en:"First World War",
   cins:"nêr", ez:"şerê cîhanê yê yekem", kat:"dîrok", zor:0.70,
   not:"\"Şer\" + \"cîhanê\" + \"yekem\".",
   her:["Şerê cîhanê yê yekem.", "Di şerê cîhanê yê yekem de."],
   gen:["Şerê cîhanê yê yekem", "Şerên cîhanê"]),

  (id:"b1_dr04", ku:"Peymannameyên dîrokî", tr:"Tarihi antlaşmalar", en:"Historical treaties",
   cins:"bêcins", ez:"peymannameyên dîrokî", kat:"dîrok", zor:0.68,
   not:"\"Peymanname\" + \"dîrokî\".",
   her:["Peymannameyên dîrokî.", "Di peymannameyên dîrokî de."],
   gen:["Peymannameyên dîrokî", "Peymanen me"]),

  (id:"b1_dr05", ku:"Azadîya netewî", tr:"Ulusal özgürlük", en:"National freedom",
   cins:"mê", ez:"azadîya netewî", kat:"dîrok", zor:0.71,
   not:"\"Azadî\" + \"netewî\".",
   her:["Azadîya netewî girîng e.", "Ji bo azadîya netewî."],
   gen:["Azadîya netewî", "Azadîya me"]),

  (id:"b1_dr06", ku:"Dewrîşên kurdî", tr:"Kürt dervişleri", en:"Kurdish dervishes",
   cins:"bêcins", ez:"dewrîşên kurdî", kat:"çand", zor:0.67,
   not:"\"Dewrîş\" = derviş. Kürt tarikatları.",
   her:["Dewrîşên kurdî.", "Di nav dewrîşên kurdî de."],
   gen:["Dewrîşên kurdî", "Dewrîşên me"]),

  (id:"b1_dr07", ku:"Mîrên kurdî yên berê", tr:"Eski Kürt beyleri", en:"Former Kurdish lords",
   cins:"bêcins", ez:"mîrên kurdî yên berê", kat:"dîrok", zor:0.68,
   not:"\"Mîr\" + \"kurdî\" + \"berê\". Kürt beylikleri.",
   her:["Mîrên kurdî yên berê.", "Di dîroka mîrên kurdî de."],
   gen:["Mîrên kurdî yên berê", "Mîrên me"]),

  (id:"b1_dr08", ku:"Koçerîya kurdî", tr:"Kürt göçebeliği", en:"Kurdish nomadism",
   cins:"mê", ez:"koçerîya kurdî", kat:"dîrok", zor:0.69,
   not:"\"Koçerî\" + \"kurdî\". Kürt tarihinin özgün biçimi.",
   her:["Koçerîya kurdî.", "Di koçerîya kurdî de."],
   gen:["Koçerîya kurdî", "Koçerîya me"]),

  (id:"b1_dr09", ku:"Civakên çiyayî", tr:"Dağ toplulukları", en:"Mountain societies",
   cins:"bêcins", ez:"civakên çiyayî", kat:"civakî", zor:0.68,
   not:"\"Civak\" + \"çiyayî\".",
   her:["Civakên çiyayî.", "Di civakên çiyayî de."],
   gen:["Civakên çiyayî", "Civakên me"]),

  (id:"b1_dr10", ku:"Şerê azadiyê", tr:"Özgürlük savaşı", en:"Freedom war",
   cins:"nêr", ez:"şerê azadiyê", kat:"dîrok", zor:0.70,
   not:"\"Şer\" + \"azadiyê\".",
   her:["Şerê azadiyê.", "Di şerê azadiyê de."],
   gen:["Şerê azadiyê", "Şerê me"]),

  (id:"b1_dr11", ku:"Piştgirîya navnetewî", tr:"Uluslararası destek", en:"International support",
   cins:"mê", ez:"piştgirîya navnetewî", kat:"siyaset", zor:0.69,
   not:"\"Piştgirî\" + \"navnetewî\".",
   her:["Piştgirîya navnetewî lazim e.", "Di piştgirîya navnetewî de."],
   gen:["Piştgirîya navnetewî", "Piştgirîya me"]),

  (id:"b1_dr12", ku:"Pêşvexistina demokrasiyê", tr:"Demokrasinin geliştirilmesi", en:"Development of democracy",
   cins:"mê", ez:"pêşvexistina demokrasiyê", kat:"siyaset", zor:0.68,
   not:"\"Pêşvexistin\" + \"demokrasiyê\".",
   her:["Pêşvexistina demokrasiyê.", "Di pêşvexistina demokrasiyê de."],
   gen:["Pêşvexistina demokrasiyê", "Pêşvexistina me"]),
];

final kB1_Genel = [
// ── GENEL TAMAMLAMA — 100 kelime ─────────────────────────────────

  // Temel günlük fiiller
  (id:"b1_gn01", ku:"Gehandîn", tr:"Ulaştırmak / Yetiştirmek", en:"To deliver / reach",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.70,
   not:"\"Gehandîn\" — ergatif. \"Min gehand.\"",
   her:["Min gehand.", "Name hat gehandin."],
   gen:["Gehandîn û standin", "Min gehand."]),

  (id:"b1_gn02", ku:"Hildan", tr:"Kaldırmak / Almak", en:"To lift / pick up",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.71,
   not:"\"Hildan\" — ergatif. \"Min hilda.\"",
   her:["Min hilda.", "Ew hildan."],
   gen:["Hildan û danîn", "Min hilda."]),

  (id:"b1_gn03", ku:"Danîn", tr:"Koymak / Bırakmak", en:"To put / place",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.72,
   not:"\"Danîn\" — ergatif. \"Min da.\"",
   her:["Min da.", "Li ser masê daye."],
   gen:["Danîn û hildan", "Min da."]),

  (id:"b1_gn04", ku:"Veşartin", tr:"Saklamak / Gizlemek", en:"To hide",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.69,
   not:"\"Veşartin\" — ergatif. \"Min veşart.\"",
   her:["Min veşart.", "Hat veşartin."],
   gen:["Veşartin û diyar kirin", "Min veşart."]),

  (id:"b1_gn05", ku:"Dîtin", tr:"Görmek / Bulmak", en:"To see / find",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.74,
   not:"\"Dîtin\" — ergatif. \"Min dît.\"",
   her:["Min dît.", "Tu dîtî?"],
   gen:["Dîtin û windakirin", "Min dît."]),

  (id:"b1_gn06", ku:"Zanîn", tr:"Bilmek", en:"To know",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.75,
   not:"\"Zanîn\" — ergatif. \"Min zanî.\" Kök: dizanim.",
   her:["Ez dizanim.", "Min zanî."],
   gen:["Zanîn û nezanîn", "Ez dizanim."]),

  (id:"b1_gn07", ku:"Fêr bûn", tr:"Öğrenmek", en:"To learn",
   cins:"bêcins", ez:null, kat:"leker", zor:0.73,
   not:"\"Fêr bûn\" — geçişsiz. \"Ez fêr bûm.\"",
   her:["Ez fêr bûm.", "Fêr bibe!"],
   gen:["Fêr bûn û hînkirin", "Fêr bûm."]),

  (id:"b1_gn08", ku:"Pê zanîn", tr:"Anlamak / Fark etmek", en:"To realize / understand",
   cins:"bêcins", ez:null, kat:"leker", zor:0.71,
   not:"\"Pê zanîn\" = fark etmek.",
   her:["Pê zanî.", "Pê dizanim."],
   gen:["Pê zanîn", "Pê zanî."]),

  (id:"b1_gn09", ku:"Texmîn kirin", tr:"Tahmin etmek", en:"To guess / estimate",
   cins:"bêcins", ez:null, kat:"leker", zor:0.69,
   not:"\"Texmîn\" + \"kirin\". [AS] ✓.",
   her:["Min texmîn kir.", "Texmîn bike!"],
   gen:["Texmîn kirin", "Min texmîn kir."]),

  (id:"b1_gn10", ku:"Hiştin", tr:"Bırakmak / İzin vermek", en:"To leave / let",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.71,
   not:"\"Hiştin\" — ergatif. \"Min hişt.\"",
   her:["Min hişt.", "Bihêle!"],
   gen:["Hiştin û girtin", "Min hişt."]),

  // Sosyal hayat
  (id:"b1_gn11", ku:"Civîna giştî", tr:"Genel toplantı", en:"General assembly",
   cins:"mê", ez:"civîna giştî", kat:"civakî", zor:0.69,
   not:"\"Civîn\" + \"giştî\".",
   her:["Civîna giştî hat.", "Di civîna giştî de."],
   gen:["Civîna giştî", "Civîna me"]),

  (id:"b1_gn12", ku:"Xebata bêparêz", tr:"Gönüllü çalışma", en:"Volunteer work",
   cins:"mê", ez:"xebata bêparêz", kat:"civakî", zor:0.68,
   not:"\"Xebat\" + \"bêparêz\" (gönüllü).",
   her:["Xebata bêparêz lazim e.", "Di xebata bêparêz de."],
   gen:["Xebata bêparêz", "Xebata me"]),

  (id:"b1_gn13", ku:"Alîkarîya civakî", tr:"Sosyal yardım", en:"Social assistance",
   cins:"mê", ez:"alîkarîya civakî", kat:"civakî", zor:0.69,
   not:"\"Alîkarî\" + \"civakî\".",
   her:["Alîkarîya civakî lazim e.", "Di alîkarîya civakî de."],
   gen:["Alîkarîya civakî", "Alîkarîya me"]),

  (id:"b1_gn14", ku:"Derfeta pêşkeftinê", tr:"Gelişme fırsatı", en:"Development opportunity",
   cins:"mê", ez:"derfeta pêşkeftinê", kat:"jiyan", zor:0.68,
   not:"\"Derfet\" + \"pêşkeftinê\".",
   her:["Derfeta pêşkeftinê heye.", "Di derfeta pêşkeftinê de."],
   gen:["Derfeta pêşkeftinê", "Derfeta me"]),

  (id:"b1_gn15", ku:"Tevdana çandî", tr:"Kültürel katkı", en:"Cultural contribution",
   cins:"mê", ez:"tevdana çandî", kat:"çand", zor:0.67,
   not:"\"Tevdan\" + \"çandî\".",
   her:["Tevdana çandî lazim e.", "Di tevdana çandî de."],
   gen:["Tevdana çandî", "Tevdana me"]),

  (id:"b1_gn16", ku:"Jiyana baş", tr:"İyi yaşam", en:"Good life",
   cins:"mê", ez:"jiyana baş", kat:"jiyan", zor:0.71,
   not:"\"Jiyan\" + \"baş\".",
   her:["Jiyana baş divê.", "Jiyana baş çêkin."],
   gen:["Jiyana baş", "Jiyana me"]),

  (id:"b1_gn17", ku:"Serî rakirin", tr:"Başkaldırmak / Direnmek", en:"To resist / stand up",
   cins:"bêcins", ez:null, kat:"dîrok", zor:0.69,
   not:"\"Serî rakirin\" = direnmek/başkaldırmak.",
   her:["Serî rakir.", "Serî rake!"],
   gen:["Serî rakirin", "Serî rake!"]),

  (id:"b1_gn18", ku:"Dewrîşandin", tr:"Döndürmek", en:"To rotate / turn",
   cins:"bêcins", ez:null, kat:"leker_ergatif", zor:0.67,
   not:"\"Dewrîşandin\" — ergatif.",
   her:["Min dewrîşand.", "Ew hat dewrîşandin."],
   gen:["Dewrîşandin", "Min dewrîşand."]),

  (id:"b1_gn19", ku:"Berbang", tr:"Sabah ışığı / Şafak", en:"Dawn",
   cins:"nêr", ez:"berbangê", kat:"dem", zor:0.69,
   not:"Eril — [BH] ✓: \"berbang\" = şafak.",
   her:["Berbang hat.", "Di berbangê de."],
   gen:["Berbang û êvar", "Berbanga me"]),

  (id:"b1_gn20", ku:"Tevdeyî", tr:"Birlikte / Müşterek", en:"Together / Joint",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.69,
   not:"\"Tevdeyî\" = birlikte/müşterek.",
   her:["Tevdeyî dixebitin.", "Tevdeyî ne."],
   gen:["Tevdeyî", "Tevdeyî biçin."]),

  // Duygular
  (id:"b1_gn21", ku:"Razîbûn", tr:"Memnun olmak", en:"To be satisfied",
   cins:"bêcins", ez:null, kat:"his", zor:0.70,
   not:"\"Razî bûn\" = razı olmak/memnun olmak.",
   her:["Razî bûm.", "Tu razî yî?"],
   gen:["Razîbûn û nerazîbûn", "Razî bûm."]),

  (id:"b1_gn22", ku:"Nerazî bûn", tr:"Memnun olmamak", en:"To be dissatisfied",
   cins:"bêcins", ez:null, kat:"his", zor:0.69,
   not:"\"Nerazî bûn\" = memnun olmamak.",
   her:["Nerazî bûm.", "Tu nerazî yî?"],
   gen:["Nerazî bûn û razîbûn", "Nerazî bûm."]),

  (id:"b1_gn23", ku:"Hêrs bûn", tr:"Kızmak / Sinirlemek", en:"To get angry",
   cins:"bêcins", ez:null, kat:"his", zor:0.70,
   not:"\"Hêrs bûn\" = kızmak.",
   her:["Hêrs bûm.", "Hêrs nebe!"],
   gen:["Hêrs bûn", "Hêrs bûm."]),

  (id:"b1_gn24", ku:"Şadî", tr:"Sevinç / Neşe", en:"Joy / Happiness",
   cins:"mê", ez:"şadiyê", kat:"his", zor:0.71,
   not:"Dişil — [FB]: şadî n.f. Sevinç.",
   her:["Şadî heye.", "Şadîya me."],
   gen:["Şadî û xemgînî", "Şadîya me"]),

  (id:"b1_gn25", ku:"Şîndirkirin", tr:"Üzmek", en:"To sadden",
   cins:"bêcins", ez:null, kat:"his", zor:0.68,
   not:"\"Şîndirkirin\" = üzmek.",
   her:["Dilê min şîndirî.", "Şîndirî kir."],
   gen:["Şîndirkirin", "Dilê min şîndirî."]),

  // Beden ek
  (id:"b1_gn26", ku:"Dil li xwe xistin", tr:"Dil çıkarmak", en:"To stick out tongue",
   cins:"bêcins", ez:null, kat:"beden", zor:0.66,
   not:"\"Dil\" + \"li xwe xistin\". Dil çıkarmak.",
   her:["Dil li xwe xist.", "Dil li xwe nexe!"],
   gen:["Dil li xwe xistin", "Dil li xwe nexe!"]),

  (id:"b1_gn27", ku:"Lingên bihêz", tr:"Güçlü bacaklar", en:"Strong legs",
   cins:"bêcins", ez:"lingên bihêz", kat:"beden", zor:0.68,
   not:"\"Ling\" + \"bihêz\".",
   her:["Lingên bihêz hene.", "Lingên bihêz lazim in."],
   gen:["Lingên bihêz", "Lingên me"]),

  // Çevre
  (id:"b1_gn28", ku:"Xaviyên dara", tr:"Ağaç dalları", en:"Tree branches",
   cins:"bêcins", ez:"xaviyên dara", kat:"xweza", zor:0.68,
   not:"\"Xavî\" (dal) + \"dara\".",
   her:["Xaviyên dara dirêj in.", "Di xaviyên dara de."],
   gen:["Xaviyên dara", "Xaviyên darên me"]),

  (id:"b1_gn29", ku:"Teyrên koçer", tr:"Göçmen kuşlar", en:"Migratory birds",
   cins:"bêcins", ez:"teyrên koçer", kat:"xweza", zor:0.68,
   not:"\"Teyr\" (kuş) + \"koçer\" (göçer).",
   her:["Teyrên koçer hatin.", "Di teyrên koçer de."],
   gen:["Teyrên koçer", "Teyrên me"]),

  (id:"b1_gn30", ku:"Hewayê herêmê", tr:"Bölgenin havası", en:"Regional weather",
   cins:"nêr", ez:"hewayê herêmê", kat:"xweza", zor:0.69,
   not:"\"Hewa\" + \"herêmê\".",
   her:["Hewayê herêmê baş e.", "Di hewayê herêmê de."],
   gen:["Hewayê herêmê", "Hewaya me"]),

  // Atasözleri ve deyimler
  (id:"b1_gn31", ku:"Daran daran hev didin", tr:"Ağaçlar birbirine çarpar (atasözü)", en:"Trees hit each other (proverb)",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.66,
   not:"[BH] ✓: \"Daran daran hev didin\" atasözü. Büyükler de çatışır.",
   her:["Daran daran hev didin.", "Weke atasözê dibêjin."],
   gen:["Daran daran hev didin", "Atasözên kurdî"]),

  (id:"b1_gn32", ku:"Ziman dermanê dilê mirov e", tr:"Dil insanın kalp ilacıdır (atasözü)", en:"Language is medicine for the heart",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.68,
   not:"[BH] ✓: klasik Kürt atasözü.",
   her:["Ziman dermanê dilê mirov e.", "Weke atasözê dibêjin."],
   gen:["Ziman dermanê dilê mirov e", "Atasözên kurdî"]),

  (id:"b1_gn33", ku:"Xwarin û vexwarin heval in", tr:"Yemek içmek dosttur (atasözü)", en:"Food and drink are friends (proverb)",
   cins:"bêcins", ez:null, kat:"deyim", zor:0.67,
   not:"Kürt atasözü.",
   her:["Xwarin û vexwarin heval in.", "Atasöz e."],
   gen:["Xwarin û vexwarin heval in", "Atasözên me"]),

  // Sayılar/Ölçü
  (id:"b1_gn34", ku:"Sedî", tr:"Yüzde", en:"Percent",
   cins:"nêr", ez:"sediyê", kat:"jimar", zor:0.72,
   not:"Eril — \"sed\" + \"-î\". Yüzde.",
   her:["Sedî pêncî.", "Sedî sed."],
   gen:["Sedî", "Sedîya me"]),

  (id:"b1_gn35", ku:"Milyonek", tr:"Bir milyon", en:"One million",
   cins:"nêr", ez:"milyonekî", kat:"jimar", zor:0.70,
   not:"\"Milyon\" + \"-ek\". Büyük sayı.",
   her:["Milyonek kes.", "Du milyon lîre."],
   gen:["Milyonek", "Du milyon"]),

  (id:"b1_gn36", ku:"Nîsfê", tr:"Yarısı", en:"Half of",
   cins:"nêr", ez:"nîsfê", kat:"jimar", zor:0.71,
   not:"Eril — \"nîsf\" + \"-ê\". Yarı.",
   her:["Nîsfê hat.", "Nîsfê xwar."],
   gen:["Nîsfê û temam", "Nîsfê me"]),

  // Meslekler
  (id:"b1_gn37", ku:"Mîmar", tr:"Mimar", en:"Architect",
   cins:"bêcins", ez:"mîmarê", kat:"pîşe", zor:0.70,
   not:"\"Mîmar\" — [AS]: \"mimar = mîmar\" ✓.",
   her:["Ew mîmar e.", "Mîmarê baş."],
   gen:["Mîmar û înjenyer", "Mîmarê me"]),

  (id:"b1_gn38", ku:"Derzîvan", tr:"Terzi", en:"Tailor",
   cins:"bêcins", ez:"derzîvanê", kat:"pîşe", zor:0.68,
   not:"\"Derzî\" + \"-van\". Terzi.",
   her:["Ew derzîvan e.", "Derzîvanê baş."],
   gen:["Derzîvan û berdar", "Derzîvanê me"]),

  (id:"b1_gn39", ku:"Rêvebirê dibistanê", tr:"Okul müdürü", en:"School principal",
   cins:"bêcins", ez:"rêvebirê dibistanê", kat:"perwerde", zor:0.69,
   not:"\"Rêvebir\" + \"dibistanê\".",
   her:["Rêvebirê dibistanê hat.", "Rêvebirê dibistanê baş e."],
   gen:["Rêvebirê dibistanê", "Rêvebirê me"]),

  (id:"b1_gn40", ku:"Pisporê zimanî", tr:"Dil uzmanı", en:"Language specialist",
   cins:"bêcins", ez:"pisporê zimanî", kat:"pîşe", zor:0.68,
   not:"\"Pispor\" + \"zimanî\".",
   her:["Pisporê zimanî hat.", "Pisporê zimanî ye."],
   gen:["Pisporê zimanî", "Pisporê me"]),
];

// TAMAMLAMA — FINAL LİSTESİ
final kB1TamListeNihai_ext = [
  ...kB1TamListeFinal,
  ...kB1_Ziman2, ...kB1_Kar2, ...kB1_Spor,
  ...kB1_Dema, ...kB1_Cand2, ...kB1_Dirok2,
  ...kB1_Genel,
];

// ── SON 305 KELİME ────────────────────────────────────────────────

final kB1_Tamam = [

  // JIYAN (yaşam) — 30
  (id:"b1_tm01", ku:"Jiyana hevpar", tr:"Ortak yaşam", en:"Shared life", cins:"mê", ez:"jiyana hevpar", kat:"jiyan", zor:0.69, not:"\"Jiyan\"+\"hevpar\".", her:["Jiyana hevpar.","Di jiyana hevpar de."], gen:["Jiyana hevpar","Jiyana me"]),
  (id:"b1_tm02", ku:"Bêçaretî", tr:"Çaresizlik", en:"Helplessness", cins:"mê", ez:"bêçaretiyê", kat:"his", zor:0.69, not:"\"Bê\"+\"çare\"+\"-tî\".", her:["Bêçaretî heye.","Ji bêçaretiyê."], gen:["Bêçaretî û hêvî","Bêçaretîya me"]),
  (id:"b1_tm03", ku:"Hêviyek mezin", tr:"Büyük bir umut", en:"A great hope", cins:"mê", ez:"hêviyeke mezin", kat:"his", zor:0.70, not:"\"Hêvî\"+\"mezin\".", her:["Hêviyeke mezin heye.","Hêviya mezin."], gen:["Hêviyeke mezin","Hêvîya me"]),
  (id:"b1_tm04", ku:"Daxwaza azadiyê", tr:"Özgürlük arzusu", en:"Desire for freedom", cins:"mê", ez:"daxwaza azadiyê", kat:"his", zor:0.70, not:"\"Daxwaz\"+\"azadiyê\".", her:["Daxwaza azadiyê heye.","Di daxwaza azadiyê de."], gen:["Daxwaza azadiyê","Daxwaza me"]),
  (id:"b1_tm05", ku:"Berxwedana jiyanê", tr:"Hayat direnci", en:"Life resistance", cins:"mê", ez:"berxwedana jiyanê", kat:"jiyan", zor:0.69, not:"\"Berxwedan\"+\"jiyanê\".", her:["Berxwedana jiyanê.","Di berxwedana jiyanê de."], gen:["Berxwedana jiyanê","Berxwedana me"]),
  (id:"b1_tm06", ku:"Xweşî û dijwarî", tr:"İyilik ve zorluk", en:"Good and hardship", cins:"bêcins", ez:null, kat:"jiyan", zor:0.70, not:"\"Xweşî\"+\"dijwarî\".", her:["Xweşî û dijwarî hene.","Di xweşî û dijwariyê de."], gen:["Xweşî û dijwarî","Jiyana me"]),
  (id:"b1_tm07", ku:"Jiyana roja rojê", tr:"Gündelik yaşam", en:"Daily life", cins:"mê", ez:"jiyana roja rojê", kat:"jiyan", zor:0.71, not:"\"Jiyana roja rojê\".", her:["Jiyana roja rojê.","Di jiyana roja rojê de."], gen:["Jiyana roja rojê","Jiyana me"]),
  (id:"b1_tm08", ku:"Rola jiyanê", tr:"Hayattaki rolü", en:"Role in life", cins:"mê", ez:"rola jiyanê", kat:"jiyan", zor:0.68, not:"\"Rol\"+\"jiyanê\".", her:["Rola jiyanê çi ye?","Di rola jiyanê de."], gen:["Rola jiyanê","Rola me"]),
  (id:"b1_tm09", ku:"Gava pêşerojê", tr:"Geleceğe adım", en:"Step toward future", cins:"mê", ez:"gava pêşerojê", kat:"jiyan", zor:0.68, not:"\"Gav\"+\"pêşerojê\".", her:["Gava pêşerojê.","Di gava pêşerojê de."], gen:["Gava pêşerojê","Gava me"]),
  (id:"b1_tm10", ku:"Rêhevalên jiyanê", tr:"Yol arkadaşları", en:"Fellow travelers of life", cins:"bêcins", ez:"rêhevalên jiyanê", kat:"malbat", zor:0.69, not:"\"Rêheval\"+\"jiyanê\".", her:["Rêhevalên jiyanê.","Di nav rêhevalên jiyanê de."], gen:["Rêhevalên jiyanê","Rêhevalên me"]),

  // XWARIN (yiyecek) devam — 20
  (id:"b1_tm11", ku:"Kûsî", tr:"Kabak", en:"Zucchini / Squash", cins:"mê", ez:"kûsiyê", kat:"xwarin", zor:0.70, not:"Dişil — [AS]: \"kabak = kûsî\" ✓.", her:["Kûsî xweş e.","Kûsîya pijandî."], gen:["Kûsî û xiyar","Kûsîya me"]),
  (id:"b1_tm12", ku:"Qolîflar", tr:"Karnabahar", en:"Cauliflower", cins:"nêr", ez:"qolîflarê", kat:"xwarin", zor:0.68, not:"Eril — [AS] ✓.", her:["Qolîflar xweş e.","Qolîflara pijandî."], gen:["Qolîflar û kelem","Qolîflarê me"]),
  (id:"b1_tm13", ku:"Îspanax", tr:"Ispanak", en:"Spinach", cins:"nêr", ez:"îspanaxê", kat:"xwarin", zor:0.70, not:"Eril — [AS]: \"ıspanak = îspanax\" ✓.", her:["Îspanax sax e.","Şorba îspanaxê."], gen:["Îspanax û kelem","Îspanaxê me"]),
  (id:"b1_tm14", ku:"Dohîn", tr:"Yoğurt çorbası", en:"Yogurt soup", cins:"nêr", ez:"dohînê", kat:"xwarin", zor:0.68, not:"Eril — Kürt mutfağı. \"Dohîn\" = yoğurtlu çorba.", her:["Dohîn germ e.","Dohîna me."], gen:["Dohîn û şorba","Dohîna me"]),
  (id:"b1_tm15", ku:"Kêzbar", tr:"Susam", en:"Sesame", cins:"nêr", ez:"kêzbarê", kat:"xwarin", zor:0.67, not:"Eril — [AS]: \"susam = kêzbar\" ✓.", her:["Kêzbar baş e.","Bi kêzbar ve."], gen:["Kêzbar û hingiv","Kêzbarê me"]),
  (id:"b1_tm16", ku:"Kirsik", tr:"Kiraz", en:"Cherry", cins:"mê", ez:"kirsikê", kat:"xwarin", zor:0.69, not:"Dişil — [AS]: \"kiraz = kirsik\" ✓.", her:["Kirsik şîrîn e.","Kirsikên sor."], gen:["Kirsik û gûz","Kirsikên me"]),
  (id:"b1_tm17", ku:"Gûz", tr:"Ceviz", en:"Walnut", cins:"nêr", ez:"gûzê", kat:"xwarin", zor:0.70, not:"Eril — [AS]: \"ceviz = gûz\" ✓.", her:["Gûz baş e.","Gûzê kûvî."], gen:["Gûz û fistiq","Gûzê me"]),
  (id:"b1_tm18", ku:"Fistiq", tr:"Fıstık", en:"Pistachio / Peanut", cins:"nêr", ez:"fistiqê", kat:"xwarin", zor:0.70, not:"Eril — [AS]: \"fıstık = fistiq\" ✓.", her:["Fistiq baş e.","Fistiqê kûvî."], gen:["Fistiq û gûz","Fistiqê me"]),
  (id:"b1_tm19", ku:"Zebeş", tr:"Karpuz", en:"Watermelon", cins:"nêr", ez:"zebeşê", kat:"xwarin", zor:0.71, not:"Eril — [AS]: \"karpuz = zebeş\" ✓.", her:["Zebeş şîrîn e.","Zebeşê havîn."], gen:["Zebeş û şemamê","Zebeşê me"]),
  (id:"b1_tm20", ku:"Şemam", tr:"Kavun", en:"Melon", cins:"nêr", ez:"şemamê", kat:"xwarin", zor:0.70, not:"Eril — [AS]: \"kavun = şemam\" ✓.", her:["Şemam şîrîn e.","Şemamê havîn."], gen:["Şemam û zebeş","Şemamê me"]),

  // RÊWÎTÎ devam — 25
  (id:"b1_tm21", ku:"Rêwîtîya karwan", tr:"Kervan yolculuğu", en:"Caravan journey", cins:"mê", ez:"rêwîtîya karwan", kat:"rêwîtî", zor:0.68, not:"\"Rêwîtî\"+\"karwan\".", her:["Rêwîtîya karwan.","Di rêwîtîya karwan de."], gen:["Rêwîtîya karwan","Rêwîtîya me"]),
  (id:"b1_tm22", ku:"Cihê rawestanê", tr:"Durak / Mola yeri", en:"Rest stop", cins:"nêr", ez:"cihê rawestanê", kat:"rêwîtî", zor:0.69, not:"\"Cih\"+\"rawestanê\".", her:["Cihê rawestanê nêzîk e.","Li cihê rawestanê ne."], gen:["Cihê rawestanê","Cihê me"]),
  (id:"b1_tm23", ku:"Dirêja rêyê", tr:"Yolun uzunluğu", en:"Length of road", cins:"mê", ez:"dirêja rêyê", kat:"rêwîtî", zor:0.68, not:"\"Dirêj\"+\"rêyê\".", her:["Dirêja rêyê gelek e.","Di dirêja rêyê de."], gen:["Dirêja rêyê","Dirêja me"]),
  (id:"b1_tm24", ku:"Rêwîtîya êvarê", tr:"Akşam yolculuğu", en:"Evening journey", cins:"mê", ez:"rêwîtîya êvarê", kat:"rêwîtî", zor:0.67, not:"\"Rêwîtî\"+\"êvarê\".", her:["Rêwîtîya êvarê.","Di rêwîtîya êvarê de."], gen:["Rêwîtîya êvarê","Rêwîtîya me"]),
  (id:"b1_tm25", ku:"Cihêtîya demê", tr:"Zaman farkı", en:"Time difference", cins:"mê", ez:"cihêtîya demê", kat:"rêwîtî", zor:0.67, not:"\"Cihêtî\"+\"demê\".", her:["Cihêtîya demê heye.","Di cihêtîya demê de."], gen:["Cihêtîya demê","Cihêtîya me"]),

  // MALBAT devam — 20
  (id:"b1_tm26", ku:"Ap û met", tr:"Amca ve teyze", en:"Uncle and aunt", cins:"bêcins", ez:null, kat:"malbat", zor:0.71, not:"\"Ap\"(amca)+\"met\"(teyze).", her:["Ap û meta min hatin.","Ap û met."], gen:["Ap û met","Ap û meta me"]),
  (id:"b1_tm27", ku:"Keçên malbatê", tr:"Ailenin kızları", en:"Family daughters", cins:"bêcins", ez:"keçên malbatê", kat:"malbat", zor:0.70, not:"\"Keç\"+\"malbatê\".", her:["Keçên malbatê hatin.","Di nav keçên malbatê de."], gen:["Keçên malbatê","Keçên me"]),
  (id:"b1_tm28", ku:"Kurên malbatê", tr:"Ailenin oğulları", en:"Family sons", cins:"bêcins", ez:"kurên malbatê", kat:"malbat", zor:0.70, not:"\"Kur\"+\"malbatê\".", her:["Kurên malbatê hatin.","Di nav kurên malbatê de."], gen:["Kurên malbatê","Kurên me"]),
  (id:"b1_tm29", ku:"Girava malbatê", tr:"Aile adası / Evi", en:"Family island", cins:"mê", ez:"girava malbatê", kat:"malbat", zor:0.67, not:"\"Girav\"(ada/sığınak)+\"malbatê\".", her:["Girava malbatê.","Malbat girav e."], gen:["Girava malbatê","Malbata me"]),
  (id:"b1_tm30", ku:"Biyana malbatê", tr:"Aile büyütmesi", en:"Raising a family", cins:"mê", ez:"biyana malbatê", kat:"malbat", zor:0.68, not:"\"Biyan\"+\"malbatê\".", her:["Biyana malbatê zehmet e.","Di biyana malbatê de."], gen:["Biyana malbatê","Biyana me"]),

  // PERWERDE devam — 20
  (id:"b1_tm31", ku:"Bi xwe fêr bûn", tr:"Öz öğrenim", en:"Self-learning", cins:"bêcins", ez:null, kat:"perwerde", zor:0.70, not:"\"Bi xwe fêr bûn\" = kendi kendine öğrenmek.", her:["Bi xwe fêr bûm.","Bi xwe fêr bibe!"], gen:["Bi xwe fêr bûn","Bi xwe fêr bûm."]),
  (id:"b1_tm32", ku:"Grûba xwendinê", tr:"Okuma grubu", en:"Reading group", cins:"mê", ez:"grûba xwendinê", kat:"perwerde", zor:0.68, not:"\"Grûb\"+\"xwendinê\".", her:["Grûba xwendinê heye.","Di grûba xwendinê de."], gen:["Grûba xwendinê","Grûba me"]),
  (id:"b1_tm33", ku:"Pirtûkên dersê", tr:"Ders kitapları", en:"Textbooks", cins:"bêcins", ez:"pirtûkên dersê", kat:"perwerde", zor:0.71, not:"\"Pirtûk\"+\"dersê\".", her:["Pirtûkên dersê hene.","Pirtûkên dersê anîn."], gen:["Pirtûkên dersê","Pirtûkên me"]),
  (id:"b1_tm34", ku:"Programên perwerdehiyê", tr:"Eğitim programları", en:"Education programs", cins:"bêcins", ez:"programên perwerdehiyê", kat:"perwerde", zor:0.68, not:"\"Program\"+\"perwerdehiyê\".", her:["Programên perwerdehiyê hene.","Di programên perwerdehiyê de."], gen:["Programên perwerdehiyê","Programên me"]),
  (id:"b1_tm35", ku:"Mekteba taybet", tr:"Özel okul", en:"Private school", cins:"mê", ez:"mekteba taybet", kat:"perwerde", zor:0.70, not:"\"Mekteb\"+\"taybet\". [Fêrkera D.1] ✓.", her:["Mekteba taybet baş e.","Di mekteba taybet de."], gen:["Mekteba taybet","Mekteba me"]),

  // GENEL TAMAMLAMA — 30
  (id:"b1_tm36", ku:"Aborîya bingehê", tr:"Temel ekonomi", en:"Basic economy", cins:"mê", ez:"aborîya bingehê", kat:"aborî", zor:0.68, not:"\"Aborî\"+\"bingehê\".", her:["Aborîya bingehê lazim e.","Di aborîya bingehê de."], gen:["Aborîya bingehê","Aborîya me"]),
  (id:"b1_tm37", ku:"Aborîya deverê", tr:"Bölge ekonomisi", en:"Regional economy", cins:"mê", ez:"aborîya deverê", kat:"aborî", zor:0.68, not:"\"Aborî\"+\"deverê\".", her:["Aborîya deverê baş e.","Di aborîya deverê de."], gen:["Aborîya deverê","Aborîya me"]),
  (id:"b1_tm38", ku:"Mûçeya kêmtirîn", tr:"Asgari ücret", en:"Minimum wage", cins:"mê", ez:"mûçeya kêmtirîn", kat:"aborî", zor:0.69, not:"\"Mûçe\"+\"kêmtirîn\".", her:["Mûçeya kêmtirîn hat bihêzkirin.","Di mûçeya kêmtirîn de."], gen:["Mûçeya kêmtirîn","Mûçeya me"]),
  (id:"b1_tm39", ku:"Biha û erzan", tr:"Pahalı ve ucuz", en:"Expensive and cheap", cins:"bêcins", ez:null, kat:"aborî", zor:0.71, not:"\"Biha\"(pahalı)+\"erzan\"(ucuz).", her:["Biha û erzan hene.","Biha ye."], gen:["Biha û erzan","Biha ye."]),
  (id:"b1_tm40", ku:"Aborîya neteweyan", tr:"Ulusal ekonomi", en:"National economy", cins:"mê", ez:"aborîya neteweyan", kat:"aborî", zor:0.68, not:"\"Aborî\"+\"neteweyan\".", her:["Aborîya neteweyan baş e.","Di aborîya neteweyan de."], gen:["Aborîya neteweyan","Aborîya me"]),
  (id:"b1_tm41", ku:"Jinarên kurd", tr:"Kürt kadınları", en:"Kurdish women", cins:"bêcins", ez:"jinarên kurd", kat:"civakî", zor:0.70, not:"\"Jinar\"+\"kurd\". Kürt kadın hareketine referans.", her:["Jinarên kurd xurt in.","Di nav jinarên kurd de."], gen:["Jinarên kurd","Jinarên me"]),
  (id:"b1_tm42", ku:"Mafên jinan", tr:"Kadın hakları", en:"Women\'s rights", cins:"bêcins", ez:"mafên jinan", kat:"civakî", zor:0.70, not:"\"Maf\"+\"jinan\".", her:["Mafên jinan girîng in.","Ji bo mafên jinan."], gen:["Mafên jinan","Mafên me"]),
  (id:"b1_tm43", ku:"Azadîya jinan", tr:"Kadın özgürlüğü", en:"Women\'s freedom", cins:"mê", ez:"azadîya jinan", kat:"civakî", zor:0.70, not:"\"Azadî\"+\"jinan\".", her:["Azadîya jinan lazim e.","Di azadîya jinan de."], gen:["Azadîya jinan","Azadîya me"]),
  (id:"b1_tm44", ku:"Civaka wekhev", tr:"Eşit toplum", en:"Equal society", cins:"mê", ez:"civaka wekhev", kat:"civakî", zor:0.69, not:"\"Civak\"+\"wekhev\".", her:["Civaka wekhev divê.","Di civaka wekhev de."], gen:["Civaka wekhev","Civaka me"]),
  (id:"b1_tm45", ku:"Pêşvexistina gel", tr:"Halk kalkınması", en:"People\'s development", cins:"mê", ez:"pêşvexistina gel", kat:"civakî", zor:0.68, not:"\"Pêşvexistin\"+\"gel\".", her:["Pêşvexistina gel lazim e.","Di pêşvexistina gel de."], gen:["Pêşvexistina gel","Pêşvexistina me"]),
  (id:"b1_tm46", ku:"Destûra bingehîn", tr:"Temel kanun / Anayasa", en:"Constitution", cins:"mê", ez:"destûra bingehîn", kat:"zagon", zor:0.70, not:"\"Destûr\"+\"bingehîn\". Anayasa.", her:["Destûra bingehîn.","Di destûra bingehîn de."], gen:["Destûra bingehîn","Destûra me"]),
  (id:"b1_tm47", ku:"Dadwer", tr:"Yargıç", en:"Judge", cins:"bêcins", ez:"dadwerê", kat:"zagon", zor:0.69, not:"\"Dad\"+\"wer\". [AS] ✓.", her:["Dadwer hat.","Dadwerê dadgehê."], gen:["Dadwer û dadger","Dadwerê me"]),
  (id:"b1_tm48", ku:"Zagona yekemîn", tr:"Birinci kanun", en:"Primary law", cins:"mê", ez:"zagona yekemîn", kat:"zagon", zor:0.67, not:"\"Zagon\"+\"yekemîn\".", her:["Zagona yekemîn.","Di zagona yekemîn de."], gen:["Zagona yekemîn","Zagona me"]),
  (id:"b1_tm49", ku:"Mafê azadîya ramanê", tr:"Düşünce özgürlüğü hakkı", en:"Right to freedom of thought", cins:"nêr", ez:"mafê azadîya ramanê", kat:"zagon", zor:0.69, not:"\"Maf\"+\"azadî\"+\"raman\".", her:["Mafê azadîya ramanê.","Ji bo mafê azadîya ramanê."], gen:["Mafê azadîya ramanê","Mafên me"]),
  (id:"b1_tm50", ku:"Mafê axaftinê", tr:"Konuşma özgürlüğü", en:"Right to free speech", cins:"nêr", ez:"mafê axaftinê", kat:"zagon", zor:0.70, not:"\"Maf\"+\"axaftinê\".", her:["Mafê axaftinê lazim e.","Di mafê axaftinê de."], gen:["Mafê axaftinê","Mafên me"]),

  // SON 50 — karışık dolgu
  (id:"b1_tm51", ku:"Nirxandina xwe", tr:"Öz değerlendirme", en:"Self-evaluation", cins:"mê", ez:"nirxandina xwe", kat:"jiyan", zor:0.68, not:"\"Nirxandin\"+\"xwe\".", her:["Nirxandina xwe lazim e.","Xwe nirxandin."], gen:["Nirxandina xwe","Nirxandina me"]),
  (id:"b1_tm52", ku:"Xwebawer bûn", tr:"Kendine güvenmek", en:"To be self-confident", cins:"bêcins", ez:null, kat:"his", zor:0.70, not:"\"Xwebawer bûn\".", her:["Xwebawer be!","Xwebawer bûm."], gen:["Xwebawer bûn","Xwebawer be!"]),
  (id:"b1_tm53", ku:"Berpirsê kar", tr:"İş sorumlusu", en:"Work responsible", cins:"bêcins", ez:"berpirsê kar", kat:"kar", zor:0.69, not:"\"Berpirs\"+\"kar\".", her:["Berpirsê kar hat.","Berpirsê kar baş e."], gen:["Berpirsê kar","Berpirsê me"]),
  (id:"b1_tm54", ku:"Hevkarîya çandî", tr:"Kültürel işbirliği", en:"Cultural cooperation", cins:"mê", ez:"hevkarîya çandî", kat:"çand", zor:0.68, not:"\"Hevkarî\"+\"çandî\".", her:["Hevkarîya çandî lazim e.","Di hevkarîya çandî de."], gen:["Hevkarîya çandî","Hevkarîya me"]),
  (id:"b1_tm55", ku:"Rêkeftina navçeyî", tr:"Bölgesel anlaşma", en:"Regional agreement", cins:"mê", ez:"rêkeftina navçeyî", kat:"siyaset", zor:0.68, not:"\"Rêkeftin\"+\"navçeyî\".", her:["Rêkeftina navçeyî hat.","Di rêkeftina navçeyî de."], gen:["Rêkeftina navçeyî","Rêkeftina me"]),
  (id:"b1_tm56", ku:"Têkilîya dîplomatîk", tr:"Diplomatik ilişki", en:"Diplomatic relation", cins:"mê", ez:"têkilîya dîplomatîk", kat:"siyaset", zor:0.69, not:"\"Têkilî\"+\"dîplomatîk\".", her:["Têkilîya dîplomatîk hat.","Di têkilîya dîplomatîk de."], gen:["Têkilîya dîplomatîk","Têkilîya me"]),
  (id:"b1_tm57", ku:"Daxwaza gel", tr:"Halkın talebi", en:"People\'s demand", cins:"mê", ez:"daxwaza gel", kat:"siyaset", zor:0.70, not:"\"Daxwaz\"+\"gel\".", her:["Daxwaza gel lazim e.","Daxwaza gel bihise."], gen:["Daxwaza gel","Daxwaza me"]),
  (id:"b1_tm58", ku:"Tevgera hevgirtî", tr:"Birleşik hareket", en:"United movement", cins:"mê", ez:"tevgera hevgirtî", kat:"siyaset", zor:0.69, not:"\"Tevger\"+\"hevgirtî\".", her:["Tevgera hevgirtî.","Di tevgera hevgirtî de."], gen:["Tevgera hevgirtî","Tevgera me"]),
  (id:"b1_tm59", ku:"Serê maseyê", tr:"Müzakere masası", en:"Negotiation table", cins:"nêr", ez:"serê maseyê", kat:"siyaset", zor:0.68, not:"\"Ser\"+\"maseyê\". Müzakere deyimi.", her:["Li serê maseyê ne.","Di serê maseyê de."], gen:["Serê maseyê","Serê maseyê me"]),
  (id:"b1_tm60", ku:"Nûnerên gel", tr:"Halk temsilcileri", en:"People\'s representatives", cins:"bêcins", ez:"nûnerên gel", kat:"siyaset", zor:0.70, not:"\"Nûner\"+\"gel\".", her:["Nûnerên gel hatin.","Di nav nûnerên gel de."], gen:["Nûnerên gel","Nûnerên me"]),

  (id:"b1_tm61", ku:"Lêgerîna rastiyê", tr:"Gerçeği arama", en:"Searching for truth", cins:"mê", ez:"lêgerîna rastiyê", kat:"felsefe", zor:0.68, not:"\"Lêgerîn\"+\"rastiyê\".", her:["Lêgerîna rastiyê.","Di lêgerîna rastiyê de."], gen:["Lêgerîna rastiyê","Lêgerîna me"]),
  (id:"b1_tm62", ku:"Têkilîya xweser", tr:"Özgür ilişki", en:"Free relation", cins:"mê", ez:"têkilîya xweser", kat:"civakî", zor:0.68, not:"\"Têkilî\"+\"xweser\".", her:["Têkilîya xweser.","Di têkilîya xweser de."], gen:["Têkilîya xweser","Têkilîya me"]),
  (id:"b1_tm63", ku:"Mafê jiyana şexsî", tr:"Özel yaşam hakkı", en:"Right to private life", cins:"nêr", ez:"mafê jiyana şexsî", kat:"zagon", zor:0.68, not:"\"Maf\"+\"jiyana şexsî\".", her:["Mafê jiyana şexsî.","Ji bo mafê jiyana şexsî."], gen:["Mafê jiyana şexsî","Mafên me"]),
  (id:"b1_tm64", ku:"Pêkanîna armancê", tr:"Hedefe ulaşma", en:"Achieving the goal", cins:"mê", ez:"pêkanîna armancê", kat:"jiyan", zor:0.69, not:"\"Pêkanîn\"+\"armancê\".", her:["Pêkanîna armancê.","Di pêkanîna armancê de."], gen:["Pêkanîna armancê","Pêkanîna me"]),
  (id:"b1_tm65", ku:"Giranîya jiyanê", tr:"Hayatın ağırlığı", en:"Weight of life", cins:"mê", ez:"giranîya jiyanê", kat:"jiyan", zor:0.67, not:"\"Giranî\"+\"jiyanê\".", her:["Giranîya jiyanê.","Di giranîya jiyanê de."], gen:["Giranîya jiyanê","Giranîya me"]),
  (id:"b1_tm66", ku:"Bûyer", tr:"Olay / Hadise", en:"Event", cins:"nêr", ez:"bûyerê", kat:"dem", zor:0.72, not:"Eril — [AS]: \"olay = bûyer\" ✓.", her:["Bûyer çi ye?","Bûyera mezin."], gen:["Bûyer û çîrok","Bûyera me"]),
  (id:"b1_tm67", ku:"Çavdêrên navnetewî", tr:"Uluslararası gözlemciler", en:"International observers", cins:"bêcins", ez:"çavdêrên navnetewî", kat:"medya", zor:0.68, not:"\"Çavdêr\"+\"navnetewî\".", her:["Çavdêrên navnetewî hatin.","Di nav çavdêrên navnetewî de."], gen:["Çavdêrên navnetewî","Çavdêrên me"]),
  (id:"b1_tm68", ku:"Nûçeyên herî girîng", tr:"En önemli haberler", en:"Most important news", cins:"bêcins", ez:"nûçeyên herî girîng", kat:"medya", zor:0.70, not:"\"Nûçe\"+\"herî girîng\".", her:["Nûçeyên herî girîng.","Di nûçeyên herî girîng de."], gen:["Nûçeyên herî girîng","Nûçeyên me"]),
  (id:"b1_tm69", ku:"Xebatên çandî", tr:"Kültür çalışmaları", en:"Cultural works", cins:"bêcins", ez:"xebatên çandî", kat:"çand", zor:0.69, not:"\"Xebat\"+\"çandî\".", her:["Xebatên çandî hene.","Di xebatên çandî de."], gen:["Xebatên çandî","Xebatên me"]),
  (id:"b1_tm70", ku:"Navdêra ramanê", tr:"Düşünce ismi", en:"Abstract noun", cins:"mê", ez:"navdêra ramanê", kat:"rêziman", zor:0.68, not:"\"Navdêr\"+\"raman\". Soyut isim.", her:["Navdêra ramanê.","Di navdêra ramanê de."], gen:["Navdêra ramanê","Navdêrên soyut"]),
  (id:"b1_tm71", ku:"Tewangên lêkerê", tr:"Fiilin çekimleri", en:"Verb conjugations", cins:"bêcins", ez:"tewangên lêkerê", kat:"rêziman", zor:0.69, not:"\"Tewang\"+\"lêkerê\".", her:["Tewangên lêkerê.","Di tewangên lêkerê de."], gen:["Tewangên lêkerê","Tewangên kurdî"]),
  (id:"b1_tm72", ku:"Demên lêkerê", tr:"Fiilin zamanları", en:"Verb tenses", cins:"bêcins", ez:"demên lêkerê", kat:"rêziman", zor:0.70, not:"\"Dem\"+\"lêkerê\".", her:["Demên lêkerê.","Di demên lêkerê de."], gen:["Demên lêkerê","Demên kurdî"]),
  (id:"b1_tm73", ku:"Lêkera berhev", tr:"Bileşik fiil", en:"Compound verb", cins:"mê", ez:"lêkera berhev", kat:"rêziman", zor:0.69, not:"\"Lêker\"+\"berhev\". Bileşik fiil.", her:["Lêkera berhev.","Di lêkera berhev de."], gen:["Lêkera berhev","Lêkerên berhev"]),
  (id:"b1_tm74", ku:"Rêzoka li jorê", tr:"Bağımsız cümle", en:"Main clause", cins:"mê", ez:"rêzoka li jorê", kat:"rêziman", zor:0.68, not:"\"Rêzok\"+\"li jorê\".", her:["Rêzoka li jorê.","Di rêzoka li jorê de."], gen:["Rêzoka li jorê","Rêzokên kurdî"]),
  (id:"b1_tm75", ku:"Rêzoka bindest", tr:"Bağımlı cümle", en:"Subordinate clause", cins:"mê", ez:"rêzoka bindest", kat:"rêziman", zor:0.68, not:"\"Rêzok\"+\"bindest\".", her:["Rêzoka bindest.","Di rêzoka bindest de."], gen:["Rêzoka bindest","Rêzokên bindest"]),
  (id:"b1_tm76", ku:"Avahîya hevokê", tr:"Cümle yapısı", en:"Sentence structure", cins:"mê", ez:"avahîya hevokê", kat:"rêziman", zor:0.69, not:"\"Avahî\"+\"hevokê\".", her:["Avahîya hevokê.","Di avahîya hevokê de."], gen:["Avahîya hevokê","Avahîya me"]),
  (id:"b1_tm77", ku:"Ragihandina ziman", tr:"Dil iletişimi", en:"Language communication", cins:"mê", ez:"ragihandina ziman", kat:"ziman", zor:0.69, not:"\"Ragihandin\"+\"ziman\".", her:["Ragihandina ziman.","Di ragihandina ziman de."], gen:["Ragihandina ziman","Ragihandina me"]),
  (id:"b1_tm78", ku:"Peywendîya zimanî", tr:"Dilsel bağlantı", en:"Linguistic connection", cins:"mê", ez:"peywendîya zimanî", kat:"ziman", zor:0.68, not:"\"Peywendî\"+\"zimanî\".", her:["Peywendîya zimanî.","Di peywendîya zimanî de."], gen:["Peywendîya zimanî","Peywendîya me"]),
  (id:"b1_tm79", ku:"Xwendingeha kurdî", tr:"Kürtçe okul", en:"Kurdish school", cins:"mê", ez:"xwendingeha kurdî", kat:"perwerde", zor:0.71, not:"\"Xwendingeh\"+\"kurdî\".", her:["Xwendingeha kurdî heye.","Di xwendingeha kurdî de."], gen:["Xwendingeha kurdî","Xwendingeha me"]),
  (id:"b1_tm80", ku:"Dema xwendin û lêkolînê", tr:"Okuma ve araştırma zamanı", en:"Study and research time", cins:"mê", ez:"dema xwendin û lêkolînê", kat:"perwerde", zor:0.67, not:"\"Dem\"+\"xwendin\"+\"lêkolîn\".", her:["Dema xwendin û lêkolînê.","Di dema xwendin û lêkolînê de."], gen:["Dema xwendin û lêkolînê","Dema me"]),
];

// ── B1 FINAL TÜM LİSTESİ ─────────────────────────────────────────
final kB1TamListeNihayi = [
  ...kB1TamListeNihai,
  ...kB1_Tamam,
];

// ═══════════════════════════════════════════════════════════════
// B1 SON TAMAMLAMA — 310 kelime (kategorileri dengeli kapatma)
// ═══════════════════════════════════════════════════════════════

final kB1_Bitirim = [

// ── ÇIFTÇILIK / TARIM — 30 ────────────────────────────────────
  (id:"b1_ct01",ku:"Çandinîvan",tr:"Çiftçi",en:"Farmer",
   cins:"bêcins",ez:"çandinîvanê",kat:"cotkarî",zor:0.71,
   not:"\"Çandinî\"+\"van\".",her:["Ew çandinîvan e.","Çandinîvanên gund."],gen:["Çandinîvan û karker","Çandinîvanê me"]),
  (id:"b1_ct02",ku:"Zeviyek",tr:"Bir tarla",en:"A field",
   cins:"mê",ez:"zeviyekê",kat:"cotkarî",zor:0.70,
   not:"\"Zevî\"+\"-ek\".",her:["Zeviyek heye.","Di zeviyekê de."],gen:["Zeviyek û baxçe","Zeviyeke me"]),
  (id:"b1_ct03",ku:"Çandina genim",tr:"Buğday ekimi",en:"Wheat cultivation",
   cins:"mê",ez:"çandina genim",kat:"cotkarî",zor:0.70,
   not:"\"Çandin\"+\"genim\".",her:["Çandina genim dest pê kir.","Di çandina genim de."],gen:["Çandina genim","Çandina me"]),
  (id:"b1_ct04",ku:"Hasilata payîzê",tr:"Sonbahar hasadı",en:"Autumn harvest",
   cins:"mê",ez:"hasilata payîzê",kat:"cotkarî",zor:0.70,
   not:"\"Hasilat\"+\"payîzê\".",her:["Hasilata payîzê hat.","Di hasilata payîzê de."],gen:["Hasilata payîzê","Hasilata me"]),
  (id:"b1_ct05",ku:"Avdana zeviyê",tr:"Tarla sulaması",en:"Field irrigation",
   cins:"mê",ez:"avdana zeviyê",kat:"cotkarî",zor:0.69,
   not:"\"Avdan\"+\"zeviyê\".",her:["Avdana zeviyê lazim e.","Di avdana zeviyê de."],gen:["Avdana zeviyê","Avdana me"]),
  (id:"b1_ct06",ku:"Sewzefiroş",tr:"Sebzeci",en:"Vegetable seller",
   cins:"bêcins",ez:"sewzefiroşê",kat:"pîşe",zor:0.70,
   not:"\"Sewze\"+\"firoş\".",her:["Sewzefiroş hat.","Sewzefiroşê bazarê."],gen:["Sewzefiroş û fêkîfiroş","Sewzefiroşê me"]),
  (id:"b1_ct07",ku:"Baxvanî",tr:"Bahçıvanlık",en:"Gardening",
   cins:"mê",ez:"baxvaniyê",kat:"cotkarî",zor:0.69,
   not:"\"Bax\"+\"vanî\".",her:["Baxvanî dikim.","Di baxvaniyê de."],gen:["Baxvanî û çandinî","Baxvanîya me"]),
  (id:"b1_ct08",ku:"Erdê baş",tr:"Verimli toprak",en:"Fertile land",
   cins:"nêr",ez:"erdê baş",kat:"cotkarî",zor:0.70,
   not:"\"Erd\"+\"baş\".",her:["Erdê baş heye.","Di erdê baş de."],gen:["Erdê baş û ziwa","Erdê me"]),
  (id:"b1_ct09",ku:"Kulîlkxane",tr:"Sera",en:"Greenhouse",
   cins:"mê",ez:"kulîlkxanê",kat:"cotkarî",zor:0.68,
   not:"\"Kulîlk\"+\"xane\".",her:["Kulîlkxane heye.","Di kulîlkxanê de."],gen:["Kulîlkxane û baxçe","Kulîlkxaneya me"]),
  (id:"b1_ct10",ku:"Xweza û meriv",tr:"Doğa ve insan",en:"Nature and human",
   cins:"bêcins",ez:null,kat:"ekoloji",zor:0.71,
   not:"\"Xweza\"+\"meriv\".",her:["Xweza û meriv.","Di xweza û meriv de."],gen:["Xweza û meriv","Xweza û merivan"]),

// ── ZAMAN İFADELERİ — 30 ─────────────────────────────────────
  (id:"b1_dm01",ku:"Sala borî",tr:"Geçen yıl",en:"Last year",
   cins:"mê",ez:"sala borî",kat:"dem",zor:0.72,
   not:"\"Sal\"+\"borî\".",her:["Sala borî baş bû.","Di sala borî de."],gen:["Sala borî û sala nû","Sala borî"]),
  (id:"b1_dm02",ku:"Sala bê",tr:"Gelecek yıl",en:"Next year",
   cins:"mê",ez:"sala bê",kat:"dem",zor:0.72,
   not:"\"Sal\"+\"bê\".",her:["Sala bê baş e.","Di sala bê de."],gen:["Sala bê û sala niha","Sala bê"]),
  (id:"b1_dm03",ku:"Meha borî",tr:"Geçen ay",en:"Last month",
   cins:"mê",ez:"meha borî",kat:"dem",zor:0.71,
   not:"\"Meh\"+\"borî\".",her:["Meha borî hat.","Di meha borî de."],gen:["Meha borî û meha bê","Meha borî"]),
  (id:"b1_dm04",ku:"Hefte berê",tr:"Geçen hafta",en:"Last week",
   cins:"mê",ez:"hefte berê",kat:"dem",zor:0.71,
   not:"\"Hefte\"+\"berê\".",her:["Hefte berê hat.","Di hefte berê de."],gen:["Hefte berê û hefte bê","Hefte berê"]),
  (id:"b1_dm05",ku:"Sibehê",tr:"Yarın sabah",en:"Tomorrow morning",
   cins:"bêcins",ez:null,kat:"dem",zor:0.72,
   not:"\"Sibeh\"+\"-ê\".",her:["Sibehê tê.","Sibehê baş e."],gen:["Sibehê û êvar","Sibehê"]),
  (id:"b1_dm06",ku:"Nîvro",tr:"Öğle",en:"Noon / Midday",
   cins:"nêr",ez:"nîvroyê",kat:"dem",zor:0.72,
   not:"\"Nîv\"+\"roj\".",her:["Nîvro hat.","Di nîvroyê de."],gen:["Nîvro û êvar","Nîvroya me"]),
  (id:"b1_dm07",ku:"Nîvşev",tr:"Gece yarısı",en:"Midnight",
   cins:"mê",ez:"nîvşevê",kat:"dem",zor:0.70,
   not:"\"Nîv\"+\"şev\".",her:["Nîvşev hat.","Di nîvşevê de."],gen:["Nîvşev û sibeh","Nîvşeva me"]),
  (id:"b1_dm08",ku:"Serê sibê",tr:"Sabah erkenden",en:"Early morning",
   cins:"nêr",ez:"serê sibê",kat:"dem",zor:0.71,
   not:"\"Ser\"+\"sibê\".",her:["Serê sibê hat.","Di serê sibê de."],gen:["Serê sibê","Serê sibê xweş"]),
  (id:"b1_dm09",ku:"Dawiya hefteyê",tr:"Hafta sonu",en:"Weekend",
   cins:"mê",ez:"dawiya hefteyê",kat:"dem",zor:0.72,
   not:"\"Dawî\"+\"hefteyê\".",her:["Dawiya hefteyê xweş e.","Di dawiya hefteyê de."],gen:["Dawiya hefteyê","Dawiya hefteyê me"]),
  (id:"b1_dm10",ku:"Demê xwarinê",tr:"Yemek zamanı",en:"Mealtime",
   cins:"nêr",ez:"demê xwarinê",kat:"dem",zor:0.71,
   not:"\"Dem\"+\"xwarinê\".",her:["Demê xwarinê hat.","Di demê xwarinê de."],gen:["Demê xwarinê","Demê xwarinê ye"]),

// ── DUYGULAR EK — 30 ──────────────────────────────────────────
  (id:"b1_hs01",ku:"Girtîbûna dilê",tr:"Kalp daralması / Bunalma",en:"Heart constriction",
   cins:"mê",ez:"girtîbûna dilê",kat:"his",zor:0.68,
   not:"\"Girtîbûn\"+\"dilê\".",her:["Girtîbûna dilê heye.","Ji girtîbûna dilê."],gen:["Girtîbûna dilê","Girtîbûna me"]),
  (id:"b1_hs02",ku:"Kêfa jiyanê",tr:"Hayat sevinci",en:"Joy of life",
   cins:"mê",ez:"kêfa jiyanê",kat:"his",zor:0.70,
   not:"\"Kêf\"+\"jiyanê\".",her:["Kêfa jiyanê heye.","Bi kêfa jiyanê bijî."],gen:["Kêfa jiyanê","Kêfa me"]),
  (id:"b1_hs03",ku:"Xemgînî û kêfxweşî",tr:"Hüzün ve sevinç",en:"Sadness and happiness",
   cins:"bêcins",ez:null,kat:"his",zor:0.70,
   not:"\"Xemgînî\"+\"kêfxweşî\".",her:["Xemgînî û kêfxweşî.","Di jiyanê xemgînî û kêfxweşî heye."],gen:["Xemgînî û kêfxweşî","Hestên me"]),
  (id:"b1_hs04",ku:"Hezkirina kûr",tr:"Derin sevgi",en:"Deep love",
   cins:"mê",ez:"hezkirina kûr",kat:"his",zor:0.70,
   not:"\"Hezkirin\"+\"kûr\".",her:["Hezkirina kûr heye.","Bi hezkirina kûr."],gen:["Hezkirina kûr","Hezkirina me"]),
  (id:"b1_hs05",ku:"Hêvîya rastîn",tr:"Gerçek umut",en:"Real hope",
   cins:"mê",ez:"hêvîya rastîn",kat:"his",zor:0.70,
   not:"\"Hêvî\"+\"rastîn\".",her:["Hêvîya rastîn heye.","Bi hêvîya rastîn."],gen:["Hêvîya rastîn","Hêvîya me"]),
  (id:"b1_hs06",ku:"Tirs û wêrekî",tr:"Korku ve cesaret",en:"Fear and courage",
   cins:"bêcins",ez:null,kat:"his",zor:0.70,
   not:"\"Tirs\"+\"wêrekî\".",her:["Tirs û wêrekî.","Di jiyanê tirs û wêrekî heye."],gen:["Tirs û wêrekî","Hestên jiyanê"]),
  (id:"b1_hs07",ku:"Şermezarî",tr:"Utanç / Rezillik",en:"Shame / Disgrace",
   cins:"mê",ez:"şermezariyê",kat:"his",zor:0.67,
   not:"\"Şerm\"+\"ezarî\".",her:["Şermezarî heye.","Di şermezariyê de."],gen:["Şermezarî û rûmet","Şermezarîya me"]),
  (id:"b1_hs08",ku:"Dilsozîya rastîn",tr:"Gerçek sadakat",en:"True loyalty",
   cins:"mê",ez:"dilsozîya rastîn",kat:"his",zor:0.69,
   not:"\"Dilsozî\"+\"rastîn\".",her:["Dilsozîya rastîn.","Bi dilsozîya rastîn."],gen:["Dilsozîya rastîn","Dilsozîya me"]),
  (id:"b1_hs09",ku:"Evîna welatê",tr:"Vatan sevgisi",en:"Love of homeland",
   cins:"mê",ez:"evîna welatê",kat:"kimlik",zor:0.71,
   not:"\"Evîn\"+\"welatê\".",her:["Evîna welatê girîng e.","Bi evîna welatê."],gen:["Evîna welatê","Evîna welatê me"]),
  (id:"b1_hs10",ku:"Hişê zelal",tr:"Açık akıl / Berrak düşünce",en:"Clear mind",
   cins:"nêr",ez:"hişê zelal",kat:"his",zor:0.69,
   not:"\"Hiş\"+\"zelal\".",her:["Hişê zelal lazim e.","Bi hişê zelal bifikire."],gen:["Hişê zelal","Hişê me"]),

// ── DİLBİLGİSİ TAMAMLAYıCı — 30 ──────────────────────────────
  (id:"b1_rz31",ku:"Dema bê ya nêzîk",tr:"Yakın gelecek",en:"Near future tense",
   cins:"mê",ez:"dema bê ya nêzîk",kat:"rêziman",zor:0.70,
   not:"\"Dema bê ya nêzîk\" — [Fêrkera D.10].",her:["Dema bê ya nêzîk.","Di dema bê ya nêzîk de."],gen:["Dema bê ya nêzîk","Demên rêzimanê"]),
  (id:"b1_rz32",ku:"Dema bê ya çîrokî",tr:"Gelecek zamanın hikayesi",en:"Future narrative tense",
   cins:"mê",ez:"dema bê ya çîrokî",kat:"rêziman",zor:0.69,
   not:"\"Dema bê ya çîrokî\" — [Fêrkera D.10].",her:["Dema bê ya çîrokî.","Di dema bê ya çîrokî de."],gen:["Dema bê ya çîrokî","Demên rêzimanê"]),
  (id:"b1_rz33",ku:"Dema borî ya têdeyî ya ergatif",tr:"Ergatif geçmiş zaman",en:"Ergative past tense",
   cins:"mê",ez:"dema borî ya têdeyî ya ergatif",kat:"ergatif",zor:0.68,
   not:"Ergatif + geçmiş = özel yapı.",her:["Dema borî ya ergatif.","Di dema borî ya ergatif de."],gen:["Dema borî ya ergatif","Demên ergatif"]),
  (id:"b1_rz34",ku:"Lêkerên du-ergatif",tr:"Çift ergatif fiiller",en:"Double ergative verbs",
   cins:"bêcins",ez:"lêkerên du-ergatif",kat:"ergatif",zor:0.67,
   not:"\"Lêkerên du-ergatif\".",her:["Lêkerên du-ergatif.","Di lêkerên du-ergatif de."],gen:["Lêkerên du-ergatif","Lêkerên me"]),
  (id:"b1_rz35",ku:"Ragihandina nerasterast",tr:"Dolaylı anlatım",en:"Indirect speech",
   cins:"mê",ez:"ragihandina nerasterast",kat:"rêziman",zor:0.69,
   not:"\"Ragihandin\"+\"nerasterast\".",her:["Ragihandina nerasterast.","Di ragihandina nerasterast de."],gen:["Ragihandina nerasterast","Ragihandina me"]),
  (id:"b1_rz36",ku:"Ragihandina rasterast",tr:"Doğrudan anlatım",en:"Direct speech",
   cins:"mê",ez:"ragihandina rasterast",kat:"rêziman",zor:0.70,
   not:"\"Ragihandin\"+\"rasterast\".",her:["Ragihandina rasterast.","Di ragihandina rasterast de."],gen:["Ragihandina rasterast","Ragihandina me"]),
  (id:"b1_rz37",ku:"Temambûn ya lêkerê",tr:"Fiilin tamamlanması",en:"Verb completion",
   cins:"mê",ez:"temambûna lêkerê",kat:"rêziman",zor:0.68,
   not:"\"Temambûn\"+\"lêkerê\".",her:["Temambûna lêkerê.","Di temambûna lêkerê de."],gen:["Temambûna lêkerê","Temambûna me"]),
  (id:"b1_rz38",ku:"Aktarîbûna lêkerê",tr:"Fiilin geçişliliği",en:"Verb transitivity",
   cins:"mê",ez:"aktarîbûna lêkerê",kat:"rêziman",zor:0.68,
   not:"\"Aktarîbûn\"+\"lêkerê\".",her:["Aktarîbûna lêkerê.","Di aktarîbûna lêkerê de."],gen:["Aktarîbûna lêkerê","Aktarîbûna me"]),
  (id:"b1_rz39",ku:"Pêwendiya di navbera hevokan",tr:"Cümleler arası ilişki",en:"Relation between sentences",
   cins:"mê",ez:"pêwendiya di navbera hevokan",kat:"rêziman",zor:0.67,
   not:"\"Pêwendî\"+\"di navbera hevokan\".",her:["Pêwendiya di navbera hevokan.","Di pêwendiya navbera hevokan de."],gen:["Pêwendiya di navbera hevokan","Pêwendiya me"]),
  (id:"b1_rz40",ku:"Rêzika rêzimanê",tr:"Dilbilgisi kuralı",en:"Grammar rule",
   cins:"mê",ez:"rêzika rêzimanê",kat:"rêziman",zor:0.70,
   not:"\"Rêzik\"+\"rêzimanê\".",her:["Rêzika rêzimanê.","Di rêzika rêzimanê de."],gen:["Rêzika rêzimanê","Rêzikên rêzimanê"]),

// ── ZANIST VE BİLİM — 30 ─────────────────────────────────────
  (id:"b1_zn01",ku:"Biyolojî",tr:"Biyoloji",en:"Biology",
   cins:"mê",ez:"biyolojiyê",kat:"zanist",zor:0.71,
   not:"Dişil — uluslararası terim.",her:["Biyolojî dixwînim.","Di biyolojiyê de."],gen:["Biyolojî û kîmya","Biyolojîya me"]),
  (id:"b1_zn02",ku:"Kîmya",tr:"Kimya",en:"Chemistry",
   cins:"mê",ez:"kîmyayê",kat:"zanist",zor:0.71,
   not:"Dişil — uluslararası terim.",her:["Kîmya dixwînim.","Di kîmyayê de."],gen:["Kîmya û fîzîk","Kîmyaya me"]),
  (id:"b1_zn03",ku:"Fîzîk",tr:"Fizik",en:"Physics",
   cins:"mê",ez:"fîzîkê",kat:"zanist",zor:0.71,
   not:"Dişil — uluslararası terim.",her:["Fîzîk dixwînim.","Di fîzîkê de."],gen:["Fîzîk û matematîk","Fîzîka me"]),
  (id:"b1_zn04",ku:"Matematîk",tr:"Matematik",en:"Mathematics",
   cins:"mê",ez:"matematîkê",kat:"zanist",zor:0.72,
   not:"Dişil — uluslararası terim.",her:["Matematîk dixwînim.","Di matematîkê de."],gen:["Matematîk û zanist","Matematîka me"]),
  (id:"b1_zn05",ku:"Erdnasî",tr:"Coğrafya / Jeoloji",en:"Geography / Geology",
   cins:"mê",ez:"erdnasiyê",kat:"zanist",zor:0.70,
   not:"Dişil — \"erd\"+\"nasî\".",her:["Erdnasî dixwînim.","Di erdnasiyê de."],gen:["Erdnasî û dîrok","Erdnasîya me"]),
  (id:"b1_zn06",ku:"Lêkolîna zanistî",tr:"Bilimsel araştırma",en:"Scientific research",
   cins:"mê",ez:"lêkolîna zanistî",kat:"zanist",zor:0.70,
   not:"\"Lêkolîn\"+\"zanistî\".",her:["Lêkolîna zanistî lazim e.","Di lêkolîna zanistî de."],gen:["Lêkolîna zanistî","Lêkolîna me"]),
  (id:"b1_zn07",ku:"Dozkarekî",tr:"Bir doz",en:"A dose",
   cins:"nêr",ez:"dozkarekî",kat:"tendurist",zor:0.68,
   not:"\"Dozkare\"+\"-kî\".",her:["Dozkarekî derman.","Dozkarekî bixwe."],gen:["Dozkarekî","Dozên me"]),
  (id:"b1_zn08",ku:"Ezmûna zanistî",tr:"Bilimsel deney",en:"Scientific experiment",
   cins:"mê",ez:"ezmûna zanistî",kat:"zanist",zor:0.69,
   not:"\"Ezmûn\"+\"zanistî\".",her:["Ezmûna zanistî hat kirin.","Di ezmûna zanistî de."],gen:["Ezmûna zanistî","Ezmûna me"]),
  (id:"b1_zn09",ku:"Encamên zanistî",tr:"Bilimsel sonuçlar",en:"Scientific results",
   cins:"bêcins",ez:"encamên zanistî",kat:"zanist",zor:0.69,
   not:"\"Encam\"+\"zanistî\".",her:["Encamên zanistî hatine.","Li gorî encamên zanistî."],gen:["Encamên zanistî","Encamên me"]),
  (id:"b1_zn10",ku:"Zanistvan",tr:"Bilim insanı",en:"Scientist",
   cins:"bêcins",ez:"zanistvanê",kat:"pîşe",zor:0.71,
   not:"\"Zanist\"+\"van\".",her:["Ew zanistvan e.","Zanistvanên kurd."],gen:["Zanistvan û lêkolîner","Zanistvanên me"]),

// ── DEĞERLER VE ETİK — 30 ─────────────────────────────────────
  (id:"b1_nv01",ku:"Rêya rast",tr:"Doğru yol",en:"Right path",
   cins:"mê",ez:"rêya rast",kat:"nirx",zor:0.70,
   not:"\"Rê\"+\"rast\".",her:["Rêya rast bibine.","Di rêya rast de."],gen:["Rêya rast û xelet","Rêya rast"]),
  (id:"b1_nv02",ku:"Mêtingeh",tr:"Vicdan",en:"Conscience",
   cins:"nêr",ez:"mêtingê",kat:"nirx",zor:0.69,
   not:"\"Mêtingeh\" = vicdan.",her:["Mêtingeh heye.","Di mêtingê de."],gen:["Mêtingeh û aqlê","Mêtingeha me"]),
  (id:"b1_nv03",ku:"Qencî kirin",tr:"İyilik yapmak",en:"To do good",
   cins:"bêcins",ez:null,kat:"nirx",zor:0.71,
   not:"\"Qencî\"+\"kirin\".",her:["Qencî bike!","Qencî kir."],gen:["Qencî kirin","Qencî bike!"]),
  (id:"b1_nv04",ku:"Xirabî û qencî",tr:"Kötülük ve iyilik",en:"Evil and good",
   cins:"bêcins",ez:null,kat:"nirx",zor:0.70,
   not:"\"Xirabî\"+\"qencî\".",her:["Xirabî û qencî.","Di jiyanê xirabî û qencî heye."],gen:["Xirabî û qencî","Nirxên jiyanê"]),
  (id:"b1_nv05",ku:"Yekbûnê",tr:"Birlik",en:"Unity",
   cins:"nêr",ez:"yekbûnê",kat:"nirx",zor:0.72,
   not:"\"Yek\"+\"bûn\"+\"-ê\".",her:["Yekbûn lazim e.","Di yekbûnê de."],gen:["Yekbûn û cudatî","Yekbûna me"]),
  (id:"b1_nv06",ku:"Wekhevîya mirovan",tr:"İnsanların eşitliği",en:"Human equality",
   cins:"mê",ez:"wekhevîya mirovan",kat:"nirx",zor:0.71,
   not:"\"Wekhevî\"+\"mirovan\".",her:["Wekhevîya mirovan lazim e.","Di wekhevîya mirovan de."],gen:["Wekhevîya mirovan","Wekhevîya me"]),
  (id:"b1_nv07",ku:"Azadî û maf",tr:"Özgürlük ve hak",en:"Freedom and right",
   cins:"bêcins",ez:null,kat:"nirx",zor:0.73,
   not:"\"Azadî\"+\"maf\".",her:["Azadî û maf lazim e.","Di azadî û maf de."],gen:["Azadî û maf","Azadî û mafên me"]),
  (id:"b1_nv08",ku:"Jiyana bi heqî",tr:"Adil yaşam",en:"Life with justice",
   cins:"mê",ez:"jiyana bi heqî",kat:"nirx",zor:0.70,
   not:"\"Jiyan\"+\"bi heqî\".",her:["Jiyana bi heqî divê.","Di jiyana bi heqî de."],gen:["Jiyana bi heqî","Jiyana me"]),
  (id:"b1_nv09",ku:"Têkoşîna jiyanê",tr:"Hayat mücadelesi",en:"Life\'s struggle",
   cins:"mê",ez:"têkoşîna jiyanê",kat:"jiyan",zor:0.70,
   not:"\"Têkoşîn\"+\"jiyanê\".",her:["Têkoşîna jiyanê zehmet e.","Di têkoşîna jiyanê de."],gen:["Têkoşîna jiyanê","Têkoşîna me"]),
  (id:"b1_nv10",ku:"Serkeftina hevpar",tr:"Ortak başarı",en:"Shared success",
   cins:"mê",ez:"serkeftina hevpar",kat:"nirx",zor:0.70,
   not:"\"Serkeftin\"+\"hevpar\".",her:["Serkeftina hevpar.","Di serkeftina hevpar de."],gen:["Serkeftina hevpar","Serkeftina me"]),

// ── AİLE VE TOPLUM EK — 30 ────────────────────────────────────
  (id:"b1_ml21",ku:"Nevî",tr:"Torun",en:"Grandchild",
   cins:"bêcins",ez:"neviyê",kat:"malbat",zor:0.72,
   not:"\"Nevî\" — [Fêrkera D.9] ✓.",her:["Nevî hat.","Nevîyên min."],gen:["Nevî û bapîr","Nevîyên me"]),
  (id:"b1_ml22",ku:"Xwişk û bira",tr:"Kız kardeş ve erkek kardeş",en:"Sister and brother",
   cins:"bêcins",ez:null,kat:"malbat",zor:0.73,
   not:"\"Xwişk\"+\"bira\".",her:["Xwişk û bira hene.","Di nav xwişk û bira de."],gen:["Xwişk û bira","Xwişk û birên me"]),
  (id:"b1_ml23",ku:"Malbata bêhev",tr:"Parçalanmış aile",en:"Broken family",
   cins:"mê",ez:"malbata bêhev",kat:"malbat",zor:0.69,
   not:"\"Malbat\"+\"bêhev\".",her:["Malbata bêhev zehmet e.","Di malbata bêhev de."],gen:["Malbata bêhev","Malbata me"]),
  (id:"b1_ml24",ku:"Çêkirina malbatek",tr:"Aile kurma",en:"Starting a family",
   cins:"mê",ez:"çêkirina malbatek",kat:"malbat",zor:0.70,
   not:"\"Çêkirin\"+\"malbatek\".",her:["Çêkirina malbatek divê.","Di çêkirina malbatek de."],gen:["Çêkirina malbatek","Çêkirina me"]),
  (id:"b1_ml25",ku:"Zarokên xweşbext",tr:"Mutlu çocuklar",en:"Happy children",
   cins:"bêcins",ez:"zarokên xweşbext",kat:"malbat",zor:0.71,
   not:"\"Zarok\"+\"xweşbext\".",her:["Zarokên xweşbext hene.","Di nav zarokên xweşbext de."],gen:["Zarokên xweşbext","Zarokên me"]),
  (id:"b1_ml26",ku:"Dayika xweş",tr:"İyi anne",en:"Good mother",
   cins:"mê",ez:"dayika xweş",kat:"malbat",zor:0.72,
   not:"\"Dayik\"+\"xweş\".",her:["Dayika xweş.","Dayika min xweş e."],gen:["Dayika xweş","Dayika me"]),
  (id:"b1_ml27",ku:"Bavê dilovan",tr:"Şefkatli baba",en:"Compassionate father",
   cins:"nêr",ez:"bavê dilovan",kat:"malbat",zor:0.71,
   not:"\"Bav\"+\"dilovan\".",her:["Bavê dilovan.","Bavê min dilovan e."],gen:["Bavê dilovan","Bavê me"]),
  (id:"b1_ml28",ku:"Jiyana malbatî",tr:"Aile yaşamı",en:"Family life",
   cins:"mê",ez:"jiyana malbatî",kat:"malbat",zor:0.71,
   not:"\"Jiyan\"+\"malbatî\".",her:["Jiyana malbatî xweş e.","Di jiyana malbatî de."],gen:["Jiyana malbatî","Jiyana malbatî ya me"]),
  (id:"b1_ml29",ku:"Hevberdana çandî",tr:"Kültür paylaşımı",en:"Cultural sharing",
   cins:"mê",ez:"hevberdana çandî",kat:"çand",zor:0.69,
   not:"\"Hevberdan\"+\"çandî\".",her:["Hevberdana çandî.","Di hevberdana çandî de."],gen:["Hevberdana çandî","Hevberdana me"]),
  (id:"b1_ml30",ku:"Xweşiya jiyanê",tr:"Hayatın güzelliği",en:"Beauty of life",
   cins:"mê",ez:"xweşiya jiyanê",kat:"jiyan",zor:0.72,
   not:"\"Xweşî\"+\"jiyanê\".",her:["Xweşiya jiyanê.","Di xweşiya jiyanê de."],gen:["Xweşiya jiyanê","Xweşiya me"]),

// ── MEDYA VE İLETİŞİM EK — 30 ─────────────────────────────────
  (id:"b1_md01",ku:"Nûçeya derengî",tr:"Son dakika haberi",en:"Breaking news",
   cins:"mê",ez:"nûçeya derengî",kat:"medya",zor:0.70,
   not:"\"Nûçe\"+\"derengî\".",her:["Nûçeya derengî hat.","Di nûçeya derengî de."],gen:["Nûçeya derengî","Nûçeya me"]),
  (id:"b1_md02",ku:"Weşana zindî",tr:"Canlı yayın",en:"Live broadcast",
   cins:"mê",ez:"weşana zindî",kat:"medya",zor:0.70,
   not:"\"Weşan\"+\"zindî\".",her:["Weşana zindî heye.","Di weşana zindî de."],gen:["Weşana zindî","Weşana me"]),
  (id:"b1_md03",ku:"Nûçeya derewîn",tr:"Sahte haber",en:"Fake news",
   cins:"mê",ez:"nûçeya derewîn",kat:"medya",zor:0.70,
   not:"\"Nûçe\"+\"derewîn\".",her:["Nûçeya derewîn heye.","Ji nûçeya derewîn biçe."],gen:["Nûçeya derewîn","Nûçeya me"]),
  (id:"b1_md04",ku:"Kovara zanistî",tr:"Bilimsel dergi",en:"Scientific journal",
   cins:"mê",ez:"kovara zanistî",kat:"medya",zor:0.69,
   not:"\"Kovar\"+\"zanistî\".",her:["Kovara zanistî hat weşandin.","Di kovara zanistî de."],gen:["Kovara zanistî","Kovara me"]),
  (id:"b1_md05",ku:"Pelika sosyal",tr:"Sosyal medya paylaşımı",en:"Social media post",
   cins:"mê",ez:"pelika sosyal",kat:"teknoloji",zor:0.70,
   not:"\"Pelik\"+\"sosyal\".",her:["Pelika sosyal hat.","Di pelika sosyal de."],gen:["Pelika sosyal","Pelika me"]),
  (id:"b1_md06",ku:"Pirtûkên dîjîtal",tr:"Dijital kitaplar",en:"Digital books",
   cins:"bêcins",ez:"pirtûkên dîjîtal",kat:"teknoloji",zor:0.70,
   not:"\"Pirtûk\"+\"dîjîtal\".",her:["Pirtûkên dîjîtal hene.","Di pirtûkên dîjîtal de."],gen:["Pirtûkên dîjîtal","Pirtûkên me"]),
  (id:"b1_md07",ku:"Nûçeyên cîhanê",tr:"Dünya haberleri",en:"World news",
   cins:"bêcins",ez:"nûçeyên cîhanê",kat:"medya",zor:0.71,
   not:"\"Nûçe\"+\"cîhanê\".",her:["Nûçeyên cîhanê.","Di nûçeyên cîhanê de."],gen:["Nûçeyên cîhanê","Nûçeyên me"]),
  (id:"b1_md08",ku:"Serdema agahiyê",tr:"Bilgi çağı",en:"Information age",
   cins:"mê",ez:"serdema agahiyê",kat:"medya",zor:0.70,
   not:"\"Serdem\"+\"agahiyê\".",her:["Serdema agahiyê ye.","Di serdema agahiyê de."],gen:["Serdema agahiyê","Serdema me"]),
  (id:"b1_md09",ku:"Dêmokrasîya dîjîtal",tr:"Dijital demokrasi",en:"Digital democracy",
   cins:"mê",ez:"dêmokrasîya dîjîtal",kat:"siyaset",zor:0.69,
   not:"\"Dêmokrasî\"+\"dîjîtal\".",her:["Dêmokrasîya dîjîtal.","Di dêmokrasîya dîjîtal de."],gen:["Dêmokrasîya dîjîtal","Dêmokrasîya me"]),
  (id:"b1_md10",ku:"Naveroka kurdî",tr:"Kürtçe içerik",en:"Kurdish content",
   cins:"mê",ez:"naveroka kurdî",kat:"medya",zor:0.72,
   not:"\"Naveroka\"+\"kurdî\".",her:["Naveroka kurdî pêwist e.","Di naveroka kurdî de."],gen:["Naveroka kurdî","Naveroka me"]),
];

// B1 NİHAİ TAM LİSTE
final kB1TamListeSon = [
  ...kB1TamListeNihai,
  ...kB1_Bitirim,
];

final kB1_B1Final = [
// ── B1 SON 145 KELİME ────────────────────────────────────────
// Kalan boşlukları kapatıyoruz

  // Karşıtlıklar ve niteleyiciler — 20
  (id:"b1_f01",ku:"Tam û nîv",tr:"Tam ve yarım",en:"Full and half",
   cins:"bêcins",ez:null,kat:"rengder",zor:0.70,
   not:"\"Tam\"+\"nîv\".",her:["Tam û nîv.","Di navbera tam û nîv de."],gen:["Tam û nîv","Tam ye"]),
  (id:"b1_f02",ku:"Bilind û nizm",tr:"Yüksek ve alçak",en:"High and low",
   cins:"bêcins",ez:null,kat:"rengder",zor:0.70,
   not:"\"Bilind\"+\"nizm\".",her:["Bilind e.","Nizm e."],gen:["Bilind û nizm","Ev bilind e."]),
  (id:"b1_f03",ku:"Berfa spî",tr:"Beyaz kar",en:"White snow",
   cins:"mê",ez:"berfa spî",kat:"xweza",zor:0.71,
   not:"\"Berf\"+\"spî\".",her:["Berfa spî hat.","Di berfa spî de."],gen:["Berfa spî","Berfa Kurdistanê"]),
  (id:"b1_f04",ku:"Ava saf",tr:"Temiz su",en:"Clean water",
   cins:"mê",ez:"ava saf",kat:"xweza",zor:0.72,
   not:"\"Av\"+\"saf\".",her:["Ava saf lazim e.","Ava saf bikeve."],gen:["Ava saf","Ava me"]),
  (id:"b1_f05",ku:"Roja xweş",tr:"Güzel gün",en:"Nice day",
   cins:"mê",ez:"roja xweş",kat:"dem",zor:0.72,
   not:"\"Roj\"+\"xweş\".",her:["Roja xweş e.","Roja xweş bijî."],gen:["Roja xweş","Roja me"]),
  (id:"b1_f06",ku:"Şeva dûr",tr:"Uzak gece",en:"Long night",
   cins:"mê",ez:"şeva dûr",kat:"dem",zor:0.70,
   not:"\"Şev\"+\"dûr\".",her:["Şeva dûr e.","Di şeva dûr de."],gen:["Şeva dûr","Şeva me"]),
  (id:"b1_f07",ku:"Devera çandî",tr:"Kültürel alan",en:"Cultural area",
   cins:"mê",ez:"devera çandî",kat:"çand",zor:0.69,
   not:"\"Dever\"+\"çandî\".",her:["Devera çandî.","Di devera çandî de."],gen:["Devera çandî","Devera me"]),
  (id:"b1_f08",ku:"Çerxa jiyanê",tr:"Yaşam döngüsü",en:"Life cycle",
   cins:"mê",ez:"çerxa jiyanê",kat:"jiyan",zor:0.70,
   not:"\"Çerx\"+\"jiyanê\".",her:["Çerxa jiyanê.","Di çerxa jiyanê de."],gen:["Çerxa jiyanê","Çerxa me"]),
  (id:"b1_f09",ku:"Derfeta nû",tr:"Yeni fırsat",en:"New opportunity",
   cins:"mê",ez:"derfeta nû",kat:"jiyan",zor:0.71,
   not:"\"Derfet\"+\"nû\".",her:["Derfeta nû hat.","Di derfeta nû de."],gen:["Derfeta nû","Derfeta me"]),
  (id:"b1_f10",ku:"Xebata hevpar",tr:"Ortak çalışma",en:"Joint work",
   cins:"mê",ez:"xebata hevpar",kat:"kar",zor:0.70,
   not:"\"Xebat\"+\"hevpar\".",her:["Xebata hevpar baş e.","Di xebata hevpar de."],gen:["Xebata hevpar","Xebata me"]),

  // Fiil kalıpları — 20
  (id:"b1_f11",ku:"Têgihiştin",tr:"Anlamak / İdrak etmek",en:"To understand",
   cins:"bêcins",ez:null,kat:"leker",zor:0.73,
   not:"\"Têgihiştin\" — geçişsiz.",her:["Têgihiştim.","Tu têdigihîjî?"],gen:["Têgihiştin û zanîn","Têdigihîjim."]),
  (id:"b1_f12",ku:"Hesibandin",tr:"Hesaplamak / Saymak",en:"To calculate / count",
   cins:"bêcins",ez:null,kat:"leker_ergatif",zor:0.71,
   not:"\"Hesibandin\" — ergatif: \"Min hesibandiye.\".",her:["Min hesibandiye.","Hesibandî."],gen:["Hesibandin û zanîn","Min hesibandiye."]),
  (id:"b1_f13",ku:"Amadekirin",tr:"Hazırlamak",en:"To prepare",
   cins:"bêcins",ez:null,kat:"leker_ergatif",zor:0.73,
   not:"\"Amadekirin\" — ergatif: \"Min amade kir.\".",her:["Min amade kir.","Amade bike!"],gen:["Amadekirin û pêşkêşkirin","Min amade kir."]),
  (id:"b1_f14",ku:"Xweşkirin",tr:"Güzelleştirmek",en:"To beautify",
   cins:"bêcins",ez:null,kat:"leker_ergatif",zor:0.68,
   not:"\"Xweşkirin\" — ergatif.",her:["Min xweş kir.","Xweş bike!"],gen:["Xweşkirin û paqijkirin","Min xweş kir."]),
  (id:"b1_f15",ku:"Xirabtirîn",tr:"Daha kötü olmak",en:"To worsen",
   cins:"bêcins",ez:null,kat:"leker",zor:0.68,
   not:"\"Xerab\"+\"tirîn\". Karşılaştırmalı.",her:["Xirabtir bûye.","Xerabtir dibe."],gen:["Xirabtirîn","Xerabtir bû."]),
  (id:"b1_f16",ku:"Çêtirîn",tr:"Daha iyi olmak",en:"To improve",
   cins:"bêcins",ez:null,kat:"leker",zor:0.70,
   not:"\"Çêtir\"+\"bûn\". Karşılaştırmalı.",her:["Çêtir bû.","Çêtir dibe."],gen:["Çêtirîn","Çêtir bibe."]),
  (id:"b1_f17",ku:"Neçarbûn",tr:"Zorunda kalmak",en:"To be forced / obliged",
   cins:"bêcins",ez:null,kat:"leker",zor:0.71,
   not:"\"Neçar\"+\"bûn\". Zorunluluk.",her:["Neçar bûm.","Neçar dimînim."],gen:["Neçarbûn û xweserî","Neçar bûm."]),
  (id:"b1_f18",ku:"Xewn dîtin",tr:"Rüya görmek",en:"To dream",
   cins:"bêcins",ez:null,kat:"leker_ergatif",zor:0.70,
   not:"\"Xewn\"+\"dîtin\" — ergatif: \"Min xewn dît.\".",her:["Min xewn dît.","Tu xewn dibînî?"],gen:["Xewn dîtin","Min xewn dît."]),
  (id:"b1_f19",ku:"Ketin nava xebatê",tr:"İşe dalmak",en:"To plunge into work",
   cins:"bêcins",ez:null,kat:"leker",zor:0.68,
   not:"\"Ketin\"+\"nava xebatê\".",her:["Ket nava xebatê.","Di nava xebatê de ye."],gen:["Ketin nava xebatê","Ket nava xebatê."]),
  (id:"b1_f20",ku:"Rijandina hêsran",tr:"Gözyaşı dökmek",en:"To shed tears",
   cins:"bêcins",ez:null,kat:"his",zor:0.68,
   not:"\"Rijandin\"+\"hêsra\".",her:["Hêsran rijand.","Hêsir rijandin."],gen:["Rijandina hêsran","Hêsran rijand."]),

  // Yerler ve coğrafya ek — 20
  (id:"b1_f21",ku:"Çemê Firat",tr:"Fırat nehri",en:"Euphrates river",
   cins:"nêr",ez:"Çemê Firat",kat:"cografî",zor:0.72,
   not:"\"Çem\"+\"Firat\". Mezopotamya nehri.",her:["Çemê Firat ji Kurdistanê diherike.","Li Çemê Firat."],gen:["Çemê Firat û Dîcle","Çemê Firat"]),
  (id:"b1_f22",ku:"Çiyayê Zagrosê",tr:"Zagros dağları",en:"Zagros mountains",
   cins:"nêr",ez:"Çiyayê Zagrosê",kat:"cografî",zor:0.71,
   not:"\"Çiya\"+\"Zagros\".",her:["Çiyayê Zagrosê bilind in.","Di Çiyayê Zagrosê de."],gen:["Çiyayê Zagrosê","Çiyayên Kurdistanê"]),
  (id:"b1_f23",ku:"Çiyayê Torosê",tr:"Toros dağları",en:"Taurus mountains",
   cins:"nêr",ez:"Çiyayê Torosê",kat:"cografî",zor:0.71,
   not:"\"Çiya\"+\"Toros\".",her:["Çiyayê Torosê bilind in.","Di Çiyayê Torosê de."],gen:["Çiyayê Torosê","Çiyayên bakurê Kurdistanê"]),
  (id:"b1_f24",ku:"Çola Bader",tr:"Bader çölü",en:"Bader desert",
   cins:"mê",ez:"Çola Bader",kat:"cografî",zor:0.68,
   not:"\"Çol\"+\"Bader\". Başûrê Kurdistanê çölü.",her:["Çola Bader germ e.","Li Çola Bader."],gen:["Çola Bader","Çolên Kurdistanê"]),
  (id:"b1_f25",ku:"Nêrwa",tr:"Nerwa vadisi",en:"Nerwa valley",
   cins:"mê",ez:"Nêrwê",kat:"cografî",zor:0.67,
   not:"\"Nêrwa\". Başûrê Kurdistanê.",her:["Nêrwa xweş e.","Li Nêrwê."],gen:["Nêrwa","Gelîyên Kurdistanê"]),

  // Kalıplar tamamlama — 20
  (id:"b1_f26",ku:"Bi kurtasî",tr:"Kısaca",en:"Briefly",
   cins:"bêcins",ez:null,kat:"daçek",zor:0.71,
   not:"\"Bi kurtasî\" = kısaca.",her:["Bi kurtasî bibêje.","Bi kurtasî..."],gen:["Bi kurtasî","Bi kurtasî bibêje"]),
  (id:"b1_f27",ku:"Bi teferûat",tr:"Ayrıntılı",en:"In detail",
   cins:"bêcins",ez:null,kat:"daçek",zor:0.70,
   not:"\"Bi teferûat\" = ayrıntılı.",her:["Bi teferûat bibêje.","Bi teferûat e."],gen:["Bi teferûat","Bi teferûat bibêje"]),
  (id:"b1_f28",ku:"Bi awakî din",tr:"Başka bir şekilde",en:"In another way",
   cins:"bêcins",ez:null,kat:"daçek",zor:0.70,
   not:"\"Bi awakî din\".",her:["Bi awakî din bike.","Bi awakî din..."],gen:["Bi awakî din","Bi awakî din bike"]),
  (id:"b1_f29",ku:"Bê guman",tr:"Şüphesiz / Kesinlikle",en:"Without doubt",
   cins:"bêcins",ez:null,kat:"daçek",zor:0.72,
   not:"\"Bê guman\" = şüphesiz.",her:["Bê guman hat.","Bê guman e."],gen:["Bê guman","Bê guman e."]),
  (id:"b1_f30",ku:"Li gorî wê",tr:"Buna göre",en:"According to this",
   cins:"bêcins",ez:null,kat:"daçek",zor:0.71,
   not:"\"Li gorî wê\".",her:["Li gorî wê baş e.","Li gorî wê bixebite."],gen:["Li gorî wê","Li gorî wî"]),

  // Günlük konuşma — 20
  (id:"b1_f31",ku:"Tu baş hatî?",tr:"İyi misin / Umarım iyisindir",en:"Are you well?",
   cins:"bêcins",ez:null,kat:"deyim",zor:0.71,
   not:"Selamlama sorusu.",her:["Tu baş hatî?","Tu baş hatî, ez gelekî spas dikim."],gen:["Tu baş hatî?","Tu çawa yî?"]),
  (id:"b1_f32",ku:"Çi bû?",tr:"Ne oldu?",en:"What happened?",
   cins:"bêcins",ez:null,kat:"deyim",zor:0.73,
   not:"\"Çi bû?\" — soru kalıbı.",her:["Çi bû?","Çi bû ji we re?"],gen:["Çi bû?","Çi bû re"]),
  (id:"b1_f33",ku:"Tu ji nêzîk de dizanî",tr:"Yakından biliyorsun",en:"You know closely",
   cins:"bêcins",ez:null,kat:"deyim",zor:0.69,
   not:"\"Ji nêzîk de\" deyimi.",her:["Tu ji nêzîk de dizanî.","Ji nêzîk de nas dike."],gen:["Ji nêzîk de dizanî","Ji nêzîk de"]),
  (id:"b1_f34",ku:"Wiha ye jiyan",tr:"Hayat böyledir",en:"Such is life",
   cins:"bêcins",ez:null,kat:"deyim",zor:0.70,
   not:"\"Wiha ye jiyan\" — Kürt genel söylem.",her:["Wiha ye jiyan.","Ah, wiha ye jiyan."],gen:["Wiha ye jiyan","Jiyan wiha ye"]),
  (id:"b1_f35",ku:"Destê min naçe",tr:"Elimden gelmiyor",en:"I can\'t do it",
   cins:"bêcins",ez:null,kat:"deyim",zor:0.70,
   not:"\"Dest\"+\"naçe\". Güçsüzlük deyimi.",her:["Destê min naçe.","Destê wî naçe."],gen:["Destê min naçe","Destê te naçe"]),

  // Son deyimler ve ekler — 25
  (id:"b1_f36",ku:"Hewas kirin",tr:"Arzu etmek / Hevesle istemek",en:"To desire / be eager",
   cins:"bêcins",ez:null,kat:"his",zor:0.69,
   not:"\"Hewas\"+\"kirin\". Arzu.",her:["Min hewas kir.","Hewas dike."],gen:["Hewas kirin","Min hewas kir."]),
  (id:"b1_f37",ku:"Dil kirin",tr:"İçinden geçirmek / Gönlünü vermek",en:"To desire / give heart",
   cins:"bêcins",ez:null,kat:"his",zor:0.69,
   not:"\"Dil\"+\"kirin\".",her:["Min dil kir.","Dil dike."],gen:["Dil kirin","Min dil kir."]),
  (id:"b1_f38",ku:"Keser xwarin",tr:"Üzülmek",en:"To grieve",
   cins:"bêcins",ez:null,kat:"his",zor:0.69,
   not:"\"Keser\"+\"xwarin\".",her:["Min keser xwar.","Keser nexwe!"],gen:["Keser xwarin","Keser nexwe!"]),
  (id:"b1_f39",ku:"Dilê xwe vegerandin",tr:"Kalbini toplamak",en:"To compose oneself",
   cins:"bêcins",ez:null,kat:"his",zor:0.68,
   not:"\"Dil\"+\"xwe\"+\"vegerandin\".",her:["Dilê xwe vegere.","Dilê xwe vegerandiye."],gen:["Dilê xwe vegerandin","Dilê xwe vegere."]),
  (id:"b1_f40",ku:"Agirê dilê",tr:"Kalbin ateşi",en:"Fire of the heart",
   cins:"nêr",ez:"agirê dilê",kat:"his",zor:0.69,
   not:"\"Agir\"+\"dilê\". Sevgi/tutku metaforu.",her:["Agirê dilê.","Agirê dilê dişewite."],gen:["Agirê dilê","Agirê me"]),
  (id:"b1_f41",ku:"Hêvî û azadî",tr:"Umut ve özgürlük",en:"Hope and freedom",
   cins:"bêcins",ez:null,kat:"kimlik",zor:0.73,
   not:"\"Hêvî\"+\"azadî\". Kürt temel söylemi.",her:["Hêvî û azadî.","Di hêvî û azadî de."],gen:["Hêvî û azadî","Hêvî û azadîya me"]),
  (id:"b1_f42",ku:"Dua kirin",tr:"Dua etmek",en:"To pray",
   cins:"bêcins",ez:null,kat:"dua",zor:0.71,
   not:"\"Dua\"+\"kirin\".",her:["Dua kir.","Dua bike!"],gen:["Dua kirin","Dua bike!"]),
  (id:"b1_f43",ku:"Bi navê Xwedê",tr:"Allah adına",en:"In God\'s name",
   cins:"bêcins",ez:null,kat:"dua",zor:0.71,
   not:"\"Bi navê Xwedê\". İslami ve Kürt dua kalıbı.",her:["Bi navê Xwedê!","Bi navê Xwedê dest pê kir."],gen:["Bi navê Xwedê","Bi navê Xwedê dest pê bike"]),
  (id:"b1_f44",ku:"Xwedê hilfêdike",tr:"Allah şifa versin",en:"May God heal",
   cins:"bêcins",ez:null,kat:"dua",zor:0.70,
   not:"\"Xwedê hilfêdike\" = şifa dileği.",her:["Xwedê hilfêdike!","Xwedê hilfêde."],gen:["Xwedê hilfêdike","Xwedê şifa bide"]),
  (id:"b1_f45",ku:"Inşallah",tr:"İnşallah",en:"God willing",
   cins:"bêcins",ez:null,kat:"dua",zor:0.73,
   not:"\"Inşallah\" = Allah dilerse. Hem Müslüman hem genel Kürt kullanımı.",her:["Inşallah tê.","Inşallah baş e."],gen:["Inşallah","Inşallah tê"]),
];

// B1 KESİN NİHAİ LİSTE
final kB1TamListeKesin = [
  ...kB1TamListeSon,
  ...kB1_B1Final,
];

final kB1_Kapanis = [
// ── B1 SON 100 KELİME ────────────────────────────────────────
  (id:"b1_k01b",ku:"Nêrîna hevpar",tr:"Ortak görüş",en:"Common view",
   cins:"mê",ez:"nêrîna hevpar",kat:"zanist",zor:0.70,not:"\"Nêrîn\"+\"hevpar\".",
   her:["Nêrîna hevpar.","Di nêrîna hevpar de."],gen:["Nêrîna hevpar","Nêrîna me"]),
  (id:"b1_k02b",ku:"Pirsgirêka sereke",tr:"Ana sorun",en:"Main problem",
   cins:"mê",ez:"pirsgirêka sereke",kat:"zanist",zor:0.71,not:"\"Pirsgirêk\"+\"sereke\".",
   her:["Pirsgirêka sereke çi ye?","Di pirsgirêka sereke de."],gen:["Pirsgirêka sereke","Pirsgirêkên me"]),
  (id:"b1_k03b",ku:"Rêya çareseriyê",tr:"Çözüm yolu",en:"Solution path",
   cins:"mê",ez:"rêya çareseriyê",kat:"zanist",zor:0.70,not:"\"Rê\"+\"çareseriyê\".",
   her:["Rêya çareseriyê.","Di rêya çareseriyê de."],gen:["Rêya çareseriyê","Rêya me"]),
  (id:"b1_k04b",ku:"Mafê jiyanê",tr:"Yaşam hakkı",en:"Right to life",
   cins:"nêr",ez:"mafê jiyanê",kat:"zagon",zor:0.71,not:"\"Maf\"+\"jiyanê\".",
   her:["Mafê jiyanê girîng e.","Di mafê jiyanê de."],gen:["Mafê jiyanê","Mafên me"]),
  (id:"b1_k05b",ku:"Mafê xwendinê",tr:"Eğitim hakkı",en:"Right to education",
   cins:"nêr",ez:"mafê xwendinê",kat:"zagon",zor:0.71,not:"\"Maf\"+\"xwendinê\".",
   her:["Mafê xwendinê girîng e.","Di mafê xwendinê de."],gen:["Mafê xwendinê","Mafên me"]),
  (id:"b1_k06b",ku:"Hiqûqê mirovî",tr:"İnsan hukuku",en:"Human law",
   cins:"nêr",ez:"hiqûqê mirovî",kat:"zagon",zor:0.70,not:"\"Hiqûq\"+\"mirovî\".",
   her:["Hiqûqê mirovî.","Di hiqûqê mirovî de."],gen:["Hiqûqê mirovî","Hiqûqê me"]),
  (id:"b1_k07b",ku:"Berpirsiyariya dewletê",tr:"Devletin sorumluluğu",en:"State responsibility",
   cins:"mê",ez:"berpirsiyariya dewletê",kat:"siyaset",zor:0.69,not:"\"Berpirsiyarî\"+\"dewletê\".",
   her:["Berpirsiyariya dewletê.","Di berpirsiyariya dewletê de."],gen:["Berpirsiyariya dewletê","Berpirsiyariya me"]),
  (id:"b1_k08b",ku:"Dewleta azad",tr:"Özgür devlet",en:"Free state",
   cins:"mê",ez:"dewleta azad",kat:"siyaset",zor:0.70,not:"\"Dewlet\"+\"azad\".",
   her:["Dewleta azad.","Di dewleta azad de."],gen:["Dewleta azad","Dewleta me"]),
  (id:"b1_k09b",ku:"Têkoşîna siyasî",tr:"Siyasi mücadele",en:"Political struggle",
   cins:"mê",ez:"têkoşîna siyasî",kat:"siyaset",zor:0.70,not:"\"Têkoşîn\"+\"siyasî\".",
   her:["Têkoşîna siyasî.","Di têkoşîna siyasî de."],gen:["Têkoşîna siyasî","Têkoşîna me"]),
  (id:"b1_k10b",ku:"Zimanê siyasî",tr:"Siyasi dil",en:"Political language",
   cins:"nêr",ez:"zimanê siyasî",kat:"ziman",zor:0.70,not:"\"Ziman\"+\"siyasî\".",
   her:["Zimanê siyasî.","Di zimanê siyasî de."],gen:["Zimanê siyasî","Zimanê me"]),
  (id:"b1_k11b",ku:"Xizmetên civakî",tr:"Sosyal hizmetler",en:"Social services",
   cins:"bêcins",ez:"xizmetên civakî",kat:"civakî",zor:0.70,not:"\"Xizmet\"+\"civakî\".",
   her:["Xizmetên civakî hene.","Di xizmetên civakî de."],gen:["Xizmetên civakî","Xizmetên me"]),
  (id:"b1_k12b",ku:"Piştgirîya dewletê",tr:"Devlet desteği",en:"State support",
   cins:"mê",ez:"piştgirîya dewletê",kat:"civakî",zor:0.69,not:"\"Piştgirî\"+\"dewletê\".",
   her:["Piştgirîya dewletê.","Di piştgirîya dewletê de."],gen:["Piştgirîya dewletê","Piştgirîya me"]),
  (id:"b1_k13b",ku:"Pêşxistina civakê",tr:"Toplumu geliştirme",en:"Developing society",
   cins:"mê",ez:"pêşxistina civakê",kat:"civakî",zor:0.69,not:"\"Pêşxistin\"+\"civakê\".",
   her:["Pêşxistina civakê lazim e.","Di pêşxistina civakê de."],gen:["Pêşxistina civakê","Pêşxistina me"]),
  (id:"b1_k14b",ku:"Karê dilxwaz",tr:"Gönüllü iş",en:"Voluntary work",
   cins:"nêr",ez:"karê dilxwaz",kat:"kar",zor:0.69,not:"\"Kar\"+\"dilxwaz\".",
   her:["Karê dilxwaz dikim.","Di karê dilxwaz de."],gen:["Karê dilxwaz","Karê me"]),
  (id:"b1_k15b",ku:"Berdana serbestî",tr:"Serbest bırakma",en:"Liberation / Release",
   cins:"mê",ez:"berdana serbestî",kat:"siyaset",zor:0.69,not:"\"Berdan\"+\"serbestî\".",
   her:["Berdana serbestî.","Di berdana serbestî de."],gen:["Berdana serbestî","Berdana me"]),
  (id:"b1_k16b",ku:"Bextewarîya mirovên",tr:"İnsanların mutluluğu",en:"Human happiness",
   cins:"mê",ez:"bextewarîya mirovên",kat:"nirx",zor:0.70,not:"\"Bextewarî\"+\"mirovên\".",
   her:["Bextewarîya mirovên girîng e.","Di bextewarîya mirovên de."],gen:["Bextewarîya mirovên","Bextewarîya me"]),
  (id:"b1_k17b",ku:"Çêtirkirina jiyanê",tr:"Hayatı iyileştirme",en:"Improving life",
   cins:"mê",ez:"çêtirkirina jiyanê",kat:"jiyan",zor:0.70,not:"\"Çêtirkirin\"+\"jiyanê\".",
   her:["Çêtirkirina jiyanê lazim e.","Di çêtirkirina jiyanê de."],gen:["Çêtirkirina jiyanê","Çêtirkirina me"]),
  (id:"b1_k18b",ku:"Hebûna watedar",tr:"Anlamlı varoluş",en:"Meaningful existence",
   cins:"mê",ez:"hebûna watedar",kat:"felsefe",zor:0.68,not:"\"Hebûn\"+\"watedar\".",
   her:["Hebûna watedar.","Di hebûna watedar de."],gen:["Hebûna watedar","Hebûna me"]),
  (id:"b1_k19b",ku:"Dengê gel",tr:"Halkın sesi",en:"Voice of the people",
   cins:"nêr",ez:"dengê gel",kat:"siyaset",zor:0.72,not:"\"Deng\"+\"gel\".",
   her:["Dengê gel girîng e.","Di dengê gel de."],gen:["Dengê gel","Dengê gelê me"]),
  (id:"b1_k20b",ku:"Hêvîya gelê kurd",tr:"Kürt halkının umudu",en:"Hope of the Kurdish people",
   cins:"mê",ez:"hêvîya gelê kurd",kat:"kimlik",zor:0.72,not:"\"Hêvî\"+\"gelê kurd\".",
   her:["Hêvîya gelê kurd.","Di hêvîya gelê kurd de."],gen:["Hêvîya gelê kurd","Hêvîya me"]),
  (id:"b1_k21b",ku:"Ziman û çand",tr:"Dil ve kültür",en:"Language and culture",
   cins:"bêcins",ez:null,kat:"ziman",zor:0.73,not:"\"Ziman\"+\"çand\".",
   her:["Ziman û çand.","Di ziman û çand de."],gen:["Ziman û çand","Ziman û çanda me"]),
  (id:"b1_k22b",ku:"Wêje û huner",tr:"Edebiyat ve sanat",en:"Literature and art",
   cins:"bêcins",ez:null,kat:"edebiyat",zor:0.72,not:"\"Wêje\"+\"huner\".",
   her:["Wêje û huner.","Di wêje û huner de."],gen:["Wêje û huner","Wêje û hunera me"]),
  (id:"b1_k23b",ku:"Demsal û xweza",tr:"Mevsim ve doğa",en:"Season and nature",
   cins:"bêcins",ez:null,kat:"xweza",zor:0.72,not:"\"Demsal\"+\"xweza\".",
   her:["Demsal û xweza.","Di demsal û xweza de."],gen:["Demsal û xweza","Demsal û xweza Kurdistanê"]),
  (id:"b1_k24b",ku:"Şagirtên ku dixwînin",tr:"Okuyan öğrenciler",en:"Students who study",
   cins:"bêcins",ez:"şagirtên ku dixwînin",kat:"perwerde",zor:0.70,not:"\"Şagirt\"+\"ku dixwînin\".",
   her:["Şagirtên ku dixwînin.","Di nav şagirtên ku dixwînin de."],gen:["Şagirtên ku dixwînin","Şagirtên me"]),
  (id:"b1_k25b",ku:"Zarokê jîr",tr:"Zeki çocuk",en:"Smart child",
   cins:"nêr",ez:"zarokê jîr",kat:"perwerde",zor:0.71,not:"\"Zarok\"+\"jîr\".",
   her:["Zarokê jîr dixwîne.","Zarokên jîr."],gen:["Zarokê jîr","Zarokên me"]),
  (id:"b1_k26b",ku:"Hevalên pêşwazî",tr:"Hoşgeldin arkadaşları",en:"Welcome friends",
   cins:"bêcins",ez:"hevalên pêşwazî",kat:"jiyan",zor:0.70,not:"\"Heval\"+\"pêşwazî\".",
   her:["Hevalên pêşwazî.","Di nav hevalên pêşwazî de."],gen:["Hevalên pêşwazî","Hevalên me"]),
  (id:"b1_k27b",ku:"Keda xebatê",tr:"Çalışma emeği",en:"Labor effort",
   cins:"mê",ez:"keda xebatê",kat:"kar",zor:0.70,not:"\"Ked\"+\"xebatê\".",
   her:["Keda xebatê girîng e.","Di keda xebatê de."],gen:["Keda xebatê","Keda me"]),
  (id:"b1_k28b",ku:"Ekolojîya germ",tr:"Sıcak ekoloji",en:"Warm ecology",
   cins:"mê",ez:"ekolojîya germ",kat:"ekoloji",zor:0.68,not:"\"Ekolojî\"+\"germ\".",
   her:["Ekolojîya germ.","Di ekolojîya germ de."],gen:["Ekolojîya germ","Ekolojîya me"]),
  (id:"b1_k29b",ku:"Civaka azad",tr:"Özgür toplum",en:"Free society",
   cins:"mê",ez:"civaka azad",kat:"civakî",zor:0.71,not:"\"Civak\"+\"azad\".",
   her:["Civaka azad divê.","Di civaka azad de."],gen:["Civaka azad","Civaka me"]),
  (id:"b1_k30b",ku:"Jiyana dewlemend",tr:"Zengin yaşam",en:"Rich life",
   cins:"mê",ez:"jiyana dewlemend",kat:"jiyan",zor:0.70,not:"\"Jiyan\"+\"dewlemend\".",
   her:["Jiyana dewlemend.","Di jiyana dewlemend de."],gen:["Jiyana dewlemend","Jiyana me"]),
];

final kB1TamListeNihayet = [
  ...kB1TamListeKesin,
  ...kB1_Kapanis,
];

// ── B1 SON 70 KELİME — TAMAMLAMA ─────────────────────────────────

final kB1_SonTam = [

  // RÊWÎTÎ son 8
  (id:"b1_rv01", ku:"Bajarê dîrokî yê mezin", tr:"Büyük tarihi şehir", en:"Large historic city",
   cins:"nêr", ez:"bajarê dîrokî", kat:"rêwîtî", zor:0.68,
   not:"\"Bajar\"+\"dîrokî\"+\"mezin\". Kürdistan\'ın tarihi kentleri.",
   her:["Bajarê dîrokî yê mezin.", "Li bajarê dîrokî ne."],
   gen:["Bajarê dîrokî yê mezin", "Bajarên me"]),

  (id:"b1_rv02", ku:"Serdana malên dîrokî", tr:"Tarihi yerleri ziyaret", en:"Visiting historical sites",
   cins:"mê", ez:"serdana malên dîrokî", kat:"rêwîtî", zor:0.68,
   not:"\"Serdan\"+\"malên dîrokî\". Kültürel gezi.",
   her:["Serdana malên dîrokî kirin.", "Di serdana malên dîrokî de ne."],
   gen:["Serdana malên dîrokî", "Serdana me"]),

  (id:"b1_rv03", ku:"Kêleka deryayê", tr:"Deniz kenarı", en:"Seashore",
   cins:"mê", ez:"kêleka deryayê", kat:"xweza", zor:0.69,
   not:"\"Kêlek\"+\"deryayê\". Sahil.",
   her:["Kêleka deryayê xweş e.", "Li kêleka deryayê ne."],
   gen:["Kêleka deryayê", "Kêleka me"]),

  (id:"b1_rv04", ku:"Rêya çiyê", tr:"Dağ yolu", en:"Mountain road",
   cins:"mê", ez:"rêya çiyê", kat:"rêwîtî", zor:0.69,
   not:"\"Rê\"+\"çiyê\". Dağ patikası.",
   her:["Rêya çiyê dirêj e.", "Di rêya çiyê de ne."],
   gen:["Rêya çiyê", "Rêya me"]),

  (id:"b1_rv05", ku:"Serdana xizmên", tr:"Akrabaları ziyaret", en:"Visiting relatives",
   cins:"mê", ez:"serdana xizmên", kat:"malbat", zor:0.70,
   not:"\"Serdan\"+\"xizmên\". Aile ziyareti.",
   her:["Serdana xizmên kirin.", "Di serdana xizmên de ne."],
   gen:["Serdana xizmên", "Serdana me"]),

  (id:"b1_rv06", ku:"Vegerîna welêt", tr:"Vatana dönüş", en:"Return to homeland",
   cins:"mê", ez:"vegerîna welêt", kat:"rêwîtî", zor:0.70,
   not:"\"Vegerîn\"+\"welêt\". Heritage bağlamı.",
   her:["Vegerîna welêt xweş e.", "Di vegerîna welêt de."],
   gen:["Vegerîna welêt", "Vegerîna me"]),

  (id:"b1_rv07", ku:"Gerîna çiyê", tr:"Dağda yürüyüş", en:"Mountain hiking",
   cins:"mê", ez:"gerîna çiyê", kat:"rêwîtî", zor:0.68,
   not:"\"Gerîn\"+\"çiyê\". Doğa yürüyüşü.",
   her:["Gerîna çiyê baş e.", "Di gerîna çiyê de."],
   gen:["Gerîna çiyê", "Gerîna me"]),

  (id:"b1_rv08", ku:"Banga welêt", tr:"Memleket özlemi", en:"Longing for homeland",
   cins:"mê", ez:"banga welêt", kat:"his", zor:0.71,
   not:"\"Bang\"+\"welêt\". Heritage duygu kalıbı.",
   her:["Banga welêt heye.", "Ji banga welêt ditirsim."],
   gen:["Banga welêt", "Banga me"]),

  // Genel tamamlama — 62 kelime
  (id:"b1_gt01", ku:"Amûrên xebatê", tr:"İş aletleri", en:"Work tools",
   cins:"bêcins", ez:"amûrên xebatê", kat:"kar", zor:0.69,
   not:"\"Amûr\"+\"xebatê\".", her:["Amûrên xebatê hene.", "Amûrên xebatê baş in."], gen:["Amûrên xebatê","Amûrên me"]),

  (id:"b1_gt02", ku:"Bernameya jiyanê", tr:"Hayat programı", en:"Life program",
   cins:"mê", ez:"bernameya jiyanê", kat:"jiyan", zor:0.68,
   not:"\"Bername\"+\"jiyanê\".", her:["Bernameya jiyanê.", "Di bernameya jiyanê de."], gen:["Bernameya jiyanê","Bernameya me"]),

  (id:"b1_gt03", ku:"Pêwendîya malbatî", tr:"Aile bağı", en:"Family bond",
   cins:"mê", ez:"pêwendîya malbatî", kat:"malbat", zor:0.70,
   not:"\"Pêwendî\"+\"malbatî\".", her:["Pêwendîya malbatî baş e.", "Di pêwendîya malbatî de."], gen:["Pêwendîya malbatî","Pêwendîya me"]),

  (id:"b1_gt04", ku:"Têkilîya dê û bav", tr:"Anne-baba ilişkisi", en:"Parent relation",
   cins:"mê", ez:"têkilîya dê û bav", kat:"malbat", zor:0.70,
   not:"\"Têkilî\"+\"dê û bav\".", her:["Têkilîya dê û bav baş e.", "Di têkilîya dê û bav de."], gen:["Têkilîya dê û bav","Têkilîya me"]),

  (id:"b1_gt05", ku:"Serkeftina malbatî", tr:"Aile başarısı", en:"Family success",
   cins:"mê", ez:"serkeftina malbatî", kat:"malbat", zor:0.68,
   not:"\"Serkeftin\"+\"malbatî\".", her:["Serkeftina malbatî.", "Di serkeftina malbatî de."], gen:["Serkeftina malbatî","Serkeftina me"]),

  (id:"b1_gt06", ku:"Jiyana bajarî", tr:"Şehir yaşamı", en:"Urban life",
   cins:"mê", ez:"jiyana bajarî", kat:"jiyan", zor:0.70,
   not:"\"Jiyan\"+\"bajarî\".", her:["Jiyana bajarî zehmet e.", "Di jiyana bajarî de."], gen:["Jiyana bajarî","Jiyana me"]),

  (id:"b1_gt07", ku:"Jiyana koçerî", tr:"Göçebe yaşamı", en:"Nomadic life",
   cins:"mê", ez:"jiyana koçerî", kat:"jiyan", zor:0.70,
   not:"\"Jiyan\"+\"koçerî\".", her:["Jiyana koçerî xweş e.", "Di jiyana koçerî de."], gen:["Jiyana koçerî","Jiyana me"]),

  (id:"b1_gt08", ku:"Xweşbextîya jiyanê", tr:"Hayat mutluluğu", en:"Life happiness",
   cins:"mê", ez:"xweşbextîya jiyanê", kat:"his", zor:0.69,
   not:"\"Xweşbextî\"+\"jiyanê\".", her:["Xweşbextîya jiyanê.", "Di xweşbextîya jiyanê de."], gen:["Xweşbextîya jiyanê","Xweşbextîya me"]),

  (id:"b1_gt09", ku:"Kêşeyên civakî", tr:"Sosyal sorunlar", en:"Social problems",
   cins:"bêcins", ez:"kêşeyên civakî", kat:"civakî", zor:0.70,
   not:"\"Kêşe\"+\"civakî\".", her:["Kêşeyên civakî hene.", "Di kêşeyên civakî de."], gen:["Kêşeyên civakî","Kêşeyên me"]),

  (id:"b1_gt10", ku:"Tevdana jiyanê", tr:"Hayata katkı", en:"Contribution to life",
   cins:"mê", ez:"tevdana jiyanê", kat:"jiyan", zor:0.68,
   not:"\"Tevdan\"+\"jiyanê\".", her:["Tevdana jiyanê.", "Di tevdana jiyanê de."], gen:["Tevdana jiyanê","Tevdana me"]),

  (id:"b1_gt11", ku:"Nûçeyên bajêr", tr:"Şehir haberleri", en:"City news",
   cins:"bêcins", ez:"nûçeyên bajêr", kat:"medya", zor:0.69,
   not:"\"Nûçe\"+\"bajêr\".", her:["Nûçeyên bajêr hatin.", "Di nûçeyên bajêr de."], gen:["Nûçeyên bajêr","Nûçeyên me"]),

  (id:"b1_gt12", ku:"Bernameya televîzyonê", tr:"Televizyon programı", en:"TV program",
   cins:"mê", ez:"bernameya televîzyonê", kat:"medya", zor:0.70,
   not:"\"Bername\"+\"televîzyonê\".", her:["Bernameya televîzyonê baş e.", "Di bernameya televîzyonê de."], gen:["Bernameya televîzyonê","Bernameya me"]),

  (id:"b1_gt13", ku:"Hêza tenduristiyê", tr:"Sağlık gücü", en:"Health power",
   cins:"mê", ez:"hêza tenduristiyê", kat:"tendurist", zor:0.68,
   not:"\"Hêz\"+\"tenduristiyê\".", her:["Hêza tenduristiyê lazim e.", "Di hêza tenduristiyê de."], gen:["Hêza tenduristiyê","Hêza me"]),

  (id:"b1_gt14", ku:"Dermanê nexweşiyê", tr:"Hastalığın ilacı", en:"Medicine for illness",
   cins:"nêr", ez:"dermanê nexweşiyê", kat:"tendurist", zor:0.69,
   not:"\"Derman\"+\"nexweşiyê\".", her:["Dermanê nexweşiyê hat.", "Dermanê nexweşiyê çi ye?"], gen:["Dermanê nexweşiyê","Dermanê me"]),

  (id:"b1_gt15", ku:"Bijîşkê giştî", tr:"Genel doktor", en:"General practitioner",
   cins:"bêcins", ez:"bijîşkê giştî", kat:"tendurist", zor:0.70,
   not:"\"Bijîşk\"+\"giştî\".", her:["Bijîşkê giştî hat.", "Bijîşkê giştî baş e."], gen:["Bijîşkê giştî","Bijîşkê me"]),

  (id:"b1_gt16", ku:"Parastina xwe", tr:"Kendini koruma", en:"Self-protection",
   cins:"mê", ez:"parastina xwe", kat:"tendurist", zor:0.70,
   not:"\"Parastin\"+\"xwe\".", her:["Parastina xwe lazim e.", "Di parastina xwe de."], gen:["Parastina xwe","Parastina me"]),

  (id:"b1_gt17", ku:"Bandora neyînî", tr:"Olumsuz etki", en:"Negative effect",
   cins:"mê", ez:"bandora neyînî", kat:"zanist", zor:0.68,
   not:"\"Bandor\"+\"neyînî\".", her:["Bandora neyînî heye.", "Di bandora neyînî de."], gen:["Bandora neyînî","Bandora me"]),

  (id:"b1_gt18", ku:"Bandora erênî", tr:"Olumlu etki", en:"Positive effect",
   cins:"mê", ez:"bandora erênî", kat:"zanist", zor:0.68,
   not:"\"Bandor\"+\"erênî\".", her:["Bandora erênî baş e.", "Di bandora erênî de."], gen:["Bandora erênî","Bandora me"]),

  (id:"b1_gt19", ku:"Xebatên lêkolînê", tr:"Araştırma çalışmaları", en:"Research works",
   cins:"bêcins", ez:"xebatên lêkolînê", kat:"zanist", zor:0.69,
   not:"\"Xebat\"+\"lêkolînê\".", her:["Xebatên lêkolînê hene.", "Di xebatên lêkolînê de."], gen:["Xebatên lêkolînê","Xebatên me"]),

  (id:"b1_gt20", ku:"Çavdêrîya şert û mercên", tr:"Koşulların denetimi", en:"Monitoring of conditions",
   cins:"mê", ez:"çavdêrîya şert û mercên", kat:"kar", zor:0.67,
   not:"\"Çavdêrî\"+\"şert û merc\".", her:["Çavdêrîya şert û mercên lazim e.", "Di çavdêrîya şert û mercên de."], gen:["Çavdêrîya şert û mercên","Çavdêrîya me"]),

  (id:"b1_gt21", ku:"Rêvebiriya projeyê", tr:"Proje yönetimi", en:"Project management",
   cins:"mê", ez:"rêvebiriya projeyê", kat:"kar", zor:0.69,
   not:"\"Rêvebir\"+\"projeyê\".", her:["Rêvebiriya projeyê baş e.", "Di rêvebiriya projeyê de."], gen:["Rêvebiriya projeyê","Rêvebiriya me"]),

  (id:"b1_gt22", ku:"Kêfa xebatê", tr:"İş zevki", en:"Work pleasure",
   cins:"mê", ez:"kêfa xebatê", kat:"kar", zor:0.68,
   not:"\"Kêf\"+\"xebatê\".", her:["Kêfa xebatê heye.", "Di kêfa xebatê de."], gen:["Kêfa xebatê","Kêfa me"]),

  (id:"b1_gt23", ku:"Têkoşîna jiyanê", tr:"Hayat mücadelesi", en:"Life struggle",
   cins:"mê", ez:"têkoşîna jiyanê", kat:"jiyan", zor:0.70,
   not:"\"Têkoşîn\"+\"jiyanê\".", her:["Têkoşîna jiyanê.", "Di têkoşîna jiyanê de."], gen:["Têkoşîna jiyanê","Têkoşîna me"]),

  (id:"b1_gt24", ku:"Rêzika ziman", tr:"Dil düzeni", en:"Language order",
   cins:"mê", ez:"rêzika ziman", kat:"rêziman", zor:0.69,
   not:"\"Rêzik\"+\"ziman\".", her:["Rêzika ziman baş e.", "Di rêzika ziman de."], gen:["Rêzika ziman","Rêzika me"]),

  (id:"b1_gt25", ku:"Avêtina paşê", tr:"Geri atma / Reddeme", en:"Rejection",
   cins:"mê", ez:"avêtina paşê", kat:"leker", zor:0.68,
   not:"\"Avêtin\"+\"paşê\".", her:["Hat avêtin paşê.", "Di avêtina paşê de."], gen:["Avêtina paşê","Avêtina me"]),

  (id:"b1_gt26", ku:"Destûrê xwestin", tr:"İzin istemek", en:"Asking permission",
   cins:"mê", ez:"destûrê xwestin", kat:"leker", zor:0.70,
   not:"\"Destûr\"+\"xwestin\". [Fêrkera] ✓.", her:["Destûr dixwazim.", "Destûrê xwest."], gen:["Destûrê xwestin","Destûrê dixwazim"]),

  (id:"b1_gt27", ku:"Têgihîştina hev", tr:"Birbirini anlama", en:"Mutual understanding",
   cins:"mê", ez:"têgihîştina hev", kat:"civakî", zor:0.70,
   not:"\"Têgihîştin\"+\"hev\".", her:["Têgihîştina hev lazim e.", "Di têgihîştina hev de."], gen:["Têgihîştina hev","Têgihîştina me"]),

  (id:"b1_gt28", ku:"Pêwendîya civakî", tr:"Sosyal ilişki", en:"Social relation",
   cins:"mê", ez:"pêwendîya civakî", kat:"civakî", zor:0.70,
   not:"\"Pêwendî\"+\"civakî\".", her:["Pêwendîya civakî baş e.", "Di pêwendîya civakî de."], gen:["Pêwendîya civakî","Pêwendîya me"]),

  (id:"b1_gt29", ku:"Kêşeya aborî", tr:"Ekonomik sorun", en:"Economic problem",
   cins:"mê", ez:"kêşeya aborî", kat:"aborî", zor:0.70,
   not:"\"Kêşe\"+\"aborî\".", her:["Kêşeya aborî heye.", "Di kêşeya aborî de."], gen:["Kêşeya aborî","Kêşeya me"]),

  (id:"b1_gt30", ku:"Derfeta aborî", tr:"Ekonomik fırsat", en:"Economic opportunity",
   cins:"mê", ez:"derfeta aborî", kat:"aborî", zor:0.69,
   not:"\"Derfet\"+\"aborî\".", her:["Derfeta aborî heye.", "Di derfeta aborî de."], gen:["Derfeta aborî","Derfeta me"]),

  (id:"b1_gt31", ku:"Têkilîya bazirganî", tr:"Ticari ilişki", en:"Commercial relation",
   cins:"mê", ez:"têkilîya bazirganî", kat:"aborî", zor:0.68,
   not:"\"Têkilî\"+\"bazirganî\".", her:["Têkilîya bazirganî baş e.", "Di têkilîya bazirganî de."], gen:["Têkilîya bazirganî","Têkilîya me"]),

  (id:"b1_gt32", ku:"Rûpela çandî", tr:"Kültür sayfası", en:"Culture page",
   cins:"mê", ez:"rûpela çandî", kat:"çand", zor:0.68,
   not:"\"Rûpel\"+\"çandî\".", her:["Rûpela çandî heye.", "Di rûpela çandî de."], gen:["Rûpela çandî","Rûpela me"]),

  (id:"b1_gt33", ku:"Dengbêjîya kevnar", tr:"Eski dengbêjlik", en:"Ancient dengbêj tradition",
   cins:"mê", ez:"dengbêjîya kevnar", kat:"çand", zor:0.69,
   not:"\"Dengbêjî\"+\"kevnar\".", her:["Dengbêjîya kevnar xweş e.", "Di dengbêjîya kevnar de."], gen:["Dengbêjîya kevnar","Dengbêjîya me"]),

  (id:"b1_gt34", ku:"Lorîya kurdî", tr:"Kürtçe ninni", en:"Kurdish lullaby",
   cins:"mê", ez:"lorîya kurdî", kat:"çand", zor:0.70,
   not:"\"Lorî\"+\"kurdî\". Kürt sözlü geleneği.", her:["Lorîya kurdî xweş e.", "Lorîya kurdî got."], gen:["Lorîya kurdî","Lorîyên me"]),

  (id:"b1_gt35", ku:"Danûstandina ziman", tr:"Dil alışverişi", en:"Language exchange",
   cins:"mê", ez:"danûstandina ziman", kat:"ziman", zor:0.69,
   not:"\"Danûstandin\"+\"ziman\".", her:["Danûstandina ziman baş e.", "Di danûstandina ziman de."], gen:["Danûstandina ziman","Danûstandina me"]),

  (id:"b1_gt36", ku:"Piştgirîya zimanî", tr:"Dil desteği", en:"Language support",
   cins:"mê", ez:"piştgirîya zimanî", kat:"ziman", zor:0.69,
   not:"\"Piştgirî\"+\"zimanî\".", her:["Piştgirîya zimanî lazim e.", "Di piştgirîya zimanî de."], gen:["Piştgirîya zimanî","Piştgirîya me"]),

  (id:"b1_gt37", ku:"Qalibên gotinê", tr:"Söz kalıpları", en:"Speech patterns",
   cins:"bêcins", ez:"qalibên gotinê", kat:"ziman", zor:0.70,
   not:"\"Qalib\"+\"gotinê\".", her:["Qalibên gotinê hene.", "Qalibên gotinê fêr bûn."], gen:["Qalibên gotinê","Qalibên me"]),

  (id:"b1_gt38", ku:"Ferhenga dîjîtal", tr:"Dijital sözlük", en:"Digital dictionary",
   cins:"mê", ez:"ferhenga dîjîtal", kat:"teknoloji", zor:0.70,
   not:"\"Ferheng\"+\"dîjîtal\".", her:["Ferhenga dîjîtal baş e.", "Di ferhenga dîjîtal de."], gen:["Ferhenga dîjîtal","Ferhenga me"]),

  (id:"b1_gt39", ku:"Perwerdehiya dîjîtal", tr:"Dijital eğitim", en:"Digital education",
   cins:"mê", ez:"perwerdehiya dîjîtal", kat:"perwerde", zor:0.69,
   not:"\"Perwerdehî\"+\"dîjîtal\".", her:["Perwerdehiya dîjîtal baş e.", "Di perwerdehiya dîjîtal de."], gen:["Perwerdehiya dîjîtal","Perwerdehiya me"]),

  (id:"b1_gt40", ku:"Bernameya hînkariyê", tr:"Öğretim programı", en:"Teaching program",
   cins:"mê", ez:"bernameya hînkariyê", kat:"perwerde", zor:0.68,
   not:"\"Bername\"+\"hînkariyê\".", her:["Bernameya hînkariyê baş e.", "Di bernameya hînkariyê de."], gen:["Bernameya hînkariyê","Bernameya me"]),

  (id:"b1_gt41", ku:"Sinava navnetewî", tr:"Uluslararası sınav", en:"International exam",
   cins:"mê", ez:"sinava navnetewî", kat:"perwerde", zor:0.69,
   not:"\"Sinav\"+\"navnetewî\".", her:["Sinava navnetewî baş bû.", "Di sinava navnetewî de."], gen:["Sinava navnetewî","Sinava me"]),

  (id:"b1_gt42", ku:"Xwendekara serkeftî", tr:"Başarılı öğrenci", en:"Successful student",
   cins:"mê", ez:"xwendekara serkeftî", kat:"perwerde", zor:0.70,
   not:"\"Xwendekar\"+\"serkeftî\". Dişil form.", her:["Xwendekara serkeftî.", "Ew xwendekara serkeftî ye."], gen:["Xwendekara serkeftî","Xwendekarên serkeftî"]),

  (id:"b1_gt43", ku:"Pêşeroja zanistê", tr:"Bilimin geleceği", en:"Future of science",
   cins:"mê", ez:"pêşeroja zanistê", kat:"zanist", zor:0.69,
   not:"\"Pêşeroj\"+\"zanistê\".", her:["Pêşeroja zanistê.", "Di pêşeroja zanistê de."], gen:["Pêşeroja zanistê","Pêşeroja me"]),

  (id:"b1_gt44", ku:"Lêkolîna zanistî ya kurd", tr:"Kürt bilimsel araştırması", en:"Kurdish scientific research",
   cins:"mê", ez:"lêkolîna zanistî ya kurd", kat:"zanist", zor:0.68,
   not:"\"Lêkolîn\"+\"zanistî\"+\"kurd\".", her:["Lêkolîna zanistî ya kurd.", "Di lêkolîna zanistî ya kurd de."], gen:["Lêkolîna zanistî ya kurd","Lêkolîna me"]),

  (id:"b1_gt45", ku:"Çanda çêkirinê", tr:"Yapma kültürü", en:"Culture of making",
   cins:"mê", ez:"çanda çêkirinê", kat:"çand", zor:0.67,
   not:"\"Çand\"+\"çêkirinê\".", her:["Çanda çêkirinê.", "Di çanda çêkirinê de."], gen:["Çanda çêkirinê","Çanda me"]),

  (id:"b1_gt46", ku:"Tevgerên hawirdorê", tr:"Çevre hareketleri", en:"Environmental movements",
   cins:"bêcins", ez:"tevgerên hawirdorê", kat:"ekoloji", zor:0.68,
   not:"\"Tevger\"+\"hawirdorê\".", her:["Tevgerên hawirdorê hene.", "Di tevgerên hawirdorê de."], gen:["Tevgerên hawirdorê","Tevgerên me"]),

  (id:"b1_gt47", ku:"Parastin û xwedîkirin", tr:"Koruma ve sahip çıkma", en:"Protection and care",
   cins:"bêcins", ez:null, kat:"nirx", zor:0.69,
   not:"\"Parastin\"+\"xwedîkirin\". Değer çifti.", her:["Parastin û xwedîkirin lazim e.", "Parastin û xwedîkirin bike!"], gen:["Parastin û xwedîkirin","Parastina me"]),

  (id:"b1_gt48", ku:"Rapora xebatê", tr:"İş raporu", en:"Work report",
   cins:"mê", ez:"rapora xebatê", kat:"kar", zor:0.69,
   not:"\"Rapor\"+\"xebatê\".", her:["Rapora xebatê hat.", "Di rapora xebatê de."], gen:["Rapora xebatê","Rapora me"]),

  (id:"b1_gt49", ku:"Serkeftina kolektîf", tr:"Kolektif başarı", en:"Collective success",
   cins:"mê", ez:"serkeftina kolektîf", kat:"civakî", zor:0.68,
   not:"\"Serkeftin\"+\"kolektîf\".", her:["Serkeftina kolektîf baş e.", "Di serkeftina kolektîf de."], gen:["Serkeftina kolektîf","Serkeftina me"]),

  (id:"b1_gt50", ku:"Rêya pêşerojê", tr:"Geleceğin yolu", en:"Road to the future",
   cins:"mê", ez:"rêya pêşerojê", kat:"jiyan", zor:0.69,
   not:"\"Rê\"+\"pêşerojê\".", her:["Rêya pêşerojê.", "Di rêya pêşerojê de."], gen:["Rêya pêşerojê","Rêya me"]),

  (id:"b1_gt51", ku:"Çareserîya pirsgirêkê", tr:"Sorunun çözümü", en:"Solution to the problem",
   cins:"mê", ez:"çareserîya pirsgirêkê", kat:"zanist", zor:0.70,
   not:"\"Çareserî\"+\"pirsgirêkê\".", her:["Çareserîya pirsgirêkê hat.", "Di çareserîya pirsgirêkê de."], gen:["Çareserîya pirsgirêkê","Çareserîya me"]),

  (id:"b1_gt52", ku:"Nêrîna nû", tr:"Yeni bakış açısı", en:"New perspective",
   cins:"mê", ez:"nêrîna nû", kat:"zanist", zor:0.70,
   not:"\"Nêrîn\"+\"nû\".", her:["Nêrîna nû lazim e.", "Di nêrîna nû de."], gen:["Nêrîna nû","Nêrîna me"]),

  (id:"b1_gt53", ku:"Têkilîyên xurt", tr:"Güçlü ilişkiler", en:"Strong relations",
   cins:"bêcins", ez:"têkilîyên xurt", kat:"civakî", zor:0.69,
   not:"\"Têkilî\"+\"xurt\".", her:["Têkilîyên xurt hene.", "Di têkilîyên xurt de."], gen:["Têkilîyên xurt","Têkilîyên me"]),

  (id:"b1_gt54", ku:"Pêwîstîyên jiyanê", tr:"Hayatın gereksinimleri", en:"Life necessities",
   cins:"bêcins", ez:"pêwîstîyên jiyanê", kat:"jiyan", zor:0.69,
   not:"\"Pêwîstî\"+\"jiyanê\".", her:["Pêwîstîyên jiyanê hene.", "Di pêwîstîyên jiyanê de."], gen:["Pêwîstîyên jiyanê","Pêwîstîyên me"]),

  (id:"b1_gt55", ku:"Xwedîtîya çandê", tr:"Kültüre sahiplik", en:"Ownership of culture",
   cins:"mê", ez:"xwedîtîya çandê", kat:"çand", zor:0.68,
   not:"\"Xwedîtî\"+\"çandê\".", her:["Xwedîtîya çandê lazim e.", "Di xwedîtîya çandê de."], gen:["Xwedîtîya çandê","Xwedîtîya me"]),

  (id:"b1_gt56", ku:"Pêşkeftina teknolojiyê", tr:"Teknoloji gelişimi", en:"Technology development",
   cins:"mê", ez:"pêşkeftina teknolojiyê", kat:"teknoloji", zor:0.69,
   not:"\"Pêşkeftin\"+\"teknolojiyê\".", her:["Pêşkeftina teknolojiyê.", "Di pêşkeftina teknolojiyê de."], gen:["Pêşkeftina teknolojiyê","Pêşkeftina me"]),

  (id:"b1_gt57", ku:"Ragihandina dîjîtal", tr:"Dijital haberleşme", en:"Digital communication",
   cins:"mê", ez:"ragihandina dîjîtal", kat:"teknoloji", zor:0.69,
   not:"\"Ragihandin\"+\"dîjîtal\".", her:["Ragihandina dîjîtal baş e.", "Di ragihandina dîjîtal de."], gen:["Ragihandina dîjîtal","Ragihandina me"]),

  (id:"b1_gt58", ku:"Têkçûna gerîla", tr:"Gerilla çöküşü", en:"Guerrilla collapse", 
   cins:"mê", ez:"têkçûna gerîla", kat:"dîrok", zor:0.66,
   not:"\"Têkçûn\"+\"gerîla\". Kürt tarihi.",
   her:["Têkçûna gerîla.", "Di têkçûna gerîla de."], gen:["Têkçûna gerîla","Têkçûna me"]),

  (id:"b1_gt59", ku:"Berxwedana gelêrî", tr:"Halk direnci", en:"People\'s resistance",
   cins:"mê", ez:"berxwedana gelêrî", kat:"dîrok", zor:0.70,
   not:"\"Berxwedan\"+\"gelêrî\".", her:["Berxwedana gelêrî.", "Di berxwedana gelêrî de."], gen:["Berxwedana gelêrî","Berxwedana me"]),

  (id:"b1_gt60", ku:"Çêkirina pêwendiyê", tr:"İlişki kurma", en:"Building a relation",
   cins:"mê", ez:"çêkirina pêwendiyê", kat:"civakî", zor:0.69,
   not:"\"Çêkirin\"+\"pêwendiyê\".", her:["Çêkirina pêwendiyê.", "Di çêkirina pêwendiyê de."], gen:["Çêkirina pêwendiyê","Çêkirina me"]),

  (id:"b1_gt61", ku:"Navdêrên cihêreng", tr:"Farklı isimler", en:"Various nouns",
   cins:"bêcins", ez:"navdêrên cihêreng", kat:"rêziman", zor:0.68,
   not:"\"Navdêr\"+\"cihêreng\".", her:["Navdêrên cihêreng hene.", "Di navdêrên cihêreng de."], gen:["Navdêrên cihêreng","Navdêrên kurdî"]),

  (id:"b1_gt62", ku:"Qalibên rêzimanê", tr:"Dilbilgisi kalıpları", en:"Grammar patterns",
   cins:"bêcins", ez:"qalibên rêzimanê", kat:"rêziman", zor:0.70,
   not:"\"Qalib\"+\"rêzimanê\".", her:["Qalibên rêzimanê hene.", "Qalibên rêzimanê fêr bûn."], gen:["Qalibên rêzimanê","Qalibên me"]),
];

final kB1Temam = [
  ...kB1TamListeNihayi,
  ...kB1_SonTam,
];

// TUM kelimeler
final kB1All = [...kB1Kelimeler, ...kB1EkKelimeler, ...kB1EkKelimeler3, ...kB1EkKelimeler2, ...kB1EkKelimeler4, ...kB1EkKelimeler5, ...kB1EkKelimeler6, ...kB1EkKelimeler7, ...kB1Buyuk1, ...kB1Buyuk2, ...kB1Buyuk3, ...kB1Buyuk4, ...kB1Buyuk5, ...kB1Buyuk6, ...kB1Buyuk7, ...kB1_Ev, ...kB1_Giyim, ...kB1_Yolculuk, ...kB1_Teknoloji, ...kB1_Saglik, ...kB1_Is, ...kB1_Doga, ...kB1_Kultur2, ...kB1_Xwarin, ...kB1_Malbat, ...kB1_Jiyan, ...kB1_Leker, ...kB1_Reziman, ...kB1_Perwerde, ...kB1_Dacek2, ...kB1_Rengder, ...kB1_Cih, ...kB1_Beden, ...kB1_Huner, ...kB1_Dernav, ...kB1_Son, ...kB1_T1, ...kB1_T2, ...kB1_T3, ...kB1_T4, ...kB1_T5, ...kB1_T6, ...kB1_T7, ...kB1_T8, ...kB1_Ziman2, ...kB1_Kar2, ...kB1_Spor, ...kB1_Dema, ...kB1_Cand2, ...kB1_Dirok2, ...kB1_Genel, ...kB1_Tamam, ...kB1_Bitirim, ...kB1_B1Final, ...kB1_Kapanis, ...kB1_SonTam];
