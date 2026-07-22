import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/services/app_config.dart';
import '../../../core/services/tts_service.dart';
import '../../../core/services/tts_source_preferences.dart';

/// LÛTKE — Kurmancî TTS Kaynak Seçim Kartı.
///
/// Kullanıcı şu seçeneklerden birini seçer:
///   - assetFirst (varsayılan): ön-üretilmiş asset + HF yedek
///   - assetOnly: sadece asset (tutarlı, HF hiç çağrılmaz)
///   - huggingface: sadece HF (güncel model, cold-start yavaş)
///
/// Ayrıca "Cache'i temizle" butonu — HF cache'inde bozuk veri varsa.
class TtsSourceCard extends ConsumerWidget {
  const TtsSourceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final source = ref.watch(ttsSourceProvider);
    final notifier = ref.read(ttsSourceProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🔊', style: TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Dengê Kurmancî',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Kîjan dengê Kurmancî tê bikaranîn? Eger deng ne xweş e, '
            '"Tenê asset" hilbijêre.',
            style: AppTypography.caption
                .copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.md),
          ...KurmanciTtsSource.values.map((s) {
            final selected = source == s;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () => notifier.set(s),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primary.withValues(alpha: 0.08)
                        : AppColors.surface,
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : AppColors.textSecondary
                              .withValues(alpha: 0.15),
                      width: selected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        selected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: selected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          s.labelKu,
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          // Cache temizleme butonu
          TextButton.icon(
            onPressed: () async {
              final tts = ref.read(ttsServiceProvider);
              await tts.clearCache();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cache hate jêbirin — dengê nû dê were.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            icon: const Icon(Icons.delete_sweep_outlined, size: 18),
            label: const Text('Cache-a dengê jêbibe'),
          ),
        ],
      ),
    );
  }
}
