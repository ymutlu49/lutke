/// LÛTKE ZAROK — A1 Çocuk Kelime Veritabanı
///
/// 7-10 yaş grubu için seçilmiş temel kelimeler.
/// Çocuğun günlük hayatından tanıdığı kavramlar.
/// Her kelime emoji ile desteklenir (görsel öğrenme).
///
/// Kategoriler:
///   - selamlama: Temel selamlaşma
///   - malbat: Aile üyeleri
///   - heywan: Hayvanlar
///   - reng: Renkler
///   - hejmar: Sayılar (1-20)
///   - xwarin: Yiyecek ve içecek
///   - las: Vücut
///   - dibistan: Okul
///   - listik: Oyun ve oyuncak

// ignore_for_file: constant_identifier_names

const kChildA1Kelimeler = [

  // ════════════════════════════════════════════════════════════
  // BİRİM 1 — Silav! (Merhaba!)
  // ════════════════════════════════════════════════════════════

  (id:'z_a1_001', ku:'Silav', tr:'Merhaba', en:'Hello', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.90, not:'En kolay kelime — her yerde kullanılır',
   emoji: '👋',
   her:['Silav, dapîrê!', 'Silav, dê!'],
   gen:['Silav, heval!', 'Silav!']),

  (id:'z_a1_002', ku:'Spas', tr:'Teşekkür', en:'Thanks', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.88, not:'Kibarlık — çocuklara ilk öğretilen',
   emoji: '🙏',
   her:['Spas, dê!', 'Spas ji te re!'],
   gen:['Spas dikim', 'Gelek spas']),

  (id:'z_a1_003', ku:'Erê', tr:'Evet', en:'Yes', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.92, not:'En temel yanıt',
   emoji: '✅',
   her:['Erê, dê!', 'Erê, ez dixwazim.'],
   gen:['Erê', 'Erê, spas']),

  (id:'z_a1_004', ku:'Na', tr:'Hayır', en:'No', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.92, not:'En temel ret',
   emoji: '❌',
   her:['Na, ez naxwazim.', 'Na, spas.'],
   gen:['Na', 'Na, spas']),

  (id:'z_a1_005', ku:'Bi xêr hatî', tr:'Hoş geldin', en:'Welcome', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.82, not:'Misafir karşılama',
   emoji: '🏠',
   her:['Bi xêr hatî, ap!', 'Bi xêr hatî malê!'],
   gen:['Bi xêr hatî!', 'Bi xêr hatî mektebê!']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 2 — Malbata min (Ailem)
  // ════════════════════════════════════════════════════════════

  (id:'z_a1_010', ku:'Dê', tr:'Anne', en:'Mother', cins:'mê', ez:'dêya',
   kat:'malbat', zor:0.88, not:'En temel aile kelimesi',
   emoji: '👩',
   her:['Dêya min çêtirîn e!', 'Ez dêya xwe hez dikim.'],
   gen:['Dê — dayik', 'Dêya min navê wê Leyla ye.']),

  (id:'z_a1_011', ku:'Bav', tr:'Baba', en:'Father', cins:'nêr', ez:'bavê',
   kat:'malbat', zor:0.88, not:'En temel aile kelimesi',
   emoji: '👨',
   her:['Bavê min bi min re dilîze.', 'Bav li malê ye.'],
   gen:['Bav — baba', 'Bavê min mamoste ye.']),

  (id:'z_a1_012', ku:'Xwişk', tr:'Kız kardeş', en:'Sister', cins:'mê', ez:'xwişka',
   kat:'malbat', zor:0.80, not:'Kız kardeş — büyük veya küçük',
   emoji: '👧',
   her:['Xwişka min biçûk e.', 'Ez bi xwişka xwe re dilîzim.'],
   gen:['Xwişk — hemşire', 'Xwişka min 5 salî ye.']),

  (id:'z_a1_013', ku:'Bira', tr:'Erkek kardeş', en:'Brother', cins:'nêr', ez:'birayê',
   kat:'malbat', zor:0.80, not:'Erkek kardeş',
   emoji: '👦',
   her:['Birayê min mezin e.', 'Bira, were em bilîzin!'],
   gen:['Bira — birader', 'Birayê min 8 salî ye.']),

  (id:'z_a1_014', ku:'Dapîr', tr:'Büyükanne', en:'Grandmother', cins:'mê', ez:'dapîra',
   kat:'malbat', zor:0.82, not:'Anneanne/Babaanne — ikisi için de kullanılır',
   emoji: '👵',
   her:['Dapîra min çîrok vedibêje.', 'Ez diçim cem dapîrê.'],
   gen:['Dapîr — büyükanne', 'Dapîra min nan çêdike.']),

  (id:'z_a1_015', ku:'Bapîr', tr:'Büyükbaba', en:'Grandfather', cins:'nêr', ez:'bapîrê',
   kat:'malbat', zor:0.82, not:'Dede — her iki taraf için',
   emoji: '👴',
   her:['Bapîrê min çîrok vedibêje.', 'Bapîr, tu çawa yî?'],
   gen:['Bapîr — dede', 'Bapîrê min li gund dijî.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 3 — Rengên min (Renklerim)
  // ════════════════════════════════════════════════════════════

  (id:'z_a1_020', ku:'Sor', tr:'Kırmızı', en:'Red', cins:'bêcins', ez:null,
   kat:'reng', zor:0.85, not:'Temel renk',
   emoji: '🔴',
   her:['Sêva sor xweş e.', 'Kinca min sor e.'],
   gen:['Sor — kırmızı', 'Gul sor e.']),

  (id:'z_a1_021', ku:'Kesk', tr:'Yeşil', en:'Green', cins:'bêcins', ez:null,
   kat:'reng', zor:0.85, not:'Kürdistan bayrağının rengi',
   emoji: '🟢',
   her:['Dar kesk e.', 'Çiya kesk e.'],
   gen:['Kesk — yeşil', 'Giya kesk e.']),

  (id:'z_a1_022', ku:'Zer', tr:'Sarı', en:'Yellow', cins:'bêcins', ez:null,
   kat:'reng', zor:0.85, not:'Güneş rengi',
   emoji: '🟡',
   her:['Roj zer e.', 'Gulên zer xweş in.'],
   gen:['Zer — sarı', 'Roj zer e.']),

  (id:'z_a1_023', ku:'Şîn', tr:'Mavi', en:'Blue', cins:'bêcins', ez:null,
   kat:'reng', zor:0.82, not:'Gökyüzü rengi',
   emoji: '🔵',
   her:['Ezman şîn e.', 'Çavên dapîrê şîn in.'],
   gen:['Şîn — mavi (ve yeşil)', 'Ezman şîn e.']),

  (id:'z_a1_024', ku:'Spî', tr:'Beyaz', en:'White', cins:'bêcins', ez:null,
   kat:'reng', zor:0.85, not:'Kar rengi',
   emoji: '⚪',
   her:['Berf spî ye.', 'Pisîka spî xweş e.'],
   gen:['Spî — beyaz', 'Berf spî ye.']),

  (id:'z_a1_025', ku:'Reş', tr:'Siyah', en:'Black', cins:'bêcins', ez:null,
   kat:'reng', zor:0.85, not:'Gece rengi',
   emoji: '⚫',
   her:['Segê reş mezin e.', 'Şev reş e.'],
   gen:['Reş — siyah', 'Pisîka reş.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 4 — Heywanên malê (Hayvanlar)
  // ════════════════════════════════════════════════════════════

  (id:'z_a1_030', ku:'Pisîk', tr:'Kedi', en:'Cat', cins:'mê', ez:'pisîka',
   kat:'heywan', zor:0.85, not:'Evcil hayvan',
   emoji: '🐱',
   her:['Pisîka me biçûk e.', 'Pisîk ronî ye.'],
   gen:['Pisîk — kedi', 'Pisîka spî xweş e.']),

  (id:'z_a1_031', ku:'Seg', tr:'Köpek', en:'Dog', cins:'nêr', ez:'segê',
   kat:'heywan', zor:0.85, not:'Evcil hayvan',
   emoji: '🐕',
   her:['Segê me mezin e.', 'Seg bi min re dilîze.'],
   gen:['Seg — köpek', 'Seg waw dike.']),

  (id:'z_a1_032', ku:'Mirîşk', tr:'Tavuk', en:'Chicken', cins:'mê', ez:'mirîşka',
   kat:'heywan', zor:0.78, not:'Köy hayvanı',
   emoji: '🐔',
   her:['Mirîşk hêk dide.', 'Li hewşê mirîşk heye.'],
   gen:['Mirîşk — tavuk', 'Mirîşk hêk dide.']),

  (id:'z_a1_033', ku:'Karîk', tr:'Oğlak', en:'Kid (baby goat)', cins:'nêr', ez:'karîkê',
   kat:'heywan', zor:0.80, not:'Karok — maskotê me!',
   emoji: '🐐',
   her:['Karîk li çiyê ye.', 'Karîk dilîze.'],
   gen:['Karîk — oğlak', 'Karok karîkek e!']),

  (id:'z_a1_034', ku:'Çûk', tr:'Kuş', en:'Bird', cins:'mê', ez:'çûka',
   kat:'heywan', zor:0.82, not:'Genel kuş',
   emoji: '🐦',
   her:['Çûk distire.', 'Çûk difirin.'],
   gen:['Çûk — kuş', 'Çûk li darê ye.']),

  (id:'z_a1_035', ku:'Masî', tr:'Balık', en:'Fish', cins:'nêr', ez:'masiyê',
   kat:'heywan', zor:0.80, not:'Su hayvanı',
   emoji: '🐟',
   her:['Masî di avê de ye.', 'Em masî dixwin.'],
   gen:['Masî — balık', 'Masî di golê de ye.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 5 — Em dixwin! (Yiyecek & İçecek)
  // ════════════════════════════════════════════════════════════

  (id:'z_a1_040', ku:'Nan', tr:'Ekmek', en:'Bread', cins:'nêr', ez:'nanê',
   kat:'xwarin', zor:0.88, not:'Temel besin',
   emoji: '🍞',
   her:['Dê nan çêdike.', 'Nanê germ xweş e.'],
   gen:['Nan — ekmek', 'Nan di firnê de ye.']),

  (id:'z_a1_041', ku:'Av', tr:'Su', en:'Water', cins:'mê', ez:'ava',
   kat:'xwarin', zor:0.90, not:'Temel içecek',
   emoji: '💧',
   her:['Ez av vedixwim.', 'Ava sar xweş e.'],
   gen:['Av — su', 'Ez dixwazim av.']),

  (id:'z_a1_042', ku:'Şîr', tr:'Süt', en:'Milk', cins:'nêr', ez:'şîrê',
   kat:'xwarin', zor:0.85, not:'Çocuklar için önemli',
   emoji: '🥛',
   her:['Dê şîr dide min.', 'Şîrê germ xweş e.'],
   gen:['Şîr — süt', 'Ez şîr vedixwim.']),

  (id:'z_a1_043', ku:'Sêv', tr:'Elma', en:'Apple', cins:'mê', ez:'sêva',
   kat:'xwarin', zor:0.85, not:'Meyve',
   emoji: '🍎',
   her:['Sêva sor xweş e.', 'Dapîr sêv dide min.'],
   gen:['Sêv — elma', 'Sêv sor e.']),

  (id:'z_a1_044', ku:'Tirî', tr:'Üzüm', en:'Grape', cins:'nêr', ez:'tiriyê',
   kat:'xwarin', zor:0.80, not:'Meyve',
   emoji: '🍇',
   her:['Tirî şîrîn e.', 'Em tirî dixwin.'],
   gen:['Tirî — üzüm', 'Tirî şîrîn e.']),

  (id:'z_a1_045', ku:'Penîr', tr:'Peynir', en:'Cheese', cins:'nêr', ez:'penîrê',
   kat:'xwarin', zor:0.82, not:'Kahvaltı yiyeceği',
   emoji: '🧀',
   her:['Nanê bi penîr xweş e.', 'Bav penîr dixwe.'],
   gen:['Penîr — peynir', 'Penîr spî ye.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 6 — Hejmar (Sayılar 1-10)
  // ════════════════════════════════════════════════════════════

  (id:'z_a1_050', ku:'Yek', tr:'Bir', en:'One', cins:'bêcins', ez:null,
   kat:'hejmar', zor:0.90, not:'1', emoji: '1️⃣',
   her:['Yek sêv', 'Yek bira min heye.'], gen:['Yek — 1', 'Yek, du, sê...']),

  (id:'z_a1_051', ku:'Du', tr:'İki', en:'Two', cins:'bêcins', ez:null,
   kat:'hejmar', zor:0.90, not:'2', emoji: '2️⃣',
   her:['Du xwişk', 'Du çav hene min.'], gen:['Du — 2', 'Du dest hene min.']),

  (id:'z_a1_052', ku:'Sê', tr:'Üç', en:'Three', cins:'bêcins', ez:null,
   kat:'hejmar', zor:0.88, not:'3', emoji: '3️⃣',
   her:['Sê pisîk', 'Sê sêv hene.'], gen:['Sê — 3', 'Sê reng.']),

  (id:'z_a1_053', ku:'Çar', tr:'Dört', en:'Four', cins:'bêcins', ez:null,
   kat:'hejmar', zor:0.85, not:'4', emoji: '4️⃣',
   her:['Çar lingên seg', 'Çar demsalên salê.'], gen:['Çar — 4', 'Çar lingên pisîkê.']),

  (id:'z_a1_054', ku:'Pênc', tr:'Beş', en:'Five', cins:'bêcins', ez:null,
   kat:'hejmar', zor:0.85, not:'5', emoji: '5️⃣',
   her:['Pênc tiliyên destê min.', 'Pênc sêv.'], gen:['Pênc — 5', 'Pênc tilî.']),

  (id:'z_a1_055', ku:'Şeş', tr:'Altı', en:'Six', cins:'bêcins', ez:null,
   kat:'hejmar', zor:0.82, not:'6', emoji: '6️⃣',
   her:['Şeş mirîşk.', 'Ez şeş salî me.'], gen:['Şeş — 6', 'Şeş roj.']),

  (id:'z_a1_056', ku:'Heft', tr:'Yedi', en:'Seven', cins:'bêcins', ez:null,
   kat:'hejmar', zor:0.82, not:'7', emoji: '7️⃣',
   her:['Heft rojên hefteyê.', 'Heft stêrk.'], gen:['Heft — 7', 'Heft roj.']),

  (id:'z_a1_057', ku:'Heşt', tr:'Sekiz', en:'Eight', cins:'bêcins', ez:null,
   kat:'hejmar', zor:0.78, not:'8', emoji: '8️⃣',
   her:['Heşt tilî.', 'Ez heşt salî me.'], gen:['Heşt — 8', 'Heşt reng.']),

  (id:'z_a1_058', ku:'Neh', tr:'Dokuz', en:'Nine', cins:'bêcins', ez:null,
   kat:'hejmar', zor:0.78, not:'9', emoji: '9️⃣',
   her:['Neh sêv.', 'Neh mirîşk.'], gen:['Neh — 9', 'Neh seg.']),

  (id:'z_a1_059', ku:'Deh', tr:'On', en:'Ten', cins:'bêcins', ez:null,
   kat:'hejmar', zor:0.82, not:'10', emoji: '🔟',
   her:['Deh tiliyên du destan.', 'Deh hejmar.'], gen:['Deh — 10', 'Deh tilî.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 7 — Li dibistanê (Okulda)
  // ════════════════════════════════════════════════════════════

  (id:'z_a1_060', ku:'Pirtûk', tr:'Kitap', en:'Book', cins:'mê', ez:'pirtûka',
   kat:'dibistan', zor:0.82, not:'Okul malzemesi',
   emoji: '📚',
   her:['Pirtûka min nû ye.', 'Ez pirtûk dixwînim.'],
   gen:['Pirtûk — kitap', 'Pirtûka Kurmancî.']),

  (id:'z_a1_061', ku:'Qelem', tr:'Kalem', en:'Pen', cins:'mê', ez:'qelema',
   kat:'dibistan', zor:0.80, not:'Okul malzemesi',
   emoji: '✏️',
   her:['Qelema min sor e.', 'Bi qelemê binivîse.'],
   gen:['Qelem — kalem', 'Qelem sor e.']),

  (id:'z_a1_062', ku:'Mamoste', tr:'Öğretmen', en:'Teacher', cins:'bêcins', ez:'mamosteyê',
   kat:'dibistan', zor:0.78, not:'Okul — saygı figürü',
   emoji: '👩‍🏫',
   her:['Mamoste baş e.', 'Mamosteyê me Kurmancî hîn dike.'],
   gen:['Mamoste — öğretmen', 'Mamoste ji me re dibêje.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 8 — Lîstik! (Oyun!)
  // ════════════════════════════════════════════════════════════

  (id:'z_a1_070', ku:'Top', tr:'Top', en:'Ball', cins:'nêr', ez:'topê',
   kat:'listik', zor:0.88, not:'Oyuncak',
   emoji: '⚽',
   her:['Em bi topê dilîzin.', 'Topê sor e.'],
   gen:['Top — top', 'Topê mezin e.']),

  (id:'z_a1_071', ku:'Lîstik', tr:'Oyun', en:'Game', cins:'mê', ez:'lîstika',
   kat:'listik', zor:0.82, not:'Genel oyun',
   emoji: '🎮',
   her:['Em lîstikê dikin.', 'Lîstik xweş e!'],
   gen:['Lîstik — oyun', 'Lîstika nû.']),

  (id:'z_a1_072', ku:'Gogik', tr:'Bebek (oyuncak)', en:'Doll', cins:'mê', ez:'gogika',
   kat:'listik', zor:0.78, not:'Oyuncak bebek',
   emoji: '🧸',
   her:['Gogika min xweş e.', 'Xwişk bi gogikê dilîze.'],
   gen:['Gogik — bebek oyuncak', 'Gogika spî.']),

  // ════════════════════════════════════════════════════════════
  // EK KELİMELER — Kategorileri 12'ye tamamlama
  // ════════════════════════════════════════════════════════════

  // ── Silav (Selamlama) ek ─────────────────────────────────
  (id:'z_a1_080', ku:'Çawa yî?', tr:'Nasılsın?', en:'How are you?', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.88, not:'Hal hatır sorma', emoji:'😊',
   her:['Silav! Çawa yî?', 'Dê, tu çawa yî?'],
   gen:['Çawa yî? — Nasılsın?', 'Tu çawa yî, heval?']),

  (id:'z_a1_081', ku:'Baş im', tr:'İyiyim', en:'I am fine', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.88, not:'Cevap', emoji:'😄',
   her:['Baş im, spas!', 'Ez baş im, tu çawa yî?'],
   gen:['Baş im — İyiyim', 'Spas, ez baş im.']),

  (id:'z_a1_082', ku:'Oxir be', tr:'Güle güle', en:'Goodbye', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.85, not:'Vedalaşma', emoji:'👋',
   her:['Oxir be, dapîrê!', 'Oxir be, heval!'],
   gen:['Oxir be — Güle güle', 'Oxir be, sibê dibînim te.']),

  (id:'z_a1_083', ku:'Rojbaş', tr:'İyi günler', en:'Good day', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.85, not:'Gündüz selamı', emoji:'☀️',
   her:['Rojbaş, mamoste!', 'Rojbaş, ap!'],
   gen:['Rojbaş — İyi günler', 'Rojbaş, çawa yî?']),

  (id:'z_a1_084', ku:'Şevbaş', tr:'İyi geceler', en:'Good night', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.85, not:'Gece selamı', emoji:'🌙',
   her:['Şevbaş, dê!', 'Şevbaş, razê!'],
   gen:['Şevbaş — İyi geceler', 'Şevbaş, xewna xweş!']),

  (id:'z_a1_085', ku:'Keremke', tr:'Buyurun/Rica ederim', en:'Please/You are welcome', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.82, not:'Kibarlık', emoji:'🙂',
   her:['Keremke, rûne!', 'Keremke, nan bixwe!'],
   gen:['Keremke — Buyurun', 'Keremke, çay vexwe.']),

  (id:'z_a1_086', ku:'Biborin', tr:'Özür dilerim', en:'Sorry', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.82, not:'Özür', emoji:'😔',
   her:['Biborin, dê!', 'Biborin, min xelet kir.'],
   gen:['Biborin — Özür dilerim', 'Biborin, ez dereng mam.']),

  // ── Dibistan (Okul) ek ──────────────────────────────────
  (id:'z_a1_090', ku:'Ders', tr:'Ders', en:'Lesson', cins:'mê', ez:'dersa',
   kat:'dibistan', zor:0.82, not:'Okul', emoji:'📝',
   her:['Ders dest pê kir.', 'Dersa me xweş e.'],
   gen:['Ders — ders', 'Dersa Kurmancî.']),

  (id:'z_a1_091', ku:'Defter', tr:'Defter', en:'Notebook', cins:'mê', ez:'deftera',
   kat:'dibistan', zor:0.80, not:'Okul malzemesi', emoji:'📓',
   her:['Deftera min nû ye.', 'Di defterê de binivîse.'],
   gen:['Defter — defter', 'Deftera sor.']),

  (id:'z_a1_092', ku:'Xwendekar', tr:'Öğrenci', en:'Student', cins:'bêcins', ez:'xwendekarê',
   kat:'dibistan', zor:0.78, not:'Okul', emoji:'🧑‍🎓',
   her:['Ez xwendekar im.', 'Xwendekar li polê ne.'],
   gen:['Xwendekar — öğrenci', 'Xwendekarên baş.']),

  (id:'z_a1_093', ku:'Pol', tr:'Sınıf', en:'Classroom', cins:'mê', ez:'pola',
   kat:'dibistan', zor:0.80, not:'Okul', emoji:'🏫',
   her:['Pola me mezin e.', 'Em diçin polê.'],
   gen:['Pol — sınıf', 'Pola sêyem.']),

  (id:'z_a1_094', ku:'Taxtê', tr:'Tahta', en:'Blackboard', cins:'nêr', ez:'taxtê',
   kat:'dibistan', zor:0.78, not:'Okul', emoji:'📋',
   her:['Mamoste li taxtê dinivîse.', 'Li taxtê binêre.'],
   gen:['Taxtê — tahta', 'Taxtê reş e.']),

  (id:'z_a1_095', ku:'Nivîsandin', tr:'Yazmak', en:'To write', cins:'bêcins', ez:null,
   kat:'dibistan', zor:0.78, not:'Okul', emoji:'✍️',
   her:['Ez dinivîsim.', 'Bi Kurmancî binivîse.'],
   gen:['Nivîsandin — yazmak', 'Em dinivîsin.']),

  // ── Lîstik (Oyun) ek ───────────────────────────────────
  (id:'z_a1_100', ku:'Firfir', tr:'Uçurtma', en:'Kite', cins:'mê', ez:'firfira',
   kat:'listik', zor:0.80, not:'Açık hava oyunu', emoji:'🪁',
   her:['Em firfirê difirandin.', 'Firfir li ezmanan e.'],
   gen:['Firfir — uçurtma', 'Firfira sor.']),

  (id:'z_a1_101', ku:'Darvêş', tr:'Salıncak', en:'Swing', cins:'mê', ez:'darvêşa',
   kat:'listik', zor:0.78, not:'Park oyunu', emoji:'🎪',
   her:['Ez li darvêşê dilîzim.', 'Darvêş xweş e!'],
   gen:['Darvêş — salıncak', 'Darvêşa mezin.']),

  (id:'z_a1_102', ku:'Gêlavêj', tr:'Kaydırak', en:'Slide', cins:'mê', ez:'gêlavêja',
   kat:'listik', zor:0.78, not:'Park oyunu', emoji:'🛝',
   her:['Em li gêlavêjê dilîzin.', 'Gêlavêj dirêj e.'],
   gen:['Gêlavêj — kaydırak', 'Gêlavêja bilind.']),

  // ── Hest (Duygular A2) ek ──────────────────────────────
];
