import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../shared/widgets/speak_button.dart';
import '../../lessons/domain/a1_kelime_db.dart';

// Conditional import for direct TTS calls
import '../../../core/services/js_eval_stub.dart'
    if (dart.library.js_interop) '../../../core/services/js_eval_web.dart'
    as js_bridge;

// ════════════════════════════════════════════════════════════════
// LISTENING COMPREHENSION — Guhdarî bike
//
// Kurmancî heritage cümleleri "dinleme" simülasyonu.
// Gerçek ses dosyaları hazır olmadığından, metin gösterilir
// ve SpeakButton ile TTS kullanılır.
//
// 3 Soru Tipi:
// 1. Meaning: "Ev hevok çi dibêje?" — 4 seçenek
// 2. WordFind: "Kîjan peyv di hevokê de heye?" — 4 seçenek
// 3. FillBlank: "Hevokê temam bike" — boşluk doldur
//
// Session: 8 soru, heritage cümlelerinden
// ════════════════════════════════════════════════════════════════

// ── Veri Modelleri ─────────────────────────────────────────────

enum _ListeningQuestionType { meaning, wordFind, fillBlank }

class _ListeningWord {
  final String id;
  final String ku;
  final String tr;
  final String en;
  final List<String> her;

  const _ListeningWord({
    required this.id,
    required this.ku,
    required this.tr,
    required this.en,
    required this.her,
  });
}

class _ListeningQuestion {
  final _ListeningQuestionType type;
  final String sentence;       // Heritage cümle (Kurmancî)
  final String correctAnswer;
  final List<String> options;  // meaning & wordFind icin 4 secenek
  final String? blankSentence; // fillBlank icin bosluklu cumle
  final String? missingWord;   // fillBlank icin eksik kelime
  final _ListeningWord sourceWord;

  const _ListeningQuestion({
    required this.type,
    required this.sentence,
    required this.correctAnswer,
    this.options = const [],
    this.blankSentence,
    this.missingWord,
    required this.sourceWord,
  });
}

// ── Kelime Havuzu ──────────────────────────────────────────────

List<_ListeningWord> _loadListeningWords() {
  return kA1TamKelimeler
      .where((r) => r.ku.length > 1 && r.tr.length > 1 && (r.her as List).isNotEmpty)
      .map((r) => _ListeningWord(
            id: r.id,
            ku: r.ku,
            tr: r.tr,
            en: r.en,
            her: (r.her as List).cast<String>(),
          ))
      .toList();
}

// ── Soru Üretici ───────────────────────────────────────────────

List<_ListeningQuestion> _generateListeningSession({int questionCount = 8}) {
  final allWords = _loadListeningWords();
  if (allWords.length < 6) return [];

  final rng = Random();
  final shuffled = List<_ListeningWord>.from(allWords)..shuffle(rng);
  final count = min(questionCount, shuffled.length);
  final sessionWords = shuffled.take(count).toList();

  // Soru tipi dagitimi: ~3 meaning, ~3 wordFind, ~2 fillBlank
  final baseTypes = <_ListeningQuestionType>[
    _ListeningQuestionType.meaning,
    _ListeningQuestionType.meaning,
    _ListeningQuestionType.meaning,
    _ListeningQuestionType.wordFind,
    _ListeningQuestionType.wordFind,
    _ListeningQuestionType.wordFind,
    _ListeningQuestionType.fillBlank,
    _ListeningQuestionType.fillBlank,
  ]..shuffle(rng);

  final questions = <_ListeningQuestion>[];

  for (int i = 0; i < count; i++) {
    final word = sessionWords[i];
    final type = baseTypes[i % baseTypes.length];
    final sentence = word.her[rng.nextInt(word.her.length)];

    switch (type) {
      case _ListeningQuestionType.meaning:
        // Dogru cevap: Turkce karsiligi
        final correct = word.tr;
        final distractors = (List<_ListeningWord>.from(allWords)
              ..remove(word)
              ..shuffle(rng))
            .take(3)
            .map((w) => w.tr)
            .toList();
        final options = [correct, ...distractors]..shuffle(rng);
        questions.add(_ListeningQuestion(
          type: type,
          sentence: sentence,
          correctAnswer: correct,
          options: options,
          sourceWord: word,
        ));
        break;

      case _ListeningQuestionType.wordFind:
        // Cumlede gecen bir kelimeyi bul
        final sentenceWords = sentence
            .replaceAll(RegExp(r'[.,!?;:""—–]'), '')
            .split(' ')
            .where((w) => w.length > 1)
            .toList();
        if (sentenceWords.isEmpty) {
          // Fallback to meaning type
          final correct = word.tr;
          final distractors = (List<_ListeningWord>.from(allWords)
                ..remove(word)
                ..shuffle(rng))
              .take(3)
              .map((w) => w.tr)
              .toList();
          final options = [correct, ...distractors]..shuffle(rng);
          questions.add(_ListeningQuestion(
            type: _ListeningQuestionType.meaning,
            sentence: sentence,
            correctAnswer: correct,
            options: options,
            sourceWord: word,
          ));
          break;
        }

        final correctWord = sentenceWords[rng.nextInt(sentenceWords.length)];
        // 3 yanlis kelime — baska cumlelerden
        final otherWords = <String>[];
        for (final w in allWords) {
          if (w.id == word.id) continue;
          for (final h in w.her) {
            final ws = h
                .replaceAll(RegExp(r'[.,!?;:""—–]'), '')
                .split(' ')
                .where((s) => s.length > 1 && s != correctWord)
                .toList();
            if (ws.isNotEmpty) {
              otherWords.add(ws[rng.nextInt(ws.length)]);
            }
            if (otherWords.length >= 8) break;
          }
          if (otherWords.length >= 8) break;
        }
        otherWords.shuffle(rng);
        final distractorWords = otherWords.take(3).toList();
        // Ensure we have enough distractors
        while (distractorWords.length < 3) {
          distractorWords.add('peyv${distractorWords.length}');
        }
        final options = [correctWord, ...distractorWords]..shuffle(rng);
        questions.add(_ListeningQuestion(
          type: type,
          sentence: sentence,
          correctAnswer: correctWord,
          options: options,
          sourceWord: word,
        ));
        break;

      case _ListeningQuestionType.fillBlank:
        // Cumlede bir kelimeyi bosalt
        final sentenceWords = sentence.split(' ');
        final longWords = sentenceWords.where((w) => w.length > 2).toList();
        if (longWords.isEmpty) {
          // Fallback to meaning
          final correct = word.tr;
          final distractors = (List<_ListeningWord>.from(allWords)
                ..remove(word)
                ..shuffle(rng))
              .take(3)
              .map((w) => w.tr)
              .toList();
          final opts = [correct, ...distractors]..shuffle(rng);
          questions.add(_ListeningQuestion(
            type: _ListeningQuestionType.meaning,
            sentence: sentence,
            correctAnswer: correct,
            options: opts,
            sourceWord: word,
          ));
          break;
        }

        final missing = longWords[rng.nextInt(longWords.length)];
        final blanked = sentence.replaceFirst(missing, '____');
        // 3 distractor words
        final fillDistractors = <String>[];
        for (final w in allWords) {
          if (w.id == word.id) continue;
          final ws = w.ku;
          if (ws.length > 2 && ws != missing && !fillDistractors.contains(ws)) {
            fillDistractors.add(ws);
          }
          if (fillDistractors.length >= 3) break;
        }
        while (fillDistractors.length < 3) {
          fillDistractors.add('kelîme${fillDistractors.length}');
        }
        final fillOptions = [missing, ...fillDistractors.take(3)]..shuffle(rng);
        questions.add(_ListeningQuestion(
          type: type,
          sentence: sentence,
          correctAnswer: missing,
          options: fillOptions,
          blankSentence: blanked,
          missingWord: missing,
          sourceWord: word,
        ));
        break;
    }
  }

  return questions;
}

// ════════════════════════════════════════════════════════════════
// LISTENING SCREEN
// ════════════════════════════════════════════════════════════════

class ListeningScreen extends ConsumerStatefulWidget {
  const ListeningScreen({super.key});

  @override
  ConsumerState<ListeningScreen> createState() => _ListeningScreenState();
}

class _ListeningScreenState extends ConsumerState<ListeningScreen>
    with TickerProviderStateMixin {
  late List<_ListeningQuestion> _questions;
  int _currentIndex = 0;
  int _correctCount = 0;
  int _hearts = 3;
  bool _isSlowMode = false;
  bool _answered = false;
  String? _selectedOption;
  bool _sentenceRevealed = false;
  bool _isPlaying = false; // TTS playback state for waveform

  // Typewriter animation
  String _displayedText = '';
  Timer? _typewriterTimer;

  @override
  void initState() {
    super.initState();
    _questions = _generateListeningSession(questionCount: 8);
    if (_questions.isNotEmpty) {
      _startTypewriter();
    }
  }

  @override
  void dispose() {
    _typewriterTimer?.cancel();
    super.dispose();
  }

  void _startTypewriter() {
    _typewriterTimer?.cancel();
    _displayedText = '';
    _sentenceRevealed = false;

    final sentence = _questions[_currentIndex].sentence;
    final words = sentence.split(' ');
    int wordIndex = 0;

    final interval = _isSlowMode ? 400 : 200;

    _typewriterTimer = Timer.periodic(Duration(milliseconds: interval), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (wordIndex < words.length) {
        setState(() {
          _displayedText = words.sublist(0, wordIndex + 1).join(' ');
        });
        wordIndex++;
      } else {
        timer.cancel();
        if (mounted) {
          setState(() => _sentenceRevealed = true);
        }
      }
    });
  }

  /// Play TTS for given text at a specific rate (for correct answer auto-play)
  void _playTts(String text, {double rate = 0.85}) {
    if (!kIsWeb) return;
    final escaped = text
        .replaceAll("'", "\\'")
        .replaceAll('"', '\\"')
        .replaceAll('\n', ' ');
    final script = '''
      (function() {
        const u = new SpeechSynthesisUtterance('$escaped');
        u.lang = 'tr-TR';
        u.rate = $rate;
        u.pitch = 1.0;
        speechSynthesis.cancel();
        speechSynthesis.speak(u);
      })();
    ''';
    try {
      js_bridge.evalJs(script);
    } catch (_) {}
  }

  /// Replay current sentence TTS with speed setting
  void _replayTts() {
    if (_questions.isEmpty) return;
    final sentence = _questions[_currentIndex].sentence;
    final rate = _isSlowMode ? 0.7 : 0.85;
    _playTts(sentence, rate: rate);
    setState(() => _isPlaying = true);
    // Estimate duration and reset playing state
    final words = sentence.split(' ').length;
    final durationSec = ((words * 0.5 + 1.5) / rate).clamp(2.0, 10.0).toInt();
    Future.delayed(Duration(seconds: durationSec), () {
      if (mounted) setState(() => _isPlaying = false);
    });
  }

  /// Auto-play the correct answer via TTS after answering
  void _playCorrectAnswer() {
    if (_questions.isEmpty) return;
    final question = _questions[_currentIndex];
    // Play the full sentence so user hears correct pronunciation
    _playTts(question.sentence, rate: 0.8);
  }

  void _onOptionSelected(String option) {
    if (_answered) return;

    HapticFeedback.lightImpact();

    final question = _questions[_currentIndex];
    final isCorrect = option == question.correctAnswer;

    setState(() {
      _answered = true;
      _selectedOption = option;
      if (isCorrect) {
        _correctCount++;
        HapticFeedback.mediumImpact();
      } else {
        _hearts = (_hearts - 1).clamp(0, 3);
        HapticFeedback.heavyImpact();
      }
    });

    // Auto-play correct answer TTS so user hears the right pronunciation
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _playCorrectAnswer();
    });

    // Sonraki soruya gec (increased delay to allow TTS to finish)
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      if (_hearts <= 0 || _currentIndex >= _questions.length - 1) {
        _showResults();
      } else {
        setState(() {
          _currentIndex++;
          _answered = false;
          _selectedOption = null;
          _isPlaying = false;
        });
        _startTypewriter();
      }
    });
  }

  void _showResults() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => _ResultsSheet(
        correct: _correctCount,
        total: _currentIndex + 1,
        onClose: () {
          Navigator.of(context).pop();
          context.pop();
        },
        onRetry: () {
          Navigator.of(context).pop();
          setState(() {
            _questions = _generateListeningSession(questionCount: 8);
            _currentIndex = 0;
            _correctCount = 0;
            _hearts = 3;
            _answered = false;
            _selectedOption = null;
          });
          if (_questions.isNotEmpty) _startTypewriter();
        },
      ),
    );
  }

  void _toggleSpeed() {
    HapticFeedback.selectionClick();
    setState(() {
      _isSlowMode = !_isSlowMode;
    });
    // Restart typewriter with new speed
    _startTypewriter();
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: AppColors.textPrimary),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(
          child: Text(
            'Peyvên bes tune ne.',
            style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    final question = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header: Close + Progress + Hearts ──────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  // Close button
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.textSecondary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  // Progress bar
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,
                        backgroundColor: AppColors.borderLight,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  // Hearts
                  Row(
                    children: List.generate(3, (i) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Icon(
                          i < _hearts
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: i < _hearts
                              ? AppColors.errorSoft
                              : AppColors.textTertiary,
                          size: 22,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms),

            // ── Soru numarasi ──────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${_currentIndex + 1} / ${_questions.length}',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // ── Dinleme Alani ──────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Column(
                  children: [
                    // Speaker button + sentence + waveform
                    _AudioSimulationCard(
                      sentence: question.sentence,
                      displayedText: _displayedText,
                      sentenceRevealed: _sentenceRevealed,
                      isSlowMode: _isSlowMode,
                      isPlaying: _isPlaying,
                      onToggleSpeed: _toggleSpeed,
                      onReplay: () {
                        _startTypewriter();
                        _replayTts();
                      },
                      onReplayTts: _replayTts,
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Question prompt
                    _QuestionPrompt(type: question.type),

                    const SizedBox(height: AppSpacing.md),

                    // FillBlank: bosluklu cumle goster
                    if (question.type == _ListeningQuestionType.fillBlank &&
                        question.blankSentence != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: Text(
                          question.blankSentence!,
                          textAlign: TextAlign.center,
                          style: AppTypography.kurmanji.copyWith(
                            color: AppColors.primary,
                          ),
                        ).animate().fadeIn(delay: 200.ms),
                      ),

                    // Options
                    ...question.options.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final option = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.optionGap),
                        child: _OptionButton(
                          text: option,
                          isSelected: _selectedOption == option,
                          isCorrect: option == question.correctAnswer,
                          showResult: _answered,
                          onTap: () => _onOptionSelected(option),
                          delay: 300 + idx * 80,
                        ),
                      );
                    }),

                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// AUDIO SIMULATION CARD
// Buyuk speaker butonu + typewriter cumle + hiz kontrolu
// ════════════════════════════════════════════════════════════════

class _AudioSimulationCard extends StatelessWidget {
  final String sentence;
  final String displayedText;
  final bool sentenceRevealed;
  final bool isSlowMode;
  final bool isPlaying;
  final VoidCallback onToggleSpeed;
  final VoidCallback onReplay;
  final VoidCallback onReplayTts;

  const _AudioSimulationCard({
    required this.sentence,
    required this.displayedText,
    required this.sentenceRevealed,
    required this.isSlowMode,
    required this.isPlaying,
    required this.onToggleSpeed,
    required this.onReplay,
    required this.onReplayTts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.15),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Speaker button (uses SpeakButton from speak_button.dart)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Large play/speak button
              SpeakButton(
                text: sentence,
                size: 72,
                color: AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.md),
              // "Dubare guhdari bike" (Listen again) button
              GestureDetector(
                onTap: onReplayTts,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.2),
                        ),
                      ),
                      child: const Icon(
                        Icons.replay_rounded,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Dubare\nguhdarî bike',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 9,
                        color: AppColors.primary.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          // Waveform animation during playback
          _WaveformAnimation(isPlaying: isPlaying),

          const SizedBox(height: AppSpacing.sm),

          // Speed toggle with explicit rate values
          GestureDetector(
            onTap: onToggleSpeed,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs + 2,
              ),
              decoration: BoxDecoration(
                color: isSlowMode
                    ? AppColors.accent.withOpacity(0.12)
                    : AppColors.backgroundTertiary,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSlowMode
                      ? AppColors.accent.withOpacity(0.3)
                      : AppColors.borderLight,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSlowMode ? Icons.slow_motion_video : Icons.speed,
                    size: 16,
                    color: isSlowMode ? AppColors.accent : AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    isSlowMode ? 'Hedi (0.7x)' : 'Normal (1.0x)',
                    style: AppTypography.labelSmall.copyWith(
                      color: isSlowMode ? AppColors.accent : AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // Typewriter text
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: isSlowMode
                ? AppTypography.kurmanjiLarge.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.6,
                  )
                : AppTypography.kurmanji.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.6,
                  ),
            child: Text(
              displayedText,
              textAlign: TextAlign.center,
            ),
          ),

          // Cursor blink while typing
          if (!sentenceRevealed)
            const Text(
              '|',
              style: TextStyle(
                fontSize: 22,
                color: AppColors.primary,
                fontWeight: FontWeight.w300,
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).fadeIn(
                  duration: 500.ms,
                ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.05);
  }
}

// ════════════════════════════════════════════════════════════════
// WAVEFORM ANIMATION — Animated bars during TTS playback
// ════════════════════════════════════════════════════════════════

class _WaveformAnimation extends StatelessWidget {
  final bool isPlaying;
  const _WaveformAnimation({required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    if (!isPlaying) {
      // Static small bars when not playing
      return SizedBox(
        height: 24,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(7, (i) {
            return Container(
              width: 3,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        ),
      );
    }

    // Animated waveform bars
    return SizedBox(
      height: 28,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(7, (i) {
          // Different delays per bar for wave effect
          final delay = (i * 80).ms;
          final maxHeight = [14.0, 22.0, 18.0, 26.0, 18.0, 22.0, 14.0][i];
          return Container(
            width: 3,
            height: maxHeight,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          )
              .animate(
                onPlay: (c) => c.repeat(reverse: true),
              )
              .scaleY(
                begin: 0.3,
                end: 1.0,
                delay: delay,
                duration: 400.ms,
                curve: Curves.easeInOut,
              )
              .fadeIn(duration: 200.ms);
        }),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// QUESTION PROMPT
// ════════════════════════════════════════════════════════════════

class _QuestionPrompt extends StatelessWidget {
  final _ListeningQuestionType type;
  const _QuestionPrompt({required this.type});

  @override
  Widget build(BuildContext context) {
    final (question, subtitle) = switch (type) {
      _ListeningQuestionType.meaning => (
          'Ev hevok çi dibêje?',
          'Bu cumle ne diyor?',
        ),
      _ListeningQuestionType.wordFind => (
          'Kîjan peyv di hevokê de heye?',
          'Hangi kelime cumlede var?',
        ),
      _ListeningQuestionType.fillBlank => (
          'Hevokê temam bike',
          'Cumleyi tamamla',
        ),
    };

    return Column(
      children: [
        Text(
          question,
          textAlign: TextAlign.center,
          style: AppTypography.title.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AppTypography.caption.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
      ],
    ).animate().fadeIn(delay: 150.ms, duration: 300.ms);
  }
}

// ════════════════════════════════════════════════════════════════
// OPTION BUTTON
// ════════════════════════════════════════════════════════════════

class _OptionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;
  final VoidCallback onTap;
  final int delay;

  const _OptionButton({
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.showResult,
    required this.onTap,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color borderColor;
    Color textColor;
    IconData? trailingIcon;

    if (showResult && isCorrect) {
      bgColor = AppColors.successSurface;
      borderColor = AppColors.success;
      textColor = AppColors.success;
      trailingIcon = Icons.check_circle_rounded;
    } else if (showResult && isSelected && !isCorrect) {
      bgColor = AppColors.errorSurface;
      borderColor = AppColors.errorSoft;
      textColor = AppColors.errorSoft;
      trailingIcon = Icons.cancel_rounded;
    } else if (isSelected) {
      bgColor = AppColors.primarySurface;
      borderColor = AppColors.primary;
      textColor = AppColors.primary;
    } else {
      bgColor = AppColors.surface;
      borderColor = AppColors.borderLight;
      textColor = AppColors.textPrimary;
    }

    return GestureDetector(
      onTap: showResult ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: borderColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: AppTypography.kurmanjiCard.copyWith(
                  color: textColor,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
            if (trailingIcon != null)
              Icon(trailingIcon, color: textColor, size: 24)
                  .animate()
                  .scale(begin: const Offset(0.5, 0.5), duration: 200.ms),
          ],
        ),
      ),
    ).animate().fadeIn(
          delay: Duration(milliseconds: delay),
          duration: 250.ms,
        );
  }
}

// ════════════════════════════════════════════════════════════════
// RESULTS SHEET
// ════════════════════════════════════════════════════════════════

class _ResultsSheet extends StatelessWidget {
  final int correct;
  final int total;
  final VoidCallback onClose;
  final VoidCallback onRetry;

  const _ResultsSheet({
    required this.correct,
    required this.total,
    required this.onClose,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = total > 0 ? (correct / total * 100).round() : 0;
    final isGreat = percentage >= 75;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.borderLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Emoji & Title
          Text(
            isGreat ? 'Aferin!' : 'Bes e!',
            style: AppTypography.display.copyWith(
              color: AppColors.textPrimary,
            ),
          ).animate().fadeIn().scale(
                begin: const Offset(0.8, 0.8),
                duration: 400.ms,
                curve: Curves.elasticOut,
              ),

          const SizedBox(height: AppSpacing.sm),

          Text(
            isGreat
                ? 'Guhdariya te pir baş e!'
                : 'Her gav pir hêjayî ye ku tu hewl didî!',
            textAlign: TextAlign.center,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Score circle
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isGreat
                  ? AppColors.successSurface
                  : AppColors.warningSurface,
              border: Border.all(
                color: isGreat ? AppColors.success : AppColors.warning,
                width: 3,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$correct/$total',
                    style: AppTypography.kurmanjiLarge.copyWith(
                      color: isGreat ? AppColors.success : AppColors.warning,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'rast',
                    style: AppTypography.caption.copyWith(
                      color: isGreat ? AppColors.success : AppColors.warning,
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 200.ms).scale(
                begin: const Offset(0.6, 0.6),
                duration: 500.ms,
                curve: Curves.elasticOut,
              ),

          const SizedBox(height: AppSpacing.xl),

          // Buttons
          Row(
            children: [
              // Retry button
              Expanded(
                child: GestureDetector(
                  onTap: onRetry,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary, width: 1.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        'Dubare',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              // Close button
              Expanded(
                child: GestureDetector(
                  onTap: onClose,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryDark],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        'Temam',
                        style: AppTypography.labelLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}
