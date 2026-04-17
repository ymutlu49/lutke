import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../domain/en_reading_db.dart';

class EnReadingScreen extends StatefulWidget {
  const EnReadingScreen({super.key});
  @override
  State<EnReadingScreen> createState() => _EnReadingScreenState();
}

class _EnReadingScreenState extends State<EnReadingScreen> {
  String _selectedLevel = 'A1';

  @override
  Widget build(BuildContext context) {
    final filtered = kEnReadingPassages
        .where((p) => p.level == _selectedLevel)
        .toList();
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            const Text('📖', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text('Xwendin',
                style: AppTypography.headingSmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                )),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              children: [
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      for (final lvl in ['A1', 'A2', 'B1', 'B2'])
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _selectedLevel = lvl),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: _selectedLevel == lvl
                                    ? const Color(0xFFEF6C00)
                                    : const Color(0xFFEF6C00)
                                        .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(lvl,
                                  style: TextStyle(
                                    color: _selectedLevel == lvl
                                        ? Colors.white
                                        : const Color(0xFFEF6C00),
                                    fontWeight: FontWeight.w800,
                                  )),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: filtered.isEmpty
                      ? const Center(
                          child: Text('Hîna tê amade kirin'))
                      : ListView.builder(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          itemCount: filtered.length,
                          itemBuilder: (_, i) =>
                              _PassageCard(passage: filtered[i]),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PassageCard extends StatefulWidget {
  final EnReadingPassage passage;
  const _PassageCard({required this.passage});
  @override
  State<_PassageCard> createState() => _PassageCardState();
}

class _PassageCardState extends State<_PassageCard> {
  bool _expanded = false;
  bool _showTranslation = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.passage;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Text(p.emoji, style: const TextStyle(fontSize: 32)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.titleEn,
                            style: AppTypography.bodyLarge.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            )),
                        Text(p.titleKu,
                            style: AppTypography.caption.copyWith(
                              color: const Color(0xFFEF6C00),
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: const Color(0xFFEF6C00),
                  ),
                ],
              ),
            ),
          ),
          if (_expanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF6C00).withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(p.passage,
                        style: AppTypography.body.copyWith(
                          height: 1.6,
                          color: AppColors.textPrimary,
                        )),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => setState(
                        () => _showTranslation = !_showTranslation),
                    child: Row(
                      children: [
                        Icon(
                          _showTranslation
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _showTranslation
                              ? 'Kurmancî veşêre'
                              : 'Kurmancî nîşan bide',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_showTranslation) ...[
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            AppColors.primary.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(p.translationKu,
                          style: AppTypography.bodySmall.copyWith(
                            height: 1.5,
                            color: AppColors.textPrimary,
                            fontStyle: FontStyle.italic,
                          )),
                    ),
                  ],
                  const SizedBox(height: 12),
                  Text('Pirsên famkirinê:',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      )),
                  const SizedBox(height: 8),
                  for (int qi = 0; qi < p.questions.length; qi++)
                    _QuestionWidget(q: p.questions[qi], index: qi + 1),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _QuestionWidget extends StatefulWidget {
  final EnReadingQuestion q;
  final int index;
  const _QuestionWidget({required this.q, required this.index});
  @override
  State<_QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<_QuestionWidget> {
  String? _selected;
  bool _answered = false;

  @override
  Widget build(BuildContext context) {
    final q = widget.q;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${widget.index}. ${q.questionEn}',
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              )),
          const SizedBox(height: 6),
          for (final opt in q.options)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: InkWell(
                onTap: _answered
                    ? null
                    : () => setState(() {
                          _selected = opt;
                          _answered = true;
                        }),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _answered
                        ? (opt == q.correctAnswer
                            ? Colors.green.withValues(alpha: 0.12)
                            : _selected == opt
                                ? Colors.red.withValues(alpha: 0.12)
                                : Colors.white)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _answered
                          ? (opt == q.correctAnswer
                              ? Colors.green
                              : _selected == opt
                                  ? Colors.red
                                  : AppColors.borderLight)
                          : AppColors.borderLight,
                    ),
                  ),
                  child: Row(
                    children: [
                      if (_answered && opt == q.correctAnswer)
                        const Icon(Icons.check_circle,
                            size: 16, color: Colors.green)
                      else if (_answered && _selected == opt)
                        const Icon(Icons.cancel,
                            size: 16, color: Colors.red)
                      else
                        const SizedBox(width: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(opt,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textPrimary,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (_answered)
            Container(
              margin: const EdgeInsets.only(top: 6),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('💡'),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(q.explanationKu,
                        style: AppTypography.caption.copyWith(
                          color: const Color(0xFF7B5E00),
                        )),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
