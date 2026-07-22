import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/services/cloudflare_auth_service.dart';

// ════════════════════════════════════════════════════════════════
// USER STATS CARD — Tenê ji bo Rêveberê
//
// Cloudflare /api/admin/stats endpoint'inden okur, owner kullanıcı
// için profil → settings tab'ında görünür.
// Backend zaten owner-only kontrolü yapıyor (403 dönüyor) — frontend
// bu widget'ı sadece isOwner ise render eder.
// ════════════════════════════════════════════════════════════════

class UserStatsCard extends ConsumerWidget {
  const UserStatsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStats = ref.watch(cloudflareStatsProvider);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.groups_outlined,
                  color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Bikarhênerên LÛTKE',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.refresh_rounded,
                    size: 20, color: AppColors.textSecondary),
                tooltip: 'Nûjen bike',
                onPressed: () => ref.invalidate(cloudflareStatsProvider),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                    minHeight: 32, minWidth: 32),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          asyncStats.when(
            data: (stats) {
              if (stats == null) {
                return _buildEmpty();
              }
              return _buildStats(stats);
            },
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child:
                      CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
            error: (_, __) => _buildEmpty(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Text(
        'Statîstîk nehat barkirin. Ji kerema xwe paşê biceribîne.',
        style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
      ),
    );
  }

  Widget _buildStats(UserStats s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero: total users
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${s.total}',
              style: AppTypography.headingSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w900,
                fontSize: 36,
                height: 1.0,
              ),
            ),
            const SizedBox(width: 6),
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                'bikarhêner',
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        // Verified vs unverified
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.xs,
          children: [
            _StatChip(
              label: 'Piştrastkirî',
              value: s.verified,
              color: const Color(0xFF4CAF50),
            ),
            _StatChip(
              label: 'Nepiştrastkirî',
              value: s.unverified,
              color: const Color(0xFFFFA726),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        const Divider(height: 1),
        const SizedBox(height: AppSpacing.sm),

        // Recent activity
        _StatRow(
          icon: Icons.fiber_new_rounded,
          label: '24 saetên dawî',
          value: '+${s.registeredLast24h}',
          color: AppColors.primary,
        ),
        _StatRow(
          icon: Icons.calendar_today_outlined,
          label: '7 rojên dawî',
          value: '+${s.registeredLast7d}',
          color: AppColors.primary,
        ),
        _StatRow(
          icon: Icons.bolt_outlined,
          label: '30 rojên dawî (aktîv)',
          value: '${s.activeLast30d}',
          color: const Color(0xFF4CAF50),
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  const _StatChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$label: $value',
            style: AppTypography.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _StatRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: AppTypography.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
