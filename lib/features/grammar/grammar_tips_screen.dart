import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../shared/providers/language_mode_provider.dart';

// ════════════════════════════════════════════════════════════════
// REZIMAN — Kurmancî Gramer Rehberi (A1–B1)
// Duolingo "Tips" tarzı: konu kartları + genisleyen detay.
// Ilke 0.5: Kurmanci birincil dil.
// ════════════════════════════════════════════════════════════════

class GrammarTipsScreen extends ConsumerStatefulWidget {
  const GrammarTipsScreen({super.key});

  @override
  ConsumerState<GrammarTipsScreen> createState() => _GrammarTipsScreenState();
}

class _GrammarTipsScreenState extends ConsumerState<GrammarTipsScreen> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final showTurkish = ref.watch(showTurkishProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rêziman',
              style: AppTypography.headline.copyWith(fontSize: 20),
            ),
            if (showTurkish)
              Text(
                'Gramer Rehberi',
                style: AppTypography.caption,
              ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        itemCount: _grammarTopics.length,
        itemBuilder: (context, index) {
          final topic = _grammarTopics[index];
          final isExpanded = _expandedIndex == index;

          return _GrammarTopicCard(
            topic: topic,
            isExpanded: isExpanded,
            showTurkish: showTurkish,
            onTap: () {
              setState(() {
                _expandedIndex = isExpanded ? null : index;
              });
            },
          ).animate(delay: (index * 60).ms).fadeIn(duration: 350.ms).slideY(
                begin: 0.05,
                duration: 350.ms,
                curve: Curves.easeOut,
              );
        },
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// KONU KARTI
// ════════════════════════════════════════════════════════════════

class _GrammarTopicCard extends StatelessWidget {
  final _GrammarTopic topic;
  final bool isExpanded;
  final bool showTurkish;
  final VoidCallback onTap;

  const _GrammarTopicCard({
    required this.topic,
    required this.isExpanded,
    required this.showTurkish,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: AnimatedContainer(
        duration: 300.ms,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: isExpanded ? AppColors.primary.withOpacity(0.4) : AppColors.borderLight,
            width: isExpanded ? 1.5 : 1.0,
          ),
          boxShadow: isExpanded
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Baslik satiri ──────────────────────────────
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      // Ikon
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: topic.color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                        child: Icon(topic.icon, color: topic.color, size: 24),
                      ),
                      const SizedBox(width: AppSpacing.md),

                      // Basliklar
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              topic.titleKu,
                              style: AppTypography.title.copyWith(fontSize: 16),
                            ),
                            if (showTurkish && topic.titleTr != null)
                              Text(
                                topic.titleTr!,
                                style: AppTypography.caption,
                              ),
                          ],
                        ),
                      ),

                      // Seviye rozeti
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: _levelColor(topic.level).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                        ),
                        child: Text(
                          topic.level,
                          style: AppTypography.labelSmall.copyWith(
                            color: _levelColor(topic.level),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      const SizedBox(width: AppSpacing.sm),

                      // Expand ikonu
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0.0,
                        duration: 250.ms,
                        child: Icon(
                          Icons.expand_more_rounded,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Genisleyen icerik ──────────────────────────
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: _TopicContent(topic: topic, showTurkish: showTurkish),
                  crossFadeState:
                      isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: 300.ms,
                  sizeCurve: Curves.easeInOut,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _levelColor(String level) {
    switch (level) {
      case 'A1':
        return AppColors.success;
      case 'A2':
        return AppColors.primary;
      case 'B1':
        return AppColors.accent;
      default:
        return AppColors.textSecondary;
    }
  }
}

// ════════════════════════════════════════════════════════════════
// KONU ICERIGI — Kurallar + Ornekler
// ════════════════════════════════════════════════════════════════

class _TopicContent extends StatelessWidget {
  final _GrammarTopic topic;
  final bool showTurkish;

  const _TopicContent({required this.topic, required this.showTurkish});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: AppColors.borderLight, height: 1),
          const SizedBox(height: AppSpacing.md),

          // Kurallar
          ...topic.rules.map(
            (rule) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Icon(Icons.circle, size: 6, color: AppColors.primary),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(rule, style: AppTypography.bodyGrammar),
                  ),
                ],
              ),
            ),
          ),

          if (topic.examples.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),

            // Ornekler basligi
            Row(
              children: [
                Icon(Icons.lightbulb_outline_rounded,
                    size: 16, color: AppColors.accent),
                const SizedBox(width: 6),
                Text(
                  'Mînak',
                  style: AppTypography.label.copyWith(color: AppColors.accent),
                ),
                if (showTurkish)
                  Text(
                    '  (Ornekler)',
                    style: AppTypography.caption,
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),

            // Ornek kutulari
            ...topic.examples.map(
              (ex) => _ExampleBox(example: ex, showTurkish: showTurkish),
            ),
          ],

          // Ipucu notu
          if (topic.tip != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.warningSurface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(color: AppColors.warning.withOpacity(0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.tips_and_updates_rounded,
                      size: 18, color: AppColors.warning),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      topic.tip!,
                      style: AppTypography.bodyGrammar.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// ORNEK KUTUSU
// ════════════════════════════════════════════════════════════════

class _ExampleBox extends StatelessWidget {
  final _GrammarExample example;
  final bool showTurkish;

  const _ExampleBox({required this.example, required this.showTurkish});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kurmanci — birincil, buyuk
          Text(
            example.ku,
            style: AppTypography.kurmanjiCard.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (showTurkish && example.tr != null) ...[
            const SizedBox(height: 4),
            Text(
              example.tr!,
              style: AppTypography.translation,
            ),
          ],
          if (example.note != null) ...[
            const SizedBox(height: 4),
            Text(
              example.note!,
              style: AppTypography.caption.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// VERi MODELLERi
// ════════════════════════════════════════════════════════════════

class _GrammarExample {
  final String ku;
  final String? tr;
  final String? note;
  const _GrammarExample({required this.ku, this.tr, this.note});
}

class _GrammarTopic {
  final IconData icon;
  final Color color;
  final String titleKu;
  final String? titleTr;
  final String level;
  final List<String> rules;
  final List<_GrammarExample> examples;
  final String? tip;

  const _GrammarTopic({
    required this.icon,
    required this.color,
    required this.titleKu,
    this.titleTr,
    required this.level,
    required this.rules,
    this.examples = const [],
    this.tip,
  });
}

// ════════════════════════════════════════════════════════════════
// GRAMER KONULARI — A1-B1
// ════════════════════════════════════════════════════════════════

final _grammarTopics = <_GrammarTopic>[
  // 1. Alfabe
  _GrammarTopic(
    icon: Icons.abc_rounded,
    color: AppColors.primary,
    titleKu: 'Alfabe û Dengên Kurmancî',
    titleTr: 'Alfabe ve Sesler',
    level: 'A1',
    rules: [
      'Kurmanci 31 tip hene. Tiplerin Latini bi kar tinin.',
      'Tiplerin taybet: e, i, u, x, q, w',
      'e — wek "e" ya direg (mer, ser, ber)',
      'i — wek "i" ya direg (ji, sir, mir)',
      'u — wek "u" ya direg (ku, tu, du)',
      'x — dengeki guleki ye, wek "ch" ya Elmani',
      'q — ji "k" ye qultir e, ji qirika ve te',
      'w — wek "w" ya Inglizi (war, ew, diwar)',
    ],
    examples: [
      _GrammarExample(ku: 'e: ser, ber, der', tr: 'bas, on, kapi'),
      _GrammarExample(ku: 'i: mir, sir, ji', tr: 'emir, sir, -den'),
      _GrammarExample(ku: 'u: ku, tu, du', tr: 'nerede, sen, iki'),
      _GrammarExample(ku: 'x: xwendin, xaniy', tr: 'okumak, ev'),
    ],
    tip: 'Kurmanci de her tip yek deng dide. Tiplerin beden guherinin tune ye!',
  ),

  // 2. Navder u Zayend
  _GrammarTopic(
    icon: Icons.category_rounded,
    color: AppColors.accent,
    titleKu: 'Navder u Zayend',
    titleTr: 'Isimler ve Cinsiyet',
    level: 'A1',
    rules: [
      'Her navderek Kurmanci ya ner (erkek) an me (disi) ye.',
      'Piran navdere bi girsegiyan diqedin ner in.',
      'Piran navdere bi denglikan diqedin me ne.',
      'Ner: kiteb, kes, dar, av, nan',
      'Me: mal, der, pirtuk, ax, cade',
    ],
    examples: [
      _GrammarExample(
        ku: 'kiteb (ner) — kiteba min',
        tr: 'kitap (eril) — benim kitabim',
        note: 'Ner: -e ezafe',
      ),
      _GrammarExample(
        ku: 'mal (me) — mala min',
        tr: 'ev (disil) — benim evim',
        note: 'Me: -a ezafe',
      ),
    ],
    tip: 'Zayende navderan bi birkirin lazim e. Di ferhenge de N (ner) an J (me) dinivisin.',
  ),

  // 3. Ezafe
  _GrammarTopic(
    icon: Icons.link_rounded,
    color: const Color(0xFF7C4DFF),
    titleKu: 'Ezafe',
    titleTr: 'Ezafe Yapisi (Tamlama)',
    level: 'A1',
    rules: [
      'Ezafe navderan bi hev ve giridade.',
      'Ner: -e (deste min = elim)',
      'Me: -a (mala min = evim)',
      'Pirjimar: -en (malten me = evlerimiz)',
      'Ezafe di navbera navder u cinavkan de te.',
    ],
    examples: [
      _GrammarExample(ku: 'deste min', tr: 'elim', note: 'dest (ner) + -e + min'),
      _GrammarExample(ku: 'mala min', tr: 'evim', note: 'mal (me) + -a + min'),
      _GrammarExample(ku: 'kiteba te', tr: 'senin kitabin', note: 'kiteb (ner) + -a? => dikkat: kiteb me ye!'),
      _GrammarExample(ku: 'nave wi', tr: 'onun adi', note: 'nav (ner) + -e + wi'),
    ],
    tip: 'Ezafe, Kurmanci nin en giring qaideye ye. Her roj bikar bine!',
  ),

  // 4. Cinavk
  _GrammarTopic(
    icon: Icons.person_outline_rounded,
    color: AppColors.success,
    titleKu: 'Cinavk',
    titleTr: 'Zamirler',
    level: 'A1',
    rules: [
      'Cinavken kes — rewsa rast (navoki):',
      '  ez (ben), tu (sen), ew (o)',
      '  em (biz), hun (siz), ew (onlar)',
      'Rewsa berz (tewang):',
      '  min (beni/benim), te (seni/senin), wi/we (onu/onun)',
      '  me (bizi/bizim), we (sizi/sizin), wan (onlari/onlarin)',
      'Rewsa berz di dema bori de ji bo kerdox te bikaranin!',
    ],
    examples: [
      _GrammarExample(ku: 'Ez dixwinim.', tr: 'Ben okuyorum.', note: 'Niha: cinavka rast'),
      _GrammarExample(ku: 'Min xwend.', tr: 'Ben okudum.', note: 'Bori: cinavka berz (ergatif!)'),
      _GrammarExample(ku: 'Ew diaxive.', tr: 'O konusuyor.'),
      _GrammarExample(ku: 'Wi got.', tr: 'O (erkek) soyledi.'),
    ],
    tip: 'Di dema bori de kerdox di rewsa berz de ye. Eva ergatif e — ji Tirkiye re cuda ye!',
  ),

  // 5. Leker — Dema Niha
  _GrammarTopic(
    icon: Icons.play_arrow_rounded,
    color: const Color(0xFF0288D1),
    titleKu: 'Leker — Dema Niha',
    titleTr: 'Fiiller — Simdiki Zaman',
    level: 'A1',
    rules: [
      'Pesgiliya di- + koka leker + pasvilla kes:',
      '  ez di-xwin-im (ben okuyorum)',
      '  tu di-xwin-i (sen okuyorsun)',
      '  ew di-xwin-e (o okuyor)',
      '  em di-xwin-in (biz okuyoruz)',
      '  hun di-xwin-in (siz okuyorsunuz)',
      '  ew di-xwin-in (onlar okuyorlar)',
      'Lekeren bi "di" ve dest pe dikin, du "di" nabe: diaxive (ne di-diaxive).',
    ],
    examples: [
      _GrammarExample(ku: 'Ez dixwinim.', tr: 'Ben okuyorum.'),
      _GrammarExample(ku: 'Tu diaxivi.', tr: 'Sen konusuyorsun.'),
      _GrammarExample(ku: 'Em dicin.', tr: 'Biz gidiyoruz.'),
      _GrammarExample(ku: 'Ew nan dixwin.', tr: 'Onlar ekmek yiyor.'),
    ],
    tip: 'Pesgiliya "di-" her dem heye. Eger kok bi "di-" dest pe bike, yek "di" bes e.',
  ),

  // 6. Leker — Dema Bori
  _GrammarTopic(
    icon: Icons.history_rounded,
    color: const Color(0xFF6D4C9F),
    titleKu: 'Leker — Dema Bori',
    titleTr: 'Fiiller — Gecmis Zaman',
    level: 'A2',
    rules: [
      'Ergatif avahiy: Di dema bori de kerdox rewsa berz digire!',
      'Lekeren veguhezi (transitif): MIN dit. (Ben gordum.)',
      '  Kerdox (min) di rewsa berz de ye.',
      'Lekeren neveguhezi (intransitif): EZ catim. (Ben gittim.)',
      '  Kerdox (ez) di rewsa rast de dimane.',
      'Koka bori ji masdar hat:',
      '  xwendin → xwend, ditin → dit, cun → cu',
    ],
    examples: [
      _GrammarExample(ku: 'Min dit.', tr: 'Ben gordum.', note: 'Veguhezi: min (berz) + dit'),
      _GrammarExample(ku: 'Te xwend.', tr: 'Sen okudun.', note: 'Veguhezi: te (berz) + xwend'),
      _GrammarExample(ku: 'Ez catim.', tr: 'Ben gittim.', note: 'Neveguhezi: ez (rast) + catim'),
      _GrammarExample(ku: 'Em hatin.', tr: 'Biz geldik.', note: 'Neveguhezi: em (rast) + hatin'),
    ],
    tip: 'Ergatif, Kurmanci nin en cuda taybetiye ye. "MIN dit" = Ben gordum — "min" ne "beni" ye, kerdox e!',
  ),

  // 7. Neyini
  _GrammarTopic(
    icon: Icons.block_rounded,
    color: AppColors.errorSoft,
    titleKu: 'Neyini',
    titleTr: 'Olumsuzluk',
    level: 'A2',
    rules: [
      'Dema niha: na- li sawe di- te:',
      '  dixwinim → naxwinim (okumuyorum)',
      'Dema bori: ne- pesgiliya ye:',
      '  xwend → nexwend (okumadi)',
      'Fermankar (emir): me- an ne-:',
      '  mexwine! (okuma!), nece! (gitme!)',
    ],
    examples: [
      _GrammarExample(ku: 'Ez naxwinim.', tr: 'Ben okumuyorum.'),
      _GrammarExample(ku: 'Tu naciy.', tr: 'Sen gitmiyorsun.'),
      _GrammarExample(ku: 'Wi nexwend.', tr: 'O okumadi.'),
      _GrammarExample(ku: 'Mexwine!', tr: 'Okuma!', note: 'Fermankar — neyini'),
    ],
    tip: 'Niha: di- → na-. Bori: ne- li ber kok. Du qaideyen hasan!',
  ),

  // 8. Dacek
  _GrammarTopic(
    icon: Icons.swap_horiz_rounded,
    color: const Color(0xFF00897B),
    titleKu: 'Dacek',
    titleTr: 'Edat ve Cevre-Edatlar',
    level: 'A2',
    rules: [
      'di...de — di nav ... de (icinde):',
      '  di male de (evde)',
      'ji...re — ji bo ... re (icin):',
      '  ji min re (benim icin)',
      'li — li ... (de, da):',
      '  li male (evde), li bazare (carsida)',
      'bi — bi ... (ile):',
      '  bi dest (elle), bi hev re (birlikte)',
    ],
    examples: [
      _GrammarExample(ku: 'Ez di male de me.', tr: 'Ben evdeyim.'),
      _GrammarExample(ku: 'Ji min re beje.', tr: 'Bana soyle.'),
      _GrammarExample(ku: 'Ew li dibistane ye.', tr: 'O okulda.'),
      _GrammarExample(ku: 'Em bi hev re dicin.', tr: 'Birlikte gidiyoruz.'),
    ],
    tip: 'Daceken Kurmanci piran du-par in (circum-position): di...de, ji...re. Her du paran ji bi birkinin!',
  ),

  // 9. Pirjimar
  _GrammarTopic(
    icon: Icons.format_list_numbered_rounded,
    color: const Color(0xFFEF6C00),
    titleKu: 'Pirjimar',
    titleTr: 'Cogul',
    level: 'A2',
    rules: [
      'Pasvilla pirjimar: -an',
      '  zarok → zarokan (cocuklar)',
      '  kiteb → kiteban (kitaplar)',
      'Hinek navder bi -in an -en pirjimar dibin:',
      '  mirov → mirovan (insanlar)',
      'Ezafe di pirjimar de: -en',
      '  malten me (evlerimiz)',
    ],
    examples: [
      _GrammarExample(ku: 'zarok → zarokan', tr: 'cocuk → cocuklar'),
      _GrammarExample(ku: 'dar → daran', tr: 'agac → agaclar'),
      _GrammarExample(ku: 'malten me', tr: 'evlerimiz', note: 'Pirjimar ezafe: -en'),
      _GrammarExample(ku: 'kiteben wi', tr: 'onun kitaplari', note: 'Pirjimar ezafe: -en'),
    ],
    tip: 'Piran navder + -an = pirjimar. Hasan e!',
  ),

  // 10. Hevoken Rojane
  _GrammarTopic(
    icon: Icons.chat_bubble_outline_rounded,
    color: AppColors.primaryDark,
    titleKu: 'Hevoken Rojane',
    titleTr: 'Gunluk Cumleler',
    level: 'A1',
    rules: [
      'Silaven roje:',
      '  Roj bas! (Gunaydin!)',
      '  Eves bas! (Iyi aksamlar!)',
      '  Bi xatire te! (Hosca kal!)',
      'Pirsyaren bingeh:',
      '  Tu cawa yi? (Nasilsin?)',
      '  Ez basm, spas. (Iyiyim, tesekkurler.)',
      '  Nave te ci ye? (Adin ne?)',
      '  Nave min ... e. (Adim ...)',
    ],
    examples: [
      _GrammarExample(ku: 'Roj bas! Tu cawa yi?', tr: 'Gunaydin! Nasilsin?'),
      _GrammarExample(ku: 'Ez basm, spas. Tu?', tr: 'Iyiyim, tesekkurler. Sen?'),
      _GrammarExample(ku: 'Nave min Amed e.', tr: 'Adim Amed.'),
      _GrammarExample(ku: 'Xatira te! Sibe bibinim.', tr: 'Hosca kal! Yarin goruselim.'),
    ],
    tip: '"Spas" (tesekkur) u "xer hati" (hosgeldin) — her roj bikar bine!',
  ),
];
