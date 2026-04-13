import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/child_theme.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Yıldız Gösterge Widget'ı
//
// Ders doğruluk oranına göre 1-3 yıldız gösterir.
//   < 50%: 1 yıldız
//   50-90%: 2 yıldız
//   90%+: 3 yıldız
// ════════════════════════════════════════════════════════════════

class StarDisplay extends StatelessWidget {
  final int count; // 0-3
  final double size;
  final bool animated;

  const StarDisplay({
    super.key,
    required this.count,
    this.size = 24,
    this.animated = false,
  });

  /// Doğruluk oranından yıldız sayısı hesapla.
  factory StarDisplay.fromAccuracy({
    Key? key,
    required double accuracy,
    double size = 24,
    bool animated = false,
  }) {
    final stars = accuracy >= 0.9 ? 3 : (accuracy >= 0.5 ? 2 : (accuracy > 0 ? 1 : 0));
    return StarDisplay(key: key, count: stars, size: size, animated: animated);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        final isFilled = i < count;
        final star = Icon(
          isFilled ? Icons.star_rounded : Icons.star_border_rounded,
          size: size,
          color: isFilled ? ChildColors.starYellow : ChildColors.starEmpty,
        );

        if (animated && isFilled) {
          return star
              .animate(delay: (200 * i).ms)
              .scale(begin: const Offset(0, 0), end: const Offset(1, 1),
                  curve: Curves.elasticOut, duration: 600.ms);
        }
        return star;
      }),
    );
  }
}

/// Büyük yıldız gösterimi — ders tamamlama ekranı için.
class StarCelebration extends StatelessWidget {
  final int stars;

  const StarCelebration({super.key, required this.stars});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StarDisplay(count: stars, size: 48, animated: true),
        const SizedBox(height: 12),
        Text(
          switch (stars) {
            3 => 'Pirr baş! ⭐',
            2 => 'Baş e! 👏',
            1 => 'Destpêkek baş!',
            _ => 'Dîsa biceribîne!',
          },
          style: ChildTypography.headline.copyWith(
            color: stars >= 2 ? ChildColors.accent : ChildColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
