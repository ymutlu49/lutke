# Play Store Submission Guide — LÛTKE v1.0.0

## ✅ Hazır olanlar (kod + meta)
- [x] AAB (App Bundle): `build/app/outputs/bundle/release/app-release.aab` — Build edildi
- [x] Keystore: `C:\Users\yilma\lutke-release-key.jks` (parolayı sakla!)
- [x] Application ID: `com.lutke.kurmanci`
- [x] Version: 1.0.0+1
- [x] Privacy Policy: https://lutke.app/legal/privacy
- [x] Terms of Service: https://lutke.app/legal/terms
- [x] Store listing (TR/KU/EN): `play_store_assets/store_listing_*.md`
- [x] Release notes: `play_store_assets/release_notes_v1.0.0.md`

## 🟡 Senin yapman gerek (Play Console UI)

### 1. Yeni Uygulama Oluştur
Play Console → **All apps** → **Create app**
- App name: `LÛTKE — Kurmancî & İngilizce Öğren`
- Default language: Türkçe (tr-TR)
- App or game: **App**
- Free or paid: **Free**
- Confirm declarations (developer policies)

### 2. Dashboard'taki "Set up your app" görevlerini doldur

#### A. App access (uygulamaya erişim)
"All functionality available without restrictions" — kullanıcı kayıt olarak tüm özelliklere erişir.
NOT: Login gerekiyorsa "All or some functionality is restricted" → test hesap bilgilerini ver:
- Email: `playstore-review@lutke.app` (oluştur, doğrula)
- Password: güçlü bir parola

#### B. Ads
**No** — uygulamada reklam yok.

#### C. Content rating
Questionnaire'i doldur:
- Education category seç
- Şiddet/cinsel içerik/küfür: **Yok**
- Kullanıcı interaktiyonu: Var (sadece kayıt + öğrenme içeriği)
- Konum/kişisel bilgi: E-posta toplanır (kayıt için)
→ Tahmini rating: **Everyone (3+)**

#### D. Target audience
- Yaş aralığı: **3-5, 6-8, 9-12, 13-17, 18+**
- Çocuk modunu işaretle (Lûtke Zarok)
- Designed for Families: **Yes** (opsiyonel ama önerilir, daha geniş kitleye ulaşır)

#### E. News apps
**No, this is not a news app**

#### F. COVID-19
Yok

#### G. Data safety
- Toplanan veriler:
  - **Personal info** → Name, Email (kayıt için, zorunlu)
  - **App activity** → In-app actions (öğrenme ilerlemesi)
- Encryption: Yes (HTTPS)
- Deletion: Hesap silme talebi `y.mutlu@alparslan.edu.tr`a yapılır
- Data shared with third parties: **No**

#### H. Government apps
**No**

#### I. Financial features
**No**

### 3. Store Listing
Sol menü → **Main store listing**

- **App name**: `LÛTKE — Kurmancî & İngilizce Öğren`
- **Short description**: `play_store_assets/store_listing_tr.md`'den kopyala
- **Full description**: aynı dosyadan kopyala
- **App icon**: `assets/images/logo_512.png` (zaten 512x512)
- **Feature graphic**: 1024x500 — bunu Canva/Figma'da hazırla:
  - LÛTKE logosu + "Ji peyvekê heya welatekî" sloganı + arka plan teal gradient
- **Phone screenshots**: en az 2 adet — Chrome'da `lutke.app`'i aç, F12 ile mobile mode (375x812 iPhone) → ekran görüntüsü al:
  1. Splash screen
  2. Login (Google butonlu)
  3. Intro slide
  4. Track select (Kurmancî/Îngilîzî)
  5. Home screen
  6. Lesson/quiz
  7. Profile

### 4. Release oluştur
Sol menü → **Production** → **Create new release**

- **Bundle yükle**: `build/app/outputs/bundle/release/app-release.aab` dosyasını sürükle-bırak
- **Release name**: `1.0.0 (1)` (otomatik)
- **Release notes**: `play_store_assets/release_notes_v1.0.0.md`'den kopyala (TR/KU/EN)
- **Save** → **Review release** → **Start rollout to Production**

### 5. Review Süreci
- Google Play review: **1-7 gün** (yeni hesaplar için 7 günü bulabilir)
- Onay sonrası uygulama Play Store'da arama sonuçlarında görünür
- Tahmini ilk yayın URL: https://play.google.com/store/apps/details?id=com.lutke.kurmanci

## 🟡 Sonraki Adımlar (yayından sonra)

### Google Sign-In Mobile için Android OAuth Client
Şu anki setup web için. Android'de Google ile giriş çalışması için:
1. Google Cloud Console → Credentials → **Create OAuth client ID**
2. Application type: **Android**
3. Package name: `com.lutke.kurmanci`
4. SHA-1 fingerprint: aşağıdaki komutla al

```powershell
# Parola android/key.properties dosyasındadır (git dışı) — buraya YAZMA.
& "$env:JAVA_HOME\bin\keytool.exe" -list -v -keystore "C:\Users\yilma\lutke-release-key.jks" -alias lutke
```

SHA-1 satırını kopyala, Google Cloud Console'a yapıştır.
5. Save → kod tarafında değişiklik gerekmez (web client ID üzerinden çalışır).

### App Store (iOS) — gelecekte
- Mac + Xcode gerek
- Apple Developer hesabı $99/yıl
- Şimdilik atlayabilirsin

## ⚠️ KRİTİK GÜVENLİK

`C:\Users\yilma\lutke-release-key.jks` dosyası ve parolası (android/key.properties içinde — git dışı):
- **Mutlaka yedekle** (Google Drive encrypted, USB, parola yöneticisi)
- **ASLA git'e commit etme** (.gitignore'da, doğrulanmış)
- **Kaybedersen** uygulama bir daha güncellenemez

`android/key.properties` dosyası da repo'ya commit edilmemeli (.gitignore'da olmalı).
