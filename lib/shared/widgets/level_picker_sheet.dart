import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/router/app_router.dart';
import '../../features/lessons/data/lesson_repository.dart';
import '../../features/onboarding/placement_test_screen.dart' show recommendedLevelKeyFor;
import '../providers/learning_track_provider.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Level Picker Sheet
//
// Yerleştirme testi sonucu zorunlu değildir; kullanıcı istediği seviyenin
// içeriğine erişebilir. Bu sheet:
//   1) Aktif seviyeyi gösterir (seçili)
//   2) Test önerisini "pêşniyar" rozeti ile işaretler
//   3) Tüm 6 CEFR seviyesini açıklamalarıyla listeler
//   4) Tek tıkla seviye değiştirir, paneli kapatır
//   5) Alttan "testi yeniden yap" CTA'sı ile placement'a yönlendirir
//
// Kullanım:
//   await LevelPickerSheet.show(context);
//
// Kurmancî birincil dil — çağrıların hepsi Kurmancî, yardımcı TR explainer
// alt satırda kalır (heritage öğrenciler için).
// ════════════════════════════════════════════════════════════════

class LevelPickerSheet extends ConsumerStatefulWidget {
  const LevelPickerSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const LevelPickerSheet(),
    );
  }

  @override
  ConsumerState<LevelPickerSheet> createState() => _LevelPickerSheetState();
}

class _LevelPickerSheetState extends ConsumerState<LevelPickerSheet> {
  String? _recommended;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadRecommendation();
  }

  Future<void> _loadRecommendation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final track = ref.read(currentTrackProvider);
      final rec = prefs.getString(recommendedLevelKeyFor(track.languageCode));
      if (mounted) {
        setState(() {
          _recommended = rec?.toLowerCase();
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _switchTo(String code) async {
    await ref.read(userProfileProvider.notifier).setLevel(code);
    if (!mounted) return;
    Navigator.of(context).pop();
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 2),
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Astê hate guhertin: ${code.toUpperCase()}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(userProfileProvider);
    final current = profile.currentLevel.toLowerCase();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.borderLight,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // Title
                Text(
                  'Asta xwe hilbijêre',
                  style: AppTypography.headingSmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Bi serbestî her astê biceribîne — paşê dîsa biguherîne.',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Level rows
                if (_loading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  ..._levelRows(current),

                const SizedBox(height: AppSpacing.md),

                // Bottom CTA — retake placement
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary.withOpacity(0.5)),
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.sm,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.push(AppRoutes.placementTest);
                  },
                  icon: const Icon(Icons.assessment_outlined, size: 18),
                  label: Text(
                    'Asta xwe ji nû ve biceribîne',
                    style: AppTypography.label.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _levelRows(String current) {
    const levels = ['a1', 'a2', 'b1', 'b2', 'c1', 'c2'];
    return [
      for (final code in levels)
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xs),
          child: _LevelRow(
            code: code,
            isCurrent: code == current,
            isRecommended: code == _recommended,
            onTap: code == current ? null : () => _switchTo(code),
          ),
        ),
    ];
  }
}

class _LevelRow extends StatelessWidget {
  final String code;
  final bool isCurrent;
  final bool isRecommended;
  final VoidCallback? onTap;

  const _LevelRow({
    required this.code,
    required this.isCurrent,
    required this.isRecommended,
    required this.onTap,
  });

  static const _colors = {
    'a1': Color(0xFF4CAF50),
    'a2': Color(0xFF8BC34A),
    'b1': Color(0xFFFF9800),
    'b2': Color(0xFFF44336),
    'c1': Color(0xFF9C27B0),
    'c2': Color(0xFF3F51B5),
  };

  static const _descriptions = {
    'a1': 'Bingehîn — silav, hejmar, peyvên rojane',
    'a2': 'Destpêka pêşketî — hevokên hêsan, dema borî/niha',
    'b1': 'Asta navîn — axaftina serbest, dem-form',
    'b2': 'Navîn-jor — îdyom, rêziman kompleks',
    'c1': 'Pêşketî — peyvên abstrakt, edebî',
    'c2': 'Pispor — nuans akademîk, herikbarî temam',
  };

  @override
  Widget build(BuildContext context) {
    final color = _colors[code] ?? AppColors.primary;
    final label = code.toUpperCase();
    final desc = _descriptions[code] ?? '';

    final bgColor = isCurrent
        ? color.withOpacity(0.10)
        : AppColors.surface;
    final borderColor = isCurrent
        ? color
        : AppColors.borderLight;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: borderColor,
              width: isCurrent ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              // Badge with level code
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isCurrent ? color : color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: isCurrent ? Colors.white : color,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),

              // Label + description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          label,
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (isRecommended) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'pêşniyar',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                        if (isCurrent) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'niha',
                              style: AppTypography.caption.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      desc,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Chevron — gizlenir if current
              if (!isCurrent)
                Icon(
                  Icons.chevron_right_rounded,
                  size: 22,
                  color: AppColors.textTertiary,
                )
              else
                Icon(
                  Icons.check_circle_rounded,
                  size: 22,
                  color: color,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
