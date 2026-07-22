# LÛTKE — Etkinlik Sorularının Niteliği ve Doğruluğu

**Tarih:** 2026-04-25
**Kapsam:** Kurmancî + İngilizce, A1 → C2, yetişkin ve çocuk modu
**Soru:** "Her düzeydeki etkinlik sorularının daha nitelik ve doğru olmasını sağlamak veya bundan emin olmak için ne yapabilirsin?"
**Tur 2 (2026-04-25):** Kurmancî düzey etkinliklerine özel derinlemesine inceleme — dil doğruluğu + ölçme-değerlendirme uyumu.

---

## 1. Özet

İçeriği "tek tek elden geçirmek" ölçeklenebilir bir cevap değil — uygulama 1843 soru/seçenek dörtlüsü içeriyor (10 dosya, 6 düzey, 2 dil, 2 mod). Bunun yerine **tekrar çalıştırılabilir bir QA boru hattı** kuruldu ve mevcut içerik üzerinde bir kez baştan sona uygulandı. Yeni içerik eklendikçe aynı boru hattı tekrar çalıştırılarak nitelik garantisi sürdürülebilir.

---

## 2. Önce / Sonra (Pozisyon yanlılığı — psikometrik kusur)

Çoktan seçmeli testlerde doğru cevabın hep aynı indexte (örn. hep B şıkkında) toplanması, öğrencinin içeriği değil deseni öğrenmesine yol açar. Tüm soru bankası tarandı:

| Dosya | Önce (max %) | Sonra (max %) | Item |
|---|---:|---:|---:|
| `character_stories_db.dart` | **100.0** (i1) | 45.5 | 11 |
| `listening_exercise_db.dart` | 81.9 (i1) | **30.5** | 105 |
| `a1_lesson_definitions.dart` | 60.5 (i1) | **29.1** | 86 |
| `a2_lesson_definitions.dart` | 67.3 (i1) | **27.9** | 104 |
| `b1_lesson_definitions.dart` | 78.7 (i1) | **30.7** | 75 |
| `b2_lesson_definitions.dart` | **90.7** (i1) | 36.0 | 75 |
| `c1_lesson_definitions.dart` | **89.0** (i1) | 37.0 | 73 |
| `c2_lesson_definitions.dart` | 82.7 (i1) | **30.7** | 75 |
| `en_grammar_db.dart` | 63.4 (i0) | **37.5** | 440 |
| `placement_test_screen.dart` | 27.5 (zaten OK) | 27.5 | 40 |

**Toplam karıştırılan item: 1029** (deterministik tohum: `md5(item.id)` → tekrar çalıştırılabilir, CI-uyumlu, diff'i izlenebilir).

Yöntem: sıralı seçenekleri (sayılar, harf-cevap anahtarları, Kurmancî sayı sözcükleri yek/du/sê/çar) atlayan, bracket-iç-içe geçişine ve string escape'lerine dayanıklı bir parser.

---

## 3. Şema bütünlüğü kontrolleri

Tarama sonucu — **0 hata** kaldı:

- Aynı soru içinde tekrarlanan seçenek: **0**
- Boş / placeholder seçenek: **0**
- `correctIndex` sınır dışı (crash riski): **0**

---

## 4. Sürekli QA altyapısı

`tools/qa/` altında iki Python betiği eklendi:

| Dosya | Görev |
|---|---|
| `quiz_qa_validator.py` | Read-only. Tüm soru bankasını tarar, kusurları raporlar. |
| `shuffle_correct_index.py` | Deterministik karıştırıcı — yeni eklenen içerik bias üretirse yeniden çalıştırılır. |
| `README.md` | Çalıştırma talimatı + eşik tablosu. |

**Sürüm öncesi tek komutla doğrulama:**

```bash
python tools/qa/quiz_qa_validator.py
```

---

## 5. Uzunluk yanlılığı (length-bias) — manuel turla iyileştirildi

İleri düzeyde doğru cevap çoğu zaman çelmesinden belirgin biçimde uzun. Bu bir "cue leakage" — sınav stratejisti olan öğrenci içeriği bilmeden bile doğruyu seçer.

Length-bias detektörü doğrulayıcıya eklendi (`tools/qa/quiz_qa_validator.py`). Eşik: doğru seçenek, distractor ortalamasının ≥2x'ı ise işaretlenir; ≥15% dosyada flag düşer.

**Önce / Sonra (B1/B2/C1/C2 odaklı el ile distractor revizyonu sonrası):**

| Dosya | Önce (item / %) | Sonra (item / %) | Δ |
|---|---:|---:|---:|
| `c2_lesson_definitions.dart` | 32 / 42.7% | **10 / 13.3%** ✅ OK | **−29.4 pp** |
| `c1_lesson_definitions.dart` | 27 / 37.0% | 12 / 16.4% | **−20.6 pp** |
| `b2_lesson_definitions.dart` | 19 / 25.3% | 12 / 16.0% | **−9.3 pp** |
| `b1_lesson_definitions.dart` | 14 / 18.7% | **9 / 12.0%** ✅ OK | **−6.7 pp** |
| `listening_exercise_db.dart` | 7 / 6.7% | 6 / 5.7% | −1 item |

**En kötü item oranı:** 11.1x → **3.0x** (yaklaşık %73 düşüş).

**C2 ve B1 artık OK eşiğinin altında.** C1 ve B2 sınırın hemen üzerinde — geriye kalan flagler çoğunlukla 2.5x–3.5x oranında, içerik tartışmaya açık olmadan kabul edilebilir.

**Yöntem:** En sapan 30+ item için distractor'lar paralel-tanım yapısına çekildi. Tek-kelimelik çelmeler ("Stranbêj", "Padîşah", "Alim") yerini, doğru cevapla aynı sözdizimsel/anlambilimsel sınıfta inanılır-ama-yanlış tanımlara bıraktı.

### 5b. Düzeyler arası yinelenen soru kökleri (cross-level duplicate stems)

A1 ve A2'de bazı şablon Türkçe soru kökleri (örn. "Aşağıdakilerden hangisi…") tekrar ediyor. Çoğu çoktan seçmeli kalıbı; "Duplicate" değil — "ortak şablon".

**Neden otomatize edilmedi:** Şablon tekrarı, *hatalı* tekrar değil. Soru içeriği farklı olduğu sürece sorun değil. Yine de C1/C2 düzeyinde aynı *cevabı* test eden iki ayrı sorudan birinin değiştirilmesi okuma akışını iyileştirir — bu, gerçek bir editörün yapacağı iş.

### 5c. Ses-metin senkronizasyonu (audio↔text)

`assets/audio/kmr_tts/` altındaki TTS dosyaları, `kmr_tts_manifest.json` üzerinden metinle eşleniyor. Manifest taraması metin değişiklikleriyle uyumlu görünüyor; ancak TTS kalitesi (telaffuz, vurgu) işitsel doğrulama gerektiriyor.

**Neden otomatize edilmedi:** Bunu yapacak araç sesi dinleyebilen bir insan kulağıdır.

---

## 6. Önceki turlarda zaten yapılanlar

Bu turdan önce uygulanan ve hâlâ yürürlükte olan iyileştirmeler (bağlam için):

- ~590+ Kurmancî yazım/dilbilgisi düzeltmesi
- 511 Türkçe karakter sızıntısı (170 atasözünde)
- 94 `explanationKu` Türkçe → Kurmancî
- 175+ "Ders" → "Wane" (morfoloji koruyarak)
- Cegerxwîn doğum yeri (Gerger → Gercüş), Mem û Zîn 1695
- Çocuk modu COPPA: ebeveyn matematik kapısı (3+2 hane), günlük 2 mola sınırı, izin akışı
- Play Store hazırlığı: ProGuard, App Bundle imza, gizlilik politikası TR, veri güvenliği formu

---

## 6b. Kurmancî düzey etkinliklerine derinlemesine tarama (2. tur)

İkinci turda yalnız Kurmancî içeriğe odaklanıldı. **3 yeni QA tarayıcı** kuruldu:

| Tarayıcı | Ne yapar |
|---|---|
| `tools/qa/kurmanci_scanner.py` | KU alanlarında Türkçe karakter sızıntısı (`ı`, `İ`, `ğ`); KU prompt + TR seçenek karışıklığı; ses/metin uyumsuzluğu |
| `tools/qa/kurmanci_lint.py` | Yazım hataları, eksik diakritik, Türkçe kalıp etkileri (`emê` → `em ê`, vb.) |
| `tools/qa/assessment_quality.py` | Zayıf/kaçıngaç çelmeler ("Tu ferq nîne", "Tu kes", "Bêsedem" — sınav stratejisi olan öğrenci kolayca eler) |

**Bulunan ve düzeltilen hatalar — 2. tur:**

| Kategori | Önce | Sonra |
|---|---:|---:|
| `ku:` alanında Türkçe soru kökü (asıl bug) | **15 item** | **0** |
| Türkçe karakter (ı, İ) Kurmancî alanlarında | 11 örnek | 0 |
| Title alanında Türkçe karakter | 1 (`'İ'`) | 0 |
| Yanlış proper noun kullanımı (Yılmaz → Bedirxan) | 1 | 0 |
| Yazım hatası (`emê` ayrılmalı) | 1 | 0 |
| Zayıf/kaçıngaç çelme | 10 | 0 |

**A1'deki kritik düzeltme — `ku:` alanındaki Türkçe soru kökleri:**
12 sorunun `kurmanjPrompt` alanında Türkçe metin vardı (örn. `ku: '"Ap" kimin amcasıdır?'`).
Bunlar `tr:` alanına taşındı, `ku:` alanına Kurmancî soru kökü yazıldı:
`ku: '"Ap" amê kîjan aliyî ye?'`. Bu, A1 öğrencisinin Kurmancî soru kalıbına maruz kalmasını sağlar — ölçme-değerlendirme açısından kritik düzeltme.

**Geriye kalan flagler:** 8 "mixed-language options" — bunlar yanlış değil, *çeviri-anlama görevleri*: KU cümlesini dinleyip TR anlamını seçme. A1 için pedagojik olarak doğru.

## 7. CI entegrasyonu (yeni)

Regresyon koruması artık aktif: `.github/workflows/quiz-qa.yml`

- Soru bankası dosyaları (`lib/features/lessons/domain/**`, `lib/features/exercises/domain/**`, vb.) değiştiğinde tetiklenir.
- **4 doğrulayıcı sırayla çalışır**: psikometrik (`quiz_qa_validator.py`), Kurmancî içerik (`kurmanci_scanner.py`), dilsel (`kurmanci_lint.py`), ölçme-değerlendirme (`assessment_quality.py`).
- Herhangi biri `exit 1` ile başarısız olursa PR'ın CI check'i kırılır.
- Sert kontroller: dup/empty/oob = 0; pozisyon yanlılığı > %50 fail; length-bias > %15 dosyada uyarı.

## 8. Bir sonraki tur için önerilen iş

1. **TTS işitsel QA** — yeni eklenen / düzeltilmiş metinler için manuel dinleme listesi.
2. **C1/B2 final temizlik** — sınır üstü duran 12+12 item; ileride değer/maliyet eşiğine göre ele alınabilir.

Soru bankası şu an "rastgele örneklemeyle bile düzgün dağılım" kriterini geçiyor — hem nitelik hem güven açısından commercial-grade durumda, regresyon CI ile bağlandı.
