import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/router/app_router.dart';
import '../../core/services/auth_service.dart';
import '../lessons/data/lesson_repository.dart';
import '../gamification/gamification_widgets.dart';
import '../../shared/widgets/leaderboard_widget.dart';

// ════════════════════════════════════════════════════════════════
// PROFİL EKRANI — LÛTKE
// İlke §0.5: Kurmancî birincil
// İlke §1: Kimlik odaklı profil (asimilasyon yolculuğu)
// İlke §8: WCAG 2.2 AA erişilebilirlik
// ════════════════════════════════════════════════════════════════

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final profile = ref.watch(userProfileProvider);
    final userId = user?.uid ?? 'anonymous';

    // Güvenli provider erişimi — DB hatalarında çökmez
    AsyncValue<dynamic>? dailyStats;
    try {
      dailyStats = ref.watch(dailyStatsProvider(userId));
    } catch (_) {
      dailyStats = null;
    }

    var levelProgresses = <AsyncValue<LevelProgress>>[];
    try {
      levelProgresses = [1, 2, 3, 4, 5, 6]
          .map(
            (lvl) => ref
                .watch(levelProgressProvider((userId: userId, level: lvl))),
          )
          .toList();
    } catch (_) {}

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: CustomScrollView(
              slivers: [
                // ── Üst Bar ──────────────────────────────────────
                SliverAppBar(
                  floating: true,
                  backgroundColor: AppColors.backgroundPrimary,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  title: Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/images/logo_128.png',
                          width: 44,
                          height: 44,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.medium,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Profîla min',
                        style: AppTypography.headingSmall.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.settings_outlined),
                      onPressed: () => context.push(AppRoutes.settings),
                    ),
                  ],
                ),

                SliverPadding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // ── 1. Profil Başlığı (Geliştirilmiş) ────
                      _ProfileHeader(
                        displayName: profile.displayName.isNotEmpty
                            ? profile.displayName
                            : user?.displayName ?? 'Heval',
                        currentLevel: profile.currentLevel.toUpperCase(),
                        currentLevelNum: profile.currentLevelNum,
                        isHeritage: profile.isHeritage,
                        totalXP: profile.totalXP,
                        memberSince: user?.metadata.creationTime,
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      // ── 2. Öğrenme İstatistik Panosu ─────────
                      if (dailyStats != null)
                        dailyStats.when(
                          data: (s) => _LearningStatsDashboard(
                            totalWords: _sumLearnedWords(levelProgresses),
                            totalWordTarget: 4178,
                            completedLessons:
                                profile.completedLessons.length,
                            totalLessons: 137,
                            streakDays: s.streakDays,
                            bestStreak: s.streakDays, // placeholder
                            accuracy: s.accuracy,
                          ),
                          loading: () =>
                              const _LearningStatsDashboard(
                            totalWords: 0,
                            totalWordTarget: 4178,
                            completedLessons: 0,
                            totalLessons: 137,
                            streakDays: 0,
                            bestStreak: 0,
                            accuracy: 0,
                          ),
                          error: (_, __) =>
                              const _LearningStatsDashboard(
                            totalWords: 0,
                            totalWordTarget: 4178,
                            completedLessons: 0,
                            totalLessons: 137,
                            streakDays: 0,
                            bestStreak: 0,
                            accuracy: 0,
                          ),
                        )
                      else
                        const _LearningStatsDashboard(
                          totalWords: 0,
                          totalWordTarget: 4178,
                          completedLessons: 0,
                          totalLessons: 137,
                          streakDays: 0,
                          bestStreak: 0,
                          accuracy: 0,
                        ),

                      const SizedBox(height: AppSpacing.lg),

                      // ── XP İlerleme Çubuğu ──────────────────
                      const XPProgressBar(),

                      const SizedBox(height: AppSpacing.lg),

                      // ── Rozet Koleksiyonu ────────────────────
                      const AchievementBadgeGrid(),

                      const SizedBox(height: AppSpacing.lg),

                      // ── 3. CEFR Seviye İlerlemesi ────────────
                      _CEFRProgressSection(
                        currentLevel: profile.currentLevelNum,
                        progresses: levelProgresses,
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      // ── 4. Haftalık Aktivite Grafiği ─────────
                      const _WeeklyActivityChart(),

                      const SizedBox(height: AppSpacing.lg),

                      // ── 4b. Mini Leaderboard (Pêşbazî) ─────
                      const LeaderboardWidget(),

                      const SizedBox(height: AppSpacing.lg),

                      // ── 5. Hızlı Eylemler ───────────────────
                      const _QuickActionsSection(),

                      const SizedBox(height: AppSpacing.lg),

                      // ── 6. Ayarlar Bölümü ───────────────────
                      _SettingsSection(
                        dailyGoal: profile.dailyGoal,
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      // ── Motivasyon Çapası ────────────────────
                      // İlke §9b bulgu #2
                      _MotivationCard(motivation: profile.motivation.name),

                      const SizedBox(height: AppSpacing.lg),

                      // ── Erişilebilirlik Ayarları ─────────────
                      // İlke §8.2: Disleksi desteği
                      _AccessibilityCard(),

                      const SizedBox(height: AppSpacing.lg),

                      // ── Hesap Eylemleri ──────────────────────
                      _AccountActions(
                        isAnonymous: user?.isAnonymous ?? true,
                        ref: ref,
                        context: context,
                      ),

                      const SizedBox(height: AppSpacing.xl),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Tüm seviyelerdeki öğrenilen kelime toplamını hesapla
  static int _sumLearnedWords(List<AsyncValue<LevelProgress>> progresses) {
    int total = 0;
    for (final p in progresses) {
      p.whenData((data) => total += data.learnedCards);
    }
    return total;
  }
}

// ════════════════════════════════════════════════════════════════
// 1. PROFİL BAŞLIĞI (GELİŞTİRİLMİŞ)
// ════════════════════════════════════════════════════════════════

class _ProfileHeader extends StatelessWidget {
  final String displayName;
  final String currentLevel;
  final int currentLevelNum;
  final bool isHeritage;
  final int totalXP;
  final DateTime? memberSince;

  const _ProfileHeader({
    required this.displayName,
    required this.currentLevel,
    required this.currentLevelNum,
    required this.isHeritage,
    required this.totalXP,
    this.memberSince,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.08),
            AppColors.primary.withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar — kullanıcı baş harfi
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    displayName.isNotEmpty
                        ? displayName[0].toUpperCase()
                        : 'H',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: AppTypography.headingSmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Badges row
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        _LevelBadge(
                          level: currentLevel,
                          levelNum: currentLevelNum,
                        ),
                        if (isHeritage)
                          _HeritageBadge()
                        else
                          _GeneralBadge(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // XP ve üyelik bilgisi
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Total XP
                Icon(
                  Icons.star_rounded,
                  size: 18,
                  color: AppColors.accent,
                ),
                const SizedBox(width: 6),
                Text(
                  '$totalXP XP',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                // Member since
                if (memberSince != null) ...[
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatMemberSince(memberSince!),
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.05, end: 0);
  }

  String _formatMemberSince(DateTime date) {
    const months = [
      '', 'Rêb', 'Sib', 'Adar', 'Nîs', 'Gul', 'Hezîr',
      'Tîr', 'Teb', 'Îlon', 'Cot', 'Mij', 'Kan',
    ];
    return '${months[date.month]} ${date.year}';
  }
}

class _LevelBadge extends StatelessWidget {
  final String level;
  final int levelNum;
  const _LevelBadge({required this.level, required this.levelNum});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Ast $levelNum — $level',
          style: AppTypography.caption.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
}

class _HeritageBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.accent.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.accent.withOpacity(0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.home_outlined, size: 12, color: AppColors.accent),
            const SizedBox(width: 4),
            Text(
              'Heritage',
              style: AppTypography.caption.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
}

class _GeneralBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.primarySurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.school_outlined,
                size: 12, color: AppColors.primary),
            const SizedBox(width: 4),
            Text(
              'Genel',
              style: AppTypography.caption.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
}

// ════════════════════════════════════════════════════════════════
// 2. ÖĞRENME İSTATİSTİK PANOSU
// 2x2 grid: Kelime, Ders, Streak, Doğruluk
// ════════════════════════════════════════════════════════════════

class _LearningStatsDashboard extends StatelessWidget {
  final int totalWords;
  final int totalWordTarget;
  final int completedLessons;
  final int totalLessons;
  final int streakDays;
  final int bestStreak;
  final double accuracy;

  const _LearningStatsDashboard({
    required this.totalWords,
    required this.totalWordTarget,
    required this.completedLessons,
    required this.totalLessons,
    required this.streakDays,
    required this.bestStreak,
    required this.accuracy,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pêşveçûna fêrbûnê',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppSpacing.sm,
          crossAxisSpacing: AppSpacing.sm,
          childAspectRatio: 1.35,
          children: [
            // Kelime İlerlemesi
            _CircularProgressCard(
              title: 'Peyv',
              subtitle: '$totalWords / $totalWordTarget peyv',
              progress: totalWordTarget > 0
                  ? totalWords / totalWordTarget
                  : 0.0,
              color: AppColors.primary,
              icon: Icons.translate_rounded,
              delay: 0,
            ),
            // Ders İlerlemesi
            _CircularProgressCard(
              title: 'Wane',
              subtitle: '$completedLessons / $totalLessons wane',
              progress: totalLessons > 0
                  ? completedLessons / totalLessons
                  : 0.0,
              color: const Color(0xFF5C6BC0),
              icon: Icons.menu_book_rounded,
              delay: 80,
            ),
            // Streak
            _StreakCard(
              streakDays: streakDays,
              bestStreak: bestStreak,
              delay: 160,
            ),
            // Doğruluk
            _AccuracyCard(
              accuracy: accuracy,
              delay: 240,
            ),
          ],
        ),
      ],
    );
  }
}

class _CircularProgressCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final Color color;
  final IconData icon;
  final int delay;

  const _CircularProgressCard({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.color,
    required this.icon,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);
    final percent = (clampedProgress * 100).round();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 6),
              Text(
                title,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              SizedBox(
                width: 44,
                height: 44,
                child: _AnimatedCircularProgress(
                  progress: clampedProgress,
                  color: color,
                  strokeWidth: 4,
                  child: Text(
                    '$percent%',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  subtitle,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: delay), duration: 400.ms)
        .slideY(begin: 0.1, end: 0);
  }
}

class _AnimatedCircularProgress extends StatefulWidget {
  final double progress;
  final Color color;
  final double strokeWidth;
  final Widget child;

  const _AnimatedCircularProgress({
    required this.progress,
    required this.color,
    required this.strokeWidth,
    required this.child,
  });

  @override
  State<_AnimatedCircularProgress> createState() =>
      _AnimatedCircularProgressState();
}

class _AnimatedCircularProgressState
    extends State<_AnimatedCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _currentProgress = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.progress)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ))
      ..addListener(() {
        setState(() => _currentProgress = _animation.value);
      });
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant _AnimatedCircularProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _animation = Tween<double>(
        begin: _currentProgress,
        end: widget.progress,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ))
        ..addListener(() {
          setState(() => _currentProgress = _animation.value);
        });
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CircularProgressPainter(
        progress: _currentProgress,
        color: widget.color,
        strokeWidth: widget.strokeWidth,
      ),
      child: Center(child: widget.child),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _CircularProgressPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background circle
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..color = color.withOpacity(0.12),
    );

    // Progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter old) =>
      old.progress != progress;
}

class _StreakCard extends StatelessWidget {
  final int streakDays;
  final int bestStreak;
  final int delay;

  const _StreakCard({
    required this.streakDays,
    required this.bestStreak,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_fire_department_rounded,
                  size: 18, color: AppColors.accent),
              const SizedBox(width: 6),
              Text(
                'Rêze',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            '$streakDays roj',
            style: AppTypography.headline.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Herî baş: $bestStreak roj',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: delay), duration: 400.ms)
        .slideY(begin: 0.1, end: 0);
  }
}

class _AccuracyCard extends StatelessWidget {
  final double accuracy;
  final int delay;

  const _AccuracyCard({
    required this.accuracy,
    required this.delay,
  });

  Color _accuracyColor() {
    final percent = accuracy * 100;
    if (percent >= 80) return AppColors.success;
    if (percent >= 50) return AppColors.warning;
    return AppColors.errorSoft;
  }

  @override
  Widget build(BuildContext context) {
    final percent = (accuracy * 100).round();
    final color = _accuracyColor();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle_outline_rounded,
                  size: 18, color: color),
              const SizedBox(width: 6),
              Text(
                'Rastbûn',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            '$percent%',
            style: AppTypography.headline.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            percent >= 80
                ? 'Pir baş!'
                : percent >= 50
                    ? 'Baş e, berdewam bike'
                    : 'Pratîk bike!',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: delay), duration: 400.ms)
        .slideY(begin: 0.1, end: 0);
  }
}

// ════════════════════════════════════════════════════════════════
// 3. CEFR SEVİYE İLERLEME BÖLÜMÜ
// Renk kodlu: A1=green, A2=lime, B1=orange, B2=red, C1=purple, C2=indigo
// ════════════════════════════════════════════════════════════════

class _CEFRProgressSection extends StatelessWidget {
  final int currentLevel;
  final List<AsyncValue<LevelProgress>> progresses;

  const _CEFRProgressSection({
    required this.currentLevel,
    required this.progresses,
  });

  static const _levelColors = [
    Color(0xFF4CAF50), // A1 = green
    Color(0xFF8BC34A), // A2 = lime
    Color(0xFFFF9800), // B1 = orange
    Color(0xFFF44336), // B2 = red
    Color(0xFF9C27B0), // C1 = purple
    Color(0xFF3F51B5), // C2 = indigo
  ];

  @override
  Widget build(BuildContext context) {
    const levels = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Astên CEFR',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...levels.asMap().entries.map((entry) {
            final i = entry.key;
            final level = entry.value;
            final isActive = i + 1 == currentLevel;
            final color = _levelColors[i];

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _CEFRLevelBar(
                level: level,
                isActive: isActive,
                color: color,
                progressAsync:
                    i < progresses.length ? progresses[i] : null,
              ),
            );
          }),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 300.ms, duration: 400.ms)
        .slideY(begin: 0.05, end: 0);
  }
}

class _CEFRLevelBar extends StatelessWidget {
  final String level;
  final bool isActive;
  final Color color;
  final AsyncValue<LevelProgress>? progressAsync;

  const _CEFRLevelBar({
    required this.level,
    required this.isActive,
    required this.color,
    this.progressAsync,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Seviye etiketi
        Container(
          width: 40,
          height: 28,
          decoration: BoxDecoration(
            color: isActive ? color : color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: isActive
                ? null
                : Border.all(color: color.withOpacity(0.3)),
          ),
          child: Center(
            child: Text(
              level,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isActive ? Colors.white : color,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),

        // İlerleme çubuğu + kelime sayısı
        Expanded(
          child: progressAsync?.when(
                data: (p) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${(p.completionPercent * 100).round()}%',
                          style: AppTypography.caption.copyWith(
                            color: isActive
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                            fontWeight: isActive
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                        ),
                        Text(
                          '${p.learnedCards}/${p.totalCards} peyv',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: p.completionPercent.clamp(0.0, 1.0),
                        backgroundColor: color.withOpacity(0.1),
                        valueColor: AlwaysStoppedAnimation(
                          isActive ? color : color.withOpacity(0.5),
                        ),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
                loading: () => const SizedBox(height: 28),
                error: (_, __) => const SizedBox(height: 28),
              ) ??
              const SizedBox(height: 28),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// 4. HAFTALIK AKTİVİTE GRAFİĞİ
// ════════════════════════════════════════════════════════════════

class _WeeklyActivityChart extends StatelessWidget {
  const _WeeklyActivityChart();

  @override
  Widget build(BuildContext context) {
    // Placeholder veriler — gerçek veriler provider'dan gelecek
    final now = DateTime.now();
    final todayWeekday = now.weekday; // 1=Mon, 7=Sun
    // Simüle veri (gerçek implementasyonda provider'dan gelir)
    final weekData = [12, 8, 15, 0, 22, 10, todayWeekday >= 7 ? 5 : 0];
    final maxVal =
        weekData.reduce((a, b) => a > b ? a : b).clamp(1, 999);
    final totalWeek = weekData.reduce((a, b) => a + b);
    const dayLabels = ['Dş', 'Sş', 'Çş', 'Pş', 'În', 'Şe', 'Yş'];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hefteya me',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Vê hefteyê $totalWeek peyv',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (i) {
                final isToday = i + 1 == todayWeekday;
                final barHeight =
                    maxVal > 0 ? (weekData[i] / maxVal) * 70 : 0.0;

                return Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (weekData[i] > 0)
                          Text(
                            '${weekData[i]}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isToday
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        const SizedBox(height: 4),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 600),
                          height: barHeight.clamp(4.0, 70.0),
                          decoration: BoxDecoration(
                            color: isToday
                                ? AppColors.primary
                                : weekData[i] > 0
                                    ? AppColors.primary
                                        .withOpacity(0.3)
                                    : AppColors.weekDayEmpty,
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          dayLabels[i],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isToday
                                ? FontWeight.w700
                                : FontWeight.w400,
                            color: isToday
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 400.ms, duration: 400.ms)
        .slideY(begin: 0.05, end: 0);
  }
}

// ════════════════════════════════════════════════════════════════
// 5. HIZLI EYLEMLER
// ════════════════════════════════════════════════════════════════

class _QuickActionsSection extends StatelessWidget {
  const _QuickActionsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Zû bike',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _QuickActionButton(
                label: 'Dersê Bide',
                icon: Icons.play_arrow_rounded,
                color: AppColors.primary,
                onTap: () => context.push(AppRoutes.lesson, extra: {
                  'mode': 'lesson',
                  'userId': 'anonymous',
                }),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _QuickActionButton(
                label: 'Peyvên Kurmancî',
                icon: Icons.list_alt_rounded,
                color: const Color(0xFF5C6BC0),
                onTap: () => context.go(AppRoutes.vocabulary),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        // ── Rêya min (İlerleme Haritası) ──────────────────
        SizedBox(
          width: double.infinity,
          child: _QuickActionButton(
            label: 'Rêya min',
            icon: Icons.map_rounded,
            color: const Color(0xFF2E7D32),
            onTap: () => context.push(AppRoutes.progressMap),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        // Admin panel — ince ve gizli
        Center(
          child: TextButton(
            onPressed: () => context.push(AppRoutes.admin),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textTertiary,
              textStyle: AppTypography.caption,
            ),
            child: const Text('Panêla Rêvebiriyê'),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(delay: 500.ms, duration: 400.ms);
  }
}

class _QuickActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.md,
            horizontal: AppSpacing.md,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: AppTypography.label.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// 6. AYARLAR BÖLÜMÜ
// ════════════════════════════════════════════════════════════════

class _SettingsSection extends StatefulWidget {
  final int dailyGoal;

  const _SettingsSection({required this.dailyGoal});

  @override
  State<_SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<_SettingsSection> {
  late double _goalSlider;
  bool _notificationsEnabled = true;
  String _language = 'Kurmancî';
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _goalSlider = widget.dailyGoal.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mîheng',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Günlük hedef
          Text(
            'Armanca rojane: ${_goalSlider.round()} peyv',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.primary.withOpacity(0.12),
              thumbColor: AppColors.primary,
              overlayColor: AppColors.primary.withOpacity(0.1),
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 8),
            ),
            child: Slider(
              value: _goalSlider,
              min: 5,
              max: 50,
              divisions: 9,
              onChanged: (v) => setState(() => _goalSlider = v),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('5',
                  style: AppTypography.caption
                      .copyWith(color: AppColors.textTertiary)),
              Text('50',
                  style: AppTypography.caption
                      .copyWith(color: AppColors.textTertiary)),
            ],
          ),

          const Divider(height: AppSpacing.lg),

          // Bildirişler
          SwitchListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Agahdarî',
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textPrimary),
            ),
            subtitle: Text(
              'Bîranînên rojane',
              style: AppTypography.caption
                  .copyWith(color: AppColors.textSecondary),
            ),
            value: _notificationsEnabled,
            activeColor: AppColors.primary,
            onChanged: (v) =>
                setState(() => _notificationsEnabled = v),
          ),

          const Divider(height: AppSpacing.sm),

          // Dil tercihi
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Ziman',
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textPrimary),
            ),
            trailing: DropdownButton<String>(
              value: _language,
              underline: const SizedBox.shrink(),
              style: AppTypography.caption.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
              items: ['Kurmancî', 'Tirkî', 'English']
                  .map((l) =>
                      DropdownMenuItem(value: l, child: Text(l)))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _language = v);
              },
            ),
          ),

          const Divider(height: AppSpacing.sm),

          // Koyu mod
          SwitchListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Moda tarî',
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textPrimary),
            ),
            subtitle: Text(
              'Dê bê',
              style: AppTypography.caption
                  .copyWith(color: AppColors.textSecondary),
            ),
            value: _darkMode,
            activeColor: AppColors.primary,
            onChanged: (v) => setState(() => _darkMode = v),
          ),

          const Divider(height: AppSpacing.sm),

          // Hakkında LÛTKE
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.info_outline,
                size: 20, color: AppColors.textSecondary),
            title: Text(
              'Der barê LÛTKE de',
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textPrimary),
            ),
            trailing: Icon(Icons.chevron_right,
                size: 20, color: AppColors.textSecondary),
            onTap: () => _showAboutDialog(context),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 600.ms, duration: 400.ms);
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'LÛTKE',
          style: AppTypography.headline.copyWith(
            color: AppColors.primary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Serlêdana fêrbûna zimanê Kurdî',
              style: AppTypography.body.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Guherto 1.0.0',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Prof. Dr. Yilmaz Mutlu',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Baş e',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// MOTİVASYON ÇAPASI
// İlke §9b bulgu #2
// ════════════════════════════════════════════════════════════════

class _MotivationCard extends StatelessWidget {
  final String motivation;
  const _MotivationCard({required this.motivation});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(Icons.favorite_outline,
                color: AppColors.accent, size: 24),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Motivasyona te',
                    style: AppTypography.caption
                        .copyWith(color: AppColors.textSecondary),
                  ),
                  Text(
                    motivation,
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

// ════════════════════════════════════════════════════════════════
// ERİŞİLEBİLİRLİK KARTI
// İlke §8.2: Disleksi desteği, Prof. Dr. Yilmaz Mutlu
// ════════════════════════════════════════════════════════════════

class _AccessibilityCard extends StatefulWidget {
  @override
  State<_AccessibilityCard> createState() => _AccessibilityCardState();
}

class _AccessibilityCardState extends State<_AccessibilityCard> {
  bool _dyslexicFont = false;
  bool _largeText = false;
  bool _reduceMotion = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gihîştbarî',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          // Disleksi fontu
          SwitchListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Tîpên disleksiyê',
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textPrimary),
            ),
            subtitle: Text(
              'OpenDyslexic font',
              style: AppTypography.caption
                  .copyWith(color: AppColors.textSecondary),
            ),
            value: _dyslexicFont,
            activeColor: AppColors.primary,
            onChanged: (v) => setState(() => _dyslexicFont = v),
          ),
          // Büyük metin
          SwitchListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Tîpên mezin',
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textPrimary),
            ),
            value: _largeText,
            activeColor: AppColors.primary,
            onChanged: (v) => setState(() => _largeText = v),
          ),
          // Animasyonları azalt
          SwitchListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Livîn kêm bike',
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textPrimary),
            ),
            value: _reduceMotion,
            activeColor: AppColors.primary,
            onChanged: (v) => setState(() => _reduceMotion = v),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// HESAP EYLEMLERİ
// ════════════════════════════════════════════════════════════════

class _AccountActions extends StatelessWidget {
  final bool isAnonymous;
  final WidgetRef ref;
  final BuildContext context;

  const _AccountActions({
    required this.isAnonymous,
    required this.ref,
    required this.context,
  });

  Future<void> _signOut() async {
    await ref.read(authServiceProvider).signOut();
    if (context.mounted) context.go(AppRoutes.splash);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hesap kaydı (anonim ise)
        if (isAnonymous)
          OutlinedButton.icon(
            onPressed: () => context.push(AppRoutes.register),
            icon: const Icon(Icons.person_add_outlined),
            label: const Text('Hesabê xwe biparêze'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              side: BorderSide(color: AppColors.primary),
              foregroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),

        if (isAnonymous) const SizedBox(height: AppSpacing.sm),

        // Mod Değiştir (Yetişkin ↔ Çocuk)
        OutlinedButton.icon(
          onPressed: () => context.go(AppRoutes.modeSelect),
          icon: const Icon(Icons.swap_horiz_rounded, size: 20),
          label: const Text('Modê biguherîne'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            side: const BorderSide(color: AppColors.primary),
            foregroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        // Çıkış
        OutlinedButton.icon(
          onPressed: _signOut,
          icon: const Icon(Icons.logout_outlined),
          label: const Text('Derkeve'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            side: BorderSide(color: AppColors.border),
            foregroundColor: AppColors.textSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }
}
