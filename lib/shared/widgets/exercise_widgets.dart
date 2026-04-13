import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/utils/fsrs_algorithm.dart';

// ════════════════════════════════════════════════════════════════
// EGZERSİZ WİDGET'LARI — LÛTKE
//
// İlke §0: Kurmancî birincil dil
// İlke §4: FSRS-5 — 4 derecelendirme (again/hard/good/easy)
// İlke §4: Gamification destekleyici, ceza odaklı değil
// İlke §8: WCAG 2.2 AA — 48x48dp min dokunma, 4.5:1 kontrast
// ════════════════════════════════════════════════════════════════

// ── FSRS 4'lü DEĞERLENDİRME KARTI ───────────────────────────────
// Kartı gördükten sonra kullanıcı 4 seçenekten birini seçer
// İlke: Yanlış = "Tekrar" değil "Yeniden gör" — ceza yok, ritim var

typedef OnRating = void Function(Rating rating);

class FSRSRatingCard extends StatelessWidget {
  final String kurmanji;
  final String turkish;
  final String? gender;          // cins bilgisi (mê/nêr/bêcins)
  final List<String> sentences;  // Örnek cümleler
  final OnRating onRating;

  const FSRSRatingCard({
    super.key,
    required this.kurmanji,
    required this.turkish,
    this.gender,
    this.sentences = const [],
    required this.onRating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Kelime kartı
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cinsiyet rozeti
                if (gender != null && gender != 'bêcins')
                  Container(
                    margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: gender == 'nêr'
                          ? Colors.blue.withOpacity(0.1)
                          : Colors.pink.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      gender == 'nêr' ? '♂ nêr' : '♀ mê',
                      style: AppTypography.caption.copyWith(
                        color: gender == 'nêr'
                            ? Colors.blue.shade700
                            : Colors.pink.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                // Kurmancî kelime — büyük ve belirgin (İlke §0.5)
                Text(
                  kurmanji,
                  style: AppTypography.displayMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSpacing.sm),

                // Türkçe çeviri — ikincil (İlke §0.5)
                Text(
                  turkish,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),

                // Örnek cümleler
                if (sentences.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.lg),
                  const Divider(),
                  const SizedBox(height: AppSpacing.sm),
                  ...sentences.take(2).map(
                    (s) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        s,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),

        // FSRS 4 derecelendirme — İlke §4
        const SizedBox(height: AppSpacing.lg),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: _FSRSRatingRow(onRating: onRating),
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

// ── FSRS DERECELENDIRME SATIRI ────────────────────────────────────
// 4 düğme: Dubare / Dijwar / Baş / Hêsan
// Kurmancî etiketler — İlke §0.5

class _FSRSRatingRow extends StatelessWidget {
  final OnRating onRating;
  const _FSRSRatingRow({required this.onRating});

  @override
  Widget build(BuildContext context) {
    // 2x2 grid on mobile for better touch targets
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            // Again — Dubare (yeniden gör — ceza değil)
            Expanded(
              child: _RatingButton(
                kuLabel: 'Dubare',   // Tekrar
                trLabel: 'Yeniden gör',
                color: const Color(0xFFEF5350),
                icon: Icons.refresh_rounded,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  onRating(Rating.again);
                },
              ),
            ),
            const SizedBox(width: 8),
            // Hard — Dijwar
            Expanded(
              child: _RatingButton(
                kuLabel: 'Dijwar',
                trLabel: 'Zor',
                color: const Color(0xFFFF9800),
                icon: Icons.sentiment_dissatisfied_outlined,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  onRating(Rating.hard);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // Good — Baş
            Expanded(
              child: _RatingButton(
                kuLabel: 'Baş',
                trLabel: 'İyi',
                color: const Color(0xFF4CAF50),
                icon: Icons.sentiment_satisfied_outlined,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  onRating(Rating.good);
                },
              ),
            ),
            const SizedBox(width: 8),
            // Easy — Hêsan
            Expanded(
              child: _RatingButton(
                kuLabel: 'Hêsan',
                trLabel: 'Kolay',
                color: const Color(0xFF2196F3),
                icon: Icons.sentiment_very_satisfied_outlined,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  onRating(Rating.easy);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RatingButton extends StatelessWidget {
  final String kuLabel;
  final String trLabel;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _RatingButton({
    required this.kuLabel,
    required this.trLabel,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Min 56dp height — mobile optimized, İlke §8 WCAG
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 56, minWidth: 48),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 6),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kurmancî önce — İlke §0.5
                Text(
                  kuLabel,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                Text(
                  trLabel,
                  style: TextStyle(
                    fontSize: 11,
                    color: color.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// ÇOK SEÇENEKLİ EGZERSİZ
// Kurmancî → Türkçe veya Türkçe → Kurmancî
// İlke §8: Renk + ikon birlikte (renk körü erişilebilirliği)
// ════════════════════════════════════════════════════════════════

class MultipleChoiceExercise extends StatefulWidget {
  final String question;          // Kurmancî kelime/cümle
  final List<String> options;     // 4 seçenek
  final int correctIndex;
  final OnRating onRating;        // Doğru/Yanlış → FSRS rating'e dönüşür

  const MultipleChoiceExercise({
    super.key,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.onRating,
  });

  @override
  State<MultipleChoiceExercise> createState() => _MultipleChoiceExerciseState();
}

class _MultipleChoiceExerciseState extends State<MultipleChoiceExercise> {
  int? _selected;
  bool _revealed = false;

  void _select(int index) {
    if (_revealed) return;
    HapticFeedback.lightImpact();
    setState(() {
      _selected = index;
      _revealed = true;
    });

    final correct = index == widget.correctIndex;

    // Haptic feedback for correct/wrong
    if (correct) {
      HapticFeedback.mediumImpact();
    } else {
      HapticFeedback.heavyImpact();
    }

    // 1.5 saniye bekle → FSRS derecelendirmesi
    Future.delayed(1500.ms, () {
      if (!mounted) return;
      // Doğruysa Good, yanlışsa Again — kullanıcı kendi derecelendirebilir
      widget.onRating(correct ? Rating.good : Rating.again);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Soru — büyük ve ortalanmış
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                'Wateya vê peyvê çi ye?',  // Bu kelimenin anlamı ne?
                style: AppTypography.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.question,
                  style: AppTypography.displayMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // Seçenekler — tek sütun, tam genişlik
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Column(
            children: widget.options.asMap().entries.map((entry) {
              final i = entry.key;
              final opt = entry.value;
              return Padding(
                padding: EdgeInsets.only(
                    bottom: i < widget.options.length - 1 ? AppSpacing.sm : 0),
                child: _OptionButton(
                  text: opt,
                  index: i,
                  selected: _selected,
                  correctIndex: widget.correctIndex,
                  revealed: _revealed,
                  onTap: () => _select(i),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _OptionButton extends StatelessWidget {
  final String text;
  final int index;
  final int? selected;
  final int correctIndex;
  final bool revealed;
  final VoidCallback onTap;

  const _OptionButton({
    required this.text,
    required this.index,
    required this.selected,
    required this.correctIndex,
    required this.revealed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == index;
    final isCorrect = index == correctIndex;

    Color bg = AppColors.surface;
    Color border = AppColors.border;
    IconData? icon;

    if (revealed) {
      if (isCorrect) {
        // Doğru — İlke §8: renk + ikon birlikte
        bg = const Color(0xFF4CAF50).withOpacity(0.12);
        border = const Color(0xFF4CAF50);
        icon = Icons.check_circle_outline;
      } else if (isSelected) {
        // Yanlış seçim — renk + ikon
        bg = const Color(0xFFEF5350).withOpacity(0.12);
        border = const Color(0xFFEF5350);
        icon = Icons.cancel_outlined;
      }
    }

    Widget button = GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 250.ms,
        constraints: const BoxConstraints(minHeight: 56),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isSelected && !revealed
                  ? AppColors.primary
                  : border,
              width: isSelected && !revealed ? 2 : 1.5),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon,
                  size: 22,
                  color: isCorrect
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFFEF5350)),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Text(
                text,
                style: AppTypography.bodyLarge.copyWith(
                  fontWeight:
                      isSelected || (revealed && isCorrect)
                          ? FontWeight.w700
                          : FontWeight.w500,
                  color: AppColors.textPrimary,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );

    // Correct: green flash animation, Wrong: red shake animation
    if (revealed && isCorrect) {
      button = button
          .animate()
          .shimmer(duration: 600.ms, color: const Color(0xFF4CAF50).withOpacity(0.3));
    } else if (revealed && isSelected && !isCorrect) {
      button = button
          .animate()
          .shakeX(duration: 400.ms, hz: 4, amount: 4);
    } else {
      button = button.animate(target: isSelected && !revealed ? 1 : 0).scale(
            begin: const Offset(1, 1),
            end: const Offset(0.97, 0.97),
            duration: 100.ms,
          );
    }

    return button;
  }
}

// ════════════════════════════════════════════════════════════════
// YAZMA EGZERSİZİ (Kurmancî yazım pratiği)
// ════════════════════════════════════════════════════════════════

class TypingExercise extends StatefulWidget {
  final String prompt;    // Türkçe → Kurmancî yaz
  final String answer;    // Doğru Kurmancî
  final OnRating onRating;

  const TypingExercise({
    super.key,
    required this.prompt,
    required this.answer,
    required this.onRating,
  });

  @override
  State<TypingExercise> createState() => _TypingExerciseState();
}

class _TypingExerciseState extends State<TypingExercise> {
  final _ctrl = TextEditingController();
  bool _checked = false;
  bool _correct = false;

  void _check() {
    if (_ctrl.text.trim().isEmpty) return;
    final userInput = _ctrl.text.trim().toLowerCase();
    final expected = widget.answer.trim().toLowerCase();
    final isCorrect = userInput == expected ||
        _similarity(userInput, expected) > 0.85;
    setState(() {
      _checked = true;
      _correct = isCorrect;
    });
    // Haptic feedback
    if (isCorrect) {
      HapticFeedback.mediumImpact();
    } else {
      HapticFeedback.heavyImpact();
    }
  }

  // Levenshtein benzerlik (typo toleransı)
  double _similarity(String a, String b) {
    if (a == b) return 1.0;
    final la = a.length, lb = b.length;
    if (la == 0 || lb == 0) return 0.0;
    final d = List.generate(la + 1, (_) => List.filled(lb + 1, 0));
    for (var i = 0; i <= la; i++) d[i][0] = i;
    for (var j = 0; j <= lb; j++) d[0][j] = j;
    for (var i = 1; i <= la; i++) {
      for (var j = 1; j <= lb; j++) {
        d[i][j] = a[i - 1] == b[j - 1]
            ? d[i - 1][j - 1]
            : 1 + [d[i - 1][j], d[i][j - 1], d[i - 1][j - 1]]
                  .reduce((a, b) => a < b ? a : b);
      }
    }
    return 1 - d[la][lb] / (la > lb ? la : lb);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Prompt
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  'Bi Kurmancî binivîse:',  // Kurmancî yaz
                  style: AppTypography.caption
                      .copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  widget.prompt,
                  style: AppTypography.headingSmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Giriş alanı — büyük font, mobil optimize
          TextField(
            controller: _ctrl,
            enabled: !_checked,
            autofocus: true,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: 'Li vir binivîse...',  // Buraya yaz
              hintStyle: TextStyle(
                fontSize: 20,
                color: AppColors.textSecondary.withOpacity(0.5),
                fontWeight: FontWeight.w400,
              ),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg, vertical: AppSpacing.lg),
              filled: true,
              fillColor: _checked
                  ? (_correct
                      ? const Color(0xFF4CAF50).withOpacity(0.08)
                      : const Color(0xFFEF5350).withOpacity(0.08))
                  : AppColors.backgroundSecondary,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: _checked
                      ? (_correct
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFFEF5350))
                      : AppColors.border,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              suffixIcon: _checked
                  ? Icon(
                      _correct
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: _correct
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFFEF5350),
                      size: 28,
                    )
                  : null,
            ),
            onSubmitted: (_) => _check(),
          ),

          // Doğru cevap (yanlışsa göster)
          if (_checked && !_correct) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: const Color(0xFF4CAF50).withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline,
                      color: Color(0xFF4CAF50), size: 18),
                  const SizedBox(width: 8),
                  Text(
                    widget.answer,
                    style: AppTypography.bodyMedium.copyWith(
                      color: const Color(0xFF4CAF50),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],

          const Spacer(),

          // Kontrol / Devam — altta sabit
          if (!_checked)
            ElevatedButton(
              onPressed: _check,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                'Kontrol bike',  // Kontrol et
                style: AppTypography.labelLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            )
          else
            // FSRS derecelendirme — kullanıcı kendi değerlendiriyor
            _FSRSRatingRow(onRating: widget.onRating),

          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// CÜMLE DÜZENLEME EGZERSİZİ
// Kelimeler karışık — doğru sırayla diz (Kurmancî sözdizimi)
// ════════════════════════════════════════════════════════════════

class SentenceOrderExercise extends StatefulWidget {
  final List<String> wordTokens;   // Karışık kelimeler
  final List<String> correctOrder; // Doğru sıra
  final OnRating onRating;

  const SentenceOrderExercise({
    super.key,
    required this.wordTokens,
    required this.correctOrder,
    required this.onRating,
  });

  @override
  State<SentenceOrderExercise> createState() =>
      _SentenceOrderExerciseState();
}

class _SentenceOrderExerciseState extends State<SentenceOrderExercise> {
  late List<String?> _remaining;
  late List<String?> _placed;
  bool _checked = false;
  bool _correct = false;

  @override
  void initState() {
    super.initState();
    _remaining = [...widget.wordTokens]..shuffle();
    _placed = List.filled(widget.correctOrder.length, null);
  }

  void _placeWord(String word, int fromIndex) {
    if (_checked) return;
    HapticFeedback.selectionClick();
    final emptySlot = _placed.indexWhere((e) => e == null);
    if (emptySlot == -1) return;
    setState(() {
      _remaining[fromIndex] = null;
      _placed[emptySlot] = word;
    });
  }

  void _removeWord(int slotIndex) {
    if (_checked) return;
    HapticFeedback.selectionClick();
    final word = _placed[slotIndex];
    if (word == null) return;
    final emptyRemaining = _remaining.indexWhere((e) => e == null);
    setState(() {
      _placed[slotIndex] = null;
      if (emptyRemaining != -1) {
        _remaining[emptyRemaining] = word;
      } else {
        _remaining.add(word);
      }
    });
  }

  void _check() {
    final placed = _placed.where((w) => w != null).toList();
    if (placed.length < widget.correctOrder.length) return;
    final isCorrect = placed.join(' ') == widget.correctOrder.join(' ');
    setState(() {
      _checked = true;
      _correct = isCorrect;
    });
    if (isCorrect) {
      HapticFeedback.mediumImpact();
    } else {
      HapticFeedback.heavyImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sentence answer area with correct/wrong animation
    Widget answerArea = Container(
      constraints: const BoxConstraints(minHeight: 60),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: _checked
            ? (_correct
                ? const Color(0xFF4CAF50).withOpacity(0.08)
                : const Color(0xFFEF5350).withOpacity(0.08))
            : AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: _checked
                ? (_correct
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFFEF5350))
                : AppColors.border,
            width: _checked ? 2 : 1),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: _placed.asMap().entries.map((entry) {
          final i = entry.key;
          final word = entry.value;
          return word == null
              ? Container(
                  width: 48,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppColors.border.withOpacity(0.5),
                        style: BorderStyle.solid),
                  ),
                )
              : GestureDetector(
                  onTap: () => _removeWord(i),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 44),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      word,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
        }).toList(),
      ),
    );

    // Animate correct/wrong
    if (_checked && _correct) {
      answerArea = answerArea
          .animate()
          .shimmer(duration: 600.ms, color: const Color(0xFF4CAF50).withOpacity(0.3));
    } else if (_checked && !_correct) {
      answerArea = answerArea
          .animate()
          .shakeX(duration: 400.ms, hz: 4, amount: 4);
    }

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Text(
            'Hevoka rast çêke',  // Doğru cümleyi oluştur
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),

          // Yerleştirilen kelimeler
          answerArea,

          const SizedBox(height: AppSpacing.xl),

          // Kalan kelimeler — büyük dokunma hedefleri (min 44dp)
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _remaining.asMap().entries.map((entry) {
              final i = entry.key;
              final word = entry.value;
              return word == null
                  ? const SizedBox.shrink()
                  : GestureDetector(
                      onTap: () => _placeWord(word, i),
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 44),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          word,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    );
            }).toList(),
          ),

          const Spacer(),

          // Kontrol / Devam
          if (!_checked)
            ElevatedButton(
              onPressed: _check,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                'Kontrol bike',
                style: AppTypography.labelLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            )
          else
            _FSRSRatingRow(onRating: widget.onRating),

          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}
