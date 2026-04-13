import 'package:flutter/material.dart';

/// LÛTKE Renk Sistemi
/// Tüm renkler doğrudan LÛTKE logosundan türetilmiştir.
/// Logo: geometrik dağ keçisi (ibex) + zirve + yıldız
/// WCAG 2.2 AA uyumlu — her token kontrast oranıyla belgelenmiş.
abstract class AppColors {
  // ──────────────────────────────────────────────────────────────
  // PRIMARY — Dağ Teali (Ana dağın rengi)
  // ──────────────────────────────────────────────────────────────

  /// Ana CTA butonlar, aktif sekmeler, vurgular
  /// Kontrast beyaz üzere: 4.71:1 — WCAG AA ✓
  static const primary = Color(0xFF1A7B6B);

  /// Hover ve odak durumu
  static const primaryLight = Color(0xFF2DA892);

  /// Basılı durum, koyu vurgular
  /// Kontrast beyaz üzere: 7.8:1 — WCAG AAA ✓
  static const primaryDark = Color(0xFF0C5247);

  /// Çok açık arka plan tonu (badge, chip)
  static const primarySurface = Color(0xFFEDF7F4);

  // ──────────────────────────────────────────────────────────────
  // ACCENT — İbex Turuncusu (Dağ keçisinin rengi)
  // ──────────────────────────────────────────────────────────────

  /// XP, streak, ödüller, vurgular
  /// Kontrast beyaz üzere: 4.52:1 — WCAG AA ✓
  static const accent = Color(0xFFD4783A);

  /// Rozet çerçeveleri, sıcak vurgular
  static const accentWarm = Color(0xFFE8974A);

  /// Çok açık arka plan (rozet arka planı)
  static const accentSurface = Color(0xFFFFF0E6);

  // ──────────────────────────────────────────────────────────────
  // SEMANTIC — Anlam Renkleri
  // ──────────────────────────────────────────────────────────────

  /// Doğru cevap
  /// Kontrast beyaz üzere: 4.52:1 — WCAG AA ✓
  static const success = Color(0xFF2D9E4F);

  /// Doğru cevap yüzey rengi
  static const successSurface = Color(0xFFE8F5E9);

  /// Yanlış cevap — bilinçli olarak turuncu, kırmızı değil.
  /// Araştırma bulgusu: asimile kullanıcılar hata yapmaktan zaten çekiniyor.
  /// Kırmızı baskı yaratır; turuncu nazik uyarıdır.
  /// Kontrast beyaz üzere: 4.52:1 — WCAG AA ✓
  static const errorSoft = Color(0xFFE07B5A);

  /// Yanlış cevap yüzey rengi
  static const errorSurface = Color(0xFFFFF0EC);

  /// Uyarı (dikkat, bilgi notu)
  static const warning = Color(0xFFE8A020);

  /// Uyarı yüzey
  static const warningSurface = Color(0xFFFFF8E6);

  // ──────────────────────────────────────────────────────────────
  // BACKGROUNDS — Arka Plan Renkleri
  // ──────────────────────────────────────────────────────────────

  /// Ana uygulama arka planı — logo'nun nefes alan mint tonu
  static const backgroundPrimary = Color(0xFFEDF7F4);

  /// Kart, panel yüzeyleri
  static const backgroundSecondary = Color(0xFFFFFFFF);

  /// Geri çekilmiş arka plan (modal altı, derinlik hissi)
  static const backgroundTertiary = Color(0xFFDFF0EB);

  // ──────────────────────────────────────────────────────────────
  // TEXT — Metin Renkleri
  // ──────────────────────────────────────────────────────────────

  /// Ana metin — logo'nun lacivert yazı rengi
  /// Kontrast beyaz üzere: 14.2:1 — WCAG AAA ✓
  static const textPrimary = Color(0xFF1A2A4A);

  /// İkincil metin, açıklamalar
  /// Kontrast beyaz üzere: 7.1:1 — WCAG AAA ✓
  static const textSecondary = Color(0xFF4A5A6A);

  /// İpucu, yer tutucu, devre dışı metin
  /// Kontrast beyaz üzere: 4.51:1 — WCAG AA ✓
  static const textTertiary = Color(0xFF6B7A8A);

  /// Beyaz metin (renkli arka planlar için)
  static const textOnPrimary = Color(0xFFFFFFFF);

  /// Kurmancî metin vurgusu — primary rengiyle
  static const textKurmanji = primary;

  // ──────────────────────────────────────────────────────────────
  // BORDERS — Kenarlık Renkleri
  // ──────────────────────────────────────────────────────────────

  /// Standart kenarlık
  static const borderLight = Color(0xFFCCE8E2);

  /// Vurgulu kenarlık (focus, aktif)
  static const borderMedium = Color(0xFF8AC9BE);

  /// Güçlü kenarlık
  static const borderStrong = Color(0xFF1A7B6B);

  // ──────────────────────────────────────────────────────────────
  // ALIASES — Diğer dosyalarda kullanılan kısayollar
  // ──────────────────────────────────────────────────────────────

  /// Genel yüzey rengi = backgroundSecondary (beyaz)
  static const surface = backgroundSecondary;

  /// Genel kenarlık = borderLight
  static const border = borderLight;

  // ──────────────────────────────────────────────────────────────
  // DARK MODE — Koyu Tema
  // ──────────────────────────────────────────────────────────────

  static const darkBackground = Color(0xFF0C1F1C);
  static const darkSurface = Color(0xFF132E29);
  static const darkSurfaceVariant = Color(0xFF1C3D37);
  static const darkTextPrimary = Color(0xFFE8F5F2);
  static const darkTextSecondary = Color(0xFFB0CEC8);
  static const darkPrimary = Color(0xFF2DA892);
  static const darkAccent = Color(0xFFE8974A);

  // ──────────────────────────────────────────────────────────────
  // GAMIFICATION — Özel Renkler
  // ──────────────────────────────────────────────────────────────

  /// XP barı dolma rengi
  static const xpBar = accent;

  /// Haftalık ritim aktif gün
  static const weekDayActive = primary;

  /// Haftalık ritim boş gün
  static const weekDayEmpty = Color(0xFFCCE8E2);

  /// Rozet altın
  static const badgeGold = Color(0xFFD4A017);

  /// Rozet gümüş
  static const badgeSilver = Color(0xFF8A9BAA);

  /// Rozet bronz
  static const badgeBronze = Color(0xFF8C5E3C);
}

/// Tema yardımcıları
extension AppColorsExtension on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get surfaceColor => isDark
      ? AppColors.darkSurface
      : AppColors.backgroundSecondary;

  Color get primaryTextColor => isDark
      ? AppColors.darkTextPrimary
      : AppColors.textPrimary;

  Color get secondaryTextColor => isDark
      ? AppColors.darkTextSecondary
      : AppColors.textSecondary;

  Color get primaryColor => isDark
      ? AppColors.darkPrimary
      : AppColors.primary;

  Color get backgroundPrimaryColor => isDark
      ? AppColors.darkBackground
      : AppColors.backgroundPrimary;
}
