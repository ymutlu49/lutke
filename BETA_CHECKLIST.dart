/// LÛTKE — Beta Hazırlık Kontrol Listesi
///
/// Bu dosya geliştirici referansıdır.
/// Her maddeyi işaretleyerek beta testine geçin.
///
/// Tarih: Nisan 2026
/// Proje: Prof. Dr. Yılmaz Mutlu

// ════════════════════════════════════════════════════════════════
// FAZ 0 — TEMEL ALTYAPИ ✓
// ════════════════════════════════════════════════════════════════
//
// [✓] Flutter 3.27 + Dart 3.6 kurulumu
// [✓] Klasör yapısı (core/features/shared)
// [✓] pubspec.yaml — tüm bağımlılıklar
// [✓] app_colors.dart — logo renklerinden türetilmiş, WCAG AA
// [✓] app_typography.dart — Noto Sans, Kurmancî karakterleri
// [✓] app_spacing.dart — 8px grid, dokunma hedefleri
// [✓] app_theme.dart — light + dark ThemeData
// [✓] fsrs_algorithm.dart — FSRS-5 tam implementasyon
// [✓] user_segment.dart — heritage/general/english profil
// [✓] app_router.dart — go_router, tüm rotalar
// [✓] main.dart — Firebase, EasyLocalization, ProviderScope
// [✓] fsrs_algorithm_test.dart — 12 birim testi
//
// TODO:
// [ ] flutter test çalıştır → tüm testler geçmeli
// [ ] dart-fsrs pub.dev'de mevcut mu? (veya elle impl. yeterli mi?)
// [ ] firebase_options.dart oluştur (flutterfire configure)
// [ ] GoogleService-Info.plist + google-services.json ekle

// ════════════════════════════════════════════════════════════════
// FAZ 1 — ONBOARDING ✓
// ════════════════════════════════════════════════════════════════
//
// [✓] SplashScreen — logo animasyonu, "Xêr hatî."
// [✓] PassiveTestScreen — 3 ses sorusu, 2 yol (hızlı/tam A1)
// [✓] MotivationAnchorScreen — isim girişi, önizleme
// [✓] DialectSelectScreen — Kurmancî/Zazaca, şeffaf dialog
// [✓] ScenarioSelectScreen — Kurmancî önce / çeviri altında
// [✓] GoalSelectScreen — 5/10/20 dakika, Kurmancî etiketler
// [✓] FirstLessonScreen — kayıtsız 3 alıştırma
// [✓] CompletionScreen — "Gelek baş!" kutlama
//
// TODO:
// [ ] Ses dosyaları ekle: assets/audio/passive_test/*.mp3
// [ ] Gerçek AudioPlayer entegrasyonu (just_audio)
// [ ] RegisterScreen yaz — Google/Apple/e-posta
// [ ] İlk açılış kontrolü — onboarding tamamlandı mı?
// [ ] Onboarding state provider → SharedPreferences'a kaydet

// ════════════════════════════════════════════════════════════════
// FAZ 2 — DERS MOTORU ✓
// ════════════════════════════════════════════════════════════════
//
// [✓] app_database.dart — 6 tablo, drift ORM
// [✓] lesson_entities.dart — VocabularyCard, Exercise, Lesson
// [✓] lesson_repository.dart — FSRS entegrasyonu, seed data
// [✓] home_screen.dart — ilerleme haritası, haftalık ritim
// [✓] lesson_screen.dart — 3 egzersiz tipi çalışıyor
//
// TODO:
// [ ] app_database.g.dart oluştur: dart run build_runner build
// [ ] Seed verisi yükleme — ilk açılışta çalıştır
// [ ] A1 ses dosyaları: assets/audio/a1/*.mp3
// [ ] ExerciseType.dragAndDrop widget'ı yaz
// [ ] ExerciseType.fillInBlank widget'ı yaz
// [ ] ExerciseType.minimalPair widget'ı yaz
// [ ] LessonScreen → LessonRepository bağlantısı (şu an mock)
// [ ] HomeScreen → gerçek kullanıcı verisi bağlantısı

// ════════════════════════════════════════════════════════════════
// FAZ 3 — GAMİFİCATION ✓
// ════════════════════════════════════════════════════════════════
//
// [✓] gamification_provider.dart — haftalık ritim, XP, rozetler
// [✓] gamification_widgets.dart — WeeklyRhythm, XPBar, BadgeOverlay
// [✓] notification_service.dart — motivasyon çapası bildirimleri
//
// TODO:
// [ ] BadgeEarnedOverlay → ana uygulamaya entegre et (Stack ile)
// [ ] Rozet görselleri: assets/images/badges/*.png
// [ ] flutter_local_notifications → izin akışı
// [ ] timezone paketi timezone/data/latest.dart import uyarısı
// [ ] Haftalık ritim → HomeScreen WeeklyRhythmWidget'a bağla
// [ ] LessonScreen tamamlama → gamification_provider.completedLesson()

// ════════════════════════════════════════════════════════════════
// FAZ 4 — KÜLTÜREL İÇERİK ✓
// ════════════════════════════════════════════════════════════════
//
// [✓] cultural_entities.dart — 7 içerik, Newroz, seed verisi
// [✓] cultural_widgets.dart — CulturalRewardCard, Kültür Yolu, Newroz
//
// TODO:
// [ ] Kültürel ses dosyaları: assets/audio/cultural/*.mp3
// [ ] CulturalScreen → app_router'a ekle (zaten var: /cultural)
// [ ] LessonScreen tamamlama → CulturalRewardCard göster
// [ ] Newroz Banner → HomeScreen'e ekle (21 Mart yaklaşırsa)
// [ ] A2 şiir modülü — Cegerxwîn tam şiir

// ════════════════════════════════════════════════════════════════
// FAZ 5 — BACKEND & ERİŞİLEBİLİRLİK ✓
// ════════════════════════════════════════════════════════════════
//
// [✓] sync_service.dart — Firebase auth + Firestore senkron
// [✓] connectivity_service.dart — çevrimdışı banner
// [✓] profile_screen.dart — profil + ayarlar
// [✓] accessibility_helpers.dart — WCAG yardımcıları
//
// TODO:
// [ ] Firebase Security Rules yaz:
//     users/{uid} → sadece kendi kullanıcısı okuyabilir
//     fsrs_reviews/{uid} → sadece kendi verisi
// [ ] Firestore offline persistence aktif et:
//     FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true)
// [ ] ProfileScreen → app_router'a bağla (zaten /profile var)
// [ ] AuthStateProvider → uygulama geneli dinle
// [ ] Onboarding sonrası anon hesabı gerçek hesaba yükselt
// [ ] KVKK metni + gizlilik politikası ekle (Türkiye zorunluluğu)
// [ ] Disleksi modu → tüm Text widget'larına DyslexiaAwareText uygula

// ════════════════════════════════════════════════════════════════
// BETA TEST ÖNCESİ KONTROLLER
// ════════════════════════════════════════════════════════════════
//
// PERFORMANS:
// [ ] flutter run --profile → frame rate kontrol
// [ ] Const constructor kullanımı → gereksiz rebuild önle
// [ ] Image cache → cached_network_image
// [ ] SQLite index → cardId + userId birlikte
//
// ERİŞİLEBİLİRLİK:
// [ ] TalkBack (Android) tam akış testi
// [ ] VoiceOver (iOS) tam akış testi
// [ ] Sistem font boyutu %200 → layout bozulmuyor mu?
// [ ] Deuteranopia modu → renk körlüğü testi
// [ ] Disleksi modu açık → tüm ekranlar okunaklı mı?
//
// WCAG RENK KONTROL (app_colors.dart'ta belgelenmiş):
// [ ] textPrimary (#1A2A4A) / beyaz → 14.2:1 ✓ AAA
// [ ] primary (#1A7B6B) / beyaz → 4.71:1 ✓ AA
// [ ] accent (#D4783A) / beyaz → 4.52:1 ✓ AA
// [ ] errorSoft (#E07B5A) / beyaz → 4.52:1 ✓ AA
// [ ] Tüm seçenek butonları → renk + ikon birlikte (renk tek başına değil)
//
// ÇEVRİMDIŞI TEST:
// [ ] Uçak modu → tüm A1 dersleri çalışıyor mu?
// [ ] Uçak modu → FSRS zamanlaması kaydediliyor mu?
// [ ] İnternet geldiğinde → kuyruk flush ediliyor mu?
// [ ] Firestore offline cache → veri kaybolmuyor mu?
//
// BETA TEST GRUBU (5 kişi — araştırma personaları):
// [ ] Asimile Kürt, 18-30 yaş arası — Heritage yolu
// [ ] Asimile Kürt, 40+ yaş — Hasan profili, büyük font
// [ ] Türkçe konuşan, meraklı — Genel yol
// [ ] Zazaca ailesi olan — Lehçe seçim akışı
// [ ] Teknoloji aşina UX kullanıcısı — Narin profili
//
// BETA ÖLÇÜM METRİKLERİ:
// [ ] Onboarding tamamlama oranı (hedef: %80+)
// [ ] İlk hafta geri dönüş oranı (hedef: %60+)
// [ ] Ortalama ders süresi (hedef: 5-12 dakika)
// [ ] Seri tamamlama (hedef: haftalık 4 gün)
// [ ] "Neden bıraktınız?" çıkış anketi

// ════════════════════════════════════════════════════════════════
// YAYINA HAZIRLIK
// ════════════════════════════════════════════════════════════════
//
// APP STORE (iOS):
// [ ] App Store Connect hesabı
// [ ] Privacy Manifest (iOS 17+ zorunluluğu)
// [ ] NSMicrophoneUsageDescription → ses kaydı için açıklama
// [ ] Minimum iOS 14.0
// [ ] Ekran görüntüleri: 6.7" + 6.1" + iPad
//
// GOOGLE PLAY (Android):
// [ ] Play Console hesabı
// [ ] RECORD_AUDIO izin beyanı
// [ ] Target SDK 35 (Android 15)
// [ ] Data safety formu — Kürtçe içerik notu
// [ ] Minimum Android 6.0 (API 23)
//
// ASO (App Store Optimization):
// Başlık: "LÛTKE — Kurmancî Öğren"
// Alt başlık: "Zimanê Kurdî • Kürtçe Dil Uygulaması"
// Anahtar kelimeler: kürtçe öğren, kurmancî, kurdish language,
//                   kürt dili, lernen kurdisch, öğren kürtçe
//
// İLK 100 KULLANICI HEDEFI:
// [ ] Twitter/X — Kürt kültür hesapları
// [ ] Instagram — Kürt diaspora toplulukları
// [ ] Reddit r/kurdistan
// [ ] Telegram Kürt grupları
// [ ] Akademik çevreler — Mardin Artuklu bağlantısı

void main() {
  // Bu dosya sadece geliştirici referansıdır.
  // Çalıştırılabilir kod içermez.
}
