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
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.primary, AppColors.primaryDark],
              ),
            ),
            child: Column(
              children: [

                const Spacer(flex: 3),

                // Logo
                LutkeLogo.splash(screenWidth: screenWidth > 480 ? 480 : screenWidth),

                const Spacer(flex: 1),

                // Xêr hatî
                Text('Xêr hatî.',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.9), fontStyle: FontStyle.italic),
                ).animate().fadeIn(delay: 1200.ms, duration: 800.ms)
                    .slideY(begin: 0.3, curve: Curves.easeOut),

                const SizedBox(height: 8),

                if (ref.watch(showTurkishProvider))
                  Text('Bi xêr hatî — Welcome',
                    style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6)),
                  ).animate().fadeIn(delay: 1600.ms, duration: 600.ms),

                const Spacer(flex: 2),

                // Giriş butonları
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      // Ana giriş butonu
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () => _navigateTo(AppRoutes.home),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                            elevation: 0,
                          ),
                          child: const Text('Dest pê bike',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        ),
                      ).animate().fadeIn(delay: 1800.ms).slideY(begin: 0.2),

                      const SizedBox(height: 12),

                      // Hesap giriş
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () => _navigateTo(AppRoutes.register),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: BorderSide(color: Colors.white.withOpacity(0.4)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          ),
                          child: const Text('Têketin / Tomarkirin',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                      ).animate().fadeIn(delay: 2000.ms).slideY(begin: 0.2),
                    ],
                  ),
                ),

                const Spacer(flex: 1),

                // Çêker bilgisi
                Text('Çêker: Prof. Dr. Yılmaz Mutlu',
                  style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.4),
                    letterSpacing: 0.5),
                ).animate().fadeIn(delay: 2200.ms, duration: 600.ms),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateTo(String route) {
    context.go(route);
  }
}
