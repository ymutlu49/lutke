import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/services/auth_service.dart';
import '../../../shared/widgets/empty_state.dart';
import '../data/review_repository.dart';
import '../domain/review_models.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Admin Review Panel
//
// Owner (Prof. Dr. Yılmaz Mutlu) buraya gelir ve 10 dil uzmanından
// gelen bekleyen önerileri (suggested + flagged) inceleyip:
//   🎉 Pejirandî (accepted) — öneriyi kabul et
//   ❌ Redkirî (dismissed) — öneriyi red et
//
// Kabul edilen önerilerin liste halinde export'u yapılabilir (CSV).
// ════════════════════════════════════════════════════════════════

class AdminReviewPanel extends ConsumerWidget {
  const AdminReviewPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOwner = ref.watch(isOwnerProvider);
    if (!isOwner) {
      return _accessDenied(context);
    }

    final pendingAsync = ref.watch(pendingReviewsProvider);
    final statsAsync = ref.watch(reviewStatsProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        title: Row(
          children: [
            const Text('📊', style: TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Text(
              'Panela Nirxandinê',
              style: AppTypography.headingSmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: statsAsync.when(
                loading: () => const SizedBox(height: 100),
                error: (_, __) => const SizedBox.shrink(),
                data: (s) => _StatsCard(stats: s),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.fromLTRB(AppSpacing.md, 8, AppSpacing.md, 8),
              child: Text(
                'Pêşniyarên bendewar',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          pendingAsync.when(
            loading: () => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
            error: (e, _) => SliverToBoxAdapter(
              child: ErrorRetryView(
                messageKu: ErrorRetryView.friendlyMessage(e),
                onRetry: () => ref.invalidate(pendingReviewsProvider),
              ),
            ),
            data: (list) {
              if (list.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(
                      child: Column(
                        children: [
                          Text('🎉', style: TextStyle(fontSize: 40)),
                          SizedBox(height: 8),
                          Text('Pêşniyarên bendewar tune ne.'),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                sliver: SliverList.separated(
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) => _PendingReviewCard(review: list[i]),
                ),
              );
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _accessDenied(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panela Nirxandinê')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🔒', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              Text(
                'Tenê rêveberî dikare vê panelê bibîne.',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () => context.canPop() ? context.pop() : context.go('/review'),
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Vegere'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  final ReviewStats stats;
  const _StatsCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            AppColors.accent.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hemûyî',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${stats.total} nirxandin',
            style: AppTypography.headingSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _StatTile(
                emoji: '⚠️',
                label: 'Bendewar',
                value: stats.pending,
                color: AppColors.accent,
              ),
              _divider(),
              _StatTile(
                emoji: '🎉',
                label: 'Pejirandî',
                value: stats.accepted,
                color: AppColors.success,
              ),
              _divider(),
              _StatTile(
                emoji: '❌',
                label: 'Redkirî',
                value: stats.dismissed,
                color: AppColors.errorSoft,
              ),
              _divider(),
              _StatTile(
                emoji: '👥',
                label: 'Pispor',
                value: stats.activeReviewers,
                color: AppColors.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _divider() => Container(
        width: 1,
        height: 36,
        color: AppColors.border,
      );
}

class _StatTile extends StatelessWidget {
  final String emoji;
  final String label;
  final int value;
  final Color color;

  const _StatTile({
    required this.emoji,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 2),
          Text(
            '$value',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _PendingReviewCard extends ConsumerStatefulWidget {
  final ContentReview review;
  const _PendingReviewCard({required this.review});

  @override
  ConsumerState<_PendingReviewCard> createState() =>
      _PendingReviewCardState();
}

class _PendingReviewCardState extends ConsumerState<_PendingReviewCard> {
  bool _saving = false;

  Future<void> _decide(ReviewStatus status) async {
    setState(() => _saving = true);
    try {
      await ref.read(contentReviewRepositoryProvider).updateStatus(
            reviewId: widget.review.id,
            status: status,
          );
      // Stream kendini günceller
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.review;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(r.status.emoji, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              Text(
                r.status.labelKu,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${r.contentType.labelKu} · ${r.level.toUpperCase()}',
                  style: TextStyle(
                    fontSize: 9,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                _formatDate(r.createdAt),
                style: AppTypography.caption.copyWith(
                  color: AppColors.textTertiary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Original
          _labeledBox(
            label: 'Orîjînal',
            text: r.originalText,
            color: AppColors.textSecondary,
          ),
          if (r.suggestedText != null) ...[
            const SizedBox(height: 6),
            _labeledBox(
              label: '💡 Pêşniyar',
              text: r.suggestedText!,
              color: AppColors.accent,
              highlight: true,
            ),
          ],
          if (r.note != null) ...[
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '📝 ${r.note}',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
          const SizedBox(height: 8),
          Text(
            '${r.reviewerEmail} · ${r.contentId}',
            style: AppTypography.caption.copyWith(
              color: AppColors.textTertiary,
              fontFamily: 'monospace',
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _saving
                      ? null
                      : () => _decide(ReviewStatus.dismissed),
                  icon: const Icon(Icons.close_rounded, size: 16),
                  label: const Text('Red bike'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.errorSoft,
                    side: BorderSide(color: AppColors.errorSoft),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _saving
                      ? null
                      : () => _decide(ReviewStatus.accepted),
                  icon: const Icon(Icons.check_rounded, size: 16),
                  label: const Text('Pejirîne'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _labeledBox({
    required String label,
    required String text,
    required Color color,
    bool highlight = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: highlight ? color.withValues(alpha: 0.08) : null,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 2),
          SelectableText(
            text,
            style: AppTypography.body.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) {
    final now = DateTime.now();
    final diff = now.difference(d);
    if (diff.inMinutes < 60) return '${diff.inMinutes} deq';
    if (diff.inHours < 24) return '${diff.inHours} st';
    return '${diff.inDays} roj';
  }
}
