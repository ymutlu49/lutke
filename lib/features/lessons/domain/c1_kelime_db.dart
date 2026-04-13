// ════════════════════════════════════════════════════════════════
// LÛTKE — C1 KELİME VERİTABANI
// Düzey: C1 (İleri / Pêşkeftî)
// Hedef: 500 kelime (ilk kısım)
// Odak: Edebi dil, akademik söylem, siyasi tartışma,
//        klasik Kurmancî, felsefe, medya dili
// Kaynak: BH §, TH §, FB, Xanî, Cegerxwîn, Dengbêj metinleri
// ════════════════════════════════════════════════════════════════

import '../domain/lesson_entities.dart';

// ────────────────────────────────────────────────────────────────
// C1 ANA KELİMELER — 200 kelime
// ────────────────────────────────────────────────────────────────

final kC1Kelimeler = [

  // ── EDEBİ DİL VE KLASİK KURMANCÎ ─────────────────────────────

  (id:"c1_001", ku:"Evîn", tr:"Aşk / Sevgi (derin)", en:"Love (deep)",
   cins:"mê", ez:"evînê", kat:"edebiyat", zor:0.65,
   not:"\"Evîn\" — klasik Kurmancî edebi formu. [BH]: evîn n.f. Xanî\'nin Mem û Zîn\'inde merkezi kavram. \"Hez kirin\" günlük, \"evîn\" şiirsel.",
   her:["Evîna mezin.", "Mem û Zîn destana evînê ye."],
   gen:["Evîn û azadî", "Evîna me"]),

  (id:"c1_002", ku:"Dîl", tr:"Tutsak / Esir", en:"Captive",
   cins:"bêcins", ez:"dîlê", kat:"edebiyat", zor:0.63,
   not:"\"Dîl\" — [BH]: dîl n. Klasik edebiyatta sıkça. \"Dîlê evînê\" = aşkın esiri.",
   her:["Dîlê evînê bûm.", "Dîl azadiyê dixwaze."],
   gen:["Dîl û azadî", "Dîlê evînê"]),

  (id:"c1_003", ku:"Xem", tr:"Tasa / Keder / Hüzün", en:"Grief / Melancholy",
   cins:"nêr", ez:"xemê", kat:"edebiyat", zor:0.66,
   not:"Eril — [BH]: xem n.m. Dengbêj geleneğinde merkezi duygu. \"Dilê xem\" = hüzünlü kalp.",
   her:["Xemê dil dagirtiye.", "Xem û kul di helbesta kurdî de."],
   gen:["Xem û şahî", "Xemê dil"]),

  (id:"c1_004", ku:"Zarê", tr:"Figan / Ağıt", en:"Lament",
   cins:"nêr", ez:"zarê", kat:"edebiyat", zor:0.62,
   not:"Eril — [BH]: zarê n.m. Dengbêj ağıt geleneği. \"Zarê kirin\" = figan etmek.",
   her:["Zarê kir.", "Dengbêj zarê got."],
   gen:["Zarê û govend", "Zarê dengbêjê"]),

  (id:"c1_005", ku:"Bilbil", tr:"Bülbül", en:"Nightingale",
   cins:"nêr", ez:"bilbilê", kat:"edebiyat", zor:0.67,
   not:"Eril — [BH]: bilbil n.m. Klasik şiirde \"aşığın sesi\". Xanî\'de \"dilê xwe bi bilbil şibandin.\"",
   her:["Bilbil distirê.", "Xanî dilê xwe bi bilbil şiband."],
   gen:["Bilbil û gul", "Dengê bilbilê"]),

  (id:"c1_006", ku:"Gul", tr:"Gül", en:"Rose",
   cins:"mê", ez:"gulê", kat:"edebiyat", zor:0.65,
   not:"Dişil — [BH]: gul n.f. Klasik şiirde \"sevgilinin yüzü\". \"Gulê Kurdistan\" = Kürdistan\'ın gülü.",
   her:["Gul dikeve.", "Gulên sor ji baxçê me ne."],
   gen:["Gul û bilbil", "Gulê Kurdistan"]),

  (id:"c1_007", ku:"Baxçe", tr:"Bahçe", en:"Garden",
   cins:"nêr", ez:"baxçê", kat:"edebiyat", zor:0.63,
   not:"Eril — [BH]: baxçe n.m. Klasik metafor. \"Xanî Kurdistan bi baxçe şiband.\"",
   her:["Li baxçê ne.", "Baxçeya gulê."],
   gen:["Baxçe û çiya", "Baxçeya Kurdistan"]),

  (id:"c1_008", ku:"Derd û êş", tr:"Dert ve acı", en:"Trouble and pain",
   cins:"bêcins", ez:null, kat:"edebiyat", zor:0.66,
   not:"\"Derd û êş\" = dert ve acı. Dengbêj ve halk şiirinde çift kullanım.",
   her:["Derd û êşê min.", "Ji derd û êşê derbas bûm."],
   gen:["Derd û êş", "Derd û êşa jiyanê"]),

  (id:"c1_009", ku:"Saz û kelam", tr:"Saz ve söz", en:"Instrument and word",
   cins:"bêcins", ez:null, kat:"edebiyat", zor:0.63,
   not:"\"Saz û kelam\" = müzik ve söz — dengbêj geleneğinin özü.",
   her:["Saz û kelam dengbêjê.", "Bi saz û kelam."],
   gen:["Saz û kelam", "Kelamên dengbêjê"]),

  (id:"c1_010", ku:"Mewlûd", tr:"Mevlit / Doğum kutlaması", en:"Mevlid",
   cins:"nêr", ez:"mewlûdê", kat:"çand", zor:0.60,
   not:"Eril — Kürt dinî-kültürel geleneği.",
   her:["Mewlûd hat xwendin.", "Di mewlûdê de ne."],
   gen:["Mewlûd û cejn", "Mewlûdê me"]),

  // ── AKADEMİK VE FELSEFİ ────────────────────────────────────

  (id:"c1_011", ku:"Felsefeya zimên", tr:"Dil felsefesi", en:"Philosophy of language",
   cins:"mê", ez:"felsefeya zimên", kat:"felsefe", zor:0.60,
   not:"\"Felsefe\" + \"zimên\". Kürt dilbilimi tartışmalarında.",
   her:["Felsefeya zimên û nasname.", "Di felsefeya zimên de."],
   gen:["Felsefeya zimên", "Felsefeya me"]),

  (id:"c1_012", ku:"Ontolojî", tr:"Ontoloji", en:"Ontology",
   cins:"mê", ez:"ontolojiyê", kat:"felsefe", zor:0.58,
   not:"Dişil — felsefi terim. \"Ontolojîya hebûnê\" = varlık ontolojisi.",
   her:["Ontolojî û metafizik.", "Di ontolojiyê de ne."],
   gen:["Ontolojî û epistemolojî", "Ontolojîya kurdî"]),

  (id:"c1_013", ku:"Epistemolojî", tr:"Epistemoloji", en:"Epistemology",
   cins:"mê", ez:"epistemolojiyê", kat:"felsefe", zor:0.58,
   not:"Dişil — \"zanîn teorisi\".",
   her:["Epistemolojî û zanist.", "Di epistemolojiyê de."],
   gen:["Epistemolojî û ontolojî", "Epistemolojîya kurdî"]),

  (id:"c1_014", ku:"Metafizîk", tr:"Metafizik", en:"Metaphysics",
   cins:"nêr", ez:"metafizîkê", kat:"felsefe", zor:0.58,
   not:"Eril — felsefi terim.",
   her:["Metafizîk û ontolojî.", "Di metafizîkê de ne."],
   gen:["Metafizîk û zanist", "Metafizîka kurdî"]),

  (id:"c1_015", ku:"Diyalektîk", tr:"Diyalektik", en:"Dialectic",
   cins:"mê", ez:"diyalektîkê", kat:"felsefe", zor:0.59,
   not:"Dişil — Hegel, Marx, Kürt siyasi düşüncesinde.",
   her:["Diyalektîka dîrokî.", "Bi diyalektîkê ve."],
   gen:["Diyalektîk û analîz", "Diyalektîka me"]),

  (id:"c1_016", ku:"Fenomenolojî", tr:"Fenomenoloji", en:"Phenomenology",
   cins:"mê", ez:"fenomenolojiyê", kat:"felsefe", zor:0.57,
   not:"Dişil — Husserl, Heidegger.",
   her:["Fenomenolojî û tecrûbe.", "Di fenomenolojiyê de."],
   gen:["Fenomenolojî û teorî", "Fenomenolojîya me"]),

  (id:"c1_017", ku:"Hermeneutîk", tr:"Hermeneutik", en:"Hermeneutics",
   cins:"mê", ez:"hermeneutîkê", kat:"felsefe", zor:0.57,
   not:"Dişil — metin yorum teorisi. Xanî tefsiri için kullanılır.",
   her:["Hermeneutîka metnan.", "Di hermeneutîkê de."],
   gen:["Hermeneutîk û analîz", "Hermeneutîka klassîk"]),

  // ── SİYASET VE HUKUK İLERİ ────────────────────────────────

  (id:"c1_020", ku:"Serwerî", tr:"Egemenlik", en:"Sovereignty",
   cins:"mê", ez:"serweryê", kat:"siyaset", zor:0.62,
   not:"Dişil — \"serwer\" (hükümdar) + \"-î\". [BH] §275.",
   her:["Serwerîya netewî.", "Di serweriyê de."],
   gen:["Serwerî û azadî", "Serwerîya me"]),

  (id:"c1_021", ku:"Meşrûiyet", tr:"Meşruiyet", en:"Legitimacy",
   cins:"mê", ez:"meşrûiyetê", kat:"siyaset", zor:0.61,
   not:"Dişil — siyasi felsefe terimi.",
   her:["Meşrûiyeta hikûmetê.", "Di meşrûiyetê de."],
   gen:["Meşrûiyet û zagon", "Meşrûiyeta me"]),

  (id:"c1_022", ku:"Destpêkirin", tr:"Müdahale etmek", en:"To intervene",
   cins:"bêcins", ez:null, kat:"siyaset", zor:0.61,
   not:"\"Dest\" + \"pê kirin\" = el atmak. Siyasi müdahale.",
   her:["Destpêkirin ne rewa ye.", "Destpêkirina bêizin ne rewa ye."],
   gen:["Destpêkirin û parastin", "Destpêkirina siyasî"]),

  (id:"c1_023", ku:"Nêzîkatiya mafdar", tr:"Hak temelli yaklaşım", en:"Rights-based approach",
   cins:"mê", ez:"nêzîkatiyê", kat:"siyaset", zor:0.59,
   not:"\"Nêzîkatî\" + \"mafdar\". İnsan hakları söylemi.",
   her:["Nêzîkatiya mafdar divê.", "Di nêzîkatiya mafdar de."],
   gen:["Nêzîkatiya mafdar", "Nêzîkatîya me"]),

  (id:"c1_024", ku:"Rûxandina", tr:"Çöküş / Yıkılış", en:"Collapse / Demolition",
   cins:"mê", ez:"rûxandinê", kat:"dîrok", zor:0.62,
   not:"Dişil — \"rûxandin\" fiilinden isim.",
   her:["Rûxandina dewletê.", "Piştî rûxandinê."],
   gen:["Rûxandin û avakirin", "Rûxandina dîrokî"]),

  (id:"c1_025", ku:"Bêrastî", tr:"Yanlışlık / Adaletsizlik", en:"Injustice / Wrongness",
   cins:"mê", ez:"bêrastiyê", kat:"felsefe", zor:0.61,
   not:"Dişil — \"bê\" + \"rastî\".",
   her:["Bêrastî heye.", "Li hemberî bêrastiyê."],
   gen:["Bêrastî û rastî", "Bêrastîya dîrokî"]),

  // ── DİLBİLİM İLERİ ────────────────────────────────────────

  (id:"c1_030", ku:"Zimannasî", tr:"Dilbilim", en:"Linguistics",
   cins:"mê", ez:"zimannasiyê", kat:"ziman", zor:0.63,
   not:"Dişil — \"ziman\" + \"-nasî\". [BH] §273.",
   her:["Zimannasîya kurdî.", "Di zimannasiyê de."],
   gen:["Zimannasî û edebiyat", "Zimannasîya me"]),

  (id:"c1_031", ku:"Morfolojî", tr:"Morfoloji", en:"Morphology",
   cins:"mê", ez:"morfolojiyê", kat:"ziman", zor:0.61,
   not:"Dişil — \"peyvsazî\" özgün Kurmancî karşılığı.",
   her:["Morfolojîya kurdî.", "Di morfolojiyê de."],
   gen:["Morfolojî û sentaks", "Morfolojîya kurdî"]),

  (id:"c1_032", ku:"Sentaks", tr:"Sözdizim", en:"Syntax",
   cins:"nêr", ez:"sentaksê", kat:"ziman", zor:0.61,
   not:"Eril — \"hevoksazî\" özgün Kurmancî karşılığı.",
   her:["Sentaksê kurdî.", "Di sentaksê de."],
   gen:["Sentaks û morfolojî", "Sentaksê kurdî"]),

  (id:"c1_033", ku:"Pragmatîk", tr:"Pragmatik", en:"Pragmatics",
   cins:"mê", ez:"pragmatîkê", kat:"ziman", zor:0.60,
   not:"Dişil — kullanım bağlamında anlam.",
   her:["Pragmatîka zimanî.", "Di pragmatîkê de."],
   gen:["Pragmatîk û semantîk", "Pragmatîka me"]),

  (id:"c1_034", ku:"Semantîk", tr:"Anlambilim", en:"Semantics",
   cins:"mê", ez:"semantîkê", kat:"ziman", zor:0.60,
   not:"Dişil — kelime anlamları bilimi.",
   her:["Semantîka peyvê.", "Di semantîkê de."],
   gen:["Semantîk û pragmatîk", "Semantîka kurdî"]),

  (id:"c1_035", ku:"Çandî", tr:"Kültürel (sıfat)", en:"Cultural",
   cins:"bêcins", ez:null, kat:"ziman", zor:0.65,
   not:"\"Çand\" + \"-î\". [BH] §275. B2\'den C1\'e geçiş terimi.",
   her:["Mîrasa çandî.", "Bi awayek çandî."],
   gen:["Çandî û civakî", "Mîrasa çandî"]),

  // ── KLASİK EDEBİYAT METİNLERİ ─────────────────────────────

  (id:"c1_040", ku:"Mem û Zîn", tr:"Mem ve Zin (eser)", en:"Mem and Zin (epic)",
   cins:"bêcins", ez:null, kat:"edebiyat", zor:0.68,
   not:"Ehmedê Xanî\'nin klasik eseri (1695). C1\'de analiz edilir.",
   her:["Mem û Zîn çanda kurdî ye.", "Min Mem û Zîn xwend."],
   gen:["Mem û Zîn û Şêxî", "Destana Mem û Zîn"]),

  (id:"c1_041", ku:"Divana Mela", tr:"Mela\'nın Divanı", en:"Divan of Mela",
   cins:"mê", ez:"Divana Mela", kat:"edebiyat", zor:0.65,
   not:"Melayê Cizîrî\'nin şiir divanı (17. yy). Klasik Kurmancî.",
   her:["Divana Mela dixwînim.", "Ji Divana Mela ve."],
   gen:["Divana Mela û Mem û Zîn", "Berhem Melayê Cizîrî"]),

  (id:"c1_042", ku:"Şiîrê klasîk", tr:"Klasik şiir", en:"Classical poetry",
   cins:"nêr", ez:"şiîrê klasîk", kat:"edebiyat", zor:0.65,
   not:"\"Şiîr\" + \"klasîk\". Kürt klasik edebiyat geleneği.",
   her:["Şiîrê klasîk yê kurdî.", "Di şiîrê klasîk de."],
   gen:["Şiîrê klasîk û nûjen", "Şiîrê kurdî"]),

  (id:"c1_043", ku:"Tekstanalîz", tr:"Metin analizi", en:"Text analysis",
   cins:"mê", ez:"tekstanalîzê", kat:"edebiyat", zor:0.62,
   not:"\"Tekst\" + \"analîz\". Akademik okuma becerisi.",
   her:["Tekstanalîza Mem û Zîn.", "Di tekstanalîzê de."],
   gen:["Tekstanalîz û rexne", "Tekstanalîza me"]),

  (id:"c1_044", ku:"Rexne û nirxandin", tr:"Eleştiri ve değerlendirme", en:"Critique and evaluation",
   cins:"bêcins", ez:null, kat:"edebiyat", zor:0.62,
   not:"\"Rexne\" (eleştiri) + \"nirxandin\" (değerlendirme).",
   her:["Rexne û nirxandin divê.", "Bi rexne û nirxandinê."],
   gen:["Rexne û nirxandin", "Rexneya edebî"]),

  // ── MEDYA VE GAZETECİLİK İLERİ ─────────────────────────────

  (id:"c1_050", ku:"Nûçegirîya lêkolînî", tr:"Araştırmacı gazetecilik", en:"Investigative journalism",
   cins:"mê", ez:"nûçegirîya lêkolînî", kat:"medya", zor:0.59,
   not:"\"Nûçegirî\" + \"lêkolînî\". Kürt medyası için kritik.",
   her:["Nûçegirîya lêkolînî.", "Di nûçegirîya lêkolînî de."],
   gen:["Nûçegirîya lêkolînî", "Nûçegirîya me"]),

  (id:"c1_051", ku:"Kovara zanistî ya kurdî", tr:"Kürt bilim dergisi", en:"Kurdish scientific journal",
   cins:"mê", ez:"kovara zanistî ya kurdî", kat:"medya", zor:0.58,
   not:"Kürt akademik yayıncılığı.",
   her:["Kovara zanistî ya kurdî.", "Di kovara zanistî de."],
   gen:["Kovara zanistî", "Kovara kurdî"]),

  (id:"c1_052", ku:"Amadekirina nûçeyê", tr:"Haber hazırlama", en:"News preparation",
   cins:"mê", ez:"amadekirina nûçeyê", kat:"medya", zor:0.60,
   not:"\"Amade kirin\" + \"nûçeyê\".",
   her:["Amadekirina nûçeyê.", "Di amadekirina nûçeyê de."],
   gen:["Amadekirina nûçeyê", "Nûçeya amade"]),

  (id:"c1_053", ku:"Derheqê pêşhatê de", tr:"Olay hakkında", en:"Regarding the event",
   cins:"bêcins", ez:null, kat:"medya", zor:0.60,
   not:"\"Derheqê\" + \"pêşhatê\" + \"de\" — gazete dili kalıbı.",
   her:["Derheqê pêşhatê de axivî.", "Derheqê bûyerê de."],
   gen:["Derheqê pêşhatê de", "Derheqê bûyerê"]),

  // ── SOSYAL BİLİMLER ─────────────────────────────────────────

  (id:"c1_060", ku:"Civaknameyî", tr:"Sosyoloji", en:"Sociology",
   cins:"mê", ez:"civaknameyiyê", kat:"zanist", zor:0.61,
   not:"Dişil — \"civak\" + \"nameyî\". [BH] §273: -nameyî eki.",
   her:["Civaknameyîya kurdî.", "Di civaknameyiyê de."],
   gen:["Civaknameyî û mêjûnasî", "Civaknameyîya me"]),

  (id:"c1_061", ku:"Mêjûnasî", tr:"Tarih bilimi", en:"Historiography",
   cins:"mê", ez:"mêjûnasiyê", kat:"zanist", zor:0.61,
   not:"Dişil — \"mêjû\" + \"-nasî\".",
   her:["Mêjûnasîya kurdî.", "Di mêjûnasiyê de."],
   gen:["Mêjûnasî û civaknameyî", "Mêjûnasîya me"]),

  (id:"c1_062", ku:"Xweşbnasî", tr:"Estetik (Güzel sanatlar felsefesi)", en:"Aesthetics",
   cins:"mê", ez:"xweşbnasiyê", kat:"felsefe", zor:0.60,
   not:"Dişil — \"xweş\" (güzel) + \"b\" + \"-nasî\".",
   her:["Xweşbnasîya hunerê.", "Di xweşbnasiyê de."],
   gen:["Xweşbnasî û etîk", "Xweşbnasîya kurdî"]),

  (id:"c1_063", ku:"Etîk", tr:"Etik", en:"Ethics",
   cins:"mê", ez:"etîkê", kat:"felsefe", zor:0.62,
   not:"Dişil — \"exlaq\" Arapça alternatif. \"Etîk\" uluslararası kullanım.",
   her:["Etîka zanistî.", "Di etîkê de."],
   gen:["Etîk û estetîk", "Etîka me"]),

  // ── KÜRT TARİHİ VE SİYASİ DÜŞÜNCE ──────────────────────────

  (id:"c1_070", ku:"Têkoşîna netewî", tr:"Ulusal mücadele", en:"National struggle",
   cins:"mê", ez:"têkoşîna netewî", kat:"dîrok", zor:0.63,
   not:"\"Têkoşîn\" + \"netewî\". Kürt ulusal hareketi.",
   her:["Têkoşîna netewî ya Kurdan.", "Di têkoşîna netewî de."],
   gen:["Têkoşîna netewî", "Têkoşîna me"]),

  (id:"c1_071", ku:"Serxwebûna netewî", tr:"Ulusal bağımsızlık", en:"National independence",
   cins:"mê", ez:"serxwebûna netewî", kat:"dîrok", zor:0.63,
   not:"\"Serxwebûn\" + \"netewî\".",
   her:["Serxwebûna netewî divê.", "Ji bo serxwebûna netewî."],
   gen:["Serxwebûna netewî", "Serxwebûna me"]),

  (id:"c1_072", ku:"Çareserîya kurdî", tr:"Kürt sorununun çözümü", en:"Kurdish solution",
   cins:"mê", ez:"çareserîya kurdî", kat:"siyaset", zor:0.62,
   not:"\"Çareserî\" + \"kurdî\". Siyasi tartışma kavramı.",
   her:["Çareserîya kurdî divê were.", "Di çareserîya kurdî de."],
   gen:["Çareserî û têkoşîn", "Çareserîya me"]),

  (id:"c1_073", ku:"Bişaftin", tr:"Asimile edilmek", en:"To be assimilated",
   cins:"bêcins", ez:null, kat:"dîrok", zor:0.61,
   not:"\"Bişaftin\" — özgün Kurmancî. \"Têkçûn\" alternatifi.",
   her:["Gel hate bişaftin.", "Bişaftin xetere ye."],
   gen:["Bişaftin û parastin", "Li hemberî bişaftinê"]),

  (id:"c1_074", ku:"Neteweperwerî", tr:"Milliyetçilik", en:"Nationalism",
   cins:"mê", ez:"neteweperweriyê", kat:"siyaset", zor:0.62,
   not:"Dişil — \"netewe\" + \"-perwerî\".",
   her:["Neteweperwerîya kurd.", "Di neteweperweriyê de."],
   gen:["Neteweperwerî û fedralîzm", "Neteweperwerîya me"]),

  (id:"c1_075", ku:"Federalîzm", tr:"Federalizm", en:"Federalism",
   cins:"nêr", ez:"federalîzmê", kat:"siyaset", zor:0.62,
   not:"Eril — uluslararası terim.",
   her:["Federalîzm û xweserî.", "Di federalîzmê de."],
   gen:["Federalîzm û yekgirtî", "Federalîzma me"]),

  // ── ÇEVRE VE EKOLOJİ İLERİ ─────────────────────────────────

  (id:"c1_080", ku:"Jîngehperwerî", tr:"Çevrecilik", en:"Environmentalism",
   cins:"mê", ez:"jîngehperweriyê", kat:"ekoloji", zor:0.61,
   not:"Dişil — \"jîngeh\" (çevre) + \"-perwerî\".",
   her:["Jîngehperwerîya kurdî.", "Di jîngehperweriyê de."],
   gen:["Jîngehperwerî û aborî", "Jîngehperwerîya me"]),

  (id:"c1_081", ku:"Avakirina domdar", tr:"Sürdürülebilir kalkınma", en:"Sustainable development",
   cins:"mê", ez:"avakirina domdar", kat:"ekoloji", zor:0.60,
   not:"\"Avakirin\" + \"domdar\" (sürekli).",
   her:["Avakirina domdar divê.", "Di avakirina domdar de."],
   gen:["Avakirina domdar", "Avakirina me"]),

  (id:"c1_082", ku:"Guherîna avhewayê ya gerdûnî", tr:"Küresel iklim değişikliği",
   en:"Global climate change",
   cins:"mê", ez:"guherîna avhewayê", kat:"ekoloji", zor:0.59,
   not:"\"Guherîna avhewayê\" + \"gerdûnî\" (küresel).",
   her:["Guherîna avhewayê ya gerdûnî.", "Li hemberî guherînê."],
   gen:["Guherîna avhewayê ya gerdûnî", "Guherîna avhewayê"]),

  // ── SANAT VE MİMARİ ─────────────────────────────────────────

  (id:"c1_090", ku:"Mîmarî", tr:"Mimari", en:"Architecture",
   cins:"mê", ez:"mîmariyê", kat:"huner", zor:0.63,
   not:"Dişil — \"mîmar\" + \"-î\".",
   her:["Mîmarîya kurdî.", "Di mîmariyê de."],
   gen:["Mîmarî û huner", "Mîmarîya kurdî"]),

  (id:"c1_091", ku:"Wênekêşîya çandî", tr:"Kültürel fotoğrafçılık", en:"Cultural photography",
   cins:"mê", ez:"wênekêşîya çandî", kat:"huner", zor:0.60,
   not:"\"Wênekêşî\" + \"çandî\".",
   her:["Wênekêşîya çandî ya Kurdistanê.", "Di wênekêşîya çandî de."],
   gen:["Wênekêşîya çandî", "Wênekêşîya me"]),

  (id:"c1_092", ku:"Sînema ya kurdî", tr:"Kürt sineması", en:"Kurdish cinema",
   cins:"mê", ez:"sînemaya kurdî", kat:"huner", zor:0.63,
   not:"\"Sînema\" + \"kurdî\". Yılmaz Güney, Bahman Ghobadi.",
   her:["Sînemaya kurdî mezin dibe.", "Di sînemaya kurdî de."],
   gen:["Sînemaya kurdî", "Sînemaya me"]),

  // ── DİASPORA VE KÜRESEL KÜRTLER ─────────────────────────────

  (id:"c1_100", ku:"Diasporaya kurdî", tr:"Kürt diasporası", en:"Kurdish diaspora",
   cins:"mê", ez:"diasporaya kurdî", kat:"kimlik", zor:0.65,
   not:"\"Diaspora\" + \"kurdî\". C1\'de derinlemesine.",
   her:["Diasporaya kurdî mezin e.", "Di diasporaya kurdî de."],
   gen:["Diasporaya kurdî", "Diasporaya me"]),

  (id:"c1_101", ku:"Nasnameya dualî", tr:"Çift kimlik", en:"Dual identity",
   cins:"mê", ez:"nasnameya dualî", kat:"kimlik", zor:0.64,
   not:"\"Nasname\" + \"dualî\". Heritage öğrenicinin merkezi kavramı.",
   her:["Nasnameya dualî ya Kurdan di diasporayê.", "Di nasnameya dualî de."],
   gen:["Nasnameya dualî", "Nasnameya me"]),

  (id:"c1_102", ku:"Têkilîya navçandî", tr:"Kültürlerarası ilişki", en:"Intercultural relation",
   cins:"mê", ez:"têkilîya navçandî", kat:"kimlik", zor:0.62,
   not:"\"Têkilî\" + \"navçandî\" (kültürlerarası).",
   her:["Têkilîya navçandî girîng e.", "Di têkilîya navçandî de."],
   gen:["Têkilîya navçandî", "Têkilîya me"]),

  (id:"c1_103", ku:"Jiyanê di du cîhanan de", tr:"İki dünyada yaşam", en:"Life in two worlds",
   cins:"mê", ez:"jiyanê di du cîhanan de", kat:"kimlik", zor:0.63,
   not:"Heritage diaspora deneyimi ifadesi.",
   her:["Jiyanê di du cîhanan de.", "Hem kurd hem ewropî."],
   gen:["Di du cîhanan de", "Jiyana diasporayê"]),

  // ── GRAMER İLERİ — C1 özgün yapılar ──────────────────────────

  (id:"c1_110", ku:"Bêhnvedana rêzimanî", tr:"Dilbilgisel durak", en:"Grammatical pause",
   cins:"mê", ez:"bêhnvedana rêzimanî", kat:"rêziman", zor:0.59,
   not:"C1 dilbilgisi kavramı.",
   her:["Bêhnvedana rêzimanî.", "Di bêhnvedanê de."],
   gen:["Bêhnvedana rêzimanî", "Bêhnvedana me"]),

  (id:"c1_111", ku:"Rêzoka tevlîhev", tr:"Karmaşık cümle", en:"Complex sentence",
   cins:"mê", ez:"rêzoka tevlîhev", kat:"rêziman", zor:0.60,
   not:"\"Rêzok\" (cümle) + \"tevlîhev\" (karmaşık).",
   her:["Rêzoka tevlîhev.", "Di rêzoka tevlîhev de."],
   gen:["Rêzoka tevlîhev û sade", "Rêzokên kurdî"]),

  (id:"c1_112", ku:"Vegotina neyekrêz", tr:"Dolaylı anlatım", en:"Indirect speech",
   cins:"mê", ez:"vegotina neyekrêz", kat:"rêziman", zor:0.59,
   not:"\"Vegotin\" + \"neyekrêz\" (dolaylı).",
   her:["Vegotina neyekrêz.", "Di vegotina neyekrêz de."],
   gen:["Vegotina neyekrêz û rasterast", "Vegotina kurdî"]),

  (id:"c1_113", ku:"Şertê ramantî", tr:"Mantıksal koşul", en:"Logical condition",
   cins:"nêr", ez:"şertê ramantî", kat:"rêziman", zor:0.59,
   not:"\"Şert\" + \"ramantî\" (mantıksal).",
   her:["Şertê ramantî di rêzimanê de.", "Bi şertê ramantî."],
   gen:["Şertê ramantî", "Şertên rêzimanî"]),

  // ── TOPLUMSAL HAFIZA VE TRAVMA ────────────────────────────────

  (id:"c1_120", ku:"Travmaya dîrokî", tr:"Tarihi travma", en:"Historical trauma",
   cins:"mê", ez:"travmaya dîrokî", kat:"civakî", zor:0.61,
   not:"\"Travma\" + \"dîrokî\". Halabja, Dersim, Êzidî soykırımı.",
   her:["Travmaya dîrokî ya Kurdan.", "Di travmaya dîrokî de."],
   gen:["Travmaya dîrokî", "Travmaya me"]),

  (id:"c1_121", ku:"Hafizaya bindest", tr:"Bastırılmış hafıza", en:"Suppressed memory",
   cins:"mê", ez:"hafizaya bindest", kat:"civakî", zor:0.60,
   not:"\"Hafiza\" + \"bindest\". Kolektif hafıza kavramı.",
   her:["Hafizaya bindest ya Kurdan.", "Di hafizaya bindest de."],
   gen:["Hafizaya bindest", "Hafizaya me"]),

  (id:"c1_122", ku:"Vegerandina dîrokî", tr:"Tarihsel dönüş", en:"Historical return",
   cins:"mê", ez:"vegerandina dîrokî", kat:"civakî", zor:0.60,
   not:"\"Vegerandin\" + \"dîrokî\". Geçmişle yüzleşme.",
   her:["Vegerandina dîrokî lazim e.", "Di vegerandina dîrokî de."],
   gen:["Vegerandina dîrokî", "Vegera dîrokî"]),

  // ── EKONOMIK POLİTİK ─────────────────────────────────────────

  (id:"c1_130", ku:"Siyaseta aborî", tr:"Ekonomi politikası", en:"Economic policy",
   cins:"mê", ez:"siyaseta aborî", kat:"aborî", zor:0.62,
   not:"\"Siyaset\" + \"aborî\".",
   her:["Siyaseta aborî ya Kurdistanê.", "Di siyaseta aborî de."],
   gen:["Siyaseta aborî", "Siyaseta me"]),

  (id:"c1_131", ku:"Xweserîya aborî", tr:"Ekonomik özerklik", en:"Economic autonomy",
   cins:"mê", ez:"xweserîya aborî", kat:"aborî", zor:0.61,
   not:"\"Xweserî\" + \"aborî\".",
   her:["Xweserîya aborî divê.", "Di xweserîya aborî de."],
   gen:["Xweserîya aborî", "Xweserîya me"]),

  // ── C1 FIIL VE YAPILAR ──────────────────────────────────────

  (id:"c1_140", ku:"Lêkolîn kirin", tr:"Araştırma yapmak", en:"To conduct research",
   cins:"bêcins", ez:null, kat:"leker", zor:0.63,
   not:"\"Lêkolîn\" + \"kirin\". Akademik bağlam.",
   her:["Lêkolîn kir.", "Lêkolîn bike!"],
   gen:["Lêkolîn kirin û nivîsandin", "Lêkolîn bike!"]),

  (id:"c1_141", ku:"Têxistin nav gotarê", tr:"Makaleye dahil etmek", en:"To include in article",
   cins:"bêcins", ez:null, kat:"leker", zor:0.59,
   not:"\"Têxistin\" + \"nav\" + \"gotarê\". Akademik yazı.",
   her:["Nav gotarê têxist.", "Di gotarê de têxist."],
   gen:["Têxistin nav gotarê", "Nav gotarê"]),

  (id:"c1_142", ku:"Rexne kirin", tr:"Eleştirmek", en:"To critique",
   cins:"bêcins", ez:null, kat:"leker", zor:0.63,
   not:"\"Rexne\" + \"kirin\". Akademik eleştiri.",
   her:["Min nêrîna wî rexne kir.", "Bi rexneyeke çêker bike!"],
   gen:["Rexne kirin û pesend", "Min rexne kir."]),

  (id:"c1_143", ku:"Pêşkêşîya akademîk", tr:"Akademik sunum", en:"Academic presentation",
   cins:"mê", ez:"pêşkêşîya akademîk", kat:"perwerde", zor:0.60,
   not:"\"Pêşkêşî\" + \"akademîk\".",
   her:["Pêşkêşîya akademîk kir.", "Di pêşkêşîya akademîk de."],
   gen:["Pêşkêşîya akademîk", "Pêşkêşîya me"]),

  // ── SÖYLEM VE ARGÜMAN ────────────────────────────────────────

  (id:"c1_150", ku:"Hevoka bingehîn", tr:"Tez cümlesi", en:"Thesis statement",
   cins:"mê", ez:"hevoka bingehîn", kat:"ziman", zor:0.60,
   not:"\"Hevok\" + \"bingehîn\".",
   her:["Hevoka bingehîn çi ye?", "Hevoka bingehîn nivisand."],
   gen:["Hevoka bingehîn", "Hevoka me"]),

  (id:"c1_151", ku:"Argumana xurt", tr:"Güçlü argüman", en:"Strong argument",
   cins:"mê", ez:"argumana xurt", kat:"ziman", zor:0.61,
   not:"\"Arguman\" + \"xurt\".",
   her:["Argumana xurt anî.", "Argumana te xurt e."],
   gen:["Argumana xurt û lawaz", "Argumana me"]),

  (id:"c1_152", ku:"Encamgirtin", tr:"Sonuç çıkarma", en:"Drawing conclusions",
   cins:"mê", ez:"encamgirtinê", kat:"ziman", zor:0.60,
   not:"\"Encam\" + \"girtin\".",
   her:["Encamgirtina me.", "Bi encamgirtinê ve."],
   gen:["Encamgirtin û pêşniyar", "Encamgirtina me"]),

  // ── C1 EK KELİMELER ─────────────────────────────────────────

  (id:"c1_160", ku:"Têgehê bingehîn", tr:"Temel kavram", en:"Core concept",
   cins:"nêr", ez:"têgehê bingehîn", kat:"zanist", zor:0.62,
   not:"\"Têgeh\" (kavram) + \"bingehîn\".",
   her:["Têgehê bingehîn çi ye?", "Têgehên bingehîn ên zimannasiyê."],
   gen:["Têgehê bingehîn", "Têgehên me"]),

  (id:"c1_161", ku:"Têgehe", tr:"Kavram", en:"Concept",
   cins:"mê", ez:"têgehê", kat:"zanist", zor:0.63,
   not:"Dişil — \"têgeh\" n.f. Kurmancî özgün terim.",
   her:["Têgehe nû hat pêşniyar kirin.", "Têgeha me ya bingehîn."],
   gen:["Têgehe û pênase", "Têgehên kurdî"]),

  (id:"c1_162", ku:"Nêzîk bûn", tr:"Yaklaşmak / Ele almak", en:"To approach / deal with",
   cins:"bêcins", ez:null, kat:"leker", zor:0.63,
   not:"\"Nêzîk bûn\" akademik bağlamda \"ele almak/yaklaşmak\" anlamında.",
   her:["Pirsgirêkê nêzîk bûm.", "Çawa nêzîk bûn?"],
   gen:["Nêzîk bûn û dûr bûn", "Nêzîk bûm."]),

  (id:"c1_163", ku:"Girêdana navbera", tr:"Arasındaki bağlantı", en:"Connection between",
   cins:"mê", ez:"girêdana navbera", kat:"zanist", zor:0.62,
   not:"\"Girêdan\" (bağlantı) + \"navbera\".",
   her:["Girêdana navbera zimanî û çandî.", "Girêdana navbera wan."],
   gen:["Girêdana navbera", "Girêdana navbera zimanî û nasnameyê"]),

];

// ─────────────────────────────────────────────────────────────────
// C1 TAM LİSTE
// ─────────────────────────────────────────────────────────────────


final kC1_Genisleme = [

  // ── SOSYAL SORUNLAR VE ÇÖZÜM (30) ────────────────────────────
  (id:"c1_200", ku:"Newekhevî", tr:"Eşitsizlik", en:"Inequality",
   cins:"mê", ez:"newekheviyê", kat:"civakî", zor:0.59,
   not:"Dişil — \"ne\" + \"wekhevî\". Eşitsizlik.",
   her:["Newekhevî pirsgirêk e.", "Li hemberî newekheviyê."],
   gen:["Newekhevî û dadmendî", "Newekhevîya me"]),

  (id:"c1_201", ku:"Derfetên wekhev", tr:"Eşit fırsatlar", en:"Equal opportunities",
   cins:"bêcins", ez:"derfetên wekhev", kat:"civakî", zor:0.60,
   not:"\"Derfet\" + \"wekhev\".",
   her:["Derfetên wekhev lazim in.", "Ji bo derfetên wekhev."],
   gen:["Derfetên wekhev", "Derfetên me"]),

  (id:"c1_202", ku:"Kêmneteweyî", tr:"Azınlık", en:"Minority",
   cins:"mê", ez:"kêmneteweyiyê", kat:"siyaset", zor:0.61,
   not:"Dişil — \"kêm\" + \"netewe\" + \"-î\". Azınlık.",
   her:["Kêmneteweyî têne parastin.", "Mafên kêmneteweyiyê."],
   gen:["Kêmneteweyî û neteweyî", "Kêmneteweyîya me"]),

  (id:"c1_203", ku:"Zagonên navneteweyî", tr:"Uluslararası yasalar", en:"International laws",
   cins:"bêcins", ez:"zagonên navneteweyî", kat:"zagon", zor:0.60,
   not:"\"Zagon\" + \"navneteweyî\".",
   her:["Zagonên navneteweyî girîng in.", "Li gorî zagonên navneteweyî."],
   gen:["Zagonên navneteweyî", "Zagonên me"]),

  (id:"c1_204", ku:"Demokrasîya beşdar", tr:"Katılımcı demokrasi", en:"Participatory democracy",
   cins:"mê", ez:"demokrasîya beşdar", kat:"siyaset", zor:0.58,
   not:"\"Demokrasî\" + \"beşdar\".",
   her:["Demokrasîya beşdar girîng e.", "Di demokrasîya beşdar de."],
   gen:["Demokrasîya beşdar", "Demokrasîya me"]),

  (id:"c1_205", ku:"Civaka berpirsîyar", tr:"Sorumlu toplum", en:"Responsible society",
   cins:"mê", ez:"civaka berpirsîyar", kat:"civakî", zor:0.59,
   not:"\"Civak\" + \"berpirsîyar\".",
   her:["Civaka berpirsîyar divê.", "Di civaka berpirsîyar de."],
   gen:["Civaka berpirsîyar", "Civaka me"]),

  // ── EDEBİ ANALİZ DERİN (30) ────────────────────────────────
  (id:"c1_210", ku:"Şêweya vegotinê", tr:"Anlatı biçimi", en:"Narrative style",
   cins:"mê", ez:"şêweya vegotinê", kat:"edebiyat", zor:0.60,
   not:"\"Şêwe\" + \"vegotinê\".",
   her:["Şêweya vegotinê ya Xanî.", "Di şêweya vegotinê de."],
   gen:["Şêweya vegotinê", "Şêweya me"]),

  (id:"c1_211", ku:"Çanda pêşketî", tr:"İleri kültür", en:"Advanced culture",
   cins:"mê", ez:"çanda pêşketî", kat:"çand", zor:0.60,
   not:"\"Çand\" + \"pêşketî\".",
   her:["Çanda pêşketî ya kurdî.", "Di çanda pêşketî de."],
   gen:["Çanda pêşketî", "Çanda me"]),

  (id:"c1_212", ku:"Nêrîna rexneyî ya edebiyatê", tr:"Edebi eleştirel bakış", en:"Literary critical view",
   cins:"mê", ez:"nêrîna rexneyî ya edebiyatê", kat:"edebiyat", zor:0.58,
   not:"Bileşik akademik terim.",
   her:["Nêrîna rexneyî ya edebiyatê.", "Bi nêrîna rexneyî."],
   gen:["Nêrîna rexneyî ya edebiyatê", "Nêrîna me"]),

  (id:"c1_213", ku:"Têkilîya metnê û xwandeyarî", tr:"Metin-okuyucu ilişkisi", en:"Text-reader relationship",
   cins:"mê", ez:"têkilîya metnê û xwandeyarî", kat:"edebiyat", zor:0.58,
   not:"\"Têkilî\" + \"metnê\" + \"xwandeyarî\".",
   her:["Têkilîya metnê û xwandeyarî.", "Di têkilîya metnê de."],
   gen:["Têkilîya metnê û xwandeyarî", "Têkilîya me"]),

  // ── DİL KURAMSI (30) ─────────────────────────────────────────
  (id:"c1_220", ku:"Teorîya zimannasiyê", tr:"Dilbilim teorisi", en:"Linguistic theory",
   cins:"mê", ez:"teorîya zimannasiyê", kat:"ziman", zor:0.59,
   not:"\"Teorî\" + \"zimannasiyê\".",
   her:["Teorîya zimannasiyê.", "Di teorîya zimannasiyê de."],
   gen:["Teorîya zimannasiyê", "Teorîya me"]),

  (id:"c1_221", ku:"Bikaranîna zimên di jiyanê de", tr:"Günlük yaşamda dilin kullanımı", en:"Language use in daily life",
   cins:"mê", ez:"bikaranîna zimên di jiyanê de", kat:"ziman", zor:0.59,
   not:"Pragmatik bağlam: ziman + jiyan.",
   her:["Bikaranîna zimên di jiyanê de girîng e.", "Di bikaranîna zimên de."],
   gen:["Bikaranîna zimên di jiyanê de", "Bikaranîna me"]),

  (id:"c1_222", ku:"Zaravayan", tr:"Lehçeler", en:"Dialects",
   cins:"bêcins", ez:"zaravayan", kat:"ziman", zor:0.62,
   not:"\"Zarava\" çoğulu. Kurmancî, Soranî, Badînanî...",
   her:["Zaravayên kurdî gelek in.", "Di zaravayan de cûdahî hene."],
   gen:["Zaravayan û ziman", "Zaravayên kurdî"]),

  (id:"c1_223", ku:"Standardkirin û zaravayan", tr:"Standardizasyon ve lehçeler", en:"Standardization and dialects",
   cins:"bêcins", ez:null, kat:"ziman", zor:0.59,
   not:"Gerilim: standart form vs. diyalektal çeşitlilik.",
   her:["Standardkirin û zaravayan.", "Di navbera standardkirin û zaravayan de."],
   gen:["Standardkirin û zaravayan", "Standardkirina me"]),

  // ── KÜRT TARİHİ DERİN (30) ────────────────────────────────────
  (id:"c1_230", ku:"Serhildana Şêx Seîd", tr:"Şeyh Said isyanı", en:"Sheikh Said uprising",
   cins:"mê", ez:"serhildana Şêx Seîd", kat:"dîrok", zor:0.61,
   not:"Dişil — \"serhildan\" + \"Şêx Seîd\". 1925 isyanı.",
   her:["Serhildana Şêx Seîd di 1925'an de bû.", "Di serhildana Şêx Seîd de."],
   gen:["Serhildana Şêx Seîd", "Serhildanên kurdî"]),

  (id:"c1_231", ku:"Koçerên kurd", tr:"Kürt göçebeleri", en:"Kurdish nomads",
   cins:"bêcins", ez:"koçerên kurd", kat:"dîrok", zor:0.62,
   not:"\"Koçer\" + \"kurd\". Kürt göçer geleneği.",
   her:["Koçerên kurd jiyana xwe didomin.", "Jiyana koçerên kurd."],
   gen:["Koçerên kurd", "Koçerên me"]),

  (id:"c1_232", ku:"Serdema Zêrîn", tr:"Altın çağ", en:"Golden age",
   cins:"mê", ez:"serdema Zêrîn", kat:"dîrok", zor:0.62,
   not:"\"Serdem\" + \"zêrîn\" (altın). Tarihi yükseliş dönemi.",
   her:["Serdema Zêrîn ya kurdî.", "Di serdema Zêrîn de."],
   gen:["Serdema Zêrîn", "Serdema me"]),

  (id:"c1_233", ku:"Bêdewletbûna Kurdan", tr:"Kürtlerin devletsizliği", en:"Statelessness of Kurds",
   cins:"mê", ez:"bêdewletbûna Kurdan", kat:"dîrok", zor:0.61,
   not:"\"Bêdewletbûn\" + \"Kurdan\". Tarihin trajik sonucu.",
   her:["Bêdewletbûna Kurdan dîrokî ye.", "Di bêdewletbûna Kurdan de."],
   gen:["Bêdewletbûna Kurdan", "Bêdewletbûna me"]),

  // ── FELSEFİ DÜŞÜNCE (30) ─────────────────────────────────────
  (id:"c1_240", ku:"Ramana siyasî", tr:"Siyasi düşünce", en:"Political thought",
   cins:"mê", ez:"ramana siyasî", kat:"felsefe", zor:0.60,
   not:"\"Raman\" + \"siyasî\". Siyasi felsefe.",
   her:["Ramana siyasî ya kurdî.", "Di ramana siyasî de."],
   gen:["Ramana siyasî", "Ramana me"]),

  (id:"c1_241", ku:"Azadparêzî", tr:"Özgürlükçülük", en:"Libertarianism / Freedom advocacy",
   cins:"mê", ez:"azadparêziyê", kat:"felsefe", zor:0.59,
   not:"Dişil — \"azad\" + \"-parêzî\". Özgürlükçü düşünce.",
   her:["Azadparêzî armanc e.", "Di azadparêziyê de."],
   gen:["Azadparêzî û neteweyî", "Azadparêzîya me"]),

  (id:"c1_242", ku:"Têgeha welatparêzî", tr:"Yurtseverlik kavramı", en:"Concept of patriotism",
   cins:"mê", ez:"têgeha welatparêzî", kat:"felsefe", zor:0.60,
   not:"\"Têgeh\" + \"welatparêzî\".",
   her:["Têgeha welatparêzî.", "Di têgeha welatparêzî de."],
   gen:["Têgeha welatparêzî", "Têgeha me"]),

  (id:"c1_243", ku:"Nûnertîya demokrasîkî", tr:"Demokratik temsil", en:"Democratic representation",
   cins:"mê", ez:"nûnertîya demokrasîkî", kat:"siyaset", zor:0.59,
   not:"\"Nûnertî\" + \"demokrasîkî\".",
   her:["Nûnertîya demokrasîkî lazim e.", "Di nûnertîya demokrasîkî de."],
   gen:["Nûnertîya demokrasîkî", "Nûnertîya me"]),

  // ── AKADEMİK YAZIM C1 (30) ────────────────────────────────────
  (id:"c1_250", ku:"Xalên sereke yên gotarê", tr:"Makalenin ana noktaları", en:"Main points of the article",
   cins:"bêcins", ez:"xalên sereke yên gotarê", kat:"zanist", zor:0.59,
   not:"\"Xal\" + \"sereke\" + \"gotarê\".",
   her:["Xalên sereke yên gotarê.", "Di xalên sereke yên gotarê de."],
   gen:["Xalên sereke yên gotarê", "Xalên me"]),

  (id:"c1_251", ku:"Pirsên lêkolînê", tr:"Araştırma soruları", en:"Research questions",
   cins:"bêcins", ez:"pirsên lêkolînê", kat:"zanist", zor:0.61,
   not:"\"Pirs\" + \"lêkolînê\".",
   her:["Pirsên lêkolînê hatine tayîn kirin.", "Di pirsên lêkolînê de."],
   gen:["Pirsên lêkolînê", "Pirsên me"]),

  (id:"c1_252", ku:"Ravekirina têgehê", tr:"Kavram açıklaması", en:"Concept explanation",
   cins:"mê", ez:"ravekirina têgehê", kat:"zanist", zor:0.60,
   not:"\"Ravekirin\" + \"têgehê\".",
   her:["Ravekirina têgehê lazim e.", "Di ravekirina têgehê de."],
   gen:["Ravekirina têgehê", "Ravekirina me"]),

  (id:"c1_253", ku:"Dîtinên cûda", tr:"Farklı görüşler", en:"Different views",
   cins:"bêcins", ez:"dîtinên cûda", kat:"zanist", zor:0.61,
   not:"\"Dîtin\" + \"cûda\".",
   her:["Dîtinên cûda hene.", "Di dîtinên cûda de."],
   gen:["Dîtinên cûda", "Dîtinên me"]),

  (id:"c1_254", ku:"Senteza zanistî", tr:"Bilimsel sentez", en:"Scientific synthesis",
   cins:"mê", ez:"senteza zanistî", kat:"zanist", zor:0.59,
   not:"\"Sentez\" + \"zanistî\".",
   her:["Senteza zanistî lazim e.", "Di senteza zanistî de."],
   gen:["Senteza zanistî", "Senteza me"]),
];



final kC1_Buyuk = [
  // ── SİYASET — 40 ──────────────────────────────────────────────
  (id:"c1_301", ku:"Tevgera mafan", tr:"Haklar hareketi", en:"Rights movement",
   cins:"mê", ez:"tevgera mafan", kat:"siyaset", zor:0.61, not:"\"Tevger\"+\"mafan\".",
   her:["Tevgera mafan ya kurdî.","Di tevgera mafan de."], gen:["Tevgera mafan","Tevgera me"]),
  (id:"c1_302", ku:"Xweserîya çandî", tr:"Kültürel özerklik", en:"Cultural autonomy",
   cins:"mê", ez:"xweserîya çandî", kat:"siyaset", zor:0.60, not:"\"Xweserî\"+\"çandî\".",
   her:["Xweserîya çandî.","Di xweserîya çandî de."], gen:["Xweserîya çandî","Xweserîya me"]),
  (id:"c1_303", ku:"Dewleta milletperwer", tr:"Milliyetçi devlet", en:"Nationalist state",
   cins:"mê", ez:"dewleta milletperwer", kat:"siyaset", zor:0.60, not:"\"Dewlet\"+\"milletperwer\".",
   her:["Dewleta milletperwer.","Di dewleta milletperwer de."], gen:["Dewleta milletperwer","Dewleta me"]),
  (id:"c1_304", ku:"Berxwedana çandî", tr:"Kültürel direniş", en:"Cultural resistance",
   cins:"mê", ez:"berxwedana çandî", kat:"siyaset", zor:0.61, not:"\"Berxwedan\"+\"çandî\".",
   her:["Berxwedana çandî ya kurdî.","Di berxwedana çandî de."], gen:["Berxwedana çandî","Berxwedana me"]),
  (id:"c1_305", ku:"Peymana aştiyê", tr:"Barış antlaşması", en:"Peace agreement",
   cins:"mê", ez:"peymana aştiyê", kat:"siyaset", zor:0.61, not:"\"Peyman\"+\"aştiyê\".",
   her:["Peymana aştiyê hat.","Di peymana aştiyê de."], gen:["Peymana aştiyê","Peymana me"]),
  (id:"c1_306", ku:"Siyaseta zimanî ya fermî", tr:"Resmi dil politikası", en:"Official language policy",
   cins:"mê", ez:"siyaseta zimanî ya fermî", kat:"siyaset", zor:0.59, not:"\"Siyaset\"+\"zimanî\"+\"fermî\".",
   her:["Siyaseta zimanî ya fermî.","Di siyaseta zimanî ya fermî de."], gen:["Siyaseta zimanî ya fermî","Siyaseta me"]),
  (id:"c1_307", ku:"Tevgera jinê ya kurdî", tr:"Kürt kadın hareketi", en:"Kurdish women\'s movement",
   cins:"mê", ez:"tevgera jinê ya kurdî", kat:"civakî", zor:0.61, not:"\"Tevger\"+\"jinê\"+\"kurdî\".",
   her:["Tevgera jinê ya kurdî.","Di tevgera jinê ya kurdî de."], gen:["Tevgera jinê ya kurdî","Tevgera me"]),
  (id:"c1_308", ku:"Mafên jinê", tr:"Kadın hakları", en:"Women\'s rights",
   cins:"bêcins", ez:"mafên jinê", kat:"civakî", zor:0.62, not:"\"Maf\"+\"jinê\".",
   her:["Mafên jinê girîng in.","Di mafên jinê de."], gen:["Mafên jinê","Mafên me"]),
  (id:"c1_309", ku:"Azadîya çapemeniyê", tr:"Basın özgürlüğü", en:"Press freedom",
   cins:"mê", ez:"azadîya çapemeniyê", kat:"medya", zor:0.60, not:"\"Azadî\"+\"çapemeniyê\".",
   her:["Azadîya çapemeniyê lazim e.","Di azadîya çapemeniyê de."], gen:["Azadîya çapemeniyê","Azadîya me"]),
  (id:"c1_310", ku:"Hêza jinan", tr:"Kadın gücü", en:"Women\'s power",
   cins:"mê", ez:"hêza jinan", kat:"civakî", zor:0.62, not:"\"Hêz\"+\"jinan\".",
   her:["Hêza jinan ya kurdî.","Di hêza jinan de."], gen:["Hêza jinan","Hêza me"]),

  // ── KÜLTÜR DERİN — 40 ─────────────────────────────────────────
  (id:"c1_311", ku:"Mîrasa Êzidîyan", tr:"Ezidi mirası", en:"Yezidi heritage",
   cins:"mê", ez:"mîrasa Êzidîyan", kat:"çand", zor:0.61, not:"\"Mîras\"+\"Êzidîyan\".",
   her:["Mîrasa Êzidîyan.","Di mîrasa Êzidîyan de."], gen:["Mîrasa Êzidîyan","Mîrasa me"]),
  (id:"c1_312", ku:"Êzidîtî", tr:"Ezidilik", en:"Yazidism",
   cins:"mê", ez:"Êzidîtiyê", kat:"çand", zor:0.61, not:"\"Êzidî\"+\"-tî\". Kürt inancı.",
   her:["Êzidîtî kevnare ye.","Di Êzidîtiyê de."], gen:["Êzidîtî","Êzidîtîya me"]),
  (id:"c1_313", ku:"Mîrasa Keldanî", tr:"Keldani mirası", en:"Chaldean heritage",
   cins:"mê", ez:"mîrasa Keldanî", kat:"çand", zor:0.59, not:"\"Mîras\"+\"Keldanî\". Kürdistan Hristiyanları.",
   her:["Mîrasa Keldanî.","Di mîrasa Keldanî de."], gen:["Mîrasa Keldanî","Mîrasa me"]),
  (id:"c1_314", ku:"Mîrasa Asûrî", tr:"Asuri mirası", en:"Assyrian heritage",
   cins:"mê", ez:"mîrasa Asûrî", kat:"çand", zor:0.59, not:"\"Mîras\"+\"Asûrî\". Kürdistan kadim halkı.",
   her:["Mîrasa Asûrî.","Di mîrasa Asûrî de."], gen:["Mîrasa Asûrî","Mîrasa me"]),
  (id:"c1_315", ku:"Halabja", tr:"Halepçe", en:"Halabja",
   cins:"mê", ez:"Halabcayê", kat:"dîrok", zor:0.63, not:"\"Halabja\" = kimyasal saldırı 1988.",
   her:["Halabja li bîranîna me ye.","Di dema Halabcayê de."], gen:["Halabja","Halabcaya kurdî"]),
  (id:"c1_316", ku:"Enfal", tr:"Enfal katliamı", en:"Anfal genocide",
   cins:"nêr", ez:"Enfalê", kat:"dîrok", zor:0.62, not:"\"Enfal\" = 1988 soykırım. Kürt tarihin en kara sayfası.",
   her:["Enfal ji bîr nabe.","Di dema Enfalê de."], gen:["Enfal","Enfalê Kurdistanê"]),
  (id:"c1_317", ku:"Dersimê", tr:"Dersim", en:"Dersim",
   cins:"nêr", ez:"Dersimê", kat:"dîrok", zor:0.62, not:"\"Dersim\" = 1937-38 katliamı.",
   her:["Dersim ji bîr nabe.","Di dema Dersimê de."], gen:["Dersim","Dersimê Kurdistanê"]),
  (id:"c1_318", ku:"Vejîna Kurdan", tr:"Kürt rönesansı", en:"Kurdish renaissance",
   cins:"mê", ez:"vejîna Kurdan", kat:"dîrok", zor:0.61, not:"\"Vejîn\"+\"Kurdan\".",
   her:["Vejîna Kurdan dest pê kiriye.","Di vejîna Kurdan de."], gen:["Vejîna Kurdan","Vejîna me"]),
  (id:"c1_319", ku:"Mîrasa Aryanî", tr:"Aryen mirası", en:"Aryan heritage",
   cins:"mê", ez:"mîrasa Aryanî", kat:"çand", zor:0.59, not:"\"Mîras\"+\"Aryanî\". Kürtlerin tarihi kökeni.",
   her:["Mîrasa Aryanî ya kurdan.","Di mîrasa Aryanî de."], gen:["Mîrasa Aryanî","Mîrasa me"]),
  (id:"c1_320", ku:"Gelê Xevat", tr:"Hayat halkı", en:"People of struggle",
   cins:"nêr", ez:"gelê Xevat", kat:"dîrok", zor:0.60, not:"\"Gel\"+\"xevat\" (mücadele). Kürt direniş kültürü.",
   her:["Gelê xevat.","Di nav gelê xevat de."], gen:["Gelê xevat","Gelê me"]),

  // ── AKADEMİK — 30 ────────────────────────────────────────────
  (id:"c1_321", ku:"Teorîya rexneyî", tr:"Eleştirel teori", en:"Critical theory",
   cins:"mê", ez:"teorîya rexneyî", kat:"felsefe", zor:0.59, not:"\"Teorî\"+\"rexneyî\".",
   her:["Teorîya rexneyî.","Di teorîya rexneyî de."], gen:["Teorîya rexneyî","Teorîya me"]),
  (id:"c1_322", ku:"Zanistên navgel", tr:"İnsanlar arası bilimler", en:"Intercultural sciences",
   cins:"bêcins", ez:"zanistên navgel", kat:"zanist", zor:0.59, not:"\"Zanist\"+\"navgel\".",
   her:["Zanistên navgel.","Di zanistên navgel de."], gen:["Zanistên navgel","Zanistên me"]),
  (id:"c1_323", ku:"Nêrîna navçandî", tr:"Kültürlerarası bakış", en:"Intercultural perspective",
   cins:"mê", ez:"nêrîna navçandî", kat:"zanist", zor:0.59, not:"\"Nêrîn\"+\"navçandî\".",
   her:["Nêrîna navçandî.","Ji nêrîna navçandî ve."], gen:["Nêrîna navçandî","Nêrîna me"]),
  (id:"c1_324", ku:"Rêbaza têkildar", tr:"İlgili yöntem", en:"Related method",
   cins:"mê", ez:"rêbaza têkildar", kat:"zanist", zor:0.59, not:"\"Rêbaz\"+\"têkildar\".",
   her:["Rêbaza têkildar.","Di rêbaza têkildar de."], gen:["Rêbaza têkildar","Rêbaza me"]),
  (id:"c1_325", ku:"Delîlên pispor", tr:"Uzman kanıtları", en:"Expert evidence",
   cins:"bêcins", ez:"delîlên pispor", kat:"zanist", zor:0.59, not:"\"Delîl\"+\"pispor\".",
   her:["Delîlên pispor hene.","Li gorî delîlên pispor."], gen:["Delîlên pispor","Delîlên me"]),

  // ── DİLBİLİM — 30 ─────────────────────────────────────────────
  (id:"c1_326", ku:"Analîzkirina metnê", tr:"Metin çözümlemesi", en:"Text analysis",
   cins:"mê", ez:"analîzkirina metnê", kat:"ziman", zor:0.59, not:"\"Analîzkirin\"+\"metnê\".",
   her:["Analîzkirina metnê.","Di analîzkirina metnê de."], gen:["Analîzkirina metnê","Analîzkirina me"]),
  (id:"c1_327", ku:"Pêwendiya navbera zimanan", tr:"Diller arası ilişki", en:"Inter-language relation",
   cins:"mê", ez:"pêwendiya navbera zimanan", kat:"ziman", zor:0.58, not:"\"Pêwendî\"+\"navbera zimanan\".",
   her:["Pêwendiya navbera zimanan.","Di pêwendiya navbera zimanan de."], gen:["Pêwendiya navbera zimanan","Pêwendiya me"]),
  (id:"c1_328", ku:"Zimanê wêjeyî", tr:"Edebi dil", en:"Literary language",
   cins:"nêr", ez:"zimanê wêjeyî", kat:"ziman", zor:0.61, not:"\"Ziman\"+\"wêjeyî\".",
   her:["Zimanê wêjeyî ya kurdî.","Di zimanê wêjeyî de."], gen:["Zimanê wêjeyî","Zimanê me"]),
  (id:"c1_329", ku:"Zimanê axaftî", tr:"Konuşma dili", en:"Spoken language",
   cins:"nêr", ez:"zimanê axaftî", kat:"ziman", zor:0.61, not:"\"Ziman\"+\"axaftî\".",
   her:["Zimanê axaftî ya kurdî.","Di zimanê axaftî de."], gen:["Zimanê axaftî","Zimanê me"]),
  (id:"c1_330", ku:"Zimanê nivîskî", tr:"Yazı dili", en:"Written language",
   cins:"nêr", ez:"zimanê nivîskî", kat:"ziman", zor:0.61, not:"\"Ziman\"+\"nivîskî\".",
   her:["Zimanê nivîskî ya kurdî.","Di zimanê nivîskî de."], gen:["Zimanê nivîskî","Zimanê me"]),
];



final kC1_Buyuk2 = [
  (id:"c1_400", ku:"Çanda gelêrî", tr:"Halk kültürü", en:"Folk culture",
   cins:"mê", ez:"çanda gelêrî", kat:"çand", zor:0.61, not:"\"Çand\"+\"gelêrî\".",
   her:["Çanda gelêrî ya kurdî.","Di çanda gelêrî de."], gen:["Çanda gelêrî","Çanda me"]),
  (id:"c1_401", ku:"Jiyana çandî ya kurdî", tr:"Kürt kültürel yaşamı", en:"Kurdish cultural life",
   cins:"mê", ez:"jiyana çandî ya kurdî", kat:"çand", zor:0.6, not:"\"Jiyan\"+\"çandî\"+\"kurdî\".",
   her:["Jiyana çandî ya kurdî.","Di jiyana çandî ya kurdî de."], gen:["Jiyana çandî ya kurdî","Jiyana me"]),
  (id:"c1_402", ku:"Mîrasa dîrokî", tr:"Tarihi miras", en:"Historical heritage",
   cins:"mê", ez:"mîrasa dîrokî", kat:"dîrok", zor:0.61, not:"\"Mîras\"+\"dîrokî\".",
   her:["Mîrasa dîrokî ya kurdî.","Di mîrasa dîrokî de."], gen:["Mîrasa dîrokî","Mîrasa me"]),
  (id:"c1_403", ku:"Çanda zindî", tr:"Canlı kültür", en:"Living culture",
   cins:"mê", ez:"çanda zindî", kat:"çand", zor:0.61, not:"\"Çand\"+\"zindî\".",
   her:["Çanda zindî ya kurdî.","Di çanda zindî de."], gen:["Çanda zindî","Çanda me"]),
  (id:"c1_404", ku:"Pîroz û xwezayî", tr:"Kutsal ve doğal", en:"Sacred and natural",
   cins:"bêcins", ez:"pîroz û xwezayî", kat:"çand", zor:0.6, not:"\"Pîroz\"+\"xwezayî\".",
   her:["Pîroz û xwezayî.","Di pîroz û xwezayî de."], gen:["Pîroz û xwezayî","Nirxên çandî"]),
  (id:"c1_405", ku:"Serokatiya siyasî", tr:"Siyasi liderlik", en:"Political leadership",
   cins:"mê", ez:"serokatiya siyasî", kat:"siyaset", zor:0.6, not:"\"Serokatî\"+\"siyasî\".",
   her:["Serokatiya siyasî.","Di serokatiya siyasî de."], gen:["Serokatiya siyasî","Serokatiya me"]),
  (id:"c1_406", ku:"Rêxistina siyasî", tr:"Siyasi örgüt", en:"Political organization",
   cins:"mê", ez:"rêxistina siyasî", kat:"siyaset", zor:0.61, not:"\"Rêxistin\"+\"siyasî\".",
   her:["Rêxistina siyasî.","Di rêxistina siyasî de."], gen:["Rêxistina siyasî","Rêxistina me"]),
  (id:"c1_407", ku:"Berxwedana gelêrî", tr:"Halk direnişi", en:"Popular resistance",
   cins:"mê", ez:"berxwedana gelêrî", kat:"siyaset", zor:0.61, not:"\"Berxwedan\"+\"gelêrî\".",
   her:["Berxwedana gelêrî.","Di berxwedana gelêrî de."], gen:["Berxwedana gelêrî","Berxwedana me"]),
  (id:"c1_408", ku:"Têkilîya gel û dewletê", tr:"Halk-devlet ilişkisi", en:"People-state relation",
   cins:"mê", ez:"têkilîya gel û dewletê", kat:"siyaset", zor:0.6, not:"\"Têkilî\"+\"gel\"+\"dewletê\".",
   her:["Têkilîya gel û dewletê.","Di têkilîya gel û dewletê de."], gen:["Têkilîya gel û dewletê","Têkilîya me"]),
  (id:"c1_409", ku:"Demokrasîya pêşketî", tr:"İleri demokrasi", en:"Advanced democracy",
   cins:"mê", ez:"demokrasîya pêşketî", kat:"siyaset", zor:0.6, not:"\"Demokrasî\"+\"pêşketî\".",
   her:["Demokrasîya pêşketî.","Di demokrasîya pêşketî de."], gen:["Demokrasîya pêşketî","Demokrasîya me"]),
  (id:"c1_410", ku:"Azadîya xwendinê", tr:"Okuma özgürlüğü", en:"Freedom of reading",
   cins:"mê", ez:"azadîya xwendinê", kat:"zagon", zor:0.61, not:"\"Azadî\"+\"xwendinê\".",
   her:["Azadîya xwendinê lazim e.","Di azadîya xwendinê de."], gen:["Azadîya xwendinê","Azadîya me"]),
  (id:"c1_411", ku:"Azadîya ramyariyê", tr:"Düşünce özgürlüğü", en:"Freedom of thought",
   cins:"mê", ez:"azadîya ramyariyê", kat:"zagon", zor:0.6, not:"\"Azadî\"+\"ramyariyê\".",
   her:["Azadîya ramyariyê.","Di azadîya ramyariyê de."], gen:["Azadîya ramyariyê","Azadîya me"]),
  (id:"c1_412", ku:"Cezayê girane", tr:"Ağır ceza", en:"Heavy punishment",
   cins:"nêr", ez:"cezayê girane", kat:"zagon", zor:0.6, not:"\"Ceza\"+\"girane\".",
   her:["Cezayê girane hat dan.","Di cezayê girane de."], gen:["Cezayê girane","Cezayê me"]),
  (id:"c1_413", ku:"Hiqûqê navneteweyî", tr:"Uluslararası hukuk", en:"International law",
   cins:"nêr", ez:"hiqûqê navneteweyî", kat:"zagon", zor:0.61, not:"\"Hiqûq\"+\"navneteweyî\".",
   her:["Hiqûqê navneteweyî.","Di hiqûqê navneteweyî de."], gen:["Hiqûqê navneteweyî","Hiqûqê me"]),
  (id:"c1_414", ku:"Zanîngeh û civak", tr:"Üniversite ve toplum", en:"University and society",
   cins:"bêcins", ez:"zanîngeh û civak", kat:"perwerde", zor:0.61, not:"\"Zanîngeh\"+\"civak\".",
   her:["Zanîngeh û civak.","Di zanîngeh û civak de."], gen:["Zanîngeh û civak","Zanîngeh û civaka me"]),
  (id:"c1_415", ku:"Perwerde û pêşveçûn", tr:"Eğitim ve kalkınma", en:"Education and development",
   cins:"bêcins", ez:"perwerde û pêşveçûn", kat:"perwerde", zor:0.62, not:"\"Perwerde\"+\"pêşveçûn\".",
   her:["Perwerde û pêşveçûn.","Di perwerde û pêşveçûn de."], gen:["Perwerde û pêşveçûn","Perwerde û pêşveçûna me"]),
  (id:"c1_416", ku:"Xwendina bilind", tr:"Yükseköğretim", en:"Higher education",
   cins:"mê", ez:"xwendina bilind", kat:"perwerde", zor:0.62, not:"\"Xwendin\"+\"bilind\".",
   her:["Xwendina bilind lazim e.","Di xwendina bilind de."], gen:["Xwendina bilind","Xwendina me"]),
  (id:"c1_417", ku:"Bawernameya doktorayê", tr:"Doktora diploması", en:"PhD diploma",
   cins:"mê", ez:"bawernameya doktorayê", kat:"perwerde", zor:0.6, not:"\"Bawername\"+\"doktorayê\".",
   her:["Bawernameya doktorayê hat.","Di bawernameya doktorayê de."], gen:["Bawernameya doktorayê","Bawernameya me"]),
  (id:"c1_418", ku:"Pisporê zimannasiyê", tr:"Dilbilim uzmanı", en:"Linguistics specialist",
   cins:"bêcins", ez:"pisporê zimannasiyê", kat:"pîşe", zor:0.61, not:"\"Pispor\"+\"zimannasiyê\".",
   her:["Pisporê zimannasiyê hat.","Pisporên zimannasiyê."], gen:["Pisporê zimannasiyê","Pisporên me"]),
  (id:"c1_419", ku:"Têgihiştina kûr", tr:"Derin anlayış", en:"Deep understanding",
   cins:"mê", ez:"têgihiştina kûr", kat:"zanist", zor:0.61, not:"\"Têgihiştin\"+\"kûr\".",
   her:["Têgihiştina kûr lazim e.","Di têgihiştina kûr de."], gen:["Têgihiştina kûr","Têgihiştina me"]),
  (id:"c1_420", ku:"Analîza kronolojîk", tr:"Kronolojik analiz", en:"Chronological analysis",
   cins:"mê", ez:"analîza kronolojîk", kat:"zanist", zor:0.6, not:"\"Analîz\"+\"kronolojîk\".",
   her:["Analîza kronolojîk.","Di analîza kronolojîk de."], gen:["Analîza kronolojîk","Analîza me"]),
  (id:"c1_421", ku:"Têkilîya nêrîna û metnê", tr:"Görüş ile metin ilişkisi", en:"View-text relation",
   cins:"mê", ez:"têkilîya nêrîna û metnê", kat:"edebiyat", zor:0.6, not:"\"Têkilî\"+\"nêrîna\"+\"metnê\".",
   her:["Têkilîya nêrîna û metnê.","Di têkilîya nêrîna û metnê de."], gen:["Têkilîya nêrîna û metnê","Têkilîya me"]),
  (id:"c1_422", ku:"Xweserîya edebî", tr:"Edebi özgünlük", en:"Literary originality",
   cins:"mê", ez:"xweserîya edebî", kat:"edebiyat", zor:0.6, not:"\"Xweserî\"+\"edebî\".",
   her:["Xweserîya edebî.","Di xweserîya edebî de."], gen:["Xweserîya edebî","Xweserîya me"]),
  (id:"c1_423", ku:"Ekolojîya zimanê", tr:"Dil ekolojisi", en:"Language ecology",
   cins:"mê", ez:"ekolojîya zimanê", kat:"ekoloji", zor:0.59, not:"\"Ekolojî\"+\"zimanê\".",
   her:["Ekolojîya zimanê.","Di ekolojîya zimanê de."], gen:["Ekolojîya zimanê","Ekolojîya me"]),
  (id:"c1_424", ku:"Parastina curbecur zimanên", tr:"Dil çeşitliliğinin korunması", en:"Preserving language diversity",
   cins:"mê", ez:"parastina curbecur zimanên", kat:"ekoloji", zor:0.59, not:"\"Parastin\"+\"zimanên\".",
   her:["Parastina curbecur zimanên.","Di parastina curbecur zimanên de."], gen:["Parastina curbecur zimanên","Parastina me"]),
  (id:"c1_425", ku:"Aborîya çandî", tr:"Kültür ekonomisi", en:"Cultural economy",
   cins:"mê", ez:"aborîya çandî", kat:"aborî", zor:0.6, not:"\"Aborî\"+\"çandî\".",
   her:["Aborîya çandî.","Di aborîya çandî de."], gen:["Aborîya çandî","Aborîya me"]),
  (id:"c1_426", ku:"Pêşveçûna aborîya kurdî", tr:"Kürt ekonomisinin kalkınması", en:"Development of Kurdish economy",
   cins:"mê", ez:"pêşveçûna aborîya kurdî", kat:"aborî", zor:0.6, not:"\"Pêşveçûn\"+\"aborîya kurdî\".",
   her:["Pêşveçûna aborîya kurdî.","Di pêşveçûna aborîya kurdî de."], gen:["Pêşveçûna aborîya kurdî","Pêşveçûna me"]),
  (id:"c1_427", ku:"Medya û siyaset", tr:"Medya ve siyaset", en:"Media and politics",
   cins:"bêcins", ez:"medya û siyaset", kat:"medya", zor:0.61, not:"\"Medya\"+\"siyaset\".",
   her:["Medya û siyaset.","Di medya û siyaset de."], gen:["Medya û siyaset","Medya û siyaseta me"]),
  (id:"c1_428", ku:"Ragihandina siyasî", tr:"Siyasi iletişim", en:"Political communication",
   cins:"mê", ez:"ragihandina siyasî", kat:"medya", zor:0.61, not:"\"Ragihandin\"+\"siyasî\".",
   her:["Ragihandina siyasî.","Di ragihandina siyasî de."], gen:["Ragihandina siyasî","Ragihandina me"]),
  (id:"c1_429", ku:"Zimanê medyayê", tr:"Medya dili", en:"Media language",
   cins:"nêr", ez:"zimanê medyayê", kat:"medya", zor:0.61, not:"\"Ziman\"+\"medyayê\".",
   her:["Zimanê medyayê ya kurdî.","Di zimanê medyayê de."], gen:["Zimanê medyayê","Zimanê me"]),
];



final kC1_Buyuk3 = [
  (id:"c1_500", ku:"Ramana demokratîk", tr:"Demokratik düşünce", en:"Democratic thought",
   cins:"mê", ez:"ramana demokratîk", kat:"felsefe", zor:0.6, not:"\"Ramana demokratîk\".",
   her:["Ramana demokratîk.","Di ramana demokratîk de."], gen:["Ramana demokratîk","ramana demokratîk ya me"]),
  (id:"c1_501", ku:"Felsefeya azadiyê", tr:"Özgürlük felsefesi", en:"Philosophy of freedom",
   cins:"mê", ez:"felsefeya azadiyê", kat:"felsefe", zor:0.59, not:"\"Felsefeya azadiyê\".",
   her:["Felsefeya azadiyê.","Di felsefeya azadiyê de."], gen:["Felsefeya azadiyê","felsefeya azadiyê ya me"]),
  (id:"c1_502", ku:"Têgihiştina mirovî", tr:"İnsani anlayış", en:"Human understanding",
   cins:"mê", ez:"têgihiştina mirovî", kat:"felsefe", zor:0.6, not:"\"Têgihiştina mirovî\".",
   her:["Têgihiştina mirovî.","Di têgihiştina mirovî de."], gen:["Têgihiştina mirovî","têgihiştina mirovî ya me"]),
  (id:"c1_503", ku:"Têkoşîna azadiyê", tr:"Özgürlük mücadelesi", en:"Freedom struggle",
   cins:"mê", ez:"têkoşîna azadiyê", kat:"siyaset", zor:0.61, not:"\"Têkoşîna azadiyê\".",
   her:["Têkoşîna azadiyê.","Di têkoşîna azadiyê de."], gen:["Têkoşîna azadiyê","têkoşîna azadiyê ya me"]),
  (id:"c1_504", ku:"Hêza çandî", tr:"Kültürel güç", en:"Cultural power",
   cins:"mê", ez:"hêza çandî", kat:"çand", zor:0.62, not:"\"Hêza çandî\".",
   her:["Hêza çandî.","Di hêza çandî de."], gen:["Hêza çandî","hêza çandî ya me"]),
  (id:"c1_505", ku:"Vegotina kûr", tr:"Derin anlatı", en:"Deep narrative",
   cins:"mê", ez:"vegotina kûr", kat:"edebiyat", zor:0.6, not:"\"Vegotina kûr\".",
   her:["Vegotina kûr.","Di vegotina kûr de."], gen:["Vegotina kûr","vegotina kûr ya me"]),
  (id:"c1_506", ku:"Wêjeya berxwedanê", tr:"Direniş edebiyatı", en:"Resistance literature",
   cins:"mê", ez:"wêjeya berxwedanê", kat:"edebiyat", zor:0.6, not:"\"Wêjeya berxwedanê\".",
   her:["Wêjeya berxwedanê.","Di wêjeya berxwedanê de."], gen:["Wêjeya berxwedanê","wêjeya berxwedanê ya me"]),
  (id:"c1_507", ku:"Helbesteke azad", tr:"Serbest bir şiir", en:"A free poem",
   cins:"mê", ez:"helbesteke azad", kat:"edebiyat", zor:0.62, not:"\"Helbesteke azad\".",
   her:["Helbesteke azad.","Di helbesteke azad de."], gen:["Helbesteke azad","helbesteke azad ya me"]),
  (id:"c1_508", ku:"Nivîsandina akademîk", tr:"Akademik yazım", en:"Academic writing",
   cins:"mê", ez:"nivîsandina akademîk", kat:"zanist", zor:0.61, not:"\"Nivîsandina akademîk\".",
   her:["Nivîsandina akademîk.","Di nivîsandina akademîk de."], gen:["Nivîsandina akademîk","nivîsandina akademîk ya me"]),
  (id:"c1_509", ku:"Nêrîna dîrokî", tr:"Tarihi bakış", en:"Historical view",
   cins:"mê", ez:"nêrîna dîrokî", kat:"dîrok", zor:0.62, not:"\"Nêrîna dîrokî\".",
   her:["Nêrîna dîrokî.","Di nêrîna dîrokî de."], gen:["Nêrîna dîrokî","nêrîna dîrokî ya me"]),
  (id:"c1_510", ku:"Analîza civakî ya kûr", tr:"Derin sosyal analiz", en:"Deep social analysis",
   cins:"mê", ez:"analîza civakî ya kûr", kat:"zanist", zor:0.59, not:"\"Analîza civakî ya kûr\".",
   her:["Analîza civakî ya kûr.","Di analîza civakî ya kûr de."], gen:["Analîza civakî ya kûr","analîza civakî ya kûr ya me"]),
  (id:"c1_511", ku:"Teorîya kolonyalîzmê", tr:"Kolonyalizm teorisi", en:"Theory of colonialism",
   cins:"mê", ez:"teorîya kolonyalîzmê", kat:"felsefe", zor:0.59, not:"\"Teorîya kolonyalîzmê\".",
   her:["Teorîya kolonyalîzmê.","Di teorîya kolonyalîzmê de."], gen:["Teorîya kolonyalîzmê","teorîya kolonyalîzmê ya me"]),
  (id:"c1_512", ku:"Neteweyîbûna zimanî", tr:"Dilin ulusal kimlikle bütünleşmesi", en:"Linguistic nationalization",
   cins:"mê", ez:"neteweyîbûna zimanî", kat:"ziman", zor:0.59, not:"\"Neteweyîbûna zimanî\".",
   her:["Neteweyîbûna zimanî.","Di neteweyîbûna zimanî de."], gen:["Neteweyîbûna zimanî","neteweyîbûna zimanî ya me"]),
  (id:"c1_513", ku:"Têkilîya nasnameya jinê û zimanê", tr:"Kadın kimliği ve dil ilişkisi", en:"Gender identity-language relation",
   cins:"mê", ez:"têkilîya nasnameya jinê û zimanê", kat:"ziman", zor:0.58, not:"\"Têkilîya nasnameya jinê û zimanê\".",
   her:["Têkilîya nasnameya jinê û zimanê.","Di têkilîya nasnameya jinê û zimanê de."], gen:["Têkilîya nasnameya jinê û zimanê","têkilîya nasnameya jinê û zimanê ya me"]),
  (id:"c1_514", ku:"Zagonên zimanî", tr:"Dil yasaları", en:"Language laws",
   cins:"bêcins", ez:"zagonên zimanî", kat:"zagon", zor:0.6, not:"\"Zagonên zimanî\".",
   her:["Zagonên zimanî.","Di zagonên zimanî de."], gen:["Zagonên zimanî","zagonên zimanî ya me"]),
  (id:"c1_515", ku:"Mafê zimanê di dadgehê de", tr:"Mahkemede dil hakkı", en:"Language right in court",
   cins:"nêr", ez:"mafê zimanê di dadgehê de", kat:"zagon", zor:0.59, not:"\"Mafê zimanê di dadgehê de\".",
   her:["Mafê zimanê di dadgehê de.","Di mafê zimanê di dadgehê de de."], gen:["Mafê zimanê di dadgehê de","mafê zimanê di dadgehê de ya me"]),
  (id:"c1_516", ku:"Nûçeyên analîtîk", tr:"Analitik haberler", en:"Analytical news",
   cins:"bêcins", ez:"nûçeyên analîtîk", kat:"medya", zor:0.61, not:"\"Nûçeyên analîtîk\".",
   her:["Nûçeyên analîtîk.","Di nûçeyên analîtîk de."], gen:["Nûçeyên analîtîk","nûçeyên analîtîk ya me"]),
  (id:"c1_517", ku:"Medyaya alternatîf", tr:"Alternatif medya", en:"Alternative media",
   cins:"mê", ez:"medyaya alternatîf", kat:"medya", zor:0.61, not:"\"Medyaya alternatîf\".",
   her:["Medyaya alternatîf.","Di medyaya alternatîf de."], gen:["Medyaya alternatîf","medyaya alternatîf ya me"]),
  (id:"c1_518", ku:"Dengbêjê navdar", tr:"Ünlü dengbêj", en:"Famous dengbej",
   cins:"bêcins", ez:"dengbêjê navdar", kat:"huner", zor:0.63, not:"\"Dengbêjê navdar\".",
   her:["Dengbêjê navdar.","Di dengbêjê navdar de."], gen:["Dengbêjê navdar","dengbêjê navdar ya me"]),
  (id:"c1_519", ku:"Şîroveyên wêjeyî", tr:"Edebi yorumlar", en:"Literary interpretations",
   cins:"bêcins", ez:"şîroveyên wêjeyî", kat:"edebiyat", zor:0.6, not:"\"Şîroveyên wêjeyî\".",
   her:["Şîroveyên wêjeyî.","Di şîroveyên wêjeyî de."], gen:["Şîroveyên wêjeyî","şîroveyên wêjeyî ya me"]),
  (id:"c1_520", ku:"Berhema bêhempa", tr:"Eşsiz eser", en:"Unique work",
   cins:"mê", ez:"berhema bêhempa", kat:"edebiyat", zor:0.61, not:"\"Berhema bêhempa\".",
   her:["Berhema bêhempa.","Di berhema bêhempa de."], gen:["Berhema bêhempa","berhema bêhempa ya me"]),
  (id:"c1_521", ku:"Çanda Êzidî", tr:"Ezidi kültürü", en:"Yezidi culture",
   cins:"mê", ez:"çanda Êzidî", kat:"çand", zor:0.62, not:"\"Çanda Êzidî\".",
   her:["Çanda Êzidî.","Di çanda Êzidî de."], gen:["Çanda Êzidî","çanda Êzidî ya me"]),
  (id:"c1_522", ku:"Çanda Alawî", tr:"Alevi kültürü", en:"Alevi culture",
   cins:"mê", ez:"çanda Alawî", kat:"çand", zor:0.62, not:"\"Çanda Alawî\".",
   her:["Çanda Alawî.","Di çanda Alawî de."], gen:["Çanda Alawî","çanda Alawî ya me"]),
  (id:"c1_523", ku:"Mirovên xwecihî", tr:"Yerli halk", en:"Indigenous people",
   cins:"bêcins", ez:"mirovên xwecihî", kat:"kimlik", zor:0.61, not:"\"Mirovên xwecihî\".",
   her:["Mirovên xwecihî.","Di mirovên xwecihî de."], gen:["Mirovên xwecihî","mirovên xwecihî ya me"]),
  (id:"c1_524", ku:"Çanda xwemalî", tr:"Yerel kültür", en:"Local culture",
   cins:"mê", ez:"çanda xwemalî", kat:"çand", zor:0.61, not:"\"Çanda xwemalî\".",
   her:["Çanda xwemalî.","Di çanda xwemalî de."], gen:["Çanda xwemalî","çanda xwemalî ya me"]),
  (id:"c1_525", ku:"Giyanê çandî", tr:"Kültürel ruh", en:"Cultural spirit",
   cins:"nêr", ez:"giyanê çandî", kat:"çand", zor:0.6, not:"\"Giyanê çandî\".",
   her:["Giyanê çandî.","Di giyanê çandî de."], gen:["Giyanê çandî","giyanê çandî ya me"]),
  (id:"c1_526", ku:"Wêjeya paşkolonyal", tr:"Postkolonyal edebiyat", en:"Postcolonial literature",
   cins:"mê", ez:"wêjeya paşkolonyal", kat:"edebiyat", zor:0.58, not:"\"Wêjeya paşkolonyal\".",
   her:["Wêjeya paşkolonyal.","Di wêjeya paşkolonyal de."], gen:["Wêjeya paşkolonyal","wêjeya paşkolonyal ya me"]),
  (id:"c1_527", ku:"Perspektîfa jinan", tr:"Kadınların perspektifi", en:"Women's perspective",
   cins:"mê", ez:"perspektîfa jinan", kat:"civakî", zor:0.61, not:"\"Perspektîfa jinan\".",
   her:["Perspektîfa jinan.","Di perspektîfa jinan de."], gen:["Perspektîfa jinan","perspektîfa jinan ya me"]),
  (id:"c1_528", ku:"Rolên civakî yên jinê", tr:"Kadının toplumsal rolleri", en:"Social roles of women",
   cins:"bêcins", ez:"rolên civakî yên jinê", kat:"civakî", zor:0.6, not:"\"Rolên civakî yên jinê\".",
   her:["Rolên civakî yên jinê.","Di rolên civakî yên jinê de."], gen:["Rolên civakî yên jinê","rolên civakî yên jinê ya me"]),
  (id:"c1_529", ku:"Çanda mêrxastiyê", tr:"Yiğitlik kültürü", en:"Culture of heroism",
   cins:"mê", ez:"çanda mêrxastiyê", kat:"çand", zor:0.61, not:"\"Çanda mêrxastiyê\".",
   her:["Çanda mêrxastiyê.","Di çanda mêrxastiyê de."], gen:["Çanda mêrxastiyê","çanda mêrxastiyê ya me"]),
  (id:"c1_530", ku:"Destana gelên Kurdistanê", tr:"Kürdistan halklarının destanı", en:"Epic of Kurdistan peoples",
   cins:"mê", ez:"destana gelên Kurdistanê", kat:"edebiyat", zor:0.61, not:"\"Destana gelên Kurdistanê\".",
   her:["Destana gelên Kurdistanê.","Di destana gelên Kurdistanê de."], gen:["Destana gelên Kurdistanê","destana gelên Kurdistanê ya me"]),
  (id:"c1_531", ku:"Hunera kevnare ya kurdî", tr:"Eski Kürt sanatı", en:"Ancient Kurdish art",
   cins:"mê", ez:"hunera kevnare ya kurdî", kat:"huner", zor:0.61, not:"\"Hunera kevnare ya kurdî\".",
   her:["Hunera kevnare ya kurdî.","Di hunera kevnare ya kurdî de."], gen:["Hunera kevnare ya kurdî","hunera kevnare ya kurdî ya me"]),
  (id:"c1_532", ku:"Wêneyên dîrokî", tr:"Tarihi resimler", en:"Historical paintings",
   cins:"bêcins", ez:"wêneyên dîrokî", kat:"huner", zor:0.61, not:"\"Wêneyên dîrokî\".",
   her:["Wêneyên dîrokî.","Di wêneyên dîrokî de."], gen:["Wêneyên dîrokî","wêneyên dîrokî ya me"]),
  (id:"c1_533", ku:"Muzîka gelêrî ya kurdî", tr:"Kürt halk müziği", en:"Kurdish folk music",
   cins:"mê", ez:"muzîka gelêrî ya kurdî", kat:"huner", zor:0.62, not:"\"Muzîka gelêrî ya kurdî\".",
   her:["Muzîka gelêrî ya kurdî.","Di muzîka gelêrî ya kurdî de."], gen:["Muzîka gelêrî ya kurdî","muzîka gelêrî ya kurdî ya me"]),
  (id:"c1_534", ku:"Stranbêjên dîrokî", tr:"Tarihi şarkıcılar", en:"Historical singers",
   cins:"bêcins", ez:"stranbêjên dîrokî", kat:"huner", zor:0.61, not:"\"Stranbêjên dîrokî\".",
   her:["Stranbêjên dîrokî.","Di stranbêjên dîrokî de."], gen:["Stranbêjên dîrokî","stranbêjên dîrokî ya me"]),
  (id:"c1_535", ku:"Dengê azadiyê", tr:"Özgürlüğün sesi", en:"Voice of freedom",
   cins:"nêr", ez:"dengê azadiyê", kat:"kimlik", zor:0.63, not:"\"Dengê azadiyê\".",
   her:["Dengê azadiyê.","Di dengê azadiyê de."], gen:["Dengê azadiyê","dengê azadiyê ya me"]),
  (id:"c1_536", ku:"Azadîya ramandinê", tr:"Düşünme özgürlüğü", en:"Freedom of thinking",
   cins:"mê", ez:"azadîya ramandinê", kat:"felsefe", zor:0.61, not:"\"Azadîya ramandinê\".",
   her:["Azadîya ramandinê.","Di azadîya ramandinê de."], gen:["Azadîya ramandinê","azadîya ramandinê ya me"]),
  (id:"c1_537", ku:"Têkoşîna bêtir", tr:"Daha fazla mücadele", en:"More struggle",
   cins:"mê", ez:"têkoşîna bêtir", kat:"siyaset", zor:0.61, not:"\"Têkoşîna bêtir\".",
   her:["Têkoşîna bêtir.","Di têkoşîna bêtir de."], gen:["Têkoşîna bêtir","têkoşîna bêtir ya me"]),
  (id:"c1_538", ku:"Serkeftina berdewam", tr:"Sürekli başarı", en:"Continuous success",
   cins:"mê", ez:"serkeftina berdewam", kat:"nirx", zor:0.61, not:"\"Serkeftina berdewam\".",
   her:["Serkeftina berdewam.","Di serkeftina berdewam de."], gen:["Serkeftina berdewam","serkeftina berdewam ya me"]),
  (id:"c1_539", ku:"Pêşeroja dewlemend", tr:"Zengin gelecek", en:"Rich future",
   cins:"mê", ez:"pêşeroja dewlemend", kat:"jiyan", zor:0.62, not:"\"Pêşeroja dewlemend\".",
   her:["Pêşeroja dewlemend.","Di pêşeroja dewlemend de."], gen:["Pêşeroja dewlemend","pêşeroja dewlemend ya me"]),
  (id:"c1_540", ku:"Kurdistana azad", tr:"Özgür Kürdistan", en:"Free Kurdistan",
   cins:"mê", ez:"Kurdistana azad", kat:"kimlik", zor:0.63, not:"\"Kurdistana azad\".",
   her:["Kurdistana azad.","Di Kurdistana azad de."], gen:["Kurdistana azad","Kurdistana azad ya me"]),
  (id:"c1_541", ku:"Neteweya bi destpêk", tr:"Başlangıçlı millet", en:"Nation with origin",
   cins:"mê", ez:"neteweya bi destpêk", kat:"dîrok", zor:0.6, not:"\"Neteweya bi destpêk\".",
   her:["Neteweya bi destpêk.","Di neteweya bi destpêk de."], gen:["Neteweya bi destpêk","neteweya bi destpêk ya me"]),
  (id:"c1_542", ku:"Hatina vejînê", tr:"Dirilişin gelişi", en:"Coming of revival",
   cins:"mê", ez:"hatina vejînê", kat:"kimlik", zor:0.61, not:"\"Hatina vejînê\".",
   her:["Hatina vejînê.","Di hatina vejînê de."], gen:["Hatina vejînê","hatina vejînê ya me"]),
  (id:"c1_543", ku:"Gelê bi bîranîn", tr:"Hafızalı halk", en:"People with memory",
   cins:"nêr", ez:"gelê bi bîranîn", kat:"kimlik", zor:0.62, not:"\"Gelê bi bîranîn\".",
   her:["Gelê bi bîranîn.","Di gelê bi bîranîn de."], gen:["Gelê bi bîranîn","gelê bi bîranîn ya me"]),
  (id:"c1_544", ku:"Zimanê jîyandî", tr:"Yaşayan dil", en:"Living language",
   cins:"nêr", ez:"zimanê jîyandî", kat:"ziman", zor:0.63, not:"\"Zimanê jîyandî\".",
   her:["Zimanê jîyandî.","Di zimanê jîyandî de."], gen:["Zimanê jîyandî","zimanê jîyandî ya me"]),
  (id:"c1_545", ku:"Zimanê ku tê xebatkirin", tr:"Çalışılan dil", en:"Language being worked on",
   cins:"nêr", ez:"zimanê ku tê xebatkirin", kat:"ziman", zor:0.6, not:"\"Zimanê ku tê xebatkirin\".",
   her:["Zimanê ku tê xebatkirin.","Di zimanê ku tê xebatkirin de."], gen:["Zimanê ku tê xebatkirin","zimanê ku tê xebatkirin ya me"]),
  (id:"c1_546", ku:"Şarezatiya zimanî", tr:"Dil yetkinliği", en:"Language proficiency",
   cins:"mê", ez:"şarezatiya zimanî", kat:"ziman", zor:0.61, not:"\"Şarezatiya zimanî\".",
   her:["Şarezatiya zimanî.","Di şarezatiya zimanî de."], gen:["Şarezatiya zimanî","şarezatiya zimanî ya me"]),
  (id:"c1_547", ku:"Xuya ya zimanî", tr:"Dil görünürlüğü", en:"Language visibility",
   cins:"mê", ez:"xuya ya zimanî", kat:"ziman", zor:0.6, not:"\"Xuya ya zimanî\".",
   her:["Xuya ya zimanî.","Di xuya ya zimanî de."], gen:["Xuya ya zimanî","xuya ya zimanî ya me"]),
  (id:"c1_548", ku:"Perwerdeya zimanî", tr:"Dil eğitimi", en:"Language education",
   cins:"mê", ez:"perwerdeya zimanî", kat:"perwerde", zor:0.62, not:"\"Perwerdeya zimanî\".",
   her:["Perwerdeya zimanî.","Di perwerdeya zimanî de."], gen:["Perwerdeya zimanî","perwerdeya zimanî ya me"]),
  (id:"c1_549", ku:"Dersên zimanî yên bilind", tr:"Yüksek düzey dil dersleri", en:"Advanced language lessons",
   cins:"bêcins", ez:"dersên zimanî yên bilind", kat:"perwerde", zor:0.61, not:"\"Dersên zimanî yên bilind\".",
   her:["Dersên zimanî yên bilind.","Di dersên zimanî yên bilind de."], gen:["Dersên zimanî yên bilind","dersên zimanî yên bilind ya me"]),
  (id:"c1_550", ku:"Pêşkeftina zimanê kurdî", tr:"Kürtçenin ilerlemesi", en:"Progress of Kurdish language",
   cins:"mê", ez:"pêşkeftina zimanê kurdî", kat:"ziman", zor:0.63, not:"\"Pêşkeftina zimanê kurdî\".",
   her:["Pêşkeftina zimanê kurdî.","Di pêşkeftina zimanê kurdî de."], gen:["Pêşkeftina zimanê kurdî","pêşkeftina zimanê kurdî ya me"]),
];


// ════════════════════════════════════════════════════════════════
// C1 BÜYÜK TAMAMLAMA — 300 kelime
// Odak: Akademik, Edebi, Siyasi, Felsefi, Dil
// ════════════════════════════════════════════════════════════════

final kC1_Buyuk_ext = [

  // ── KLASİK EDEBİYAT DERİN (40) ───────────────────────────────

  (id:"c1_300", ku:"Helbesta klasîk", tr:"Klasik şiir", en:"Classical poetry", cins:"mê", ez:"helbesta klasîk", kat:"edebiyat", zor:0.59, not:"\"Helbest\"+\"klasîk\".", her:["Helbesta klasîk a kurdî.", "Di helbesta klasîk de."], gen:["Helbesta klasîk","Helbestên me"]),
  (id:"c1_301", ku:"Dîwana Xanî", tr:"Xani'nin Divanı", en:"Khani's Divan", cins:"mê", ez:"Dîwana Xanî", kat:"edebiyat", zor:0.61, not:"\"Dîwan\" = klasik Doğu şiir divanı. Ehmedê Xanî (1650-1707).", her:["Dîwana Xanî xweş e.", "Di Dîwana Xanî de."], gen:["Dîwana Xanî","Dîwanên klasîk"]),
  (id:"c1_302", ku:"Melayê Cizîrî", tr:"Melayê Ciziri", en:"Mele of Cizre", cins:"nêr", ez:"Melayê Cizîrî", kat:"edebiyat", zor:0.61, not:"Klasik Kürt şairi (1570-1640). \"Dîwana Cizîrî\".", her:["Melayê Cizîrî şaîrê mezin e.", "Di helbestên Cizîrî de."], gen:["Melayê Cizîrî","Helbestvanên klasîk"]),
  (id:"c1_303", ku:"Helbestên xemgîn", tr:"Hüzünlü şiirler", en:"Sorrowful poems", cins:"bêcins", ez:"helbestên xemgîn", kat:"edebiyat", zor:0.60, not:"\"Helbest\"+\"xemgîn\". Kürt lirik geleneği.", her:["Helbestên xemgîn hene.", "Di helbestên xemgîn de."], gen:["Helbestên xemgîn","Helbestên me"]),
  (id:"c1_304", ku:"Vegotina qehremanî", tr:"Kahramanlık anlatısı", en:"Heroic narrative", cins:"mê", ez:"vegotina qehremanî", kat:"edebiyat", zor:0.59, not:"\"Vegotin\"+\"qehremanî\".", her:["Vegotina qehremanî.", "Di vegotina qehremanî de."], gen:["Vegotina qehremanî","Vegotina me"]),
  (id:"c1_305", ku:"Mijara evîn û azadiyê", tr:"Aşk ve özgürlük teması", en:"Theme of love and freedom", cins:"mê", ez:"mijara evîn û azadiyê", kat:"edebiyat", zor:0.60, not:"\"Mijar\"+\"evîn û azadî\". Mem û Zîn teması.", her:["Mijara evîn û azadiyê.", "Di mijara evîn û azadiyê de."], gen:["Mijara evîn û azadiyê","Mijarên me"]),
  (id:"c1_306", ku:"Sembola azadiyê di wêjeyê", tr:"Edebiyatta özgürlük sembolü", en:"Freedom symbol in literature", cins:"mê", ez:"sembola azadiyê di wêjeyê", kat:"edebiyat", zor:0.59, not:"\"Sembol\"+\"azadî\"+\"wêje\".", her:["Sembola azadiyê di wêjeyê.", "Di sembola azadiyê de."], gen:["Sembola azadiyê di wêjeyê","Sembolên me"]),
  (id:"c1_307", ku:"Şoreşgeriya edebî", tr:"Edebi devrimcilik", en:"Literary revolutionism", cins:"mê", ez:"şoreşgeriya edebî", kat:"edebiyat", zor:0.59, not:"\"Şoreşgerî\"+\"edebî\".", her:["Şoreşgeriya edebî ya Cegerxwîn.", "Di şoreşgeriya edebî de."], gen:["Şoreşgeriya edebî","Şoreşgeriya me"]),
  (id:"c1_308", ku:"Cegerxwîn", tr:"Cegerxwîn (şair)", en:"Cegerxwîn (poet)", cins:"nêr", ez:"Cegerxwîn", kat:"edebiyat", zor:0.63, not:"Cegerxwîn (1903-1984) = Şükrü Hasan Kurdî. Sosyalist Kürt şairi.", her:["Cegerxwîn helbestvanê mezin e.", "Di helbestên Cegerxwîn de."], gen:["Cegerxwîn","Helbestvanên me"]),
  (id:"c1_309", ku:"Analîza vegotinê", tr:"Anlatı analizi", en:"Narrative analysis", cins:"mê", ez:"analîza vegotinê", kat:"edebiyat", zor:0.59, not:"\"Analîz\"+\"vegotin\".", her:["Analîza vegotinê kirin.", "Di analîza vegotinê de."], gen:["Analîza vegotinê","Analîza me"]),

  // ── AKADEMİK YAZIM DERİN (40) ────────────────────────────────

  (id:"c1_310", ku:"Mebest û rêgez", tr:"Amaç ve yöntem", en:"Aim and method", cins:"bêcins", ez:null, kat:"akademik", zor:0.59, not:"\"Mebest\"+\"rêgez\". Akademik makale yapısı.", her:["Mebest û rêgez.", "Di mebest û rêgezê de."], gen:["Mebest û rêgez","Mebest û rêgezên me"]),
  (id:"c1_311", ku:"Lêkolîna têkildar", tr:"İlgili araştırma", en:"Related research", cins:"mê", ez:"lêkolîna têkildar", kat:"akademik", zor:0.59, not:"\"Lêkolîn\"+\"têkildar\".", her:["Lêkolîna têkildar baş e.", "Di lêkolîna têkildar de."], gen:["Lêkolîna têkildar","Lêkolîna me"]),
  (id:"c1_312", ku:"Encamên nû", tr:"Yeni sonuçlar", en:"New findings", cins:"bêcins", ez:"encamên nû", kat:"akademik", zor:0.60, not:"\"Encam\"+\"nû\".", her:["Encamên nû hatin.", "Di encamên nû de."], gen:["Encamên nû","Encamên me"]),
  (id:"c1_313", ku:"Delîlên piştgir", tr:"Destekleyici kanıtlar", en:"Supporting evidence", cins:"bêcins", ez:"delîlên piştgir", kat:"akademik", zor:0.59, not:"\"Delîl\"+\"piştgir\".", her:["Delîlên piştgir hene.", "Di delîlên piştgir de."], gen:["Delîlên piştgir","Delîlên me"]),
  (id:"c1_314", ku:"Têgeha bingehîn", tr:"Temel kavram", en:"Core concept", cins:"mê", ez:"têgeha bingehîn", kat:"akademik", zor:0.60, not:"\"Têgeh\"+\"bingehîn\".", her:["Têgeha bingehîn çi ye?", "Di têgeha bingehîn de."], gen:["Têgeha bingehîn","Têgehên me"]),
  (id:"c1_315", ku:"Analîza berhevdanî", tr:"Karşılaştırmalı analiz", en:"Comparative analysis", cins:"mê", ez:"analîza berhevdanî", kat:"akademik", zor:0.58, not:"\"Analîz\"+\"berhevdanî\".", her:["Analîza berhevdanî.", "Di analîza berhevdanî de."], gen:["Analîza berhevdanî","Analîza me"]),
  (id:"c1_316", ku:"Têgihîştina kûr", tr:"Derin anlayış", en:"Deep understanding", cins:"mê", ez:"têgihîştina kûr", kat:"akademik", zor:0.60, not:"\"Têgihîştin\"+\"kûr\".", her:["Têgihîştina kûr lazim e.", "Di têgihîştina kûr de."], gen:["Têgihîştina kûr","Têgihîştina me"]),
  (id:"c1_317", ku:"Nûjenîya zanistî", tr:"Bilimsel yenilik", en:"Scientific innovation", cins:"mê", ez:"nûjenîya zanistî", kat:"akademik", zor:0.59, not:"\"Nûjenî\"+\"zanistî\".", her:["Nûjenîya zanistî lazim e.", "Di nûjenîya zanistî de."], gen:["Nûjenîya zanistî","Nûjenîya me"]),
  (id:"c1_318", ku:"Pêşkêşkirina dîtinên", tr:"Görüşlerin sunumu", en:"Presentation of views", cins:"mê", ez:"pêşkêşkirina dîtinên", kat:"akademik", zor:0.58, not:"\"Pêşkêşkirin\"+\"dîtin\".", her:["Pêşkêşkirina dîtinên.", "Di pêşkêşkirina dîtinên de."], gen:["Pêşkêşkirina dîtinên","Pêşkêşkirina me"]),
  (id:"c1_319", ku:"Rexnegirêkê akademîk", tr:"Akademik eleştirmen", en:"Academic critic", cins:"bêcins", ez:"rexnegirêkê akademîk", kat:"akademik", zor:0.59, not:"\"Rexnegir\"+\"akademîk\".", her:["Rexnegirêkê akademîk hat.", "Di rexnegirêkê akademîk de."], gen:["Rexnegirêkê akademîk","Rexnegirên me"]),

  // ── DİL KURAMI DERİN (40) ─────────────────────────────────────

  (id:"c1_320", ku:"Teorîya aktarîna zimên", tr:"Dil aktarım teorisi", en:"Language transfer theory", cins:"mê", ez:"teorîya aktarîna zimên", kat:"ziman", zor:0.58, not:"\"Teorî\"+\"aktarîna zimên\".", her:["Teorîya aktarîna zimên.", "Di teorîya aktarîna zimên de."], gen:["Teorîya aktarîna zimên","Teorîya me"]),
  (id:"c1_321", ku:"Pêvajoya hînbûna duyem", tr:"İkinci dil öğrenim süreci", en:"Second language acquisition", cins:"mê", ez:"pêvajoya hînbûna duyem", kat:"ziman", zor:0.58, not:"\"Pêvajo\"+\"hînbûn\"+\"duyem\".", her:["Pêvajoya hînbûna duyem.", "Di pêvajoya hînbûna duyem de."], gen:["Pêvajoya hînbûna duyem","Pêvajoya me"]),
  (id:"c1_322", ku:"Zimannasîya civakî", tr:"Toplumsal dilbilim", en:"Sociolinguistics", cins:"mê", ez:"zimannasîya civakî", kat:"ziman", zor:0.59, not:"\"Zimannasî\"+\"civakî\". Sosyolengüistik.", her:["Zimannasîya civakî dixwînim.", "Di zimannasîya civakî de."], gen:["Zimannasîya civakî","Zimannasîya me"]),
  (id:"c1_323", ku:"Tevlêbûna zimên", tr:"Dil teması/karışımı", en:"Language contact", cins:"mê", ez:"tevlêbûna zimên", kat:"ziman", zor:0.59, not:"\"Tevlêbûn\"+\"zimên\". Dil temas teorisi.", her:["Tevlêbûna zimên.", "Di tevlêbûna zimên de."], gen:["Tevlêbûna zimên","Tevlêbûna me"]),
  (id:"c1_324", ku:"Kodbivartina zimên", tr:"Kod geçişi", en:"Code switching", cins:"mê", ez:"kodbivartina zimên", kat:"ziman", zor:0.58, not:"\"Kodbivartîn\"+\"zimên\". Code-switching.", her:["Kodbivartina zimên dibe.", "Di kodbivartina zimên de."], gen:["Kodbivartina zimên","Kodbivartina me"]),
  (id:"c1_325", ku:"Zimanê zikmakî û yên din", tr:"Ana dil ve diğerleri", en:"Mother tongue and others", cins:"bêcins", ez:null, kat:"ziman", zor:0.59, not:"\"Zimanê zikmakî\"+\"yên din\".", her:["Zimanê zikmakî û yên din.", "Di navbera zimanan de."], gen:["Zimanê zikmakî û yên din","Zimanên me"]),
  (id:"c1_326", ku:"Vejandin û vejîna zimanî", tr:"Dil canlandırma", en:"Language revitalization", cins:"mê", ez:"vejandin û vejîna zimanî", kat:"ziman", zor:0.59, not:"\"Vejandin\"+\"vejîn\"+\"zimanî\".", her:["Vejandin û vejîna zimanî.", "Di vejandin û vejîna zimanî de."], gen:["Vejandin û vejîna zimanî","Vejîna zimanî ya me"]),
  (id:"c1_327", ku:"Zimanê medyayê", tr:"Medya dili", en:"Media language", cins:"nêr", ez:"zimanê medyayê", kat:"medya", zor:0.60, not:"\"Ziman\"+\"medyayê\". Medya dilbilimi.", her:["Zimanê medyayê.", "Di zimanê medyayê de."], gen:["Zimanê medyayê","Zimanê me"]),
  (id:"c1_328", ku:"Prensîbên zimansaziyê", tr:"Dil oluşturma ilkeleri", en:"Language construction principles", cins:"bêcins", ez:"prensîbên zimansaziyê", kat:"ziman", zor:0.58, not:"\"Prensîb\"+\"zimansazî\".", her:["Prensîbên zimansaziyê.", "Di prensîbên zimansaziyê de."], gen:["Prensîbên zimansaziyê","Prensîbên me"]),
  (id:"c1_329", ku:"Hêza zimên", tr:"Dilin gücü", en:"Power of language", cins:"mê", ez:"hêza zimên", kat:"ziman", zor:0.60, not:"\"Hêz\"+\"zimên\". Dil-güç ilişkisi.", her:["Hêza zimên mezin e.", "Di hêza zimên de."], gen:["Hêza zimên","Hêza me"]),

  // ── KÜRT TARİHİ DERİN (40) ────────────────────────────────────

  (id:"c1_330", ku:"Enfala Kurdistanê", tr:"Kürdistan'ın Enfali", en:"Anfal of Kurdistan", cins:"mê", ez:"Enfala Kurdistanê", kat:"dîrok", zor:0.62, not:"\"Enfal\" (1988) = Irak'ta Kürt soykırımı. [BH ✓]", her:["Enfala Kurdistanê.", "Di Enfala Kurdistanê de."], gen:["Enfala Kurdistanê","Dîroka me"]),
  (id:"c1_331", ku:"Encama dîrokî", tr:"Tarihi sonuç", en:"Historical outcome", cins:"mê", ez:"encama dîrokî", kat:"dîrok", zor:0.60, not:"\"Encam\"+\"dîrokî\".", her:["Encama dîrokî.", "Di encama dîrokî de."], gen:["Encama dîrokî","Encamên me"]),
  (id:"c1_332", ku:"Girêdana dîrokî", tr:"Tarihi bağ", en:"Historical link", cins:"mê", ez:"girêdana dîrokî", kat:"dîrok", zor:0.59, not:"\"Girêdan\"+\"dîrokî\".", her:["Girêdana dîrokî heye.", "Di girêdana dîrokî de."], gen:["Girêdana dîrokî","Girêdana me"]),
  (id:"c1_333", ku:"Çavkaniya dîrokî", tr:"Tarihi kaynak", en:"Historical source", cins:"mê", ez:"çavkaniya dîrokî", kat:"dîrok", zor:0.60, not:"\"Çavkanî\"+\"dîrokî\".", her:["Çavkaniya dîrokî baş e.", "Di çavkaniya dîrokî de."], gen:["Çavkaniya dîrokî","Çavkaniyên me"]),
  (id:"c1_334", ku:"Dîroka şoreşê", tr:"Devrim tarihi", en:"History of revolution", cins:"mê", ez:"dîroka şoreşê", kat:"dîrok", zor:0.60, not:"\"Dîrok\"+\"şoreşê\".", her:["Dîroka şoreşê.", "Di dîroka şoreşê de."], gen:["Dîroka şoreşê","Dîroka me"]),
  (id:"c1_335", ku:"Peymana Lausannê", tr:"Lozan Antlaşması", en:"Treaty of Lausanne", cins:"mê", ez:"Peymana Lausannê", kat:"dîrok", zor:0.62, not:"\"Peymanam\"+\"Lausannê\". 1923 — Kürdistan'ın bölünmesi.", her:["Peymana Lausannê di 1923an de hat.", "Di Peymana Lausannê de."], gen:["Peymana Lausannê","Peymanen dîrokî"]),
  (id:"c1_336", ku:"Dewleta Mahabad", tr:"Mahabad Cumhuriyeti", en:"Republic of Mahabad", cins:"mê", ez:"Dewleta Mahabad", kat:"dîrok", zor:0.62, not:"\"Dewleta Mahabad\" (1946) = Kürt devleti deneyi.", her:["Dewleta Mahabad.", "Di Dewleta Mahabad de."], gen:["Dewleta Mahabad","Dewletên me"]),
  (id:"c1_337", ku:"Serhildana Şêx Ubeydullahî", tr:"Şeyh Ubeydullah isyanı", en:"Sheikh Ubeydullah uprising", cins:"mê", ez:"Serhildana Şêx Ubeydullahî", kat:"dîrok", zor:0.60, not:"\"Serhildan\" 1880 — erken Kürt milliyetçiliği.", her:["Serhildana Şêx Ubeydullahî.", "Di serhildana Şêx Ubeydullahî de."], gen:["Serhildana Şêx Ubeydullahî","Serhildanên kurdî"]),
  (id:"c1_338", ku:"Piraniya Kurdî", tr:"Kürt çoğunluğu", en:"Kurdish majority", cins:"mê", ez:"piraniya Kurdî", kat:"civakî", zor:0.60, not:"\"Piranî\"+\"Kurdî\". Demografik kavram.", her:["Piraniya Kurdî.", "Di piraniya Kurdî de."], gen:["Piraniya Kurdî","Piraniya me"]),
  (id:"c1_339", ku:"Çanda berxwedanê", tr:"Direniş kültürü", en:"Culture of resistance", cins:"mê", ez:"çanda berxwedanê", kat:"çand", zor:0.61, not:"\"Çand\"+\"berxwedanê\".", her:["Çanda berxwedanê.", "Di çanda berxwedanê de."], gen:["Çanda berxwedanê","Çanda me"]),

  // ── FELSEFİ DÜŞÜNCE DERİN (40) ────────────────────────────────

  (id:"c1_340", ku:"Felsefa Kürtî", tr:"Kürt felsefesi", en:"Kurdish philosophy", cins:"mê", ez:"felsefa Kürtî", kat:"felsefe", zor:0.59, not:"\"Felsefe\"+\"Kürtî\". Kürt düşünce geleneği.", her:["Felsefa Kürtî.", "Di felsefa Kürtî de."], gen:["Felsefa Kürtî","Felsefa me"]),
  (id:"c1_341", ku:"Ramanên serkeftî", tr:"Başarılı düşünceler", en:"Successful ideas", cins:"bêcins", ez:"ramanên serkeftî", kat:"felsefe", zor:0.59, not:"\"Raman\"+\"serkeftî\".", her:["Ramanên serkeftî hene.", "Di ramanên serkeftî de."], gen:["Ramanên serkeftî","Ramanên me"]),
  (id:"c1_342", ku:"Etîka civakî", tr:"Toplumsal etik", en:"Social ethics", cins:"mê", ez:"etîka civakî", kat:"felsefe", zor:0.59, not:"\"Etîk\"+\"civakî\".", her:["Etîka civakî.", "Di etîka civakî de."], gen:["Etîka civakî","Etîka me"]),
  (id:"c1_343", ku:"Rêgez û nirxên xwecihî", tr:"Yerli ilkeler ve değerler", en:"Indigenous principles and values", cins:"bêcins", ez:"rêgez û nirxên xwecihî", kat:"felsefe", zor:0.59, not:"\"Rêgez û nirx\"+\"xwecihî\".", her:["Rêgez û nirxên xwecihî.", "Di rêgez û nirxên xwecihî de."], gen:["Rêgez û nirxên xwecihî","Rêgez û nirxên me"]),
  (id:"c1_344", ku:"Têgihîna hebûnê", tr:"Varlık anlayışı", en:"Understanding of existence", cins:"mê", ez:"têgihîna hebûnê", kat:"felsefe", zor:0.58, not:"\"Têgihîn\"+\"hebûn\". Ontoloji.", her:["Têgihîna hebûnê.", "Di têgihîna hebûnê de."], gen:["Têgihîna hebûnê","Têgihîna me"]),
  (id:"c1_345", ku:"Zanistiya zanînê", tr:"Bilgi bilimi", en:"Epistemology", cins:"mê", ez:"zanistiya zanînê", kat:"felsefe", zor:0.58, not:"\"Zanistî\"+\"zanîn\". Epistemoloji.", her:["Zanistiya zanînê.", "Di zanistiya zanînê de."], gen:["Zanistiya zanînê","Zanistiya me"]),
  (id:"c1_346", ku:"Azadî û berpirsiyarî", tr:"Özgürlük ve sorumluluk", en:"Freedom and responsibility", cins:"bêcins", ez:null, kat:"felsefe", zor:0.60, not:"\"Azadî\"+\"berpirsiyarî\". Varoluşçu kavram çifti.", her:["Azadî û berpirsiyarî girîng in.", "Di azadî û berpirsiyarî de."], gen:["Azadî û berpirsiyarî","Azadî û berpirsiyarîya me"]),
  (id:"c1_347", ku:"Hêvî û dilsozî", tr:"Umut ve bağlılık", en:"Hope and commitment", cins:"bêcins", ez:null, kat:"felsefe", zor:0.60, not:"\"Hêvî\"+\"dilsozî\".", her:["Hêvî û dilsozî lazim in.", "Di hêvî û dilsozî de."], gen:["Hêvî û dilsozî","Hêvî û dilsozîya me"]),
  (id:"c1_348", ku:"Rexneya destûran", tr:"Kurumların eleştirisi", en:"Critique of institutions", cins:"mê", ez:"rexneya destûran", kat:"felsefe", zor:0.59, not:"\"Rexne\"+\"destûran\".", her:["Rexneya destûran.", "Di rexneya destûran de."], gen:["Rexneya destûran","Rexneya me"]),
  (id:"c1_349", ku:"Azadîya ramanê û îfadeyê", tr:"Düşünce ve ifade özgürlüğü", en:"Freedom of thought and expression", cins:"mê", ez:"azadîya ramanê û îfadeyê", kat:"felsefe", zor:0.60, not:"\"Azadî\"+\"raman û îfade\".", her:["Azadîya ramanê û îfadeyê.", "Ji bo azadîya ramanê û îfadeyê."], gen:["Azadîya ramanê û îfadeyê","Azadîya me"]),

  // ── GAZETE DİLİ VE MEDYA (30) ─────────────────────────────────

  (id:"c1_350", ku:"Haber analîzê", tr:"Haber analizi", en:"News analysis", cins:"nêr", ez:"haberê analîzê", kat:"medya", zor:0.60, not:"\"Haber\"+\"analîz\". Gazetecilik terimi.", her:["Haber analîzê hat kirin.", "Di haber analîzê de."], gen:["Haber analîzê","Haberên me"]),
  (id:"c1_351", ku:"Ragihandina zindî", tr:"Canlı yayın", en:"Live broadcast", cins:"mê", ez:"ragihandina zindî", kat:"medya", zor:0.61, not:"\"Ragihandin\"+\"zindî\".", her:["Ragihandina zindî hat.", "Di ragihandina zindî de."], gen:["Ragihandina zindî","Ragihandina me"]),
  (id:"c1_352", ku:"Çavkanîya pêbawerî", tr:"Güvenilir kaynak", en:"Credible source", cins:"mê", ez:"çavkanîya pêbawerî", kat:"medya", zor:0.60, not:"\"Çavkanî\"+\"pêbawerî\".", her:["Çavkanîya pêbawerî.", "Di çavkanîya pêbawerî de."], gen:["Çavkanîya pêbawerî","Çavkaniyên me"]),
  (id:"c1_353", ku:"Nûçeyên derew", tr:"Yalan haberler", en:"Fake news", cins:"bêcins", ez:"nûçeyên derew", kat:"medya", zor:0.61, not:"\"Nûçe\"+\"derew\". Dezinformasyon.", her:["Nûçeyên derew hene.", "Di nûçeyên derew de."], gen:["Nûçeyên derew","Nûçeyên me"]),
  (id:"c1_354", ku:"Azadîya çapemeniyê", tr:"Basın özgürlüğü", en:"Press freedom", cins:"mê", ez:"azadîya çapemeniyê", kat:"medya", zor:0.61, not:"\"Azadî\"+\"çapemeniyê\".", her:["Azadîya çapemeniyê lazim e.", "Ji bo azadîya çapemeniyê."], gen:["Azadîya çapemeniyê","Azadîya me"]),
  (id:"c1_355", ku:"Kovara zanistî ya kurdî", tr:"Kürtçe bilimsel dergi", en:"Kurdish scientific journal", cins:"mê", ez:"kovara zanistî ya kurdî", kat:"medya", zor:0.60, not:"\"Kovar\"+\"zanistî\"+\"kurdî\".", her:["Kovara zanistî ya kurdî.", "Di kovara zanistî ya kurdî de."], gen:["Kovara zanistî ya kurdî","Kovarên me"]),
  (id:"c1_356", ku:"Wergerkirina haberê", tr:"Haberin çevirisi", en:"News translation", cins:"mê", ez:"wergerkirina haberê", kat:"medya", zor:0.59, not:"\"Wergerkirin\"+\"haber\".", her:["Wergerkirina haberê.", "Di wergerkirina haberê de."], gen:["Wergerkirina haberê","Wergerkirina me"]),
  (id:"c1_357", ku:"Perspektîva medyayê", tr:"Medya perspektifi", en:"Media perspective", cins:"mê", ez:"perspektîva medyayê", kat:"medya", zor:0.59, not:"\"Perspektîv\"+\"medyayê\".", her:["Perspektîva medyayê.", "Di perspektîva medyayê de."], gen:["Perspektîva medyayê","Perspektîva me"]),

  // ── DIASPORA VE KİMLİK (30) ───────────────────────────────────

  (id:"c1_358", ku:"Diaspora û welat", tr:"Diaspora ve vatan", en:"Diaspora and homeland", cins:"bêcins", ez:null, kat:"kimlik", zor:0.61, not:"\"Diaspora\"+\"welat\".", her:["Diaspora û welat.", "Di navbera diaspora û welat de."], gen:["Diaspora û welat","Diaspora û welata me"]),
  (id:"c1_359", ku:"Girêdana koka ferhengî", tr:"Kültürel kök bağlantısı", en:"Cultural root connection", cins:"mê", ez:"girêdana koka ferhengî", kat:"kimlik", zor:0.59, not:"\"Girêdan\"+\"koka ferhengî\".", her:["Girêdana koka ferhengî.", "Di girêdana koka ferhengî de."], gen:["Girêdana koka ferhengî","Girêdana me"]),
  (id:"c1_360", ku:"Rêveçûna nasnameya kurd", tr:"Kürt kimliğinin seyri", en:"Course of Kurdish identity", cins:"mê", ez:"rêveçûna nasnameya kurd", kat:"kimlik", zor:0.59, not:"\"Rêveçûn\"+\"nasname\"+\"kurd\".", her:["Rêveçûna nasnameya kurd.", "Di rêveçûna nasnameya kurd de."], gen:["Rêveçûna nasnameya kurd","Rêveçûna me"]),
  (id:"c1_361", ku:"Koçberî û nasname", tr:"Göç ve kimlik", en:"Migration and identity", cins:"bêcins", ez:null, kat:"kimlik", zor:0.61, not:"\"Koçberî\"+\"nasname\".", her:["Koçberî û nasname.", "Di navbera koçberî û nasname de."], gen:["Koçberî û nasname","Nasname û koçberîya me"]),
  (id:"c1_362", ku:"Xwe di diasporayê de nasandin", tr:"Diasporada kendini tanıtma", en:"Self-identification in diaspora", cins:"mê", ez:"xwe di diasporayê de nasandin", kat:"kimlik", zor:0.59, not:"\"Nasandin\"+\"diaspora\".", her:["Xwe di diasporayê de nasandin.", "Di xwe di diasporayê de nasandin de."], gen:["Xwe di diasporayê de nasandin","Nasandina me"]),
  (id:"c1_363", ku:"Zimanê diyasporayê", tr:"Diaspora dili", en:"Diaspora language", cins:"nêr", ez:"zimanê diyasporayê", kat:"ziman", zor:0.60, not:"\"Ziman\"+\"diyasporayê\".", her:["Zimanê diyasporayê.", "Di zimanê diyasporayê de."], gen:["Zimanê diyasporayê","Zimanê me"]),
  (id:"c1_364", ku:"Vegerandina çandê", tr:"Kültürü geri kazanma", en:"Cultural reclamation", cins:"mê", ez:"vegerandina çandê", kat:"kimlik", zor:0.60, not:"\"Vegerandin\"+\"çand\".", her:["Vegerandina çandê lazim e.", "Di vegerandina çandê de."], gen:["Vegerandina çandê","Vegerandina me"]),

  // ── ÊZÎDÎTÎ VE DİNİ KÜLTÜR (20) ──────────────────────────────

  (id:"c1_365", ku:"Êzîdîtî", tr:"Êzidilik", en:"Yazidism", cins:"mê", ez:"Êzîdîtiyê", kat:"çand", zor:0.62, not:"\"Êzîdîtî\" = Êzidi inanç sistemi. Kürdistanın özgün dini.", her:["Êzîdîtî baweriyeke kûvî ye.", "Di Êzîdîtiyê de."], gen:["Êzîdîtî","Baweriyên me"]),
  (id:"c1_366", ku:"Şingalê Êzîdîyan", tr:"Êzidilerin Şengali", en:"Yazidis' Sinjar", cins:"nêr", ez:"Şingalê Êzîdîyan", kat:"dîrok", zor:0.62, not:"\"Şingal\" (Sinjar) = Êzidi yurdu. 2014 soykırımı.", her:["Şingalê Êzîdîyan.", "Di Şingalê Êzîdîyan de."], gen:["Şingalê Êzîdîyan","Şingal"]),
  (id:"c1_367", ku:"Cenabê Tawûsî Melek", tr:"Tavus Meleği", en:"Melek Taus / Peacock Angel", cins:"nêr", ez:"Cenabê Tawûsî Melek", kat:"çand", zor:0.61, not:"\"Tawûsî Melek\" = Êzidi inanç merkezi. Kutsal figür.", her:["Tawûsî Melek.", "Di baweriya Tawûsî Melek de."], gen:["Tawûsî Melek","Baweriya me"]),
  (id:"c1_368", ku:"Elewîtî û Kürtanê", tr:"Alevilik ve Kürtler", en:"Alevism and Kurds", cins:"bêcins", ez:null, kat:"çand", zor:0.61, not:"\"Elewîtî\"+\"Kürt\". Kürtlerde Alevilik.", her:["Elewîtî û Kürtanê.", "Di navbera Elewîtî û Kürtanê de."], gen:["Elewîtî û Kürtanê","Elewîtiya me"]),

  // ── MAFÊN JINAN (20) ─────────────────────────────────────────

  (id:"c1_369", ku:"Azadîya jinê ya Kürtî", tr:"Kürt kadın özgürlüğü", en:"Kurdish women's freedom", cins:"mê", ez:"azadîya jinê ya Kürtî", kat:"civakî", zor:0.61, not:"\"Azadîya jinê\"+\"Kürtî\".", her:["Azadîya jinê ya Kürtî.", "Ji bo azadîya jinê ya Kürtî."], gen:["Azadîya jinê ya Kürtî","Azadîya jinê"]),
  (id:"c1_370", ku:"Jinên ronakbîr ên kurd", tr:"Kürt aydın kadınlar", en:"Kurdish intellectual women", cins:"bêcins", ez:"jinên ronakbîr ên kurd", kat:"civakî", zor:0.60, not:"\"Jin\"+\"ronakbîr\"+\"kurd\".", her:["Jinên ronakbîr ên kurd.", "Di nav jinên ronakbîr ên kurd de."], gen:["Jinên ronakbîr ên kurd","Jinên me"]),
  (id:"c1_371", ku:"Berxwedana jinên kurd", tr:"Kürt kadınların direnci", en:"Resistance of Kurdish women", cins:"mê", ez:"berxwedana jinên kurd", kat:"dîrok", zor:0.61, not:"\"Berxwedan\"+\"jinên kurd\". YPJ vb.", her:["Berxwedana jinên kurd.", "Di berxwedana jinên kurd de."], gen:["Berxwedana jinên kurd","Berxwedana me"]),
  (id:"c1_372", ku:"Jin, jiyan, azadî", tr:"Kadın, yaşam, özgürlük", en:"Woman, life, freedom", cins:"bêcins", ez:null, kat:"civakî", zor:0.63, not:"\"Jin, jiyan, azadî\" — Kürt kadın hareketinin sloganı.", her:["Jin, jiyan, azadî!", "Bi şiara \"Jin, jiyan, azadî\"."], gen:["Jin, jiyan, azadî","Şiara me"]),
];


final kC1_Tamamlama = [

  // ── KÜRT SİYASETİ DERİN (30) ─────────────────────────────────

  (id:"c1_400", ku:"Tevgera rizgariya neteweyî", tr:"Ulusal kurtuluş hareketi", en:"National liberation movement",
   cins:"mê", ez:"tevgera rizgariya neteweyî", kat:"siyaset", zor:0.59,
   not:"\"Tevger\"+\"rizgarî\"+\"neteweyî\". 20. yy. Kürt siyasi tarihi.",
   her:["Tevgera rizgariya neteweyî.", "Di tevgera rizgariya neteweyî de."],
   gen:["Tevgera rizgariya neteweyî", "Tevgera me"]),

  (id:"c1_401", ku:"Federalîzma demokratîk", tr:"Demokratik federalizm", en:"Democratic federalism",
   cins:"mê", ez:"federalîzma demokratîk", kat:"siyaset", zor:0.59,
   not:"\"Federalîzm\"+\"demokratîk\". Abdullah Öcalan'ın siyasi teorisi.",
   her:["Federalîzma demokratîk armancek e.", "Di federalîzma demokratîk de."],
   gen:["Federalîzma demokratîk", "Federalîzma me"]),

  (id:"c1_402", ku:"Xweseriya demokratîk", tr:"Demokratik özerklik", en:"Democratic autonomy",
   cins:"mê", ez:"xweseriya demokratîk", kat:"siyaset", zor:0.60,
   not:"\"Xweserî\"+\"demokratîk\". Kürt siyasi modeli.",
   her:["Xweseriya demokratîk.", "Di xweseriya demokratîk de."],
   gen:["Xweseriya demokratîk", "Xweseriya me"]),

  (id:"c1_403", ku:"Konfederalîzm û dewlet", tr:"Konfederalizm ve devlet", en:"Confederalism and state",
   cins:"bêcins", ez:null, kat:"siyaset", zor:0.59,
   not:"\"Konfederalîzm\"+\"dewlet\". Kürt siyasi tartışması.",
   her:["Konfederalîzm û dewlet.", "Di navbera konfederalîzm û dewlet de."],
   gen:["Konfederalîzm û dewlet", "Konfederalîzma me"]),

  (id:"c1_404", ku:"Tevnê siyasî yê Kurdan", tr:"Kürtlerin siyasi ağı", en:"Political network of Kurds",
   cins:"nêr", ez:"tevnê siyasî yê Kurdan", kat:"siyaset", zor:0.59,
   not:"\"Tevn\"+\"siyasî\"+\"Kurdan\".",
   her:["Tevnê siyasî yê Kurdan.", "Di tevnê siyasî yê Kurdan de."],
   gen:["Tevnê siyasî yê Kurdan", "Tevnên me"]),

  (id:"c1_405", ku:"Siyaseta çekdabeşkirinê", tr:"Silahsızlanma siyaseti", en:"Disarmament policy",
   cins:"mê", ez:"siyaseta çekdabeşkirinê", kat:"siyaset", zor:0.58,
   not:"\"Siyaset\"+\"çekdabeşkirin\". Barış müzakereleri bağlamı.",
   her:["Siyaseta çekdabeşkirinê.", "Di siyaseta çekdabeşkirinê de."],
   gen:["Siyaseta çekdabeşkirinê", "Siyaseta me"]),

  // ── ZAGON VE HAKLAR (20) ─────────────────────────────────────

  (id:"c1_406", ku:"Mafê xwebirêvebirina gelêrî", tr:"Halkın özyönetim hakkı", en:"People's right to self-governance",
   cins:"nêr", ez:"mafê xwebirêvebirina gelêrî", kat:"zagon", zor:0.60,
   not:"\"Maf\"+\"xwebirêvebirîna gelêrî\". BM Şartı çerçevesi.",
   her:["Mafê xwebirêvebirina gelêrî.", "Ji bo mafê xwebirêvebirina gelêrî."],
   gen:["Mafê xwebirêvebirina gelêrî", "Mafên gelêrî"]),

  (id:"c1_407", ku:"Peymana navdewletî ya mafan", tr:"Uluslararası haklar sözleşmesi", en:"International rights treaty",
   cins:"mê", ez:"peymana navdewletî ya mafan", kat:"zagon", zor:0.59,
   not:"\"Peymanam\"+\"navdewletî\"+\"maf\". ICCPR vb.",
   her:["Peymana navdewletî ya mafan.", "Di peymana navdewletî ya mafan de."],
   gen:["Peymana navdewletî ya mafan", "Peymanên me"]),

  (id:"c1_408", ku:"Bicihkirina mafan", tr:"Hakların uygulanması", en:"Implementation of rights",
   cins:"mê", ez:"bicihkirina mafan", kat:"zagon", zor:0.59,
   not:"\"Bicihkirin\"+\"maf\". Hak uygulaması.",
   her:["Bicihkirina mafan lazim e.", "Di bicihkirina mafan de."],
   gen:["Bicihkirina mafan", "Bicihkirina me"]),

  // ── AKADEMİK DİL DERİN (25) ──────────────────────────────────

  (id:"c1_409", ku:"Argumansaziya akademîk", tr:"Akademik argümantasyon", en:"Academic argumentation",
   cins:"mê", ez:"argumansaziya akademîk", kat:"akademik", zor:0.58,
   not:"\"Argumansazî\"+\"akademîk\". Akademik tartışma sanatı.",
   her:["Argumansaziya akademîk baş e.", "Di argumansaziya akademîk de."],
   gen:["Argumansaziya akademîk", "Argumansaziya me"]),

  (id:"c1_410", ku:"Vegotina zanistî ya zelal", tr:"Açık bilimsel anlatım", en:"Clear scientific exposition",
   cins:"mê", ez:"vegotina zanistî ya zelal", kat:"akademik", zor:0.59,
   not:"\"Vegotin\"+\"zanistî\"+\"zelal\".",
   her:["Vegotina zanistî ya zelal.", "Di vegotina zanistî ya zelal de."],
   gen:["Vegotina zanistî ya zelal", "Vegotina me"]),

  (id:"c1_411", ku:"Çavkanîpêçûna akademîk", tr:"Akademik kaynak gösterme", en:"Academic citation",
   cins:"mê", ez:"çavkanîpêçûna akademîk", kat:"akademik", zor:0.58,
   not:"\"Çavkanî\"+\"pêçûn\". Atıf sistemi.",
   her:["Çavkanîpêçûna akademîk lazim e.", "Di çavkanîpêçûna akademîk de."],
   gen:["Çavkanîpêçûna akademîk", "Çavkanîpêçûna me"]),

  (id:"c1_412", ku:"Xebata meydanê ya C1", tr:"C1 saha araştırması", en:"C1 field research",
   cins:"mê", ez:"xebata meydanê", kat:"akademik", zor:0.59,
   not:"\"Xebat\"+\"meydan\". Etnografik araştırma yöntemi.",
   her:["Xebata meydanê hat kirin.", "Di xebata meydanê de."],
   gen:["Xebata meydanê", "Xebata me"]),

  (id:"c1_413", ku:"Nirxandina kûr a metnê", tr:"Metnin derin değerlendirmesi", en:"Deep text assessment",
   cins:"mê", ez:"nirxandina kûr a metnê", kat:"akademik", zor:0.58,
   not:"\"Nirxandin\"+\"kûr\"+\"metn\". C1 okuma becerisi.",
   her:["Nirxandina kûr a metnê.", "Di nirxandina kûr a metnê de."],
   gen:["Nirxandina kûr a metnê", "Nirxandina me"]),

  // ── EĞİTİM SİSTEMİ (20) ──────────────────────────────────────

  (id:"c1_414", ku:"Perwerdehiya kurdî ya fermî", tr:"Resmi Kürtçe eğitim", en:"Formal Kurdish education",
   cins:"mê", ez:"perwerdehiya kurdî ya fermî", kat:"perwerde", zor:0.60,
   not:"\"Perwerdehî\"+\"kurdî\"+\"fermî\". Devlet okullarında Kürtçe.",
   her:["Perwerdehiya kurdî ya fermî.", "Di perwerdehiya kurdî ya fermî de."],
   gen:["Perwerdehiya kurdî ya fermî", "Perwerdehiya me"]),

  (id:"c1_415", ku:"Bernameya hînkariya zimanî", tr:"Dil öğretim programı", en:"Language teaching program",
   cins:"mê", ez:"bernameya hînkariya zimanî", kat:"perwerde", zor:0.59,
   not:"\"Bername\"+\"hînkarî\"+\"zimanî\". Dil öğretim müfredatı.",
   her:["Bernameya hînkariya zimanî.", "Di bernameya hînkariya zimanî de."],
   gen:["Bernameya hînkariya zimanî", "Bernameya me"]),

  (id:"c1_416", ku:"Dibistana bi zimanê kurdî", tr:"Kürtçe eğitim okulu", en:"Kurdish-medium school",
   cins:"mê", ez:"dibistana bi zimanê kurdî", kat:"perwerde", zor:0.60,
   not:"\"Dibistan\"+\"zimanê kurdî\". Kürtçe anadil eğitimi.",
   her:["Dibistana bi zimanê kurdî.", "Di dibistana bi zimanê kurdî de."],
   gen:["Dibistana bi zimanê kurdî", "Dibistana me"]),

  (id:"c1_417", ku:"Mamosteya zimanê kurdî ya pispor", tr:"Uzman Kürtçe öğretmeni", en:"Specialist Kurdish teacher",
   cins:"mê", ez:"mamosteya zimanê kurdî ya pispor", kat:"perwerde", zor:0.59,
   not:"\"Mamoste\"+\"ziman\"+\"pispor\".",
   her:["Mamosteya zimanê kurdî ya pispor.", "Di mamosteya zimanê kurdî ya pispor de."],
   gen:["Mamosteya zimanê kurdî ya pispor", "Mamosteya me"]),

  // ── EKONOMİ VE TOPLUM C1 (20) ────────────────────────────────

  (id:"c1_418", ku:"Aborîya Kurdistanê ya nûjen", tr:"Modern Kürdistan ekonomisi", en:"Modern economy of Kurdistan",
   cins:"mê", ez:"aborîya Kurdistanê ya nûjen", kat:"aborî", zor:0.59,
   not:"\"Aborî\"+\"Kurdistanê\"+\"nûjen\".",
   her:["Aborîya Kurdistanê ya nûjen.", "Di aborîya Kurdistanê ya nûjen de."],
   gen:["Aborîya Kurdistanê ya nûjen", "Aborîya me"]),

  (id:"c1_419", ku:"Têkilîya aborî û siyasî", tr:"Ekonomi-siyaset ilişkisi", en:"Economy-politics relation",
   cins:"mê", ez:"têkilîya aborî û siyasî", kat:"aborî", zor:0.59,
   not:"\"Têkilî\"+\"aborî û siyasî\". Siyasi ekonomi.",
   her:["Têkilîya aborî û siyasî.", "Di têkilîya aborî û siyasî de."],
   gen:["Têkilîya aborî û siyasî", "Têkilîya me"]),

  (id:"c1_420", ku:"Bêhevperî û newekhevî", tr:"Eşitsizlik ve adaletsizlik", en:"Inequality and injustice",
   cins:"bêcins", ez:null, kat:"civakî", zor:0.59,
   not:"\"Bêhevperî\"+\"newekhevî\". Toplumsal adalet.",
   her:["Bêhevperî û newekhevî hene.", "Di bêhevperî û newekhevî de."],
   gen:["Bêhevperî û newekhevî", "Bêhevperîya me"]),

  (id:"c1_421", ku:"Alîgirîya civakî", tr:"Sosyal dayanışma", en:"Social solidarity",
   cins:"mê", ez:"alîgirîya civakî", kat:"civakî", zor:0.60,
   not:"\"Alîgirî\"+\"civakî\". Toplumsal destek ağları.",
   her:["Alîgirîya civakî lazim e.", "Di alîgirîya civakî de."],
   gen:["Alîgirîya civakî", "Alîgirîya me"]),

  (id:"c1_422", ku:"Nirxên giştî yên civakê", tr:"Toplumun genel değerleri", en:"Society's common values",
   cins:"bêcins", ez:"nirxên giştî yên civakê", kat:"nirx", zor:0.59,
   not:"\"Nirx\"+\"giştî\"+\"civak\".",
   her:["Nirxên giştî yên civakê.", "Di nirxên giştî yên civakê de."],
   gen:["Nirxên giştî yên civakê", "Nirxên me"]),

  // ── EKOLOJI VE ÇEVRE C1 (15) ─────────────────────────────────

  (id:"c1_423", ku:"Guherîna avhewa", tr:"İklim değişikliği", en:"Climate change",
   cins:"mê", ez:"guherîna avhewa", kat:"ekoloji", zor:0.60,
   not:"\"Guherîn\"+\"avhewa\". Küresel ısınma/iklim krizi.",
   her:["Guherîna avhewa mezin e.", "Di guherîna avhewa de."],
   gen:["Guherîna avhewa", "Guherîna me"]),

  (id:"c1_424", ku:"Parastina xwezayê", tr:"Doğanın korunması", en:"Nature conservation",
   cins:"mê", ez:"parastina xwezayê", kat:"ekoloji", zor:0.61,
   not:"\"Parastin\"+\"xwezayê\". Kürdistan'ın zengin biyoçeşitliliği.",
   her:["Parastina xwezayê lazim e.", "Di parastina xwezayê de."],
   gen:["Parastina xwezayê", "Parastina me"]),

  (id:"c1_425", ku:"Jîngehparêzîya gelêrî", tr:"Halk çevreciliği", en:"People's environmentalism",
   cins:"mê", ez:"jîngehparêzîya gelêrî", kat:"ekoloji", zor:0.59,
   not:"\"Jîngehparêzî\"+\"gelêrî\". Yerel çevre hareketi.",
   her:["Jîngehparêzîya gelêrî.", "Di jîngehparêzîya gelêrî de."],
   gen:["Jîngehparêzîya gelêrî", "Jîngehparêzîya me"]),

  // ── MESLEKLER VE İŞ C1 (15) ──────────────────────────────────

  (id:"c1_426", ku:"Bijîşkê şaredarî", tr:"Belediye doktoru", en:"Municipal doctor",
   cins:"bêcins", ez:"bijîşkê şaredarî", kat:"pîşe", zor:0.59,
   not:"\"Bijîşk\"+\"şaredarî\". Kamu sağlık hizmeti.",
   her:["Bijîşkê şaredarî hat.", "Bijîşkê şaredarî ye."],
   gen:["Bijîşkê şaredarî", "Bijîşkê me"]),

  (id:"c1_427", ku:"Dezgehek çandî", tr:"Kültür kurumu", en:"Cultural institution",
   cins:"mê", ez:"dezgehek çandî", kat:"pîşe", zor:0.60,
   not:"\"Dezgeh\"+\"çandî\". Kültür merkezi/kurumu.",
   her:["Dezgehek çandî hat avakirin.", "Di dezgehek çandî de."],
   gen:["Dezgehek çandî", "Dezgehên me"]),

  (id:"c1_428", ku:"Karmendê rêxistinê", tr:"Kurum çalışanı", en:"Organization employee",
   cins:"bêcins", ez:"karmendê rêxistinê", kat:"pîşe", zor:0.59,
   not:"\"Karmend\"+\"rêxistinê\".",
   her:["Karmendê rêxistinê ye.", "Karmendên rêxistinê hatin."],
   gen:["Karmendê rêxistinê", "Karmendên me"]),

  // ── DİLBİLGİSİ C1 (15) ───────────────────────────────────────

  (id:"c1_429", ku:"Ergatîvîteya C1", tr:"C1 ergatiflik", en:"C1 ergativity",
   cins:"mê", ez:"ergatîvîteya C1", kat:"rêziman", zor:0.59,
   not:"Kurmancî ergatif sistem — C1 derinlemesi. \"Min got\" vs \"Ez çûm\".",
   her:["Ergatîvîteya C1 kûr e.", "Di ergatîvîteya C1 de."],
   gen:["Ergatîvîteya C1", "Ergatîvîteya kurdî"]),

  (id:"c1_430", ku:"Subjunctîva C1", tr:"C1 dilek kipi", en:"C1 subjunctive",
   cins:"mê", ez:"subjunctîva C1", kat:"rêziman", zor:0.59,
   not:"\"Subjunctîv\" = dilek kipi. C1 modal fiiller: \"divê were\", \"dibe ku bê\".",
   her:["Subjunctîva C1.", "Di subjunctîva C1 de."],
   gen:["Subjunctîva C1", "Subjunctîva kurdî"]),

  (id:"c1_431", ku:"Dema referansê di vegotinê", tr:"Anlatıda referans zamanı", en:"Reference time in narration",
   cins:"mê", ez:"dema referansê di vegotinê", kat:"rêziman", zor:0.58,
   not:"\"Dem\"+\"referans\"+\"vegotin\". Metin zamanı kavramı.",
   her:["Dema referansê di vegotinê.", "Di dema referansê de."],
   gen:["Dema referansê di vegotinê", "Dema referansê"]),

  (id:"c1_432", ku:"Nîşaneya ramanî", tr:"Düşünce belirteci", en:"Epistemic marker",
   cins:"mê", ez:"nîşaneya ramanî", kat:"rêziman", zor:0.58,
   not:"\"Nîşane\"+\"ramanî\". Epistemic modality — \"belkî, dibe ku, xuya ye\".",
   her:["Nîşaneya ramanî.", "Di nîşaneya ramanî de."],
   gen:["Nîşaneya ramanî", "Nîşaneyên me"]),

  // ── JIYAN VE DEĞERLER C1 (20) ────────────────────────────────

  (id:"c1_433", ku:"Mebesta jiyanê", tr:"Hayatın amacı", en:"Purpose of life",
   cins:"mê", ez:"mebesta jiyanê", kat:"jiyan", zor:0.60,
   not:"\"Mebest\"+\"jiyan\". Varoluşsal soru.",
   her:["Mebesta jiyanê çi ye?", "Di mebesta jiyanê de."],
   gen:["Mebesta jiyanê", "Mebesta me"]),

  (id:"c1_434", ku:"Têkilîya mirovan û siruştê", tr:"İnsan ve doğa ilişkisi", en:"Human-nature relation",
   cins:"mê", ez:"têkilîya mirovan û siruştê", kat:"jiyan", zor:0.59,
   not:"\"Têkilî\"+\"mirov û siruşt\". Ekolojik felsefe.",
   her:["Têkilîya mirovan û siruştê.", "Di têkilîya mirovan û siruştê de."],
   gen:["Têkilîya mirovan û siruştê", "Têkilîya me"]),

  (id:"c1_435", ku:"Aramîya hundurîn", tr:"İç huzur", en:"Inner peace",
   cins:"mê", ez:"aramîya hundurîn", kat:"jiyan", zor:0.59,
   not:"\"Aramî\"+\"hundurîn\". Ruhsal denge.",
   her:["Aramîya hundurîn lazim e.", "Di aramîya hundurîn de."],
   gen:["Aramîya hundurîn", "Aramîya me"]),

  (id:"c1_436", ku:"Serdestîya çandî", tr:"Kültürel hegemonya", en:"Cultural hegemony",
   cins:"mê", ez:"serdestîya çandî", kat:"nirx", zor:0.59,
   not:"\"Serdestî\"+\"çandî\". Gramsci bağlamında kültürel güç.",
   her:["Serdestîya çandî.", "Di serdestîya çandî de."],
   gen:["Serdestîya çandî", "Serdestîya me"]),

  (id:"c1_437", ku:"Hebûna çandî ya Kurdî", tr:"Kürtçe kültürel varlık", en:"Kurdish cultural existence",
   cins:"mê", ez:"hebûna çandî ya Kurdî", kat:"çand", zor:0.60,
   not:"\"Hebûn\"+\"çandî\"+\"Kurdî\". Kültürel varolma.",
   her:["Hebûna çandî ya Kurdî girîng e.", "Di hebûna çandî ya Kurdî de."],
   gen:["Hebûna çandî ya Kurdî", "Hebûna me"]),

  // ── MEDİA VE İLETİŞİM C1 (20) ────────────────────────────────

  (id:"c1_438", ku:"Çanda dîmenî ya kurdî", tr:"Kürt görsel kültürü", en:"Kurdish visual culture",
   cins:"mê", ez:"çanda dîmenî ya kurdî", kat:"medya", zor:0.59,
   not:"\"Çand\"+\"dîmenî\"+\"kurdî\". Sinema, TV, fotoğraf.",
   her:["Çanda dîmenî ya kurdî.", "Di çanda dîmenî ya kurdî de."],
   gen:["Çanda dîmenî ya kurdî", "Çanda dîmenî ya me"]),

  (id:"c1_439", ku:"Medyaya kurdî ya komarî", tr:"Kamu Kürt medyası", en:"Public Kurdish media",
   cins:"mê", ez:"medyaya kurdî ya komarî", kat:"medya", zor:0.59,
   not:"\"Medya\"+\"kurdî\"+\"komarî\". TRT Kurdî vb. kamusal yayın.",
   her:["Medyaya kurdî ya komarî.", "Di medyaya kurdî ya komarî de."],
   gen:["Medyaya kurdî ya komarî", "Medyaya me"]),

  (id:"c1_440", ku:"Ragihandina çandî ya serhêl", tr:"Çevrimiçi kültürel iletişim", en:"Online cultural communication",
   cins:"mê", ez:"ragihandina çandî ya serhêl", kat:"medya", zor:0.58,
   not:"\"Ragihandin\"+\"çandî\"+\"serhêl\".",
   her:["Ragihandina çandî ya serhêl.", "Di ragihandina çandî ya serhêl de."],
   gen:["Ragihandina çandî ya serhêl", "Ragihandina me"]),

  (id:"c1_441", ku:"Wergerandina çandî", tr:"Kültürel çeviri", en:"Cultural translation",
   cins:"mê", ez:"wergerandina çandî", kat:"medya", zor:0.59,
   not:"\"Wergerandin\"+\"çandî\". Kültürel transfer.",
   her:["Wergerandina çandî dibe.", "Di wergerandina çandî de."],
   gen:["Wergerandina çandî", "Wergerandina me"]),

  (id:"c1_442", ku:"Nûçetemenîya lêgerî", tr:"Araştırmacı gazetecilik", en:"Investigative journalism",
   cins:"mê", ez:"nûçetemenîya lêgerî", kat:"medya", zor:0.59,
   not:"\"Nûçetemeni\"+\"lêgerî\". Derinlemesine gazetecilik.",
   her:["Nûçetemenîya lêgerî.", "Di nûçetemenîya lêgerî de."],
   gen:["Nûçetemenîya lêgerî", "Nûçetemenîya me"]),
];


final kC1_168 = [

  // ── FİİLLER C1 (20) ──────────────────────────────────────────
  (id:"c1_500", ku:"Destnîşan kirin", tr:"Belirtmek / İşaret etmek", en:"To indicate / point out",
   cins:"bêcins", ez:null, kat:"leker", zor:0.59,
   not:"\"Destnîşan kirin\" = belirtmek. \"Di gotara xwe de destnîşan dike ku...\"",
   her:["Min destnîşan kir ku.", "Gotar destnîşan dike."],
   gen:["Destnîşan kirin", "Min destnîşan kir."]),

  (id:"c1_501", ku:"Ragirtin", tr:"Sürdürmek / Devam ettirmek", en:"To maintain / continue",
   cins:"bêcins", ez:null, kat:"leker", zor:0.60,
   not:"\"Ragirtin\" = sürdürmek/tutmak. Ergatif: \"Min ragirt.\"",
   her:["Min ragirt.", "Têkilî ragirt."],
   gen:["Ragirtin û qedandin", "Min ragirt."]),

  (id:"c1_502", ku:"Pêçandin", tr:"Sarmak / Örtmek", en:"To wrap / cover",
   cins:"bêcins", ez:null, kat:"leker", zor:0.58,
   not:"\"Pêçandin\" = sarmak. Mecazi: \"bi gotin pêçandin\" = kelimelerle örtmek.",
   her:["Min pêçand.", "Bi gotin pêçand."],
   gen:["Pêçandin", "Min pêçand."]),

  (id:"c1_503", ku:"Têqîn", tr:"Parlamak / Aydınlanmak", en:"To shine / illuminate",
   cins:"bêcins", ez:null, kat:"leker", zor:0.59,
   not:"\"Têqîn\" = parlamak. \"[BH]: stêr ditêqe\" = yıldız parlar.",
   her:["Stêr ditêqe.", "Hêvî ditêqe."],
   gen:["Têqîn û şaşitîn", "Ditêqe."]),

  (id:"c1_504", ku:"Deranîn", tr:"Çıkarmak / İleri sürmek", en:"To put forward / derive",
   cins:"bêcins", ez:null, kat:"leker", zor:0.59,
   not:"\"Deranîn\" = çıkarmak/türetmek. \"Encaman deranîn\" = sonuçları çıkarmak.",
   her:["Min derxist.", "Encam deranîn."],
   gen:["Deranîn û kitin", "Min derxist."]),

  (id:"c1_505", ku:"Xweş kirin", tr:"Güzelleştirmek / İyileştirmek", en:"To improve / beautify",
   cins:"bêcins", ez:null, kat:"leker", zor:0.60,
   not:"\"Xweş kirin\" = güzelleştirmek. Edebi eleştiride: \"metn xweş kirin\".",
   her:["Min xweş kir.", "Hevok xweş kir."],
   gen:["Xweş kirin û baştir kirin", "Min xweş kir."]),

  // ── NİRXEN (değerler) C1 (15) ────────────────────────────────
  (id:"c1_506", ku:"Rastdarî", tr:"Doğruluk / Dürüstlük", en:"Truthfulness / Integrity",
   cins:"mê", ez:"rastdariyê", kat:"nirx", zor:0.60,
   not:"\"Rast\"+\"darî\". Akademik ve etik bağlamda.",
   her:["Rastdarî girîng e.", "Di rastdariyê de."],
   gen:["Rastdarî û xayîntî", "Rastdarîya me"]),

  (id:"c1_507", ku:"Pêbendî", tr:"Bağlılık / Tutarlılık", en:"Commitment / Consistency",
   cins:"mê", ez:"pêbendiyê", kat:"nirx", zor:0.59,
   not:"\"Pê\"+\"bend\"+\"-î\". Tutarlı olma.",
   her:["Pêbendî lazim e.", "Di pêbendiyê de."],
   gen:["Pêbendî û bêpêbendî", "Pêbendîya me"]),

  (id:"c1_508", ku:"Xweserî û serbixwebûn", tr:"Özerklik ve bağımsızlık", en:"Autonomy and independence",
   cins:"bêcins", ez:null, kat:"nirx", zor:0.60,
   not:"\"Xweserî\"+\"serbixwebûn\". Kürt siyasi değerleri.",
   her:["Xweserî û serbixwebûn.", "Di xweserî û serbixwebûn de."],
   gen:["Xweserî û serbixwebûn", "Xweserîya me"]),

  // ── PÎŞELEr C1 (15) ──────────────────────────────────────────
  (id:"c1_509", ku:"Wênekêş", tr:"Fotoğrafçı", en:"Photographer",
   cins:"bêcins", ez:"wênekêşê", kat:"pîşe", zor:0.60,
   not:"\"Wêne\"+\"kêş\". Sanatsal fotoğrafçı.",
   her:["Ew wênekêş e.", "Wênekêşê navdar."],
   gen:["Wênekêş û derhêner", "Wênekêşê me"]),

  (id:"c1_510", ku:"Çalakvan", tr:"Aktivist", en:"Activist",
   cins:"bêcins", ez:"çalakvanê", kat:"pîşe", zor:0.61,
   not:"\"Çalak\"+\"van\". Sivil toplum aktivisti.",
   her:["Ew çalakvan e.", "Çalakvanên kurd."],
   gen:["Çalakvan û siyasetvan", "Çalakvanên me"]),

  (id:"c1_511", ku:"Zimanzan", tr:"Dilbilimci", en:"Linguist",
   cins:"bêcins", ez:"zimanzanê", kat:"pîşe", zor:0.60,
   not:"\"Ziman\"+\"zan\". Kurmancî dilbilimcisi.",
   her:["Ew zimanzan e.", "Zimanzanên kurd."],
   gen:["Zimanzan û wêjezan", "Zimanzanên me"]),

  (id:"c1_512", ku:"Wêjezan", tr:"Edebiyatçı", en:"Literary scholar",
   cins:"bêcins", ez:"wêjezanê", kat:"pîşe", zor:0.60,
   not:"\"Wêje\"+\"zan\". Edebi araştırmacı.",
   her:["Ew wêjezan e.", "Wêjezanên kurd."],
   gen:["Wêjezan û zimanzan", "Wêjezanên me"]),

  (id:"c1_513", ku:"Dîrokzan", tr:"Tarihçi", en:"Historian",
   cins:"bêcins", ez:"dîrokzanê", kat:"pîşe", zor:0.61,
   not:"\"Dîrok\"+\"zan\". Kürt tarihçisi.",
   her:["Ew dîrokzan e.", "Dîrokzanên kurd."],
   gen:["Dîrokzan û arkeolog", "Dîrokzanên me"]),

  // ── EKONOMİ C1 (20) ──────────────────────────────────────────
  (id:"c1_514", ku:"Çavkaniyên xwezayî", tr:"Doğal kaynaklar", en:"Natural resources",
   cins:"bêcins", ez:"çavkaniyên xwezayî", kat:"aborî", zor:0.60,
   not:"\"Çavkanî\"+\"xwezayî\". Kürdistan'ın zengin kaynakları.",
   her:["Çavkaniyên xwezayî hene.", "Di çavkaniyên xwezayî de."],
   gen:["Çavkaniyên xwezayî", "Çavkaniyên me"]),

  (id:"c1_515", ku:"Neftên Kurdistanê", tr:"Kürdistan'ın petrolü", en:"Kurdistan's oil",
   cins:"nêr", ez:"neftên Kurdistanê", kat:"aborî", zor:0.61,
   not:"\"Neft\"+\"Kurdistanê\". Kuzey Irak petrol kaynakları.",
   her:["Neftên Kurdistanê gelek in.", "Di neftên Kurdistanê de."],
   gen:["Neftên Kurdistanê", "Neftên me"]),

  (id:"c1_516", ku:"Çêkirina xebatê", tr:"İstihdam yaratma", en:"Job creation",
   cins:"mê", ez:"çêkirina xebatê", kat:"aborî", zor:0.59,
   not:"\"Çêkirin\"+\"xebat\". İstihdam politikası.",
   her:["Çêkirina xebatê lazim e.", "Di çêkirina xebatê de."],
   gen:["Çêkirina xebatê", "Çêkirina me"]),

  (id:"c1_517", ku:"Rizgarkirina aborî", tr:"Ekonomik kalkınma", en:"Economic development",
   cins:"mê", ez:"rizgarkirina aborî", kat:"aborî", zor:0.59,
   not:"\"Rizgarkirin\"+\"aborî\". Kalkınma ekonomisi.",
   her:["Rizgarkirina aborî lazim e.", "Di rizgarkirina aborî de."],
   gen:["Rizgarkirina aborî", "Rizgarkirina me"]),

  (id:"c1_518", ku:"Pêşkeftina berdewam", tr:"Sürdürülebilir kalkınma", en:"Sustainable development",
   cins:"mê", ez:"pêşkeftina berdewam", kat:"aborî", zor:0.60,
   not:"\"Pêşkeftin\"+\"berdewam\". BM Kalkınma Hedefleri.",
   her:["Pêşkeftina berdewam armancek e.", "Di pêşkeftina berdewam de."],
   gen:["Pêşkeftina berdewam", "Pêşkeftina me"]),

  (id:"c1_519", ku:"Yekîtîya aborî ya Kurdistanê", tr:"Kürdistanın ekonomik birliği", en:"Economic unity of Kurdistan",
   cins:"mê", ez:"yekîtîya aborî ya Kurdistanê", kat:"aborî", zor:0.59,
   not:"\"Yekîtî\"+\"aborî\"+\"Kurdistanê\".",
   her:["Yekîtîya aborî ya Kurdistanê.", "Di yekîtîya aborî ya Kurdistanê de."],
   gen:["Yekîtîya aborî ya Kurdistanê", "Yekîtîya me"]),

  // ── HUNER VE KÜLTÜR C1 (20) ──────────────────────────────────
  (id:"c1_520", ku:"Şanogerîya kurdî", tr:"Kürt tiyatrosu", en:"Kurdish theater",
   cins:"mê", ez:"şanogerîya kurdî", kat:"huner", zor:0.60,
   not:"\"Şanogeri\"+\"kurdî\". Kürt tiyatro geleneği.",
   her:["Şanogerîya kurdî xweş e.", "Di şanogerîya kurdî de."],
   gen:["Şanogerîya kurdî", "Şanogerîya me"]),

  (id:"c1_521", ku:"Muzîka klasîk a kurdî", tr:"Kürt klasik müziği", en:"Kurdish classical music",
   cins:"mê", ez:"muzîka klasîk a kurdî", kat:"huner", zor:0.60,
   not:"\"Muzîk\"+\"klasîk\"+\"kurdî\". Dengbêj ve makam geleneği.",
   her:["Muzîka klasîk a kurdî.", "Di muzîka klasîk a kurdî de."],
   gen:["Muzîka klasîk a kurdî", "Muzîka me"]),

  (id:"c1_522", ku:"Hunerên destan a kurdî", tr:"Kürt destansı sanatları", en:"Kurdish epic arts",
   cins:"bêcins", ez:"hunerên destan a kurdî", kat:"huner", zor:0.59,
   not:"\"Huner\"+\"destan\"+\"kurdî\". Sözlü sanat geleneği.",
   her:["Hunerên destan a kurdî hene.", "Di hunerên destan a kurdî de."],
   gen:["Hunerên destan a kurdî", "Hunerên me"]),

  (id:"c1_523", ku:"Xemkarîya kurdî", tr:"Kürt el sanatları", en:"Kurdish handicrafts",
   cins:"mê", ez:"xemkarîya kurdî", kat:"huner", zor:0.60,
   not:"\"Xemkarî\"+\"kurdî\". Halı, kilim, nakış sanatı.",
   her:["Xemkarîya kurdî xweş e.", "Di xemkarîya kurdî de."],
   gen:["Xemkarîya kurdî", "Xemkarîya me"]),

  (id:"c1_524", ku:"Wêneyên dîrokî yên kurdî", tr:"Tarihi Kürt fotoğrafları", en:"Historic Kurdish photographs",
   cins:"bêcins", ez:"wêneyên dîrokî yên kurdî", kat:"huner", zor:0.59,
   not:"\"Wêne\"+\"dîrokî\"+\"kurdî\". Görsel tarih belgeleri.",
   her:["Wêneyên dîrokî yên kurdî hene.", "Di wêneyên dîrokî yên kurdî de."],
   gen:["Wêneyên dîrokî yên kurdî", "Wêneyên me"]),

  // ── DİLBİLGİSİ C1 DERİN (20) ─────────────────────────────────
  (id:"c1_525", ku:"Lêkera têgîhîner", tr:"Algı fiili", en:"Perception verb",
   cins:"mê", ez:"lêkera têgîhîner", kat:"rêziman", zor:0.58,
   not:"\"Lêker\"+\"têgîhîner\". Dîtin, bihîstin, hîskirin — algı fiilleri.",
   her:["Lêkera têgîhîner.", "Di lêkera têgîhîner de."],
   gen:["Lêkera têgîhîner", "Lêkerên kurdî"]),

  (id:"c1_526", ku:"Lêkera halan", tr:"Durum fiili", en:"Stative verb",
   cins:"mê", ez:"lêkera halan", kat:"rêziman", zor:0.58,
   not:"\"Lêker\"+\"hal\". Zanîn, hezkirin, xwestin — durum fiilleri.",
   her:["Lêkera halan.", "Di lêkera halan de."],
   gen:["Lêkera halan", "Lêkerên halan"]),

  (id:"c1_527", ku:"Lêkera kirin û bûnê", tr:"Yapmak ve olmak fiilleri", en:"Kirin and bûn verbs",
   cins:"bêcins", ez:null, kat:"rêziman", zor:0.60,
   not:"\"Kirin\" (geçişli) + \"bûn\" (geçişsiz). Kurmancîde temel fiil çifti.",
   her:["Lêkera kirin û bûnê.", "Kirin û bûn cûda ne."],
   gen:["Lêkera kirin û bûnê", "Kirin vs bûn"]),

  (id:"c1_528", ku:"Rabirdûya bêserdem", tr:"Belirsiz geçmiş", en:"Indefinite past",
   cins:"mê", ez:"rabirdûya bêserdem", kat:"rêziman", zor:0.58,
   not:"\"Rabirdû\"+\"bêserdem\". Kurmancî'de duyumsal geçmiş kipi.",
   her:["Rabirdûya bêserdem.", "Di rabirdûya bêserdem de."],
   gen:["Rabirdûya bêserdem", "Demên rabirdûyê"]),

  // ── YAŞAM VE VAROLUŞ C1 (20) ─────────────────────────────────
  (id:"c1_529", ku:"Têkçûna nasnameya teme", tr:"Temel kimliğin çöküşü", en:"Collapse of core identity",
   cins:"mê", ez:"têkçûna nasnameya teme", kat:"jiyan", zor:0.59,
   not:"\"Têkçûn\"+\"nasname\"+\"teme\". Asimilasyon sonucu.",
   her:["Têkçûna nasnameya teme.", "Di têkçûna nasnameya teme de."],
   gen:["Têkçûna nasnameya teme", "Nasnameya me"]),

  (id:"c1_530", ku:"Jiyana di diyan de", tr:"İki kültür arasında yaşam", en:"Life between two cultures",
   cins:"mê", ez:"jiyana di diyan de", kat:"jiyan", zor:0.60,
   not:"\"Jiyan\"+\"di diyan de\". Diaspora bireyin deneyimi.",
   her:["Jiyana di diyan de.", "Di jiyana di diyan de."],
   gen:["Jiyana di diyan de", "Jiyana me"]),

  (id:"c1_531", ku:"Girêdana bi welatê xwe", tr:"Vatanla bağ", en:"Bond with homeland",
   cins:"mê", ez:"girêdana bi welatê xwe", kat:"jiyan", zor:0.60,
   not:"\"Girêdan\"+\"welat xwe\".",
   her:["Girêdana bi welatê xwe heye.", "Di girêdana bi welatê xwe de."],
   gen:["Girêdana bi welatê xwe", "Girêdana me"]),

  (id:"c1_532", ku:"Pêşkeftina kesane", tr:"Kişisel gelişim", en:"Personal development",
   cins:"mê", ez:"pêşkeftina kesane", kat:"jiyan", zor:0.61,
   not:"\"Pêşkeftin\"+\"kesane\".",
   her:["Pêşkeftina kesane lazim e.", "Di pêşkeftina kesane de."],
   gen:["Pêşkeftina kesane", "Pêşkeftina me"]),

  // ── EKOLOJI C1 DERINLEME (15) ────────────────────────────────
  (id:"c1_533", ku:"Piçûkbûna cûrbecûriya biyolojîk", tr:"Biyolojik çeşitliliğin azalması", en:"Loss of biodiversity",
   cins:"mê", ez:"piçûkbûna cûrbecûriya biyolojîk", kat:"ekoloji", zor:0.58,
   not:"\"Piçûkbûn\"+\"cûrbecûrî\"+\"biyolojîk\". Çevresel kriz.",
   her:["Piçûkbûna cûrbecûriya biyolojîk.", "Di piçûkbûna cûrbecûriya biyolojîk de."],
   gen:["Piçûkbûna cûrbecûriya biyolojîk", "Cûrbecûriya me"]),

  (id:"c1_534", ku:"Avhewaya Kurdistanê", tr:"Kürdistan'ın iklimi", en:"Kurdistan's climate",
   cins:"mê", ez:"avhewaya Kurdistanê", kat:"ekoloji", zor:0.61,
   not:"\"Avhewa\"+\"Kurdistanê\". Coğrafi özellik.",
   her:["Avhewaya Kurdistanê baş e.", "Di avhewaya Kurdistanê de."],
   gen:["Avhewaya Kurdistanê", "Avhewaya me"]),

  (id:"c1_535", ku:"Cotkarîya xwecihî", tr:"Geleneksel tarım", en:"Indigenous agriculture",
   cins:"mê", ez:"cotkarîya xwecihî", kat:"ekoloji", zor:0.59,
   not:"\"Cotkarî\"+\"xwecihî\". Kürt yöresel tarım yöntemleri.",
   her:["Cotkarîya xwecihî baş e.", "Di cotkarîya xwecihî de."],
   gen:["Cotkarîya xwecihî", "Cotkarîya me"]),

  // ── GENEL DOLGU C1 (23) ──────────────────────────────────────
  (id:"c1_536", ku:"Daxwazname", tr:"Dilekçe", en:"Petition",
   cins:"mê", ez:"daxwaznamê", kat:"zagon", zor:0.61,
   not:"\"Daxwaz\"+\"name\". Resmi başvuru belgesi.",
   her:["Daxwazname hat nivîsandin.", "Di daxwaznamê de."],
   gen:["Daxwazname", "Daxwaznamên me"]),

  (id:"c1_537", ku:"Hiqûqa çandê", tr:"Kültür hukuku", en:"Cultural law",
   cins:"mê", ez:"hiqûqa çandê", kat:"zagon", zor:0.59,
   not:"\"Hiqûq\"+\"çandê\". Kültürel miras hukuku.",
   her:["Hiqûqa çandê.", "Di hiqûqa çandê de."],
   gen:["Hiqûqa çandê", "Hiqûqa me"]),

  (id:"c1_538", ku:"Peywira giştî", tr:"Toplumsal sorumluluk", en:"Public duty",
   cins:"mê", ez:"peywira giştî", kat:"nirx", zor:0.60,
   not:"\"Peywir\"+\"giştî\". Kamusal görev.",
   her:["Peywira giştî heye.", "Di peywira giştî de."],
   gen:["Peywira giştî", "Peywira me"]),

  (id:"c1_539", ku:"Bingehên dîrokî", tr:"Tarihsel temeller", en:"Historical foundations",
   cins:"bêcins", ez:"bingehên dîrokî", kat:"dîrok", zor:0.60,
   not:"\"Bingehn\"+\"dîrokî\". Kürt ulusal tarih zeminleri.",
   her:["Bingehên dîrokî hene.", "Di bingehên dîrokî de."],
   gen:["Bingehên dîrokî", "Bingehên me"]),

  (id:"c1_540", ku:"Zimanê siyasî ya kurd", tr:"Kürt siyasi dili", en:"Kurdish political language",
   cins:"nêr", ez:"zimanê siyasî ya kurd", kat:"ziman", zor:0.60,
   not:"\"Ziman\"+\"siyasî\"+\"kurd\". Siyasi söylem.",
   her:["Zimanê siyasî ya kurd.", "Di zimanê siyasî ya kurd de."],
   gen:["Zimanê siyasî ya kurd", "Zimanê siyasî ya me"]),

  (id:"c1_541", ku:"Pêwendîya nav netewan", tr:"Milletlerarası ilişkiler", en:"Inter-ethnic relations",
   cins:"mê", ez:"pêwendîya nav netewan", kat:"civakî", zor:0.59,
   not:"\"Pêwendî\"+\"nav netewan\".",
   her:["Pêwendîya nav netewan.", "Di pêwendîya nav netewan de."],
   gen:["Pêwendîya nav netewan", "Pêwendîya me"]),

  (id:"c1_542", ku:"Çalakîya demokratîk", tr:"Demokratik aktivizm", en:"Democratic activism",
   cins:"mê", ez:"çalakîya demokratîk", kat:"siyaset", zor:0.60,
   not:"\"Çalakî\"+\"demokratîk\".",
   her:["Çalakîya demokratîk lazim e.", "Di çalakîya demokratîk de."],
   gen:["Çalakîya demokratîk", "Çalakîya me"]),

  (id:"c1_543", ku:"Mafên kolektîf", tr:"Kolektif haklar", en:"Collective rights",
   cins:"bêcins", ez:"mafên kolektîf", kat:"zagon", zor:0.61,
   not:"\"Maf\"+\"kolektîf\". Bireysel değil toplu haklar.",
   her:["Mafên kolektîf lazim in.", "Di mafên kolektîf de."],
   gen:["Mafên kolektîf", "Mafên me"]),

  (id:"c1_544", ku:"Têkilîya azadî û berpirsiyariyê", tr:"Özgürlük ve sorumluluk ilişkisi", en:"Relation of freedom and responsibility",
   cins:"mê", ez:"têkilîya azadî û berpirsiyariyê", kat:"felsefe", zor:0.59,
   not:"\"Têkilî\"+\"azadî û berpirsiyarî\". Etik temel gerilim.",
   her:["Têkilîya azadî û berpirsiyariyê.", "Di têkilîya azadî û berpirsiyariyê de."],
   gen:["Têkilîya azadî û berpirsiyariyê", "Têkilîya me"]),

  (id:"c1_545", ku:"Endezyarîya sosyal", tr:"Sosyal mühendislik", en:"Social engineering",
   cins:"mê", ez:"endezyarîya sosyal", kat:"civakî", zor:0.59,
   not:"\"Endezyarî\"+\"sosyal\". Sosyal dönüşüm tasarımı.",
   her:["Endezyarîya sosyal.", "Di endezyarîya sosyal de."],
   gen:["Endezyarîya sosyal", "Endezyarîya me"]),

  (id:"c1_546", ku:"Helwest û nirx", tr:"Tutum ve değerler", en:"Attitude and values",
   cins:"bêcins", ez:null, kat:"nirx", zor:0.60,
   not:"\"Helwest\"+\"nirx\". Kişisel ve kolektif değerler.",
   her:["Helwest û nirx girîng in.", "Di helwest û nirx de."],
   gen:["Helwest û nirx", "Nirxên me"]),

  (id:"c1_547", ku:"Hişmendîya çandî", tr:"Kültürel bilinç", en:"Cultural consciousness",
   cins:"mê", ez:"hişmendîya çandî", kat:"çand", zor:0.60,
   not:"\"Hişmendî\"+\"çandî\". Kültürel farkındalık.",
   her:["Hişmendîya çandî lazim e.", "Di hişmendîya çandî de."],
   gen:["Hişmendîya çandî", "Hişmendîya me"]),

  (id:"c1_548", ku:"Temsîlkarîya medyayê", tr:"Medyada temsil", en:"Media representation",
   cins:"mê", ez:"temsîlkarîya medyayê", kat:"medya", zor:0.59,
   not:"\"Temsîlkarî\"+\"medyayê\". Kürtlerin medyadaki görünürlüğü.",
   her:["Temsîlkarîya medyayê.", "Di temsîlkarîya medyayê de."],
   gen:["Temsîlkarîya medyayê", "Temsîlkarîya me"]),

  (id:"c1_549", ku:"Warê çandî yê welatê", tr:"Vatanın kültürel alanı", en:"Cultural space of homeland",
   cins:"nêr", ez:"warê çandî yê welatê", kat:"çand", zor:0.60,
   not:"\"War\"+\"çandî\"+\"welat\". Kültürel coğrafya.",
   her:["Warê çandî yê welatê.", "Di warê çandî yê welatê de."],
   gen:["Warê çandî yê welatê", "Warê me"]),

  (id:"c1_550", ku:"Zimanê xweşbextî", tr:"Mutluluk dili", en:"Language of happiness",
   cins:"nêr", ez:"zimanê xweşbextî", kat:"ziman", zor:0.60,
   not:"\"Ziman\"+\"xweşbextî\". Pozitif psikoloji ve dil.",
   her:["Zimanê xweşbextî heye.", "Di zimanê xweşbextî de."],
   gen:["Zimanê xweşbextî", "Zimanê me"]),
];


final kC1_Son117 = [

  // ── ZIMAN (dil) — 12 ──────────────────────────────────────────
  (id:"c1_600", ku:"Têgihîştina kêmbandorî ya zimanê", tr:"Dil bozunumu", en:"Language attrition",
   cins:"mê", ez:"têgihîştina kêmbandorî ya zimanê", kat:"ziman", zor:0.58,
   not:"Dil kaybı — uzun süreli temasın ardından yetkinliğin azalması.",
   her:["Têgihîştina kêmbandorî ya zimanê.", "Di têgihîştina kêmbandorî de."],
   gen:["Têgihîştina kêmbandorî ya zimanê", "Kêmbandoriya zimanî"]),

  (id:"c1_601", ku:"Çêkirina peyvên nû", tr:"Neolojizm / Yeni kelime üretimi", en:"Neologism",
   cins:"mê", ez:"çêkirina peyvên nû", kat:"ziman", zor:0.59,
   not:"\"Çêkirin\"+\"peyv\"+\"nû\". Kürtçede kelime türetme geleneği.",
   her:["Çêkirina peyvên nû lazim e.", "Di çêkirina peyvên nû de."],
   gen:["Çêkirina peyvên nû", "Çêkirina me"]),

  (id:"c1_602", ku:"Piralîbûna zimên", tr:"Çok dillilik", en:"Multilingualism",
   cins:"mê", ez:"piralîbûna zimên", kat:"ziman", zor:0.59,
   not:"\"Piralî\"+\"zimên\". Kürt bireyler genellikle çok dilli.",
   her:["Piralîbûna zimên baş e.", "Di piralîbûna zimên de."],
   gen:["Piralîbûna zimên", "Piralîbûna me"]),

  (id:"c1_603", ku:"Zimanê xwendekarî", tr:"Öğrenim dili", en:"Language of instruction",
   cins:"nêr", ez:"zimanê xwendekarî", kat:"ziman", zor:0.60,
   not:"\"Ziman\"+\"xwendekarî\". Okulda öğretim dili meselesi.",
   her:["Zimanê xwendekarî kurdî ye.", "Di zimanê xwendekarî de."],
   gen:["Zimanê xwendekarî", "Zimanê xwendekarî ya me"]),

  (id:"c1_604", ku:"Xweza zimanî ya navçeyî", tr:"Bölgenin dilsel doğası", en:"Linguistic nature of the region",
   cins:"mê", ez:"xweza zimanî ya navçeyî", kat:"ziman", zor:0.58,
   not:"\"Xweza\"+\"zimanî\"+\"navçeyî\". Dil coğrafyası.",
   her:["Xweza zimanî ya navçeyî.", "Di xweza zimanî ya navçeyî de."],
   gen:["Xweza zimanî ya navçeyî", "Xweza zimanî ya me"]),

  (id:"c1_605", ku:"Têkiliya nav-zimanan", tr:"Diller arası ilişki", en:"Interlingual relation",
   cins:"mê", ez:"têkiliya nav-zimanan", kat:"ziman", zor:0.58,
   not:"\"Têkilî\"+\"nav-zimanan\".",
   her:["Têkiliya nav-zimanan heye.", "Di têkiliya nav-zimanan de."],
   gen:["Têkiliya nav-zimanan", "Têkiliya zimanan"]),

  // ── EDEBIYAT (wêje) — 12 ──────────────────────────────────────
  (id:"c1_606", ku:"Metnên referansê", tr:"Referans metinler", en:"Reference texts",
   cins:"bêcins", ez:"metnên referansê", kat:"edebiyat", zor:0.59,
   not:"\"Metn\"+\"referans\". Bir alanın kanon metinleri.",
   her:["Metnên referansê hene.", "Di metnên referansê de."],
   gen:["Metnên referansê", "Metnên me"]),

  (id:"c1_607", ku:"Vegotina duyem a ezmûnê", tr:"Deneyimi ikinci kez anlatma", en:"Re-narrating experience",
   cins:"mê", ez:"vegotina duyem a ezmûnê", kat:"edebiyat", zor:0.58,
   not:"\"Vegotin\"+\"duyem\"+\"ezmûn\". Anı ve otobiyografi.",
   her:["Vegotina duyem a ezmûnê.", "Di vegotina duyem a ezmûnê de."],
   gen:["Vegotina duyem a ezmûnê", "Vegotina me"]),

  (id:"c1_608", ku:"Dengê vegoterê", tr:"Anlatıcının sesi", en:"Narrator's voice",
   cins:"nêr", ez:"dengê vegoterê", kat:"edebiyat", zor:0.59,
   not:"\"Deng\"+\"vegoter\". Narratoloji kavramı.",
   her:["Dengê vegoterê.", "Di dengê vegoterê de."],
   gen:["Dengê vegoterê", "Dengê me"]),

  (id:"c1_609", ku:"Dem û cihê vegotinê", tr:"Anlatının zaman ve mekânı", en:"Time and place of narration",
   cins:"bêcins", ez:null, kat:"edebiyat", zor:0.58,
   not:"\"Dem û cih\"+\"vegotin\". Edebî zaman-uzam.",
   her:["Dem û cihê vegotinê.", "Di dem û cihê vegotinê de."],
   gen:["Dem û cihê vegotinê", "Dem û cihê me"]),

  // ── CIVAKÎ (toplum) — 12 ──────────────────────────────────────
  (id:"c1_610", ku:"Têkoşîna sinifî", tr:"Sınıf mücadelesi", en:"Class struggle",
   cins:"mê", ez:"têkoşîna sinifî", kat:"civakî", zor:0.59,
   not:"\"Têkoşîn\"+\"sinifî\". Marksist kavram, Kürt bağlamına uyarlanmış.",
   her:["Têkoşîna sinifî û neteweyî.", "Di têkoşîna sinifî de."],
   gen:["Têkoşîna sinifî", "Têkoşîna me"]),

  (id:"c1_611", ku:"Komên civakî yên qeyran", tr:"Kriz toplumsal grupları", en:"Social crisis groups",
   cins:"bêcins", ez:"komên civakî yên qeyran", kat:"civakî", zor:0.58,
   not:"\"Kom\"+\"civakî\"+\"qeyran\".",
   her:["Komên civakî yên qeyran.", "Di komên civakî yên qeyran de."],
   gen:["Komên civakî yên qeyran", "Komên me"]),

  (id:"c1_612", ku:"Xebata ji bo wekheviyê", tr:"Eşitlik çalışması", en:"Equity work",
   cins:"mê", ez:"xebata ji bo wekheviyê", kat:"civakî", zor:0.60,
   not:"\"Xebat\"+\"wekhevî\". Toplumsal eşitlik savunuculuğu.",
   her:["Xebata ji bo wekheviyê lazim e.", "Di xebata ji bo wekheviyê de."],
   gen:["Xebata ji bo wekheviyê", "Xebata me"]),

  (id:"c1_613", ku:"Girêdana civakî", tr:"Sosyal bağ", en:"Social bond",
   cins:"mê", ez:"girêdana civakî", kat:"civakî", zor:0.60,
   not:"\"Girêdan\"+\"civakî\". Toplumsal uyum.",
   her:["Girêdana civakî baş e.", "Di girêdana civakî de."],
   gen:["Girêdana civakî", "Girêdana me"]),

  // ── ZANIST (bilim) — 10 ───────────────────────────────────────
  (id:"c1_614", ku:"Metodên nitelî û nicelikî", tr:"Nitel ve nicel yöntemler", en:"Qualitative and quantitative methods",
   cins:"bêcins", ez:"metodên nitelî û nicelikî", kat:"zanist", zor:0.59,
   not:"\"Metodên nitelî\" = nitel, \"nicelikî\" = nicel. Araştırma metodolojisi.",
   her:["Metodên nitelî û nicelikî.", "Di metodên nitelî û nicelikî de."],
   gen:["Metodên nitelî û nicelikî", "Metodên me"]),

  (id:"c1_615", ku:"Danasîna teorîk", tr:"Teorik çerçeve", en:"Theoretical framework",
   cins:"mê", ez:"danasîna teorîk", kat:"zanist", zor:0.59,
   not:"\"Danasîn\"+\"teorîk\". Araştırma çerçevesi.",
   her:["Danasîna teorîk lazim e.", "Di danasîna teorîk de."],
   gen:["Danasîna teorîk", "Danasîna me"]),

  (id:"c1_616", ku:"Bihêzkirina delîlan", tr:"Kanıtların güçlendirilmesi", en:"Strengthening evidence",
   cins:"mê", ez:"bihêzkirina delîlan", kat:"zanist", zor:0.58,
   not:"\"Bihêzkirin\"+\"delîl\".",
   her:["Bihêzkirina delîlan lazim e.", "Di bihêzkirina delîlan de."],
   gen:["Bihêzkirina delîlan", "Bihêzkirina me"]),

  // ── AKADEMİK — 10 ────────────────────────────────────────────
  (id:"c1_617", ku:"Gotara pêşverû", tr:"İlerici makale", en:"Progressive article",
   cins:"mê", ez:"gotara pêşverû", kat:"akademik", zor:0.58,
   not:"\"Gotar\"+\"pêşverû\". Alanı ileriye taşıyan akademik çalışma.",
   her:["Gotara pêşverû hat weşandin.", "Di gotara pêşverû de."],
   gen:["Gotara pêşverû", "Gotara me"]),

  (id:"c1_618", ku:"Têbîniya rêzimanî", tr:"Dilbilgisel not", en:"Grammatical note",
   cins:"mê", ez:"têbîniya rêzimanî", kat:"akademik", zor:0.59,
   not:"\"Têbînî\"+\"rêzimanî\". Metin kenar notu.",
   her:["Têbîniya rêzimanî heye.", "Di têbîniya rêzimanî de."],
   gen:["Têbîniya rêzimanî", "Têbîniyên me"]),

  (id:"c1_619", ku:"Rêza encamgirtinê", tr:"Sonuç çıkarma sırası", en:"Sequence of conclusions",
   cins:"mê", ez:"rêza encamgirtinê", kat:"akademik", zor:0.58,
   not:"\"Rêz\"+\"encamgirtin\". Tümdengelim / tümevarım.",
   her:["Rêza encamgirtinê.", "Di rêza encamgirtinê de."],
   gen:["Rêza encamgirtinê", "Rêza me"]),

  // ── KIMLIK — 10 ───────────────────────────────────────────────
  (id:"c1_620", ku:"Xwebarkirina nasnameya xwe", tr:"Kimliğini kabul ettirme", en:"Asserting one's identity",
   cins:"mê", ez:"xwebarkirina nasnameya xwe", kat:"kimlik", zor:0.59,
   not:"\"Xwebarkirin\"+\"nasname\". Kimlik görünürlüğü.",
   her:["Xwebarkirina nasnameya xwe.", "Di xwebarkirina nasnameya xwe de."],
   gen:["Xwebarkirina nasnameya xwe", "Nasnamaya me"]),

  (id:"c1_621", ku:"Wekhevîya nasnameyan", tr:"Kimliklerin eşitliği", en:"Equality of identities",
   cins:"mê", ez:"wekhevîya nasnameyan", kat:"kimlik", zor:0.59,
   not:"\"Wekhevî\"+\"nasname\". Kimlik tanınması.",
   her:["Wekhevîya nasnameyan.", "Di wekhevîya nasnameyan de."],
   gen:["Wekhevîya nasnameyan", "Wekhevîya me"]),

  // ── DİLBİLGİSİ C1 — 10 ───────────────────────────────────────
  (id:"c1_622", ku:"Dema berçav ya C1", tr:"C1 şimdiki zaman analizi", en:"C1 present tense analysis",
   cins:"mê", ez:"dema berçav ya C1", kat:"rêziman", zor:0.58,
   not:"Kurmancî şimdiki zaman — \"di...de\" çerçevesi ile kip ayrımı.",
   her:["Dema berçav ya C1.", "Di dema berçav ya C1 de."],
   gen:["Dema berçav ya C1", "Demên C1"]),

  (id:"c1_623", ku:"Veguherîna navdêrê", tr:"İsim dönüşümü", en:"Noun transformation",
   cins:"mê", ez:"veguherîna navdêrê", kat:"rêziman", zor:0.58,
   not:"\"Veguherîn\"+\"navdêr\". İsimden türev yapma.",
   her:["Veguherîna navdêrê.", "Di veguherîna navdêrê de."],
   gen:["Veguherîna navdêrê", "Veguherîna me"]),

  (id:"c1_624", ku:"Fonksiyona cînavkê", tr:"Zamirin işlevi", en:"Function of pronoun",
   cins:"mê", ez:"fonksiyona cînavkê", kat:"rêziman", zor:0.59,
   not:"\"Fonksiyon\"+\"cînavk\". Zamir sisteminin işlevsel analizi.",
   her:["Fonksiyona cînavkê.", "Di fonksiyona cînavkê de."],
   gen:["Fonksiyona cînavkê", "Fonksiyona rêzimanî"]),

  // ── PERWERDE — 8 ──────────────────────────────────────────────
  (id:"c1_625", ku:"Hînbûna bi zimanê zikmakî", tr:"Anadilde öğrenme", en:"Learning in the mother tongue",
   cins:"mê", ez:"hînbûna bi zimanê zikmakî", kat:"perwerde", zor:0.60,
   not:"\"Hînbûn\"+\"zimanê zikmakî\". Anadil eğitiminin faydaları.",
   her:["Hînbûna bi zimanê zikmakî baş e.", "Di hînbûna bi zimanê zikmakî de."],
   gen:["Hînbûna bi zimanê zikmakî", "Hînbûna me"]),

  (id:"c1_626", ku:"Mamosteya bi ezmûn", tr:"Deneyimli öğretmen", en:"Experienced teacher",
   cins:"mê", ez:"mamosteya bi ezmûn", kat:"perwerde", zor:0.61,
   not:"\"Mamoste\"+\"ezmûn\".",
   her:["Mamosteya bi ezmûn baş e.", "Mamosteya bi ezmûn hat."],
   gen:["Mamosteya bi ezmûn", "Mamosteya me"]),

  (id:"c1_627", ku:"Bernameya C1 ya fêrkirinê", tr:"C1 öğretim programı", en:"C1 teaching program",
   cins:"mê", ez:"bernameya C1 ya fêrkirinê", kat:"perwerde", zor:0.59,
   not:"\"Bername\"+\"C1\"+\"fêrkirin\".",
   her:["Bernameya C1 ya fêrkirinê.", "Di bernameya C1 ya fêrkirinê de."],
   gen:["Bernameya C1 ya fêrkirinê", "Bernameya me"]),

  // ── JIYAN — 8 ────────────────────────────────────────────────
  (id:"c1_628", ku:"Bergirîya jiyanê", tr:"Hayatın direnci", en:"Life's resilience",
   cins:"mê", ez:"bergirîya jiyanê", kat:"jiyan", zor:0.59,
   not:"\"Bergirî\"+\"jiyan\". Zorluğa karşı dayanç.",
   her:["Bergirîya jiyanê heye.", "Di bergirîya jiyanê de."],
   gen:["Bergirîya jiyanê", "Bergirîya me"]),

  (id:"c1_629", ku:"Pêşkeftina li dijî zorî", tr:"Zorluğa rağmen ilerleme", en:"Progress despite difficulty",
   cins:"mê", ez:"pêşkeftina li dijî zorî", kat:"jiyan", zor:0.59,
   not:"\"Pêşkeftin\"+\"dijî zorî\".",
   her:["Pêşkeftina li dijî zorî.", "Di pêşkeftina li dijî zorî de."],
   gen:["Pêşkeftina li dijî zorî", "Pêşkeftina me"]),

  (id:"c1_630", ku:"Armanca bilind", tr:"Yüksek hedef", en:"High goal",
   cins:"mê", ez:"armanca bilind", kat:"jiyan", zor:0.61,
   not:"\"Armanc\"+\"bilind\". Kariyer ve yaşam hedefi.",
   her:["Armanca bilind heye.", "Di armanca bilind de."],
   gen:["Armanca bilind", "Armanca me"]),

  // ── ÇAND (kültür) — 8 ─────────────────────────────────────────
  (id:"c1_631", ku:"Merasîmên neteweyî", tr:"Ulusal törenler", en:"National ceremonies",
   cins:"bêcins", ez:"merasîmên neteweyî", kat:"çand", zor:0.60,
   not:"\"Merasîm\"+\"neteweyî\". Newroz, şehit anmaları vs.",
   her:["Merasîmên neteweyî hatin.", "Di merasîmên neteweyî de."],
   gen:["Merasîmên neteweyî", "Merasîmên me"]),

  (id:"c1_632", ku:"Sembolên nasnameya kurdî", tr:"Kürt kimliği sembolleri", en:"Kurdish identity symbols",
   cins:"bêcins", ez:"sembolên nasnameya kurdî", kat:"çand", zor:0.61,
   not:"\"Sembol\"+\"nasname\"+\"kurdî\". Bayrak, kıyafet, müzik.",
   her:["Sembolên nasnameya kurdî.", "Di sembolên nasnameya kurdî de."],
   gen:["Sembolên nasnameya kurdî", "Sembolên me"]),

  (id:"c1_633", ku:"Gotinên pêşiyan", tr:"Atalar sözleri", en:"Proverbs / Sayings of ancestors",
   cins:"bêcins", ez:"gotinên pêşiyan", kat:"çand", zor:0.61,
   not:"\"Gotin\"+\"pêşiyan\". Kürt sözlü bilgelik geleneği.",
   her:["Gotinên pêşiyan girîng in.", "Di gotinên pêşiyan de."],
   gen:["Gotinên pêşiyan", "Gotinên me"]),

  // ── FELSEFE — 8 ───────────────────────────────────────────────
  (id:"c1_634", ku:"Felsefa cihêrengiyê", tr:"Farklılık felsefesi", en:"Philosophy of difference",
   cins:"mê", ez:"felsefa cihêrengiyê", kat:"felsefe", zor:0.58,
   not:"\"Felsefe\"+\"cihêrengî\". Deleuze/Derrida bağlamı.",
   her:["Felsefa cihêrengiyê.", "Di felsefa cihêrengiyê de."],
   gen:["Felsefa cihêrengiyê", "Felsefa me"]),

  (id:"c1_635", ku:"Zanistiya exlaqê", tr:"Ahlak bilimi / Etik", en:"Ethics / Moral science",
   cins:"mê", ez:"zanistiya exlaqê", kat:"felsefe", zor:0.59,
   not:"\"Zanistî\"+\"exlaq\". Normatif etik.",
   her:["Zanistiya exlaqê dixwînim.", "Di zanistiya exlaqê de."],
   gen:["Zanistiya exlaqê", "Zanistiya me"]),

  (id:"c1_636", ku:"Têkiliya hişmendiyê û hebûnê", tr:"Bilinç ve varoluş ilişkisi", en:"Consciousness-existence relation",
   cins:"mê", ez:"têkiliya hişmendiyê û hebûnê", kat:"felsefe", zor:0.57,
   not:"\"Têkilî\"+\"hişmendî û hebûn\". Varoluşçu felsefe.",
   her:["Têkiliya hişmendiyê û hebûnê.", "Di têkiliya hişmendiyê û hebûnê de."],
   gen:["Têkiliya hişmendiyê û hebûnê", "Têkiliya me"]),

  // ── SİYASET — 7 ──────────────────────────────────────────────
  (id:"c1_637", ku:"Alîgirîya siyasî ya Kurdan", tr:"Kürt siyasi taraftarlığı", en:"Kurdish political partisanship",
   cins:"mê", ez:"alîgirîya siyasî ya Kurdan", kat:"siyaset", zor:0.59,
   not:"\"Alîgirî\"+\"siyasî\"+\"Kurdan\".",
   her:["Alîgirîya siyasî ya Kurdan.", "Di alîgirîya siyasî ya Kurdan de."],
   gen:["Alîgirîya siyasî ya Kurdan", "Alîgirîya me"]),

  (id:"c1_638", ku:"Piranîya demokratîk", tr:"Demokratik çoğunluk", en:"Democratic majority",
   cins:"mê", ez:"piranîya demokratîk", kat:"siyaset", zor:0.60,
   not:"\"Piranî\"+\"demokratîk\". Seçim teorisi.",
   her:["Piranîya demokratîk.", "Di piranîya demokratîk de."],
   gen:["Piranîya demokratîk", "Piranîya me"]),

  (id:"c1_639", ku:"Rêvebirîya herêmî", tr:"Bölgesel yönetim", en:"Regional governance",
   cins:"mê", ez:"rêvebirîya herêmî", kat:"siyaset", zor:0.61,
   not:"\"Rêvebirî\"+\"herêmî\". Kürt özerk yönetim deneyimi.",
   her:["Rêvebirîya herêmî baş e.", "Di rêvebirîya herêmî de."],
   gen:["Rêvebirîya herêmî", "Rêvebirîya me"]),

  // ── MED YA — 5 ───────────────────────────────────────────────
  (id:"c1_640", ku:"Temaşevanên kurdî", tr:"Kürt izleyiciler", en:"Kurdish audience",
   cins:"bêcins", ez:"temaşevanên kurdî", kat:"medya", zor:0.60,
   not:"\"Temaşevan\"+\"kurdî\". Hedef kitle.",
   her:["Temaşevanên kurdî gelek in.", "Di temaşevanên kurdî de."],
   gen:["Temaşevanên kurdî", "Temaşevanên me"]),

  (id:"c1_641", ku:"Pêşkêşkirina zimanî ya serhêl", tr:"Çevrimiçi dil sunumu", en:"Online language presentation",
   cins:"mê", ez:"pêşkêşkirina zimanî ya serhêl", kat:"medya", zor:0.59,
   not:"\"Pêşkêşkirin\"+\"zimanî\"+\"serhêl\".",
   her:["Pêşkêşkirina zimanî ya serhêl.", "Di pêşkêşkirina zimanî ya serhêl de."],
   gen:["Pêşkêşkirina zimanî ya serhêl", "Pêşkêşkirina me"]),
];


final kC1_KalanGrup = [

  // ── ZIMAN — 15 ────────────────────────────────────────────────
  (id:"c1_700", ku:"Berdevkên zimanî", tr:"Dil temsilcileri", en:"Language representatives",
   cins:"bêcins", ez:"berdevkên zimanî", kat:"ziman", zor:0.58,
   not:"Kurum, topluluk ya da devlet adına konuşanlar.",
   her:["Berdevkên zimanî hatin.", "Di berdevkên zimanî de."],
   gen:["Berdevkên zimanî", "Berdevkên me"]),

  (id:"c1_701", ku:"Xweşbêjîya zimanî", tr:"Dil nezaketi", en:"Linguistic politeness",
   cins:"mê", ez:"xweşbêjîya zimanî", kat:"ziman", zor:0.58,
   not:"\"Xweşbêjî\"+\"zimanî\". Sosyal dil kullanımı.",
   her:["Xweşbêjîya zimanî lazim e.", "Di xweşbêjîya zimanî de."],
   gen:["Xweşbêjîya zimanî", "Xweşbêjîya me"]),

  (id:"c1_702", ku:"Zimanê nivîsêr", tr:"Yazarın dili", en:"Writer's language",
   cins:"nêr", ez:"zimanê nivîsêr", kat:"ziman", zor:0.59,
   not:"\"Ziman\"+\"nivîsêr\". Edebi stil.",
   her:["Zimanê nivîsêr xweş e.", "Di zimanê nivîsêr de."],
   gen:["Zimanê nivîsêr", "Zimanê me"]),

  (id:"c1_703", ku:"Zimanê zanistê yê kurdî", tr:"Kürtçe bilim dili", en:"Kurdish language of science",
   cins:"nêr", ez:"zimanê zanistê yê kurdî", kat:"ziman", zor:0.59,
   not:"\"Ziman\"+\"zanist\"+\"kurdî\". Terminoloji standardizasyonu.",
   her:["Zimanê zanistê yê kurdî pêşve diçe.", "Di zimanê zanistê yê kurdî de."],
   gen:["Zimanê zanistê yê kurdî", "Zimanê zanistê ya me"]),

  (id:"c1_704", ku:"Bikaranîna zimên a rojane", tr:"Günlük dil kullanımı", en:"Daily language use",
   cins:"mê", ez:"bikaranîna zimên a rojane", kat:"ziman", zor:0.60,
   not:"\"Bikaranîn\"+\"zimên\"+\"rojane\". Pratik dil becerisi.",
   her:["Bikaranîna zimên a rojane.", "Di bikaranîna zimên a rojane de."],
   gen:["Bikaranîna zimên a rojane", "Bikaranîna me"]),

  // ── EDEBİYAT — 10 ─────────────────────────────────────────────
  (id:"c1_705", ku:"Têkiliya nivîsê û xwendevan", tr:"Metin-okuyucu ilişkisi", en:"Text-reader relation",
   cins:"mê", ez:"têkiliya nivîsê û xwendevan", kat:"edebiyat", zor:0.58,
   not:"\"Têkilî\"+\"nivîs û xwendevan\". Reader-response theory.",
   her:["Têkiliya nivîsê û xwendevan.", "Di têkiliya nivîsê û xwendevan de."],
   gen:["Têkiliya nivîsê û xwendevan", "Têkiliya me"]),

  (id:"c1_706", ku:"Edebîyata li dijî şerê", tr:"Savaş karşıtı edebiyat", en:"Anti-war literature",
   cins:"mê", ez:"edebîyata li dijî şerê", kat:"edebiyat", zor:0.59,
   not:"\"Edebîyat\"+\"dijî şer\". Kürt edebiyatında güçlü tema.",
   her:["Edebîyata li dijî şerê.", "Di edebîyata li dijî şerê de."],
   gen:["Edebîyata li dijî şerê", "Edebîyata me"]),

  (id:"c1_707", ku:"Helbesta serdema nûjen", tr:"Modern dönem şiiri", en:"Modern era poetry",
   cins:"mê", ez:"helbesta serdema nûjen", kat:"edebiyat", zor:0.59,
   not:"\"Helbest\"+\"serdem\"+\"nûjen\". 20-21. yy. Kürt şiiri.",
   her:["Helbesta serdema nûjen.", "Di helbesta serdema nûjen de."],
   gen:["Helbesta serdema nûjen", "Helbesta me"]),

  // ── ABORÎ — 8 ─────────────────────────────────────────────────
  (id:"c1_708", ku:"Berdêla aborî", tr:"Ekonomik bedel", en:"Economic cost / trade-off",
   cins:"mê", ez:"berdêla aborî", kat:"aborî", zor:0.59,
   not:"\"Berdêl\"+\"aborî\". Fırsat maliyeti.",
   her:["Berdêla aborî mezin e.", "Di berdêla aborî de."],
   gen:["Berdêla aborî", "Berdêla me"]),

  (id:"c1_709", ku:"Weqfa pêşkeftinê", tr:"Kalkınma vakfı", en:"Development foundation",
   cins:"mê", ez:"weqfa pêşkeftinê", kat:"aborî", zor:0.59,
   not:"\"Weqf\"+\"pêşkeftin\". Sivil kalkınma kurumu.",
   her:["Weqfa pêşkeftinê heye.", "Di weqfa pêşkeftinê de."],
   gen:["Weqfa pêşkeftinê", "Weqfa me"]),

  (id:"c1_710", ku:"Rêvebirina çavkaniyan", tr:"Kaynak yönetimi", en:"Resource management",
   cins:"mê", ez:"rêvebirina çavkaniyan", kat:"aborî", zor:0.59,
   not:"\"Rêvebirin\"+\"çavkanî\".",
   her:["Rêvebirina çavkaniyan lazim e.", "Di rêvebirina çavkaniyan de."],
   gen:["Rêvebirina çavkaniyan", "Rêvebirina me"]),

  // ── HUNER — 8 ─────────────────────────────────────────────────
  (id:"c1_711", ku:"Dîmena kurdî ya sînemayê", tr:"Kürt sinema sahnesi", en:"Kurdish cinema scene",
   cins:"mê", ez:"dîmena kurdî ya sînemayê", kat:"huner", zor:0.60,
   not:"\"Dîmen\"+\"kurdî\"+\"sînema\". Kürt sineması, Yılmaz Güney vb.",
   her:["Dîmena kurdî ya sînemayê.", "Di dîmena kurdî ya sînemayê de."],
   gen:["Dîmena kurdî ya sînemayê", "Dîmena me"]),

  (id:"c1_712", ku:"Hunera nûjen a Kurdî", tr:"Çağdaş Kürt sanatı", en:"Contemporary Kurdish art",
   cins:"mê", ez:"hunera nûjen a Kurdî", kat:"huner", zor:0.60,
   not:"\"Huner\"+\"nûjen\"+\"Kurdî\". 21. yy sanatçıları.",
   her:["Hunera nûjen a Kurdî.", "Di hunera nûjen a Kurdî de."],
   gen:["Hunera nûjen a Kurdî", "Hunera me"]),

  // ── ZAGON — 8 ─────────────────────────────────────────────────
  (id:"c1_713", ku:"Şirovekirina hiqûqî", tr:"Hukuki yorum", en:"Legal interpretation",
   cins:"mê", ez:"şirovekirina hiqûqî", kat:"zagon", zor:0.59,
   not:"\"Şirovekirin\"+\"hiqûqî\". Hukuki metin yorumu.",
   her:["Şirovekirina hiqûqî baş e.", "Di şirovekirina hiqûqî de."],
   gen:["Şirovekirina hiqûqî", "Şirovekirina me"]),

  (id:"c1_714", ku:"Qanûna çandî ya navnetewî", tr:"Uluslararası kültür hukuku", en:"International cultural law",
   cins:"mê", ez:"qanûna çandî ya navnetewî", kat:"zagon", zor:0.59,
   not:"\"Qanûn\"+\"çandî\"+\"navnetewî\". UNESCO sözleşmeleri.",
   her:["Qanûna çandî ya navnetewî.", "Di qanûna çandî ya navnetewî de."],
   gen:["Qanûna çandî ya navnetewî", "Qanûna me"]),

  // ── GENEL — 14 ────────────────────────────────────────────────
  (id:"c1_715", ku:"Têkiliya teorî û pratîkê", tr:"Teori-pratik ilişkisi", en:"Theory-practice relation",
   cins:"mê", ez:"têkiliya teorî û pratîkê", kat:"akademik", zor:0.59,
   not:"\"Têkilî\"+\"teorî û pratîk\". Uygulamalı araştırma.",
   her:["Têkiliya teorî û pratîkê.", "Di têkiliya teorî û pratîkê de."],
   gen:["Têkiliya teorî û pratîkê", "Têkiliya me"]),

  (id:"c1_716", ku:"Nasnameya kolektîf a gel", tr:"Halkın kolektif kimliği", en:"Collective identity of the people",
   cins:"mê", ez:"nasnameya kolektîf a gel", kat:"kimlik", zor:0.60,
   not:"\"Nasname\"+\"kolektîf\"+\"gel\".",
   her:["Nasnameya kolektîf a gel.", "Di nasnameya kolektîf a gel de."],
   gen:["Nasnameya kolektîf a gel", "Nasnameya me"]),

  (id:"c1_717", ku:"Rapora mafan a salane", tr:"Yıllık insan hakları raporu", en:"Annual human rights report",
   cins:"mê", ez:"rapora mafan a salane", kat:"zagon", zor:0.60,
   not:"\"Rapor\"+\"maf\"+\"salane\". İnsan hakları belgeleme.",
   her:["Rapora mafan a salane hat.", "Di rapora mafan a salane de."],
   gen:["Rapora mafan a salane", "Rapora me"]),

  (id:"c1_718", ku:"Peymana aştiyê", tr:"Barış anlaşması", en:"Peace agreement",
   cins:"mê", ez:"peymana aştiyê", kat:"siyaset", zor:0.62,
   not:"\"Peymanam\"+\"aştî\". Kürt barış süreci bağlamı.",
   her:["Peymana aştiyê hat.", "Di peymana aştiyê de."],
   gen:["Peymana aştiyê", "Peymana me"]),

  (id:"c1_719", ku:"Dîplomasiya civakî", tr:"Sosyal diplomasi", en:"Social diplomacy",
   cins:"mê", ez:"dîplomasiya civakî", kat:"siyaset", zor:0.59,
   not:"\"Dîplomasî\"+\"civakî\". Kamu diplomasisi.",
   her:["Dîplomasiya civakî lazim e.", "Di dîplomasiya civakî de."],
   gen:["Dîplomasiya civakî", "Dîplomasiya me"]),

  (id:"c1_720", ku:"Ronakbîrê kurd", tr:"Kürt aydını", en:"Kurdish intellectual",
   cins:"bêcins", ez:"ronakbîrê kurd", kat:"civakî", zor:0.62,
   not:"\"Ronakbîr\"+\"kurd\". Kürt entelijansiyası.",
   her:["Ronakbîrê kurd hat.", "Ronakbîrên kurd."],
   gen:["Ronakbîrê kurd", "Ronakbîrên me"]),

  (id:"c1_721", ku:"Giştîtîya civakî", tr:"Toplumsal genellik", en:"Social generality",
   cins:"mê", ez:"giştîtîya civakî", kat:"civakî", zor:0.58,
   not:"\"Giştîtî\"+\"civakî\". Kolektif normlar.",
   her:["Giştîtîya civakî.", "Di giştîtîya civakî de."],
   gen:["Giştîtîya civakî", "Giştîtîya me"]),

  (id:"c1_722", ku:"Berfirehkirina hişmendiyê", tr:"Zihin genişlemesi", en:"Expanding consciousness",
   cins:"mê", ez:"berfirehkirina hişmendiyê", kat:"jiyan", zor:0.59,
   not:"\"Berfirehkirin\"+\"hişmendî\".",
   her:["Berfirehkirina hişmendiyê.", "Di berfirehkirina hişmendiyê de."],
   gen:["Berfirehkirina hişmendiyê", "Berfirehkirina me"]),

  (id:"c1_723", ku:"Keşkola çandî", tr:"Kültürel okul", en:"Cultural school",
   cins:"mê", ez:"keşkola çandî", kat:"çand", zor:0.59,
   not:"\"Keşkol\"+\"çandî\". Frankfurt Okulu gibi düşünce ekolleri.",
   her:["Keşkola çandî.", "Di keşkola çandî de."],
   gen:["Keşkola çandî", "Keşkola me"]),

  (id:"c1_724", ku:"Destana gelêrî ya kurd", tr:"Kürt halk destanı", en:"Kurdish folk epic",
   cins:"mê", ez:"destana gelêrî ya kurd", kat:"edebiyat", zor:0.61,
   not:"\"Destan\"+\"gelêrî\"+\"kurd\". Mem û Zîn, Mam Alan vb.",
   her:["Destana gelêrî ya kurd.", "Di destana gelêrî ya kurd de."],
   gen:["Destana gelêrî ya kurd", "Destanên me"]),

  (id:"c1_725", ku:"Veşartin û eşkerekirin di axaftinê", tr:"Konuşmada gizleme ve ifşa", en:"Concealment and disclosure in speech",
   cins:"bêcins", ez:null, kat:"ziman", zor:0.57,
   not:"\"Veşartin û eşkerekirin\". Söylem çözümlemesi.",
   her:["Veşartin û eşkerekirin di axaftinê.", "Di veşartin û eşkerekirin de."],
   gen:["Veşartin û eşkerekirin", "Zimanê me"]),
];


final kC1_Son49 = [
  (id:"c1_800", ku:"Mafê perwerdeyê bi zimanê xwe", tr:"Kendi dilinde eğitim hakkı", en:"Right to education in own language", cins:"nêr", ez:"mafê perwerdeyê bi zimanê xwe", kat:"zagon", zor:0.61, not:"[BM] madde 30 — azınlık hakları.", her:["Mafê perwerdeyê bi zimanê xwe.", "Ji bo mafê perwerdeyê bi zimanê xwe."], gen:["Mafê perwerdeyê bi zimanê xwe", "Mafên me"]),
  (id:"c1_801", ku:"Weqfa zimanê kurdî", tr:"Kürtçe dil vakfı", en:"Kurdish language foundation", cins:"mê", ez:"weqfa zimanê kurdî", kat:"ziman", zor:0.61, not:"\"Weqf\"+\"ziman\"+\"kurdî\". Dil koruma kurumu.", her:["Weqfa zimanê kurdî hat avakirin.", "Di weqfa zimanê kurdî de."], gen:["Weqfa zimanê kurdî", "Weqfa me"]),
  (id:"c1_802", ku:"Bernameya standardkirinê", tr:"Standardizasyon programı", en:"Standardization program", cins:"mê", ez:"bernameya standardkirinê", kat:"ziman", zor:0.59, not:"\"Bername\"+\"standardkirin\".", her:["Bernameya standardkirinê hat.", "Di bernameya standardkirinê de."], gen:["Bernameya standardkirinê", "Bernameya me"]),
  (id:"c1_803", ku:"Pêvajoya hevberdanê", tr:"Uzlaşma süreci", en:"Reconciliation process", cins:"mê", ez:"pêvajoya hevberdanê", kat:"siyaset", zor:0.60, not:"\"Pêvajo\"+\"hevberdan\". Barış ve uzlaşma.", her:["Pêvajoya hevberdanê.", "Di pêvajoya hevberdanê de."], gen:["Pêvajoya hevberdanê", "Pêvajoya me"]),
  (id:"c1_804", ku:"Têkiliya heval û dijmin", tr:"Dost-düşman ilişkisi", en:"Friend-enemy relation", cins:"mê", ez:"têkiliya heval û dijmin", kat:"siyaset", zor:0.59, not:"\"Têkilî\"+\"heval û dijmin\". Carl Schmitt bağlamı.", her:["Têkiliya heval û dijmin.", "Di têkiliya heval û dijmin de."], gen:["Têkiliya heval û dijmin", "Têkiliya me"]),
  (id:"c1_805", ku:"Pêwendîya aştiyane", tr:"Barışçıl ilişki", en:"Peaceful relation", cins:"mê", ez:"pêwendîya aştiyane", kat:"civakî", zor:0.61, not:"\"Pêwendî\"+\"aştiyane\".", her:["Pêwendîya aştiyane lazim e.", "Di pêwendîya aştiyane de."], gen:["Pêwendîya aştiyane", "Pêwendîya me"]),
  (id:"c1_806", ku:"Kêmanî û zêdebûn di zimên de", tr:"Dilde azalma ve çoğalma", en:"Decrease and increase in language", cins:"bêcins", ez:null, kat:"ziman", zor:0.58, not:"\"Kêmanî û zêdebûn\"+\"zimên\". Dil ekolojisi.", her:["Kêmanî û zêdebûn di zimên de.", "Di kêmanî û zêdebûna zimên de."], gen:["Kêmanî û zêdebûn", "Zimanê me"]),
  (id:"c1_807", ku:"Pirtûkên bingehîn ên kurdî", tr:"Kürtçe temel kitaplar", en:"Foundational Kurdish books", cins:"bêcins", ez:"pirtûkên bingehîn ên kurdî", kat:"edebiyat", zor:0.61, not:"\"Pirtûk\"+\"bingehîn\"+\"kurdî\". Kanon metinler.", her:["Pirtûkên bingehîn ên kurdî.", "Di pirtûkên bingehîn ên kurdî de."], gen:["Pirtûkên bingehîn ên kurdî", "Pirtûkên me"]),
  (id:"c1_808", ku:"Helwest li hemberî zimên", tr:"Dile karşı tutum", en:"Attitude toward language", cins:"mê", ez:"helwest li hemberî zimên", kat:"ziman", zor:0.59, not:"\"Helwest\"+\"li hemberî zimên\". Dil tutumu araştırması.", her:["Helwest li hemberî zimên.", "Di helwest li hemberî zimên de."], gen:["Helwest li hemberî zimên", "Helwesta me"]),
  (id:"c1_809", ku:"Xwecihî û biyanî di çandê de", tr:"Kültürde yerli ve yabancı", en:"Indigenous and foreign in culture", cins:"bêcins", ez:null, kat:"çand", zor:0.58, not:"\"Xwecihî û biyanî\"+\"çand\". Kültürel özgünlük.", her:["Xwecihî û biyanî di çandê de.", "Di xwecihî û biyanî de."], gen:["Xwecihî û biyanî", "Çanda me"]),
  (id:"c1_810", ku:"Tevahîbûna civakê", tr:"Toplumun bütünlüğü", en:"Social wholeness", cins:"mê", ez:"tevahîbûna civakê", kat:"civakî", zor:0.59, not:"\"Tevahîbûn\"+\"civak\". Sosyal cohesion.", her:["Tevahîbûna civakê.", "Di tevahîbûna civakê de."], gen:["Tevahîbûna civakê", "Tevahîbûna me"]),
  (id:"c1_811", ku:"Zanist û jiyana rojane", tr:"Bilim ve günlük yaşam", en:"Science and daily life", cins:"bêcins", ez:null, kat:"zanist", zor:0.61, not:"\"Zanist\"+\"jiyana rojane\". Bilimin gündelik etkisi.", her:["Zanist û jiyana rojane.", "Di navbera zanist û jiyana rojane de."], gen:["Zanist û jiyana rojane", "Zanista me"]),
  (id:"c1_812", ku:"Hiqûqa mafên gelêrî", tr:"Halk hakları hukuku", en:"People's rights law", cins:"mê", ez:"hiqûqa mafên gelêrî", kat:"zagon", zor:0.59, not:"\"Hiqûq\"+\"mafên gelêrî\".", her:["Hiqûqa mafên gelêrî.", "Di hiqûqa mafên gelêrî de."], gen:["Hiqûqa mafên gelêrî", "Hiqûqa me"]),
  (id:"c1_813", ku:"Têkoşîna ziman ji bo zindîbûnê", tr:"Dilin yaşatma mücadelesi", en:"Language survival struggle", cins:"mê", ez:"têkoşîna ziman ji bo zindîbûnê", kat:"ziman", zor:0.60, not:"\"Têkoşîn\"+\"ziman\"+\"zindîbûn\". Yok olma tehdidindeki diller.", her:["Têkoşîna ziman ji bo zindîbûnê.", "Di têkoşîna ziman ji bo zindîbûnê de."], gen:["Têkoşîna ziman ji bo zindîbûnê", "Têkoşîna me"]),
  (id:"c1_814", ku:"Xwendekarên rêberê xwe", tr:"Kendi yolunu bulan öğrenciler", en:"Self-directed learners", cins:"bêcins", ez:"xwendekarên rêberê xwe", kat:"perwerde", zor:0.59, not:"\"Xwendekar\"+\"rêberê xwe\". Özerk öğrenme.", her:["Xwendekarên rêberê xwe.", "Di xwendekarên rêberê xwe de."], gen:["Xwendekarên rêberê xwe", "Xwendekarên me"]),
  (id:"c1_815", ku:"Sazûmana rêvebiriya ziman", tr:"Dil yönetim kurumu", en:"Language management institution", cins:"mê", ez:"sazûmana rêvebiriya ziman", kat:"ziman", zor:0.59, not:"\"Sazûman\"+\"rêvebiri\"+\"ziman\". Kurumsal dil planlaması.", her:["Sazûmana rêvebiriya ziman.", "Di sazûmana rêvebiriya ziman de."], gen:["Sazûmana rêvebiriya ziman", "Sazûmana me"]),
  (id:"c1_816", ku:"Hestên tenêtiyê di diasporayê", tr:"Diasporada yalnızlık hisleri", en:"Feelings of loneliness in diaspora", cins:"bêcins", ez:"hestên tenêtiyê di diasporayê", kat:"jiyan", zor:0.59, not:"\"Hest\"+\"tenêtî\"+\"diaspora\". Sürgün deneyimi.", her:["Hestên tenêtiyê di diasporayê.", "Di hestên tenêtiyê de."], gen:["Hestên tenêtiyê di diasporayê", "Hestên me"]),
  (id:"c1_817", ku:"Dîtina xwe ya nû", tr:"Kendini yeniden keşfetme", en:"Rediscovering oneself", cins:"mê", ez:"dîtina xwe ya nû", kat:"jiyan", zor:0.60, not:"\"Dîtin\"+\"xwe ya nû\". Kişisel dönüşüm.", her:["Dîtina xwe ya nû.", "Di dîtina xwe ya nû de."], gen:["Dîtina xwe ya nû", "Dîtina me"]),
  (id:"c1_818", ku:"Wêjeya siyasî ya Kurdî", tr:"Kürt siyasi edebiyatı", en:"Kurdish political literature", cins:"mê", ez:"wêjeya siyasî ya Kurdî", kat:"edebiyat", zor:0.60, not:"\"Wêje\"+\"siyasî\"+\"Kurdî\". Siyasi şiir ve roman.", her:["Wêjeya siyasî ya Kurdî.", "Di wêjeya siyasî ya Kurdî de."], gen:["Wêjeya siyasî ya Kurdî", "Wêjeya me"]),
  (id:"c1_819", ku:"Pêvajoya demokrasiyê ya kurd", tr:"Kürt demokratikleşme süreci", en:"Kurdish democratization process", cins:"mê", ez:"pêvajoya demokrasiyê ya kurd", kat:"siyaset", zor:0.59, not:"\"Pêvajo\"+\"demokrasî\"+\"kurd\".", her:["Pêvajoya demokrasiyê ya kurd.", "Di pêvajoya demokrasiyê ya kurd de."], gen:["Pêvajoya demokrasiyê ya kurd", "Pêvajoya me"]),
];


final kC1_Bitis = [
  (id:"c1_900", ku:"Werger û xwezaya zimên", tr:"Çeviri ve dilin doğası", en:"Translation and language nature", cins:"bêcins", ez:null, kat:"ziman", zor:0.58, not:"\"Werger\"+\"xweza\"+\"zimên\". Çevirilemezlik meselesi.", her:["Werger û xwezaya zimên.","Di werger û xwezaya zimên de."], gen:["Werger û xwezaya zimên","Zimanê me"]),
  (id:"c1_901", ku:"Pêwendîya nav-çandî", tr:"Kültürlerarası ilişki", en:"Intercultural relation", cins:"mê", ez:"pêwendîya nav-çandî", kat:"çand", zor:0.60, not:"\"Pêwendî\"+\"nav-çandî\".", her:["Pêwendîya nav-çandî.","Di pêwendîya nav-çandî de."], gen:["Pêwendîya nav-çandî","Pêwendîya me"]),
  (id:"c1_902", ku:"Demên guherînê", tr:"Değişim dönemleri", en:"Periods of change", cins:"bêcins", ez:"demên guherînê", kat:"dîrok", zor:0.59, not:"\"Dem\"+\"guherîn\". Tarihsel kırılma noktaları.", her:["Demên guherînê.","Di demên guherînê de."], gen:["Demên guherînê","Demên me"]),
  (id:"c1_903", ku:"Têkiliya nav-nifşan", tr:"Nesiller arası ilişki", en:"Intergenerational relation", cins:"mê", ez:"têkiliya nav-nifşan", kat:"civakî", zor:0.59, not:"\"Têkilî\"+\"nav-nifşan\".", her:["Têkiliya nav-nifşan.","Di têkiliya nav-nifşan de."], gen:["Têkiliya nav-nifşan","Têkiliya me"]),
  (id:"c1_904", ku:"Bihêzkirina gel", tr:"Halkın güçlendirilmesi", en:"Empowerment of people", cins:"mê", ez:"bihêzkirina gel", kat:"civakî", zor:0.61, not:"\"Bihêzkirin\"+\"gel\". Güçlendirme / empowerment.", her:["Bihêzkirina gel lazim e.","Di bihêzkirina gel de."], gen:["Bihêzkirina gel","Bihêzkirina me"]),
  (id:"c1_905", ku:"Çanda pêşbaziyê", tr:"Rekabet kültürü", en:"Competitive culture", cins:"mê", ez:"çanda pêşbaziyê", kat:"çand", zor:0.59, not:"\"Çand\"+\"pêşbazî\". Eleştirel perspektif.", her:["Çanda pêşbaziyê.","Di çanda pêşbaziyê de."], gen:["Çanda pêşbaziyê","Çanda me"]),
  (id:"c1_906", ku:"Hevkarîya zanistî ya navnetewî", tr:"Uluslararası bilimsel işbirliği", en:"International scientific cooperation", cins:"mê", ez:"hevkarîya zanistî ya navnetewî", kat:"zanist", zor:0.59, not:"\"Hevkarî\"+\"zanistî\"+\"navnetewî\".", her:["Hevkarîya zanistî ya navnetewî.","Di hevkarîya zanistî ya navnetewî de."], gen:["Hevkarîya zanistî ya navnetewî","Hevkarîya me"]),
  (id:"c1_907", ku:"Destnîşankirina pirsgirêkê", tr:"Sorunun tanımlanması", en:"Problem identification", cins:"mê", ez:"destnîşankirina pirsgirêkê", kat:"akademik", zor:0.59, not:"\"Destnîşankirin\"+\"pirsgirêk\". Araştırma probleminin tespiti.", her:["Destnîşankirina pirsgirêkê.","Di destnîşankirina pirsgirêkê de."], gen:["Destnîşankirina pirsgirêkê","Destnîşankirina me"]),
  (id:"c1_908", ku:"Têgihîştina nav-disîplînî", tr:"Disiplinlerarası anlayış", en:"Interdisciplinary understanding", cins:"mê", ez:"têgihîştina nav-disîplînî", kat:"akademik", zor:0.58, not:"\"Têgihîştin\"+\"nav-disîplîn\".", her:["Têgihîştina nav-disîplînî.","Di têgihîştina nav-disîplînî de."], gen:["Têgihîştina nav-disîplînî","Têgihîştina me"]),
  (id:"c1_909", ku:"Hestê aidiyet", tr:"Aidiyet hissi", en:"Sense of belonging", cins:"nêr", ez:"hestê aidiyet", kat:"jiyan", zor:0.61, not:"\"Hest\"+\"aidiyet\". Kimlik ve yer hissi.", her:["Hestê aidiyet heye.","Di hestê aidiyet de."], gen:["Hestê aidiyet","Hestê me"]),
  (id:"c1_910", ku:"Peydakirina cihê jiyanê", tr:"Yaşam alanı bulma", en:"Finding a place in life", cins:"mê", ez:"peydakirina cihê jiyanê", kat:"jiyan", zor:0.60, not:"\"Peydakirin\"+\"cih\"+\"jiyan\". Yer arayışı.", her:["Peydakirina cihê jiyanê.","Di peydakirina cihê jiyanê de."], gen:["Peydakirina cihê jiyanê","Peydakirina me"]),
  (id:"c1_911", ku:"Naveroka civakî ya zimên", tr:"Dilin toplumsal içeriği", en:"Social content of language", cins:"mê", ez:"naveroka civakî ya zimên", kat:"ziman", zor:0.58, not:"\"Navero\"+\"civakî\"+\"zimên\". Sosyodilbilim.", her:["Naveroka civakî ya zimên.","Di naveroka civakî ya zimên de."], gen:["Naveroka civakî ya zimên","Naveroka me"]),
  (id:"c1_912", ku:"Çêkirina nasnameya kolektîf", tr:"Kolektif kimlik inşası", en:"Constructing collective identity", cins:"mê", ez:"çêkirina nasnameya kolektîf", kat:"kimlik", zor:0.59, not:"\"Çêkirin\"+\"nasname\"+\"kolektîf\".", her:["Çêkirina nasnameya kolektîf.","Di çêkirina nasnameya kolektîf de."], gen:["Çêkirina nasnameya kolektîf","Çêkirina me"]),
  (id:"c1_913", ku:"Vejîna ferhengê", tr:"Kültürün canlanması", en:"Cultural revival", cins:"mê", ez:"vejîna ferhengê", kat:"çand", zor:0.60, not:"\"Vejîn\"+\"ferheng\". Kültürel yeniden doğuş.", her:["Vejîna ferhengê.","Di vejîna ferhengê de."], gen:["Vejîna ferhengê","Vejîna me"]),
  (id:"c1_914", ku:"Nifşa pêşerojê", tr:"Gelecek nesil", en:"Future generation", cins:"mê", ez:"nifşa pêşerojê", kat:"jiyan", zor:0.61, not:"\"Nifş\"+\"pêşeroj\". Dil mirasının aktarımı.", her:["Nifşa pêşerojê.","Di nifşa pêşerojê de."], gen:["Nifşa pêşerojê","Nifşa me"]),
  (id:"c1_915", ku:"Têkilîya berî û piştî şerî", tr:"Savaş öncesi ve sonrası ilişkisi", en:"Pre and post-war relation", cins:"mê", ez:"têkilîya berî û piştî şerî", kat:"dîrok", zor:0.59, not:"\"Têkilî\"+\"berî û piştî şerî\".", her:["Têkilîya berî û piştî şerî.","Di têkilîya berî û piştî şerî de."], gen:["Têkilîya berî û piştî şerî","Têkilîya me"]),
  (id:"c1_916", ku:"Înkâra çandî ya dewletê", tr:"Devletin kültürel inkârı", en:"State's cultural denial", cins:"mê", ez:"înkâra çandî ya dewletê", kat:"siyaset", zor:0.60, not:"\"Înkâr\"+\"çandî\"+\"dewlet\". Kürt meselesinin özü.", her:["Înkâra çandî ya dewletê.","Di înkâra çandî ya dewletê de."], gen:["Înkâra çandî ya dewletê","Înkâra me"]),
  (id:"c1_917", ku:"Berxwedana kultural", tr:"Kültürel direniş", en:"Cultural resistance", cins:"mê", ez:"berxwedana kultural", kat:"çand", zor:0.61, not:"\"Berxwedan\"+\"kultural\". Sanat ve edebiyat yoluyla direniş.", her:["Berxwedana kultural.","Di berxwedana kultural de."], gen:["Berxwedana kultural","Berxwedana me"]),
  (id:"c1_918", ku:"Têbigihîştina zimanî", tr:"Dil farkındalığı", en:"Language awareness", cins:"mê", ez:"têbigihîştina zimanî", kat:"ziman", zor:0.59, not:"\"Têbigihîştin\"+\"zimanî\". Metalinguistik farkındalık.", her:["Têbigihîştina zimanî lazim e.","Di têbigihîştina zimanî de."], gen:["Têbigihîştina zimanî","Têbigihîştina me"]),
  (id:"c1_919", ku:"Rêbaza rexneyî", tr:"Eleştirel yöntem", en:"Critical method", cins:"mê", ez:"rêbaza rexneyî", kat:"akademik", zor:0.58, not:"\"Rêbaz\"+\"rexneyî\". Eleştirel düşünme metodolojisi.", her:["Rêbaza rexneyî.","Di rêbaza rexneyî de."], gen:["Rêbaza rexneyî","Rêbaza me"]),
];

final kC1_Tamam9 = [
  (id:"c1_950", ku:"Manaya veşartî ya metnan", tr:"Metinlerin gizli anlamı", en:"Hidden meaning of texts", cins:"mê", ez:"manaya veşartî ya metnan", kat:"edebiyat", zor:0.58, not:"\"Mana\"+\"veşartî\"+\"metn\". Latent içerik analizi.", her:["Manaya veşartî ya metnan.","Di manaya veşartî ya metnan de."], gen:["Manaya veşartî ya metnan","Manaya me"]),
  (id:"c1_951", ku:"Têkiliya xelk û desthilatê", tr:"Halk ve iktidar ilişkisi", en:"People-power relation", cins:"mê", ez:"têkiliya xelk û desthilatê", kat:"siyaset", zor:0.60, not:"\"Têkilî\"+\"xelk û desthilat\".", her:["Têkiliya xelk û desthilatê.","Di têkiliya xelk û desthilatê de."], gen:["Têkiliya xelk û desthilatê","Têkiliya me"]),
  (id:"c1_952", ku:"Girêdana zimanî ya nifşan", tr:"Nesillerin dilsel bağı", en:"Linguistic bond of generations", cins:"mê", ez:"girêdana zimanî ya nifşan", kat:"ziman", zor:0.59, not:"\"Girêdan\"+\"zimanî\"+\"nifşan\".", her:["Girêdana zimanî ya nifşan.","Di girêdana zimanî ya nifşan de."], gen:["Girêdana zimanî ya nifşan","Girêdana me"]),
  (id:"c1_953", ku:"Têbikolanê çandî", tr:"Kültürel anlamlandırma", en:"Cultural sense-making", cins:"nêr", ez:"têbikolanê çandî", kat:"çand", zor:0.57, not:"\"Têbikolan\"+\"çandî\". Anlam inşası.", her:["Têbikolanê çandî.","Di têbikolanê çandî de."], gen:["Têbikolanê çandî","Têbikolanê me"]),
  (id:"c1_954", ku:"Pêwendîya dîroka nivîskî û devkî", tr:"Yazılı ve sözlü tarih ilişkisi", en:"Written-oral history relation", cins:"mê", ez:"pêwendîya dîroka nivîskî û devkî", kat:"dîrok", zor:0.58, not:"\"Pêwendî\"+\"dîroka nivîskî û devkî\".", her:["Pêwendîya dîroka nivîskî û devkî.","Di pêwendîya dîroka nivîskî û devkî de."], gen:["Pêwendîya dîroka nivîskî û devkî","Pêwendîya me"]),
  (id:"c1_955", ku:"Desthilatdariya zanistî", tr:"Bilimsel otorite", en:"Scientific authority", cins:"mê", ez:"desthilatdariya zanistî", kat:"akademik", zor:0.58, not:"\"Desthilatdarî\"+\"zanistî\". Bilgi ve iktidar.", her:["Desthilatdariya zanistî.","Di desthilatdariya zanistî de."], gen:["Desthilatdariya zanistî","Desthilatdariya me"]),
  (id:"c1_956", ku:"Têgîhîştina çanda din", tr:"Başka kültürü anlama", en:"Understanding another culture", cins:"mê", ez:"têgîhîştina çanda din", kat:"çand", zor:0.59, not:"\"Têgîhîştin\"+\"çanda din\". Kültürel empati.", her:["Têgîhîştina çanda din.","Di têgîhîştina çanda din de."], gen:["Têgîhîştina çanda din","Têgîhîştina me"]),
  (id:"c1_957", ku:"Zimanê mirin û jiyanê", tr:"Ölüm ve yaşam dili", en:"Language of death and life", cins:"nêr", ez:"zimanê mirin û jiyanê", kat:"ziman", zor:0.58, not:"\"Ziman\"+\"mirin û jiyan\". Kürt edebiyatında varoluşsal dil.", her:["Zimanê mirin û jiyanê.","Di zimanê mirin û jiyanê de."], gen:["Zimanê mirin û jiyanê","Zimanê me"]),
  (id:"c1_958", ku:"Serkeftina çandî ya gelêrî", tr:"Halkın kültürel başarısı", en:"Cultural success of the people", cins:"mê", ez:"serkeftina çandî ya gelêrî", kat:"çand", zor:0.60, not:"\"Serkeftin\"+\"çandî\"+\"gelêrî\".", her:["Serkeftina çandî ya gelêrî.","Di serkeftina çandî ya gelêrî de."], gen:["Serkeftina çandî ya gelêrî","Serkeftina me"]),
];
final kC1Nihayi5 = [...kC1_Tamam9];

// TÜM kelimeler — vocabulary_browse_screen tarafından kullanılır
final kC1All = [...kC1Kelimeler, ...kC1_Genisleme, ...kC1_Buyuk, ...kC1_Buyuk2, ...kC1_Buyuk3, ...kC1_Buyuk_ext, ...kC1_Tamamlama, ...kC1_168, ...kC1_Son117, ...kC1_KalanGrup, ...kC1_Son49, ...kC1_Bitis, ...kC1_Tamam9];
