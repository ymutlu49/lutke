import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/child_theme.dart';
import '../../domain/bizer_evolution.dart';

/// Karîk Pet Evolution kartı — çocuk home ana sayfası.
/// Mevcut aşama, yıldız sayısı, bir sonraki aşamaya kalan.
class KarikEvolutionCard extends ConsumerWidget {
  const KarikEvolutionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(karikEvolutionProvider);
    final next = s.stage.nextStage();
    final progress = s.stage.progressInStage(s.totalStars);
    final starsToNext = s.stage.starsToNext(s.totalStars);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ChildColors.primarySurface,
            ChildColors.accentSurface,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ChildColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(s.stage.emoji, style: const TextStyle(fontSize: 52))
                  .animate(
                    onPlay: (c) => c.repeat(reverse: true),
                  )
                  .scaleXY(
                    begin: 1.0,
                    end: 1.06,
                    duration: 1400.ms,
                    curve: Curves.easeInOut,
                  ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.stage.nameKu,
                      style: AppTypography.labelLarge.copyWith(
                        color: ChildColors.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      s.stage.descriptionKu,
                      style: AppTypography.caption.copyWith(
                        color: ChildColors.textSecondary,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // ── Yıldız Göstergesi ───────────────────────────────
          Row(
            children: [
              const Text('⭐', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 4),
              Text(
                '${s.totalStars} stêrk',
                style: AppTypography.labelMedium.copyWith(
                  color: ChildColors.accent,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              if (next != null)
                Text(
                  '${next.emoji} · $starsToNext mayî',
                  style: AppTypography.caption.copyWith(
                    color: ChildColors.textSecondary,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          // ── Progress bar ────────────────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor:
                  ChildColors.primary.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation(ChildColors.accent),
            ),
          ),
          if (s.hasNewStage) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: ChildColors.success.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🎉', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Karîk mezintir bû! ${s.stage.nameKu}',
                      style: AppTypography.caption.copyWith(
                        color: ChildColors.success,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => ref
                        .read(karikEvolutionProvider.notifier)
                        .clearNewStage(),
                    child: const Icon(Icons.close, size: 14),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
