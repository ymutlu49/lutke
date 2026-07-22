import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/services/auth_service.dart';
import '../domain/content_source.dart';
import '../domain/review_models.dart';
import '../data/review_repository.dart';
import 'review_item_sheet.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Dil Uzmanı Review Hub Ekranı
//
// 10 dil uzmanı bu ekrana eriştiğinde:
//   1. İçerik türü seçer (kelime, quiz, diyalog vs.)
//   2. Seviye seçer (A1-C2, child)
//   3. Liste görür — her öğede kısa metin + review durumu
//   4. Öğeye tıklar → alt sayfa açılır → onay/öneri/red
//
// Owner (Prof. Dr. Yılmaz Mutlu) da buraya erişebilir.
// ════════════════════════════════════════════════════════════════

class ReviewHubScreen extends ConsumerStatefulWidget {
  const ReviewHubScreen({super.key});

  @override
  ConsumerState<ReviewHubScreen> createState() => _ReviewHubScreenState();
}

class _ReviewHubScreenState extends ConsumerState<ReviewHubScreen> {
  ReviewContentType _type = ReviewContentType.wordKu;
  String _level = 'A1';
  String _search = '';
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  static const _levelsByType = {
    ReviewContentType.wordKu: ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'],
    ReviewContentType.childWordKu: ['A1', 'A2'],
    ReviewContentType.exampleSentenceKu: ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'],
    ReviewContentType.quizKu: ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'],
    ReviewContentType.dialogueKu: ['A1', 'A2', 'B1', 'B2'],
    ReviewContentType.grammarKu: ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'],
    ReviewContentType.readingKu: ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'],
    ReviewContentType.culturalKu: ['all'],
    ReviewContentType.uiKu: ['ui'],
  };

  @override
  Widget build(BuildContext context) {
    final isReviewer = ref.watch(isReviewerProvider);
    if (!isReviewer) {
      return _accessDeniedScaffold(context);
    }

    final items = ContentSource.list(
      type: _type,
      level: _level,
      search: _search.isEmpty ? null : _search,
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        title: Row(
          children: [
            const Text('🔍', style: TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Text(
              'Review Hub',
              style: AppTypography.headingSmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.dashboard_outlined),
            tooltip: 'Panela rêveberiyê',
            onPressed: () {
              if (ref.read(isOwnerProvider)) {
                context.push('/review/panel');
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _filters(items.length),
          Expanded(
            child: items.isEmpty
                ? _emptyState()
                : ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, i) =>
                        _ReviewItemCard(item: items[i], contentType: _type),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _filters(int count) {
    final availableLevels = _levelsByType[_type] ?? const ['A1'];
    if (!availableLevels.contains(_level)) {
      _level = availableLevels.first;
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.md, 0, AppSpacing.md, AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kategori seçici (yatay scroll)
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: ReviewContentType.values.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final t = ReviewContentType.values[i];
                final isActive = t == _type;
                return GestureDetector(
                  onTap: () => setState(() => _type = t),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.primary
                          : AppColors.primarySurface,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: isActive
                            ? AppColors.primary
                            : AppColors.primary.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(t.emoji, style: const TextStyle(fontSize: 14)),
                        const SizedBox(width: 6),
                        Text(
                          t.labelKu,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color:
                                isActive ? Colors.white : AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          // Seviye chip'leri
          Row(
            children: [
              for (final lvl in availableLevels) ...[
                _LevelChip(
                  label: lvl.toUpperCase(),
                  isActive: lvl == _level,
                  onTap: () => setState(() => _level = lvl),
                ),
                const SizedBox(width: 6),
              ],
              const Spacer(),
              Text(
                '$count babet',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Arama
          TextField(
            controller: _searchCtrl,
            onChanged: (v) => setState(() => _search = v),
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search_rounded, size: 18),
              hintText: 'Li metnî bigere...',
              hintStyle: TextStyle(
                  color: AppColors.textTertiary, fontSize: 13),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: AppColors.primary.withValues(alpha: 0.2)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('📭', style: TextStyle(fontSize: 56)),
            const SizedBox(height: 16),
            Text(
              'Ji bo vê kategorî û astê naverok tune ye.',
              style: AppTypography.body.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              'Piştî ku naverok were zêdekirin, ê li vir xuya bibe.',
              style: AppTypography.caption.copyWith(
                color: AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _accessDeniedScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review Hub')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🔒', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              Text(
                'Ev rûpel tenê ji bo pisporên ziman e.',
                style: AppTypography.title.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                'Bi e-nameya xwe ya pispor têkeve.',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: () => context.canPop() ? context.pop() : context.go('/profile'),
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

class _LevelChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _LevelChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.accent
              : AppColors.accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: isActive ? Colors.white : AppColors.accent,
          ),
        ),
      ),
    );
  }
}

// ── Item kartı ──────────────────────────────────────────────────

class _ReviewItemCard extends ConsumerWidget {
  final ReviewableItem item;
  final ReviewContentType contentType;

  const _ReviewItemCard({required this.item, required this.contentType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final existingAsync = ref.watch(reviewsByContentProvider(
        (type: contentType, contentId: item.contentId)));

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _openReviewSheet(context, ref),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  item.level.toUpperCase(),
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.text,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (item.context != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        item.context!,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      item.contentId,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiary,
                        fontFamily: 'monospace',
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              existingAsync.when(
                loading: () => const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                error: (_, __) => const SizedBox.shrink(),
                data: (list) {
                  if (list.isEmpty) {
                    return Icon(Icons.chevron_right_rounded,
                        color: AppColors.textTertiary);
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${list.length} nirxandin',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openReviewSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ReviewItemSheet(item: item, contentType: contentType),
      ),
    );
  }
}
