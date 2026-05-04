# LÛTKE — Play Store Listing Content

## App Name (50 char max)
LÛTKE — Kurmancî Öğren

## Short Description (80 char max)
Kurmancî öğren! A1-C2 seviyeleri, sesli alıştırmalar, kültürel içerik.

## Full Description (4000 char max)

```
LÛTKE — Zimanê Kurdî
Kurmancî (Kuzey Kürtçe) dil öğretim uygulaması

Prof. Dr. Yılmaz Mutlu tarafından geliştirilmiştir.

🎯 ÖZELLİKLER

📚 Kapsamlı İçerik
• 6 CEFR seviyesi: A1, A2, B1, B2, C1, C2
• 137 ders, 3.900+ kelime
• Hawar (Bedirxan) standardı

🎓 Öğrenme Yöntemi
• FSRS-5 spaced repetition algoritması
• Audio-visual flashcards
• Ses kaydıyla telaffuz pratiği
• Mini-diyaloglar ve heritage senaryolar

🎨 Kürt Kültürü
• 12 ünlü Kürt sanatçı (Şivan Perwer, Ciwan Haco, Aynur Doğan...)
• 12 destan ve efsane (Mem û Zîn, Şahmaran, Newroz...)
• 3.000+ atasözü (Yılmaz Mutlu derlemesi)
• Klasik şairler (Ehmedê Xanî, Melayê Cizîrî, Cegerxwîn)

🌟 Heritage Yolu
İkinci nesil Kürtler için özel "Rêya Malê" — büyükanne ve aile diyaloglarıyla başlayın.

👶 Çocuk Modu (LÛTKE ZAROK)
7-10 yaş için özel maskot Karik ile öğrenim.
COPPA uyumlu, reklamsız, güvenli.

♿ Erişilebilirlik
• OpenDyslexic font desteği
• Büyük tip, hareket azaltma
• Reading ruler (disleksi yardımı)
• TTS (metin-konuşma)

🌍 İngilizce Track
Hem Kurmancî hem İngilizce öğrenim — tek uygulama.

📜 Akademik Temel
• Bedirxan-Hawar alfabesi (1932 standartı)
• Kemal Badıllı dilbilim kaynakları
• Institut Kurde de Paris referansları

🎁 7 Gün Ücretsiz Deneme
Yıllık abonelik 299 ₺. Reklam yok, kart bilgisi olmadan deneyin.

📞 İletişim
info@lutke.app
www.lutke.app
```

## In-App Products / Subscriptions

### Yıllık Premium Abonelik
- **SKU (Play Console):** `lutke_yearly_299_try`
- **Fiyat:** 299 ₺ (TRY) / yıl
- **Süre:** 365 gün, otomatik yenilemeli
- **Cayma:** Play Store → Ödemeler ve abonelikler menüsünden istenildiği zaman
- **Free trial:** 7 gün (Play Console: "Introductory price → Free trial")
- **Tek seferlik ücretsiz deneme** (account-level — restore akışında dikkate alınır)

### Play Console Setup Steps
1. Monetize → Subscriptions → Create subscription
2. Product ID: `lutke_yearly_299_try`
3. Name: `LÛTKE Premium — Salane / Yıllık`
4. Description: `Tev de Kurmancî bê sînor — hemû ast, hemû çalakî.`
5. Base plan: Auto-renewing, 1 year, 299 TRY
6. Offer: 7-day free trial (eligible: new subscribers)
7. Tax: KDV %18 (digital service)
8. Save & activate

## What's New (500 char max — for v1.0.0)

```
🎉 LÛTKE'ye hoş geldiniz!

İlk sürüm:
• 6 CEFR seviyesi (A1-C2)
• 137 ders, 3.900+ kelime
• Heritage + Genel öğrenim yolu
• Çocuk Modu (LÛTKE ZAROK)
• OpenDyslexic + erişilebilirlik
• Kurmancî TTS desteği

Geri bildiriminizi bekliyoruz: info@lutke.app
```

## Categorization

- **Category:** Education
- **Tags:** Language Learning, Kurdish, Kurmancî, CEFR
- **Content rating:** Everyone (with parental gate for child mode)
- **Target age range:** 7+ (with child mode), 13+ (general)

## Contact Information (Required)

- **Email:** info@lutke.app *(MUST BE REAL & MONITORED)*
- **Phone:** *(optional, but increases trust)*
- **Website:** https://lutke.app *(MUST BE LIVE)*

## Required URLs (Play Store will check)

- **Privacy Policy:** https://lutke.app/privacy
- **Terms of Service:** https://lutke.app/terms

## Required Graphics (Pixel sizes)

- ⚠️ **App icon:** 512×512 PNG (32-bit, no transparency in border)
- ⚠️ **Feature graphic:** 1024×500 PNG/JPG (no transparency)
- ⚠️ **Phone screenshots:** 2-8 images, 16:9 or 9:16, min 320px, max 3840px
- ⚠️ **7" tablet screenshots:** Optional but recommended (2-8 images)
- ⚠️ **10" tablet screenshots:** Optional but recommended (2-8 images)
- ⚠️ **Promo video:** Optional, YouTube link

## Recommended Screenshot Sequence

1. **Welcome/Landing** — "Ji peyvekê heya welatekî" (Bir kelimeden bir vatana)
2. **Onboarding** — "Tu axêverê mîratî yî?"
3. **Home with skill tree** — Visual learning path
4. **Lesson exercise** — Multiple choice with audio
5. **Speaking practice** — Microphone interface
6. **Cultural content** — Mem û Zîn or Cegerxwîn page
7. **Profile/streak** — Gamification view
8. **Child mode** — Karik mascot (if child mode emphasized)

## Localization (App descriptions)

- 🇹🇷 **Turkish** (primary): Yukarıdaki TR metin
- 🇬🇧 **English** (recommended for international reach): TBD
- 🌍 **Kurmancî** (Kurdish Latin) — TBD

---

## Submission Checklist

### Pre-submission
- [ ] Real Firebase configuration (`firebase_options.dart`)
- [ ] Real keystore configured (`android/key.properties`)
- [ ] Privacy policy URL hosted and reachable
- [ ] Terms of service URL hosted and reachable
- [ ] Real contact email functional
- [ ] App icon 512×512 created
- [ ] Feature graphic 1024×500 created
- [ ] 4-8 screenshots captured

### Build
- [ ] `flutter build appbundle --release` succeeds
- [ ] AAB tested on real device
- [ ] All features work without internet (where expected)
- [ ] Release build size <150 MB
- [ ] No crashes in 30-min QA session

### Play Console
- [ ] Internal testing track tested by 5+ testers
- [ ] Closed testing track ran for 14+ days (Google requirement for new devs)
- [ ] Data safety form completed
- [ ] Content rating questionnaire completed
- [ ] Target audience and content declared
- [ ] App access (any login required) declared
- [ ] Pre-launch report reviewed (no critical issues)
- [ ] **Subscription product `lutke_yearly_299_try` created & activated** (Monetize → Subscriptions)
- [ ] **Free trial offer (7 days)** configured for the subscription
- [ ] **`in_app_purchase` Flutter package** integrated (call `activatePremium()` on `purchaseUpdated`)

### Post-launch
- [ ] Monitor crash-free rate (target: >99.5%)
- [ ] Respond to first reviews within 24h
- [ ] Set up Crashlytics alerts
- [ ] Prepare v1.0.1 hotfix branch
