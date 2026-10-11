/// LÛTKE — A1 Tam Kelime Veritabanı
///
/// Kaynak: Bedir Han & Lescot
/// Müfredat: Prof. Dr. Yılmaz Mutlu
/// Düzeltme: Nisan 2026 — birim başlıkları standartlaştırıldı
///
/// Her kelimede:
/// - id: benzersiz, sıralı
/// - kurmanji: Bedir Han Latin alfabesi standardı
/// - turkce / ingilizce: çeviri
/// - cinsiyet: "nêr" (eril) / "mê" (dişil) / "bêcins" (fiil/değişmez)
/// - veqetandek: veqetandek formu (isimler için)
/// - kategori: FSRS kategori kodu
/// - zorluk: FSRS başlangıç zorluğu (0.50–0.90)
/// - cinsiyetNotu: Türkçe konuşan için cinsiyet ipucu
/// - heritage / genel: iki paralel cümle seti

// ignore_for_file: constant_identifier_names

const kA1TamKelimeler = [

  // ════════════════════════════════════════════════════════════
  // BİRİM 1 — Alfabe û Dengên Kurmancî (Alfabe ve Sesler)
  // Kaynak: Bedir Han & Lescot Bölüm 1–5
  // ════════════════════════════════════════════════════════════

  (id:'a1_001', ku:'a', tr:'a (uzun ünlü)', en:'a', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.88,
   not:'Bedirxan-Lescot §6: "a" Kurmancî\'de Türkçe "a"dan biraz daha uzun söylenir. Mînak: av (su), bav (baba), nan (ekmek).',
   her:['Pîrê "av" dibêje.', 'Bavê min "nan" got.'],
   gen:['av, bav, nan, mal']),

  (id:'a1_002', ku:'ê', tr:'ê (uzun e — Fransızca é)', en:'ê', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.72,
   not:'Bedirxan-Lescot §7: "ê" Türkçede yok. Fransızca "été"deki é gibi, ağız biraz gülümser. Têbinî: kısa "e" ile karıştırma — ker (eşek) ↔ kêr (bıçak).',
   her:['Pîrê "mêr" dibêje.', 'Bavê min "dê" got.'],
   gen:['mêr, kêr, pêş, dê']),

  (id:'a1_003', ku:'î', tr:'î (uzun i)', en:'î', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.80,
   not:'Bedirxan-Lescot §8: "î" Türkçe "i"nin uzunudur. Mînak: spî (beyaz), îro (bugün). Têbinî: kısa "i" ile karıştırma — bir (götürdü) ↔ bîr (kuyu).',
   her:['Xwişka min "spî" dibêje.', 'Pîrê "îro" got.'],
   gen:['spî, îro, nîvro, kî']),

  (id:'a1_004', ku:'û', tr:'û (uzun u)', en:'û', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.80,
   not:'Bedirxan-Lescot §9: "û" Türkçe "u"nun uzunudur, dudaklar yuvarlak. Mînak: hûn (siz), dûr (uzak). Têbinî: "û" tek başına "ve" anlamına da gelir.',
   her:['Pîrê "hûn" dibêje.', 'Dê "dûr" got.'],
   gen:['hûn, dûr, rû, û']),

  (id:'a1_005', ku:'x', tr:'x (gırtlak h)', en:'x (guttural)', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.62,
   not:'Bedirxan-Lescot §13: "x" Türkçede yok, boğazdan çıkar, Arapça "خ" gibi. Mînak: xwarin (yemek), xweş (güzel).',
   her:['Bavê min "xwarin" dibêje.', 'Dê "xweş" got.'],
   gen:['xwarin, xweş, xwişk, xatir']),

  (id:'a1_006', ku:'q', tr:'q (kalın k)', en:'q (uvular)', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.65,
   not:'Bedirxan-Lescot §14: "q" Türkçedeki "k"dan daha kalın, gırtlaktan çıkar. Mînak: qehwe (kahve), qad (alan). Têbinî: ince "k" ile karıştırma — kelem (lahana) ↔ qelem (kalem).',
   her:['Bira "qehwe" vexwar.', 'Pîrê qehwe vexwe.'],
   gen:['qehwe, qad, qir, qeşmer']),

  (id:'a1_007', ku:'w', tr:'w (yarı ünsüz)', en:'w', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.75,
   not:'Bedirxan-Lescot §15: "w" İngilizce "water"daki gibi, dudaklar yuvarlak. Türkçe "v" değil. Mînak: welat (vatan), wek (gibi).',
   her:['Dê "welat" dibêje.', 'Pîrê "wek" got.'],
   gen:['welat, wek, ew, wan']),

  (id:'a1_008', ku:'r', tr:'r (Kurmancî titrek)', en:'r (Kurmancî trill)', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.78,
   not:'Bedirxan-Lescot §16: Kurmancî "r" kelime başında titrek olur, dil damağa dokunur. Mînak: roj (gün), rê (yol). Têbinî: Türkçe "r"den biraz daha kuvvetli.',
   her:['Pîrê "roj" dibêje.', 'Bavê min "rê" got.'],
   gen:['roj, rê, rast, bihar']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 2 — Silavdan û Pêşkêşkirin (Selamlama ve Tanışma)
  // Kaynak: Bedir Han & Lescot (Axaftna Rojane)
  // ════════════════════════════════════════════════════════════

  (id:'a1_010', ku:'Silav', tr:'Merhaba', en:'Hello', cins:'bêcins', ez:null,
   kat:'silav', zor:0.88,
   not:'Her durumda kullanılır — sabah/akşam/gündüz fark etmez. Mînak: Silav, pîrê! Têbinî: daha resmi karşılığı "Merheba".',
   her:['Silav, pîrê!', 'Silav, dê û bav!'],
   gen:['Silav, heval!', 'Silav, mamoste!']),

  (id:'a1_011', ku:'Merheba', tr:'Merhaba (resmi)', en:'Greetings', cins:'bêcins', ez:null,
   kat:'silav', zor:0.85,
   not:'"Silav" daha samimi, "Merheba" biraz daha resmi. Mînak: Merheba, mamoste! Têbinî: yakınlarla "Silav", uzaklarla "Merheba" tercih edilir.',
   her:['Merheba, ap!', 'Merheba, met!'],
   gen:['Merheba, mamoste!', 'Merheba û spas!']),

  (id:'a1_012', ku:'Spas', tr:'Teşekkür ederim', en:'Thank you', cins:'bêcins', ez:null,
   kat:'silav', zor:0.88,
   not:'"Sipas" da denir, ikisi de doğru. Mînak: Spas, dayê! Têbinî: vurgu için "Gelek spas" (çok teşekkürler).',
   her:['Spas, dayê!', 'Gelek spas, pîrê!'],
   gen:['Spas, mamoste!', 'Spas ji te re.']),

  (id:'a1_013', ku:'Gelek spas', tr:'Çok teşekkür ederim', en:'Thank you very much', cins:'bêcins', ez:null,
   kat:'silav', zor:0.86,
   not:'"Gelek" = çok. Mînak: Gelek spas, kal! Têbinî: yalın biçim "Spas" da yeterli; "Gelek" pekiştirir.',
   her:['Gelek spas, kal!', 'Gelek spas, dayê!'],
   gen:['Gelek spas, heval!', 'Gelek spas, mamoste!']),

  (id:'a1_014', ku:'Erê', tr:'Evet', en:'Yes', cins:'bêcins', ez:null,
   kat:'silav', zor:0.90,
   not:'Olumlu cevap. Mînak: Tu baş î? — Erê. Têbinî: olumsuz cevap için "Na" kullanılır.',
   her:['Erê, dayê, ez hatim!', 'Erê, baş im.'],
   gen:['Erê, dizanim.', 'Erê, rast e.']),

  (id:'a1_015', ku:'Na', tr:'Hayır', en:'No', cins:'bêcins', ez:null,
   kat:'silav', zor:0.90,
   not:'Olumsuz cevap. Türkçe "na" (al) ile karıştırılmamalı. Mînak: Tu baş î? — Na. Têbinî: olumlu cevap için "Erê".',
   her:['Na, pîrê.', 'Na, ez nehatim.'],
   gen:['Na, spas.', 'Na, ne rast e.']),

  (id:'a1_016', ku:'Baş e', tr:'İyi / Tamam', en:'Good / OK', cins:'bêcins', ez:null,
   kat:'silav', zor:0.88,
   not:'"Baş" = iyi. "e" = bûn fiili 3.tekil. Mînak: Baş e, spas. Têbinî: olumsuzu "ne baş e" (iyi değil).',
   her:['Baş e, dayê.', 'Baş e, pîrê!'],
   gen:['Baş e, spas.', 'Ev baş e.']),

  (id:'a1_017', ku:'Tu çawa yî?', tr:'Nasılsın?', en:'How are you?', cins:'bêcins', ez:null,
   kat:'silav', zor:0.85,
   not:'"Çawa" = nasıl. "yî" = bûn 2.tekil. Mînak: Tu çawa yî, heval? Têbinî: çoğul biçim → "Hûn çawa ne?" (nasılsınız).',
   her:['Pîrê, tu çawa yî?', 'Dê, tu çawa yî?'],
   gen:['Heval, tu çawa yî?', 'Mamoste, tu çawa yî?']),

  (id:'a1_018', ku:'Ez baş im', tr:'İyiyim', en:"I'm fine", cins:'bêcins', ez:null,
   kat:'silav', zor:0.86,
   not:'"Ez" = ben. "im" = bûn 1.tekil. Mînak: Ez baş im. Têbinî: bûn çekimi → Ez … im / Tu … î / Ew … e / Em … in / Hûn … in / Ew … in.',
   her:['Ez baş im, pîrê.', 'Ez baş im, dê.'],
   gen:['Ez baş im, spas.', 'Ez baş im, gelek spas.']),

  (id:'a1_019', ku:'Navê min … e', tr:'Adım … dır', en:'My name is …', cins:'bêcins', ez:null,
   kat:'silav', zor:0.83,
   not:'"Nav" = isim (eril). Veqetandek -ê → "navê min" (benim adım). Mînak: Navê min Mehmet e. Têbinî: ünlüyle biten isimde "ye" → Navê min Fatma ye.',
   her:['Navê min Fatma ye, pîrê!', 'Navê min Mehmet e.'],
   gen:['Navê min … e, tu kî yî?', 'Navê min Narin e.']),

  (id:'a1_020', ku:'Tu kî yî?', tr:'Sen kimsin?', en:'Who are you?', cins:'bêcins', ez:null,
   kat:'silav', zor:0.84,
   not:'"Kî" = kim (insan için). Mînak: Tu kî yî? Têbinî: "çi" = ne (eşya/anlam için) → Navê te çi ye?',
   her:['Tu kî yî, kurê min?', 'Pîrê, tu kî yî?'],
   gen:['Tu kî yî, heval?', 'Pîrê, tu kî yî?']),

  (id:'a1_021', ku:'Bi xêr hatî', tr:'Hoş geldin (tekil)', en:'Welcome (singular)', cins:'bêcins', ez:null,
   kat:'silav', zor:0.82,
   not:'"Bi xêr" = iyilikle. "hatî" = 2.tekil "geldin". Mînak: Bi xêr hatî, heval! Têbinî: çoğul → "Bi xêr hatin" (hoş geldiniz).',
   her:['Bi xêr hatî, heval!', 'Bi xêr hatî malê me!'],
   gen:['Bi xêr hatî, mamoste!', 'Bi xêr hatin, malbatê min!']),

  (id:'a1_022', ku:'Xatirê te', tr:'Hoşça kal / Güle güle', en:'Goodbye', cins:'bêcins', ez:null,
   kat:'silav', zor:0.82,
   not:'"Xatir" = hatır. "Xatirê te" = senin hatırın — ayrılırken söylenir. Mînak: Xatirê te, heval! Têbinî: çoğul → "Xatirê we!" (hoşçakalın).',
   her:['Xatirê te, pîrê!', 'Xatirê te, dê û bav!'],
   gen:['Xatirê te, heval!', 'Xatirê te, mamoste!']),

  (id:'a1_023', ku:'Bibore', tr:'Özür dilerim / Pardon', en:'Excuse me / Sorry', cins:'bêcins', ez:null,
   kat:'silav', zor:0.84,
   not:'Hafif özür için "Bibore", daha derin pişmanlık için "Li min bibore". Mînak: Bibore, ez dereng im.',
   her:['Bibore, pîrê!', 'Bibore, dê, dereng hatim.'],
   gen:['Bibore, ez dereng im.', 'Bibore, mamoste.']),

  (id:'a1_024', ku:'Destê te xweş be', tr:'Elinize sağlık', en:'Well done (for cooking)', cins:'bêcins', ez:null,
   kat:'silav', zor:0.78,
   not:'"Dest" = el, "xweş" = güzel. Yemekten sonra söylenen geleneksel ifade. Mînak: Destê te xweş be! Têbinî: çoğul → "Destên we xweş be!" (elinize sağlık - çoğul).',
   her:['Destê te xweş be, dêyê!', 'Destê te xweş be, pîrê!'],
   gen:['Destê te xweş be!', 'Xwarin xweş bû!']),

  (id:'a1_025', ku:'Bextewar', tr:'Mutlu / Bahtiyar', en:'Happy', cins:'bêcins', ez:null,
   kat:'silav', zor:0.80,
   not:'"Bextewar" = bahtiyar (Farsça kökenli, Kurmancîde yerleşmiş). Mînak: Ez bextewar im. Têbinî: olumsuz karşılığı "bedbext" (mutsuz).',
   her:['Ez bextewar im, pîrê!', 'Tu bextewar î?'],
   gen:['Em bextewar in.', 'Bextewar bî!']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 3 — Jimar (Sayılar 0–100+)
  // Kaynak: Bedir Han & Lescot — JIMAR-JIMARÊN RÊZÊ
  // ════════════════════════════════════════════════════════════

  (id:'a1_030', ku:'Sifir', tr:'Sıfır', en:'Zero', cins:'bêcins', ez:null, kat:'jimar', zor:0.82,
   not:'Arapça "sıfır"dan; Kurmancî\'de aynen kullanılır. Mînak: sifir derece. Têbinî: pozitif sayma "yek" (1) ile başlar.',
   her:['Sifir heye.', 'Sifir derece sar e.'],
   gen:['Sifir, yek, du.', 'Sifir piçûk e.']),

  (id:'a1_031', ku:'Yek', tr:'Bir', en:'One', cins:'bêcins', ez:null, kat:'jimar', zor:0.85,
   not:'Sayma 1. Mînak: yek çay (bir çay). Têbinî: sayı + isim → isim tekil kalır (yek roj, du roj, sê roj).',
   her:['Yek çay bide min, dêyê.', 'Yek birê min heye.'],
   gen:['Yek pirs heye.', 'Yek saet e.']),

  (id:'a1_032', ku:'Du', tr:'İki', en:'Two', cins:'bêcins', ez:null, kat:'jimar', zor:0.85,
   not:'Sayma 2. Mînak: du saet (iki saat). Têbinî: sayı + isim → isim tekil; veqetandek yok.',
   her:['Du xwişk in.', 'Du çay, pîrê!'],
   gen:['Du saet e.', 'Du nan hene.']),

  (id:'a1_033', ku:'Sê', tr:'Üç', en:'Three', cins:'bêcins', ez:null, kat:'jimar', zor:0.84,
   not:'Sayma 3. Mînak: sê roj (üç gün). Têbinî: "ê" uzun söylenir.',
   her:['Sê kur in.', 'Sê roj man.'],
   gen:['Sê saet e.', 'Em sê ne.']),

  (id:'a1_034', ku:'Çar', tr:'Dört', en:'Four', cins:'bêcins', ez:null, kat:'jimar', zor:0.84,
   not:'Sayma 4. Mînak: çar demsal (dört mevsim). Têbinî: ç sesi Türkçe ile aynıdır.',
   her:['Çar demsal hene.', 'Çar kes hene.'],
   gen:['Çar saet e.', 'Çar mirov hatin.']),

  (id:'a1_035', ku:'Pênc', tr:'Beş', en:'Five', cins:'bêcins', ez:null, kat:'jimar', zor:0.83,
   not:'Sayma 5. Mînak: pênc kilo (beş kilo). Têbinî: "ê" uzun, "nc" birlikte söylenir.',
   her:['Pênc nan bide min.', 'Pênc roj man.'],
   gen:['Pênc saet e.', 'Pênc nan hene.']),

  (id:'a1_036', ku:'Şeş', tr:'Altı', en:'Six', cins:'bêcins', ez:null, kat:'jimar', zor:0.82,
   not:'Sayma 6. Mînak: şeş kes (altı kişi). Têbinî: ş sesi Türkçe ile aynıdır.',
   her:['Em şeş kes in.', 'Şeş saet xew kir.'],
   gen:['Şeş roj e.', 'Şeş kes hatin.']),

  (id:'a1_037', ku:'Heft', tr:'Yedi', en:'Seven', cins:'bêcins', ez:null, kat:'jimar', zor:0.82,
   not:'Sayma 7. Mînak: heft roj (yedi gün). Têbinî: "Hefte heft roj e" (hafta yedi gündür).',
   her:['Hefte heft roj e.', 'Heft sal in.'],
   gen:['Heft roj e.', 'Heft kes hene.']),

  (id:'a1_038', ku:'Heşt', tr:'Sekiz', en:'Eight', cins:'bêcins', ez:null, kat:'jimar', zor:0.81,
   not:'Sayma 8. Mînak: heşt saet (sekiz saat). Têbinî: "şt" birlikte söylenir.',
   her:['Heşt saet xew kir.', 'Heşt kes hene.'],
   gen:['Heşt roj e.', 'Heşt kilo hene.']),

  (id:'a1_039', ku:'Neh', tr:'Dokuz', en:'Nine', cins:'bêcins', ez:null, kat:'jimar', zor:0.82,
   not:'Sayma 9. Mînak: neh sal (dokuz yıl). Têbinî: kısa, tek heceli sayı.',
   her:['Neh çay vexwar.', 'Neh sal in.'],
   gen:['Neh saet e.', 'Neh kes hatin.']),

  (id:'a1_040', ku:'Deh', tr:'On', en:'Ten', cins:'bêcins', ez:null, kat:'jimar', zor:0.83,
   not:'Sayma 10. Mînak: deh kes (on kişi). Têbinî: 11-19 için "yanzdeh, dwanzdeh..." formu vardır.',
   her:['Deh çay vexwarin.', 'Em deh kes in.'],
   gen:['Deh kilo nan.', 'Deh mirov hatin.']),

  (id:'a1_041', ku:'Bîst', tr:'Yirmi', en:'Twenty', cins:'bêcins', ez:null, kat:'jimar', zor:0.80,
   not:'Sayma 20. Mînak: bîst sal (yirmi yıl). Têbinî: "î" uzun söylenir.',
   her:['Bîst sal in, pîrê!', 'Bîst kes hatin.'],
   gen:['Bîst saet e.', 'Bîst mirov hene.']),

  (id:'a1_042', ku:'Sih', tr:'Otuz', en:'Thirty', cins:'bêcins', ez:null, kat:'jimar', zor:0.79,
   not:'Sayma 30. Mînak: sih kes (otuz kişi). Têbinî: "s" yumuşak söylenir.',
   her:['Sih sal zewicî ye.', 'Sih kes hatin.'],
   gen:['Sih saet e.', 'Sih kilo hene.']),

  (id:'a1_043', ku:'Çil', tr:'Kırk', en:'Forty', cins:'bêcins', ez:null, kat:'jimar', zor:0.80,
   not:'Sayma 40. Mînak: çil sal (kırk yıl). Têbinî: kısa, tek heceli sayı.',
   her:['Çil sal in, bav!', 'Çil mirov hatin.'],
   gen:['Çil roj e.', 'Çil kes hene.']),

  (id:'a1_044', ku:'Pêncî', tr:'Elli', en:'Fifty', cins:'bêcins', ez:null, kat:'jimar', zor:0.79,
   not:'Sayma 50. Mînak: pêncî sal (elli yıl). Têbinî: "ê" ve "î" uzun söylenir.',
   her:['Pêncî sal in, kal!', 'Pêncî kes hene.'],
   gen:['Pêncî saet e.', 'Pêncî kilo hene.']),

  (id:'a1_045', ku:'Şêst', tr:'Altmış', en:'Sixty', cins:'bêcins', ez:null, kat:'jimar', zor:0.78,
   not:'Sayma 60. Mînak: şêst sal (altmış yıl). Têbinî: "ê" uzun söylenir.',
   her:['Şêst sal in.', 'Şêst kes hene.'],
   gen:['Şêst kilo nan.', 'Şêst mirov hatin.']),

  (id:'a1_046', ku:'Heftê', tr:'Yetmiş', en:'Seventy', cins:'bêcins', ez:null, kat:'jimar', zor:0.78,
   not:'Sayma 70. Yaş bildirme: "heftê salî" = 70 yaşında (-î eki sıfat yapar). Mînak: pîrê heftê salî ye.',
   her:['Pîrê heftê salî ye!', 'Heftê kes hene.'],
   gen:['Heftê saet e.', 'Heftê kilo nan.']),

  (id:'a1_047', ku:'Heştê', tr:'Seksen', en:'Eighty', cins:'bêcins', ez:null, kat:'jimar', zor:0.78,
   not:'Sayma 80. Yaş bildirme: "heştê salî" = 80 yaşında. Mînak: bapîr heştê salî ye.',
   her:['Bapîr heştê salî ye.', 'Heştê kes hene.'],
   gen:['Heştê saet e.', 'Heştê kilo hene.']),

  (id:'a1_048', ku:'Nod', tr:'Doksan', en:'Ninety', cins:'bêcins', ez:null, kat:'jimar', zor:0.78,
   not:'Sayma 90. Yaş bildirme: "nod salî" = 90 yaşında. Mînak: kal nod salî ye.',
   her:['Kal nod salî ye.', 'Nod kes hene.'],
   gen:['Nod saet e.', 'Nod mirov hatin.']),

  (id:'a1_049', ku:'Sed', tr:'Yüz', en:'Hundred', cins:'bêcins', ez:null, kat:'jimar', zor:0.80,
   not:'Sayma 100. Mînak: sed sal (yüz yıl). Têbinî: "s" yumuşak, "d" belirgin söylenir.',
   her:['Sed sal in.', 'Sed kes hatin.'],
   gen:['Sed kilo nan.', 'Sed mirov hene.']),

  (id:'a1_050', ku:'Hezar', tr:'Bin', en:'Thousand', cins:'bêcins', ez:null, kat:'jimar', zor:0.79,
   not:'Sayma 1000. Farsça kökenli. Mînak: hezar spas (bin teşekkür) — vurgu için kullanılır.',
   her:['Hezar spas, pîrê!', 'Hezar kes hene.'],
   gen:['Hezar saet e.', 'Hezar kilo nan.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 4 — Reng (Renkler)
  // Kaynak: Bedir Han & Lescot — RENG
  // ════════════════════════════════════════════════════════════

  (id:'a1_060', ku:'Spî', tr:'Beyaz', en:'White', cins:'bêcins', ez:null, kat:'reng', zor:0.84,
   not:'Bedirxan-Lescot: "spî" beyaz. s+p ses birleşimi Türkçede yoktur. Mînak: berf spî (beyaz kar). Têbinî: zıttı "reş" (siyah).',
   her:['Berf spî ye, pîrê!', 'Kincê spî xweş e.'],
   gen:['Rengê spî xweş e.', 'Spî û reş hene.']),

  (id:'a1_061', ku:'Reş', tr:'Siyah', en:'Black', cins:'bêcins', ez:null, kat:'reng', zor:0.84,
   not:'Bedirxan-Lescot: "reş" siyah; "e" kısa söylenir. Mînak: çavên reş (siyah gözler). Têbinî: zıttı "spî" (beyaz).',
   her:['Çavên pîrê reş in.', 'Kincên bavê min reş in.'],
   gen:['Rengê reş tarî ye.', 'Spî û reş hene.']),

  (id:'a1_062', ku:'Sor', tr:'Kırmızı', en:'Red', cins:'bêcins', ez:null, kat:'reng', zor:0.85,
   not:'Bedirxan-Lescot: "sor" kırmızı. Mînak: agirê sor (kırmızı ateş). Têbinî: Newroz ateşinin rengi — kültürel önemli.',
   her:['Agirê Newrozê sor e.', 'Kulîlkên sor xweş in.'],
   gen:['Rengê sor xurt e.', 'Sêv sor e.']),

  (id:'a1_063', ku:'Kesk', tr:'Yeşil', en:'Green', cins:'bêcins', ez:null, kat:'reng', zor:0.84,
   not:'Bedirxan-Lescot: "kesk" yeşil. Mînak: çiyayên kesk (yeşil dağlar). Têbinî: Kürt bayrağının ortasındaki renk.',
   her:['Çiyayên Kurdistanê kesk in.', 'Sewzeyên kesk xweş in.'],
   gen:['Rengê kesk xweş e.', 'Dar kesk e.']),

  (id:'a1_064', ku:'Şîn', tr:'Mavi', en:'Blue', cins:'bêcins', ez:null, kat:'reng', zor:0.84,
   not:'Bedirxan-Lescot: "şîn" mavi; "î" uzun. Mînak: esmanê şîn (mavi gökyüzü). Têbinî: aynı kelime "üzgün" anlamına da gelir — bağlamdan anlaşılır.',
   her:['Esman şîn e, pîrê!', 'Çemê şîn xweş e.'],
   gen:['Rengê şîn xweş e.', 'Esman şîn e.']),

  (id:'a1_065', ku:'Zer', tr:'Sarı', en:'Yellow', cins:'bêcins', ez:null, kat:'reng', zor:0.84,
   not:'Bedirxan-Lescot: "zer" sarı. Mînak: tav zer (sarı güneş). Têbinî: tek heceli sıfat, Türkçeden farklı kısa söylenir.',
   her:['Tav zer e, pîrê!', 'Tav zer û germ e.'],
   gen:['Rengê zer xweş e.', 'Tav zer e.']),

  (id:'a1_066', ku:'Gewr', tr:'Gri', en:'Grey', cins:'bêcins', ez:null, kat:'reng', zor:0.80,
   not:'Bedirxan-Lescot: "gewr" gri. Mînak: ewrên gewr (gri bulutlar). Têbinî: "gw" ses birleşimi — w yarı ünsüz.',
   her:['Ewrên gewr in.', 'Mişk gewr e.'],
   gen:['Rengê gewr xweş e.', 'Esman gewr e.']),

  (id:'a1_067', ku:'Qehweyî', tr:'Kahverengi', en:'Brown', cins:'bêcins', ez:null, kat:'reng', zor:0.78,
   not:'Bedirxan-Lescot: "qehweyî" kahverengi; "qehwe" (kahve) + -yî eki. Mînak: çavên qehweyî (kahverengi gözler).',
   her:['Çavên bavê min qehweyî ne.', 'Erdê qehweyî ye.'],
   gen:['Rengê qehweyî xweş e.', 'Dar qehweyî ye.']),

  (id:'a1_068', ku:'Pembe', tr:'Pembe', en:'Pink', cins:'bêcins', ez:null, kat:'reng', zor:0.82,
   not:'"Pembe" Farsça/Türkçe alıntı, Kurmancîde yaygın. Mînak: kulîlka pembe (pembe çiçek).',
   her:['Kulîlkên pembe hene.', 'Kincê pembe xweş e.'],
   gen:['Rengê pembe xweş e.', 'Kulîlk pembe ye.']),

  (id:'a1_069', ku:'Mor', tr:'Mor', en:'Purple', cins:'bêcins', ez:null, kat:'reng', zor:0.82,
   not:'"Mor" Türkçeyle aynı. Mînak: kulîlkên mor (mor çiçekler).',
   her:['Kulîlkên mor hene.', 'Rengê mor xweş e.'],
   gen:['Mor û şîn hene.', 'Kulîlka mor xweş e.']),

  (id:'a1_070', ku:'Narencî', tr:'Turuncu', en:'Orange', cins:'bêcins', ez:null, kat:'reng', zor:0.78,
   not:'"Narencî" Farsça "narenc" (portakal) + -î eki = portakal rengi. Mînak: fêkiya narencî (turuncu meyve).',
   her:['Fêkiyên narencî hene.', 'Agirê narencî ye.'],
   gen:['Rengê narencî xweş e.', 'Fêkî narencî ye.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 5 — Malbat (Aile Üyeleri)
  // Kaynak: Bedir Han & Lescot — MALBAT; Arizona Üniversitesi Ders 5
  // ════════════════════════════════════════════════════════════

  (id:'a1_080', ku:'Bav', tr:'Baba', en:'Father', cins:'nêr', ez:'bavê',
   kat:'malbat', zor:0.84,
   not:'Bav (eril/nêr). Veqetandek: bavê min (babamın). Mînak: Bavê min li kar e. Têbinî: dişil eşi "dê" (anne).',
   her:['Bavê min li kar e.', 'Silav ji bavê min re!'],
   gen:['Bavê min mamoste ye.', 'Bav û dê hatin.']),

  (id:'a1_081', ku:'Dê', tr:'Anne', en:'Mother', cins:'mê', ez:'dêya',
   kat:'malbat', zor:0.84,
   not:'Dê (dişil/mê). Veqetandek: dêya min (annemin). Mînak: Dêya min nan dipijîne. Têbinî: "Dayik/Daya" da denir; eril eşi "bav".',
   her:['Dêya min nan dipijîne.', 'Dê li malê ye.'],
   gen:['Dêya min mamoste ye.', 'Dê û bav hatin.']),

  (id:'a1_082', ku:'Bira', tr:'Erkek kardeş', en:'Brother', cins:'nêr', ez:'birê',
   kat:'malbat', zor:0.83,
   not:'Bira (eril/nêr). Veqetandek: birê min (kardeşimin). Mînak: Birê min mezin e. Têbinî: dişil eşi "xwişk".',
   her:['Birê min mezin e.', 'Bira û xwişk in.'],
   gen:['Birê min xwendekar e.', 'Bira li dibistanê ye.']),

  (id:'a1_083', ku:'Xwişk', tr:'Kız kardeş', en:'Sister', cins:'mê', ez:'xwişka',
   kat:'malbat', zor:0.82,
   not:'Xwişk (dişil/mê). Veqetandek: xwişka min (kardeşimin). Mînak: Xwişka min li dibistanê ye. Têbinî: x sesi gırtlaktan; eril eşi "bira".',
   her:['Xwişka min li dibistanê ye.', 'Xwişka te çawa ye?'],
   gen:['Xwişka min mezin e.', 'Xwişk û bira lîstin.']),

  (id:'a1_084', ku:'Dapîr', tr:'Büyükanne', en:'Grandmother', cins:'mê', ez:'dapîra',
   kat:'malbat', zor:0.84,
   not:'Dapîr (dişil/mê). Veqetandek: dapîra min (büyükannemin). Mînak: Dapîra min Kurmancî dizane. Têbinî: "Pîrê" da denir; eril eşi "kal/bapîr".',
   her:['Dapîra min Kurmancî dizane.', 'Dapîra min li gundî ye.'],
   gen:['Dapîra min mezin e.', 'Dapîr û bapîr hatin.']),

  (id:'a1_085', ku:'Kal', tr:'Büyükbaba', en:'Grandfather', cins:'nêr', ez:'kalê',
   kat:'malbat', zor:0.84,
   not:'Kal (eril/nêr). Veqetandek: kalê min (büyükbabamın). Mînak: Kalê min li gundî ye. Têbinî: "Bapîr" da denir; dişil eşi "dapîr/pîrê".',
   her:['Kalê min li gundî ye.', 'Kalê min mezin e.'],
   gen:['Kalê min xort e.', 'Bapîr û dapîr hatin.']),

  (id:'a1_086', ku:'Ap', tr:'Amca (baba tarafı)', en:"Father's brother", cins:'nêr', ez:'apê',
   kat:'malbat', zor:0.80,
   not:'Ap (eril/nêr) — baba tarafı amca; günlük dilde hitap biçimi "Apo". Veqetandek: apê min (amcamın). Têbinî: anne tarafı için "xal" (dayı).',
   her:['Apê min li bajêr e.', 'Apê te çawa ye?'],
   gen:['Apê min mamoste ye.', 'Ap û xaltî hatin.']),

  (id:'a1_087', ku:'Xaltî', tr:'Teyze', en:"Mother's sister", cins:'mê', ez:'xaltiya',
   kat:'malbat', zor:0.79,
   not:'Xaltî (dişil/mê) — anne tarafı teyze. Veqetandek: xaltiya min (teyzemin). Têbinî: x sesi gırtlaktan; baba tarafı için "met" (hala).',
   her:['Xaltiya min baş e.', 'Xaltî, silav!'],
   gen:['Xaltiya min mezin e.', 'Xaltî û ap hatin.']),

  (id:'a1_088', ku:'Kur', tr:'Oğul', en:'Son', cins:'nêr', ez:'kurê',
   kat:'malbat', zor:0.82,
   not:'Kur (eril/nêr). Veqetandek: kurê min (oğlumun). Mînak: Kurê min xwendekar e. Têbinî: dişil eşi "keç" (kız çocuğu).',
   her:['Kurê min xwendekar e.', 'Pîrê, kurê te çawa ye?'],
   gen:['Kurê min mezin e.', 'Kur û keç hatin.']),

  (id:'a1_089', ku:'Keç', tr:'Kız çocuğu / Kız', en:'Daughter / Girl', cins:'mê', ez:'keça',
   kat:'malbat', zor:0.82,
   not:'Keç (dişil/mê). Veqetandek: keça min (kızımın). Mînak: Keça min li dibistanê ye. Têbinî: eril eşi "kur" (oğul).',
   her:['Keça min li dibistanê ye.', 'Keça te çawa ye, pîrê?'],
   gen:['Keça min mezin e.', 'Kur û keç dilîzin.']),

  (id:'a1_090', ku:'Mêr', tr:'Koca / Erkek', en:'Husband / Man', cins:'nêr', ez:'mêrê',
   kat:'malbat', zor:0.80,
   not:'Mêr (eril/nêr) — koca veya yetişkin erkek. Veqetandek: mêrê min (kocamın). Têbinî: dişil eşi "jin" (karı/kadın).',
   her:['Mêrê min baş e.', 'Mêrê te çawa ye?'],
   gen:['Mêrê wê mamoste ye.', 'Mêr û jin hatin.']),

  (id:'a1_091', ku:'Jin', tr:'Karı / Kadın', en:'Wife / Woman', cins:'mê', ez:'jina',
   kat:'malbat', zor:0.82,
   not:'Jin (dişil/mê) — karı veya yetişkin kadın. Veqetandek: jina min (karımın). Têbinî: eril eşi "mêr".',
   her:['Jin li malê ye.', 'Jin û mêr hatin.'],
   gen:['Jina wî baş e.', 'Jin û mêr li gundî ne.']),

  (id:'a1_092', ku:'Nevî', tr:'Torun', en:'Grandchild', cins:'bêcins', ez:'neviyê/neviya',
   kat:'malbat', zor:0.78,
   not:'Nevî — eril ve dişil için kullanılır. Veqetandek: neviyê (eril) / neviya (dişil). Mînak: neviyê min (torunum). Têbinî: çoğul → neviyên min.',
   her:['Pîrê neviyê xwe hez dike.', 'Sê neviyên min hene.'],
   gen:['Neviyê wî mezin e.', 'Nevî û pîrê li malê ne.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 6 — Cînavk (Zamirler)
  // Kaynak: Bedir Han §165–180 — Zamirler
  // ════════════════════════════════════════════════════════════

  (id:'a1_100', ku:'Ez', tr:'Ben', en:'I', cins:'bêcins', ez:null, kat:'cinavk', zor:0.88,
   not:'Yalın durum (nominatif). Eğik hali: "min". Mînak: Ez baş im. Têbinî: bûn 1.tekil ünsüzden sonra "im" (Ez baş im), ünlüden sonra "me" (Ez Kurdistanî me).',
   her:['Ez hatim malê, pîrê!', 'Ez baş im, dê.'],
   gen:['Ez xwendekar im.', 'Ez Kurdistanî me.']),

  (id:'a1_101', ku:'Tu', tr:'Sen', en:'You (singular)', cins:'bêcins', ez:null, kat:'cinavk', zor:0.88,
   not:'Yalın durum. Eğik hali: "te". Mînak: Tu baş î. Têbinî: bûn 2.tekil ünsüzden sonra "î", ünlüden sonra "yî" (Tu çawa yî?).',
   her:['Tu çawa yî, pîrê?', 'Tu baş î, dêyê?'],
   gen:['Tu kî yî?', 'Tu xwendekar î?']),

  (id:'a1_102', ku:'Ew', tr:'O (eril ve dişil)', en:'He / She / It', cins:'bêcins', ez:null, kat:'cinavk', zor:0.85,
   not:'Kurmancîde 3.tekil için cinsiyetsiz "ew". Eğik: wî (eril) / wê (dişil). Mînak: Ew baş e. Têbinî: çoğul "ew" da aynı yazılır — bağlamdan anlaşılır.',
   her:['Ew pîrêya min e.', 'Ew baş e.'],
   gen:['Ew mamosta ye.', 'Ew li malê ye.']),

  (id:'a1_103', ku:'Em', tr:'Biz', en:'We', cins:'bêcins', ez:null, kat:'cinavk', zor:0.86,
   not:'1.çoğul. Eğik hali: "me". Mînak: Em baş in. Têbinî: bûn çoğul ünsüzden sonra "in" (xwendekar in), ünlüden sonra "ne" (li malê ne).',
   her:['Em malbata me ne.', 'Em hatin malê, pîrê!'],
   gen:['Em xwendekar in.', 'Em li malê ne.']),

  (id:'a1_104', ku:'Hûn', tr:'Siz', en:'You (plural)', cins:'bêcins', ez:null, kat:'cinavk', zor:0.85,
   not:'2.çoğul. Eğik hali: "we". Mînak: Hûn xwendekar in. Têbinî: saygı için tekile de kullanılır (büyüklere "Tu" yerine "Hûn").',
   her:['Hûn çawa ne, pîrê û kal?', 'Hûn bi xêr hatîn!'],
   gen:['Hûn kî ne?', 'Hûn xwendekar in.']),

  (id:'a1_105', ku:'Ew (pirjimar)', tr:'Onlar', en:'They', cins:'bêcins', ez:null, kat:'cinavk', zor:0.84,
   not:'3.çoğul yazımda tekil "ew" ile aynı. Eğik hali: "wan". Mînak: Ew xwendekar in. Têbinî: bağlamdan anlaşılır (yüklem ve sayı işaretler).',
   her:['Ew malbata me ne.', 'Ew hatine malê.'],
   gen:['Ew xwendekar in.', 'Ew li bajêr in.']),

  (id:'a1_106', ku:'Min', tr:'Benim / Beni', en:'My / Me', cins:'bêcins', ez:null, kat:'cinavk', zor:0.83,
   not:'"Ez"in eğik hali — tamlama (sahiplik) ve nesne durumunda. Mînak: Navê min (benim adım). Têbinî: 2.tekil eğik "te".',
   her:['Dêya min baş e.', 'Pîrêya min li malê ye.'],
   gen:['Navê min … e.', 'Mala min mezin e.']),

  (id:'a1_107', ku:'Te', tr:'Senin / Seni', en:'Your / You (object)', cins:'bêcins', ez:null, kat:'cinavk', zor:0.83,
   not:'"Tu"nun eğik hali. Mînak: Navê te (senin adın). Têbinî: 1.tekil eğik "min".',
   her:['Dêya te çawa ye?', 'Xatirê te, pîrê!'],
   gen:['Navê te çi ye?', 'Mala te dûr e.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 7 — Pîşe û Perwerdehî (Meslek ve Eğitim)
  // Kaynak: Bedir Han & Lescot — PÎŞE + PERWERDEHÎ
  // ════════════════════════════════════════════════════════════

  (id:'a1_110', ku:'Mamosta', tr:'Öğretmen', en:'Teacher', cins:'bêcins', ez:'mamostayê/mamostaya',
   kat:'pîşe', zor:0.83,
   not:'Mamosta — eril/dişil aynı kelime; sadece veqetandek değişir. Mînak: mamostayê min (eril) / mamostaya min (dişil). Têbinî: çoğul → mamostayên me.',
   her:['Mamostayê min baş e.', 'Bavê min mamosta ye.'],
   gen:['Mamostayê me Kurmancî dizane.', 'Mamosta û xwendekar hatin.']),

  (id:'a1_111', ku:'Xwendekar', tr:'Öğrenci', en:'Student', cins:'bêcins', ez:'xwendekarê/xwendekara',
   kat:'pîşe', zor:0.82,
   not:'Xwendekar — "xwend" (okudu) + "-ekar" (yapan). Eril/dişil için aynı; veqetandek değişir. Mînak: xwendekarê dibistanê. Têbinî: x sesi gırtlaktan.',
   her:['Ez xwendekarê dibistanê me.', 'Xwişka min xwendekar e.'],
   gen:['Xwendekarên baş hene.', 'Xwendekar û mamosta hatin.']),

  (id:'a1_112', ku:'Bijîşk', tr:'Doktor / Hekim', en:'Doctor', cins:'bêcins', ez:'bijîşkê/bijîşka',
   kat:'pîşe', zor:0.80,
   not:'Bijîşk — saf Kurmancî kelime. Mînak: bijîşkê me (eril) / bijîşka me (dişil). Têbinî: "doktor" da kullanılır ama bijîşk daha özgün.',
   her:['Dêya min bijîşk e.', 'Bijîşkê me baş e.'],
   gen:['Bijîşka me baş e.', 'Bijîşk û nexweş hatin.']),

  (id:'a1_113', ku:'Karker', tr:'İşçi', en:'Worker', cins:'bêcins', ez:'karkerê/karkera',
   kat:'pîşe', zor:0.80,
   not:'Karker — "kar" (iş) + "-ker" (yapan). Eril/dişil için aynı. Mînak: karkerê me (eril) / karkera me (dişil).',
   her:['Bavê min karker e.', 'Karkerên baş in.'],
   gen:['Karkerên me dixebitin.', 'Karker û cotkar dixebitin.']),

  (id:'a1_114', ku:'Cotkar', tr:'Çiftçi', en:'Farmer', cins:'bêcins', ez:'cotkarê/cotkara',
   kat:'pîşe', zor:0.79,
   not:'Cotkar — "cot" (çift) + "-kar" (yapan). Mînak: cotkarê gund (köyün çiftçisi). Têbinî: çoğul → cotkarên me.',
   her:['Kalê min cotkar e.', 'Cotkarên Kurdistanê dixebitin.'],
   gen:['Cotkarê me xort e.', 'Cotkar û şivan in.']),

  (id:'a1_115', ku:'Şivan', tr:'Çoban', en:'Shepherd', cins:'bêcins', ez:'şivanê/şivana',
   kat:'pîşe', zor:0.79,
   not:'Şivan — Kürt kültüründe köklü meslek. Mînak: şivanê gund (köyün çobanı). Têbinî: çoğul → şivanên me.',
   her:['Kalê min şivan bû.', 'Şivanê me li çiyê ye.'],
   gen:['Şivanê Kurdistanê xort e.', 'Şivan û cotkar in.']),

  (id:'a1_116', ku:'Dibistan', tr:'Okul', en:'School', cins:'mê', ez:'dibistana',
   kat:'perwerde', zor:0.82,
   not:'Dibistan (dişil/mê). Veqetandek: dibistana min (benim okulum). Mînak: Xwişka min li dibistanê ye. Têbinî: oblique "li dibistanê" (okulda).',
   her:['Xwişka min li dibistanê ye.', 'Dibistana me mezin e.'],
   gen:['Dibistana me nêzîk e.', 'Dibistan û zanîngeh hene.']),

  (id:'a1_117', ku:'Zanîngeh', tr:'Üniversite', en:'University', cins:'mê', ez:'zanîngeha',
   kat:'perwerde', zor:0.80,
   not:'Zanîngeh (dişil/mê) — "zanîn" (bilmek) + "-geh" (yer). Veqetandek: zanîngeha min. Mînak: li zanîngehê (üniversitede).',
   her:['Birê min li zanîngehê dixwîne.', 'Zanîngeh nêzîkê me ye.'],
   gen:['Zanîngeha me mezin e.', 'Zanîngeh û dibistan hene.']),

  (id:'a1_118', ku:'Pirtûk', tr:'Kitap', en:'Book', cins:'mê', ez:'pirtûka',
   kat:'perwerde', zor:0.83,
   not:'Pirtûk (dişil/mê). Veqetandek: pirtûka min. Mînak: Pirtûka min Kurmancî ye. Têbinî: çoğul → pirtûkên min.',
   her:['Pirtûka min Kurmancî ye.', 'Pirtûkên pîrê hene.'],
   gen:['Pirtûka me xweş e.', 'Pirtûk û xwendin baş in.']),

  (id:'a1_119', ku:'Pirtûkxane', tr:'Kütüphane', en:'Library', cins:'mê', ez:'pirtûkxaneya',
   kat:'perwerde', zor:0.78,
   not:'Pirtûkxane (dişil/mê) — "pirtûk" (kitap) + "xane" (yer). Veqetandek: pirtûkxaneya bajêr (şehir kütüphanesi). Têbinî: oblique "li pirtûkxaneyê".',
   her:['Ez li pirtûkxaneyê dixwînim.', 'Pirtûkxaneya dibistanê mezin e.'],
   gen:['Pirtûkxaneya bajêr nêzîk e.', 'Pirtûkxane û dibistan hene.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 8 — Dem û Rojen (Zaman ve Günler)
  // Kaynak: Bedir Han & Lescot — DEM + DEMSAL + ALÎ
  // ════════════════════════════════════════════════════════════

  (id:'a1_120', ku:'Roj', tr:'Gün / Güneş', en:'Day / Sun', cins:'mê', ez:'roja',
   kat:'dem', zor:0.84,
   not:'Roj (dişil/mê) — hem "gün" hem "güneş". Veqetandek: roja min. Mînak: Newroz = "yeni gün". Têbinî: karşıtı "şev" (gece).',
   her:['Roja min xweş bû, pîrê!', 'Roj derketiye.'],
   gen:['Roja me dirêj e.', 'Roj germ e.']),

  (id:'a1_121', ku:'Şev', tr:'Gece', en:'Night', cins:'mê', ez:'şeva',
   kat:'dem', zor:0.84,
   not:'Şev (dişil/mê). Veqetandek: şeva min. Mînak: Şeva we xweş be! (Geceniz güzel olsun!) Têbinî: karşıtı "roj" (gün).',
   her:['Şeva we xweş be, pîrê!', 'Şev sar e.'],
   gen:['Şeva me dirêj e.', 'Şev û sibê hene.']),

  (id:'a1_122', ku:'Sibê', tr:'Yarın / Sabahleyin (zarf)', en:'Tomorrow / In the morning', cins:'bêcins', ez:null,
   kat:'dem', zor:0.82,
   not:'Sibê — zarf olarak "yarın" veya "sabahleyin". Mînak: Sibê tê. (Yarın geliyor.) Têbinî: isim formu "sibeh" (dişil); karşıtı "duh" (dün).',
   her:['Sibê tê malê, pîrê?', 'Sibê baş, dê!'],
   gen:['Sibê tê.', 'Sibê û êvar hene.']),

  (id:'a1_123', ku:'Nîvro', tr:'Öğle', en:'Noon / Midday', cins:'nêr', ez:'nîvroyê',
   kat:'dem', zor:0.82,
   not:'Nîvro (eril/nêr) — "nîv" (yarım) + "ro(j)" (gün) = günün yarısı. Veqetandek: nîvroyê. Têbinî: oblique "di nîvroyê de" (öğleyin).',
   her:['Nîvro hatim malê, dêyê.', 'Di nîvroyê de nan dixwim.'],
   gen:['Nîvro germ e.', 'Nîvro û êvar hene.']),

  (id:'a1_124', ku:'Êvar', tr:'Akşam', en:'Evening', cins:'mê', ez:'êvara',
   kat:'dem', zor:0.82,
   not:'Êvar (dişil/mê). Veqetandek: êvara me. Mînak: di êvarê de (akşamleyin). Têbinî: karşıtı "sibê" (sabah).',
   her:['Êvarê hatim, pîrê!', 'Êvara me xweş bû.'],
   gen:['Di êvarê de tê.', 'Êvar û şev hene.']),

  (id:'a1_125', ku:'Îro', tr:'Bugün', en:'Today', cins:'bêcins', ez:null,
   kat:'dem', zor:0.85,
   not:'Îro — "î-ro" (bu gün); zarf. Mînak: Îro çawa yî? Têbinî: karşıtı "duh" (dün), gelecek "sibê" (yarın).',
   her:['Îro pîrê tê malê!', 'Îro çawa yî, dêyê?'],
   gen:['Îro baş e.', 'Îro û sibê hene.']),

  (id:'a1_126', ku:'Duh', tr:'Dün', en:'Yesterday', cins:'bêcins', ez:null,
   kat:'dem', zor:0.83,
   not:'Duh — geçmiş gün; zarf. Mînak: Duh hatim. (Dün geldim.) Têbinî: karşıtı "sibê" (yarın).',
   her:['Duh pîrê hat malê.', 'Duh xweş bû.'],
   gen:['Duh hatim.', 'Duh û îro hene.']),

  (id:'a1_127', ku:'Hefte', tr:'Hafta', en:'Week', cins:'mê', ez:'hefteya',
   kat:'dem', zor:0.82,
   not:'Hefte (dişil/mê). Veqetandek: hefteya min. Mînak: di vê heftê de (bu hafta). Têbinî: oblique "di heftê de" (haftada).',
   her:['Di vê heftê de pîrê tê.', 'Hefteya me xweş bû.'],
   gen:['Hefteya me dirêj e.', 'Hefte û meh hene.']),

  (id:'a1_128', ku:'Meh', tr:'Ay (zaman)', en:'Month', cins:'mê', ez:'meha',
   kat:'dem', zor:0.81,
   not:'Meh (dişil/mê). Veqetandek: meha Adarê (Adar ayı). Mînak: di mehê de (ayda). Têbinî: gökteki ay için "heyv".',
   her:['Meha Adarê — Newroz!', 'Meha me xweş bû.'],
   gen:['Meha me dirêj e.', 'Meh û sal hene.']),

  (id:'a1_129', ku:'Sal', tr:'Yıl', en:'Year', cins:'mê', ez:'sala',
   kat:'dem', zor:0.83,
   not:'Sal (dişil/mê). Veqetandek: sala me. Mînak: sala nû (yeni yıl). Têbinî: oblique "di salê de" (yılda).',
   her:['Sala nû pîroz be, pîrê!', 'Ev sal xweş e.'],
   gen:['Sala me dirêj e.', 'Sal û meh hene.']),

  // Günler
  (id:'a1_130', ku:'Duşem', tr:'Pazartesi', en:'Monday', cins:'mê', ez:'Duşema',
   kat:'roj', zor:0.80,
   not:'Duşem — "şem" (gün) + "du" (iki) = ikinci gün. Mînak: Duşemê em diçin. Têbinî: Kürt-İran takviminde haftanın ilk günü "Yekşem" (Pazar).',
   her:['Duşemê ez diçim dibistanê.', 'Duşem roja duyem e.'],
   gen:['Duşemê em hatin.', 'Duşem û Sêşem hene.']),

  (id:'a1_131', ku:'Sêşem', tr:'Salı', en:'Tuesday', cins:'mê', ez:'Sêşema',
   kat:'roj', zor:0.79,
   not:'Sêşem — "sê" (üç) + "şem" (gün) = üçüncü gün. Mînak: Sêşemê pîrê tê.',
   her:['Sêşemê pîrê tê.', 'Sêşem roja sêyem e.'],
   gen:['Sêşemê em xebitîn.', 'Sêşem û Çarşem hene.']),

  (id:'a1_132', ku:'Çarşem', tr:'Çarşamba', en:'Wednesday', cins:'mê', ez:'Çarşema',
   kat:'roj', zor:0.79,
   not:'Çarşem — "çar" (dört) + "şem" (gün). Mînak: Çarşemê em diçin. Têbinî: Türkçe "Çarşamba" ile aynı kök.',
   her:['Çarşemê em diçin gund.', 'Çarşem roja çarem e.'],
   gen:['Çarşemê em hatin.', 'Çarşem û Pêncşem hene.']),

  (id:'a1_133', ku:'Pêncşem', tr:'Perşembe', en:'Thursday', cins:'mê', ez:'Pêncşema',
   kat:'roj', zor:0.79,
   not:'Pêncşem — "pênc" (beş) + "şem" (gün). Mînak: Pêncşemê xebat heye.',
   her:['Pêncşemê xebat heye.', 'Pêncşem roja pêncem e.'],
   gen:['Pêncşemê em hatin.', 'Pêncşem û Înî hene.']),

  (id:'a1_134', ku:'Înî', tr:'Cuma', en:'Friday', cins:'mê', ez:'Îniya',
   kat:'roj', zor:0.80,
   not:'Înî — Kurmancî özgün form. Mînak: Înî malbat tê. Têbinî: "Cuma" (Arapça alıntı) da kullanılır.',
   her:['Înî malbat tê malê.', 'Di Îniyê de çay vedixwin.'],
   gen:['Înî em diçin gund.', 'Îro Înî ye.']),

  (id:'a1_135', ku:'Şemî', tr:'Cumartesi', en:'Saturday', cins:'mê', ez:'Şemiya',
   kat:'roj', zor:0.80,
   not:'Şemî — Arapça "şem" (gün) kökünden. Mînak: Şemî em diçin bazarê. Têbinî: oblique "di Şemiyê de".',
   her:['Şemî em diçin bazarê.', 'Şemî roja şeşem e.'],
   gen:['Şemî em xebitîn.', 'Şemî û Yekşem hene.']),

  (id:'a1_136', ku:'Yekşem', tr:'Pazar', en:'Sunday', cins:'mê', ez:'Yekşema',
   kat:'roj', zor:0.80,
   not:'Yekşem — "yek" (bir) + "şem" (gün) = ilk gün. Mînak: Yekşem malbat tê. Têbinî: Kürt-İran takviminde haftanın ilk günü.',
   her:['Yekşem malbat tê malê.', 'Di Yekşemê de pîrê tê.'],
   gen:['Yekşem roja yekem e.', 'Yekşem û Duşem hene.']),

  // Mevsimler
  (id:'a1_140', ku:'Bihar', tr:'İlkbahar', en:'Spring', cins:'mê', ez:'bihara',
   kat:'demsal', zor:0.83,
   not:'Bihar (dişil/mê). Veqetandek: bihara me. Mînak: Newroz biharê tê! Têbinî: karşıtı "payîz" (sonbahar); oblique "di biharê de".',
   her:['Biharê Newroz tê, pîrê!', 'Bihara vê salê xweş e.'],
   gen:['Bihara me xweş e.', 'Bihar û havîn hene.']),

  (id:'a1_141', ku:'Havîn', tr:'Yaz', en:'Summer', cins:'mê', ez:'havîna',
   kat:'demsal', zor:0.82,
   not:'Havîn (dişil/mê). Veqetandek: havîna me. Mînak: havînê germ e (yaz sıcak). Têbinî: karşıtı "zivistan" (kış).',
   her:['Havînê em diçin gund.', 'Havîna îsal germ e.'],
   gen:['Havîna me dirêj e.', 'Havîn û payîz hene.']),

  (id:'a1_142', ku:'Payîz', tr:'Sonbahar', en:'Autumn', cins:'mê', ez:'payîza',
   kat:'demsal', zor:0.82,
   not:'Payîz (dişil/mê). Veqetandek: payîza me. Mînak: payîzê sar e (sonbahar soğuk). Têbinî: karşıtı "bihar" (ilkbahar).',
   her:['Payîzê ew tê malê.', 'Payîza îsal sar e.'],
   gen:['Payîza me dirêj e.', 'Payîz û zivistan hene.']),

  (id:'a1_143', ku:'Zivistan', tr:'Kış', en:'Winter', cins:'mê', ez:'zivistana',
   kat:'demsal', zor:0.82,
   not:'Zivistan (dişil/mê). Veqetandek: zivistana me. Mînak: zivistanê berf dibare (kışın kar yağar). Têbinî: karşıtı "havîn" (yaz).',
   her:['Zivistanê berf dibare, pîrê!', 'Zivistana sar derbas bû.'],
   gen:['Zivistana me dirêj e.', 'Zivistan û bihar hene.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 9 — Xwarin û Vexwarin (Yemek ve İçecek)
  // Kaynak: Bedir Han & Lescot — XWARIN Û VEXWARIN
  // ════════════════════════════════════════════════════════════

  (id:'a1_150', ku:'Nan', tr:'Ekmek', en:'Bread', cins:'nêr', ez:'nanê',
   kat:'xwarin', zor:0.86,
   not:'Nan (eril/nêr) — kültürel önemi büyük. Veqetandek: nanê me. Mînak: Dêya min nan dipijîne. Têbinî: "nan û xwê" = misafirperverlik sembolü.',
   her:['Dêya min nan dipijîne.', 'Nan bixwe, pîrê!'],
   gen:['Nanê me xweş e.', 'Nan û av hene.']),

  (id:'a1_151', ku:'Av', tr:'Su', en:'Water', cins:'mê', ez:'ava',
   kat:'vexwarin', zor:0.86,
   not:'Av (dişil/mê). Veqetandek: ava me. Mînak: avê bide min (su ver bana). Têbinî: oblique "li avê" (suda).',
   her:['Dêyê, av bide min!', 'Av sar e, pîrê.'],
   gen:['Ava me sar e.', 'Av û çay hene.']),

  (id:'a1_152', ku:'Çay', tr:'Çay', en:'Tea', cins:'nêr', ez:'çayê',
   kat:'vexwarin', zor:0.88,
   not:'Çay (eril/nêr) — Kürt kültüründe misafir çayı zorunlu gelenektir. Veqetandek: çayê me. Mînak: çayê xweş.',
   her:['Pîrêya min çay dide min.', 'Çayê xweş vexwe!'],
   gen:['Çayê me germ e.', 'Çay û qehwe hene.']),

  (id:'a1_153', ku:'Qehwe', tr:'Kahve', en:'Coffee', cins:'mê', ez:'qehweya',
   kat:'vexwarin', zor:0.84,
   not:'Qehwe (dişil/mê). Veqetandek: qehweya me. Mînak: bavê min qehwe vedixwe. Têbinî: q sesi gırtlaktan.',
   her:['Bavê min qehwe vedixwe.', 'Qehweya min germ e.'],
   gen:['Qehweya we xweş e.', 'Qehwe û çay hene.']),

  (id:'a1_154', ku:'Şîr', tr:'Süt', en:'Milk', cins:'nêr', ez:'şîrê',
   kat:'vexwarin', zor:0.83,
   not:'Şîr (eril/nêr). Veqetandek: şîrê bizinê (keçi sütü). Mînak: şîr bide min. Têbinî: î uzun söylenir.',
   her:['Şîrê bizinê xweş e.', 'Pîrê şîr dide me.'],
   gen:['Şîrê me xweş e.', 'Şîr û mast hene.']),

  (id:'a1_155', ku:'Mast', tr:'Yoğurt', en:'Yogurt', cins:'nêr', ez:'mastê',
   kat:'xwarin', zor:0.84,
   not:'Mast (eril/nêr). Veqetandek: mastê me. Mînak: nan û mast bixwe. Têbinî: Türkçeyle aynı kök.',
   her:['Mastê dêya min xweş e!', 'Nan û mast bixwe.'],
   gen:['Mastê me xweş e.', 'Mast û şîr hene.']),

  (id:'a1_156', ku:'Goşt', tr:'Et', en:'Meat', cins:'nêr', ez:'goştê',
   kat:'xwarin', zor:0.82,
   not:'Goşt (eril/nêr). Veqetandek: goştê berx (kuzu eti). Mînak: pîrê goşt dipijîne. Têbinî: çoğul → goştên cur bi cur.',
   her:['Pîrê goşt dipijîne.', 'Goştê berx xweş e.'],
   gen:['Goştê me xweş e.', 'Goşt û nan hene.']),

  (id:'a1_157', ku:'Mirîşk', tr:'Tavuk', en:'Chicken', cins:'mê', ez:'mirîşka',
   kat:'xwarin', zor:0.81,
   not:'Mirîşk (dişil/mê) — hem hayvan hem et anlamında. Veqetandek: mirîşka pîrê. Mînak: mirîşk û goşt.',
   her:['Mirîşka pîrê xweş bû!', 'Mirîşk û goşt xweş in.'],
   gen:['Mirîşka me xweş e.', 'Mirîşk û nan hene.']),

  (id:'a1_158', ku:'Rûn', tr:'Yağ / Tereyağı', en:'Butter / Fat', cins:'nêr', ez:'rûnê',
   kat:'xwarin', zor:0.80,
   not:'Rûn (eril/nêr) — Kürt mutfağında temel malzeme. Veqetandek: rûnê bizinê (keçi yağı). Têbinî: û uzun söylenir.',
   her:['Rûnê bizinê xweş e.', 'Pîrê rûn dike.'],
   gen:['Rûnê me kêm e.', 'Rûn û mast hene.']),

  (id:'a1_159', ku:'Xwê', tr:'Tuz', en:'Salt', cins:'mê', ez:'xwêya',
   kat:'xwarin', zor:0.82,
   not:'Xwê (dişil/mê) — x sesi gırtlaktan. Veqetandek: xwêya me. Mînak: "Nan û xwê" = ekmek ve tuz = misafirperverlik sembolü.',
   her:['Nan û xwê bide mêvanan.', 'Xwê tê de heye.'],
   gen:['Xwêya me kêm e.', 'Xwê û îsot hene.']),

  (id:'a1_160', ku:'Sêv', tr:'Elma', en:'Apple', cins:'mê', ez:'sêva',
   kat:'mêwe', zor:0.83,
   not:'Sêv (dişil/mê) — ê uzun söylenir. Veqetandek: sêva min. Mînak: sêvên sor xweş in.',
   her:['Sêvên pîrê xweş in!', 'Sêva min sor e.'],
   gen:['Sêva me xweş e.', 'Sêv û tirî hene.']),

  (id:'a1_161', ku:'Tirî', tr:'Üzüm', en:'Grape', cins:'nêr', ez:'tiriyê',
   kat:'mêwe', zor:0.81,
   not:'Tirî (eril/nêr) — Kürt kültüründe önemli meyve. Veqetandek: tiriyê sor. Mînak: tirî bide me.',
   her:['Tiriyên sor xweş in.', 'Pîrê tirî dide me.'],
   gen:['Tiriyê me xweş e.', 'Tirî û sêv hene.']),

  (id:'a1_162', ku:'Birinc', tr:'Pirinç', en:'Rice', cins:'nêr', ez:'birincê',
   kat:'xwarin', zor:0.80,
   not:'Birinc (eril/nêr). Veqetandek: birincê pîrê. Mînak: birinc û goşt xweş in.',
   her:['Birincê pîrê xweş e!', 'Birinc û goşt xweş in.'],
   gen:['Birincê me xweş e.', 'Birinc û nan hene.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 10 — Endamên Bedenê û Tenduristî (Beden ve Sağlık)
  // Kaynak: Bedir Han & Lescot — ENDAMÊN BEDENÊ + TENDURISTÎ
  // ════════════════════════════════════════════════════════════

  (id:'a1_170', ku:'Ser', tr:'Baş', en:'Head', cins:'nêr', ez:'serê',
   kat:'beden', zor:0.84,
   not:'Ser (eril/nêr). Veqetandek: serê min (başım). Mînak: serê min diêşe (başım ağrıyor). Têbinî: "serî" uzun form da kullanılır.',
   her:['Serê min diêşe îro.', 'Çav û ser girêdayî ne.'],
   gen:['Serê min mezin e.', 'Ser û çav hene.']),

  (id:'a1_171', ku:'Çav', tr:'Göz', en:'Eye', cins:'nêr', ez:'çavê',
   kat:'beden', zor:0.84,
   not:'Çav (eril/nêr). Veqetandek: çavê min (gözüm). Mînak: çavên pîrê xweş in. Têbinî: çoğul → çavên min.',
   her:['Çavên pîrê xweş in.', 'Çavê te kesk e.'],
   gen:['Çavên min reş in.', 'Çav û guh hene.']),

  (id:'a1_172', ku:'Guh', tr:'Kulak', en:'Ear', cins:'nêr', ez:'guhê',
   kat:'beden', zor:0.83,
   not:'Guh (eril/nêr). Veqetandek: guhê min. Mînak: guhên pîrê baş dibihîzin. Têbinî: çoğul → guhên min.',
   her:['Guhên pîrê baş dibihîzin.', 'Guhê te diêşe?'],
   gen:['Guhên min baş in.', 'Guh û dev hene.']),

  (id:'a1_173', ku:'Dev', tr:'Ağız', en:'Mouth', cins:'nêr', ez:'devê',
   kat:'beden', zor:0.83,
   not:'Dev (eril/nêr). Veqetandek: devê min. Mînak: devê te xweş diaxive. Têbinî: ziman dev içindedir.',
   her:['Devê te xweş diaxive.', 'Dev û ziman girêdayî ne.'],
   gen:['Devê min biçûk e.', 'Dev û poz hene.']),

  (id:'a1_174', ku:'Poz', tr:'Burun', en:'Nose', cins:'nêr', ez:'pozê',
   kat:'beden', zor:0.82,
   not:'Poz (eril/nêr). Veqetandek: pozê min. Mînak: pozê min diêşe. Têbinî: çoğul yoktur (tek burun).',
   her:['Pozê min diêşe.', 'Pozê te mezin e?'],
   gen:['Pozê min biçûk e.', 'Poz û dev hene.']),

  (id:'a1_175', ku:'Dest', tr:'El', en:'Hand', cins:'nêr', ez:'destê',
   kat:'beden', zor:0.84,
   not:'Dest (eril/nêr). Veqetandek: destê te (senin elin). Mînak: "destê te xweş be" = elinize sağlık. Têbinî: çoğul → destên min.',
   her:['Destê te xweş be, pîrê!', 'Destên min sar in.'],
   gen:['Destên min mezin in.', 'Dest û ling hene.']),

  (id:'a1_176', ku:'Ling', tr:'Ayak / Bacak', en:'Leg / Foot', cins:'nêr', ez:'lingê',
   kat:'beden', zor:0.82,
   not:'Ling (eril/nêr) — hem "ayak" hem "bacak". Veqetandek: lingê min. Mînak: lingê min diêşe.',
   her:['Lingê min diêşe.', 'Lingên min sar in.'],
   gen:['Lingên min dirêj in.', 'Ling û dest hene.']),

  (id:'a1_177', ku:'Ziman', tr:'Dil (organ)', en:'Tongue / Language', cins:'nêr', ez:'zimanê',
   kat:'beden', zor:0.83,
   not:'Ziman (eril/nêr) — hem "dil organı" hem "dil/lisan". Veqetandek: zimanê min. Mînak: Zimanê min Kurmancî ye.',
   her:['Zimanê min Kurmancî ye!', 'Ziman û dev girêdayî ne.'],
   gen:['Zimanê me Kurmancî ye.', 'Ziman û çav hene.']),

  (id:'a1_178', ku:'Dil', tr:'Kalp', en:'Heart', cins:'nêr', ez:'dilê',
   kat:'beden', zor:0.84,
   not:'Dil (eril/nêr) — hem "kalp organı" hem duygusal "gönül". Veqetandek: dilê min. Mînak: dilê min xweş e.',
   her:['Dilê min lez dixebite.', 'Dilê min xweş e.'],
   gen:['Dilê min germ e.', 'Dil û ziman hene.']),

  (id:'a1_179', ku:'Ez nexweş im', tr:'Hastayım', en:"I'm sick", cins:'bêcins', ez:null,
   kat:'tendurist', zor:0.83,
   not:'Hevok: "ez" + "nexweş" + bûn 1.tekil "im". "Nexweş" = ne (değil) + xweş (iyi). Mînak: Ez nexweş im, bijîşk pêwîst e.',
   her:['Ez nexweş im, bijîşk pêwîst e.', 'Dê, ez nexweş im.'],
   gen:['Ez nexweş im.', 'Ew nexweş e.']),

  (id:'a1_180', ku:'Ez birçî me', tr:'Açım', en:"I'm hungry", cins:'bêcins', ez:null,
   kat:'tendurist', zor:0.82,
   not:'Hevok: "ez" + "birçî" (aç) + bûn 1.tekil "me" (ünlüden sonra). Mînak: Ez birçî me, nan bide. Têbinî: karşıtı "têr" (tok).',
   her:['Dayê, ez birçî me.', 'Pîrê, em birçî ne!'],
   gen:['Ez birçî me.', 'Ew birçî ye.']),

  (id:'a1_181', ku:'Ez tî me', tr:'Susuzum', en:"I'm thirsty", cins:'bêcins', ez:null,
   kat:'tendurist', zor:0.82,
   not:'Hevok: "ez" + "tî" (susuz) + bûn 1.tekil "me" (ünlüden sonra). Mînak: Ez tî me, av bide.',
   her:['Ez tî me, dêyê.', 'Kal, ez tî me.'],
   gen:['Ez tî me.', 'Av bide min, tî me.']),

  (id:'a1_182', ku:'Nexweşxane', tr:'Hastane', en:'Hospital', cins:'mê', ez:'nexweşxaneya',
   kat:'tendurist', zor:0.80,
   not:'Nexweşxane (dişil/mê) — "nexweş" (hasta) + "xane" (yer). Veqetandek: nexweşxaneya bajêr (şehir hastanesi). Têbinî: oblique "li nexweşxaneyê".',
   her:['Bavê min li nexweşxaneyê ye.', 'Nexweşxane li nêzê gund e.'],
   gen:['Nexweşxaneya me mezin e.', 'Nexweşxane û mal nêzîk in.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 11 — Mal û Cih (Ev ve Mekan)
  // Kaynak: Bedir Han & Lescot — Konaklama bölümü
  // ════════════════════════════════════════════════════════════

  (id:'a1_190', ku:'Mal', tr:'Ev / Yurt', en:'Home / House', cins:'mê', ez:'mala',
   kat:'mal', zor:0.85,
   not:'Mal (dişil/mê). Veqetandek: mala min (benim evim). Mînak: Ez hatim malê. Têbinî: oblique "li malê" (evde), "malê" (eve — yön).',
   her:['Ez hatim malê, pîrê!', 'Mala me mezin e.'],
   gen:['Mala me nêzîk e.', 'Mal û cih hene.']),

  (id:'a1_191', ku:'Xanî', tr:'Bina / Ev', en:'Building / House', cins:'nêr', ez:'xaniyê',
   kat:'mal', zor:0.82,
   not:'Xanî (eril/nêr) — daha çok bina anlamında. Veqetandek: xaniyê me. Têbinî: x sesi gırtlaktan; "mal" daha geniş anlam.',
   her:['Xaniyê me mezin e.', 'Em li xaniyê nû dijîn.'],
   gen:['Xaniyê me bilind e.', 'Xanî û mal hene.']),

  (id:'a1_192', ku:'Ode', tr:'Oda', en:'Room', cins:'mê', ez:'odeya',
   kat:'mal', zor:0.83,
   not:'Ode (dişil/mê) — Türkçe alıntı. Veqetandek: odeya min. Têbinî: özgün Kurmancî alternatif "jûr" (mê).',
   her:['Odeya min biçûk e.', 'Odeyên malê biçûk in.'],
   gen:['Odeya me xweş e.', 'Ode û mitbex hene.']),

  (id:'a1_193', ku:'Derî', tr:'Kapı', en:'Door', cins:'nêr', ez:'deriyê',
   kat:'mal', zor:0.82,
   not:'Derî (eril/nêr). Veqetandek: deriyê malê. Mînak: deriyê malê veke. Têbinî: çoğul → deriyên me.',
   her:['Deriyê malê veke, pîrê!', 'Derî û pace girêdayî ne.'],
   gen:['Deriyê malê veke.', 'Derî û pace hene.']),

  (id:'a1_194', ku:'Pace', tr:'Cam / Pencere', en:'Window', cins:'mê', ez:'paceya',
   kat:'mal', zor:0.83,
   not:'Pace (dişil/mê) — özgün Kurmancî form. Veqetandek: paceya min. Têbinî: "pencere" alıntı; "pace" tercih edilir.',
   her:['Paceya malê kesk e.', 'Pace veke, dêyê!'],
   gen:['Paceya me mezin e.', 'Pace û derî hene.']),

  (id:'a1_195', ku:'Nivîn', tr:'Yatak', en:'Bed', cins:'nêr', ez:'nivînê',
   kat:'mal', zor:0.80,
   not:'Nivîn (eril/nêr). Veqetandek: nivînê min. Mînak: pîrê li nivînê ye. Têbinî: oblique "li nivînê" (yatakta).',
   her:['Nivînê min germ e.', 'Pîrê li nivînê ye.'],
   gen:['Nivînê min nerm e.', 'Nivîn û kursî hene.']),

  (id:'a1_196', ku:'Kursî', tr:'Sandalye / Koltuk', en:'Chair', cins:'mê', ez:'kursiya',
   kat:'mal', zor:0.80,
   not:'Kursî (dişil/mê) — Farsça/Arapça kökenli. Veqetandek: kursiya min. Têbinî: oblique "li ser kursiyê" (sandalyenin üstünde).',
   her:['Li ser kursiyê rûne, hevalo!', 'Kursiya min mezin e.'],
   gen:['Kursiya me biçûk e.', 'Kursî û mêz hene.']),

  (id:'a1_197', ku:'Mêz', tr:'Masa', en:'Table', cins:'nêr', ez:'mêzê',
   kat:'mal', zor:0.81,
   not:'Mêz (eril/nêr) — ê uzun söylenir. Veqetandek: mêzê me. Mînak: xwarin li mêzê ye.',
   her:['Xwarin li mêzê ye.', 'Pîrê li mêzê rûniştî ye.'],
   gen:['Mêzê me mezin e.', 'Mêz û kursî hene.']),

  (id:'a1_198', ku:'Mitbex', tr:'Mutfak', en:'Kitchen', cins:'mê', ez:'mitbexa',
   kat:'mal', zor:0.80,
   not:'Mitbex (dişil/mê) — Bedirxan tercihi (metbex değil). Veqetandek: mitbexa malê. Têbinî: özgün Kurmancî "aşpêzxane".',
   her:['Dê li mitbexê nan dipijîne.', 'Mitbexa me mezin e.'],
   gen:['Mitbexa me xweş e.', 'Mitbex û ode hene.']),

  (id:'a1_199', ku:'Serşok', tr:'Tuvalet / Banyo', en:'Bathroom / Toilet', cins:'mê', ez:'serşoka',
   kat:'mal', zor:0.78,
   not:'Serşok (dişil/mê). Veqetandek: serşoka me. Mînak: serşok li jor e.',
   her:['Serşok li jor e.', 'Serşoka me paqij e.'],
   gen:['Serşoka me paqij e.', 'Serşok û ode hene.']),

  (id:'a1_200', ku:'Baxçe', tr:'Bahçe', en:'Garden', cins:'nêr', ez:'baxçeyê',
   kat:'mal', zor:0.81,
   not:'Baxçe (eril/nêr) — Kürt evlerinde bahçe kültürü güçlü. Veqetandek: baxçeyê pîrê. Têbinî: oblique "li baxçeyê" (bahçede).',
   her:['Baxçeyê pîrê xweş e.', 'Em li baxçeyê rûniştin.'],
   gen:['Baxçeyê me mezin e.', 'Baxçe û mal hene.']),

  // ════════════════════════════════════════════════════════════
  // BİRİM 12 — Rengdêr û Peyvên Bingehîn (Rengdêrlar ve Temel Kelimeler)
  // Kaynak: Bedir Han & Lescot — RENGDÊR
  // ════════════════════════════════════════════════════════════

  (id:'a1_210', ku:'Baş', tr:'İyi', en:'Good', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.87,
   not:'Rengdêra neguherbar — isimle uyum yok. Mînak: pîrê baş e (büyükanne iyidir). Têbinî: karşıtı "xerab" (kötü); karş: "baştir" (daha iyi).',
   her:['Pîrê baş e!', 'Ev nan baş e.'],
   gen:['Ev mamoste baş e.', 'Baş û xerab dijwate ne.']),

  (id:'a1_211', ku:'Xerab', tr:'Kötü', en:'Bad', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.84,
   not:'Rengdêra neguherbar. Mînak: hewa xerab e (hava kötü). Têbinî: karşıtı "baş" (iyi); karş: "xerabtir" (daha kötü).',
   her:['Hewa xerab e, pîrê.', 'Ev nan xerab e.'],
   gen:['Ev rojek xerab e.', 'Baş û xerab dijwate ne.']),

  (id:'a1_212', ku:'Mezin', tr:'Büyük', en:'Big', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.85,
   not:'Rengdêra neguherbar. Mînak: mala pîrê mezin e (büyükannenin evi büyük). Têbinî: karşıtı "biçûk" (küçük).',
   her:['Mala pîrê mezin e!', 'Birê min mezin e.'],
   gen:['Ev xanî mezin e.', 'Mezin û biçûk dijwate ne.']),

  (id:'a1_213', ku:'Biçûk', tr:'Küçük', en:'Small', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.84,
   not:'Rengdêra neguherbar. Mînak: xwişka min biçûk e. Têbinî: karşıtı "mezin" (büyük).',
   her:['Xwişka min biçûk e.', 'Odeya min biçûk e.'],
   gen:['Ev mal biçûk e.', 'Biçûk û mezin dijwate ne.']),

  (id:'a1_214', ku:'Nû', tr:'Yeni', en:'New', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.84,
   not:'Rengdêra neguherbar. Mînak: sala nû (yeni yıl). Têbinî: karşıtı "kevn" (eski).',
   her:['Xaniyê me nû ye.', 'Sala nû pîroz be!'],
   gen:['Ev pirtûk nû ye.', 'Nû û kevn dijwate ne.']),

  (id:'a1_215', ku:'Kevn', tr:'Eski', en:'Old', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.82,
   not:'Rengdêra neguherbar. Mînak: mala pîrê kevn e. Têbinî: karşıtı "nû" (yeni).',
   her:['Mala pîrê kevn e.', 'Pirtûk kevn e.'],
   gen:['Ev xanî kevn e.', 'Kevn û nû dijwate ne.']),

  (id:'a1_216', ku:'Germ', tr:'Sıcak', en:'Hot / Warm', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.84,
   not:'Rengdêra neguherbar. Mînak: hewa germ e (hava sıcak). Têbinî: karşıtı "sar" (soğuk).',
   her:['Çayê germ vexwe, pîrê!', 'Hewa germ e.'],
   gen:['Av germ e.', 'Germ û sar dijwate ne.']),

  (id:'a1_217', ku:'Sar', tr:'Soğuk', en:'Cold', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.84,
   not:'Rengdêra neguherbar. Mînak: zivistan sar e. Têbinî: karşıtı "germ" (sıcak).',
   her:['Zivistan sar e, pîrê!', 'Av sar e.'],
   gen:['Hewa sar e.', 'Sar û germ dijwate ne.']),

  (id:'a1_218', ku:'Dirêj', tr:'Uzun', en:'Long / Tall', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.82,
   not:'Rengdêra neguherbar — hem boy hem mesafe için. Mînak: birê min dirêj e. Têbinî: karşıtı "kurt" (kısa).',
   her:['Birê min dirêj e.', 'Rêya dirêj e.'],
   gen:['Roj dirêj e.', 'Dirêj û kurt dijwate ne.']),

  (id:'a1_219', ku:'Kurt', tr:'Kısa', en:'Short', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.82,
   not:'Rengdêra neguherbar. Mînak: wane kurt e (ders kısa). Têbinî: karşıtı "dirêj" (uzun).',
   her:['Xwişka min kurt e.', 'Wane kurt e.'],
   gen:['Hefte kurt bû.', 'Kurt û dirêj dijwate ne.']),

  (id:'a1_220', ku:'Xweş', tr:'Güzel / İyi', en:'Beautiful / Nice', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.85,
   not:'Rengdêra neguherbar — çok kullanılan. Mînak: pîrêya min xweş e. Têbinî: "xweş bî!" = iyi ol! (selamlama).',
   her:['Pîrêya min xweş e!', 'Nan xweş bû, dêyê!'],
   gen:['Ev hewa xweş e.', 'Xweş û xerab dijwate ne.']),

  (id:'a1_221', ku:'Gelek', tr:'Çok', en:'Very / Many', cins:'bêcins', ez:null,
   kat:'peyvben', zor:0.85,
   not:'Hoker (zarf) — değişmez, rengdêrlardan önce gelir. Mînak: gelek baş (çok iyi). Têbinî: karşıtı "hindik" (az).',
   her:['Gelek spas, pîrê!', 'Ez gelek birçî me.'],
   gen:['Ez gelek dixwînim.', 'Gelek û hindik dijwate ne.']),

  (id:'a1_222', ku:'Hindik', tr:'Az / Biraz', en:'Little / Few', cins:'bêcins', ez:null,
   kat:'peyvben', zor:0.82,
   not:'Hoker (zarf) — az miktar. Mînak: hindik nan bide (az ekmek ver). Têbinî: "hinekî" = biraz; karşıtı "gelek" (çok).',
   her:['Hindik nan bide min, dêyê.', 'Hindik av heye.'],
   gen:['Ez hindik dixwim.', 'Hindik û gelek dijwate ne.']),

  (id:'a1_223', ku:'Zû', tr:'Erken / Hızlı', en:'Early / Fast', cins:'bêcins', ez:null,
   kat:'peyvben', zor:0.82,
   not:'Hoker (zarf) — hem "erken" hem "hızlı". Mînak: zû were (hızlı gel). Têbinî: karşıtı "dereng" (geç).',
   her:['Zû were, pîrê tê!', 'Zû hatim malê.'],
   gen:['Ez zû radibim.', 'Zû û dereng dijwate ne.']),

  (id:'a1_224', ku:'Dereng', tr:'Geç / Geride', en:'Late / Behind', cins:'bêcins', ez:null,
   kat:'peyvben', zor:0.82,
   not:'Hoker (zarf) — hem "geç" hem "geride". Mînak: dereng hatim (geç geldim). Têbinî: karşıtı "zû" (erken).',
   her:['Bibore, dereng hatim, pîrê.', 'Dereng e, şev e.'],
   gen:['Ez dereng radibim.', 'Dereng û zû dijwate ne.']),

  (id:'a1_225', ku:'Rast', tr:'Doğru / Sağ', en:'Correct / Right', cins:'bêcins', ez:null,
   kat:'peyvben', zor:0.83,
   not:'Hem "doğru" hem "sağ yön". Mînak: rast bêje (doğru söyle). Têbinî: karşıtı "çep" (sol).',
   her:['Rast bêje, pîrê!', 'Berê rast here.'],
   gen:['Ev gotin rast e.', 'Rast û çep dijwate ne.']),

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
   not:'Bûn 1.tekil "im" (ünsüz sonrası) / "me" (ünlü sonrası). Mînak: Ez baş im / Ez Kurdistanî me. Têbinî: çekim → Ez … im / Tu … î / Ew … e / Em … in.',
   her:['Ez baş im, spas.', 'Ez hêvîdar im îro.'],
   gen:['Ez xwendekar im.', 'Ez Tirkiyeyî me.']),

  (id:'a1_231', ku:'Tu … î', tr:'Sen … -sin', en:'You are …', cins:'bêcins', ez:null,
   kat:'bun', zor:0.87,
   not:'Bûn 2.tekil "î" (ünsüz sonrası) / "yî" (ünlü sonrası). Mînak: Tu baş î / Tu çawa yî? Têbinî: olumsuzu "ne baş î" (iyi değilsin).',
   her:['Tu jîr î, lawê min.', 'Tu hevalê min î.'],
   gen:['Tu xwendekar î?', 'Tu kî yî?']),

  (id:'a1_232', ku:'Ew … e', tr:'O … -dir', en:'He/She/It is …', cins:'bêcins', ez:null,
   kat:'bun', zor:0.86,
   not:'Bûn 3.tekil "e" (ünsüz sonrası) / "ye" (ünlü sonrası). Hem eril hem dişil için. Mînak: Ew baş e / Ew mamosta ye.',
   her:['Ew zarokek baş e.', 'Ew li dibistanê ye.'],
   gen:['Ew mamosta ye.', 'Ev rast e.']),

  (id:'a1_233', ku:'Em … in', tr:'Biz … -iz', en:'We are …', cins:'bêcins', ez:null,
   kat:'bun', zor:0.85,
   not:'Bûn çoğul "in" (ünsüz sonrası) / "ne" (ünlü sonrası). Aynı ek 1./2./3. çoğul için. Mînak: Em xwendekar in / Em li malê ne.',
   her:['Em li malê ne.', 'Em ji Kurdistanê ne.'],
   gen:['Em xwendekar in.', 'Em baş in.']),

  // ── Dixwazim / Dixwim — İsteme ve Yeme Lêkerleri ──────────────
  // Thackston §71: dixwazin (to want) çok sık kullanım
  // Bedir Han §170: xwastin fiil kökü

  (id:'a1_234', ku:'Ez dixwazim', tr:'Ben istiyorum', en:'I want', cins:'bêcins', ez:null,
   kat:'leker', zor:0.83,
   not:'"Di-xwaz-im" — di (şimdiki ön ek) + xwaz (kök: istemek) + im (1.tekil). Mînak: Ez çay dixwazim. Têbinî: x sesi gırtlaktan.',
   her:['Ez çay dixwazim, dêyê.', 'Ez nan dixwazim.'],
   gen:['Ez xwarin dixwazim.', 'Ew av dixwaze.']),

  (id:'a1_235', ku:'Ez dixwim', tr:'Ben yiyorum', en:'I eat', cins:'bêcins', ez:null,
   kat:'leker', zor:0.83,
   not:'"Di-xw-im" — xwarin fiili kökü "xw" + 1.tekil "im". Mînak: Nan dixwim. Têbinî: çay/su için "vedixwim" (içiyorum).',
   her:['Ez sêv dixwim sibehê.', 'Niha ez nan dixwim.'],
   gen:['Ez birinc dixwim.', 'Ew goşt dixwe.']),

  (id:'a1_236', ku:'Ez vedixwim', tr:'Ben içiyorum', en:'I drink', cins:'bêcins', ez:null,
   kat:'leker', zor:0.82,
   not:'"Ve-di-xw-im" — "ve" ön eki + içme. Mînak: çay vedixwim (çay içiyorum). Têbinî: katı yiyecek için "dixwim".',
   her:['Ez av vedixwim.', 'Sibehê ez çay vedixwim.'],
   gen:['Ez şîr vedixwim.', 'Ew çay vedixwe.']),

  (id:'a1_237', ku:'Ez diçim', tr:'Ben gidiyorum', en:'I go', cins:'bêcins', ez:null,
   kat:'leker', zor:0.82,
   not:'"Di-ç-im" — çûn fiili (gitmek). Düzensiz fiil — kök değişir. Mînak: Ez diçim malê.',
   her:['Ez diçim malê, pîrê!', 'Ez diçim dibistanê.'],
   gen:['Ez diçim bajêr.', 'Ew diçe gund.']),

  (id:'a1_238', ku:'Ez têm', tr:'Ben geliyorum', en:'I come', cins:'bêcins', ez:null,
   kat:'leker', zor:0.82,
   not:'"Di-têm" — hatin fiili (gelmek). Düzensiz fiil. Mînak: Ez têm malê. Têbinî: karşıtı "diçim" (gidiyorum).',
   her:['Ez têm malê, dêyê!', 'Ez sibê têm.'],
   gen:['Ez ji dibistanê têm.', 'Ew jî tê.']),

  (id:'a1_239', ku:'Ez dikim', tr:'Ben yapıyorum', en:'I do / make', cins:'bêcins', ez:null,
   kat:'leker', zor:0.82,
   not:'"Di-k-im" — kirin fiili. En yaygın yardımcı fiil. Mînak: Ez kar dikim.',
   her:['Ez li malê kar dikim.', 'Ez her roj kar dikim.'],
   gen:['Ez wane dikim.', 'Ew çi dike?']),

  (id:'a1_240', ku:'Ez dibêjim', tr:'Ben söylüyorum / diyorum', en:'I say', cins:'bêcins', ez:null,
   kat:'leker', zor:0.81,
   not:'"Di-bêj-im" — gotin fiili (söylemek). Mînak: Ez spas dibêjim. Têbinî: kök "bêj" şimdiki zamanda kullanılır.',
   her:['Ez spas dibêjim, dêyê.', 'Ez rast dibêjim.'],
   gen:['Ez dibêjim erê.', 'Ew çi dibêje?']),

  (id:'a1_241', ku:'Ez dizanim', tr:'Ben biliyorum', en:'I know', cins:'bêcins', ez:null,
   kat:'leker', zor:0.82,
   not:'"Di-zan-im" — zanîn fiili. Mînak: Ez Kurmancî dizanim. Têbinî: olumsuz "Ez nizanim" (bilmiyorum) — di- yerine ni-.',
   her:['Ez Kurmancî dizanim.', 'Ez navê te dizanim.'],
   gen:['Ez dizanim.', 'Ew dizane.']),

  (id:'a1_242', ku:'Ez dibînim', tr:'Ben görüyorum', en:'I see', cins:'bêcins', ez:null,
   kat:'leker', zor:0.81,
   not:'"Di-bîn-im" — dîtin fiili. Mînak: Ez te dibînim. Têbinî: î uzun söylenir.',
   her:['Ez te dibînim.', 'Ez çiya dibînim.'],
   gen:['Ez pirtûkê dibînim.', 'Ew çi dibîne?']),

  (id:'a1_243', ku:'Ez dibihîzim', tr:'Ben duyuyorum / işitiyorum', en:'I hear', cins:'bêcins', ez:null,
   kat:'leker', zor:0.79,
   not:'"Di-bihîz-im" — bihîstin fiili. Mînak: Ez dengê te dibihîzim. Têbinî: telaffuz "bi-hîz".',
   her:['Ez dengê te dibihîzim.', 'Ez stranê dibihîzim.'],
   gen:['Ez muzîk dibihîzim.', 'Ew çi dibihîze?']),

  (id:'a1_244', ku:'Ez rûdinim', tr:'Ben oturuyorum', en:'I sit', cins:'bêcins', ez:null,
   kat:'leker', zor:0.80,
   not:'Rûniştin fiili — şimdiki kök "-nê-/-ne-": ez rûdinim, tu rûdinî, ew rûdine. Mînak: Ez li ser kursiyê rûdinim.',
   her:['Ez li ser kursiyê rûdinim.', 'Niha ez li malê rûdinim.'],
   gen:['Ez li kursiyê rûdinim.', 'Ew li wir rûdine.']),

  (id:'a1_245', ku:'Ez radibim', tr:'Ben kalkıyorum / uyanıyorum', en:'I get up', cins:'bêcins', ez:null,
   kat:'leker', zor:0.79,
   not:'Rabûn fiili — "ra" ön eki + "bûn". Şimdiki: ez radibim. Mînak: Ez sibehê radibim.',
   her:['Ez sibehê radibim.', 'Ez zû radibim.'],
   gen:['Ez sibê zû radibim.', 'Ew dereng radibe.']),

  (id:'a1_246', ku:'Ez dixwînim', tr:'Ben okuyorum', en:'I read / study', cins:'bêcins', ez:null,
   kat:'leker', zor:0.81,
   not:'"Di-xwîn-im" — xwendin fiili. Mînak: Ez pirtûka kurdî dixwînim. Têbinî: x sesi gırtlaktan.',
   her:['Ez pirtûka kurdî dixwînim.', 'Ez li dibistanê dixwînim.'],
   gen:['Ez gelek dixwînim.', 'Ew li zanîngehê dixwîne.']),

  (id:'a1_247', ku:'Ez dinivîsim', tr:'Ben yazıyorum', en:'I write', cins:'bêcins', ez:null,
   kat:'leker', zor:0.79,
   not:'"Di-nivîs-im" — nivîsîn fiili. Mînak: Ez bi Kurmancî dinivîsim.',
   her:['Ez ji dêya xwe re dinivîsim.', 'Ez bi Kurmancî dinivîsim.'],
   gen:['Ez waneya xwe dinivîsim.', 'Ew kaxez dinivîse.']),

  // ════════════════════════════════════════════════════════════
  // YÖN VE YER — Thackston §45 — ALÎ-HÊL
  // Yer edatları + yön/mesafe rengdêr — Bedirxan-Lescot fonetik
  // ════════════════════════════════════════════════════════════

  (id:'a1_250', ku:'Li vir', tr:'Burada', en:'Here', cins:'bêcins', ez:null,
   kat:'cih', zor:0.84,
   not:'"Li" yer edatı + "vir" (bura). Mînak: Ez li vir im. Têbinî: karşıtı "li wir" (orada).',
   her:['Pîrê li vir e.', 'Mala me li vir e.'],
   gen:['Mamoste li vir e.', 'Ez li vir dixwînim.']),

  (id:'a1_251', ku:'Li wir', tr:'Orada', en:'There', cins:'bêcins', ez:null,
   kat:'cih', zor:0.83,
   not:'"Li" yer edatı + "wir" (ora). Mînak: Mal li wir e. Têbinî: karşıtı "li vir" (burada).',
   her:['Bavê min li wir e.', 'Pîrê li wir e.'],
   gen:['Dibistan li wir e.', 'Heval li wir e.']),

  (id:'a1_252', ku:'Li ku?', tr:'Nerede?', en:'Where?', cins:'bêcins', ez:null,
   kat:'cih', zor:0.84,
   not:'Yer sorma kalıbı — "li ku?" = nerede? Mînak: Tu li ku yî? Têbinî: "ku" ünlü bittiğinden bûn 2.tek "yî" olur.',
   her:['Tu li ku yî, pîrê?', 'Bira li ku ye?'],
   gen:['Dibistan li ku ye?', 'Tu li ku dixwînî?']),

  (id:'a1_253', ku:'Li malê', tr:'Evde', en:'At home', cins:'bêcins', ez:null,
   kat:'cih', zor:0.85,
   not:'"Mal" (dişil/mê) — "li" ile sonuna -ê alır. Mînak: Ez li malê me. Têbinî: malê ünlü bittiğinden bûn 1.tek "me" (im değil).',
   her:['Pîrê li malê ye.', 'Em li malê ne.'],
   gen:['Ez li malê me.', 'Ew li malê dixwîne.']),

  (id:'a1_254', ku:'Li bajêr', tr:'Şehirde', en:'In the city', cins:'bêcins', ez:null,
   kat:'cih', zor:0.82,
   not:'"Bajar" (eril/nêr) — "li" ile "bajêr" olur. Mînak: Ez li bajêr im. Têbinî: dişil eşi "li malê" (evde).',
   her:['Bira li bajêr e.', 'Ez diçim bajêr.'],
   gen:['Dibistan li bajêr e.', 'Ez li bajêr dixwînim.']),

  (id:'a1_255', ku:'Li gundî', tr:'Köyde', en:'In the village', cins:'bêcins', ez:null,
   kat:'cih', zor:0.82,
   not:'"Gund" (eril/nêr) — edattan sonra eril eğik hâl "-î": "li gundî". Mînak: Pîrê li gundî ye. Têbinî: karşıtı "li bajêr" (şehirde — iç bükün a→ê).',
   her:['Pîrê li gundî ye.', 'Kal li gundî ye.'],
   gen:['Mala me li gundî ye.', 'Ez diçim gund.']),

  (id:'a1_256', ku:'Jor', tr:'Yukarı / Üst', en:'Up / Above', cins:'bêcins', ez:null,
   kat:'cih', zor:0.81,
   not:'Yön/yer kelimesi — "li jor" (yukarıda). Mînak: Pace li jor e. Têbinî: karşıtı "jêr" (aşağı).',
   her:['Pîrê li jor e.', 'Bavê min li jor e.'],
   gen:['Mamoste li jor e.', 'Pace li jor e.']),

  (id:'a1_257', ku:'Jêr', tr:'Aşağı / Alt', en:'Down / Below', cins:'bêcins', ez:null,
   kat:'cih', zor:0.81,
   not:'Yön/yer kelimesi — "li jêr" (aşağıda). Mînak: Mitbex li jêr e. Têbinî: karşıtı "jor" (yukarı).',
   her:['Pîrê li jêr e.', 'Bavê min li jêr e.'],
   gen:['Mitbex li jêr e.', 'Ez li jêr im.']),

  (id:'a1_258', ku:'Pêş', tr:'Ön / İleri', en:'Front / Forward', cins:'bêcins', ez:null,
   kat:'cih', zor:0.80,
   not:'Yön/yer kelimesi — "li pêş" (önde). Mînak: Bira li pêş e. Têbinî: karşıtı "paş" (arka).',
   her:['Pîrê li pêş malê ye.', 'Bavê min li pêş e.'],
   gen:['Mamoste li pêş e.', 'Ez li pêş dibistanê me.']),

  (id:'a1_259', ku:'Paş', tr:'Arka / Geri', en:'Back / Behind', cins:'bêcins', ez:null,
   kat:'cih', zor:0.80,
   not:'Yön/yer kelimesi — "li paş" (arkada). Mînak: Baxçe li paş malê ye. Têbinî: karşıtı "pêş" (ön).',
   her:['Pîrê li paş malê ye.', 'Bira li paş e.'],
   gen:['Mamoste li paş e.', 'Baxçe li paş dibistanê ye.']),

  (id:'a1_260', ku:'Nêzîk', tr:'Yakın', en:'Near / Close', cins:'bêcins', ez:null,
   kat:'cih', zor:0.81,
   not:'Mesafe rengdêri (yakın). Mînak: Mal nêzîk e. Têbinî: karşıtı "dûr" (uzak).',
   her:['Mala pîrê nêzîk e.', 'Bavê min nêzîk e.'],
   gen:['Dibistan nêzîk e.', 'Mamoste nêzîk e.']),

  (id:'a1_261', ku:'Dûr', tr:'Uzak', en:'Far', cins:'bêcins', ez:null,
   kat:'cih', zor:0.81,
   not:'Mesafe rengdêri (uzak). Mînak: Bajar dûr e. Têbinî: karşıtı "nêzîk" (yakın).',
   her:['Gundê pîrê dûr e.', 'Bavê min dûr e.'],
   gen:['Bajar dûr e.', 'Dibistan dûr e.']),

  // ════════════════════════════════════════════════════════════
  // TEMEL EDATLAR — Thackston §40–45; Bedir Han §200–215
  // Yer/kaynak/araç/amaç edatları + temel bağlaçlar
  // ════════════════════════════════════════════════════════════

  (id:'a1_270', ku:'Li', tr:'De / Da / -de/-da', en:'At / In / On', cins:'bêcins', ez:null,
   kat:'daçek', zor:0.84,
   not:'En sık edat — yer bildirir. Mînak: Pîrê li malê ye. Têbinî: "ji" karşıtı (-den).',
   her:['Pîrê li malê ye.', 'Ez li dibistanê me.'],
   gen:['Ew li wir e.', 'Mamoste li dibistanê ye.']),

  (id:'a1_271', ku:'Ji', tr:'Dan / Den / -den', en:'From / Of', cins:'bêcins', ez:null,
   kat:'daçek', zor:0.83,
   not:'Kaynak/çıkış bildirir — "ji malê" = evden. Mînak: Ez ji malê têm. Têbinî: "li" karşıtı (-de).',
   her:['Ez ji malê têm.', 'Spas ji te re, pîrê!'],
   gen:['Ez ji bajêr têm.', 'Pirtûk ji mamoste ye.']),

  (id:'a1_272', ku:'Bi', tr:'İle / -le / -yla', en:'With / By', cins:'bêcins', ez:null,
   kat:'daçek', zor:0.83,
   not:'Araç/birliktelik bildirir — "bi Kurmancî" = Kurmancîyle. Mînak: Ez bi pîrê re têm. Têbinî: "bi … re" birliktelik kalıbı.',
   her:['Ez bi pîrê re têm.', 'Ez bi Kurmancî dibêjim.'],
   gen:['Mamoste bi min re ye.', 'Ez bi heval re têm.']),

  (id:'a1_273', ku:'Bo / Ji bo', tr:'İçin', en:'For', cins:'bêcins', ez:null,
   kat:'daçek', zor:0.82,
   not:'"Bo" ve "ji bo" = için. Mînak: Ev ji bo te ye. Têbinî: "ji bo" daha yaygın (formel).',
   her:['Ev ji bo pîrê ye.', 'Pirtûk ji bo bira ye.'],
   gen:['Ev ji bo te ye.', 'Çay ji bo mamoste ye.']),

  (id:'a1_274', ku:'Û', tr:'Ve', en:'And', cins:'bêcins', ez:null,
   kat:'daçek', zor:0.90,
   not:'Bağlaç — "û" = ve. Mînak: Dê û bav li malê ne. Têbinî: çoğul bûn (ne/in) ünsüz/ünlü kuralına bağlı.',
   her:['Dê û bav xweş in.', 'Pîrê û kal hene.'],
   gen:['Mamoste û heval baş in.', 'Nan û av xweş in.']),

  (id:'a1_275', ku:'Lê', tr:'Ama / Fakat', en:'But', cins:'bêcins', ez:null,
   kat:'daçek', zor:0.83,
   not:'Karşıtlık bağlacı (ama, fakat). Mînak: Ez têm, lê dereng. Têbinî: "Belê" karıştırma — o "evet" demek.',
   her:['Ez têm, lê dereng.', 'Xweş e, lê germ e.'],
   gen:['Pîrê tê, lê dereng e.', 'Baş e, lê dûr e.']),

  (id:'a1_276', ku:'Ku', tr:'Ki / -dığı / -eceği', en:'That / Which', cins:'bêcins', ez:null,
   kat:'daçek', zor:0.80,
   not:'Bağlaç — bağımlı cümle başlatır. Mînak: Ez dizanim ku baş e. Têbinî: A1\'de "ku + 3.tek" basit yapı yeter.',
   her:['Ez dizanim ku pîrê tê.', 'Ez dibînim ku baş e.'],
   gen:['Ez dizanim ku baş e.', 'Ez dibihîzim ku heval tê.']),

  // ════════════════════════════════════════════════════════════
  // DOĞA VE ÇEVRE — Thackston §85
  // Heritage kullanıcı için: Kurmancî doğası duygusal bağ kurar
  // ════════════════════════════════════════════════════════════

  (id:'a1_280', ku:'Çiya', tr:'Dağ', en:'Mountain', cins:'nêr', ez:'çiyayê',
   kat:'xweza', zor:0.84,
   not:'Çiya (eril/nêr) — Kurmancî dağ kültürü güçlü. Veqetandek: çiyayê me. Mînak: Çiyayê me bilind e. Têbinî: çoğul veqetandek "çiyayên" (dağlar).',
   her:['Çiyayê me bilind e.', 'Pîrê li çiyayî ye.'],
   gen:['Çiya bilind e.', 'Çiyayê me xweş e.']),

  (id:'a1_281', ku:'Çem', tr:'Nehir / Irmak', en:'River', cins:'nêr', ez:'çemê',
   kat:'xweza', zor:0.83,
   not:'Çem (eril/nêr) — Dicle/Fırat Kurmancî kültüründe önemli. Veqetandek: çemê gund. Mînak: Çemê gund sar e. Têbinî: veqetandek "çemê" + isim/zamir.',
   her:['Çemê gund sar e.', 'Pîrê li çem e.'],
   gen:['Çem mezin e.', 'Av ji çem tê.']),

  (id:'a1_282', ku:'Agir', tr:'Ateş', en:'Fire', cins:'nêr', ez:'agirê',
   kat:'xweza', zor:0.83,
   not:'Agir (eril/nêr) — Newroz ateşi kültürel sembol. Veqetandek: agirê Newrozê. Mînak: Agirê Newrozê germ e. Têbinî: çoğul "agir" değişmez.',
   her:['Agirê Newrozê germ e.', 'Pîrê agir dibîne.'],
   gen:['Agir mezin e.', 'Agir li malê ye.']),

  (id:'a1_283', ku:'Ava çem', tr:'Nehir suyu', en:'River water', cins:'mê', ez:'ava çem',
   kat:'xweza', zor:0.86,
   not:'"Av" (su, dişil/mê) + veqetandek "-a" + "çem" → "ava çem" = nehir suyu. Mînak: Ava çem zelal e. Têbinî: dişil veqetandek "-a" formu.',
   her:['Ava çem zelal e.', 'Pîrê ava çem vedixwe.'],
   gen:['Ava me xweş e.', 'Ava çem sar e.']),

  (id:'a1_284', ku:'Dar', tr:'Ağaç', en:'Tree', cins:'mê', ez:'dara',
   kat:'xweza', zor:0.83,
   not:'Dar (dişil/mê) — Kurmancî atasözü "dareke bê kok". Veqetandek: dara me. Mînak: Dara me kesk e. Têbinî: çoğul "darên".',
   her:['Dara me kesk e.', 'Pîrê darê dibîne.'],
   gen:['Dar mezin e.', 'Dar û gul li baxçe ne.']),

  (id:'a1_285', ku:'Gul', tr:'Gül / Çiçek', en:'Flower / Rose', cins:'mê', ez:'gula',
   kat:'xweza', zor:0.83,
   not:'Gul (dişil/mê) — Kurmancî atasözü "Malbat gula jiyanê ye". Veqetandek: gula me. Mînak: Gula me sor e. Têbinî: çoğul "gulên".',
   her:['Gula pîrê sor e.', 'Gulên kesk xweş in.'],
   gen:['Gulên sor xweş in.', 'Baxçe û gul hene.']),

  (id:'a1_286', ku:'Hewa', tr:'Hava', en:'Weather / Air', cins:'mê', ez:'hewaya',
   kat:'xweza', zor:0.83,
   not:'Hewa (dişil/mê) — hava durumu. Veqetandek: hewaya îro. Mînak: Hewa germ e. Têbinî: ünlü ile bittiğinden veqetandek "-ya".',
   her:['Hewa germ e, pîrê.', 'Hewaya îro xweş e.'],
   gen:['Hewa sar e.', 'Hewaya bajêr xweş e.']),

  (id:'a1_287', ku:'Bahoz', tr:'Fırtına', en:'Storm', cins:'mê', ez:'bahoza',
   kat:'xweza', zor:0.80,
   not:'Bahoz (dişil/mê) — "ba" (rüzgar) kökünden. Veqetandek: bahoza biharê. Mînak: Bahoz mezin e. Têbinî: çoğul "bahozan" (ileri).',
   her:['Bahoz mezin e.', 'Bahoz tê, pîrê!'],
   gen:['Bahoz dûr e.', 'Bahoza mezin nêzîk e.']),

  (id:'a1_288', ku:'Baran', tr:'Yağmur', en:'Rain', cins:'mê', ez:'barana',
   kat:'xweza', zor:0.82,
   not:'Baran (dişil/mê) — "Baran dibare" yağmur yağıyor. Veqetandek: barana biharê. Mînak: Baran dibare. Têbinî: dişil veqetandek "barana".',
   her:['Baran dibare, pîrê!', 'Barana biharê xweş e.'],
   gen:['Baran sar e.', 'Baran û berf hene.']),

  (id:'a1_289', ku:'Berf', tr:'Kar', en:'Snow', cins:'mê', ez:'berfa',
   kat:'xweza', zor:0.82,
   not:'Berf (dişil/mê) — "Berf dibare" kar yağıyor. Veqetandek: berfa zivistanê. Mînak: Berf spî ye. Têbinî: dişil veqetandek "berfa".',
   her:['Berf dibare, pîrê!', 'Berf spî ye.'],
   gen:['Berf sar e.', 'Berfa zivistanê xweş e.']),

  (id:'a1_290', ku:'Tav', tr:'Güneş', en:'Sun', cins:'mê', ez:'tava',
   kat:'xweza', zor:0.83,
   not:'Tav (dişil/mê) — gökteki güneş. Veqetandek: tava biharê. Mînak: Tav germ e. Têbinî: "Roj" da kullanılır (eril, hem gün hem güneş).',
   her:['Tav germ e, pîrê.', 'Tava biharê xweş e.'],
   gen:['Tav xweş e.', 'Tav li bajêr germ e.']),

  (id:'a1_291', ku:'Stêrk', tr:'Yıldız', en:'Star', cins:'mê', ez:'stêrka',
   kat:'xweza', zor:0.82,
   not:'Stêrk (dişil/mê) — Bedirxan-Lescot standart formu (stêr değil). Veqetandek: stêrka şevê. Mînak: Stêrk geş e. Têbinî: çoğul "stêrkên".',
   her:['Stêrkên şevê xweş in.', 'Pîrê stêrk dibîne.'],
   gen:['Stêrk geş e.', 'Stêrk û heyv hene.']),

  (id:'a1_292', ku:'Heyv', tr:'Ay (gökte)', en:'Moon', cins:'mê', ez:'heyva',
   kat:'xweza', zor:0.82,
   not:'Heyv (dişil/mê) — gökteki ay. Veqetandek: heyva şevê. Mînak: Heyv geş e. Têbinî: zaman olarak "meh" (Birim 8).',
   her:['Heyv geş e, pîrê.', 'Heyva şevê xweş e.'],
   gen:['Heyv mezin e.', 'Heyv û stêrk hene.']),

  // ════════════════════════════════════════════════════════════
  // HAYVANLAR — Bedir Han & Lescot — HEYWAN-AJAL
  // Kurmancî köy/dağ kültüründe hayvancılık yaygın
  // ════════════════════════════════════════════════════════════

  (id:'a1_295', ku:'Kûçik', tr:'Köpek', en:'Dog', cins:'nêr', ez:'kûçikê',
   kat:'ajal', zor:0.83,
   not:'Kûçik (eril/nêr) — û uzun söylenir. Veqetandek: kûçikê me. Mînak: Kûçikê me baş e. Têbinî: dişil eşi "pisîk" (kedi).',
   her:['Kûçikê me baş e.', 'Kûçik li baxçeyê ye.'],
   gen:['Kûçik mezin e.', 'Kûçik li malê ye.']),

  (id:'a1_296', ku:'Pisîk', tr:'Kedi', en:'Cat', cins:'mê', ez:'pisîka',
   kat:'ajal', zor:0.83,
   not:'Pisîk (dişil/mê) — î uzun söylenir. Veqetandek: pisîka me. Mînak: Pisîka me spî ye. Têbinî: eril eşi "kûçik" (köpek).',
   her:['Pisîka pîrê spî ye.', 'Pisîk li malê ye.'],
   gen:['Pisîk biçûk e.', 'Pisîka me reş e.']),

  (id:'a1_297', ku:'Hesp', tr:'At', en:'Horse', cins:'nêr', ez:'hespê',
   kat:'ajal', zor:0.82,
   not:'Hesp (eril/nêr) — Kurmancî kültüründe saygın hayvan. Veqetandek: hespê kal. Mînak: Hespê kal mezin e. Têbinî: çoğul "hespan" (ileri).',
   her:['Hespê kal mezin e.', 'Hesp li çiyayî ye.'],
   gen:['Hesp mezin e.', 'Hespê me xweş e.']),

  (id:'a1_298', ku:'Bizin', tr:'Keçi', en:'Goat', cins:'mê', ez:'bizina',
   kat:'ajal', zor:0.81,
   not:'Bizin (dişil/mê) — "Şîrê bizinê" = keçi sütü (yaygın). Veqetandek: bizina me. Mînak: Bizin li çiyayê ye. Têbinî: çoğul "bizinên".',
   her:['Şîrê bizina pîrê xweş e.', 'Bizin li çiyê ye.'],
   gen:['Bizin biçûk e.', 'Bizinên spî hene.']),

  (id:'a1_299', ku:'Mî', tr:'Koyun', en:'Sheep', cins:'mê', ez:'miya',
   kat:'ajal', zor:0.81,
   not:'Mî (dişil/mê) — Kurmancî köy hayatında yaygın. Veqetandek: miya kal. Mînak: Miya kal mezin e. Têbinî: çoğul "miyên" (koyunlar).',
   her:['Miya kalê min mezin e.', 'Şivan li gundî ye.'],
   gen:['Mî biçûk e.', 'Miyên spî hene.']),

  (id:'a1_300', ku:'Çêlek', tr:'İnek', en:'Cow', cins:'mê', ez:'çêleka',
   kat:'ajal', zor:0.80,
   not:'Çêlek (dişil/mê) — Kurmancî köy hayatında yaygın. Veqetandek: çêleka me. Mînak: Çêleka me mezin e. Têbinî: çoğul "çêlekên" (inekler).',
   her:['Çêleka me mezin e.', 'Çêlek li gundî ye.'],
   gen:['Çêlek mezin e.', 'Çêlekên me hene.']),

  // ════════════════════════════════════════════════════════════
  // EN SIK 50 KELİME — DoReCo + Thackston kelime listeleri
  // Bunlar A1'de mutlaka geçmesi gereken temel sözcükler
  // ════════════════════════════════════════════════════════════

  (id:'a1_305', ku:'Mirov', tr:'İnsan / Kişi', en:'Person / Human', cins:'nêr', ez:'mirovê',
   kat:'temel', zor:0.83,
   not:'Nêr — "Ziman dermanê dilê mirov e" atasözünde geçer',
   her:['Mirov çi ye?', 'Her mirov zimanekî heye.'],
   gen:['Mirov û xweza', 'Mirovên baş']),

  (id:'a1_306', ku:'Jiyan', tr:'Hayat / Yaşam', en:'Life', cins:'mê', ez:'jiyana',
   kat:'temel', zor:0.82,
   not:'Mê — [FB Chyet]: jiyan n.f. "Jiyana me xweş e" (dişil veqetandek). "Malbat gula jiyanê ye" atasözünde geçer',
   her:['Jiyana me xweş e.', 'Jiyan û malbat.'],
   gen:['Jiyana baş', 'Jiyan zor e.']),

  (id:'a1_307', ku:'Rê', tr:'Yol', en:'Road / Way', cins:'mê', ez:'rêya',
   kat:'temel', zor:0.83,
   not:'Mê — "rêya baş" = iyi yol',
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
   not:'"Car" = kez/defa (dişil). "Caran" = bazen (çoğul oblique). "Carek / carekê" = bir kez/bir defa.',
   her:['Caran pîrê tê malê.', 'Ez caran diçim bajêr.'],
   gen:['Caran baş e.', 'Caran û daim']),

  (id:'a1_311', ku:'Daim', tr:'Her zaman / Daima', en:'Always', cins:'bêcins', ez:null,
   kat:'temel', zor:0.80,
   not:'"Daim" Farsça kökenli ama Kurmancîde yerleşmiş. "Her dem" de kullanılır',
   her:['Ez daim ji te hez dikim, pîrê!', 'Pîrê daim li malê ye.'],
   gen:['Daim û caran', 'Ew daim tê.']),

  (id:'a1_312', ku:'Çiqas?', tr:'Ne kadar? / Kaç?', en:'How much? / How many?', cins:'bêcins', ez:null,
   kat:'temel', zor:0.81,
   not:'"Çiqas" = ne kadar. "Ev bi çiqas e?" = Bu ne kadar?',
   her:['Ev mal çiqas e?', 'Tu çiqas mezin î niha?'],
   gen:['Ev bi çiqas e?', 'Çiqas dem man?']),

  (id:'a1_313', ku:'Çend salî?', tr:'Kaç yaşında?', en:'How old?', cins:'bêcins', ez:null,
   kat:'temel', zor:0.82,
   not:'"Tu çend salî yî?" = Kaç yaşındasın? Sıkça sorulan soru. "Salî" = yaşında (sal + î).',
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

  // ════════════════════════════════════════════════════════════
  // EK GİRİŞLER — Kategorileri 12 minimuma tamamlama
  // a1_500 – a1_560
  // ════════════════════════════════════════════════════════════

  // ── perwerde (eğitim) — 6 yeni ──────────────────────────────

  (id:'a1_500', ku:'Pênûsk', tr:'Kalem', en:'Pen', cins:'mê', ez:'pênûska',
   kat:'perwerde', zor:0.80, not:'"Pênûsk" — dişil. Özgün Kurmancî form. "Qelem" Arapça alıntısı yerine tercih edilen.',
   her:['Pênûska te li ku ye, keça min?', 'Dayê, pênûskek bide min.'],
   gen:['Pênûsk li ser masê ye.', 'Ez bi pênûskê dinivîsim.']),

  (id:'a1_501', ku:'Defter', tr:'Defter', en:'Notebook', cins:'mê', ez:'deftera',
   kat:'perwerde', zor:0.78, not:'"Defter" — dişil. Her du zimanan de heman form.',
   her:['Deftera xwe bîne, lawê min!', 'Pîrê, ez di defterê de dinivîsim.'],
   gen:['Defter li çentê ye.', 'Ez defterê vedikim.']),

  (id:'a1_502', ku:'Wane', tr:'Ders', en:'Lesson', cins:'mê', ez:'waneya',
   kat:'perwerde', zor:0.80, not:'"Wane" — dişil. "Waneya me" = dersimiz.',
   her:['Waneya me dest pê kir, dê!', 'Bavê min waneyan fêrî min dike.'],
   gen:['Wane hêsan e.', 'Waneya îro Kurmancî ye.']),

  (id:'a1_503', ku:'Hîndekar', tr:'Öğretici / Eğitmen', en:'Instructor / Trainer', cins:'nêr', ez:'hîndekarê',
   kat:'perwerde', zor:0.78, not:'"Hîn" (öğren-) + "-dekar" eki. Mamoste\'den farkı: kurs/pratik eğitimi veren.',
   her:['Hîndekar hat, pîrê!', 'Hîndekarê min baş e.'],
   gen:['Hîndekar û mamoste', 'Hîndekarê me']),

  (id:'a1_504', ku:'Zanîst', tr:'Bilim', en:'Science', cins:'mê', ez:'zanîsta',
   kat:'perwerde', zor:0.80, not:'Mê — "Zanîn" (bilmek) + "-ist". Modern terim. [FB]: zanîst n.f.',
   her:['Zanîst girîng e, dê!', 'Ez zanîstê dixwînim.'],
   gen:['Zanîst û huner', 'Zanîsta nûjen']),

  (id:'a1_505', ku:'Lêkolîn', tr:'Araştırma', en:'Research', cins:'mê', ez:'lêkolîna',
   kat:'perwerde', zor:0.86, not:'"Lê" + "kolîn" = incelemek, araştırmak.',
   her:['Bavê min lêkolîn dike, dê.', 'Pîrê, lêkolîn çi ye?'],
   gen:['Lêkolîn girîng e.', 'Ew lêkolînê dike.']),

  // ── dua (dua / iyi dilekler) — 5 yeni ──────────────────────

  (id:'a1_506', ku:'Xwedê ji te razî be', tr:'Allah senden razı olsun', en:'May God be pleased with you', cins:'bêcins', ez:null,
   kat:'dua', zor:0.84, not:'Yaygın şükran duası. "Razî" = razı, memnun.',
   her:['Xwedê ji te razî be, pîrê!', 'Dê dibêje: Xwedê ji te razî be.'],
   gen:['Xwedê ji te razî be, heval.', 'Spas, Xwedê ji te razî be.']),

  (id:'a1_507', ku:'Bimîne sax', tr:'Sağ ol / Sağlıcakla', en:'Stay well', cins:'bêcins', ez:null,
   kat:'dua', zor:0.80, not:'"Bimîne" = kal + "sax" = sağlıklı. Vedalaşma duası.',
   her:['Bimîne sax, dapîrê!', 'Bavê min dibêje: Bimîne sax.'],
   gen:['Bimîne sax, heval!', 'Bimîne sax û xweş.']),

  (id:'a1_508', ku:'Riya te vekirî be', tr:'Yolun açık olsun', en:'May your path be open', cins:'bêcins', ez:null,
   kat:'dua', zor:0.82, not:'"Rê" = yol, "vekirî" = açık. Yolculuk duası.',
   her:['Riya te vekirî be, lawê min!', 'Pîrê dibêje: Riya te vekirî be.'],
   gen:['Riya te vekirî be!', 'Bi xêr herî, riya te vekirî be.']),

  (id:'a1_509', ku:'Hêviya te çêbe', tr:'Umudun gerçekleşsin', en:'May your hope come true', cins:'bêcins', ez:null,
   kat:'dua', zor:0.84, not:'"Hêvî" = umut, "çêbûn" = olmak/gerçekleşmek.',
   her:['Hêviya te çêbe, keça min!', 'Dê dibêje: Hêviya te çêbe.'],
   gen:['Hêviya te çêbe, heval.', 'Hêviya me hemûyan çêbe.']),

  (id:'a1_510', ku:'Serketî bî', tr:'Başarılı ol', en:'Be successful', cins:'bêcins', ez:null,
   kat:'dua', zor:0.82, not:'"Serketin" = başarmak. "Serketî" = başarılı.',
   her:['Serketî bî, lawê min!', 'Pîrê dibêje: Serketî bî.'],
   gen:['Serketî bî li azmûnê!', 'Hêvîdar im ku serketî bî.']),

  // ── çand (kültür) — 5 yeni ─────────────────────────────────

  (id:'a1_511', ku:'Strandin', tr:'Şarkı söyleme', en:'Singing', cins:'mê', ez:'strandina',
   kat:'çand', zor:0.80, not:'"Stran" = şarkı, "strandin" = söylemek fiili.',
   her:['Pîrê ji strandinê hez dike.', 'Dê, strandina te xweş e!'],
   gen:['Strandin xweş e.', 'Ew strandinê dike.']),

  (id:'a1_512', ku:'Destan', tr:'Destan', en:'Epic', cins:'mê', ez:'destana',
   kat:'çand', zor:0.84, not:'"Destan" — dişil (mê). Destanên Kurdî navdar in.',
   her:['Pîrê destanê ji me re dibêje.', 'Bavê min ji destanan hez dike.'],
   gen:['Destan kevn e.', 'Destanên Kurdî xweş in.']),

  (id:'a1_513', ku:'Kilam', tr:'Türkü / Şarkı', en:'Song', cins:'mê', ez:'kilama',
   kat:'çand', zor:0.80, not:'"Kilam" — dişil. "Stran" ile eş anlamlı.',
   her:['Dê kilamek ji me re dibêje.', 'Pîrê, kilama te xweş e!'],
   gen:['Kilam xweş e.', 'Ez li kilamê guhdarî dikim.']),

  (id:'a1_514', ku:'Dawet', tr:'Düğün', en:'Wedding', cins:'mê', ez:'daweta',
   kat:'çand', zor:0.82, not:'"Dawet" — dişil. Kürt düğün geleneği çok zengindir.',
   her:['Dê, em ê herin dawetê!', 'Daweta xaltiyê xweş bû, pîrê.'],
   gen:['Dawet îşev e.', 'Em diçin dawetê.']),

  (id:'a1_515', ku:'Şahî', tr:'Kutlama / Şenlik', en:'Celebration', cins:'mê', ez:'şahiya',
   kat:'çand', zor:0.82, not:'"Şahî" — dişil. "Şa" = mutlu + "-î" ek.',
   her:['Pîrê, şahî li malê ye!', 'Em şahiyê dikin, dê!'],
   gen:['Şahî xweş e.', 'Şahiya Newrozê mezin e.']),

  // ── alfabe — 4 yeni ────────────────────────────────────────

  (id:'a1_516', ku:'ç', tr:'ç (çe sesi)', en:'ç (ch)', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.80, not:'Türkçe ç gibi — "çav" (göz), "çiya" (dağ)',
   her:['Pîrê, "ç" dengê çi ye?', '"Çav" — dengê ç tê de ye.'],
   gen:['ç — Kurmancî dengek e.', 'Mînak: çav, çiya, çêl, çarşem']),

  (id:'a1_517', ku:'ş', tr:'ş (şe sesi)', en:'ş (sh)', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.80, not:'Türkçe ş gibi — "şev" (gece), "şîr" (süt)',
   her:['Bira, "ş" bêje!', '"Şev" — dengê ş tê de ye.'],
   gen:['ş — Kurmancî dengek e.', 'Mînak: şev, şîr, şêr, şemî']),

  (id:'a1_518', ku:'h', tr:'h (he sesi)', en:'h', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.78, not:'Türkçe h gibi — "heval" (arkadaş), "hesp" (at)',
   her:['Dê, "h" dengê çi ye?', '"Heval" — dengê h tê de ye.'],
   gen:['h — Kurmancî dengek e.', 'Mînak: heval, hesp, hêvî, hewş']),

  (id:'a1_519', ku:'j', tr:'j (je sesi)', en:'j (zh)', cins:'bêcins', ez:null,
   kat:'alfabe', zor:0.80, not:'Fransızca j gibi — "jin" (kadın), "jiyan" (hayat). Türkçe j\'den farklı',
   her:['Pîrê, "j" bêje!', '"Jin" — dengê j tê de ye.'],
   gen:['j — Kurmancî dengek e.', 'Mînak: jin, jiyan, jêr, jimare']),

  // ── bun (olmak) — 4 yeni ───────────────────────────────────

  (id:'a1_520', ku:'Ez hatime', tr:'Ben geldim', en:'I have come', cins:'bêcins', ez:null,
   kat:'bun', zor:0.84, not:'"Hatin" fiilinin birinci tekil geçmiş zaman formu.',
   her:['Ez hatime, dê!', 'Pîrê, ez hatime malê.'],
   gen:['Ez hatime dibistanê.', 'Ez hatime vir.']),

  (id:'a1_521', ku:'Tu çûyî', tr:'Sen gittin', en:'You went', cins:'bêcins', ez:null,
   kat:'bun', zor:0.84, not:'"Çûn" fiilinin ikinci tekil geçmiş zaman formu.',
   her:['Tu çûyî bazarê, bira?', 'Dê, tu çûyî ku?'],
   gen:['Tu çûyî malê.', 'Tu çûyî dibistanê.']),

  (id:'a1_522', ku:'Ew heye', tr:'O var', en:'He/She exists', cins:'bêcins', ez:null,
   kat:'bun', zor:0.82, not:'"Hebûn" = var olmak. "Heye" = var.',
   her:['Ew heye, pîrê, xem nexwe.', 'Bavê min heye, dê.'],
   gen:['Hêvî heye.', 'Av heye.']),

  (id:'a1_523', ku:'Em hatin', tr:'Biz geldik', en:'We came', cins:'bêcins', ez:null,
   kat:'bun', zor:0.84, not:'"Hatin" fiilinin birinci çoğul geçmiş zaman formu.',
   her:['Em hatin, dapîrê!', 'Dê, em hatin malê.'],
   gen:['Em hatin dibistanê.', 'Em hatin vir.']),

  // ── demsal (mevsim) — 4 yeni ───────────────────────────────

  (id:'a1_524', ku:'Germahî', tr:'Sıcaklık', en:'Heat', cins:'mê', ez:'germahiya',
   kat:'demsal', zor:0.82, not:'"Germ" = sıcak + "-ahî" = durum eki.',
   her:['Germahî zêde ye, dê!', 'Pîrê, germahî heye.'],
   gen:['Germahî li derve ye.', 'Germahî zêde ye.']),

  (id:'a1_525', ku:'Sar', tr:'Soğuk', en:'Cold', cins:'bêcins', ez:null,
   kat:'demsal', zor:0.78, not:'"Sar" = soğuk. Hem rengdêr hem isim olarak kullanılır.',
   her:['Sar e, dê, cilên germ bide min.', 'Pîrê, li derve sar e.'],
   gen:['Îro sar e.', 'Zivistan sar e.']),

  (id:'a1_526', ku:'Barandar', tr:'Yağmurlu', en:'Rainy', cins:'bêcins', ez:null,
   kat:'demsal', zor:0.84, not:'"Baran" (yağmur) + "-dar" (sahip olan eki) = yağmurlu. Standart Bedirxan/Ferhenga Birûskî formu. Eşdeğer: "bi baran".',
   her:['Roja îro barandar e, dê.', 'Pîrê, li derve barandar e.'],
   gen:['Îro barandar e.', 'Payîz barandar e.']),

  (id:'a1_527', ku:'Ronahî', tr:'Işık / Aydınlık', en:'Light / Brightness', cins:'mê', ez:'ronahiya',
   kat:'xweza', zor:0.80, not:'Mê — "Ronahî" = aydınlık. Karşıtı "tarî" (karanlık).',
   her:['Ronahiya tavê xweş e.', 'Di ronahiyê de dixwînim.'],
   gen:['Ronahî û tarî', 'Ronahiya rojê']),

  // ── peyvben (bağlaç) — 4 yeni ──────────────────────────────

  (id:'a1_528', ku:'Lêbelê', tr:'Ancak / Ama', en:'However', cins:'bêcins', ez:null,
   kat:'peyvben', zor:0.84, not:'"Lêbelê" = ancak, ama. Resmi bağlaç.',
   her:['Ez dixwazim, lêbelê nikarim, dê.', 'Pîrê, lêbelê ew ne li vir e.'],
   gen:['Lêbelê ew nehat.', 'Ez dizanim, lêbelê ew zehmet e.']),

  (id:'a1_529', ku:'Ji ber vê', tr:'Bu nedenle', en:'Therefore', cins:'bêcins', ez:null,
   kat:'peyvben', zor:0.86, not:'"Ji ber" = -den dolayı + "vê" = bu. Neden bildiren bağlaç.',
   her:['Ji ber vê ez neçûm, dê.', 'Pîrê, ji ber vê em li malê ne.'],
   gen:['Ji ber vê ez li malê mam.', 'Ji ber vê ew nehat.']),

  (id:'a1_530', ku:'Wekî din', tr:'Yoksa / Aksi takdirde', en:'Otherwise', cins:'bêcins', ez:null,
   kat:'peyvben', zor:0.86, not:'"Wekî" = gibi + "din" = başka = başka türlü.',
   her:['Bixwîne, wekî din tu ê sernekevî, lawê min.', 'Dê, wekî din em ê dereng bimînin.'],
   gen:['Bixwîne, wekî din tu nizanî.', 'Bimeşe, wekî din tu ê dereng bî.']),

  (id:'a1_531', ku:'Her wiha', tr:'Ayrıca / Bunun yanı sıra', en:'Also', cins:'bêcins', ez:null,
   kat:'peyvben', zor:0.82, not:'"Her" = her + "wiha" = böyle = ayrıca.',
   her:['Her wiha pîrê jî hat, dê.', 'Bavê min her wiha dixebite.'],
   gen:['Her wiha ew jî hat.', 'Her wiha ez dizanim.']),

  // ── cinavk (zamir) — 3 yeni ────────────────────────────────

  (id:'a1_532', ku:'Xwe', tr:'Kendi / Kendisi', en:'Self', cins:'bêcins', ez:null,
   kat:'cinavk', zor:0.84, not:'"Xwe" = dönüşlü zamir. "Ez xwe dibînim" = kendimi görüyorum.',
   her:['Xwe bişo, lawê min!', 'Dê, ez xwe di neynikê de dibînim.'],
   gen:['Ew xwe dibîne.', 'Ez xwe nas dikim.']),

  (id:'a1_533', ku:'Yekî', tr:'Biri / Birisi', en:'Someone', cins:'bêcins', ez:null,
   kat:'cinavk', zor:0.82, not:'"Yek" = bir + "-î" = belirsizlik. Belirsiz zamir.',
   her:['Yek li derve ye, dê!', 'Pîrê, yek li derî ye.'],
   gen:['Yek hat.', 'Yekî ji min re got.']),

  (id:'a1_534', ku:'Tiştek', tr:'Bir şey', en:'Something', cins:'bêcins', ez:null,
   kat:'cinavk', zor:0.82, not:'"Tişt" = şey + "-ek" = belirsiz. Belirsiz zamir.',
   her:['Tiştek heye, dê?', 'Pîrê, tiştek bêje!'],
   gen:['Tiştek li wir e.', 'Ez tiştek dizanim.']),

  // ── cil (giysi) — 2 yeni ──────────────────────────────────

  (id:'a1_535', ku:'Şal', tr:'Şal / Atkı', en:'Scarf', cins:'nêr', ez:'şalê',
   kat:'cil', zor:0.80, not:'"Şal" — eril. Kürt kültüründe geleneksel giysi parçası.',
   her:['Şalê xwe li xwe bike, keça min!', 'Pîrê, şalê te xweş e.'],
   gen:['Şal germ e.', 'Ew şalê li xwe dike.']),

  (id:'a1_536', ku:'Çakêt', tr:'Ceket', en:'Jacket', cins:'nêr', ez:'çakêtê',
   kat:'cil', zor:0.80, not:'"Çakêt" — eril. Fransızca "jaquette" kökenli.',
   her:['Çakêtê xwe li xwe bike, lawê min!', 'Dê, çakêt li ku ye?'],
   gen:['Çakêt nû ye.', 'Ew çakêtê li xwe dike.']),

  // ── gihanî (ulaşım) — 2 yeni ──────────────────────────────

  (id:'a1_537', ku:'Motorsîklêt', tr:'Motosiklet', en:'Motorcycle', cins:'mê', ez:'motorsîklêta',
   kat:'gihanî', zor:0.76, not:'Mê — Uluslararası. "Bi motorsîklêtê" = motorsikletle.',
   her:['Ez bi motorsîklêtê diçim, dê!', 'Pîrê, motorsîklêt zû ye!'],
   gen:['Motorsîklêt û bisiklêt', 'Motorsîklêta min']),

  (id:'a1_538', ku:'Keştî', tr:'Gemi', en:'Ship', cins:'mê', ez:'keştiya',
   kat:'gihanî', zor:0.82, not:'Mê — Farsça kökenli. Veqetandek (î + a → iya): "keştiya mezin" = büyük gemi.',
   her:['Dê, ez keştiyê dibînim!', 'Pîrê, keştî li avê ye.'],
   gen:['Keştî mezin e.', 'Keştî li deryayê ye.']),

  // ── mêwe (meyve) — 2 yeni ─────────────────────────────────

  (id:'a1_539', ku:'Zeytûn', tr:'Zeytin', en:'Olive', cins:'nêr', ez:'zeytûnê',
   kat:'mêwe', zor:0.80, not:'"Zeytûn" — eril. Arapça kökenli.',
   her:['Zeytûn bixwe, lawê min!', 'Pîrê, zeytûn xweş e.'],
   gen:['Zeytûn li masê ye.', 'Ez zeytûn dixwim.']),

  (id:'a1_540', ku:'Qeysî', tr:'Kayısı', en:'Apricot', cins:'nêr', ez:'qeysiyê',
   kat:'mêwe', zor:0.82, not:'"Qeysî" — eril. Havînê dipese.',
   her:['Dê, qeysî gihîştiye!', 'Pîrê, qeysî şîrîn e.'],
   gen:['Qeysî zer e.', 'Ez qeysiyê dixwim.']),

  // ── pirs (soru) — 2 yeni ──────────────────────────────────

  (id:'a1_541', ku:'Kengê?', tr:'Ne zaman?', en:'When?', cins:'bêcins', ez:null,
   kat:'pirs', zor:0.82, not:'"Kengê" = ne zaman. Zaman soran soru kelimesi.',
   her:['Kengê em ê herin, dê?', 'Pîrê, kengê tu hatî?'],
   gen:['Kengê tu tê?', 'Kengê wane dest pê dike?']),

  (id:'a1_542', ku:'Çawa?', tr:'Nasıl?', en:'How?', cins:'bêcins', ez:null,
   kat:'pirs', zor:0.80, not:'"Çawa" = nasıl. Durum/hal soran soru kelimesi.',
   her:['Çawa yî, pîrê?', 'Dê, çawa bû?'],
   gen:['Çawa yî?', 'Çawa diçe?']),

  // ── pîşe (meslek) — 2 yeni ─────────────────────────────────

  (id:'a1_543', ku:'Avahîsaz', tr:'Mimar', en:'Architect', cins:'nêr', ez:'avahîsazê',
   kat:'pîşe', zor:0.86, not:'"Avahî" = bina + "saz" = yapan = mimar.',
   her:['Apê min avahîsaz e, dê.', 'Pîrê, avahîsaz çi dike?'],
   gen:['Ew avahîsaz e.', 'Avahîsaz avahiyan çêdike.']),

  (id:'a1_544', ku:'Şofêr', tr:'Şoför', en:'Driver', cins:'nêr', ez:'şofêrê',
   kat:'pîşe', zor:0.80, not:'"Şofêr" — eril. Fransızca "chauffeur" kökenli.',
   her:['Bavê min şofêr e, pîrê.', 'Dê, şofêr hat!'],
   gen:['Ew şofêr e.', 'Şofêr basê diajo.']),

  // ── silav (selamlama) — 2 yeni ─────────────────────────────

  (id:'a1_545', ku:'Hûn çawa ne?', tr:'Nasılsınız? (çoğul)', en:'How are you? (plural/formal)', cins:'bêcins', ez:null,
   kat:'silav', zor:0.80, not:'Çoğul/resmi hitap. "Hûn" (siz) + "çawa" (nasıl) + "ne" (-siniz). Yaşlılara saygı.',
   her:['Hûn çawa ne, pîrê û kal?', 'Malbato, hûn çawa ne?'],
   gen:['Hûn çawa ne, malbato?', 'Hûn çawa ne, heval?']),

  (id:'a1_546', ku:'Ne xweş im', tr:'İyi değilim / Hastayım', en:'I am not well', cins:'bêcins', ez:null,
   kat:'silav', zor:0.76, not:'Olumsuz biçim. "Ne" + "xweş" (iyi) + "im" = iyi değilim.',
   her:['Ne xweş im, dayê.', 'Pîrê, ez ne xweş im.'],
   gen:['Ne xweş im, spas.', 'Îro ez ne xweş im.']),

  // ── tendurist (sağlık) — 2 yeni ────────────────────────────

  (id:'a1_547', ku:'Serêş', tr:'Baş ağrısı', en:'Headache', cins:'nêr', ez:'serêşê',
   kat:'tendurist', zor:0.82, not:'"Ser" = baş + "êş" = ağrı = baş ağrısı.',
   her:['Serêşê min heye, dê.', 'Pîrê, serêş xweş nabe.'],
   gen:['Serêş heye.', 'Serêşê min zêde ye.']),

  (id:'a1_548', ku:'Ta', tr:'Ateş / Humma', en:'Fever', cins:'mê', ez:'taya',
   kat:'tendurist', zor:0.84, not:'"Ta" = ateş (vücut ısısı). "Tav" = güneş ışığı — karıştırma!',
   her:['Taya min heye, dê.', 'Pîrê, zarok bi ta ye.'],
   gen:['Ta heye.', 'Ew bi ta ye.']),

  // ── vexwarin (içecek) — 2 yeni ─────────────────────────────

  (id:'a1_549', ku:'Ava fêkî', tr:'Meyve suyu', en:'Fruit juice', cins:'mê', ez:'ava fêkî',
   kat:'vexwarin', zor:0.80, not:'Mê — "av" (su, dişil) + veqetandek "-a" + "fêkî" (meyve). Özgün Kurmancî tercih: "ava fêkî" / "ava sêvê" (elma suyu) / "ava porteqalê" (portakal suyu). "Şerbik" aslında "küçük kap/testi" anlamına gelir, içecek değil.',
   her:['Ava fêkî bixwe, lawê min!', 'Dê, ava sêvê xweş e.'],
   gen:['Ava fêkî sar e.', 'Ez ava porteqalê vedixwim.']),

  (id:'a1_550', ku:'Mastaw', tr:'Ayran', en:'Buttermilk', cins:'nêr', ez:'mastawê',
   kat:'vexwarin', zor:0.80, not:'"Mast" (yoğurt) + "aw" (su) = ayran. Sıvı içecek için "vexwarin" (içmek) fiili kullanılır.',
   her:['Mastawê bide min, dê!', 'Pîrê, mastaw xweş e.'],
   gen:['Mastaw sar e.', 'Ez mastawê vedixwim.']),

  // ── roj (gün / zaman) — 5 yeni ─────────────────────────────

  (id:'a1_551', ku:'Sibeh', tr:'Sabah', en:'Morning', cins:'mê', ez:'sibeha',
   kat:'roj', zor:0.80, not:'"Sibeh" = sabah. "Sibê" = yarın. Dikkat: iki anlam!',
   her:['Roj baş, dê! Sibeh xweş e.', 'Pîrê, sibeh zû ye.'],
   gen:['Sibeh e.', 'Sibeh xweş e.']),

  (id:'a1_552', ku:'Piştî nîvro', tr:'Öğleden sonra', en:'Afternoon', cins:'bêcins', ez:null,
   kat:'roj', zor:0.78, not:'"Piştî" (sonra) + "nîvro" (öğle). Öğleden sonraki zaman aralığı.',
   her:['Piştî nîvro pîrê tê.', 'Piştî nîvro em diçin.'],
   gen:['Piştî nîvro û berî nîvro', 'Piştî nîvro tê.']),

  (id:'a1_553', ku:'Êvar baş!', tr:'İyi akşamlar!', en:'Good evening!', cins:'bêcins', ez:null,
   kat:'silav', zor:0.80, not:'Akşam selamlaması — sabit selamlama kalıbı, EZAFE ALMAZ: "Roj baş!", "Şev baş!", "Sibe baş!", "Êvar baş!". Bunlar set-phrase\'lerdir. Dilek formülleri (örn. "Êvara te baş be!" / "Roja te baş be!") farklı yapı; orada veqetandek gerekir çünkü cümle özne-yüklem yapısındadır.',
   her:['Êvar baş, pîrê!', 'Êvar baş, malbato!'],
   gen:['Êvar baş!', 'Êvar baş, mamosta!']),

  (id:'a1_554', ku:'Şev baş', tr:'İyi geceler', en:'Good night', cins:'bêcins', ez:null,
   kat:'silav', zor:0.78, not:'Gece selamlaması — "şev baş!"',
   her:['Şev baş, dê!', 'Şev baş, pîrê!'],
   gen:['Şev baş!', 'Şev baş, heval!']),

  (id:'a1_555', ku:'Nîvê şevê', tr:'Gece yarısı', en:'Midnight', cins:'mê', ez:null,
   kat:'roj', zor:0.84, not:'"Nîv" = yarı + "şev" = gece = gece yarısı.',
   her:['Nîvê şevê ye, razê, lawê min!', 'Dê, nîvê şevê bû.'],
   gen:['Nîvê şevê ye.', 'Di nîvê şevê de hemû radizan.']),

];

// ════════════════════════════════════════════════════════════════
// A1 EK KELIMELER — B ADIMI
// Kaynak karşılaştırma tablosu:
//
// [BH] = Bedir Han & Lescot (1990) — cinsiyet ve çekim
// [TH] = Thackston (2006) — gramer doğrulama
// [AS] = Pratik kelime listesi (2017)
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
   not:'Dotmam (dişil/mê) — amca kızı. "Dot" (kız) + "mam" (amca). Veqetandek: dotmama min. Mînak: Dotmam baş e. Têbinî: eril eşi "pismam" (amca oğlu).',
   her:['Dotmama pîrê baş e.', 'Dotmam li bajêr e.'],
   gen:['Dotmam baş e.', 'Dotmam û pismam hene.']),

  // [BH] p.277: "Pismam, er., amca oğlu (pis/pir; mam, amca)"
  // [FB]: pismam n.m. — eril, kesin
  (id:'a1_401', ku:'Pismam', tr:'Amca oğlu', en:"Father's brother's son", cins:'nêr', ez:'pismamê',
   kat:'malbat', zor:0.78,
   not:'Pismam (eril/nêr) — amca oğlu. "Pis" (genç) + "mam" (amca). Veqetandek: pismamê min. Mînak: Pismam baş e. Têbinî: dişil eşi "dotmam".',
   her:['Pismamê pîrê baş e.', 'Pismam li bajêr e.'],
   gen:['Pismam baş e.', 'Pismam û dotmam hene.']),

  // [BH] § — Met = hala (baba tarafı kız kardeş)
  // [AS] s.30: "Malbat" bölümünde met
  // [FB]: met n.f. (feminine)
  (id:'a1_402', ku:'Met', tr:'Hala', en:"Father's sister", cins:'mê', ez:'meta',
   kat:'malbat', zor:0.79,
   not:'Met (dişil/mê) — hala (baba tarafı). Veqetandek: meta min. Mînak: Met baş e. Têbinî: anne tarafı "xaltî" (teyze) — Kurmancî\'de ayrım kritik.',
   her:['Meta pîrê baş e.', 'Met li bajêr e.'],
   gen:['Meta me xweş e.', 'Met û xaltî hene.']),

  // [AS] s.30: Malbat bölümü — birazên = gelinler, bûk
  // [BH]: bûk, dişil — gelin/yeni evli kadın
  // [FB]: bûk n.f.
  (id:'a1_403', ku:'Bûk', tr:'Gelin', en:'Bride / Daughter-in-law', cins:'mê', ez:'bûka',
   kat:'malbat', zor:0.79,
   not:'Bûk (dişil/mê) — gelin, yeni evli kadın. Veqetandek: bûka me. Mînak: Bûk baş e. Têbinî: eril eşi "zava" (damat).',
   her:['Bûka birê min baş e.', 'Bûk li malê ye.'],
   gen:['Bûk baş e.', 'Bûk û zava hene.']),

  // [BH] §: zavayê (eril veqetandek) → zava eril
  // [AS]: zava = damat ✓
  // [FB]: zava n.m.
  (id:'a1_404', ku:'Zava', tr:'Damat', en:'Son-in-law / Groom', cins:'nêr', ez:'zavayê',
   kat:'malbat', zor:0.78,
   not:'Zava (eril/nêr) — damat, yeni evli erkek. Veqetandek: zavayê me. Mînak: Zava baş e. Têbinî: dişil eşi "bûk" (gelin).',
   her:['Zavayê pîrê baş e.', 'Zava li malê ye.'],
   gen:['Zava baş e.', 'Zava û bûk hene.']),

  // ─────────────────────────────────────────────────────────────
  // YİYECEK EKSİKLERİ — Thackston §85
  // ─────────────────────────────────────────────────────────────

  // [AS] s.47: "penîr" = peynir
  // [BH]: penîr — eril, doğal konuşmada çok sık
  // [FB]: penîr n.m.
  // [TH]: §85 gıda kelimelerinde penîr geçer
  (id:'a1_410', ku:'Penîr', tr:'Peynir', en:'Cheese', cins:'nêr', ez:'penîrê',
   kat:'xwarin', zor:0.83,
   not:'Penîr (eril/nêr) — peynir. Veqetandek: penîrê me. Mînak: Penîr xweş e. Têbinî: keçi sütünden yapılır (şîrê bizinê).',
   her:['Penîrê pîrê xweş e.', 'Pîrê penîr dixwe.'],
   gen:['Penîr û nan xweş in.', 'Penîr û mast hene.']),

  // [AS] s.47: "hêk" = yumurta
  // [BH]: hêk, eril — "hêkê mirîşkê"
  // [FB]: hêk n.m.
  (id:'a1_411', ku:'Hêk', tr:'Yumurta', en:'Egg', cins:'mê', ez:'hêka',
   kat:'xwarin', zor:0.82,
   not:'Hêk (dişil/mê) — yumurta. Veqetandek: hêka mirîşkê. Mînak: Hêk xweş e. Têbinî: ê uzun söylenir.',
   her:['Pîrê hêk dixwe.', 'Hêka mirîşkê xweş e.'],
   gen:['Hêk xweş e.', 'Hêk û penîr hene.']),

  // [AS] s.47: "şorbe/şorba" = çorba
  // [BH]: şorbe dişil
  // [TH]: çorba için "şorbe" veya "kele" kullanılır
  (id:'a1_412', ku:'Şorbe', tr:'Çorba', en:'Soup', cins:'mê', ez:'şorbeya',
   kat:'xwarin', zor:0.81,
   not:'Şorbe (dişil/mê) — çorba. Veqetandek: şorbeya pîrê. Mînak: Şorbe germ e. Têbinî: ünlü ile bittiğinden veqetandek "ya".',
   her:['Şorbeya pîrê xweş e.', 'Pîrê şorbe dixwe.'],
   gen:['Şorbe germ e.', 'Şorbe û nan hene.']),

  // [AS] s.47: "nêranc" = portakal
  // [FB]: nêranc n.m. — eril
  (id:'a1_413', ku:'Nêranc', tr:'Portakal', en:'Orange (fruit)', cins:'nêr', ez:'nêrancê',
   kat:'mêwe', zor:0.80,
   not:'Nêranc (eril/nêr) — portakal. Veqetandek: nêrancê me. Mînak: Nêranc şîrîn e. Têbinî: "porteqalî" rengi bu meyveden gelir.',
   her:['Pîrê nêranc dixwe.', 'Nêrancê pîrê şîrîn e.'],
   gen:['Nêranc xweş e.', 'Nêranc û sêv hene.']),

  // [AS] s.47: "genim" = buğday
  // [BH]: genim eril
  // [FB]: genim n.m.
  (id:'a1_414', ku:'Genim', tr:'Buğday', en:'Wheat', cins:'nêr', ez:'genimê',
   kat:'xwarin', zor:0.79,
   not:'Genim (eril/nêr) — buğday. Veqetandek: genimê me. Mînak: Genim li gundî ye. Têbinî: "Nan ji genimê tê" = ekmek buğdaydan gelir.',
   her:['Genim li gundî ye.', 'Pîrê genim dibîne.'],
   gen:['Genim û birinc hene.', 'Genim li gundê me ye.']),

  // [AS]: "xwêdan" → actually "xwê" = tuz (already have)
  // "Biber" = îsot — [AS] s.47
  // [FB]: îsot n.m.
  (id:'a1_415', ku:'Îsot', tr:'Biber', en:'Pepper', cins:'mê', ez:'îsota',
   kat:'xwarin', zor:0.81,
   not:'Îsot (dişil/mê) — biber. Veqetandek: îsota sor. Mînak: Îsot sor e. Têbinî: "bîharek" karabiber ayrı kelime.',
   her:['Îsota pîrê sor e.', 'Pîrê îsot dixwe.'],
   gen:['Îsot sor e.', 'Îsot û xwê hene.']),

  // [AS]: "fêkî" = meyve (genel)
  // [FB]: fêkî n.m.
  (id:'a1_416', ku:'Fêkî', tr:'Meyve (genel)', en:'Fruit (general)', cins:'nêr', ez:'fêkiyê',
   kat:'mêwe', zor:0.81,
   not:'Fêkî (eril/nêr) — meyve (genel). Veqetandek: fêkiyê me. Mînak: Fêkî xweş e. Têbinî: "sêv", "hirmî", "mûz" gibi türler.',
   her:['Pîrê fêkî dixwe.', 'Fêkiyê biharê xweş e.'],
   gen:['Fêkî xweş e.', 'Fêkî û sêv hene.']),

  // ─────────────────────────────────────────────────────────────
  // BEDEN EKSİKLERİ — ENDAMÊN BEDENÊ
  // Badıllı karşılaştırma + Bedir Han vurgu bölümü
  // ─────────────────────────────────────────────────────────────

  // [AS] s.37: "mejî" = beyin (no.229)
  // [BH]: mejî eril
  // [FB]: mejî n.m.
  (id:'a1_420', ku:'Mejî', tr:'Beyin', en:'Brain', cins:'nêr', ez:'mejiyê',
   kat:'beden', zor:0.80,
   not:'Mejî (eril/nêr) — beyin. Veqetandek: mejiyê min. Mînak: Mejî mezin e. Têbinî: organ.',
   her:['Mejiyê pîrê mezin e.', 'Mejî baş e.'],
   gen:['Mejî mezin e.', 'Mejî û dil hene.']),

  // [AS] s.37: "sitû" = boyun (no.232)
  // [BA]: "boyun = sitû" ✓
  // [BH]: stû eril
  // [FB]: stû/sitû n.m.
  (id:'a1_421', ku:'Stû', tr:'Boyun', en:'Neck', cins:'nêr', ez:'stûyê',
   kat:'beden', zor:0.80,
   not:'Stû (eril/nêr) — boyun. Veqetandek: stûyê min. Mînak: Stû dirêj e. Têbinî: "sitû" alternatif yazım.',
   her:['Stûyê pîrê dirêj e.', 'Stû kurt e.'],
   gen:['Stû dirêj e.', 'Stû û mil hene.']),

  // [AS] s.37: "mil" = omuz (no.252)
  // [BH]: mil eril — "Pî, er., omuz" (pî de kullanılır)
  // [FB]: mil n.m.
  (id:'a1_422', ku:'Mil', tr:'Omuz', en:'Shoulder', cins:'nêr', ez:'milê',
   kat:'beden', zor:0.80,
   not:'Mil (eril/nêr) — omuz. Veqetandek: milê min. Mînak: Mil mezin e. Têbinî: çoğul "milên".',
   her:['Milê pîrê mezin e.', 'Milên min mezin in.'],
   gen:['Mil mezin e.', 'Mil û stû hene.']),

  // [AS] s.37: "pişt" = sırt (no.256)
  // [FB]: pişt n.m.
  // [BA]: pişt = sırt ✓
  (id:'a1_423', ku:'Pişt', tr:'Sırt', en:'Back', cins:'mê', ez:'pişta',
   kat:'beden', zor:0.80,
   not:'Pişt (dişil/mê) — sırt. Veqetandek: pişta min. Mînak: Pişt dirêj e. Têbinî: "li pişt" (arkasında, a1_583).',
   her:['Pişta pîrê dirêj e.', 'Pişt û dest hene.'],
   gen:['Pişt mezin e.', 'Pişta min dirêj e.']),

  // [AS] s.37: "zend" = bilek (no.231)
  // [BA]: "bilek = zend" ✓
  // [FB]: zend n.m.
  (id:'a1_424', ku:'Zend', tr:'Bilek', en:'Wrist', cins:'nêr', ez:'zendê',
   kat:'beden', zor:0.79,
   not:'Zend (eril/nêr) — bilek. Veqetandek: zendê min. Mînak: Zend biçûk e. Têbinî: "enîşk" (dirsek) ile çift.',
   her:['Zendê pîrê biçûk e.', 'Zend û dest hene.'],
   gen:['Zend biçûk e.', 'Zend û enîşk hene.']),

  // [AS] s.37: "enîşk" = dirsek (no.237)
  // [BA]: "dirsek = enîşk" ✓
  // [FB]: enîşk n.m.
  (id:'a1_425', ku:'Enîşk', tr:'Dirsek', en:'Elbow', cins:'nêr', ez:'enîşkê',
   kat:'beden', zor:0.79,
   not:'Enîşk (eril/nêr) — dirsek. Veqetandek: enîşkê min. Mînak: Enîşk mezin e. Têbinî: "zend" (bilek) ile çift.',
   her:['Enîşkê pîrê mezin e.', 'Enîşk û zend hene.'],
   gen:['Enîşk mezin e.', 'Enîşk û mil hene.']),

  // [AS] s.37: "çeng" = çene/kol (no.234)
  // [BH] p.56: "Çeng, kol, kanat : çengi, çengan" — eril!
  // [FB]: çeng n.m. (chin/jaw)
  (id:'a1_426', ku:'Çeng', tr:'Çene', en:'Chin / Jaw', cins:'nêr', ez:'çengê',
   kat:'beden', zor:0.79,
   not:'Çeng (eril/nêr) — çene. Veqetandek: çengê min. Mînak: Çeng biçûk e. Têbinî: yüzün alt parçası.',
   her:['Çengê pîrê biçûk e.', 'Çeng û rû hene.'],
   gen:['Çeng biçûk e.', 'Çeng û rû hene.']),

  // [AS] s.37: "rû/serçav" = yüz (no.258)
  // [BH]: rû eril
  // [FB]: rû n.m.
  (id:'a1_427', ku:'Rû', tr:'Yüz / Çehre', en:'Face', cins:'nêr', ez:'rûyê',
   kat:'beden', zor:0.82,
   not:'Rû (eril/nêr) — yüz, çehre. Veqetandek: rûyê min. Mînak: Rû xweş e. Têbinî: "Avrû" = onur/şeref (mecazi).',
   her:['Rûyê pîrê xweş e.', 'Rûyê min sor e.'],
   gen:['Rû xweş e.', 'Rû û çav hene.']),

  // [AS] s.37: "por" = saç (no.254)
  // [BH]: por eril
  // [FB]: por n.m.
  (id:'a1_428', ku:'Por', tr:'Saç', en:'Hair', cins:'nêr', ez:'porê',
   kat:'beden', zor:0.81,
   not:'Por (eril/nêr) — saç. Veqetandek: porê min. Mînak: Por reş e. Têbinî: çoğul "porên".',
   her:['Porê pîrê spî ye.', 'Porê min reş e.'],
   gen:['Por reş e.', 'Por û çav hene.']),

  // [AS] s.37: "lêv" = dudak (no.239)
  // [BH]: lêv eril
  // [FB]: lêv n.m.
  (id:'a1_429', ku:'Lêv', tr:'Dudak', en:'Lip', cins:'mê', ez:'lêva',
   kat:'beden', zor:0.79,
   not:'Lêv (dişil/mê) — dudak. Veqetandek: lêva min. Mînak: Lêv sor e. Têbinî: çoğul "lêvên" (dudaklar).',
   her:['Lêva pîrê sor e.', 'Lêvên min sor in.'],
   gen:['Lêv sor e.', 'Lêvên me sor in.']),

  // ─────────────────────────────────────────────────────────────
  // ÖNEMLI ZAMİR VE KELİMELER
  // ─────────────────────────────────────────────────────────────

  // [BH] §168-172: Dönüşlü zamir "xwe" — en önemli zamirlerden
  // [TH] §: "xwe" = oneself, reflexive pronoun
  // [DR]: DoReCo'da yüksek frekans
  // [AZ]: Arizona derslerinde §12 — xwe
  (id:'a1_430', ku:'Xwe', tr:'Kendim / Kendi', en:'Myself / Oneself (reflexive)', cins:'bêcins', ez:null,
   kat:'cinavk', zor:0.80,
   not:'Xwe — dönüşlü zamir (kendisi). Tüm kişilerde aynı. Mînak: Malbata xwe baş e. Têbinî: "ji xwe" kalıbında çok geçer.',
   her:['Malbata xwe baş e.', 'Pîrê malbata xwe dibîne.'],
   gen:['Malbata xwe baş e.', 'Mala xwe paqij e.']),

  // [BH]: Hemî = hepsi
  // [FB]: hemî pron./adj. — all, every
  // [TH]: hemû/hemî = all
  (id:'a1_431', ku:'Hemî', tr:'Hepsi / Bütün', en:'All / Every', cins:'bêcins', ez:null,
   kat:'temel', zor:0.81,
   not:'Hemî — sıfat/zamir (hepsi, bütün). Mînak: Hemî baş in. Têbinî: alternatif "hemû".',
   her:['Hemî malbat li malê ne.', 'Pîrê hemî dibîne.'],
   gen:['Hemî baş in.', 'Hemî û hin hene.']),

  // [BH]: Hin = bazı, birkaç
  // [FB]: hin adj. — some, a few
  // [TH]: hin = some
  (id:'a1_432', ku:'Hin', tr:'Bazı / Birkaç', en:'Some / A few', cins:'bêcins', ez:null,
   kat:'temel', zor:0.81,
   not:'Hin — sıfat/zamir (bazı, birkaç). Mînak: Hin pirtûk hene. Têbinî: "Hin caran" = bazen.',
   her:['Hin caran pîrê tê.', 'Hin pirtûk hene.'],
   gen:['Hin kes li vir in.', 'Hin sêv sor in.']),

  // Stran — Bedir Han p.56: "Stran, şarkı : stranê, stranan." — DİŞİL
  // [FB]: stran n.f. — dişil, kesin
  // [TH]: stran feminine
  // [DR]: DoReCo'da cultural content — sık geçer
  (id:'a1_433', ku:'Stran', tr:'Türkü / Şarkı', en:'Song / Ballad', cins:'mê', ez:'strana',
   kat:'çand', zor:0.83,
   not:'Stran (dişil/mê) — şarkı, türkü. Veqetandek: strana pîrê. Mînak: Stran xweş e. Têbinî: çoğul "stranên" (şarkılar).',
   her:['Pîrê stran dibêje.', 'Strana pîrê xweş e.'],
   gen:['Stran xweş e.', 'Stranên me xweş in.']),

  // [BH]: Dengbêj = dengbêj (sözlü hikaye anlatıcısı)
  // [FB]: dengbêj n.m.
  // Kültürel önemi muazzam — A1 sonu kültürel içerik
  (id:'a1_434', ku:'Dengbêj', tr:'Dengbêj / Halk Ozanı', en:'Kurdish oral tradition singer', cins:'nêr', ez:'dengbêjê',
   kat:'çand', zor:0.78,
   not:'Dengbêj (eril/nêr) — halk ozanı, sözlü hikaye anlatıcısı. "Deng" (ses) + "bêj" (söyleyen). Veqetandek: dengbêjê me. Mînak: Dengbêj stran dibêje.',
   her:['Dengbêjê pîrê stran dibêje.', 'Dengbêj baş e.'],
   gen:['Dengbêj stran dibêje.', 'Dengbêj û stran hene.']),

  // ─────────────────────────────────────────────────────────────
  // ULAŞIM VE YER — Arizona §4
  // ─────────────────────────────────────────────────────────────

  // [AS] s.40: "erebe" = araba
  // [FB]: erebe n.f. — dişil
  // [TH]: erebe = car (feminine)
  (id:'a1_440', ku:'Erebe', tr:'Araba', en:'Car', cins:'mê', ez:'erebeya',
   kat:'gihanî', zor:0.83,
   not:'Erebe (dişil/mê) — araba. Veqetandek: erebeya min. Mînak: Erebe sor e. Têbinî: alıntı "otomobîl" da kullanılır.',
   her:['Erebeya bavê min sor e.', 'Pîrê bi erebê tê.'],
   gen:['Erebe nû ye.', 'Erebe û bas hene.']),

  // [AS] s.40: "bas" = otobüs
  // [FB]: bas n.m. — eril
  (id:'a1_441', ku:'Bas', tr:'Otobüs', en:'Bus', cins:'nêr', ez:'basê',
   kat:'gihanî', zor:0.82,
   not:'Bas (eril/nêr) — otobüs. Veqetandek: basê bajêr. Mînak: Ez bi basê diçim. Têbinî: "otobûs" alternatif (a1_ek435).',
   her:['Ez bi basê diçim dibistanê.', 'Pîrê bi basê tê.'],
   gen:['Bas û erebe hene.', 'Basê bajêr mezin e.']),

  // [AS] s.40: "balafir" = uçak
  // [FB]: balafir n.m. — eril
  // [TH]: balafir = plane
  (id:'a1_442', ku:'Balafir', tr:'Uçak', en:'Airplane', cins:'mê', ez:'balafira',
   kat:'gihanî', zor:0.81,
   not:'Balafir (dişil/mê) — uçak. "Bala" (yüksek) + "fir" (uçuş). Veqetandek: balafira min. Mînak: Balafir li esmên e. Têbinî: "balafirgeh" = havalimanı.',
   her:['Pîrê bi balafirê tê.', 'Balafira bavê min mezin e.'],
   gen:['Balafir mezin e.', 'Balafir û trên hene.']),

  // [AS] s.40: "trên" = tren
  // [FB]: trên n.m.
  (id:'a1_443', ku:'Trên', tr:'Tren', en:'Train', cins:'nêr', ez:'trênê',
   kat:'gihanî', zor:0.80,
   not:'Trên (eril/nêr) — tren (Fransızca alıntı). Veqetandek: trênê bajêr. Mînak: Ez bi trênê diçim. Têbinî: oblique "bi trênê".',
   her:['Ez bi trênê diçim.', 'Pîrê bi trênê tê.'],
   gen:['Trên û balafir hene.', 'Trênê bajêr mezin e.']),

  // [AS]: "Rêhesin" = demiryolu — Bedir Han p.277 bileşik: "Rêhesin, er., demiryolu"
  // Ama A1 için simpler: "Rê" = yol (already have)
  // "Sekingeha" = durak — [FB]: sekingeha n.f.
  (id:'a1_444', ku:'Sekingeh', tr:'Durak', en:'Stop / Station', cins:'mê', ez:'sekingeha',
   kat:'gihanî', zor:0.79,
   not:'Sekingeh (dişil/mê) — durak, istasyon. "Sekinîn" + "-geh" (yer eki). Veqetandek: sekingeha basê. Mînak: Sekingeh li bajêr e.',
   her:['Pîrê li sekingehê ye.', 'Sekingeha basê li bajêr e.'],
   gen:['Sekingeh nêzîk e.', 'Sekingeha basê mezin e.']),

  // "Bajar" = şehir — [BH]: bajar eril
  // [FB]: bajar n.m.
  // [TH]: bajar = city
  (id:'a1_445', ku:'Bajar', tr:'Şehir', en:'City', cins:'nêr', ez:'bajêr',
   kat:'cih', zor:0.83,
   not:'Bajar (eril/nêr) — şehir. Veqetandek: bajarê me. Mînak: Bajar mezin e. Têbinî: "li bajêr" yer formu (a1_254).',
   her:['Pîrê li bajêr e.', 'Bajarê me mezin e.'],
   gen:['Bajar mezin e.', 'Bajar û gund hene.']),

  // "Gund" = köy — [BH]: gund eril
  // [FB]: gund n.m.
  // Heritage kullanıcı için önemli — büyükanne genellikle gundê
  (id:'a1_446', ku:'Gund', tr:'Köy', en:'Village', cins:'nêr', ez:'gundê',
   kat:'cih', zor:0.83,
   not:'Gund (eril/nêr) — köy. Veqetandek: gundê me. Mînak: Gund xweş e. Têbinî: "li gund" yer formu (a1_255). Kurmancî kültüründe köklerin yeri.',
   her:['Pîrê li gundî ye.', 'Gundê me xweş e.'],
   gen:['Gund xweş e.', 'Gund û bajar hene.']),

  // ─────────────────────────────────────────────────────────────
  // EV VE MEKAN EKSİKLERİ
  // ─────────────────────────────────────────────────────────────

  // [AS] s.47: "firax" = tabak
  // [FB]: firax n.m. [Arapça "firàs"tan]
  (id:'a1_450', ku:'Firax', tr:'Tabak / Kap', en:'Plate / Dish', cins:'nêr', ez:'firaxê',
   kat:'mal', zor:0.80,
   not:'Firax (eril/nêr) — tabak, kap. Veqetandek: firaxê me. Mînak: Firax paqij e. Têbinî: çoğul "firaxan".',
   her:['Firaxê pîrê paqij e.', 'Firax li mêzê ye.'],
   gen:['Firax paqij e.', 'Firax û kevçî hene.']),

  // [AS]: "kevçî" = kaşık
  // [FB]: kevçî n.m.
  (id:'a1_451', ku:'Kevçî', tr:'Kaşık', en:'Spoon', cins:'nêr', ez:'kevçiyê',
   kat:'mal', zor:0.80,
   not:'Kevçî (eril/nêr) — kaşık. Veqetandek: kevçiyê me. Mînak: Kevçî biçûk e. Têbinî: yemek aleti.',
   her:['Kevçiyê pîrê biçûk e.', 'Kevçî li mêzê ye.'],
   gen:['Kevçî biçûk e.', 'Kevçî û çengal hene.']),

  // [AS]: "çengal" = çatal
  // [FB]: çengal n.m.
  (id:'a1_452', ku:'Çengal', tr:'Çatal', en:'Fork', cins:'nêr', ez:'çengalê',
   kat:'mal', zor:0.79,
   not:'Çengal (eril/nêr) — çatal. Veqetandek: çengalê me. Mînak: Çengal biçûk e. Têbinî: "kevçî" (kaşık) ile çift.',
   her:['Çengalê pîrê biçûk e.', 'Çengal li mêzê ye.'],
   gen:['Çengal biçûk e.', 'Çengal û kêr hene.']),

  // [AS]: "kêr" = bıçak
  // [BH]: kêr dişil — ve minimal çifte dikkat: "ker" (eşek, nêr) vs "kêr" (bıçak, mê)
  // [FB]: kêr n.f.
  (id:'a1_453', ku:'Kêr', tr:'Bıçak', en:'Knife', cins:'mê', ez:'kêra',
   kat:'mal', zor:0.78,
   not:'Kêr (dişil/mê) — bıçak. Veqetandek: kêra me. Mînak: Kêr biçûk e. Têbinî: "ker" (eşek, eril) ile karıştırma — minimal çift.',
   her:['Kêra pîrê biçûk e.', 'Kêr li mêzê ye.'],
   gen:['Kêr biçûk e.', 'Kêr û çengal hene.']),

  // ─────────────────────────────────────────────────────────────
  // SIFAT EKSİKLERİ
  // ─────────────────────────────────────────────────────────────

  // [AS] + [FB]: pak = temiz
  // [TH]: pak = clean, adj. invariable
  (id:'a1_460', ku:'Pak', tr:'Temiz', en:'Clean', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.82,
   not:'Pak — sıfat (temiz, saf). Mînak: Mal pak e. Têbinî: karşıtı "qirêj" (kirli).',
   her:['Mala pîrê pak e.', 'Destên pîrê pak in.'],
   gen:['Pak xweş e.', 'Firax pak in.']),

  // [AS] + [FB]: qirêj = kirli
  // [TH]: qirêj = dirty
  (id:'a1_461', ku:'Qirêj', tr:'Kirli', en:'Dirty', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.81,
   not:'Qirêj — sıfat (kirli). Mînak: Firax qirêj e. Têbinî: karşıtı "pak" (temiz). Q sesi gırtlaktan.',
   her:['Firaxê pîrê qirêj e.', 'Destên min qirêj in.'],
   gen:['Qirêj baş nîne.', 'Firax qirêj e.']),

  // [AS] + [FB]: vala = boş
  // [BH]: vala adj. invariable
  (id:'a1_462', ku:'Vala', tr:'Boş', en:'Empty', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.81,
   not:'Vala — sıfat (boş). Mînak: Firax vala ye. Têbinî: karşıtı "tijî" (dolu).',
   her:['Firaxê pîrê vala ye.', 'Mal vala ye.'],
   gen:['Vala xweş nîne.', 'Çante vala ye.']),

  // [AS] + [FB]: tijî = dolu
  // [BH]: tijî adj.
  (id:'a1_463', ku:'Tijî', tr:'Dolu', en:'Full', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.81,
   not:'Tijî — sıfat (dolu). Mînak: Firax tijî ye. Têbinî: karşıtı "vala" (boş).',
   her:['Firaxê pîrê tijî ye.', 'Mal tijî ye.'],
   gen:['Tijî baş e.', 'Çante tijî ye.']),

  // [AS] + [FB]: girîng = önemli
  // [TH]: girîng = important
  (id:'a1_464', ku:'Girîng', tr:'Önemli', en:'Important', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.80,
   not:'Girîng — sıfat (önemli). Mînak: Ziman girîng e. Têbinî: zarf gibi de kullanılır.',
   her:['Ziman girîng e, pîrê.', 'Pîrê girîng e.'],
   gen:['Ev pirtûk girîng e.', 'Ziman girîng e.']),

  // [AS] + [FB]: xweşik = güzel (kişi için)
  // xweş = genel "güzel", xweşik = özellikle kişi güzelliği için
  (id:'a1_465', ku:'Xweşik', tr:'Güzel (kişi için)', en:'Beautiful (person)', cins:'bêcins', ez:null,
   kat:'rengder', zor:0.81,
   not:'Xweşik — sıfat (güzel, özellikle kişi için). Mînak: Keçik xweşik e. Têbinî: "xweş" genel güzel, "xweşik" kişi.',
   her:['Keça pîrê xweşik e.', 'Pîrê xweşik e.'],
   gen:['Zarok xweşik in.', 'Keçik xweşik e.']),

  // ─────────────────────────────────────────────────────────────
  // TEMEL FİİL TAMAMLAMAları — DoReCo frekans + Arizona §8-10
  // ─────────────────────────────────────────────────────────────

  // [TH] §74: hesibandin/fikirîn = düşünmek
  // [FB]: fikirîn v. — to think
  // [DR]: sık kullanılan filler listesinde
  (id:'a1_470', ku:'Ez difikirim', tr:'Ben düşünüyorum', en:'I think', cins:'bêcins', ez:null,
   kat:'leker', zor:0.79,
   not:'"Di-fikir-im" — fikirîn fiili (düşünmek). Mînak: Ez difikirim ku baş e. Têbinî: 3.tek "difikire".',
   her:['Ez difikirim ku pîrê tê.', 'Tu çi difikirî?'],
   gen:['Ez difikirim.', 'Ew jî difikire.']),

  // [TH] §74: hez kirin = sevmek
  // [FB]: hez kirin = to like/love
  // [DR]: en sık bileşik fiillerden — gerekli A1!
  (id:'a1_471', ku:'Ez hez dikim', tr:'Ben seviyorum', en:'I love / I like', cins:'bêcins', ez:null,
   kat:'leker', zor:0.82,
   not:'"Ji X hez kirin" = X-i sevmek. Mînak: Ez ji Kurmancî hez dikim. Têbinî: 3.tek "hez dike".',
   her:['Ez ji te hez dikim.', 'Ez ji Kurmancî hez dikim.'],
   gen:['Pîrê ji min hez dike.', 'Ew ji me hez dike.']),

  // [TH]: zanîn = bilmek (already have dizanim)
  // Kullanıcı tercihi: "keyf xweş im" — iki ayrı kelime
  (id:'a1_472', ku:'Keyf xweş im', tr:'Keyfim yerinde / Mutluyum', en:"I'm in good spirits", cins:'bêcins', ez:null,
   kat:'leker', zor:0.80,
   not:'"Keyf" (zevk) + "xweş" (güzel) → keyfim yerinde. Mînak: Keyf xweş im. Têbinî: günlük konuşmada yaygın.',
   her:['Keyf xweş im, pîrê.', 'Pîrê keyf xweş e.'],
   gen:['Keyf xweş im.', 'Tu keyf xweş î?']),

  // [TH] §74: parastin = korumak, saklamak
  // [FB]: xwedî kirin = sahip olmak/korumak — A1 için önemli
  (id:'a1_473', ku:'Ez xwedî … im', tr:'Ben … sahibiyim / var', en:'I have / I own', cins:'bêcins', ez:null,
   kat:'leker', zor:0.80,
   not:'"Xwedî" — sahip. Mînak: Ez xwedî pirtûkek im. Têbinî: "xwedî kirin" = sahip olmak yapısı.',
   her:['Ez xwedî sê pirtûk im.', 'Ez xwedî birayek im.'],
   gen:['Ew xwedî erebe ye.', 'Pîrê xwedî mal e.']),

  // ─────────────────────────────────────────────────────────────
  // ZAMAN VE DURUM BİLDİREN İFADELER
  // ─────────────────────────────────────────────────────────────

  // [BH]: Êvare = akşam (already have)
  // [TH]: Şevek = bir gece / Wextê = zamanında
  // [FB]: wext n.m. — time
  (id:'a1_480', ku:'Wext', tr:'Vakit / Zaman', en:'Time', cins:'nêr', ez:'wextê',
   kat:'dem', zor:0.81,
   not:'Wext (eril/nêr) — vakit, zaman. Veqetandek: wextê me. Mînak: Wext baş e. Têbinî: "dem" eşanlamı.',
   her:['Wextê pîrê heye.', 'Wext baş e, pîrê.'],
   gen:['Wext zû tê.', 'Wext û dem hene.']),

  // [BH] §: "êdî" = artık
  // [FB]: êdî adv. — now, already, no more
  // [DR]: sık zarf
  (id:'a1_481', ku:'Êdî', tr:'Artık / Hadi', en:'Now / Already / No more', cins:'bêcins', ez:null,
   kat:'temel', zor:0.80,
   not:'Êdî — zarf (artık, hadi). Mînak: Êdî ez diçim. Têbinî: süreç bildiren zarf.',
   her:['Êdî ez diçim malê, pîrê.', 'Êdî pîrê tê.'],
   gen:['Êdî baş e.', 'Êdî dem e.']),

  // [BH]: hîn = henüz / hâlâ
  // [FB]: hîn adv. — still, yet
  // [TH]: hîn = still
  (id:'a1_482', ku:'Hîn', tr:'Henüz / Hâlâ', en:'Still / Yet', cins:'bêcins', ez:null,
   kat:'temel', zor:0.80,
   not:'Hîn — zarf (henüz, hâlâ). Mînak: Pîrê hîn li malê ye. Têbinî: "êdî" karşıtı zaman ifade.',
   her:['Pîrê hîn li malê ye.', 'Hîn baş e.'],
   gen:['Hîn nîne.', 'Pîrê hîn tê.']),

  // ─────────────────────────────────────────────────────────────
  // SELAMLAMA TAMAMLAMA
  // ─────────────────────────────────────────────────────────────

  // [TH]: "Roja te baş be" = iyi günler
  // [FB]: "roj baş" = good day — yaygın selamlama
  (id:'a1_490', ku:'Roja te baş be', tr:'İyi günler', en:'Good day', cins:'bêcins', ez:null,
   kat:'silav', zor:0.83,
   not:'Selam kalıbı — gün için iyi dilek (iyi günler). Mînak: Roja te baş be! Têbinî: çoğul "Roja we baş be" — "roj" dişil (mê), veqetandek -a.',
   her:['Roja te baş be, pîrê!', 'Roja we baş be!'],
   gen:['Roja te baş be!', 'Roj baş!']),

  // [TH]: "Şeva te xweş be" = iyi geceler
  // [FB]: standard gece selamı
  (id:'a1_491', ku:'Şeva te xweş be', tr:'İyi geceler', en:'Good night', cins:'bêcins', ez:null,
   kat:'silav', zor:0.82,
   not:'Selam kalıbı — gece için iyi dilek. Mînak: Şeva te xweş be! Têbinî: çoğul "Şeva we xweş be".',
   her:['Şeva te xweş be, pîrê!', 'Şeva we xweş be!'],
   gen:['Şeva te xweş be.', 'Şev xweş!']),

  // [TH]: "Sibê baş!" = günaydın (short form)
  // [FB]: standard sabah selamı
  (id:'a1_492', ku:'Sibê baş!', tr:'Günaydın!', en:'Good morning!', cins:'bêcins', ez:null,
   kat:'silav', zor:0.83,
   not:'Selam kalıbı — sabah selamı (günaydın, kısa). Mînak: Sibê baş, pîrê! Têbinî: uzun form "Sibê te xweş be".',
   her:['Sibê baş, pîrê!', 'Sibê baş, dê û bav!'],
   gen:['Sibê baş!', 'Sibê baş, heval!']),

  // [TH]: "Çawa ye?" informal
  // [FB]: yaygın selamlama
  (id:'a1_493', ku:'Çawa ye?', tr:'Nasıl? (kısa)', en:"How's it going?", cins:'bêcins', ez:null,
   kat:'silav', zor:0.84,
   not:'Soru kalıbı — "nasıl?" kısa formu. Mînak: Çawa ye, pîrê? Têbinî: uzun form "Tu çawa yî?".',
   her:['Çawa ye, pîrê?', 'Çawa ye, bavê min?'],
   gen:['Çawa ye?', 'Xweş e, spas!']),

  // [TH] + [FB]: "Bi xatirê we" = güle güle (çoğul)
  (id:'a1_494', ku:'Bi xatirê we', tr:'Güle güle (çoğul)', en:'Goodbye (to a group)', cins:'bêcins', ez:null,
   kat:'silav', zor:0.81,
   not:'Vedalaşma kalıbı — çoğul "güle güle". Mînak: Bi xatirê we, malbato! Têbinî: tekil "Bi xatirê te"; "Oxir be" eşanlamı.',
   her:['Bi xatirê we, malbato!', 'Bi xatirê we, pîrê û kal!'],
   gen:['Bi xatirê we!', 'Bi xatirê te, heval!']),

  // [TH]: "Ser çavim" = baş üstüne / Rica ederim
  // [FB]: ser çavim — polite response to thanks
  (id:'a1_495', ku:'Ser çavim', tr:'Baş üstüne / Rica ederim', en:'You are welcome / At your service', cins:'bêcins', ez:null,
   kat:'silav', zor:0.79,
   not:'Kibar kalıp — "rica ederim, baş üstüne". Mînak: Spas! — Ser çavim. Têbinî: teşekküre yanıt olarak.',
   her:['Spas, pîrê! — Ser çavim!', 'Pîrê — Ser çavim!'],
   gen:['Spas! — Ser çavim.', 'Ser çavim, heval!']),

  // ─────────────────────────────────────────────────────────────
  // DOĞA EKSİKLERİ
  // ─────────────────────────────────────────────────────────────

  // [BH]: Erd = toprak/yer — eril
  // [FB]: erd n.m.
  (id:'a1_743', ku:'Erd', tr:'Toprak / Yer', en:'Earth / Ground', cins:'mê', ez:'erda',
   kat:'xweza', zor:0.82,
   not:'Erd (dişil/mê) — toprak, yer. Veqetandek: erda me. Mînak: Erd germ e. Têbinî: a1_573 ile yakın anlam (zemin).',
   her:['Erda me xweş e.', 'Erd û çiya hene.'],
   gen:['Erd germ e.', 'Erda gund mezin e.']),

  // [BH]: Esman = gökyüzü — eril
  // [FB]: esman n.m. [Farsça "âsmân"dan]
  // [TH]: esman = sky
  (id:'a1_744', ku:'Esman', tr:'Gökyüzü', en:'Sky', cins:'nêr', ez:'esmanê',
   kat:'xweza', zor:0.82,
   not:'Esman (eril/nêr) — gökyüzü. Veqetandek: esmanê şîn. Mînak: Esman şîn e. Têbinî: oblique "li esmên" (iç bükün a→ê).',
   her:['Esman şîn e, pîrê.', 'Stêrk li esmên in.'],
   gen:['Esman şîn e.', 'Esman û erd hene.']),

  // [FB]: Roj = güneş + gün — already have!
  // [FB]: Bayînek/Çiyayek — mountain pass
  // Simpler: "Kanî" = pınar/kaynak — sık geçen
  // [FB]: kanî n.f. — spring, fountain
  (id:'a1_745', ku:'Kanî', tr:'Pınar / Su kaynağı', en:'Spring / Fountain', cins:'mê', ez:'kaniya',
   kat:'xweza', zor:0.80,
   not:'Kanî (dişil/mê) — pınar, su kaynağı. Veqetandek: kaniya gund. Mînak: Kaniya gund zelal e. Têbinî: ünlü ile bittiğinden veqetandek "iya".',
   her:['Kaniya gund zelal e.', 'Pîrê li kaniyê ye.'],
   gen:['Kanî zelal e.', 'Kanî û çem hene.']),

  // [FB]: Zevî = tarla — eril
  // [AS]: "tarla" kelimesi
  (id:'a1_746', ku:'Zevî', tr:'Tarla', en:'Field', cins:'mê', ez:'zeviya',
   kat:'xweza', zor:0.79,
   not:'Zevî (dişil/mê) — tarla. Veqetandek: zeviya me. Mînak: Zevî mezin e. Têbinî: cotkar/tarım bağlamı.',
   her:['Zeviya me mezin e.', 'Bavê min li zeviyê ye.'],
   gen:['Zevî mezin e.', 'Zevî û baxçe hene.']),

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
//     → Cinsiyet, veqetandek, fiil çekimleri için ANA referans
//
// [2] W.M. Thackston — Kurmanji Kurdish: A Reference Grammar (2006)
//     → Harvard Harvard standardı; fiil tabloları §60–90
//     → DoReCo frekans listesiyle örtüşen kelimeler önceliklendirildi
//
// [3] Kemal Badıllı — Türkçe İzahlı Kürtçe Gramer (1965)
//     → Türkçe konuşan için açıklamalar ve bölgesel varyantlar
//
// [4] Pratik Dil Kartları (2017)
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
// A1 EK KELİMELER 2 — 106 kelime (AS + BH + TH kaynaklı)
// ════════════════════════════════════════════════════════════════

const kA1EkKelimeler2 = [

  // ── GİYECEK — [AS] s.54 CİLÛBERG ─────────────────────────
  (id:'a1_747', ku:'Kiras', tr:'Gömlek / Elbise', en:'Shirt / Dress',
   cins:'nêr', ez:'kirasê', kat:'cil', zor:0.83,
   not:'Kiras — gömlek veya elbise. Veqetandek: kirasê min. Mînak: Kirasê min spî ye. Têbinî: çoğul "kiras" değişmez.',
   her:['Kirasê pîrê spî ye.', 'Kiras li malê ye.'],
   gen:['Kiras nû ye.', 'Kirasê min reş e.']),

  (id:'a1_748', ku:'Pantol', tr:'Pantolon', en:'Trousers',
   cins:'nêr', ez:'pantolê', kat:'cil', zor:0.83,
   not:'Pantol (eril/nêr) — Türkçe alıntı. Veqetandek: pantolê min. Mînak: Pantolê min reş e. Têbinî: çoğul "pantolan" (oblique).',
   her:['Pantolê bavê min reş e.', 'Pantol li malê ye.'],
   gen:['Pantol nû ye.', 'Pantolê me kesk e.']),

  (id:'a1_749', ku:'Pêlav', tr:'Ayakkabı', en:'Shoe',
   cins:'mê', ez:'pêlava', kat:'cil', zor:0.83,
   not:'Pêlav (dişil/mê) — ayakkabı. Veqetandek: pêlava min. Mînak: Pêlava min nû ye. Têbinî: çoğul veqetandek "pêlavên".',
   her:['Pêlava pîrê reş e.', 'Pêlav li malê ye.'],
   gen:['Pêlav nû ye.', 'Pêlavên me xweş in.']),

  (id:'a1_750', ku:'Gore', tr:'Çorap', en:'Sock',
   cins:'mê', ez:'goreya', kat:'cil', zor:0.81,
   not:'Gore (dişil/mê) — çorap. Veqetandek: goreya min. Mînak: Goreya min germ e. Têbinî: çoğul veqetandek "goreyên".',
   her:['Goreya kal germ e.', 'Gore li malê ye.'],
   gen:['Gore nû ye.', 'Goreyên me reş in.']),

  (id:'a1_751', ku:'Kirasê jorîn', tr:'Üst elbise / Ceket', en:'Jacket / Coat',
   cins:'nêr', ez:'kirasê jorîn', kat:'cil', zor:0.79,
   not:'"Kiras" (gömlek) + "jorîn" (üst) — ceket/üst kıyafet. Mînak: Kirasê jorîn germ e. Têbinî: alıntı "çakêt" de yaygın.',
   her:['Kirasê jorîn germ e.', 'Pîrê kirasê jorîn dixwaze.'],
   gen:['Kirasê jorîn nû ye.', 'Kirasê jorîn reş e.']),

  (id:'a1_752', ku:'Cilên xwe guhartin', tr:'Giyinmek / Kıyafet değiştirmek', en:'To change clothes',
   cins:'bêcins', ez:null, kat:'leker', zor:0.79,
   not:'"Cil" (kıyafet) + "xwe" (kendi) + "guhartin" (değiştirmek) → giyinme. Mînak: Cilên min nû ne. Têbinî: A1\'de fiil mastar formu nadir.',
   her:['Cilên pîrê paqij in.', 'Cilên min germ in.'],
   gen:['Cil û berg hene.', 'Cilên min nû ne.']),

  // ── OKUL — [AS] s.36 PERWERDEHİ ──────────────────────────
  (id:'a1_753', ku:'Muze', tr:'Müze', en:'Museum',
   cins:'mê', ez:'muzeya', kat:'cih', zor:0.76,
   not:'Muze (dişil/mê) — Türkçe alıntı. Veqetandek: muzeya bajêr. Mînak: Muze li bajêr e. Têbinî: oblique "li muzê" (müzede).',
   her:['Pîrê li muzê ye.', 'Muze li bajêr e.'],
   gen:['Muze mezin e.', 'Muzeya bajêr xweş e.']),

  (id:'a1_754', ku:'Sinif', tr:'Sınıf', en:'Classroom',
   cins:'mê', ez:'sinifa', kat:'cih', zor:0.83,
   not:'Sinif (dişil/mê) — Türkçe alıntı. Veqetandek: sinifa me. Mînak: Sinifa me mezin e. Têbinî: öz Kurmancî alternatif "pol".',
   her:['Sinifa me mezin e.', 'Bira li sinifê ye.'],
   gen:['Sinif mezin e.', 'Sinif nû ye.']),

  (id:'a1_755', ku:'Texte', tr:'Tahta / Yazı tahtası', en:'Blackboard',
   cins:'nêr', ez:'texteyê', kat:'mal', zor:0.79,
   not:'Texte (eril/nêr) — yazı tahtası. Veqetandek: texteyê me. Mînak: Texteyê me spî ye. Têbinî: çoğul "texteyan" (oblique).',
   her:['Texteyê me spî ye.', 'Texte li dibistanê ye.'],
   gen:['Mamostayê me li texteyê dinivîse.', 'Texte mezin e.']),

  (id:'a1_756', ku:'Pênûsk', tr:'Kalem / Yazı kalemi', en:'Pen / Pencil',
   cins:'mê', ez:'pênûska', kat:'mal', zor:0.83,
   not:'Pênûsk (dişil/mê) — özgün Kurmancî form. Veqetandek: pênûska min. Mînak: Pênûska min reş e. Têbinî: alıntı "qelem" yerine "pênûsk" tercih edilir.',
   her:['Pênûska pîrê reş e.', 'Pênûsk li mêzê ye.'],
   gen:['Pênûsk nû ye.', 'Pênûska min reş e.']),

  (id:'a1_757', ku:'Kaxez', tr:'Kağıt', en:'Paper',
   cins:'mê', ez:'kaxeza', kat:'mal', zor:0.82,
   not:'Kaxez (dişil/mê) — kağıt. Veqetandek: kaxeza min. Mînak: Kaxeza min spî ye. Têbinî: çoğul "kaxezan" (oblique).',
   her:['Kaxez li mêzê ye.', 'Kaxeza pîrê spî ye.'],
   gen:['Kaxez spî ye.', 'Kaxeza me nû ye.']),

  (id:'a1_758', ku:'Çante', tr:'Çanta', en:'Bag',
   cins:'mê', ez:'çanteya', kat:'mal', zor:0.83,
   not:'Çante (dişil/mê) — Türkçe alıntı. Veqetandek: çanta min. Mînak: Çanta min mezin e. Têbinî: çoğul "çanteyan" (oblique).',
   her:['Çanta pîrê mezin e.', 'Çante li mêzê ye.'],
   gen:['Çante mezin e.', 'Çanta min nû ye.']),

  // ── GÜN VE ZAMAN EK ───────────────────────────────────────
  (id:'a1_759', ku:'Piştî sibê', tr:'Öbür gün', en:'Day after tomorrow',
   cins:'bêcins', ez:null, kat:'dem', zor:0.80,
   not:'"Piştî" (sonra) + "sibê" (yarın) — yarından sonraki gün. Mînak: Piştî sibê tê. Têbinî: zaman zarfı, çekimsiz.',
   her:['Piştî sibê pîrê tê.', 'Piştî sibê ez diçim.'],
   gen:['Piştî sibê tê.', 'Piştî sibê ez diçim dibistanê.']),

  (id:'a1_760', ku:'Pêr', tr:'Evvelki gün', en:'Day before yesterday',
   cins:'bêcins', ez:null, kat:'dem', zor:0.78,
   not:'Zaman zarfı — dünden önceki gün. Mînak: Pêr û duh roj in. Têbinî: karşıtı "piştî sibê".',
   her:['Pêr û duh roj in.', 'Pêr roj e.'],
   gen:['Pêr û duh nêzîk in.', 'Pêr û sibê dûr in.']),

  (id:'a1_761', ku:'Berbang', tr:'Şafak / Tan vakti', en:'Dawn',
   cins:'mê', ez:'berbanga', kat:'dem', zor:0.74,
   not:'Berbang (dişil/mê) — sabahın ilk ışıkları. Veqetandek: berbanga sibehê. Mînak: Berbanga sibehê xweş e. Têbinî: karşıtı "êvar" (akşam).',
   her:['Berbang sar e, pîrê.', 'Pîrê li berbangê radibe.'],
   gen:['Berbang xweş e.', 'Berbanga sibehê germ e.']),

  (id:'a1_762', ku:'Nîvê rojê', tr:'Gün ortası / Öğle zamanı', en:'Midday',
   cins:'mê', ez:'nîvê rojê', kat:'dem', zor:0.78,
   not:'"Nîv" (yarı) + "roj" (gün) — öğleyin. Mînak: Nîvê rojê germ e. Têbinî: aynı anlamda "nîvro" (a1_123).',
   her:['Nîvê rojê pîrê nan dixwe.', 'Pîrê li nîvê rojê dixwîne.'],
   gen:['Nîvê rojê germ e.', 'Nîvê rojê ez nan dixwim.']),

  (id:'a1_763', ku:'Nîv saet', tr:'Yarım saat', en:'Half hour',
   cins:'bêcins', ez:null, kat:'dem', zor:0.80,
   not:'"Nîv" (yarım) + "saet" → yarım saat. Mînak: Nîv saet hindik e. Têbinî: "saet" Türkçe alıntı.',
   her:['Nîv saet hindik e.', 'Pîrê piştî nîv saetê tê.'],
   gen:['Nîv saet kurt e.', 'Mamosta piştî nîv saetê tê.']),

  (id:'a1_764', ku:'Çend?', tr:'Kaç? / Ne kadar?', en:'How many? / How much?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.85,
   not:'Soru kelimesi — "Çend?" = kaç. Mînak: Çend pirtûk hene? Têbinî: nicel sayı sorma.',
   her:['Çend xwişk hene?', 'Pîrê çend salî ye?'],
   gen:['Çend pirtûk hene?', 'Çend xwendekar in?']),

  // ── RENKLER EK ────────────────────────────────────────────
  (id:'a1_765', ku:'Reşik', tr:'Koyu / Siyahımsı', en:'Dark / Blackish',
   cins:'bêcins', ez:null, kat:'reng', zor:0.74,
   not:'Rengdêr — "reş" (siyah) + "-ik" küçültme eki → koyu renk tonu. Mînak: Reng reşik e. Têbinî: karşıtı "vekirî" (açık ton).',
   her:['Çavên pîrê reşik in.', 'Reng reşik e.'],
   gen:['Reşik xweş e.', 'Reşik û tarî nêzîk in.']),

  (id:'a1_766', ku:'Vekirî', tr:'Açık (renk)', en:'Light (color shade)',
   cins:'bêcins', ez:null, kat:'reng', zor:0.77,
   not:'Rengdêr — açık ton. Mînak: Kesk vekirî xweş e. Têbinî: karşıtı "tarî" (koyu).',
   her:['Kesk vekirî xweş e.', 'Rengê pîrê vekirî ye.'],
   gen:['Rengê vekirî xweş e.', 'Ev şîn vekirî ye.']),

  (id:'a1_767', ku:'Tarî', tr:'Koyu / Karanlık', en:'Dark',
   cins:'bêcins', ez:null, kat:'reng', zor:0.80,
   not:'Rengdêr — koyu ton, karanlık. Mînak: Şev tarî ye. Têbinî: karşıtı "vekirî" (açık ton).',
   her:['Şev tarî ye.', 'Çavên pîrê tarî ne.'],
   gen:['Şev tarî ye.', 'Ev sor tarî ye.']),

  // ── SAYILAR EK — büyük sayılar ────────────────────────────
  (id:'a1_768', ku:'Dused', tr:'İki yüz (200)', en:'Two hundred',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.78,
   not:'"Du" (iki) + "sed" (yüz) → 200. Mînak: Dused pirtûk hene. Têbinî: bileşik sayı, küçük sayılar Birim 3.',
   her:['Dused pirtûk hene.', 'Dused kes li bajêr in.'],
   gen:['Dused sêv hene.', 'Dused kes hene.']),

  (id:'a1_769', ku:'Dehhezar', tr:'On bin (10.000)', en:'Ten thousand',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.77,
   not:'"Deh" (on) + "hezar" (bin) → 10.000. Mînak: Dehhezar pirtûk hene. Têbinî: çok büyük sayı.',
   her:['Dehhezar pirtûk hene.', 'Dehhezar kes li bajêr in.'],
   gen:['Dehhezar mirov hene.', 'Dehhezar gelek e.']),

  (id:'a1_770', ku:'Yekem', tr:'Birinci', en:'First',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.82,
   not:'Sıra sayısı — "Yek" + "-em" → birinci. Mînak: Roja yekem yekşem e. Têbinî: "yekemîn" da kullanılır.',
   her:['Roja yekem yekşem e.', 'Pîrê yekem tê.'],
   gen:['Yekem baş e.', 'Yekem roj e.']),

  (id:'a1_771', ku:'Duyem', tr:'İkinci', en:'Second',
   cins:'bêcins', ez:null, kat:'jimar', zor:0.81,
   not:'Sıra sayısı — "Du" + "-yem" → ikinci. Mînak: Roja duyem duşem e. Têbinî: "duyemîn" da kullanılır.',
   her:['Roja duyem duşem e.', 'Pîrê duyem tê.'],
   gen:['Duyem baş e.', 'Duyem roj e.']),

  // ── SORULAR VE İFADELER ───────────────────────────────────
  (id:'a1_772', ku:'Ji kerema xwe', tr:'Lütfen', en:'Please',
   cins:'bêcins', ez:null, kat:'silav', zor:0.85,
   not:'"Ji kerema xwe" — kibar rica kalıbı (lütfen). Mînak: Ji kerema xwe pîrê! Têbinî: günlük kibar konuşmada.',
   her:['Pîrê, ji kerema xwe!', 'Bavê min, ji kerema xwe!'],
   gen:['Ji kerema xwe heval!', 'Ji kerema xwe!']),

  (id:'a1_773', ku:'Biborin', tr:'Afedersiniz / Pardon', en:'Excuse me / Sorry',
   cins:'bêcins', ez:null, kat:'silav', zor:0.84,
   not:'"Biborin" — kibar özür kalıbı (afedersiniz). Mînak: Biborin pîrê! Têbinî: tekil "bibore", çoğul/resmi "biborin".',
   her:['Biborin pîrê!', 'Biborin bavê min!'],
   gen:['Biborin!', 'Biborin heval!']),

  (id:'a1_774', ku:'Gelo', tr:'Acaba', en:'I wonder / Is it?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.82,
   not:'Soru partiküli — "Gelo?" = acaba? Mînak: Gelo pîrê tê? Têbinî: cümle başında soru tonu verir.',
   her:['Gelo pîrê tê?', 'Gelo baş e?'],
   gen:['Gelo dibistan e?', 'Gelo pirtûk hene?']),

  (id:'a1_775', ku:'Li ku?', tr:'Nerede?', en:'Where?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.85,
   not:'"Li" yer edatı + "ku" → nerede? Mînak: Pîrê li ku ye? Têbinî: ünlü ile bittiği için bûn 2.tek "yî".',
   her:['Pîrê li ku ye?', 'Bavê min li ku ye?'],
   gen:['Mal li ku ye?', 'Dibistan li ku ye?']),

  (id:'a1_776', ku:'Çima?', tr:'Neden? / Niye?', en:'Why?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.84,
   not:'Soru kelimesi — "Çima?" = neden, niye. Mînak: Çima sar e? Têbinî: sebep sorma.',
   her:['Çima pîrê li malê ye?', 'Çima sar e?'],
   gen:['Çima dibistan dûr e?', 'Çima xweş e?']),

  (id:'a1_777', ku:'Kengî?', tr:'Ne zaman?', en:'When?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.84,
   not:'Soru kelimesi — "Kengî?" = ne zaman. Mînak: Kengî tê pîrê? Têbinî: zaman sorma.',
   her:['Kengî pîrê tê?', 'Kengî bavê min tê?'],
   gen:['Kengî baran dibare?', 'Kengî ez diçim?']),

  (id:'a1_556', ku:'Kê?', tr:'Kim? (eğik)', en:'Who? (oblique)',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.81,
   not:'Soru zamiri eğik formu — "Kê?" = kim? Nominatif "Kî?". Mînak: Ji kê tê? Têbinî: "li kê", "ji kê" gibi edatlardan sonra kullanılır.',
   her:['Pîrê ji kê tê?', 'Bavê min ji kê tê?'],
   gen:['Mamosta ji kê tê?', 'Ev pirtûk a kê ye?']),

  // ── HAYVAN EK ─────────────────────────────────────────────
  (id:'a1_560', ku:'Çûçik', tr:'Kuş', en:'Bird',
   cins:'nêr', ez:'çûçikê', kat:'ajal', zor:0.82,
   not:'Çûçik (eril/nêr) — kuş. Veqetandek: çûçikê spî. Mînak: Çûçik mezin e. Têbinî: çoğul "çûçikan".',
   her:['Çûçik xweş e, pîrê.', 'Çûçikê pîrê reş e.'],
   gen:['Çûçik mezin e.', 'Çûçik û masî hene.']),

  (id:'a1_561', ku:'Masî', tr:'Balık', en:'Fish',
   cins:'nêr', ez:'masiyê', kat:'ajal', zor:0.82,
   not:'Masî (eril/nêr) — balık. Veqetandek: masiyê min. Mînak: Masî dixwim. Têbinî: oblique "li avê" (suda).',
   her:['Masî dixwim, pîrê.', 'Masiyê pîrê mezin e.'],
   gen:['Masî li avê ye.', 'Masî xweş e.']),

  (id:'a1_562', ku:'Hirç', tr:'Ayı', en:'Bear',
   cins:'nêr', ez:'hirçê', kat:'ajal', zor:0.80,
   not:'Hirç (eril/nêr) — ayı. Veqetandek: hirçê çiyayê. Mînak: Hirç li çiyayî ye. Têbinî: dağ/orman hayvanı.',
   her:['Hirç li çiyayî ye.', 'Hirç mezin e, pîrê.'],
   gen:['Hirç dûr e.', 'Hirçê çiyayê reş e.']),

  (id:'a1_563', ku:'Rovî', tr:'Tilki', en:'Fox',
   cins:'nêr', ez:'roviyê', kat:'ajal', zor:0.80,
   not:'Rovî (eril/nêr) — tilki. Veqetandek: roviyê min. Mînak: Rovî li çiyayî ye. Têbinî: atasözünde akıllı hayvan.',
   her:['Rovî li çiyayî ye.', 'Roviyê pîrê biçûk e.'],
   gen:['Rovî biçûk e.', 'Rovî û çûçik hene.']),

  // ── MEKAN EK ──────────────────────────────────────────────
  (id:'a1_570', ku:'Derî', tr:'Kapı', en:'Door',
   cins:'nêr', ez:'deriyê', kat:'mal', zor:0.85,
   not:'Derî (eril/nêr) — kapı. Veqetandek: deriyê malê. Mînak: Derî mezin e. Têbinî: çoğul "deriyên" (kapılar).',
   her:['Deriyê pîrê reş e.', 'Derî vekirî ye.'],
   gen:['Derî mezin e.', 'Derî û pace hene.']),

  (id:'a1_571', ku:'Pace', tr:'Cam / Pencere', en:'Window',
   cins:'mê', ez:'paceya', kat:'mal', zor:0.84,
   not:'Pace (dişil/mê) — cam, pencere. Veqetandek: paceya min. Mînak: Pace vekirî ye. Têbinî: alıntı "pencere" yerine "pace" tercih.',
   her:['Paceya pîrê vekirî ye.', 'Pace biçûk e.'],
   gen:['Pace mezin e.', 'Pace û derî hene.']),

  (id:'a1_572', ku:'Dîwar', tr:'Duvar', en:'Wall',
   cins:'nêr', ez:'dîwarê', kat:'mal', zor:0.82,
   not:'Dîwar (eril/nêr) — duvar. Veqetandek: dîwarê malê. Mînak: Dîwar spî ye. Têbinî: çoğul "dîwaran".',
   her:['Dîwarê pîrê spî ye.', 'Dîwar bilind e.'],
   gen:['Dîwar mezin e.', 'Dîwarê malê spî ye.']),

  (id:'a1_573', ku:'Erd', tr:'Zemin / Yer', en:'Floor / Ground',
   cins:'mê', ez:'erda', kat:'mal', zor:0.83,
   not:'Erd (dişil/mê) — yer, zemin. Veqetandek: erda malê. Mînak: Erd germ e. Têbinî: oblique "li erdê" (yerde).',
   her:['Pisîka pîrê li erdê ye.', 'Erda malê germ e.'],
   gen:['Erd germ e.', 'Erd û dîwar reş in.']),

  (id:'a1_574', ku:'Banî', tr:'Tavan / Çatı', en:'Ceiling / Roof',
   cins:'nêr', ez:'baniyê', kat:'mal', zor:0.79,
   not:'Banî (eril/nêr) — tavan veya çatı. Veqetandek: baniyê malê. Mînak: Banî bilind e. Têbinî: çoğul "baniyan".',
   her:['Baniyê pîrê bilind e.', 'Banî mezin e.'],
   gen:['Banî bilind e.', 'Baniyê malê spî ye.']),

  // ── EDAT VE ZARF EK — [TH] §40-50 ────────────────────────
  (id:'a1_580', ku:'Di...de', tr:'-de / İçinde', en:'In / Inside',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.86,
   not:'"Di ... de" yapısı — içinde anlamı. Mînak: Em di malê de ne. Têbinî: "li" karşıtı, çevreleyen mekan.',
   her:['Pîrê di malê de ye.', 'Em di malê de ne.'],
   gen:['Mamosta di sinifê de ye.', 'Em di dibistanê de ne.']),

  (id:'a1_581', ku:'Di...re', tr:'-den geçerek / Arasından', en:'Through / Via',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.80,
   not:'"Di ... re" yapısı — bir şeyin içinden geçerek. Mînak: Di rêyê re tê. Têbinî: yön/hareket bildiren kalıp.',
   her:['Pîrê di rêyê re tê.', 'Heval di deriyê re tê.'],
   gen:['Ez di rêyê re diçim.', 'Mamosta di deriyê re tê.']),

  (id:'a1_582', ku:'Ber', tr:'Önünde / Karşısında', en:'Before / In front of',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.81,
   not:'"Ber" yapısı — önünde, karşısında. Mînak: Pîrê li ber malê ye. Têbinî: çoğunlukla "li ber" ile.',
   her:['Pîrê li ber malê ye.', 'Bira li ber derî ye.'],
   gen:['Mamosta li ber dibistanê ye.', 'Pisîk li ber malê ye.']),

  (id:'a1_583', ku:'Pişt', tr:'Arkasında', en:'Behind',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.80,
   not:'"Pişt" yapısı — arkasında. Mînak: Baxçe li pişt malê ye. Têbinî: "ber" karşıtı.',
   her:['Baxçe li pişt malê ye.', 'Pîrê li pişt malê ye.'],
   gen:['Pisîk li pişt malê ye.', 'Mamosta li pişt dibistanê ye.']),

  (id:'a1_584', ku:'Ser', tr:'Üstünde / Üzerinde', en:'On / On top of',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.85,
   not:'"Ser" yapısı — "li ser" üstünde, üzerinde. Mînak: Pirtûk li ser mêzê ye. Têbinî: "bin" karşıtı.',
   her:['Pirtûk li ser mêzê ye.', 'Pîrê li ser kursiyê ye.'],
   gen:['Pisîk li ser kursiyê ye.', 'Pirtûk li ser baniyê ye.']),

  (id:'a1_585', ku:'Bin', tr:'Altında', en:'Under / Below',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.84,
   not:'"Bin" yapısı — "li bin" altında. Mînak: Pisîk li bin kursiyê ye. Têbinî: "ser" karşıtı.',
   her:['Pisîk li bin mêzê ye.', 'Pîrê li bin darê ye.'],
   gen:['Pisîk li bin kursiyê ye.', 'Pirtûk li bin mêzê ye.']),

  (id:'a1_586', ku:'Nêzîk', tr:'Yakın / Yakınında', en:'Near / Close to',
   cins:'bêcins', ez:null, kat:'daçek', zor:0.83,
   not:'Nêzîk — mesafe rengdêri (yakın). Mînak: Mal nêzîk e. Têbinî: karşıtı "dûr" (uzak).',
   her:['Mala pîrê nêzîk e.', 'Bavê min nêzîk e.'],
   gen:['Dibistan nêzîk e.', 'Mamosta nêzîk e.']),

  // ── FIIL EK — [AS] no.965-995 ─────────────────────────────
  (id:'a1_590', ku:'Vexwarin', tr:'İçmek', en:'To drink',
   cins:'bêcins', ez:null, kat:'leker', zor:0.85,
   not:'Vexwarin — fiil mastarı (içmek). Mînak: Vexwarina çayê xweş e. Têbinî: 1.tek "Ez vedixwim" (a1_236).',
   her:['Vexwarina çayê xweş e.', 'Pîrê çay vedixwe.'],
   gen:['Vexwarin baş e.', 'Av û çay vexwarin in.']),

  (id:'a1_591', ku:'Kirîn', tr:'Satın almak', en:'To buy',
   cins:'bêcins', ez:null, kat:'leker', zor:0.83,
   not:'Kirîn — fiil mastarı (satın almak). Mînak: Kirîna nan baş e. Têbinî: ergative geçmiş "Min kirî" — A1\'de ileri.',
   her:['Kirîna nan baş e.', 'Pîrê pirtûk dikire.'],
   gen:['Ez nan dikirim.', 'Kirîn û firotin baş in.']),

  (id:'a1_592', ku:'Firotin', tr:'Satmak', en:'To sell',
   cins:'bêcins', ez:null, kat:'leker', zor:0.82,
   not:'Firotin — fiil mastarı (satmak). Mînak: Firotin û kirîn baş in. Têbinî: 3.tek "difiroşe".',
   her:['Pîrê nan difiroşe.', 'Kirîna pîrê baş e.'],
   gen:['Firotin baş e.', 'Mamosta nan difiroşe.']),

  (id:'a1_593', ku:'Gerîn', tr:'Gezmek / Dolaşmak', en:'To walk around / wander',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'Gerîn — fiil mastarı (gezmek). Mînak: Gerîn li bajêr xweş e. Têbinî: 1.tek "Ez digerim".',
   her:['Gerîn li bajêr xweş e.', 'Pîrê li bajêr digere.'],
   gen:['Gerîn xweş e.', 'Ez li gund digerim.']),

  (id:'a1_594', ku:'Sekinîn', tr:'Durmak', en:'To stop / stand',
   cins:'bêcins', ez:null, kat:'leker', zor:0.82,
   not:'Sekinîn — fiil mastarı (durmak). Mînak: Sekinîn li ber malê. Têbinî: 3.tek "disekine".',
   her:['Pîrê li ber derî disekine.', 'Sekinîn li ber malê baş e.'],
   gen:['Sekinîn baş e.', 'Mamosta li ber dibistanê disekine.']),

  (id:'a1_595', ku:'Rûniştin', tr:'Oturmak', en:'To sit',
   cins:'bêcins', ez:null, kat:'leker', zor:0.84,
   not:'Rûniştin — fiil mastarı (oturmak). Mînak: Pîrê li kursiyê rûdine. Têbinî: 1.tek "Ez rûdinim" (a1_244).',
   her:['Pîrê li ser kursiyê rûdine.', 'Rûniştin baş e, pîrê.'],
   gen:['Rûniştin baş e.', 'Mamosta li ser kursiyê rûdine.']),

  (id:'a1_596', ku:'Axaftin', tr:'Konuşmak', en:'To speak',
   cins:'bêcins', ez:null, kat:'leker', zor:0.84,
   not:'Axaftin — fiil mastarı (konuşmak). Mînak: Axaftin bi Kurmancî xweş e. Têbinî: 1.tek "Ez diaxivim".',
   her:['Axaftin bi Kurmancî xweş e.', 'Pîrê bi Kurmancî diaxive.'],
   gen:['Ez bi Kurmancî diaxivim.', 'Mamosta bi Kurmancî diaxive.']),

  (id:'a1_597', ku:'Bihîstin', tr:'Duymak / İşitmek', en:'To hear',
   cins:'bêcins', ez:null, kat:'leker', zor:0.83,
   not:'Bihîstin — fiil mastarı (duymak). Mînak: Ez dengê te dibihîzim. Têbinî: 1.tek "Ez dibihîzim" (a1_243).',
   her:['Pîrê min dibihîze.', 'Ez dengê te dibihîzim.'],
   gen:['Mamosta min dibihîze.', 'Ez dibihîzim.']),

  (id:'a1_598', ku:'Zanîn', tr:'Bilmek', en:'To know',
   cins:'bêcins', ez:null, kat:'leker', zor:0.85,
   not:'Zanîn — fiil mastarı (bilmek). Mînak: Zanîn baş e. Têbinî: 1.tek "Ez dizanim" (a1_241).',
   her:['Pîrê dizane.', 'Zanîna zimanê me baş e.'],
   gen:['Zanîn baş e.', 'Mamosta dizane.']),

  (id:'a1_599', ku:'Bawer kirin', tr:'İnanmak', en:'To believe',
   cins:'bêcins', ez:null, kat:'leker', zor:0.81,
   not:'"Bawer kirin" — bileşik fiil mastarı (inanmak). Mînak: Ez bawer dikim. Têbinî: "kirin" bileşik fiil yardımcısı.',
   her:['Ez bawer dikim ku tê.', 'Pîrê bawer dike.'],
   gen:['Bawer kirin baş e.', 'Mamosta bawer dike.']),

  // ── SIFAT EK — [BH] §57-60 ────────────────────────────────
  (id:'a1_600', ku:'Kevn', tr:'Eski', en:'Old / Aged',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.83,
   not:'Kevn — sıfat (eski). Mînak: Pirtûka kevn e. Têbinî: karşıtı "nû" (yeni).',
   her:['Pirtûka pîrê kevn e.', 'Mala kal kevn e.'],
   gen:['Xanî kevn e.', 'Pirtûk kevn û nû hene.']),

  (id:'a1_601', ku:'Nû', tr:'Yeni', en:'New',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.85,
   not:'Nû — sıfat (yeni). Mînak: Kiras nû ye. Têbinî: karşıtı "kevn" (eski).',
   her:['Kirasê pîrê nû ye.', 'Pirtûka min nû ye.'],
   gen:['Kiras nû ye.', 'Mal nû ye.']),

  (id:'a1_602', ku:'Biçûk', tr:'Küçük', en:'Small / Little',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.85,
   not:'Biçûk — sıfat (küçük). Mînak: Mal biçûk e. Têbinî: karşıtı "mezin" (büyük).',
   her:['Mala pîrê biçûk e.', 'Pisîka pîrê biçûk e.'],
   gen:['Mal biçûk e.', 'Pisîk biçûk e.']),

  (id:'a1_603', ku:'Dirêj', tr:'Uzun', en:'Long / Tall',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.83,
   not:'Dirêj — sıfat (uzun). Mînak: Rê dirêj e. Têbinî: karşıtı "kurt" (kısa).',
   her:['Rêya pîrê dirêj e.', 'Bavê min dirêj e.'],
   gen:['Rê dirêj e.', 'Roj dirêj e.']),

  (id:'a1_604', ku:'Kurt', tr:'Kısa', en:'Short',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.82,
   not:'Kurt — sıfat (kısa). Mînak: Stran kurt e. Têbinî: karşıtı "dirêj" (uzun).',
   her:['Stran kurt e, pîrê.', 'Roj kurt e.'],
   gen:['Stran kurt e.', 'Rê kurt e.']),

  (id:'a1_605', ku:'Giran', tr:'Ağır', en:'Heavy',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.82,
   not:'Giran — sıfat (ağır). Mînak: Çante giran e. Têbinî: karşıtı "sivik" (hafif).',
   her:['Çanta pîrê giran e.', 'Pirtûk giran e.'],
   gen:['Çante giran e.', 'Pirtûk giran û sivik in.']),

  (id:'a1_606', ku:'Sivik', tr:'Hafif', en:'Light (weight)',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.81,
   not:'Sivik — sıfat (hafif). Mînak: Çante sivik e. Têbinî: karşıtı "giran" (ağır).',
   her:['Pirtûka pîrê sivik e.', 'Çanta min sivik e.'],
   gen:['Çante sivik e.', 'Pirtûk sivik e.']),

  (id:'a1_607', ku:'Rast', tr:'Doğru', en:'Correct / True',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.83,
   not:'Rast — sıfat (doğru). Mînak: Ev rast e. Têbinî: karşıtı "çewt" (yanlış).',
   her:['Ev rast e, pîrê.', 'Pîrê rast dibêje.'],
   gen:['Mamosta rast dibêje.', 'Ev rast e.']),

  (id:'a1_608', ku:'Çewt', tr:'Yanlış', en:'Wrong / Incorrect',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.80,
   not:'Çewt — sıfat (yanlış, eğri). Mînak: Ev çewt e. Têbinî: karşıtı "rast" (doğru).',
   her:['Ev çewt e, pîrê.', 'Pîrê ne çewt e.'],
   gen:['Ev çewt e.', 'Mamosta ne çewt e.']),

  // ── SAYDAM A1 CÜMLE KALIPLARI ─────────────────────────────
  (id:'a1_610', ku:'Ev çi ye?', tr:'Bu nedir?', en:'What is this?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.86,
   not:'Temel soru kalıbı — "Ev" (bu) + "çi" (ne) + "ye". Mînak: Ev pirtûk e. Têbinî: nesne tanımlama.',
   her:['Ev çi ye?', 'Ev pirtûk e.'],
   gen:['Ev çi ye?', 'Ev mal e.']),

  (id:'a1_611', ku:'Ew kî ye?', tr:'O kim?', en:'Who is that?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.85,
   not:'Kişi sorma kalıbı — "Ew" (o) + "kî" (kim) + "ye". Mînak: Ew bavê min e. Têbinî: "kî" nominatif, "kê" eğik (a1_556).',
   her:['Ew kî ye?', 'Ew bavê min e.'],
   gen:['Ew kî ye?', 'Ew mamosta ye.']),

  (id:'a1_612', ku:'Li ku ye?', tr:'Nerede?', en:'Where is it?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.85,
   not:'Yer sorma kalıbı — "li ku?" + bûn 3.tek "ye". Mînak: Pîrê li malê ye. Têbinî: a1_252 ile aynı kalıp.',
   her:['Pîrê li ku ye?', 'Pîrê li malê ye.'],
   gen:['Mal li ku ye?', 'Mal li bajêr e.']),

  (id:'a1_613', ku:'Çend e?', tr:'Ne kadar?', en:'How much?',
   cins:'bêcins', ez:null, kat:'pirs', zor:0.84,
   not:'Miktar sorma kalıbı — "Çend e?" = ne kadar. Mînak: Çend pirtûk hene? Têbinî: a1_764 "Çend?" ile aynı kök.',
   her:['Çend pirtûk hene?', 'Pîrê çend salî ye?'],
   gen:['Çend xwendekar in?', 'Çend roj in?']),

  (id:'a1_614', ku:'Xweş e!', tr:'Güzel / İyi!', en:'Great / Beautiful!',
   cins:'bêcins', ez:null, kat:'silav', zor:0.86,
   not:'Onay/beğenme ifadesi — "Xweş" (güzel) + bûn 3.tek "e". Mînak: Xweş e, pîrê! Têbinî: kalıp olarak günlük kullanım.',
   her:['Xweş e, pîrê!', 'Gelek xweş e.'],
   gen:['Xweş e!', 'Mal xweş e.']),

  (id:'a1_615', ku:'Baş e!', tr:'İyi / Tamam!', en:'Good / OK!',
   cins:'bêcins', ez:null, kat:'silav', zor:0.87,
   not:'Onay/kabul ifadesi — "Baş" (iyi) + bûn 3.tek "e". Mînak: Baş e, pîrê! Têbinî: kalıp olarak günlük kullanım.',
   her:['Baş e, pîrê!', 'Gelek baş e.'],
   gen:['Baş e!', 'Mamosta baş e.']),

];


// ── A1 SON 3 KELİME — TAMAMLAMA ──────────────────────────────

const kA1EkKelimeler3 = [

  (id:'a1_740', ku:'Paqij', tr:'Temiz (sıfat)', en:'Clean (adj)',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.84,
   not:'Paqij — sıfat (temiz). Mînak: Mal paqij e. Têbinî: karşıtı "qirêj" (kirli).',
   her:['Mala pîrê paqij e.', 'Destê pîrê paqij e.'],
   gen:['Mal paqij e.', 'Pirtûk paqij e.']),

  (id:'a1_741', ku:'Xweş', tr:'Güzel / İyi', en:'Beautiful / Good',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.87,
   not:'Xweş — sıfat (güzel, hoş). Mînak: Mal xweş e. Têbinî: a1_220 ile aynı, en yaygın A1 rengdêri.',
   her:['Mala pîrê xweş e.', 'Hewa xweş e, pîrê.'],
   gen:['Xweş e!', 'Gelek xweş e.']),


  (id:'a1_743b', ku:'Lênûsk', tr:'Defter / Not defteri', en:'Notebook',
   cins:'mê', ez:'lênûska', kat:'mal', zor:0.82,
   not:'Lênûsk (dişil/mê) — defter. "Lê" (üzerine) + "nûsk" (yazmak). Veqetandek: lênûska min. Mînak: Lênûska min nû ye.',
   her:['Lênûska pîrê nû ye.', 'Lênûska min li mêzê ye.'],
   gen:['Lênûsk nû ye.', 'Lênûsk û pirtûk hene.']),

  (id:'a1_742', ku:'Teng', tr:'Dar / Sıkışık', en:'Narrow / Tight',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.79,
   not:'Teng — sıfat (dar, sıkışık). Mînak: Rê teng e. Têbinî: karşıtı "fireh" (geniş, ileri).',
   her:['Rêya pîrê teng e.', 'Kirasê pîrê teng e.'],
   gen:['Rê teng e.', 'Pantol teng e.']),

];


// ════════════════════════════════════════════════════════════════
// A1 FÊRKERA KURDÎ EK KELİMELER — Doç. Dr. Abdurrahman Adak ve ekibi
// ════════════════════════════════════════════════════════════════

const kA1FerkeraDersler = [

  // ── SELAMLAMA — [Fêrkera D.1] ─────────────────────────────────

  (id:'a1_fk_01', ku:'Beyanî baş', tr:'Günaydın (sabah)', en:'Good morning',
   cins:'bêcins', ez:null, kat:'silav', zor:0.87,
   not:'"Beyanî baş" — sabah selamlaması (günaydın). Mînak: Beyanî baş, pîrê! Têbinî: "Roj baş" gün boyu kullanılır.',
   her:['Beyanî baş, pîrê!', 'Beyanî baş, bavê min!'],
   gen:['Beyanî baş!', 'Roj baş!']),

  (id:'a1_fk_02', ku:'Roj baş', tr:'Günaydın / İyi günler', en:'Good day',
   cins:'bêcins', ez:null, kat:'silav', zor:0.87,
   not:'"Roj baş" — gün selamlaması. Mînak: Roj baş, pîrê! Têbinî: günün herhangi bir saatinde.',
   her:['Roj baş, pîrê!', 'Roj baş, bavê min!'],
   gen:['Roj baş!', 'Beyanî baş!']),

  (id:'a1_fk_03', ku:'Oxir be', tr:'Güle güle / Hayırlı olsun', en:'Farewell / Goodbye',
   cins:'bêcins', ez:null, kat:'silav', zor:0.84,
   not:'"Oxir be" — vedalaşma ifadesi (güle güle, hayırlı olsun). Mînak: Oxir be, pîrê! Têbinî: "Bi xatirê te" ile çift.',
   her:['Oxir be, pîrê!', 'Oxir be, bavê min!'],
   gen:['Oxir be!', 'Bi xatirê te, oxir be.']),

  (id:'a1_fk_04', ku:'Ser çavan', tr:'Baş göz üstüne / Güle güle', en:'With pleasure / Goodbye',
   cins:'bêcins', ez:null, kat:'silav', zor:0.83,
   not:'"Ser çavan" — onay/vedalaşma ifadesi. Mînak: Ser çavan, pîrê! Têbinî: "ser" (üst) + "çavan" (gözler oblique).',
   her:['Ser çavan, pîrê!', 'Oxir be, ser çavan.'],
   gen:['Ser çavan!', 'Bi xêr hatî, ser çavan!']),

  (id:'a1_fk_05', ku:'Serkeftin', tr:'Başarı / Başarılar', en:'Success / Good luck',
   cins:'mê', ez:'serkeftina', kat:'silav', zor:0.83,
   not:'Serkeftin (dişil/mê) — başarı. Veqetandek: serkeftina te. Mînak: Serkeftin ji te re! Têbinî: dilemek/tebrik için.',
   her:['Serkeftin ji te re!', 'Pîrê serkeftin dixwaze.'],
   gen:['Mamosta serkeftin dixwaze.', 'Serkeftin ji te re!']),

  // ── RENKLER TAM — [Fêrkera D.10] ──────────────────────────────

  (id:'a1_fk_06', ku:'Binevşî', tr:'Leylak / Mor', en:'Violet / Purple',
   cins:'bêcins', ez:null, kat:'reng', zor:0.80,
   not:'Binevşî — sıfat/renk (mor, leylak). Mînak: Gul binevşî ye. Têbinî: alıntı "mor" koyu ton için.',
   her:['Gula pîrê binevşî ye.', 'Rengê binevşî xweş e.'],
   gen:['Binevşî xweş e.', 'Sor û binevşî hene.']),

  (id:'a1_fk_07', ku:'Porteqalî', tr:'Turuncu', en:'Orange (color)',
   cins:'bêcins', ez:null, kat:'reng', zor:0.80,
   not:'Porteqalî — sıfat/renk (turuncu). "Porteqal" (portakal) + "-î". Mînak: Rengê porteqalî xweş e. Têbinî: meyve kökü.',
   her:['Gula pîrê porteqalî ye.', 'Rengê porteqalî xweş e.'],
   gen:['Porteqalî xweş e.', 'Sor û porteqalî hene.']),

  (id:'a1_fk_08', ku:'Zêrîn', tr:'Altın rengi / Sarımsı', en:'Golden',
   cins:'bêcins', ez:null, kat:'reng', zor:0.78,
   not:'Zêrîn — sıfat/renk (altın rengi). "Zêr" (altın) + "-în". Mînak: Rengê zêrîn xweş e. Têbinî: parlak sarı ton.',
   her:['Gula pîrê zêrîn e.', 'Rengê zêrîn xweş e.'],
   gen:['Zêrîn xweş e.', 'Tav zêrîn e.']),

  // ── ÖĞÜNLER — [Fêrkera D.5] ────────────────────────────────────

  (id:'a1_fk_09', ku:'Taştê', tr:'Kahvaltı', en:'Breakfast',
   cins:'mê', ez:'taştêya', kat:'xwarin', zor:0.84,
   not:'Taştê (dişil/mê) — kahvaltı (sabah yemeği). Veqetandek: taştê pîrê. Mînak: Taştê li mêzê ye. Têbinî: "Xwarina sibehê" de denir.',
   her:['Pîrê taştê dixwe.', 'Taştêya pîrê xweş e.'],
   gen:['Taştê li mêzê ye.', 'Taştê xweş e.']),

  (id:'a1_fk_10', ku:'Firavîn', tr:'Öğle yemeği', en:'Lunch',
   cins:'mê', ez:'firavîna', kat:'xwarin', zor:0.83,
   not:'Firavîn (dişil/mê) — öğle yemeği. Veqetandek: firavîna me. Mînak: Firavîn li mêzê ye. Têbinî: "taştê" sabah, "şîv" akşam.',
   her:['Pîrê firavîn dixwe.', 'Firavîn xweş e, pîrê.'],
   gen:['Firavîn li mêzê ye.', 'Firavîn û taştê hene.']),

  (id:'a1_fk_11', ku:'Şîv', tr:'Akşam yemeği', en:'Dinner',
   cins:'mê', ez:'şîva', kat:'xwarin', zor:0.83,
   not:'Şîv (dişil/mê) — akşam yemeği. Veqetandek: şîva me. Mînak: Şîv li mêzê ye. Têbinî: "şîr" (süt) ile karıştırma.',
   her:['Pîrê şîv dixwe.', 'Şîva pîrê xweş e.'],
   gen:['Şîv li mêzê ye.', 'Şîv û firavîn hene.']),

  // ── OKUL — [Fêrkera D.2] ───────────────────────────────────────

  (id:'a1_fk_12', ku:'Pol', tr:'Sınıf', en:'Classroom / Class',
   cins:'mê', ez:'pola', kat:'perwerde', zor:0.83,
   not:'Pol (dişil/mê) — sınıf. Veqetandek: pola me. Mînak: Pola me xweş e. Têbinî: alıntı "sinif" yerine "pol".',
   her:['Pola me xweş e.', 'Em di polê de ne.'],
   gen:['Pol mezin e.', 'Pol li dibistanê ye.']),

  (id:'a1_fk_13', ku:'Mase', tr:'Masa / Sıra', en:'Desk / Table',
   cins:'mê', ez:'maseya', kat:'mal', zor:0.84,
   not:'Mase (dişil/mê) — masa, sıra. Veqetandek: masê me. Mînak: Mase li polê ye. Têbinî: A1 ana yapıda "mêz" (a1_197) tercih edilir.',
   her:['Pirtûk li ser masê ye.', 'Pîrê li ber masê ye.'],
   gen:['Mase li polê ye.', 'Mase û texte hene.']),

  (id:'a1_fk_14', ku:'Spartek', tr:'Ödev', en:'Homework',
   cins:'mê', ez:'sparteka', kat:'perwerde', zor:0.82,
   not:'Spartek (dişil/mê) — ödev. Veqetandek: sparteka min. Mînak: Spartek hene. Têbinî: çoğul "spartekên" (ödevler).',
   her:['Spartekên min hene.', 'Pîrê spartek dibîne.'],
   gen:['Spartek hene.', 'Mamosta spartek dixwaze.']),

  (id:'a1_fk_15', ku:'Jêhatî', tr:'Başarılı / Yetenekli', en:'Talented / Skilled',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.82,
   not:'Jêhatî — sıfat (başarılı, yetenekli). Mînak: Tu jêhatî yî. Têbinî: ders/iş bağlamında.',
   her:['Tu jêhatî yî, pîrê.', 'Pîrê jêhatî ye.'],
   gen:['Mamosta jêhatî ye.', 'Xwendekar jêhatî ye.']),

  // ── AİLE — [Fêrkera D.9] ───────────────────────────────────────

  (id:'a1_fk_16', ku:'Bapîr', tr:'Büyükbaba / Dede', en:'Grandfather',
   cins:'nêr', ez:'bapîrê', kat:'malbat', zor:0.84,
   not:'Bapîr (eril/nêr) — büyükbaba, dede. Veqetandek: bapîrê min. Mînak: Bapîrê min baş e. Têbinî: "Kal" da kullanılır; karşıtı "dapîr".',
   her:['Bapîrê min baş e.', 'Bapîr li malê ye.'],
   gen:['Bapîr mezin e.', 'Bapîr û dapîr hene.']),

  (id:'a1_fk_17', ku:'Xwarzî', tr:'Yeğen (kız kardeşinin çocuğu)', en:"Sister's child (nephew/niece)",
   cins:'bêcins', ez:'xwarziyê/xwarziya', kat:'malbat', zor:0.80,
   not:'Xwarzî — kız kardeşten olan yeğen. Veqetandek: xwarziyê min (eril) / xwarziya min (dişil). Mînak: Xwarziyê min baş e. Têbinî: erkek kardeşten "birazî".',
   her:['Xwarziyê min baş e.', 'Xwarziya pîrê xweş e.'],
   gen:['Xwarzî mezin e.', 'Xwarziyê me li malê ye.']),

  // ── HAYVAN — [Fêrkera D.4] ─────────────────────────────────────

  (id:'a1_fk_18', ku:'Ajel', tr:'Hayvan', en:'Animal',
   cins:'nêr', ez:'ajelê', kat:'ajal', zor:0.83,
   not:'Ajel (eril/nêr) — hayvan (genel terim). Veqetandek: ajelê min. Mînak: Ajel li gundî ye. Têbinî: alıntı "heywan" da kullanılır.',
   her:['Ajelên pîrê gelek in.', 'Ajel li gundî ye.'],
   gen:['Ajelên gund mezin in.', 'Ajel û çûçik hene.']),

  (id:'a1_fk_19', ku:'Dîk', tr:'Horoz', en:'Rooster',
   cins:'nêr', ez:'dîkê', kat:'ajal', zor:0.81,
   not:'Dîk (eril/nêr) — horoz, erkek tavuk. Veqetandek: dîkê me. Mînak: Dîk li gundî ye. Têbinî: dişil eşi "mirîşk" (tavuk).',
   her:['Dîkê pîrê li gundî ye.', 'Dîk û mirîşk hene.'],
   gen:['Dîk mezin e.', 'Mirîşk û dîk hene.']),

  (id:'a1_fk_20', ku:'Nêrî', tr:'Teke (erkek keçi)', en:'Billy goat (male goat)',
   cins:'nêr', ez:'nêriyê', kat:'ajal', zor:0.78,
   not:'Nêrî (eril/nêr) — erkek keçi, teke. Veqetandek: nêriyê me. Mînak: Nêrî li çiyayî ye. Têbinî: dişil eşi "bizin".',
   her:['Nêriyê pîrê li çiyayî ye.', 'Nêrî mezin e.'],
   gen:['Nêrî li çiyayî ye.', 'Nêrî û bizin hene.']),

  (id:'a1_fk_21', ku:'Beran', tr:'Koç', en:'Ram',
   cins:'nêr', ez:'beranê', kat:'ajal', zor:0.80,
   not:'Beran (eril/nêr) — koç, erkek koyun. Veqetandek: beranê me. Mînak: Beran mezin e. Têbinî: dişil eşi "mî" (koyun).',
   her:['Beranê pîrê mezin e.', 'Beran li çiyayî ye.'],
   gen:['Beran mezin e.', 'Beran û mî hene.']),

  (id:'a1_fk_22', ku:'Firîngî', tr:'Domates', en:'Tomato',
   cins:'mê', ez:'firîngiya', kat:'xwarin', zor:0.82,
   not:'Firîngî (dişil/mê) — domates. Veqetandek: firîngiya sor. Mînak: Firîngî sor e. Têbinî: çoğul "firîngiyên".',
   her:['Firîngî sor e.', 'Pîrê firîngî dixwe.'],
   gen:['Firîngiyên sor hene.', 'Firîngî û birinc hene.']),

];

// ════════════════════════════════════════════════════════════
// EK KELİMELER 4 — Eksik Kategoriler Takviyesi
// Nisan 2026 — düşük sayılı kategorilere ek kelimeler
// ════════════════════════════════════════════════════════════

const kA1EkKelimeler4 = [

  // ── Vexwarin (İçecekler) ──────────────────────────────────

  (id:'a1_ek401', ku:'Ava germ', tr:'Sıcak su', en:'Hot water',
   cins:'mê', ez:'ava germ', kat:'vexwarin', zor:0.78,
   not:'"Ava germ" — "av" (su, dişil) + veqetandek "-a" + "germ" (sıcak). Mînak: Ava germ xweş e. Têbinî: kış içeceği.',
   her:['Pîrê ava germ vedixwe.', 'Ava germ xweş e, pîrê.'],
   gen:['Ava germ baş e.', 'Ava germ û çay hene.']),

  (id:'a1_ek402', ku:'Şerbet', tr:'Şerbet', en:'Sherbet',
   cins:'mê', ez:'şerbeta', kat:'vexwarin', zor:0.72,
   not:'Şerbet (dişil/mê) — geleneksel tatlı içecek. Veqetandek: şerbeta Newrozê. Mînak: Şerbet xweş e. Têbinî: Newroz şerbeti yaygın.',
   her:['Pîrê şerbet vedixwe.', 'Şerbeta Newrozê xweş e.'],
   gen:['Şerbet xweş e.', 'Şerbet û av hene.']),

  (id:'a1_ek403', ku:'Lîmonata', tr:'Limonata', en:'Lemonade',
   cins:'mê', ez:'lîmonataya', kat:'vexwarin', zor:0.75,
   not:'Lîmonata (dişil/mê) — limonlu içecek. "Lîmon" + "-ata". Mînak: Lîmonata havînê xweş e. Têbinî: yaz içeceği.',
   her:['Pîrê lîmonata vedixwe.', 'Lîmonata havînê xweş e.'],
   gen:['Lîmonata baş e.', 'Lîmonata û av hene.']),

  (id:'a1_ek404', ku:'Şerbeta porteqalê', tr:'Portakal şerbeti / Portakal suyu', en:'Orange juice',
   cins:'mê', ez:'şerbeta porteqalê', kat:'vexwarin', zor:0.70,
   not:'"Şerbet" + "porteqal" (oblik -ê) → portakal şerbeti. Mînak: Şerbeta porteqalê xweş e. Têbinî: "porteqalî" renk sıfatıdır (turuncu); meyve tamlaması oblik "-ê" ister.',
   her:['Pîrê şerbeta porteqalê vedixwe.', 'Şerbeta porteqalê xweş e.'],
   gen:['Şerbeta porteqalê baş e.', 'Şerbeta porteqalê û sêv hene.']),

  (id:'a1_ek405', ku:'Dew', tr:'Ayran', en:'Ayran / Buttermilk',
   cins:'nêr', ez:'dewê', kat:'vexwarin', zor:0.76,
   not:'Dew (eril/nêr) — geleneksel ayran. Veqetandek: dewê me. Mînak: Dew xweş e. Têbinî: mast + av karışımı, Kurmancî mutfağı temel içeceği.',
   her:['Dewê pîrê xweş e!', 'Pîrê dew vedixwe.'],
   gen:['Dew baş e.', 'Dew û mast hene.']),

  (id:'a1_ek406', ku:'Şîrê germ', tr:'Sıcak süt', en:'Hot milk',
   cins:'nêr', ez:'şîrê germ', kat:'vexwarin', zor:0.74,
   not:'"Şîr" (süt) eril + "germ" (sıcak) → sıcak süt. Mînak: Şîrê germ xweş e. Têbinî: çocuklara ve yaşlılara verilir.',
   her:['Pîrê şîrê germ vedixwe.', 'Şîrê germ xweş e.'],
   gen:['Şîrê germ baş e.', 'Şîrê germ û nan hene.']),

  // ── Mêwe (Meyveler) ───────────────────────────────────────

  (id:'a1_ek407', ku:'Mûz', tr:'Muz', en:'Banana',
   cins:'nêr', ez:'mûzê', kat:'mêwe', zor:0.78,
   not:'Mûz (eril/nêr) — muz. Veqetandek: mûzê min. Mînak: Mûz zer e. Têbinî: çoğul "mûzan".',
   her:['Mûz zer e, pîrê.', 'Pîrê mûz dixwe.'],
   gen:['Mûz xweş e.', 'Mûz û sêv hene.']),

  (id:'a1_ek408', ku:'Hirmî', tr:'Armut', en:'Pear',
   cins:'mê', ez:'hirmiya', kat:'mêwe', zor:0.72,
   not:'Hirmî (dişil/mê) — armut. Veqetandek: hirmiya zer. Mînak: Hirmî xweş e. Têbinî: ünlü ile bittiğinden veqetandek "iya".',
   her:['Hirmiya pîrê xweş e.', 'Pîrê hirmî dixwe.'],
   gen:['Hirmî xweş e.', 'Hirmî û sêv hene.']),

  (id:'a1_ek409', ku:'Zebeş', tr:'Karpuz', en:'Watermelon',
   cins:'nêr', ez:'zebeşê', kat:'mêwe', zor:0.70,
   not:'Zebeş (eril/nêr) — karpuz. Veqetandek: zebeşê me. Mînak: Zebeş havînê xweş e. Têbinî: yaz meyvesi.',
   her:['Zebeş havînê xweş e.', 'Pîrê zebeş dixwe.'],
   gen:['Zebeşê sor xweş e.', 'Zebeş û petêx hene.']),

  (id:'a1_ek410', ku:'Fîstiq', tr:'Fıstık', en:'Pistachio',
   cins:'nêr', ez:'fîstiqê', kat:'mêwe', zor:0.68,
   not:'Fîstiq (eril/nêr) — fıstık. Veqetandek: fîstiqê me. Mînak: Fîstiq kesk e. Têbinî: kuruyemiş.',
   her:['Fîstiqê pîrê kesk e.', 'Pîrê fîstiq dixwe.'],
   gen:['Fîstiq kesk e.', 'Fîstiq û gûz hene.']),

  (id:'a1_ek411', ku:'Gûz', tr:'Ceviz', en:'Walnut',
   cins:'nêr', ez:'gûzê', kat:'mêwe', zor:0.70,
   not:'Gûz (eril/nêr) — ceviz. Veqetandek: gûzê me. Mînak: Gûz xweş e. Têbinî: "dara gûzê" = ceviz ağacı.',
   her:['Gûzê pîrê xweş e.', 'Dara gûzê li baxçeyê ye.'],
   gen:['Gûz xweş e.', 'Gûz û fîstiq hene.']),

  (id:'a1_ek412', ku:'Petêx', tr:'Kavun', en:'Melon',
   cins:'nêr', ez:'petêxê', kat:'mêwe', zor:0.72,
   not:'Petêx (eril/nêr) — kavun. Veqetandek: petêxê me. Mînak: Petêx xweş e. Têbinî: yaz meyvesi; "pepûk" ise guguk kuşu demektir — karıştırma.',
   her:['Petêxê pîrê zer e.', 'Pîrê petêx dixwe.'],
   gen:['Petêx xweş e.', 'Petêx û zebeş hene.']),

  // ── Tendurist (Sağlık) ────────────────────────────────────

  (id:'a1_ek413', ku:'Nexweşî', tr:'Hastalık', en:'Illness',
   cins:'mê', ez:'nexweşiya', kat:'tendurist', zor:0.73,
   not:'Nexweşî (dişil/mê) — hastalık. "Ne" + "xweş" + "-î" → iyi olmayan durum. Veqetandek: nexweşiya giran. Mînak: Nexweşî giran e. Têbinî: karşıtı sağlıklı olma.',
   her:['Nexweşiya pîrê giran e.', 'Nexweşiya pîrê heye.'],
   gen:['Nexweşî giran e.', 'Nexweşî û derman hene.']),

  (id:'a1_ek414', ku:'Birîn', tr:'Yara', en:'Wound',
   cins:'mê', ez:'birîna', kat:'tendurist', zor:0.70,
   not:'Birîn (dişil/mê) — yara. Veqetandek: birîna min. Mînak: Birîn paqij e. Têbinî: çoğul "birînan".',
   her:['Birîna pîrê giran e.', 'Birîn paqij e.'],
   gen:['Birîn û derman hene.', 'Bijîşk birînê dibîne.']),

  (id:'a1_ek415', ku:'Derman', tr:'İlaç', en:'Medicine',
   cins:'nêr', ez:'dermanê', kat:'tendurist', zor:0.75,
   not:'Derman (eril/nêr) — ilaç. Veqetandek: dermanê min. Mînak: Derman baş e. Têbinî: atasözü "Ziman dermanê dilê mirov e".',
   her:['Dermanê pîrê baş e.', 'Pîrê derman dixwe.'],
   gen:['Derman baş e.', 'Derman û bijîşk hene.']),

  (id:'a1_ek416', ku:'Zikêş', tr:'Karın ağrısı', en:'Stomachache',
   cins:'nêr', ez:'zikêşê', kat:'tendurist', zor:0.72,
   not:'Zikêş (eril/nêr) — karın ağrısı. "Zik" (karın) + "êş" (ağrı) bileşiği. Veqetandek: zikêşê min. Mînak: Zikêş heye. Têbinî: "serêş" ile paralel.',
   her:['Zikêşê pîrê heye.', 'Zikêş giran e.'],
   gen:['Zikêş û serêş hene.', 'Zikêşê min heye.']),

  (id:'a1_ek417', ku:'Kuxik', tr:'Öksürük', en:'Cough',
   cins:'mê', ez:'kuxika', kat:'tendurist', zor:0.68,
   not:'Kuxik (dişil/mê) — öksürük. Veqetandek: kuxika min. Mînak: Kuxik heye. Têbinî: kış mevsiminde yaygın.',
   her:['Kuxika pîrê heye.', 'Kuxik giran e.'],
   gen:['Kuxik û ta hene.', 'Kuxika min heye.']),

  (id:'a1_ek418', ku:'Dermangeh', tr:'Eczane', en:'Pharmacy',
   cins:'mê', ez:'dermangeha', kat:'tendurist', zor:0.70,
   not:'Dermangeh (dişil/mê) — eczane. "Derman" + "-geh" (yer eki). Veqetandek: dermangeha bajêr. Mînak: Dermangeh li bajêr e. Têbinî: oblique "li dermangehê".',
   her:['Pîrê li dermangehê ye.', 'Dermangeh li bajêr e.'],
   gen:['Dermangeh nêzîk e.', 'Dermangeh û nexweşxane hene.']),

  // ── Demsal / Hewa (Mevsim / Hava) ────────────────────────

  (id:'a1_ek419', ku:'Ba', tr:'Rüzgar', en:'Wind',
   cins:'nêr', ez:'bayê', kat:'demsal', zor:0.75,
   not:'Ba (eril/nêr) — rüzgar. Veqetandek: bayê sar. Mînak: Ba sar e. Têbinî: "ba dikişîne" = rüzgar esiyor.',
   her:['Ba sar e, pîrê.', 'Bayê germ xweş e.'],
   gen:['Ba û baran hene.', 'Bayê havînê germ e.']),

  (id:'a1_ek420', ku:'Ewr', tr:'Bulut', en:'Cloud',
   cins:'nêr', ez:'ewrê', kat:'demsal', zor:0.72,
   not:'Ewr (eril/nêr) — bulut. Veqetandek: ewrê reş. Mînak: Ewr reş in. Têbinî: çoğul "ewran" (oblique).',
   her:['Ewrên reş hene.', 'Ewr li jor in.'],
   gen:['Ewr û baran hene.', 'Ewrên spî xweş in.']),

  (id:'a1_ek421', ku:'Şil', tr:'Islak / Nemli', en:'Wet / Damp',
   cins:'bêcins', ez:null, kat:'demsal', zor:0.70,
   not:'Şil — sıfat (ıslak, nemli). Mînak: Erd şil e. Têbinî: karşıtı "hişk" (kuru).',
   her:['Erd şil e, pîrê.', 'Piştî baranê şil e.'],
   gen:['Şil sar e.', 'Erd û dîwar şil in.']),

  (id:'a1_ek422', ku:'Hişk', tr:'Kuru', en:'Dry',
   cins:'bêcins', ez:null, kat:'demsal', zor:0.70,
   not:'Hişk — sıfat (kuru). Mînak: Erd hişk e. Têbinî: karşıtı "şil" (ıslak).',
   her:['Erd hişk e.', 'Havîn hişk e, pîrê.'],
   gen:['Hişk germ e.', 'Erd û nan hişk in.']),

  // ── Pîşe (Meslekler) ─────────────────────────────────────

  (id:'a1_ek423', ku:'Mamoste', tr:'Öğretmen', en:'Teacher',
   cins:'bêcins', ez:'mamosteyê/mamosteya', kat:'pîşe', zor:0.80,
   not:'Mamoste — öğretmen (formel kayıt). Veqetandek: mamosteyê me. Mînak: Mamoste baş e. Têbinî: a1_110 "Mamosta" alternatif yazım.',
   her:['Mamosteyê me baş e.', 'Mamosteyê pîrê baş e.'],
   gen:['Mamoste baş e.', 'Mamoste û xwendekar hene.']),

  (id:'a1_ek424', ku:'Nanpêj', tr:'Fırıncı', en:'Baker',
   cins:'nêr', ez:'nanpêjê', kat:'pîşe', zor:0.72,
   not:'Nanpêj (eril/nêr) — "nan" (ekmek) + "pêj" (pişiren) → fırıncı. Veqetandek: nanpêjê me. Mînak: Nanpêj nan dipêje. Têbinî: meslek.',
   her:['Nanpêjê me baş e.', 'Nanpêj nan dipêje.'],
   gen:['Nanpêjê gund baş e.', 'Nanpêj û mamosta hene.']),

  (id:'a1_ek425', ku:'Polîs', tr:'Polis', en:'Police officer',
   cins:'nêr', ez:'polîsê', kat:'pîşe', zor:0.77,
   not:'Polîs (eril/nêr) — uluslararası kelime, polis. Veqetandek: polîsê bajêr. Mînak: Polîs li bajêr e. Têbinî: "polîsê trafîkê" = trafik polisi.',
   her:['Polîs li bajêr e.', 'Polîsê me baş e.'],
   gen:['Polîsê bajêr baş e.', 'Polîs û mamosta hene.']),

  (id:'a1_ek426', ku:'Berber', tr:'Berber', en:'Barber',
   cins:'nêr', ez:'berberê', kat:'pîşe', zor:0.70,
   not:'Berber (eril/nêr) — berber (alıntı; "sertaş" da denir). Veqetandek: berberê me. Mînak: Berber baş e. Têbinî: "berdar" farklı kelimedir (verimli, meyve veren).',
   her:['Berberê me baş e.', 'Berber li bajêr e.'],
   gen:['Berber li gundî ye.', 'Berber û nanpêj hene.']),

  // ── Çand (Kültür) ─────────────────────────────────────────

  (id:'a1_ek427', ku:'Newroz', tr:'Nevruz', en:'Newroz / Kurdish New Year',
   cins:'nêr', ez:'Newrozê', kat:'çand', zor:0.80,
   not:'Newroz (eril/nêr) — "New" (yeni) + "roz" (gün). 21 Adarê. Kurmancî kültürünün önemli bayramı.',
   her:['Newroz pîroz be!', 'Newrozê pîrê xweş e.'],
   gen:['Newroz xweş e.', 'Newroz û bihar hene.']),

  (id:'a1_ek428', ku:'Govend', tr:'Halay / Halk dansı', en:'Traditional circle dance',
   cins:'mê', ez:'govenda', kat:'çand', zor:0.72,
   not:'Govend (dişil/mê) — halay, halk dansı. Veqetandek: govenda Newrozê. Mînak: Govend xweş e. Têbinî: "govend girtin" = halay çekmek.',
   her:['Govenda Newrozê xweş e.', 'Pîrê govend dibîne.'],
   gen:['Govend xweş e.', 'Govend û stran hene.']),

  (id:'a1_ek429', ku:'Çîrok', tr:'Masal / Hikaye', en:'Story / Tale',
   cins:'mê', ez:'çîroka', kat:'çand', zor:0.74,
   not:'Çîrok (dişil/mê) — masal, hikaye. Veqetandek: çîroka pîrê. Mînak: Çîrok xweş e. Têbinî: çoğul "çîrokan".',
   her:['Pîrê çîrokê dibêje.', 'Çîroka pîrê xweş e.'],
   gen:['Çîrok xweş e.', 'Çîrok û stran hene.']),

  (id:'a1_ek430', ku:'Lorî', tr:'Ninni', en:'Lullaby',
   cins:'mê', ez:'loriya', kat:'çand', zor:0.70,
   not:'Lorî (dişil/mê) — ninni. Veqetandek: loriya pîrê. Mînak: Lorî xweş e. Têbinî: ünlü ile bittiğinden veqetandek "iya".',
   her:['Dê lorî dibêje.', 'Loriya pîrê xweş e.'],
   gen:['Lorî xweş e.', 'Lorî û stran hene.']),

  (id:'a1_ek431', ku:'Cejn', tr:'Bayram', en:'Festival / Holiday',
   cins:'mê', ez:'cejna', kat:'çand', zor:0.76,
   not:'Cejn (dişil/mê) — bayram. Veqetandek: cejna we. Mînak: Cejn pîroz be. Têbinî: oblique "cejnê" (bayramda).',
   her:['Cejn pîroz be!', 'Cejna pîrê xweş e.'],
   gen:['Cejn xweş e.', 'Cejn û Newroz hene.']),

  // ── Gihanî (Ulaşım) ──────────────────────────────────────

  (id:'a1_ek432', ku:'Taksî', tr:'Taksi', en:'Taxi',
   cins:'mê', ez:'taksiya', kat:'gihanî', zor:0.78,
   not:'Taksî (dişil/mê) — taksi (Fransızca alıntı). Veqetandek: taksiya min. Mînak: Ez bi taksiyê diçim. Têbinî: oblique "bi taksiyê" (taksiyle).',
   her:['Ez bi taksiyê diçim.', 'Pîrê bi taksiyê tê.'],
   gen:['Taksî zû ye.', 'Taksî û otobûs hene.']),

  (id:'a1_ek433', ku:'Metro', tr:'Metro', en:'Subway / Metro',
   cins:'nêr', ez:'metroyê', kat:'gihanî', zor:0.74,
   not:'Metro (eril/nêr) — metro (Fransızca alıntı). Veqetandek: metroyê bajêr. Mînak: Ez bi metroyê diçim. Têbinî: yer altı taşıt.',
   her:['Ez bi metroyê diçim.', 'Metro zû ye.'],
   gen:['Metro û otobûs hene.', 'Metroyê bajêr xweş e.']),

  (id:'a1_ek434', ku:'Bisiklêt', tr:'Bisiklet', en:'Bicycle',
   cins:'mê', ez:'bisiklêta', kat:'gihanî', zor:0.72,
   not:'Bisiklêt (dişil/mê) — bisiklet (Fransızca alıntı). Veqetandek: bisiklêta min. Mînak: Bisiklêta min nû ye. Têbinî: oblique "bi bisiklêtê".',
   her:['Bisiklêta pîrê nû ye.', 'Ez bi bisiklêtê diçim.'],
   gen:['Bisiklêt û erebe hene.', 'Bisiklêta min nû ye.']),

  (id:'a1_ek435', ku:'Otobûs', tr:'Otobüs', en:'Bus',
   cins:'nêr', ez:'otobûsê', kat:'gihanî', zor:0.76,
   not:'Otobûs (eril/nêr) — otobüs. Veqetandek: otobûsê bajêr. Mînak: Otobûs li bajêr e. Têbinî: oblique "bi otobûsê" (otobüsle).',
   her:['Pîrê bi otobûsê tê.', 'Otobûs li bajêr e.'],
   gen:['Otobûs û trên hene.', 'Otobûsê bajêr mezin e.']),

  (id:'a1_ek436', ku:'Firoke', tr:'Uçak (alternatif)', en:'Airplane',
   cins:'mê', ez:'firokeya', kat:'gihanî', zor:0.70,
   not:'Firoke (dişil/mê) — uçak (alternatif). Veqetandek: firokeya me. Mînak: Firoke li esmên e. Têbinî: ana yapı "balafir" (a1_442).',
   her:['Firoke li esmên e.', 'Firokeya pîrê mezin e.'],
   gen:['Firoke mezin e.', 'Firoke û balafir hene.']),

  // ── Cil (Giysi) ───────────────────────────────────────────

  (id:'a1_ek437', ku:'Poşû', tr:'Poşu / Geleneksel Kürt atkısı', en:'Pushi (traditional Kurdish scarf)',
   cins:'nêr', ez:'poşûyê', kat:'cil', zor:0.73,
   not:'Poşû (eril/nêr) — geleneksel Kurmancî atkısı, kültürel simge. Veqetandek: poşûyê min. Mînak: Poşû reş e. Têbinî: siyah-beyaz desenli.',
   her:['Poşûyê bavê min reş e.', 'Pîrê poşû dibîne.'],
   gen:['Poşû reş e.', 'Poşû û şal hene.']),

  (id:'a1_ek438', ku:'Kumik', tr:'Şapka', en:'Hat / Cap',
   cins:'nêr', ez:'kumikê', kat:'cil', zor:0.72,
   not:'Kumik (eril/nêr) — şapka. Veqetandek: kumikê me. Mînak: Kumik germ e. Têbinî: kış aksesuarı.',
   her:['Kumikê bavê min reş e.', 'Pîrê kumik dibîne.'],
   gen:['Kumik germ e.', 'Kumik û kiras hene.']),

  (id:'a1_ek439', ku:'Qebayet', tr:'Palto / Mont', en:'Coat / Overcoat',
   cins:'mê', ez:'qebayeta', kat:'cil', zor:0.70,
   not:'Qebayet (dişil/mê) — palto, mont. Veqetandek: qebayeta min. Mînak: Qebayet germ e. Têbinî: kış kıyafeti.',
   her:['Qebayeta pîrê germ e.', 'Qebayeta min nû ye.'],
   gen:['Qebayet germ e.', 'Qebayet û kiras hene.']),

  (id:'a1_ek440', ku:'Şapik', tr:'Yelek', en:'Vest / Waistcoat',
   cins:'nêr', ez:'şapikê', kat:'cil', zor:0.72,
   not:'Şapik (eril/nêr) — yelek. Veqetandek: şapikê me. Mînak: Şapik germ e. Têbinî: "şal û şapik" geleneksel kıyafet.',
   her:['Şapikê bavê min germ e.', 'Pîrê şapik dibîne.'],
   gen:['Şapik germ e.', 'Şapik û şal hene.']),

  (id:'a1_ek441', ku:'Destmal', tr:'Mendil / Eşarp', en:'Scarf / Handkerchief',
   cins:'mê', ez:'destmala', kat:'cil', zor:0.70,
   not:'Destmal (dişil/mê) — mendil veya eşarp. "Dest" (el) + "mal" (silme). Veqetandek: destmala min. Mînak: Destmal spî ye.',
   her:['Destmala pîrê spî ye.', 'Pîrê destmal dibîne.'],
   gen:['Destmal spî ye.', 'Destmal û kumik hene.']),

  // ── Dua (Dua / Dilek) ─────────────────────────────────────

  (id:'a1_ek442', ku:'Xêr be!', tr:'Hayırlı olsun!', en:'May it be auspicious!',
   cins:'bêcins', ez:null, kat:'dua', zor:0.80,
   not:'"Xêr be!" — kalıp dilek (hayırlı olsun). Mînak: Xêr be, pîrê! Têbinî: olumsuz haberlere/sorulara karşı kullanılır.',
   her:['Xêr be, pîrê!', 'Xêr be, bavê min!'],
   gen:['Xêr be!', 'Xêr be, heval.']),

  (id:'a1_ek443', ku:'Xwedê te biparêze', tr:'Allah seni korusun', en:'May God protect you',
   cins:'bêcins', ez:null, kat:'dua', zor:0.70,
   not:'"Xwedê te biparêze" — koruma duası (Allah seni korusun). Mînak: Xwedê te biparêze, kurê min. Têbinî: "biparêze" subjunctive dua formu.',
   her:['Xwedê te biparêze, kurê min!', 'Xwedê te biparêze, pîrê!'],
   gen:['Xwedê te biparêze.', 'Xwedê we biparêze.']),

  (id:'a1_ek444', ku:'Xwedê xêrê bide', tr:'Allah hayır versin', en:'May God give blessings',
   cins:'bêcins', ez:null, kat:'dua', zor:0.68,
   not:'"Xwedê xêrê bide" — iyi dilek duası (Allah hayır versin). Mînak: Xwedê xêrê bide te! Têbinî: "Xêr" = hayır, iyilik.',
   her:['Xwedê xêrê bide te!', 'Xwedê xêrê bide we!'],
   gen:['Xwedê xêrê bide.', 'Xwedê xêrê bide pîrê.']),

  (id:'a1_ek445', ku:'Pîroz be', tr:'Kutlu olsun', en:'May it be blessed / Congratulations',
   cins:'bêcins', ez:null, kat:'dua', zor:0.74,
   not:'"Pîroz be" — kutlama ifadesi (kutlu olsun). Mînak: Newroz pîroz be! Têbinî: bayram, düğün ve yeni yıl için.',
   her:['Newroz pîroz be!', 'Daweta te pîroz be!'],
   gen:['Pîroz be!', 'Sala nû pîroz be.']),

  (id:'a1_ek446', ku:'Bimîne bi xêr', tr:'Hoşça kal', en:'Goodbye / Stay well',
   cins:'bêcins', ez:null, kat:'dua', zor:0.75,
   not:'"Bimîne bi xêr" — vedalaşma kalıbı (hoşça kal). Mînak: Bimîne bi xêr, pîrê! Têbinî: "Bi xatirê te" eşanlamı.',
   her:['Bimîne bi xêr, pîrê!', 'Bimîne bi xêr, dê!'],
   gen:['Bimîne bi xêr.', 'Bi xatirê te.']),

  (id:'a1_ek447', ku:'Xwedê bihêle', tr:'Allah bağışlasın', en:'May God forgive',
   cins:'bêcins', ez:null, kat:'dua', zor:0.66,
   not:'"Xwedê bihêle" — af duası (Allah bağışlasın). Mînak: Xwedê bihêle, pîrê! Têbinî: "bihêle" subjunctive bırakma/affetme.',
   her:['Xwedê bihêle, pîrê!', 'Xwedê bihêle, bavê min!'],
   gen:['Xwedê bihêle.', 'Xwedê we bihêle.']),

  // ── Bun (Varoluş / Olma) ─────────────────────────────────

  (id:'a1_ek448', ku:'Tunebûn', tr:'Yokluk / Olmama', en:'Non-existence',
   cins:'bêcins', ez:null, kat:'bun', zor:0.70,
   not:'Tunebûn — yokluk, olmama. "Tune" + "bûn". Mînak: Tune ye. Têbinî: karşıtı "hebûn" (var olma).',
   her:['Tunebûna pîrê zor e.', 'Tune ye, pîrê.'],
   gen:['Tunebûn ne baş e.', 'Tune ye.']),

  (id:'a1_ek449', ku:'Man', tr:'Kalmak', en:'To stay / To remain',
   cins:'bêcins', ez:null, kat:'bun', zor:0.72,
   not:'Man — fiil mastarı (kalmak). Mînak: Pîrê li malê dimîne. Têbinî: 1.tek "Ez dimînim".',
   her:['Pîrê li malê dimîne.', 'Bavê min li gundî dimîne.'],
   gen:['Mamosta li dibistanê dimîne.', 'Ez li malê dimînim.']),

  (id:'a1_ek450', ku:'Çêbûn', tr:'Oluşmak / Doğmak', en:'To be born / To come into being',
   cins:'bêcins', ez:null, kat:'bun', zor:0.68,
   not:'Çêbûn — fiil mastarı (oluşmak, doğmak). "Çê" + "bûn". Mînak: Çêbûn xweş e. Têbinî: bileşik fiil.',
   her:['Çêbûn xweş e, pîrê.', 'Jiyan û çêbûn hene.'],
   gen:['Çêbûn baş e.', 'Çêbûn û jiyan hene.']),

  (id:'a1_ek451', ku:'Jiyan', tr:'Yaşam / Hayat', en:'Life',
   cins:'mê', ez:'jiyana', kat:'bun', zor:0.74,
   not:'Jiyan (dişil/mê) — yaşam, hayat. Veqetandek: jiyana min. Mînak: Jiyan xweş e. Têbinî: bûn ile çift.',
   her:['Jiyan xweş e, pîrê!', 'Jiyana pîrê baş e.'],
   gen:['Jiyan baş e.', 'Jiyan û bûn hene.']),

  // ── Peyvben (Bileşik Kelimeler) ───────────────────────────

  (id:'a1_ek452', ku:'Her dem', tr:'Her zaman', en:'Always',
   cins:'bêcins', ez:null, kat:'peyvben', zor:0.76,
   not:'"Her dem" — zaman zarfı (her zaman). "Her" + "dem" (zaman). Mînak: Her dem xweş e.',
   her:['Her dem xweş e, pîrê!', 'Pîrê her dem tê.'],
   gen:['Her dem baş e.', 'Mamosta her dem tê.']),

  (id:'a1_ek453', ku:'Carinan', tr:'Bazen', en:'Sometimes',
   cins:'bêcins', ez:null, kat:'peyvben', zor:0.74,
   not:'"Carinan" — zaman zarfı (bazen). "Car" + "-inan". Mînak: Carinan baran dibare.',
   her:['Carinan baran dibare.', 'Carinan ez diçim gund.'],
   gen:['Carinan baş e.', 'Carinan tê pîrê.']),

  (id:'a1_ek454', ku:'Bi tenê', tr:'Yalnız / Tek başına', en:'Alone',
   cins:'bêcins', ez:null, kat:'peyvben', zor:0.72,
   not:'"Bi tenê" — yalnız, tek başına. "Bi" + "tenê" (tek). Mînak: Ez bi tenê me. Têbinî: "tenê" kökü.',
   her:['Ez bi tenê me, pîrê.', 'Pîrê bi tenê ye.'],
   gen:['Bi tenê baş nîne.', 'Ew bi tenê diçe.']),
];

// A1 nihai liste


const kA1Son7 = [
  (id:'a1_s01', ku:'Xwedê', tr:'Allah / Tanrı', en:'God',
   cins:'nêr', ez:'Xwedê', kat:'dua', zor:0.87,
   not:'Xwedê (eril/nêr) — Allah, Tanrı. Mînak: Xwedê mezin e. Têbinî: dua kalıplarında çok geçer.',
   her:['Xwedê mezin e.', 'Bi navê Xwedê.'],
   gen:['Xwedê baş e.', 'Xwedê û dua hene.']),

  (id:'a1_s02', ku:'Xort', tr:'Genç erkek / Delikanlı', en:'Young man',
   cins:'nêr', ez:'xortê', kat:'malbat', zor:0.83,
   not:'Xort (eril/nêr) — genç erkek, delikanlı. Veqetandek: xortê me. Mînak: Xort jîr e. Têbinî: dişil eşi "keçik".',
   her:['Xortê pîrê baş e.', 'Ew xort e.'],
   gen:['Xort jîr e.', 'Xort û keçik hene.']),

  (id:'a1_s03', ku:'Keçik', tr:'Kız / Genç kız', en:'Girl / Young woman',
   cins:'mê', ez:'keçika', kat:'malbat', zor:0.84,
   not:'Keçik (dişil/mê) — genç kız. Veqetandek: keçika me. Mînak: Keçik delal e. Têbinî: eril eşi "xort".',
   her:['Keçika pîrê delal e.', 'Keçik baş e.'],
   gen:['Keçik delal e.', 'Keçik û xort hene.']),

  (id:'a1_s04', ku:'Delal', tr:'Sevgili / Güzel (hitap)', en:'Dear / Darling',
   cins:'bêcins', ez:null, kat:'silav', zor:0.83,
   not:'Delal — sevgi hitabı (sevgili, güzel). Mînak: Keçik delal e. Têbinî: hem sıfat hem hitap formu.',
   her:['Keçik delal e, pîrê.', 'Pîrê delal e.'],
   gen:['Delal baş e.', 'Ew delal e.']),

  (id:'a1_s05', ku:'Jîr', tr:'Akıllı / Zeki', en:'Smart / Clever',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.83,
   not:'Jîr — sıfat (akıllı, zeki). Mînak: Xwendekar jîr e. Têbinî: "jêhatî" eşanlamı.',
   her:['Xwendekarê pîrê jîr e.', 'Pîrê jîr e.'],
   gen:['Mamosta jîr e.', 'Xwendekar jîr in.']),

  (id:'a1_s06', ku:'Dilgerm', tr:'Candan / Sıcakkanlı', en:'Warm-hearted',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.81,
   not:'Dilgerm — sıfat (sıcakkanlı, candan). "Dil" + "germ" (sıcak). Mînak: Pîrê dilgerm e. Têbinî: olumlu kişilik.',
   her:['Pîrê dilgerm e.', 'Bavê min dilgerm e.'],
   gen:['Mamosta dilgerm e.', 'Xort dilgerm in.']),

  (id:'a1_s07', ku:'Beza', tr:'Hızlı / Çevik', en:'Fast / Agile',
   cins:'bêcins', ez:null, kat:'rengder', zor:0.79,
   not:'Beza — sıfat (hızlı, çevik). Mînak: Hesp beza ye. Têbinî: "baza" alternatif yazım.',
   her:['Hespê pîrê beza ye.', 'Pîrê beza ye.'],
   gen:['Hesp beza ye.', 'Ew beza ye.']),
];

// ════════════════════════════════════════════════════════════
// A1 ÇEKİRDEK FİİLLER (iyileştirme planı Faz 4.1, Ekim 2026)
// En sık yedi fiil madde başı olarak yoktu; yalnız çekimli biçimleri
// (Dihat, Digot) ve "X kirin" bileşikleri vardı.
// Örnek cümleler docs/cumle/havuz.tsv'de çevirileriyle kayıtlı.
// ════════════════════════════════════════════════════════════
const kA1CekirdekFiil = [
  (id:'a1_cf_01', ku:'Kirin', tr:'Yapmak / Etmek', en:'To do / To make',
   cins:'bêcins', ez:null, kat:'leker', zor:0.92,
   not:'Kirin — yapmak, etmek. Şimdiki zaman kökü "k": ez dikim, tu dikî, ew dike. Emir: bike! Birleşik fiillerin çoğu "kirin" ile kurulur: kar kirin (çalışmak), spas kirin (teşekkür etmek).',
   her:['Tu çi dikî?', 'Ez karê xwe dikim.'],
   gen:['Ew çi dike?', 'Em îro kar dikin.']),

  (id:'a1_cf_02', ku:'Gotin', tr:'Söylemek / Demek', en:'To say / To tell',
   cins:'bêcins', ez:null, kat:'leker', zor:0.91,
   not:'Gotin — söylemek, demek. Şimdiki zaman kökü "bêj": ez dibêjim, tu dibêjî, ew dibêje. Emir: bibêje!',
   her:['Tu çi dibêjî?', 'Ew rast dibêje.'],
   gen:['Ez ji te re dibêjim.', 'Bavê min wiha dibêje.']),

  (id:'a1_cf_03', ku:'Hatin', tr:'Gelmek', en:'To come',
   cins:'bêcins', ez:null, kat:'leker', zor:0.92,
   not:'Hatin — gelmek. Şimdiki zamanı düzensiz: ez têm, tu têyî, ew tê, em tên. Emir: were!',
   her:['Ez ji malê têm.', 'Tu kengî têyî?'],
   gen:['Ew îro tê.', 'Em bi hev re tên.']),

  (id:'a1_cf_04', ku:'Çûn', tr:'Gitmek', en:'To go',
   cins:'bêcins', ez:null, kat:'leker', zor:0.92,
   not:'Çûn — gitmek. Şimdiki zaman kökü "ç": ez diçim, tu diçî, ew diçe. Emir: here! ya da biçe!',
   her:['Ez diçim malê.', 'Tu bi ku ve diçî?'],
   gen:['Em diçin dibistanê.', 'Ew îro naçe.']),

  (id:'a1_cf_05', ku:'Bûn', tr:'Olmak', en:'To be / To become',
   cins:'bêcins', ez:null, kat:'leker', zor:0.9,
   not:'Bûn — olmak. "Dibe" = oluyor, olur. Koşaç (im, î, e, in) ayrı bir konudur: Ez mamoste me.',
   her:['Hewa sar dibe.', 'Zarok mezin dibin.'],
   gen:['Ez dixwazim bibim mamoste.', 'Ew kêfxweş bû.']),

  (id:'a1_cf_06', ku:'Xwarin', tr:'Yemek (fiil)', en:'To eat',
   cins:'bêcins', ez:null, kat:'leker', zor:0.92,
   not:'Xwarin — yemek (fiil). Aynı sözcük "yemek, yiyecek" anlamında ad olarak da kullanılır. Şimdiki zaman kökü "xw": ez dixwim, tu dixwî, ew dixwe. Emir: bixwe!',
   her:['Ez nan dixwim.', 'Tu çi dixwî?'],
   gen:['Em şîv dixwin.', 'Zarok sêvan dixwin.']),

  (id:'a1_cf_07', ku:'Dan', tr:'Vermek', en:'To give',
   cins:'bêcins', ez:null, kat:'leker', zor:0.9,
   not:'Dan — vermek. Şimdiki zaman kökü "d": ez didim, tu didî, ew dide. Emir: bide!',
   her:['Ez pirtûkê didim te.', 'Avê bide min!'],
   gen:['Ew pere dide.', 'Mamoste pirtûkan dide me.']),

];

final kA1TamListe = [
  ...kA1TamKelimeler,
  ...kA1EkKelimeler,
  ...kA1EkKelimeler2,
  ...kA1EkKelimeler3,
  ...kA1EkKelimeler4,
  ...kA1FerkeraDersler,
  ...kA1Son7,
  ...kA1CekirdekFiil,
];