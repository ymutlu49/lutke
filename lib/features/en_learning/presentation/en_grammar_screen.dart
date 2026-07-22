import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/en_tts_helper.dart';
import '../domain/en_grammar_db.dart';

/// İngilizce dilbilgisi notları ekranı.
/// Konular CEFR seviyesine göre gruplanır, Kurmancî açıklamalı.
class EnGrammarScreen extends ConsumerStatefulWidget {
  const EnGrammarScreen({super.key});

  @override
  ConsumerState<EnGrammarScreen> createState() => _EnGrammarScreenState();
}

class _EnGrammarScreenState extends ConsumerState<EnGrammarScreen> {
  String _selectedLevel = 'A1';

  @override
  Widget build(BuildContext context) {
    final levels = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];
    final filteredTopics =
        kEnGrammarTopics.where((t) => t.level == _selectedLevel).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          tooltip: 'Vegere',
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.enHome);
            }
          },
        ),
        title: Row(
          children: [
            const Text('📚', style: TextStyle(fontSize: 24)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Rêziman a Îngilîzî',
                style: AppTypography.headingSmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              children: [
                // Seviye seçici — yatay kaydırılabilir + a11y
                SizedBox(
                  height: 56,
                  child: Semantics(
                    label: 'Astê hilbijêre',
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          for (final lvl in levels) _levelChip(lvl),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Expanded(
                  child: filteredTopics.isEmpty
                      ? _emptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          itemCount: filteredTopics.length,
                          itemBuilder: (_, i) {
                            return _GrammarCard(topic: filteredTopics[i]);
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _levelChip(String lvl) {
    final isSelected = _selectedLevel == lvl;
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      // A11Y: GestureDetector → InkWell so keyboard focus + Enter work.
      child: Semantics(
        button: true,
        selected: isSelected,
        label: 'Asta $lvl',
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () => setState(() => _selectedLevel = lvl),
            borderRadius: BorderRadius.circular(10),
            focusColor: AppColors.accent.withValues(alpha: 0.3),
            child: AnimatedContainer(
              duration: reduceMotion
                  ? Duration.zero
                  : const Duration(milliseconds: 200),
              // A11Y: raised minHeight 44→48 (WCAG 2.5.5 target size).
              constraints: const BoxConstraints(minWidth: 56, minHeight: 48),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.accent
                    : AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                // A11Y: Thicker border on selected → non-color indicator for
                // color-blind users (WCAG 1.4.1 Use of Color).
                border: Border.all(
                  color: isSelected
                      ? AppColors.accentWarm
                      : AppColors.accent.withValues(alpha: 0.3),
                  width: isSelected ? 2 : 1,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                lvl,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.accent,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('📖', style: TextStyle(fontSize: 64)),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Asta $_selectedLevel — di demek nêzîk de tê zêdekirin',
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Tu dikarî astek din hilbijêrî.',
            style: AppTypography.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _GrammarCard extends StatefulWidget {
  final EnGrammarTopic topic;
  const _GrammarCard({required this.topic});

  @override
  State<_GrammarCard> createState() => _GrammarCardState();
}

class _GrammarCardState extends State<_GrammarCard> {
  bool _expanded = false;
  bool _showQuiz = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          Semantics(
            button: true,
            expanded: _expanded,
            label:
                '${widget.topic.titleKu}. ${widget.topic.titleEn}. ${_expanded ? 'Girtî bike' : 'Veke'}',
            child: InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.topic.emoji,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Kurmancî önce ve daha büyük — LÛTKE tipografi kuralı
                          Text(
                            widget.topic.titleKu,
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.topic.titleEn,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.accent,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.accent.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      widget.topic.summaryKu,
                      style: AppTypography.bodyGrammar.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  for (int i = 0; i < widget.topic.rules.length; i++) ...[
                    _RuleSection(rule: widget.topic.rules[i], index: i + 1),
                    if (i < widget.topic.rules.length - 1)
                      const SizedBox(height: AppSpacing.md),
                  ],
                  if (widget.topic.quizQuestions.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.md),
                    if (!_showQuiz)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => setState(() => _showQuiz = true),
                          icon: const Icon(Icons.quiz_rounded, size: 18),
                          label: const Text('Dest bi testê bike'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textStyle: AppTypography.label.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    if (_showQuiz)
                      _EnGrammarQuiz(
                        questions: widget.topic.quizQuestions,
                        accentColor: AppColors.accent,
                        onClose: () => setState(() => _showQuiz = false),
                      ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// EN GRAMMAR QUIZ WIDGET — mirrors KU _GrammarQuiz
// ════════════════════════════════════════════════════════════════

class _EnGrammarQuiz extends StatefulWidget {
  final List<EnQuizQuestion> questions;
  final Color accentColor;
  final VoidCallback onClose;

  const _EnGrammarQuiz({
    required this.questions,
    required this.accentColor,
    required this.onClose,
  });

  @override
  State<_EnGrammarQuiz> createState() => _EnGrammarQuizState();
}

class _EnGrammarQuizState extends State<_EnGrammarQuiz> {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedOption;
  bool _answered = false;
  bool _finished = false;

  EnQuizQuestion get _currentQuestion => widget.questions[_currentIndex];

  void _selectOption(int index) {
    if (_answered) return;
    setState(() {
      _selectedOption = index;
      _answered = true;
      if (index == _currentQuestion.correctIndex) {
        _score++;
      }
    });

    // Haptic feedback — encouraging touch response
    final isCorrect = index == _currentQuestion.correctIndex;
    if (isCorrect) {
      HapticFeedback.lightImpact();
    } else {
      HapticFeedback.selectionClick();
    }

    Future.delayed(const Duration(milliseconds: 1100), () {
      if (!mounted) return;
      if (_currentIndex < widget.questions.length - 1) {
        setState(() {
          _currentIndex++;
          _selectedOption = null;
          _answered = false;
        });
      } else {
        setState(() => _finished = true);
      }
    });
  }

  void _retry() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _selectedOption = null;
      _answered = false;
      _finished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: widget.accentColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: widget.accentColor.withValues(alpha: 0.25),
        ),
      ),
      child: _finished ? _buildResult() : _buildQuestion(),
    );
  }

  Widget _buildQuestion() {
    final total = widget.questions.length;
    final q = _currentQuestion;
    final progress = (_currentIndex + (_answered ? 1 : 0)) / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.quiz_rounded, size: 16, color: widget.accentColor),
            const SizedBox(width: 6),
            Text(
              'Pirsa ${_currentIndex + 1}/$total',
              style: AppTypography.label.copyWith(color: widget.accentColor),
            ),
            const Spacer(),
            // A11Y: IconButton gives proper touch target (≥48dp) & focus ring.
            IconButton(
              onPressed: widget.onClose,
              tooltip: 'Testê dade',
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
              icon: Icon(
                Icons.close_rounded,
                size: 20,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // Progress bar — clear motion forward
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 4,
            backgroundColor: widget.accentColor.withValues(alpha: 0.15),
            valueColor: AlwaysStoppedAnimation<Color>(widget.accentColor),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        // English question — code-like rendering for fill-in blanks
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Text(
            q.questionEn,
            style: AppTypography.title.copyWith(
              fontSize: 16,
              fontFamily: 'NotoSans',
              letterSpacing: 0.2,
            ),
          ),
        ),
        if (q.questionKu != null) ...[
          const SizedBox(height: 6),
          // A11Y dyslexia: avoid italics (BDA 2023). Use color + weight
          // contrast to distinguish helper/translation text.
          Text(
            q.questionKu!,
            style: AppTypography.caption.copyWith(
              color: widget.accentColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: List.generate(q.options.length, (i) {
            final isCorrect = i == q.correctIndex;
            final isSelected = i == _selectedOption;
            Color bgColor;
            Color borderColor;
            Color textColor;

            if (!_answered) {
              bgColor = AppColors.backgroundSecondary;
              borderColor = AppColors.borderLight;
              textColor = AppColors.textPrimary;
            } else if (isSelected && isCorrect) {
              bgColor = AppColors.success.withValues(alpha: 0.15);
              borderColor = AppColors.success;
              textColor = AppColors.success;
            } else if (isSelected && !isCorrect) {
              bgColor = AppColors.errorSoft.withValues(alpha: 0.15);
              borderColor = AppColors.errorSoft;
              textColor = AppColors.errorSoft;
            } else if (isCorrect) {
              bgColor = AppColors.success.withValues(alpha: 0.10);
              borderColor = AppColors.success.withValues(alpha: 0.5);
              textColor = AppColors.success;
            } else {
              bgColor = AppColors.backgroundSecondary;
              borderColor = AppColors.borderLight;
              textColor = AppColors.textTertiary;
            }

            // A11Y: GestureDetector → Material+InkWell so keyboard users
            // get focus rings & Enter/Space activation. WCAG 2.1.1 Keyboard.
            return Semantics(
              button: true,
              selected: isSelected,
              label: 'Bersiv: ${q.options[i]}',
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(999),
                child: InkWell(
                  onTap: _answered ? null : () => _selectOption(i),
                  borderRadius: BorderRadius.circular(999),
                  focusColor: widget.accentColor.withValues(alpha: 0.25),
                  child: AnimatedContainer(
                    duration: MediaQuery.of(context).disableAnimations
                        ? Duration.zero
                        : const Duration(milliseconds: 250),
                    // A11Y: raised from 44dp → 48dp (Material/iOS minimum).
                    constraints: const BoxConstraints(minHeight: 48),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm + 2,
                    ),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(999),
                      // A11Y: thicker border for correct/selected gives
                      // non-color cue for color-blind users (WCAG 1.4.1).
                      border: Border.all(
                          color: borderColor,
                          width: (isSelected || (_answered && isCorrect))
                              ? 2.5
                              : 1.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_answered && isCorrect)
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.check_circle_rounded,
                              size: 16,
                              color: AppColors.success,
                              semanticLabel: 'Rast',
                            ),
                          ),
                        if (_answered && isSelected && !isCorrect)
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.cancel_rounded,
                              size: 16,
                              color: AppColors.errorSoft,
                              semanticLabel: 'Çewt',
                            ),
                          ),
                        Text(
                          q.options[i],
                          style: AppTypography.label.copyWith(
                            color: textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        if (_answered) ...[
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _selectedOption == q.correctIndex
                  ? AppColors.success.withValues(alpha: 0.08)
                  : AppColors.errorSoft.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  _selectedOption == q.correctIndex
                      ? Icons.check_circle_rounded
                      : Icons.info_rounded,
                  size: 18,
                  color: _selectedOption == q.correctIndex
                      ? AppColors.success
                      : AppColors.errorSoft,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _selectedOption == q.correctIndex
                        ? 'Aferîn! Rast e.'
                        : 'Dîsa biceribîne. Bersiva rast: ${q.options[q.correctIndex]}',
                    style: AppTypography.bodySmall.copyWith(
                      color: _selectedOption == q.correctIndex
                          ? AppColors.success
                          : AppColors.errorSoft,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildResult() {
    final total = widget.questions.length;
    final allCorrect = _score == total;
    final goodScore = _score >= (total * 0.7).round();
    return Column(
      children: [
        Icon(
          allCorrect ? Icons.emoji_events_rounded : Icons.star_rounded,
          size: 44,
          color: allCorrect ? AppColors.accent : widget.accentColor,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          '$_score/$total rast!',
          style: AppTypography.headline.copyWith(
            color: widget.accentColor,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          allCorrect
              ? 'Pir baş! Hemû rast in!'
              : goodScore
                  ? 'Baş e! Ji bo baştir, dîsa biceribîne.'
                  : 'Bi hêdî hêdî. Dîsa biceribîne.',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: _retry,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Dîsa biceribîne'),
              style: OutlinedButton.styleFrom(
                foregroundColor: widget.accentColor,
                side: BorderSide(color: widget.accentColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            TextButton(
              onPressed: widget.onClose,
              child: Text(
                'Bigre',
                style: TextStyle(color: AppColors.textTertiary),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RuleSection extends StatelessWidget {
  final EnGrammarRule rule;
  final int index;
  const _RuleSection({required this.rule, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  rule.ruleKu,
                  style: AppTypography.bodyGrammar.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (final ex in rule.examples)
            Padding(
              padding: const EdgeInsets.only(bottom: 6, left: 32),
              child: _ExampleCard(en: ex.en, ku: ex.ku),
            ),
          if (rule.noteKu != null)
            Padding(
              padding: const EdgeInsets.only(left: 32, top: 6),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFFFE082)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('💡', style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        rule.noteKu!,
                        style: AppTypography.caption.copyWith(
                          color: const Color(0xFF7B5E00),
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Example card with play-audio affordance for English sentence.
class _ExampleCard extends StatelessWidget {
  final String en;
  final String ku;
  const _ExampleCard({required this.en, required this.ku});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  en,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  ku,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.accent,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Semantics(
            button: true,
            label: 'Mînakê bibihîze',
            child: InkWell(
              onTap: () => EnTtsHelper.speak(en, rate: 0.85),
              borderRadius: BorderRadius.circular(999),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.volume_up_rounded,
                  size: 16,
                  color: AppColors.accent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
