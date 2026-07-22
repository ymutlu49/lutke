import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/router/app_router.dart';
import '../../shared/providers/intro_seen_provider.dart';
import '../../shared/providers/learning_track_provider.dart';
import '../../core/services/cloudflare_auth_service.dart';

// ════════════════════════════════════════════════════════════════
// INTRO / PÊŞKÊŞKIRIN — LÛTKE
//
// Akış: Register/Login → BU EKRAN → Placement Test → Track Select → Home
//
// 3 slayt swipeable Kurmancî pêşkêşkirin:
//   1. "Xêr hatî LÛTKE'yê!" — em ê bi hev re Kurmancî û Îngilîzî fêr bibin
//   2. "Em rêberiya te dikin" — her pey serkeftinê tu dê xelat bistînî
//   3. "Pêşî, em asta te ya zimên dibînin"
//
// İlke §0.5: Pure Kurmancî. Hîç Tirkî tune.
// İlke §1.1: Yargılamayan, destekleyici ton.
// ════════════════════════════════════════════════════════════════

class IntroFlowScreen extends ConsumerStatefulWidget {
  const IntroFlowScreen({super.key});

  @override
  ConsumerState<IntroFlowScreen> createState() => _IntroFlowScreenState();
}

class _IntroFlowScreenState extends ConsumerState<IntroFlowScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  static const int _totalPages = 3;

  @override
  void initState() {
    super.initState();
    // Yerleşmiş kullanıcı (hesapta veya localStorage'da placement var) intro'yu
    // ve track-select/testi tekrar görmesin → doğrudan ana sayfaya.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      if (await _isPlaced()) {
        await markIntroSeen(ref);
        if (!mounted) return;
        context.go(ref.read(currentTrackProvider).nativeHomePath);
      }
    });
  }

  /// Hesap (cloudflareCurrentUserProvider) veya localStorage'da bu track için
  /// düzey testi tamamlanmış mı?
  ///
  /// YARIŞ DÜZELTMESİ (Temmuz 2026): önceden .valueOrNull ile okunuyordu —
  /// sayfa yenilenince /me henüz dönmemişse null gelir, prefs de boşsa
  /// (yeni cihaz) test yeniden gösterilirdi. hasPlacementForTrack hesap
  /// bilgisi YÜKLENENE kadar bekler (5 sn timeout → prefs fallback) ve
  /// track-duyarlıdır (KU → placementLevel, EN → placementLevelEn).
  Future<bool> _isPlaced() async {
    final track = ref.read(currentTrackProvider);
    return hasPlacementForTrack(ref, track.languageCode);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> _completeIntro() async {
    // Akış: intro → track-select → (yeni user için) placement → home.
    // Track seçim ekranı kullanıcının placement testini yapmadığını
    // tespit ederse 20 soruluk testi otomatik tetikler.
    // Flag set: bir sonraki splash'ta logged-in user direkt track-select'e gider.
    await markIntroSeen(ref);
    if (!mounted) return;
    // Yerleşmiş kullanıcı → track-select/testi atla, doğrudan ana sayfa.
    if (await _isPlaced()) {
      if (!mounted) return;
      context.go(ref.read(currentTrackProvider).nativeHomePath);
      return;
    }
    if (!mounted) return;
    context.go(AppRoutes.trackSelect);
  }

  void _nextOrFinish() {
    if (_currentPage < _totalPages - 1) {
      _goToPage(_currentPage + 1);
    } else {
      _completeIntro();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _totalPages - 1;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar — Skip ────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Vegere — sadece ilk slaytta gizle
                  if (_currentPage > 0)
                    SizedBox(
                      width: AppSpacing.touchMin,
                      height: AppSpacing.touchMin,
                      child: IconButton(
                        tooltip: 'Vegere',
                        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                        onPressed: () => _goToPage(_currentPage - 1),
                      ),
                    )
                  else
                    const SizedBox(
                      width: AppSpacing.touchMin,
                      height: AppSpacing.touchMin,
                    ),
                  TextButton(
                    onPressed: _completeIntro,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.textTertiary,
                      minimumSize: const Size(
                        AppSpacing.touchMin,
                        AppSpacing.touchMin,
                      ),
                    ),
                    child: Text(
                      'Derbas bike',
                      style: AppTypography.label.copyWith(
                        color: AppColors.textTertiary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── PageView ──────────────────────────────────────
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: const [
                  _IntroSlide(
                    iconAsset: 'assets/images/logo_512.png',
                    iconType: _IconType.logo,
                    title: "Bi xêr hatî LÛTKE'yê!",
                    subtitle: 'Em ê bi hev re Kurmancî û Îngilîzî fêr bibin.',
                    description: 'Lûtke hevrêyê te ye ji bo hînbûna zimanî. '
                        'Em ji destpêkê heya astên bilind bi hev re ne.\n\n'
                        'Sepan hîn nû ye — em ji kêmasiyên biçûk haydar in '
                        'û dê hêdî hêdî hemûyan baş bikin. Spas ji bo sebra te!',
                    accentColor: AppColors.primary,
                  ),
                  _IntroSlide(
                    iconAsset: null,
                    iconType: _IconType.path,
                    title: 'Em rêberiya te dikin.',
                    subtitle: 'Li ser rêya fêrbûnê, em her dem bi te re ne.',
                    description: 'Piştî her serkeftinê, tu dê xelatan bistînî. '
                        'Asta te hêdî hêdî dê bilind bibe — A1, A2, B1, B2, C1.',
                    accentColor: Color(0xFFE89200),
                  ),
                  _IntroSlide(
                    iconAsset: 'assets/images/mascot_128.png',
                    iconType: _IconType.mascot,
                    title: 'Pêşî, em asta te dibînin.',
                    subtitle: 'Paşê, tu dikarî rêya xwe hilbijêrî.',
                    description:
                        'Em ê çend pirsên kurt ji te bipirsin da ku em '
                        'asta te ya zimanî fêm bikin. Paşê, tu dê rêya '
                        'xwe ya fêrbûnê hilbijêrî.',
                    accentColor: Color(0xFF1E88E5),
                  ),
                ],
              ),
            ),

            // ── Page indicators ───────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_totalPages, (i) {
                  final isActive = i == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                          isActive ? AppColors.primary : AppColors.borderLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),

            // ── Berdewam bike button ──────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: SizedBox(
                width: double.infinity,
                height: AppSpacing.touchPreferred,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: _nextOrFinish,
                  child: Text(
                    isLastPage ? 'Em dest pê bikin!' : 'Berdewam bike',
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.textOnPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Slide içeriği ──────────────────────────────────────────────

enum _IconType { logo, path, mascot }

class _IntroSlide extends StatelessWidget {
  final String? iconAsset;
  final _IconType iconType;
  final String title;
  final String subtitle;
  final String description;
  final Color accentColor;

  const _IntroSlide({
    required this.iconAsset,
    required this.iconType,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Görsel
          _buildVisual()
              .animate(key: ValueKey(title))
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1, 1),
                duration: 500.ms,
                curve: Curves.easeOutBack,
              )
              .fadeIn(duration: 400.ms),

          const SizedBox(height: AppSpacing.xl),

          // Sernav
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.headline.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 26,
              height: 1.25,
            ),
          ).animate(key: ValueKey('title_$title')).fadeIn(
                delay: 200.ms,
                duration: 400.ms,
              ),

          const SizedBox(height: AppSpacing.sm),

          // Bin sernav (vurgulu)
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTypography.bodyLarge.copyWith(
              color: accentColor,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ).animate(key: ValueKey('sub_$title')).fadeIn(
                delay: 350.ms,
                duration: 400.ms,
              ),

          const SizedBox(height: AppSpacing.md),

          // Şirove
          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
              height: 1.55,
            ),
          ).animate(key: ValueKey('desc_$title')).fadeIn(
                delay: 500.ms,
                duration: 400.ms,
              ),
        ],
      ),
    );
  }

  Widget _buildVisual() {
    switch (iconType) {
      case _IconType.logo:
      case _IconType.mascot:
        return Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: accentColor.withOpacity(0.18),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Image.asset(
            iconAsset!,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.medium,
          ),
        );
      case _IconType.path:
        return _SkillTreePreview(accentColor: accentColor);
    }
  }
}

// ── Slayt 2 — CEFR yolu önizlemesi ─────────────────────────────

class _SkillTreePreview extends StatelessWidget {
  final Color accentColor;
  const _SkillTreePreview({required this.accentColor});

  @override
  Widget build(BuildContext context) {
    final levels = <(String, Color)>[
      ('A1', const Color(0xFF4CAF50)),
      ('A2', const Color(0xFF8BC34A)),
      ('B1', const Color(0xFFFF9800)),
      ('B2', const Color(0xFFFF5722)),
      ('C1', const Color(0xFF9C27B0)),
    ];

    return Container(
      width: 220,
      height: 160,
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: accentColor.withOpacity(0.18),
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Trofe
          Icon(
            Icons.emoji_events_rounded,
            color: accentColor,
            size: 40,
          ),
          const SizedBox(height: AppSpacing.sm),
          // Asta dot zincirî
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < levels.length; i++) ...[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: levels[i].$2,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      levels[i].$1,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                if (i < levels.length - 1)
                  Container(
                    width: 8,
                    height: 1.5,
                    color: AppColors.borderLight,
                    margin: const EdgeInsets.only(bottom: 14),
                  ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
