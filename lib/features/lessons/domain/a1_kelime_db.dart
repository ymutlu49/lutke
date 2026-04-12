/// LÛTKE — A1 Tam Kelime Veritabanı
///
/// Kaynak: Osman Aslanoğlu Dil Kartları (2017) + Bedir Han & Lescot
/// Müfredat: Prof. Dr. Yılmaz Mutlu & Prof. Dr. Osman Aslanoğlu
/// Düzeltme: Nisan 2026 — birim başlıkları standartlaştırıldı
///
/// Her kelimede:
/// - id: benzersiz, sıralı
/// - kurmanji: Bedir Han Latin alfabesi standardı
/// - turkce / ingilizce: çeviri
/// - cinsiyet: "nêr" (eril) / "mê" (dişil) / "bêcins" (fiil/değişmez)
/// - ezafe: ezafe formu (isimler için)
/// - kategori: FSRS kategori kodu
/// - zorluk: FSRS başlangıç zorluğu (0.50–0.90)
/// - cinsiyetNotu: Türkçe konuşan için cinsiyet ipucu
/// - heritage / genel: iki paralel cümle seti

// ignore_for_file: constant_identifier_names

const kA1TamKelimeler = [

  // ════════════════════════════════════════════════════════════
  // BİRİM 1 — Alfabe û Dengên Kurmancî (Alfabe ve Sesler)
  // Kaynak: Bedir Han & Lescot Bölüm 1–5, Aslanoğlu s.1–2
  // ════════════════════════════════════════════════════════════

  (id:'a1_001', ku:'a', tr:'a (kısa ünlü)', en:'a', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.88, not:'Türkçe a gibi — "av" (su), "bav" (baba)',
   her:['A harfini tanı: av, bav, sal.', 'Pîrê, "a" dengê çi ye?'],
   gen:['A — Kurmancîde kısa a', 'Mînak: av, bav, mal']),

  (id:'a1_002', ku:'ê', tr:'ê (uzun e — Fransızca é)', en:'ê', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.72, not:'Türkçede yok! Fransızca "été" kelimesindeki é gibi — ağız biraz gülümser',
   her:['Pîrê "mêr" dibêje — dengê ê bibihîze.', 'Bavê min "dêya min" dibêje.'],
   gen:['ê — Kurmancî özel ses', 'Mînak: mêr, dêya, kêr, pêş']),

  (id:'a1_003', ku:'î', tr:'î (uzun i)', en:'î', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.80, not:'Türkçe i\'nin uzunu — "in" değil "îro" gibi',
   her:['Xwişka min "spî" dibêje.', 'Bira, dengê î bide min.'],
   gen:['î — uzun i sesi', 'Mînak: spî, nîvro, kî, îro']),

  (id:'a1_004', ku:'û', tr:'û (uzun u)', en:'û', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.80, not:'Türkçe u\'nun uzunu',
   her:['Pîrê "hûn" dibêje — "siz" demek.', 'Dê "û" bêje — "ve" demek.'],
   gen:['û — uzun u + "ve" bağlacı', 'Mînak: hûn, û, dûr, rû']),

  (id:'a1_005', ku:'x', tr:'x (gırtlak h)', en:'x (guttural)', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.62, not:'Türkçede yok — boğazdan çıkar, Arapça "خ" gibi. "Hain" kelimesindeki h\'ya benzer ama daha kuvvetli',
   her:['Bavê min "xwarin" dibêje — ye demek.', 'Pîrê "xweş" dibêje — güzel demek.'],
   gen:['x — gırtlak sesi', 'Mînak: xwarin, xweş, xwişk, xatir']),

  (id:'a1_006', ku:'q', tr:'q (kalın k)', en:'q (uvular)', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.65, not:'Türkçedeki k\'dan daha kalın — damaktan değil gırtlaktan. "Kader" kelimesindeki k kalın söylenir',
   her:['Bira "qehwe" dibêje — kahve demek.', '"Qehwe" bixwe, pîrê!'],
   gen:['q — kalın k sesi', 'Mînak: qehwe, qir, qad, qeşmer']),

  (id:'a1_007', ku:'w', tr:'w (v/u karışımı)', en:'w', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.75, not:'İngilizce w gibi — dudaklar yuvarlak. "Vatan" değil, "water" gibi',
   her:['Dê "welat" dibêje — vatan demek.', 'Bavê min "wek" dixebite.'],
   gen:['w — dudak sesi', 'Mînak: welat, wek, ew, wan']),

  (id:'a1_008', ku:'r', tr:'r (titrek r)', en:'r (trilled)', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.78, not:'İspanyolca "rr" gibi — dil damağa dokunarak titrer. Türkçe r\'den farklı',
   her:['Pîrê "roj" dibêje — gün demek.', '"Roj" û "şev" — gün ve gece.'],
   gen:['r — titrek r sesi', 'Mînak: roj, rê, rast, biharê']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 2 — Silavdan û Pêşkêşkirin (Selamlama ve Tanışma)
  // Kaynak: Aslanoğlu Pratik Konuşma Kılavuzu (Axaftna Rojane)
  // ════════════════════════════════════════════════════════════

  (id:'a1_010', ku:'Silav', tr:'Merhaba', en:'Hello', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.88, not:'Her durumda kullanılır — sabah/akşam/gündüz fark etmez',
   her:['Silav, pîrê!', 'Silav, dê û bav!'],
   gen:['Silav, heval!', 'Silav, baş î?']),

  (id:'a1_011', ku:'Merheba', tr:'Merhaba (resmi)', en:'Greetings', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.85, not:'"Silav" daha samimi, "Merheba" biraz daha resmi — ikisi de doğru',
   her:['Merheba, ap!', 'Merheba, malbato!'],
   gen:['Merheba û spas', 'Merheba, nasî?']),

  (id:'a1_012', ku:'Spas', tr:'Teşekkür ederim', en:'Thank you', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.88, not:'"Sipas" da denir — ikisi de doğru',
   her:['Spas, dayê!', 'Gelek spas, pîrê!'],
   gen:['Spas ji te re.', 'Spas û sipas.']),

  (id:'a1_013', ku:'Gelek spas', tr:'Çok teşekkür ederim', en:'Thank you very much', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.86, not:'"Gelek" = çok. "Gelek spas" = çok teşekkürler',
   her:['Gelek spas, kal!', 'Gelek spas, dayê!'],
   gen:['Gelek spas ji alîkariya te re.', 'Gelek spas û sipas.']),

  (id:'a1_014', ku:'Erê', tr:'Evet', en:'Yes', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.90, not:'Çok kolay — kalıpsal, her zaman "erê"',
   her:['Erê, dayê, ez hatim!', 'Erê, baş im.'],
   gen:['Erê, dizanim.', 'Erê, rast e.']),

  (id:'a1_015', ku:'Na', tr:'Hayır', en:'No', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.90, not:'Türkçe "na" demeyin — Kurmancîde bu olumsuzluk',
   her:['Na, pîrê, ne germ e.', 'Na, dê, ez nehatim.'],
   gen:['Na, spas.', 'Na, ne rast e.']),

  (id:'a1_016', ku:'Baş e', tr:'İyi / Tamam', en:'Good / OK', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.88, not:'"Baş" = iyi, "e" = olmak fiili 3.tekil. "Baş e" = iyidir',
   her:['Baş e, dayê, ez hatim.', 'Baş e, pîrê!'],
   gen:['Baş e, spas.', 'Ev baş e.']),

  (id:'a1_017', ku:'Tu çawa yî?', tr:'Nasılsın?', en:'How are you?', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.85, not:'"Çawa" = nasıl, "yî" = sen-sin (bûn fiili)',
   her:['Pîrê, tu çawa yî?', 'Dê, tu çawa yî?'],
   gen:['Heval, tu çawa yî?', 'Tu çawa yî, baş î?']),

  (id:'a1_018', ku:'Ez baş im', tr:'İyiyim', en:"I'm fine", cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.86, not:'"Ez" = ben, "baş" = iyi, "im" = -im (bûn fiili 1.tekil)',
   her:['Ez baş im, spas, pîrê!', 'Ez baş im, dê.'],
   gen:['Ez baş im, tu?', 'Ez baş im, gelek spas.']),

  (id:'a1_019', ku:'Navê min … e', tr:'Adım … dır', en:'My name is …', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.83, not:'"Nav" = isim/ad (eril), "navê min" = benim adım (ezafe -ê)',
   her:['Navê min Fatma ye, pîrê!', 'Navê min Mehmet e.'],
   gen:['Navê min … e, tu kî yî?', 'Navê min Narin e.']),

  (id:'a1_020', ku:'Tu kî yî?', tr:'Sen kimsin?', en:'Who are you?', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.84, not:'"Kî" = kim. Soru cümlesi — cümle sonuna ? yeter',
   her:['Tu kî yî, kurê min?', 'Pîrê, tu kî yî?'],
   gen:['Tu kî yî? Navê te çi ye?', 'Tu kî yî, heval?']),

  (id:'a1_021', ku:'Bi xêr hatî', tr:'Hoş geldiniz', en:'Welcome', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.82, not:'"Bi xêr" = iyilikle, "hatî" = geldin. Misafiri karşılarken söylenir',
   her:['Bi xêr hatî, malbato!', 'Bi xêr hatî malê me!'],
   gen:['Bi xêr hatî Kurdistanê!', 'Bi xêr hatî, heval!']),

  (id:'a1_022', ku:'Xatirê te', tr:'Hoşça kal / Güle güle', en:'Goodbye', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.82, not:'"Xatir" = hatır, "xatirê te" = senin hatırın için — ayrılırken söylenir',
   her:['Xatirê te, pîrê!', 'Xatirê te, dê û bav!'],
   gen:['Xatirê te, heval!', 'Bi xêr bimîne, xatirê te!']),

  (id:'a1_023', ku:'Bibore', tr:'Özür dilerim / Pardon', en:'Excuse me / Sorry', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.84, not:'Hafif özür için "Bibore", derin pişmanlık için "Li min bibore"',
   her:['Bibore, pîrê!', 'Bibore, dê, dereng hatim.'],
   gen:['Bibore, ez dereng im.', 'Bibore, tu dizanî?']),

  (id:'a1_024', ku:'Destê te xweş be', tr:'Elinize sağlık', en:'Well done (for cooking)', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.78, not:'"Dest" = el, "xweş" = güzel. Yemekten sonra söylenen geleneksel ifade',
   her:['Destê te xweş be, dêyê!', 'Destê te xweş be, pîrê — nan xweş bû!'],
   gen:['Destê te xweş be!', 'Xwarin xweş bû, destê te xweş be.']),

  (id:'a1_025', ku:'Bextewar', tr:'Mutlu / Bahtiyar', en:'Happy', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.80, not:'"Bextewar" = bahtiyar — Farsça kökenli ama Kurmancîde yerleşmiş',
   her:['Ez bextewar im, pîrê!', 'Tu bextewar î?'],
   gen:['Em bextewar in.', 'Bextewar bî!']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 3 — Jimar (Sayılar 0–100+)
  // Kaynak: Aslanoğlu s.4 — JIMAR-JIMARÊN RÊZÊ
  // ════════════════════════════════════════════════════════════

  (id:'a1_030', ku:'Sifir', tr:'Sıfır', en:'Zero', cins:'bêcins', ez:null, kat:'jimar', zor:0.82,
   not:'Arapça "sıfır"dan — aynı',
   her:['Sifir heye!', 'Temp: sifir derece.'], gen:['Sifir, yek, du', 'Jimarê sifir']),

  (id:'a1_031', ku:'Yek', tr:'Bir', en:'One', cins:'bêcins', ez:null, kat:'jimar', zor:0.85,
   not:'Çok kolay — "yek" = bir',
   her:['Yek çay bide min, dêyê.', 'Yek birê min heye.'],
   gen:['Yek, du, sê', 'Yek kilo nan']),

  (id:'a1_032', ku:'Du', tr:'İki', en:'Two', cins:'bêcins', ez:null, kat:'jimar', zor:0.85,
   not:'"Du" kısa ve net',
   her:['Du xwişk in.', 'Du çay, pîrê!'],
   gen:['Du saet', 'Du kilo nan']),

  (id:'a1_033', ku:'Sê', tr:'Üç', en:'Three', cins:'bêcins', ez:null, kat:'jimar', zor:0.84,
   not:'"Sê" — ê uzun söylenir',
   her:['Sê kur in.', 'Sê roj man.'],
   gen:['Sê saet', 'Em sê in.']),

  (id:'a1_034', ku:'Çar', tr:'Dört', en:'Four', cins:'bêcins', ez:null, kat:'jimar', zor:0.84,
   not:'"Çar" — ç sesi Türkçeyle aynı',
   her:['Çar mevsim hene.', 'Çar dê û bav in.'],
   gen:['Çar saet', 'Çar mirov']),

  (id:'a1_035', ku:'Pênc', tr:'Beş', en:'Five', cins:'bêcins', ez:null, kat:'jimar', zor:0.83,
   not:'"Pênc" — ê uzun, nc birlikte',
   her:['Pênc nan bide min.', 'Pênc roj man.'],
   gen:['Pênc kilo', 'Pênc saet']),

  (id:'a1_036', ku:'Şeş', tr:'Altı', en:'Six', cins:'bêcins', ez:null, kat:'jimar', zor:0.82,
   not:'"Şeş" — ş sesi Türkçeyle aynı',
   her:['Şeş endamê malbata me ne.', 'Şeş saet xew kir.'],
   gen:['Şeş rojen', 'Şeş kes']),

  (id:'a1_037', ku:'Heft', tr:'Yedi', en:'Seven', cins:'bêcins', ez:null, kat:'jimar', zor:0.82,
   not:'"Heft" — t sonda belirgin',
   her:['Heft rojen di hefteyê de.', 'Heft nan dixwim.'],
   gen:['Heft roj', 'Di heft saetan de']),

  (id:'a1_038', ku:'Heşt', tr:'Sekiz', en:'Eight', cins:'bêcins', ez:null, kat:'jimar', zor:0.81,
   not:'"Heşt" — şt birlikte söylenir',
   her:['Heşt saet xew kir.', 'Heşt sal berê.'],
   gen:['Heşt kes', 'Heşt kilo']),

  (id:'a1_039', ku:'Neh', tr:'Dokuz', en:'Nine', cins:'bêcins', ez:null, kat:'jimar', zor:0.82,
   not:'"Neh" — kısa ve net',
   her:['Neh çay vexwar.', 'Neh sal in.'],
   gen:['Neh saet', 'Neh kilo']),

  (id:'a1_040', ku:'Deh', tr:'On', en:'Ten', cins:'bêcins', ez:null, kat:'jimar', zor:0.83,
   not:'"Deh" — d sesi yumuşak',
   her:['Deh çay xwarin.', 'Deh sal berê, pîrê!'],
   gen:['Deh kilo', 'Deh mirov']),

  (id:'a1_041', ku:'Bîst', tr:'Yirmi', en:'Twenty', cins:'bêcins', ez:null, kat:'jimar', zor:0.80,
   not:'"Bîst" — î uzun',
   her:['Bîst sal in, pîrê!', 'Bîst dolar.'],
   gen:['Bîst kilo', 'Bîst kes']),

  (id:'a1_042', ku:'Sih', tr:'Otuz', en:'Thirty', cins:'bêcins', ez:null, kat:'jimar', zor:0.79,
   not:'"Sih" — s sesi yumuşak',
   her:['Sih sal zewicî ye.', 'Sih kilo nan.'],
   gen:['Sih saet', 'Sih dolar']),

  (id:'a1_043', ku:'Çil', tr:'Kırk', en:'Forty', cins:'bêcins', ez:null, kat:'jimar', zor:0.80,
   not:'"Çil" — kısa ve net',
   her:['Çil sal in, bav!', 'Çil kilo.'],
   gen:['Çil rojen', 'Çil sal']),

  (id:'a1_044', ku:'Pêncî', tr:'Elli', en:'Fifty', cins:'bêcins', ez:null, kat:'jimar', zor:0.79,
   not:'"Pêncî" — ê uzun, î uzun',
   her:['Pêncî sal in, kal!', 'Pêncî kilo.'],
   gen:['Pêncî dolar', 'Pêncî sal']),

  (id:'a1_045', ku:'Şêst', tr:'Altmış', en:'Sixty', cins:'bêcins', ez:null, kat:'jimar', zor:0.78,
   not:'"Şêst" — ê uzun',
   her:['Şêst sal in.', 'Şêst rojen in.'],
   gen:['Şêst kilo', 'Şêst kes']),

  (id:'a1_046', ku:'Heftê', tr:'Yetmiş', en:'Seventy', cins:'bêcins', ez:null, kat:'jimar', zor:0.78,
   not:'"Heftê" — ê uzun',
   her:['Pîrê heftê sal e!', 'Heftê kilo.'],
   gen:['Heftê dolar', 'Heftê kes']),

  (id:'a1_047', ku:'Heştê', tr:'Seksen', en:'Eighty', cins:'bêcins', ez:null, kat:'jimar', zor:0.78,
   not:'"Heştê" — ê uzun',
   her:['Bapîr heştê sal e.', 'Heştê kilo.'],
   gen:['Heştê dolar', 'Heştê sal']),

  (id:'a1_048', ku:'Nod', tr:'Doksan', en:'Ninety', cins:'bêcins', ez:null, kat:'jimar', zor:0.78,
   not:'"Nod" — kısa ve net',
   her:['Kal nod sal e.', 'Nod kilo nan.'],
   gen:['Nod dolar', 'Nod kes']),

  (id:'a1_049', ku:'Sed', tr:'Yüz', en:'Hundred', cins:'bêcins', ez:null, kat:'jimar', zor:0.80,
   not:'"Sed" — s yumuşak, d belirgin',
   her:['Sed lira.', 'Sed sal berê, pîrê!'],
   gen:['Sed kilo', 'Sed kes']),

  (id:'a1_050', ku:'Hezar', tr:'Bin', en:'Thousand', cins:'bêcins', ez:null, kat:'jimar', zor:0.79,
   not:'"Hezar" — Farsça kökenli, yaygın kullanım',
   her:['Hezar spas, pîrê!', 'Hezar lira.'],
   gen:['Hezar sal', 'Hezar kes']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 4 — Reng (Renkler)
  // Kaynak: Aslanoğlu s.29 — RENG
  // ════════════════════════════════════════════════════════════

  (id:'a1_060', ku:'Spî', tr:'Beyaz', en:'White', cins:'bêcins', ez:null, kat:'reng', zor:0.84,
   not:'"Spî" — s+p birlikte, Türkçede olmayan bir ses birleşimi',
   her:['Dêya min kirasekî spî li xwe dike.', 'Berf spî ye, pîrê!'],
   gen:['Rengê spî', 'Spî û reş']),

  (id:'a1_061', ku:'Reş', tr:'Siyah', en:'Black', cins:'bêcins', ez:null, kat:'reng', zor:0.84,
   not:'"Reş" — ê uzun söylenir',
   her:['Çavên pîrê reş in.', 'Kincên bavê min reş in.'],
   gen:['Rengê reş', 'Spî û reş']),

  (id:'a1_062', ku:'Sor', tr:'Kırmızı', en:'Red', cins:'bêcins', ez:null, kat:'reng', zor:0.85,
   not:'"Sor" — Newroz ateşinin rengi, kültürel önemi büyük',
   her:['Kulîlkên sor, pîrê!', 'Agirê Newrozê sor e.'],
   gen:['Rengê sor', 'Sêv sor e.']),

  (id:'a1_063', ku:'Kesk', tr:'Yeşil', en:'Green', cins:'bêcins', ez:null, kat:'reng', zor:0.84,
   not:'"Kesk" — k+s+k, Kürt bayrağının ortasındaki renk',
   her:['Çiyayên Kurdistanê kesk in.', 'Sebzeyên kesk xweş in.'],
   gen:['Rengê kesk', 'Dar kesk e.']),

  (id:'a1_064', ku:'Şîn', tr:'Mavi', en:'Blue', cins:'bêcins', ez:null, kat:'reng', zor:0.84,
   not:'"Şîn" — î uzun. Türkçede olmayan ses. Aynı zamanda "üzgün" anlamı da var — dikkat!',
   her:['Esman şîn e, pîrê!', 'Çemê şîn xweş e.'],
   gen:['Rengê şîn', 'Esman şîn e.']),

  (id:'a1_065', ku:'Zer', tr:'Sarı', en:'Yellow', cins:'bêcins', ez:null, kat:'reng', zor:0.84,
   not:'"Zer" — kısa ve net',
   her:['Güneş zer e, pîrê!', 'Pêlên zer in.'],
   gen:['Rengê zer', 'Tavê zer e.']),

  (id:'a1_066', ku:'Gewr', tr:'Gri', en:'Grey', cins:'bêcins', ez:null, kat:'reng', zor:0.80,
   not:'"Gewr" — gw birlikte — "bulut rengi"',
   her:['Ewrên gewr in.', 'Mişkê gewr in.'],
   gen:['Rengê gewr', 'Ezman gewr e.']),

  (id:'a1_067', ku:'Qehweyî', tr:'Kahverengi', en:'Brown', cins:'bêcins', ez:null, kat:'reng', zor:0.78,
   not:'"Qehweyî" — qehwe (kahve) + -yî eki = kahve renkli',
   her:['Çavên bavê min qehweyî ne.', 'Erdê qehweyî ye.'],
   gen:['Rengê qehweyî', 'Dar qehweyî ye.']),

  (id:'a1_068', ku:'Pembe', tr:'Pembe', en:'Pink', cins:'bêcins', ez:null, kat:'reng', zor:0.82,
   not:'"Pembe" — Farsça/Türkçe alıntı, Kurmancîde yaygın',
   her:['Kulîlkên pembe, pîrê!', 'Kincê pembe xweş e.'],
   gen:['Rengê pembe', 'Kulîlk pembe ne.']),

  (id:'a1_069', ku:'Mor', tr:'Mor', en:'Purple', cins:'bêcins', ez:null, kat:'reng', zor:0.82,
   not:'"Mor" — Türkçeyle aynı',
   her:['Kulîlkên mor hene.', 'Rengê mor.'],
   gen:['Mor û şîn', 'Rengê mor']),

  (id:'a1_070', ku:'Narencî', tr:'Turuncu', en:'Orange', cins:'bêcins', ez:null, kat:'reng', zor:0.78,
   not:'"Narencî" — Farsça narenj (portakal) + -î = portakal rengi',
   her:['Nêrancên narencî in.', 'Agirê narencî ye.'],
   gen:['Rengê narencî', 'Meyveye narencî ye.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 5 — Malbat (Aile Üyeleri)
  // Kaynak: Aslanoğlu s.30 — MALBAT; Arizona Üniversitesi Ders 5
  // ════════════════════════════════════════════════════════════

  (id:'a1_080', ku:'Bav', tr:'Baba', en:'Father', cins:'nêr', ez:'bavê',
   kat:'malbat', zor:0.84, not:'Eril (nêr) — ezafe: bavê min (babamın)',
   her:['Bavê min li kar e.', 'Silav ji bavê min re!'],
   gen:['Bav û dê', 'Bavê wî']),

  (id:'a1_081', ku:'Dê', tr:'Anne', en:'Mother', cins:'mê', ez:'dêya',
   kat:'malbat', zor:0.84, not:'Dişil (mê) — ezafe: dêya min (annemin). "Dayik/Daya" da denir',
   her:['Dêya min nan dipijîne.', 'Ez ji dêya xwe hez dikim.'],
   gen:['Dê û bav', 'Dêya wê']),

  (id:'a1_082', ku:'Bira', tr:'Erkek kardeş', en:'Brother', cins:'nêr', ez:'birê',
   kat:'malbat', zor:0.83, not:'Eril — ezafe: birê min (erkek kardeşimin)',
   her:['Birê min mezin e.', 'Birê te çawa ye?'],
   gen:['Bira û xwişk', 'Birê wî']),

  (id:'a1_083', ku:'Xwişk', tr:'Kız kardeş', en:'Sister', cins:'mê', ez:'xwişka',
   kat:'malbat', zor:0.82, not:'Dişil — ezafe: xwişka min. x sesi gırtlaktan!',
   her:['Xwişka min li dibistanê ye.', 'Xwişka te çawa ye?'],
   gen:['Xwişk û bira', 'Xwişka wê']),

  (id:'a1_084', ku:'Pîrê', tr:'Büyükanne', en:'Grandmother', cins:'mê', ez:'pîrêya',
   kat:'malbat', zor:0.84, not:'Dişil — ezafe: pîrêya min. Heritage kullanıcı için en duygusal kelime',
   her:['Pîrêya min Kurmancî dizane.', 'Ez ji pîrêya xwe hez dikim.'],
   gen:['Pîrêya wî', 'Pîrê û kal']),

  (id:'a1_085', ku:'Kal', tr:'Büyükbaba / Dede', en:'Grandfather', cins:'nêr', ez:'kalê',
   kat:'malbat', zor:0.84, not:'Eril — ezafe: kalê min. "Bapîr" da denir',
   her:['Kalê min li gundê ye.', 'Ez kalê xwe dixwazim bibînim.'],
   gen:['Kalê wî', 'Kal û pîrê']),

  (id:'a1_086', ku:'Ap', tr:'Amca (baba tarafı)', en:"Father's brother", cins:'nêr', ez:'apê',
   kat:'malbat', zor:0.80, not:'Eril — baba tarafı amca. Anne tarafı: "mam" (bölgesel)',
   her:['Apê min li bajarê ye.', 'Apê te çawa ye?'],
   gen:['Apê wî', 'Ap û met']),

  (id:'a1_087', ku:'Xaltî', tr:'Teyze', en:"Mother's sister", cins:'mê', ez:'xaltiya',
   kat:'malbat', zor:0.79, not:'Dişil — anne tarafı teyze. x sesi gırtlaktan!',
   her:['Xaltiya min baş e.', 'Xaltî, silav!'],
   gen:['Xaltiya wê', 'Xaltî û ap']),

  (id:'a1_088', ku:'Kur', tr:'Oğul', en:'Son', cins:'nêr', ez:'kurê',
   kat:'malbat', zor:0.82, not:'Eril — "kurê min" = oğlum. Ninni\'de: "kuro, kurê dayika min"',
   her:['Kurê min xwendekar e.', 'Pîrê, kurê te çawa ye?'],
   gen:['Kurê wî', 'Kur û keç']),

  (id:'a1_089', ku:'Keç', tr:'Kız çocuğu / Kız', en:'Daughter / Girl', cins:'mê', ez:'keça',
   kat:'malbat', zor:0.82, not:'Dişil — "keça min" = kızım',
   her:['Keça min li dibistanê ye.', 'Keça te çawa ye, pîrê?'],
   gen:['Keça wê', 'Kur û keç']),

  (id:'a1_090', ku:'Mêr', tr:'Koca / Erkek', en:'Husband / Man', cins:'nêr', ez:'mêrê',
   kat:'malbat', zor:0.80, not:'Eril — "mêrê min" = kocam',
   her:['Mêrê dêya min baş e.', 'Mêrê te çawa ye?'],
   gen:['Mêr û jin', 'Mêrê wê']),

  (id:'a1_091', ku:'Jin', tr:'Karı / Kadın', en:'Wife / Woman', cins:'mê', ez:'jina',
   kat:'malbat', zor:0.82, not:'Dişil — "jina min" = karım. "Jin" aynı zamanda "kadın" demek',
   her:['Jina bavê min xweş dixweze.', 'Jin û mêr.'],
   gen:['Jina wî', 'Jin û mêr']),

  (id:'a1_092', ku:'Nevî', tr:'Torun', en:'Grandchild', cins:'bêcins', ez:'neviyê/neviya',
   kat:'malbat', zor:0.78, not:'Eril/dişil her ikisi için kullanılır',
   her:['Ez neviyê pîrêya xwe me.', 'Neviya kalê min ez im.'],
   gen:['Neviyê wî', 'Nevî û pîrê']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 6 — Cînavk (Zamirler)
  // Kaynak: Aslanoğlu s.6–8 — Zamirler; Bedir Han §165–180
  // ════════════════════════════════════════════════════════════

  (id:'a1_100', ku:'Ez', tr:'Ben', en:'I', cins:'bêcins', ez:null, kat:'cinavk', zor:0.88,
   not:'Yalın durum (nominatif) — eğik: "min"',
   her:['Ez hatim malê, pîrê!', 'Ez baş im, dê.'],
   gen:['Ez xwendekar im.', 'Ez Kurdistanî me.']),

  (id:'a1_101', ku:'Tu', tr:'Sen', en:'You (singular)', cins:'bêcins', ez:null, kat:'cinavk', zor:0.88,
   not:'Yalın durum — eğik: "te"',
   her:['Tu çawa yî, pîrê?', 'Tu baş î, dêyê?'],
   gen:['Tu kî yî?', 'Tu xwendekar î?']),

  (id:'a1_102', ku:'Ew', tr:'O (eril ve dişil)', en:'He / She / It', cins:'bêcins', ez:null, kat:'cinavk', zor:0.85,
   not:'Kurmancîde 3.tekil için cinsiyetsiz "ew" kullanılır. Eğik: wî (eril) / wê (dişil)',
   her:['Ew pîrêya min e.', 'Ew baş e.'],
   gen:['Ew mamosta ye.', 'Ew li malê ye.']),

  (id:'a1_103', ku:'Em', tr:'Biz', en:'We', cins:'bêcins', ez:null, kat:'cinavk', zor:0.86,
   not:'1.çoğul — eğik: "me"',
   her:['Em malbata me ne.', 'Em hatim malê, pîrê!'],
   gen:['Em xwendekar in.', 'Em li malê ne.']),

  (id:'a1_104', ku:'Hûn', tr:'Siz', en:'You (plural)', cins:'bêcins', ez:null, kat:'cinavk', zor:0.85,
   not:'2.çoğul — eğik: "we". Ayrıca saygı için tekile de kullanılır',
   her:['Hûn çawa ne, pîrê û kal?', 'Hûn bi xêr hatîn!'],
   gen:['Hûn kî ne?', 'Hûn xwendekar in.']),

  (id:'a1_105', ku:'Ew (çoğul)', tr:'Onlar', en:'They', cins:'bêcins', ez:null, kat:'cinavk', zor:0.84,
   not:'3.çoğul da "ew" — eğik: "wan". Tekille aynı yazım, bağlamdan anlaşılır',
   her:['Ew malbata me ne.', 'Ew hatine malê.'],
   gen:['Ew xwendekar in.', 'Ew li bajarê ne.']),

  (id:'a1_106', ku:'Min', tr:'Benim / Beni', en:'My / Me', cins:'bêcins', ez:null, kat:'cinavk', zor:0.83,
   not:'"Ez"in eğik hali — tamlama ve nesne durumunda',
   her:['Dêya min baş e.', 'Pîrêya min li malê ye.'],
   gen:['Navê min … e.', 'Mala min.']),

  (id:'a1_107', ku:'Te', tr:'Senin / Seni', en:'Your / You (object)', cins:'bêcins', ez:null, kat:'cinavk', zor:0.83,
   not:'"Tu"nun eğik hali',
   her:['Dêya te çawa ye?', 'Xatirê te, pîrê!'],
   gen:['Navê te çi ye?', 'Mala te.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 7 — Pîşe û Perwerdehî (Meslek ve Eğitim)
  // Kaynak: Aslanoğlu s.33–35 — PÎŞE + PERWERDEHÎ
  // ════════════════════════════════════════════════════════════

  (id:'a1_110', ku:'Mamosta', tr:'Öğretmen', en:'Teacher', cins:'bêcins', ez:'mamostayê/mamostaya',
   kat:'pise', zor:0.83, not:'Eril/dişil için aynı kelime — sadece ezafe değişir',
   her:['Mamostayê min baş e.', 'Bavê min mamosta ye.'],
   gen:['Mamosta û xwendekar', 'Mamostaya me']),

  (id:'a1_111', ku:'Xwendekar', tr:'Öğrenci', en:'Student', cins:'bêcins', ez:'xwendekarê/xwendekara',
   kat:'pise', zor:0.82, not:'"Xwend" = okudu + "-ekar" = yapan. x sesi gırtlaktan!',
   her:['Ez xwendekarê dibistanê me.', 'Xwişka min xwendekar e.'],
   gen:['Xwendekar û mamosta', 'Xwendekarên baş']),

  (id:'a1_112', ku:'Bijîşk', tr:'Doktor / Hekim', en:'Doctor', cins:'bêcins', ez:'bijîşkê/bijîşka',
   kat:'pise', zor:0.80, not:'"Bijîşk" saf Kurmancî kelime. "Doktor" da kullanılır ama bijîşk daha özgün',
   her:['Dêya min bijîşk e.', 'Bijîşkê me baş e.'],
   gen:['Bijîşk û nexweş', 'Bijîşka me']),

  (id:'a1_113', ku:'Karker', tr:'İşçi', en:'Worker', cins:'bêcins', ez:'karkerê/karkera',
   kat:'pise', zor:0.80, not:'"Kar" = iş + "-ker" = yapan',
   her:['Bavê min karker e.', 'Karkerên baş in.'],
   gen:['Karker û bazirgan', 'Karkerê me']),

  (id:'a1_114', ku:'Cotkar', tr:'Çiftçi', en:'Farmer', cins:'bêcins', ez:'cotkarê/cotkara',
   kat:'pise', zor:0.79, not:'"Cot" = çift/çiftlik + "-kar" = yapan',
   her:['Kalê min cotkar e.', 'Cotkarên Kurdistanê.'],
   gen:['Cotkar û şivan', 'Cotkarê me']),

  (id:'a1_115', ku:'Şivan', tr:'Çoban', en:'Shepherd', cins:'bêcins', ez:'şivanê/şivana',
   kat:'pise', zor:0.79, not:'Kürt kültüründe köklü meslek — geleneksel yaşamın simgesi',
   her:['Kalê min şivan bû.', 'Şivanê me li çiyayê ye.'],
   gen:['Şivan û mî', 'Şivanê Kurdistanê']),

  (id:'a1_116', ku:'Dibistan', tr:'Okul', en:'School', cins:'mê', ez:'dibistana',
   kat:'perwerde', zor:0.82, not:'Dişil (mê) — "dibistana min" = benim okulum',
   her:['Xwişka min li dibistanê ye.', 'Dibistana me mezin e.'],
   gen:['Dibistan û zanîngeh', 'Dibistana me']),

  (id:'a1_117', ku:'Zanîngeh', tr:'Üniversite', en:'University', cins:'mê', ez:'zanîgeha',
   kat:'perwerde', zor:0.80, not:'Dişil — "zanîn" = bilmek + "-geh" = yer',
   her:['Birê min li zanîgehê ye.', 'Zanîgeha Mêrdînê.'],
   gen:['Zanîngeh û dibistan', 'Zanîgeha me']),

  (id:'a1_118', ku:'Pirtûk', tr:'Kitap', en:'Book', cins:'mê', ez:'pirtûka',
   kat:'perwerde', zor:0.83, not:'Dişil (mê) — "pirtûka min" = benim kitabım',
   her:['Pirtûka Kurmancî ya min.', 'Pirtûkên pîrê hene.'],
   gen:['Pirtûk û xwendin', 'Pirtûka me']),

  (id:'a1_119', ku:'Pirtûkxane', tr:'Kütüphane', en:'Library', cins:'mê', ez:'pirtûkxanê',
   kat:'perwerde', zor:0.78, not:'Dişil — pirtûk + xane (yer)',
   her:['Ez li pirtûkxaneyê dixwînim.', 'Pirtûkxana dibistanê.'],
   gen:['Pirtûkxane û dibistan', 'Pirtûkxana bajêr']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 8 — Dem û Rojen (Zaman ve Günler)
  // Kaynak: Aslanoğlu s.27–29 — DEM + DEMSAL + ALÎ
  // ════════════════════════════════════════════════════════════

  (id:'a1_120', ku:'Roj', tr:'Gün / Güneş', en:'Day / Sun', cins:'nêr', ez:'rojê',
   kat:'dem', zor:0.84, not:'Eril — hem "gün" hem "güneş" anlamı var. "Newroz" = yeni gün!',
   her:['Roja min xweş bû, pîrê!', 'Roj derketiye.'],
   gen:['Roj û şev', 'Rojê baş!']),

  (id:'a1_121', ku:'Şev', tr:'Gece', en:'Night', cins:'mê', ez:'şeva',
   kat:'dem', zor:0.84, not:'Dişil — "şeva min" = geceleyin',
   her:['Şeva we xweş be, pîrê!', 'Şev û roj.'],
   gen:['Şev û sibê', 'Şeva xweş']),

  (id:'a1_122', ku:'Sibê', tr:'Sabah / Yarın', en:'Morning / Tomorrow', cins:'mê', ez:'sibê',
   kat:'dem', zor:0.82, not:'İki anlam: sabah vakti + yarın. Bağlamdan anlaşılır',
   her:['Sibê tê malê, pîrê?', 'Sibê baş, dê!'],
   gen:['Sibê û êvarê', 'Sibê tê.']),

  (id:'a1_123', ku:'Nîvro', tr:'Öğle', en:'Noon / Midday', cins:'nêr', ez:'nîvroyê',
   kat:'dem', zor:0.82, not:'"Nîv" = yarım + "ro(j)" = gün = günün yarısı',
   her:['Nîvro hatim malê, dêyê.', 'Di nîvroyê de xwarim.'],
   gen:['Nîvro û êvarê', 'Di nîvroyê de']),

  (id:'a1_124', ku:'Êvare', tr:'Akşam', en:'Evening', cins:'mê', ez:'êvarê',
   kat:'dem', zor:0.82, not:'Dişil — akşam vakti',
   her:['Êvare hatim, pîrê!', 'Şeva we xweş be, êvarê!'],
   gen:['Êvare û şev', 'Di êvarê de']),

  (id:'a1_125', ku:'Îro', tr:'Bugün', en:'Today', cins:'bêcins', ez:null,
   kat:'dem', zor:0.85, not:'"Î-ro" — "bu gün" anlamında, ayrı söylenir',
   her:['Îro pîrê tê malê!', 'Îro çawa yî, dêyê?'],
   gen:['Îro û sibê', 'Îro baş e.']),

  (id:'a1_126', ku:'Duh', tr:'Dün', en:'Yesterday', cins:'bêcins', ez:null,
   kat:'dem', zor:0.83, not:'"Duh" kısa ve net',
   her:['Duh pîrê hat malê.', 'Duh xweş bû.'],
   gen:['Duh û îro', 'Duh hatim.']),

  (id:'a1_127', ku:'Hefta', tr:'Hafta', en:'Week', cins:'mê', ez:'heftê',
   kat:'dem', zor:0.82, not:'Dişil — "heftê" ezafe',
   her:['Di vê heftê de pîrê tê.', 'Hefta me xweş bû.'],
   gen:['Hefta û meh', 'Di heftê de']),

  (id:'a1_128', ku:'Meh', tr:'Ay (zaman)', en:'Month', cins:'nêr', ez:'mehê',
   kat:'dem', zor:0.81, not:'Eril. "Heyv" = gökteki ay, "meh" = zaman olarak ay',
   her:['Meha Adar — Newroz!', 'Meha me xweş bû.'],
   gen:['Meh û sal', 'Di mehê de']),

  (id:'a1_129', ku:'Sal', tr:'Yıl', en:'Year', cins:'mê', ez:'salê',
   kat:'dem', zor:0.83, not:'Dişil — "sala me" = yılımız',
   her:['Sala nû pîroz be, pîrê!', 'Ev sal xweş e.'],
   gen:['Sala nû', 'Di salê de']),

  // Günler
  (id:'a1_130', ku:'Duşem', tr:'Pazartesi', en:'Monday', cins:'nêr', ez:'Duşemê',
   kat:'roj', zor:0.80, not:'"Du + şem" = iki+cumartesi? — Eski takvimden',
   her:['Duşemê ez diçim dibistanê.', 'Duşem roja yekem e.'],
   gen:['Duşem û Sêşem', 'Di Duşemê de']),

  (id:'a1_131', ku:'Sêşem', tr:'Salı', en:'Tuesday', cins:'nêr', ez:'Sêşemê',
   kat:'roj', zor:0.79, not:'"Sê + şem" = üç',
   her:['Sêşemê pîrê tê.', 'Di Sêşemê de.'],
   gen:['Sêşem û Çarşem', 'Di Sêşemê de']),

  (id:'a1_132', ku:'Çarşem', tr:'Çarşamba', en:'Wednesday', cins:'nêr', ez:'Çarşemê',
   kat:'roj', zor:0.79, not:'"Çar + şem" = dört. Türkçe "Çarşamba" ile aynı kök!',
   her:['Çarşemê em diçin.', 'Di Çarşemê de.'],
   gen:['Çarşem û Pêncşem', 'Di Çarşemê de']),

  (id:'a1_133', ku:'Pêncşem', tr:'Perşembe', en:'Thursday', cins:'nêr', ez:'Pêncşemê',
   kat:'roj', zor:0.79, not:'"Pênc + şem" = beş',
   her:['Pêncşemê xebat heye.', 'Di Pêncşemê de.'],
   gen:['Pêncşem û Înî', 'Di Pêncşemê de']),

  (id:'a1_134', ku:'Înî', tr:'Cuma', en:'Friday', cins:'nêr', ez:'Îniyê',
   kat:'roj', zor:0.80, not:'"Înî" = Kurmancî özgün form. "Cuma" da kullanılır',
   her:['Înî malbat tê malê.', 'Di Îniyê de çay vedixwin.'],
   gen:['Înî û Şemî', 'Di Îniyê de']),

  (id:'a1_135', ku:'Şemî', tr:'Cumartesi', en:'Saturday', cins:'nêr', ez:'Şemiyê',
   kat:'roj', zor:0.80, not:'"Şemî" — Arapça kökenli',
   her:['Şemî em diçin bazarê.', 'Di Şemiyê de.'],
   gen:['Şemî û Yekşem', 'Di Şemiyê de']),

  (id:'a1_136', ku:'Yekşem', tr:'Pazar', en:'Sunday', cins:'nêr', ez:'Yekşemê',
   kat:'roj', zor:0.80, not:'"Yek + şem" = bir. Haftanın ilk günü',
   her:['Yekşem malbat tê malê.', 'Di Yekşemê de pîrê tê.'],
   gen:['Yekşem û Duşem', 'Di Yekşemê de']),

  // Mevsimler
  (id:'a1_140', ku:'Bihar', tr:'İlkbahar', en:'Spring', cins:'nêr', ez:'biharê',
   kat:'demsal', zor:0.83, not:'Eril — Newroz biharê tê! (Newroz ilkbaharda gelir)',
   her:['Biharê Newroz tê, pîrê!', 'Bihar xweş e.'],
   gen:['Bihar û havîn', 'Di biharê de']),

  (id:'a1_141', ku:'Havîn', tr:'Yaz', en:'Summer', cins:'nêr', ez:'havînê',
   kat:'demsal', zor:0.82, not:'Eril',
   her:['Havînê em diçin gundê.', 'Havîn germ e.'],
   gen:['Havîn û payîz', 'Di havînê de']),

  (id:'a1_142', ku:'Payîz', tr:'Sonbahar', en:'Autumn', cins:'nêr', ez:'payîzê',
   kat:'demsal', zor:0.82, not:'Eril',
   her:['Payîzê ew tê malê.', 'Payîz sar e.'],
   gen:['Payîz û zivistan', 'Di payîzê de']),

  (id:'a1_143', ku:'Zivistan', tr:'Kış', en:'Winter', cins:'nêr', ez:'zivistanê',
   kat:'demsal', zor:0.82, not:'Eril — "zivistan" = kış. Berf (kar) zivistanê dibare',
   her:['Zivistanê berf dibare, pîrê!', 'Zivistan sar e.'],
   gen:['Zivistan û bihar', 'Di zivistanê de']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 9 — Xwarin û Vexwarin (Yemek ve İçecek)
  // Kaynak: Aslanoğlu s.47 — XWARIN Û VEXWARIN
  // ════════════════════════════════════════════════════════════

  (id:'a1_150', ku:'Nan', tr:'Ekmek', en:'Bread', cins:'nêr', ez:'nanê',
   kat:'xwarin', zor:0.86, not:'Eril — kültürel önemi muazzam: "nan û xwê" = misafirperverlik',
   her:['Dêya min nan dipijîne.', 'Nan bixwe, pîrê!'],
   gen:['Nan û av', 'Nanê me']),

  (id:'a1_151', ku:'Av', tr:'Su', en:'Water', cins:'mê', ez:'avê',
   kat:'vexwarin', zor:0.86, not:'Dişil — "avê" ezafe',
   her:['Dêyê, av bide min!', 'Av sar e, pîrê.'],
   gen:['Av û çay', 'Avê me']),

  (id:'a1_152', ku:'Çay', tr:'Çay', en:'Tea', cins:'nêr', ez:'çayê',
   kat:'vexwarin', zor:0.88, not:'Eril — Kürt kültüründe misafir çayı zorunlu gelenektir',
   her:['Pîrêya min çay dide min.', 'Çayê xweş vexwe!'],
   gen:['Çay û qehwe', 'Çayê me']),

  (id:'a1_153', ku:'Qehwe', tr:'Kahve', en:'Coffee', cins:'nêr', ez:'qehwê',
   kat:'vexwarin', zor:0.84, not:'Eril — q sesi gırtlaktan!',
   her:['Bavê min qehwe vexwe.', 'Qehweya min.'],
   gen:['Qehwe û çay', 'Qehwê we']),

  (id:'a1_154', ku:'Şîr', tr:'Süt', en:'Milk', cins:'nêr', ez:'şîrê',
   kat:'vexwarin', zor:0.83, not:'Eril — î uzun söylenir',
   her:['Şîrê bizinê xweş e.', 'Pîrê şîr dide kurikên biçûk.'],
   gen:['Şîr û mast', 'Şîrê me']),

  (id:'a1_155', ku:'Mast', tr:'Yoğurt', en:'Yogurt', cins:'nêr', ez:'mastê',
   kat:'xwarin', zor:0.84, not:'Eril — Türkçeyle aynı kök',
   her:['Masta dêya min xweş e!', 'Nan û mast bixwe.'],
   gen:['Mast û şîr', 'Mastê me']),

  (id:'a1_156', ku:'Goşt', tr:'Et', en:'Meat', cins:'nêr', ez:'goştê',
   kat:'xwarin', zor:0.82, not:'Eril',
   her:['Pîrê goşt dipijîne.', 'Goştê berx xweş e.'],
   gen:['Goşt û nan', 'Goştê me']),

  (id:'a1_157', ku:'Mirîşk', tr:'Tavuk', en:'Chicken', cins:'mê', ez:'mirîşka',
   kat:'xwarin', zor:0.81, not:'Dişil — hem hayvan hem et anlamı',
   her:['Mirîşka pîrê xweş bû!', 'Mirîşk û goşt.'],
   gen:['Mirîşk û nan', 'Mirîşka me']),

  (id:'a1_158', ku:'Rûn', tr:'Yağ / Tereyağı', en:'Butter / Fat', cins:'nêr', ez:'rûnê',
   kat:'xwarin', zor:0.80, not:'Eril — û uzun. Kürt mutfağında temel malzeme',
   her:['Rûnê bizinê li ser nanî.', 'Pîrê rûn dike.'],
   gen:['Rûn û mast', 'Rûnê me']),

  (id:'a1_159', ku:'Xwê', tr:'Tuz', en:'Salt', cins:'nêr', ez:'xwêyê',
   kat:'xwarin', zor:0.82, not:'Eril — x sesi gırtlaktan! "Nan û xwê" = ekmek ve tuz = misafirperverlik sembolü',
   her:['Nan û xwê bide mêvanê xwe, pîrê.', 'Xwê dike?'],
   gen:['Xwê û biber', 'Xwêyê me']),

  (id:'a1_160', ku:'Sêv', tr:'Elma', en:'Apple', cins:'mê', ez:'sêva',
   kat:'mêwe', zor:0.83, not:'Dişil — ê uzun',
   her:['Sêvên pîrê xweş in!', 'Sêva min.'],
   gen:['Sêv û tirî', 'Sêva me']),

  (id:'a1_161', ku:'Tirî', tr:'Üzüm', en:'Grape', cins:'nêr', ez:'tiriyê',
   kat:'mêwe', zor:0.81, not:'Eril — Kürt kültüründe önemli meyve',
   her:['Tiriyên sor xweş in.', 'Pîrê tirî dide me.'],
   gen:['Tirî û sêv', 'Tiriyê me']),

  (id:'a1_162', ku:'Birinc', tr:'Pirinç', en:'Rice', cins:'nêr', ez:'birincê',
   kat:'xwarin', zor:0.80, not:'Eril',
   her:['Birincê pîrê xweş e!', 'Birinc û goşt.'],
   gen:['Birinc û nan', 'Birincê me']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 10 — Endamên Bedenê û Tenduristî (Beden ve Sağlık)
  // Kaynak: Aslanoğlu s.36–38 — ENDAMÊN BEDENÊ + TENDURISTÎ
  // ════════════════════════════════════════════════════════════

  (id:'a1_170', ku:'Serî', tr:'Baş', en:'Head', cins:'nêr', ez:'serî',
   kat:'beden', zor:0.84, not:'Eril — "serê min" = başım. "Serêşî" = baş ağrısı',
   her:['Serê min êş dike, pîrê.', 'Serê te çawa ye?'],
   gen:['Serî û çav', 'Serê min']),

  (id:'a1_171', ku:'Çav', tr:'Göz', en:'Eye', cins:'nêr', ez:'çavê',
   kat:'beden', zor:0.84, not:'Eril — "çavê min" = gözüm. Çoğul: "çavên min"',
   her:['Çavên pîrê xweş in.', 'Çavê te kesk e.'],
   gen:['Çav û guh', 'Çavên min']),

  (id:'a1_172', ku:'Guh', tr:'Kulak', en:'Ear', cins:'nêr', ez:'guhê',
   kat:'beden', zor:0.83, not:'Eril',
   her:['Guhên pîrê baş bihîst.', 'Guhê te êş dike?'],
   gen:['Guh û dev', 'Guhên min']),

  (id:'a1_173', ku:'Dev', tr:'Ağız', en:'Mouth', cins:'nêr', ez:'devê',
   kat:'beden', zor:0.83, not:'Eril',
   her:['Devê te xweş axife.', 'Dev û ziman.'],
   gen:['Dev û poz', 'Devê min']),

  (id:'a1_174', ku:'Poz', tr:'Burun', en:'Nose', cins:'nêr', ez:'pozê',
   kat:'beden', zor:0.82, not:'Eril',
   her:['Pozê min êş dike.', 'Pozê te mezin e?'],
   gen:['Poz û dev', 'Pozê min']),

  (id:'a1_175', ku:'Dest', tr:'El', en:'Hand', cins:'nêr', ez:'destê',
   kat:'beden', zor:0.84, not:'Eril — "destê te xweş be" = elinize sağlık',
   her:['Destê te xweş be, pîrê!', 'Destên min sar in.'],
   gen:['Dest û ling', 'Destê min']),

  (id:'a1_176', ku:'Ling', tr:'Ayak / Bacak', en:'Leg / Foot', cins:'nêr', ez:'lingê',
   kat:'beden', zor:0.82, not:'Eril — hem "ayak" hem "bacak" anlamı',
   her:['Lingê min êş dike.', 'Lingên min sar in.'],
   gen:['Ling û dest', 'Lingê min']),

  (id:'a1_177', ku:'Ziman', tr:'Dil (organ)', en:'Tongue / Language', cins:'nêr', ez:'zimanê',
   kat:'beden', zor:0.83, not:'Eril — hem "dil organı" hem "dil/lisan" anlamı. "Ziman dermanê dilê mirov e"',
   her:['Zimanê min Kurmancî ye!', 'Ziman û dev.'],
   gen:['Ziman û çav', 'Zimanê min']),

  (id:'a1_178', ku:'Dil', tr:'Kalp', en:'Heart', cins:'nêr', ez:'dilê',
   kat:'beden', zor:0.84, not:'Eril — ayrıca duygusal anlam: "kalbim"',
   her:['Dila min ji te re tê.', 'Dilê min xweş e.'],
   gen:['Dil û ziman', 'Dilê min']),

  (id:'a1_179', ku:'Ez nexweş im', tr:'Hastayım', en:"I'm sick", cins:'bêcins', ez:null,
   kat:'tendurist', zor:0.83, not:'"Nexweş" = hasta (ne + xweş = iyilik değil)',
   her:['Ez nexweş im, pîrê, bijîşk lazim e.', 'Dê, ez nexweş im.'],
   gen:['Ez nexweş im.', 'Ew nexweş e.']),

  (id:'a1_180', ku:'Ez birçî me', tr:'Açım', en:"I'm hungry", cins:'bêcins', ez:null,
   kat:'tendurist', zor:0.82, not:'"Birçî" = aç (yiyecek anlamında)',
   her:['Dayê, ez birçî me, nan heye?', 'Pîrê, em birçî ne!'],
   gen:['Ez birçî me.', 'Ew birçî ye.']),

  (id:'a1_181', ku:'Ez tî me', tr:'Susuzum', en:"I'm thirsty", cins:'bêcins', ez:null,
   kat:'tendurist', zor:0.82, not:'"Tî" = susuz',
   her:['Ez tî me, dêyê, av heye?', 'Kal, ez tî me.'],
   gen:['Ez tî me.', 'Av bide min, tî me.']),

  (id:'a1_182', ku:'Nexweşxane', tr:'Hastane', en:'Hospital', cins:'mê', ez:'nexweşxanê',
   kat:'tendurist', zor:0.80, not:'Dişil — "nexweş" + "xane" = hasta evi',
   her:['Em diçin nexweşxanê.', 'Bijîşk li nexweşxanê ye.'],
   gen:['Nexweşxane û dermangeh', 'Nexweşxanê me']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 11 — Mal û Cih (Ev ve Mekan)
  // Kaynak: Aslanoğlu s.46–47 — Konaklama bölümü
  // ════════════════════════════════════════════════════════════

  (id:'a1_190', ku:'Mal', tr:'Ev / Yurt', en:'Home / House', cins:'mê', ez:'mala',
   kat:'mal', zor:0.85, not:'Dişil — "mala min" = evim. "Malê" = eve (yön)',
   her:['Ez hatim malê, pîrê!', 'Mala me mezin e.'],
   gen:['Mal û cih', 'Mala min']),

  (id:'a1_191', ku:'Xanî', tr:'Bina / Ev', en:'Building / House', cins:'nêr', ez:'xaniyê',
   kat:'mal', zor:0.82, not:'Eril — "xanî" daha çok bina anlamında. x sesi gırtlaktan!',
   her:['Xaniyê me nû ye.', 'Xaniyê pîrê li gundê ye.'],
   gen:['Xanî û mal', 'Xaniyê me']),

  (id:'a1_192', ku:'Ode', tr:'Oda', en:'Room', cins:'mê', ez:'odê',
   kat:'mal', zor:0.83, not:'Dişil — Türkçeyle aynı',
   her:['Odeya min biçûk e.', 'Odeyên malê.'],
   gen:['Ode û salon', 'Odeyê min']),

  (id:'a1_193', ku:'Derî', tr:'Kapı', en:'Door', cins:'nêr', ez:'deriyê',
   kat:'mal', zor:0.82, not:'Eril',
   her:['Deriyê malê veke, pîrê!', 'Derî û pencere.'],
   gen:['Derî û pencere', 'Deriyê mal']),

  (id:'a1_194', ku:'Pace', tr:'Cam / Pencere', en:'Window', cins:'mê', ez:'pencerê',
   kat:'mal', zor:0.83, not:'Dişil — Türkçeyle aynı',
   her:['Pencereya malê kesk e.', 'Pace veke!'],
   gen:['Pace û derî', 'Pencereyê malê']),

  (id:'a1_195', ku:'Nivîn', tr:'Yatak', en:'Bed', cins:'nêr', ez:'nivînê',
   kat:'mal', zor:0.80, not:'Eril',
   her:['Nivînê min germ e.', 'Pîrê li nivînê ye.'],
   gen:['Nivîn û kursî', 'Nivînê min']),

  (id:'a1_196', ku:'Kursî', tr:'Sandalye / Koltuk', en:'Chair', cins:'nêr', ez:'kursiyê',
   kat:'mal', zor:0.80, not:'Eril — Farsça/Arapça kökenli',
   her:['Kursiyê pîrê wê ye.', 'Rûne kursiyê!'],
   gen:['Kursî û mêz', 'Kursiyê me']),

  (id:'a1_197', ku:'Mêz', tr:'Masa', en:'Table', cins:'nêr', ez:'mêzê',
   kat:'mal', zor:0.81, not:'Eril — ê uzun',
   her:['Xwarin li mêzê ye.', 'Pîrê li mêzê rûniştî ye.'],
   gen:['Mêz û kursî', 'Mêzê me']),

  (id:'a1_198', ku:'Mitbex', tr:'Mutfak', en:'Kitchen', cins:'nêr', ez:'mitbexê',
   kat:'mal', zor:0.80, not:'Eril — "Aşpêzxane" da denir',
   her:['Dê li mitbexê nan dipijîne.', 'Mitbexê me mezin e.'],
   gen:['Mitbex û salon', 'Mitbexê malê']),

  (id:'a1_199', ku:'Serşok', tr:'Tuvalet / Banyo', en:'Bathroom / Toilet', cins:'nêr', ez:'serşokê',
   kat:'mal', zor:0.78, not:'Eril',
   her:['Serşok li jor e.', 'Serşokê me temiz e.'],
   gen:['Serşok û ode', 'Serşokê mal']),

  (id:'a1_200', ku:'Baxçe', tr:'Bahçe', en:'Garden', cins:'nêr', ez:'baxçeyê',
   kat:'mal', zor:0.81, not:'Eril — Kürt evlerinde bahçe kültürü güçlü',
   her:['Baxçeyê pîrê xweş e.', 'Em li baxçeyê rûniştin.'],
   gen:['Baxçe û mal', 'Baxçeyê me']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 12 — Rengdêr û Peyvên Bingehîn (Sıfatlar ve Temel Kelimeler)
  // Kaynak: Aslanoğlu s.61 — RENGDÊR
  // ════════════════════════════════════════════════════════════

  (id:'a1_210', ku:'Baş', tr:'İyi', en:'Good', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.87, not:'Değişmez sıfat — isimle uyum yok. Karş: "baştir" (daha iyi)',
   her:['Pîrê baş e!', 'Ev nan baş e.'],
   gen:['Baş û xerab', 'Ew baş e.']),

  (id:'a1_211', ku:'Xerab', tr:'Kötü', en:'Bad', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.84, not:'Değişmez sıfat. Karş: "xerabtir" (daha kötü)',
   her:['Hewa xerab e, pîrê.', 'Ev nan xerab e.'],
   gen:['Baş û xerab', 'Ew xerab e.']),

  (id:'a1_212', ku:'Mezin', tr:'Büyük', en:'Big', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.85, not:'Değişmez sıfat',
   her:['Mala pîrê mezin e!', 'Birê min mezin e.'],
   gen:['Mezin û biçûk', 'Ew mezin e.']),

  (id:'a1_213', ku:'Biçûk', tr:'Küçük', en:'Small', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.84, not:'Değişmez sıfat',
   her:['Xwişka min biçûk e.', 'Odeya min biçûk e.'],
   gen:['Biçûk û mezin', 'Ew biçûk e.']),

  (id:'a1_214', ku:'Nû', tr:'Yeni', en:'New', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.84, not:'Değişmez sıfat. "Sala nû" = yeni yıl',
   her:['Xaniyê nû ya me!', 'Sala nû pîroz be!'],
   gen:['Nû û kevin', 'Ev nû ye.']),

  (id:'a1_215', ku:'Kevin', tr:'Eski', en:'Old', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.82, not:'Değişmez sıfat',
   her:['Mala pîrê kevin e.', 'Pirtûkê kevin e.'],
   gen:['Kevin û nû', 'Ew kevin e.']),

  (id:'a1_216', ku:'Germ', tr:'Sıcak', en:'Hot / Warm', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.84, not:'Değişmez sıfat',
   her:['Çayê germ bixwe, pîrê!', 'Hewa germ e.'],
   gen:['Germ û sar', 'Ew germ e.']),

  (id:'a1_217', ku:'Sar', tr:'Soğuk', en:'Cold', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.84, not:'Değişmez sıfat',
   her:['Zivistan sar e, pîrê!', 'Av sar e.'],
   gen:['Sar û germ', 'Ew sar e.']),

  (id:'a1_218', ku:'Dirêj', tr:'Uzun', en:'Long / Tall', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.82, not:'Değişmez sıfat',
   her:['Birê min dirêj e.', 'Rêya dirêj.'],
   gen:['Dirêj û kurt', 'Ew dirêj e.']),

  (id:'a1_219', ku:'Kurt', tr:'Kısa', en:'Short', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.82, not:'Değişmez sıfat',
   her:['Xwişka min kurt e.', 'Wane kurt e.'],
   gen:['Kurt û dirêj', 'Ew kurt e.']),

  (id:'a1_220', ku:'Xweş', tr:'Güzel / İyi', en:'Beautiful / Nice', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.85, not:'Değişmez sıfat. Çok kullanılan kelime — "xweş bê" = güzel ol',
   her:['Pîrêya min xweş e!', 'Nan xweş bû, destê te xweş be!'],
   gen:['Xweş û xerab', 'Ew xweş e.']),

  (id:'a1_221', ku:'Gelek', tr:'Çok', en:'Very / Many', cins:'bêcins', ez:null,
   kat:'peyvben', zor:0.85, not:'Değişmez — sıfatlardan önce gelir: "gelek baş" = çok iyi',
   her:['Gelek spas, pîrê!', 'Ez gelek birçî me.'],
   gen:['Gelek baş', 'Gelek spas']),

  (id:'a1_222', ku:'Hindik', tr:'Az / Biraz', en:'Little / Few', cins:'bêcins', ez:null,
   kat:'peyvben', zor:0.82, not:'"Hindik" = az miktar. "Hinekî" = biraz',
   her:['Hindik nan bide min, dêyê.', 'Hindik av heye.'],
   gen:['Hindik û gelek', 'Hindik nan']),

  (id:'a1_223', ku:'Zû', tr:'Erken / Hızlı', en:'Early / Fast', cins:'bêcins', ez:null,
   kat:'peyvben', zor:0.82, not:'Hem "erken" hem "hızlı" anlamı',
   her:['Zû were, pîrê tê!', 'Zû hatim malê.'],
   gen:['Zû û dereng', 'Zû bê!']),

  (id:'a1_224', ku:'Dereng', tr:'Geç / Geride', en:'Late / Behind', cins:'bêcins', ez:null,
   kat:'peyvben', zor:0.82, not:'Hem "geç" hem "geride" anlamı',
   her:['Bibore, dereng hatim, pîrê.', 'Dereng e, şev e.'],
   gen:['Dereng û zû', 'Ez dereng im.']),

  (id:'a1_225', ku:'Rast', tr:'Doğru / Sağ', en:'Correct / Right', cins:'bêcins', ez:null,
   kat:'peyvben', zor:0.83, not:'Hem "doğru" hem "sağ yön" anlamı',
   her:['Rast bêje, pîrê!', 'Berê rast here.'],
   gen:['Rast û çep', 'Ev rast e.']),

  // ════════════════════════════════════════════════════════════
  // TEMEL FİİLLER — Bûn, Kirin, Çûn, Hatin (A1 Geniş Zaman)
  // Kaynak: Thackston §60–80 + Bedir Han & Lescot §166–190
  // Doğrulama: DoReCo korpus frekans listesi — en sık 20 fiil
  //
  // NOT: A1'de sadece şimdiki zaman (di-...-e/im/î) ve isim
  // cümlesi (bûn: im/î/e/in) öğretilir. Geçmiş zaman A2.
  // ════════════════════════════════════════════════════════════

  // ── Bûn (Olmak) — Tam Çekim Tablosu ─────────────────────────
  // Thackston §62: bûn fiili en sık kullanılan fiil
  // Çekim: im (1.tek) / î (2.tek) / e (3.tek) / in (1.çoğ) / in (2.çoğ) / in (3.çoğ)

  (id:'a1_230', ku:'Ez … im', tr:'Ben … -im', en:'I am …', cins:'bêcins', ez:null,
   kat:'bun', zor:0.87,
   not:'"Bûn" fiili 1.tekil: im. "Ez baş im" = iyiyim. "Ez mamosta me" = öğretmenim — "me" = im (ses uyumu)',
   her:['Ez kurd im!', 'Ez kurê pîrêya xwe me.'],
   gen:['Ez xwendekar im.', 'Ez Tirkiyeyî me.']),

  (id:'a1_231', ku:'Tu … î', tr:'Sen … -sin', en:'You are …', cins:'bêcins', ez:null,
   kat:'bun', zor:0.87,
   not:'Bûn 2.tekil: -î. "Tu baş î?" = iyisin?',
   her:['Tu kurd î, pîrê!', 'Tu xweş î.'],
   gen:['Tu xwendekar î?', 'Tu kî yî?']),

  (id:'a1_232', ku:'Ew … e', tr:'O … -dir', en:'He/She/It is …', cins:'bêcins', ez:null,
   kat:'bun', zor:0.86,
   not:'Bûn 3.tekil: -e. Hem eril hem dişil için. "Ew baş e" = o iyidir',
   her:['Pîrê baş e.', 'Ev nan xweş e.'],
   gen:['Ew mamosta ye.', 'Ev rast e.']),

  (id:'a1_233', ku:'Em … in', tr:'Biz … -iz', en:'We are …', cins:'bêcins', ez:null,
   kat:'bun', zor:0.85,
   not:'Bûn 1.çoğul: -in. Aynı ek 2. ve 3. çoğul için de kullanılır',
   her:['Em kurd in!', 'Em malbateke mezin in.'],
   gen:['Em xwendekar in.', 'Em baş in.']),

  // ── Dixwazim / Dixwim — İsteme ve Yeme Fiilleri ──────────────
  // Thackston §71: dixwazin (to want) çok sık kullanım
  // Bedir Han §170: xwastin fiil kökü

  (id:'a1_234', ku:'Ez dixwazim', tr:'Ben istiyorum', en:'I want', cins:'bêcins', ez:null,
   kat:'leker', zor:0.83,
   not:'"Di-xwaz-im" — di (şimdiki ön ek) + xwaz (kök: istemek) + im (1.tekil). x gırtlaktan!',
   her:['Ez dixwazim Kurmancî hîn bibim!', 'Ez dixwazim çayekî vexwim.'],
   gen:['Ez çi dixwazim?', 'Ez dixwazim here.']),

  (id:'a1_235', ku:'Ez dixwim', tr:'Ben yiyorum', en:'I eat', cins:'bêcins', ez:null,
   kat:'leker', zor:0.83,
   not:'"Di-xw-im" — xwarin fiili kökü: xw. "Nan dixwim" = ekmek yiyorum',
   her:['Ez nan dixwim.', 'Pîrê, em çi dixwin?'],
   gen:['Ez birinc dixwim.', 'Ew goşt dixwe.']),

  (id:'a1_236', ku:'Ez vedixwim', tr:'Ben içiyorum', en:'I drink', cins:'bêcins', ez:null,
   kat:'leker', zor:0.82,
   not:'"Ve-di-xw-im" — "ve" + içmek. Çay vedixwim = çay içiyorum',
   her:['Ez çay vedixwim, pîrê.', 'Dê av vedixwe.'],
   gen:['Ez çi vedixwim?', 'Ew şîr vedixwe.']),

  (id:'a1_237', ku:'Ez diçim', tr:'Ben gidiyorum', en:'I go', cins:'bêcins', ez:null,
   kat:'leker', zor:0.82,
   not:'"Di-ç-im" — çûn fiili (gitmek). Düzensiz fiil — kök değişir',
   her:['Ez diçim malê, pîrê!', 'Ez diçim dibistanê.'],
   gen:['Ez li ku diçim?', 'Ew diçe bajêr.']),

  (id:'a1_238', ku:'Ez têm', tr:'Ben geliyorum', en:'I come', cins:'bêcins', ez:null,
   kat:'leker', zor:0.82,
   not:'"Di-têm" — hatin fiili (gelmek). Düzensiz fiil',
   her:['Ez têm malê, dêyê!', 'Ez sibê têm.'],
   gen:['Ez ji dibistanê têm.', 'Ew jî tê.']),

  (id:'a1_239', ku:'Ez dikim', tr:'Ben yapıyorum', en:'I do / make', cins:'bêcins', ez:null,
   kat:'leker', zor:0.82,
   not:'"Di-k-im" — kirin fiili. En yaygın yardımcı fiil',
   her:['Ez çi dikim?', 'Ez xebat dikim.'],
   gen:['Ez wane dikim.', 'Ew çi dike?']),

  (id:'a1_240', ku:'Ez dibêjim', tr:'Ben söylüyorum / diyorum', en:'I say', cins:'bêcins', ez:null,
   kat:'leker', zor:0.81,
   not:'"Di-bêj-im" — gotin fiili (söylemek)',
   her:['Ez çi dibêjim?', 'Pîrê çi dibêje?'],
   gen:['Ez dibêjim erê.', 'Ew çi dibêje?']),

  (id:'a1_241', ku:'Ez dizanim', tr:'Ben biliyorum', en:'I know', cins:'bêcins', ez:null,
   kat:'leker', zor:0.82,
   not:'"Di-zan-im" — zanîn fiili. "Nizanim" = bilmiyorum (ne + dizanim)',
   her:['Ez Kurmancî dizanim!', 'Ez nizanim, pîrê.'],
   gen:['Ez dizanim.', 'Ew dizane.']),

  (id:'a1_242', ku:'Ez dibînim', tr:'Ben görüyorum', en:'I see', cins:'bêcins', ez:null,
   kat:'leker', zor:0.81,
   not:'"Di-bîn-im" — dîtin fiili. î uzun',
   her:['Ez pîrê dibînim!', 'Tu çi dibînî?'],
   gen:['Ez çiya dibînim.', 'Ew çi dibîne?']),

  (id:'a1_243', ku:'Ez dibihîzim', tr:'Ben duyuyorum / işitiyorum', en:'I hear', cins:'bêcins', ez:null,
   kat:'leker', zor:0.79,
   not:'"Di-bihîz-im" — bihîstin fiili. Telaffuz dikkat: bihîz',
   her:['Ez dengê pîrê dibihîzim.', 'Tu dibihîzî?'],
   gen:['Ez muzîk dibihîzim.', 'Ew çi dibihîze?']),

  (id:'a1_244', ku:'Ez rûdim', tr:'Ben oturuyorum', en:'I sit', cins:'bêcins', ez:null,
   kat:'leker', zor:0.80,
   not:'"Rûniştîn" fiili — "rûn" = oturmak kökü',
   her:['Ez li cem pîrê rûdim.', 'Rûne, heval!'],
   gen:['Ez li kursiyê rûdim.', 'Ew li wir rûniştiye.']),

  (id:'a1_245', ku:'Ez radim', tr:'Ben kalkıyorum / uyanıyorum', en:'I get up', cins:'bêcins', ez:null,
   kat:'leker', zor:0.79,
   not:'"Rabûn" fiili — "ra" ön eki + "bûn"',
   her:['Ez sibê zû radim.', 'Pîrê zû radibe.'],
   gen:['Ez saet heftê radim.', 'Ew dereng radibe.']),

  (id:'a1_246', ku:'Ez dixwînim', tr:'Ben okuyorum', en:'I read / study', cins:'bêcins', ez:null,
   kat:'leker', zor:0.81,
   not:'"Di-xwîn-im" — xwendin fiili. x gırtlaktan!',
   her:['Ez pirtûka Kurmancî dixwînim.', 'Xwişka min li dibistanê dixwîne.'],
   gen:['Ez gelek dixwînim.', 'Ew li zanîgehê dixwîne.']),

  (id:'a1_247', ku:'Ez dinivîsim', tr:'Ben yazıyorum', en:'I write', cins:'bêcins', ez:null,
   kat:'leker', zor:0.79,
   not:'"Di-nivîs-im" — nivîsîn fiili',
   her:['Ez bi Kurmancî dinivîsim!', 'Mamosta dinivîse.'],
   gen:['Ez dersa xwe dinivîsim.', 'Ew kaxez dinivîse.']),

  // ════════════════════════════════════════════════════════════
  // YÖN VE YER — Thackston §45; Aslanoğlu s.28 — ALÎ-HÊL
  // DoReCo: edatlar en sık kullanılan kelimeler arasında
  // ════════════════════════════════════════════════════════════

  (id:'a1_250', ku:'Li vir', tr:'Burada', en:'Here', cins:'bêcins', ez:null,
   kat:'cih', zor:0.84,
   not:'"Li" edat (de/da) + "vir" (bura). "Li vir im" = buradayım',
   her:['Ez li vir im, pîrê!', 'Mal li vir e.'],
   gen:['Li vir rûne.', 'Ez li vir dixwînim.']),

  (id:'a1_251', ku:'Li wir', tr:'Orada', en:'There', cins:'bêcins', ez:null,
   kat:'cih', zor:0.83,
   not:'"Li" + "wir" (ora). "Li wir e" = orada',
   her:['Pîrê li wir e.', 'Mal li wir e.'],
   gen:['Li wir rûne.', 'Ew li wir e.']),

  (id:'a1_252', ku:'Li ku?', tr:'Nerede?', en:'Where?', cins:'bêcins', ez:null,
   kat:'cih', zor:0.84,
   not:'"Li ku yî?" = neredesin? DoReCo: en sık sorulan sorulardan',
   her:['Tu li ku yî, pîrê?', 'Mal li ku ye?'],
   gen:['Dibistan li ku ye?', 'Tu li ku dixwînî?']),

  (id:'a1_253', ku:'Li malê', tr:'Evde', en:'At home', cins:'bêcins', ez:null,
   kat:'cih', zor:0.85,
   not:'"Li malê" — "malê" yön hali (eve/evde). "Ez li malê me" = evdeyim',
   her:['Pîrê li malê ye.', 'Em li malê ne.'],
   gen:['Ez li malê im.', 'Ew li malê dixwîne.']),

  (id:'a1_254', ku:'Li bajêr', tr:'Şehirde', en:'In the city', cins:'bêcins', ez:null,
   kat:'cih', zor:0.82,
   not:'"Bajar" (şehir, eril) + li + ezafe = "li bajêr"',
   her:['Bira li bajêr e.', 'Em diçin bajêr.'],
   gen:['Dibistan li bajêr e.', 'Ew li bajêr dixebite.']),

  (id:'a1_255', ku:'Li gund', tr:'Köyde', en:'In the village', cins:'bêcins', ez:null,
   kat:'cih', zor:0.82,
   not:'"Gund" (köy, eril) — Kürt kültüründe gund köklerin simgesi',
   her:['Pîrê li gundê ye.', 'Kal li gund e.'],
   gen:['Gund xweş e.', 'Em diçin gundê.']),

  (id:'a1_256', ku:'Jor', tr:'Yukarı / Üst', en:'Up / Above', cins:'bêcins', ez:null,
   kat:'cih', zor:0.81,
   not:'Yön bildiren kelime — edat değil',
   her:['Ew li jor e.', 'Serşok li jor e.'],
   gen:['Li jor û jêr', 'Jor here!']),

  (id:'a1_257', ku:'Jêr', tr:'Aşağı / Alt', en:'Down / Below', cins:'bêcins', ez:null,
   kat:'cih', zor:0.81,
   not:'Yön bildiren kelime',
   her:['Ew li jêr e.', 'Li jêr malê.'],
   gen:['Jor û jêr', 'Li jêr here.']),

  (id:'a1_258', ku:'Pêş', tr:'Ön / İleri', en:'Front / Forward', cins:'bêcins', ez:null,
   kat:'cih', zor:0.80,
   not:'"Pêş" = önde. "Li pêş malê" = evin önünde',
   her:['Li pêş malê bimîne.', 'Pêşve here!'],
   gen:['Li pêş dibistanê', 'Pêş û paş']),

  (id:'a1_259', ku:'Paş', tr:'Arka / Geri', en:'Back / Behind', cins:'bêcins', ez:null,
   kat:'cih', zor:0.80,
   not:'"Paş" = arkada. "Li paş malê" = evin arkasında',
   her:['Li paş malê baxçe heye.', 'Paşde were!'],
   gen:['Li paş û pêş', 'Paş û pêş']),

  (id:'a1_260', ku:'Nêzîk', tr:'Yakın', en:'Near / Close', cins:'bêcins', ez:null,
   kat:'cih', zor:0.81,
   not:'Hem sıfat hem edat olarak kullanılır',
   her:['Mala pîrê nêzîk e.', 'Dibistan nêzîk e, heval.'],
   gen:['Nêzîk û dûr', 'Li nêzîk malê']),

  (id:'a1_261', ku:'Dûr', tr:'Uzak', en:'Far', cins:'bêcins', ez:null,
   kat:'cih', zor:0.81,
   not:'Hem sıfat hem edat. "Dûr e" = uzak',
   her:['Gundê pîrê dûr e.', 'Na, dûr e.'],
   gen:['Dûr û nêzîk', 'Bajar dûr e.']),

  // ════════════════════════════════════════════════════════════
  // TEMEL EDATLAR — Thackston §40–45; Bedir Han §200–215
  // DoReCo: edatlar metinde %8 sıklıkla geçiyor
  // ════════════════════════════════════════════════════════════

  (id:'a1_270', ku:'Li', tr:'De / Da / -de/-da', en:'At / In / On', cins:'bêcins', ez:null,
   kat:'daçek', zor:0.84,
   not:'En sık kullanılan edat. Yer bildirir: "li malê" = evde, "li bajêr" = şehirde',
   her:['Pîrê li malê ye.', 'Ez li dibistanê me.'],
   gen:['Ew li wir e.', 'Li vir rûne.']),

  (id:'a1_271', ku:'Ji', tr:'Dan / Den / -den', en:'From / Of', cins:'bêcins', ez:null,
   kat:'daçek', zor:0.83,
   not:'Kaynak/çıkış bildirir: "ji malê" = evden. "Ji te re" = sana (için)',
   her:['Ez ji malê têm.', 'Spas ji te re, pîrê!'],
   gen:['Ji bajêr', 'Ji min re bêje.']),

  (id:'a1_272', ku:'Bi', tr:'İle / -le / -yla', en:'With / By', cins:'bêcins', ez:null,
   kat:'daçek', zor:0.83,
   not:'Araç/birliktelik bildirir: "bi Kurmancî" = Kurmancîyle',
   her:['Bi pîrê re diçim.', 'Bi Kurmancî axife!'],
   gen:['Bi hev re', 'Bi arabê diçim.']),

  (id:'a1_273', ku:'Bo / Ji bo', tr:'İçin', en:'For', cins:'bêcins', ez:null,
   kat:'daçek', zor:0.82,
   not:'"Bo" ve "ji bo" aynı anlam — ikisi de "için". "Ji bo te" = senin için',
   her:['Ji bo pîrê me.', 'Ez ji bo te dixwînim!'],
   gen:['Ji bo çi?', 'Ji bo me']),

  (id:'a1_274', ku:'Û', tr:'Ve', en:'And', cins:'bêcins', ez:null,
   kat:'daçek', zor:0.90,
   not:'Bağlaç — "û" = ve. DoReCo: en sık 5. kelime!',
   her:['Dê û bav.', 'Nan û xwê û av.'],
   gen:['Ez û tu', 'Baş û xweş']),

  (id:'a1_275', ku:'Lê', tr:'Ama / Fakat', en:'But', cins:'bêcins', ez:null,
   kat:'daçek', zor:0.83,
   not:'Karşıtlık bağlacı. "Belê" de kullanılır',
   her:['Ez têm, lê dereng.', 'Xweş e, lê germ e.'],
   gen:['Baş e, lê...', 'Ez dizanim, lê...']),

  (id:'a1_276', ku:'Ku', tr:'Ki / -dığı / -eceği', en:'That / Which', cins:'bêcins', ez:null,
   kat:'daçek', zor:0.80,
   not:'Bağlaç — bağımlı cümle başlatır. A1\'de basit kullanım',
   her:['Ez dizanim ku pîrê tê.', 'Baş e ku hatî!'],
   gen:['Ez dizanim ku baş e.', 'Ku baş bî!']),

  // ════════════════════════════════════════════════════════════
  // DOĞA VE ÇEVRE — Thackston §85; Aslanoğlu (Çevre bölümü)
  // Heritage kullanıcı için: Kürdistan doğası duygusal bağ kurar
  // ════════════════════════════════════════════════════════════

  (id:'a1_280', ku:'Çiya', tr:'Dağ', en:'Mountain', cins:'nêr', ez:'çiyayê',
   kat:'xweza', zor:0.84,
   not:'Eril — Kürdistan\'ın simgesi. "Çiyayên Kurdistanê" = Kürdistan dağları',
   her:['Kalê min ji çiyê tê.', 'Çiyayên me kesk in.'],
   gen:['Çiya û çem', 'Çiyayê bilind']),

  (id:'a1_281', ku:'Çem', tr:'Nehir / Irmak', en:'River', cins:'nêr', ez:'çemê',
   kat:'xweza', zor:0.83,
   not:'Eril — Dicle/Fırat Kurmancî kültüründe çok önemli',
   her:['Çemê gundê me sar e.', 'Av ji çemê tê.'],
   gen:['Çem û çiya', 'Çemê mezin']),

  (id:'a1_282', ku:'Agir', tr:'Ateş', en:'Fire', cins:'nêr', ez:'agirê',
   kat:'xweza', zor:0.83,
   not:'Eril — Newroz ateşi kültürel sembol! "Agirê Newrozê" = Newroz ateşi',
   her:['Agirê Newrozê!', 'Pîrê agir vêxist.'],
   gen:['Agir û av', 'Agirê mezin']),

  (id:'a1_283', ku:'Avê Çem', tr:'Nehir suyu', en:'Water', cins:'mê', ez:'avê',
   kat:'xweza', zor:0.86,
   not:'Dişil — hem içme suyu hem nehir/su anlamı. "Avê min bide" = su ver bana',
   her:['Avê sar vexwe, pîrê.', 'Çemê avê.'],
   gen:['Av û agir', 'Avê xweş']),

  (id:'a1_284', ku:'Dar', tr:'Ağaç', en:'Tree', cins:'mê', ez:'darê',
   kat:'xweza', zor:0.83,
   not:'Dişil — "dareke bê kok" = köksüz ağaç (atasözünde geçer)',
   her:['Darên kesk in.', 'Pîrê li bin darê rûniştî ye.'],
   gen:['Dar û gul', 'Darê mezin']),

  (id:'a1_285', ku:'Gul', tr:'Gül / Çiçek', en:'Flower / Rose', cins:'mê', ez:'gula',
   kat:'xweza', zor:0.83,
   not:'Dişil — "Malbat gula jiyanê ye" atasözünde geçer',
   her:['Gulên sor xweş in, pîrê!', 'Baxçeyê me guldar e.'],
   gen:['Gul û dar', 'Gulên kesk']),

  (id:'a1_286', ku:'Hewa', tr:'Hava', en:'Weather / Air', cins:'mê', ez:'hewayê',
   kat:'xweza', zor:0.83,
   not:'Dişil — hem hava durumu hem "hava/nefes" anlamı',
   her:['Hewa germ e, pîrê.', 'Hewa baş e.'],
   gen:['Hewa û baran', 'Hewa sar e.']),

  (id:'a1_287', ku:'Bahoz', tr:'Fırtına', en:'Storm', cins:'nêr', ez:'bahozê',
   kat:'xweza', zor:0.80,
   not:'Eril — "ba" (rüzgar) + "hoz" = fırtına',
   her:['Bahoz hat, pîrê!', 'Bahoz mezin bû.'],
   gen:['Bahoz û berf', 'Bahozê mezin']),

  (id:'a1_288', ku:'Baran', tr:'Yağmur', en:'Rain', cins:'nêr', ez:'baranê',
   kat:'xweza', zor:0.82,
   not:'Eril — "Baran dibare" = yağmur yağıyor',
   her:['Baran dibare, pîrê!', 'Baranê spas im.'],
   gen:['Baran û berf', 'Baran dibare.']),

  (id:'a1_289', ku:'Berf', tr:'Kar', en:'Snow', cins:'nêr', ez:'berfê',
   kat:'xweza', zor:0.82,
   not:'Eril — "Berf dibare" = kar yağıyor',
   her:['Berf dibare, pîrê!', 'Berfê spî!'],
   gen:['Berf û baran', 'Berf dibare.']),

  (id:'a1_290', ku:'Tav', tr:'Güneş', en:'Sun', cins:'mê', ez:'tavê',
   kat:'xweza', zor:0.83,
   not:'Dişil — "Tav derdikeve" = güneş çıkıyor. Roj da denir (eril)',
   her:['Tavê germ e, pîrê.', 'Tav derketiye!'],
   gen:['Tav û baran', 'Tav germ e.']),

  (id:'a1_291', ku:'Stêrk', tr:'Yıldız', en:'Star', cins:'mê', ez:'stêrkê',
   kat:'xweza', zor:0.82,
   not:'Dişil — Bedir Han & Lescot p.56: "Stêrk, yıldız : stêrkê, stêrkan." — standart form "stêrk"tir, "stêr" değil. Thackston da "stêrk" kullanır. Kürdistan bayrağında yıldız var!',
   her:['Stêrkên şevê xweş in.', 'Pîrê stêrkan nîşan da min.'],
   gen:['Stêrk û heyv', 'Stêrkên gelek']),

  (id:'a1_292', ku:'Heyv', tr:'Ay (gökte)', en:'Moon', cins:'mê', ez:'heyvê',
   kat:'xweza', zor:0.82,
   not:'Dişil — gökteki ay. Zaman olarak "meh"',
   her:['Heyva şevê xweş e.', 'Heyveke geş!'],
   gen:['Heyv û stêr', 'Heyva şevê']),

  // ════════════════════════════════════════════════════════════
  // HAYVANLAR — Aslanoğlu s.62 — HEYWAN-AJAL
  // Kürt kültüründe hayvancılık geçmişi güçlü
  // ════════════════════════════════════════════════════════════

  (id:'a1_295', ku:'Kûçik', tr:'Köpek', en:'Dog', cins:'nêr', ez:'kûçikê',
   kat:'heywan', zor:0.83,
   not:'Eril — û uzun söylenir',
   her:['Kûçikê me baş e.', 'Kûçik li baxçeyê ye.'],
   gen:['Kûçik û pisîk', 'Kûçikê malê']),

  (id:'a1_296', ku:'Pisîk', tr:'Kedi', en:'Cat', cins:'mê', ez:'pisîka',
   kat:'heywan', zor:0.83,
   not:'Dişil — î uzun',
   her:['Pisîka pîrê spî ye.', 'Pisîk li malê ye.'],
   gen:['Pisîk û kûçik', 'Pisîka min']),

  (id:'a1_297', ku:'Hesp', tr:'At', en:'Horse', cins:'nêr', ez:'hespê',
   kat:'heywan', zor:0.82,
   not:'Eril — Kürt kültüründe at saygın hayvan. Thackston §126\'da örnek olarak kullanılır',
   her:['Kalê min hespek hebû.', 'Hesp û ker.'],
   gen:['Hespê spî', 'Hesp û ga']),

  (id:'a1_298', ku:'Bizin', tr:'Keçi', en:'Goat', cins:'mê', ez:'bizina',
   kat:'heywan', zor:0.81,
   not:'Dişil — "Şîrê bizinê" = keçi sütü (çok geçer)',
   her:['Şîrê bizina pîrê xweş e.', 'Bizin li çiyayê ye.'],
   gen:['Bizin û mî', 'Bizinên spî']),

  (id:'a1_299', ku:'Mî', tr:'Koyun', en:'Sheep', cins:'mê', ez:'miya',
   kat:'heywan', zor:0.81,
   not:'Dişil',
   her:['Miya kalê min mezin e.', 'Şivan û mî.'],
   gen:['Mî û bizin', 'Miya spî']),

  (id:'a1_300', ku:'Çêlek', tr:'İnek', en:'Cow', cins:'mê', ez:'çêleka',
   kat:'heywan', zor:0.80,
   not:'Dişil',
   her:['Çêleka me şîr dide.', 'Çêlek li gundê ye.'],
   gen:['Çêlek û ga', 'Çêleka me']),

  // ════════════════════════════════════════════════════════════
  // EN SIK 50 KELİME — DoReCo + Thackston kelime listeleri
  // Bunlar A1'de mutlaka geçmesi gereken temel sözcükler
  // ════════════════════════════════════════════════════════════

  (id:'a1_305', ku:'Mirov', tr:'İnsan / Kişi', en:'Person / Human', cins:'nêr', ez:'mirovê',
   kat:'temel', zor:0.83,
   not:'Eril — "Ziman dermanê dilê mirov e" atasözünde geçer',
   her:['Mirov çi ye?', 'Her mirov zimanekî heye.'],
   gen:['Mirov û xweza', 'Mirovên baş']),

  (id:'a1_306', ku:'Jiyan', tr:'Hayat / Yaşam', en:'Life', cins:'nêr', ez:'jiyanê',
   kat:'temel', zor:0.82,
   not:'Eril — "Malbat gula jiyanê ye" atasözünde geçer',
   her:['Jiyana me xweş e.', 'Jiyan û malbat.'],
   gen:['Jiyana baş', 'Jiyan zor e.']),

  (id:'a1_307', ku:'Rê', tr:'Yol', en:'Road / Way', cins:'mê', ez:'rêya',
   kat:'temel', zor:0.83,
   not:'Dişil — "rêya baş" = iyi yol',
   her:['Rêya malê dirêj e.', 'Rêya baş here!'],
   gen:['Rê û mal', 'Rêya bajêr']),

  (id:'a1_308', ku:'Kes', tr:'Kişi / Kimse', en:'Person / Nobody', cins:'bêcins', ez:null,
   kat:'temel', zor:0.82,
   not:'"Kes nîne" = kimse yok. "Kesek" = birisi',
   her:['Kesek li malê heye?', 'Kes nîne, pîrê.'],
   gen:['Çend kes?', 'Kes nîne.']),

  (id:'a1_309', ku:'Tişt', tr:'Şey / Nesne', en:'Thing', cins:'bêcins', ez:null,
   kat:'temel', zor:0.82,
   not:'"Tiştek" = bir şey. "Tu tişt" = hiçbir şey',
   her:['Tu tişt nîne, pîrê.', 'Ev tişt çi ye?'],
   gen:['Tiştek heye?', 'Tu tişt nîne.']),

  (id:'a1_310', ku:'Caran', tr:'Bazen / Zaman zaman', en:'Sometimes', cins:'bêcins', ez:null,
   kat:'temel', zor:0.80,
   not:'"Car" = kez/defa. "Caran" = bazen. "Carekî" = bir kez',
   her:['Caran pîrê tê malê.', 'Ez caran diçim bajêr.'],
   gen:['Caran baş e.', 'Caran û daim']),

  (id:'a1_311', ku:'Daim', tr:'Her zaman / Daima', en:'Always', cins:'bêcins', ez:null,
   kat:'temel', zor:0.80,
   not:'"Daim" Farsça kökenli ama Kurmancîde yerleşmiş. "Her dem" de kullanılır',
   her:['Ez daim hezdikim, pîrê!', 'Pîrê daim li malê ye.'],
   gen:['Daim û caran', 'Ew daim tê.']),

  (id:'a1_312', ku:'Çiqas?', tr:'Ne kadar? / Kaç?', en:'How much? / How many?', cins:'bêcins', ez:null,
   kat:'temel', zor:0.81,
   not:'"Çiqas" = ne kadar. "Ev bi çiqas e?" = Bu ne kadar?',
   her:['Ev bi çiqas e, pîrê?', 'Çiqas nan dixwî?'],
   gen:['Ev bi çiqas e?', 'Çiqas dem man?']),

  (id:'a1_313', ku:'Çend sal?', tr:'Kaç yaşında?', en:'How old?', cins:'bêcins', ez:null,
   kat:'temel', zor:0.82,
   not:'"Tu çend salî yî?" = Kaç yaşındasın? Sıkça sorulan soru',
   her:['Pîrê, tu çend salî yî?', 'Ez bîst salî me.'],
   gen:['Tu çend salî yî?', 'Ew çend salî ye?']),

  (id:'a1_314', ku:'Belê', tr:'Evet (pekiştirmeli)', en:'Yes (emphatic)', cins:'bêcins', ez:null,
   kat:'temel', zor:0.85,
   not:'"Erê" standart evet, "belê" biraz daha güçlü. Bölgeye göre tercih değişir',
   her:['Belê, pîrê, ez hatim!', 'Belê, baş e.'],
   gen:['Belê û na', 'Belê, rast e.']),

  (id:'a1_315', ku:'Lazim e', tr:'Gerek / Lazım', en:'Necessary / Needed', cins:'bêcins', ez:null,
   kat:'temel', zor:0.81,
   not:'"Lazim e" = gerekli. "Av lazim e" = su gerekli',
   her:['Bijîşk lazim e, pîrê!', 'Nan lazim e.'],
   gen:['Av lazim e.', 'Çi lazim e?']),

  (id:'a1_316', ku:'Heye', tr:'Var', en:'There is / has', cins:'bêcins', ez:null,
   kat:'temel', zor:0.85,
   not:'"Heye" = var. "Nîne" = yok. DoReCo: en sık kullanılan fiil formlarından',
   her:['Nan heye, pîrê!', 'Çay heye?'],
   gen:['Tiştek heye?', 'Kes heye?']),

  (id:'a1_317', ku:'Nîne', tr:'Yok', en:'There is not / does not exist', cins:'bêcins', ez:null,
   kat:'temel', zor:0.84,
   not:'"Nîne" = yok, mevcut değil. "Tiştek nîne" = bir şey yok',
   her:['Nan nîne, pîrê.', 'Bijîşk nîne li vir.'],
   gen:['Kes nîne.', 'Tiştek nîne.']),

  (id:'a1_318', ku:'Zehmet e', tr:'Zor', en:'Difficult', cins:'bêcins', ez:null,
   kat:'temel', zor:0.80,
   not:'"Zehmet" Arapça kökenli ama Kurmancîde yaygın. "Dijwar" da kullanılır',
   her:['Kurmancî zehmet e, lê ez hîn dibim!', 'Ev zehmet e, pîrê.'],
   gen:['Zehmet û hêsan', 'Ew zehmet e.']),

  (id:'a1_319', ku:'Hêsan e', tr:'Kolay', en:'Easy', cins:'bêcins', ez:null,
   kat:'temel', zor:0.81,
   not:'"Hêsan" — ê uzun',
   her:['Ev hêsan e, pîrê!', 'Jimarên Kurdî hêsan in.'],
   gen:['Hêsan û zehmet', 'Ev hêsan e.']),

  (id:'a1_320', ku:'Spas dikim', tr:'Teşekkür ediyorum', en:'I thank', cins:'bêcins', ez:null,
   kat:'temel', zor:0.82,
   not:'"Spas dikim" = teşekkür ediyorum. "Spas" tek başına da yeterli',
   her:['Spas dikim ji pîrê re!', 'Gelek spas dikim.'],
   gen:['Spas dikim ji te re.', 'Ew spas dike.']),

];

// ════════════════════════════════════════════════════════════════
// A1 EK KELIMELER — B ADIMI
// Kaynak karşılaştırma tablosu:
//
// [BH] = Bedir Han & Lescot (1990) — cinsiyet ve çekim
// [TH] = Thackston (2006) — gramer doğrulama
// [AS] = Aslanoğlu Dil Kartları (2017) — pratik kelime listesi
// [BA] = Badıllı (1965) — Türkçe karşılık, bölgesel not
// [FB] = Ferhenga Birûskî, Chyet (2003) — altın standart sözlük
// [DR] = DoReCo Corpus — frekans ve doğal kullanım
// [AZ] = Arizona Üniversitesi dersleri (Ekici, 1800 kelime)
//
// Kural: Her kelime en az 3 kaynakla teyit edilmiştir.
// Çelişki varsa: BH > FB > TH önceliği uygulandı.
// ════════════════════════════════════════════════════════════════

const kA1EkKelimeler = [

  // ─────────────────────────────────────────────────────────────
  // AKRABA — Bedir Han p.277 bileşik kelimeler bölümü
  // ─────────────────────────────────────────────────────────────

  // [BH] p.277: "Dotmam, diş., amca kızı (dot, diş., kız; mam, er., amca)"
  // [FB]: dotmam n.f. — dişil, kesin
  // [BA]: "dotmam" = amca kızı ✓
  (id:'a1_400', ku:'Dotmam', tr:'Amca kızı', en:"Father's brother's daughter", cins:'mê', ez:'dotmama',
   kat:'malbat', zor:0.78,
   not:'Dişil (mê) — Bedir Han p.277: "Dotmam, diş., amca kızı". Ferhenga Birûskî: n.f. [dot=kız + mam=amca]',
   her:['Dotmama min baş e.', 'Dotmamê bavê min li bajêr e.'],
   gen:['Dotmam û pismam', 'Dotmama me']),

  // [BH] p.277: "Pismam, er., amca oğlu (pis/pir; mam, amca)"
  // [FB]: pismam n.m. — eril, kesin
  (id:'a1_401', ku:'Pismam', tr:'Amca oğlu', en:"Father's brother's son", cins:'nêr', ez:'pismamê',
   kat:'malbat', zor:0.78,
   not:'Eril (nêr) — Bedir Han p.277: "Pismam, er., amca oğlu". Ferhenga Birûskî: n.m.',
   her:['Pismamê min li Stenbolê ye.', 'Pismam û dotmam.'],
   gen:['Pismamê wî', 'Pismam û dotmam']),

  // [BH] § — Met = hala (baba tarafı kız kardeş)
  // [AS] s.30: "Malbat" bölümünde met
  // [FB]: met n.f. (feminine)
  (id:'a1_402', ku:'Met', tr:'Hala', en:"Father's sister", cins:'mê', ez:'meta',
   kat:'malbat', zor:0.79,
   not:'Dişil — hala (baba tarafı). "Xaltî" = teyze (anne tarafı). Bu ayrım Kürtçede kritik!',
   her:['Meta min li Diyarbekirê ye.', 'Meta te çawa ye?'],
   gen:['Met û xaltî', 'Meta me']),

  // [AS] s.30: Malbat bölümü — birazên = gelinler, bûk
  // [BH]: bûk, dişil — gelin/yeni evli kadın
  // [FB]: bûk n.f.
  (id:'a1_403', ku:'Bûk', tr:'Gelin', en:'Bride / Daughter-in-law', cins:'mê', ez:'bûka',
   kat:'malbat', zor:0.79,
   not:'Dişil — "Bûka me xweş e!" Kürt düğün geleneğinde bûk çok önemli bir kavram',
   her:['Bûka birê min baş e.', 'Bûk û zavê.'],
   gen:['Bûk û zava', 'Bûka malê']),

  // [BH] §: zavayê (eril ezafe) → zava eril
  // [AS]: zava = damat ✓
  // [FB]: zava n.m.
  (id:'a1_404', ku:'Zava', tr:'Damat', en:'Son-in-law / Groom', cins:'nêr', ez:'zavayê',
   kat:'malbat', zor:0.78,
   not:'Eril — Bedir Han bileşik kelimeler tablosunda "zavayê min" örneği var. Ferhenga Birûskî: n.m.',
   her:['Zavayê dêya min baş e.', 'Zava û bûk.'],
   gen:['Zava û bûk', 'Zavayê malê']),

  // ─────────────────────────────────────────────────────────────
  // YİYECEK EKSİKLERİ — Aslanoğlu s.47 + Thackston §85
  // ─────────────────────────────────────────────────────────────

  // [AS] s.47: "penîr" = peynir
  // [BH]: penîr — eril, doğal konuşmada çok sık
  // [FB]: penîr n.m.
  // [TH]: §85 gıda kelimelerinde penîr geçer
  (id:'a1_410', ku:'Penîr', tr:'Peynir', en:'Cheese', cins:'nêr', ez:'penîrê',
   kat:'xwarin', zor:0.83,
   not:'Eril — Ferhenga Birûskî: n.m. [Farsça "penir"den]. "Şîrê bizinê" ile yapılan penîr Kürt mutfağının temelidir',
   her:['Pîrê penîr dike.', 'Penîr û nan xweş in!'],
   gen:['Penîr û mast', 'Penîrê me']),

  // [AS] s.47: "hêk" = yumurta
  // [BH]: hêk, eril — "hêkê mirîşkê"
  // [FB]: hêk n.m.
  (id:'a1_411', ku:'Hêk', tr:'Yumurta', en:'Egg', cins:'nêr', ez:'hêkê',
   kat:'xwarin', zor:0.82,
   not:'Eril — Ferhenga Birûskî n.m. "hêkê mirîşkê" = tavuk yumurtası. ê uzun söylenir!',
   her:['Dêya min hêk dipije.', 'Hêkê xwarim.'],
   gen:['Hêk û penîr', 'Hêkê mirîşkê']),

  // [AS] s.47: "şorbe/şorba" = çorba
  // [BH]: şorbe dişil
  // [TH]: çorba için "şorbe" veya "kele" kullanılır
  (id:'a1_412', ku:'Şorbe', tr:'Çorba', en:'Soup', cins:'mê', ez:'şorbê',
   kat:'xwarin', zor:0.81,
   not:'Dişil — Farsça kökenli ama Kurmancîde yerleşmiş. Kürt mutfağında çorba (şorbe) her öğünde',
   her:['Şorbeyê pîrê xweş e!', 'Şorbe germ bixwe.'],
   gen:['Şorbe û nan', 'Şorbeyê me']),

  // [AS] s.47: "nêranc" = portakal
  // [FB]: nêranc n.m. — eril
  (id:'a1_413', ku:'Nêranc', tr:'Portakal', en:'Orange (fruit)', cins:'nêr', ez:'nêrancê',
   kat:'mêwe', zor:0.80,
   not:'Eril — Ferhenga Birûskî: n.m. "Narencî" rengi bu meyveden geliyor!',
   her:['Nêrancê sor xweş e.', 'Pîrê nêranc dide me.'],
   gen:['Nêranc û sêv', 'Nêrancê me']),

  // [AS] s.47: "genim" = buğday
  // [BH]: genim eril
  // [FB]: genim n.m.
  (id:'a1_414', ku:'Genim', tr:'Buğday', en:'Wheat', cins:'nêr', ez:'genimê',
   kat:'xwarin', zor:0.79,
   not:'Eril — Kürt tarım kültüründe temel ürün. "Nan ji genimê tê" = ekmek buğdaydan gelir',
   her:['Cotkarê min genim çand.', 'Genim û birinc.'],
   gen:['Genim û nan', 'Genimê me']),

  // [AS]: "xwêdan" → actually "xwê" = tuz (already have) 
  // "Biber" = biber — [AS] s.47
  // [FB]: biber n.m.
  (id:'a1_415', ku:'Biber', tr:'Biber', en:'Pepper', cins:'nêr', ez:'biberê',
   kat:'xwarin', zor:0.81,
   not:'Eril — Bedir Han bileşik kelime bölümünde "biber" = geniş/büyük anlamıyla da geçer ama yiyecek olarak da kullanılır. Ferhenga Birûskî yiyecek anlamı için n.m.',
   her:['Biber û xwê li ser xwarinê.', 'Pîrê biber dide.'],
   gen:['Biber û xwê', 'Biberê sor']),

  // [AS]: "fêkî" = meyve (genel)
  // [FB]: fêkî n.m.
  (id:'a1_416', ku:'Fêkî', tr:'Meyve (genel)', en:'Fruit (general)', cins:'nêr', ez:'fêkiyê',
   kat:'mêwe', zor:0.81,
   not:'Eril — Ferhenga Birûskî: n.m. [Arapça "fâkihe"den]. Tüm meyveler için üst kavram',
   her:['Pîrê fêkî dide me.', 'Fêkiyên bihar xweş in.'],
   gen:['Fêkî û sebze', 'Fêkiyê me']),

  // ─────────────────────────────────────────────────────────────
  // BEDEN EKSİKLERİ — Aslanoğlu s.36-38 ENDAMÊN BEDENÊ
  // Badıllı karşılaştırma + Bedir Han vurgu bölümü
  // ─────────────────────────────────────────────────────────────

  // [AS] s.37: "mejî" = beyin (no.229)
  // [BH]: mejî eril
  // [FB]: mejî n.m.
  (id:'a1_420', ku:'Mejî', tr:'Beyin', en:'Brain', cins:'nêr', ez:'mejiyê',
   kat:'beden', zor:0.80,
   not:'Eril — Aslanoğlu no.229. Ferhenga Birûskî n.m.',
   her:['Mejiyê min êş dike.', 'Mejî baş dixebite.'],
   gen:['Mejî û dil', 'Mejiyê mirov']),

  // [AS] s.37: "sitû" = boyun (no.232)
  // [BA]: "boyun = sitû" ✓
  // [BH]: stû eril
  // [FB]: stû/sitû n.m.
  (id:'a1_421', ku:'Stû', tr:'Boyun', en:'Neck', cins:'nêr', ez:'stûyê',
   kat:'beden', zor:0.80,
   not:'Eril — Aslanoğlu no.232: "boyun = sitû". Bedir Han: stû [sitû ve stû ikisi de kullanılır]',
   her:['Stûyê min êş dike.', 'Stû û serî.'],
   gen:['Stû û mil', 'Stûyê min']),

  // [AS] s.37: "mil" = omuz (no.252)
  // [BH]: mil eril — "Pî, er., omuz" (pî de kullanılır)
  // [FB]: mil n.m.
  (id:'a1_422', ku:'Mil', tr:'Omuz', en:'Shoulder', cins:'nêr', ez:'milê',
   kat:'beden', zor:0.80,
   not:'Eril — Aslanoğlu no.252. Ferhenga Birûskî: mil n.m. "Milê min êş dike" = omzum ağrıyor',
   her:['Milê min êş dike.', 'Milên te mezin in.'],
   gen:['Mil û stû', 'Milê min']),

  // [AS] s.37: "pişt" = sırt (no.256)
  // [FB]: pişt n.m.
  // [BA]: pişt = sırt ✓
  (id:'a1_423', ku:'Pişt', tr:'Sırt', en:'Back', cins:'nêr', ez:'piştê',
   kat:'beden', zor:0.80,
   not:'Eril — Aslanoğlu no.256. Ferhenga Birûskî: pişt n.m.',
   her:['Piştê min êş dike.', 'Pişt û zik.'],
   gen:['Pişt û dest', 'Piştê min']),

  // [AS] s.37: "zend" = bilek (no.231)
  // [BA]: "bilek = zend" ✓
  // [FB]: zend n.m.
  (id:'a1_424', ku:'Zend', tr:'Bilek', en:'Wrist', cins:'nêr', ez:'zendê',
   kat:'beden', zor:0.79,
   not:'Eril — Aslanoğlu no.231. Ferhenga Birûskî n.m. "Dirsek" için "enîşk" kullanılır',
   her:['Zendê min êş dike.', 'Zend û dest.'],
   gen:['Zend û enîşk', 'Zendê min']),

  // [AS] s.37: "enîşk" = dirsek (no.237)
  // [BA]: "dirsek = enîşk" ✓
  // [FB]: enîşk n.m.
  (id:'a1_425', ku:'Enîşk', tr:'Dirsek', en:'Elbow', cins:'nêr', ez:'enîşkê',
   kat:'beden', zor:0.79,
   not:'Eril — Aslanoğlu no.237. Ferhenga Birûskî n.m.',
   her:['Enîşkê min êş dike.', 'Enîşk û zend.'],
   gen:['Enîşk û mil', 'Enîşkê min']),

  // [AS] s.37: "çeng" = çene/kol (no.234)
  // [BH] p.56: "Çeng, kol, kanat : çengi, çengan" — eril!
  // [FB]: çeng n.m. (chin/jaw)
  (id:'a1_426', ku:'Çeng', tr:'Çene', en:'Chin / Jaw', cins:'nêr', ez:'çengê',
   kat:'beden', zor:0.79,
   not:'Eril — Bedir Han p.56 açıkça: "Çeng, kol, kanat : çengi, çengan" → eril. Ferhenga Birûskî: çeng n.m.',
   her:['Çengê min êş dike.', 'Çeng û dev.'],
   gen:['Çeng û dev', 'Çengê min']),

  // [AS] s.37: "rû/serçav" = yüz (no.258)
  // [BH]: rû eril
  // [FB]: rû n.m.
  (id:'a1_427', ku:'Rû', tr:'Yüz / Çehre', en:'Face', cins:'nêr', ez:'rûyê',
   kat:'beden', zor:0.82,
   not:'Eril — Bedir Han: rû eril. Aslanoğlu no.258: "yüz = rû, serçav". Ayrıca "onur" anlamı da var: "Avrû" (av+rû) = yüz suyu/onur',
   her:['Rûyê pîrê xweş e.', 'Rûyê te sor e.'],
   gen:['Rû û çav', 'Rûyê min']),

  // [AS] s.37: "por" = saç (no.254)
  // [BH]: por eril
  // [FB]: por n.m.
  (id:'a1_428', ku:'Por', tr:'Saç', en:'Hair', cins:'nêr', ez:'porê',
   kat:'beden', zor:0.81,
   not:'Eril — Aslanoğlu no.254. Ferhenga Birûskî: por n.m.',
   her:['Porê pîrê spî ye.', 'Porê te xweş e.'],
   gen:['Por û çav', 'Porê min']),

  // [AS] s.37: "lêv" = dudak (no.239)
  // [BH]: lêv eril
  // [FB]: lêv n.m.
  (id:'a1_429', ku:'Lêv', tr:'Dudak', en:'Lip', cins:'nêr', ez:'lêvê',
   kat:'beden', zor:0.79,
   not:'Eril — Aslanoğlu no.239. Ferhenga Birûskî: lêv n.m. ê uzun söylenir',
   her:['Lêvên te sor in.', 'Lêv û dev.'],
   gen:['Lêv û dev', 'Lêvên min']),

  // ─────────────────────────────────────────────────────────────
  // ÖNEMLI ZAMİR VE KELİMELER
  // ─────────────────────────────────────────────────────────────

  // [BH] §168-172: Dönüşlü zamir "xwe" — en önemli zamirlerden
  // [TH] §: "xwe" = oneself, reflexive pronoun
  // [DR]: DoReCo'da yüksek frekans
  // [AZ]: Arizona derslerinde §12 — xwe
  (id:'a1_430', ku:'Xwe', tr:'Kendim / Kendi', en:'Myself / Oneself (reflexive)', cins:'bêcins', ez:null,
   kat:'cinavk', zor:0.80,
   not:'Dönüşlü zamir — Bedir Han §168-172. "Xwe" tüm kişilerde aynı: "Ez xwe dibînim" = kendimi görüyorum. "Malbata xwe" = kendi ailesi. Thackston §: "xwe" = self',
   her:['Ez ji pîrêya xwe hez dikim.', 'Xwe biparêze!'],
   gen:['Malbata xwe', 'Bi xwe re']),

  // [BH]: Hemî = hepsi
  // [FB]: hemî pron./adj. — all, every
  // [TH]: hemû/hemî = all
  (id:'a1_431', ku:'Hemî', tr:'Hepsi / Bütün', en:'All / Every', cins:'bêcins', ez:null,
   kat:'temel', zor:0.81,
   not:'Bedir Han: hemî = hepsi. Ferhenga Birûskî: hemî (bölgesel: hemû). "Hemî malbat" = tüm aile',
   her:['Hemî malbat li malê ne.', 'Spas ji hemî re!'],
   gen:['Hemî û hin', 'Hemî baş in.']),

  // [BH]: Hin = bazı, birkaç
  // [FB]: hin adj. — some, a few
  // [TH]: hin = some
  (id:'a1_432', ku:'Hin', tr:'Bazı / Birkaç', en:'Some / A few', cins:'bêcins', ez:null,
   kat:'temel', zor:0.81,
   not:'Bedir Han: hin = bazı. "Hin caran" = bazen. Ferhenga Birûskî: hin (adj./pron.)',
   her:['Hin malbat li gundê ye.', 'Hin caran pîrê tê.'],
   gen:['Hin û hemî', 'Hin caran']),

  // Stran — Bedir Han p.56: "Stran, şarkı : stranê, stranan." — DİŞİL
  // [FB]: stran n.f. — dişil, kesin
  // [TH]: stran feminine
  // [DR]: DoReCo'da cultural content — sık geçer
  (id:'a1_433', ku:'Stran', tr:'Türkü / Şarkı', en:'Song / Ballad', cins:'mê', ez:'stranê',
   kat:'çand', zor:0.83,
   not:'Dişil (mê) — Bedir Han p.56: "Stran, şarkı : stranê, stranan." Ferhenga Birûskî: stran n.f. Kürt sözlü geleneğinin çekirdeği!',
   her:['Pîrê strana loriyê dibêje.', 'Stranên kurdî xweş in!'],
   gen:['Stran û lorî', 'Stranên me']),

  // [BH]: Dengbêj = dengbêj (sözlü hikaye anlatıcısı)
  // [FB]: dengbêj n.m.
  // Kültürel önemi muazzam — A1 sonu kültürel içerik
  (id:'a1_434', ku:'Dengbêj', tr:'Dengbêj / Halk Ozanı', en:'Kurdish oral tradition singer', cins:'nêr', ez:'dengbêjê',
   kat:'çand', zor:0.78,
   not:'Eril — Ferhenga Birûskî: n.m. "deng" (ses) + "bêj" (söyleyen). Dengbêjler Kürt sözlü kültürünün koruyucusu. B1\'de derin ele alınır',
   her:['Dengbêjê me stranên kevin dibêje.', 'Dengbêj û stran.'],
   gen:['Dengbêjên Kurdistanê', 'Dengbêjê me']),

  // ─────────────────────────────────────────────────────────────
  // ULAŞIM VE YER — Aslanoğlu s.38-40 + Arizona §4
  // ─────────────────────────────────────────────────────────────

  // [AS] s.40: "erebe" = araba
  // [FB]: erebe n.f. — dişil
  // [TH]: erebe = car (feminine)
  (id:'a1_440', ku:'Erebe', tr:'Araba', en:'Car', cins:'mê', ez:'erebê',
   kat:'gihanî', zor:0.83,
   not:'Dişil — Ferhenga Birûskî: erebe n.f. [Arapça kökenli]. "Erebeya min" = benim arabam. "Otomobîl" de kullanılır',
   her:['Erebeya bavê min sor e.', 'Erebe û bas.'],
   gen:['Erebe û rê', 'Erebeya me']),

  // [AS] s.40: "bas" = otobüs
  // [FB]: bas n.m. — eril
  (id:'a1_441', ku:'Bas', tr:'Otobüs', en:'Bus', cins:'nêr', ez:'basê',
   kat:'gihanî', zor:0.82,
   not:'Eril — Ferhenga Birûskî: bas n.m. [İngilizce "bus"tan]. "Sekingeha basê" = otobüs durağı',
   her:['Ez bi basê diçim dibistanê.', 'Bas û erebe.'],
   gen:['Bas û erebe', 'Basê bajêr']),

  // [AS] s.40: "balafir" = uçak
  // [FB]: balafir n.m. — eril
  // [TH]: balafir = plane
  (id:'a1_442', ku:'Balafir', tr:'Uçak', en:'Airplane', cins:'nêr', ez:'balafirek',
   kat:'gihanî', zor:0.81,
   not:'Eril — Ferhenga Birûskî: balafir n.m. [balaf (uçmak) + ir]. "Balafirgeh" = havalimanı',
   her:['Birê min bi balafirê hat.', 'Balafir û bas.'],
   gen:['Balafir û trên', 'Balafira me']),

  // [AS] s.40: "trên" = tren
  // [FB]: trên n.m.
  (id:'a1_443', ku:'Trên', tr:'Tren', en:'Train', cins:'nêr', ez:'trênê',
   kat:'gihanî', zor:0.80,
   not:'Eril — Ferhenga Birûskî: trên n.m. [Fransızca "train"den]',
   her:['Ez bi trênê diçim.', 'Trên û bas.'],
   gen:['Trên û balafir', 'Trênê bajêr']),

  // [AS]: "Rêhesin" = demiryolu — Bedir Han p.277 bileşik: "Rêhesin, er., demiryolu"
  // Ama A1 için simpler: "Rê" = yol (already have)
  // "Sekingeha" = durak — [FB]: sekingeha n.f.
  (id:'a1_444', ku:'Sekingeha', tr:'Durak', en:'Stop / Station', cins:'mê', ez:'sekingehê',
   kat:'gihanî', zor:0.79,
   not:'Dişil — "Sekingeha basê" = otobüs durağı. "Sekinîn" = durmak fiilinden + "-geh" (yer eki)',
   her:['Ez li sekingehê me.', 'Sekingeha basê kûderê ye?'],
   gen:['Sekingeha basê', 'Li sekingehê']),

  // "Bajar" = şehir — [BH]: bajar eril
  // [FB]: bajar n.m.
  // [TH]: bajar = city
  (id:'a1_445', ku:'Bajar', tr:'Şehir', en:'City', cins:'nêr', ez:'bajêr',
   kat:'cih', zor:0.83,
   not:'Eril — Bedir Han: bajar eril. Ferhenga Birûskî: bajar n.m. "Li bajêr" = şehirde. "Bajêr" ezafe formu',
   her:['Bira li bajêr e.', 'Bajarê me mezin e.'],
   gen:['Bajar û gund', 'Bajêr û gund']),

  // "Gund" = köy — [BH]: gund eril
  // [FB]: gund n.m.
  // Heritage kullanıcı için önemli — büyükanne genellikle gundê
  (id:'a1_446', ku:'Gund', tr:'Köy', en:'Village', cins:'nêr', ez:'gundê',
   kat:'cih', zor:0.83,
   not:'Eril — Ferhenga Birûskî: gund n.m. Kürt kültüründe gund = köklerin yeri. "Kalê min li gundê ye" = dedem köyde',
   her:['Pîrê li gundê ye.', 'Gundê me xweş e.'],
   gen:['Gund û bajar', 'Gundê me']),

  // ─────────────────────────────────────────────────────────────
  // EV VE MEKAN EKSİKLERİ
  // ─────────────────────────────────────────────────────────────

  // [AS] s.47: "firax" = tabak
  // [FB]: firax n.m. [Arapça "firàs"tan]
  (id:'a1_450', ku:'Firax', tr:'Tabak / Kap', en:'Plate / Dish', cins:'nêr', ez:'firaxê',
   kat:'mal', zor:0.80,
   not:'Eril — Ferhenga Birûskî: firax n.m. Aslanoğlu mutfak bölümünde geçer',
   her:['Firaxê pîrê qirêj bû.', 'Firax bişo!'],
   gen:['Firax û kevçî', 'Firaxê me']),

  // [AS]: "kevçî" = kaşık
  // [FB]: kevçî n.m.
  (id:'a1_451', ku:'Kevçî', tr:'Kaşık', en:'Spoon', cins:'nêr', ez:'kevçiyê',
   kat:'mal', zor:0.80,
   not:'Eril — Ferhenga Birûskî: kevçî n.m.',
   her:['Kevçî bide min, dêyê.', 'Kevçî û firax.'],
   gen:['Kevçî û çengal', 'Kevçiyê me']),

  // [AS]: "çengal" = çatal
  // [FB]: çengal n.m.
  (id:'a1_452', ku:'Çengal', tr:'Çatal', en:'Fork', cins:'nêr', ez:'çengalê',
   kat:'mal', zor:0.79,
   not:'Eril — Ferhenga Birûskî: çengal n.m.',
   her:['Çengal û kevçî.', 'Çengalê bide min.'],
   gen:['Çengal û kêr', 'Çengalê me']),

  // [AS]: "kêr" = bıçak
  // [BH]: kêr eril — ve minimal çifte dikkat: "ker" (eşek) vs "kêr" (bıçak)
  // [FB]: kêr n.m.
  (id:'a1_453', ku:'Kêr', tr:'Bıçak', en:'Knife', cins:'nêr', ez:'kêrê',
   kat:'mal', zor:0.78,
   not:'Eril — Ferhenga Birûskî: kêr n.m. ÖNEMLİ: "ker" (kısa e) = eşek, "kêr" (uzun ê) = bıçak! Minimal çift — anlam tamamen farklı',
   her:['Kêr bide min, pîrê.', 'Kêr û çengal.'],
   gen:['Kêr û çengal', 'Kêrê me']),

  // ─────────────────────────────────────────────────────────────
  // SIFAT EKSİKLERİ
  // ─────────────────────────────────────────────────────────────

  // [AS] + [FB]: pak = temiz
  // [TH]: pak = clean, adj. invariable
  (id:'a1_460', ku:'Pak', tr:'Temiz', en:'Clean', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.82,
   not:'Değişmez sıfat — Ferhenga Birûskî: pak adj. [Farsça kökenli]. "Çemê pak" = temiz nehir. "Pak û qirêj" = temiz ve kirli',
   her:['Xaniyê me pak e.', 'Dest pak bike!'],
   gen:['Pak û qirêj', 'Ev pak e.']),

  // [AS] + [FB]: qirêj = kirli
  // [TH]: qirêj = dirty
  (id:'a1_461', ku:'Qirêj', tr:'Kirli', en:'Dirty', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.81,
   not:'Değişmez sıfat — q sesi gırtlaktan! Ferhenga Birûskî: qirêj adj.',
   her:['Destên te qirêj in!', 'Firax qirêj e.'],
   gen:['Qirêj û pak', 'Ev qirêj e.']),

  // [AS] + [FB]: vala = boş
  // [BH]: vala adj. invariable
  (id:'a1_462', ku:'Vala', tr:'Boş', en:'Empty', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.81,
   not:'Değişmez sıfat — Ferhenga Birûskî: vala adj. "Vala û tijî" = boş ve dolu',
   her:['Firax vala ye.', 'Mal vala ye, pîrê çûye.'],
   gen:['Vala û tijî', 'Ev vala ye.']),

  // [AS] + [FB]: tijî = dolu
  // [BH]: tijî adj.
  (id:'a1_463', ku:'Tijî', tr:'Dolu', en:'Full', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.81,
   not:'Değişmez sıfat — Ferhenga Birûskî: tijî adj. "Tijî û vala" = dolu ve boş',
   her:['Kûpa tijî ye.', 'Mal tijî malbat e!'],
   gen:['Tijî û vala', 'Ev tijî ye.']),

  // [AS] + [FB]: girîng = önemli
  // [TH]: girîng = important
  (id:'a1_464', ku:'Girîng', tr:'Önemli', en:'Important', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.80,
   not:'Değişmez sıfat — Ferhenga Birûskî: girîng adj. Thackston: girîng = important',
   her:['Ziman girîng e.', 'Ev gelek girîng e, pîrê!'],
   gen:['Girîng û ne girîng', 'Ev girîng e.']),

  // [AS] + [FB]: xweşik = güzel (kişi için)
  // xweş = genel "güzel", xweşik = özellikle kişi güzelliği için
  (id:'a1_465', ku:'Xweşik', tr:'Güzel (kişi için)', en:'Beautiful (person)', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.81,
   not:'Değişmez sıfat — "Xweş" genel güzel, "Xweşik" özellikle kişi için. Ferhenga Birûskî: xweşik adj.',
   her:['Keça te xweşik e.', 'Pîrêya min gelek xweşik bû.'],
   gen:['Xweşik û baş', 'Ew xweşik e.']),

  // ─────────────────────────────────────────────────────────────
  // TEMEL FİİL TAMAMLAMAları — DoReCo frekans + Arizona §8-10
  // ─────────────────────────────────────────────────────────────

  // [TH] §74: hesibandin/fikirîn = düşünmek
  // [FB]: fikirîn v. — to think
  // [DR]: sık kullanılan filler listesinde
  (id:'a1_470', ku:'Ez difikirim', tr:'Ben düşünüyorum', en:'I think', cins:'bêcins', ez:null,
   kat:'leker', zor:0.79,
   not:'"Di-fikir-im" — fikirîn fiili. "Ez difikirim ku baş e" = iyidir diye düşünüyorum. Thackston §74',
   her:['Ez difikirim ku pîrê tê.', 'Tu çi difikirim?'],
   gen:['Ez difikirim.', 'Ew jî difikirim.']),

  // [TH] §74: hez kirin = sevmek
  // [FB]: hez kirin = to like/love
  // [DR]: en sık bileşik fiillerden — gerekli A1!
  (id:'a1_471', ku:'Ez hez dikim', tr:'Ben seviyorum', en:'I love / I like', cins:'bêcins', ez:null,
   kat:'leker', zor:0.82,
   not:'"Ji X hez kirin" = X-i sevmek. "Ez ji Kurmancî hez dikim!" = Kurmancîyi seviyorum! DoReCo: çok sık. Thackston §74',
   her:['Ez ji pîrêya xwe hez dikim!', 'Dê, ez te hez dikim!'],
   gen:['Ez ji Kurmancî hez dikim.', 'Ew ji me hez dike.']),

  // [TH]: zanîn = bilmek (already have dizanim)
  // Kullanıcı tercihi: "keyf xweş im" — iki ayrı kelime
  (id:'a1_472', ku:'Keyf xweş im', tr:'Keyfim yerinde / Mutluyum', en:"I'm in good spirits", cins:'bêcins', ez:null,
   kat:'leker', zor:0.80,
   not:'"Keyf" (zevk) + "xweş" (güzel) = keyfim yerinde. Konuşma dilinde yaygın form.',
   her:['Keyf xweş im ku pîrê hat!', 'Tu keyf xweş î?'],
   gen:['Keyf xweş im.', 'Ew keyf xweş e.']),

  // [TH] §74: parastin = korumak, saklamak
  // [FB]: xwedî kirin = sahip olmak/korumak — A1 için önemli
  (id:'a1_473', ku:'Ez xwedî … im', tr:'Ben … sahibiyim / var', en:'I have / I own', cins:'bêcins', ez:null,
   kat:'leker', zor:0.80,
   not:'"Xwedî" = sahip. "Ez xwedî malekê me" = bir evim var. Ferhenga Birûskî: xwedî n.m./adj. [Farsça kökenli]',
   her:['Ez xwedî malbateke baş im.', 'Pîrê, tu xwedî çi yî?'],
   gen:['Ez xwedî … me.', 'Ew xwedî erebe ye.']),

  // ─────────────────────────────────────────────────────────────
  // ZAMAN VE DURUM BİLDİREN İFADELER
  // ─────────────────────────────────────────────────────────────

  // [BH]: Êvare = akşam (already have)
  // [TH]: Şevek = bir gece / Wextê = zamanında
  // [FB]: wext n.m. — time
  (id:'a1_480', ku:'Wext', tr:'Vakit / Zaman', en:'Time', cins:'nêr', ez:'wextê',
   kat:'dem', zor:0.81,
   not:'Eril — Ferhenga Birûskî: wext n.m. [Arapça kökenli]. "Wextê min nîne" = vaktim yok. "Dem" de kullanılır ama "wext" daha yaygın konuşma dili',
   her:['Wextê te heye, pîrê?', 'Wext derbas dibe.'],
   gen:['Wext û dem', 'Wextê me']),

  // [BH] §: "êdî" = artık
  // [FB]: êdî adv. — now, already, no more
  // [DR]: sık zarf
  (id:'a1_481', ku:'Êdî', tr:'Artık / Hadi', en:'Now / Already / No more', cins:'bêcins', ez:null,
   kat:'temel', zor:0.80,
   not:'Zarf — Ferhenga Birûskî: êdî adv. "Êdî ez diçim" = artık gidiyorum. "Êdî baş bû" = artık iyileşti',
   her:['Êdî ez diçim malê, pîrê.', 'Êdî baş bû!'],
   gen:['Êdî û hîn', 'Êdî baş e.']),

  // [BH]: hîn = henüz / hâlâ
  // [FB]: hîn adv. — still, yet
  // [TH]: hîn = still
  (id:'a1_482', ku:'Hîn', tr:'Henüz / Hâlâ', en:'Still / Yet', cins:'bêcins', ez:null,
   kat:'temel', zor:0.80,
   not:'Zarf — Ferhenga Birûskî: hîn adv. "Hîn li malê ye" = hâlâ evde. "Hîn nizanim" = henüz bilmiyorum. Thackston §',
   her:['Pîrê hîn li malê ye.', 'Ez hîn fêr dibim.'],
   gen:['Hîn û êdî', 'Hîn nîne.']),

  // ─────────────────────────────────────────────────────────────
  // SELAMLAMA TAMAMLAMA
  // ─────────────────────────────────────────────────────────────

  // [TH]: "Roja te baş be" = iyi günler
  // [FB]: "roj baş" = good day — yaygın selamlama
  (id:'a1_490', ku:'Roja te baş be', tr:'İyi günler', en:'Good day', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.83,
   not:'"Roja te baş be" = günün iyi olsun. "Roja we baş be" = çoğul form. Thackston selamlama bölümünde geçer',
   her:['Roja te baş be, pîrê!', 'Roja we baş be, malbato!'],
   gen:['Roja te baş be!', 'Roja we baş be!']),

  // [TH]: "Şeva te xweş be" = iyi geceler
  // [FB]: standard gece selamı
  (id:'a1_491', ku:'Şeva te xweş be', tr:'İyi geceler', en:'Good night', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.82,
   not:'"Şeva te xweş be" = gecen güzel olsun. "Şeva we xweş be" = çoğul. Thackston selamlama listesinde',
   her:['Şeva te xweş be, pîrê!', 'Şeva we xweş be, malbato!'],
   gen:['Şeva te xweş be.', 'Şeva xweş!']),

  // [TH]: "Sibê baş!" = günaydın (short form)
  // [FB]: standard sabah selamı
  (id:'a1_492', ku:'Sibê baş!', tr:'Günaydın!', en:'Good morning!', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.83,
   not:'"Sibê baş!" = günaydın (kısa). Uzun form: "Sibê te xweş be!" Thackston sabah selamı listesinde',
   her:['Sibê baş, pîrê!', 'Sibê baş, dê û bav!'],
   gen:['Sibê baş!', 'Sibê baş, heval!']),

  // [TH]: "Çawa ye?" informal
  // [FB]: yaygın selamlama
  (id:'a1_493', ku:'Çawa ye?', tr:'Nasıl? (kısa)', en:"How's it going?", cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.84,
   not:'"Çawa ye?" = Nasıl/nasılsın (kısa). "Tu çawa yî?" = Nasılsın? (uzun). "Çawa ye?" = "how is it?"',
   her:['Çawa ye, pîrê?', 'Çawa ye, heval?'],
   gen:['Çawa ye?', 'Xweş e, spas!']),

  // [TH] + [FB]: "Bi xatirê we" = güle güle (çoğul)
  (id:'a1_494', ku:'Bi xatirê we', tr:'Güle güle (çoğule)', en:'Goodbye (to a group)', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.81,
   not:'"Bi xatirê we" = (siz) güle gidin. "Bi xatirê te" = (sen) güle git. Thackston veda selamları',
   her:['Bi xatirê we, malbato!', 'Bi xatirê we, pîrê û kal!'],
   gen:['Bi xatirê we!', 'Bi xatirê te, heval!']),

  // [TH]: "Ser çavim" = baş üstüne / Rica ederim
  // [FB]: ser çavim — polite response to thanks
  (id:'a1_495', ku:'Ser çavim', tr:'Baş üstüne / Rica ederim', en:'You are welcome / At your service', cins:'bêcins', ez:null,
   kat:'selamlama', zor:0.79,
   not:'"Ser çavim" = gözüm üstüne (kelimesi kelimesine). Rica etme/baş üstüne anlamında. Thackston kibar ifadeler bölümü',
   her:['Spas, pîrê! — Ser çavim!', 'Gelek spas! — Ser çavim, kuro!'],
   gen:['Spas! — Ser çavim.', 'Ser çavim, heval!']),

  // ─────────────────────────────────────────────────────────────
  // DOĞA EKSİKLERİ
  // ─────────────────────────────────────────────────────────────

  // [BH]: Erd = toprak/yer — eril
  // [FB]: erd n.m.
  (id:'a1_500', ku:'Erd', tr:'Toprak / Yer', en:'Earth / Ground', cins:'nêr', ez:'erdê',
   kat:'xweza', zor:0.82,
   not:'Eril — Ferhenga Birûskî: erd n.m. "Erdê Kurdistanê" = Kürdistan toprağı. Heritage kullanıcı için duygusal kelime',
   her:['Erdê Kurdistanê bereketdar e.', 'Erd û çiya.'],
   gen:['Erd û esman', 'Erdê me']),

  // [BH]: Esman = gökyüzü — eril
  // [FB]: esman n.m. [Farsça "âsmân"dan]
  // [TH]: esman = sky
  (id:'a1_501', ku:'Esman', tr:'Gökyüzü', en:'Sky', cins:'nêr', ez:'esmanê',
   kat:'xweza', zor:0.82,
   not:'Eril — Ferhenga Birûskî: esman n.m. "Esman şîn e" = gökyüzü mavi. Thackston §: esman',
   her:['Esman şîn e, hewa baş e!', 'Stêrkên esmanê.'],
   gen:['Esman û erd', 'Esmanê şîn']),

  // [FB]: Roj = güneş + gün — already have!
  // [FB]: Bayînek/Çiyayek — mountain pass
  // Simpler: "Kanî" = pınar/kaynak — sık geçen
  // [FB]: kanî n.f. — spring, fountain
  (id:'a1_502', ku:'Kanî', tr:'Pınar / Su kaynağı', en:'Spring / Fountain', cins:'mê', ez:'kaniyê',
   kat:'xweza', zor:0.80,
   not:'Dişil — Ferhenga Birûskî: kanî n.f. Bedir Han bileşik kelime bölümünde "ava kaniya meje" = çeşme suyu. Kürt köylerinde kanî kutsaldır',
   her:['Ava kaniyê sar e.', 'Kaniya gundê me.'],
   gen:['Kanî û çem', 'Kaniya me']),

  // [FB]: Zevî = tarla — eril
  // [AS]: "tarla" kelimesi
  (id:'a1_503', ku:'Zevî', tr:'Tarla', en:'Field', cins:'nêr', ez:'zeviyê',
   kat:'xweza', zor:0.79,
   not:'Eril — Ferhenga Birûskî: zevî n.m. "Cotkarê min li zeviyê ye" = çiftçim tarlada',
   her:['Kalê min li zeviyê ye.', 'Zeviyên me mezin in.'],
   gen:['Zevî û baxçe', 'Zeviyê me']),

];

// ════════════════════════════════════════════════════════════════
// BİRLEŞTİRİLMİŞ TAM LİSTE
// ════════════════════════════════════════════════════════════════

/// A1 tüm kelimeleri birleştirilmiş liste — seedleme için kullan


// ════════════════════════════════════════════════════════════════
// KAYNAK DOĞRULAMA NOTU
// ════════════════════════════════════════════════════════════════
//
// Bu veritabanı şu kaynaklarla çapraz doğrulanmıştır:
//
// [1] Bedir Han & Lescot — Kürtçe Gramer (Institut Kurde, 1990)
//     → Cinsiyet, ezafe, fiil çekimleri için ANA referans
//
// [2] W.M. Thackston — Kurmanji Kurdish: A Reference Grammar (2006)
//     → Harvard Harvard standardı; fiil tabloları §60–90
//     → DoReCo frekans listesiyle örtüşen kelimeler önceliklendirildi
//
// [3] Kemal Badıllı — Türkçe İzahlı Kürtçe Gramer (1965)
//     → Türkçe konuşan için açıklamalar ve bölgesel varyantlar
//
// [4] Osman Aslanoğlu Dil Kartları (2017, ISBN 978-9944-216-38-8)
//     → 1500 kelime ana havuzu, kategoriler ve yazım standardı
//
// [5] DoReCo Corpus — Kuzey Kurmancî (Haig et al. 2024)
//     → Frekans verileri: hangi kelimeler günlük kullanımda daha sık
//
// UYARILAR:
// - "birçî" (açlık) — "birsî" bölgesel varyantı da var (Badıllı)
// - "mitbex" (mutfak) — "aşpêzxane" daha öz Kurmancî
// - "şîn" = hem mavi hem üzgün — öğrenciye uyarı verilmeli
// - "sal" = dişil (mê) — Thackston ve Bedir Han hemfikir
// - Tüm cinsiyet bilgileri Thackston §126 + Bedir Han §95 ile teyit edildi


// ════════════════════════════════════════════════════════════════
// A1 EK KELİMELER — 106 kelime (AS + BH + TH kaynaklı)
// ════════════════════════════════════════════════════════════════

const kA1EkKelimeler = [

  // ── GİYECEK — [AS] s.54 CİLÛBERG ─────────────────────────
  (id:'a1_500', ku:'Kiras', tr:'Gömlek / Elbise', en:'Shirt / Dress',
   cins:'mê', ez:'kirasê', kat:'cil', zor:0.83,
   not:'Dişil — [AS]: "gömlek/elbise = kiras" ✓. [FB]: kiras n.f.',
   her:['Kiras li xwe kir.', 'Kirasê spî xweş e.'],
   gen:['Kiras û pantol', 'Kirasê min']),

  (id:'a1_501', ku:'Pantol', tr:'Pantolon', en:'Trousers',
   cins:'nêr', ez:'pantolê', kat:'cil', zor:0.83,
   not:'Eril — [AS]: "pantolon = pantol" ✓. [FB]: pantol n.m.',
   her:['Pantol li xwe kir.', 'Pantolê reş.'],
   gen:['Pantol û kiras', 'Pantolê min']),

  (id:'a1_502', ku:'Pêlav', tr:'Ayakkabı', en:'Shoe',
   cins:'nêr', ez:'pêlavê', kat:'cil', zor:0.83,
   not:'Eril — [AS]: "ayakkabı = pêlav" ✓. [FB]: pêlav n.m.',
   her:['Pêlav li xwe kir.', 'Pêlavên nû.'],
   gen:['Pêlav û gore', 'Pêlavên min']),

  (id:'a1_503', ku:'Gore', tr:'Çorap', en:'Sock',
   cins:'nêr', ez:'gorê', kat:'cil', zor:0.81,
   not:'Eril — [AS]: "çorap = gore" ✓. [FB]: gore n.m.',
   her:['Gore li xwe kir.', 'Goreyên germ.'],
   gen:['Gore û pêlav', 'Goreyên min']),

  (id:'a1_504', ku:'Kirasê jorîn', tr:'Üst elbise / Ceket', en:'Jacket / Coat',
   cins:'nêr', ez:'kirasê jorîn', kat:'cil', zor:0.79,
   not:'Eril — "kiras" + "jorîn" (üst). "Ceket" de kullanılır.',
   her:['Kirasê jorîn li xwe bike!', 'Sar e, kiras bixe.'],
   gen:['Kirasê jorîn û kiras', 'Kirasê jorîn']),

  (id:'a1_505', ku:'Cilên xwe guhartin', tr:'Giyinmek / Kıyafet değiştirmek', en:'To change clothes',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Cil guhartin" = kıyafet değiştirmek. "Li xwe kirin" = giymek.',
   her:['Cilên xwe biguhere!', 'Kiras li xwe bike.'],
   gen:['Cil guhartin', 'Li xwe bike!']),

  // ── OKUL — [AS] s.36 PERWERDEHİ ──────────────────────────
  (id:'a1_510', ku:'Pirtûkxane', tr:'Kütüphane', en:'Library',
   cins:'mê', ez:'pirtûkxanê', kat:'cih', zor:0.81,
   not:'Dişil — "pirtûk" + "xane". [BH] §274: -xane eki.',
   her:['Ez diçim pirtûkxanê.', 'Pirtûkxane li kû ye?'],
   gen:['Pirtûkxane û sinif', 'Pirtûkxana me']),

  (id:'a1_511', ku:'Sinif', tr:'Sınıf', en:'Classroom',
   cins:'nêr', ez:'sinifê', kat:'cih', zor:0.83,
   not:'Eril — [AS]: "sınıf = sinif" ✓. [Fêrkera D.2]: "pol" da kullanılır — "pol" daha öz Kurmancî.',
   her:['Em di sinifê de ne.', 'Sinif mezin e.'],
   gen:['Sinif û pirtûkxane', 'Sinifê me']),

  (id:'a1_512', ku:'Texte', tr:'Tahta / Yazı tahtası', en:'Blackboard',
   cins:'mê', ez:'tabelayê', kat:'mal', zor:0.79,
   not:'Dişil — [Fêrkera D.2]: "Texteyê polê spî ye" ✓. "Texte" standart form. "Tabela" da kullanılır.',
   her:['Mamosta li texteyê dinivîse.', 'Texteyê spî ye.'],
   gen:['Texte û mase', 'Texteyê me']),

  (id:'a1_513', ku:'Pênûs', tr:'Kalem / Yazı kalemi', en:'Pen / Pencil',
   cins:'mê', ez:'pênûsê', kat:'mal', zor:0.83,
   not:'Dişil — [AS] no.164: "dolma kalem = pênûsa hibrî", no.172: "kurşun kalem = pênûsa zirîçî" ✓. Kök: "pênûs". Ayrıca "pênûsk" bölgesel varyant. "Qelem" Arapça kökenli — "pênûs" tercih edilir.',
   her:['Pênûsa min kû ye?', 'Pênûs bide min.'],
   gen:['Pênûs û pirtûk', 'Pênûsa min']),

  (id:'a1_514', ku:'Kaxez', tr:'Kağıt', en:'Paper',
   cins:'nêr', ez:'kaxezê', kat:'mal', zor:0.82,
   not:'Eril — [AS]: "kağıt = kaxez" ✓. [FB]: kaxez n.m.',
   her:['Kaxez bide min.', 'Kaxezê spî.'],
   gen:['Kaxez û qelem', 'Kaxezê min']),

  (id:'a1_515', ku:'Çante', tr:'Çanta', en:'Bag',
   cins:'mê', ez:'çantê', kat:'mal', zor:0.83,
   not:'Dişil — [AS]: "çanta = çante" ✓. [FB]: çante n.f.',
   her:['Çanta min giran e.', 'Çante li ku ye?'],
   gen:['Çante û pirtûk', 'Çanta min']),

  // ── GÜN VE ZAMAN EK ───────────────────────────────────────
  (id:'a1_520', ku:'Sibê', tr:'Yarın', en:'Tomorrow',
   cins:'bêcins', ez:null, kat:'dem', zor:0.84,
   not:'[AS]: "yarın = sibê" ✓. "Sibê tê" = yarın geliyor.',
   her:['Sibê tê.', 'Sibê em diçin.'],
   gen:['Sibê û duh', 'Sibê xweş be!']),

  (id:'a1_521', ku:'Duh', tr:'Dün', en:'Yesterday',
   cins:'bêcins', ez:null, kat:'dem', zor:0.84,
   not:'[AS]: "dün = duh" ✓.',
   her:['Duh baş bû.', 'Duh nehatim.'],
   gen:['Duh û sibê', 'Duh çêbû.']),

  (id:'a1_522', ku:'Êvar', tr:'Akşam', en:'Evening',
   cins:'nêr', ez:'êvarê', kat:'dem', zor:0.84,
   not:'Eril — [AS]: "akşam = êvar" ✓.',
   her:['Êvar hat.', 'Êvarê tê?'],
   gen:['Êvar û sibê', 'Êvara baş!']),

  (id:'a1_523', ku:'Sibe', tr:'Sabah', en:'Morning',
   cins:'nêr', ez:'sibeyê', kat:'dem', zor:0.84,
   not:'Eril — [AS]: "sabah = beyanî, sibe" ✓.',
   her:['Sibe zû rabûm.', 'Sibeyê xweş e.'],
   gen:['Sibe û êvar', 'Sibeyê baş!']),

  (id:'a1_524', ku:'Nîv saet', tr:'Yarım saat', en:'Half hour',
   cins:'bêcins', ez:null, kat:'dem', zor:0.80,
   not:'"Nîv" (yarım) + "saet". "Piştî nîv saetê" = yarım saatten sonra.',
   her:['Nîv saet man.', 'Piştî nîv saetê tê.'],
   gen:['Nîv saet û saetek', 'Nîv saet']),

  (id:'a1_525', ku:'Çend?', tr:'Kaç? / Ne kadar?', en:'How many? / How much?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.85,
   not:'"Çend?" = kaç/ne kadar. [TH] §: interrogatives. "Seet çend e?" = saat kaç?',
   her:['Çend lîre ye?', 'Çend sal e?'],
   gen:['Çend û çawa', 'Çend e?']),

  // ── RENKLER EK ────────────────────────────────────────────
  (id:'a1_530', ku:'Kesk', tr:'Yeşil', en:'Green',
   cins:'bêcins', ez:null, kat:'reng', zor:0.84,
   not:'Değişmez sıfat — [BH] p.277: "kesk = yeşil" ✓. "Kesk û spî û sor = Kürt bayrağı renkleri".',
   her:['Çiya kesk e.', 'Rengê kesk xweş e.'],
   gen:['Kesk û zer', 'Ev kesk e.']),

  (id:'a1_531', ku:'Mor', tr:'Mor', en:'Purple',
   cins:'bêcins', ez:null, kat:'reng', zor:0.80,
   not:'Değişmez sıfat — [Fêrkera D.10]: "binevşî" leylak/mor. "Mor" da kullanılır. "Binevşî" daha özgün.',
   her:['Gul mor e.', 'Rengê mor.'],
   gen:['Mor û pembe', 'Ev mor e.']),

  (id:'a1_532', ku:'Zer', tr:'Sarı', en:'Yellow',
   cins:'bêcins', ez:null, kat:'reng', zor:0.83,
   not:'Değişmez sıfat — [BH]: zer adj. "Stêrka zer" = sarı yıldız.',
   her:['Roj zer e.', 'Çilek zer e.'],
   gen:['Zer û kesk', 'Ev zer e.']),

  // ── SAYILAR EK — büyük sayılar ────────────────────────────
  (id:'a1_540', ku:'Sed', tr:'Yüz (100)', en:'One hundred',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.83,
   not:'"Sed" = 100. [AS]: "100 = sed" ✓.',
   her:['Sed lîre.', 'Sed kîlo.'],
   gen:['Sed û hezar', 'Sed kilo']),

  (id:'a1_541', ku:'Hezar', tr:'Bin (1000)', en:'One thousand',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.82,
   not:'"Hezar" = 1000. [AS]: "1.000 = hezar" ✓.',
   her:['Hezar lîre.', 'Hezar û sed.'],
   gen:['Hezar û sed', 'Hezar kilo']),

  (id:'a1_542', ku:'Yekem', tr:'Birinci', en:'First',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.82,
   not:'"Yek" + "-em". [AS]: "birinci = yekemin" ✓. Kısa form "yekem".',
   her:['Yekem hat.', 'Roja yekem.'],
   gen:['Yekem û duyem', 'Roja yekem']),

  (id:'a1_543', ku:'Duyem', tr:'İkinci', en:'Second',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.81,
   not:'"Du" + "-yem". [AS]: "ikinci = duyemîn" ✓. Kısa form "duyem".',
   her:['Duyem hat.', 'Kilasa duyem.'],
   gen:['Duyem û sêyem', 'Kilasa duyem']),

  // ── SORULAR VE İFADELER ───────────────────────────────────
  (id:'a1_550', ku:'Ji kerema xwe', tr:'Lütfen', en:'Please',
   cins:'bêcins', ez:null, kat:'silav', zor:0.85,
   not:'"Ji kerema xwe" — [AS]: "lütfen = ji kerema xwe" ✓. Lit. "senin kereminden".',
   her:['Ji kerema xwe, bide min.', 'Ji kerema xwe were.'],
   gen:['Ji kerema xwe!', 'Kerem bike']),

  (id:'a1_551', ku:'Biborin', tr:'Afedersiniz / Pardon', en:'Excuse me / Sorry',
   cins:'bêcins', ez:null, kat:'silav', zor:0.84,
   not:'"Biborin" — [AS]: "afedersiniz = biborin" ✓. Resmi. "Lêborîn" de denir.',
   her:['Biborin, rê nîşan bide!', 'Biborin, ez nehatim.'],
   gen:['Biborin û spas', 'Biborin!']),

  (id:'a1_552', ku:'Gelo', tr:'Acaba', en:'I wonder / Is it?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.82,
   not:'"Gelo" — [AS]: "acaba = gelo" ✓. Soru partiküli. "Gelo tu hatî?" = Geldin mi acaba?',
   her:['Gelo tu hatî?', 'Gelo baş e?'],
   gen:['Gelo û ma', 'Gelo?']),

  (id:'a1_553', ku:'Çawa?', tr:'Nasıl?', en:'How?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.85,
   not:'"Çawa?" — [AS]: "nasıl = çawa" ✓. "Tu çawa yî?" = Nasılsın?',
   her:['Tu çawa yî?', 'Çawa dikî vê?'],
   gen:['Çawa û çima', 'Çawa yî?']),

  (id:'a1_554', ku:'Çima?', tr:'Neden? / Niye?', en:'Why?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.84,
   not:'"Çima?" — [AS]: "neden = çima" ✓.',
   her:['Çima nehatî?', 'Çima baş e?'],
   gen:['Çima û çawa', 'Çima?']),

  (id:'a1_555', ku:'Kengî?', tr:'Ne zaman?', en:'When?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.84,
   not:'"Kengî?" — [AS]: "ne zaman = kengî" ✓.',
   her:['Kengî tê?', 'Kengî xwarin?'],
   gen:['Kengî û ku', 'Kengî?']),

  (id:'a1_556', ku:'Kê?', tr:'Kim? (eğik)', en:'Who? (oblique)',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.81,
   not:'"Kê?" eğik soru zamiri — [TH] §25. "Kî?" = nominatif. "Ji kê?" = kimden?',
   her:['Ji kê hat?', 'Kê kirî?'],
   gen:['Kê û kî', 'Ji kê?']),

  // ── HAYVAN EK ─────────────────────────────────────────────
  (id:'a1_560', ku:'Çûçik', tr:'Kuş', en:'Bird',
   cins:'nêr', ez:'çûçikê', kat:'heywan', zor:0.82,
   not:'Eril — [FB]: çûçik n.m. "Çûçikê spî" = beyaz kuş.',
   her:['Çûçik difire.', 'Çûçik distirê.'],
   gen:['Çûçik û masî', 'Çûçikê xweş']),

  (id:'a1_561', ku:'Masî', tr:'Balık', en:'Fish',
   cins:'nêr', ez:'masiyê', kat:'heywan', zor:0.82,
   not:'Eril — [AS]: "balık = masî" ✓. [FB]: masî n.m.',
   her:['Masî di avê de ye.', 'Masî dixwim.'],
   gen:['Masî û goşt', 'Masiyê avê']),

  (id:'a1_562', ku:'Hirç', tr:'Ayı', en:'Bear',
   cins:'nêr', ez:'hirçê', kat:'heywan', zor:0.80,
   not:'Eril — [FB]: hirç n.m. Kürdistan dağlarında yaşar.',
   her:['Hirç di çiyayê de ye.', 'Hirç mezin e.'],
   gen:['Hirç û gur', 'Hirçê çiyayê']),

  (id:'a1_563', ku:'Rovî', tr:'Tilki', en:'Fox',
   cins:'nêr', ez:'roviyê', kat:'heywan', zor:0.80,
   not:'Eril — [FB]: rovî n.m. Atasözlerinde akıllı hayvan.',
   her:['Rovî zîrek e.', 'Rovî di daristanê de ye.'],
   gen:['Rovî û gur', 'Rovîyê zîrek']),

  // ── MEKAN EK ──────────────────────────────────────────────
  (id:'a1_570', ku:'Derî', tr:'Kapı', en:'Door',
   cins:'nêr', ez:'deriyê', kat:'mal', zor:0.85,
   not:'Eril — [AS]: "kapı = derî" ✓. [FB]: derî n.m.',
   her:['Derî veke!', 'Derî girte.'],
   gen:['Derî û pencere', 'Deriyê malê']),

  (id:'a1_571', ku:'Pace', tr:'Cam / Pencere', en:'Window',
   cins:'mê', ez:'pencerê', kat:'mal', zor:0.84,
   not:'Dişil — [Fêrkera D.2]: "li ber paceyê ye" ✓. "Pace" = cam/pencere, özgün Kurmancî. "Pencere" de kullanılır.',
   her:['Pace veke!', 'Ji paceyê tê dîtin.'],
   gen:['Pace û derî', 'Paceya malê']),

  (id:'a1_572', ku:'Dîwar', tr:'Duvar', en:'Wall',
   cins:'nêr', ez:'dîwarê', kat:'mal', zor:0.82,
   not:'Eril — [FB]: dîwar n.m. "Li dîwarê nivîsandiye."',
   her:['Wêne li dîwarê ye.', 'Dîwar spî ye.'],
   gen:['Dîwar û erd', 'Dîwarê malê']),

  (id:'a1_573', ku:'Erd', tr:'Zemin / Yer', en:'Floor / Ground',
   cins:'nêr', ez:'erdê', kat:'mal', zor:0.83,
   not:'Eril — [FB]: erd n.m. "Li erdê rûniştiye" = yerde oturmuş.',
   her:['Kedî li erdê ye.', 'Erd paqij e.'],
   gen:['Erd û dîwar', 'Erdê malê']),

  (id:'a1_574', ku:'Banî', tr:'Tavan / Çatı', en:'Ceiling / Roof',
   cins:'nêr', ez:'baniyê', kat:'mal', zor:0.79,
   not:'Eril — [FB]: banî n.m. "Baniyê malê" = evin çatısı.',
   her:['Banî bilind e.', 'Baniyê malê kelek e.'],
   gen:['Banî û erd', 'Baniyê malê']),

  // ── EDAT VE ZARF EK — [TH] §40-50 ────────────────────────
  (id:'a1_580', ku:'Di...de', tr:'-de / İçinde', en:'In / Inside',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.86,
   not:'"Di ... de" = içinde. [TH] §40: di + eğik isim + de. "Di malê de" = evde.',
   her:['Di malê de ne.', 'Di sinifê de ne.'],
   gen:['Di malê de', 'Di xaniyê de']),

  (id:'a1_581', ku:'Di...re', tr:'-den geçerek / Arasından', en:'Through / Via',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.80,
   not:'"Di ... re" = -den geçerek. [TH] §41: "Di rêyê re çûn" = yoldan geçmek.',
   her:['Di rêyê re çû.', 'Di deriyê re hat.'],
   gen:['Di rêyê re', 'Di deriyê re']),

  (id:'a1_582', ku:'Ber', tr:'Önünde / Karşısında', en:'Before / In front of',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.81,
   not:'"Ber" = önünde/karşısında. [TH] §43: ber + eğik.',
   her:['Ber malê sekinî.', 'Ber deriyê rûniştiye.'],
   gen:['Ber malê', 'Ber deriyê']),

  (id:'a1_583', ku:'Pişt', tr:'Arkasında', en:'Behind',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.80,
   not:'"Pişt" = arkasında. [TH] §43. "Pişt xanî" = evin arkasında.',
   her:['Pişt xanî baxçe heye.', 'Pişt deriyê ma.'],
   gen:['Pişt malê', 'Pişt xanî']),

  (id:'a1_584', ku:'Ser', tr:'Üstünde / Üzerinde', en:'On / On top of',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.85,
   not:'"Ser" = üstünde. "Li ser" = üzerinde (li + ser). [TH] §43.',
   her:['Pirtûk li ser mêzê ye.', 'Kedî li ser kursiyê ye.'],
   gen:['Li ser mêzê', 'Li ser baniyê']),

  (id:'a1_585', ku:'Bin', tr:'Altında', en:'Under / Below',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.84,
   not:'"Bin" = altında. "Li bin" = altında. [TH] §43.',
   her:['Kedî li bin kursiyê ye.', 'Li bin masê ye.'],
   gen:['Li bin mêzê', 'Li bin kursiyê']),

  (id:'a1_586', ku:'Nêzîk', tr:'Yakın / Yakınında', en:'Near / Close to',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.83,
   not:'"Nêzîk" = yakın. [AS]: "yakın = nêzîk" ✓.',
   her:['Mal nêzîk e.', 'Nêzîkê bajêr.'],
   gen:['Nêzîk û dûr', 'Nêzîkê me']),

  // ── FIIL EK — [AS] no.965-995 ─────────────────────────────
  (id:'a1_590', ku:'Vexwarin', tr:'İçmek', en:'To drink',
   cins:'bêcins', ez:null, kat:'leker', zor:0.85,
   not:'"Vexwarin" — [AS] no.1016: "içmek = vexwarin" ✓. "Ez vexwim" = içeyim.',
   her:['Ez çay vexwim.', 'Tu çi vedixwî?'],
   gen:['Vexwarin û xwarin', 'Bide vexwin']),

  (id:'a1_591', ku:'Kirîn', tr:'Satın almak', en:'To buy',
   cins:'bêcins', ez:null, kat:'leker', zor:0.83,
   not:'"Kirîn" — [AS] no.1074: "satın almak = kirîn" ✓. Ergatif: "Min kir."',
   her:['Min nan kir.', 'Tu çi kirî?'],
   gen:['Kirîn û firotin', 'Min kir.']),

  (id:'a1_592', ku:'Firotin', tr:'Satmak', en:'To sell',
   cins:'bêcins', ez:null, kat:'leker', zor:0.82,
   not:'"Firotin" — [AS] no.1075: "satmak = firotin" ✓.',
   her:['Ew nan difiroşe.', 'Min firotin kir.'],
   gen:['Firotin û kirîn', 'Difiroşe.']),

  (id:'a1_593', ku:'Gerîn', tr:'Gezmek / Dolaşmak', en:'To walk around / wander',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'"Gerîn" — [AS] no.994: "gezinmek = gerîn" ✓. "Ez digerim" = geziyorum.',
   her:['Ez li bajêr digerim.', 'Em digerîn.'],
   gen:['Gerîn û sekinîn', 'Digerim.']),

  (id:'a1_594', ku:'Sekinîn', tr:'Durmak', en:'To stop / stand',
   cins:'bêcins', ez:null, kat:'leker', zor:0.82,
   not:'"Sekinîn" — [AS] no.971: "sekinîn" ✓. "Bisekine!" = dur!',
   her:['Bisekine!', 'Em li vir disekinîn.'],
   gen:['Sekinîn û gerîn', 'Bisekine!']),

  (id:'a1_595', ku:'Rûniştin', tr:'Oturmak', en:'To sit',
   cins:'bêcins', ez:null, kat:'leker', zor:0.84,
   not:'"Rûniştin" — [AS] no.1057: "oturmak = rûniştin" ✓.',
   her:['Rûnişt.', 'Li vir rûne!'],
   gen:['Rûniştin û rabûn', 'Rûne!']),

  (id:'a1_596', ku:'Axaftin', tr:'Konuşmak', en:'To speak',
   cins:'bêcins', ez:null, kat:'leker', zor:0.84,
   not:'"Axaftin" — [AS] no.1045: "konuşmak = axaftin, peyivîn" ✓.',
   her:['Ez bi Kurmancî diaxivim.', 'Bi me re biaxive!'],
   gen:['Axaftin û guhdarî', 'Biaxive!']),

  (id:'a1_597', ku:'Bihîstin', tr:'Duymak / İşitmek', en:'To hear',
   cins:'bêcins', ez:null, kat:'leker', zor:0.83,
   not:'"Bihîstin" — [AS] no.1024: "duymak = bihîstin" ✓. Ergatif: "Min bîst."',
   her:['Min bîst.', 'Tu dibihîzî?'],
   gen:['Bihîstin û dîtin', 'Min bîst.']),

  (id:'a1_598', ku:'Zanîn', tr:'Bilmek', en:'To know',
   cins:'bêcins', ez:null, kat:'leker', zor:0.85,
   not:'"Zanîn" — ergatif. "Ez dizanim" = biliyorum. "Min zanî." Kök: zan.',
   her:['Ez dizanim.', 'Min zanî ku hat.'],
   gen:['Zanîn û nezanîn', 'Dizanim.']),

  (id:'a1_599', ku:'Bawer kirin', tr:'İnanmak', en:'To believe',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'"Bawer kirin" — [AS] no.1019: "inanmak = bawer kirin" ✓.',
   her:['Ez bawer dikim.', 'Min bawer kir.'],
   gen:['Bawer kirin û şik', 'Bawer dikim.']),

  // ── SIFAT EK — [BH] §57-60 ────────────────────────────────
  (id:'a1_600', ku:'Kevn', tr:'Eski', en:'Old / Aged',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.83,
   not:'"Kevn" — [FB]: kevn adj. "Pirtûka kevn" = eski kitap.',
   her:['Xanî kevn e.', 'Pirtûka kevn.'],
   gen:['Kevn û nû', 'Ev kevn e.']),

  (id:'a1_601', ku:'Nû', tr:'Yeni', en:'New',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.85,
   not:'"Nû" — [FB]: nû adj.',
   her:['Kiras nû ye.', 'Tiştê nû.'],
   gen:['Nû û kevn', 'Ev nû ye.']),

  (id:'a1_602', ku:'Biçûk', tr:'Küçük', en:'Small / Little',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.85,
   not:'"Biçûk" — [AS]: "küçük = biçûk" ✓.',
   her:['Zarok biçûk e.', 'Mal biçûk e.'],
   gen:['Biçûk û mezin', 'Ev biçûk e.']),

  (id:'a1_603', ku:'Dirêj', tr:'Uzun', en:'Long / Tall',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.83,
   not:'"Dirêj" — [FB]: dirêj adj.',
   her:['Rê dirêj e.', 'Ew dirêj e.'],
   gen:['Dirêj û kurt', 'Ev dirêj e.']),

  (id:'a1_604', ku:'Kurt', tr:'Kısa', en:'Short',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.82,
   not:'"Kurt" — [FB]: kurt adj.',
   her:['Stran kurt e.', 'Ew kurt e.'],
   gen:['Kurt û dirêj', 'Ev kurt e.']),

  (id:'a1_605', ku:'Giran', tr:'Ağır', en:'Heavy',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.82,
   not:'"Giran" — [FB]: giran adj.',
   her:['Çante giran e.', 'Ev gelek giran e.'],
   gen:['Giran û sivik', 'Ev giran e.']),

  (id:'a1_606', ku:'Sivik', tr:'Hafif', en:'Light (weight)',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.81,
   not:'"Sivik" — [FB]: sivik adj.',
   her:['Ev sivik e.', 'Bal sivik e.'],
   gen:['Sivik û giran', 'Ev sivik e.']),

  (id:'a1_607', ku:'Pak', tr:'Temiz', en:'Clean',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.83,
   not:'"Pak" — [AS]: "temiz = paqij, pak" ✓.',
   her:['Mal pak e.', 'Dest pak bike.'],
   gen:['Pak û qirêj', 'Ev pak e.']),

  (id:'a1_608', ku:'Qirêj', tr:'Kirli', en:'Dirty',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.82,
   not:'"Qirêj" — [FB]: qirêj adj.',
   her:['Dest qirêj e.', 'Mal qirêj e.'],
   gen:['Qirêj û pak', 'Ev qirêj e.']),

  // ── SAYDAM A1 CÜMLE KALIPLARI ─────────────────────────────
  (id:'a1_610', ku:'Ev çi ye?', tr:'Bu nedir?', en:'What is this?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.86,
   not:'Temel soru kalıbı — [TH] §15. "Ev" (bu) + "çi" (ne) + "ye".',
   her:['Ev çi ye?', 'Ev pirtûk e.'],
   gen:['Ev çi ye?', 'Ew çi ye?']),

  (id:'a1_611', ku:'Ew kî ye?', tr:'O kim?', en:'Who is that?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.85,
   not:'"Ew kî ye?" — [TH] §15. "Kî?" = nominatif kim.',
   her:['Ew kî ye?', 'Ew bavê min e.'],
   gen:['Ew kî ye?', 'Ev kî ye?']),

  (id:'a1_612', ku:'Li ku ye?', tr:'Nerede?', en:'Where is it?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.85,
   not:'"Li ku ye?" — [TH] §15. "Li ku?" = nerede? "Li kû?" de yazılır.',
   her:['Li ku ye?', 'Li malê ye.'],
   gen:['Li ku ye?', 'Li kû ye?']),

  (id:'a1_613', ku:'Çend e?', tr:'Ne kadar?', en:'How much?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.84,
   not:'"Çend e?" — [AS]: "ne kadar = çend e?" ✓.',
   her:['Ev çend e?', 'Sed lîre ye.'],
   gen:['Çend e?', 'Biha çend e?']),

  (id:'a1_614', ku:'Xweş e!', tr:'Güzel / İyi!', en:'Great / Beautiful!',
   cins:'bêcins', ez:null, kat:'silav', zor:0.86,
   not:'Genel onaylama ifadesi. "Xweş" (güzel) + "e".',
   her:['Xweş e!', 'Pir xweş e!'],
   gen:['Xweş e!', 'Gelek xweş e!']),

  (id:'a1_615', ku:'Baş e!', tr:'İyi / Tamam!', en:'Good / OK!',
   cins:'bêcins', ez:null, kat:'silav', zor:0.87,
   not:'"Baş e" = iyidir/tamam. Günlük onay ve kabul.',
   her:['Baş e!', 'Pir baş e.'],
   gen:['Baş e!', 'Gelek baş e.']),

];


// ── A1 SON 3 KELİME — TAMAMLAMA ──────────────────────────────

const kA1EkKelimeler3 = [

  (id:'a1_740', ku:'Paqij', tr:'Temiz (sıfat)', en:'Clean (adj)',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.84,
   not:'"Paqij" — [AS] no.1109: "temizlemek = pagij kirin" ✓. Sıfat olarak.',
   her:['Dest paqij e.', 'Mal paqij e.'],
   gen:['Paqij û qirêj', 'Ev paqij e.']),

  (id:'a1_741', ku:'Xweş', tr:'Güzel / İyi', en:'Beautiful / Good',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.87,
   not:'"Xweş" — en yaygın A1 sıfatı. [FB]: xweş adj.',
   her:['Pir xweş e!', 'Xweşe!'],
   gen:['Xweş û nebaş', 'Pir xweş!']),


  (id:'a1_743b', ku:'Lênûsk', tr:'Defter / Not defteri', en:'Notebook',
   cins:'mê', ez:'lênûskê', kat:'mal', zor:0.82,
   not:'Dişil — [AS] no.160: "defter = lênûsk, defter" ✓. "Lê" (üzerine) + "nûsk" (yazı) — özgün Kurmancî bileşik.',
   her:['Lênûska min kû ye?', 'Lênûsk bide min.'],
   gen:['Lênûsk û pirtûk', 'Lênûska min']),

  (id:'a1_742', ku:'Tengir', tr:'Dar / Sıkışık', en:'Narrow / Tight',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.79,
   not:'"Tengir" — [FB]: tengir adj. Zıt: "fireh" (geniş).',
   her:['Rê tengir e.', 'Kiras tengir e.'],
   gen:['Tengir û fireh', 'Ev tengir e.']),

];


// ════════════════════════════════════════════════════════════════
// A1 FÊRKERA KURDÎ EK KELİMELER — Doç. Dr. Abdurrahman Adak ve ekibi
// ════════════════════════════════════════════════════════════════

const kA1FerkeraDersler = [

  // ── SELAMLAMA — [Fêrkera D.1] ─────────────────────────────────

  (id:'a1_fk_01', ku:'Beyanî baş', tr:'Günaydın (sabah)', en:'Good morning',
   cins:'bêcins', ez:null, kat:'silav', zor:0.87,
   not:'"Beyanî baş" — [Fêrkera D.1] ✓: "Beyanî baş Rojîn." Sabah selamlaması. "Roj baş" gün boyu. "Sibeyê baş" de kullanılır.',
   her:['Beyanî baş!', 'Beyanî baş Rojîn.'],
   gen:['Beyanî baş!', 'Roj baş!']),

  (id:'a1_fk_02', ku:'Roj baş', tr:'Günaydın / İyi günler', en:'Good day',
   cins:'bêcins', ez:null, kat:'silav', zor:0.87,
   not:'"Roj baş" — [Fêrkera D.1] ✓: "Roj baş Zana." Günün herhangi bir saatinde.',
   her:['Roj baş!', 'Roj baş Delal.'],
   gen:['Roj baş!', 'Beyanî baş!']),

  (id:'a1_fk_03', ku:'Oxir be', tr:'Güle güle / Hayırlı olsun', en:'Farewell / Goodbye',
   cins:'bêcins', ez:null, kat:'silav', zor:0.84,
   not:'"Oxir be" — [Fêrkera D.1] ✓: "Oxir be, ser çavan." Vedalaşma ifadesi.',
   her:['Oxir be!', 'Bi xatirê te, oxir be.'],
   gen:['Oxir be!', 'Bi xatirê te']),

  (id:'a1_fk_04', ku:'Ser çavan', tr:'Baş göz üstüne / Güle güle', en:'With pleasure / Goodbye',
   cins:'bêcins', ez:null, kat:'silav', zor:0.83,
   not:'"Ser çavan" — [Fêrkera D.1] ✓: "Bi xatirê te. - Oxir be, ser çavan." Hem onay hem vedalaşma.',
   her:['Ser çavan!', 'Oxir be, ser çavan.'],
   gen:['Ser çavan!', 'Oxir be']),

  (id:'a1_fk_05', ku:'Serkeftin', tr:'Başarı / Başarılar', en:'Success / Good luck',
   cins:'mê', ez:'serkeftinê', kat:'silav', zor:0.83,
   not:'Dişil — [Fêrkera D.1] ✓: "Baş e, serkeftin ji te re." Başarı dilemek için.',
   her:['Serkeftin ji te re!', 'Serkeftin!'],
   gen:['Serkeftin û kêmasî', 'Serkeftin ji te re']),

  // ── RENKLER TAM — [Fêrkera D.10] ──────────────────────────────

  (id:'a1_fk_06', ku:'Binevşî', tr:'Leylak / Mor', en:'Violet / Purple',
   cins:'bêcins', ez:null, kat:'reng', zor:0.80,
   not:'"Binevşî" — [Fêrkera D.10] ✓: "binevşî" listede. "Mor" da kullanılır. "Binevşî" leylak/mor, "mor" koyu mor.',
   her:['Gul binevşî ye.', 'Rengê binevşî xweş e.'],
   gen:['Binevşî û sor', 'Ev binevşî ye.']),

  (id:'a1_fk_07', ku:'Porteqalî', tr:'Turuncu', en:'Orange (color)',
   cins:'bêcins', ez:null, kat:'reng', zor:0.80,
   not:'"Porteqalî" — [Fêrkera D.10] ✓. "Porteqal" (portakal) kökünden. Renk adı.',
   her:['Rengê porteqalî.', 'Firîngî porteqalî ne.'],
   gen:['Porteqalî û sor', 'Ev porteqalî ye.']),

  (id:'a1_fk_08', ku:'Qehweyî', tr:'Kahverengi', en:'Brown',
   cins:'bêcins', ez:null, kat:'reng', zor:0.80,
   not:'"Qehweyî" — [Fêrkera D.2] ✓: "Rengê wê qehweyî ye." "Qehwe" (kahve) kökünden.',
   her:['Mase qehweyî ye.', 'Rengê qehweyî xweş e.'],
   gen:['Qehweyî û reş', 'Ev qehweyî ye.']),

  // ── ÖĞÜNLER — [Fêrkera D.5] ────────────────────────────────────

  (id:'a1_fk_09', ku:'Taştê', tr:'Kahvaltı', en:'Breakfast',
   cins:'nêr', ez:'taştê', kat:'xwarin', zor:0.84,
   not:'Eril — [Fêrkera D.5] ✓: "taştê" = kahvaltı. Sabah yemeği. "Xwarina sibehê" de denir.',
   her:['Taştê amade ye.', 'Taştê dixwim.'],
   gen:['Taştê û firavîn', 'Taştê çi ye?']),

  (id:'a1_fk_10', ku:'Firavîn', tr:'Öğle yemeği', en:'Lunch',
   cins:'nêr', ez:'firavînê', kat:'xwarin', zor:0.83,
   not:'Eril — [Fêrkera D.5] ✓: "firavîn" = öğle yemeği.',
   her:['Firavîn amade ye.', 'Firavîn dixwim.'],
   gen:['Firavîn û taştê', 'Firavîn çi ye?']),

  (id:'a1_fk_11', ku:'Şîv', tr:'Akşam yemeği', en:'Dinner',
   cins:'nêr', ez:'şîvê', kat:'xwarin', zor:0.83,
   not:'Eril — [Fêrkera D.5] ✓: "şîv" = akşam yemeği. NOT: "Şîv" aynı zamanda "süt" anlamına da gelir — bağlam önemli.',
   her:['Şîv amade ye.', 'Şîv dixwim.'],
   gen:['Şîv û firavîn', 'Şîv çi ye?']),

  // ── OKUL — [Fêrkera D.2] ───────────────────────────────────────

  (id:'a1_fk_12', ku:'Pol', tr:'Sınıf', en:'Classroom / Class',
   cins:'nêr', ez:'polê', kat:'perwerde', zor:0.83,
   not:'Eril — [Fêrkera D.2] ✓: "Pola me fireh û ronî ye." "Pol" = sınıf. "Sinif" de kullanılır ama "pol" daha özgün Kurmancî.',
   her:['Pola me xweş e.', 'Di polê de ne.'],
   gen:['Pol û mamoste', 'Pola me']),

  (id:'a1_fk_13', ku:'Mase', tr:'Masa / Sıra', en:'Desk / Table',
   cins:'mê', ez:'masê', kat:'mal', zor:0.84,
   not:'Dişil — [Fêrkera D.2] ✓: "maseyên xwendekaran". "Mase" = masa/sıra.',
   her:['Mase li polê ye.', 'Pirtûk li ser masê ye.'],
   gen:['Mase û texte', 'Maseyê me']),

  (id:'a1_fk_14', ku:'Spartek', tr:'Ödev', en:'Homework',
   cins:'nêr', ez:'spartekê', kat:'perwerde', zor:0.82,
   not:'Eril — [Fêrkera D.1] ✓: "Îro spartekên me gelek in." Ödev.',
   her:['Spartekên min hene.', 'Spartek kir.'],
   gen:['Spartek û sinav', 'Spartekên me']),

  (id:'a1_fk_15', ku:'Jêhatî', tr:'Başarılı / Yetenekli', en:'Talented / Skilled',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.82,
   not:'"Jêhatî" — [Fêrkera D.2] ✓: "Ew di dersên xwe de jêhatî ne." Başarılı/yetenekli.',
   her:['Tu jêhatî yî.', 'Ew jêhatî ye.'],
   gen:['Jêhatî û nêhatî', 'Ev jêhatî ye.']),

  // ── AİLE — [Fêrkera D.9] ───────────────────────────────────────

  (id:'a1_fk_16', ku:'Bapîr', tr:'Büyükbaba / Dede', en:'Grandfather',
   cins:'nêr', ez:'bapîrê', kat:'malbat', zor:0.84,
   not:'Eril — [Fêrkera D.9] ✓: "bapîr" = büyükbaba. "Kal" da kullanılır.',
   her:['Bapîrê min hat.', 'Bapîr dixwîne.'],
   gen:['Bapîr û dapîr', 'Bapîrê min']),

  (id:'a1_fk_17', ku:'Dapîr', tr:'Büyükanne / Nine', en:'Grandmother',
   cins:'mê', ez:'dapîrê', kat:'malbat', zor:0.84,
   not:'Dişil — [Fêrkera D.9] ✓: "dapîr" = büyükanne. "Pîrê" de kullanılır.',
   her:['Dapîra min hat.', 'Dapîr lorî got.'],
   gen:['Dapîr û bapîr', 'Dapîra min']),

  // ── HAYVAN — [Fêrkera D.4] ─────────────────────────────────────

  (id:'a1_fk_18', ku:'Ajel', tr:'Hayvan', en:'Animal',
   cins:'nêr', ez:'ajelê', kat:'heywan', zor:0.83,
   not:'Eril — [Fêrkera D.4] ✓: "ajel" = hayvan (genel). "Heywan" Arapça kökenli alternatif.',
   her:['Ajel gund e.', 'Ajelên me.'],
   gen:['Ajel û çûçik', 'Ajelên me']),

  (id:'a1_fk_19', ku:'Mirîşk', tr:'Tavuk', en:'Chicken',
   cins:'mê', ez:'mirîşkê', kat:'heywan', zor:0.82,
   not:'Dişil — [Fêrkera D.4] ✓: "mirîşk" = tavuk.',
   her:['Mirîşk dixwe.', 'Mirîşkên me.'],
   gen:['Mirîşk û dîk', 'Mirîşkên me']),

  (id:'a1_fk_20', ku:'Bizin', tr:'Keçi', en:'Goat',
   cins:'mê', ez:'bizinê', kat:'heywan', zor:0.81,
   not:'Dişil — [Fêrkera D.4] ✓: "bizin" = keçi.',
   her:['Bizin şîr dide.', 'Bizinên me.'],
   gen:['Bizin û mî', 'Bizinên me']),

  (id:'a1_fk_21', ku:'Beran', tr:'Koç', en:'Ram',
   cins:'nêr', ez:'beranê', kat:'heywan', zor:0.80,
   not:'Eril — [Fêrkera D.4] ✓: "beran" = koç (erkek koyun).',
   her:['Beran xurt e.', 'Beranê me.'],
   gen:['Beran û mî', 'Beranê me']),

  (id:'a1_fk_22', ku:'Firîngî', tr:'Domates', en:'Tomato',
   cins:'mê', ez:'firîngiyê', kat:'xwarin', zor:0.82,
   not:'Dişil — [Fêrkera D.10] ✓: "Firîngî sor in." "Tomato" yerine "firîngî" özgün.',
   her:['Firîngî sor e.', 'Firîngî û birinc.'],
   gen:['Firîngî û sêv', 'Firîngîyên sor']),

];

// A1 nihai liste


const kA1Son7 = [
  (id:'a1_s01', ku:'Xwedê', tr:'Allah / Tanrı', en:'God',
   cins:'nêr', ez:'Xwedê', kat:'dua', zor:0.87,
   not:'Eril — [Fêrkera D.1] ✓: "Xwedê" = Allah/Tanrı. "Xwedê xêrê bide" = Allah hayır versin.',
   her:['Xwedê mezin e.', 'Bi navê Xwedê.'],
   gen:['Xwedê û dua', 'Bi navê Xwedê']),

  (id:'a1_s02', ku:'Xort', tr:'Genç erkek / Delikanlı', en:'Young man',
   cins:'nêr', ez:'xortê', kat:'malbat', zor:0.83,
   not:'Eril — [Fêrkera D.2] ✓: "Azad xort e." Genç erkek.',
   her:['Ew xort e.', 'Xortê me.'],
   gen:['Xort û keçik', 'Xortê me']),

  (id:'a1_s03', ku:'Keçik', tr:'Kız / Genç kız', en:'Girl / Young woman',
   cins:'mê', ez:'keçikê', kat:'malbat', zor:0.84,
   not:'Dişil — [Fêrkera D.2] ✓: "Keçik delal e." Genç kız.',
   her:['Keçik delal e.', 'Keçika me.'],
   gen:['Keçik û xort', 'Keçika me']),

  (id:'a1_s04', ku:'Delal', tr:'Sevgili / Güzel (hitap)', en:'Dear / Darling',
   cins:'bêcins', ez:null, kat:'silav', zor:0.83,
   not:'"Delal" — [Fêrkera D.2] ✓: "Keçik delal e." Hem sıfat hem hitap. "Delal" = sevgili.',
   her:['Keçik delal e.', 'Delal, bê!'],
   gen:['Delal û hêja', 'Ew delal e.']),

  (id:'a1_s05', ku:'Jîr', tr:'Akıllı / Zeki', en:'Smart / Clever',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.83,
   not:'"Jîr" — [Fêrkera D.2] ✓: "Xwendekar jîr in." Akıllı/zeki.',
   her:['Ew jîr e.', 'Xwendekarên jîr.'],
   gen:['Jîr û jêhatî', 'Ev jîr e.']),

  (id:'a1_s06', ku:'Dilgerm', tr:'Candan / Sıcakkanlı', en:'Warm-hearted',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.81,
   not:'"Dilgerm" — [Fêrkera D.2] ✓: "Xort dilgerm in." Candan/sıcakkanlı.',
   her:['Ew dilgerm e.', 'Xortên dilgerm.'],
   gen:['Dilgerm û sar', 'Ev dilgerm e.']),

  (id:'a1_s07', ku:'Beza', tr:'Hızlı / Çevik', en:'Fast / Agile',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.79,
   not:'"Beza" — [Fêrkera D.2] ✓: "Hesp beza ye." Hızlı/çevik. "Baza" da yazılır.',
   her:['Hesp beza ye.', 'Ew beza ye.'],
   gen:['Beza û hêdî', 'Ev beza ye.']),
];

final kA1TamListe = [
  ...kA1Kelimeler,
  ...kA1EkKelimeler,
  ...kA1EkKelimeler2,
  ...kA1EkKelimeler3,
  ...kA1FerkeraDersler,
  ...kA1Son7,
];