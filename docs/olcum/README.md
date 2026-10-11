# docs/olcum — içerik ölçümü

İyileştirme planının sayıları buradan gelir. Her faz bitince ölçüm yeniden çalıştırılır ve taban ile karşılaştırılır.

```bash
python tools/qa/olcum.py            # olcum.md ve olcum.json'u yeniler
python tools/qa/olcum.py --taban    # ayrıca bugünkü değerleri taban yapar (yalnız faz başında)
python tools/qa/ziman_denetim.py --kapi   # kayıtta olmayan yeni dil işareti varsa 1 ile çıkar
python tools/qa/ziman_denetim.py --yaz    # açık işaret kaydını yeniler (düzeltmelerden sonra)
```

Windows'ta önce: `set PYTHONUTF8=1` (PowerShell: `$env:PYTHONUTF8 = 1`).

| Dosya | Ne | Kim yazar |
|---|---|---|
| `olcum.md` | Okunacak rapor | `olcum.py` |
| `olcum.json` | Aynı sayılar, makine için | `olcum.py` |
| `taban.json` | Karşılaştırma tabanı (10 Ekim 2026) | `olcum.py --taban` |
| `cins_celiski.tsv` | Cinsiyeti en az bir kaynakla çelişen adlar; editör kuyruğu | `olcum.py` |
| `taniksiz.tsv` | Hiçbir kaynakta tanığı olmayan tek sözcüklü maddeler | `olcum.py` |
| `eksik_cekirdek.tsv` | Korpusun çekirdek söz varlığında olup LÛTKE'de geçmeyen maddeler | `olcum.py` |
| `ziman_isaret.tsv` | Dil denetiminin açık işaretleri (bilinen borç) | `ziman_denetim.py --yaz` |

## Nereden okur

- **Kelimeler** Dart kaynağından (`lib/features/lessons/domain/*_kelime_db.dart`), uygulamanın kullandığı listelerle: `kA1TamListe`, `kA2TamListe`, `kB1All`, `kB2All`, `kC1All`, `kC2All`. Ayrıştırıcı `tools/qa/icerik.py`; `--sinama` ile `content.json`'a karşı sınanır (10 Ekim 2026: altı düzeyde alan düzeyinde birebir).
- **Ders, diyalog, kültür, dilbilgisi, atasözü** `website/data/content.json`dan. Dosya Dart kaynağından eskiyse rapor uyarır; `dart run tool/export_content.dart` ile yenilenir.
- **Dinleme, konuşma, yazma, hikâye, yerleştirme testi** Dart dosyalarından alan adıyla.
- **Tanıklık, kapsam, cinsiyet, dil denetimi** çalışma alanının ortak katmanından: `Kurmanci/Ziman` ve `Kurmanci/ku-tr-sozluk`. Bu depoda değildir; bulunamazsa o bölümler atlanır.

## Uygulama ile web sitesi aynı sayıyı vermez

Dışa aktarım (`tool/export_content.dart`) B1 için `kB1Temam` listesini kullanır: 951 kayıt. Ekranlar `kB1All` kullanır: 1.555 kayıt. Bu yüzden web sitesi 3.604 kelime gösterir, uygulamada 4.208 kayıt vardır. Ölçüm uygulamayı esas alır; web sayısı ayrı satırda durur.

## Ölçülerin sınırları

- **Yüklemsiz örnek** sezgiseldir: örnekte koşaç ya da çekimli fiil arar. Çekimli fiili Wîkîferheng'in biçim tablosundan tanır; tabloda olmayan fiil biçimleri kaçabilir. Birkaç puan oynar; düzeyler arası eğilim güvenilirdir.
- **Çekirdek söz varlığı** korpusun edebiyat ve halk anlatısı bölümünden, diakritiği sağlam 12 dosyadan çıkar; en az 4 dosyada geçen maddeler alınır. Biçimler madde başına yaklaşık bir çözücüyle bağlanır (%86). Çekimli zamirler (*van*, *wan*) ve yazım değişkeleri (*ko*, *pirr*) ayrı madde gibi görünebilir; eksik listesi elle okunmalıdır.
- **Cinsiyet** iki kaynağa bakar: Wîkîferheng etiketi ve korpustaki izafe sayımı (`-a` dişil, `-ê` eril; en az 6 geçiş, bir yöne en az %80). "İki kaynak hemfikir" satırları güvenilirdir. "Yalnız Wîkîferheng" satırları tek kaynağa dayanır ve gönüllü verisidir; editör onayı olmadan düzeltilmez. Korpus sayımı yalnız diakritiği sağlam dosyalardandır.
- **Tanıksız madde** "yanlış" demek değildir; sözlüklerde ve korpusta karşılığı bulunamadı demektir. Yeni terimler ve özel adlar da bu listeye düşer.
- **Hazır ses** `tts_asset_manifest.dart` içindeki eşleştirmenin Python eşiyle sayılır; dosyanın diskte olup olmadığına bakmaz.
- **Dil denetimi** karar vermez, işaretler. Açık işaretlerin bir bölümü sahte uyarıdır; incelenip hata olmadığı anlaşılanlar gerekçesiyle `tools/qa/ziman_muaf.tsv`ye yazılır.
