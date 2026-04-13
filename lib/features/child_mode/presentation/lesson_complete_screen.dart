import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/child_theme.dart';
import '../../../core/router/app_router.dart';
import 'widgets/star_display_widget.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Ders Tamamlama Kutlama Ekranı
//
// Ders bittiğinde gösterilir:
//   - Maskot kutlama dansı
//   - Yıldız gösterimi (1-3)
//   - Yeni çıkartma açılışı
//   - Hazine sandığı efekti
// ════════════════════════════════════════════════════════════════

class ChildLessonCompleteScreen extends StatelessWidget {
  final int correctCount;
  final int totalCount;
  final int xpEarned;
  final String? stickerEmoji;
  final String? stickerName;

  const ChildLessonCompleteScreen({
    super.key,
    required this.correctCount,
    required this.totalCount,
    required this.xpEarned,
    this.stickerEmoji,
    this.stickerName,
  });

  double get accuracy =>
      totalCount > 0 ? correctCount / totalCount : 0.0;

  int get stars =>
      accuracy >= 0.9 ? 3 : (accuracy >= 0.5 ? 2 : (accuracy > 0 ? 1 : 0));

  int get starsEarned => xpEarned ~/ 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChildColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // ── Maskot Kutlaması ────────────────────────────
              const Text('🐐', style: TextStyle(fontSize: 80))
                  .animate()
                  .scale(
                      begin: const Offset(0.3, 0.3),
                      curve: Curves.elasticOut,
                      duration: 800.ms)
                  .then()
                  .moveY(begin: 0, end: -15, duration: 300.ms)
                  .then()
                  .moveY(begin: -15, end: 0, duration: 300.ms),

              const SizedBox(height: 16),

              // ── Tebrik Mesajı ──────────────────────────────
              Text(
                stars >= 3 ? 'Pirr baş!' : stars >= 2 ? 'Aferin!' : 'Baş e!',
                style: ChildTypography.display.copyWith(
                  color: ChildColors.primary,
                ),
              ).animate().fadeIn(delay: 600.ms),

              const SizedBox(height: 8),

              Text(
                '$correctCount / $totalCount rast',
                style: ChildTypography.bodyLarge.copyWith(
                  color: ChildColors.textSecondary,
                ),
              ).animate().fadeIn(delay: 800.ms),

              const SizedBox(height: 24),

              // ── Yıldız Gösterimi ───────────────────────────
              StarCelebration(stars: stars)
                  .animate()
                  .fadeIn(delay: 400.ms),

              const SizedBox(height: 24),

              // ── Kazanılan Yıldızlar ────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: ChildColors.starYellow.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
                  border: Border.all(
                    color: ChildColors.starYellow.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('⭐', style: TextStyle(fontSize: 28)),
                    const SizedBox(width: 8),
                    Text(
                      '+$starsEarned stêrk',
                      style: ChildTypography.headline.copyWith(
                        color: ChildColors.accent,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.2),

              // ── Çıkartma (varsa) ──────────────────────────
              if (stickerEmoji != null) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: ChildColors.stickerPurple.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
                    border: Border.all(
                      color: ChildColors.stickerPurple.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Stîkera nû!',
                        style: ChildTypography.label.copyWith(
                          color: ChildColors.stickerPurple,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(stickerEmoji!,
                          style: const TextStyle(fontSize: 48)),
                      if (stickerName != null) ...[
                        const SizedBox(height: 4),
                        Text(stickerName!,
                            style: ChildTypography.caption),
                      ],
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(delay: 1200.ms)
                    .scale(
                        begin: const Offset(0.5, 0.5),
                        curve: Curves.elasticOut,
                        duration: 600.ms),
              ],

              const Spacer(flex: 2),

              // ── Butonlar ──────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: ChildSpacing.touchPreferred,
                child: ElevatedButton.icon(
                  onPressed: () => context.go(AppRoutes.childHome),
                  icon: const Icon(Icons.home_rounded, size: 24),
                  label: Text(
                    'Malê vegere',
                    style: ChildTypography.labelLarge.copyWith(
                      color: ChildColors.textOnPrimary,
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 1400.ms),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () {
                  // TODO: Sonraki derse geç
                  context.go(AppRoutes.childHome);
                },
                child: Text(
                  'Waneya din',
                  style: ChildTypography.label.copyWith(
                    color: ChildColors.primary,
                  ),
                ),
              ).animate().fadeIn(delay: 1500.ms),

              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
