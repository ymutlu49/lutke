import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/child_theme.dart';
import '../../../shared/providers/learning_track_provider.dart';
import '../../en_learning/domain/en_child_a1_kelime_db.dart';
import '../../en_learning/domain/en_child_a2_kelime_db.dart';
import '../../lessons/domain/child_a1_kelime_db.dart';
import '../../lessons/domain/child_a2_kelime_db.dart';
import 'widgets/mascot_widget.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Çocuk UnitHub Ekranı
//
// Çocuklara özel etkinlik seçim ekranı.
// Yetişkin UnitHub yerine: daha az etkinlik, daha büyük butonlar,
// canlı renkler, maskot teşviki.
// ════════════════════════════════════════════════════════════════

class ChildUnitHubScreen extends ConsumerWidget {
  final String category;
  final String titleKu;
  final String titleTr;
  final String emoji;
  final String level;

  const ChildUnitHubScreen({
    super.key,
    required this.category,
    this.titleKu = '',
    this.titleTr = '',
    this.emoji = '📚',
    this.level = 'A1',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEn = ref.watch(currentTrackProvider).isEnglish;
    final words = _loadCategoryWords(category, level, isEn: isEn);
    final catColor = ChildColors.categoryColor(category);

    return Scaffold(
      backgroundColor: ChildColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // ── Üst bar ──────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.canPop() ? context.pop() : context.go('/child/home'),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: catColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back_rounded,
                          size: 22, color: catColor),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    isEn ? '${words.length} words' : '${words.length} peyv',
                    style: ChildTypography.label.copyWith(
                      color: catColor,
                    ),
                  ),
                ],
              ),
            ),

            // ── Başlık + Maskot ──────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Column(
                children: [
                  // Emoji büyük
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          catColor.withOpacity(0.2),
                          catColor.withOpacity(0.06),
                        ],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: catColor.withOpacity(0.25),
                        width: 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: catColor.withOpacity(0.15),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(emoji,
                          style: const TextStyle(fontSize: 44)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    titleKu,
                    style: ChildTypography.headline.copyWith(
                      color: catColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (titleTr.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(titleTr,
                        style: ChildTypography.caption),
                  ],
                  const SizedBox(height: 12),
                  // Maskot teşvik mesajı
                  MascotWidget(
                    state: MascotState.wave,
                    size: 56,
                    message: isEn ? "Let's learn together!" : 'Ka em fêr bibin!',
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms),

            const SizedBox(height: 20),

            // ── Etkinlik Kartları (2x2 grid) ─────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _ChildActivityCard(
                            emoji: '📝',
                            titleKu: isEn ? 'Quiz' : 'Ceribandin',
                            color: ChildColors.primary,
                            onTap: () => context.push(
                              '/activity/quiz',
                              extra: {'level': level, 'category': category},
                            ),
                          ).animate().fadeIn(delay: 100.ms)
                              .scale(begin: const Offset(0.9, 0.9), duration: 300.ms),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _ChildActivityCard(
                            emoji: '🃏',
                            titleKu: isEn ? 'Flashcards' : 'Peld',
                            color: ChildColors.accent,
                            onTap: () => context.push(
                              '/activity/flashcard',
                              extra: {
                                'category': category,
                                'level': level,
                                'isChildMode': true,
                              },
                            ),
                          ).animate().fadeIn(delay: 200.ms)
                              .scale(begin: const Offset(0.9, 0.9), duration: 300.ms),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _ChildActivityCard(
                            emoji: '🔊',
                            titleKu: isEn ? 'Listen' : 'Guhdarêkirin',
                            color: const Color(0xFF2196F3),
                            onTap: () => context.push(
                              '/activity/listening',
                              extra: {'category': category, 'level': level},
                            ),
                          ).animate().fadeIn(delay: 300.ms)
                              .scale(begin: const Offset(0.9, 0.9), duration: 300.ms),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _ChildActivityCard(
                            emoji: '🖼️',
                            titleKu: isEn ? 'Picture match' : 'Wêne',
                            color: ChildColors.stickerPurple,
                            onTap: () => context.push(
                              '/activity/word-match',
                              extra: {'category': category, 'level': level},
                            ),
                          ).animate().fadeIn(delay: 400.ms)
                              .scale(begin: const Offset(0.9, 0.9), duration: 300.ms),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // ── Çîrok (Hikaye) — 3. sıra, tek geniş kart ──
                    _ChildActivityCard(
                      emoji: '📖',
                      titleKu: isEn ? 'Story' : 'Çîrok',
                      color: const Color(0xFFFF7043),
                      onTap: () => context.push(
                        '/home/story',
                        extra: {'level': level, 'category': category},
                      ),
                    ).animate().fadeIn(delay: 500.ms)
                        .scale(begin: const Offset(0.9, 0.9), duration: 300.ms),

                    const SizedBox(height: 28),

                    // ── Kelime Önizleme ──────────────────
                    if (words.isNotEmpty) ...[
                      Row(
                        children: [
                          Text(
                            isEn ? 'Words in this unit' : 'Peyvên vê beşê',
                            style: ChildTypography.label.copyWith(
                              color: ChildColors.textSecondary,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            isEn
                                ? '${words.length} words'
                                : '${words.length} peyv',
                            style: ChildTypography.caption,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Yatay kaydırılabilir kelime chip'leri
                      SizedBox(
                        height: 52,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: words.length.clamp(0, 12),
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 10),
                          itemBuilder: (_, i) {
                            final w = words[i];
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    catColor.withOpacity(0.12),
                                    catColor.withOpacity(0.04),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: catColor.withOpacity(0.15)),
                              ),
                              child: Center(
                                child: Text(
                                  w.ku,
                                  style: ChildTypography.label.copyWith(
                                    color: catColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
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

  List<_SimpleWord> _loadCategoryWords(
    String category,
    String level, {
    bool isEn = false,
  }) {
    // Track-aware: EN child → en_child_aX_kelime_db, KU child → child_aX.
    // Level belirtilmişse o seviyeye bak; yoksa A1+A2 birleşir.
    if (isEn) {
      final pool = level == 'A2'
          ? [...kEnChildA1Liste, ...kEnChildA2Liste]
          : kEnChildA1Liste;
      return pool
          .where((w) => w.kat == category)
          .map((w) => _SimpleWord(w.en, w.ku))
          .toList();
    }
    final pool = level == 'A2'
        ? [...kChildA1Kelimeler, ...kChildA2Kelimeler]
        : kChildA1Kelimeler as List;
    return pool
        .where((w) => w.kat == category)
        .map((w) => _SimpleWord(w.ku as String, w.tr as String))
        .toList();
  }
}

class _SimpleWord {
  final String ku;
  final String tr;
  const _SimpleWord(this.ku, this.tr);
}

// ── Çocuk Etkinlik Kartı ───────────────────────────────────

class _ChildActivityCard extends StatelessWidget {
  final String emoji;
  final String titleKu;
  final Color color;
  final VoidCallback onTap;

  const _ChildActivityCard({
    required this.emoji,
    required this.titleKu,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.15),
              color.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
          border: Border.all(color: color.withOpacity(0.25), width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.12),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 32)),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              titleKu,
              style: ChildTypography.label.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
