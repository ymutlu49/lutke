import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/child_theme.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/providers/child_mode_provider.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Çocuk Onboarding
//
// 2 adımlı basit akış:
//   1. Yaş seçimi (7, 8, 9, 10)
//   2. Maskot karşılama ("Karik")
//
// NOT (Nisan 2026): Ebeveyn PIN adımı kaldırıldı — LÛTKE bir dil
// öğrenme uygulaması; kısıtlama aracı değil.
// ════════════════════════════════════════════════════════════════

class ChildOnboardingScreen extends ConsumerStatefulWidget {
  const ChildOnboardingScreen({super.key});

  @override
  ConsumerState<ChildOnboardingScreen> createState() =>
      _ChildOnboardingScreenState();
}

class _ChildOnboardingScreenState
    extends ConsumerState<ChildOnboardingScreen> {
  int _step = 0;
  int? _selectedAge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChildColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: switch (_step) {
              0 => _AgeStep(
                  key: const ValueKey(0),
                  selectedAge: _selectedAge,
                  onSelect: (age) {
                    setState(() {
                      _selectedAge = age;
                      _step = 1;
                    });
                  },
                ),
              _ => _MascotWelcome(
                  key: const ValueKey(1),
                  onStart: () => _completeOnboarding(),
                ),
            },
          ),
        ),
      ),
    );
  }

  Future<void> _completeOnboarding() async {
    // Child mode'u aktif et
    await ref.read(isChildModeProvider.notifier).setChildMode(true);

    // SharedPreferences'a kaydet
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('child_age', _selectedAge ?? 8);
    await prefs.setBool('child_onboarding_complete', true);

    if (mounted) {
      context.go(AppRoutes.childHome);
    }
  }
}

// ── Adım 1: Yaş Seçimi ─────────────────────────────────────

class _AgeStep extends StatelessWidget {
  final int? selectedAge;
  final ValueChanged<int> onSelect;

  const _AgeStep({super.key, this.selectedAge, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),

        // Maskot
        const Text('🐐', style: TextStyle(fontSize: 72))
            .animate()
            .scale(begin: const Offset(0.5, 0.5), curve: Curves.elasticOut,
                duration: 800.ms),

        const SizedBox(height: 24),

        Text(
          'Silav! Ez Karik im!',
          style: ChildTypography.display.copyWith(color: ChildColors.primary),
        ).animate().fadeIn(delay: 300.ms),

        const SizedBox(height: 8),

        Text(
          'Tu çend salî yî?',
          style: ChildTypography.title.copyWith(
            color: ChildColors.textSecondary,
          ),
        ).animate().fadeIn(delay: 500.ms),

        const Spacer(),

        // Yaş butonları
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [7, 8, 9, 10].map((age) {
            return _AgeButton(
              age: age,
              isSelected: selectedAge == age,
              onTap: () => onSelect(age),
            );
          }).toList(),
        ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2),

        const Spacer(flex: 2),
      ],
    );
  }
}

class _AgeButton extends StatelessWidget {
  final int age;
  final bool isSelected;
  final VoidCallback onTap;

  const _AgeButton({
    required this.age,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: isSelected
              ? ChildColors.primary
              : ChildColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
          border: Border.all(
            color: isSelected
                ? ChildColors.primary
                : ChildColors.primary.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: ChildColors.primary.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            '$age',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: isSelected
                  ? ChildColors.textOnPrimary
                  : ChildColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Adım 2: Maskot Karşılama ────────────────────────────────

class _MascotWelcome extends StatelessWidget {
  final VoidCallback onStart;

  const _MascotWelcome({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),

        // Büyük maskot
        const Text('🐐', style: TextStyle(fontSize: 96))
            .animate()
            .scale(
                begin: const Offset(0.3, 0.3),
                curve: Curves.elasticOut,
                duration: 1000.ms),

        const SizedBox(height: 24),

        Text(
          'Karik amade ye!',
          style: ChildTypography.display.copyWith(color: ChildColors.primary),
        ).animate().fadeIn(delay: 400.ms),

        const SizedBox(height: 8),

        Text(
          'Em bi hev re Kurmancî fêr bibin!',
          style: ChildTypography.bodyLarge.copyWith(
            color: ChildColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 600.ms),

        const Spacer(),

        // Yıldızlar
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < 3; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: const Icon(
                  Icons.star_rounded,
                  size: 40,
                  color: ChildColors.starYellow,
                ).animate(delay: (800 + i * 200).ms)
                    .scale(begin: const Offset(0, 0), curve: Curves.elasticOut,
                        duration: 600.ms),
              ),
          ],
        ),

        const Spacer(),

        SizedBox(
          width: double.infinity,
          height: ChildSpacing.touchPreferred,
          child: ElevatedButton.icon(
            onPressed: onStart,
            icon: const Icon(Icons.play_arrow_rounded, size: 28),
            label: Text(
              'Dest pê bike!',
              style: ChildTypography.labelLarge.copyWith(
                color: ChildColors.textOnPrimary,
              ),
            ),
          ),
        ).animate().fadeIn(delay: 1200.ms).slideY(begin: 0.2),

        const Spacer(flex: 1),
      ],
    );
  }
}
