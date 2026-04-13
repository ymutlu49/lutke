import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/child_theme.dart';
import '../../../../core/utils/fsrs_algorithm.dart';
import '../../../lessons/domain/entities/exercise.dart';
import '../../../exercises/presentation/exercise_dispatcher.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Resim Eşleştirme Widget'ı
//
// Çocuk emoji'yi doğru kelimeyle eşleştirir.
// Sürükle-bırak veya dokunma ile eşleştirme.
// ════════════════════════════════════════════════════════════════

class PictureMatchWidget extends StatefulWidget {
  final PictureMatchExercise exercise;
  final OnRatingCallback onRating;

  const PictureMatchWidget({
    super.key,
    required this.exercise,
    required this.onRating,
  });

  @override
  State<PictureMatchWidget> createState() => _PictureMatchWidgetState();
}

class _PictureMatchWidgetState extends State<PictureMatchWidget> {
  // Seçilen emoji
  String? _selectedEmoji;
  // Eşleşmiş çiftler: emoji → word
  final Map<String, String> _matched = {};
  // Yanlış animasyon
  bool _showError = false;

  List<PictureWordPair> get _pairs => widget.exercise.pairs;

  bool get _allMatched => _matched.length == _pairs.length;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Başlık
          Text(
            'Wêne û peyv li hev bîne!',
            style: ChildTypography.title.copyWith(color: ChildColors.primary),
          ),
          Text(
            'Resim ve kelimeyi eşleştir!',
            style: ChildTypography.caption,
          ),
          const SizedBox(height: 24),

          // Emoji'ler
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: _pairs.map((pair) {
              final isMatched = _matched.containsKey(pair.emoji);
              final isSelected = _selectedEmoji == pair.emoji;

              return GestureDetector(
                onTap: isMatched ? null : () => _selectEmoji(pair.emoji),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: isMatched
                        ? ChildColors.success.withOpacity(0.15)
                        : isSelected
                            ? ChildColors.accent.withOpacity(0.15)
                            : ChildColors.backgroundSecondary,
                    borderRadius: BorderRadius.circular(ChildSpacing.radiusMd),
                    border: Border.all(
                      color: isMatched
                          ? ChildColors.success
                          : isSelected
                              ? ChildColors.accent
                              : ChildColors.primary.withOpacity(0.2),
                      width: isSelected ? 3 : 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      pair.emoji,
                      style: TextStyle(fontSize: isMatched ? 28 : 36),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),

          // Kelimeler (karıştırılmış)
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: _pairs.map((pair) {
              final isMatched = _matched.containsValue(pair.word);
              return GestureDetector(
                onTap: isMatched || _selectedEmoji == null
                    ? null
                    : () => _tryMatch(pair.word),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: isMatched
                        ? ChildColors.success.withOpacity(0.1)
                        : _selectedEmoji != null
                            ? ChildColors.primarySurface
                            : ChildColors.backgroundSecondary,
                    borderRadius: BorderRadius.circular(ChildSpacing.radiusMd),
                    border: Border.all(
                      color: isMatched
                          ? ChildColors.success
                          : ChildColors.primary.withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    pair.word,
                    style: ChildTypography.kurmanjiCard.copyWith(
                      color: isMatched ? ChildColors.success : null,
                      decoration: isMatched
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          if (_showError)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                'Dîsa biceribîne! 💪',
                style: ChildTypography.body.copyWith(
                  color: ChildColors.encourage,
                ),
              ),
            ).animate().shake(duration: 400.ms),

          const Spacer(),

          // Tamamlandıysa devam butonu
          if (_allMatched)
            SizedBox(
              width: double.infinity,
              height: ChildSpacing.touchPreferred,
              child: ElevatedButton.icon(
                onPressed: () => widget.onRating(Rating.good),
                icon: const Text('⭐', style: TextStyle(fontSize: 22)),
                label: Text(
                  'Aferin! Dûv re',
                  style: ChildTypography.labelLarge.copyWith(
                    color: ChildColors.textOnPrimary,
                  ),
                ),
              ),
            ).animate().fadeIn().scale(
                begin: const Offset(0.8, 0.8),
                curve: Curves.elasticOut,
                duration: 600.ms),
        ],
      ),
    );
  }

  void _selectEmoji(String emoji) {
    setState(() {
      _selectedEmoji = emoji;
      _showError = false;
    });
  }

  void _tryMatch(String word) {
    final emoji = _selectedEmoji!;
    final correctPair = _pairs.firstWhere((p) => p.emoji == emoji);

    if (correctPair.word == word) {
      // Doğru eşleşme!
      setState(() {
        _matched[emoji] = word;
        _selectedEmoji = null;
        _showError = false;
      });
    } else {
      // Yanlış
      setState(() {
        _showError = true;
        _selectedEmoji = null;
      });
    }
  }
}
