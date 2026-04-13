import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/child_theme.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/providers/child_mode_provider.dart';
import '../domain/time_limit_service.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Ebeveyn Kontrol Paneli
//
// PIN korumalı. Ebeveyn buradan:
//   - Çocuğun istatistiklerini görür
//   - Günlük süre limitini ayarlar
//   - Yetişkin moduna geçer
// ════════════════════════════════════════════════════════════════

class ParentalControlsScreen extends ConsumerWidget {
  const ParentalControlsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ebeveyn Paneli'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go(AppRoutes.childProfile),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Çocuk İstatistikleri ──────────────────────────
            Text(
              'Çocuğunuzun İlerlemesi',
              style: ChildTypography.title,
            ),
            const SizedBox(height: 16),

            _StatRow(label: 'Öğrenilen kelime', value: '24'),
            _StatRow(label: 'Tamamlanan ders', value: '3'),
            _StatRow(label: 'Toplam yıldız', value: '42'),
            _StatRow(label: 'Aktif gün (bu hafta)', value: '5 / 7'),
            _StatRow(label: 'Günlük ortalama süre', value: '12 dk'),

            const SizedBox(height: 32),

            // ── Süre Limiti ──────────────────────────────────
            Text(
              'Günlük Süre Limiti',
              style: ChildTypography.title,
            ),
            const SizedBox(height: 16),

            _TimeLimitSelector(),

            const SizedBox(height: 32),

            // ── Mod Geçişi ───────────────────────────────────
            Text(
              'Mod Geçişi',
              style: ChildTypography.title,
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => context.go(AppRoutes.modeSelect),
                icon: const Icon(Icons.swap_horiz_rounded),
                label: const Text('Modê biguherîne'),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'Yetişkin moduna geçiş yapıldığında çocuk ekranlarından '
              'çıkılır. Profil ekranından tekrar çocuk moduna dönebilirsiniz.',
              style: ChildTypography.caption.copyWith(fontSize: 13),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: ChildTypography.body),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: ChildColors.primarySurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: ChildTypography.label.copyWith(
                color: ChildColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeLimitSelector extends ConsumerStatefulWidget {
  @override
  ConsumerState<_TimeLimitSelector> createState() => _TimeLimitSelectorState();
}

class _TimeLimitSelectorState extends ConsumerState<_TimeLimitSelector> {
  int _selectedMinutes = 30;

  @override
  void initState() {
    super.initState();
    _selectedMinutes = ref.read(timeLimitProvider).limitMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [15, 30, 45, 60].map((min) {
            final isSelected = _selectedMinutes == min;
            return GestureDetector(
              onTap: () {
                setState(() => _selectedMinutes = min);
                ref.read(timeLimitProvider.notifier).setLimit(min);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: isSelected
                      ? ChildColors.primary
                      : ChildColors.backgroundSecondary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? ChildColors.primary
                        : ChildColors.primary.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$min',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? ChildColors.textOnPrimary
                            : ChildColors.primary,
                      ),
                    ),
                    Text(
                      'dk',
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected
                            ? ChildColors.textOnPrimary.withOpacity(0.8)
                            : ChildColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 12),
        Text(
          'Günlük $_selectedMinutes dakika kullanım izni',
          style: ChildTypography.caption.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}
