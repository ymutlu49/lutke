# LÛTKE — Zimanê Kurdî

**Kurmancî dil öğretim uygulaması**

Prof. Dr. Yılmaz Mutlu & Prof. Dr. Osman Aslanoğlu ortaklığında.

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
│       ├── domain/  # 3.900 kelime (A1-C2) + Ders tanımları
│       ├── data/    # LessonRepository + FSRS-5
│       └── presentation/
└── shared/widgets/  # Egzersiz widgetları (FSRS 4-rating)
```

## İçerik

| Düzey | Kelime | Ders |
|-------|--------|------|
| A1    | 400    | 20   |
| A2    | 700    | 25   |
| B1    | 1500   | 30   |
| B2    | 500    | 35   |
| C1    | 500    | 15   |
| C2    | 300    | 12   |
| **Toplam** | **3.900** | **137** |

## Ses Dosyaları

`assets/audio/` klasörüne anadil konuşucu kaydı ekleyin.
Format: 44.1kHz, OPUS, her kelime için yavaş + normal + cümle.
