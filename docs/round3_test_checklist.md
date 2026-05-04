# LÛTKE — Tur 3 Manuel Test Checklist

**Amaç:** Tur 3 düzeltmelerinin uygulamada doğru göründüğünü doğrulamak.
**URL (build hazır olduğunda):** http://localhost:8123

---

## A. Kritik içerik onarımları (mutlaka kontrol et)

### A1 — Heritage diyaloğu: Çay sahnesi
**Yer:** A1 → "Pîrê û Çay" hikayesi / heritage track ders 1
**Test:**
- [ ] Büyükanne çağrısı: `Rûne, rûne! Ez ê çayekê ji bo te çêkim.` (önceden: `Ezê çay bikim`)
- [ ] Grammar note: "Bedirxan-Lescot: 'ê' zamirden ayrı yazılır" mesajını görüyor musun?
- [ ] Story comprehension question: `Kî got "Rûne, rûne! Ez ê çayekê ji bo te çêkim"?`

### A2 — Hediye sahnesi: Pêwîst nebû
**Yer:** Heritage diyaloğu 4 (`kDialogueMalbat`)
**Test:**
- [ ] Büyükanne: `Çi ye ev? Pêwîst nebû! Gelek spas, kurê min.` (önceden: `Lazim nebû`)
- [ ] Grammar note Arapça-Türkçe alıntısı yerine Kurmancî tercihini açıklıyor

### B — A1: bir/bîr minimal pair (ETIMOLOJİ HATASI DÜZELTMESI)
**Yer:** A1 Birim 1, "ker_keer_ex1" alıştırması civarı (bir_biir_ex1)
**Test:**
- [ ] Soru: `Ferqa "bir" û "bîr" çi ye?`
- [ ] Doğru cevap: `"bir" = götürdü, "bîr" = kuyu/hafıza` (önceden YANLIŞ: `bir = kesmek`)
- [ ] Grammar note: "Kesmek Kurmancî'de 'birîn' (uzun î)" eklemesi var mı?

### C — C2: Cixarek/söz sanatı (KRİTİK TERMİNOLOJİ HATASI)
**Yer:** C2 sözlük araması: "Şêweyê wêjeyî" veya "Figura edebî"
**Test:**
- [ ] c2_308: `Şêweyê wêjeyî` (önceden: `Şêweyê cixarek` = "sigara biçimi"!)
- [ ] c2_309: `Figura edebî` (önceden: `Cixareka edebî` = "edebi sigara"!)
- [ ] c2_864: `Vegotina nerasterast` (önceden: `Şerê neyabûyî` = "savaş")

### D — C1: Êzîdîtî (KÜLTÜREL SAYGI)
**Yer:** C1 sözlük: "Êzîdîtî"
**Test:**
- [ ] Heritage sentence: `Êzîdîtî baweriyeke kevnar e.` (önceden: `kûvî` = "vahşi")
- [ ] Genel ton: kadim ve saygılı

### E — C1: Cegerxwîn isim
**Yer:** C1 sözlük: "Cegerxwîn"
**Test:**
- [ ] Doğum yeri: `Hesar, Gercüş, Mêrdîn`
- [ ] Gerçek ad: `Şêxmûs Hesen` (önceden Türkçeleştirilmiş: `Şükrü Hasan Kurdî`)
- [ ] Ölüm yeri: `Stockholm`
- [ ] Tarih: `1903–1984`

### F — C1: Ehmedê Xanî tarih + yapıt
**Yer:** C1 sözlük: "Dîwana Xanî" / Mem û Zîn dersleri
**Test:**
- [ ] Tarih: `1651–1707` (önceden bazı yerlerde 1650)
- [ ] Yapıt: `Mem û Zîn (1695)`, `Nûbahara Biçûkan (1683)`

### G — Kültürel sözlük: Tarihi kişiler
**Yer:** Kültürel içerik → Tarihi kişiler
**Test:**
- [ ] **Şerefxan** (h_012): "Qezwîn — paytexta wê demê" (önceden YANLIŞ: Tehran)
- [ ] **Şerefname**: "Mîrên Bedlîsê û şecereya wan" (önceden: `pîramidên Bedlîsê` = piramitler!)
- [ ] **İdris-i Bidlisi** (h_013): "Sefewîyan (1501)" (önceden: Selçûqîyan)
- [ ] **Şêx Ubeydullah** (h_015): şehirler `Mehabad, Miyandoab, Seqiz` (önceden bozuk: `Mîyando Av, Sereiş`)
- [ ] **Sara Xatun** (h_019): `sedsala 15` + `Trabzon (1461)` + `dîya Uzun Hesen` (önceden YANLIŞ: 14. y.y. + Tehran + jina Mîr Bohtanê)

---

## B. Yazım onarımları (örnekleme yap)

### Birleşik gelecek zaman
**Test:**
- [ ] A2 → "Dema bê" dersi: tüm açıklamalar `Ez ê / Tu yê / Ew ê / Em ê` ayrı yazımıyla
- [ ] Yazma alıştırması (KU writing) ku_write_019: `Ez ê sibê biçim Stenbolê.`
- [ ] Yazma alıştırması ku_write_058: `Ew ê sibê were.`

### Ezafe düzeltmeleri
**Test:**
- [ ] A1 sözlük: `Êvara baş` (Êvar + ezafe -a) — `Êvar baş` değil
- [ ] B1: `Pîra min pir dilovan e` (önceden çift dişil-marker `Pîrêya`)

### Kelime düzeltmeleri
**Test:**
- [ ] A1: `Barandar` (önceden `Baranbar` — non-standart)
- [ ] A1 ayran örneği: `Ez mastawê vedixwim` (önceden `dixwim`)
- [ ] A2: `Kitêb` (kelime başında kısa i — önceden uzun î `Kîtêb` yanlış)

### Kültürel içerik
**Test:**
- [ ] Aynur Doğan / Cegerxwîn şair sayfaları: `Cegerxwîn` (önceden 5 yerde `Cigerxwîn`)
- [ ] Yemekler: `darçîn` (tarçın — önceden `dirêjberg` calque)

---

## C. Soru kalitesi (sample bazında)

**Test:**
- [ ] B2 ifade hakkı sorusu: 4 distractor, hepsi grammatical ve uniquely-eliminable (önceden çift-doğru)
- [ ] B2 basın özgürlüğü sorusu: distractor `civînê` (önceden çift-doğru `matbûatê`)
- [ ] A1 büyükbaba (Kal) sorusu: distractorlar parallel uzunlukta `Amca (baba tarafı)`, `Dayı (anne tarafı)`, `Baba`, `Büyükbaba`
- [ ] B2 "Li ber ketin" sorusu: 4 paralel uzunluk-tanım

---

## D. Genel akış kontrolleri

- [ ] Uygulama açılıyor (login screen, ana sayfa)
- [ ] CEFR level navigation çalışıyor (A1 → A2 → B1 → ...)
- [ ] Heritage track aktive edilebiliyor
- [ ] Çocuk modu girişi (memory match, picture match) çalışıyor
- [ ] Kültürel sözlükteki tarihi kişiler sayfası açılıyor
- [ ] Sözlük arama: "Êzîdîtî", "Cegerxwîn", "Şêweyê wêjeyî" sonuç dönüyor

---

## E. Browser DevTools (Console)

- [ ] Console errors: 0 (en azından kritik error yok)
- [ ] Network errors (404'ler) yok
- [ ] Asset (audio/image) yükleme hatası yok

---

## F. Bilinen risk: TTS uyumsuzluğu

Heritage diyaloğunda metin değişti ama ses dosyası eski:
- `assets/audio/heritage/dlg1_06.mp3` — yeni metin: `Ez ê çayekê ji bo te çêkim` (eski ses: `Ezê çay bikim`)
- `assets/audio/heritage/dlg4_07.mp3` — yeni metin: `Ez ê çayekê çêkim` (eski ses: `Ezê çay bikim`)

**Test:**
- [ ] Ses dinlendiğinde metin/ses uyuşmazlığını fark ediyor musun? Bu bilinen bir sınır — TTS yeniden sentez gerekiyor.

---

Test bittiğinde:
- ✅ Hepsi çalışıyor → "Seçenek A: commit + push" aşamasına geç
- ❌ Hata var → spesifik problemi bana anlat, ona göre düzelteyim
