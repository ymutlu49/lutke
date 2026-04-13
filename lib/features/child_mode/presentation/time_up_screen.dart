import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/child_theme.dart';
import '../../../shared/providers/child_mode_provider.dart';
import 'widgets/pin_entry_widget.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Süre Doldu Ekranı
//
// Günlük süre limiti aşıldığında gösterilir.
// Çocuk dostu tasarım — maskot veda eder.
// PIN olmadan geçilemez (ebeveyn kontrolü).
// ════════════════════════════════════════════════════════════════

class TimeUpScreen extends StatelessWidget {
  const TimeUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChildColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Maskot veda
              const Text('🐐', style: TextStyle(fontSize: 80))
                  .animate()
                  .fadeIn()
                  .then()
                  .moveY(begin: 0, end: -10, duration: 500.ms)
                  .then()
                  .moveY(begin: -10, end: 0, duration: 500.ms),

              const SizedBox(height: 24),

              // Ay ikonu
              const Text('🌙', style: TextStyle(fontSize: 48))
                  .animate()
                  .fadeIn(delay: 400.ms)
                  .scale(begin: const Offset(0.5, 0.5)),

              const SizedBox(height: 24),

              Text(
                'Dema te ya îro qediya!',
                style: ChildTypography.display.copyWith(
                  color: ChildColors.primary,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 600.ms),

              const SizedBox(height: 12),

              Text(
                'Karok jî razê.\nSibê em dîsa bilîzin!',
                style: ChildTypography.bodyLarge.copyWith(
                  color: ChildColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 800.ms),

              const Spacer(flex: 2),

              // Yıldız özeti
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ChildColors.starYellow.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
                  border: Border.all(
                    color: ChildColors.starYellow.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('⭐', style: TextStyle(fontSize: 28)),
                    const SizedBox(width: 8),
                    Text(
                      'Îro te baş xebitî!',
                      style: ChildTypography.title.copyWith(
                        color: ChildColors.accent,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 1000.ms),

              const Spacer(),

              // Ebeveyn erişimi
              TextButton.icon(
                onPressed: () => _showParentPinDialog(context),
                icon: const Icon(Icons.lock_outline_rounded, size: 18),
                label: Text(
                  'Dê û bav',
                  style: TextStyle(
                    fontSize: 13,
                    color: ChildColors.textSecondary.withOpacity(0.6),
                  ),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: ChildColors.textSecondary.withOpacity(0.6),
                ),
              ).animate().fadeIn(delay: 1200.ms),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _showParentPinDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_rounded,
                  size: 48, color: ChildColors.primary),
              const SizedBox(height: 16),
              Text('Ebeveyn PIN\'i girin', style: ChildTypography.title),
              const SizedBox(height: 8),
              Text(
                'Süre limitini uzatmak veya modu değiştirmek için',
                style: ChildTypography.caption,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              PinEntryWidget(
                onComplete: (pin) {
                  // TODO: PIN doğrulama + süre uzatma / mod değiştirme
                  Navigator.of(ctx).pop();
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('İptal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
