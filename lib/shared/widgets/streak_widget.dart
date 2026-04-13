import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../providers/streak_provider.dart';

// ════════════════════════════════════════════════════════════════
// STREAK WIDGET — Duolingo-ilhamli streak ve gunluk hedef karti
//
// Bilesenler:
// 1. Streak Counter (ates + "X roj")
// 2. Daily Goal Ring (dairesel ilerleme)
// 3. XP Counter (yildiz + gunluk XP)
// 4. Weekly Calendar (7 noktali haftalik gorunum)
//
// Tasarim ilkeleri:
// - Mobil-oncelikli (480px genislik)
// - AppColors uyumlu (primary: teal, accent: turuncu)
// - flutter_animate animasyonlari
// - Streak kirilinca nazik uyari (ceza degil — ilke #3)
// ════════════════════════════════════════════════════════════════

class StreakWidget extends ConsumerWidget {
  const StreakWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streak = ref.watch(streakProvider);

    return Column(
      children: [
        // ── Ana Streak Karti ────────────────────────────────────
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              // Ust kisim: Streak + Ring + XP
              Row(
                children: [
                  // 1. Streak Counter
                  _StreakCounter(days: streak.streakDays),

                  const SizedBox(width: 12),

                  // 2. Daily Goal Ring
                  _DailyGoalRing(
                    progress: streak.dailyProgress,
                    reviewed: streak.todayWordsReviewed,
                    goal: streak.dailyGoal,
                  ),

                  const Spacer(),

                  // 3. XP Counter
                  _XPCounter(xp: streak.todayXP),
                ],
              ),

              const SizedBox(height: 12),

              // Cizgi ayirici
              Divider(
                height: 1,
                color: AppColors.border.withOpacity(0.6),
              ),

              const SizedBox(height: 10),

              // 4. Weekly Calendar
              _WeeklyCalendar(
                weeklyActivity: streak.weeklyActivity,
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 400.ms)
            .slideY(begin: -0.05, duration: 350.ms, curve: Curves.easeOut),

        // ── Streak Broken Uyarisi ───────────────────────────────
        if (streak.streakBroken)
          _StreakBrokenBanner(
            onDismiss: () {
              ref.read(streakProvider.notifier).dismissBrokenWarning();
            },
          ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// 1. STREAK COUNTER — Ates emoji + "X roj"
// Streak buyudukce ates buyur
// ════════════════════════════════════════════════════════════════

class _StreakCounter extends StatelessWidget {
  final int days;
  const _StreakCounter({required this.days});

  double get _fireSize {
    if (days >= 30) return 28;
    if (days >= 14) return 24;
    if (days >= 7) return 22;
    return 18;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Ates — streak buyudukce buyur ve animasyonlu olur
        Text(
          '\u{1F525}', // fire emoji
          style: TextStyle(fontSize: _fireSize),
        )
            .animate(
              onPlay: (c) => c.repeat(reverse: true),
            )
            .scaleXY(
              begin: 1.0,
              end: days >= 7 ? 1.15 : 1.05,
              duration: 1200.ms,
              curve: Curves.easeInOut,
            ),

        const SizedBox(width: 6),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$days',
              style: AppTypography.streakCounter.copyWith(
                fontSize: days >= 100 ? 22 : 24,
                color: AppColors.accent,
              ),
            ),
            Text(
              'roj',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// 2. DAILY GOAL RING — Dairesel ilerleme gostergesi
// ════════════════════════════════════════════════════════════════

class _DailyGoalRing extends StatelessWidget {
  final double progress;
  final int reviewed;
  final int goal;

  const _DailyGoalRing({
    required this.progress,
    required this.reviewed,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    final isComplete = progress >= 1.0;

    return SizedBox(
      width: 52,
      height: 52,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Arka plan halka
          SizedBox(
            width: 52,
            height: 52,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 4,
              color: AppColors.primary.withOpacity(0.12),
            ),
          ),

          // Animasyonlu ilerleme halkasi
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: progress),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) {
              return SizedBox(
                width: 52,
                height: 52,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 4,
                  strokeCap: StrokeCap.round,
                  color: isComplete ? AppColors.success : AppColors.primary,
                ),
              );
            },
          ),

          // Merkez metin
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isComplete)
                Icon(Icons.check, size: 18, color: AppColors.success)
              else
                Text(
                  '$reviewed',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              Text(
                '/$goal',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    )
        .animate()
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.0, 1.0),
          duration: 500.ms,
          curve: Curves.elasticOut,
        );
  }
}

// ════════════════════════════════════════════════════════════════
// 3. XP COUNTER — Yildiz + gunluk XP
// ════════════════════════════════════════════════════════════════

class _XPCounter extends StatelessWidget {
  final int xp;
  const _XPCounter({required this.xp});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.accentSurface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        border: Border.all(
          color: AppColors.accent.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            size: 18,
            color: Colors.amber.shade700,
          ),
          const SizedBox(width: 4),
          Text(
            '+$xp',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 2),
          Text(
            'XP',
            style: AppTypography.caption.copyWith(
              color: AppColors.accent.withOpacity(0.7),
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// 4. WEEKLY CALENDAR — 7 noktali haftalik gorunum
// Yesil = tamamlandi, turuncu = bugun, gri = gelecek
// ════════════════════════════════════════════════════════════════

class _WeeklyCalendar extends StatelessWidget {
  final List<bool> weeklyActivity;

  const _WeeklyCalendar({required this.weeklyActivity});

  @override
  Widget build(BuildContext context) {
    // Kurmanci gun kisaltmalari: Duse, Sese, Carse, Pencs, Ini, Seni, Yeksen
    const dayLabels = ['D', 'S', 'C', 'P', 'I', 'S', 'Y'];
    final todayIdx = (DateTime.now().weekday - 1).clamp(0, 6);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (i) {
        final isActive = weeklyActivity.length > i && weeklyActivity[i];
        final isToday = i == todayIdx;
        final isFuture = i > todayIdx;

        return _WeekDot(
          label: dayLabels[i],
          isActive: isActive,
          isToday: isToday,
          isFuture: isFuture,
          index: i,
        );
      }),
    );
  }
}

class _WeekDot extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isToday;
  final bool isFuture;
  final int index;

  const _WeekDot({
    required this.label,
    required this.isActive,
    required this.isToday,
    required this.isFuture,
    required this.index,
  });

  Color get _dotColor {
    if (isActive) return AppColors.success;
    if (isToday) return AppColors.accent;
    return AppColors.weekDayEmpty;
  }

  Color get _labelColor {
    if (isActive) return AppColors.success;
    if (isToday) return AppColors.accent;
    return AppColors.textTertiary;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Nokta / ikon
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? _dotColor.withOpacity(0.15)
                : isToday
                    ? _dotColor.withOpacity(0.1)
                    : Colors.transparent,
            border: Border.all(
              color: isFuture
                  ? AppColors.weekDayEmpty
                  : _dotColor,
              width: isToday ? 2.0 : 1.5,
            ),
          ),
          child: Center(
            child: isActive
                ? Icon(Icons.check, size: 14, color: AppColors.success)
                : Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isFuture
                          ? AppColors.weekDayEmpty
                          : _dotColor.withOpacity(0.5),
                    ),
                  ),
          ),
        )
            .animate()
            .fadeIn(delay: (80 * index).ms, duration: 300.ms)
            .scaleXY(begin: 0.6, duration: 300.ms, curve: Curves.easeOut),

        const SizedBox(height: 4),

        // Gun etiketi
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
            color: _labelColor,
          ),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// STREAK BROKEN BANNER — Nazik uyari
// Ilke: Ceza degil, tesvik. "Her roj destpekek nuh ye."
// ════════════════════════════════════════════════════════════════

class _StreakBrokenBanner extends StatelessWidget {
  final VoidCallback onDismiss;
  const _StreakBrokenBanner({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.warningSurface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: AppColors.warning.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Text(
              '\u{1F331}', // seedling emoji
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Destpekek nuh!',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Her roj firsendek nuh e. Ka em dest pe bikin!',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onDismiss,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: 200.ms, duration: 400.ms)
        .slideY(begin: 0.1, duration: 300.ms);
  }
}

// ════════════════════════════════════════════════════════════════
// COMPACT STREAK CARD — Ana sayfa icin yatay kompakt versiyon
// App bar ile ders icerigi arasina yerlestirmek icin
// ════════════════════════════════════════════════════════════════

class CompactStreakCard extends ConsumerWidget {
  const CompactStreakCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streak = ref.watch(streakProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.surface,
            AppColors.primarySurface.withOpacity(0.5),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: AppColors.borderLight.withOpacity(0.5),
        ),
      ),
      child: Row(
        children: [
          // Streak ates + gun
          _CompactStreakFire(days: streak.streakDays),

          const SizedBox(width: 12),

          // Kucuk daily ring
          _CompactGoalRing(progress: streak.dailyProgress),

          const SizedBox(width: 8),

          // Gunluk hedef metni
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${streak.todayWordsReviewed}/${streak.dailyGoal} peyv',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                Text(
                  streak.dailyGoalMet
                      ? 'Armanc hat bidestxistin!'
                      : 'Armanca roje',
                  style: AppTypography.caption.copyWith(
                    color: streak.dailyGoalMet
                        ? AppColors.success
                        : AppColors.textTertiary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

          // XP chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.accentSurface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star_rounded,
                  size: 14,
                  color: Colors.amber.shade700,
                ),
                const SizedBox(width: 3),
                Text(
                  '${streak.todayXP}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 350.ms)
        .slideY(begin: -0.08, duration: 300.ms, curve: Curves.easeOut);
  }
}

class _CompactStreakFire extends StatelessWidget {
  final int days;
  const _CompactStreakFire({required this.days});

  @override
  Widget build(BuildContext context) {
    final fireSize = days >= 30 ? 22.0 : (days >= 7 ? 20.0 : 17.0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '\u{1F525}',
          style: TextStyle(fontSize: fireSize),
        )
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .scaleXY(
              begin: 1.0,
              end: days >= 7 ? 1.12 : 1.0,
              duration: 1400.ms,
              curve: Curves.easeInOut,
            ),
        const SizedBox(width: 4),
        Text(
          '$days',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.accent,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class _CompactGoalRing extends StatelessWidget {
  final double progress;
  const _CompactGoalRing({required this.progress});

  @override
  Widget build(BuildContext context) {
    final isComplete = progress >= 1.0;

    return SizedBox(
      width: 32,
      height: 32,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: progress),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return CustomPaint(
            painter: _RingPainter(
              progress: value,
              bgColor: AppColors.primary.withOpacity(0.12),
              fgColor: isComplete ? AppColors.success : AppColors.primary,
              strokeWidth: 3,
            ),
            child: child,
          );
        },
        child: Center(
          child: isComplete
              ? Icon(Icons.check, size: 14, color: AppColors.success)
              : Text(
                  '${(progress * 100).round()}%',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// CUSTOM RING PAINTER
// ════════════════════════════════════════════════════════════════

class _RingPainter extends CustomPainter {
  final double progress;
  final Color bgColor;
  final Color fgColor;
  final double strokeWidth;

  _RingPainter({
    required this.progress,
    required this.bgColor,
    required this.fgColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Arka plan halka
    final bgPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Ilerleme yay
    if (progress > 0) {
      final fgPaint = Paint()
        ..color = fgColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        fgPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.fgColor != fgColor;
}
