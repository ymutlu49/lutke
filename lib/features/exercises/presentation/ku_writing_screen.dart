import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../shared/providers/language_mode_provider.dart';
import '../domain/ku_writing_db.dart';

class KuWritingScreen extends ConsumerStatefulWidget {
  const KuWritingScreen({super.key});
  @override
  ConsumerState<KuWritingScreen> createState() => _KuWritingScreenState();
}

class _KuWritingScreenState extends ConsumerState<KuWritingScreen> {
  late List<KuWritingExercise> _items;
  int _idx = 0;
  final _ctrl = TextEditingController();
  bool _checked = false;
  bool? _correct;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _items = List.from(kKuWritingExercises)..shuffle(Random());
    _items = _items.take(10).toList();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  String _normalize(String s) => s
      .toLowerCase()
      .replaceAll(RegExp(r"[.,!?']"), '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  void _check() {
    final q = _items[_idx];
    final user = _normalize(_ctrl.text);
    final correct = _normalize(q.correctAnswer);
    setState(() {
      _checked = true;
      _correct = user == correct;
      if (_correct == true) _score += 10;
    });
  }

  void _next() {
    if (_idx + 1 >= _items.length) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('✍️ Temam!'),
          content: Text('$_score XP.'),
          actions: [TextButton(
            onPressed: () { Navigator.pop(context); context.pop(); },
            child: const Text('Derkeve'))],
        ),
      );
      return;
    }
    setState(() { _idx++; _ctrl.clear(); _checked = false; _correct = null; });
  }

  @override
  Widget build(BuildContext context) {
    final showTr = ref.watch(showTurkishProvider);
    final q = _items[_idx];
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
        title: Row(children: [
          const Text('✍️', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 8),
          Text('Nivîsîn', style: AppTypography.headingSmall.copyWith(
            color: AppColors.textPrimary, fontWeight: FontWeight.w800)),
          const Spacer(),
          Text('${_idx+1}/${_items.length}', style: AppTypography.caption),
        ]),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7B1FA2).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('${q.level} · ${q.type}',
                    style: TextStyle(color: const Color(0xFF7B1FA2),
                      fontWeight: FontWeight.w800, fontSize: 11)),
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
                  child: Text(showTr ? q.promptTr : q.correctAnswer,
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600, height: 1.5)),
                ),
                if (q.words != null) ...[
                  const SizedBox(height: 12),
                  Wrap(spacing: 6, runSpacing: 6, children: [
                    for (final w in q.words!)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7B1FA2).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF7B1FA2).withValues(alpha: 0.3)),
                        ),
                        child: Text(w, style: TextStyle(
                          color: const Color(0xFF7B1FA2), fontWeight: FontWeight.w700)),
                      ),
                  ]),
                ],
                const SizedBox(height: 16),
                TextField(
                  controller: _ctrl,
                  enabled: !_checked,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Bi Kurmancî binivîse...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: const Color(0xFF7B1FA2), width: 2)),
                  ),
                  style: AppTypography.bodyLarge,
                ),
                if (_checked) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _correct == true
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        Icon(_correct == true ? Icons.check_circle : Icons.cancel,
                          color: _correct == true ? Colors.green : Colors.red),
                        const SizedBox(width: 8),
                        Text(_correct == true ? 'Rast!' : 'Çewt',
                          style: TextStyle(
                            color: _correct == true ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w800, fontSize: 16)),
                      ]),
                      const SizedBox(height: 8),
                      Text('Bersiv: ${q.correctAnswer}',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text(showTr ? q.explanationTr : q.explanationKu,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary, height: 1.4)),
                    ]),
                  ),
                ],
                const Spacer(),
                SizedBox(
                  width: double.infinity, height: 50,
                  child: ElevatedButton(
                    onPressed: _checked ? _next : _check,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7B1FA2),
                      foregroundColor: Colors.white),
                    child: Text(_checked
                      ? (_idx + 1 >= _items.length ? 'Encamê bibîne' : 'Berdewam')
                      : 'Kontrol bike',
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
