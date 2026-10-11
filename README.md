# LÛTKE — Zimanê Kurdî

**Kurmancî dil öğretim uygulaması**

Prof. Dr. Yılmaz Mutlu tarafından geliştirilmiştir.

## Kurulum

```bash
# 1. Bağımlılıklar
flutter pub get

# 2. Firebase yapılandırma (lutke-kurdish projesi oluşturulmalı)
flutterfire configure --project=lutke-kurdish

# 3. Drift + Riverpod kod üretimi
dart run build_runner build --delete-conflicting-outputs

# 4. Çalıştır
flutter run
```

## Proje Yapısı

```
lib/
├── core/            # Sabitler, DB, Router, Servisler, Utils
├── features/        # Auth, Dersler, Gamification, Profil
│   └── lessons/
│       ├── domain/  # 4.208 kelime kaydı (A1-C2) + ders tanımları
│       ├── data/    # LessonRepository + FSRS (henüz devrede değil)
│       └── presentation/
└── shared/widgets/  # Egzersiz widgetları (FSRS 4-rating)
```

## İçerik

Sayılar `python tools/qa/olcum.py` ile ölçülür; güncel rapor `docs/olcum/olcum.md` (10 Ekim 2026).

| Düzey | Kelime kaydı (uygulama) | Web sitesinde | Ders | Egzersiz |
|-------|------:|------:|-----:|-----:|
| A1    | 510   | 510   | 20   | 101  |
| A2    | 700   | 700   | 25   | 129  |
| B1    | 1.555 | 951   | 15   | 90   |
| B2    | 598   | 598   | 15   | 90   |
| C1    | 510   | 510   | 15   | 90   |
| C2    | 335   | 335   | 15   | 90   |
| **Toplam** | **4.208** | **3.604** | **105** | **590** |

- 4.208 kayıt 3.732 farklı madde başına karşılık gelir; çocuk modu ayrıca 92 kayıt taşır.
- Uygulama ekranları B1 için `kB1All` listesini, web dışa aktarımı (`tool/export_content.dart`) `kB1Temam` listesini kullanır; iki sütunun farkı buradan gelir.
- 105 ders yazılmış durumda ama henüz öğrencinin izlediği yola bağlı değil; yalnız yönetici panelinde ve web sitesinde görünür.
- İyileştirme planı: `Kurmanci/Lutke/IYILESTIRME_PLANI.md`.

## Ses Dosyaları

`assets/audio/words/` altındaki 9.938 dosyanın tamamı yapay sestir (amedcj/kmr_tts, 16 kHz WAV);
anadil konuşur kaydı henüz yok. Hazır ses kapsamı `docs/olcum/olcum.md` §7'de.
