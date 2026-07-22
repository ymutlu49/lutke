import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/services/ai_recommendation_service.dart';
import '../../../shared/widgets/empty_state.dart';

/// AI tavsiyesinin metninden uygun etkinlik rotasını tahmin eder.
String _deepLinkForTip(RecommendationTip tip) {
  final text = '${tip.title} ${tip.body}'.toLowerCase();
  if (text.contains('guhdar') || text.contains('dinle') ||
      text.contains('listen')) {
    return '/activity/listening';
  }
  if (text.contains('flashcard') || text.contains('peld') ||
      text.contains('kart')) {
    return '/activity/flashcard';
  }
  if (text.contains('hevok') || text.contains('cümle') ||
      text.contains('sentence')) {
    return '/activity/sentence-builder';
  }
  if (text.contains('telaffuz') || text.contains('bilêv') ||
      text.contains('speak')) {
    return '/activity/pronunciation';
  }
  if (text.contains('lîhev') || text.contains('eşleş') ||
      text.contains('match')) {
    return '/activity/word-match';
  }
  if (text.contains('diyalog') || text.contains('dialogue')) {
    return '/activity/dialogue';
  }
  return '/activity/quiz';
}

/// LÛTKE — Haftalık AI Çalışma Önerisi Kartı
///
/// Profile ekranında görünür. 3 öncelikli tavsiye + 7 günlük plan sunar.
/// 24 saatte bir otomatik yenilenir; kullanıcı manuel yenileme yapabilir.
class WeeklyAiAdvisorCard extends ConsumerWidget {
  final int streakDays;
  final int currentLevelNum;

  const WeeklyAiAdvisorCard({
    super.key,
    required this.streakDays,
    required this.currentLevelNum,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(weeklyRecommendationProvider(
      (streak: streakDays, level: currentLevelNum),
    ));

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.08),
            AppColors.accent.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.12),
        ),
      ),
      child: async.when(
        loading: () => _loadingState(),
        error: (e, _) => ErrorRetryView(
          messageKu: 'Pêşniyar amade nebû',
          compact: true,
          padding: const EdgeInsets.symmetric(vertical: 8),
          onRetry: () {
            // ignore: unused_result
            ref.refresh(weeklyRecommendationProvider(
              (streak: streakDays, level: currentLevelNum),
            ));
          },
        ),
        data: (r) => _content(context, ref, r),
      ),
    );
  }

  Widget _loadingState() => const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );

  Widget _content(
    BuildContext context,
    WidgetRef ref,
    WeeklyRecommendation r,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(context, ref, r),
        const SizedBox(height: AppSpacing.sm),
        _summary(r),
        const SizedBox(height: AppSpacing.md),
        ...r.tips.asMap().entries.map((e) {
          final tip = e.value;
          return Padding(
            padding: EdgeInsets.only(bottom: e.key < r.tips.length - 1 ? 8 : 0),
            child: _TipTile(tip: tip, index: e.key),
          );
        }),
        if (r.weeklyPlan.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          _WeeklyPlanGrid(plan: r.weeklyPlan),
        ],
      ],
    );
  }

  Widget _header(BuildContext context, WidgetRef ref, WeeklyRecommendation r) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              AppColors.primary,
              AppColors.primary.withValues(alpha: 0.7),
            ]),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text('🤖', style: TextStyle(fontSize: 18)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pêşniyara Hefteyî',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '${r.moduleEmoji} ${r.moduleName} · Ast $currentLevelNum',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.refresh_rounded, size: 20),
          tooltip: 'Nû bike',
          color: AppColors.primary,
          onPressed: () async {
            await AiRecommendationService.refresh();
            // ignore: unused_result
            ref.refresh(weeklyRecommendationProvider(
              (streak: streakDays, level: currentLevelNum),
            ));
          },
        ),
      ],
    );
  }

  Widget _summary(WeeklyRecommendation r) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('💡', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              r.summary,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tavsiye kutusu ──────────────────────────────────────────────

class _TipTile extends StatelessWidget {
  final RecommendationTip tip;
  final int index;

  const _TipTile({required this.tip, required this.index});

  @override
  Widget build(BuildContext context) {
    final priorityColor = tip.priority >= 8
        ? AppColors.accent
        : tip.priority >= 6
            ? AppColors.primary
            : AppColors.textSecondary;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: priorityColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(tip.emoji, style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip.title,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  tip.body,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 4),
              minimumSize: const Size(44, 32),
              backgroundColor: priorityColor.withValues(alpha: 0.1),
              foregroundColor: priorityColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => context.push(_deepLinkForTip(tip)),
            child: Text(
              'Dest pê ke',
              style: AppTypography.caption.copyWith(
                color: priorityColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 100 * index)).slideX(
          begin: 0.05,
          end: 0,
        );
  }
}

// ── 7-günlük plan ızgarası ──────────────────────────────────────

class _WeeklyPlanGrid extends StatelessWidget {
  final List<DailyPlanItem> plan;
  const _WeeklyPlanGrid({required this.plan});

  @override
  Widget build(BuildContext context) {
    final todayWeekday = DateTime.now().weekday; // 1=Mon..7=Sun
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('📅', style: TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Text(
              'Bernameya Hefteyê',
              style: AppTypography.caption.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(plan.length, (i) {
            final p = plan[i];
            final isToday = (i + 1) == todayWeekday;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: _DayCell(item: p, isToday: isToday),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  final DailyPlanItem item;
  final bool isToday;

  const _DayCell({required this.item, required this.isToday});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      decoration: BoxDecoration(
        color: isToday
            ? AppColors.primary
            : AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isToday
              ? AppColors.primary
              : AppColors.primary.withValues(alpha: 0.12),
          width: 1.2,
        ),
        boxShadow: isToday
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.dayShort,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: isToday ? Colors.white : AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(item.emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 2),
          Text(
            '${item.targetXp}',
            style: TextStyle(
              fontSize: 8.5,
              fontWeight: FontWeight.w700,
              color: isToday
                  ? Colors.white.withValues(alpha: 0.9)
                  : AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
