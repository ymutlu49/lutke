import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_spacing.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Çocuk Tema Sistemi
//
// 7-10 yaş grubu için optimize edilmiş:
//   - Daha büyük metin (+4sp)
//   - Daha büyük dokunma hedefleri (72dp+)
//   - Daha yumuşak, canlı renkler
//   - Daha yuvarlak köşeler (20px)
//   - Brand teal korunur, pastel arka planlar
// ════════════════════════════════════════════════════════════════

abstract class ChildColors {
  // ── Marka renkleri korunur ──────────────────────────────────
  static const primary = AppColors.primary;
  static const primaryLight = Color(0xFF3CC0AA);
  static const primaryDark = AppColors.primaryDark;
  static const primarySurface = Color(0xFFF0FBF8);

  // ── Çocuk vurgu renkleri ───────────────────────────────────
  static const accent = Color(0xFFF5A623); // Daha sıcak altın
  static const accentWarm = Color(0xFFFFBE4D);
  static const accentSurface = Color(0xFFFFF6E6);

  // ── Yıldız & Ödül ─────────────────────────────────────────
  static const starYellow = Color(0xFFFFD700);
  static const starEmpty = Color(0xFFE8E0D0);
  static const stickerPink = Color(0xFFFF8FAB);
  static const stickerPurple = Color(0xFFB388FF);

  // ── Anlamsal ───────────────────────────────────────────────
  static const success = Color(0xFF66BB6A); // Daha yumuşak yeşil
  static const successSurface = Color(0xFFE8F5E9);
  static const encourage = Color(0xFFFFB74D); // Turuncu yerine sıcak amber
  static const encourageSurface = Color(0xFFFFF3E0);

  // ── Arka plan ──────────────────────────────────────────────
  static const backgroundPrimary = Color(0xFFF5FBF9); // Daha açık mint
  static const backgroundSecondary = Color(0xFFFFFFFF);
  static const backgroundTertiary = Color(0xFFE8F5F1);

  // ── Metin ──────────────────────────────────────────────────
  static const textPrimary = Color(0xFF1A2A4A);
  static const textSecondary = Color(0xFF4A5A6A);
  static const textOnPrimary = Color(0xFFFFFFFF);

  // ── Kategori Renkleri (çocuk ders kartları) ───────────────
  static const categorySelamlama = Color(0xFF1A7B6B); // teal
  static const categoryMalbat    = Color(0xFF7B1FA2); // mor
  static const categoryReng      = Color(0xFFE91E63); // pembe
  static const categoryHeywan    = Color(0xFFD4783A); // turuncu
  static const categoryXwarin    = Color(0xFF2D9E4F); // yeşil
  static const categoryHejmar    = Color(0xFF2196F3); // mavi
  static const categoryDibistan  = Color(0xFFFF8F00); // amber
  static const categoryListik    = Color(0xFFFF5722); // koyu turuncu
  static const categoryLas       = Color(0xFF00BCD4); // cyan
  static const categoryHest      = Color(0xFFFF8FAB); // pembe

  /// Kategori anahtarından renk döndürür.
  static Color categoryColor(String category) => switch (category) {
    'selamlama' || 'silav' => categorySelamlama,
    'malbat' => categoryMalbat,
    'reng' => categoryReng,
    'heywan' => categoryHeywan,
    'xwarin' || 'vexwarin' => categoryXwarin,
    'hejmar' || 'jimar' => categoryHejmar,
    'dibistan' || 'perwerde' => categoryDibistan,
    'listik' => categoryListik,
    'las' || 'beden' => categoryLas,
    'hest' || 'his' => categoryHest,
    _ => primary,
  };
}

/// Çocuk modu tipografi — tüm boyutlar +4sp.
abstract class ChildTypography {
  static const String _fontFamily = 'NotoSans';

  static const display = TextStyle(
    fontFamily: _fontFamily, fontSize: 32, fontWeight: FontWeight.w700,
    height: 1.2, letterSpacing: -0.5, color: ChildColors.textPrimary,
  );

  static const headline = TextStyle(
    fontFamily: _fontFamily, fontSize: 26, fontWeight: FontWeight.w600,
    height: 1.3, color: ChildColors.textPrimary,
  );

  static const title = TextStyle(
    fontFamily: _fontFamily, fontSize: 22, fontWeight: FontWeight.w600,
    height: 1.4, color: ChildColors.textPrimary,
  );

  static const kurmanji = TextStyle(
    fontFamily: _fontFamily, fontSize: 26, fontWeight: FontWeight.w500,
    height: 1.5, letterSpacing: 0.2, color: ChildColors.textPrimary,
  );

  static const kurmanjiCard = TextStyle(
    fontFamily: _fontFamily, fontSize: 22, fontWeight: FontWeight.w500,
    height: 1.5, color: ChildColors.textPrimary,
  );

  static const bodyLarge = TextStyle(
    fontFamily: _fontFamily, fontSize: 20, fontWeight: FontWeight.w400,
    height: 1.6, color: ChildColors.textPrimary,
  );

  static const body = TextStyle(
    fontFamily: _fontFamily, fontSize: 18, fontWeight: FontWeight.w400,
    height: 1.6, color: ChildColors.textPrimary,
  );

  static const labelLarge = TextStyle(
    fontFamily: _fontFamily, fontSize: 20, fontWeight: FontWeight.w500,
    height: 1.2, letterSpacing: 0.1,
  );

  static const label = TextStyle(
    fontFamily: _fontFamily, fontSize: 18, fontWeight: FontWeight.w500,
    height: 1.2, letterSpacing: 0.1,
  );

  static const caption = TextStyle(
    fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w400,
    height: 1.5, color: ChildColors.textSecondary,
  );
}

/// Çocuk modu boşluk sabitleri.
abstract class ChildSpacing {
  static const double touchMin = 72;
  static const double touchPreferred = 72;
  static const double touchLarge = 80;
  static const double radiusMd = 20;
  static const double radiusLg = 24;
  static const double optionGap = 16;
}

/// Çocuk modu tema.
abstract class ChildAppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'NotoSans',

    colorScheme: const ColorScheme.light(
      primary: ChildColors.primary,
      onPrimary: ChildColors.textOnPrimary,
      primaryContainer: ChildColors.primarySurface,
      onPrimaryContainer: ChildColors.primaryDark,
      secondary: ChildColors.accent,
      onSecondary: ChildColors.textOnPrimary,
      secondaryContainer: ChildColors.accentSurface,
      onSecondaryContainer: ChildColors.accent,
      surface: ChildColors.backgroundSecondary,
      onSurface: ChildColors.textPrimary,
      surfaceContainerHighest: ChildColors.backgroundTertiary,
      error: ChildColors.encourage,
      onError: ChildColors.textOnPrimary,
    ),

    scaffoldBackgroundColor: ChildColors.backgroundPrimary,

    appBarTheme: const AppBarTheme(
      backgroundColor: ChildColors.backgroundPrimary,
      foregroundColor: ChildColors.textPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      titleTextStyle: ChildTypography.title,
    ),

    cardTheme: CardThemeData(
      color: ChildColors.backgroundSecondary,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
        side: const BorderSide(
          color: AppColors.borderLight,
          width: AppSpacing.borderThin,
        ),
      ),
      margin: EdgeInsets.zero,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ChildColors.primary,
        foregroundColor: ChildColors.textOnPrimary,
        disabledBackgroundColor: AppColors.borderLight,
        disabledForegroundColor: AppColors.textTertiary,
        elevation: 0,
        shadowColor: Colors.transparent,
        minimumSize: const Size.fromHeight(ChildSpacing.touchPreferred),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ChildSpacing.radiusMd),
        ),
        textStyle: ChildTypography.labelLarge,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ChildColors.primary,
        side: const BorderSide(color: ChildColors.primary, width: 2),
        minimumSize: const Size.fromHeight(ChildSpacing.touchPreferred),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ChildSpacing.radiusMd),
        ),
        textStyle: ChildTypography.labelLarge,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ChildColors.primary,
        textStyle: ChildTypography.label,
        minimumSize: const Size(ChildSpacing.touchMin, ChildSpacing.touchMin),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ChildColors.backgroundSecondary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ChildSpacing.radiusMd),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ChildSpacing.radiusMd),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ChildSpacing.radiusMd),
        borderSide: const BorderSide(color: ChildColors.primary, width: 2),
      ),
      hintStyle: ChildTypography.body.copyWith(color: AppColors.textTertiary),
      labelStyle: ChildTypography.label,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ChildColors.backgroundSecondary,
      selectedItemColor: ChildColors.primary,
      unselectedItemColor: AppColors.textTertiary,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ChildColors.primary,
      linearTrackColor: ChildColors.primarySurface,
      linearMinHeight: 8,
    ),

    textTheme: const TextTheme(
      displayLarge: ChildTypography.display,
      displayMedium: ChildTypography.display,
      headlineLarge: ChildTypography.headline,
      headlineMedium: ChildTypography.headline,
      titleLarge: ChildTypography.title,
      titleMedium: ChildTypography.title,
      bodyLarge: ChildTypography.bodyLarge,
      bodyMedium: ChildTypography.body,
      bodySmall: ChildTypography.caption,
      labelLarge: ChildTypography.labelLarge,
      labelMedium: ChildTypography.label,
      labelSmall: ChildTypography.caption,
    ),
  );
}
