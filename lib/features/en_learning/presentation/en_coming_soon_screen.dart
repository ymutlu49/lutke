import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/accessibility_settings.dart';

/// Ji bo ekranên egzersîzê yên ku hîna di trake Îngilîzî de ne amade
/// ne, wek şûngir tê bi kar anîn — li şûna ku em naveroka Kurmancî
/// nîşan bidin, vê ekranê tercîh dikin.
///
/// Bikarhêner ber bi EN Skills Hub ('Reading / Writing / Listening /
/// Speaking') ve tê rêvekirin — wisa cross-track content leak çênabe.
class EnComingSoonScreen extends ConsumerWidget {
  /// Etîketa Kurmancî: "Guhdarîkirin", "Çîrok" hwd.
  final String activityKu;

  /// Rêya EN alternatîf a pêşniyarkirî (mînak AppRoutes.enListening).
  /// Ger vala be, ber bi EN Home ve diçe.
  final String? suggestedRoute;

  /// Etîketa EN alternatîf a pêşniyarkirî (mînak "Guhdarîkirina EN").
  final String? suggestedLabel;

  const EnComingSoonScreen({
    super.key,
    required this.activityKu,
    this.suggestedRoute,
    this.suggestedLabel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final a11y = ref.watch(accessibilitySettingsProvider);
    return Scaffold(
      backgroundColor: a11y.background.color ?? AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          tooltip: 'Derkeve',
          onPressed: () =>
              context.canPop() ? context.pop() : context.go(AppRoutes.enHome),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // A11Y: decorative emoji; the Text below carries the message.
                  ExcludeSemantics(
                    child: const Text('🚧', style: TextStyle(fontSize: 72)),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  // A11Y: H1 heading for page title.
                  Semantics(
                    header: true,
                    child: Text(
                      'Di rê de…',
                      textAlign: TextAlign.center,
                      style: a11y.applyFont(
                        AppTypography.headingLarge.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    '"$activityKu" di trake Îngilîzî de hîna amade nîne. '
                    'Em li ser dixebitin — zû dê bigihîje te. Spas ji bo '
                    'aramiya te!',
                    textAlign: TextAlign.center,
                    style: a11y.applyFont(
                      AppTypography.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  // Pêşniyara erênî — xwendevanê bi çalakiyên alternatîf
                  // girêdide da ku çalak bimîne.
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00838F).withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: const Color(0xFF00838F)
                              .withValues(alpha: 0.25)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // A11Y: decorative emoji.
                        ExcludeSemantics(
                          child: const Text('💡',
                              style: TextStyle(fontSize: 20)),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Di vê navberê de beşên amade biceribîne: '
                            'Xwendin, Nivîsîn, Guhdarîkirin û Axaftin.',
                            style: a11y.applyFont(
                              AppTypography.bodySmall.copyWith(
                                color: AppColors.textPrimary,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  if (suggestedRoute != null)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => context.go(suggestedRoute!),
                        icon: const Icon(Icons.arrow_forward_rounded),
                        label: Text(
                          suggestedLabel ?? 'Temrîna EN biceribîne',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00838F),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(0, 52),
                          padding:
                              const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: AppSpacing.sm),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => context.go(AppRoutes.enSkillsHub),
                      icon: const Icon(Icons.school_rounded),
                      label: const Text('Navenda Jêhatîbûnên EN'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF00838F),
                        side: const BorderSide(color: Color(0xFF00838F)),
                        minimumSize: const Size(0, 52),
                        padding:
                            const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
