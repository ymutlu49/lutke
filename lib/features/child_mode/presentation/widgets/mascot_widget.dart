import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/child_theme.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Maskot Widget (Karok 🐐)
//
// Animasyonlu maskot durumları:
//   - idle: Nazik zıplama
//   - happy: Zıplama + yıldız (doğru cevap)
//   - encourage: Baş eğme (yanlış cevap)
//   - celebrate: Dans (ders tamamlama)
//   - wave: El sallama (uygulama açılışı)
//   - sleepy: Uyku (süre doldu)
// ════════════════════════════════════════════════════════════════

enum MascotState { idle, happy, encourage, celebrate, wave, sleepy }

class MascotWidget extends StatelessWidget {
  final MascotState state;
  final double size;
  final String? message;

  const MascotWidget({
    super.key,
    this.state = MascotState.idle,
    this.size = 80,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: _buildMascot(),
        ),
        if (message != null) ...[
          const SizedBox(height: 8),
          _SpeechBubble(message: message!),
        ],
      ],
    );
  }

  Widget _buildMascot() {
    final emoji = switch (state) {
      MascotState.sleepy => '😴',
      _ => '🐐',
    };

    final mascot = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: ChildColors.primarySurface,
        shape: BoxShape.circle,
        border: Border.all(
          color: _borderColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: _borderColor.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(emoji, style: TextStyle(fontSize: size * 0.5)),
      ),
    );

    return switch (state) {
      MascotState.idle => mascot
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .moveY(begin: 0, end: -4, duration: 1200.ms),

      MascotState.happy => Stack(
          clipBehavior: Clip.none,
          children: [
            mascot
                .animate()
                .moveY(begin: 0, end: -20, duration: 300.ms,
                    curve: Curves.easeOut)
                .then()
                .moveY(begin: -20, end: 0, duration: 300.ms,
                    curve: Curves.bounceOut),
            // Yıldız parçacıkları
            Positioned(
              top: -8,
              right: -4,
              child: const Text('⭐', style: TextStyle(fontSize: 20))
                  .animate()
                  .fadeIn(delay: 200.ms)
                  .moveY(begin: 0, end: -16, duration: 600.ms)
                  .fadeOut(delay: 400.ms),
            ),
            Positioned(
              top: -4,
              left: -4,
              child: const Text('✨', style: TextStyle(fontSize: 16))
                  .animate()
                  .fadeIn(delay: 300.ms)
                  .moveY(begin: 0, end: -12, duration: 500.ms)
                  .fadeOut(delay: 300.ms),
            ),
          ],
        ),

      MascotState.encourage => mascot
          .animate()
          .rotate(begin: 0, end: -0.05, duration: 300.ms)
          .then()
          .rotate(begin: -0.05, end: 0.05, duration: 300.ms)
          .then()
          .rotate(begin: 0.05, end: 0, duration: 300.ms),

      MascotState.celebrate => Stack(
          clipBehavior: Clip.none,
          children: [
            mascot
                .animate()
                .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1),
                    duration: 200.ms)
                .then()
                .scale(end: const Offset(1, 1), duration: 200.ms)
                .then()
                .moveY(begin: 0, end: -24, duration: 300.ms)
                .then()
                .moveY(begin: -24, end: 0, duration: 400.ms,
                    curve: Curves.bounceOut),
            // Konfeti
            for (var i = 0; i < 5; i++)
              Positioned(
                top: -10 + (i * 6).toDouble(),
                left: -10 + (i * 18).toDouble(),
                child: Text(
                  ['🎉', '⭐', '🌟', '✨', '🎊'][i],
                  style: const TextStyle(fontSize: 16),
                )
                    .animate(delay: (200 + i * 100).ms)
                    .fadeIn()
                    .moveY(begin: 0, end: -(20 + i * 8).toDouble(),
                        duration: 800.ms)
                    .fadeOut(delay: 500.ms),
              ),
          ],
        ),

      MascotState.wave => mascot
          .animate()
          .scale(begin: const Offset(0.5, 0.5), curve: Curves.elasticOut,
              duration: 800.ms),

      MascotState.sleepy => mascot
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scale(begin: const Offset(1, 1), end: const Offset(1.03, 1.03),
              duration: 2000.ms),
    };
  }

  Color get _borderColor => switch (state) {
    MascotState.happy || MascotState.celebrate => ChildColors.starYellow,
    MascotState.encourage => ChildColors.encourage,
    MascotState.sleepy => ChildColors.textSecondary,
    _ => ChildColors.primary,
  };
}

/// Konuşma balonu — maskotun mesajını gösterir.
class _SpeechBubble extends StatelessWidget {
  final String message;

  const _SpeechBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ChildColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ChildColors.primary.withOpacity(0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        message,
        style: ChildTypography.body.copyWith(
          color: ChildColors.primary,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1);
  }
}
