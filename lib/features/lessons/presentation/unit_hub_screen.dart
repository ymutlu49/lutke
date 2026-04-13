import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/providers/language_mode_provider.dart';
import '../domain/a1_kelime_db.dart';
import '../domain/a2_kelime_db.dart';

// ════════════════════════════════════════════════════════════════
// BİRİM HUB EKRANI — Durak tıklandığında açılır
//
// Kategorinin tüm kelimelerini gösterir + farklı etkinlik
// türlerine erişim sağlar:
//   - Quiz (çoktan seçmeli)
//   - Flashcard (kelime kartları)
//   - Dinleme (ses + seçim)
//   - Cümle kurma (sıralama)
//   - Kelime eşleştirme
// ════════════════════════════════════════════════════════════════

class UnitHubScreen extends ConsumerWidget {
  final String category;
  final String titleKu;
  final String titleTr;
  final IconData icon;
  final int wordCount;

  const UnitHubScreen({
    super.key,
    required this.category,
    required this.titleKu,
    this.titleTr = '',
    this.icon = Icons.menu_book_rounded,
    this.wordCount = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showTr = ref.watch(showTurkishProvider);

    // Kategorideki kelimeleri yükle
    final words = _loadCategoryWords(category);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // ── Üst bar ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back_rounded,
                          size: 20, color: AppColors.textSecondary),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${words.length} peyv',
                    style: AppTypography.label
                        .copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),

            // ── Başlık ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColors.primary.withOpacity(0.2)),
                    ),
                    child: Icon(icon, size: 36, color: AppColors.primary),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    titleKu,
                    style: AppTypography.headline
                        .copyWith(color: AppColors.primary),
                  ),
                  if (showTr && titleTr.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(titleTr,
                        style: AppTypography.translation),
                  ],
                ],
              ),
            ).animate().fadeIn(duration: 300.ms),

            const SizedBox(height: 24),

            // ── Etkinlik Kartları ─────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _ActivityCard(
                      emoji: '📝',
                      titleKu: 'Quiz',
                      descKu: 'Peyvan biceribîne',
                      descTr: 'Kelimeleri test et',
                      showTr: showTr,
                      color: AppColors.primary,
                      onTap: () => context.push(
                        AppRoutes.quiz,
                        extra: {'level': 'A1', 'category': category},
                      ),
                    ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.05),

                    const SizedBox(height: 14),

                    _ActivityCard(
                      emoji: '🃏',
                      titleKu: 'Flashcard',
                      descKu: 'Kartên peyvan',
                      descTr: 'Kelime kartları',
                      showTr: showTr,
                      color: AppColors.accent,
                      onTap: () => context.push(AppRoutes.flashcard, extra: {'category': category}),
                    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.05),

                    const SizedBox(height: 14),

                    _ActivityCard(
                      emoji: '🔊',
                      titleKu: 'Guhdarîkirin',
                      descKu: 'Guh bide û hilbijêre',
                      descTr: 'Dinle ve seç',
                      showTr: showTr,
                      color: const Color(0xFF2196F3),
                      onTap: () => context.push(AppRoutes.listening, extra: {'category': category}),
                    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.05),

                    const SizedBox(height: 14),

                    _ActivityCard(
                      emoji: '🧩',
                      titleKu: 'Hevoka çêke',
                      descKu: 'Peyvan bi rêz bike',
                      descTr: 'Cümle kur',
                      showTr: showTr,
                      color: const Color(0xFF9C27B0),
                      onTap: () => context.push(AppRoutes.sentenceBuilder, extra: {'category': category}),
                    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.05),

                    const SizedBox(height: 14),

                    _ActivityCard(
                      emoji: '🔗',
                      titleKu: 'Lihevhatin',
                      descKu: 'Peyv û wateyan li hev bîne',
                      descTr: 'Kelime eşleştir',
                      showTr: showTr,
                      color: const Color(0xFFFF5722),
                      onTap: () => context.push(AppRoutes.wordMatch, extra: {'category': category}),
                    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.05),

                    const SizedBox(height: 24),

                    // ── Kelime Önizleme ──────────────────────
                    if (words.isNotEmpty) ...[
                      Row(
                        children: [
                          Text(
                            'Peyvên vê beşê',
                            style: AppTypography.label.copyWith(
                                color: AppColors.textSecondary),
                          ),
                          const Spacer(),
                          Text(
                            '${words.length} peyv',
                            style: AppTypography.caption,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...words.take(8).map((w) => _WordPreviewRow(
                            ku: w.ku,
                            tr: showTr ? w.tr : null,
                          )),
                      if (words.length > 8) ...[
                        const SizedBox(height: 8),
                        Text(
                          '+${words.length - 8} peyvên din...',
                          style: AppTypography.caption,
                        ),
                      ],
                    ],

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<_SimpleWord> _loadCategoryWords(String category) {
    final all = [...kA1TamKelimeler, ...kA2Kelimeler];
    return all
        .where((w) => w.kat == category)
        .map((w) => _SimpleWord(w.ku, w.tr))
        .toList();
  }
}

class _SimpleWord {
  final String ku;
  final String tr;
  const _SimpleWord(this.ku, this.tr);
}

// ── Etkinlik Kartı ──────────────────────────────────────────

class _ActivityCard extends StatelessWidget {
  final String emoji;
  final String titleKu;
  final String descKu;
  final String descTr;
  final bool showTr;
  final Color color;
  final VoidCallback onTap;

  const _ActivityCard({
    required this.emoji,
    required this.titleKu,
    required this.descKu,
    required this.descTr,
    required this.showTr,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.15)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 26)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleKu,
                    style: AppTypography.title.copyWith(
                      color: color,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    showTr ? descTr : descKu,
                    style: AppTypography.caption.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 16, color: color.withOpacity(0.4)),
          ],
        ),
      ),
    );
  }
}

// ── Kelime Önizleme Satırı ──────────────────────────────────

class _WordPreviewRow extends StatelessWidget {
  final String ku;
  final String? tr;

  const _WordPreviewRow({required this.ku, this.tr});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.4),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            ku,
            style: AppTypography.kurmanjiCard.copyWith(fontSize: 16),
          ),
          if (tr != null) ...[
            const SizedBox(width: 8),
            Text(
              '— $tr',
              style: AppTypography.translation.copyWith(fontSize: 13),
            ),
          ],
        ],
      ),
    );
  }
}
