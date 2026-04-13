import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/child_theme.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Kelime Ekranı
//
// Çocuklar için basitleştirilmiş kelime tarayıcı.
// Büyük kartlar, emoji simgeleri, kategori bazlı filtreleme.
// ════════════════════════════════════════════════════════════════

class ChildVocabularyScreen extends ConsumerWidget {
  const ChildVocabularyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Başlık ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
              child: Text(
                'Peyvên min',
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
                children: const [
                  _CategoryChip(emoji: '📚', label: 'Hemû', isSelected: true),
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
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: _sampleWords.length,
                itemBuilder: (context, index) {
                  final word = _sampleWords[index];
                  return _WordCard(
                    emoji: word.emoji,
                    kurmanji: word.ku,
                    turkish: word.tr,
                  ).animate()
                      .fadeIn(delay: (100 * index).ms)
                      .scale(begin: const Offset(0.9, 0.9));
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

class _WordCard extends StatelessWidget {
  final String emoji;
  final String kurmanji;
  final String turkish;

  const _WordCard({
    required this.emoji,
    required this.kurmanji,
    required this.turkish,
  });

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 12),
          Text(
            kurmanji,
            style: ChildTypography.kurmanjiCard.copyWith(
              color: ChildColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            turkish,
            style: ChildTypography.caption.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
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
