import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/providers/learning_module_provider.dart';

/// LÛTKE — Öğrenme Modülü Seçici
///
/// Kullanıcı 2 modül arasında seçer:
///   1. Fêrî Kurdî bibe — Kurmancî öğren (mevcut sistem)
///   2. Fêrî Îngilîzî bibe — Kurmancî üzerinden İngilizce öğren
///
/// Seçim SharedPreferences'a kaydedilir, ana sayfadan değiştirilebilir.
class ModuleSelectScreen extends ConsumerWidget {
  const ModuleSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Semantics(
                    label: 'Logoya LÛTKE',
                    image: true,
                    child: Image.asset(
                      'assets/images/logo_512.png',
                      width: 120,
                      height: 120,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  // A11Y: H1 — screen reader announces page heading.
                  Semantics(
                    header: true,
                    child: Text(
                      'Tu dixwazî çi fêr bibî?',
                      style: AppTypography.headline.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Modulekê hilbijêre ku bi Kurmancî dest pê bikî',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  _ModuleCard(
                    title: 'Fêrî Kurmancî bibe',
                    subtitle: 'Zimanê dayikê — bi kok û dirêjahî',
                    emoji: '🐐',
                    color: AppColors.primary,
                    onTap: () async {
                      await ref.read(learningModuleProvider.notifier)
                          .setModule(LearningModule.kurmanci);
                      if (context.mounted) {
                        context.go(AppRoutes.home);
                      }
                    },
                  ),

                  const SizedBox(height: AppSpacing.md),

                  _ModuleCard(
                    title: 'Fêrî Îngilîzî bibe',
                    subtitle: 'English — bi rêya Kurmancî',
                    emoji: '🌍',
                    color: AppColors.accent,
                    onTap: () async {
                      await ref.read(learningModuleProvider.notifier)
                          .setModule(LearningModule.english);
                      if (context.mounted) {
                        context.go(AppRoutes.enHome);
                      }
                    },
                  ),

                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Tu dikarî paşê hilbijartina xwe biguherînî',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textTertiary,
                    ),
                    textAlign: TextAlign.center,
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

class _ModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String emoji;
  final Color color;
  final VoidCallback onTap;

  const _ModuleCard({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$title — $subtitle',
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          // A11Y: visible keyboard focus ring.
          focusColor: color.withValues(alpha: 0.25),
          child: Container(
            constraints: const BoxConstraints(minHeight: 88),
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.12),
                  color.withValues(alpha: 0.04),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: color.withValues(alpha: 0.25),
                width: 1.5,
              ),
            ),
            child: ExcludeSemantics(
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(emoji,
                        style: const TextStyle(fontSize: 32)),
                  ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.title.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: color,
                  size: 18,
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
