import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../shared/providers/language_mode_provider.dart';
import 'cultural_entities.dart';

// ════════════════════════════════════════════════════════════════
// KÜLTÜREL ÖDÜL KARTI
//
// Araştırma Bulgusu #6: Kültürel içerik asıl motivasyon.
// Her birim sonunda açılan bu kart "ek özellik" değil,
// öğrenme döngüsünün zorunlu bir parçası.
// Ücretsiz — premium duvarı yok.
// ════════════════════════════════════════════════════════════════

class CulturalRewardCard extends StatefulWidget {
  final CulturalItem item;
  final VoidCallback? onContinue;
  final VoidCallback? onShare;

  const CulturalRewardCard({
    super.key,
    required this.item,
    this.onContinue,
    this.onShare,
  });

  @override
  State<CulturalRewardCard> createState() => _CulturalRewardCardState();
}

class _CulturalRewardCardState extends State<CulturalRewardCard> {
  bool _isPlaying = false;
  bool _showTranslation = false;
  bool _showNote = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: AppRadius.xl,
        border: Border.all(
          color: AppColors.primary.withOpacity(0.25),
          width: AppSpacing.borderMedium,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Üst başlık bandı ──────────────────────────────────
          _CardHeader(item: widget.item),

          // ── Ana içerik ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Kurmancî içerik — büyük, birincil
                Text(
                  widget.item.kurmanjContent,
                  style: AppTypography.kurmanji.copyWith(
                    color: AppColors.primaryDark,
                    height: 1.8,
                    fontStyle: widget.item.type == CulturalContentType.poem ||
                            widget.item.type == CulturalContentType.song
                        ? FontStyle.italic
                        : FontStyle.normal,
                  ),
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.1, end: 0),

                Gap.md,

                // Ses butonu
                if (widget.item.audioAsset != null)
                  Center(
                    child: _AudioButton(
                      isPlaying: _isPlaying,
                      onTap: () {
                        setState(() => _isPlaying = true);
                        Future.delayed(const Duration(seconds: 3), () {
                          if (mounted) setState(() => _isPlaying = false);
                        });
                      },
                    ),
                  ).animate(delay: 400.ms).fadeIn(),

                Gap.md,

                // Türkçe çeviri toggle — only when showTurkish
                Consumer(builder: (_, ref, __) {
                  if (!ref.watch(showTurkishProvider)) return const SizedBox.shrink();
                  return _ToggleSection(
                    label: 'Türkçe çeviri',
                    isOpen: _showTranslation,
                    onToggle: () =>
                        setState(() => _showTranslation = !_showTranslation),
                    child: Text(
                      widget.item.turkishContent,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.7,
                        fontStyle: widget.item.type == CulturalContentType.poem ||
                                widget.item.type == CulturalContentType.song
                            ? FontStyle.italic
                            : FontStyle.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ).animate(delay: 500.ms).fadeIn();
                }),

                // Kültürel arka plan notu
                if (widget.item.backgroundNote != null) ...[
                  Gap.sm,
                  _ToggleSection(
                    label: 'Kültürel arka plan',
                    isOpen: _showNote,
                    onToggle: () => setState(() => _showNote = !_showNote),
                    child: Text(
                      widget.item.backgroundNote!,
                      style: AppTypography.bodyGrammar.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ).animate(delay: 600.ms).fadeIn(),
                ],

                Gap.lg,

                // İlgili kelimeler
                if (widget.item.keywords.isNotEmpty)
                  _KeywordsRow(keywords: widget.item.keywords)
                      .animate(delay: 700.ms)
                      .fadeIn(),

                Gap.lg,

                // Alt butonlar
                Row(
                  children: [
                    if (widget.onShare != null)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: widget.onShare,
                          icon: const Icon(Icons.share_outlined, size: 16),
                          label: Text(
                            'Paylaş',
                            style: AppTypography.label.primary,
                          ),
                        ),
                      ),
                    if (widget.onShare != null) Gap.hSm,
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: widget.onContinue,
                        child: Text(
                          'Berdewam bike →',
                          style: AppTypography.labelLarge.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ).animate(delay: 800.ms).fadeIn(),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic);
  }
}

// ── Kart Başlığı ─────────────────────────────────────────────────

class _CardHeader extends StatelessWidget {
  final CulturalItem item;
  const _CardHeader({required this.item});

  Color get _accentColor => switch (item.type) {
        CulturalContentType.proverb => AppColors.primary,
        CulturalContentType.song => AppColors.accent,
        CulturalContentType.poem => AppColors.primaryLight,
        CulturalContentType.story => AppColors.accent,
        CulturalContentType.celebration => AppColors.accent,
        CulturalContentType.foodTradition => AppColors.success,
        CulturalContentType.culturalNote => AppColors.primaryLight,
        CulturalContentType.historicalFigure => AppColors.primaryDark,
      };

  IconData get _icon => switch (item.type) {
        CulturalContentType.proverb => Icons.format_quote,
        CulturalContentType.song => Icons.music_note,
        CulturalContentType.poem => Icons.auto_stories,
        CulturalContentType.story => Icons.menu_book,
        CulturalContentType.celebration => Icons.celebration,
        CulturalContentType.foodTradition => Icons.restaurant,
        CulturalContentType.culturalNote => Icons.info_outline,
        CulturalContentType.historicalFigure => Icons.person_outline,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: _accentColor.withOpacity(0.08),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXl),
        ),
        border: Border(
          bottom: BorderSide(
            color: _accentColor.withOpacity(0.15),
            width: AppSpacing.borderThin,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(_icon, color: _accentColor, size: 20),
          Gap.hSm,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kurmancî tür adı — birincil
              Text(item.typeLabel,
                  style: AppTypography.captionStrong
                      .copyWith(color: _accentColor)),
              // Türkçe tür — ikincil (only when showTurkish)
              Consumer(builder: (_, ref, __) {
                if (!ref.watch(showTurkishProvider)) return const SizedBox.shrink();
                return Text(item.typeTurkish, style: AppTypography.caption);
              }),
            ],
          ),
          const Spacer(),
          // Kültürel içerik ücretsiz rozeti
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.12),
              borderRadius: AppRadius.full,
            ),
            child: Consumer(builder: (_, ref, __) {
              final showTr = ref.watch(showTurkishProvider);
              return Text(
                showTr ? 'Azad · Ücretsiz' : 'Azad',
                style: AppTypography.caption.copyWith(
                  color: AppColors.success,
                  fontSize: 10,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ── Ses Butonu ───────────────────────────────────────────────────

class _AudioButton extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onTap;

  const _AudioButton({required this.isPlaying, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isPlaying ? AppColors.primarySurface : AppColors.backgroundPrimary,
          borderRadius: AppRadius.full,
          border: Border.all(
            color: isPlaying ? AppColors.primary : AppColors.borderLight,
            width: isPlaying ? AppSpacing.borderMedium : AppSpacing.borderThin,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isPlaying ? Icons.volume_up : Icons.play_circle_outline,
              color: isPlaying ? AppColors.primary : AppColors.textSecondary,
              size: 20,
            ),
            Gap.hSm,
            Text(
              isPlaying ? 'Çalıyor...' : 'Sesi dinle',
              style: AppTypography.label.copyWith(
                color: isPlaying ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Toggle Bölümü ────────────────────────────────────────────────

class _ToggleSection extends StatelessWidget {
  final String label;
  final bool isOpen;
  final VoidCallback onToggle;
  final Widget child;

  const _ToggleSection({
    required this.label,
    required this.isOpen,
    required this.onToggle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: onToggle,
          child: Row(
            children: [
              Text(label,
                  style: AppTypography.captionStrong.primary),
              const Spacer(),
              Icon(
                isOpen ? Icons.expand_less : Icons.expand_more,
                color: AppColors.primary,
                size: 18,
              ),
            ],
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: child,
          ),
          crossFadeState: isOpen
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}

// ── Anahtar Kelimeler ────────────────────────────────────────────

class _KeywordsRow extends StatelessWidget {
  final List<String> keywords;
  const _KeywordsRow({required this.keywords});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bu içerikteki kelimeler:',
            style: AppTypography.captionStrong),
        Gap.xs,
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: keywords.map((word) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: AppRadius.full,
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Text(
                word,
                style: AppTypography.captionStrong.primary,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// KÜLTÜR YOLU ANA EKRANI — Rêya Çandê
// Tüm kültürel içeriklerin listelendiği ekran
// ════════════════════════════════════════════════════════════════

class CulturalScreen extends ConsumerWidget {
  const CulturalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grouped = _groupByType(kCulturalItems.where((i) => i.level <= 1));

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Başlık ──────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md, AppSpacing.lg, AppSpacing.md, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kurmancî başlık
                    Text('Rêya Çandê',
                        style: AppTypography.headline.copyWith(
                          color: AppColors.primary,
                        )),
                    // Türkçe ikincil — only when showTurkish
                    if (ref.watch(showTurkishProvider)) ...[
                      Text('Kültür Yolu',
                          style: AppTypography.caption),
                      Gap.sm,
                      Text(
                        'Türküler, atasözleri, şiirler — Kürt kültürünün özü.\n'
                        'Bu içeriklerin tümü ücretsizdir.',
                        style: AppTypography.body.muted,
                      ),
                    ],
                  ],
                ).animate().fadeIn(duration: 400.ms),
              ),
            ),

            SliverToBoxAdapter(child: Gap.lg),

            // ── Newroz özel banner ────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: AppSpacing.pageHorizontal,
                child: _NewrozBanner()
                    .animate(delay: 200.ms)
                    .fadeIn(duration: 400.ms),
              ),
            ),

            SliverToBoxAdapter(child: Gap.lg),

            // ── Her tip için bölüm ────────────────────────────────
            ...grouped.entries.map((entry) => [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md, 0, AppSpacing.md, AppSpacing.sm),
                  child: _SectionHeader(type: entry.key),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) {
                    final item = entry.value[i];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(
                          AppSpacing.md, 0, AppSpacing.md, AppSpacing.sm),
                      child: _CulturalListTile(
                        item: item,
                        delay: Duration(milliseconds: i * 80),
                      ),
                    );
                  },
                  childCount: entry.value.length,
                ),
              ),
              const SliverToBoxAdapter(child: Gap.md),
            ]).expand((e) => e),

            const SliverToBoxAdapter(child: Gap.xxl),
          ],
        ),
      ),
    );
  }

  Map<CulturalContentType, List<CulturalItem>> _groupByType(
      Iterable<CulturalItem> items) {
    final map = <CulturalContentType, List<CulturalItem>>{};
    for (final item in items) {
      map.putIfAbsent(item.type, () => []).add(item);
    }
    return map;
  }
}

// ── Newroz Banner ────────────────────────────────────────────────

class _NewrozBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newroz = kCulturalItems.firstWhere((i) => i.id == 'c_newroz');

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NewrozScreen(item: newroz)),
        ),
        borderRadius: AppRadius.lg,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.accent.withOpacity(0.15),
                AppColors.primary.withOpacity(0.15),
              ],
            ),
            borderRadius: AppRadius.lg,
            border: Border.all(
              color: AppColors.accent.withOpacity(0.3),
              width: AppSpacing.borderMedium,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.15),
                  borderRadius: AppRadius.md,
                ),
                child: const Icon(
                  Icons.local_fire_department,
                  color: AppColors.accent,
                  size: 32,
                ),
              ),
              Gap.hMd,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kurmancî — büyük, birincil
                    Text('Newroz Pîroz Be!',
                        style: AppTypography.kurmanjiCard.copyWith(
                          color: AppColors.accent,
                        )),
                    // Türkçe — küçük, ikincil (only when showTurkish)
                    Consumer(builder: (_, ref, __) {
                      if (!ref.watch(showTurkishProvider)) return const SizedBox.shrink();
                      return Text('Kürt Yeni Yılı — 21 Mart',
                          style: AppTypography.caption);
                    }),
                    Gap.xs,
                    Consumer(builder: (_, ref, __) {
                      final showTr = ref.watch(showTurkishProvider);
                      return Text(
                        showTr ? 'Kawa\'nın hikayesini keşfet' : 'Çîroka Kawa bibîne',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right,
                  color: AppColors.accent, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Bölüm Başlığı ────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final CulturalContentType type;
  const _SectionHeader({required this.type});

  static final _sample = CulturalItem(
    id: '', type: CulturalContentType.proverb,
    kurmanjTitle: '', turkishTitle: '',
    kurmanjContent: '', turkishContent: '',
    level: 1, unitId: '',
  );

  @override
  Widget build(BuildContext context) {
    final item = CulturalItem(
      id: 'tmp',
      type: type,
      kurmanjTitle: '',
      turkishTitle: '',
      kurmanjContent: '',
      turkishContent: '',
      level: 1,
      unitId: '',
    );

    return Row(
      children: [
        Text(item.typeLabel,
            style: AppTypography.title.copyWith(color: AppColors.primary)),
        Gap.hSm,
        Text('/ ${item.typeTurkish}', style: AppTypography.caption),
      ],
    );
  }
}

// ── Liste Satırı ─────────────────────────────────────────────────

class _CulturalListTile extends StatelessWidget {
  final CulturalItem item;
  final Duration delay;

  const _CulturalListTile({required this.item, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CulturalDetailScreen(item: item),
          ),
        ),
        borderRadius: AppRadius.lg,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: AppRadius.lg,
            border: Border.all(
              color: AppColors.borderLight,
              width: AppSpacing.borderThin,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kurmancî başlık — büyük, birincil
              Text(item.kurmanjTitle,
                  style: AppTypography.kurmanjiCard.copyWith(
                    color: AppColors.primaryDark,
                  )),
              Gap.xs,
              // Türkçe — ikincil (only when showTurkish)
              Consumer(builder: (_, ref, __) {
                if (!ref.watch(showTurkishProvider)) return const SizedBox.shrink();
                return Text(item.turkishTitle, style: AppTypography.caption);
              }),
              Gap.sm,
              // İçerik önizleme
              Text(
                item.kurmanjContent.split('\n').first,
                style: AppTypography.body.muted,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    )
        .animate(delay: delay)
        .fadeIn(duration: 350.ms)
        .slideX(begin: 0.05, end: 0);
  }
}

// ════════════════════════════════════════════════════════════════
// KÜLTÜREL İÇERİK DETAY EKRANI
// ════════════════════════════════════════════════════════════════

class CulturalDetailScreen extends StatelessWidget {
  final CulturalItem item;
  const CulturalDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: Column(
          children: [
            // Kurmancî başlık — birincil
            Text(item.typeLabel,
                style: AppTypography.label.copyWith(color: AppColors.primary)),
            // Türkçe — ikincil (only when showTurkish)
            Consumer(builder: (_, ref, __) {
              if (!ref.watch(showTurkishProvider)) return const SizedBox.shrink();
              return Text(item.typeTurkish, style: AppTypography.caption);
            }),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: CulturalRewardCard(
          item: item,
          onContinue: () => Navigator.pop(context),
          onShare: () {
            // Paylaşım Faz 5'te
          },
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// NEWROZ ÖZEL EKRANI
// ════════════════════════════════════════════════════════════════

class NewrozScreen extends StatefulWidget {
  final CulturalItem item;
  const NewrozScreen({super.key, required this.item});

  @override
  State<NewrozScreen> createState() => _NewrozScreenState();
}

class _NewrozScreenState extends State<NewrozScreen>
    with TickerProviderStateMixin {
  late AnimationController _fireController;
  late Animation<double> _fireAnim;

  @override
  void initState() {
    super.initState();
    _fireController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _fireAnim = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _fireController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fireController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1F1C), // Koyu gece rengi
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppSpacing.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Gap.xl,

                // Ateş animasyonu
                Center(
                  child: AnimatedBuilder(
                    animation: _fireAnim,
                    builder: (_, __) => Transform.scale(
                      scale: _fireAnim.value,
                      child: const Icon(
                        Icons.local_fire_department,
                        color: AppColors.accent,
                        size: 96,
                      ),
                    ),
                  ),
                ).animate().fadeIn(duration: 600.ms),

                Gap.lg,

                // Newroz kutlaması — Kurmancî büyük, birincil
                Text(
                  'Newroz Pîroz Be!',
                  style: AppTypography.display.copyWith(
                    color: AppColors.accent,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ).animate(delay: 300.ms).fadeIn(duration: 600.ms),

                Gap.xs,

                // Türkçe — ikincil (only when showTurkish)
                Consumer(builder: (_, ref, __) {
                  if (!ref.watch(showTurkishProvider)) return const SizedBox.shrink();
                  return Text(
                    'Nevruz Kutlu Olsun!',
                    style: AppTypography.body.copyWith(
                      color: AppColors.accent.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ).animate(delay: 500.ms).fadeIn();
                }),

                Gap.xl,

                // Newroz içerik kartı
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.darkSurface,
                    borderRadius: AppRadius.xl,
                    border: Border.all(
                      color: AppColors.accent.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Kurmancî içerik
                      Text(
                        widget.item.kurmanjContent,
                        style: AppTypography.kurmanji.copyWith(
                          color: Colors.white,
                          height: 2.0,
                        ),
                        textAlign: TextAlign.center,
                      ).animate(delay: 600.ms).fadeIn(),

                      Gap.lg,

                      const Divider(color: Colors.white24),

                      Gap.lg,

                      // Türkçe çeviri
                      Text(
                        widget.item.turkishContent,
                        style: AppTypography.body.copyWith(
                          color: Colors.white70,
                          height: 1.8,
                        ),
                        textAlign: TextAlign.center,
                      ).animate(delay: 800.ms).fadeIn(),
                    ],
                  ),
                ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.15, end: 0),

                Gap.lg,

                // Kültürel arka plan
                if (widget.item.backgroundNote != null)
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.darkSurfaceVariant,
                      borderRadius: AppRadius.lg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.info_outline,
                                color: AppColors.primaryLight, size: 16),
                            Gap.hSm,
                            Text('Newroz hakkında',
                                style: AppTypography.captionStrong.copyWith(
                                  color: AppColors.primaryLight,
                                )),
                          ],
                        ),
                        Gap.sm,
                        Text(
                          widget.item.backgroundNote!,
                          style: AppTypography.body.copyWith(
                            color: Colors.white70,
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  ).animate(delay: 1000.ms).fadeIn(),

                Gap.xl,

                // Anahtar kelimeler
                _KeywordsRow(keywords: widget.item.keywords)
                    .animate(delay: 1200.ms)
                    .fadeIn(),

                Gap.xl,

                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                  ),
                  child: Text(
                    'Newroz pîroz be! →',
                    style: AppTypography.labelLarge.onPrimary,
                  ),
                ).animate(delay: 1400.ms).fadeIn(),

                Gap.lg,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
