import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';
import '../../core/services/sound_service.dart';

// ════════════════════════════════════════════════════════════════
// STREAK MILESTONE HELPERS
//
// Egzersiz ekranlarında ardışık doğru cevap eşikleri (3/5/10)
// geçildiğinde çağrılır.
// Etkiler:
//   • Milestone sesi (SoundService.playStreakMilestone).
//   • Haptic lightImpact (hafif ekran hissi).
//   • SnackBar toast — kısa, engelleyici değil.
// ════════════════════════════════════════════════════════════════

void showStreakMilestone(
  BuildContext context,
  int streak, {
  bool isEnglish = false,
}) {
  SoundService.playStreakMilestone(streak);

  // Reduced motion saygısı: animasyonları kapatırsak haptic ve ses
  // yine çalışır (ses için ayrı mute var), ama shake atlanır.
  final reduceMotion = MediaQuery.of(context).disableAnimations;
  if (!reduceMotion) {
    HapticFeedback.lightImpact();
  }

  // Mesaj metinleri — track-aware (KU / EN).
  final Map<int, List<String>> messages = {
    3: [
      isEnglish ? '3 streak! Keep going!' : 'Rêzeke 3yan! Berdewam be!',
    ],
    5: [
      isEnglish ? '5 streak! You\'re on fire!' : 'Rêzeke 5an! Te pêxist!',
    ],
    10: [
      isEnglish ? '10 streak! Incredible!' : 'Rêzeke 10an! Gelek baş!',
    ],
  };
  final bucket = streak >= 10 ? 10 : (streak >= 5 ? 5 : 3);
  final text = messages[bucket]!.first;

  final messenger = ScaffoldMessenger.maybeOf(context);
  if (messenger == null) return;

  messenger.clearSnackBars();
  messenger.showSnackBar(
    SnackBar(
      backgroundColor: AppColors.accent,
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: bucket == 10 ? 2200 : 1600),
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('\u{1F525}', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
