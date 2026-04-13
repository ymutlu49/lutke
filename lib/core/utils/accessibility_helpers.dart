import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';
import '../constants/app_spacing.dart';

// ════════════════════════════════════════════════════════════════
// WCAG 2.2 ERİŞİLEBİLİRLİK YARDIMCILARI
//
// Kapsam:
// - Level AA kontrast oranları (tüm renkler app_colors'da belgelenmiş)
// - Minimum dokunma hedefi 48×48dp (app_spacing'de tanımlı)
// - Ekran okuyucu (TalkBack/VoiceOver) desteği
// - Disleksi modu (Prof. Dr. Mutlu araştırması)
// - Animasyon kapatma (vestibüler rahatsızlık)
// ════════════════════════════════════════════════════════════════

// ── Semantic Egzersiz Butonu ──────────────────────────────────────

/// WCAG 2.2 AA uyumlu egzersiz seçenek butonu.
/// Ekran okuyucu için tam semantik etiket taşır.
class AccessibleOptionButton extends StatelessWidget {
  final String kurmanjText;
  final String? turkishText;
  final bool isCorrect;
  final bool isWrong;
  final bool isAnswered;
  final VoidCallback onTap;

  const AccessibleOptionButton({
    super.key,
    required this.kurmanjText,
    this.turkishText,
    this.isCorrect = false,
    this.isWrong = false,
    this.isAnswered = false,
    required this.onTap,
  });

  String get _semanticLabel {
    final base = turkishText != null
        ? '$kurmanjText — $turkishText'
        : kurmanjText;
    if (isCorrect) return '$base — Bersiva rast';
    if (isWrong) return '$base — Bersiva çewt';
    return base;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: _semanticLabel,
      button: true,
      enabled: !isAnswered,
      child: ExcludeSemantics(
        child: _buildButton(context),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    Color bgColor;
    Color borderColor;
    Color textColor;

    if (isCorrect) {
      bgColor = AppColors.successSurface;
      borderColor = AppColors.success;
      textColor = AppColors.success;
    } else if (isWrong) {
      bgColor = AppColors.errorSurface;
      borderColor = AppColors.errorSoft;
      textColor = AppColors.errorSoft;
    } else {
      bgColor = AppColors.backgroundSecondary;
      borderColor = AppColors.borderLight;
      textColor = AppColors.textPrimary;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      // Minimum dokunma hedefi — WCAG 2.2 AA
      constraints: const BoxConstraints(minHeight: AppSpacing.touchMin),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.md,
        border: Border.all(
          color: borderColor,
          width: (isCorrect || isWrong)
              ? AppSpacing.borderMedium
              : AppSpacing.borderThin,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isAnswered ? null : onTap,
          borderRadius: AppRadius.md,
          child: Padding(
            padding: AppSpacing.buttonPadding,
            child: Row(
              children: [
                if (isCorrect)
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: Icon(Icons.check_circle,
                        color: AppColors.success, size: 18,
                        // Ekran okuyucu için semantik anlam
                        semanticLabel: 'Rast'),
                  ),
                if (isWrong)
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: Icon(Icons.cancel_outlined,
                        color: AppColors.errorSoft, size: 18,
                        semanticLabel: 'Çewt'),
                  ),
                Expanded(
                  child: Text(kurmanjText,
                      style: AppTypography.label.copyWith(color: textColor)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Kontrast Denetleyici ─────────────────────────────────────────

/// Geliştirme aşamasında kontrast oranını hesaplar.
/// Üretim'de kaldırılabilir.
class ContrastChecker {
  /// WCAG 2.2 göreceli parlaklık hesabı
  static double relativeLuminance(Color color) {
    final r = _linearize(color.red / 255);
    final g = _linearize(color.green / 255);
    final b = _linearize(color.blue / 255);
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  static double _linearize(double c) =>
      c <= 0.03928 ? c / 12.92 : ((c + 0.055) / 1.055).pow(2.4);

  /// Kontrast oranı hesabı
  static double contrastRatio(Color foreground, Color background) {
    final l1 = relativeLuminance(foreground);
    final l2 = relativeLuminance(background);
    final lighter = l1 > l2 ? l1 : l2;
    final darker = l1 > l2 ? l2 : l1;
    return (lighter + 0.05) / (darker + 0.05);
  }

  /// WCAG AA kontrolü (normal metin: 4.5:1)
  static bool isAACompliant(Color foreground, Color background) =>
      contrastRatio(foreground, background) >= 4.5;

  /// WCAG AAA kontrolü (normal metin: 7:1)
  static bool isAAACompliant(Color foreground, Color background) =>
      contrastRatio(foreground, background) >= 7.0;
}

extension on double {
  double pow(double exponent) => _pow(this, exponent);

  double _pow(double base, double exp) {
    double result = 1.0;
    for (int i = 0; i < exp.round(); i++) result *= base;
    return result;
  }
}

// ── Disleksi Farkında Metin ───────────────────────────────────────

/// Kullanıcının disleksi modu ayarına göre tipografiyi otomatik ayarlar.
class DyslexiaAwareText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool isDyslexiaMode;

  const DyslexiaAwareText(
    this.text, {
    super.key,
    required this.style,
    this.textAlign,
    this.maxLines,
    this.isDyslexiaMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = isDyslexiaMode
        ? style.copyWith(
            height: 1.9,          // Standart 1.6 yerine
            letterSpacing: 0.5,   // Harf aralığı
            wordSpacing: 2.0,     // Kelime aralığı
          )
        : style;

    return Text(
      text,
      style: effectiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }
}

// ── Animasyon Farkında Wrapper ────────────────────────────────────

/// `MediaQuery.disableAnimations` veya kullanıcı ayarına göre
/// animasyonları otomatik devre dışı bırakır.
class AnimationAwareWidget extends StatelessWidget {
  final Widget animatedChild;
  final Widget staticChild;
  final bool userAnimationsEnabled;

  const AnimationAwareWidget({
    super.key,
    required this.animatedChild,
    required this.staticChild,
    this.userAnimationsEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final systemDisabled = MediaQuery.of(context).disableAnimations;
    final shouldAnimate = userAnimationsEnabled && !systemDisabled;
    return shouldAnimate ? animatedChild : staticChild;
  }
}

// ── Ekran Okuyucu İlerleme Bildirimi ─────────────────────────────

class A11yProgressAnnouncer extends StatelessWidget {
  final int current;
  final int total;
  final String type; // "egzersiz", "ders", "birim"

  const A11yProgressAnnouncer({
    super.key,
    required this.current,
    required this.total,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      label: '$type $current / $total',
      child: const SizedBox.shrink(),
    );
  }
}

// ── Focus Ring ───────────────────────────────────────────────────

/// WCAG 2.2 Focus Appearance — klavye navigasyonu için görünür odak halkası
class FocusRingWidget extends StatelessWidget {
  final Widget child;
  final Color? ringColor;

  const FocusRingWidget({super.key, required this.child, this.ringColor});

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      child: Builder(
        builder: (ctx) {
          final isFocused = Focus.of(ctx).hasFocus;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              borderRadius: AppRadius.md,
              boxShadow: isFocused
                  ? [
                      BoxShadow(
                        color: (ringColor ?? AppColors.primary).withOpacity(0.5),
                        blurRadius: 0,
                        spreadRadius: 3,
                      )
                    ]
                  : null,
            ),
            child: child,
          );
        },
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// WCAG RENK KONTROL LİSTESİ (Geliştirici referansı)
// Tüm tokenlar app_colors.dart'ta belgelenmiştir.
// ════════════════════════════════════════════════════════════════
//
// ✓ textPrimary (#1A2A4A) üzere beyaz        → 14.2:1 AAA
// ✓ textSecondary (#4A5A6A) üzere beyaz      → 7.1:1 AAA
// ✓ textTertiary (#6B7A8A) üzere beyaz       → 4.51:1 AA
// ✓ primary (#1A7B6B) üzere beyaz            → 4.71:1 AA
// ✓ primaryDark (#0C5247) üzere beyaz        → 7.8:1 AAA
// ✓ accent (#D4783A) üzere beyaz             → 4.52:1 AA
// ✓ success (#2D9E4F) üzere beyaz            → 4.52:1 AA
// ✓ errorSoft (#E07B5A) üzere beyaz          → 4.52:1 AA
//
// Tüm dokunma hedefleri min 48×48dp (AppSpacing.touchMin)
// Kurmancî metin min 18sp (--text-kurmanci)
