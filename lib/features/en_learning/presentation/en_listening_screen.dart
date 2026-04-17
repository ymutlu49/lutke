import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../domain/en_listening_db.dart';

// Conditional JS import
import '../../../core/services/js_eval_stub.dart'
    if (dart.library.html) '../../../core/services/js_eval_web.dart'
    as js_bridge;

class EnListeningScreen extends StatefulWidget {
  const EnListeningScreen({super.key});
  @override
  State<EnListeningScreen> createState() => _EnListeningScreenState();
}

class _EnListeningScreenState extends State<EnListeningScreen> {
  late List<EnListeningExercise> _items;
  int _idx = 0;
  String? _selected;
  bool _checked = false;
  final _ctrl = TextEditingController();
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _items = List.from(kEnListeningExercises)..shuffle(Random());
    _items = _items.take(10).toList();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _playAudio(String text) {
    if (!kIsWeb) return;
    final esc = text.replaceAll("'", "\\'").replaceAll('\n', ' ');
    js_bridge.evalJs('''
      (function() {
        if (!window.speechSynthesis) return;
        window.speechSynthesis.cancel();
        var u = new SpeechSynthesisUtterance('$esc');
        u.lang = 'en-US';
        u.rate = 0.9;
        window.speechSynthesis.speak(u);
      })();
    ''');
  }

  void _check() {
    final q = _items[_idx];
    bool correct;
    if (q.type == 'transcribe') {
      final a = _ctrl.text.trim().toLowerCase().replaceAll(RegExp(r'[.,!?]'), '');
      final b = q.correctAnswer.toLowerCase().replaceAll(RegExp(r'[.,!?]'), '');
      correct = a == b;
    } else {
      correct = _selected == q.correctAnswer;
    }
    setState(() {
      _checked = true;
      if (correct) _score += 10;
    });
  }

  void _next() {
    if (_idx + 1 >= _items.length) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('✅ Bitti!'),
          content: Text('$_score XP kazandın.'),
          actions: [
            TextButton(
              onPressed: () { Navigator.pop(context); context.pop(); },
              child: const Text('Derkeve'),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = _items[_idx];
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
        title: Row(children: [
          const Text('👂', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 8),
          Text('Guhdarîkirin', style: AppTypography.headingSmall.copyWith(
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
                    color: const Color(0xFF00838F).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('${q.level} · ${q.type}',
                    style: TextStyle(color: const Color(0xFF00838F),
                      fontWeight: FontWeight.w800, fontSize: 11)),
                ),
                const SizedBox(height: 12),
                Text(q.promptKu, style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
                const SizedBox(height: 20),
                // Play button
                Center(
                  child: InkWell(
                    onTap: () => _playAudio(q.audioText),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00838F),
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(
                          color: const Color(0xFF00838F).withValues(alpha: 0.3),
                          blurRadius: 16, offset: const Offset(0, 4))],
                      ),
                      child: const Icon(Icons.volume_up, size: 48, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(child: Text('Guhdarî bike', style: AppTypography.caption)),
                const SizedBox(height: 20),
                // Answer area
                if (q.type == 'transcribe')
                  TextField(
                    controller: _ctrl,
                    enabled: !_checked,
                    decoration: InputDecoration(
                      hintText: 'Guhê xwe bide û binivîse...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  )
                else if (q.options != null)
                  Column(children: [
                    for (final opt in q.options!)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: InkWell(
                          onTap: _checked ? null : () => setState(() => _selected = opt),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: _checked
                                ? (opt == q.correctAnswer
                                  ? Colors.green.withValues(alpha: 0.15)
                                  : _selected == opt ? Colors.red.withValues(alpha: 0.15) : Colors.white)
                                : (_selected == opt ? const Color(0xFF00838F).withValues(alpha: 0.1) : Colors.white),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _selected == opt ? const Color(0xFF00838F) : AppColors.borderLight,
                                width: 1.5),
                            ),
                            child: Text(opt, style: AppTypography.body),
                          ),
                        ),
                      ),
                  ]),
                if (_checked) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8E1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Bersiva rast: ${q.correctAnswer}',
                        style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Text(q.explanationKu, style: AppTypography.caption),
                    ]),
                  ),
                ],
                const Spacer(),
                SizedBox(width: double.infinity, height: 50, child: ElevatedButton(
                  onPressed: _checked ? _next : _check,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00838F),
                    foregroundColor: Colors.white),
                  child: Text(_checked ? 'Berdewam' : 'Kontrol',
                    style: const TextStyle(fontWeight: FontWeight.w800)),
                )),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
