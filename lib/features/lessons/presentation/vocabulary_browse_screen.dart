import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  State<VocabularyBrowseScreen> createState() => _VocabularyBrowseScreenState();
}

class _VocabularyBrowseScreenState extends State<VocabularyBrowseScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final Set<String> _expandedWords = {};
  String? _selectedLevel;

  late final List<_LevelData> _levels;

  @override
  void initState() {
    super.initState();
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
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool _wordMatchesSearch(dynamic word, String query) {
    if (query.isEmpty) return true;
    final q = query.toLowerCase();
    final ku = (word.ku as String).toLowerCase();
    final tr = (word.tr as String).toLowerCase();
    final en = (word.en as String).toLowerCase();
    final kat = (word.kat as String).toLowerCase();
    return ku.contains(q) || tr.contains(q) || en.contains(q) || kat.contains(q);
  }

  List<dynamic> _getFilteredWords(_LevelData level) {
    if (_searchQuery.isEmpty) return level.words;
    return level.words.where((w) => _wordMatchesSearch(w, _searchQuery)).toList();
  }

  int get _totalFilteredCount {
    int count = 0;
    for (final level in _levels) {
      count += _getFilteredWords(level).length;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final levelsToShow = _selectedLevel != null
        ? _levels.where((l) => l.name == _selectedLevel).toList()
        : _levels;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset('assets/images/logo_128.png', width: 36, height: 36,
              filterQuality: FilterQuality.medium),
            const SizedBox(width: 10),
            Text('Peyvên Kurmancî',
              style: AppTypography.headingSmall.copyWith(color: AppColors.textPrimary)),
          ],
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: AppSpacing.md),
              child: Text(
                '$_totalFilteredCount peyv',
                style: AppTypography.caption.copyWith(color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Arama Çubuğu ────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => _searchQuery = val.trim()),
              style: AppTypography.body.copyWith(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Kelime ara... (ku / tr / en)',
                hintStyle: AppTypography.body.copyWith(color: AppColors.textTertiary),
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 20),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: const BorderSide(color: AppColors.primary, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
              ),
            ),
          ),

          // ── Seviye Filtre Chipleri ──────────────────────────
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              children: [
                _FilterChip(
                  label: 'Hemû',
                  isSelected: _selectedLevel == null,
                  color: AppColors.primary,
                  onTap: () => setState(() => _selectedLevel = null),
                ),
                const SizedBox(width: 8),
                ..._levels.map((level) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _FilterChip(
                        label: '${level.name} (${_getFilteredWords(level).length})',
                        isSelected: _selectedLevel == level.name,
                        color: level.color,
                        onTap: () => setState(() {
                          _selectedLevel =
                              _selectedLevel == level.name ? null : level.name;
                        }),
                      ),
                    )),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          // ── Kelime Listesi ──────────────────────────────────
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              itemCount: levelsToShow.length,
              itemBuilder: (context, levelIndex) {
                final level = levelsToShow[levelIndex];
                final filtered = _getFilteredWords(level);
                if (filtered.isEmpty) return const SizedBox.shrink();

                return _LevelSection(
                  level: level,
                  filteredWords: filtered,
                  expandedWords: _expandedWords,
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
        ],
      ),
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
  final ValueChanged<String> onToggleWord;

  const _LevelSection({
    required this.level,
    required this.filteredWords,
    required this.expandedWords,
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
              border: Border.all(color: widget.level.color.withOpacity(0.3)),
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
              onTap: () => widget.onToggleWord(id),
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
  final VoidCallback onTap;

  const _WordCard({
    required this.word,
    required this.levelColor,
    required this.isExpanded,
    required this.onTap,
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
                      Text(
                        ku,
                        style: AppTypography.kurmanjiCard.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '$tr  |  $en',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: levelColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    kat,
                    style: AppTypography.caption.copyWith(
                      color: levelColor,
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
                  Text('  - ', style: TextStyle(color: color, fontSize: 12)),
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
