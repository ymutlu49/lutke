import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_spacing.dart';

/// LÛTKE Tema Sistemi
///
/// Light ve dark tema birlikte tanımlanmıştır.
/// Tüm renkler AppColors'dan, tipografi AppTypography'den gelir.
abstract class AppTheme {
  // ──────────────────────────────────────────────────────────────
  // LIGHT TEMA
  // ──────────────────────────────────────────────────────────────

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: 'NotoSans',

        // Color Scheme
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          onPrimary: AppColors.textOnPrimary,
          primaryContainer: AppColors.primarySurface,
          onPrimaryContainer: AppColors.primaryDark,
          secondary: AppColors.accent,
          onSecondary: AppColors.textOnPrimary,
          secondaryContainer: AppColors.accentSurface,
          onSecondaryContainer: AppColors.accent,
          surface: AppColors.backgroundSecondary,
          onSurface: AppColors.textPrimary,
          surfaceContainerHighest: AppColors.backgroundTertiary,
          error: AppColors.errorSoft,
          onError: AppColors.textOnPrimary,
        ),

        // Scaffold
        scaffoldBackgroundColor: AppColors.backgroundPrimary,

        // AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundPrimary,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          scrolledUnderElevation: 0.5,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          titleTextStyle: AppTypography.title,
        ),

        // Card
        cardTheme: CardTheme(
          color: AppColors.backgroundSecondary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.lg,
            side: const BorderSide(
              color: AppColors.borderLight,
              width: AppSpacing.borderThin,
            ),
          ),
          margin: EdgeInsets.zero,
        ),

        // ElevatedButton (Ana CTA butonu)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnPrimary,
            disabledBackgroundColor: AppColors.borderLight,
            disabledForegroundColor: AppColors.textTertiary,
            elevation: 0,
            shadowColor: Colors.transparent,
            minimumSize: const Size.fromHeight(AppSpacing.touchPreferred),
            padding: AppSpacing.buttonPadding,
            shape: const RoundedRectangleBorder(
              borderRadius: AppRadius.md,
            ),
            textStyle: AppTypography.labelLarge,
          ),
        ),

        // OutlinedButton (İkincil buton)
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(
              color: AppColors.primary,
              width: AppSpacing.borderMedium,
            ),
            minimumSize: const Size.fromHeight(AppSpacing.touchPreferred),
            padding: AppSpacing.buttonPadding,
            shape: const RoundedRectangleBorder(
              borderRadius: AppRadius.md,
            ),
            textStyle: AppTypography.labelLarge,
          ),
        ),

        // TextButton
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            textStyle: AppTypography.label,
            minimumSize: const Size(AppSpacing.touchMin, AppSpacing.touchMin),
          ),
        ),

        // Input (TextField)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.backgroundSecondary,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm + AppSpacing.xs,
          ),
          border: OutlineInputBorder(
            borderRadius: AppRadius.md,
            borderSide: const BorderSide(
              color: AppColors.borderLight,
              width: AppSpacing.borderMedium,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.md,
            borderSide: const BorderSide(
              color: AppColors.borderLight,
              width: AppSpacing.borderMedium,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppRadius.md,
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: AppSpacing.borderThick,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppRadius.md,
            borderSide: const BorderSide(
              color: AppColors.errorSoft,
              width: AppSpacing.borderMedium,
            ),
          ),
          hintStyle: AppTypography.body.muted,
          labelStyle: AppTypography.label,
        ),

        // BottomNavigationBar
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.backgroundSecondary,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textTertiary,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: AppTypography.captionStrong,
          unselectedLabelStyle: AppTypography.caption,
        ),

        // Divider
        dividerTheme: const DividerThemeData(
          color: AppColors.borderLight,
          thickness: AppSpacing.borderThin,
          space: 0,
        ),

        // SnackBar
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.textPrimary,
          contentTextStyle: AppTypography.body.onPrimary,
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.md),
          behavior: SnackBarBehavior.floating,
        ),

        // ProgressIndicator
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primary,
          linearTrackColor: AppColors.primarySurface,
          linearMinHeight: 6,
        ),

        // Chip
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.backgroundTertiary,
          selectedColor: AppColors.primarySurface,
          labelStyle: AppTypography.label,
          side: const BorderSide(
            color: AppColors.borderLight,
            width: AppSpacing.borderThin,
          ),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.full),
          padding: AppSpacing.chipPadding,
        ),

        // TextTheme
        textTheme: const TextTheme(
          displayLarge: AppTypography.display,
          displayMedium: AppTypography.display,
          headlineLarge: AppTypography.headline,
          headlineMedium: AppTypography.headline,
          titleLarge: AppTypography.title,
          titleMedium: AppTypography.title,
          bodyLarge: AppTypography.bodyLarge,
          bodyMedium: AppTypography.body,
          bodySmall: AppTypography.caption,
          labelLarge: AppTypography.labelLarge,
          labelMedium: AppTypography.label,
          labelSmall: AppTypography.labelSmall,
        ),
      );

  // ──────────────────────────────────────────────────────────────
  // DARK TEMA
  // ──────────────────────────────────────────────────────────────

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: 'NotoSans',

        colorScheme: const ColorScheme.dark(
          primary: AppColors.darkPrimary,
          onPrimary: AppColors.textOnPrimary,
          primaryContainer: AppColors.darkSurfaceVariant,
          onPrimaryContainer: AppColors.darkPrimary,
          secondary: AppColors.darkAccent,
          onSecondary: AppColors.textOnPrimary,
          surface: AppColors.darkSurface,
          onSurface: AppColors.darkTextPrimary,
          surfaceContainerHighest: AppColors.darkSurfaceVariant,
          error: AppColors.errorSoft,
          onError: AppColors.textOnPrimary,
        ),

        scaffoldBackgroundColor: AppColors.darkBackground,

        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkBackground,
          foregroundColor: AppColors.darkTextPrimary,
          elevation: 0,
          scrolledUnderElevation: 0.5,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),

        cardTheme: CardTheme(
          color: AppColors.darkSurface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.lg,
            side: const BorderSide(
              color: AppColors.darkSurfaceVariant,
              width: AppSpacing.borderThin,
            ),
          ),
          margin: EdgeInsets.zero,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkPrimary,
            foregroundColor: AppColors.textOnPrimary,
            elevation: 0,
            shadowColor: Colors.transparent,
            minimumSize: const Size.fromHeight(AppSpacing.touchPreferred),
            padding: AppSpacing.buttonPadding,
            shape: const RoundedRectangleBorder(borderRadius: AppRadius.md),
            textStyle: AppTypography.labelLarge,
          ),
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.darkSurface,
          selectedItemColor: AppColors.darkPrimary,
          unselectedItemColor: AppColors.darkTextSecondary,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
        ),

        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.darkPrimary,
          linearTrackColor: AppColors.darkSurfaceVariant,
          linearMinHeight: 6,
        ),

        textTheme: TextTheme(
          displayLarge: AppTypography.display
              .copyWith(color: AppColors.darkTextPrimary),
          headlineLarge: AppTypography.headline
              .copyWith(color: AppColors.darkTextPrimary),
          titleLarge:
              AppTypography.title.copyWith(color: AppColors.darkTextPrimary),
          bodyLarge:
              AppTypography.bodyLarge.copyWith(color: AppColors.darkTextPrimary),
          bodyMedium:
              AppTypography.body.copyWith(color: AppColors.darkTextPrimary),
          bodySmall:
              AppTypography.caption.copyWith(color: AppColors.darkTextSecondary),
          labelLarge: AppTypography.labelLarge
              .copyWith(color: AppColors.darkTextPrimary),
        ),
      );
}
