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
import '../../../shared/widgets/speak_button.dart';
import '../../lessons/domain/a1_kelime_db.dart';
import '../../lessons/domain/a2_kelime_db.dart';
import '../../lessons/domain/b1_kelime_db.dart';
import '../../lessons/domain/b2_kelime_db.dart';
import '../../lessons/domain/c1_kelime_db.dart';
import '../../lessons/domain/c2_kelime_db.dart';
import '../../../core/services/sound_service.dart';
import '../../../shared/utils/word_emoji_map.dart';

// ════════════════════════════════════════════════════════════════
// FLASHCARD EKRANI — Tinder-Style Swipeable Kartlar
// Sag = Biliyorum (yeşil), Sol = Bilmiyorum (kırmızı)
// Dokunma = Kartı çevir (ön: Kurmancî, arka: TR + EN + örnek)
// ════════════════════════════════════════════════════════════════

class FlashcardScreen extends ConsumerStatefulWidget {
  final String? category;
  final String level;
  const FlashcardScreen({super.key, this.category, this.level = 'A1'});

  @override
  ConsumerState<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends ConsumerState<FlashcardScreen>
    with TickerProviderStateMixin {
  // ── Veri ────────────────────────────────────────────────────
  late List<_FlashcardItem> _cards;
  int _currentIndex = 0;
  int _knewCount = 0;
  int _didntKnowCount = 0;
  bool _sessionComplete = false;

  // ── Swipe animasyonu ───────────────────────────────────────
  late AnimationController _swipeController;
  late AnimationController _bounceController;
  Offset _dragOffset = Offset.zero;
  double _dragAngle = 0;
  bool _isDragging = false;
  _SwipeDirection? _swipeResult;

  // Swipe animasyon tween değerleri
  Offset _swipeStartOffset = Offset.zero;
  double _swipeStartAngle = 0;
  double _swipeTargetX = 0;

  // ── Flip animasyonu ────────────────────────────────────────
  late AnimationController _flipController;
  bool _showFront = true;

  // ── Flash overlay ──────────────────────────────────────────
  Color? _flashColor;
  late AnimationController _flashController;

  // ── Kart sayısı (oturum başına) ────────────────────────────
  static const int _sessionCardCount = 20;

  @override
  void initState() {
    super.initState();

    // Seviyeye göre kelime yükle
    var allWords = _wordsForLevel(widget.level);
    if (widget.category != null && widget.category!.isNotEmpty) {
      final filtered = allWords.where((w) => w.kat == widget.category).toList();
      if (filtered.length >= 4) allWords = filtered;
    }
    allWords.shuffle(Random());
    _cards = allWords
        .take(_sessionCardCount)
        .map((w) => _FlashcardItem.fromRecord(w))
        .toList();

    _swipeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      value: 0,
    );

    _flashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _swipeController.addStatusListener(_onSwipeComplete);
    _swipeController.addListener(_onSwipeAnimationTick);

    _bounceController.addListener(_onBounceTick);

    _flashController.addListener(() => setState(() {}));
    _flashController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _flashColor = null);
      }
    });
  }

  @override
  void dispose() {
    _swipeController.dispose();
    _bounceController.dispose();
    _flipController.dispose();
    _flashController.dispose();
    super.dispose();
  }

  // ── Animasyon tick'leri ──────────────────────────────────────

  void _onSwipeAnimationTick() {
    setState(() {
      final t = _swipeController.value;
      _dragOffset = Offset(
        _swipeStartOffset.dx + (_swipeTargetX - _swipeStartOffset.dx) * t,
        _swipeStartOffset.dy + (_swipeStartOffset.dy * 0.3) * t,
      );
      _dragAngle = _swipeStartAngle + (_swipeStartAngle * 2) * t;
    });
  }

  Offset _bounceStartOffset = Offset.zero;
  double _bounceStartAngle = 0;

  void _onBounceTick() {
    setState(() {
      final t = _bounceController.value;
      _dragOffset = Offset.lerp(_bounceStartOffset, Offset.zero, t)!;
      _dragAngle = _bounceStartAngle * (1 - t);
    });
  }

  // ── Swipe mantığı ──────────────────────────────────────────

  void _onPanStart(DragStartDetails details) {
    _isDragging = true;
    _bounceController.stop();
    _swipeController.stop();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;
    setState(() {
      _dragOffset += details.delta;
      _dragAngle = _dragOffset.dx * 0.001; // Hafif rotasyon
    });
  }

  void _onPanEnd(DragEndDetails details) {
    _isDragging = false;
    final screenWidth = MediaQuery.of(context).size.width;
    final threshold = screenWidth * 0.3;

    if (_dragOffset.dx.abs() > threshold) {
      // Yeterli swipe — animasyonla dışarı at
      _swipeResult = _dragOffset.dx > 0
          ? _SwipeDirection.right
          : _SwipeDirection.left;

      final targetX = _swipeResult == _SwipeDirection.right
          ? screenWidth * 1.5
          : -screenWidth * 1.5;

      _swipeStartOffset = _dragOffset;
      _swipeStartAngle = _dragAngle;
      _swipeTargetX = targetX;

      _swipeController.reset();

      // Haptic
      HapticFeedback.mediumImpact();

      // Flash renk
      _flashColor = _swipeResult == _SwipeDirection.right
          ? AppColors.success
          : AppColors.errorSoft;
      _flashController.reset();
      _flashController.forward();

      _swipeController.forward();
    } else {
      // Geri zıplat
      _bounceStartOffset = _dragOffset;
      _bounceStartAngle = _dragAngle;
      _bounceController.reset();
      _bounceController.forward();
    }
  }

  void _onSwipeComplete(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    if (_swipeResult == null) return;

    // Sonucu kaydet
    if (_swipeResult == _SwipeDirection.right) {
      _knewCount++;
      SoundService.playCorrect();
    } else {
      _didntKnowCount++;
      SoundService.playWrong();
      // Smart Review: zayıf kelime olarak kaydet
      ref.read(reviewProvider.notifier).addWeakWord(_cards[_currentIndex].id);
    }

    // Sonraki kart
    setState(() {
      _currentIndex++;
      _dragOffset = Offset.zero;
      _dragAngle = 0;
      _swipeResult = null;
      _showFront = true;
      _flipController.value = 0;

      if (_currentIndex >= _cards.length) {
        _sessionComplete = true;
        HapticFeedback.heavyImpact();
      }
    });
  }

  // ── Buton ile swipe ────────────────────────────────────────

  void _swipeViaButton(_SwipeDirection direction) {
    if (_sessionComplete || _currentIndex >= _cards.length) return;

    _swipeResult = direction;
    final screenWidth = MediaQuery.of(context).size.width;
    final targetX = direction == _SwipeDirection.right
        ? screenWidth * 1.5
        : -screenWidth * 1.5;

    HapticFeedback.mediumImpact();

    _flashColor = direction == _SwipeDirection.right
        ? AppColors.success
        : AppColors.errorSoft;
    _flashController.reset();
    _flashController.forward();

    _swipeStartOffset = Offset.zero;
    _swipeStartAngle = 0;
    _swipeTargetX = targetX;

    _swipeController.reset();
    _swipeController.forward();
  }

  // ── Kart çevirme ──────────────────────────────────────────

  void _flipCard() {
    HapticFeedback.lightImpact();
    SoundService.playFlip();
    if (_showFront) {
      _flipController.forward();
    } else {
      _flipController.reverse();
    }
    _showFront = !_showFront;
  }

  // ── Build ─────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: _sessionComplete
            ? _buildSessionSummary()
            : _buildCardSession(),
      ),
    );
  }

  Widget _buildCardSession() {
    return Stack(
      children: [
        Column(
          children: [
            // ── Üst bar ─────────────────────────────────────
            _buildTopBar(),

            // ── Progress bar ────────────────────────────────
            _buildProgressBar(),

            // ── Kart alanı ──────────────────────────────────
            Expanded(
              child: _buildCardStack(),
            ),

            // ── Alt butonlar ────────────────────────────────
            _buildActionButtons(),

            const SizedBox(height: AppSpacing.md),
          ],
        ),

        // ── Flash overlay ─────────────────────────────────
        if (_flashColor != null)
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                color: _flashColor!.withOpacity(
                  0.15 * (1 - _flashController.value),
                ),
              ),
            ),
          ),
      ],
    );
  }

  // ── Top bar ────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          // Geri butonu
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              context.pop();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                size: 20,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          // Başlık
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Peld',
                  style: AppTypography.title.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${_currentIndex + 1} / ${_cards.length}',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Skor göstergesi
          Row(
            children: [
              _ScorePill(
                icon: Icons.check_rounded,
                count: _knewCount,
                color: AppColors.success,
              ),
              const SizedBox(width: 8),
              _ScorePill(
                icon: Icons.close_rounded,
                count: _didntKnowCount,
                color: AppColors.errorSoft,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Progress bar ───────────────────────────────────────────

  Widget _buildProgressBar() {
    final progress = _cards.isEmpty ? 0.0 : _currentIndex / _cards.length;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.primary.withOpacity(0.12),
          valueColor: const AlwaysStoppedAnimation(AppColors.primary),
          minHeight: 6,
        ),
      ),
    );
  }

  // ── Kart yığını ────────────────────────────────────────────

  Widget _buildCardStack() {
    if (_currentIndex >= _cards.length) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Arka kartlar (perspektif derinliği)
              for (int i = min(_currentIndex + 2, _cards.length - 1);
                  i > _currentIndex;
                  i--)
                _buildBackgroundCard(
                  i - _currentIndex,
                  constraints,
                ),

              // Aktif kart — swipe + flip
              GestureDetector(
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
                onTap: _flipCard,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..translate(_dragOffset.dx, _dragOffset.dy)
                    ..rotateZ(_dragAngle),
                  child: _buildFlipCard(
                    _cards[_currentIndex],
                    constraints,
                  ),
                ),
              ),

              // Swipe ipucu overlay'leri
              if (_isDragging) ...[
                // Sag swipe ipucu
                Positioned(
                  left: AppSpacing.lg,
                  top: AppSpacing.xl,
                  child: Opacity(
                    opacity: (_dragOffset.dx / 100).clamp(0.0, 1.0),
                    child: Transform.rotate(
                      angle: -0.2,
                      child: _SwipeHintBadge(
                        text: 'Dizanim',
                        color: AppColors.success,
                        icon: Icons.check_rounded,
                      ),
                    ),
                  ),
                ),
                // Sol swipe ipucu
                Positioned(
                  right: AppSpacing.lg,
                  top: AppSpacing.xl,
                  child: Opacity(
                    opacity: (-_dragOffset.dx / 100).clamp(0.0, 1.0),
                    child: Transform.rotate(
                      angle: 0.2,
                      child: _SwipeHintBadge(
                        text: 'Nizanim',
                        color: AppColors.errorSoft,
                        icon: Icons.close_rounded,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildBackgroundCard(int depth, BoxConstraints constraints) {
    final scale = 1.0 - (depth * 0.05);
    final yOffset = depth * 12.0;

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..translate(0.0, yOffset)
        ..scale(scale),
      child: Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight * 0.85,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06 - depth * 0.02),
              blurRadius: 12,
              offset: Offset(0, 4 + depth * 2),
            ),
          ],
          border: Border.all(
            color: AppColors.borderLight.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  // ── Flip Card ─────────────────────────────────────────────

  Widget _buildFlipCard(_FlashcardItem card, BoxConstraints constraints) {
    return AnimatedBuilder(
      animation: _flipController,
      builder: (context, child) {
        final angle = _flipController.value * pi;
        final isFrontVisible = angle < pi / 2;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspektif
            ..rotateY(angle),
          child: Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight * 0.85,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                  spreadRadius: 2,
                ),
              ],
              border: Border.all(
                color: _isDragging
                    ? (_dragOffset.dx > 30
                        ? AppColors.success.withOpacity(0.4)
                        : _dragOffset.dx < -30
                            ? AppColors.errorSoft.withOpacity(0.4)
                            : AppColors.borderLight)
                    : AppColors.borderLight,
                width: 1.5,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusXl - 1),
              child: isFrontVisible
                  ? _buildCardFront(card)
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(pi),
                      child: _buildCardBack(card),
                    ),
            ),
          ),
        );
      },
    );
  }

  // ── Kart ön yüz ───────────────────────────────────────────

  Widget _buildCardFront(_FlashcardItem card) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          // Kategori ve zorluk badgeleri
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CategoryBadge(category: card.kategori),
              _LevelBadge(difficulty: card.zorluk),
            ],
          ),

          // Kurmancî kelime — ortada, büyük
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Cinsiyet etiketi
                  if (card.cinsiyet != 'bêcins')
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: card.cinsiyet == 'nêr'
                            ? const Color(0xFF2196F3).withOpacity(0.1)
                            : const Color(0xFFE91E63).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                            AppSpacing.radiusFull),
                        border: Border.all(
                          color: card.cinsiyet == 'nêr'
                              ? const Color(0xFF2196F3).withOpacity(0.3)
                              : const Color(0xFFE91E63).withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        card.cinsiyet == 'nêr'
                            ? (ref.watch(showTurkishProvider) ? 'nêr (eril)' : 'nêr')
                            : (ref.watch(showTurkishProvider) ? 'mê (dişil)' : 'mê'),
                        style: AppTypography.labelSmall.copyWith(
                          color: card.cinsiyet == 'nêr'
                              ? const Color(0xFF2196F3)
                              : const Color(0xFFE91E63),
                        ),
                      ),
                    ),

                  // Kelime emojisi (gorsel ipucu)
                  if (emojiForWord(card.kurmanji, card.kategori).isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        emojiForWord(card.kurmanji, card.kategori),
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),

                  // Ana kelime + speak button
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          card.kurmanji,
                          style: AppTypography.displayKurmanji.copyWith(
                            fontSize: card.kurmanji.length > 12 ? 28 : 36,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // TTS speak button — tap to hear pronunciation
                      SpeakButton(
                        text: card.kurmanji,
                        size: 36,
                        color: AppColors.primary,
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Ezafe formu
                  if (card.ezafe != null)
                    Text(
                      'Ezafe: ${card.ezafe}',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Alt ipucu
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.backgroundTertiary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.touch_app_rounded,
                  size: 16,
                  color: AppColors.textTertiary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Peldê bide ser ku wateya wê bibîne',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Kart arka yüz ─────────────────────────────────────────

  Widget _buildCardBack(_FlashcardItem card) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surface,
            AppColors.primarySurface.withOpacity(0.3),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kurmancî kelime (küçük)
            Center(
              child: Text(
                card.kurmanji,
                style: AppTypography.kurmanjiLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            const Divider(height: 1),
            const SizedBox(height: AppSpacing.md),

            // Çeviri — Tirkî an Inglîzî li gor moda zimanê
            _TranslationRow(
              flag: ref.watch(showTurkishProvider) ? '🇹🇷' : '🇬🇧',
              label: ref.watch(showTurkishProvider) ? 'Tirkî' : 'English',
              text: ref.watch(showTurkishProvider) ? card.turkce : card.ingilizce,
            ),
            const SizedBox(height: AppSpacing.md),

            // Cinsiyet notu
            if (card.cinsiyetNotu != null) ...[
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.warningSurface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  border: Border.all(
                    color: AppColors.warning.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      size: 16,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        card.cinsiyetNotu!,
                        style: AppTypography.body.copyWith(
                          color: AppColors.textPrimary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],

            // Heritage cümleleri
            if (card.heritageSentences.isNotEmpty) ...[
              Text(
                'Mînak (Heritage)',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              for (final sentence in card.heritageSentences)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '  ',
                        style: AppTypography.body.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          sentence,
                          style: AppTypography.body.copyWith(
                            color: AppColors.textPrimary,
                            fontStyle: FontStyle.italic,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: AppSpacing.sm),
            ],

            // Gramer notu
            if (card.cinsiyetNotu != null &&
                card.cinsiyet != 'bêcins') ...[
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.school_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Cinsiyet: ${card.cinsiyet == 'nêr' ? (ref.watch(showTurkishProvider) ? 'Nêr (Eril)' : 'Nêr') : (ref.watch(showTurkishProvider) ? 'Mê (Dişil)' : 'Mê')}${card.ezafe != null ? ' — Ezafe: ${card.ezafe}' : ''}',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ── Alt aksiyon butonları ──────────────────────────────────

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Bilmiyorum
          _ActionButton(
            icon: Icons.close_rounded,
            color: AppColors.errorSoft,
            label: 'Nizanim',
            onTap: () => _swipeViaButton(_SwipeDirection.left),
          ),

          // Çevir
          _ActionButton(
            icon: Icons.flip_rounded,
            color: AppColors.primary,
            label: 'Bizivirîne',
            size: 52,
            onTap: _flipCard,
          ),

          // Biliyorum
          _ActionButton(
            icon: Icons.check_rounded,
            color: AppColors.success,
            label: 'Dizanim',
            onTap: () => _swipeViaButton(_SwipeDirection.right),
          ),
        ],
      ),
    );
  }

  // ── Oturum özeti ───────────────────────────────────────────

  Widget _buildSessionSummary() {
    final total = _knewCount + _didntKnowCount;
    final percentage = total > 0 ? (_knewCount / total * 100).round() : 0;
    final xpEarned = _knewCount * 10 + _didntKnowCount * 3;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xxl),

          // Mascot kutlama
          Image.asset(
            'assets/images/mascot_128.png',
            width: 100,
            height: 100,
            filterQuality: FilterQuality.medium,
          ).animate().scale(
                begin: const Offset(0.5, 0.5),
                duration: 600.ms,
                curve: Curves.elasticOut,
              ),

          const SizedBox(height: AppSpacing.lg),

          Text(
            'Derse temam!',
            style: AppTypography.displayKurmanji.copyWith(
              color: AppColors.primary,
            ),
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: AppSpacing.xs),

          Text(
            ref.watch(showTurkishProvider)
                ? 'Peld danişîna temam bû'
                : 'Danişîna peldan temam bû',
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
            ),
          ).animate().fadeIn(delay: 300.ms),

          const SizedBox(height: AppSpacing.xl),

          // Skor kartı
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Yüzde dairesi
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(
                          value: total > 0 ? _knewCount / total : 0,
                          strokeWidth: 10,
                          backgroundColor:
                              AppColors.errorSoft.withOpacity(0.15),
                          valueColor:
                              const AlwaysStoppedAnimation(AppColors.success),
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '%$percentage',
                            style: AppTypography.streakCounter.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'Rast',
                            style: AppTypography.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),
                const Divider(height: 1),
                const SizedBox(height: AppSpacing.lg),

                // Detay satırları
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _SummaryStatItem(
                      icon: Icons.check_circle_rounded,
                      color: AppColors.success,
                      value: '$_knewCount',
                      label: 'Dizanim',
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: AppColors.borderLight,
                    ),
                    _SummaryStatItem(
                      icon: Icons.cancel_rounded,
                      color: AppColors.errorSoft,
                      value: '$_didntKnowCount',
                      label: 'Nizanim',
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: AppColors.borderLight,
                    ),
                    _SummaryStatItem(
                      icon: Icons.star_rounded,
                      color: AppColors.accent,
                      value: '+$xpEarned',
                      label: 'XP',
                    ),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),

          const SizedBox(height: AppSpacing.xl),

          // Tekrar oyna butonu
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                  _knewCount = 0;
                  _didntKnowCount = 0;
                  _sessionComplete = false;
                  _dragOffset = Offset.zero;
                  _dragAngle = 0;
                  _showFront = true;
                  _flipController.value = 0;

                  // Yeni rastgele seçim
                  final allWords = _wordsForLevel(widget.level)
                      .toList();
                  allWords.shuffle(Random());
                  _cards = allWords
                      .take(_sessionCardCount)
                      .map((w) => _FlashcardItem.fromRecord(w))
                      .toList();
                });
              },
              icon: const Icon(Icons.replay_rounded),
              label: const Text('Dîsa bilîze'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                ),
                textStyle: AppTypography.labelLarge,
                elevation: 0,
              ),
            ),
          ).animate().fadeIn(delay: 600.ms),

          const SizedBox(height: AppSpacing.sm),

          // Ana sayfaya dön butonu
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => context.pop(),
              child: Text(
                'Vegerê malê',
                style: AppTypography.label.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ).animate().fadeIn(delay: 700.ms),

          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// YARDIMCI WIDGET'LAR
// ════════════════════════════════════════════════════════════════

enum _SwipeDirection { left, right }

class _ScorePill extends StatelessWidget {
  final IconData icon;
  final int count;
  final Color color;

  const _ScorePill({
    required this.icon,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            '$count',
            style: AppTypography.labelSmall.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Kategori -> emoji eslesmesi (flashcard icin, fallback olarak kullanilir)
/// Kelime bazli emoji icin emojiForWord() kullanilir (word_emoji_map.dart)
String _emojiForCategory(String kat) => switch (kat) {
  'silav' || 'selamlama' => '\u{1F44B}',
  'malbat'               => '\u{1F468}\u{200D}\u{1F469}\u{200D}\u{1F467}\u{200D}\u{1F466}',
  'xwarin'               => '\u{1F37D}\u{FE0F}',
  'vexwarin'             => '\u{1F964}',
  'mêwe' || 'mewe'       => '\u{1F34E}',
  'ajal'                 => '\u{1F43E}',
  'reng'                 => '\u{1F3A8}',
  'jimar'                => '\u{1F522}',
  'mal'                  => '\u{1F3E0}',
  'cil'                  => '\u{1F455}',
  'beden'                => '\u{1FAC1}',
  'tendurist'            => '\u{1F48A}',
  'pîşe' || 'pise'       => '\u{1F477}',
  'dem'                  => '\u{23F0}',
  'roj'                  => '\u{1F4C5}',
  'demsal'               => '\u{1F326}\u{FE0F}',
  'cih'                  => '\u{1F4CD}',
  'gihanî'               => '\u{1F697}',
  'leker'                => '\u{1F3C3}',
  'xweza'                => '\u{1F33F}',
  'perwerde'             => '\u{1F4DA}',
  'alfabe'               => '\u{1F524}',
  _                      => '',
};

class _CategoryBadge extends StatelessWidget {
  final String category;
  const _CategoryBadge({required this.category});

  String get _displayName => switch (category) {
        'selamlama' => 'Silav',
        'aile' => 'Malbat',
        'beden' => 'Beden',
        'ev' => 'Mal',
        'renk' => 'Reng',
        'fiil' => 'Lêker',
        'yemek' => 'Xwarin',
        'giyim' => 'Cil',
        'ajal' => 'Ajal',
        'doga' => 'Xweza',
        'sayi' => 'Hejmar',
        'zaman' => 'Dem',
        'pîşe' => 'Pîşe',
        _ => category,
      };

  @override
  Widget build(BuildContext context) {
    final emoji = _emojiForCategory(category);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        border: Border.all(color: AppColors.primary.withOpacity(0.15)),
      ),
      child: Text(
        emoji.isNotEmpty ? '$emoji $_displayName' : _displayName,
        style: AppTypography.labelSmall.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  final double difficulty;
  const _LevelBadge({required this.difficulty});

  String get _levelText {
    if (difficulty >= 0.85) return 'Hêsan'; // Kolay
    if (difficulty >= 0.70) return 'Navîn'; // Orta
    return 'Dijwar'; // Zor
  }

  Color get _levelColor {
    if (difficulty >= 0.85) return AppColors.success;
    if (difficulty >= 0.70) return AppColors.warning;
    return AppColors.errorSoft;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _levelColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        border: Border.all(color: _levelColor.withOpacity(0.2)),
      ),
      child: Text(
        _levelText,
        style: AppTypography.labelSmall.copyWith(
          color: _levelColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SwipeHintBadge extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;

  const _SwipeHintBadge({
    required this.text,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: color, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 6),
          Text(
            text,
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

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final double size;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.label,
    this.size = 60,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.3), width: 2),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: size * 0.45),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _TranslationRow extends StatelessWidget {
  final String flag;
  final String label;
  final String text;

  const _TranslationRow({
    required this.flag,
    required this.label,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(flag, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              Text(
                text,
                style: AppTypography.title.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryStatItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  const _SummaryStatItem({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTypography.xpCounter.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// VERİ MODELİ — Kelime DB Record'ından dönüşüm
// ════════════════════════════════════════════════════════════════

class _FlashcardItem {
  final String id;
  final String kurmanji;
  final String turkce;
  final String ingilizce;
  final String cinsiyet;
  final String? ezafe;
  final String kategori;
  final double zorluk;
  final String? cinsiyetNotu;
  final List<String> heritageSentences;
  final List<String> generalSentences;

  const _FlashcardItem({
    required this.id,
    required this.kurmanji,
    required this.turkce,
    required this.ingilizce,
    required this.cinsiyet,
    this.ezafe,
    required this.kategori,
    required this.zorluk,
    this.cinsiyetNotu,
    required this.heritageSentences,
    required this.generalSentences,
  });

  factory _FlashcardItem.fromRecord(dynamic record) {
    return _FlashcardItem(
      id: record.id as String,
      kurmanji: record.ku as String,
      turkce: record.tr as String,
      ingilizce: record.en as String,
      cinsiyet: record.cins as String,
      ezafe: record.ez as String?,
      kategori: record.kat as String,
      zorluk: (record.zor as num).toDouble(),
      cinsiyetNotu: record.not as String?,
      heritageSentences: (record.her as List).cast<String>(),
      generalSentences: (record.gen as List).cast<String>(),
    );
  }
}

/// Seviyeye göre kelime listesi döndürür.
List<dynamic> _wordsForLevel(String level) => switch (level.toUpperCase()) {
  'A1' => kA1TamKelimeler.toList(),
  'A2' => kA2Kelimeler.toList(),
  'B1' => kB1Kelimeler.toList(),
  'B2' => kB2Kelimeler.toList(),
  'C1' => kC1Kelimeler.toList(),
  'C2' => kC2Kelimeler.toList(),
  _ => kA1TamKelimeler.toList(),
};
