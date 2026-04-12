import 'package:flutter/material.dart';

/// LÛTKE Boşluk Sistemi
///
/// 8px temel grid. Tüm boşluklar 8'in katlarıdır.
/// Minimum dokunma hedefi: 48x48dp (Material 3 + iOS HIG)
abstract class AppSpacing {
  // ──────────────────────────────────────────────────────────────
  // TEMEL BOŞLUKLAR
  // ──────────────────────────────────────────────────────────────

  static const double xs = 4;    // İç padding minimum
  static const double sm = 8;    // Bileşen iç boşluğu
  static const double md = 16;   // Standart padding
  static const double lg = 24;   // Bölüm aralığı
  static const double xl = 32;   // Büyük bölüm
  static const double xxl = 48;  // Sayfa üst-alt boşluk
  static const double xxxl = 64; // Ekran dolusu boşluk

  // ──────────────────────────────────────────────────────────────
  // DOKUNMA HEDEFLERİ
  // ──────────────────────────────────────────────────────────────

  /// Minimum dokunma hedefi — Material 3 & iOS HIG
  static const double touchMin = 48;

  /// Tercih edilen dokunma hedefi (daha kolay kullanım)
  static const double touchPreferred = 56;

  /// Yaşlı kullanıcılar için büyük dokunma hedefi (Hasan, 58)
  static const double touchLarge = 64;

  // ──────────────────────────────────────────────────────────────
  // KÖŞE YARIÇAPLARI
  // ──────────────────────────────────────────────────────────────

  static const double radiusXs = 4;
  static const double radiusSm = 8;
  static const double radiusMd = 12;   // Butonlar
  static const double radiusLg = 16;   // Kartlar
  static const double radiusXl = 24;   // Modal'lar
  static const double radiusFull = 999; // Tam yuvarlak (pill, avatar)

  // ──────────────────────────────────────────────────────────────
  // SAYFA KENAR BOŞLUKLARI
  // ──────────────────────────────────────────────────────────────

  static const EdgeInsets pagePadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: lg,
  );

  static const EdgeInsets pageHorizontal = EdgeInsets.symmetric(
    horizontal: md,
  );

  static const EdgeInsets cardPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: md,
  );

  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: sm + xs, // 12
  );

  static const EdgeInsets chipPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: xs + xs, // 8
  );

  // ──────────────────────────────────────────────────────────────
  // EGZERSİZ EKRANI ÖZEL BOŞLUKLAR
  // ──────────────────────────────────────────────────────────────

  /// Kurmancî metin ile çeviri arası
  static const double kurmanjToTranslation = xs + xs; // 8

  /// Egzersiz sorusu ile seçenekler arası
  static const double questionToOptions = lg;

  /// Seçenek butonları arası
  static const double optionGap = sm;

  /// Alt aksiyon butonu ile içerik arası
  static const double actionBarHeight = touchPreferred + md; // 72

  // ──────────────────────────────────────────────────────────────
  // BORDER WIDTH'LER
  // ──────────────────────────────────────────────────────────────

  static const double borderThin = 0.5;
  static const double borderMedium = 1.0;
  static const double borderThick = 2.0;
}

/// Boşluk widget yardımcıları
class Gap {
  static const Widget xs = SizedBox(height: AppSpacing.xs);
  static const Widget sm = SizedBox(height: AppSpacing.sm);
  static const Widget md = SizedBox(height: AppSpacing.md);
  static const Widget lg = SizedBox(height: AppSpacing.lg);
  static const Widget xl = SizedBox(height: AppSpacing.xl);

  static const Widget hXs = SizedBox(width: AppSpacing.xs);
  static const Widget hSm = SizedBox(width: AppSpacing.sm);
  static const Widget hMd = SizedBox(width: AppSpacing.md);
  static const Widget hLg = SizedBox(width: AppSpacing.lg);
  static const Widget hXl = SizedBox(width: AppSpacing.xl);

  static Widget custom(double height) => SizedBox(height: height);
  static Widget hCustom(double width) => SizedBox(width: width);
}

/// Border radius yardımcıları
class AppRadius {
  static const xs = BorderRadius.all(Radius.circular(AppSpacing.radiusXs));
  static const sm = BorderRadius.all(Radius.circular(AppSpacing.radiusSm));
  static const md = BorderRadius.all(Radius.circular(AppSpacing.radiusMd));
  static const lg = BorderRadius.all(Radius.circular(AppSpacing.radiusLg));
  static const xl = BorderRadius.all(Radius.circular(AppSpacing.radiusXl));
  static const full = BorderRadius.all(Radius.circular(AppSpacing.radiusFull));
}
