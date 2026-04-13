import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../lessons/domain/a1_kelime_db.dart';

// ════════════════════════════════════════════════════════════════
// SENTENCE BUILDER — Duolingo-Style Cümle Oluşturma
// Kullanıcı karışık sıradaki kelimeleri doğru sırayla dizer.
// Heritage cümleler (her alanı) A1 kelime veritabanından çekilir.
// ════════════════════════════════════════════════════════════════

/// Tek bir egzersiz sorusu: orijinal cümle + karışık tokenlar
class _SentenceQuestion {
  final String original;
  final List<String> tokens;
  final String sourceWord; // hangi kelimeden geldi (Kurmancî)

  _SentenceQuestion({
    required this.original,
    required this.tokens,
    required this.sourceWord,
  });
}

class SentenceBuilderScreen extends ConsumerStatefulWidget {
  const SentenceBuilderScreen({super.key});

  @override
  ConsumerState<SentenceBuilderScreen> createState() =>
      _SentenceBuilderScreenState();
}

class _SentenceBuilderScreenState extends ConsumerState<SentenceBuilderScreen>
    with TickerProviderStateMixin {
  // ── Oturum verileri ──────────────────────────────────────────
  static const int _totalQuestions = 10;
  static const int _maxHearts = 3;

  late List<_SentenceQuestion> _questions;
  int _currentIndex = 0;
  int _hearts = _maxHearts;
  int _correctCount = 0;
  int _xpEarned = 0;
  bool _sessionComplete = false;
  bool _hintUsed = false;

  // ── Mevcut soru durumu ──────────────────────────────────────
  late List<String> _wordBank;     // alt kısımdaki mevcut kelimeler
  late List<String?> _answerSlots; // üstteki slot dizisi
  int _nextSlotIndex = 0;

  // ── Animasyon ──────────────────────────────────────────────
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  bool _showCorrectFlash = false;
  bool _showWrongShake = false;

  // ── Zorluk artışı ─────────────────────────────────────────
  // İlk 4 soru: 3-4 kelimelik cümleler, sonra 5-7 kelimelik
  int get _minTokens => _currentIndex < 4 ? 3 : 5;
  int get _maxTokens => _currentIndex < 4 ? 4 : 7;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
    _buildQuestions();
    _setupCurrentQuestion();
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  // ── Soruları oluştur ──────────────────────────────────────
  void _buildQuestions() {
    final rng = Random();
    final pool = <_SentenceQuestion>[];

    for (final word in kA1TamKelimeler) {
      final herList = word.her as List<dynamic>?;
      if (herList == null || herList.isEmpty) continue;

      for (final sentence in herList) {
        final s = sentence.toString().trim();
        // Noktalama işaretlerini temizle
        final cleaned = s.replaceAll(RegExp(r'[.!?,;:\u2014\u2013\-]+$'), '').trim();
        final tokens = cleaned.split(RegExp(r'\s+'));
        if (tokens.length < 3 || tokens.length > 7) continue;

        pool.add(_SentenceQuestion(
          original: cleaned,
          tokens: tokens,
          sourceWord: (word.ku as String?) ?? '',
        ));
      }
    }

    pool.shuffle(rng);

    // Zorluk sıralama: kısa cümleler önce, uzun cümleler sonra
    final shortSentences =
        pool.where((q) => q.tokens.length <= 4).toList()..shuffle(rng);
    final longSentences =
        pool.where((q) => q.tokens.length > 4).toList()..shuffle(rng);

    _questions = [
      ...shortSentences.take(5),
      ...longSentences.take(5),
    ];

    // Yeterli soru yoksa havuzu tekrar karıştır
    while (_questions.length < _totalQuestions && pool.isNotEmpty) {
      _questions.add(pool[rng.nextInt(pool.length)]);
    }

    _questions = _questions.take(_totalQuestions).toList();
  }

  void _setupCurrentQuestion() {
    if (_currentIndex >= _questions.length) {
      setState(() => _sessionComplete = true);
      return;
    }
    final q = _questions[_currentIndex];
    _wordBank = List<String>.from(q.tokens)..shuffle(Random());
    _answerSlots = List<String?>.filled(q.tokens.length, null);
    _nextSlotIndex = 0;
    _hintUsed = false;
    _showCorrectFlash = false;
    _showWrongShake = false;
  }

  // ── Kelime tıklama: bankadan slota ────────────────────────
  void _onWordTap(int bankIndex) {
    if (_nextSlotIndex >= _answerSlots.length) return;

    setState(() {
      _answerSlots[_nextSlotIndex] = _wordBank[bankIndex];
      _wordBank[bankIndex] = ''; // boş işaretle
      _nextSlotIndex++;
    });

    HapticFeedback.lightImpact();

    // Tüm slotlar dolduysa otomatik kontrol
    if (_nextSlotIndex == _answerSlots.length) {
      _checkAnswer();
    }
  }

  // ── Slot tıklama: slottan bankaya geri ────────────────────
  void _onSlotTap(int slotIndex) {
    final word = _answerSlots[slotIndex];
    if (word == null) return;

    setState(() {
      // Bankada ilk boş yere geri koy
      final emptyIdx = _wordBank.indexOf('');
      if (emptyIdx != -1) {
        _wordBank[emptyIdx] = word;
      }
      _answerSlots[slotIndex] = null;

      // Slot indeksini güncelle: en düşük boş yere
      _nextSlotIndex = _answerSlots.indexOf(null);
      if (_nextSlotIndex == -1) {
        _nextSlotIndex = _answerSlots.length;
      }
    });

    HapticFeedback.selectionClick();
  }

  // ── Cevap kontrolü ────────────────────────────────────────
  void _checkAnswer() {
    final q = _questions[_currentIndex];
    final userAnswer = _answerSlots.whereType<String>().join(' ');
    final correct = userAnswer == q.original;

    if (correct) {
      _xpEarned += _hintUsed ? 8 : 15;
      _correctCount++;
      setState(() => _showCorrectFlash = true);
      HapticFeedback.mediumImpact();

      Future.delayed(const Duration(milliseconds: 800), () {
        if (!mounted) return;
        _advanceToNext();
      });
    } else {
      setState(() {
        _hearts--;
        _showWrongShake = true;
      });
      HapticFeedback.heavyImpact();
      _shakeController.forward(from: 0);

      if (_hearts <= 0) {
        Future.delayed(const Duration(milliseconds: 600), () {
          if (!mounted) return;
          setState(() => _sessionComplete = true);
        });
        return;
      }

      Future.delayed(const Duration(milliseconds: 1000), () {
        if (!mounted) return;
        setState(() {
          _showWrongShake = false;
          _setupCurrentQuestion();
        });
      });
    }
  }

  void _advanceToNext() {
    setState(() {
      _currentIndex++;
      if (_currentIndex >= _questions.length) {
        _sessionComplete = true;
      } else {
        _setupCurrentQuestion();
      }
    });
  }

  // ── Hint: ilk kelimeyi göster ─────────────────────────────
  void _useHint() {
    if (_hintUsed) return;
    final q = _questions[_currentIndex];
    final firstWord = q.tokens.first;

    // İlk kelime bankada mı?
    final bankIdx = _wordBank.indexOf(firstWord);
    if (bankIdx == -1) return; // Zaten yerleştirilmiş

    setState(() {
      _hintUsed = true;
    });
    _onWordTap(bankIdx);
  }

  // ═══════════════════════════════════════════════════════════
  // BUILD
  // ═══════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    if (_sessionComplete) return _buildResultScreen();

    final q = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _totalQuestions;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              children: [
                // ── Üst bar: geri, progress, kalpler ──────────
                _buildTopBar(progress),

                const SizedBox(height: AppSpacing.lg),

                // ── Talimat ──────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: Text(
                    'Peyvên rêz bike',
                    style: AppTypography.headline.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ).animate().fadeIn(duration: 300.ms),

                const SizedBox(height: 4),

                // Kaynak kelime ipucu
                Text(
                  '( ${q.sourceWord} )',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // ── Cevap slotları ───────────────────────────
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    child: Column(
                      children: [
                        _buildAnswerSlots(q),
                        const Spacer(),
                        _buildWordBank(),
                        const SizedBox(height: AppSpacing.md),
                        _buildHintButton(),
                        const SizedBox(height: AppSpacing.md),
                      ],
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

  // ── Üst Bar ──────────────────────────────────────────────
  Widget _buildTopBar(double progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          // Geri butonu
          GestureDetector(
            onTap: () => _showExitDialog(),
            child: const Icon(
              Icons.close_rounded,
              color: AppColors.textSecondary,
              size: 28,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),

          // Progress bar
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: AppColors.borderLight,
                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),

          // Kalpler
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(_maxHearts, (i) {
              final active = i < _hearts;
              return Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Icon(
                  active ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: active ? AppColors.errorSoft : AppColors.borderLight,
                  size: 22,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ── Cevap Slotları ────────────────────────────────────────
  Widget _buildAnswerSlots(_SentenceQuestion q) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        double dx = 0;
        if (_showWrongShake) {
          dx = sin(_shakeAnimation.value * pi * 4) * 12;
        }
        return Transform.translate(
          offset: Offset(dx, 0),
          child: child,
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: _showCorrectFlash
              ? AppColors.successSurface
              : _showWrongShake
                  ? AppColors.errorSurface
                  : AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: _showCorrectFlash
                ? AppColors.success
                : _showWrongShake
                    ? AppColors.errorSoft
                    : AppColors.borderLight,
            width: _showCorrectFlash || _showWrongShake ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        constraints: const BoxConstraints(minHeight: 100),
        child: Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: List.generate(q.tokens.length, (i) {
            final word = _answerSlots[i];
            if (word != null) {
              return _AnswerChip(
                word: word,
                onTap: () => _onSlotTap(i),
                isCorrect: _showCorrectFlash,
              );
            }
            return _EmptySlot(index: i);
          }),
        ),
      ),
    );
  }

  // ── Kelime Bankası ────────────────────────────────────────
  Widget _buildWordBank() {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      alignment: WrapAlignment.center,
      children: List.generate(_wordBank.length, (i) {
        final word = _wordBank[i];
        if (word.isEmpty) {
          return _GhostChip();
        }
        return _WordBankChip(
          word: word,
          onTap: () => _onWordTap(i),
        );
      }),
    );
  }

  // ── Hint butonu ───────────────────────────────────────────
  Widget _buildHintButton() {
    return GestureDetector(
      onTap: _hintUsed ? null : _useHint,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: _hintUsed
              ? AppColors.borderLight.withOpacity(0.5)
              : AppColors.warningSurface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          border: Border.all(
            color: _hintUsed ? AppColors.borderLight : AppColors.warning,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lightbulb_outline_rounded,
              size: 18,
              color: _hintUsed ? AppColors.textTertiary : AppColors.warning,
            ),
            const SizedBox(width: 6),
            Text(
              _hintUsed ? 'Alîkarî hat bikaranîn' : 'Alîkarî',
              style: AppTypography.label.copyWith(
                color: _hintUsed ? AppColors.textTertiary : AppColors.warning,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Çıkış onay diyaloğu ──────────────────────────────────
  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.backgroundSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        title: Text(
          'Derkeve?',
          style: AppTypography.title,
        ),
        content: Text(
          'Pêşketina te winda dibe.',
          style: AppTypography.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Bimîne',
              style: AppTypography.label.copyWith(color: AppColors.primary),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.pop();
            },
            child: Text(
              'Derkeve',
              style: AppTypography.label.copyWith(color: AppColors.errorSoft),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // SONUÇ EKRANI
  // ═══════════════════════════════════════════════════════════

  Widget _buildResultScreen() {
    final accuracy = _questions.isEmpty
        ? 0
        : ((_correctCount / _totalQuestions) * 100).round();
    final isPerfect = _correctCount == _totalQuestions;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Başarı ikonu
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: isPerfect
                          ? AppColors.successSurface
                          : _hearts > 0
                              ? AppColors.primarySurface
                              : AppColors.errorSurface,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isPerfect
                          ? Icons.emoji_events_rounded
                          : _hearts > 0
                              ? Icons.check_circle_outline_rounded
                              : Icons.sentiment_neutral_rounded,
                      size: 48,
                      color: isPerfect
                          ? AppColors.accent
                          : _hearts > 0
                              ? AppColors.primary
                              : AppColors.errorSoft,
                    ),
                  ).animate().scale(
                        begin: const Offset(0, 0),
                        end: const Offset(1, 1),
                        duration: 500.ms,
                        curve: Curves.elasticOut,
                      ),

                  const SizedBox(height: AppSpacing.lg),

                  // Başlık
                  Text(
                    isPerfect
                        ? 'Pîroz be!'
                        : _hearts > 0
                            ? 'Baş e!'
                            : 'Careke din biceribîne!',
                    style: AppTypography.display.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ).animate().fadeIn(delay: 200.ms),

                  const SizedBox(height: AppSpacing.md),

                  // XP kartı
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentSurface,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.bolt_rounded,
                          color: AppColors.accent,
                          size: 28,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '+$_xpEarned XP',
                          style: AppTypography.xpCounter,
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),

                  const SizedBox(height: AppSpacing.md),

                  // Doğruluk
                  Text(
                    '$accuracy% rast',
                    style: AppTypography.title.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ).animate().fadeIn(delay: 500.ms),

                  const SizedBox(height: 4),
                  Text(
                    '$_correctCount / $_totalQuestions hevok',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ).animate().fadeIn(delay: 550.ms),

                  const SizedBox(height: AppSpacing.xl),

                  // Devam butonu
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusMd,
                          ),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Berdewam bike',
                        style: AppTypography.labelLarge.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.15),

                  const SizedBox(height: AppSpacing.sm),

                  // Tekrar butonu
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _currentIndex = 0;
                        _hearts = _maxHearts;
                        _correctCount = 0;
                        _xpEarned = 0;
                        _sessionComplete = false;
                        _buildQuestions();
                        _setupCurrentQuestion();
                      });
                    },
                    child: Text(
                      'Ji nû ve dest pê bike',
                      style: AppTypography.label.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ).animate().fadeIn(delay: 700.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// BİLEŞENLER
// ═══════════════════════════════════════════════════════════════

/// Cevap alanındaki yerleştirilmiş kelime chipi
class _AnswerChip extends StatelessWidget {
  final String word;
  final VoidCallback onTap;
  final bool isCorrect;

  const _AnswerChip({
    required this.word,
    required this.onTap,
    this.isCorrect = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        decoration: BoxDecoration(
          color: isCorrect ? AppColors.success : AppColors.primary,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          boxShadow: [
            BoxShadow(
              color: (isCorrect ? AppColors.success : AppColors.primary)
                  .withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          word,
          style: AppTypography.kurmanjiCard.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ).animate().scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: 200.ms,
          curve: Curves.easeOutBack,
        );
  }
}

/// Boş slot (kesikli kenarlık)
class _EmptySlot extends StatelessWidget {
  final int index;
  const _EmptySlot({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: AppColors.borderMedium,
          width: 1.5,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        color: AppColors.backgroundTertiary.withOpacity(0.3),
      ),
    );
  }
}

/// Kelime bankasındaki dokunulabilir chip
class _WordBankChip extends StatelessWidget {
  final String word;
  final VoidCallback onTap;

  const _WordBankChip({required this.word, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.borderMedium),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          word,
          style: AppTypography.kurmanjiCard.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

/// Kelime slota taşındığında bankada kalan hayalet yer tutucu
class _GhostChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.borderLight.withOpacity(0.3),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: Colors.transparent),
      ),
      child: Text(
        '      ',
        style: AppTypography.kurmanjiCard.copyWith(
          color: Colors.transparent,
        ),
      ),
    );
  }
}
