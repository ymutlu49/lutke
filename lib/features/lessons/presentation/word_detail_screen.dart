import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';

// ════════════════════════════════════════════════════════════════
// KELİME DETAY EKRANI — Tam ekran kelime görünümü
// Kullanıcı kelime tarayıcısından bir kelimeye dokunduğunda açılır.
// Hero animasyonu + flutter_animate stagger giriş efektleri.
// ════════════════════════════════════════════════════════════════

class WordDetailScreen extends StatelessWidget {
  final dynamic word;
  final Color levelColor;

  const WordDetailScreen({
    super.key,
    required this.word,
    required this.levelColor,
  });

  // ── Cinsiyet rengini döndür ─────────────────────────────────
  Color _genderColor(String cins) => switch (cins) {
        'mê' => const Color(0xFFE91E63),   // pink
        'nêr' => const Color(0xFF2196F3),  // blue
        _ => const Color(0xFF9E9E9E),      // grey for bêcins
      };

  String _genderLabel(String cins) => switch (cins) {
        'mê' => 'Dişil (mê)',
        'nêr' => 'Eril (nêr)',
        _ => 'Bêcins',
      };

  IconData _genderIcon(String cins) => switch (cins) {
        'mê' => Icons.female,
        'nêr' => Icons.male,
        _ => Icons.remove,
      };

  // ── Telaffuz ipucu üret ─────────────────────────────────────
  String _pronunciationHint(String ku) {
    final hints = <String>[];
    if (ku.contains('x')) hints.add('x = girtlak "h" (Arapca x gibi)');
    if (ku.contains('q')) hints.add('q = kalin k (girtlaktan)');
    if (ku.contains('w')) hints.add('w = Ingilizce "w" (dudak yuvarlak)');
    if (ku.contains('e') && !ku.contains('ê')) hints.add('e = schwa (belirsiz unlu)');
    if (ku.contains('ê')) hints.add('e = uzun e (Fransizca e gibi)');
    if (ku.contains('î')) hints.add('i = uzun i');
    if (ku.contains('û')) hints.add('u = uzun u');
    if (ku.contains('ç')) hints.add('c = Turkce c');
    if (ku.contains('ş')) hints.add('s = Turkce s');
    if (hints.isEmpty) return 'Okunusu Turkce ile benzer';
    return hints.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    final ku = word.ku as String;
    final tr = word.tr as String;
    final en = word.en as String;
    final cins = word.cins as String;
    final ez = word.ez as String?;
    final kat = word.kat as String;
    final zor = word.zor as double;
    final not_ = word.not as String?;
    final her = word.her as List<String>;
    final gen = word.gen as List<String>;
    final id = word.id as String;

    final genderClr = _genderColor(cins);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: CustomScrollView(
        slivers: [
          // ── SliverAppBar ────────────────────────────────────
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppColors.backgroundPrimary,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.surface.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_rounded, size: 20),
              ),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: _HeroSection(
                ku: ku,
                tr: tr,
                en: en,
                cins: cins,
                genderColor: genderClr,
                wordId: id,
              ),
            ),
          ),

          // ── İçerik ──────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                const SizedBox(height: AppSpacing.md),

                // 1) Telaffuz Rehberi
                _PronunciationCard(hint: _pronunciationHint(ku))
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 100.ms)
                    .slideY(begin: 0.1, end: 0),

                const SizedBox(height: AppSpacing.md),

                // 2) Gramer Kartı
                _GrammarCard(
                  cins: cins,
                  genderColor: genderClr,
                  genderLabel: _genderLabel(cins),
                  genderIcon: _genderIcon(cins),
                  ez: ez,
                  kat: kat,
                  zor: zor,
                  levelColor: levelColor,
                ).animate()
                    .fadeIn(duration: 400.ms, delay: 200.ms)
                    .slideY(begin: 0.1, end: 0),

                const SizedBox(height: AppSpacing.md),

                // 3) Ornek Cumleler
                if (her.isNotEmpty || gen.isNotEmpty)
                  _ExampleSentencesSection(her: her, gen: gen)
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 300.ms)
                      .slideY(begin: 0.1, end: 0),

                if (her.isNotEmpty || gen.isNotEmpty)
                  const SizedBox(height: AppSpacing.md),

                // 4) Gramer Notu
                if (not_ != null && not_!.isNotEmpty)
                  _GrammarNoteCard(note: not_!)
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 400.ms)
                      .slideY(begin: 0.1, end: 0),

                if (not_ != null && not_!.isNotEmpty)
                  const SizedBox(height: AppSpacing.md),

                // 5) Ilgili Kelimeler (placeholder — same kat)
                _RelatedWordsPlaceholder(kat: kat, currentId: id)
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 500.ms)
                    .slideY(begin: 0.1, end: 0),

                const SizedBox(height: AppSpacing.lg),

                // 6) Hizli Aksiyonlar
                _QuickActions(ku: ku, tr: tr, en: en, cins: cins)
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 600.ms)
                    .slideY(begin: 0.1, end: 0),

                const SizedBox(height: AppSpacing.xxl),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// HERO SECTION — Buyuk kelime gorunumu
// ════════════════════════════════════════════════════════════════

class _HeroSection extends StatelessWidget {
  final String ku;
  final String tr;
  final String en;
  final String cins;
  final Color genderColor;
  final String wordId;

  const _HeroSection({
    required this.ku,
    required this.tr,
    required this.en,
    required this.cins,
    required this.genderColor,
    required this.wordId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            genderColor.withOpacity(0.08),
            AppColors.backgroundPrimary,
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cinsiyet renk gostergesi cizgisi
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: genderColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),

                // Kurmanci kelime — Hero animasyonu
                Hero(
                  tag: 'word_$wordId',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      ku,
                      style: const TextStyle(
                        fontFamily: 'NotoSans',
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),

                // Turkce ceviri
                Text(
                  tr,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),

                // Ingilizce ceviri
                Text(
                  en,
                  style: AppTypography.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// TELAFFUZ KARTI
// ════════════════════════════════════════════════════════════════

class _PronunciationCard extends StatelessWidget {
  final String hint;
  const _PronunciationCard({required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.record_voice_over_rounded,
                    size: 18, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Telaffuz Rehberi',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            hint,
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// GRAMER KARTI
// ════════════════════════════════════════════════════════════════

class _GrammarCard extends StatelessWidget {
  final String cins;
  final Color genderColor;
  final String genderLabel;
  final IconData genderIcon;
  final String? ez;
  final String kat;
  final double zor;
  final Color levelColor;

  const _GrammarCard({
    required this.cins,
    required this.genderColor,
    required this.genderLabel,
    required this.genderIcon,
    required this.ez,
    required this.kat,
    required this.zor,
    required this.levelColor,
  });

  @override
  Widget build(BuildContext context) {
    final zorPercent = (zor * 100).round();

    return Container(
      width: double.infinity,
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baslik
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.accentSurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.auto_stories_rounded,
                    size: 18, color: AppColors.accent),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Gramer',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Cinsiyet badge + Ezafe + Kategori
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              // Cinsiyet
              _GrammarBadge(
                icon: genderIcon,
                label: genderLabel,
                color: genderColor,
              ),

              // Ezafe
              if (ez != null && ez!.isNotEmpty)
                _GrammarBadge(
                  icon: Icons.link_rounded,
                  label: 'Ezafe: $ez',
                  color: AppColors.primary,
                ),

              // Kategori
              _GrammarBadge(
                icon: Icons.category_rounded,
                label: kat,
                color: levelColor,
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // Zorluk barı
          Row(
            children: [
              Text(
                'Zorluk',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: zor,
                    minHeight: 8,
                    backgroundColor: AppColors.border,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      zor > 0.7
                          ? AppColors.success
                          : zor > 0.5
                              ? AppColors.warning
                              : AppColors.errorSoft,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                '%$zorPercent',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GrammarBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _GrammarBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// ORNEK CUMLELER
// ════════════════════════════════════════════════════════════════

class _ExampleSentencesSection extends StatelessWidget {
  final List<String> her;
  final List<String> gen;

  const _ExampleSentencesSection({
    required this.her,
    required this.gen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baslik
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.successSurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.format_quote_rounded,
                    size: 18, color: AppColors.success),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Nimune Hevok (Ornek Cumleler)',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          // Heritage cumleler
          if (her.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            _SentenceGroup(
              title: 'Heritage (Malbat)',
              sentences: her,
              accentColor: AppColors.primary,
            ),
          ],

          // Genel cumleler
          if (gen.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            _SentenceGroup(
              title: 'Genel (Gisti)',
              sentences: gen,
              accentColor: AppColors.accent,
            ),
          ],
        ],
      ),
    );
  }
}

class _SentenceGroup extends StatelessWidget {
  final String title;
  final List<String> sentences;
  final Color accentColor;

  const _SentenceGroup({
    required this.title,
    required this.sentences,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.caption.copyWith(
            color: accentColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        ...sentences.map((s) => Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm + 4,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.04),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                border: Border(
                  left: BorderSide(color: accentColor, width: 3),
                ),
              ),
              child: Text(
                '\u201C$s\u201D',
                style: AppTypography.body.copyWith(
                  color: AppColors.textPrimary,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
            )),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// GRAMER NOTU
// ════════════════════════════════════════════════════════════════

class _GrammarNoteCard extends StatelessWidget {
  final String note;
  const _GrammarNoteCard({required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.warningSurface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.warning.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('\uD83D\uDCDD', style: TextStyle(fontSize: 20)),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gramer Notu',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  note,
                  style: AppTypography.bodyGrammar.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// ILGILI KELIMELER (Ayni kategori)
// ════════════════════════════════════════════════════════════════

class _RelatedWordsPlaceholder extends StatelessWidget {
  final String kat;
  final String currentId;

  const _RelatedWordsPlaceholder({
    required this.kat,
    required this.currentId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.hub_rounded,
                    size: 18, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Peyvine Tere (Ilgili Kelimeler)',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm + 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.backgroundTertiary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Row(
              children: [
                Icon(Icons.label_rounded,
                    size: 16, color: AppColors.textTertiary),
                const SizedBox(width: 6),
                Text(
                  'Kategoriya: $kat',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Bu kategorideki diger kelimeleri gormek icin "Peyv" sekmesinde "$kat" ile arama yapin.',
            style: AppTypography.caption.copyWith(
              color: AppColors.textTertiary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// HIZLI AKSIYONLAR
// ════════════════════════════════════════════════════════════════

class _QuickActions extends StatefulWidget {
  final String ku;
  final String tr;
  final String en;
  final String cins;

  const _QuickActions({
    required this.ku,
    required this.tr,
    required this.en,
    required this.cins,
  });

  @override
  State<_QuickActions> createState() => _QuickActionsState();
}

class _QuickActionsState extends State<_QuickActions> {
  bool _isKnown = false;
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Ezberle (Add to review)
        Expanded(
          child: _ActionButton(
            icon: _isBookmarked
                ? Icons.bookmark_rounded
                : Icons.bookmark_border_rounded,
            label: 'Ezberle',
            color: AppColors.primary,
            isActive: _isBookmarked,
            onTap: () {
              setState(() => _isBookmarked = !_isBookmarked);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_isBookmarked
                      ? '${widget.ku} tekrar listesine eklendi'
                      : '${widget.ku} tekrar listesinden cikarildi'),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: AppSpacing.sm),

        // Paylas
        Expanded(
          child: _ActionButton(
            icon: Icons.share_rounded,
            label: 'Paylas',
            color: AppColors.accent,
            isActive: false,
            onTap: () {
              final text = '${widget.ku} — ${widget.tr} / ${widget.en}'
                  '\n(${widget.cins})'
                  '\n\nLUTKE ile Kurmanci ogreniyorum!';
              Share.share(text);
            },
          ),
        ),
        const SizedBox(width: AppSpacing.sm),

        // Biliyorum
        Expanded(
          child: _ActionButton(
            icon: _isKnown
                ? Icons.check_circle_rounded
                : Icons.check_circle_outline_rounded,
            label: 'Biliyorum',
            color: AppColors.success,
            isActive: _isKnown,
            onTap: () {
              setState(() => _isKnown = !_isKnown);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_isKnown
                      ? '${widget.ku} bilinen olarak isaretlendi'
                      : '${widget.ku} isareti kaldirildi'),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isActive;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive ? color.withOpacity(0.12) : AppColors.surface,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm + 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: isActive ? color.withOpacity(0.4) : AppColors.border,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, size: 22, color: isActive ? color : AppColors.textSecondary),
              const SizedBox(height: 4),
              Text(
                label,
                style: AppTypography.labelSmall.copyWith(
                  color: isActive ? color : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
