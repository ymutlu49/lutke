import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../lessons/domain/lesson_entities.dart';
import 'gamification_provider.dart';

// ════════════════════════════════════════════════════════════════
// HAFTALIK RİTİM KARTI
// ════════════════════════════════════════════════════════════════

class WeeklyRhythmWidget extends ConsumerWidget {
  final String? anchorName;
  const WeeklyRhythmWidget({super.key, this.anchorName});

  static const _dayLabels = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];

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
              // Kurmancî etiket — birincil
              Text('Ev hefta',
                  style: AppTypography.kurmanjiCard
                      .copyWith(color: AppColors.primary)),
              Gap.hXs,
              Text('/ Bu hafta', style: AppTypography.caption),
              const Spacer(),
              // Sayaç
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
          ? '$name için bu hafta hedefi tamamladın! 🎉'
          : 'Bu hafta hedefi tamamladın! 🎉';
      color = AppColors.success;
    } else if (remaining <= 1) {
      message = name != null
          ? '$name için sadece $remaining gün daha!'
          : 'Haftalık hedefe $remaining gün kaldı!';
      color = AppColors.accent;
    } else {
      message = name != null
          ? '$name için $remaining gün daha aktif kal'
          : 'Hedef: $remaining gün daha aktif kal';
      color = AppColors.textSecondary;
    }

    return Text(
      message,
      style: AppTypography.caption.copyWith(color: color),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// XP BAR WİDGET'I
// ════════════════════════════════════════════════════════════════

class XPProgressBar extends ConsumerWidget {
  final bool showLabel;
  const XPProgressBar({super.key, this.showLabel = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gamificationProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showLabel)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state.level,
                style: AppTypography.captionStrong.copyWith(
                  color: AppColors.primary,
                ),
              ),
              Text(
                '${state.levelXP} / ${state.xpToNextLevel} XP',
                style: AppTypography.caption,
              ),
            ],
          ),
        if (showLabel) Gap.xs,
        ClipRRect(
          borderRadius: AppRadius.full,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: state.levelProgress),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            builder: (_, value, __) => LinearProgressIndicator(
              value: value,
              backgroundColor: AppColors.accentSurface,
              color: AppColors.accent,
              minHeight: 8,
            ),
          ),
        ),
      ],
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
      child: Container(
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
                width: 280,
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  borderRadius: AppRadius.xl,
                  border: Border.all(
                    color: AppColors.accent,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    // Rozet ikonu (asset yokken emoji placeholder)
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.accentSurface,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.accent.withOpacity(0.3),
                          width: 3,
                        ),
                      ),
                      child: const Icon(
                        Icons.workspace_premium,
                        color: AppColors.accent,
                        size: 44,
                      ),
                    )
                        .animate(delay: 400.ms)
                        .scale(
                          begin: const Offset(0.5, 0.5),
                          duration: 700.ms,
                          curve: Curves.elasticOut,
                        ),

                    Gap.md,

                    // "Rozet kazandın!" başlığı — Kurmancî önce
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
                      'Rozet kazandın!',
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
                  ],
                ),
              )
                  .animate(delay: 200.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.15, end: 0),

              Gap.lg,

              Text(
                'Devam etmek için dokun',
                style: AppTypography.caption.copyWith(
                  color: Colors.white.withOpacity(0.7),
                ),
              )
                  .animate(delay: 1300.ms)
                  .fadeIn(duration: 400.ms),
            ],
          ),
        ),
      )
          .animate()
          .fadeIn(duration: 300.ms),
    );
  }
}

// Parıltı halkası
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
                end: const Offset(1.2 + i * 0.15, 1.2 + i * 0.15),
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
// HAFTALik ÖZEt KARTI
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
              // Kurmancî etiket
              Text('Hefte',
                  style: AppTypography.caption.primary),
              Text('Haftalık seri',
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
                  'Bu hafta',
                  style: AppTypography.captionStrong,
                ),
                Gap.xs,
                Text(
                  '${rhythm.activeDayCount} gün aktif · ${state.totalXP} XP',
                  style: AppTypography.body.primary,
                ),
                Gap.xs,
                Text(
                  rhythm.weekGoalMet
                      ? '✓ Haftalık hedef tamamlandı!'
                      : '${WeeklyRhythmState.weekGoalDays - rhythm.activeDayCount} gün daha',
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
// ROZET IZGARASI — Profil sayfası için
// ════════════════════════════════════════════════════════════════

class BadgeGrid extends ConsumerWidget {
  const BadgeGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gamificationProvider);
    final earned = Set<String>.from(state.earnedBadgeIds);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.85,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
      ),
      itemCount: kBadges.length,
      itemBuilder: (context, index) {
        final badge = kBadges[index];
        final isEarned = earned.contains(badge.id);

        return _BadgeTile(
          badge: badge,
          isEarned: isEarned,
          delay: Duration(milliseconds: index * 60),
        );
      },
    );
  }
}

class _BadgeTile extends StatelessWidget {
  final BadgeModel badge;
  final bool isEarned;
  final Duration delay;

  const _BadgeTile({
    required this.badge,
    required this.isEarned,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isEarned ? 1.0 : 0.35,
      duration: const Duration(milliseconds: 300),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: isEarned
              ? AppColors.accentSurface
              : AppColors.backgroundSecondary,
          borderRadius: AppRadius.lg,
          border: Border.all(
            color: isEarned
                ? AppColors.accent.withOpacity(0.3)
                : AppColors.borderLight,
            width: isEarned ? AppSpacing.borderMedium : AppSpacing.borderThin,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.workspace_premium,
              color: isEarned ? AppColors.accent : AppColors.textTertiary,
              size: 32,
            ),
            Gap.xs,
            // Kurmancî ad — birincil
            Text(
              badge.kurmanjName,
              style: AppTypography.captionStrong.copyWith(
                color: isEarned ? AppColors.primaryDark : AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // Türkçe — ikincil
            Text(
              badge.turkishName,
              style: AppTypography.caption.copyWith(
                color: AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    )
        .animate(delay: delay)
        .fadeIn(duration: 350.ms)
        .scale(begin: const Offset(0.92, 0.92));
  }
}
