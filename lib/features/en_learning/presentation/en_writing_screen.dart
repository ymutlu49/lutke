import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/accessibility_settings.dart';
import '../../../shared/services/skill_progress_service.dart';
import '../domain/en_writing_db.dart';
import '../../exercises/domain/level_pick.dart';

class EnWritingScreen extends ConsumerStatefulWidget {
  /// Öğrencinin düzeyi (ana ekrandan). Sorular bu düzeyden seçilir; o düzeyde
  /// yetmezse önce alt, sonra üst düzeylerle tamamlanır (Kurmancî beceri
  /// ekranlarıyla aynı kural, `pickForLevel`). Eskiden bütün düzeylerden
  /// rastgele 10 soru çekiliyordu: A1 öğrencisine C2 sorusu düşebiliyordu.
  final String? level;
  const EnWritingScreen({super.key, this.level});
  @override
  ConsumerState<EnWritingScreen> createState() => _EnWritingScreenState();
}

class _EnWritingScreenState extends ConsumerState<EnWritingScreen> {
  late List<EnWritingExercise> _items;
  int _idx = 0;
  final _ctrl = TextEditingController();
  bool _checked = false;
  bool? _correct;
  int _score = 0;
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    _items = pickForLevel(kEnWritingExercises, widget.level, (e) => e.level);
    _ctrl.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _ctrl.removeListener(_onTextChanged);
    _ctrl.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final len = _ctrl.text.length;
    if (len != _charCount) {
      setState(() => _charCount = len);
    }
  }

  void _check() {
    if (_ctrl.text.trim().isEmpty) return;
    final q = _items[_idx];
    final user = _ctrl.text.trim().toLowerCase();
    final correct = q.correctAnswer.trim().toLowerCase();
    final match = user == correct || _fuzzyMatch(user, correct);
    setState(() {
      _checked = true;
      _correct = match;
      if (match) {
        _score += 10;
        markSkillCompletedAndNotify(ref, module: 'en', skill: 'writing');
      }
    });
  }

  bool _fuzzyMatch(String a, String b) {
    // Apostrof normalize bike; ? ! . virgûl xwe xwe veguherîne.
    String norm(String s) => s
        .replaceAll(RegExp(r"[.,!?']"), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    return norm(a) == norm(b);
  }

  void _next() {
    if (_idx + 1 >= _items.length) {
      _showResult();
      return;
    }
    setState(() {
      _idx++;
      _ctrl.clear();
      _charCount = 0;
      _checked = false;
      _correct = null;
    });
  }

  void _showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Row(children: [
          const Text('🎉', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 8),
          Text('Pîroz be!',
              style: AppTypography.title
                  .copyWith(fontWeight: FontWeight.w800)),
        ]),
        content: Text(
          'Te bi $_score XP ${_items.length} temrîn qedand. Nivîsîn di mêjiyê te de kok berdide.',
          style: AppTypography.body,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.pop();
            },
            child: const Text('Derkeve'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final a11y = ref.watch(accessibilitySettingsProvider);
    if (_items.isEmpty) {
      return Scaffold(
        backgroundColor:
            a11y.background.color ?? AppColors.backgroundPrimary,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text('📚', style: TextStyle(fontSize: 48)),
              const SizedBox(height: AppSpacing.md),
              Text('Tu temrîn amade nîne',
                  style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary),
                  textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.md),
              ElevatedButton(
                onPressed: () => context.canPop()
                    ? context.pop()
                    : context.go(AppRoutes.enHome),
                child: const Text('Vegere'),
              ),
            ]),
          ),
        ),
      );
    }
    final q = _items[_idx];
    return Scaffold(
      backgroundColor: a11y.background.color ?? AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor:
            a11y.background.color ?? AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          tooltip: 'Derkeve',
          onPressed: () => context.canPop()
              ? context.pop()
              : context.go(AppRoutes.enHome),
        ),
        title: Row(
          children: [
            // A11Y: decorative emoji.
            ExcludeSemantics(
              child: const Text('✍️', style: TextStyle(fontSize: 22)),
            ),
            const SizedBox(width: 8),
            Semantics(
              header: true,
              child: Text('Nivîsîn',
                  style: AppTypography.headingSmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800)),
            ),
            const Spacer(),
            Semantics(
              label: 'Pirsa ${_idx + 1} ji ${_items.length}',
              child: Text('${_idx + 1}/${_items.length}',
                  style: AppTypography.caption),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color:
                            const Color(0xFF7B1FA2).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('${q.level} · ${q.type}',
                          style: const TextStyle(
                              color: Color(0xFF7B1FA2),
                              fontWeight: FontWeight.w800,
                              fontSize: 11)),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Text(q.promptKu,
                          style: a11y.applyFont(
                            AppTypography.bodyLarge.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                                height: 1.5),
                          )),
                    ),
                    if (q.words != null) ...[
                      const SizedBox(height: 12),
                      Text('Peyvên alîkar:',
                          style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Wrap(spacing: 6, runSpacing: 6, children: [
                        for (final w in q.words!)
                          Semantics(
                            label: 'Peyva alîkar: $w',
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF7B1FA2)
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: const Color(0xFF7B1FA2)
                                        .withValues(alpha: 0.3)),
                              ),
                              child: Text(w,
                                  style: const TextStyle(
                                      color: Color(0xFF7B1FA2),
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                      ]),
                    ],
                    const SizedBox(height: 16),
                    // A11Y: labelText so screen readers announce the field
                    // as "Peyv" (not just "edit field"). hintText alone is
                    // not a label. autofocus disabled — startling for
                    // dyslexic learners; only focus after user intent.
                    TextField(
                      controller: _ctrl,
                      enabled: !_checked,
                      autofocus: false,
                      maxLines: _writeLines(q.type),
                      minLines: _writeLines(q.type),
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _checked ? _next() : _check(),
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        labelText: 'Bersiva te',
                        hintText: 'Bi Îngilîzî binivîse…',
                        // A11Y: stable ≥48dp field even with 1 line.
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 14),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Color(0xFF7B1FA2), width: 2)),
                      ),
                      style: a11y.applyFont(AppTypography.bodyLarge),
                    ),
                    const SizedBox(height: 6),
                    Row(children: [
                      const Spacer(),
                      Text('$_charCount tîp',
                          style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary)),
                    ]),
                    if (_checked) ...[
                      const SizedBox(height: 12),
                      // A11Y: liveRegion announces correct/wrong + answer
                      // + explanation. Error is identified by icon + text
                      // prefix, not color alone (WCAG 3.3.1).
                      Semantics(
                      liveRegion: true,
                      label: _correct == true
                          ? 'Rast. Bersiva rast: ${q.correctAnswer}. ${q.explanationKu}'
                          : 'Çewt. Bersiva rast: ${q.correctAnswer}. ${q.explanationKu}',
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          // A11Y: semantic token colors; softer red via errorSoft.
                          color: _correct == true
                              ? AppColors.success.withValues(alpha: 0.12)
                              : AppColors.errorSoft.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _correct == true
                                ? AppColors.success.withValues(alpha: 0.3)
                                : AppColors.errorSoft.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Icon(
                                  _correct == true
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  color: _correct == true
                                      ? AppColors.success
                                      : AppColors.errorSoft),
                              const SizedBox(width: 8),
                              Text(_correct == true ? 'Rast!' : 'Çewt',
                                  style: TextStyle(
                                      color: _correct == true
                                          ? AppColors.success
                                          : AppColors.errorSoft,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16)),
                            ]),
                            const SizedBox(height: 8),
                            // Bersiva rast tenê piştî kontrolê tê nîşandan.
                            Text('Bersiva rast: ${q.correctAnswer}',
                                style: a11y.applyFont(
                                  AppTypography.bodySmall.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w700),
                                )),
                            const SizedBox(height: 4),
                            Text(q.explanationKu,
                                style: a11y.applyFont(
                                  AppTypography.caption.copyWith(
                                      color: AppColors.textSecondary,
                                      height: 1.4),
                                )),
                          ],
                        ),
                      ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.md),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _checked
                            ? _next
                            : (_charCount == 0 ? null : _check),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7B1FA2),
                            foregroundColor: Colors.white,
                            disabledBackgroundColor:
                                const Color(0xFF7B1FA2)
                                    .withValues(alpha: 0.35)),
                        child: Text(
                            _checked
                                ? (_idx + 1 >= _items.length
                                    ? 'Encamê bibîne'
                                    : 'Berdewam')
                                : 'Kontrol bike',
                            style: const TextStyle(
                                fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Dictation û fill_blank ji bo yek rêzikê; reorder/correct ji bo gelek
  /// rêzikan bi gelemperî dirêj in.
  int _writeLines(String type) {
    switch (type) {
      case 'reorder':
      case 'correct':
        return 3;
      default:
        return 1;
    }
  }
}
