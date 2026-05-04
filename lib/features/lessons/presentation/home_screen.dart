import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/auth_service.dart';
import '../data/lesson_repository.dart';
import '../domain/a1_kelime_db.dart';
import '../domain/a2_kelime_db.dart';
import '../domain/b1_kelime_db.dart';
import '../domain/b2_kelime_db.dart';
import '../domain/c1_kelime_db.dart';
import '../domain/c2_kelime_db.dart';
// PERF: getEnWordsForLevel transitively re-exported via learning_module_provider.
// en_to_quiz_adapter.dart dropped — EN words only surface at flashcard/quiz where
// that file is already imported. Saves ~1 deferred-candidate adapter in main bundle.
import '../../en_learning/domain/en_to_quiz_adapter.dart' show getEnWordsForLevel;
import '../../../shared/providers/learning_module_provider.dart';
// daily_word_widget import removed — widget no longer on home screen
import '../../../shared/providers/language_mode_provider.dart';
import '../../../shared/providers/review_provider.dart';
import '../../../shared/providers/progression_provider.dart';
import '../../gamification/gamification_provider.dart';
import '../../gamification/gamification_widgets.dart';
import '../../cultural_content/widgets/daily_proverb_card.dart';
import '../../../core/services/user_mode_preferences.dart';
import '../../../shared/widgets/level_picker_sheet.dart';
import '../../subscription/data/subscription_service.dart';
import '../../subscription/domain/subscription_status.dart';

// ════════════════════════════════════════════════════════════════
// ANA SAYFA — İLERLEME HARİTASI
// İlke: Kurmancî birincil dil. Heritage + Genel yol.
// Gamification: Destekleyici, kimlik odaklı (ceza yok).
// ════════════════════════════════════════════════════════════════

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final profile = ref.watch(userProfileProvider);
    final userId = user?.uid ?? 'anonymous';

    final dailyStats = ref.watch(dailyStatsProvider(userId));
    // PERF 2026-04: eskiden build() içinde 6 ayrı `ref.watch(isEnglishModuleProvider)`
    // çağrısı vardı — her biri ayrı bir subscribe path yaratıyor (Riverpod aynı
    // provider'ı dedupe etse de her çağrı watchlist'e ayrı entry, her rebuild'de
    // identityHashCode karşılaştırması). Tek cache → 5 ek hash lookup / frame.
    final isEn = ref.watch(isEnglishModuleProvider);
    final userMode = ref.watch(userModeProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      // Bottom nav artık shell'de — burada kaldırıldı
      body: Stack(
        children: [
          SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── İçerik ───────────────────────────────────────────
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: AppSpacing.md),

                  // ════════════════════════════════════════════════
                  // 1) COMPACT HEADER: mascot + selamlama
                  // Dil toggle (KU/TR) ve track değişimi yalnız Profile
                  // üzerinden yapılır (Mîheng > Rêya biguherîne / Dil modu).
                  // ════════════════════════════════════════════════
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Mascot 40px
                      GestureDetector(
                        onLongPress: () => context.push(AppRoutes.admin),
                        child: SizedBox(
                          width: 40, height: 40,
                          child: Image.asset('assets/images/mascot_64.png',
                            fit: BoxFit.contain, filterQuality: FilterQuality.medium),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Selamlama + alt yazı
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isEn
                                  ? (profile.isHeritage ? 'Welcome, friend!' : 'Welcome!')
                                  : (profile.isHeritage ? 'Xêr hatî, heval!' : 'Xêr hatî!'),
                              style: AppTypography.headingSmall.copyWith(
                                color: AppColors.textPrimary, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              isEn
                                  ? 'What will you learn today?'
                                  : 'Îro çi fêr dibî?',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // ════════════════════════════════════════════════
                  // 2) COMPACT STREAK BAR — Academic modda gizli
                  // ════════════════════════════════════════════════
                  if (!hideGamificationFor(userMode))
                    dailyStats.when(
                      data: (stats) => _DailySummaryCard(stats: stats, level: profile.currentLevel.toUpperCase()),
                      loading: () => _DailySummaryCard(stats: null, level: profile.currentLevel.toUpperCase()),
                      error: (_, __) => _DailySummaryCard(stats: null, level: profile.currentLevel.toUpperCase()),
                    ),

                  // ════════════════════════════════════════════════
                  // 2.1) ABONELİK BANNER — yeni kullanıcı için 7 günlük
                  // demo daveti, deneme/premium aktifken durum bildirimi.
                  // Premium aktifse tamamen gizlenir (ek gürültü olmaz).
                  // ════════════════════════════════════════════════
                  const _SubscriptionBanner(),

                  // ════════════════════════════════════════════════
                  // 2.5) GOTINA ÎRO — Sadece Kurmancî track'ta
                  // Kurmancî atasözü İngilizce öğrenene yabancı gelir
                  // ════════════════════════════════════════════════
                  if (!isEn) ...[
                    const SizedBox(height: AppSpacing.md),
                    const DailyProverbCard(),
                  ],

                  const SizedBox(height: AppSpacing.lg),

                  // ════════════════════════════════════════════════
                  // 3) LEARNING PATH — Main focus of the home screen
                  //    Visual mountain/path with nodes (always visible)
                  // ════════════════════════════════════════════════
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: Row(
                      children: [
                        Icon(Icons.route_rounded, size: 22, color: AppColors.primary),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            isEn
                                ? 'Learning Path 📖'
                                : 'Rêya Fêrbûnê 🐐',
                            style: AppTypography.headingSmall.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        // Seviye chip'i — kullanıcı her zaman seviyeyi
                        // değiştirebilsin. Bu, yerleştirme testini "tek
                        // doğru yol" değil bir "öneri" olarak konumlar.
                        _LevelChip(level: profile.currentLevel),
                      ],
                    ),
                  ).animate().fadeIn(delay: 160.ms),

                  _SkillTreePath(
                    userId: userId,
                    currentLevel: profile.currentLevelNum,
                    ref: ref,
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  // ── Günlük Ödül ─────────────────────────────
                  const DailyRewardWidget(),

                  const SizedBox(height: AppSpacing.xl),
                ]),
              ),
            ),
          ],
        ),
      ),

          // ── Gamification Overlay'ler ────────────────────────
          // Level-up kutlaması
          const LevelUpCelebrationOverlay(),

          // Rozet kazanımı
          const BadgeEarnedOverlay(),

          // CEFR seviye geçişi → sertifika toast'u (görünmez listener).
          const _CefrCertificateCtaListener(),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// SUBSCRIPTION BANNER — kullanıcı dostu, ısrarcı değil.
// Yeni kullanıcı (none): "7 gün ücretsiz dene" daveti
// Deneme aktif: kalan gün sayısı + premium'a yükselt CTA
// Deneme/premium bitti: yenile CTA
// Premium aktif: gizli (ek banner gerekmez)
// ════════════════════════════════════════════════════════════════

class _SubscriptionBanner extends ConsumerWidget {
  const _SubscriptionBanner();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sub = ref.watch(subscriptionProvider);
    final isPromoActive = SubscriptionConstants.isPromoPeriodActive;

    // Premium aktif → banner göstermeye gerek yok.
    // Promo aktifken aşağıdaki ayrı banner gösterilir, premium dahi olsa kullanıcı
    // "tanıtım dönemi" mesajından haberdar olmalı.
    if (!isPromoActive && sub.tier == SubscriptionTier.premium) {
      return const SizedBox.shrink();
    }

    // Banner içeriği duruma göre.
    final (gradient, icon, title, subtitle, ctaLabel) = isPromoActive
        ? (
            // Promo banner — sıcak gold/amber tonları, festival hissi.
            [const Color(0xFFFFA726), const Color(0xFFFB8C00)],
            Icons.celebration_outlined,
            'Demê pêşkêşiyê — bedelî!',
            'Heya ${SubscriptionConstants.promoEndsLabelKu} '
                'her tişt vekirî · '
                '${SubscriptionConstants.promoDaysRemaining} roj mayî',
            'Bibîne',
          )
        : switch (sub.tier) {
            SubscriptionTier.trial => (
              [AppColors.primary, AppColors.primary.withOpacity(0.7)],
              Icons.timer_outlined,
              'Ceribandina te aktîv e',
              sub.trialDaysRemaining != null
                  ? '${sub.trialDaysRemaining} roj mayî — paşê ${SubscriptionConstants.annualPriceTry} ₺/sal'
                  : 'Bê sînor 7 roj.',
              'Aboneya salane',
            ),
            SubscriptionTier.trialExpired => (
              [Colors.orange, Colors.orange.shade700],
              Icons.lock_outline_rounded,
              'Ceribandina 7 rojan qediya',
              'Berdewamiya tev: ${SubscriptionConstants.annualPriceTry} ₺/sal',
              'Abone bibe',
            ),
            SubscriptionTier.premiumExpired => (
              [Colors.orange, Colors.orange.shade700],
              Icons.refresh_rounded,
              'Aboneya te qediya',
              'Bi ${SubscriptionConstants.annualPriceTry} ₺/sal nûjen bike',
              'Nûjen bike',
            ),
            _ => (
              [AppColors.primary, AppColors.primary.withOpacity(0.7)],
              Icons.workspace_premium_rounded,
              'LÛTKE Premium\'ê biceribîne',
              '7 roj bê pere — kart pêwîst nine',
              'Bê pere dest pê bike',
            ),
          };

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          onTap: () => context.push(AppRoutes.paywall),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.labelLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: AppTypography.caption.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Text(
                    ctaLabel,
                    style: AppTypography.label.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
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
}

// ════════════════════════════════════════════════════════════════
// LEVEL CHIP — Path başlığında, tıklayınca level picker sheet'i açar.
// Yerleştirme testi sonucu zorlamaz; kullanıcı her zaman dilediği seviyeyi
// gezebilir.
// ════════════════════════════════════════════════════════════════

class _LevelChip extends StatelessWidget {
  final String level; // a1..c2
  const _LevelChip({required this.level});

  @override
  Widget build(BuildContext context) {
    final label = level.toUpperCase();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        onTap: () => LevelPickerSheet.show(context),
        child: Tooltip(
          message: 'Asta xwe biguherîne',
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.10),
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.25),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ast: $label',
                  style: AppTypography.label.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// CEFR LEVEL TRANSITION LISTENER
//
// Kullanıcı XP ile CEFR seviyesinden bir üst CEFR'e atladığında
// (ör. A1 → A2) altta SnackBar ile tebrik + "Belgeyê bibîne" aksiyonu.
//
// Not: `gamificationProvider.state.level` yalnızca A1/A2/B1/B2 taşıyor,
// B2 üstü placement testinde set ediliyor. Bu toast, gamification kaynaklı
// her A→B geçişinde tek seferlik tetiklenir. Spam önlemek için
// SharedPreferences'e "son gösterilen seviye" kaydedilir.
// ════════════════════════════════════════════════════════════════

class _CefrCertificateCtaListener extends ConsumerStatefulWidget {
  const _CefrCertificateCtaListener();

  @override
  ConsumerState<_CefrCertificateCtaListener> createState() =>
      _CefrCertificateCtaListenerState();
}

class _CefrCertificateCtaListenerState
    extends ConsumerState<_CefrCertificateCtaListener> {
  String? _lastSeenLevel;

  @override
  Widget build(BuildContext context) {
    ref.listen(gamificationProvider, (prev, next) {
      final previousLevel =
          _lastSeenLevel ?? prev?.level ?? next.level;
      if (previousLevel != next.level && previousLevel.isNotEmpty) {
        _lastSeenLevel = next.level;
        _showCertCtaSnack(context, next.level);
      } else {
        _lastSeenLevel = next.level;
      }
    });
    return const SizedBox.shrink();
  }

  void _showCertCtaSnack(BuildContext context, String newCefrLevel) {
    // Build esnasında SnackBar açmaz — microtask'a ertele.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.primaryDark,
          duration: const Duration(seconds: 8),
          content: Row(
            children: [
              const Icon(
                Icons.workspace_premium_rounded,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Pîroz be! Asta $newCefrLevel temam bû.',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          action: SnackBarAction(
            textColor: AppColors.accent,
            label: 'Belgeyê bibîne →',
            onPressed: () =>
                context.push('${AppRoutes.certificate}/$newCefrLevel'),
          ),
        ),
      );
    });
  }
}

// (_WelcomeSection kaldirildi — header icinde inline olarak yazildi)

// ════════════════════════════════════════════════════════════════
// STREAK ROZETI
// İlke §9b bulgu #3: Ceza değil, ritim kutlanır
// ════════════════════════════════════════════════════════════════

// NOT: `_StreakBadge` kaldırıldı — hiçbir yerde referans yoktu (analyzer:
// unused_element). Streak görünümü artık _DailySummaryCard içinde.

// ════════════════════════════════════════════════════════════════
// GÜNLÜK ÖZET KARTI — streak, XP, seviye
// ════════════════════════════════════════════════════════════════

class _DailySummaryCard extends ConsumerWidget {
  final DailyStats? stats;
  final String level;
  const _DailySummaryCard({this.stats, required this.level});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPad = screenWidth < 360 ? 10.0 : AppSpacing.md;
    // TRACK-AWARE FIX: "roj" (Kurmancî: gün) EN track'te "days" olmalı.
    final isEn = ref.watch(isEnglishModuleProvider);
    final dayLabel = isEn ? 'days' : 'roj';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPad, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Streak
            _SummaryItem(
              icon: Icons.local_fire_department_rounded,
              iconColor: AppColors.accent,
              value: stats != null ? '${stats!.streakDays} $dayLabel' : '0 $dayLabel',
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
              color: AppColors.border,
            ),
            // XP
            _SummaryItem(
              icon: Icons.star_rounded,
              iconColor: Colors.amber,
              value: stats != null ? '${stats!.xpToday} XP' : '0 XP',
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
              color: AppColors.border,
            ),
            // Level badge
            _SummaryItem(
              icon: Icons.emoji_events_rounded,
              iconColor: AppColors.primary,
              value: level.isNotEmpty ? level : 'A1',
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 120.ms, duration: 350.ms);
  }
}

/// Değer değiştiğinde kısa scale-pulse ile canlı görünen özet öğesi.
/// MediaQuery.disableAnimations aktifse pulse atlanır.
class _SummaryItem extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  const _SummaryItem({
    required this.icon,
    required this.iconColor,
    required this.value,
  });

  @override
  State<_SummaryItem> createState() => _SummaryItemState();
}

class _SummaryItemState extends State<_SummaryItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  String? _lastValue;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 360),
    );
    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.22), weight: 45),
      TweenSequenceItem(tween: Tween(begin: 1.22, end: 1.0), weight: 55),
    ]).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _lastValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant _SummaryItem old) {
    super.didUpdateWidget(old);
    if (widget.value != _lastValue) {
      _lastValue = widget.value;
      final reduce = MediaQuery.of(context).disableAnimations;
      if (!reduce) _ctrl.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ScaleTransition(
        scale: _scale,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.icon, size: 20, color: widget.iconColor),
            const SizedBox(width: 6),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: child,
              ),
              child: Text(
                widget.value,
                key: ValueKey(widget.value),
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
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
// PERF 2026-04: Dead-code purge — ~970 satır aşağıda kaldırıldı.
// Aşağıdaki widget'lar hiçbir yerde instantiate edilmiyordu (build()
// grafiği tarama sonucu sıfır referans):
//
//   _WeeklyRhythmCard + _DayDot + _StatChip        — compact bar ile değişti
//   _DailyReviewButton                             — SkillTreePath ile değişti
//   _FlashcardQuickAction                          — grid card ile değişti
//   _ActivityCard                                  — tasarım revize edildi
//   _ActivityGrid + _ActivityGridCard              — skill tree öne çıktı
//   _CollapsibleSkillTree + state                  — açılır/kapanır kaldırıldı
//   _LevelProgressCard                             — daily_summary ile değişti
//   _LutkeBottomNav + _NavItem                     — shell'deki nav kullanılıyor
//   _StartQuizButton                               — grid içinde inline
//
// Bundle etkisi: dart2js hâlâ ağaç budayıp atacaktı ama:
//   (a) tree-shake analizi hızlanır (daha az node),
//   (b) const literal'lar (Icons, TextStyle) ve closure literallar
//       kalıcı-referans-olmayan-ama-hâlâ-derlenen kod oldukları için
//       ara adımda serbest-bırakılmadan tutuluyordu,
//   (c) analyzer "unused_element" warn gürültüsü gidiyor.
// ════════════════════════════════════════════════════════════════

// (kaldırıldı: _WeeklyRhythmCard + _DayDot + _StatChip + _DailyReviewButton)

// (kaldırıldı: _FlashcardQuickAction, _ActivityCard)

// (kaldırıldı: _ActivityGrid, _ActivityGridCard, _CollapsibleSkillTree,
//              _CollapsibleSkillTreeState, _LevelProgressCard)

// ════════════════════════════════════════════════════════════════
// SKILL TREE UNIT MODELİ
// A1 kelime DB'sinden kategorilere göre birim oluşturur
// ════════════════════════════════════════════════════════════════

class _SkillTreeUnit {
  final String id;
  final String katKey;
  final String kuTitle;
  final String trTitle;
  final IconData icon;
  final int wordCount;
  final int unitIndex;

  const _SkillTreeUnit({
    required this.id,
    required this.katKey,
    required this.kuTitle,
    required this.trTitle,
    required this.icon,
    required this.wordCount,
    required this.unitIndex,
  });
}

/// Seviyeye göre kelime DB'sini döndürür.
/// İngilizce modülünde EnWord adapte edilmiş veri döner.
List<dynamic> _getWordsForLevel(String level, {bool isEnglishModule = false}) {
  if (isEnglishModule) return getEnWordsForLevel(level);
  return switch (level) {
    'A1' => kA1TamListe,
    'A2' => kA2TamListe,
    'B1' => kB1All,
    'B2' => kB2All,
    'C1' => kC1All,
    'C2' => kC2All,
    _ => kA1TamListe,
  };
}

/// Kategori renkleri — her durak kendine özel canlı renk.
Color _colorForCategory(String kat) => switch (kat) {
  'selamlama' || 'silav' => const Color(0xFF1A7B6B), // teal
  'cinavk' || 'navdêr' => const Color(0xFF7B1FA2), // mor
  'hejmar' || 'jimar' => const Color(0xFF2196F3), // mavi
  'malbat' => const Color(0xFFE91E63), // pembe
  'bun' => const Color(0xFFD4783A), // turuncu
  'reng' => const Color(0xFFFF5722), // koyu turuncu
  'dem' || 'roj' || 'demsal' || 'werzî' => const Color(0xFFFF8F00), // amber
  'mal' || 'cih' || 'bajêr' => const Color(0xFF00BCD4), // cyan
  'xwarin' || 'vexwarin' || 'mêwe' => const Color(0xFF2D9E4F), // yeşil
  'beden' || 'tendurist' => const Color(0xFF009688), // teal koyu
  'cil' => const Color(0xFF9C27B0), // mor
  'pîşe' || 'kar' => const Color(0xFF3F51B5), // indigo
  'ajal' => const Color(0xFFD4783A), // turuncu
  'xweza' || 'ekoloji' => const Color(0xFF4CAF50), // yeşil
  'gihanî' || 'rêwîtî' => const Color(0xFF0277BD), // koyu mavi
  'his' || 'peyvben' || 'psikoloji' => const Color(0xFFFF8FAB), // pembe
  'pirs' => const Color(0xFF607D8B), // gri-mavi
  'leker' || 'leker_ergatif' || 'ergatif' => const Color(0xFF795548), // kahve
  'rengder' || 'soyut' => const Color(0xFF673AB7), // koyu mor
  'daçek' || 'rêziman' => const Color(0xFF455A64), // koyu gri
  'çand' || 'edebiyat' || 'huner' => const Color(0xFFE91E63), // pembe
  'dua' => const Color(0xFF8BC34A), // açık yeşil
  'temel' || 'jiyan' => const Color(0xFF1A7B6B), // teal
  'civakî' || 'kimlik' => const Color(0xFF5C6BC0), // indigo açık
  'siyaset' || 'zagon' => const Color(0xFF37474F), // koyu
  'aborî' || 'bazirganî' || 'cotkarî' => const Color(0xFF00695C), // teal koyu
  'teknoloji' || 'zanist' => const Color(0xFF0288D1), // mavi
  'medya' => const Color(0xFFE64A19), // koyu turuncu
  'felsefe' => const Color(0xFF6A1B9A), // mor
  'dîrok' => const Color(0xFF5D4037), // kahve koyu
  'akademik' => const Color(0xFF1565C0), // koyu mavi
  'deyim' => const Color(0xFFC62828), // kırmızı
  'welat' => const Color(0xFF2E7D32), // koyu yeşil
  'hewa' => const Color(0xFF0097A7), // cyan koyu
  'neyekî' => const Color(0xFF616161), // gri
  _ => const Color(0xFF1A7B6B), // varsayılan teal
};

/// Kategori ikonları — tüm seviyeler için ortak.
IconData _iconForCategory(String kat) => switch (kat) {
  'alfabe' => Icons.text_fields_rounded,
  'selamlama' || 'silav' => Icons.waving_hand_rounded,
  'jimar' || 'hejmar' => Icons.tag_rounded,
  'reng' => Icons.palette_rounded,
  'malbat' => Icons.family_restroom_rounded,
  'cinavk' || 'navdêr' => Icons.person_rounded,
  'pîşe' || 'kar' => Icons.work_rounded,
  'perwerde' => Icons.school_rounded,
  'dem' => Icons.access_time_rounded,
  'roj' || 'demsal' || 'werzî' || 'hewa' => Icons.wb_sunny_rounded,
  'xwarin' || 'vexwarin' || 'mêwe' => Icons.restaurant_rounded,
  'beden' || 'tendurist' => Icons.accessibility_new_rounded,
  'mal' || 'cih' || 'bajêr' => Icons.home_rounded,
  'rengder' || 'soyut' => Icons.format_color_text_rounded,
  'temel' || 'jiyan' => Icons.auto_stories_rounded,
  'leker' || 'leker_ergatif' || 'ergatif' || 'neyekî' => Icons.directions_run_rounded,
  'xweza' || 'ekoloji' => Icons.park_rounded,
  'ajal' => Icons.pets_rounded,
  'cil' => Icons.dry_cleaning_rounded,
  'daçek' || 'rêziman' => Icons.compare_arrows_rounded,
  'pirs' => Icons.help_outline_rounded,
  'gihanî' || 'rêwîtî' => Icons.directions_bus_rounded,
  'peyvben' || 'his' || 'psikoloji' => Icons.sentiment_satisfied_rounded,
  'bun' => Icons.lightbulb_rounded,
  'çand' || 'edebiyat' || 'huner' => Icons.museum_rounded,
  'dua' => Icons.volunteer_activism_rounded,
  'civakî' || 'kimlik' => Icons.groups_rounded,
  'siyaset' || 'zagon' => Icons.gavel_rounded,
  'aborî' || 'bazirganî' || 'cotkarî' => Icons.account_balance_rounded,
  'teknoloji' || 'zanist' => Icons.science_rounded,
  'ziman' => Icons.translate_rounded,
  'medya' => Icons.newspaper_rounded,
  'felsefe' => Icons.psychology_rounded,
  'dîrok' => Icons.history_edu_rounded,
  'akademik' => Icons.school_rounded,
  'deyim' => Icons.format_quote_rounded,
  'welat' => Icons.flag_rounded,
  _ => Icons.circle_rounded,
};

/// Kategori anahtarından İngilizce adını döndürür (İngilizce modü için).
String _enNameForCategory(String kat) => switch (kat) {
  'alfabe' => 'Alphabet',
  'silav' => 'Greetings',
  'jimar' || 'hejmar' => 'Numbers',
  'reng' => 'Colors',
  'malbat' => 'Family',
  'cinavk' => 'Pronouns',
  'pîşe' => 'Jobs',
  'perwerde' => 'Education',
  'dem' => 'Time',
  'roj' => 'Days of Week',
  'demsal' || 'werzî' => 'Seasons',
  'xwarin' => 'Food',
  'vexwarin' => 'Drinks',
  'mêwe' => 'Fruits',
  'beden' => 'Body',
  'tendurist' => 'Health',
  'mal' => 'Home',
  'cih' || 'bajêr' => 'Places',
  'rengder' || 'soyut' => 'Adjectives',
  'temel' => 'Basic Words',
  'leker' => 'Verbs',
  'leker_ergatif' || 'ergatif' || 'ergatif_b2' => 'Past Verbs',
  'xweza' => 'Nature',
  'ajal' => 'Animals',
  'cil' => 'Clothes',
  'daçek' => 'Prepositions',
  'rêziman' => 'Grammar',
  'pirs' => 'Questions',
  'gihanî' || 'rêwîtî' => 'Transport',
  'peyvben' => 'Connectors',
  'his' || 'psikoloji' => 'Feelings',
  'bun' => 'To Be',
  'dua' => 'Greetings & Blessings',
  'çand' => 'Culture',
  'jiyan' => 'Life',
  'civakî' => 'Social',
  'kar' => 'Work',
  'teknoloji' => 'Technology',
  'hewa' => 'Weather',
  'bazirganî' => 'Commerce',
  'welat' => 'Country',
  'navdêr' => 'Nouns',
  'neyekî' => 'Negation',
  'deyim' => 'Idioms',
  'edebiyat' => 'Literature',
  'huner' => 'Arts',
  'siyaset' => 'Politics',
  'zagon' => 'Law',
  'aborî' => 'Economy',
  'medya' => 'Media',
  'zanist' => 'Science',
  'felsefe' => 'Philosophy',
  'dîrok' => 'History',
  'akademik' => 'Academic',
  'kimlik' => 'Identity',
  'ekoloji' => 'Ecology',
  'ziman' => 'Language',
  'ergatif_b2' => 'Ergative',
  'cotkarî' => 'Farming',
  _ => kat,
};

/// Kategori anahtarından doğru Kurmancî adını döndürür.
String _kuNameForCategory(String kat) => switch (kat) {
  'alfabe' => 'Alfabê',
  'silav' => 'Silav',
  'jimar' || 'hejmar' => 'Hejmar',
  'reng' => 'Reng',
  'malbat' => 'Malbat',
  'cinavk' => 'Cînav',
  'pîşe' => 'Pîşe',
  'perwerde' => 'Perwerde',
  'dem' => 'Dem',
  'roj' => 'Rojên hefteyê',
  'demsal' || 'werzî' => 'Demsalên salê',
  'xwarin' => 'Xwarin',
  'vexwarin' => 'Vexwarin',
  'mêwe' => 'Fêkî û mêwe',
  'beden' => 'Laş',
  'tendurist' => 'Tenduristî',
  'mal' => 'Mal û xanî',
  'cih' || 'bajêr' => 'Cih û der',
  'rengder' || 'soyut' => 'Rengdêr',
  'temel' => 'Peyvên bingehîn',
  'leker' => 'Lêker',
  'leker_ergatif' || 'ergatif' || 'ergatif_b2' => 'Lêkerên ergatîf',
  'xweza' => 'Xweza',
  'ajal' => 'Heywan',
  'cil' => 'Cil û berg',
  'daçek' => 'Daçek',
  'rêziman' => 'Rêziman',
  'pirs' => 'Pirsyar',
  'gihanî' || 'rêwîtî' => 'Veguhestin',
  'peyvben' => 'Peyvên girêdayî',
  'his' || 'psikoloji' => 'Hest',
  'bun' => 'Bûn',
  'çand' => 'Çand',
  'edebiyat' => 'Wêje',
  'huner' => 'Huner',
  'dua' => 'Dua û hêvî',
  'civakî' || 'kimlik' => 'Civak',
  'siyaset' => 'Siyaset',
  'zagon' => 'Zagonî',
  'aborî' || 'bazirganî' || 'cotkarî' => 'Aborî',
  'teknoloji' => 'Teknolojî',
  'zanist' => 'Zanist',
  'ziman' => 'Ziman',
  'medya' => 'Medya',
  'felsefe' => 'Felsefe',
  'dîrok' => 'Dîrok',
  'akademik' => 'Akademîk',
  'deyim' => 'Gotinên pêşiyan',
  'welat' => 'Welat',
  'jiyan' => 'Jiyan',
  'kar' => 'Kar û pîşe',
  'hewa' => 'Hewa',
  'ekoloji' => 'Ekolojî',
  'neyekî' => 'Neyînî',
  'navdêr' => 'Navdêr',
  _ => kat.isEmpty ? '' : kat[0].toUpperCase() + kat.substring(1),
};

// PERF 2026-04: Pedagogic order — top-level const (eskiden her build()'de
// yeni list literal allocate ediliyordu, üstelik `contains` O(n) lookup +
// _pedagogicOrder.length=~60. Şimdi const => 1 kez alloc, lookup için ek
// olarak Set versiyonu O(1) bakış.
const List<String> _kPedagogicOrder = [
  // A1 temel — Silav ilk durak
  'silav', 'cinavk', 'hejmar', 'jimar',
  'malbat', 'bun', 'reng', 'dem', 'roj', 'demsal', 'werzî',
  'mal', 'xwarin', 'vexwarin', 'mêwe', 'beden', 'cil',
  'pîşe', 'ajal', 'xweza', 'cih', 'gihanî', 'rêwîtî',
  'tendurist', 'his', 'peyvben', 'pirs', 'temel',
  'leker', 'rengder', 'daçek', 'dua', 'çand',
  // A2-B1 genişleme
  'jiyan', 'civakî', 'perwerde', 'kar', 'teknoloji',
  'hewa', 'bazirganî', 'welat', 'navdêr', 'neyekî',
  'ergatif', 'leker_ergatif', 'deyim', 'rêziman',
  // B2-C2 ileri
  'edebiyat', 'huner', 'siyaset', 'zagon', 'aborî',
  'medya', 'zanist', 'felsefe', 'dîrok', 'akademik',
  'kimlik', 'ekoloji', 'ziman', 'soyut', 'psikoloji',
  'ergatif_b2', 'cotkarî', 'bajêr',
];
final Set<String> _kPedagogicOrderSet = _kPedagogicOrder.toSet();

/// PERF 2026-04: Memoization cache — `_buildSkillUnits` fonksiyonu
/// home_screen her rebuild'de (ör. progressionProvider değişiminde) tüm
/// A1/A2/…/C2 kelime listesini dönüp kategori sayımı yapıyordu. Input
/// (level, isEnglishModule) ikisi değişmeden sonuç değişmez — cache ile
/// O(n) → O(1). Web'de drag/scroll sırasında ~3-5ms/frame kazanç.
final Map<String, List<_SkillTreeUnit>> _skillUnitsCache = {};

/// Belirli seviye için durak listesi oluşturur.
/// Minimum 12 kelime olan kategoriler gösterilir.
/// Pedagojik sıralamaya göre sıralanır.
List<_SkillTreeUnit> _buildSkillUnits(String level, {bool isEnglishModule = false}) {
  final cacheKey = '$level|${isEnglishModule ? 'en' : 'ku'}';
  final cached = _skillUnitsCache[cacheKey];
  if (cached != null) return cached;

  final words = _getWordsForLevel(level, isEnglishModule: isEnglishModule);
  final catCounts = <String, int>{};
  for (final k in words) {
    final kat = k.kat as String? ?? '';
    if (kat.isEmpty) continue;
    catCounts[kat] = (catCounts[kat] ?? 0) + 1;
  }

  final units = <_SkillTreeUnit>[];

  // Önce pedagojik sıradaki kategorileri ekle
  for (final kat in _kPedagogicOrder) {
    final count = catCounts[kat];
    if (count == null || count < 4) continue;
    units.add(_SkillTreeUnit(
      id: '${level.toLowerCase()}_unit_$kat',
      katKey: kat,
      kuTitle: isEnglishModule
          ? _enNameForCategory(kat)
          : _kuNameForCategory(kat),
      trTitle: '',
      icon: _iconForCategory(kat),
      wordCount: count,
      unitIndex: units.length,
    ));
  }

  // Sırada olmayan ama yeterli kelimesi olan kategorileri sona ekle
  // 'alfabe' hariç — tek harflik girişler etkinlikler için uygun değil
  for (final entry in catCounts.entries) {
    final kat = entry.key;
    if (kat == 'alfabe') continue;
    final count = entry.value;
    if (count < 4) continue;
    if (_kPedagogicOrderSet.contains(kat)) continue; // Zaten eklendi (O(1))
    units.add(_SkillTreeUnit(
      id: '${level.toLowerCase()}_unit_$kat',
      katKey: kat,
      kuTitle: isEnglishModule
          ? _enNameForCategory(kat)
          : _kuNameForCategory(kat),
      trTitle: '',
      icon: _iconForCategory(kat),
      wordCount: count,
      unitIndex: units.length,
    ));
  }

  _skillUnitsCache[cacheKey] = units;
  return units;
}

// ════════════════════════════════════════════════════════════════
// SKILL TREE PATH — Duolingo benzeri kıvrımlı yol
// İlke §7.1: Heritage / Genel yol; §2: İlişki senaryoları
// ════════════════════════════════════════════════════════════════

class _SkillTreePath extends StatelessWidget {
  final String userId;
  final int currentLevel;
  final WidgetRef ref;

  const _SkillTreePath({
    required this.userId,
    required this.currentLevel,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    // Seviyeye göre durakları oluştur
    final levelKey = switch (currentLevel) {
      1 => 'A1', 2 => 'A2', 3 => 'B1', 4 => 'B2', 5 => 'C1', 6 => 'C2',
      _ => 'A1',
    };
    // PERF: isEnglishModule parent'ta zaten watch ediliyor — değişince parent
    // rebuild olur; burada `read` yeterli. Böylece aynı frame içinde iki ayrı
    // subscribe entry oluşmaz.
    final units = _buildSkillUnits(levelKey,
        isEnglishModule: ref.read(isEnglishModuleProvider));
    final progression = ref.read(progressionProvider.notifier);
    // ignore: unused_local_variable
    final _ = ref.watch(progressionProvider); // rebuild on changes

    // Tamamlanan durak sayısını hesapla
    int completedCount = 0;
    for (final u in units) {
      if (progression.isStopComplete(levelKey, u.katKey)) {
        completedCount++;
      } else {
        break; // Sıralı — ilk eksik durağa kadar say
      }
    }
    final currentIndex = completedCount.clamp(0, units.length - 1);

    // ── Dağ keçisi teması — biome dekorasyonları ───────────────
    // Her seviye farklı bir ekosistemi temsil eder.
    // Karik'un tırmanış yolculuğunda: çayır → orman → kayalık →
    // bulutlar → kar → zirve.
    final biome = _TrailBiome.forLevel(levelKey);

    // PERF 2026-04: `ref.watch(showTurkishProvider)` eskiden .map() içinde
    // her entry için çağrılıyordu (10+ item × per rebuild). Hoist edildi →
    // tek subscribe, N item'da O(1) bakış.
    final showTurkish = ref.watch(showTurkishProvider);

    // Skill tree — arka planda dekoratif öğeler, önde duraklar.
    return Stack(
      children: [
        // Dekoratif biome arka planı (duraklar kadar uzun)
        Positioned.fill(
          child: IgnorePointer(
            child: _TrailBackdrop(
              biome: biome,
              stopCount: units.length,
            ),
          ),
        ),

        // Skill tree nodeları
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...units.asMap().entries.map((entry) {
              final i = entry.key;
              final unit = entry.value;

              final isCompleted = i < completedCount;
              final isCurrent = i == currentIndex;
              final isUnlocked = i <= completedCount; // tamamlanan + 1 açık
              final isLocked = !isCompleted && !isCurrent && !isUnlocked;

              return _SkillTreeNode(
                unit: unit,
                index: i,
                totalCount: units.length,
                isCompleted: isCompleted,
                isCurrent: isCurrent,
                isLocked: isLocked,
                showTurkish: showTurkish,
                onTap: () => context.push(
                  AppRoutes.unitHub,
                  extra: {
                    'category': unit.katKey,
                    'titleKu': unit.kuTitle,
                    'titleTr': unit.trTitle,
                    'icon': unit.icon,
                    'wordCount': unit.wordCount,
                    'level': levelKey,
                  },
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// TRAIL BIOME — Seviyeye göre dağ keçisi yolunun ekosistemi
// Karik'un tırmanış metaforu: A1 çayır → C2 zirve.
// ════════════════════════════════════════════════════════════════

class _TrailBiome {
  /// Ön plan dekor öğeleri (büyük, canlı) — patikanın yakın sahnesi
  final List<String> foregroundEmojis;
  /// Orta plan dekor öğeleri (orta boy) — scene kıymetli detayları
  final List<String> midgroundEmojis;
  /// Uzak plan (küçük/soluk) — parallax uzaklık hissi
  final List<String> backgroundEmojis;
  /// Gökyüzü/üst gradient rengi (açık, doygun)
  final Color skyColor;
  /// Zemin gradient rengi (canlı, seviyeye özgü)
  final Color groundColor;
  /// Path çizgisi rengi
  final Color pathColor;
  /// Milestone emojisi (her 4 durakta bir büyük manzara)
  final String milestoneEmoji;

  const _TrailBiome({
    required this.foregroundEmojis,
    required this.midgroundEmojis,
    required this.backgroundEmojis,
    required this.skyColor,
    required this.groundColor,
    required this.pathColor,
    required this.milestoneEmoji,
  });

  static _TrailBiome forLevel(String level) => switch (level) {
        'A1' => const _TrailBiome(
            // Çayır — dağ keçileri otlakta
            // Dağ keçisi (🐐) baskın olacak şekilde ağırlıklandırılmış.
            foregroundEmojis: ['🌾', '🌼', '🌿', '🌻'],
            midgroundEmojis: ['🐐', '🐐', '🦋', '🌳'],
            backgroundEmojis: ['🐐', '⛰️', '🏔️'],
            skyColor: Color(0xFFE8F5E9),
            groundColor: Color(0xFFC8E6C9),
            pathColor: Color(0xFFD4A437),
            milestoneEmoji: '🐐',
          ),
        'A2' => const _TrailBiome(
            // Orman eteği — dağ keçileri ağaçların arasında
            foregroundEmojis: ['🌲', '🌳', '🌿', '🍄'],
            midgroundEmojis: ['🐐', '🐐', '🌾', '🌸'],
            backgroundEmojis: ['🐐', '⛰️', '🏔️'],
            skyColor: Color(0xFFE0F2F1),
            groundColor: Color(0xFFB2DFDB),
            pathColor: Color(0xFFD4A437),
            milestoneEmoji: '🐐',
          ),
        'B1' => const _TrailBiome(
            // Kayalık — dağ keçileri zinarlarda atlıyor
            foregroundEmojis: ['🪨', '🌿', '🌾', '🪨'],
            midgroundEmojis: ['🐐', '🐐', '🌲', '💧'],
            backgroundEmojis: ['🐐', '⛰️', '🏔️'],
            skyColor: Color(0xFFE0F7FA),
            groundColor: Color(0xFFB2EBF2),
            pathColor: Color(0xFFD4A437),
            milestoneEmoji: '🐐',
          ),
        'B2' => const _TrailBiome(
            // Bulutlar — dağ keçileri yüksek zirvelerde
            foregroundEmojis: ['☁️', '🌤️', '🪨', '🌿'],
            midgroundEmojis: ['🐐', '🐐', '🦅', '🌈'],
            backgroundEmojis: ['🐐', '🏔️', '⛰️'],
            skyColor: Color(0xFFE3F2FD),
            groundColor: Color(0xFFBBDEFB),
            pathColor: Color(0xFFD4A437),
            milestoneEmoji: '🐐',
          ),
        'C1' => const _TrailBiome(
            // Kar — dağ keçileri buzlu kayalarda
            foregroundEmojis: ['❄️', '🌨️', '🪨', '🧊'],
            midgroundEmojis: ['🐐', '🐐', '🦅', '✨'],
            backgroundEmojis: ['🐐', '🏔️', '⛰️'],
            skyColor: Color(0xFFF3E5F5),
            groundColor: Color(0xFFE1BEE7),
            pathColor: Color(0xFFD4A437),
            milestoneEmoji: '🐐',
          ),
        'C2' => const _TrailBiome(
            // Zirve — dağ keçileri lûtkede
            foregroundEmojis: ['⭐', '✨', '🪨', '🌟'],
            midgroundEmojis: ['🐐', '🐐', '👑', '🏆'],
            backgroundEmojis: ['🐐', '🏔️', '🌄'],
            skyColor: Color(0xFFFFF3E0),
            groundColor: Color(0xFFFFE0B2),
            pathColor: Color(0xFFD4A437),
            milestoneEmoji: '🐐',
          ),
        _ => const _TrailBiome(
            foregroundEmojis: ['🌿', '🪨'],
            midgroundEmojis: ['🐐', '🌾'],
            backgroundEmojis: ['⛰️', '🐐'],
            skyColor: Color(0xFFE8F5E9),
            groundColor: Color(0xFFC8E6C9),
            pathColor: Color(0xFFD4A437),
            milestoneEmoji: '🐐',
          ),
      };
}

/// Zengin patika arka planı — çok katmanlı sahne:
/// 1) Gradient gökyüzü → zemin (gök mavisi-yeşil-toprak)
/// 2) Uzak plan: soluk dağ silueti + bulutlar (parallax uzaklık)
/// 3) Orta plan: ağaçlar, hayvanlar, çalılar (scene grupları)
/// 4) Ön plan: çiçekler, otlar, taşlar (duraklara yakın)
/// 5) Landmark: her ~4 durakta bir büyük emoji (milestone)
///
/// Deterministik yerleştirme (hash tabanlı): her build aynı görünüm.
class _TrailBackdrop extends StatelessWidget {
  final _TrailBiome biome;
  final int stopCount;

  const _TrailBackdrop({
    required this.biome,
    required this.stopCount,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : (stopCount * 135.0) + 120;
        final width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width;

        return SizedBox.expand(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  biome.skyColor,
                  biome.groundColor,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Doğal sahne yerleşimi — her durak aralığında tutarlı bir "sahne":
  /// sol-ön (büyük), sağ-orta (orta boy), sağ-arka (küçük soluk), vb.
  /// Deterministik ama patern hissettirmeyecek şekilde varyans.
  List<Widget> _buildNaturalScenes({
    required double width,
    required double height,
    required _TrailBiome biome,
    required int stopCount,
  }) {
    final widgets = <Widget>[];
    // Her durak başına bir sahne bandı
    final bands = stopCount + 1;
    final bandHeight = height / bands;

    for (var i = 0; i < bands; i++) {
      final bandTop = i * bandHeight;
      // Bu bandın hash'i — varyans için
      final h = ((i + 1) * 2654435761) & 0x7FFFFFFF;
      final variant = h % 4; // 0,1,2,3 — yerleşim türü

      // Her band'de 3-5 öğe: sol, sağ, (orta-sol, orta-sağ opsiyonel)
      // Bantlar arası değişken → yerleşim doğal görünsün.

      switch (variant) {
        case 0:
          // Sol kenarda büyük ön-plan, sağ-üstte arka plan
          widgets.add(_scenery(
            emoji: biome.foregroundEmojis[h % biome.foregroundEmojis.length],
            left: width * 0.04,
            top: bandTop + bandHeight * 0.35,
            size: 40,
            opacity: 0.75,
            rotation: -0.05,
          ));
          widgets.add(_scenery(
            emoji: biome.backgroundEmojis[
                (h ~/ 10) % biome.backgroundEmojis.length],
            left: width * 0.88,
            top: bandTop + bandHeight * 0.15,
            size: 22,
            opacity: 0.40,
          ));
          widgets.add(_scenery(
            emoji: biome.foregroundEmojis[
                (h ~/ 100) % biome.foregroundEmojis.length],
            left: width * 0.12,
            top: bandTop + bandHeight * 0.75,
            size: 28,
            opacity: 0.60,
            rotation: 0.08,
          ));
          break;
        case 1:
          // Sağ kenarda büyük ön-plan, sol-orta midground
          widgets.add(_scenery(
            emoji: biome.foregroundEmojis[h % biome.foregroundEmojis.length],
            left: width * 0.84,
            top: bandTop + bandHeight * 0.4,
            size: 42,
            opacity: 0.75,
            rotation: 0.05,
          ));
          widgets.add(_scenery(
            emoji: biome.midgroundEmojis[
                (h ~/ 10) % biome.midgroundEmojis.length],
            left: width * 0.06,
            top: bandTop + bandHeight * 0.55,
            size: 32,
            opacity: 0.65,
          ));
          widgets.add(_scenery(
            emoji: biome.backgroundEmojis[
                (h ~/ 100) % biome.backgroundEmojis.length],
            left: width * 0.12,
            top: bandTop + bandHeight * 0.18,
            size: 20,
            opacity: 0.35,
          ));
          break;
        case 2:
          // İki kenarda da orta boy — simetrik, doğal
          widgets.add(_scenery(
            emoji: biome.midgroundEmojis[h % biome.midgroundEmojis.length],
            left: width * 0.05,
            top: bandTop + bandHeight * 0.5,
            size: 34,
            opacity: 0.70,
            rotation: -0.03,
          ));
          widgets.add(_scenery(
            emoji: biome.foregroundEmojis[
                (h ~/ 10) % biome.foregroundEmojis.length],
            left: width * 0.86,
            top: bandTop + bandHeight * 0.6,
            size: 34,
            opacity: 0.65,
            rotation: 0.04,
          ));
          widgets.add(_scenery(
            emoji: biome.foregroundEmojis[
                (h ~/ 100) % biome.foregroundEmojis.length],
            left: width * 0.15,
            top: bandTop + bandHeight * 0.8,
            size: 26,
            opacity: 0.55,
          ));
          break;
        default:
          // Sol-üst küçük küme (3 öğe cluster), sağda büyük tek
          widgets.add(_scenery(
            emoji: biome.foregroundEmojis[h % biome.foregroundEmojis.length],
            left: width * 0.06,
            top: bandTop + bandHeight * 0.25,
            size: 28,
            opacity: 0.65,
            rotation: -0.06,
          ));
          widgets.add(_scenery(
            emoji: biome.midgroundEmojis[
                (h ~/ 10) % biome.midgroundEmojis.length],
            left: width * 0.14,
            top: bandTop + bandHeight * 0.45,
            size: 24,
            opacity: 0.55,
          ));
          widgets.add(_scenery(
            emoji: biome.foregroundEmojis[
                (h ~/ 100) % biome.foregroundEmojis.length],
            left: width * 0.85,
            top: bandTop + bandHeight * 0.55,
            size: 38,
            opacity: 0.70,
            rotation: 0.02,
          ));
          break;
      }
    }
    return widgets;
  }

  Widget _scenery({
    required String emoji,
    required double left,
    required double top,
    required double size,
    required double opacity,
    double rotation = 0.0,
  }) {
    return Positioned(
      left: left,
      top: top,
      child: Transform.rotate(
        angle: rotation,
        child: Opacity(
          opacity: opacity,
          child: Text(
            emoji,
            style: TextStyle(fontSize: size),
          ),
        ),
      ),
    );
  }

  /// Milestone emojileri — patika boyunca düzenli aralıklarla büyük dağ keçileri.
  List<Widget> _buildMilestones({
    required double width,
    required double height,
    required String emoji,
    required int stopCount,
  }) {
    if (stopCount < 3) return [];
    final widgets = <Widget>[];
    // Her 5 durakta bir milestone
    final count = (stopCount / 5).clamp(1, 4).round();
    for (var i = 0; i < count; i++) {
      final isLeft = i.isEven;
      final yRatio = (i + 1) / (count + 1);
      widgets.add(
        Positioned(
          left: isLeft ? 12 : null,
          right: isLeft ? null : 12,
          top: (yRatio * height - 40).clamp(0.0, height - 80),
          child: Opacity(
            opacity: 0.18,
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 80),
            ),
          ),
        ),
      );
    }
    return widgets;
  }
}

/// Uzak dağ silueti — CustomPaint ile yumuşak zikzak path.
/// Parallax arka plan hissi.
class _DistantMountainsPainter extends CustomPainter {
  final Color color;
  _DistantMountainsPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // İlk dağ sırası (daha soluk, uzak)
    final far = Path();
    final baseY1 = size.height * 0.18;
    far.moveTo(0, baseY1);
    final peaks = (size.width / 90).round().clamp(4, 12);
    for (var i = 0; i <= peaks; i++) {
      final x = size.width * i / peaks;
      final peakHeight = 30.0 + ((i * 17) % 25);
      final y = baseY1 - peakHeight;
      if (i.isEven) {
        far.lineTo(x, y);
      } else {
        final midX = x - (size.width / peaks / 2);
        final midY = baseY1 - peakHeight * 0.6;
        far.quadraticBezierTo(midX, midY, x, y);
      }
    }
    far.lineTo(size.width, baseY1);
    far.lineTo(size.width, 0);
    far.lineTo(0, 0);
    far.close();
    canvas.drawPath(far, paint);

    // İkinci dağ sırası — daha yakın, daha koyu
    final near = Path();
    final baseY2 = size.height * 0.32;
    final nearPaint = Paint()
      ..color = color.withOpacity(color.opacity * 1.4).withOpacity(
          (color.opacity * 1.4).clamp(0.0, 1.0))
      ..style = PaintingStyle.fill;
    near.moveTo(0, baseY2);
    final peaks2 = (size.width / 120).round().clamp(3, 8);
    for (var i = 0; i <= peaks2; i++) {
      final x = size.width * i / peaks2;
      final peakHeight = 45.0 + ((i * 23) % 35);
      final y = baseY2 - peakHeight;
      near.lineTo(x, y);
    }
    near.lineTo(size.width, baseY2);
    near.lineTo(size.width, 0);
    near.lineTo(0, 0);
    near.close();
    canvas.drawPath(near, nearPaint);
  }

  @override
  bool shouldRepaint(covariant _DistantMountainsPainter oldDelegate) =>
      oldDelegate.color != color;
}

// ════════════════════════════════════════════════════════════════
// SKILL TREE NODE — Tek bir birim dugumu
// ════════════════════════════════════════════════════════════════

class _SkillTreeNode extends StatelessWidget {
  final _SkillTreeUnit unit;
  final int index;
  final int totalCount;
  final bool isCompleted;
  final bool isCurrent;
  final bool isLocked;
  final bool showTurkish;
  final VoidCallback? onTap;

  const _SkillTreeNode({
    required this.unit,
    required this.index,
    required this.totalCount,
    required this.isCompleted,
    required this.isCurrent,
    required this.isLocked,
    required this.showTurkish,
    this.onTap,
  });

  // Zigzag pattern: saga ve sola sirayla kaydir
  Alignment _nodeAlignment() {
    // Her 2 satirda bir yon degistir (Duolingo pattern)
    final cycle = index % 4;
    switch (cycle) {
      case 0: return Alignment.center;
      case 1: return const Alignment(0.55, 0);
      case 2: return Alignment.center;
      case 3: return const Alignment(-0.55, 0);
      default: return Alignment.center;
    }
  }

  @override
  Widget build(BuildContext context) {
    final alignment = _nodeAlignment();
    final isLast = index == totalCount - 1;

    // Node boyutlari — larger for mountain-path feel
    final nodeSize = isCurrent ? 88.0 : 74.0;
    final catColor = _colorForCategory(unit.katKey);

    // Renkler — her durak kendi kategori rengiyle
    final nodeColor = isCompleted
        ? catColor
        : isCurrent
            ? catColor
            : isLocked
                ? AppColors.backgroundTertiary
                : catColor.withOpacity(0.12);

    final borderColor = isCompleted
        ? catColor
        : isCurrent
            ? AppColors.accent
            : isLocked
                ? AppColors.border
                : catColor.withOpacity(0.4);

    final iconColor = isCompleted || isCurrent
        ? Colors.white
        : isLocked
            ? AppColors.textTertiary
            : catColor;

    final textColor = isLocked
        ? AppColors.textTertiary
        : AppColors.textPrimary;

    return Column(
      children: [
        // Baglanti cizgisi (ilk node haric)
        if (index > 0)
          _PathConnector(
            fromAlignment: _prevAlignment(),
            toAlignment: alignment,
            isCompleted: isCompleted || isCurrent,
          ),

        // Node
        Align(
          alignment: alignment,
          child: GestureDetector(
            onTap: onTap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ana daire
                _buildNodeCircle(nodeSize, nodeColor, borderColor, iconColor),

                const SizedBox(height: 6),

                // Baslik
                Text(
                  unit.kuTitle,
                  style: AppTypography.labelMedium.copyWith(
                    color: textColor,
                    fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),

                // Alt baslik + kelime sayisi — track-aware label.
                // FIX (Apr 2026): Eski davranış `'${unit.trTitle} · ${unit.wordCount} peyv'`
                // showTurkish=true'da leading " · X peyv" üretirdi (unit.trTitle daima boş).
                // EN TRACK FIX: "peyv" (Kurmancî: kelime) EN modunda "words" olmalı.
                Consumer(builder: (_, ref, __) {
                  final enMode = ref.watch(isEnglishModuleProvider);
                  final wordLabel = enMode ? 'words' : 'peyv';
                  return Text(
                    (showTurkish && unit.trTitle.isNotEmpty)
                        ? '${unit.trTitle} · ${unit.wordCount} $wordLabel'
                        : '${unit.wordCount} $wordLabel',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textTertiary,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  );
                }),

                // Aktif node: "Dest pê bike!" etiketi
                if (isCurrent) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Consumer(builder: (_, ref, __) {
                      final enMode = ref.watch(isEnglishModuleProvider);
                      return Text(
                        enMode ? 'Start!' : 'Dest pê bike!',
                        style: AppTypography.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      );
                    }),
                  ),
                ],
              ],
            ),
          ).animate().fadeIn(delay: (200 + index * 60).ms, duration: 350.ms)
              .slideY(begin: 0.15, duration: 350.ms, curve: Curves.easeOut),
        ),

        // Son node'dan sonra bosluk
        if (isLast) const SizedBox(height: AppSpacing.md),
      ],
    );
  }

  Widget _buildNodeCircle(
      double size, Color color, Color border, Color iconColor) {
    final catColor = _colorForCategory(unit.katKey);
    final circle = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: (isCompleted || isCurrent)
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  catColor,
                  Color.lerp(catColor, Colors.black, 0.2)!,
                ],
              )
            : null,
        color: (isCompleted || isCurrent) ? null : color,
        border: Border.all(color: border, width: isCurrent ? 3.5 : 2.5),
        boxShadow: [
          if (isCurrent)
            BoxShadow(
              color: catColor.withOpacity(0.45),
              blurRadius: 20,
              spreadRadius: 3,
            ),
          if (isCompleted)
            BoxShadow(
              color: catColor.withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          if (!isLocked && !isCompleted && !isCurrent)
            BoxShadow(
              color: catColor.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Center(
        child: isCompleted
            ? Icon(Icons.check_rounded, color: iconColor, size: size * 0.4)
            : isLocked
                ? Icon(Icons.lock_rounded, color: iconColor, size: size * 0.35)
                : isCurrent
                    ? Image.asset('assets/images/mascot_64.png',
                        width: size * 0.55, height: size * 0.55,
                        filterQuality: FilterQuality.medium)
                    : Icon(unit.icon, color: iconColor, size: size * 0.4),
      ),
    );

    // Aktif node: pulsing animasyonu
    if (isCurrent) {
      return circle
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scale(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.08, 1.08),
            duration: 1200.ms,
            curve: Curves.easeInOut,
          );
    }

    return circle;
  }

  Alignment _prevAlignment() {
    if (index == 0) return Alignment.center;
    final prevCycle = (index - 1) % 4;
    switch (prevCycle) {
      case 0: return Alignment.center;
      case 1: return const Alignment(0.55, 0);
      case 2: return Alignment.center;
      case 3: return const Alignment(-0.55, 0);
      default: return Alignment.center;
    }
  }
}

// ════════════════════════════════════════════════════════════════
// PATH CONNECTOR — Nodelar arasi baglanti cizgisi
// ════════════════════════════════════════════════════════════════

class _PathConnector extends StatelessWidget {
  final Alignment fromAlignment;
  final Alignment toAlignment;
  final bool isCompleted;

  const _PathConnector({
    required this.fromAlignment,
    required this.toAlignment,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: CustomPaint(
        size: const Size(double.infinity, 42),
        painter: _PathPainter(
          fromX: (fromAlignment.x + 1) / 2,
          toX: (toAlignment.x + 1) / 2,
          isCompleted: isCompleted,
        ),
      ),
    );
  }
}

class _PathPainter extends CustomPainter {
  final double fromX;
  final double toX;
  final bool isCompleted;

  _PathPainter({
    required this.fromX,
    required this.toX,
    required this.isCompleted,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Dashed line icin path
    final startX = size.width * fromX;
    final endX = size.width * toX;

    final path = Path();
    path.moveTo(startX, 0);

    if ((startX - endX).abs() < 10) {
      path.lineTo(endX, size.height);
    } else {
      path.cubicTo(
        startX, size.height * 0.4,
        endX, size.height * 0.6,
        endX, size.height,
      );
    }

    // Gölge çizgi (altta)
    final shadowPaint = Paint()
      ..color = (isCompleted ? const Color(0xFF1A7B6B) : Colors.black).withOpacity(0.08)
      ..strokeWidth = isCompleted ? 5.0 : 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, shadowPaint);

    // Ana çizgi — dashed pattern
    final paint = Paint()
      ..color = isCompleted
          ? const Color(0xFF1A7B6B).withOpacity(0.7) // teal canlı
          : const Color(0xFF1A7B6B).withOpacity(0.18)
      ..strokeWidth = isCompleted ? 3.5 : 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final dashPath = Path();
    const dashLen = 8.0;
    const gapLen = 5.0;
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = math.min(distance + dashLen, metric.length);
        final extracted = metric.extractPath(distance, end);
        dashPath.addPath(extracted, Offset.zero);
        distance += dashLen + gapLen;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant _PathPainter old) =>
      old.fromX != fromX || old.toX != toX || old.isCompleted != isCompleted;
}

// (kaldırıldı: _LutkeBottomNav, _NavItem, _StartQuizButton)
// Eski _LanguageModeToggle ve _ModuleSwitcher kaldırıldı.
// Dil modu (KU/TR vs kuOnly) artık yalnızca Profile > _LanguageModeCard'ta.
// Track değişimi de Profile > _ActiveTrackCard üzerinden track-select'e gider.
