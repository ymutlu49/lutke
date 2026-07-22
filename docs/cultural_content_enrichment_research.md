# LÛTKE — Çand (Kürt Kültürü) Sayfası Zenginleştirme Araştırması

**Tarih:** 2026-04-25
**Kapsam:** `lib/features/cultural_content/` — yalnızca Kurmancî tarafındaki Çand
sekmesi ve alt kategorileri.
**Hedef:** İçerik miktarı ve niteliği yönünden kapsamlı zenginleştirme planı —
tümü Bedirxan-Hawar standartlarında, doğru imla ve dilbilgisiyle.

---

## 1. Mevcut Envanter (Durum Tespiti)

### Çand sekmesi alt başlıkları ve item sayıları

| Alt başlık | Mevcut item | Doluluk |
|---|---:|---|
| **Gotinên Pêşiyan** (atasözü) | 3,363 | ✅ Doygun, **ama %87 TR çevirisi yok (2,917 madde)** |
| **Destan û Efsane** | 15 | ⚠️ İyi temel, genişletilebilir |
| **Stranbêj** (türkücü) | 20 | ✅ Kapsamlı |
| **Helbestvan** (şair) | 12 | ⚠️ Soranî/modern şairler eksik |
| **Nivîskar** (yazar) | 10 | ⚠️ Modern roman/öykü yazarları eksik |
| **Kesayetên Dîrokî** | 10 | ⚠️ 19./20. yy figürleri kısmî |
| **Helbest** (örnek metin) | 5 | ❌ Çok az — klasik şairlerden seçkiler eksik |
| **Stran** (şarkı metni) | 2 | ❌ Çok az |
| **Xwarinên Kurdî** | 2 | ❌ Neredeyse yok |
| **Cejn** (bayram/festival) | 0 | ❌ Kategori kapatılmış (`celebration` enum kaldırıldı) |
| **Govend & Cil û Berg** | 0 | ❌ Yeni kategori — yok |
| **Bûyerên Dîrokî** (olaylar) | 0 | ❌ Kişiler var, olaylar yok |
| **Mîmariya Kurdî** | 0 | ❌ Yeni kategori — yok |

**Toplam content item:** 3,446 (büyük çoğunluğu atasözü).
**Atasözü dışı içerik:** sadece 83 item — bu sayı bir dil öğrenme platformu için
düşük. İlgili analoglar: Duolingo Stories, Glossika culture cards genellikle
düzey başına 50+ item içerir.

### Mevcut içeriğin biçim kalitesi (örnek)

Her item şu yapıyı takip ediyor (kaliteli):
- `kurmanjTitle` + `turkishTitle`
- Çok paragraflı `kurmanjContent` (biyografi/hikâye/açıklama)
- Çok paragraflı `turkishContent` (paralel çeviri)
- `backgroundNote` (kültürel bağlam)
- `level` (1-4) ve `unitId` (ders bağlantısı)
- `keywords` (arama)

---

## 2. Kapsam Boşlukları (Gap Analysis)

### A. Atasözü Türkçe çeviri eksikliği — ⭐ YÜKSEK ÖNCELİK
3,363 atasözünden yalnızca **446'sının (=%13) Türkçe açıklaması** var. Heritage
öğrenciler için atasözünün anlamını anlamak kritik bir motivasyon noktası.

**Öneri:** Aşamalı olarak 2,917 atasözünün TR açıklamalarını eklemek.

### B. Destan boşlukları
Mevcut 15 destan iyi bir başlangıç ama Kürt sözel edebiyatının zenginliği şunları
dahil eder:

| Eklenmesi gereken destan | Önemi | Kaynak |
|---|---|---|
| **Dewrêşê Evdî û Edûle** | Botan-Cizîrî klasik aşk destanı | Ordîxanê Celîl arşivi |
| **Cembelîyê Hekarî** | Hekarî bölgesi epik | Lescot 1942 |
| **Ferxendê** | Kadın baş kahramanlı destan | Heciyê Cindî kaydı |
| **Hesso & Hassan (kardeş efsanesi)** | Kardeş ihaneti/affı | Sözel gelenek |
| **Bûka Baranê** (yağmur duası) | Ritüel çocuk şiiri-efsane | Halk inancı |
| **Ker û Kûlik** | Komik halk hikâyesi | Mela Mehmûdê Beyazîdî |
| **Şex Sennayî/Senan** | Sufî aşk efsanesi | Feqiyê Teyran "Şêxê Senan" |
| **Xanê Çengzêrîn** (Altın elli han) | Mucize-iyilik efsanesi | Botan halk anlatısı |
| **Êwra û Eyşan** | Yezidî kökenli aşk efsanesi | Şingal kayıtları |
| **Lawkê Metînî** | Dağ dengbêj destanı | Metînî dengbêjlik |

### C. Stranbêj boşlukları (Kürt müziği — modern + bölgesel)
Mevcut 20 isim güçlü ama eksikler:

- **Reşîdê Baso** (1900-1973) — Serhed dengbêj geleneği
- **Hozan Mizgîn** (j.d. 1965) — modern kadın stranbêj
- **Hozan Dîno** — Avrupa diaspora stranbêj
- **Beytocan** (j.d. 1962) — Botanî dengbêj
- **Diyar Dersim** (j.d. 1966) — Kürt-Alevî sentezi
- **Marûf Berzincî** (Soranî) — Başûr klasik
- **Süleyman Yıldız** — Serhed klasik dengbêj
- **Kemalê Amedî** — Diyarbekir dengbêj
- **Hêvîdar** (j.d. 1980) — modern kadın stranbêj
- **Kawa Akkaya** — diaspora stran
- **Diljen Roni** — modern kadın
- **Salar Aghili** — Soranî klasik
- **Aram Dîkran** — Botanî klasik

### D. Helbestvan boşlukları
Mevcut 12 şair sağlam temel ama eksikler:

- **Goran (Abdulla Goran)** (1904-1962) — Modern Soranî şiirinin babası
- **Mela Eyûbê Hekarî** (16. yy) — Klasik Hekarî şair
- **Mela Mehmûdê Beyazîdî** (1797-1867) — "Adat û Rusûmatnameê" yazarı
- **Şex Reza Talebanî** (1837-1910) — Soranî hicvi şair
- **Heciyê Cindî** (1908-1990) — Sovyet Kürdü, halk şiiri derleyicisi
- **Lal Laleş** (j.d. 1975) — Modern feminist şiir
- **Mehmed Mehdî Zana** — Yakın dönem
- **Selîm Berekat** (j.d. 1951) — Suriyeli Kürt şair
- **Bekes** (Faiq Bekes, 1905-1948) — Soranî klasik
- **Kemal Burkay** (j.d. 1937) — Diaspora şair-aktivist

### E. Nivîskar (yazar) boşlukları
Mevcut 10 yazar iyi ama Kürt prozra/öykü geleneğindeki temel isimler eksik:

- **Yaşar Kemal** (1923-2015) — Türkçe yazmış ama Kürt kimliği güçlü
- **Mehmed Said Tofîq** — Modern öykü
- **Şener Özmen** (j.d. 1971) — Modern roman/sanat
- **Lokman Polat** (j.d. 1950) — Diaspora roman
- **Sevdê Çetin** — Kadın öykücü
- **Adar Yûsiv** — Modern roman
- **Ata Nehayî** (1960-2021) — Soranî roman
- **Bextiyar Elî** (j.d. 1960) — Soranî roman ("Êvara Perwaneyê")
- **Şerko Bêkes** (1940-2013) — Soranî şiir + prozra
- **Sherzad Hassan** — Soranî modern

### F. Kesayetên Dîrokî (tarihi kişilikler) boşlukları
Mevcut 10 kişi iyi başlangıç ama ⚠️ **Kürt tarihinin temel figürleri eksik**:

| Eksik kişi | Tarih | Önem |
|---|---|---|
| **Selahaddinê Eyyûbî** | 1137-1193 | Kudüs fatihi, en tanınan Kürt tarihi figürü |
| **Şerefxanê Bedlîsî** | 1543-1599 | "Şerefname" — ilk Kürt tarihi |
| **Mîr Bedirxan Beg** | 1802-1869 | Cizre Mîri, Bedirxanî hanedanı |
| **Qazî Mihemed** | 1893-1947 | Mahabad Cumhuriyeti Cumhurbaşkanı |
| **Simko Şikak** | 1880-1930 | Şikak aşireti lideri, Kürt bağımsızlık |
| **Îhsan Nûrî Paşa** | 1893-1976 | Ararat ayaklanması (1930) lideri |
| **Heci Mûsa Beg** | 1881-1922 | Hekarî milli mücadele |
| **Sara Xatun** | 14. yy | Aq Qoyunlu hanedanı kraliçesi |
| **Bese Nareynê** | 16. yy | Akkoyunlu kadın komutan |
| **Leyla Qasim** | 1952-1974 | İdam edilen kadın aktivist |
| **Sakine Cansız** | 1957-2013 | Kadın hakları figürü |

### G. Kategorize edilmemiş büyük boşluklar

#### G1. Xwarinên Kurdî (Yemekler) — ⭐ EN BÜYÜK BOŞLUK
**Mevcut: 1 item ("Nan û xwê").** Halbuki:

| Yemek | Bölge | Sembolik anlam |
|---|---|---|
| **Dolma** (dolme) | Tüm | Kalabalık paylaşım |
| **Kibbe / Kutilk** | Sırnak/Cizre | Misafir yemeği |
| **Savar** (bulgur) | Tüm | Temel besin |
| **Birîyanî** | Hekarî | Düğün yemeği |
| **Harîse** | Tüm | Kış yemeği, paylaşım |
| **Awxa** (yoğurt çorbası) | Hekarî | Hasta-iyileşen yemeği |
| **Qelyaze** (kavurma) | Tüm | Kış stoku |
| **Şîlanê** (yabani gül reçeli) | Erzurum | Kış pekmezi |
| **Pelûda** | Diyarbekir | Yaz tatlısı |
| **Kade** (kuru ekmek) | Tüm | Yolculuk azığı |
| **Çayê dêlokê** (köy çayı) | Tüm | Konukseverlik |
| **Hingiv** (bal) | Hekarî | Doğum-misafir geleneği |
| **Dengo** (yoğurt-buğday içeceği) | Tüm | Yaz serinleticisi |
| **Mîr-zengî** (kabuk fasulye) | Botan | Kış aile yemeği |
| **Topîk** | Suryani-Kürt | Bayram tatlısı |

#### G2. Cejn (Bayram/Festival) — kategori KAPALI
Şu an `celebration` enum'u kaldırılmış. **Geri eklenmeli**, çünkü:

- **Newroz** (21 Mart) — En büyük Kürt bayramı, ayrı ayrı destan-efsane var ama
  bayram ritüeli detayı yok
- **Roja Zimanê Kurdî** (15 Mayıs) — 1932 Hawar dergisinin çıkış günü
- **Çarşema Sor** (Kırmızı Çarşamba) — Yezidî yeni yılı (Nisan)
- **Roja Şehîdên Kurdistan** (14 Mayıs)
- **Cejna Qurbanê** (yerel adetler — Kürt aile geleneği)
- **Cejna Remezanê** (iftar adetleri)
- **Sersal** (Aliyê Mihtbahar)
- **Mihrcan** (sonbahar bayramı, kadim İran takvimi)

#### G3. Govend (Halay) û Cil û Berg (Geleneksel kıyafet) — yeni kategori
- **Govenda Çepik** — Botan halay
- **Govenda Şiroka** — Hekarî halay
- **Halayên dengbêjiyê** — Mardin halayı
- **Şal û şepik** — Hekarî erkek kıyafeti
- **Kraz û fîstan** — Kadın elbisesi
- **Kofî** (başlık) — Çeşitleri
- **Şiltik û eşarp** — Bölgesel desenler
- **Sîng** (göğüs takısı) — Düğün geleneği

#### G4. Mîmariya Kurdî (Mimari) — yeni kategori
- **Hesankeyfa** (Hasankeyf) — 12,000 yıllık kent
- **Cîzîra Botan** — Tarihi Cizre kalesi
- **Sertaca Mêrdînê** — Mardin medreseleri
- **Xanê Pîramêrd** — Süleymaniye
- **Kelha Dimdimê** — Mahmûdê Xan kalesi
- **Diyarbekir surları** — Karaboran kapılar
- **Sêwr** (köy mimarisi) — Çatısız damdar yapı

#### G5. Bûyerên Dîrokî (Tarihi Olaylar) — yeni kategori
Mevcut Şingal/Halepçe destanları yerine olaylar başlığı altında:

| Olay | Tarih | Önem |
|---|---|---|
| **Şerê Çaldiranê** | 1514 | Kürtlerin Osmanlı'ya geçişi |
| **Serhildana Bedirxan** | 1843-1847 | İlk modern Kürt başkaldırı |
| **Serhildana Şêx Ubeydullah** | 1880 | Pan-Kürt vizyon |
| **Serhildana Şêx Seîd** | 1925 | Cumhuriyet dönemi başkaldırı |
| **Serhildana Araratê** | 1927-1930 | Hoybûn-Xoybûn |
| **Komkujiya Dêrsim** | 1937-1938 | Devlet katliamı |
| **Komara Mehabad** | 1946 | Kürt cumhuriyeti, 11 ay |
| **Pêkanîna Hawarê** | 1932 | Bedirxan'ın Hawar dergisi |
| **Anfal** | 1986-1989 | Saddam katliamı |
| **Helebce** | 1988 | Kimyasal saldırı (mevcut) |
| **Şerê Kobanê** | 2014 | DAEŞ direnişi |
| **Şingal** | 2014 | Yezidî soykırımı (mevcut) |
| **Newrozên 1992-2002** | 90'lar | Bayram yasakları/direniş |

---

## 3. Önerilen Yeni Kategori/Enum Şeması

```dart
enum CulturalContentType {
  // Mevcut
  proverb,
  song,
  poem,
  story,
  foodTradition,
  historicalFigure,
  singer,
  poet,
  writer,

  // Yeni — geri eklenmesi/eklenmesi öneriler
  celebration,    // Cejn — Newroz, Çarşema Sor vs.
  historicalEvent, // Bûyer — Serhildan, Komkujî
  folkDance,      // Govend û Cilûberg — Halay, kıyafet
  architecture,   // Mîmarî — Hasankeyf, kale, köy mimarisi
}
```

Şu an UI'de yalnız 7 sekme var (Hemû, Gotin, Destan, Stranbêj, Helbestvan,
Nivîskar, Kesayetên Dîrokî). Şu eklemeler önerilir:

```
+ Xwarin   (yemek)       → 15-20 yemek
+ Cejn     (bayram)      → 8 bayram
+ Govend   (folklor)     → 10 halay/kıyafet item
+ Mîmarî   (mimari)      → 8 yapı
+ Bûyer    (olay)        → 13 tarihi olay
```

---

## 4. Kategori Bazında Somut Zenginleştirme Önerileri

### 4.1 Yemek (Xwarinên Kurdî) — örnek 3 item

#### a) Dolma — Tomê dewer

```kurmanci
Tomê dewer, xwarineke gelêrî ya kurdî ye. Bi pelên rezê, miya, an
beroşan tê pêçandin; tê de savar, goştê hûr, pîvaz, tomate û baharat
hene. Di malên Kurdan de, tomê dewer nîşana mêvanperweriyê ye —
gava mêvan tê, ji bo wî tom tê amade kirin.

Awayê amadekirinê:
1. Pelên rezê di ava germ de tên hûrkirin.
2. Savar, goştê hûr, pîvazê hûrkirî tên tevlihev kirin.
3. Her pel bi tijîkirinê tê pêçandin.
4. Bi sîr û kîşmîşê re di şewatê de tê pijandin (40-50 deqîqe).

Çand: Di dawetan de, deh-bîst jin bi hev re tomê dewer çêdikin.
Ev kar nîşana hevkariya jinan û kêfa civakî ye.
```

**Türkçe:** Dolma, Kürt halk yemeğidir. Yaprağa bulgur, kıyma, soğan, domates ve
baharat sarılır. Misafir gelince hazırlanır — misafirperverliğin sembolüdür.
Düğünlerde kadınlar birlikte sarar.

#### b) Savar (bulgur) — temel gıda

```kurmanci
Savar, ji genimê hilberî tê çêkirin: genim tê kelandin, ziwa kirin
û hêran. Du celeb sereke hene: savara hûr (ji bo şorbê û pîlavê) û
savara stûr (ji bo dolme û küfte).

Çand: Savar wek "nanê duyemîn" tê hesibîn. Beriya zivistanê, jin
bi salan savara malê amade dikirin — ev kar wek "kar û barê
keçikan" dihat zanîn û nîşana xanedaniyê bû.
```

#### c) Çayê dêlokê — köy çayı geleneği

```kurmanci
Çayê dêlokê (an: çayê gundî), nîşana mêvanperweriya kurdî ye.
Çay di kapika sor ("kapika çayê") de bi şekirê paqij tê amade
kirin û di îstîkanên zer de tê pêşkêş kirin.

Edebiyat: Di her hevdîtinekê de, "Çay venekîye" dê bibe nîşana
nehêvîtî. Mêvanperwerî dixwaze ku herî kêm sê îstîkan bên vexwarin.
```

### 4.2 Bayram (Cejn) — örnek 2 item

#### a) Newroz — 21 Adar

```kurmanci
Newroz, cejna gelêrî ya kurdî ye, di 21 Adarê de tê pîrozkirin.
Peyva "Newroz" ji "now" (nû) û "roz" (roj) tê — yanî "Roja Nû".

Mîtolojî: Li gor destana Şahnameyê, Kawayê hesinkar di vê rojê de
li dijî dîktatorê zalim Dehak rabû. Kawa bi bizmara xwe Dehak kuşt
û azadiyê li gel anî. Ji wê rojê û pê ve, agirên Newrozê li ser
çiyan tên dadan.

Adetên îro: Malbat li deşt û çiyan kom dibin, agir tê dadan,
zarokan ji ser agir bazdayîna xwe dikin (sembola paqijbûnê),
govend û dawet tê meşandin. Cilên kurdî tên lixwekirin: keçik
fîstan û kofî, lawik şal û şepik.

Edebiyat: Cegerxwîn û Hêmin Mukriyanî helbestên Newrozê
nivîsîne; "Newroz Newroz" ji stranên Şivan Perwer e.
```

#### b) Çarşema Sor — Yezidî yeni yılı

```kurmanci
Çarşema Sor (an Sersala Êzîdiyan), cejna nû ya gelê Êzîdî ye.
Di yekem çarşemiya meha Nîsanê de tê pîrozkirin.

Bawerî: Li gor mîtolojiya Êzîdî, Tawisî Melek (Periyê Tawûs) di
vê rojê de hatiye xelifîn ji bo parastina cîhanê. Ev nîşana
xelasiya mirovahiyê ye.

Adet: Tixmê hêkan tên xemilandin (sor, kesk, zer), li ser gorên
bav û bapîran xwarin tê danîn, "qaweltê Tawûsî Melek" tê dirêjkirin.
Govenda Hewlê û dîlanên kevneşopî tên kirin.

Cih: Gundên Şingalê, Lalîş, Hewlêr û Şêxan navendên sereke ne.
```

### 4.3 Halay (Govend) — örnek 2 item

#### a) Govenda Çepik — Botan halayı

```kurmanci
Govenda Çepik, govendeke gelêrî ye ji deşta Botan û Cizîrê.
Bi awayekî dor (çember) tê meşandin: dest û dest tên girtin,
piyê rastê li pêş, piyê çepê li paş tê meşandin.

Rîtim: 6/8 muzîk, bi def û zurnê re. Govend bi qaweltê dengbêjekî
dest pê dike, paşê hemû kom dibe.

Stran: "Lawikê min hat" (govenda kêfê), "Heyamo lê" (govenda
xemgînî), "Kirîvê" (Şivan Perwer'den).

Çand: Di dawet, tinhe û cejnan de tê meşandin. Halaya kurdî
nîşana yekîtiya civakê ye — "ji devê govendê derketin" wateya
dûriya civakê dide.
```

### 4.4 Tarihi olay (Bûyer) — örnek 2 item

#### a) Komara Mehabad (1946) — Mahabad Cumhuriyeti

```kurmanci
Komara Mehabad, dewleta yekem û tenê ya rojavayî ya tarîxa Kurdan
e. Di 22ê Çile 1946'an de li bajarê Mehabad (Rojhilatê Kurdistanê)
hate avakirin.

Lîderê wê: Qazî Mihemed (1893–1947), kesayetekî dînî û neteweyî.
Komar 11 mehan domand: dibistanên Kurdî vebûn, kovara "Kurdistan"
hat çapkirin, alaya kurdî hate dadan.

Dawiya wê: Di 31ê Adar 1947'an de, hêzên Şahê Îranî bajar girtin.
Qazî Mihemed û birayên wî hatin dardakirin li meydana Çar Çiraya
Mehabadê. Mistefa Barzanî bi 500 pêşmergeyên xwe ber bi Sovyetê
ve revî, ku salan paşê vegere serhildanê.

Mîras: Komara Mehabad, "alaya kurdî" ya niha ya li Başûrê
Kurdistanê û fikra "Kurdistana yekgirtî" ji wê serdemê dimîne.
```

#### b) Pêkanîna Hawarê (1932) — Hawar dergisi

```kurmanci
Hawar, kovara yekem a Kurmancî bi alfabeya Latînî bû.
Di 15ê Gulanê 1932'yan de li Şamê (Sûriye) hate weşandin.

Damezrîner: Mîr Celadet Alî Bedirxan (1893–1951), bi alîkariya
birayê xwe Kamûran Bedirxan û hin rewşenbîrên Kurd ên xerîb.

Berhem: Hawar 57 hejmar weşand (1932–1943). Tê de:
- Alfabeya Bedirxan (Latînî, 31 tîp): bingeh ji bo standardîzasyonê.
- Helbest, çîrok, gotinên gelêrî, ferhengoka piçûk.
- Berhemên Cegerxwîn, Qedrîcan, Osman Sebrî pêşî li wir derketin.

Mîras: 15ê Gulanê wek "Roja Zimanê Kurdî" tê pîrozkirin.
Alfabeya Hawar îro standarda Kurmancîya nivîskî ye.
```

### 4.5 Mimari (Mîmarî) — örnek 1 item

#### a) Hesankeyfa — Hasankeyf

```kurmanci
Hesankeyfa (bi tirkî: Hasankeyf), bajarê dîrokî ye li ser kenarê
Çemê Dîcleyê, li bakurê parêzgeha Êlîhê (Batman). Nêzîkî 12,000
sal beriya niha avakirina mirovan dest pê kiriye.

Dîrok: Bi sedan şikeftên di kevirên çiyê de hatine kolandin.
Romayî, Bîzansî, Eyûbî û Osmanî vê herêmê parastine.
Köprîya Çar Stûyî (1116) û Mizgefta El-Rizk (1409) ji binyatên
girîng in.

Bûyera 2020: Di sala 2020'an de, ji ber baraja Ilîsuyê, beşekî
Hesankeyfayê di bin avê de ma. Pirana Çar Stûyî û çend yadigarên
herî kevn nemane. Ev di nav nivîskar û mîmarên cîhanê de bû mijara
gilî û rexneyê.

Mîras: Hesankeyfa wek "Petraya Kurdistanê" tê hesibîn — mîrasa
çand-mîmariyê ya 12 hezar salan e.
```

### 4.6 Eksik destan (örnek 1 item — Bedirxan-Hawar dilbilgisi denetlenmiş)

#### Dewrêşê Evdî û Edûle

```kurmanci
Destana Dewrêşê Evdî û Edûle, ji destanên evînî yên klasîk ên
Botanê ye. Di sedsala 17an de hat berhevkirin.

Çîrok: Dewrêşê Evdî, lawê Mîr Evdî yê Bedirxaniyan, di govendekê
de Edûleya keça mîrê herêmî dît. Bi yek nihêrînê dilketin. Lê
malbata Edûleyê li hember evîna wan derket; keçikê bi zorê dan
yek mîrê biyanî.

Dawiya destanê: Dewrêş li ser çiyayê Cûdî bi xemê mir. Edûle, ku
sirra evînê bihîst, xwe avêt Çemê Dîcleyê. Du gor li ser hev
hatin çêkirin — ji wan rojê û pê ve, kulîlkek sor di nav her du
goran de şîn dibe.

Sembolîk: Wek Mem û Zîn, Dewrêş û Edûle nîşana evîna nemir û
serhildana li hember pergala mîrekiyê ne. Di stranên Karapetê
Xaço û Şakiroyê de tên dubarekirin.
```

---

## 5. Kurmancî Doğruluk ve Yazım Standardı

Tüm yeni içerik **Bedirxan-Hawar standardına (1932)** uymalı. Önemli kontrol
noktaları:

### 5.1 Diakritik kullanımı (zorunlu)

| Harf | Kullanım | Örnek (doğru) | Yanlış |
|---|---|---|---|
| **î** (uzun i) | sînor, dîl, hîn | `çîrok`, `Cizîrî` | ❌ `cirok`, `Ciziri` |
| **û** (uzun u) | rû, dûr, çûyîn | `dûr`, `çûn` | ❌ `dur`, `çun` |
| **ê** (kapalı e) | sêv, mêr, hêvî | `mêr`, `welêt` | ❌ `mer`, `welet` |
| **ç** (ç) | çiya, çav | `çand`, `çîrok` | ❌ `cand` |
| **ş** (ş) | şîn, şer | `Şivan`, `şer` | ❌ `Sivan`, `ser` |
| **x** (gargara x) | xanî, xêr | `xanî`, `xelat` | ❌ `hani` |
| **q** (gırtlak q) | qebr, qant | `qehr`, `qonax` | ❌ `kehr` |

### 5.2 Ezafe kuralları

| Cinsiyet | Tek | Çoğul | Örnek |
|---|---|---|---|
| **Eril (nêr)** | `-ê` | `-ên` | `welatê min` (vatanım) |
| **Dişil (mê)** | `-a` | `-ên` | `dayika min` (annem) |
| **Belirsiz (yî, ya)** | `-ekî/-ekê` | `-ne` | `çîrokeke kevin` |

### 5.3 Ergative geçmiş zaman

Geçişli fiillerin geçmiş zamanında özne **eğik halde** olur:

- ✅ `Min got` (söyledim) — "min" eğik
- ❌ `Ez got` — yanlış
- ✅ `Wî dît` (gördü) — "wî" eğik
- ❌ `Ew dît`

### 5.4 Sık yapılan hatalar (yeni içerikte kaçınılmalı)

| Hata | Doğru | Açıklama |
|---|---|---|
| `ki` | `ku` | Türkçe "ki" ≠ Kurmancî bağlaç "ku" |
| `emê` | `em ê` | Gelecek zaman zamir + ê ayrı |
| `ders` (Kurmancî bağlam) | `wane` | Lûtke standartlaştırma |
| `tüm` | `hemû` | TR borçlanması |
| `çok` | `pir`, `gelek` | TR borçlanması |
| `ama` | `lê`, `lê belê` | TR borçlanması |
| `için` | `ji bo` | TR borçlanması |
| `Türkçe ı` (KU metinde) | yok | Karakter Kurmancî alfabede yok |

### 5.5 QA tarayıcı entegrasyonu

`tools/qa/kurmanci_lint.py` ve `tools/qa/kurmanci_scanner.py` zaten bu kuralları
denetliyor. Her yeni içerik eklendikten sonra çalıştırılmalı:

```bash
python tools/qa/kurmanci_scanner.py   # Türkçe sızıntı
python tools/qa/kurmanci_lint.py      # Yazım/diakritik
```

---

## 6. Önceliklendirme (Roadmap)

### Faz 1 — Kritik eksikler (öncelik: ⭐⭐⭐)
1. **Yemek kategorisi**: 15 yemek. Çocuk + heritage modülü için yüksek değer.
2. **Cejn (bayram) kategorisi**: 8 bayram. `celebration` enum geri ekle.
3. **Tarihi olaylar**: 13 olay. Kişiler var, olaylar eksik — öğretici boşluk.
4. **Atasözü TR çevirileri**: 2,917 atasözü. Aşamalı (haftada 100).

### Faz 2 — Genişletme (öncelik: ⭐⭐)
5. **Destan ekleri**: 10 yeni destan (Dewrêşê Evdî öncelikli).
6. **Stranbêj ekleri**: 13 yeni isim (modern dengbêj + kadın).
7. **Tarihi kişilik ekleri**: 11 yeni isim (Selahaddin, Şerefxanê Bedlîsî öncelikli).
8. **Helbestvan ekleri**: 10 yeni şair (Goran, Lal Laleş öncelikli).

### Faz 3 — Yeni kategoriler (öncelik: ⭐)
9. **Govend & Cil û Berg**: 10 item.
10. **Mîmarî**: 8 yapı.
11. **Helbest & Stran metin koleksiyonları**: 30+ tam metin.

### Faz 4 — Niceliksel zenginleştirme
12. Nivîskar ekleri: 10 yeni isim.
13. Mevcut girdilerde kaynaklar/audio bağlantı tamamlama.

---

## 7. Teknik Uygulama Adımları (özet)

1. **`cultural_entities.dart`** — eksik enum türleri ekle (`celebration`,
   `historicalEvent`, `folkDance`, `architecture`).
2. **`culture_screen.dart`** — yeni sekme tanımları (`_kTabs` listesi).
3. **Yeni DB dosyaları**:
   - `kurdish_foods_db.dart` — Faz 1
   - `kurdish_celebrations_db.dart` — Faz 1
   - `kurdish_events_db.dart` — Faz 1
   - `kurdish_architecture_db.dart` — Faz 3
4. **Mevcut DB'leri genişlet**:
   - `kurdish_legends_db.dart` (+10 destan)
   - `kurdish_artists_db.dart` (+13 stranbêj, +10 helbestvan, +10 nivîskar)
   - `cultural_entities.dart` (+11 tarihi kişilik)
5. **Atasözü TR çeviri yardımcısı**: `gotinen_pesiyan_db.dart` aşamalı dolgu.
6. **Tüm yeni metinler** üzerinden `tools/qa/kurmanci_*.py` doğrulayıcılarını çalıştır.
7. **CI bağlantısı**: `quiz-qa.yml` workflow'una culture validator eklemek.

---

## 8. Kaynaklar (yeni içerik için referans)

### Akademik
- Institut Kurde de Paris yayınları
- Kurdish Academy (Erbil) yayınları
- Kurdipedia (kurdipedia.org)
- Encyclopædia Iranica — "Kurdish" girişleri
- Mehrdad R. Izady — *The Kurds: A Concise Handbook*

### Dilbilgisi/yazım
- Celadet Bedirxan & Roger Lescot — *Grammaire Kurde* (1970)
- Kurdo, Kanat — *Rêziman Kurdî* (1956)
- Hawar Dergisi (1932–1943) tıpkıbasım
- Wîkîpediya Kurmancî (ku.wikipedia.org)

### Sözel gelenek (destan)
- Ordîxanê Celîl & Celîlê Celîl — *Çîrok û Çîrokbêjên Kurd* (1965)
- Heciyê Cindî — *Folklora Kurdî* (1957, Ermenistan)
- Mela Mehmûdê Beyazîdî — *Adat û Rusûmatnameê Ekradiyye*
- Sasun Asatryan — Sovyet Kürt arşivi

### Müzik (stranbêj)
- Saara — *Antolojiya Stranên Kurdî* (3 cilt)
- Mehmûd Berazî — dengbêj kayıtları
- Ahmedê Mîrazî — *Stranbêjên Mezin*

---

## 9. Beklenen Çıktı (sayısal hedef)

| Kategori | Şu an | Faz 1 sonrası | Faz 3 sonrası |
|---|---:|---:|---:|
| Yemek | 1 | 16 | 20 |
| Bayram | 0 | 8 | 10 |
| Tarihi olay | 0 | 13 | 13 |
| Destan | 15 | 15 | 25 |
| Stranbêj | 20 | 20 | 33 |
| Helbestvan | 12 | 12 | 22 |
| Nivîskar | 10 | 10 | 20 |
| Tarihi kişilik | 10 | 21 | 21 |
| Halay/kıyafet | 0 | 0 | 10 |
| Mimari | 0 | 0 | 8 |
| Helbest tam metin | 5 | 5 | 30 |
| Stran tam metin | 2 | 2 | 25 |
| Atasözü TR çeviri | 446 | 1,500 | 3,000 |
| **TOPLAM yeni içerik** | — | **~50 yeni** | **~150 yeni** |

---

## 10. Sonuç

Çand sayfası şu an üç yapısal soruna sahip:

1. **Atasözü ezici çoğunluk**: %97 tüm content atasözü; diğer kategoriler az.
2. **Yemek/bayram boşlukları**: Heritage öğrenciler için kültürel kimlik çekirdek
   konuları neredeyse yok.
3. **Tarihi olaylar yok**: Kişi-bazlı içerik var, olay-bazlı yok.

Bu üç sorunu çözmek için **3 fazlı bir zenginleştirme yol haritası** önerilir.
Tüm yeni içerik:
- Bedirxan-Hawar Latin alfabesi
- Doğru ezafe ve ergatif kullanımı
- Sıfır Türkçe-Kurmancî karışımı
- Mevcut QA tarayıcılarıyla doğrulanmış

Bu plan tamamlandığında Çand sayfası **dünyada en kapsamlı dijital Kurmancî
kültür koleksiyonu** olacaktır — Institut Kurde de Paris ve Kurdipedia
dışında karşılaştırılabilir bir kaynak yok.
