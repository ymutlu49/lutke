import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/auth_service.dart';
import '../data/lesson_repository.dart';
import '../domain/lesson_entities.dart';
import '../domain/a1_kelime_db.dart';
import '../domain/a2_kelime_db.dart';
import '../domain/b1_kelime_db.dart';
import '../domain/b2_kelime_db.dart';
import '../domain/c1_kelime_db.dart';
import '../domain/c2_kelime_db.dart';
import '../../../shared/widgets/streak_widget.dart';
// daily_word_widget import removed — widget no longer on home screen
import '../../../shared/providers/language_mode_provider.dart';
import '../../../shared/providers/review_provider.dart';
import '../../gamification/gamification_widgets.dart';

// ════════════════════════════════════════════════════════════════
// ANA SAYFA — İLERLEME HARİTASI
// İlke: Kurmancî birincil dil. Heritage + Genel yol.
// Gamification: Destekleyici, kimlik odaklı (ceza yok).
// ════════════════════════════════════════════════════════════════

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final profile = ref.watch(userProfileProvider);
    final userId = user?.uid ?? 'anonymous';

    final dailyStats = ref.watch(dailyStatsProvider(userId));
    final currentLevelProgress =
        ref.watch(levelProgressProvider((userId: userId, level: profile.currentLevelNum)));

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      // Bottom nav artık shell'de — burada kaldırıldı
      body: Stack(
        children: [
          SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── İçerik ───────────────────────────────────────────
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: AppSpacing.md),

                  // ════════════════════════════════════════════════
                  // 1) COMPACT HEADER: mascot + Xêr hatî + KU/TR
                  // ════════════════════════════════════════════════
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Mascot 40px
                      GestureDetector(
                        onLongPress: () => context.push(AppRoutes.admin),
                        child: SizedBox(
                          width: 40, height: 40,
                          child: Image.asset('assets/images/mascot_64.png',
                            fit: BoxFit.contain, filterQuality: FilterQuality.medium),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Selamlama + alt yazı
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              profile.isHeritage ? 'Xêr hatî, heval!' : 'Xêr hatî!',
                              style: AppTypography.headingSmall.copyWith(
                                color: AppColors.textPrimary, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Îro çi fêr dibî?',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      // KU/TR dil toggle
                      _LanguageModeToggle(),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // ════════════════════════════════════════════════
                  // 2) COMPACT STREAK BAR: streak, XP, level
                  // ════════════════════════════════════════════════
                  dailyStats.when(
                    data: (stats) => _DailySummaryCard(stats: stats, level: profile.currentLevel.toUpperCase()),
                    loading: () => _DailySummaryCard(stats: null, level: profile.currentLevel.toUpperCase()),
                    error: (_, __) => _DailySummaryCard(stats: null, level: profile.currentLevel.toUpperCase()),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // ════════════════════════════════════════════════
                  // 3) LEARNING PATH — Main focus of the home screen
                  //    Visual mountain/path with nodes (always visible)
                  // ════════════════════════════════════════════════
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: Row(
                      children: [
                        Icon(Icons.route_rounded, size: 22, color: AppColors.primary),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          'Rêya Fêrbûnê',
                          style: AppTypography.headingSmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 160.ms),

                  _SkillTreePath(
                    userId: userId,
                    currentLevel: profile.currentLevelNum,
                    ref: ref,
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  // ── Günlük Ödül ─────────────────────────────
                  const DailyRewardWidget(),

                  const SizedBox(height: AppSpacing.xl),
                ]),
              ),
            ),
          ],
        ),
      ),

          // ── Gamification Overlay'ler ────────────────────────
          // Level-up kutlaması
          const LevelUpCelebrationOverlay(),

          // Rozet kazanımı
          const BadgeEarnedOverlay(),
        ],
      ),
    );
  }
}

// (_WelcomeSection kaldirildi — header icinde inline olarak yazildi)

// ════════════════════════════════════════════════════════════════
// STREAK ROZETI
// İlke §9b bulgu #3: Ceza değil, ritim kutlanır
// ════════════════════════════════════════════════════════════════

class _StreakBadge extends StatelessWidget {
  final int days;
  const _StreakBadge({required this.days});

  @override
  Widget build(BuildContext context) {
    if (days == 0) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accent.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          Text(
            '$days roj',
            style: AppTypography.caption.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// GÜNLÜK ÖZET KARTI — streak, XP, seviye
// ════════════════════════════════════════════════════════════════

class _DailySummaryCard extends StatelessWidget {
  final DailyStats? stats;
  final String level;
  const _DailySummaryCard({this.stats, required this.level});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPad = screenWidth < 360 ? 10.0 : AppSpacing.md;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPad, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Streak
            _SummaryItem(
              icon: Icons.local_fire_department_rounded,
              iconColor: AppColors.accent,
              value: stats != null ? '${stats!.streakDays} roj' : '0 roj',
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
              color: AppColors.border,
            ),
            // XP
            _SummaryItem(
              icon: Icons.star_rounded,
              iconColor: Colors.amber,
              value: stats != null ? '${stats!.xpToday} XP' : '0 XP',
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
              color: AppColors.border,
            ),
            // Level badge
            _SummaryItem(
              icon: Icons.emoji_events_rounded,
              iconColor: AppColors.primary,
              value: level.isNotEmpty ? level : 'A1',
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 120.ms, duration: 350.ms);
  }
}

class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  const _SummaryItem({
    required this.icon,
    required this.iconColor,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: 6),
          Text(
            value,
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// HAFTALIK RİTİM KARTI
// İlke §9b bulgu #3: Streak değil, haftalık ritim
// ════════════════════════════════════════════════════════════════

class _WeeklyRhythmCard extends StatelessWidget {
  final DailyStats? stats;
  const _WeeklyRhythmCard({this.stats});

  @override
  Widget build(BuildContext context) {
    final days = ['D', 'S', 'Ç', 'P', 'C', 'Ct', 'P'];
    final today = DateTime.now().weekday - 1; // 0=Pazartesi

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Roja te ya vê hefteyê',  // Bu haftaki günün
            style: AppTypography.labelMedium.copyWith(
                color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (i) {
              final isToday = i == today;
              final isDone = i < today;
              return _DayDot(
                label: days[i],
                isToday: isToday,
                isDone: isDone,
              );
            }),
          ),
          if (stats != null) ...[
            const SizedBox(height: AppSpacing.sm),
            const Divider(height: 1),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatChip(
                    label: 'Îro',
                    value: '${stats!.totalReviewed}',
                    icon: Icons.check_circle_outline),
                _StatChip(
                    label: 'Rast',
                    value: '${(stats!.accuracy * 100).round()}%',
                    icon: Icons.trending_up),
                _StatChip(
                    label: 'XP',
                    value: '+${stats!.xpToday}',
                    icon: Icons.star_border),
              ],
            ),
          ],
        ],
      ),
    ).animate().fadeIn(delay: 150.ms);
  }
}

class _DayDot extends StatelessWidget {
  final String label;
  final bool isToday;
  final bool isDone;
  const _DayDot({required this.label, required this.isToday, required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isToday
                ? AppColors.primary
                : isDone
                    ? AppColors.primary.withOpacity(0.15)
                    : AppColors.backgroundSecondary,
            border: isToday
                ? null
                : Border.all(
                    color: isDone
                        ? AppColors.primary.withOpacity(0.4)
                        : AppColors.border,
                    width: 1.5,
                  ),
          ),
          child: Center(
            child: isDone
                ? Icon(Icons.check,
                    size: 16,
                    color: isToday ? Colors.white : AppColors.primary)
                : Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                          isToday ? FontWeight.w700 : FontWeight.w500,
                      color: isToday ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        if (!isDone)
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isToday ? AppColors.primary : AppColors.textSecondary,
              fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _StatChip({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(height: 2),
        Text(value,
            style: AppTypography.labelLarge.copyWith(
                color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
        Text(label,
            style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary)),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// GÜNLÜK TEKRAR BUTONU — Birincil aksiyon
// İlke §3: FSRS-5 kuyruğu; §4: Gamification destekleyici
// ════════════════════════════════════════════════════════════════

class _DailyReviewButton extends StatelessWidget {
  final int dueCount;
  final String userId;
  const _DailyReviewButton({required this.dueCount, required this.userId});

  @override
  Widget build(BuildContext context) {
    final hasCards = dueCount > 0;

    return GestureDetector(
      onTap: hasCards
          ? () => context.push(
                AppRoutes.lesson,
                extra: {'mode': 'review', 'userId': userId},
              )
          : null,
      child: AnimatedContainer(
        duration: 300.ms,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          gradient: hasCards
              ? LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: hasCards ? null : AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: hasCards
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  )
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(hasCards ? 0.2 : 0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                hasCards ? Icons.play_arrow_rounded : Icons.check_circle_outline,
                color: hasCards ? Colors.white : AppColors.textSecondary,
                size: 28,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hasCards ? 'Tekrar bike — $dueCount peld' : 'Îro temam e! ✓',
                    style: AppTypography.labelLarge.copyWith(
                      color: hasCards ? Colors.white : AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    hasCards
                        ? 'FSRS-5 — pir bibîre, zûtir pêş bikeve'
                        : 'Hemû peld hatine xwendin',
                    style: AppTypography.caption.copyWith(
                      color: hasCards
                          ? Colors.white.withOpacity(0.85)
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (hasCards)
              Icon(Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.8), size: 16),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 200.ms).scale(
          begin: const Offset(0.97, 0.97),
          duration: 300.ms,
          curve: Curves.easeOut,
        );
  }
}

// ════════════════════════════════════════════════════════════════
// FLASHCARD HIZLI ERİŞİM BUTONU
// ════════════════════════════════════════════════════════════════

class _FlashcardQuickAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.flashcard),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.accent.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.accent, AppColors.accentWarm],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.style_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Peld',
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Peyvan bi swipe fêr bibe',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AppColors.accent.withOpacity(0.6),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 220.ms).slideX(begin: 0.05);
  }
}

// ════════════════════════════════════════════════════════════════
// AKTİVİTE KARTI — Fêrbûn sekmesi için büyük, renkli kart
// ════════════════════════════════════════════════════════════════

class _ActivityCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final List<Color> gradientColors;
  final VoidCallback? onTap;
  final int delay;

  const _ActivityCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.gradientColors,
    required this.onTap,
    this.delay = 150,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.lg,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradientColors.first.withOpacity(0.35),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              label,
              style: AppTypography.labelLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: AppTypography.caption.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay)).scale(
          begin: const Offset(0.95, 0.95),
          duration: 300.ms,
          curve: Curves.easeOut,
        );
  }
}

// ════════════════════════════════════════════════════════════════
// AKTİVİTE GRID — 2 sütunlu, 8 çalakiye kartı
// Tam öğrenme aktivite ızgarası
// ════════════════════════════════════════════════════════════════

class _ActivityGrid extends ConsumerWidget {
  final String userId;
  final AsyncValue<DailyStats> dailyStats;

  const _ActivityGrid({required this.userId, required this.dailyStats});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // ── Row 1: Waneyê Bide (Quiz) + Peld (Flashcard) ──
        Row(
          children: [
            Expanded(
              child: _ActivityGridCard(
                emoji: '\u{1F3AF}',
                label: 'Waneyê Bide',
                subtitle: '10 pirs',
                gradientColors: [AppColors.primary, AppColors.primaryDark],
                onTap: () => context.push(
                  AppRoutes.quiz,
                  extra: {'level': 'A1'},
                ),
                delay: 320,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _ActivityGridCard(
                emoji: '\u{1F0CF}',
                label: 'Peld',
                subtitle: '454 peyv',
                gradientColors: [AppColors.accent, AppColors.accentWarm],
                onTap: () => context.push(AppRoutes.flashcard),
                delay: 360,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.sm),

        // ── Row 2: Rêziman (Grammar) + Dubare (Smart Review) ──
        Row(
          children: [
            Expanded(
              child: _ActivityGridCard(
                emoji: '\u{1F4DD}',
                label: 'Rêziman',
                subtitle: 'Gramer bike',
                gradientColors: [const Color(0xFF3F51B5), const Color(0xFF283593)],
                onTap: () => context.push(AppRoutes.grammar),
                delay: 400,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _ActivityGridCard(
                emoji: '\u{1F504}',
                label: 'Dubare',
                subtitle: '${ref.watch(reviewDueCountProvider)} peyv',
                gradientColors: [const Color(0xFF43A047), const Color(0xFF2E7D32)],
                onTap: () => context.push(AppRoutes.review),
                delay: 440,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// AKTİVİTE GRID KARTI — Emoji ikonu + gradient arka plan
// Rounded rectangle, staggered entrance animation, ripple
// ════════════════════════════════════════════════════════════════

class _ActivityGridCard extends StatelessWidget {
  final String emoji;
  final String label;
  final String subtitle;
  final List<Color> gradientColors;
  final VoidCallback? onTap;
  final int delay;

  const _ActivityGridCard({
    required this.emoji,
    required this.label,
    required this.subtitle,
    required this.gradientColors,
    required this.onTap,
    this.delay = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.white.withOpacity(0.15),
        highlightColor: Colors.white.withOpacity(0.08),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: gradientColors.first.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.lg,
            ),
            child: Column(
              children: [
                // Emoji icon
                Text(
                  emoji,
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(height: AppSpacing.sm),
                // Title
                Text(
                  label,
                  style: AppTypography.labelLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                // Subtitle
                Text(
                  subtitle,
                  style: AppTypography.caption.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay)).scale(
          begin: const Offset(0.92, 0.92),
          duration: 350.ms,
          curve: Curves.easeOut,
        );
  }
}

// ════════════════════════════════════════════════════════════════
// COLLAPSIBLE SKILL TREE — Açılır/kapanır öğrenme yolu
// ════════════════════════════════════════════════════════════════

class _CollapsibleSkillTree extends StatefulWidget {
  final String userId;
  final int currentLevel;
  final WidgetRef ref;

  const _CollapsibleSkillTree({
    required this.userId,
    required this.currentLevel,
    required this.ref,
  });

  @override
  State<_CollapsibleSkillTree> createState() => _CollapsibleSkillTreeState();
}

class _CollapsibleSkillTreeState extends State<_CollapsibleSkillTree> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Toggle header
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.route_rounded, size: 22, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Rêya Fêrbûnê',
                    style: AppTypography.headingSmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textSecondary,
                    size: 26,
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(delay: 300.ms),

        // Collapsible content
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.md),
            child: _SkillTreePath(
              userId: widget.userId,
              currentLevel: widget.currentLevel,
              ref: widget.ref,
            ),
          ),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
          sizeCurve: Curves.easeInOut,
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// SEVİYE İLERLEME KARTI
// ════════════════════════════════════════════════════════════════

class _LevelProgressCard extends StatelessWidget {
  final LevelProgress? progress;
  const _LevelProgressCard({this.progress});

  @override
  Widget build(BuildContext context) {
    if (progress == null) {
      return Container(
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
      );
    }

    final pct = progress!.completionPercent;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Asta ${progress!.levelName}',
                style: AppTypography.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                '${progress!.learnedCards}/${progress!.totalCards} peyv',
                style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: pct,
              backgroundColor: AppColors.primary.withOpacity(0.12),
              valueColor: AlwaysStoppedAnimation(AppColors.primary),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(pct * 100).round()}% temam',
                style: AppTypography.caption.copyWith(
                    color: AppColors.primary, fontWeight: FontWeight.w600),
              ),
              if (progress!.masteredCards > 0)
                Text(
                  '${progress!.masteredCards} dît ✓',
                  style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary),
                ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 250.ms);
  }
}

// ════════════════════════════════════════════════════════════════
// SKILL TREE UNIT MODELİ
// A1 kelime DB'sinden kategorilere göre birim oluşturur
// ════════════════════════════════════════════════════════════════

class _SkillTreeUnit {
  final String id;
  final String katKey;
  final String kuTitle;
  final String trTitle;
  final IconData icon;
  final int wordCount;
  final int unitIndex;

  const _SkillTreeUnit({
    required this.id,
    required this.katKey,
    required this.kuTitle,
    required this.trTitle,
    required this.icon,
    required this.wordCount,
    required this.unitIndex,
  });
}

/// Seviyeye göre kelime DB'sini döndürür.
List<dynamic> _getWordsForLevel(String level) => switch (level) {
  'A1' => kA1TamKelimeler,
  'A2' => kA2Kelimeler,
  'B1' => kB1Kelimeler,
  'B2' => kB2Kelimeler,
  'C1' => kC1Kelimeler,
  'C2' => kC2Kelimeler,
  _ => kA1TamKelimeler,
};

/// Kategori ikonları — tüm seviyeler için ortak.
IconData _iconForCategory(String kat) => switch (kat) {
  'alfabe' => Icons.text_fields_rounded,
  'selamlama' || 'silav' => Icons.waving_hand_rounded,
  'jimar' || 'hejmar' => Icons.tag_rounded,
  'reng' => Icons.palette_rounded,
  'malbat' => Icons.family_restroom_rounded,
  'cinavk' || 'navdêr' => Icons.person_rounded,
  'pîşe' || 'kar' => Icons.work_rounded,
  'perwerde' => Icons.school_rounded,
  'dem' => Icons.access_time_rounded,
  'roj' || 'demsal' || 'werzî' || 'hewa' => Icons.wb_sunny_rounded,
  'xwarin' || 'vexwarin' || 'mêwe' => Icons.restaurant_rounded,
  'beden' || 'tendurist' => Icons.accessibility_new_rounded,
  'mal' || 'cih' || 'bajêr' => Icons.home_rounded,
  'rengder' || 'soyut' => Icons.format_color_text_rounded,
  'temel' || 'jiyan' => Icons.auto_stories_rounded,
  'leker' || 'leker_ergatif' || 'ergatif' || 'neyekî' => Icons.directions_run_rounded,
  'xweza' || 'ekoloji' => Icons.park_rounded,
  'ajal' => Icons.pets_rounded,
  'cil' => Icons.dry_cleaning_rounded,
  'daçek' || 'rêziman' => Icons.compare_arrows_rounded,
  'pirs' => Icons.help_outline_rounded,
  'gihanî' || 'rêwîtî' => Icons.directions_bus_rounded,
  'peyvben' || 'his' || 'psikoloji' => Icons.sentiment_satisfied_rounded,
  'bun' => Icons.lightbulb_rounded,
  'çand' || 'edebiyat' || 'huner' => Icons.museum_rounded,
  'dua' => Icons.volunteer_activism_rounded,
  'civakî' || 'kimlik' => Icons.groups_rounded,
  'siyaset' || 'zagon' => Icons.gavel_rounded,
  'aborî' || 'bazirganî' || 'cotkarî' => Icons.account_balance_rounded,
  'teknoloji' || 'zanist' => Icons.science_rounded,
  'ziman' => Icons.translate_rounded,
  'medya' => Icons.newspaper_rounded,
  'felsefe' => Icons.psychology_rounded,
  'dîrok' => Icons.history_edu_rounded,
  'akademik' => Icons.school_rounded,
  'deyim' => Icons.format_quote_rounded,
  'welat' => Icons.flag_rounded,
  _ => Icons.circle_rounded,
};

/// Kategori anahtarından doğru Kurmancî adını döndürür.
String _kuNameForCategory(String kat) => switch (kat) {
  'alfabe' => 'Alfabê',
  'selamlama' || 'silav' => 'Silav',
  'jimar' || 'hejmar' => 'Hejmar',
  'reng' => 'Reng',
  'malbat' => 'Malbat',
  'cinavk' => 'Cînav',
  'pîşe' => 'Pîşe',
  'perwerde' => 'Perwerde',
  'dem' => 'Dem',
  'roj' => 'Rojên hefteyê',
  'demsal' || 'werzî' => 'Demsalên salê',
  'xwarin' => 'Xwarin',
  'vexwarin' => 'Vexwarin',
  'mêwe' => 'Fêkî û mêwe',
  'beden' => 'Laş',
  'tendurist' => 'Tenduristî',
  'mal' => 'Mal û xanî',
  'cih' || 'bajêr' => 'Cih û der',
  'rengder' || 'soyut' => 'Rengdêr',
  'temel' => 'Peyvên bingehîn',
  'leker' => 'Lêker',
  'leker_ergatif' || 'ergatif' || 'ergatif_b2' => 'Lêkerên ergatîf',
  'xweza' => 'Xweza',
  'ajal' => 'Heywan',
  'cil' => 'Cil û berg',
  'daçek' => 'Daçek',
  'rêziman' => 'Rêziman',
  'pirs' => 'Pirsyar',
  'gihanî' || 'rêwîtî' => 'Veguhestin',
  'peyvben' => 'Peyvên girêdayî',
  'his' || 'psikoloji' => 'Hest',
  'bun' => 'Bûn',
  'çand' => 'Çand',
  'edebiyat' => 'Wêje',
  'huner' => 'Huner',
  'dua' => 'Dua û hêvî',
  'civakî' || 'kimlik' => 'Civak',
  'siyaset' => 'Siyaset',
  'zagon' => 'Zagonî',
  'aborî' || 'bazirganî' || 'cotkarî' => 'Aborî',
  'teknoloji' => 'Teknolojî',
  'zanist' => 'Zanist',
  'ziman' => 'Ziman',
  'medya' => 'Medya',
  'felsefe' => 'Felsefe',
  'dîrok' => 'Dîrok',
  'akademik' => 'Akademîk',
  'deyim' => 'Gotinên pêşiyan',
  'welat' => 'Welat',
  'jiyan' => 'Jiyan',
  'kar' => 'Kar û pîşe',
  'hewa' => 'Hewa',
  'ekoloji' => 'Ekolojî',
  'neyekî' => 'Neyînî',
  'navdêr' => 'Navdêr',
  _ => kat[0].toUpperCase() + kat.substring(1),
};

/// Belirli seviye için durak listesi oluşturur.
/// Minimum 12 kelime olan kategoriler gösterilir.
/// Pedagojik sıralamaya göre sıralanır.
List<_SkillTreeUnit> _buildSkillUnits(String level) {
  final words = _getWordsForLevel(level);
  final catCounts = <String, int>{};
  for (final k in words) {
    final kat = k.kat as String? ?? '';
    if (kat.isEmpty) continue;
    catCounts[kat] = (catCounts[kat] ?? 0) + 1;
  }

  // Pedagojik sıra — basit/somut → karmaşık/soyut
  const _pedagogicOrder = [
    // A1 temel
    'alfabe', 'selamlama', 'silav', 'cinavk', 'hejmar', 'jimar',
    'malbat', 'bun', 'reng', 'dem', 'roj', 'demsal', 'werzî',
    'mal', 'xwarin', 'vexwarin', 'mêwe', 'beden', 'cil',
    'pîşe', 'ajal', 'xweza', 'cih', 'gihanî', 'rêwîtî',
    'tendurist', 'his', 'peyvben', 'pirs', 'temel',
    'leker', 'rengder', 'daçek', 'dua', 'çand',
    // A2-B1 genişleme
    'jiyan', 'civakî', 'perwerde', 'kar', 'teknoloji',
    'hewa', 'bazirganî', 'welat', 'navdêr', 'neyekî',
    'ergatif', 'leker_ergatif', 'deyim', 'rêziman',
    // B2-C2 ileri
    'edebiyat', 'huner', 'siyaset', 'zagon', 'aborî',
    'medya', 'zanist', 'felsefe', 'dîrok', 'akademik',
    'kimlik', 'ekoloji', 'ziman', 'soyut', 'psikoloji',
    'ergatif_b2', 'cotkarî', 'bajêr',
  ];

  final units = <_SkillTreeUnit>[];

  // Önce pedagojik sıradaki kategorileri ekle
  for (final kat in _pedagogicOrder) {
    final count = catCounts[kat];
    if (count == null || count < 4) continue;
    units.add(_SkillTreeUnit(
      id: '${level.toLowerCase()}_unit_$kat',
      katKey: kat,
      kuTitle: _kuNameForCategory(kat),
      trTitle: '',
      icon: _iconForCategory(kat),
      wordCount: count,
      unitIndex: units.length,
    ));
  }

  // Sırada olmayan ama yeterli kelimesi olan kategorileri sona ekle
  for (final entry in catCounts.entries) {
    final kat = entry.key;
    final count = entry.value;
    if (count < 4) continue;
    if (_pedagogicOrder.contains(kat)) continue; // Zaten eklendi
    units.add(_SkillTreeUnit(
      id: '${level.toLowerCase()}_unit_$kat',
      katKey: kat,
      kuTitle: _kuNameForCategory(kat),
      trTitle: '',
      icon: _iconForCategory(kat),
      wordCount: count,
      unitIndex: units.length,
    ));
  }

  return units;
}

// ════════════════════════════════════════════════════════════════
// SKILL TREE PATH — Duolingo benzeri kıvrımlı yol
// İlke §7.1: Heritage / Genel yol; §2: İlişki senaryoları
// ════════════════════════════════════════════════════════════════

class _SkillTreePath extends StatelessWidget {
  final String userId;
  final int currentLevel;
  final WidgetRef ref;

  const _SkillTreePath({
    required this.userId,
    required this.currentLevel,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    // Seviyeye göre durakları oluştur
    final levelKey = switch (currentLevel) {
      1 => 'A1', 2 => 'A2', 3 => 'B1', 4 => 'B2', 5 => 'C1', 6 => 'C2',
      _ => 'A1',
    };
    final units = _buildSkillUnits(levelKey);
    const completedCount = 0;
    const currentIndex = 0;
    final unlockedCount = units.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Skill tree nodeları
        ...units.asMap().entries.map((entry) {
          final i = entry.key;
          final unit = entry.value;

          final isCompleted = i < completedCount;
          final isCurrent = i == currentIndex;
          final isUnlocked = i < unlockedCount; // İlk 3 node açık
          final isLocked = !isCompleted && !isCurrent && !isUnlocked;

          return _SkillTreeNode(
            unit: unit,
            index: i,
            totalCount: units.length,
            isCompleted: isCompleted,
            isCurrent: isCurrent,
            isLocked: isLocked,
            showTurkish: ref.watch(showTurkishProvider),
            onTap: () => context.push(
              AppRoutes.unitHub,
              extra: {
                'category': unit.katKey,
                'titleKu': unit.kuTitle,
                'titleTr': unit.trTitle,
                'icon': unit.icon,
                'wordCount': unit.wordCount,
                'level': levelKey,
              },
            ),
          );
        }),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// SKILL TREE NODE — Tek bir birim dugumu
// ════════════════════════════════════════════════════════════════

class _SkillTreeNode extends StatelessWidget {
  final _SkillTreeUnit unit;
  final int index;
  final int totalCount;
  final bool isCompleted;
  final bool isCurrent;
  final bool isLocked;
  final bool showTurkish;
  final VoidCallback? onTap;

  const _SkillTreeNode({
    required this.unit,
    required this.index,
    required this.totalCount,
    required this.isCompleted,
    required this.isCurrent,
    required this.isLocked,
    required this.showTurkish,
    this.onTap,
  });

  // Zigzag pattern: saga ve sola sirayla kaydir
  Alignment _nodeAlignment() {
    // Her 2 satirda bir yon degistir (Duolingo pattern)
    final cycle = index % 4;
    switch (cycle) {
      case 0: return Alignment.center;
      case 1: return const Alignment(0.55, 0);
      case 2: return Alignment.center;
      case 3: return const Alignment(-0.55, 0);
      default: return Alignment.center;
    }
  }

  @override
  Widget build(BuildContext context) {
    final alignment = _nodeAlignment();
    final isLast = index == totalCount - 1;

    // Node boyutlari — larger for mountain-path feel
    final nodeSize = isCurrent ? 88.0 : 74.0;

    // Renkler
    final nodeColor = isCompleted
        ? AppColors.success
        : isCurrent
            ? AppColors.primary
            : AppColors.backgroundTertiary;

    final borderColor = isCompleted
        ? AppColors.success
        : isCurrent
            ? AppColors.primaryDark
            : AppColors.border;

    final iconColor = isCompleted || isCurrent
        ? Colors.white
        : AppColors.textTertiary;

    final textColor = isLocked
        ? AppColors.textTertiary
        : AppColors.textPrimary;

    return Column(
      children: [
        // Baglanti cizgisi (ilk node haric)
        if (index > 0)
          _PathConnector(
            fromAlignment: _prevAlignment(),
            toAlignment: alignment,
            isCompleted: isCompleted || isCurrent,
          ),

        // Node
        Align(
          alignment: alignment,
          child: GestureDetector(
            onTap: onTap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ana daire
                _buildNodeCircle(nodeSize, nodeColor, borderColor, iconColor),

                const SizedBox(height: 6),

                // Baslik
                Text(
                  unit.kuTitle,
                  style: AppTypography.labelMedium.copyWith(
                    color: textColor,
                    fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),

                // Alt baslik + kelime sayisi
                Text(
                  showTurkish
                      ? '${unit.trTitle} · ${unit.wordCount} peyv'
                      : '${unit.wordCount} peyv',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),

                // Aktif node: "Dest pê bike!" etiketi
                if (isCurrent) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Dest pê bike!',
                      style: AppTypography.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ).animate().fadeIn(delay: (200 + index * 60).ms, duration: 350.ms)
              .slideY(begin: 0.15, duration: 350.ms, curve: Curves.easeOut),
        ),

        // Son node'dan sonra bosluk
        if (isLast) const SizedBox(height: AppSpacing.md),
      ],
    );
  }

  Widget _buildNodeCircle(
      double size, Color color, Color border, Color iconColor) {
    final circle = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: border, width: isCurrent ? 3.5 : 2.5),
        boxShadow: [
          if (isCurrent)
            BoxShadow(
              color: AppColors.primary.withOpacity(0.35),
              blurRadius: 18,
              spreadRadius: 2,
            ),
          if (isCompleted)
            BoxShadow(
              color: AppColors.success.withOpacity(0.25),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          if (!isLocked)
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Center(
        child: isCompleted
            ? Icon(Icons.check_rounded, color: iconColor, size: size * 0.4)
            : isLocked
                ? Icon(Icons.lock_rounded, color: iconColor, size: size * 0.35)
                : isCurrent
                    ? Image.asset('assets/images/mascot_64.png',
                        width: size * 0.55, height: size * 0.55,
                        filterQuality: FilterQuality.medium)
                    : Icon(unit.icon, color: iconColor, size: size * 0.4),
      ),
    );

    // Aktif node: pulsing animasyonu
    if (isCurrent) {
      return circle
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scale(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.08, 1.08),
            duration: 1200.ms,
            curve: Curves.easeInOut,
          );
    }

    return circle;
  }

  Alignment _prevAlignment() {
    if (index == 0) return Alignment.center;
    final prevCycle = (index - 1) % 4;
    switch (prevCycle) {
      case 0: return Alignment.center;
      case 1: return const Alignment(0.55, 0);
      case 2: return Alignment.center;
      case 3: return const Alignment(-0.55, 0);
      default: return Alignment.center;
    }
  }
}

// ════════════════════════════════════════════════════════════════
// PATH CONNECTOR — Nodelar arasi baglanti cizgisi
// ════════════════════════════════════════════════════════════════

class _PathConnector extends StatelessWidget {
  final Alignment fromAlignment;
  final Alignment toAlignment;
  final bool isCompleted;

  const _PathConnector({
    required this.fromAlignment,
    required this.toAlignment,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: CustomPaint(
        size: const Size(double.infinity, 42),
        painter: _PathPainter(
          fromX: (fromAlignment.x + 1) / 2,
          toX: (toAlignment.x + 1) / 2,
          isCompleted: isCompleted,
        ),
      ),
    );
  }
}

class _PathPainter extends CustomPainter {
  final double fromX;
  final double toX;
  final bool isCompleted;

  _PathPainter({
    required this.fromX,
    required this.toX,
    required this.isCompleted,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isCompleted
          ? AppColors.primary.withOpacity(0.5)
          : AppColors.border
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Dashed line icin path
    final startX = size.width * fromX;
    final endX = size.width * toX;

    final path = Path();
    path.moveTo(startX, 0);

    // Eger ayni x hizasindalarsa duz cizgi, degilse egri
    if ((startX - endX).abs() < 10) {
      path.lineTo(endX, size.height);
    } else {
      // Cubic bezier ile kivrilan yol
      path.cubicTo(
        startX, size.height * 0.4,
        endX, size.height * 0.6,
        endX, size.height,
      );
    }

    // Dotted pattern
    final dashPath = Path();
    const dashLen = 6.0;
    const gapLen = 4.0;
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = math.min(distance + dashLen, metric.length);
        final extracted = metric.extractPath(distance, end);
        dashPath.addPath(extracted, Offset.zero);
        distance += dashLen + gapLen;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant _PathPainter old) =>
      old.fromX != fromX || old.toX != toX || old.isCompleted != isCompleted;
}

// ════════════════════════════════════════════════════════════════
// ALT NAVİGASYON ÇUBUĞU
// 4 sekme: Fêrbûn, Dubare, Çand, Profîl
// ════════════════════════════════════════════════════════════════

class _LutkeBottomNav extends StatelessWidget {
  final int currentIndex;
  const _LutkeBottomNav({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            top: 8,
            bottom: bottomPadding > 0 ? 0 : 8,
          ),
          child: Row(
            children: [
              Expanded(
                child: _NavItem(
                  icon: Icons.menu_book_rounded,
                  label: 'Fêrbûn',
                  isSelected: currentIndex == 0,
                  onTap: () {
                    // Already on home
                  },
                ),
              ),
              Expanded(
                child: _NavItem(
                  icon: Icons.translate_rounded,
                  label: 'Peyv',
                  isSelected: currentIndex == 1,
                  onTap: () => context.push(AppRoutes.vocabulary),
                ),
              ),
              Expanded(
                child: _NavItem(
                  icon: Icons.music_note_rounded,
                  label: 'Çand',
                  isSelected: currentIndex == 2,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Beşa Çandê zû tê',
                          style: TextStyle(fontSize: 13),
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: _NavItem(
                  icon: Icons.person_rounded,
                  label: 'Profîl',
                  isSelected: currentIndex == 3,
                  onTap: () => context.push(AppRoutes.profile),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 48,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// QUIZ BUTONU — "Ders Bide!" (Start Lesson)
// Ana sayfada belirgin, Duolingo tarzı quiz oturumu başlatıcı
// ════════════════════════════════════════════════════════════════

class _StartQuizButton extends StatelessWidget {
  const _StartQuizButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.quiz, extra: {'level': 'A1'}),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.accent, AppColors.accentWarm],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.quiz_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Waneyê Bide!',
                    style: AppTypography.labelLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '10 pirs — werger, guhdarikirin, nivisan',
                    style: AppTypography.caption.copyWith(
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                color: Colors.white.withOpacity(0.8), size: 16),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 180.ms).scale(
          begin: const Offset(0.97, 0.97),
          duration: 300.ms,
          curve: Curves.easeOut,
        );
  }
}

// ════════════════════════════════════════════════════════════════
// DİL MODU TOGGLE — KU/TR veya KU only
// ════════════════════════════════════════════════════════════════

class _LanguageModeToggle extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(languageModeProvider);
    final isKuTr = mode == LanguageMode.kuTr;

    return GestureDetector(
      onTap: () {
        ref.read(languageModeProvider.notifier).toggle();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isKuTr ? 'Tenê Kurmancî' : 'Kurmancî + Tirkî',
              style: const TextStyle(fontSize: 13),
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isKuTr
              ? AppColors.primary.withOpacity(0.1)
              : const Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isKuTr
                ? AppColors.primary.withOpacity(0.3)
                : const Color(0xFFFF9800).withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('KU',
              style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w800,
                color: AppColors.primary)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text('/', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
            ),
            Text(isKuTr ? 'TR' : '—',
              style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w800,
                color: isKuTr ? const Color(0xFFFF9800) : AppColors.textSecondary.withOpacity(0.4),
                decoration: isKuTr ? null : TextDecoration.lineThrough)),
          ],
        ),
      ),
    );
  }
}
