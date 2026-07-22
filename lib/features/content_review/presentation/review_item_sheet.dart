import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/services/auth_service.dart';
import '../data/review_repository.dart';
import '../domain/review_models.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Review Item Bottom Sheet
//
// Dil uzmanı bir içeriği incelerken:
//   1. ✅ Qebûl — içerik doğru, dokunma
//   2. 💡 Pêşniyar — alternatif metin gir
//   3. ⚠️ Pirsgirêk — imla/anlam sorunu bildir
//
// Her review Firestore'a yazılır + geçmişi aynı sheet içinde gösterilir.
// ════════════════════════════════════════════════════════════════

class ReviewItemSheet extends ConsumerStatefulWidget {
  final ReviewableItem item;
  final ReviewContentType contentType;

  const ReviewItemSheet({
    super.key,
    required this.item,
    required this.contentType,
  });

  @override
  ConsumerState<ReviewItemSheet> createState() => _ReviewItemSheetState();
}

class _ReviewItemSheetState extends ConsumerState<ReviewItemSheet> {
  final _suggestCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  ReviewStatus _selected = ReviewStatus.approved;
  bool _saving = false;
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    _suggestCtrl.text = widget.item.text; // seed with original
  }

  @override
  void dispose() {
    _suggestCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _saving = true);

    try {
      final repo = ref.read(contentReviewRepositoryProvider);
      final user = ref.read(currentUserProvider);
      final uid = user?.uid ?? 'anonymous';
      final email = user?.email ?? 'unknown@lutke.app';

      final review = ContentReview(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        contentType: widget.contentType,
        contentId: widget.item.contentId,
        originalText: widget.item.text,
        contextText: widget.item.context,
        level: widget.item.level,
        status: _selected,
        suggestedText: _selected == ReviewStatus.suggested
            ? _suggestCtrl.text.trim()
            : null,
        note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
        reviewerUid: uid,
        reviewerEmail: email,
        createdAt: DateTime.now(),
      );

      await repo.add(review);

      if (!mounted) return;
      setState(() {
        _saving = false;
        _saved = true;
      });
      await Future.delayed(const Duration(milliseconds: 900));
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Çewtî: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_saved) return _successView();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _header(),
            const SizedBox(height: AppSpacing.md),
            _originalBox(),
            const SizedBox(height: AppSpacing.md),
            _statusSelector(),
            const SizedBox(height: AppSpacing.md),
            if (_selected == ReviewStatus.suggested) _suggestField(),
            _noteField(),
            const SizedBox(height: AppSpacing.md),
            _historyPreview(),
            const SizedBox(height: AppSpacing.lg),
            _submitBar(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(widget.contentType.emoji,
              style: const TextStyle(fontSize: 20)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.contentType.labelKu,
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '${widget.item.level.toUpperCase()} · ${widget.item.contentId}',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _originalBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.format_quote_rounded,
                  size: 16, color: AppColors.primary),
              const SizedBox(width: 4),
              Text(
                'Metna esasî',
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          SelectableText(
            widget.item.text,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
          if (widget.item.context != null) ...[
            const SizedBox(height: 6),
            Text(
              widget.item.context!,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _statusSelector() {
    final options = [
      (ReviewStatus.approved, 'Metn rast e, ti guhertin ne pêwîst'),
      (ReviewStatus.suggested, 'Min alternatîvek tê ser pêşniyar bikim'),
      (ReviewStatus.flagged, 'Pirsgirêkek heye (îmla, wate, telafûz)'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nirxandin',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        for (final (status, desc) in options)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => setState(() => _selected = status),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _selected == status
                      ? AppColors.primary.withValues(alpha: 0.08)
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _selected == status
                        ? AppColors.primary
                        : AppColors.border,
                    width: _selected == status ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Text(status.emoji, style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            status.labelKu,
                            style: AppTypography.body.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            desc,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Radio<ReviewStatus>(
                      value: status,
                      groupValue: _selected,
                      onChanged: (v) => setState(() => _selected = v!),
                      activeColor: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _suggestField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pêşniyara te',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _suggestCtrl,
            maxLines: 3,
            minLines: 2,
            style: AppTypography.body.copyWith(color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Metna alternatîf...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _noteField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _selected == ReviewStatus.flagged
              ? 'Pirsgirêk çi ye?'
              : 'Not (opsîyonel)',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: _noteCtrl,
          maxLines: 2,
          style: AppTypography.body.copyWith(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: _selected == ReviewStatus.flagged
                ? 'Nimûne: "xetayeke îmlayê heye"'
                : 'Zêdeyî şîroveyê...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  Widget _historyPreview() {
    final async = ref.watch(reviewsByContentProvider(
        (type: widget.contentType, contentId: widget.item.contentId)));

    return async.when(
      loading: () => const SizedBox(height: 0),
      error: (_, __) => const SizedBox.shrink(),
      data: (list) {
        if (list.isEmpty) return const SizedBox.shrink();
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${list.length} review berê hate nivîsandin',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              for (final r in list.take(3)) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r.status.emoji,
                          style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          r.suggestedText ?? r.note ?? r.status.labelKu,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        _formatDate(r.createdAt),
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textTertiary,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime d) {
    final now = DateTime.now();
    final diff = now.difference(d);
    if (diff.inMinutes < 60) return '${diff.inMinutes}d';
    if (diff.inHours < 24) return '${diff.inHours}st';
    return '${diff.inDays}r';
  }

  Widget _submitBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
          child: const Text('Navêre'),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: _saving ? null : _submit,
          icon: _saving
              ? const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
              : const Icon(Icons.send_rounded, size: 16),
          label: Text(_saving ? 'Hûrdibe...' : 'Bişîne'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _successView() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('✅', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text(
            'Review hat tomarkirin!',
            style: AppTypography.title.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Spas ji bo piştgiriya te.',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
