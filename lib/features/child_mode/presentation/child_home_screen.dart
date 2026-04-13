import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/child_theme.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/providers/child_mode_provider.dart';
import 'widgets/star_display_widget.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Ana Ekran
//
// 7-10 yaş grubu için optimize edilmiş ana ekran.
// Büyük resimli ders kartları, yıldız ilerleme, maskot.
// ════════════════════════════════════════════════════════════════

class ChildHomeScreen extends ConsumerWidget {
  const ChildHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Başlık ────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Row(
                  children: [
                    // Maskot
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: ChildColors.primarySurface,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ChildColors.primary.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      child: const Center(
                        child: Text('🐐', style: TextStyle(fontSize: 28)),
                      ),
                    )
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .moveY(begin: 0, end: -4, duration: 1200.ms),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Silav, heval!',
                            style: ChildTypography.headline.copyWith(
                              color: ChildColors.primary,
                            ),
                          ),
                          Text(
                            'Karok bi te re ye',
                            style: ChildTypography.body.copyWith(
                              color: ChildColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Günlük Yıldız İlerleme ─────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ChildColors.accent.withOpacity(0.1),
                        ChildColors.starYellow.withOpacity(0.08),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
                    border: Border.all(
                      color: ChildColors.accent.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _DailyStat(
                        icon: '⭐',
                        value: '12',
                        label: 'Stêrk',
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: ChildColors.accent.withOpacity(0.2),
                      ),
                      _DailyStat(
                        icon: '📚',
                        value: '3',
                        label: 'Wane',
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: ChildColors.accent.withOpacity(0.2),
                      ),
                      _DailyStat(
                        icon: '🔥',
                        value: '5',
                        label: 'Roj',
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
            ),

            // ── Ders Başlığı ────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Text(
                  'Waneyên min',
                  style: ChildTypography.title,
                ),
              ),
            ),

            // ── Ders Kartları ───────────────────────────────
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList.builder(
                itemCount: _childLessons.length,
                itemBuilder: (context, index) {
                  final lesson = _childLessons[index];
                  final isLocked = index > 2; // İlk 3 ders açık
                  final delay = (200 + index * 100).ms;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _ChildLessonCard(
                      emoji: lesson.emoji,
                      titleKu: lesson.titleKu,
                      titleTr: lesson.titleTr,
                      stars: lesson.stars,
                      isLocked: isLocked,
                      onTap: isLocked
                          ? null
                          : () => context.go(
                              AppRoutes.childLesson,
                              extra: {
                                'lessonId': lesson.id,
                                'mode': 'child',
                              },
                            ),
                    ),
                  ).animate().fadeIn(delay: delay).slideX(begin: 0.05);
                },
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

// ── Günlük İstatistik ───────────────────────────────────────

class _DailyStat extends StatelessWidget {
  final String icon;
  final String value;
  final String label;

  const _DailyStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          value,
          style: ChildTypography.headline.copyWith(
            color: ChildColors.accent,
          ),
        ),
        Text(
          label,
          style: ChildTypography.caption.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}

// ── Çocuk Ders Kartı ────────────────────────────────────────

class _ChildLessonCard extends StatelessWidget {
  final String emoji;
  final String titleKu;
  final String titleTr;
  final int stars;
  final bool isLocked;
  final VoidCallback? onTap;

  const _ChildLessonCard({
    required this.emoji,
    required this.titleKu,
    required this.titleTr,
    required this.stars,
    required this.isLocked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isLocked
              ? Colors.grey.shade100
              : ChildColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
          border: Border.all(
            color: isLocked
                ? Colors.grey.shade300
                : ChildColors.primary.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: isLocked
              ? null
              : [
                  BoxShadow(
                    color: ChildColors.primary.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          children: [
            // Emoji büyük
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: isLocked
                    ? Colors.grey.shade200
                    : ChildColors.primarySurface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: isLocked
                    ? Icon(Icons.lock_rounded,
                        size: 28, color: Colors.grey.shade400)
                    : Text(emoji, style: const TextStyle(fontSize: 32)),
              ),
            ),
            const SizedBox(width: 16),

            // Başlıklar
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleKu,
                    style: ChildTypography.kurmanjiCard.copyWith(
                      color: isLocked ? Colors.grey : null,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    titleTr,
                    style: ChildTypography.caption.copyWith(
                      color: isLocked
                          ? Colors.grey.shade400
                          : ChildColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  if (!isLocked && stars > 0) ...[
                    const SizedBox(height: 6),
                    StarDisplay(count: stars, size: 20),
                  ],
                ],
              ),
            ),

            // Ok veya kilit
            Icon(
              isLocked
                  ? Icons.lock_outline_rounded
                  : Icons.arrow_forward_ios_rounded,
              size: 20,
              color: isLocked ? Colors.grey.shade400 : ChildColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Geçici ders verileri (Phase 2'de gerçek veriye geçecek) ──

class _ChildLessonData {
  final String id;
  final String emoji;
  final String titleKu;
  final String titleTr;
  final int stars;

  const _ChildLessonData({
    required this.id,
    required this.emoji,
    required this.titleKu,
    required this.titleTr,
    this.stars = 0,
  });
}

const _childLessons = [
  _ChildLessonData(
    id: 'child_a1_01',
    emoji: '👋',
    titleKu: 'Silav!',
    titleTr: 'Merhaba!',
    stars: 3,
  ),
  _ChildLessonData(
    id: 'child_a1_02',
    emoji: '👨‍👩‍👧‍👦',
    titleKu: 'Malbata min',
    titleTr: 'Ailem',
    stars: 2,
  ),
  _ChildLessonData(
    id: 'child_a1_03',
    emoji: '🎨',
    titleKu: 'Rengên min',
    titleTr: 'Renklerim',
    stars: 0,
  ),
  _ChildLessonData(
    id: 'child_a1_04',
    emoji: '🐱',
    titleKu: 'Heywanên malê',
    titleTr: 'Evcil hayvanlar',
  ),
  _ChildLessonData(
    id: 'child_a1_05',
    emoji: '🍎',
    titleKu: 'Em dixwin!',
    titleTr: 'Yemek yiyoruz!',
  ),
  _ChildLessonData(
    id: 'child_a1_06',
    emoji: '🔢',
    titleKu: 'Hejmartinê fêr bibe',
    titleTr: 'Sayı öğren',
  ),
  _ChildLessonData(
    id: 'child_a1_07',
    emoji: '🏫',
    titleKu: 'Li dibistanê',
    titleTr: 'Okulda',
  ),
  _ChildLessonData(
    id: 'child_a1_08',
    emoji: '⚽',
    titleKu: 'Lîstik!',
    titleTr: 'Oyun!',
  ),
];
