import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../shared/providers/language_mode_provider.dart';
import '../../../shared/providers/learning_track_provider.dart';
import '../../../shared/widgets/speak_button.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Gotinên Pêşiyan (Günlük Atasözü) Kartı
//
// Her gün 1 Kurmancî atasözü + Türkçe yorum + HF TTS.
// Proverbs dil öğretiminde çift transfer: dil + kültür.
// Gün deterministik seed ile seçilir — aynı gün aynı atasözü.
// ════════════════════════════════════════════════════════════════

class _Proverb {
  final String ku;
  final String tr;
  final String meaning;
  const _Proverb(this.ku, this.tr, this.meaning);
}

const _kProverbs = <_Proverb>[
  _Proverb(
    'Ziman dermanê dilê mirov e.',
    'Dil, insanın kalbinin ilacıdır.',
    'Ana dilin duygusal değerine vurgu.',
  ),
  _Proverb(
    'Av di cih de bêhn dibe.',
    'Yerinde duran su kokar.',
    'Hareketsizliğe karşı uyarı.',
  ),
  _Proverb(
    'Dil bi dil re, can bi can re.',
    'Gönül gönüle, can cana.',
    'Dostlukta içten bağlılık.',
  ),
  _Proverb(
    'Destê xwe bi xêr bîne.',
    'Ellerin hayırlı olsun.',
    'Yardımdan sonra söylenen hayır duası.',
  ),
  _Proverb(
    'Zimanê xwe ji bîr neke, ma tu xwe ji bîr dikî?',
    'Dilini unutma, kendini mi unutacaksın?',
    'Ana dilin korunmasına çağrı.',
  ),
  _Proverb(
    'Ji xwezanê çi xwiya ne, ji xwe dizane.',
    'Bir kişide ne görünürse kendinden bilir.',
    'Öz-bilinç ve dürüstlük.',
  ),
  _Proverb(
    'Heta baran nebare, diqilqil naşkê.',
    'Yağmur yağmadan çatlak dolmaz.',
    'Sabır ve doğal zaman.',
  ),
  _Proverb(
    'Bi sebir tir û tavil tên.',
    'Sabırla koruk helva olur.',
    'Sabrın mükafatı.',
  ),
  _Proverb(
    'Kû bibe bi carek û tim bimîne.',
    'Her ne olursa bir kere olur ve kalıcı olur.',
    'Önemli olanın tek seferde doğru yapılması.',
  ),
  _Proverb(
    'Hinek tişt bi zor nayên, tenê bi dem.',
    'Bazı şeyler zorla değil, zamanla olur.',
    'Zamanın öğretici gücü.',
  ),
  _Proverb(
    'Mala xweş, jina xweş, dilê xweş.',
    'Güzel ev, güzel eş, güzel gönül.',
    'Aile huzurunun üç sütunu.',
  ),
  _Proverb(
    'Guh dide hev, dev jî diçe hev.',
    'Kulaklar birbirine yaslanınca ağızlar da birleşir.',
    'Uyum ve karşılıklı saygı.',
  ),
  _Proverb(
    'Heta nanê xwe bi mekî venaxwî, hevalên xwe nas nakî.',
    'Birlikte ekmek yemeyince dostunu tanıyamazsın.',
    'Dostluk zamanla sınanır.',
  ),
  _Proverb(
    'Bi yekîtiyê, her tişt pêk tê.',
    'Birlikle her şey başarılır.',
    'Birlik vurgusu (Xanî-Koyî temasıyla uyumlu).',
  ),
];

/// Günün atasözü kartı. Home ekranında / Culture sekmesinde gösterilebilir.
class DailyProverbCard extends ConsumerWidget {
  const DailyProverbCard({super.key});

  _Proverb get _todayProverb {
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
    return _kProverbs[dayOfYear % _kProverbs.length];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Bu Kurmancî atasözü kartı — sadece Kurmancî track'te gösterilir.
    final track = ref.watch(currentTrackProvider);
    if (track.isEnglish) return const SizedBox.shrink();

    final p = _todayProverb;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withValues(alpha: 0.12),
            AppColors.primary.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('📜', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 6),
              Text(
                ref.watch(showTurkishProvider)
                    ? 'Gotina Îro — Günün Atasözü'
                    : 'Gotina Îro',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  p.ku,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SpeakButton(text: p.ku, size: 36, lang: 'ku'),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            p.tr,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            p.meaning,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
