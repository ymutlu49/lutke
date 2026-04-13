import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';
import '../constants/app_spacing.dart';

// ════════════════════════════════════════════════════════════════
// BAĞLANTI DURUMU
// Çevrimdışı öncelikli mimari — uygulama internet olmadan da çalışır
// ════════════════════════════════════════════════════════════════

enum ConnectionStatus { online, offline, unknown }

class ConnectivityNotifier extends StateNotifier<ConnectionStatus> {
  StreamSubscription<List<ConnectivityResult>>? _sub;

  ConnectivityNotifier() : super(ConnectionStatus.unknown) {
    _init();
  }

  Future<void> _init() async {
    final result = await Connectivity().checkConnectivity();
    state = _fromResult(result);

    _sub = Connectivity().onConnectivityChanged.listen((results) {
      state = _fromResult(results);
    });
  }

  ConnectionStatus _fromResult(List<ConnectivityResult> results) {
    if (results.isEmpty || results.contains(ConnectivityResult.none)) {
      return ConnectionStatus.offline;
    }
    return ConnectionStatus.online;
  }

  bool get isOnline => state == ConnectionStatus.online;

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

final connectivityProvider =
    StateNotifierProvider<ConnectivityNotifier, ConnectionStatus>(
  (ref) => ConnectivityNotifier(),
);

final isOnlineProvider = Provider<bool>((ref) {
  return ref.watch(connectivityProvider) == ConnectionStatus.online;
});

// ════════════════════════════════════════════════════════════════
// ÇEVRİMDIŞI BANNER WİDGET'I
// ════════════════════════════════════════════════════════════════

class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(isOnlineProvider);

    return AnimatedSlide(
      offset: isOnline ? const Offset(0, -1) : Offset.zero,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: AnimatedOpacity(
        opacity: isOnline ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          color: AppColors.warning,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 14, color: Colors.white),
              Gap.hXs,
              Text(
                'Bê girêdan — ders berdewam dikin',
                style: AppTypography.captionStrong.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
