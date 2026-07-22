import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../data/custom_quiz_service.dart';

// ════════════════════════════════════════════════════════════════
// CONTENT EDITOR — CUSTOM QUIZ SEKMESİ
//
// Sahip kullanıcı:
//   - Kendi çoktan seçmeli sorularını ekler (Kurmancî soru + 4 seçenek +
//     correctIndex + TR açıklama + kategori)
//   - Sorular SharedPreferences'a yazılır
//   - MVP: yalnızca oluştur/listele/sil — düzenleme sonra eklenebilir
// ════════════════════════════════════════════════════════════════

const _kCats = <String>[
  'custom',
  'selamlama',
  'malbat',
  'xwarin',
  'jimar',
  'reng',
  'jiyan',
  'beden',
  'xweza',
  'dem',
  'kar',
  'cih',
  'mal',
  'perwerde',
  'tenduristî',
  'bazirganî',
  'huner',
  'siyaset',
  'zanist',
];

class ContentQuizTab extends ConsumerStatefulWidget {
  const ContentQuizTab({super.key});

  @override
  ConsumerState<ContentQuizTab> createState() => _ContentQuizTabState();
}

class _ContentQuizTabState extends ConsumerState<ContentQuizTab> {
  @override
  Widget build(BuildContext context) {
    final qs = ref.watch(customQuizQuestionsProvider);
    final list = qs.values.toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: 8),
            child: Row(
              children: [
                Text('${list.length} pirs',
                    style: AppTypography.caption),
                const Spacer(),
                if (list.isNotEmpty)
                  TextButton.icon(
                    onPressed: _confirmClearAll,
                    icon: Icon(Icons.delete_sweep_rounded,
                        size: 16, color: AppColors.errorSoft),
                    label: Text('Hemû jê bibe',
                        style: TextStyle(
                            color: AppColors.errorSoft, fontSize: 12)),
                  ),
              ],
            ),
          ),
          Expanded(
            child: list.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.quiz_outlined,
                              size: 48, color: AppColors.textTertiary),
                          const SizedBox(height: 8),
                          Text(
                            'Hê pirsek tune.\n"+" bitikîne û pirsa xwe zêde bike.',
                            textAlign: TextAlign.center,
                            style: AppTypography.bodyMedium
                                .copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      final q = list[i];
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () => _openEditDialog(q),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.primary.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        q.kat,
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
                                      child: Text(
                                        q.questionKu,
                                        style: AppTypography.labelMedium
                                            .copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      tooltip: 'Edît bike',
                                      visualDensity: VisualDensity.compact,
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                          minWidth: 32, minHeight: 32),
                                      icon: Icon(Icons.edit_outlined,
                                          size: 18, color: AppColors.primary),
                                      onPressed: () => _openEditDialog(q),
                                    ),
                                    IconButton(
                                      tooltip: 'Jê bibe',
                                      visualDensity: VisualDensity.compact,
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                          minWidth: 32, minHeight: 32),
                                      icon: Icon(Icons.delete_outline,
                                          size: 18, color: AppColors.errorSoft),
                                      onPressed: () => _confirmDelete(q.id,
                                          q.questionKu),
                                    ),
                                  ],
                                ),
                            const SizedBox(height: 6),
                            for (int j = 0; j < q.options.length; j++)
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Row(
                                  children: [
                                    Icon(
                                      j == q.correctIndex
                                          ? Icons.check_circle
                                          : Icons.radio_button_unchecked,
                                      size: 14,
                                      color: j == q.correctIndex
                                          ? AppColors.success
                                          : AppColors.textTertiary,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(q.options[j],
                                          style: AppTypography.caption
                                              .copyWith(
                                            color: j == q.correctIndex
                                                ? AppColors.success
                                                : AppColors.textSecondary,
                                            fontWeight: j == q.correctIndex
                                                ? FontWeight.w700
                                                : FontWeight.w400,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            if (q.explanationTr.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Text(
                                q.explanationTr,
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textTertiary,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddDialog,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text('Pirsa nû',
            style: AppTypography.labelMedium
                .copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
      ),
    );
  }

  Future<void> _confirmDelete(String id, String preview) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Pirs were jêbirin?'),
        content: Text('"$preview" bi temamî tê jêbirin. Ev kar venagere.'),
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
    if (ok == true) {
      await ref.read(customQuizQuestionsProvider.notifier).removeQuestion(id);
    }
  }

  Future<void> _confirmClearAll() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hemû pirs werin jêbirin?'),
        content: const Text('Ev kar venagere.'),
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
    if (ok == true) {
      await ref.read(customQuizQuestionsProvider.notifier).clearAll();
    }
  }

  Future<void> _openAddDialog() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const _AddQuizSheet(),
    );
  }

  Future<void> _openEditDialog(CustomQuizQuestion q) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _AddQuizSheet(existing: q),
    );
  }
}

class _AddQuizSheet extends ConsumerStatefulWidget {
  /// existing != null ise edit modu — alanlar prefilled.
  final CustomQuizQuestion? existing;
  const _AddQuizSheet({this.existing});

  @override
  ConsumerState<_AddQuizSheet> createState() => _AddQuizSheetState();
}

class _AddQuizSheetState extends ConsumerState<_AddQuizSheet> {
  late final TextEditingController _qCtrl;
  late final TextEditingController _o1;
  late final TextEditingController _o2;
  late final TextEditingController _o3;
  late final TextEditingController _o4;
  late final TextEditingController _expl;
  late int _correctIndex;
  late String _kat;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _qCtrl = TextEditingController(text: e?.questionKu ?? '');
    final opts = e?.options ?? const ['', '', '', ''];
    _o1 = TextEditingController(
        text: opts.isNotEmpty ? opts[0] : '');
    _o2 = TextEditingController(
        text: opts.length > 1 ? opts[1] : '');
    _o3 = TextEditingController(
        text: opts.length > 2 ? opts[2] : '');
    _o4 = TextEditingController(
        text: opts.length > 3 ? opts[3] : '');
    _expl = TextEditingController(text: e?.explanationTr ?? '');
    _correctIndex = e?.correctIndex ?? 0;
    _kat = e?.kat ?? 'custom';
  }

  @override
  void dispose() {
    _qCtrl.dispose();
    _o1.dispose();
    _o2.dispose();
    _o3.dispose();
    _o4.dispose();
    _expl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final q = _qCtrl.text.trim();
    final opts = [
      _o1.text.trim(),
      _o2.text.trim(),
      _o3.text.trim(),
      _o4.text.trim(),
    ];
    if (q.isEmpty || opts.any((o) => o.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Divê hemû qad werin dagirtin'),
          backgroundColor: AppColors.errorSoft,
        ),
      );
      return;
    }
    setState(() => _submitting = true);
    // Edit modundaysa aynı id'yi koru — addQuestion upsert yapar.
    final question = CustomQuizQuestion(
      id: widget.existing?.id ?? CustomQuizQuestion.newId(),
      questionKu: q,
      options: opts,
      correctIndex: _correctIndex,
      explanationTr: _expl.text.trim(),
      kat: _kat,
    );
    await ref
        .read(customQuizQuestionsProvider.notifier)
        .addQuestion(question);
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.existing == null
            ? 'Pirs hat tomarkirin'
            : 'Pirs hat nûjenkirin'),
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
                          widget.existing == null
                              ? 'Pirsa nû'
                              : 'Edît bike',
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
              const Divider(height: 1),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    _Field(label: 'Pirs (Kurmancî) *', controller: _qCtrl),
                    const SizedBox(height: 12),
                    _OptionField(
                      label: 'Bijare 1',
                      controller: _o1,
                      isCorrect: _correctIndex == 0,
                      onSelect: () => setState(() => _correctIndex = 0),
                    ),
                    const SizedBox(height: 8),
                    _OptionField(
                      label: 'Bijare 2',
                      controller: _o2,
                      isCorrect: _correctIndex == 1,
                      onSelect: () => setState(() => _correctIndex = 1),
                    ),
                    const SizedBox(height: 8),
                    _OptionField(
                      label: 'Bijare 3',
                      controller: _o3,
                      isCorrect: _correctIndex == 2,
                      onSelect: () => setState(() => _correctIndex = 2),
                    ),
                    const SizedBox(height: 8),
                    _OptionField(
                      label: 'Bijare 4',
                      controller: _o4,
                      isCorrect: _correctIndex == 3,
                      onSelect: () => setState(() => _correctIndex = 3),
                    ),
                    const SizedBox(height: 12),
                    _Field(
                      label: 'Ravekirin (Tirkî)',
                      controller: _expl,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    Text('Kategorî',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textTertiary,
                          fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _kat,
                          isExpanded: true,
                          items: _kCats
                              .map((c) => DropdownMenuItem<String>(
                                    value: c,
                                    child: Text(c),
                                  ))
                              .toList(),
                          onChanged: (v) {
                            if (v != null) setState(() => _kat = v);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _submitting ? null : _submit,
                      icon: const Icon(Icons.check_rounded),
                      label: Text(_submitting ? 'Tê tomarkirin...' : 'Tomar bike'),
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

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;
  const _Field({
    required this.label,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textTertiary,
              fontWeight: FontWeight.w700,
            )),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: AppTypography.body,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.surface,
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.border),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ],
    );
  }
}

class _OptionField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isCorrect;
  final VoidCallback onSelect;
  const _OptionField({
    required this.label,
    required this.controller,
    required this.isCorrect,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          icon: Icon(
            isCorrect
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color:
                isCorrect ? AppColors.success : AppColors.textTertiary,
          ),
          onPressed: onSelect,
        ),
        Expanded(
          child: TextField(
            controller: controller,
            style: AppTypography.body,
            decoration: InputDecoration(
              labelText: label,
              filled: true,
              fillColor: AppColors.surface,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color:
                      isCorrect ? AppColors.success : AppColors.border,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 10),
            ),
          ),
        ),
      ],
    );
  }
}
