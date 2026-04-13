import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../shared/providers/language_mode_provider.dart';

// ════════════════════════════════════════════════════════════════
// RÊZIMAN — Kurmancî Gramer Rehberi (A1–B1)
// Duolingo "Tips" tarzı: konu kartları + genişleyen detay.
// Îlke 0.5: Kurmancî bîrincîl dil.
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
                // ── Başlık satırı ──────────────────────────────
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

                // ── Genişleyen içerik ──────────────────────────
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
// KONU İÇERİĞİ — Kurallar + Örnekler
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
                    '  (Örnekler)',
                    style: AppTypography.caption,
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),

            // Örnek kutuları
            ...topic.examples.map(
              (ex) => _ExampleBox(example: ex, showTurkish: showTurkish),
            ),
          ],

          // İpucu notu
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
// ÖRNEK KUTUSU
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
          // Kurmancî — birincil, büyük
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
// VERİ MODELLERİ
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
      'Kurmancî 31 tîp hene. Tîpên Latînî bi kar tînin.',
      'Tîpên taybet: ê, î, û, x, q, w',
      'ê — wek "e" ya dirêj (mêr, sêr, bêr)',
      'î — wek "i" ya dirêj (jî, şîr, mîr)',
      'û — wek "u" ya dirêj (kû, tû, dû)',
      'x — dengekî gulekî ye, wek "ch" ya Elmanî',
      'q — ji "k" ye qûltir e, ji qirika ve tê',
      'w — wek "w" ya Îngîlîzî (war, ew, dîwar)',
    ],
    examples: [
      _GrammarExample(ku: 'ê: sêr, bêr, dêr', tr: 'baş, ön, kapı'),
      _GrammarExample(ku: 'î: mîr, şîr, jî', tr: 'emir, süt, -den'),
      _GrammarExample(ku: 'û: kû, tû, dû', tr: 'nerede, sen, iki'),
      _GrammarExample(ku: 'x: xwendin, xanî', tr: 'okumak, ev'),
    ],
    tip: 'Kurmancî de her tîp yek deng dide. Tîpên bedên guherînin tune ye!',
  ),

  // 2. Navdêr û Zayend
  _GrammarTopic(
    icon: Icons.category_rounded,
    color: AppColors.accent,
    titleKu: 'Navdêr û Zayend',
    titleTr: 'İsimler ve Cinsiyet',
    level: 'A1',
    rules: [
      'Her navdêrek Kurmancî ya nêr (erkek) an mê (dişi) ye.',
      'Pîran navdêrê bi girsegîyan diqedin nêr in.',
      'Pîran navdêrê bi denglîkan diqedin mê ne.',
      'Nêr: kitêb, kes, dar, av, nan',
      'Mê: mal, dêr, pirtûk, ax, cade',
    ],
    examples: [
      _GrammarExample(
        ku: 'kitêb (nêr) — kitêba min',
        tr: 'kitap (eril) — benim kitabım',
        note: 'Nêr: -ê ezafe',
      ),
      _GrammarExample(
        ku: 'mal (mê) — mala min',
        tr: 'ev (dişil) — benim evim',
        note: 'Mê: -a ezafe',
      ),
    ],
    tip: 'Zayendê navdêran bi bîrkirîn lazim e. Di ferhengê de N (nêr) an J (mê) dinivîsîn.',
  ),

  // 3. Ezafe
  _GrammarTopic(
    icon: Icons.link_rounded,
    color: const Color(0xFF7C4DFF),
    titleKu: 'Ezafe',
    titleTr: 'Ezafe Yapısı (Tamlama)',
    level: 'A1',
    rules: [
      'Ezafe navdêran bi hev ve girêdide.',
      'Nêr: -ê (destê min = elim)',
      'Mê: -a (mala min = evim)',
      'Pîrjimar: -ên (maltên me = evlerimiz)',
      'Ezafe di navbêra navdêr û cinavkan de tê.',
    ],
    examples: [
      _GrammarExample(ku: 'destê min', tr: 'elim', note: 'dest (nêr) + -ê + min'),
      _GrammarExample(ku: 'mala min', tr: 'evim', note: 'mal (mê) + -a + min'),
      _GrammarExample(ku: 'kitêba te', tr: 'senin kitabın', note: 'kitêb (mê) + -a + te'),
      _GrammarExample(ku: 'navê wî', tr: 'onun adı', note: 'nav (nêr) + -ê + wî'),
    ],
    tip: 'Ezafe, Kurmancî nin en girîng qaîdeye ye. Her roj bikar bîne!',
  ),

  // 4. Cinavk
  _GrammarTopic(
    icon: Icons.person_outline_rounded,
    color: AppColors.success,
    titleKu: 'Cinavk',
    titleTr: 'Zamirler',
    level: 'A1',
    rules: [
      'Cinavkên kes — rewşa rast (navokî):',
      '  ez (ben), tu (sen), ew (o)',
      '  em (biz), hûn (siz), ew (onlar)',
      'Rewşa berz (tewang):',
      '  min (beni/benim), te (seni/senin), wî/wê (onu/onun)',
      '  me (bizi/bizim), we (sizi/sizin), wan (onları/onların)',
      'Rewşa berz di dema borî de ji bo kerdox tê bikaranîn!',
    ],
    examples: [
      _GrammarExample(ku: 'Ez dixwînim.', tr: 'Ben okuyorum.', note: 'Niha: cinavka rast'),
      _GrammarExample(ku: 'Min xwend.', tr: 'Ben okudum.', note: 'Borî: cinavka berz (ergatîf!)'),
      _GrammarExample(ku: 'Ew diaxive.', tr: 'O konuşuyor.'),
      _GrammarExample(ku: 'Wî got.', tr: 'O (erkek) söyledi.'),
    ],
    tip: 'Di dema borî de kerdox di rewşa berz de ye. Eva ergatîf e — ji Tirkiyê re cuda ye!',
  ),

  // 5. Lêker — Dema Niha
  _GrammarTopic(
    icon: Icons.play_arrow_rounded,
    color: const Color(0xFF0288D1),
    titleKu: 'Lêker — Dema Niha',
    titleTr: 'Fiiller — Şimdiki Zaman',
    level: 'A1',
    rules: [
      'Pêşgilîya di- + koka lêker + paşvilla kes:',
      '  ez di-xwîn-im (ben okuyorum)',
      '  tu di-xwîn-î (sen okuyorsun)',
      '  ew di-xwîn-e (o okuyor)',
      '  em di-xwîn-in (biz okuyoruz)',
      '  hûn di-xwîn-in (siz okuyorsunuz)',
      '  ew di-xwîn-in (onlar okuyorlar)',
      'Lêkerên bi "di" ve dest pê dikin, du "di" nabe: diaxive (ne di-diaxive).',
    ],
    examples: [
      _GrammarExample(ku: 'Ez dixwînim.', tr: 'Ben okuyorum.'),
      _GrammarExample(ku: 'Tu diaxivî.', tr: 'Sen konuşuyorsun.'),
      _GrammarExample(ku: 'Em diçin.', tr: 'Biz gidiyoruz.'),
      _GrammarExample(ku: 'Ew nan dixwin.', tr: 'Onlar ekmek yiyor.'),
    ],
    tip: 'Pêşgilîya "di-" her dem heye. Eger kok bi "di-" dest pê bike, yek "di" bes e.',
  ),

  // 6. Lêker — Dema Borî
  _GrammarTopic(
    icon: Icons.history_rounded,
    color: const Color(0xFF6D4C9F),
    titleKu: 'Lêker — Dema Borî',
    titleTr: 'Fiiller — Geçmiş Zaman',
    level: 'A2',
    rules: [
      'Ergatîf avahî: Di dema borî de kerdox rewşa berz digire!',
      'Lêkerên veguhêzî (transîtîf): MIN dît. (Ben gördüm.)',
      '  Kerdox (min) di rewşa berz de ye.',
      'Lêkerên neveguhêzî (întransîtîf): EZ çûm. (Ben gittim.)',
      '  Kerdox (ez) di rewşa rast de dimîne.',
      'Koka borî ji masdar hat:',
      '  xwendin → xwend, dîtin → dît, çûn → çû',
    ],
    examples: [
      _GrammarExample(ku: 'Min dît.', tr: 'Ben gördüm.', note: 'Veguhêzî: min (berz) + dît'),
      _GrammarExample(ku: 'Te xwend.', tr: 'Sen okudun.', note: 'Veguhêzî: te (berz) + xwend'),
      _GrammarExample(ku: 'Ez çûm.', tr: 'Ben gittim.', note: 'Neveguhêzî: ez (rast) + çûm'),
      _GrammarExample(ku: 'Em hatin.', tr: 'Biz geldik.', note: 'Neveguhêzî: em (rast) + hatin'),
    ],
    tip: 'Ergatîf, Kurmancî nin en cuda taybetîye ye. "MIN dît" = Ben gördüm — "min" ne "beni" ye, kerdox e!',
  ),

  // 7. Neyînî
  _GrammarTopic(
    icon: Icons.block_rounded,
    color: AppColors.errorSoft,
    titleKu: 'Neyînî',
    titleTr: 'Olumsuzluk',
    level: 'A2',
    rules: [
      'Dema niha: na- li şawê di- tê:',
      '  dixwînim → naxwînim (okumuyorum)',
      'Dema borî: ne- pêşgilîya ye:',
      '  xwend → nexwend (okumadı)',
      'Fermankar (emir): me- an ne-:',
      '  mexwîne! (okuma!), neçe! (gitme!)',
    ],
    examples: [
      _GrammarExample(ku: 'Ez naxwînim.', tr: 'Ben okumuyorum.'),
      _GrammarExample(ku: 'Tu naçî.', tr: 'Sen gitmiyorsun.'),
      _GrammarExample(ku: 'Wî nexwend.', tr: 'O okumadı.'),
      _GrammarExample(ku: 'Mexwîne!', tr: 'Okuma!', note: 'Fermankar — neyînî'),
    ],
    tip: 'Niha: di- → na-. Borî: ne- li ber kok. Du qaîdeyên hêsan!',
  ),

  // 8. Daçek
  _GrammarTopic(
    icon: Icons.swap_horiz_rounded,
    color: const Color(0xFF00897B),
    titleKu: 'Daçek',
    titleTr: 'Edat ve Çevre-Edatlar',
    level: 'A2',
    rules: [
      'di...de — di nav ... de (içinde):',
      '  di malê de (evde)',
      'ji...re — ji bo ... re (için):',
      '  ji min re (benim için)',
      'li — li ... (de, da):',
      '  li malê (evde), li bazarê (çarşıda)',
      'bi — bi ... (ile):',
      '  bi dest (elle), bi hev re (birlikte)',
    ],
    examples: [
      _GrammarExample(ku: 'Ez di malê de me.', tr: 'Ben evdeyim.'),
      _GrammarExample(ku: 'Ji min re bêje.', tr: 'Bana söyle.'),
      _GrammarExample(ku: 'Ew li dibistanê ye.', tr: 'O okulda.'),
      _GrammarExample(ku: 'Em bi hev re diçin.', tr: 'Birlikte gidiyoruz.'),
    ],
    tip: 'Daçekên Kurmancî pîran du-par in (circum-position): di...de, ji...re. Her du paran jî bi bîrkinin!',
  ),

  // 9. Pîrjimar
  _GrammarTopic(
    icon: Icons.format_list_numbered_rounded,
    color: const Color(0xFFEF6C00),
    titleKu: 'Pîrjimar',
    titleTr: 'Çoğul',
    level: 'A2',
    rules: [
      'Paşvilla pîrjimar: -an',
      '  zarok → zarokan (çocuklar)',
      '  kitêb → kitêban (kitaplar)',
      'Hinên navdêr bi -in an -ên pîrjimar dibin:',
      '  mirov → mirovan (insanlar)',
      'Ezafe di pîrjimar de: -ên',
      '  maltên me (evlerimiz)',
    ],
    examples: [
      _GrammarExample(ku: 'zarok → zarokan', tr: 'çocuk → çocuklar'),
      _GrammarExample(ku: 'dar → daran', tr: 'ağaç → ağaçlar'),
      _GrammarExample(ku: 'maltên me', tr: 'evlerimiz', note: 'Pîrjimar ezafe: -ên'),
      _GrammarExample(ku: 'kitêbên wî', tr: 'onun kitapları', note: 'Pîrjimar ezafe: -ên'),
    ],
    tip: 'Pîran navdêr + -an = pîrjimar. Hêsan e!',
  ),

  // 10. Hevokên Rojane
  _GrammarTopic(
    icon: Icons.chat_bubble_outline_rounded,
    color: AppColors.primaryDark,
    titleKu: 'Hevokên Rojane',
    titleTr: 'Günlük Cümleler',
    level: 'A1',
    rules: [
      'Silavên rojê:',
      '  Roj baş! (Günaydın!)',
      '  Êvar baş! (İyi akşamlar!)',
      '  Bi xatirê te! (Hoşça kal!)',
      'Pirsyarên bingehîn:',
      '  Tu çawa yî? (Nasılsın?)',
      '  Ez başim, spas. (İyiyim, teşekkürler.)',
      '  Navê te çi ye? (Adın ne?)',
      '  Navê min ... e. (Adım ...)',
    ],
    examples: [
      _GrammarExample(ku: 'Roj baş! Tu çawa yî?', tr: 'Günaydın! Nasılsın?'),
      _GrammarExample(ku: 'Ez başim, spas. Tu?', tr: 'İyiyim, teşekkürler. Sen?'),
      _GrammarExample(ku: 'Navê min Amed e.', tr: 'Adım Amed.'),
      _GrammarExample(ku: 'Xatirê te! Sibê bibînim.', tr: 'Hoşça kal! Yarın görüşelim.'),
    ],
    tip: '"Spas" (teşekkür) û "xêr hatî" (hoşgeldin) — her roj bikar bîne!',
  ),
];
