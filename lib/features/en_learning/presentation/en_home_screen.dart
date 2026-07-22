import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/providers/learning_track_provider.dart';

/// LÛTKE — `/en/home` deep-link giriş noktası.
///
/// Davranış: track'i englishAdult'a senkronlar ve shell-backed `/home`'a
/// yönlendirir. Shell'in kalıcı bottom nav'ı (Learn/Words/Grammar/
/// Culture/Profile) artık İngilizce track'te de görünür olur.
/// Brief flash önlenmesi için branded splash (logo + çift dilli etiket) gösterilir.
///
/// INTEGRATION FIX (Nisan 2026 — EN audit):
///   1. Splash artık logo + çift dilli mesaj ("Tê barkirin · Loading")
///      içeriyor. Önceden yalnızca spinner vardı — kullanıcı "app mı
///      donmuş?" izlenimi alıyordu.
///   2. activeTrackProvider null-aware: SharedPreferences hâlâ yüklenmiyorsa
///      kısa bekleme. Yoksa varsayılan Kurmancî track flash'ı oluşuyordu.
class EnHomeScreen extends ConsumerStatefulWidget {
  const EnHomeScreen({super.key});

  @override
  ConsumerState<EnHomeScreen> createState() => _EnHomeScreenState();
}

class _EnHomeScreenState extends ConsumerState<EnHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      // Race-condition safety: activeTrackProvider null olabilir
      // (SharedPreferences asenkron yükleniyor). setTrack() atomik.
      final current = ref.read(activeTrackProvider);
      if (current != LearningTrack.englishAdult) {
        await ref
            .read(activeTrackProvider.notifier)
            .setTrack(LearningTrack.englishAdult);
      }
      if (!mounted) return;
      context.go(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    // A11Y: CircularProgressIndicator without label is read as just
    // "progress bar" by screen readers. Semantics(liveRegion, label)
    // gives dyslexic / blind users confirmation that content is loading.
    // Visual: branded splash = logo + bilingual message — prevents the
    // "frozen/flash" feel when the user deep-links /en/home.
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Center(
          child: Semantics(
            label: 'Tê barkirin — English track · Loading',
            liveRegion: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🌍', style: TextStyle(fontSize: 48)),
                const SizedBox(height: 12),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  semanticsLabel: 'Loading English track',
                ),
                const SizedBox(height: 16),
                Text(
                  'Tê barkirin…',
                  style: AppTypography.body.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Loading English track',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
