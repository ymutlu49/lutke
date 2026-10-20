import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/en_tts_helper.dart';
import '../domain/en_listening_db.dart';
import '../../exercises/domain/level_pick.dart';

/// İngilizce guhdarîkirinê ekranı — TTS okur, kullanıcı yazar/seçer.
class EnListeningScreen extends StatefulWidget {
  /// Öğrencinin düzeyi (ana ekrandan). Sorular bu düzeyden seçilir; o düzeyde
  /// yetmezse önce alt, sonra üst düzeylerle tamamlanır (Kurmancî beceri
  /// ekranlarıyla aynı kural, `pickForLevel`). Eskiden bütün düzeylerden
  /// rastgele 10 soru çekiliyordu: A1 öğrencisine C2 sorusu düşebiliyordu.
  final String? level;
  const EnListeningScreen({super.key, this.level});
  @override
  State<EnListeningScreen> createState() => _EnListeningScreenState();
}

class _EnListeningScreenState extends State<EnListeningScreen> {
  static const Color _teal = Color(0xFF00838F);

  late List<EnListeningExercise> _items;
  int _idx = 0;
  String? _selected;
  bool _checked = false;
  final _ctrl = TextEditingController();
  final FocusNode _focus = FocusNode();
  int _score = 0;
  double _rate = 0.9; // TTS rate — slow=0.65, normal=0.9, fast=1.1
  int _playCount = 0; // Kullanıcı kaç kez dinledi

  @override
  void initState() {
    super.initState();
    _items = pickForLevel(kEnListeningExercises, widget.level, (e) => e.level);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    // TTS'i iptal et — başka ekrana çıkınca ses devam etmesin
    EnTtsHelper.cancel();
    super.dispose();
  }

  void _playAudio(String text) {
    EnTtsHelper.speak(text, rate: _rate);
    setState(() => _playCount++);
    HapticFeedback.selectionClick();
  }

  void _setRate(double r) {
    setState(() => _rate = r);
  }

  void _check() {
    final q = _items[_idx];
    bool correct;
    if (q.type == 'transcribe') {
      final a =
          _ctrl.text.trim().toLowerCase().replaceAll(RegExp(r'[.,!?]'), '');
      final b =
          q.correctAnswer.toLowerCase().replaceAll(RegExp(r'[.,!?]'), '');
      correct = a == b;
    } else {
      correct = _selected == q.correctAnswer;
    }
    setState(() {
      _checked = true;
      if (correct) _score += 10;
    });
    if (correct) {
      HapticFeedback.lightImpact();
    } else {
      HapticFeedback.selectionClick();
    }
  }

  void _next() {
    if (_idx + 1 >= _items.length) {
      showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          icon: const Icon(
            Icons.emoji_events_rounded,
            color: _teal,
            size: 44,
          ),
          title: const Text(
            'Pîroz be!',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          content: Text(
            'Te $_score XP qezenc kir.',
            textAlign: TextAlign.center,
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      setState(() {
                        _idx = 0;
                        _selected = null;
                        _checked = false;
                        _ctrl.clear();
                        _score = 0;
                        _playCount = 0;
                        _items = pickForLevel(
                            kEnListeningExercises, widget.level, (e) => e.level);
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _teal,
                      side: const BorderSide(color: _teal),
                    ),
                    child: const Text('Dîsa biceribîne'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      context.canPop()
                          ? context.pop()
                          : context.go(AppRoutes.enHome);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _teal,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Derkeve'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
      return;
    }
    setState(() {
      _idx++;
      _selected = null;
      _checked = false;
      _ctrl.clear();
      _playCount = 0;
    });
    EnTtsHelper.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final q = _items[_idx];
    final progress = (_idx + (_checked ? 1 : 0)) / _items.length;
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          tooltip: 'Derkeve',
          onPressed: () {
            EnTtsHelper.cancel();
            context.canPop() ? context.pop() : context.go(AppRoutes.enHome);
          },
        ),
        title: Row(
          children: [
            // A11Y: Emoji decorative — parent Row has Text label.
            ExcludeSemantics(
              child: const Text('👂', style: TextStyle(fontSize: 22)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Semantics(
                header: true,
                child: Text(
                  'Guhdarîkirin',
                  style: AppTypography.headingSmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // Skor badge — motivasyon
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.bolt_rounded,
                    size: 14,
                    color: AppColors.accent,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '$_score',
                    style: AppTypography.label.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 4,
            backgroundColor: _teal.withValues(alpha: 0.15),
            valueColor: const AlwaysStoppedAnimation<Color>(_teal),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _teal.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${q.level} · ${_typeLabel(q.type)}',
                          style: const TextStyle(
                            color: _teal,
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Pirs ${_idx + 1}/${_items.length}',
                        style: AppTypography.caption,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    q.promptKu,
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Play button — büyük dokunma hedefi + Semantics
                  Center(
                    child: Column(
                      children: [
                        Semantics(
                          button: true,
                          label: 'Dengê bibihîze',
                          child: InkWell(
                            onTap: () => _playAudio(q.audioText),
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: _teal,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: _teal.withValues(alpha: 0.3),
                                    blurRadius: 16,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.volume_up_rounded,
                                size: 48,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _playCount == 0
                              ? 'Guhdarî bike'
                              : 'Carek din guhdarî bike ($_playCount)',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Speed control — slow / normal / fast
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.speed_rounded,
                              size: 14,
                              color: AppColors.textTertiary,
                            ),
                            const SizedBox(width: 6),
                            _speedChip('Hêdî', 0.65),
                            const SizedBox(width: 4),
                            _speedChip('Asayî', 0.9),
                            const SizedBox(width: 4),
                            _speedChip('Zûtir', 1.1),
                            const SizedBox(width: 6),
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
                                    size: 16,
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
                  const SizedBox(height: 20),
                  // Answer area
                  if (q.type == 'transcribe')
                    TextField(
                      controller: _ctrl,
                      focusNode: _focus,
                      enabled: !_checked,
                      autocorrect: false,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) {
                        if (!_checked && _ctrl.text.trim().isNotEmpty) {
                          _check();
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Guhdarî bike û li jêr binivîse...',
                        hintStyle: AppTypography.body.copyWith(
                          color: AppColors.textTertiary,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.borderLight),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.borderLight),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: _teal, width: 2),
                        ),
                      ),
                    )
                  else if (q.options != null)
                    Column(
                      children: [
                        for (final opt in q.options!)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Semantics(
                              button: true,
                              selected: _selected == opt,
                              label: 'Bersiv: $opt',
                              child: InkWell(
                                onTap: _checked
                                    ? null
                                    : () => setState(() => _selected = opt),
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: double.infinity,
                                  constraints: const BoxConstraints(
                                    minHeight: 52,
                                  ),
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: _checked
                                        ? (opt == q.correctAnswer
                                            ? AppColors.success
                                                .withValues(alpha: 0.15)
                                            : _selected == opt
                                                ? AppColors.errorSoft
                                                    .withValues(alpha: 0.15)
                                                : Colors.white)
                                        : (_selected == opt
                                            ? _teal.withValues(alpha: 0.1)
                                            : Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: _checked
                                          ? (opt == q.correctAnswer
                                              ? AppColors.success
                                              : _selected == opt
                                                  ? AppColors.errorSoft
                                                  : AppColors.borderLight)
                                          : (_selected == opt
                                              ? _teal
                                              : AppColors.borderLight),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      if (_checked && opt == q.correctAnswer)
                                        const Padding(
                                          padding: EdgeInsets.only(right: 8),
                                          child: Icon(
                                            Icons.check_circle_rounded,
                                            size: 20,
                                            color: AppColors.success,
                                          ),
                                        )
                                      else if (_checked &&
                                          _selected == opt)
                                        const Padding(
                                          padding: EdgeInsets.only(right: 8),
                                          child: Icon(
                                            Icons.cancel_rounded,
                                            size: 20,
                                            color: AppColors.errorSoft,
                                          ),
                                        ),
                                      Expanded(
                                        child: Text(
                                          opt,
                                          style: AppTypography.body.copyWith(
                                            fontWeight: _selected == opt
                                                ? FontWeight.w700
                                                : FontWeight.w500,
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
                  if (_checked) ...[
                    const SizedBox(height: 12),
                    // A11Y: liveRegion announces feedback to screen readers
                    // immediately after "Kontrol bike". WCAG 4.1.3 Status
                    // Messages. Error identification not by color only
                    // (icon + text prefix "Bersiva rast:").
                    Semantics(
                      liveRegion: true,
                      child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _isCorrect(q)
                            ? AppColors.success.withValues(alpha: 0.08)
                            : const Color(0xFFFFF8E1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _isCorrect(q)
                              ? AppColors.success.withValues(alpha: 0.3)
                              : const Color(0xFFFFE082),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _isCorrect(q)
                                    ? Icons.check_circle_rounded
                                    : Icons.info_rounded,
                                size: 18,
                                color: _isCorrect(q)
                                    ? AppColors.success
                                    : const Color(0xFF7B5E00),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  _isCorrect(q)
                                      ? 'Aferîn! Rast e.'
                                      : 'Bersiva rast: ${q.correctAnswer}',
                                  style: AppTypography.bodySmall.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: _isCorrect(q)
                                        ? AppColors.success
                                        : const Color(0xFF7B5E00),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            q.explanationKu,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          // Tekrar dinle — açıklama okunduktan sonra sesi tekrar duy
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton.icon(
                              onPressed: () => _playAudio(q.audioText),
                              icon: const Icon(
                                Icons.replay_rounded,
                                size: 16,
                              ),
                              label: const Text('Careke din bibihîze'),
                              style: TextButton.styleFrom(
                                foregroundColor: _teal,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ),
                  ],
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: _checked
                          ? _next
                          : ((q.type == 'transcribe' &&
                                      _ctrl.text.trim().isEmpty) ||
                                  (q.type != 'transcribe' && _selected == null)
                              ? null
                              : _check),
                      icon: Icon(
                        _checked
                            ? Icons.arrow_forward_rounded
                            : Icons.check_rounded,
                        size: 20,
                      ),
                      label: Text(
                        _checked
                            ? (_idx + 1 >= _items.length
                                ? 'Bi dawî bike'
                                : 'Pêşde')
                            : 'Kontrol bike',
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _teal,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor:
                            _teal.withValues(alpha: 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isCorrect(EnListeningExercise q) {
    if (q.type == 'transcribe') {
      final a =
          _ctrl.text.trim().toLowerCase().replaceAll(RegExp(r'[.,!?]'), '');
      final b =
          q.correctAnswer.toLowerCase().replaceAll(RegExp(r'[.,!?]'), '');
      return a == b;
    }
    return _selected == q.correctAnswer;
  }

  Widget _speedChip(String label, double value) {
    final isSelected = (_rate - value).abs() < 0.01;
    // A11Y: GestureDetector → InkWell for keyboard activation.
    return Semantics(
      button: true,
      selected: isSelected,
      label: 'Lez: $label',
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          onTap: () => _setRate(value),
          borderRadius: BorderRadius.circular(999),
          focusColor: _teal.withValues(alpha: 0.3),
          child: Container(
            // A11Y: ≥32dp tall chip; button semantics still apply.
            constraints: const BoxConstraints(minHeight: 32, minWidth: 40),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? _teal.withValues(alpha: 0.15)
                  : AppColors.backgroundSecondary,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: isSelected ? _teal : AppColors.borderLight,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: isSelected ? _teal : AppColors.textTertiary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _typeLabel(String type) {
    switch (type) {
      case 'transcribe':
        return 'binivîse';
      case 'multiple_choice':
        return 'hilbijêre';
      case 'true_false':
        return 'rast an şaş';
      default:
        return type;
    }
  }
}
