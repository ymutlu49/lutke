import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_spacing.dart';

// ════════════════════════════════════════════════════════════════
// HAFTALIK RİTİM KARTI — LÛTKE
//
// İlke §4.2: Günlük seri yerine haftalık ritim modeli
//   - 7 günde en az 4 gün → "Bu hafta aktiftin" ödülü
//   - Kaçırılan gün: suçlama yok, sadece hafta özeti
//   - Motivasyon çapası ile kişiselleştirilmiş bildirim
// ════════════════════════════════════════════════════════════════

class WeeklyRhythmCard extends StatelessWidget {
  final List<bool> activeDays; // 7 eleman, Pazartesi'den başlar
  final int weekStreak;
  final String? motivationAnchor; // "Fatma" gibi isim

  const WeeklyRhythmCard({
    super.key,
    required this.activeDays,
    this.weekStreak = 0,
    this.motivationAnchor,
  });

  int get _activeDayCount => activeDays.where((d) => d).length;
  bool get _weekGoalMet => _activeDayCount >= 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: _weekGoalMet
            ? Border.all(color: const Color(0xFF4CAF50).withOpacity(0.3))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık
          Row(
            children: [
              Icon(
                _weekGoalMet ? Icons.emoji_events_rounded : Icons.calendar_today_rounded,
                color: _weekGoalMet ? const Color(0xFFD4783A) : AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Rîtma Hefteyê',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (weekStreak > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$weekStreak hefte',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // 7 gün gösterimi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) => _DayDot(
              label: _dayLabel(i),
              isActive: i < activeDays.length && activeDays[i],
              isToday: i == (DateTime.now().weekday - 1),
            )),
          ),

          const SizedBox(height: AppSpacing.md),

          // İlerleme mesajı
          Text(
            _progressMessage(),
            style: AppTypography.bodySmall.copyWith(
              color: _weekGoalMet
                  ? const Color(0xFF4CAF50)
                  : AppColors.textSecondary,
              fontWeight: _weekGoalMet ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  String _dayLabel(int index) => const ['D', 'S', 'Ç', 'P', 'C', 'Ş', 'Y'][index];

  String _progressMessage() {
    if (_weekGoalMet) {
      final anchor = motivationAnchor != null
          ? '$motivationAnchor ji te serbilind e!'
          : 'Ev hefte gelek baş bû!';
      return anchor;
    }
    final remaining = 4 - _activeDayCount;
    if (remaining <= 0) return 'Hedef tamamlandı!';
    final anchor = motivationAnchor != null
        ? '$motivationAnchor için $remaining gün daha'
        : '$remaining roj din — tu dikarî!';
    return anchor;
  }
}

class _DayDot extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isToday;

  const _DayDot({
    required this.label,
    required this.isActive,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary
                : (isToday
                    ? AppColors.primary.withOpacity(0.1)
                    : AppColors.backgroundSecondary),
            shape: BoxShape.circle,
            border: isToday && !isActive
                ? Border.all(color: AppColors.primary, width: 2)
                : null,
          ),
          child: Center(
            child: isActive
                ? const Icon(Icons.check_rounded, color: Colors.white, size: 18)
                : Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
                      color: isToday ? AppColors.primary : AppColors.textSecondary,
                    ),
                  ),
          ),
        ).animate(target: isActive ? 1 : 0).scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: 300.ms,
          curve: Curves.elasticOut,
        ),
      ],
    );
  }
}
