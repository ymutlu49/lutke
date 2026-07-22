import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/child_theme.dart';
import '../../../core/router/app_router.dart';
import '../../gamification/gamification_provider.dart';
import '../domain/bizer_evolution.dart';
import 'widgets/bizer_evolution_card.dart';
import 'widgets/daily_challenge_card.dart';
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
                            'Karîk bi te re ye',
                            style: ChildTypography.body.copyWith(
                              color: ChildColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // TrackSwitchChip kaldırıldı — track değişimi Profile'dan
                  ],
                ),
              ),
            ),

            // ── Günlük Yıldız İlerleme (CANLI VERİ) ──────────
            // Önceden hardcoded '12/3/5' görünüyordu; artık gamification +
            // karîk evolution provider'larından okur.
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Consumer(
                  builder: (context, ref, _) {
                    final gam = ref.watch(gamificationProvider);
                    final karik = ref.watch(karikEvolutionProvider);
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ChildColors.accent.withOpacity(0.1),
                            ChildColors.starYellow.withOpacity(0.08),
                          ],
                        ),
                        borderRadius:
                            BorderRadius.circular(ChildSpacing.radiusLg),
                        border: Border.all(
                          color: ChildColors.accent.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _DailyStat(
                            icon: '⭐',
                            value: '${karik.totalStars}',
                            label: 'Stêrk',
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: ChildColors.accent.withOpacity(0.2),
                          ),
                          _DailyStat(
                            icon: '📚',
                            value: '${gam.totalWordsLearned}',
                            label: 'Peyv',
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: ChildColors.accent.withOpacity(0.2),
                          ),
                          _DailyStat(
                            icon: '🔥',
                            value:
                                '${gam.weeklyRhythm.activeDayCount}',
                            label: 'Roj',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
            ),

            // ── Karîk Evolution Kartı ────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
                child: const KarikEvolutionCard(),
              ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.1),
            ),

            // ── Günlük Meydan Okuma Kartı ────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
                child: const DailyChallengeCard(),
              ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
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
                  final isLocked = false; // Tüm dersler açık
                  final delay = (200 + index * 100).ms;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _ChildLessonCard(
                      emoji: lesson.emoji,
                      titleKu: lesson.titleKu,
                      titleTr: lesson.titleTr,
                      stars: lesson.stars,
                      isLocked: isLocked,
                      cardColor: ChildColors.categoryColor(lesson.category),
                      onTap: () => context.push(
                        AppRoutes.childUnitHub,
                        extra: {
                          'category': lesson.category,
                          'titleKu': lesson.titleKu,
                          'titleTr': lesson.titleTr,
                          'emoji': lesson.emoji,
                          'level': lesson.level,
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
  final Color cardColor;
  final VoidCallback? onTap;

  const _ChildLessonCard({
    required this.emoji,
    required this.titleKu,
    required this.titleTr,
    required this.stars,
    required this.isLocked,
    required this.cardColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: isLocked
              ? null
              : LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    cardColor.withOpacity(0.14),
                    cardColor.withOpacity(0.04),
                  ],
                ),
          color: isLocked ? Colors.grey.shade100 : null,
          borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
          border: Border.all(
            color: isLocked
                ? Colors.grey.shade300
                : cardColor.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: isLocked
              ? null
              : [
                  BoxShadow(
                    color: cardColor.withOpacity(0.15),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: Row(
          children: [
            // Emoji — gradient container ile canlı
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                gradient: isLocked
                    ? null
                    : LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          cardColor.withOpacity(0.2),
                          cardColor.withOpacity(0.06),
                        ],
                      ),
                color: isLocked ? Colors.grey.shade200 : null,
                borderRadius: BorderRadius.circular(20),
                border: isLocked
                    ? null
                    : Border.all(color: cardColor.withOpacity(0.15)),
              ),
              child: Center(
                child: isLocked
                    ? Icon(Icons.lock_rounded,
                        size: 28, color: Colors.grey.shade400)
                    : Text(emoji, style: const TextStyle(fontSize: 42)),
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
                      color: isLocked ? Colors.grey : cardColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    titleTr,
                    style: ChildTypography.caption.copyWith(
                      color: isLocked
                          ? Colors.grey.shade400
                          : ChildColors.textSecondary,
                      fontSize: 15,
                    ),
                  ),
                  if (!isLocked && stars > 0) ...[
                    const SizedBox(height: 6),
                    StarDisplay(count: stars, size: 22),
                  ],
                ],
              ),
            ),

            // Ok — renkli daire içinde
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isLocked
                    ? Colors.grey.shade200
                    : cardColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isLocked
                    ? Icons.lock_outline_rounded
                    : Icons.arrow_forward_ios_rounded,
                size: 16,
                color: isLocked ? Colors.grey.shade400 : cardColor,
              ),
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
  final String category;
  // A1/A2 seçimi: Laş & Hest A2 DB'sinde. Default: A1.
  final String level;
  final int stars;

  const _ChildLessonData({
    required this.id,
    required this.emoji,
    required this.titleKu,
    required this.titleTr,
    required this.category,
    this.level = 'A1',
    this.stars = 0,
  });
}

const _childLessons = [
  // ── A1 dersler (kChildA1Kelimeler DB'siyle birebir uyumlu kategoriler) ──
  // DB: silav(12), malbat(6), reng(6), heywan(6), xwarin(6), hejmar(10),
  //     dibistan(9), listik(6)
  _ChildLessonData(
    id: 'child_a1_01',
    emoji: '👋',
    titleKu: 'Silav!',
    titleTr: 'Merhaba!',
    category: 'silav',
    level: 'A1',
    stars: 0,
  ),
  _ChildLessonData(
    id: 'child_a1_02',
    emoji: '👨‍👩‍👧‍👦',
    titleKu: 'Malbata min',
    titleTr: 'Ailem',
    category: 'malbat',
    level: 'A1',
    stars: 0,
  ),
  _ChildLessonData(
    id: 'child_a1_03',
    emoji: '🎨',
    titleKu: 'Rengên min',
    titleTr: 'Renklerim',
    category: 'reng',
    level: 'A1',
    stars: 0,
  ),
  _ChildLessonData(
    id: 'child_a1_04',
    emoji: '🐱',
    titleKu: 'Heywan',
    titleTr: 'Hayvanlar',
    category: 'heywan',
    level: 'A1',
  ),
  _ChildLessonData(
    id: 'child_a1_05',
    emoji: '🍎',
    titleKu: 'Xwarin',
    titleTr: 'Yiyecekler',
    category: 'xwarin',
    level: 'A1',
  ),
  _ChildLessonData(
    id: 'child_a1_06',
    emoji: '🔢',
    titleKu: 'Hejmar',
    titleTr: 'Sayılar',
    category: 'hejmar',
    level: 'A1',
  ),
  _ChildLessonData(
    id: 'child_a1_07',
    emoji: '🏫',
    titleKu: 'Dibistan',
    titleTr: 'Okul',
    category: 'dibistan',
    level: 'A1',
  ),
  _ChildLessonData(
    id: 'child_a1_08',
    emoji: '⚽',
    titleKu: 'Lîstik!',
    titleTr: 'Oyun!',
    category: 'listik',
    level: 'A1',
  ),
  // ── A2 dersler (kChildA2Kelimeler DB: fiil, hest, las, xweza) ──
  _ChildLessonData(
    id: 'child_a2_01',
    emoji: '🧍',
    titleKu: 'Laş',
    titleTr: 'Vücut',
    category: 'las',
    level: 'A2',
  ),
  _ChildLessonData(
    id: 'child_a2_02',
    emoji: '😊',
    titleKu: 'Hest',
    titleTr: 'Duygular',
    category: 'hest',
    level: 'A2',
  ),
];
