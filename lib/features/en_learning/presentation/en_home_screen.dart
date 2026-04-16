import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../domain/en_a1_kelime_db.dart';

/// LÛTKE — İngilizce Öğrenme Ana Sayfası (MVP)
///
/// Faz 1: Basit iskelet — A1 kelime havuzu, swipe-based vocabulary review.
/// Sonraki fazlar: Quiz, FSRS, dilbilgisi.
class EnHomeScreen extends ConsumerWidget {
  const EnHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => context.go(AppRoutes.moduleSelect),
              child: Image.asset(
                'assets/images/logo_128.png',
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Fêrî Îngilîzî',
              style: AppTypography.headingSmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '🌍',
              style: const TextStyle(fontSize: 22),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz_rounded),
            tooltip: 'Modulê biguherîne',
            onPressed: () => context.go(AppRoutes.moduleSelect),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                _WelcomeCard(),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Asta a destpêkê — A1',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  '${kEnA1Liste.length} peyv hatine amade kirin',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _LevelCard(
                  title: 'A1 — Destpêk',
                  subtitle: '${kEnA1Liste.length} peyv',
                  description: 'Selamandin, hejmar, reng, malbat, leker',
                  emoji: '🌱',
                  active: true,
                  onTap: () => _showA1Preview(context),
                ),
                const SizedBox(height: AppSpacing.md),
                _LevelCard(
                  title: 'A2 — Destpêka pêşketî',
                  subtitle: 'Bê dem hatîye amade kirin',
                  description: 'Wê di pêşerojê de were lê zêdekirin',
                  emoji: '🌿',
                  active: false,
                  onTap: null,
                ),
                const SizedBox(height: AppSpacing.md),
                _LevelCard(
                  title: 'B1 — Navîn',
                  subtitle: 'Bê dem hatîye amade kirin',
                  description: 'Wê di pêşerojê de were lê zêdekirin',
                  emoji: '🌳',
                  active: false,
                  onTap: null,
                ),
                const SizedBox(height: AppSpacing.lg),
                _CategoryGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showA1Preview(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _A1PreviewSheet(),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withOpacity(0.12),
            AppColors.accent.withOpacity(0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accent.withOpacity(0.20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🌍', style: TextStyle(fontSize: 28)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Bi xêr hatî!',
                  style: AppTypography.title.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Tu yê Îngilîzî bi rêya Kurmancî fêr bibî. '
            'Tu bi peyvên rojane dest pê dikî û her gav pêşda diçî.',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String emoji;
  final bool active;
  final VoidCallback? onTap;

  const _LevelCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.emoji,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.primary : AppColors.textTertiary;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: active
                ? AppColors.surface
                : AppColors.surface.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withOpacity(active ? 0.3 : 0.15),
            ),
          ),
          child: Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.bodyLarge.copyWith(
                        color: active
                            ? AppColors.textPrimary
                            : AppColors.textTertiary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTypography.caption.copyWith(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (active)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: color,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cats = <String, int>{};
    for (final w in kEnA1Liste) {
      cats[w.kat] = (cats[w.kat] ?? 0) + 1;
    }
    final sortedCats = cats.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kategorî',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: sortedCats
              .map((e) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          e.key,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${e.value}',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _A1PreviewSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textTertiary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                const Text('🌱', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'A1 — ${kEnA1Liste.length} peyv',
                    style: AppTypography.title.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              itemCount: kEnA1Liste.length,
              itemBuilder: (_, i) {
                final w = kEnA1Liste[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Row(
                    children: [
                      if (w.emoji != null) ...[
                        Text(w.emoji!, style: const TextStyle(fontSize: 24)),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              w.en,
                              style: AppTypography.bodyLarge.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              '${w.ipa} · ${w.pos}',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        w.ku,
                        style: AppTypography.bodyLarge.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
