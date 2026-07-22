import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../lessons/domain/a1_kelime_db.dart';
import '../../lessons/domain/a1_lesson_definitions.dart';
import '../../lessons/domain/a2_kelime_db.dart';
import '../../lessons/domain/a2_lesson_definitions.dart';
import '../../lessons/domain/b1_kelime_db.dart';
import '../../lessons/domain/b1_lesson_definitions.dart';
import '../../lessons/domain/b2_kelime_db.dart';
import '../../lessons/domain/b2_lesson_definitions.dart';
import '../../lessons/domain/c1_kelime_db.dart';
import '../../lessons/domain/c1_lesson_definitions.dart';
import '../../lessons/domain/c2_kelime_db.dart';
import '../../lessons/domain/c2_lesson_definitions.dart';
import '../../lessons/domain/lesson_entities.dart';
import '../data/content_override_service.dart';
import '../data/lesson_override_service.dart';

// ════════════════════════════════════════════════════════════════
// CONTENT EDITOR — DERS SEKMESİ
//
// Sahip kullanıcı:
//   1) Ders seç (seviye filtresi + liste)
//   2) Kart listesini sürükle-bırak yeniden sırala
//   3) Kart çıkar (×) veya ekle (+ Kart zêde bike)
//   4) Sakla → LessonOverride'a kaydedilir
//   5) "Vegere asîl" → override kaldırılır
// ════════════════════════════════════════════════════════════════

const _kLevels = <_LevelInfo>[
  _LevelInfo(1, 'A1', Color(0xFF4CAF50)),
  _LevelInfo(2, 'A2', Color(0xFF8BC34A)),
  _LevelInfo(3, 'B1', Color(0xFFFF9800)),
  _LevelInfo(4, 'B2', Color(0xFFFF5722)),
  _LevelInfo(5, 'C1', Color(0xFF9C27B0)),
  _LevelInfo(6, 'C2', Color(0xFF673AB7)),
];

class _LevelInfo {
  final int num;
  final String name;
  final Color color;
  const _LevelInfo(this.num, this.name, this.color);
}

List<LessonModel> _lessonsForLevel(int n) => switch (n) {
      1 => kA1Lessons,
      2 => kA2Lessons,
      3 => kB1Lessons,
      4 => kB2Lessons,
      5 => kC1Lessons,
      6 => kC2Lessons,
      _ => kA1Lessons,
    };

List<dynamic> _wordsForLevel(int n) => switch (n) {
      1 => kA1TamListe,
      2 => kA2TamListe,
      3 => kB1All,
      4 => kB2All,
      5 => kC1All,
      6 => kC2All,
      _ => kA1TamListe,
    };

class ContentLessonsTab extends ConsumerStatefulWidget {
  const ContentLessonsTab({super.key});

  @override
  ConsumerState<ContentLessonsTab> createState() => _ContentLessonsTabState();
}

class _ContentLessonsTabState extends ConsumerState<ContentLessonsTab> {
  int _level = 1;

  @override
  Widget build(BuildContext context) {
    final lessons = _lessonsForLevel(_level);
    final overrides = ref.watch(lessonOverridesProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Column(
        children: [
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              children: _kLevels
                  .map((l) => _FilterChip(
                        label: l.name,
                        selected: _level == l.num,
                        color: l.color,
                        onTap: () => setState(() => _level = l.num),
                      ))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: 6),
            child: Row(
              children: [
                Text('${lessons.length} wane',
                    style: AppTypography.caption),
                if (overrides.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${overrides.length} overrides',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: lessons.length,
              itemBuilder: (context, i) {
                final l = lessons[i];
                final hasOverride = overrides.containsKey(l.id);
                return InkWell(
                  onTap: () => _openLessonEditor(l),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: hasOverride
                          ? AppColors.accent.withOpacity(0.08)
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: hasOverride
                            ? AppColors.accent.withOpacity(0.5)
                            : AppColors.border,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            l.id,
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
                                l.kurmanjTitle,
                                style: AppTypography.labelMedium.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '${l.turkishTitle} · ${l.targetCardIds.length} kart',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (hasOverride)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            margin: const EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Override',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                        Icon(Icons.chevron_right,
                            size: 18, color: AppColors.textSecondary),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openLessonEditor(LessonModel lesson) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _LessonEditorScreen(
          lesson: lesson,
          levelNum: _level,
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
// LESSON EDITOR SCREEN — tek ders için reorder + add/remove
// ════════════════════════════════════════════════════════════════

class _LessonEditorScreen extends ConsumerStatefulWidget {
  final LessonModel lesson;
  final int levelNum;
  const _LessonEditorScreen({
    required this.lesson,
    required this.levelNum,
  });

  @override
  ConsumerState<_LessonEditorScreen> createState() =>
      _LessonEditorScreenState();
}

class _LessonEditorScreenState
    extends ConsumerState<_LessonEditorScreen> {
  late List<String> _cardIds;

  @override
  void initState() {
    super.initState();
    final override = ref.read(lessonOverridesProvider)[widget.lesson.id];
    _cardIds = List<String>.from(
        override?.targetCardIds ?? widget.lesson.targetCardIds);
  }

  dynamic _lookupWord(String id) {
    final pool = _wordsForLevel(widget.levelNum);
    for (final w in pool) {
      if (w.id == id) return w;
    }
    // Custom kelimeler de aranabilir
    final customs = ref.read(customWordsProvider);
    if (customs.containsKey(id)) {
      return customs[id];
    }
    return null;
  }

  Future<void> _saveOverride() async {
    // Orijinal ile eşitse override kaldır.
    final original = widget.lesson.targetCardIds;
    final same = original.length == _cardIds.length &&
        List<int>.generate(original.length, (i) => i)
            .every((i) => original[i] == _cardIds[i]);
    final notifier = ref.read(lessonOverridesProvider.notifier);
    if (same) {
      await notifier.removeOverride(widget.lesson.id);
    } else {
      await notifier.setOverride(
        widget.lesson.id,
        LessonOverride(targetCardIds: List<String>.from(_cardIds)),
      );
    }
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(same ? 'Vegeriya rewşa resen' : 'Hat tomarkirin'),
        backgroundColor:
            same ? AppColors.textSecondary : AppColors.success,
      ),
    );
  }

  Future<void> _resetOverride() async {
    await ref
        .read(lessonOverridesProvider.notifier)
        .removeOverride(widget.lesson.id);
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Vegeriya rewşa resen'),
        backgroundColor: AppColors.textSecondary,
      ),
    );
  }

  Future<void> _addCard() async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _CardPickerSheet(
        levelNum: widget.levelNum,
        excludeIds: _cardIds.toSet(),
      ),
    );
    if (picked != null) {
      setState(() => _cardIds.add(picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasOverride = ref
        .watch(lessonOverridesProvider)
        .containsKey(widget.lesson.id);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
        title: Text(widget.lesson.kurmanjTitle,
            style: AppTypography.headingSmall.copyWith(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Kart zêde bike',
            onPressed: _addCard,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: 8),
            child: Row(
              children: [
                Text('${_cardIds.length} kart',
                    style: AppTypography.caption),
                const Spacer(),
                if (hasOverride)
                  TextButton.icon(
                    onPressed: _resetOverride,
                    icon: Icon(Icons.restart_alt_rounded,
                        size: 16, color: AppColors.errorSoft),
                    label: Text('Vegere rewşa resen',
                        style: TextStyle(
                            color: AppColors.errorSoft, fontSize: 12)),
                  ),
              ],
            ),
          ),
          Expanded(
            child: _cardIds.isEmpty
                ? Center(
                    child: Text(
                      'Kart tune ne. "+ Zêde bike" bitikîne.',
                      style: AppTypography.bodyMedium
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  )
                : ReorderableListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: _cardIds.length,
                    onReorder: (oldIdx, newIdx) {
                      setState(() {
                        if (newIdx > oldIdx) newIdx -= 1;
                        final item = _cardIds.removeAt(oldIdx);
                        _cardIds.insert(newIdx, item);
                      });
                    },
                    itemBuilder: (context, i) {
                      final id = _cardIds[i];
                      final w = _lookupWord(id);
                      final ku = (w is CustomWord)
                          ? w.ku
                          : (w?.ku as String?) ?? '(missing)';
                      final tr = (w is CustomWord)
                          ? w.tr
                          : (w?.tr as String?) ?? '';
                      final missing = w == null;
                      return Container(
                        key: ValueKey('$id-$i'),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: missing
                              ? AppColors.errorSoft.withOpacity(0.08)
                              : AppColors.surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: missing
                                ? AppColors.errorSoft.withOpacity(0.4)
                                : AppColors.border,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.drag_handle,
                                color: AppColors.textSecondary),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
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
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    missing ? '(nayê dîtin)' : ku,
                                    style: AppTypography.labelMedium.copyWith(
                                      color: missing
                                          ? AppColors.errorSoft
                                          : AppColors.textPrimary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  if (tr.isNotEmpty)
                                    Text(
                                      tr,
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close,
                                  size: 18, color: AppColors.errorSoft),
                              onPressed: () {
                                setState(() => _cardIds.removeAt(i));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: ElevatedButton.icon(
                onPressed: _saveOverride,
                icon: const Icon(Icons.save_rounded),
                label: const Text('Tomar bike'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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
// CARD PICKER SHEET — search existing words to add
// ════════════════════════════════════════════════════════════════

class _CardPickerSheet extends ConsumerStatefulWidget {
  final int levelNum;
  final Set<String> excludeIds;
  const _CardPickerSheet({
    required this.levelNum,
    required this.excludeIds,
  });

  @override
  ConsumerState<_CardPickerSheet> createState() =>
      _CardPickerSheetState();
}

class _CardPickerSheetState extends ConsumerState<_CardPickerSheet> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pool = <dynamic>[
      ..._wordsForLevel(widget.levelNum),
      ...ref.read(customWordsProvider).values,
    ];
    // Silinenleri ve excluded id'leri çıkar
    final deleted = ref.read(deletedWordIdsProvider);
    final filtered = pool.where((w) {
      final id = (w is CustomWord) ? w.id : w.id as String;
      if (deleted.contains(id)) return false;
      if (widget.excludeIds.contains(id)) return false;
      if (_q.isEmpty) return true;
      final q = _q.toLowerCase();
      final ku = ((w is CustomWord) ? w.ku : w.ku as String).toLowerCase();
      final tr = ((w is CustomWord) ? w.tr : w.tr as String).toLowerCase();
      return ku.contains(q) || tr.contains(q);
    }).toList();

    return DraggableScrollableSheet(
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
                    child: Text('Kartekê hilbijêre',
                        style: AppTypography.headingSmall.copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w800,
                        )),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: 4),
              child: TextField(
                controller: _ctrl,
                onChanged: (v) => setState(() => _q = v.trim()),
                decoration: InputDecoration(
                  hintText: 'Lê bigere...',
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
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: filtered.length,
                itemBuilder: (context, i) {
                  final w = filtered[i];
                  final id = (w is CustomWord) ? w.id : w.id as String;
                  final ku = (w is CustomWord) ? w.ku : w.ku as String;
                  final tr = (w is CustomWord) ? w.tr : w.tr as String;
                  final isCustom = isCustomWordId(id);
                  return ListTile(
                    dense: true,
                    title: Text(ku,
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        )),
                    subtitle: Text(tr, style: AppTypography.caption),
                    leading: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
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
                    trailing: isCustom
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Custom',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: AppColors.success,
                              ),
                            ),
                          )
                        : null,
                    onTap: () => Navigator.of(context).pop(id),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
