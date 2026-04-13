import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/child_theme.dart';
import '../../domain/time_limit_service.dart';
import '../time_up_screen.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Çocuk Modu Sarmalayıcı
//
// Tüm çocuk ekranlarını sarar:
//   - Oturum süresini takip eder
//   - Kalan süre göstergesi (yumuşak saat)
//   - 5 dk uyarısı
//   - Süre dolduğunda TimeUpScreen'e yönlendirir
//   - Geri tuşunu engeller (çocuğun kazara çıkmasını önler)
// ════════════════════════════════════════════════════════════════

class ChildModeWrapper extends ConsumerStatefulWidget {
  final Widget child;

  const ChildModeWrapper({super.key, required this.child});

  @override
  ConsumerState<ChildModeWrapper> createState() => _ChildModeWrapperState();
}

class _ChildModeWrapperState extends ConsumerState<ChildModeWrapper>
    with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Oturumu başlat
    Future.microtask(() {
      ref.read(timeLimitProvider.notifier).startSession();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final notifier = ref.read(timeLimitProvider.notifier);
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      notifier.stopSession();
    } else if (state == AppLifecycleState.resumed) {
      notifier.startSession();
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeState = ref.watch(timeLimitProvider);

    // Süre dolduysa TimeUpScreen göster
    if (timeState.isExpired) {
      return const TimeUpScreen();
    }

    return PopScope(
      // Geri tuşunu engelle
      canPop: false,
      child: Stack(
        children: [
          widget.child,

          // Kalan süre göstergesi (sağ üst)
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            right: 16,
            child: _TimeIndicator(
              remainingMinutes: timeState.remainingMinutes,
              isWarning: timeState.isWarning,
            ),
          ),

          // 5 dk uyarı banner'ı
          if (timeState.isWarning)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _WarningBanner(
                remainingMinutes: timeState.remainingMinutes,
              ),
            ),
        ],
      ),
    );
  }
}

/// Kalan süre göstergesi — küçük, dikkat dağıtmayan.
class _TimeIndicator extends StatelessWidget {
  final int remainingMinutes;
  final bool isWarning;

  const _TimeIndicator({
    required this.remainingMinutes,
    required this.isWarning,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isWarning
            ? ChildColors.encourage.withOpacity(0.15)
            : ChildColors.primarySurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isWarning
              ? ChildColors.encourage.withOpacity(0.4)
              : ChildColors.primary.withOpacity(0.15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer_outlined,
            size: 14,
            color: isWarning ? ChildColors.encourage : ChildColors.primary,
          ),
          const SizedBox(width: 4),
          Text(
            '$remainingMinutes dk',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isWarning ? ChildColors.encourage : ChildColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

/// 5 dakika kala uyarı banner'ı.
class _WarningBanner extends StatelessWidget {
  final int remainingMinutes;

  const _WarningBanner({required this.remainingMinutes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: ChildColors.encourage.withOpacity(0.95),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            const Text('🐐', style: TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '$remainingMinutes deqîqe ma! Bizer jî westiya ye.',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().slideY(begin: 1, curve: Curves.easeOut, duration: 400.ms);
  }
}
