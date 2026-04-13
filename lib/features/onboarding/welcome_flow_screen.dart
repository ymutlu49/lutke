import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/router/app_router.dart';
import '../../shared/providers/language_mode_provider.dart';

// ════════════════════════════════════════════════════════════════
// WELCOME FLOW — LÛTKE
//
// Duolingo-tarzı 3 adımlı onboarding:
//   1. Hoş geldin (Xêr hatî)
//   2. Hedef seçimi (Armanca xwe hilbijêre)
//   3. Hazırsın! (Tu amade yî!)
//
// İlke §0.5: Kurmancî ile aç
// İlke §2: "Feel first, play second"
// ════════════════════════════════════════════════════════════════

class WelcomeFlowScreen extends StatefulWidget {
  const WelcomeFlowScreen({super.key});

  @override
  State<WelcomeFlowScreen> createState() => _WelcomeFlowScreenState();
}

class _WelcomeFlowScreenState extends State<WelcomeFlowScreen> {
  final _pageController = PageController();
  int _currentPage = 0;
  int? _selectedGoal;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: 400.ms,
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    if (mounted) {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundPrimary,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip butonu (sadece ilk 2 sayfada)
              if (_currentPage < 2)
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12, right: 16),
                    child: TextButton(
                      onPressed: _completeOnboarding,
                      child: Text(
                        'Derbas bike',
                        style: AppTypography.label.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ),
                  ),
                )
              else
                const SizedBox(height: 52),

              // Sayfa içerikleri
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  children: [
                    _WelcomePage(onNext: () => _goToPage(1)),
                    _GoalPage(
                      selectedGoal: _selectedGoal,
                      onGoalSelected: (goal) {
                        setState(() => _selectedGoal = goal);
                      },
                      onNext: () async {
                        if (_selectedGoal != null) {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setInt(
                              'daily_goal_minutes', _selectedGoal!);
                          _goToPage(2);
                        }
                      },
                    ),
                    _ReadyPage(onComplete: _completeOnboarding),
                  ],
                ),
              ),

              // Dot göstergeleri
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (i) {
                    final isActive = i == _currentPage;
                    return AnimatedContainer(
                      duration: 300.ms,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isActive ? 28 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColors.primary
                            : AppColors.borderLight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// SAYFA 1 — Xêr hatî (Hoş geldin)
// ════════════════════════════════════════════════════════════════

class _WelcomePage extends StatelessWidget {
  final VoidCallback onNext;
  const _WelcomePage({required this.onNext});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final logoSize = (screenWidth * 0.35).clamp(100.0, 160.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const Spacer(flex: 2),

          // Logo
          Container(
            width: logoSize,
            height: logoSize,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.15),
                  blurRadius: 40,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: EdgeInsets.all(logoSize * 0.12),
            child: Image.asset(
              'assets/images/logo_512.png',
              fit: BoxFit.contain,
              filterQuality: FilterQuality.medium,
            ),
          )
              .animate()
              .scale(
                begin: const Offset(0.7, 0.7),
                end: const Offset(1, 1),
                duration: 700.ms,
                curve: Curves.easeOutBack,
              )
              .fadeIn(duration: 500.ms),

          const SizedBox(height: 32),

          // LÛTKE
          Text(
            'LÛTKE',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
              letterSpacing: 4,
            ),
          )
              .animate()
              .fadeIn(delay: 300.ms, duration: 500.ms)
              .slideY(begin: 0.3, curve: Curves.easeOut),

          const SizedBox(height: 24),

          // Ana mesaj — Kurmancî
          Text(
            'Zimanê xwe vegerîne',
            textAlign: TextAlign.center,
            style: AppTypography.displayKurmanji.copyWith(
              color: AppColors.textPrimary,
            ),
          )
              .animate()
              .fadeIn(delay: 500.ms, duration: 600.ms)
              .slideY(begin: 0.2, curve: Curves.easeOut),

          const SizedBox(height: 12),

          // Alt açıklama — Türkçe (only when showTurkish)
          Consumer(
            builder: (context, ref, _) {
              if (!ref.watch(showTurkishProvider)) return const SizedBox.shrink();
              return Text(
                'Kurmancî öğrenmenin en etkili yolu',
                textAlign: TextAlign.center,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              )
                  .animate()
                  .fadeIn(delay: 700.ms, duration: 500.ms);
            },
          ),

          const Spacer(flex: 2),

          // CTA Butonu
          _PrimaryButton(
            label: 'Dest pê bike!',
            onPressed: onNext,
          )
              .animate()
              .fadeIn(delay: 900.ms, duration: 500.ms)
              .slideY(begin: 0.3, curve: Curves.easeOut),

          const Spacer(flex: 1),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// SAYFA 2 — Armanca xwe hilbijêre (Hedef seç)
// ════════════════════════════════════════════════════════════════

class _GoalPage extends StatelessWidget {
  final int? selectedGoal;
  final ValueChanged<int> onGoalSelected;
  final VoidCallback onNext;

  const _GoalPage({
    required this.selectedGoal,
    required this.onGoalSelected,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(flex: 1),

          // Başlık
          Text(
            'Armanca xwe hilbijêre',
            textAlign: TextAlign.center,
            style: AppTypography.displayKurmanji.copyWith(
              color: AppColors.textPrimary,
            ),
          )
              .animate()
              .fadeIn(duration: 500.ms)
              .slideY(begin: 0.2, curve: Curves.easeOut),

          const SizedBox(height: 8),

          Text(
            'Rojê çend hûrdem?',
            textAlign: TextAlign.center,
            style: AppTypography.headline.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          )
              .animate()
              .fadeIn(delay: 200.ms, duration: 400.ms),

          const SizedBox(height: 12),

          Consumer(
            builder: (context, ref, _) {
              if (!ref.watch(showTurkishProvider)) return const SizedBox.shrink();
              return Text(
                'Hedefini sonra da değiştirebilirsin',
                textAlign: TextAlign.center,
                style: AppTypography.body.copyWith(
                  color: AppColors.textTertiary,
                ),
              )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 400.ms);
            },
          ),

          const SizedBox(height: 36),

          // Hedef kartları
          _GoalCard(
            emoji: '🌱',
            minutes: 5,
            kurmanjLabel: '5 deqîqe',
            turkishLabel: 'Sivik — Hafif',
            isSelected: selectedGoal == 5,
            onTap: () => onGoalSelected(5),
          )
              .animate()
              .fadeIn(delay: 400.ms, duration: 400.ms)
              .slideX(begin: -0.1, curve: Curves.easeOut),

          const SizedBox(height: 12),

          _GoalCard(
            emoji: '📚',
            minutes: 10,
            kurmanjLabel: '10 deqîqe',
            turkishLabel: 'Normal',
            isSelected: selectedGoal == 10,
            onTap: () => onGoalSelected(10),
          )
              .animate()
              .fadeIn(delay: 550.ms, duration: 400.ms)
              .slideX(begin: -0.1, curve: Curves.easeOut),

          const SizedBox(height: 12),

          _GoalCard(
            emoji: '🔥',
            minutes: 20,
            kurmanjLabel: '20 deqîqe',
            turkishLabel: 'Cidî — Ciddi',
            isSelected: selectedGoal == 20,
            onTap: () => onGoalSelected(20),
          )
              .animate()
              .fadeIn(delay: 700.ms, duration: 400.ms)
              .slideX(begin: -0.1, curve: Curves.easeOut),

          const Spacer(flex: 2),

          // Devam butonu
          AnimatedOpacity(
            opacity: selectedGoal != null ? 1.0 : 0.4,
            duration: 300.ms,
            child: _PrimaryButton(
              label: 'Berdewam bike',
              onPressed: selectedGoal != null ? onNext : null,
            ),
          ),

          const Spacer(flex: 1),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// SAYFA 3 — Tu amade yî! (Hazırsın!)
// ════════════════════════════════════════════════════════════════

class _ReadyPage extends StatelessWidget {
  final VoidCallback onComplete;
  const _ReadyPage({required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const Spacer(flex: 2),

          // Kutlama ikonu
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.successSurface,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.celebration_rounded,
              size: 56,
              color: AppColors.success,
            ),
          )
              .animate()
              .scale(
                begin: const Offset(0, 0),
                end: const Offset(1, 1),
                duration: 600.ms,
                curve: Curves.easeOutBack,
              )
              .fadeIn(duration: 400.ms),

          const SizedBox(height: 32),

          // Kutlama mesajı
          Text(
            'Tu amade yî!',
            textAlign: TextAlign.center,
            style: AppTypography.displayKurmanji.copyWith(
              color: AppColors.primary,
            ),
          )
              .animate()
              .fadeIn(delay: 300.ms, duration: 500.ms)
              .slideY(begin: 0.2, curve: Curves.easeOut),

          const SizedBox(height: 8),

          Consumer(
            builder: (context, ref, _) {
              if (!ref.watch(showTurkishProvider)) return const SizedBox.shrink();
              return Text(
                'Hazırsın!',
                textAlign: TextAlign.center,
                style: AppTypography.headline.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                ),
              )
                  .animate()
                  .fadeIn(delay: 450.ms, duration: 400.ms);
            },
          ),

          const SizedBox(height: 40),

          // İstatistikler
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatBadge(
                value: '3,900+',
                label: 'peyv',
                turkishLabel: 'kelime',
                delay: 600,
              ),
              _StatBadge(
                value: '6',
                label: 'ast',
                turkishLabel: 'seviye',
                delay: 750,
              ),
              _StatBadge(
                value: '137',
                label: 'ders',
                turkishLabel: 'ders',
                delay: 900,
              ),
            ],
          ),

          const Spacer(flex: 2),

          // Başla butonu
          _PrimaryButton(
            label: 'Dest pê bike!',
            onPressed: onComplete,
          )
              .animate()
              .fadeIn(delay: 1000.ms, duration: 500.ms)
              .slideY(begin: 0.3, curve: Curves.easeOut),

          const Spacer(flex: 1),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// YARDIMCI WİDGET'LAR
// ════════════════════════════════════════════════════════════════

/// Hedef seçim kartı
class _GoalCard extends StatelessWidget {
  final String emoji;
  final int minutes;
  final String kurmanjLabel;
  final String turkishLabel;
  final bool isSelected;
  final VoidCallback onTap;

  const _GoalCard({
    required this.emoji,
    required this.minutes,
    required this.kurmanjLabel,
    required this.turkishLabel,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 250.ms,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primarySurface : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.borderLight,
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.12),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          children: [
            // Emoji
            Text(emoji, style: const TextStyle(fontSize: 32)),

            const SizedBox(width: 16),

            // Kurmancî + Türkçe
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kurmanjLabel,
                    style: AppTypography.kurmanjiCard.copyWith(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Consumer(
                    builder: (context, ref, _) {
                      if (!ref.watch(showTurkishProvider)) return const SizedBox.shrink();
                      return Text(
                        turkishLabel,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Seçim ikonu
            AnimatedContainer(
              duration: 200.ms,
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    isSelected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.borderMedium,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

/// İstatistik rozeti (Sayfa 3)
class _StatBadge extends StatelessWidget {
  final String value;
  final String label;
  final String turkishLabel;
  final int delay;

  const _StatBadge({
    required this.value,
    required this.label,
    required this.turkishLabel,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              value,
              style: AppTypography.xpCounter.copyWith(
                fontSize: 22,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        Consumer(
          builder: (context, ref, _) {
            if (!ref.watch(showTurkishProvider)) return const SizedBox.shrink();
            return Text(
              turkishLabel,
              style: AppTypography.caption.copyWith(fontSize: 11),
            );
          },
        ),
      ],
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: delay), duration: 400.ms)
        .slideY(begin: 0.3, curve: Curves.easeOut);
  }
}

/// Birincil CTA butonu
class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _PrimaryButton({
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.4),
          disabledForegroundColor: Colors.white.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: AppTypography.labelLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
