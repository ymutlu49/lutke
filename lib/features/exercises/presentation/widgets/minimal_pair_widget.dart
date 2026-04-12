import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/services/audio_service.dart';
import '../../../../core/utils/fsrs_algorithm.dart';
import '../../../lessons/domain/entities/exercise.dart';

// ════════════════════════════════════════════════════════════════
// MİNİMAL ÇİFT EGZERSİZİ — LÛTKE
//
// İlke §5.5: ker/kêr gibi fonemik çiftler — ⭐⭐⭐ Heritage önceliği
// İlke §3.2: FSRS zorluk: minimal_pair = 0.55 (anlam bozucu fark)
//
// Kurmancî'de önemli minimal çiftler:
//   ker (eşek) / kêr (bıçak)
//   sor (kırmızı) / şor (tuzlu)
//   dar (ağaç) / derê (kapı)
//   gul (gül) / gol (göl)
// ════════════════════════════════════════════════════════════════

class MinimalPairWidget extends ConsumerStatefulWidget {
  final MinimalPairExercise exercise;
  final void Function(Rating rating) onRating;

  const MinimalPairWidget({
    super.key,
    required this.exercise,
    required this.onRating,
  });

  @override
  ConsumerState<MinimalPairWidget> createState() => _MinimalPairWidgetState();
}

class _MinimalPairWidgetState extends ConsumerState<MinimalPairWidget> {
  int? _selected;
  bool _checked = false;
  bool _correct = false;
  bool _audioPlayed = false;

  MinimalPairExercise get _ex => widget.exercise;

  void _playAudio() {
    final audioPath = _ex.playedIndex == 0 ? _ex.audioA : _ex.audioB;
    if (audioPath != null) {
      ref.read(audioServiceProvider.notifier).playAsset(audioPath);
    }
    setState(() => _audioPlayed = true);
  }

  void _select(int index) {
    if (_checked) return;
    setState(() => _selected = index);
  }

  void _check() {
    if (_selected == null) return;
    setState(() {
      _checked = true;
      _correct = _ex.checkAnswer(_selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          // Başlık
          Text(
            'Cûdahîyê bibîne',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Hangi kelimeyi duydun?',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary.withOpacity(0.6),
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppSpacing.xl),

          // Ses çalma butonu
          _AudioPlayButton(
            onPlay: _playAudio,
            isPlayed: _audioPlayed,
          ),

          const SizedBox(height: AppSpacing.xl),

          // İki kelime seçeneği
          Row(
            children: [
              Expanded(
                child: _PairOption(
                  word: _ex.wordA,
                  meaning: _ex.meaningA,
                  index: 0,
                  selected: _selected,
                  checked: _checked,
                  correctIndex: _ex.playedIndex,
                  onTap: () => _select(0),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              // VS ayırıcı
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'an',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _PairOption(
                  word: _ex.wordB,
                  meaning: _ex.meaningB,
                  index: 1,
                  selected: _selected,
                  checked: _checked,
                  correctIndex: _ex.playedIndex,
                  onTap: () => _select(1),
                ),
              ),
            ],
          ),

          // Açıklama (kontrol sonrası)
          if (_checked) ...[
            const SizedBox(height: AppSpacing.lg),
            _PairExplanation(
              wordA: _ex.wordA,
              wordB: _ex.wordB,
              meaningA: _ex.meaningA,
              meaningB: _ex.meaningB,
            ),
          ],

          const Spacer(),

          // Kontrol / FSRS
          if (!_checked)
            ElevatedButton(
              onPressed: _selected != null ? _check : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                disabledBackgroundColor: AppColors.primary.withOpacity(0.3),
              ),
              child: Text(
                'Kontrol bike',
                style: AppTypography.labelLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          else
            _buildRatingRow(),
        ],
      ),
    );
  }

  Widget _buildRatingRow() {
    return Row(
      children: [
        _ratingBtn('Dubare', const Color(0xFFEF5350),
            () => widget.onRating(Rating.again)),
        const SizedBox(width: 8),
        _ratingBtn('Dijwar', const Color(0xFFFF9800),
            () => widget.onRating(Rating.hard)),
        const SizedBox(width: 8),
        _ratingBtn('Baş', const Color(0xFF4CAF50),
            () => widget.onRating(Rating.good)),
        const SizedBox(width: 8),
        _ratingBtn('Hêsan', const Color(0xFF2196F3),
            () => widget.onRating(Rating.easy)),
      ],
    );
  }

  Widget _ratingBtn(String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 48),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Center(
            child: Text(label,
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w700, color: color)),
          ),
        ),
      ),
    );
  }
}

// ── Ses Çalma Butonu ──────────────────────────────────────────

class _AudioPlayButton extends StatelessWidget {
  final VoidCallback onPlay;
  final bool isPlayed;

  const _AudioPlayButton({required this.onPlay, required this.isPlayed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlay,
      child: Container(
        width: 88,
        height: 88,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 2),
        ),
        child: Icon(
          isPlayed ? Icons.replay_rounded : Icons.volume_up_rounded,
          size: 40,
          color: AppColors.primary,
        ),
      ),
    ).animate(target: isPlayed ? 0 : 1).scale(
      begin: const Offset(1, 1),
      end: const Offset(1.05, 1.05),
      duration: 800.ms,
      curve: Curves.easeInOut,
    );
  }
}

// ── Çift Seçeneği ──────────────────────────────────────────────

class _PairOption extends StatelessWidget {
  final String word;
  final String meaning;
  final int index;
  final int? selected;
  final bool checked;
  final int correctIndex;
  final VoidCallback onTap;

  const _PairOption({
    required this.word,
    required this.meaning,
    required this.index,
    required this.selected,
    required this.checked,
    required this.correctIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == index;
    final isCorrect = index == correctIndex;

    Color bg = AppColors.surface;
    Color border = AppColors.border;

    if (checked) {
      if (isCorrect) {
        bg = const Color(0xFF4CAF50).withOpacity(0.1);
        border = const Color(0xFF4CAF50);
      } else if (isSelected) {
        bg = const Color(0xFFE07B5A).withOpacity(0.1);
        border = const Color(0xFFE07B5A);
      }
    } else if (isSelected) {
      bg = AppColors.primary.withOpacity(0.08);
      border = AppColors.primary;
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: border, width: isSelected ? 2 : 1.5),
        ),
        child: Column(
          children: [
            // Kurmancî kelime — büyük
            Text(
              word,
              style: AppTypography.headingSmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            // Türkçe anlam — küçük
            Text(
              meaning,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            // Doğru/yanlış ikon
            if (checked) ...[
              const SizedBox(height: 8),
              Icon(
                isCorrect ? Icons.check_circle : (isSelected ? Icons.cancel : null),
                color: isCorrect
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFFE07B5A),
                size: 24,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Çift Açıklaması ────────────────────────────────────────────

class _PairExplanation extends StatelessWidget {
  final String wordA, wordB, meaningA, meaningB;

  const _PairExplanation({
    required this.wordA,
    required this.wordB,
    required this.meaningA,
    required this.meaningB,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: AppColors.accent, size: 18),
              const SizedBox(width: 8),
              Text(
                'Minimal çift — cûdahî:',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _miniCard(wordA, meaningA),
              Icon(Icons.compare_arrows, color: AppColors.textSecondary, size: 20),
              _miniCard(wordB, meaningB),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _miniCard(String word, String meaning) {
    return Column(
      children: [
        Text(word, style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        Text(meaning, style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary)),
      ],
    );
  }
}
