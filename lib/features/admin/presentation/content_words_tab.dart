import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../lessons/domain/a1_kelime_db.dart';
import '../../lessons/domain/a2_kelime_db.dart';
import '../../lessons/domain/b1_kelime_db.dart';
import '../../lessons/domain/b2_kelime_db.dart';
import '../../lessons/domain/c1_kelime_db.dart';
import '../../lessons/domain/c2_kelime_db.dart';
import '../../lessons/domain/child_a1_kelime_db.dart';
import '../../lessons/domain/child_a2_kelime_db.dart';
import '../data/content_override_service.dart';

// ════════════════════════════════════════════════════════════════
// CONTENT EDITOR — KELİME SEKMESİ
//
// Mevcut DB kelimelerinin listesi, arama, seviye filtresi, edit,
// soft-delete + restore, yeni özel kelime ekleme. Tüm işlemler
// SharedPreferences üzerinden kalıcıdır.
//
// CRUD akışları:
//   - Tıkla → edit sheet
//   - Uzun bas (veya çöp ikonu) → soft-delete confirm
//   - Silinmişse "Vegere" butonu ile geri al
//   - FAB → yeni özel kelime ekle
// ════════════════════════════════════════════════════════════════

const _kLevelPacks = <_LevelPack>[
  _LevelPack('A1', 'A1', Color(0xFF4CAF50)),
  _LevelPack('A2', 'A2', Color(0xFF8BC34A)),
  _LevelPack('B1', 'B1', Color(0xFFFF9800)),
  _LevelPack('B2', 'B2', Color(0xFFFF5722)),
  _LevelPack('C1', 'C1', Color(0xFF9C27B0)),
  _LevelPack('C2', 'C2', Color(0xFF673AB7)),
  _LevelPack('CHILD_A1', 'Zarok A1', Color(0xFF26A69A)),
  _LevelPack('CHILD_A2', 'Zarok A2', Color(0xFF5C6BC0)),
];

class _LevelPack {
  final String key;
  final String label;
  final Color color;
  const _LevelPack(this.key, this.label, this.color);
}

List<dynamic> _wordsForLevelKey(String key) => switch (key) {
      'A1' => kA1TamListe,
      'A2' => kA2TamListe,
      'B1' => kB1All,
      'B2' => kB2All,
      'C1' => kC1All,
      'C2' => kC2All,
      'CHILD_A1' => kChildA1Kelimeler,
      'CHILD_A2' => kChildA2Kelimeler,
      _ => kA1TamListe,
    };

/// Tüm DB kategorilerini topla — dropdown dolgusu için.
List<String> _allCategories() {
  final set = <String>{};
  for (final p in _kLevelPacks) {
    for (final w in _wordsForLevelKey(p.key)) {
      final k = w.kat as String?;
      if (k != null && k.isNotEmpty) set.add(k);
    }
  }
  final list = set.toList()..sort();
  if (!list.contains('custom')) list.insert(0, 'custom');
  return list;
}

class ContentWordsTab extends ConsumerStatefulWidget {
  const ContentWordsTab({super.key});

  @override
  ConsumerState<ContentWordsTab> createState() => _ContentWordsTabState();
}

class _ContentWordsTabState extends ConsumerState<ContentWordsTab> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';
  String? _level; // null = hemû

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<dynamic> _filtered({
    required Map<String, WordOverride> overrides,
    required Set<String> deletedIds,
    required Map<String, CustomWord> customWords,
  }) {
    // Pool seçimi: level null → hepsi, level varsa o pack + custom kelimeler
    final pool = <dynamic>[];
    if (_level == null) {
      // DB kelimeleri (overrides uygulansın, deleted filtresi uygulanmasın —
      // silinenler görünsün ki kullanıcı geri alabilsin).
      for (final p in _kLevelPacks) {
        for (final w in _wordsForLevelKey(p.key)) {
          final id = w.id as String;
          final o = overrides[id];
          pool.add(o == null || o.isEmpty ? w : _OverriddenPreview(w, o));
        }
      }
      // Tüm custom kelimeler
      for (final cw in customWords.values) {
        pool.add(_CustomPreview(cw));
      }
    } else {
      for (final w in _wordsForLevelKey(_level!)) {
        final id = w.id as String;
        final o = overrides[id];
        pool.add(o == null || o.isEmpty ? w : _OverriddenPreview(w, o));
      }
      for (final cw in customWords.values) {
        if (cw.level == _level) pool.add(_CustomPreview(cw));
      }
    }

    if (_query.isEmpty) return pool;
    final q = _query.toLowerCase();
    return pool.where((w) {
      final ku = (w.ku as String).toLowerCase();
      final tr = (w.tr as String).toLowerCase();
      return ku.contains(q) || tr.contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final overrides = ref.watch(contentOverridesProvider);
    final deletedIds = ref.watch(deletedWordIdsProvider);
    final customWords = ref.watch(customWordsProvider);
    final words = _filtered(
      overrides: overrides,
      deletedIds: deletedIds,
      customWords: customWords,
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Column(
        children: [
          // ── Arama ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _query = v.trim()),
              style: AppTypography.body,
              decoration: InputDecoration(
                hintText: 'Li Kurmancî an Tirkî bigere...',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchCtrl.clear();
                          setState(() => _query = '');
                        },
                      ),
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

          // ── Ast filtrasyonu ─────────────────────────────────
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              children: [
                _FilterChip(
                  label: 'Hemû',
                  selected: _level == null,
                  onTap: () => setState(() => _level = null),
                ),
                ..._kLevelPacks.map((p) => _FilterChip(
                      label: p.label,
                      selected: _level == p.key,
                      color: p.color,
                      onTap: () => setState(
                          () => _level = _level == p.key ? null : p.key),
                    )),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: 6),
            child: Row(
              children: [
                Text(
                  '${words.length} peyv',
                  style: AppTypography.caption,
                ),
                if (customWords.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '+${customWords.length}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.success,
                      ),
                    ),
                  ),
                ],
                if (deletedIds.isNotEmpty) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.errorSoft.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '-${deletedIds.length}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.errorSoft,
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                if (overrides.isNotEmpty ||
                    deletedIds.isNotEmpty ||
                    customWords.isNotEmpty)
                  TextButton.icon(
                    onPressed: _confirmClearAll,
                    icon: Icon(Icons.delete_sweep_rounded,
                        size: 16, color: AppColors.errorSoft),
                    label: Text(
                      'Hemûyan vegerîne',
                      style: TextStyle(
                          color: AppColors.errorSoft, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),

          // ── Liste ───────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: words.length,
              itemBuilder: (context, i) {
                final w = words[i];
                final id = w.id as String;
                final isCustom = isCustomWordId(id);
                final isDeleted = deletedIds.contains(id);
                final override = overrides[id];
                return _WordRow(
                  word: w,
                  isCustom: isCustom,
                  isDeleted: isDeleted,
                  edited: override != null && override.isNotEmpty,
                  onTap: isDeleted
                      ? null
                      : () => _openEditor(w, override, isCustom: isCustom),
                  onDelete: isDeleted
                      ? null
                      : () => _confirmDelete(id, w.ku as String,
                          isCustom: isCustom),
                  onRestore: isDeleted
                      ? () async {
                          await ref
                              .read(deletedWordIdsProvider.notifier)
                              .restore(id);
                        }
                      : null,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddCustomDialog,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text('Peyva nû',
            style: AppTypography.labelMedium
                .copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
      ),
    );
  }

  // ── Destructive confirm ─────────────────────────────────────

  Future<void> _confirmDelete(String id, String ku,
      {required bool isCustom}) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Peyv were jêbirin?'),
        content: Text(isCustom
            ? '"$ku" bi temamî tê jêbirin. Ev kar venagere.'
            : '"$ku" tê veşartin. Tu dikarî paşê vegerînî.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Betal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(isCustom ? 'Jê bibe' : 'Veşêre',
                style: TextStyle(color: AppColors.errorSoft)),
          ),
        ],
      ),
    );
    if (ok != true) return;
    if (isCustom) {
      await ref.read(customWordsProvider.notifier).deleteWord(id);
    } else {
      await ref.read(deletedWordIdsProvider.notifier).markDeleted(id);
    }
  }

  Future<void> _confirmClearAll() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hemû guhartin vegerin?'),
        content: const Text(
            'Guhartin, veşartin û peyvên xweser hemû tên jêbirin. Ev kar venagere.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Betal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Jê bibe',
                style: TextStyle(color: AppColors.errorSoft)),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await ref.read(contentOverridesProvider.notifier).clearAll();
    await ref.read(deletedWordIdsProvider.notifier).clearAll();
    await ref.read(customWordsProvider.notifier).clearAll();
  }

  // ── Edit & add dialogs ──────────────────────────────────────

  Future<void> _openEditor(dynamic word, WordOverride? current,
      {required bool isCustom}) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) =>
          _EditorSheet(word: word, current: current, isCustom: isCustom),
    );
  }

  Future<void> _openAddCustomDialog() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const _AddCustomSheet(),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// WORD ROW
// ════════════════════════════════════════════════════════════════

class _WordRow extends StatelessWidget {
  final dynamic word;
  final bool isCustom;
  final bool isDeleted;
  final bool edited;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onRestore;
  const _WordRow({
    required this.word,
    required this.isCustom,
    required this.isDeleted,
    required this.edited,
    required this.onTap,
    required this.onDelete,
    required this.onRestore,
  });

  @override
  Widget build(BuildContext context) {
    final id = word.id as String;
    final ku = word.ku as String;
    final tr = word.tr as String;

    final bgColor = isDeleted
        ? AppColors.errorSoft.withOpacity(0.08)
        : isCustom
            ? AppColors.success.withOpacity(0.06)
            : edited
                ? AppColors.accent.withOpacity(0.08)
                : AppColors.surface;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isDeleted
                ? AppColors.errorSoft.withOpacity(0.4)
                : isCustom
                    ? AppColors.success.withOpacity(0.4)
                    : edited
                        ? AppColors.accent.withOpacity(0.5)
                        : AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                id,
                style: const TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ku,
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      decoration:
                          isDeleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  Text(
                    tr,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                      decoration:
                          isDeleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
            ),
            if (isCustom) _Badge(text: 'Custom', color: AppColors.success),
            if (edited && !isCustom)
              _Badge(text: 'Edit', color: AppColors.accent),
            if (isDeleted && onRestore != null)
              TextButton.icon(
                onPressed: onRestore,
                icon: Icon(Icons.undo_rounded,
                    size: 16, color: AppColors.primary),
                label: Text('Vegere',
                    style: TextStyle(
                        fontSize: 11,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700)),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: const Size(0, 30),
                ),
              ),
            if (!isDeleted)
              IconButton(
                tooltip: 'Edît bike',
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                    minWidth: 32, minHeight: 32),
                icon: Icon(Icons.edit_outlined,
                    size: 18, color: AppColors.primary),
                onPressed: onTap,
              ),
            if (!isDeleted && onDelete != null)
              IconButton(
                tooltip: 'Veşêre',
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                    minWidth: 32, minHeight: 32),
                icon: Icon(Icons.delete_outline,
                    size: 18, color: AppColors.errorSoft),
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;
  const _Badge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color? color;
  final VoidCallback onTap;

  const _FilterChip({
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? c : c.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: selected ? c : c.withOpacity(0.3)),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : c,
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// EDITOR SHEET — existing + custom editing
// ════════════════════════════════════════════════════════════════

class _EditorSheet extends ConsumerStatefulWidget {
  final dynamic word;
  final WordOverride? current;
  final bool isCustom;
  const _EditorSheet({
    required this.word,
    required this.current,
    required this.isCustom,
  });

  @override
  ConsumerState<_EditorSheet> createState() => _EditorSheetState();
}

class _EditorSheetState extends ConsumerState<_EditorSheet> {
  late final TextEditingController _kuCtrl;
  late final TextEditingController _trCtrl;
  late final TextEditingController _enCtrl;
  late final TextEditingController _ezCtrl;
  late final TextEditingController _notCtrl;
  late String _cins;
  late double _zor;

  late final String _origTr;
  late final String _origEn;
  late final String _origEz;
  late final String _origNot;
  late final String _origCins;
  late final double _origZor;

  static const _cinsOptions = <String>['mê', 'nêr', 'bêcins'];

  @override
  void initState() {
    super.initState();
    final w = widget.word;
    _origTr = (w.tr as String?) ?? '';
    _origEn = (w.en as String?) ?? '';
    _origEz = (w.ez as String?) ?? '';
    _origNot = (w.not as String?) ?? '';
    _origCins = (w.cins as String?) ?? 'bêcins';
    _origZor = ((w.zor as num?) ?? 0.75).toDouble();

    _kuCtrl = TextEditingController(text: w.ku as String);
    final o = widget.current;
    _trCtrl = TextEditingController(text: o?.tr ?? _origTr);
    _enCtrl = TextEditingController(text: o?.en ?? _origEn);
    _ezCtrl = TextEditingController(text: o?.ez ?? _origEz);
    _notCtrl = TextEditingController(text: o?.not ?? _origNot);
    _cins = _cinsOptions.contains(o?.cins ?? _origCins)
        ? (o?.cins ?? _origCins)
        : 'bêcins';
    _zor = (o?.zor ?? _origZor).clamp(0.0, 1.0);
  }

  @override
  void dispose() {
    _kuCtrl.dispose();
    _trCtrl.dispose();
    _enCtrl.dispose();
    _ezCtrl.dispose();
    _notCtrl.dispose();
    super.dispose();
  }

  WordOverride _buildOverride() {
    final trVal = _trCtrl.text.trim();
    final enVal = _enCtrl.text.trim();
    final ezVal = _ezCtrl.text.trim();
    final notVal = _notCtrl.text.trim();
    return WordOverride(
      tr: trVal != _origTr ? trVal : null,
      en: enVal != _origEn ? enVal : null,
      ez: ezVal != _origEz ? ezVal : null,
      not: notVal != _origNot ? notVal : null,
      cins: _cins != _origCins ? _cins : null,
      zor: (_zor - _origZor).abs() > 0.001 ? _zor : null,
    );
  }

  Future<void> _save() async {
    final id = widget.word.id as String;
    if (widget.isCustom) {
      final current = ref.read(customWordsProvider)[id];
      if (current == null) return;
      final updated = current.copyWith(
        ku: _kuCtrl.text.trim().isEmpty ? current.ku : _kuCtrl.text.trim(),
        tr: _trCtrl.text.trim(),
        en: _enCtrl.text.trim(),
        ez: _ezCtrl.text.trim().isEmpty ? null : _ezCtrl.text.trim(),
        cins: _cins,
        zor: _zor,
      );
      await ref.read(customWordsProvider.notifier).saveWord(updated);
    } else {
      final override = _buildOverride();
      await ref
          .read(contentOverridesProvider.notifier)
          .setOverride(id, override);
    }
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Hat tomarkirin'),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _reset() async {
    final id = widget.word.id as String;
    await ref.read(contentOverridesProvider.notifier).removeOverride(id);
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Vegeriya rewşa resen'),
        backgroundColor: AppColors.textSecondary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.word;
    final ku = w.ku as String;
    final id = w.id as String;
    final kat = w.kat as String;
    final hasOverride = widget.current != null && widget.current!.isNotEmpty;
    final viewInsets = MediaQuery.of(context).viewInsets;

    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets.bottom),
      child: DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 4),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderMedium,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ku,
                            style: AppTypography.headingSmall.copyWith(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            '$id  ·  $kat',
                            style: AppTypography.caption.copyWith(
                              fontFamily: 'monospace',
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    if (widget.isCustom)
                      _FormField(
                        label: 'Kurmancî',
                        controller: _kuCtrl,
                      )
                    else
                      _ReadOnlyField(
                        label: 'Kurmancî (tenê tê xwendin)',
                        value: ku,
                      ),
                    const SizedBox(height: 12),
                    _FormField(label: 'Tirkî', controller: _trCtrl),
                    const SizedBox(height: 12),
                    _FormField(label: 'Îngilîzî', controller: _enCtrl),
                    const SizedBox(height: 12),
                    _CinsDropdown(
                      value: _cins,
                      onChanged: (v) {
                        if (v != null) setState(() => _cins = v);
                      },
                    ),
                    const SizedBox(height: 12),
                    _FormField(
                      label: 'Veqetandek',
                      controller: _ezCtrl,
                      hint: 'mînak: -ê / -a / -yê',
                    ),
                    const SizedBox(height: 12),
                    if (!widget.isCustom) ...[
                      _FormField(
                        label: 'Nîşeya rêzimanî',
                        controller: _notCtrl,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),
                    ],
                    _ZorSlider(
                      value: _zor,
                      onChanged: (v) => setState(() => _zor = v),
                    ),
                    const SizedBox(height: 20),
                    _ActionButtons(
                      hasOverride: hasOverride && !widget.isCustom,
                      onSave: _save,
                      onReset: _reset,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// ADD CUSTOM SHEET — yeni kelime oluştur
// ════════════════════════════════════════════════════════════════

class _AddCustomSheet extends ConsumerStatefulWidget {
  const _AddCustomSheet();

  @override
  ConsumerState<_AddCustomSheet> createState() => _AddCustomSheetState();
}

class _AddCustomSheetState extends ConsumerState<_AddCustomSheet> {
  final _kuCtrl = TextEditingController();
  final _trCtrl = TextEditingController();
  final _enCtrl = TextEditingController();
  final _ezCtrl = TextEditingController();
  String _cins = 'bêcins';
  String _kat = 'custom';
  String _level = 'A1';
  double _zor = 0.75;
  bool _submitting = false;
  late final List<String> _cats;

  @override
  void initState() {
    super.initState();
    _cats = _allCategories();
  }

  @override
  void dispose() {
    _kuCtrl.dispose();
    _trCtrl.dispose();
    _enCtrl.dispose();
    _ezCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final ku = _kuCtrl.text.trim();
    final tr = _trCtrl.text.trim();
    if (ku.isEmpty || tr.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Qadên Kurmancî û Tirkî pêwîst in'),
          backgroundColor: AppColors.errorSoft,
        ),
      );
      return;
    }
    setState(() => _submitting = true);
    final w = CustomWord(
      id: CustomWord.newId(),
      ku: ku,
      tr: tr,
      en: _enCtrl.text.trim(),
      cins: _cins,
      ez: _ezCtrl.text.trim().isEmpty ? null : _ezCtrl.text.trim(),
      kat: _kat,
      zor: _zor,
      level: _level,
    );
    await ref.read(customWordsProvider.notifier).saveWord(w);
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"$ku" hat zêdekirin'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;

    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets.bottom),
      child: DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 4),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderMedium,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Peyveke nû zêde bike',
                        style: AppTypography.headingSmall.copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    _FormField(
                      label: 'Kurmancî *',
                      controller: _kuCtrl,
                    ),
                    const SizedBox(height: 12),
                    _FormField(label: 'Tirkî *', controller: _trCtrl),
                    const SizedBox(height: 12),
                    _FormField(label: 'Îngilîzî', controller: _enCtrl),
                    const SizedBox(height: 12),
                    _CinsDropdown(
                      value: _cins,
                      onChanged: (v) {
                        if (v != null) setState(() => _cins = v);
                      },
                    ),
                    const SizedBox(height: 12),
                    _FormField(
                      label: 'Veqetandek',
                      controller: _ezCtrl,
                      hint: 'mînak: -ê / -a',
                    ),
                    const SizedBox(height: 12),
                    _LabeledDropdown<String>(
                      label: 'Kategorî',
                      value: _kat,
                      items: _cats,
                      itemLabel: (c) => c,
                      onChanged: (v) {
                        if (v != null) setState(() => _kat = v);
                      },
                    ),
                    const SizedBox(height: 12),
                    _LabeledDropdown<String>(
                      label: 'Ast (level)',
                      value: _level,
                      items: _kLevelPacks.map((p) => p.key).toList(),
                      itemLabel: (k) =>
                          _kLevelPacks.firstWhere((p) => p.key == k).label,
                      onChanged: (v) {
                        if (v != null) setState(() => _level = v);
                      },
                    ),
                    const SizedBox(height: 16),
                    _ZorSlider(
                      value: _zor,
                      onChanged: (v) => setState(() => _zor = v),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _submitting ? null : _submit,
                      icon: const Icon(Icons.check_rounded),
                      label: Text(_submitting ? 'Tê tomarkirin...' : 'Zêde bike'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// SUBWIDGETS
// ════════════════════════════════════════════════════════════════

class _ReadOnlyField extends StatelessWidget {
  final String label;
  final String value;
  const _ReadOnlyField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textTertiary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.backgroundTertiary,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Text(
            value,
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? hint;
  final int maxLines;
  const _FormField({
    required this.label,
    required this.controller,
    this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textTertiary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: AppTypography.body,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: AppColors.surface,
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.border),
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 10),
          ),
        ),
      ],
    );
  }
}

class _CinsDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;
  const _CinsDropdown({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return _LabeledDropdown<String>(
      label: 'Cins · zayend',
      value: value,
      items: const ['mê', 'nêr', 'bêcins'],
      itemLabel: (v) => switch (v) {
        'mê' => 'mê (dişil / feminine)',
        'nêr' => 'nêr (eril / masculine)',
        _ => 'bêcins (yok / neuter)',
      },
      onChanged: onChanged,
    );
  }
}

class _LabeledDropdown<T> extends StatelessWidget {
  final String label;
  final T value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;
  const _LabeledDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final safeValue = items.contains(value) ? value : items.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textTertiary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: safeValue,
              isExpanded: true,
              items: items
                  .map((e) => DropdownMenuItem<T>(
                        value: e,
                        child: Text(itemLabel(e)),
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class _ZorSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  const _ZorSlider({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Zehmetî (zor)',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textTertiary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              value.toStringAsFixed(2),
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: 0.0,
          max: 1.0,
          divisions: 20,
          activeColor: AppColors.primary,
          label: value.toStringAsFixed(2),
          onChanged: onChanged,
        ),
        Text(
          '0.00 = pir hêsan · 1.00 = pir zehmet',
          style: AppTypography.caption
              .copyWith(color: AppColors.textTertiary),
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final bool hasOverride;
  final Future<void> Function() onSave;
  final Future<void> Function() onReset;
  const _ActionButtons({
    required this.hasOverride,
    required this.onSave,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (hasOverride) ...[
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onReset,
              icon: Icon(Icons.restart_alt_rounded,
                  color: AppColors.errorSoft),
              label: Text('Vegere rewşa resen',
                  style: TextStyle(color: AppColors.errorSoft)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(color: AppColors.errorSoft),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
        Expanded(
          flex: 2,
          child: ElevatedButton.icon(
            onPressed: onSave,
            icon: const Icon(Icons.save_rounded),
            label: const Text('Tomar bike'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Dahili önizleme sarmalayıcıları — yalnızca editor listesinde.
// Bunlar applyVocabulary() yerine, listenin `edited` veya `custom`
// rozetini görsel olarak doğrulamak için kullanılır.
// ════════════════════════════════════════════════════════════════

class _OverriddenPreview {
  final dynamic _raw;
  final WordOverride _o;
  const _OverriddenPreview(this._raw, this._o);
  dynamic get id => _raw.id;
  dynamic get ku => _raw.ku;
  dynamic get kat => _raw.kat;
  dynamic get tr => _o.tr ?? _raw.tr;
  dynamic get en => _o.en ?? _raw.en;
  dynamic get not => _o.not ?? _raw.not;
  dynamic get zor => _o.zor ?? _raw.zor;
  dynamic get cins => _o.cins ?? _raw.cins;
  dynamic get ez => _o.ez ?? _raw.ez;
  dynamic get her => _raw.her;
  dynamic get gen => _raw.gen;
}

class _CustomPreview {
  final CustomWord _w;
  const _CustomPreview(this._w);
  String get id => _w.id;
  String get ku => _w.ku;
  String get tr => _w.tr;
  String get en => _w.en;
  String get kat => _w.kat;
  double get zor => _w.zor;
  String get cins => _w.cins;
  String? get ez => _w.ez;
  String? get not => null;
  List<String> get her => _w.her;
  List<String> get gen => _w.gen;
}
