# KURMANCI ORTOGRAFİK VE GRAMER KURALLARI

# Kurmancî Linter Spesifikasyonu — Authoritative Spec

> **Audience:** Kurmancî–Türkçe iki dilli bakımcı (project maintainer).
> **Purpose:** Bu doküman, 32.000+ satırlık Kurmancî öğrenme içeriğindeki yazım hatalarını otomatik olarak tespit eden Python tabanlı bir linter için tek otoriter kaynaktır.
> **Standard:** Hawar imlâ standardı (Celadet Bedirxan–Roger Lescot, 1932 sonrası).
>
> **Kaynaklar (refs):**
> - **B-L** = Celadet Bedirxan & Roger Lescot, *Kürtçe Gramer (Kurmancî Lehçesi)*, Paris, 1990. (`refs/bedirxan.txt`)
> - **Badillî** = Kemal Badillı, *Türkçe İzahlı Kürtçe Grameri (Kürmançça Lehçesi)*, Ankara, 1965. (`refs/bedirxan_lescot.txt`)
> - **Thackston** = W. M. Thackston, *Kurmanji Kurdish: A Reference Grammar*, Harvard. (`refs/kurmanji_complete.txt`)
> - **MEB** = T.C. Millî Eğitim Bakanlığı, *Yaşayan Diller ve Lehçeler — Kürtçe Öğretim Programı*, Ankara, 2012. (`refs/meb_yasayan_diller.txt`)
> - **Fêrker** = Adak/Aydın/Ergün/Bülbül, *Fêrkera Kurdî — Asta Destpêkê*. (`refs/ferkera_kurdi.txt`)
> - **Aslanoğlu** = Osman Aslanoğlu, *Kurmancî — Kürtçe Dil Kartları*, Delta, 2017. (`refs/aslanoglu.txt`)
> - **KDE** = *Kürt Dili ve Edebiyatı Ders Kitabı*, Tarih Vakfı. (`refs/kurt_dili_edebiyati.txt`)
>
> **Notation in this file:**
> - `BAD` = yanlış biçim (linter flag).
> - `OK` = doğru biçim (linter suggestion).
> - `[Linter pattern]` = bad-pattern regex (Python `re` syntax, `re.UNICODE | re.IGNORECASE` unless explicitly stated).
> - All regex patterns are designed to be word-bounded with `\b` unless specified.
> - When two forms compete (e.g., `spas` vs `sipas`), the canonical one is the form preferred by Bedirxan-Lescot grammar; alternates are accepted as warnings, not errors, unless noted.

---

## 1. HAWAR ALFABESİ (31 HARF)

### 1.1 Resmi Hawar harf listesi

Bedirxan–Lescot grameri (B-L §2, p. 4) **31 ana harf** tanımlar. Tercihen iki ekstra harf (ḧ ve ẍ — ihtiyari) bazı ağızlarda kullanılır, ancak Bedirxan standardında **31 harfli alfabe** esastır:

```
A  B  C  Ç  D  E  Ê  F  G  H  I  Î  J  K  L  M  N  O  P  Q  R  S  Ş  T  U  Û  V  W  X  Y  Z
a  b  c  ç  d  e  ê  f  g  h  i  î  j  k  l  m  n  o  p  q  r  s  ş  t  u  û  v  w  x  y  z
```

**Sesliler (8):**  `a, e, ê, i, î, o, u, û`
**Sessizler (23):** `b, c, ç, d, f, g, h, j, k, l, m, n, p, q, r, s, ş, t, v, w, x, y, z`

**Kısa sesliler (3):** `e, i, u`
**Uzun sesliler (5):** `a, ê, î, o, û`

> **Cite:** B-L §2 ("Kürt alfabesi otuz bir harf"), p. 4; Fêrker p. 14 ("Alfabeya kurdî ji sî û yek tîpan pêk tê"); Aslanoğlu p. 3.

### 1.2 İhtiyari (opsiyonel) harfler

Bazı bölgesel ağızlarda Arapça'dan miras kalmış üç fonem ihtiyari olarak gösterilir (B-L §5):

| İhtiyari harf | Karşılık | Standart Hawar | Linter politikası |
|---|---|---|---|
| ḧ (h̄) | Arapça ح | `h` | **Tolerate**: Akademik / Latince transkripsiyon dışında uyarı verme |
| ẍ | Arapça غ | `x` | **Tolerate**: Akademik / Latince transkripsiyon dışında uyarı verme |
| ʼ (ayn) | Arapça ع | gösterilmez | **Tolerate**: Akademik dışında atılır |

Öğrenme içeriğinde **31 harfli pür Hawar** beklenir; ḧ/ẍ kullanılmamalıdır.

[Linter pattern] (öğrenme içeriğinde ḧ/ẍ tespiti):
```regex
[ḧẖẍ]
```

### 1.3 Türkçe-spesifik harfler — KESİNLİKLE YASAK

Pür Kurmancî metinde aşağıdaki Türkçe harfler **bulunamaz**:

| Türkçe harf | Sebep | Doğru Kurmancî karşılığı |
|---|---|---|
| `ı` (noktasız i) | Kurmancî'de yok | `i` (B-L §9, "Kürtçede sekiz ünlü"). Kurmancî `i` zaten Türkçe `ı` sesindedir |
| `İ` (büyük noktalı i) | Türkçe konvansiyon; Kurmancî büyük `I` kullanır | `I` (büyük) |
| `ğ` | Kurmancî'de yok | Yumuşatma yok; loanword'lerde atlanır veya `g`'ye dönüşür (örn. *ağa* → `axa`) |
| `ö` | Kurmancî'de yok (B-L §21: "ö Kurmancî leh­çesinde hemen hemen yoktur"); B-L bazı ağızların `ö'ya yer verdiğini, ancak Hawar alfabesine alınmadığını belirtir | `o` veya `e` (örn. *göl* → `gol`; *Ömer* → `Omer`) |
| `ü` | Kurmancî'de yok (Badillî §7-8) | `u` veya `û` ya da `i` |

**Cite:** Badillî p. 9: "Kurmancîda Türkçedeki ö, ü vokalleri olmadığından mesela göl kelimesi gol, Ömer kelimesi Omer, üzüm kelimesi üzüm üjm, üç kelimesi de sê şeklinde telâffuz olunur."

[Linter pattern] (Türkçe harfler — tek bir Türkçe harfin Kurmancî kelimesinde geçmesi):
```regex
[ıİğöÖüÜ]
```

> Yan etki: Eğer içerik açıkça Türkçe karşılık alanında ise (örneğin sözlük TR sütunu), bu pattern tetiklenmemeli. Linter kurmancî alanını işaretlemeli, Türkçe alanı değil.

### 1.4 Aspirated vs. unaspirated stops — yazıda gösterilmez

`p, t, k, ç` **iki farklı sese** denk gelir (aspire/aspire değil), ancak Hawar imlâsı bunları ayırmaz. Thackston **§** "they are not indicated in the writing system." Linter aspire altçizgi/işaretleme görse de uyarı vermez.

Ancak öğrenme içeriği aspire belirten alt-çizgi varyantlarını içermemelidir:

[Linter pattern]:
```regex
[ṕṕt̪ḱč̌]
```
(ASCII'ye dönüştürülmeli.)

### 1.5 Doubled consonants — neredeyse yok

Kurmancî'de çift sessize **çok nadiren** rastlanır (Thackston, "Doubled consonants are quite rare"). Çoğu Arapça ödünç ikilemesi tek sessize indirgenir:

| BAD | OK | Açıklama |
|---|---|---|
| `muddet` | `mudet` | Arapça مدة |
| `mulla` | `mele` | Arapça ملا |
| `şiddet` | `şidet` | Arapça شدة |

İstisnalar (kabul edilen ikilemeler): `ummet`, `welle`, `seff`, `muswedde`, ve özellikle r-ikilemesi `pirr`, `gerr`. Trilled `r` opsiyonel olarak `rr` ile gösterilebilir (Thackston, p. 3).

[Linter pattern] (sık rastlanan ikileme hataları):
```regex
\b(\w*?)([bcçdfgjklmnpsştvxz])\2(\w*)\b
```
(allowlist ile filtrelenmeli — özellikle `pirr`, `gerr`, `welle`, `seff`, `ummet`)

### 1.6 The furtive i (kayıp i)

Kurmancî, sonu çift sessize varan kelimelerde araya bir `i` koyar. Bu `i` ekli durumlarda düşer (Thackston p. 5):

| Yalın hâl | Ek almışta i düşer |
|---|---|
| `aqil` (akıl) | `aqlê te` (senin aklın) |
| `esil` | `bi eslê xwe` (aslında) |
| `emir` (yaş) | `emrê min` |
| `fêhm`/`fêhim` | `ez fêhm dikim` |

Linter politikası: Hem `fêhm` hem `fêhim` kabul. Sözlüklerde lemma `aqil`, `esil`, `emir`, `fêhim` (italik i ile).

---

## 2. SESLİ KURALLARI

### 2.1 Kısa vs. Uzun sesli ayrımı (B-L §6)

| Kısa | Uzun | Türkçe yaklaşığı |
|---|---|---|
| `e` | `ê` | (e) vs. (Fr. é, *été*) |
| `i` | `î` | (Tr. ı) vs. (uzun ince i) |
| `u` | `û` | (Tr. u-ü arası) vs. (uzun u) |
| — | `a` | (uzun a) |
| — | `o` | (Tr. o) |

**Bu ayrım anlam farkı yaratır.** Kısa `i` ile uzun `î` karıştırılırsa anlam değişir.

### 2.2 Minimal pairs (≥10 örnek)

Hata yapılırsa anlam değişeceğinden, linter aşağıdaki çiftlerde lemma-ekli sayfa düzeltir:

| Form A | Anlam A | Form B | Anlam B | Linter |
|---|---|---|---|---|
| `kir` | yaptı (geçmiş kök) | `kîr` | erkek cinsel organı (kaba) | İçerik tipi: ÇOCUK öğrencileri için `kîr` üretilmemeli |
| `ker` | eşek; sağır | `kêr` | bıçak | her ikisi de geçerli; bağlam |
| `bir` | götürdü | `bîr` | hafıza, kuyu | her ikisi de geçerli |
| `mir` | öldü; emir | `mîr` | bey, prens | her ikisi de geçerli |
| `mir` | öldü | `mêr` | erkek, koca | farklı kelime — karıştırılmasın |
| `gul` | gül | `gûl`/`gul` | (ikinci yok) | sadece `gul` |
| `dest` | el | `dist`* | yok | her zaman `dest` |
| `nan` | ekmek | `nên`* | yok | her zaman `nan` (ya da i.h. `nîn`?) |
| `min` | benim | `mîn`* | yok | her zaman `min`. Bkz. §10 |
| `ev` | bu | `êv`* | yok | her zaman `ev`. ⚠ `êvar` (akşam) farklı kelime |
| `ew` | o | `êw`* | yok | her zaman `ew` |
| `şer` | savaş, kavga | `şêr` | aslan; süt | her ikisi geçerli; bağlam |
| `şîr` | süt; kılıç | — | — | her zaman uzun `î` |
| `por` | saç | `pîr` | yaşlı (kadın) | farklı kelime — karıştırılmasın |
| `roj` | gün | `rûj`*/`ruj`* | yok | her zaman `roj`. Türkçe "roj/ruj" yanlış |
| `dil` | kalp; gönül; istek | `dîl` | esir | her ikisi geçerli; bağlam |
| `dîn` | din; deli | `din` | başka, diğer | her ikisi geçerli |

[Linter pattern] (sık rastlanan i-î karıştırması — örnek olarak):
```regex
\bmîn\b   → suggest: 'min'
\brûj\b   → suggest: 'roj'
\bnên\b   → suggest: 'nan'
\bdîst\b  → suggest: 'dest'
\bsîpas\b → suggest: 'spas' (veya 'sipas')
```

### 2.3 e — ê özel kuralı

Kelime `ê` ile bittiğinde, sonraki ek `y` ile başlıyorsa, son `ê` yazıda korunur ama telaffuzda `e` olarak okunur (B-L §16). Bu kural **yazıda değişmez** — linter bu fonetik dönüşümü hata olarak işaretlememeli:

| OK | OK |
|---|---|
| `tu kurê kê yê?` | "kimin oğlusun?" (Okunuş: *kurê ke yê*) |
| `kitêb li ser masê ye` | "kitap masada" (Okunuş: *mase ye*) |

### 2.4 Furtive `i` ile çift sessizden kaçınma (B-L §11-13)

Kurmancî kelimenin başında `î` ile başlamayı kabul etmez (B-L §15: "Î ünlüsü hiçbir zaman y'den önce gelmez"). `i` ile başlayan kelimelerin çoğu Arapça ödünçtür (`izin`, `imza`, `insan`).

[Linter pattern] (kelimenin başında `î` — tetikleyici hata):
```regex
\bî
```
(Yalnızca metnin sözcük başı; istisna: özel ad / yer adı sözlükten gelen).

### 2.5 `u` öncesi pozisyon kuralı (B-L §12)

`u` (kısa) **yalnızca** `g, h, k, q, x` sessizlerinden sonra gelir. İstisna: birkaç tek heceli zamir/sayı (`tu`, `du`, `sund`).

[Linter pattern] (yanlış pozisyonda `u` — örn. `bu`, `lu`, `ru`):
```regex
\b[^ghkqxtds]u[^aâê]
```

### 2.6 `u` ↔ `iw` dönüşümü (B-L §19)

`û`/`u` ile biten kelime ek aldığında, `u` → `i` ve araya `w` girer:

| Yalın | Ek almış |
|---|---|
| `tû` (dut) | `dara tiwê` (dut ağacı) |
| `rû` (yüz) | `riwê min` (yüzüm) |

Bu fonetik dönüşüm yazıda gösterilir.

### 2.7 `xw` digrafı — Korunan grup (B-L §30)

Kurmancî, eski Farsça `xw` grubunu korumuştur (Thackston, "in xw the w is a close back unrounded semivowel"). Bu grup **asla `xu`** olarak yazılmaz:

| BAD | OK |
|---|---|
| `xudê` | `xwedê` (Tanrı) |
| `xu` | `xwe` (kendi) |
| `xulî` | `xwelî` (kül) |
| `xustin` | `xwestin` (istemek) |
| `xuarin` | `xwarin` (yemek) |
| `xuş` | `xweş` (güzel, hoş) |
| `xudan` | `xwedan` (sahip) |
| `xosi` | `xwesî` (kayınvalide) |
| `xeyşk`/`xuşk` | `xwişk` veya `xwehk`/`xweh` (kız kardeş) |

[Linter pattern] (xw → xu hatası):
```regex
\bxu(?=[aeio])
```
(Eşle: `xua-`, `xue-`, `xui-`, `xuo-` — ama `xu` ile başlayan ve sonra konson sessiz gelmeyen kelimeleri etkileme.)

---

## 3. EZAFE (TAMLAMA / RAVEK) EKLERİ

### 3.1 Temel ezafe ekleri (B-L §99, Thackston §4)

| | Tekil eril | Tekil dişil | Çoğul (her iki cins) |
|---|---|---|---|
| Belirli (definite) | `-ê` | `-a` | `-ên` |
| Belirsiz (indefinite) | `-ekî` | `-eke` | `-ine` |

| | Belirli | Belirsiz | Çoğul belirsiz |
|---|---|---|---|
| **Eril** | `hespê min` (atım) | `hespekî min` (bir atım) | `hespine min` (atlarım) |
| **Dişil** | `mehîna min` (kısrağım) | `mehîneke min` (bir kısrağım) | `mehînine min` |
| **Çoğul** | `hespên min` (atlarım) | — | — |

> **Cite:** B-L §99, p. 73-77; Thackston §4, p. 11.

### 3.2 ≥15 doğru-yanlış örneği

| BAD | OK | Açıklama |
|---|---|---|
| `mala min a` | `mala min` | Diş. tek. ezafe `-a` zaten kelimede |
| `kura min` | `kurê min` | "oğlum" — eril, `-ê` |
| `kitêbê min` | `kitêba min` | "kitabım" — `kitêb` dişil, `-a` |
| `dayika min ê mezin` | `dayika min ya mezin` | Çoklu sıfat: ravek genişletici (extender) `ya` |
| `mamostê min e mezin` | `mamostê min ê mezin` | Eril extender `ê` (vurgulu) |
| `hespan min` | `hespên min` | Çoğul ezafe `-ên`, `hespan` çoğul oblique |
| `mêvanên kurda` | `mêvanên kurdan` | Çoğul oblique `-an` (kurd→kurdan) |
| `evê kitabê` | `eva kitêbê` veya `ev kitêba ...` | Demonstrative-uyum |
| `dotmama min` | `dotmama min` | OK — dotmam dişil, `-a` |
| `dotmamê min` | `dotmama min` | "amca kızım" — dişil |
| `kitêba minê nû` | `kitêba min a nû` veya `kitêba min ya nû` | Ek genişletici `a/ya` |
| `kura paşa` | `kurê paşa` | eril ezafe `-ê` |
| `pirtuka min` | `pirtûka min` | "pirtûk" (kitap), `û` uzun |
| `mala bavê min mezin` | `mala bavê min ê mezin` | Eril extender `ê` |
| `gundên kurdê Tirkiyê` | `gundên kurdên Tirkiyê` | "Türkiye Kürtleri'nin köyleri" — çoğul ezafe |
| `hevala minê` | `hevala min` | Dişil ezafe içinde "min" oblique kalır |
| `roja yekşemê` | `roja yekşemê` | OK — roj dişil, "yekşem" oblique |

### 3.3 Ezafe genişletici (Construct extender, B-L Lescot kısmı; Thackston §5)

Ek bir sıfat veya tamlayıcı eklendiğinde, `yê / ya / yên` kullanılır:

| Tek başına | Genişletici eklemek için |
|---|---|
| `kitêba nû` (yeni kitap) | `kitêba nû ya kovarê` (derginin yeni sayısı) |
| `mirovê mezin` (büyük adam) | `mirovê mezin yê welêt` (vatanın büyük adamı) |
| `kurê min ê mezin` (büyük oğlum) | `kurê min ê mezin ê hêja` (değerli büyük oğlum) |

Bazı ağızlar `yê/ya/yên` yerine `ê/a/ên` kullanır (ünlüden sonra). Linter her ikisini de kabul eder.

[Linter pattern] (ezafe çakışması — sıfat sonrası ek ezafe gerektiğinde eksik):
```
Heuristic: Eğer aynı NP'de bir sıfat + sonradan tamlayıcı varsa, extender beklenir.
Programatik check: NER + dependency parse gerekir, basit regex çıkmaz.
```

### 3.4 Sesli ile biten kelimelerde ezafe

Kelime sonu sesliyse araya bağlantı sessizi `-y-` veya `-w-` girer (B-L §103-105):

| Sonu | Bağlantı | Örnek |
|---|---|---|
| `-a` (eril) | `y` | `zavayê min` (damadım) |
| `-a` (dişil) | `y` | `çirayê min` → `çira min` (büzülmüş) |
| `-e` (eril) | `y` veya büzülme | `paleyê pîr` veya `palê pîr` (yaşlı orakçı) |
| `-e` (dişil) | `y` veya `e→a` | `perdeya min` veya `perda min` (perdem) |
| `-î` | `y` | `ronahiya min` (ışığım) |
| `-o` | `w` veya `y` | `çowê min` veya `çoyê min` |
| `-û` | `w` (`u` araya) | `riwê min` (yüzüm), `tiwê min` (dudum) |

[Linter pattern] (-a + ezafe çakışması — sesli üst üste):
```regex
\b(\w+)a\s+(?:e|ê)\s
```
(uyarı, doğrudan hata değil — bağlantı gerekli olabilir.)

---

## 4. EĞİK / OBLIQUE HÂL

### 4.1 Eğik hâl ekleri (B-L §114, Thackston §1.2)

| | Tek eril | Tek dişil | Çoğul |
|---|---|---|---|
| Yalın (nominative) | `-` (değişmez) | `-` (değişmez) | `-` (değişmez) |
| Eğik (oblique) | `-î` veya iç çekim* | `-ê` | `-an` |

*Eril çekim: `a/e` içeren tek heceli kelimelerde sıklıkla iç çekim (`a/e → ê`). Örn: `hesp` → `hêsp`, `welat` → `welêt`. Bu **opsiyoneldir**; modern yazımda eril `-î` kayboluyor. Yalnızca demonstrative + isim'de zorunlu (B-L §115).

### 4.2 Cümle içi kullanım (Thackston §1.2)

Eğik (oblique), şu durumlarda zorunludur:
1. **Şimdiki/genel zaman direct object** — `Ez mirovî dibînim` (Adamı görüyorum)
2. **Geçmiş zaman geçişli fiilde agent (özne)** — `Min mirov dît` (Adamı gördüm) — split-ergative
3. **Edat tamamlayıcısı** — `ji mirovî, di odeyê de, li jinê`
4. **Tamlama'nın ikinci üyesi (genitive)** — `gundê kurdan` (Kürtlerin köyü)

### 4.3 ≥15 doğru-yanlış örneği (eğik hâl)

| BAD | OK | Açıklama |
|---|---|---|
| `Ez ji mal hatim` | `Ez ji malê hatim` | "Evden geldim" — `mal` dişil, `-ê` |
| `Ez di mal de me` | `Ez di malê de me` | "Evdeyim" |
| `Li gund mêvanek heye` | `Li gundî mêvanek heye` | Eril `-î` (Doğu ağızlarında `gund`) |
| `Ji bo mirov` | `Ji bo mirovî` | "İnsan için" — eril oblique |
| `Bi nan re` | `Bi nan re` | OK — `nan` eril, opsiyonel `-î` |
| `Ji ber jin` | `Ji ber jinê` | "Kadın yüzünden" — dişil oblique |
| `Ez wî dibînim` | OK | `ew` (o) eril oblique = `wî` |
| `Ez ew dibînim` | `Ez wî / wê dibînim` | Direct object oblique olmalı |
| `Min jinek dît` | OK | "Bir kadın gördüm" — geçmiş ergative; jin patient |
| `Ez ji bajar têm` | `Ez ji bajêr têm` veya `ji bajarî` | Eril iç çekim `a→ê` |
| `Li ser mase` | `Li ser masê` | "Masada" |
| `Ji bo zarok` | `Ji bo zarokî` veya `ji bo zarokê` | Belirli/belirsiz |
| `bi te re` | OK | OK — "seninle" |
| `gava (ku) min ji bavê min re got` | OK | "Babama söylediğim zaman" |
| `Ez gundi me` | `Ez gundî me` | "Ben köylüyüm" — `gundî` (köylü) farklı kelime |
| `Ez gundî dibînim` | `Ez gundî dibînim` | OK — eril oblique |
| `Ji wan mirov` | `Ji wan mirovan` | Çoğul oblique `-an` |
| `Bi van zarok re` | `Bi van zarokan re` | Çoğul oblique |

[Linter pattern] (edat sonrası eğik hâl atlamış):
```regex
\b(li|ji|di|bi|ji bo|ji ber|li ser|li ber|ji nav)\s+([a-zêîûçşA-ZÊÎÛÇŞ]+)(?!ê|î|an|ê de|ê re|ê ve)\b
```
(Heuristic; per-word lookup ile filter — tüm yalın hâlde bırakılmış edat tamamlayıcılarını uyarı olarak işaretle.)

### 4.4 Demonstrative + isim (B-L §115, Thackston §2)

`ev/ew` ile değiştirilen tekil eril isim **zorunlu olarak** `-î` alır:

| BAD | OK |
|---|---|
| `Ez vî mirov dibînim` | `Ez vî mirovî dibînim` |
| `Ez wî hesp dibînim` | `Ez wî hespî dibînim` veya `wî hêsp dibînim` |
| `bi vê hesp` | `bi vî hespî` |
| `ji w mirov` | `ji wî mirovî` |
| `Eve mirov hat` | `Ev mirov hat` (yalın), `vî mirovî dît` (oblique) |

Çoğulda demonstrative `van/wan` + isim `-an`:

| BAD | OK |
|---|---|
| `Ez van zarok dibînim` | `Ez van zarokan dibînim` |
| `wan kitêb` | `wan kitêban` |

---

## 5. ZAMİRLER VE ZAMİR KLİTİKLERİ

### 5.1 Şahıs zamirleri (Thackston §7)

| | Yalın | Eğik |
|---|---|---|
| 1.tek. | `ez` | `min` |
| 2.tek. | `tu` | `te` |
| 3.tek. eril | `ew` | `wî` |
| 3.tek. dişil | `ew` | `wê` |
| 1.çoğ. | `em` | `me` |
| 2.çoğ. | `hûn` (ayrıca `hun`) | `we` |
| 3.çoğ. | `ew` | `wan` |

Yakın gösterici (ev-set):

| | Yalın | Eğik |
|---|---|---|
| 3.tek.eril | `ev` | `vî` |
| 3.tek.dişil | `ev` | `vê` |
| 3.çoğ. | `ev` | `van` |

### 5.2 ≥15 doğru-yanlış örneği

| BAD | OK | Açıklama |
|---|---|---|
| `Ez tu dibînim` | `Ez te dibînim` | Direct object oblique |
| `Ez ew dibînim` | `Ez wî/wê dibînim` | Eril/dişil ayrımı |
| `Tu min dibîne` | `Tu min dibînî` | Şahıs ekiğin: 2.tek. = `-î` (kısa î) |
| `Ew em dibîne` | `Ew me dibîne` | Direct object oblique |
| `Bi min re` | OK | OK |
| `Ji ez` | `Ji min` | Eğik |
| `Min ez dît` | `Te ez dîtî` | Geçmiş geçişli — agent oblique olmalı |
| `Min tu dîtim` | `Min tu dîtî` | Patient ile uyum: `tu` 2.tek. → `-î` |
| `Te wan dît` | `Te ew dît(in)` | Patient yalın olmalı; `wan` agent |
| `Min wê dît` | OK | "Onu (dişil) gördüm" — patient `wê` zaten eğikse: `Min ew dît` (yalın); `Min wê dît` ise "wê"yi eğik direct object olarak okur — bağlam |
| `hûn(un)` | `hûn` | "siz" — bir n |
| `huyn` | `hûn` | yanlış imlâ |
| `wez/Ez ê` | OK (`ê` ayrı yazılır) | gelecek partikeli |
| `weê` | `we ê` | gelecek partikeli ayrı yazılır |
| `Ezje` | `Ez ê` | `ê` ayrı yazılır |
| `tê û here` | `tu yê here` veya `tê here` | 2.tek. gelecek: `tu yê` veya büzülmüş `tê` |

### 5.3 Refleksif zamir `xwe` (Thackston §7.1)

`xwe` kişi/sayı taşımaz — fiilin öznesinden alır:
- "Kendi kitabımı okuyorum": `Ez kitêba xwe dixwînim`
- "Kendi evine gitti": `Ew çû mala xwe`
- "Etrafıma bakıyorum": `Li dora xwe dinêrim`

[Linter pattern] (yanlış: özneye ait zamir kullanılmış):
```
Eğer fiil öznesi 1.şahısta ise, NP içindeki "min" şüpheli — `xwe` olabilir.
```
(Anlamsal — basit regex zor; örnek-tabanlı.)

### 5.4 Gelecek zaman partikeli `ê` / `dê` — AYRI YAZILIR

Gelecek zaman, özne + `ê` (veya tam form `dê`) + present subjunctive ile kurulur (B-L §175, Thackston §16.2). **Partikel ZAMİRLE BİRLEŞMEZ**, ayrı yazılır:

| BAD (birleşik) | OK (ayrı) |
|---|---|
| `Ezê herim` | `Ez ê herim` veya `Ez dê herim` |
| `tuê here` | `Tu yê here` (bağlantı `y`) veya `Tê here` (büzülme) |
| `ewê here` | `Ew ê here` veya büzülmüş `Wê here` |
| `emê herin` | `Em ê herin` veya `Em dê herin` |
| `hûnê herin` | `Hûn ê herin` |
| `wanê here` | `Wan ê here` (özne ad) |

> **Kural (Thackston):** "When the subject of a future-tense verb is a noun, **wê, ê, or dê comes after the noun**." Partikel kelimedi DEĞİLDİR.

[Linter pattern] (özne + `ê` birleşmiş):
```regex
\b(ez|tu|ew|em|hûn|hun|wan)ê\b
```
Replacement: `\1 ê`

[Linter pattern] (özne + `dê` birleşmiş):
```regex
\b(ez|tu|ew|em|hûn|hun|wan)dê\b
```
Replacement: `\1 dê`

### 5.5 Şahıs sonekleri — aşırı sık geçen hata

**Present (geniş zaman) ekler** (B-L §180):

| Şahıs | Ek |
|---|---|
| 1.tek. | `-im` |
| 2.tek. | `-î` |
| 3.tek. | `-e` |
| 1.çoğ. | `-in` |
| 2.çoğ. | `-in` |
| 3.çoğ. | `-in` |

| BAD | OK |
|---|---|
| `Ez dibîne` | `Ez dibînim` |
| `Tu dibîne` | `Tu dibînî` |
| `Ew dibînim` | `Ew dibîne` |
| `Em dibîne` | `Em dibînin` |
| `Tu dibîni` (kısa i) | `Tu dibînî` (uzun î) |

**Geçmiş (intransitive) ekler** (Thackston §18):

| Şahıs | Sonra konsonan | Sonra sesli |
|---|---|---|
| 1.tek. | `-im` | `-m` |
| 2.tek. | `-î` | `-yî` |
| 3.tek. | `-` (çıplak kök) | `-` |
| 1.çoğ. | `-in` | `-n` |
| 2.çoğ. | `-in` | `-n` |
| 3.çoğ. | `-in` | `-n` |

| BAD | OK |
|---|---|
| `Ez hatîm` | `Ez hatim` |
| `Tu hat` | `Tu hatî` |
| `Ew hatim` | `Ew hat` |
| `Em hatim` | `Em hatin` |
| `Hûn hat` | `Hûn hatin` |

[Linter pattern] (şahıs eksikliği — örnek):
```regex
\b(?:ez)\s+(?:di|na|ne)?\w+(?:e|ê|în|ne|i)\b
```
(Heuristic — verb-ending tablosu ile kontrol edilmeli; basit regex'ten çok lemma-tablosu gerekir.)

---

## 6. FİİL ÇEKİMİ — ESPECIALLY ERGATIVITY

### 6.1 Genel zaman düzenleri

Kurmancî fiil zamanları üç gruba ayrılır (B-L §141 vd.):

1. **I. Grup (Geçmiş tabanı):** simple past (di'li geçmiş), past habitual, perfect, pluperfect, past subjunctive.
2. **II. Grup (Birleşik geçmiş):** anterior future, conditional perfect.
3. **III. Grup (Geniş zaman tabanı):** imperative, present indicative, future, present subjunctive.

### 6.2 Split ergativity (Thackston §18.2 — KRİTİK)

Geçmiş zamanda **geçişli** fiil:
- **Agent (mantıksal özne)** → eğik hâlde
- **Patient (mantıksal nesne)** → yalın hâlde
- **Fiil**, patient ile şahıs/sayı uyumu yapar.

Bu şimdiki zamanın **TAM TERSİDİR**.

| Şimdiki (transitive) | Geçmiş (transitive — ergative) |
|---|---|
| `Ez wî dibînim` (Onu görüyorum) | `Min ew dît` (Onu gördüm) |
| `Tu min dibînî` (Beni görüyorsun) | `Te ez dîtim` (Beni gördün) |
| `Ew me dibîne` (Bizi görüyor) | `Wî em dîtin` (Bizi gördü) |
| `Em wan dibînin` (Onları görüyoruz) | `Me ew dîtin` (Onları gördük) |

**KRİTİK HATA — Türkçe etkisi:**

| BAD (Türkçe etkisi) | OK |
|---|---|
| `Ez wî dît` | `Min ew dît` |
| `Tu min dît` | `Te ez dîtim` |
| `Ew kitêbê xwand` | `Wî kitêb xwand` |
| `Min ez kuştim` | `Min xwe kuşt` (refleksif) |
| `Min jinê dît` | `Min jin dît` (patient yalın) |
| `Min wî dît` | `Min ew dît` (3.tek. eril yalın `ew`) |
| `Ez kitêbê xwand` | `Min kitêb xwand` (geçmişte) |
| `Min mirov gotin` | `Min mirov got` (3.tek. patient → `got`) |
| `Te jin dîtî` | `Te jin dît` (3.tek. patient → çıplak kök) |

### 6.3 ≥10 sık fiil çekim hatası

| BAD | OK | Açıklama |
|---|---|---|
| `Min got û tu got` | `Min got û te got` | Te, geçişli geçmiş için eğik gerek |
| `Ez wê dît` | `Min ew dît` | Şimdiki/geçmiş çatışması |
| `Tu hatîm` | `Tu hatî` | hatin geçişsiz; `-î` 2.tek. |
| `Ez gotim` | `Min got` | gotin geçişli — agent eğik |
| `Em geriyam` | `Em geriyan` | 1.çoğ. → `-n` (sesliden sonra) |
| `Ez li wir bûm` | OK (geçişsiz) | `bûn` "olmak" |
| `Ez nedixwendim` | OK | Olumsuz past habitual |
| `Ez nadixwînim` | `Ez naxwînim` | Olumsuz şimdiki: `na-` di-'siz |
| `Ez na bibînim` | `Ez nabînim` | Olumsuz şimdiki = `na-` + present stem (di- kalkar) |
| `Ez bi xwendim` | `Ez bixwînim` | Subjunctive: `bi-` + present stem |
| `Min ne got` | `Min negot` | Olumsuz geçmiş: `ne-` bitişik |
| `Min na got` | `Min negot` | `na-` şimdiki içindir |
| `Tê here / Tu yê here` | OK; örn. `Hûn ê herin` | Gelecek partikeli ayrı |
| `Ez nikare` | `Ez nikarim` | `karîn` 1.tek. = `-im` (di-siz) |
| `Ez dixwazî herim` | `Ez dixwazim herim` | xwestin 1.tek. → `-im` |

### 6.4 Yardımcı fiiller

Sık kullanılan yardımcı fiiller:
- `bûn` (olmak) — present stem `-b-`
- `kirin` (yapmak) — present stem `-k-` → imperative `bike`
- `dan` (vermek) — present stem `-d-` → imperative `bide`
- `hatin` (gelmek) — present stem `-ê-` → imperative `were`
- `çûn` (gitmek) — present stem `-ç-` → imperative `here`
- `xwestin` (istemek) — present stem `xwaz-`
- `karîn`/`kanîn` (-ebilmek) — present stem `kar-` (di-siz çekilir)
- `zanîn` (bilmek) — present stem `zan-` (di-siz çekilir)

### 6.5 Olumsuzluk

| Zaman | Olumsuz prefiks |
|---|---|
| Present indicative (di-) | `na-` (di- yerine) |
| Present subjunctive (bi-) | `ne-` (bi- yerine) |
| Imperative | `ne-` (bi- yerine) |
| Past tenses | `ne-` (kelime başına) |
| Past habitual (di-) | `ne-di-` (di- ile birlikte) |
| Auxiliary `karîn`, `zanîn` | `ni-` |

[Linter pattern] (`na` + `bi-` gereksiz):
```regex
\bna\s*bi-?\w+\b
```

[Linter pattern] (olumsuz geçmiş ayrılmış):
```regex
\bne\s+(?:got|hat|çû|kir|da|dît|xwand)\b
```
Replacement: `ne` + verb birleşik.

---

## 7. KELİME OLUŞUMU VE BİRLEŞİK İMLÂ

### 7.1 Genel kural — birleşik vs. ayrı

Kurmancî'de bileşiklerin yazılışı (B-L §192-194):

**Tip 1 (close compound):** Önek + mastar — **bitişik yazılır**.
- `rabûn` (kalkmak) ← ra + bûn
- `vexwarin` (içmek) ← ve + xwarin
- `dagirtin` (doldurmak) ← da + girtin
- `hilgirtin` (yukarı kaldırmak)
- `hildan` (kaldırmak)
- `hilanîn` (yukarı çıkarmak)
- `dakirin` (indirmek)
- `derketin` (çıkmak)
- `derxistin` (çıkarmak)
- `werkirin` (giymek)

**Tip 2 (open compound):** Ad/sıfat + mastar — **ayrı yazılır**.
- `dest pê kirin` (başlamak)
- `xwe kirin` (kendini yapmak)
- `lîstik kirin` (oyun oynamak)
- `cih girtin` (yer almak)
- `bi cih anîn` (yerine getirmek)
- `pêwendî danîn` (irtibat kurmak)

**Tip 3 (öneksiz birleşik):** Önek+zamir kasınması (B-L §193b)
- `lê xistin` (vurmak) ← li + wê + xistin
- `pê ketin` (tutuşmak) ← bi + wê + ketin
- `jê kirin` (kesmek) ← ji + wê + kirin
- `tê xistin` (sokmak) ← di + wê + xistin

### 7.2 ≥10 doğru-yanlış birleşik örneği

| BAD | OK | Açıklama |
|---|---|---|
| `destpê kirin` | `dest pê kirin` | Tip 2 — ayrı (Lescot §194) |
| `dest pêkirin` | `dest pê kirin` | Üç ayrı kelime |
| `bi xêr hatî` | OK | "Hoş geldin" — ayrı |
| `xêrhatî` | OK alternative | "Hoşgeldin" sıfat-form, bitişik |
| `liber` | `li ber` | Edat birleşmez |
| `liser` | `li ser` | "üzerinde" — ayrı |
| `jiber ku` | `ji ber ku` | "çünkü" — ayrı (3 sözcük) |
| `jibo` | `ji bo` | "için" — ayrı |
| `digel ku` | OK | "rağmen" — `digel` tek kelime, `ku` ayrı |
| `dibîn` | `di bîn` (bağlam) veya `dibîne` | `dibîn` 1.çoğ. olabilir, sözlük lookup |
| `bicih kirin` | `bi cih kirin` | "yerleştirmek" |
| `bicihanîn` | `bi cih anîn` | "yerine getirmek" |
| `xêrnedîtin` | `xêr nedîtin` | Olumsuz |
| `Davaijin/davêjin` | `davêjin` | "atıyorlar" — birleşik fiil av- + êj- |
| `derxe` | OK | imperative `derxistin` |
| `der xe` | `derxe` | imperative bitişik |
| `Pêkve` | `pêk ve` veya `pêkve` (hareket bağı) | bağlama göre |
| `Lê belê` | OK | "ama, fakat" |
| `lêbelê` | `lê belê` | İki sözcük |
| `xwedê | OK | Allah |
| `xwe dê` | `xwedê` | bitişik |

### 7.3 Edatların bileşik olmaması

Aşağıdaki edatlar her zaman ayrı yazılır:

| BAD | OK |
|---|---|
| `lihev` | `li hev` |
| `liber` | `li ber` |
| `liser` | `li ser` |
| `lipê` | `li pê` veya `li pê (s)` |
| `jibal` | `ji bal` |
| `jibo` | `ji bo` |
| `jibona` | `ji bona` |
| `jiber` | `ji ber` |
| `jinav` | `ji nav` |
| `dinav` | `di nav` |
| `dibareya` | `di bareya` |
| `linav` | `li nav` |

[Linter pattern] (birleşik edat hatası):
```regex
\b(li|ji|di|bi)(ber|ser|bin|nav|hev|gel|cih|bal|bo|bona|bareya|navbera|gor[aê]|dij[ê]|pey|cem|rex)\b
```
Replacement: `\1 \2`

### 7.4 Birleşik sıfat/zarf

| BAD | OK | Açıklama |
|---|---|---|
| `bi rast` | `birastî` veya `bi rastî` | "doğrusu" (bağlama göre) |
| `bi xêr` | `bi xêr` | "Hoş, hayırlı" (içeren bileşikler içinde varır) |
| `bi hêz` | `bi hêz` | "güçlü" sıfat |
| `pir biha` | OK | "çok pahalı" — sıfat tamlaması |
| `pirbiha` | `pir biha` | iki sözcük |
| `gelek baş` | OK | "çok iyi" |
| `gelekbaş` | `gelek baş` | iki sözcük |

---

## 8. TÜRKÇE ETKİSİ — KALKES VE ÖDÜNÇ HATALARI

### 8.1 Sık karşılaşılan kalkes ve ödünç hataları

| BAD (Türkçe etkisi) | OK (Kurmancî) | Açıklama |
|---|---|---|
| `ki` (subordinator) | `ku` | "ki" Türkçe; Kurmancî `ku` |
| `bir` (1 sayısı) | `yek` | Türkçe sayı |
| `iki` | `du` veya `didu` | Türkçe sayı |
| `tane` (sınıflayıcı) | `lib` veya `heb` | "x adet" → `x heb` |
| `ders` (Arabic→Tr→Kr) | `wane` veya `ders` | `wane` daha öz; `ders` kabul edilir |
| `ekîp` | `tîm` veya `koma X` | Frans→Tr→Kr |
| `grup` | `kom` | bkz. yukarı |
| `okul` | `dibistan` veya `xwendegeh` | |
| `kitap` (Tr) | `kitêb` veya `pirtûk` | `pirtûk` daha öz |
| `kitap` | `pirtûk` veya `kitêb` | her ikisi de kabul |
| `bilgisayar` | `kombers`, `komputûr` | hibrit; her ikisi geçerli |
| `meslek` (Ar→Tr) | `pîşe` | öz Kurmancî |
| `kavram` | `têgeh`, `têgih` | öz Kurmancî |
| `madde` (Ar) | `made` veya `bend` | bağlama göre |
| `arkadaş` | `heval` | öz |
| `merhaba` | `merheba` veya `silav` | her ikisi geçerli |
| `affedersin` | `biborîne` | direkt çeviri yok; Kurmancî öz |
| `lütfen` | `ji kerema xwe` | tam çeviri uzun |
| `evet` | `erê` veya `belê` | iki seçenek; bölgesel |
| `hayır` | `na` veya `nexêr` | |
| `efendim` | `camêr`, `kek` (M); `xanim`, `sitî` (F) | |
| `bayan` | `xanim` | hanım |
| `bayan (bekar)` | `banî`, `sitî` | |
| `bay` (efendi) | `camêr`, `mîrza` | |
| `iş` | `kar` veya `xebat` | her ikisi de geçerli; `kar` daha sık |
| `iş yapma` | `kar kirin` | |
| `evlilik` | `zewac` veya `mêrkirin/jinanîn` | |
| `araba` | `erebe` veya `tirimbêl` | her ikisi |
| `sendika` | `sendîka` | |
| `iletişim` | `pêwendî` veya `gihandin` | |
| `sosyal` | `civakî` | öz |
| `bilim` | `zanîn`, `zanist` | |
| `bilimsel` | `zanistî` | |
| `dikkat et` | `bala xwe bide` veya `hay ji xwe hebe` | |
| `tabii ki` | `helbet` veya `bê guman` | |
| `ekonomi` | `aborî` | öz Kurmancî |
| `çünkü` (subordinator) | `ji ber ku` veya `lewre (ku)` | |
| `bu yüzden` | `loma`, `lewma`, `ji ber wê yekê` | |
| `belki` | `belkî`, `dibe ku` | |
| `gelecek` | `paşeroj`, `dahatî` | öz |
| `geçmiş` | `paşeroj`* (yanlış!), `derbasbûyî`, `borî`, `rabirdû` | "paşeroj" gelecektir; geçmiş için `borî` |

> **Cite:** Aslanoğlu p. 8 ve sonrası; Fêrker ders 1-14; B-L §III "Yabancı Kelimeler".

### 8.2 ≥15 sık karışıklık

| Türkçe sözcük | Yanlış kullanım | Doğru Kurmancî |
|---|---|---|
| ki (bağlaç) | `Min got ki ew tê` | `Min got ku ew tê` |
| ama | `Ez ji wir hatim ama wê neçû` | `Ez ji wir hatim lê wê neçû` (`lê` ya da `lê belê`) |
| veya | `nan veya av` | `nan an av` |
| da/de (Tr emphatic) | `Ez da diçim` | `Ez jî diçim` (`jî` Kurmancî vurgu) |
| -lik (Türkçe abstract) | `mamostelik` | `mamostetî` veya `mamosteyî` |
| -lı/-li (sıfat eki) | `parali` | `bi pere` |
| dan-den (ablative) | `evden` | `ji malê` |
| -e/-a (dative) | `eve geliyor` | `tê malê` (`-ê` oblique zaten) |
| sonra | `pir sonra` | `pir paşê` veya `dûv re` |
| önce | `önce ez gotim` | `berê ez got(im)` veya `pêşî` |
| bazen | `bazen ez tê(m)` | `carinan ez têm` |
| şimdi | `şimdi ez diçim` | `niha ez diçim` |
| bugün | `bugün hava güzel` | `îro hewa xweş e` |
| yarın | `yarın geliyor` | `sibe tê` |
| kimse | `kimse nayê` | `kes nayê` |
| hiçbir | `hiçbir ders` | `tu wane` veya `ti wane` |

### 8.3 Sayı sistemi farkları

| Yanlış (Tr-tarzı) | Doğru |
|---|---|
| `bir adam` | `mirovek` (`-ek` belirsiz) veya `yek mirov` |
| `iki kitap` | `du kitêb` (sözcük çoğul gibi davranır ama -an oblique'te) |
| `pênc deh` | `pêncî` (50) |
| `dewam ji` | `dewam ji` (kabul) ya da `domandin` (devam etmek) |
| `tane` (Türkçe sınıflayıcı) | `heb` veya `lib` |
| `iki tane elma` | `du heb sêv` veya `du sêv` |

[Linter pattern] (Türkçe `ki` subordinator):
```regex
\bki\b(?=\s)
```
(Bağlam: `ku` olmalı; manuel verify gerek.)

[Linter pattern] (Türkçe `ama`):
```regex
\bama\b
```
Replacement suggestion: `lê` veya `lê belê`

---

## 9. NOKTALAMA VE BÜYÜK HARF

### 9.1 Cümle başı / nokta

Kurmancî, Latin alfabesinin standart noktalama kurallarını izler:
- Cümle nokta `.` ile biter; soru `?`; ünlem `!`.
- Virgül `,` listelerde ve birleşik cümlelerde.
- Tırnak: `« »` (Fransız tarzı, geleneksel) veya düz `" "` (modern).

### 9.2 Büyük harf kuralları

**Büyük harfle başlar:**
- Cümle başı.
- Özel adlar (kişi, yer, kurum): `Celadet`, `Diyarbekir`, `Tirkiye`, `Kurdistan`, `Hawar`.
- Dil/halk adları: `Kurd`, `Kurdî`, `Tirk`, `Tirkî` (B-L kullanımı).
- Kurum adları: `Enstîtuya Kurdî`, `Civata Heyva Sor`.
- Ay adları: `Adar`, `Nîsan`, `Gulan` (geleneksel olarak).
- Gün adları: `Yekşem`, `Duşem` (belirgin değil — küçük de yazılabilir).

**Küçük harfle:**
- Ortak adlar (`mirov`, `mal`, `nan`).
- Yer/zaman zarfları (`îro`, `sibe`, `du`).

### 9.3 Loanword imlâsı

Modern Latin loanword'leri `î` veya yabancı imlâ ile alınabilir:

| BAD | OK |
|---|---|
| `internet` (loanword) | `Înternet` veya `înternet` (cümle bağlam) |
| `telefon` | `telefon` (kabul) |
| `telefonkartî` | `qerta telefonê` |
| `kredi karti` | `qerta krediyê` |

Türkçe-eklemeli imlâ kabul edilmez (örn. `internet'i`, `telefon'da`):

[Linter pattern] (Türkçe apostroflu ek):
```regex
\b\w+'\w+\b
```
(False positive: contraction. İçeriğe bakılması gerekli.)

---

## 10. SIK YANLIŞ YAZILAN KELİMELER (≥40)

Aşağıdaki tablo, `tools/qa/refs/*.txt` referanslarında belgelenmiş, lutkê öğrenme içeriğinde sık karşılaşılan yazım hatalarını listeler. Her satır linter tarafından otomatik düzeltme önerisi olarak kullanılabilir.

| Kanonik (OK) | Yanlış varyantlar (BAD) | TR | Kaynak |
|---|---|---|---|
| `spas` | `sipas`, `sîpas`, `spass` | teşekkür | Aslanoğlu p. 14, 16; Fêrker s. 18; B-L; **`sipas` bazı yazarlarca kabul** |
| `xwedê` | `xudê`, `xudê`, `xude`, `xweda` | Tanrı, Allah | Fêrker s. 20; Bedirxan |
| `xweş` | `xeş`, `xuş`, `xoş` | hoş, güzel | B-L §30 |
| `xwişk` | `xuşk`, `xueh`, `xeşk`, `xweh` (alt) | kız kardeş | B-L; Aslanoğlu p. 31 (xweng) |
| `xwendin` | `xundin`, `xandin`, `xwandin`*  | okumak | B-L; *xwandin bölgesel kabul |
| `xwendekar` | `xwendkar`, `xandekar`, `xundekar` | öğrenci | Fêrker s. 12 |
| `pirtûk` | `pirtuk`, `pırtuk`, `pîrtûk` | kitap | Fêrker s. 14, 24; Aslanoğlu |
| `kitêb` | `kitap`, `kitab`, `kitêp` | kitap (Ar.→) | her ikisi kabul; `pirtûk` daha öz |
| `mamoste` | `mamosta`, `mamostey`, `mamostî` | öğretmen | Fêrker; Aslanoğlu |
| `dibistan` | `debistan` (eski), `dibîstan` | okul | B-L; modern: dibistan |
| `xwendegeh` | `xandegeh`, `xundegeh` | okul (alt.) | Aslanoğlu p. 33 |
| `zanîngeh` | `zanîngah`, `zanîngeh`*, `zaningeh` | üniversite | Aslanoğlu p. 35 |
| `nan` | `nên`, `naan` | ekmek | B-L; her yer |
| `av` | `aw` (bölgesel — Doğu) | su | B-L §25; *standartda `av` |
| `êvar` | `êvarê` (yalın), `evar`, `iwar` | akşam | Aslanoğlu p. 17 (mesai zamanı) |
| `roj` | `rûj`, `ruz`, `rîj` | gün | B-L; Aslanoğlu p. 28 |
| `şev` | `shev`, `sev` | gece | B-L; Aslanoğlu p. 28 |
| `îro` | `iro`, `ırö`, `îrö` | bugün | Aslanoğlu p. 28 |
| `sibe` | `sibah`, `sıbe`, `subê` | yarın; sabah | Aslanoğlu p. 28; **`sibeh` "sabah", `sibe` "yarın" — ayrı kelimeler** |
| `duh`, `do` | `dün`, `düh` | dün | Aslanoğlu p. 28 |
| `niha` | `niho`, `nuha`, `nıha` | şimdi | Aslanoğlu p. 28 |
| `pêncî` | `pênc deh` (yanlış), `penci` | 50 | Aslanoğlu p. 4 |
| `şêst` | `şest`*, `şîşt` | 60 | Aslanoğlu p. 4 |
| `heftê` | `hefte` (yanlış — bu hafta), `heftî` | 70 | Aslanoğlu p. 4 |
| `heştê` | `hesté`, `heşti` | 80 | Aslanoğlu p. 4 |
| `nod` | `nodê`, `nawd` | 90 | Aslanoğlu p. 4 |
| `sed` | `sad`, `cêd` | 100 | Aslanoğlu p. 4 |
| `hezar` | `hîzar`, `hesar` | 1000 | Aslanoğlu p. 4 |
| `kurê min` | `kura min` (eril karışıklığı) | oğlum | B-L §99 |
| `keça min` | `keça min`*, `keçê min` | kızım (dişil) | B-L |
| `bavê min` | `bave min`, `bavî min` | babam | B-L |
| `dayika min` | `dêya min` (alt.), `daike min` | annem | B-L |
| `bavê min e` | `bavê min ye` (yanlış — kons. sonrası `e`) | "babam" cümle | B-L "isim cümlesi" §; **`-e` konsondan sonra, `-ye` selden sonra** |
| `mala min e` | `mala min ye` | "evimdir" | A>e (sesli) sonrası `ye`... istisnai; sözlük gerek |
| `welat` | `welêt` (oblique), `welêt min` (yanlış nominative) | vatan | B-L §115 |
| `bajar` | `bajêr` (oblique), `becer` (yanlış) | şehir | B-L §115 |
| `pêwendî` | `pewendi`, `pêwendi` | irtibat, ilişki | Fêrker; B-L |
| `hêvî` | `hivî`, `hewi`, `hîvî` | umut | B-L; Fêrker |
| `dîtin` | `dıtin`, `dîten`, `ditin` | görmek | B-L; her yer |
| `gotin` | `gutin`, `gotîn` | söylemek | B-L; her yer |
| `kirin` | `kırın`, `kirîn` | yapmak | B-L |
| `bûn` | `bun`, `bûne` (perfect form) | olmak (mastar) | B-L |
| `çûn` | `çun`, `çuyîn` | gitmek | B-L |
| `axaftin` | `axaftin`*, `axaftin`, `axiftin` | konuşmak | B-L; her yer |
| `peyivîn`/`peyvîn` | `peyivin`, `peyîvîn` | konuşmak | Fêrker |
| `şanî dan` veya `nîşan dan` | `şanî da` (preterit) | göstermek | B-L |
| `bersiv` | `bersıv`, `bersiv*`, `bersiv` | cevap | Aslanoğlu p. 33 |
| `pirs` | `pırs`, `pirss` | soru | Aslanoğlu p. 33 |
| `daxistin` | `daxiştin`, `daxınmak` | indirmek | B-L |
| `hilkişin`/`hilkiş(an/în)` | `hıl kişın` | tırmanmak | B-L |
| `hez kirin` | `hezkirin` | sevmek | B-L; ayrı yazılır |
| `hez ji X kirin` | `ez ji te hezdikim` (birleşik yanlış) | ben seni seviyorum | Aslanoğlu p. 19; "Ez ji te hez dikim" |
| `rastî hatin` veya `rastî kesekî hatin` | `raş hatin`* | rastlamak | B-L |
| `wext` | `weht`, `wax`, `vext` | vakit | B-L; Tr/Fars ödünç |
| `çawa` | `çawan` (alt.), `çava` | nasıl | B-L; `çawan` Doğu ağzı |
| `çima` | `çıma`, `çumı`, `çême` | niçin | B-L |
| `kîjan` | `kıjan`, `kîjin` | hangi | B-L |
| `çend` | `çand`, `çen`, `çendê` | kaç, ne kadar | Aslanoğlu p. 14 |
| `gelek` | `gélek`, `galak` | çok | Aslanoğlu p. 18 |
| `pir` | `pır` | çok | her yer |
| `hindik` | `hindîk`, `hîndik`, `hindek` | az, biraz | Aslanoğlu p. 16 |
| `şîr` | `şir` (yanlış), `çîr` | süt; kılıç | B-L |
| `sêv` | `sév`, `seyv`, `sêw` | elma | Fêrker |

[Linter pattern] (örnek otomatik düzeltme listesi):
```python
COMMON_MISSPELLINGS = {
    'sîpas': 'spas',
    'xudê': 'xwedê',
    'xude': 'xwedê',
    'xweda': 'xwedê',
    'xeş': 'xweş',
    'xuş': 'xweş',
    'xoş': 'xweş',
    'xuşk': 'xwişk',
    'xandin': 'xwendin',
    'xundin': 'xwendin',
    'pirtuk': 'pirtûk',
    'pırtuk': 'pirtûk',
    'mamostey': 'mamoste',
    'mamosta': 'mamoste',
    'rûj': 'roj',
    'shev': 'şev',
    'iro': 'îro',
    'pênc deh': 'pêncî',
    'penci': 'pêncî',
    'şest': 'şêst',
    'aw': 'av',
    'kıjan': 'kîjan',
    'çıma': 'çima',
    'çıvı': 'çawa',
    'hıl kişın': 'hilkişîn',
    'hezkirin': 'hez kirin',
    'cıwan': 'ciwan',
    'kjt': 'kîjan',
    # ... vb. extend dictionary
}
```

---

## 11. KANONİK KELİME LİSTESİ (≥150 KELİME)

Aşağıdaki tablo, Lutkê öğrenme platformu için en sık kullanılan 150+ Kurmancî kelimenin kanonik yazılışıdır. Yazımda hata varsa linter bu tabloyu lookup olarak kullanmalı.

| Kurmancî | TR | Cins | Yaygın yanlış | Kaynak |
|---|---|---|---|---|
| ez | ben | — | — | B-L; Thackston §7 |
| tu | sen | — | — | B-L |
| ew | o (kişi/işaret) | — | — | B-L |
| em | biz | — | — | B-L |
| hûn | siz | — | hun (alt.) | B-L; Thackston |
| min | benim, beni | — | mîn (yanlış) | B-L |
| te | senin, seni | — | — | B-L |
| wî | onun (eril) | — | wê (dişil) ile karış. | B-L |
| wê | onun (dişil) | — | — | B-L |
| me | bizim, bizi | — | — | B-L |
| we | sizin, sizi | — | — | B-L |
| wan | onların | — | — | B-L |
| xwe | kendi | — | xu, xve (yanlış) | B-L §189 |
| xwedê | Allah, Tanrı | M | xudê, xeda | B-L; Fêrker s. 20 |
| mirov | adam, insan | M | merov (alt.) | B-L; Fêrker |
| jin | kadın | F | — | B-L; Aslanoğlu |
| zilam | adam (M) | M | zîlam | Fêrker s. 19 |
| keç | kız | F | — | Fêrker |
| kur | oğlan, oğul | M | — | Fêrker |
| zarok | çocuk | M/F | — | Fêrker |
| heval | arkadaş | M/F | — | Aslanoğlu |
| dost | dost | M/F | — | her yer |
| bav | baba | M | — | B-L; Aslanoğlu |
| dê / dayik | anne | F | dê (alt.) | B-L; Aslanoğlu p. 31 |
| bira | erkek kardeş | M | — | Aslanoğlu p. 31 |
| xwişk | kız kardeş | F | xuşk, xweng (alt.) | Aslanoğlu p. 31 |
| xwarzî | yeğen (kız tarafı) | M/F | — | B-L |
| brazî | yeğen (erkek tarafı) | M/F | — | B-L |
| ap / mam | amca | M | — | B-L; Aslanoğlu |
| xal | dayı | M | — | Aslanoğlu p. 31 |
| met | hala | F | — | B-L |
| xaltî | teyze | F | — | Aslanoğlu |
| amojin | yenge | F | — | Aslanoğlu |
| pîrik / dapîr | büyükanne | F | — | Aslanoğlu p. 31 |
| bapîr / kalik | büyükbaba | M | — | Aslanoğlu p. 31 |
| zava | damat | M | — | B-L; Aslanoğlu |
| bûk | gelin | F | — | Aslanoğlu p. 31 |
| nevî | torun | M/F | — | Aslanoğlu p. 31 |
| mêr | erkek; koca | M | — | her yer |
| pîr | yaşlı (kadın) | F | — | B-L |
| kal | yaşlı (erkek) | M | kalo (vocative) | B-L |
| ciwan | genç; güzel | sıfat | cwan, cıwan | Aslanoğlu p. 19 |
| mal | ev | F | — | B-L |
| xanî | ev, bina | M | xani (kısa) | B-L §123 |
| oda | oda | F | ode (alt.) | Thackston |
| derî | kapı | M | dêri | Thackston |
| pace / pencere | pencere | F | pace (alt.) | Fêrker |
| mase | masa | F | masa (Tr→) | Thackston |
| sekû / kursî | sandalye | F | — | Thackston; Aslanoğlu |
| nan | ekmek | M | nên (yanlış) | B-L |
| av | su | F | aw (Doğu) | B-L |
| şîr | süt | M | şir (yanlış) | B-L |
| dew | ayran | M | — | B-L |
| goşt | et | M | gocet, gost | her yer |
| sêv | elma | F | sev (yanlış) | B-L; Fêrker |
| tirî | üzüm | M | — | B-L |
| nan | ekmek | M | — | B-L |
| sal | yıl | F | — | Aslanoğlu p. 28 |
| meh | ay | F | mah (yanlış) | Aslanoğlu p. 28 |
| roj | gün | F | rûj | B-L; Aslanoğlu p. 28 |
| şev | gece | F | shev | B-L |
| sibe | yarın | F | sıbe | Aslanoğlu p. 28 |
| sibeh | sabah | F | sıbah | Aslanoğlu (ayrı kelime) |
| niha | şimdi | zarf | niho, nuha | Aslanoğlu p. 28 |
| îro | bugün | zarf | iro | Aslanoğlu p. 28 |
| do / duh | dün | zarf | dün (Tr) | Aslanoğlu p. 28 |
| îsal | bu yıl | zarf | isal | B-L |
| par | geçen yıl | zarf | — | B-L |
| sal | yıl | F | — | her yer |
| dem | zaman | F | — | Fêrker |
| wext | zaman, vakit | M | weht, vext | her yer |
| saet / demjimêr | saat | F | — | Aslanoğlu p. 28 |
| kêlîk / deqîqe | dakika | F | — | Aslanoğlu p. 28 |
| çirk / saniye | saniye | F | — | Aslanoğlu p. 28 |
| hefte | hafta | F | — | Aslanoğlu p. 28 |
| pêşeroj / dahatî | gelecek | F | — | Aslanoğlu p. 28 |
| paşeroj / rabirdû | geçmiş | F | — | Aslanoğlu p. 28 (NOT: bu söz iki anlama gelir, dikkat) |
| Yekşem | Pazar | F | — | Aslanoğlu p. 28 |
| Duşem | Pazartesi | F | — | Aslanoğlu p. 28 |
| Sêşem | Salı | F | — | Aslanoğlu |
| Çarşem | Çarşamba | F | — | Aslanoğlu |
| Pêncşem | Perşembe | F | — | Aslanoğlu |
| În | Cuma | F | — | Aslanoğlu p. 28 |
| Şemî | Cumartesi | F | — | Aslanoğlu p. 28 |
| Çile / Rêbendan | Ocak | F | — | Aslanoğlu p. 28 |
| Sibat / Reşemî | Şubat | F | — | Aslanoğlu p. 28 |
| Adar | Mart | F | — | Aslanoğlu p. 28 |
| Nîsan / Avrêl | Nisan | F | — | Aslanoğlu |
| Gulan | Mayıs | F | — | Aslanoğlu |
| Hezîran / Pûşper | Haziran | F | — | Aslanoğlu |
| Tîrmeh | Temmuz | F | — | Aslanoğlu p. 29 |
| Tebax / Gelawêj | Ağustos | F | — | Aslanoğlu p. 29 |
| Îlon / Rezber | Eylül | F | — | Aslanoğlu p. 29 |
| Cotmeh / Kewçêr | Ekim | F | — | Aslanoğlu p. 29 |
| Sermawez / Mijdar | Kasım | F | — | Aslanoğlu p. 29 |
| Kanûn / Berfanbar | Aralık | F | — | Aslanoğlu p. 29 |
| bihar | ilkbahar | F | — | Aslanoğlu p. 29 |
| havîn | yaz | M (B-L), F (Aslanoğlu) | havin | B-L; **cins iki kaynakta farklı!** |
| payîz | sonbahar | F | payiz | Aslanoğlu p. 29 |
| zivistan | kış | F | zivîstan | Aslanoğlu |
| reng | renk | M | — | Aslanoğlu p. 29 |
| spî | beyaz | sıfat | sıpı | Aslanoğlu p. 30 |
| reş | siyah | sıfat | reş, ras | Aslanoğlu |
| sor | kırmızı | sıfat | — | Aslanoğlu |
| zer | sarı | sıfat | — | Aslanoğlu |
| şîn | mavi | sıfat | shin | Aslanoğlu |
| kesk | yeşil | sıfat | — | Aslanoğlu |
| qehweyî | kahverengi | sıfat | — | Aslanoğlu |
| pembe | pembe | sıfat | — | Aslanoğlu |
| binevş | mor | sıfat | — | Aslanoğlu |
| gewr | gri | sıfat | — | Aslanoğlu |
| zêr / rengê zêr | altın rengi | sıfat | — | Aslanoğlu |
| zîv / rengê zîv | gümüş rengi | sıfat | zev (yanlış) | Aslanoğlu |
| dest | el | M | — | Aslanoğlu p. 36 |
| ling / pê | ayak; bacak | M | — | Aslanoğlu p. 36 |
| ser | baş; üst | M | sere (alt.) | her yer |
| dil | kalp | M | — | Aslanoğlu p. 36 |
| çav | göz | M | cav | Aslanoğlu p. 36 |
| dev | ağız | M | — | Aslanoğlu p. 36 |
| ziman | dil; lisan | M | zıman | Aslanoğlu p. 36 |
| dîran | diş | M | — | Aslanoğlu p. 36 |
| guh | kulak | M | — | Aslanoğlu p. 36 |
| poz | burun | M | poz (alt.) | Aslanoğlu p. 36 |
| por | saç | M | — | Aslanoğlu p. 36 |
| serî | baş, kafa | M | — | Aslanoğlu |
| yek | bir (1) | sayı | bir (Tr) | Aslanoğlu p. 4 |
| du / didu | iki (2) | sayı | iki (Tr) | Aslanoğlu p. 4 |
| sê / sisê | üç (3) | sayı | üç (Tr) | Aslanoğlu p. 4 |
| çar | dört (4) | sayı | car | Aslanoğlu |
| pênc | beş (5) | sayı | penc | Aslanoğlu |
| şeş | altı (6) | sayı | shesh | Aslanoğlu |
| heft | yedi (7) | sayı | heft | Aslanoğlu |
| heşt | sekiz (8) | sayı | hest | Aslanoğlu |
| neh | dokuz (9) | sayı | neh | Aslanoğlu |
| deh | on (10) | sayı | de | Aslanoğlu (de farklı kelime — "vermek" present stem) |
| yazdeh | onbir (11) | sayı | yanzdeh (alt.) | Aslanoğlu / Thackston |
| dozdeh / dwanzdeh | oniki (12) | sayı | onikî | Aslanoğlu / Thackston |
| sêzdeh | onüç (13) | sayı | — | Thackston |
| çardeh | ondört (14) | sayı | — | Thackston |
| pazdeh / panzdeh | onbeş (15) | sayı | — | Thackston |
| şazdeh / şanzdeh | onaltı (16) | sayı | — | Thackston |
| hivdeh | onyedi (17) | sayı | hevdeh (alt.) | Thackston |
| hijdeh | onsekiz (18) | sayı | — | Thackston |
| nozdeh | ondokuz (19) | sayı | — | Thackston |
| bîst | yirmi (20) | sayı | — | Aslanoğlu p. 4 |
| sî / sih | otuz (30) | sayı | sîh | Aslanoğlu / Thackston |
| çil / çel | kırk (40) | sayı | — | Aslanoğlu p. 4 |
| pêncî | elli (50) | sayı | pênc deh | Aslanoğlu |
| şêst | altmış (60) | sayı | şest | Aslanoğlu |
| heftê | yetmiş (70) | sayı | hefte (yanlış — bu hafta!) | Aslanoğlu |
| heştê | seksen (80) | sayı | — | Aslanoğlu |
| nod | doksan (90) | sayı | — | Aslanoğlu |
| sed | yüz (100) | sayı | — | Aslanoğlu |
| hezar | bin (1000) | sayı | hesar | Aslanoğlu |
| milyon | milyon | sayı | — | Aslanoğlu |
| ba | rüzgar | M | — | B-L |
| baran | yağmur | F | — | B-L |
| berf | kar | M (Doğu) / F | — | B-L |
| zivistan | kış | F | — | B-L |
| havîn | yaz | M / F | — | tartışmalı |
| ezman | gök | M | ezmên (oblique) | B-L |
| roj | güneş; gün | F | — | B-L |
| heyv | ay (gökcismi) | F | hêv (yanlış) | B-L |
| stêr | yıldız | F | stêrk (alt.) | her yer |
| hewa | hava | F | — | Aslanoğlu |
| genim | buğday | M | — | B-L |
| kew | keklik | M | — | B-L |
| hesp | at | M | — | B-L |
| mehîn | kısrak | F | — | B-L |
| ker | eşek; sağır | M | — | her yer |
| şêr | aslan; süt | M | şêr / şîr ayır | her yer |
| dêl | dişi köpek | F | — | her yer |
| seg / kûçik | köpek | M | — | Aslanoğlu |
| pisîk | kedi | M | pısık | Aslanoğlu |
| mar | yılan | M | — | her yer |
| masî | balık | M | — | her yer |
| cûcik | civciv | F | — | her yer |
| mirîşk | tavuk | F | — | B-L |
| dîk | horoz | M | — | B-L |
| beran | koç | M | berên (oblique) | B-L |
| berx | kuzu | M | — | B-L |
| bizin | keçi | F | — | B-L |
| mih | koyun (dişi) | F | — | B-L |
| mêş | sinek | F | mes | B-L |
| dar | ağaç | F | — | B-L |
| kulîlk | çiçek | F | — | her yer |
| gul | gül | F | gûl (yanlış) | her yer |
| zevî | tarla | F | zewi | her yer |
| daristan | orman | F | — | her yer |
| çiya | dağ | M | çya | her yer |
| çem | nehir | M | — | her yer |
| behr | deniz | F | — | B-L |
| gol | göl | F | gül (yanlış — Tr.) | B-L; Badillî |
| kanî | pınar | F | — | B-L |
| welat | vatan | M | welêt (oblique) | B-L |
| bajar | şehir | M | bajêr (oblique) | B-L |
| gund | köy | M | — | B-L |
| ode | oda | F | oda (alt.) | Thackston |
| kolan | sokak | F | — | her yer |
| pirt | köprü | F | — | her yer |
| baş | iyi | sıfat | bash | her yer |
| xirab | kötü; bozuk | sıfat | xerab (alt.) | B-L |
| mezin | büyük | sıfat | — | her yer |
| piçûk / biçûk | küçük | sıfat | piçuk | Thackston |
| nû | yeni | sıfat | — | her yer |
| kevin | eski | sıfat | kevn (alt.) | B-L |
| kevn | eski (alt.) | sıfat | — | B-L |
| dirêj | uzun | sıfat | dırej | her yer |
| kurt | kısa | sıfat | — | her yer |
| bilind | yüksek | sıfat | bılınd | her yer |
| nizm | alçak | sıfat | — | her yer |
| germ | sıcak | sıfat | — | Fêrker |
| sar | soğuk | sıfat | — | Fêrker |
| hêsan | kolay | sıfat | hesan | her yer |
| zehmet / dijwar | zor | sıfat | zehmat | her yer |
| zû | erken; çabuk | sıfat | zu | her yer |
| dereng | geç | sıfat | derang | her yer |
| şîrîn | tatlı | sıfat | — | B-L |
| tirş | ekşi | sıfat | tırş | her yer |
| tehl | acı | sıfat | tal (alt.) | B-L |
| şor | tuzlu | sıfat | — | her yer |
| xweş | hoş; lezzetli | sıfat | xeş, xuş | B-L; Fêrker |
| paqij | temiz | sıfat | paqıj | her yer |
| qirêj | kirli | sıfat | qırej | Fêrker |
| zêde | fazla | sıfat | zêdeh | her yer |
| hindik | az | sıfat | hindek | her yer |
| ziyan | zarar | F | — | her yer |
| feyde | yarar | F | fayde (alt.) | her yer |
| qenc | iyi (kişi) | sıfat | — | B-L |
| pîs | pis | sıfat | — | her yer |
| dest pê kirin | başlamak | fiil | destpê kirin | B-L §194 |
| hez kirin | sevmek | fiil | hezkirin | B-L; Aslanoğlu |
| bawer kirin | inanmak | fiil | bawerkirin | B-L |
| guh dan | dinlemek | fiil | guhdan | B-L |
| guhdarî kirin | dinlemek | fiil | guhdarîkirin | B-L |
| pîroz kirin | kutlamak | fiil | pîrozkirin | B-L |
| qebûl kirin | kabul etmek | fiil | qebûlkirin | B-L |
| dîtin | görmek | fiil | dıtin | B-L |
| gotin | söylemek | fiil | — | B-L |
| kirin | yapmak | fiil | — | B-L |
| bûn | olmak | fiil | bun | B-L |
| dan | vermek | fiil | — | B-L |
| birin | götürmek | fiil | — | B-L |
| anîn / înan | getirmek | fiil | — | B-L |
| çûn | gitmek | fiil | çun | B-L |
| hatin | gelmek | fiil | hatın | B-L |
| ketin | düşmek | fiil | kêtin (yanlış) | B-L |
| derketin | çıkmak | fiil | der ketin | B-L (close compound) |
| derxistin | çıkarmak | fiil | derxistîn | B-L |
| daxistin | indirmek | fiil | da xistin (yanlış) | B-L |
| hilkişîn | tırmanmak | fiil | — | B-L |
| hildan | kaldırmak | fiil | hil dan | B-L |
| rabûn | kalkmak | fiil | rabun | B-L |
| razan | yatmak | fiil | razan | B-L |
| xwarin | yemek | fiil/M | xewarin | B-L; Fêrker |
| vexwarin | içmek | fiil | ve xwarin | B-L (close compound) |
| xwendin | okumak | fiil | xandin, xundin | B-L |
| nivîsîn / nivîsandin | yazmak | fiil | nıvısın | B-L |
| zanîn | bilmek | fiil | zaniın, zanın | B-L |
| karîn / kanîn | yapabilmek | fiil | karın (alt.) | B-L |
| xwestin | istemek | fiil | xustin | B-L; xwastin (alt.) |
| fêhm kirin / fêm kirin | anlamak | fiil | fehm kirin (alt.) | Aslanoğlu |
| temam | tamam | sıfat / interj | temem | her yer |
| belê / erê | evet | interj | erê (alt.) | Aslanoğlu p. 14 |
| na / nexêr | hayır | interj | nehêr | Aslanoğlu |
| spas | teşekkür | interj | sipas | Aslanoğlu p. 14 |
| ji kerema xwe | lütfen | ifade | jıkerema xwe | Aslanoğlu p. 14 |
| ku | ki, çünkü, ki — bağlaç | bağlaç | ki (Tr→Kr) | Thackston §29 |
| ji ber ku | çünkü | bağlaç | jiberku | Thackston |
| heger / eger | eğer | bağlaç | egê | her yer |
| an | ya da | bağlaç | veya (Tr→Kr) | her yer |
| an jî | ya da | bağlaç | anjı, an de | her yer |
| û | ve | bağlaç | u (yanlış) | B-L |
| jî | de, dahi | enklitik | da/de (Tr→Kr) | Thackston §31 |
| ji bo | için | edat | jibo | her yer |
| li ber | önünde | edat | liber | her yer |
| li ser | üstünde | edat | liser | her yer |
| li bin | altında | edat | libin | her yer |
| li nav | içinde | edat | linav | her yer |
| ji nav | içinden | edat | jinav | her yer |
| di nav | içinde, arasında | edat | dinav | her yer |
| ji bo ku | -mek için | bağlaç | jibo ku | Thackston §29 |
| ji ber wê yekê | bu yüzden | ifade | jiber wê yekê | Aslanoğlu p. 21 |
| dema (ku) | -dığında | bağlaç | demaku | Thackston |
| gava (ku) | -dığında | bağlaç | gavaku | Thackston |
| heta (ku) | -e kadar | bağlaç | hetaku | her yer |

[Linter pattern] (auto-correct lookup):
```python
# Auto-suggestion: see COMMON_MISSPELLINGS dict in §10
```

---

## 12. AŞINIK NOKTALAR / TARTIŞMALI FORMLAR

### 12.1 Forms accepting variation

Bedirxan-Lescot ve Thackston bazı formlarda farklılaşır. Linter aşağıdakileri **tolerate** eder (uyarı vermez), fakat tek dosya içinde tutarlılık önerir:

| Form A | Form B | Açıklama |
|---|---|---|
| `spas` | `sipas` | "spas" daha öz; "sipas" CE'da yaygın |
| `xweh` | `xwişk` | Doğu / Batı varyantları |
| `dwanzdeh` | `dozdeh` | Sayı varyantları (12) |
| `ji bo` | `bo` (kısa) | "için" |
| `pê re` | `pere` | Kasınmış vs ayrık |
| `tê de` | `têde` | Kasınmış vs ayrık |
| `wê re` | `were` | Kasınmış vs ayrık |
| `dê` | `ê` | Gelecek partikeli |
| `karîn` | `kanîn` | "yapabilmek" — bölgesel |
| `kevin` | `kevn` | "eski" — kasınmış |
| `çawan` | `çawa` | "nasıl" — Doğu vs Batı |

### 12.2 Forms that MUST be Bedirxan-canonical

| Yanlış (akademik dışı) | Bedirxan-kanonik |
|---|---|
| `xudê`, `xude` | `xwedê` |
| `xuşk` | `xwişk` (B-L) ya da `xweh` (alt.) |
| `xandin`, `xundin` | `xwendin` |
| `pencî` (Tr-vari) | `pêncî` |
| `roz` | `roj` |
| `aw` | `av` |

### 12.3 Cinsiyet farklılıkları (uyarı, hata değil)

Bazı kelimelerin cinsiyeti yazardan yazara değişir (B-L §95-d). Linter çelişme uyarısı verebilir ama bu hata değildir:

| Kelime | M ağız | F ağız |
|---|---|---|
| `havîn` (yaz) | M (B-L) | F (Aslanoğlu) |
| `bihar` | M | F |
| `dem` | M | F |
| `wext` | M | F |
| `çem` | M | F |

---

## 13. EK: LİNTER UYGULAMA NOTLARI

### 13.1 Önerilen kontrol seviyeleri

**LEVEL-1 (kritik — hata):** Türkçe harf, yanlış karakter, ezafe-cinsiyet çakışması, ayrı yazılması gereken edat birleşmiş.

**LEVEL-2 (uyarı):** Sözlük lookup farkı (sîpas vs spas), eril/dişil cinsiyet inconsistency.

**LEVEL-3 (style):** Akademik tutarsızlık (pê re vs pere), bölgesel formlar.

### 13.2 Regex genel kalıpları

```python
import re

# 1. Türkçe harfler — KRİTİK
TURKISH_LETTERS = re.compile(r'[ıİğöÖüÜ]')

# 2. xw → xu hatası
XW_TO_XU_ERROR = re.compile(r'\bxu(?=[aeio][a-zêîûçş])')

# 3. Birleşik edat
COMPOUND_PREP_ERROR = re.compile(
    r'\b(li|ji|di|bi)(ber|ser|bin|nav|hev|gel|cih|bal|bo|bona|bareya)\b',
    re.IGNORECASE
)

# 4. Gelecek partikeli birleşmiş
FUTURE_PARTICLE_ERROR = re.compile(
    r'\b(ez|tu|ew|em|hûn|hun|wan)(ê|dê)\b'
)

# 5. Olumsuz geçmiş ayrılmış
NEGATIVE_PAST_SPLIT = re.compile(
    r'\bne\s+(got|hat|çû|kir|da|dît|xwand|bû|mam)\b'
)

# 6. Türkçe `ki`
TURKISH_KI = re.compile(r'\bki\b(?=\s+\w)', re.IGNORECASE)

# 7. Türkçe `ama`
TURKISH_AMA = re.compile(r'\bama\b', re.IGNORECASE)

# 8. Türkçe `veya`
TURKISH_VEYA = re.compile(r'\bveya\b', re.IGNORECASE)

# 9. xwe yerine min/te yanlışı (heuristic — kullanım grafından)
XWE_VS_PERSONAL = re.compile(
    r'\bEz\s+(?:\w+\s+){1,3}min\s+\w+',
    re.IGNORECASE
)

# 10. Misspell dictionary
MISSPELL_PATTERNS = [
    (re.compile(r'\bsîpas\b'), 'spas'),
    (re.compile(r'\bxudê\b'), 'xwedê'),
    (re.compile(r'\bxuşk\b'), 'xwişk'),
    (re.compile(r'\bxandin\b'), 'xwendin'),
    (re.compile(r'\bxundin\b'), 'xwendin'),
    (re.compile(r'\biro\b'), 'îro'),
    (re.compile(r'\baw\b(?!\w)'), 'av'),
    (re.compile(r'\brûj\b'), 'roj'),
    (re.compile(r'\bnên\b'), 'nan'),
    (re.compile(r'\bpenci\b'), 'pêncî'),
    (re.compile(r'\bşest\b(?!\w)'), 'şêst'),
    (re.compile(r'\bhezkirin\b'), 'hez kirin'),
    (re.compile(r'\bdestpê\s+kirin\b'), 'dest pê kirin'),
    # ... extend as needed
]
```

### 13.3 Recommended order of checks

1. Hawar alphabet violation (Türkçe harfler) — block early.
2. xw→xu error.
3. Compound prep / future particle / negative past spacing.
4. Common misspelling dictionary.
5. Ezafe / oblique case heuristics (require POS tagging).
6. Ergativity check (require dependency parse — optional).

### 13.4 Notes on dialectal acceptance

Lutkê hedef kitlesi okul-yaşı öğrencilerdir. Linter:
- Bedirxan-Lescot standardını esas alır.
- Doğu ağzı varyantlarını (e.g. `çawan`, `digêl`) **tolerate** eder (uyarı vermez).
- Aşırı eski formları (B-L §17 e/i geçişleri) **tolerate** eder.
- Türkçe doğrudan ödünçleri (Tr→Kr direct loan) **flag** eder, ancak öğretici bağlamda kabul eder.

---

## 14. KAYNAK ÇİZELGESİ

| Kural alanı | Birincil kaynak | İkincil destek |
|---|---|---|
| Alfabe | B-L §2-§5 | Badillî §7-§8; Aslanoğlu p. 3 |
| Sesliler | B-L §6-§21 | Badillî §8; Thackston "Phonology" p. 1-3 |
| Sessizler | B-L §22-§64 | Badillî §8; Thackston "Phonology" |
| Cinsiyet | B-L §89-§96 | Thackston §1.1 |
| Ezafe | B-L §99-§109 | Thackston §4-§5 |
| Eğik hâl | B-L §111-§128 | Thackston §1.2 |
| Demonstrative | B-L; Thackston §2 | Aslanoğlu |
| Belirsizlik (-ek) | B-L §100-§101 | Thackston §3 |
| Şahıs zamir | B-L §134-§140 | Thackston §7 |
| Fiil çekimi | B-L §141-§180 | Thackston §11-§28 |
| Ergativity | B-L §187 | Thackston §18.2 |
| Gelecek zaman | B-L §175 | Thackston §16.2 |
| Birleşik fiil | B-L §192-§197 | Thackston §15 |
| Edat | B-L (B.IX) | Thackston §8 |
| Bağlaçlar | — | Thackston §29 |
| Ödünç kelime imlâ | B-L §35-§37 | Aslanoğlu |
| Sayı | B-L §131-§133 | Aslanoğlu p. 4; Thackston §9 |
| Konuşma kalıpları | — | Aslanoğlu p. 14-27; Fêrker |

---

**SON.** Bu doküman Lutkê Kurmancî linter'i için tek otoriter kural seti olarak kullanılır. Yeni kural eklenirken kaynak alıntısı (B-L paragrafı veya Thackston bölüm numarası) zorunludur. Tartışmalı durumlarda Bedirxan-Lescot grameri otoritedir.
