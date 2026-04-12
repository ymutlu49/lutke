import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/router/app_router.dart';

/// Pasif Anlama Testi
///
/// Araştırma Bulgusu #1: Mevcut uygulamalar herkesi sıfır bilen
/// yabancı olarak ele alıyor. Mehmet, Hasan, Narin gibi pasif
/// maruziyeti olan kullanıcılar ilk derste bırakıyor.
///
/// Çözüm: 3 kısa ses sorusuyla kullanıcının pasif bilgisini ölç,
/// ona göre A1 yolu belirle:
/// - 0–1 doğru → Tam A1 yolu (alfabe dahil)
/// - 2–3 doğru → Hızlı A1 yolu (alfabe atlanır, kelime+cümle)

// ── Model ────────────────────────────────────────────────────────

class _TestQuestion {
  final String id;
  final String kurmanjiText;     // Ekranda gösterilen Kurmancî
  final String audioAsset;       // Ses dosyası yolu
  final List<String> options;    // 4 Türkçe seçenek
  final int correctIndex;        // Doğru seçeneğin indeksi

  const _TestQuestion({
    required this.id,
    required this.kurmanjiText,
    required this.audioAsset,
    required this.options,
    required this.correctIndex,
  });
}

const _questions = [
  _TestQuestion(
    id: 'q1',
    kurmanjiText: 'Silav, çawa yî?',
    audioAsset: 'assets/audio/passive_test/q1_silav.mp3',
    options: ['Selamlama', 'Sayı', 'Renk', 'Bilmiyorum'],
    correctIndex: 0,
  ),
  _TestQuestion(
    id: 'q2',
    kurmanjiText: 'Nan xwarin',
    audioAsset: 'assets/audio/passive_test/q2_nan.mp3',
    options: ['Uyumak', 'Yemek yemek', 'Gitmek', 'Bilmiyorum'],
    correctIndex: 1,
  ),
  _TestQuestion(
    id: 'q3',
    kurmanjiText: 'Mala min',
    audioAsset: 'assets/audio/passive_test/q3_mal.mp3',
    options: ['Araba', 'Okul', 'Evim', 'Bilmiyorum'],
    correctIndex: 2,
  ),
];

// ── State ────────────────────────────────────────────────────────

class _TestState {
  final int currentIndex;
  final List<int?> answers; // null = henüz cevaplanmadı
  final bool isComplete;

  const _TestState({
    this.currentIndex = 0,
    required this.answers,
    this.isComplete = false,
  });

  _TestState copyWith({
    int? currentIndex,
    List<int?>? answers,
    bool? isComplete,
  }) {
    return _TestState(
      currentIndex: currentIndex ?? this.currentIndex,
      answers: answers ?? this.answers,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  int get correctCount {
    int count = 0;
    for (int i = 0; i < answers.length; i++) {
      if (i < _questions.length && answers[i] == _questions[i].correctIndex) {
        count++;
      }
    }
    return count;
  }

  bool get isHeritageUser => correctCount >= 2;
}

// ── Provider ─────────────────────────────────────────────────────

class _TestNotifier extends StateNotifier<_TestState> {
  _TestNotifier()
      : super(_TestState(answers: List.filled(_questions.length, null)));

  void answer(int optionIndex) {
    final newAnswers = List<int?>.from(state.answers);
    newAnswers[state.currentIndex] = optionIndex;

    if (state.currentIndex >= _questions.length - 1) {
      state = state.copyWith(answers: newAnswers, isComplete: true);
    } else {
      state = state.copyWith(
        answers: newAnswers,
        currentIndex: state.currentIndex + 1,
      );
    }
  }
}

final _testProvider =
    StateNotifierProvider.autoDispose<_TestNotifier, _TestState>(
  (ref) => _TestNotifier(),
);

// ── Ekran ────────────────────────────────────────────────────────

class PassiveTestScreen extends ConsumerWidget {
  const PassiveTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testState = ref.watch(_testProvider);

    if (testState.isComplete) {
      return _ResultScreen(state: testState);
    }

    return _QuestionScreen(
      question: _questions[testState.currentIndex],
      questionIndex: testState.currentIndex,
      totalQuestions: _questions.length,
    );
  }
}

// ── Soru Ekranı ──────────────────────────────────────────────────

class _QuestionScreen extends ConsumerWidget {
  final _TestQuestion question;
  final int questionIndex;
  final int totalQuestions;

  const _QuestionScreen({
    required this.question,
    required this.questionIndex,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── İlerleme çubuğu ──────────────────────────────
              _ProgressBar(
                current: questionIndex,
                total: totalQuestions,
              ),

              Gap.xl,

              // ── Başlık ───────────────────────────────────────
              Text(
                'Bunu duymuş musun?',
                style: AppTypography.headline,
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 400.ms),

              Gap.xs,

              Text(
                'Kulağına tanıdık geliyor mu?',
                style: AppTypography.body.muted,
                textAlign: TextAlign.center,
              ).animate(delay: 150.ms).fadeIn(duration: 400.ms),

              Gap.xl,

              // ── Ses oynatma kartı ─────────────────────────────
              _AudioCard(question: question)
                  .animate(delay: 200.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.15, end: 0),

              Gap.xl,

              // ── Seçenekler ───────────────────────────────────
              Text(
                'Ne anlama geliyor?',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ).animate(delay: 350.ms).fadeIn(),

              Gap.sm,

              ...question.options.asMap().entries.map((entry) {
                final index = entry.key;
                final option = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _OptionButton(
                    text: option,
                    onTap: () => ref.read(_testProvider.notifier).answer(index),
                    delay: Duration(milliseconds: 400 + index * 80),
                  ),
                );
              }),

              const Spacer(),

              // ── Alt not ──────────────────────────────────────
              Text(
                'Bilmiyorsan sorun değil — seç ve devam et',
                style: AppTypography.caption,
                textAlign: TextAlign.center,
              ).animate(delay: 700.ms).fadeIn(),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Ses Kartı ────────────────────────────────────────────────────

class _AudioCard extends StatefulWidget {
  final _TestQuestion question;
  const _AudioCard({required this.question});

  @override
  State<_AudioCard> createState() => _AudioCardState();
}

class _AudioCardState extends State<_AudioCard> {
  bool _isPlaying = false;
  bool _hasPlayed = false;

  void _playAudio() {
    // MVP: Audio asset henüz yok, simüle ediyoruz
    // Gerçek implementasyonda just_audio kullanılacak:
    // final player = AudioPlayer();
    // await player.setAsset(widget.question.audioAsset);
    // await player.play();
    setState(() => _isPlaying = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() {
        _isPlaying = false;
        _hasPlayed = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: AppRadius.lg,
        border: Border.all(
          color: _hasPlayed ? AppColors.primary : AppColors.borderLight,
          width: _hasPlayed ? AppSpacing.borderMedium : AppSpacing.borderThin,
        ),
      ),
      child: Column(
        children: [
          // Kurmancî metin — büyük, birincil
          Text(
            widget.question.kurmanjiText,
            style: AppTypography.kurmanjiLarge,
            textAlign: TextAlign.center,
          ),

          Gap.md,

          // Ses butonu
          GestureDetector(
            onTap: _isPlaying ? null : _playAudio,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: _isPlaying
                    ? AppColors.primaryLight
                    : AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isPlaying ? Icons.volume_up : Icons.play_arrow_rounded,
                color: AppColors.textOnPrimary,
                size: 36,
              ),
            )
                .animate(target: _isPlaying ? 1 : 0)
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.08, 1.08),
                ),
          ),

          Gap.sm,

          Text(
            _hasPlayed
                ? 'Tekrar dinle'
                : 'Sesi çal',
            style: AppTypography.caption.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Seçenek Butonu ───────────────────────────────────────────────

class _OptionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Duration delay;

  const _OptionButton({
    required this.text,
    required this.onTap,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.md,
        child: Container(
          height: AppSpacing.touchPreferred,
          padding: AppSpacing.buttonPadding,
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: AppRadius.md,
            border: Border.all(
              color: AppColors.borderLight,
              width: AppSpacing.borderThin,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: AppTypography.label.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    )
        .animate(delay: delay)
        .fadeIn(duration: 350.ms)
        .slideX(begin: 0.1, end: 0, duration: 350.ms);
  }
}

// ── İlerleme Çubuğu ──────────────────────────────────────────────

class _ProgressBar extends StatelessWidget {
  final int current;
  final int total;

  const _ProgressBar({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hızlı test',
              style: AppTypography.captionStrong,
            ),
            Text(
              '${current + 1} / $total',
              style: AppTypography.caption,
            ),
          ],
        ),
        Gap.xs,
        ClipRRect(
          borderRadius: AppRadius.full,
          child: LinearProgressIndicator(
            value: (current + 1) / total,
            backgroundColor: AppColors.primarySurface,
            color: AppColors.primary,
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}

// ── Sonuç Ekranı ─────────────────────────────────────────────────

class _ResultScreen extends StatelessWidget {
  final _TestState state;
  const _ResultScreen({required this.state});

  @override
  Widget build(BuildContext context) {
    final isHeritage = state.isHeritageUser;
    final correct = state.correctCount;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.pagePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sonuç ikonu
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: isHeritage
                      ? AppColors.primarySurface
                      : AppColors.accentSurface,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isHeritage ? Icons.favorite : Icons.star_outline,
                  color: isHeritage ? AppColors.primary : AppColors.accent,
                  size: 40,
                ),
              )
                  .animate()
                  .scale(
                    begin: const Offset(0.5, 0.5),
                    duration: 600.ms,
                    curve: Curves.elasticOut,
                  )
                  .fadeIn(duration: 300.ms),

              Gap.lg,

              // Sonuç başlığı — Kurmancî önce
              if (isHeritage) ...[
                Text(
                  'Zimanê te di dilê te de ye.',
                  style: AppTypography.kurmanjiLarge,
                  textAlign: TextAlign.center,
                )
                    .animate(delay: 300.ms)
                    .fadeIn(duration: 500.ms),

                Gap.xs,

                Text(
                  'Dil senin kalbinde zaten vardı.',
                  style: AppTypography.body.muted,
                  textAlign: TextAlign.center,
                )
                    .animate(delay: 500.ms)
                    .fadeIn(duration: 400.ms),

                Gap.md,

                Text(
                  '$correct / 3 soruyu doğru cevaplayarak bazı kelimeleri '
                  'zaten duyduğunu gösterdin. '
                  'Seni hızlı yola yönlendiriyoruz.',
                  style: AppTypography.body,
                  textAlign: TextAlign.center,
                )
                    .animate(delay: 700.ms)
                    .fadeIn(duration: 400.ms),
              ] else ...[
                Text(
                  'Destpêk e!',
                  style: AppTypography.kurmanjiLarge,
                  textAlign: TextAlign.center,
                )
                    .animate(delay: 300.ms)
                    .fadeIn(duration: 500.ms),

                Gap.xs,

                Text(
                  'Güzel bir başlangıç!',
                  style: AppTypography.body.muted,
                  textAlign: TextAlign.center,
                )
                    .animate(delay: 500.ms)
                    .fadeIn(duration: 400.ms),

                Gap.md,

                Text(
                  'Sıfırdan başlıyoruz — en iyi yer burası. '
                  'Adım adım, hiç acele etmeden ilerleyeceğiz.',
                  style: AppTypography.body,
                  textAlign: TextAlign.center,
                )
                    .animate(delay: 700.ms)
                    .fadeIn(duration: 400.ms),
              ],

              Gap.xxl,

              // Devam butonu
              ElevatedButton(
                onPressed: () => context.go(AppRoutes.motivationAnchor),
                child: Text(
                  isHeritage ? 'Harika, devam edelim →' : 'Başlayalım →',
                  style: AppTypography.labelLarge.onPrimary,
                ),
              )
                  .animate(delay: 1000.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.2, end: 0),
            ],
          ),
        ),
      ),
    );
  }
}
