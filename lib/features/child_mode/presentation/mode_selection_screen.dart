import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/child_theme.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/providers/child_mode_provider.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Mod Seçim Ekranı
//
// Giriş yaptıktan sonra kullanıcı seçer:
//   - Ji bo mezinan (Yetişkinler için)
//   - Ji bo zarokan (Çocuklar için)
//
// Tek hesap, iki mod. İstediği zaman geçiş yapabilir.
// ════════════════════════════════════════════════════════════════

class ModeSelectionScreen extends ConsumerWidget {
  const ModeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // ── Logo ──────────────────────────────────
                  ClipOval(
                    child: Container(
                      width: 80,
                      height: 80,
                      color: Colors.white,
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        'assets/images/logo_512.png',
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.medium,
                      ),
                    ),
                  ).animate().scale(
                      begin: const Offset(0.8, 0.8),
                      curve: Curves.easeOutCubic,
                      duration: 500.ms),

                  const SizedBox(height: 16),

                  Text(
                    'LÛTKE',
                    style: AppTypography.display.copyWith(
                      color: AppColors.primary,
                      fontSize: 28,
                    ),
                  ).animate().fadeIn(delay: 200.ms),

                  const SizedBox(height: 8),

                  Text(
                    'Kê dixwaze fêr bibe?',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ).animate().fadeIn(delay: 400.ms),

                  const Spacer(),

                  // ── Ji bo mezinan (Yetişkin) ──────────────
                  _ModeCard(
                    emoji: '🏔️',
                    titleKu: 'Ji bo mezinan',
                    titleTr: 'Yetişkinler için',
                    description: 'A1–C2 tam müfredat',
                    color: AppColors.primary,
                    onTap: () async {
                      await ref
                          .read(isChildModeProvider.notifier)
                          .setChildMode(false);
                      if (context.mounted) {
                        context.go(AppRoutes.home);
                      }
                    },
                  ).animate().fadeIn(delay: 600.ms).slideX(begin: -0.05),

                  const SizedBox(height: 20),

                  // ── Ji bo zarokan (Çocuk) ─────────────────
                  _ModeCard(
                    emoji: '🐐',
                    titleKu: 'Ji bo zarokan',
                    titleTr: 'Çocuklar için (7-10 yaş)',
                    description: 'Karik bi te re ye!',
                    color: ChildColors.accent,
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final childSetup = prefs.getBool('child_onboarding_complete') ?? false;

                      await ref
                          .read(isChildModeProvider.notifier)
                          .setChildMode(true);

                      if (context.mounted) {
                        if (childSetup) {
                          context.go(AppRoutes.childHome);
                        } else {
                          context.go(AppRoutes.childOnboarding);
                        }
                      }
                    },
                  ).animate().fadeIn(delay: 800.ms).slideX(begin: 0.05),

                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final String emoji;
  final String titleKu;
  final String titleTr;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _ModeCard({
    required this.emoji,
    required this.titleKu,
    required this.titleTr,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.25), width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Emoji
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 36)),
              ),
            ),
            const SizedBox(width: 20),

            // Metin
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleKu,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    titleTr,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textTertiary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: color.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
