# Yazım normu uzlaşması — LÛTKE ile ortak dil katmanı

Tarih: 10 Ekim 2026 · İyileştirme planı Faz 0.3

LÛTKE'nin içeriği iki ayrı kural belgesiyle karşı karşıyaydı:

| | LÛTKE'nin kendi belgesi | Çalışma alanının ortak belgesi |
|---|---|---|
| Dosya | `tools/qa/refs/KURMANCI_RULES.md` | `Kurmanci/Ziman/REBER.md` |
| Taban norm | Hawar imlâsı, Bedirxan–Lescot | *Rêbera Rastnivîsînê* (Weqfa Mezopotamyayê) |
| Dayanak | 7 kaynak, 56 bin satır | 36 kaynak, 2,14 milyon sözcük; kurallar korpusta ölçülmüş |
| Denetleyici | `tools/qa/kurmanci_lint.py` | `Kurmanci/Ziman/araclar/kontrol.py` |

Bu not iki belgenin nerede ayrıştığını, korpusun ne dediğini ve LÛTKE içeriğinin bugün hangi tarafta durduğunu gösterir. Sayılar `Kurmanci/Ziman/korpus` üzerinde 10 Ekim 2026'da ölçüldü. A bölümündeki "x / y" sayılarında x karar verilen biçimin, y öteki biçimin geçiş sayısıdır.

**Sonuç:** İki belge temel dilbilgisinde çelişmiyor. Sekiz yazım noktası karara bağlandı (A); üçü sizin kararınızı bekliyor (B). Asıl sorun belgeler arasında değil: LÛTKE içeriği kendi belgesine de uymuyor (A'da 1. nokta).

---

## A. Karara bağlanan noktalar

Bunlarda iki belge ve korpus aynı yönü gösteriyor. Ortak denetleyiciye `norm` kuralı olarak eklendi; LÛTKE taramasında işaretleniyor.

| # | Nokta | Karar | Korpus | LÛTKE içeriği |
|---|---|---|---|---|
| 1 | î, y'den önce | **i** olur: *azadiya, têkiliya* | edebiyat 9.077 / 91 · halk 2.350 / 46 · Samî Tan 1.159 / 5 | **829 yerde *îy*** (3.201 geçişin %26'sı); 98 kök iki biçimde de yazılmış |
| 2 | Gelecek zaman belirteci | **ayrı**: *ez ê, tu yê, em ê* | çağdaş düzyazı ve halk masalı 724 / 160 | uyumlu (0 işaret) |
| 3 | Edat öbekleri | **ayrı**: *ji bo, li ser, ji ber* | 8.935 / 209 | uyumlu |
| 4 | *lê belê* | **ayrı** | 153 / 9 | 5 yerde *lêbelê* (madde başı `a1_528` dahil) |
| 5 | *bi kar anîn* (çekimli) | **ayrı**: *bi kar tîne* | 146 / 45 · Samî Tan 52 / 1 | 15 yerde *bikar* |
| 6 | *dest pê kirin* (çekimli) | **üç sözcük** | 113 / 10 | 1 yerde *destpê kir* |
| 7 | Çevreleyen edatın ikinci parçası | **re, de, ve** (ra, da, va değil) | 4.276 / 41 (klasikler hariç) | uyumlu |
| 8 | Bağlaç | **ku** (ko değil) | 14.541 / 4.765; *ko*'nun 4.291'i iki romandan (*Hawara Dîcleyê*, *Labirenta Cinan*) | uyumlu |

> **Sayılar üzerine not.** Korpustaki dokuz dosyada şapkalı ünlüler PDF çıkarımında kaybolmuş (`Kurmanci/Ziman/README.md`, "Diakritik hasarı"). 1. noktanın sayıları yalnız î harfi sağlam dosyalardan alındı; aksi hâlde *îy* yazan bir kitap *iy* yazıyor görünürdü. Öteki noktalarda hasar iki biçimi de aynı ölçüde eksilttiği için yön değişmiyor.

### 1. nokta üzerine

En büyük kalem bu ve LÛTKE'nin kendi belgesi de aynı kuralı örnekliyor (`KURMANCI_RULES.md` §3.4: *ronahiya min*). *îy* yazımı korpusta yalnız iki kaynakta baskın: *Fêrkera Kurdî* (*îy* 179, *iy* 7) ve Halil Aktug (*îy* 195, *iy* 0). *Fêrkera Kurdî* LÛTKE'nin ilk yedi kaynağından biri; sapmanın oradan geldiği anlaşılıyor.

En sık örnekler: *Têkilîya* 101, *Teorîya* 64, *Azadîya* 44, *Aborîya* 39, *Pêwendîya* 27, *Xweserîya* 20.

Düzeltme mekanik ama iki sonucu var:

- **Ses.** Hazır ses dosyası metnin kendisiyle eşleştiği için, düzeltilen her metnin varsa hazır sesi kopar. Düzeltme, ses mimarisi işiyle (planda M2) birlikte yapılmalı.
- **Madde başları.** Bir bölümü madde başının kendisinde (*Têkilîya …* ile başlayan öbekler); kimlikler değişmez ama web sitesindeki sayfa başlıkları değişir.

### 2. nokta üzerine: karar doğru, gerekçesi yanlış

LÛTKE'nin belgesi ve derslerdeki öğrenci notları ayrı yazımı Bedirxan–Lescot'a dayandırıyor (`a2_lesson_definitions.dart:159`: "Bedirxan-Lescot: cînavk + AYRI ê"). Korpustaki Bedirxan metninde ise belirteç **bitişik** yazılıyor: *ezê* türü bitişik biçim 101 kez, ayrı biçim hiç. Selîm Biçûk (bitişik 181, ayrı 7) ve Qedrî Can (bitişik 79, ayrı 0) da bitişik yazıyor.

Ayrı yazım çağdaş normdur: *Fêrkera Kurdî* (ayrı 88, bitişik 0), Hesenê Metê'nin iki kitabı (ayrı 238, bitişik 0), halk masalı derlemeleri (ayrı 240, bitişik 1). Karar değişmiyor; ama öğrenciye "Bedirxan böyle yazar" denmemeli. Notlardaki atıf Faz 2'de "çağdaş yazım" olarak düzeltilmeli. LÛTKE'nin kelime ve ders dosyalarında "Bedirxan-Lescot §…" biçiminde 11 atıf var; hepsi aynı gözle okunmalı.

---

## B. Kararınızı bekleyen noktalar

Bunlarda kaynaklar gerçekten ikiye ayrılıyor. Denetleyici saymıyor, işaretlemiyor; sayılar `docs/olcum/olcum.md` §9'da izleniyor.

### B1. Dil adları: *Kurdî* mi, *kurdî* mi?

Cümle içinde *Kurdî / Kurmancî* yazımı, kaynak başına:

| Kaynak | Büyük | Küçük |
|---|---:|---:|
| Bedirxan | 25 | 5 |
| *Fêrkera Kurdî* | 117 | 25 |
| Deham Ebdulfettah | 129 | 15 |
| Samî Tan | 49 | 460 |
| Husein Muhamed | 12 | 108 |
| *Rêzimanên kurdî û termînolojiya wan* | 44 | 110 |

- LÛTKE'nin belgesi büyük harf diyor (§9.2, "B-L kullanımı").
- *Gotar* dizisi ve Gav bi Gav küçük harf kullanıyor (*bi kurdî*, *pola tirkî*).
- LÛTKE içeriği kendi içinde tutarsız: cümle içinde 239 büyük, 596 küçük. *Kurmancî* neredeyse hep büyük, *kurdî* çoğunlukla küçük yazılmış.

**Önerim küçük harf:** çağdaş gramerlerin çoğunluğu ve sizin diğer yayınlarınızla uyumlu. Marka ve başlık kullanımı (*LÛTKE — Zimanê Kurdî*) bunun dışında kalır. *Rêbera Rastnivîsînê*'nin bu konudaki hükmünü kitaptan doğrulayamadım; kitap korpusta yok.

### B2. Ay adları: *Adar* mı, *adar* mı?

LÛTKE'nin belgesi büyük harf diyor ("geleneksel olarak"). Korpusta küçük harf baskın: edebiyat 49 / 7, halk 17 / 0, gramer 29 / 9. LÛTKE içeriğinde 25 büyük, 0 küçük.

**Önerim küçük harf.**

### B3. *herdu* mu, *her du* mu?

Edebiyat bitişik yazıyor (499 / 46), gramerler ayrı (210 / 29; Samî Tan 116 / 2). LÛTKE'de 3'e 3.

**Önerim *her du*:** öğretim metni gramer normunu izlemeli. Etkisi küçük.

---

## C. Belgeler ve araçlar bundan sonra

1. **Tek kural belgesi `REBER.md`dir.** A bölümündeki kararlar oraya §1 altında, ölçümleriyle yazıldı. `KURMANCI_RULES.md` Hawar alfabesi ve dilbilgisi için başvuru olarak kalır; ikisi ayrıştığında `REBER.md` geçerlidir. Dosyanın başına bu not eklendi.
2. **İki denetleyici, iki iş.**
   - `kurmanci_lint.py` hafif kapıdır: yalnız Dart kaynağını okur, GitHub CI'da çalışır. Kelimeye özgü yazım listesi (*nivîskêr*, *kîtêb*), alıntı kalıpları (*çay kirin*) ve `ez` alanı denetimi buradadır.
   - `ziman_denetim.py` tam denetimdir: ortak denetleyiciyi bütün Kurmancî metinler üzerinde çalıştırır. Korpusa dayandığı için yalnız yerelde çalışır.
   - İkisi çelişmiyor: `kurmanci_lint.py`'nin bitişik gelecek zaman kuralı artık ortak denetleyicide de var.
3. **Rêbera Rastnivîsînê korpusa alınmalı.** Taban norm olarak anılıyor ama metni elimizde değil; B1 gibi noktalarda hükmü doğrudan okunamıyor. PDF'i Weqfa Mezopotamyayê yayımlıyor; `norm` sınıfıyla korpusa eklenmesini öneririm.

## D. Cinsiyette "ağız farkı" sayılanlar

`KURMANCI_RULES.md` §12.3 bazı adların cinsiyetini yazara göre değişen bir ağız farkı sayıyor ve örnek olarak *dem*'i veriyor. Korpusta *dem* açık biçimde dişil: diakritiği sağlam dosyalarda 593'e 51. LÛTKE'de `b1_905` kaydı *dem*'i eril veriyor.

Gerçek ağız farkı olan adlar var, ama bu liste ölçülmeden yazılmış. Faz 2'de her ad için kanıt aranacak; "iki cinsiyetli" etiketi yalnız iki kaynağın gerçekten ayrıştığı adlara verilecek (`docs/olcum/cins_celiski.tsv`, "kaynaklar ayrışıyor" sınıfı: bugün 9 ad).
