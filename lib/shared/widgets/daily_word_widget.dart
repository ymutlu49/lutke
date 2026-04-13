import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../features/lessons/domain/a1_kelime_db.dart';
import '../providers/language_mode_provider.dart';

// ════════════════════════════════════════════════════════════════
// PEYVA ROJE — Gunun Kelimesi Widget'i
//
// Her gun farkli bir Kurmanci kelime gosterir.
// Kelime gun-of-year indeksi ile secilir → her gun degisir.
// "Fer bum!" butonu ile ogrenildi olarak isaretlenir.
// ════════════════════════════════════════════════════════════════

/// Kategori -> emoji eslemesi
String _emojiForKat(String kat) => switch (kat) {
  'silav' || 'selamlama' => '\u{1F44B}',
  'malbat'               => '\u{1F468}\u{200D}\u{1F469}\u{200D}\u{1F467}\u{200D}\u{1F466}',
  'xwarin'               => '\u{1F37D}\u{FE0F}',
  'vexwarin'             => '\u{1F964}',
  'mewe' || 'mêwe'       => '\u{1F34E}',
  'ajal' || 'heywan'     => '\u{1F43E}',
  'reng'                 => '\u{1F3A8}',
  'jimar'                => '\u{1F522}',
  'mal'                  => '\u{1F3E0}',
  'cil'                  => '\u{1F455}',
  'beden'                => '\u{1FAC0}',
  'tendurist'            => '\u{1F3E5}',
  'pise' || 'pîşe'       => '\u{1F477}',
  'dem'                  => '\u{23F0}',
  'roj'                  => '\u{1F4C5}',
  'demsal'               => '\u{1F326}\u{FE0F}',
  'cih'                  => '\u{1F4CD}',
  'gihanî'               => '\u{1F697}',
  'leker'                => '\u{1F3C3}',
  'xweza'                => '\u{1F33F}',
  'perwerde'             => '\u{1F4DA}',
  'alfabe'               => '\u{1F524}',
  _                      => '\u{1F4D6}',
};

/// Gunun kelimesini kA1TamKelimeler listesinden secer.
/// Alfabe harflerini atlar (ku.length > 1), gun-of-year bazli indeks kullanir.
({
  String ku,
  String tr,
  String en,
  String cins,
  String kat,
  String not_,
  List<dynamic> her,
  List<dynamic> gen,
}) _getDailyWord() {
  // Anlamli kelimeleri filtrele (alfabe harfleri haric)
  final words = kA1TamKelimeler
      .where((r) => (r.ku as String).length > 1 && (r.tr as String).length > 1)
      .toList();

  if (words.isEmpty) {
    return (
      ku: 'Silav',
      tr: 'Merhaba',
      en: 'Hello',
      cins: 'becins',
      kat: 'selamlama',
      not_: '',
      her: <dynamic>[],
      gen: <dynamic>[],
    );
  }

  // Gun-of-year indeksi
  final now = DateTime.now();
  final startOfYear = DateTime(now.year, 1, 1);
  final dayOfYear = now.difference(startOfYear).inDays;
  final index = dayOfYear % words.length;
  final w = words[index];

  return (
    ku: w.ku as String,
    tr: w.tr as String,
    en: w.en as String,
    cins: (w.cins ?? 'becins') as String,
    kat: (w.kat ?? '') as String,
    not_: (w.not ?? '') as String,
    her: (w.her ?? []) as List<dynamic>,
    gen: (w.gen ?? []) as List<dynamic>,
  );
}

/// Cinsiyet gostergesi
String _genderLabel(String cins) => switch (cins) {
  'nêr'    => 'nêr (eril)',
  'mê'     => 'mê (disil)',
  _        => '',
};

class DailyWordWidget extends ConsumerStatefulWidget {
  const DailyWordWidget({super.key});

  @override
  ConsumerState<DailyWordWidget> createState() => _DailyWordWidgetState();
}

class _DailyWordWidgetState extends ConsumerState<DailyWordWidget> {
  bool _learned = false;

  @override
  Widget build(BuildContext context) {
    final showTurkish = ref.watch(showTurkishProvider);
    final word = _getDailyWord();
    final emoji = _emojiForKat(word.kat);
    final genderText = _genderLabel(word.cins);

    // Ornek cumle: heritage listesinden ilkini al
    final exampleSentence = word.her.isNotEmpty
        ? word.her.first.toString()
        : (word.gen.isNotEmpty ? word.gen.first.toString() : '');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primarySurface, Color(0xFFD6F0EA)],
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ust satir: baslik + kategori emoji
          Row(
            children: [
              Text(
                '$emoji Peyva Rojê',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Text(
                  word.kat.isNotEmpty ? word.kat : 'peyv',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          // Buyuk Kurmanci kelime
          Text(
            word.ku,
            style: AppTypography.kurmanjiLarge.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w700,
            ),
          ),

          // Cinsiyet bilgisi (varsa)
          if (genderText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                genderText,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textTertiary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

          const SizedBox(height: AppSpacing.xs),

          // Ceviri (dil moduna gore)
          if (showTurkish)
            Text(
              word.tr,
              style: AppTypography.translation.copyWith(
                color: AppColors.textSecondary,
              ),
            )
          else
            Text(
              word.en,
              style: AppTypography.translation.copyWith(
                color: AppColors.textSecondary,
              ),
            ),

          // Gramer notu
          if (word.not_.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Text(
                word.not_,
                style: AppTypography.bodyGrammar.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ),
          ],

          // Ornek cumle
          if (exampleSentence.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\u{201C}',
                  style: AppTypography.kurmanji.copyWith(
                    color: AppColors.primary.withOpacity(0.4),
                    fontSize: 24,
                    height: 1.0,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    exampleSentence,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textPrimary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: AppSpacing.md),

          // "Fer bum!" butonu
          SizedBox(
            width: double.infinity,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _learned
                  ? Container(
                      key: const ValueKey('learned'),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.successSurface,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                        border: Border.all(
                          color: AppColors.success.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_rounded,
                              color: AppColors.success, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Baş e! Peyv hat fêrkirin.',
                            style: AppTypography.label.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ElevatedButton(
                      key: const ValueKey('learn'),
                      onPressed: () => setState(() => _learned = true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Fêr bûm!',
                        style: AppTypography.labelLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.05);
  }
}
