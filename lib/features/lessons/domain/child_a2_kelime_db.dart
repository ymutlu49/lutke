/// LÛTKE ZAROK — A2 Çocuk Kelime Veritabanı
///
/// 7-10 yaş grubu, A1'den sonraki ilerleme.
/// Daha karmaşık kavramlar: duygular, doğa, zaman, fiiller.

// ignore_for_file: constant_identifier_names

const kChildA2Kelimeler = [

  // ════════════════════════════════════════════════════════════
  // BİRİM 1 — Laşê min (Vücudum)
  // ════════════════════════════════════════════════════════════

  (id:'z_a2_001', ku:'Ser', tr:'Baş/Kafa', en:'Head', cins:'nêr', ez:'serê',
   kat:'las', zor:0.82, not:'Vücut', emoji: '🧠',
   her:['Serê min diêşe.', 'Dest bide ser!'], gen:['Ser — baş', 'Serê min.']),

  (id:'z_a2_002', ku:'Çav', tr:'Göz', en:'Eye', cins:'nêr', ez:'çavê',
   kat:'las', zor:0.82, not:'Çift organ', emoji: '👁️',
   her:['Çavên min reş in.', 'Çavên dapîrê şîn in.'], gen:['Çav — göz', 'Du çav.']),

  (id:'z_a2_003', ku:'Guh', tr:'Kulak', en:'Ear', cins:'nêr', ez:'guhê',
   kat:'las', zor:0.80, not:'Çift organ', emoji: '👂',
   her:['Guhên xwe veke!', 'Bi guhên xwe guhdarî bike.'], gen:['Guh — kulak', 'Du guh.']),

  (id:'z_a2_004', ku:'Dev', tr:'Ağız', en:'Mouth', cins:'nêr', ez:'devê',
   kat:'las', zor:0.80, not:'Vücut', emoji: '👄',
   her:['Devê xwe veke!', 'Dev — xwarin tê de ye.'], gen:['Dev — ağız', 'Dev mezin e.']),

  (id:'z_a2_005', ku:'Dest', tr:'El', en:'Hand', cins:'nêr', ez:'destê',
   kat:'las', zor:0.85, not:'Çift organ', emoji: '✋',
   her:['Destên xwe bişo!', 'Pênc tiliyên destê min.'], gen:['Dest — el', 'Du dest.']),

  (id:'z_a2_006', ku:'Pê', tr:'Ayak', en:'Foot', cins:'nêr', ez:'piyê',
   kat:'las', zor:0.82, not:'Çift organ', emoji: '🦶',
   her:['Piyên min sar in.', 'Bi pê bimeşe.'], gen:['Pê — ayak', 'Du pê.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 2 — Hest û Rewş (Duygular ve Haller)
  // ════════════════════════════════════════════════════════════

  (id:'z_a2_010', ku:'Kêfxweş', tr:'Mutlu', en:'Happy', cins:'bêcins', ez:null,
   kat:'hest', zor:0.78, not:'Duygu', emoji: '😊',
   her:['Ez kêfxweş im!', 'Dê kêfxweş e.'], gen:['Kêfxweş — mutlu', 'Ez kêfxweş im.']),

  (id:'z_a2_011', ku:'Xemgîn', tr:'Üzgün', en:'Sad', cins:'bêcins', ez:null,
   kat:'hest', zor:0.75, not:'Duygu', emoji: '😢',
   her:['Ez xemgîn im.', 'Xwişk xemgîn e.'], gen:['Xemgîn — üzgün', 'Tu xemgîn î?']),

  (id:'z_a2_012', ku:'Birçî', tr:'Aç', en:'Hungry', cins:'bêcins', ez:null,
   kat:'hest', zor:0.82, not:'Temel ihtiyaç', emoji: '😋',
   her:['Ez birçî me!', 'Dê, ez birçî me.'], gen:['Birçî — aç', 'Tu birçî yî?']),

  (id:'z_a2_013', ku:'Tî', tr:'Susuz', en:'Thirsty', cins:'bêcins', ez:null,
   kat:'hest', zor:0.82, not:'Temel ihtiyaç', emoji: '🥤',
   her:['Ez tî me!', 'Bav, ez tî me.'], gen:['Tî — susuz', 'Tu tî yî?']),

  (id:'z_a2_014', ku:'Xew', tr:'Uyku', en:'Sleep', cins:'mê', ez:'xewa',
   kat:'hest', zor:0.80, not:'Temel ihtiyaç', emoji: '😴',
   her:['Xewa min tê.', 'Dê, ez dixwazim razêm.'], gen:['Xew — uyku', 'Xew xweş e.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 3 — Xweza (Doğa)
  // ════════════════════════════════════════════════════════════

  (id:'z_a2_020', ku:'Roj', tr:'Güneş/Gün', en:'Sun/Day', cins:'mê', ez:'roja',
   kat:'xweza', zor:0.85, not:'Doğa', emoji: '☀️',
   her:['Roj li ezmanan e.', 'Roja baş!'], gen:['Roj — güneş', 'Roj zer e.']),

  (id:'z_a2_021', ku:'Heyv', tr:'Ay', en:'Moon', cins:'mê', ez:'heyva',
   kat:'xweza', zor:0.80, not:'Gece gökyüzü', emoji: '🌙',
   her:['Heyv li ezmanan e.', 'Heyv spî ye.'], gen:['Heyv — ay', 'Heyva tije.']),

  (id:'z_a2_022', ku:'Stêr', tr:'Yıldız', en:'Star', cins:'mê', ez:'stêra',
   kat:'xweza', zor:0.82, not:'Gece gökyüzü', emoji: '⭐',
   her:['Stêr li ezmanan in.', 'Stêrên gelek xweş in.'], gen:['Stêr — yıldız', 'Stêr dibiriqin.']),

  (id:'z_a2_023', ku:'Av', tr:'Su', en:'Water', cins:'mê', ez:'ava',
   kat:'xweza', zor:0.88, not:'Doğa elementi', emoji: '🌊',
   her:['Av di çem de diherike.', 'Ava sar.'], gen:['Av — su', 'Av paqij e.']),

  (id:'z_a2_024', ku:'Dar', tr:'Ağaç', en:'Tree', cins:'mê', ez:'dara',
   kat:'xweza', zor:0.82, not:'Doğa', emoji: '🌳',
   her:['Dar mezin e.', 'Çûk li darê ye.'], gen:['Dar — ağaç', 'Dara kesk.']),

  (id:'z_a2_025', ku:'Gul', tr:'Çiçek/Gül', en:'Flower/Rose', cins:'mê', ez:'gula',
   kat:'xweza', zor:0.82, not:'Doğa', emoji: '🌹',
   her:['Gul sor e.', 'Gulên xweş.'], gen:['Gul — çiçek', 'Gula sor.']),

  (id:'z_a2_026', ku:'Berf', tr:'Kar', en:'Snow', cins:'nêr', ez:'berfê',
   kat:'xweza', zor:0.80, not:'Mevsim', emoji: '❄️',
   her:['Berf dibare!', 'Em bi berfê dilîzin.'], gen:['Berf — kar', 'Berf spî ye.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 4 — Temel Fiiller
  // ════════════════════════════════════════════════════════════

  (id:'z_a2_030', ku:'Xwarin', tr:'Yemek', en:'To eat', cins:'bêcins', ez:null,
   kat:'fiil', zor:0.78, not:'Temel fiil', emoji: '🍽️',
   her:['Ez dixwim.', 'Em xwarin dixwin.'], gen:['Xwarin — yemek', 'Ez sêv dixwim.']),

  (id:'z_a2_031', ku:'Vexwarin', tr:'İçmek', en:'To drink', cins:'bêcins', ez:null,
   kat:'fiil', zor:0.75, not:'Temel fiil', emoji: '🥤',
   her:['Ez av vedixwim.', 'Bira şîr vedixwe.'], gen:['Vexwarin — içmek', 'Ez çay vedixwim.']),

  (id:'z_a2_032', ku:'Lîstin', tr:'Oynamak', en:'To play', cins:'bêcins', ez:null,
   kat:'fiil', zor:0.82, not:'Çocuk fiili', emoji: '🎮',
   her:['Em dilîzin!', 'Ez bi xwişka xwe re dilîzim.'], gen:['Lîstin — oynamak', 'Em dilîzin.']),

  (id:'z_a2_033', ku:'Xwendin', tr:'Okumak', en:'To read', cins:'bêcins', ez:null,
   kat:'fiil', zor:0.75, not:'Eğitim fiili', emoji: '📖',
   her:['Ez dixwînim.', 'Dê pirtûk dixwîne.'], gen:['Xwendin — okumak', 'Ez pirtûk dixwînim.']),

  (id:'z_a2_034', ku:'Nivîsandin', tr:'Yazmak', en:'To write', cins:'bêcins', ez:null,
   kat:'fiil', zor:0.72, not:'Eğitim fiili', emoji: '✍️',
   her:['Ez dinivîsim.', 'Bi Kurmancî binivîse.'], gen:['Nivîsandin — yazmak', 'Ez dinivîsim.']),

  (id:'z_a2_035', ku:'Hatin', tr:'Gelmek', en:'To come', cins:'bêcins', ez:null,
   kat:'fiil', zor:0.75, not:'Hareket fiili', emoji: '🏃',
   her:['Were vir!', 'Bira, were em bilîzin!'], gen:['Hatin — gelmek', 'Were!']),

  (id:'z_a2_036', ku:'Çûn', tr:'Gitmek', en:'To go', cins:'bêcins', ez:null,
   kat:'fiil', zor:0.78, not:'Hareket fiili', emoji: '🚶',
   her:['Ez diçim mektebê.', 'Em diçin parkê.'], gen:['Çûn — gitmek', 'Ez diçim.']),
];
