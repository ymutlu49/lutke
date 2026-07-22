import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/child_theme.dart';
import '../../../../core/services/audio_service.dart';
import '../../../../core/services/tts_service.dart';
import '../../../../core/services/tts_source_preferences.dart';
import '../../../../core/utils/fsrs_algorithm.dart';
import '../../../lessons/domain/entities/exercise.dart';
import '../../../exercises/presentation/exercise_dispatcher.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Resim Eşleştirme Widget'ı
//
// Çocuk emoji'yi doğru kelimeyle eşleştirir.
// Sürükle-bırak veya dokunma ile eşleştirme.
// ════════════════════════════════════════════════════════════════

class PictureMatchWidget extends ConsumerStatefulWidget {
  final PictureMatchExercise exercise;
  final OnRatingCallback onRating;

  const PictureMatchWidget({
    super.key,
    required this.exercise,
    required this.onRating,
  });

  @override
  ConsumerState<PictureMatchWidget> createState() =>
      _PictureMatchWidgetState();
}

class _PictureMatchWidgetState extends ConsumerState<PictureMatchWidget> {
  /// Kurmancî TTS — HF amedcj/kmr_tts. Türkçe/İngilizce fallback YOK.
  Future<void> _speakKurmanci(String text) async {
    if (text.trim().isEmpty) return;
    try {
      final tts = ref.read(ttsServiceProvider);
      // Kullanıcı TTS kaynak tercihini senkronize et (default assetFirst).
      tts.source = ref.read(ttsSourceProvider);
      final url = await tts.synthesize(text);
      if (url == null || !mounted) return;
      final audio = ref.read(audioServiceProvider.notifier);
      if (url.startsWith('asset:')) {
        await audio.playAsset(url.substring('asset:'.length));
      } else {
        await audio.playUrl(url);
      }
    } catch (_) {
      // Sessiz geç — yanlış telaffuz yerine susmak tercih edilir
    }
  }

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
          // Başlık — Kurmancî-only (alt yazı kaldırıldı: dil sızıntısı önlemi)
          Text(
            'Wêne û peyv li hev bîne!',
            style: ChildTypography.title.copyWith(color: ChildColors.primary),
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
                  'Pîroz be! Dûvre',
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
    // Emojinin karşılığı olan Kurmancî kelimeyi sesli oku (çocuk öğrenir).
    final pair = _pairs.firstWhere(
      (p) => p.emoji == emoji,
      orElse: () => _pairs.first,
    );
    _speakKurmanci(pair.word);
  }

  void _tryMatch(String word) {
    final emoji = _selectedEmoji!;
    final correctPair = _pairs.firstWhere((p) => p.emoji == emoji);

    if (correctPair.word == word) {
      // Doğru eşleşme — Kurmancî kelimeyi kutlama olarak sesli söyle
      setState(() {
        _matched[emoji] = word;
        _selectedEmoji = null;
        _showError = false;
      });
      _speakKurmanci(word);
    } else {
      // Yanlış
      setState(() {
        _showError = true;
        _selectedEmoji = null;
      });
    }
  }
}
