// ════════════════════════════════════════════════════════════════
// ÇAND — KULTUR SAYFASI
//
// Zenginlestirilmis kultur ekrani: kategori tablari, arama,
// ozellestirilmis kart gorunum, animasyonlar.
// ════════════════════════════════════════════════════════════════

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/router/app_router.dart';
import '../../shared/providers/language_mode_provider.dart';
import 'cultural_entities.dart';
import 'domain/gotinen_pesiyan_db.dart';

// ────────────────────────────────────────────────────────────────
// TAB MODELI
// ────────────────────────────────────────────────────────────────

class _TabItem {
  final String label;
  final CulturalContentType? type; // null = "Hemu" (All)
  final IconData icon;

  const _TabItem({required this.label, this.type, required this.icon});
}

const _kTabs = <_TabItem>[
  _TabItem(label: 'Hemû', icon: Icons.grid_view_rounded),
  _TabItem(label: 'Gotinên Pêşiyan', type: CulturalContentType.proverb, icon: Icons.format_quote_rounded),
  _TabItem(label: 'Stran', type: CulturalContentType.song, icon: Icons.music_note_rounded),
  _TabItem(label: 'Helbest', type: CulturalContentType.poem, icon: Icons.auto_stories_rounded),
  _TabItem(label: 'Cejna', type: CulturalContentType.celebration, icon: Icons.celebration_rounded),
  _TabItem(label: 'Nîşe', type: CulturalContentType.culturalNote, icon: Icons.info_outline_rounded),
  _TabItem(label: 'Kesayetên Dîrokî', type: CulturalContentType.historicalFigure, icon: Icons.person_pin_rounded),
];

// ────────────────────────────────────────────────────────────────
// YARDIMCI FONKSIYONLAR
// ────────────────────────────────────────────────────────────────

IconData _typeIcon(CulturalContentType type) => switch (type) {
  CulturalContentType.proverb => Icons.format_quote_rounded,
  CulturalContentType.song => Icons.music_note_rounded,
  CulturalContentType.celebration => Icons.celebration_rounded,
  CulturalContentType.poem => Icons.auto_stories_rounded,
  CulturalContentType.story => Icons.menu_book_rounded,
  CulturalContentType.foodTradition => Icons.restaurant_rounded,
  CulturalContentType.culturalNote => Icons.info_outline_rounded,
  CulturalContentType.historicalFigure => Icons.person_pin_rounded,
};

Color _typeColor(CulturalContentType type) => switch (type) {
  CulturalContentType.proverb => const Color(0xFF4CAF50),
  CulturalContentType.song => const Color(0xFFE91E63),
  CulturalContentType.celebration => const Color(0xFFFF9800),
  CulturalContentType.poem => const Color(0xFF9C27B0),
  CulturalContentType.story => const Color(0xFF2196F3),
  CulturalContentType.foodTradition => const Color(0xFF795548),
  CulturalContentType.culturalNote => const Color(0xFF607D8B),
  CulturalContentType.historicalFigure => const Color(0xFF5D4037),
};

String _levelLabel(int level) => switch (level) {
  1 => 'A1',
  2 => 'A2',
  3 => 'B1',
  4 => 'B2',
  _ => 'A1',
};

// ════════════════════════════════════════════════════════════════
// ANA EKRAN
// ════════════════════════════════════════════════════════════════

class CultureScreen extends StatefulWidget {
  const CultureScreen({super.key});

  @override
  State<CultureScreen> createState() => _CultureScreenState();
}

class _CultureScreenState extends State<CultureScreen> {
  int _selectedTab = 0;
  String _searchQuery = '';
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<CulturalItem> get _filteredItems {
    final tab = _kTabs[_selectedTab];
    var items = kCulturalItems.toList();

    // Tab filtresi
    if (tab.type != null) {
      items = items.where((i) => i.type == tab.type).toList();
    }

    // Arama filtresi
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      items = items.where((i) =>
        i.kurmanjTitle.toLowerCase().contains(q) ||
        i.turkishTitle.toLowerCase().contains(q) ||
        i.kurmanjContent.toLowerCase().contains(q) ||
        i.keywords.any((k) => k.toLowerCase().contains(q))
      ).toList();
    }

    return items;
  }

  /// "Gotina Roje" — Gunden guene degisen one cikan icerik
  CulturalItem get _featuredItem {
    final dayIndex = DateTime.now().difference(DateTime(2025, 1, 1)).inDays;
    return kCulturalItems[dayIndex % kCulturalItems.length];
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredItems;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // ── APP BAR ──
          SliverAppBar(
            backgroundColor: AppColors.backgroundPrimary,
            elevation: 0,
            floating: true,
            snap: true,
            toolbarHeight: 60,
            title: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/logo_128.png',
                    width: 40, height: 40,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Çand',
                  style: AppTypography.headline.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Kültür',
                  style: AppTypography.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${filtered.length} içerik',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── SEARCH BAR ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: _SearchBar(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
              ),
            ),
          ),

          // ── CATEGORY TABS ──
          SliverToBoxAdapter(
            child: SizedBox(
              height: 44,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _kTabs.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final tab = _kTabs[index];
                  final isActive = index == _selectedTab;
                  return _CategoryChip(
                    label: tab.label,
                    icon: tab.icon,
                    isActive: isActive,
                    onTap: () => setState(() => _selectedTab = index),
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // ── GOTINÊN PÊŞÎYAN — Büyük atasözü koleksiyonu CTA ──
          // (sadece "Hemû" ve "Gotinên Pêşiyan" sekmelerinde görünür)
          if ((_selectedTab == 0 || _selectedTab == 1) &&
              _searchQuery.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: _GotinenPesiyanBanner(),
              ),
            ),

          // ── FEATURED CARD (only on "All" tab with no search) ──
          if (_selectedTab == 0 && _searchQuery.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _FeaturedCard(item: _featuredItem),
              ),
            ),

          if (_selectedTab == 0 && _searchQuery.isEmpty)
            const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // ── CONTENT LIST ──
          if (filtered.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.search_off_rounded, size: 48,
                      color: AppColors.textTertiary),
                    const SizedBox(height: 12),
                    Text('Encam nehat dîtin',
                      style: AppTypography.title.copyWith(
                        color: AppColors.textSecondary)),
                    const SizedBox(height: 4),
                    Text('Sonuc bulunamadi',
                      style: AppTypography.caption),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = filtered[index];
                    final isProverb = item.type == CulturalContentType.proverb;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: isProverb
                          ? _ProverbCard(item: item)
                          : _EnrichedCultureCard(item: item),
                    ).animate()
                     .fadeIn(delay: Duration(milliseconds: 40 * min(index, 10)))
                     .slideY(begin: 0.05, end: 0, duration: 300.ms,
                       curve: Curves.easeOutCubic);
                  },
                  childCount: filtered.length,
                ),
              ),
            ),

          // Alt bosluk
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// ARAMA CUBUGU
// ════════════════════════════════════════════════════════════════

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppTypography.body,
        decoration: InputDecoration(
          hintText: 'Bigere... (Ara...)',
          hintStyle: AppTypography.body.copyWith(color: AppColors.textTertiary),
          prefixIcon: const Icon(Icons.search_rounded, size: 20,
            color: AppColors.textTertiary),
          suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close_rounded, size: 18),
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
              )
            : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// KATEGORI CHIP
// ════════════════════════════════════════════════════════════════

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.borderLight,
          ),
          boxShadow: isActive ? [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16,
              color: isActive ? Colors.white : AppColors.textSecondary),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: isActive ? Colors.white : AppColors.textSecondary,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// ONE CIKAN KART — GOTINA ROJE
// ════════════════════════════════════════════════════════════════

class _FeaturedCard extends StatefulWidget {
  final CulturalItem item;
  const _FeaturedCard({required this.item});

  @override
  State<_FeaturedCard> createState() => _FeaturedCardState();
}

class _FeaturedCardState extends State<_FeaturedCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final color = _typeColor(item.type);

    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: 300.ms,
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.85),
              color.withOpacity(0.65),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ust etiket
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.auto_awesome_rounded, size: 14,
                          color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          'Gotina Rojê',
                          style: AppTypography.labelSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.typeLabel,
                      style: AppTypography.caption.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Kurmanci icerik
              Text(
                item.kurmanjContent,
                style: AppTypography.kurmanjiLarge.copyWith(
                  color: Colors.white,
                  fontSize: 22,
                  height: 1.4,
                ),
                maxLines: _expanded ? 20 : 3,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 10),

              // Baslik
              Text(
                '— ${item.kurmanjTitle}',
                style: AppTypography.label.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontStyle: FontStyle.italic,
                ),
              ),

              if (_expanded) ...[
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    item.turkishContent,
                    style: AppTypography.body.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                  ),
                ),
                if (item.backgroundNote != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    item.backgroundNote!,
                    style: AppTypography.caption.copyWith(
                      color: Colors.white.withOpacity(0.7),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],

              const SizedBox(height: 8),
              // Genisletme ipucu
              Center(
                child: Icon(
                  _expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                  color: Colors.white.withOpacity(0.6),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).scale(
      begin: const Offset(0.97, 0.97),
      end: const Offset(1, 1),
      duration: 400.ms,
      curve: Curves.easeOutCubic,
    );
  }
}

// ════════════════════════════════════════════════════════════════
// ATASOZU OZEL KARTI — QUOTE STILI
// ════════════════════════════════════════════════════════════════

class _ProverbCard extends StatefulWidget {
  final CulturalItem item;
  const _ProverbCard({required this.item});

  @override
  State<_ProverbCard> createState() => _ProverbCardState();
}

class _ProverbCardState extends State<_ProverbCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final color = _typeColor(CulturalContentType.proverb);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withOpacity(0.2)),
      ),
      color: AppColors.backgroundSecondary,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tur ve seviye etiketi
              Row(
                children: [
                  _TypeBadge(type: item.type),
                  const SizedBox(width: 8),
                  _LevelBadge(level: item.level),
                  const Spacer(),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.textTertiary, size: 20,
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Buyuk tirnak isareti + Kurmanci atasozu
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\u201C',
                    style: TextStyle(
                      fontSize: 48,
                      height: 0.8,
                      fontWeight: FontWeight.w700,
                      color: color.withOpacity(0.3),
                      fontFamily: 'Georgia',
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        item.kurmanjContent,
                        style: AppTypography.kurmanji.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Turkce anlam — only when showTurkish
              Consumer(builder: (_, ref, __) {
                if (!ref.watch(showTurkishProvider)) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      item.turkishContent,
                      style: AppTypography.translation.copyWith(
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                );
              }),

              // Genisletilmis icerik
              if (_expanded) ...[
                if (item.backgroundNote != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: color.withOpacity(0.1)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.lightbulb_outline_rounded,
                          size: 16, color: color),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.backgroundNote!,
                            style: AppTypography.body.copyWith(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              fontStyle: FontStyle.italic,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],

              // Anahtar kelimeler
              if (item.keywords.isNotEmpty) ...[
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: item.keywords.map((k) =>
                    _KeywordTag(keyword: k),
                  ).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// ZENGINLESTIRILMIS KULTUR KARTI
// ════════════════════════════════════════════════════════════════

class _EnrichedCultureCard extends StatefulWidget {
  final CulturalItem item;
  const _EnrichedCultureCard({required this.item});

  @override
  State<_EnrichedCultureCard> createState() => _EnrichedCultureCardState();
}

class _EnrichedCultureCardState extends State<_EnrichedCultureCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final color = _typeColor(item.type);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withOpacity(0.15)),
      ),
      color: AppColors.backgroundSecondary,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ust kisim: ikon + baslik + seviye
              Row(
                children: [
                  _TypeBadge(type: item.type),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.kurmanjTitle,
                          style: AppTypography.title.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.turkishTitle,
                          style: AppTypography.caption,
                        ),
                      ],
                    ),
                  ),
                  _LevelBadge(level: item.level),
                  const SizedBox(width: 6),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.textTertiary, size: 20,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Kurmanci icerik onizleme
              Text(
                item.kurmanjContent,
                style: AppTypography.kurmanji.copyWith(
                  fontSize: 16,
                  height: 1.5,
                ),
                maxLines: _expanded ? 50 : 2,
                overflow: TextOverflow.ellipsis,
              ),

              // Genisletilmis icerik
              if (_expanded) ...[
                const SizedBox(height: 12),

                // Turkce ceviri kutusu — only when showTurkish
                Consumer(builder: (_, ref, __) {
                  if (!ref.watch(showTurkishProvider)) return const SizedBox.shrink();
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tirkî — Türkçe',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.turkishContent,
                          style: AppTypography.translation.copyWith(
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                // Arka plan notu
                if (item.backgroundNote != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: color.withOpacity(0.1)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.lightbulb_outline_rounded,
                          size: 16, color: color),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.backgroundNote!,
                            style: AppTypography.body.copyWith(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              fontStyle: FontStyle.italic,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],

              // Anahtar kelimeler
              if (item.keywords.isNotEmpty) ...[
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: item.keywords.map((k) =>
                    _KeywordTag(keyword: k),
                  ).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// YARDIMCI WIDGET'LAR
// ════════════════════════════════════════════════════════════════

/// Tur rozeti (ikon + renk)
class _TypeBadge extends StatelessWidget {
  final CulturalContentType type;
  const _TypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    final color = _typeColor(type);
    return Container(
      width: 38, height: 38,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Icon(_typeIcon(type), color: color, size: 20),
    );
  }
}

/// Seviye rozeti (A1, A2, B1...)
class _LevelBadge extends StatelessWidget {
  final int level;
  const _LevelBadge({required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Text(
        _levelLabel(level),
        style: AppTypography.labelSmall.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
      ),
    );
  }
}

/// Anahtar kelime etiketi
class _KeywordTag extends StatelessWidget {
  final String keyword;
  const _KeywordTag({required this.keyword});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.backgroundTertiary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        keyword,
        style: AppTypography.caption.copyWith(
          fontSize: 11,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// GOTINÊN PÊŞÎYAN BANNER — Büyük atasözü koleksiyonuna bağlantı
// ════════════════════════════════════════════════════════════════

class _GotinenPesiyanBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final count = kGotinenPesiyan.length;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(AppRoutes.gotinenPesiyan),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.primary.withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gotinên Pêşîyan',
                      style: AppTypography.title.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$count gotinên kal û pîran — alfabeyî',
                      style: AppTypography.caption.copyWith(
                        color: Colors.white.withOpacity(0.92),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
