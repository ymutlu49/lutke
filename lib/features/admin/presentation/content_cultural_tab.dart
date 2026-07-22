import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../cultural_content/cultural_entities.dart';
import '../../cultural_content/domain/gotinen_pesiyan_db.dart';
import '../../cultural_content/domain/kurdish_artists_db.dart';
import '../../cultural_content/domain/kurdish_legends_db.dart';
import '../../cultural_content/domain/kurdish_foods_db.dart';
import '../../cultural_content/domain/kurdish_celebrations_db.dart';
import '../../cultural_content/domain/kurdish_events_db.dart';
import '../../cultural_content/domain/kurdish_historical_figures_db.dart';
import '../../cultural_content/domain/kurdish_folk_dances_db.dart';
import '../../cultural_content/domain/kurdish_architecture_db.dart';
import '../../cultural_content/domain/kurdish_poems_full_db.dart';
import '../../cultural_content/domain/kurdish_songs_full_db.dart';
import '../data/cultural_content_override_service.dart';

// ════════════════════════════════════════════════════════════════
// MUHERRIRÊ NAVEROKA ÇANDÎ — Kültürel içerik düzenleyicisi
//
// Yönetici şu içerikleri düzenler:
//   • Atasözleri (gotinên pêşiyan)
//   • Destan û efsane
//   • Sanatçılar (stranbêj/helbestvan/nivîskar)
//   • Tarihi kişilikler
//   • Yemek, bayram, halay, mimari
//   • Helbest/stran tam metinleri
//
// Akış:
//   1. Tür seçimi (radyo): tüm içerikler tek listede.
//   2. Arama / filtre: başlığa veya içeriğe göre.
//   3. Item listesi: edit / delete / restore butonları.
//   4. Edit dialog: 7 alanı düzenle (kurmanjTitle, turkishTitle,
//      kurmanjContent, turkishContent, backgroundNote, level,
//      keywords).
//   5. Yeni custom item ekle (FAB).
//
// Tüm değişiklikler SharedPreferences üzerinden kalıcıdır.
// Yeniden çalıştırma sonrası UI otomatik yansıtır.
// ════════════════════════════════════════════════════════════════

class ContentCulturalTab extends ConsumerStatefulWidget {
  const ContentCulturalTab({super.key});

  @override
  ConsumerState<ContentCulturalTab> createState() =>
      _ContentCulturalTabState();
}

class _ContentCulturalTabState extends ConsumerState<ContentCulturalTab> {
  CulturalContentType? _typeFilter;
  String _search = '';
  final _searchController = TextEditingController();

  /// Tüm DB'leri birleştir + atasözü listesini CulturalItem'a çevir.
  static final List<CulturalItem> _rawItems = _buildRawItems();

  static List<CulturalItem> _buildRawItems() {
    // Atasözü için ayrı dönüşüm — Gotin record → CulturalItem.
    final proverbs = <CulturalItem>[
      for (final g in kGotinenPesiyan)
        CulturalItem(
          id: 'gp_${g.letter}_${g.num}',
          type: CulturalContentType.proverb,
          kurmanjTitle: g.ku,
          turkishTitle: g.tr ?? '',
          kurmanjContent: g.ku,
          turkishContent: g.tr ?? '',
          level: 2,
          unitId: 'proverb',
          keywords: const [],
        ),
    ];
    return [
      ...kCulturalItems,
      ...kKurdishArtistItems,
      ...kKurdishLegends,
      ...kKurdishFoods,
      ...kKurdishCelebrations,
      ...kKurdishEvents,
      ...kKurdishHistoricalFigures,
      ...kKurdishFolkDances,
      ...kKurdishArchitecture,
      ...kKurdishPoemsFullText,
      ...kKurdishSongsFullText,
      ...proverbs,
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final overrides = ref.watch(culturalOverridesProvider);
    final deleted = ref.watch(deletedCulturalIdsProvider);
    final customs = ref.watch(customCulturalItemsProvider);

    final items = _filterItems(overrides, customs);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Column(
        children: [
          // ── Top: Search + Type filter ──
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: Column(
              children: [
                _SearchBar(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _search = v),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 38,
                  child: _TypeChips(
                    selected: _typeFilter,
                    overrides: overrides,
                    deleted: deleted,
                    customs: customs,
                    onSelect: (t) => setState(() => _typeFilter = t),
                  ),
                ),
              ],
            ),
          ),

          // ── Stats banner ──
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: _StatsBanner(
              totalRaw: _rawItems.length,
              edited: overrides.length,
              deleted: deleted.length,
              custom: customs.length,
              filtered: items.length,
            ),
          ),

          const SizedBox(height: 8),

          // ── Item list ──
          Expanded(
            child: items.isEmpty
                ? _EmptyState(query: _search)
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 80),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 6),
                    itemBuilder: (context, i) {
                      final item = items[i];
                      final hasOverride =
                          overrides.containsKey(item.id);
                      final isDeleted = deleted.contains(item.id);
                      final isCustom = isCustomCulturalId(item.id);
                      return _ItemCard(
                        item: item,
                        hasOverride: hasOverride,
                        isDeleted: isDeleted,
                        isCustom: isCustom,
                        onEdit: () => _openEditor(item, isCustom: isCustom),
                        onDeleteToggle: () => _toggleDelete(item.id, isDeleted),
                        onRemoveOverride: hasOverride
                            ? () => _removeOverride(item.id)
                            : null,
                        onDeleteCustom: isCustom
                            ? () => _deleteCustom(item.id)
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _newCustomItem,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Naverokeke nû'),
      ),
    );
  }

  // ── Filter logic ──

  List<CulturalItem> _filterItems(
    Map<String, CulturalOverride> overrides,
    Map<String, CustomCulturalItem> customs,
  ) {
    final live = <CulturalItem>[];
    for (final item in _rawItems) {
      final o = overrides[item.id];
      live.add(applyCulturalOverride(item, o));
    }
    for (final c in customs.values) {
      live.add(c.toCulturalItem());
    }

    var filtered = live;
    if (_typeFilter != null) {
      filtered = filtered.where((i) => i.type == _typeFilter).toList();
    }
    if (_search.isNotEmpty) {
      final q = _search.toLowerCase();
      filtered = filtered
          .where((i) =>
              i.kurmanjTitle.toLowerCase().contains(q) ||
              i.turkishTitle.toLowerCase().contains(q) ||
              i.kurmanjContent.toLowerCase().contains(q))
          .toList();
    }
    return filtered;
  }

  // ── Actions ──

  Future<void> _openEditor(CulturalItem item, {required bool isCustom}) async {
    if (isCustom) {
      // Custom item: tüm alanlar düzenlenebilir.
      final customs = ref.read(customCulturalItemsProvider);
      final c = customs[item.id];
      if (c == null) return;
      await showDialog<void>(
        context: context,
        builder: (_) => _CustomItemDialog(initial: c),
      );
    } else {
      // DB item: kısmi override.
      final overrides = ref.read(culturalOverridesProvider);
      await showDialog<void>(
        context: context,
        builder: (_) => _OverrideDialog(
          item: item,
          existing: overrides[item.id],
        ),
      );
    }
  }

  Future<void> _toggleDelete(String id, bool isDeleted) async {
    final notifier = ref.read(deletedCulturalIdsProvider.notifier);
    if (isDeleted) {
      await notifier.restore(id);
      _toast('Naverok hate vegerandin');
    } else {
      final ok = await _confirmDelete();
      if (ok != true) return;
      await notifier.markDeleted(id);
      _toast('Naverok hate veşartin');
    }
  }

  Future<void> _removeOverride(String id) async {
    final ok = await _confirm(
      title: 'Guhertinan rake?',
      message: 'Naverok dê vegere ser rewşa orjînal.',
    );
    if (ok != true) return;
    await ref.read(culturalOverridesProvider.notifier).removeOverride(id);
    _toast('Guhertin hatin rakirin');
  }

  Future<void> _deleteCustom(String id) async {
    final ok = await _confirm(
      title: 'Naverokê jê bibe?',
      message:
          'Ev ji aliyê we ve hatibû avakirin. Vê derê rakirin nayê vegerandin.',
      destructive: true,
    );
    if (ok != true) return;
    await ref.read(customCulturalItemsProvider.notifier).deleteItem(id);
    _toast('Naverok jê hat birin');
  }

  Future<void> _newCustomItem() async {
    final newItem = CustomCulturalItem(
      id: CustomCulturalItem.newId(),
      type: _typeFilter ?? CulturalContentType.proverb,
      kurmanjTitle: '',
      turkishTitle: '',
      kurmanjContent: '',
      turkishContent: '',
    );
    await showDialog<void>(
      context: context,
      builder: (_) => _CustomItemDialog(initial: newItem, isNew: true),
    );
  }

  // ── Helpers ──

  Future<bool?> _confirmDelete() => _confirm(
        title: 'Naverokê veşêre?',
        message: 'Ev ne herwekî dê neyê dîtin di Çand de.',
        destructive: true,
      );

  Future<bool?> _confirm({
    required String title,
    required String message,
    bool destructive = false,
  }) async {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Vegere'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor:
                  destructive ? Colors.red.shade700 : AppColors.primary,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(destructive ? 'Jê bibe' : 'Erê'),
          ),
        ],
      ),
    );
  }

  void _toast(String msg) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// SEARCH BAR
// ════════════════════════════════════════════════════════════════

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Lêgerîn di nav navendê de…',
        prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(Icons.clear, size: 20, color: AppColors.textSecondary),
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
              ),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.borderLight),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 6),
        isDense: true,
      ),
      style: AppTypography.body,
    );
  }
}

// ════════════════════════════════════════════════════════════════
// TYPE CHIPS — yatay scroll filtre
// ════════════════════════════════════════════════════════════════

class _TypeChips extends StatelessWidget {
  final CulturalContentType? selected;
  final Map<String, CulturalOverride> overrides;
  final Set<String> deleted;
  final Map<String, CustomCulturalItem> customs;
  final ValueChanged<CulturalContentType?> onSelect;

  const _TypeChips({
    required this.selected,
    required this.overrides,
    required this.deleted,
    required this.customs,
    required this.onSelect,
  });

  static const _types = [
    null, // Hemû
    CulturalContentType.proverb,
    CulturalContentType.story,
    CulturalContentType.poem,
    CulturalContentType.song,
    CulturalContentType.singer,
    CulturalContentType.poet,
    CulturalContentType.writer,
    CulturalContentType.historicalFigure,
    CulturalContentType.foodTradition,
    CulturalContentType.celebration,
    CulturalContentType.folkDance,
    CulturalContentType.historicalEvent,
    CulturalContentType.architecture,
  ];

  static String _labelFor(CulturalContentType? t) {
    if (t == null) return 'Hemû';
    return switch (t) {
      CulturalContentType.proverb => 'Gotin',
      CulturalContentType.story => 'Destan',
      CulturalContentType.poem => 'Helbest',
      CulturalContentType.song => 'Stran',
      CulturalContentType.singer => 'Stranbêj',
      CulturalContentType.poet => 'Helbestvan',
      CulturalContentType.writer => 'Nivîskar',
      CulturalContentType.historicalFigure => 'Kesayet',
      CulturalContentType.foodTradition => 'Xwarin',
      CulturalContentType.celebration => 'Cejn',
      CulturalContentType.folkDance => 'Govend',
      CulturalContentType.historicalEvent => 'Bûyer',
      CulturalContentType.architecture => 'Mîmarî',
    };
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: _types.length,
      separatorBuilder: (_, __) => const SizedBox(width: 6),
      itemBuilder: (context, i) {
        final t = _types[i];
        final isActive = t == selected;
        return ChoiceChip(
          label: Text(_labelFor(t)),
          selected: isActive,
          onSelected: (_) => onSelect(t),
          selectedColor: AppColors.primary,
          backgroundColor: AppColors.surface,
          labelStyle: AppTypography.label.copyWith(
            color: isActive ? Colors.white : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        );
      },
    );
  }
}

// ════════════════════════════════════════════════════════════════
// STATS BANNER
// ════════════════════════════════════════════════════════════════

class _StatsBanner extends StatelessWidget {
  final int totalRaw;
  final int edited;
  final int deleted;
  final int custom;
  final int filtered;

  const _StatsBanner({
    required this.totalRaw,
    required this.edited,
    required this.deleted,
    required this.custom,
    required this.filtered,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          _stat('Tev', totalRaw + custom, AppColors.textPrimary),
          _divider(),
          _stat('Niha', filtered, AppColors.primary),
          _divider(),
          _stat('Edît', edited, Colors.orange),
          _divider(),
          _stat('Veşartî', deleted, Colors.red),
          _divider(),
          _stat('Nû', custom, Colors.green),
        ],
      ),
    );
  }

  Widget _stat(String label, int value, Color color) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$value',
            style: AppTypography.labelLarge.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: AppTypography.caption
                .copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _divider() => Container(
        width: 1,
        height: 28,
        color: AppColors.borderLight,
      );
}

// ════════════════════════════════════════════════════════════════
// ITEM CARD
// ════════════════════════════════════════════════════════════════

class _ItemCard extends StatelessWidget {
  final CulturalItem item;
  final bool hasOverride;
  final bool isDeleted;
  final bool isCustom;
  final VoidCallback onEdit;
  final VoidCallback onDeleteToggle;
  final VoidCallback? onRemoveOverride;
  final VoidCallback? onDeleteCustom;

  const _ItemCard({
    required this.item,
    required this.hasOverride,
    required this.isDeleted,
    required this.isCustom,
    required this.onEdit,
    required this.onDeleteToggle,
    required this.onRemoveOverride,
    required this.onDeleteCustom,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDeleted
        ? Colors.red.shade50
        : (hasOverride
            ? Colors.orange.shade50
            : (isCustom ? Colors.green.shade50 : AppColors.surface));

    return Material(
      color: color,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: isDeleted ? onDeleteToggle : onEdit,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _typeIcon(item.type),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.kurmanjTitle,
                      style: AppTypography.body.copyWith(fontWeight: FontWeight.w700).copyWith(
                        color: AppColors.textPrimary,
                        decoration: isDeleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (item.turkishTitle.isNotEmpty)
                      Text(
                        item.turkishTitle,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 4,
                      children: [
                        _badge(item.typeLabel, AppColors.primary),
                        if (hasOverride)
                          _badge('GUHERTÎ', Colors.orange.shade700),
                        if (isCustom) _badge('NÛ', Colors.green.shade700),
                        if (isDeleted)
                          _badge('VEŞARTÎ', Colors.red.shade700),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _menuButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _typeIcon(CulturalContentType t) {
    final icon = switch (t) {
      CulturalContentType.proverb => Icons.format_quote_rounded,
      CulturalContentType.story => Icons.auto_stories_rounded,
      CulturalContentType.poem => Icons.edit_note_rounded,
      CulturalContentType.song => Icons.music_note_rounded,
      CulturalContentType.singer => Icons.mic_rounded,
      CulturalContentType.poet => Icons.edit_note_rounded,
      CulturalContentType.writer => Icons.menu_book_rounded,
      CulturalContentType.historicalFigure => Icons.person_pin_rounded,
      CulturalContentType.foodTradition => Icons.restaurant_rounded,
      CulturalContentType.celebration => Icons.cake_rounded,
      CulturalContentType.folkDance => Icons.music_video_rounded,
      CulturalContentType.historicalEvent => Icons.event_note_rounded,
      CulturalContentType.architecture => Icons.location_city_rounded,
    };
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: AppColors.primary, size: 18),
    );
  }

  Widget _badge(String txt, Color c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: c.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        txt,
        style: TextStyle(
          color: c,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _menuButton() {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: AppColors.textSecondary),
      itemBuilder: (_) => [
        if (!isDeleted)
          const PopupMenuItem(value: 'edit', child: Text('Edît bike')),
        PopupMenuItem(
          value: 'toggle_delete',
          child: Text(isDeleted ? 'Vegerîne' : 'Veşêre'),
        ),
        if (hasOverride && !isCustom)
          const PopupMenuItem(
            value: 'remove_override',
            child: Text('Guhertinan rake'),
          ),
        if (isCustom)
          const PopupMenuItem(
            value: 'delete_custom',
            child: Text('Bi temamî jê bibe'),
          ),
      ],
      onSelected: (v) {
        switch (v) {
          case 'edit':
            onEdit();
            break;
          case 'toggle_delete':
            onDeleteToggle();
            break;
          case 'remove_override':
            onRemoveOverride?.call();
            break;
          case 'delete_custom':
            onDeleteCustom?.call();
            break;
        }
      },
    );
  }
}

// ════════════════════════════════════════════════════════════════
// EMPTY STATE
// ════════════════════════════════════════════════════════════════

class _EmptyState extends StatelessWidget {
  final String query;
  const _EmptyState({required this.query});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off_rounded,
                size: 56, color: AppColors.textTertiary),
            const SizedBox(height: 12),
            Text(
              query.isEmpty
                  ? 'Tu naverok lê nehat dîtin'
                  : 'Tu encam ji bo "$query" nehat dîtin',
              textAlign: TextAlign.center,
              style: AppTypography.title
                  .copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// EDIT DIALOG — DB item için kısmi override
// ════════════════════════════════════════════════════════════════

class _OverrideDialog extends ConsumerStatefulWidget {
  final CulturalItem item;
  final CulturalOverride? existing;

  const _OverrideDialog({required this.item, required this.existing});

  @override
  ConsumerState<_OverrideDialog> createState() => _OverrideDialogState();
}

class _OverrideDialogState extends ConsumerState<_OverrideDialog> {
  late final TextEditingController _kuTitle;
  late final TextEditingController _trTitle;
  late final TextEditingController _kuContent;
  late final TextEditingController _trContent;
  late final TextEditingController _bgNote;
  late final TextEditingController _keywords;
  late int _level;

  // Form içinde değişiklik yapılıp yapılmadığını takip eder.
  // X'e basınca veya geri çekilince: değişiklik VARSA onay sor.
  bool _isDirty = false;

  // Orijinal değerleri tutar — _isDirty hesabı için.
  late final String _origKuTitle;
  late final String _origTrTitle;
  late final String _origKuContent;
  late final String _origTrContent;
  late final String _origBgNote;
  late final String _origKeywords;
  late final int _origLevel;

  @override
  void initState() {
    super.initState();
    final o = widget.existing;
    _origKuTitle = o?.kurmanjTitle ?? widget.item.kurmanjTitle;
    _origTrTitle = o?.turkishTitle ?? widget.item.turkishTitle;
    _origKuContent = o?.kurmanjContent ?? widget.item.kurmanjContent;
    _origTrContent = o?.turkishContent ?? widget.item.turkishContent;
    _origBgNote = o?.backgroundNote ?? widget.item.backgroundNote ?? '';
    _origKeywords = (o?.keywords ?? widget.item.keywords).join(', ');
    _origLevel = o?.level ?? widget.item.level;

    _kuTitle = TextEditingController(text: _origKuTitle)..addListener(_check);
    _trTitle = TextEditingController(text: _origTrTitle)..addListener(_check);
    _kuContent = TextEditingController(text: _origKuContent)..addListener(_check);
    _trContent = TextEditingController(text: _origTrContent)..addListener(_check);
    _bgNote = TextEditingController(text: _origBgNote)..addListener(_check);
    _keywords = TextEditingController(text: _origKeywords)..addListener(_check);
    _level = _origLevel;
  }

  void _check() {
    final dirty = _kuTitle.text != _origKuTitle ||
        _trTitle.text != _origTrTitle ||
        _kuContent.text != _origKuContent ||
        _trContent.text != _origTrContent ||
        _bgNote.text != _origBgNote ||
        _keywords.text != _origKeywords ||
        _level != _origLevel;
    if (dirty != _isDirty) {
      setState(() => _isDirty = dirty);
    }
  }

  @override
  void dispose() {
    _kuTitle.dispose();
    _trTitle.dispose();
    _kuContent.dispose();
    _trContent.dispose();
    _bgNote.dispose();
    _keywords.dispose();
    super.dispose();
  }

  /// Çıkarken değişiklik varsa kullanıcıya sor.
  Future<bool> _confirmExit() async {
    if (!_isDirty) return true;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Bê tomarkirin derkeve?'),
        content: const Text(
          'Te guhertin kirin lê hîn tomar nekirin. Eger derkevî, '
          'guhertinên te wenda dibin.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Vegere'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade700),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Derkeve, tomar nekin'),
          ),
        ],
      ),
    );
    return ok == true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isDirty,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        if (await _confirmExit() && mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Dialog.fullscreen(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'Bigire (bê tomarkirin)',
              onPressed: () async {
                if (await _confirmExit() && mounted) {
                  Navigator.of(context).pop();
                }
              },
            ),
            title: const Text('Edît bike'),
            actions: [
              TextButton.icon(
                onPressed: _isDirty ? _save : null,
                icon: Icon(Icons.check,
                    color: _isDirty ? Colors.white : Colors.white38),
                label: Text(
                  'Tomar',
                  style: TextStyle(
                    color: _isDirty ? Colors.white : Colors.white38,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              _readOnlyChip('ID: ${widget.item.id}'),
              const SizedBox(height: 6),
              _readOnlyChip('Cure: ${widget.item.typeLabel}'),
              const SizedBox(height: 16),
              _field('Sernavê Kurmancî', _kuTitle, maxLines: 1),
              const SizedBox(height: 12),
              _field('Sernavê Tirkî', _trTitle, maxLines: 1),
              const SizedBox(height: 12),
              _field('Naveroka Kurmancî', _kuContent, maxLines: 8),
              const SizedBox(height: 12),
              _field('Naveroka Tirkî', _trContent, maxLines: 8),
              const SizedBox(height: 12),
              _field('Nota arkaplanê', _bgNote, maxLines: 4),
              const SizedBox(height: 12),
              _field('Peyvên kilît (bi virgûlê)', _keywords, maxLines: 1),
              const SizedBox(height: 12),
              _levelDropdown(),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _isDirty ? _save : null,
                icon: const Icon(Icons.check),
                label: const Text('Tomar bike'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () async {
                  if (await _confirmExit() && mounted) {
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.close),
                label: const Text('Vegere bê tomarkirin'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  }

  Widget _readOnlyChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Text(
        text,
        style: AppTypography.caption
            .copyWith(color: AppColors.textSecondary),
      ),
    );
  }

  Widget _field(String label, TextEditingController c, {int maxLines = 1}) {
    return TextField(
      controller: c,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        alignLabelWithHint: maxLines > 1,
      ),
      style: AppTypography.body,
    );
  }

  Widget _levelDropdown() {
    return DropdownButtonFormField<int>(
      value: _level,
      decoration: const InputDecoration(
        labelText: 'Asta CEFR',
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: 1, child: Text('A1')),
        DropdownMenuItem(value: 2, child: Text('A2')),
        DropdownMenuItem(value: 3, child: Text('B1')),
        DropdownMenuItem(value: 4, child: Text('B2')),
        DropdownMenuItem(value: 5, child: Text('C1')),
        DropdownMenuItem(value: 6, child: Text('C2')),
      ],
      onChanged: (v) => setState(() => _level = v ?? 2),
    );
  }

  Future<void> _save() async {
    final orig = widget.item;
    String? diffStr(String orig, String now) =>
        now.trim() == orig.trim() ? null : now.trim();
    int? diffInt(int orig, int now) => now == orig ? null : now;
    List<String>? diffList(List<String> orig, List<String> now) {
      if (now.length != orig.length) return now;
      for (var i = 0; i < orig.length; i++) {
        if (orig[i].trim() != now[i].trim()) return now;
      }
      return null;
    }

    final newKw = _keywords.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final override = CulturalOverride(
      kurmanjTitle: diffStr(orig.kurmanjTitle, _kuTitle.text),
      turkishTitle: diffStr(orig.turkishTitle, _trTitle.text),
      kurmanjContent: diffStr(orig.kurmanjContent, _kuContent.text),
      turkishContent: diffStr(orig.turkishContent, _trContent.text),
      backgroundNote: diffStr(orig.backgroundNote ?? '', _bgNote.text),
      level: diffInt(orig.level, _level),
      keywords: diffList(orig.keywords, newKw),
    );

    await ref
        .read(culturalOverridesProvider.notifier)
        .setOverride(orig.id, override);

    if (mounted) Navigator.of(context).pop();
  }
}

// ════════════════════════════════════════════════════════════════
// CUSTOM ITEM DIALOG — yeni veya mevcut custom item
// ════════════════════════════════════════════════════════════════

class _CustomItemDialog extends ConsumerStatefulWidget {
  final CustomCulturalItem initial;
  final bool isNew;
  const _CustomItemDialog({required this.initial, this.isNew = false});

  @override
  ConsumerState<_CustomItemDialog> createState() => _CustomItemDialogState();
}

class _CustomItemDialogState extends ConsumerState<_CustomItemDialog> {
  late final TextEditingController _kuTitle;
  late final TextEditingController _trTitle;
  late final TextEditingController _kuContent;
  late final TextEditingController _trContent;
  late final TextEditingController _bgNote;
  late final TextEditingController _keywords;
  late CulturalContentType _type;
  late int _level;

  bool _isDirty = false;
  late final String _origKuTitle;
  late final String _origTrTitle;
  late final String _origKuContent;
  late final String _origTrContent;
  late final String _origBgNote;
  late final String _origKeywords;
  late final CulturalContentType _origType;
  late final int _origLevel;

  @override
  void initState() {
    super.initState();
    final i = widget.initial;
    _origKuTitle = i.kurmanjTitle;
    _origTrTitle = i.turkishTitle;
    _origKuContent = i.kurmanjContent;
    _origTrContent = i.turkishContent;
    _origBgNote = i.backgroundNote ?? '';
    _origKeywords = i.keywords.join(', ');
    _origType = i.type;
    _origLevel = i.level;

    _kuTitle = TextEditingController(text: _origKuTitle)..addListener(_check);
    _trTitle = TextEditingController(text: _origTrTitle)..addListener(_check);
    _kuContent = TextEditingController(text: _origKuContent)..addListener(_check);
    _trContent = TextEditingController(text: _origTrContent)..addListener(_check);
    _bgNote = TextEditingController(text: _origBgNote)..addListener(_check);
    _keywords = TextEditingController(text: _origKeywords)..addListener(_check);
    _type = _origType;
    _level = _origLevel;

    // Yeni item için (boş): kullanıcı bir şey yazana kadar dirty değildir.
    if (widget.isNew) {
      _isDirty = false;
    }
  }

  void _check() {
    final dirty = _kuTitle.text != _origKuTitle ||
        _trTitle.text != _origTrTitle ||
        _kuContent.text != _origKuContent ||
        _trContent.text != _origTrContent ||
        _bgNote.text != _origBgNote ||
        _keywords.text != _origKeywords ||
        _type != _origType ||
        _level != _origLevel;
    if (dirty != _isDirty) {
      setState(() => _isDirty = dirty);
    }
  }

  @override
  void dispose() {
    _kuTitle.dispose();
    _trTitle.dispose();
    _kuContent.dispose();
    _trContent.dispose();
    _bgNote.dispose();
    _keywords.dispose();
    super.dispose();
  }

  Future<bool> _confirmExit() async {
    if (!_isDirty) return true;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Bê tomarkirin derkeve?'),
        content: const Text(
          'Te guhertin kirin lê hîn tomar nekirin. Eger derkevî, '
          'guhertinên te wenda dibin.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Vegere'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade700),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Derkeve, tomar nekin'),
          ),
        ],
      ),
    );
    return ok == true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isDirty,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        if (await _confirmExit() && mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Dialog.fullscreen(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'Bigire (bê tomarkirin)',
              onPressed: () async {
                if (await _confirmExit() && mounted) {
                  Navigator.of(context).pop();
                }
              },
            ),
            title: Text(widget.isNew
                ? 'Naverokeke nû'
                : 'Naveroka taybet — edît bike'),
            actions: [
              TextButton.icon(
                onPressed: _isDirty ? _save : null,
                icon: Icon(Icons.check,
                    color: _isDirty ? Colors.white : Colors.white38),
                label: Text(
                  'Tomar',
                  style: TextStyle(
                    color: _isDirty ? Colors.white : Colors.white38,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              _typeDropdown(),
              const SizedBox(height: 12),
              _field('Sernavê Kurmancî *', _kuTitle, maxLines: 1),
              const SizedBox(height: 12),
              _field('Sernavê Tirkî', _trTitle, maxLines: 1),
              const SizedBox(height: 12),
              _field('Naveroka Kurmancî *', _kuContent, maxLines: 8),
              const SizedBox(height: 12),
              _field('Naveroka Tirkî', _trContent, maxLines: 8),
              const SizedBox(height: 12),
              _field('Nota arkaplanê', _bgNote, maxLines: 4),
              const SizedBox(height: 12),
              _field('Peyvên kilît (bi virgûlê)', _keywords, maxLines: 1),
              const SizedBox(height: 12),
              _levelDropdown(),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: const Text('Tomar bike'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () async {
                  if (await _confirmExit() && mounted) {
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.close),
                label: const Text('Vegere bê tomarkirin'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  }

  Widget _typeDropdown() {
    return DropdownButtonFormField<CulturalContentType>(
      value: _type,
      decoration: const InputDecoration(
        labelText: 'Cureyê Naverokê',
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(
            value: CulturalContentType.proverb, child: Text('Gotin')),
        DropdownMenuItem(
            value: CulturalContentType.story, child: Text('Destan / Çîrok')),
        DropdownMenuItem(
            value: CulturalContentType.poem, child: Text('Helbest')),
        DropdownMenuItem(
            value: CulturalContentType.song, child: Text('Stran')),
        DropdownMenuItem(
            value: CulturalContentType.singer, child: Text('Stranbêj')),
        DropdownMenuItem(
            value: CulturalContentType.poet, child: Text('Helbestvan')),
        DropdownMenuItem(
            value: CulturalContentType.writer, child: Text('Nivîskar')),
        DropdownMenuItem(
            value: CulturalContentType.historicalFigure,
            child: Text('Kesayetekî dîrokî')),
        DropdownMenuItem(
            value: CulturalContentType.foodTradition,
            child: Text('Xwarin')),
        DropdownMenuItem(
            value: CulturalContentType.celebration, child: Text('Cejn')),
        DropdownMenuItem(
            value: CulturalContentType.folkDance,
            child: Text('Govend / Cilûberg')),
        DropdownMenuItem(
            value: CulturalContentType.historicalEvent,
            child: Text('Bûyera dîrokî')),
        DropdownMenuItem(
            value: CulturalContentType.architecture,
            child: Text('Mîmarî')),
      ],
      onChanged: (v) => setState(() => _type = v ?? _type),
    );
  }

  Widget _levelDropdown() {
    return DropdownButtonFormField<int>(
      value: _level,
      decoration: const InputDecoration(
        labelText: 'Asta CEFR',
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: 1, child: Text('A1')),
        DropdownMenuItem(value: 2, child: Text('A2')),
        DropdownMenuItem(value: 3, child: Text('B1')),
        DropdownMenuItem(value: 4, child: Text('B2')),
        DropdownMenuItem(value: 5, child: Text('C1')),
        DropdownMenuItem(value: 6, child: Text('C2')),
      ],
      onChanged: (v) => setState(() => _level = v ?? 2),
    );
  }

  Widget _field(String label, TextEditingController c, {int maxLines = 1}) {
    return TextField(
      controller: c,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        alignLabelWithHint: maxLines > 1,
      ),
      style: AppTypography.body,
    );
  }

  Future<void> _save() async {
    if (_kuTitle.text.trim().isEmpty || _kuContent.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sernav û naveroka Kurmancî divê tijî bibin.'),
        ),
      );
      return;
    }

    final keywords = _keywords.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final item = widget.initial.copyWith(
      type: _type,
      kurmanjTitle: _kuTitle.text.trim(),
      turkishTitle: _trTitle.text.trim(),
      kurmanjContent: _kuContent.text.trim(),
      turkishContent: _trContent.text.trim(),
      backgroundNote: _bgNote.text.trim().isEmpty ? null : _bgNote.text.trim(),
      level: _level,
      keywords: keywords,
    );

    await ref.read(customCulturalItemsProvider.notifier).saveItem(item);

    if (mounted) Navigator.of(context).pop();
  }
}
