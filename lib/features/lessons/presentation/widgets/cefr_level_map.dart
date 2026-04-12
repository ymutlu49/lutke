import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/entities/vocabulary_card.dart';
import '../../domain/repositories/lesson_repository_interface.dart';

// ════════════════════════════════════════════════════════════════
// CEFR SEVİYE HARİTASI — LÛTKE
//
// İlke §4.5: İlerleme haritası — 6 seviye (A1–C2)
// Her seviye bir rozet + ilerleme çubuğu ile gösterilir.
// ════════════════════════════════════════════════════════════════

class CEFRLevelMap extends StatelessWidget {
  final CEFRLevel currentLevel;
  final Map<CEFRLevel, LevelProgress> progressMap;

  const CEFRLevelMap({
    super.key,
    required this.currentLevel,
    required this.progressMap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rêya Fêrbûnê',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Öğrenme yolu',
          style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary.withOpacity(0.6),
            fontSize: 11,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ...CEFRLevel.values.map((level) {
          final progress = progressMap[level];
          final isCurrent = level == currentLevel;
          final isLocked = level.number > currentLevel.number + 1;

          return _LevelRow(
            level: level,
            progress: progress,
            isCurrent: isCurrent,
            isLocked: isLocked,
          );
        }),
      ],
    );
  }
}

class _LevelRow extends StatelessWidget {
  final CEFRLevel level;
  final LevelProgress? progress;
  final bool isCurrent;
  final bool isLocked;

  const _LevelRow({
    required this.level,
    required this.progress,
    required this.isCurrent,
    required this.isLocked,
  });

  @override
  Widget build(BuildContext context) {
    final percent = progress?.completionPercent ?? 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isCurrent
            ? AppColors.primary.withOpacity(0.06)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: isCurrent
            ? Border.all(color: AppColors.primary.withOpacity(0.3))
            : null,
      ),
      child: Row(
        children: [
          // Seviye rozeti
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: isLocked
                  ? AppColors.backgroundSecondary
                  : _levelColor(level).withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isLocked
                  ? Icon(Icons.lock_outline, size: 18,
                      color: AppColors.textSecondary.withOpacity(0.4))
                  : Text(
                      level.label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: _levelColor(level),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          // Bilgi
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      level.labelKu,
                      style: AppTypography.bodySmall.copyWith(
                        color: isLocked
                            ? AppColors.textSecondary.withOpacity(0.4)
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (isCurrent) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('niha',
                            style: TextStyle(
                                fontSize: 9, color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                // İlerleme çubuğu
                if (!isLocked)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: percent,
                      backgroundColor: AppColors.backgroundSecondary,
                      valueColor: AlwaysStoppedAnimation(_levelColor(level)),
                      minHeight: 6,
                    ),
                  )
                else
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 0,
                      backgroundColor: AppColors.backgroundSecondary
                          .withOpacity(0.5),
                      minHeight: 6,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),

          // Yüzde
          if (!isLocked)
            Text(
              '${(percent * 100).toInt()}%',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    ).animate(delay: (level.number * 80).ms)
        .fadeIn(duration: 300.ms)
        .slideX(begin: 0.05, end: 0);
  }

  Color _levelColor(CEFRLevel level) => switch (level) {
    CEFRLevel.a1 => const Color(0xFF4CAF50),
    CEFRLevel.a2 => const Color(0xFF66BB6A),
    CEFRLevel.b1 => const Color(0xFF1A7B6B),
    CEFRLevel.b2 => const Color(0xFF0277BD),
    CEFRLevel.c1 => const Color(0xFF7B1FA2),
    CEFRLevel.c2 => const Color(0xFFD4783A),
  };
}
