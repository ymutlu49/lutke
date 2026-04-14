import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/child_theme.dart';
import 'widgets/star_display_widget.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Profil Ekranı
//
// Çocuğun yıldız sayısı, çıkartma koleksiyonu ve haftalık
// emoji takvimi.
//
// NOT (Nisan 2026): Ebeveyn kontrol sistemi kaldırıldı — LÛTKE
// bir dil öğrenme uygulamasıdır, kısıtlama aracı değil.
// ════════════════════════════════════════════════════════════════

class ChildProfileScreen extends ConsumerWidget {
  const ChildProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // ── Maskot + İsim ───────────────────────────────
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: ChildColors.primarySurface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ChildColors.primary.withOpacity(0.3),
                    width: 3,
                  ),
                ),
                child: const Center(
                  child: Text('🐐', style: TextStyle(fontSize: 48)),
                ),
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .moveY(begin: 0, end: -6, duration: 1500.ms),

              const SizedBox(height: 12),
              Text(
                'Karik',
                style: ChildTypography.headline.copyWith(
                  color: ChildColors.primary,
                ),
              ),
              Text(
                'Hevalê te yê fêrbûnê',
                style: ChildTypography.caption,
              ),

              const SizedBox(height: 24),

              // ── Yıldız Toplam ─────────────────────────────
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ChildColors.starYellow.withOpacity(0.15),
                      ChildColors.accent.withOpacity(0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
                  border: Border.all(
                    color: ChildColors.starYellow.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('⭐', style: TextStyle(fontSize: 36)),
                    const SizedBox(width: 12),
                    Text(
                      '42',
                      style: ChildTypography.display.copyWith(
                        color: ChildColors.accent,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Stêrk',
                      style: ChildTypography.title.copyWith(
                        color: ChildColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.9, 0.9)),

              const SizedBox(height: 20),

              // ── Haftalık Emoji Takvim ──────────────────────
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ChildColors.backgroundSecondary,
                  borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
                  border: Border.all(
                    color: ChildColors.primary.withOpacity(0.15),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Hefteya min',
                      style: ChildTypography.title.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        _DayEmoji(label: 'Dş', emoji: '😊', isActive: true),
                        _DayEmoji(label: 'Sş', emoji: '😊', isActive: true),
                        _DayEmoji(label: 'Çş', emoji: '😊', isActive: true),
                        _DayEmoji(label: 'Pş', emoji: '🌟', isActive: true),
                        _DayEmoji(label: 'Î', emoji: '😊', isActive: true),
                        _DayEmoji(label: 'Ş', emoji: '😴', isActive: false),
                        _DayEmoji(label: 'Y', emoji: '❓', isActive: false),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 400.ms),

              const SizedBox(height: 20),

              // ── İstatistik Kartları ────────────────────────
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      emoji: '📚',
                      value: '24',
                      label: 'Peyvên fêrbûyî',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _StatCard(
                      emoji: '🏆',
                      value: '3',
                      label: 'Waneyên temam',
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 600.ms),

            ],
          ),
        ),
      ),
    );
  }
}

class _DayEmoji extends StatelessWidget {
  final String label;
  final String emoji;
  final bool isActive;

  const _DayEmoji({
    required this.label,
    required this.emoji,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isActive
                ? ChildColors.primary
                : ChildColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;

  const _StatCard({
    required this.emoji,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChildColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
        border: Border.all(
          color: ChildColors.primary.withOpacity(0.15),
        ),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 8),
          Text(value, style: ChildTypography.headline),
          Text(
            label,
            style: ChildTypography.caption.copyWith(fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
