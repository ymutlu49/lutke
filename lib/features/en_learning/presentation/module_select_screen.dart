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
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_512.png',
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Tu çi dixwazî fêr bibî?',
                    style: AppTypography.headline.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Modulekê hilbijêre',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  _ModuleCard(
                    title: 'Fêrî Kurdî bibe',
                    subtitle: 'Kurmancî — Zimanê dayikê',
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
                    subtitle: 'English — Bi rêya Kurmancî',
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
                    'Tu paşê dikarî biguherînî',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textTertiary,
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.12),
                color.withOpacity(0.04),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: color.withOpacity(0.25),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(emoji, style: const TextStyle(fontSize: 32)),
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
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
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
    );
  }
}
