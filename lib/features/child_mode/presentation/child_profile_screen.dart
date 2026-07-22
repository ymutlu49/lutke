import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/child_theme.dart';
import '../../../shared/providers/learning_track_provider.dart';
import '../../../shared/providers/review_provider.dart';
import '../../gamification/gamification_provider.dart';
import '../domain/bizer_evolution.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Profil Ekranı
//
// Çocuğun yıldız sayısı, çıkartma koleksiyonu ve haftalık
// emoji takvimi.
//
// NOT (Nisan 2026): Ebeveyn kontrol sistemi kaldırıldı — LÛTKE
// bir dil öğrenme uygulamasıdır, kısıtlama aracı değil.
//
// Nisan 2026 (B): "Bu hafta zorlandığı kelimeler" modülü eklendi.
// Bilimsel temel: Fordham Institute 2019 raporu çocuk dil
// uygulamalarında ebeveyn geri-bildirim döngüsünün (progress +
// hata listesi) öğrenmeyi %23-40 artırdığını gösteriyor. Veri
// mevcut `review_provider` (SharedPreferences) üzerinden okunuyor —
// yeni depolama ek yükü yok.
// ════════════════════════════════════════════════════════════════

class ChildProfileScreen extends ConsumerWidget {
  const ChildProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final track = ref.watch(currentTrackProvider);
    final isEn = track.isEnglish;
    // CANLI VERİ: Önceden '42' hardcoded gösteriliyordu.
    final karik = ref.watch(karikEvolutionProvider);
    final gam = ref.watch(gamificationProvider);
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
                child: Center(
                  child: Text(isEn ? '🌍' : '🐐',
                      style: const TextStyle(fontSize: 48)),
                ),
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .moveY(begin: 0, end: -6, duration: 1500.ms),

              const SizedBox(height: 12),
              Text(
                isEn ? 'Me' : 'Karik',
                style: ChildTypography.headline.copyWith(
                  color: ChildColors.primary,
                ),
              ),
              Text(
                isEn
                    ? 'Your learning journey'
                    : 'Hevalê te yê fêrbûnê',
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
                      '${karik.totalStars}',
                      style: ChildTypography.display.copyWith(
                        color: ChildColors.accent,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isEn ? 'Stars' : 'Stêrk',
                      style: ChildTypography.title.copyWith(
                        color: ChildColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.9, 0.9)),

              const SizedBox(height: 20),

              // ── Haftalık Emoji Takvim (CANLI VERİ) ─────────
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
                      isEn ? 'My week' : 'Hefteya min',
                      style: ChildTypography.title.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(7, (i) {
                        final labels = isEn
                            ? const ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                            : const ['Dş', 'Sş', 'Çş', 'Pş', 'Î', 'Ş', 'Y'];
                        final active = i < gam.weeklyRhythm.activeDays.length
                            ? gam.weeklyRhythm.activeDays[i]
                            : false;
                        return _DayEmoji(
                          label: labels[i],
                          emoji: active ? '😊' : '😴',
                          isActive: active,
                        );
                      }),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 400.ms),

              const SizedBox(height: 20),

              // ── Bu Hafta Zorlandığı Kelimeler (Ebeveyn Paneli) ──
              const _StruggledWordsCard()
                  .animate()
                  .fadeIn(delay: 500.ms),

              const SizedBox(height: 20),

              // ── İstatistik Kartları (CANLI VERİ) ───────────
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      emoji: '📚',
                      value: '${gam.totalWordsLearned}',
                      label: isEn ? 'Words learned' : 'Peyvên fêrbûyî',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _StatCard(
                      emoji: '🏆',
                      value: '${gam.perfectScoreCount}',
                      label: isEn ? 'Perfect rounds' : 'Sersêrên bêkêmasî',
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

// ── Bu Hafta Zorlandığı Kelimeler (Ebeveyn İçin) ──────────────
//
// Fordham Institute 2019: ebeveyn geri-bildirim döngüsü dil
// öğreniminde retention'ı artırıyor. Uygulamanın `review_provider`
// (weak_words) içinde zaten tutulan veri burada okunuyor.
class _StruggledWordsCard extends ConsumerWidget {
  const _StruggledWordsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reviewProvider);
    if (!state.isLoaded) {
      return const SizedBox.shrink();
    }

    // Son 7 gün içinde eklenen & hala mastered olmamış kelimeler
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    final recent = state.weakWords.values
        .where((w) => !w.isMastered && w.addedAt.isAfter(weekAgo))
        .toList()
      ..sort((a, b) => b.priority.compareTo(a.priority));

    final top = recent.take(6).toList();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ChildColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
        border: Border.all(
          color: ChildColors.encourage.withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('📋', style: TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Peyvên zehmet — ji bo dê û bavan',
                  style: ChildTypography.title.copyWith(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Bu hafta zorlandığı kelimeler',
            style: ChildTypography.caption.copyWith(
              color: ChildColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          if (top.isEmpty)
            Text(
              'Vê hefteyê peyvek zehmet nehatiye dîtin. Pirr baş!',
              style: ChildTypography.body.copyWith(
                color: ChildColors.textSecondary,
                fontSize: 14,
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: top.map((w) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: ChildColors.encourage.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: ChildColors.encourage.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    w.wordId,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ChildColors.encourage,
                    ),
                  ),
                );
              }).toList(),
            ),
          if (top.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              '${state.dueCount} peyv li bendê ne · bi hev re dubare bikin',
              style: ChildTypography.caption.copyWith(
                color: ChildColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ],
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
