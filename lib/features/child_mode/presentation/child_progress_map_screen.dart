import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/child_theme.dart';
import 'widgets/star_display_widget.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — İlerleme Haritası
//
// Masa oyunu tarzı görsel yol. Her düğüm bir ders.
// Tamamlanan düğümler yıldız gösterir.
// Mevcut düğüm nabız atar.
// Gelecek düğümler gri/kilitli.
// ════════════════════════════════════════════════════════════════

class ChildProgressMapScreen extends StatelessWidget {
  const ChildProgressMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rêya Fêrbûnê'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Başlangıç maskotu
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: ChildColors.primarySurface,
                shape: BoxShape.circle,
                border: Border.all(color: ChildColors.primary, width: 2),
              ),
              child: const Center(
                child: Text('🐐', style: TextStyle(fontSize: 36)),
              ),
            ).animate().scale(
                begin: const Offset(0.5, 0.5),
                curve: Curves.elasticOut,
                duration: 600.ms),

            // Yol düğümleri
            for (var i = 0; i < _mapNodes.length; i++) ...[
              _PathConnector(isCompleted: i < 3),
              _MapNode(
                node: _mapNodes[i],
                index: i,
                isCompleted: i < 3,
                isCurrent: i == 3,
                isLocked: i > 3,
              ),
            ],

            _PathConnector(isCompleted: false),

            // Hedef
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade400, width: 2),
              ),
              child: const Center(
                child: Text('🏆', style: TextStyle(fontSize: 36)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapNode extends StatelessWidget {
  final _NodeData node;
  final int index;
  final bool isCompleted;
  final bool isCurrent;
  final bool isLocked;

  const _MapNode({
    required this.node,
    required this.index,
    required this.isCompleted,
    required this.isCurrent,
    required this.isLocked,
  });

  @override
  Widget build(BuildContext context) {
    final delay = (200 + index * 150).ms;

    Widget nodeWidget = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isLocked
            ? Colors.grey.shade100
            : isCompleted
                ? ChildColors.success.withOpacity(0.08)
                : isCurrent
                    ? ChildColors.primarySurface
                    : ChildColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
        border: Border.all(
          color: isLocked
              ? Colors.grey.shade300
              : isCompleted
                  ? ChildColors.success.withOpacity(0.3)
                  : isCurrent
                      ? ChildColors.primary
                      : ChildColors.primary.withOpacity(0.15),
          width: isCurrent ? 2.5 : 1.5,
        ),
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: ChildColors.primary.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          // Emoji
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: isLocked
                  ? Colors.grey.shade200
                  : ChildColors.primarySurface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: isLocked
                  ? Icon(Icons.lock_rounded,
                      size: 24, color: Colors.grey.shade400)
                  : Text(node.emoji, style: const TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(width: 14),

          // Başlık + yıldızlar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  node.titleKu,
                  style: ChildTypography.kurmanjiCard.copyWith(
                    fontSize: 18,
                    color: isLocked ? Colors.grey : null,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  node.titleTr,
                  style: TextStyle(
                    fontSize: 13,
                    color: isLocked
                        ? Colors.grey.shade400
                        : ChildColors.textSecondary,
                  ),
                ),
                if (isCompleted) ...[
                  const SizedBox(height: 6),
                  StarDisplay(count: node.stars, size: 18),
                ],
              ],
            ),
          ),

          // Durum ikonu
          if (isCompleted)
            const Icon(Icons.check_circle_rounded,
                color: ChildColors.success, size: 24)
          else if (isCurrent)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: ChildColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.play_arrow_rounded,
                  color: Colors.white, size: 20),
            ),
        ],
      ),
    );

    if (isCurrent) {
      nodeWidget = nodeWidget
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.01, 1.01),
              duration: 1500.ms);
    }

    return nodeWidget.animate().fadeIn(delay: delay).slideX(
        begin: index.isEven ? -0.05 : 0.05);
  }
}

class _PathConnector extends StatelessWidget {
  final bool isCompleted;

  const _PathConnector({required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 32,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isCompleted
            ? ChildColors.success.withOpacity(0.4)
            : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _NodeData {
  final String emoji;
  final String titleKu;
  final String titleTr;
  final int stars;

  const _NodeData(this.emoji, this.titleKu, this.titleTr, [this.stars = 0]);
}

const _mapNodes = [
  _NodeData('👋', 'Silav!', 'Merhaba!', 3),
  _NodeData('👨‍👩‍👧‍👦', 'Malbata min', 'Ailem', 2),
  _NodeData('🎨', 'Rengên min', 'Renklerim', 1),
  _NodeData('🐱', 'Heywanên malê', 'Hayvanlar'),
  _NodeData('🍎', 'Em dixwin!', 'Yemek yiyoruz!'),
  _NodeData('🔢', 'Hejmartinê', 'Sayılar'),
  _NodeData('🏫', 'Li dibistanê', 'Okulda'),
  _NodeData('⚽', 'Lîstik!', 'Oyun!'),
];
