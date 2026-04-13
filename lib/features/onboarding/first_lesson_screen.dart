import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/providers/language_mode_provider.dart';

/// İlk Ders Ekranı — Kayıtsız 3 Alıştırma
///
/// "Play first, profile second" + "Feel first, play second"
/// Kullanıcı kayıt olmadan hemen 3 alıştırma yapıyor.
/// Pasif anlama testindeki sonuca göre kişiselleştirilmiş.
///
/// Egzersizler:
/// 1. Ses dinle → 4 seçenekten seç (dinleme)
/// 2. Cümleyi tamamla — sürükle bırak (okuma+anlama)
/// 3. Tekrar et → değerlendir (konuşma pratiği)

class _Exercise {
  final String type; // 'listen_select', 'complete', 'speak'
  final String kurmanjText;
  final String translation;       // Turkish translation
  final String translationEn;     // English translation (Kurdish-only mode)
  final List<String>? options;    // Turkish options
  final List<String>? optionsEn;  // English options (Kurdish-only mode)
  final int? correctIndex;
  final String? hint;             // Turkish hint
  final String? hintEn;           // English hint (Kurdish-only mode)

  const _Exercise({
    required this.type,
    required this.kurmanjText,
    required this.translation,
    required this.translationEn,
    this.options,
    this.optionsEn,
    this.correctIndex,
    this.hint,
    this.hintEn,
  });
}

const _exercises = [
  _Exercise(
    type: 'listen_select',
    kurmanjText: 'Silav',
    translation: 'Merhaba',
    translationEn: 'Hello',
    options: ['Merhaba', 'Teşekkür', 'Günaydın', 'İyi geceler'],
    optionsEn: ['Hello', 'Thank you', 'Good morning', 'Good night'],
    correctIndex: 0,
    hint: 'Kürtçede en yaygın selamlama',
    hintEn: 'The most common greeting in Kurdish',
  ),
  _Exercise(
    type: 'listen_select',
    kurmanjText: 'Spas',
    translation: 'Teşekkür ederim',
    translationEn: 'Thank you',
    options: ['Özür dilerim', 'Hoşça kal', 'Teşekkür ederim', 'Tamam'],
    optionsEn: ['I\'m sorry', 'Goodbye', 'Thank you', 'OK'],
    correctIndex: 2,
    hint: '"Spas" — kalp sıcaklığıyla söylenir',
    hintEn: '"Spas" — said with heartfelt warmth',
  ),
  _Exercise(
    type: 'listen_select',
    kurmanjText: 'Baş e',
    translation: 'İyi / Tamam',
    translationEn: 'Good / OK',
    options: ['Hayır', 'İyi / Tamam', 'Belki', 'Bilmiyorum'],
    optionsEn: ['No', 'Good / OK', 'Maybe', 'I don\'t know'],
    correctIndex: 1,
    hint: '"Baş" — iyi demek. "Baş e" — iyi/tamam demek.',
    hintEn: '"Baş" — means good. "Baş e" — means good/OK.',
  ),
];

// ── Ekran ────────────────────────────────────────────────────────

class FirstLessonScreen extends ConsumerStatefulWidget {
  const FirstLessonScreen({super.key});

  @override
  ConsumerState<FirstLessonScreen> createState() => _FirstLessonScreenState();
}

class _FirstLessonScreenState extends ConsumerState<FirstLessonScreen> {
  int _currentIndex = 0;
  int? _selectedAnswer;
  bool _isAnswered = false;
  int _correctCount = 0;
  bool _isComplete = false;

  _Exercise get _current => _exercises[_currentIndex];

  void _selectAnswer(int index) {
    if (_isAnswered) return;
    setState(() {
      _selectedAnswer = index;
      _isAnswered = true;
      if (index == _current.correctIndex) _correctCount++;
    });
  }

  void _next() {
    if (_currentIndex >= _exercises.length - 1) {
      setState(() => _isComplete = true);
    } else {
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _isAnswered = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isComplete) return _CompletionScreen(correctCount: _correctCount);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Progress + Kapat ──────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md, AppSpacing.md, AppSpacing.md, 0),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: AppRadius.full,
                      child: LinearProgressIndicator(
                        value: (_currentIndex + (_isAnswered ? 1 : 0)) /
                            _exercises.length,
                        backgroundColor: AppColors.primarySurface,
                        color: AppColors.primary,
                        minHeight: 8,
                      ),
                    ),
                  ),
                  Gap.hSm,
                  Text(
                    '${_currentIndex + 1}/${_exercises.length}',
                    style: AppTypography.captionStrong,
                  ),
                ],
              ),
            ),

            // ── Egzersiz İçeriği — scrollable ─────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: AppSpacing.pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Gap.lg,

                    // Yönerge
                    Builder(
                      builder: (context) {
                        final showTr = ref.watch(showTurkishProvider);
                        return Text(
                          showTr ? 'Ne anlama geliyor?' : 'Wateya wê çi ye?',
                          style: AppTypography.headline,
                        );
                      },
                    ).animate(key: ValueKey(_currentIndex)).fadeIn(duration: 300.ms),

                    Gap.xl,

                    // Kurmancî kelime kartı
                    _WordCard(exercise: _current)
                        .animate(key: ValueKey('card_$_currentIndex'))
                        .fadeIn(duration: 400.ms)
                        .scale(begin: const Offset(0.95, 0.95)),

                    Gap.xl,

                    // Seçenekler
                    ...(() {
                      final showTr = ref.watch(showTurkishProvider);
                      final opts = showTr
                          ? (_current.options ?? [])
                          : (_current.optionsEn ?? _current.options ?? []);
                      return opts.asMap().entries.map((entry) {
                      final i = entry.key;
                      final option = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: _AnswerButton(
                          text: option,
                          state: _isAnswered
                              ? (i == _current.correctIndex
                                  ? _AnswerState.correct
                                  : i == _selectedAnswer
                                      ? _AnswerState.wrong
                                      : _AnswerState.neutral)
                              : _AnswerState.idle,
                          onTap: () => _selectAnswer(i),
                          delay: Duration(milliseconds: 100 + i * 60),
                        ),
                      );
                    });
                    })(),
                  ],
                ),
              ),
            ),

            // ── Alt Bar ───────────────────────────────────────
            if (_isAnswered)
              _AnswerFeedbackBar(
                isCorrect: _selectedAnswer == _current.correctIndex,
                hint: _current.hint ?? '',
                hintEn: _current.hintEn ?? '',
                kurmanjWord: _current.kurmanjText,
                translation: _current.translation,
                translationEn: _current.translationEn,
                onNext: _next,
                isLast: _currentIndex >= _exercises.length - 1,
              ),
          ],
        ),
      ),
    );
  }
}

// ── Kelime Kartı ─────────────────────────────────────────────────

class _WordCard extends ConsumerStatefulWidget {
  final _Exercise exercise;
  const _WordCard({required this.exercise});

  @override
  ConsumerState<_WordCard> createState() => _WordCardState();
}

class _WordCardState extends ConsumerState<_WordCard> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _isPlaying = true);
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) setState(() => _isPlaying = false);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: AppRadius.lg,
          border: Border.all(
            color: AppColors.borderLight,
            width: AppSpacing.borderThin,
          ),
        ),
        child: Column(
          children: [
            // Kurmancî kelime — büyük, birincil
            Text(
              widget.exercise.kurmanjText,
              style: AppTypography.kurmanjiLarge,
              textAlign: TextAlign.center,
            ),
            Gap.md,
            // Ses ikonu
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: _isPlaying
                    ? AppColors.primarySurface
                    : AppColors.backgroundPrimary,
                borderRadius: AppRadius.full,
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Icon(
                _isPlaying ? Icons.volume_up : Icons.volume_up_outlined,
                color: _isPlaying ? AppColors.primary : AppColors.textSecondary,
                size: 20,
              ),
            ),
            Gap.xs,
            Builder(
              builder: (context) {
                final showTr = ref.watch(showTurkishProvider);
                return Text(
                  showTr ? 'Sesi duy' : 'Deng lê bide',
                  style: AppTypography.caption.copyWith(color: AppColors.primary),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ── Cevap Butonu ─────────────────────────────────────────────────

enum _AnswerState { idle, correct, wrong, neutral }

class _AnswerButton extends StatelessWidget {
  final String text;
  final _AnswerState state;
  final VoidCallback onTap;
  final Duration delay;

  const _AnswerButton({
    required this.text,
    required this.state,
    required this.onTap,
    required this.delay,
  });

  Color get _bgColor => switch (state) {
        _AnswerState.correct => AppColors.successSurface,
        _AnswerState.wrong => AppColors.errorSurface,
        _AnswerState.neutral => AppColors.backgroundSecondary,
        _AnswerState.idle => AppColors.backgroundSecondary,
      };

  Color get _borderColor => switch (state) {
        _AnswerState.correct => AppColors.success,
        _AnswerState.wrong => AppColors.errorSoft,
        _AnswerState.neutral => AppColors.borderLight,
        _AnswerState.idle => AppColors.borderLight,
      };

  Color get _textColor => switch (state) {
        _AnswerState.correct => AppColors.success,
        _AnswerState.wrong => AppColors.errorSoft,
        _AnswerState.neutral => AppColors.textPrimary,
        _AnswerState.idle => AppColors.textPrimary,
      };

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: AppSpacing.touchPreferred,
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: AppRadius.md,
        border: Border.all(color: _borderColor, width: AppSpacing.borderMedium),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: state == _AnswerState.idle ? onTap : null,
          borderRadius: AppRadius.md,
          child: Padding(
            padding: AppSpacing.buttonPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state == _AnswerState.correct)
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: Icon(Icons.check_circle, color: AppColors.success, size: 18),
                  ),
                if (state == _AnswerState.wrong)
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: Icon(Icons.cancel_outlined, color: AppColors.errorSoft, size: 18),
                  ),
                Text(text,
                    style: AppTypography.label.copyWith(color: _textColor)),
              ],
            ),
          ),
        ),
      ),
    ).animate(delay: delay).fadeIn(duration: 300.ms).slideX(begin: 0.05, end: 0);
  }
}

// ── Alt Geri Bildirim Barı ───────────────────────────────────────

class _AnswerFeedbackBar extends ConsumerWidget {
  final bool isCorrect;
  final String hint;
  final String hintEn;
  final String kurmanjWord;
  final String translation;
  final String translationEn;
  final VoidCallback onNext;
  final bool isLast;

  const _AnswerFeedbackBar({
    required this.isCorrect,
    required this.hint,
    required this.hintEn,
    required this.kurmanjWord,
    required this.translation,
    required this.translationEn,
    required this.onNext,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showTr = ref.watch(showTurkishProvider);
    final bgColor = isCorrect ? AppColors.successSurface : AppColors.errorSurface;
    final accentColor = isCorrect ? AppColors.success : AppColors.errorSoft;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final displayTranslation = showTr ? translation : translationEn;
    final displayHint = showTr ? hint : hintEn;

    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md + (bottomPadding > 0 ? bottomPadding : AppSpacing.md),
      ),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(top: BorderSide(color: accentColor, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.info_outline,
                color: accentColor,
                size: 20,
              ),
              Gap.hSm,
              Text(
                isCorrect ? 'Erê! Baş e!' : 'Nêzîk bû!',
                style: AppTypography.title.copyWith(color: accentColor),
              ),
            ],
          ),
          if (!isCorrect) ...[
            Gap.xs,
            // Doğru cevap
            Text(
              '$kurmanjWord = $displayTranslation',
              style: AppTypography.body.copyWith(color: accentColor),
            ),
          ],
          if (displayHint.isNotEmpty) ...[
            Gap.xs,
            Text(displayHint, style: AppTypography.caption.copyWith(color: accentColor)),
          ],
          Gap.md,
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(backgroundColor: accentColor),
            child: Text(
              isLast ? 'Hat temamkirin!' : 'Berdewam bike →',
              style: AppTypography.labelLarge.onPrimary,
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: 1.0, end: 0, duration: 300.ms, curve: Curves.easeOut);
  }
}

// ── Tamamlama Ekranı ─────────────────────────────────────────────

class _CompletionScreen extends StatelessWidget {
  final int correctCount;
  const _CompletionScreen({required this.correctCount});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable centered content
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.md,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Kutlama
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: AppColors.primarySurface,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.star_rounded,
                          color: AppColors.accent,
                          size: 56,
                        ),
                      )
                          .animate()
                          .scale(
                            begin: const Offset(0.3, 0.3),
                            duration: 700.ms,
                            curve: Curves.elasticOut,
                          )
                          .fadeIn(duration: 400.ms),

                      Gap.lg,

                      // Kurmancî tebrik
                      Text(
                        'Gelek baş!',
                        style: AppTypography.kurmanjiLarge.copyWith(
                          color: AppColors.primary,
                        ),
                        textAlign: TextAlign.center,
                      ).animate(delay: 400.ms).fadeIn(),

                      Gap.xs,

                      Text(
                        'Pir baş!',
                        style: AppTypography.body.muted,
                        textAlign: TextAlign.center,
                      ).animate(delay: 550.ms).fadeIn(),

                      Gap.lg,

                      // Sonuç
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.primarySurface,
                          borderRadius: AppRadius.lg,
                        ),
                        child: Column(
                          children: [
                            Text(
                              '$correctCount / ${_exercises.length}',
                              style: AppTypography.display.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'rast',
                              style: AppTypography.body.copyWith(color: AppColors.primary),
                            ),
                            Gap.sm,
                            Text(
                              'Te 3 peyvên Kurmancî hîn bûn.\n'
                              'Tovên vî zimanî berê di te de hebûn —\n'
                              'îro dest bi mezinbûnê kirin.',
                              style: AppTypography.body,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ).animate(delay: 700.ms).fadeIn(),
                    ],
                  ),
                ),
              ),
            ),

            // Pinned bottom buttons
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.sm + (bottomPadding > 0 ? 0 : AppSpacing.md),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Hesap oluştur
                  ElevatedButton(
                    onPressed: () => context.go(AppRoutes.register),
                    child: Text(
                      'Ji bo berdewamiyê hesab veke →',
                      style: AppTypography.labelLarge.onPrimary,
                    ),
                  ).animate(delay: 1000.ms).fadeIn(),

                  const SizedBox(height: AppSpacing.xs),

                  TextButton(
                    onPressed: () => context.go(AppRoutes.home),
                    style: TextButton.styleFrom(
                      minimumSize: const Size(double.infinity, AppSpacing.touchMin),
                    ),
                    child: Text(
                      'Niha derbas bibe',
                      style: AppTypography.label.muted,
                    ),
                  ).animate(delay: 1100.ms).fadeIn(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
