import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/entities/lesson.dart';

// ════════════════════════════════════════════════════════════════
// DERS TAMAMLAMA EKRANI — LÛTKE
//
// İlke §4: Kutlayıcı, destekleyici ton
// İlke §5.4: "Tebrikler" yerine "Bu dilin tohumları sende vardı"
// İlke §7.1: Kültürel ödül gösterimi
// ════════════════════════════════════════════════════════════════

class LessonCompletionOverlay extends StatelessWidget {
  final LessonSessionState session;
  final String? motivationAnchor;
  final VoidCallback onContinue;
  final VoidCallback? onRetry;

  const LessonCompletionOverlay({
    super.key,
    required this.session,
    this.motivationAnchor,
    required this.onContinue,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundPrimary.withOpacity(0.95),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Kutlama ikonu
              _CelebrationIcon(isPerfect: session.accuracy == 1.0),

              const SizedBox(height: AppSpacing.xl),

              // Kurmancî kutlama mesajı — büyük, birincil (İlke §0.5)
              Text(
                session.accuracy >= 0.9
                    ? 'Gelek baş!'
                    : session.accuracy >= 0.7
                        ? 'Baş e!'
                        : 'Berdewam bike!',
                style: AppTypography.displayMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Türkçe — küçük, ikincil
              Text(
                session.accuracy >= 0.9
                    ? 'Gelek baş!'
                    : session.accuracy >= 0.7
                        ? 'Tu baş diçî!'
                        : 'Berdewam bike!',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.xl),

              // İstatistikler
              _StatsRow(
                correct: session.correctCount,
                total: session.totalExercises,
                xp: session.earnedXP,
                duration: session.elapsed,
              ),

              const SizedBox(height: AppSpacing.lg),

              // Motivasyon çapası mesajı (İlke §2.1)
              if (motivationAnchor != null) ...[
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$motivationAnchor ji te serbilind e!',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],

              const Spacer(),

              // Devam butonu
              ElevatedButton(
                onPressed: onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Dûv re',
                  style: AppTypography.labelLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),

              // Tekrar çöz butonu
              if (onRetry != null && session.accuracy < 1.0) ...[
                const SizedBox(height: AppSpacing.sm),
                TextButton(
                  onPressed: onRetry,
                  child: Text(
                    'Dîsa bicerib',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}

// ── Kutlama İkonu ──────────────────────────────────────────

class _CelebrationIcon extends StatelessWidget {
  final bool isPerfect;
  const _CelebrationIcon({required this.isPerfect});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, height: 100,
      decoration: BoxDecoration(
        color: isPerfect
            ? const Color(0xFFD4783A).withOpacity(0.1)
            : AppColors.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isPerfect ? Icons.stars_rounded : Icons.celebration_rounded,
        size: 52,
        color: isPerfect ? const Color(0xFFD4783A) : AppColors.primary,
      ),
    ).animate()
        .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1),
            duration: 600.ms, curve: Curves.elasticOut)
        .then()
        .shimmer(duration: 800.ms, color: Colors.white24);
  }
}

// ── İstatistik Satırı ──────────────────────────────────────

class _StatsRow extends StatelessWidget {
  final int correct;
  final int total;
  final int xp;
  final Duration duration;

  const _StatsRow({
    required this.correct,
    required this.total,
    required this.xp,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _statItem(
          icon: Icons.check_circle_outline,
          value: '$correct/$total',
          label: 'Rast',
          color: const Color(0xFF4CAF50),
        ),
        _statItem(
          icon: Icons.bolt_rounded,
          value: '+$xp',
          label: 'XP',
          color: const Color(0xFFD4783A),
        ),
        _statItem(
          icon: Icons.timer_outlined,
          value: _formatDuration(duration),
          label: 'Dem',
          color: AppColors.primary,
        ),
      ],
    );
  }

  Widget _statItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: color,
        )),
        Text(label, style: TextStyle(
          fontSize: 11,
          color: AppColors.textSecondary,
        )),
      ],
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0);
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    return '${m}d ${s}s';
  }
}
