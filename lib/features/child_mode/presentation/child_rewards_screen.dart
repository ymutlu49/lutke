import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/child_theme.dart';
import '../../../shared/widgets/empty_state.dart';
import '../domain/child_daily_challenge.dart';
import '../domain/bizer_evolution.dart';
import '../../gamification/gamification_provider.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Ödül Sandığı Ekranı
//
// Kullanıcının kazandığı kapanmamış sandıkları görüntüler.
// Sandık açma animasyonu + yıldız ödülü.
// ════════════════════════════════════════════════════════════════

class ChildRewardsScreen extends ConsumerStatefulWidget {
  const ChildRewardsScreen({super.key});

  @override
  ConsumerState<ChildRewardsScreen> createState() => _ChildRewardsScreenState();
}

class _ChildRewardsScreenState extends ConsumerState<ChildRewardsScreen>
    with TickerProviderStateMixin {
  bool _opening = false;
  int? _lastReward;

  @override
  Widget build(BuildContext context) {
    final chestsAsync = ref.watch(unopenedChestsProvider);

    return Scaffold(
      backgroundColor: ChildColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            _appBar(context),
            Expanded(
              child: chestsAsync.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => ErrorRetryView(
                  messageKu: ErrorRetryView.friendlyMessage(e),
                  onRetry: () => ref.invalidate(unopenedChestsProvider),
                ),
                data: (count) =>
                    count == 0 ? _emptyState() : _chestView(count),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded, size: 28),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              }
            },
          ),
          const SizedBox(width: 8),
          Text(
            'Sandiqên Xelatê',
            style: ChildTypography.headline.copyWith(
              color: ChildColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '📭',
              style: TextStyle(fontSize: 84),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .moveY(begin: 0, end: -8, duration: 1400.ms),
            const SizedBox(height: 16),
            Text(
              'Niha sandiqek nîne',
              style: ChildTypography.title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Her 3 erkên rojane biqedîne, dê sandiqekê bistînî!',
              style: ChildTypography.body.copyWith(
                color: ChildColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _chestView(int count) {
    if (_lastReward != null) {
      return _rewardDisplay(_lastReward!);
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Te $count sandiq heye!',
            style: ChildTypography.title,
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: _opening ? null : _openChest,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 300),
              scale: _opening ? 1.2 : 1.0,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      ChildColors.accent.withOpacity(0.3),
                      ChildColors.accent.withOpacity(0.05),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ChildColors.accent.withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    _opening ? '✨' : '🎁',
                    style: const TextStyle(fontSize: 108),
                  ),
                )
                    .animate(
                      onPlay: (c) => _opening ? c.forward() : c.repeat(reverse: true),
                    )
                    .moveY(begin: 0, end: -6, duration: 900.ms),
              ),
            ),
          ),
          const SizedBox(height: 28),
          ElevatedButton.icon(
            onPressed: _opening ? null : _openChest,
            icon: const Icon(Icons.auto_awesome),
            label: Text(
              _opening ? 'Sandiq vedibe...' : 'Sandiqê Veke!',
              style: ChildTypography.label.copyWith(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: ChildColors.accent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                  horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rewardDisplay(int reward) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '⭐',
            style: TextStyle(fontSize: 120),
          ).animate()
              .scale(begin: const Offset(0, 0), end: const Offset(1, 1), duration: 500.ms, curve: Curves.elasticOut)
              .then()
              .shake(duration: 500.ms, hz: 3),
          const SizedBox(height: 16),
          Text(
            'Pîroz be!',
            style: ChildTypography.headline.copyWith(
              color: ChildColors.accent,
              fontSize: 32,
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ChildColors.accent.withOpacity(0.2),
                  ChildColors.accent.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Te $reward stêrk qezenc kir!',
              style: ChildTypography.title.copyWith(
                color: ChildColors.accent,
                fontSize: 22,
              ),
            ),
          ).animate().fadeIn(delay: 700.ms),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => setState(() => _lastReward = null),
            icon: const Icon(Icons.redo_rounded),
            label: Text(
              'Vegere',
              style: ChildTypography.label.copyWith(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: ChildColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ).animate().fadeIn(delay: 1000.ms),
        ],
      ),
    );
  }

  Future<void> _openChest() async {
    setState(() => _opening = true);
    await Future.delayed(const Duration(milliseconds: 800));
    final reward = await ChildDailyChallengeService.openChest();
    // Ryan-Deci (1985 CET): makul aralık (25-45 yıldız) — büyük random
    // ödüller intrinsic motivasyonu aşındırıyor.
    final finalReward = reward == 0 ? 25 + Random().nextInt(21) : reward;
    // ── GAMIFICATION CANLI VERİ ──────────────────────────
    // Sandık ödülünü gerçek XP + Karîk'e yıldız olarak yansıt
    if (finalReward > 0) {
      ref.read(gamificationProvider.notifier).addXP(finalReward);
      // Yıldız = XP/5 yaklaşık (Karîk evolution için)
      ref.read(karikEvolutionProvider.notifier).addStars(finalReward ~/ 5);
    }
    if (!mounted) return;
    setState(() {
      _opening = false;
      _lastReward = finalReward;
    });
    // Provider'ı yenile
    // ignore: unused_result
    ref.refresh(unopenedChestsProvider);
  }
}
