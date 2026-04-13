/// LÛTKE — B2 Kelime Veritabanı (Orta-Üst / Navîn-Jor)
///
/// Hedef: 500+ kelime (bu dosya ~250)
///
/// B2 pedagoji odağı:
/// 1. Ergatif anlaşma (fiil nesneyle cinsiyet/sayı uyumu)
/// 2. Pasif yapı (-în / -bûn ile)
/// 3. Bileşik fiiller (li ber ketin, ser ketin…)
/// 4. Gazete ve resmi dil
/// 5. Soyut kavramlar (felsefe, siyaset, ekoloji)
/// 6. Kürt edebiyatı — Mem û Zîn, Cegerxwîn
/// 7. Atasözleri ve deyimler
///
/// Kaynak: [BH][TH][AS][FB][AZ][DR][BNK]
/// [BNK] = Institut Kurde Paris dijital kütüphane

// ignore_for_file: constant_identifier_names

final kB2Kelimeler = [

  // ════════════════════════════════════════════════════════════
  // B2 BİRİM 1 — ERGATİF ANLAŞMA (FİİL-NESNE UYUMU)
  // [BH] §170–185 + [TH] §75–80
  // B2'de: nesnenin cinsiyetiyle fiil uyumu (kişi eki anlaşması)
  // ════════════════════════════════════════════════════════════

  (id:"b2_001", ku:"Wî gotiye", tr:"O (eril) söylemiş (mükemmel)", en:"He has said",
   cins:"bêcins", ez:null, kat:"ergatif_b2", zor:0.60,
   not:"Ergatif + mükemmel: Wî (eğik eril) + got + -iye. [TH] §72+76. Nesne dişilse: \"Wî gotiye\" dişil nesneyle de değişmez — fiil kişiyle değil nesneyle uyum arar (B2 kritik)",
   her:["Wî gotiye ku pîrê tê.", "Wê raporê nivîsandiye."],
   gen:["Wî gotiye.", "Wê çêkiriye."]),

  (id:"b2_002", ku:"Min xwendiye", tr:"Ben okumuşum", en:"I have read (m. perfect)",
   cins:"bêcins", ez:null, kat:"ergatif_b2", zor:0.61,
   not:"\"Min\" (ergatif) + \"xwend\" + \"-iye\" = şimdiki mükemmel geçişli. [BH] §186. \"Şimdiye etki var\" çözümü",
   her:["Min ev pirtûk xwendiye.", "Min nameya te xwendiye."],
   gen:["Min xwendiye.", "Te nivîsandiye?"]),

  (id:"b2_003", ku:"Lihevhatina armancan", tr:"Nesne uyumu (fiil-nesne cinsiyet)", en:"Object agreement",
   cins:"bêcins", ez:null, kat:"ergatif_b2", zor:0.58,
   not:"[BH] §178: Bazı lehçelerde geçmiş geçişlide fiil nesnenin cinsiyetiyle uyum sağlar. \"Min pirtûk dit\" (eril nesne) vs \"Min pirtûka dit\" (dişil nesne) — Kurmancî standart Türkiye ağzında bu ayrım zayıflamış",
   her:["Min pirtûk dit. (eril).", "Min diya wî dit. (dişil)."],
   gen:["Lihevhatin: lehçeyî ye", "Standarda Kurmancî"]),

  // ════════════════════════════════════════════════════════════
  // B2 BİRİM 2 — PASİF YAPI
  // [BH] §193 + [TH] §82 + [AZ] Ders 15
  // ════════════════════════════════════════════════════════════

  (id:"b2_010", ku:"Tê gotin", tr:"Söylenir / Denilir", en:"It is said",
   cins:"bêcins", ez:null, kat:"pasif", zor:0.62,
   not:"\"Tê\" (3.tekil hatin) + mastar = pasif. [TH] §82: \"tê kirin\" = yapılıyor (pasif). \"Tê gotin ku…\" = denilir ki…",
   her:["Tê gotin ku Kurdistan xweş e.", "Di Kurmancî de wilo tê gotin."],
   gen:["Tê gotin ku…", "Tê kirin…"]),

  (id:"b2_011", ku:"Hate gotin", tr:"Söylendi / Denildi", en:"It was said",
   cins:"bêcins", ez:null, kat:"pasif", zor:0.61,
   not:"\"Hat\" (geçmiş hatin) + mastar = geçmiş pasif. [BH] §193. \"Hate kirin\" = yapıldı",
   her:["Hate gotin ku rast e.", "Hate kirin."],
   gen:["Hate gotin.", "Hate sazkirin."]),

  (id:"b2_012", ku:"Dê bête kirin", tr:"Yapılacak", en:"It will be done",
   cins:"bêcins", ez:null, kat:"pasif", zor:0.60,
   not:"\"Dê\" + \"bê\" + mastar = gelecek pasif. [TH] §82",
   her:["Rêkxistin dê bête kirin.", "Pirsgirêk dê bête çarakirin."],
   gen:["Dê bête kirin.", "Dê bête gotin."]),

  (id:"b2_013", ku:"Bête zanîn", tr:"Bilinmektedir", en:"It is known",
   cins:"bêcins", ez:null, kat:"pasif", zor:0.61,
   not:"\"Bête zanîn\" = bilinmektedir. Resmi ve gazete dilinde sık. [AZ] Ders 15",
   her:["Bête zanîn ku ev dîrok girîng e.", "Wek ku bête zanîn…."],
   gen:["Wek ku bête zanîn", "Tê zanîn ku…"]),

  // ════════════════════════════════════════════════════════════
  // B2 BİRİM 3 — BİLEŞİK FİİLLER
  // [BH] §200–210 + [FB] compound verbs
  // ════════════════════════════════════════════════════════════

  (id:"b2_020", ku:"Li ber ketin", tr:"Çalışmak / Uğraşmak", en:"To work on / strive",
   cins:"bêcins", ez:null, kat:"bileşik_leker", zor:0.65,
   not:"\"Li ber\" + \"ketin\" = -e karşı düşmek → üzerinde çalışmak. [FB]: li ber ketin v.comp. B1\'de geçmedi, B2\'de tam öğretim",
   her:["Em li ber pirsgirêkê dikevim.", "Ew li ber xwendinê dikeve."],
   gen:["Li ber ketin", "Li ber dixebite."]),

  (id:"b2_021", ku:"Ser ketin", tr:"Başarmak / Üstün gelmek", en:"To succeed / overcome",
   cins:"bêcins", ez:null, kat:"bileşik_leker", zor:0.64,
   not:"\"Ser\" + \"ketin\" = üstüne düşmek → başarmak. [FB]: ser ketin v.comp.",
   her:["Em ser ketine!", "Ew ser ket."],
   gen:["Ser ketin û şikest", "Em ser ketin."]),

  (id:"b2_022", ku:"Bi xêr ketin", tr:"Mutlu olmak / Sevinmek", en:"To be glad / rejoice",
   cins:"bêcins", ez:null, kat:"bileşik_leker", zor:0.65,
   not:"\"Bi xêr\" + \"ketin\" = hayra düşmek. [FB]: bi xêr ketin v.comp.",
   her:["Ez bi xêr diketim ku pîrê hat.", "Ew bi xêr ket."],
   gen:["Bi xêr ketin", "Bi xêr diketim."]),

  (id:"b2_023", ku:"Dest avêtin", tr:"Başlamak / Girişmek", en:"To begin / embark",
   cins:"bêcins", ez:null, kat:"bileşik_leker", zor:0.64,
   not:"\"Dest\" (el) + \"avêtin\" (atmak) = ele almak, başlamak. [BH] §200",
   her:["Em dest avêtin xwendinê.", "Ew dest avêt karê."],
   gen:["Dest avêtin û dawî kirin", "Dest avêt."]),

  (id:"b2_024", ku:"Xwe avêtin", tr:"Kendini vermek / Atlamak", en:"To throw oneself",
   cins:"bêcins", ez:null, kat:"bileşik_leker", zor:0.63,
   not:"\"Xwe\" (kendini) + \"avêtin\" (atmak). [FB]: xwe avêtin v.comp.",
   her:["Ew xwe avêt nav xwendinê.", "Xwe avêt û bi ser ket."],
   gen:["Xwe avêtin", "Xwe avêt."]),

  (id:"b2_025", ku:"Ziman girtin", tr:"Susmak / Dil tutmak", en:"To keep silent",
   cins:"bêcins", ez:null, kat:"bileşik_leker", zor:0.63,
   not:"\"Ziman girtin\" = dili tutmak. [FB]: ziman girtin v.comp. Kürt kültüründe sır tutma",
   her:["Ziman bigire!", "Ew ziman girt."],
   gen:["Ziman girtin", "Ziman bigire!"]),

  (id:"b2_026", ku:"Mêze kirin", tr:"Bakmak / İzlemek", en:"To look / observe",
   cins:"bêcins", ez:null, kat:"bileşik_leker", zor:0.66,
   not:"\"Mêze kirin\" = dikkatle bakmak. [FB]: mêze kirin v.comp.",
   her:["Tu çi mêze dikî?", "Min mêze kir û dît."],
   gen:["Mêze bike!", "Mêze dike."]),

  // ════════════════════════════════════════════════════════════
  // B2 BİRİM 4 — GAZETE VE RESMİ DİL
  // [BNK] Institut Kurde + [AZ] Ders 18 (medya)
  // ════════════════════════════════════════════════════════════

  (id:"b2_030", ku:"Ragihandin", tr:"İletişim / Haberleşme", en:"Communication / Media",
   cins:"mê", ez:"ragihanndinê", kat:"medya", zor:0.67,
   not:"Dişil — [FB]: ragihandin n.f. (aynı zamanda \"bildirmek\" fiili). \"Medyaya Kurdî\" = Kürt medyası",
   her:["Ragihandina kurdî geş dibe.", "Di ragihandina hevdem de…."],
   gen:["Ragihandin û rojname", "Ragihandina me"]),

  (id:"b2_031", ku:"Rojname", tr:"Gazete", en:"Newspaper",
   cins:"mê", ez:"rojnamê", kat:"medya", zor:0.68,
   not:"Dişil — [FB]: rojname n.f. \"Roj\" (gün) + \"name\" (mektup). \"Rojnameya kurdî\" = Kürtçe gazete",
   her:["Rojnameya kurdî dixwînim.", "Rojname derket."],
   gen:["Rojname û kovar", "Rojnameyên kurdî"]),

  (id:"b2_032", ku:"Kovar", tr:"Dergi", en:"Magazine / Journal",
   cins:"mê", ez:"kovarê", kat:"medya", zor:0.67,
   not:"Dişil — [FB]: kovar n.f. \"Kovara Hawarê\" (1932) — Bedir Han\'ın efsanevi dergisi!",
   her:["Kovara Hawarê di 1932an de derket.", "Kovar dixwînim."],
   gen:["Kovar û rojname", "Kovarên kurdî"]),

  (id:"b2_033", ku:"Nûçegiran", tr:"Gazeteci", en:"Journalist / Reporter",
   cins:"bêcins", ez:"nûçegiranê", kat:"medya", zor:0.66,
   not:"\"Nûçe\" (haber) + \"giran\" (ağır/önemli olan). [FB]: nûçegiran n.",
   her:["Nûçegiranê kurdî gelek dixebite.", "Ew nûçegiran e."],
   gen:["Nûçegiran û rojnamenivîs", "Nûçegiranên kurd"]),

  (id:"b2_034", ku:"Pirsname", tr:"Anket / Soru formu", en:"Questionnaire / Survey",
   cins:"mê", ez:"pirsnamê", kat:"medya", zor:0.64,
   not:"\"Pirs\" (soru) + \"name\" (yazı). [FB]: pirsname n.f. Akademik kullanım için önemli",
   her:["Pirsname dagirtin.", "Pirsnameyê tijî bike."],
   gen:["Pirsname û lêkolîn", "Pirsnameya me"]),

  (id:"b2_035", ku:"Raportin", tr:"Rapor etmek / Haberdar etmek", en:"To report",
   cins:"bêcins", ez:null, kat:"medya", zor:0.65,
   not:"\"Raportin\" fiili. [FB]: raportin v. Gazete ve resmi yazışmalarda kullanılır",
   her:["Nûçegiran ragihand.", "Kêşe hate ragihandin."],
   gen:["Ragihandin û pêşniyar", "Raportin lazim e."]),

  // ════════════════════════════════════════════════════════════
  // B2 BİRİM 5 — SOYUT KAVRAMLAR (Felsefe ve Kimlik)
  // [BNK] + [AZ] Ders 18
  // ════════════════════════════════════════════════════════════

  (id:"b2_040", ku:"Nasname", tr:"Kimlik", en:"Identity",
   cins:"mê", ez:"nasnamê", kat:"soyut", zor:0.68,
   not:"Dişil — \"nas\" (tanıma) + \"name\" (yazı/belge). [FB]: nasname n.f. Heritage kullanıcı için merkezi kavram",
   her:["Nasnameya kurdî dewlemend e.", "Nasname û ziman têkildar in."],
   gen:["Nasname û çand", "Nasnameya me"]),

  (id:"b2_041", ku:"Bîrdozî", tr:"İdeoloji", en:"Ideology",
   cins:"mê", ez:"bîrdoziyê", kat:"soyut", zor:0.64,
   not:"Dişil — [FB]: bîrdozî n.f. \"Bîr\" (düşünce) + \"dozî\". Kurmancî özgün türetme",
   her:["Bîrdoziya wê ne aşkere ye.", "Bîrdozî û siyaset."],
   gen:["Bîrdozî û hizr", "Bîrdoziya kurdî"]),

  (id:"b2_042", ku:"Netewe", tr:"Millet / Ulus", en:"Nation / People",
   cins:"mê", ez:"netewê", kat:"soyut", zor:0.70,
   not:"Dişil — [FB]: netewe n.f. \"Netewa kurd\" = Kürt milleti. [AZ] Ders 18: nationality",
   her:["Neteweyên cîhanê.", "Neteweya kurdî zindî ye."],
   gen:["Netewe û dewlet", "Neteweyên cîhanê"]),

  (id:"b2_043", ku:"Cîhan", tr:"Dünya / Evren", en:"World / Universe",
   cins:"nêr", ez:"cîhanê", kat:"soyut", zor:0.71,
   not:"Eril — [FB]: cîhan n.m. [Farsça]. \"Cîhana me\" = bizim dünyamız",
   her:["Cîhan guhêrbar e.", "Di cîhanê de gelek zimanên xweş hene."],
   gen:["Cîhan û ezel", "Cîhanê mezin"]),

  (id:"b2_044", ku:"Demokrasî", tr:"Demokrasi", en:"Democracy",
   cins:"mê", ez:"demokrasiyê", kat:"soyut", zor:0.66,
   not:"Dişil — uluslararası terim. \"Demokrasiya kurdî\" = Kürt demokrasisi",
   her:["Demokrasî û azadî pêwendîdar in.", "Demokrasî lazim e."],
   gen:["Demokrasî û maf", "Demokrasiya me"]),

  (id:"b2_045", ku:"Meşrûiyet", tr:"Meşruiyet", en:"Legitimacy",
   cins:"mê", ez:"meşrûiyetê", kat:"soyut", zor:0.62,
   not:"Dişil — [AS] hiqûq bölümü → Kurmancîde doğru terim: \"zagon\" (kanun) veya \"maf\" (hak/hukuk)",
   her:["Meşrûiyeta dewletê.", "Pirsên meşrûiyetê."],
   gen:["Meşrûiyet û maf", "Meşrûiyeta me"]),

  (id:"b2_046", ku:"Dadmendî", tr:"Adalet", en:"Justice",
   cins:"mê", ez:"dadmendiyê", kat:"soyut", zor:0.68,
   not:"Dişil — \"dad\" (adalet) + \"-mendî\" — özgün Kurmancî form. [BH] §275. \"Edalat\" Arapça kökenli — \"dadmendî\" tercih edilir.",
   her:["Dadmendî bingeha civakê ye.", "Dadmendî û maf."],
   gen:["Dadmendî û azadî", "Dadmendîya civakî"]),

  (id:"b2_047", ku:"Têgeh", tr:"Kavram", en:"Concept",
   cins:"nêr", ez:"têgehê", kat:"soyut", zor:0.64,
   not:"Eril — [FB]: têgeh n.m. Akademik ve felsefi yazımda kullanılır",
   her:["Têgeha azadiyê.", "Têgehên bingehîn."],
   gen:["Têgeh û teorî", "Têgehên sereke"]),

  (id:"b2_048", ku:"Nîqaş", tr:"Tartışma / Müzakere", en:"Discussion / Debate",
   cins:"nêr", ez:"nîqaşê", kat:"soyut", zor:0.66,
   not:"Eril — [AS] no.1099: \"tartışmak = nîgaş kirin, gengeşî kirin\" ✓. \"Gengeşî\" daha özgün Kurmancî; \"nîqaş\" Arapça kökenli ama yaygınlaşmış. İkisi de kabul.",
   her:["Nîqaşa girîng bû.", "Di nîqaşê de gelek got."],
   gen:["Nîqaş û lihevkirin", "Nîqaşa me"]),

  // ════════════════════════════════════════════════════════════
  // B2 BİRİM 6 — EKOLOJİ VE ÇEVRE
  // [AZ] Ders 19 extended + [BNK]
  // ════════════════════════════════════════════════════════════

  (id:"b2_050", ku:"Ekolojî", tr:"Ekoloji", en:"Ecology",
   cins:"mê", ez:"ekolojiyê", kat:"ekoloji", zor:0.65,
   not:"Dişil — uluslararası terim. \"Ekolojiya Kurdistanê\" = Kürdistan ekolojisi",
   her:["Ekolojî û xweza girêdayî ne.", "Ekolojî xirabtir dibe."],
   gen:["Ekolojî û çand", "Ekolojiya me"]),

  (id:"b2_051", ku:"Gurçkirin", tr:"Kurutmak / Yok etmek", en:"To dry up / destroy",
   cins:"bêcins", ez:null, kat:"ekoloji", zor:0.63,
   not:"\"Gurç\" + \"kirin\". Ormansızlaşma, nehirlerin kuruması için kullanılır",
   her:["Daristan gurç dibe.", "Çem gurç kiriye."],
   gen:["Gurçkirin û xêzkirin", "Daristan gurç dibe."]),

  (id:"b2_052", ku:"Qirêjahî", tr:"Kirlilik / Çevre kirliliği", en:"Pollution",
   cins:"mê", ez:"qirêjahiyê", kat:"ekoloji", zor:0.65,
   not:"Dişil — \"qirêj\" (kirli) + \"-ahî\" (sonek). [BH] §: -ahî sonek türetme",
   her:["Qirêjahiya hewayê mezin dibe.", "Qirêjahî û ekolojî."],
   gen:["Qirêjahî û paqijî", "Qirêjahiya malê"]),

  (id:"b2_053", ku:"Xwedîderketina xwezayê", tr:"Doğayı koruma / Çevrecilik", en:"Environmental protection",
   cins:"mê", ez:null, kat:"ekoloji", zor:0.60,
   not:"\"Xwedîderketin\" = sahip çıkma. Uzun ama Kurmancîde yaygın bileşik",
   her:["Xwedîderketina xwezayê girîng e.", "Em xwezayê diparêzin."],
   gen:["Xweza biparêze!", "Xwedîderketin lazim e."]),

  (id:"b2_054", ku:"Germahiya globî", tr:"Küresel ısınma", en:"Global warming",
   cins:"mê", ez:null, kat:"ekoloji", zor:0.63,
   not:"\"Germahî\" (ısı, dişil) + \"globî\" (küresel). Kürtçe özgün terim kombinasyonu",
   her:["Germahiya globî xetereye.", "Li dijî germahiya globî bisekine!"],
   gen:["Germahiya globî", "Germahî û qirêjahî"]),

  // ════════════════════════════════════════════════════════════
  // B2 BİRİM 7 — KÜRT EDEBİYATI KAVRAMLARI
  // Mem û Zîn, Cegerxwîn, Dengbêj geleneği
  // [BNK] Institut Kurde dijital kütüphane
  // ════════════════════════════════════════════════════════════

  (id:"b2_060", ku:"Dilsoz", tr:"Sadık / Vefakâr", en:"Loyal / Faithful",
   cins:"bêcins", ez:null, kat:"edebiyat", zor:0.69,
   not:"\"Dil\" (gönül) + \"soz\" (söz). [FB]: dilsoz adj. Mem û Zîn\'deki sevgi dilinin temel kelimesi",
   her:["Mem ji Zîn re dilsoz bû.", "Dost û dilsoz."],
   gen:["Dilsoz û bawer", "Ev dilsoz e."]),

  (id:"b2_061", ku:"Bengî", tr:"Tutsak / Esir", en:"Captive / Prisoner",
   cins:"bêcins", ez:"bengiyê", kat:"edebiyat", zor:0.66,
   not:"[FB]: bengî n. \"Mem û Zîn\'de Mem\'in tutsaklığı\" — edebi bağlam. Bedir Han kullanımı",
   her:["Mem bengî bû.", "Bengiya dilî."],
   gen:["Bengî û azad", "Bengiyê aşqê"]),

  (id:"b2_062", ku:"Xerîb", tr:"Gurbetçi / Yabancı", en:"Stranger / Exile",
   cins:"bêcins", ez:"xerîbê", kat:"edebiyat", zor:0.70,
   not:"\"Xerîb\" = yabancı/gurbet. [FB]: xerîb n./adj. Kürt diaspora edebiyatında merkezi kavram",
   her:["Ez li vê bajêr xerîbim.", "Dengê xerîbî dike."],
   gen:["Xerîb û welat", "Dengê xerîbiyê"]),

  (id:"b2_063", ku:"Gurbet", tr:"Gurbet / Yurt dışı", en:"Exile / Foreign land",
   cins:"nêr", ez:"gurbetê", kat:"edebiyat", zor:0.70,
   not:"Eril — [FB]: gurbet n.m. \"Li gurbetê\" = gurbette. Heritage kullanıcının gerçekliği",
   her:["Em li gurbetê ne.", "Dengbêjên gurbetê stranên xemgîn dibêjin."],
   gen:["Gurbet û welat", "Li gurbetê"]),

  (id:"b2_064", ku:"Bîranîn", tr:"Anı / Hatıra", en:"Memory / Recollection",
   cins:"mê", ez:"bîranînê", kat:"edebiyat", zor:0.68,
   not:"Dişil — [FB]: bîranîn n.f. \"Bîr\" (akıl/hafıza) + \"-anîn\" (türetme). \"Bîranînên pîrê\" = büyükannenin anıları",
   her:["Bîranînên pîrê girîng in.", "Di bîranîna me de dimîne."],
   gen:["Bîranîn û jibîrkirin", "Bîranînên me"]),

  (id:"b2_065", ku:"Jibîrkirin", tr:"Unutmak", en:"To forget",
   cins:"bêcins", ez:null, kat:"edebiyat", zor:0.69,
   not:"\"Ji bîr kirin\" = unutmak. [FB]: ji bîr kirin v. Asimilasyonun sonucu: \"Zimanê me ji bîr ne bikin!\"",
   her:["Zimanê xwe ji bîr neke!", "Min jibîr kir."],
   gen:["Jibîrkirin û bîranîn", "Ji bîr neke!"]),

  (id:"b2_066", ku:"Şibandin", tr:"Benzetmek / Kıyaslamak", en:"To compare / liken",
   cins:"bêcins", ez:null, kat:"edebiyat", zor:0.65,
   not:"\"Şibandin\" fiili — şiirde benzetme sanatı için. [TH] §65",
   her:["Şair dilê xwe bi bilbil şiband.", "Xanî Kurdistan bi baxçe şiband."],
   gen:["Şibandin û qiyaskirin", "Bi... re şiband."]),

  // ════════════════════════════════════════════════════════════
  // B2 BİRİM 8 — ŞARTLI CÜMLELER (Conditional)
  // [BH] §192 + [TH] §79 + [AZ] Ders 15
  // ════════════════════════════════════════════════════════════

  (id:"b2_070", ku:"Ger ... bûya ... bûya", tr:"Olsaydı ... olurdu", en:"If ... had ... would have",
   cins:"bêcins", ez:null, kat:"şart", zor:0.58,
   not:"Gerçekleşmemiş şart — [BH] §192: \"Ger … bûya … bûya\". \"Ger ez dizanibûm, digotim\" = bilseydim, söylerdim",
   her:["Ger pîrê hatibûya, em şa bibûyan.", "Ger ez zanibûm, nediçûm."],
   gen:["Ger … bûya…", "Ger dizanibûm…"]),

  (id:"b2_071", ku:"Ger ... be ... be", tr:"Eğer ... ise ... olur", en:"If ... then ...",
   cins:"bêcins", ez:null, kat:"şart", zor:0.62,
   not:"Gerçekleşebilir şart — [TH] §79: \"ger … be\" = eğer … ise (gelecek olası)",
   her:["Ger hewa baş be, em diçin.", "Ger tu bêyî, ez jî bêm."],
   gen:["Ger baş be…", "Ger were…"]),

  (id:"b2_072", ku:"Heya ku", tr:"-dığı sürece / Oldukça", en:"As long as",
   cins:"bêcins", ez:null, kat:"şart", zor:0.62,
   not:"\"Heya ku\" = -dığı sürece. [TH] §: subordinate clauses",
   her:["Heya ku ez dijim, hîn dibim.", "Heya ku pîrê heye, ziman dimîne."],
   gen:["Heya ku…", "Heya ku dijim"]),

  (id:"b2_073", ku:"Çawa ku", tr:"Nasıl ki / Gibi", en:"Just as / Like",
   cins:"bêcins", ez:null, kat:"şart", zor:0.63,
   not:"\"Çawa ku\" = nasıl ki. Edebi dilde karşılaştırma ve analoji için. [TH] §",
   her:["Çawa ku te got, wilo ye.", "Çawa ku av di çemê de diherike…."],
   gen:["Çawa ku…", "Çawa ku tê zanîn"]),

  // ════════════════════════════════════════════════════════════
  // B2 BİRİM 9 — MASTARLAŞTİRMA (Nominalization)
  // [BH] §: infinitive as noun + [TH] §86
  // ════════════════════════════════════════════════════════════

  (id:"b2_080", ku:"Xwendin baş e", tr:"Okumak iyidir", en:"Reading is good (nominalized)",
   cins:"bêcins", ez:null, kat:"mastar", zor:0.63,
   not:"Mastar isim gibi kullanılır. [TH] §86: infinitives as nouns. \"Xwendin\" = hem \"okumak\" hem \"okuma\"",
   her:["Xwendin baş e.", "Xwendina Kurmancî kêfxweş e."],
   gen:["Xwendin û nivîsîn", "Xwendin girîng e."]),

  (id:"b2_081", ku:"Hez kirin erzanî ye", tr:"Sevmek değerlidir", en:"Loving is precious",
   cins:"bêcins", ez:null, kat:"mastar", zor:0.62,
   not:"Bileşik fiil mastar olarak: \"hez kirin\" = sevmek (isim gibi). [TH] §86",
   her:["Ji malbatê hez kirin xweştirîn tişt e.", "Hez kirin û hezkirî bûn."],
   gen:["Hez kirin girîng e.", "Hez kirin"]),

  (id:"b2_082", ku:"Nivîsandina Kurmancî", tr:"Kurmancî yazımı", en:"Writing in Kurmanji",
   cins:"bêcins", ez:null, kat:"mastar", zor:0.63,
   not:"\"Nivîsandin\" fiil → isim olarak \"-ina\" ekiyle (verbal noun). [BH] §: verbal nouns",
   her:["Nivîsandina Kurmancî hîn dikim.", "Nivîsandina baş hewce ye."],
   gen:["Nivîsandina kurdî", "Nivîsandin û xwendin"]),

  // ════════════════════════════════════════════════════════════
  // B2 BİRİM 10 — ATASÖZÜ VE DEYİMLER
  // [BNK] Lescot — Textes Kurdes (1940) + Institut Kurde
  // ════════════════════════════════════════════════════════════

  (id:"b2_090", ku:"Dev ji birçîtiyê vedikin, dev li xwerinê digirin", tr:"Açlıktan ağız açarlar, yemeğe ağız kapatırlar", en:"Proverb about moderation",
   cins:"bêcins", ez:null, kat:"pêşgotin", zor:0.60,
   not:"Kürt atasözü. \"Dev\" = ağız. \"Birçîtî\" = açlık. Denge ve ölçülülük hakkında",
   her:["Dev ji birçîtiyê vedikin….", "Ev pêşgotin ji me re dibêje."],
   gen:["Pêşgotina Kurdî", "Ji birçîtiyê…"]),

  (id:"b2_091", ku:"Gund bê bav weke mal bê xwe ye", tr:"Babasız köy korsuz ev gibi", en:"Proverb about leadership",
   cins:"bêcins", ez:null, kat:"pêşgotin", zor:0.59,
   not:"Kürt atasözü. Toplumsal liderlik ve birliğin önemi. [BNK] Folklor arşivi",
   her:["Gund bê bav weke mal bê xwe ye.", "Ev pêşgotin dîroka me ye."],
   gen:["Pêşgotina Kurdî", "Gund û bav"]),

  (id:"b2_092", ku:"Çavê kor, dilê kor", tr:"Kör gözün kalbi de kör", en:"Proverb about inner sight",
   cins:"bêcins", ez:null, kat:"pêşgotin", zor:0.60,
   not:"Kürt atasözü. \"Çav\" = göz. \"Kor\" = kör. İç görüş / empati hakkında",
   her:["Çavê kor, dilê kor — hişyar be!", "Ev pêşgotin çawa ye?"],
   gen:["Çav û dil", "Pêşgotina Kurdî"]),

  (id:"b2_093", ku:"Erzan kirî, biha ferya dike", tr:"Ucuza aldığın pahalıya ağlar", en:"You get what you pay for",
   cins:"bêcins", ez:null, kat:"pêşgotin", zor:0.60,
   not:"\"Ferya kirin\" = ağlamak/feryat etmek. Kalite ve değer hakkında. [BNK] atasözü koleksiyonu",
   her:["Erzan kirî, biha ferya dike — rast e!", "Ev pêşgotin di jiyana me de heye."],
   gen:["Erzan û biha", "Pêşgotina me"]),

  // ════════════════════════════════════════════════════════════
  // B2 BİRİM 11 — SOSYAL BİLİMLER VE EĞİTİM
  // [AS] s.65 + [AZ] Ders 18
  // ════════════════════════════════════════════════════════════

  (id:"b2_100", ku:"Civak", tr:"Toplum", en:"Society",
   cins:"nêr", ez:"civakê", kat:"civaknas", zor:0.70,
   not:"Eril — [FB]: civak n.m. \"Civaka kurdî\" = Kürt toplumu. [AS] sosyoloji bölümü",
   her:["Civaka kurdî guhartin dide.", "Di civakê de ziman girîng e."],
   gen:["Civak û dewlet", "Civaka me"]),

  (id:"b2_101", ku:"Civaknas", tr:"Sosyolog / Sosyoloji", en:"Sociologist / Sociology",
   cins:"bêcins", ez:"civaknaê", kat:"civaknas", zor:0.64,
   not:"\"Civak\" + \"-nas\" (bilen). Kurmancî özgün türetme. \"Civaknas\" hem sosyolog hem sosyoloji",
   her:["Civaknas pirsgirêkê analîz dike.", "Civaknas û psîkolojînas."],
   gen:["Civaknas û rewşenbîr", "Civaknas e."]),

  (id:"b2_102", ku:"Rewşenbîr", tr:"Aydın / Entelektüel", en:"Intellectual",
   cins:"bêcins", ez:"rewşenbîrê", kat:"civaknas", zor:0.66,
   not:"\"Rewşen\" (aydın) + \"bîr\" (akıl). [FB]: rewşenbîr n. Kürt entelektüel geleneği için terim",
   her:["Rewşenbîrên kurd gelek xebat kirin.", "Ew rewşenbîrek e."],
   gen:["Rewşenbîr û xwendekar", "Rewşenbîrên me"]),

  (id:"b2_103", ku:"Perwerdezanî", tr:"Eğitim bilimi / Pedagoji", en:"Pedagogy",
   cins:"mê", ez:"perwerdezaniyê", kat:"perwerde", zor:0.65,
   not:"Dişil — \"Pedagojiya kurdî\" = Kürtçe eğitim metodolojisi. [AS] akademik bölüm",
   her:["Perwerdezaniya kurdî pêş dikeve.", "Di perwerdezaniyê de ziman sereke ye."],
   gen:["Perwerdezanî û perwerde", "Perwerdezaniya me"]),

  (id:"b2_104", ku:"Rewanzanî", tr:"Psikoloji / Rewanzanî", en:"Psychology",
   cins:"mê", ez:"rewanzaniyê", kat:"perwerde", zor:0.65,
   not:"Dişil — uluslararası terim. \"Psîkolojiya civakî\" = sosyal psikoloji",
   her:["Rewanzanî û ziman têkildar in.", "Di rewanzaniyê de bîranîn girîng e."],
   gen:["Rewanzanî û civaknas", "Rewanzaniya me"]),

  (id:"b2_105", ku:"Du-alîtî", tr:"İkicilik / Çifte aidiyet", en:"Dualism",
   cins:"nêr", ez:"dualîzmê", kat:"felsefe", zor:0.60,
   not:"Eril — felsefi terim. Kürt kimliği çalışmalarında: \"Türkçe ve Kürtçe arasında dualîzm\"",
   her:["Du-alîtiya zimanî pirsgirêk e.", "Du-alîtî û nasname."],
   gen:["Du-alîtî û yekîtî", "Du-alîtiya me"]),

  // ════════════════════════════════════════════════════════════
  // B2 BİRİM 12 — HUKUK VE SİYASET
  // [AS] s.65 HİQÛQ + [AZ] Ders 18
  // ════════════════════════════════════════════════════════════

  (id:"b2_110", ku:"Zagon", tr:"Kanun / Yasa", en:"Law / Statute",
   cins:"nêr", ez:"zagonê", kat:"zagon", zor:0.67,
   not:"Eril — [BH] + [TH]: zagon n.m. Kurmancîde standart \"kanun/yasa\" kelimesi. \"Hiqûq\" Arapça/Soranî etkisi — doğrusu \"zagon\" (yasa) veya \"maf\" (hak). [AZ] Ders 18: law",
   her:["Zagonê welêt divê were parastin.", "Li gorî zagonê."],
   gen:["Zagon û maf", "Zagonê welêt"]),

  (id:"b2_110b", ku:"Maf", tr:"Hak / Hukuk", en:"Right / Law",
   cins:"nêr", ez:"mafê", kat:"zagon", zor:0.70,
   not:"Eril — [BH] + [FB]: maf n.m. Günlük Kurmancîde \"hak\" ve \"hukuk\" için en yaygın kelime. \"Mafên mirovan\" = insan hakları. \"Hiqûq\" yerine kullanılmalı",
   her:["Mafê xwe biparêze!", "Mafên mirovan girîng in."],
   gen:["Maf û dadmendî", "Mafên me"]),

  (id:"b2_111", ku:"Serokmar", tr:"Cumhurbaşkanı", en:"President",
   cins:"bêcins", ez:"serokmara", kat:"zagon", zor:0.66,
   not:"\"Serok\" (başkan) + \"mar\" (döneme ait). [FB]: serokmar n. \"Serokmarê Kurdistanê\"",
   her:["Serokmarê Kurdistan Herêma Kurdistanê.", "Serokmar axivî."],
   gen:["Serokmar û parlamento", "Serokmara me"]),

  (id:"b2_112", ku:"Parlament", tr:"Meclis / Parlamento", en:"Parliament",
   cins:"nêr", ez:"parlamentê", kat:"zagon", zor:0.67,
   not:"Eril — [FB]: parlament n.m. [Fransızca/İngilizce]. \"Parlamentoya Kurdistanê\"",
   her:["Parlament biryar da.", "Di parlamentê de nîqaş bû."],
   gen:["Parlament û serokmar", "Parlamenta me"]),

  (id:"b2_110c", ku:"Dadmendî", tr:"Hukukbilim / Yargı sistemi", en:"Jurisprudence / Legal justice",
   cins:"mê", ez:"dadmendiyê", kat:"zagon", zor:0.68,
   not:"Dişil — \"dad\" (adalet/mahkeme) + \"-mendî\" (sahip olan). Kurmancî özgün bileşim. \"Dadgeh\" = mahkeme. \"Dadmend\" = adaletli/hakim kişi. Bedir Han §275: \"-î\" soneki soyut ad yapar",
   her:["Dadmendiya kurdî pêşde diçe.", "Di dadmendiyê de maf girîng e."],
   gen:["Dadmendî û zagon", "Dadmendiya me"]),

  (id:"b2_110d", ku:"Zagonî", tr:"Yasal / Hukuki", en:"Legal / Lawful",
   cins:"bêcins", ez:null, kat:"zagon", zor:0.64,
   not:"\"Zagona\" (kanun) + \"-î\" eki. [FB]: zagonî adj.",
   her:["Ev zagonî ye.", "Bi awayekî zagonî."],
   gen:["Zagonî û nedestûrî", "Ev zagonî ye."]),

  (id:"b2_114", ku:"Siyaset", tr:"Siyaset / Politika", en:"Politics",
   cins:"mê", ez:"siyasetê", kat:"zagon", zor:0.70,
   not:"Dişil — [FB]: siyaset n.f. [Arapça]. \"Siyaseta kurdî\" = Kürt siyaseti",
   her:["Siyaset û çand têkildar in.", "Siyaseta Kurdistanê."],
   gen:["Siyaset û aborî", "Siyaseta me"]),

  // ════════════════════════════════════════════════════════════
  // B2 BİRİM 13 — İLERİ DÜZEYLİ ZAMAN VE KIYAS
  // ════════════════════════════════════════════════════════════

  (id:"b2_120", ku:"Ji dema ku", tr:"-den beri / -dığından beri", en:"Ever since",
   cins:"bêcins", ez:null, kat:"dem", zor:0.64,
   not:"\"Ji dema ku\" = -den beri. [TH] §85: time expressions B2",
   her:["Ji dema ku hat, gelek xwend.", "Ji dema ku Kurmancî hîn dibim, şa me."],
   gen:["Ji dema ku...", "Ji dema ku hatim"]),

  (id:"b2_121", ku:"Heta niha", tr:"Şimdiye kadar / Bugüne dek", en:"Until now / So far",
   cins:"bêcins", ez:null, kat:"dem", zor:0.67,
   not:"\"Heta niha\" = şimdiye kadar. [TH] §85",
   her:["Heta niha gelek xwend.", "Heta niha tu xwendiye?"],
   gen:["Heta niha û ji niha pê ve", "Heta niha"]),

  (id:"b2_122", ku:"Ji niha pê ve", tr:"Bundan böyle / Artık", en:"From now on",
   cins:"bêcins", ez:null, kat:"dem", zor:0.65,
   not:"\"Ji niha pê ve\" = bundan sonra. [TH] §85: future time expressions",
   her:["Ji niha pê ve bi Kurmancî dipeyivim!", "Ji niha pê ve çêtir dibe."],
   gen:["Ji niha pê ve...", "Ji niha pê ve baştir e."]),

  (id:"b2_123", ku:"Di vê navberê de", tr:"Bu arada / Esnasında", en:"Meanwhile / In the meantime",
   cins:"bêcins", ez:null, kat:"dem", zor:0.63,
   not:"\"Di vê navberê de\" = bu arada. Gazete dilinde sık. [TH] §: discourse markers",
   her:["Di vê navberê de bûyerên girîng çêbûn.", "Di vê navberê de…."],
   gen:["Di vê navberê de...", "Di vê navberê de hat."]),

  // ════════════════════════════════════════════════════════════
  // B2 BİRİM 14 — TURİZM VE COĞRAFYA
  // Kürdistan coğrafyası
  // ════════════════════════════════════════════════════════════

  (id:"b2_130", ku:"Erdnîgarî", tr:"Coğrafya / Erdnîgarî", en:"Geography",
   cins:"mê", ez:"erdnîgariyê", kat:"erdnîgarî", zor:0.66,
   not:"Dişil — erd (toprak/yer) + nîgar (çizim/resim) — Kurmancî özgün terim. Erdnîgariya Kurdistanê = Kürdistan coğrafyası",
   her:["Erdnîgariya Kurdistanê xweş e.", "Di erdnîgariyê de."],
   gen:["Erdnîgarî û dîrok", "Erdnîgariya Kurdistanê"]),

  (id:"b2_131", ku:"Sînor", tr:"Sınır", en:"Border / Limit",
   cins:"nêr", ez:"sînorê", kat:"erdnîgarî", zor:0.68,
   not:"Eril — [FB]: sînor n.m. \"Sînorên Kurdistanê\" = Kürdistan sınırları",
   her:["Sînorên çar welatan dibirin.", "Sînor û welat."],
   gen:["Sînor û nav", "Sînorên me"]),

  (id:"b2_132", ku:"Çiyayên Zagros", tr:"Zagros Dağları", en:"Zagros Mountains",
   cins:"bêcins", ez:null, kat:"erdnîgarî", zor:0.67,
   not:"Kürdistan\'ın ana dağ silsilesi. \"Çiyayên Zagros û Toros\" = Zagros ve Toroslar",
   her:["Çiyayên Zagros bilind û xweş in.", "Li çiyayên Zagros Kurdên gelek dijîn."],
   gen:["Zagros û Toros", "Çiyayên Zagros"]),

  (id:"b2_133", ku:"Dicle", tr:"Dicle (nehri)", en:"Tigris river",
   cins:"mê", ez:"Diclê", kat:"erdnîgarî", zor:0.69,
   not:"Dişil — Tarihi Kürt nehri. \"Dicle û Firat\" = Dicle ve Fırat. Mezopotamya kültüründe kutsal",
   her:["Dicle ji çiyayên Kurdistanê diherike.", "Dicle û Firat."],
   gen:["Dicle û Firat", "Li Diclê"]),

  // ════════════════════════════════════════════════════════════
  // B2 BİRİM 15 — SANAT VE ESTETİK
  // ════════════════════════════════════════════════════════════

  (id:"b2_140", ku:"Xêzkarî", tr:"Resim / Çizim sanatı", en:"Drawing / Painting",
   cins:"mê", ez:"xêzkariyê", kat:"huner", zor:0.66,
   not:"Dişil — \"xêz\" (çizgi) + \"-karî\" (iş). [FB]: xêzkarî n.f.",
   her:["Xêzkariya kurdî dewlemend e.", "Xêzkarî û muzîk."],
   gen:["Xêzkarî û wênesazî", "Xêzkariya me"]),

  (id:"b2_141", ku:"Wênesazî", tr:"Resim sanatı / Boyama", en:"Painting / Visual art",
   cins:"mê", ez:"wênesaziyê", kat:"huner", zor:0.65,
   not:"Dişil — \"wêne\" (resim/fotoğraf) + \"-sazî\" (yapım). [FB]: wênesazî n.f.",
   her:["Wênesaziya kurdî mezin dibe.", "Di wênesaziyê de reng girîng e."],
   gen:["Wênesazî û muzîk", "Wênesaziya kurdî"]),

  (id:"b2_142", ku:"Xweşikzanî", tr:"Estetik / Güzellik bilimi", en:"Aesthetics",
   cins:"mê", ez:"xweşikzaniyê", kat:"huner", zor:0.65,
   not:"Dişil — \"xweşik\" (güzel) + \"zanî\" (bilim). Kurmancî özgün terim. \"Estetîk\" yerine kullanılmalı. Bedir Han §275: -zanî/-nas sonekleri meslek/bilim adı yapar",
   her:["Xweşikzaniya muzîka kurdî.", "Xweşikzanî û huner."],
   gen:["Xweşikzanî û çand", "Xweşikzaniya me"]),

  (id:"b2_143", ku:"Hunermend", tr:"Sanatçı", en:"Artist",
   cins:"bêcins", ez:"hunermendê", kat:"huner", zor:0.68,
   not:"\"Huner\" (sanat) + \"-mend\" (sahip). [FB]: hunermend n.",
   her:["Hunermendên kurd gelek in.", "Ew hunermendek baş e."],
   gen:["Hunermend û rewşenbîr", "Hunermendên kurdî"]),

];

// ════════════════════════════════════════════════════════════════
// B2 TAM LİSTE
// ════════════════════════════════════════════════════════════════


// ════════════════════════════════════════════════════════════════
// B2 EK KELİMELER — +150 kelime
// ════════════════════════════════════════════════════════════════

final kB2EkKelimeler = [

  // ─────────────────────────────────────────────────────────────
  // FELSEFFE VE ETİK
  // ─────────────────────────────────────────────────────────────

  (id:"b2_200", ku:"Exlaq", tr:"Ahlak / Etik", en:"Ethics / Morals",
   cins:"nêr", ez:"exlaqê", kat:"felsefe", zor:0.68,
   not:"Eril — [FB]: exlaq n.m. [Arapça]. \"Exlaqê civakî\" = sosyal ahlak.",
   her:["Exlaq girîng e.", "Exlaqê me."], gen:["Exlaq û dadmendî", "Exlaqê me"]),

  (id:"b2_201", ku:"Rexne", tr:"Eleştiri", en:"Criticism",
   cins:"mê", ez:"rexnê", kat:"felsefe", zor:0.69,
   not:"Dişil — [FB]: rexne n.f. \"Rexneya edebî\" = edebi eleştiri.",
   her:["Rexne lazim e.", "Rexneya konstruktîf."], gen:["Rexne û piştgirî", "Rexneya me"]),

  (id:"b2_202", ku:"Arguman", tr:"Argüman / Kanıt", en:"Argument / Evidence",
   cins:"nêr", ez:"argumanê", kat:"felsefe", zor:0.68,
   not:"Eril — [FB]: arguman n.m. \"Argumentên wî baş bûn.\"",
   her:["Arguman heye.", "Argumanê te çi ye?"], gen:["Arguman û delîl", "Argumanê me"]),

  (id:"b2_203", ku:"Nêzîkatî", tr:"Yaklaşım", en:"Approach",
   cins:"mê", ez:"nêzîkatiyê", kat:"felsefe", zor:0.68,
   not:"Dişil — \"nêzîk\" (yakın) + \"-atî\". [FB]: nêzîkatî n.f.",
   her:["Nêzîkatiya baş.", "Nêzîkatiya me."], gen:["Nêzîkatî û rêbaz", "Nêzîkatiya me"]),

  (id:"b2_204", ku:"Rêbaz", tr:"Yöntem", en:"Method",
   cins:"nêr", ez:"rêbazê", kat:"felsefe", zor:0.68,
   not:"Eril — \"rê\" (yol) + \"baz\" (giden). [FB]: rêbaz n.m.",
   her:["Rêbaza baş heye.", "Rêbaza zanistî."], gen:["Rêbaz û nêzîkatî", "Rêbaza me"]),

  // ─────────────────────────────────────────────────────────────
  // EDEBİYAT TERMİNOLOJİSİ
  // ─────────────────────────────────────────────────────────────

  (id:"b2_210", ku:"Metafor", tr:"Metafor / Mecaz", en:"Metaphor",
   cins:"nêr", ez:"metaforê", kat:"edebiyat", zor:0.67,
   not:"Eril — uluslararası terim. \"Kurmancîde \"îstiare\" de kullanılır.",
   her:["Ev metafor e.", "Metaforên Xanî."], gen:["Metafor û sembol", "Metaforê me"]),

  (id:"b2_211", ku:"Sembol", tr:"Sembol", en:"Symbol",
   cins:"nêr", ez:"sembolê", kat:"edebiyat", zor:0.68,
   not:"Eril — [FB]: sembol n.m. \"Agir sembola azadiyê ye\" = ateş özgürlüğün sembolüdür.",
   her:["Agir sembola azadiyê ye.", "Sembol baş e."], gen:["Sembol û metafor", "Sembolê me"]),

  (id:"b2_212", ku:"Rîtim", tr:"Ritim", en:"Rhythm",
   cins:"nêr", ez:"rîtimê", kat:"edebiyat", zor:0.67,
   not:"Eril — [FB]: rîtim n.m. \"Rîtima helbestê\" = şiirin ritmi.",
   her:["Rîtima stranê xweş e.", "Rîtim girîng e."], gen:["Rîtim û dengbêj", "Rîtima me"]),

  (id:"b2_213", ku:"Vegotina yekem", tr:"Birinci şahıs anlatımı", en:"First person narration",
   cins:"mê", ez:"vegotinê", kat:"edebiyat", zor:0.65,
   not:"\"Vegotina yekem\" = birinci şahıs. \"Vegotin\" = anlatı. [FB]: vegotin n.f.",
   her:["Vegotina yekem xweş e.", "Di vegotina yekemê de."], gen:["Vegotin û metnin", "Vegotina me"]),

  // ─────────────────────────────────────────────────────────────
  // EKOLOJİ VE ÇEVRE GENİŞLEME
  // ─────────────────────────────────────────────────────────────

  (id:"b2_220", ku:"Hewayê germ", tr:"Sıcak hava / İklim", en:"Warm climate",
   cins:"bêcins", ez:null, kat:"ekoloji", zor:0.68,
   not:"\"Germahiya hewayê\" = havanın sıcaklığı. İklim değişikliği bağlamı.",
   her:["Hewayê germ zêde dibe.", "Germahiya hewayê."], gen:["Hewayê germ û sar", "Germahiya hewayê"]),

  (id:"b2_221", ku:"Daristan xêzkirin", tr:"Ağaçlandırma", en:"Reforestation",
   cins:"bêcins", ez:null, kat:"ekoloji", zor:0.65,
   not:"\"Daristan\" (orman) + \"xêzkirin\" (çizme/kurma) = ağaçlandırma.",
   her:["Daristan xêzkirin lazim e.", "Daristanek nû."], gen:["Daristan û çevre", "Daristan xêzkirin"]),

  (id:"b2_222", ku:"Enerjiya xwezayî", tr:"Yenilenebilir enerji", en:"Natural / Renewable energy",
   cins:"mê", ez:"enerjiyê", kat:"ekoloji", zor:0.66,
   not:"\"Enerjiya tavê\" (güneş enerjisi), \"enerjiya bayê\" (rüzgar enerjisi). Kürdistan potansiyeli.",
   her:["Enerjiya xwezayî lazim e.", "Enerjiya tavê baş e."], gen:["Enerji û qirêjahî", "Enerjiya me"]),

  // ─────────────────────────────────────────────────────────────
  // SOSYAL BİLİM KELİMELERİ
  // ─────────────────────────────────────────────────────────────

  (id:"b2_230", ku:"Nifûs", tr:"Nüfus", en:"Population",
   cins:"nêr", ez:"nifûsê", kat:"civaknas", zor:0.70,
   not:"Eril — [FB]: nifûs n.m. [Arapça]. \"Nifûsa Kurdistanê\" = Kürdistan nüfusu.",
   her:["Nifûs zêde dibe.", "Nifûsa bajêr."], gen:["Nifûs û hejmar", "Nifûsa me"]),

  (id:"b2_231", ku:"Perwerde", tr:"Eğitim", en:"Education",
   cins:"mê", ez:"perwerdê", kat:"perwerde", zor:0.74,
   not:"Dişil — [FB]: perwerde n.f. \"Perwerdehiya kurdî\" = Kürtçe eğitim. A2\'de \"perwerdehî\" formu da var.",
   her:["Perwerde girîng e.", "Perwerdehiya kurdî."], gen:["Perwerde û ziman", "Perwerdeya me"]),

  (id:"b2_232", ku:"Têkoşerî", tr:"Mücadeleci / Aktivist", en:"Activist / Fighter",
   cins:"bêcins", ez:"têkoşeriyê", kat:"kimlik", zor:0.68,
   not:"\"Têkoşer\" + \"-î\" = mücadeleci durum/kimlik. Heritage bağlamında dil aktivizmi.",
   her:["Ew têkoşer e.", "Têkoşeriya zimanî."], gen:["Têkoşer û rêvebirî", "Têkoşerên me"]),

  (id:"b2_233", ku:"Çavdêrî kirin", tr:"Gözlemlemek / İzlemek", en:"To observe / monitor",
   cins:"bêcins", ez:null, kat:"civaknas", zor:0.68,
   not:"\"Çavdêrî kirin\" — \"çav\" (göz) + \"dêrî\" (tutma/gözleme). [AS] no.1044: kontrol kirin, sehî kirin de kullanılır. [FB]: çavdêrî n.f. Gözlem ve izleme için özgün Kurmancî form.",
   her:["Çavdêrî dike.", "Em çavdêrî dikin."], gen:["Çavdêrî û lêkolîn", "Çavdêrî bike."]),

  // ─────────────────────────────────────────────────────────────
  // MEDYA VE İLETİŞİM GENİŞLEME
  // ─────────────────────────────────────────────────────────────

  (id:"b2_240", ku:"Têkilî kirin", tr:"İletişim kurmak", en:"To communicate / contact",
   cins:"bêcins", ez:null, kat:"medya", zor:0.70,
   not:"\"Têkilî kirin\" — [FB]: têkilî n.f. + kirin. \"Têkilî daynin\" de kullanılır.",
   her:["Bi me re têkilî bikin.", "Têkilî kir."], gen:["Têkilî û ragihandin", "Têkilî bike."]),

  (id:"b2_241", ku:"Weşan", tr:"Yayın / Baskı", en:"Publication / Broadcast",
   cins:"mê", ez:"weşanê", kat:"medya", zor:0.70,
   not:"Dişil — \"weşandin\" (yayınlamak) kökünden. [FB]: weşan n.f. \"Weşana pirtûkê\" = kitabın yayımı.",
   her:["Weşan hat.", "Weşana kovarê."], gen:["Weşan û kovar", "Weşana me"]),

  (id:"b2_242", ku:"Weşandin", tr:"Yayımlamak", en:"To publish / broadcast",
   cins:"bêcins", ez:null, kat:"medya", zor:0.69,
   not:"\"Weşandin\" geçişli → ergatif. \"Min pirtûk weşand\" = kitabı yayımladım.",
   her:["Min pirtûk weşand.", "Kovar weşandine."], gen:["Weşandin û nivîsîn", "Min weşand."]),

  (id:"b2_243", ku:"Agahî", tr:"Bilgi / Enformasyon", en:"Information",
   cins:"mê", ez:"agahiyê", kat:"medya", zor:0.71,
   not:"Dişil — [FB]: agahî n.f. \"Agahiyên baş\" = iyi bilgiler.",
   her:["Agahî lazim e.", "Agahiya baş."], gen:["Agahî û nûçe", "Agahiya me"]),

  // ─────────────────────────────────────────────────────────────
  // HUKUK VE YÖNETİM
  // ─────────────────────────────────────────────────────────────

  (id:"b2_250", ku:"Destûr", tr:"Anayasa / İzin", en:"Constitution / Permission",
   cins:"nêr", ez:"destûrê", kat:"zagon", zor:0.69,
   not:"Eril — [FB]: destûr n.m. \"Destûra bingehîn\" = anayasa. Aynı zamanda \"izin\" anlamı.",
   her:["Destûr heye.", "Destûra welêt."], gen:["Destûr û zagon", "Destûra me"]),

  (id:"b2_251", ku:"Dadgeh", tr:"Mahkeme", en:"Court",
   cins:"mê", ez:"dadgehê", kat:"zagon", zor:0.70,
   not:"Dişil — \"dad\" (adalet) + \"-geh\" (yer). [BH] §274. \"Li dadgehê\" = mahkemede.",
   her:["Dadgeh biryar da.", "Li dadgehê ne."], gen:["Dadgeh û zagon", "Dadgeha me"]),

  (id:"b2_252", ku:"Biryara dadgehê", tr:"Mahkeme kararı", en:"Court verdict",
   cins:"mê", ez:"biryarê", kat:"zagon", zor:0.68,
   not:"\"Biryara dadgehê\" = mahkeme kararı. \"Biryar standin\" = karar almak.",
   her:["Biryara dadgehê hat.", "Biryar da."], gen:["Biryar û zagon", "Biryara dadgehê"]),

  (id:"b2_253", ku:"Ceza", tr:"Ceza", en:"Punishment / Penalty",
   cins:"mê", ez:"cezayê", kat:"zagon", zor:0.70,
   not:"Dişil — [FB]: ceza n.f. [Türkçe/Arapça]. \"Cezaya giran\" = ağır ceza.",
   her:["Ceza hate dan.", "Ceza û maf."], gen:["Ceza û xelat", "Cezaya me"]),

  // ─────────────────────────────────────────────────────────────
  // MODERNLEŞME VE KÜRESELLEŞME
  // ─────────────────────────────────────────────────────────────

  (id:"b2_260", ku:"Cîhanîbûn", tr:"Küreselleşme", en:"Globalization",
   cins:"mê", ez:"cîhanîbûnê", kat:"soyut", zor:0.67,
   not:"Dişil — \"cîhan\" (dünya) + \"-îbûn\" (olma süreci). Kurmancî özgün terim. \"Globalîzasyon\" da kullanılır (uluslararası). \"Cîhanîbûn û ziman\" = küreselleşme ve dil.",
   her:["Globalîzasyon ziman dixe xeterê.", "Globalîzasyon û çand."], gen:["Globalîzasyon û nasname", "Globalîzasyona me"]),

  (id:"b2_261", ku:"Nûgerî", tr:"Modernizm / Yenilikçilik", en:"Modernism",
   cins:"mê", ez:"nûgeriyê", kat:"soyut", zor:0.67,
   not:"Dişil — \"nû\" (yeni) + \"-gerî\" (yönelim). Kurmancî özgün terim. \"Modernîzm\" de kullanılır. \"Nûgeriya kurdî\" = Kürt modernizmi.",
   her:["Modernîzm û kevneşopî.", "Di modernîzmê de."], gen:["Modernîzm û çand", "Modernîzma me"]),

  (id:"b2_262", ku:"Dîjîtal", tr:"Dijital", en:"Digital",
   cins:"bêcins", ez:null, kat:"teknoloji", zor:0.70,
   not:"\"Dîjîtal\" = dijital. \"Ziman di dîjîtalê de\" = dijital ortamda dil.",
   her:["Pirtûkxaneyê dîjîtal.", "Dîjîtal û çap."], gen:["Dîjîtal û tradicyonel", "Dîjîtal"]),

  (id:"b2_263", ku:"Mîrasa çandî", tr:"Kültürel miras", en:"Cultural heritage",
   cins:"mê", ez:"mîrasê", kat:"çand", zor:0.69,
   not:"\"Mîras\" (miras) + \"çandî\" (kültürel). [FB]: mîras n.f.",
   her:["Mîrasa çandî ya kurdî.", "Mîras biparêze!"], gen:["Mîras û çand", "Mîrasa me"]),

  // ─────────────────────────────────────────────────────────────
  // COĞRAFYA VE TARİH
  // ─────────────────────────────────────────────────────────────

  (id:"b2_270", ku:"Firat", tr:"Fırat (nehri)", en:"Euphrates river",
   cins:"mê", ez:"Firatê", kat:"cografî", zor:0.70,
   not:"Dişil — tarihî Kürt nehri. \"Dicle û Firat\" = iki büyük nehir.",
   her:["Firat ji Kurdistanê diherike.", "Dicle û Firat."], gen:["Firat û Dicle", "Li Firatê"]),

  (id:"b2_271", ku:"Mezopotamya", tr:"Mezopotamya", en:"Mesopotamia",
   cins:"mê", ez:"Mezopotamyayê", kat:"cografî", zor:0.70,
   not:"Dişil — tarihî coğrafi terim. \"Mezopotamyaya jor\" = Yukarı Mezopotamya = tarihî Kürdistan.",
   her:["Mezopotamya dîrokê ye.", "Di Mezopotamyayê de."], gen:["Mezopotamya û Kurdistan", "Mezopotamyaya me"]),

  (id:"b2_272", ku:"Bakur", tr:"Kuzey", en:"North",
   cins:"nêr", ez:"bakurê", kat:"cografî", zor:0.72,
   not:"Eril — [FB]: bakur n.m. \"Bakurê Kurdistanê\" = Kuzey Kürdistan (Türkiye).",
   her:["Bakurê Kurdistanê.", "Li bakur in."], gen:["Bakur û başûr", "Bakurê Kurdistan"]),

  (id:"b2_273", ku:"Başûr", tr:"Güney", en:"South",
   cins:"nêr", ez:"başûrê", kat:"cografî", zor:0.72,
   not:"Eril — [FB]: başûr n.m. \"Başûrê Kurdistanê\" = Güney Kürdistan (Irak).",
   her:["Başûrê Kurdistanê.", "Li başûr in."], gen:["Başûr û bakur", "Başûrê Kurdistan"]),

  (id:"b2_274", ku:"Rojava", tr:"Batı / Rojava", en:"West / Rojava",
   cins:"mê", ez:"Rojava", kat:"cografî", zor:0.71,
   not:"Dişil — \"roj\" (gün/güneş) + \"ava\" (batı yönü). \"Rojavaya Kurdistanê\" = Batı Kürdistan (Suriye).",
   her:["Rojavaya Kurdistanê.", "Li Rojava ne."], gen:["Rojava û Bakur", "Rojavaya Kurdistan"]),

  (id:"b2_275", ku:"Rojhilat", tr:"Doğu", en:"East",
   cins:"nêr", ez:"Rojhilatê", kat:"cografî", zor:0.71,
   not:"Eril — \"roj\" (güneş) + \"hilat\" (doğu). \"Rojhilatê Kurdistanê\" = Doğu Kürdistan (İran).",
   her:["Rojhilatê Kurdistanê.", "Li Rojhilat in."], gen:["Rojhilat û Rojava", "Rojhilatê Kurdistan"]),

  // ─────────────────────────────────────────────────────────────
  // SANAT VE PERFORMANS
  // ─────────────────────────────────────────────────────────────

  (id:"b2_280", ku:"Şano", tr:"Tiyatro / Sahne", en:"Theatre / Stage",
   cins:"nêr", ez:"şanoyê", kat:"huner", zor:0.68,
   not:"Eril — [FB]: şano n.m. \"Şanoya kurdî\" = Kürt tiyatrosu.",
   her:["Şano hat.", "Di şanoyê de."], gen:["Şano û muzîk", "Şanoya me"]),

  (id:"b2_281", ku:"Dans kirin", tr:"Dans etmek", en:"To dance",
   cins:"bêcins", ez:null, kat:"huner", zor:0.71,
   not:"\"Dans kirin\" fiili. \"Govend\" = Kürt halk dansı. \"Govend girtin\" = halaya durmak.",
   her:["Em dans dikin.", "Govend girtin."], gen:["Dans û muzîk", "Govend bigire!"]),

  (id:"b2_282", ku:"Govend", tr:"Halav / Kürt halk dansı", en:"Kurdish circle dance",
   cins:"mê", ez:"govendê", kat:"huner", zor:0.72,
   not:"Dişil — [FB]: govend n.f. \"Govend girtin\" = halkaya katılmak. Kürt kültürünün merkezi.",
   her:["Govend xweş e!", "Em govend digirin."], gen:["Govend û stran", "Govendê me"]),

  (id:"b2_283", ku:"Bijarte", tr:"Seçkin / Önde gelen", en:"Elite / Selected",
   cins:"bêcins", ez:null, kat:"soyut", zor:0.67,
   not:"\"Bijarte\" — \"bijêrin\" (seçmek) + \"-te\" pasif sıfat. [FB]: bijarte adj.",
   her:["Bijarteyên me.", "Bijarte bûn."], gen:["Bijarte û resen", "Bijarteyên me"]),

];


// KAYNAK DOĞRULAMA NOTU — B2
// Ergatif anlaşma: [BH] §178 — bölgesel varyant uyarısı eklendi
// Pasif yapı: [BH] §193 + [TH] §82
// Bileşik fiiller: [FB] compound verbs
// "Keskesor": [BH] p.277 dişil ✓ (B1'den miras)
// "Cîhan": [FB] n.m. eril ✓
// "Civak": [FB] n.m. eril ✓
// "Gurbet": [FB] n.m. eril ✓
// "Zagon" + "Maf" = doğru Kurmancî hukuk terimleri [BH+FB] ✓


// ════════════════════════════════════════════════════════════════
// B2 EK KELİMELER — İkinci Kısım (+200 kelime)
// ════════════════════════════════════════════════════════════════

final kB2EkKelimeler2 = [

  // ── PASIF YAPILAR İÇİN ÖZGÜN KELİMELER ───────────────────
  (id:"b2_300", ku:"Ragihandin", tr:"Açıklamak / Bildirmek", en:"To announce / inform",
   cins:"bêcins", ez:null, kat:"medya", zor:0.70,
   not:"\"Ragihandin\" — geçişli. Pasif: \"hate ragihandin\" = açıklandı.",
   her:["Wî ragihand.", "Hate ragihandin."],
   gen:["Ragihandin û pirsîn", "Hate ragihandin."]),

  (id:"b2_301", ku:"Şibandin", tr:"Benzetmek", en:"To compare / liken",
   cins:"bêcins", ez:null, kat:"edebiyat", zor:0.68,
   not:"\"Şibandin\" — [FB]: şibandin v. Edebi dilde benzetme.",
   her:["Şair dilê xwe bi bilbil şiband.", "Xanî Kurdistan bi baxçe şiband."],
   gen:["Şibandin û qiyaskirin", "Bi...re şiband."]),

  (id:"b2_302", ku:"Vegêran", tr:"Aktarım / Geçiş", en:"Transfer / Transmission",
   cins:"nêr", ez:"vegêranê", kat:"edebiyat", zor:0.67,
   not:"Eril — \"vegêrin\" (aktarmak) kökünden. Kültürel aktarım kavramı.",
   her:["Vegêrana çandî.", "Vegêrana zimanê."],
   gen:["Vegêran û parastin", "Vegêrana zimanî"]),

  (id:"b2_303", ku:"Pêşgotin", tr:"Önsöz / Girişi söz", en:"Preface / Foreword",
   cins:"mê", ez:"pêşgotinê", kat:"edebiyat", zor:0.69,
   not:"Dişil — [FB]: pêşgotin n.f. \"Pêşgotina Mem û Zîn\" = Xanî'nin önsözü.",
   her:["Min pêşgotin xwend.", "Di pêşgotinê de..."],
   gen:["Pêşgotin û encam", "Pêşgotina Xanî"]),

  (id:"b2_304", ku:"Analîtîk", tr:"Analitik", en:"Analytical",
   cins:"bêcins", ez:null, kat:"felsefe", zor:0.66,
   not:"[FB]: analîtîk adj. \"Nêrîna analîtîk\" = analitik bakış.",
   her:["Nêrîna analîtîk.", "Bi awayek analîtîk."],
   gen:["Analîtîk û sentez", "Nêrîna analîtîk"]),

  (id:"b2_305", ku:"Sîstematîk", tr:"Sistematik", en:"Systematic",
   cins:"bêcins", ez:null, kat:"felsefe", zor:0.66,
   not:"[FB]: sîstematîk adj.",
   her:["Bi awayek sîstematîk.", "Lêkolîna sîstematîk."],
   gen:["Sîstematîk û random", "Awayekî sîstematîk"]),

  // ── GAZETE DİLİ ───────────────────────────────────────────
  (id:"b2_310", ku:"Li gorî çavkaniyên fermî", tr:"Resmi kaynaklara göre",
   en:"According to official sources",
   cins:"bêcins", ez:null, kat:"medya", zor:0.66,
   not:"Gazete kalıbı. \"Li gorî\" + \"çavkaniyên fermî\".",
   her:["Li gorî çavkaniyên fermî...", "Li gorî xebera fermî."],
   gen:["Li gorî çavkaniyên fermî", "Li gorî axaftinê"]),

  (id:"b2_311", ku:"Raportkirin", tr:"Rapor etmek", en:"To report",
   cins:"bêcins", ez:null, kat:"medya", zor:0.67,
   not:"\"Rapor kirin\" — gazete dilinde. \"Nûçegiran raport kir.\"",
   her:["Nûçegiran raport kir.", "Hate raporkirin."],
   gen:["Raporkirin û ragihandin", "Hate raporkirin."]),

  (id:"b2_312", ku:"Têgihîştin", tr:"Kavramak / İdrak etmek", en:"To comprehend",
   cins:"bêcins", ez:null, kat:"felsefe", zor:0.67,
   not:"\"Têgihîştin\" — \"tê\" + \"gihîştin\". [FB]: têgihîştin v.",
   her:["Min têgihîşt.", "Zehmet e têgihêjîm."],
   gen:["Têgihîştin û fêm kirin", "Min têgihîşt."]),

  (id:"b2_313", ku:"Pênasekirin", tr:"Tanımlamak", en:"To define",
   cins:"bêcins", ez:null, kat:"felsefe", zor:0.66,
   not:"\"Pênase kirin\" — [FB]: pênase n.f. + kirin.",
   her:["Pênase bike!", "Min pênase kir."],
   gen:["Pênasekirin û analîz", "Pênase bike!"]),

  (id:"b2_314", ku:"Pênase", tr:"Tanım / Definisyon", en:"Definition",
   cins:"mê", ez:"pênasê", kat:"felsefe", zor:0.67,
   not:"Dişil — [FB]: pênase n.f.",
   her:["Pênasa vê yekê çi ye?", "Pênaseyek baş bide."],
   gen:["Pênase û teorî", "Pênaseya rast"]),

  // ── EDEBIYAT DERİN ────────────────────────────────────────
  (id:"b2_320", ku:"Kilam", tr:"Türkü / Şarkı", en:"Song / Folk tune",
   cins:"mê", ez:"kilamê", kat:"edebiyat", zor:0.72,
   not:"Dişil — [FB]: kilam n.f. \"Kilama dengbêjan\" = dengbêj türküsü.",
   her:["Kilama Kurdistanê xweş e.", "Dengbêj kilam got."],
   gen:["Kilam û stran", "Kilamên me"]),

  (id:"b2_321", ku:"Rêzefîlm", tr:"Dizi", en:"TV Series",
   cins:"nêr", ez:"rêzefîlmê", kat:"medya", zor:0.69,
   not:"Eril — \"rêze\" (seri) + \"fîlm\". Kürtçe yayıncılık.",
   her:["Rêzefîlma kurdî tê.", "Rêzefîlm temaşe kirin."],
   gen:["Rêzefîlm û fîlm", "Rêzefîlmê me"]),

  (id:"b2_322", ku:"Belgefilm", tr:"Belgesel", en:"Documentary",
   cins:"nêr", ez:"belgefilmê", kat:"medya", zor:0.69,
   not:"Eril — \"belge\" + \"film\". Kürt belgeselleri artan öneme sahip.",
   her:["Belgefilmek li ser Kurdistanê.", "Belgefilm kêrhatî ye."],
   gen:["Belgefilm û rêzefîlm", "Belgefilmê kurdî"]),

  (id:"b2_323", ku:"Vegêrîn", tr:"Geri dönmek", en:"To return",
   cins:"bêcins", ez:null, kat:"leker", zor:0.70,
   not:"\"Vegêrîn\" — [AS] no.992: \"geri dönmek = vegerîn\" ✓.",
   her:["Vegerîm!", "Hasan vegeriya welatê xwe."],
   gen:["Vegêrîn û çûn", "Vegerî!"]),

  // ── HUKUK VE YÖNETİM TAM ──────────────────────────────────
  (id:"b2_330", ku:"Parlamento", tr:"Parlamento", en:"Parliament",
   cins:"nêr", ez:"parlamentoyê", kat:"siyaset", zor:0.70,
   not:"Eril — uluslararası terim.",
   her:["Parlamento biryar da.", "Di parlamentoyê de nîqaş bû."],
   gen:["Parlamento û hikûmet", "Parlamentoya Kurdistanê"]),

  (id:"b2_331", ku:"Serok", tr:"Başkan / Lider", en:"President / Leader",
   cins:"nêr", ez:"serokê", kat:"siyaset", zor:0.73,
   not:"Eril — [FB]: serok n.m. \"Serokê me\" = liderimiz.",
   her:["Serok axivî.", "Serokê nû hat."],
   gen:["Serok û wezîr", "Serokê me"]),

  (id:"b2_332", ku:"Hikûmet", tr:"Hükümet", en:"Government",
   cins:"mê", ez:"hikûmetê", kat:"siyaset", zor:0.72,
   not:"Dişil — [FB]: hikûmet n.f. [Arapça].",
   her:["Hikûmet biryar da.", "Hikûmeta nû."],
   gen:["Hikûmet û parlamento", "Hikûmeta me"]),

  (id:"b2_333", ku:"Maf", tr:"Hak", en:"Right",
   cins:"nêr", ez:"mafê", kat:"zagon", zor:0.73,
   not:"Eril — [FB]: maf n.m. \"Mafên mirovan\" = insan hakları.",
   her:["Mafê me ye!", "Mafên mirovan biparêzin."],
   gen:["Maf û peywir", "Mafên me"]),

  (id:"b2_334", ku:"Peywir", tr:"Görev / Sorumluluk", en:"Duty / Responsibility",
   cins:"mê", ez:"peywirê", kat:"zagon", zor:0.70,
   not:"Dişil — [FB]: peywir n.f.",
   her:["Peywira me ye.", "Peywirê xwe bîr neke."],
   gen:["Peywir û maf", "Peywira me"]),

  (id:"b2_335", ku:"Yasax", tr:"Yasaklama", en:"Ban / Prohibition",
   cins:"mê", ez:"yasaxê", kat:"zagon", zor:0.70,
   not:"Dişil — \"yasax kirin\" = yasaklamak. \"Qedexe\" de kullanılır.",
   her:["Yasax hate kirin.", "Yasaxa zimanî."],
   gen:["Yasax û azadî", "Yasaxa zimanê"]),

  // ── FELSEFİ KAVRAMLAR TAM ─────────────────────────────────
  (id:"b2_340", ku:"Mebest", tr:"Niyet / Amaç", en:"Intent / Purpose",
   cins:"nêr", ez:"mebestê", kat:"felsefe", zor:0.69,
   not:"Eril — [FB]: mebest n.m. \"Mebesta te çi ye?\" = amacın ne?",
   her:["Mebesta min baş e.", "Mebest û armancê."],
   gen:["Mebest û armanc", "Mebesta min"]),

  (id:"b2_341", ku:"Wateyî", tr:"Anlamlı", en:"Meaningful",
   cins:"bêcins", ez:null, kat:"felsefe", zor:0.68,
   not:"\"Wate\" (anlam) + \"-yî\". [FB]: wateyî adj.",
   her:["Jiyana wateyî.", "Ev wateyî ye."],
   gen:["Wateyî û bêwate", "Jiyana wateyî"]),

  (id:"b2_342", ku:"Bêwate", tr:"Anlamsız", en:"Meaningless",
   cins:"bêcins", ez:null, kat:"felsefe", zor:0.67,
   not:"\"Bê\" + \"wate\". [FB]: bêwate adj.",
   her:["Ev bêwate ye.", "Jiyana bêwate."],
   gen:["Bêwate û wateyî", "Ev bêwate ye."]),

  (id:"b2_343", ku:"Hevgirtin", tr:"Dayanışma / Birliktelik", en:"Solidarity",
   cins:"mê", ez:"hevgirtinê", kat:"civakî", zor:0.69,
   not:"Dişil — \"hev\" + \"girtin\". [FB]: hevgirtin n.f.",
   her:["Hevgirtina me.", "Bi hevgirtinê pêş dikevin."],
   gen:["Hevgirtin û cudabûn", "Hevgirtina me"]),

  // ── KÜRT KÜLTÜRÜ TAM ──────────────────────────────────────
  (id:"b2_350", ku:"Dengbêjî", tr:"Dengbêjlik sanatı", en:"Art of dengbêj",
   cins:"mê", ez:"dengbêjiyê", kat:"çand", zor:0.70,
   not:"Dişil — \"dengbêj\" + \"-î\". Kürt sözlü geleneğinin adı.",
   her:["Dengbêjî zindî ye.", "Dengbêjîya kurdî."],
   gen:["Dengbêjî û stranbêjî", "Dengbêjîya me"]),

  (id:"b2_351", ku:"Stranbêjî", tr:"Şarkıcılık / Müzisyenlik", en:"Singing / Musicianship",
   cins:"mê", ez:"stranbêjiyê", kat:"çand", zor:0.69,
   not:"Dişil — \"stran\" + \"bêj\" + \"-î\".",
   her:["Stranbêjî ji dengbêjiyê cuda ye.", "Stranbêjîya kurdî."],
   gen:["Stranbêjî û dengbêjî", "Stranbêjîya me"]),

  (id:"b2_352", ku:"Wêjezan", tr:"Edebiyatçı", en:"Literary scholar",
   cins:"bêcins", ez:"wêjezanê", kat:"edebiyat", zor:0.67,
   not:"\"Wêje\" (edebiyat) + \"-zan\". [BH] §273: -zan soneki.",
   her:["Ew wêjezan e.", "Wêjezanên kurd."],
   gen:["Wêjezan û zimanzan", "Wêjezanên me"]),

  (id:"b2_353", ku:"Nîvromak", tr:"Roman (edebi tür)", en:"Novel",
   cins:"nêr", ez:"nîvromakê", kat:"edebiyat", zor:0.67,
   not:"Eril — Kurmancîde \"roman\" da kullanılır.",
   her:["Min nîvromak xwend.", "Nîvromakên kurdî."],
   gen:["Nîvromak û helbest", "Nîvromakên kurdî"]),

  // ── AKADEMIK KELİMELER ────────────────────────────────────
  (id:"b2_360", ku:"Lêkolîner", tr:"Araştırmacı", en:"Researcher",
   cins:"bêcins", ez:"lêkolînerê", kat:"perwerde", zor:0.69,
   not:"\"Lêkolîn\" + \"-er\". [FB]: lêkolîner n.",
   her:["Ew lêkolîner e.", "Lêkolînerên kurd."],
   gen:["Lêkolîner û zimanzanê", "Lêkolînerên me"]),

  (id:"b2_361", ku:"Konferanse", tr:"Konferans", en:"Conference",
   cins:"mê", ez:"konferansê", kat:"perwerde", zor:0.69,
   not:"Dişil — uluslararası terim.",
   her:["Di konferansê de axivî.", "Konferansa kurdî."],
   gen:["Konferanse û semînar", "Konferansa me"]),

  (id:"b2_362", ku:"Semînar", tr:"Seminer", en:"Seminar",
   cins:"nêr", ez:"semînarê", kat:"perwerde", zor:0.69,
   not:"Eril — uluslararası terim.",
   her:["Semînar baş bû.", "Di semînarê de ne."],
   gen:["Semînar û konferanse", "Semînarê me"]),

  (id:"b2_363", ku:"Destûr û zagon", tr:"Anayasa ve kanun", en:"Constitution and law",
   cins:"bêcins", ez:null, kat:"zagon", zor:0.68,
   not:"\"Destûr\" (anayasa) + \"û\" + \"zagon\" (kanun). B2 hukuk söylemi.",
   her:["Destûr û zagon divê bên rêzkirin.", "Li gorî destûr û zagon."],
   gen:["Destûr û zagon", "Destûra bingehîn"]),

  // ── DIASPORA VE KİMLİK TAM ────────────────────────────────
  (id:"b2_370", ku:"Vatanperwer", tr:"Vatansever", en:"Patriotic",
   cins:"bêcins", ez:"vatanperwer", kat:"kimlik", zor:0.68,
   not:"\"Welat\" Kurmancî — \"welatperwer\" daha özgün ama \"vatanperwer\" yaygın.",
   her:["Ew welatperwer e.", "Welatperwer bin!"],
   gen:["Welatperwer û wefadar", "Welatperwer"]),

  (id:"b2_371", ku:"Welatperwer", tr:"Vatansever (özgün)", en:"Patriot",
   cins:"bêcins", ez:null, kat:"kimlik", zor:0.69,
   not:"\"Welat\" + \"-perwer\" (seven). Kurmancî özgün form.",
   her:["Ew welatperwer e.", "Welatperwer û azad."],
   gen:["Welatperwer û koçber", "Welatperwer"]),

  (id:"b2_372", ku:"Asîmîlasyon", tr:"Asimilasyon", en:"Assimilation",
   cins:"mê", ez:"asîmîlasyonê", kat:"kimlik", zor:0.68,
   not:"Dişil — uluslararası terim. \"Têkçûn\" Kurmancî karşılığı.",
   her:["Asîmîlasyon ziyan dide.", "Li hemberî asîmîlasyonê."],
   gen:["Asîmîlasyon û têkçûn", "Li hemberî asîmîlasyonê"]),

  (id:"b2_373", ku:"Têkçûn", tr:"Asimilasyon / Erime", en:"Assimilation (loss of identity)",
   cins:"mê", ez:"têkçûnê", kat:"kimlik", zor:0.68,
   not:"\"Têk\" (bütün) + \"çûn\" (gitmek). Kimlik kaybı için Kurmancî özgün terim.",
   her:["Têkçûna zimanî gelek e.", "Li hemberî têkçûnê."],
   gen:["Têkçûn û parastin", "Têkçûna zimanî"]),

  // ── ÇEVRE VE EKOLOJİ ──────────────────────────────────────
  (id:"b2_380", ku:"Guhertina avhewayê", tr:"İklim değişikliği", en:"Climate change",
   cins:"mê", ez:"guhertinê", kat:"ekoloji", zor:0.67,
   not:"\"Guhertin\" (değişim) + \"avhewayê\" (iklimin).",
   her:["Guhertina avhewayê pirsgirêkeke mezin e.", "Li hemberî guhertina avhewayê."],
   gen:["Guhertina avhewayê", "Avhewa û ekolojî"]),

  (id:"b2_381", ku:"Avhewa", tr:"İklim", en:"Climate",
   cins:"mê", ez:"avhewayê", kat:"ekoloji", zor:0.69,
   not:"Dişil — \"av\" + \"hewa\". [FB]: avhewa n.f.",
   her:["Avhewa guheriye.", "Avhewaya Kurdistan."],
   gen:["Avhewa û jîngeh", "Avhewaya me"]),

  (id:"b2_382", ku:"Xwezayî", tr:"Doğal", en:"Natural",
   cins:"bêcins", ez:null, kat:"ekoloji", zor:0.70,
   not:"\"Xweza\" + \"-yî\". [FB]: xwezayî adj.",
   her:["Tiştên xwezayî.", "Bi awayek xwezayî."],
   gen:["Xwezayî û sûnî", "Awayekî xwezayî"]),

  (id:"b2_383", ku:"Qirêjahî", tr:"Kirlilik / Çevre kirliliği", en:"Pollution",
   cins:"mê", ez:"qirêjahiyê", kat:"ekoloji", zor:0.68,
   not:"Dişil — \"qirêj\" + \"-ahî\". [BH] §275.",
   her:["Qirêjahîya avê.", "Qirêjahî zêde dibe."],
   gen:["Qirêjahî û paqijî", "Qirêjahîya bajêr"]),

  // ── ARAP VE KÜRT İLİŞKİLERİ BAĞLAMI ─────────────────────
  (id:"b2_390", ku:"Mezopotamya", tr:"Mezopotamya", en:"Mesopotamia",
   cins:"mê", ez:"Mezopotamyayê", kat:"dîrok", zor:0.70,
   not:"\"Di Mezopotamyayê de\" — tarihî Kürdistan coğrafyasında.",
   her:["Mezopotamya xwedî dîroka dûr û dirêj e.", "Ji Mezopotamyayê ve."],
   gen:["Mezopotamya û Kurdistan", "Dîroka Mezopotamyayê"]),

  (id:"b2_391", ku:"Êzdî", tr:"Ezidi / Yezidi", en:"Yazidi",
   cins:"bêcins", ez:null, kat:"dîrok", zor:0.69,
   not:"Êzdî = Kürdistan'ın kadim dinî topluluğu. Sincar (Şengal) merkezli.",
   her:["Êzdîyên Şengalê.", "Çanda Êzdîyan."],
   gen:["Êzdî û Kurd", "Êzdîyên me"]),

  (id:"b2_392", ku:"Êzidîtî", tr:"Ezidilik / Ezidi inancı", en:"Yezidism",
   cins:"mê", ez:"êzidîtiyê", kat:"dîrok", zor:0.67,
   not:"Dişil — \"Êzdî\" + \"-tî\". Kürdistan'ın en eski dinî geleneği.",
   her:["Êzidîtî kevneşopîyek e.", "Êzidîtî biparêzin."],
   gen:["Êzidîtî û Îslam", "Êzidîtîya me"]),

  // ── EK BAĞLAÇLAR VE ZARFLAR ───────────────────────────────
  (id:"b2_400", ku:"Weke mînak", tr:"Örneğin", en:"For example",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.72,
   not:"\"Weke mînak\" = örneğin. [FB]: mînak n.f.",
   her:["Weke mînak, Kurmancî.", "Weke mînak, Cegerxwîn."],
   gen:["Weke mînak", "Weke mînak bide"]),

  (id:"b2_401", ku:"Ji aliyekî ve", tr:"Bir yandan", en:"On one hand",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.69,
   not:"\"Ji aliyekî ve... ji aliyê din ve...\" = bir yandan... öte yandan...",
   her:["Ji aliyekî ve, ziman girîng e.", "Ji aliyekî ve û ji aliyê din ve."],
   gen:["Ji aliyekî ve", "Ji aliyê din ve"]),

  (id:"b2_402", ku:"Bi şêweyekî giştî", tr:"Genel olarak", en:"Generally speaking",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.68,
   not:"\"Bi şêweyekî giştî\" = genel olarak. Akademik kalıp.",
   her:["Bi şêweyekî giştî, ziman...", "Bi şêweyekî giştî baştir e."],
   gen:["Bi şêweyekî giştî", "Bi giştî"]),

  (id:"b2_403", ku:"Bi awayekî taybetî", tr:"Özellikle", en:"Particularly",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.68,
   not:"\"Bi awayekî taybetî\" = özellikle. Akademik ve gazete kalıbı.",
   her:["Bi awayekî taybetî zimanê kurdî.", "Bi awayekî taybetî girîng e."],
   gen:["Bi awayekî taybetî", "Bi taybetî"]),

];


// ════════════════════════════════════════════════════════════════
// B2 EK KELİMELER — Üçüncü Kısım (+180 kelime)
// Odak: Edebi eleştiri, gazete dili, felsefi tartışma,
//       diaspora kimliği, hukuk, dilbilim
// ════════════════════════════════════════════════════════════════

final kB2EkKelimeler3 = [

  // ── EDEBİ ELEŞTİRİ — B2 özgün ────────────────────────────
  (id:"b2_500", ku:"Naveroka vegotinê", tr:"Anlatının içeriği", en:"Narrative content",
   cins:"mê", ez:"naveroka vegotinê", kat:"edebiyat", zor:0.65,
   not:"\"Navrok\" (içerik) + \"vegotinê\" (anlatının).",
   her:["Naveroka vegotinê.", "Di naveroka vegotinê de."],
   gen:["Navrok û şêwe", "Naveroka vegotinê"]),

  (id:"b2_501", ku:"Dengê vegêr", tr:"Anlatıcı sesi", en:"Narrator voice",
   cins:"nêr", ez:"dengê vegêr", kat:"edebiyat", zor:0.64,
   not:"Edebi terim. \"Deng\" + \"vegêr\" (anlatan).",
   her:["Dengê vegêr yekem e.", "Di dengê vegêr de."],
   gen:["Dengê vegêr", "Dengê vegotinê"]),

  (id:"b2_502", ku:"Serdem", tr:"Dönem / Çağ", en:"Era / Period",
   cins:"mê", ez:"serdemê", kat:"edebiyat", zor:0.70,
   not:"Dişil — [FB]: serdem n.f. \"Serdema Xanî.\"",
   her:["Serdema Xanî.", "Di serdemê de."],
   gen:["Serdem û dîrok", "Serdema me"]),

  (id:"b2_503", ku:"Vegotina nû", tr:"Modern anlatı", en:"Modern narrative",
   cins:"mê", ez:"vegotina nû", kat:"edebiyat", zor:0.64,
   not:"\"Vegotin\" + \"nû\". Modern edebiyat kavramı.",
   her:["Vegotina nû.", "Di vegotina nû de."],
   gen:["Vegotina nû û kevn", "Vegotina nû"]),

  (id:"b2_504", ku:"Şaxê wêjeyê", tr:"Edebi dal / Tür", en:"Literary genre / Branch",
   cins:"nêr", ez:"şaxê wêjeyê", kat:"edebiyat", zor:0.64,
   not:"\"Şax\" (dal) + \"wêjeyê\" (edebiyatın).",
   her:["Şaxê wêjeyê çi ye?", "Di şaxê wêjeyê de."],
   gen:["Şax û tûr", "Şaxên wêjeyê"]),

  // ── GAZETE VE RESMİ DİL ───────────────────────────────────
  (id:"b2_510", ku:"Nûçegirî", tr:"Gazetecilik", en:"Journalism",
   cins:"mê", ez:"nûçegiriyê", kat:"medya", zor:0.68,
   not:"Dişil — \"nûçegir\" + \"-î\". [FB]: nûçegirî n.f.",
   her:["Nûçegirîya kurdî.", "Di nûçegiriyê de."],
   gen:["Nûçegirî û ragihandin", "Nûçegirîya kurdî"]),

  (id:"b2_511", ku:"Sernavê nûçeyê", tr:"Haber başlığı", en:"News headline",
   cins:"nêr", ez:"sernavê nûçeyê", kat:"medya", zor:0.66,
   not:"\"Sernav\" + \"nûçeyê\". Gazete formatı.",
   her:["Sernavê nûçeyê girîng e.", "Sernavê nûçeyê xwend."],
   gen:["Sernav û nûçe", "Sernavê nûçeyê"]),

  (id:"b2_512", ku:"Gotara siyasî", tr:"Siyasi makale", en:"Political article",
   cins:"mê", ez:"gotara siyasî", kat:"medya", zor:0.66,
   not:"\"Gotar\" + \"siyasî\". Gazete dilinde.",
   her:["Gotara siyasî xwend.", "Gotareke siyasî nivîsand."],
   gen:["Gotar û nûçe", "Gotara siyasî"]),

  (id:"b2_513", ku:"Edîtorî", tr:"Başyazı", en:"Editorial",
   cins:"mê", ez:"edîtoriyê", kat:"medya", zor:0.65,
   not:"Dişil — uluslararası terim.",
   her:["Edîtorîya kovarê.", "Edîtorî xwend."],
   gen:["Edîtorî û gotar", "Edîtorîya kovarê"]),

  (id:"b2_514", ku:"Rapora salane", tr:"Yıllık rapor", en:"Annual report",
   cins:"mê", ez:"rapora salane", kat:"medya", zor:0.65,
   not:"\"Rapor\" + \"salane\" (yıllık).",
   her:["Rapora salane hat.", "Rapora salaneyê xwend."],
   gen:["Rapor û gotar", "Rapora salane"]),

  // ── DİLBİLİM VE TERMINOLOJI ───────────────────────────────
  (id:"b2_520", ku:"Nûjenî", tr:"Yenilik / İnovasyon", en:"Innovation",
   cins:"mê", ez:"nûjeniyê", kat:"zanist", zor:0.68,
   not:"Dişil — \"nû\" + \"-jenî\". [FB]: nûjenî n.f.",
   her:["Nûjenîya zimanî.", "Nûjenî lazim e."],
   gen:["Nûjenî û kevneşopî", "Nûjenîya me"]),

  (id:"b2_521", ku:"Standardkirin", tr:"Standartlaştırma", en:"Standardization",
   cins:"mê", ez:"standardkirinê", kat:"ziman", zor:0.67,
   not:"Dişil — \"standard\" + \"kirin\" + \"-a isim\".",
   her:["Standardkirina zimanê kurdî.", "Standardkirin lazim e."],
   gen:["Standardkirin û devok", "Standardkirina ziman"]),

  (id:"b2_522", ku:"Têkstên nivîskî", tr:"Yazılı metinler", en:"Written texts",
   cins:"bêcins", ez:null, kat:"ziman", zor:0.66,
   not:"\"Têkst\" (metin) + \"nivîskî\" (yazılı).",
   her:["Têkstên nivîskî yên kurdî.", "Di têkstên nivîskî de."],
   gen:["Têkstên nivîskî û devkî", "Têkstên kurdî"]),

  (id:"b2_523", ku:"Devkî", tr:"Sözlü", en:"Oral",
   cins:"bêcins", ez:null, kat:"ziman", zor:0.68,
   not:"\"Dev\" (ağız) + \"-kî\". [FB]: devkî adj. \"Çanda devkî.\"",
   her:["Çanda devkî.", "Bi awayek devkî."],
   gen:["Devkî û nivîskî", "Çanda devkî"]),

  (id:"b2_524", ku:"Dîrokname", tr:"Tarihsel belge", en:"Historical document",
   cins:"mê", ez:"dîroknamê", kat:"dîrok", zor:0.65,
   not:"Dişil — \"dîrok\" + \"name\". Bileşik.",
   her:["Dîrokname girîng e.", "Dîroknameyê xwend."],
   gen:["Dîrokname û arşîv", "Dîroknameyên kurdî"]),

  // ── FELSEFİ VE ETİK TARTIŞMA ──────────────────────────────
  (id:"b2_530", ku:"Mafên mirovî", tr:"İnsan hakları", en:"Human rights",
   cins:"bêcins", ez:"mafên mirovî", kat:"zagon", zor:0.71,
   not:"\"Maf\" + \"mirovî\" (insani). B2'de temel tartışma konusu.",
   her:["Mafên mirovî biparêzin.", "Rêxistina mafên mirovî."],
   gen:["Mafên mirovî", "Mafên me"]),

  (id:"b2_531", ku:"Demokrasî", tr:"Demokrasi", en:"Democracy",
   cins:"mê", ez:"demokrasiyê", kat:"siyaset", zor:0.72,
   not:"Dişil — uluslararası terim.",
   her:["Demokrasî lazim e.", "Di demokrasiyê de."],
   gen:["Demokrasî û otoriter", "Demokrasîya me"]),

  (id:"b2_532", ku:"Pluralîzm", tr:"Çoğulculuk", en:"Pluralism",
   cins:"nêr", ez:"pluralîzmê", kat:"felsefe", zor:0.65,
   not:"Eril — uluslararası terim. \"Cihêrengî\" Kurmancî karşılığı.",
   her:["Pluralîzm û cihêrengî.", "Di pluralîzmê de."],
   gen:["Pluralîzm û yekgirtî", "Pluralîzma civakî"]),

  (id:"b2_533", ku:"Sekularîzm", tr:"Laiklik / Sekülarizm", en:"Secularism",
   cins:"nêr", ez:"sekularîzmê", kat:"felsefe", zor:0.65,
   not:"Eril — uluslararası terim.",
   her:["Sekularîzm û dîn.", "Di sekularîzmê de."],
   gen:["Sekularîzm û dîn", "Sekularîzmê civakî"]),

  (id:"b2_534", ku:"Nasnameya netewî", tr:"Ulusal kimlik", en:"National identity",
   cins:"mê", ez:"nasnameya netewî", kat:"kimlik", zor:0.68,
   not:"\"Nasname\" + \"netewî\". B2 kimlik tartışması merkezi.",
   her:["Nasnameya netewî ya kurd.", "Nasnameya netewî û civakî."],
   gen:["Nasnameya netewî", "Nasname û netewe"]),

  // ── DİASPORA VE POSTKOLONYEL ──────────────────────────────
  (id:"b2_540", ku:"Postkolonyalîzm", tr:"Postkolonyalizm", en:"Postcolonialism",
   cins:"nêr", ez:"postkolonyalîzmê", kat:"felsefe", zor:0.64,
   not:"Eril — akademik terim. Kürt çalışmalarında kullanılır.",
   her:["Postkolonyalîzm û Kurd.", "Di postkolonyalîzmê de."],
   gen:["Postkolonyalîzm û serbixwebûn", "Teorîya postkolonyalîzmê"]),

  (id:"b2_541", ku:"Têkoşîna ziman", tr:"Dil mücadelesi", en:"Language struggle",
   cins:"mê", ez:"têkoşîna ziman", kat:"kimlik", zor:0.68,
   not:"\"Têkoşîn\" + \"ziman\". Heritage öğrenicinin yaşadığı gerçeklik.",
   her:["Têkoşîna ziman dewam dike.", "Di têkoşîna zimanê de."],
   gen:["Têkoşîna ziman û azadî", "Têkoşîna zimanî"]),

  (id:"b2_542", ku:"Xwebûn", tr:"Benlik / Öz varlık", en:"Self-being / Identity",
   cins:"nêr", ez:"xwebûnê", kat:"kimlik", zor:0.67,
   not:"Eril — \"xwe\" + \"bûn\". Felsefi kimlik kavramı.",
   her:["Xwebûna kurdî.", "Di xwebûnê de."],
   gen:["Xwebûn û nasname", "Xwebûna me"]),

  (id:"b2_543", ku:"Bikarhêner", tr:"Kullanıcı", en:"User",
   cins:"bêcins", ez:"bikarhênerê", kat:"teknoloji", zor:0.69,
   not:"\"Bikar\" + \"hêner\". Dijital dünyada.",
   her:["Bikarhênerên malperê.", "Bikarhêner kî ne?"],
   gen:["Bikarhêner û çêker", "Bikarhênerên me"]),

  // ── TARİHSEL OLAYLAR VE KÜRT ──────────────────────────────
  (id:"b2_550", ku:"Berxwedan", tr:"Direniş", en:"Resistance",
   cins:"mê", ez:"berxwedanê", kat:"dîrok", zor:0.71,
   not:"Dişil — \"ber\" + \"xwedan\". [FB]: berxwedan n.f. Heritage: Newroz, Kobanê.",
   her:["Berxwedana Kobanê.", "Berxwedan berdewam dike."],
   gen:["Berxwedan û aştî", "Berxwedana me"]),

  (id:"b2_551", ku:"Qirkirin", tr:"Soykırım", en:"Genocide",
   cins:"nêr", ez:"qirkirinê", kat:"dîrok", zor:0.68,
   not:"Eril — \"qir kirin\" (yok etmek). Dêrsim, Êzidî, Halabja bağlamları.",
   her:["Qirkirin ne hatiye bîranîn.", "Qirkirina Halabcayê."],
   gen:["Qirkirin û hafiza", "Qirkirina dîrokî"]),

  (id:"b2_552", ku:"Felaketa dîrokî", tr:"Tarihi felaket", en:"Historical catastrophe",
   cins:"mê", ez:"felaketa dîrokî", kat:"dîrok", zor:0.66,
   not:"\"Felaket\" + \"dîrokî\". Kürt tarihinde travma ifadesi.",
   her:["Felaketa dîrokî ya Helebceyê.", "Felaketa dîrokî ji bîr nake."],
   gen:["Felaket û hafiza", "Felaketa dîrokî"]),

  (id:"b2_553", ku:"Hafizaya kolektîf", tr:"Kolektif bellek", en:"Collective memory",
   cins:"mê", ez:"hafizaya kolektîf", kat:"kimlik", zor:0.66,
   not:"\"Hafiza\" + \"kolektîf\". Sosyolojik kavram.",
   her:["Hafizaya kolektîfa kurdî.", "Di hafizaya kolektîf de."],
   gen:["Hafizaya kolektîf", "Hafizaya me"]),

  // ── SOYUT VE KAVRAMSAL ────────────────────────────────────
  (id:"b2_560", ku:"Çarçowe", tr:"Çerçeve / Bağlam", en:"Framework / Context",
   cins:"mê", ez:"çarçowê", kat:"felsefe", zor:0.67,
   not:"Dişil — [FB]: çarçowe n.f. \"Di çarçoweya...\", gazete.",
   her:["Di çarçoweya vê pirsê de.", "Çarçoweya teorîk."],
   gen:["Çarçowe û nêzîkatî", "Çarçoweya me"]),

  (id:"b2_561", ku:"Pêvajoya", tr:"Süreç", en:"Process",
   cins:"mê", ez:"pêvajoyê", kat:"felsefe", zor:0.68,
   not:"Dişil — [FB]: pêvajo n.f. \"Pêvajoya hînbûnê.\"",
   her:["Pêvajoya hînbûnê.", "Di pêvajoyê de."],
   gen:["Pêvajo û encam", "Pêvajoya me"]),

  (id:"b2_562", ku:"Hevsengî", tr:"Denge / Denge", en:"Balance / Equilibrium",
   cins:"mê", ez:"hevsengiyê", kat:"felsefe", zor:0.68,
   not:"Dişil — \"hev\" + \"sengî\". [FB]: hevsengî n.f.",
   her:["Hevsengî lazim e.", "Di hevsengiyê de."],
   gen:["Hevsengî û bêdengî", "Hevsengîya me"]),

  (id:"b2_563", ku:"Alîgirî", tr:"Taraflılık / Önyargı", en:"Bias / Partiality",
   cins:"mê", ez:"alîgiriyê", kat:"felsefe", zor:0.66,
   not:"Dişil — \"alî\" + \"girî\". [FB]: alîgirî n.f.",
   her:["Alîgirî çêbû.", "Bê alîgirî."],
   gen:["Alîgirî û bêalîgirî", "Alîgirîya me"]),

  // ── KELİME TÜRETİMİ — BH §270-280 ────────────────────────
  (id:"b2_570", ku:"-vanî/-tî pêşgir", tr:"-cılık/-çılık eki", en:"Occupational suffix",
   cins:"bêcins", ez:null, kat:"rêziman", zor:0.65,
   not:"[BH] §273: \"-vanî\" = uğraş eki. cotkarî, dengbêjî, stranbêjî...",
   her:["Cotkarî baş e.", "Stranbêjî û dengbêjî."],
   gen:["-vanî û -tî", "Pêşgirên -vanî"]),

  (id:"b2_571", ku:"-zan/-nas pêşgir", tr:"-bilimci eki", en:"Expertise suffix",
   cins:"bêcins", ez:null, kat:"rêziman", zor:0.65,
   not:"[BH] §273: \"-zan\" / \"-nas\" = bilen. zimanzan, rewanzanê, bijîşk...",
   her:["Zimanzan û zimanas.", "Pêşgira -zan."],
   gen:["-zan û -nas", "Pêşgirên -zan"]),

  (id:"b2_572", ku:"Peyvên tevhev", tr:"Bileşik kelimeler", en:"Compound words",
   cins:"bêcins", ez:"peyvên tevhev", kat:"rêziman", zor:0.67,
   not:"\"Peyvên tevhev\" = bileşik kelimeler. [BH] §270-275: türetme.",
   her:["Peyvên tevhev gelek in.", "Çawa peyvên tevhev çêdibin?"],
   gen:["Peyvên tevhev", "Bileşik peyvên kurdî"]),

  // ── İLERİ EDABİYAT ────────────────────────────────────────
  (id:"b2_580", ku:"Şaîrên klasîk", tr:"Klasik şairler", en:"Classical poets",
   cins:"bêcins", ez:"şaîrên klasîk", kat:"edebiyat", zor:0.68,
   not:"\"Şaîr\" (şair) + \"klasîk\". Xanî, Melayê Cizîrî, Feqiyê Teyran.",
   her:["Şaîrên klasîk.", "Ji şaîrên klasîk."],
   gen:["Şaîrên klasîk û nûjen", "Şaîrên kurdî"]),

  (id:"b2_581", ku:"Melayê Cizîrî", tr:"Mela (şair)", en:"Mela of Cizre (poet)",
   cins:"bêcins", ez:"Melayê Cizîrî", kat:"edebiyat", zor:0.69,
   not:"Kürt tasavvuf şiirinin öncüsü (1570-1640). Divana Mela.",
   her:["Melayê Cizîrî helbestvanê mezin e.", "Ji Melayê Cizîrî."],
   gen:["Mela û Xanî", "Divana Melayê Cizîrî"]),

  (id:"b2_582", ku:"Feqiyê Teyran", tr:"Feqi Teyran (şair)", en:"Feqi Teyran (poet)",
   cins:"bêcins", ez:"Feqiyê Teyran", kat:"edebiyat", zor:0.68,
   not:"Kürt halk şiiri geleneğinin kurucusu (1590-1660).",
   her:["Feqiyê Teyran dengbêjê mezin e.", "Ji Feqiyê Teyran."],
   gen:["Feqiyê Teyran û Mela", "Berhem Feqiyê Teyran"]),

  // ── B2 SÖZDİZİM KELİMELERİ ────────────────────────────────
  (id:"b2_590", ku:"Ji vî alî ve", tr:"Bu açıdan / Bu bakımdan", en:"From this perspective",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.67,
   not:"\"Ji vî alî ve\" = bu açıdan/bakımdan.",
   her:["Ji vî alî ve, ziman girîng e.", "Ji vî alî ve nêrîn."],
   gen:["Ji vî alî ve", "Ji aliyê din ve"]),

  (id:"b2_591", ku:"Bi kurtasî", tr:"Kısaca", en:"Briefly / In short",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.68,
   not:"\"Bi kurtasî\" = kısaca. [FB]: kurtasî adv.",
   her:["Bi kurtasî bibêje.", "Bi kurtasî, ziman..."],
   gen:["Bi kurtasî û bi dirêjasî", "Bi kurtasî"]),

  (id:"b2_592", ku:"Bi dirêjasî", tr:"Ayrıntılı / Geniş", en:"In detail / Extensively",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.67,
   not:"\"Bi dirêjasî\" = ayrıntılı biçimde.",
   her:["Bi dirêjasî şîrove bike.", "Bi dirêjasî lêkolîn kirin."],
   gen:["Bi dirêjasî û bi kurtasî", "Bi dirêjasî"]),

  (id:"b2_593", ku:"Bi taybetî jî", tr:"Özellikle de", en:"In particular also",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.66,
   not:"\"Bi taybetî\" + \"jî\" pekiştirici.",
   her:["Bi taybetî jî ziman.", "Bi taybetî jî girîng e."],
   gen:["Bi taybetî jî", "Bi taybetî û bi giştî"]),

];


final kB2EkKelimeler4 = [

  // ── İLERİ FİİL VE YAPILAR ─────────────────────────────────

  (id:"b2_700", ku:"Têxebatîn", tr:"Mücadele içinde çalışmak", en:"To work in struggle",
   cins:"bêcins", ez:null, kat:"leker", zor:0.65,
   not:"\"Tê\" + \"xebitîn\". Aktivizm bağlamı.",
   her:["Ji bo ziman têxebatîm.", "Em têxebatîn."],
   gen:["Têxebatîn û têkoşîn", "Ji bo ziman"]),

  (id:"b2_701", ku:"Bêhempa", tr:"Eşsiz / Benzersiz", en:"Unique / Unparalleled",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.67,
   not:"\"Bê\" + \"hempa\". [FB]: bêhempa adj.",
   her:["Dengbêjî bêhempa ye.", "Mîrasa bêhempa."],
   gen:["Bêhempa û asayî", "Ev bêhempa ye."]),

  (id:"b2_702", ku:"Nûjen", tr:"Modern / Çağdaş", en:"Modern / Contemporary",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.69,
   not:"\"Nû\" + \"-jen\". [FB]: nûjen adj.",
   her:["Wejeya nûjen.", "Bi awayek nûjen."],
   gen:["Nûjen û kevn", "Wejeya nûjen"]),

  (id:"b2_703", ku:"Xweser", tr:"Özerk / Bağımsız", en:"Autonomous",
   cins:"bêcins", ez:null, kat:"siyaset", zor:0.68,
   not:"\"Xwe\" + \"ser\". [FB]: xweser adj.",
   her:["Herêma xweser.", "Xweser be!"],
   gen:["Xweser û serbixwe", "Herêma xweser"]),

  (id:"b2_704", ku:"Xweserî", tr:"Özerklik", en:"Autonomy",
   cins:"mê", ez:"xweseriyê", kat:"siyaset", zor:0.68,
   not:"Dişil — \"xweser\" + \"-î\".",
   her:["Xweserîya Başûrê Kurdistanê.", "Di xweseriyê de."],
   gen:["Xweserî û serxwebûn", "Xweserîya me"]),

  (id:"b2_705", ku:"Serxwebûn", tr:"Bağımsızlık", en:"Independence",
   cins:"mê", ez:"serxwebûnê", kat:"siyaset", zor:0.69,
   not:"Dişil — \"serbixwe\" + \"bûn\". [FB]: serxwebûn n.f.",
   her:["Serxwebûna Kurdistanê.", "Di serxwebûnê de."],
   gen:["Serxwebûn û xweserî", "Serxwebûna me"]),

  // ── HUKUKİ VE SİYASİ DERİN ────────────────────────────────

  (id:"b2_710", ku:"Peymana navdewletî", tr:"Uluslararası anlaşma", en:"International treaty",
   cins:"mê", ez:"peymanê", kat:"zagon", zor:0.65,
   not:"\"Peymanê\" + \"navdewletî\". B2 hukuk söylemi.",
   her:["Peymanên navdewletî.", "Di peymana navdewletî de."],
   gen:["Peymanên navdewletî", "Peymana me"]),

  (id:"b2_711", ku:"Sazîyên navdewletî", tr:"Uluslararası kurumlar", en:"International institutions",
   cins:"bêcins", ez:"sazîyên navdewletî", kat:"siyaset", zor:0.65,
   not:"\"Sazî\" + \"navdewletî\". BM, AB gibi.",
   her:["Sazîyên navdewletî.", "Di sazîyên navdewletî de."],
   gen:["Sazîyên navdewletî", "Sazîyên me"]),

  (id:"b2_712", ku:"Nûnerîtî", tr:"Temsil / Temsilcilik", en:"Representation",
   cins:"mê", ez:"nûnerîtiyê", kat:"siyaset", zor:0.66,
   not:"Dişil — \"nûner\" + \"-îtî\". [FB]: nûnerîtî n.f.",
   her:["Nûnerîtiya kurdî.", "Di nûnerîtiyê de."],
   gen:["Nûnerîtî û azadî", "Nûnerîtîya me"]),

  (id:"b2_713", ku:"Nûner", tr:"Temsilci", en:"Representative",
   cins:"bêcins", ez:"nûnerê", kat:"siyaset", zor:0.69,
   not:"\"Nûner\" — [FB]: nûner n. \"Nûnerê gelê kurd.\"",
   her:["Nûner hat.", "Nûnerê gelê kurd."],
   gen:["Nûner û serok", "Nûnerê me"]),

  // ── KÜRT COĞRAFYASI VE TARİHİ ─────────────────────────────

  (id:"b2_720", ku:"Silêmanî", tr:"Süleymaniye", en:"Sulaymaniyah",
   cins:"mê", ez:"Silêmanî", kat:"cografî", zor:0.70,
   not:"Dişil — Başûrê Kurdistanê büyük şehri. Kürt kültürünün merkezi.",
   her:["Silêmanî bajarekî mezin e.", "Li Silêmanî ne."],
   gen:["Silêmanî û Hewlêr", "Li Silêmaniyê"]),

  (id:"b2_721", ku:"Hewlêr", tr:"Erbil", en:"Erbil / Hawler",
   cins:"mê", ez:"Hewlêrê", kat:"cografî", zor:0.70,
   not:"Dişil — Başûrê Kurdistanê başkenti. Kurmancî adı \"Hewlêr\".",
   her:["Hewlêr paytexta Herêma Kurdistanê ye.", "Li Hewlêrê ne."],
   gen:["Hewlêr û Silêmanî", "Li Hewlêrê"]),

  (id:"b2_722", ku:"Şingal", tr:"Sincar", en:"Sinjar",
   cins:"mê", ez:"Şingalê", kat:"cografî", zor:0.68,
   not:"Dişil — Êzdî Kürtlerinin yurdu. 2014 soykırımının yaşandığı yer.",
   her:["Şingal Êzdîyan e.", "Li Şingalê ne."],
   gen:["Şingal û Kobanê", "Berxwedana Şingalê"]),

  (id:"b2_723", ku:"Kirkûk", tr:"Kerkük", en:"Kirkuk",
   cins:"mê", ez:"Kirkûkê", kat:"cografî", zor:0.70,
   not:"Dişil — Petrol zengini Kürt şehri. \"Qudsê Kurdistanê.\"",
   her:["Kirkûk qulba Kurdistan e.", "Li Kirkûkê ne."],
   gen:["Kirkûk û Silêmanî", "Li Kirkûkê"]),

  // ── KAVRAMSAL VE FELSEFİ ──────────────────────────────────

  (id:"b2_730", ku:"Zanistê civakî", tr:"Sosyal bilimler", en:"Social sciences",
   cins:"bêcins", ez:"zanistê civakî", kat:"zanist", zor:0.67,
   not:"\"Zanist\" + \"civakî\". Akademik disiplin.",
   her:["Zanistê civakî girîng in.", "Di zanistê civakî de."],
   gen:["Zanistê civakî û xwezayî", "Zanistê civakî"]),

  (id:"b2_731", ku:"Tevger û bersiv", tr:"Eylem ve tepki", en:"Action and reaction",
   cins:"bêcins", ez:null, kat:"felsefe", zor:0.65,
   not:"\"Tevger\" (eylem) + \"bersiv\" (tepki). Sosyal teori kavramı.",
   her:["Tevger û bersiv.", "Di tevger û bersivê de."],
   gen:["Tevger û bersiv", "Tevger"]),

  (id:"b2_732", ku:"Navendîbûn", tr:"Merkezileşme", en:"Centralization",
   cins:"mê", ez:"navendîbûnê", kat:"siyaset", zor:0.65,
   not:"Dişil — \"navend\" + \"-îbûn\".",
   her:["Navendîbûn xetere ye.", "Li hemberî navendîbûnê."],
   gen:["Navendîbûn û xweserî", "Li hemberî navendîbûnê"]),

  (id:"b2_733", ku:"Dezgehên sivîl", tr:"Sivil kurumlar", en:"Civil institutions",
   cins:"bêcins", ez:"dezgehên sivîl", kat:"civakî", zor:0.65,
   not:"\"Dezgeh\" (kurum) + \"sivîl\".",
   her:["Dezgehên sivîl girîng in.", "Di dezgehên sivîlê de."],
   gen:["Dezgehên sivîl", "Dezgehên me"]),

  // ── İLETİŞİM VE DİYALOG ───────────────────────────────────

  (id:"b2_740", ku:"Axaftina yekalî", tr:"Tek taraflı konuşma", en:"One-sided speech",
   cins:"mê", ez:"axaftina yekalî", kat:"ziman", zor:0.64,
   not:"\"Axaftin\" + \"yekalî\". Retorik kavramı.",
   her:["Axaftina yekalî nayê qebûlkirin.", "Di axaftina yekalî de."],
   gen:["Axaftina yekalî û gotûbêj", "Axaftina yekalî"]),

  (id:"b2_741", ku:"Têgihîştina hevpar", tr:"Ortak anlayış", en:"Mutual understanding",
   cins:"mê", ez:"têgihîştina hevpar", kat:"ziman", zor:0.65,
   not:"\"Têgihîştin\" + \"hevpar\".",
   her:["Têgihîştina hevpar lazim e.", "Di têgihîştina hevpar de."],
   gen:["Têgihîştina hevpar", "Têgihîştina me"]),

  (id:"b2_742", ku:"Axaftina analîtîk", tr:"Analitik söylem", en:"Analytical discourse",
   cins:"mê", ez:"axaftina analîtîk", kat:"ziman", zor:0.64,
   not:"\"Axaftin\" + \"analîtîk\". B2 düzeyi akademik dil.",
   her:["Bi axaftina analîtîk.", "Axaftina analîtîk baş e."],
   gen:["Axaftina analîtîk", "Bi analîtîk"]),

  // ── EDEBİ VE KÜLTÜREL DERİN ───────────────────────────────

  (id:"b2_750", ku:"Berhemên folklorî", tr:"Folklor eserleri", en:"Folkloric works",
   cins:"bêcins", ez:"berhemên folklorî", kat:"çand", zor:0.67,
   not:"\"Berhem\" + \"folklorî\". Sözlü kültür mirası.",
   her:["Berhemên folklorî yên kurdî.", "Di berhemên folklorî de."],
   gen:["Berhemên folklorî", "Berhemên kurdî"]),

  (id:"b2_751", ku:"Vegotina dîrokî", tr:"Tarihsel anlatı", en:"Historical narrative",
   cins:"mê", ez:"vegotina dîrokî", kat:"edebiyat", zor:0.66,
   not:"\"Vegotin\" + \"dîrokî\".",
   her:["Vegotina dîrokî ya Kurdan.", "Di vegotina dîrokî de."],
   gen:["Vegotina dîrokî", "Vegotina me"]),

  (id:"b2_752", ku:"Pêkhatê çandî", tr:"Kültürel unsurlar", en:"Cultural elements",
   cins:"bêcins", ez:"pêkhatên çandî", kat:"çand", zor:0.66,
   not:"\"Pêkhat\" (unsur) + \"çandî\".",
   her:["Pêkhatên çandî yên kurdî.", "Di pêkhatên çandî de."],
   gen:["Pêkhatên çandî", "Pêkhatên me"]),

  (id:"b2_753", ku:"Stranbêjî ya neteweyî", tr:"Ulusal şarkıcılık geleneği", en:"National singing tradition",
   cins:"mê", ez:"stranbêjiya neteweyî", kat:"çand", zor:0.64,
   not:"\"Stranbêjî\" + \"neteweyî\". Kürt ulusal kültür kavramı.",
   her:["Stranbêjîya neteweyî.", "Di stranbêjîya neteweyî de."],
   gen:["Stranbêjîya neteweyî", "Stranbêjîya me"]),

  // ── AKADEMİK DİL KALIPLARI ────────────────────────────────

  (id:"b2_760", ku:"Weke ku hatiye nîşandan", tr:"Gösterildiği gibi", en:"As has been shown",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.65,
   not:"\"Weke ku hatiye nîşandan\" — akademik metin kalıbı.",
   her:["Weke ku hatiye nîşandan...", "Weke ku hat nîşandan, ziman..."],
   gen:["Weke ku hatiye nîşandan", "Weke ku diyar kirin"]),

  (id:"b2_761", ku:"Li gorî vê yekê", tr:"Buna göre", en:"According to this",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.67,
   not:"\"Li gorî\" + \"vê yekê\". Argüman zincirlemesi.",
   her:["Li gorî vê yekê, ziman...", "Li gorî vê yekê em dibêjin."],
   gen:["Li gorî vê yekê", "Li gorî vê"]),

  (id:"b2_762", ku:"Ji vir tê xuya kirin", tr:"Buradan anlaşılıyor ki", en:"It can be seen from this",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.64,
   not:"Akademik sonuç çıkarma kalıbı.",
   her:["Ji vir tê xuya kirin ku ziman...", "Ji vir tê xuya kirin."],
   gen:["Ji vir tê xuya kirin", "Tê xuya kirin"]),

  (id:"b2_763", ku:"Weke encamekê", tr:"Sonuç olarak", en:"As a conclusion",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.66,
   not:"\"Weke encamekê\" — akademik metin kapanış kalıbı.",
   her:["Weke encamekê em dibêjin...", "Weke encamekê, ziman girîng e."],
   gen:["Weke encamekê", "Encam"]),

  // ── B2 ÖZGÜN TERİMLER ─────────────────────────────────────

  (id:"b2_770", ku:"Kovara zanistî", tr:"Bilimsel dergi", en:"Scientific journal",
   cins:"mê", ez:"kovara zanistî", kat:"zanist", zor:0.65,
   not:"\"Kovar\" + \"zanistî\". Akademik yayın.",
   her:["Kovara zanistî ya kurdî.", "Di kovara zanistî de."],
   gen:["Kovara zanistî", "Kovara me"]),

  (id:"b2_771", ku:"Gotara akademîk", tr:"Akademik makale", en:"Academic article",
   cins:"mê", ez:"gotara akademîk", kat:"zanist", zor:0.65,
   not:"\"Gotar\" + \"akademîk\".",
   her:["Gotara akademîk nivîsand.", "Di gotara akademîk de."],
   gen:["Gotara akademîk", "Gotara me"]),

  (id:"b2_772", ku:"Çavkanî û referans", tr:"Kaynak ve referans", en:"Source and reference",
   cins:"bêcins", ez:"çavkanî û referans", kat:"zanist", zor:0.66,
   not:"\"Çavkanî\" + \"referans\". Akademik atıf.",
   her:["Çavkanî û referans bide.", "Di çavkanî û referansê de."],
   gen:["Çavkanî û referans", "Çavkanîyên me"]),

  (id:"b2_773", ku:"Metodolojî", tr:"Metodoloji", en:"Methodology",
   cins:"mê", ez:"metodolojiyê", kat:"zanist", zor:0.65,
   not:"Dişil — uluslararası terim. \"Metodolojîya lêkolînê.\"",
   her:["Metodolojîya baş.", "Di metodolojiyê de."],
   gen:["Metodolojî û teorî", "Metodolojîya me"]),

  // ── SÜREÇ VE DEĞİŞİM ──────────────────────────────────────

  (id:"b2_780", ku:"Veguhêzîna çandî", tr:"Kültürel dönüşüm", en:"Cultural transformation",
   cins:"mê", ez:"veguhêzîna çandî", kat:"civakî", zor:0.65,
   not:"\"Veguhêzîn\" (dönüşüm) + \"çandî\".",
   her:["Veguhêzîna çandî ya kurdî.", "Di veguhêzîna çandî de."],
   gen:["Veguhêzîna çandî", "Veguhêzîna me"]),

  (id:"b2_781", ku:"Pêvajoya hînbûnê", tr:"Öğrenme süreci", en:"Learning process",
   cins:"mê", ez:"pêvajoya hînbûnê", kat:"perwerde", zor:0.66,
   not:"\"Pêvajo\" + \"hînbûnê\". Pedagojik kavram.",
   her:["Pêvajoya hînbûnê.", "Di pêvajoya hînbûnê de."],
   gen:["Pêvajoya hînbûnê", "Pêvajoya me"]),

  (id:"b2_782", ku:"Guherîna sîstematîk", tr:"Sistematik değişim", en:"Systematic change",
   cins:"mê", ez:"guherîna sîstematîk", kat:"civakî", zor:0.64,
   not:"\"Guherîn\" + \"sîstematîk\".",
   her:["Guherîna sîstematîk lazim e.", "Di guherîna sîstematîk de."],
   gen:["Guherîna sîstematîk", "Guherîna me"]),

];



final kB2FerkeraEk = [
  // ── FÊRKERA B2 EK KAVRAMLAR ───────────────────────────────────
  (id:"b2_fk_01", ku:"Endazyarî", tr:"Mühendislik", en:"Engineering",
   cins:"mê", ez:"endazyariyê", kat:"zanist", zor:0.69,
   not:"Dişil — [Fêrkera D.3] ✓: \"endazyarî\" listede. \"Endazyar\" + \"-î\".",
   her:["Endazyarî dixwînim.", "Beşa endazyariyê."],
   gen:["Endazyarî û zanist", "Beşa endazyariyê"]),

  (id:"b2_fk_02", ku:"Jîngehparêzî", tr:"Çevrecilik / Ekoloji", en:"Environmentalism",
   cins:"mê", ez:"jîngehparêziyê", kat:"ekoloji", zor:0.68,
   not:"Dişil — [Fêrkera D.14] ✓: \"jîngehparêzî\" listede. \"Jîngeh\" + \"parêz\" + \"-î\".",
   her:["Jîngehparêzî girîng e.", "Ji bo jîngehparêziyê."],
   gen:["Jîngehparêzî û aborî", "Jîngehparêzîya me"]),

  (id:"b2_fk_03", ku:"Xwedî derketin", tr:"Sahip çıkmak / Korumak", en:"To take ownership / care for",
   cins:"bêcins", ez:null, kat:"leker", zor:0.69,
   not:"\"Xwedî derketin\" — [Fêrkera D.14] ✓. \"Xwedî\" (sahip) + \"derketin\".",
   her:["Xwedî derkeve jîngehê!", "Em xwedî derdikevin."],
   gen:["Xwedî derketin û parastin", "Xwedî derkeve!"]),

  (id:"b2_fk_04", ku:"Hişyar kirin", tr:"Uyarmak / Bilinçlendirmek", en:"To warn / raise awareness",
   cins:"bêcins", ez:null, kat:"leker", zor:0.70,
   not:"\"Hişyar kirin\" — [Fêrkera D.14] ✓. \"Hişyar\" (uyanık) + \"kirin\".",
   her:["Min hişyar kir.", "Gel hişyar bike!"],
   gen:["Hişyar kirin û ragihandin", "Hişyar bike!"]),

  (id:"b2_fk_05", ku:"Xweşîya candaran", tr:"Canlıların iyiliği", en:"Well-being of living beings",
   cins:"mê", ez:"xweşîya candaran", kat:"ekoloji", zor:0.67,
   not:"\"Xweşî\" + \"candar\" (canlı). [Fêrkera D.14] ✓.",
   her:["Xweşîya candaran lazim e.", "Ji bo xweşîya candaran."],
   gen:["Xweşîya candaran", "Xweşîya jîngehê"]),
];

final kB2Buyuk = [
  // ── EDEBİ ELEŞTİRİ (25) ─────────────────────────────────────

  (id:"b2_t01", ku:"Analîza metnê", tr:"Metin analizi", en:"Text analysis",
   cins:"mê", ez:"analîza metnê", kat:"edebiyat", zor:0.66,
   not:"\"Analîz\" + \"metnê\". Akademik okuma.",
   her:["Analîza metnê kir.", "Di analîza metnê de."],
   gen:["Analîza metnê", "Analîza me"]),

  (id:"b2_t02", ku:"Nêrîna rexneyî", tr:"Eleştirel bakış", en:"Critical perspective",
   cins:"mê", ez:"nêrîna rexneyî", kat:"edebiyat", zor:0.65,
   not:"\"Nêrîn\" + \"rexneyî\".",
   her:["Nêrîna rexneyî.", "Bi nêrîna rexneyî."],
   gen:["Nêrîna rexneyî", "Nêrîna me"]),

  (id:"b2_t03", ku:"Metnên kronolojîk", tr:"Kronolojik metinler", en:"Chronological texts",
   cins:"bêcins", ez:"metnên kronolojîk", kat:"edebiyat", zor:0.64,
   not:"\"Metn\" + \"kronolojîk\".",
   her:["Metnên kronolojîk.", "Di metnên kronolojîk de."],
   gen:["Metnên kronolojîk", "Metnên dîrokî"]),

  (id:"b2_t04", ku:"Hîkayeta qehremanî", tr:"Kahramanlık hikayesi", en:"Heroic narrative",
   cins:"mê", ez:"hîkayeta qehremanî", kat:"edebiyat", zor:0.66,
   not:"\"Hîkaye\" + \"qehremanî\". Kürt destanları.",
   her:["Hîkayeta qehremanî.", "Di hîkayeta qehremanî de."],
   gen:["Hîkayeta qehremanî", "Hîkayetên kurdî"]),

  (id:"b2_t05", ku:"Vegotina Mem û Zîn", tr:"Mem ve Zin'in anlatısı", en:"Narrative of Mem û Zîn",
   cins:"mê", ez:"vegotina Mem û Zîn", kat:"edebiyat", zor:0.68,
   not:"\"Vegotin\" + \"Mem û Zîn\". Xanî'nin anlatı yapısı.",
   her:["Vegotina Mem û Zîn.", "Di vegotina Mem û Zîn de."],
   gen:["Vegotina Mem û Zîn", "Vegotina Xanî"]),

  // ── SİYASİ FELSEFE (30) ─────────────────────────────────────
  (id:"b2_t06", ku:"Neteweyî û navnetewî", tr:"Ulusal ve uluslararası", en:"National and international",
   cins:"bêcins", ez:null, kat:"siyaset", zor:0.68,
   not:"\"Neteweyî\" + \"navnetewî\". Siyasi analiz kavramı.",
   her:["Meseleya neteweyî û navnetewî.", "Di astên neteweyî û navnetewî de."],
   gen:["Neteweyî û navnetewî", "Astên navnetewî"]),

  (id:"b2_t07", ku:"Biryardariya neteweyî", tr:"Ulusal karar alma", en:"National decision-making",
   cins:"mê", ez:"biryardariya neteweyî", kat:"siyaset", zor:0.65,
   not:"\"Biryardarî\" + \"neteweyî\".",
   her:["Biryardariya neteweyî.", "Di biryardariya neteweyî de."],
   gen:["Biryardariya neteweyî", "Biryardariya me"]),

  (id:"b2_t08", ku:"Hevalbendî", tr:"İttifak / Müttefik ilişkisi", en:"Alliance",
   cins:"mê", ez:"hevalbendiyê", kat:"siyaset", zor:0.67,
   not:"Dişil — \"heval\" + \"-bendî\". İttifak.",
   her:["Hevalbendî hatiye kirin.", "Di hevalbendiyê de."],
   gen:["Hevalbendî û dijminantî", "Hevalbendîya me"]),

  (id:"b2_t09", ku:"Lihevkirin", tr:"Uzlaşma / Anlaşma", en:"Agreement / Compromise",
   cins:"mê", ez:"lihevkirinê", kat:"siyaset", zor:0.68,
   not:"Dişil — \"li hev kirin\". Uzlaşma.",
   her:["Lihevkirin hat.", "Di lihevkirinê de."],
   gen:["Lihevkirin û nakokî", "Lihevkirina me"]),

  (id:"b2_t10", ku:"Nakokî", tr:"Çelişki / Anlaşmazlık", en:"Contradiction / Dispute",
   cins:"mê", ez:"nakokiyê", kat:"siyaset", zor:0.68,
   not:"Dişil — \"na\" + \"kokî\". Çelişki.",
   her:["Nakokî heye.", "Di nakokiyê de."],
   gen:["Nakokî û lihevkirin", "Nakokîya me"]),

  // ── MEDYA VE GAZETECİLİK (25) ────────────────────────────────
  (id:"b2_t11", ku:"Weşana televîzyonê", tr:"Televizyon yayını", en:"TV broadcast",
   cins:"mê", ez:"weşana televîzyonê", kat:"medya", zor:0.68,
   not:"\"Weşan\" + \"televîzyonê\".",
   her:["Weşana televîzyonê.", "Di weşana televîzyonê de."],
   gen:["Weşana televîzyonê", "Weşana me"]),

  (id:"b2_t12", ku:"Kanala kurdî", tr:"Kürtçe kanal", en:"Kurdish channel",
   cins:"mê", ez:"kanala kurdî", kat:"medya", zor:0.69,
   not:"\"Kanal\" + \"kurdî\". Kürt medyası.",
   her:["Kanala kurdî tê.", "Di kanala kurdî de ne."],
   gen:["Kanala kurdî", "Kanalên me"]),

  (id:"b2_t13", ku:"Nûçeyên derbarê", tr:"Hakkında haberler", en:"News about",
   cins:"bêcins", ez:null, kat:"medya", zor:0.67,
   not:"\"Nûçe\" + \"derbarê\". Gazete kalıbı.",
   her:["Nûçeyên derbarê Kurdistanê.", "Nûçeyên derbarê."],
   gen:["Nûçeyên derbarê", "Nûçeyên me"]),

  (id:"b2_t14", ku:"Pêbawer", tr:"Güvenilir", en:"Reliable / Trustworthy",
   cins:"bêcins", ez:null, kat:"medya", zor:0.69,
   not:"\"Pê\" + \"bawer\". \"Çavkanîyên pêbawer\" = güvenilir kaynaklar.",
   her:["Çavkanîyên pêbawer.", "Ev pêbawer e."],
   gen:["Pêbawer û bêbawer", "Çavkanîyên pêbawer"]),

  (id:"b2_t15", ku:"Analîza siyasî", tr:"Siyasi analiz", en:"Political analysis",
   cins:"mê", ez:"analîza siyasî", kat:"medya", zor:0.67,
   not:"\"Analîz\" + \"siyasî\".",
   her:["Analîza siyasî kir.", "Di analîza siyasî de."],
   gen:["Analîza siyasî", "Analîza me"]),

  // ── KÜRT KİMLİĞİ DERİN (25) ──────────────────────────────────
  (id:"b2_t16", ku:"Çanda xwecihî", tr:"Yerel kültür", en:"Indigenous culture",
   cins:"mê", ez:"çanda xwecihî", kat:"çand", zor:0.67,
   not:"\"Çand\" + \"xwecihî\" (yerli). Kürt kültürel mirası.",
   her:["Çanda xwecihî ya kurdî.", "Di çanda xwecihî de."],
   gen:["Çanda xwecihî", "Çanda me"]),

  (id:"b2_t17", ku:"Zimanê dê û bav", tr:"Anne babanın dili", en:"Language of parents",
   cins:"nêr", ez:"zimanê dê û bav", kat:"kimlik", zor:0.70,
   not:"\"Ziman\" + \"dê û bav\". Heritage bağlamında.",
   her:["Zimanê dê û bavê min kurdî ye.", "Zimanê dê û bav."],
   gen:["Zimanê dê û bav", "Zimanê me"]),

  (id:"b2_t18", ku:"Pêşxistina zimanî", tr:"Dil geliştirme", en:"Language development",
   cins:"mê", ez:"pêşxistina zimanî", kat:"kimlik", zor:0.67,
   not:"\"Pêşxistin\" + \"zimanî\".",
   her:["Pêşxistina zimanî lazim e.", "Di pêşxistina zimanî de."],
   gen:["Pêşxistina zimanî", "Pêşxistina me"]),

  (id:"b2_t19", ku:"Mafê perwerdeya kurdî", tr:"Kürtçe eğitim hakkı", en:"Right to Kurdish education",
   cins:"nêr", ez:"mafê perwerdeya kurdî", kat:"zagon", zor:0.68,
   not:"\"Maf\" + \"perwerde\" + \"kurdî\". Temel siyasi talep.",
   her:["Mafê perwerdeya kurdî.", "Ji bo mafê perwerdeya kurdî."],
   gen:["Mafê perwerdeya kurdî", "Mafên me"]),

  (id:"b2_t20", ku:"Vegotina dîasporayê", tr:"Diaspora anlatısı", en:"Diaspora narrative",
   cins:"mê", ez:"vegotina dîasporayê", kat:"kimlik", zor:0.67,
   not:"\"Vegotin\" + \"dîasporayê\". Heritage söylemi.",
   her:["Vegotina dîasporayê.", "Di vegotina dîasporayê de."],
   gen:["Vegotina dîasporayê", "Vegotina me"]),

  // ── BAĞLAÇLAR VE KALIPLAR (25) ────────────────────────────────
  (id:"b2_t21", ku:"Bi gotineke din", tr:"Başka bir deyişle", en:"In other words",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.68,
   not:"\"Bi gotineke din\" = başka deyişle. Akademik kalıp.",
   her:["Bi gotineke din...", "Bi gotineke din, ziman girîng e."],
   gen:["Bi gotineke din", "Bi gotina din"]),

  (id:"b2_t22", ku:"Gelek caran", tr:"Sıklıkla / Çok kez", en:"Often / Frequently",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.70,
   not:"\"Gelek\" + \"caran\". \"Gelek caran dibêjin ku...\"",
   her:["Gelek caran hatîye.", "Gelek caran tê gotin."],
   gen:["Gelek caran û kêm caran", "Gelek caran"]),

  (id:"b2_t23", ku:"Ji aliyê teorîkî ve", tr:"Teorik açıdan", en:"Theoretically",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.66,
   not:"\"Ji aliyê\" + \"teorîkî\" + \"ve\". Akademik B2 kalıbı.",
   her:["Ji aliyê teorîkî ve...", "Ji aliyê teorîkî ve nêrîn."],
   gen:["Ji aliyê teorîkî ve", "Ji aliyê pratîkî ve"]),

  (id:"b2_t24", ku:"Di vî warî de", tr:"Bu alanda", en:"In this field",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.68,
   not:"\"Di vî warî de\" = bu alanda.",
   her:["Di vî warî de gelek kar heye.", "Di vî warî de bêtejrîbe me."],
   gen:["Di vî warî de", "Di warê..."]),

  (id:"b2_t25", ku:"Wek ku nîşan dide", tr:"Gösterdiği gibi", en:"As it shows",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.66,
   not:"\"Wek ku nîşan dide\" = gösterdiği gibi. Akademik metin kalıbı.",
   her:["Wek ku lêkolîn nîşan dide...", "Wek ku nîşan dide, ziman..."],
   gen:["Wek ku nîşan dide", "Wek ku tê xuya kirin"]),
];


final kB2_Akademik = [  // AKADEMİK DİL — 80 kelime
  (id:"b2_a01", ku:"Çarçoweya analîtîk", tr:"Analitik çerçeve", en:"Analytical framework",
   cins:"mê", ez:"çarçoweya analîtîk", kat:"akademik", zor:0.62,
   not:"\"Çarçowe\" + \"analîtîk\".",
   her:["Çarçoweya analîtîk hatîye bikaranîn.", "Di çarçoweya analîtîk de."],
   gen:["Çarçoweya analîtîk", "Çarçoweya me"]),

  (id:"b2_a02", ku:"Nêrîna teorîkî", tr:"Teorik bakış açısı", en:"Theoretical perspective",
   cins:"mê", ez:"nêrîna teorîkî", kat:"akademik", zor:0.63,
   not:"\"Nêrîn\" + \"teorîkî\".",
   her:["Nêrîna teorîkî baş e.", "Ji nêrîna teorîkî ve."],
   gen:["Nêrîna teorîkî", "Nêrîna me"]),

  (id:"b2_a03", ku:"Delîlên empirîk", tr:"Ampirik kanıtlar", en:"Empirical evidence",
   cins:"bêcins", ez:"delîlên empirîk", kat:"akademik", zor:0.62,
   not:"\"Delîl\" + \"empirîk\". Bilimsel kanıt.",
   her:["Delîlên empirîk hene.", "Li gorî delîlên empirîk."],
   gen:["Delîlên empirîk", "Delîlên me"]),

  (id:"b2_a04", ku:"Analîza kûr", tr:"Derin analiz", en:"Deep analysis",
   cins:"mê", ez:"analîza kûr", kat:"akademik", zor:0.64,
   not:"\"Analîz\" + \"kûr\". Derinlemesine analiz.",
   her:["Analîza kûr lazim e.", "Di analîza kûr de."],
   gen:["Analîza kûr", "Analîza me"]),

  (id:"b2_a05", ku:"Gotara lêkolînê", tr:"Araştırma makalesi", en:"Research article",
   cins:"mê", ez:"gotara lêkolînê", kat:"akademik", zor:0.62,
   not:"\"Gotar\" + \"lêkolînê\".",
   her:["Gotara lêkolînê hat weşandin.", "Di gotara lêkolînê de."],
   gen:["Gotara lêkolînê", "Gotarên lêkolînê"]),

  (id:"b2_a06", ku:"Çavkanî û referans", tr:"Kaynak ve referans", en:"Source and reference",
   cins:"bêcins", ez:null, kat:"akademik", zor:0.64,
   not:"\"Çavkanî\" + \"referans\". Atıf sistemi.",
   her:["Çavkanî û referans girîng in.", "Çavkanî û referans nivisandin."],
   gen:["Çavkanî û referans", "Çavkanîyên me"]),

  (id:"b2_a07", ku:"Metodolojîya lêkolînê", tr:"Araştırma metodolojisi", en:"Research methodology",
   cins:"mê", ez:"metodolojîya lêkolînê", kat:"akademik", zor:0.61,
   not:"\"Metodolojî\" + \"lêkolînê\".",
   her:["Metodolojîya lêkolînê baş e.", "Di metodolojîya lêkolînê de."],
   gen:["Metodolojîya lêkolînê", "Metodolojîya me"]),

  (id:"b2_a08", ku:"Hevpeyvîna kûr", tr:"Derinlemesine mülakat", en:"In-depth interview",
   cins:"mê", ez:"hevpeyvîna kûr", kat:"akademik", zor:0.62,
   not:"\"Hevpeyvîn\" + \"kûr\".",
   her:["Hevpeyvîna kûr hat kirin.", "Di hevpeyvîna kûr de."],
   gen:["Hevpeyvîna kûr", "Hevpeyvîna me"]),

  (id:"b2_a09", ku:"Encamên lêkolînê", tr:"Araştırma bulguları", en:"Research findings",
   cins:"bêcins", ez:"encamên lêkolînê", kat:"akademik", zor:0.63,
   not:"\"Encam\" + \"lêkolînê\".",
   her:["Encamên lêkolînê hatine weşandin.", "Li gorî encamên lêkolînê."],
   gen:["Encamên lêkolînê", "Encamên me"]),

  (id:"b2_a10", ku:"Dissertasyon", tr:"Tez / Doktora tezi", en:"Dissertation / Thesis",
   cins:"mê", ez:"dissertasyonê", kat:"perwerde", zor:0.62,
   not:"Dişil — uluslararası terim.",
   her:["Dissertasyon hat nivîsandin.", "Di dissertasyonê de."],
   gen:["Dissertasyon û tez", "Dissertasyona me"]),

  // Felsefe
  (id:"b2_a11", ku:"Felsefeya siyasî", tr:"Siyasi felsefe", en:"Political philosophy",
   cins:"mê", ez:"felsefeya siyasî", kat:"felsefe", zor:0.63,
   not:"\"Felsefe\" + \"siyasî\". B2 felsefe.",
   her:["Felsefeya siyasî dixwînim.", "Di felsefeya siyasî de."],
   gen:["Felsefeya siyasî", "Felsefeya me"]),

  (id:"b2_a12", ku:"Têkilîya hêz û zanistê", tr:"Güç-bilgi ilişkisi", en:"Power-knowledge relation",
   cins:"mê", ez:"têkilîya hêz û zanistê", kat:"felsefe", zor:0.60,
   not:"Foucault kavramı: \"hêz\" + \"zanist\".",
   her:["Têkilîya hêz û zanistê.", "Di têkilîya hêz û zanistê de."],
   gen:["Têkilîya hêz û zanistê", "Têkilîya me"]),

  (id:"b2_a13", ku:"Rexneya civakî", tr:"Toplumsal eleştiri", en:"Social critique",
   cins:"mê", ez:"rexneya civakî", kat:"felsefe", zor:0.63,
   not:"\"Rexne\" + \"civakî\".",
   her:["Rexneya civakî girîng e.", "Bi rexneya civakî."],
   gen:["Rexneya civakî", "Rexneya me"]),

  (id:"b2_a14", ku:"Têgeha sereke", tr:"Ana kavram", en:"Core concept",
   cins:"mê", ez:"têgeha sereke", kat:"felsefe", zor:0.65,
   not:"\"Têgeh\" + \"sereke\".",
   her:["Têgeha sereke çi ye?", "Têgehên sereke."],
   gen:["Têgeha sereke", "Têgehên me"]),

  (id:"b2_a15", ku:"Zanistên civakî", tr:"Sosyal bilimler", en:"Social sciences",
   cins:"bêcins", ez:"zanistên civakî", kat:"akademik", zor:0.64,
   not:"\"Zanist\" + \"civakî\".",
   her:["Zanistên civakî dixwînim.", "Di zanistên civakî de."],
   gen:["Zanistên civakî", "Zanistên me"]),

  // İletişim
  (id:"b2_a16", ku:"Ragihandina giştî", tr:"Kamu iletişimi", en:"Public communication",
   cins:"mê", ez:"ragihandina giştî", kat:"medya", zor:0.64,
   not:"\"Ragihandin\" + \"giştî\".",
   her:["Ragihandina giştî lazim e.", "Di ragihandina giştî de."],
   gen:["Ragihandina giştî", "Ragihandina me"]),

  (id:"b2_a17", ku:"Ronakbîrî", tr:"Aydınlanma / Aydın olma", en:"Enlightenment / Being an intellectual",
   cins:"mê", ez:"ronakbîriyê", kat:"felsefe", zor:0.63,
   not:"Dişil — \"ronak\" (aydınlık) + \"bîr\" (düşünce) + \"-î\". Entelektüel birikim.",
   her:["Ronakbîrî armancek e.", "Di ronakbîriyê de."],
   gen:["Ronakbîrî û zanist", "Ronakbîrîya me"]),

  (id:"b2_a18", ku:"Ronakbîr", tr:"Aydın (kişi)", en:"Intellectual / Enlightened person",
   cins:"bêcins", ez:"ronakbîrê", kat:"pîşe", zor:0.65,
   not:"\"Ronak\" + \"bîr\". Kürt entelektüeli.",
   her:["Ew ronakbîr e.", "Ronakbîrên kurd."],
   gen:["Ronakbîr û akademîsyen", "Ronakbîrên me"]),

  (id:"b2_a19", ku:"Rûpela akademîk", tr:"Akademik sayfa / profil", en:"Academic page",
   cins:"mê", ez:"rûpela akademîk", kat:"akademik", zor:0.63,
   not:"\"Rûpel\" + \"akademîk\".",
   her:["Rûpela akademîk heye.", "Li rûpela akademîk binêre."],
   gen:["Rûpela akademîk", "Rûpela me"]),

  (id:"b2_a20", ku:"Konferansa navnetewî", tr:"Uluslararası konferans", en:"International conference",
   cins:"mê", ez:"konferansa navnetewî", kat:"akademik", zor:0.63,
   not:"\"Konferans\" + \"navnetewî\".",
   her:["Konferansa navnetewî hat.", "Di konferansa navnetewî de."],
   gen:["Konferansa navnetewî", "Konferansa me"]),
];

final kB2_Hukuk = [  // HUKUK VE ADALET — 60 kelime
  (id:"b2_h01", ku:"Mafê dengê azad", tr:"Serbest oy hakkı", en:"Right to free vote",
   cins:"nêr", ez:"mafê dengê azad", kat:"zagon", zor:0.64,
   not:"\"Maf\" + \"dengê azad\".",
   her:["Mafê dengê azad girîng e.", "Ji bo mafê dengê azad."],
   gen:["Mafê dengê azad", "Mafên me"]),

  (id:"b2_h02", ku:"Sûcdar", tr:"Suçlu", en:"Criminal / Guilty",
   cins:"bêcins", ez:"sûcdarê", kat:"zagon", zor:0.66,
   not:"\"Sûc\" + \"-dar\". Suçlu.",
   her:["Ew sûcdar e.", "Sûcdarê hat girtin."],
   gen:["Sûcdar û bêsûc", "Ev sûcdar e."]),

  (id:"b2_h03", ku:"Bêsûcî", tr:"Masumiyet", en:"Innocence",
   cins:"mê", ez:"bêsûciyê", kat:"zagon", zor:0.64,
   not:"Dişil — \"bê\" + \"sûc\" + \"-î\". Masumiyet.",
   her:["Bêsûcî tê parastin.", "Di bêsûciyê de."],
   gen:["Bêsûcî û sûcdarî", "Bêsûcîya me"]),

  (id:"b2_h04", ku:"Ceza", tr:"Ceza", en:"Punishment",
   cins:"mê", ez:"cezê", kat:"zagon", zor:0.68,
   not:"Dişil — [AS] ✓: \"ceza = ceza\". Ceza.",
   her:["Ceza hat dan.", "Cezaya giran."],
   gen:["Ceza û maf", "Cezaya me"]),

  (id:"b2_h05", ku:"Dadger", tr:"Hakim", en:"Judge",
   cins:"bêcins", ez:"dadgerê", kat:"pîşe", zor:0.67,
   not:"\"Dad\" (adalet) + \"-ger\". [AS] ✓.",
   her:["Dadger hat.", "Dadgerê dadgehê."],
   gen:["Dadger û parêzer", "Dadgerê me"]),

  (id:"b2_h06", ku:"Parêzer", tr:"Avukat", en:"Lawyer",
   cins:"bêcins", ez:"parêzerê", kat:"pîşe", zor:0.68,
   not:"\"Parêz\" (koruma) + \"-er\". Avukat.",
   her:["Parêzer hat.", "Parêzerê baş."],
   gen:["Parêzer û dadger", "Parêzerê me"]),

  (id:"b2_h07", ku:"Daxuyanî", tr:"Açıklama / Bildiri", en:"Statement / Declaration",
   cins:"mê", ez:"daxuyaniyê", kat:"zagon", zor:0.67,
   not:"Dişil — \"daxuyanî\" = açıklama/bildiri.",
   her:["Daxuyanî hat dayîn.", "Daxuyanîya fermî."],
   gen:["Daxuyanî û raportek", "Daxuyanîya me"]),

  (id:"b2_h08", ku:"Peymanek", tr:"Sözleşme / Antlaşma", en:"Treaty / Contract",
   cins:"mê", ez:"peymanekê", kat:"zagon", zor:0.66,
   not:"Dişil — \"peyman\" + \"-ek\". Sözleşme.",
   her:["Peymanek hat îmzakirin.", "Di peymanekê de."],
   gen:["Peymanek û biryar", "Peymaneka me"]),

  (id:"b2_h09", ku:"Encama biryarê", tr:"Karar sonucu", en:"Decision outcome",
   cins:"mê", ez:"encama biryarê", kat:"zagon", zor:0.65,
   not:"\"Encam\" + \"biryarê\".",
   her:["Encama biryarê baş e.", "Di encama biryarê de."],
   gen:["Encama biryarê", "Encama me"]),

  (id:"b2_h10", ku:"Mafên bingehîn", tr:"Temel haklar", en:"Fundamental rights",
   cins:"bêcins", ez:"mafên bingehîn", kat:"zagon", zor:0.67,
   not:"\"Maf\" + \"bingehîn\".",
   her:["Mafên bingehîn têne parastin.", "Di mafên bingehîn de."],
   gen:["Mafên bingehîn", "Mafên me"]),

  // Ekonomi
  (id:"b2_h11", ku:"Rastkirina aborî", tr:"Ekonomik düzeltme", en:"Economic correction",
   cins:"mê", ez:"rastkirina aborî", kat:"aborî", zor:0.63,
   not:"\"Rastkirin\" + \"aborî\".",
   her:["Rastkirina aborî lazim e.", "Di rastkirina aborî de."],
   gen:["Rastkirina aborî", "Rastkirina me"]),

  (id:"b2_h12", ku:"Aborîya neteweperest", tr:"Milliyetçi ekonomi", en:"Nationalist economy",
   cins:"mê", ez:"aborîya neteweperest", kat:"aborî", zor:0.62,
   not:"\"Aborî\" + \"neteweperest\".",
   her:["Aborîya neteweperest.", "Di aborîya neteweperest de."],
   gen:["Aborîya neteweperest", "Aborîya me"]),

  (id:"b2_h13", ku:"Bacê hatinê", tr:"Gelir vergisi", en:"Income tax",
   cins:"nêr", ez:"bacê hatinê", kat:"aborî", zor:0.64,
   not:"\"Bac\" + \"hatinê\". Gelir vergisi.",
   her:["Bacê hatinê hat dan.", "Di bacê hatinê de."],
   gen:["Bacê hatinê", "Bacê me"]),

  (id:"b2_h14", ku:"Aborîya bazar", tr:"Piyasa ekonomisi", en:"Market economy",
   cins:"mê", ez:"aborîya bazar", kat:"aborî", zor:0.65,
   not:"\"Aborî\" + \"bazar\".",
   her:["Aborîya bazar heye.", "Di aborîya bazar de."],
   gen:["Aborîya bazar", "Aborîya me"]),

  (id:"b2_h15", ku:"Rizgarkirina bazirganî", tr:"Ticaret liberalizasyonu", en:"Trade liberalization",
   cins:"mê", ez:"rizgarkirina bazirganî", kat:"aborî", zor:0.62,
   not:"\"Rizgarkirin\" + \"bazirganî\".",
   her:["Rizgarkirina bazirganî lazim e.", "Di rizgarkirina bazirganî de."],
   gen:["Rizgarkirina bazirganî", "Rizgarkirina me"]),
];

final kB2_Kultur2 = [  // KÜLTÜR VE KİMLİK DERİN — 70 kelime
  (id:"b2_k01", ku:"Kulturparêzî", tr:"Kültürel koruma", en:"Cultural preservation",
   cins:"mê", ez:"kulturparêziyê", kat:"çand", zor:0.64,
   not:"\"Kûltur\" + \"parêzî\". Kültürel mirasın korunması.",
   her:["Kulturparêzî lazim e.", "Di kulturparêziyê de."],
   gen:["Kulturparêzî", "Kulturparêzîya me"]),

  (id:"b2_k02", ku:"Çanda mezin", tr:"Büyük kültür / Yüksek kültür", en:"High culture",
   cins:"mê", ez:"çanda mezin", kat:"çand", zor:0.64,
   not:"\"Çand\" + \"mezin\".",
   her:["Çanda mezin ya kurdî.", "Di çanda mezin de."],
   gen:["Çanda mezin", "Çanda me"]),

  (id:"b2_k03", ku:"Nasnameya kolektîf", tr:"Kolektif kimlik", en:"Collective identity",
   cins:"mê", ez:"nasnameya kolektîf", kat:"kimlik", zor:0.65,
   not:"\"Nasname\" + \"kolektîf\".",
   her:["Nasnameya kolektîf ya kurdî.", "Di nasnameya kolektîf de."],
   gen:["Nasnameya kolektîf", "Nasnameya me"]),

  (id:"b2_k04", ku:"Rewşa dualî", tr:"İkili durum / Çift kimlik", en:"Dual situation",
   cins:"mê", ez:"rewşa dualî", kat:"kimlik", zor:0.63,
   not:"\"Rewş\" + \"dualî\". Heritage diaspora durumu.",
   her:["Rewşa dualî ya kurdan di diasporayê.", "Di rewşa dualî de."],
   gen:["Rewşa dualî", "Rewşa me"]),

  (id:"b2_k05", ku:"Veguhestina çandî", tr:"Kültürel aktarım", en:"Cultural transmission",
   cins:"mê", ez:"veguhestina çandî", kat:"çand", zor:0.63,
   not:"\"Veguhestin\" + \"çandî\". Kültürün aktarılması.",
   her:["Veguhestina çandî lazim e.", "Di veguhestina çandî de."],
   gen:["Veguhestina çandî", "Veguhestina me"]),

  (id:"b2_k06", ku:"Bîranîna dîrokî", tr:"Tarihi bellek / Kolektif hafıza", en:"Historical memory",
   cins:"mê", ez:"bîranîna dîrokî", kat:"dîrok", zor:0.65,
   not:"\"Bîranîn\" + \"dîrokî\".",
   her:["Bîranîna dîrokî ya kurdî.", "Di bîranîna dîrokî de."],
   gen:["Bîranîna dîrokî", "Bîranîna me"]),

  (id:"b2_k07", ku:"Wêjenasî", tr:"Edebiyat bilimi", en:"Literary science",
   cins:"mê", ez:"wêjenasiyê", kat:"edebiyat", zor:0.64,
   not:"Dişil — \"wêje\" + \"-nasî\". Edebiyat bilimi.",
   her:["Wêjenasî dixwînim.", "Di wêjenasiyê de."],
   gen:["Wêjenasî û zimannasî", "Wêjenasîya me"]),

  (id:"b2_k08", ku:"Mijara edebiyatê", tr:"Edebiyat teması", en:"Literary theme",
   cins:"mê", ez:"mijara edebiyatê", kat:"edebiyat", zor:0.66,
   not:"\"Mijar\" + \"edebiyatê\".",
   her:["Mijara edebiyatê çi ye?", "Di mijara edebiyatê de."],
   gen:["Mijara edebiyatê", "Mijarên edebiyatê"]),

  (id:"b2_k09", ku:"Jiyana mêjûyî", tr:"Tarihi yaşam / Tarihsel bağlam", en:"Historical life",
   cins:"mê", ez:"jiyana mêjûyî", kat:"dîrok", zor:0.63,
   not:"\"Jiyan\" + \"mêjûyî\".",
   her:["Jiyana mêjûyî ya kurdî.", "Di jiyana mêjûyî de."],
   gen:["Jiyana mêjûyî", "Jiyana me"]),

  (id:"b2_k10", ku:"Şêwe û naveroka", tr:"Biçim ve içerik", en:"Form and content",
   cins:"bêcins", ez:null, kat:"edebiyat", zor:0.66,
   not:"\"Şêwe\" (biçim) + \"naveroka\" (içerik). Edebi analiz.",
   her:["Şêwe û naveroka metnê.", "Di şêwe û naveroka de."],
   gen:["Şêwe û naveroka", "Şêwe û naveroka me"]),

  // Diaspora
  (id:"b2_k11", ku:"Ziman di Diasporayê de", tr:"Diasporada dil", en:"Language in diaspora",
   cins:"nêr", ez:"ziman di Diasporayê de", kat:"kimlik", zor:0.65,
   not:"\"Ziman\" + \"di diasporayê de\". Heritage konusu.",
   her:["Ziman di diasporayê de.", "Di zimanê diasporayê de."],
   gen:["Ziman di diasporayê de", "Zimanê me"]),

  (id:"b2_k12", ku:"Piştgirîya civakî", tr:"Sosyal destek", en:"Social support",
   cins:"mê", ez:"piştgirîya civakî", kat:"civakî", zor:0.66,
   not:"\"Piştgirî\" + \"civakî\".",
   her:["Piştgirîya civakî lazim e.", "Di piştgirîya civakî de."],
   gen:["Piştgirîya civakî", "Piştgirîya me"]),

  (id:"b2_k13", ku:"Neteweya bêdewlet", tr:"Devletsiz ulus", en:"Stateless nation",
   cins:"mê", ez:"neteweya bêdewlet", kat:"siyaset", zor:0.64,
   not:"\"Netewe\" + \"bêdewlet\". Kürt siyasi bağlamında.",
   her:["Neteweya bêdewlet ya kurd.", "Di neteweya bêdewlet de."],
   gen:["Neteweya bêdewlet", "Neteweya me"]),

  (id:"b2_k14", ku:"Çareserîya demokrasîk", tr:"Demokratik çözüm", en:"Democratic solution",
   cins:"mê", ez:"çareserîya demokrasîk", kat:"siyaset", zor:0.65,
   not:"\"Çareserî\" + \"demokrasîk\".",
   her:["Çareserîya demokrasîk lazim e.", "Di çareserîya demokrasîk de."],
   gen:["Çareserîya demokrasîk", "Çareserîya me"]),

  (id:"b2_k15", ku:"Yekîtîya gelê kurd", tr:"Kürt halkının birliği", en:"Unity of Kurdish people",
   cins:"mê", ez:"yekîtîya gelê kurd", kat:"siyaset", zor:0.66,
   not:"\"Yekîtî\" + \"gelê kurd\". Xanî'den bu yana temel mesaj.",
   her:["Yekîtîya gelê kurd girîng e.", "Di yekîtîya gelê kurd de."],
   gen:["Yekîtîya gelê kurd", "Yekîtîya me"]),
];



final kB2_Son2 = [
  (id:"b2_q01", ku:"Jiyana koçerî", tr:"Göçer yaşamı", en:"Nomadic life",
   cins:"mê", ez:"jiyana koçerî", kat:"çand", zor:0.66, not:"\"Jiyan\"+\"koçerî\".",
   her:["Jiyana koçerî ya kurdî.","Di jiyana koçerî de."], gen:["Jiyana koçerî","Jiyana me"]),
  (id:"b2_q02", ku:"Çanda gundî", tr:"Köy kültürü", en:"Village culture",
   cins:"mê", ez:"çanda gundî", kat:"çand", zor:0.67, not:"\"Çand\"+\"gundî\".",
   her:["Çanda gundî ya kurdî.","Di çanda gundî de."], gen:["Çanda gundî","Çanda me"]),
  (id:"b2_q03", ku:"Mafên zimanê kêmneteweyî", tr:"Azınlık dil hakları", en:"Minority language rights",
   cins:"bêcins", ez:"mafên zimanê kêmneteweyî", kat:"zagon", zor:0.64, not:"\"Maf\"+\"ziman\"+\"kêmneteweyî\".",
   her:["Mafên zimanê kêmneteweyî.","Di mafên zimanê kêmneteweyî de."], gen:["Mafên zimanê kêmneteweyî","Mafên me"]),
  (id:"b2_q04", ku:"Peymanên navnetewî", tr:"Uluslararası sözleşmeler", en:"International treaties",
   cins:"bêcins", ez:"peymanên navnetewî", kat:"zagon", zor:0.65, not:"\"Peyman\"+\"navnetewî\".",
   her:["Peymanên navnetewî hene.","Li gorî peymanên navnetewî."], gen:["Peymanên navnetewî","Peymanên me"]),
  (id:"b2_q05", ku:"Binpêkirina mafan", tr:"Hak ihlali", en:"Rights violation",
   cins:"mê", ez:"binpêkirina mafan", kat:"zagon", zor:0.65, not:"\"Binpêkirin\"+\"mafan\".",
   her:["Binpêkirina mafan heye.","Li hemberî binpêkirina mafan."], gen:["Binpêkirina mafan","Binpêkirina me"]),
  (id:"b2_q06", ku:"Aborîya dîjîtal", tr:"Dijital ekonomi", en:"Digital economy",
   cins:"mê", ez:"aborîya dîjîtal", kat:"aborî", zor:0.65, not:"\"Aborî\"+\"dîjîtal\".",
   her:["Aborîya dîjîtal mezin dibe.","Di aborîya dîjîtal de."], gen:["Aborîya dîjîtal","Aborîya me"]),
  (id:"b2_q07", ku:"Bazarê navnetewî", tr:"Uluslararası pazar", en:"International market",
   cins:"nêr", ez:"bazarê navnetewî", kat:"aborî", zor:0.65, not:"\"Bazar\"+\"navnetewî\".",
   her:["Bazarê navnetewî mezin e.","Di bazarê navnetewî de."], gen:["Bazarê navnetewî","Bazarê me"]),
  (id:"b2_q08", ku:"Sermayeya mirovî", tr:"İnsan sermayesi", en:"Human capital",
   cins:"mê", ez:"sermayeya mirovî", kat:"aborî", zor:0.64, not:"\"Sermaye\"+\"mirovî\".",
   her:["Sermayeya mirovî girîng e.","Di sermayeya mirovî de."], gen:["Sermayeya mirovî","Sermayeya me"]),
  (id:"b2_q09", ku:"Çîroka kevnar", tr:"Eski hikaye", en:"Ancient story",
   cins:"mê", ez:"çîroka kevnar", kat:"edebiyat", zor:0.66, not:"\"Çîrok\"+\"kevnar\".",
   her:["Çîroka kevnar xweş e.","Di çîroka kevnar de."], gen:["Çîroka kevnar","Çîrokên me"]),
  (id:"b2_q10", ku:"Şiîrê serhildanê", tr:"İsyan şiiri", en:"Resistance poetry",
   cins:"nêr", ez:"şiîrê serhildanê", kat:"edebiyat", zor:0.65, not:"\"Şiîr\"+\"serhildanê\".",
   her:["Şiîrê serhildanê.","Di şiîrê serhildanê de."], gen:["Şiîrê serhildanê","Şiîrên kurdî"]),
  (id:"b2_q11", ku:"Nivîskarê kurd", tr:"Kürt yazar", en:"Kurdish writer",
   cins:"bêcins", ez:"nivîskarê kurd", kat:"edebiyat", zor:0.68, not:"\"Nivîskar\"+\"kurd\".",
   her:["Nivîskarê kurd hat.","Nivîskarên kurd."], gen:["Nivîskarê kurd","Nivîskarên me"]),
  (id:"b2_q12", ku:"Kurdên diasporayê", tr:"Diaspora Kürtleri", en:"Diaspora Kurds",
   cins:"bêcins", ez:"Kurdên diasporayê", kat:"kimlik", zor:0.67, not:"\"Kurd\"+\"diasporayê\".",
   her:["Kurdên diasporayê.","Di nav Kurdên diasporayê de."], gen:["Kurdên diasporayê","Kurdên me"]),
  (id:"b2_q13", ku:"Analîza rexneyî", tr:"Eleştirel analiz", en:"Critical analysis",
   cins:"mê", ez:"analîza rexneyî", kat:"akademik", zor:0.64, not:"\"Analîz\"+\"rexneyî\".",
   her:["Analîza rexneyî lazim e.","Di analîza rexneyî de."], gen:["Analîza rexneyî","Analîza me"]),
  (id:"b2_q14", ku:"Wêjeya kurdî ya nûjen", tr:"Modern Kürt edebiyatı", en:"Modern Kurdish literature",
   cins:"mê", ez:"wêjeya kurdî ya nûjen", kat:"edebiyat", zor:0.65, not:"\"Wêje\"+\"kurdî\"+\"nûjen\".",
   her:["Wêjeya kurdî ya nûjen.","Di wêjeya kurdî ya nûjen de."], gen:["Wêjeya kurdî ya nûjen","Wêjeya me"]),
  (id:"b2_q15", ku:"Dezgehên hiqûqî", tr:"Hukuki kurumlar", en:"Legal institutions",
   cins:"bêcins", ez:"dezgehên hiqûqî", kat:"zagon", zor:0.64, not:"\"Dezgeh\"+\"hiqûqî\".",
   her:["Dezgehên hiqûqî hene.","Di dezgehên hiqûqî de."], gen:["Dezgehên hiqûqî","Dezgehên me"]),
  (id:"b2_q16", ku:"Nasnameya kolektîf", tr:"Kolektif kimlik", en:"Collective identity",
   cins:"mê", ez:"nasnameya kolektîf", kat:"kimlik", zor:0.65, not:"\"Nasname\"+\"kolektîf\".",
   her:["Nasnameya kolektîf.","Di nasnameya kolektîf de."], gen:["Nasnameya kolektîf","Nasnameya me"]),
  (id:"b2_q17", ku:"Çanda tevlihev", tr:"Karma kültür", en:"Mixed culture",
   cins:"mê", ez:"çanda tevlihev", kat:"kimlik", zor:0.65, not:"\"Çand\"+\"tevlihev\".",
   her:["Çanda tevlihev ya diasporayê.","Di çanda tevlihev de."], gen:["Çanda tevlihev","Çanda me"]),
  (id:"b2_q18", ku:"Nêrîna demokratîk", tr:"Demokratik görüş", en:"Democratic view",
   cins:"mê", ez:"nêrîna demokratîk", kat:"siyaset", zor:0.66, not:"\"Nêrîn\"+\"demokratîk\".",
   her:["Nêrîna demokratîk.","Bi nêrîna demokratîk."], gen:["Nêrîna demokratîk","Nêrîna me"]),
  (id:"b2_q19", ku:"Sazîya sivîl", tr:"Sivil kurum", en:"Civil institution",
   cins:"mê", ez:"sazîya sivîl", kat:"civakî", zor:0.65, not:"\"Sazî\"+\"sivîl\".",
   her:["Sazîya sivîl heye.","Di sazîya sivîl de."], gen:["Sazîya sivîl","Sazîya me"]),
  (id:"b2_q20", ku:"Pirsgirêkên serdema me", tr:"Çağımızın sorunları", en:"Issues of our era",
   cins:"bêcins", ez:"pirsgirêkên serdema me", kat:"civakî", zor:0.65, not:"\"Pirsgirêk\"+\"serdema me\".",
   her:["Pirsgirêkên serdema me.","Di pirsgirêkên serdema me de."], gen:["Pirsgirêkên serdema me","Pirsgirêkên me"]),
  (id:"b2_q21", ku:"Nirxên mirovatiyê", tr:"İnsanlık değerleri", en:"Human values",
   cins:"bêcins", ez:"nirxên mirovatiyê", kat:"felsefe", zor:0.65, not:"\"Nirx\"+\"mirovatiyê\".",
   her:["Nirxên mirovatiyê.","Di nirxên mirovatiyê de."], gen:["Nirxên mirovatiyê","Nirxên me"]),
  (id:"b2_q22", ku:"Pêşveçûna berdewam", tr:"Sürdürülebilir kalkınma", en:"Sustainable development",
   cins:"mê", ez:"pêşveçûna berdewam", kat:"aborî", zor:0.64, not:"\"Pêşveçûn\"+\"berdewam\".",
   her:["Pêşveçûna berdewam.","Di pêşveçûna berdewam de."], gen:["Pêşveçûna berdewam","Pêşveçûna me"]),
  (id:"b2_q23", ku:"Rêzgirtina cureyên jiyanê", tr:"Yaşam formlarına saygı", en:"Respect for life forms",
   cins:"mê", ez:"rêzgirtina cureyên jiyanê", kat:"ekoloji", zor:0.63, not:"\"Rêzgirtin\"+\"cureyên jiyanê\".",
   her:["Rêzgirtina cureyên jiyanê.","Di rêzgirtina cureyên jiyanê de."], gen:["Rêzgirtina cureyên jiyanê","Rêzgirtina me"]),
  (id:"b2_q24", ku:"Rewşa ekolojîk", tr:"Ekolojik durum", en:"Ecological situation",
   cins:"mê", ez:"rewşa ekolojîk", kat:"ekoloji", zor:0.65, not:"\"Rewş\"+\"ekolojîk\".",
   her:["Rewşa ekolojîk giran e.","Di rewşa ekolojîk de."], gen:["Rewşa ekolojîk","Rewşa me"]),
  (id:"b2_q25", ku:"Biparastina jîngehê", tr:"Çevre koruma", en:"Environmental protection",
   cins:"mê", ez:"biparastina jîngehê", kat:"ekoloji", zor:0.65, not:"\"Biparastin\"+\"jîngehê\".",
   her:["Biparastina jîngehê lazim e.","Di biparastina jîngehê de."], gen:["Biparastina jîngehê","Biparastina me"]),
  (id:"b2_q26", ku:"Hişmendiya rexneyî", tr:"Eleştirel düşünce", en:"Critical thinking",
   cins:"mê", ez:"hişmendiya rexneyî", kat:"zanist", zor:0.65, not:"\"Hişmendî\"+\"rexneyî\".",
   her:["Hişmendiya rexneyî lazim e.","Di hişmendiya rexneyî de."], gen:["Hişmendiya rexneyî","Hişmendiya me"]),
  (id:"b2_q27", ku:"Zanîna berdest", tr:"Mevcut bilgi", en:"Available knowledge",
   cins:"mê", ez:"zanîna berdest", kat:"zanist", zor:0.65, not:"\"Zanîn\"+\"berdest\".",
   her:["Zanîna berdest heye.","Di zanîna berdest de."], gen:["Zanîna berdest","Zanîna me"]),
  (id:"b2_q28", ku:"Çanda xwendinê", tr:"Okuma kültürü", en:"Reading culture",
   cins:"mê", ez:"çanda xwendinê", kat:"çand", zor:0.66, not:"\"Çand\"+\"xwendinê\".",
   her:["Çanda xwendinê lazim e.","Di çanda xwendinê de."], gen:["Çanda xwendinê","Çanda me"]),
  (id:"b2_q29", ku:"Nasnameyeke nû", tr:"Yeni bir kimlik", en:"A new identity",
   cins:"mê", ez:"nasnameyeke nû", kat:"kimlik", zor:0.66, not:"\"Nasname\"+\"-eke\"+\"nû\".",
   her:["Nasnameyeke nû çêkirin.","Nasnameyeke nû."], gen:["Nasnameyeke nû","Nasnameya me"]),
  (id:"b2_q30", ku:"Mafname", tr:"Haklar beyannamesi", en:"Rights declaration",
   cins:"mê", ez:"mafnamê", kat:"zagon", zor:0.64, not:"\"Maf\"+\"name\".",
   her:["Mafname hat weşandin.","Di mafnamê de."], gen:["Mafname","Mafnameya me"]),
];


final kB2_Final = [

  // AKADEMİK + EDEBİYAT — 60
  (id:"b2_f01", ku:"Teorîya edebiyatê", tr:"Edebiyat teorisi", en:"Literary theory", cins:"mê", ez:"teorîya edebiyatê", kat:"edebiyat", zor:0.63, not:"\"Teorî\"+\"edebiyatê\".", her:["Teorîya edebiyatê.","Di teorîya edebiyatê de."], gen:["Teorîya edebiyatê","Teorîya me"]),
  (id:"b2_f02", ku:"Vegotina lêzêdekar", tr:"Üst anlatı", en:"Meta-narrative", cins:"mê", ez:"vegotina lêzêdekar", kat:"edebiyat", zor:0.60, not:"\"Vegotin\"+\"lêzêdekar\".", her:["Vegotina lêzêdekar.","Di vegotina lêzêdekar de."], gen:["Vegotina lêzêdekar","Vegotina me"]),
  (id:"b2_f03", ku:"Xeyala edebiyatê", tr:"Edebi imgelem", en:"Literary imagination", cins:"mê", ez:"xeyala edebiyatê", kat:"edebiyat", zor:0.62, not:"\"Xeyal\"+\"edebiyatê\".", her:["Xeyala edebiyatê.","Di xeyala edebiyatê de."], gen:["Xeyala edebiyatê","Xeyala me"]),
  (id:"b2_f04", ku:"Sembolîzm di wêjeyê de", tr:"Edebiyatta sembolizm", en:"Symbolism in literature", cins:"nêr", ez:"sembolîzm di wêjeyê de", kat:"edebiyat", zor:0.61, not:"\"Sembolîzm\"+\"wêje\".", her:["Sembolîzm di wêjeyê de.","Di sembolîzmê de."], gen:["Sembolîzm di wêjeyê de","Sembolîzma me"]),
  (id:"b2_f05", ku:"Tematîka destan", tr:"Destan temaları", en:"Epic themes", cins:"mê", ez:"tematîka destan", kat:"edebiyat", zor:0.62, not:"\"Tematîk\"+\"destan\".", her:["Tematîka destan.","Di tematîka destan de."], gen:["Tematîka destan","Tematîka me"]),
  (id:"b2_f06", ku:"Serdema Newrozê di wêjeyê", tr:"Edebiyatta Newroz dönemi", en:"Newroz era in literature", cins:"mê", ez:"serdema Newrozê di wêjeyê", kat:"edebiyat", zor:0.62, not:"\"Serdem\"+\"Newroz\"+\"wêje\".", her:["Serdema Newrozê di wêjeyê.","Di serdema Newrozê de."], gen:["Serdema Newrozê di wêjeyê","Serdema me"]),
  (id:"b2_f07", ku:"Zimanê berhevok", tr:"Derleme dili", en:"Anthology language", cins:"nêr", ez:"zimanê berhevok", kat:"edebiyat", zor:0.61, not:"\"Ziman\"+\"berhevok\".", her:["Zimanê berhevok.","Di zimanê berhevok de."], gen:["Zimanê berhevok","Zimanê me"]),
  (id:"b2_f08", ku:"Lêkolîna wêjeyî", tr:"Edebi araştırma", en:"Literary research", cins:"mê", ez:"lêkolîna wêjeyî", kat:"edebiyat", zor:0.62, not:"\"Lêkolîn\"+\"wêjeyî\".", her:["Lêkolîna wêjeyî.","Di lêkolîna wêjeyî de."], gen:["Lêkolîna wêjeyî","Lêkolîna me"]),
  (id:"b2_f09", ku:"Naveroka çandî ya wêjeyê", tr:"Edebiyatın kültürel içeriği", en:"Cultural content of literature", cins:"mê", ez:"naveroka çandî ya wêjeyê", kat:"edebiyat", zor:0.61, not:"\"Navero\"+\"çandî\"+\"wêje\".", her:["Naveroka çandî ya wêjeyê.","Di naveroka çandî de."], gen:["Naveroka çandî ya wêjeyê","Naveroka me"]),
  (id:"b2_f10", ku:"Helbestvan", tr:"Şair", en:"Poet", cins:"bêcins", ez:"helbestvane", kat:"edebiyat", zor:0.65, not:"\"Helbest\"+\"-van\".", her:["Ew helbestvan e.","Helbestvanên kurd."], gen:["Helbestvan û dengbêj","Helbestvanên me"]),
  (id:"b2_f11", ku:"Çîrokvan", tr:"Hikayeci", en:"Storyteller", cins:"bêcins", ez:"çîrokvane", kat:"edebiyat", zor:0.64, not:"\"Çîrok\"+\"-van\".", her:["Ew çîrokvan e.","Çîrokvanên kurd."], gen:["Çîrokvan û helbestvan","Çîrokvanên me"]),
  (id:"b2_f12", ku:"Wêjenasê navdar", tr:"Ünlü edebiyat bilimci", en:"Famous literary scholar", cins:"bêcins", ez:"wêjenasê navdar", kat:"edebiyat", zor:0.61, not:"\"Wêjenas\"+\"navdar\".", her:["Wêjenasê navdar hat.","Wêjenasên navdar."], gen:["Wêjenasê navdar","Wêjenasên me"]),

  // ÇAND (kültür) — 30
  (id:"b2_f13", ku:"Dengbêjên navdar", tr:"Ünlü dengbêjler", en:"Famous dengbêjs", cins:"bêcins", ez:"dengbêjên navdar", kat:"çand", zor:0.64, not:"\"Dengbêj\"+\"navdar\".", her:["Dengbêjên navdar.","Di nav dengbêjên navdar de."], gen:["Dengbêjên navdar","Dengbêjên me"]),
  (id:"b2_f14", ku:"Kilama cejnê", tr:"Bayram türküsü", en:"Celebration song", cins:"mê", ez:"kilama cejnê", kat:"çand", zor:0.65, not:"\"Kilam\"+\"cejnê\".", her:["Kilama cejnê.","Di kilama cejnê de."], gen:["Kilama cejnê","Kilamên me"]),
  (id:"b2_f15", ku:"Keçelê kurdî", tr:"Kürt masalı", en:"Kurdish fairy tale", cins:"nêr", ez:"keçelê kurdî", kat:"çand", zor:0.64, not:"\"Keçel\" Kürt masallarında.", her:["Keçelê kurdî xweş e.","Di keçelê kurdî de."], gen:["Keçelê kurdî","Keçelên kurdî"]),
  (id:"b2_f16", ku:"Hunerê kevneşopî", tr:"Geleneksel sanat", en:"Traditional art", cins:"nêr", ez:"hunerê kevneşopî", kat:"çand", zor:0.65, not:"\"Huner\"+\"kevneşopî\".", her:["Hunerê kevneşopî ya kurdî.","Di hunerê kevneşopî de."], gen:["Hunerê kevneşopî","Hunerê me"]),
  (id:"b2_f17", ku:"Nimêjkirina kurdî", tr:"Kürt ibadeti", en:"Kurdish prayer", cins:"mê", ez:"nimêjkirina kurdî", kat:"çand", zor:0.62, not:"\"Nimêj\"+\"kurdî\". Dini kültürel bağlam.", her:["Nimêjkirina kurdî.","Di nimêjkirina kurdî de."], gen:["Nimêjkirina kurdî","Nimêjkirina me"]),
  (id:"b2_f18", ku:"Remezan di çanda kurdî", tr:"Kürt kültüründe Ramazan", en:"Ramadan in Kurdish culture", cins:"nêr", ez:"Remezan di çanda kurdî", kat:"çand", zor:0.63, not:"\"Remezan\"+\"çanda kurdî\".", her:["Remezan di çanda kurdî.","Di Remezana kurdî de."], gen:["Remezan di çanda kurdî","Remezana me"]),
  (id:"b2_f19", ku:"Jiyana çandî ya bajêr", tr:"Şehrin kültürel yaşamı", en:"Cultural life of the city", cins:"mê", ez:"jiyana çandî ya bajêr", kat:"çand", zor:0.63, not:"\"Jiyan\"+\"çandî\"+\"bajêr\".", her:["Jiyana çandî ya bajêr.","Di jiyana çandî ya bajêr de."], gen:["Jiyana çandî ya bajêr","Jiyana çandî ya me"]),

  // SİYASET ek — 20
  (id:"b2_f20", ku:"Alîgirên siyasî", tr:"Siyasi destekçiler", en:"Political supporters", cins:"bêcins", ez:"alîgirên siyasî", kat:"siyaset", zor:0.64, not:"\"Alîgir\"+\"siyasî\".", her:["Alîgirên siyasî hatin.","Di nav alîgirên siyasî de."], gen:["Alîgirên siyasî","Alîgirên me"]),
  (id:"b2_f21", ku:"Pêşniyara çareseriyê", tr:"Çözüm önerisi", en:"Solution proposal", cins:"mê", ez:"pêşniyara çareseriyê", kat:"siyaset", zor:0.64, not:"\"Pêşniyar\"+\"çareseriyê\".", her:["Pêşniyara çareseriyê.","Di pêşniyara çareseriyê de."], gen:["Pêşniyara çareseriyê","Pêşniyara me"]),
  (id:"b2_f22", ku:"Nexşeya siyasî", tr:"Siyasi harita", en:"Political map", cins:"mê", ez:"nexşeya siyasî", kat:"siyaset", zor:0.64, not:"\"Nexşe\"+\"siyasî\".", her:["Nexşeya siyasî guherîye.","Di nexşeya siyasî de."], gen:["Nexşeya siyasî","Nexşeya me"]),
  (id:"b2_f23", ku:"Dîplomasîya çandî", tr:"Kültürel diplomasi", en:"Cultural diplomacy", cins:"mê", ez:"dîplomasîya çandî", kat:"siyaset", zor:0.63, not:"\"Dîplomasi\"+\"çandî\".", her:["Dîplomasîya çandî.","Di dîplomasîya çandî de."], gen:["Dîplomasîya çandî","Dîplomasîya me"]),
  (id:"b2_f24", ku:"Pirsên navçeyî", tr:"Bölgesel sorunlar", en:"Regional issues", cins:"bêcins", ez:"pirsên navçeyî", kat:"siyaset", zor:0.64, not:"\"Pirs\"+\"navçeyî\".", her:["Pirsên navçeyî hene.","Di pirsên navçeyî de."], gen:["Pirsên navçeyî","Pirsên me"]),

  // KİMLİK ek — 20
  (id:"b2_f25", ku:"Nasnameya kevneşopî", tr:"Geleneksel kimlik", en:"Traditional identity", cins:"mê", ez:"nasnameya kevneşopî", kat:"kimlik", zor:0.64, not:"\"Nasname\"+\"kevneşopî\".", her:["Nasnameya kevneşopî.","Di nasnameya kevneşopî de."], gen:["Nasnameya kevneşopî","Nasnameya me"]),
  (id:"b2_f26", ku:"Nasname di guherînê de", tr:"Değişim içinde kimlik", en:"Identity in transformation", cins:"mê", ez:"nasname di guherînê de", kat:"kimlik", zor:0.63, not:"\"Nasname\"+\"guherîn\".", her:["Nasname di guherînê de.","Di nasname di guherînê de."], gen:["Nasname di guherînê de","Nasnameya me"]),
  (id:"b2_f27", ku:"Bîranîna kolektîf", tr:"Kolektif bellek", en:"Collective memory", cins:"mê", ez:"bîranîna kolektîf", kat:"kimlik", zor:0.64, not:"\"Bîranîn\"+\"kolektîf\".", her:["Bîranîna kolektîf ya kurdî.","Di bîranîna kolektîf de."], gen:["Bîranîna kolektîf","Bîranîna me"]),
  (id:"b2_f28", ku:"Vegerandina nasnameya xwe", tr:"Kimliğini geri alma", en:"Reclaiming one's identity", cins:"mê", ez:"vegerandina nasnameya xwe", kat:"kimlik", zor:0.64, not:"\"Vegerandin\"+\"nasname\".", her:["Vegerandina nasnameya xwe.","Di vegerandina nasnameya xwe de."], gen:["Vegerandina nasnameya xwe","Vegerandina me"]),
  (id:"b2_f29", ku:"Koka çandî", tr:"Kültürel kök", en:"Cultural root", cins:"mê", ez:"koka çandî", kat:"kimlik", zor:0.65, not:"\"Kok\"+\"çandî\".", her:["Koka çandî ya kurdî.","Di koka çandî de."], gen:["Koka çandî","Koka me"]),

  // AKADEMİK ek — 20
  (id:"b2_f30", ku:"Semîner û konferans", tr:"Seminer ve konferans", en:"Seminar and conference", cins:"bêcins", ez:null, kat:"akademik", zor:0.64, not:"\"Semîner\"+\"konferans\".", her:["Semîner û konferans hatin.","Di semîner û konferans de."], gen:["Semîner û konferans","Semîner û konferansa me"]),
  (id:"b2_f31", ku:"Gotarên zanistî", tr:"Bilimsel makaleler", en:"Scientific articles", cins:"bêcins", ez:"gotarên zanistî", kat:"akademik", zor:0.63, not:"\"Gotar\"+\"zanistî\".", her:["Gotarên zanistî hatin weşandin.","Di gotarên zanistî de."], gen:["Gotarên zanistî","Gotarên me"]),
  (id:"b2_f32", ku:"Çarçoweya nêrîner", tr:"Eleştirel çerçeve", en:"Critical framework", cins:"mê", ez:"çarçoweya nêrîner", kat:"akademik", zor:0.62, not:"\"Çarçowe\"+\"nêrîner\".", her:["Çarçoweya nêrîner.","Di çarçoweya nêrîner de."], gen:["Çarçoweya nêrîner","Çarçoweya me"]),
  (id:"b2_f33", ku:"Pêşandana akademîk", tr:"Akademik sunum/sergi", en:"Academic presentation/display", cins:"mê", ez:"pêşandana akademîk", kat:"akademik", zor:0.63, not:"\"Pêşandan\"+\"akademîk\".", her:["Pêşandana akademîk.","Di pêşandana akademîk de."], gen:["Pêşandana akademîk","Pêşandana me"]),
  (id:"b2_f34", ku:"Daneya lêkolînê", tr:"Araştırma verisi", en:"Research data", cins:"mê", ez:"daneya lêkolînê", kat:"akademik", zor:0.63, not:"\"Dane\"+\"lêkolînê\".", her:["Daneya lêkolînê hat berhevkirin.","Di daneya lêkolînê de."], gen:["Daneya lêkolînê","Daneya me"]),

  // EKONOMİ ek — 20
  (id:"b2_f35", ku:"Dabînkirina karî", tr:"İş istihdamı", en:"Employment provision", cins:"mê", ez:"dabînkirina karî", kat:"aborî", zor:0.63, not:"\"Dabînkirin\"+\"karî\".", her:["Dabînkirina karî lazim e.","Di dabînkirina karî de."], gen:["Dabînkirina karî","Dabînkirina me"]),
  (id:"b2_f36", ku:"Aborîya rûberî", tr:"Yüzeysel ekonomi", en:"Surface economy", cins:"mê", ez:"aborîya rûberî", kat:"aborî", zor:0.62, not:"\"Aborî\"+\"rûberî\".", her:["Aborîya rûberî.","Di aborîya rûberî de."], gen:["Aborîya rûberî","Aborîya me"]),
  (id:"b2_f37", ku:"Firoştina ber bi derve", tr:"İhracat", en:"Export", cins:"mê", ez:"firoştina ber bi derve", kat:"aborî", zor:0.63, not:"\"Firoştin\"+\"ber bi derve\".", her:["Firoştina ber bi derve.","Di firoştina ber bi derve de."], gen:["Firoştina ber bi derve","Firoştina me"]),
  (id:"b2_f38", ku:"Kirîna ji derve", tr:"İthalat", en:"Import", cins:"mê", ez:"kirîna ji derve", kat:"aborî", zor:0.63, not:"\"Kirîn\"+\"ji derve\".", her:["Kirîna ji derve.","Di kirîna ji derve de."], gen:["Kirîna ji derve","Kirîna me"]),
  (id:"b2_f39", ku:"Bazarê global", tr:"Global piyasa", en:"Global market", cins:"nêr", ez:"bazarê global", kat:"aborî", zor:0.64, not:"\"Bazar\"+\"global\".", her:["Bazarê global mezin e.","Di bazarê global de."], gen:["Bazarê global","Bazarê me"]),
  (id:"b2_f40", ku:"Derfeta veberhênanê", tr:"Yatırım fırsatı", en:"Investment opportunity", cins:"mê", ez:"derfeta veberhênanê", kat:"aborî", zor:0.63, not:"\"Derfet\"+\"veberhênanê\".", her:["Derfeta veberhênanê heye.","Di derfeta veberhênanê de."], gen:["Derfeta veberhênanê","Derfeta me"]),
];



final kB2_Kapanis = [
  (id:"b2_e01",ku:"Lêkolîna navdewletî",tr:"Uluslararası araştırma",en:"International research",
   cins:"mê",ez:"lêkolîna navdewletî",kat:"akademik",zor:0.64,not:"\"Lêkolîn\"+\"navdewletî\".",
   her:["Lêkolîna navdewletî.","Di lêkolîna navdewletî de."],gen:["Lêkolîna navdewletî","Lêkolîna me"]),
  (id:"b2_e02",ku:"Analîza berhevkarî",tr:"Karşılaştırmalı analiz",en:"Comparative analysis",
   cins:"mê",ez:"analîza berhevkarî",kat:"akademik",zor:0.63,not:"\"Analîz\"+\"berhevkarî\".",
   her:["Analîza berhevkarî.","Di analîza berhevkarî de."],gen:["Analîza berhevkarî","Analîza me"]),
  (id:"b2_e03",ku:"Mifteya têgihiştinê",tr:"Anlama anahtarı",en:"Key to understanding",
   cins:"mê",ez:"mifteya têgihiştinê",kat:"akademik",zor:0.64,not:"\"Mifte\"+\"têgihiştinê\".",
   her:["Mifteya têgihiştinê.","Di mifteya têgihiştinê de."],gen:["Mifteya têgihiştinê","Mifteya me"]),
  (id:"b2_e04",ku:"Perspektîfa rexneyî",tr:"Eleştirel perspektif",en:"Critical perspective",
   cins:"mê",ez:"perspektîfa rexneyî",kat:"felsefe",zor:0.63,not:"\"Perspektîf\"+\"rexneyî\".",
   her:["Perspektîfa rexneyî.","Ji perspektîfa rexneyî ve."],gen:["Perspektîfa rexneyî","Perspektîfa me"]),
  (id:"b2_e05",ku:"Têgehên bingehîn",tr:"Temel kavramlar",en:"Core concepts",
   cins:"bêcins",ez:"têgehên bingehîn",kat:"zanist",zor:0.65,not:"\"Têgeh\"+\"bingehîn\".",
   her:["Têgehên bingehîn.","Di têgehên bingehîn de."],gen:["Têgehên bingehîn","Têgehên me"]),
  (id:"b2_e06",ku:"Zanistên edebî",tr:"Edebiyat bilimleri",en:"Literary sciences",
   cins:"bêcins",ez:"zanistên edebî",kat:"edebiyat",zor:0.64,not:"\"Zanist\"+\"edebî\".",
   her:["Zanistên edebî.","Di zanistên edebî de."],gen:["Zanistên edebî","Zanistên me"]),
  (id:"b2_e07",ku:"Warê akademîk",tr:"Akademik alan",en:"Academic field",
   cins:"nêr",ez:"warê akademîk",kat:"akademik",zor:0.64,not:"\"War\"+\"akademîk\".",
   her:["Warê akademîk.","Di warê akademîk de."],gen:["Warê akademîk","Warê me"]),
  (id:"b2_e08",ku:"Zimanan û cîhan",tr:"Diller ve dünya",en:"Languages and world",
   cins:"bêcins",ez:null,kat:"ziman",zor:0.65,not:"\"Ziman\"+\"cîhan\".",
   her:["Zimanan û cîhan.","Di zimanan û cîhan de."],gen:["Zimanan û cîhan","Zimanan û cîhana me"]),
  (id:"b2_e09",ku:"Dewlemendiya zimanî",tr:"Dil zenginliği",en:"Linguistic richness",
   cins:"mê",ez:"dewlemendiya zimanî",kat:"ziman",zor:0.65,not:"\"Dewlemendî\"+\"zimanî\".",
   her:["Dewlemendiya zimanî ya kurdî.","Di dewlemendiya zimanî de."],gen:["Dewlemendiya zimanî","Dewlemendiya me"]),
  (id:"b2_e10",ku:"Hêvîya vejînê",tr:"Diriliş umudu",en:"Hope of revival",
   cins:"mê",ez:"hêvîya vejînê",kat:"kimlik",zor:0.65,not:"\"Hêvî\"+\"vejînê\".",
   her:["Hêvîya vejînê heye.","Di hêvîya vejînê de."],gen:["Hêvîya vejînê","Hêvîya me"]),
  (id:"b2_e11",ku:"Neteweperestîya çandî",tr:"Kültürel milliyetçilik",en:"Cultural nationalism",
   cins:"mê",ez:"neteweperestîya çandî",kat:"siyaset",zor:0.63,not:"\"Neteweperestî\"+\"çandî\".",
   her:["Neteweperestîya çandî.","Di neteweperestîya çandî de."],gen:["Neteweperestîya çandî","Neteweperestîya me"]),
  (id:"b2_e12",ku:"Jiyanên parçebûyî",tr:"Parçalanmış yaşamlar",en:"Fragmented lives",
   cins:"bêcins",ez:"jiyanên parçebûyî",kat:"kimlik",zor:0.63,not:"\"Jiyan\"+\"parçebûyî\".",
   her:["Jiyanên parçebûyî.","Di jiyanên parçebûyî de."],gen:["Jiyanên parçebûyî","Jiyanên me"]),
  (id:"b2_e13",ku:"Têkilîya dîroka û îroyê",tr:"Tarih ile bugünün ilişkisi",en:"Relation of history and today",
   cins:"mê",ez:"têkilîya dîroka û îroyê",kat:"dîrok",zor:0.62,not:"\"Têkilî\"+\"dîroka\"+\"îroyê\".",
   her:["Têkilîya dîroka û îroyê.","Di têkilîya dîroka û îroyê de."],gen:["Têkilîya dîroka û îroyê","Têkilîya me"]),
  (id:"b2_e14",ku:"Berhevkirina çandinên",tr:"Kültürlerin karşılaştırılması",en:"Cultural comparison",
   cins:"mê",ez:"berhevkirina çandinên",kat:"çand",zor:0.62,not:"\"Berhevkirin\"+\"çandinên\".",
   her:["Berhevkirina çandinên.","Di berhevkirina çandinên de."],gen:["Berhevkirina çandinên","Berhevkirina me"]),
  (id:"b2_e15",ku:"Pêşeroja kurdan",tr:"Kürtlerin geleceği",en:"Future of Kurds",
   cins:"nêr",ez:"pêşeroja kurdan",kat:"kimlik",zor:0.65,not:"\"Pêşeroj\"+\"kurdan\".",
   her:["Pêşeroja kurdan.","Di pêşeroja kurdan de."],gen:["Pêşeroja kurdan","Pêşeroja me"]),
  (id:"b2_e16",ku:"Têkilîya gender û ziman",tr:"Toplumsal cinsiyet ve dil ilişkisi",en:"Gender and language relation",
   cins:"mê",ez:"têkilîya gender û ziman",kat:"civaknas",zor:0.62,not:"\"Têkilî\"+\"gender\"+\"ziman\".",
   her:["Têkilîya gender û ziman.","Di têkilîya gender û ziman de."],gen:["Têkilîya gender û ziman","Têkilîya me"]),
  (id:"b2_e17",ku:"Rêzimana wesfkirinê",tr:"Betimleyici dilbilgisi",en:"Descriptive grammar",
   cins:"mê",ez:"rêzimana wesfkirinê",kat:"rêziman",zor:0.63,not:"\"Rêziman\"+\"wesfkirinê\".",
   her:["Rêzimana wesfkirinê.","Di rêzimana wesfkirinê de."],gen:["Rêzimana wesfkirinê","Rêzimana me"]),
  (id:"b2_e18",ku:"Pêvajoya hînbûnê",tr:"Öğrenme süreci",en:"Learning process",
   cins:"mê",ez:"pêvajoya hînbûnê",kat:"perwerde",zor:0.64,not:"\"Pêvajo\"+\"hînbûnê\".",
   her:["Pêvajoya hînbûnê.","Di pêvajoya hînbûnê de."],gen:["Pêvajoya hînbûnê","Pêvajoya me"]),
  (id:"b2_e19",ku:"Xebata sahadê",tr:"Saha çalışması",en:"Field work",
   cins:"mê",ez:"xebata sahadê",kat:"akademik",zor:0.63,not:"\"Xebat\"+\"sahadê\".",
   her:["Xebata sahadê hat kirin.","Di xebata sahadê de."],gen:["Xebata sahadê","Xebata me"]),
  (id:"b2_e20",ku:"Hevpeyvîna analîtîk",tr:"Analitik mülakat",en:"Analytical interview",
   cins:"mê",ez:"hevpeyvîna analîtîk",kat:"akademik",zor:0.62,not:"\"Hevpeyvîn\"+\"analîtîk\".",
   her:["Hevpeyvîna analîtîk.","Di hevpeyvîna analîtîk de."],gen:["Hevpeyvîna analîtîk","Hevpeyvîna me"]),
];


final kB2_Son90 = [

  // ABORİ (ekonomi) — 15
  (id:"b2_s01", ku:"Dahata netewî", tr:"Milli gelir", en:"National income", cins:"mê", ez:"dahata netewî", kat:"aborî", zor:0.63, not:"\"Dahat\"+\"netewî\".", her:["Dahata netewî zêde bû.", "Di dahata netewî de."], gen:["Dahata netewî","Dahata me"]),
  (id:"b2_s02", ku:"Aborîya hevbeş", tr:"Ortak ekonomi", en:"Shared economy", cins:"mê", ez:"aborîya hevbeş", kat:"aborî", zor:0.62, not:"\"Aborî\"+\"hevbeş\".", her:["Aborîya hevbeş baş e.", "Di aborîya hevbeş de."], gen:["Aborîya hevbeş","Aborîya me"]),
  (id:"b2_s03", ku:"Berhevoka aborî", tr:"Ekonomik toplam", en:"Economic total", cins:"mê", ez:"berhevoka aborî", kat:"aborî", zor:0.62, not:"\"Berhevok\"+\"aborî\".", her:["Berhevoka aborî mezin e.", "Di berhevoka aborî de."], gen:["Berhevoka aborî","Berhevoka me"]),
  (id:"b2_s04", ku:"Xercên giştî", tr:"Genel harcamalar", en:"Total expenses", cins:"bêcins", ez:"xercên giştî", kat:"aborî", zor:0.63, not:"\"Xerc\"+\"giştî\".", her:["Xercên giştî gelek in.", "Di xercên giştî de."], gen:["Xercên giştî","Xercên me"]),
  (id:"b2_s05", ku:"Lihevhatina aborî", tr:"Ekonomik anlaşma", en:"Economic agreement", cins:"mê", ez:"lihevhatina aborî", kat:"aborî", zor:0.62, not:"\"Lihevhatin\"+\"aborî\".", her:["Lihevhatina aborî hat.", "Di lihevhatina aborî de."], gen:["Lihevhatina aborî","Lihevhatina me"]),
  (id:"b2_s06", ku:"Pêşengîya aborî", tr:"Ekonomik öncülük", en:"Economic leadership", cins:"mê", ez:"pêşengîya aborî", kat:"aborî", zor:0.62, not:"\"Pêşengî\"+\"aborî\".", her:["Pêşengîya aborî lazim e.", "Di pêşengîya aborî de."], gen:["Pêşengîya aborî","Pêşengîya me"]),
  (id:"b2_s07", ku:"Fonên pêşkeftinê", tr:"Kalkınma fonları", en:"Development funds", cins:"bêcins", ez:"fonên pêşkeftinê", kat:"aborî", zor:0.62, not:"\"Fon\"+\"pêşkeftinê\".", her:["Fonên pêşkeftinê hene.", "Di fonên pêşkeftinê de."], gen:["Fonên pêşkeftinê","Fonên me"]),
  (id:"b2_s08", ku:"Nirxê berhemê", tr:"Ürünün değeri", en:"Value of product", cins:"nêr", ez:"nirxê berhemê", kat:"aborî", zor:0.63, not:"\"Nirx\"+\"berhemê\".", her:["Nirxê berhemê bilind e.", "Di nirxê berhemê de."], gen:["Nirxê berhemê","Nirxê me"]),
  (id:"b2_s09", ku:"Çêkirina kargehê", tr:"Fabrika kurma", en:"Factory establishment", cins:"mê", ez:"çêkirina kargehê", kat:"aborî", zor:0.62, not:"\"Çêkirin\"+\"kargehê\".", her:["Çêkirina kargehê hat.", "Di çêkirina kargehê de."], gen:["Çêkirina kargehê","Çêkirina me"]),
  (id:"b2_s10", ku:"Rêkûpêkkirina aborî", tr:"Ekonomik düzenleme", en:"Economic regulation", cins:"mê", ez:"rêkûpêkkirina aborî", kat:"aborî", zor:0.62, not:"\"Rêkûpêkkirin\"+\"aborî\".", her:["Rêkûpêkkirina aborî lazim e.", "Di rêkûpêkkirina aborî de."], gen:["Rêkûpêkkirina aborî","Rêkûpêkkirina me"]),
  (id:"b2_s11", ku:"Xizanî û dewlemendî", tr:"Yoksulluk ve zenginlik", en:"Poverty and wealth", cins:"bêcins", ez:null, kat:"aborî", zor:0.64, not:"\"Xizanî\"+\"dewlemendî\". Zıt kavram çifti.", her:["Xizanî û dewlemendî hene.", "Di navbera xizanî û dewlemendî de."], gen:["Xizanî û dewlemendî","Xizanî û dewlemendîya me"]),
  (id:"b2_s12", ku:"Dabînkirina xwarinê", tr:"Gıda sağlama", en:"Food provision", cins:"mê", ez:"dabînkirina xwarinê", kat:"aborî", zor:0.63, not:"\"Dabînkirin\"+\"xwarinê\".", her:["Dabînkirina xwarinê lazim e.", "Di dabînkirina xwarinê de."], gen:["Dabînkirina xwarinê","Dabînkirina me"]),
  (id:"b2_s13", ku:"Dabeşkirina çavkaniyan", tr:"Kaynakların dağıtımı", en:"Distribution of resources", cins:"mê", ez:"dabeşkirina çavkaniyan", kat:"aborî", zor:0.62, not:"\"Dabeşkirin\"+\"çavkaniyan\".", her:["Dabeşkirina çavkaniyan.", "Di dabeşkirina çavkaniyan de."], gen:["Dabeşkirina çavkaniyan","Dabeşkirina me"]),
  (id:"b2_s14", ku:"Têkilîya aborî ya navnetewî", tr:"Uluslararası ekonomik ilişki", en:"International economic relation", cins:"mê", ez:"têkilîya aborî ya navnetewî", kat:"aborî", zor:0.61, not:"\"Têkilî\"+\"aborî\"+\"navnetewî\".", her:["Têkilîya aborî ya navnetewî.", "Di têkilîya aborî ya navnetewî de."], gen:["Têkilîya aborî ya navnetewî","Têkilîya me"]),
  (id:"b2_s15", ku:"Îtîraza aborî", tr:"Ekonomik itiraz", en:"Economic objection", cins:"mê", ez:"îtîraza aborî", kat:"aborî", zor:0.62, not:"\"Îtiraz\"+\"aborî\".", her:["Îtîraza aborî hat.", "Di îtîraza aborî de."], gen:["Îtîraza aborî","Îtîraza me"]),

  // AKADEMİK — 15
  (id:"b2_s16", ku:"Têzê doktorayê", tr:"Doktora tezi", en:"Doctoral thesis", cins:"nêr", ez:"têzê doktorayê", kat:"akademik", zor:0.62, not:"\"Têz\"+\"doktorayê\".", her:["Têzê doktorayê hat nivîsandin.", "Di têzê doktorayê de."], gen:["Têzê doktorayê","Têzê me"]),
  (id:"b2_s17", ku:"Nêrîna alikarî", tr:"Yardımcı bakış", en:"Auxiliary perspective", cins:"mê", ez:"nêrîna alîkarî", kat:"akademik", zor:0.62, not:"\"Nêrîn\"+\"alîkarî\".", her:["Nêrîna alîkarî baş e.", "Di nêrîna alîkarî de."], gen:["Nêrîna alîkarî","Nêrîna me"]),
  (id:"b2_s18", ku:"Teknîka nivîsandinê", tr:"Yazma tekniği", en:"Writing technique", cins:"mê", ez:"teknîka nivîsandinê", kat:"akademik", zor:0.63, not:"\"Teknîk\"+\"nivîsandinê\".", her:["Teknîka nivîsandinê baş e.", "Di teknîka nivîsandinê de."], gen:["Teknîka nivîsandinê","Teknîka me"]),
  (id:"b2_s19", ku:"Lîteratûra zanistî", tr:"Bilimsel literatür", en:"Scientific literature", cins:"mê", ez:"lîteratûra zanistî", kat:"akademik", zor:0.62, not:"\"Lîteratûr\"+\"zanistî\".", her:["Lîteratûra zanistî mezin e.", "Di lîteratûra zanistî de."], gen:["Lîteratûra zanistî","Lîteratûra me"]),
  (id:"b2_s20", ku:"Xalên bingehîn ên analîzê", tr:"Analizin temel noktaları", en:"Core points of analysis", cins:"bêcins", ez:"xalên bingehîn ên analîzê", kat:"akademik", zor:0.61, not:"\"Xal\"+\"bingehîn\"+\"analîzê\".", her:["Xalên bingehîn ên analîzê.", "Di xalên bingehîn de."], gen:["Xalên bingehîn ên analîzê","Xalên me"]),
  (id:"b2_s21", ku:"Pêşniyara siyasî", tr:"Siyasi öneri", en:"Policy proposal", cins:"mê", ez:"pêşniyara siyasî", kat:"akademik", zor:0.62, not:"\"Pêşniyar\"+\"siyasî\".", her:["Pêşniyara siyasî hat.", "Di pêşniyara siyasî de."], gen:["Pêşniyara siyasî","Pêşniyara me"]),

  // SİYASET ek — 10
  (id:"b2_s22", ku:"Siyaseta derveyî", tr:"Dış politika", en:"Foreign policy", cins:"mê", ez:"siyaseta derveyî", kat:"siyaset", zor:0.64, not:"\"Siyaset\"+\"derveyî\".", her:["Siyaseta derveyî baş e.", "Di siyaseta derveyî de."], gen:["Siyaseta derveyî","Siyaseta me"]),
  (id:"b2_s23", ku:"Siyaseta hundir", tr:"İç politika", en:"Domestic policy", cins:"mê", ez:"siyaseta hundir", kat:"siyaset", zor:0.64, not:"\"Siyaset\"+\"hundir\".", her:["Siyaseta hundir baş e.", "Di siyaseta hundir de."], gen:["Siyaseta hundir","Siyaseta me"]),
  (id:"b2_s24", ku:"Rêxistinên mafên mirovan", tr:"İnsan hakları örgütleri", en:"Human rights organizations", cins:"bêcins", ez:"rêxistinên mafên mirovan", kat:"siyaset", zor:0.63, not:"\"Rêxistin\"+\"mafên mirovan\".", her:["Rêxistinên mafên mirovan hatin.", "Di rêxistinên mafên mirovan de."], gen:["Rêxistinên mafên mirovan","Rêxistinên me"]),
  (id:"b2_s25", ku:"Biryarên siyasî", tr:"Siyasi kararlar", en:"Political decisions", cins:"bêcins", ez:"biryarên siyasî", kat:"siyaset", zor:0.64, not:"\"Biryar\"+\"siyasî\".", her:["Biryarên siyasî hatin.", "Di biryarên siyasî de."], gen:["Biryarên siyasî","Biryarên me"]),

  // ÇAND (kültür) ek — 10
  (id:"b2_s26", ku:"Xezala kurdî", tr:"Kürtçe şarkı türü (xezel)", en:"Kurdish ghazal", cins:"mê", ez:"xezala kurdî", kat:"çand", zor:0.64, not:"\"Xezel\" = gazel/lirik şiir türü.", her:["Xezala kurdî xweş e.", "Di xezala kurdî de."], gen:["Xezala kurdî","Xezalên me"]),
  (id:"b2_s27", ku:"Çanda herêmî", tr:"Bölgesel kültür", en:"Regional culture", cins:"mê", ez:"çanda herêmî", kat:"çand", zor:0.65, not:"\"Çand\"+\"herêmî\".", her:["Çanda herêmî xweş e.", "Di çanda herêmî de."], gen:["Çanda herêmî","Çanda me"]),
  (id:"b2_s28", ku:"Veguherîna çandî", tr:"Kültürel dönüşüm", en:"Cultural transformation", cins:"mê", ez:"veguherîna çandî", kat:"çand", zor:0.63, not:"\"Veguherîn\"+\"çandî\".", her:["Veguherîna çandî dibe.", "Di veguherîna çandî de."], gen:["Veguherîna çandî","Veguherîna me"]),
  (id:"b2_s29", ku:"Navdêrên çandî", tr:"Kültürel isimler/kavramlar", en:"Cultural terms", cins:"bêcins", ez:"navdêrên çandî", kat:"çand", zor:0.63, not:"\"Navdêr\"+\"çandî\".", her:["Navdêrên çandî hene.", "Di navdêrên çandî de."], gen:["Navdêrên çandî","Navdêrên me"]),

  // KİMLİK ek — 10
  (id:"b2_s30", ku:"Nasnameya têkçûyî", tr:"Parçalanmış kimlik", en:"Fragmented identity", cins:"mê", ez:"nasnameya têkçûyî", kat:"kimlik", zor:0.63, not:"\"Nasname\"+\"têkçûyî\".", her:["Nasnameya têkçûyî.", "Di nasnameya têkçûyî de."], gen:["Nasnameya têkçûyî","Nasnameya me"]),
  (id:"b2_s31", ku:"Nasnameya hevbeş", tr:"Ortak kimlik", en:"Shared identity", cins:"mê", ez:"nasnameya hevbeş", kat:"kimlik", zor:0.64, not:"\"Nasname\"+\"hevbeş\".", her:["Nasnameya hevbeş.", "Di nasnameya hevbeş de."], gen:["Nasnameya hevbeş","Nasnameya me"]),
  (id:"b2_s32", ku:"Asîmîlasyona çandî", tr:"Kültürel asimilasyon", en:"Cultural assimilation", cins:"mê", ez:"asîmîlasyona çandî", kat:"kimlik", zor:0.63, not:"\"Asîmîlasyon\"+\"çandî\".", her:["Asîmîlasyona çandî.", "Di asîmîlasyona çandî de."], gen:["Asîmîlasyona çandî","Asîmîlasyona me"]),
  (id:"b2_s33", ku:"Mafê xwebirêvebirinê", tr:"Özyönetim hakkı", en:"Right to self-governance", cins:"nêr", ez:"mafê xwebirêvebirinê", kat:"kimlik", zor:0.64, not:"\"Maf\"+\"xwebirêvebirin\".", her:["Mafê xwebirêvebirinê lazim e.", "Ji bo mafê xwebirêvebirinê."], gen:["Mafê xwebirêvebirinê","Mafên me"]),
  (id:"b2_s34", ku:"Pêvajoya vejînê", tr:"Canlanma süreci", en:"Revival process", cins:"mê", ez:"pêvajoya vejînê", kat:"kimlik", zor:0.63, not:"\"Pêvajo\"+\"vejîn\".", her:["Pêvajoya vejînê.", "Di pêvajoya vejînê de."], gen:["Pêvajoya vejînê","Pêvajoya me"]),

  // GENEL B2 — 30
  (id:"b2_s35", ku:"Têkoşîna jiyanî", tr:"Hayati mücadele", en:"Life struggle", cins:"mê", ez:"têkoşîna jiyanî", kat:"felsefe", zor:0.63, not:"\"Têkoşîn\"+\"jiyanî\".", her:["Têkoşîna jiyanî.", "Di têkoşîna jiyanî de."], gen:["Têkoşîna jiyanî","Têkoşîna me"]),
  (id:"b2_s36", ku:"Serdana zanîngehe", tr:"Üniversite ziyareti", en:"University visit", cins:"mê", ez:"serdana zanîngehe", kat:"perwerde", zor:0.64, not:"\"Serdan\"+\"zanîngehe\".", her:["Serdana zanîngehe hat.", "Di serdana zanîngehe de."], gen:["Serdana zanîngehe","Serdana me"]),
  (id:"b2_s37", ku:"Bernameya zanistî", tr:"Bilimsel program", en:"Scientific program", cins:"mê", ez:"bernameya zanistî", kat:"zanist", zor:0.63, not:"\"Bername\"+\"zanistî\".", her:["Bernameya zanistî baş e.", "Di bernameya zanistî de."], gen:["Bernameya zanistî","Bernameya me"]),
  (id:"b2_s38", ku:"Teknîkên lêkolînê", tr:"Araştırma teknikleri", en:"Research techniques", cins:"bêcins", ez:"teknîkên lêkolînê", kat:"zanist", zor:0.62, not:"\"Teknîk\"+\"lêkolînê\".", her:["Teknîkên lêkolînê hene.", "Di teknîkên lêkolînê de."], gen:["Teknîkên lêkolînê","Teknîkên me"]),
  (id:"b2_s39", ku:"Pêvajoya hînbûnê", tr:"Öğrenme süreci", en:"Learning process", cins:"mê", ez:"pêvajoya hînbûnê", kat:"perwerde", zor:0.63, not:"\"Pêvajo\"+\"hînbûn\".", her:["Pêvajoya hînbûnê.", "Di pêvajoya hînbûnê de."], gen:["Pêvajoya hînbûnê","Pêvajoya me"]),
  (id:"b2_s40", ku:"Serwerîya zimanî", tr:"Dil hâkimiyeti", en:"Linguistic dominance", cins:"mê", ez:"serwerîya zimanî", kat:"ziman", zor:0.63, not:"\"Serwer\"+\"zimanî\".", her:["Serwerîya zimanî.", "Di serwerîya zimanî de."], gen:["Serwerîya zimanî","Serwerîya me"]),
  (id:"b2_s41", ku:"Rêkeftina zimanî", tr:"Dil anlaşması", en:"Language agreement", cins:"mê", ez:"rêkeftina zimanî", kat:"ziman", zor:0.63, not:"\"Rêkeftin\"+\"zimanî\".", her:["Rêkeftina zimanî hat.", "Di rêkeftina zimanî de."], gen:["Rêkeftina zimanî","Rêkeftina me"]),
  (id:"b2_s42", ku:"Naveroka akademîk", tr:"Akademik içerik", en:"Academic content", cins:"mê", ez:"naveroka akademîk", kat:"akademik", zor:0.63, not:"\"Navero\"+\"akademîk\".", her:["Naveroka akademîk baş e.", "Di naveroka akademîk de."], gen:["Naveroka akademîk","Naveroka me"]),
  (id:"b2_s43", ku:"Pêşkeftina sereke", tr:"Ana gelişme", en:"Main development", cins:"mê", ez:"pêşkeftina sereke", kat:"zanist", zor:0.64, not:"\"Pêşkeftin\"+\"sereke\".", her:["Pêşkeftina sereke hat.", "Di pêşkeftina sereke de."], gen:["Pêşkeftina sereke","Pêşkeftina me"]),
  (id:"b2_s44", ku:"Têkilîya ziman û çand", tr:"Dil ve kültür ilişkisi", en:"Language-culture relation", cins:"mê", ez:"têkilîya ziman û çand", kat:"ziman", zor:0.64, not:"\"Têkilî\"+\"ziman û çand\".", her:["Têkilîya ziman û çand.", "Di têkilîya ziman û çand de."], gen:["Têkilîya ziman û çand","Têkilîya me"]),
];


final kB2_Final46 = [

  // DİLBİLGİSİ B2 — karmaşık yapılar (15)
  (id:"b2_r01", ku:"Lêkera girêdayî", tr:"Bağlaçlı fiil", en:"Compound verb construction",
   cins:"mê", ez:"lêkera girêdayî", kat:"rêziman", zor:0.64,
   not:"\"Lêker\"+\"girêdayî\". B2 dilbilgisi yapısı. Örn: \"xwe kişandin\", \"ji holê kirin\".",
   her:["Lêkera girêdayî.", "Di lêkera girêdayî de."],
   gen:["Lêkera girêdayî", "Lêkerên kurdî"]),

  (id:"b2_r02", ku:"Hevoka veqetandî", tr:"Ayrık cümle / Uzak bağlaçlı", en:"Cleft sentence",
   cins:"mê", ez:"hevoka veqetandî", kat:"rêziman", zor:0.63,
   not:"\"Hevok\"+\"veqetandî\". Örn: \"Ew e ku hat\" yapısı.",
   her:["Hevoka veqetandî.", "Di hevoka veqetandî de."],
   gen:["Hevoka veqetandî", "Hevokên kurdî"]),

  (id:"b2_r03", ku:"Nerêziya lêkerê", tr:"Fiilin düzensizliği", en:"Verb irregularity",
   cins:"mê", ez:"nerêziya lêkerê", kat:"rêziman", zor:0.64,
   not:"\"Nerêzî\"+\"lêker\". Düzensiz fiil formları: hatin/hat, bûn/bû.",
   her:["Nerêziya lêkerê heye.", "Di nerêziya lêkerê de."],
   gen:["Nerêziya lêkerê", "Nerêzîyên kurdî"]),

  (id:"b2_r04", ku:"Mastarê bi fonksiyona navdêrî", tr:"İsim işlevli mastar", en:"Verbal noun",
   cins:"nêr", ez:"mastarê bi fonksiyona navdêrî", kat:"rêziman", zor:0.63,
   not:"\"Mastar\" isim görevinde. Örn: \"Xwendin baş e\" = Okumak iyidir.",
   her:["Mastarê bi fonksiyona navdêrî.", "Di mastarê de."],
   gen:["Mastarê bi fonksiyona navdêrî", "Mastarên kurdî"]),

  (id:"b2_r05", ku:"Rawestandina lêkerê", tr:"Fiilin duraksatılması", en:"Verb suspension",
   cins:"mê", ez:"rawestandina lêkerê", kat:"rêziman", zor:0.63,
   not:"\"Rawestan\"+\"lêker\". Belirli zaman kiplerinde fiil.",
   her:["Rawestandina lêkerê.", "Di rawestandina lêkerê de."],
   gen:["Rawestandina lêkerê", "Rawestandina me"]),

  (id:"b2_r06", ku:"Têkiliya şertê bi encamê", tr:"Koşul-sonuç ilişkisi", en:"Condition-result relation",
   cins:"mê", ez:"têkiliya şertê bi encamê", kat:"rêziman", zor:0.64,
   not:"\"Têkilî\"+\"şert û encam\". \"Ger were, wê biçim\" yapısı.",
   her:["Têkiliya şertê bi encamê.", "Di têkiliya şertê de."],
   gen:["Têkiliya şertê bi encamê", "Têkiliyên rêzimanê"]),

  (id:"b2_r07", ku:"Cihêtîya zayendî di ziman de", tr:"Dildeki cinsiyet ayrımı", en:"Gender distinction in language",
   cins:"mê", ez:"cihêtîya zayendî di ziman de", kat:"rêziman", zor:0.63,
   not:"\"Cihêtî\"+\"zayendî\"+\"ziman\". Kurmancî cinsiyet sistemi.",
   her:["Cihêtîya zayendî di ziman de.", "Di cihêtîya zayendî de."],
   gen:["Cihêtîya zayendî di ziman de", "Zayendê kurdî"]),

  (id:"b2_r08", ku:"Veguherîna hevokê", tr:"Cümle dönüşümü", en:"Sentence transformation",
   cins:"mê", ez:"veguherîna hevokê", kat:"rêziman", zor:0.64,
   not:"\"Veguherîn\"+\"hevok\". Aktif-pasif, direkt-endirekt dönüşüm.",
   her:["Veguherîna hevokê.", "Di veguherîna hevokê de."],
   gen:["Veguherîna hevokê", "Veguherîna me"]),

  // FİİLLER B2 (8)
  (id:"b2_lk01", ku:"Nîşandan", tr:"Göstermek", en:"To show / demonstrate",
   cins:"bêcins", ez:null, kat:"leker", zor:0.68,
   not:"\"Nîşandan\" = göstermek. Ergatif: \"Min nîşan da.\"",
   her:["Min nîşan da.", "Ew nîşan dide."],
   gen:["Nîşandan û veşartin", "Min nîşan da."]),

  (id:"b2_lk02", ku:"Pêşkêş kirin", tr:"Sunmak", en:"To present / offer",
   cins:"bêcins", ez:null, kat:"leker", zor:0.69,
   not:"\"Pêşkêş kirin\" = sunmak. Ergatif: \"Min pêşkêş kir.\"",
   her:["Min pêşkêş kir.", "Ew pêşkêş dike."],
   gen:["Pêşkêş kirin", "Min pêşkêş kir."]),

  (id:"b2_lk03", ku:"Nirxandin", tr:"Değerlendirmek", en:"To evaluate / assess",
   cins:"bêcins", ez:null, kat:"leker", zor:0.69,
   not:"\"Nirxandin\" = değerlendirmek. Ergatif: \"Min nirxand.\"",
   her:["Min gotara nirxand.", "Ew hat nirxandin."],
   gen:["Nirxandin û rexnekirin", "Min nirxand."]),

  (id:"b2_lk04", ku:"Xelas kirin", tr:"Kurtarmak / Bitirmek", en:"To save / finish",
   cins:"bêcins", ez:null, kat:"leker", zor:0.69,
   not:"\"Xelas kirin\" = kurtarmak. Ergatif: \"Min xelas kir.\"",
   her:["Min xelas kir.", "Ew xelas dike."],
   gen:["Xelas kirin", "Min xelas kir."]),

  // TEKNOLOJİ (6)
  (id:"b2_tk01", ku:"Sîstema serhêl", tr:"Çevrimiçi sistem", en:"Online system",
   cins:"mê", ez:"sîstema serhêl", kat:"teknoloji", zor:0.67,
   not:"\"Sîstem\"+\"serhêl\". Dijital altyapı.",
   her:["Sîstema serhêl baş e.", "Di sîstema serhêl de."],
   gen:["Sîstema serhêl", "Sîstema me"]),

  (id:"b2_tk02", ku:"Bernameya yapay dîmenî", tr:"Yapay zekâ programı", en:"Artificial intelligence program",
   cins:"mê", ez:"bernameya yapay dîmenî", kat:"teknoloji", zor:0.66,
   not:"\"Zekaya çêkirî\" = yapay zekâ. Dijital çağ terimi.",
   her:["Bernameya yapay dîmenî.", "Di bernameya zekaya çêkirî de."],
   gen:["Bernameya zekaya çêkirî", "Bernameya me"]),

  (id:"b2_tk03", ku:"Platforma kurdî ya dîjîtal", tr:"Kürtçe dijital platform", en:"Kurdish digital platform",
   cins:"mê", ez:"platforma kurdî ya dîjîtal", kat:"teknoloji", zor:0.67,
   not:"\"Platform\"+\"kurdî\"+\"dîjîtal\". Kürt dijital medyası.",
   her:["Platforma kurdî ya dîjîtal heye.", "Di platforma kurdî de."],
   gen:["Platforma kurdî ya dîjîtal", "Platforma me"]),

  // CİVAKÎ (8)
  (id:"b2_cv01", ku:"Tevkarîya civakî", tr:"Toplumsal katılım", en:"Social participation",
   cins:"mê", ez:"tevkarîya civakî", kat:"civakî", zor:0.66,
   not:"\"Tevkarî\"+\"civakî\". Sivil katılım.",
   her:["Tevkarîya civakî lazim e.", "Di tevkarîya civakî de."],
   gen:["Tevkarîya civakî", "Tevkarîya me"]),

  (id:"b2_cv02", ku:"Grûbên kêmahî", tr:"Azınlık grupları", en:"Minority groups",
   cins:"bêcins", ez:"grûbên kêmahî", kat:"civakî", zor:0.66,
   not:"\"Grûb\"+\"kêmahî\". Azınlık grupları.",
   her:["Grûbên kêmahî hene.", "Di grûbên kêmahî de."],
   gen:["Grûbên kêmahî", "Grûbên me"]),

  (id:"b2_cv03", ku:"Wekhevî û dadmendî", tr:"Eşitlik ve adalet", en:"Equality and justice",
   cins:"bêcins", ez:null, kat:"civakî", zor:0.67,
   not:"\"Wekhevî\"+\"dadmendî\". Temel sosyal değerler.",
   her:["Wekhevî û dadmendî lazim in.", "Di wekhevî û dadmendî de."],
   gen:["Wekhevî û dadmendî", "Wekhevîya me"]),

  (id:"b2_cv04", ku:"Piştgirîya hevdû", tr:"Karşılıklı destek", en:"Mutual support",
   cins:"mê", ez:"piştgirîya hevdû", kat:"civakî", zor:0.67,
   not:"\"Piştgirî\"+\"hevdû\". Dayanışma.",
   her:["Piştgirîya hevdû lazim e.", "Di piştgirîya hevdû de."],
   gen:["Piştgirîya hevdû", "Piştgirîya me"]),

  // EKSİK TAMAMLAMA (9)
  (id:"b2_x01", ku:"Ronakbîrîya kurdî", tr:"Kürt aydınlanması", en:"Kurdish enlightenment",
   cins:"mê", ez:"ronakbîrîya kurdî", kat:"dîrok", zor:0.66,
   not:"\"Ronakbîrî\"+\"kurdî\". 19-20. yy Kürt kültürel uyanışı.",
   her:["Ronakbîrîya kurdî girîng e.", "Di ronakbîrîya kurdî de."],
   gen:["Ronakbîrîya kurdî", "Ronakbîrîya me"]),

  (id:"b2_x02", ku:"Perwerdehiya bilind", tr:"Yükseköğretim", en:"Higher education",
   cins:"mê", ez:"perwerdehiya bilind", kat:"perwerde", zor:0.66,
   not:"\"Perwerdehî\"+\"bilind\". Üniversite düzeyi.",
   her:["Perwerdehiya bilind girîng e.", "Di perwerdehiya bilind de."],
   gen:["Perwerdehiya bilind", "Perwerdehiya me"]),

  (id:"b2_x03", ku:"Xebata meydanî", tr:"Saha çalışması", en:"Fieldwork",
   cins:"mê", ez:"xebata meydanî", kat:"zanist", zor:0.65,
   not:"\"Xebat\"+\"meydanî\". Araştırma metodolojisi.",
   her:["Xebata meydanî hat kirin.", "Di xebata meydanî de."],
   gen:["Xebata meydanî", "Xebata me"]),

  (id:"b2_x04", ku:"Demografîya Kurdistanê", tr:"Kürdistanın demografisi", en:"Demographics of Kurdistan",
   cins:"mê", ez:"demografîya Kurdistanê", kat:"zanist", zor:0.65,
   not:"\"Demografî\"+\"Kurdistanê\". Nüfus yapısı.",
   her:["Demografîya Kurdistanê.", "Di demografîya Kurdistanê de."],
   gen:["Demografîya Kurdistanê", "Demografîya me"]),

  (id:"b2_x05", ku:"Huqûqa navnetewî", tr:"Uluslararası hukuk", en:"International law",
   cins:"mê", ez:"huqûqa navnetewî", kat:"zagon", zor:0.67,
   not:"\"Huqûq\"+\"navnetewî\". Uluslararası hukukun Kurmancî karşılığı.",
   her:["Huqûqa navnetewî.", "Di huqûqa navnetewî de."],
   gen:["Huqûqa navnetewî", "Huqûqa me"]),

  (id:"b2_x06", ku:"Welatparêzî û neteweyî", tr:"Yurtseverlik ve milliyetçilik", en:"Patriotism and nationalism",
   cins:"bêcins", ez:null, kat:"siyaset", zor:0.67,
   not:"\"Welatparêzî\"+\"neteweyî\". Siyasi kavram çifti.",
   her:["Welatparêzî û neteweyî.", "Di navbera welatparêzî û neteweyî de."],
   gen:["Welatparêzî û neteweyî", "Welatparêzîya me"]),

  (id:"b2_x07", ku:"Pêwendîya herêmî", tr:"Bölgesel ilişki", en:"Regional relation",
   cins:"mê", ez:"pêwendîya herêmî", kat:"cografî", zor:0.66,
   not:"\"Pêwendî\"+\"herêmî\".",
   her:["Pêwendîya herêmî baş e.", "Di pêwendîya herêmî de."],
   gen:["Pêwendîya herêmî", "Pêwendîya me"]),

  (id:"b2_x08", ku:"Ekolojîya kultûrel", tr:"Kültürel ekoloji", en:"Cultural ecology",
   cins:"mê", ez:"ekolojîya kultûrel", kat:"ekoloji", zor:0.65,
   not:"\"Ekolojî\"+\"kultûrel\". Çevre-kültür ilişkisi.",
   her:["Ekolojîya kultûrel.", "Di ekolojîya kultûrel de."],
   gen:["Ekolojîya kultûrel", "Ekolojîya me"]),

  (id:"b2_x09", ku:"Rêkxistina hiqûqî", tr:"Hukuki düzenleme", en:"Legal arrangement",
   cins:"mê", ez:"rêkxistina hiqûqî", kat:"zagon", zor:0.65,
   not:"\"Rêkxistin\"+\"hiqûqî\".",
   her:["Rêkxistina hiqûqî hat.", "Di rêkxistina hiqûqî de."],
   gen:["Rêkxistina hiqûqî", "Rêkxistina me"]),
];



final kB2_Son18 = [
  // Rengder (B2)
  (id:"b2_rg01", ku:"Veşartî", tr:"Gizli / Örtülü", en:"Hidden / Covert",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.65,
   not:"\"Veşartî\" = gizli/örtülü. Akademik bağlamda: \"maneya veşartî\" = gizli anlam.",
   her:["Maneya veşartî heye.", "Ev veşartî ye."],
   gen:["Veşartî û eşkere", "Ev veşartî ye."]),

  (id:"b2_rg02", ku:"Eşkere", tr:"Açık / Belirgin", en:"Clear / Explicit",
   cins:"bêcins", ez:null, kat:"rengder", zor:0.67,
   not:"\"Eşkere\" = açık/belirgin. \"Eşkere kirin\" = açıklamak.",
   her:["Eşkere ye.", "Bi awayekî eşkere."],
   gen:["Eşkere û veşartî", "Eşkere bike."]),

  // Şart (koşul yapıları)
  (id:"b2_st01", ku:"Ger... bûya, wê... bûya", tr:"Eğer... olsaydı, ... olurdu", en:"If... had been, would have been",
   cins:"bêcins", ez:null, kat:"şart", zor:0.64,
   not:"Gerçekleşmemiş koşul (counterfactual): \"Ger ez hatibama, wê min dîtibam.\"",
   her:["Ger hatibama, wê dîtibam.", "Ger baş bûya, wê çûbama."],
   gen:["Ger... bûya, wê... bûya", "Şerta nayabûyî"]),

  (id:"b2_st02", ku:"Heke... be, dê... be", tr:"Eğer... ise, ... olacak", en:"If... is, will be",
   cins:"bêcins", ez:null, kat:"şart", zor:0.65,
   not:"Gerçekleşebilir koşul: \"Heke bê, dê biçim.\" Açık koşul yapısı.",
   her:["Heke were, dê biçim.", "Heke baş be, dê çêbe."],
   gen:["Heke... be, dê... be", "Şerta vekirî"]),

  // Pasif yapılar
  (id:"b2_ps01", ku:"Pirtûk hat nivîsandin", tr:"Kitap yazıldı", en:"The book was written",
   cins:"bêcins", ez:null, kat:"pasif", zor:0.65,
   not:"Pasif yapı: \"hat + mastar\". \"Pirtûk hat weşandin\" = kitap yayımlandı.",
   her:["Pirtûk hat nivîsandin.", "Biryar hat dayîn."],
   gen:["Hat nivîsandin", "Pasîf hevok"]),

  (id:"b2_ps02", ku:"Tê gotin ku", tr:"Söyleniyor ki / Deniliyor ki", en:"It is said that",
   cins:"bêcins", ez:null, kat:"pasif", zor:0.66,
   not:"\"Tê gotin ku\" = deniliyor ki. Belirsiz özne pasifi. Akademik bağlamda sık.",
   her:["Tê gotin ku baş e.", "Tê bawerkirin ku..."],
   gen:["Tê gotin ku", "Tê bawerkirin ku"]),

  // Mastar yapıları
  (id:"b2_ms01", ku:"Xwendin girîng e", tr:"Okumak önemlidir", en:"Reading is important",
   cins:"bêcins", ez:null, kat:"mastar", zor:0.67,
   not:"Mastar isim görevinde: \"Xwendin + copula\". Örn: \"Axaftin zehmet e.\"",
   her:["Xwendin girîng e.", "Fêrbûn zehmet e."],
   gen:["Mastar + lêker", "Xwendin baş e."]),

  // Ergatif örnekler
  (id:"b2_er01", ku:"Min gotibû ku", tr:"Demiştim ki", en:"I had said that",
   cins:"bêcins", ez:null, kat:"ergatif_b2", zor:0.65,
   not:"\"Min gotibû ku\" = demiştim ki. Ergatif geçmiş mükemmel. Min + geçişli fiil.",
   her:["Min gotibû ku were.", "Min nivîsibû ku baş e."],
   gen:["Min gotibû ku", "Min... bû"]),

  // Pîşe (meslekler B2)
  (id:"b2_pi01", ku:"Edîtorê wêjeyî", tr:"Edebi editör", en:"Literary editor",
   cins:"bêcins", ez:"edîtorê wêjeyî", kat:"pîşe", zor:0.65,
   not:"\"Edîtor\"+\"wêjeyî\". Yayın dünyası mesleği.",
   her:["Ew edîtorê wêjeyî ye.", "Edîtorê wêjeyî baş e."],
   gen:["Edîtorê wêjeyî", "Edîtorên me"]),

  (id:"b2_pi02", ku:"Pisporê çandê", tr:"Kültür uzmanı", en:"Culture specialist",
   cins:"bêcins", ez:"pisporê çandê", kat:"pîşe", zor:0.65,
   not:"\"Pispor\"+\"çandê\". Kültürel danışman.",
   her:["Pisporê çandê hat.", "Pisporê çandê ye."],
   gen:["Pisporê çandê", "Pisporên me"]),

  // Pêşgotin (söylem başlatıcılar)
  (id:"b2_pg01", ku:"Berî her tiştî", tr:"Her şeyden önce", en:"First of all",
   cins:"bêcins", ez:null, kat:"pêşgotin", zor:0.68,
   not:"\"Berî her tiştî\" = her şeyden önce. Akademik söylem açıcısı.",
   her:["Berî her tiştî, ez dixwazim...", "Berî her tiştî, girîng e ku..."],
   gen:["Berî her tiştî", "Berî her tiştî ye."]),

  (id:"b2_pg02", ku:"Di dawiyê de", tr:"Sonunda / Son olarak", en:"Finally / In the end",
   cins:"bêcins", ez:null, kat:"pêşgotin", zor:0.68,
   not:"\"Di dawiyê de\" = sonunda. Sonuç cümlesi açıcısı.",
   her:["Di dawiyê de, ez...", "Di dawiyê de, encam ev e."],
   gen:["Di dawiyê de", "Di dawiyê de hat."]),

  // Zaman ifadeleri B2
  (id:"b2_dm01", ku:"Di çarçoveya dîrokî de", tr:"Tarihsel çerçevede", en:"In a historical framework",
   cins:"bêcins", ez:null, kat:"dem", zor:0.64,
   not:"\"Çarçowe\"+\"dîrokî\". Akademik bağlam kalıbı.",
   her:["Di çarçoveya dîrokî de.", "Di çarçoveya dîrokî de lêkolîn kir."],
   gen:["Di çarçoveya dîrokî de", "Di çarçoveyê de"]),

  (id:"b2_dm02", ku:"Di serdema nûjen a", tr:"Çağdaş dönemde", en:"In the modern era",
   cins:"bêcins", ez:null, kat:"dem", zor:0.65,
   not:"\"Di serdema nûjen de\" = çağdaş dönemde.",
   her:["Di serdema nûjen de.", "Di serdema nûjen de pêşket."],
   gen:["Di serdema nûjen de", "Serdema me"]),

  // Genel tamamlama
  (id:"b2_gn01", ku:"Komela sivîl", tr:"Sivil toplum", en:"Civil society",
   cins:"mê", ez:"komela sivîl", kat:"civakî", zor:0.66,
   not:"\"Komel\"+\"sivîl\". Kürt sivil toplum örgütleri.",
   her:["Komela sivîl girîng e.", "Di komela sivîl de."],
   gen:["Komela sivîl", "Komela me"]),

  (id:"b2_gn02", ku:"Xebatên mafparêzî", tr:"İnsan hakları çalışmaları", en:"Human rights work",
   cins:"bêcins", ez:"xebatên mafparêzî", kat:"zagon", zor:0.66,
   not:"\"Xebat\"+\"mafparêzî\". İnsan hakları savunuculuğu.",
   her:["Xebatên mafparêzî hene.", "Di xebatên mafparêzî de."],
   gen:["Xebatên mafparêzî", "Xebatên me"]),

  (id:"b2_gn03", ku:"Civaka jêrîn", tr:"Alt toplum / Sivil taban", en:"Grassroots",
   cins:"mê", ez:"civaka jêrîn", kat:"civakî", zor:0.65,
   not:"\"Civak\"+\"jêrîn\". Tabandan gelen hareketler.",
   her:["Civaka jêrîn çalak e.", "Di civaka jêrîn de."],
   gen:["Civaka jêrîn", "Civaka me"]),
];


final kB2_Tamam = [
  (id:"b2_tam01", ku:"Xebata hevpar", tr:"Ortak çalışma", en:"Collaborative work",
   cins:"mê", ez:"xebata hevpar", kat:"kar", zor:0.66,
   not:"\"Xebat\"+\"hevpar\". İşbirliği kültürü.",
   her:["Xebata hevpar baş e.", "Di xebata hevpar de ne."],
   gen:["Xebata hevpar", "Xebata me"]),
];
final kB2Temam2 = [...kB2_Tamam];

// TÜM kelimeler — vocabulary_browse_screen tarafından kullanılır
final kB2All = [...kB2Kelimeler, ...kB2EkKelimeler, ...kB2EkKelimeler2, ...kB2EkKelimeler3, ...kB2EkKelimeler4, ...kB2FerkeraEk, ...kB2Buyuk, ...kB2_Akademik, ...kB2_Hukuk, ...kB2_Kultur2, ...kB2_Son2, ...kB2_Final, ...kB2_Kapanis, ...kB2_Son90, ...kB2_Final46, ...kB2_Son18, ...kB2_Tamam];
