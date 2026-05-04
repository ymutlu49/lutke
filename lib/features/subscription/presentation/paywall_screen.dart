import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../data/subscription_service.dart';
import '../domain/subscription_status.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Paywall (Premium Abonelik)
//
// Kurmancî birincil dil. Türkçe yardımcı (heritage öğrenciler için).
//
// Akış:
//   1) Yeni kullanıcı (none): "7 gün ücretsiz dene" + "Yıllık abone ol"
//   2) Deneme bitmiş (trialExpired): "Yıllık abone ol" tek başına
//   3) Premium aktif: bu ekran zaten erişimi iade ediyor; durum
//      detayı gösterilir
// ════════════════════════════════════════════════════════════════

class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sub = ref.watch(subscriptionProvider);
    final notifier = ref.read(subscriptionProvider.notifier);
    final canStartTrial = sub.tier == SubscriptionTier.none;
    final isAlreadyPremium = sub.tier == SubscriptionTier.premium;
    final isInTrial = sub.tier == SubscriptionTier.trial;
    final isPromoActive = SubscriptionConstants.isPromoPeriodActive;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Close button
                  Row(
                    children: [
                      SizedBox(
                        width: AppSpacing.touchMin,
                        height: AppSpacing.touchMin,
                        child: IconButton(
                          tooltip: 'Vegere',
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.go(AppRoutes.home);
                            }
                          },
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Hero
                  Center(
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.primary.withOpacity(0.7),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 22,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.workspace_premium_rounded,
                          size: 56,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(duration: 400.ms).scale(
                        begin: const Offset(0.85, 0.85),
                        end: const Offset(1, 1),
                      ),
                  const SizedBox(height: AppSpacing.md),

                  Text(
                    'LÛTKE Premium',
                    textAlign: TextAlign.center,
                    style: AppTypography.display.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tev de Kurmancî — bê sînor',
                    textAlign: TextAlign.center,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Status banner — promo dönemi aktifse en üstte gösterilir,
                  // diğer rozet/aboneya öncelikli olur.
                  if (isPromoActive)
                    _StatusBanner(
                      icon: Icons.celebration_outlined,
                      color: const Color(0xFFFFC107),
                      title: 'Demê pêşkêşiyê — bedelî!',
                      subtitle:
                          'Heya ${SubscriptionConstants.promoEndsLabelKu} '
                          'her tişt ji bo te vekirî ye '
                          '(${SubscriptionConstants.promoDaysRemaining} roj mayî).',
                    )
                  else if (isAlreadyPremium)
                    _StatusBanner(
                      icon: Icons.check_circle_rounded,
                      color: const Color(0xFF4CAF50),
                      title: 'Premium aktîf e',
                      subtitle: sub.premiumDaysRemaining != null
                          ? '${sub.premiumDaysRemaining} roj mayî'
                          : 'Bê sînor',
                    )
                  else if (isInTrial)
                    _StatusBanner(
                      icon: Icons.timer_outlined,
                      color: AppColors.primary,
                      title: 'Ceribandina te aktîv e',
                      subtitle: sub.trialDaysRemaining != null
                          ? '${sub.trialDaysRemaining} roj mayî'
                          : '7 roj mayî',
                    ),

                  if (isPromoActive || isAlreadyPremium || isInTrial)
                    const SizedBox(height: AppSpacing.md),

                  // Features list
                  _FeaturesCard(),

                  const SizedBox(height: AppSpacing.lg),

                  // Plan card — 299 TL annual
                  _PlanCard(),

                  const SizedBox(height: AppSpacing.lg),

                  // Promo aktifken: tüm satın alma akışı saklı.
                  // CTA: ana ekrana dön.
                  if (isPromoActive) ...[
                    SizedBox(
                      height: AppSpacing.touchPreferred,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.textOnPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusMd),
                          ),
                        ),
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go(AppRoutes.home);
                          }
                        },
                        icon: const Icon(Icons.arrow_forward_rounded),
                        label: Text(
                          'Bidome hîn bibe',
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.textOnPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    // Primary CTA — Subscribe
                    if (!isAlreadyPremium)
                      SizedBox(
                        height: AppSpacing.touchPreferred,
                        child: FilledButton.icon(
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.textOnPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusMd),
                            ),
                          ),
                          onPressed: () => _onSubscribe(context, notifier),
                          icon: const Icon(Icons.workspace_premium_rounded),
                          label: Text(
                            'Aboneya salane — ${SubscriptionConstants.annualPriceTry} ₺',
                            style: AppTypography.labelLarge.copyWith(
                              color: AppColors.textOnPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                    // Trial CTA (yalnız tier=none ise)
                    if (canStartTrial) ...[
                      const SizedBox(height: AppSpacing.sm),
                      SizedBox(
                        height: AppSpacing.touchPreferred,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusMd),
                            ),
                          ),
                          onPressed: () => _onStartTrial(context, notifier),
                          icon: const Icon(Icons.play_arrow_rounded),
                          label: Text(
                            '7 roj bê pere biceribîne',
                            style: AppTypography.labelLarge.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],

                  const SizedBox(height: AppSpacing.sm),

                  // Restore CTA
                  TextButton(
                    onPressed: () => _onRestore(context, notifier),
                    child: Text(
                      'Aboneyê vegerîne',
                      style: AppTypography.label.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Legal small print
                  Text(
                    '7 rojên ceribandinê bê pere ne — kart pêwîst nine. '
                    'Aboneya salane ${SubscriptionConstants.annualPriceTry} ₺ ye, '
                    'tu dikarî her dem îptal bikî. '
                    'Bi xwendina Şertên Bikaranînê û Polîtîkaya Nehêniyê re mafê we girtî ye.',
                    textAlign: TextAlign.center,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textTertiary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: AppSpacing.sm,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () =>
                            context.push(AppRoutes.termsOfService),
                        child: Text(
                          'Şertên Bikaranînê',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () =>
                            context.push(AppRoutes.privacyPolicy),
                        child: Text(
                          'Polîtîkaya Nehêniyê',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Action handlers ─────────────────────────────────────────

  Future<void> _onStartTrial(
    BuildContext context,
    SubscriptionNotifier notifier,
  ) async {
    final ok = await notifier.startTrial();
    if (!context.mounted) return;
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          content: const Text(
            'Ceribandina 7 rojan dest pê kir 🎉',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      );
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(AppRoutes.home);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Te berê ceribandin xwest — ji kerema xwe abone bibe.'),
        ),
      );
    }
  }

  Future<void> _onSubscribe(
    BuildContext context,
    SubscriptionNotifier notifier,
  ) async {
    // PLAY BILLING TODO: bunun yerine InAppPurchase.instance.buyNonConsumable
    // ile SKU 'lutke_yearly_299_try' satın al. onPurchaseUpdated'da
    // notifier.activatePremium() çağır.
    //
    // Geçici olarak: bilgi diyalogu göster — Play Console kurulumu
    // bekleniyor. Test build'lerinde "geçici aktive et" seçeneği var.
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Aboneya Salane'),
        content: Text(
          'LÛTKE Premium ${SubscriptionConstants.annualPriceTry} ₺ / sal\n\n'
          'Bilkêr: hemû Kurmancî, hemû ast, hemû çalakî bê sînor.\n\n'
          'NOT (test): Play Billing kurulumu ji bo weşana fermî pêwîst e. '
          'Niha ji bo ceribandinê tu dikarî "Aktîfkirina demkî" hilbijêrî.',
          style: const TextStyle(height: 1.5),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop('cancel'),
            child: const Text('Vegere'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop('activate'),
            child: const Text('Aktîfkirina demkî'),
          ),
        ],
      ),
    );

    if (result == 'activate' && context.mounted) {
      await notifier.activatePremium();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFF4CAF50),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Premium aktîf bû! Bi kêfxweşî bişopîne 🌟',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      );
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(AppRoutes.home);
      }
    }
  }

  Future<void> _onRestore(
    BuildContext context,
    SubscriptionNotifier notifier,
  ) async {
    await notifier.restorePurchase();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Ji nû ve hat barkirin.'),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// FEATURES CARD
// ════════════════════════════════════════════════════════════════

class _FeaturesCard extends StatelessWidget {
  static const _features = [
    (Icons.menu_book_rounded, 'Hemû ast: A1 → C2'),
    (Icons.headphones_rounded, 'Bi deng: TTS + dengbêjî'),
    (Icons.workspace_premium_rounded, 'Belgeyên CEFR'),
    (Icons.auto_awesome_rounded, 'FSRS — bîranîna zîrek'),
    (Icons.menu_book_outlined, 'Edebiyat û çand'),
    (Icons.cloud_off_rounded, 'Bê înternet jî dixebite'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < _features.length; i++) ...[
            Row(
              children: [
                Icon(
                  _features[i].$1,
                  size: 22,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    _features[i].$2,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Icon(
                  Icons.check_rounded,
                  size: 18,
                  color: const Color(0xFF4CAF50),
                ),
              ],
            ),
            if (i < _features.length - 1) const SizedBox(height: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// PLAN CARD
// ════════════════════════════════════════════════════════════════

class _PlanCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.primary, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Text(
                  'TÊKILDARÎ',
                  style: AppTypography.caption.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'Salane',
                style: AppTypography.label.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${SubscriptionConstants.annualPriceTry}',
                style: AppTypography.display.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 44,
                  height: 1,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  '₺ / sal',
                  style: AppTypography.body.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Bi mehê ji 25 ₺ kêmtir — bê sînor.',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// STATUS BANNER (premium aktif / deneme aktif)
// ════════════════════════════════════════════════════════════════

class _StatusBanner extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const _StatusBanner({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
