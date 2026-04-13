// ════════════════════════════════════════════════════════════════
// LÛTKE — C2 KELİME VERİTABANI
// Düzey: C2 (Ustalık / Sertî)
// Hedef: 300 kelime (ilk kısım)
// Odak: Akademik yetkinlik, edebi üretim, siyasi hitabet,
//        klasik Kurmancî üretimi, gazetecilik, çeviri
// ════════════════════════════════════════════════════════════════

import '../domain/lesson_entities.dart';

final kC2Kelimeler = [

  // ── EDEBI ÜRETİM — C2 ÖZGÜN ──────────────────────────────────

  (id:"c2_001", ku:"Arûz", tr:"Aruz vezni", en:"Aruz prosody",
   cins:"nêr", ez:"arûzê", kat:"edebiyat", zor:0.50,
   not:"Eril — Klasik Kürt şiirinin vezin sistemi. Farsça/Arapçadan alınmış. Xanî ve Mela arûz kullandı.",
   her:["Şiîra bi arûzê.", "Arûzê fêr bûm."],
   gen:["Arûz û hece", "Arûzê klasîk"]),

  (id:"c2_002", ku:"Qafiye", tr:"Kafiye / Uyak", en:"Rhyme",
   cins:"mê", ez:"qafiyê", kat:"edebiyat", zor:0.52,
   not:"Dişil — [BH]: qafiye n.f. Şiirde ses uyumu.",
   her:["Qafiyeya şiîrê.", "Bi qafiyeyê."],
   gen:["Qafiye û rîtm", "Qafiyeya şiîrê"]),

  (id:"c2_003", ku:"Heyam", tr:"Dönem / Çağ (şiirsel)", en:"Era (poetic)",
   cins:"nêr", ez:"heyamê", kat:"edebiyat", zor:0.50,
   not:"Eril — [BH]: heyam n.m. \"Heyamê zêrîn\" = altın çağ.",
   her:["Di heyamê de.", "Heyama zêrîn."],
   gen:["Heyam û serdem", "Heyamê zêrîn"]),

  (id:"c2_004", ku:"Meyxane", tr:"Meyhane (mecazi)", en:"Tavern (metaphorical)",
   cins:"mê", ez:"meyxanê", kat:"edebiyat", zor:0.49,
   not:"Dişil — Tasavvuf şiirinde: meyxane = ilahi aşkın mekanı.",
   her:["Li meyxaneyê ne.", "Meyxaneya evînê."],
   gen:["Meyxane û baxçe", "Meyxaneya Mela"]),

  (id:"c2_005", ku:"Şahbaz", tr:"Şahin / Asil kişi", en:"Falcon / Noble person",
   cins:"nêr", ez:"şahbazê", kat:"edebiyat", zor:0.48,
   not:"Eril — Klasik şiirde metafor: güçlü, asil kişi.",
   her:["Weke şahbazê.", "Şahbazê Kurdistan."],
   gen:["Şahbaz û bilbil", "Şahbazê me"]),

  (id:"c2_006", ku:"Destpêkirina şiîrê", tr:"Şiir başlangıcı", en:"Poem opening",
   cins:"mê", ez:"destpêkirina şiîrê", kat:"edebiyat", zor:0.50,
   not:"\"Matla\" karşılığı. Klasik şiirde ilk beyt.",
   her:["Destpêkirina şiîrê xweş e.", "Di destpêkirina şiîrê de."],
   gen:["Destpêkirina şiîrê", "Destpêkirin û encam"]),

  (id:"c2_007", ku:"Beyt", tr:"Beyit (şiir birimi)", en:"Couplet (verse unit)",
   cins:"nêr", ez:"beytê", kat:"edebiyat", zor:0.51,
   not:"Eril — [BH]: beyt n.m. [Arapça]. Klasik şiirde iki mısralık birim.",
   her:["Beytê xweş.", "Di beytê de."],
   gen:["Beyt û mısra", "Beytên Xanî"]),

  // ── AKADEMİK ARAŞTIRMA — C2 ──────────────────────────────────

  (id:"c2_010", ku:"Çarçoweya teorîkî", tr:"Teorik çerçeve", en:"Theoretical framework",
   cins:"mê", ez:"çarçoweya teorîkî", kat:"zanist", zor:0.50,
   not:"\"Çarçowe\" + \"teorîkî\". Akademik araştirma kavramı.",
   her:["Çarçoweya teorîkî ya lêkolînê.", "Di çarçoweya teorîkî de."],
   gen:["Çarçoweya teorîkî", "Çarçoweya me"]),

  (id:"c2_011", ku:"Rêbaza lêkolînê", tr:"Araştırma yöntemi", en:"Research methodology",
   cins:"mê", ez:"rêbaza lêkolînê", kat:"zanist", zor:0.51,
   not:"\"Rêbaz\" + \"lêkolînê\". C2 akademik dil.",
   her:["Rêbaza lêkolînê.", "Di rêbaza lêkolînê de."],
   gen:["Rêbaza lêkolînê", "Rêbaza me"]),

  (id:"c2_012", ku:"Hevçerxî", tr:"Yinelenebilirlik", en:"Reproducibility",
   cins:"mê", ez:"hevçerxiyê", kat:"zanist", zor:0.48,
   not:"Dişil — bilimsel yöntem ilkesi.",
   her:["Hevçerxî di lêkolînê de.", "Di hevçerxiyê de."],
   gen:["Hevçerxî û rast bûn", "Hevçerxîya zanistî"]),

  (id:"c2_013", ku:"Berhemên sereke", tr:"Birincil kaynaklar", en:"Primary sources",
   cins:"bêcins", ez:"berhemên sereke", kat:"zanist", zor:0.51,
   not:"\"Berhem\" + \"sereke\" (birincil).",
   her:["Berhemên sereke girîng in.", "Ji berhemên sereke ve."],
   gen:["Berhemên sereke û duyem", "Berhemên me"]),

  (id:"c2_014", ku:"Tabloya daneyê", tr:"Veri tablosu", en:"Data table",
   cins:"mê", ez:"tabloya daneyê", kat:"zanist", zor:0.50,
   not:"\"Tabloye\" + \"daneyê\" (verinin).",
   her:["Tabloya daneyê hat amade kirin.", "Di tabloya daneyê de."],
   gen:["Tabloya daneyê", "Tabloya me"]),

  // ── İLERİ SİYASİ SÖYLEM ─────────────────────────────────────

  (id:"c2_020", ku:"Jeopolîtîk", tr:"Jeopolitik", en:"Geopolitics",
   cins:"mê", ez:"jeopolîtîkê", kat:"siyaset", zor:0.50,
   not:"Dişil — \"Jeopolîtîka Rojhilata Navîn\" = Orta Doğu jeopolitiği.",
   her:["Jeopolîtîka Kurdistanê.", "Di jeopolîtîkê de."],
   gen:["Jeopolîtîk û dîplomasi", "Jeopolîtîka me"]),

  (id:"c2_021", ku:"Dîplomasi", tr:"Diplomasi", en:"Diplomacy",
   cins:"mê", ez:"dîplomasiyê", kat:"siyaset", zor:0.51,
   not:"Dişil — uluslararası terim.",
   her:["Dîplomasîya kurdî.", "Di dîplomasiyê de."],
   gen:["Dîplomasi û têkoşîn", "Dîplomasîya me"]),

  (id:"c2_022", ku:"Mîmarîya ewlehiyê", tr:"Güvenlik mimarisi", en:"Security architecture",
   cins:"mê", ez:"mîmarîya ewlehiyê", kat:"siyaset", zor:0.48,
   not:"\"Mîmarî\" + \"ewlehiyê\".",
   her:["Mîmarîya ewlehiyê ya Kurdistanê.", "Di mîmarîya ewlehiyê de."],
   gen:["Mîmarîya ewlehiyê", "Mîmarîya me"]),

  (id:"c2_023", ku:"Çareserkirin", tr:"Çözüme kavuşturmak", en:"To resolve",
   cins:"bêcins", ez:null, kat:"siyaset", zor:0.51,
   not:"\"Çareser kirin\" — geçişli.",
   her:["Pirsgirêk çareser kirin.", "Çareser bike."],
   gen:["Çareserkirin û danûstandin", "Çareser bike!"]),

  (id:"c2_024", ku:"Danûstandin", tr:"Müzakere", en:"Negotiation",
   cins:"mê", ez:"danûstandinê", kat:"siyaset", zor:0.52,
   not:"Dişil — \"dan\" + \"û\" + \"standin\".",
   her:["Danûstandin dest pê kir.", "Di danûstandinê de."],
   gen:["Danûstandin û cenga", "Danûstandina me"]),

  // ── ÇEVİRİ VE DİL AKTARIMI ──────────────────────────────────

  (id:"c2_030", ku:"Wergerandin wêjeyî", tr:"Edebi çeviri", en:"Literary translation",
   cins:"mê", ez:"wergerandina wêjeyî", kat:"ziman", zor:0.51,
   not:"\"Wergerandin\" + \"wêjeyî\".",
   her:["Wergerandina wêjeyî zehmet e.", "Di wergerandina wêjeyî de."],
   gen:["Wergerandina wêjeyî", "Wergerandina me"]),

  (id:"c2_031", ku:"Hevwate", tr:"Eş anlamlı", en:"Synonym",
   cins:"bêcins", ez:"hevwateyî", kat:"ziman", zor:0.53,
   not:"\"Hev\" + \"wate\". Özgün Kurmancî terim.",
   her:["Hevwateyên peyvê.", "Hevwate û dijwate."],
   gen:["Hevwate û dijwate", "Hevwateyên me"]),

  (id:"c2_032", ku:"Dijwate", tr:"Zıt anlamlı", en:"Antonym",
   cins:"bêcins", ez:"dijwateyî", kat:"ziman", zor:0.52,
   not:"\"Dij\" (karşı) + \"wate\".",
   her:["Dijwateyên peyvê.", "Hevwate û dijwate."],
   gen:["Dijwate û hevwate", "Dijwateyên me"]),

  (id:"c2_033", ku:"Navok", tr:"İçerik / Öz", en:"Content / Essence",
   cins:"nêr", ez:"navokê", kat:"ziman", zor:0.53,
   not:"Eril — \"nav\" + \"-ok\". [BH]: navok n.m.",
   her:["Navokê gotarê.", "Navoka metnê."],
   gen:["Navok û şêwe", "Navoka me"]),

  (id:"c2_034", ku:"Şêweya derbirînê", tr:"Anlatım biçimi", en:"Mode of expression",
   cins:"mê", ez:"şêweya derbirînê", kat:"ziman", zor:0.50,
   not:"\"Şêwe\" + \"derbirînê\".",
   her:["Şêweya derbirînê ya Xanî.", "Di şêweya derbirînê de."],
   gen:["Şêweya derbirînê", "Şêweya me"]),

  // ── KÜLTÜREL ELEŞTİRİ ────────────────────────────────────────

  (id:"c2_040", ku:"Paşkolonyalîzm", tr:"Postkolonyalizm", en:"Postcolonialism",
   cins:"nêr", ez:"paşkolonyalîzmê", kat:"felsefe", zor:0.49,
   not:"\"Paş\" (post) + \"kolonyalîzm\". \"Paş\" Kurmancî özgün önek.",
   her:["Paşkolonyalîzm û zimanê kurdî.", "Di paşkolonyalîzmê de."],
   gen:["Paşkolonyalîzm û xweserî", "Nêzîkatîya paşkolonyalîst"]),

  (id:"c2_041", ku:"Mijarên hevpar", tr:"Ortak temalar", en:"Common themes",
   cins:"bêcins", ez:"mijarên hevpar", kat:"edebiyat", zor:0.52,
   not:"\"Mijar\" (tema) + \"hevpar\".",
   her:["Mijarên hevpar ên wêjeya kurdî.", "Di mijarên hevpar de."],
   gen:["Mijarên hevpar", "Mijarên wêjeyî"]),

  (id:"c2_042", ku:"Wêjeya muqayeseyî", tr:"Karşılaştırmalı edebiyat", en:"Comparative literature",
   cins:"mê", ez:"wêjeya muqayeseyî", kat:"edebiyat", zor:0.49,
   not:"\"Wêje\" + \"muqayeseyî\" (karşılaştırmalı).",
   her:["Wêjeya muqayeseyî ya kurdî.", "Di wêjeya muqayeseyî de."],
   gen:["Wêjeya muqayeseyî", "Wêjeya me"]),

  (id:"c2_043", ku:"Îmgeya kurdî", tr:"Kürt imgesi", en:"Kurdish imagery",
   cins:"mê", ez:"îmgeya kurdî", kat:"edebiyat", zor:0.50,
   not:"\"Îmge\" (imge/görüntü) + \"kurdî\".",
   her:["Îmgeya kurdî di wêjeyê de.", "Di îmgeya kurdî de."],
   gen:["Îmgeya kurdî", "Îmgeya me"]),

  // ── İLERİ DİLBİLGİSİ ─────────────────────────────────────────

  (id:"c2_050", ku:"Guhêrbara vegotinê", tr:"Anlatı değişkeni", en:"Narrative variable",
   cins:"mê", ez:"guhêrbara vegotinê", kat:"rêziman", zor:0.48,
   not:"\"Guhêrbar\" (değişken) + \"vegotinê\". Dilbilim araştırmasında.",
   her:["Guhêrbara vegotinê.", "Di guhêrbara vegotinê de."],
   gen:["Guhêrbara vegotinê", "Guhêrbarên rêzimanî"]),

  (id:"c2_051", ku:"Demsazî", tr:"Zaman uyumu", en:"Temporal coherence",
   cins:"mê", ez:"demsaziyê", kat:"rêziman", zor:0.48,
   not:"Dişil — \"dem\" + \"-sazî\". Metin tutarlılığı.",
   her:["Demsazîya metnê.", "Di demsaziyê de."],
   gen:["Demsazî û girêdan", "Demsazîya kurdî"]),

  (id:"c2_052", ku:"Pirsên rêzimanî yên gengaz", tr:"Olası dilbilgisel sorular",
   en:"Possible grammatical questions",
   cins:"bêcins", ez:null, kat:"rêziman", zor:0.47,
   not:"C2 dilbilgisi analizi kavramı.",
   her:["Pirsên rêzimanî yên gengaz.", "Pirsên gengaz hene?"],
   gen:["Pirsên gengaz", "Pirsên rêzimanî"]),

  // ── C2 KONUŞMA VE YAZMA KALIPLARI ────────────────────────────

  (id:"c2_060", ku:"Bi awayekî pir zelal", tr:"Çok açık bir şekilde", en:"Very clearly",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.55,
   not:"\"Bi awayekî\" + \"pir zelal\". C2 düzeyi söylem.",
   her:["Bi awayekî pir zelal axivî.", "Bi awayekî zelal nivisand."],
   gen:["Bi awayekî pir zelal", "Zelal û kûr"]),

  (id:"c2_061", ku:"Ji perspektîfa", tr:"Perspektifinden", en:"From the perspective of",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.53,
   not:"\"Ji perspektîfa...\" akademik C2 kalıbı.",
   her:["Ji perspektîfa zimannasiyê.", "Ji perspektîfa mêjûnasiyê."],
   gen:["Ji perspektîfa...", "Ji perspektîfa kurdî"]),

  (id:"c2_062", ku:"Bi kûrbûnî", tr:"Derinlemesine", en:"In depth",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.54,
   not:"\"Bi kûrbûnî\" = derinlemesine.",
   her:["Bi kûrbûnî lêkolîn kirin.", "Bi kûrbûnî analîz kir."],
   gen:["Bi kûrbûnî û bi kurtasî", "Bi kûrbûnî"]),

  (id:"c2_063", ku:"Têgehê navdar", tr:"Anahtar kavram", en:"Key concept",
   cins:"nêr", ez:"têgehê navdar", kat:"zanist", zor:0.54,
   not:"\"Têgeh\" + \"navdar\".",
   her:["Têgehê navdar ê lêkolînê.", "Di têgehê navdar de."],
   gen:["Têgehê navdar", "Têgehên navdar"]),

  (id:"c2_064", ku:"Raman û pratîk", tr:"Teori ve pratik", en:"Theory and practice",
   cins:"bêcins", ez:null, kat:"zanist", zor:0.55,
   not:"\"Raman\" (düşünce/teori) + \"pratîk\". Özgün Kurmancî bileşim.",
   her:["Raman û pratîk divê hev temam bikin.", "Di raman û pratîk de."],
   gen:["Raman û pratîk", "Raman û jiyan"]),

  // ── KÜLTÜREL BELLEK VE MİRAS ─────────────────────────────────

  (id:"c2_070", ku:"Muîn bûna çandî", tr:"Kültürel muhatap olma", en:"Cultural encounter",
   cins:"mê", ez:"muîn bûna çandî", kat:"çand", zor:0.49,
   not:"\"Muîn bûn\" + \"çandî\".",
   her:["Muîn bûna çandî ya Kurdan.", "Di muîn bûna çandî de."],
   gen:["Muîn bûna çandî", "Muîn bûna me"]),

  (id:"c2_071", ku:"Mîrasa zindî", tr:"Yaşayan miras", en:"Living heritage",
   cins:"mê", ez:"mîrasa zindî", kat:"çand", zor:0.52,
   not:"\"Mîras\" + \"zindî\" (yaşayan).",
   her:["Dengbêjî mîrasa zindî ye.", "Di mîrasa zindî de."],
   gen:["Mîrasa zindî", "Mîrasa me"]),

  (id:"c2_072", ku:"Kaniya zanistê", tr:"Bilgi kaynağı", en:"Source of knowledge",
   cins:"mê", ez:"kaniya zanistê", kat:"zanist", zor:0.51,
   not:"\"Kanî\" (kaynak/pınar) + \"zanistê\". Özgün Kurmancî bileşim.",
   her:["Kaniya zanistê ya kurdî.", "Ji kaniya zanistê ve."],
   gen:["Kaniya zanistê", "Kaniya me"]),

  // ── C2 SON KELİMELER ─────────────────────────────────────────

  (id:"c2_080", ku:"Bêalîgirî", tr:"Tarafsızlık", en:"Impartiality",
   cins:"mê", ez:"bêalîgiriyê", kat:"felsefe", zor:0.53,
   not:"Dişil — \"bê\" + \"alîgirî\".",
   her:["Bêalîgirî lazim e.", "Bi bêalîgiriyê."],
   gen:["Bêalîgirî û alîgirî", "Bêalîgirîya me"]),

  (id:"c2_081", ku:"Peywira zanistî", tr:"Bilimsel sorumluluk", en:"Scientific responsibility",
   cins:"mê", ez:"peywira zanistî", kat:"zanist", zor:0.51,
   not:"\"Peywir\" + \"zanistî\".",
   her:["Peywira zanistî girîng e.", "Di peywira zanistî de."],
   gen:["Peywira zanistî", "Peywira me"]),

  (id:"c2_082", ku:"Pêşniyarên pêşerojê", tr:"Gelecek önerileri", en:"Future recommendations",
   cins:"bêcins", ez:"pêşniyarên pêşerojê", kat:"zanist", zor:0.52,
   not:"\"Pêşniyar\" + \"pêşerojê\" (geleceğin).",
   her:["Pêşniyarên pêşerojê.", "Di pêşniyarên pêşerojê de."],
   gen:["Pêşniyarên pêşerojê", "Pêşniyarên me"]),

  (id:"c2_083", ku:"Zagonên zimên", tr:"Dil yasaları", en:"Language laws",
   cins:"bêcins", ez:"zagonên zimên", kat:"ziman", zor:0.53,
   not:"\"Zagon\" + \"zimên\" (dilin). Dil politikası.",
   her:["Zagonên zimên divê bên guhartin.", "Di zagonên zimên de."],
   gen:["Zagonên zimên", "Zagonên me"]),

];


final kC2_Genisleme = [

  // ── ELEŞTİREL KURAM (30) ─────────────────────────────────────
  (id:"c2_100", ku:"Nêrîna paşkolonyalîst", tr:"Postkolonyal bakış", en:"Postcolonial view",
   cins:"mê", ez:"nêrîna paşkolonyalîst", kat:"felsefe", zor:0.48,
   not:"\"Nêrîn\" + \"paşkolonyalîst\".",
   her:["Nêrîna paşkolonyalîst.", "Ji nêrîna paşkolonyalîst ve."],
   gen:["Nêrîna paşkolonyalîst", "Nêrîna me"]),

  (id:"c2_101", ku:"Cihêrengîya çandî", tr:"Kültürel çeşitlilik", en:"Cultural diversity",
   cins:"mê", ez:"cihêrengîya çandî", kat:"çand", zor:0.50,
   not:"\"Cihêrengî\" + \"çandî\".",
   her:["Cihêrengîya çandî dewlemend e.", "Di cihêrengîya çandî de."],
   gen:["Cihêrengîya çandî", "Cihêrengîya me"]),

  (id:"c2_102", ku:"Têkilîya hêzê", tr:"Güç ilişkisi", en:"Power relation",
   cins:"mê", ez:"têkilîya hêzê", kat:"felsefe", zor:0.49,
   not:"\"Têkilî\" + \"hêzê\". Foucault'dan.",
   her:["Têkilîya hêzê.", "Di têkilîya hêzê de."],
   gen:["Têkilîya hêzê", "Têkilîya me"]),

  (id:"c2_103", ku:"Epistemolojîya kolonyal", tr:"Kolonyal epistemoloji", en:"Colonial epistemology",
   cins:"mê", ez:"epistemolojîya kolonyal", kat:"felsefe", zor:0.47,
   not:"\"Epistemolojî\" + \"kolonyal\".",
   her:["Epistemolojîya kolonyal.", "Di epistemolojîya kolonyal de."],
   gen:["Epistemolojîya kolonyal", "Epistemolojîya me"]),

  (id:"c2_104", ku:"Zanîna dêrxistî", tr:"Marjinalleştirilmiş bilgi", en:"Marginalized knowledge",
   cins:"mê", ez:"zanîna dêrxistî", kat:"felsefe", zor:0.47,
   not:"\"Zanîn\" + \"dêrxistî\" (kenara itilmiş).",
   her:["Zanîna dêrxistî ya kurdan.", "Di zanîna dêrxistî de."],
   gen:["Zanîna dêrxistî", "Zanîna me"]),

  // ── DİL PLANLAMASI DERİN (30) ────────────────────────────────
  (id:"c2_110", ku:"Standardên zimanî", tr:"Dil standartları", en:"Language standards",
   cins:"bêcins", ez:"standardên zimanî", kat:"ziman", zor:0.50,
   not:"\"Standard\" + \"zimanî\".",
   her:["Standardên zimanî hatine tayîn kirin.", "Di standardên zimanî de."],
   gen:["Standardên zimanî", "Standardên me"]),

  (id:"c2_111", ku:"Pevajoya normalizasyonê", tr:"Normalleştirme süreci", en:"Normalization process",
   cins:"mê", ez:"pevajoya normalizasyonê", kat:"ziman", zor:0.48,
   not:"\"Pevajo\" + \"normalizasyonê\".",
   her:["Pevajoya normalizasyonê.", "Di pevajoya normalizasyonê de."],
   gen:["Pevajoya normalizasyonê", "Pevajoya me"]),

  (id:"c2_112", ku:"Ziman û hêz", tr:"Dil ve güç", en:"Language and power",
   cins:"bêcins", ez:null, kat:"ziman", zor:0.50,
   not:"\"Ziman\" + \"hêz\". Siyasi dil teorisi.",
   her:["Ziman û hêz têkildar in.", "Di ziman û hêz de."],
   gen:["Ziman û hêz", "Ziman û hêza me"]),

  (id:"c2_113", ku:"Vejîna zimanî ya serkeftî", tr:"Başarılı dil canlanması", en:"Successful language revitalization",
   cins:"mê", ez:"vejîna zimanî ya serkeftî", kat:"ziman", zor:0.48,
   not:"\"Vejîna zimanî\" + \"serkeftî\".",
   her:["Vejîna zimanî ya serkeftî nimûne e.", "Di vejîna zimanî ya serkeftî de."],
   gen:["Vejîna zimanî ya serkeftî", "Vejîna zimanî ya me"]),

  (id:"c2_114", ku:"Têkilîya zimanê dê û zimanê nû", tr:"Ana dil ve yeni dil ilişkisi", en:"Relation of mother tongue and new language",
   cins:"mê", ez:"têkilîya zimanê dê û zimanê nû", kat:"ziman", zor:0.48,
   not:"Heritage dilbilim kavramı.",
   her:["Têkilîya zimanê dê û zimanê nû.", "Di têkilîya de."],
   gen:["Têkilîya zimanê dê û zimanê nû", "Têkilîya zimanî"]),

  // ── AKADEMİK ÜRETİM DERİN (30) ──────────────────────────────
  (id:"c2_120", ku:"Argumana bingehîn a gotarê", tr:"Makalenin temel argümanı", en:"Core argument of the article",
   cins:"mê", ez:"argumana bingehîn a gotarê", kat:"zanist", zor:0.49,
   not:"\"Arguman\" + \"bingehîn\" + \"gotarê\".",
   her:["Argumana bingehîn a gotarê.", "Di argumana bingehîn de."],
   gen:["Argumana bingehîn a gotarê", "Argumana me"]),

  (id:"c2_121", ku:"Rexneyên akademîk", tr:"Akademik eleştiriler", en:"Academic critiques",
   cins:"bêcins", ez:"rexneyên akademîk", kat:"zanist", zor:0.50,
   not:"\"Rexne\" + \"akademîk\".",
   her:["Rexneyên akademîk hatine kirin.", "Di rexneyên akademîk de."],
   gen:["Rexneyên akademîk", "Rexneyên me"]),

  (id:"c2_122", ku:"Têgehên nû di zanistê de", tr:"Bilimde yeni kavramlar", en:"New concepts in science",
   cins:"bêcins", ez:"têgehên nû di zanistê de", kat:"zanist", zor:0.49,
   not:"\"Têgeh\" + \"nû\" + \"zanistê\".",
   her:["Têgehên nû di zanistê de.", "Di têgehên nû de."],
   gen:["Têgehên nû di zanistê de", "Têgehên nû"]),

  (id:"c2_123", ku:"Çavdêrîya zanistî", tr:"Bilimsel gözlem", en:"Scientific observation",
   cins:"mê", ez:"çavdêrîya zanistî", kat:"zanist", zor:0.50,
   not:"\"Çavdêrî\" + \"zanistî\". Bilimsel yöntem.",
   her:["Çavdêrîya zanistî hat kirin.", "Di çavdêrîya zanistî de."],
   gen:["Çavdêrîya zanistî", "Çavdêrîya me"]),

  (id:"c2_124", ku:"Danûstandina zanistî", tr:"Bilimsel tartışma/diyalog", en:"Scientific dialogue",
   cins:"mê", ez:"danûstandina zanistî", kat:"zanist", zor:0.49,
   not:"\"Danûstandin\" + \"zanistî\".",
   her:["Danûstandina zanistî lazim e.", "Di danûstandina zanistî de."],
   gen:["Danûstandina zanistî", "Danûstandina me"]),

  // ── MEDYA VE HITABET DERİN (20) ──────────────────────────────
  (id:"c2_130", ku:"Stratejîya ragihandinê", tr:"İletişim stratejisi", en:"Communication strategy",
   cins:"mê", ez:"stratejîya ragihandinê", kat:"medya", zor:0.49,
   not:"\"Stratejî\" + \"ragihandinê\".",
   her:["Stratejîya ragihandinê.", "Di stratejîya ragihandinê de."],
   gen:["Stratejîya ragihandinê", "Stratejîya me"]),

  (id:"c2_131", ku:"Raya giştî", tr:"Kamuoyu", en:"Public opinion",
   cins:"mê", ez:"raya giştî", kat:"medya", zor:0.51,
   not:"\"Ray\" (görüş) + \"giştî\". Kamuoyu.",
   her:["Raya giştî guherîye.", "Di raya giştî de."],
   gen:["Raya giştî", "Raya me"]),

  (id:"c2_132", ku:"Zimanê fermî û xweserî", tr:"Resmi ve özgür dil", en:"Formal and autonomous language",
   cins:"bêcins", ez:null, kat:"ziman", zor:0.49,
   not:"\"Ziman\" + \"fermî\" + \"xweserî\".",
   her:["Zimanê fermî û xweserî.", "Di navbera fermî û xweserî de."],
   gen:["Zimanê fermî û xweserî", "Zimanê me"]),

  (id:"c2_133", ku:"Axaftina giştî ya serkeftî", tr:"Başarılı kamuoyu konuşması", en:"Successful public speech",
   cins:"mê", ez:"axaftina giştî ya serkeftî", kat:"medya", zor:0.48,
   not:"\"Axaftin\" + \"giştî\" + \"serkeftî\".",
   her:["Axaftina giştî ya serkeftî.", "Di axaftina giştî de."],
   gen:["Axaftina giştî ya serkeftî", "Axaftina me"]),

  (id:"c2_134", ku:"Pêşkêşîya profesyonel", tr:"Profesyonel sunum", en:"Professional presentation",
   cins:"mê", ez:"pêşkêşîya profesyonel", kat:"akademik", zor:0.50,
   not:"\"Pêşkêşî\" + \"profesyonel\".",
   her:["Pêşkêşîya profesyonel hat kirin.", "Di pêşkêşîya profesyonel de."],
   gen:["Pêşkêşîya profesyonel", "Pêşkêşîya me"]),
];



final kC2_Buyuk = [
  // ── ELEŞTİREL/AKADEMİK — 50 ──────────────────────────────────
  (id:"c2_200", ku:"Parêzvaniya zimanê", tr:"Dil savunuculuğu", en:"Language advocacy",
   cins:"mê", ez:"parêzvaniya zimanê", kat:"ziman", zor:0.48, not:"\"Parêzvanî\"+\"zimanê\".",
   her:["Parêzvaniya zimanê.","Di parêzvaniya zimanê de."], gen:["Parêzvaniya zimanê","Parêzvaniya me"]),
  (id:"c2_201", ku:"Çêkirina peyva nû", tr:"Yeni kelime oluşturma", en:"Neologism creation",
   cins:"mê", ez:"çêkirina peyva nû", kat:"ziman", zor:0.49, not:"\"Çêkirin\"+\"peyva nû\".",
   her:["Çêkirina peyva nû.","Di çêkirina peyva nû de."], gen:["Çêkirina peyva nû","Çêkirina me"]),
  (id:"c2_202", ku:"Zimanzanîya sazkirî", tr:"Yapısal dilbilim", en:"Structural linguistics",
   cins:"mê", ez:"zimanzanîya sazkirî", kat:"ziman", zor:0.47, not:"\"Zimanzanî\"+\"sazkirî\".",
   her:["Zimanzanîya sazkirî.","Di zimanzanîya sazkirî de."], gen:["Zimanzanîya sazkirî","Zimanzanîya me"]),
  (id:"c2_203", ku:"Teorîya wergerê", tr:"Çeviri teorisi", en:"Translation theory",
   cins:"mê", ez:"teorîya wergerê", kat:"ziman", zor:0.48, not:"\"Teorî\"+\"wergerê\".",
   her:["Teorîya wergerê.","Di teorîya wergerê de."], gen:["Teorîya wergerê","Teorîya me"]),
  (id:"c2_204", ku:"Analîza gotarê", tr:"Söylem analizi", en:"Discourse analysis",
   cins:"mê", ez:"analîza gotarê", kat:"ziman", zor:0.48, not:"\"Analîz\"+\"gotarê\".",
   her:["Analîza gotarê.","Di analîza gotarê de."], gen:["Analîza gotarê","Analîza me"]),
  (id:"c2_205", ku:"Berhevkirina mêtodolojîk", tr:"Metodolojik karşılaştırma", en:"Methodological comparison",
   cins:"mê", ez:"berhevkirina mêtodolojîk", kat:"zanist", zor:0.47, not:"\"Berhevkirin\"+\"mêtodolojîk\".",
   her:["Berhevkirina mêtodolojîk.","Di berhevkirina mêtodolojîk de."], gen:["Berhevkirina mêtodolojîk","Berhevkirina me"]),
  (id:"c2_206", ku:"Teorîya rêzimanê", tr:"Dilbilgisi teorisi", en:"Grammar theory",
   cins:"mê", ez:"teorîya rêzimanê", kat:"rêziman", zor:0.48, not:"\"Teorî\"+\"rêzimanê\".",
   her:["Teorîya rêzimanê.","Di teorîya rêzimanê de."], gen:["Teorîya rêzimanê","Teorîya me"]),
  (id:"c2_207", ku:"Navgihandina dîrokî", tr:"Tarihsel aktarım", en:"Historical transmission",
   cins:"mê", ez:"navgihandina dîrokî", kat:"çand", zor:0.47, not:"\"Navgihandin\"+\"dîrokî\".",
   her:["Navgihandina dîrokî.","Di navgihandina dîrokî de."], gen:["Navgihandina dîrokî","Navgihandina me"]),
  (id:"c2_208", ku:"Hêmanên nasnameya neteweyî", tr:"Ulusal kimlik öğeleri", en:"National identity elements",
   cins:"bêcins", ez:"hêmanên nasnameya neteweyî", kat:"kimlik", zor:0.48, not:"\"Hêman\"+\"nasname\"+\"neteweyî\".",
   her:["Hêmanên nasnameya neteweyî.","Di hêmanên nasnameya neteweyî de."], gen:["Hêmanên nasnameya neteweyî","Hêmanên me"]),
  (id:"c2_209", ku:"Pêwendîya ziman û nasnameya civakî", tr:"Dil ile sosyal kimlik ilişkisi", en:"Language and social identity relation",
   cins:"mê", ez:"pêwendîya ziman û nasnameya civakî", kat:"ziman", zor:0.47, not:"Sosyolinguistik kavram.",
   her:["Pêwendîya ziman û nasnameya civakî.","Di vê pêwendîyê de."], gen:["Pêwendîya ziman û nasnameya civakî","Pêwendîya me"]),

  // ── SIYASET/FELSEFE — 40 ─────────────────────────────────────
  (id:"c2_210", ku:"Teorîya dewletê", tr:"Devlet teorisi", en:"State theory",
   cins:"mê", ez:"teorîya dewletê", kat:"felsefe", zor:0.48, not:"\"Teorî\"+\"dewletê\".",
   her:["Teorîya dewletê.","Di teorîya dewletê de."], gen:["Teorîya dewletê","Teorîya me"]),
  (id:"c2_211", ku:"Felsefeya mafan", tr:"Haklar felsefesi", en:"Philosophy of rights",
   cins:"mê", ez:"felsefeya mafan", kat:"felsefe", zor:0.48, not:"\"Felsefe\"+\"mafan\".",
   her:["Felsefeya mafan.","Di felsefeya mafan de."], gen:["Felsefeya mafan","Felsefeya me"]),
  (id:"c2_212", ku:"Azadîya ramiyar", tr:"Düşünce özgürlüğü", en:"Freedom of thought",
   cins:"mê", ez:"azadîya ramiyar", kat:"felsefe", zor:0.49, not:"\"Azadî\"+\"ramiyar\" (düşünür).",
   her:["Azadîya ramiyar lazim e.","Di azadîya ramiyar de."], gen:["Azadîya ramiyar","Azadîya me"]),
  (id:"c2_213", ku:"Têkilîya hêz û zanistê ya Foucault", tr:"Foucault\'nun güç-bilgi ilişkisi", en:"Foucault\'s power-knowledge relation",
   cins:"mê", ez:"têkilîya hêz û zanistê ya Foucault", kat:"felsefe", zor:0.46, not:"Foucault kavramı C2.",
   her:["Têkilîya hêz û zanistê ya Foucault.","Di têkilîya hêz û zanistê de."], gen:["Têkilîya hêz û zanistê ya Foucault","Têkilîya me"]),
  (id:"c2_214", ku:"Felsefeya paşnûjen", tr:"Postmodern felsefe", en:"Postmodern philosophy",
   cins:"mê", ez:"felsefeya paşnûjen", kat:"felsefe", zor:0.47, not:"\"Felsefe\"+\"paşnûjen\".",
   her:["Felsefeya paşnûjen.","Di felsefeya paşnûjen de."], gen:["Felsefeya paşnûjen","Felsefeya me"]),
  (id:"c2_215", ku:"Navendparêzî û derveparêzî", tr:"Merkezcilik ve dışsalcılık", en:"Centralism and decentralism",
   cins:"bêcins", ez:null, kat:"siyaset", zor:0.47, not:"\"Navendparêzî\"+\"derveparêzî\".",
   her:["Navendparêzî û derveparêzî.","Di navbera navendparêzî û derveparêzî de."], gen:["Navendparêzî û derveparêzî","Navendparêzîya me"]),
  (id:"c2_216", ku:"Siyaseta çandî paşkolonyalîst", tr:"Postkolonyal kültür politikası", en:"Postcolonial cultural politics",
   cins:"mê", ez:"siyaseta çandî paşkolonyalîst", kat:"siyaset", zor:0.46, not:"\"Siyaset\"+\"çandî\"+\"paşkolonyalîst\".",
   her:["Siyaseta çandî paşkolonyalîst.","Di siyaseta çandî paşkolonyalîst de."], gen:["Siyaseta çandî paşkolonyalîst","Siyaseta me"]),
  (id:"c2_217", ku:"Xweserîya kulturî", tr:"Kültürel özgürlük", en:"Cultural sovereignty",
   cins:"mê", ez:"xweserîya kulturî", kat:"siyaset", zor:0.48, not:"\"Xweserî\"+\"kulturî\".",
   her:["Xweserîya kulturî.","Di xweserîya kulturî de."], gen:["Xweserîya kulturî","Xweserîya me"]),

  // ── EDEBİYAT — 30 ─────────────────────────────────────────────
  (id:"c2_218", ku:"Analîza şiîrê bi rêbaza C2", tr:"C2 yöntemiyle şiir analizi", en:"C2-level poetry analysis",
   cins:"mê", ez:"analîza şiîrê bi rêbaza C2", kat:"edebiyat", zor:0.47, not:"\"Analîza şiîrê\"+\"C2\".",
   her:["Analîza şiîrê bi rêbaza C2.","Di analîza şiîrê de."], gen:["Analîza şiîrê","Analîza me"]),
  (id:"c2_219", ku:"Nivîsandina afirîner", tr:"Yaratıcı yazarlık", en:"Creative writing",
   cins:"mê", ez:"nivîsandina afirîner", kat:"edebiyat", zor:0.49, not:"\"Nivîsandin\"+\"afirîner\".",
   her:["Nivîsandina afirîner.","Di nivîsandina afirîner de."], gen:["Nivîsandina afirîner","Nivîsandina me"]),
  (id:"c2_220", ku:"Helbesta azad", tr:"Serbest şiir", en:"Free verse poetry",
   cins:"mê", ez:"helbesta azad", kat:"edebiyat", zor:0.50, not:"\"Helbest\"+\"azad\".",
   her:["Helbesta azad ya kurdî.","Di helbesta azad de."], gen:["Helbesta azad","Helbestên kurdî"]),
  (id:"c2_221", ku:"Proza şiîrî", tr:"Şiirsel nesir", en:"Poetic prose",
   cins:"mê", ez:"proza şiîrî", kat:"edebiyat", zor:0.48, not:"\"Proz\"+\"şiîrî\".",
   her:["Proza şiîrî ya kurdî.","Di proza şiîrî de."], gen:["Proza şiîrî","Proza me"]),
  (id:"c2_222", ku:"Wergerandina bêkêmasî", tr:"Kusursuz çeviri", en:"Flawless translation",
   cins:"mê", ez:"wergerandina bêkêmasî", kat:"ziman", zor:0.48, not:"\"Wergerandin\"+\"bêkêmasî\".",
   her:["Wergerandina bêkêmasî.","Di wergerandina bêkêmasî de."], gen:["Wergerandina bêkêmasî","Wergerandina me"]),

  // ── MEDİYA/HİTABET — 20 ───────────────────────────────────────
  (id:"c2_223", ku:"Axaftina persuazîf", tr:"İkna edici konuşma", en:"Persuasive speech",
   cins:"mê", ez:"axaftina persuazîf", kat:"medya", zor:0.48, not:"\"Axaftin\"+\"persuazîf\".",
   her:["Axaftina persuazîf.","Di axaftina persuazîf de."], gen:["Axaftina persuazîf","Axaftina me"]),
  (id:"c2_224", ku:"Gotara siyasî ya kûr", tr:"Derin siyasi makale", en:"Deep political article",
   cins:"mê", ez:"gotara siyasî ya kûr", kat:"medya", zor:0.47, not:"\"Gotar\"+\"siyasî\"+\"kûr\".",
   her:["Gotara siyasî ya kûr.","Di gotara siyasî ya kûr de."], gen:["Gotara siyasî ya kûr","Gotara me"]),
  (id:"c2_225", ku:"Nûçeya lêkolînî ya kûr", tr:"Derin araştırmacı haber", en:"Deep investigative report",
   cins:"mê", ez:"nûçeya lêkolînî ya kûr", kat:"medya", zor:0.47, not:"\"Nûçe\"+\"lêkolînî\"+\"kûr\".",
   her:["Nûçeya lêkolînî ya kûr.","Di nûçeya lêkolînî ya kûr de."], gen:["Nûçeya lêkolînî ya kûr","Nûçeya me"]),
];



final kC2_Buyuk2 = [
  (id:"c2_300", ku:"Teorîya zimanê ya Chomsky", tr:"Chomsky dil teorisi", en:"Chomsky's language theory",
   cins:"mê", ez:"teorîya zimanê ya Chomsky", kat:"ziman", zor:0.46, not:"\"Teorîya zimanê ya Chomsky\".",
   her:["Teorîya zimanê ya Chomsky.","Di arûzê de."], gen:["Teorîya zimanê ya Chomsky","Konsêpta me"]),
  (id:"c2_301", ku:"Naveroka implicit", tr:"Örtük içerik", en:"Implicit content",
   cins:"mê", ez:"naveroka implicit", kat:"ziman", zor:0.47, not:"\"Naveroka implicit\".",
   her:["Naveroka implicit.","Di naveroka implicit de dixebitin."], gen:["Naveroka implicit","Konsêpta me"]),
  (id:"c2_302", ku:"Gotara siyasî ya dekolonyal", tr:"Dekolonyal siyasi söylem", en:"Decolonial political discourse",
   cins:"mê", ez:"gotara siyasî ya dekolonyal", kat:"siyaset", zor:0.45, not:"\"Gotara siyasî ya dekolonyal\".",
   her:["Gotara siyasî ya dekolonyal.","Di gotara siyasî ya dekolonyal de dixebitin."], gen:["Gotara siyasî ya dekolonyal","Konsêpta me"]),
  (id:"c2_303", ku:"Nêrîna interseksiyonel", tr:"Kesişimsel bakış", en:"Intersectional view",
   cins:"mê", ez:"nêrîna interseksiyonel", kat:"felsefe", zor:0.45, not:"\"Nêrîna interseksiyonel\".",
   her:["Nêrîna interseksiyonel.","Di nêrîna interseksiyonel de dixebitin."], gen:["Nêrîna interseksiyonel","Konsêpta me"]),
  (id:"c2_304", ku:"Felsefeya exlaqê", tr:"Ahlak felsefesi", en:"Ethics / Moral philosophy",
   cins:"mê", ez:"felsefeya exlaqê", kat:"felsefe", zor:0.47, not:"\"Felsefeya exlaqê\".",
   her:["Felsefeya exlaqê.","Di felsefeya exlaqê de dixebitin."], gen:["Felsefeya exlaqê","Konsêpta me"]),
  (id:"c2_305", ku:"Têkilîya hêz û zayendê", tr:"Güç ve cinsiyet ilişkisi", en:"Power-gender relation",
   cins:"mê", ez:"têkilîya hêz û zayendê", kat:"felsefe", zor:0.46, not:"\"Têkilîya hêz û zayendê\".",
   her:["Têkilîya hêz û zayendê.","Di mijara arûz de dixebitin."], gen:["Têkilîya hêz û zayendê","Konsêpta me"]),
  (id:"c2_306", ku:"Zimanê akademîk ya kûr", tr:"Derin akademik dil", en:"Deep academic language",
   cins:"nêr", ez:"zimanê akademîk ya kûr", kat:"ziman", zor:0.47, not:"\"Zimanê akademîk ya kûr\".",
   her:["Zimanê akademîk ya kûr.","Di zimanê akademîk ya kûr de xebat heye."], gen:["Zimanê akademîk ya kûr","Konsêpta me"]),
  (id:"c2_307", ku:"Rêzimana kûr ya Kurmancî", tr:"Derin Kurmancî dilbilgisi", en:"Deep Kurmancî grammar",
   cins:"mê", ez:"rêzimana kûr ya Kurmancî", kat:"rêziman", zor:0.47, not:"\"Rêzimana kûr ya Kurmancî\".",
   her:["Rêzimana kûr ya Kurmancî.","Di rêzimana kûr ya kurmancî de xebat heye."], gen:["Rêzimana kûr ya Kurmancî","Konsêpta me"]),
  (id:"c2_308", ku:"Şêweyê cixarek", tr:"Sigar biçimi / Belagat figürü", en:"Figure of speech",
   cins:"nêr", ez:"şêweyê cixarek", kat:"ziman", zor:0.47, not:"\"Şêweyê cixarek\".",
   her:["Şêweyê cixarek.","Di şêweyê cixarek de."], gen:["Şêweyê cixarek","Konsêpta me"]),
  (id:"c2_309", ku:"Cixareka edebî", tr:"Edebi figür", en:"Literary figure",
   cins:"mê", ez:"cixareka edebî", kat:"edebiyat", zor:0.47, not:"\"Cixareka edebî\".",
   her:["Cixareka edebî.","Di cixareka edebî de."], gen:["Cixareka edebî","Konsêpta me"]),
  (id:"c2_310", ku:"Zimanê siyasî ya kûr", tr:"Derin siyasi dil", en:"Deep political language",
   cins:"nêr", ez:"zimanê siyasî ya kûr", kat:"siyaset", zor:0.47, not:"\"Zimanê siyasî ya kûr\".",
   her:["Zimanê siyasî ya kûr.","Di zimanê siyasî ya kûr de xebat heye."], gen:["Zimanê siyasî ya kûr","Konsêpta me"]),
  (id:"c2_311", ku:"Civaka paşkolonyal", tr:"Postkolonyal toplum", en:"Postcolonial society",
   cins:"mê", ez:"civaka paşkolonyal", kat:"felsefe", zor:0.46, not:"\"Civaka paşkolonyal\".",
   her:["Civaka paşkolonyal.","Di civaka paşkolonyal de."], gen:["Civaka paşkolonyal","Konsêpta me"]),
  (id:"c2_312", ku:"Pêkanîna nasnameyê", tr:"Kimlik inşası", en:"Identity construction",
   cins:"mê", ez:"pêkanîna nasnameyê", kat:"kimlik", zor:0.47, not:"\"Pêkanîna nasnameyê\".",
   her:["Pêkanîna nasnameyê.","Di pêkanîna nasnameyê de ne."], gen:["Pêkanîna nasnameyê","Konsêpta me"]),
  (id:"c2_313", ku:"Çanda bêdengî", tr:"Sessizlik kültürü", en:"Culture of silence",
   cins:"mê", ez:"çanda bêdengî", kat:"çand", zor:0.47, not:"\"Çanda bêdengî\".",
   her:["Çanda bêdengî.","Di çanda bêdengî de ne."], gen:["Çanda bêdengî","Konsêpta me"]),
  (id:"c2_314", ku:"Gotara paşkolonyal", tr:"Postkolonyal söylem", en:"Postcolonial discourse",
   cins:"mê", ez:"gotara paşkolonyal", kat:"felsefe", zor:0.46, not:"\"Gotara paşkolonyal\".",
   her:["Gotara paşkolonyal.","Di gotara paşkolonyal de."], gen:["Gotara paşkolonyal","Konsêpta me"]),
  (id:"c2_315", ku:"Teorîya çandî ya Stuart Hall", tr:"Stuart Hall kültür teorisi", en:"Stuart Hall's cultural theory",
   cins:"mê", ez:"teorîya çandî ya Stuart Hall", kat:"felsefe", zor:0.45, not:"\"Teorîya çandî ya Stuart Hall\".",
   her:["Teorîya çandî ya Stuart Hall.","Di teorîya çandî ya Stuart Hall de ne."], gen:["Teorîya çandî ya Stuart Hall","Konsêpta me"]),
  (id:"c2_316", ku:"Pêngava wêjeyî", tr:"Edebi hamle", en:"Literary move",
   cins:"mê", ez:"pêngava wêjeyî", kat:"edebiyat", zor:0.47, not:"\"Pêngava wêjeyî\".",
   her:["Pêngava wêjeyî.","Di pêngava wêjeyî de."], gen:["Pêngava wêjeyî","Konsêpta me"]),
  (id:"c2_317", ku:"Pêwendîya nivîskar û xwendevan", tr:"Yazar-okuyucu ilişkisi", en:"Author-reader relation",
   cins:"mê", ez:"pêwendîya nivîskar û xwendevan", kat:"edebiyat", zor:0.47, not:"\"Pêwendîya nivîskar û xwendevan\".",
   her:["Pêwendîya nivîskar û xwendevan.","Di pêwendîya nivîskar û xwendevan de dixebitin."], gen:["Pêwendîya nivîskar û xwendevan","Konsêpta me"]),
  (id:"c2_318", ku:"Naveroka veşartî", tr:"Gizli içerik", en:"Hidden content",
   cins:"mê", ez:"naveroka veşartî", kat:"edebiyat", zor:0.47, not:"\"Naveroka veşartî\".",
   her:["Naveroka veşartî.","Di naveroka veşartî de."], gen:["Naveroka veşartî","Konsêpta me"]),
  (id:"c2_319", ku:"Tonal û sembolik", tr:"Tonsal ve simgesel", en:"Tonal and symbolic",
   cins:"bêcins", ez:"-", kat:"edebiyat", zor:0.47, not:"\"Tonal û sembolik\".",
   her:["Tonal û sembolik.","Di tonal û sembolik de."], gen:["Tonal û sembolik","Konsêpta me"]),
  (id:"c2_320", ku:"Helbesteke paşnûjen", tr:"Postmodern bir şiir", en:"A postmodern poem",
   cins:"mê", ez:"helbesteke paşnûjen", kat:"edebiyat", zor:0.47, not:"\"Helbesteke paşnûjen\".",
   her:["Helbesteke paşnûjen.","Di helbesteke paşnûjen de."], gen:["Helbesteke paşnûjen","Konsêpta me"]),
  (id:"c2_321", ku:"Naveroka çandî ya kûr", tr:"Derin kültürel içerik", en:"Deep cultural content",
   cins:"mê", ez:"naveroka çandî ya kûr", kat:"çand", zor:0.47, not:"\"Naveroka çandî ya kûr\".",
   her:["Naveroka çandî ya kûr.","Di naveroka çandî ya kûr de ne."], gen:["Naveroka çandî ya kûr","Konsêpta me"]),
  (id:"c2_322", ku:"Şaredariya zimanî", tr:"Dilsel düzenleme", en:"Linguistic regulation",
   cins:"mê", ez:"şaredariya zimanî", kat:"ziman", zor:0.46, not:"\"Şaredariya zimanî\".",
   her:["Şaredariya zimanî.","Di şaredariya zimanî de xebat heye."], gen:["Şaredariya zimanî","Konsêpta me"]),
  (id:"c2_323", ku:"Pêvajoya standartkirinê", tr:"Standardizasyon süreci", en:"Standardization process",
   cins:"mê", ez:"pêvajoya standartkirinê", kat:"ziman", zor:0.47, not:"\"Pêvajoya standartkirinê\".",
   her:["Pêvajoya standartkirinê.","Di pêvajoya standartkirinê de."], gen:["Pêvajoya standartkirinê","Konsêpta me"]),
  (id:"c2_324", ku:"Çêkirina termînolojiya kurdî", tr:"Kürtçe terminoloji oluşturma", en:"Creating Kurdish terminology",
   cins:"mê", ez:"çêkirina termînolojiya kurdî", kat:"ziman", zor:0.46, not:"\"Çêkirina termînolojiya kurdî\".",
   her:["Çêkirina termînolojiya kurdî.","Di çêkirina termînolojiya kurdî de ne."], gen:["Çêkirina termînolojiya kurdî","Konsêpta me"]),
  (id:"c2_325", ku:"Normativa daxistî", tr:"İniş normativi", en:"Prescriptive norm",
   cins:"mê", ez:"normativa daxistî", kat:"rêziman", zor:0.46, not:"\"Normativa daxistî\".",
   her:["Normativa daxistî di rêzimanê de.","Di normativa daxistî de kar dikin."], gen:["Normativa daxistî","Konsêpta me"]),
  (id:"c2_326", ku:"Zimanzanîya sosyolojîk", tr:"Sosyolojik dilbilim", en:"Sociological linguistics",
   cins:"mê", ez:"zimanzanîya sosyolojîk", kat:"ziman", zor:0.46, not:"\"Zimanzanîya sosyolojîk\".",
   her:["Zimanzanîya sosyolojîk.","Di normativa daxistî de."], gen:["Zimanzanîya sosyolojîk","Konsêpta me"]),
  (id:"c2_327", ku:"Zimanzanîya rewşenbîrî", tr:"Entelektüel dilbilim", en:"Intellectual linguistics",
   cins:"mê", ez:"zimanzanîya rewşenbîrî", kat:"ziman", zor:0.46, not:"\"Zimanzanîya rewşenbîrî\".",
   her:["Zimanzanîya rewşenbîrî.","Di zimanzanîya rewşenbîrî de xebat heye."], gen:["Zimanzanîya rewşenbîrî","Konsêpta me"]),
  (id:"c2_328", ku:"Xweşnivîsîna akademîk", tr:"Akademik güzel yazarlık", en:"Academic eloquence",
   cins:"mê", ez:"xweşnivîsîna akademîk", kat:"zanist", zor:0.46, not:"\"Xweşnivîsîna akademîk\".",
   her:["Xweşnivîsîna akademîk.","Di xweşnivîsîna akademîk de."], gen:["Xweşnivîsîna akademîk","Konsêpta me"]),
  (id:"c2_329", ku:"Gotara pêşniyarî", tr:"Öneri söylemi", en:"Prescriptive discourse",
   cins:"mê", ez:"gotara pêşniyarî", kat:"zanist", zor:0.46, not:"\"Gotara pêşniyarî\".",
   her:["Gotara pêşniyarî.","Di gotara pêşniyarî de."], gen:["Gotara pêşniyarî","Konsêpta me"]),
];


final kC2_Buyuk_ext = [

  // ── ELEŞTİREL DİL TEORİSİ (40) ───────────────────────────────

  (id:"c2_200", ku:"Teorîya zimanî ya Saussure", tr:"Saussure'ün dil teorisi", en:"Saussure's language theory", cins:"mê", ez:"teorîya zimanî ya Saussure", kat:"ziman", zor:0.47, not:"\"Ferdinand de Saussure\" = modern dilbilimin kurucusu. Gösterge teorisi.", her:["Teorîya zimanî ya Saussure.", "Di teorîya zimanî ya Saussure de."], gen:["Teorîya zimanî ya Saussure","Teorîya me"]),
  (id:"c2_201", ku:"Nîşane û nîşanker", tr:"Gösteren ve gösterilen", en:"Signifier and signified", cins:"bêcins", ez:null, kat:"ziman", zor:0.47, not:"\"Nîşane\" (gösterilen) + \"nîşanker\" (gösteren). Saussure terminolojisi.", her:["Nîşane û nîşanker.", "Di navbera nîşane û nîşanker de."], gen:["Nîşane û nîşanker","Nîşaneyên me"]),
  (id:"c2_202", ku:"Zimanê wek pergal", tr:"Sistem olarak dil", en:"Language as system", cins:"bêcins", ez:null, kat:"ziman", zor:0.47, not:"\"Ziman wek pergal\" = yapısalcı dil anlayışı.", her:["Zimanê wek pergal.", "Di zimanê wek pergal de."], gen:["Zimanê wek pergal","Zimanê me"]),
  (id:"c2_203", ku:"Performatîvîteya zimên", tr:"Dilin performatifliği", en:"Performativity of language", cins:"mê", ez:"performatîvîteya zimên", kat:"ziman", zor:0.46, not:"\"Performatîvîte\" = J.L. Austin. Dil eylem olarak.", her:["Performatîvîteya zimên.", "Di performatîvîteya zimên de."], gen:["Performatîvîteya zimên","Performatîvîteya me"]),
  (id:"c2_204", ku:"Têkilîya ziman û hêzê", tr:"Dil-güç ilişkisi", en:"Language-power relation", cins:"mê", ez:"têkilîya ziman û hêzê", kat:"ziman", zor:0.47, not:"Foucault: dil güç üretir. Temel postmodern önerme.", her:["Têkilîya ziman û hêzê.", "Di têkilîya ziman û hêzê de."], gen:["Têkilîya ziman û hêzê","Têkilîya me"]),
  (id:"c2_205", ku:"Ziman û siyaseta nasname", tr:"Dil ve kimlik siyaseti", en:"Language and identity politics", cins:"bêcins", ez:null, kat:"ziman", zor:0.47, not:"\"Ziman\"+\"siyaseta nasname\". Dil siyaseti.", her:["Ziman û siyaseta nasname.", "Di ziman û siyaseta nasname de."], gen:["Ziman û siyaseta nasname","Zimanê me"]),
  (id:"c2_206", ku:"Metakomunîkasyon", tr:"Üst iletişim", en:"Meta-communication", cins:"mê", ez:"metakomunîkasyonê", kat:"ziman", zor:0.46, not:"\"Meta\" + \"komunîkasyon\". İletişim hakkında iletişim.", her:["Metakomunîkasyon dibe.", "Di metakomunîkasyonê de."], gen:["Metakomunîkasyon","Metakomunîkasyona me"]),
  (id:"c2_207", ku:"Yekalîbûna zimanî", tr:"Dil standardizasyonu", en:"Language standardization", cins:"mê", ez:"yekalîbûna zimanî", kat:"ziman", zor:0.47, not:"\"Yekalîbûn\"+\"zimanî\". Standardizasyon süreci.", her:["Yekalîbûna zimanî.", "Di yekalîbûna zimanî de."], gen:["Yekalîbûna zimanî","Yekalîbûna me"]),
  (id:"c2_208", ku:"Nûpeyvên kurdî", tr:"Yeni Kürtçe kelimeler", en:"New Kurdish words", cins:"bêcins", ez:"nûpeyvên kurdî", kat:"ziman", zor:0.48, not:"\"Nûpeyv\" = neolojizm. Kürtçe kelime türetme.", her:["Nûpeyvên kurdî saz kirin.", "Di nûpeyvên kurdî de."], gen:["Nûpeyvên kurdî","Nûpeyvên me"]),
  (id:"c2_209", ku:"Pêvajoya standardkirinê ya nûjen", tr:"Modern standardizasyon süreci", en:"Modern standardization process", cins:"mê", ez:"pêvajoya standardkirinê ya nûjen", kat:"ziman", zor:0.46, not:"\"Pêvajo\"+\"standardkirin\"+\"nûjen\".", her:["Pêvajoya standardkirinê ya nûjen.", "Di pêvajoya standardkirinê ya nûjen de."], gen:["Pêvajoya standardkirinê ya nûjen","Pêvajoya me"]),

  // ── AKADEMİK ÜRETİM VE SUNUM (30) ────────────────────────────

  (id:"c2_210", ku:"Gotareke pêzanistî", tr:"Bilimsel makale yazımı", en:"Writing a scientific article", cins:"mê", ez:"gotareke pêzanistî", kat:"akademik", zor:0.47, not:"\"Gotar\"+\"pêzanistî\". Akademik yazım.", her:["Gotareke pêzanistî nivîsand.", "Di gotareke pêzanistî de."], gen:["Gotareke pêzanistî","Gotarên me"]),
  (id:"c2_211", ku:"Argumana akademîk ya serkeftî", tr:"Başarılı akademik argüman", en:"Successful academic argument", cins:"mê", ez:"argumana akademîk ya serkeftî", kat:"akademik", zor:0.46, not:"\"Arguman\"+\"akademîk\"+\"serkeftî\".", her:["Argumana akademîk ya serkeftî.", "Di argumana akademîk de."], gen:["Argumana akademîk ya serkeftî","Argumana me"]),
  (id:"c2_212", ku:"Debata zanistî", tr:"Bilimsel tartışma", en:"Scientific debate", cins:"mê", ez:"debata zanistî", kat:"akademik", zor:0.48, not:"\"Debat\"+\"zanistî\".", her:["Debata zanistî hat.", "Di debata zanistî de."], gen:["Debata zanistî","Debata me"]),
  (id:"c2_213", ku:"Pêxistina têgehên nû", tr:"Yeni kavramlar önerme", en:"Proposing new concepts", cins:"mê", ez:"pêxistina têgehên nû", kat:"akademik", zor:0.46, not:"\"Pêxistin\"+\"têgeh\"+\"nû\".", her:["Pêxistina têgehên nû.", "Di pêxistina têgehên nû de."], gen:["Pêxistina têgehên nû","Pêxistina me"]),
  (id:"c2_214", ku:"Serhilana akademîk", tr:"Akademik itiraz", en:"Academic challenge", cins:"mê", ez:"serhilana akademîk", kat:"akademik", zor:0.47, not:"\"Serhilan\"+\"akademîk\".", her:["Serhilana akademîk hat.", "Di serhilana akademîk de."], gen:["Serhilana akademîk","Serhilana me"]),

  // ── ELEŞTİREL KURAM DERİN (40) ────────────────────────────────

  (id:"c2_215", ku:"Derûnnasiya Kürtî", tr:"Kürt psikolojisi", en:"Kurdish psychology", cins:"mê", ez:"derûnnasiya Kürtî", kat:"felsefe", zor:0.47, not:"\"Derûnnasî\"+\"Kürtî\". Kolektif travma ve kimlik.", her:["Derûnnasiya Kürtî.", "Di derûnnasiya Kürtî de."], gen:["Derûnnasiya Kürtî","Derûnnasiya me"]),
  (id:"c2_216", ku:"Travmaya kolektîf", tr:"Kolektif travma", en:"Collective trauma", cins:"mê", ez:"travmaya kolektîf", kat:"psikoloji", zor:0.48, not:"\"Travma\"+\"kolektîf\". Kürt tarihsel travması.", her:["Travmaya kolektîf.", "Di travmaya kolektîf de."], gen:["Travmaya kolektîf","Travmaya me"]),
  (id:"c2_217", ku:"Zordarîya çandî", tr:"Kültürel baskı", en:"Cultural oppression", cins:"mê", ez:"zordarîya çandî", kat:"felsefe", zor:0.48, not:"\"Zordarî\"+\"çandî\". Kültürel hegemonya eleştirisi.", her:["Zordarîya çandî.", "Di zordarîya çandî de."], gen:["Zordarîya çandî","Zordarîya me"]),
  (id:"c2_218", ku:"Dekonstiruksiyona nasnameya kolonyal", tr:"Sömürge kimliğinin dekonstruksiyonu", en:"Deconstruction of colonial identity", cins:"mê", ez:"dekonstiruksiyona nasnameya kolonyal", kat:"felsefe", zor:0.45, not:"\"Dekonstrüksiyona\" + \"nasnameya kolonyal\". Derrida/Spivak.", her:["Dekonstiruksiyona nasnameya kolonyal.", "Di dekonstiruksiyona nasnameya kolonyal de."], gen:["Dekonstiruksiyona nasnameya kolonyal","Dekonstiruksiyon"]),
  (id:"c2_219", ku:"Hêmana paşkolonyalîst", tr:"Postkolonyal unsur", en:"Postcolonial element", cins:"mê", ez:"hêmana paşkolonyalîst", kat:"felsefe", zor:0.46, not:"\"Hêman\"+\"paşkolonyalîst\".", her:["Hêmana paşkolonyalîst.", "Di hêmana paşkolonyalîst de."], gen:["Hêmana paşkolonyalîst","Hêmanên me"]),
  (id:"c2_220", ku:"Têkilîya navend û deverê", tr:"Merkez ve çevre ilişkisi", en:"Center-periphery relation", cins:"mê", ez:"têkilîya navend û deverê", kat:"felsefe", zor:0.47, not:"\"Têkilî\"+\"navend û dever\". Dünya sistemi teorisi.", her:["Têkilîya navend û deverê.", "Di têkilîya navend û deverê de."], gen:["Têkilîya navend û deverê","Têkilîya me"]),
  (id:"c2_221", ku:"Zanista bêdestpêk", tr:"Disiplinlerarası bilim", en:"Interdisciplinary science", cins:"mê", ez:"zanista bêdestpêk", kat:"zanist", zor:0.47, not:"\"Zanist\"+\"bêdestpêk\". Sınır aşan araştırma.", her:["Zanista bêdestpêk.", "Di zanista bêdestpêk de."], gen:["Zanista bêdestpêk","Zanista me"]),
  (id:"c2_222", ku:"Metodolojîya mîkso", tr:"Karma metodoloji", en:"Mixed methodology", cins:"mê", ez:"metodolojîya mîkso", kat:"akademik", zor:0.47, not:"\"Metodolojî\"+\"mîkso\". Nitel+nicel birleşimi.", her:["Metodolojîya mîkso.", "Di metodolojîya mîkso de."], gen:["Metodolojîya mîkso","Metodolojîya me"]),

  // ── DİL ÜRETME VE KÜLTÜR (30) ─────────────────────────────────

  (id:"c2_223", ku:"Helbestên azad yên Kürtî", tr:"Kürtçe serbest nazım", en:"Kurdish free verse", cins:"bêcins", ez:"helbestên azad yên Kürtî", kat:"edebiyat", zor:0.48, not:"\"Helbesta azad\" = serbest nazım. Modern Kürt şiiri.", her:["Helbestên azad yên Kürtî.", "Di helbestên azad yên Kürtî de."], gen:["Helbestên azad yên Kürtî","Helbestên me"]),
  (id:"c2_224", ku:"Naveroka têgehî ya helbesta", tr:"Şiirin kavramsal içeriği", en:"Conceptual content of poetry", cins:"mê", ez:"naveroka têgehî ya helbesta", kat:"edebiyat", zor:0.47, not:"\"Navero\"+\"têgehî\"+\"helbest\".", her:["Naveroka têgehî ya helbesta.", "Di naveroka têgehî de."], gen:["Naveroka têgehî ya helbesta","Naveroka me"]),
  (id:"c2_225", ku:"Çêkirina têgehên nû yên kurdî", tr:"Yeni Kürtçe kavramlar yaratma", en:"Creating new Kurdish concepts", cins:"mê", ez:"çêkirina têgehên nû yên kurdî", kat:"ziman", zor:0.47, not:"\"Çêkirin\"+\"têgeh\"+\"nû\"+\"kurdî\".", her:["Çêkirina têgehên nû yên kurdî.", "Di çêkirina têgehên nû de."], gen:["Çêkirina têgehên nû yên kurdî","Çêkirina me"]),
  (id:"c2_226", ku:"Wergera edebî ya kûr", tr:"Derin edebi çeviri", en:"Deep literary translation", cins:"mê", ez:"wergera edebî ya kûr", kat:"edebiyat", zor:0.47, not:"\"Werger\"+\"edebî\"+\"kûr\".", her:["Wergera edebî ya kûr.", "Di wergera edebî ya kûr de."], gen:["Wergera edebî ya kûr","Wergera me"]),
  (id:"c2_227", ku:"Pêşengiya wêjeyî", tr:"Edebi öncülük", en:"Literary leadership", cins:"mê", ez:"pêşengiya wêjeyî", kat:"edebiyat", zor:0.47, not:"\"Pêşengî\"+\"wêjeyî\".", her:["Pêşengiya wêjeyî.", "Di pêşengiya wêjeyî de."], gen:["Pêşengiya wêjeyî","Pêşengiya me"]),
  (id:"c2_228", ku:"Wêje û civakê re têkildar", tr:"Edebiyatın toplumla ilişkisi", en:"Literature's relation with society", cins:"bêcins", ez:null, kat:"edebiyat", zor:0.47, not:"\"Wêje\"+\"civak\". Sosyal eleştiri.", her:["Wêje û civakê re têkildar.", "Di wêje û civakê re têkildar de."], gen:["Wêje û civakê re têkildar","Wêjeya me"]),

  // ── JEOPOLİTİK VE ULUSLARARASI (30) ──────────────────────────

  (id:"c2_229", ku:"Jeopolîtîka Kurdan", tr:"Kürtlerin jeopolitiği", en:"Geopolitics of Kurds", cins:"mê", ez:"jeopolîtîka Kurdan", kat:"siyaset", zor:0.48, not:"\"Jeopolîtîk\"+\"Kurdan\". Kürt jeopolitiği.", her:["Jeopolîtîka Kurdan.", "Di jeopolîtîka Kurdan de."], gen:["Jeopolîtîka Kurdan","Jeopolîtîka me"]),
  (id:"c2_230", ku:"Têkilîyên navdewletî ya Kurdan", tr:"Kürtlerin uluslararası ilişkileri", en:"International relations of Kurds", cins:"bêcins", ez:"têkilîyên navdewletî ya Kurdan", kat:"siyaset", zor:0.47, not:"\"Têkilî\"+\"navdewletî\"+\"Kurdan\".", her:["Têkilîyên navdewletî ya Kurdan.", "Di têkilîyên navdewletî ya Kurdan de."], gen:["Têkilîyên navdewletî ya Kurdan","Têkilîyên me"]),
  (id:"c2_231", ku:"Stratejîya siyasî ya kurd", tr:"Kürt siyasi stratejisi", en:"Kurdish political strategy", cins:"mê", ez:"stratejîya siyasî ya kurd", kat:"siyaset", zor:0.48, not:"\"Stratejî\"+\"siyasî\"+\"kurd\".", her:["Stratejîya siyasî ya kurd.", "Di stratejîya siyasî ya kurd de."], gen:["Stratejîya siyasî ya kurd","Stratejîya me"]),
  (id:"c2_232", ku:"Fedratîvîteya Kurdistanê", tr:"Kürdistanın federatifliği", en:"Federalism of Kurdistan", cins:"mê", ez:"fedratîvîteya Kurdistanê", kat:"siyaset", zor:0.47, not:"\"Fedratîvîte\"+\"Kurdistanê\". Siyasi model.", her:["Fedratîvîteya Kurdistanê.", "Di fedratîvîteya Kurdistanê de."], gen:["Fedratîvîteya Kurdistanê","Fedratîvîteya me"]),
  (id:"c2_233", ku:"Siyaseta herêmî ya Xawermiyan", tr:"Orta Doğu bölgesel siyaseti", en:"Middle East regional politics", cins:"mê", ez:"siyaseta herêmî ya Xawermiyan", kat:"siyaset", zor:0.47, not:"\"Siyaset\"+\"herêmî\"+\"Xawermiya\".", her:["Siyaseta herêmî ya Xawermiyan.", "Di siyaseta herêmî de."], gen:["Siyaseta herêmî ya Xawermiyan","Siyaseta me"]),

  // ── HITABET VE SUNUM (20) ─────────────────────────────────────

  (id:"c2_234", ku:"Hîtabeta siyasî ya serkeftî", tr:"Başarılı siyasi hitabet", en:"Successful political oratory", cins:"mê", ez:"hîtabeta siyasî ya serkeftî", kat:"akademik", zor:0.47, not:"\"Hîtabet\"+\"siyasî\"+\"serkeftî\".", her:["Hîtabeta siyasî ya serkeftî.", "Di hîtabeta siyasî ya serkeftî de."], gen:["Hîtabeta siyasî ya serkeftî","Hîtabeta me"]),
  (id:"c2_235", ku:"Axaftina li pêşiya girseyê", tr:"Kitleye konuşma", en:"Speaking to a crowd", cins:"mê", ez:"axaftina li pêşiya girseyê", kat:"akademik", zor:0.48, not:"\"Axaftin\"+\"li pêşiya girseyê\".", her:["Axaftina li pêşiya girseyê.", "Di axaftina li pêşiya girseyê de."], gen:["Axaftina li pêşiya girseyê","Axaftina me"]),
  (id:"c2_236", ku:"Rêbazên metinperêziyê", tr:"Metin yorum yöntemleri", en:"Methods of textual interpretation", cins:"bêcins", ez:"rêbazên metinperêziyê", kat:"edebiyat", zor:0.46, not:"\"Rêbaz\"+\"metinperêzî\".", her:["Rêbazên metinperêziyê hene.", "Di rêbazên metinperêziyê de."], gen:["Rêbazên metinperêziyê","Rêbazên me"]),
  (id:"c2_237", ku:"Danûstandina navçandî", tr:"Kültürlerarası diyalog", en:"Intercultural dialogue", cins:"mê", ez:"danûstandina navçandî", kat:"çand", zor:0.47, not:"\"Danûstandin\"+\"navçandî\".", her:["Danûstandina navçandî lazim e.", "Di danûstandina navçandî de."], gen:["Danûstandina navçandî","Danûstandina me"]),
  (id:"c2_238", ku:"Pêkanîna reformê", tr:"Reform gerçekleştirme", en:"Implementing reform", cins:"mê", ez:"pêkanîna reformê", kat:"siyaset", zor:0.48, not:"\"Pêkanîn\"+\"reform\".", her:["Pêkanîna reformê lazim e.", "Di pêkanîna reformê de."], gen:["Pêkanîna reformê","Pêkanîna me"]),
];


final kC2_Tamamlama = [

  // ── ELEŞTİREL KURAM VE EDEBİYAT (40) ─────────────────────────

  (id:"c2_300", ku:"Teorîya girtêkxistina zimên", tr:"Dil hapsetme teorisi", en:"Language imprisonment theory",
   cins:"mê", ez:"teorîya girtêkxistina zimên", kat:"ziman", zor:0.45,
   not:"Sömürge dilbilimi: kolonyal güç dilleri hapseder.",
   her:["Teorîya girtêkxistina zimên.", "Di teorîya girtêkxistina zimên de."],
   gen:["Teorîya girtêkxistina zimên", "Teorîya me"]),

  (id:"c2_301", ku:"Helbestên dijberî", tr:"Karşı şiirler", en:"Counter poetry",
   cins:"bêcins", ez:"helbestên dijberî", kat:"edebiyat", zor:0.47,
   not:"\"Helbest\"+\"dijberî\". Direniş edebiyatı.",
   her:["Helbestên dijberî hatin nivîsandin.", "Di helbestên dijberî de."],
   gen:["Helbestên dijberî", "Helbestên me"]),

  (id:"c2_302", ku:"Naveroka îdeolojîk ya metnê", tr:"Metnin ideolojik içeriği", en:"Ideological content of text",
   cins:"mê", ez:"naveroka îdeolojîk ya metnê", kat:"edebiyat", zor:0.45,
   not:"\"Navero\"+\"îdeolojîk\"+\"metn\". Eleştirel metin çözümlemesi.",
   her:["Naveroka îdeolojîk ya metnê.", "Di naveroka îdeolojîk de."],
   gen:["Naveroka îdeolojîk ya metnê", "Naveroka me"]),

  (id:"c2_303", ku:"Têkilîya niviskar û civakê", tr:"Yazar ve toplum ilişkisi", en:"Author-society relation",
   cins:"mê", ez:"têkilîya niviskar û civakê", kat:"edebiyat", zor:0.46,
   not:"\"Têkilî\"+\"niviskar û civak\".",
   her:["Têkilîya niviskar û civakê.", "Di têkilîya niviskar û civakê de."],
   gen:["Têkilîya niviskar û civakê", "Têkilîya me"]),

  (id:"c2_304", ku:"Wêjeya bergirî", tr:"Engelleme edebiyatı", en:"Literature of resistance",
   cins:"mê", ez:"wêjeya bergirî", kat:"edebiyat", zor:0.46,
   not:"\"Wêje\"+\"bergirî\". Kürt sürgün edebiyatı.",
   her:["Wêjeya bergirî ya kurdî.", "Di wêjeya bergirî de."],
   gen:["Wêjeya bergirî", "Wêjeya me"]),

  (id:"c2_305", ku:"Zanistiya wêjeyî ya nûjen", tr:"Modern edebiyat bilimi", en:"Modern literary science",
   cins:"mê", ez:"zanistiya wêjeyî ya nûjen", kat:"edebiyat", zor:0.46,
   not:"\"Zanistî\"+\"wêjeyî\"+\"nûjen\". Çağdaş eleştiri teorileri.",
   her:["Zanistiya wêjeyî ya nûjen.", "Di zanistiya wêjeyî ya nûjen de."],
   gen:["Zanistiya wêjeyî ya nûjen", "Zanistiya me"]),

  (id:"c2_306", ku:"Metaforên rizgariyê di wêjeyê", tr:"Edebiyatta özgürleşme metaforları", en:"Liberation metaphors in literature",
   cins:"bêcins", ez:"metaforên rizgariyê di wêjeyê", kat:"edebiyat", zor:0.45,
   not:"\"Metafor\"+\"rizgarî\"+\"wêje\".",
   her:["Metaforên rizgariyê di wêjeyê.", "Di metaforên rizgariyê de."],
   gen:["Metaforên rizgariyê di wêjeyê", "Metaforên me"]),

  // ── KİMLİK VE KÜLTÜR DERİN (30) ──────────────────────────────

  (id:"c2_307", ku:"Perçebûna nasnameya birêkûpêk", tr:"Parçalanmış kimliği yeniden kurma", en:"Reconstructing fragmented identity",
   cins:"mê", ez:"perçebûna nasnameya birêkûpêk", kat:"kimlik", zor:0.45,
   not:"\"Perçebûn\"+\"nasname\"+\"birêkûpêk\". Diaspora kimlik inşası.",
   her:["Perçebûna nasnameya birêkûpêk.", "Di perçebûna nasnameya birêkûpêk de."],
   gen:["Perçebûna nasnameya birêkûpêk", "Nasnameya me"]),

  (id:"c2_308", ku:"Hybridîteya çandî", tr:"Kültürel melez kimlik", en:"Cultural hybridity",
   cins:"mê", ez:"hybridîteya çandî", kat:"kimlik", zor:0.45,
   not:"\"Hybridîte\"+\"çandî\". Homi K. Bhabha kavramı. Diaspora bağlamı.",
   her:["Hybridîteya çandî.", "Di hybridîteya çandî de."],
   gen:["Hybridîteya çandî", "Hybridîteya me"]),

  (id:"c2_309", ku:"Nasnameya serhêl ya kurdî", tr:"Kürt çevrimiçi kimliği", en:"Kurdish online identity",
   cins:"mê", ez:"nasnameya serhêl ya kurdî", kat:"kimlik", zor:0.46,
   not:"\"Nasname\"+\"serhêl\"+\"kurdî\". Dijital kimlik.",
   her:["Nasnameya serhêl ya kurdî.", "Di nasnameya serhêl ya kurdî de."],
   gen:["Nasnameya serhêl ya kurdî", "Nasnameya me"]),

  (id:"c2_310", ku:"Tejbûna çandî", tr:"Kültürel asimilasyon süreci", en:"Cultural assimilation process",
   cins:"mê", ez:"tejbûna çandî", kat:"kimlik", zor:0.46,
   not:"\"Tejbûn\"+\"çandî\". Eritme politikası etkisi.",
   her:["Tejbûna çandî.", "Di tejbûna çandî de."],
   gen:["Tejbûna çandî", "Tejbûna me"]),

  (id:"c2_311", ku:"Vegerandina zimanê winda", tr:"Kayıp dilin geri kazanılması", en:"Reclaiming a lost language",
   cins:"mê", ez:"vegerandina zimanê winda", kat:"kimlik", zor:0.46,
   not:"\"Vegerandin\"+\"zimên winda\". Heritage öğreniminin özü.",
   her:["Vegerandina zimanê winda.", "Di vegerandina zimanê winda de."],
   gen:["Vegerandina zimanê winda", "Vegerandina me"]),

  // ── FELSEFİ DERINLEME (25) ────────────────────────────────────

  (id:"c2_312", ku:"Ontolojîya zimanî", tr:"Dilsel ontoloji", en:"Linguistic ontology",
   cins:"mê", ez:"ontolojîya zimanî", kat:"felsefe", zor:0.44,
   not:"\"Ontolojî\"+\"zimanî\". Heidegger: \"Dil varlığın evidir\".",
   her:["Ontolojîya zimanî.", "Di ontolojîya zimanî de."],
   gen:["Ontolojîya zimanî", "Ontolojîya me"]),

  (id:"c2_313", ku:"Felsefa neteweyî ya kurd", tr:"Kürt ulusal felsefesi", en:"Kurdish national philosophy",
   cins:"mê", ez:"felsefa neteweyî ya kurd", kat:"felsefe", zor:0.45,
   not:"\"Felsefe\"+\"neteweyî\"+\"kurd\".",
   her:["Felsefa neteweyî ya kurd.", "Di felsefa neteweyî ya kurd de."],
   gen:["Felsefa neteweyî ya kurd", "Felsefa me"]),

  (id:"c2_314", ku:"Têgihîştina azadiyê di çanda kurdî", tr:"Kürt kültüründe özgürlük anlayışı", en:"Understanding freedom in Kurdish culture",
   cins:"mê", ez:"têgihîştina azadiyê di çanda kurdî", kat:"felsefe", zor:0.45,
   not:"\"Têgihîştin\"+\"azadî\"+\"çanda kurdî\".",
   her:["Têgihîştina azadiyê di çanda kurdî.", "Di têgihîştina azadiyê de."],
   gen:["Têgihîştina azadiyê di çanda kurdî", "Têgihîştina me"]),

  (id:"c2_315", ku:"Rexneya modernîteyê", tr:"Modernliğin eleştirisi", en:"Critique of modernity",
   cins:"mê", ez:"rexneya modernîteyê", kat:"felsefe", zor:0.45,
   not:"\"Rexne\"+\"modernîte\". Frankfurt Okulu bağlamı.",
   her:["Rexneya modernîteyê.", "Di rexneya modernîteyê de."],
   gen:["Rexneya modernîteyê", "Rexneya me"]),

  (id:"c2_316", ku:"Dîyalektîka rast û çewt", tr:"Doğru-yanlış diyalektiği", en:"Dialectic of right and wrong",
   cins:"mê", ez:"dîyalektîka rast û çewt", kat:"felsefe", zor:0.45,
   not:"\"Dîyalektîk\"+\"rast û çewt\". Etik akıl yürütme.",
   her:["Dîyalektîka rast û çewt.", "Di dîyalektîka rast û çewt de."],
   gen:["Dîyalektîka rast û çewt", "Dîyalektîka me"]),

  // ── DİLBİLİM VE DİL PLANLAMASI (25) ─────────────────────────

  (id:"c2_317", ku:"Plankirina statuyê zimanî", tr:"Dil statüsü planlaması", en:"Language status planning",
   cins:"mê", ez:"plankirina statuyê zimanî", kat:"ziman", zor:0.45,
   not:"\"Plankirin\"+\"statu\"+\"zimanî\". Haugen'ın dil planlaması modeli.",
   her:["Plankirina statuyê zimanî.", "Di plankirina statuyê zimanî de."],
   gen:["Plankirina statuyê zimanî", "Plankirina me"]),

  (id:"c2_318", ku:"Plankirina corpus zimanî", tr:"Dil corpus planlaması", en:"Language corpus planning",
   cins:"mê", ez:"plankirina corpus zimanî", kat:"ziman", zor:0.44,
   not:"\"Plankirin\"+\"corpus\"+\"zimanî\". Standartizasyon süreci.",
   her:["Plankirina corpus zimanî.", "Di plankirina corpus zimanî de."],
   gen:["Plankirina corpus zimanî", "Plankirina me"]),

  (id:"c2_319", ku:"Pratîkên normalkirinê", tr:"Normalleştirme pratikleri", en:"Normalization practices",
   cins:"bêcins", ez:"pratîkên normalkirinê", kat:"ziman", zor:0.45,
   not:"\"Pratîk\"+\"normalkirin\". Dil kabulü süreci.",
   her:["Pratîkên normalkirinê hene.", "Di pratîkên normalkirinê de."],
   gen:["Pratîkên normalkirinê", "Pratîkên me"]),

  (id:"c2_320", ku:"Pêşengîya zimansaz", tr:"Dilbilimcinin önderliği", en:"Linguist's leadership",
   cins:"mê", ez:"pêşengîya zimansaz", kat:"ziman", zor:0.45,
   not:"\"Pêşengî\"+\"zimansaz\". Dil aktivizmi.",
   her:["Pêşengîya zimansaz lazim e.", "Di pêşengîya zimansaz de."],
   gen:["Pêşengîya zimansaz", "Pêşengîya me"]),

  // ── AKADEMİK VE ARAŞTIRMA C2 (20) ────────────────────────────

  (id:"c2_321", ku:"Gotara referandûmê akademîk", tr:"Akademik hakemlik", en:"Academic peer review",
   cins:"mê", ez:"gotara referandûmê akademîk", kat:"akademik", zor:0.45,
   not:"\"Referandûm\"+\"akademîk\". Hakemli dergi süreci.",
   her:["Gotara referandûmê akademîk.", "Di gotara referandûmê akademîk de."],
   gen:["Gotara referandûmê akademîk", "Gotara me"]),

  (id:"c2_322", ku:"Xebata pirbir a lêkolînê", tr:"Çok katmanlı araştırma", en:"Multi-layered research",
   cins:"mê", ez:"xebata pirbir a lêkolînê", kat:"akademik", zor:0.44,
   not:"\"Xebat\"+\"pirbir\"+\"lêkolîn\".",
   her:["Xebata pirbir a lêkolînê.", "Di xebata pirbir de."],
   gen:["Xebata pirbir a lêkolînê", "Xebata me"]),

  (id:"c2_323", ku:"Têgihîştina semîotîk", tr:"Göstergebilimsel anlayış", en:"Semiotic understanding",
   cins:"mê", ez:"têgihîştina semîotîk", kat:"akademik", zor:0.44,
   not:"\"Têgihîştin\"+\"semîotîk\". Gösterge bilimi.",
   her:["Têgihîştina semîotîk.", "Di têgihîştina semîotîk de."],
   gen:["Têgihîştina semîotîk", "Têgihîştina me"]),

  (id:"c2_324", ku:"Analîza hermenôtîk", tr:"Hermenötik analiz", en:"Hermeneutic analysis",
   cins:"mê", ez:"analîza hermenôtîk", kat:"akademik", zor:0.44,
   not:"\"Analîz\"+\"hermenôtîk\". Yorum bilgisi.",
   her:["Analîza hermenôtîk.", "Di analîza hermenôtîk de."],
   gen:["Analîza hermenôtîk", "Analîza me"]),

  // ── DİLBİLGİSİ C2 (10) ───────────────────────────────────────

  (id:"c2_325", ku:"Aspektê lêkerê ya kûr", tr:"Fiilin derin görünüşü", en:"Deep verb aspect",
   cins:"nêr", ez:"aspektê lêkerê ya kûr", kat:"rêziman", zor:0.44,
   not:"\"Aspekt\"+\"lêker\". Kurmancîde görünüş sistemi: perfective/imperfective.",
   her:["Aspektê lêkerê ya kûr.", "Di aspektê lêkerê de."],
   gen:["Aspektê lêkerê ya kûr", "Aspektê kurdî"]),

  (id:"c2_326", ku:"Modalîteya ezmûnî", tr:"Kanıtsal kiplik", en:"Evidential modality",
   cins:"mê", ez:"modalîteya ezmûnî", kat:"rêziman", zor:0.44,
   not:"\"Modalîte\"+\"ezmûnî\". Kanıtsallık — \"tê gotin\" yapısı.",
   her:["Modalîteya ezmûnî.", "Di modalîteya ezmûnî de."],
   gen:["Modalîteya ezmûnî", "Modalîteya me"]),

  (id:"c2_327", ku:"Têkiliya derheqê ya C2", tr:"C2 ilgi cümlesi", en:"C2 relative clause",
   cins:"mê", ez:"têkiliya derheqê ya C2", kat:"rêziman", zor:0.44,
   not:"\"Têkilî\"+\"derheqê\". C2 sözdizimi. \"Ew kesê ku...\" yapısı.",
   her:["Têkiliya derheqê ya C2.", "Di têkiliya derheqê de."],
   gen:["Têkiliya derheqê ya C2", "Têkiliyên C2"]),

  // ── JEOPOLİTİK VE BÖLGESEL (10) ──────────────────────────────

  (id:"c2_328", ku:"Siyaseta enerjiyê û Kurd", tr:"Enerji politikası ve Kürtler", en:"Energy policy and Kurds",
   cins:"bêcins", ez:null, kat:"siyaset", zor:0.46,
   not:"\"Siyaseta enerjiyê\"+\"Kurd\". Kürdistan'ın petrol kaynakları.",
   her:["Siyaseta enerjiyê û Kurd.", "Di siyaseta enerjiyê de."],
   gen:["Siyaseta enerjiyê û Kurd", "Siyaseta me"]),

  (id:"c2_329", ku:"Şerê neyabûyî ya C2", tr:"C2 dolaylı anlatım", en:"C2 indirect speech",
   cins:"nêr", ez:"şerê neyabûyî ya C2", kat:"rêziman", zor:0.44,
   not:"\"Şerê neyabûyî\" = dolaylı konuşma. \"Got ku bihata\" yapısı.",
   her:["Şerê neyabûyî ya C2.", "Di şerê neyabûyî de."],
   gen:["Şerê neyabûyî ya C2", "Şerê neyabûyî"]),

  (id:"c2_330", ku:"Perspektîva derûnnasiyê ya çanda kurdî", tr:"Kürt kültüründe psikolojik perspektif", en:"Psychological perspective in Kurdish culture",
   cins:"mê", ez:"perspektîva derûnnasiyê ya çanda kurdî", kat:"felsefe", zor:0.44,
   not:"\"Perspektîv\"+\"derûnnasî\"+\"çanda kurdî\".",
   her:["Perspektîva derûnnasiyê ya çanda kurdî.", "Di perspektîva derûnnasiyê de."],
   gen:["Perspektîva derûnnasiyê ya çanda kurdî", "Perspektîva me"]),

  // ── MEDYA C2 (10) ─────────────────────────────────────────────

  (id:"c2_331", ku:"Sazûmanên ragihandina kurdî", tr:"Kürt iletişim kurumları", en:"Kurdish communication institutions",
   cins:"bêcins", ez:"sazûmanên ragihandina kurdî", kat:"medya", zor:0.46,
   not:"\"Sazûman\"+\"ragihandina kurdî\".",
   her:["Sazûmanên ragihandina kurdî.", "Di sazûmanên ragihandina kurdî de."],
   gen:["Sazûmanên ragihandina kurdî", "Sazûmanên me"]),

  (id:"c2_332", ku:"Ragihandina li dijî dezinformasyonê", tr:"Dezenformasyona karşı iletişim", en:"Communication against disinformation",
   cins:"mê", ez:"ragihandina li dijî dezinformasyonê", kat:"medya", zor:0.45,
   not:"\"Ragihandin\"+\"dijî dezinformasyon\".",
   her:["Ragihandina li dijî dezinformasyonê.", "Di ragihandina li dijî dezinformasyonê de."],
   gen:["Ragihandina li dijî dezinformasyonê", "Ragihandina me"]),

  (id:"c2_333", ku:"Ziman û pêvajoya îdeolojîk", tr:"Dil ve ideolojik süreç", en:"Language and ideological process",
   cins:"bêcins", ez:null, kat:"ziman", zor:0.45,
   not:"\"Ziman\"+\"pêvajo\"+\"îdeolojîk\". Althusser'in ideolojik devlet aygıtları.",
   her:["Ziman û pêvajoya îdeolojîk.", "Di ziman û pêvajoya îdeolojîk de."],
   gen:["Ziman û pêvajoya îdeolojîk", "Zimanê me"]),

  (id:"c2_334", ku:"Nîşaneyên hêza zimanî", tr:"Dilsel güç göstergeleri", en:"Linguistic power indicators",
   cins:"bêcins", ez:"nîşaneyên hêza zimanî", kat:"ziman", zor:0.45,
   not:"\"Nîşane\"+\"hêza zimanî\". Dil-iktidar göstergeleri.",
   her:["Nîşaneyên hêza zimanî.", "Di nîşaneyên hêza zimanî de."],
   gen:["Nîşaneyên hêza zimanî", "Nîşaneyên me"]),
];


final kC2_Son109 = [

  // ── SİYASET VE ULUSLARARASI İLİŞKİLER C2 (25) ────────────────
  (id:"c2_400", ku:"Hevsazîya navçeyî", tr:"Bölgesel koordinasyon", en:"Regional coordination",
   cins:"mê", ez:"hevsazîya navçeyî", kat:"siyaset", zor:0.45,
   not:"\"Hevsazî\"+\"navçeyî\". Kürt bölgeleri arası işbirliği.",
   her:["Hevsazîya navçeyî lazim e.", "Di hevsazîya navçeyî de."],
   gen:["Hevsazîya navçeyî", "Hevsazîya me"]),

  (id:"c2_401", ku:"Dîplomasyaya zimanî", tr:"Dil diplomasisi", en:"Language diplomacy",
   cins:"mê", ez:"dîplomasyaya zimanî", kat:"siyaset", zor:0.45,
   not:"\"Dîplomasya\"+\"zimanî\". Dil, uluslararası ilişkilerde araç.",
   her:["Dîplomasyaya zimanî.", "Di dîplomasyaya zimanî de."],
   gen:["Dîplomasyaya zimanî", "Dîplomasyaya me"]),

  (id:"c2_402", ku:"Patronên navnetewî yên Kurdan", tr:"Kürtlerin uluslararası hamilileri", en:"International patrons of Kurds",
   cins:"bêcins", ez:"patronên navnetewî yên Kurdan", kat:"siyaset", zor:0.45,
   not:"\"Patron\"+\"navnetewî\"+\"Kurdan\". Uluslararası destek ilişkileri.",
   her:["Patronên navnetewî yên Kurdan.", "Di patronên navnetewî yên Kurdan de."],
   gen:["Patronên navnetewî yên Kurdan", "Patronên me"]),

  (id:"c2_403", ku:"Şerê proxyê li Kurdistanê", tr:"Kürdistanda vekâlet savaşı", en:"Proxy war in Kurdistan",
   cins:"nêr", ez:"şerê proxyê li Kurdistanê", kat:"siyaset", zor:0.45,
   not:"\"Şerê proxy\" = vekâlet savaşı. Kürdistan'ın jeopolitik konumu.",
   her:["Şerê proxyê li Kurdistanê.", "Di şerê proxyê de."],
   gen:["Şerê proxyê li Kurdistanê", "Şerê proxyê"]),

  (id:"c2_404", ku:"Alîkarîya mirovî ya navnetewî", tr:"Uluslararası insani yardım", en:"International humanitarian aid",
   cins:"mê", ez:"alîkarîya mirovî ya navnetewî", kat:"siyaset", zor:0.46,
   not:"\"Alîkarî\"+\"mirovî\"+\"navnetewî\". İnsani kriz bağlamı.",
   her:["Alîkarîya mirovî ya navnetewî hat.", "Di alîkarîya mirovî ya navnetewî de."],
   gen:["Alîkarîya mirovî ya navnetewî", "Alîkarîya me"]),

  // ── AKADEMİK DERINLEME C2 (25) ───────────────────────────────
  (id:"c2_405", ku:"Rexneya epîstemîk", tr:"Epistemik eleştiri", en:"Epistemic critique",
   cins:"mê", ez:"rexneya epîstemîk", kat:"akademik", zor:0.43,
   not:"\"Rexne\"+\"epîstemîk\". Bilgi teorisi eleştirisi.",
   her:["Rexneya epîstemîk.", "Di rexneya epîstemîk de."],
   gen:["Rexneya epîstemîk", "Rexneya me"]),

  (id:"c2_406", ku:"Pêvajoya hevpeyvînê ya kûr", tr:"Derin mülakat süreci", en:"Deep interview process",
   cins:"mê", ez:"pêvajoya hevpeyvînê ya kûr", kat:"akademik", zor:0.44,
   not:"\"Pêvajo\"+\"hevpeyvîn\"+\"kûr\". Nitel araştırma yöntemi.",
   her:["Pêvajoya hevpeyvînê ya kûr.", "Di pêvajoya hevpeyvînê ya kûr de."],
   gen:["Pêvajoya hevpeyvînê ya kûr", "Pêvajoya me"]),

  (id:"c2_407", ku:"Daneyên etnografîk", tr:"Etnografik veriler", en:"Ethnographic data",
   cins:"bêcins", ez:"daneyên etnografîk", kat:"akademik", zor:0.44,
   not:"\"Dane\"+\"etnografîk\". Nitel saha araştırması verisi.",
   her:["Daneyên etnografîk hatin berhev kirin.", "Di daneyên etnografîk de."],
   gen:["Daneyên etnografîk", "Daneyên me"]),

  (id:"c2_408", ku:"Gotara destpêkî", tr:"Başlangıç makalesi", en:"Foundational article",
   cins:"mê", ez:"gotara destpêkî", kat:"akademik", zor:0.44,
   not:"\"Gotar\"+\"destpêkî\". Bir alanın kurucu metni.",
   her:["Gotara destpêkî baş e.", "Di gotara destpêkî de."],
   gen:["Gotara destpêkî", "Gotara me"]),

  (id:"c2_409", ku:"Nêrîna alîhevkirî", tr:"Sentezci bakış", en:"Synthesizing view",
   cins:"mê", ez:"nêrîna alîhevkirî", kat:"akademik", zor:0.43,
   not:"\"Nêrîn\"+\"alîhevkirî\". Farklı teorileri birleştiren yaklaşım.",
   her:["Nêrîna alîhevkirî baş e.", "Di nêrîna alîhevkirî de."],
   gen:["Nêrîna alîhevkirî", "Nêrîna me"]),

  // ── DİL VE İLETİŞİM C2 (20) ──────────────────────────────────
  (id:"c2_410", ku:"Zimanê diplomatîk", tr:"Diplomatik dil", en:"Diplomatic language",
   cins:"nêr", ez:"zimanê diplomatîk", kat:"ziman", zor:0.46,
   not:"\"Ziman\"+\"diplomatîk\". Uluslararası söylemde dil seçimi.",
   her:["Zimanê diplomatîk.", "Di zimanê diplomatîk de."],
   gen:["Zimanê diplomatîk", "Zimanê me"]),

  (id:"c2_411", ku:"Stratejîya axaftinê", tr:"Konuşma stratejisi", en:"Speech strategy",
   cins:"mê", ez:"stratejîya axaftinê", kat:"ziman", zor:0.46,
   not:"\"Stratejî\"+\"axaftin\". Pragmatik dil kullanımı.",
   her:["Stratejîya axaftinê.", "Di stratejîya axaftinê de."],
   gen:["Stratejîya axaftinê", "Stratejîya me"]),

  (id:"c2_412", ku:"Nîşandana hestan bi ziman", tr:"Dille duygu ifadesi", en:"Expressing emotions through language",
   cins:"mê", ez:"nîşandana hestan bi ziman", kat:"ziman", zor:0.45,
   not:"\"Nîşandan\"+\"hest\"+\"ziman\". Duygusal pragmatik.",
   her:["Nîşandana hestan bi ziman.", "Di nîşandana hestan bi ziman de."],
   gen:["Nîşandana hestan bi ziman", "Nîşandana me"]),

  (id:"c2_413", ku:"Rêzbûna daxwaznameyê", tr:"Dilekçe sözdizimi", en:"Petition syntax",
   cins:"mê", ez:"rêzbûna daxwaznameyê", kat:"rêziman", zor:0.43,
   not:"\"Rêzbûn\"+\"daxwazname\". Resmi yazışma sözdizimi.",
   her:["Rêzbûna daxwaznameyê.", "Di rêzbûna daxwaznameyê de."],
   gen:["Rêzbûna daxwaznameyê", "Rêzbûna me"]),

  (id:"c2_414", ku:"Hevoksaziya çandî", tr:"Kültürel sözdizim", en:"Cultural syntax",
   cins:"mê", ez:"hevoksaziya çandî", kat:"rêziman", zor:0.43,
   not:"\"Hevoksazî\"+\"çandî\". Kültüre özgü cümle kurma.",
   her:["Hevoksaziya çandî.", "Di hevoksaziya çandî de."],
   gen:["Hevoksaziya çandî", "Hevoksaziya me"]),

  // ── KİMLİK VE DIASPORA C2 (20) ───────────────────────────────
  (id:"c2_415", ku:"Kurdbûna diasporayê", tr:"Diaspora Kürtlüğü", en:"Diaspora Kurdishness",
   cins:"mê", ez:"Kurdbûna diasporayê", kat:"kimlik", zor:0.46,
   not:"\"Kurdbûn\"+\"diaspora\". Diasporada kimlik performansı.",
   her:["Kurdbûna diasporayê.", "Di Kurdbûna diasporayê de."],
   gen:["Kurdbûna diasporayê", "Kurdbûna me"]),

  (id:"c2_416", ku:"Lihevhatina nasnameyan", tr:"Kimliklerin uyumlaşması", en:"Accommodation of identities",
   cins:"mê", ez:"lihevhatina nasnameyan", kat:"kimlik", zor:0.45,
   not:"\"Lihevhatin\"+\"nasname\". Çoklu kimlik müzakeresi.",
   her:["Lihevhatina nasnameyan.", "Di lihevhatina nasnameyan de."],
   gen:["Lihevhatina nasnameyan", "Lihevhatina me"]),

  (id:"c2_417", ku:"Pirçand û yekdengî", tr:"Çokkültürlülük ve uyum", en:"Multiculturalism and harmony",
   cins:"bêcins", ez:null, kat:"kimlik", zor:0.46,
   not:"\"Pirçand\"+\"yekdengî\". Çokkültürlü toplum modeli.",
   her:["Pirçand û yekdengî.", "Di pirçand û yekdengî de."],
   gen:["Pirçand û yekdengî", "Pirçanda me"]),

  (id:"c2_418", ku:"Bêmalîya çandî", tr:"Kültürel evsizlik", en:"Cultural homelessness",
   cins:"mê", ez:"bêmalîya çandî", kat:"kimlik", zor:0.45,
   not:"\"Bêmalî\"+\"çandî\". Diaspora deneyiminin ağır yüzü.",
   her:["Bêmalîya çandî.", "Di bêmalîya çandî de."],
   gen:["Bêmalîya çandî", "Bêmalîya me"]),

  (id:"c2_419", ku:"Vejandin û vehiştin", tr:"Hatırlamak ve unutmak", en:"Remembering and forgetting",
   cins:"bêcins", ez:null, kat:"kimlik", zor:0.46,
   not:"\"Vejandin\"+\"vehiştin\". Kolektif hafıza dinamiği.",
   her:["Vejandin û vehiştin.", "Di vejandin û vehiştin de."],
   gen:["Vejandin û vehiştin", "Bîranîn û ji bîranîn"]),

  // ── KÜLTÜR VE EDEBİYAT C2 (15) ───────────────────────────────
  (id:"c2_420", ku:"Wergerandina çandî ya xwecihî", tr:"Yerli kültürel çeviri", en:"Indigenous cultural translation",
   cins:"mê", ez:"wergerandina çandî ya xwecihî", kat:"çand", zor:0.44,
   not:"\"Wergerandin\"+\"çandî\"+\"xwecihî\".",
   her:["Wergerandina çandî ya xwecihî.", "Di wergerandina çandî ya xwecihî de."],
   gen:["Wergerandina çandî ya xwecihî", "Wergerandina me"]),

  (id:"c2_421", ku:"Çanda dijber", tr:"Karşı kültür", en:"Counter-culture",
   cins:"mê", ez:"çanda dijber", kat:"çand", zor:0.46,
   not:"\"Çand\"+\"dijber\". Dominant kültüre alternatif.",
   her:["Çanda dijber ya kurdî.", "Di çanda dijber de."],
   gen:["Çanda dijber", "Çanda me"]),

  (id:"c2_422", ku:"Mîrasa nepenî", tr:"Gizli miras", en:"Hidden heritage",
   cins:"mê", ez:"mîrasa nepenî", kat:"çand", zor:0.45,
   not:"\"Mîras\"+\"nepenî\". Baskı altında yaşatılan kültürel miras.",
   her:["Mîrasa nepenî heye.", "Di mîrasa nepenî de."],
   gen:["Mîrasa nepenî", "Mîrasa me"]),

  // ── PSİKOLOJİ C2 (5) ─────────────────────────────────────────
  (id:"c2_423", ku:"Derûnnasiya siyasî", tr:"Siyasi psikoloji", en:"Political psychology",
   cins:"mê", ez:"derûnnasiya siyasî", kat:"psikoloji", zor:0.45,
   not:"\"Derûnnasî\"+\"siyasî\". Siyasi davranış psikolojisi.",
   her:["Derûnnasiya siyasî.", "Di derûnnasiya siyasî de."],
   gen:["Derûnnasiya siyasî", "Derûnnasiya me"]),

  (id:"c2_424", ku:"Psîkolojîya rizgariyê", tr:"Kurtuluş psikolojisi", en:"Liberation psychology",
   cins:"mê", ez:"psîkolojîya rizgariyê", kat:"psikoloji", zor:0.44,
   not:"\"Psîkolojî\"+\"rizgarî\". Frantz Fanon bağlamı.",
   her:["Psîkolojîya rizgariyê.", "Di psîkolojîya rizgariyê de."],
   gen:["Psîkolojîya rizgariyê", "Psîkolojîya me"]),

  (id:"c2_425", ku:"Travmaya dîrokî ya kolektîf", tr:"Kolektif tarihi travma", en:"Collective historical trauma",
   cins:"mê", ez:"travmaya dîrokî ya kolektîf", kat:"psikoloji", zor:0.45,
   not:"\"Travma\"+\"dîrokî\"+\"kolektîf\". Nesiller arası travma.",
   her:["Travmaya dîrokî ya kolektîf.", "Di travmaya dîrokî ya kolektîf de."],
   gen:["Travmaya dîrokî ya kolektîf", "Travmaya me"]),

  // ── DAÇEK / AKADEMIK KALIPLAR C2 (10) ────────────────────────
  (id:"c2_426", ku:"Bi vê yekê re", tr:"Bununla birlikte", en:"Along with this",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.47,
   not:"\"Bi vê yekê re\" = bununla birlikte. C2 akademik söylem bağlacı.",
   her:["Bi vê yekê re, em...", "Bi vê yekê re dizanin."],
   gen:["Bi vê yekê re", "Lê belê"]),

  (id:"c2_427", ku:"Ji aliyê din ve", tr:"Öte yandan", en:"On the other hand",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.47,
   not:"\"Ji aliyê din ve\" = öte yandan. Karşıt argüman bağlacı.",
   her:["Ji aliyê din ve, em dibêjin...", "Ji aliyê din ve."],
   gen:["Ji aliyê din ve", "Ji aliyê ve"]),

  (id:"c2_428", ku:"Weke xulase", tr:"Özetle", en:"In summary",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.48,
   not:"\"Weke xulase\" = özetle. Sonuç söylemine geçiş.",
   her:["Weke xulase em dibêjin.", "Weke xulase..."],
   gen:["Weke xulase", "Bi kurtasî"]),
];


final kC2_Son80 = [

  // ── KİMLİK DERİN — 15 ─────────────────────────────────────────
  (id:"c2_500", ku:"Çarçoveya nasnameya C2", tr:"C2 kimlik çerçevesi", en:"C2 identity framework",
   cins:"mê", ez:"çarçoveya nasnameya C2", kat:"kimlik", zor:0.44,
   not:"Kimlik üretiminin eleştirel çerçevesi — Hall, Butler, Bhabha.",
   her:["Çarçoveya nasnameya C2.", "Di çarçoveya nasnameya C2 de."],
   gen:["Çarçoveya nasnameya C2", "Çarçoveya me"]),

  (id:"c2_501", ku:"Nasnameya li ser sînoran", tr:"Sınırda kimlik", en:"Border identity",
   cins:"mê", ez:"nasnameya li ser sînoran", kat:"kimlik", zor:0.45,
   not:"Gloria Anzaldúa'nın \"borderlands\" kavramı — Kürt coğrafyasında yankısı.",
   her:["Nasnameya li ser sînoran.", "Di nasnameya li ser sînoran de."],
   gen:["Nasnameya li ser sînoran", "Nasnameya me"]),

  (id:"c2_502", ku:"Vegerandina ser zimanê wendabûyî", tr:"Kayıp dile dönüş", en:"Return to a lost language",
   cins:"mê", ez:"vegerandina ser zimanê wendabûyî", kat:"kimlik", zor:0.45,
   not:"\"Vegerandin\"+\"zimanê wendabûyî\". Heritage öğreniminin duygusal boyutu.",
   her:["Vegerandina ser zimanê wendabûyî.", "Di vegerandina ser zimanê wendabûyî de."],
   gen:["Vegerandina ser zimanê wendabûyî", "Vegerandina me"]),

  (id:"c2_503", ku:"Piranîbûna nasnameya Kurdî", tr:"Kürt kimliğinin çoğulluğu", en:"Plurality of Kurdish identity",
   cins:"mê", ez:"piranîbûna nasnameya Kurdî", kat:"kimlik", zor:0.44,
   not:"\"Piranîbûn\"+\"nasname\"+\"Kurdî\". Kürt kimliğinin monolitik olmadığı.",
   her:["Piranîbûna nasnameya Kurdî.", "Di piranîbûna nasnameya Kurdî de."],
   gen:["Piranîbûna nasnameya Kurdî", "Piranîbûna me"]),

  (id:"c2_504", ku:"Hînbûna ji nû ve ya nasnameya çandî", tr:"Kültürel kimliği yeniden öğrenme", en:"Re-learning cultural identity",
   cins:"mê", ez:"hînbûna ji nû ve ya nasnameya çandî", kat:"kimlik", zor:0.44,
   not:"\"Hînbûna ji nû ve\"+\"nasname\"+\"çandî\". Heritage öğrenimi.",
   her:["Hînbûna ji nû ve ya nasnameya çandî.", "Di hînbûna ji nû ve de."],
   gen:["Hînbûna ji nû ve ya nasnameya çandî", "Hînbûna me"]),

  // ── KÜLTÜR DERİN — 15 ─────────────────────────────────────────
  (id:"c2_505", ku:"Berhemdana çandî ya kolonyal", tr:"Sömürgeci kültürel üretim", en:"Colonial cultural production",
   cins:"mê", ez:"berhemdana çandî ya kolonyal", kat:"çand", zor:0.43,
   not:"\"Berhemdana çandî\"+\"kolonyal\". Said'in Oryantalizm eleştirisi bağlamı.",
   her:["Berhemdana çandî ya kolonyal.", "Di berhemdana çandî ya kolonyal de."],
   gen:["Berhemdana çandî ya kolonyal", "Berhemdana me"]),

  (id:"c2_506", ku:"Têkiliya serdest û bindest di çandê de", tr:"Kültürde egemen-bağımlı ilişkisi", en:"Dominant-subordinate relation in culture",
   cins:"mê", ez:"têkiliya serdest û bindest di çandê de", kat:"çand", zor:0.43,
   not:"Gramsci hegemonya teorisi — kültürel güç ilişkileri.",
   her:["Têkiliya serdest û bindest di çandê de.", "Di têkiliya serdest û bindest de."],
   gen:["Têkiliya serdest û bindest di çandê de", "Têkiliya me"]),

  (id:"c2_507", ku:"Çanda jêrîn ya Kurdî", tr:"Kürt alt kültürü", en:"Kurdish subculture",
   cins:"mê", ez:"çanda jêrîn ya Kurdî", kat:"çand", zor:0.44,
   not:"\"Çand\"+\"jêrîn\"+\"Kurdî\". Hâkim kültüre direnen alt kültür.",
   her:["Çanda jêrîn ya Kurdî.", "Di çanda jêrîn ya Kurdî de."],
   gen:["Çanda jêrîn ya Kurdî", "Çanda jêrîn ya me"]),

  // ── FELSEFİ DERİNLEME — 12 ───────────────────────────────────
  (id:"c2_508", ku:"Fenomenolojîya zimanî", tr:"Dilsel fenomenoloji", en:"Linguistic phenomenology",
   cins:"mê", ez:"fenomenolojîya zimanî", kat:"felsefe", zor:0.43,
   not:"Merleau-Ponty: beden ve dil. Husserl fenomenolojisi.",
   her:["Fenomenolojîya zimanî.", "Di fenomenolojîya zimanî de."],
   gen:["Fenomenolojîya zimanî", "Fenomonolojîya me"]),

  (id:"c2_509", ku:"Civakbûna mirov û ziman", tr:"İnsan ve dilin toplumsallığı", en:"Sociality of human and language",
   cins:"mê", ez:"civakbûna mirov û ziman", kat:"felsefe", zor:0.43,
   not:"\"Civakbûn\"+\"mirov û ziman\". Vygotsky sosyal öğrenme.",
   her:["Civakbûna mirov û ziman.", "Di civakbûna mirov û ziman de."],
   gen:["Civakbûna mirov û ziman", "Civakbûna me"]),

  (id:"c2_510", ku:"Têkiliya moralê û siyasetê", tr:"Ahlak ve siyaset ilişkisi", en:"Morality-politics relation",
   cins:"mê", ez:"têkiliya moralê û siyasetê", kat:"felsefe", zor:0.43,
   not:"\"Têkilî\"+\"moral û siyaset\". Siyaset felsefesi.",
   her:["Têkiliya moralê û siyasetê.", "Di têkiliya moralê û siyasetê de."],
   gen:["Têkiliya moralê û siyasetê", "Têkiliya me"]),

  // ── PSİKOLOJİ DERİN — 8 ───────────────────────────────────────
  (id:"c2_511", ku:"Hişmendiya bajêrvanîtiyê", tr:"Diaspora bilinci", en:"Diaspora consciousness",
   cins:"mê", ez:"hişmendiya bajêrvanîtiyê", kat:"psikoloji", zor:0.44,
   not:"\"Hişmendî\"+\"bajêrvanî\". Sürgün/diaspora psikolojisi.",
   her:["Hişmendiya bajêrvanîtiyê.", "Di hişmendiya bajêrvanîtiyê de."],
   gen:["Hişmendiya bajêrvanîtiyê", "Hişmendiya me"]),

  (id:"c2_512", ku:"Girtêk û azadîya hişmendî", tr:"Bilinçsel kısıtlama ve özgürlük", en:"Mental constraint and freedom",
   cins:"bêcins", ez:null, kat:"psikoloji", zor:0.43,
   not:"\"Girtêk\"+\"azadî\"+\"hişmendî\". Sömürge psikolojisi.",
   her:["Girtêk û azadîya hişmendî.", "Di girtêk û azadîya hişmendî de."],
   gen:["Girtêk û azadîya hişmendî", "Hişmendiya me"]),

  // ── MEDYA DERİN — 10 ─────────────────────────────────────────
  (id:"c2_513", ku:"Platformên medyaya civakî yên kurdî", tr:"Kürt sosyal medya platformları", en:"Kurdish social media platforms",
   cins:"bêcins", ez:"platformên medyaya civakî yên kurdî", kat:"medya", zor:0.45,
   not:"\"Platform\"+\"medyaya civakî\"+\"kurdî\". Dijital Kürt alanı.",
   her:["Platformên medyaya civakî yên kurdî.", "Di platformên medyaya civakî yên kurdî de."],
   gen:["Platformên medyaya civakî yên kurdî", "Platformên me"]),

  (id:"c2_514", ku:"Algorîtma û kurdî", tr:"Algoritma ve Kürtçe", en:"Algorithm and Kurdish",
   cins:"bêcins", ez:null, kat:"medya", zor:0.45,
   not:"\"Algorîtma\"+\"kurdî\". Arama motorları, Kürtçe görünürlük.",
   her:["Algorîtma û kurdî.", "Di navbera algorîtma û kurdî de."],
   gen:["Algorîtma û kurdî", "Algorîtmaya me"]),

  (id:"c2_515", ku:"Arşîva dîjîtal a kurdî", tr:"Kürtçe dijital arşiv", en:"Kurdish digital archive",
   cins:"mê", ez:"arşîva dîjîtal a kurdî", kat:"medya", zor:0.45,
   not:"\"Arşîv\"+\"dîjîtal\"+\"kurdî\". Kürt kültürel dijital koruma.",
   her:["Arşîva dîjîtal a kurdî heye.", "Di arşîva dîjîtal a kurdî de."],
   gen:["Arşîva dîjîtal a kurdî", "Arşîva me"]),

  // ── SİYASET DERINLEME — 8 ─────────────────────────────────────
  (id:"c2_516", ku:"Siyaseta çandî ya dewletê", tr:"Devletin kültür politikası", en:"State's cultural policy",
   cins:"mê", ez:"siyaseta çandî ya dewletê", kat:"siyaset", zor:0.45,
   not:"\"Siyaset\"+\"çandî\"+\"dewlet\". Kültürel asimilasyon politikaları.",
   her:["Siyaseta çandî ya dewletê.", "Di siyaseta çandî ya dewletê de."],
   gen:["Siyaseta çandî ya dewletê", "Siyaseta me"]),

  (id:"c2_517", ku:"Siyaseta nasnameya neteweyî", tr:"Ulusal kimlik politikası", en:"National identity policy",
   cins:"mê", ez:"siyaseta nasnameya neteweyî", kat:"siyaset", zor:0.45,
   not:"\"Siyaset\"+\"nasname\"+\"neteweyî\".",
   her:["Siyaseta nasnameya neteweyî.", "Di siyaseta nasnameya neteweyî de."],
   gen:["Siyaseta nasnameya neteweyî", "Siyaseta me"]),

  // ── DAÇEK/KALIPLAR GENEL — 5 ─────────────────────────────────
  (id:"c2_518", ku:"Bi vî awayî", tr:"Bu şekilde", en:"In this way",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.47,
   not:"\"Bi vî awayî\" = bu şekilde. Açıklama kalıbı.",
   her:["Bi vî awayî pêk tê.", "Bi vî awayî dizanin."],
   gen:["Bi vî awayî", "Bi vî awayî pêk tê."]),

  (id:"c2_519", ku:"Di rêya ... de", tr:"... yoluyla", en:"By means of / through",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.47,
   not:"\"Di rêya... de\" = yoluyla/aracılığıyla. Akademik yazı kalıbı.",
   her:["Di rêya zimên de.", "Di rêya lêkolînê de."],
   gen:["Di rêya... de", "Di rêya me de"]),

  (id:"c2_520", ku:"Ji vê derê ve", tr:"Buradan hareketle", en:"Starting from here",
   cins:"bêcins", ez:null, kat:"daçek", zor:0.46,
   not:"\"Ji vê derê ve\" = buradan hareketle. Argüman geliştirme.",
   her:["Ji vê derê ve, em dixwazin...", "Ji vê derê ve."],
   gen:["Ji vê derê ve", "Ji vê derê ve em"]),
];


final kC2_Bitis = [
  // Felsefe
  (id:"c2_600", ku:"Fenomena çandî", tr:"Kültürel fenomen", en:"Cultural phenomenon", cins:"mê", ez:"fenomena çandî", kat:"felsefe", zor:0.43, not:"\"Fenomen\"+\"çandî\". Sosyal olgu.", her:["Fenomena çandî.","Di fenomena çandî de."], gen:["Fenomena çandî","Fenomena me"]),
  (id:"c2_601", ku:"Praksîsa zimanî", tr:"Dilsel pratik", en:"Language praxis", cins:"mê", ez:"praksîsa zimanî", kat:"felsefe", zor:0.42, not:"\"Praksîs\"+\"zimanî\". Bourdieu: pratik teori.", her:["Praksîsa zimanî.","Di praksîsa zimanî de."], gen:["Praksîsa zimanî","Praksîsa me"]),
  (id:"c2_602", ku:"Têgîhîştina dialektîk", tr:"Diyalektik anlayış", en:"Dialectical understanding", cins:"mê", ez:"têgîhîştina dialektîk", kat:"felsefe", zor:0.42, not:"\"Têgîhîştin\"+\"dialektîk\". Hegel ve Marx.", her:["Têgîhîştina dialektîk.","Di têgîhîştina dialektîk de."], gen:["Têgîhîştina dialektîk","Têgîhîştina me"]),
  (id:"c2_603", ku:"Rastîya xwendina rexneyî", tr:"Eleştirel okumanın gerçekliği", en:"Reality of critical reading", cins:"mê", ez:"rastîya xwendina rexneyî", kat:"felsefe", zor:0.42, not:"\"Rastî\"+\"xwendin\"+\"rexneyî\".", her:["Rastîya xwendina rexneyî.","Di rastîya xwendina rexneyî de."], gen:["Rastîya xwendina rexneyî","Rastîya me"]),
  // Ziman
  (id:"c2_604", ku:"Lêpirsîna mîkrozaman", tr:"Mikrodizim araştırması", en:"Microgenetic research", cins:"mê", ez:"lêpirsîna mîkrozaman", kat:"ziman", zor:0.42, not:"\"Lêpirsîn\"+\"mîkro\". Kısa vadeli dil gelişimi.", her:["Lêpirsîna mîkrozaman.","Di lêpirsîna mîkrozaman de."], gen:["Lêpirsîna mîkrozaman","Lêpirsîna me"]),
  (id:"c2_605", ku:"Têgîhîştina semîotîk a çandê", tr:"Kültürün göstergebilimsel anlayışı", en:"Semiotic understanding of culture", cins:"mê", ez:"têgîhîştina semîotîk a çandê", kat:"ziman", zor:0.42, not:"\"Têgîhîştin\"+\"semîotîk\"+\"çand\". Lotman kültür semiyotiği.", her:["Têgîhîştina semîotîk a çandê.","Di têgîhîştina semîotîk a çandê de."], gen:["Têgîhîştina semîotîk a çandê","Têgîhîştina me"]),
  (id:"c2_606", ku:"Pragmatîka nav-çandî", tr:"Kültürlerarası pragmatik", en:"Cross-cultural pragmatics", cins:"mê", ez:"pragmatîka nav-çandî", kat:"ziman", zor:0.43, not:"\"Pragmatîk\"+\"nav-çandî\". Kültürlerarası iletişim.", her:["Pragmatîka nav-çandî.","Di pragmatîka nav-çandî de."], gen:["Pragmatîka nav-çandî","Pragmatîka me"]),
  (id:"c2_607", ku:"Standardkirina alfabeyê", tr:"Alfabe standardizasyonu", en:"Alphabet standardization", cins:"mê", ez:"standardkirina alfabeyê", kat:"ziman", zor:0.44, not:"\"Standardkirin\"+\"alfabe\". Kürt Latin alfabesi (1932).", her:["Standardkirina alfabeyê.","Di standardkirina alfabeyê de."], gen:["Standardkirina alfabeyê","Standardkirina me"]),
  (id:"c2_608", ku:"Dewsa zimên di zagonê de", tr:"Dilin hukuktaki yeri", en:"Place of language in law", cins:"mê", ez:"dewsa zimên di zagonê de", kat:"ziman", zor:0.44, not:"\"Dewse\"+\"zimên\"+\"zagon\". Dil hakları.", her:["Dewsa zimên di zagonê de.","Di dewsa zimên di zagonê de."], gen:["Dewsa zimên di zagonê de","Dewsa zimên"]),
  // Akademik
  (id:"c2_609", ku:"Senteza nêrînan", tr:"Görüşlerin sentezi", en:"Synthesis of views", cins:"mê", ez:"senteza nêrînan", kat:"akademik", zor:0.44, not:"\"Sentez\"+\"nêrîn\". Akademik argüman sentezi.", her:["Senteza nêrînan.","Di senteza nêrînan de."], gen:["Senteza nêrînan","Senteza me"]),
  (id:"c2_610", ku:"Lêpirsîna çalak", tr:"Eylem araştırması", en:"Action research", cins:"mê", ez:"lêpirsîna çalak", kat:"akademik", zor:0.44, not:"\"Lêpirsîn\"+\"çalak\". Participatory action research.", her:["Lêpirsîna çalak.","Di lêpirsîna çalak de."], gen:["Lêpirsîna çalak","Lêpirsîna me"]),
  (id:"c2_611", ku:"Têgîhîştina fenomenolojîk", tr:"Fenomenolojik anlayış", en:"Phenomenological understanding", cins:"mê", ez:"têgîhîştina fenomenolojîk", kat:"akademik", zor:0.42, not:"\"Têgîhîştin\"+\"fenomenolojîk\". Husserl'in bracketing yöntemi.", her:["Têgîhîştina fenomenolojîk.","Di têgîhîştina fenomenolojîk de."], gen:["Têgîhîştina fenomenolojîk","Têgîhîştina me"]),
  (id:"c2_612", ku:"Nirxandina kûr a pratîkê", tr:"Pratiğin derin değerlendirmesi", en:"Deep assessment of practice", cins:"mê", ez:"nirxandina kûr a pratîkê", kat:"akademik", zor:0.43, not:"\"Nirxandin\"+\"kûr\"+\"pratîk\".", her:["Nirxandina kûr a pratîkê.","Di nirxandina kûr a pratîkê de."], gen:["Nirxandina kûr a pratîkê","Nirxandina me"]),
  // Siyaset
  (id:"c2_613", ku:"Pêşkeftina mafên Kurdan", tr:"Kürt haklarının gelişimi", en:"Development of Kurdish rights", cins:"mê", ez:"pêşkeftina mafên Kurdan", kat:"siyaset", zor:0.46, not:"\"Pêşkeftin\"+\"mafên Kurdan\".", her:["Pêşkeftina mafên Kurdan.","Di pêşkeftina mafên Kurdan de."], gen:["Pêşkeftina mafên Kurdan","Pêşkeftina me"]),
  (id:"c2_614", ku:"Nexşeya siyasî ya gelêrî", tr:"Halkın siyasi haritası", en:"People's political map", cins:"mê", ez:"nexşeya siyasî ya gelêrî", kat:"siyaset", zor:0.45, not:"\"Nexşe\"+\"siyasî\"+\"gelêrî\".", her:["Nexşeya siyasî ya gelêrî.","Di nexşeya siyasî ya gelêrî de."], gen:["Nexşeya siyasî ya gelêrî","Nexşeya me"]),
  (id:"c2_615", ku:"Tevkarîya sivîl a Kurdan", tr:"Kürtlerin sivil katkısı", en:"Kurdish civil contribution", cins:"mê", ez:"tevkarîya sivîl a Kurdan", kat:"siyaset", zor:0.46, not:"\"Tevkarî\"+\"sivîl\"+\"Kurdan\".", her:["Tevkarîya sivîl a Kurdan.","Di tevkarîya sivîl a Kurdan de."], gen:["Tevkarîya sivîl a Kurdan","Tevkarîya me"]),
  // Kimlik/Çand
  (id:"c2_616", ku:"Jiyana di navbera du welatan de", tr:"İki vatan arasında yaşam", en:"Life between two homelands", cins:"mê", ez:"jiyana di navbera du welatan de", kat:"kimlik", zor:0.46, not:"\"Jiyan\"+\"navbera du welat\". Diaspora deneyimi.", her:["Jiyana di navbera du welatan de.","Di jiyana di navbera du welatan de."], gen:["Jiyana di navbera du welatan de","Jiyana me"]),
  (id:"c2_617", ku:"Xizmeta çandê ya hevbeş", tr:"Ortak kültürel hizmet", en:"Shared cultural service", cins:"mê", ez:"xizmeta çandê ya hevbeş", kat:"çand", zor:0.45, not:"\"Xizmet\"+\"çand\"+\"hevbeş\".", her:["Xizmeta çandê ya hevbeş.","Di xizmeta çandê ya hevbeş de."], gen:["Xizmeta çandê ya hevbeş","Xizmeta me"]),
  (id:"c2_618", ku:"Çanda êzmanî", tr:"Ruh/gök kültürü", en:"Celestial culture", cins:"mê", ez:"çanda êzmanî", kat:"çand", zor:0.44, not:"\"Çand\"+\"êzman\" (gök/evren). Mistik kültür boyutu.", her:["Çanda êzmanî.","Di çanda êzmanî de."], gen:["Çanda êzmanî","Çanda me"]),
  // Rêziman
  (id:"c2_619", ku:"Têkiliya aspekt û dem", tr:"Görünüş ve zaman ilişkisi", en:"Aspect-tense relation", cins:"mê", ez:"têkiliya aspekt û dem", kat:"rêziman", zor:0.42, not:"\"Têkilî\"+\"aspekt û dem\". Zamansal semantik.", her:["Têkiliya aspekt û dem.","Di têkiliya aspekt û dem de."], gen:["Têkiliya aspekt û dem","Têkiliya me"]),
  (id:"c2_620", ku:"Prosodîya kurdî", tr:"Kürtçe prozodi", en:"Kurdish prosody", cins:"mê", ez:"prosodîya kurdî", kat:"rêziman", zor:0.42, not:"\"Prosodî\"+\"kurdî\". Kürtçe vurgu ve tonlama sistemi.", her:["Prosodîya kurdî.","Di prosodîya kurdî de."], gen:["Prosodîya kurdî","Prosodîya me"]),
  // Medya
  (id:"c2_621", ku:"Ziman û pêşkêşkirin di medyayê de", tr:"Medyada dil ve sunum", en:"Language and presentation in media", cins:"bêcins", ez:null, kat:"medya", zor:0.45, not:"\"Ziman\"+\"pêşkêşkirin\"+\"medya\".", her:["Ziman û pêşkêşkirin di medyayê de.","Di ziman û pêşkêşkirin de."], gen:["Ziman û pêşkêşkirin di medyayê de","Zimanê me"]),
  // Psikoloji
  (id:"c2_622", ku:"Wesnandin û zanîn", tr:"Duygu ve bilgi", en:"Emotion and knowledge", cins:"bêcins", ez:null, kat:"psikoloji", zor:0.43, not:"\"Wesnandin\"+\"zanîn\". Duygu-biliş ilişkisi.", her:["Wesnandin û zanîn.","Di wesnandin û zanîn de."], gen:["Wesnandin û zanîn","Hestên me"]),
  // Daçek
  (id:"c2_623", ku:"Ji aliyê zanistî ve", tr:"Bilimsel açıdan", en:"From a scientific standpoint", cins:"bêcins", ez:null, kat:"daçek", zor:0.46, not:"\"Ji aliyê zanistî ve\" = bilimsel açıdan. Akademik çerçeveleme.", her:["Ji aliyê zanistî ve.","Ji aliyê zanistî ve, ev rast e."], gen:["Ji aliyê zanistî ve","Ji aliyê teorîkî ve"]),
];


final kC2_Tamam35 = [
  (id:"c2_700", ku:"Têkiliya çand û hêzê", tr:"Kültür ve güç ilişkisi", en:"Culture-power relation", cins:"mê", ez:"têkiliya çand û hêzê", kat:"felsefe", zor:0.43, not:"Bourdieu: kültürel sermaye ve alan.", her:["Têkiliya çand û hêzê.","Di têkiliya çand û hêzê de."], gen:["Têkiliya çand û hêzê","Têkiliya me"]),
  (id:"c2_701", ku:"Zimanzaniya berhevdanê", tr:"Karşılaştırmalı dilbilim", en:"Comparative linguistics", cins:"mê", ez:"zimanzaniya berhevdanê", kat:"ziman", zor:0.43, not:"\"Zimanzanî\"+\"berhevdan\". Diller arası karşılaştırma.", her:["Zimanzaniya berhevdanê.","Di zimanzaniya berhevdanê de."], gen:["Zimanzaniya berhevdanê","Zimanzaniya me"]),
  (id:"c2_702", ku:"Têkiliya gotin û ramanê", tr:"Söz ve düşünce ilişkisi", en:"Word-thought relation", cins:"mê", ez:"têkiliya gotin û ramanê", kat:"ziman", zor:0.43, not:"Sapir-Whorf hipotezi bağlamı.", her:["Têkiliya gotin û ramanê.","Di têkiliya gotin û ramanê de."], gen:["Têkiliya gotin û ramanê","Têkiliya me"]),
  (id:"c2_703", ku:"Helwest û çalakî di zimên de", tr:"Dilde tutum ve eylem", en:"Attitude and action in language", cins:"bêcins", ez:null, kat:"ziman", zor:0.43, not:"\"Helwest û çalakî\"+\"zimên\". Söylem analizi.", her:["Helwest û çalakî di zimên de.","Di helwest û çalakî de."], gen:["Helwest û çalakî di zimên de","Zimanê me"]),
  (id:"c2_704", ku:"Teorîya çanda bazarê", tr:"Pazar kültürü teorisi", en:"Marketplace culture theory", cins:"mê", ez:"teorîya çanda bazarê", kat:"felsefe", zor:0.43, not:"\"Teorî\"+\"çanda bazarê\". Kültürün metalaşması.", her:["Teorîya çanda bazarê.","Di teorîya çanda bazarê de."], gen:["Teorîya çanda bazarê","Teorîya me"]),
  (id:"c2_705", ku:"Analîza girêbesta axaftinê", tr:"Söz edimi analizinin", en:"Speech act analysis", cins:"mê", ez:"analîza girêbesta axaftinê", kat:"ziman", zor:0.42, not:"\"Analîz\"+\"girêbest\"+\"axaftin\". Austin/Searle.", her:["Analîza girêbesta axaftinê.","Di analîza girêbesta axaftinê de."], gen:["Analîza girêbesta axaftinê","Analîza me"]),
  (id:"c2_706", ku:"Pêşkêşkirina xwe a zimanî", tr:"Dilsel öz sunumu", en:"Linguistic self-presentation", cins:"mê", ez:"pêşkêşkirina xwe a zimanî", kat:"ziman", zor:0.43, not:"\"Pêşkêşkirin\"+\"xwe\"+\"zimanî\". Goffman dramaturjisi.", her:["Pêşkêşkirina xwe a zimanî.","Di pêşkêşkirina xwe a zimanî de."], gen:["Pêşkêşkirina xwe a zimanî","Pêşkêşkirina me"]),
  (id:"c2_707", ku:"Nirxên zanistî û exlaqî", tr:"Bilimsel ve etik değerler", en:"Scientific and ethical values", cins:"bêcins", ez:"nirxên zanistî û exlaqî", kat:"akademik", zor:0.44, not:"\"Nirx\"+\"zanistî û exlaqî\". Araştırma etiği.", her:["Nirxên zanistî û exlaqî.","Di nirxên zanistî û exlaqî de."], gen:["Nirxên zanistî û exlaqî","Nirxên me"]),
  (id:"c2_708", ku:"Netewebûna zimanî", tr:"Dilsel millileşme", en:"Linguistic nationalization", cins:"mê", ez:"netewebûna zimanî", kat:"siyaset", zor:0.45, not:"\"Netewebûn\"+\"zimanî\". Dil ve ulus inşası.", her:["Netewebûna zimanî.","Di netewebûna zimanî de."], gen:["Netewebûna zimanî","Netewebûna me"]),
  (id:"c2_709", ku:"Siyaseta maf û welêt", tr:"Hak ve vatan siyaseti", en:"Rights and homeland politics", cins:"mê", ez:"siyaseta maf û welêt", kat:"siyaset", zor:0.46, not:"\"Siyaset\"+\"maf û welêt\".", her:["Siyaseta maf û welêt.","Di siyaseta maf û welêt de."], gen:["Siyaseta maf û welêt","Siyaseta me"]),
  (id:"c2_710", ku:"Çêkirina hiqûqê ya alternatîf", tr:"Alternatif hukuk yapımı", en:"Alternative law-making", cins:"mê", ez:"çêkirina hiqûqê ya alternatîf", kat:"siyaset", zor:0.44, not:"\"Çêkirin\"+\"hiqûq\"+\"alternatîf\". Kürt öz hukuku.", her:["Çêkirina hiqûqê ya alternatîf.","Di çêkirina hiqûqê ya alternatîf de."], gen:["Çêkirina hiqûqê ya alternatîf","Çêkirina me"]),
  (id:"c2_711", ku:"Wêjeya ezmûna diasporayê", tr:"Diaspora deneyimi edebiyatı", en:"Literature of diaspora experience", cins:"mê", ez:"wêjeya ezmûna diasporayê", kat:"edebiyat", zor:0.45, not:"\"Wêje\"+\"ezmûn\"+\"diaspora\".", her:["Wêjeya ezmûna diasporayê.","Di wêjeya ezmûna diasporayê de."], gen:["Wêjeya ezmûna diasporayê","Wêjeya me"]),
  (id:"c2_712", ku:"Metnên bingehîn ên teorîkî", tr:"Temel teorik metinler", en:"Foundational theoretical texts", cins:"bêcins", ez:"metnên bingehîn ên teorîkî", kat:"akademik", zor:0.43, not:"\"Metn\"+\"bingehîn\"+\"teorîkî\". Kanon teorik metinler.", her:["Metnên bingehîn ên teorîkî.","Di metnên bingehîn ên teorîkî de."], gen:["Metnên bingehîn ên teorîkî","Metnên me"]),
  (id:"c2_713", ku:"Têkiliya hêz û zanînê", tr:"Güç ve bilgi ilişkisi", en:"Power-knowledge relation", cins:"mê", ez:"têkiliya hêz û zanînê", kat:"felsefe", zor:0.43, not:"Foucault: pouvoir-savoir. Bilgi iktidar üretir.", her:["Têkiliya hêz û zanînê.","Di têkiliya hêz û zanînê de."], gen:["Têkiliya hêz û zanînê","Têkiliya me"]),
  (id:"c2_714", ku:"Nîvromaka kurdî ya nûjen", tr:"Çağdaş Kürt romanı", en:"Contemporary Kurdish novel", cins:"mê", ez:"nîvromaka kurdî ya nûjen", kat:"edebiyat", zor:0.46, not:"\"Nîvromak\"+\"kurdî\"+\"nûjen\". Modern Kürt nesri.", her:["Nîvromaka kurdî ya nûjen.","Di nîvromaka kurdî ya nûjen de."], gen:["Nîvromaka kurdî ya nûjen","Nîvromaka me"]),
  (id:"c2_715", ku:"Girêbesta civakî ya C2", tr:"C2 toplumsal sözleşme", en:"C2 social contract", cins:"mê", ez:"girêbesta civakî ya C2", kat:"felsefe", zor:0.43, not:"Rousseau'nun sözleşme teorisi — Kürt bağlamı.", her:["Girêbesta civakî ya C2.","Di girêbesta civakî ya C2 de."], gen:["Girêbesta civakî ya C2","Girêbesta civakî"]),
  (id:"c2_716", ku:"Dîroka şaristanîya kurdî", tr:"Kürt medeniyeti tarihi", en:"History of Kurdish civilization", cins:"mê", ez:"dîroka şaristanîya kurdî", kat:"edebiyat", zor:0.47, not:"\"Dîrok\"+\"şaristanî\"+\"kurdî\". Kürt kadim tarihi.", her:["Dîroka şaristanîya kurdî.","Di dîroka şaristanîya kurdî de."], gen:["Dîroka şaristanîya kurdî","Dîroka me"]),
  (id:"c2_717", ku:"Têkoşîna siyasî ya nav-herêmî", tr:"Bölgelerarası siyasi mücadele", en:"Inter-regional political struggle", cins:"mê", ez:"têkoşîna siyasî ya nav-herêmî", kat:"siyaset", zor:0.45, not:"\"Têkoşîn\"+\"siyasî\"+\"nav-herêmî\".", her:["Têkoşîna siyasî ya nav-herêmî.","Di têkoşîna siyasî ya nav-herêmî de."], gen:["Têkoşîna siyasî ya nav-herêmî","Têkoşîna me"]),
  (id:"c2_718", ku:"Hiqûqa kolektîf a Kurdan", tr:"Kürtlerin kolektif hukuku", en:"Collective law of Kurds", cins:"mê", ez:"hiqûqa kolektîf a Kurdan", kat:"siyaset", zor:0.44, not:"\"Hiqûq\"+\"kolektîf\"+\"Kurdan\".", her:["Hiqûqa kolektîf a Kurdan.","Di hiqûqa kolektîf a Kurdan de."], gen:["Hiqûqa kolektîf a Kurdan","Hiqûqa me"]),
  (id:"c2_719", ku:"Medyaya alternatîf a kurdî", tr:"Kürt alternatif medyası", en:"Kurdish alternative media", cins:"mê", ez:"medyaya alternatîf a kurdî", kat:"medya", zor:0.46, not:"\"Medya\"+\"alternatîf\"+\"kurdî\". Bağımsız Kürt medyası.", her:["Medyaya alternatîf a kurdî.","Di medyaya alternatîf a kurdî de."], gen:["Medyaya alternatîf a kurdî","Medyaya me"]),
  (id:"c2_720", ku:"Têkiliya edebiyat û hêzê", tr:"Edebiyat ve güç ilişkisi", en:"Literature-power relation", cins:"mê", ez:"têkiliya edebiyat û hêzê", kat:"edebiyat", zor:0.43, not:"\"Têkilî\"+\"edebiyat û hêz\". Siyasal edebiyat.", her:["Têkiliya edebiyat û hêzê.","Di têkiliya edebiyat û hêzê de."], gen:["Têkiliya edebiyat û hêzê","Têkiliya me"]),
  (id:"c2_721", ku:"Agahdariya kûr a medyayê", tr:"Derinlemesine medya haberciliği", en:"In-depth media reporting", cins:"mê", ez:"agahdariya kûr a medyayê", kat:"medya", zor:0.45, not:"\"Agahdarî\"+\"kûr\"+\"medya\". Araştırmacı gazetecilik.", her:["Agahdariya kûr a medyayê.","Di agahdariya kûr a medyayê de."], gen:["Agahdariya kûr a medyayê","Agahdariya me"]),
  (id:"c2_722", ku:"Xweza zimên a siyasî", tr:"Dilin siyasal doğası", en:"Political nature of language", cins:"mê", ez:"xweza zimên a siyasî", kat:"ziman", zor:0.43, not:"\"Xweza\"+\"zimên\"+\"siyasî\". Dil her zaman siyasaldır.", her:["Xweza zimên a siyasî.","Di xweza zimên a siyasî de."], gen:["Xweza zimên a siyasî","Xweza zimên"]),
  (id:"c2_723", ku:"Pêvajoya wergera çandî", tr:"Kültürel çeviri süreci", en:"Cultural translation process", cins:"mê", ez:"pêvajoya wergera çandî", kat:"çand", zor:0.44, not:"\"Pêvajo\"+\"werger\"+\"çandî\". Kavramların kültürel aktarımı.", her:["Pêvajoya wergera çandî.","Di pêvajoya wergera çandî de."], gen:["Pêvajoya wergera çandî","Pêvajoya me"]),
  (id:"c2_724", ku:"Di encamê de dikare bê gotin ku", tr:"Sonuç olarak şunu söylemek mümkün", en:"In conclusion it can be said that", cins:"bêcins", ez:null, kat:"daçek", zor:0.46, not:"C2 akademik söylem kapanışı.", her:["Di encamê de dikare bê gotin ku...","Di encamê de..."], gen:["Di encamê de dikare bê gotin ku","Di encamê de"]),
  (id:"c2_725", ku:"Li gorî nêrîna... em dikarin bibêjin", tr:"... görüşüne göre şunu söyleyebiliriz", en:"According to the view of..., we can say", cins:"bêcins", ez:null, kat:"daçek", zor:0.45, not:"C2 akademik atıf kalıbı.", her:["Li gorî nêrîna Foucault em dikarin bibêjin.","Li gorî nêrîna me..."], gen:["Li gorî nêrîna... em dikarin bibêjin","Li gorî nêrîna me"]),
];


final kC2_Son9 = [
  (id:"c2_800", ku:"Rêzika nêrînê ya rêkûpêk", tr:"Tutarlı argümantasyon zinciri", en:"Coherent chain of argumentation", cins:"mê", ez:"rêzika nêrînê ya rêkûpêk", kat:"akademik", zor:0.42, not:"\"Rêzik\"+\"nêrîn\"+\"rêkûpêk\". Deduktif akıl yürütme.", her:["Rêzika nêrînê ya rêkûpêk.","Di rêzika nêrînê ya rêkûpêk de."], gen:["Rêzika nêrînê ya rêkûpêk","Rêzika me"]),
  (id:"c2_801", ku:"Biyografîya zimanzanekî kurd", tr:"Bir Kürt dilbilimcinin biyografisi", en:"Biography of a Kurdish linguist", cins:"mê", ez:"biyografîya zimanzanekî kurd", kat:"edebiyat", zor:0.45, not:"\"Biyografî\"+\"zimanzanekî kurd\".", her:["Biyografîya zimanzanekî kurd.","Di biyografîya zimanzanekî kurd de."], gen:["Biyografîya zimanzanekî kurd","Biyografîya me"]),
  (id:"c2_802", ku:"Ziman û hebûna civakî", tr:"Dil ve toplumsal varoluş", en:"Language and social existence", cins:"bêcins", ez:null, kat:"ziman", zor:0.42, not:"\"Ziman\"+\"hebûn\"+\"civakî\". Vygotsky sosyal biliş.", her:["Ziman û hebûna civakî.","Di ziman û hebûna civakî de."], gen:["Ziman û hebûna civakî","Zimanê me"]),
  (id:"c2_803", ku:"Têkoşîna nasnameya nûjen", tr:"Modern kimlik mücadelesi", en:"Contemporary identity struggle", cins:"mê", ez:"têkoşîna nasnameya nûjen", kat:"kimlik", zor:0.45, not:"\"Têkoşîn\"+\"nasname\"+\"nûjen\".", her:["Têkoşîna nasnameya nûjen.","Di têkoşîna nasnameya nûjen de."], gen:["Têkoşîna nasnameya nûjen","Têkoşîna me"]),
  (id:"c2_804", ku:"Têgîhîştina etnografîk", tr:"Etnografik anlayış", en:"Ethnographic understanding", cins:"mê", ez:"têgîhîştina etnografîk", kat:"akademik", zor:0.42, not:"\"Têgîhîştin\"+\"etnografîk\". Katılımcı gözlem.", her:["Têgîhîştina etnografîk.","Di têgîhîştina etnografîk de."], gen:["Têgîhîştina etnografîk","Têgîhîştina me"]),
  (id:"c2_805", ku:"Nexşeya dîroka zimanî", tr:"Dilsel tarih haritası", en:"Map of linguistic history", cins:"mê", ez:"nexşeya dîroka zimanî", kat:"ziman", zor:0.43, not:"\"Nexşe\"+\"dîrok\"+\"zimanî\". Diyakronik dilbilim.", her:["Nexşeya dîroka zimanî.","Di nexşeya dîroka zimanî de."], gen:["Nexşeya dîroka zimanî","Nexşeya me"]),
  (id:"c2_806", ku:"Xweşbûna zimanzaniyê ya C2", tr:"C2 dilbilim yetkinliği", en:"C2 linguistic competence", cins:"mê", ez:"xweşbûna zimanzaniyê ya C2", kat:"ziman", zor:0.43, not:"\"Xweşbûn\"+\"zimanzanî\"+\"C2\". Üst düzey dil bilgisi.", her:["Xweşbûna zimanzaniyê ya C2.","Di xweşbûna zimanzaniyê ya C2 de."], gen:["Xweşbûna zimanzaniyê ya C2","Xweşbûna me"]),
  (id:"c2_807", ku:"Têkiliya dîrokî ya nav çandan", tr:"Kültürler arası tarihsel ilişki", en:"Historical intercultural relation", cins:"mê", ez:"têkiliya dîrokî ya nav çandan", kat:"çand", zor:0.44, not:"\"Têkilî\"+\"dîrokî\"+\"nav çandan\".", her:["Têkiliya dîrokî ya nav çandan.","Di têkiliya dîrokî ya nav çandan de."], gen:["Têkiliya dîrokî ya nav çandan","Têkiliya me"]),
  (id:"c2_808", ku:"Daxwaza nas bûnê", tr:"Tanınma talebi", en:"Demand for recognition", cins:"mê", ez:"daxwaza nas bûnê", kat:"felsefe", zor:0.44, not:"Honneth'in tanınma teorisi — Kürt kimliği bağlamında.", her:["Daxwaza nas bûnê.","Di daxwaza nas bûnê de."], gen:["Daxwaza nas bûnê","Daxwaza me"]),
];

final kC2Temam = [...kC2_Son9];
