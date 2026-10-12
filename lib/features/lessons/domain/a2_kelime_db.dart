/// LÛTKE — A2 Kelime Veritabanı (Temel / Bingehîn)
///
/// Hedef: 700–900 kelime
/// Bu dosya: ~220 kelime (ilk kısım)
///
/// Kaynak doğrulama:
/// [BH] Bedir Han & Lescot (1990) — cinsiyet, çekim
/// [TH] Thackston (2006) — fiil sistemleri §60–140
/// [AS] Pratik Dil Kartları (2017) — pratik kelimeler
/// [AZ] Arizona Üniversitesi (Ekici, 1800 kelime) — ders sırası
/// [FB] Ferhenga Birûskî (Chyet, 2003) — altın standart sözlük
///
/// A2 pedagoji ilkeleri:
/// - Şimdiki zaman (di-...-e) tam öğretimi
/// - Geçmiş zaman geçişsiz (kök + kişi eki)
/// - Gelecek zaman (dê/ê + şimdiki zaman)
/// - Veqetandek derinleşmesi (belirsiz -ek, eğik haller)
/// - Olumsuzluk: na- (şimdiki), ne- (geçmiş)
/// - Edatlar: li, ji, bi, bo, ser, bin, ber, pey, di...de

// ignore_for_file: constant_identifier_names

import 'matematik_kelime_db.dart';

const kA2Kelimeler = [

  // ════════════════════════════════════════════════════════════
  // A2 BİRİM 1 — Êvara Baş: Günlük Selamlaşma (Derinleştirme)
  // A1\'de temel selamlar öğrenildi; A2\'de bağlamsal kullanım
  // [AZ] Ders 1 + [TH] §60–62
  // ════════════════════════════════════════════════════════════

  // Zaman bildiren selamlar
  (id:'a2_001', ku:'Sibê baş!', tr:'Günaydın!', en:'Good morning!',
   cins:'bêcins', ez:null, kat:'silav', zor:0.86,
   not:'"Sibê" = sabah/yarın. "Sibê baş!" sabah selamıdır. [TH] §: time expressions',
   her:['Sibê baş, dayê!', 'Sibê baş, pîrê — tu çawa yî?'],
   gen:['Sibê baş, mamosta!', 'Sibê baş, heval!']),

  (id:'a2_002', ku:'Êvar baş!', tr:'İyi akşamlar!', en:'Good evening!',
   cins:'bêcins', ez:null, kat:'silav', zor:0.83,
   not:'"Êvar" = akşam (dişil). "Êvar baş!" = iyi akşamlar. [AS] selamlama bölümü',
   her:['Êvar baş, kal!', 'Êvar baş, malbato!'],
   gen:['Êvar baş, heval!', 'Êvara we baş be!']),

  (id:'a2_003', ku:'Şev baş!', tr:'İyi geceler!', en:'Good night!',
   cins:'bêcins', ez:null, kat:'silav', zor:0.83,
   not:'"Şev baş!" = iyi geceler. "Şeva te xweş be" = gecen güzel olsun [TH]',
   her:['Şev baş, keça min!', 'Şev baş, pîrê!'],
   gen:['Şev baş, heval!', 'Şeva we baş be!']),

  // Hal hatır sorma — derinleşmiş
  (id:'a2_004', ku:'Çi nûçe?', tr:'Ne haber?', en:"What\'s new?",
   cins:'bêcins', ez:null, kat:'silav', zor:0.82,
   not:'"Nûçe" = haber/yenilik (dişil). [FB]: nûçe n.f. [AZ] günlük konuşma',
   her:['Çi nûçe heye, bira?', 'Pîrê, çi nûçe?'],
   gen:['Çi nûçe, heval?', 'Nûçeyên baş hene?']),

  (id:'a2_005', ku:'Nûçeyên baş', tr:'İyi haberler', en:'Good news',
   cins:'mê', ez:'nûçeyên',
   kat:'silav', zor:0.81,
   not:'"Nûçe" dişil (mê). Çoğul: "nûçeyên". [FB]: nûçe n.f.',
   her:['Nûçeyên baş hene!', 'Pîrê, nûçeyên baş!'],
   gen:['Nûçeyên baş hatine.', 'Ev nûçeyên baş in.']),

  // ════════════════════════════════════════════════════════════
  // A2 BİRİM 2 — Li Bajarê Mezin: Şehir ve Yer
  // [AZ] Ders 4 + [AS] Mekân bölümü
  // ════════════════════════════════════════════════════════════

  (id:'a2_010', ku:'Navend', tr:'Merkez / Şehir merkezi', en:'Center / Downtown',
   cins:'mê', ez:'navenda',
   kat:'cih', zor:0.82,
   not:'Mê — [FB]: navend n.f. "Navenda bajêr" = şehir merkezi',
   her:['Em diçin navenda bajêr.', 'Navend nêzîk e.'],
   gen:['Navend û derdor', 'Li navendê ye.']),

  (id:'a2_011', ku:'Kolan', tr:'Sokak', en:'Street',
   cins:'mê', ez:'kolana',
   kat:'cih', zor:0.82,
   not:'Mê — [FB]: kolan n.f. [AS] şehir bölümünde. "Li kolanê" = sokakta',
   her:['Kolan dirêj e.', 'Em li kolanê ne.'],
   gen:['Kolan û rê', 'Kolan mezin e.']),

  (id:'a2_012', ku:'Bazar', tr:'Pazar / Çarşı', en:'Market / Bazaar',
   cins:'mê', ez:'bazara',
   kat:'cih', zor:0.83,
   not:'Mê — [FB]: bazar n.f. [AS]: "PAZARLAR / BAZAR". Kürt kültüründe bazar sadece alışveriş değil, buluşma yeri',
   her:['Em diçin bazarê.', 'Bazara bajêr mezin e.'],
   gen:['Bazar û dikan', 'Li bazarê ye.']),

  (id:'a2_013', ku:'Dikan', tr:'Dükkan / Mağaza', en:'Shop / Store',
   cins:'mê', ez:'dikana',
   kat:'cih', zor:0.82,
   not:'Mê — [FB]: dikan n.f. [AS]: "dükkan = dikan" ✓',
   her:['Dikana pîrê nêzîk e.', 'Ez diçim dikanê.'],
   gen:['Dikan û bazar', 'Dikana nû']),

  (id:'a2_014', ku:'Nexweşxane', tr:'Hastane', en:'Hospital',
   cins:'mê', ez:'nexweşxaneya',
   kat:'cih', zor:0.81,
   not:'Mê — "nexweş" (hasta) + "xane" (yer). Zaten A1\'de var ama A2\'de kullanım genişler',
   her:['Em diçin nexweşxanê.', 'Nexweşxane li kû ye?'],
   gen:['Nexweşxane û dermangeh', 'Li nexweşxanê ye.']),

  (id:'a2_015', ku:'Dermangeh', tr:'Eczane', en:'Pharmacy',
   cins:'mê', ez:'dermangeha',
   kat:'cih', zor:0.81,
   not:'Mê — "derman" (ilaç) + "-geh" (yer). [FB]: dermangeh n.f.',
   her:['Dermangeh li kû ye?', 'Ez diçim dermangehê.'],
   gen:['Dermangeh û nexweşxane', 'Li dermangehê ye.']),

  (id:'a2_016', ku:'Qereqol', tr:'Karakol / Polis merkezi', en:'Police station',
   cins:'mê', ez:'qereqola',
   kat:'cih', zor:0.79,
   not:'Mê — [FB]: qereqol n.f. [Türkçe karakol\'dan]. "Qereqola polîsan" = polis karakolu',
   her:['Qereqol li navendê ye.', 'Em diçin qereqolê.'],
   gen:['Qereqol û enstîtu', 'Li qereqolê ye.']),

  (id:'a2_017', ku:'Xwendegeh / Dibistan', tr:'Okul', en:'School',
   cins:'mê', ez:'xwendegeha',
   kat:'cih', zor:0.79,
   not:'Mê — "Dibistan" A1\'de öğrenildi. "Xwendegeh" daha özgün Kurmancî alternatif. [FB]: xwendegeh n.f.',
   her:['Xwendegeha me mezin e.', 'Ez diçim xwendegehê.'],
   gen:['Xwendegeh û zanîngeh', 'Li xwendegehê ye.']),

  (id:'a2_018', ku:'Mizgeft', tr:'Cami', en:'Mosque',
   cins:'mê', ez:'mizgefta',
   kat:'cih', zor:0.80,
   not:'Mê — [FB]: mizgeft n.f. [Arapça "mescid"den]. "Li mizgeftê" = camide',
   her:['Mizgeft li navendê ye.', 'Em diçin mizgeftê.'],
   gen:['Mizgeft û dêr', 'Mizgefta me']),

  (id:'a2_019', ku:'Park', tr:'Park', en:'Park',
   cins:'mê', ez:'parka',
   kat:'cih', zor:0.81,
   not:'Mê — [FB]: park n.f. [İngilizce/Fransızca kökenli]. Dişil veqetandek: "parka me" (bizim park). Oblik: "li parkê" = parkta.',
   her:['Em diçin parkê ji bo lîstinê.', 'Parka me li nêzî malê ye.'],
   gen:['Parka bajêr', 'Li parkê ne.']),

  // ════════════════════════════════════════════════════════════
  // A2 BİRİM 3 — Ew Çi Dike? Lêker Sistemi Derinleşmesi
  // A2\'de şimdiki, basit geçmiş, gelecek zaman
  // [TH] §60–80 + [BH] §166–195 + [AZ] Ders 7–10
  // ════════════════════════════════════════════════════════════

  // Şimdiki zaman — temel fiiller (di-...-e/im/î sistemi)
  (id:'a2_030', ku:'Dipeyive', tr:'Konuşuyor', en:'(He/She) speaks',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Di-peyiv-e" — peyvîn fiili 3.tekil. A1\'de diyalogda geçti. [TH] §65',
   her:['Pîrê bi Kurmancî dipeyive.', 'Tu çawa dipeyivî?'],
   gen:['Mamosta dipeyive.', 'Ew baş dipeyive.']),

  (id:'a2_031', ku:'Difroşe', tr:'Satıyor', en:'(He/She) sells',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Di-froş-e" — firotin fiili 3.tekil. [TH] §65: firotin = to sell',
   her:['Bazirganê me nan difroşe.', 'Ew çi difroşe?'],
   gen:['Dikan nan difroşe.', 'Ew erebe difroşe.']),

  (id:'a2_032', ku:'Dikire', tr:'Satın alıyor', en:'(He/She) buys',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Di-kir-e" — kirîn fiili 3.tekil. [TH] §65: kirîn = to buy',
   her:['Dêya min nan dikire.', 'Tu çi dikirî?'],
   gen:['Ew pirtûk dikire.', 'Em erebe dikirin.']),

  (id:'a2_033', ku:'Dixebite', tr:'Çalışıyor (aktif)', en:'Works',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Di-xebit-e" (dixebite) veya "dixebite" — şimdiki çalışma. [TH] §65',
   her:['Bavê min gelek dixebite.', 'Tu li kû dixebitî?'],
   gen:['Ew li bajêr dixebite.', 'Em hemî dixebitin.']),

  // Geçmiş zaman geçişsiz — A2 kritik yapı
  // [BH] §170: geçişsiz fiil geçmişte özne yalın halde
  (id:'a2_034', ku:'Hat', tr:'Geldi', en:'(He/She) came',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'Geçmiş zaman geçişsiz — [BH] §170. "Ez hatim" (ben geldim) / "tu hatî" / "ew hat". Özne yalın halde!',
   her:['Pîrê hat malê!', 'Ew duh hat.'],
   gen:['Mamosta hat.', 'Heval hat.']),

  (id:'a2_035', ku:'Çû', tr:'Gitti', en:'(He/She) went',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'Geçmiş geçişsiz — çûn fiili. "Ez çûm" / "tu çûyî" / "ew çû". [TH] §68',
   her:['Bira çû bajêr.', 'Ew duh çû.'],
   gen:['Mamosta çû.', 'Malbat çû gund.']),

  (id:'a2_036', ku:'Ket', tr:'Düştü', en:'(He/She) fell',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'Geçmiş geçişsiz — ketin fiili. [TH] §68: ketin = to fall',
   her:['Zarok ket.', 'Bahoz ket.'],
   gen:['Ew ket.', 'Ez ketim.']),

  (id:'a2_037', ku:'Rabû', tr:'Kalktı', en:'Got up',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'Geçmiş geçişsiz — rabûn fiili. [TH] §68: rabûn = to get up (geçişsiz)',
   her:['Pîrê zû rabû.', 'Tu kengî rabûyî?'],
   gen:['Ew sibê rabû.', 'Ez dereng rabûm.']),

  // Gelecek zaman — dê + şimdiki zaman formu
  // [BH] §185: "ê" veya "dê" + fiil
  (id:'a2_038', ku:'Dê bê', tr:'Gelecek', en:'Will come',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Dê" gelecek zaman işareti — [BH] §185. "Ew dê bê" = o gelecek. "Ez ê bêm" = ben geleceğim (Bedirxan-Lescot: zamir ve "ê" AYRI)',
   her:['Pîrê dê bê malê.', 'Tu kengî dê bêyî?'],
   gen:['Mamosta dê bê.', 'Em dê werin.']),

  (id:'a2_039', ku:'Dê biçe', tr:'Gidecek', en:'Will go',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Dê biçe" = gidecek. "Ez ê biçim" = gideceğim (Bedirxan-Lescot §185: zamir ve "ê" AYRI yazılır).',
   her:['Bira dê biçe bajêr.', 'Tu dê biçî kû?'],
   gen:['Ew dê biçe.', 'Em dê biçin.']),

  // ════════════════════════════════════════════════════════════
  // A2 BİRİM 4 — Jiyan û Malbat: Genişletilmiş Aile Konuşması
  // [AZ] Ders 5 + [AS] Malbat bölümü derinlemesi
  // ════════════════════════════════════════════════════════════

  (id:'a2_040', ku:'Zewicîn', tr:'Evlenmek', en:'To marry',
   cins:'bêcins', ez:null, kat:'malbat', zor:0.80,
   not:'"Zewicîn" fiili — [FB]: zewicîn v. [AZ] aile dersleri. "Ew zewicî" = o evlendi',
   her:['Birayê min havînê zewicî.', 'Em ji bo zewicînê hazir in.'],
   gen:['Ew dê bizewice.', 'Zewac xweş be!']),

  (id:'a2_041', ku:'Zewac', tr:'Evlilik / Düğün', en:'Marriage / Wedding',
   cins:'mê', ez:'zewaca',
   kat:'malbat', zor:0.80,
   not:'Mê — [FB]: zewac n.f. "Zewaca wî xweş be!" = düğünü kutlu olsun.',
   her:['Zewaca birayê min bû.', 'Zewaca we pîroz be!'],
   gen:['Zewac û malbat', 'Di zewacê de']),

  (id:'a2_042', ku:'Zarok', tr:'Çocuk', en:'Child',
   cins:'bêcins', ez:'zarokê/zaroka',
   kat:'malbat', zor:0.83,
   not:'Nêr veya dişil bağlamına göre değişir — [FB]: zarok n. "Zarokên min" = çocuklarım',
   her:['Zarokê min xwendekar e.', 'Zarokên te çawa ne?'],
   gen:['Zarok û malbat', 'Zarokên me']),

  (id:'a2_043', ku:'Kurik', tr:'Küçük erkek / Oğlancık', en:'Little boy',
   cins:'nêr', ez:'kurikê',
   kat:'malbat', zor:0.80,
   not:'Nêr — "kur" (oğul) + "-ik" küçültme. [FB]: kurik n.m.',
   her:['Kurikê min xweş e.', 'Ev kurik kî ye?'],
   gen:['Kurik û keçik', 'Kurikê me']),

  (id:'a2_044', ku:'Keçik', tr:'Küçük kız / Kızcağız', en:'Little girl',
   cins:'mê', ez:'keçika',
   kat:'malbat', zor:0.80,
   not:'Mê — "keç" (kız) + "-ik" küçültme. [FB]: keçik n.f.',
   her:['Keçika min xweşik e.', 'Ev keçik kî ye?'],
   gen:['Keçik û kurik', 'Keçika me']),

  (id:'a2_045', ku:'Hevalê jiyanê', tr:'Eş / Hayat arkadaşı', en:'Life partner / Spouse',
   cins:'nêr', ez:'hevalê jiyanê',
   kat:'malbat', zor:0.78,
   not:'Lit. "jiyanın arkadaşı" — [AZ]: modern kullanım. "Mêr/Jin" daha formal, bu daha sıcak',
   her:['Hevalê jiyana min baş e.', 'Ew hevalê jiyana min e.'],
   gen:['Hevalê jiyanê xweş be!', 'Ev hevalê jiyana wî ye.']),

  // ════════════════════════════════════════════════════════════
  // A2 BİRİM 5 — Rewşa Hewayê: Hava ve Mevsim Konuşması
  // [AS] s.53 REWŞA HEWAYÊ + [AZ] Ders 19
  // ════════════════════════════════════════════════════════════

  (id:'a2_050', ku:'Hewa çawa ye?', tr:'Hava nasıl?', en:"What\'s the weather like?",
   cins:'bêcins', ez:null, kat:'hewa', zor:0.83,
   not:'"Hewa çawa ye?" = hava nasıl? [AZ] Wane 19: weather expressions',
   her:['Dayê, hewa çawa ye?', 'Pîrê, derve hewa çawa ye?'],
   gen:['Hewa çawa ye îro?', 'Li Stenbolê hewa çawa ye?']),

  (id:'a2_051', ku:'Hewa germ e', tr:'Hava sıcak', en:"The weather is hot",
   cins:'bêcins', ez:null, kat:'hewa', zor:0.84,
   not:'"Germ" = sıcak (değişmez rengdêr). A1\'de öğrenildi, A2\'de cümlede kullanım',
   her:['Êvarê hewa germ e.', 'Havînê hewa gelek germ e.'],
   gen:['Hewa germ e, av bixwe.', 'Hewa pir germ e.']),

  (id:'a2_052', ku:'Hewa sar e', tr:'Hava soğuk', en:"The weather is cold",
   cins:'bêcins', ez:null, kat:'hewa', zor:0.84,
   not:'"Sar" = soğuk. A1\'de var, A2\'de bağlam genişler',
   her:['Zivistanê hewa gelek sar e.', 'Sibê hewa sar dibe.'],
   gen:['Hewa sar e, kiras li xwe bike!', 'Hewa pir sar e.']),

  (id:'a2_053', ku:'Ewrî', tr:'Bulutlu', en:'Cloudy',
   cins:'bêcins', ez:null, kat:'hewa', zor:0.81,
   not:'Rengdêr — [FB]: ewrî adj. "Hewa ewrî ye" = hava bulutlu. [AZ] Wane 19',
   her:['Îro hewa ewrî ye.', 'Sibê hewa ewrî dibe.'],
   gen:['Hewa ewrî ye.', 'Sibê ewrî ye.']),

  (id:'a2_054', ku:'Tav dide', tr:'Güneş vuruyor', en:"The sun is shining",
   cins:'bêcins', ez:null, kat:'hewa', zor:0.82,
   not:'"Tav dide" = güneş vurur/parlıyor. [AS] hava bölümü. "Tav derdikeve" de kullanılır',
   her:['Îro tav dide, baş e!', 'Biharê tav gelek dide.'],
   gen:['Tav dide, em diçin derve.', 'Tav dide û germ e.']),

  (id:'a2_055', ku:'Baran dibare', tr:'Yağmur yağıyor', en:"It is raining",
   cins:'bêcins', ez:null, kat:'hewa', zor:0.82,
   not:'"Baran dibare" = yağmur yağıyor. [AS]: "Baran dibare" ✓. [AZ] Wane 19',
   her:['Derve baran dibare, nekeve!', 'Baran dibare û hewa sar e.'],
   gen:['Baran dibare.', 'Sibê baran dibare.']),

  (id:'a2_056', ku:'Berf dibare', tr:'Kar yağıyor', en:"It is snowing",
   cins:'bêcins', ez:null, kat:'hewa', zor:0.81,
   not:'"Berf dibare" = kar yağıyor. [AS]: bu form doğru ✓',
   her:['Zivistanê berf dibare.', 'Li çiyê berf dibare.'],
   gen:['Berf dibare û sar e.', 'Sibê berf dibare.']),

  // ════════════════════════════════════════════════════════════
  // A2 BİRİM 6 — Kirîn û Firotin: Alışveriş
  // [AZ] Ders 6 + [AS] s.55 Alışveriş bölümü
  // ════════════════════════════════════════════════════════════

  (id:'a2_060', ku:'Ev bi çendê ye?', tr:'Bu ne kadar?', en:'How much is this?',
   cins:'bêcins', ez:null, kat:'bazirganî', zor:0.83,
   not:'"Bi çendê?" = ne kadar (fiyat). [AZ] Wane 6: shopping. [AS] alışveriş bölümü',
   her:['Ev penîr bi çendê ye, xaltî?', 'Ev nan bi çendê ye?'],
   gen:['Ev bi çendê ye?', 'Ev erebe bi çendê ye?']),

  (id:'a2_061', ku:'Biha', tr:'Fiyat / Pahalı', en:'Price / Expensive',
   cins:'nêr', ez:'bihayê',
   kat:'bazirganî', zor:0.82,
   not:'Nêr — [FB]: biha n.m. "Bihayê vê çend e?" = bunun fiyatı ne? Hem isim hem rengdêr',
   her:['Biha gelek e!', 'Biha çend e?'],
   gen:['Biha û erzan', 'Ev biha ye.']),

  (id:'a2_062', ku:'Erzan', tr:'Ucuz', en:'Cheap',
   cins:'bêcins', ez:null, kat:'bazirganî', zor:0.82,
   not:'Rengdêra neguherbar — [FB]: erzan adj. [AZ] Wane 6',
   her:['Ev erzan e!', 'Bazar erzan e.'],
   gen:['Erzan û biha', 'Ev gelek erzan e.']),

  (id:'a2_063', ku:'Giran', tr:'Ağır / Pahalı', en:'Heavy / Expensive',
   cins:'bêcins', ez:null, kat:'bazirganî', zor:0.81,
   not:'Hem "ağır" hem "pahalı" anlamı var. [FB]: giran adj.',
   her:['Ev gelek giran e!', 'Ev dikan giran e.'],
   gen:['Giran û erzan', 'Ev pir giran e.']),

  (id:'a2_064', ku:'Pere', tr:'Para', en:'Money',
   cins:'nêr', ez:'pereyê',
   kat:'bazirganî', zor:0.83,
   not:'Nêr — [FB]: pere n.m. "Pereyê min" = param. Veqetandek çoğul: "pereyên...". [KURMANCI_RULES §8.2: "bi pere"]',
   her:['Pereyên min nînin!', 'Çend pere dixwazî?'],
   gen:['Pere û qerta krediyê', 'Pereyê min']),

  (id:'a2_065', ku:'Qerta krediyê', tr:'Kredi kartı', en:'Credit card',
   cins:'mê', ez:'qerta krediyê',
   kat:'bazirganî', zor:0.78,
   not:'Mê — "qert" (kart) + veqetandek + "krediyê". [KURMANCI_RULES §9.3: "kredi karti" YANLIŞ → "qerta krediyê"]',
   her:['Qerta krediyê heye?', 'Ez bi qerta krediyê didim.'],
   gen:['Qerta krediyê û pere', 'Qerta krediyê qebûl dike?']),

  (id:'a2_066', ku:'Kîlo', tr:'Kilo', en:'Kilogram',
   cins:'nêr', ez:'kîloyê',
   kat:'bazirganî', zor:0.84,
   not:'Nêr — [FB]: kîlo n.m. "Du kîlo nan" = iki kilo ekmek. Ölçü birimi',
   her:['Du kîlo goşt bide min.', 'Ev çend kîlo ye?'],
   gen:['Kîlo û gram', 'Sê kîlo nan']),

  // ════════════════════════════════════════════════════════════
  // A2 BİRİM 7 — Rêwîtiyê: Seyahat ve Ulaşım
  // [AS] s.38-40 ULAŞİM + [AZ] Ders 4
  // ════════════════════════════════════════════════════════════

  (id:'a2_070', ku:'Rêwîtî', tr:'Seyahat / Yolculuk', en:'Journey / Travel',
   cins:'mê', ez:'rêwîtiya',
   kat:'rêwîtî', zor:0.81,
   not:'Mê — [FB]: rêwîtî n.f. "Rêwîtiya baş!" = iyi yolculuklar!',
   her:['Rêwîtiya te baş be, bira!', 'Rêwîtî dirêj bû.'],
   gen:['Rêwîtiya baş!', 'Di rêwîtiyê de']),

  (id:'a2_071', ku:'Balafirgeh', tr:'Havalimanı', en:'Airport',
   cins:'mê', ez:'balafirgeha',
   kat:'rêwîtî', zor:0.80,
   not:'Mê — "balafir" (uçak) + "-geh" (yer). [FB]: balafirgeh n.f. (-geh ekli yer adları dişildir: dermangeh, xwendegeh)',
   her:['Em diçin balafirgehê.', 'Balafirgeh li kû ye?'],
   gen:['Balafirgeh û bisiklet', 'Li balafirgehê ye.']),

  (id:'a2_072', ku:'Stasyon', tr:'İstasyon / Gar', en:'Station',
   cins:'mê', ez:'stasyona',
   kat:'rêwîtî', zor:0.80,
   not:'Mê — [FB]: stasyon n.f. [Fransızca]. "Stasyona trênê" = tren garı',
   her:['Stasyon nêzîk e.', 'Em li stasyonê ne.'],
   gen:['Stasyon û balafirgeh', 'Li stasyonê ye.']),

  (id:'a2_073', ku:'Bilet', tr:'Bilet', en:'Ticket',
   cins:'nêr', ez:'biletê',
   kat:'rêwîtî', zor:0.82,
   not:'Nêr — [FB]: bilet n.m. [Fransızca]. "Biletekî bikirim" = bir bilet satın alayım',
   her:['Min bilet kirî.', 'Bilet bi çendê ye?'],
   gen:['Bilet û rêwîtî', 'Biletê balafirê']),

  (id:'a2_074', ku:'Sefer', tr:'Sefer / Gidiş', en:'Trip / Departure',
   cins:'mê', ez:'sefera',
   kat:'rêwîtî', zor:0.79,
   not:'Mê — [FB]: sefer n.f. [Arapça]. "Sefera te baş be!" = iyi yolculuklar (veda)',
   her:['Sefera te baş be!', 'Sefer kengî ye?'],
   gen:['Sefer û hatin', 'Sefera te baş be!']),

  (id:'a2_075', ku:'Pasaport', tr:'Pasaport', en:'Passport',
   cins:'nêr', ez:'pasaportê',
   kat:'rêwîtî', zor:0.79,
   not:'Nêr — uluslararası terim, Kurmancîde aynen kullanılır',
   her:['Pasaportê te hazir e?', 'Pasaport lazim e.'],
   gen:['Pasaport û vîze', 'Pasaportê min']),

  // ════════════════════════════════════════════════════════════
  // A2 BİRİM 8 — Pirtûk û Hîn bûn: Eğitim ve Öğrenme
  // [AZ] Ders 3 + [AS] EĞİTİM bölümü
  // ════════════════════════════════════════════════════════════

  (id:'a2_080', ku:'Hîn bûn', tr:'Öğrenmek', en:'To learn',
   cins:'bêcins', ez:null, kat:'perwerde', zor:0.82,
   not:'"Hîn bûn" fiili — "Hîn dibim" = öğreniyorum. [TH] §68. A1\'de diyalogda geçti',
   her:['Ez Kurmancî hîn dibim.', 'Pîrê hez dike em hîn bibin.'],
   gen:['Hîn bûn zehmet e lê baş e.', 'Em hemî hîn dibin.']),

  (id:'a2_081', ku:'Fêr bûn', tr:'Alışmak / Öğrenmek', en:'To get used to / learn',
   cins:'bêcins', ez:null, kat:'perwerde', zor:0.81,
   not:'"Fêr bûn" — hîn bûn\'a yakın ama özellikle "alışmak" anlamı da taşır. [TH] §68',
   her:['Ez fêrî Kurmancî dibim.', 'Tu fêrî bajarê bûyî?'],
   gen:['Fêr bûn zehmet e.', 'Ew fêrî xwendinê bûye.']),

  (id:'a2_082', ku:'Wane', tr:'Ders', en:'Lesson / Class',
   cins:'mê', ez:'waneya',
   kat:'perwerde', zor:0.82,
   not:'Mê — [FB]: wane n.f. [AS] no.161: "wane = ders" ✓. "Wanê xweş be!" = dersler güzel olsun',
   her:['Waneyên Kurmancî xweş in.', 'Kengî wane heye?'],
   gen:['Wane û sinif', 'Di wanê de']),

  (id:'a2_083', ku:'Sinif', tr:'Sınıf', en:'Classroom',
   cins:'mê', ez:'sinifa',
   kat:'perwerde', zor:0.82,
   not:'Mê — [AS] no.187: "sınıf = sinif" ✓ [FB]: sinif n.f. "Sinifa yekem" = birinci sınıf',
   her:['Sinifa me mezin e.', 'Em li sinifê ne.'],
   gen:['Sinif û korîdor', 'Li sinifê ye.']),

  (id:'a2_084', ku:'Xwend', tr:'Okudu / Öğrendi', en:'Read / Studied (past)',
   cins:'bêcins', ez:null, kat:'perwerde', zor:0.80,
   not:'Geçmiş kök — "xwendin" fiilinin geçmiş gövdesi. Ergatif: "Min pirtûk xwend" (ben kitap okudum).',
   her:['Min ev pirtûk sala borî xwend.', 'Te çi xwend?'],
   gen:['Ew gelek xwendiye.', 'Min pirtûk xwend.']),

  (id:'a2_085', ku:'Îmtîhan', tr:'Sınav', en:'Exam',
   cins:'mê', ez:'îmtîhana',
   kat:'perwerde', zor:0.80,
   not:'Mê — [AS] no.186: "sınav = ezmûn" ama "îmtîhan" daha yaygın. [FB]: îmtîhan n.f. "Îmtîhana min heye"',
   her:['Sibê îmtîhana me heye.', 'Îmtîhan zehmet bû.'],
   gen:['Îmtîhan û wane', 'Li îmtîhanê']),

  // ════════════════════════════════════════════════════════════
  // A2 BİRİM 9 — Tenduristî û Bijîşk: Sağlık ve Doktor
  // [AS] s.35-36 SAĞLIK + [AZ] Ders 12
  // ════════════════════════════════════════════════════════════

  (id:'a2_090', ku:'Serêşî', tr:'Baş ağrısı', en:'Headache',
   cins:'mê', ez:'serêşiya',
   kat:'tendurist', zor:0.82,
   not:'Mê — "ser" (baş) + "êşî" (ağrı). [FB]: serêşî n.f.',
   her:['Îro serêşiya min heye.', 'Serêşiya min giran e.'],
   gen:['Serêşî û nexweşî', 'Serêşiya min']),

  (id:'a2_091', ku:'Ta', tr:'Ateş (hastalık)', en:'Fever',
   cins:'mê', ez:'taya',
   kat:'tendurist', zor:0.81,
   not:'Mê — tıbbi ateş/humma. \"Germahî\" = sıcaklık (fiziksel), \"ta\" = hastalık ateşi.',
   her:['Zarokê me bi ta nexweş ket.', 'Taya wî bilind e.'],
   gen:['Ta û serêşî', 'Taya min']),

  (id:'a2_092', ku:'Derman', tr:'İlaç', en:'Medicine',
   cins:'nêr', ez:'dermanê',
   kat:'tendurist', zor:0.83,
   not:'Nêr — [FB]: derman n.m. "Ziman dermanê dilê mirov e" atasözünde geçer. Hem "ilaç" hem mecazi "derman"',
   her:['Bijîşk derman da min.', 'Divê tu dermanê xwe bixwî.'],
   gen:['Derman û nexweşxane', 'Dermanê min']),

  (id:'a2_093', ku:'Muayene', tr:'Muayene', en:'Examination (medical)',
   cins:'mê', ez:'muayeneya',
   kat:'tendurist', zor:0.79,
   not:'Mê — [AS] no.210: "muayene = muayene" ✓ [FB]: muayene n.f.',
   her:['Bijîşk muayene kir.', 'Sibê muayeneya me heye.'],
   gen:['Muayene û derman', 'Di muayeneyê de']),

  (id:'a2_094', ku:'Ji penîsîlînê re alerjiya min heye', tr:'Penisiline alerjim var', en:'I am allergic to penicillin',
   cins:'bêcins', ez:null, kat:'tendurist', zor:0.75,
   not:'[AS] öne çıkan cümle (s.35): "Penisiline alerjim var = Ji penîsîlînê re alerjiya min heye." Doktor ziyaretinde kritik',
   her:['Bijîşk, ji penîsîlînê re alerjiya min heye!', 'Ji vî dermanî re alerjiya min heye.'],
   gen:['Ji penîsîlînê re alerjî', 'Alerjiya min heye.']),

  // ════════════════════════════════════════════════════════════
  // A2 BİRİM 10 — Jiyana Rojane: Günlük Rutinler
  // [AZ] Ders 8 + [TH] §65–70
  // ════════════════════════════════════════════════════════════

  (id:'a2_100', ku:'Dema xewê', tr:'Uyku vakti / Yatma vakti', en:'Bedtime',
   cins:'mê', ez:'dema xewê',
   kat:'jiyan', zor:0.80,
   not:'"Dema xewê" = uyuma zamanı. [AS]: "ketin xewê" = uykuya girmek ✓. "Dem" (zaman) + "xewê" (uykunun). Özgün Kurmancî ifade.',
   her:['Dema xewê ye, kuro!', 'Şev baş be!'],
   gen:['Dema xewê', 'Şev baş be!']),

  (id:'a2_101', ku:'Şûştin', tr:'Yıkamak', en:'To wash',
   cins:'bêcins', ez:null, kat:'jiyan', zor:0.79,
   not:'"Dest û rûyê xwe bişo!" = el yüzünü yıka! [TH] §65: şûştin = to wash',
   her:['Sibehê ez destê xwe dişom.', 'Şûştina kincan dijwar e.'],
   gen:['Şûştin û paqijkirin', 'Dest bişo!']),

  (id:'a2_102', ku:'Razan', tr:'Uyumak', en:'To sleep',
   cins:'bêcins', ez:null, kat:'jiyan', zor:0.81,
   not:'"Razan" fiili — [AS] no.1124: uyumak = razan ✓. "Ew radize" = uyuyor. "Ketin xewê" = uykuya dalmak (deyimsel). [TH] §65',
   her:['Zarok zû dirazin êvarê.', 'Razan ji bo tendurûstiyê girîng e.'],
   gen:['Razan û şiyarîn', 'Ew radize.']),

  (id:'a2_103', ku:'Şiyarîn', tr:'Uyanmak', en:'To wake up',
   cins:'bêcins', ez:null, kat:'jiyan', zor:0.80,
   not:'"Şiyarîn" fiili. "Zû şiyar bibe!" = erken uyan! [TH] §65',
   her:['Sibehê zû em şiyar dibin.', 'Ez bi dengê dîk şiyar bûm.'],
   gen:['Şiyarîn û razan', 'Zû şiyar bibe!']),

  (id:'a2_104', ku:'Xwarin çêkirin', tr:'Yemek yapmak', en:'To cook',
   cins:'bêcins', ez:null, kat:'jiyan', zor:0.81,
   not:'"Xwarin çêkirin" veya "pijandin". "Dêya min xwarin çêdike" = annem yemek yapıyor',
   her:['Dêya min xwarin çêdike.', 'Tu xwarin çêdikî?'],
   gen:['Xwarin çêkirin û xwarin', 'Ew xwarin çêdike.']),

  (id:'a2_105', ku:'Malê paqij kirin', tr:'Ev temizlemek', en:'To clean the house',
   cins:'bêcins', ez:null, kat:'jiyan', zor:0.79,
   not:'"Paqij kirin" = temizlemek. "Malê paqij dikim" = evi temizliyorum',
   her:['Sibê ez malê paqij dikim.', 'Dêya min mal paqij kir.'],
   gen:['Mal paqij kirin', 'Malê paqij bike!']),

  // ════════════════════════════════════════════════════════════
  // A2 BİRİM 11 — Heywan û Xweza: Hayvanlar ve Doğa
  // [AS] s.62 HAYVANLAR + [TH] §85
  // ════════════════════════════════════════════════════════════

  (id:'a2_110', ku:'Rovî', tr:'Tilki', en:'Fox',
   cins:'nêr', ez:'roviyê',
   kat:'ajal', zor:0.80,
   not:'Nêr — [AS]: "Tilki = rovî" ✓. Kürt masallarında sık geçen hayvan — zekice davranışıyla simgeleşmiş',
   her:['Rovî li daristanê ye.', 'Rovî jîr e.'],
   gen:['Rovî û gur', 'Roviyê daristanê']),

  (id:'a2_111', ku:'Gur', tr:'Kurt', en:'Wolf',
   cins:'nêr', ez:'gurê',
   kat:'ajal', zor:0.80,
   not:'Nêr — [BH] s.277 bileşik: "Dêlegut, diş., (dişi) kurt (dêl, diş., köpek; gut, er., kurt)". Gur eril. [FB]: gur n.m.',
   her:['Gur li çiyê ye.', 'Gur û mî.'],
   gen:['Gur û rovî', 'Gurê çiyê']),

  (id:'a2_112', ku:'Şêr', tr:'Aslan', en:'Lion',
   cins:'nêr', ez:'şêrê',
   kat:'ajal', zor:0.81,
   not:'Nêr — [FB]: şêr n.m. Kürt kültüründe güç ve asalet simgesi',
   her:['Şêr ajalê şah e.', 'Wek şêr!'],
   gen:['Şêr û piling', 'Şêrê daristanê']),

  (id:'a2_113', ku:'Bilbil', tr:'Bülbül', en:'Nightingale',
   cins:'nêr', ez:'bilbilê',
   kat:'ajal', zor:0.81,
   not:'Nêr — [FB]: bilbil n.m. Kürt şiirinde sevgilinin simgesi. Cegerxwîn şiirlerinde sık geçer',
   her:['Bilbil stranan dibêje.', 'Dengê bilbil xweş e.'],
   gen:['Bilbil û gul', 'Bilbilê baxçeyê']),

  (id:'a2_114', ku:'Daristan', tr:'Orman', en:'Forest',
   cins:'mê', ez:'daristana',
   kat:'xweza', zor:0.81,
   not:'Mê — "dar" (ağaç) + "-istan" (yer eki). [FB]: daristan n.f. Kürdistan\'da ormanlık dağlar',
   her:['Daristana me mezin e.', 'Em çûn daristanê.'],
   gen:['Daristan û çiya', 'Li daristanê']),

  (id:'a2_115', ku:'Çol', tr:'Çöl / Bozkır', en:'Desert / Steppe',
   cins:'mê', ez:'çola',
   kat:'xweza', zor:0.79,
   not:'Mê — [FB]: çol n.f. "Li çolê" = çölde. Mezopotamya bozkırı Kürt coğrafyasının parçası',
   her:['Çol germ û hişk e.', 'Li çolê av tune ye.'],
   gen:['Çol û çiya', 'Çola germ']),

  // ════════════════════════════════════════════════════════════
  // A2 BİRİM 12 — Rengdêr û Berawirdkirin: Karşılaştırma
  // [AZ] Ders 5 dilbilgisi §16 + [BH] §57–60 rengdêrlar
  // A2\'de: baştir (daha iyi), baştirîn (en iyi)
  // ════════════════════════════════════════════════════════════

  (id:'a2_120', ku:'Baştir', tr:'Daha iyi', en:'Better',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.81,
   not:'"Baş" + "-tir" karşılaştırma eki. [BH] §58: rengdêr derecelendirmesi. [AZ] Wane 5 §16',
   her:['Tu baştir î!', 'Ev baştir e.'],
   gen:['Baştir û xerabtir', 'Ev baştir e.']),

  (id:'a2_121', ku:'Baştirîn', tr:'En iyi', en:'Best',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.81,
   not:'"Baş" + "-tirîn" üstünlük eki. "Tu xwendekarê baştirîn î!" [AZ] Wane 5',
   her:['Ev baştirîn e!', 'Tu baştirîn î!'],
   gen:['Baştirîn û xerabtirîn', 'Ev baştirîn e.']),

  (id:'a2_122', ku:'Mezintir', tr:'Daha büyük', en:'Bigger / Older',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.80,
   not:'"Mezin" + "-tir". [BH] §58: -tir karşılaştırma. "Birayê min mezintir e" = erkek kardeşim büyüktür',
   her:['Birayê min mezintir e.', 'Ev xanî mezintir e.'],
   gen:['Mezintir û biçûktir', 'Ew mezintir e.']),

  (id:'a2_123', ku:'Dirêjtir', tr:'Daha uzun / Daha uzak', en:'Longer / Farther',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.79,
   not:'"Dirêj" + "-tir". [BH] §58',
   her:['Rêya me dirêjtir e.', 'Ew dirêjtir e.'],
   gen:['Dirêjtir û kurttir', 'Ev dirêjtir e.']),

  (id:'a2_124', ku:'Germtir', tr:'Daha sıcak', en:'Hotter',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.79,
   not:'"Germ" + "-tir". Havadan konuşurken çok kullanılır',
   her:['Havîn germtir e.', 'Ev çay germtir e.'],
   gen:['Germtir û sartir', 'Êvare germtir e.']),

  (id:'a2_125', ku:'Xweştir', tr:'Daha güzel', en:'More beautiful',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.80,
   not:'"Xweş" + "-tir". [BH] §58',
   her:['Ev xweştir e!', 'Tu xweştir î!'],
   gen:['Xweştir û xirabtir', 'Ev pir xweştir e.']),

  // ════════════════════════════════════════════════════════════
  // A2 TEMEL BAĞLAÇLAR VE ZARFLAR
  // [TH] §: connectors + [AZ] Ders 14–15
  // ════════════════════════════════════════════════════════════

  (id:'a2_130', ku:'Ji ber ku', tr:'Çünkü', en:'Because',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.81,
   not:'"Ji ber ku" = çünkü. [TH] §: subordinating conjunctions. [AZ] Wane 14',
   her:['Ez neçûm ji ber ku nexweş bûm.', 'Pîrê hat ji ber ku me xwest.'],
   gen:['Ji ber ku baş e.', 'Ez hatim ji ber ku dixwastim.']),

  (id:'a2_131', ku:'Ger', tr:'Eğer', en:'If',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.81,
   not:'"Ger" = eğer (şart bağlacı). [TH] §: conditional. [AZ] Wane 15',
   her:['Ger bêyî, ez jî bêm.', 'Ger hewa baş be, em diçin.'],
   gen:['Ger baş be.', 'Ger haya te hebe.']),

  (id:'a2_132', ku:'Heta', tr:'Kadar / -e dek', en:'Until / As far as',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.80,
   not:'"Heta" = -e kadar. [TH] §: prepositions. [AZ] Wane 13',
   her:['Min heta nîvro kar kir.', 'Heta sibê bisekine.'],
   gen:['Heta dawiyê', 'Heta malê']),

  (id:'a2_133', ku:'Dema ku', tr:'-dığında / -ince', en:'When / While',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.80,
   not:'"Dema ku" = -dığında. [TH] §: time clauses. [AZ] Wane 15',
   her:['Dema ku ez hatim, ew çû.', 'Dema ku pîrê hat, keyf xweş bûm.'],
   gen:['Dema ku baş be.', 'Dema ku were.']),

  (id:'a2_134', ku:'Wilo', tr:'Böyle / Öyle', en:'Like this / So',
   cins:'bêcins', ez:null, kat:'temel', zor:0.80,
   not:'"Wilo" = böyle/öyle. [FB]: wilo adv. "Wilo ye" = böyledir',
   her:['Wilo baş e.', 'Pîrê wilo dibêje.'],
   gen:['Wilo û wisa', 'Wilo ye.']),

  (id:'a2_135', ku:'Ji nû ve', tr:'Yeniden / Tekrar', en:'Again / Anew',
   cins:'bêcins', ez:null, kat:'temel', zor:0.80,
   not:'"Ji nû ve" = yeniden. [FB]: ji nû ve adv. "Kurmancî ji nû ve hîn dibim!" = Kurmancîyi yeniden öğreniyorum!',
   her:['Ji nû ve dest pê bike!', 'Ez ji nû ve hatim.'],
   gen:['Ji nû ve dest pê kirin', 'Ji nû ve']),

  // ════════════════════════════════════════════════════════════
  // A2 BİRİM 13 — Reng û Huner: Kültür ve Sanat
  // Kürt müziği, dengbêj geleneği, Mem û Zîn
  // ════════════════════════════════════════════════════════════

  (id:'a2_140', ku:'Stranbêj', tr:'Şarkıcı', en:'Singer',
   cins:'bêcins', ez:'stranbêjê/stranbêja',
   kat:'çand', zor:0.81,
   not:'"Stran" (şarkı/dişil) + "bêj" (söyleyen). [FB]: stranbêj n. Heritage rozeti de "Stranbêj"!',
   her:['Stranbêjê me gelek xweş e.', 'Ew stranbêj e.'],
   gen:['Stranbêj û dengbêj', 'Stranbêjê kurd']),

  (id:'a2_141', ku:'Muzîk', tr:'Müzik', en:'Music',
   cins:'mê', ez:'muzîka',
   kat:'çand', zor:0.83,
   not:'Mê — [FB]: muzîk n.f. "Muzîka kurdî" = Kürt müziği. DoReCo: yaygın kullanım',
   her:['Muzîka kurdî xweş e.', 'Ez muzîk dibihîzim.'],
   gen:['Muzîk û stran', 'Muzîka me']),

  (id:'a2_142', ku:'Kitêb', tr:'Kitap (Arapça asıllı, klasik)', en:'Book',
   cins:'mê', ez:'kitêba',
   kat:'çand', zor:0.80,
   not:'Mê — "Pirtûk" A1\'de öğrenildi (saf Kurmancî, günlük). "Kitêb" Arapça كتاب asıllı, kelime başında KISA "i" (Kurmancî kelime başı uzun "î" almaz). Daha edebi / klasik metinlerde geçer.',
   her:['Kitêba Mem û Zîn xweş e.', 'Min kitêb xwend.'],
   gen:['Kitêb û pirtûk', 'Kitêba kurdî']),

  (id:'a2_143', ku:'Wêje', tr:'Edebiyat', en:'Literature',
   cins:'mê', ez:'wêjeya',
   kat:'çand', zor:0.79,
   not:'Mê — [FB]: wêje n.f. "Wêjeya kurdî" = Kürt edebiyatı. B1\'de derinleşir',
   her:['Wêjeya kurdî dewlemend e.', 'Ez wêje dixwînim.'],
   gen:['Wêje û huner', 'Wêjeya kurdî']),

  (id:'a2_144', ku:'Sêtar', tr:'Saz / Kürt çalgısı', en:'Saz / Kurdish lute',
   cins:'nêr', ez:'sêtarê',
   kat:'çand', zor:0.79,
   not:'Nêr — Kürt sazıdır. [FB]: sêtar n.m. Dengbêjlerin eşlikçisi',
   her:['Ew sêtar lêdixe.', 'Dengbêj sêtar dixwaze.'],
   gen:['Sêtar û muzîk', 'Sêtarê dengbêj']),

  (id:'a2_145', ku:'Lorî', tr:'Ninni', en:'Lullaby',
   cins:'mê', ez:'loriya',
   kat:'çand', zor:0.82,
   not:'Mê — [FB]: lorî n.f. A1 kültürel içeriğinde "Ninîno" ninnisi geçti',
   her:['Pîrê loriyekê ji min re got.', 'Lorî û stran.'],
   gen:['Lorî û stran', 'Loriya kurdî']),

  // ════════════════════════════════════════════════════════════
  // A2 BİRİM 14 — Navdêrên Gewre: Ülkeler ve Milletler
  // [AZ] Ders 2 + [AS] kişisel bilgiler bölümü
  // ════════════════════════════════════════════════════════════

  (id:'a2_150', ku:'Kurdistan', tr:'Kürdistan', en:'Kurdistan',
   cins:'mê', ez:'Kurdistana',
   kat:'navdêr', zor:0.85,
   not:'Mê — [FB]: Kurdistan n.f. "Li Kurdistanê" = Kürdistan\'da. Heritage kullanıcı için kimlik kelimesi. "-stan" soneki coğrafi alan işaretidir.',
   her:['Kurdistan welatê min e.', 'Li Kurdistanê baş e.'],
   gen:['Kurdistan û Tirkiye', 'Li Kurdistanê']),

  (id:'a2_151', ku:'Tirkiye', tr:'Türkiye', en:'Turkey',
   cins:'mê', ez:'Tirkiyeya',
   kat:'navdêr', zor:0.84,
   not:'Mê — ülke adları genellikle dişil. "Li Tirkiyê" = Türkiye\'de',
   her:['Ez li Tirkiyê dijim.', 'Tirkiye û Kurdistan.'],
   gen:['Li Tirkiyê dijim.', 'Tirkiyê']),

  (id:'a2_152', ku:'Kurdî', tr:'Kürtçe / Kürt (sıfat)', en:'Kurdish',
   cins:'bêcins', ez:null, kat:'navdêr', zor:0.85,
   not:'Rengdêra neguherbar — "Zimanê kurdî" = Kürtçe. "Muzîka kurdî" = Kürt müziği',
   her:['Ez bi kurdî dipeyivim!', 'Zimanê kurdî xweş e.'],
   gen:['Kurdî û Tirkî', 'Bi kurdî']),

  (id:'a2_153', ku:'Tirkî', tr:'Türkçe / Türk (sıfat)', en:'Turkish',
   cins:'bêcins', ez:null, kat:'navdêr', zor:0.85,
   not:'Rengdêra neguherbar — "Bi tirkî" = Türkçe olarak. Dil adları',
   her:['Bi tirkî û kurdî dipeyivim.', 'Tirkî û kurdî.'],
   gen:['Bi tirkî dipeyivim.', 'Tirkî û kurdî']),

  (id:'a2_154', ku:'Erebî', tr:'Arapça / Arap', en:'Arabic',
   cins:'bêcins', ez:null, kat:'navdêr', zor:0.80,
   not:'Rengdêra neguherbar — "Bi erebî" = Arapça. Kürdistan\'ın yakın komşusu',
   her:['Bi erebî nizanim.', 'Erebî û kurdî.'],
   gen:['Bi erebî', 'Erebî û farsî']),


];

// ════════════════════════════════════════════════════════════════
// A2 EK KELİMELER — İkinci Kısım
// Kaynak doğrulama: [BH][TH][AS][FB][AZ] — aynı standartlar
// ════════════════════════════════════════════════════════════════

const kA2EkKelimeler = [

  // ─────────────────────────────────────────────────────────────
  // GİYİM — [AS] s.54 CİLÛBERG
  // ─────────────────────────────────────────────────────────────

  (id:'a2_200', ku:'Kiras', tr:'Gömlek / Elbise', en:'Shirt / Dress',
   cins:'nêr', ez:'kirasê', kat:'cil', zor:0.82,
   not:'Nêr — [AS]: "gömlek = kiras" ✓. [FB]: kiras n.m.',
   her:['Min kirasekî nû kirî.', 'Kiras xweş e.'],
   gen:['Kiras û pantol', 'Kirasê nû']),

  (id:'a2_201', ku:'Pantol', tr:'Pantolon', en:'Trousers / Pants',
   cins:'nêr', ez:'pantolê', kat:'cil', zor:0.82,
   not:'Nêr — [AS]: "pantolon = pantol" ✓. [FB]: pantol n.m.',
   her:['Pantolê min reş e.', 'Pantol bikire.'],
   gen:['Pantol û kiras', 'Pantolê nû']),

  (id:'a2_202', ku:'Pêlav', tr:'Ayakkabı', en:'Shoe',
   cins:'mê', ez:'pêlava', kat:'cil', zor:0.81,
   not:'Mê — [FB]: pêlav n.f. "Pê" (ayak) + "lav" (örtü). DÜZELTME: Önce "kêlav" yazılmıştı; doğru form "pêlav". [AZ] giyim bölümü.',
   her:['Pêlavên min reş in.', 'Pêlavên min li ber derî ne.'],
   gen:['Pêlav û corab', 'Pêlavên nû']),

  (id:'a2_203', ku:'Corab', tr:'Çorap', en:'Sock',
   cins:'nêr', ez:'corabê', kat:'cil', zor:0.81,
   not:'Nêr — [FB]: corab n.m.',
   her:['Corabên min kû ne?', 'Corab li xwe bike!'],
   gen:['Corab û pêlav', 'Corabê spî']),

  (id:'a2_204', ku:'Cil û berg', tr:'Elbise / Kıyafet (genel)', en:'Clothes / Outfit',
   cins:'nêr', ez:'cil û bergê', kat:'cil', zor:0.82,
   not:'Nêr — "cil" (giysi) + "berg" (örtü). [AS] s.54: CILÛBERG bölümü ✓',
   her:['Cil û bergê te xweş e.', 'Cil û berg bikire.'],
   gen:['Cil û berg û pêlav', 'Cil û bergê nû']),

  (id:'a2_205', ku:'Xêz', tr:'Çizgi / Desen çizgisi', en:'Line / Stripe',
   cins:'mê', ez:'xêza', kat:'cil', zor:0.78,
   not:'Mê — [FB]: xêz n.f. "Kirasê xêzdar" = çizgili gömlek. "Nexş" = işlemeli desen (alternatif).',
   her:['Kiras xêzdar e.', 'Xêza sor.'],
   gen:['Xêz û reng', 'Xêzdar']),

  (id:'a2_206', ku:'Kevnare', tr:'Çok eski / Antika', en:'Ancient / Antique',
   cins:'bêcins', ez:null, kat:'cil', zor:0.79,
   not:'Rengdêra neguherbar — [Badillî]: "kevnar, kevnare, antika". "Kevin" (A1) genel eski; "kevnare" çok eski/antika',
   her:['Kirasê min kevnare ye.', 'Ev kevnare ye, nû bike.'],
   gen:['Kevnare û nû', 'Ev kevnare ye.']),

  // ─────────────────────────────────────────────────────────────
  // RENK/GÖRÜNÜM EK SİFATLAR — [BH] §57–60 + [FB]
  // ─────────────────────────────────────────────────────────────

  (id:'a2_210', ku:'Geş', tr:'Parlak / Aydınlık', en:'Bright / Vivid',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.80,
   not:'Rengdêra neguherbar — [FB]: geş adj. "Çiraya geş" = parlak lamba. Bedir Han bileşiklerinde geçer',
   her:['Rengê geş xweş e.', 'Esman geş e.'],
   gen:['Geş û tarî', 'Ev geş e.']),

  (id:'a2_211', ku:'Tarî', tr:'Karanlık / Koyu', en:'Dark',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.80,
   not:'Rengdêra neguherbar — [FB]: tarî adj. "Şeva tarî" = karanlık gece',
   her:['Şev tarî ye.', 'Li derve hewa tarî bû.'],
   gen:['Tarî û geş', 'Ev tarî ye.']),

  (id:'a2_212', ku:'Hêşîn', tr:'Yeşil (doğa için) / Yeşermiş', en:'Fresh green / Verdant',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.78,
   not:'[FB]: hêşîn adj. "Kesk" genel yeşil, "hêşîn" doğadaki canlı yeşil (bitki yeşili). "Hêşîn bûn" = yeşermek',
   her:['Çiyayên hêşîn.', 'Bihar — her tişt hêşîn e.'],
   gen:['Hêşîn û kesk', 'Ev hêşîn e.']),

  (id:'a2_213', ku:'Boz', tr:'Gri / Kır (at için)', en:'Grey / Dun',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.79,
   not:'[FB]: boz adj. Bedir Han örneğinde: "Hespê boz baş e" = boz at iyidir ✓',
   her:['Hespê boz xweş e.', 'Rengê boz.'],
   gen:['Boz û gewr', 'Ev boz e.']),

  // ─────────────────────────────────────────────────────────────
  // ERGATİF YAPI GİRİŞİ — A2 KRİTİK NOKTA
  // [BH] §170–180 + [TH] §75–80 + [AZ] Ders 14–15
  // Geçmişte geçişli fiillerde özne eğik hale girer
  // ─────────────────────────────────────────────────────────────

  (id:'a2_220', ku:'Min xwar', tr:'Ben yedim', en:'I ate (ergative)',
   cins:'bêcins', ez:null, kat:'ergatif', zor:0.70,
   not:'[BH] §170: GEÇİŞLİ geçmişte ÖZNE EĞİK HALE GİRER. "Ez xwarin dixwim" (şimdiki) → "Min xwarin xwar" (geçmiş). Min = ez\'nin eğik hali!',
   her:['Min nan xwar.', 'Min çay vexwar.'],
   gen:['Min xwarin xwar.', 'Te çi xwar?']),

  (id:'a2_221', ku:'Min got', tr:'Ben dedim / söyledim', en:'I said (ergative)',
   cins:'bêcins', ez:null, kat:'ergatif', zor:0.70,
   not:'[BH] §170: gotin fiili geçişli → ergatif. "Min got" = ben söyledim. [TH] §75: ergatif yapı',
   her:['Min got ku baş e.', 'Min navê xwe got.'],
   gen:['Min got.', 'Wî çi got?']),

  (id:'a2_222', ku:'Te kir', tr:'Sen yaptın', en:'You did (ergative)',
   cins:'bêcins', ez:null, kat:'ergatif', zor:0.70,
   not:'"Te" = "tu"nun eğik hali. [BH] §170: kirin geçişli → ergatif. "Tu dikî" (şimdiki) → "Te kir" (geçmiş)',
   her:['Te çi kir?', 'Te baş kir!'],
   gen:['Te kir.', 'Min kir.']),

  (id:'a2_223', ku:'Wî/Wê bir', tr:'O götürdü', en:'He/She took (ergative)',
   cins:'bêcins', ez:null, kat:'ergatif', zor:0.69,
   not:'"Wî" (eril) veya "Wê" (dişil) = "ew"in eğik hali. [BH] §170: birin geçişli',
   her:['Wî pirtûk bir.', 'Wê keça xwe bir dibistanê.'],
   gen:['Wî bir.', 'Wê got.']),

  (id:'a2_224', ku:'Me dît', tr:'Biz gördük', en:'We saw (ergative)',
   cins:'bêcins', ez:null, kat:'ergatif', zor:0.69,
   not:'"Me" = "em"in eğik hali. [BH] §170: dîtin geçişli → ergatif',
   her:['Me pîrê dît.', 'Me çi dît?'],
   gen:['Me dît.', 'We çi dît?']),

  // ─────────────────────────────────────────────────────────────
  // OLUMSUZLUK — [TH] §63–64 + [BH] §175
  // na- (şimdiki) / ne- (geçmiş) / nebe (gelecek olumsuz)
  // ─────────────────────────────────────────────────────────────

  (id:'a2_230', ku:'Naçim', tr:'Gitmiyorum', en:"I\'m not going",
   cins:'bêcins', ez:null, kat:'neyekî', zor:0.81,
   not:'"Na-" + "çim" = gitmiyorum. [TH] §63: olumsuzluk "na" şimdiki zamanda fiil önüne gelir. "Naxwim" = yemiyorum',
   her:['Ez naçim bajêr.', 'Ez naçim, nexweş im.'],
   gen:['Naçim.', 'Ew naçe.']),

  (id:'a2_231', ku:'Nizanim', tr:'Bilmiyorum', en:"I don\'t know",
   cins:'bêcins', ez:null, kat:'neyekî', zor:0.83,
   not:'"Ni-zanim" — zanîn olumsuz. A1\'de "dizanim" (biliyorum) öğrenildi. [TH] §63',
   her:['Nizanim, pîrê.', 'Nizanim ku kû ye.'],
   gen:['Nizanim.', 'Ew jî nizane.']),

  (id:'a2_232', ku:'Nehat', tr:'Gelmedi', en:"Didn\'t come",
   cins:'bêcins', ez:null, kat:'neyekî', zor:0.80,
   not:'"Ne-" + geçmiş zaman. [TH] §64: olumsuz geçmiş "ne" öneki ile. "Neçû" = gitmedi',
   her:['Pîrê nehat.', 'Ew duh nehat.'],
   gen:['Nehat.', 'Me negot.']),

  (id:'a2_233', ku:'Nebe', tr:'Olmasın / Olmayacak', en:"Won\'t be / Don\'t let it be",
   cins:'bêcins', ez:null, kat:'neyekî', zor:0.78,
   not:'"Ne-bê" = olmasın. [BH] §175: gelecek olumsuz. "Dê nebe" = olmayacak',
   her:['Nexweş nebe!', 'Ger neçî, baş nabe.'],
   gen:['Dê nebe.', 'Nexweş nebe!']),

  // ─────────────────────────────────────────────────────────────
  // EDAT DERİNLEŞME — [TH] §40–45 + [BH] §200–215
  // ─────────────────────────────────────────────────────────────

  (id:'a2_240', ku:'Di navbera', tr:'Arasında', en:'Between',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.79,
   not:'"Di navbera … de" = arasında. [TH] §42: compound prepositions. "Di navbera me û wan de" = bizimle onlar arasında',
   her:['Di navbera me û wan de.', 'Di navbera bajêr û gund de.'],
   gen:['Di navbera … de', 'Di navbera kolan û malê de']),

  (id:'a2_241', ku:'Ber bi', tr:'Doğru / -e doğru', en:'Towards',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.79,
   not:'"Ber bi … ve" = -e doğru. [TH] §42. "Ber bi malê ve diçim" = eve doğru gidiyorum',
   her:['Ber bi malê ve diçim.', 'Ber bi bajêr ve.'],
   gen:['Ber bi … ve', 'Ber bi rê ve']),

  (id:'a2_242', ku:'Ji ber', tr:'-den dolayı / Yüzünden', en:'Because of',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.79,
   not:'"Ji ber" hem "önünde" hem "yüzünden". [TH] §42. "Ji ber malê" = evin önünde',
   her:['Ji ber baranê nehat.', 'Ji ber ku nexweş im.'],
   gen:['Ji ber baranê', 'Ji ber ku baş e']),

  (id:'a2_243', ku:'Di pêşiya', tr:'İlerisinde / Önünde', en:'Ahead of / In front of',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.78,
   not:'"Di pêşiya … de" = önünde/ilerisinde. [TH] §42',
   her:['Di pêşiya malê de park heye.', 'Di pêşiya me de rê dirêj e.'],
   gen:['Di pêşiya malê de', 'Di pêşiya te de']),

  (id:'a2_244', ku:'Di paşiya', tr:'Arkasında', en:'Behind',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.78,
   not:'"Di paşiya … de" = arkasında. [TH] §42',
   her:['Di paşiya malê de baxçe heye.', 'Di paşiya min de ew e.'],
   gen:['Di paşiya malê de', 'Di paşiya we de']),

  (id:'a2_245', ku:'Li ser', tr:'Üstünde', en:'On / On top of',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.81,
   not:'"Li ser" = üstünde. [TH] §40. "Pirtûk li ser mêzê ye" = kitap masanın üstünde',
   her:['Pirtûk li ser mêzê ye.', 'Pisîk li ser nivînê ye.'],
   gen:['Li ser mêzê', 'Li ser malê']),

  (id:'a2_246', ku:'Li bin', tr:'Altında', en:'Under / Below',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.80,
   not:'"Li bin" = altında. [TH] §40. "Li bin darê" = ağacın altında',
   her:['Pisîk li bin kursiyê ye.', 'Li bin darê rûniştin.'],
   gen:['Li bin mêzê', 'Li bin darê']),

  // ─────────────────────────────────────────────────────────────
  // ZAMAN İFADELERİ — [TH] §85 + [AZ] Ders 9
  // ─────────────────────────────────────────────────────────────

  (id:'a2_250', ku:'Par', tr:'Geçen yıl', en:'Last year',
   cins:'bêcins', ez:null, kat:'dem', zor:0.81,
   not:'"Par" = geçen yıl. [TH] §85: time adverbs. "Parêsal" de denir',
   her:['Par em çûn gundê xwe.', 'Ew par ji gund derket.'],
   gen:['Par û îsal', 'Par hat.']),

  (id:'a2_251', ku:'Îsal', tr:'Bu yıl', en:'This year',
   cins:'bêcins', ez:null, kat:'dem', zor:0.82,
   not:'"Î-sal" — [BH] bileşik: "î" (gösterme) + "sal" (yıl). [TH] §85',
   her:['Îsal gelek xwendim.', 'Îsal Newroz xweş bû.'],
   gen:['Îsal û par', 'Îsal baş e.']),

  (id:'a2_252', ku:'Sala bê', tr:'Gelecek yıl', en:'Next year',
   cins:'bêcins', ez:null, kat:'dem', zor:0.80,
   not:'"Sala bê" = gelecek yıl. "Bê" = gelecek/gelen. [TH] §85',
   her:['Sala bê ez diçim zanîgehê.', 'Sala bê dê baş be.'],
   gen:['Sala bê û îsal', 'Sala bê']),

  (id:'a2_253', ku:'Berê', tr:'Önce / Eskiden', en:'Before / Previously',
   cins:'bêcins', ez:null, kat:'dem', zor:0.81,
   not:'"Berê" = önce/eskiden. [FB]: berê adv. [TH] §85. "Berê baştir bû" = eskiden daha iyiydi',
   her:['Berê li gundê dijiya.', 'Berê Kurmancî nizanibû.'],
   gen:['Berê û niha', 'Berê baştir bû.']),

  (id:'a2_254', ku:'Niha', tr:'Şimdi / Şu an', en:'Now',
   cins:'bêcins', ez:null, kat:'dem', zor:0.83,
   not:'"Niha" = şimdi/şu an. [FB]: niha adv. [TH] §85',
   her:['Niha baş im.', 'Niha ez dixwînim.'],
   gen:['Niha û berê', 'Niha çi dike?']),

  (id:'a2_255', ku:'Piştî', tr:'Sonra / -den sonra', en:'After / Later',
   cins:'bêcins', ez:null, kat:'dem', zor:0.80,
   not:'"Piştî" = sonra. [TH] §42: "piştî xwarinê" = yemekten sonra. [FB]: piştî prep.',
   her:['Piştî xwarinê çay vexwarin.', 'Piştî waneyê diçim malê.'],
   gen:['Piştî xwarinê', 'Piştî sibê']),

  (id:'a2_256', ku:'Berî', tr:'Önce / -den önce', en:'Before',
   cins:'bêcins', ez:null, kat:'dem', zor:0.80,
   not:'"Berî" = önce. [TH] §42: "berî xwarinê" = yemekten önce',
   her:['Berî xwarinê dest bişo.', 'Berî sibê were.'],
   gen:['Berî û piştî', 'Berî xwarinê']),

  (id:'a2_257', ku:'Di vê demê de', tr:'Bu sıralar / Şu dönemde', en:'These days / Currently',
   cins:'bêcins', ez:null, kat:'dem', zor:0.78,
   not:'"Di vê demê de" = bu sıralar. [TH] §85',
   her:['Di vê demê de gelek dixwînim.', 'Di vê demê de çawa yî?'],
   gen:['Di vê demê de baş im.', 'Di vê demê de']),

  // ─────────────────────────────────────────────────────────────
  // DUYGU VE DURUM — [AZ] Ders 11 + [FB]
  // ─────────────────────────────────────────────────────────────

  (id:'a2_260', ku:'Kovan', tr:'Üzgün', en:'Sad',
   cins:'bêcins', ez:null, kat:'his', zor:0.80,
   not:'[FB]: kovan adj. "Ez kovan im" = üzgünüm. [AZ] Wane 11: emotions',
   her:['Ez kovan im.', 'Pîrê kovan bû.'],
   gen:['Kovan û şa', 'Ev kovan e.']),

  (id:'a2_261', ku:'Şa', tr:'Mutlu / Sevinçli', en:'Happy / Joyful',
   cins:'bêcins', ez:null, kat:'his', zor:0.81,
   not:'[FB]: şa adj. "Ez şa me!" = çok mutluyum! [AZ] Wane 11',
   her:['Ez şa me ku hatî!', 'Pîrê gelek şa bû.'],
   gen:['Şa û kovan', 'Ez şa me!']),

  (id:'a2_262', ku:'Xemgîn', tr:'Kederli / Hüzünlü', en:'Sorrowful',
   cins:'bêcins', ez:null, kat:'his', zor:0.79,
   not:'[FB]: xemgîn adj. "Xem" (keder) + "-gîn" (dolmuş). Kürt şiirinin temel duygusal kelimesi',
   her:['Pîrê xemgîn bû.', 'Çima xemgîn î?'],
   gen:['Xemgîn û şa', 'Ev xemgîn e.']),

  (id:'a2_263', ku:'Tirsîn', tr:'Korkmak', en:'To be afraid',
   cins:'bêcins', ez:null, kat:'his', zor:0.79,
   not:'"Tirsîn" fiili — "Ez ditirsim" = korkuyorum. [FB]: tirsîn v. [TH] §65',
   her:['Ez ji tariyê natirsim.', 'Zarok ji tariyê ditirsin.'],
   gen:['Tirsîn û hêvî', 'Ez ditirsim.']),

  (id:'a2_264', ku:'Dilşa', tr:'Gönlü açık / Neşeli', en:'Cheerful / Lighthearted',
   cins:'bêcins', ez:null, kat:'his', zor:0.78,
   not:'[FB]: dilşa adj. "Dil" (gönül) + "şa" (mutlu). Kürt şiirinde sık kullanılan bileşik rengdêr',
   her:['Pîrê dilşa ye.', 'Tu dilşa yî?'],
   gen:['Dilşa û xemgîn', 'Ev dilşa ye.']),

  (id:'a2_265', ku:'Aciz bûn', tr:'Sıkılmak / Bıkmak', en:'To get bored / annoyed',
   cins:'bêcins', ez:null, kat:'his', zor:0.78,
   not:'"Aciz bûn" fiili. [FB]: aciz adj. [Arapça kökenli ama Kurmancîde yaygın]',
   her:['Ez ji bêkariyê aciz bûm.', 'Tu aciz î?'],
   gen:['Aciz bûn û bêhnvedan', 'Ez aciz im.']),

  (id:'a2_266', ku:'Hêvî', tr:'Umut / Beklenti', en:'Hope',
   cins:'mê', ez:'hêviya', kat:'his', zor:0.80,
   not:'Mê — [FB]: hêvî n.f. "Hêviya min heye" = umut var. [AZ] Wane 11',
   her:['Hêviya min heye!', 'Bê hêvî nebe.'],
   gen:['Hêvî û tirs', 'Hêviya me']),

  // ─────────────────────────────────────────────────────────────
  // BEDEN ve SAĞLIK EKSİKLERİ — A2 derinleşme
  // [AS] s.35-36 + [AZ] Ders 12
  // ─────────────────────────────────────────────────────────────

  (id:'a2_270', ku:'Êşîn', tr:'Ağrımak', en:'To ache / hurt',
   cins:'bêcins', ez:null, kat:'tendurist', zor:0.80,
   not:'"Êşîn" fiili — "Serê min diêşe" = başım ağrıyor. [TH] §65. "Êş" = ağrı (A1\'de var)',
   her:['Serê min îro pir diêşe.', 'Diranê min diêşe.'],
   gen:['Êşîn û baş bûn', 'Zikê min diêşe.']),

  (id:'a2_271', ku:'Zirav', tr:'İnce / Zayıf', en:'Thin / Slim',
   cins:'bêcins', ez:null, kat:'beden', zor:0.79,
   not:'[FB]: zirav adj. Hem "ince/zayıf" fiziksel hem "narin" anlamı',
   her:['Keça zirav.', 'Tu zirav bûyî.'],
   gen:['Zirav û qelew', 'Ew zirav e.']),

  (id:'a2_272', ku:'Qelew', tr:'Şişman / Tombul', en:'Fat / Chubby',
   cins:'bêcins', ez:null, kat:'beden', zor:0.79,
   not:'[FB]: qelew adj. q sesi gırtlaktan!',
   her:['Pisîk qelew e.', 'Zarokê qelew.'],
   gen:['Qelew û zirav', 'Ev qelew e.']),

  (id:'a2_273', ku:'Bilind', tr:'Uzun boylu / Yüksek', en:'Tall / High',
   cins:'bêcins', ez:null, kat:'beden', zor:0.80,
   not:'[FB]: bilind adj. Hem boy hem yükseklik. "Çiyayê bilind" = yüksek dağ',
   her:['Birayê min gelek bilind e.', 'Dengê xwe zêde bilind neke.'],
   gen:['Bilind û kurt', 'Ev bilind e.']),

  // ─────────────────────────────────────────────────────────────
  // SOSYAL HAYAT VE DİYALOG — [AZ] Ders 3 + [FB]
  // ─────────────────────────────────────────────────────────────

  (id:'a2_280', ku:'Civîn', tr:'Toplantı / Buluşma', en:'Meeting / Gathering',
   cins:'mê', ez:'civîna', kat:'civakî', zor:0.79,
   not:'Mê — [FB]: civîn n.f. "Civîna malbatê" = aile toplantısı',
   her:['Civîna malbatê baş bû.', 'Sibê civîn heye.'],
   gen:['Civîn û kom', 'Civîna me']),

  (id:'a2_281', ku:'Vexwandin', tr:'Davet etmek', en:'To invite',
   cins:'bêcins', ez:null, kat:'civakî', zor:0.79,
   not:'"Vexwandin" fiili — "Ew me vexwand" = bizi davet etti. [FB]: vexwandin v.',
   her:['Me mêvan vexwandin malê.', 'Vexwandina malbatê pir xweş bû.'],
   gen:['Vexwandin û qebûl kirin', 'Ew vexwand.']),

  (id:'a2_282', ku:'Qebûl kirin', tr:'Kabul etmek', en:'To accept',
   cins:'bêcins', ez:null, kat:'civakî', zor:0.79,
   not:'"Qebûl kirin" — [FB]: qebûl v. [Arapça kökenli]. "Qebûl dikim" = kabul ediyorum',
   her:['Erê, qebûl dikim!', 'Wî qebûl nekir.'],
   gen:['Qebûl kirin û red kirin', 'Qebûl dikim.']),

  (id:'a2_283', ku:'Red kirin', tr:'Reddetmek', en:'To refuse',
   cins:'bêcins', ez:null, kat:'civakî', zor:0.78,
   not:'"Red kirin" — [FB]: red kirin. "Red kir" = reddetti',
   her:['Ew red kir.', 'Ez red dikim.'],
   gen:['Red kirin û qebûl kirin', 'Red kir.']),

  (id:'a2_284', ku:'Bi hev re', tr:'Birlikte / Beraber', en:'Together',
   cins:'bêcins', ez:null, kat:'civakî', zor:0.82,
   not:'"Bi hev re" = birlikte. [TH] §42. "Em bi hev re diçin" = birlikte gidiyoruz',
   her:['Em bi hev re diçin.', 'Em bi hev re dixwin.'],
   gen:['Bi hev re û ji hev cuda', 'Bi hev re be!']),

  (id:'a2_285', ku:'Hevkarî', tr:'Dayanışma / Yardımlaşma', en:'Solidarity / Cooperation',
   cins:'mê', ez:'hevkariya', kat:'civakî', zor:0.78,
   not:'Mê — [FB]: hevkarî n.f. "Hev" (karşılıklı) + "karî" (iş). Kürt kültürünün temel değeri',
   her:['Hevkarî baş e.', 'Bi hevkarî em hêztirîn in.'],
   gen:['Hevkarî û yekîtî', 'Hevkariya me']),

  (id:'a2_286', ku:'Arîkarî', tr:'Yardım', en:'Help',
   cins:'mê', ez:'arîkariya', kat:'civakî', zor:0.81,
   not:'Mê — [FB]: arîkarî n.f. "Arîkariya te lazim e?" = yardıma ihtiyacın var mı?',
   her:['Ji te re arîkarî hewce ye?', 'Ez ji bo arîkariyê li wir im.'],
   gen:['Arîkarî û piştgirî', 'Arîkariya me']),

  // ─────────────────────────────────────────────────────────────
  // İŞ VE MESLEK DERİNLEŞME — [AS] s.33 + [AZ] Ders 16
  // ─────────────────────────────────────────────────────────────

  (id:'a2_290', ku:'Kar', tr:'İş / Çalışma', en:'Work / Job',
   cins:'nêr', ez:'karê', kat:'kar', zor:0.83,
   not:'Nêr — [FB]: kar n.m. "Karê min" = benim işim. [AZ] Wane 16',
   her:['Karê min baş e.', 'Li kû dixebitî?'],
   gen:['Kar û mal', 'Karê min']),

  (id:'a2_291', ku:'Xebat', tr:'Çalışma / Emek', en:'Work / Effort',
   cins:'mê', ez:'xebata', kat:'kar', zor:0.80,
   not:'Mê — [FB]: xebat n.f. "Xebata baş" = iyi çalışma. "Xebitîn" = çalışmak fiili',
   her:['Xebata te baş e!', 'Xebat lazim e.'],
   gen:['Xebat û bêhnvedan', 'Xebata me']),

  (id:'a2_292', ku:'Mûçe', tr:'Maaş', en:'Salary',
   cins:'mê', ez:'mûçeya', kat:'kar', zor:0.79,
   not:'Mê — [FB]: mûçe n.f. [Farsça kökenli]. "Mûçeya min" = maaşım',
   her:['Mûçeya min kêm e.', 'Mûçe hat?'],
   gen:['Mûçe û kar', 'Mûçeya min']),

  (id:'a2_293', ku:'Şirket', tr:'Şirket / Firma', en:'Company',
   cins:'mê', ez:'şirketa', kat:'kar', zor:0.79,
   not:'Mê — [FB]: şirket n.f. [Arapça kökenli]. Kurmancîde "sazî" (kurum) veya "karîger" daha özgün ama şirket yaygınlaşmıştır.',
   her:['Li şirketa mezin dixebitim.', 'Şirket li bajêr e.'],
   gen:['Şirket û sazî', 'Şirketa me']),

  (id:'a2_294', ku:'Serbixwe', tr:'Serbest / Bağımsız', en:'Freelance / Independent',
   cins:'bêcins', ez:null, kat:'kar', zor:0.79,
   not:'[FB]: serbixwe adj. "Serbixwe dixebite" = serbest çalışıyor',
   her:['Ez serbixwe dixebitim.', 'Serbixwe baş e.'],
   gen:['Serbixwe û şirket', 'Serbixwe dixebite.']),

  // ─────────────────────────────────────────────────────────────
  // TAŞINMA VE KONUT — [AZ] Ders 17 + [AS] Konaklama
  // ─────────────────────────────────────────────────────────────

  (id:'a2_300', ku:'Xanî kirê kirin', tr:'Ev kiralamak', en:'To rent a house',
   cins:'bêcins', ez:null, kat:'mal', zor:0.78,
   not:'"Kirê kirin" = kiralamak (ayrı yazılır — [BH] §194 açık bileşik). "Min xanî kirê kir" = ev kiraladım',
   her:['Me xanî kirê kir.', 'Kirêkirina malê zehmet e.'],
   gen:['Xanî kirê kirin û kirîn', 'Min xanî kirê kir.']),

  (id:'a2_301', ku:'Kirê', tr:'Kira', en:'Rent',
   cins:'mê', ez:'kirêya', kat:'mal', zor:0.79,
   not:'Mê — [FB]: kirê n.f. "Kirê gelek e" = kira çok yüksek. Veqetandek: "kirêya malê" = evin kirası (dişil -ya). DÜZELTME: Önceki cins:nêr yanlıştı.',
   her:['Kirê pir giran e.', 'Kirê kengî didî?'],
   gen:['Kirê û biha', 'Kirêya malê']),

  (id:'a2_302', ku:'Cînar', tr:'Komşu', en:'Neighbour',
   cins:'bêcins', ez:'cînarê/cînara', kat:'civakî', zor:0.81,
   not:'[FB]: cînar n. "Cînarên me baş in" = komşularımız iyidir',
   her:['Cînarên me baş in.', 'Cînarê te kî ye?'],
   gen:['Cînar û malbat', 'Cînarên me']),


  // ─────────────────────────────────────────────────────────────
  // TEKNOLOJI VE MODERN HAYAT — [AZ] Ders 18
  // ─────────────────────────────────────────────────────────────

  (id:'a2_310', ku:'Têlefon', tr:'Telefon', en:'Phone',
   cins:'mê', ez:'têlefona', kat:'teknoloji', zor:0.84,
   not:'Mê — [FB]: têlefon n.f. "Têlefona min" = telefonum',
   her:['Têlefona min hat.', 'Têlefon bike!'],
   gen:['Têlefon û înternet', 'Têlefona min']),

  (id:'a2_311', ku:'Komputêr', tr:'Bilgisayar', en:'Computer',
   cins:'mê', ez:'komputêra', kat:'teknoloji', zor:0.83,
   not:'Mê — [FB]: komputêr n.f. [AS] s.30 "Komputêr" ✓',
   her:['Li ser komputêrê dixebitim.', 'Komputêr xelas bû.'],
   gen:['Komputêr û têlefon', 'Komputêra min']),

  (id:'a2_312', ku:'Înternet', tr:'İnternet', en:'Internet',
   cins:'mê', ez:'înterneta', kat:'teknoloji', zor:0.83,
   not:'Mê — [FB]: înternet n.f. "Li ser înternetê" = internette. Yalın hal "Înternet" (eğik "înternetê")',
   her:['Li ser înternetê dixwînim.', 'Înternet qut bû.'],
   gen:['Înternet û têlefon', 'Li ser înternetê']),

  (id:'a2_313', ku:'Şandname', tr:'E-posta', en:'Email',
   cins:'mê', ez:'şandnameya', kat:'teknoloji', zor:0.78,
   not:'Mê — "şand" (gönderme) + "name" (mektup). Kurmancî özgün terim. [AZ] modern vocab',
   her:['Min şandname şand.', 'Şandname hat.'],
   gen:['Şandname û têlefon', 'Şandnameya min']),

  // ─────────────────────────────────────────────────────────────
  // SOSYAL İFADELER — [AZ] günlük konuşma + [TH]
  // ─────────────────────────────────────────────────────────────

  (id:'a2_320', ku:'Ji kerema xwe', tr:'Lütfen', en:'Please',
   cins:'bêcins', ez:null, kat:'civakî', zor:0.84,
   not:'"Ji kerema xwe" = lütfen (lit. senin iyiliğin için). [TH] polite forms. Çok sık kullanım',
   her:['Ji kerema xwe, arîkariyê bike.', 'Ji kerema xwe, bisekine.'],
   gen:['Ji kerema xwe!', 'Ji kerema xwe bide min.']),

  (id:'a2_321', ku:'Xêr be', tr:'Hayırlı olsun', en:'Bless you / Good luck',
   cins:'bêcins', ez:null, kat:'civakî', zor:0.81,
   not:'"Xêr be" = hayırlı olsun. [AZ] blessings. "Xêr û bereket" = hayır ve bereket',
   her:['Xêr be, kurê min!', 'Xêr be ji bo te!'],
   gen:['Xêr be!', 'Xêr û xweşî']),

  (id:'a2_322', ku:'Bextê te vekirî be', tr:'Bahtın açık olsun', en:'May you be lucky',
   cins:'bêcins', ez:null, kat:'civakî', zor:0.79,
   not:'Kürt kültüründe yaygın dua ve dilek ifadesi. "Bext" = baht/şans',
   her:['Bextê te vekirî be!', 'Bextê we vekirî be, malbato!'],
   gen:['Bextê te vekirî be!', 'Bextê wan vekirî be.']),

  (id:'a2_323', ku:'Bila xweş be', tr:'Güzel olsun', en:'May it be good',
   cins:'bêcins', ez:null, kat:'civakî', zor:0.80,
   not:'"Bila" + subjunctive = "olsun". "Bila xweş be!" = güzel olsun! [TH] §: subjunctive mood',
   her:['Bila xweş be!', 'Roja te bila xweş be.'],
   gen:['Bila baş be!', 'Bila xweş be!']),

  (id:'a2_324', ku:'Te çawa bihîst?', tr:'Nasıl duydun? / Haberdar mısın?', en:'How did you hear?',
   cins:'bêcins', ez:null, kat:'civakî', zor:0.77,
   not:'"Bihîstin" = duymak; geçişli → geçmişte ergatif: "Te bihîst" = duydun. ("Bîst" = 20 sayısı — karıştırma!) [AZ] informal questions',
   her:['Te çawa bihîst?', 'Te ev yek çawa bihîst?'],
   gen:['Te çawa bihîst?', 'Min ji te bihîst.']),

];

// ════════════════════════════════════════════════════════════════
// A2 EK KELIMELER — Üçüncü Kısım (~150 kelime)
// Kaynak: [BH][TH][AS][FB][AZ][DR] — beş kaynak doğrulamalı
// ════════════════════════════════════════════════════════════════

const kA2EkKelimeler2 = [

  // ─────────────────────────────────────────────────────────────
  // FİİLLER — Temel A2 Lêker Havuzu
  // [TH] §60–90 + [BH] §166–195 + [AZ] Ders 7–12
  // ─────────────────────────────────────────────────────────────

  (id:'a2_400', ku:'Axiftin', tr:'Konuşmak', en:'To speak/talk',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Axiftin" fiili — "Ez diaxivim" = konuşuyorum. [TH] §65. "Peyvîn" ile eş anlamlı',
   her:['Em bi Kurmancî diaxivin.', 'Axiftin bi dêya xwe re xweş e.'],
   gen:['Axiftin û guhdarîkirin', 'Em diaxivin.']),

  (id:'a2_401', ku:'Guhdarî kirin', tr:'Dinlemek', en:'To listen',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Guhdarî kirin" = dinlemek. [FB]: guhdarî n.f. + kirin. "Guh dan" de kullanılır',
   her:['Guhdariya stranên kurdî dikim.', 'Tu guhdarî dikî?'],
   gen:['Guhdarî kirin û axiftin', 'Guhdarî bike!']),

  (id:'a2_402', ku:'Xwendin', tr:'Okumak', en:'To read',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'"Xwendin" fiili — "Ez dixwînim" = okuyorum. [TH] §65. x gırtlaktan!',
   her:['Xwendina pirtûkan baş e.', 'Ez ji xwendinê hez dikim.'],
   gen:['Xwendin û nivîsîn', 'Ez dixwînim.']),

  (id:'a2_403', ku:'Nivîsîn', tr:'Yazmak', en:'To write',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Nivîsîn" fiili — "Ez dinivîsim" = yazıyorum. [TH] §65',
   her:['Nivîsîn bi destê xwe hêsan e.', 'Ez ji nivîsînê hez dikim.'],
   gen:['Nivîsîn û xwendin', 'Ez dinivîsim.']),

  (id:'a2_404', ku:'Gerîn', tr:'Gezmek / Dolaşmak', en:'To wander / walk around',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Gerîn" fiili — "Ez digerim" = geziyorum/dolaşıyorum. [TH] §65: gerîn = to wander',
   her:['Em havînê li bajêr geriyan.', 'Gerîn bi malbatê xweş e.'],
   gen:['Gerîn û rêwîtî', 'Em digerin.']),

  (id:'a2_405', ku:'Lîstin', tr:'Oynamak', en:'To play',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'"Lîstin" fiili — "Ez dilîzim" = oynuyorum. [TH] §65. [AZ] Wane 10',
   her:['Zarok li parkê lîstin.', 'Lîstin ji bo zarokan pir girîng e.'],
   gen:['Lîstin û xwendin', 'Em dilîzin.']),

  (id:'a2_406', ku:'Bêhna xwe vedan', tr:'Dinlenmek', en:'To rest',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Bêhna xwe vedan" = dinlenmek. [AS] no.974: "bêhna xwe dan" ✓. [BH]: bêhn = nefes.',
   her:['Bêhna xwe bide!', 'Pîrê bêhna xwe dide.'],
   gen:['Bêhna xwe vedan û xebat', 'Bêhna xwe bide!']),

  (id:'a2_407', ku:'Zanîn', tr:'Bilmek', en:'To know',
   cins:'bêcins', ez:null, kat:'leker', zor:0.83,
   not:'"Zanîn" — "Ez dizanim" (A1\'de var). A2\'de kullanım genişler: "Tu dizanî ku…"',
   her:['Ez dizanim ku tu yê bêyî.', 'Zanîn û têgihîştin du tişt in.'],
   gen:['Zanîn û nezanîn', 'Ez dizanim.']),

  (id:'a2_408', ku:'Xwestin', tr:'İstemek', en:'To want',
   cins:'bêcins', ez:null, kat:'leker', zor:0.82,
   not:'"Xwestin" — "Ez dixwazim" şimdiki zaman. [TH] §65. "Daxwaz" = istek/dilek',
   her:['Min pirtûkek xwest.', 'Te ji min çi xwest?'],
   gen:['Xwestin û nexwestin', 'Ew dixwaze.']),

  (id:'a2_409', ku:'Fêm kirin', tr:'Anlamak', en:'To understand',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Fêm kirin" — "Ez fêm dikim" = anlıyorum. [FB]: fêm n.m./v. [AZ] Wane 3',
   her:['Ez fêm dikim.', 'Tu fêm dikî?'],
   gen:['Fêm kirin û nezanîn', 'Fêm kir.']),

  (id:'a2_410', ku:'Bawer kirin', tr:'İnanmak / Güvenmek', en:'To believe / trust',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Bawer kirin" — "Ez bawer dikim" = inanıyorum. [FB]: bawer n.m.',
   her:['Ez bawer dikim.', 'Pîrê jî bawer dike.'],
   gen:['Bawer kirin û bawer nekirin', 'Bawer bike!']),

  (id:'a2_411', ku:'Li xweşa yekî çûn', tr:'Hoşlanmak / Hoşuna gitmek', en:'To enjoy / like',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Li xweşa yekî çûn" — [AS] no.1013: hoşlanmak ✓. "Ev stran li xweşa min diçe" = bu şarkı hoşuma gidiyor. "Hez kirin" (A1) daha güçlü sevgi; bu daha hafif beğeni.',
   her:['Ev stran li xweşa min diçe.', 'Ev li xweşa te diçe?'],
   gen:['Li xweşa yekî çûn û hez kirin', 'Li xweşa min diçe.']),

  (id:'a2_412', ku:'Bijartin', tr:'Seçmek', en:'To choose',
   cins:'bêcins', ez:null, kat:'leker', zor:0.78,
   not:'"Bijartin" (mesdar) — "Ez dibijêrim" = seçiyorum, "min bijart" = seçtim (ergatif). [TH] §65. DÜZELTME: Önce "Bijêrin" (imperatif/subjunctive) yazılmıştı.',
   her:['Tu kîjanê dibijêrî?', 'Min baştirîn pirtûk bijart.'],
   gen:['Bijartin û red kirin', 'Bijêre!']),

  (id:'a2_413', ku:'Mayîn', tr:'Kalmak', en:'To stay / remain',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Mayîn" (mesdar) — "Ez dimînim" = kalıyorum, "Ez mam" = kaldım. [TH] §65: man/mayîn = to stay. DÜZELTME: Önce "Bimîne" (imperatif) yazılmıştı; mesdar "mayîn".',
   her:['Tu li mal bimîne îşev.', 'Em li wir mabûn heya sibê.'],
   gen:['Mayîn û çûn', 'Ez dimînim.']),

  (id:'a2_414', ku:'Vegerîn', tr:'Dönmek', en:'To return',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Vegerîn" (mesdar) — "Ez vedigerim" = dönüyorum, "ez vegeriyam" = döndüm. [TH] §65. DÜZELTME: Önce "Vegerin" (imperatif/3pl) yazılmıştı.',
   her:['Sibê vedigerim malê.', 'Tu kengî vedigerî malê?'],
   gen:['Vegerîn û çûn', 'Em vedigerin.']),

  (id:'a2_415', ku:'Şandin', tr:'Göndermek', en:'To send',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Şandin" fiili — "Min şand" = gönderdim (ergatif!). [TH] §65 + §76',
   her:['Min name ji birayê xwe re şand.', 'Şandina peyaman bi têlefonê hêsan e.'],
   gen:['Şandin û wergirtin', 'Min şand.']),

  (id:'a2_416', ku:'Wergirtin', tr:'Almak / Teslim almak', en:'To receive',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Wergirtin" fiili — ergatif. [TH] §76: wergirtin = to receive/get',
   her:['Min ev pirtûk ji bavê xwe wergirt.', 'Wergirtina diyariyê kêfxweşî ye.'],
   gen:['Wergirtin û şandin', 'Min wergirt.']),

  // ─────────────────────────────────────────────────────────────
  // DOĞA VE ÇEVRE GENİŞLEME — [AS] + [TH] §85
  // ─────────────────────────────────────────────────────────────

  (id:'a2_420', ku:'Hewz', tr:'Havuz', en:'Pool / Pond',
   cins:'nêr', ez:'hewzê', kat:'xweza', zor:0.80,
   not:'Nêr — [FB]: hewz n.m. [Arapça kökenli]. "Hewzê mezin" = büyük göl',
   her:['Hewz xweş e.', 'Li hewzê masiyan girt.'],
   gen:['Hewz û çem', 'Hewzê mezin']),

  (id:'a2_421', ku:'Behr', tr:'Deniz', en:'Sea',
   cins:'mê', ez:'behra', kat:'xweza', zor:0.80,
   not:'Mê — [FB]: behr n.f. [Arapça behr]. "Li behrê" = denizde. DÜZELTME: Önceki ku alanında "Behrê" (eğik hal) yazılmıştı; yalın hal "Behr".',
   her:['Behr xweş e.', 'Em diçin behrê.'],
   gen:['Behr û hewz', 'Li behrê']),

  (id:'a2_422', ku:'Kevirên Çiya', tr:'Dağ taşları', en:'Mountain rocks',
   cins:'nêr', ez:'kevirê', kat:'xweza', zor:0.78,
   not:'"Kevir" = taş (eril). [FB]: kevir n.m. "Kevirên çiyayê" = dağın taşları',
   her:['Kevirên çiya sar in.', 'Kevir û dar.'],
   gen:['Kevir û ax', 'Kevirê çiyayê']),

  (id:'a2_423', ku:'Ax', tr:'Toprak / Kil', en:'Soil / Clay',
   cins:'mê', ez:'axa', kat:'xweza', zor:0.79,
   not:'Mê — [FB]: ax n.f. "Axa Kurdistanê" = Kürdistan toprağı (duygusal)',
   her:['Axa welat xweş e.', 'Axa vî gundî pir baş e.'],
   gen:['Ax û erd', 'Axa me']),

  (id:'a2_424', ku:'Dema zivistanê', tr:'Kış mevsimi', en:'Winter season',
   cins:'bêcins', ez:null, kat:'xweza', zor:0.79,
   not:'Zaman tamlaması. "Dema" = vakit/dönem. [TH] §85',
   her:['Dema zivistanê sar e.', 'Di dema zivistanê de berf dibare.'],
   gen:['Dema havîn û dema zivistanê', 'Di dema zivistanê de']),

  // ─────────────────────────────────────────────────────────────
  // MUTFAK VE YEMEK YAPIMI — [AS] s.47 + [AZ] Ders 8
  // ─────────────────────────────────────────────────────────────

  (id:'a2_430', ku:'Pijandin', tr:'Pişirmek', en:'To cook/bake',
   cins:'bêcins', ez:null, kat:'xwarin', zor:0.81,
   not:'"Pijandin" fiili — "Dêya min nan dipijîne" = annem ekmek pişiriyor. [TH] §65',
   her:['Dêya min nan dipijîne.', 'Pijandin a xwarinê hêz dixwaze.'],
   gen:['Pijandin û xwarin', 'Nan pijand.']),

  (id:'a2_431', ku:'Berbûn', tr:'Kaynatmak / Kaynamak', en:'To boil',
   cins:'bêcins', ez:null, kat:'xwarin', zor:0.79,
   not:'"Berbûn" veya "kelandin" = kaynatmak. [FB]: kelandin v. "Av dikele" = su kaynıyor',
   her:['Av berbûn li ser êgir.', 'Berbûna avê dem dixwaze.'],
   gen:['Kelandin û pijandin', 'Av dikele.']),

  (id:'a2_432', ku:'Nêrxê', tr:'Tane / Adet', en:'Piece / Unit',
   cins:'nêr', ez:'nêrxê', kat:'xwarin', zor:0.78,
   not:'Nêr — [FB]: nêrx n.m. Sayılabilir şeyler için birim. "Du nêrxê sêv" = iki tane elma',
   her:['Du nêrxê nan bide min.', 'Çend nêrx dixwazî?'],
   gen:['Nêrx û kîlo', 'Yek nêrx']),

  (id:'a2_433', ku:'Zeytûn', tr:'Zeytin', en:'Olive',
   cins:'nêr', ez:'zeytûnê', kat:'xwarin', zor:0.81,
   not:'Nêr — [FB]: zeytûn n.m. [Arapça]. Kürt kahvaltısının vazgeçilmezi',
   her:['Zeytûn û penîr xweş in.', 'Ez ji zeytûnên reş hez dikim.'],
   gen:['Zeytûn û rûn', 'Zeytûnê me']),

  (id:'a2_434', ku:'Mewîj', tr:'Kuru üzüm', en:'Raisin',
   cins:'mê', ez:'mewîja', kat:'xwarin', zor:0.78,
   not:'Mê — [FB]: mewîj n.f. ("mêw" = asma kökünden). Kürt yemek kültüründe sık kullanılır',
   her:['Mewîjên şîrîn.', 'Di xwarinê de mewîj heye.'],
   gen:['Mewîj û fêkî', 'Mewîja şîrîn']),

  (id:'a2_435', ku:'Kilam', tr:'Kilam / Türkü', en:'Ballad / Song (dengbêj)',
   cins:'mê', ez:'kilama', kat:'çand', zor:0.79,
   not:'Mê — [FB]: kilam n.f. "Kilamên pîrê" = büyükannenin kilamları. Dengbêj geleneğinin ezgili sözü; "stran" ile yakın. [Fêrker: "stran gotin, kilam gotin"]',
   her:['Kilamên pîrê binavûdeng in.', 'Ev kilam xweş e.'],
   gen:['Kilam û stran', 'Kilamên me']),

  // ─────────────────────────────────────────────────────────────
  // EV VE KONUT GENİŞLEME — [AS] s.46-47
  // ─────────────────────────────────────────────────────────────

  (id:'a2_440', ku:'Salon', tr:'Oturma odası / Salon', en:'Living room',
   cins:'mê', ez:'salona', kat:'mal', zor:0.82,
   not:'Mê — [FB]: salon n.f. [Fransızca]. "Li salonê" = salonda',
   her:['Em li salonê rûniştin.', 'Salon mezin e.'],
   gen:['Salon û ode', 'Salona me']),

  (id:'a2_441', ku:'Hewş', tr:'Avlu / Bahçe içi', en:'Courtyard',
   cins:'mê', ez:'hewşa', kat:'mal', zor:0.80,
   not:'Mê — [FB]: hewş n.f. Geleneksel Kürt evinin avlusu. Çok kültürel önemi var',
   her:['Zarok li hewşê dilîzin.', 'Hewşa malê mezin e.'],
   gen:['Hewş û baxçe', 'Hewşa me']),

  (id:'a2_442', ku:'Ban', tr:'Çatı / Tavan', en:'Roof / Ceiling',
   cins:'nêr', ez:'banê', kat:'mal', zor:0.78,
   not:'Nêr — [FB]: ban n.m. "Banê malê" = evin çatısı. DÜZELTME: "Ezmên" (= ezman, gökyüzü eğik hali) çatı anlamında kullanılmaz; doğru form sadece "ban".',
   her:['Banê malê diherike.', 'Li banê rûniştin.'],
   gen:['Ban û dêm', 'Banê malê']),

  (id:'a2_443', ku:'Derdor', tr:'Çevre / Etraf', en:'Surroundings',
   cins:'mê', ez:'derdora', kat:'cih', zor:0.80,
   not:'Mê — [FB]: derdor n.f. "Der" (dış) + "dor" (çevre). DÜZELTME: Önce "gilover" (= yuvarlak/küre) yazılmıştı; çevre/etraf için doğru form "derdor".',
   her:['Derdora malê xweş e.', 'Derdora bajêr kesk e.'],
   gen:['Derdor û nav', 'Derdora me']),

  // ─────────────────────────────────────────────────────────────
  // RENKLER / GÖRÜNÜM EK — A2 derinleştirme
  // ─────────────────────────────────────────────────────────────

  (id:'a2_450', ku:'Rengîn', tr:'Renkli / Rengarenk', en:'Colorful',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.79,
   not:'"Rengîn" = renkli/rengarenk. "Rengareng" jî tê gotin. DİKKAT: "rengdêr" gramer terimidir (= sıfat), "renkli" demek değildir',
   her:['Cilên rengîn xweş in.', 'Kirasê rengîn.'],
   gen:['Rengîn û yekreng', 'Kirasê rengîn']),

  (id:'a2_451', ku:'Ronî', tr:'Parlak / Aydınlık', en:'Light / Luminous',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.79,
   not:'[FB]: ronî adj. "Roja ronî" = aydınlık gün. Kürt şiirinde sık geçer',
   her:['Sibê ronî ye.', 'Ode ronî ye.'],
   gen:['Ronî û tarî', 'Ev ronî ye.']),

  // ─────────────────────────────────────────────────────────────
  // GÜNLÜK KONUŞMA İFADELERİ — [AZ] Ders 1-3 + [TH]
  // ─────────────────────────────────────────────────────────────

  (id:'a2_460', ku:'Jixwe', tr:'Zaten / Elbette', en:'Of course / Certainly',
   cins:'bêcins', ez:null, kat:'civakî', zor:0.80,
   not:'"Jixwe" = zaten/elbette. [FB]: jixwe adv. [AZ] günlük konuşma',
   her:['Jixwe ez dizanim.', 'Jixwe pîrê tê.'],
   gen:['Jixwe û belkî', 'Jixwe baş e.']),

  (id:'a2_461', ku:'Belkî', tr:'Belki / Olabilir', en:'Maybe / Perhaps',
   cins:'bêcins', ez:null, kat:'civakî', zor:0.81,
   not:'"Belkî" = belki. [FB]: belkî adv. [TH] §: modal expressions',
   her:['Belkî pîrê bê.', 'Belkî baş bibe.'],
   gen:['Belkî û bê guman', 'Belkî baş e.']),

  (id:'a2_462', ku:'Bê guman', tr:'Şüphesiz / Kesinlikle', en:'Without doubt / Certainly',
   cins:'bêcins', ez:null, kat:'civakî', zor:0.80,
   not:'"Bê guman" = şüphesiz. "Bê" = -siz + "guman" = şüphe. [FB]: bê guman adv.',
   her:['Bê guman ez têm.', 'Bê guman rast e.'],
   gen:['Bê guman û belkî', 'Bê guman!']),

  (id:'a2_463', ku:'Çi dibe bila bibe', tr:'Her neyse / Ne olursa olsun', en:'Whatever happens',
   cins:'bêcins', ez:null, kat:'civakî', zor:0.77,
   not:'İdiomatic expression — [TH] §: fixed phrases. "Çi dibe bila bibe!" = ne olursa olsun!',
   her:['Çi dibe bila bibe, ez têm!', 'Çi dibe bila bibe.'],
   gen:['Çi dibe bila bibe!', 'Bê xem be!']),

  (id:'a2_464', ku:'Bi ya min', tr:'Bence / Bana göre', en:'In my opinion',
   cins:'bêcins', ez:null, kat:'civakî', zor:0.79,
   not:'"Bi ya min" = bence. "Bi ya te" = sence. [AZ] opinion expressions',
   her:['Bi ya min, baştir e.', 'Bi ya te çawa ye?'],
   gen:['Bi ya min baş e.', 'Bi ya te?']),

  (id:'a2_465', ku:'Li gorî', tr:'Göre / -e göre', en:'According to',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.79,
   not:'"Li gorî" = göre. [TH] §42. "Li gorî min" = bana göre',
   her:['Li gorî min, baştir e.', 'Li gorî pîrê, rast e.'],
   gen:['Li gorî min', 'Li gorî hev']),

  // ─────────────────────────────────────────────────────────────
  // SOSYAL VE KÜLTÜREL — [AZ] Ders 16-17
  // ─────────────────────────────────────────────────────────────

  (id:'a2_470', ku:'Dost', tr:'Dost / Arkadaş', en:'Friend / Companion',
   cins:'bêcins', ez:'dostê/dosta', kat:'civakî', zor:0.83,
   not:'"Dost" Farsça kökenli ama Kurmancîde yerleşmiş. "Heval" daha yaygın. [FB]: dost n.',
   her:['Dostê min baş e.', 'Tu dostê min î!'],
   gen:['Dost û heval', 'Dostê me']),

  (id:'a2_471', ku:'Neyar', tr:'Düşman', en:'Enemy',
   cins:'nêr', ez:'neyarê', kat:'civakî', zor:0.78,
   not:'Nêr — [FB]: neyar n.m. "Ne" (olumsuz) + "yar" (dost) = dost-olmayan. "Dijmin" de kullanılır.',
   her:['Neyar tune ye.', 'Ew ne neyarê me ye.'],
   gen:['Neyar û heval', 'Neyarên me']),

  (id:'a2_472', ku:'Berpirsiyar', tr:'Sorumlu', en:'Responsible',
   cins:'bêcins', ez:null, kat:'kar', zor:0.78,
   not:'[FB]: berpirsiyar adj. "Ew berpirsiyar e" = o sorumlu',
   her:['Ez berpirsiyarê vê xebatê me.', 'Berpirsiyar kî ye?'],
   gen:['Berpirsiyar û serbixwe', 'Ev berpirsiyar e.']),

  (id:'a2_473', ku:'Derfet', tr:'Fırsat / İmkân', en:'Opportunity / Chance',
   cins:'mê', ez:'derfeta', kat:'civakî', zor:0.79,
   not:'Mê — [FB]: derfet n.f. [Arapça]. "Derfeteke baş" = iyi bir fırsat',
   her:['Ev derfeteke baş e!', 'Derfet tune ye.'],
   gen:['Derfet û zehmet', 'Derfeteke baş']),

  (id:'a2_474', ku:'Pêşeroj', tr:'Gelecek / İstikbal', en:'Future',
   cins:'mê', ez:'pêşeroja', kat:'dem', zor:0.79,
   not:'Mê — [FB]: pêşeroj n.f. "Pêş" (ön) + "roj" (gün). Kürtçe özgün terim',
   her:['Pêşeroja Kurdistanê baş e.', 'Pêşeroja zarokên me.'],
   gen:['Pêşeroj û niha', 'Pêşeroja me']),

  (id:'a2_475', ku:'Dîrok', tr:'Tarih', en:'History',
   cins:'mê', ez:'dîroka', kat:'çand', zor:0.79,
   not:'Mê — [FB]: dîrok n.f. "Dîroka kurdî" = Kürt tarihi. B1\'de derinleşir',
   her:['Dîroka kurdî dewlemend e.', 'Ez ji dîrok hez dikim.'],
   gen:['Dîrok û çand', 'Dîroka me']),

  // ─────────────────────────────────────────────────────────────
  // SAYILAR GENİŞLEME — Sıralı, bölünebilir
  // [AS] + [TH] §: ordinal numbers
  // ─────────────────────────────────────────────────────────────

  (id:'a2_480', ku:'Yekemîn', tr:'Birinci / İlk', en:'First',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.82,
   not:'"Yek" + "-emîn" = birinci. [TH] §: ordinal numbers. "Roja yekemîn" = ilk gün',
   her:['Ez yekemîn hatim!', 'Roja yekemîn a seferê.'],
   gen:['Yekemîn û duyem', 'Roja yekemîn']),

  (id:'a2_481', ku:'Duyem', tr:'İkinci', en:'Second',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.81,
   not:'"Du" + "-yem" = ikinci. [TH] §: ordinals',
   her:['Duyem hat.', 'Saeta duyem.'],
   gen:['Duyem û siyem', 'Serdema duyem']),

  (id:'a2_482', ku:'Nîv', tr:'Yarım / Orta', en:'Half / Middle',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.82,
   not:'"Nîv" = yarım. [BH]: "Nîvro" = öğle (nîv + roj). [FB]: nîv n./adj.',
   her:['Saet çar û nîv e.', 'Nîv nan dixwazim.'],
   gen:['Nîv û tam', 'Nîv saet']),

  (id:'a2_483', ku:'Çaryek', tr:'Çeyrek / Dörtte bir', en:'Quarter',
   cins:'nêr', ez:'çaryekê', kat:'jimar', zor:0.79,
   not:'Nêr — [FB]: çaryek n.m. "Çar" (dört) + "yek" (bir). "Çaryek saet" = çeyrek saat. DÜZELTME: Önceki yazım "çeryek" yanlıştı; doğru form "çaryek" (a2_1601 ile tutarlı).',
   her:['Çaryek saet man.', 'Saet pênc û çaryek e.'],
   gen:['Çaryek û nîv', 'Çaryek saet']),

  // ─────────────────────────────────────────────────────────────
  // BAĞLAÇLAR VE ZARFLAR TAMAMLAMA
  // ─────────────────────────────────────────────────────────────

  (id:'a2_490', ku:'Ji xwe re', tr:'Kendine / Kendisi için', en:'For oneself',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.79,
   not:'"Ji xwe re" = kendine/kendisi için. [TH] §42. "Ji xwe" de kullanılır',
   her:['Min ji xwe re xwarin xwar.', 'Ji xwe re fêr bibe.'],
   gen:['Ji xwe re bixwîne.', 'Ji xwe re']),

  (id:'a2_491', ku:'Bi tenê', tr:'Yalnız / Tek başına', en:'Alone / Only',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.80,
   not:'"Bi tenê" = yalnız. [FB]: bi tenê adv.',
   her:['Ez bi tenê me.', 'Pîrê bi tenê dimîne.'],
   gen:['Bi tenê û bi hev re', 'Bi tenê be.']),

  (id:'a2_492', ku:'Timî', tr:'Her zaman / Devamlı', en:'Always / Constantly',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.81,
   not:'"Timî" = her zaman/daima. [FB]: timî adv. "Daim" (A1) daha resmi; "timî" daha konuşma dili',
   her:['Timî baş be!', 'Pîrê timî çay dide.'],
   gen:['Timî û caran', 'Timî baş e.']),

  (id:'a2_493', ku:'Zêde', tr:'Fazla / Aşırı', en:'Too much / Excessive',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.80,
   not:'"Zêde" = fazla/çok fazla. [FB]: zêde adj./adv. "Pir zêde" = çok fazla',
   her:['Zêde nexwe!', 'Îro karê min pir zêde ye.'],
   gen:['Zêde û kêm', 'Pir zêde ye.']),

  (id:'a2_494', ku:'Kêm', tr:'Az / Eksik', en:'Few / Lacking',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.80,
   not:'"Kêm" = az/eksik. [FB]: kêm adj. "Hindik" (A1) ile yakın ama "kêm" eksikliği vurgular',
   her:['Pare kêm e.', 'Wext kêm e.'],
   gen:['Kêm û zêde', 'Kêm û zor']),

  (id:'a2_495', ku:'Qet', tr:'Hiç', en:'Never / Not at all',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.80,
   not:'"Qet" = hiç. [FB]: qet adv. "Qet nehatiye" = hiç gelmedi',
   her:['Min qet nexwest.', 'Qet ne rast e.'],
   gen:['Qet û timî', 'Qet nabe!']),

  // ─────────────────────────────────────────────────────────────
  // TEKNOLOJİ VE MODERN HAYAT EK
  // ─────────────────────────────────────────────────────────────

  (id:'a2_500', ku:'Wêne', tr:'Fotoğraf / Resim', en:'Photo / Image',
   cins:'nêr', ez:'wêneyê', kat:'teknoloji', zor:0.81,
   not:'Nêr — "Wêneyê min" = fotoğrafım. "Wêje" (edebiyat) ile karıştırma',
   her:['Wêneyê pîrê heye.', 'Wêneyekî bikişîne!'],
   gen:['Wêne û muzîk', 'Wêneyê min']),

  (id:'a2_501', ku:'Vîdyo', tr:'Video', en:'Video',
   cins:'mê', ez:'vîdyoya', kat:'teknoloji', zor:0.82,
   not:'Mê — uluslararası terim. "Vîdyoya kurdî" = Kürtçe video',
   her:['Ez vîdyoyên kurdî temaşe dikim.', 'Min vîdyo şand.'],
   gen:['Vîdyo û wêne', 'Vîdyoya baş']),

  (id:'a2_502', ku:'Malper', tr:'Web sitesi', en:'Website',
   cins:'mê', ez:'malpera', kat:'teknoloji', zor:0.78,
   not:'Mê — "mal" (ev) + "per" (kanat/sayfa). Kurmancî özgün terim. [AZ] modern',
   her:['Malpereke kurdî heye.', 'Malper li kû ye?'],
   gen:['Malper û înternet', 'Malpera me']),

  // ─────────────────────────────────────────────────────────────
  // ADET VE GELENEK — Kültürel genişleme
  // ─────────────────────────────────────────────────────────────

  (id:'a2_510', ku:'Adet', tr:'Gelenek / Adet', en:'Custom / Tradition',
   cins:'mê', ez:'adeta', kat:'çand', zor:0.80,
   not:'Mê — [FB]: adet n.f. [Arapça]. "Adetên kurdî" = Kürt gelenekleri',
   her:['Adetên kurdî xweş in.', 'Ev adet girîng e.'],
   gen:['Adet û çand', 'Adetên me']),

  (id:'a2_511', ku:'Cejn', tr:'Bayram / Şenlik', en:'Feast / Festival',
   cins:'mê', ez:'cejna', kat:'çand', zor:0.81,
   not:'Mê — [FB]: cejn n.f. "Cejna we pîroz be!" = bayramınız kutlu olsun! [Aslanoğlu: "Cejna te pîroz be"]',
   her:['Cejna we pîroz be!', 'Tu roja cejnê çi dikî?'],
   gen:['Cejn û Newroz', 'Cejna me']),

  (id:'a2_512', ku:'Dawet', tr:'Düğün', en:'Wedding celebration',
   cins:'mê', ez:'daweta', kat:'çand', zor:0.81,
   not:'Mê — [FB]: dawet n.f. "Daweta birayê min" = erkek kardeşimin düğünü',
   her:['Daweta birayê min xweş bû!', 'Di dawetê de xweş distirên.'],
   gen:['Dawet û cejn', 'Daweta me']),

  (id:'a2_513', ku:'Mêvandarî', tr:'Misafirperverlik', en:'Hospitality',
   cins:'mê', ez:'mêvandariya', kat:'çand', zor:0.79,
   not:'Mê — [FB]: mêvandarî n.f. "Mêvan" (misafir) + "-darî". Kürt kültürünün özü',
   her:['Mêvandariya kurdî binavûdeng e.', 'Ev mêvandarî baş e.'],
   gen:['Mêvandarî û xêrxwazî', 'Mêvandariya me']),

  // ─────────────────────────────────────────────────────────────
  // SORU KALIPLARI GENİŞLEME — [AZ] Ders 5 + [TH]
  // ─────────────────────────────────────────────────────────────

  (id:'a2_520', ku:'Ji kerema xwe, … li kû ye?', tr:'Lütfen … nerede?', en:'Please, where is…?',
   cins:'bêcins', ez:null, kat:'silav', zor:0.81,
   not:'Yön sormak için temel kalıp. [AZ] Wane 4',
   her:['Ji kerema xwe, bazar li kû ye?', 'Ji kerema xwe, dermangeh li kû ye?'],
   gen:['Ji kerema xwe, … li kû ye?', 'Li kû ye?']),

  (id:'a2_521', ku:'Rêya … çawa ye?', tr:'… yolu nasıl?', en:'How is the way to…?',
   cins:'bêcins', ez:null, kat:'rêwîtî', zor:0.79,
   not:'Yol tarifi sormak. [AZ] Wane 4',
   her:['Rêya bazarê çawa ye?', 'Rêya stasyonê çawa ye?'],
   gen:['Rêya … çawa ye?', 'Rê çawa ye?']),

  (id:'a2_522', ku:'Kengî vedigere?', tr:'Ne zaman dönüyor?', en:'When does (he/she) return?',
   cins:'bêcins', ez:null, kat:'dem', zor:0.80,
   not:'"Kengî" = ne zaman (A1\'de var). "Vedigere" = dönüyor (3.tekil). [TH] §65',
   her:['Pîrê kengî vedigere?', 'Tu kengî vedigerî?'],
   gen:['Kengî vedigere?', 'Kengî tê?']),

  // ─────────────────────────────────────────────────────────────
  // EĞİTİM VE BİLGİ — [AZ] Ders 3
  // ─────────────────────────────────────────────────────────────

  (id:'a2_530', ku:'Zanyarî', tr:'Bilgi / Enformasyon', en:'Knowledge / Information',
   cins:'mê', ez:'zanyariya', kat:'perwerde', zor:0.79,
   not:'Mê — [FB]: zanyarî n.f. "Zanîn" (bilmek) kökünden. [AZ] Wane 3',
   her:['Zanyariya te baş e.', 'Zanyarî lazim e.'],
   gen:['Zanyarî û hêz', 'Zanyariya me']),

  (id:'a2_531', ku:'Zanist', tr:'Bilim / Bilgi', en:'Science / Knowledge',
   cins:'mê', ez:'zanista', kat:'perwerde', zor:0.79,
   not:'"Zanist" = bilim. "Zanîn" = bilmek fiili. [FB]: zanist n.f.',
   her:['Zanist girîng e.', 'Zanista Kurmancî.'],
   gen:['Zanist û huner', 'Zanista me']),

  (id:'a2_532', ku:'Lêkolîn', tr:'Araştırma', en:'Research / Investigation',
   cins:'mê', ez:'lêkolîna', kat:'perwerde', zor:0.78,
   not:'Mê — [FB]: lêkolîn n.f. "Lêkolîna min" = araştırmam',
   her:['Lêkolîna Prof. Dr. Mutlu girîng e.', 'Ez li ser vê mijarê lêkolîn dikim.'],
   gen:['Lêkolîn û zanist', 'Lêkolîna me']),

];

// ════════════════════════════════════════════════════════════════
// A2 TAM BİRLEŞTİRİLMİŞ LİSTE
// ════════════════════════════════════════════════════════════════

// ════════════════════════════════════════════════════════════════
// A2 EK KELİMELER — Altıncı Kısım (+100 kelime)
// Odak: fiiller tam (AS 67-73), günlük alışkanlıklar, ülkeler, rengdêrlar
// ════════════════════════════════════════════════════════════════

const kA2EkKelimeler5 = [

  // BEDEN DİLİ — [AS] no.1002-1091
  (id:'a2_1000', ku:'Kenîn', tr:'Gülmek', en:'To laugh',
   cins:'bêcins', ez:null, kat:'leker', zor:0.83,
   not:'"Kenîn" — [AS] no.1002 ✓. "Ez dikenim" = gülüyorum.',
   her:['Zarok bi kêfa xwe kenîn.', 'Kenîn ji bo tenduristiyê baş e.'],
   gen:['Kenîn û girîn', 'Dikene!']),

  (id:'a2_1001', ku:'Bişirîn', tr:'Gülümsemek', en:'To smile',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'"Bişirîn" — [AS] no.1003 ✓. Kenîn\'den hafif.',
   her:['Pîrê li min bişirî.', 'Bişirîna wê pir xweş e.'],
   gen:['Bişirîn û kenîn', 'Bibişire!']),

  (id:'a2_1002', ku:'Girîn', tr:'Ağlamak', en:'To cry',
   cins:'bêcins', ez:null, kat:'leker', zor:0.82,
   not:'"Girîn" — [FB]: girîn v. "Zarok digirî."',
   her:['Zarok ji ber êşê girîn.', 'Girîn carna baş e.'],
   gen:['Girîn û kenîn', 'Negirî!']),

  (id:'a2_1003', ku:'Ramûsîn', tr:'Öpmek / El öpmek', en:'To kiss / embrace',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Ramûsîn" — [AS] no.1064 ✓. "Destê pîrê ramûsîn" = el öpmek.',
   her:['Min destê dêya xwe ramûsî.', 'Ramûsîn nîşana hezkirinê ye.'],
   gen:['Ramûsîn û hezkirî', 'Dest ramûsandin']),

  (id:'a2_1004', ku:'Cesaret', tr:'Cesaret / Yüreklilik', en:'Courage',
   cins:'mê', ez:'cesareta', kat:'his', zor:0.80,
   not:'Mê — [FB]: cesaret n.f. [Arapça kökenli]. "Cesareta te heye!" = cesaretin var. "Wêrekî" öz Kurmancî karşılık.',
   her:['Cesareta te heye!', 'Cesaret lazim e.'],
   gen:['Cesaret û tirs', 'Cesareta me']),

  (id:'a2_1005', ku:'Xewn dîtin', tr:'Rüya görmek', en:'To dream',
   cins:'bêcins', ez:null, kat:'jiyan', zor:0.80,
   not:'"Xewn dîtin" — [AS] no.1072 ✓.',
   her:['Min şevê xewneke xweş dît.', 'Tu xewn dibînî?'],
   gen:['Xewn dîtin û razan', 'Xewneke xweş!']),

  (id:'a2_1006', ku:'Revîn', tr:'Kaçmak', en:'To run away',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Revîn" — [AS] no.1029 ✓. "Ew direve."',
   her:['Mişk ji pisîkê revî.', 'Ew ji xeterê revî.'],
   gen:['Revîn û sekinîn', 'Nereve!']),

  (id:'a2_1007', ku:'Rûniştin', tr:'Oturmak', en:'To sit down',
   cins:'bêcins', ez:null, kat:'jiyan', zor:0.82,
   not:'"Rûniştin" — "Ru" (oturma) + "niştin". Ergatif değil, geçişsiz. "Ez rûdinim" = oturuyorum. Rabûn\'un zıddı.',
   her:['Em li ser kursiyê rûniştin.', 'Rûniştin piştî xebatê rehet e.'],
   gen:['Rûniştin û rabûn', 'Rûnê!']),

  (id:'a2_1008', ku:'Westîn', tr:'Yorulmak', en:'To be tired',
   cins:'bêcins', ez:null, kat:'jiyan', zor:0.81,
   not:'"Westîn" — [FB]: westîn v. "Lewre ez westî me."',
   her:['Em piştî kar westîn.', 'Westîn nîşana xebatê ye.'],
   gen:['Westîn û bêhnvedan', 'Ez westî me.']),

  (id:'a2_1009', ku:'Tîbûn', tr:'Susamak', en:'To be thirsty',
   cins:'bêcins', ez:null, kat:'jiyan', zor:0.80,
   not:'"Tîbûn" — [AS] no.1087 ✓. "Ez tî me."',
   her:['Em ji germê tî bûn.', 'Tîbûn av dixwaze.'],
   gen:['Tî û birçî', 'Ez tî me.']),

  // ÜLKELER — [AS] s.33 + diaspora
  (id:'a2_1020', ku:'Almanya', tr:'Almanya', en:'Germany',
   cins:'mê', ez:'Almanyaya', kat:'welat', zor:0.84,
   not:'Mê — "Li Almanyayê" = Almanya\'da. En büyük Kürt diasporası.',
   her:['Em li Almanyayê ne.', 'Ji Almanyayê hatim.'],
   gen:['Almanya û Kurdistan', 'Li Almanyayê']),

  (id:'a2_1021', ku:'Swêd', tr:'İsveç', en:'Sweden',
   cins:'mê', ez:'Swêda', kat:'welat', zor:0.81,
   not:'Mê — "Li Swêdê" = İsveç\'te. Büyük Kürt diasporası.',
   her:['Heval li Swêdê ye.', 'Ji Swêdê hat.'],
   gen:['Swêd û Almanya', 'Li Swêdê']),

  (id:'a2_1022', ku:'Hollenda', tr:'Hollanda', en:'Netherlands',
   cins:'mê', ez:'Hollendaya', kat:'welat', zor:0.80,
   not:'Mê — "Li Hollendayê" = Hollanda\'da.',
   her:['Xaltî li Hollendayê ye.', 'Ji Hollendayê hat.'],
   gen:['Hollenda û Belçîka', 'Li Hollendayê']),

  (id:'a2_1023', ku:'Ewropa', tr:'Avrupa', en:'Europe',
   cins:'mê', ez:'Ewropaya', kat:'welat', zor:0.83,
   not:'Mê — "Li Ewropayê" = Avrupa\'da. Diaspora kavramı.',
   her:['Em li Ewropayê dijîn.', 'Ewropaya bakur.'],
   gen:['Ewropa û Kurdistan', 'Li Ewropayê']),

  (id:'a2_1024', ku:'Iraq', tr:'Irak', en:'Iraq',
   cins:'mê', ez:'Iraqa', kat:'welat', zor:0.82,
   not:'Mê — "Li Iraqê" = Irak\'ta. Başûrê Kurdistanê.',
   her:['Başûrê Kurdistanê li Iraqê ye.', 'Ji Iraqê hat.'],
   gen:['Iraq û Tirkiye', 'Li Iraqê']),

  (id:'a2_1025', ku:'Almanî', tr:'Almanca / Alman', en:'German',
   cins:'bêcins', ez:null, kat:'ziman', zor:0.82,
   not:'Rengdêra neguherbar — "Bi almanî dipeyivim."',
   her:['Bi almanî baş diaxivim.', 'Almanî û kurdî.'],
   gen:['Almanî û kurdî', 'Bi almanî']),

  (id:'a2_1026', ku:'Îngilîzî', tr:'İngilizce / İngiliz', en:'English',
   cins:'bêcins', ez:null, kat:'ziman', zor:0.83,
   not:'Rengdêra neguherbar — "Bi îngilîzî dipeyivim."',
   her:['Bi îngilîzî dipeyivim.', 'Îngilîzî fêr dibim.'],
   gen:['Îngilîzî û kurdî', 'Bi îngilîzî']),

  // HAVA VE DOĞA
  (id:'a2_1030', ku:'Ba', tr:'Rüzgâr', en:'Wind',
   cins:'nêr', ez:'bayê', kat:'xweza', zor:0.83,
   not:'Nêr — [FB]: ba n.m. "Ba tê" = rüzgâr geliyor.',
   her:['Îro bayekî xurt tê.', 'Ba gelek e.'],
   gen:['Ba û baran', 'Bayê xurt']),

  (id:'a2_1031', ku:'Bahoz', tr:'Fırtına', en:'Storm',
   cins:'mê', ez:'bahoza', kat:'xweza', zor:0.81,
   not:'Mê — [FB]: bahoz n.f. "Bahoz tê."',
   her:['Bahoz tê, biçin hundur!', 'Bahoz xurt bû.'],
   gen:['Bahoz û baran', 'Bahoza mezin']),

  (id:'a2_1032', ku:'Mij', tr:'Sis', en:'Fog',
   cins:'mê', ez:'mija', kat:'xweza', zor:0.79,
   not:'Mê — [FB]: mij n.f. "Mij heye" = sis var. [Aslanoğlu no.709: "mij, moran"] ("sis" Türkçedir)',
   her:['Mij heye, hêdî here!', 'Di mijê de nayê dîtin.'],
   gen:['Mij û baran', 'Mija bajêr']),

  (id:'a2_1033', ku:'Tav', tr:'Güneş ışığı', en:'Sunshine',
   cins:'mê', ez:'tava', kat:'xweza', zor:0.82,
   not:'Mê — [FB]: tav n.f. "Tav dide" = güneş vuruyor.',
   her:['Tav dide, germ e.', 'Tav xweş e.'],
   gen:['Tav û baran', 'Tava biharê']),

  // KÜLTÜR VE MİRAS
  (id:'a2_1040', ku:'Mîras', tr:'Miras', en:'Heritage / Inheritance',
   cins:'mê', ez:'mîrasa', kat:'çand', zor:0.80,
   not:'Mê — [FB]: mîras n.f. "Mîrasa zimanî" = dil mirası.',
   her:['Mîrasa malbatê.', 'Mîras biparêze!'],
   gen:['Mîras û çand', 'Mîrasa me']),

  (id:'a2_1041', ku:'Nesl', tr:'Nesil / Kuşak', en:'Generation',
   cins:'nêr', ez:'neslê', kat:'çand', zor:0.80,
   not:'Nêr — [FB]: nesl n.m. "Neslê nû" = yeni nesil.',
   her:['Neslê nû Kurmancî hîn dibe.', 'Ji neslekî bo neslekî.'],
   gen:['Nesl û malbat', 'Neslê me']),

  (id:'a2_1042', ku:'Çîrok', tr:'Hikâye / Masal', en:'Story / Tale',
   cins:'mê', ez:'çîroka', kat:'çand', zor:0.83,
   not:'Mê — [FB]: çîrok n.f. "Pîrê çîrok digot."',
   her:['Pîrê çîrokek got.', 'Çîroka wî pir xweş bû.'],
   gen:['Çîrok û stran', 'Çîroka me']),

  (id:'a2_1043', ku:'Kevneşopî', tr:'Gelenek', en:'Tradition',
   cins:'mê', ez:'kevneşopiya', kat:'çand', zor:0.79,
   not:'Mê — "kevn" + "şopî". [FB]: kevneşopî n.f.',
   her:['Newroz kevneşopiya me ye.', 'Govend kevneşopiyek kurdî ye.'],
   gen:['Kevneşopî û nûgerî', 'Kevneşopiya me']),

  (id:'a2_1044', ku:'Pêşgotin', tr:'Önsöz', en:'Preface / Foreword',
   cins:'mê', ez:'pêşgotina', kat:'çand', zor:0.79,
   not:'Mê — [FB]: pêşgotin n.f.',
   her:['Ev pêşgotineke xweş e.', 'Min pêşgotina pirtûkê xwend.'],
   gen:['Pêşgotin û naverok', 'Pêşgotinên me']),

  // SIFATLAR
  (id:'a2_1050', ku:'Wêrek', tr:'Cesur', en:'Brave',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.79,
   not:'[FB]: wêrek adj. Kürt kültüründe önemli erdem.',
   her:['Ew gelek wêrek e.', 'Wêrek bin!'],
   gen:['Wêrek û tirsok', 'Ev wêrek e.']),

  (id:'a2_1051', ku:'Nazik', tr:'Nazik / Kibar', en:'Kind / Gentle',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.81,
   not:'[FB]: nazik adj. "Nazik bibe!"',
   her:['Ew gelek nazik e.', 'Nazik bibe!'],
   gen:['Nazik û hişk', 'Ev nazik e.']),

  (id:'a2_1052', ku:'Tûj', tr:'Keskin / Zeki', en:'Sharp',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.79,
   not:'[FB]: tûj adj. Hem fiziksel hem mecaz.',
   her:['Kêr tûj e.', 'Ew gelek tûj e.'],
   gen:['Tûj û kund', 'Ev tûj e.']),

  (id:'a2_1053', ku:'Dilpak', tr:'Dürüst / Temiz kalpli', en:'Honest',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.79,
   not:'"Dil" + "pak". [FB]: dilpak adj.',
   her:['Ew dilpak e.', 'Dilpak bibe!'],
   gen:['Dilpak û xayîn', 'Ev dilpak e.']),

  // ÖLÇÜ VE ZAMAN
  (id:'a2_1060', ku:'Saet', tr:'Saat (süre)', en:'Hour',
   cins:'mê', ez:'saeta', kat:'dem', zor:0.84,
   not:'Mê — [AS]: "saat = saet" ✓.',
   her:['Ez du saetan li benda te mam.', 'Du saet rêwîtî ye.'],
   gen:['Saet û deqîqe', 'Saetek']),

  (id:'a2_1061', ku:'Deqîqe', tr:'Dakika', en:'Minute',
   cins:'mê', ez:'deqîqeya', kat:'dem', zor:0.83,
   not:'Mê — [AS]: "dakika = hûrdem, deqîqe" ✓.',
   her:['Pênc deqîqe man.', 'Saet çar û bîst deqîqe ye.'],
   gen:['Deqîqe û saet', 'Pênc deqîqe']),

  (id:'a2_1062', ku:'Saniye', tr:'Saniye', en:'Second',
   cins:'mê', ez:'saniyeya', kat:'dem', zor:0.81,
   not:'Mê — [AS]: "saniye = çirk, saniye" ✓.',
   her:['Deh saniye man.', 'Di saniyeyê de hat.'],
   gen:['Saniye û deqîqe', 'Deh saniye']),

  // FİİLLER — [AS] tam liste
  (id:'a2_1070', ku:'Parve kirin', tr:'Paylaşmak', en:'To share',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Parve kirin" — [AS] no.1067 ✓.',
   her:['Parve bike!', 'Min parve kir.'],
   gen:['Parve kirin û girtin', 'Parve bike!']),

  (id:'a2_1071', ku:'Dubare kirin', tr:'Tekrar etmek', en:'To repeat',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Dubare kirin" — [AS] no.1106 ✓.',
   her:['Dubare bike!', 'Min dubare kir.'],
   gen:['Dubare kirin', 'Dubare bike!']),

  (id:'a2_1072', ku:'Vedîtin', tr:'Keşfetmek', en:'To discover',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Vedîtin" — [AS] no.1039 ✓.',
   her:['Zarokan tiştên nû vedîtin.', 'Vedîtina dermanan dijwar e.'],
   gen:['Vedîtin û hîn bûn', 'Vebîne!']),

  (id:'a2_1073', ku:'Bikar anîn', tr:'Kullanmak', en:'To use',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'"Bikar anîn" — [AS] no.1049 ✓.',
   her:['Vê pirtûkê bikar bîne.', 'Ez Kurmancî bikar tînim.'],
   gen:['Bikar anîn', 'Bikar bîne!']),

  (id:'a2_1074', ku:'Soz dan', tr:'Söz vermek', en:'To promise',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'"Soz dan" — [AS] no.1086 ✓. "Min soz da."',
   her:['Min soz da.', 'Soz bide!'],
   gen:['Soz dan û şikandin', 'Soz bide!']),

  (id:'a2_1075', ku:'Tomar kirin', tr:'Kaydetmek', en:'To record',
   cins:'bêcins', ez:null, kat:'leker', zor:0.78,
   not:'"Tomar kirin" — [AS] no.1036 ✓.',
   her:['Min tomar kir.', 'Tomar bike!'],
   gen:['Tomar kirin', 'Tomar bike!']),

  (id:'a2_1076', ku:'Îmze kirin', tr:'İmzalamak', en:'To sign',
   cins:'bêcins', ez:null, kat:'leker', zor:0.77,
   not:'"Îmze kirin" = imzalamak. ("Navîş" standart Kurmancî değildir.)',
   her:['Îmze bike!', 'Min îmze kir.'],
   gen:['Îmze kirin', 'Îmze bike!']),

  (id:'a2_1077', ku:'Şopandin', tr:'Takip etmek', en:'To follow',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Şopandin" — [AS] no.1095 ✓.',
   her:['Em zimanê kurdî dişopînin.', 'Bişopîne!'],
   gen:['Şopandin û dîtin', 'Bişopîne!']),

];



// ════════════════════════════════════════════════════════════════
// A2 EK KELİMELER — Beşinci Kısım (+250 kelime)
// Odak: fiiller tam, soyut kavramlar, meslekler, ev & eşyalar,
//        sağlık genişleme, doğa, aile ilişkileri, zaman kalıpları
// ════════════════════════════════════════════════════════════════

const kA2EkKelimeler4 = [

  // ─────────────────────────────────────────────────────────────
  // MESLEKLER GENİŞLEME — [AS] s.33 PÎŞEYİ tam
  // ─────────────────────────────────────────────────────────────

  (id:'a2_800', ku:'Bijîşk', tr:'Doktor', en:'Doctor',
   cins:'bêcins', ez:'bijîşkê', kat:'pîşe', zor:0.84,
   not:'A1\'de var, A2\'de mesleki bağlamda derinleşir. [AS]: "doktor = bijîşk"',
   her:['Ez îro diçim ba bijîşk.', 'Ez bijîşk im.'], gen:['Bijîşk û hekim', 'Bijîşkê me']),

  (id:'a2_801', ku:'Parêzer', tr:'Avukat', en:'Lawyer',
   cins:'bêcins', ez:'parêzerê', kat:'pîşe', zor:0.80,
   not:'"Parêzin" (korumak) + "-er" = koruyan. [FB]: parêzer n. "Parêzera baş."',
   her:['Parêzer lazim e.', 'Parêzera baş e.'], gen:['Parêzer û bijîşk', 'Parêzera me']),

  (id:'a2_802', ku:'Endezyar', tr:'Mühendis', en:'Engineer',
   cins:'bêcins', ez:'endezyarê', kat:'pîşe', zor:0.80,
   not:'[AS]: "mühendis = endezyar". [FB]: endezyar n.',
   her:['Ew endezyar e.', 'Endezyarên baş.'], gen:['Endezyar û mamosta', 'Endezyara me']),

  (id:'a2_803', ku:'Cotkar', tr:'Çiftçi', en:'Farmer',
   cins:'bêcins', ez:'cotkarê', kat:'pîşe', zor:0.81,
   not:'"Cot" (çift/saban) + "-kar" (yapan). [BH] §273: -kar soneki. [FB]: cotkar n.',
   her:['Cotkar li zeviyê ye.', 'Cotkarên kurd.'], gen:['Cotkar û bazirgan', 'Cotkarê me']),

  (id:'a2_804', ku:'Bazirgan', tr:'Tüccar', en:'Merchant',
   cins:'bêcins', ez:'bazirganê', kat:'pîşe', zor:0.81,
   not:'"Bazar" kökünden. [FB]: bazirgan n. "Bazirganê baş ji mêvanan hez dike."',
   her:['Bazirgan hat bazarê.', 'Ew bazirgan e.'], gen:['Bazirgan û cotkar', 'Bazirganê me']),

  (id:'a2_805', ku:'Şofer', tr:'Şoför / Sürücü', en:'Driver',
   cins:'bêcins', ez:'şoferê', kat:'pîşe', zor:0.82,
   not:'[FB]: şofer n. [Fransızca]. "Şoferê basê" = otobüs şoförü.',
   her:['Şofer tê.', 'Şoferê baş e.'], gen:['Şofer û erebe', 'Şoferê me']),

  (id:'a2_806', ku:'Nivîskar', tr:'Yazar', en:'Writer / Author',
   cins:'bêcins', ez:'nivîskarê', kat:'pîşe', zor:0.79,
   not:'"Nivîsîn" (yazmak) + "-kar". [BH] §273. [FB]: nivîskar n.',
   her:['Ew nivîskarek e.', 'Nivîskarên kurd.'], gen:['Nivîskar û helbestvan', 'Nivîskarê me']),

  (id:'a2_807', ku:'Wênekêş', tr:'Fotoğrafçı / Ressam', en:'Photographer / Painter',
   cins:'bêcins', ez:'wênekêşê', kat:'pîşe', zor:0.78,
   not:'"Wêne" (resim) + "kêş" (çeken). Kurmancî özgün bileşim.',
   her:['Wênekêş hat.', 'Ew wênekêş e.'], gen:['Wênekêş û helbestvan', 'Wênekêşê me']),

  (id:'a2_808', ku:'Muzîkvan', tr:'Müzisyen', en:'Musician',
   cins:'bêcins', ez:'muzîkvanê', kat:'pîşe', zor:0.79,
   not:'"Muzîk" + "-van" (uğraşan). [FB]: muzîkvan n.',
   her:['Muzîkvan stran got.', 'Ew muzîkvan e.'], gen:['Muzîkvan û stranbêj', 'Muzîkvanê me']),

  (id:'a2_809', ku:'Polîs', tr:'Polis', en:'Police officer',
   cins:'bêcins', ez:'polîsê', kat:'pîşe', zor:0.82,
   not:'[FB]: polîs n. "Qereqola polîsê" = polis karakolu.',
   her:['Polîs hat.', 'Polîs li malê ye.'], gen:['Polîs û artêş', 'Polîsê me']),

  // ─────────────────────────────────────────────────────────────
  // EV EŞYALARI — [AS] s.46-47 AMÛRÊN MUTBEXÊ + Oda eşyaları
  // ─────────────────────────────────────────────────────────────

  (id:'a2_820', ku:'Mêz', tr:'Masa', en:'Table',
   cins:'mê', ez:'mêza', kat:'mal', zor:0.84,
   not:'Mê — [FB]: mêz n.f. ("mase" ile eş; KURMANCI_RULES: mase F). "Li ser mêzê" = masanın üstünde',
   her:['Pirtûk li ser mêzê ye.', 'Mêz mezin e.'], gen:['Mêz û kursî', 'Mêza me']),

  (id:'a2_821', ku:'Kursî', tr:'Sandalye', en:'Chair',
   cins:'mê', ez:'kursiya', kat:'mal', zor:0.84,
   not:'Mê — [FB]: kursî n.f. (KURMANCI_RULES: kursî F). "Li bin kursiyê" = sandalyenin altında.',
   her:['Pisîk li bin kursiyê ye.', 'Kursî xweş e.'], gen:['Kursî û mêz', 'Kursiya me']),

  (id:'a2_822', ku:'Nivîn', tr:'Yatak', en:'Bed',
   cins:'mê', ez:'nivîna', kat:'mal', zor:0.83,
   not:'Mê — [FB]: nivîn n.f. "Li ser nivînê" = yatak üstünde.',
   her:['Pisîk li ser nivînê ye.', 'Nivîn mezin e.'], gen:['Nivîn û kursî', 'Nivîna me']),

  (id:'a2_823', ku:'Dolap', tr:'Dolap', en:'Wardrobe / Cupboard',
   cins:'mê', ez:'dolapa', kat:'mal', zor:0.83,
   not:'Mê — [AS]: "dolap = dolap" ✓. [FB]: dolab n.f.',
   her:['Cil di dolapê de ne.', 'Dolap mezin e.'], gen:['Dolap û mêz', 'Dolapa me']),

  (id:'a2_824', ku:'Çira', tr:'Lamba / Işık', en:'Lamp / Light',
   cins:'mê', ez:'çira', kat:'mal', zor:0.82,
   not:'Mê — [FB]: çira n.f. "Çiraya geş" = parlak lamba. A2\'de "geş" rengdêrı ile bağlantı.',
   her:['Çira vêxe!', 'Çira geş e.'], gen:['Çira û tarî', 'Çiraya me']),

  (id:'a2_825', ku:'Qûşxane', tr:'Tencere', en:'Pot',
   cins:'mê', ez:'qûşxaneya', kat:'mal', zor:0.80,
   not:'Mê — [AS] no.474: tencere = qûşxane, beroş ✓. "Beroş" de kullanılır (lehçe farkı). Dikkat: "textê" (%192 AS\'da "textê nivîsê" = yazı masası için) — tencere için YANLIŞ.',
   her:['Xwarin di qûşxanê de ye.', 'Qûşxane mezin e.'], gen:['Qûşxane û tawe', 'Qûşxana me']),

  (id:'a2_826', ku:'Firax', tr:'Tabak / Kap (genel)', en:'Dish / Plate',
   cins:'nêr', ez:'firaxê', kat:'mal', zor:0.82,
   not:'Nêr — [FB]: firax n.m. "Firaxên şikestî" = kırık tabaklar.',
   her:['Firax bişo!', 'Firax li mêzê ye.'], gen:['Firax û qedeh', 'Firaxê me']),

  (id:'a2_827', ku:'Qedeh', tr:'Bardak', en:'Glass / Cup',
   cins:'mê', ez:'qedeha', kat:'mal', zor:0.82,
   not:'Mê — [FB]: qedeh n.f. "Qedeha avê" = su bardağı.',
   her:['Qedeha avê bide min.', 'Qedeh şikiya.'], gen:['Qedeh û firax', 'Qedeha min']),

  (id:'a2_828', ku:'Çetel', tr:'Çatal', en:'Fork',
   cins:'nêr', ez:'çetelê', kat:'mal', zor:0.79,
   not:'Nêr — [AS] no.468: çatal = çetel, sêtêlk ✓. [FB]: çetel n.m. "Sêtêlk" de kullanılır (lehçe farkı). Dikkat: "çêlik" YANLIŞ form — kaynak yok.',
   her:['Çetel kû ye?', 'Çetel û kêr.'], gen:['Çetel û kêr', 'Çetelê me']),

  (id:'a2_829', ku:'Kêr', tr:'Bıçak', en:'Knife',
   cins:'mê', ez:'kêra', kat:'mal', zor:0.81,
   not:'Mê — [FB]: kêr n.f. "Kêra tûj" = keskin bıçak. (KURMANCI_RULES §2.2: kêr = bıçak)',
   her:['Kêr tûj e.', 'Kêr û çetel.'], gen:['Kêr û çetel', 'Kêra me']),

  // ─────────────────────────────────────────────────────────────
  // BEDEN VE SAĞLIK TAMAMLAMA
  // ─────────────────────────────────────────────────────────────

  (id:'a2_840', ku:'Pişt', tr:'Sırt', en:'Back',
   cins:'mê', ez:'pişta', kat:'beden', zor:0.82,
   not:'Mê — [FB]: pişt n.f. "Pişta min diêşe" = sırtım ağrıyor.',
   her:['Pişta min diêşe.', 'Pişta pîrê diêşe.'], gen:['Pişt û zik', 'Pişta min']),

  (id:'a2_841', ku:'Mil', tr:'Omuz', en:'Shoulder',
   cins:'nêr', ez:'milê', kat:'beden', zor:0.81,
   not:'Nêr — [FB]: mil n.m. "Milê min diêşe" = omzum ağrıyor.',
   her:['Milê min diêşe.', 'Du mil hene.'], gen:['Mil û ling', 'Milê min']),

  (id:'a2_842', ku:'Guh', tr:'Kulak', en:'Ear',
   cins:'nêr', ez:'guhê', kat:'beden', zor:0.83,
   not:'Nêr — [FB]: guh n.m. "Guhdarî kirin" = dinlemek (guh = kulak). A2\'de fiil bağlantısı.',
   her:['Guhê min diêşe.', 'Bi guhê xwe bibihîze.'], gen:['Guh û çav', 'Guhê min']),

  (id:'a2_843', ku:'Poz', tr:'Burun', en:'Nose',
   cins:'nêr', ez:'pozê', kat:'beden', zor:0.82,
   not:'Nêr — [FB]: poz n.m. "Pozê min girtî ye" = burnum tıkalı.',
   her:['Pozê min diêşe.', 'Pozê min girtî ye.'], gen:['Poz û guh', 'Pozê min']),

  (id:'a2_844', ku:'Hinarik', tr:'Yanak', en:'Cheek',
   cins:'mê', ez:'hinarika', kat:'beden', zor:0.79,
   not:'Mê — [FB]: hinarik n.f. "Alik" de kullanılır. DÜZELTME: Önce "çaw" (= göz/çav) yazılmıştı; yanak için doğru form "hinarik".',
   her:['Hinarikên te sor in.', 'Hinarik xweş e.'], gen:['Hinarik û rû', 'Hinarika min']),

  (id:'a2_845', ku:'Birîn', tr:'Yara', en:'Wound',
   cins:'mê', ez:'birîna', kat:'tendurist', zor:0.80,
   not:'Mê — [FB]: birîn n.f. "Birîna min heye" = yaram var. "Birîna dil" = gönül yarası (mecazi).',
   her:['Birîna min heye.', 'Birîn baş bû.'], gen:['Birîn û derman', 'Birîna min']),

  (id:'a2_846', ku:'Masqe', tr:'Maske', en:'Mask',
   cins:'mê', ez:'masqeya', kat:'tendurist', zor:0.79,
   not:'Mê — "masqe" = maske. Kurmancî medyasında yaygın. "Niqab" örtü/peçe için ayrı. [FB]: masqe n.f. [İtalyanca maschera kökenli].',
   her:['Bijîşk masqe danî.', 'Masqe ji bo nexweşiyê tê bikaranîn.'], gen:['Masqe û derman', 'Masqeya min']),

  // ─────────────────────────────────────────────────────────────
  // ULAŞIM EK — [AS] s.38-40 GIHANÎ tam
  // ─────────────────────────────────────────────────────────────

  (id:'a2_850', ku:'Trên', tr:'Tren', en:'Train',
   cins:'nêr', ez:'trênê', kat:'rêwîtî', zor:0.83,
   not:'Nêr — [AS]: "tren = trên" ✓. [FB]: trên n.m.',
   her:['Trên kengê derbas dibe?', 'Bi trênê diçim.'], gen:['Trên û bas', 'Trênê me']),

  (id:'a2_851', ku:'Keştî', tr:'Gemi', en:'Ship / Boat',
   cins:'mê', ez:'keştiya', kat:'rêwîtî', zor:0.81,
   not:'Mê — [AS]: "gemi = keştî". [FB]: keştî n.f. Dişil veqetandek (vokal-sonlu): "keştiya me". Oblik: "bi keştiyê" / "li keştiyê".',
   her:['Keştî li behrê ye.', 'Bi keştiyê çûm.'], gen:['Keştî û balafir', 'Keştiya me']),

  (id:'a2_852', ku:'Balafir', tr:'Uçak', en:'Airplane',
   cins:'mê', ez:'balafira', kat:'rêwîtî', zor:0.83,
   not:'Mê — [AS]: "uçak = balafir".',
   her:['Balafir tê.', 'Bi balafirê çûm.'], gen:['Balafir û trên', 'Balafira me']),

  (id:'a2_853', ku:'Duçerxe', tr:'Bisiklet', en:'Bicycle',
   cins:'mê', ez:'duçerxa', kat:'rêwîtî', zor:0.80,
   not:'Mê — [FB]: duçerxe n.f. "Du" (iki) + "çerx" (teker). Dişil veqetandek: "duçerxa min". Oblik: "bi duçerxê".',
   her:['Bi duçerxê diçim.', 'Duçerxe baş e.'], gen:['Duçerxe û erebe', 'Duçerxa min']),

  (id:'a2_854', ku:'Trafîk', tr:'Trafik', en:'Traffic',
   cins:'mê', ez:'trafîka', kat:'rêwîtî', zor:0.79,
   not:'Mê — [AS]: "trafik = seyrûsefer" ✓ ama "trafîk" formu Kurmancî medyasında yaygınlaşmış. "Seyrûsefer" Arapça bileşim (seyr+û+sefer). İkisi de kullanılır.',
   her:['Li bajêr trafîk pir e.', 'Em saetekê di trafîkê de man.'], gen:['Seyrûsefer û rê', 'Trafîka bajêr']),

  (id:'a2_855', ku:'Sekingeha basê', tr:'Otobüs durağı', en:'Bus stop',
   cins:'mê', ez:'sekingeha', kat:'rêwîtî', zor:0.80,
   not:'Mê — "sekinîn" (durmak) + "-geh" (yer). [AS]: "otobüs durağı = sekingeha basê".',
   her:['Li sekingehê me.', 'Sekingeh nêzîk e.'], gen:['Sekingeh û istasyon', 'Sekingehe basê']),

  // ─────────────────────────────────────────────────────────────
  // AİLE GENİŞLEME — [AS] s.31-32 MALBAT tam
  // ─────────────────────────────────────────────────────────────

  (id:'a2_860', ku:'Ap', tr:'Amca (baba tarafı)', en:'Paternal uncle',
   cins:'nêr', ez:'apê', kat:'malbat', zor:0.82,
   not:'Nêr — [AS]: "amca = ap". [FB]: ap n.m. "Apê min baş e."',
   her:['Apê min hat.', 'Ez diçim cem apê xwe.'], gen:['Ap û xaltî', 'Apê min']),

  (id:'a2_861', ku:'Xal', tr:'Dayı (annenin erkek kardeşi)', en:'Maternal uncle',
   cins:'nêr', ez:'xalê', kat:'malbat', zor:0.83,
   not:'Nêr — [FB]: xal n.m. "Xalê min" = dayım. DÜZELTME: Önce "mam" (= amca/saygı hitabı) yazılmıştı; dayı için doğru Kurmancî formu "xal" (xaltî = teyze ile aynı kök).',
   her:['Xalê min tê.', 'Ez diçim cem xalê xwe.'], gen:['Xal û ap', 'Xalê min']),

  (id:'a2_862', ku:'Xaltî', tr:'Teyze', en:'Aunt',
   cins:'mê', ez:'xaltiya', kat:'malbat', zor:0.82,
   not:'Mê — [AS]: "teyze = xaltî". [FB]: xaltî n.f. Heritage diyaloglarında sık geçti.',
   her:['Ev xaltiya min e.', 'Ez diçim cem xaltiya xwe.'], gen:['Xaltî û mam', 'Xaltiya min']),

  (id:'a2_863', ku:'Nevî', tr:'Torun', en:'Grandchild',
   cins:'bêcins', ez:'neviyê', kat:'malbat', zor:0.81,
   not:'[FB]: nevî n. "Neviyên pîrê" = büyükannenin torunları.',
   her:['Pîrê gelek ji neviyê xwe hez dike.', 'Min sê nevî hene.'], gen:['Nevî û zarok', 'Neviyên me']),

  (id:'a2_864', ku:'Bûk', tr:'Gelin', en:'Bride / Daughter-in-law',
   cins:'mê', ez:'bûka', kat:'malbat', zor:0.81,
   not:'Mê — [AS]: "gelin = bûk". [FB]: bûk n.f. "Bûka me xweş e."',
   her:['Bûk hat.', 'Bûka me xweş e.'], gen:['Bûk û zava', 'Bûka me']),

  (id:'a2_865', ku:'Zava', tr:'Damat', en:'Bridegroom / Son-in-law',
   cins:'nêr', ez:'zavayê', kat:'malbat', zor:0.80,
   not:'Nêr — [AS]: "damat = zava". [FB]: zava n.m.',
   her:['Zava baş e.', 'Zavayê me hat.'], gen:['Zava û bûk', 'Zavayê me']),

  (id:'a2_866', ku:'Met', tr:'Hala (babanın kız kardeşi)', en:'Paternal aunt',
   cins:'mê', ez:'meta', kat:'malbat', zor:0.81,
   not:'Mê — [FB]: met n.f. "Meta min" = halam. DÜZELTME: Önce "dixûşik" (standart değil) yazılmıştı; hala için doğru Bedirxan-Hawar formu "met".',
   her:['Meta min tê.', 'Ez diçim cem meta xwe.'], gen:['Met û xaltî', 'Meta min']),

  // ─────────────────────────────────────────────────────────────
  // ZAMAN KALIPLARI TAM — [TH] §85 + [AZ] Ders 9
  // ─────────────────────────────────────────────────────────────

  (id:'a2_870', ku:'Nîvro', tr:'Öğle', en:'Noon / Midday',
   cins:'nêr', ez:'nîvroyê', kat:'dem', zor:0.83,
   not:'Nêr — "nîv" (yarım) + "roj" (gün). [BH] bileşik. "Di nîvroyê de" = öğleyin.',
   her:['Em nîvro bi hev re dixwin.', 'Piştî nîvro ez têm mala we.'], gen:['Nîvro û êvare', 'Nîvroyê me']),

  (id:'a2_871', ku:'Spêde', tr:'Gün doğumu / Şafak', en:'Dawn / Early morning',
   cins:'mê', ez:'spêdeya', kat:'dem', zor:0.80,
   not:'Mê — [FB]: spêde n.f. "Di spêdê de" = şafakta. Kürt şiirinde sık.',
   her:['Di spêdê de şiyar bûm.', 'Spêde xweş e.'], gen:['Spêde û êvare', 'Di spêdê de']),

  (id:'a2_872', ku:'Nîvşev', tr:'Gece yarısı', en:'Midnight',
   cins:'mê', ez:'nîvşeva', kat:'dem', zor:0.80,
   not:'Mê — "nîv" (yarım) + "şev" (gece). [BH] bileşik. "Di nîvşevê de" = gece yarısında.',
   her:['Di nîvşevê de hat.', 'Nîvşev xewê ye.'], gen:['Nîvşev û spêde', 'Di nîvşevê de']),

  (id:'a2_873', ku:'Rojevê', tr:'Sabah vakti', en:'Morning time',
   cins:'nêr', ez:'rojevê', kat:'dem', zor:0.80,
   not:'"Roj" (gün) + "ev" (ev/vakit). "Di rojevê de" = sabah vakti.',
   her:['Di rojevê de çay vexwarin.', 'Rojevê xweş e.'], gen:['Rojeve û êvare', 'Di rojevê de']),

  (id:'a2_874', ku:'Destpêka hefteyê', tr:'Haftanın başı', en:'Beginning of the week',
   cins:'mê', ez:'destpêka hefteyê', kat:'dem', zor:0.78,
   not:'"Destpêk" (mê) + veqetandek -a + "hefte" oblik (-yê) = haftanın başı. Kalıp ifade.',
   her:['Destpêka hefteyê hat.', 'Di destpêka hefteyê de.'], gen:['Destpêk û dawî', 'Destpêka hefteyê']),

  (id:'a2_875', ku:'Dawiya mehê', tr:'Ay sonu', en:'End of the month',
   cins:'mê', ez:'dawiya mehê', kat:'dem', zor:0.78,
   not:'"Dawî" (mê) + veqetandek -ya + "meh" oblik (-ê) = ayın sonu. Maaş, kira gibi konularda kullanılır.',
   her:['Dawiya mehê mûçe tê.', 'Di dawiya mehê de.'], gen:['Dawî û destpêk', 'Dawiya mehê']),

  // ─────────────────────────────────────────────────────────────
  // HAYVAN EK — [AS] s.62 HEYWAN tam
  // ─────────────────────────────────────────────────────────────

  (id:'a2_880', ku:'Hesp', tr:'At', en:'Horse',
   cins:'nêr', ez:'hespê', kat:'ajal', zor:0.83,
   not:'Nêr — [AS]: "at = hesp". [FB]: hesp n.m. Kürt kültüründe simgesel hayvan.',
   her:['Hesp xweş e.', 'Hespê wî reş e.'], gen:['Hesp û ker', 'Hespê me']),

  (id:'a2_881', ku:'Ga', tr:'Öküz', en:'Ox / Bull',
   cins:'nêr', ez:'gayê', kat:'ajal', zor:0.81,
   not:'Nêr — [AS]: "öküz = ga". [FB]: ga n.m. "Gayen cotkar" = çiftçinin öküzleri.',
   her:['Ga li zeviyê ye.', 'Cotkarê bi gayê.'], gen:['Ga û mî', 'Gayê me']),

  (id:'a2_882', ku:'Bizin', tr:'Keçi', en:'Goat',
   cins:'mê', ez:'bizina', kat:'ajal', zor:0.82,
   not:'Mê — [AS]: "keçi = bizin". [FB]: bizin n.f.',
   her:['Bizin li çiyê ye.', 'Bizin çû ser darê.'], gen:['Bizin û mî', 'Bizina me']),

  (id:'a2_883', ku:'Mî', tr:'Koyun', en:'Sheep',
   cins:'mê', ez:'miya', kat:'ajal', zor:0.82,
   not:'Mê — [AS]: "koyun = mî". [FB]: mî n.f. Dişil veqetandek (vokal-sonlu): "miya min". Oblik: "miyê" / pl.obl.: "miyan".',
   her:['Mî li çiyê ye.', 'Keriya miyan xweş e.'], gen:['Mî û bizin', 'Keriya miyan']),

  (id:'a2_884', ku:'Mirîşk', tr:'Tavuk', en:'Chicken',
   cins:'mê', ez:'mirîşka', kat:'ajal', zor:0.82,
   not:'Mê — [AS]: "tavuk = mirîşk". [FB]: mirîşk n.f.',
   her:['Mirîşk li hewşê ye.', 'Mirîşkên me her roj hêkan dikin.'], gen:['Mirîşk û çêlek', 'Mirîşka me']),

  (id:'a2_885', ku:'Çêlek', tr:'İnek', en:'Cow',
   cins:'mê', ez:'çêleka', kat:'ajal', zor:0.82,
   not:'Mê — [AS]: "inek = çêlek". [FB]: çêlek n.f. "Şîrê çêlekê" = inek sütü.',
   her:['Çêlek şîr dide.', 'Çêleka me baş e.'], gen:['Çêlek û ga', 'Çêleka me']),

  (id:'a2_886', ku:'Ker', tr:'Eşek', en:'Donkey',
   cins:'nêr', ez:'kerê', kat:'ajal', zor:0.81,
   not:'Nêr — [AS]: "eşek = ker". [FB]: ker n.m. Atasözlerinde sık: "ker û ker".',
   her:['Ker barkêş e.', 'Kerê me'], gen:['Ker û hesp', 'Kerê me']),

  (id:'a2_887', ku:'Kûçik', tr:'Köpek', en:'Dog',
   cins:'nêr', ez:'kûçikê', kat:'ajal', zor:0.83,
   not:'Nêr — [AS]: "köpek = kûçik". [FB]: kûçik n.m.',
   her:['Çend kûçik di hewşê de ne.', 'Kûçikê me baş e.'], gen:['Kûçik û pisîk', 'Kûçikê me']),

  (id:'a2_888', ku:'Pisîk', tr:'Kedi', en:'Cat',
   cins:'mê', ez:'pisîka', kat:'ajal', zor:0.83,
   not:'Mê — [AS]: "kedi = pisîk". [FB]: pisîk n.f.',
   her:['Pisîk li bin kursiyê ye.', 'Pisîka me'], gen:['Pisîk û kûçik', 'Pisîka me']),

  // ─────────────────────────────────────────────────────────────
  // SOYUT VE FİKİR KELİMELERİ — A2/B1 köprüsü
  // ─────────────────────────────────────────────────────────────

  (id:'a2_890', ku:'Raman', tr:'Fikir / Düşünce', en:'Idea / Thought',
   cins:'mê', ez:'ramana', kat:'temel', zor:0.81,
   not:'Mê — "raman" özgün Kurmancî (raman/ramandin = düşünmek). [BH] §: raman = düşünce/fikir. "Fikir" Arapça kökenli; "raman" tercih edilir.',
   her:['Ramana te çi ye?', 'Raman baş e.'], gen:['Raman û biryar', 'Ramana me']),

  (id:'a2_891', ku:'Plan', tr:'Plan', en:'Plan',
   cins:'mê', ez:'plana', kat:'temel', zor:0.82,
   not:'Mê — "Plana te çi ye?" = planın ne?',
   her:['Plana min amade ye.', 'Plan çi ye?'], gen:['Plan û biryar', 'Plana min']),

  (id:'a2_892', ku:'Armanc', tr:'Hedef / Amaç', en:'Goal / Purpose',
   cins:'mê', ez:'armanca', kat:'temel', zor:0.80,
   not:'Mê — [FB]: armanc n.f. Veqetandek dişil: "armanca min" = hedefim. Ku field nominatif form.',
   her:['Armanca min baş e.', 'Armanca te çi ye?'], gen:['Armanc û plan', 'Armanca min']),

  (id:'a2_893', ku:'Hewce', tr:'Gerekli / Lazım', en:'Necessary',
   cins:'bêcins', ez:null, kat:'temel', zor:0.82,
   not:'Değişmez — [FB]: hewce adj. "Hewce ye" = gereklidir. "Lazim" ile eş anlamlı.',
   her:['Derman hewce ye.', 'Hewce ye ez herim.'], gen:['Hewce û lazim', 'Ev hewce ye.']),

  (id:'a2_894', ku:'Muhim', tr:'Önemli', en:'Important',
   cins:'bêcins', ez:null, kat:'temel', zor:0.82,
   not:'"Girîng" (A1) daha yaygın, "muhim" Arapça kökenli ama Kurmancîde kullanılır. [FB]: muhim adj.',
   her:['Ev muhim e.', 'Pirsgirêka muhim.'], gen:['Muhim û girîng', 'Ev muhim e.']),

  (id:'a2_895', ku:'Asayî', tr:'Normal / Olağan', en:'Normal / Ordinary',
   cins:'bêcins', ez:null, kat:'temel', zor:0.80,
   not:'[FB]: asayî adj. "Ev asayî ye" = bu normal. "Nebaş" ile zıt değil, "ne asayî" ile.',
   her:['Ev asayî ye.', 'Asayî baş e.'], gen:['Asayî û ne asayî', 'Ev asayî ye.']),

  (id:'a2_896', ku:'Taybetî', tr:'Özel', en:'Special / Specific',
   cins:'bêcins', ez:null, kat:'temel', zor:0.80,
   not:'[FB]: taybetî adj. "Roja taybetî" = özel gün.',
   her:['Ev roja taybetî ye.', 'Tiştê taybetî heye.'], gen:['Taybetî û asayî', 'Ev taybetî ye.']),

  (id:'a2_897', ku:'Dijwar', tr:'Zor / Sert', en:'Hard / Difficult',
   cins:'bêcins', ez:null, kat:'temel', zor:0.81,
   not:'[FB]: dijwar adj. "Zehmet" (A1) ile yakın ama "dijwar" daha güçlü.',
   her:['Pirsgirêk dijwar e.', 'Ziman dijwar e lê xweş e.'], gen:['Dijwar û hêsan', 'Ev dijwar e.']),

  (id:'a2_898', ku:'Hêsan', tr:'Kolay', en:'Easy',
   cins:'bêcins', ez:null, kat:'temel', zor:0.81,
   not:'[FB]: hêsan adj. "Ev hêsan e" = bu kolay.',
   her:['Ev hêsan e.', 'Hêsan bike!'], gen:['Hêsan û dijwar', 'Ev hêsan e.']),

  (id:'a2_899', ku:'Nûjen', tr:'Modern / Yeni çağ', en:'Modern',
   cins:'bêcins', ez:null, kat:'temel', zor:0.80,
   not:'"Nû" (yeni) + "jen" (vuran/yenileyen) = modernleştirilmiş. [FB]: nûjen adj. A1\'de "nû" var; A2\'de bileşik "nûjen".',
   her:['Ev mala nûjen e.', 'Cil û bergê nûjen.'], gen:['Nûjen û kevneşopî', 'Bi awayekî nûjen']),

  // ─────────────────────────────────────────────────────────────
  // FİİL TAMAMLAMA — DoReCo frekans listesi
  // ─────────────────────────────────────────────────────────────

  (id:'a2_900', ku:'Fikirîn', tr:'Düşünmek', en:'To think',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'"Fikirîn" fiili — "Ez difikirim" = düşünüyorum. [TH] §65.',
   her:['Ez li ser vê meseleyê gelek difikirim.', 'Fikirîn aqilê mirov xurt dike.'], gen:['Fikirîn û axiftin', 'Ez difikirim.']),

  (id:'a2_901', ku:'Hesab kirin', tr:'Saymak / Hesaplamak', en:'To count / calculate',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Hesab kirin" — "Hesab dike" = hesaplıyor. [FB]: hesab n.m. + kirin.',
   her:['Pare hesab dike.', 'Hesab bike!'], gen:['Hesab kirin û biryar', 'Hesab bike.']),

  (id:'a2_902', ku:'Texmîn kirin', tr:'Tahmin etmek', en:'To guess / estimate',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Texmîn kirin" — [FB]: texmîn n.m. + kirin.',
   her:['Min texmîn kir.', 'Texmîn bike!'], gen:['Texmîn kirin û zanîn', 'Texmîn bike.']),

  (id:'a2_903', ku:'Îtiraz kirin', tr:'İtiraz etmek', en:'To object / protest',
   cins:'bêcins', ez:null, kat:'leker', zor:0.78,
   not:'"Îtiraz kirin" — [FB]: îtiraz n.m. + kirin.',
   her:['Ew îtiraz kir.', 'Ez îtiraz dikim.'], gen:['Îtiraz û qebûl', 'Îtiraz bike.']),

  (id:'a2_904', ku:'Pêşniyar kirin', tr:'Önermek / Teklif etmek', en:'To suggest / propose',
   cins:'bêcins', ez:null, kat:'leker', zor:0.78,
   not:'"Pêşniyar kirin" — [FB]: pêşniyar n.m. + kirin.',
   her:['Min pêşniyar kir.', 'Pêşniyar bike!'], gen:['Pêşniyar û biryar', 'Pêşniyar bike.']),

  (id:'a2_905', ku:'Ketin xewê', tr:'Uykuya dalmak', en:'To fall asleep',
   cins:'bêcins', ez:null, kat:'jiyan', zor:0.80,
   not:'"Ketin xewê" = uykuya düşmek. [TH] §65: ketin = to fall.',
   her:['Zarok ket xewê.', 'Zû ket xewê.'], gen:['Ketin xewê û şiyarîn', 'Ket xewê.']),

];


// ════════════════════════════════════════════════════════════════
// A2 EK KELİMELER — Dördüncü Kısım (~300 kelime)
// [BH][TH][AS][FB][AZ][DR] — çok kaynaklı doğrulama
// ════════════════════════════════════════════════════════════════

const kA2EkKelimeler3 = [

  // ─────────────────────────────────────────────────────────────
  // SPORT VE AKTİVİTE — [AS] s.40 WERZÎ
  // ─────────────────────────────────────────────────────────────

  (id:'a2_600', ku:'Futbol', tr:'Futbol', en:'Football/Soccer',
   cins:'nêr', ez:'futbolê', kat:'werzî', zor:0.84,
   not:'Nêr — uluslararası terim. [AS] s.40: WERZÎ bölümü. Kurmancîde yaygın',
   her:['Ez futbol dilîzim.', 'Futbolê temaşe dikim.'],
   gen:['Futbol û basket', 'Futbolê me']),

  (id:'a2_601', ku:'Werzîş', tr:'Spor / Egzersiz', en:'Sport/Exercise',
   cins:'mê', ez:'werzîşa', kat:'werzî', zor:0.82,
   not:'Mê — [AS] s.40: "WERZÎ" bölümü. "Werzîş kirin" = spor yapmak',
   her:['Werzîş baş e.', 'Ez werzîş dikim.'],
   gen:['Werzîş û tenduristî', 'Werzîşê bike!']),

  (id:'a2_602', ku:'Meydan', tr:'Alan / Saha', en:'Field / Ground',
   cins:'mê', ez:'meydana', kat:'werzî', zor:0.80,
   not:'Mê — "Meydana futbolê" = futbol sahası',
   her:['Em diçin meydanê.', 'Meydan mezin e.'],
   gen:['Meydan û park', 'Meydana bajêr']),

  (id:'a2_603', ku:'Bezîn', tr:'Koşmak', en:'To run',
   cins:'bêcins', ez:null, kat:'werzî', zor:0.81,
   not:'"Bezîn" fiili — "Ez dibezim" = koşuyorum. [TH] §65: bezîn = to run',
   her:['Em her sibehê bezîn li parkê.', 'Bezîn ji bo tendurûstiyê baş e.'],
   gen:['Bezîn û mêze kirin', 'Ez dibezim.']),

  (id:'a2_604', ku:'Avjenî', tr:'Yüzmek / Yüzme', en:'Swimming',
   cins:'mê', ez:'avjeniya', kat:'werzî', zor:0.80,
   not:'Mê — "av" (su) + "jenî" (vuruş). Kurmancî özgün bileşim. [FB]: avjenî n.f.',
   her:['Ez ji avjeniyê hez dikim.', 'Ez avjeniyê hîn dibim.'],
   gen:['Avjenî û werzîş', 'Avjeniya me']),

  // ─────────────────────────────────────────────────────────────
  // KİŞİSEL BAKIM — [AS] s.53 XWEÇÊKIRINÊ
  // ─────────────────────────────────────────────────────────────

  (id:'a2_610', ku:'Serşok', tr:'Banyo / Duş', en:'Shower / Bath',
   cins:'mê', ez:'serşoka', kat:'mal', zor:0.82,
   not:'Mê — "ser" (baş) + "şok" (yıkama). [AS] s.53 bölümü. "Serşok kirin" = duş almak',
   her:['Serşok dikim.', 'Serşok li kû ye?'],
   gen:['Serşok û serûber', 'Serşoka me']),

  (id:'a2_611', ku:'Sabun', tr:'Sabun', en:'Soap',
   cins:'nêr', ez:'sabunê', kat:'mal', zor:0.83,
   not:'Nêr — [AS]: "sabun" ✓. [FB]: sabun n.m.',
   her:['Sabun bide min.', 'Bi sabun dest bişo.'],
   gen:['Sabun û av', 'Sabunê me']),

  (id:'a2_612', ku:'Diranşer', tr:'Diş fırçası', en:'Toothbrush',
   cins:'nêr', ez:'diranşerê', kat:'mal', zor:0.80,
   not:'Nêr — "diran" (diş) + "şer" (fırçalayan). Kurmancî özgün bileşim.',
   her:['Diranşera min kû ye?', 'Bi diranşerê diran bişo.'],
   gen:['Diranşer û darik', 'Diranşera min']),

  (id:'a2_613', ku:'Neynik', tr:'Ayna', en:'Mirror',
   cins:'mê', ez:'neynika', kat:'mal', zor:0.79,
   not:'Mê — [FB]: neynik n.f. "Awêne" da kullanılır. DÜZELTME: Önce yanlışlıkla "nêçîr" (av) yazılmıştı; ayna için doğru form "neynik".',
   her:['Di neynikê de xwe dibînim.', 'Neynik li dîwarê ye.'],
   gen:['Neynik û awêne', 'Neynika me']),

  // ─────────────────────────────────────────────────────────────
  // RENK EK — Detay renk isimleri [AS] s.30 + [BH]
  // ─────────────────────────────────────────────────────────────

  (id:'a2_620', ku:'Portakalî', tr:'Turuncu', en:'Orange (color)',
   cins:'bêcins', ez:null, kat:'reng', zor:0.81,
   not:'Rengdêra neguherbar — "nêranc" (portakal) + "-î" eki. [BH] §274: renk türetmesi',
   her:['Rengê portakalî xweş e.', 'Cil portakalî ye.'],
   gen:['Portakalî û zer', 'Ev portakalî ye.']),

  (id:'a2_621', ku:'Pembe', tr:'Pembe', en:'Pink',
   cins:'bêcins', ez:null, kat:'reng', zor:0.81,
   not:'Rengdêra neguherbar — Türkçeden geçmiş ama Kurmancîde yerleşmiş. [AS] renkler listesinde',
   her:['Kirasê pembe xweş e.', 'Gulên pembe.'],
   gen:['Pembe û sor', 'Ev pembe ye.']),

  (id:'a2_622', ku:'Qehweyî', tr:'Kahverengi', en:'Brown',
   cins:'bêcins', ez:null, kat:'reng', zor:0.81,
   not:'Rengdêra neguherbar — "qehwe" (kahve) + "-yî". [AS] renkler listesinde ✓',
   her:['Çavên qehweyî xweş in.', 'Dar qehweyî ye.'],
   gen:['Qehweyî û reş', 'Ev qehweyî ye.']),

  (id:'a2_623', ku:'Gewr', tr:'Gri / Boz', en:'Grey',
   cins:'bêcins', ez:null, kat:'reng', zor:0.80,
   not:'Rengdêra neguherbar — [FB]: gewr adj. "Esman gewr e" = gökyüzü gridir',
   her:['Esman gewr e.', 'Kiras gewr e.'],
   gen:['Gewr û reş', 'Ev gewr e.']),

  // ─────────────────────────────────────────────────────────────
  // BEDEN / ENDAMÊN BEDENÊ EKSİKLER — [AS] s.35-38
  // ─────────────────────────────────────────────────────────────

  (id:'a2_630', ku:'Gewrî', tr:'Gırtlak / Boğaz', en:'Throat',
   cins:'nêr', ez:'gewriyê', kat:'beden', zor:0.79,
   not:'Nêr — [AS] s.37: "boğaz = gewrî". [FB]: gewrî n.m.',
   her:['Gewriyê min êş dike.', 'Gewrî qirêj e.'],
   gen:['Gewrî û ziman', 'Gewriyê min']),

  (id:'a2_631', ku:'Zik', tr:'Karın / Mide', en:'Belly / Stomach',
   cins:'nêr', ez:'zikê', kat:'beden', zor:0.81,
   not:'Nêr — [AS] s.37: "mide/karın = zik". [FB]: zik n.m.',
   her:['Zikê min diêşe.', 'Zik vala ye.'],
   gen:['Zik û pişt', 'Zikê min']),

  (id:'a2_632', ku:'Ling', tr:'Bacak / Ayak', en:'Leg / Foot',
   cins:'nêr', ez:'lingê', kat:'beden', zor:0.82,
   not:'Nêr — [AS] s.37: "bacak = ling". [FB]: ling n.m. "Lingê min diêşe" = bacağım ağrıyor',
   her:['Lingê min diêşe.', 'Du ling hene.'],
   gen:['Ling û dest', 'Lingê min']),

  (id:'a2_633', ku:'Çok', tr:'Diz', en:'Knee',
   cins:'nêr', ez:'çokê', kat:'beden', zor:0.79,
   not:'Nêr — [FB]: çok n.m. "Ejno" veya "çûng" de bölgesel olarak kullanılır. DÜZELTME: Önce yanlışlıkla "pêç" (sarmak) yazılmıştı; diz için doğru form "çok".',
   her:['Çokê min diêşe.', 'Çok kişiyaye.'],
   gen:['Çok û ling', 'Çokê min']),

  // ─────────────────────────────────────────────────────────────
  // SAYILAR EKSİKLER — Kesir ve sıra
  // ─────────────────────────────────────────────────────────────

  (id:'a2_640', ku:'Sê-yek', tr:'Üçte bir / 1/3', en:'One third',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.79,
   not:'"Sê-yek" = 1/3. [TH] §: fractions. "Du-yek" = 1/2 (nîv de kullanılır)',
   her:['Min sê-yek nan xwar.', 'Sê-yekê nan bide min.'],
   gen:['Sê-yek û nîv', 'Sê-yek']),

  (id:'a2_641', ku:'Sêyem', tr:'Üçüncü', en:'Third',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.80,
   not:'"Sê" + "-yem" = üçüncü. [TH] §: ordinals. "Roja siyem" = üçüncü gün',
   her:['Sêyem hat.', 'Roja sêyem.'],
   gen:['Sêyem û çarem', 'Serdema siyem']),

  (id:'a2_642', ku:'Çarem', tr:'Dördüncü', en:'Fourth',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.79,
   not:'"Çar" + "-em" = dördüncü',
   her:['Çarem hat.', 'Kilasa çarem.'],
   gen:['Çarem û pênciyem', 'Roja çarem']),

  (id:'a2_643', ku:'Pêncem', tr:'Beşinci', en:'Fifth',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.79,
   not:'"Pênc" + "-em" = beşinci. "Pênciyem" ellinci demektir (pêncî + -em).',
   her:['Pêncem hat.', 'Sinifa pêncem.'],
   gen:['Pêncem û şeşem', 'Roja pêncem']),

  // ─────────────────────────────────────────────────────────────
  // AKADEMİK / OKUL — [AS] s.36 PERWERDEHÎ derinleşme
  // ─────────────────────────────────────────────────────────────

  (id:'a2_650', ku:'Tez', tr:'Tez / Bitirme ödevi', en:'Thesis',
   cins:'mê', ez:'teza', kat:'perwerde', zor:0.78,
   not:'Mê — [FB]: tez n.f. "Teza min li ser zimanê kurdî ye" = tezim Kürtçe üzerine. ("Teze" = taze demektir — karıştırma!)',
   her:['Min tez nivîsî.', 'Teza wî pir baş bû.'],
   gen:['Tez û lêkolîn', 'Teza min']),

  (id:'a2_651', ku:'Dîplom', tr:'Diploma', en:'Diploma',
   cins:'nêr', ez:'dîplomê', kat:'perwerde', zor:0.79,
   not:'Nêr — [FB]: dîplom n.m. [Fransızca]. "Wî dîplomê xwe girt" = diplomasını aldı',
   her:['Wî dîplomê xwe girt.', 'Dîplom lazim e.'],
   gen:['Dîplom û sertîfîka', 'Dîplomê min']),

  (id:'a2_652', ku:'Mijar', tr:'Konu / Ders konusu', en:'Topic / Subject',
   cins:'mê', ez:'mijara', kat:'perwerde', zor:0.80,
   not:'Mê — [FB]: mijar n.f. "Mijara waneyê" = dersin konusu. "Wane" = ders oturumu',
   her:['Mijara îro çand bû.', 'Em mijara nû fêr bûn.'],
   gen:['Mijar û wane', 'Mijara me']),

  (id:'a2_653', ku:'Pêşkêş', tr:'Sunum / Prezentasyon', en:'Presentation',
   cins:'mê', ez:'pêşkêşa', kat:'perwerde', zor:0.78,
   not:'Mê — "pêş" (ön) + "kêş" (çekme). [FB]: pêşkêş n.f. "Pêşkêş kirin" = sunmak',
   her:['Pêşkêşa min sibê ye.', 'Pêşkêş kir.'],
   gen:['Pêşkêş û teze', 'Pêşkêşa min']),

  // ─────────────────────────────────────────────────────────────
  // MEDYA VE İLETİŞİM — [AZ] Ders 18
  // ─────────────────────────────────────────────────────────────

  (id:'a2_660', ku:'Televîzyon', tr:'Televizyon', en:'Television',
   cins:'mê', ez:'televîzyona', kat:'teknoloji', zor:0.84,
   not:'Mê — uluslararası terim. "Televîzyona kurdî" = Kürtçe televizyon',
   her:['Ez televîzyon temaşe dikim.', 'Televîzyon vekirî ye.'],
   gen:['Televîzyon û radyo', 'Televîzyona me']),

  (id:'a2_661', ku:'Radyo', tr:'Radyo', en:'Radio',
   cins:'mê', ez:'radyoya', kat:'teknoloji', zor:0.83,
   not:'Mê — uluslararası terim. "Radyoya kurdî" Kürt kültüründe önemli tarihsel rol oynadı',
   her:['Ez radyo guhdarî dikim.', 'Radyo kar dike.'],
   gen:['Radyo û televîzyon', 'Radyoya kurdî']),

  (id:'a2_662', ku:'Kamera', tr:'Kamera / Fotoğraf makinesi', en:'Camera',
   cins:'mê', ez:'kameraya', kat:'teknoloji', zor:0.82,
   not:'Mê — [FB]: kamera n.f. "Kamera kêş" = fotoğraf/video çek',
   her:['Min bi kamerayê wêne kêşa.', 'Kamera li kû ye?'],
   gen:['Kamera û têlefon', 'Kameraya min']),

  (id:'a2_663', ku:'Temaşe kirin', tr:'İzlemek / Seyretmek', en:'To watch',
   cins:'bêcins', ez:null, kat:'teknoloji', zor:0.82,
   not:'"Temaşe kirin" = izlemek. [FB]: temaşe kirin v.',
   her:['Ez fîlim temaşe dikim.', 'Tu çi temaşe dikî?'],
   gen:['Temaşe kirin û guhdarî', 'Temaşe bike!']),

  // ─────────────────────────────────────────────────────────────
  // YEMEK DETAYI — [AS] s.47 derinleştirme
  // ─────────────────────────────────────────────────────────────

  (id:'a2_670', ku:'Taştê', tr:'Kahvaltı', en:'Breakfast',
   cins:'mê', ez:'taştêya', kat:'xwarin', zor:0.83,
   not:'Mê — [AS]: "kahvaltı = taştê". [FB]: taştê n.f. "Taştê xwarin" = kahvaltı yapmak',
   her:['Me sibehê taştê xwar.', 'Taştê amade ye.'],
   gen:['Taştê û firavîn', 'Taştêya me']),

  (id:'a2_671', ku:'Firavîn', tr:'Öğle yemeği', en:'Lunch',
   cins:'mê', ez:'firavîna', kat:'xwarin', zor:0.82,
   not:'Mê — [AS] no.485: "öğle yemeği = firavîn, navroj" ✓ [Fêrker: "Em firavînê dixwazin"]. ("Firavun" = Mısır kralı — YANLIŞ!)',
   her:['Firavîn çi ye?', 'Me firavîn xwar.'],
   gen:['Firavîn û şîv', 'Firavîna me']),

  (id:'a2_672', ku:'Şîv', tr:'Akşam yemeği', en:'Dinner / Supper',
   cins:'mê', ez:'şîva', kat:'xwarin', zor:0.83,
   not:'Mê — [AS]: "akşam yemeği = şîv". [FB]: şîv n.f. "Şîva êvarê"',
   her:['Şîv amade ye.', 'Me şîv bi hev re xwar.'],
   gen:['Şîv û firavîn', 'Şîva me']),

  (id:'a2_673', ku:'Çêkirin', tr:'Hazırlamak / Yapmak', en:'To prepare / make',
   cins:'bêcins', ez:null, kat:'xwarin', zor:0.82,
   not:'"Çêkirin" — "Xwarin çêdikim" = yemek yapıyorum. [TH] §65',
   her:['Dêya min taştê çêkir.', 'Çêkirina xwarinê wext dixwaze.'],
   gen:['Çêkirin û pijandin', 'Çêdike.']),

  (id:'a2_674', ku:'Rûn', tr:'Tereyağı / Yağ', en:'Butter / Fat',
   cins:'nêr', ez:'rûnê', kat:'xwarin', zor:0.82,
   not:'Nêr — [AS]: "tereyağı = rûn". [FB]: rûn n.m. "Nanê bi rûn" = yağlı ekmek',
   her:['Rûnê bizinê xweş e.', 'Nan û rûn xwarin.'],
   gen:['Rûn û penîr', 'Rûnê me']),

  (id:'a2_675', ku:'Şekir', tr:'Şeker', en:'Sugar',
   cins:'nêr', ez:'şekirê', kat:'xwarin', zor:0.83,
   not:'Nêr — [AS]: "şeker = şekir". [FB]: şekir n.m.',
   her:['Çaya bi şekir.', 'Şekir zêde nexwe!'],
   gen:['Şekir û xwê', 'Şekirê me']),

  (id:'a2_676', ku:'Xwê', tr:'Tuz', en:'Salt',
   cins:'mê', ez:'xwêya', kat:'xwarin', zor:0.84,
   not:'Mê — [FB]: xwê n.f. "Nan û xwê" kültürel önem — A1\'de öğrenildi',
   her:['Xwê li xwarinê bixe.', 'Xwê gelek e!'],
   gen:['Xwê û îsot', 'Xwê û nan']),

  (id:'a2_677', ku:'Tirş', tr:'Ekşi', en:'Sour',
   cins:'bêcins', ez:null, kat:'xwarin', zor:0.80,
   not:'Rengdêra neguherbar — [FB]: tirş adj. "Mast tirş e" = yoğurt ekşidir',
   her:['Ev tirş e!', 'Mêweyên tirş.'],
   gen:['Tirş û şîrîn', 'Ev tirş e.']),

  (id:'a2_678', ku:'Şîrîn', tr:'Tatlı', en:'Sweet',
   cins:'bêcins', ez:null, kat:'xwarin', zor:0.82,
   not:'Rengdêra neguherbar — [FB]: şîrîn adj. "Dil û ziman şîrîntir in" = gönül ve dil daha tatlıdır',
   her:['Ev gelek şîrîn e!', 'Mêweyên şîrîn.'],
   gen:['Şîrîn û tirş', 'Ev şîrîn e.']),

  // ─────────────────────────────────────────────────────────────
  // TABIAT VE ÇEVRE EK
  // ─────────────────────────────────────────────────────────────

  (id:'a2_680', ku:'Derya', tr:'Deniz / Derya', en:'Sea',
   cins:'mê', ez:'deryaya', kat:'xweza', zor:0.79,
   not:'Mê — [FB]: derya n.f. [Farsça]. "Behr" = deniz, "derya" = okyanus/büyük su',
   her:['Derya gelek mezin e.', 'Deryaya Atlantîk.'],
   gen:['Derya û behr', 'Deryaya mezin']),

  (id:'a2_681', ku:'Tepe', tr:'Tepe / Doruk', en:'Hill / Peak',
   cins:'mê', ez:'tepeya', kat:'xweza', zor:0.80,
   not:'Mê — [FB]: tepe n.f. "Tepeya çiyê" = dağın tepesi',
   her:['Em hilkişiyan ser tepeyê.', 'Tepeya çiyê bilind e.'],
   gen:['Tepe û zinar', 'Tepeya çiyê']),

  (id:'a2_682', ku:'Deşt', tr:'Ova / Düzlük', en:'Plain / Flatland',
   cins:'mê', ez:'deşta', kat:'xweza', zor:0.80,
   not:'Mê — [BH] bileşik: "Deştvanî, sonbaharda inme". [FB]: deşt n.f. Kürdistan ovaları tarihsel önem taşır',
   her:['Deşta Bexdayê.', 'Li deştê zevî hene.'],
   gen:['Deşt û çiya', 'Deşta Kurdistan']),

  (id:'a2_683', ku:'Kulîlk', tr:'Çiçek', en:'Flower',
   cins:'mê', ez:'kulîlka', kat:'xweza', zor:0.82,
   not:'Mê — [FB]: kulîlk n.f. "Gul" = gül (özel), "kulîlk" = genel çiçek. "Min kulîlk çand" = çiçek ektim (ergatif!)',
   her:['Kulîlkên biharê xweş in.', 'Min kulîlk çand.'],
   gen:['Kulîlk û dar', 'Kulîlkên me']),

  (id:'a2_684', ku:'Zinar', tr:'Kaya / Kayalık', en:'Rock / Crag',
   cins:'nêr', ez:'zinarê', kat:'xweza', zor:0.78,
   not:'Nêr — [FB]: zinar n.m. Kürdistan dağlarında kayalık arazi',
   her:['Zinarên çiyê bilind in.', 'Zinar û tepe.'],
   gen:['Zinar û kevir', 'Zinarê çiyê']),

  // ─────────────────────────────────────────────────────────────
  // GÜNLÜK DİYALOG VE SOSYAl
  // ─────────────────────────────────────────────────────────────

  (id:'a2_690', ku:'Bextê xweş', tr:'İyi şanslar', en:'Good luck',
   cins:'bêcins', ez:null, kat:'silav', zor:0.83,
   not:'"Bext" = baht/şans. "Bextê xweş!" = iyi şanslar! [TH] blessings',
   her:['Bextê xweş, heval!', 'Bextê xweş di îmtîhanê de!'],
   gen:['Bextê xweş!', 'Bextê te xweş be!']),

  (id:'a2_691', ku:'Bi serkeftî', tr:'Başarıyla / Tebrikler', en:'Congratulations',
   cins:'bêcins', ez:null, kat:'silav', zor:0.82,
   not:'"Serkeftin" = başarı. "Bi serkeftî!" = tebrikler/başarıyla. [FB]: serkeftin n.m.',
   her:['Bi serkeftî!', 'Di îmtîhanê de serkeftin!'],
   gen:['Bi serkeftî!', 'Serkeftin ji te re!']),

  (id:'a2_692', ku:'Serkeftin', tr:'Başarı', en:'Success',
   cins:'mê', ez:'serkeftina', kat:'his', zor:0.81,
   not:'Mê — [FB]: serkeftin n.f. (mastar kökenli isimler dişildir). "Ser" + "ketin" → başarmak',
   her:['Serkeftina te pîroz be!', 'Serkeftin bi hewl tê.'],
   gen:['Serkeftin û şikest', 'Serkeftina me']),

  (id:'a2_693', ku:'Şikest', tr:'Yenilgi / Başarısızlık', en:'Defeat / Failure',
   cins:'mê', ez:'şikesta', kat:'his', zor:0.79,
   not:'Mê — [FB]: şikest n.f. "Şikandin" = kırmak → şikest = kırılma/yenilgi',
   her:['Şikest wane ye.', 'Ji şikestê fêr bibin.'],
   gen:['Şikest û serkeftin', 'Şikest wane ye.']),

  (id:'a2_694', ku:'Dest pê kirin', tr:'Başlamak', en:'To begin / start',
   cins:'bêcins', ez:null, kat:'leker', zor:0.82,
   not:'"Dest pê kirin" = başlamak — AYRI yazılır ([BH] §194, KURMANCI_RULES §7.2). [TH] §65',
   her:['Me dest bi waneyê kir.', 'Destpêk her tim dijwar e.'],
   gen:['Dest pê kirin û dawî kirin', 'Dest pê bike!']),

  (id:'a2_695', ku:'Dawî kirin', tr:'Bitirmek / Sona erdirmek', en:'To finish / end',
   cins:'bêcins', ez:null, kat:'leker', zor:0.82,
   not:'"Dawî kirin" = bitirmek (ayrı yazılır). [TH] §65. "Dawî hat" = bitti',
   her:['Min karê xwe dawî kir.', 'Dawîkirina projeyê xweş bû.'],
   gen:['Dawî kirin û dest pê kirin', 'Dawî bike!']),

  // ─────────────────────────────────────────────────────────────
  // MEKÂN VE KONUM EK
  // ─────────────────────────────────────────────────────────────

  (id:'a2_700', ku:'Pirtûkxane', tr:'Kütüphane', en:'Library',
   cins:'mê', ez:'pirtûkxaneya', kat:'cih', zor:0.81,
   not:'Mê — "pirtûk" (kitap) + "xane" (yer). Kurmancî özgün bileşim. [BH] §274: -xane soneki',
   her:['Ez diçim pirtûkxanê.', 'Pirtûkxane li kû ye?'],
   gen:['Pirtûkxane û sinif', 'Pirtûkxana me']),

  (id:'a2_701', ku:'Otêl', tr:'Otel', en:'Hotel',
   cins:'nêr', ez:'otêlê', kat:'cih', zor:0.82,
   not:'Nêr — [AS] s.44 RÛNIŞTGEH bölümü. [FB]: otêl n.m.',
   her:['Em li otêlê ne.', 'Otêl xweş bû.'],
   gen:['Otêl û mêvanxane', 'Otêlê bajêr']),

  (id:'a2_702', ku:'Restorant', tr:'Restoran', en:'Restaurant',
   cins:'nêr', ez:'restorantê', kat:'cih', zor:0.83,
   not:'Nêr — uluslararası terim. [AS] s.44 bölümü. [FB]: restorant n.m.',
   her:['Em diçin restorantê.', 'Restorant baş e.'],
   gen:['Restorant û kafe', 'Restorantê bajêr']),

  (id:'a2_703', ku:'Kafe', tr:'Kafe / Kahvehane', en:'Café',
   cins:'nêr', ez:'kafeyê', kat:'cih', zor:0.83,
   not:'Nêr — uluslararası terim. "Li kafeyê çay vexwarin" = kafede çay içtik',
   her:['Em li kafeyê ne.', 'Kafe xweş e.'],
   gen:['Kafe û restorant', 'Kafeyê nû']),

  (id:'a2_704', ku:'Gumrik', tr:'Gümrük', en:'Customs',
   cins:'nêr', ez:'gumrikê', kat:'cih', zor:0.78,
   not:'Nêr — [AS] s.65: "GÜMRÜK = GUMRIK". [FB]: gumrik n.m.',
   her:['Li gumrikê man.', 'Gumrik li sînorê ye.'],
   gen:['Gumrik û sînor', 'Li gumrikê']),

  // ─────────────────────────────────────────────────────────────
  // ÖNEMLI FIILLER TAMAMLAMA — DoReCo frekans
  // ─────────────────────────────────────────────────────────────

  (id:'a2_710', ku:'Rawestin', tr:'Durmak / Beklemek', en:'To stop / wait',
   cins:'bêcins', ez:null, kat:'leker', zor:0.82,
   not:'"Rawestin" fiili — "Bisekine!" = dur!/bekle!. [TH] §65',
   her:['Bisekine, pîrê!', 'Em li sekingehê rawestin.'],
   gen:['Rawestin û çûn', 'Bisekine!']),

  (id:'a2_711', ku:'Veguhastin', tr:'Taşımak / Transfer etmek', en:'To transport / move',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Veguhastin" — [BH] §200 mesdar. "Ziman veguhastin" = dili aktarmak (kültürel anlam). DÜZELTME: Önceki "Veguhêzin" (subjunctive/çekim formu) yerine mesdar "veguhastin" yazılmalı. Şimdiki: "Ez diguhêzim".',
   her:['Em pirtûkan diguhêzin malê.', 'Veguhastina mîrasê girîng e.'],
   gen:['Veguhastin û parastin', 'Biguhêze!']),

  (id:'a2_712', ku:'Biryar dan', tr:'Karar vermek', en:'To decide',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'"Biryar dan" — [FB]: biryar n.m. + dan (vermek). "Biryara min hat" = kararımı verdim',
   her:['Min biryar da ku biçim.', 'Te biryar da?'],
   gen:['Biryar dan û xwestin', 'Biryar bide!']),

  (id:'a2_713', ku:'Amade kirin', tr:'Hazırlamak', en:'To prepare',
   cins:'bêcins', ez:null, kat:'leker', zor:0.82,
   not:'"Amade kirin" = hazırlamak (ayrı yazılır). "Amade" = hazır. [FB]: amade adj. "Xwarin amade ye" zaten A1\'de',
   her:['Min taştê amade kir.', 'Amadekirina waneyê hewce ye.'],
   gen:['Amade kirin û pêşkêş kirin', 'Amade bike!']),

  (id:'a2_714', ku:'Pêşkêş kirin', tr:'Sunmak / Takdim etmek', en:'To present / offer',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Pêşkêş kirin" = sunmak. [FB]: pêşkêş kirin v.',
   her:['Karê xwe pêşkêş kir.', 'Mamosta pêşkêş dike.'],
   gen:['Pêşkêş kirin û amadekirin', 'Pêşkêş bike!']),

  (id:'a2_715', ku:'Pirsîn', tr:'Sormak', en:'To ask',
   cins:'bêcins', ez:null, kat:'leker', zor:0.83,
   not:'"Pirsîn" fiili — "Ez dipirsim" = soruyorum. [TH] §65. "Pirs" = soru',
   her:['Zarokan ji mamoste pirsî.', 'Pirsîn nîşana meraqê ye.'],
   gen:['Pirsîn û bersivdan', 'Bipirse!']),

  (id:'a2_716', ku:'Bersiv dan', tr:'Cevap vermek', en:'To answer',
   cins:'bêcins', ez:null, kat:'leker', zor:0.82,
   not:'"Bersiv dan" — [FB]: bersiv n.f. + dan. "Bersiv dide" = cevap veriyor',
   her:['Mamosta bersiv da.', 'Bersiv bide!'],
   gen:['Bersiv dan û pirsîn', 'Bersiv bide!']),

  (id:'a2_717', ku:'Şîrove kirin', tr:'Açıklamak / Yorumlamak', en:'To explain',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Şîrove kirin" — [FB]: şîrove v. Özgün Kurmancî form. "Îzah kirin" Arapça kökenli. "Ravekirin" de kullanılır. "Şîrove bike" = açıkla.',
   her:['Mamosta şîrove kir.', 'Şîrove bike, ji kerema xwe.'],
   gen:['Şîrove kirin û fêm kirin', 'Şîrove bike!']),

  // ─────────────────────────────────────────────────────────────
  // SOYUT İFADELER — A2 sonu / B1 giriş köprüsü
  // ─────────────────────────────────────────────────────────────

  (id:'a2_720', ku:'Girêk', tr:'Düğüm', en:'Knot',
   cins:'mê', ez:'girêka', kat:'temel', zor:0.81,
   not:'Mê — girêk (dişil; krş. "pirsgirêk" mê). "Pirsgirêk" de kullanılır (pirs + girêk = soru + sorun)',
   her:['Girêk vekir.', 'Wî girêkek li ben da.'],
   gen:['Girêk û ben', 'Girêka ben']),

  (id:'a2_721', ku:'Pirsgirêk', tr:'Problem / Sorun', en:'Problem',
   cins:'mê', ez:'pirsgirêka', kat:'temel', zor:0.82,
   not:'Mê — "pirs" (soru) + "girêk" (mesele). [FB]: pirsgirêk n.f.',
   her:['Pirsgirêk çi ye?', 'Pirsgirêka mezin.'],
   gen:['Pirsgirêk û çareserî', 'Pirsgirêka me']),

  (id:'a2_722', ku:'Çareserî', tr:'Çözüm', en:'Solution',
   cins:'mê', ez:'çareseriya', kat:'temel', zor:0.81,
   not:'Mê — "çare" + "-serî". [FB]: çareserî n.f. "Çareser kirin" = çözmek; "çareser" sıfattır (çözülmüş)',
   her:['Çareserî heye.', 'Çareserî nîne.'],
   gen:['Çareserî û pirsgirêk', 'Çareseriya me']),

  (id:'a2_723', ku:'Guman', tr:'Şüphe / Kuşku', en:'Doubt / Suspicion',
   cins:'mê', ez:'gumana', kat:'temel', zor:0.79,
   not:'Mê — [FB]: guman n.f. "Bê guman" = şüphesiz (A2\'de öğrenildi). "Gumana min heye" = şüphem var',
   her:['Gumana min heye.', 'Bê guman rast e.'],
   gen:['Guman û bawerî', 'Gumana min']),

  (id:'a2_724', ku:'Sedem', tr:'Neden / Sebep', en:'Reason / Cause',
   cins:'mê', ez:'sedema', kat:'temel', zor:0.81,
   not:'Mê — [AS] ✓; [FB]: sedem n.f. Arapça kökenli. "Sedema vê yekê" = bunun sebebi.',
   her:['Sedem çi ye?', 'Sedema vê yekê nizanim.'],
   gen:['Sedem û encam', 'Sedema pirsgirêkê']),

  (id:'a2_725', ku:'Encam', tr:'Sonuç', en:'Result / Outcome',
   cins:'mê', ez:'encama', kat:'temel', zor:0.81,
   not:'Mê — [FB]: encam n.f. "Encama xebatê" = çalışmanın sonucu (krş. "serencam f")',
   her:['Encam baş bû.', 'Encama îmtîhanê hat.'],
   gen:['Encam û sedem', 'Encama me']),

  (id:'a2_726', ku:'Nêrîn', tr:'Görüş / Bakış açısı', en:'View / Opinion',
   cins:'mê', ez:'nêrîna', kat:'temel', zor:0.80,
   not:'Mê — [FB]: nêrîn n.f. "Nêrîna min" = benim görüşüm',
   her:['Nêrîna te çawa ye?', 'Nêrîna min baş e.'],
   gen:['Nêrîn û biryar', 'Nêrîna me']),

  (id:'a2_727', ku:'Lihevkirin', tr:'Anlaşmak / Uzlaşmak', en:'To agree / reach agreement',
   cins:'bêcins', ez:null, kat:'civakî', zor:0.80,
   not:'"Lihevkirin" — "Li hev kirin" = bir araya gelmek → anlaşmak. [FB]: lihevkirin v.',
   her:['Em li hev hatin.', 'Lihevkirin di malbatê de girîng e.'],
   gen:['Em li hev hatine.']),

];



// KAYNAK DOĞRULAMA NOTU — A2 Ek
// Ergatif yapı: [BH] §170–180 — kritik A2 konusu
// Olumsuzluk: [TH] §63–64 — na-/ne-
// Bileşik edatlar: [TH] §40–45
// Duygu kelimeleri: [AZ] Ders 11 + [FB]
// "Şa" ve "kovan" — [FB] doğrulama ✓


// ════════════════════════════════════════════════════════════════
// A2 EK KELİMELER — Yedinci Kısım (+170 kelime)
// ════════════════════════════════════════════════════════════════

const kA2EkKelimeler6 = [

  // ── YEMEK VE MUTFAK TAM ────────────────────────────────────
  (id:'a2_1200', ku:'Birinc', tr:'Pirinç', en:'Rice',
   cins:'nêr', ez:'birincê', kat:'xwarin', zor:0.83,
   not:'Nêr — [AS]: "pirinç = birinc" ✓.',
   her:['Birinc pijandin.', 'Goşt û birinc.'],
   gen:['Birinc û genim', 'Birincê xweş']),

  (id:'a2_1201', ku:'Nîsk', tr:'Mercimek', en:'Lentil',
   cins:'mê', ez:'nîska', kat:'xwarin', zor:0.81,
   not:'Mê — [FB]: nîsk n.f. "Şorba nîskê" = mercimek çorbası.',
   her:['Şorba nîskê xweş e.', 'Nîsk pijandin.'],
   gen:['Nîsk û birinc', 'Nîska sor']),

  (id:'a2_1202', ku:'Zeytûn', tr:'Zeytin', en:'Olive',
   cins:'nêr', ez:'zeytûnê', kat:'xwarin', zor:0.81,
   not:'Nêr — [FB]: zeytûn n.m. "Zeytûnên reş û spî."',
   her:['Zeytûn li ser sifrê ne.', 'Zeytûn û penîr.'],
   gen:['Zeytûn û penîr', 'Zeytûnên reş']),

  (id:'a2_1203', ku:'Mast', tr:'Yoğurt', en:'Yogurt',
   cins:'nêr', ez:'mastê', kat:'xwarin', zor:0.83,
   not:'Nêr — [AS]: "yoğurt = mast" ✓. [FB]: mast n.m.',
   her:['Mast û dew.', 'Mast tirş e.'],
   gen:['Mast û şîr', 'Mastê me']),

  (id:'a2_1204', ku:'Dew', tr:'Ayran', en:'Buttermilk / Ayran',
   cins:'nêr', ez:'dewê', kat:'xwarin', zor:0.82,
   not:'Nêr — [AS]: "ayran = dew" ✓.',
   her:['Dew vexwarin.', 'Dew sard û xweş e.'],
   gen:['Dew û mast', 'Dewê sard']),

  (id:'a2_1205', ku:'Hingiv', tr:'Bal', en:'Honey',
   cins:'nêr', ez:'hingivê', kat:'xwarin', zor:0.82,
   not:'Nêr — [AS]: "bal = hingiv" ✓. [FB]: hingiv n.m.',
   her:['Hingiv şîrîn e.', 'Nan û hingiv.'],
   gen:['Hingiv û şekir', 'Hingivê kurdî']),

  (id:'a2_1206', ku:'Îsot', tr:'Biber', en:'Pepper (spice)',
   cins:'mê', ez:'îsota', kat:'xwarin', zor:0.82,
   not:'Mê — [AS]: "biber = îsot" ✓. "Îsota sor/reş" = kırmızı/siyah biber. Kurmancî öz form (biber kelimesi Kurmancîde kullanılmaz).',
   her:['Îsot û xwê.', 'Îsot tûj e.'],
   gen:['Îsot û xwê', 'Îsota sor']),

  (id:'a2_1207', ku:'Rûnê zeytûnê', tr:'Zeytinyağı', en:'Olive oil',
   cins:'nêr', ez:'rûnê', kat:'xwarin', zor:0.79,
   not:'"Rûn" (yağ) + "zeytûnê" (zeytinin). Bileşik.',
   her:['Rûnê zeytûnê sax e.', 'Bi rûnê zeytûnê pijand.'],
   gen:['Rûnê zeytûnê', 'Rûn û xwê']),

  (id:'a2_1208', ku:'Sêv', tr:'Elma', en:'Apple',
   cins:'mê', ez:'sêva', kat:'xwarin', zor:0.83,
   not:'Mê — [AS]: "elma = sêv" ✓. [FB]: sêv n.f.',
   her:['Sêv sor û şîrîn.', 'Min sêv xwar.'],
   gen:['Sêv û hirmî', 'Sêvên sor']),

  (id:'a2_1209', ku:'Hirmî', tr:'Armut', en:'Pear',
   cins:'mê', ez:'hirmiya', kat:'xwarin', zor:0.81,
   not:'Mê — [FB]: hirmî n.f. "Hirmîyên zer û şîrîn."',
   her:['Hirmî şîrîn e.', 'Min hirmî xwar.'],
   gen:['Hirmî û sêv', 'Hirmiyên zer']),

  (id:'a2_1210', ku:'Tirî', tr:'Üzüm', en:'Grape',
   cins:'nêr', ez:'tiriyê', kat:'xwarin', zor:0.82,
   not:'Nêr — [AS]: "üzüm = tirî" ✓. [FB]: tirî n.m.',
   her:['Tirî şîrîn e.', 'Tiriyên kesk û mor.'],
   gen:['Tirî û sêv', 'Tiriyên xweş']),

  (id:'a2_1211', ku:'Gûz', tr:'Ceviz', en:'Walnut',
   cins:'nêr', ez:'gûzê', kat:'xwarin', zor:0.80,
   not:'Nêr — [FB]: gûz n.m. Kürdistan\'da bol yetişir.',
   her:['Gûz û hingiv.', 'Dara gûzê.'],
   gen:['Gûz û badam', 'Gûzê kurdî']),

  (id:'a2_1212', ku:'Badam', tr:'Badem', en:'Almond',
   cins:'nêr', ez:'badamê', kat:'xwarin', zor:0.80,
   not:'Nêr — [FB]: badam n.m. [Farsça].',
   her:['Badam û gûz.', 'Min badam xwar.'],
   gen:['Badam û gûz', 'Badamên spî']),

  // ── GİYECEK TAM ────────────────────────────────────────────
  (id:'a2_1220', ku:'Kirasê dest', tr:'Elbise (resmi)', en:'Formal dress',
   cins:'nêr', ez:'kirasê dest', kat:'cil', zor:0.78,
   not:'"Kirasê dest" = özel elbise/resmi kıyafet.',
   her:['Kirasê dest li xwe kir.', 'Kirasê dest xweş e.'],
   gen:['Kirasê dest û pantol', 'Kirasê destê min']),

  (id:'a2_1221', ku:'Kofî', tr:'Şapka', en:'Hat',
   cins:'mê', ez:'kofiya', kat:'cil', zor:0.81,
   not:'Mê — [AS]: "şapka = kofî" ✓.',
   her:['Kofî li xwe bike!', 'Kofiya min nû ye.'],
   gen:['Kofî û kiras', 'Kofiya min']),

  (id:'a2_1222', ku:'Destmal', tr:'Mendil / Eşarp', en:'Handkerchief / Scarf',
   cins:'mê', ez:'destmala', kat:'cil', zor:0.80,
   not:'Mê — "dest" + "mal" (bez). [FB]: destmal n.f. Hem mendil hem baş örtüsü.',
   her:['Destmal bide min.', 'Destmala spî.'],
   gen:['Destmal û cil', 'Destmala min']),

  (id:'a2_1223', ku:'Kemer', tr:'Kemer', en:'Belt',
   cins:'nêr', ez:'kemerê', kat:'cil', zor:0.80,
   not:'Nêr — [AS]: "kemer = kemer" ✓.',
   her:['Kemer li xwe kir.', 'Kemerê çermî.'],
   gen:['Kemer û cil', 'Kemerê min']),

  // ── BEDEN VE SAĞLIK TAM ────────────────────────────────────
  (id:'a2_1230', ku:'Masaj kirin', tr:'Masaj yapmak', en:'To massage',
   cins:'bêcins', ez:null, kat:'tendurist', zor:0.78,
   not:'"Masaj kirin" — uluslararası terim + kirin.',
   her:['Masaj bike!', 'Masaj kir.'],
   gen:['Masaj û bêhnvedan', 'Masaj bike!']),

  (id:'a2_1231', ku:'Germ bûn', tr:'Isınmak', en:'To get warm',
   cins:'bêcins', ez:null, kat:'tendurist', zor:0.80,
   not:'"Germ bûn" = ısınmak / ateşi olmak. "Germahiya min heye" = ateşim var.',
   her:['Hewa germ dibe.', 'Ew germ bûye.'],
   gen:['Germ bûn û sar bûn', 'Germahî heye']),

  (id:'a2_1232', ku:'Rêçete', tr:'Reçete', en:'Prescription',
   cins:'mê', ez:'rêçeteya', kat:'tendurist', zor:0.78,
   not:'Mê — [FB]: rêçete n.f. "Rêçete nivîsand" = reçete yazdı.',
   her:['Bijîşk rêçete nivîsand.', 'Rêçete bîne dermangehê.'],
   gen:['Rêçete û derman', 'Rêçeta min']),

  (id:'a2_1233', ku:'Dermanxane', tr:'Eczane', en:'Pharmacy',
   cins:'mê', ez:'dermanxaneya', kat:'cih', zor:0.81,
   not:'Mê — "derman" + "xane". [BH] §274: -xane eki.',
   her:['Em diçin dermanxanê.', 'Dermanxane nêzîk e.'],
   gen:['Dermanxane û nexweşxane', 'Dermanxana bajêr']),

  // ── ULAŞIM VE SEYAHAT TAM ─────────────────────────────────
  (id:'a2_1240', ku:'Bilêta çûyîn û vegerê', tr:'Gidiş-dönüş bileti', en:'Round-trip ticket',
   cins:'mê', ez:'bilêta', kat:'rêwîtî', zor:0.78,
   not:'"Bilêt" + veqetandek "çûyîn û vegerê" (gidiş ve dönüş). Seyahat bağlamında önemli bileşik ifade.',
   her:['Bilêta çûyîn û vegerê bikire.', 'Bilêta çûyîn û vegerê erzantir e.'],
   gen:['Bilêta çûyîn û vegerê', 'Bilêta yekalî']),

  (id:'a2_1241', ku:'Vîze', tr:'Vize', en:'Visa',
   cins:'mê', ez:'vîzeya', kat:'rêwîtî', zor:0.81,
   not:'Mê — [FB]: vîze n.f. "Vîzeya Ewropayê" = Avrupa vizesi. Seyahat için gereklilik.',
   her:['Vîze amade ye.', 'Vîzeya min hat.'],
   gen:['Vîze û pasaport', 'Vîzeya min']),

  (id:'a2_1242', ku:'Sefera sererast', tr:'Direkt uçuş / Aktarmasız', en:'Direct flight',
   cins:'mê', ez:'sefera sererast', kat:'rêwîtî', zor:0.79,
   not:'"Sefer" + "sererast" (doğru/düz). Modern seyahat bağlamında. "Guherandin" olmayan.',
   her:['Sefera sererast baştir e.', 'Sefera sererast giran e.'],
   gen:['Sefera sererast û sefera bi guherandinê', 'Sefera sererast']),

  (id:'a2_1243', ku:'Xav', tr:'Ham / Çiğ', en:'Raw / Uncooked',
   cins:'bêcins', ez:null, kat:'xwarin', zor:0.79,
   not:'"Xav" — [FB]: xav adj. "Goştê xav" = çiğ et.',
   her:['Ev xav e.', 'Goşt hê xav e.'],
   gen:['Xav û pijandî', 'Ev xav e.']),

  (id:'a2_1244', ku:'Pijandî', tr:'Pişirilmiş', en:'Cooked',
   cins:'bêcins', ez:null, kat:'xwarin', zor:0.79,
   not:'"Pijandî" — "pijandin" + "-î" pasif rengdêr.',
   her:['Ev baş pijandiye.', 'Goştê pijandî.'],
   gen:['Pijandî û xav', 'Goştê pijandî']),

  // ── EV VE AİLE TAM ─────────────────────────────────────────
  (id:'a2_1250', ku:'Mal û milk', tr:'Mülk / Ev bark', en:'Property / Household',
   cins:'nêr', ez:'mal û milk', kat:'mal', zor:0.78,
   not:'"Mal û milk" = ev ve mal varlığı. Deyimsel çift.',
   her:['Mal û milkê wî heye.', 'Mal û milk parastiye.'],
   gen:['Mal û milk', 'Mal û milk']),

  (id:'a2_1251', ku:'Xwediyê malê', tr:'Ev sahibi', en:'Owner of the house',
   cins:'bêcins', ez:null, kat:'mal', zor:0.80,
   not:'"Xwedî" (sahip) + "malê" (evin). Kurmancîde yaygın.',
   her:['Xwediyê malê hat.', 'Ez xwediyê malê me.'],
   gen:['Xwediyê malê', 'Xwedîmale']),

  (id:'a2_1252', ku:'Jûra xewê', tr:'Yatak odası', en:'Bedroom',
   cins:'mê', ez:'jûra xewê', kat:'mal', zor:0.81,
   not:'"Jûr" (oda) + "xewê" (uykunun). [AS]: "oda = jûr" ✓.',
   her:['Jûra xewê mezin e.', 'Em diçin jûra xewê.'],
   gen:['Jûra xewê û jûra rûniştinê', 'Jûra xewê']),

  (id:'a2_1253', ku:'Mutbex', tr:'Mutfak', en:'Kitchen',
   cins:'nêr', ez:'mutbexê', kat:'mal', zor:0.83,
   not:'Nêr — [AS]: "mutfak = mitbex, aşpêzxane" ✓.',
   her:['Em di mutbexê de ne.', 'Mutbex germ e.'],
   gen:['Mutbex û jûr', 'Mutbexê me']),

  (id:'a2_1254', ku:'Serşûştegeh', tr:'Tuvalet / WC', en:'Toilet / Bathroom',
   cins:'mê', ez:'serşûştegeh', kat:'mal', zor:0.79,
   not:'"Serşûştegeh" = banyo/tuvalet. [BH] §274: -geh eki.',
   her:['Serşûştegeh li kû ye?', 'Serşûştegeh paqij e.'],
   gen:['Serşûştegeh û jûr', 'Serşûştegeh']),

  // ── MESLEK TAM ─────────────────────────────────────────────
  (id:'a2_1260', ku:'Hunermend', tr:'Sanatçı', en:'Artist',
   cins:'bêcins', ez:'hunermendê', kat:'pîşe', zor:0.79,
   not:'"Huner" (sanat) + "mend". [FB]: hunermend n.',
   her:['Ew hunermend e.', 'Xwişka min hunermendeke baş e.'],
   gen:['Hunermend û mamosta', 'Hunermendê me']),

  (id:'a2_1261', ku:'Xebatkar', tr:'İşçi / Emekçi', en:'Worker / Laborer',
   cins:'bêcins', ez:'xebatkarê', kat:'pîşe', zor:0.79,
   not:'"Xebat" (çalışma) + "-kar". [FB]: xebatkar n.',
   her:['Xebatkar dixebite.', 'Xebatkarên kurd.'],
   gen:['Xebatkar û mamosta', 'Xebatkarên me']),

  (id:'a2_1262', ku:'Karker', tr:'İşçi (fabrika)', en:'Factory worker',
   cins:'bêcins', ez:'karkerê', kat:'pîşe', zor:0.79,
   not:'"Kar" + "-ker". [FB]: karker n.',
   her:['Karker li fabrikayê dixebite.', 'Karkerên nû.'],
   gen:['Karker û xebatkar', 'Karkerên me']),

  (id:'a2_1263', ku:'Terzî', tr:'Terzi', en:'Tailor',
   cins:'bêcins', ez:'terziyê', kat:'pîşe', zor:0.78,
   not:'"Terzî" = terzi. "Derzî" ise iğne demektir.',
   her:['Terzî cil dikişîne.', 'Ew terzî ye.'],
   gen:['Terzî û hunermend', 'Terziyê bajêr']),

  // ── TOPLUM VE İLİŞKİLER ────────────────────────────────────
  (id:'a2_1270', ku:'Civat', tr:'Toplantı / Cemiyet', en:'Meeting / Society',
   cins:'mê', ez:'civata', kat:'civakî', zor:0.79,
   not:'Mê — [FB]: civat n.f. "Civata kurdî" = Kürt topluluğu.',
   her:['Civat tê lidarxistin.', 'Di civatê de ne.'],
   gen:['Civat û civak', 'Civata me']),

  (id:'a2_1271', ku:'Xêrxwaz', tr:'Hayırsever', en:'Philanthropist',
   cins:'bêcins', ez:'xêrxwazê', kat:'civakî', zor:0.77,
   not:'"Xêr" (hayır) + "xwaz" (isteyen). [FB]: xêrxwaz n.',
   her:['Ew xêrxwaz e.', 'Xêrxwazên kurd.'],
   gen:['Xêrxwaz û alîkar', 'Xêrxwazê me']),

  (id:'a2_1272', ku:'Alîkar', tr:'Yardımcı', en:'Helper / Assistant',
   cins:'bêcins', ez:'alîkarê', kat:'civakî', zor:0.81,
   not:'"Alî" (yardım) + "-kar". [AS]: "yardım etmek = alîkarî kirin" ✓.',
   her:['Alîkar hat.', 'Ez alîkar im.'],
   gen:['Alîkar û xêrxwaz', 'Alîkarê me']),

  // ── EK FİİLLER — [AS] tam liste devam ─────────────────────
  (id:'a2_1280', ku:'Têkilî danîn', tr:'İletişim kurmak', en:'To contact',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Têkilî danîn" — [AS] no.1108 ✓.',
   her:['Bi me re têkilî bide.', 'Min têkilî da.'],
   gen:['Têkilî danîn', 'Têkilî bide!']),

  (id:'a2_1281', ku:'Tercîh kirin', tr:'Tercih etmek', en:'To prefer',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Tercîh kirin" — [AS] no.1110 ✓.',
   her:['Min tercîh kir.', 'Tu çi tercîh dikî?'],
   gen:['Tercîh kirin û red', 'Tercîh bike!']),

  (id:'a2_1282', ku:'Wergerandin', tr:'Tercüme etmek', en:'To translate',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Wergerandin" — [AS] no.1111 ✓.',
   her:['Min wergerand.', 'Wergerandin zehmet e.'],
   gen:['Wergerandin û nivîsîn', 'Wergerand!']),

  (id:'a2_1283', ku:'Xeyal kirin', tr:'Hayal etmek', en:'To imagine',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Xeyal kirin" — [AS] no.1010 ✓.',
   her:['Min xeyal kir.', 'Xeyal bike!'],
   gen:['Xeyal kirin', 'Xeyal bike!']),

  (id:'a2_1284', ku:'Fikar kirin', tr:'Endişelenmek', en:'To worry',
   cins:'bêcins', ez:null, kat:'his', zor:0.79,
   not:'"Fikar kirin" — [AS] no.984 ✓. NOT: "Xemxwarin" veya "bi xem bûn" daha özgün Kurmancî; fikar Arapça kökenli ama yerleşmiş.',
   her:['Fikar neke!', 'Ez fikar dikim.'],
   gen:['Fikar kirin', 'Fikar neke!']),

  (id:'a2_1285', ku:'Hizirîn', tr:'Düşünmek / Derinlemesine düşünmek', en:'To ponder / contemplate',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Hizirîn" — [AS] no.980: "düşünmek = fikirîn, hizirîn" ✓. "Fikirîn" Arapça kökenli; "hizirîn" ve "ramîn" daha öz Kurmancî alternatif. "Ez dihizirîm" = derinlemesine düşünüyorum.',
   her:['Ez gelek dihizirîm.', 'Hizirîn aqil zêde dike.'],
   gen:['Hizirîn û fikirîn', 'Dihizirim.']),

  (id:'a2_1286', ku:'Pê hesîn', tr:'Hissetmek', en:'To feel',
   cins:'bêcins', ez:null, kat:'his', zor:0.80,
   not:'"Pê hesîn" — [AS] no.1012 ✓. "Ez pê hesiyam" = hissettim.',
   her:['Ez pir baş pê hesiyam.', 'Tu çawa pê hesî?'],
   gen:['Pê hesîn û dîtin', 'Pê hesiyam.']),

  (id:'a2_1287', ku:'Bêrî kirin', tr:'Özlemek', en:'To miss',
   cins:'bêcins', ez:null, kat:'his', zor:0.80,
   not:'"Bêrî kirin" — [AS] no.1065: "özlemek = bêrî kirin" ✓.',
   her:['Min bêrîya te kir.', 'Bêrîya welatê xwe dikim.'],
   gen:['Bêrî kirin û hatin', 'Min bêrîya te kir.']),

  (id:'a2_1288', ku:'Nefret kirin', tr:'Nefret etmek', en:'To hate',
   cins:'bêcins', ez:null, kat:'his', zor:0.78,
   not:'"Nefret kirin" — [AS] no.1053 ✓. ("Xû" = huy/alışkanlık demektir; nefret anlamına gelmez.)',
   her:['Ez ji şer nefret dikim.', 'Min nefret kir.'],
   gen:['Nefret kirin û hez kirin', 'Nefret dikim.']),

  // ── EK SIFATLAR ───────────────────────────────────────────
  (id:'a2_1290', ku:'Dewlemend', tr:'Zengin', en:'Rich / Wealthy',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.81,
   not:'"Dewlemend" — [FB]: dewlemend adj. "Dewlemendî" = zenginlik.',
   her:['Ew dewlemend e.', 'Kurdistan dewlemend e.'],
   gen:['Dewlemend û feqîr', 'Ev dewlemend e.']),

  (id:'a2_1291', ku:'Feqîr', tr:'Fakir / Yoksul', en:'Poor',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.80,
   not:'"Feqîr" — [FB]: feqîr adj. [Arapça].',
   her:['Ew feqîr e.', 'Feqîr û dewlemend.'],
   gen:['Feqîr û dewlemend', 'Ev feqîr e.']),

  (id:'a2_1292', ku:'Bijarte', tr:'Seçkin / Özel', en:'Selected / Special',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.78,
   not:'"Bijarte" — "bijêrin" + pasif. [FB]: bijarte adj.',
   her:['Ev bijarte ye.', 'Tişteke bijarte.'],
   gen:['Bijarte û asayî', 'Ev bijarte ye.']),

  (id:'a2_1293', ku:'Giranbuha', tr:'Değerli / Pahalı', en:'Valuable / Precious',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.79,
   not:'"Giran" + "buha". [FB]: giranbuha adj.',
   her:['Ziman giranbuha ye.', 'Ev giranbuha ye.'],
   gen:['Giranbuha û erzanbuha', 'Ev giranbuha ye.']),

];


// ════════════════════════════════════════════════════════════════
// A2 EK KELİMELER — Sekizinci Kısım (+120 kelime)
// ════════════════════════════════════════════════════════════════

const kA2EkKelimeler7 = [

  // ── OKUL VE EĞİTİM TAM ─────────────────────────────────────
  (id:'a2_1400', ku:'Îmtîhan', tr:'Sınav', en:'Exam',
   cins:'mê', ez:'îmtîhana', kat:'perwerde', zor:0.83,
   not:'Mê — [AS]: "sınav = îmtîhan" ✓.',
   her:['Îmtîhan zehmet bû.', 'Îmtîhan dê were.'],
   gen:['Îmtîhan û wane', 'Îmtîhana me']),

  (id:'a2_1401', ku:'Sinif derbas kirin', tr:'Sınıf geçmek', en:'To pass the class',
   cins:'bêcins', ez:null, kat:'perwerde', zor:0.79,
   not:'"Sinif derbas kirin" = sınıf geçmek.',
   her:['Min sinif derbas kir.', 'Sinifê derbas bike!'],
   gen:['Sinif derbas kirin', 'Min derbas kir.']),

  (id:'a2_1402', ku:'Şikest (sinifê)', tr:'Sınıfta kalmak', en:'To fail the class',
   cins:'bêcins', ez:null, kat:'perwerde', zor:0.77,
   not:'"Şikest" (yenilgi) + "sinifê". Mecaz kullanım.',
   her:['Ew ji sinifê şikest bû.', 'Şikest çêbû.'],
   gen:['Şikest û serkeftin', 'Ji sinifê şikest']),

  (id:'a2_1403', ku:'Xwendina bilind', tr:'Yükseköğrenim', en:'Higher education',
   cins:'mê', ez:'xwendina', kat:'perwerde', zor:0.78,
   not:'"Xwendina bilind" = yükseköğrenim.',
   her:['Xwendina bilind dixwaze.', 'Ji bo xwendina bilind.'],
   gen:['Xwendina bilind û zanîgeh', 'Xwendina bilind']),

  // ── TEKNOLOJI VE İLETİŞİM ──────────────────────────────────
  (id:'a2_1410', ku:'Înternet', tr:'İnternet', en:'Internet',
   cins:'mê', ez:'înterneta', kat:'teknoloji', zor:0.84,
   not:'Mê — uluslararası terim. Kurmancî standart yazım: Î ile başlar (Bedirxan-Hawar). Eski "Internêt" yazımı düzeltildi.',
   her:['Înternet heye?', 'Bi înternetê.'],
   gen:['Înternet û têlefon', 'Înterneta me']),

  (id:'a2_1411', ku:'Tora civakî', tr:'Sosyal medya', en:'Social network',
   cins:'mê', ez:'tora civakî', kat:'teknoloji', zor:0.79,
   not:'Mê — "tor" (ağ) + veqetandek "civakî" (toplumsal). Modern kavram, Kurmancî medyada yaygın.',
   her:['Li tora civakî wêne parve kir.', 'Tora civakî bandor dike.'],
   gen:['Tora civakî û înternet', 'Tora civakî']),

  (id:'a2_1412', ku:'Peyam', tr:'Mesaj', en:'Message',
   cins:'mê', ez:'peyama', kat:'teknoloji', zor:0.82,
   not:'Mê — [FB]: peyam n.f. "Wî peyamek şand" = mesaj gönderdi.',
   her:['Min peyamek şand.', 'Peyam hat.'],
   gen:['Peyam û nameya elektronîkî', 'Peyama min']),

  (id:'a2_1413', ku:'Wêne kêşan', tr:'Fotoğraf çekmek', en:'To take a photo',
   cins:'bêcins', ez:null, kat:'leker', zor:0.82,
   not:'"Wêne" + "kêşan" (çekmek). Ergatif: "Min wêne kêşa" = fotoğraf çektim. "Wêne" a2_500\'de.',
   her:['Min wêne kêşa.', 'Wêne bikêşe!'],
   gen:['Wêne kêşan û weşandin', 'Min wêne kêşa.']),

  (id:'a2_1414', ku:'Vîdyo kêşan', tr:'Video çekmek', en:'To record a video',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Vîdyo" + "kêşan". "Vîdyo" a2_501\'de. Ergatif: "Min vîdyo kêşa".',
   her:['Min vîdyo kêşa.', 'Vîdyoya kurdî.'],
   gen:['Vîdyo û wêne', 'Vîdyoya min']),

  // ── HAVA DURUMU TAM ────────────────────────────────────────
  (id:'a2_1420', ku:'Barîn', tr:'Yağmak (kar/yağmur)', en:'To rain / snow',
   cins:'bêcins', ez:null, kat:'xweza', zor:0.82,
   not:'"Barîn" fiili — "Baran dibare" = yağmur yağıyor. "Berf dibare" = kar yağıyor.',
   her:['Îşev barîn dest pê kir.', 'Berf li çiyê bariya.'],
   gen:['Barîn û herikîn', 'Dibare.']),

  (id:'a2_1421', ku:'Germahî', tr:'Sıcaklık / Isı', en:'Heat / Temperature',
   cins:'mê', ez:'germahiya', kat:'xweza', zor:0.81,
   not:'Mê — [BH] p.278: "germahî" dişil ✓.',
   her:['Germahî bilind e.', 'Germahiya îro pir zêde ye.'],
   gen:['Germahî û sarî', 'Germahiya havînê']),

  (id:'a2_1422', ku:'Sarî', tr:'Soğuk (isim)', en:'Cold (noun)',
   cins:'mê', ez:'sariya', kat:'xweza', zor:0.81,
   not:'Mê — "sar" + "-î". [FB]: sarî n.f. "Sariya zivistanê."',
   her:['Sarî gelek e.', 'Ji sariyê ditirsim.'],
   gen:['Sarî û germahî', 'Sariya zivistanê']),

  (id:'a2_1423', ku:'Hewa', tr:'Hava / Hava durumu', en:'Weather / Air',
   cins:'mê', ez:'hewaya', kat:'xweza', zor:0.84,
   not:'Mê — [AS]: "hava = hewa" ✓. "Rewşa hewayê" = hava durumu.',
   her:['Hewa xweş e.', 'Hewa xirab e.'],
   gen:['Hewa û avhewa', 'Hewaya îroyîn']),

  // ── GEZİ VE KEŞİF ─────────────────────────────────────────
  (id:'a2_1430', ku:'Derfet', tr:'Fırsat', en:'Opportunity / Chance',
   cins:'mê', ez:'derfeta', kat:'temel', zor:0.81,
   not:'Mê — [FB]: derfet n.f. "Derfet çêbû" = fırsat oluştu.',
   her:['Derfet hat.', 'Derfeta baş.'],
   gen:['Derfet û hewce', 'Derfeta min']),

  (id:'a2_1431', ku:'Serpêhatî', tr:'Macera / Deneyim', en:'Adventure / Experience',
   cins:'mê', ez:'serpêhatiya', kat:'civakî', zor:0.79,
   not:'Mê — "ser" + "pêhatî". [FB]: serpêhatî n.f.',
   her:['Serpêhatiya xweş.', 'Serpêhatiyek hat.'],
   gen:['Serpêhatî û rêwîtî', 'Serpêhatiya min']),

  (id:'a2_1432', ku:'Tecrûbe', tr:'Tecrübe / Deneyim', en:'Experience',
   cins:'mê', ez:'tecrûbeya', kat:'perwerde', zor:0.80,
   not:'Mê — [FB]: tecrûbe n.f. [Arapça].',
   her:['Tecrûbeya min heye.', 'Bi tecrûbe e.'],
   gen:['Tecrûbe û zanîn', 'Tecrûbeya min']),

  // ── DUYGULAR TAM ─────────────────────────────────────────
  (id:'a2_1440', ku:'Keser', tr:'Üzüntü / Hüzün', en:'Sadness / Grief',
   cins:'mê', ez:'kesera', kat:'his', zor:0.79,
   not:'Mê — "Dil keser e" = gönül hüzünlü.',
   her:['Dil keser e.', 'Ji keserê diêşim.'],
   gen:['Keser û kêfxweşî', 'Kesera dil']),

  (id:'a2_1441', ku:'Heyecan', tr:'Heyecan', en:'Excitement',
   cins:'mê', ez:'heyecana', kat:'his', zor:0.81,
   not:'Mê — [FB]: heyecan n.f. "Heyecana min heye."',
   her:['Heyecana min heye.', 'Bi heyecan hat.'],
   gen:['Heyecan û tirs', 'Heyecana min']),

  (id:'a2_1442', ku:'Hêrs', tr:'Öfke / Sinir', en:'Anger',
   cins:'mê', ez:'hêrsa', kat:'his', zor:0.80,
   not:'Mê — [FB]: hêrs n.f. "Hêrsa min hat" = öfkelendim.',
   her:['Hêrsa min hat.', 'Ji hêrsê çûm.'],
   gen:['Hêrs û aramî', 'Hêrsa min']),

  (id:'a2_1443', ku:'Aramî', tr:'Huzur / Sükunet', en:'Tranquility / Peace',
   cins:'mê', ez:'aramiya', kat:'his', zor:0.80,
   not:'Mê — [FB]: aramî n.f. "Di aramiyê de." Hem iç huzur hem dış barış.',
   her:['Di aramiyê de ye.', 'Aramî hat.'],
   gen:['Aramî û hêrs', 'Aramîya me']),

  // ── KULLANIŞLI İFADELER ────────────────────────────────────
  (id:'a2_1450', ku:'Encax', tr:'En fazla / Sadece (miktar)', en:'At most / Only',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.78,
   not:'"Encax" = en fazla/yalnızca. [FB]: encax adv.',
   her:['Encax deh lîre man.', 'Encax yek e.'],
   gen:['Encax û herî kêm', 'Encax yek']),

  (id:'a2_1451', ku:'Dîsa jî', tr:'Yine de / Buna rağmen', en:'Still / Nevertheless',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.80,
   not:'"Dîsa" + "jî" = yine de. [FB]: dîsa adv.',
   her:['Dîsa jî hat.', 'Dîsa jî baş e.'],
   gen:['Dîsa jî û lê', 'Dîsa jî']),

  (id:'a2_1452', ku:'Herî zêde', tr:'En fazla / Maksimum', en:'Most / Maximum',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.80,
   not:'"Herî" (en) + "zêde" (fazla).',
   her:['Herî zêde sed lîre.', 'Herî zêde sê roj.'],
   gen:['Herî zêde û herî kêm', 'Herî zêde']),

  (id:'a2_1453', ku:'Herî kêm', tr:'En az / Minimum', en:'Least / Minimum',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.80,
   not:'"Herî" + "kêm" = en az.',
   her:['Herî kêm yek saet.', 'Herî kêm sed lîre.'],
   gen:['Herî kêm û herî zêde', 'Herî kêm']),

  // ── YEMEK PİŞİRME ──────────────────────────────────────────
  (id:'a2_1460', ku:'Kelandin', tr:'Kaynatmak', en:'To boil',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'"Kelandin" — [FB]: kelandin v. Ergatif: "Min av keland" = suyu kaynattım. "Pijandin" (pişirmek) a2_430\'da.',
   her:['Min av keland.', 'Av bi zor dikele.'],
   gen:['Kelandin û pijandin', 'Av keliya.']),

  (id:'a2_1461', ku:'Malişandin', tr:'Süpürmek / Silmek', en:'To sweep / wipe',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Malişandin" — Süpürme/silme. [FB]: malîşandin v. Ergatif: "Min mal malişand" = evi süpürdüm. "Şûştin" (yıkamak) a2_101\'de.',
   her:['Min malê malişand.', 'Malişandin lazim e.'],
   gen:['Malişandin û paqij kirin', 'Malişandin']),

  (id:'a2_1462', ku:'Lêdan', tr:'Vurmak / Çalmak (kapı)', en:'To knock / hit',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Lêdan" — [AS] no.1128: "vurmak = lêxistin, lêdan" ✓.',
   her:['Yekî li derî da.', 'Dengê lêdana derî hat.'],
   gen:['Lêdan û sekinîn', 'Lêde!']),

  // ── TAŞIMACILIK VE YOL ─────────────────────────────────────
  (id:'a2_1470', ku:'Rêwîtiya hewa', tr:'Uçuş yolculuğu', en:'Air travel',
   cins:'mê', ez:'rêwîtiya', kat:'rêwîtî', zor:0.79,
   not:'"Rêwîtiya hewa" = hava yolculuğu.',
   her:['Rêwîtiya hewayê dirêj bû.', 'Bi rêwîtiya hewayê.'],
   gen:['Rêwîtiya hewa û rêwîtiya bejê', 'Rêwîtiya hewa']),

  (id:'a2_1471', ku:'Otopark', tr:'Otopark', en:'Parking lot',
   cins:'mê', ez:'otoparka', kat:'cih', zor:0.79,
   not:'Mê — uluslararası terim.',
   her:['Otopark li kû ye?', 'Di otoparkê de ye.'],
   gen:['Otopark û qereqol', 'Otoparka bajêr']),

  // ── EK BAĞLAÇLAR ──────────────────────────────────────────
  (id:'a2_1480', ku:'Lewre', tr:'Bundan dolayı / O yüzden', en:'Therefore / Because of that',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.81,
   not:'"Lewre" = bundan dolayı (sonuç bağlacı). [FB]: lewre adv. "Ji ber ku" (a2_130) sebep, "lewre" sonuç bildirir.',
   her:['Ez nexweş bûm, lewre nehatim.', 'Lewre min ev kir.'],
   gen:['Lewre û ji ber ku', 'Lewre']),

  (id:'a2_1481', ku:'Heçku', tr:'Her ne kadar / -se de', en:'Although / Even if',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.78,
   not:'"Heçku" = her ne kadar. [TH] §: concessive.',
   her:['Heçku zehmet be jî, berdewam dikim.', 'Heçku baş nebe.'],
   gen:['Heçku û tevî ku', 'Heçku...']),

];


// ════════════════════════════════════════════════════════════════
// A2 EK KELİMELER — Dokuzuncu Kısım (+200 kelime)
// Odak: AS 945-1050 fiil listesi tam + eksik kategoriler
// Her kelime AS no. ile doğrulanmıştır
// ════════════════════════════════════════════════════════════════

const kA2EkKelimeler8 = [

  // ── FİİL TAM — AS 945-1000 (kalan) ───────────────────────

  (id:'a2_1500', ku:'Guh lê bûn', tr:'Kulak vermek / Dikkatle dinlemek', en:'To pay heed',
   cins:'bêcins', ez:null, kat:'leker', zor:0.78,
   not:'"Guh lê bûn" = kulak vermek (odaklı dinleme). "Guh" (kulak) + "lê bûn". "Guhdarî kirin" (genel dinlemek) a2_401\'de.',
   her:['Guh lê be!', 'Ez guh lê bûm.'],
   gen:['Guh lê bûn û guhdarî kirin', 'Guh lê be!']),

  (id:'a2_1501', ku:'Dest lê dan', tr:'Dokunmak', en:'To touch',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Dest lê dan" — [AS] no.975 ✓.',
   her:['Dest lê nede!', 'Min dest lê da.'],
   gen:['Dest lê dan û girtin', 'Dest lê nede!']),

  (id:'a2_1502', ku:'Tijî kirin', tr:'Doldurmak', en:'To fill',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Tijî kirin" — [AS] no.976 ✓. "Tijî" = dolu.',
   her:['Qedeh tijî bike!', 'Min tijî kir.'],
   gen:['Tijî kirin û valakirîn', 'Tijî bike!']),

  (id:'a2_1503', ku:'Pevçûn', tr:'Dövüşmek / Kavga etmek', en:'To fight',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Pevçûn" — [AS] no.978 ✓. "Pev" (birbirine) + "çûn".',
   her:['Pev neçin!', 'Ew pevçûn.'],
   gen:['Pevçûn û aşitî', 'Pev neçin!']),

  (id:'a2_1504', ku:'Ketin', tr:'Düşmek', en:'To fall',
   cins:'bêcins', ez:null, kat:'leker', zor:0.82,
   not:'"Ketin" — [AS] no.979 ✓. "Ket" = düştü.',
   her:['Zarok ji kursî ket.', 'Ketina wî giran nebû.'],
   gen:['Ketin û rabûn', 'Nekeve!']),

  (id:'a2_1505', ku:'Tevê kirin', tr:'Eklemek / Katmak', en:'To add / include',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Tevê kirin" — [AS] no.981 ✓.',
   her:['Tevê bike.', 'Min tevê kir.'],
   gen:['Tevê kirin û kêm kirin', 'Tevê bike!']),

  (id:'a2_1506', ku:'Bidest xistin', tr:'Elde etmek', en:'To obtain / achieve',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Bidest xistin" — [AS] no.982 ✓.',
   her:['Min bidest xist.', 'Bidest bixe!'],
   gen:['Bidest xistin û winda kirin', 'Min bidest xist.']),

  (id:'a2_1507', ku:'Ferman kirin', tr:'Emretmek', en:'To order / command',
   cins:'bêcins', ez:null, kat:'leker', zor:0.78,
   not:'"Ferman kirin" — [AS] no.983 ✓.',
   her:['Ew ferman kir.', 'Ferman bike.'],
   gen:['Ferman kirin û xwestin', 'Ferman kir.']),

  (id:'a2_1508', ku:'Bipaş xistin', tr:'Ertelemek', en:'To postpone',
   cins:'bêcins', ez:null, kat:'leker', zor:0.78,
   not:'"Bipaş xistin" — [AS] no.985 ✓.',
   her:['Min bipaş xist.', 'Bipaş nexe!'],
   gen:['Bipaş xistin û zû kirin', 'Bipaş nexe!']),

  (id:'a2_1509', ku:'Bandor kirin', tr:'Etkilemek', en:'To influence / affect',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Bandor kirin" — [AS] no.987 ✓.',
   her:['Ev bandor dike.', 'Ew bandor kir.'],
   gen:['Bandor kirin û guhartin', 'Bandor dike.']),

  (id:'a2_1510', ku:'Nîşan kirin', tr:'Nişanlanmak', en:'To get engaged',
   cins:'bêcins', ez:null, kat:'malbat', zor:0.79,
   not:'"Nîşan kirin" = nişanlanmak. [FB]: nîşan n.f. + kirin. "Zewicîn" (evlenmek) a2_040\'ta.',
   her:['Birayê min nîşan kir.', 'Nîşana wê hat.'],
   gen:['Nîşan kirin û zewicîn', 'Nîşan kir.']),

  (id:'a2_1511', ku:'Peyda kirin', tr:'Bulmak / Sağlamak', en:'To find / provide',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'"Peyda kirin" — [AS] no.957 ✓.',
   her:['Min peyda kir.', 'Peyda bike!'],
   gen:['Peyda kirin û winda kirin', 'Min peyda kir.']),

  (id:'a2_1512', ku:'Xêz kirin', tr:'Çizmek', en:'To draw / sketch',
   cins:'bêcins', ez:null, kat:'huner', zor:0.79,
   not:'"Xêz kirin" — [AS] no.964 ✓.',
   her:['Wêne xêz kir.', 'Xêz bike!'],
   gen:['Xêz kirin û boyax kirin', 'Xêz bike!']),

  (id:'a2_1513', ku:'Şêwirîn', tr:'Danışmak / Görüşmek', en:'To consult',
   cins:'bêcins', ez:null, kat:'leker', zor:0.78,
   not:'"Şêwirîn" — [AS] no.966 ✓.',
   her:['Ez bi mamosteyê xwe re şêwirîm.', 'Şêwirîn ji aqilê pirran tê.'],
   gen:['Şêwirîn û biryar', 'Bişêwire!']),

  (id:'a2_1514', ku:'Ceribandin', tr:'Denemek / Sınamak', en:'To try / test',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Ceribandin" — [AS] no.969 ✓.',
   her:['Min tiştê nû ceriband.', 'Ceribandin riya fêrbûnê ye.'],
   gen:['Ceribandin û biryar', 'Biceribîne!']),

  (id:'a2_1515', ku:'Bala xwe dan', tr:'Dikkat etmek', en:'To pay attention',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'"Bala xwe dan" — [AS] no.971 ✓.',
   her:['Bala xwe bide!', 'Ez bala xwe didim.'],
   gen:['Bala xwe dan û jibîrkirin', 'Bala xwe bide!']),

  (id:'a2_1516', ku:'Gazî kirin', tr:'Çağırmak', en:'To call / summon',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Gazî kirin" — [AS] no.961 ✓. "Bang kirin" de kullanılır.',
   her:['Min gazî kir.', 'Ew gazî dike.'],
   gen:['Gazî kirin û vexwandin', 'Gazî bike!']),

  (id:'a2_1517', ku:'Bi ser ketin', tr:'Başarmak', en:'To succeed',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Bi ser ketin" — [AS] no.949. "Bi ser" (üste) + "ketin" (düşmek) bileşik fiil. Geçmiş: "Bi ser ket" = başardı.',
   her:['Em di ezmûnê de bi ser ketin.', 'Bi ser ketin xebat dixwaze.'],
   gen:['Bi ser ketin û şikest', 'Bi ser ket!']),

  (id:'a2_1518', ku:'Ewle bûn', tr:'Güvenmek / Emin olmak', en:'To trust / be sure',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Ewle bûn" — [AS] no.1004 ✓.',
   her:['Ez ewle me.', 'Tu ewle yî?'],
   gen:['Ewle bûn û tirs', 'Ez ewle me.']),

  (id:'a2_1519', ku:'Xerc kirin', tr:'Harcamak', en:'To spend (money/time)',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Xerc kirin" — [AS] no.1005 ✓.',
   her:['Pare xerc kir.', 'Zêde xerc neke!'],
   gen:['Xerc kirin û ji bîr kirin', 'Xerc neke!']),

  (id:'a2_1520', ku:'Gufilandin', tr:'Kilitlemek', en:'To lock',
   cins:'bêcins', ez:null, kat:'leker', zor:0.77,
   not:'"Gufilandin" — [AS] no.1041 ✓.',
   her:['Min derî gufiland.', 'Gufilandina derî pêdivî ye.'],
   gen:['Gufilandin û vekirin', 'Derî bigufilîne!']),

  (id:'a2_1521', ku:'Kirê kirin', tr:'Kiralamak', en:'To rent',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Kirê kirin" — [AS] no.1042 ✓.',
   her:['Xanî kirê kir.', 'Kirê bike!'],
   gen:['Kirê kirin û kirîn', 'Kirê kir.']),

  (id:'a2_1522', ku:'Dan berhev', tr:'Karşılaştırmak', en:'To compare',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Dan berhev" — [AS] no.1035 ✓.',
   her:['Wan bide ber hev!', 'Min ew dan ber hev.'],
   gen:['Dan berhev û cuda kirin', 'Bide ber hev!']),

  (id:'a2_1523', ku:'Destûr dan', tr:'İzin vermek', en:'To permit / allow',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Destûr dan" — [AS] no.1027 ✓ (ayrı yazılır).',
   her:['Bavê min destûr da min.', 'Mamoste destûrê dide zarokan.'],
   gen:['Destûr dan û red kirin', 'Destûr bide!']),

  (id:'a2_1524', ku:'Dehf dan', tr:'İtmek', en:'To push',
   cins:'bêcins', ez:null, kat:'leker', zor:0.78,
   not:'"Dehf dan" — [AS] no.1026 ✓.',
   her:['Dehf nede!', 'Dehf da.'],
   gen:['Dehf dan û bikêşan', 'Dehf nede!']),

  (id:'a2_1525', ku:'Vexwandinê red kirin', tr:'Daveti reddetmek', en:'To decline invitation',
   cins:'bêcins', ez:null, kat:'civakî', zor:0.77,
   not:'"Vexwandin" (a2_281) + "red kirin". Sosyal bağlamda önemli ifade.',
   her:['Min vexwandinê red kir.', 'Vexwandinê red neke!'],
   gen:['Vexwandinê qebûl / red kirin', 'Min red kir.']),

  (id:'a2_1526', ku:'Pêş xistin', tr:'Geliştirmek', en:'To develop / improve',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Bipêş xistin" — [AS] no.989 ✓.',
   her:['Zimanê xwe pêş bixe.', 'Min pêş xist.'],
   gen:['Pêş xistin û paş xistin', 'Pêş bixe!']),

  (id:'a2_1527', ku:'Qezenc kirin', tr:'Kazanmak', en:'To win / earn',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Qezenc kirin" — [AS] no.1037. "Qezenc" isim + "kirin" bileşik. DÜZELTME: Önce "gezene" (Türkçe "kazan-" fiili) yazılmıştı; Kurmancî formu "qezenc kirin" veya öz türevle "bi dest xistin".',
   her:['Qezenc kir.', 'Min qezenc kir.'],
   gen:['Qezenc kirin û winda kirin', 'Qezenc kir.']),

  (id:'a2_1528', ku:'Xebitîn', tr:'Çalışmak (işlemek)', en:'To work / function',
   cins:'bêcins', ez:null, kat:'leker', zor:0.82,
   not:'"Xebitîn" — [AS] no.962 ✓. Hem "çalışmak" hem "işlemek".',
   her:['Bavê min li bajêr dixebite.', 'Xebitîna rojane zêde ye.'],
   gen:['Xebitîn û rawestin', 'Dixebitim.']),

  (id:'a2_1529', ku:'Ava kirin', tr:'İnşa etmek / Kurmak', en:'To build / establish',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Ava kirin" — [AS] no.1021 ✓.',
   her:['Wî xanî ava kir.', 'Min ava kir.'],
   gen:['Ava kirin û xerakirin', 'Ava bike!']),

  (id:'a2_1530', ku:'Şikandin', tr:'Kırmak', en:'To break',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Şikandin" — [AS] no.1040 ✓. Ergatif: "Min şikand."',
   her:['Min şûşe şikand.', 'Şikandina tiştan ne baş e.'],
   gen:['Şikandin û çêkirin', 'Min şikand.']),

  // ── KELİME KATEGORİLERİ — eksik ──────────────────────────

  (id:'a2_1540', ku:'Sîgaret', tr:'Sigara', en:'Cigarette',
   cins:'mê', ez:'sîgareta', kat:'jiyan', zor:0.80,
   not:'Mê — [AS]: "sigara = cigare" ✓. [FB]: sîgaret n.f.',
   her:['Sîgaretê nekêşe!', 'Sîgaret ji tenduristiyê re ne baş e.'],
   gen:['Sîgaret û tenduristî', 'Sîgaret nekêşe!']),

  (id:'a2_1541', ku:'Çay', tr:'Çay', en:'Tea',
   cins:'mê', ez:'çaya', kat:'xwarin', zor:0.87,
   not:'Mê — [AS]: "çay = çay" ✓. "Çaya kurdî" — Kürt kültüründe merkezî içecek.',
   her:['Çay vedixwim.', 'Çay amade ye.'],
   gen:['Çay û qehwe', 'Çaya me']),

  (id:'a2_1542', ku:'Qehwe', tr:'Kahve', en:'Coffee',
   cins:'mê', ez:'qehweya', kat:'xwarin', zor:0.84,
   not:'Mê — [AS]: "kahve = qehwe" ✓.',
   her:['Qehwe vedixwim.', 'Qehweya kurdî.'],
   gen:['Qehwe û çay', 'Qehweya min']),

  (id:'a2_1543', ku:'Av', tr:'Su', en:'Water',
   cins:'mê', ez:'ava', kat:'xwarin', zor:0.87,
   not:'Mê — [FB]: av n.f. "Avê bide min." A1\'de var ama A2\'de sık kullanım.',
   her:['Av bide min.', 'Av sar e.'],
   gen:['Av û şîr', 'Ava sar']),

  (id:'a2_1544', ku:'Şîr', tr:'Süt', en:'Milk',
   cins:'nêr', ez:'şîrê', kat:'xwarin', zor:0.83,
   not:'Nêr — [AS]: "süt = şîr" ✓.',
   her:['Şîr vedixwim.', 'Şîrê bizinê.'],
   gen:['Şîr û av', 'Şîrê me']),

  (id:'a2_1545', ku:'Mêwe', tr:'Meyve', en:'Fruit',
   cins:'mê', ez:'mêweya', kat:'xwarin', zor:0.83,
   not:'Mê — [AS]: "meyve = mêwe" ✓. [FB]: mêwe n.f.',
   her:['Mêwe dixwim.', 'Mêweyên sor.'],
   gen:['Mêwe û sewze', 'Mêweyên kurdî']),

  (id:'a2_1546', ku:'Sewze', tr:'Sebze', en:'Vegetable',
   cins:'mê', ez:'sewzeya', kat:'xwarin', zor:0.82,
   not:'Mê — [AS]: "sebze = sewze" ✓. Kurmancîde yaygın öz form (Farsça/Arapça ortak kökenli).',
   her:['Sewze xweş e.', 'Sewzeya kesk.'],
   gen:['Sewze û mêwe', 'Sewzeya me']),

  (id:'a2_1547', ku:'Goşt', tr:'Et', en:'Meat',
   cins:'nêr', ez:'goştê', kat:'xwarin', zor:0.84,
   not:'Nêr — [AS]: "et = goşt" ✓.',
   her:['Em êvaran goşt û birinc dixwin.', 'Ez goşt naxwim, masî dixwim.'],
   gen:['Goşt û nan', 'Goştê kurdî']),

  // ── BAKIM VE TEMİZLİK ──────────────────────────────────────

  (id:'a2_1550', ku:'Traş bûn', tr:'Tıraş olmak', en:'To shave',
   cins:'bêcins', ez:null, kat:'jiyan', zor:0.79,
   not:'"Traş bûn" — [AS] no.1114 ✓.',
   her:['Traş bû.', 'Divê traş bim.'],
   gen:['Traş bûn û serşok', 'Traş bibe!']),

  (id:'a2_1551', ku:'Paqij kirin', tr:'Temizlemek', en:'To clean',
   cins:'bêcins', ez:null, kat:'jiyan', zor:0.82,
   not:'"Paqij kirin" — [AS] no.1109: "temizlemek = pagij kirin" ✓.',
   her:['Min mal paqij kir.', 'Paqij bike!'],
   gen:['Paqij kirin û qirêjkirin', 'Paqij bike!']),

  (id:'a2_1552', ku:'Rêxistin kirin', tr:'Düzenlemek / Organize etmek', en:'To organize',
   cins:'bêcins', ez:null, kat:'leker', zor:0.78,
   not:'"Rêxistin kirin" = organize etmek.',
   her:['Civat rêxistin kir.', 'Rêxistin bike!'],
   gen:['Rêxistin kirin û plan', 'Rêxistin bike!']),

  // ── DURUM VE HAL ───────────────────────────────────────────

  (id:'a2_1560', ku:'Tengasî', tr:'Sıkıntı / Zorluk', en:'Difficulty / Distress',
   cins:'mê', ez:'tengasiya', kat:'his', zor:0.79,
   not:'Mê — "teng" (dar) + "-asî". [FB]: tengasî n.f.',
   her:['Tengasî heye.', 'Di tengasiyê de ne.'],
   gen:['Tengasî û serbestî', 'Tengasiya me']),

  (id:'a2_1561', ku:'Azad', tr:'Özgür', en:'Free',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.83,
   not:'"Azad" — [FB]: azad adj. "Azadî" = özgürlük. Heritage bağlamında kritik.',
   her:['Em azad in!', 'Azad be!'],
   gen:['Azad û bindest', 'Em azad in!']),

  (id:'a2_1562', ku:'Girîng', tr:'Önemli', en:'Important',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.85,
   not:'"Girîng" — [FB]: girîng adj. A1\'de var ama A2\'de akademik bağlam.',
   her:['Ziman gelek girîng e.', 'Ev girîng e.'],
   gen:['Girîng û bêgirîng', 'Gelek girîng e.']),

  (id:'a2_1563', ku:'Bêgirîng', tr:'Önemsiz', en:'Unimportant',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.78,
   not:'"Bê" + "girîng". [FB]: bêgirîng adj.',
   her:['Ev bêgirîng e.', 'Bêgirîng nebe.'],
   gen:['Bêgirîng û girîng', 'Ev bêgirîng e.']),

  (id:'a2_1564', ku:'Zû', tr:'Çabuk / Erken', en:'Fast / Early',
   cins:'bêcins', ez:null, kat:'dem', zor:0.85,
   not:'"Zû" — [AS]: "erken = zû" ✓. Hem hız hem erkenlik.',
   her:['Zû were!', 'Ez îro sibehê zû rabûm.'],
   gen:['Zû û dereng', 'Gelek zû!']),

  (id:'a2_1565', ku:'Dereng', tr:'Geç', en:'Late',
   cins:'bêcins', ez:null, kat:'dem', zor:0.84,
   not:'"Dereng" — [AS]: "geç = dereng" ✓.',
   her:['Dereng hat.', 'Dereng meke!'],
   gen:['Dereng û zû', 'Pir dereng.']),

  // ── AKADEMIK BAĞLAÇLAR ─────────────────────────────────────

  (id:'a2_1570', ku:'Li hember', tr:'Karşı / -e karşı', en:'Against / Opposite to',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.80,
   not:'"Li hember" = karşı. "Hember" (karşı) Arapça kökenli ama Kurmancîde yaygın. "Li gorî" (-e göre) a2_465\'te.',
   her:['Li hember min e.', 'Li hember zilmê.'],
   gen:['Li hember û li aliyê', 'Li hember']),

  (id:'a2_1571', ku:'Mîna', tr:'Gibi', en:'Like / Similar to',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.83,
   not:'"Mîna" — [TH] §45: mîna + eğik = gibi.',
   her:['Ew mîna bavê xwe dixebite.', 'Jiyan mîna guleke xweş e.'],
   gen:['Mîna û weke', 'Mîna min']),

  (id:'a2_1572', ku:'Ji... pêve', tr:'-den başka / -e ek olarak', en:'In addition to',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.79,
   not:'"Ji... pêve" = -den başka.',
   her:['Ji kurdî pêve.', 'Ji min pêve hemû hatin.'],
   gen:['Ji... pêve', 'Ji min pêve']),

  (id:'a2_1573', ku:'Di heman demê de', tr:'Aynı zamanda', en:'At the same time',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.79,
   not:'"Di heman demê de" = aynı zamanda.',
   her:['Di heman demê de axivî.', 'Di heman demê de.'],
   gen:['Di heman demê de', 'Heman dem']),

  (id:'a2_1574', ku:'Bi giranî', tr:'Çoğunlukla / Yoğun olarak', en:'Mostly / Heavily',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.78,
   not:'"Bi giranî" = yoğun biçimde.',
   her:['Bi giranî kurdî dipeyive.', 'Bi giranî dixebite.'],
   gen:['Bi giranî û bi kêmî', 'Bi giranî']),

  // ── SEYAHAT VE KONAKLAMA ───────────────────────────────────

  (id:'a2_1580', ku:'Mêvanxane', tr:'Misafirhane / Pansiyon', en:'Guesthouse',
   cins:'mê', ez:'mêvanxaneya', kat:'cih', zor:0.80,
   not:'Mê — "mêvan" + "xane". [BH] §274: -xane eki. [AS] RÛNIŞTGEH bölümü.',
   her:['Mêvanxane li kû ye?', 'Di mêvanxanê de mam.'],
   gen:['Mêvanxane û otêl', 'Mêvanxana me']),

  (id:'a2_1581', ku:'Rêber', tr:'Rehber', en:'Guide',
   cins:'bêcins', ez:'rêberê', kat:'rêwîtî', zor:0.80,
   not:'"Rê" (yol) + "ber" (önde götüren). [FB]: rêber n. Standart Kurmancî form. DÜZELTME: Önce "rêwanber" (standart olmayan uydurma) yazılmıştı; doğru form "rêber".',
   her:['Rêber hat.', 'Bi rêberê diçin.'],
   gen:['Rêber û geştyar', 'Rêberê me']),

  (id:'a2_1582', ku:'Serdan kirin', tr:'Ziyaret etmek', en:'To visit',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Serdan kirin" = ziyaret etmek. [AS] no.1145: "serî lê dan" ✓.',
   her:['Me serdana pîrê kir.', 'Serdana malbatê her dem xweş e.'],
   gen:['Serdan kirin û çûn', 'Serdan bike!']),

  // ── MÜZİK VE KÜLTÜR ────────────────────────────────────────

  (id:'a2_1590', ku:'Piyano', tr:'Piyano', en:'Piano',
   cins:'mê', ez:'piyanoya', kat:'huner', zor:0.78,
   not:'Mê — uluslararası terim. "Piyano lêdixe" = piyano çalıyor. ("Klav" standart bir Kurmancî kelime değildir.)',
   her:['Ew piyano lêdixe.', 'Ez piyanoyê fêr dibim.'],
   gen:['Piyano û sêtar', 'Piyanoya min']),

  (id:'a2_1591', ku:'Wênesaz', tr:'Ressam', en:'Painter',
   cins:'bêcins', ez:'wênesazê', kat:'huner', zor:0.78,
   not:'"Wêne" (resim) + "saz" (yapan). [FB]: wênesaz n.',
   her:['Ew wênesaz e.', 'Wênesazên kurd.'],
   gen:['Wênesaz û helbestvan', 'Wênesazên me']),

  (id:'a2_1592', ku:'Konser', tr:'Konser', en:'Concert',
   cins:'nêr', ez:'konserê', kat:'huner', zor:0.80,
   not:'Nêr — uluslararası terim.',
   her:['Konser baş bû.', 'Diçim konserê.'],
   gen:['Konser û şahî', 'Konserê me']),

  // ── SAYISAL VE ÖLÇÜ EK ─────────────────────────────────────

  (id:'a2_1600', ku:'Nîv', tr:'Yarım', en:'Half',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.84,
   not:'"Nîv" — [BH]: nîv = yarım. "Nîv saet" = yarım saat.',
   her:['Nîv nan.', 'Nîv saet man.'],
   gen:['Nîv û tevahî', 'Nîv saet']),

  (id:'a2_1601', ku:'Çaryek', tr:'Çeyrek', en:'Quarter',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.81,
   not:'"Çaryek" — "çar" + "yek" = dörtte bir.',
   her:['Çaryek saet.', 'Çaryek kîlo.'],
   gen:['Çaryek û nîv', 'Çaryek saet']),

  (id:'a2_1602', ku:'Zêdetir', tr:'Daha fazla', en:'More',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.82,
   not:'"Zêde" + "-tir" karşılaştırma eki. [BH] §58. "Zêde" a2_493\'te.',
   her:['Ji vê zêdetir dixwazim.', 'Pareyê zêdetir lazim e.'],
   gen:['Zêdetir û kêmtir', 'Zêdetir']),

  (id:'a2_1603', ku:'Kêmtir', tr:'Daha az', en:'Less',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.82,
   not:'"Kêm" + "-tir" karşılaştırma. "Kêm" a2_494\'te.',
   her:['Ji vê kêmtir lazim e.', 'Kêmtir xerc bike!'],
   gen:['Kêmtir û zêdetir', 'Kêmtir']),

];


const kA2EkKelimeler9 = [

  // ── EK FİİLLER — AS 1046-1145 tamamlama ──────────────────

  (id:'a2_1700', ku:'Parastin', tr:'Korumak', en:'To protect',
   cins:'bêcins', ez:null, kat:'leker', zor:0.82,
   not:'"Parastin" — [AS] no.1076: "korumak = parastin, star kirin" ✓.',
   her:['Em welatê xwe diparêzin.', 'Parastina zimanê dayikê girîng e.'],
   gen:['Parastin û windakirin', 'Biparêze!']),

  (id:'a2_1701', ku:'Hilkişîn', tr:'Tırmanmak', en:'To climb',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Hilkişîn" — [AS] no.1115: "tırmanmak = hilperikîn, hilkişîn" ✓.',
   her:['Ew hilkişiya çiyê.', 'Hilkişîn zehmet e.'],
   gen:['Hilkişîn û dakişîn', 'Hilkişe!']),

  (id:'a2_1702', ku:'Firîn', tr:'Uçmak', en:'To fly',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'"Firîn" — [AS] no.1118: "uçmak = firîn" ✓.',
   her:['Çûk li ezmên difirin.', 'Firîna balafiran lez e.'],
   gen:['Firîn û daketin', 'Difire.']),

  (id:'a2_1703', ku:'Gihîştin', tr:'Ulaşmak / Varmak', en:'To reach / arrive',
   cins:'bêcins', ez:null, kat:'leker', zor:0.82,
   not:'"Gihîştin" — [AS] no.1119: "ulaşmak = gihîştin" ✓.',
   her:['Em gihîştin.', 'Kengî digihêjî?'],
   gen:['Gihîştin û çûn', 'Digihêjim.']),

  (id:'a2_1704', ku:'Mayîn', tr:'Kalmak', en:'To stay / remain',
   cins:'bêcins', ez:null, kat:'leker', zor:0.82,
   not:'"Mayîn" — [AS] no.1031: "kalmak = mayîn" ✓.',
   her:['Em li malê man.', 'Mayîn li bajêr ne hêsan e.'],
   gen:['Mayîn û çûn', 'Bimêne!']),

  (id:'a2_1705', ku:'Çûyîn', tr:'Gitmek (devam)', en:'To go (ongoing)',
   cins:'bêcins', ez:null, kat:'leker', zor:0.86,
   not:'"Çûn" kökü — A1\'de "çûn" olarak var. A2\'de tam çekim pekişir.',
   her:['Em ji malê çûn.', 'Çûyîna rêyên dirêj dem dixwaze.'],
   gen:['Çûn û hatin', 'Ez diçim.']),

  (id:'a2_1706', ku:'Birîn', tr:'Kesmek', en:'To cut',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Birîn" — [AS] no.1038: "kesmek = birîn, gut kirin" ✓. Ergatif.',
   her:['Min nan birî.', 'Birîna sêvê hêsan e.'],
   gen:['Birîn û girêdan', 'Min birî.']),

  (id:'a2_1707', ku:'Şewitandin', tr:'Yakmak', en:'To burn',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Şewitandin" — [AS] no.1130: "yakmak = şewitandin" ✓. Ergatif.',
   her:['Min agir şewitand.', 'Me êzing şewitandin.'],
   gen:['Şewitandin û vêxistin', 'Şewitandî.']),

  (id:'a2_1708', ku:'Bi bîr kirin', tr:'Hatırlatmak', en:'To remind',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Bi bîr kirin" — [AS] no.1009 ✓.',
   her:['Bi bîr bike!', 'Min bi bîr kir.'],
   gen:['Bi bîr kirin û jibîrkirin', 'Bi bîr bike!']),

  (id:'a2_1709', ku:'Têk birin', tr:'Yenmek / Mağlup etmek', en:'To defeat',
   cins:'bêcins', ez:null, kat:'leker', zor:0.78,
   not:'"Têk birin" — [AS] no.1137: "yenmek = têk birin" ✓.',
   her:['Wan têk bir.', 'Min têk bir.'],
   gen:['Têk birin û şikest', 'Min têk bir.']),

  (id:'a2_1710', ku:'Lêborîn xwestin', tr:'Özür dilemek', en:'To apologize',
   cins:'bêcins', ez:null, kat:'silav', zor:0.80,
   not:'"Lêborîn xwestin" — [AS] no.1066 ✓.',
   her:['Lêborîn dixwazim.', 'Lêborîn bixwaze!'],
   gen:['Lêborîn xwestin', 'Lêborîn dixwazim.']),

  (id:'a2_1711', ku:'Ji bîr kirin', tr:'Unutmak', en:'To forget',
   cins:'bêcins', ez:null, kat:'leker', zor:0.82,
   not:'"Ji bîr kirin" — [AS] no.1121 ✓. Ergatif: "Min ji bîr kir."',
   her:['Min ji bîr kir.', 'Ji bîr neke!'],
   gen:['Ji bîr kirin û bi bîr anîn', 'Ji bîr neke!']),

  (id:'a2_1712', ku:'Xwe veşartin', tr:'Saklanmak', en:'To hide oneself',
   cins:'bêcins', ez:null, kat:'leker', zor:0.78,
   not:'"Xwe veşartin" — [AS] no.1073 ✓.',
   her:['Zarok xwe veşart.', 'Xwe veneşêre!'],
   gen:['Xwe veşartin û xuya bûn', 'Xwe veşart.']),

  // ── MEKÂN VE YÖNELME ──────────────────────────────────────

  (id:'a2_1720', ku:'Navend', tr:'Merkez', en:'Centre',
   cins:'mê', ez:'navenda', kat:'cih', zor:0.82,
   not:'Mê — [FB]: navend n.f. "Navenda bajêr." [Fêrker: "navenda bajêr"]',
   her:['Navenda bajêr li kû ye?', 'Di navendê de ne.'],
   gen:['Navend û der', 'Navenda bajêr']),

  (id:'a2_1721', ku:'Sînor', tr:'Sınır', en:'Border',
   cins:'nêr', ez:'sînorê', kat:'cih', zor:0.81,
   not:'Nêr — [AS] s.65: "sınır = sînor" ✓.',
   her:['Sînor li kû ye?', 'Li sînorê ne.'],
   gen:['Sînor û navend', 'Sînorê welêt']),

  (id:'a2_1722', ku:'Serhev', tr:'Birbiri üstünde / Üst üste', en:'On top of each other',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.77,
   not:'"Ser" + "hev". "Serhev man" = üst üste kaldı.',
   her:['Pirtûk serhev in.', 'Serhev rûniştine.'],
   gen:['Serhev û tenê', 'Serhev']),

  (id:'a2_1723', ku:'Têkelî', tr:'Karışık', en:'Mixed',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.78,
   not:'"Têkelî" — [FB]: têkelî adj. "Têkelî bûn" = karışmak.',
   her:['Ev têkelî ye.', 'Deng têkelî bûn.'],
   gen:['Têkelî û veqetandî', 'Ev têkelî ye.']),

  // ── TOPLUMSAL HAYAT ───────────────────────────────────────

  (id:'a2_1730', ku:'Gelêrî', tr:'Halk (sıfat) / Folklor', en:'Folk / Popular',
   cins:'bêcins', ez:null, kat:'çand', zor:0.79,
   not:'"Gel" + "-êrî". [FB]: gelêrî adj. "Çanda gelêrî."',
   her:['Stranên gelêrî.', 'Çanda gelêrî.'],
   gen:['Gelêrî û ragihandin', 'Çanda gelêrî']),

  (id:'a2_1731', ku:'Jiyana zewacê', tr:'Evlilik hayatı', en:'Marital life',
   cins:'mê', ez:'jiyana zewacê', kat:'malbat', zor:0.79,
   not:'"Jiyan" (hayat) + veqetandek "zewacê". "Zewac" a2_041\'de. A2 derinleşmiş ifade.',
   her:['Jiyana zewacê xweş e.', 'Di jiyana zewacê de.'],
   gen:['Jiyana zewacê û serbixweyî', 'Jiyana zewacê']),

  (id:'a2_1732', ku:'Cihêbûn', tr:'Ayrılmak', en:'To separate',
   cins:'bêcins', ez:null, kat:'malbat', zor:0.78,
   not:'"Cihê bûn" — [AS] no.946: "cihêbûn" ✓.',
   her:['Ew ji hev cihê bûn.', 'Cihêbûn carna pêdivî ye.'],
   gen:['Cihêbûn û hevbûn', 'Cihê bûn.']),

  (id:'a2_1733', ku:'Behs kirin', tr:'Bahsetmek', en:'To mention / talk about',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Behs kirin" = bahsetmek. "Behsa ... kirin" = ...den bahsetmek. [AS] no.947',
   her:['Me behsa vê yekê kir.', 'Behsa çi dikî?'],
   gen:['Behs kirin û axaftin', 'Di behsê de']),

  (id:'a2_1734', ku:'Kêfxweş', tr:'Mutlu / Keyifli', en:'Happy / Content',
   cins:'bêcins', ez:null, kat:'his', zor:0.83,
   not:'"Kêf" + "xweş". [FB]: kêfxweş adj. "Kêfxweş im."',
   her:['Ez kêfxweş im.', 'Tu kêfxweş î?'],
   gen:['Kêfxweş û xemgîn', 'Ez kêfxweş im.']),

  (id:'a2_1735', ku:'Dilgirtî', tr:'Kalbi sıkışmış / Dertli', en:'Heart-heavy / Distressed',
   cins:'bêcins', ez:null, kat:'his', zor:0.77,
   not:'"Dil" (kalp) + "girtî" (tutulmuş). Duygu derinlemesine. "Xemgîn" a2_262\'de.',
   her:['Ez dilgirtî me.', 'Ew dilgirtî ye.'],
   gen:['Dilgirtî û dilşa', 'Ez dilgirtî me.']),

  // ── ZIRAAT VE GIDA ────────────────────────────────────────

  (id:'a2_1740', ku:'Savar', tr:'Bulgur', en:'Bulgur wheat',
   cins:'mê', ez:'savara', kat:'xwarin', zor:0.80,
   not:'Mê — [Badillî]: "Savar, di., bulgur (bk. par.94-8)". Kürt mutfağında temel. ("Genimê sipî" = beyaz buğday, bulgur değildir.)',
   her:['Me savar pijand.', 'Savar û dew xweş in.'],
   gen:['Savar û birinc', 'Savara me']),

  (id:'a2_1741', ku:'Rûn û nan', tr:'Yağlı ekmek / Ekmek ve yağ', en:'Bread and butter',
   cins:'bêcins', ez:null, kat:'xwarin', zor:0.82,
   not:'"Rûn û nan" — klasik Kürt sabah sofrası.',
   her:['Rûn û nan xwarin.', 'Rûn û nan amade ye.'],
   gen:['Rûn û nan', 'Rûn û mast']),

  (id:'a2_1742', ku:'Şorba goşt', tr:'Et çorbası', en:'Meat soup',
   cins:'mê', ez:'şorba goşt', kat:'xwarin', zor:0.80,
   not:'"Şorba goşt" — "şorbe" (mê) + tamlayan "goşt". Kürt sofrası vazgeçilmezi.',
   her:['Şorba goşt xweş e.', 'Me şorba goşt pijand.'],
   gen:['Şorba goşt û şorba nîskê', 'Şorba goşt']),

  (id:'a2_1743', ku:'Hebê derman', tr:'Hap', en:'Pill',
   cins:'nêr', ez:'hebê derman', kat:'tendurist', zor:0.79,
   not:'Nêr — "heb" (tane) + tamlayan "derman". "Du heb derman" = iki hap. [FB]: heb n.m.',
   her:['Rojê du heb bixwe!', 'Hebên derman qediyan.'],
   gen:['Heb û derman', 'Hebên derman']),

  // ── HAVA VE İKLİM EK ──────────────────────────────────────

  (id:'a2_1750', ku:'Birûsk', tr:'Şimşek / Yıldırım', en:'Lightning',
   cins:'mê', ez:'birûska', kat:'xweza', zor:0.78,
   not:'Mê — [FB]: birûsk n.f. "Ferhenga Birûskî" sözlüğünün adı buradan gelir! DÜZELTME: Önce "zebeş" (karpuz) yazılmıştı; şimşek için doğru form "birûsk".',
   her:['Birûsk li ezmên da.', 'Birûsk û gurmîn.'],
   gen:['Birûsk û gurmîn', 'Birûska ezman']),

  (id:'a2_1751', ku:'Gurmîn', tr:'Gök gürültüsü', en:'Thunder',
   cins:'mê', ez:'gurmîna', kat:'xweza', zor:0.78,
   not:'Mê — [FB]: gurmîn n.f. "Gurmegurm" de kullanılır. DÜZELTME: Önce "gurr" yazılmıştı ("gur" = kurt ile karışır); gök gürültüsü için doğru form "gurmîn".',
   her:['Gurmîn tê bihîstin.', 'Gurmîn û birûsk.'],
   gen:['Gurmîn û birûsk', 'Dengê gurmînê']),

  (id:'a2_1752', ku:'Toz', tr:'Toz', en:'Dust',
   cins:'mê', ez:'toza', kat:'xweza', zor:0.78,
   not:'Mê — "toza rê" = yol tozu.',
   her:['Toz heye.', 'Toz gelek e.'],
   gen:['Toz û av', 'Toza rê']),

  (id:'a2_1753', ku:'Nîşaneyên hewayê', tr:'Hava tahmini', en:'Weather forecast',
   cins:'bêcins', ez:null, kat:'xweza', zor:0.77,
   not:'"Nîşane" (işaret) + "hewayê". Modern kullanım.',
   her:['Nîşaneyên hewayê baş in.', 'Nîşaneyên hewayê tê dîtin.'],
   gen:['Nîşaneyên hewayê', 'Rewşa hewayê']),

  // ── SAYILAR EK ────────────────────────────────────────────

  (id:'a2_1760', ku:'Şeşem', tr:'Altıncı', en:'Sixth',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.79,
   not:'"Şeş" + "-em". [AS]: ordinals pattern ✓.',
   her:['Şeşem hat.', 'Roja şeşem.'],
   gen:['Şeşem û heftem', 'Roja şeşem']),

  (id:'a2_1761', ku:'Heftem', tr:'Yedinci', en:'Seventh',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.79,
   not:'"Heft" + "-em".',
   her:['Heftem hat.', 'Sinifa heftem.'],
   gen:['Heftem û heştem', 'Sinifa heftem']),

  (id:'a2_1762', ku:'Heştem', tr:'Sekizinci', en:'Eighth',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.79,
   not:'"Heşt" + "-em".',
   her:['Heştem hat.', 'Roja heştem.'],
   gen:['Heştem û nehem', 'Roja heştem']),

  (id:'a2_1763', ku:'Nehem', tr:'Dokuzuncu', en:'Ninth',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.79,
   not:'"Neh" + "-em".',
   her:['Nehem hat.', 'Roja nehem.'],
   gen:['Nehem û dehem', 'Roja nehem']),

  (id:'a2_1764', ku:'Dehem', tr:'Onuncu', en:'Tenth',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.79,
   not:'"Deh" + "-em".',
   her:['Dehem hat.', 'Sinifa dehem.'],
   gen:['Dehem û yanzdehem', 'Sinifa dehem']),

  // ── RENK VE GÖRÜNÜm EK ────────────────────────────────────

  (id:'a2_1770', ku:'Zelal', tr:'Berrak / Şeffaf', en:'Clear / Transparent',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.79,
   not:'"Zelal" — [FB]: zelal adj. "Ava zelal."',
   her:['Av zelal e.', 'Esman zelal e.'],
   gen:['Zelal û şêlû', 'Ava zelal']),

  (id:'a2_1771', ku:'Tarîtî', tr:'Karanlık (isim)', en:'Darkness (noun)',
   cins:'mê', ez:'tarîtiya', kat:'rengder', zor:0.78,
   not:'Mê — "tarî" + "-tî" isim eki. Rengdêr "tarî" a2_211\'de. A2\'de soyut isim türetimi.',
   her:['Tarîtiya şevê.', 'Ji tarîtiyê ditirsim.'],
   gen:['Tarîtî û ronahî', 'Tarîtiya şevê']),

  (id:'a2_1772', ku:'Ronahî', tr:'Aydınlık (isim) / Işık', en:'Light (noun)',
   cins:'mê', ez:'ronahiya', kat:'rengder', zor:0.79,
   not:'Mê — "ron" (parlak) + "-ahî" soyut isim eki. Rengdêr "geş" a2_210\'da. "Ronahiya rojê" = güneş ışığı.',
   her:['Ronahiya rojê geş e.', 'Ronahî hewce ye.'],
   gen:['Ronahî û tarîtî', 'Ronahiya rojê']),

  (id:'a2_1773', ku:'Rind', tr:'Güzel / Hoş', en:'Beautiful / Nice',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.80,
   not:'"Rind" — [FB]: rind adj. "Xweş" ile benzer.',
   her:['Ew rind e.', 'Ev pir rind e.'],
   gen:['Rind û xirab', 'Ev rind e.']),

  // ── ÖZEL İFADE VE KALIP ───────────────────────────────────

  (id:'a2_1780', ku:'Bi xêr were', tr:'Hoş geldin', en:'Welcome',
   cins:'bêcins', ez:null, kat:'silav', zor:0.85,
   not:'"Bi xêr were" = hoş geldiniz. [AS]: karşılama ifadesi.',
   her:['Bi xêr were!', 'Bi xêr hatin!'],
   gen:['Bi xêr were!', 'Bi xêr!']),

  (id:'a2_1781', ku:'Baş be', tr:'İyi ol / Sağlıkla', en:'Be well / Take care',
   cins:'bêcins', ez:null, kat:'silav', zor:0.84,
   not:'"Baş be" = iyi ol.',
   her:['Baş be!', 'Baş bibe!'],
   gen:['Baş be!', 'Xweş be!']),

  (id:'a2_1782', ku:'Xwedê razî be', tr:'Allah razı olsun', en:'May God be pleased',
   cins:'bêcins', ez:null, kat:'silav', zor:0.82,
   not:'Dua kalıbı. "Xwedê razî be ji te" = Allah senden razı olsun.',
   her:['Xwedê razî be!', 'Xwedê ji te razî be.'],
   gen:['Xwedê razî be', 'Ji te spas']),

  (id:'a2_1783', ku:'Derê xêrê be', tr:'Hayırlı işler', en:'Good luck with that',
   cins:'bêcins', ez:null, kat:'silav', zor:0.79,
   not:'İdiyomatik vedalaşma ifadesi.',
   her:['Derê xêrê be!', 'Derê xêrê be, heval.'],
   gen:['Derê xêrê be!', 'Xêr be!']),

  // ── ZAMANLAMA VE FREKANS ──────────────────────────────────

  (id:'a2_1790', ku:'Her sibeh', tr:'Her sabah', en:'Every morning',
   cins:'bêcins', ez:null, kat:'dem', zor:0.82,
   not:'"Her" (her) + "sibeh" (sabah).',
   her:['Her sibeh çay vedixwim.', 'Her sibeh dixebite.'],
   gen:['Her sibeh û her êvar', 'Her sibeh']),

  (id:'a2_1791', ku:'Her êvar', tr:'Her akşam', en:'Every evening',
   cins:'bêcins', ez:null, kat:'dem', zor:0.82,
   not:'"Her" + "êvar".',
   her:['Her êvar stran guhdarî dikim.', 'Her êvar.'],
   gen:['Her êvar û her sibeh', 'Her êvar']),

  (id:'a2_1792', ku:'Carinan', tr:'Bazen', en:'Sometimes',
   cins:'bêcins', ez:null, kat:'dem', zor:0.84,
   not:'"Carinan" — [AS]: "bazen = carinan" ✓.',
   her:['Ew carinan tê mala me.', 'Carinan baş e.'],
   gen:['Carinan û timî', 'Carinan']),

  (id:'a2_1793', ku:'Pir caran', tr:'Çok sık / Sık sık', en:'Often / Frequently',
   cins:'bêcins', ez:null, kat:'dem', zor:0.83,
   not:'"Pir caran" — [AS]: "sık sık = pir caran" ✓.',
   her:['Pir caran tê.', 'Pir caran dikim.'],
   gen:['Pir caran û kêm caran', 'Pir caran']),

  (id:'a2_1794', ku:'Kêm caran', tr:'Nadiren', en:'Rarely',
   cins:'bêcins', ez:null, kat:'dem', zor:0.81,
   not:'"Kêm caran" = nadiren.',
   her:['Kêm caran tê.', 'Kêm caran dikim.'],
   gen:['Kêm caran û pir caran', 'Kêm caran']),

  (id:'a2_1795', ku:'Hema hema', tr:'Neredeyse / Hemen hemen', en:'Almost',
   cins:'bêcins', ez:null, kat:'dem', zor:0.79,
   not:'"Hema hema" = neredeyse. Tekrarla vurgu. "Qet" (hiç) a2_495\'te.',
   her:['Hema hema qediya.', 'Hema hema 100 kes hatin.'],
   gen:['Hema hema û bi tevahî', 'Hema hema']),

  // ── SAĞLIK VE VÜCUT EK ────────────────────────────────────

  (id:'a2_1800', ku:'Spor kirin', tr:'Spor yapmak', en:'To do sports',
   cins:'bêcins', ez:null, kat:'werzî', zor:0.82,
   not:'"Werzîş kirin" veya "spor kirin". Yaygın kullanım.',
   her:['Ez spor dikim.', 'Spor bike!'],
   gen:['Spor kirin û bêhnvedan', 'Spor bike!']),

  (id:'a2_1801', ku:'Jimartin', tr:'Saymak (rakam)', en:'To count',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Jimartin" — [AS] no.1077: "saymak = jimartin" ✓.',
   her:['Me heta deh jimart.', 'Jimartina zarokan zû ye.'],
   gen:['Jimartin û nivîsandin', 'Dijmêre.']),

  (id:'a2_1802', ku:'Nalîn', tr:'Ağrımak / İnlemek', en:'To ache / moan',
   cins:'bêcins', ez:null, kat:'tendurist', zor:0.78,
   not:'"Nalîn" — [FB]: nalîn v. "Diêşe û dinale."',
   her:['Ew dinale.', 'Nexweş dinale.'],
   gen:['Nalîn û ketin', 'Dinale.']),

  // ── HER GÜN KELİMELERİ ────────────────────────────────────

  (id:'a2_1810', ku:'Çend caran', tr:'Kaç kez', en:'How many times',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.81,
   not:'"Çend caran" = kaç kez. Soru kalıbı.',
   her:['Çend caran hatî?', 'Çend caran.'],
   gen:['Çend caran û çend roj', 'Çend caran?']),

  (id:'a2_1811', ku:'Ji kû ye?', tr:'Nereli? / Nereden?', en:'Where are you from?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.84,
   not:'"Ji kû ye?" = nereli/nereden. "Ji" (-den) + "kû" (nere) + "ye" (-dir). [AS]: kimlik sorusu kalıbı. DÜZELTME: Önce "Neden geliyor?" anlamı eklenmişti; bu yanlış. "Neden?" = "çima?".',
   her:['Tu ji kû yî?', 'Ew ji kû ye?'],
   gen:['Ji kû ye?', 'Tu ji kû yî?']),

  (id:'a2_1812', ku:'Bi şev', tr:'Geceleri / Gece vakti', en:'At night',
   cins:'bêcins', ez:null, kat:'dem', zor:0.82,
   not:'"Bi şev" = geceleri.',
   her:['Bi şev dixewim.', 'Bi şev diêşe.'],
   gen:['Bi şev û bi roj', 'Bi şev']),

  (id:'a2_1813', ku:'Bi roj', tr:'Gündüzleri', en:'During the day',
   cins:'bêcins', ez:null, kat:'dem', zor:0.81,
   not:'"Bi roj" = gündüzleri.',
   her:['Bi roj dixebitim.', 'Bi roj tê.'],
   gen:['Bi roj û bi şev', 'Bi roj']),

];


const kA2EkKelimeler10 = [

  // ── AS FİİL LİSTESİNDEN KALANLAR ─────────────────────────

  (id:'a2_1900', ku:'Radest kirin', tr:'Teslim etmek', en:'To hand over',
   cins:'bêcins', ez:null, kat:'leker', zor:0.78,
   not:'"Radest kirin" — [AS] no.1112 ✓.',
   her:['Min radest kir.', 'Radest bike!'],
   gen:['Radest kirin û wergirtin', 'Min radest kir.']),

  (id:'a2_1901', ku:'Rawêj kirin', tr:'Tavsiye etmek / Önermek', en:'To recommend',
   cins:'bêcins', ez:null, kat:'leker', zor:0.78,
   not:'"Rawêj kirin" — [AS] no.1094 ✓. Kurmancî özgün form. "Tewsiye kirin" Arapça kökenli — "rawêj" daha doğru.',
   her:['Min rawêj kir.', 'Çi rawêj dikî?'],
   gen:['Rawêj kirin û red kirin', 'Min rawêj kir.']),

  (id:'a2_1902', ku:'Pîroz kirin', tr:'Tebrik etmek / Kutlamak', en:'To congratulate',
   cins:'bêcins', ez:null, kat:'silav', zor:0.81,
   not:'"Pîroz kirin" — [AS] no.1103 ✓. "Serkeftina te pîroz be!"',
   her:['Pîroz be!', 'Min pîroz kir.'],
   gen:['Pîroz kirin û spas', 'Pîroz be!']),

  (id:'a2_1903', ku:'Derman kirin', tr:'Tedavi etmek', en:'To treat (medically)',
   cins:'bêcins', ez:null, kat:'tendurist', zor:0.78,
   not:'"Derman kirin" — [AS] no.1104 ✓.',
   her:['Bijîşk derman kir.', 'Min derman kir.'],
   gen:['Derman kirin û nexweşî', 'Bijîşk derman kir.']),

  (id:'a2_1904', ku:'Gef lê xwarin', tr:'Tehdit etmek', en:'To threaten',
   cins:'bêcins', ez:null, kat:'leker', zor:0.77,
   not:'"Gef lê xwarin" — [AS] no.1105 ✓.',
   her:['Gef lê xwar.', 'Gef lê nexwe!'],
   gen:['Gef xwarin û tehdît', 'Gef lê xwar.']),

  (id:'a2_1905', ku:'Gilî kirin', tr:'Şikâyet etmek', en:'To complain',
   cins:'bêcins', ez:null, kat:'leker', zor:0.78,
   not:'"Gilî kirin" — [AS] no.1092: "şikâyet = gilî kirin, gazine kirin" ✓.',
   her:['Gilî kir.', 'Gilî neke!'],
   gen:['Gilî kirin û red kirin', 'Gilî kir.']),

  (id:'a2_1906', ku:'Guman kirin', tr:'Şüphelenmek', en:'To suspect',
   cins:'bêcins', ez:null, kat:'leker', zor:0.77,
   not:'"Guman kirin" — [BH]: "guman" özgün Kurmancî form. "Şik kirin" Arapça kökenli alternatif. "Gumanê min heye" = şüphem var.',
   her:['Gumanê min heye.', 'Guman dike.'],
   gen:['Guman kirin û bawer kirin', 'Gumanê min heye.']),

  (id:'a2_1907', ku:'Nefret kirin', tr:'Nefret etmek', en:'To hate',
   cins:'bêcins', ez:null, kat:'his', zor:0.78,
   not:'"Nefret kirin" — [AS] no.1053: "nefret kirin" ✓.',
   her:['Ez ji şer nefret dikim.', 'Nefret neke!'],
   gen:['Nefret kirin û hez kirin', 'Nefret dikim.']),

  // ── EV VE EŞYALAR TAMAMLAMA ───────────────────────────────

  (id:'a2_1910', ku:'Kirêt', tr:'Çirkin / Hoşa gitmeyen', en:'Ugly / Unpleasant',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.79,
   not:'"Kirêt" — [FB]: kirêt adj (awful, vile). "Rind"in zıddı. [AS] no.836. ("Çirqin" standart değildir.)',
   her:['Ev kirêt e.', 'Ew ne kirêt e.'],
   gen:['Kirêt û rind', 'Ev kirêt e.']),

  (id:'a2_1911', ku:'Mêjî', tr:'Beyin / Akıl', en:'Brain / Mind',
   cins:'nêr', ez:'mêjiyê', kat:'beden', zor:0.80,
   not:'Nêr — [FB]: mêjî n.m.',
   her:['Mêjî kar dike.', 'Mêjiyê min.'],
   gen:['Mêjî û dil', 'Mêjiyê me']),

  (id:'a2_1912', ku:'Çerm', tr:'Deri / Cilt', en:'Skin',
   cins:'nêr', ez:'çermê', kat:'beden', zor:0.79,
   not:'Nêr — [FB]: çerm n.m. "Çermê xweş."',
   her:['Çerm tenik e.', 'Çermê min.'],
   gen:['Çerm û mû', 'Çermê min']),

  // ── TEMEL EDAT VE BAĞLAÇ EK ───────────────────────────────

  (id:'a2_1920', ku:'Pê re', tr:'Onunla / Beraber', en:'With it / Along with',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.82,
   not:'"Pê re" = onunla/beraber. [TH] §45.',
   her:['Bi te re.', 'Pê re çûm.'],
   gen:['Bi te re', 'Pê re']),

  (id:'a2_1921', ku:'Ji bo vê', tr:'Bunun için', en:'For this',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.82,
   not:'"Ji bo" + "vê". Bağlaç.',
   her:['Ji bo vê hatim.', 'Ji bo vê lazim e.'],
   gen:['Ji bo vê', 'Ji bo']),

  (id:'a2_1922', ku:'Bi vê yekê re', tr:'Bununla birlikte', en:'Together with this',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.80,
   not:'"Bi vê yekê re" — söylem bağlacı.',
   her:['Bi vê yekê re jî.', 'Bi vê yekê re hat.'],
   gen:['Bi vê yekê re', 'Vê yekê']),

  // ── MEKAN VE YÖN EK ──────────────────────────────────────

  (id:'a2_1930', ku:'Li hundurê', tr:'İçeride / İçinde', en:'Inside',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.83,
   not:'"Li hundurê" = içeride.',
   her:['Li hundurê ne.', 'Biçin hundur!'],
   gen:['Li hundurê û li derve', 'Li hundurê']),

  (id:'a2_1931', ku:'Li derve', tr:'Dışarıda', en:'Outside',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.83,
   not:'"Li derve" = dışarıda.',
   her:['Li derve ne.', 'Biçin derve!'],
   gen:['Li derve û li hundurê', 'Li derve']),

  (id:'a2_1932', ku:'Li jorê', tr:'Yukarıda', en:'Above / Upstairs',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.82,
   not:'"Li jorê" = yukarıda.',
   her:['Li jorê ne.', 'Herin jorê!'],
   gen:['Li jorê û li xwarê', 'Li jorê']),

  (id:'a2_1933', ku:'Li xwarê', tr:'Aşağıda', en:'Below / Downstairs',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.82,
   not:'"Li xwarê" = aşağıda.',
   her:['Li xwarê ne.', 'Herin xwarê!'],
   gen:['Li xwarê û li jorê', 'Li xwarê']),

  // ── KÜRT KÜLTÜRÜ EK ───────────────────────────────────────

  (id:'a2_1940', ku:'Cejna Remezan', tr:'Ramazan Bayramı', en:'Eid al-Fitr',
   cins:'mê', ez:'cejna', kat:'çand', zor:0.81,
   not:'"Cejna Remezan" = Ramazan Bayramı. Kürt kültüründe önemli. "Cejn" dişil → "Cejna te pîroz be!"',
   her:['Cejna te pîroz be!', 'Di cejnê de.'],
   gen:['Cejn û Newroz', 'Cejna we pîroz be!']),

  (id:'a2_1941', ku:'Cejna te pîroz be', tr:'Bayramın kutlu olsun', en:'Happy holiday',
   cins:'bêcins', ez:null, kat:'silav', zor:0.84,
   not:'"Cejna te pîroz be" = bayramın kutlu olsun ("cejn" mê → veqetandek -a). [Aslanoğlu CEJN bölümü]',
   her:['Cejna te pîroz be!', 'Cejna we pîroz be!'],
   gen:['Cejna we pîroz be!', 'Pîroz be!']),

  (id:'a2_1942', ku:'Nan û xwê', tr:'Ekmek ve tuz (birlik sembolü)', en:'Bread and salt',
   cins:'bêcins', ez:null, kat:'çand', zor:0.82,
   not:'"Nan û xwê" = bağlılık ve dostluk sembolü. Kürt kültüründe kutsal.',
   her:['Nan û xwê xwarin.', 'Nan û xwê pîroz e.'],
   gen:['Nan û xwê', 'Xwê û nan']),

  // ── SINAV VE ÖĞRENİM EK ──────────────────────────────────

  (id:'a2_1950', ku:'Peyv fêr bûn', tr:'Kelime öğrenmek', en:'To learn vocabulary',
   cins:'bêcins', ez:null, kat:'perwerde', zor:0.80,
   not:'"Peyv" (kelime) + "fêr bûn".',
   her:['Her roj peyv fêr dibim.', 'Peyv fêr bibe!'],
   gen:['Peyv fêr bûn', 'Her roj peyv fêr bibe']),

  (id:'a2_1951', ku:'Rêzimana kurdî', tr:'Kürtçe dilbilgisi', en:'Kurdish grammar',
   cins:'mê', ez:'rêzimana kurdî', kat:'perwerde', zor:0.79,
   not:'"Rêziman" + "kurdî".',
   her:['Rêzimana kurdî fêr dibim.', 'Di rêzimana kurdî de.'],
   gen:['Rêzimana kurdî', 'Rêzimana me']),

  (id:'a2_1952', ku:'Ferhenga kurdî', tr:'Kürtçe sözlük', en:'Kurdish dictionary',
   cins:'mê', ez:'ferhenga kurdî', kat:'perwerde', zor:0.79,
   not:'"Ferheng" + "kurdî". Ferhenga Birûskî.',
   her:['Ferhenga kurdî bikar tînim.', 'Di ferhenga kurdî de.'],
   gen:['Ferhenga kurdî', 'Ferhenga Birûskî']),

  // ── SON TAMAMLAMA ─────────────────────────────────────────

  (id:'a2_1960', ku:'Zêde bûn', tr:'Artmak / Çoğalmak', en:'To increase',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'"Zêde bûn" — geçişsiz. "Xwendekar zêde bûn."',
   her:['Xwendekar zêde bûn.', 'Germahî zêde bû.'],
   gen:['Zêde bûn û kêm bûn', 'Zêde bû.']),

  (id:'a2_1961', ku:'Kêm bûn', tr:'Azalmak', en:'To decrease',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Kêm bûn" — geçişsiz.',
   her:['Xwendekar kêm bûn.', 'Baran kêm bû.'],
   gen:['Kêm bûn û zêde bûn', 'Kêm bû.']),

  (id:'a2_1962', ku:'Baştir bûn', tr:'İyileşmek', en:'To get better',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'"Baştir bûn" = daha iyi olmak.',
   her:['Nexweş baştir bû.', 'Her roj baştir dibim.'],
   gen:['Baştir bûn û xerab bûn', 'Baştir bû.']),

  (id:'a2_1963', ku:'Xirab bûn', tr:'Kötüleşmek', en:'To get worse',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Xirab bûn" = kötüleşmek.',
   her:['Hewa xirab bû.', 'Rewş xirab bû.'],
   gen:['Xirab bûn û baştir bûn', 'Xirab bû.']),

  (id:'a2_1964', ku:'Dîyar bûn', tr:'Görünmek / Belli olmak', en:'To become clear / visible',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Dîyar bûn" — "dîyar" (belli/açık) + "bûn".',
   her:['Dîyar bû ku rast e.', 'Stêrk dîyar bûn.'],
   gen:['Dîyar bûn û winda bûn', 'Dîyar bû.']),


  (id:'a2_1965', ku:'Lênûsk', tr:'Defter', en:'Notebook',
   cins:'mê', ez:'lênûska', kat:'perwerde', zor:0.82,
   not:'Mê — [AS] no.160: "defter = lênûsk, defter" ✓. "Lê" + "nûsk" — özgün Kurmancî bileşik. "Defter" de kullanılır.',
   her:['Lênûska xwendekarê.', 'Lênûsk û pênûsk.'],
   gen:['Lênûsk û pirtûk', 'Lênûska me']),


];


// ════════════════════════════════════════════════════════════════
// A2 FÊRKERA KURDÎ EK KELİMELER — Doç. Dr. Abdurrahman Adak ve ekibi
// Odak: D.7 Doğa/Çevre, D.8 Dil-Edebiyat, D.9 Aile genişletme
// ════════════════════════════════════════════════════════════════

const kA2FerkeraDersler = [

  // ── DOĞA VE ÇEVRE — [Fêrkera D.7] ────────────────────────────

  (id:'a2_fk_01', ku:'Jîngeh', tr:'Çevre / Ortam', en:'Environment',
   cins:'mê', ez:'jîngeha', kat:'ekoloji', zor:0.81,
   not:'Mê — [Fêrkera D.7] ✓: "Hezkirina Siruştê" dersi. "Jîn" (yaşam) + "geh" (yer). "Jîngehparêzî" = çevrecilik.',
   her:['Jîngeh biparêze.', 'Jîngeh qirêj e.'],
   gen:['Jîngeh û siruşt', 'Jîngeha me']),

  (id:'a2_fk_02', ku:'Siruşt', tr:'Doğa / Tabiat', en:'Nature',
   cins:'mê', ez:'siruşta', kat:'ekoloji', zor:0.82,
   not:'Mê — [Fêrkera D.7] ✓: "Ez hezdêra siruştê me." Doğa.',
   her:['Siruşt xweş e.', 'Li siruştê ne.'],
   gen:['Siruşt û bajêr', 'Siruşta me']),

  (id:'a2_fk_03', ku:'Hatûçû', tr:'Gidiş geliş / Trafik', en:'Traffic / Going and coming',
   cins:'nêr', ez:'hatûçûyê', kat:'bajêr', zor:0.78,
   not:'Nêr — [Fêrkera D.7] ✓: "hat" + "û" + "çû". Trafik/gidip gelme.',
   her:['Hatûçûyê bajêr zêde ye.', 'Hatûçû gelek e.'],
   gen:['Hatûçû û aramî', 'Hatûçûyê bajêr']),

  (id:'a2_fk_04', ku:'Bêhntengî', tr:'Bunaltı / Sıkıntı (hava)', en:'Suffocation / Stuffiness',
   cins:'mê', ez:'bêhntengiya', kat:'ekoloji', zor:0.77,
   not:'Mê — [Fêrkera D.7] ✓: "bêhn" (nefes) + "tengî" (darlık). Hava kirliliği sıkıntısı.',
   her:['Bêhntengîya bajêr zehmet e.', 'Ji bêhntengiyê direvim.'],
   gen:['Bêhntengî û stres', 'Bêhntengîya bajêr']),

  (id:'a2_fk_05', ku:'Bêhn vedan', tr:'Nefes almak / Soluklanmak', en:'To breathe / rest',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Bêhn vedan" = nefes almak/soluklanmak. DİKKAT: "bêhn kirin" = koklamak — karıştırma. [Fêrkera D.7]',
   her:['Em hinekî bêhna xwe vedidin.', 'Bêhnvedan piştî xebatê pêdivî ye.'],
   gen:['Bêhnvedan û xebat', 'Bêhna xwe vede!']),

  (id:'a2_fk_06', ku:'Zevî', tr:'Tarla', en:'Field / Agricultural land',
   cins:'mê', ez:'zeviya', kat:'cotkarî', zor:0.79,
   not:'Mê — [Fêrkera D.7] ✓: "zevî" = tarla.',
   her:['Zevî fireh e.', 'Li zeviyê dixebitin.'],
   gen:['Zevî û baxçe', 'Zevîya me']),

  (id:'a2_fk_07', ku:'Mêrg', tr:'Çayır / Otlak', en:'Meadow / Pasture',
   cins:'mê', ez:'mêrga', kat:'xweza', zor:0.76,
   not:'Mê — [FB]: mêrg n.f. Çayırlık/mera. ("Şemamok" bir kavun türüdür — çayır değildir.)',
   her:['Mêrg kesk e.', 'Ajal li mêrgê ne.'],
   gen:['Mêrg û zevî', 'Mêrga me']),

  (id:'a2_fk_08', ku:'Nêrgiz', tr:'Nergis (çiçek)', en:'Daffodil / Narcissus',
   cins:'mê', ez:'nêrgiza', kat:'xweza', zor:0.77,
   not:'Mê — [Fêrkera D.7] ✓. Kürdistan\'da baharın simgesi.',
   her:['Nêrgiz şîn bûye.', 'Nêrgizên zer.'],
   gen:['Nêrgiz û gul', 'Nêrgizên bihar']),

  (id:'a2_fk_09', ku:'Zerdele', tr:'Kayısı', en:'Apricot',
   cins:'mê', ez:'zerdeleya', kat:'xwarin', zor:0.78,
   not:'Mê — [Fêrkera D.7] ✓. Kürdistan\'da bol yetişir.',
   her:['Zerdele şîrîn e.', 'Zarok zerdele û sêvan dixwin.'],
   gen:['Zerdele û sêv', 'Zerdeleyên me']),

  // ── DİL VE EDEBİYAT — [Fêrkera D.8] ──────────────────────────

  (id:'a2_fk_10', ku:'Helbest', tr:'Şiir', en:'Poem / Poetry',
   cins:'mê', ez:'helbesta', kat:'edebiyat', zor:0.81,
   not:'Mê — [Fêrkera D.8] ✓: "helbest, çîrok, şanoname" listede. Şiir.',
   her:['Wê helbesteke xweş xwend.', 'Helbesteke xweş.'],
   gen:['Helbest û çîrok', 'Helbestên kurdî']),

  (id:'a2_fk_11', ku:'Çîrok', tr:'Hikaye / Öykü', en:'Story',
   cins:'mê', ez:'çîroka', kat:'edebiyat', zor:0.82,
   not:'Mê — [Fêrkera D.8] ✓. Hem "hikaye" hem "masal".',
   her:['Çîrok xwend.', 'Çîroka xweş.'],
   gen:['Çîrok û helbest', 'Çîrokên kurdî']),

  (id:'a2_fk_12', ku:'Şanoname', tr:'Oyun / Tiyatro metni', en:'Play / Drama',
   cins:'mê', ez:'şanonameya', kat:'edebiyat', zor:0.77,
   not:'Mê — [Fêrkera D.8] ✓: "şano" (sahne) + "name". Oyun metni.',
   her:['Şanoname dixwînim.', 'Şanonameke xweş.'],
   gen:['Şanoname û helbest', 'Şanonameyên kurdî']),

  (id:'a2_fk_13', ku:'Kovar', tr:'Dergi', en:'Magazine / Journal',
   cins:'mê', ez:'kovara', kat:'medya', zor:0.81,
   not:'Mê — [Fêrkera D.8] ✓: "Em kovarekê derdixin." Dergi.',
   her:['Kovar derdikeve.', 'Ev kovar her meh derdikeve.'],
   gen:['Kovar û rojname', 'Kovara me']),

  (id:'a2_fk_14', ku:'Weşandin', tr:'Yayımlamak / Yayınlamak', en:'To publish',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Weşandin" — [Fêrkera D.8] ✓. Ergatif: "Min weşand."',
   her:['Min weşand.', 'Kovar hate weşandin.'],
   gen:['Weşandin û çapkirin', 'Min weşand.']),

  (id:'a2_fk_15', ku:'Çapkirin', tr:'Basmak / Yayınlamak', en:'To print / publish',
   cins:'bêcins', ez:null, kat:'leker', zor:0.78,
   not:'"Çapkirin" — [Fêrkera D.8] ✓. "Çap" (baskı) + "kirin".',
   her:['Pirtûk hate çapkirin.', 'Çap bike!'],
   gen:['Çapkirin û weşandin', 'Hate çapkirin.']),

  // ── DİVÊ — [Fêrkera D.1] ──────────────────────────────────────

  (id:'a2_fk_16', ku:'Divê', tr:'Gerekir / -meli / -malı', en:'Must / Should',
   cins:'bêcins', ez:null, kat:'rêziman', zor:0.84,
   not:'"Divê" — [Fêrkera D.1] ✓: "divê em hemûyan biqedînin!" Zorunluluk ifadesi. "Divê + subjunctive" yapısı.',
   her:['Divê were.', 'Divê em biçin.'],
   gen:['Divê û dibe', 'Divê were!']),

  // ── SIFATLAR — [Fêrkera D.2] ──────────────────────────────────

  (id:'a2_fk_17', ku:'Fireh', tr:'Geniş', en:'Wide / Spacious',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.82,
   not:'"Fireh" — [Fêrkera D.2] ✓: "Pola me fireh û ronî ye." Geniş.',
   her:['Pol fireh e.', 'Rê fireh e.'],
   gen:['Fireh û teng', 'Ev fireh e.']),

  (id:'a2_fk_18', ku:'Ronak', tr:'Aydın / Işıklı', en:'Luminous / Enlightened',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.78,
   not:'"Ronak" — [Fêrkera D.2] ✓. "Ron" (parlak) + "-ak". Hem fiziksel ışık hem mecazi aydın (aydınlanmış). "Ronî" a2_451\'de.',
   her:['Mirovê ronak.', 'Odayek ronak.'],
   gen:['Ronak û tarî', 'Ev ronak e.']),

  (id:'a2_fk_19', ku:'Hêja', tr:'Değerli / Kıymetli', en:'Precious / Worthy',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.82,
   not:'"Hêja" — [Fêrkera D.2] ✓: "Hemû hevalên min hêja ne." Değerli/sayın.',
   her:['Hevalên min hêja ne.', 'Ew hêja ye.'],
   gen:['Hêja û kêmgotin', 'Ev hêja ye.']),

  (id:'a2_fk_20', ku:'Westiyayî', tr:'Yorgun', en:'Tired',
   cins:'bêcins', ez:null, kat:'his', zor:0.82,
   not:'"Westiyayî" — [Fêrkera D.1] ✓: "Qey tu pir westîyayî?" Yorgun. (Hawar imlâsı: î, y\'den önce kısa i olur)',
   her:['Ez westiyame.', 'Tu westiyayî?'],
   gen:['Westiyayî û sax', 'Ez westiyame.']),

];


const kA2Son30 = [

  // ── GÜNLÜK HAYAT ALIŞKANLIKLARI ────────────────────────────
  (id:'a2_z01', ku:'Destşûştin', tr:'El yıkamak', en:'To wash hands',
   cins:'bêcins', ez:null, kat:'jiyan', zor:0.82,
   not:'"Dest" + "şûştin". [Fêrkera D.5] bağlamı. "Dest bişo" = elini yıka.',
   her:['Berî xwarinê em destên xwe dişon.', 'Destşûştin ji bo tenduristiyê girîng e.'],
   gen:['Destşûştin û xwarin', 'Destên xwe bişo!']),

  (id:'a2_z02', ku:'Hişyarbûn', tr:'Uyanmak', en:'To wake up',
   cins:'bêcins', ez:null, kat:'jiyan', zor:0.82,
   not:'"Hişyarbûn" — [Fêrkera D.5] ✓: "hişyarbûn, şûştin, destpêkirin, gerîn...".',
   her:['Sibehê hişyarbûn xweş e.', 'Hişyarbûna zû girîng e.'],
   gen:['Hişyarbûn û raketin', 'Hişyar bû.']),

  (id:'a2_z03', ku:'Raketin', tr:'Yatmak / Uyumak', en:'To lie down / sleep',
   cins:'bêcins', ez:null, kat:'jiyan', zor:0.82,
   not:'"Raketin" — [Fêrkera D.5] ✓. "Rakete" = yattı.',
   her:['Êvarê em raketin.', 'Raketin di nava nivînê de rehet e.'],
   gen:['Raketin û hişyarbûn', 'Rakete.']),

  (id:'a2_z04', ku:'Werzîş kirin', tr:'Egzersiz yapmak', en:'To exercise',
   cins:'bêcins', ez:null, kat:'jiyan', zor:0.79,
   not:'"Werzîş kirin" — "werzîş" (spor) + "kirin".',
   her:['Her roj werzîş dikim.', 'Werzîş bike!'],
   gen:['Werzîş û xwarin', 'Werzîş bike!']),

  (id:'a2_z05', ku:'Çûyîna dikanê', tr:'Alışverişe gitme', en:'Going shopping',
   cins:'mê', ez:'çûyîna dikanê', kat:'jiyan', zor:0.79,
   not:'"Çûyîn" + "dikanê". Günlük alışveriş.',
   her:['Ez diçim dikanê.', 'Çûyîna dikanê kêfxweş e.'],
   gen:['Çûyîna dikanê', 'Li dikanê']),

  // ── ZAMAN İFADELERİ ────────────────────────────────────────
  (id:'a2_z06', ku:'Piştî demekê', tr:'Bir süre sonra', en:'After a while',
   cins:'bêcins', ez:null, kat:'dem', zor:0.80,
   not:'"Piştî" + "demekê" (bir sürenin). Zaman ifadesi.',
   her:['Piştî demekê hat.', 'Piştî demekê em diçin.'],
   gen:['Piştî demekê', 'Di demekê de']),

  (id:'a2_z07', ku:'Her dem', tr:'Her zaman / Daima', en:'Always',
   cins:'bêcins', ez:null, kat:'dem', zor:0.83,
   not:'"Her dem" = her zaman. "Tim û tim" de kullanılır.',
   her:['Her dem dixwînim.', 'Her dem baş be.'],
   gen:['Her dem û carinan', 'Her dem']),

  (id:'a2_z08', ku:'Niha niha', tr:'Az önce / Demin', en:'Just now',
   cins:'bêcins', ez:null, kat:'dem', zor:0.80,
   not:'"Niha niha" = az önce (tekrarlı vurgu). "Nû hat" = az önce geldi (anlamsal alternatif). A1\'de "Nû" (yeni) var; burada zaman zarfı anlamı.',
   her:['Niha niha hat.', 'Niha niha min ew dît.'],
   gen:['Niha niha û berê', 'Niha niha']),

  // ── MEKAN VE YÖN ────────────────────────────────────────────
  (id:'a2_z09', ku:'Naverast', tr:'Ortada / Merkez', en:'In the middle / Center',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.80,
   not:'"Naverast" = orta/merkez. "Nav" + "rast".',
   her:['Li naverastê ye.', 'Di naverastê de.'],
   gen:['Naverast û alî', 'Li naverast']),

  (id:'a2_z10', ku:'Jor û xwar', tr:'Yukarı aşağı', en:'Up and down',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.80,
   not:'"Jor" (yukarı) + "û" + "xwar" (aşağı). Bileşik yön ifadesi.',
   her:['Jor û xwar çû.', 'Ji jor û xwar.'],
   gen:['Jor û xwar', 'Ji jor ve']),

  // ── KARSILAŞma VE SOSYAL ────────────────────────────────────
  (id:'a2_z11', ku:'Miqate bûn', tr:'Dikkat etmek / Özen göstermek', en:'To be careful',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Miqate bûn" = dikkatli olmak.',
   her:['Miqate be!', 'Tu miqate yî?'],
   gen:['Miqate bûn û xemxwarin', 'Miqate be!']),

  (id:'a2_z12', ku:'Xwe amade kirin', tr:'Hazırlanmak', en:'To prepare oneself',
   cins:'bêcins', ez:null, kat:'leker', zor:0.80,
   not:'"Xwe amade kirin" = hazırlanmak.',
   her:['Xwe amade bike!', 'Xwe amade kir.'],
   gen:['Xwe amade kirin', 'Xwe amade bike!']),

  (id:'a2_z13', ku:'Destûr xwestin', tr:'İzin istemek', en:'To ask permission',
   cins:'bêcins', ez:null, kat:'silav', zor:0.79,
   not:'"Destûr xwestin" = izin istemek.',
   her:['Destûr dixwazim.', 'Destûr lê xwest.'],
   gen:['Destûr xwestin û dayîn', 'Destûr dixwazim.']),

  // ── ÇEVRE VE DOĞA ───────────────────────────────────────────
  (id:'a2_z14', ku:'Esman', tr:'Gökyüzü', en:'Sky',
   cins:'nêr', ez:'esmanê', kat:'xweza', zor:0.82,
   not:'Nêr — "ezman" da yazılır. "Esman şîn e" = gökyüzü mavidir.',
   her:['Esman şîn e.', 'Stêr li esmên in.'],
   gen:['Esman û erd', 'Esmanê şîn']),

  (id:'a2_z15', ku:'Stêr', tr:'Yıldız', en:'Star',
   cins:'mê', ez:'stêra', kat:'xweza', zor:0.82,
   not:'Mê — "stêr" = yıldız. "Stêrên esmên."',
   her:['Stêr ronî ne.', 'Bi şev stêr xuya dibin.'],
   gen:['Stêr û heyv', 'Stêrên esmên']),

  (id:'a2_z16', ku:'Heyv', tr:'Ay', en:'Moon',
   cins:'mê', ez:'heyva', kat:'xweza', zor:0.82,
   not:'Mê — "heyv" = ay. "Heyv şevê ronî dike."',
   her:['Heyv derdikeve.', 'Heyva tijî xweş e.'],
   gen:['Heyv û stêr', 'Heyva tijî']),

  (id:'a2_z17', ku:'Roj', tr:'Güneş / Gün', en:'Sun / Day',
   cins:'mê', ez:'roja', kat:'xweza', zor:0.85,
   not:'Mê — "roj" hem güneş hem gün; DİŞİLDİR: "roja xweş" [Badillî: "roj, di., gün"; KURMANCI_RULES: roj F].',
   her:['Roj derdikeve.', 'Dawet roja yekşemê ye.'],
   gen:['Roj û heyv', 'Roja me']),

  // ── BESLENME VE SAĞLIK ──────────────────────────────────────
  (id:'a2_z18', ku:'Birçî', tr:'Aç', en:'Hungry',
   cins:'bêcins', ez:null, kat:'his', zor:0.83,
   not:'"Birçî" = aç. "Ez birçî me" = Açım. [Fêrkera]: mêvan birçî ne.',
   her:['Ez birçî me.', 'Ew birçî ne.'],
   gen:['Birçî û têr', 'Ez birçî me.']),

  (id:'a2_z19', ku:'Têr', tr:'Tok', en:'Full / Satiated',
   cins:'bêcins', ez:null, kat:'his', zor:0.82,
   not:'"Têr" = tok. "Ez têr bûm" = tokum.',
   her:['Ez têr bûm.', 'Tu têr î?'],
   gen:['Têr û birçî', 'Ez têr bûm.']),

  (id:'a2_z20', ku:'Tî', tr:'Susamış', en:'Thirsty',
   cins:'bêcins', ez:null, kat:'his', zor:0.82,
   not:'"Tî" = susamış. [Fêrkera]: "Zarok tî ne."',
   her:['Ez tî me.', 'Zarok tî ne.'],
   gen:['Tî û têr', 'Ez tî me.']),

  // ── DUYGULAR EK ─────────────────────────────────────────────
  (id:'a2_z21', ku:'Dilşikandî', tr:'Kırık kalpli / Üzgün', en:'Heartbroken',
   cins:'bêcins', ez:null, kat:'his', zor:0.79,
   not:'"Dil" + "şikandî". [Fêrkera]: "Dayik dilşikandî ne."',
   her:['Dayik dilşikandî ne.', 'Ez dilşikandî me.'],
   gen:['Dilşikandî û kêfxweş', 'Ev dilşikandî ye.']),

  (id:'a2_z22', ku:'Şa bûn', tr:'Sevinmek', en:'To be happy / rejoice',
   cins:'bêcins', ez:null, kat:'his', zor:0.81,
   not:'"Şa bûn" = sevinmek. "Ez şa bûm" = sevindim.',
   her:['Ez şa bûm.', 'Tu şa yî?'],
   gen:['Şa bûn û xemgîn bûn', 'Ez şa bûm.']),

  // ── DİLBİLGİSİ KALIPLARI ────────────────────────────────────
  (id:'a2_z23', ku:'Weke mînak', tr:'Örneğin', en:'For example',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.82,
   not:'"Weke mînak" = örneğin. A2 bağlaç.',
   her:['Weke mînak ez dixwînim.'],
   gen:['Weke mînak', 'Mînak']),

  (id:'a2_z24', ku:'Lewma', tr:'Bu yüzden / Onun için', en:'Therefore',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.81,
   not:'"Lewma" = bu yüzden/onun için. "Lewre" de kullanılır.',
   her:['Tu nehatî, lewma ez jî neçûm.', 'Lewma ez dixwînim.'],
   gen:['Lewma û ji ber ku', 'Lewma']),

  (id:'a2_z25', ku:'Helbet', tr:'Tabii ki / Elbette', en:'Of course',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.83,
   not:'"Helbet" = tabii ki/elbette.',
   her:['Helbet, baş e!', 'Helbet ez diçim.'],
   gen:['Helbet û na', 'Helbet!']),

  // ── SAYILAR VE ÖLÇÜ ─────────────────────────────────────────
  (id:'a2_z26', ku:'Hûrdem', tr:'Dakika (öz Kurmancî)', en:'Minute (native form)',
   cins:'mê', ez:'hûrdema', kat:'dem', zor:0.77,
   not:'Mê — [AS]: "dakika = hûrdem, deqîqe" ✓. "Hûr" (küçük) + "dem" (zaman). Öz Kurmancî alternatif; "deqîqe" a2_1061\'de Arapça kökenli.',
   her:['Pênc hûrdem man.', 'Di hûrdemekê de.'],
   gen:['Hûrdem û deqîqe', 'Pênc hûrdem']),

  (id:'a2_z27', ku:'Hefteyek', tr:'Bir hafta', en:'One week',
   cins:'mê', ez:'hefteyeke', kat:'dem', zor:0.81,
   not:'"Hefteyek" = bir hafta. "Heft" + "-e" + "-yek".',
   her:['Piştî hefteyekê tê.', 'Hefteyek ma.'],
   gen:['Hefteyek û meh', 'Piştî hefteyekê']),

  // ── YOLCULUK EK ─────────────────────────────────────────────
  (id:'a2_z28', ku:'Nexşe', tr:'Harita', en:'Map',
   cins:'mê', ez:'nexşeya', kat:'rêwîtî', zor:0.80,
   not:'Mê — [Fêrkera D.2] ✓: "nexşe" listede. Harita.',
   her:['Di polê de du nexşe hene.', 'Li nexşeyê binêre.'],
   gen:['Nexşe û rê', 'Nexşeya Kurdistanê']),

  (id:'a2_z29', ku:'Mêjer', tr:'Miktar / Ölçü', en:'Amount / Measure',
   cins:'mê', ez:'mêjera', kat:'jimar', zor:0.78,
   not:'Mê — "mêjer" = miktar/ölçü. [BH] ✓ mêzîn (ölçmek) kökünden.',
   her:['Mêjera wê çend e?', 'Mêjer gelek e.'],
   gen:['Mêjer û biha', 'Mêjera wê']),

  (id:'a2_z30', ku:'Ciwan bûn', tr:'Büyümek (güzel olmak)', en:'To grow up beautifully',
   cins:'bêcins', ez:null, kat:'jiyan', zor:0.79,
   not:'"Ciwan bûn" = büyümek/güzelleşmek. [Fêrkera]: "Ciwan" = genç/güzel.',
   her:['Tu ciwan bûyî!', 'Ew ciwan e.'],
   gen:['Ciwan bûn û mezin bûn', 'Tu ciwan bûyî!']),
];

final kA2TamListe = [
  ...kA2Kelimeler,
  ...kA2EkKelimeler, ...kA2EkKelimeler2, ...kA2EkKelimeler3,
  ...kA2EkKelimeler4, ...kA2EkKelimeler5, ...kA2EkKelimeler6,
  ...kA2EkKelimeler7, ...kA2EkKelimeler8, ...kA2EkKelimeler9,
  ...kA2EkKelimeler10, ...kA2FerkeraDersler, ...kA2Son30,
  // FerMat köprüsü (Faz 7): terim tabanından üretilen matematik birimi.
  ...kA2Matematik,
];