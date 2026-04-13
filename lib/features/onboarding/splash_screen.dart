import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/router/app_router.dart';
import '../../core/services/auth_service.dart';
import '../../shared/widgets/lutke_logo.dart';
import '../../shared/providers/language_mode_provider.dart';

// ════════════════════════════════════════════════════════════════
// SPLASH EKRANI — LÛTKE
//
// İlke §2: "Feel first, play second"
// İlke §0.5: Kurmancî ile aç — "Xêr hatî"
// İlke §1.1: Hiç yargılamayan, sıcak karşılama
// ════════════════════════════════════════════════════════════════

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    // Splash animasyonu ile paralel olarak onboarding durumunu kontrol et
    final prefsFuture = SharedPreferences.getInstance();
    await Future.delayed(2800.ms);
    if (!mounted) return;

    final prefs = await prefsFuture;
    final onboardingComplete = prefs.getBool('onboarding_complete') ?? false;

    if (!mounted) return;

    // İlk kullanıcılar welcome flow'a, diğerleri doğrudan home'a
    if (!onboardingComplete) {
      context.go(AppRoutes.welcome);
      return;
    }

    try {
      final authState = ref.read(authStateProvider);
      authState.when(
        data: (user) {
          if (user != null) {
            context.go(AppRoutes.home);
          } else {
            context.go(AppRoutes.home); // Firebase yok — doğrudan home
          }
        },
        loading: () => context.go(AppRoutes.home),
        error: (_, __) => context.go(AppRoutes.home),
      );
    } catch (_) {
      // Firebase hatasında bile home'a git
      if (mounted) context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary,
              AppColors.primaryDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [

                const Spacer(flex: 3),

                // Logo — merkezi marka widget'ı
                LutkeLogo.splash(screenWidth: screenWidth),

                const Spacer(flex: 2),

                // Hoş geldin mesajı — Kurmancî (İlke §0.5, §2)
                Text(
                  'Xêr hatî.',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.9),
                    fontStyle: FontStyle.italic,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 1200.ms, duration: 800.ms)
                    .slideY(begin: 0.3, curve: Curves.easeOut),

                const SizedBox(height: 8),

                if (ref.watch(showTurkishProvider))
                  Text(
                    'Bi xêr hatî — Welcome',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ).animate().fadeIn(delay: 1600.ms, duration: 600.ms),

                const Spacer(flex: 2),

                // Yükleniyor göstergesi
                SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ).animate().fadeIn(delay: 2000.ms),

                const Spacer(flex: 1),

                // Çêker bilgisi
                Text(
                  'Çêker: Prof. Dr. Yılmaz Mutlu',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.4),
                    letterSpacing: 0.5,
                  ),
                ).animate().fadeIn(delay: 2200.ms, duration: 600.ms),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
