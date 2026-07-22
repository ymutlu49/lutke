import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/accessibility_settings.dart';
import '../../../core/services/sound_service.dart';
import '../../../shared/services/skill_progress_service.dart';
import '../domain/en_quiz_items.dart';

/// Ekrana quiz'a taybet a Îngilîzî.
///
/// Tîp: article, past, plural, prep, phrasal, collocation, compare, synonym
///
/// Ji bo xwecihên Kurmancî: şîrove hemû bi Kurmancî ne,
/// xeletiyên gelemperî têne destnîşankirin.
class EnSpecialQuizScreen extends ConsumerStatefulWidget {
  final String? type; // null = hemû tîp
  final String? level; // null = hemû asta
  const EnSpecialQuizScreen({super.key, this.type, this.level});

  @override
  ConsumerState<EnSpecialQuizScreen> createState() =>
      _EnSpecialQuizScreenState();
}

class _EnSpecialQuizScreenState
    extends ConsumerState<EnSpecialQuizScreen> {
  late List<EnQuizItem> _items;
  int _currentIndex = 0;
  String? _selectedAnswer;
  bool _answered = false;
  int _correctCount = 0;
  int _streak = 0;
  int _bestStreak = 0;
  int _xp = 0;

  @override
  void initState() {
    super.initState();
    final filtered = kEnQuizItems.where((q) {
      if (widget.type != null && q.type != widget.type) return false;
      if (widget.level != null && q.level != widget.level) return false;
      return true;
    }).toList();
    filtered.shuffle(Random());
    _items = filtered.take(15).toList();
  }

  void _onAnswer(String answer) {
    if (_answered) return;
    final correct = answer == _items[_currentIndex].correctAnswer;
    setState(() {
      _selectedAnswer = answer;
      _answered = true;
      if (correct) {
        _correctCount++;
        _streak++;
        if (_streak > _bestStreak) _bestStreak = _streak;
        // Streak bonus: her 3'emîn rast XP ekstra tîne.
        final bonus = _streak >= 3 && _streak % 3 == 0 ? 5 : 0;
        _xp += 10 + bonus;
        SoundService.playCorrect();
      } else {
        _streak = 0;
        SoundService.playWrong();
      }
    });
  }

  void _next() {
    if (_currentIndex + 1 >= _items.length) {
      _showResult();
      return;
    }
    setState(() {
      _currentIndex++;
      _selectedAnswer = null;
      _answered = false;
    });
  }

  void _showResult() {
    final pct = _items.isEmpty ? 0 : (_correctCount * 100 ~/ _items.length);
    if (pct >= 70) {
      markSkillCompletedAndNotify(ref, module: 'en', skill: 'grammar');
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          children: [
            Text(pct >= 70 ? '🎉' : '📚',
                style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 8),
            Text(pct >= 70 ? 'Pîroz be!' : 'Baş bû!',
                style: AppTypography.title.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                )),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Encam: $_correctCount / ${_items.length}',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                )),
            const SizedBox(height: 4),
            Text('%$pct rast',
                style: AppTypography.body.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w700,
                )),
            const SizedBox(height: 8),
            Text('+$_xp XP',
                style: AppTypography.body.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                )),
            if (_bestStreak >= 3) ...[
              const SizedBox(height: 4),
              Text('🔥 Rêza herî baş: $_bestStreak',
                  style: AppTypography.bodySmall.copyWith(
                    color: Colors.orange.shade700,
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.canPop()
                  ? context.pop()
                  : context.go(AppRoutes.enHome);
            },
            child: Text('Derkeve',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              setState(() {
                _currentIndex = 0;
                _correctCount = 0;
                _streak = 0;
                _bestStreak = 0;
                _xp = 0;
                _selectedAnswer = null;
                _answered = false;
                _items.shuffle(Random());
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
            ),
            child: const Text('Dîsa bike'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final a11y = ref.watch(accessibilitySettingsProvider);
    if (_items.isEmpty) {
      return Scaffold(
        backgroundColor:
            a11y.background.color ?? AppColors.backgroundPrimary,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // A11Y: decorative emoji.
                ExcludeSemantics(
                  child: const Text('📚', style: TextStyle(fontSize: 64)),
                ),
                const SizedBox(height: AppSpacing.md),
                Text('Ev tîp an asta hîna tê amadekirin',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center),
                const SizedBox(height: AppSpacing.lg),
                ElevatedButton(
                  onPressed: () => context.canPop()
                      ? context.pop()
                      : context.go(AppRoutes.enHome),
                  // A11Y: minimum 48dp.
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 48),
                  ),
                  child: const Text('Vegere'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final q = _items[_currentIndex];
    final progress = (_currentIndex + 1) / _items.length;

    return Scaffold(
      backgroundColor: a11y.background.color ?? AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor:
            a11y.background.color ?? AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          tooltip: 'Derkeve',
          onPressed: () => context.canPop()
              ? context.pop()
              : context.go(AppRoutes.enHome),
        ),
        title: Row(
          children: [
            // A11Y: decorative emoji/icon glyph.
            ExcludeSemantics(
              child: Text(_typeIcon(q.type),
                  style: const TextStyle(fontSize: 22)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Semantics(
                header: true,
                child: Text(
                  _typeName(q.type),
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            if (_streak >= 2) ...[
              Semantics(
                // A11Y: announce streak value for screen reader users.
                label: 'Şopa rast: $_streak',
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('🔥 $_streak',
                      style: TextStyle(
                        // A11Y: semantic token — survives high-contrast.
                        color: AppColors.accent,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      )),
                ),
              ),
            ],
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Semantics(
                label: '$_xp puanê ezmûnê',
                child: Text('⭐ $_xp XP',
                    style: TextStyle(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    )),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress bar
                  Row(
                    children: [
                      Semantics(
                        label: 'Pirsa ${_currentIndex + 1} ji ${_items.length}',
                        child: Text('${_currentIndex + 1}/${_items.length}',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 6,
                            backgroundColor:
                                AppColors.accent.withValues(alpha: 0.15),
                            valueColor: AlwaysStoppedAnimation(
                                AppColors.accent),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Level badge
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color:
                              AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(q.level,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                              fontSize: 11,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Prompt
                  Semantics(
                    // A11Y: Prompt explicitly labelled as the question.
                    label: 'Pirs: ${q.promptEn}',
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      // A11Y dyslexia: left-aligned, ≥1.6 line-height, wider
                      // letter-spacing via a11y.applyFont. `textAlign.center`
                      // removed — left-align is the WCAG-preferred alignment.
                      child: Text(
                        q.promptEn,
                        style: a11y.applyFont(
                          AppTypography.title.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                            height: 1.6,
                            letterSpacing: 0.3,
                          ),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Options
                  Expanded(
                    child: ListView.builder(
                      itemCount: q.options.length,
                      itemBuilder: (_, i) {
                        final opt = q.options[i];
                        final isSelected = _selectedAnswer == opt;
                        final isCorrect = opt == q.correctAnswer;
                        // A11Y: semantic tokens instead of raw Colors.red/green
                        // — survive Windows high-contrast, custom themes, and
                        // align with the soft error palette (dyslexic users
                        // are less alarmed by orange vs. hard red).
                        Color bg = AppColors.surface;
                        Color border = AppColors.borderLight;
                        Color text = AppColors.textPrimary;
                        IconData? icon;
                        if (_answered) {
                          if (isCorrect) {
                            bg = AppColors.success.withValues(alpha: 0.15);
                            border = AppColors.success;
                            text = AppColors.success;
                            icon = Icons.check_circle_rounded;
                          } else if (isSelected) {
                            bg = AppColors.errorSoft.withValues(alpha: 0.15);
                            border = AppColors.errorSoft;
                            text = AppColors.errorSoft;
                            icon = Icons.cancel_rounded;
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Semantics(
                            button: true,
                            label:
                                'Vebijarka ${String.fromCharCode(65 + i)}: $opt',
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: _answered
                                    ? null
                                    : () => _onAnswer(opt),
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                  constraints: const BoxConstraints(
                                      minHeight: 52),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: bg,
                                    borderRadius:
                                        BorderRadius.circular(14),
                                    border: Border.all(
                                        color: border, width: 1.5),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: border.withValues(
                                              alpha: 0.2),
                                          shape: BoxShape.circle,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          String.fromCharCode(65 + i),
                                          style: TextStyle(
                                            color: text,
                                            fontWeight:
                                                FontWeight.w800,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          opt,
                                          style: a11y.applyFont(
                                            TextStyle(
                                              color: text,
                                              fontWeight:
                                                  FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (icon != null)
                                        Icon(icon,
                                            color: border, size: 24),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Explanation
                  if (_answered)
                    // A11Y: liveRegion announces explanation after answering.
                    Semantics(
                      liveRegion: true,
                      label:
                          '${_selectedAnswer == q.correctAnswer ? 'Rast' : 'Çewt'}. ${q.explanationKu}',
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        margin: const EdgeInsets.only(bottom: AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AppColors.accent
                                  .withValues(alpha: 0.25)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // A11Y: decorative emoji hidden from screen reader.
                            ExcludeSemantics(
                              child: const Text('💡',
                                  style: TextStyle(fontSize: 18)),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                q.explanationKu,
                                style: a11y.applyFont(
                                  AppTypography.bodySmall.copyWith(
                                    color: AppColors.textPrimary,
                                    height: 1.6,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Next button
                  if (_answered)
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _next,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          _currentIndex + 1 >= _items.length
                              ? 'Encamê bibîne'
                              : 'Berdewam',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _typeName(String type) => switch (type) {
      'article' => 'Bernavk (a/an/the)',
      'past' => 'Dema borî',
      'plural' => 'Pirjimar',
      'prep' => 'Daçek (in/on/at)',
      'phrasal' => 'Lêkerên frazî',
      'collocation' => 'Hevderçûn',
      'compare' => 'Berawirdkirin',
      'superlative' => 'Pileya herî bilind',
      'synonym' => 'Hevwate',
      'antonym' => 'Dijwate',
      'as_as' => 'Hevberawirdî (as ... as)',
      _ => 'Pirs',
    };

String _typeIcon(String type) => switch (type) {
      'article' => '🅰️',
      'past' => '⏪',
      'plural' => '➕',
      'prep' => '📍',
      'phrasal' => '🔗',
      'collocation' => '🤝',
      'compare' => '📊',
      'superlative' => '🏆',
      'synonym' => '≈',
      'antonym' => '↔️',
      'as_as' => '⚖️',
      _ => '❓',
    };
