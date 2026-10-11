import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../shared/providers/activity_outcome.dart';
import '../../../shared/providers/language_mode_provider.dart';
import '../../../shared/providers/learning_module_provider.dart';
import '../../../shared/services/skill_progress_service.dart';
import '../../en_learning/presentation/en_coming_soon_screen.dart';
import '../../lessons/domain/a1_kelime_db.dart';
import '../../lessons/domain/a2_kelime_db.dart';import '../../lessons/domain/b1_kelime_db.dart';import '../../lessons/domain/b2_kelime_db.dart';import '../../lessons/domain/c1_kelime_db.dart';import '../../lessons/domain/c2_kelime_db.dart';
import '../../../core/services/sound_service.dart';
import '../../gamification/gamification_provider.dart';
import '../../../shared/widgets/persistent_xp_badge.dart';
import '../../../shared/widgets/xp_float_animation.dart';
import '../../../shared/widgets/streak_milestone_toast.dart';

// ════════════════════════════════════════════════════════════════
// SENTENCE BUILDER — Duolingo-Style Cümle Oluşturma
// Kullanıcı karışık sıradaki kelimeleri doğru sırayla dizer.
// Heritage cümleler (her alanı) A1 kelime veritabanından çekilir.
//
// Akış: Cümlelerin Türkçe çevirisi veride olmadığı için hedef cümle
// soru başında bir "çalışma kartında" gösterilir, sonra gizlenir;
// kullanıcı cümleyi hafızasından kurar. Ekranda yalnızca kaynak
// kelimenin TÜRKÇE anlamı ipucu olarak kalır (cevap sızıntısı yok).
// ════════════════════════════════════════════════════════════════

/// Tek bir egzersiz sorusu: orijinal cümle + karışık tokenlar
class _SentenceQuestion {
  final String original;
  final List<String> tokens;
  final String sourceWord;   // hangi kelimeden geldi (Kurmancî)
  final String sourceWordTr; // kaynak kelimenin Türkçe karşılığı (anlam ipucu)

  _SentenceQuestion({
    required this.original,
    required this.tokens,
    required this.sourceWord,
    required this.sourceWordTr,
  });
}

class SentenceBuilderScreen extends ConsumerStatefulWidget {
  final String? category;
  final String level;
  const SentenceBuilderScreen({super.key, this.category, this.level = 'A1'});

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

  // ── Yardım / deneme durumu (soru başına) ────────────────────
  bool _studyPhase = true;      // soru başında cümle gösterilir, sonra gizlenir
  int _hintCount = 0;           // kademeli ipucu kullanım sayısı (her biri -3 XP)
  bool _peekUsed = false;       // gizlenen cümleye yeniden bakıldı mı (-3 XP)
  int _wrongAttempts = 0;       // bu sorudaki yanlış deneme sayısı
  bool _answerRevealed = false; // "Bersivê nîşan bide" kullanıldı mı

  // ── Mevcut soru durumu ──────────────────────────────────────
  late List<String> _wordBank;     // alt kısımdaki mevcut kelimeler
  late List<String?> _answerSlots; // üstteki slot dizisi
  int _nextSlotIndex = 0;

  // ── Animasyon ──────────────────────────────────────────────
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  bool _showCorrectFlash = false;
  bool _showWrongShake = false;

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

    var source = _sbWordsForLevel(widget.level);
    if (widget.category != null && widget.category!.isNotEmpty) {
      final filtered = source.where((w) => w.kat == widget.category).toList();
      if (filtered.length >= 3) source = filtered;
    }
    for (final word in source) {
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
          sourceWordTr: (word.tr as String?) ?? '',
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
    _resetBoard();
    _studyPhase = true;
    _hintCount = 0;
    _peekUsed = false;
    _wrongAttempts = 0;
    _answerRevealed = false;
    _showCorrectFlash = false;
    _showWrongShake = false;
  }

  /// Aynı soru için tahtayı sıfırlar (yanlış denemeden sonra tekrar).
  /// Deneme sayacı ve ipucu/peek durumu korunur.
  void _resetBoard() {
    final q = _questions[_currentIndex];
    _wordBank = List<String>.from(q.tokens)..shuffle(Random());
    _answerSlots = List<String?>.filled(q.tokens.length, null);
    _nextSlotIndex = 0;
  }

  // ── Kelime tıklama: bankadan slota ────────────────────────
  void _onWordTap(int bankIndex) {
    if (_answerRevealed || _showCorrectFlash || _showWrongShake) return;
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
    if (_answerRevealed || _showCorrectFlash || _showWrongShake) return;
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
      // Yardım kullanımı XP'yi düşürür: her ipucu -3, cümleye tekrar bakmak -3.
      // Taban 15, alt sınır 5.
      final gain = max(15 - _hintCount * 3 - (_peekUsed ? 3 : 0), 5);
      _xpEarned += gain;
      _correctCount++;
      setState(() => _showCorrectFlash = true);
      HapticFeedback.mediumImpact();
      SoundService.playCorrect();
      SoundService.playXpGain();
      showXpFloat(context, gain);
      final milestone = ref
          .read(gamificationProvider.notifier)
          .registerCorrectForCombo();
      if (milestone > 0) {
        final isEn = ref.read(isEnglishModuleProvider);
        final newCombo = ref.read(gamificationProvider).comboCount;
        showStreakMilestone(context, newCombo, isEnglish: isEn);
      }

      Future.delayed(const Duration(milliseconds: 800), () {
        if (!mounted) return;
        _advanceToNext();
      });
    } else {
      setState(() {
        _hearts--;
        _wrongAttempts++;
        _showWrongShake = true;
      });
      HapticFeedback.heavyImpact();
      SoundService.playWrong();
      SoundService.playFail();
      ref.read(gamificationProvider.notifier).resetCombo();
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
        // Bu arada "Bersivê nîşan bide" kullanıldıysa tahtaya dokunma.
        if (_answerRevealed) return;
        setState(() {
          _showWrongShake = false;
          // Sadece tahta sıfırlanır; deneme sayacı ve ipucu durumu korunur
          // ki "Bersivê nîşan bide" çıkış yolu tetiklenebilsin.
          _resetBoard();
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

  // ── Kademeli ipucu ────────────────────────────────────────
  // Her basışta, kullanıcının baştan itibaren DOĞRU yerleştirdiği
  // kelimelerin sonrasındaki sıradaki doğru kelime yerleştirilir.
  // Doğru önekten sonraki yanlış kelimeler bankaya geri döner —
  // böylece kullanıcı nerede hata yaptığını da görür. Her ipucu -3 XP.
  void _useHint() {
    if (_studyPhase || _answerRevealed || _showCorrectFlash || _showWrongShake) {
      return;
    }
    final q = _questions[_currentIndex];

    // Baştan itibaren doğru yerleştirilmiş kelime sayısı (doğru önek)
    int prefix = 0;
    while (prefix < q.tokens.length && _answerSlots[prefix] == q.tokens[prefix]) {
      prefix++;
    }
    if (prefix >= q.tokens.length) return; // her şey zaten doğru

    final nextWord = q.tokens[prefix];

    setState(() {
      _hintCount++;

      // Önekten sonraki (yanlış) yerleştirmeleri bankaya geri al
      for (int i = q.tokens.length - 1; i >= prefix; i--) {
        final w = _answerSlots[i];
        if (w != null) {
          final emptyIdx = _wordBank.indexOf('');
          if (emptyIdx != -1) _wordBank[emptyIdx] = w;
          _answerSlots[i] = null;
        }
      }

      // Sıradaki doğru kelimeyi bankadan bulup yerine koy
      final bankIdx = _wordBank.indexOf(nextWord);
      if (bankIdx != -1) {
        _answerSlots[prefix] = nextWord;
        _wordBank[bankIdx] = '';
      }

      _nextSlotIndex = _answerSlots.indexOf(null);
      if (_nextSlotIndex == -1) _nextSlotIndex = _answerSlots.length;
    });

    HapticFeedback.lightImpact();

    // İpucu son slotu da doldurduysa otomatik kontrol
    if (_nextSlotIndex >= _answerSlots.length) {
      _checkAnswer();
    }
  }

  // ── Çıkış yolu: cevabı göster ─────────────────────────────
  // Tekrarlanan yanlış denemeden sonra kullanıcıya çıkış sunulur.
  // Not: 3 kalp sisteminde 3. yanlış oturumu bitirdiği için eşik
  // "aynı soruda 2 yanlış" (veya son kalpte 1 yanlış) olarak kuruldu.
  bool get _canReveal =>
      !_answerRevealed &&
      (_wrongAttempts >= 2 || (_wrongAttempts >= 1 && _hearts <= 1));

  /// Doğru cümleyi vurgulayarak gösterir; soru yanlış sayılır
  /// (XP verilmez, doğru sayacı artmaz) ve devam edilebilir.
  void _revealAnswer() {
    if (_answerRevealed || _showCorrectFlash) return;
    final q = _questions[_currentIndex];
    setState(() {
      _answerRevealed = true;
      _showWrongShake = false;
      _answerSlots = List<String?>.from(q.tokens);
      _wordBank = List<String>.filled(q.tokens.length, '');
      _nextSlotIndex = _answerSlots.length;
    });
    HapticFeedback.selectionClick();
  }

  // ═══════════════════════════════════════════════════════════
  // BUILD
  // ═══════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    // ── TRACK-AWARE GUARD ──────────────────────────────────
    // Hevokê çêke KU heritage cümleleri kullanır — EN track için uygun değil.
    final isEn = ref.watch(isEnglishModuleProvider);
    if (isEn) {
      return const EnComingSoonScreen(
        activityKu: 'Hevokê çêke',
        suggestedRoute: '/en/writing',
        suggestedLabel: 'EN Writing',
      );
    }

    if (_sessionComplete) return _buildResultScreen();

    // Yeterli cümle bulunamadıysa (pool boş) — erken boş ekran.
    if (_questions.isEmpty || _currentIndex >= _questions.length) {
      ActivityOutcome.reportNoContent();
      return Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundPrimary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => context.canPop()
                ? context.pop()
                : context.go(AppRoutes.home),
          ),
        ),
        body: Center(
          child: Text(
            'Vê beşê de hevokên bes tune ne.',
            style: AppTypography.body
                .copyWith(color: AppColors.textSecondary),
          ),
        ),
      );
    }

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
                    _studyPhase ? 'Hevokê bixwîne' : 'Peyvên rêz bike',
                    style: AppTypography.headline.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ).animate().fadeIn(duration: 300.ms),

                const SizedBox(height: 4),

                // Anlam ipucu: kaynak kelimenin TÜRKÇE karşılığı.
                // Kurmancî kaynak kelime gösterilmez — cevabı ele veriyordu.
                if (q.sourceWordTr.isNotEmpty)
                  Text(
                    '( ${q.sourceWordTr} )',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),

                const SizedBox(height: AppSpacing.lg),

                // ── İçerik: çalışma kartı veya cevap slotları ──
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    child: _studyPhase
                        ? _buildStudyCard(q)
                        : Column(
                            children: [
                              _buildAnswerSlots(q),
                              const Spacer(),
                              _buildWordBank(),
                              const SizedBox(height: AppSpacing.md),
                              _buildBottomControls(),
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
          const SizedBox(width: 6),
          const PersistentXpBadge(),
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
              : _answerRevealed
                  ? AppColors.warningSurface
                  : _showWrongShake
                      ? AppColors.errorSurface
                      : AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: _showCorrectFlash
                ? AppColors.success
                : _answerRevealed
                    ? AppColors.warning
                    : _showWrongShake
                        ? AppColors.errorSoft
                        : AppColors.borderLight,
            width: _showCorrectFlash || _showWrongShake || _answerRevealed
                ? 2
                : 1,
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
                isRevealed: _answerRevealed,
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

  // ── Çalışma kartı ─────────────────────────────────────────
  // Hedef cümle soru başında burada gösterilir; kullanıcı
  // "dest pê bike" deyince kart kapanır ve cümle gizlenir.
  Widget _buildStudyCard(_SentenceQuestion q) {
    return Column(
      children: [
        const Spacer(),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(color: AppColors.primary.withOpacity(0.4)),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.menu_book_rounded,
                color: AppColors.primary,
                size: 28,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                q.original,
                style: AppTypography.kurmanjiCard.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ).animate().fadeIn(duration: 300.ms),
        const SizedBox(height: AppSpacing.sm),
        Text(
          // TR modda yeni mekanik iki dilli anlatılır — ilk kez gören
          // başlangıç kullanıcısı yönergeyi anlayabilsin.
          ref.watch(showTurkishProvider)
              ? 'Hevokê baş bixwîne — paşê ew tê veşartin.\nCümleyi dikkatle oku — sonra gizlenecek.'
              : 'Hevokê baş bixwîne — paşê ew tê veşartin.',
          style: AppTypography.caption.copyWith(
            color: AppColors.textTertiary,
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => setState(() => _studyPhase = false),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              elevation: 0,
            ),
            child: Text(
              ref.watch(showTurkishProvider)
                  ? 'Min xwend — dest pê bike (Okudum, başla)'
                  : 'Min xwend — dest pê bike',
              style: AppTypography.labelLarge.copyWith(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }

  // ── Alt kontroller ────────────────────────────────────────
  // Normal: ipucu + cümleye tekrar bak (+ gerekirse cevabı göster).
  // Cevap gösterildiyse: sadece devam butonu.
  Widget _buildBottomControls() {
    if (_answerRevealed) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _advanceToNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            elevation: 0,
          ),
          child: Text(
            'Berdewam bike',
            style: AppTypography.labelLarge.copyWith(color: Colors.white),
          ),
        ),
      );
    }

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _buildHintButton(),
        _buildPeekButton(),
        if (_canReveal) _buildRevealButton(),
      ],
    );
  }

  // ── Hint butonu: kademeli, çok kullanımlı ─────────────────
  Widget _buildHintButton() {
    final showTr = ref.watch(showTurkishProvider);
    final base = showTr ? 'Alîkarî (ipucu)' : 'Alîkarî';
    return Semantics(
      button: true,
      label: base,
      child: GestureDetector(
        onTap: _useHint,
        child: Container(
          constraints: const BoxConstraints(minHeight: 44),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.warningSurface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            border: Border.all(color: AppColors.warning),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.lightbulb_outline_rounded,
                size: 18,
                color: AppColors.warning,
              ),
              const SizedBox(width: 6),
              Text(
                _hintCount > 0 ? '$base ($_hintCount) · -3 XP' : '$base · -3 XP',
                style: AppTypography.label.copyWith(color: AppColors.warning),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── "Cümleye tekrar bak" butonu ───────────────────────────
  // Gizlenen hedef cümleyi yeniden gösterir (çalışma kartına döner).
  // İlk kullanımda -3 XP; aynı soruda tekrar bakmak ek ceza getirmez.
  Widget _buildPeekButton() {
    final showTr = ref.watch(showTurkishProvider);
    final base = showTr ? 'Hevokê bibîne (cümleye bak)' : 'Hevokê bibîne';
    return Semantics(
      button: true,
      label: base,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() {
            _peekUsed = true;
            _studyPhase = true;
          });
        },
        child: Container(
          constraints: const BoxConstraints(minHeight: 44),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            border: Border.all(color: AppColors.primary),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.visibility_outlined,
                size: 18,
                color: AppColors.primary,
              ),
              const SizedBox(width: 6),
              Text(
                _peekUsed ? base : '$base · -3 XP',
                style: AppTypography.label.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── "Cevabı göster" butonu ────────────────────────────────
  Widget _buildRevealButton() {
    final showTr = ref.watch(showTurkishProvider);
    final label =
        showTr ? 'Bersivê nîşan bide (cevabı göster)' : 'Bersivê nîşan bide';
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: _revealAnswer,
        child: Container(
          constraints: const BoxConstraints(minHeight: 44),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.errorSurface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            border: Border.all(color: AppColors.errorSoft),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.help_outline_rounded,
                size: 18,
                color: AppColors.errorSoft,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style:
                    AppTypography.label.copyWith(color: AppColors.errorSoft),
              ),
            ],
          ),
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
              if (context.canPop()) context.pop(); else context.go(AppRoutes.home);
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

  bool _sessionCompleteSoundFired = false;

  Widget _buildResultScreen() {
    if (!_sessionCompleteSoundFired) {
      _sessionCompleteSoundFired = true;
      if (_questions.isEmpty) {
        ActivityOutcome.reportNoContent();
      } else {
        ActivityOutcome.report(
            ActivityOutcome(_correctCount, _questions.length));
      }
      SoundService.playSessionComplete();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final gami = ref.read(gamificationProvider.notifier);
        gami.resetCombo();
        if (_xpEarned > 0) gami.addXP(_xpEarned);
        // İLERLEME FIX: Beceri panosundaki 'grammar' (Gramer) sayacı hiç
        // beslenmiyordu — cümle kurma (sözdizimi) oturumu buraya işlenir.
        markSkillCompletedAndNotify(ref,
            module: ref.read(isEnglishModuleProvider) ? 'en' : 'ku',
            skill: 'grammar',
            xp: 10);
      });
    }
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
                      onPressed: () { if (context.canPop()) context.pop(); else context.go(AppRoutes.home); },
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
                        _sessionCompleteSoundFired = false;
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
  final bool isRevealed; // "Bersivê nîşan bide" ile gösterildi (turuncu vurgu)

  const _AnswerChip({
    required this.word,
    required this.onTap,
    this.isCorrect = false,
    this.isRevealed = false,
  });

  @override
  Widget build(BuildContext context) {
    final chipColor = isCorrect
        ? AppColors.success
        : isRevealed
            ? AppColors.warning
            : AppColors.primary;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        decoration: BoxDecoration(
          color: chipColor,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          boxShadow: [
            BoxShadow(
              color: chipColor.withOpacity(0.3),
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

List<dynamic> _sbWordsForLevel(String level) => switch (level.toUpperCase()) {
  'A1' => kA1TamListe.toList(),
  'A2' => kA2TamListe.toList(),
  'B1' => kB1All.toList(),
  'B2' => kB2All.toList(),
  'C1' => kC1All.toList(),
  'C2' => kC2All.toList(),
  _ => kA1TamListe.toList(),
};
