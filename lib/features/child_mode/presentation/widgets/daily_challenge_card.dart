import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/child_theme.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../domain/child_daily_challenge.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Günlük Meydan Okuma Kartı
//
// 3 görev + ödül sandığı. Child home ekranında görünür.
// ════════════════════════════════════════════════════════════════

class DailyChallengeCard extends ConsumerWidget {
  const DailyChallengeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(todayChallengesProvider);
    final chestsAsync = ref.watch(unopenedChestsProvider);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ChildColors.primary.withOpacity(0.10),
            ChildColors.accent.withOpacity(0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
        border: Border.all(
          color: ChildColors.primary.withOpacity(0.22),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context, chestsAsync),
          const SizedBox(height: 12.0),
          async.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            ),
            error: (e, _) => ErrorRetryView(
              messageKu: 'Erkên îro amade nebûn',
              compact: true,
              padding: const EdgeInsets.all(8),
              onRetry: () => ref.invalidate(todayChallengesProvider),
            ),
            data: (list) => Column(
              children: list
                  .asMap()
                  .entries
                  .map((e) => Padding(
                        padding: EdgeInsets.only(
                          bottom: e.key < list.length - 1 ? 10 : 0,
                        ),
                        child: _ChallengeRow(challenge: e.value, index: e.key),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context, AsyncValue<int> chestsAsync) {
    final chests = chestsAsync.asData?.value ?? 0;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: ChildColors.primary.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text('🎯', style: TextStyle(fontSize: 22)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Îro 3 erkên te hene!',
                style: ChildTypography.title.copyWith(
                  fontSize: 16,
                ),
              ),
              Text(
                'Her erekê biqedîne, sandiqê bi dest bixe!',
                style: ChildTypography.caption,
              ),
            ],
          ),
        ),
        if (chests > 0)
          GestureDetector(
            onTap: () => context.push(AppRoutes.childRewards),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ChildColors.accent,
                        ChildColors.accent.withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: ChildColors.accent.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Text('🎁', style: TextStyle(fontSize: 22)),
                )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.08, 1.08),
                      duration: 900.ms,
                    ),
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 1,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$chests',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

}

class _ChallengeRow extends StatelessWidget {
  final DailyChallenge challenge;
  final int index;

  const _ChallengeRow({required this.challenge, required this.index});

  @override
  Widget build(BuildContext context) {
    final completed = challenge.isCompleted;
    final color = completed
        ? ChildColors.success
        : ChildColors.primary;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ChildColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.25),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              challenge.kind.emoji,
              style: const TextStyle(fontSize: 22),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        challenge.kind.titleKu,
                        style: ChildTypography.label.copyWith(
                          fontWeight: FontWeight.w700,
                          decoration: completed
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text('⭐', style: TextStyle(fontSize: 14)),
                        Text(
                          '${challenge.starsReward}',
                          style: ChildTypography.label.copyWith(
                            color: ChildColors.accent,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: challenge.percentComplete,
                          minHeight: 7,
                          backgroundColor: color.withOpacity(0.12),
                          valueColor: AlwaysStoppedAnimation(color),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${challenge.progress}/${challenge.target}',
                      style: ChildTypography.caption.copyWith(
                        color: color,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    if (completed) ...[
                      const SizedBox(width: 4),
                      Text(
                        '✔',
                        style: TextStyle(
                          fontSize: 14,
                          color: ChildColors.success,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(
          delay: Duration(milliseconds: 100 * index),
          duration: 300.ms,
        );
  }
}
