import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../lessons/domain/lesson_entities.dart';
import 'gamification_provider.dart';

// ════════════════════════════════════════════════════════════════
// 1. XP PROGRESS BAR — Seviye rozeti + animasyonlu dolum
// ════════════════════════════════════════════════════════════════

class XPProgressBar extends ConsumerWidget {
  final bool showLabel;
  final bool compact;
  const XPProgressBar({
    super.key,
    this.showLabel = true,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gamificationProvider);
    final numLevel = state.numericLevel;
    final currentXP = LevelSystem.xpInCurrentLevel(state.totalXP);
    final rangeXP = LevelSystem.xpRangeForCurrentLevel(state.totalXP);
    final progress = state.levelProgress;

    if (compact) {
      return _CompactXPBar(
        level: numLevel,
        currentXP: currentXP,
        rangeXP: rangeXP,
        progress: progress,
      );
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: AppRadius.lg,
        border: Border.all(
          color: AppColors.borderLight,
          width: AppSpacing.borderThin,
        ),
      ),
      child: Row(
        children: [
          // ── Seviye Rozeti ─────────────────────────────
          _LevelBadgeCircle(level: numLevel),

          const SizedBox(width: AppSpacing.md),

          // ── XP Barı + Metin ──────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showLabel)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Seviye $numLevel',
                        style: AppTypography.captionStrong.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '$currentXP / $rangeXP XP',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                if (showLabel) const SizedBox(height: AppSpacing.xs),
                ClipRRect(
                  borderRadius: AppRadius.full,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: progress),
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.easeOutCubic,
                    builder: (_, value, __) => Stack(
                      children: [
                        // Arka plan
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.accentSurface,
                            borderRadius: AppRadius.full,
                          ),
                        ),
                        // Dolum — gradient
                        FractionallySizedBox(
                          widthFactor: value.clamp(0.02, 1.0),
                          child: Container(
                            height: 10,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.accent,
                                  AppColors.accentWarm,
                                ],
                              ),
                              borderRadius: AppRadius.full,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.accent.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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

/// Kompakt XP barı — home header'da kullanım için
class _CompactXPBar extends StatelessWidget {
  final int level;
  final int currentXP;
  final int rangeXP;
  final double progress;

  const _CompactXPBar({
    required this.level,
    required this.currentXP,
    required this.rangeXP,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Mini seviye rozeti
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.accent, AppColors.accentWarm],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$level',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: AppRadius.full,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: progress),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutCubic,
                  builder: (_, value, __) => Stack(
                    children: [
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: AppColors.accentSurface,
                          borderRadius: AppRadius.full,
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: value.clamp(0.02, 1.0),
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.accent,
                                AppColors.accentWarm,
                              ],
                            ),
                            borderRadius: AppRadius.full,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '$currentXP / $rangeXP XP',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Dairesel seviye rozeti
class _LevelBadgeCircle extends StatelessWidget {
  final int level;
  const _LevelBadgeCircle({required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.accent, AppColors.accentWarm],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '$level',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1,
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// 2. ACHIEVEMENT BADGE GRID — Kazanılan / Kilitli rozetler
// ════════════════════════════════════════════════════════════════

class AchievementBadgeGrid extends ConsumerWidget {
  const AchievementBadgeGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gamificationProvider);
    final earned = Set<String>.from(state.earnedBadgeIds);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bölüm başlığı
        Row(
          children: [
            Text(
              'Xelatên min',
              style: AppTypography.kurmanjiCard.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap.hXs,
            Text(
              '/ Rozetlerim',
              style: AppTypography.caption,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: AppColors.accentSurface,
                borderRadius: AppRadius.full,
              ),
              child: Text(
                '${earned.length}/${kBadges.length}',
                style: AppTypography.captionStrong.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ),
          ],
        ),
        Gap.md,

        // Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.78,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
          ),
          itemCount: kBadges.length,
          itemBuilder: (context, index) {
            final badge = kBadges[index];
            final isEarned = earned.contains(badge.id);

            return GestureDetector(
              onTap: () => _showBadgeDetail(context, badge, isEarned),
              child: _AchievementBadgeTile(
                badge: badge,
                isEarned: isEarned,
                delay: Duration(milliseconds: index * 70),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showBadgeDetail(
      BuildContext context, BadgeModel badge, bool isEarned) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _BadgeDetailSheet(badge: badge, isEarned: isEarned),
    );
  }
}

class _AchievementBadgeTile extends StatelessWidget {
  final BadgeModel badge;
  final bool isEarned;
  final Duration delay;

  const _AchievementBadgeTile({
    required this.badge,
    required this.isEarned,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: isEarned
            ? AppColors.accentSurface
            : AppColors.backgroundSecondary,
        borderRadius: AppRadius.lg,
        border: Border.all(
          color: isEarned
              ? AppColors.accent.withOpacity(0.4)
              : AppColors.borderLight,
          width: isEarned ? 1.5 : AppSpacing.borderThin,
        ),
        boxShadow: isEarned
            ? [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Rozet ikonu — emoji veya kilitli
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isEarned
                  ? AppColors.accent.withOpacity(0.12)
                  : AppColors.backgroundTertiary,
              shape: BoxShape.circle,
              border: isEarned
                  ? Border.all(
                      color: AppColors.accent.withOpacity(0.3),
                      width: 2,
                    )
                  : null,
            ),
            child: Center(
              child: isEarned
                  ? Text(
                      badge.emoji,
                      style: const TextStyle(fontSize: 24),
                    )
                  : const Icon(
                      Icons.lock_outline_rounded,
                      color: AppColors.textTertiary,
                      size: 20,
                    ),
            ),
          ),
          Gap.xs,
          // Kurmancî ad
          Text(
            isEarned ? badge.kurmanjName : '?',
            style: AppTypography.captionStrong.copyWith(
              color: isEarned
                  ? AppColors.primaryDark
                  : AppColors.textTertiary,
              fontWeight: isEarned ? FontWeight.w600 : FontWeight.w400,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // Türkçe ad
          Text(
            isEarned ? badge.turkishName : '???',
            style: AppTypography.caption.copyWith(
              color: AppColors.textTertiary,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    )
        .animate(delay: delay)
        .fadeIn(duration: 350.ms)
        .scale(begin: const Offset(0.9, 0.9));
  }
}

/// Rozet detay bottom sheet
class _BadgeDetailSheet extends StatelessWidget {
  final BadgeModel badge;
  final bool isEarned;

  const _BadgeDetailSheet({
    required this.badge,
    required this.isEarned,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: const BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXl),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tutamak
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.borderLight,
              borderRadius: AppRadius.full,
            ),
          ),
          Gap.lg,

          // Rozet ikonu
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: isEarned
                  ? AppColors.accentSurface
                  : AppColors.backgroundTertiary,
              shape: BoxShape.circle,
              border: isEarned
                  ? Border.all(
                      color: AppColors.accent.withOpacity(0.4),
                      width: 3,
                    )
                  : null,
            ),
            child: Center(
              child: isEarned
                  ? Text(
                      badge.emoji,
                      style: const TextStyle(fontSize: 36),
                    )
                  : const Icon(
                      Icons.lock_outline_rounded,
                      color: AppColors.textTertiary,
                      size: 36,
                    ),
            ),
          )
              .animate()
              .scale(
                begin: const Offset(0.6, 0.6),
                duration: 500.ms,
                curve: Curves.elasticOut,
              ),

          Gap.md,

          // Kurmancî ad
          Text(
            badge.kurmanjName,
            style: AppTypography.headline.copyWith(
              color: isEarned ? AppColors.primaryDark : AppColors.textTertiary,
            ),
          ).animate().fadeIn(delay: 150.ms),

          Gap.xs,

          // Türkçe ad
          Text(
            badge.turkishName,
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
            ),
          ).animate().fadeIn(delay: 200.ms),

          Gap.md,

          // Açıklama
          Text(
            badge.description,
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 250.ms),

          Gap.md,

          // Durum rozeti
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: isEarned
                  ? AppColors.successSurface
                  : AppColors.backgroundTertiary,
              borderRadius: AppRadius.full,
            ),
            child: Text(
              isEarned ? 'Hatiye bidestxistin!' : 'Hêj nehat',
              style: AppTypography.captionStrong.copyWith(
                color: isEarned ? AppColors.success : AppColors.textTertiary,
              ),
            ),
          ).animate().fadeIn(delay: 300.ms),

          Gap.lg,
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// 3. LEVEL-UP CELEBRATION OVERLAY
// Tam ekran — konfeti animasyonu + "Piroz be!" mesajı
// ════════════════════════════════════════════════════════════════

class LevelUpCelebrationOverlay extends ConsumerWidget {
  const LevelUpCelebrationOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gamificationProvider);

    if (!state.showLevelUp) return const SizedBox.shrink();

    return _LevelUpContent(
      newLevel: state.numericLevel,
      onDismiss: () => ref.read(gamificationProvider.notifier).clearLevelUp(),
    );
  }
}

class _LevelUpContent extends StatefulWidget {
  final int newLevel;
  final VoidCallback onDismiss;

  const _LevelUpContent({
    required this.newLevel,
    required this.onDismiss,
  });

  @override
  State<_LevelUpContent> createState() => _LevelUpContentState();
}

class _LevelUpContentState extends State<_LevelUpContent>
    with TickerProviderStateMixin {
  late final List<_ConfettiParticle> _particles;
  late final AnimationController _confettiController;

  @override
  void initState() {
    super.initState();
    final random = Random();
    _particles = List.generate(40, (i) {
      return _ConfettiParticle(
        x: random.nextDouble(),
        speed: 0.3 + random.nextDouble() * 0.7,
        size: 4 + random.nextDouble() * 8,
        color: [
          AppColors.accent,
          AppColors.accentWarm,
          AppColors.primary,
          AppColors.primaryLight,
          AppColors.success,
          AppColors.badgeGold,
        ][random.nextInt(6)],
        rotation: random.nextDouble() * 2 * pi,
        wobble: random.nextDouble() * 0.02,
      );
    });

    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onDismiss,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.7),
          child: Stack(
            children: [
              // ── Konfeti animasyonu ──────────────────────
              AnimatedBuilder(
                animation: _confettiController,
                builder: (context, _) {
                  return CustomPaint(
                    size: MediaQuery.of(context).size,
                    painter: _ConfettiPainter(
                      particles: _particles,
                      progress: _confettiController.value,
                    ),
                  );
                },
              ),

              // ── İçerik ─────────────────────────────────
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Yıldız parıltısı
                    _GlowRing()
                        .animate()
                        .scale(
                          begin: const Offset(0, 0),
                          end: const Offset(1, 1),
                          duration: 600.ms,
                          curve: Curves.elasticOut,
                        )
                        .fadeIn(duration: 300.ms),

                    Gap.lg,

                    // Ana kart
                    Container(
                      width: 300,
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundSecondary,
                        borderRadius: AppRadius.xl,
                        border: Border.all(
                          color: AppColors.accent,
                          width: 2.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accent.withOpacity(0.3),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Seviye rozeti — büyük
                          Container(
                            width: 88,
                            height: 88,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.accent,
                                  AppColors.accentWarm,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColors.accent.withOpacity(0.4),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '${widget.newLevel}',
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  height: 1,
                                ),
                              ),
                            ),
                          )
                              .animate(delay: 300.ms)
                              .scale(
                                begin: const Offset(0.3, 0.3),
                                duration: 700.ms,
                                curve: Curves.elasticOut,
                              ),

                          Gap.lg,

                          // "Piroz be!" — Kurmancî birincil
                          Text(
                            'Piroz be!',
                            style: AppTypography.kurmanjiLarge.copyWith(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                              .animate(delay: 500.ms)
                              .fadeIn(duration: 400.ms),

                          Gap.xs,

                          Text(
                            'Tebrikler!',
                            style: AppTypography.caption.muted,
                          )
                              .animate(delay: 600.ms)
                              .fadeIn(duration: 400.ms),

                          Gap.md,

                          // Seviye metni
                          Text(
                            'Seviye ${widget.newLevel}',
                            style: AppTypography.headline.copyWith(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                              .animate(delay: 700.ms)
                              .fadeIn(duration: 400.ms),

                          Gap.lg,

                          // Devam butonu
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: widget.onDismiss,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSpacing.sm + AppSpacing.xs,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: AppRadius.md,
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Berdewam bike!',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                              .animate(delay: 900.ms)
                              .fadeIn(duration: 400.ms)
                              .slideY(begin: 0.2, end: 0),
                        ],
                      ),
                    )
                        .animate(delay: 150.ms)
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: 0.1, end: 0),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
          .animate()
          .fadeIn(duration: 300.ms),
    );
  }
}

// Konfeti parçacık verisi
class _ConfettiParticle {
  final double x;
  final double speed;
  final double size;
  final Color color;
  final double rotation;
  final double wobble;

  const _ConfettiParticle({
    required this.x,
    required this.speed,
    required this.size,
    required this.color,
    required this.rotation,
    required this.wobble,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;
  final double progress;

  _ConfettiPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final y = -20 + (size.height + 40) * (p.speed * progress) % (size.height + 40);
      final x = p.x * size.width +
          sin(progress * 10 + p.rotation) * 30 * (1 + p.wobble * 10);

      final paint = Paint()
        ..color = p.color.withOpacity(0.8)
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(progress * 5 + p.rotation);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.6),
          const Radius.circular(1),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// ════════════════════════════════════════════════════════════════
// 4. DAILY REWARD WIDGET — Xelata Rojane
// Animasyonlu hediye kutusu + +50 XP
// ════════════════════════════════════════════════════════════════

class DailyRewardWidget extends ConsumerStatefulWidget {
  const DailyRewardWidget({super.key});

  @override
  ConsumerState<DailyRewardWidget> createState() => _DailyRewardWidgetState();
}

class _DailyRewardWidgetState extends ConsumerState<DailyRewardWidget>
    with SingleTickerProviderStateMixin {
  bool _isOpening = false;
  bool _showXP = false;

  Future<void> _claimReward() async {
    if (_isOpening) return;
    setState(() => _isOpening = true);

    // Kutu açılma animasyonu bekle
    await Future.delayed(const Duration(milliseconds: 600));

    final claimed =
        await ref.read(gamificationProvider.notifier).claimDailyReward();

    if (claimed && mounted) {
      setState(() => _showXP = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(gamificationProvider);
    final isAvailable = state.dailyRewardAvailable;

    if (!isAvailable && !_showXP) {
      return _ClaimedDailyReward();
    }

    return GestureDetector(
      onTap: isAvailable ? _claimReward : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          gradient: isAvailable
              ? LinearGradient(
                  colors: [
                    AppColors.accent.withOpacity(0.1),
                    AppColors.accentWarm.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isAvailable ? null : AppColors.backgroundSecondary,
          borderRadius: AppRadius.lg,
          border: Border.all(
            color: isAvailable
                ? AppColors.accent.withOpacity(0.3)
                : AppColors.borderLight,
            width: isAvailable ? 1.5 : AppSpacing.borderThin,
          ),
        ),
        child: Row(
          children: [
            // Hediye kutusu ikonu
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.elasticOut,
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isAvailable
                    ? AppColors.accentSurface
                    : AppColors.backgroundTertiary,
                shape: BoxShape.circle,
                border: isAvailable
                    ? Border.all(
                        color: AppColors.accent.withOpacity(0.3),
                        width: 2,
                      )
                    : null,
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: _isOpening
                      ? Icon(
                          Icons.celebration_rounded,
                          key: const ValueKey('open'),
                          color: AppColors.accent,
                          size: 24,
                        )
                      : Icon(
                          Icons.card_giftcard_rounded,
                          key: const ValueKey('gift'),
                          color: isAvailable
                              ? AppColors.accent
                              : AppColors.textTertiary,
                          size: 24,
                        ),
                ),
              ),
            )
                .animate(
                  autoPlay: isAvailable,
                  onComplete: (c) {
                    if (isAvailable) c.loop(count: 0);
                  },
                )
                .then(delay: 2000.ms)
                .shake(hz: 2, duration: 600.ms, offset: const Offset(0, 1)),

            const SizedBox(width: AppSpacing.md),

            // Metin
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Xelata Rojane',
                    style: AppTypography.kurmanjiCard.copyWith(
                      color: isAvailable
                          ? AppColors.accent
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    isAvailable
                        ? 'Dersê bike, +${GamificationNotifier.dailyRewardXP} XP bistîne!'
                        : 'Xelata te ya rojane hat',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // XP kazanma göstergesi
            if (_showXP)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentSurface,
                  borderRadius: AppRadius.full,
                ),
                child: Text(
                  '+${GamificationNotifier.dailyRewardXP} XP',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
                  .animate()
                  .fadeIn(duration: 300.ms)
                  .scale(
                    begin: const Offset(0.5, 0.5),
                    duration: 400.ms,
                    curve: Curves.elasticOut,
                  )
            else if (isAvailable)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: AppRadius.full,
                ),
                child: Text(
                  '+${GamificationNotifier.dailyRewardXP} XP',
                  style: AppTypography.labelSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Zaten alınmış günlük ödül gösterimi
class _ClaimedDailyReward extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.successSurface,
        borderRadius: AppRadius.lg,
        border: Border.all(
          color: AppColors.success.withOpacity(0.2),
          width: AppSpacing.borderThin,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_rounded,
            color: AppColors.success,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'Xelata rojane hat wergirtin',
            style: AppTypography.caption.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            '+${GamificationNotifier.dailyRewardXP} XP',
            style: AppTypography.captionStrong.copyWith(
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// XP KAZANMA ANİMASYONU (+10 XP popup)
// ════════════════════════════════════════════════════════════════

class XPGainAnimation extends StatelessWidget {
  final int xpAmount;
  const XPGainAnimation({super.key, required this.xpAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentSurface,
        borderRadius: AppRadius.full,
        border: Border.all(
          color: AppColors.accent.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded,
              color: AppColors.accent, size: 16),
          Gap.hXs,
          Text(
            '+$xpAmount XP',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.3, end: -0.5, duration: 800.ms)
        .then()
        .fadeOut(duration: 400.ms);
  }
}

// ════════════════════════════════════════════════════════════════
// ROZET KAZANMA ANİMASYONU — 1200ms törensel
// Araştırma: Kültürel kimlik rozetleri — törensel his
// ════════════════════════════════════════════════════════════════

class BadgeEarnedOverlay extends ConsumerWidget {
  const BadgeEarnedOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gamificationProvider);
    final badgeId = state.newlyEarnedBadgeId;

    if (badgeId == null) return const SizedBox.shrink();

    final badge = kBadges.where((b) => b.id == badgeId).firstOrNull;
    if (badge == null) return const SizedBox.shrink();

    return _BadgeOverlayContent(
      badge: badge,
      onDismiss: () => ref.read(gamificationProvider.notifier).clearNewBadge(),
    );
  }
}

class _BadgeOverlayContent extends StatelessWidget {
  final BadgeModel badge;
  final VoidCallback onDismiss;

  const _BadgeOverlayContent({
    required this.badge,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDismiss,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.65),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Parıltı halkası
                _GlowRing()
                    .animate()
                    .scale(
                      begin: const Offset(0, 0),
                      end: const Offset(1, 1),
                      duration: 600.ms,
                      curve: Curves.elasticOut,
                    )
                    .fadeIn(duration: 300.ms),

                Gap.lg,

                // Rozet kartı
                Container(
                  width: 290,
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundSecondary,
                    borderRadius: AppRadius.xl,
                    border: Border.all(
                      color: AppColors.accent,
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withOpacity(0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Rozet ikonu — emoji
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.accentSurface,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.accent.withOpacity(0.4),
                            width: 3,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            badge.emoji,
                            style: const TextStyle(fontSize: 40),
                          ),
                        ),
                      )
                          .animate(delay: 400.ms)
                          .scale(
                            begin: const Offset(0.5, 0.5),
                            duration: 700.ms,
                            curve: Curves.elasticOut,
                          ),

                      Gap.md,

                      // "Xelat hat!" başlığı — Kurmancî önce
                      Text(
                        'Xelat hat!',
                        style: AppTypography.kurmanjiLarge.copyWith(
                          color: AppColors.accent,
                        ),
                      )
                          .animate(delay: 600.ms)
                          .fadeIn(duration: 400.ms),

                      Gap.xs,

                      Text(
                        'Nîşan hat bidestxistin!',
                        style: AppTypography.caption.muted,
                      )
                          .animate(delay: 700.ms)
                          .fadeIn(duration: 400.ms),

                      Gap.lg,

                      // Rozet adı — Kurmancî birincil
                      Text(
                        badge.kurmanjName,
                        style: AppTypography.headline.copyWith(
                          color: AppColors.primaryDark,
                        ),
                      )
                          .animate(delay: 800.ms)
                          .fadeIn(duration: 400.ms),

                      Gap.xs,

                      // Türkçe ikincil
                      Text(
                        badge.turkishName,
                        style: AppTypography.caption,
                      )
                          .animate(delay: 900.ms)
                          .fadeIn(duration: 400.ms),

                      Gap.xs,

                      Text(
                        badge.description,
                        style: AppTypography.body.muted,
                        textAlign: TextAlign.center,
                      )
                          .animate(delay: 1000.ms)
                          .fadeIn(duration: 400.ms),

                      Gap.lg,

                      // XP bonusu
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentSurface,
                          borderRadius: AppRadius.full,
                        ),
                        child: Text(
                          '+${XPRules.badgeEarned} XP',
                          style: AppTypography.label.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                          .animate(delay: 1100.ms)
                          .fadeIn(duration: 300.ms)
                          .scale(
                            begin: const Offset(0.8, 0.8),
                            duration: 400.ms,
                            curve: Curves.elasticOut,
                          ),

                      Gap.lg,

                      // Devam butonu
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: onDismiss,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.sm + AppSpacing.xs,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: AppRadius.md,
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Berdewam bike!',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                          .animate(delay: 1200.ms)
                          .fadeIn(duration: 300.ms),
                    ],
                  ),
                )
                    .animate(delay: 200.ms)
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: 0.15, end: 0),
              ],
            ),
          ),
        ),
      )
          .animate()
          .fadeIn(duration: 300.ms),
    );
  }
}

// Parıltı halkası — rozet ve seviye overlay'leri için ortak
class _GlowRing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(3, (i) {
          return Animate(
            effects: [
              ScaleEffect(
                begin: const Offset(0.8, 0.8),
                end: Offset(1.2 + i * 0.15, 1.2 + i * 0.15),
                duration: (1000 + i * 200).ms,
                delay: (i * 150).ms,
                curve: Curves.easeOut,
              ),
              FadeEffect(
                begin: 0.6,
                end: 0.0,
                duration: (1000 + i * 200).ms,
                delay: (i * 150).ms,
              ),
            ],
            onComplete: (c) => c.loop(),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.accent.withOpacity(0.6 - i * 0.15),
                  width: 2,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// HAFTALIK RİTİM KARTI
// ════════════════════════════════════════════════════════════════

class WeeklyRhythmWidget extends ConsumerWidget {
  final String? anchorName;
  const WeeklyRhythmWidget({super.key, this.anchorName});

  static const _dayLabels = ['Dş', 'Sş', 'Çş', 'Pş', 'În', 'Şe', 'Yk'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gamificationProvider);
    final rhythm = state.weeklyRhythm;
    final today = rhythm.todayIndex;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: AppRadius.lg,
        border: Border.all(color: AppColors.borderLight,
            width: AppSpacing.borderThin),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Başlık satırı ─────────────────────────────────────
          Row(
            children: [
              Text('Ev hefta',
                  style: AppTypography.kurmanjiCard
                      .copyWith(color: AppColors.primary)),
              Gap.hXs,
              Text('/ Vê hefteyê', style: AppTypography.caption),
              const Spacer(),
              Text(
                '${rhythm.activeDayCount} / ${WeeklyRhythmState.weekGoalDays} roj',
                style: AppTypography.captionStrong.copyWith(
                  color: rhythm.weekGoalMet
                      ? AppColors.success
                      : AppColors.accent,
                ),
              ),
            ],
          ),

          Gap.sm,

          // ── 7 Gün görselleştirmesi ─────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final isActive = rhythm.activeDays[i];
              final isToday = i == today;

              return Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutBack,
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.primary
                          : AppColors.primarySurface,
                      shape: BoxShape.circle,
                      border: isToday
                          ? Border.all(
                              color: AppColors.accent,
                              width: 2.5,
                            )
                          : null,
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.25),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              )
                            ]
                          : null,
                    ),
                    child: isActive
                        ? const Icon(Icons.check,
                            color: Colors.white, size: 18)
                        : null,
                  ),
                  Gap.xs,
                  Text(
                    _dayLabels[i],
                    style: AppTypography.caption.copyWith(
                      color: isToday
                          ? AppColors.accent
                          : AppColors.textTertiary,
                      fontWeight: isToday
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ],
              );
            }),
          ),

          Gap.sm,

          // ── İlerleme barı ─────────────────────────────────────
          ClipRRect(
            borderRadius: AppRadius.full,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              child: LinearProgressIndicator(
                value: rhythm.weekProgress,
                backgroundColor: AppColors.primarySurface,
                color: rhythm.weekGoalMet
                    ? AppColors.success
                    : AppColors.primary,
                minHeight: 6,
              ),
            ),
          ),

          Gap.sm,

          // ── Motivasyon metni ───────────────────────────────────
          _WeeklyMessage(
            rhythm: rhythm,
            anchorName: anchorName,
          ),
        ],
      ),
    );
  }
}

class _WeeklyMessage extends StatelessWidget {
  final WeeklyRhythmState rhythm;
  final String? anchorName;

  const _WeeklyMessage({required this.rhythm, this.anchorName});

  @override
  Widget build(BuildContext context) {
    final remaining = WeeklyRhythmState.weekGoalDays - rhythm.activeDayCount;
    final name = anchorName;

    String message;
    Color color;

    if (rhythm.weekGoalMet) {
      message = name != null
          ? '$name ji bo ev hefta hedef qediya!'
          : 'Ev hefta hedef qediya!';
      color = AppColors.success;
    } else if (remaining <= 1) {
      message = name != null
          ? '$name ji bo tenê $remaining roj!'
          : 'Hefteya hedef $remaining roj ma!';
      color = AppColors.accent;
    } else {
      message = name != null
          ? '$name ji bo $remaining roj zêdetir çalak bimîne'
          : 'Hedef: $remaining roj zêdetir çalak bimîne';
      color = AppColors.textSecondary;
    }

    return Text(
      message,
      style: AppTypography.caption.copyWith(color: color),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// HAFTALIK ÖZET KARTI
// ════════════════════════════════════════════════════════════════

class WeeklySummaryCard extends ConsumerWidget {
  final String? anchorName;
  const WeeklySummaryCard({super.key, this.anchorName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gamificationProvider);
    final rhythm = state.weeklyRhythm;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: AppRadius.lg,
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          // Haftalık seri
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${rhythm.weekStreak}',
                  style: AppTypography.streakCounter),
              Text('Hefte',
                  style: AppTypography.caption.primary),
              Text('Rêza heftanê',
                  style: AppTypography.caption.muted),
            ],
          ),

          Gap.hLg,

          Container(
            width: 1,
            height: 60,
            color: AppColors.borderLight,
          ),

          Gap.hLg,

          // Bu hafta istatistik
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ev hefta',
                  style: AppTypography.captionStrong,
                ),
                Gap.xs,
                Text(
                  '${rhythm.activeDayCount} roj çalak · ${state.totalXP} XP',
                  style: AppTypography.body.primary,
                ),
                Gap.xs,
                Text(
                  rhythm.weekGoalMet
                      ? 'Hefteya hedef qediya!'
                      : '${WeeklyRhythmState.weekGoalDays - rhythm.activeDayCount} roj zêdetir',
                  style: AppTypography.caption.copyWith(
                    color: rhythm.weekGoalMet
                        ? AppColors.success
                        : AppColors.textSecondary,
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

// ════════════════════════════════════════════════════════════════
// ESKI ROZET IZGARASI — BadgeGrid (geriye uyumluluk)
// AchievementBadgeGrid'e yönlendirir
// ════════════════════════════════════════════════════════════════

class BadgeGrid extends ConsumerWidget {
  const BadgeGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AchievementBadgeGrid();
  }
}
