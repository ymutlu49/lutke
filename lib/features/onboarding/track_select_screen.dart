import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/router/app_router.dart';
import '../../shared/providers/learning_track_provider.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Track Seçim Ekranı
//
// 4 öğrenme yolu arasında seçim yapan TEK ekran.
//
// Karışma riskini sıfırlar: Her track'in kendi rengi, emojisi, kartı,
// mesajı ve hedef ekranı var. Seçim activeTrackProvider'a yazılır,
// eski provider'lar otomatik senkronlanır.
// ════════════════════════════════════════════════════════════════

class TrackSelectScreen extends ConsumerWidget {
  const TrackSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTrack = ref.watch(activeTrackProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  // UX FIX #3: Kaçış kolu. Önceden hiç "geri" yoktu —
                  // kullanıcı fikrini değiştirirse yapabilir hiçbir şey yoktu.
                  // canPop varsa geri, yoksa splash'a (fallback döngü yok).
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: AppSpacing.touchMin,
                      height: AppSpacing.touchMin,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        tooltip: 'Vegere',
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go(AppRoutes.splash);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ClipOval(
                    child: Container(
                      width: 72,
                      height: 72,
                      color: Colors.white,
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/images/logo_512.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'LÛTKE',
                    style: AppTypography.display.copyWith(
                      color: AppColors.primary,
                      fontSize: 28,
                    ),
                  ).animate().fadeIn(),
                  const SizedBox(height: 6),
                  Text(
                    'Rêya xwe hilbijêre',
                    style: AppTypography.title.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ).animate().fadeIn(delay: 150.ms),
                  const SizedBox(height: 4),
                  Text(
                    'Tu dikarî her gav biguherînî.',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 250.ms),
                  const SizedBox(height: 32),

                  // 2x2 grid — kompakt, minimal aesthetic
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.95,
                      children: [
                        _TrackCard(
                          track: LearningTrack.kurdishAdult,
                          isSelected:
                              currentTrack == LearningTrack.kurdishAdult,
                          gradient: [
                            AppColors.primary,
                            AppColors.primary.withOpacity(0.7),
                          ],
                          audienceLabel: 'Ji bo mezinan',
                          delayMs: 300,
                          onTap: () => _selectTrack(
                            context,
                            ref,
                            LearningTrack.kurdishAdult,
                          ),
                        ),
                        _TrackCard(
                          track: LearningTrack.kurdishChild,
                          isSelected:
                              currentTrack == LearningTrack.kurdishChild,
                          gradient: const [
                            Color(0xFFF5A623),
                            Color(0xFFE89200),
                          ],
                          audienceLabel: 'Ji bo zarokan',
                          delayMs: 400,
                          onTap: () => _selectTrack(
                            context,
                            ref,
                            LearningTrack.kurdishChild,
                          ),
                        ),
                        _TrackCard(
                          track: LearningTrack.englishAdult,
                          isSelected:
                              currentTrack == LearningTrack.englishAdult,
                          gradient: const [
                            Color(0xFF1E88E5),
                            Color(0xFF1565C0),
                          ],
                          audienceLabel: 'Ji bo mezinan',
                          delayMs: 500,
                          onTap: () => _selectTrack(
                            context,
                            ref,
                            LearningTrack.englishAdult,
                          ),
                        ),
                        _TrackCard(
                          track: LearningTrack.englishChild,
                          isSelected:
                              currentTrack == LearningTrack.englishChild,
                          gradient: const [
                            Color(0xFFAB47BC),
                            Color(0xFF6A1B9A),
                          ],
                          audienceLabel: 'Ji bo zarokan',
                          delayMs: 600,
                          onTap: () => _selectTrack(
                            context,
                            ref,
                            LearningTrack.englishChild,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Ji Profîl › Sazkirin her gav dikarî biguherînî.',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textTertiary,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 800.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectTrack(
    BuildContext context,
    WidgetRef ref,
    LearningTrack track,
  ) async {
    await ref.read(activeTrackProvider.notifier).setTrack(track);
    if (!context.mounted) return;

    // Kurmancî çocuk için onboarding gerekiyor mu kontrol et.
    // (Çocuk modunda placement testi hîç nayê pêşandan — yaşa uygun değil.)
    if (track == LearningTrack.kurdishChild) {
      final prefs = await SharedPreferences.getInstance();
      final done = prefs.getBool('child_onboarding_complete') ?? false;
      if (!done) {
        if (context.mounted) context.go(AppRoutes.childOnboarding);
        return;
      }
    }

    // GÖNÜLLÜ TEST (Ekim 2026): yol seçiminden sonra doğrudan ana ekrana.
    // Mayıs 2026 akışı düzey testi yapmamış kullanıcıyı burada teste
    // gönderiyordu (zorunlu). Artık düzey testi isteğe bağlı: kullanıcı A1'den
    // başlar, düzeyini seçiciden kendisi değiştirebilir ya da testi ana
    // ekrandaki davetten / düzey seçicisinden / profilden kendi isteğiyle açar.
    context.go(track.nativeHomePath);
  }
}

// ── Track Kartı ─────────────────────────────────────────────────

class _TrackCard extends StatelessWidget {
  final LearningTrack track;
  final bool isSelected;
  final List<Color> gradient;
  final String audienceLabel;
  final int delayMs;
  final VoidCallback onTap;

  const _TrackCard({
    required this.track,
    required this.isSelected,
    required this.gradient,
    required this.audienceLabel,
    required this.delayMs,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Sade isim: yalnız "Pezkovî" (yetişkin) veya "Karîk" (çocuk).
    // Tekrar yok — "ji bo X" zaten üst-sağ rozette mevcut.
    final mascotName = track.isChild ? 'Karîk' : 'Pezkovî';

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          border: isSelected
              ? Border.all(color: Colors.white, width: 2.5)
              : null,
          boxShadow: [
            BoxShadow(
              color: gradient.first.withOpacity(0.28),
              blurRadius: isSelected ? 16 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(11, 9, 11, 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üst rozetler — kompakt
            Row(
              children: [
                if (isSelected)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 1.5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      '✓',
                      style: TextStyle(
                        fontSize: 8.5,
                        fontWeight: FontWeight.w900,
                        color: gradient.first,
                      ),
                    ),
                  ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.22),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    audienceLabel,
                    style: const TextStyle(
                      fontSize: 8.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Maskot görseli — kompakt
            Center(
              child: SizedBox(
                width: 52,
                height: 52,
                child: Image.asset(
                  track.isChild
                      ? 'assets/images/mascot_128.png'
                      : 'assets/images/logo_128.png',
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.medium,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              track.labelKu,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.15,
                letterSpacing: 0.1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 1),
            Text(
              mascotName,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withOpacity(0.82),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white.withOpacity(0.9),
                size: 17,
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: delayMs), duration: 400.ms)
        .slideY(begin: 0.1, end: 0);
  }
}
