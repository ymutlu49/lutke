# Cümle havuzu

Etkinliklerde kullanılan örneklerin (`her`) çoğu cümle değil, öbek: *Rengê tarî.*,
*Neyar û dost.* Bu klasör onların yerine geçen cümleleri tutar: her biri Türkçe
çevirili, düzeyin uzunluk ölçüsünde, korpus tanığına dayalı.

## Dosyalar

| Dosya | Ne |
|---|---|
| `havuz.tsv` | Havuzun kendisi: kimlik, sıra, cümle, çeviri, kaynak, durum |
| `../olcum/cumle.json` | Son ölçüm (`cumle.py --olc`) |
| `../olcum/cumle_taban.json` | Faz 3 başındaki durum |
| `lib/features/lessons/domain/ornek_ceviri_db.dart` | Havuzdan üretilen çeviri tablosu (elle düzenlenmez) |

Aday dosyaları (`aday_<düzey>.tsv`) depoda **değildir**: korpustan birebir cümle
içerirler ve korpus teliflidir. `Kurmanci/Lutke/cumle_havuzu/` altına yazılırlar.

## Bir kelimeye cümle eklemek

1. Adayları çıkar: `python tools/qa/cumle.py --aday a2` (ya da `--kat xwarin` ile tek birim).
   Adaylar "bütün sözcükleri öğrencinin bildiği cümle önce" sırasıyla gelir.
2. `havuz.tsv`ye satır yaz. Adayı aynen almak yerine uyarlamayı tercih et (özne, iyelik,
   zaman). Yeni yazdığın cümlenin eşdizimini ara: `python Ziman/araclar/ara.py "..." --say`.
   Sıfır tanık çıkarsa sözlüğe bak; orada da yoksa başka bir eşdizim seç.
3. Sına: `python tools/qa/cumle.py --denetle`
   Uzunluk ölçüsü, yüklem, madde başının cümlede geçmesi, tanınmayan biçim, dil denetimi.
4. İşle:

   ```bash
   python tools/qa/cumle.py --uygula
   python tools/qa/duzelt.py docs/duzeltme/girdi/cumle_havuzu.tsv --uygula
   dart run tool/export_content.dart
   python tools/qa/icerik.py --sinama
   python tools/qa/ziman_denetim.py --kapi
   flutter test
   ```

## Uygulamada

Havuzdan gelen cümlenin Türkçesi kelime ayrıntısında, kelime kartının arkasında ve
quiz açıklamasında cümlenin altında görünür; "Türkçe göster" kapalıyken görünmez.
Çeviri cümlenin kendisiyle eşleşir: cümle değişirse `--uygula` yeniden çalıştırılır
(`test/ornek_ceviri_test.dart` kopukluğu yakalar).

## Bilinen bedel

Değişen cümlenin hazır sesi kopar (`docs/olcum/ses_bekleyen.tsv`). Ses üreten servis
çalışmadığı için havuz cümleleri şimdilik sessiz; dinleme etkinliği yalnız sesi olan
cümleleri sorduğundan bu cümleler oraya girmez.

## Durum

`durum` sütunu `taslak` olan cümleleri dil editörü görmedi.
