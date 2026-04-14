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
import '../../../shared/providers/language_mode_provider.dart';
import '../../lessons/domain/a1_kelime_db.dart';
import '../../lessons/domain/a2_kelime_db.dart';import '../../lessons/domain/b1_kelime_db.dart';import '../../lessons/domain/b2_kelime_db.dart';import '../../lessons/domain/c1_kelime_db.dart';import '../../lessons/domain/c2_kelime_db.dart';
import '../../../core/services/sound_service.dart';
import '../../../shared/utils/word_emoji_map.dart';

// ════════════════════════════════════════════════════════════════
// WORD MATCH — Peyvan Bike! (Kelime Eslestirme Oyunu)
//
// Sol sutun: Kurmanci kelimeler
// Sag sutun: Ceviri / Heritage cumlesi
// Dokunarak eslestir — dogru: yesil + cizgi, yanlis: titresim
//
// 6 cift / tur, 3 tur = 18 toplam eslesme
// Opsiyonel zamanlayici (challenge modu)
// Skor: Zaman bonusu + Dogru orani + XP
//
// Ilke: Destekleyici gamification, ceza degil tesvik.
// ════════════════════════════════════════════════════════════════

class WordMatchScreen extends ConsumerStatefulWidget {
  final String? category;
  final String level;
  const WordMatchScreen({super.key, this.category, this.level = 'A1'});

  @override
  ConsumerState<WordMatchScreen> createState() => _WordMatchScreenState();
}

class _WordMatchScreenState extends ConsumerState<WordMatchScreen>
    with TickerProviderStateMixin {
  // ── Yapilandirma ─────────────────────────────────────────────
  static const int _pairsPerRound = 6;
  static const int _totalRounds = 3;

  // ── Oyun durumu ──────────────────────────────────────────────
  int _currentRound = 0;
  int _correctMatches = 0;
  int _wrongAttempts = 0;
  int _totalCorrect = 0;
  int _totalWrong = 0;
  bool _sessionComplete = false;
  bool _challengeMode = false;

  // ── Zamanlayici ──────────────────────────────────────────────
  int _timeRemaining = 60; // saniye (tur basi)
  bool _timerActive = false;

  // ── Secim durumu ─────────────────────────────────────────────
  int? _selectedLeftIndex;
  int? _selectedRightIndex;

  // ── Tur verileri ─────────────────────────────────────────────
  late List<_MatchPair> _currentPairs;
  late List<int> _shuffledRightIndices;
  final Set<int> _matchedIndices = {};

  // ── Animasyon ────────────────────────────────────────────────
  late AnimationController _shakeController;
  late AnimationController _flashController;
  int? _shakingLeftIndex;
  int? _shakingRightIndex;
  Color? _flashColor;

  // ── Tum kelimeler ────────────────────────────────────────────
  late List<dynamic> _allWords;

  // ── Eslestirme renkleri ──────────────────────────────────────
  static const _matchColors = [
    Color(0xFF1A7B6B), // primary
    Color(0xFFD4783A), // accent
    Color(0xFF2D9E4F), // success
    Color(0xFF6B5CE7), // purple
    Color(0xFFE07B5A), // coral
    Color(0xFF3A8DD4), // blue
  ];
  final Map<int, Color> _matchColorMap = {};

  @override
  void initState() {
    super.initState();

    var source = _wmWordsForLevel(widget.level);
    if (widget.category != null && widget.category!.isNotEmpty) {
      final filtered = source.where((w) => w.kat == widget.category).toList();
      if (filtered.length >= 6) source = filtered;
    }
    _allWords = source;

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _flashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _flashController.addListener(() => setState(() {}));

    _startRound();
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _flashController.dispose();
    super.dispose();
  }

  // ── Tur baslat ───────────────────────────────────────────────
  void _startRound() {
    final rng = Random();
    final shuffled = List.of(_allWords)..shuffle(rng);
    final selected = shuffled.take(_pairsPerRound).toList();

    final isKuOnly = ref.read(languageModeProvider) == LanguageMode.kuOnly;

    _currentPairs = selected.asMap().entries.map((e) {
      final w = e.value;
      final String rightText;
      if (isKuOnly) {
        // Heritage cumlesi snippet veya kategori + emoji
        final heritageSentences = w.her as List<dynamic>;
        if (heritageSentences.isNotEmpty) {
          String sentence = heritageSentences.first.toString();
          // Kisalt: maks 30 karakter
          if (sentence.length > 30) {
            sentence = '${sentence.substring(0, 27)}...';
          }
          rightText = sentence;
        } else {
          rightText = '${_categoryEmoji(w.kat)} ${w.kat}';
        }
      } else {
        rightText = w.tr as String;
      }
      return _MatchPair(
        index: e.key,
        kuWord: w.ku as String,
        matchText: rightText,
      );
    }).toList();

    // Sag sutun karistir
    _shuffledRightIndices = List.generate(_pairsPerRound, (i) => i)
      ..shuffle(rng);

    _matchedIndices.clear();
    _matchColorMap.clear();
    _selectedLeftIndex = null;
    _selectedRightIndex = null;
    _correctMatches = 0;
    _wrongAttempts = 0;

    if (_challengeMode) {
      _timeRemaining = 60;
      _timerActive = true;
      _startTimer();
    }

    setState(() {});
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted || !_timerActive) return;
      setState(() {
        _timeRemaining--;
      });
      if (_timeRemaining <= 0) {
        _timerActive = false;
        _finishRound();
      } else {
        _startTimer();
      }
    });
  }

  // ── Sol sutun dokunma ────────────────────────────────────────
  void _onLeftTap(int index) {
    if (_matchedIndices.contains(index)) return;
    SoundService.playTap();
    HapticFeedback.selectionClick();

    setState(() {
      _selectedLeftIndex = index;
    });

    // Eger sag da secili ise eslestirme kontrol et
    if (_selectedRightIndex != null) {
      _checkMatch();
    }
  }

  // ── Sag sutun dokunma ────────────────────────────────────────
  void _onRightTap(int shuffledIndex) {
    final actualIndex = _shuffledRightIndices[shuffledIndex];
    if (_matchedIndices.contains(actualIndex)) return;
    HapticFeedback.selectionClick();

    setState(() {
      _selectedRightIndex = shuffledIndex;
    });

    // Eger sol da secili ise eslestirme kontrol et
    if (_selectedLeftIndex != null) {
      _checkMatch();
    }
  }

  // ── Eslestirme kontrolu ──────────────────────────────────────
  void _checkMatch() {
    final leftIdx = _selectedLeftIndex!;
    final rightActualIdx = _shuffledRightIndices[_selectedRightIndex!];

    if (leftIdx == rightActualIdx) {
      // Dogru eslestirme
      SoundService.playCorrect();
      HapticFeedback.mediumImpact();

      final colorIdx = _matchedIndices.length % _matchColors.length;
      _matchColorMap[leftIdx] = _matchColors[colorIdx];

      setState(() {
        _matchedIndices.add(leftIdx);
        _correctMatches++;
        _totalCorrect++;
        _selectedLeftIndex = null;
        _selectedRightIndex = null;
        _flashColor = AppColors.success;
      });

      _flashController.forward(from: 0);

      // Tur tamamlandi mi?
      if (_correctMatches == _pairsPerRound) {
        Future.delayed(const Duration(milliseconds: 600), _finishRound);
      }
    } else {
      // Yanlis eslestirme
      SoundService.playWrong();
      HapticFeedback.heavyImpact();
      _totalWrong++;
      _wrongAttempts++;

      setState(() {
        _shakingLeftIndex = leftIdx;
        _shakingRightIndex = _selectedRightIndex;
        _flashColor = AppColors.errorSoft;
      });

      _shakeController.forward(from: 0);
      _flashController.forward(from: 0);

      Future.delayed(const Duration(milliseconds: 400), () {
        if (!mounted) return;
        setState(() {
          _selectedLeftIndex = null;
          _selectedRightIndex = null;
          _shakingLeftIndex = null;
          _shakingRightIndex = null;
        });
      });
    }
  }

  // ── Tur bitis ────────────────────────────────────────────────
  void _finishRound() {
    _timerActive = false;

    if (_currentRound + 1 >= _totalRounds) {
      setState(() {
        _sessionComplete = true;
      });
    } else {
      setState(() {
        _currentRound++;
      });
      _startRound();
    }
  }

  // ── Skor hesaplama ───────────────────────────────────────────
  int get _xpEarned {
    final total = _totalCorrect + _totalWrong;
    if (total == 0) return 0;
    final accuracy = _totalCorrect / total;
    final base = _totalCorrect * 10;
    final accuracyBonus = accuracy >= 0.9 ? 20 : (accuracy >= 0.7 ? 10 : 0);
    final challengeBonus = _challengeMode ? 15 : 0;
    return base + accuracyBonus + challengeBonus;
  }

  double get _accuracy {
    final total = _totalCorrect + _totalWrong;
    if (total == 0) return 1.0;
    return _totalCorrect / total;
  }

  // ── Kategori emojisi ─────────────────────────────────────────
  static String _categoryEmoji(String kat) {
    switch (kat) {
      case 'selamlama': return '👋';
      case 'aile': return '👨‍👩‍👧';
      case 'sayi': return '🔢';
      case 'renk': return '🎨';
      case 'yemek': return '🍽️';
      case 'hayvan': return '🐾';
      case 'beden': return '🧍';
      case 'ev': return '🏠';
      case 'zaman': return '⏰';
      case 'doga': return '🌿';
      case 'giysiler': return '👗';
      case 'meslek': return '💼';
      default: return '📝';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_sessionComplete) return _buildResultScreen();
    return _buildGameScreen();
  }

  // ════════════════════════════════════════════════════════════════
  // OYUN EKRANI
  // ════════════════════════════════════════════════════════════════

  Widget _buildGameScreen() {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: AppColors.textPrimary),
          onPressed: () => _showExitDialog(),
        ),
        title: Text(
          'Peyvan Bike!',
          style: AppTypography.title.copyWith(color: AppColors.textPrimary),
        ),
        centerTitle: true,
        actions: [
          // Challenge mode toggle
          IconButton(
            icon: Icon(
              _challengeMode ? Icons.timer : Icons.timer_outlined,
              color: _challengeMode ? AppColors.accent : AppColors.textTertiary,
            ),
            onPressed: () {
              setState(() {
                _challengeMode = !_challengeMode;
                if (_challengeMode && !_timerActive) {
                  _timeRemaining = 60;
                  _timerActive = true;
                  _startTimer();
                } else {
                  _timerActive = false;
                }
              });
            },
            tooltip: 'Challenge Mode',
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.sm),

                  // ── Ust bilgi: tur + ilerleme + zamanlayici ──
                  _buildHeader(),

                  const SizedBox(height: AppSpacing.md),

                  // ── Ilerleme cubugu ──────────────────────────
                  _buildProgressBar(),

                  const SizedBox(height: AppSpacing.lg),

                  // ── Eslestirme alani ─────────────────────────
                  Expanded(child: _buildMatchArea()),

                  const SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
          ),

          // ── Flash overlay ──────────────────────────────────
          if (_flashColor != null)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  color: _flashColor!.withOpacity(
                    0.12 * (1 - _flashController.value),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── Ust bilgi satirlari ──────────────────────────────────────
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Tur bilgisi
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm + 4,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
          child: Text(
            'Dor ${_currentRound + 1}/$_totalRounds',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Eslestirme sayaci
        Text(
          '$_correctMatches/$_pairsPerRound',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),

        // Zamanlayici (sadece challenge modda)
        if (_challengeMode)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm + 4,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: _timeRemaining <= 10
                  ? AppColors.errorSoft.withOpacity(0.15)
                  : AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.timer_outlined,
                  size: 14,
                  color: _timeRemaining <= 10
                      ? AppColors.errorSoft
                      : AppColors.accent,
                ),
                const SizedBox(width: 4),
                Text(
                  '${_timeRemaining}s',
                  style: AppTypography.labelSmall.copyWith(
                    color: _timeRemaining <= 10
                        ? AppColors.errorSoft
                        : AppColors.accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          )
        else
          const SizedBox(width: 48),
      ],
    ).animate().fadeIn(duration: 300.ms);
  }

  // ── Ilerleme cubugu ──────────────────────────────────────────
  Widget _buildProgressBar() {
    final totalDone =
        _currentRound * _pairsPerRound + _correctMatches;
    final totalAll = _totalRounds * _pairsPerRound;
    final progress = totalDone / totalAll;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 6,
        backgroundColor: AppColors.borderLight,
        valueColor: const AlwaysStoppedAnimation(AppColors.primary),
      ),
    );
  }

  // ── Eslestirme alani — iki sutun ─────────────────────────────
  Widget _buildMatchArea() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sol sutun — Kurmanci kelimeler
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _pairsPerRound,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (_, index) => _buildLeftCard(index),
          ),
        ),

        const SizedBox(width: AppSpacing.sm),

        // Sag sutun — Ceviri / Heritage
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _pairsPerRound,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (_, index) => _buildRightCard(index),
          ),
        ),
      ],
    );
  }

  // ── Sol kart (Kurmanci) ──────────────────────────────────────
  Widget _buildLeftCard(int index) {
    final pair = _currentPairs[index];
    final isMatched = _matchedIndices.contains(index);
    final isSelected = _selectedLeftIndex == index;
    final isShaking = _shakingLeftIndex == index;
    final matchColor = _matchColorMap[index];

    return _MatchCard(
      text: pair.kuWord,
      isKurmanji: true,
      isSelected: isSelected,
      isMatched: isMatched,
      matchColor: matchColor,
      isShaking: isShaking,
      shakeController: _shakeController,
      onTap: () => _onLeftTap(index),
      delay: index * 60,
    );
  }

  // ── Sag kart (Ceviri / Heritage) ─────────────────────────────
  Widget _buildRightCard(int shuffledIndex) {
    final actualIndex = _shuffledRightIndices[shuffledIndex];
    final pair = _currentPairs[actualIndex];
    final isMatched = _matchedIndices.contains(actualIndex);
    final isSelected = _selectedRightIndex == shuffledIndex;
    final isShaking = _shakingRightIndex == shuffledIndex;
    final matchColor = _matchColorMap[actualIndex];

    return _MatchCard(
      text: pair.matchText,
      isKurmanji: false,
      isSelected: isSelected,
      isMatched: isMatched,
      matchColor: matchColor,
      isShaking: isShaking,
      shakeController: _shakeController,
      onTap: () => _onRightTap(shuffledIndex),
      delay: shuffledIndex * 60 + 30,
    );
  }

  // ── Cikis diyalogu ───────────────────────────────────────────
  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        title: Text(
          'Lîstikê berde?',
          style: AppTypography.title,
        ),
        content: Text(
          'Pêşketina te wê were parastin.',
          style: AppTypography.body.copyWith(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Na, bidomîne',
              style: AppTypography.label.copyWith(color: AppColors.primary),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (context.canPop()) context.pop(); else context.go(AppRoutes.home);
            },
            child: Text(
              'Erê, derkeve',
              style: AppTypography.label.copyWith(color: AppColors.textTertiary),
            ),
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════
  // SONUC EKRANI
  // ════════════════════════════════════════════════════════════════

  Widget _buildResultScreen() {
    final accuracyPercent = (_accuracy * 100).round();
    final stars = accuracyPercent >= 90 ? 3 : (accuracyPercent >= 70 ? 2 : 1);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Yildizlar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) {
                  final isActive = i < stars;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      isActive ? Icons.star_rounded : Icons.star_outline_rounded,
                      size: i == 1 ? 64 : 48,
                      color: isActive ? AppColors.accent : AppColors.borderLight,
                    ),
                  );
                }),
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .scale(begin: const Offset(0.5, 0.5), curve: Curves.elasticOut, duration: 700.ms),

              const SizedBox(height: AppSpacing.lg),

              // Tebrik mesaji
              Text(
                stars == 3
                    ? 'Pîroz be! 🎉'
                    : stars == 2
                        ? 'Baş e!'
                        : 'Berdewam bike!',
                style: AppTypography.headingLarge.copyWith(
                  color: AppColors.textPrimary,
                ),
              ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

              const SizedBox(height: AppSpacing.sm),

              Text(
                'Te $_totalCorrect peyv bi rast ket.',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

              const SizedBox(height: AppSpacing.xl),

              // Skor detaylari
              _ResultStatRow(
                icon: Icons.check_circle_outline,
                label: 'Rast',
                value: '$_totalCorrect',
                color: AppColors.success,
              ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.1),

              const SizedBox(height: AppSpacing.sm),

              _ResultStatRow(
                icon: Icons.close_rounded,
                label: 'Xelet',
                value: '$_totalWrong',
                color: AppColors.errorSoft,
              ).animate().fadeIn(delay: 600.ms).slideX(begin: -0.1),

              const SizedBox(height: AppSpacing.sm),

              _ResultStatRow(
                icon: Icons.percent_rounded,
                label: 'Rast bûn',
                value: '$accuracyPercent%',
                color: AppColors.primary,
              ).animate().fadeIn(delay: 700.ms).slideX(begin: -0.1),

              const SizedBox(height: AppSpacing.sm),

              _ResultStatRow(
                icon: Icons.bolt_rounded,
                label: 'XP',
                value: '+${_xpEarned}',
                color: AppColors.accent,
              ).animate().fadeIn(delay: 800.ms).slideX(begin: -0.1),

              const Spacer(),

              // Butonlar
              Row(
                children: [
                  // Tekrar oyna
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _currentRound = 0;
                          _totalCorrect = 0;
                          _totalWrong = 0;
                          _sessionComplete = false;
                        });
                        _startRound();
                      },
                      icon: const Icon(Icons.replay_rounded),
                      label: const Text('Dubare'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: AppSpacing.sm),

                  // Bitti — ana sayfa
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () { if (context.canPop()) context.pop(); else context.go(AppRoutes.home); },
                      icon: const Icon(Icons.check_rounded),
                      label: const Text('Temam'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(delay: 900.ms, duration: 400.ms)
                  .slideY(begin: 0.2),

              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// MATCH PAIR — Veri modeli
// ════════════════════════════════════════════════════════════════

class _MatchPair {
  final int index;
  final String kuWord;
  final String matchText;

  const _MatchPair({
    required this.index,
    required this.kuWord,
    required this.matchText,
  });
}

// ════════════════════════════════════════════════════════════════
// MATCH CARD — Tek eslestirme karti
// ════════════════════════════════════════════════════════════════

class _MatchCard extends StatelessWidget {
  final String text;
  final bool isKurmanji;
  final bool isSelected;
  final bool isMatched;
  final Color? matchColor;
  final bool isShaking;
  final AnimationController shakeController;
  final VoidCallback onTap;
  final int delay;

  const _MatchCard({
    required this.text,
    required this.isKurmanji,
    required this.isSelected,
    required this.isMatched,
    required this.matchColor,
    required this.isShaking,
    required this.shakeController,
    required this.onTap,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor;
    final Color bgColor;
    final double borderWidth;

    if (isMatched) {
      borderColor = matchColor ?? AppColors.success;
      bgColor = (matchColor ?? AppColors.success).withOpacity(0.08);
      borderWidth = 2.0;
    } else if (isSelected) {
      borderColor = AppColors.primary;
      bgColor = AppColors.primary.withOpacity(0.06);
      borderWidth = 2.5;
    } else {
      borderColor = AppColors.borderLight;
      bgColor = AppColors.backgroundSecondary;
      borderWidth = 1.0;
    }

    Widget card = GestureDetector(
      onTap: isMatched ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 4,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: borderColor, width: borderWidth),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Kurmancî kelimede emoji (görsel ipucu) — sağ sütunda yok
            if (isKurmanji) ...[
              Builder(
                builder: (_) {
                  final emoji = emojiForWord(text, '');
                  if (emoji.isEmpty) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(emoji, style: const TextStyle(fontSize: 20)),
                  );
                },
              ),
            ],
            Expanded(
              child: Text(
                text,
                style: isKurmanji
                    ? AppTypography.kurmanjiCard.copyWith(
                        color: isMatched
                            ? (matchColor ?? AppColors.success)
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      )
                    : AppTypography.body.copyWith(
                        color: isMatched
                            ? (matchColor ?? AppColors.success)
                            : AppColors.textPrimary,
                      ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isMatched)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.check_circle_rounded,
                  size: 18,
                  color: matchColor ?? AppColors.success,
                ),
              ),
          ],
        ),
      ),
    );

    // Titresim animasyonu (yanlis eslestirmede)
    if (isShaking) {
      card = AnimatedBuilder(
        animation: shakeController,
        builder: (_, child) {
          final dx = sin(shakeController.value * pi * 4) * 6;
          return Transform.translate(
            offset: Offset(dx, 0),
            child: child,
          );
        },
        child: card,
      );
    }

    // Giris animasyonu
    return card
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: delay),
          duration: 300.ms,
        )
        .slideX(
          begin: isKurmanji ? -0.15 : 0.15,
          delay: Duration(milliseconds: delay),
          duration: 300.ms,
          curve: Curves.easeOut,
        );
  }
}

// ════════════════════════════════════════════════════════════════
// SONUC STAT SATIRI
// ════════════════════════════════════════════════════════════════

class _ResultStatRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _ResultStatRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style: AppTypography.label.copyWith(color: AppColors.textSecondary),
          ),
          const Spacer(),
          Text(
            value,
            style: AppTypography.labelLarge.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

List<dynamic> _wmWordsForLevel(String level) => switch (level.toUpperCase()) {
  'A1' => kA1TamListe.toList(),
  'A2' => kA2TamListe.toList(),
  'B1' => kB1All.toList(),
  'B2' => kB2All.toList(),
  'C1' => kC1All.toList(),
  'C2' => kC2All.toList(),
  _ => kA1TamListe.toList(),
};
