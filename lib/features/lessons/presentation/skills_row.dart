import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/providers/language_mode_provider.dart';

/// Ana ekrandaki beceri girişlerinden biri: (simge, Kurmancî ad, ikinci
/// dildeki ad, rota).
typedef SkillEntry = (String, String, String, String);

/// Ana ekrandaki beceri girişleri.
///
/// Kurmancî yol: yazma, konuşma, hikâye, okuma (ikinci satır Türkçe).
/// İngilizce yol (Ekim 2026): okuma, dinleme, yazma, konuşma. Bu dört ekran
/// yazılmıştı ama ana ekrandan doğrudan açılmıyordu. Kurmancî adlar İngilizce
/// beceri merkezindekilerle aynıdır; ikinci satır İngilizcedir (İngilizce
/// modülde Türkçe tutulmaz).
List<SkillEntry> skillEntries({required bool english}) => english
    ? const [
        ('📖', 'Xwendin', 'Reading', AppRoutes.enReading),
        ('🎧', 'Guhdarîkirin', 'Listening', AppRoutes.enListening),
        ('✍️', 'Nivîsîn', 'Writing', AppRoutes.enWriting),
        ('🗣️', 'Axaftin', 'Speaking', AppRoutes.enSpeaking),
      ]
    : const [
        ('✍️', 'Nivîsîn', 'Yazma', AppRoutes.writing),
        ('🗣️', 'Axaftin', 'Konuşma', AppRoutes.speaking),
        ('📖', 'Çîrok', 'Hikâye', AppRoutes.story),
        ('📚', 'Xwendin', 'Okuma', AppRoutes.xwendin),
      ];

/// Ana ekrandaki beceri girişleri: Kurmancî yolda yazma, konuşma, hikâye,
/// okuma; İngilizce yolda okuma, dinleme, yazma, konuşma. Yazma ve konuşma
/// ögeleri (Kurmancî yolda) öğrencinin düzeyinden seçilir.
class SkillsRow extends ConsumerWidget {
  final String level;
  final bool english;
  const SkillsRow({super.key, required this.level, this.english = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Kurmancî yolda Türkçe satır kullanıcının dil ayarına bağlı; İngilizce
    // yolda ikinci satır İngilizce adın kendisidir, hep görünür.
    final ikinciSatir = english || ref.watch(showTurkishProvider);
    final girisler = skillEntries(english: english);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          for (int i = 0; i < girisler.length; i++) ...[
            if (i > 0) const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Material(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  onTap: () =>
                      context.push(girisler[i].$4, extra: {'level': level}),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.sm + 2, horizontal: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      border: Border.all(
                          color: AppColors.primary.withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        Text(girisler[i].$1,
                            style: const TextStyle(fontSize: 22)),
                        const SizedBox(height: 4),
                        // Dar ekranda uzun ad ("Guhdarîkirin") taşmasın.
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            girisler[i].$2,
                            maxLines: 1,
                            style: AppTypography.label.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        if (ikinciSatir)
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(girisler[i].$3,
                                maxLines: 1, style: AppTypography.caption),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(delay: 200.ms);
  }
}
