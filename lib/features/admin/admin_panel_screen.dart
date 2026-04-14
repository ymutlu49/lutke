import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/app_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../lessons/domain/a1_kelime_db.dart';
import '../lessons/domain/a2_kelime_db.dart';
import '../lessons/domain/b1_kelime_db.dart';
import '../lessons/domain/b2_kelime_db.dart';
import '../lessons/domain/c1_kelime_db.dart';
import '../lessons/domain/c2_kelime_db.dart';

// ════════════════════════════════════════════════════════════════
// ADMIN PANELİ — Veri yönetimi ve istatistikler
// Erişim: Ana ekran logosuna uzun basma
// ════════════════════════════════════════════════════════════════

class _LevelInfo {
  final String name;
  final List<dynamic> words;
  final Color color;
  _LevelInfo(this.name, this.words, this.color);
}

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final List<_LevelInfo> _levels;
  late final List<dynamic> _allWords;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _levels = [
      _LevelInfo('A1', kA1TamListe, const Color(0xFF4CAF50)),
      _LevelInfo('A2', kA2TamListe, const Color(0xFF8BC34A)),
      _LevelInfo('B1', kB1All, const Color(0xFFFF9800)),
      _LevelInfo('B2', kB2All, const Color(0xFFFF5722)),
      _LevelInfo('C1', kC1All, const Color(0xFF9C27B0)),
      _LevelInfo('C2', kC2All, const Color(0xFF673AB7)),
    ];
    _allWords = [];
    for (final level in _levels) {
      _allWords.addAll(level.words);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () { if (context.canPop()) context.pop(); else context.go(AppRoutes.home); },
        ),
        title: Row(
          children: [
            const Icon(Icons.admin_panel_settings, color: Colors.white, size: 22),
            const SizedBox(width: 8),
            Text(
              'Panela Rêveberiyê',
              style: AppTypography.headingSmall.copyWith(color: Colors.white),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppColors.accent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          labelStyle: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.w700),
          tabs: const [
            Tab(text: 'Lîsteya Peyvan'),
            Tab(text: 'Amar'),
            Tab(text: 'Kontrola Daneyan'),
            Tab(text: 'Lêgerîna Bilez'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _WordListTab(levels: _levels, allWords: _allWords),
          _StatsTab(levels: _levels, allWords: _allWords),
          _DataValidationTab(levels: _levels, allWords: _allWords),
          _QuickSearchTab(allWords: _allWords),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// TAB 1 — KELİME LİSTESİ
// ════════════════════════════════════════════════════════════════

class _WordListTab extends StatefulWidget {
  final List<_LevelInfo> levels;
  final List<dynamic> allWords;

  const _WordListTab({required this.levels, required this.allWords});

  @override
  State<_WordListTab> createState() => _WordListTabState();
}

class _WordListTabState extends State<_WordListTab> {
  String _filter = '';
  String? _selectedLevel;

  List<dynamic> get _filteredWords {
    var words = _selectedLevel != null
        ? widget.levels
            .firstWhere((l) => l.name == _selectedLevel)
            .words
        : widget.allWords;

    if (_filter.isNotEmpty) {
      final q = _filter.toLowerCase();
      words = words.where((w) {
        return (w.ku as String).toLowerCase().contains(q) ||
            (w.tr as String).toLowerCase().contains(q) ||
            (w.en as String).toLowerCase().contains(q) ||
            (w.id as String).toLowerCase().contains(q);
      }).toList();
    }
    return words;
  }

  @override
  Widget build(BuildContext context) {
    final words = _filteredWords;

    return Column(
      children: [
        // Arama
        Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: TextField(
            onChanged: (v) => setState(() => _filter = v.trim()),
            style: AppTypography.body,
            decoration: InputDecoration(
              hintText: 'Peyv an ID bigere...',
              prefixIcon: const Icon(Icons.search, size: 20),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.border),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),
            ),
          ),
        ),

        // Seviye filtre
        SizedBox(
          height: 36,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            children: [
              _AdminChip(
                label: 'Hemû (${widget.allWords.length})',
                selected: _selectedLevel == null,
                onTap: () => setState(() => _selectedLevel = null),
              ),
              ...widget.levels.map((l) => _AdminChip(
                    label: '${l.name} (${l.words.length})',
                    selected: _selectedLevel == l.name,
                    color: l.color,
                    onTap: () => setState(() =>
                        _selectedLevel = _selectedLevel == l.name ? null : l.name),
                  )),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md, vertical: 6),
          child: Text(
            '${words.length} encam',
            style: AppTypography.caption,
          ),
        ),

        // Liste
        Expanded(
          child: ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, i) {
              final w = words[i];
              return _AdminWordTile(word: w);
            },
          ),
        ),
      ],
    );
  }
}

class _AdminWordTile extends StatefulWidget {
  final dynamic word;
  const _AdminWordTile({required this.word});

  @override
  State<_AdminWordTile> createState() => _AdminWordTileState();
}

class _AdminWordTileState extends State<_AdminWordTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final w = widget.word;
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _expanded ? AppColors.primarySurface : AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    w.id as String,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace',
                        color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${w.ku}  —  ${w.tr}',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Text(
                  w.cins as String,
                  style: TextStyle(
                    fontSize: 10,
                    color: (w.cins as String) == 'nêr'
                        ? Colors.blue
                        : (w.cins as String) == 'mê'
                            ? Colors.pink
                            : AppColors.textTertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
            if (_expanded) ...[
              const SizedBox(height: 8),
              _DetailRow('EN', w.en as String),
              _DetailRow('Kategorî', w.kat as String),
              _DetailRow('Ezafe', (w.ez as String?) ?? '-'),
              _DetailRow('Astengî', '${w.zor}'),
              if ((w.not as String?) != null && (w.not as String).isNotEmpty)
                _DetailRow('Nîşe', w.not as String),
              const SizedBox(height: 4),
              if ((w.her as List<String>).isNotEmpty)
                _DetailRow('Heritage', (w.her as List<String>).join(' | ')),
              if ((w.gen as List<String>).isNotEmpty)
                _DetailRow('Giştî', (w.gen as List<String>).join(' | ')),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: AppTypography.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.caption.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// TAB 2 — İSTATİSTİKLER
// ════════════════════════════════════════════════════════════════

class _StatsTab extends StatelessWidget {
  final List<_LevelInfo> levels;
  final List<dynamic> allWords;

  const _StatsTab({required this.levels, required this.allWords});

  @override
  Widget build(BuildContext context) {
    // Kategori dağılımı
    final catCounts = <String, int>{};
    final genderCounts = <String, int>{};
    for (final w in allWords) {
      final kat = w.kat as String;
      catCounts[kat] = (catCounts[kat] ?? 0) + 1;
      final cins = w.cins as String;
      genderCounts[cins] = (genderCounts[cins] ?? 0) + 1;
    }
    final sortedCats = catCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Toplam
          _StatCard(
            title: 'Hejmara Giştî ya Peyvan',
            value: '${allWords.length}',
            icon: Icons.library_books,
            color: AppColors.primary,
          ),

          const SizedBox(height: AppSpacing.md),

          // Seviye dağılımı
          Text(
            'Dabeşkirina Astan',
            style: AppTypography.headingSmall.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          ...levels.map((level) {
            final pct = allWords.isEmpty
                ? 0.0
                : level.words.length / allWords.length;
            return _LevelStatBar(
              name: level.name,
              count: level.words.length,
              percent: pct,
              color: level.color,
            );
          }),

          const SizedBox(height: AppSpacing.lg),

          // Cinsiyet dağılımı
          Text(
            'Dabeşkirina Cinsan',
            style: AppTypography.headingSmall.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          Row(
            children: [
              _GenderChip('nêr', genderCounts['nêr'] ?? 0, Colors.blue),
              const SizedBox(width: 8),
              _GenderChip('mê', genderCounts['mê'] ?? 0, Colors.pink),
              const SizedBox(width: 8),
              _GenderChip('bêcins', genderCounts['bêcins'] ?? 0, AppColors.textSecondary),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // Kategori dağılımı
          Text(
            'Dabeşkirina Kategoriyan (20 pêşîn)',
            style: AppTypography.headingSmall.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          ...sortedCats.take(20).map((entry) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text(
                        entry.key,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: entry.value / (sortedCats.first.value),
                          backgroundColor: AppColors.border,
                          valueColor:
                              AlwaysStoppedAnimation(AppColors.primary.withOpacity(0.6)),
                          minHeight: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${entry.value}',
                      style: AppTypography.caption.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              )),

          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
              Text(
                value,
                style: AppTypography.headline.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LevelStatBar extends StatelessWidget {
  final String name;
  final int count;
  final double percent;
  final Color color;

  const _LevelStatBar({
    required this.name,
    required this.count,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: percent,
                backgroundColor: color.withOpacity(0.12),
                valueColor: AlwaysStoppedAnimation(color),
                minHeight: 20,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 60,
            child: Text(
              '$count',
              textAlign: TextAlign.right,
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GenderChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  const _GenderChip(this.label, this.count, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '$count',
            style: AppTypography.labelLarge.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// TAB 3 — VERİ KONTROLÜ
// ════════════════════════════════════════════════════════════════

class _DataValidationTab extends StatefulWidget {
  final List<_LevelInfo> levels;
  final List<dynamic> allWords;

  const _DataValidationTab({required this.levels, required this.allWords});

  @override
  State<_DataValidationTab> createState() => _DataValidationTabState();
}

class _DataValidationTabState extends State<_DataValidationTab> {
  List<_ValidationIssue>? _issues;
  bool _running = false;

  void _runValidation() {
    setState(() => _running = true);

    final issues = <_ValidationIssue>[];

    // Tekrar eden IDʻler
    final idSet = <String>{};
    final duplicateIds = <String>{};
    for (final w in widget.allWords) {
      final id = w.id as String;
      if (!idSet.add(id)) {
        duplicateIds.add(id);
      }
    }
    for (final dup in duplicateIds) {
      issues.add(_ValidationIssue(
        severity: _Severity.error,
        message: 'IDya dubare: $dup',
        wordId: dup,
      ));
    }

    // Eksik alanlar
    for (final w in widget.allWords) {
      final id = w.id as String;
      if ((w.ku as String).trim().isEmpty) {
        issues.add(_ValidationIssue(
          severity: _Severity.error,
          message: 'Qada Kurmancî (ku) vala ye',
          wordId: id,
        ));
      }
      if ((w.tr as String).trim().isEmpty) {
        issues.add(_ValidationIssue(
          severity: _Severity.warning,
          message: 'Qada Tirkî (tr) vala ye',
          wordId: id,
        ));
      }
      if ((w.en as String).trim().isEmpty) {
        issues.add(_ValidationIssue(
          severity: _Severity.warning,
          message: 'Qada Îngilîzî (en) vala ye',
          wordId: id,
        ));
      }
      final cins = w.cins as String;
      if (!['nêr', 'mê', 'bêcins'].contains(cins)) {
        issues.add(_ValidationIssue(
          severity: _Severity.error,
          message: 'Cinsê nederbasdar: "$cins"',
          wordId: id,
        ));
      }
      if ((w.her as List<String>).isEmpty) {
        issues.add(_ValidationIssue(
          severity: _Severity.info,
          message: 'Hevoka Heritage kêm e',
          wordId: id,
        ));
      }
      if ((w.gen as List<String>).isEmpty) {
        issues.add(_ValidationIssue(
          severity: _Severity.info,
          message: 'Hevoka giştî kêm e',
          wordId: id,
        ));
      }
    }

    setState(() {
      _issues = issues;
      _running = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _running ? null : _runValidation,
              icon: _running
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.verified_user, size: 20),
              label: Text(_running ? 'Tê kontrol kirin...' : 'Kontrola Daneyan Dest Pê Bike'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),

        if (_issues != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              children: [
                _IssueSummaryChip(
                  'Çewtî',
                  _issues!.where((i) => i.severity == _Severity.error).length,
                  AppColors.errorSoft,
                ),
                const SizedBox(width: 8),
                _IssueSummaryChip(
                  'Hişyarî',
                  _issues!.where((i) => i.severity == _Severity.warning).length,
                  AppColors.warning,
                ),
                const SizedBox(width: 8),
                _IssueSummaryChip(
                  'Agahî',
                  _issues!.where((i) => i.severity == _Severity.info).length,
                  AppColors.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _issues!.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle,
                            size: 48, color: AppColors.success),
                        const SizedBox(height: 8),
                        Text(
                          'Yekrêziya daneyan baş e!',
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _issues!.length,
                    itemBuilder: (context, i) {
                      final issue = _issues![i];
                      return ListTile(
                        dense: true,
                        leading: Icon(
                          issue.severity == _Severity.error
                              ? Icons.error
                              : issue.severity == _Severity.warning
                                  ? Icons.warning
                                  : Icons.info_outline,
                          color: issue.severity == _Severity.error
                              ? AppColors.errorSoft
                              : issue.severity == _Severity.warning
                                  ? AppColors.warning
                                  : AppColors.primary,
                          size: 20,
                        ),
                        title: Text(
                          issue.message,
                          style: AppTypography.body.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: 13,
                          ),
                        ),
                        subtitle: Text(
                          issue.wordId,
                          style: const TextStyle(
                            fontSize: 11,
                            fontFamily: 'monospace',
                            color: AppColors.textTertiary,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ] else
          Expanded(
            child: Center(
              child: Text(
                'Ji bo destpêkirina kontrolê bişkojkê bitikînin',
                style: AppTypography.body.copyWith(color: AppColors.textSecondary),
              ),
            ),
          ),
      ],
    );
  }
}

class _IssueSummaryChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  const _IssueSummaryChip(this.label, this.count, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        '$label: $count',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

enum _Severity { error, warning, info }

class _ValidationIssue {
  final _Severity severity;
  final String message;
  final String wordId;
  const _ValidationIssue({
    required this.severity,
    required this.message,
    required this.wordId,
  });
}

// ════════════════════════════════════════════════════════════════
// TAB 4 — HIZLI ARAMA
// ════════════════════════════════════════════════════════════════

class _QuickSearchTab extends StatefulWidget {
  final List<dynamic> allWords;
  const _QuickSearchTab({required this.allWords});

  @override
  State<_QuickSearchTab> createState() => _QuickSearchTabState();
}

class _QuickSearchTabState extends State<_QuickSearchTab> {
  final TextEditingController _controller = TextEditingController();
  dynamic _found;
  bool _searched = false;

  void _search() {
    final q = _controller.text.trim().toLowerCase();
    if (q.isEmpty) return;

    setState(() {
      _searched = true;
      _found = null;
      for (final w in widget.allWords) {
        if ((w.ku as String).toLowerCase() == q ||
            (w.id as String).toLowerCase() == q ||
            (w.tr as String).toLowerCase() == q) {
          _found = w;
          break;
        }
      }
      // Fallback: partial match
      if (_found == null) {
        for (final w in widget.allWords) {
          if ((w.ku as String).toLowerCase().contains(q) ||
              (w.tr as String).toLowerCase().contains(q)) {
            _found = w;
            break;
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'IDya peyvê an navê wê binivîsin û bigerin:',
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  onSubmitted: (_) => _search(),
                  style: AppTypography.body,
                  decoration: InputDecoration(
                    hintText: 'mînak: Silav, a1_010',
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _search,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Icon(Icons.search, size: 20),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          if (_searched && _found == null)
            Center(
              child: Column(
                children: [
                  const Icon(Icons.search_off, size: 40, color: AppColors.textTertiary),
                  const SizedBox(height: 8),
                  Text(
                    'Peyv nehate dîtin',
                    style: AppTypography.body.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),

          if (_found != null) _FullWordDetail(word: _found!),
        ],
      ),
    );
  }
}

class _FullWordDetail extends StatelessWidget {
  final dynamic word;
  const _FullWordDetail({required this.word});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kurmancî
              Text(
                word.ku as String,
                style: AppTypography.kurmanjiLarge,
              ),
              const SizedBox(height: 4),
              Text(
                word.tr as String,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                word.en as String,
                style: AppTypography.body.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Divider(color: AppColors.border),
              const SizedBox(height: AppSpacing.sm),

              _FieldRow('ID', word.id as String),
              _FieldRow('Cinsiyet', word.cins as String),
              _FieldRow('Ezafe', (word.ez as String?) ?? '-'),
              _FieldRow('Kategori', word.kat as String),
              _FieldRow('Zorluk', '${word.zor}'),
              if ((word.not as String?) != null)
                _FieldRow('Not', word.not as String),
              const SizedBox(height: AppSpacing.sm),
              if ((word.her as List<String>).isNotEmpty) ...[
                Text('Heritage:',
                    style: AppTypography.labelSmall.copyWith(
                        color: AppColors.primary, fontWeight: FontWeight.w700)),
                ...(word.her as List<String>).map((s) => Padding(
                      padding: const EdgeInsets.only(left: 12, top: 2),
                      child: Text('- $s',
                          style: AppTypography.body.copyWith(fontSize: 13)),
                    )),
                const SizedBox(height: 6),
              ],
              if ((word.gen as List<String>).isNotEmpty) ...[
                Text('Genel:',
                    style: AppTypography.labelSmall.copyWith(
                        color: AppColors.accent, fontWeight: FontWeight.w700)),
                ...(word.gen as List<String>).map((s) => Padding(
                      padding: const EdgeInsets.only(left: 12, top: 2),
                      child: Text('- $s',
                          style: AppTypography.body.copyWith(fontSize: 13)),
                    )),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldRow extends StatelessWidget {
  final String label;
  final String value;
  const _FieldRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: AppTypography.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.body.copyWith(
                color: AppColors.textPrimary,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// ADMIN YARDIMCI CHIP
// ════════════════════════════════════════════════════════════════

class _AdminChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color? color;
  final VoidCallback onTap;

  const _AdminChip({
    required this.label,
    required this.selected,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: selected ? c : c.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: selected ? c : c.withOpacity(0.3)),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : c,
            ),
          ),
        ),
      ),
    );
  }
}
