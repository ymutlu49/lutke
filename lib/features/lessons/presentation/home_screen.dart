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
import '../../../shared/widgets/lutke_logo.dart';

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
      bottomNavigationBar: _LutkeBottomNav(currentIndex: 0),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Üst Bar ──────────────────────────────────────────
            SliverAppBar(
              floating: true,
              backgroundColor: AppColors.backgroundPrimary,
              elevation: 0,
              toolbarHeight: 56,
              titleSpacing: AppSpacing.md,
              title: LutkeLogo.brandHorizontal(iconSize: 32),
            ),

            // ── İçerik ───────────────────────────────────────────
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: AppSpacing.sm),

                  // Heritage veya Genel yola göre selamlama
                  _WelcomeSection(isHeritage: profile.isHeritage),

                  const SizedBox(height: AppSpacing.sm),

                  // ── Günlük özet kartı ─────────────────────────
                  dailyStats.when(
                    data: (stats) => _DailySummaryCard(stats: stats, level: profile.currentLevel.toUpperCase()),
                    loading: () => _DailySummaryCard(stats: null, level: profile.currentLevel.toUpperCase()),
                    error: (_, __) => _DailySummaryCard(stats: null, level: profile.currentLevel.toUpperCase()),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Haftalık ritim (streak değil — ilke §Bölüm 9b bulgu #3)
                  dailyStats.when(
                    data: (stats) => _WeeklyRhythmCard(stats: stats),
                    loading: () => const _WeeklyRhythmCard(stats: null),
                    error: (_, __) => const _WeeklyRhythmCard(stats: null),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Günlük tekrar butonu — birincil aksiyon
                  dailyStats.when(
                    data: (stats) => _DailyReviewButton(
                      dueCount: stats.dueCount,
                      userId: userId,
                    ),
                    loading: () => const _DailyReviewButton(dueCount: 0, userId: ''),
                    error: (_, __) => const _DailyReviewButton(dueCount: 0, userId: ''),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Seviye ilerleme kartı
                  currentLevelProgress.when(
                    data: (progress) => _LevelProgressCard(progress: progress),
                    loading: () => const _LevelProgressCard(progress: null),
                    error: (_, __) => const _LevelProgressCard(progress: null),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Birim haritası
                  _UnitMapSection(
                    userId: userId,
                    currentLevel: profile.currentLevelNum,
                    ref: ref,
                  ),

                  const SizedBox(height: AppSpacing.xl),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// SELAMLAMA — Heritage / Genel yol ayrımı
// İlke 0.5: Kurmancî birinci dil; 1.1: Heritage özel pedagoji
// ════════════════════════════════════════════════════════════════

class _WelcomeSection extends StatelessWidget {
  final bool isHeritage;
  const _WelcomeSection({required this.isHeritage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Kurmancî birincil — İlke §0.5
        Text(
          isHeritage ? 'Xêr hatî, heval!' : 'Xêr hatî!',
          style: AppTypography.headingLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),

        const SizedBox(height: 4),

        Text(
          isHeritage
              ? 'Zimanê xwe vegerîne — her gav pêngav e.'
              : 'Îro çi fêr dibî?',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ).animate().fadeIn(delay: 100.ms, duration: 400.ms),

        // Heritage kullanıcısına bağlam notu (ilke §1.1)
        if (isHeritage) ...[
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: AppSpacing.xs),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.home_outlined,
                    size: 16, color: AppColors.primary),
                const SizedBox(width: 6),
                Text(
                  'Rêya Malê — Heritage Yolu',
                  style: AppTypography.caption.copyWith(
                      color: AppColors.primary),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 200.ms),
        ],
      ],
    );
  }
}

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
                    hasCards ? 'Tekrar bike — $dueCount kart' : 'Îro temam e! ✓',
                    style: AppTypography.labelLarge.copyWith(
                      color: hasCards ? Colors.white : AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    hasCards
                        ? 'FSRS-5 — pir bibîre, zûtir pêş bikeve'
                        : 'Tev kart hatiye xwendin',
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
// BİRİM HARİTASI
// İlke §7.1: Heritage / Genel yol; §2: İlişki senaryoları
// ════════════════════════════════════════════════════════════════

class _UnitMapSection extends StatelessWidget {
  final String userId;
  final int currentLevel;
  final WidgetRef ref;

  const _UnitMapSection({
    required this.userId,
    required this.currentLevel,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final lessons = ref.watch(levelLessonsProvider(currentLevel));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: Text(
            'Waneyên te', // Derslerim
            style: AppTypography.headingSmall.copyWith(
                color: AppColors.textPrimary, fontWeight: FontWeight.w700),
          ),
        ),

        // Ders kartları — birim haritası
        ...lessons.take(12).toList().asMap().entries.map((entry) {
          final i = entry.key;
          final lesson = entry.value;
          return _LessonCard(
            lesson: lesson,
            index: i,
            isUnlocked: i <= 1, // İlk 2 ders açık, geri kalan kilitli (MVP)
            onTap: () => context.push(
              AppRoutes.lesson,
              extra: {'lessonId': lesson.id, 'userId': userId},
            ),
          ).animate().fadeIn(delay: (300 + i * 50).ms);
        }),

        if (lessons.length > 12)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.md),
            child: Center(
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.grid_view_rounded, size: 18),
                label: const Text('Hemû waneyan nîşan bide'),
                style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary),
              ),
            ),
          ),
      ],
    );
  }
}

class _LessonCard extends StatelessWidget {
  final LessonModel lesson;
  final int index;
  final bool isUnlocked;
  final VoidCallback onTap;

  const _LessonCard({
    required this.lesson,
    required this.index,
    required this.isUnlocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isUnlocked ? 1.0 : 0.5,
      child: GestureDetector(
        onTap: isUnlocked ? onTap : null,
        child: Container(
          constraints: const BoxConstraints(minHeight: 48),
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isUnlocked
                  ? AppColors.primary.withOpacity(0.15)
                  : AppColors.border,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Ders numarası
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isUnlocked
                      ? AppColors.primary.withOpacity(0.12)
                      : AppColors.backgroundSecondary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: isUnlocked
                      ? Text(
                          '${index + 1}',
                          style: AppTypography.labelLarge.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700),
                        )
                      : Icon(Icons.lock_outline,
                          size: 18, color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Ders bilgisi — Kurmancî önce (İlke §0.5)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.kuTitle,
                      style: AppTypography.labelLarge.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      lesson.trTitle,
                      style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),

              if (isUnlocked)
                Icon(Icons.arrow_forward_ios,
                    size: 14, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.menu_book_rounded,
                label: 'Fêrbûn',
                isSelected: currentIndex == 0,
                onTap: () {
                  // Already on home
                },
              ),
              _NavItem(
                icon: Icons.refresh_rounded,
                label: 'Dubare',
                isSelected: currentIndex == 1,
                onTap: () => context.push(
                  AppRoutes.lesson,
                  extra: {'mode': 'review'},
                ),
              ),
              _NavItem(
                icon: Icons.music_note_rounded,
                label: 'Çand',
                isSelected: currentIndex == 2,
                onTap: () {
                  // TODO: Navigate to culture screen when available
                },
              ),
              _NavItem(
                icon: Icons.person_rounded,
                label: 'Profîl',
                isSelected: currentIndex == 3,
                onTap: () => context.push(AppRoutes.profile),
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
        width: MediaQuery.of(context).size.width / 4,
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
