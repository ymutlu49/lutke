import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../features/gamification/gamification_provider.dart';
import '../providers/streak_provider.dart';

// ════════════════════════════════════════════════════════════════
// PERSISTENT XP BADGE
//
// Egzersiz ekranlarında sürekli görünen kompakt pill.
// İçerik: 🔥 streak count + ⭐ günün XP'si.
//
// Animasyon: XP değiştiğinde scale pulse (sadece bu değere).
// `MediaQuery.disableAnimations` aktifse animasyon atlanır.
// ════════════════════════════════════════════════════════════════

class PersistentXpBadge extends ConsumerStatefulWidget {
  /// Sadece streak göster (XP gizli) — kompakt alanlar için.
  final bool hideXp;
  final bool hideStreak;
  final EdgeInsetsGeometry? padding;

  const PersistentXpBadge({
    super.key,
    this.hideXp = false,
    this.hideStreak = false,
    this.padding,
  });

  @override
  ConsumerState<PersistentXpBadge> createState() => _PersistentXpBadgeState();
}

class _PersistentXpBadgeState extends ConsumerState<PersistentXpBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseCtrl;
  late final Animation<double> _pulseScale;
  int _lastXp = -1;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _pulseScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.18), weight: 45),
      TweenSequenceItem(tween: Tween(begin: 1.18, end: 1.0), weight: 55),
    ]).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Streak — streakProvider.streakDays (live kaynak).
    final streakDays = ref.watch(streakProvider.select((s) => s.streakDays));
    // Gün XP'si — streak provider'da tutuluyor. Gamification totalXP yerine
    // bugünün XP'si daha motive edici.
    final todayXp = ref.watch(streakProvider.select((s) => s.todayXP));

    // XP değiştiğinde bir kez pulse tetikle (sadece artış).
    if (_lastXp >= 0 && todayXp > _lastXp) {
      final disableAnim = MediaQuery.of(context).disableAnimations;
      if (!disableAnim) {
        _pulseCtrl.forward(from: 0.0);
      }
    }
    _lastXp = todayXp;

    // Fallback: streak yoksa gamification.numericLevel göster.
    final gamiLevel = ref.watch(
      gamificationProvider.select((g) => g.numericLevel),
    );

    return Container(
      padding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.borderLight.withValues(alpha: 0.6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!widget.hideStreak) ...[
            _StreakChip(days: streakDays),
            if (!widget.hideXp) const SizedBox(width: 8),
          ],
          if (!widget.hideXp)
            ScaleTransition(
              scale: _pulseScale,
              child: _XpChip(xp: todayXp, levelFallback: gamiLevel),
            ),
        ],
      ),
    );
  }
}

class _StreakChip extends StatelessWidget {
  final int days;
  const _StreakChip({required this.days});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('\u{1F525}', style: TextStyle(fontSize: 14)),
        const SizedBox(width: 3),
        Text(
          '$days',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.accent,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}

class _XpChip extends StatelessWidget {
  final int xp;
  final int levelFallback;
  const _XpChip({required this.xp, required this.levelFallback});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star_rounded,
          size: 14,
          color: Colors.amber.shade700,
        ),
        const SizedBox(width: 3),
        Text(
          xp > 0 ? '$xp' : 'Lv$levelFallback',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.accent,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}
