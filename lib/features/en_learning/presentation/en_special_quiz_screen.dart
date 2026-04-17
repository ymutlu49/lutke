import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/sound_service.dart';
import '../domain/en_quiz_items.dart';

/// İngilizce-özgü quiz ekranı.
///
/// Tipler: article, past, plural, prep, phrasal, collocation, compare, synonym
///
/// Kurmancî anadilliler için: açıklamalar tamamen Kurmancî,
/// yaygın hatalar vurgulanır.
class EnSpecialQuizScreen extends ConsumerStatefulWidget {
  final String? type; // null = tüm tipler
  final String? level; // null = tüm seviyeler
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
        _xp += 10;
        SoundService.playCorrect();
      } else {
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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop();
            },
            child: Text('Derkeve',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 0;
                _correctCount = 0;
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
    if (_items.isEmpty) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('📚', style: TextStyle(fontSize: 64)),
                const SizedBox(height: AppSpacing.md),
                Text('Ev tîp an asta hîna tê amade kirin',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center),
                const SizedBox(height: AppSpacing.lg),
                ElevatedButton(
                  onPressed: () => context.pop(),
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
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            Text(_typeIcon(q.type), style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _typeName(q.type),
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('⭐ $_xp XP',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  )),
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
                      Text('${_currentIndex + 1}/${_items.length}',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w700,
                          )),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 6,
                            backgroundColor:
                                AppColors.accent.withValues(alpha: 0.15),
                            valueColor: AlwaysStoppedAnimation(AppColors.accent),
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
                          color: AppColors.primary.withValues(alpha: 0.1),
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Text(
                      q.promptEn,
                      style: AppTypography.title.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
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
                        Color bg = AppColors.surface;
                        Color border = AppColors.borderLight;
                        Color text = AppColors.textPrimary;
                        IconData? icon;
                        if (_answered) {
                          if (isCorrect) {
                            bg = Colors.green.withValues(alpha: 0.15);
                            border = Colors.green;
                            text = Colors.green.shade900;
                            icon = Icons.check_circle_rounded;
                          } else if (isSelected) {
                            bg = Colors.red.withValues(alpha: 0.15);
                            border = Colors.red;
                            text = Colors.red.shade900;
                            icon = Icons.cancel_rounded;
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap:
                                  _answered ? null : () => _onAnswer(opt),
                              borderRadius: BorderRadius.circular(14),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: border, width: 1.5),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: border.withValues(alpha: 0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        String.fromCharCode(65 + i),
                                        style: TextStyle(
                                          color: text,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        opt,
                                        style: TextStyle(
                                          color: text,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    if (icon != null)
                                      Icon(icon, color: border, size: 24),
                                  ],
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
                    Container(
                      padding: const EdgeInsets.all(14),
                      margin: const EdgeInsets.only(bottom: AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppColors.accent.withValues(alpha: 0.25)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('💡', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              q.explanationKu,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textPrimary,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
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
      'article' => 'Belirteç (a/an/the)',
      'past' => 'Demê borî (past)',
      'plural' => 'Pirjimar',
      'prep' => 'Daçek (in/on/at)',
      'phrasal' => 'Lekerên frazî',
      'collocation' => 'Hevderçûn',
      'compare' => 'Berawirdkirin',
      'superlative' => 'Berawirdê herî',
      'synonym' => 'Hevwate',
      'antonym' => 'Dijber',
      'as_as' => 'as ... as yapısı',
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
