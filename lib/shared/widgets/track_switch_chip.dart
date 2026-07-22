import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_router.dart';
import '../providers/learning_track_provider.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Hızlı Track Anahtarı (AppBar chip)
//
// Her ana sayfanın AppBar'ında küçük bir chip:
//   - Tek tık: Track seçim ekranına git
//   - Uzun bas: Aynı dilde kitleyi değiştir (yetişkin ↔ çocuk)
//
// Kullanıcı nerede olduğunu (hangi track) her an görür → karışmaz.
// ════════════════════════════════════════════════════════════════

class TrackSwitchChip extends ConsumerWidget {
  /// Chip'in rengi manuel belirlenebilir. Null ise track'e göre otomatik.
  final Color? foregroundColor;

  const TrackSwitchChip({super.key, this.foregroundColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final track = ref.watch(currentTrackProvider);
    final fg = foregroundColor ?? Colors.white;

    // "Karik" (oğlak) çocuk maskotu; "Mezin" yetişkin.
    // Tutarlılık: tüm UI'de child mod için "Karik" kullanılır.
    final audienceLabel = track.isChild ? 'Karik' : 'Mezin';
    final audienceEmoji = track.isChild ? '🐐' : '👤';

    return Tooltip(
      message:
          'Rêya te: ${track.labelKu}\nTik bike: rêya biguherîne\nDirêj bigire: mezin↔zarok',
      waitDuration: const Duration(milliseconds: 500),
      child: GestureDetector(
        onTap: () => context.push(AppRoutes.trackSelect),
        onLongPress: () async {
          ref.read(activeTrackProvider.notifier).switchAudience();
          await Future<void>.delayed(const Duration(milliseconds: 50));
          // currentTrackProvider güncel — native home'a götür
          if (!context.mounted) return;
          final newTrack = ref.read(currentTrackProvider);
          context.go(newTrack.nativeHomePath);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${newTrack.emoji} ${newTrack.labelKu} vekirî',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: fg.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: fg.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(track.emoji, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 4),
              Text(
                audienceEmoji,
                style: const TextStyle(fontSize: 10),
              ),
              const SizedBox(width: 4),
              Text(
                audienceLabel,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: fg,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.alt_route_rounded, size: 13, color: fg),
            ],
          ),
        ),
      ),
    );
  }
}
