# İçerik düzeltmeleri

Bu klasör LÛTKE içeriğinde yapılan her düzeltmenin kaydını tutar. Düzeltme elle
yapılmaz; bir tablo yazılır ve `tools/qa/duzelt.py` onu uygular.

## Dosyalar

| Dosya | Ne |
|---|---|
| `girdi/<tarih>_<konu>.tsv` | Uygulanan düzeltme tabloları (kimlik, alan, eski, yeni, kural, gerekçe) |
| `duzeltme.tsv` | Birikimli günlük: uygulanan her satır, tarihiyle |
| `../olcum/ses_bekleyen.tsv` | Metni değiştiği için hazır sesi kopan cümleler |
| `../olcum/cins_celiski.tsv` | Cinsiyeti karara bağlanamayan adlar (editör kuyruğu) |
| `../olcum/cins_kanit.tsv` | Her adın cinsiyet kanıtı |
| `../olcum/anlam_supheli.tsv` | Türkçe karşılığı sözlükle eşleşmeyen madde başları (okunacak) |

## Bir düzeltme nasıl yapılır

1. Kanıtı topla: `python tools/qa/cins_kanit.py <sözcük>`, `python Ziman/araclar/ara.py "<ifade>"`,
   `ku-tr-sozluk`. Tek kaynağa dayanma.
2. Tabloyu `girdi/` altına yaz. Bir cinsiyet düzeltmesi tek satır değildir: `cins`, `ez`,
   nottaki açıklama ve o ada izafe takan bütün örnek cümleler birlikte değişir.
3. Kuru çalıştır: `python tools/qa/duzelt.py docs/duzeltme/girdi/<tablo>.tsv`
   Bulunamayan satır varsa hiçbir şey yazılmaz.
4. Uygula: `... --uygula`
5. Kapıları çalıştır:

   ```bash
   dart run tool/export_content.dart
   python tools/qa/icerik.py --sinama
   python tools/qa/ziman_denetim.py --kapi
   python tools/qa/olcum.py
   flutter test
   ```

   Kültür ve ders metinleri denetleyiciye `content.json` üzerinden gider; dışa aktarım
   yapılmadan `ziman_denetim.py` eski metni görür.

## Sesler

Hazır ses metnin kendisiyle eşleşir. Bir cümlede tek harf değişince sesi kopar ve
uygulama o cümleyi sessiz gösterir (ses üreten dış servis çalışmıyor).
`ses_bekleyen.tsv` bu cümlelerin listesidir; ses yeniden üretilebildiğinde ilk iş budur.
Yalnız yazımı değişen (söylenişi aynı kalan) metinler için eski sesin kullanılması
ayrı bir iştir (plan: M2).

## Editöre gidenler

Bu turda uygulanan düzeltmelerin dayanağı sözlük ve korpus kanıtıdır, bir dil
editörünün okuması değildir. Üç liste editör bekliyor: `cins_celiski.tsv`,
`anlam_supheli.tsv` ve teyit için `duzeltme.tsv`.
