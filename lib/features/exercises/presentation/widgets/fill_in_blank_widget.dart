import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/fsrs_algorithm.dart';
import '../../../../shared/providers/language_mode_provider.dart';
import '../../../lessons/domain/entities/exercise.dart';

// ═══════════════════════════════════════════════════���════════════
// BOŞLUK DOLDURMA EGZERSİZİ — LÛTKE
//
// İlke §5.5: Yazma pratiği ⭐⭐ Heritage önceliği
// İlke §8: WCAG AA — renk + ikon birlikte
//
// İki mod:
//   1. Seçenekli: 3-4 kelime arasından seç
//   2. Serbest yazım: Doğrudan yaz (İlke §3.4: yazma %20)
// ══════════════════════════��═════════════════════════════════════

class FillInBlankWidget extends ConsumerStatefulWidget {
  final FillInBlankExercise exercise;
  final void Function(Rating rating) onRating;

  const FillInBlankWidget({
    super.key,
    required this.exercise,
    required this.onRating,
  });

  @override
  ConsumerState<FillInBlankWidget> createState() => _FillInBlankWidgetState();
}

class _FillInBlankWidgetState extends ConsumerState<FillInBlankWidget> {
  String? _selectedOption;
  final _textController = TextEditingController();
  bool _checked = false;
  bool _correct = false;

  FillInBlankExercise get _ex => widget.exercise;

  void _checkAnswer() {
    final answer = _ex.hasOptions
        ? _selectedOption
        : _textController.text;

    if (answer == null || answer.trim().isEmpty) return;

    setState(() {
      _checked = true;
      _correct = _ex.checkAnswer(answer);
    });
  }

  void _selectOption(String option) {
    if (_checked) return;
    setState(() => _selectedOption = option);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showTurkish = ref.watch(showTurkishProvider);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Başlık
          Text(
            'Cihê vala dagire',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            showTurkish ? 'Boşluğu doldur' : 'Cihê vala dagire',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary.withOpacity(0.6),
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppSpacing.xl),

          // Cümle kartı (boşluklu)
          _SentenceCard(
            sentence: _ex.sentenceWithBlank,
            filledWord: _checked ? _ex.correctWord : (_selectedOption ?? _textController.text),
            isChecked: _checked,
            isCorrect: _correct,
          ),

          const SizedBox(height: AppSpacing.xl),

          // Seçenekler veya yazım alanı
          if (_ex.hasOptions)
            _OptionsGrid(
              options: _ex.options,
              correctWord: _ex.correctWord,
              selected: _selectedOption,
              checked: _checked,
              onSelect: _selectOption,
            )
          else
            _FreeInputField(
              controller: _textController,
              checked: _checked,
              correct: _correct,
              correctWord: _ex.correctWord,
              onSubmitted: _checkAnswer,
            ),

          // Gramer notu
          if (_checked && _ex.grammarNote != null) ...[
            const SizedBox(height: AppSpacing.md),
            _GrammarNote(note: _ex.grammarNote!),
          ],

          const Spacer(),

          // Kontrol / FSRS derecelendirme
          if (!_checked)
            ElevatedButton(
              onPressed: (_selectedOption != null || _textController.text.isNotEmpty)
                  ? _checkAnswer
                  : null,
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
            _CompactRatingRow(onRating: widget.onRating, showTurkish: showTurkish),
        ],
      ),
    );
  }
}

// ── Cümle Kartı ───────────────────────────────────────────────

class _SentenceCard extends StatelessWidget {
  final String sentence;
  final String filledWord;
  final bool isChecked;
  final bool isCorrect;

  const _SentenceCard({
    required this.sentence,
    required this.filledWord,
    required this.isChecked,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final parts = sentence.split('___');
    final hasInput = filledWord.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: isChecked
            ? (isCorrect
                ? const Color(0xFF4CAF50).withOpacity(0.06)
                : const Color(0xFFE07B5A).withOpacity(0.06))
            : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: isChecked
            ? Border.all(
                color: isCorrect
                    ? const Color(0xFF4CAF50).withOpacity(0.3)
                    : const Color(0xFFE07B5A).withOpacity(0.3),
              )
            : null,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTypography.headingSmall.copyWith(
            color: AppColors.textPrimary,
            height: 1.6,
          ),
          children: [
            if (parts.isNotEmpty) TextSpan(text: parts[0]),
            // Boşluk / doldurulan kelime
            WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: hasInput
                      ? AppColors.primary.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border(
                    bottom: BorderSide(
                      color: isChecked
                          ? (isCorrect
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFFE07B5A))
                          : AppColors.primary,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  hasInput ? filledWord : '       ',
                  style: AppTypography.headingSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            if (parts.length > 1) TextSpan(text: parts[1]),
          ],
        ),
      ),
    );
  }
}

// ── Seçenek Grid ─────────────────��────────────────────────────

class _OptionsGrid extends StatelessWidget {
  final List<String> options;
  final String correctWord;
  final String? selected;
  final bool checked;
  final ValueChanged<String> onSelect;

  const _OptionsGrid({
    required this.options,
    required this.correctWord,
    required this.selected,
    required this.checked,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      alignment: WrapAlignment.center,
      children: options.map((opt) {
        final isSelected = selected == opt;
        final isCorrect = opt == correctWord;

        Color bg = AppColors.surface;
        Color borderColor = AppColors.border;
        IconData? icon;

        if (checked) {
          if (isCorrect) {
            bg = const Color(0xFF4CAF50).withOpacity(0.12);
            borderColor = const Color(0xFF4CAF50);
            icon = Icons.check_circle_outline;
          } else if (isSelected) {
            bg = const Color(0xFFE07B5A).withOpacity(0.12);
            borderColor = const Color(0xFFE07B5A);
            icon = Icons.cancel_outlined;
          }
        } else if (isSelected) {
          bg = AppColors.primary.withOpacity(0.1);
          borderColor = AppColors.primary;
        }

        return GestureDetector(
          onTap: () => onSelect(opt),
          child: AnimatedContainer(
            duration: 200.ms,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            constraints: const BoxConstraints(minHeight: 48, minWidth: 80),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor, width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 16,
                    color: isCorrect
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFFE07B5A)),
                  const SizedBox(width: 6),
                ],
                Text(
                  opt,
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ── Serbest Yazım Alanı ───────────────��──────────────────────

class _FreeInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool checked;
  final bool correct;
  final String correctWord;
  final VoidCallback onSubmitted;

  const _FreeInputField({
    required this.controller,
    required this.checked,
    required this.correct,
    required this.correctWord,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          enabled: !checked,
          autofocus: true,
          textAlign: TextAlign.center,
          style: AppTypography.headingSmall.copyWith(
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: 'Li vir binivîse...',
            filled: true,
            fillColor: checked
                ? (correct
                    ? const Color(0xFF4CAF50).withOpacity(0.08)
                    : const Color(0xFFE07B5A).withOpacity(0.08))
                : AppColors.backgroundSecondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            suffixIcon: checked
                ? Icon(
                    correct ? Icons.check_circle : Icons.cancel,
                    color: correct
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFFE07B5A),
                  )
                : null,
          ),
          onSubmitted: (_) => onSubmitted(),
        ),

        if (checked && !correct) ...[
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle_outline,
                    color: Color(0xFF4CAF50), size: 18),
                const SizedBox(width: 8),
                Text(
                  correctWord,
                  style: AppTypography.bodyMedium.copyWith(
                    color: const Color(0xFF4CAF50),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

// ── Gramer Notu ───────────────────────────────────────────────

class _GrammarNote extends StatelessWidget {
  final String note;
  const _GrammarNote({required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline,
              color: AppColors.accent, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              note,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}

// ── Kompakt FSRS Derecelendirme ───────────────────────────────

class _CompactRatingRow extends StatelessWidget {
  final void Function(Rating rating) onRating;
  final bool showTurkish;
  const _CompactRatingRow({required this.onRating, required this.showTurkish});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ratingBtn('Dubare', showTurkish ? 'Tekrar' : '', const Color(0xFFEF5350),
            Icons.refresh_rounded, () => onRating(Rating.again)),
        const SizedBox(width: 8),
        _ratingBtn('Dijwar', showTurkish ? 'Zor' : '', const Color(0xFFFF9800),
            Icons.sentiment_dissatisfied_outlined, () => onRating(Rating.hard)),
        const SizedBox(width: 8),
        _ratingBtn('Baş', showTurkish ? 'İyi' : '', const Color(0xFF4CAF50),
            Icons.sentiment_satisfied_outlined, () => onRating(Rating.good)),
        const SizedBox(width: 8),
        _ratingBtn('Hêsan', showTurkish ? 'Kolay' : '', const Color(0xFF2196F3),
            Icons.sentiment_very_satisfied_outlined, () => onRating(Rating.easy)),
      ],
    );
  }

  Widget _ratingBtn(String ku, String tr, Color color,
      IconData icon, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 56),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3), width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 2),
              Text(ku, style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w700, color: color)),
              if (tr.isNotEmpty)
                Text(tr, style: TextStyle(
                    fontSize: 9, color: color.withOpacity(0.7))),
            ],
          ),
        ),
      ),
    );
  }
}
