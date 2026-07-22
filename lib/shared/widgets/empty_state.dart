import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Ortak Empty / Error / Loading Widget'ları
//
// UX ilkesi §4: Her ekran üç durumu net göstermeli:
//   1. Loading  — spinner veya skeleton
//   2. Empty    — yardımcı mesaj + CTA
//   3. Error    — dostça metin + "Dîsa biceribîne" / "Tekrar dene"
//
// NOT: Tam ekran rota kurtarma için `features/onboarding/onboarding_screens.dart`
// içindeki `ErrorScreen` (go_router errorBuilder) kullanılıyor; bu dosya in-screen
// (.when() error veya itemCount == 0) durumlarda kullanılır.
// ════════════════════════════════════════════════════════════════

/// İçerik bulunamadığında gösterilen dostça durum.
///
/// [titleKu] ve [bodyKu] zorunludur. [titleEn]/[bodyEn] verilirse bilingual
/// (İngilizce track) olarak alt satırda yer alır.
/// [icon] varsayılan olarak [Icons.inbox_rounded].
/// [cta] veriliyse buton olarak gösterilir.
class EmptyStateView extends StatelessWidget {
  final String titleKu;
  final String? titleEn;
  final String? bodyKu;
  final String? bodyEn;
  final IconData icon;
  final Color? iconColor;
  final Widget? cta;
  final EdgeInsets padding;

  const EmptyStateView({
    super.key,
    required this.titleKu,
    this.titleEn,
    this.bodyKu,
    this.bodyEn,
    this.icon = Icons.inbox_rounded,
    this.iconColor,
    this.cta,
    this.padding = const EdgeInsets.all(AppSpacing.xl),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 64,
              color: (iconColor ?? AppColors.textTertiary).withValues(alpha: 0.6),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              titleKu,
              style: AppTypography.title.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            if (titleEn != null) ...[
              const SizedBox(height: 2),
              Text(
                titleEn!,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (bodyKu != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                bodyKu!,
                style: AppTypography.body.copyWith(
                  color: AppColors.textTertiary,
                  height: 1.45,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (bodyEn != null) ...[
              const SizedBox(height: 2),
              Text(
                bodyEn!,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textTertiary.withValues(alpha: 0.9),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (cta != null) ...[
              const SizedBox(height: AppSpacing.lg),
              cta!,
            ],
          ],
        ),
      ),
    );
  }
}

/// `.when()` error dalında kullanılacak dostça hata + retry bileşeni.
///
/// Ham `toString()` yerine anlaşılır mesaj ve "Dîsa biceribîne" butonu sunar.
/// [onRetry] verilirse buton gösterilir (örn. `ref.invalidate(provider)`).
/// [compact] true ise küçük satır içi versiyon, false ise tam ortalı versiyon.
class ErrorRetryView extends StatelessWidget {
  final VoidCallback? onRetry;
  final String? messageKu;
  final String? messageEn;
  final bool compact;
  final EdgeInsets padding;

  const ErrorRetryView({
    super.key,
    this.onRetry,
    this.messageKu,
    this.messageEn,
    this.compact = false,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
  });

  /// Dio/Timeout farkı için yardımcı — hata tipine göre daha spesifik metin.
  static String friendlyMessage(Object error) {
    final text = error.toString().toLowerCase();
    if (text.contains('timeout') || text.contains('timed out')) {
      return 'Zeman qediya — dîsa biceribîne';
    }
    if (text.contains('socket') ||
        text.contains('network') ||
        text.contains('connection') ||
        text.contains('unreachable')) {
      return 'Têkiliya înternetê nîne';
    }
    return 'Tiştek xelet çû';
  }

  @override
  Widget build(BuildContext context) {
    final msg = messageKu ?? 'Tiştek xelet çû';

    if (compact) {
      return Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off_rounded,
              size: 16,
              color: AppColors.textTertiary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Text(
                msg,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(width: AppSpacing.sm),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 14),
                label: const Text('Dîsa'),
                style: TextButton.styleFrom(
                  minimumSize: const Size(64, 32),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                  ),
                  foregroundColor: AppColors.primary,
                ),
              ),
            ],
          ],
        ),
      );
    }

    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_rounded,
              size: 48,
              color: AppColors.errorSoft.withValues(alpha: 0.7),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              msg,
              style: AppTypography.title.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            if (messageEn != null) ...[
              const SizedBox(height: 2),
              Text(
                messageEn!,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.md),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('Dîsa biceribîne'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(180, AppSpacing.touchMin),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
