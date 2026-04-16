import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/router/app_router.dart';

/// LÛTKE markasının tek gerçek kaynağı.
/// Tüm ekranlarda tutarlı logo gösterimi sağlar.
///
/// Kullanım:
///   LutkeLogo.icon(size: 48)           — sadece ikon
///   LutkeLogo.brand()                  — ikon + LÛTKE yazısı (dikey)
///   LutkeLogo.brandHorizontal()        — ikon + LÛTKE yazısı (yatay, app bar)
///   LutkeLogo.splash(screenWidth: w)   — splash ekranı versiyonu
class LutkeLogo extends StatelessWidget {
  final double size;
  final _LogoVariant _variant;
  final bool animated;
  /// Logoya dokunulduğunda çağrılacak callback.
  /// `null` → tıklanamaz (splash/welcome gibi akış içi ekranlar).
  /// Varsayılan (factory'lerden gelir) → ana sayfaya yönlendirir.
  final VoidCallback? onTap;

  const LutkeLogo._({
    required this.size,
    required _LogoVariant variant,
    this.animated = false,
    this.onTap,
  }) : _variant = variant;

  /// Sadece ikon — navigation bar, küçük alanlar. Tıklanabilir (ana sayfaya gider).
  factory LutkeLogo.icon({double size = 40, VoidCallback? onTap}) =>
      LutkeLogo._(size: size, variant: _LogoVariant.icon, onTap: onTap ?? _goHome);

  /// Dikey marka — ikon üstte, yazı altta. Auth, onboarding. Splash/welcome için onTap: null.
  factory LutkeLogo.brand({
    double iconSize = 72,
    bool animated = false,
    VoidCallback? onTap,
  }) => LutkeLogo._(
        size: iconSize,
        variant: _LogoVariant.brand,
        animated: animated,
        onTap: onTap,
      );

  /// Yatay marka — ikon solda, yazı sağda. App bar. Tıklanabilir.
  factory LutkeLogo.brandHorizontal({double iconSize = 32, VoidCallback? onTap}) =>
      LutkeLogo._(
        size: iconSize,
        variant: _LogoVariant.horizontal,
        onTap: onTap ?? _goHome,
      );

  /// Splash ekranı — büyük, animasyonlu. Tıklanamaz (akış içi).
  factory LutkeLogo.splash({required double screenWidth}) {
    final s = (screenWidth * 0.28).clamp(72.0, 140.0);
    return LutkeLogo._(size: s, variant: _LogoVariant.splash, animated: true);
  }

  /// Dahili sentinel — onTap geç argümanı olmayan çağrılarda runtime'da
  /// context'e ihtiyaç olduğundan, _navigate() helper'ı kullanılır.
  static void _goHome() {} // yerleşik sentinel — build içinde ele alınır

  @override
  Widget build(BuildContext context) {
    final raw = switch (_variant) {
      _LogoVariant.icon => _buildIcon(),
      _LogoVariant.brand => _buildBrand(),
      _LogoVariant.horizontal => _buildHorizontal(),
      _LogoVariant.splash => _buildSplash(),
    };
    if (onTap == null) return raw;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (onTap == _goHome) {
            // Ana sayfaya git — mevcut rota zaten home ise no-op
            final loc = GoRouterState.of(context).matchedLocation;
            if (loc != AppRoutes.home) context.go(AppRoutes.home);
          } else {
            onTap!.call();
          }
        },
        child: Tooltip(
          message: 'Serrûpel',
          waitDuration: const Duration(milliseconds: 800),
          child: raw,
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: Image.asset(
          _assetForSize(size),
          fit: BoxFit.cover,
          filterQuality: FilterQuality.medium,
          errorBuilder: (_, __, ___) => _fallbackIcon(size),
        ),
      ),
    );
  }

  Widget _buildBrand() {
    Widget logo = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Ikon — temiz, gölgesiz
        SizedBox(
          width: size,
          height: size,
          child: Image.asset(
            _assetForSize(size),
            fit: BoxFit.contain,
            filterQuality: FilterQuality.medium,
            errorBuilder: (_, __, ___) => _fallbackIcon(size),
          ),
        ),

        SizedBox(height: size * 0.18),

        // LÛTKE yazısı
        Text(
          'LÛTKE',
          style: TextStyle(
            fontSize: size * 0.33,
            fontWeight: FontWeight.w900,
            color: AppColors.primary,
            letterSpacing: size * 0.04,
            height: 1,
          ),
        ),

        SizedBox(height: size * 0.04),

        // Alt yazı
        Text(
          'Zimanê Kurdî',
          style: TextStyle(
            fontSize: size * 0.16,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
            letterSpacing: size * 0.02,
          ),
        ),
      ],
    );

    if (animated) {
      logo = logo
          .animate()
          .fadeIn(duration: 600.ms, curve: Curves.easeOut)
          .slideY(begin: 0.08, duration: 600.ms, curve: Curves.easeOut);
    }

    return logo;
  }

  Widget _buildHorizontal() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipOval(
          child: SizedBox(
            width: size,
            height: size,
            child: Image.asset(
              _assetForSize(size),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.medium,
              errorBuilder: (_, __, ___) => _fallbackIcon(size),
            ),
          ),
        ),

        SizedBox(width: size * 0.15),

        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LÛTKE',
              style: TextStyle(
                fontSize: size * 0.52,
                fontWeight: FontWeight.w900,
                color: AppColors.primary,
                letterSpacing: 0.8,
                height: 1,
              ),
            ),
            Text(
              'Zimanê Kurdî',
              style: TextStyle(
                fontSize: size * 0.2,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
                letterSpacing: 0.3,
                height: 1.3,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSplash() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo — beyaz zemin üzerinde, hafif gölge
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: size * 0.2,
                offset: Offset(0, size * 0.04),
              ),
            ],
          ),
          padding: EdgeInsets.all(size * 0.14),
          child: Image.asset(
            'assets/images/logo_512.png',
            fit: BoxFit.contain,
            filterQuality: FilterQuality.medium,
            errorBuilder: (_, __, ___) => _fallbackIcon(size * 0.72),
          ),
        )
            .animate()
            .scale(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1, 1),
              curve: Curves.easeOutCubic,
              duration: 700.ms,
            )
            .fadeIn(duration: 500.ms),

        SizedBox(height: size * 0.22),

        // LÛTKE
        Text(
          'LÛTKE',
          style: TextStyle(
            fontSize: size * 0.3,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: size * 0.05,
            height: 1,
          ),
        ).animate().fadeIn(delay: 300.ms, duration: 500.ms),

        SizedBox(height: size * 0.06),

        // Zimanê Kurdî
        Text(
          'Zimanê Kurdî',
          style: TextStyle(
            fontSize: size * 0.13,
            fontWeight: FontWeight.w400,
            color: Colors.white.withOpacity(0.8),
            letterSpacing: size * 0.015,
          ),
        ).animate().fadeIn(delay: 500.ms, duration: 500.ms),
      ],
    );
  }

  // ── Yardımcılar ─────────────────────────────────────────

  static String _assetForSize(double size) {
    if (size > 200) return 'assets/images/logo_512.png';
    if (size > 100) return 'assets/images/logo_256.png';
    return 'assets/images/logo_128.png';
  }

  static Widget _fallbackIcon(double size) {
    return Icon(
      Icons.landscape_rounded,
      size: size * 0.5,
      color: AppColors.primary,
    );
  }
}

enum _LogoVariant { icon, brand, horizontal, splash }
