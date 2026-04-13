import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../shared/providers/language_mode_provider.dart';
import '../../lessons/domain/a1_kelime_db.dart';
import '../../lessons/domain/a2_kelime_db.dart';

// ════════════════════════════════════════════════════════════════
// QUIZ SESSION — 4 Egzersiz Tipi, 10 Soru, Duolingo Tarzı
//
// 1. Translation: Kurmancî -> Tirkî (4 secenek)
// 2. Reverse Translation: Tirkî -> Kurmancî (4 secenek)
// 3. Listening: Ses butonu + Kurmancî metin, Tirkî secenek
// 4. Typing: Tirkî goster, Kurmancî yaz (fuzzy match)
//
// Ilke: Destekleyici gamification, ceza degil tesvik.
// ════════════════════════════════════════════════════════════════

// ── Veri Modeli ─────────────────────────────────────────────────

/// Kelime DB kayitlarindan okunan basit quiz kelimesi.
class _QuizWord {
  final String id;
  final String ku;
  final String tr;

  const _QuizWord({required this.id, required this.ku, required this.tr});
}

/// Egzersiz tipleri.
enum _ExerciseType { translation, reverseTranslation, listening, typing }

/// Tek bir quiz sorusu.
class _QuizQuestion {
  final _ExerciseType type;
  final _QuizWord word;
  final List<String> options; // 4 secenek (translation/reverse/listening icin)

  const _QuizQuestion({
    required this.type,
    required this.word,
    this.options = const [],
  });
}

// ── Kelime Havuzu Yardimcilari ──────────────────────────────────

List<_QuizWord> _loadWordsForLevel(String level) {
  final raw = switch (level.toUpperCase()) {
    'A1' => kA1TamKelimeler,
    'A2' => kA2Kelimeler,
    _ => kA1TamKelimeler,
  };

  // Sadece anlamli kelime/soz olanları al (alfabe harfleri haric)
  return raw
      .where((r) => r.ku.length > 1 && r.tr.length > 1)
      .map((r) => _QuizWord(id: r.id, ku: r.ku, tr: r.tr))
      .toList();
}

List<_QuizQuestion> _generateQuizSession({
  required String level,
  int questionCount = 10,
}) {
  final allWords = _loadWordsForLevel(level);
  if (allWords.length < 10) return [];

  final rng = Random();
  final shuffled = List<_QuizWord>.from(allWords)..shuffle(rng);
  final sessionWords = shuffled.take(questionCount).toList();

  // Egzersiz tipi dagitimi: ~3 translation, ~3 reverse, ~2 listening, ~2 typing
  final types = <_ExerciseType>[
    _ExerciseType.translation,
    _ExerciseType.translation,
    _ExerciseType.translation,
    _ExerciseType.reverseTranslation,
    _ExerciseType.reverseTranslation,
    _ExerciseType.reverseTranslation,
    _ExerciseType.listening,
    _ExerciseType.listening,
    _ExerciseType.typing,
    _ExerciseType.typing,
  ]..shuffle(rng);

  final questions = <_QuizQuestion>[];
  for (int i = 0; i < questionCount; i++) {
    final word = sessionWords[i];
    final type = types[i];
    List<String> options = [];

    if (type != _ExerciseType.typing) {
      // 4 secenek olustur: 1 dogru + 3 yanlis
      final isKuOptions =
          type == _ExerciseType.reverseTranslation; // Kurmancî secenekler
      final correctAnswer = isKuOptions ? word.ku : word.tr;

      // Yanlis secenekler icin diger kelimelerden sec
      final distractors = allWords
          .where((w) => w.id != word.id)
          .toList()
        ..shuffle(rng);

      final wrongOptions = distractors
          .take(3)
          .map((w) => isKuOptions ? w.ku : w.tr)
          .toList();

      options = [correctAnswer, ...wrongOptions]..shuffle(rng);
    }

    questions.add(_QuizQuestion(type: type, word: word, options: options));
  }

  return questions;
}

// ── Levenshtein Distance ────────────────────────────────────────

int _levenshteinDistance(String a, String b) {
  final la = a.length;
  final lb = b.length;
  if (la == 0) return lb;
  if (lb == 0) return la;

  var prev = List<int>.generate(lb + 1, (i) => i);
  var curr = List<int>.filled(lb + 1, 0);

  for (int i = 1; i <= la; i++) {
    curr[0] = i;
    for (int j = 1; j <= lb; j++) {
      final cost = a[i - 1] == b[j - 1] ? 0 : 1;
      curr[j] = [
        prev[j] + 1, // deletion
        curr[j - 1] + 1, // insertion
        prev[j - 1] + cost, // substitution
      ].reduce(min);
    }
    final tmp = prev;
    prev = curr;
    curr = tmp;
  }

  return prev[lb];
}

// ════════════════════════════════════════════════════════════════
// QUIZ SCREEN — Ana Ekran
// ════════════════════════════════════════════════════════════════

class QuizScreen extends ConsumerStatefulWidget {
  final String level;
  const QuizScreen({super.key, this.level = 'A1'});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen>
    with TickerProviderStateMixin {
  late List<_QuizQuestion> _questions;
  int _currentIndex = 0;
  int _hearts = 3;
  int _xp = 0;
  int _correctCount = 0;
  bool _answered = false;
  bool _isCorrect = false;
  int? _selectedOptionIndex;
  String _typedAnswer = '';
  bool _sessionComplete = false;

  // Animation controllers
  late AnimationController _shakeController;
  late AnimationController _correctFlashController;
  final _typingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _questions = _generateQuizSession(level: widget.level);

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _correctFlashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _correctFlashController.dispose();
    _typingController.dispose();
    super.dispose();
  }

  _QuizQuestion get _currentQuestion => _questions[_currentIndex];

  void _submitAnswer({int? optionIndex, String? typed}) {
    if (_answered) return;

    final q = _currentQuestion;
    bool correct = false;

    if (q.type == _ExerciseType.typing) {
      final userInput = (typed ?? _typedAnswer).trim().toLowerCase();
      final expected = q.word.ku.trim().toLowerCase();
      final distance = _levenshteinDistance(userInput, expected);
      correct = distance <= 2;
    } else {
      // Multiple choice
      if (optionIndex == null) return;
      _selectedOptionIndex = optionIndex;

      final selected = q.options[optionIndex];
      final isKuOptions = q.type == _ExerciseType.reverseTranslation;
      final correctAnswer = isKuOptions ? q.word.ku : q.word.tr;
      correct = selected == correctAnswer;
    }

    setState(() {
      _answered = true;
      _isCorrect = correct;
    });

    if (correct) {
      _xp += 10;
      _correctCount++;
      _correctFlashController.forward(from: 0.0);
      HapticFeedback.lightImpact();
    } else {
      _hearts = (_hearts - 1).clamp(0, 3);
      _shakeController.forward(from: 0.0);
      HapticFeedback.heavyImpact();
    }

    // Kalp sifirsa oturum biter
    if (_hearts <= 0) {
      Future.delayed(const Duration(milliseconds: 1200), () {
        if (mounted) setState(() => _sessionComplete = true);
      });
    }
  }

  void _nextQuestion() {
    if (_currentIndex >= _questions.length - 1 || _hearts <= 0) {
      setState(() => _sessionComplete = true);
      return;
    }

    setState(() {
      _currentIndex++;
      _answered = false;
      _isCorrect = false;
      _selectedOptionIndex = null;
      _typedAnswer = '';
      _typingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundPrimary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: AppColors.textPrimary),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_amber_rounded,
                  size: 48, color: AppColors.textSecondary),
              Gap.md,
              Text('Di vê astê de peyv bes nine.',
                  style: AppTypography.body
                      .copyWith(color: AppColors.textSecondary)),
            ],
          ),
        ),
      );
    }

    if (_sessionComplete) return _buildEndScreen();

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar: close + progress + hearts + XP
            _buildTopBar(),

            // Progress bar
            _buildProgressBar(),

            // Question area
            Expanded(
              child: SingleChildScrollView(
                padding: AppSpacing.pagePadding,
                child: _buildQuestionCard(),
              ),
            ),

            // Berdewam button
            if (_answered) _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  // ── Top Bar ─────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 8),
      child: Row(
        children: [
          // Close button
          GestureDetector(
            onTap: () => _showExitDialog(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: const Icon(Icons.close, size: 18, color: AppColors.textSecondary),
            ),
          ),

          const Spacer(),

          // Hearts
          Row(
            children: List.generate(3, (i) {
              final hasHeart = i < _hearts;
              return Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Icon(
                  hasHeart ? Icons.favorite : Icons.favorite_border,
                  color: hasHeart
                      ? const Color(0xFFE53935)
                      : AppColors.textTertiary,
                  size: 22,
                ),
              );
            }),
          ),

          Gap.hMd,

          // XP
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.accentSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star_rounded,
                    size: 16, color: AppColors.accent),
                const SizedBox(width: 4),
                Text(
                  '$_xp XP',
                  style: AppTypography.labelSmall
                      .copyWith(color: AppColors.accent, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Progress Bar ──────────────────────────────────────────────

  Widget _buildProgressBar() {
    final progress = (_currentIndex + 1) / _questions.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pirs ${_currentIndex + 1} / ${_questions.length}',
                style: AppTypography.caption
                    .copyWith(color: AppColors.textSecondary),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: AppTypography.caption
                    .copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              builder: (_, value, __) => LinearProgressIndicator(
                value: value,
                backgroundColor: AppColors.primary.withOpacity(0.12),
                valueColor:
                    const AlwaysStoppedAnimation(AppColors.primary),
                minHeight: 6,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ── Question Card Router ──────────────────────────────────────

  Widget _buildQuestionCard() {
    final q = _currentQuestion;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: switch (q.type) {
        _ExerciseType.translation => _buildTranslationQuestion(q),
        _ExerciseType.reverseTranslation =>
          _buildReverseTranslationQuestion(q),
        _ExerciseType.listening => _buildListeningQuestion(q),
        _ExerciseType.typing => _buildTypingQuestion(q),
      },
    );
  }

  // ── 1. Translation: Kurmancî -> Tirkî ────────────────────────

  Widget _buildTranslationQuestion(_QuizQuestion q) {
    return Column(
      key: ValueKey('translation_${q.word.id}'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Instruction
        _buildInstruction('Ev peyv bi Tirkî çi ye?', 'Bu kelime Turkce ne demek?',
            showTr: ref.watch(showTurkishProvider)),

        Gap.lg,

        // Kurmancî word card
        _buildWordCard(q.word.ku, isKurmanji: true),

        const SizedBox(height: AppSpacing.questionToOptions),

        // Options
        ..._buildOptionButtons(q),
      ],
    );
  }

  // ── 2. Reverse Translation: Tirkî -> Kurmancî ────────────────

  Widget _buildReverseTranslationQuestion(_QuizQuestion q) {
    return Column(
      key: ValueKey('reverse_${q.word.id}'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInstruction(
            'Ev peyv bi Kurmancî çi ye?', 'Bu kelimenin Kurmancisi ne?',
            showTr: ref.watch(showTurkishProvider)),

        Gap.lg,

        // Turkish word card
        _buildWordCard(q.word.tr, isKurmanji: false),

        const SizedBox(height: AppSpacing.questionToOptions),

        // Options (Kurmancî)
        ..._buildOptionButtons(q),
      ],
    );
  }

  // ── 3. Listening Exercise ─────────────────────────────────────

  Widget _buildListeningQuestion(_QuizQuestion q) {
    return Column(
      key: ValueKey('listening_${q.word.id}'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInstruction('Guh bide u bersivê bide', 'Dinle ve cevapla',
            showTr: ref.watch(showTurkishProvider)),

        Gap.lg,

        // Audio button + word display (placeholder)
        Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  // Placeholder: ses dosyasi yokken sadece haptic feedback
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryDark],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.volume_up_rounded,
                      size: 36, color: Colors.white),
                ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.05, 1.05),
                      duration: 1200.ms,
                    ),
              ),

              Gap.md,

              // Kurmancî metin (ses placeholder olarak gosterilir)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: Text(
                  q.word.ku,
                  style: AppTypography.kurmanji
                      .copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.questionToOptions),

        // Options (Turkish translations)
        ..._buildOptionButtons(q),
      ],
    );
  }

  // ── 4. Typing Exercise ────────────────────────────────────────

  Widget _buildTypingQuestion(_QuizQuestion q) {
    return Column(
      key: ValueKey('typing_${q.word.id}'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInstruction(
            'Ev peyvê bi Kurmancî binivîse', 'Bu kelimeyi Kurmancica yaz',
            showTr: ref.watch(showTurkishProvider)),

        Gap.lg,

        // Turkish word
        _buildWordCard(q.word.tr, isKurmanji: false),

        const SizedBox(height: AppSpacing.questionToOptions),

        // Text input
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(
              color: _answered
                  ? (_isCorrect
                      ? AppColors.success
                      : AppColors.errorSoft)
                  : AppColors.borderMedium,
              width: _answered ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _typingController,
            enabled: !_answered,
            autofocus: true,
            textAlign: TextAlign.center,
            style: AppTypography.kurmanji,
            decoration: InputDecoration(
              hintText: 'Kurmancî bersiv...',
              hintStyle: AppTypography.body
                  .copyWith(color: AppColors.textTertiary),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: AppSpacing.md),
            ),
            onChanged: (v) => _typedAnswer = v,
            onSubmitted: (_) {
              if (!_answered) _submitAnswer(typed: _typedAnswer);
            },
          ),
        ),

        Gap.md,

        // Submit button (typing only)
        if (!_answered)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _typedAnswer.trim().isNotEmpty
                  ? () => _submitAnswer(typed: _typedAnswer)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppColors.primary.withOpacity(0.3),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMd)),
                elevation: 0,
              ),
              child: Text('Bersivê Bide',
                  style: AppTypography.labelLarge
                      .copyWith(color: Colors.white)),
            ),
          ),

        // Feedback for typing
        if (_answered) ...[
          Gap.md,
          _buildTypingFeedback(q),
        ],
      ],
    );
  }

  Widget _buildTypingFeedback(_QuizQuestion q) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: _isCorrect ? AppColors.successSurface : AppColors.errorSurface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: _isCorrect
              ? AppColors.success.withOpacity(0.3)
              : AppColors.errorSoft.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _isCorrect ? Icons.check_circle : Icons.cancel,
                color: _isCorrect ? AppColors.success : AppColors.errorSoft,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                _isCorrect ? 'Aferin!' : 'Rast bersiv:',
                style: AppTypography.label.copyWith(
                  color: _isCorrect ? AppColors.success : AppColors.errorSoft,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (!_isCorrect) ...[
            const SizedBox(height: 8),
            Text(
              q.word.ku,
              style: AppTypography.kurmanji
                  .copyWith(color: AppColors.textPrimary),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 200.ms).slideY(begin: 0.1);
  }

  // ── Shared Widgets ────────────────────────────────────────────

  Widget _buildInstruction(String kuText, String trText, {required bool showTr}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(kuText,
            style: AppTypography.title.copyWith(color: AppColors.textPrimary)),
        if (showTr) ...[
          const SizedBox(height: 4),
          Text(trText,
              style: AppTypography.translation
                  .copyWith(color: AppColors.textSecondary)),
        ],
      ],
    );
  }

  Widget _buildWordCard(String word, {required bool isKurmanji}) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(minWidth: 180),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          word,
          textAlign: TextAlign.center,
          style: isKurmanji
              ? AppTypography.kurmanjiLarge
              : AppTypography.headline.copyWith(color: AppColors.textPrimary),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).scale(
          begin: const Offset(0.95, 0.95),
          duration: 300.ms,
          curve: Curves.easeOut,
        );
  }

  List<Widget> _buildOptionButtons(_QuizQuestion q) {
    return q.options.asMap().entries.map((entry) {
      final i = entry.key;
      final option = entry.value;

      final isKuOption = q.type == _ExerciseType.reverseTranslation;
      final correctAnswer = isKuOption ? q.word.ku : q.word.tr;
      final isThisCorrect = option == correctAnswer;
      final isSelected = _selectedOptionIndex == i;

      Color bgColor = AppColors.surface;
      Color borderColor = AppColors.borderLight;
      Color textColor = AppColors.textPrimary;

      if (_answered) {
        if (isThisCorrect) {
          bgColor = AppColors.successSurface;
          borderColor = AppColors.success;
          textColor = AppColors.success;
        } else if (isSelected && !isThisCorrect) {
          bgColor = AppColors.errorSurface;
          borderColor = AppColors.errorSoft;
          textColor = AppColors.errorSoft;
        } else {
          bgColor = AppColors.surface.withOpacity(0.5);
          textColor = AppColors.textTertiary;
        }
      }

      Widget optionWidget = GestureDetector(
        onTap: _answered ? null : () => _submitAnswer(optionIndex: i),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md, vertical: 14),
          margin: EdgeInsets.only(bottom: AppSpacing.optionGap),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(color: borderColor, width: _answered && (isThisCorrect || isSelected) ? 2 : 1),
            boxShadow: [
              if (!_answered)
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Row(
            children: [
              // Option letter badge
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _answered && isThisCorrect
                      ? AppColors.success.withOpacity(0.15)
                      : _answered && isSelected && !isThisCorrect
                          ? AppColors.errorSoft.withOpacity(0.15)
                          : AppColors.backgroundTertiary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: _answered && isThisCorrect
                      ? Icon(Icons.check, size: 16, color: AppColors.success)
                      : _answered && isSelected && !isThisCorrect
                          ? Icon(Icons.close,
                              size: 16, color: AppColors.errorSoft)
                          : Text(
                              String.fromCharCode(65 + i), // A, B, C, D
                              style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w600),
                            ),
                ),
              ),
              Gap.hMd,
              Expanded(
                child: Text(
                  option,
                  style: (isKuOption
                          ? AppTypography.kurmanjiCard
                          : AppTypography.bodyLarge)
                      .copyWith(color: textColor),
                ),
              ),
            ],
          ),
        ),
      );

      // Shake animation for wrong selection
      if (_answered && isSelected && !isThisCorrect) {
        optionWidget = AnimatedBuilder(
          animation: _shakeController,
          builder: (context, child) {
            final dx = sin(_shakeController.value * pi * 4) * 8 *
                (1 - _shakeController.value);
            return Transform.translate(offset: Offset(dx, 0), child: child);
          },
          child: optionWidget,
        );
      }

      // Shimmer animation for correct answer
      if (_answered && isThisCorrect) {
        optionWidget = optionWidget
            .animate()
            .shimmer(
              duration: 800.ms,
              color: AppColors.success.withOpacity(0.3),
            );
      }

      return optionWidget;
    }).toList();
  }

  // ── Continue Button ───────────────────────────────────────────

  Widget _buildContinueButton() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: _isCorrect ? AppColors.successSurface : AppColors.errorSurface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Feedback message
            Row(
              children: [
                Icon(
                  _isCorrect
                      ? Icons.check_circle_rounded
                      : Icons.info_outline_rounded,
                  color: _isCorrect ? AppColors.success : AppColors.errorSoft,
                  size: 24,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _isCorrect
                        ? _getCorrectMessage()
                        : '${_currentQuestion.word.ku} = ${_currentQuestion.word.tr}',
                    style: AppTypography.label.copyWith(
                      color:
                          _isCorrect ? AppColors.success : AppColors.errorSoft,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (_isCorrect)
                  Text(
                    '+10 XP',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              ],
            ),

            Gap.md,

            // Berdewam button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isCorrect ? AppColors.success : AppColors.errorSoft,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  elevation: 0,
                ),
                child: Text('Berdewam',
                    style: AppTypography.labelLarge
                        .copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    ).animate().slideY(begin: 1.0, duration: 250.ms, curve: Curves.easeOut);
  }

  String _getCorrectMessage() {
    final messages = [
      'Aferin!',
      'Pir bask!',
      'Rast e!',
      'Geleki bask!',
      'Tu zana yi!',
    ];
    return messages[Random().nextInt(messages.length)];
  }

  // ── Exit Dialog ───────────────────────────────────────────────

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg)),
        backgroundColor: AppColors.surface,
        title: Text('Dersê bihêle?',
            style: AppTypography.title
                .copyWith(color: AppColors.textPrimary)),
        content: Text(
          'Eger tu derkevi, pesdahatina te ya vê dersê winda dibe.',
          style:
              AppTypography.body.copyWith(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Bimîne',
                style: AppTypography.label
                    .copyWith(color: AppColors.primary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.pop();
            },
            child: Text('Derkeve',
                style: AppTypography.label
                    .copyWith(color: AppColors.errorSoft)),
          ),
        ],
      ),
    );
  }

  // ── End Screen ────────────────────────────────────────────────

  Widget _buildEndScreen() {
    final showTr = ref.watch(showTurkishProvider);
    final accuracy = _questions.isNotEmpty
        ? (_correctCount / _questions.length * 100).round()
        : 0;

    final motivationalKu = _hearts > 0
        ? (accuracy >= 80
            ? 'Geleki bask! Tu zimane xwe bas dizani!'
            : accuracy >= 50
                ? 'Bask e! Her roj ferbuve!'
                : 'Bersiv xelet in bes tu ber bi pesdahatin ve dici!')
        : 'Xem neke! Cardin biceribine.';

    final motivationalTr = _hearts > 0
        ? (accuracy >= 80
            ? 'Harika! Dilini cok iyi biliyorsun!'
            : accuracy >= 50
                ? 'Guzel! Her gun ogrenmeye devam!'
                : 'Hatalar olsa da ilerliyorsun!')
        : 'Xemgîn nebe! Dîsa biceribîne.';

    final motivationalMessage = showTr
        ? '$motivationalKu\n$motivationalTr'
        : motivationalKu;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: AppSpacing.pagePadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Trophy or retry icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _hearts > 0
                          ? [AppColors.accent, AppColors.accentWarm]
                          : [AppColors.errorSoft, AppColors.errorSoft.withOpacity(0.7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (_hearts > 0
                                ? AppColors.accent
                                : AppColors.errorSoft)
                            .withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Icon(
                    _hearts > 0
                        ? Icons.emoji_events_rounded
                        : Icons.refresh_rounded,
                    size: 48,
                    color: Colors.white,
                  ),
                )
                    .animate()
                    .scale(
                      begin: const Offset(0, 0),
                      end: const Offset(1, 1),
                      duration: 600.ms,
                      curve: Curves.elasticOut,
                    )
                    .fadeIn(),

                Gap.xl,

                // Title
                Text(
                  _hearts > 0 ? 'Ders Qediya!' : 'Dil Qediya!',
                  style: AppTypography.display
                      .copyWith(color: AppColors.textPrimary),
                ).animate().fadeIn(delay: 200.ms),

                Gap.md,

                // Motivational message in Kurmancî
                Text(
                  motivationalMessage,
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyLarge
                      .copyWith(color: AppColors.textSecondary),
                ).animate().fadeIn(delay: 300.ms),

                Gap.xl,

                // Stats grid
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusLg),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatColumn(
                        icon: Icons.star_rounded,
                        iconColor: AppColors.accent,
                        value: '$_xp',
                        label: 'XP',
                      ),
                      Container(
                          width: 1,
                          height: 48,
                          color: AppColors.borderLight),
                      _buildStatColumn(
                        icon: Icons.check_circle_rounded,
                        iconColor: AppColors.success,
                        value: '$_correctCount/${_questions.length}',
                        label: 'Rast',
                      ),
                      Container(
                          width: 1,
                          height: 48,
                          color: AppColors.borderLight),
                      _buildStatColumn(
                        icon: Icons.percent_rounded,
                        iconColor: AppColors.primary,
                        value: '$accuracy%',
                        label: 'Rastbun',
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),

                Gap.xl,

                // Action buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Restart quiz
                      setState(() {
                        _questions =
                            _generateQuizSession(level: widget.level);
                        _currentIndex = 0;
                        _hearts = 3;
                        _xp = 0;
                        _correctCount = 0;
                        _answered = false;
                        _isCorrect = false;
                        _selectedOptionIndex = null;
                        _typedAnswer = '';
                        _typingController.clear();
                        _sessionComplete = false;
                      });
                    },
                    icon: const Icon(Icons.replay_rounded, size: 20),
                    label: Text('Cardin Biceribine',
                        style: AppTypography.labelLarge
                            .copyWith(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      elevation: 0,
                    ),
                  ),
                ).animate().fadeIn(delay: 500.ms),

                Gap.md,

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.home_rounded, size: 20),
                    label: Text('Mala Serekin',
                        style: AppTypography.labelLarge
                            .copyWith(color: AppColors.primary)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 550.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24, color: iconColor),
        const SizedBox(height: 6),
        Text(
          value,
          style: AppTypography.xpCounter.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style:
              AppTypography.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
