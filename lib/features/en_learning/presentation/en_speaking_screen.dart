import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../domain/en_speaking_db.dart';
import '../../../shared/services/speech_recognition_service.dart';
import '../../../shared/services/skill_progress_service.dart';

import '../../../core/services/js_eval_stub.dart'
    if (dart.library.html) '../../../core/services/js_eval_web.dart'
    as js_bridge;

class EnSpeakingScreen extends StatefulWidget {
  const EnSpeakingScreen({super.key});
  @override
  State<EnSpeakingScreen> createState() => _EnSpeakingScreenState();
}

class _EnSpeakingScreenState extends State<EnSpeakingScreen> {
  late List<EnSpeakingExercise> _items;
  int _idx = 0;
  bool _done = false;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _items = List.from(kEnSpeakingExercises)..shuffle(Random());
    _items = _items.take(10).toList();
  }

  void _playModel() {
    if (!kIsWeb) return;
    final esc = _items[_idx].textEn.replaceAll("'", "\\'");
    js_bridge.evalJs('''
      (function() {
        if (!window.speechSynthesis) return;
        window.speechSynthesis.cancel();
        var u = new SpeechSynthesisUtterance('$esc');
        u.lang = 'en-US'; u.rate = 0.85;
        window.speechSynthesis.speak(u);
      })();
    ''');
  }

  void _playSlow() {
    if (!kIsWeb) return;
    final esc = _items[_idx].textEn.replaceAll("'", "\\'");
    js_bridge.evalJs('''
      (function() {
        if (!window.speechSynthesis) return;
        window.speechSynthesis.cancel();
        var u = new SpeechSynthesisUtterance('$esc');
        u.lang = 'en-US'; u.rate = 0.6;
        window.speechSynthesis.speak(u);
      })();
    ''');
  }

  bool _listening = false;
  String? _transcript;
  double? _similarity;

  void _startRecording() {
    if (_listening) return;
    setState(() { _listening = true; _transcript = null; _similarity = null; });
    SpeechRecognitionService.start(
      language: 'en-US',
      onResult: (t) {
        if (!mounted) return;
        final sim = SpeechRecognitionService.similarity(t, _items[_idx].textEn);
        setState(() {
          _listening = false;
          _transcript = t;
          _similarity = sim;
          if (sim >= 0.7) {
            _done = true;
            _score += (sim * 15).round();
          }
        });
      },
      onError: (err) {
        if (!mounted) return;
        setState(() {
          _listening = false;
          _transcript = 'Xelet: $err';
        });
      },
    );
  }

  void _iDid() {
    setState(() { _done = true; _score += 10; });
    SkillProgressService.markCompleted(module: 'en', skill: 'speaking');
  }

  void _next() {
    if (_idx + 1 >= _items.length) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('🎙️ Temam!'),
          content: Text('$_score XP. Meşqên konuşma her roj bike.'),
          actions: [TextButton(
            onPressed: () { Navigator.pop(context); context.pop(); },
            child: const Text('Derkeve'))],
        ),
      );
      return;
    }
    setState(() { _idx++; _done = false; });
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
          const Text('🗣️', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 8),
          Text('Axaftin', style: AppTypography.headingSmall.copyWith(
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
                    color: const Color(0xFFD81B60).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('${q.level} · ${q.type}',
                    style: TextStyle(color: const Color(0xFFD81B60),
                      fontWeight: FontWeight.w800, fontSize: 11)),
                ),
                const SizedBox(height: 12),
                Text(q.promptKu, style: AppTypography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 16),
                // Target text
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color(0xFFD81B60).withValues(alpha: 0.15),
                      const Color(0xFFD81B60).withValues(alpha: 0.05),
                    ]),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFD81B60).withValues(alpha: 0.3)),
                  ),
                  child: Column(children: [
                    Text(q.textEn,
                      style: AppTypography.title.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary),
                      textAlign: TextAlign.center),
                    if (q.ipa != null) ...[
                      const SizedBox(height: 6),
                      Text(q.ipa!, style: AppTypography.body.copyWith(
                        color: AppColors.textSecondary, fontStyle: FontStyle.italic)),
                    ],
                  ]),
                ),
                const SizedBox(height: 12),
                // Audio buttons
                Row(children: [
                  Expanded(child: ElevatedButton.icon(
                    onPressed: _playModel,
                    icon: const Icon(Icons.volume_up),
                    label: const Text('Guhdarî bike'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD81B60),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 48)),
                  )),
                  const SizedBox(width: 8),
                  Expanded(child: OutlinedButton.icon(
                    onPressed: _playSlow,
                    icon: const Icon(Icons.slow_motion_video),
                    label: const Text('Hêdî'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFD81B60),
                      side: BorderSide(color: const Color(0xFFD81B60)),
                      minimumSize: const Size(0, 48)),
                  )),
                ]),
                const SizedBox(height: 12),
                // Tip
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('💡'),
                    const SizedBox(width: 8),
                    Expanded(child: Text(q.tipKu,
                      style: AppTypography.bodySmall.copyWith(
                        color: const Color(0xFF7B5E00), height: 1.4))),
                  ]),
                ),
                const SizedBox(height: 16),
                // Recording button (speech recognition)
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _listening ? null : _startRecording,
                    icon: Icon(_listening ? Icons.mic : Icons.mic_none),
                    label: Text(_listening ? 'Guhdarî dike...' : 'Tu bibêje'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _listening ? Colors.red : const Color(0xFFD81B60),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(200, 48),
                    ),
                  ),
                ),
                if (_transcript != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _similarity != null && _similarity! >= 0.7
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Te got: "$_transcript"',
                          style: AppTypography.bodySmall.copyWith(
                            fontWeight: FontWeight.w700)),
                        if (_similarity != null) ...[
                          const SizedBox(height: 4),
                          Text('Hevşibî: %${(_similarity! * 100).toStringAsFixed(0)}',
                            style: TextStyle(
                              color: _similarity! >= 0.7 ? Colors.green : Colors.orange,
                              fontWeight: FontWeight.w800)),
                        ],
                      ],
                    ),
                  ),
                ],
                const Spacer(),
                Row(children: [
                  Expanded(child: OutlinedButton(
                    onPressed: _next,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 48)),
                    child: const Text('Derbas bike'),
                  )),
                  const SizedBox(width: 8),
                  Expanded(child: ElevatedButton(
                    onPressed: _done ? _next : _iDid,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _done ? Colors.green : const Color(0xFFD81B60),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 48)),
                    child: Text(_done ? 'Berdewam' : 'Min got ✓',
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                  )),
                ]),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
