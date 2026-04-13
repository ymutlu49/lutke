import 'package:flutter/material.dart';
import 'app_colors.dart';

/// LÛTKE Tipografi Sistemi
///
/// Font: Noto Sans — Kurmancî özel karakterleri tam destekler:
/// ê, î, û, ç, ş, w, x, q, ř
///
/// Temel kural: Kurmancî metin her zaman Türkçe karşılığından
/// 2sp büyük gösterilir. Kullanıcıya bilinçaltı mesaj:
/// bu dil birincil, çeviri ikincil.
abstract class AppTypography {
  static const String _fontFamily = 'NotoSans';

  // ──────────────────────────────────────────────────────────────
  // DISPLAY — Başlık Ekranları (Splash, Onboarding)
  // ──────────────────────────────────────────────────────────────

  static const display = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );

  static const displayKurmanji = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32, // +4sp — Kurmancî her zaman daha büyük
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );

  // ──────────────────────────────────────────────────────────────
  // HEADLINE — Ders Başlıkları, Ekran Başlıkları
  // ──────────────────────────────────────────────────────────────

  static const headline = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  // ──────────────────────────────────────────────────────────────
  // TITLE — Kart Başlıkları, Bölüm Başlıkları
  // ──────────────────────────────────────────────────────────────

  static const title = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  // ──────────────────────────────────────────────────────────────
  // KURMANJI — Öğretilen Dil Metni (Ana egzersiz metni)
  // ──────────────────────────────────────────────────────────────

  /// Egzersiz kartında Kurmancî kelime/cümle gösterimi.
  /// Her zaman Türkçe çevirisinden 2sp büyük.
  static const kurmanji = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.2,
    color: AppColors.textPrimary,
  );

  /// Büyük Kurmancî — splash, ödül momentleri
  static const kurmanjiLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.primary,
  );

  /// Kurmancî kart içi — seçenek butonları
  static const kurmanjiCard = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  // ──────────────────────────────────────────────────────────────
  // TRANSLATION — Çeviri Metni (Türkçe/İngilizce yardımcı)
  // ──────────────────────────────────────────────────────────────

  /// Kurmancî metnin altındaki küçük çeviri.
  /// Bilerek 20sp — Kurmancî'nin (22sp) altında.
  static const translation = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textSecondary,
  );

  // ──────────────────────────────────────────────────────────────
  // BODY — Ana İçerik, Açıklamalar
  // ──────────────────────────────────────────────────────────────

  static const bodyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.textPrimary,
  );

  static const body = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.textPrimary,
  );

  /// Gramer açıklaması — biraz daha geniş satır aralığı (disleksi dostu)
  static const bodyGrammar = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.8,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  // ──────────────────────────────────────────────────────────────
  // LABEL — Butonlar, Etiketler
  // ──────────────────────────────────────────────────────────────

  static const labelLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.1,
  );

  static const label = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.1,
  );

  static const labelSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.2,
  );

  // ──────────────────────────────────────────────────────────────
  // CAPTION — Yardımcı Notlar, Alt Bilgiler
  // ──────────────────────────────────────────────────────────────

  static const caption = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textTertiary,
  );

  // ──────────────────────────────────────────────────────────────
  // ALIASES — Diğer dosyalarda kullanılan kısayollar
  // ──────────────────────────────────────────────────────────────

  /// bodySmall = caption (12sp)
  static const bodySmall = caption;

  /// bodyMedium = body (14sp)
  static const bodyMedium = body;

  /// labelMedium = label (14sp, w500)
  static const labelMedium = label;

  /// headingLarge = display (28sp, w700)
  static const headingLarge = display;

  /// headingSmall = title (18sp, w600)
  static const headingSmall = title;

  /// headingMedium = title (18sp, w600) — alias
  static const headingMedium = title;

  /// displayMedium = display (28sp, w700) — alias
  static const displayMedium = display;

  static const captionStrong = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: AppColors.textSecondary,
  );

  // ──────────────────────────────────────────────────────────────
  // XP & GAMIFICATION — Sayısal Göstergeler
  // ──────────────────────────────────────────────────────────────

  static const xpCounter = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.accent,
  );

  static const streakCounter = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.accent,
  );

  static const badgeTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // ──────────────────────────────────────────────────────────────
  // DİSLEKSİ MODU — Araştırma temelli (Prof. Dr. Mutlu)
  // ──────────────────────────────────────────────────────────────

  /// Disleksi modunda tüm body metinler bu style ile override edilir.
  /// Geniş satır aralığı, geniş harf aralığı, kısa satır uzunluğu.
  static const bodyDyslexia = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.9,         // Standart 1.6 yerine 1.9
    letterSpacing: 0.5,  // Harf arası genişletilmiş
    wordSpacing: 2.0,    // Kelime arası genişletilmiş
    color: AppColors.textPrimary,
  );

  static const kurmanjiDyslexia = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.9,
    letterSpacing: 0.5,
    wordSpacing: 2.0,
    color: AppColors.textPrimary,
  );
}

/// Text style yardımcı extension'ları
extension TextStyleHelpers on TextStyle {
  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle get onPrimary => copyWith(color: AppColors.textOnPrimary);
  TextStyle get muted => copyWith(color: AppColors.textTertiary);
  TextStyle get primary => copyWith(color: AppColors.primary);
  TextStyle get accent => copyWith(color: AppColors.accent);
  TextStyle get success => copyWith(color: AppColors.success);
  TextStyle get error => copyWith(color: AppColors.errorSoft);
}
