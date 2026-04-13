import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/child_theme.dart';
import '../../domain/child_gamification.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Çıkartma Kitabı Widget'ı
//
// Çocuğun topladığı çıkartmaları görsel grid'de gösterir.
// Kazanılmamış çıkartmalar gri/kilitli görünür.
// ════════════════════════════════════════════════════════════════

class StickerBookWidget extends StatelessWidget {
  final List<Sticker> stickers;
  final Set<String> earnedIds;

  const StickerBookWidget({
    super.key,
    required this.stickers,
    required this.earnedIds,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Başlık
        Row(
          children: [
            const Text('🏷️', style: TextStyle(fontSize: 24)),
            const SizedBox(width: 8),
            Text(
              'Pirtûka Stîkeran',
              style: ChildTypography.title,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: ChildColors.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${earnedIds.length}/${stickers.length}',
                style: ChildTypography.label.copyWith(
                  color: ChildColors.accent,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Sticker Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: stickers.length,
          itemBuilder: (context, index) {
            final sticker = stickers[index];
            final isEarned = earnedIds.contains(sticker.id);

            return _StickerCell(
              sticker: sticker,
              isEarned: isEarned,
              index: index,
            );
          },
        ),
      ],
    );
  }
}

class _StickerCell extends StatelessWidget {
  final Sticker sticker;
  final bool isEarned;
  final int index;

  const _StickerCell({
    required this.sticker,
    required this.isEarned,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final widget = Container(
      decoration: BoxDecoration(
        color: isEarned
            ? ChildColors.backgroundSecondary
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isEarned
              ? ChildColors.starYellow.withOpacity(0.4)
              : Colors.grey.shade300,
        ),
        boxShadow: isEarned
            ? [
                BoxShadow(
                  color: ChildColors.starYellow.withOpacity(0.1),
                  blurRadius: 8,
                ),
              ]
            : null,
      ),
      child: Center(
        child: isEarned
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    sticker.emoji,
                    style: const TextStyle(fontSize: 28),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    sticker.nameKu,
                    style: const TextStyle(fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            : Icon(
                Icons.lock_rounded,
                size: 24,
                color: Colors.grey.shade400,
              ),
      ),
    );

    if (isEarned) {
      return widget
          .animate(delay: (index * 50).ms)
          .fadeIn()
          .scale(begin: const Offset(0.8, 0.8));
    }
    return widget;
  }
}

/// Yeni çıkartma kazanıldığında gösterilecek popup.
class StickerEarnedOverlay extends StatelessWidget {
  final Sticker sticker;
  final VoidCallback onDismiss;

  const StickerEarnedOverlay({
    super.key,
    required this.sticker,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDismiss,
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(48),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: ChildColors.backgroundSecondary,
              borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
              boxShadow: [
                BoxShadow(
                  color: ChildColors.starYellow.withOpacity(0.3),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Stîkera nû!',
                  style: ChildTypography.headline.copyWith(
                    color: ChildColors.accent,
                  ),
                ).animate().fadeIn(),

                const SizedBox(height: 24),

                Text(
                  sticker.emoji,
                  style: const TextStyle(fontSize: 72),
                )
                    .animate()
                    .scale(
                        begin: const Offset(0, 0),
                        curve: Curves.elasticOut,
                        duration: 800.ms),

                const SizedBox(height: 16),

                Text(
                  sticker.nameKu,
                  style: ChildTypography.title.copyWith(
                    color: ChildColors.primary,
                  ),
                ).animate().fadeIn(delay: 400.ms),

                Text(
                  sticker.nameTr,
                  style: ChildTypography.caption,
                ).animate().fadeIn(delay: 500.ms),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: onDismiss,
                  child: const Text('Baş e!'),
                ).animate().fadeIn(delay: 800.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
