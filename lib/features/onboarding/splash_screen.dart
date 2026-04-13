import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/router/app_router.dart';
import '../../core/services/auth_service.dart';
import '../../shared/widgets/lutke_logo.dart';

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
    // Animasyon için bekle
    await Future.delayed(2800.ms);
    if (!mounted) return;

    final authState = ref.read(authStateProvider);
    authState.when(
      data: (user) {
        if (user != null) {
          // Giriş yapmış → doğrudan ana sayfa
          context.go(AppRoutes.home);
        } else {
          // Giriş yapmamış → onboarding
          context.go(AppRoutes.passiveTest);
        }
      },
      loading: () => context.go(AppRoutes.passiveTest),
      error: (_, __) => context.go(AppRoutes.passiveTest),
    );
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

                Text(
                  'Hoş geldiniz — Welcome',
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

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
