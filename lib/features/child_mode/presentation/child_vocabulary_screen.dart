import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/child_theme.dart';
import '../../../shared/providers/language_mode_provider.dart';
import '../../../shared/providers/learning_track_provider.dart';
import '../../../shared/widgets/speak_button.dart';
import '../../en_learning/domain/en_child_a1_kelime_db.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Kelime Ekranı
//
// Çocuklar için basitleştirilmiş kelime tarayıcı.
// Büyük kartlar, emoji simgeleri, kategori bazlı filtreleme.
//
// Track-aware (Nisan 2026): englishChild → İngilizce A1 kelimeleri,
// kurdishChild → Kurmancî örnek kelimeleri.
// ════════════════════════════════════════════════════════════════

class ChildVocabularyScreen extends ConsumerWidget {
  const ChildVocabularyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final track = ref.watch(currentTrackProvider);
    final isEn = track.isEnglish;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Başlık ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
              child: Text(
                isEn ? 'My Words' : 'Peyvên min',
                style: ChildTypography.headline.copyWith(
                  color: ChildColors.primary,
                ),
              ),
            ),

            // ── Kategori Filtreleri ──────────────────────────
            SizedBox(
              height: 52,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: isEn
                    ? const [
                        _CategoryChip(
                            emoji: '📚', label: 'All', isSelected: true),
                        _CategoryChip(emoji: '👨‍👩‍👧‍👦', label: 'Family'),
                        _CategoryChip(emoji: '🐱', label: 'Animals'),
                        _CategoryChip(emoji: '🎨', label: 'Colors'),
                        _CategoryChip(emoji: '🍎', label: 'Food'),
                        _CategoryChip(emoji: '🔢', label: 'Numbers'),
                      ]
                    : const [
                        _CategoryChip(
                            emoji: '📚', label: 'Hemû', isSelected: true),
                        _CategoryChip(emoji: '👨‍👩‍👧‍👦', label: 'Malbat'),
                        _CategoryChip(emoji: '🐱', label: 'Heywan'),
                        _CategoryChip(emoji: '🎨', label: 'Reng'),
                        _CategoryChip(emoji: '🍎', label: 'Xwarin'),
                        _CategoryChip(emoji: '🔢', label: 'Hejmar'),
                      ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Kelime Kartları ──────────────────────────────
            Expanded(
              child: Builder(
                builder: (context) {
                  // Track-aware: EN child → İngilizce çocuk A1 DB'den
                  // ilk 24 kelime; KU child → mevcut örnekler.
                  final items = isEn
                      ? kEnChildA1Liste
                          .take(24)
                          .map((w) => _DisplayWord(
                                emoji: w.emoji ?? '📘',
                                primary: w.en,
                                secondary: w.ku,
                                lang: 'en',
                              ))
                          .toList()
                      : _sampleWords
                          .map((w) => _DisplayWord(
                                emoji: w.emoji,
                                primary: w.ku,
                                secondary: w.tr,
                                lang: 'ku',
                              ))
                          .toList();
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final word = items[index];
                      return _WordCard(
                        emoji: word.emoji,
                        primary: word.primary,
                        secondary: word.secondary,
                        lang: word.lang,
                      ).animate()
                          .fadeIn(delay: (100 * index).ms)
                          .scale(begin: const Offset(0.9, 0.9));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isSelected;

  const _CategoryChip({
    required this.emoji,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
        selected: isSelected,
        onSelected: (_) {},
        selectedColor: ChildColors.primarySurface,
        backgroundColor: ChildColors.backgroundSecondary,
        side: BorderSide(
          color: isSelected ? ChildColors.primary : ChildColors.backgroundTertiary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ChildSpacing.radiusMd),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}

class _WordCard extends ConsumerWidget {
  final String emoji;
  final String primary;
  final String secondary;
  final String lang; // 'ku' veya 'en' — TTS için

  const _WordCard({
    required this.emoji,
    required this.primary,
    required this.secondary,
    required this.lang,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Kurmancî modda Türkçe çeviri gizlenir — sadece emoji + Kurmancî.
    final showTurkish = ref.watch(showTurkishProvider);
    return Container(
      decoration: BoxDecoration(
        color: ChildColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
        border: Border.all(
          color: ChildColors.primary.withOpacity(0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: ChildColors.primary.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 10),
          Text(
            primary,
            style: ChildTypography.kurmanjiCard.copyWith(
              color: ChildColors.primary,
            ),
          ),
          if (showTurkish) ...[
            const SizedBox(height: 4),
            Text(
              secondary,
              style: ChildTypography.caption.copyWith(fontSize: 14),
            ),
          ],
          const SizedBox(height: 8),
          // TTS — EN için İngilizce TTS, KU için Kurmancî (HF).
          SpeakButton(
            text: primary,
            size: 44,
            color: ChildColors.primary,
            lang: lang,
          ),
        ],
      ),
    );
  }
}

// İç model — track-aware liste için.
class _DisplayWord {
  final String emoji;
  final String primary;
  final String secondary;
  final String lang;
  const _DisplayWord({
    required this.emoji,
    required this.primary,
    required this.secondary,
    required this.lang,
  });
}

// ── Örnek kelimeler (Phase 2'de DB'den gelecek) ──────────────

class _SampleWord {
  final String emoji;
  final String ku;
  final String tr;
  const _SampleWord(this.emoji, this.ku, this.tr);
}

const _sampleWords = [
  _SampleWord('👋', 'Silav', 'Merhaba'),
  _SampleWord('❤️', 'Dê', 'Anne'),
  _SampleWord('💪', 'Bav', 'Baba'),
  _SampleWord('👧', 'Xwişk', 'Kız kardeş'),
  _SampleWord('👦', 'Bira', 'Erkek kardeş'),
  _SampleWord('🐱', 'Pisîk', 'Kedi'),
  _SampleWord('🐕', 'Seg', 'Köpek'),
  _SampleWord('🍎', 'Sêv', 'Elma'),
  _SampleWord('💧', 'Av', 'Su'),
  _SampleWord('🍞', 'Nan', 'Ekmek'),
  _SampleWord('🔴', 'Sor', 'Kırmızı'),
  _SampleWord('🟢', 'Kesk', 'Yeşil'),
];
