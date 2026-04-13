import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/fsrs_algorithm.dart';
import '../../../core/services/analytics_service.dart';
import '../../../shared/providers/language_mode_provider.dart';
import '../../../shared/widgets/exercise_widgets.dart';
import '../data/lesson_repository.dart';
import '../domain/a1_kelime_db.dart';

// ════════════════════════════════════════════════════════════════
// DERS EKRANI — LÛTKE
//
// İlke §3: FSRS-5 — 4 derecelendirme, gerçek zamanlı schedule
// İlke §4: Gamification destekleyici — hata = "yeniden gör"
// İlke §0.5: Kurmancî birinci dil her adımda
// İlke §7: Heritage / Genel yol kart setleri
// ════════════════════════════════════════════════════════════════

// Egzersiz türleri (ilke §5 — çeşitlilik)
enum ExerciseType { flashcard, multipleChoice, typing, sentenceOrder }

class LessonScreen extends ConsumerStatefulWidget {
  final String? lessonId;
  final String mode; // 'review' | 'lesson' | 'new'
  final String userId;

  const LessonScreen({
    super.key,
    this.lessonId,
    this.mode = 'lesson',
    required this.userId,
  });

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen> {
  // Kart listesi
  List<VocabularyCardModel> _cards = [];
  int _currentIndex = 0;
  bool _loading = true;
  bool _showAnswer = false;
  DateTime _cardStartTime = DateTime.now();

  // Oturum istatistikleri
  int _correctCount = 0;
  int _totalSeen = 0;
  final List<Rating> _ratings = [];

  // Egzersiz türü rotasyonu — çeşitlilik (ilke §5)
  static const _exerciseCycle = [
    ExerciseType.flashcard,
    ExerciseType.multipleChoice,
    ExerciseType.flashcard,
    ExerciseType.typing,
    ExerciseType.sentenceOrder,
  ];

  ExerciseType get _currentExerciseType =>
      _exerciseCycle[_currentIndex % _exerciseCycle.length];

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
    try {
      // Statik listeden yükle — DB bağlantısı gerekmez
      final allWords = kA1TamKelimeler
          .where((w) => w.kat != 'alfabe') // Alfabe kartlarını atla
          .toList();
      final rng = Random();
      final shuffled = [...allWords]..shuffle(rng);
      final limit = widget.mode == 'review' ? 15 : (widget.lessonId != null ? 20 : 15);
      final selected = shuffled.take(limit).toList();

      // VocabularyCardModel'e dönüştür
      final cards = selected.map((w) => VocabularyCardModel(
        id: w.id,
        kurmanji: w.ku,
        turkish: w.tr,
        english: w.en,
        category: w.kat,
        gender: w.cins,
        level: 1,
        fsrsCard: FSRSCard(cardId: w.id, state: CardState.newCard, dueDate: DateTime.now()),
        sentencesHeritage: (w.her as List).cast<String>(),
        sentencesGeneral: (w.gen as List).cast<String>(),
      )).toList();

      if (mounted) {
        setState(() {
          _cards = cards;
          _loading = false;
        });
      }
    } catch (_) {
      // Hata — boş liste göster
      if (mounted) setState(() => _loading = false);
    }

    // Analitik
    try { ref.read(analyticsServiceProvider).logAppOpen(); } catch (_) {}
  }

  // ── FSRS DEĞERLENDİRME ─────────────────────────────────────

  Future<void> _onRating(Rating rating) async {
    if (_currentIndex >= _cards.length) return;

    final card = _cards[_currentIndex];
    final responseMs = DateTime.now().difference(_cardStartTime).inMilliseconds;

    // FSRS güncelle
    await ref.read(lessonRepositoryProvider).updateCardAfterReview(
      userId: widget.userId,
      cardId: card.id,
      rating: rating,
    );

    // Analitik
    await ref.read(analyticsServiceProvider).logCardReview(
      cardId: card.id,
      kurmanji: card.kurmanji,
      levelNum: card.level,
      rating: rating.name,
      responseMs: responseMs,
    );

    // İstatistik güncelle
    final correct = rating == Rating.good || rating == Rating.easy;
    if (correct) _correctCount++;
    _totalSeen++;
    _ratings.add(rating);

    // Sonraki kart
    if (mounted) {
      setState(() {
        _currentIndex++;
        _showAnswer = false;
        _cardStartTime = DateTime.now();
      });
    }

    // Oturum bitti mi?
    if (_currentIndex >= _cards.length) {
      _onSessionComplete();
    }
  }

  void _onSessionComplete() {
    ref.read(analyticsServiceProvider).logLessonComplete(
      lessonId: widget.lessonId ?? 'review',
      lessonTitle: widget.mode == 'review' ? 'Dubare' : 'Wane',
      levelNum: ref.read(userProfileProvider).currentLevelNum,
      durationSeconds: 0,
      correctAnswers: _correctCount,
      totalQuestions: _totalSeen,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const _LoadingView();

    if (_cards.isEmpty) {
      return const _EmptyView();
    }

    if (_currentIndex >= _cards.length) {
      return _CompletionView(
        totalSeen: _totalSeen,
        correctCount: _correctCount,
        ratings: _ratings,
        onClose: () => context.pop(),
      );
    }

    final card = _cards[_currentIndex];

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // ── Üst Bar ──────────────────────────────────────
            _TopBar(
              current: _currentIndex + 1,
              total: _cards.length,
              onClose: () => context.pop(),
            ),

            // ── İlerleme Çubuğu ──────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: _currentIndex / _cards.length,
                  backgroundColor: AppColors.primary.withOpacity(0.12),
                  valueColor: AlwaysStoppedAnimation(AppColors.primary),
                  minHeight: 8,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // ── Egzersiz İçeriği ──────────────────────────────
            Expanded(
              child: _buildExercise(card),
            ),
          ],
        ),
      ),
    );
  }

  /// Dil moduna göre çeviri metni: Türkçe veya İngilizce fallback
  String _translationText(VocabularyCardModel card) {
    final showTr = ref.watch(showTurkishProvider);
    return showTr ? card.turkish : (card.english ?? card.turkish);
  }

  Widget _buildExercise(VocabularyCardModel card) {
    final translation = _translationText(card);

    switch (_currentExerciseType) {
      case ExerciseType.flashcard:
        // Kart + cevabı göster + FSRS derecelendirme
        return _FlashcardExercise(
          card: card,
          translation: translation,
          showAnswer: _showAnswer,
          onShowAnswer: () => setState(() => _showAnswer = true),
          onRating: _onRating,
        );

      case ExerciseType.multipleChoice:
        // Kurmancî → çeviri çok seçenek
        final allCards = _cards;
        final options = _buildOptions(card, allCards);
        return MultipleChoiceExercise(
          question: card.kurmanji,
          options: options,
          correctIndex: options.indexOf(translation),
          onRating: _onRating,
        );

      case ExerciseType.typing:
        // Çeviri → Kurmancî yazma
        return TypingExercise(
          prompt: translation,
          answer: card.kurmanji,
          onRating: _onRating,
        );

      case ExerciseType.sentenceOrder:
        // Örnek cümle → kelime sırala
        if (card.sentencesHeritage.isEmpty) {
          // Fallback: flashcard
          return _FlashcardExercise(
            card: card,
            translation: translation,
            showAnswer: _showAnswer,
            onShowAnswer: () => setState(() => _showAnswer = true),
            onRating: _onRating,
          );
        }
        final sentence = card.sentencesHeritage.first;
        final tokens = sentence
            .replaceAll('.', '')
            .replaceAll('!', '')
            .replaceAll('?', '')
            .split(' ')
            .where((s) => s.isNotEmpty)
            .toList();
        return SentenceOrderExercise(
          wordTokens: [...tokens]..shuffle(),
          correctOrder: tokens,
          onRating: _onRating,
        );
    }
  }

  // ── YARDIMCI: Çok seçenekli seçenekler ───────────────────

  List<String> _buildOptions(
      VocabularyCardModel card, List<VocabularyCardModel> allCards) {
    final correctText = _translationText(card);
    final distractors = allCards
        .where((c) => c.id != card.id && _translationText(c) != correctText)
        .map((c) => _translationText(c))
        .toSet()
        .take(3)
        .toList();

    final options = [correctText, ...distractors];
    options.shuffle();
    return options;
  }
}

// ════════════════════════════════════════════════════════════════
// FLASHCARD EGZERSİZİ
// ════════════════════════════════════════════════════════════════

class _FlashcardExercise extends StatelessWidget {
  final VocabularyCardModel card;
  final String translation;
  final bool showAnswer;
  final VoidCallback onShowAnswer;
  final OnRating onRating;

  const _FlashcardExercise({
    required this.card,
    required this.translation,
    required this.showAnswer,
    required this.onShowAnswer,
    required this.onRating,
  });

  @override
  Widget build(BuildContext context) {
    return showAnswer
        ? FSRSRatingCard(
            kurmanji: card.kurmanji,
            turkish: translation,
            gender: card.gender,
            sentences: card.sentencesHeritage,
            onRating: onRating,
          )
        : _CardFront(
            card: card,
            onTap: onShowAnswer,
          );
  }
}

class _CardFront extends StatelessWidget {
  final VocabularyCardModel card;
  final VoidCallback onTap;

  const _CardFront({required this.card, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Kurmancî — büyük, birincil, responsive (İlke §0.5)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        card.kurmanji,
                        style: AppTypography.displayMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ).animate().fadeIn().scale(begin: const Offset(0.95, 0.95)),

                  const SizedBox(height: AppSpacing.xl),

                  // İpucu — daha belirgin
                  Icon(Icons.touch_app_rounded,
                      color: AppColors.textSecondary.withOpacity(0.5),
                      size: 40),

                  const SizedBox(height: AppSpacing.sm),

                  Consumer(
                    builder: (context, ref, _) {
                      final showTr = ref.watch(showTurkishProvider);
                      return Text(
                        'Bersivê bibîne',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // Seviye + kategori etiketi
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Tag(text: card.levelName, isPrimary: true),
              const SizedBox(width: 8),
              _Tag(text: card.category, isPrimary: false),
            ],
          ),

          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  final bool isPrimary;
  const _Tag({required this.text, required this.isPrimary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isPrimary
            ? AppColors.primary.withOpacity(0.1)
            : AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: AppTypography.caption.copyWith(
          color: isPrimary ? AppColors.primary : AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// ÜST BAR
// ════════════════════════════════════════════════════════════════

class _TopBar extends StatelessWidget {
  final int current;
  final int total;
  final VoidCallback onClose;

  const _TopBar({
    required this.current,
    required this.total,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      child: Row(
        children: [
          // Kapat — min 48x48dp (İlke §8 WCAG)
          SizedBox(
            width: 48,
            height: 48,
            child: IconButton(
              onPressed: onClose,
              icon: const Icon(Icons.close_rounded),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.backgroundSecondary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),

          const SizedBox(width: AppSpacing.sm),

          // Kart sayacı — belirgin
          Expanded(
            child: Text(
              '$current / $total',
              style: AppTypography.headingSmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(width: 48), // Simetri
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// OTURUM TAMAMLAMA EKRANI
// İlke §4: Kutlama, destekleyici ton — ceza yok
// ════════════════════════════════════════════════════════════════

class _CompletionView extends StatelessWidget {
  final int totalSeen;
  final int correctCount;
  final List<Rating> ratings;
  final VoidCallback onClose;

  const _CompletionView({
    required this.totalSeen,
    required this.correctCount,
    required this.ratings,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final accuracy =
        totalSeen > 0 ? (correctCount / totalSeen * 100).round() : 0;

    // İlke §4: Destekleyici mesaj — başarı oranına göre
    final message = accuracy >= 80
        ? 'Zêde baş! Tu pêş dikevî.' // Çok iyi! İlerliyorsun.
        : accuracy >= 50
            ? 'Baş e! Her gav pêngav e.' // İyi! Her gün adım adım.
            : 'Destpêk xweş e. Berdewam bike!'; // Başlangıç güzel. Devam et!

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Kutlama ikonu — ortalanmış
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.star_rounded,
                      size: 64, color: AppColors.primary),
                ).animate().scale(
                      begin: const Offset(0, 0),
                      curve: Curves.elasticOut,
                      duration: 600.ms,
                    ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Kurmancî kutlama (İlke §0.5)
              Text(
                'Temam bû!',
                style: AppTypography.displayMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 200.ms),

              const SizedBox(height: AppSpacing.sm),

              Text(
                message,
                style: AppTypography.bodyLarge
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 300.ms),

              const SizedBox(height: AppSpacing.xl),

              // İstatistikler — responsive
              LayoutBuilder(
                builder: (context, constraints) {
                  final statWidth = (constraints.maxWidth - AppSpacing.md * 2) / 3;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: statWidth,
                        child: _CompletionStat(
                          label: 'Peld',
                          value: '$totalSeen',
                          icon: Icons.layers_outlined,
                        ),
                      ),
                      SizedBox(
                        width: statWidth,
                        child: _CompletionStat(
                          label: 'Rast',
                          value: '$accuracy%',
                          icon: Icons.check_circle_outline,
                        ),
                      ),
                      SizedBox(
                        width: statWidth,
                        child: _CompletionStat(
                          label: 'XP',
                          value: '+${correctCount * 10}',
                          icon: Icons.star_border,
                        ),
                      ),
                    ],
                  );
                },
              ).animate().fadeIn(delay: 400.ms),

              const Spacer(flex: 3),

              // Geri dön butonu — tam genişlik, altta
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onClose,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: Text(
                    'Vegere serê',  // Ana sayfaya dön
                    style: AppTypography.labelLarge.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompletionStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _CompletionStat({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 28),
        const SizedBox(height: 6),
        Text(value,
            style: AppTypography.headingSmall.copyWith(
                color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
        Text(label,
            style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary)),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// YÜKLEME VE BOŞ DURUM
// ════════════════════════════════════════════════════════════════

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.primary),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Peld amade dibin...',  // Kartlar hazırlanıyor
              style: AppTypography.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/mascot_128.png',
                width: 100, height: 100,
                filterQuality: FilterQuality.medium),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Hemû peld hatine xwendin!',  // Tüm kartlar okundu!
              style: AppTypography.headingSmall.copyWith(
                  color: AppColors.textPrimary, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'FSRS sonda dîsa dê bîne.',  // FSRS zamanı gelince tekrar sunacak
              style: AppTypography.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            TextButton.icon(
              onPressed: () => context.pop(),
              icon: Icon(Icons.arrow_back, color: AppColors.primary),
              label: Text(
                'Vegere',
                style: AppTypography.labelLarge.copyWith(
                    color: AppColors.primary, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
