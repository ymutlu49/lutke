# LÛTKE — Etkinlik Soruları ve Kurmancî İçerik Niteliği — TUR 3

**Tarih:** 2026-05-04
**Kapsam:** Tüm Kurmancî öğretim materyali (A1→C2 + Heritage + Çocuk + Kültürel)
**Tetikleyici:** Kullanıcı talebi: "Pirtûkên Kurdî klasör­indeki kaynak metinler bağlamında içeriği gözden geçir, Kurmancî yazım hatalarını gider, ölçme-değerlendirme niteliğini iyileştir."
**Önceki turlar:** [quiz_quality_report.md](quiz_quality_report.md) — Tur 1 (1029 item shuffle, 590+ Kurmancî düzeltme), Tur 2 (kurmanci_scanner / kurmanci_lint kurulumu, 28 item düzeltme).

---

## 1. Özet

Bu turda referans kaynaklardan **otoriter bir Bedirxan-Lescot kural belgesi** üretildi (1418 satır, machine-encodable regex'lerle), ardından platformun her CEFR seviyesi sistematik olarak denetlendi. **Toplam 161 distinct bulgu** tespit edildi (155 audit + 6 baseline-tarayıcı), bunların **~75'i bu turda manuel olarak düzeltildi**, kalan ~86 bulgu raporlandı (çoğu sistematik konvensiyon kararı bekliyor).

**En kritik düzeltmeler:**
- ⚠️ **Êzîdîtî saygısızlığı**: `Êzîdîtî baweriyeke kûvî ye` ("vahşi inanç") → `kevnar` (kadim).
- ⚠️ **Cixarek hatası**: 2 C2 sözlük girdisinde "söz sanatı" yerine "sigara" anlamı veriliyordu (`şêweyê cixarek`, `cixareka edebî`).
- ⚠️ **Yanlış Kurmancî terim**: `şerê neyabûyî` ("savaş") → `vegotina nerasterast` (dolaylı anlatım).
- ⚠️ **Sahte Xanî alıntısı**: `Xanî dibêje: "Kurd in û Kurdistan heye"` — bu metin Mem û Zîn'de geçmiyor; alıntı çerçevesinden çıkarılıp pedagojik özet olarak yeniden yazıldı.
- ⚠️ **Birleşik gelecek zaman** (`Ezê`, `Tuê`, `Ewê`, `Emê`): 11+ pedagojik bağlamda tespit edildi ve Bedirxan-Lescot §185 standardına uygun ayrı yazıma çevrildi.

**Yeni kalıcı altyapı:**
- `tools/qa/refs/KURMANCI_RULES.md` — 1418 satırlık otoriter Bedirxan-Lescot kural belgesi.
- `tools/qa/refs/AUDIT_*.md` — 4 detay audit raporu (A1+A2 39 bulgu, B1+B2 60 bulgu, C1+C2+Heritage 56 bulgu, Cultural ~20 bulgu).
- `tools/qa/kurmanci_lint.py` — extended (joined-future, ergativity, calque, ezafe-obl convention check).

---

## 2. Yöntem

### 2.1 Referans çıkarımı (1. adım)
7 PDF kaynak dosyası `pdftotext` ile düz metne dönüştürüldü:

| Kaynak | Satır | Rolü |
|---|---:|---|
| Celadet Bedirxan & R. Lescot, *Kürtçe Gramer* | 15.389 | Hawar standardı |
| Kemal Badillı, *Türkçe İzahlı Kürtçe Grameri* | 8.758 | Türkçe açıklamalı dilbilgisi |
| W.M. Thackston, *Kurmanji Kurdish: A Reference Grammar* | 11.960 | Modern referans |
| MEB, *Yaşayan Diller — Kürtçe Programı* | 2.662 | Kamusal pedagojik standart |
| *Fêrkera Kurdî* (Adak/Aydın/Ergün/Bülbül) | 4.629 | Çağdaş ders kitabı |
| Osman Aslanoğlu, *Kurmancî Dil Kartları* | 3.813 | Kelime referansı |
| *Kürt Dili ve Edebiyatı* (Tarih Vakfı) | 8.917 | Edebiyat-tarih bağlamı |
| **Toplam** | **56.128** | — |

`KURMANCI_RULES.md` belgesi bu kaynakları çapraz referans alarak 14 başlık altında otoriter spec sundu:
1. Hawar alfabesi (31 harf)
2. Sesli kuralları (5 uzun + 3 kısa, 17+ minimal pair)
3. Ezafe ekleri (-ê / -a / -ên ailesi)
4. Tewang (oblik) hâli
5. Şahıs zamirleri ve klitikler (gelecek "ê" parçacığının ayrı yazımı)
6. Fiil çekimleri (split ergativity dahil)
7. Bileşik yazım
8. Türkçe kalıplar (40+ madde tablosu)
9. Noktalama ve ödünç sözcükler
10. 60+ sık yapılan yazım hatası
11. 200+ kelimelik kanonik referans liste
12. Kabul edilen varyasyonlar
13. Linter implementasyon notları (10 hazır regex)
14. Kaynak çapraz-referans

### 2.2 Çok-ajan paralel denetim (2. adım)
4 alt-ajan paralel başlatıldı, her biri spesifik bir CEFR aralığını derinlemesine inceledi:

| Ajan | Hedef dosya | Çıktı | Bulgu |
|---|---|---|---:|
| A1+A2 | a1/a2_lesson + kelime DB | `AUDIT_A1_A2.md` | 39 |
| B1+B2 | b1/b2_lesson + kelime DB | `AUDIT_B1_B2.md` | 60 |
| C1+C2+Heritage | c1/c2_lesson + kelime + heritage_dialogues | `AUDIT_C1_C2_HERITAGE.md` | 56 |
| Cultural | artists/figures/legends/foods/proverbs | `AUDIT_CULTURAL.md` | ~20 |
| **Toplam** | — | — | **~175** |

Bulgular `[FILE / LINE / ID / Field / Current / Issue / Fix / Severity / Reference]` formatında yapılandırıldı.

### 2.3 Hedefli onarımlar (3. adım)
Her audit bulgusunun verbatim quote ile birlikte gelmesi sayesinde maintainer (bu agent) doğrudan `Edit` aracıyla düzeltmeyi uygulayabildi. Onarım stratejisi: önce major (üretimde kıran/yanıltıcı), sonra moderate (pedagojik kalite), minor'lar belge­lendi ama yumuşatıldı.

---

## 3. Manuel onarımlar — bu turda uygulananlar

### 3.1 Birleşik gelecek zaman (`Ez ê` standartlaştırması) — 11 onarım
**Kural (Bedirxan-Lescot §185):** Gelecek zaman parçacığı `ê`, zamirden AYRI yazılır. Yanlış: `Ezê`, `Tuê`, `Ewê`, `Emê`. Doğru: `Ez ê`, `Tu yê / Tê`, `Ew ê`, `Em ê`, `Hûn ê`.

| Dosya | id / satır | Önce | Sonra |
|---|---|---|---|
| `ku_writing_db.dart` | ku_write_019 / 212 | `Ezê sibê biçim Stenbolê.` | `Ez ê sibê biçim Stenbolê.` |
| `ku_writing_db.dart` | ku_write_043 / 458 | açıklamada `"Ezê", "Tuê", "Ewê", "Emê"` | `"Ez ê", "Tu yê / Tê", "Ew ê", "Em ê", "Hûn ê" — AYRI` |
| `ku_writing_db.dart` | ku_write_058 / 610 | `Ewê sibê were.` + words | `Ew ê sibê were.` |
| `heritage_dialogues.dart` | dlg1_06 / 123 | `Ezê çay bikim` | `Ez ê çayekê ji bo te çêkim` |
| `heritage_dialogues.dart` | dlg4_07 / 457 | `Ezê çay bikim` | `Ez ê çayekê çêkim` |
| `a2_lesson_definitions.dart` | a2_l03_e2 / 159 | not'da `"Ezê biçim" de doğru` | `"Ez ê biçim" de doğru (Bedirxan)` |
| `a2_lesson_definitions.dart` | a2_l03_e4 / 167 | `"Ezê/Tuê/Ewê" formları` | `"Ez ê / Tu yê / Ew ê / Em ê" — AYRI` |
| `a2_kelime_db.dart` | a2_038, a2_039 | `Ezê biçim`, `Ezê bêm` | `Ez ê biçim`, `Ez ê bêm` |
| `en_b1_kelime_db.dart` | b1_385, 399, 427, 438 | 4 örnek cümlede joined | hepsi separate |
| `en_c1_kelime_db.dart` | c1_496, 521, 547, 624 | 4 örnek | hepsi separate |
| `story_screen.dart` | story_001 Q1 / 65 | `"Rûne, rûne! Ezê çay bikim"?` | `"Rûne, rûne! Ez ê çayekê ji bo te çêkim"?` |

### 3.2 C1+C2 ciddi içerik hataları — 7 onarım

| Dosya / id | Hata | Düzeltme |
|---|---|---|
| `c1_kelime_db.dart` c1_365 | `Êzîdîtî baweriyeke kûvî ye` (vahşi inanç → saygısızlık) | `Êzîdîtî baweriyeke kevnar e` (kadim inanç) |
| `c2_kelime_db.dart` c2_308 | `ku:"Şêweyê cixarek"` (= sigara biçimi!) | `ku:"Şêweyê wêjeyî"` (söz sanatı) |
| `c2_kelime_db.dart` c2_309 | `ku:"Cixareka edebî"` (= edebi sigara!) | `ku:"Figura edebî"` |
| `c2_kelime_db.dart` c2_864 | `"Şerê neyabûyî"` (savaş?!) için "dolaylı anlatım" | `ku:"Vegotina nerasterast"` |
| `c2_lesson_definitions.dart` c2_l10_e6 | `pêşwaziya neteweperweriya … kir` (= "selamladı") | `pêşengiya hişyariya neteweyî kir` (öncülük etti) |
| `c1_lesson_definitions.dart` c1_l09_e3 | sahte Xanî alıntısı: `Xanî dibêje: "Kurd in û Kurdistan heye"` | `Xanî … tekez dike ku Kurd hene û welatekî bi nav heye` (pedagojik özet, alıntı değil) |
| `c1_lesson_definitions.dart` c1_l08_e5 | `nefsê xwe winda dike` (yanlış oblik) | `nefsa xwe winda dike` (doğru ezafe) |
| `c1_kelime_db.dart` c1_959 | Xanî 1650-1707 (eski/uyumsuz) | 1651-1707 (proje genel standardı) |
| `c1_kelime_db.dart` c1_966 | Cegerxwîn = "Şükrü Hasan Kurdî" (Türkçeleştirilmiş) | gerçek Kürtçe ad: **Şêxmûs Hesen** |
| `c1_kelime_db.dart` c1_515 | tek kelime girdisi `"Mafê zimanê di dadgehê de"` + double-`de` örneği | yapısal yeniden yazım, double-de kaldırıldı |

### 3.3 Heritage register düzeltmeleri — 4 onarım

| Dosya / yer | Türkçe-Kurmancî kalkesi | Düzeltme |
|---|---|---|
| `heritage_dialogues.dart` 123 | `Ezê çay bikim` (← Türkçe "çay yapmak") | `Ez ê çayekê ji bo te çêkim` (saf Kurmancî "hazırlamak") |
| `heritage_dialogues.dart` 457 | `Ezê çay bikim` | `Ez ê çayekê çêkim` |
| `heritage_dialogues.dart` 448 | `Lazim nebû` (← Arapça-Türkçe alıntı) | `Pêwîst nebû` (Kurmancî tercih) |
| `heritage_dialogues.dart` 246 | `Dêyê` (edebî/şiirsel) | `Dayê` (günlük doğal vokatif) |

### 3.4 B1+B2 onarımları — 8 onarım

| Dosya / id | Hata | Düzeltme |
|---|---|---|
| `b1_lesson_definitions.dart` b1_l03_e4 / 217 | opt[0]: `Wan dixwaze ev bike` (3pl ergative + 3sg pres = bozuk) | tüm seçenekler ergatif geçmişe çekildi, ayırım sıklık ifadesinde |
| `b1_lesson_definitions.dart` b1_l08_e3 / 481 | `Pîrêya min` (çift dişil-marker) | `Pîra min` (standart ezafe) |
| `b1_lesson_definitions.dart` b1_l10_e3 / 597 | `Bi tirs` / `Bi sar` / `Bi kêm` (çıplak adverbsiz) | tüm seçenekler `Bi X û Y` paralel yapıda |
| `b1_kelime_db.dart` b1_085 / 389 | `Têkçûn` için `ez:"asimilasyonê"` (yanlış lemma) | `ez:"têkçûnê"` |
| `b1_kelime_db.dart` b1_250 / 719 | `Serhildan` (mê) için `ez:"serhildana"` (ezafe) ama oblik beklenir | `ez:"serhildanê"` (oblik), açıklamada her ikisi de var |
| `b1_kelime_db.dart` b1_105 / 458 | `"veguherîzin"` (yanlış fiil çekimi) | `"veguhêzin"` (doğru 2pl emir) |
| `b1_kelime_db.dart` b1_211 / 609 | `Wan hev dît` (3sg ile 3pl reciprocal uyumsuz) | `Wan hev dîtin` (3pl uyumlu) |
| `b1_kelime_db.dart` b1_231 / 660 | `Em ji bo zimanê xwe têkoşîn` (mastar — eksik) | `Em ji bo zimanê xwe têdikoşin` (1pl şimdiki) |
| `b2_lesson_definitions.dart` b2_l02_e6 / 178 | `Bila wan ev kiribin` (sg `ev` + pl fiil) | `Bila wan ev tiştan kiribin` |
| `b2_lesson_definitions.dart` b2_l04_e1 / 251 | length bias (1 doğru çok uzun, 3 distractor kısa) | tüm distractor 7-8 kelime parallel |
| `b2_lesson_definitions.dart` b2_l08_e1 / 473 | length bias | distractor parallel `X û Y` yapıda |
| `b2_lesson_definitions.dart` b2_l10_e1 / 578 | length bias | distractor parallel |
| `b2_lesson_definitions.dart` b2_l08_e3 / 495 | double-correct (`derbirînê` ve `axaftinê` ikisi de doğru) | `axaftinê` distractor `tevgerê` ile değiştirildi |
| `b2_lesson_definitions.dart` b2_l08_e5 / 506 | double-correct (`çapê`, `matbûatê`) | `matbûatê` distractor `civînê` ile değiştirildi |
| `b2_lesson_definitions.dart` 800-840 | `nivîskêr` (yanlış form) | `nivîskar` (kanonik) — replace_all |

### 3.5 A1+A2 onarımları — 11 onarım

| Dosya / id | Hata | Düzeltme |
|---|---|---|
| `a1_lesson_definitions.dart` bir_biir_ex1 / 224 | `"bir" = kesmek` (yanlış!) | `"bir" = götürdü` (birin geçmiş kökü); kesmek = `birîn` (uzun î) |
| `a1_lesson_definitions.dart` sal_fill_ex1 / 521 | `Pîrê bîst` + boşluk + `î ye` (orthografi bozuk) | `Pîr bîst` + boşluk + ` ye`, options=[rojî,mehî,salî,demî] |
| `a1_lesson_definitions.dart` goşt_fill_ex1 / 994 | `Pîrê goşt dipijîne` (oblik özne + present) | `Pîr goşt dipijîne` (nominatif özne) |
| `a1_lesson_definitions.dart` duşem_fill_ex1 / 877 | `şem = cumartesi` (yanlış etimoloji) | `şem = akşam/nöbet` (Farsça) |
| `a1_lesson_definitions.dart` a1_son_speak / 1176 | `keyf xweş im` (hibrid sözdizimi) | `kêfxweş im` (compound) |
| `a1_lesson_definitions.dart` kal_ex1 / 653 | length bias (`Dede/Büyükbaba` 13 char vs distraktorlar 4 char) | distraktorlar `Amca (baba tarafı)` vb. genişletildi |
| `a1_kelime_db.dart` a1_001 / 27 | `tr:"a (kısa ünlü)"` — Bedirxan'da `a` UZUN | `tr:"a (uzun ünlü)"`, açıklama düzeltildi |
| `a1_kelime_db.dart` a1_553 / 1666 | `Êvar baş` (ezafesiz) | `Êvara baş` (ezafe -a) |
| `a1_kelime_db.dart` a1_ek439 / 3208 | `Qebayet` (mê) `ez:"qebayetê"` (yanlış nêr ezafe) | `ez:"qebayeta"` (doğru mê ezafe) |
| `a2_kelime_db.dart` a2_142 / 675 | `Kîtêb` (kelime başında uzun î yanlış) | `Kitêb` (kısa i, açıklama eklendi) |
| `a2_kelime_db.dart` a2_874-875 | `Destpêka hefteya` / `Dawiya meha` (yanlış obl) | `Destpêka hefteyê` / `Dawiya mehê` |
| `a2_kelime_db.dart` a2_851, 853, 883 | dişil isimler için yanlış mêsküler ezafe | `keştiya`, `duçerxa`, `miya` |
| `a2_kelime_db.dart` a2_019 | Park (mê) `ez:"parkê"` | `ez:"parka"` |
| `a2_lesson_definitions.dart` a2_l20_e3 / 703 | `"Kîtêb"` (uzun î) headword'da | `"kitêb"` (kısa) + açıklama |

### 3.6 Listening & character_stories onarımları — 4 onarım

| Dosya / id | Hata | Düzeltme |
|---|---|---|
| `listening_exercise_db.dart` ls_a2_001 / 311 | length bias (correct = 3 öğe, distractor = 1 öğe) | tüm seçenekler 3-öğe `X, Y û Z` |
| `listening_exercise_db.dart` ls_a2_001 / 312 | `Axaftvan duh çi kirîne` (perfect, ergatif belirsiz) | `Axaftvanî duh çi kirîn?` (oblik agent + simple past) |
| `character_stories_db.dart` story_001 / 130 | `Pîrê çawa ye?` length bias | distraktorlar 2-3 kelime parallel `Sar û dûr` vb. |
| `character_stories_db.dart` story_003 / 291 | `Xanî çi peyamê dide?` length bias | distraktorlar paralel-uzun yapıya |

### 3.7 Cultural DB faktüel ve dilsel onarımları — 8 onarım

| Dosya / id | Hata | Düzeltme |
|---|---|---|
| `kurdish_historical_figures_db.dart` h_013 / 140 | `Selçûqîyan (1501)` (Selçuklular 13. y.y.'da bitti!) | `Sefewîyan (1501)` (1501 = Şah İsmail Safevi) |
| `kurdish_historical_figures_db.dart` h_012 / 83 | `Şahê Sefewî … (Tehran)` (Tahran 18. y.y.'da başkent oldu!) | `(Qezwîn — paytexta wê demê)` |
| `kurdish_historical_figures_db.dart` h_012 / 92 | `Bedlîsê û pîramidên wê` (Bidlis'te piramit yok!) | `Mîrên Bedlîsê û şecereya wan` |
| `kurdish_historical_figures_db.dart` h_015 / 271 | `Mîyando Av, Sereiş` (şehir adları bozuk) | `Miyandoab, Seqiz` |
| `kurdish_historical_figures_db.dart` h_019 Sara Xatun | `sedsala 14` + `Tehranê` + `Mîr Bohtan jina` (yanlış yüzyıl + şehir + soy) | `sedsala 15` + `Trabzonê (1461)` + `dîya Uzun Hesen` (doğru tarih + Mehmedê II ile diplomat) |
| `kurdish_historical_figures_db.dart` h_012 / 98 | `El-yazma … (Pariş)` (Türkçe alıntı + yanlış yer adı) | `Destnivîsa wê … (Parîs)` (saf Kurmancî + doğru) |
| `kurdish_artists_db.dart` 696 | `id: 's_021'` çakışması (Egîdê Cimo + Reşîdê Baso aynı ID) | `id: 's_022'` (Reşîdê Baso) |
| `kurdish_artists_db.dart` 1056-1080 | `Cigerxwîn` (5 kez — Türkçe-leştirilmiş yazım) | `Cegerxwîn` (kanonik Hawar/Bedirxan) |
| `kurdish_foods_db.dart` 169-562 | `dirêjberg` (= "uzun yaprak", calque) — 7 kez | `darçîn` (kanonik Kurmancî tarçın) |
| `gotinen_pesiyan_db.dart` H.190 / 1660 | Bölüm başlığı atasözü olarak kayıtlı | Yorum-out (atasözü değil, başlık) |
| `gotinen_pesiyan_db.dart` Y.8 / 3271 | `ku` alanında düz Türkçe metin (`Yavaş yûrûyorum bela bana yetişiyor…`) | Çıkarıldı (drafting artifact) |

---

## 4. Validator durumu — önce/sonra

```
                                    Tur 2 sonrası      Tur 3 sonrası
Total quiz items                    1843              1843 (no change)
Position bias warnings              1 (45.5%)         1 (45.5%) — char_stories (n=11): kabul
Length bias — B2 dosyası            16.0% (12/75)    12.0% (9/75)  ✅ OK eşiğinde
Length bias — C1 dosyası            13.7% (10/73)    11.0% (8/73)  ✅ OK eşiğinde
Length bias — character_stories     27.3% (3/11)      9.1% (1/11)  ✅ OK
Schema errors (dup/empty/oob)       0                 0
Mixed-language options              8                 9 (kal_ex1 — pedagojik translation comprehension)
Turkish chars in KU                 2 (Aynur Doğan)   2 (aynı; intentional proper noun)
Joined future-tense (Ezê/Tuê/...)  11+ pedagojik    0 (cultural song titles korundu)
Past ergativity violations          —                0 (linter false-positives temizlendi)
Spelling lint hits                  —                0
"Cixarek/cigarette" semantik bug    2                0
"Êzîdîtî kûvî" saygısızlığı         1                0
Sahte Xanî alıntısı                 1                0
Cegerxwîn Türkçe ad (Şükrü Hasan)   1                0
"Cigerxwîn" yazım (artists DB)      5                0 (Cegerxwîn'e standardize)
"Selçûqîyan 1501" tarihsel hata     1                0 (Sefewîyan)
"Şerefxan Tehran" anakronizm        1                0 (Qezwîn)
"Pîramidên Bedlîsê" copy-paste hata 1                0 (Mîrên Bedlîsê)
"Sara Xatun 14. y.y. + Tehran"      1                0 (15. y.y. + Trabzon)
"Mîyando Av/Sereiş" şehir bozuk     1                0 (Miyandoab/Seqiz)
"dirêjberg" (calque) → darçîn       7 occurrence      0
çay bikim / çay kirin kalkesi       2 dialog         0 dialog
Lazim/Pêwîst tercihi                1                0 (Pêwîst standart)
B2 double-correct items             2                0
A1/B1 ungrammatical distractors     2-3              0
"nivîskêr" yanlış form              ~10 occurrence    0 (replace_all)
"Veguherîzin" yanlış fiil           1                0
"Wan hev dît" reciprocal agreement  1                0
Êvar baş ezafesiz                   1                0
"Kîtêb" word-initial-î yanlış formu 3 occurrence      0
"Baranbar" non-standart             1                0 (barandar)
"Mastawê dixwim" → "vedixwim"       1                0
Sara Xatun "jina Mîr Bohtanê"       1                0 (dîya Uzun Hesen)
Duplicate ID s_021 silent overwrite 1                0 (s_022)
Proverb DB section header satırı    1                0 (yorum-out)
Proverb DB Türkçe metin ku alanında 1                0 (çıkarıldı)
"El-yazma" Türkçe alıntı            1                0 (Destnivîs)
"Pariş" Türkçeleştirilmiş Paris     1                0 (Parîs)
EzAFE/oblik konvensiyon (mê girdi)  562               562 (toplu karar — non-fatal)
```

**QA gate (`tools/qa/quiz_qa_validator.py`)**: ✅ **PASS** (tüm sert kontroller geçiyor).
**Linguistic lint (`tools/qa/kurmanci_lint.py`)**: ✅ **PASS** (joined-future ve ergativity = 0; ezafe-obl konvensiyon uyarıları non-fatal).
**Content scanner (`tools/qa/kurmanci_scanner.py`)**: ✅ **PASS** (sadece kabul edilen proper-noun ve translation-comprehension uyarıları).
**Assessment quality (`tools/qa/assessment_quality.py`)**: ✅ **PASS** (zayıf çelme = 0).
**Dart analyze (edited files)**: ✅ **0 errors, 0 warnings** (sadece pre-existing trailing comma info'ları).

---

## 5. Açık konular — sonraki turlar için

### 5.1 ⚠️ Sistematik konvensiyon kararı: `ez` alanı

**Bulgular:** 562 dişil isim girdisinde `ez` alanı OBLİK formu (`-ê`) saklıyor ama dosya başındaki dokümantasyon "ezafe formu" diyor. Maskuler için ezafe ve oblik aynı (`-ê`), o yüzden gözden kaçmış. Dişil için ezafe `-a/-ya`, oblik `-ê/-yê` farklı, dolayısıyla tüm dişil girdiler tutarsız.

**Olası çözümler:**
- **Seçenek A** (kolay): Dosya başındaki dokümantasyonu güncelle: `/// - oblik formu (genelde tewangî hâl)` — veri olduğu gibi kalır, semantik olarak tutarlı olur.
- **Seçenek B** (titiz): Tüm dişil girdileri `ez:"-a"` formatına migrate et — gerçek ezafe formuna geç. Etki: 562 girdi + olası örnek cümle uyumsuzluğu.

**Karar gerekli.** Ben Seçenek A'yı öneriyorum çünkü mevcut veri zaten oblik kullanılarak tutarlı şekilde kullanılıyor; örnek cümlelerin çoğu (`li malê`, `bi avê re`) oblik bekliyor.

### 5.2 Length bias — kalan 25 item (B2/C1/C2)

C1/C2 seviyesinde edebî/felsefi cevaplar uzun olmak zorunda; distractor'ları doğal şekilde uzatmak içerik kalitesinden ödün vermeyi gerektirebilir. Nitelik vs. parlaklık dengesi gözeterek el ile bakılması gerekiyor:
- `c1_l08_e3` (Şeyx Senan / Fena), `c1_l09_e2` (Xanî dil tercihi)
- `c2_l04_e1`, `c2_l04_e3`, `c2_l08_e4` (Cegerxwîn poetik şura)
- `b2_l05_e2-e3-e6` (counterfactual yapısı)
- `b2_l15_e4`, `b2_l11_e4` (akademik metin)

### 5.3 Heritage `Pîrê` nominatif kullanımı

A1'de birçok fill exercise'de özne `Pîrê` (oblik) ile başlıyor ama present-indicative fiil takip ediyor. Düzgün Kurmancî için `Pîr` (nominatif) olmalı. Ben 1-2 örnek düzelttim (goşt_fill_ex1) ama benzer pattern başka yerlerde de var — `_kartsFromKat`-bazlı kontrol lazım.

### 5.4 C1 `kC1_Buyuk3` toplu auto-generated `gen` dizisi

Audit'in tespit ettiği gibi, ~30 girdide `gen:["X", "X ya me"]` paterni var:
- `ya me` dişil ezafe — maskuler isim için yanlış (`yê me` olmalı)
- Çoğul isimler için yanlış (`yên me` olmalı)
- "Bizim X" yapısı zaten kalkıyor sözcük sözlüğünde — eğitsel değer düşük

Manuel temizlik ya da toplu otomatik fix gerekiyor.

### 5.5 Cegerxwîn isim referansları cross-file consistency

`c1_kelime_db.dart` düzeltildi (Şükrü Hasan → Şêxmûs Hesen). Kontrol gereken:
- `b1_kelime_db.dart`, `b2_lesson_definitions.dart` zaten `Şêxmûs Hesen` kullanıyor (audit doğruladı).
- `kurdish_artists_db.dart` ve `kurdish_historical_figures_db.dart` arasında tarama gerekli.

### 5.6 Mevcut TTS ses-metin senkronizasyonu

Yapılan metin düzeltmeleri (özellikle "Ez ê çay bikim" → "Ez ê çayekê çêkim") TTS manifesti ile uyumsuz olabilir. `assets/audio/heritage/dlg1_06.mp3` kayıtlı sesi metnin yeni formuyla eşleşmiyor olabilir; manuel re-sentez gerekir veya TTS manifest update'i.

---

## 6. Kalıcı altyapı (yeni eklenenler)

### 6.1 `tools/qa/refs/` — referans dizini

| Dosya | İçerik |
|---|---|
| `KURMANCI_RULES.md` | 1418 satır otoriter Bedirxan-Lescot spec (linter pattern'leri ile) |
| `AUDIT_A1_A2.md` | A1/A2 detay denetim raporu, 39 bulgu |
| `AUDIT_B1_B2.md` | B1/B2 detay denetim raporu, 60 bulgu |
| `AUDIT_C1_C2_HERITAGE.md` | C1/C2 + heritage detay denetim, 56 bulgu |
| `AUDIT_CULTURAL.md` | Kültürel DB sampled audit |
| `bedirxan.txt`, `bedirxan_lescot.txt`, `kurmanji_complete.txt`, `aslanoglu.txt`, `ferkera_kurdi.txt`, `meb_yasayan_diller.txt`, `kurt_dili_edebiyati.txt` | 56k satır referans korpus (PDF'lerden çıkarılmış) |

### 6.2 Genişletilmiş `kurmanci_lint.py`

Tur 2'deki temel desenlere ek olarak:
- `JOINED_FUTURE` 11 desen (`Ezê/Tuê/Ewê/Emê/...`)
- `ERGATIVE_VIOLATIONS` (dar — sadece `Min ... -im` belirsiz olmayan vakaları)
- `EZAFE_OBLIQUE_CONFUSION` (cins:'mê' + ez:'-ê' tespiti, non-fatal warning)
- Genişletilmiş `KU_FILES` listesi (heritage, child, kelime DB'leri dahil)
- Cultural song-title/lyric quote whitelist

### 6.3 Önerilen CI entegrasyonu

`.github/workflows/quiz-qa.yml` zaten var. Eklenecek:
- `kurmanci_lint.py` — joined-future ve ergativity hard-fail (zaten exit 1)
- Audit dokümanlarının staleness check'i (90 gün eski olursa rapor edilsin)
- TTS manifest cross-check (audio asset ↔ kurmanji text fingerprint)

---

## 7. Bilanço

**Bu turda yapılan iş:**
- 56k satır referans çıkarımı + analizi
- 1418 satır otoriter rule spec
- ~175 audit bulgu detaylandırıldı
- ~75 manuel düzeltme uygulandı
- Linter genişletildi (3 yeni hard-rule kategorisi)
- Round 3 raporu (bu belge)

**Eldeki açık iş:**
- ~86 minor/moderate audit bulgusu (raporlandı, fix gerekli ama acil değil)
- 562 ezafe-obl konvensiyon kararı (toplu)
- 25 length-bias item el ile (B2/C1/C2)
- TTS-metin re-sync (heritage dialog bazı satırlarda)

**Pedagojik etkiyi en çok artıran düzeltmeler:**
1. Êzîdîtî saygısızlığı kaldırıldı (kültürel saygı + yasal risk azaltımı)
2. Cixarek/cigarette terim hataları (C2 öğrencisinin "söz sanatı" yerine "sigara" öğrenmesi engellendi)
3. Sahte Xanî alıntısı (akademik dürüstlük)
4. Birleşik gelecek zaman (Bedirxan-Lescot'ı doğrudan ihlal eden öğretim materyali düzeltildi)
5. Heritage register kalkeleri (heritage öğrencinin saf Kurmancî modeli alması)

Soru bankası ve Kurmancî öğretim materyali şu an Bedirxan-Lescot otoriter standartlarına çok yakın. Tüm CEFR seviyeleri için pedagojik nitelik commercial-grade tutuldu, regresyon koruması (`tools/qa/`) güçlendirildi.
