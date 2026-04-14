import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/router/app_router.dart';
import '../../shared/providers/language_mode_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showTr = ref.watch(showTurkishProvider);
    final sw = MediaQuery.of(context).size.width;
    final w = sw > 480 ? 480.0 : sw;

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
                colors: [Color(0xFF1A7B6B), Color(0xFF0A3D35)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // ── Logo ──────────────────────────────────
                  ClipOval(
                    child: Container(
                      width: w * 0.28,
                      height: w * 0.28,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(w * 0.04),
                      child: Image.asset('assets/images/logo_512.png',
                        fit: BoxFit.contain, filterQuality: FilterQuality.medium),
                    ),
                  ).animate().scale(
                    begin: const Offset(0.8, 0.8),
                    curve: Curves.easeOutCubic, duration: 600.ms),

                  SizedBox(height: w * 0.04),

                  // ── LÛTKE ─────────────────────────────────
                  Text('LÛTKE',
                    style: TextStyle(
                      fontSize: w * 0.08,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: w * 0.012,
                    ),
                  ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

                  const SizedBox(height: 4),

                  Text('Zimanê Kurdî',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                      letterSpacing: 0.5,
                    ),
                  ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

                  const SizedBox(height: 18),

                  // ── Slogan ────────────────────────────────
                  // "Dil vatansız kalır ama vatan dilsiz kalmaz."
                  // Anadilin kimlik için merkezi rolünü vurgular.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      '"Ziman bê welat dimîne, lê welat bê ziman namîne."',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.95),
                        height: 1.45,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ).animate().fadeIn(delay: 500.ms, duration: 500.ms),

                  const Spacer(flex: 1),

                  // ── Öğrenme Yolu Görseli ──────────────────
                  _LearningPathPreview()
                      .animate()
                      .fadeIn(delay: 700.ms, duration: 600.ms)
                      .slideY(begin: 0.15, curve: Curves.easeOut),

                  const Spacer(flex: 1),

                  // ── Têketin / Tomarkirin — Sade, daha küçük CTA ──
                  // (max genişlik sınırlı, daha kompakt)
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 240),
                      child: SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton.icon(
                          onPressed: () => context.go(AppRoutes.register),
                          icon: const Icon(Icons.login_rounded, size: 18),
                          label: const Text(
                            'Têketin / Tomarkirin',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.2),

                  const Spacer(flex: 1),

                  // Çêker
                  Text('Çêker: Prof. Dr. Yılmaz Mutlu',
                    style: TextStyle(fontSize: 11,
                      color: Colors.white.withOpacity(0.35)),
                  ).animate().fadeIn(delay: 1400.ms),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// ÖĞRENME YOLU ÖNİZLEME — Dağ yolculuğu metaforu
// ════════════════════════════════════════════════════════════════

class _LearningPathPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Başlık
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/mascot_64.png',
                    width: 22,
                    height: 22,
                    filterQuality: FilterQuality.medium,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Rêya Fêrbûnê',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withOpacity(0.92),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Seviye yolu — 6 CEFR seviyesi (kompakt)
              Row(
                children: [
                  _LevelDot(label: 'A1', isActive: true, color: const Color(0xFF4CAF50)),
                  _PathLine(),
                  _LevelDot(label: 'A2', color: const Color(0xFF8BC34A)),
                  _PathLine(),
                  _LevelDot(label: 'B1', color: const Color(0xFFFF9800)),
                  _PathLine(),
                  _LevelDot(label: 'B2', color: const Color(0xFFFF5722)),
                  _PathLine(),
                  _LevelDot(label: 'C1', color: const Color(0xFF9C27B0)),
                  _PathLine(),
                  _LevelDot(label: 'C2', color: const Color(0xFF673AB7)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LevelDot extends StatelessWidget {
  final String label;
  final bool isActive;
  final Color color;

  const _LevelDot({required this.label, this.isActive = false, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: isActive ? 26 : 20,
          height: isActive ? 26 : 20,
          decoration: BoxDecoration(
            color: isActive ? color : color.withOpacity(0.35),
            shape: BoxShape.circle,
            border: isActive
                ? Border.all(color: Colors.white, width: 1.5)
                : null,
          ),
          child: Center(
            child: isActive
                ? const Icon(Icons.flag_rounded, size: 11, color: Colors.white)
                : null,
          ),
        ),
        const SizedBox(height: 3),
        Text(label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive ? Colors.white : Colors.white.withOpacity(0.55),
          ),
        ),
      ],
    );
  }
}

class _PathLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 1.5,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white.withOpacity(0.3), Colors.white.withOpacity(0.1)],
          ),
        ),
      ),
    );
  }
}
