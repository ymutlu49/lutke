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
import '../../../shared/providers/review_provider.dart';
import '../../lessons/domain/a1_kelime_db.dart';
import '../../lessons/domain/a2_kelime_db.dart';
import '../../../core/services/sound_service.dart';
import '../../../shared/utils/word_emoji_map.dart';

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
  final String en;
  final String kat;
  final String cins;
  final String not_;
  final List<dynamic> her;
  final List<dynamic> gen;

  const _QuizWord({
    required this.id, required this.ku, required this.tr, required this.en,
    this.kat = '', this.cins = '', this.not_ = '',
    this.her = const [], this.gen = const [],
  });
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

  // Tüm kelimeleri al (alfabe harfleri dahil — açıklamaları quiz'de kullanılır)
  return raw
      .where((r) => r.ku.isNotEmpty && r.tr.isNotEmpty)
      .map((r) => _QuizWord(
        id: r.id, ku: r.ku, tr: r.tr, en: r.en,
        kat: r.kat ?? '', cins: r.cins ?? '', not_: r.not ?? '',
        her: r.her ?? [], gen: r.gen ?? [],
      ))
      .toList();
}

List<_QuizQuestion> _generateQuizSession({
  required String level,
  String? category,
  int questionCount = 10,
  bool showTurkish = true,
}) {
  final allWords = _loadWordsForLevel(level);
  // Filter by category if provided, but keep allWords for distractors
  var poolWords = category != null
      ? allWords.where((w) => w.kat == category).toList()
      : allWords;
  // Kategori yetersizse tüm seviye kelimelerinden quiz oluştur
  if (poolWords.length < 4) poolWords = allWords;
  if (poolWords.length < 4) return [];
  // Adjust questionCount if category has fewer words
  final effectiveCount = poolWords.length < questionCount ? poolWords.length : questionCount;

  final rng = Random();
  final shuffled = List<_QuizWord>.from(poolWords)..shuffle(rng);
  final sessionWords = shuffled.take(effectiveCount).toList();

  // Egzersiz tipi dagitimi: ~3 translation, ~3 reverse, ~2 listening, ~2 typing
  final baseTypes = <_ExerciseType>[
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
  // Ensure types list matches effectiveCount
  final types = List.generate(effectiveCount, (i) => baseTypes[i % baseTypes.length]);

  final questions = <_QuizQuestion>[];
  for (int i = 0; i < effectiveCount; i++) {
    final word = sessionWords[i];
    final type = types[i];
    List<String> options = [];

    if (type != _ExerciseType.typing) {
      // 4 secenek olustur: 1 dogru + 3 yanlis
      if (showTurkish) {
        // KU/TR modu: Kurmancî kelime → Türkçe seçenekler
        final isKuOptions = type == _ExerciseType.reverseTranslation;
        final correctAnswer = isKuOptions ? word.ku : word.tr;
        final distractors = allWords.where((w) => w.id != word.id).toList()..shuffle(rng);
        final wrongOptions = distractors.take(3).map((w) => isKuOptions ? w.ku : w.tr).toList();
        options = [correctAnswer, ...wrongOptions]..shuffle(rng);
      } else {
        // Tenê Kurmancî: Tüm seçenekler Kurmancî
        // Translation: Kurmancî cümle/tanım → Kurmancî kelime seçenekleri
        // Reverse: Kurmancî kelime → Kurmancî tanım/kategori seçenekleri
        final correctAnswer = word.ku;
        final distractors = allWords.where((w) => w.id != word.id).toList()..shuffle(rng);
        final wrongOptions = distractors.take(3).map((w) => w.ku).toList();
        options = [correctAnswer, ...wrongOptions]..shuffle(rng);
      }
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
  final String? category;
  const QuizScreen({super.key, this.level = 'A1', this.category});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen>
    with TickerProviderStateMixin {
  late List<_QuizQuestion> _questions;
  late bool _showTurkish;
  int _currentIndex = 0;
  int _hearts = 3;
  int _xp = 0;
  int _correctCount = 0;
  bool _answered = false;
  bool _isCorrect = false;
  int? _selectedOptionIndex;
  String _typedAnswer = '';
  bool _sessionComplete = false;
  bool _variantAccepted = false; // True when e->ê etc. variant was accepted
  String _variantNote = ''; // Note about which variant was accepted

  /// Per-question results: true = correct, false = wrong.
  final List<bool> _questionResults = [];

  // Animation controllers
  late AnimationController _shakeController;
  late AnimationController _correctFlashController;
  final _typingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _showTurkish = ref.read(showTurkishProvider);
    _questions = _generateQuizSession(level: widget.level, category: widget.category, showTurkish: _showTurkish);

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

      // Accept common Kurmancî variants: e->ê, i->î, u->û, c->ç, s->ş
      if (!correct) {
        final normalized = userInput
            .replaceAll('e', 'ê')
            .replaceAll('i', 'î')
            .replaceAll('u', 'û')
            .replaceAll('c', 'ç')
            .replaceAll('s', 'ş');
        final normalizedDist = _levenshteinDistance(normalized, expected);
        if (normalizedDist <= 1) {
          correct = true;
          _variantAccepted = true;
          // Build a note about which characters should be used
          final notes = <String>[];
          if (expected.contains('ê') && userInput.contains('e'))
            notes.add('ê bi xêr');
          if (expected.contains('î') && userInput.contains('i'))
            notes.add('î bi xêr');
          if (expected.contains('û') && userInput.contains('u'))
            notes.add('û bi xêr');
          if (expected.contains('ç') && userInput.contains('c'))
            notes.add('ç bi xêr');
          if (expected.contains('ş') && userInput.contains('s'))
            notes.add('ş bi xêr');
          _variantNote = notes.isNotEmpty
              ? '${notes.join(', ')} — tîpên Kurmancî bi kar bîne'
              : '';
        }
      }
    } else {
      // Multiple choice
      if (optionIndex == null) return;
      _selectedOptionIndex = optionIndex;

      final selected = q.options[optionIndex];
      final String correctAnswer;
      if (_showTurkish) {
        final isKuOptions = q.type == _ExerciseType.reverseTranslation;
        correctAnswer = isKuOptions ? q.word.ku : q.word.tr;
      } else {
        // Tenê Kurmancî: seçenekler hep Kurmancî, doğru cevap = word.ku
        correctAnswer = q.word.ku;
      }
      correct = selected == correctAnswer;
    }

    setState(() {
      _answered = true;
      _isCorrect = correct;
      _questionResults.add(correct);
    });

    if (correct) {
      _xp += 10;
      _correctCount++;
      _correctFlashController.forward(from: 0.0);
      HapticFeedback.lightImpact();
      SoundService.playCorrect();
    } else {
      _hearts = (_hearts - 1).clamp(0, 3);
      _shakeController.forward(from: 0.0);
      HapticFeedback.heavyImpact();
      SoundService.playWrong();
      // Smart Review: zayıf kelime olarak kaydet
      ref.read(reviewProvider.notifier).addWeakWord(q.word.id);
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
      _variantAccepted = false;
      _variantNote = '';
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

  // ── Kurmancî Soru Yardımcıları ─────────────────────────────────

  /// Heritage cümleden kelimeyi gizle
  String _maskWord(String sentence, String word) {
    // Kelimeyi ve ezafe formlarını gizle
    var masked = sentence;
    final forms = [word, '${word}ê', '${word}a', '${word}î', '${word}an'];
    for (final form in forms) {
      masked = masked.replaceAll(form, '____');
      masked = masked.replaceAll(form.toLowerCase(), '____');
    }
    return masked;
  }

  // ── 1. Translation: Kurmancî -> Tirkî ────────────────────────

  Widget _buildTranslationQuestion(_QuizQuestion q) {
    if (_showTurkish) {
      return Column(
        key: ValueKey('translation_${q.word.id}'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInstruction('Ev peyv bi Tirkî çi ye?', '', showTr: false),
          Gap.lg,
          _buildWordCard(q.word.ku, isKurmanji: true, kat: q.word.kat),
          const SizedBox(height: AppSpacing.questionToOptions),
          ..._buildOptionButtons(q),
        ],
      );
    }

    // Tenê Kurmancî: Kelimeyi göster → doğru anlamını seç
    return Column(
      key: ValueKey('translation_${q.word.id}'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInstruction('Ev peyv çi ye?', '', showTr: false),
        Gap.lg,
        _buildWordCard(q.word.ku, isKurmanji: true, kat: q.word.kat),
        const SizedBox(height: AppSpacing.questionToOptions),
        ..._buildOptionButtons(q),
      ],
    );
  }

  // ── 2. Reverse Translation ────────────────────────────────────

  Widget _buildReverseTranslationQuestion(_QuizQuestion q) {
    if (_showTurkish) {
      return Column(
        key: ValueKey('reverse_${q.word.id}'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInstruction('Ev peyv bi Kurmancî çi ye?', '', showTr: false),
          Gap.lg,
          _buildWordCard(q.word.tr, isKurmanji: false),
          const SizedBox(height: AppSpacing.questionToOptions),
          ..._buildOptionButtons(q),
        ],
      );
    }

    // Tenê Kurmancî: Heritage cümle göster → doğru kelimeyi seç
    final sentences = q.word.her;
    String hint;
    if (sentences is List && sentences.isNotEmpty) {
      hint = _maskWord(sentences[0].toString(), q.word.ku);
      if (!hint.contains('____')) {
        hint = '____';
      }
    } else {
      hint = '____';
    }

    return Column(
      key: ValueKey('reverse_${q.word.id}'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInstruction('Kîjan peyv rast e?', '', showTr: false),
        Gap.lg,
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primary.withOpacity(0.15)),
            ),
            child: Text(hint,
              style: AppTypography.kurmanji.copyWith(
                color: AppColors.textPrimary, fontSize: 18, height: 1.5),
              textAlign: TextAlign.center),
          ),
        ),
        const SizedBox(height: AppSpacing.questionToOptions),
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
        _buildInstruction('Guh bide û bersivê bide', 'Dinle ve cevapla',
            showTr: _showTurkish),

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
        _buildInstruction('Vê peyvê binivîse', '', showTr: false),

        Gap.lg,

        // Soru gösterimi — her iki modda da kelime kartı göster
        _buildWordCard(
          _showTurkish ? q.word.tr : q.word.ku,
          isKurmanji: !_showTurkish,
        ),

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
              hintText: 'Bersiva xwe binivîse...',
              hintStyle: AppTypography.body
                  .copyWith(color: AppColors.textTertiary),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: AppSpacing.md),
            ),
            onChanged: (v) => setState(() => _typedAnswer = v),
            onSubmitted: (_) {
              if (!_answered) _submitAnswer(typed: _typedAnswer);
            },
          ),
        ),

        // ── Kurmancî special characters keyboard ──────────
        if (!_answered) ...[
          const SizedBox(height: AppSpacing.sm),
          _KurmanciKeyboard(controller: _typingController, onChanged: (v) {
            setState(() => _typedAnswer = v);
          }),
        ],

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
    final expected = q.word.ku.trim();
    final userInput = _typedAnswer.trim();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: _isCorrect
            ? (_variantAccepted
                ? AppColors.warningSurface
                : AppColors.successSurface)
            : AppColors.errorSurface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: _isCorrect
              ? (_variantAccepted
                  ? AppColors.warning.withOpacity(0.3)
                  : AppColors.success.withOpacity(0.3))
              : AppColors.errorSoft.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _isCorrect
                    ? (_variantAccepted
                        ? Icons.info_rounded
                        : Icons.check_circle)
                    : Icons.cancel,
                color: _isCorrect
                    ? (_variantAccepted
                        ? AppColors.warning
                        : AppColors.success)
                    : AppColors.errorSoft,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _isCorrect
                      ? (_variantAccepted ? 'Nêzîk e!' : 'Aferin!')
                      : 'Rast bersiv:',
                  style: AppTypography.label.copyWith(
                    color: _isCorrect
                        ? (_variantAccepted
                            ? AppColors.warning
                            : AppColors.success)
                        : AppColors.errorSoft,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          // Variant accepted note
          if (_variantAccepted && _variantNote.isNotEmpty) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                _variantNote,
                style: AppTypography.caption.copyWith(
                  color: AppColors.warning,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
            ),
          ],

          // Character-by-character comparison on wrong answer
          if (!_isCorrect) ...[
            const SizedBox(height: 10),
            // User's input with char-by-char coloring
            Text(
              'Bersiva te:',
              style: AppTypography.caption.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 4),
            _CharByCharComparison(
              userInput: userInput,
              expected: expected,
            ),
            const SizedBox(height: 10),
            // Correct answer
            Text(
              'Bersiva rast:',
              style: AppTypography.caption.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              expected,
              style: AppTypography.kurmanji.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w600,
              ),
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

  Widget _buildWordCard(String word, {required bool isKurmanji, String kat = ''}) {
    final wordEmoji = isKurmanji ? emojiForWord(word, kat) : '';
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (wordEmoji.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(wordEmoji, style: const TextStyle(fontSize: 32)),
              ),
            Text(
              word,
              textAlign: TextAlign.center,
              style: isKurmanji
                  ? AppTypography.kurmanjiLarge
                  : AppTypography.headline.copyWith(color: AppColors.textPrimary),
            ),
          ],
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

      final String correctAnswer;
      if (_showTurkish) {
        final isKuOption = q.type == _ExerciseType.reverseTranslation;
        correctAnswer = isKuOption ? q.word.ku : q.word.tr;
      } else {
        correctAnswer = q.word.ku;
      }
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
                  style: (!_showTurkish || q.type == _ExerciseType.reverseTranslation
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
                        : _showTurkish
                            ? '${_currentQuestion.word.ku} = ${_currentQuestion.word.tr}'
                            : 'Bersiva rast: ${_currentQuestion.word.ku}',
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

            // "Rave bike?" butonu — yanlis cevaplarda aciklama goster
            if (!_isCorrect)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm),
                child: GestureDetector(
                  onTap: () => _showExplanationSheet(_currentQuestion),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('\u{1F4A1}', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 6),
                      Text(
                        'Rave bike?',
                        style: AppTypography.label.copyWith(
                          color: AppColors.errorSoft,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.errorSoft.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
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

  // ── Bersiva Min Rave Bike — Aciklama Alt Sayfasi ─────────────

  void _showExplanationSheet(_QuizQuestion question) {
    final word = question.word;

    // Dogru cevabi belirle
    final String correctAnswer;
    if (_showTurkish) {
      final isKuOptions = question.type == _ExerciseType.reverseTranslation;
      correctAnswer = isKuOptions ? word.ku : '${word.ku} = ${word.tr}';
    } else {
      correctAnswer = word.ku;
    }

    // Cinsiyet bilgisi
    final genderText = switch (word.cins) {
      'nêr'    => 'Cinsiyet: nêr (eril)',
      'mê'     => 'Cinsiyet: mê (disil)',
      'bêcins' => 'Cinsiyet: bêcins (cinsiyetsiz)',
      _        => '',
    };

    // Kategori emoji (kelime bazli, fallback: kitap)
    final emoji = emojiForWord(word.ku, word.kat).isNotEmpty
        ? emojiForWord(word.ku, word.kat)
        : '\u{1F4D6}';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(ctx).size.height * 0.7,
        ),
        decoration: const BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSpacing.radiusXl),
            topRight: Radius.circular(AppSpacing.radiusXl),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tutamac (handle)
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.borderLight,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Baslik
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: AppColors.primarySurface,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text('\u{1F4A1}', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Bersiva Min Rave Bike',
                        style: AppTypography.title.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.lg),

                // Dogru cevap — vurgulu kutu
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.successSurface,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    border: Border.all(
                      color: AppColors.success.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bersiva rast:',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        correctAnswer,
                        style: AppTypography.kurmanji.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Kategori ve cinsiyet bilgisi
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    if (word.kat.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primarySurface,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusFull),
                        ),
                        child: Text(
                          '$emoji ${word.kat}',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    if (genderText.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentSurface,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusFull),
                        ),
                        child: Text(
                          genderText,
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                  ],
                ),

                // Gramer aciklamasi (not alani)
                if (word.not_.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.warningSurface,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMd),
                      border: Border.all(
                        color: AppColors.warning.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.school_rounded,
                                size: 18, color: AppColors.warning),
                            const SizedBox(width: 8),
                            Text(
                              'Gramer',
                              style: AppTypography.label.copyWith(
                                color: AppColors.warning,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          word.not_,
                          style: AppTypography.bodyGrammar.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Ornek cumleler (her alani)
                if (word.her.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Minak:',
                    style: AppTypography.label.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...word.her.map((sentence) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\u{2022} ',
                          style: AppTypography.body.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            sentence.toString(),
                            style: AppTypography.body.copyWith(
                              color: AppColors.textPrimary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],

                const SizedBox(height: AppSpacing.lg),

                // "Famkirim!" butonu
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(),
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
                    child: Text(
                      'Famkirim!',
                      style: AppTypography.labelLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  // ── End Screen (Enhanced — Lesson Summary) ─────────────────────

  Widget _buildEndScreen() {
    final showTr = ref.watch(showTurkishProvider);
    final answeredCount = _questionResults.length;
    final accuracy = answeredCount > 0
        ? (_correctCount / answeredCount * 100).round()
        : 0;
    final accuracyFraction = answeredCount > 0
        ? _correctCount / answeredCount
        : 0.0;

    // ── Motivational Kurdish messages based on score ────────────
    final String motivationalKu;
    final String motivationalTr;
    if (accuracy == 100) {
      motivationalKu = 'Pîroz be! Tu pispor i!';
      motivationalTr = 'Tebrikler! Uzmansin!';
    } else if (accuracy >= 80) {
      motivationalKu = 'Zede bas! Pes dikevi!';
      motivationalTr = 'Cok iyi! Ilerliyorsun!';
    } else if (accuracy >= 50) {
      motivationalKu = 'Bas e! Berdewam bike!';
      motivationalTr = 'Iyi! Devam et!';
    } else {
      motivationalKu = 'Xemgin nebe! Dubare biceribine!';
      motivationalTr = 'Uzulme! Tekrar dene!';
    }

    final motivationalMessage = showTr
        ? '$motivationalKu\n$motivationalTr'
        : motivationalKu;

    // ── Collect word results ────────────────────────────────────
    final wordResults = <({_QuizWord word, bool correct})>[];
    for (int i = 0; i < answeredCount && i < _questions.length; i++) {
      wordResults.add((word: _questions[i].word, correct: _questionResults[i]));
    }
    final wrongWords = wordResults.where((r) => !r.correct).toList();
    final hasWrongWords = wrongWords.isNotEmpty;

    // ── XP breakdown ───────────────────────────────────────────
    final baseXP = _correctCount * 10;
    final streakBonus = _correctCount > 0 ? 3 : 0;
    final totalXP = baseXP + streakBonus;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.pagePadding,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                children: [
                  Gap.md,

                  // ── Mascot (happy or encouraging) ────────────
                  Image.asset(
                    'assets/images/mascot_128.png',
                    width: 128,
                    height: 128,
                    filterQuality: FilterQuality.medium,
                  ).animate()
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: -0.3, curve: Curves.easeOut),

                  Gap.sm,

                  // ── 1. Accuracy Ring ─────────────────────────
                  _AccuracyRing(
                    accuracy: accuracyFraction,
                    accuracyPercent: accuracy,
                    isSuccess: _hearts > 0,
                  ).animate()
                      .scale(
                        begin: const Offset(0, 0),
                        end: const Offset(1, 1),
                        duration: 700.ms,
                        curve: Curves.elasticOut,
                      )
                      .fadeIn(),

                  Gap.lg,

                  // Title
                  Text(
                    _hearts > 0 ? 'Ders Qediya!' : 'Dil Qediya!',
                    style: AppTypography.display
                        .copyWith(color: AppColors.textPrimary),
                  ).animate().fadeIn(delay: 200.ms),

                  Gap.sm,

                  // ── 5. Motivational Kurdish message ──────────
                  Text(
                    motivationalMessage,
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyLarge
                        .copyWith(color: AppColors.textSecondary),
                  ).animate().fadeIn(delay: 300.ms),

                  Gap.lg,

                  // ── 4. XP Breakdown ──────────────────────────
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'XP',
                          style: AppTypography.label.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Gap.sm,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatColumn(
                              icon: Icons.check_circle_rounded,
                              iconColor: AppColors.success,
                              value: '+$baseXP',
                              label: '$_correctCount rast x10',
                            ),
                            Container(
                                width: 1,
                                height: 48,
                                color: AppColors.borderLight),
                            _buildStatColumn(
                              icon: Icons.local_fire_department_rounded,
                              iconColor: AppColors.accent,
                              value: '+$streakBonus',
                              label: 'Streak bonus',
                            ),
                            Container(
                                width: 1,
                                height: 48,
                                color: AppColors.borderLight),
                            _buildStatColumn(
                              icon: Icons.star_rounded,
                              iconColor: AppColors.accent,
                              value: '$totalXP',
                              label: 'Gistayek',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),

                  Gap.lg,

                  // ── 2. Words Learned ─────────────────────────
                  if (wordResults.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.md),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Peyvên ve dersi',
                            style: AppTypography.label.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Gap.sm,
                          ...wordResults.asMap().entries.map((entry) {
                            final idx = entry.key;
                            final r = entry.value;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3),
                              child: Row(
                                children: [
                                  Icon(
                                    r.correct
                                        ? Icons.check_circle_rounded
                                        : Icons.cancel_rounded,
                                    size: 18,
                                    color: r.correct
                                        ? AppColors.success
                                        : AppColors.errorSoft,
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  Expanded(
                                    child: Text(
                                      r.word.ku,
                                      style: AppTypography.kurmanjiCard
                                          .copyWith(
                                        color: r.correct
                                            ? AppColors.textPrimary
                                            : AppColors.errorSoft,
                                      ),
                                    ),
                                  ),
                                  if (showTr)
                                    Text(
                                      r.word.tr,
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.textTertiary,
                                      ),
                                    ),
                                ],
                              ),
                            )
                                .animate()
                                .fadeIn(
                                  delay: Duration(
                                      milliseconds: 450 + idx * 60),
                                  duration: 250.ms,
                                )
                                .slideX(begin: 0.05, end: 0);
                          }),
                        ],
                      ),
                    ).animate().fadeIn(delay: 450.ms),

                  // ── 3. Weak Words ────────────────────────────
                  if (hasWrongWords) ...[
                    Gap.lg,
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.errorSurface,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusLg),
                        border: Border.all(
                          color: AppColors.errorSoft.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.replay_circle_filled_rounded,
                                size: 20,
                                color: AppColors.errorSoft,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                'Dubare bike!',
                                style: AppTypography.label.copyWith(
                                  color: AppColors.errorSoft,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Gap.sm,
                          Wrap(
                            spacing: AppSpacing.sm,
                            runSpacing: AppSpacing.xs,
                            children: wrongWords.map((r) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm + 2,
                                  vertical: AppSpacing.xs,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      AppSpacing.radiusFull),
                                  border: Border.all(
                                    color:
                                        AppColors.errorSoft.withOpacity(0.4),
                                  ),
                                ),
                                child: Text(
                                  r.word.ku,
                                  style: AppTypography.labelSmall.copyWith(
                                    color: AppColors.errorSoft,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 550.ms).slideY(begin: 0.1),
                  ],

                  Gap.lg,

                  // ── 7. "Dubare bike" — Review wrong words ────
                  if (hasWrongWords)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final wrongQuestions = <_QuizQuestion>[];
                          for (int i = 0;
                              i < answeredCount && i < _questions.length;
                              i++) {
                            if (!_questionResults[i]) {
                              wrongQuestions.add(_questions[i]);
                            }
                          }
                          if (wrongQuestions.isEmpty) return;
                          setState(() {
                            _questions = wrongQuestions;
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
                            _questionResults.clear();
                          });
                        },
                        icon: const Icon(Icons.replay_rounded, size: 20),
                        label: Text(
                          'Dubare bike',
                          style: AppTypography.labelLarge
                              .copyWith(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.errorSoft,
                          foregroundColor: Colors.white,
                          padding:
                              const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                AppSpacing.radiusMd),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ).animate().fadeIn(delay: 600.ms),

                  if (hasWrongWords) Gap.md,

                  // ── 8. "Waneye din" — New quiz ───────────────
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _questions = _generateQuizSession(
                            level: widget.level,
                            category: widget.category,
                            showTurkish: _showTurkish,
                          );
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
                          _questionResults.clear();
                        });
                      },
                      icon: const Icon(
                          Icons.arrow_forward_rounded, size: 20),
                      label: Text(
                        'Waneye din',
                        style: AppTypography.labelLarge
                            .copyWith(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding:
                            const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              AppSpacing.radiusMd),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ).animate().fadeIn(delay: 650.ms),

                  Gap.md,

                  // ── 6. Share button + Home ───────────────────
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Parvekirin di pesirojeyede te!',
                                  style: AppTypography.body.copyWith(
                                      color: Colors.white),
                                ),
                                backgroundColor: AppColors.primary,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: const Icon(Icons.share_rounded, size: 18),
                          label: Text(
                            'Parve bike',
                            style: AppTypography.label
                                .copyWith(color: AppColors.primary),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: const BorderSide(
                                color: AppColors.primary),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMd),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => context.pop(),
                          icon: const Icon(Icons.home_rounded, size: 18),
                          label: Text(
                            'Mala Serekin',
                            style: AppTypography.label
                                .copyWith(color: AppColors.primary),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: const BorderSide(
                                color: AppColors.primary),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMd),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 700.ms),

                  Gap.xl,
                ],
              ),
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

// ════════════════════════════════════════════════════════════════
// ACCURACY RING — Circular progress showing accuracy %
// ════════════════════════════════════════════════════════════════

class _AccuracyRing extends StatelessWidget {
  final double accuracy; // 0.0 - 1.0
  final int accuracyPercent; // 0 - 100
  final bool isSuccess;

  const _AccuracyRing({
    required this.accuracy,
    required this.accuracyPercent,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    final ringColor = isSuccess
        ? (accuracyPercent >= 80
            ? AppColors.success
            : accuracyPercent >= 50
                ? AppColors.accent
                : AppColors.errorSoft)
        : AppColors.errorSoft;

    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background ring
          SizedBox(
            width: 140,
            height: 140,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 10,
              color: ringColor.withOpacity(0.15),
              strokeCap: StrokeCap.round,
            ),
          ),
          // Progress ring
          SizedBox(
            width: 140,
            height: 140,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: accuracy),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return CircularProgressIndicator(
                  value: value,
                  strokeWidth: 10,
                  color: ringColor,
                  strokeCap: StrokeCap.round,
                );
              },
            ),
          ),
          // Center content
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSuccess
                    ? Icons.emoji_events_rounded
                    : Icons.refresh_rounded,
                size: 32,
                color: ringColor,
              ),
              const SizedBox(height: 4),
              Text(
                '$accuracyPercent%',
                style: AppTypography.streakCounter.copyWith(
                  color: ringColor,
                  fontSize: 28,
                ),
              ),
              Text(
                'Rastbun',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// KURMANCÎ KEYBOARD — Özel karakter butonları
// ════════════════════════════════════════════════════════════════

class _KurmanciKeyboard extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  /// Kurmancî special characters shown as tappable chips
  static const List<String> _chars = ['ê', 'î', 'û', 'ç', 'ş', 'x', 'q', 'w'];

  const _KurmanciKeyboard({
    required this.controller,
    required this.onChanged,
  });

  void _insertChar(String char) {
    final text = controller.text;
    final selection = controller.selection;
    final cursorPos = selection.isValid ? selection.baseOffset : text.length;

    final newText = text.substring(0, cursorPos) +
        char +
        text.substring(cursorPos);
    controller.text = newText;
    controller.selection = TextSelection.collapsed(
      offset: cursorPos + char.length,
    );
    onChanged(newText);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      alignment: WrapAlignment.center,
      children: _chars.map((char) {
        return GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            _insertChar(char);
          },
          child: Container(
            constraints: const BoxConstraints(minWidth: 38),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.borderMedium),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Text(
              char,
              textAlign: TextAlign.center,
              style: AppTypography.kurmanjiCard.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// CHAR-BY-CHAR COMPARISON — Harf harf karşılaştırma
// ════════════════════════════════════════════════════════════════

class _CharByCharComparison extends StatelessWidget {
  final String userInput;
  final String expected;

  const _CharByCharComparison({
    required this.userInput,
    required this.expected,
  });

  @override
  Widget build(BuildContext context) {
    final maxLen = userInput.length > expected.length
        ? userInput.length
        : expected.length;
    final spans = <InlineSpan>[];

    for (int i = 0; i < maxLen; i++) {
      if (i < userInput.length) {
        final userChar = userInput[i];
        final isCorrect =
            i < expected.length && userChar.toLowerCase() == expected[i].toLowerCase();
        final isMissing = i >= expected.length;

        spans.add(TextSpan(
          text: userChar,
          style: AppTypography.kurmanji.copyWith(
            color: isCorrect
                ? AppColors.success
                : isMissing
                    ? AppColors.textTertiary
                    : AppColors.errorSoft,
            fontWeight: FontWeight.w600,
            backgroundColor: isCorrect
                ? AppColors.success.withOpacity(0.08)
                : isMissing
                    ? Colors.transparent
                    : AppColors.errorSoft.withOpacity(0.08),
          ),
        ));
      } else {
        // Missing characters from user input
        spans.add(TextSpan(
          text: expected[i],
          style: AppTypography.kurmanji.copyWith(
            color: AppColors.textTertiary,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.textTertiary.withOpacity(0.5),
            decorationStyle: TextDecorationStyle.dashed,
          ),
        ));
      }
    }

    return Text.rich(TextSpan(children: spans));
  }
}
