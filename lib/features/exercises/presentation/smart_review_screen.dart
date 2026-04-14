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
import '../../../shared/providers/review_provider.dart';
import '../../lessons/domain/a1_kelime_db.dart';
import '../../lessons/domain/a2_kelime_db.dart';
import '../../lessons/domain/b1_kelime_db.dart';
import '../../lessons/domain/b2_kelime_db.dart';
import '../../lessons/domain/c1_kelime_db.dart';
import '../../lessons/domain/c2_kelime_db.dart';

// ════════════════════════════════════════════════════════════════
// SMART REVIEW (DUBARE) EKRANI
//
// Zayıf kelimeleri akıllı tekrar sistemiyle sunar.
// Kart yığını UI — her kart: kelime + gramer notu + örnek
// "Dizanim" (Biliyorum) / "Nizanim" (Bilmiyorum) butonları
// 3 kez üst üste doğru → kelime mastered, listeden çıkar
// ════════════════════════════════════════════════════════════════

/// Tekrar kartı verisi — kelime DB kaydından oluşturulur.
class _ReviewCardData {
  final String id;
  final String kurmanji;
  final String turkce;
  final String ingilizce;
  final String? grammarNote;
  final List<String> exampleSentences;
  final String category;

  const _ReviewCardData({
    required this.id,
    required this.kurmanji,
    required this.turkce,
    required this.ingilizce,
    this.grammarNote,
    required this.exampleSentences,
    required this.category,
  });
}

class SmartReviewScreen extends ConsumerStatefulWidget {
  const SmartReviewScreen({super.key});

  @override
  ConsumerState<SmartReviewScreen> createState() => _SmartReviewScreenState();
}

class _SmartReviewScreenState extends ConsumerState<SmartReviewScreen>
    with TickerProviderStateMixin {
  // ── Veri ────────────────────────────────────────────────────
  List<_ReviewCardData> _reviewCards = [];
  int _currentIndex = 0;
  int _knewCount = 0;
  int _didntKnowCount = 0;
  bool _sessionComplete = false;
  bool _isFlipped = false;

  // ── Animasyonlar ───────────────────────────────────────────
  late AnimationController _flipController;
  late AnimationController _slideController;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: 1.0,
    );

    // Kartları bir sonraki frame'de yükle (provider hazır olduğunda)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadReviewCards();
    });
  }

  void _loadReviewCards() {
    final reviewState = ref.read(reviewProvider);
    final reviewWords = reviewState.getReviewWords(maxCount: 20);

    if (reviewWords.isEmpty) {
      setState(() => _sessionComplete = true);
      return;
    }

    // Kelime DB'lerinden verileri bul
    final allDbWords = [
      ...kA1TamListe,
      ...kA2TamListe,
      ...kB1All,
      ...kB2All,
      ...kC1All,
      ...kC2All,
    ];

    final cards = <_ReviewCardData>[];
    for (final weakWord in reviewWords) {
      final dbMatch = allDbWords.where((w) => w.id == weakWord.wordId).firstOrNull;
      if (dbMatch != null) {
        cards.add(_ReviewCardData(
          id: dbMatch.id,
          kurmanji: dbMatch.ku,
          turkce: dbMatch.tr,
          ingilizce: dbMatch.en,
          grammarNote: dbMatch.not as String?,
          exampleSentences: (dbMatch.her as List).cast<String>(),
          category: dbMatch.kat as String,
        ));
      }
    }

    setState(() {
      _reviewCards = cards;
      if (cards.isEmpty) _sessionComplete = true;
    });
  }

  @override
  void dispose() {
    _flipController.dispose();
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  // ── Kart İşlemleri ─────────────────────────────────────────

  void _flipCard() {
    HapticFeedback.lightImpact();
    setState(() => _isFlipped = !_isFlipped);
    if (_isFlipped) {
      _flipController.forward();
    } else {
      _flipController.reverse();
    }
  }

  void _onKnow() {
    if (_currentIndex >= _reviewCards.length) return;
    HapticFeedback.lightImpact();

    final wordId = _reviewCards[_currentIndex].id;
    ref.read(reviewProvider.notifier).markCorrect(wordId);

    setState(() {
      _knewCount++;
    });

    _advanceCard();
  }

  void _onDontKnow() {
    if (_currentIndex >= _reviewCards.length) return;
    HapticFeedback.mediumImpact();

    final wordId = _reviewCards[_currentIndex].id;
    ref.read(reviewProvider.notifier).markIncorrect(wordId);

    setState(() {
      _didntKnowCount++;
    });

    _advanceCard();
  }

  void _advanceCard() {
    _fadeController.reverse().then((_) {
      setState(() {
        _currentIndex++;
        _isFlipped = false;
        _flipController.value = 0;

        if (_currentIndex >= _reviewCards.length) {
          _sessionComplete = true;
          ref.read(reviewProvider.notifier).completeReviewSession();
        }
      });
      _fadeController.forward();
    });
  }

  // ── Build ──────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final showTurkish = ref.watch(showTurkishProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: AppColors.textPrimary),
          onPressed: () { if (context.canPop()) context.pop(); else context.go(AppRoutes.home); },
        ),
        title: Text(
          'Dubare',
          style: AppTypography.title.copyWith(color: AppColors.textPrimary),
        ),
        centerTitle: true,
        actions: [
          if (!_sessionComplete && _reviewCards.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.md),
              child: Center(
                child: Text(
                  '${_currentIndex + 1} / ${_reviewCards.length}',
                  style: AppTypography.label.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: _sessionComplete
          ? _buildCompletionScreen()
          : _reviewCards.isEmpty
              ? _buildEmptyState()
              : _buildReviewSession(showTurkish),
    );
  }

  // ── Tekrar Oturumu ─────────────────────────────────────────

  Widget _buildReviewSession(bool showTurkish) {
    return Column(
      children: [
        // ── İlerleme çubuğu ─────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.sm),
              ClipRRect(
                borderRadius: AppRadius.full,
                child: LinearProgressIndicator(
                  value: _reviewCards.isNotEmpty
                      ? _currentIndex / _reviewCards.length
                      : 0,
                  minHeight: 6,
                  backgroundColor: AppColors.borderLight,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '$_currentIndex / ${_reviewCards.length} peyv dubare kirin',
                style: AppTypography.caption,
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // ── Skor göstergesi ─────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ScorePill(
                icon: Icons.check_circle_rounded,
                count: _knewCount,
                color: AppColors.success,
              ),
              const SizedBox(width: AppSpacing.md),
              _ScorePill(
                icon: Icons.cancel_rounded,
                count: _didntKnowCount,
                color: AppColors.errorSoft,
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // ── Kart ─────────────────────────────────────────────
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: FadeTransition(
              opacity: _fadeController,
              child: GestureDetector(
                onTap: _flipCard,
                child: _currentIndex < _reviewCards.length
                    ? _buildCard(_reviewCards[_currentIndex], showTurkish)
                    : const SizedBox.shrink(),
              ),
            ),
          ),
        ),

        // ── Butonlar ─────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              // Nizanim (Bilmiyorum)
              Expanded(
                child: _ReviewButton(
                  label: 'Nizanim',
                  icon: Icons.close_rounded,
                  color: AppColors.errorSoft,
                  surfaceColor: AppColors.errorSurface,
                  onTap: _onDontKnow,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              // Dizanim (Biliyorum)
              Expanded(
                child: _ReviewButton(
                  label: 'Dizanim',
                  icon: Icons.check_rounded,
                  color: AppColors.success,
                  surfaceColor: AppColors.successSurface,
                  onTap: _onKnow,
                ),
              ),
            ],
          ),
        ),

        // Kart çevir ipucu
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: Text(
            'Kartê çekin ji bo bersivê bibînin',
            style: AppTypography.caption.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  // ── Tekrar Kartı ───────────────────────────────────────────

  Widget _buildCard(_ReviewCardData card, bool showTurkish) {
    return AnimatedBuilder(
      animation: _flipController,
      builder: (context, child) {
        final angle = _flipController.value * 3.14159;
        final isBack = _flipController.value > 0.5;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle),
          child: isBack
              ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(3.14159),
                  child: _buildCardBack(card, showTurkish),
                )
              : _buildCardFront(card),
        );
      },
    );
  }

  Widget _buildCardFront(_ReviewCardData card) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Kategori badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            ),
            child: Text(
              card.category.isNotEmpty ? card.category : 'peyv',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Kurmancî kelime (büyük)
          Text(
            card.kurmanji,
            style: AppTypography.kurmanjiLarge.copyWith(
              fontSize: 36,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppSpacing.lg),

          // Çevir ipucu
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.touch_app_rounded,
                size: 16,
                color: AppColors.textTertiary,
              ),
              const SizedBox(width: 4),
              Text(
                'Bikirtînin ji bo bersivê',
                style: AppTypography.caption,
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          duration: 300.ms,
        );
  }

  Widget _buildCardBack(_ReviewCardData card, bool showTurkish) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        border: Border.all(color: AppColors.primaryLight.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kurmancî kelime
            Center(
              child: Text(
                card.kurmanji,
                style: AppTypography.kurmanjiLarge,
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            // Çeviri
            if (showTurkish) ...[
              Center(
                child: Text(
                  card.turkce,
                  style: AppTypography.title.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 4),
            ],

            if (card.ingilizce.isNotEmpty)
              Center(
                child: Text(
                  card.ingilizce,
                  style: AppTypography.translation,
                  textAlign: TextAlign.center,
                ),
              ),

            const SizedBox(height: AppSpacing.lg),

            // Gramer notu
            if (card.grammarNote != null && card.grammarNote!.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.warningSurface,
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusMd),
                  border: Border.all(
                    color: AppColors.warning.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      size: 18,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        card.grammarNote!,
                        style: AppTypography.body.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],

            // Örnek cümleler
            if (card.exampleSentences.isNotEmpty) ...[
              Text(
                'Mînak:',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              ...card.exampleSentences.take(2).map(
                    (s) => Padding(
                      padding:
                          const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '  ',
                            style: AppTypography.body.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: Text(
                              s,
                              style: AppTypography.body.copyWith(
                                fontStyle: FontStyle.italic,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            ],
          ],
        ),
      ),
    );
  }

  // ── Boş Durum ──────────────────────────────────────────────

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/mascot_128.png',
              width: 100, height: 100,
              filterQuality: FilterQuality.medium),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Peyv ji bo dubareyê tune!',
              style: AppTypography.headline.copyWith(
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Quiz an flashcard bixebitîne da ku peyvên qels werin tomarkirin.',
              style: AppTypography.body.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            OutlinedButton.icon(
              onPressed: () { if (context.canPop()) context.pop(); else context.go(AppRoutes.home); },
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text('Vegere'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                padding: AppSpacing.buttonPadding,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusMd),
                ),
              ),
            ),
          ],
        ).animate().fadeIn(duration: 400.ms),
      ),
    );
  }

  // ── Tamamlanma Ekranı ──────────────────────────────────────

  Widget _buildCompletionScreen() {
    // Kartlar hiç yüklenmemişse (boş liste) boş durum göster
    if (_reviewCards.isEmpty && _knewCount == 0 && _didntKnowCount == 0) {
      return _buildEmptyState();
    }

    final total = _knewCount + _didntKnowCount;
    final percentage = total > 0 ? (_knewCount / total * 100).round() : 0;
    final reviewState = ref.watch(reviewProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xl),

          // Kutlama ikonu
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.celebration_rounded,
              size: 48,
              color: AppColors.primary,
            ),
          ).animate().scale(
                begin: const Offset(0, 0),
                end: const Offset(1, 1),
                duration: 500.ms,
                curve: Curves.elasticOut,
              ),

          const SizedBox(height: AppSpacing.lg),

          Text(
            'Dubare temam!',
            style: AppTypography.headline.copyWith(
              color: AppColors.textPrimary,
            ),
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: AppSpacing.sm),

          Text(
            'Te $total peyv dubare kir',
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
            ),
          ).animate().fadeIn(delay: 300.ms),

          const SizedBox(height: AppSpacing.xl),

          // İstatistikler
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Column(
              children: [
                // Doğruluk yüzdesi
                _StatRow(
                  icon: Icons.analytics_rounded,
                  label: 'Rastbûn',
                  value: '%$percentage',
                  color: percentage >= 70
                      ? AppColors.success
                      : AppColors.accent,
                ),

                const Divider(height: AppSpacing.lg),

                // Bilinen
                _StatRow(
                  icon: Icons.check_circle_rounded,
                  label: 'Dizanim',
                  value: '$_knewCount',
                  color: AppColors.success,
                ),

                const Divider(height: AppSpacing.lg),

                // Bilinmeyen
                _StatRow(
                  icon: Icons.cancel_rounded,
                  label: 'Nizanim',
                  value: '$_didntKnowCount',
                  color: AppColors.errorSoft,
                ),

                const Divider(height: AppSpacing.lg),

                // Kalan zayıf kelimeler
                _StatRow(
                  icon: Icons.replay_rounded,
                  label: 'Peyvên mane',
                  value: '${reviewState.dueCount}',
                  color: AppColors.primary,
                ),
              ],
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),

          const SizedBox(height: AppSpacing.lg),

          // Mastery ilerleme çubuğu
          if (reviewState.masteredCount > 0 ||
              reviewState.dueCount > 0) ...[
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.successSurface,
                borderRadius:
                    BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(
                  color: AppColors.success.withOpacity(0.2),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Serfirazbûn',
                        style: AppTypography.label.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                      Text(
                        '${reviewState.masteredCount} peyv',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ClipRRect(
                    borderRadius: AppRadius.full,
                    child: LinearProgressIndicator(
                      value: _masteryProgress(reviewState),
                      minHeight: 8,
                      backgroundColor:
                          AppColors.success.withOpacity(0.15),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.success),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 500.ms),
            const SizedBox(height: AppSpacing.lg),
          ],

          // Butonlar
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () { if (context.canPop()) context.pop(); else context.go(AppRoutes.home); },
                  icon: const Icon(Icons.home_rounded),
                  label: const Text('Mal'),
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
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _restartSession,
                  icon: const Icon(Icons.replay_rounded),
                  label: const Text('Dîsa bike'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(delay: 600.ms),
        ],
      ),
    );
  }

  double _masteryProgress(ReviewState state) {
    final total = state.masteredCount + state.dueCount;
    if (total == 0) return 0;
    return state.masteredCount / total;
  }

  void _restartSession() {
    setState(() {
      _currentIndex = 0;
      _knewCount = 0;
      _didntKnowCount = 0;
      _sessionComplete = false;
      _isFlipped = false;
      _flipController.value = 0;
    });
    _loadReviewCards();
  }
}

// ════════════════════════════════════════════════════════════════
// YARDIMCI WİDGET'LAR
// ════════════════════════════════════════════════════════════════

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
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Text(
            '$count',
            style: AppTypography.label.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _ReviewButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color surfaceColor;
  final VoidCallback onTap;

  const _ReviewButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.surfaceColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: surfaceColor,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTypography.labelLarge.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            label,
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: AppTypography.title.copyWith(color: color),
        ),
      ],
    );
  }
}
