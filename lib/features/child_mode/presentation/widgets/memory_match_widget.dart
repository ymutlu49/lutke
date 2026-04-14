import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/child_theme.dart';
import '../../../../core/utils/fsrs_algorithm.dart';
import '../../../lessons/domain/entities/exercise.dart';
import '../../../exercises/presentation/exercise_dispatcher.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Lîstika Bîranînê (Memory Match)
//
// Klasik hafıza oyunu: 4-6 emoji-kelime çifti grid'e karıştırılmış
// şekilde yerleştirilir (8-12 kart). Çocuk 2 kart açar:
//   - Eşleşirse kartlar açık kalır (yeşil)
//   - Eşleşmezse kısa süre sonra kapanır
// Tüm çiftler bulununca oyun tamamlanır.
//
// Pedagoji: yazı/motor yükü yok → disleksi ve 7-10 yaş ideal.
// Çalıştırdığı beceriler: dikkat, görsel-sözlü ilişki, çalışma belleği.
// ════════════════════════════════════════════════════════════════

class MemoryMatchWidget extends StatefulWidget {
  final MemoryMatchExercise exercise;
  final OnRatingCallback onRating;

  const MemoryMatchWidget({
    super.key,
    required this.exercise,
    required this.onRating,
  });

  @override
  State<MemoryMatchWidget> createState() => _MemoryMatchWidgetState();
}

/// Tek bir kart — emoji yüzü veya kelime yüzü
class _MemoryCard {
  final int pairId;        // Hangi çifte ait
  final String content;    // Gösterilecek içerik (emoji veya kelime)
  final bool isEmoji;      // True = emoji kartı, False = kelime kartı

  _MemoryCard({
    required this.pairId,
    required this.content,
    required this.isEmoji,
  });
}

class _MemoryMatchWidgetState extends State<MemoryMatchWidget> {
  late List<_MemoryCard> _cards;
  final Set<int> _flipped = {};   // Şu an açık olan kart indeksleri
  final Set<int> _matched = {};   // Eşleşmiş kart indeksleri (kalıcı açık)
  int _attempts = 0;              // Deneme sayısı
  bool _isChecking = false;       // İki kart açık, eşleşme kontrolü var

  @override
  void initState() {
    super.initState();
    _buildCards();
  }

  void _buildCards() {
    final pairs = widget.exercise.pairs;
    final cards = <_MemoryCard>[];
    for (var i = 0; i < pairs.length; i++) {
      cards.add(_MemoryCard(
        pairId: i,
        content: pairs[i].emoji,
        isEmoji: true,
      ));
      cards.add(_MemoryCard(
        pairId: i,
        content: pairs[i].word,
        isEmoji: false,
      ));
    }
    cards.shuffle(Random());
    _cards = cards;
  }

  bool get _allMatched => _matched.length == _cards.length;

  void _onCardTap(int index) {
    if (_isChecking) return;
    if (_matched.contains(index)) return;
    if (_flipped.contains(index)) return;

    HapticFeedback.selectionClick();

    setState(() {
      _flipped.add(index);
    });

    if (_flipped.length == 2) {
      _attempts++;
      _checkMatch();
    }
  }

  Future<void> _checkMatch() async {
    _isChecking = true;
    final indices = _flipped.toList();
    final c1 = _cards[indices[0]];
    final c2 = _cards[indices[1]];

    // İki kart da aynı çifte ait mi? (biri emoji, diğeri kelime)
    final isMatch = c1.pairId == c2.pairId && c1.isEmoji != c2.isEmoji;

    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    setState(() {
      if (isMatch) {
        _matched.addAll(indices);
        _flipped.clear();
        HapticFeedback.mediumImpact();
      } else {
        _flipped.clear();
        HapticFeedback.lightImpact();
      }
      _isChecking = false;
    });

    if (_allMatched) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      if (!mounted) return;
      // Az deneme = good, çok deneme = hard ama yine de tamamlandı
      final minAttempts = widget.exercise.pairs.length;
      final rating = _attempts <= minAttempts + 2
          ? Rating.easy
          : _attempts <= minAttempts * 2
              ? Rating.good
              : Rating.hard;
      widget.onRating(rating);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPairs = widget.exercise.pairs.length;
    final matchedPairs = _matched.length ~/ 2;

    // Grid layout — 4 sütun (uzun kelimelerde 3 olabilir ama 4 genel)
    final crossAxisCount = _cards.length <= 8 ? 4 : 4;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Başlık
          Text(
            'Lîstika Bîranînê',
            style: ChildTypography.title.copyWith(color: ChildColors.primary),
          ),
          const SizedBox(height: 4),
          Text(
            'Wêne û peyvan li hev bîne!',
            style: ChildTypography.caption.copyWith(
              color: ChildColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),

          // İlerleme göstergesi — kaç çift bulundu
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < totalPairs; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Icon(
                    i < matchedPairs
                        ? Icons.star_rounded
                        : Icons.star_border_rounded,
                    size: 24,
                    color: i < matchedPairs
                        ? ChildColors.starYellow
                        : ChildColors.textSecondary.withOpacity(0.3),
                  ),
                ),
              const SizedBox(width: 12),
              Text(
                'Ceribandin: $_attempts',
                style: ChildTypography.caption.copyWith(
                  color: ChildColors.textSecondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Kart Grid'i
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.92,
              ),
              itemCount: _cards.length,
              itemBuilder: (context, index) {
                final card = _cards[index];
                final isMatched = _matched.contains(index);
                final isFlipped = _flipped.contains(index);
                final isFaceUp = isMatched || isFlipped;

                return _FlippableCard(
                  key: ValueKey('card_$index'),
                  isFaceUp: isFaceUp,
                  isMatched: isMatched,
                  card: card,
                  onTap: () => _onCardTap(index),
                );
              },
            ),
          ),

          // Tamamlandıysa başarı mesajı + devam butonu
          if (_allMatched)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: ChildColors.success.withOpacity(0.12),
                  borderRadius:
                      BorderRadius.circular(ChildSpacing.radiusLg),
                  border: Border.all(
                    color: ChildColors.success.withOpacity(0.4),
                  ),
                ),
                child: Row(
                  children: [
                    const Text('🎉', style: TextStyle(fontSize: 28)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _attempts <= totalPairs + 2
                            ? 'Pir baş! Tu hînê Kurmancî yî!'
                            : 'Te kir! Dîsa biceribîne dê zûtir bibe.',
                        style: ChildTypography.body.copyWith(
                          color: ChildColors.success,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms).scale(
                    begin: const Offset(0.9, 0.9),
                    curve: Curves.elasticOut,
                    duration: 500.ms,
                  ),
            ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────
// Tek bir flip-kartı — yüz aşağı (?) veya yüz yukarı (içerik)
// ────────────────────────────────────────────────────────────────

class _FlippableCard extends StatelessWidget {
  final bool isFaceUp;
  final bool isMatched;
  final _MemoryCard card;
  final VoidCallback onTap;

  const _FlippableCard({
    super.key,
    required this.isFaceUp,
    required this.isMatched,
    required this.card,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        decoration: BoxDecoration(
          color: isMatched
              ? ChildColors.success.withOpacity(0.15)
              : isFaceUp
                  ? Colors.white
                  : ChildColors.primary,
          borderRadius: BorderRadius.circular(ChildSpacing.radiusMd),
          border: Border.all(
            color: isMatched
                ? ChildColors.success
                : isFaceUp
                    ? ChildColors.primary.withOpacity(0.4)
                    : ChildColors.primary,
            width: isMatched ? 2.5 : 1.5,
          ),
          boxShadow: isFaceUp
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: isFaceUp
                ? Padding(
                    key: const ValueKey('front'),
                    padding: const EdgeInsets.all(6),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: card.isEmoji
                          ? Text(
                              card.content,
                              style: const TextStyle(fontSize: 34),
                            )
                          : Text(
                              card.content,
                              style: ChildTypography.kurmanjiCard.copyWith(
                                color: isMatched
                                    ? ChildColors.success
                                    : ChildColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                    ),
                  )
                : Icon(
                    Icons.question_mark_rounded,
                    key: const ValueKey('back'),
                    color: Colors.white,
                    size: 32,
                  ),
          ),
        ),
      ),
    );
  }
}
