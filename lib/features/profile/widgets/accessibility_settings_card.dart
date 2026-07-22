import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/services/accessibility_settings.dart';

/// LÛTKE — Erişilebilirlik / Disleksi Modu Ayarları Kartı.
///
/// Prof. Dr. Yılmaz Mutlu'nun disleksi araştırmasıyla uyumlu.
/// 3 preset (Standart/Hafif/Disleksi) + granüler kontroller.
class AccessibilitySettingsCard extends ConsumerWidget {
  const AccessibilitySettingsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final a11y = ref.watch(accessibilitySettingsProvider);
    final notifier = ref.read(accessibilitySettingsProvider.notifier);

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
              const Text('👁️', style: TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Alîkariya Xwendinê',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              if (a11y.isDyslexiaMode)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('Çalak',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w700,
                      )),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Disleksî, kêmbîna an xwendina giran? Eva saz bike.',
            style: AppTypography.caption
                .copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.md),

          // ── 3 Preset ────────────────────────────────────────
          Row(
            children: [
              _PresetChip(
                label: 'Asayî',
                onTap: () => notifier.applyPreset('standart'),
                selected: !a11y.isDyslexiaMode,
              ),
              const SizedBox(width: 6),
              _PresetChip(
                label: 'Sivik',
                onTap: () => notifier.applyPreset('hafif'),
                selected: a11y.font == ReadingFont.lexend &&
                    a11y.lineHeight > 1.5 &&
                    a11y.lineHeight < 1.7,
              ),
              const SizedBox(width: 6),
              _PresetChip(
                label: 'Disleksî',
                onTap: () => notifier.applyPreset('disleksi'),
                selected: a11y.font == ReadingFont.openDyslexic,
              ),
            ],
          ),

          const Divider(height: 28),

          // ── Font ────────────────────────────────────────────
          Text('Tîp (Font)',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: ReadingFont.values.map((f) {
              final selected = a11y.font == f;
              return ChoiceChip(
                label: Text(f.labelKu,
                    style: TextStyle(fontSize: 12,
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w400)),
                selected: selected,
                onSelected: (_) => notifier.setFont(f),
              );
            }).toList(),
          ),

          const SizedBox(height: AppSpacing.md),

          // ── Arka Plan ───────────────────────────────────────
          Text('Rengê Paşê',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(height: 6),
          Row(
            children: ReadingBackground.values.map((bg) {
              final selected = a11y.background == bg;
              return Padding(
                padding: const EdgeInsets.only(right: 6),
                child: GestureDetector(
                  onTap: () => notifier.setBackground(bg),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: bg.color ?? Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selected
                            ? AppColors.primary
                            : AppColors.textSecondary
                                .withValues(alpha: 0.2),
                        width: selected ? 2.5 : 1,
                      ),
                    ),
                    child: selected
                        ? const Icon(Icons.check,
                            color: AppColors.primary, size: 20)
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: AppSpacing.md),

          // ── Satır Yüksekliği ────────────────────────────────
          _Slider(
            label: 'Bilindahiya rêzê (line height)',
            value: a11y.lineHeight,
            min: 1.2, max: 2.0, divisions: 16,
            onChanged: notifier.setLineHeight,
          ),
          const SizedBox(height: 4),

          // ── Harf Aralığı ────────────────────────────────────
          _Slider(
            label: 'Dûrî di navbera tîpan de',
            value: a11y.letterSpacing,
            min: 0.0, max: 2.0, divisions: 20,
            onChanged: notifier.setLetterSpacing,
          ),
          const SizedBox(height: 4),

          // ── Text Scale ──────────────────────────────────────
          _Slider(
            label: 'Mezinahiya nivîsê',
            value: a11y.textScale,
            min: 0.85, max: 1.5, divisions: 13,
            onChanged: notifier.setTextScale,
            labelFormatter: (v) => '${(v * 100).round()}%',
          ),

          const SizedBox(height: AppSpacing.sm),

          // ── Toggleler ───────────────────────────────────────
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text('Anîmasyon kêm bike',
                style: AppTypography.bodySmall),
            subtitle: Text('Ji bo kesên ji anîmasyonê hesas',
                style: AppTypography.caption
                    .copyWith(color: AppColors.textSecondary)),
            value: a11y.reduceAnimations,
            onChanged: notifier.toggleReduceAnimations,
          ),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text('Zehftir kontrast',
                style: AppTypography.bodySmall),
            value: a11y.highContrast,
            onChanged: notifier.toggleHighContrast,
          ),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text('Rêbera xwendinê (reading ruler)',
                style: AppTypography.bodySmall),
            subtitle: Text('Rêza heyî tê ronîkirin',
                style: AppTypography.caption
                    .copyWith(color: AppColors.textSecondary)),
            value: a11y.readingRuler,
            onChanged: notifier.toggleReadingRuler,
          ),
        ],
      ),
    );
  }
}

class _PresetChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool selected;

  const _PresetChip({
    required this.label,
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.primary.withValues(alpha: 0.12)
                : AppColors.surface,
            border: Border.all(
              color: selected
                  ? AppColors.primary
                  : AppColors.textSecondary.withValues(alpha: 0.2),
              width: selected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.labelMedium.copyWith(
              color: selected
                  ? AppColors.primary
                  : AppColors.textPrimary,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _Slider extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;
  final String Function(double)? labelFormatter;

  const _Slider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
    this.labelFormatter,
  });

  @override
  Widget build(BuildContext context) {
    final fmt = labelFormatter ?? ((v) => v.toStringAsFixed(2));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(label,
                  style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary)),
            ),
            Text(fmt(value),
                style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700)),
          ],
        ),
        Slider(
          value: value.clamp(min, max),
          min: min, max: max, divisions: divisions,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
