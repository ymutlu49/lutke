import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';import '../../core/router/app_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../shared/providers/language_mode_provider.dart';

// ════════════════════════════════════════════════════════════════
// RÊZIMAN — Kurmancî Gramer Rehberi (A1–B1)
// Duolingo "Tips" tarzı: konu kartları + genişleyen detay.
// Îlke 0.5: Kurmancî bîrincîl dil.
// ════════════════════════════════════════════════════════════════

class GrammarTipsScreen extends ConsumerStatefulWidget {
  const GrammarTipsScreen({super.key});

  @override
  ConsumerState<GrammarTipsScreen> createState() => _GrammarTipsScreenState();
}

class _GrammarTipsScreenState extends ConsumerState<GrammarTipsScreen> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final showTurkish = ref.watch(showTurkishProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
          onPressed: () => context.canPop() ? context.pop() : context.go(AppRoutes.home),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rêziman',
              style: AppTypography.headline.copyWith(fontSize: 20),
            ),
            if (showTurkish)
              Text(
                'Gramer Rehberi',
                style: AppTypography.caption,
              ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        itemCount: _grammarTopics.length,
        itemBuilder: (context, index) {
          final topic = _grammarTopics[index];
          final isExpanded = _expandedIndex == index;

          return _GrammarTopicCard(
            topic: topic,
            isExpanded: isExpanded,
            showTurkish: showTurkish,
            onTap: () {
              setState(() {
                _expandedIndex = isExpanded ? null : index;
              });
            },
          ).animate(delay: (index * 60).ms).fadeIn(duration: 350.ms).slideY(
                begin: 0.05,
                duration: 350.ms,
                curve: Curves.easeOut,
              );
        },
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// KONU KARTI
// ════════════════════════════════════════════════════════════════

class _GrammarTopicCard extends StatelessWidget {
  final _GrammarTopic topic;
  final bool isExpanded;
  final bool showTurkish;
  final VoidCallback onTap;

  const _GrammarTopicCard({
    required this.topic,
    required this.isExpanded,
    required this.showTurkish,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: AnimatedContainer(
        duration: 300.ms,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: isExpanded ? AppColors.primary.withOpacity(0.4) : AppColors.borderLight,
            width: isExpanded ? 1.5 : 1.0,
          ),
          boxShadow: isExpanded
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Başlık satırı ──────────────────────────────
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      // Ikon
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: topic.color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                        child: Icon(topic.icon, color: topic.color, size: 24),
                      ),
                      const SizedBox(width: AppSpacing.md),

                      // Basliklar
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              topic.titleKu,
                              style: AppTypography.title.copyWith(fontSize: 16),
                            ),
                            if (showTurkish && topic.titleTr != null)
                              Text(
                                topic.titleTr!,
                                style: AppTypography.caption,
                              ),
                          ],
                        ),
                      ),

                      // Seviye rozeti
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: _levelColor(topic.level).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                        ),
                        child: Text(
                          topic.level,
                          style: AppTypography.labelSmall.copyWith(
                            color: _levelColor(topic.level),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      const SizedBox(width: AppSpacing.sm),

                      // Expand ikonu
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0.0,
                        duration: 250.ms,
                        child: Icon(
                          Icons.expand_more_rounded,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Genişleyen içerik ──────────────────────────
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: _TopicContent(topic: topic, showTurkish: showTurkish),
                  crossFadeState:
                      isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: 300.ms,
                  sizeCurve: Curves.easeInOut,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _levelColor(String level) {
    switch (level) {
      case 'A1':
        return AppColors.success;
      case 'A2':
        return AppColors.primary;
      case 'B1':
        return AppColors.accent;
      default:
        return AppColors.textSecondary;
    }
  }
}

// ════════════════════════════════════════════════════════════════
// KONU İÇERİĞİ — Kurallar + Örnekler
// ════════════════════════════════════════════════════════════════

class _TopicContent extends StatefulWidget {
  final _GrammarTopic topic;
  final bool showTurkish;

  const _TopicContent({required this.topic, required this.showTurkish});

  @override
  State<_TopicContent> createState() => _TopicContentState();
}

class _TopicContentState extends State<_TopicContent> {
  bool _showQuiz = false;

  @override
  Widget build(BuildContext context) {
    final topic = widget.topic;
    final showTurkish = widget.showTurkish;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: AppColors.borderLight, height: 1),
          const SizedBox(height: AppSpacing.md),

          // Kurallar
          ...topic.rules.map(
            (rule) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Icon(Icons.circle, size: 6, color: AppColors.primary),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(rule, style: AppTypography.bodyGrammar),
                  ),
                ],
              ),
            ),
          ),

          if (topic.examples.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),

            // Ornekler basligi
            Row(
              children: [
                Icon(Icons.lightbulb_outline_rounded,
                    size: 16, color: AppColors.accent),
                const SizedBox(width: 6),
                Text(
                  'Mînak',
                  style: AppTypography.label.copyWith(color: AppColors.accent),
                ),
                if (showTurkish)
                  Text(
                    '  (Örnekler)',
                    style: AppTypography.caption,
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),

            // Örnek kutuları
            ...topic.examples.map(
              (ex) => _ExampleBox(example: ex, showTurkish: showTurkish),
            ),
          ],

          // İpucu notu
          if (topic.tip != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.warningSurface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(color: AppColors.warning.withOpacity(0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.tips_and_updates_rounded,
                      size: 18, color: AppColors.warning),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      topic.tip!,
                      style: AppTypography.bodyGrammar.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // ── Biceribîne! (Quiz) button ──────────────────────
          if (topic.quizQuestions.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            if (!_showQuiz)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => setState(() => _showQuiz = true),
                  icon: const Icon(Icons.quiz_rounded, size: 18),
                  label: const Text('Biceribîne!'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: topic.color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    textStyle: AppTypography.label.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            if (_showQuiz)
              _GrammarQuiz(
                questions: topic.quizQuestions,
                accentColor: topic.color,
                onClose: () => setState(() => _showQuiz = false),
              ),
          ],
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// GRAMMAR QUIZ WIDGET
// ════════════════════════════════════════════════════════════════

class _GrammarQuiz extends StatefulWidget {
  final List<_QuizQuestion> questions;
  final Color accentColor;
  final VoidCallback onClose;

  const _GrammarQuiz({
    required this.questions,
    required this.accentColor,
    required this.onClose,
  });

  @override
  State<_GrammarQuiz> createState() => _GrammarQuizState();
}

class _GrammarQuizState extends State<_GrammarQuiz> {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedOption;
  bool _answered = false;
  bool _finished = false;

  _QuizQuestion get _currentQuestion => widget.questions[_currentIndex];

  void _selectOption(int index) {
    if (_answered) return;
    setState(() {
      _selectedOption = index;
      _answered = true;
      if (index == _currentQuestion.correctIndex) {
        _score++;
      }
    });

    Future.delayed(const Duration(milliseconds: 900), () {
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
        color: widget.accentColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: widget.accentColor.withOpacity(0.25)),
      ),
      child: _finished ? _buildResult() : _buildQuestion(),
    );
  }

  Widget _buildQuestion() {
    final total = widget.questions.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress indicator
        Row(
          children: [
            Icon(Icons.quiz_rounded, size: 16, color: widget.accentColor),
            const SizedBox(width: 6),
            Text(
              'Pirs ${_currentIndex + 1}/$total',
              style: AppTypography.label.copyWith(color: widget.accentColor),
            ),
            const Spacer(),
            GestureDetector(
              onTap: widget.onClose,
              child: Icon(Icons.close_rounded, size: 18, color: AppColors.textTertiary),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        // Question text
        Text(
          _currentQuestion.question,
          style: AppTypography.title.copyWith(fontSize: 15),
        ),
        const SizedBox(height: AppSpacing.md),

        // Options as chips
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: List.generate(_currentQuestion.options.length, (i) {
            final isCorrect = i == _currentQuestion.correctIndex;
            final isSelected = i == _selectedOption;
            Color bgColor;
            Color borderColor;
            Color textColor;

            if (!_answered) {
              bgColor = AppColors.backgroundSecondary;
              borderColor = AppColors.borderLight;
              textColor = AppColors.textPrimary;
            } else if (isSelected && isCorrect) {
              bgColor = AppColors.success.withOpacity(0.15);
              borderColor = AppColors.success;
              textColor = AppColors.success;
            } else if (isSelected && !isCorrect) {
              bgColor = AppColors.errorSoft.withOpacity(0.15);
              borderColor = AppColors.errorSoft;
              textColor = AppColors.errorSoft;
            } else if (isCorrect) {
              bgColor = AppColors.success.withOpacity(0.10);
              borderColor = AppColors.success.withOpacity(0.5);
              textColor = AppColors.success;
            } else {
              bgColor = AppColors.backgroundSecondary;
              borderColor = AppColors.borderLight;
              textColor = AppColors.textTertiary;
            }

            return GestureDetector(
              onTap: () => _selectOption(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  border: Border.all(color: borderColor, width: 1.5),
                ),
                child: Text(
                  _currentQuestion.options[i],
                  style: AppTypography.label.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }),
        ),

        // Feedback text
        if (_answered) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            _selectedOption == _currentQuestion.correctIndex
                ? 'Rast e! \u2714'
                : 'Ne rast e. Bersiva rast: ${_currentQuestion.options[_currentQuestion.correctIndex]}',
            style: AppTypography.bodyGrammar.copyWith(
              color: _selectedOption == _currentQuestion.correctIndex
                  ? AppColors.success
                  : AppColors.errorSoft,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildResult() {
    final total = widget.questions.length;
    final allCorrect = _score == total;
    return Column(
      children: [
        Icon(
          allCorrect ? Icons.emoji_events_rounded : Icons.star_rounded,
          size: 40,
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
          allCorrect ? 'Pîroz be! Hemû rast bûn!' : 'Careke din biceribîne!',
          style: AppTypography.bodyGrammar,
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
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            TextButton(
              onPressed: widget.onClose,
              child: Text(
                'Bigire',
                style: TextStyle(color: AppColors.textTertiary),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// ÖRNEK KUTUSU
// ════════════════════════════════════════════════════════════════

class _ExampleBox extends StatelessWidget {
  final _GrammarExample example;
  final bool showTurkish;

  const _ExampleBox({required this.example, required this.showTurkish});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kurmancî — birincil, büyük
          Text(
            example.ku,
            style: AppTypography.kurmanjiCard.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (showTurkish && example.tr != null) ...[
            const SizedBox(height: 4),
            Text(
              example.tr!,
              style: AppTypography.translation,
            ),
          ],
          if (example.note != null) ...[
            const SizedBox(height: 4),
            Text(
              example.note!,
              style: AppTypography.caption.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// VERİ MODELLERİ
// ════════════════════════════════════════════════════════════════

class _GrammarExample {
  final String ku;
  final String? tr;
  final String? note;
  const _GrammarExample({required this.ku, this.tr, this.note});
}

class _QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  const _QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

class _GrammarTopic {
  final IconData icon;
  final Color color;
  final String titleKu;
  final String? titleTr;
  final String level;
  final List<String> rules;
  final List<_GrammarExample> examples;
  final String? tip;
  final List<_QuizQuestion> quizQuestions;

  const _GrammarTopic({
    required this.icon,
    required this.color,
    required this.titleKu,
    this.titleTr,
    required this.level,
    required this.rules,
    this.examples = const [],
    this.tip,
    this.quizQuestions = const [],
  });
}

// ════════════════════════════════════════════════════════════════
// GRAMER KONULARI — A1-B1
// ════════════════════════════════════════════════════════════════

// PERF 2026-04: `final` → `const` — tüm iç _GrammarTopic ve nested literallar
// zaten `const`. `final` ile idare edince her build'de `runtime` liste
// değerlendirmesi yok ama linker'da const-pool'a girmiyordu. `const` ile
// dart2js const-hoisting yapar → daha küçük JS (tek literal, referansla).
const _grammarTopics = <_GrammarTopic>[
  // 1. Alfabe
  _GrammarTopic(
    icon: Icons.abc_rounded,
    color: AppColors.primary,
    titleKu: 'Alfabe û Dengên Kurmancî',
    titleTr: 'Alfabe ve Sesler',
    level: 'A1',
    rules: [
      'Kurmancî 31 tîp hene. Tîpên Latînî bi kar tînin (alfabeya Bedirxan-Hawar).',
      'Tîpên taybet: ê, î, û, x, q, w, ç, ş',
      'ê — wek "e" ya dirêj (mêr, dê, kêr)',
      'î — wek "i" ya dirêj (jî, şîr, mîr)',
      'û — wek "u" ya dirêj (rû, hûn, çû)',
      'x — dengekî gewrî ye, wek "ch" ya Elmanî (xwarin, xanî)',
      'q — ji "k" kûrtir e, ji qirikê tê (qehwe, qeşmer)',
      'w — wek "w" ya Îngilîzî (welat, ew, dîwar)',
    ],
    examples: [
      _GrammarExample(ku: 'ê: mêr, dê, kêr', tr: 'erkek, anne, bıçak'),
      _GrammarExample(ku: 'î: mîr, şîr, jî', tr: 'emir, süt, -de'),
      _GrammarExample(ku: 'û: rû, hûn, çû', tr: 'yüz, siz, gitti'),
      _GrammarExample(ku: 'x: xwarin, xanî', tr: 'yemek, ev'),
    ],
    tip: 'Di Kurmancî de her tîp yek deng dide. Tîpên ku du deng bidin tune ne.',
    quizQuestions: [
      // Rule recognition
      _QuizQuestion(question: 'Kîjan tîp dengdêr e?', options: ['ê', 'k', 'ş', 'm'], correctIndex: 0),
      _QuizQuestion(question: 'Di alfabeya Kurmancî de çend tîp hene?', options: ['26', '29', '31', '33'], correctIndex: 2),
      // Fill in the blank
      _QuizQuestion(question: 'Peyva "m__r" (erkek) bi kîjan tîpê temam dibe?', options: ['e', 'ê', 'î'], correctIndex: 1),
      _QuizQuestion(question: 'Peyva "ş__r" (süt) bi kîjan tîpê temam dibe?', options: ['i', 'î', 'û'], correctIndex: 1),
      _QuizQuestion(question: 'Peyva "r__" (yüz) bi kîjan tîpê temam dibe?', options: ['u', 'û', 'ê'], correctIndex: 1),
      // Error detection
      _QuizQuestion(question: 'Kîjan peyv rast hatiye nivîsîn?', options: ['xwarin', 'kwarin', 'qwarin'], correctIndex: 0),
      _QuizQuestion(question: 'Kîjan nivîs çewt e?', options: ['qehwe', 'kehwe', 'welat'], correctIndex: 1),
      // Transformation (sound to letter mapping)
      _QuizQuestion(question: '"ê" çawa tê xwendin?', options: ['wek "e" ya kurt', 'wek "e" ya dirêj', 'wek "a"'], correctIndex: 1),
      _QuizQuestion(question: '"x" çawa tê xwendin?', options: ['wek "s"', 'wek "ch" ya Elmanî', 'wek "k"'], correctIndex: 1),
      // Applied
      _QuizQuestion(question: 'Di peyva "hûn" (siz) de kîjan tîp taybet e?', options: ['h', 'û', 'n'], correctIndex: 1),
    ],
  ),

  // 2. Navdêr û Zayend
  _GrammarTopic(
    icon: Icons.category_rounded,
    color: AppColors.accent,
    titleKu: 'Navdêr û Zayend',
    titleTr: 'İsimler ve Cinsiyet',
    level: 'A1',
    rules: [
      'Her navdêrek Kurmancî ya nêr (erkek) an mê (dişi) ye.',
      'Zayend bi bîrkirinê tê naskirin — ne qaîdeyek giştî heye.',
      'Nêr: nan, dest, dil, bav, bira, çem',
      'Mê: mal, av, dar, pirtûk, kitêb, dê, xwişk, ax',
    ],
    examples: [
      _GrammarExample(
        ku: 'nan (nêr) — nanê min',
        tr: 'ekmek (eril) — benim ekmeğim',
        note: 'Nêr: -ê veqetandek',
      ),
      _GrammarExample(
        ku: 'mal (mê) — mala min',
        tr: 'ev (dişil) — benim evim',
        note: 'Mê: -a veqetandek',
      ),
      _GrammarExample(
        ku: 'pirtûk (mê) — pirtûka min',
        tr: 'kitap (dişil) — benim kitabım',
        note: 'Mê: -a veqetandek',
      ),
    ],
    tip: 'Zayendê navdêran bi bîrkirîn lazim e. Di ferhengê de N (nêr) an M (mê) tê nivîsîn.',
    quizQuestions: [
      // Rule recognition
      _QuizQuestion(question: 'Her navdêrek Kurmancî çi ye?', options: ['tenê nêr', 'nêr an mê', 'bê zayend'], correctIndex: 1),
      _QuizQuestion(question: 'Zayendê navdêran çawa tê naskirin?', options: ['bi qaîdeyek giştî', 'bi bîrkirinê', 'bi paşgirekî taybet'], correctIndex: 1),
      // Fill in the blank (gender recognition)
      _QuizQuestion(question: 'Mal__ min (ev) — kîjan veqetandek?', options: ['ê', 'a', 'ên'], correctIndex: 1),
      _QuizQuestion(question: 'Dest__ min (el) — kîjan veqetandek?', options: ['ê', 'a', 'ên'], correctIndex: 0),
      _QuizQuestion(question: 'Pirtûk__ te (senin kitabın) — kîjan veqetandek?', options: ['ê', 'a', 'ên'], correctIndex: 1),
      // Error detection
      _QuizQuestion(question: 'Kîjan rast e?', options: ['nana min', 'nanê min', 'nanên min'], correctIndex: 1),
      _QuizQuestion(question: 'Kîjan rast e?', options: ['avê min', 'ava min', 'avên min'], correctIndex: 1),
      // Transformation — identify gender
      _QuizQuestion(question: 'Kîjan peyv mê ye?', options: ['mal', 'dest', 'dil', 'nan'], correctIndex: 0),
      _QuizQuestion(question: '"pirtûk" nêr e an mê?', options: ['nêr', 'mê'], correctIndex: 1),
      // Applied
      _QuizQuestion(question: 'Navdêrên mê bi kîjan veqetandekê ve tên girêdan?', options: ['-ê', '-a', '-ên'], correctIndex: 1),
    ],
  ),

  // 3. Veqetandek
  _GrammarTopic(
    icon: Icons.link_rounded,
    color: const Color(0xFF7C4DFF),
    titleKu: 'Veqetandek',
    titleTr: 'Veqetandek Yapısı (Tamlama)',
    level: 'A1',
    rules: [
      'Veqetandek navdêran bi hev ve girêdide.',
      'Nêr: -ê (destê min = elim)',
      'Mê: -a (mala min = evim)',
      'Pirjimar: -ên (malên me = evlerimiz)',
      'Veqetandek di navbera navdêr û cînavkê, navdêr û navdêrê, navdêr û rengdêrê de tê:',
      '  mala min, mala bavê min, mala mezin',
    ],
    examples: [
      _GrammarExample(ku: 'destê min', tr: 'elim', note: 'dest (nêr) + -ê + min'),
      _GrammarExample(ku: 'mala min', tr: 'evim', note: 'mal (mê) + -a + min'),
      _GrammarExample(ku: 'kitêba te', tr: 'senin kitabın', note: 'kitêb (mê) + -a + te'),
      _GrammarExample(ku: 'navê wî', tr: 'onun adı', note: 'nav (nêr) + -ê + wî'),
    ],
    tip: 'Veqetandek di Kurmancî de yek ji qaîdeyên herî girîng e. Her roj bikar bîne!',
    quizQuestions: [
      // Rule recognition
      _QuizQuestion(question: 'Veqetandek ya nêr kîjan e?', options: ['-ê', '-a', '-ên'], correctIndex: 0),
      _QuizQuestion(question: 'Veqetandek ya mê kîjan e?', options: ['-ê', '-a', '-ên'], correctIndex: 1),
      // Fill in the blank
      _QuizQuestion(question: 'dest__ min (benim elim)', options: ['a', 'ê', 'ên'], correctIndex: 1),
      _QuizQuestion(question: 'mal__ min (benim evim)', options: ['a', 'ê', 'ên'], correctIndex: 0),
      _QuizQuestion(question: 'kitêb__ te (senin kitapların)', options: ['a', 'ê', 'ên'], correctIndex: 2),
      // Error detection
      _QuizQuestion(question: 'Kîjan rast e (kitap — mê)?', options: ['kitêbê te', 'kitêba te', 'kitêbên te'], correctIndex: 1),
      _QuizQuestion(question: 'Kîjan rast e (nav — nêr)?', options: ['nava wî', 'navê wî', 'navên wî'], correctIndex: 1),
      // Transformation
      _QuizQuestion(question: '"malên me" — kîjan veqetandek ye?', options: ['nêr', 'mê', 'pirjimar'], correctIndex: 2),
      _QuizQuestion(question: '"dest" yek e → pirjimar veqetandekê? "dest__ min"', options: ['-ê', '-a', '-ên'], correctIndex: 2),
      // Applied
      _QuizQuestion(question: '____ min (dest — nêr)', options: ['mala', 'destê', 'destan'], correctIndex: 1),
    ],
  ),

  // 4. Cînavk
  _GrammarTopic(
    icon: Icons.person_outline_rounded,
    color: AppColors.success,
    // Terimler kaynak dilbilgilerinden (Samî Tan, Selîm Biçûk, Fêrkera Kurdî): rewşa xwerû/tewandî,
    // kirde (242 geçiş, 8 kaynak; "biker" yalnız Fêrkera'da 18), gerguhêz/negerguhêz, cînavk.
    // Önceki "rewşa rast/berz", "navokî", "kerdox", "veguhêzî" korpusta tanıksızdı (2026-10-24 denetimi).
    titleKu: 'Cînavk',
    titleTr: 'Zamirler',
    level: 'A1',
    rules: [
      'Cînavkên kesî — rewşa xwerû:',
      '  ez (ben), tu (sen), ew (o)',
      '  em (biz), hûn (siz), ew (onlar)',
      'Rewşa tewandî:',
      '  min (beni/benim), te (seni/senin), wî/wê (onu/onun)',
      '  me (bizi/bizim), we (sizi/sizin), wan (onları/onların)',
      'Di dema borî de, bi lêkerên gerguhêz, kirde di rewşa tewandî de ye!',
    ],
    examples: [
      _GrammarExample(ku: 'Ez dixwînim.', tr: 'Ben okuyorum.', note: 'Niha: cînavka xwerû'),
      _GrammarExample(ku: 'Min xwend.', tr: 'Ben okudum.', note: 'Borî: cînavka tewandî (ergatîf!)'),
      _GrammarExample(ku: 'Ew diaxive.', tr: 'O konuşuyor.'),
      _GrammarExample(ku: 'Wî got.', tr: 'O (erkek) söyledi.'),
    ],
    tip: 'Di dema borî de kirde di rewşa tewandî de ye. Ev ergatîf e — ji Tirkî cuda ye!',
    quizQuestions: [
      // Rule recognition
      _QuizQuestion(question: 'Ez, tu, ew — kîjan pirjimar e?', options: ['em', 'tu', 'ew'], correctIndex: 0),
      _QuizQuestion(question: '"min" di kîjan rewşê de ye?', options: ['xwerû', 'tewandî'], correctIndex: 1),
      // Fill in the blank
      _QuizQuestion(question: '___ dixwînim (ben)', options: ['Ez', 'Min', 'Em'], correctIndex: 0),
      _QuizQuestion(question: '___ got. (O — erkek, borî)', options: ['Ew', 'Wê', 'Wî'], correctIndex: 2),
      _QuizQuestion(question: '___ xwend. (Sen — borî, gerguhêz)', options: ['Tu', 'Te', 'We'], correctIndex: 1),
      // Error detection
      _QuizQuestion(question: 'Kîjan rast e (niha)?', options: ['Min dixwînim', 'Ez dixwînim', 'Me dixwînim'], correctIndex: 1),
      _QuizQuestion(question: 'Kîjan rast e (borî, gerguhêz)?', options: ['Ez dît', 'Min dît', 'Ê dît'], correctIndex: 1),
      // Transformation (niha → borî)
      _QuizQuestion(question: '"Ez dibînim" → dema borî (gerguhêz)?', options: ['Ez dît', 'Min dît', 'Min dibînim'], correctIndex: 1),
      _QuizQuestion(question: '"Em diçin" → dema borî? (negerguhêz)', options: ['Em çûn', 'Me çûn', 'Em çû'], correctIndex: 0),
      // Applied
      _QuizQuestion(question: 'Cînavka "hûn" tê çi wateyê?', options: ['biz', 'siz', 'onlar'], correctIndex: 1),
    ],
  ),

  // ── 2026-10-28: kaynak kitaplarda (Fêrkera Kurdî ilk 14 ders, MEB A1 programı) öğretilip
  // burada olmayan konular. Her örnek ve doğru cevap tanık korpusunda sayıldı; tanıksız
  // olanların yerine Fêrkera'nın kendi örnekleri kondu (docs/olcum/kaynak_kitap_denetimi.md).

  // 4a. Hevokên Navdêrî — Fêrkera Kurdî 2.–3. ders
  _GrammarTopic(
    icon: Icons.short_text_rounded,
    color: const Color(0xFF5C6BC0),
    titleKu: 'Hevokên Navdêrî',
    titleTr: 'Ad Cümleleri (bûn: im, î, e, in)',
    level: 'A1',
    rules: [
      'Lêkera "bûn" piştî navdêr an rengdêrê tê û cuda tê nivîsîn:',
      '  piştî tîpên bêdeng: ez … im, tu … î, ew … e, em/hûn/ew … in',
      '  piştî tîpên dengdêr: ez … me, tu … yî, ew … ye, em/hûn/ew … ne',
      'Neyînî bi du awayan:',
      '  bi "ne": Şîlan ne mamoste ye.',
      '  bi "nîne / nînin": Şîlan mamoste nîne. — Sêv sor nînin.',
      'Pirs: Azad xort e? — Gelo ew xwendekar e?',
    ],
    examples: [
      _GrammarExample(ku: 'Ez xwendekar im.', tr: 'Ben öğrenciyim.', note: 'Piştî tîpa bêdeng: im'),
      _GrammarExample(ku: 'Rêzan zana ye.', tr: 'Rêzan bilgilidir.', note: 'Piştî tîpa dengdêr: ye'),
      _GrammarExample(ku: 'Em heval in.', tr: 'Biz arkadaşız.'),
      _GrammarExample(ku: 'Şîlan ne mamoste ye.', tr: 'Şîlan öğretmen değil.', note: 'Neyînî: ne'),
    ],
    tip: 'Lêkera "bûn" cuda tê nivîsîn: "xwendekar im", ne "xwendekarim".',
    quizQuestions: [
      _QuizQuestion(question: 'Rêzan xwendekar __.', options: ['e', 'ye', 'in'], correctIndex: 0),
      _QuizQuestion(question: 'Rêzan zana __.', options: ['e', 'ye', 'ne'], correctIndex: 1),
      _QuizQuestion(question: 'Ez mamoste __.', options: ['im', 'me', 'e'], correctIndex: 1),
      _QuizQuestion(question: 'Em heval __.', options: ['e', 'in', 'ne'], correctIndex: 1),
      _QuizQuestion(question: 'Tu mamoste __.', options: ['î', 'yî', 'ye'], correctIndex: 1),
      _QuizQuestion(question: 'Kîjan rast e?', options: ['Ez xwendekar im.', 'Ez xwendekarim.', 'Ez xwendekar e.'], correctIndex: 0),
      _QuizQuestion(question: '"Şîlan mamoste ye." → neyînî?', options: ['Şîlan ne mamoste ye.', 'Şîlan na mamoste ye.', 'Şîlan mamoste ne ye.'], correctIndex: 0),
      _QuizQuestion(question: '"Sêv sor in." → neyînî (bi "nînin")?', options: ['Sêv sor nînin.', 'Sêv sor nîne.', 'Sêv nînin sor.'], correctIndex: 0),
    ],
  ),

  // 4b. Cînavên Nîşanê — Fêrkera Kurdî 10. ders
  _GrammarTopic(
    icon: Icons.near_me_rounded,
    color: const Color(0xFF26A69A),
    titleKu: 'Cînavên Nîşanê',
    titleTr: 'İşaret Zamirleri (ev, ew, vê, vî, van)',
    level: 'A1',
    rules: [
      'Nêzîk: ev (bu) — Dûr: ew (şu, o)',
      'Bi navdêrê re: ev pirtûk, ew pirtûk',
      'Rewşa tewandî (bi daçekan re, wek bireser):',
      '  nêzîk: vê (mê), vî (nêr), van (pirjimar)',
      '  dûr: wê (mê), wî (nêr), wan (pirjimar)',
      '  Navdêr jî ditewe: vê pirtûkê, vî gundî, van zarokan',
    ],
    examples: [
      _GrammarExample(ku: 'Ev çi ye?', tr: 'Bu ne?'),
      _GrammarExample(ku: 'di vê malê de', tr: 'bu evde', note: 'mê: vê … -ê'),
      _GrammarExample(ku: 'ji vî gundî', tr: 'bu köyden', note: 'nêr: vî … -î'),
      _GrammarExample(ku: 'bi van zarokan re', tr: 'bu çocuklarla', note: 'pirjimar: van … -an'),
    ],
    tip: 'Bi daçekan re cînava nîşanê û navdêr bi hev re ditewin: di vê malê de, ji vî gundî.',
    quizQuestions: [
      _QuizQuestion(question: 'Nêzîk: __ pirtûk (bu kitap)', options: ['ev', 'ew', 'vê'], correctIndex: 0),
      _QuizQuestion(question: 'Di __ malê de (bu evde)', options: ['ev', 'vê', 'vî'], correctIndex: 1),
      _QuizQuestion(question: 'Ji __ gundî (bu köyden)', options: ['vê', 'vî', 'van'], correctIndex: 1),
      _QuizQuestion(question: 'Bi __ zarokan re (bu çocuklarla)', options: ['vî', 'vê', 'van'], correctIndex: 2),
      _QuizQuestion(question: '"vê" ji bo kîjan zayendê ye?', options: ['nêr', 'mê', 'pirjimar'], correctIndex: 1),
      _QuizQuestion(question: 'Kîjan rast e (bu evde)?', options: ['di vê malê de', 'di vî malê de', 'di ev malê de'], correctIndex: 0),
      _QuizQuestion(question: '"Ev çi ye?" tê çi wateyê?', options: ['Bu ne?', 'Bu kim?', 'Bu nerede?'], correctIndex: 0),
    ],
  ),

  // 4c. Peyvên Pirsê — MEB A1 kazanımı (çi, li ku, kengî, çawa, çima, kî)
  _GrammarTopic(
    icon: Icons.help_outline_rounded,
    color: const Color(0xFFAB47BC),
    titleKu: 'Peyvên Pirsê',
    titleTr: 'Soru Sözcükleri',
    level: 'A1',
    rules: [
      'çi (ne) · kî (kim) · kîjan (hangi)',
      'kengî (ne zaman) · çawa (nasıl) · çima (neden)',
      'li ku (nerede) · ji ku (nereden) · çend (kaç)',
      'Peyva pirsê li cihê bersivê tê:',
      '  Navê te çi ye? — Navê min Amed e.',
    ],
    examples: [
      _GrammarExample(ku: 'Navê te çi ye?', tr: 'Adın ne?'),
      _GrammarExample(ku: 'Ew kî ye?', tr: 'O kim?'),
      _GrammarExample(ku: 'Tu ji ku yî?', tr: 'Nerelisin?'),
      _GrammarExample(ku: 'Tu çend salî yî?', tr: 'Kaç yaşındasın?'),
    ],
    tip: 'Ew kî ye? — Ew Amed e. · Navê te çi ye? — Navê min Amed e.',
    quizQuestions: [
      _QuizQuestion(question: '"kengî" tê çi wateyê?', options: ['ne zaman', 'nasıl', 'neden'], correctIndex: 0),
      _QuizQuestion(question: '"çima" tê çi wateyê?', options: ['nerede', 'neden', 'kim'], correctIndex: 1),
      _QuizQuestion(question: 'Navê te __ ye?', options: ['çi', 'kî', 'çend'], correctIndex: 0),
      _QuizQuestion(question: 'Ew __ ye? — Ew Amed e.', options: ['çi', 'kî', 'kengî'], correctIndex: 1),
      _QuizQuestion(question: 'Tu __ yî? — Ez baş im.', options: ['çawa', 'çi', 'kî'], correctIndex: 0),
      _QuizQuestion(question: 'Tu __ salî yî?', options: ['çend', 'çi', 'kîjan'], correctIndex: 0),
      _QuizQuestion(question: '"kîjan" tê çi wateyê?', options: ['hangi', 'kaç', 'kim'], correctIndex: 0),
    ],
  ),

  // 4d. Jimar û Saet — Fêrkera Kurdî 4.–5. ders
  _GrammarTopic(
    icon: Icons.schedule_rounded,
    color: const Color(0xFFFFA000),
    titleKu: 'Jimar û Saet',
    titleTr: 'Sayılar ve Saat',
    level: 'A1',
    rules: [
      'yek, du, sê, çar, pênc, şeş, heft, heşt, neh, deh',
      'yanzdeh, diwazdeh, sêzdeh, çardeh, panzdeh, şanzdeh, hivdeh, hejdeh, nozdeh, bîst',
      'Di navbera jimaran de "û": bîst û yek (21), sed û deh (110)',
      'Saet çend e? — Saet heşt e.',
      '  Saet heft û nîv e. (7.30) — Saet heşt û çaryek e. (8.15)',
      '  Saet didu kêm deh deqîqe ye. (2\'ye 10 var)',
    ],
    examples: [
      _GrammarExample(ku: 'Saet çend e?', tr: 'Saat kaç?'),
      _GrammarExample(ku: 'Saet heft û nîv e.', tr: 'Saat yedi buçuk.'),
      _GrammarExample(ku: 'bîst û yek', tr: 'yirmi bir', note: 'jimar + û + jimar'),
      _GrammarExample(ku: 'Saet didu ye.', tr: 'Saat iki.', note: 'Di saetê de: didu, sisê'),
    ],
    tip: 'Di gotina saetê de "du" û "sê" wek "didu" û "sisê" tên gotin: Saet didu ye.',
    quizQuestions: [
      _QuizQuestion(question: '21 = ?', options: ['bîst û yek', 'yek û bîst', 'bîstyek'], correctIndex: 0),
      _QuizQuestion(question: '15 = ?', options: ['pêncdeh', 'panzdeh', 'deh û pênc'], correctIndex: 1),
      _QuizQuestion(question: 'Saet __ e? (Saat kaç?)', options: ['çend', 'çi', 'kengî'], correctIndex: 0),
      _QuizQuestion(question: 'Saet heft û __ e. (yedi buçuk)', options: ['nîv', 'çaryek', 'deh'], correctIndex: 0),
      _QuizQuestion(question: 'Saet heşt û __ e. (sekizi çeyrek geçiyor)', options: ['nîv', 'çaryek', 'kêm'], correctIndex: 1),
      _QuizQuestion(question: 'Kîjan rast e (Saat iki)?', options: ['Saet didu ye.', 'Saet du e.', 'Saet didu e.'], correctIndex: 0),
      _QuizQuestion(question: '100 = ?', options: ['sed', 'hezar', 'deh'], correctIndex: 0),
    ],
  ),

  // 4e. Hebûn: heye / hene — Kurmanji Complete; korpus "Min kitêbek heye"
  _GrammarTopic(
    icon: Icons.inventory_2_rounded,
    color: const Color(0xFF8D6E63),
    titleKu: 'Hebûn: heye / hene',
    titleTr: 'Var / Yok: iyelik',
    level: 'A1',
    rules: [
      'Xwedîtî: cînavk an navdêr di rewşa tewandî de + heye (yekjimar) / hene (pirjimar)',
      '  Min kitêbek heye. (Bir kitabım var.)',
      '  Min zarok hene. (Çocuklarım var.)',
      'Neyînî: tune (Tune ye. = Yok.)',
    ],
    examples: [
      _GrammarExample(ku: 'Min kitêbek heye.', tr: 'Bir kitabım var.', note: 'min (tewandî) + heye'),
      _GrammarExample(ku: 'Min hevalek heye.', tr: 'Bir arkadaşım var.'),
      _GrammarExample(ku: 'Min zarok hene.', tr: 'Çocuklarım var.', note: 'pirjimar: hene'),
      _GrammarExample(ku: 'Tune ye.', tr: 'Yok.'),
    ],
    tip: '"Min kitêbek heye" — xwedî "min" e (tewandî), ne "ez".',
    quizQuestions: [
      _QuizQuestion(question: '__ kitêbek heye. (Bir kitabım var.)', options: ['Min', 'Ez', 'Em'], correctIndex: 0),
      _QuizQuestion(question: 'Min zarok __. (Çocuklarım var.)', options: ['heye', 'hene', 'in'], correctIndex: 1),
      _QuizQuestion(question: 'Min hevalek __.', options: ['heye', 'hene', 'e'], correctIndex: 0),
      _QuizQuestion(question: 'Kîjan rast e (Bir kitabım var)?', options: ['Min kitêbek heye.', 'Ez kitêbek heye.', 'Min kitêbek hene.'], correctIndex: 0),
      _QuizQuestion(question: '"heye" — neyînî?', options: ['tune', 'nake', 'nayê'], correctIndex: 0),
    ],
  ),

  // 5. Lêker — Dema Niha
  _GrammarTopic(
    icon: Icons.play_arrow_rounded,
    color: const Color(0xFF0288D1),
    titleKu: 'Lêker — Dema Niha',
    titleTr: 'Fiiller — Şimdiki Zaman',
    level: 'A1',
    rules: [
      'Pêşgira di- + koka lêker + paşgira kes:',
      '  ez di-xwîn-im (ben okuyorum)',
      '  tu di-xwîn-î (sen okuyorsun)',
      '  ew di-xwîn-e (o okuyor)',
      '  em di-xwîn-in (biz okuyoruz)',
      '  hûn di-xwîn-in (siz okuyorsunuz)',
      '  ew di-xwîn-in (onlar okuyorlar)',
      'Pêşgira "di-" tenê carekê tê danîn: diaxive (ne di-diaxive).',
    ],
    examples: [
      _GrammarExample(ku: 'Ez dixwînim.', tr: 'Ben okuyorum.'),
      _GrammarExample(ku: 'Tu diaxivî.', tr: 'Sen konuşuyorsun.'),
      _GrammarExample(ku: 'Em diçin.', tr: 'Biz gidiyoruz.'),
      _GrammarExample(ku: 'Ew nan dixwin.', tr: 'Onlar ekmek yiyorlar.'),
    ],
    tip: 'Pêşgira "di-" her dem li pêşiya kokê ye. Di hevokê de ew bi kok re wek yek peyv tê nivîsîn.',
    quizQuestions: [
      // Rule recognition
      _QuizQuestion(question: 'Pêşgira dema niha kîjan e?', options: ['na-', 'di-', 'ne-'], correctIndex: 1),
      _QuizQuestion(question: 'Paşgira "ez" kîjan e?', options: ['-e', '-im', '-î'], correctIndex: 1),
      // Fill in the blank
      _QuizQuestion(question: 'Ez di____im (xwendin)', options: ['xwîn', 'xwên', 'xwan'], correctIndex: 0),
      _QuizQuestion(question: 'Tu di____î (axaftin)', options: ['axiv', 'axaf', 'axivî'], correctIndex: 0),
      _QuizQuestion(question: 'Em di____in (çûn)', options: ['ç', 'çûn', 'çü'], correctIndex: 0),
      // Error detection
      _QuizQuestion(question: 'Kîjan rast e?', options: ['Ez dixwînim', 'Ez xwînim', 'Ez dixwîne'], correctIndex: 0),
      _QuizQuestion(question: 'Kîjan rast e (ew)?', options: ['Ew dixwînim', 'Ew dixwîne', 'Ew dixwînin'], correctIndex: 1),
      // Transformation (different subjects)
      _QuizQuestion(question: '"Ez dixwînim" → "Hûn ____"', options: ['dixwînî', 'dixwînin', 'dixwîne'], correctIndex: 1),
      _QuizQuestion(question: '"Ez dixebitim" → "Ew (mêr) ____"', options: ['dixebite', 'dixebitin', 'dixebitim'], correctIndex: 0),
      // Applied
      _QuizQuestion(question: '"Ew nan ____" (yemek yiyorlar — onlar)', options: ['dixwe', 'dixwin', 'dixwî'], correctIndex: 1),
    ],
  ),

  // 6. Lêker — Dema Borî
  _GrammarTopic(
    icon: Icons.history_rounded,
    color: const Color(0xFF6D4C9F),
    titleKu: 'Lêker — Dema Borî',
    titleTr: 'Fiiller — Geçmiş Zaman',
    level: 'A2',
    rules: [
      'Avahiya ergatîf: Di dema borî de kirde (bi lêkerên gerguhêz) di rewşa tewandî de ye!',
      'Lêkerên gerguhêz (transîtîf): MIN dît. (Ben gördüm.)',
      '  Kirde (min) di rewşa tewandî de ye.',
      '  Lêker li gorî bireserê tê kişandin, ne li gorî kirdeyê:',
      '  Min ew dît. (Onu gördüm.) — Min tu dîtî. (Seni gördüm.)',
      'Lêkerên negerguhêz (întransîtîf): EZ çûm. (Ben gittim.)',
      '  Kirde (ez) di rewşa xwerû de dimîne.',
      'Koka borî ji rader tê çêkirin:',
      '  xwendin → xwend, dîtin → dît, çûn → çû',
    ],
    examples: [
      _GrammarExample(ku: 'Min dît.', tr: 'Ben gördüm.', note: 'Gerguhêz: min (tewandî) + dît'),
      _GrammarExample(ku: 'Te xwend.', tr: 'Sen okudun.', note: 'Gerguhêz: te (tewandî) + xwend'),
      _GrammarExample(ku: 'Ez çûm.', tr: 'Ben gittim.', note: 'Negerguhêz: ez (xwerû) + çûm'),
      _GrammarExample(ku: 'Em hatin.', tr: 'Biz geldik.', note: 'Negerguhêz: em (xwerû) + hatin'),
    ],
    tip: 'Ergatîf yek ji taybetiyên herî cuda yên Kurmancî ye. "MIN dît" = Ben gördüm — "min" ne "beni" ye, kirde ye!',
    quizQuestions: [
      // Rule recognition
      _QuizQuestion(question: 'Di borî de kirde di kîjan rewşê de ye (lêkerên gerguhêz)?', options: ['xwerû', 'tewandî (ergatîf)'], correctIndex: 1),
      _QuizQuestion(question: '"Ez çûm" — kîjan celeb lêker e?', options: ['gerguhêz', 'negerguhêz'], correctIndex: 1),
      // Fill in the blank — "ew" tekil de çoğul da olabilir; anlam verilmezse "dîtin" de doğru olurdu
      _QuizQuestion(question: 'Min ew ____ (onu gördüm)', options: ['dît', 'dîtim', 'dîtin'], correctIndex: 0),
      _QuizQuestion(question: '____ xwend. (Sen okudun)', options: ['Tu', 'Te', 'We'], correctIndex: 1),
      _QuizQuestion(question: 'Ez ____ (gittim)', options: ['çû', 'çûm', 'çûn'], correctIndex: 1),
      // Error detection
      _QuizQuestion(question: 'Kîjan rast e (ben gördüm)?', options: ['Ez dît', 'Min dît', 'Ez dîtim'], correctIndex: 1),
      _QuizQuestion(question: 'Kîjan rast e (biz geldik)?', options: ['Em hatin', 'Me hatin', 'Em hat'], correctIndex: 0),
      // Transformation (niha → borî)
      _QuizQuestion(question: '"Ez dixwînim" → borî?', options: ['Ez xwendim', 'Min xwend', 'Ez xwend'], correctIndex: 1),
      _QuizQuestion(question: '"Em diçin" → borî?', options: ['Em çûn', 'Me çûn', 'Em çûm'], correctIndex: 0),
      // Applied
      _QuizQuestion(question: 'Koka borî ya lêkera "dîtin" çi ye?', options: ['dît', 'dîte', 'dîtin'], correctIndex: 0),
    ],
  ),

  // 7. Neyînî
  _GrammarTopic(
    icon: Icons.block_rounded,
    color: AppColors.errorSoft,
    titleKu: 'Neyînî',
    titleTr: 'Olumsuzluk',
    level: 'A2',
    rules: [
      'Dema niha: na- li şûna di- tê:',
      '  dixwînim → naxwînim (okumuyorum)',
      'Dema borî: ne- pêşgir e:',
      '  xwend → nexwend (okumadı)',
      'Raweya fermanî (emir): me- an ne-:',
      '  mexwîne! (okuma!), meçe! (gitme!)',
    ],
    examples: [
      _GrammarExample(ku: 'Ez naxwînim.', tr: 'Ben okumuyorum.'),
      _GrammarExample(ku: 'Tu naçî.', tr: 'Sen gitmiyorsun.'),
      _GrammarExample(ku: 'Wî nexwend.', tr: 'O okumadı.'),
      _GrammarExample(ku: 'Mexwîne!', tr: 'Okuma!', note: 'Fermanî — neyînî'),
    ],
    tip: 'Niha: di- → na-. Borî: ne- li pêşiya kokê. Du qaîdeyên hêsan!',
    quizQuestions: [
      // Rule recognition
      _QuizQuestion(question: 'Neyînîya dema niha bi kîjan pêşgirê ye?', options: ['na-', 'ne-', 'me-'], correctIndex: 0),
      _QuizQuestion(question: 'Neyînîya borî bi kîjan pêşgirê ye?', options: ['na-', 'ne-', 'me-'], correctIndex: 1),
      // Fill in the blank
      _QuizQuestion(question: 'Ez na____im (xwendin)', options: ['xwîn', 'dixwîn', 'xwend'], correctIndex: 0),
      _QuizQuestion(question: 'Tu na____ (çûn, niha)', options: ['çî', 'diçî', 'çûyî'], correctIndex: 0),
      _QuizQuestion(question: 'Wî ne____ (xwendin, borî)', options: ['xwend', 'dixwend', 'xwîn'], correctIndex: 0),
      // Error detection
      _QuizQuestion(question: 'Kîjan rast e (niha)?', options: ['Ez naxwînim', 'Ez nedixwînim', 'Ez nexwînim'], correctIndex: 0),
      _QuizQuestion(question: 'Kîjan rast e (borî)?', options: ['Wî naxwend', 'Wî nexwend', 'Wî ne xwend'], correctIndex: 1),
      // Transformation (olumludan olumsuza)
      _QuizQuestion(question: '"Ez diçim" → neyînî?', options: ['Ez naçim', 'Ez neçim', 'Ez nediçim'], correctIndex: 0),
      _QuizQuestion(question: '"Min dît" → neyînî?', options: ['Min nedît', 'Min nadît', 'Ez nedîtim'], correctIndex: 0),
      // Applied
      _QuizQuestion(question: '"Mexwîne!" çi ye?', options: ['pirsyar', 'fermanî neyînî', 'dema niha'], correctIndex: 1),
    ],
  ),

  // 8. Daçek
  _GrammarTopic(
    icon: Icons.swap_horiz_rounded,
    color: const Color(0xFF00897B),
    titleKu: 'Daçek',
    titleTr: 'Edat ve Çevre-Edatlar',
    level: 'A2',
    rules: [
      'di...de — içinde / içerisinde:',
      '  di malê de (evde, evin içinde)',
      'ji...re — -e/-a (datîf/alîcî):',
      '  ji min re bêje (bana söyle)',
      'ji bo — için (amaç):',
      '  ji bo te (senin için)',
      'li — de/da (cih):',
      '  li malê (evde), li bazarê (çarşıda)',
      'bi — ile (amûr/alet):',
      '  bi destan (ellerle), bi hev re (birlikte)',
    ],
    examples: [
      _GrammarExample(ku: 'Ez di malê de me.', tr: 'Ben evdeyim.'),
      _GrammarExample(ku: 'Ji min re bêje.', tr: 'Bana söyle.'),
      _GrammarExample(ku: 'Ew li dibistanê ye.', tr: 'O okulda.'),
      _GrammarExample(ku: 'Em bi hev re diçin.', tr: 'Birlikte gidiyoruz.'),
    ],
    tip: 'Daçekên Kurmancî piranî du-par in (circum-position): di...de, ji...re. Her du paran jî bi bîr bînin!',
    quizQuestions: [
      // Rule recognition
      _QuizQuestion(question: 'Daçeka "di...de" tê çi wateyê?', options: ['için', 'içinde', 'ile'], correctIndex: 1),
      _QuizQuestion(question: 'Daçeka "ji...re" tê çi wateyê?', options: ['-e / -a (bana, sana)', 'içinde', 'ile'], correctIndex: 0),
      // Fill in the blank
      _QuizQuestion(question: 'Di malê ____', options: ['de', 'da', 're'], correctIndex: 0),
      _QuizQuestion(question: 'Ji min ____', options: ['de', 'da', 're'], correctIndex: 2),
      _QuizQuestion(question: '____ bazarê (çarşıda)', options: ['di', 'li', 'ji'], correctIndex: 1),
      // Error detection
      _QuizQuestion(question: 'Kîjan rast e?', options: ['di mal', 'di malê de', 'mal de'], correctIndex: 1),
      _QuizQuestion(question: 'Kîjan rast e (bana söyle)?', options: ['Ji min bêje', 'Ji min re bêje', 'Bi min bêje'], correctIndex: 1),
      // Transformation
      _QuizQuestion(question: '"evde" → Kurmancî?', options: ['di malê de', 'li mal', 'bi malê re'], correctIndex: 0),
      _QuizQuestion(question: '"elle (bi dest)" — daçeka "bi" tê çi wateyê?', options: ['ile', 'için', 'içinde'], correctIndex: 0),
      // Applied
      _QuizQuestion(question: '"bi hev re" tê çi wateyê?', options: ['birlikte', 'içinde', 'üzerinde'], correctIndex: 0),
    ],
  ),

  // 9. Pirjimar
  _GrammarTopic(
    icon: Icons.format_list_numbered_rounded,
    color: const Color(0xFFEF6C00),
    titleKu: 'Pirjimar',
    titleTr: 'Çoğul',
    level: 'A2',
    // 2026-10-24: önceki sürüm "-an = çoğul" öğretiyordu ("zarok → zarokan = çocuklar"). Samî Tan:
    // yalın durumdaki çoğulun eki yoktur, -an çoğul adların eğik durumunu kurar (Rêzimana Kurmancî,
    // korpus satır 2307 ve 2529). Yanlış kural "Zarokan hatin" hatasına götürürdü.
    rules: [
      'Di rewşa xwerû de pirjimar paşgir nagire:',
      '  Zarok hatin. (Çocuklar geldi.) — lêker pirjimar e',
      'Paşgira pirjimarê ya rewşa tewandî: -an',
      '  ji zarokan re (çocuklara), kitêb → kitêban, mirov → mirovan',
      'Paşgira veqetandekê ya pirjimarê: -ên',
      '  malên me (evlerimiz)',
      '  kitêbên wan (onların kitapları)',
    ],
    examples: [
      _GrammarExample(ku: 'Zarok hatin.', tr: 'Çocuklar geldi.', note: 'Xwerû: paşgir tune, lêker pirjimar e'),
      _GrammarExample(ku: 'zarok → zarokan', tr: 'çocuk → çocukları / çocuklara', note: 'Tewandî: -an'),
      _GrammarExample(ku: 'malên me', tr: 'evlerimiz', note: 'Pirjimar veqetandek: -ên'),
      _GrammarExample(ku: 'kitêbên wî', tr: 'onun kitapları', note: 'Pirjimar veqetandek: -ên'),
    ],
    tip: 'Pirjimara rewşa xwerû paşgir nagire (Zarok hatin). -an tenê di rewşa tewandî de tê (ji zarokan re).',
    quizQuestions: [
      // Rule recognition
      _QuizQuestion(question: 'Paşgira pirjimarê ya tewandî kîjan e?', options: ['-ê', '-an', '-ên'], correctIndex: 1),
      _QuizQuestion(question: 'Veqetandek ya pirjimar kîjan e?', options: ['-ê', '-a', '-ên'], correctIndex: 2),
      // Fill in the blank
      _QuizQuestion(question: 'zarok + an = ____', options: ['zarokan', 'zaroken', 'zarokên'], correctIndex: 0),
      _QuizQuestion(question: 'kitêb + an = ____', options: ['kitêbên', 'kitêban', 'kitêba'], correctIndex: 1),
      _QuizQuestion(question: 'mal + ên me = ____ me (evlerimiz)', options: ['malên', 'malan', 'mala'], correctIndex: 0),
      // Error detection
      _QuizQuestion(question: 'Kîjan rast e (Çocuklar geldi)?', options: ['Zarok hatin.', 'Zarokan hatin.', 'Zarokên hatin.'], correctIndex: 0),
      _QuizQuestion(question: 'Kîjan rast e (onların kitapları)?', options: ['kitêban wan', 'kitêbên wan', 'kitêba wan'], correctIndex: 1),
      // Transformation (yek → pirjimar)
      _QuizQuestion(question: '"mirov" → forma pirjimar a tewandî?', options: ['mirovan', 'mirovên', 'mirova'], correctIndex: 0),
      _QuizQuestion(question: '"daran" ji kîjan peyvê ye?', options: ['dar', 'dara', 'darê'], correctIndex: 0),
      // Applied
      _QuizQuestion(question: '"kitêbên wî" — veqetandeka pirjimarê çi ye?', options: ['-ê', '-a', '-ên'], correctIndex: 2),
    ],
  ),

  // 9a. Tewang — Fêrkera Kurdî 12. ders (mê -ê, nêr -î, tewanga navîn)
  _GrammarTopic(
    icon: Icons.swap_vert_rounded,
    color: const Color(0xFF7E57C2),
    titleKu: 'Tewang: -ê, -î, -an',
    titleTr: 'Eğik Durum (tekil ve çoğul)',
    level: 'A2',
    rules: [
      'Bi daçekan re navdêr di rewşa tewandî de ye:',
      '  mê: -ê (di malê de)',
      '  nêr: -î (li gundî) — di axaftinê de pir caran nayê gotin (ji gund)',
      '  pirjimar: -an (ji zarokan re)',
      'Tewanga navîn: bajar → ji bajêr',
    ],
    examples: [
      _GrammarExample(ku: 'di malê de', tr: 'evde', note: 'mal (mê) → malê'),
      _GrammarExample(ku: 'li gundî', tr: 'köyde', note: 'gund (nêr) → gundî'),
      _GrammarExample(ku: 'ji bajêr', tr: 'şehirden', note: 'bajar → bajêr'),
      _GrammarExample(ku: 'ji zarokan re', tr: 'çocuklara', note: 'pirjimar → -an'),
    ],
    tip: 'Mê -ê, nêr -î, pirjimar -an: zayenda navdêran bi bîr bîne!',
    quizQuestions: [
      _QuizQuestion(question: 'Kîjan rast e (evde)?', options: ['di malê de', 'di malî de', 'di malan de'], correctIndex: 0),
      _QuizQuestion(question: 'Ji zarok__ re (çocuklara)', options: ['ê', 'î', 'an'], correctIndex: 2),
      _QuizQuestion(question: 'Kîjan rast e (şehirden)?', options: ['ji bajêr', 'ji bajara', 'ji bajaran'], correctIndex: 0),
      _QuizQuestion(question: 'Qertafa tewangê ya navdêrên mê?', options: ['-ê', '-î', '-an'], correctIndex: 0),
      _QuizQuestion(question: 'Qertafa tewangê ya navdêrên nêr?', options: ['-ê', '-î', '-an'], correctIndex: 1),
    ],
  ),

  // 9b. Banglêkirin — Fêrkera Kurdî 8. ders (-o, -ê, -ino, gelî)
  _GrammarTopic(
    icon: Icons.campaign_rounded,
    color: const Color(0xFFEF5350),
    titleKu: 'Banglêkirin',
    titleTr: 'Seslenme (bavo!, dayê!)',
    level: 'A2',
    rules: [
      'Qertafên rewşa banglêkirinê ev in:',
      '  nêr: -o (bavo!, kuro!)',
      '  mê: -ê (dayê!, keçê!)',
      '  pirjimar: -ino (hevalino!) an "gelî … -an" (gelî hevalan!)',
    ],
    examples: [
      _GrammarExample(ku: 'Bavo!', tr: 'Baba!', note: 'nêr: -o'),
      _GrammarExample(ku: 'Keçê!', tr: 'Kızım! / Kız!', note: 'mê: -ê'),
      _GrammarExample(ku: 'Hevalino!', tr: 'Arkadaşlar!', note: 'pirjimar: -ino'),
      _GrammarExample(ku: 'Gelî hevalan!', tr: 'Ey arkadaşlar!', note: 'gelî + -an'),
    ],
    tip: 'Nêr -o, mê -ê, pirjimar -ino.',
    quizQuestions: [
      _QuizQuestion(question: 'Gazîkirina "bav"?', options: ['bavo', 'bavê', 'bavino'], correctIndex: 0),
      _QuizQuestion(question: 'Gazîkirina "keç"?', options: ['keço', 'keçê', 'keçino'], correctIndex: 1),
      _QuizQuestion(question: 'Gazîkirina "kur"?', options: ['kuro', 'kurê', 'kurino'], correctIndex: 0),
      _QuizQuestion(question: 'Gazîkirina "heval" (pirjimar)?', options: ['hevalo', 'hevalê', 'hevalino'], correctIndex: 2),
      _QuizQuestion(question: 'Gelî __! (Arkadaşlar!)', options: ['heval', 'hevalan', 'hevalên'], correctIndex: 1),
      _QuizQuestion(question: '"-o" ji bo kîjan zayendê ye?', options: ['nêr', 'mê', 'pirjimar'], correctIndex: 0),
    ],
  ),

  // 9c. Dema Bê û Fermanî — REBER: ayrı yazım "ez ê, tu yê"; Samî Tan "Tu yê bixwî"
  _GrammarTopic(
    icon: Icons.update_rounded,
    color: const Color(0xFF0097A7),
    titleKu: 'Dema Bê û Fermanî',
    titleTr: 'Gelecek Zaman ve Emir',
    level: 'A2',
    rules: [
      'Dema bê: ê / yê + bi- + kok + -im, -î, -e, -in',
      '  Ez ê biçim. — Tu yê bixwî. — Em ê biçin.',
      '  Neyînî: bi- → ne-: Ez ê neçim.',
      'Fermanî: bi- + koka dema niha + -e (yekjimar) / -in (pirjimar)',
      '  bixwîne! — bixwînin!',
      '  Awarte: hatin → were! / werin!',
    ],
    examples: [
      _GrammarExample(ku: 'Ez ê biçim.', tr: 'Gideceğim.'),
      _GrammarExample(ku: 'Tu yê bixwî.', tr: 'Yiyeceksin.', note: 'piştî "tu": yê'),
      _GrammarExample(ku: 'Bixwîne!', tr: 'Oku!', note: 'Fermanî, yekjimar'),
      _GrammarExample(ku: 'Werin!', tr: 'Gelin!', note: 'Fermanî, pirjimar'),
    ],
    tip: '"ê" ji cînavkê cuda tê nivîsîn: ez ê, tu yê, em ê.',
    quizQuestions: [
      _QuizQuestion(question: '"Ez diçim" → dema bê?', options: ['Ez ê biçim.', 'Ez ê diçim.', 'Min ê biçim.'], correctIndex: 0),
      _QuizQuestion(question: 'Kîjan rast e (yiyeceksin)?', options: ['Tu yê bixwî.', 'Tu yê dixwî.', 'Te yê bixwî.'], correctIndex: 0),
      _QuizQuestion(question: '"Ez ê biçim" → neyînî?', options: ['Ez ê neçim.', 'Ez ê naçim.', 'Ez ê nediçim.'], correctIndex: 0),
      _QuizQuestion(question: '"xwendin" → fermanî (yekjimar)?', options: ['bixwîne!', 'dixwîne!', 'bixwînin!'], correctIndex: 0),
      _QuizQuestion(question: '"xwendin" → fermanî (pirjimar)?', options: ['bixwîne!', 'bixwînin!', 'dixwînin!'], correctIndex: 1),
      _QuizQuestion(question: '"hatin" → fermanî (yekjimar)?', options: ['were!', 'hat!', 'tê!'], correctIndex: 0),
      _QuizQuestion(question: '"Werin!" tê çi wateyê?', options: ['Gelin!', 'Gel!', 'Gidin!'], correctIndex: 0),
    ],
  ),

  // 10. Hevokên Rojane
  _GrammarTopic(
    icon: Icons.chat_bubble_outline_rounded,
    color: AppColors.primaryDark,
    titleKu: 'Hevokên Rojane',
    titleTr: 'Günlük Cümleler',
    level: 'A1',
    rules: [
      'Silavên rojê:',
      '  Roj baş! (Günaydın!)',
      '  Êvar baş! (İyi akşamlar!)',
      '  Bi xatirê te! (Hoşça kal!)',
      'Pirsyarên bingehîn:',
      '  Tu çawa yî? (Nasılsın?)',
      '  Ez baş im, spas. (İyiyim, teşekkürler.)',
      '  Navê te çi ye? (Adın ne?)',
      '  Navê min ... e. (Adım ...)',
    ],
    examples: [
      _GrammarExample(ku: 'Roj baş! Tu çawa yî?', tr: 'Günaydın! Nasılsın?'),
      _GrammarExample(ku: 'Ez baş im, spas. Tu?', tr: 'İyiyim, teşekkürler. Sen?'),
      _GrammarExample(ku: 'Navê min Amed e.', tr: 'Adım Amed.'),
      // Fêrkera Kurdî 1. ders: veda "Bi xatirê te" — karşılığı "Oxir be" (korpus 18 / 14 geçiş).
      // Önceki "Xatirê te! Sibê bibînim." editör kararı bekleyenler listesindeydi; "Sibê bibînim" tanıksız.
      _GrammarExample(ku: 'Bi xatirê te! — Oxir be!', tr: 'Hoşça kal! — Güle güle!'),
    ],
    tip: '"Spas" (teşekkür) û "bi xêr hatî" (hoşgeldin) — her roj bikar bîne!',
    quizQuestions: [
      // Rule recognition
      _QuizQuestion(question: '"Roj baş!" tê çi wateyê?', options: ['İyi akşamlar!', 'Günaydın!', 'Hoşça kal!'], correctIndex: 1),
      _QuizQuestion(question: '"Spas" tê çi wateyê?', options: ['Merhaba', 'Teşekkürler', 'Evet'], correctIndex: 1),
      // Fill in the blank
      _QuizQuestion(question: 'Roj ____', options: ['baş', 'baş e', 'başe'], correctIndex: 0),
      _QuizQuestion(question: 'Navê min ____ e. (Adım ...)', options: ['Amed', 'tu', 'çi'], correctIndex: 0),
      _QuizQuestion(question: 'Ez ____ im, spas. (İyiyim)', options: ['xweş', 'baş', 'kêm'], correctIndex: 1),
      // Error detection
      _QuizQuestion(question: 'Kîjan rast e (Nasılsın?)?', options: ['Tu çawa yî?', 'Tu çi yî?', 'Tu kî yî?'], correctIndex: 0),
      _QuizQuestion(question: 'Kîjan rast e (Hoşça kal)?', options: ['Roj baş!', 'Bi xatirê te!', 'Spas!'], correctIndex: 1),
      // Transformation / response
      _QuizQuestion(question: '"Tu çawa yî?" → Bersiv?', options: ['Navê min Amed e.', 'Ez baş im, spas.', 'Roj baş!'], correctIndex: 1),
      _QuizQuestion(question: '"Tu çawa yî?" tê çi wateyê?', options: ['Adın ne?', 'Nasılsın?', 'Nerelisin?'], correctIndex: 1),
      // Applied
      _QuizQuestion(question: '"Bi xatirê te!" tê çi wateyê?', options: ['Hoşgeldin!', 'Teşekkürler!', 'Hoşça kal!'], correctIndex: 2),
    ],
  ),
];
