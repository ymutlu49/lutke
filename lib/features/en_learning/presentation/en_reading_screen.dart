import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/services/en_tts_helper.dart';
import '../domain/en_reading_db.dart';

/// İngilizce xwendin ekranı — CEFR seviyesine göre pasajlar.
class EnReadingScreen extends StatefulWidget {
  /// Öğrencinin düzeyi (ana ekrandan). Düzey seçicisi bu düzeyde açılır;
  /// eskiden hep A1'de açılıyordu. Öğrenci başka düzeye geçebilir.
  final String? level;
  const EnReadingScreen({super.key, this.level});
  @override
  State<EnReadingScreen> createState() => _EnReadingScreenState();
}

class _EnReadingScreenState extends State<EnReadingScreen> {
  static const Color _orange = Color(0xFFEF6C00);

  late String _selectedLevel = _baslangicDuzeyi(widget.level);

  /// Sınamalar için: seçili düzey.
  @visibleForTesting
  String get seciliDuzey => _selectedLevel;

  static String _baslangicDuzeyi(String? level) {
    final l = (level ?? '').toUpperCase();
    final var_ = kEnReadingPassages.any((p) => p.level == l);
    return var_ ? l : 'A1';
  }
  // Tüm pasajlar için paylaşılan okuma font ölçeği — a11y için.
  double _fontScale = 1.0;

  @override
  void dispose() {
    // Ekrandan çıkışta aktif İngilizce TTS iptal edilmeli
    EnTtsHelper.cancel();
    super.dispose();
  }

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
          tooltip: 'Vegere',
          onPressed: () {
            EnTtsHelper.cancel();
            context.canPop() ? context.pop() : context.go(AppRoutes.enHome);
          },
        ),
        title: Row(
          children: [
            // A11Y: decorative emoji.
            ExcludeSemantics(
              child: const Text('📖', style: TextStyle(fontSize: 22)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Semantics(
                header: true,
                child: Text(
                  'Xwendin',
                  style: AppTypography.headingSmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        actions: [
          // Font ölçeği — a11y, disleksi dostu
          PopupMenuButton<double>(
            tooltip: 'Mezinahiya nivîsê',
            icon: const Icon(
              Icons.format_size_rounded,
              color: _orange,
            ),
            onSelected: (v) => setState(() => _fontScale = v),
            itemBuilder: (context) => [
              _fontMenuItem('Biçûk', 0.9),
              _fontMenuItem('Asayî', 1.0),
              _fontMenuItem('Mezin', 1.15),
              _fontMenuItem('Gelek mezin', 1.3),
            ],
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              children: [
                // Seviye seçici — yatay kaydırılabilir, a11y
                SizedBox(
                  height: 52,
                  child: Semantics(
                    label: 'Astê hilbijêre',
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          for (final lvl in ['A1', 'A2', 'B1', 'B2'])
                            _levelChip(lvl),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: filtered.isEmpty
                      ? _emptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          itemCount: filtered.length,
                          itemBuilder: (_, i) => _PassageCard(
                            passage: filtered[i],
                            fontScale: _fontScale,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<double> _fontMenuItem(String label, double value) {
    return PopupMenuItem<double>(
      value: value,
      child: Row(
        children: [
          Icon(
            (_fontScale - value).abs() < 0.01
                ? Icons.check_rounded
                : null,
            size: 16,
            color: _orange,
          ),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }

  Widget _levelChip(String lvl) {
    final isSelected = _selectedLevel == lvl;
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    // A11Y: GestureDetector → Material+InkWell for keyboard focus.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Semantics(
        button: true,
        selected: isSelected,
        label: 'Asta $lvl',
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () => setState(() => _selectedLevel = lvl),
            borderRadius: BorderRadius.circular(10),
            focusColor: _orange.withValues(alpha: 0.3),
            child: AnimatedContainer(
              duration:
                  reduceMotion ? Duration.zero : const Duration(milliseconds: 200),
              // A11Y: raised 40 → 48 (WCAG 2.5.5 target size).
              constraints: const BoxConstraints(minWidth: 64, minHeight: 48),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? _orange : _orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                // A11Y: thick border on selected — non-color cue.
                border: Border.all(
                  color: isSelected ? _orange : _orange.withValues(alpha: 0.3),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Text(
                lvl,
                style: TextStyle(
                  color: isSelected ? Colors.white : _orange,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('📖', style: TextStyle(fontSize: 64)),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Asta $_selectedLevel — di demek nêzîk de tê zêdekirin',
              style: AppTypography.body.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Tu dikarî astek din hilbijêrî.',
              style: AppTypography.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _PassageCard extends StatefulWidget {
  final EnReadingPassage passage;
  final double fontScale;
  const _PassageCard({
    required this.passage,
    required this.fontScale,
  });
  @override
  State<_PassageCard> createState() => _PassageCardState();
}

class _PassageCardState extends State<_PassageCard> {
  static const Color _orange = Color(0xFFEF6C00);
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
          Semantics(
            button: true,
            expanded: _expanded,
            label:
                '${p.titleKu}. ${p.titleEn}. ${_expanded ? 'Girtî bike' : 'Veke'}',
            child: InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    // A11Y: decorative emoji — parent Semantics has label.
                    ExcludeSemantics(
                      child: Text(
                        p.emoji,
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Kurmancî başlık önce ve daha güçlü (LÛTKE tipografi)
                          Text(
                            p.titleKu,
                            style: AppTypography.bodyLarge.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            p.titleEn,
                            style: AppTypography.caption.copyWith(
                              color: _orange,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: _orange,
                      ),
                    ),
                  ],
                ),
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
                  // Pasaj + dinleme butonu
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _orange.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _orange.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // A11Y dyslexia: ≥16sp body (WCAG 1.4.4 resize),
                        // line-height 1.7 (≥1.5x required),
                        // letterSpacing 0.3 (Zorzi 2012 +20% reading speed),
                        // wordSpacing for clearer word boundaries,
                        // left-aligned (no "rivers of white"),
                        // Semantics textDirection helps readers.
                        Text(
                          p.passage,
                          textAlign: TextAlign.left,
                          style: AppTypography.body.copyWith(
                            height: 1.8,
                            fontSize: 16 * widget.fontScale,
                            color: AppColors.textPrimary,
                            letterSpacing: 0.3,
                            wordSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            // Pasajı dinle
                            Semantics(
                              button: true,
                              label: 'Pasajê bibihîze',
                              child: InkWell(
                                onTap: () => EnTtsHelper.speak(
                                  p.passage,
                                  rate: 0.85,
                                ),
                                borderRadius: BorderRadius.circular(999),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _orange,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.volume_up_rounded,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Bibihîze',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Durdur
                            Semantics(
                              button: true,
                              label: 'Dengbêjê rawestîne',
                              child: InkWell(
                                onTap: () {
                                  EnTtsHelper.cancel();
                                  HapticFeedback.selectionClick();
                                },
                                borderRadius: BorderRadius.circular(999),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: AppColors.backgroundSecondary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.borderLight,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.stop_rounded,
                                    size: 14,
                                    color: AppColors.textTertiary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Semantics(
                    button: true,
                    label: _showTranslation
                        ? 'Wergera Kurmancî veşêre'
                        : 'Wergera Kurmancî nîşan bide',
                    child: InkWell(
                      onTap: () => setState(
                        () => _showTranslation = !_showTranslation,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 4,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _showTranslation
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _showTranslation
                                  ? 'Wergerê veşêre'
                                  : 'Werger nîşan bide (Kurmancî)',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (_showTranslation) ...[
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.15),
                        ),
                      ),
                      // A11Y dyslexia: removed italics (BDA 2023). Use
                      // weight/color to distinguish translation from source.
                      child: Text(
                        p.translationKu,
                        style: AppTypography.bodySmall.copyWith(
                          height: 1.7,
                          fontSize: 13 * widget.fontScale,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Icon(
                        Icons.help_outline_rounded,
                        size: 16,
                        color: _orange,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Pirsên famkirinê',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  for (int qi = 0; qi < p.questions.length; qi++)
                    _QuestionWidget(
                      q: p.questions[qi],
                      index: qi + 1,
                      fontScale: widget.fontScale,
                    ),
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
  final double fontScale;
  const _QuestionWidget({
    required this.q,
    required this.index,
    required this.fontScale,
  });
  @override
  State<_QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<_QuestionWidget> {
  String? _selected;
  bool _answered = false;

  void _select(String opt) {
    setState(() {
      _selected = opt;
      _answered = true;
    });
    HapticFeedback.selectionClick();
  }

  void _reset() {
    setState(() {
      _selected = null;
      _answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.q;
    final isCorrect = _selected == q.correctAnswer;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.index}. ${q.questionEn}',
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13 * widget.fontScale,
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          for (final opt in q.options)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Semantics(
                button: true,
                selected: _selected == opt,
                label: 'Bersiv: $opt',
                child: InkWell(
                  onTap: _answered ? null : () => _select(opt),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 40),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _answered
                          ? (opt == q.correctAnswer
                              ? AppColors.success.withValues(alpha: 0.12)
                              : _selected == opt
                                  ? AppColors.errorSoft
                                      .withValues(alpha: 0.12)
                                  : Colors.white)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _answered
                            ? (opt == q.correctAnswer
                                ? AppColors.success
                                : _selected == opt
                                    ? AppColors.errorSoft
                                    : AppColors.borderLight)
                            : AppColors.borderLight,
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      children: [
                        if (_answered && opt == q.correctAnswer)
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 16,
                            color: AppColors.success,
                          )
                        else if (_answered && _selected == opt)
                          const Icon(
                            Icons.cancel_rounded,
                            size: 16,
                            color: AppColors.errorSoft,
                          )
                        else
                          const SizedBox(width: 16),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            opt,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textPrimary,
                              fontSize: 12 * widget.fontScale,
                              height: 1.5,
                              fontWeight: _answered && opt == q.correctAnswer
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          if (_answered)
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isCorrect
                    ? AppColors.success.withValues(alpha: 0.08)
                    : const Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isCorrect
                      ? AppColors.success.withValues(alpha: 0.3)
                      : const Color(0xFFFFE082),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isCorrect ? '✅' : '💡',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          isCorrect
                              ? 'Aferîn! Rast e.'
                              : 'Bersiva rast: ${q.correctAnswer}',
                          style: AppTypography.caption.copyWith(
                            color: isCorrect
                                ? AppColors.success
                                : const Color(0xFF7B5E00),
                            fontWeight: FontWeight.w800,
                            fontSize: 12 * widget.fontScale,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      q.explanationKu,
                      style: AppTypography.caption.copyWith(
                        color: isCorrect
                            ? AppColors.textSecondary
                            : const Color(0xFF7B5E00),
                        height: 1.5,
                        fontSize: 12 * widget.fontScale,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Dîsa biceribîne — bir daha cevaplamasına izin ver
                  if (!isCorrect)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: _reset,
                        icon: const Icon(
                          Icons.refresh_rounded,
                          size: 14,
                        ),
                        label: const Text('Dîsa biceribîne'),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF7B5E00),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          textStyle: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
