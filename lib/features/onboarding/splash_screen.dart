import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/router/app_router.dart';
import '../../core/services/auth_service.dart';

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
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Logo — canlandırmalı giriş
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Image.asset(
                  'assets/images/logo_512.png',
                  fit: BoxFit.contain,
                ),
              )
                  .animate()
                  .scale(
                    begin: const Offset(0, 0),
                    curve: Curves.elasticOut,
                    duration: 800.ms,
                  )
                  .then()
                  .shimmer(duration: 1200.ms, color: Colors.white30),

              const SizedBox(height: 32),

              // Uygulama adı
              Text(
                'LÛTKE',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 6,
                ),
              ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

              const SizedBox(height: 8),

              // Kurmancî alt başlık — İlke §0.5
              Text(
                'Zimanê Kurdî',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.85),
                  letterSpacing: 2,
                ),
              ).animate().fadeIn(delay: 600.ms, duration: 600.ms),

              const SizedBox(height: 80),

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

              const SizedBox(height: 60),

              // Yükleniyor göstergesi
              SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white.withOpacity(0.6),
                ),
              ).animate().fadeIn(delay: 2000.ms),
            ],
          ),
        ),
      ),
    );
  }
}
