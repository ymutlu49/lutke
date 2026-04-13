import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../domain/a1_kelime_db.dart';
import '../domain/a2_kelime_db.dart';
import '../domain/b1_kelime_db.dart';
import '../domain/b2_kelime_db.dart';
import '../domain/c1_kelime_db.dart';
import '../domain/c2_kelime_db.dart';

// ════════════════════════════════════════════════════════════════
// KELİME TARAYICI — Tüm seviyelerdeki kelimeleri görüntüle
// Doğrudan statik listelerden okur — veritabanı gerekmez.
// ════════════════════════════════════════════════════════════════

/// Sıralama seçenekleri
enum _SortMode { alphabetical, difficulty, category }

/// SharedPreferences anahtarı
const _kRecentSearchesKey = 'vocab_recent_searches';

/// Kategori → renk eşleştirmesi (tutarlı renk)
const Map<String, Color> _kCategoryColors = {
  'alfabe': Color(0xFF5C6BC0),
  'selamlama': Color(0xFF26A69A),
  'jimar': Color(0xFFEF5350),
  'reng': Color(0xFFAB47BC),
  'malbat': Color(0xFFFF7043),
  'xwarin': Color(0xFFFFA726),
  'jiyan': Color(0xFF66BB6A),
  'beden': Color(0xFF42A5F5),
  'xweza': Color(0xFF8D6E63),
  'dem': Color(0xFF78909C),
  'kar': Color(0xFFEC407A),
  'cih': Color(0xFF7E57C2),
  'mal': Color(0xFFD4E157),
  'perwerde': Color(0xFF29B6F6),
  'tenduristî': Color(0xFF26C6DA),
  'bazirganî': Color(0xFF9CCC65),
  'huner': Color(0xFFFFCA28),
  'siyaset': Color(0xFFBDBDBD),
  'zanist': Color(0xFF5C6BC0),
};

/// Varsayılan kategori rengi (listede olmayan kategoriler için)
Color _categoryColor(String kat) {
  final key = kat.toLowerCase();
  return _kCategoryColors[key] ?? AppColors.primary;
}

/// Her seviyenin adı ve kelime listesi
class _LevelData {
  final String name;
  final String label;
  final Color color;
  final List<dynamic> words;

  const _LevelData({
    required this.name,
    required this.label,
    required this.color,
    required this.words,
  });
}

class VocabularyBrowseScreen extends StatefulWidget {
  const VocabularyBrowseScreen({super.key});

  @override
  State<VocabularyBrowseScreen> createState() =>
      _VocabularyBrowseScreenState();
}

class _VocabularyBrowseScreenState extends State<VocabularyBrowseScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _searchQuery = '';
  final Set<String> _expandedWords = {};
  String? _selectedLevel;
  String? _selectedCategory;
  _SortMode _sortMode = _SortMode.alphabetical;
  Timer? _debounceTimer;
  List<String> _recentSearches = [];
  bool _showRecentSearches = false;

  late final List<_LevelData> _levels;
  late final List<String> _allCategories;
  late final int _totalWordCount;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _fadeController.forward();

    _levels = [
      _LevelData(
        name: 'A1',
        label: 'A1 — Destpêk (Başlangıç)',
        color: const Color(0xFF4CAF50),
        words: kA1TamListe,
      ),
      _LevelData(
        name: 'A2',
        label: 'A2 — Bingehîn (Temel)',
        color: const Color(0xFF8BC34A),
        words: kA2TamListe,
      ),
      _LevelData(
        name: 'B1',
        label: 'B1 — Navîn (Orta)',
        color: const Color(0xFFFF9800),
        words: kB1All,
      ),
      _LevelData(
        name: 'B2',
        label: 'B2 — Navîn-Jor (Orta-Üst)',
        color: const Color(0xFFFF5722),
        words: kB2All,
      ),
      _LevelData(
        name: 'C1',
        label: 'C1 — Pêşkeftî (İleri)',
        color: const Color(0xFF9C27B0),
        words: kC1All,
      ),
      _LevelData(
        name: 'C2',
        label: 'C2 — Sertî (Ustalık)',
        color: const Color(0xFF673AB7),
        words: kC2All,
      ),
    ];

    // Tüm kategorileri topla
    final catSet = <String>{};
    int total = 0;
    for (final level in _levels) {
      total += level.words.length;
      for (final w in level.words) {
        catSet.add(w.kat as String);
      }
    }
    _totalWordCount = total;
    _allCategories = catSet.toList()..sort();

    _loadRecentSearches();

    _searchFocusNode.addListener(() {
      setState(() {
        _showRecentSearches =
            _searchFocusNode.hasFocus && _searchQuery.isEmpty;
      });
    });
  }

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _recentSearches = prefs.getStringList(_kRecentSearchesKey) ?? [];
    });
  }

  Future<void> _saveRecentSearch(String query) async {
    if (query.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    _recentSearches.remove(query);
    _recentSearches.insert(0, query);
    if (_recentSearches.length > 5) {
      _recentSearches = _recentSearches.sublist(0, 5);
    }
    await prefs.setStringList(_kRecentSearchesKey, _recentSearches);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _debounceTimer?.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String val) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      final trimmed = val.trim();
      setState(() {
        _searchQuery = trimmed;
        _showRecentSearches = trimmed.isEmpty && _searchFocusNode.hasFocus;
      });
      _fadeController.reset();
      _fadeController.forward();
      if (trimmed.length >= 2) _saveRecentSearch(trimmed);
    });
  }

  bool _wordMatchesSearch(dynamic word, String query) {
    if (query.isEmpty) return true;
    final q = query.toLowerCase();
    final ku = (word.ku as String).toLowerCase();
    final tr = (word.tr as String).toLowerCase();
    final en = (word.en as String).toLowerCase();
    final kat = (word.kat as String).toLowerCase();
    return ku.contains(q) ||
        tr.contains(q) ||
        en.contains(q) ||
        kat.contains(q);
  }

  bool _wordMatchesCategory(dynamic word) {
    if (_selectedCategory == null) return true;
    return (word.kat as String).toLowerCase() ==
        _selectedCategory!.toLowerCase();
  }

  List<dynamic> _getFilteredWords(_LevelData level) {
    var list = level.words.where((w) {
      return _wordMatchesSearch(w, _searchQuery) && _wordMatchesCategory(w);
    }).toList();

    switch (_sortMode) {
      case _SortMode.alphabetical:
        list.sort((a, b) => (a.ku as String)
            .toLowerCase()
            .compareTo((b.ku as String).toLowerCase()));
        break;
      case _SortMode.difficulty:
        list.sort(
            (a, b) => (b.zor as double).compareTo(a.zor as double));
        break;
      case _SortMode.category:
        list.sort(
            (a, b) => (a.kat as String).compareTo(b.kat as String));
        break;
    }
    return list;
  }

  int get _totalFilteredCount {
    int count = 0;
    for (final level in _levels) {
      count += _getFilteredWords(level).length;
    }
    return count;
  }

  String get _sortLabel {
    switch (_sortMode) {
      case _SortMode.alphabetical:
        return 'A-Z';
      case _SortMode.difficulty:
        return 'Zor';
      case _SortMode.category:
        return 'Kat';
    }
  }

  void _showSortMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.md,
            horizontal: AppSpacing.md,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Rêzkirinê hilbijêre',
                  style: AppTypography.title
                      .copyWith(color: AppColors.textPrimary)),
              const SizedBox(height: AppSpacing.md),
              _SortOption(
                icon: Icons.sort_by_alpha,
                label: 'Alfabetîk (ku A-Z)',
                isSelected: _sortMode == _SortMode.alphabetical,
                onTap: () {
                  setState(() => _sortMode = _SortMode.alphabetical);
                  Navigator.pop(ctx);
                },
              ),
              _SortOption(
                icon: Icons.trending_up,
                label: 'Zehmetî (zor jor\u2192jêr)',
                isSelected: _sortMode == _SortMode.difficulty,
                onTap: () {
                  setState(() => _sortMode = _SortMode.difficulty);
                  Navigator.pop(ctx);
                },
              ),
              _SortOption(
                icon: Icons.category,
                label: 'Li gor kategoriyê',
                isSelected: _sortMode == _SortMode.category,
                onTap: () {
                  setState(() => _sortMode = _SortMode.category);
                  Navigator.pop(ctx);
                },
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final levelsToShow = _selectedLevel != null
        ? _levels.where((l) => l.name == _selectedLevel).toList()
        : _levels;

    final filteredCount = _totalFilteredCount;
    final hasResults = filteredCount > 0;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            ClipOval(
                child: Image.asset('assets/images/logo_128.png',
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium)),
            const SizedBox(width: 10),
            Text('Peyvên Kurmancî',
                style: AppTypography.headingSmall
                    .copyWith(color: AppColors.textPrimary)),
          ],
        ),
        actions: [
          // ── Word Count Badge ──
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 6),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius:
                    BorderRadius.circular(AppSpacing.radiusFull),
                border:
                    Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Text(
                '$filteredCount / $_totalWordCount peyv',
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // ── Sort Button ──
          IconButton(
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.sort,
                    size: 20, color: AppColors.textSecondary),
                const SizedBox(width: 2),
                Text(_sortLabel,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    )),
              ],
            ),
            onPressed: _showSortMenu,
            tooltip: 'Rêzkirin',
          ),
        ],
      ),
      body: Column(
        children: [
          // ══════ STICKY HEADER ══════
          Material(
            color: AppColors.backgroundPrimary,
            elevation: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Arama Çubuğu ──
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    onChanged: _onSearchChanged,
                    style: AppTypography.body
                        .copyWith(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Peyv bigere... (ku / tr / en)',
                      hintStyle: AppTypography.body
                          .copyWith(color: AppColors.textTertiary),
                      prefixIcon: const Icon(Icons.search,
                          color: AppColors.textSecondary),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 20),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                  _showRecentSearches =
                                      _searchFocusNode.hasFocus;
                                });
                                _fadeController.reset();
                                _fadeController.forward();
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: AppColors.surface,
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                        borderSide: BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                        borderSide: BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                        borderSide: const BorderSide(
                            color: AppColors.primary, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                  ),
                ),

                // ── Recent Searches ──
                if (_showRecentSearches && _recentSearches.isNotEmpty)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md),
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMd),
                      border: Border.all(color: AppColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 4, bottom: 4),
                          child: Text('Lêgerînên dawî',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textTertiary,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        ..._recentSearches.map((s) => InkWell(
                              onTap: () {
                                _searchController.text = s;
                                setState(() {
                                  _searchQuery = s;
                                  _showRecentSearches = false;
                                });
                                _fadeController.reset();
                                _fadeController.forward();
                              },
                              borderRadius: BorderRadius.circular(6),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                child: Row(
                                  children: [
                                    const Icon(Icons.history,
                                        size: 16,
                                        color: AppColors.textTertiary),
                                    const SizedBox(width: 8),
                                    Text(s,
                                        style:
                                            AppTypography.body.copyWith(
                                          color: AppColors.textPrimary,
                                        )),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),

                // ── Seviye Filtre Chipleri ──
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md),
                    children: [
                      _FilterChip(
                        label: 'Hemû',
                        isSelected: _selectedLevel == null,
                        color: AppColors.primary,
                        onTap: () =>
                            setState(() => _selectedLevel = null),
                      ),
                      const SizedBox(width: 8),
                      ..._levels.map((level) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: _FilterChip(
                              label:
                                  '${level.name} (${_getFilteredWords(level).length})',
                              isSelected:
                                  _selectedLevel == level.name,
                              color: level.color,
                              onTap: () => setState(() {
                                _selectedLevel =
                                    _selectedLevel == level.name
                                        ? null
                                        : level.name;
                              }),
                            ),
                          )),
                    ],
                  ),
                ),

                const SizedBox(height: 6),

                // ── Kategori Filtre Chipleri ──
                SizedBox(
                  height: 34,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md),
                    children: [
                      _FilterChip(
                        label: 'Hemû kat.',
                        isSelected: _selectedCategory == null,
                        color: AppColors.textSecondary,
                        onTap: () =>
                            setState(() => _selectedCategory = null),
                      ),
                      const SizedBox(width: 6),
                      ..._allCategories.map((cat) {
                        final catColor = _categoryColor(cat);
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: _FilterChip(
                            label: cat,
                            isSelected: _selectedCategory == cat,
                            color: catColor,
                            onTap: () => setState(() {
                              _selectedCategory =
                                  _selectedCategory == cat
                                      ? null
                                      : cat;
                            }),
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.sm),
              ],
            ),
          ),

          // ══════ WORD LIST ══════
          Expanded(
            child: hasResults
                ? FadeTransition(
                    opacity: _fadeAnimation,
                    child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      color: AppColors.primary,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md),
                        itemCount: levelsToShow.length,
                        itemBuilder: (context, levelIndex) {
                          final level = levelsToShow[levelIndex];
                          final filtered = _getFilteredWords(level);
                          if (filtered.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return _LevelSection(
                            level: level,
                            filteredWords: filtered,
                            expandedWords: _expandedWords,
                            searchQuery: _searchQuery,
                            onToggleWord: (id) {
                              setState(() {
                                if (_expandedWords.contains(id)) {
                                  _expandedWords.remove(id);
                                } else {
                                  _expandedWords.add(id);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                  )
                // ── Empty State ──
                : FadeTransition(
                    opacity: _fadeAnimation,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.xl),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.search_off_rounded,
                                size: 72,
                                color: AppColors.textTertiary
                                    .withOpacity(0.4)),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              'Peyv nehat dîtin',
                              style: AppTypography.title.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              'Lêgerîna xwe biguherîne an kategoriyekê '
                              'hilbijêre.',
                              textAlign: TextAlign.center,
                              style: AppTypography.body.copyWith(
                                color: AppColors.textTertiary,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            OutlinedButton.icon(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                  _selectedCategory = null;
                                  _selectedLevel = null;
                                });
                                _fadeController.reset();
                                _fadeController.forward();
                              },
                              icon: const Icon(Icons.refresh, size: 18),
                              label: const Text(
                                  'Hemû peyvan nîşan bide'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side: const BorderSide(
                                    color: AppColors.primary),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppSpacing.radiusMd),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// SIRALAMA SEÇENEĞİ — Bottom sheet öğesi
// ════════════════════════════════════════════════════════════════

class _SortOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SortOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,
          color:
              isSelected ? AppColors.primary : AppColors.textSecondary),
      title: Text(label,
          style: AppTypography.body.copyWith(
            color:
                isSelected ? AppColors.primary : AppColors.textPrimary,
            fontWeight:
                isSelected ? FontWeight.w600 : FontWeight.w400,
          )),
      trailing: isSelected
          ? const Icon(Icons.check_circle,
              color: AppColors.primary, size: 20)
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      onTap: onTap,
    );
  }
}

// ════════════════════════════════════════════════════════════════
// SEVİYE BÖLÜMÜ — Genişletilebilir
// ════════════════════════════════════════════════════════════════

class _LevelSection extends StatefulWidget {
  final _LevelData level;
  final List<dynamic> filteredWords;
  final Set<String> expandedWords;
  final String searchQuery;
  final ValueChanged<String> onToggleWord;

  const _LevelSection({
    required this.level,
    required this.filteredWords,
    required this.expandedWords,
    required this.searchQuery,
    required this.onToggleWord,
  });

  @override
  State<_LevelSection> createState() => _LevelSectionState();
}

class _LevelSectionState extends State<_LevelSection> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Seviye başlığı
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            margin: const EdgeInsets.only(bottom: AppSpacing.sm),
            decoration: BoxDecoration(
              color: widget.level.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border:
                  Border.all(color: widget.level.color.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: widget.level.color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      widget.level.name,
                      style: AppTypography.labelMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.level.label,
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${widget.filteredWords.length} peyv',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: widget.level.color,
                ),
              ],
            ),
          ),
        ),

        // Kelimeler
        if (_isExpanded)
          ...widget.filteredWords.map((word) {
            final id = word.id as String;
            final isExpanded = widget.expandedWords.contains(id);

            return _WordCard(
              word: word,
              levelColor: widget.level.color,
              isExpanded: isExpanded,
              searchQuery: widget.searchQuery,
              onTap: () => widget.onToggleWord(id),
              onNavigateDetail: () {
                context.push('/word-detail', extra: {
                  'word': word,
                  'levelColor': widget.level.color,
                });
              },
            );
          }),

        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// KELİME KARTI
// ════════════════════════════════════════════════════════════════

class _WordCard extends StatelessWidget {
  final dynamic word;
  final Color levelColor;
  final bool isExpanded;
  final String searchQuery;
  final VoidCallback onTap;
  final VoidCallback onNavigateDetail;

  const _WordCard({
    required this.word,
    required this.levelColor,
    required this.isExpanded,
    required this.searchQuery,
    required this.onTap,
    required this.onNavigateDetail,
  });

  @override
  Widget build(BuildContext context) {
    final ku = word.ku as String;
    final tr = word.tr as String;
    final en = word.en as String;
    final kat = word.kat as String;
    final cins = word.cins as String;
    final ez = word.ez as String?;
    final not_ = word.not as String?;
    final her = word.her as List<String>;
    final gen = word.gen as List<String>;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(AppSpacing.sm + 4),
        decoration: BoxDecoration(
          color: isExpanded
              ? levelColor.withOpacity(0.04)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: isExpanded
                ? levelColor.withOpacity(0.3)
                : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ana satir: ku, tr, en, kategori
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: 'word_${word.id}',
                        child: Material(
                          color: Colors.transparent,
                          child: _HighlightedText(
                            text: ku,
                            query: searchQuery,
                            style: AppTypography.kurmanjiCard.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                            highlightColor: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Flexible(
                            child: _HighlightedText(
                              text: tr,
                              query: searchQuery,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              highlightColor: AppColors.accent,
                            ),
                          ),
                          Text('  |  ',
                              style: AppTypography.caption.copyWith(
                                  color: AppColors.textSecondary)),
                          Flexible(
                            child: _HighlightedText(
                              text: en,
                              query: searchQuery,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              highlightColor: AppColors.accent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _categoryColor(kat).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    kat,
                    style: AppTypography.caption.copyWith(
                      color: _categoryColor(kat),
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ],
            ),

            // Genisletilmis detay
            if (isExpanded) ...[
              const SizedBox(height: AppSpacing.sm),
              Divider(height: 1, color: AppColors.border),
              const SizedBox(height: AppSpacing.sm),

              // Cinsiyet ve Ezafe
              Row(
                children: [
                  _DetailChip(
                    icon: Icons.male,
                    label: 'Cins: $cins',
                    color: cins == 'nêr'
                        ? Colors.blue
                        : cins == 'mê'
                            ? Colors.pink
                            : AppColors.textSecondary,
                  ),
                  if (ez != null && ez.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    _DetailChip(
                      icon: Icons.link,
                      label: 'Ezafe: $ez',
                      color: AppColors.primary,
                    ),
                  ],
                ],
              ),

              // Gramer notu
              if (not_ != null && not_.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.warningSurface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.lightbulb_outline,
                          size: 16, color: AppColors.warning),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          not_,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textPrimary,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Heritage cumleler
              if (her.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                _SentenceSection(
                  title: 'Heritage (Malbat)',
                  sentences: her,
                  color: AppColors.primary,
                ),
              ],

              // Genel cumleler
              if (gen.isNotEmpty) ...[
                const SizedBox(height: 6),
                _SentenceSection(
                  title: 'Genel (Giştî)',
                  sentences: gen,
                  color: AppColors.accent,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// METIN VURGULAMA — Arama sorgusuna göre eşleşen metni vurgula
// ════════════════════════════════════════════════════════════════

class _HighlightedText extends StatelessWidget {
  final String text;
  final String query;
  final TextStyle style;
  final Color highlightColor;

  const _HighlightedText({
    required this.text,
    required this.query,
    required this.style,
    required this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) {
      return Text(text, style: style, overflow: TextOverflow.ellipsis);
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final spans = <TextSpan>[];
    int start = 0;

    while (true) {
      final idx = lowerText.indexOf(lowerQuery, start);
      if (idx == -1) {
        spans.add(TextSpan(text: text.substring(start), style: style));
        break;
      }
      if (idx > start) {
        spans.add(
            TextSpan(text: text.substring(start, idx), style: style));
      }
      spans.add(TextSpan(
        text: text.substring(idx, idx + query.length),
        style: style.copyWith(
          color: highlightColor,
          fontWeight: FontWeight.w700,
          backgroundColor: highlightColor.withOpacity(0.12),
        ),
      ));
      start = idx + query.length;
    }

    return RichText(
      text: TextSpan(children: spans),
      overflow: TextOverflow.ellipsis,
    );
  }
}

// ════════════════════════════════════════════════════════════════
// YARDIMCI WIDGETʻLER
// ════════════════════════════════════════════════════════════════

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : color.withOpacity(0.3),
          ),
        ),
        child: Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: isSelected ? Colors.white : color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _DetailChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _SentenceSection extends StatelessWidget {
  final String title;
  final List<String> sentences;
  final Color color;

  const _SentenceSection({
    required this.title,
    required this.sentences,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.caption.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 3),
        ...sentences.map((s) => Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('  - ',
                      style: TextStyle(color: color, fontSize: 12)),
                  Expanded(
                    child: Text(
                      s,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
