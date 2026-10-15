import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/accessibility_settings.dart';
import '../../../core/services/en_tts_helper.dart';
import '../domain/en_speaking_db.dart';
import '../../../shared/services/speech_recognition_service.dart';
import '../../../shared/services/skill_progress_service.dart';

// WEB-COMPAT FIX: Bu ekran `markSkillCompletedAndNotify(ref, ...)` dixebitîne,
// lê StatefulWidget bû — `ref` nediyar bû → build blocking error
// (flutter analyze: undefined_identifier). Hate veguhertin ConsumerStatefulWidget.
class EnSpeakingScreen extends ConsumerStatefulWidget {
  const EnSpeakingScreen({super.key});
  @override
  ConsumerState<EnSpeakingScreen> createState() => _EnSpeakingScreenState();
}

class _EnSpeakingScreenState extends ConsumerState<EnSpeakingScreen> {
  late List<EnSpeakingExercise> _items;
  int _idx = 0;
  bool _done = false;
  int _score = 0;
  int _attempts = 0;

  @override
  void initState() {
    super.initState();
    _items = List.from(kEnSpeakingExercises)..shuffle(Random());
    _items = _items.take(10).toList();
  }

  @override
  void dispose() {
    // Safety: mikrofon hâlâ açıksa kapat (sonuç atılır).
    SpeechRecognitionService.cancel();
    EnTtsHelper.cancel();
    super.dispose();
  }

  void _playModel() {
    EnTtsHelper.speak(_items[_idx].textEn, rate: 0.85);
  }

  void _playSlow() {
    EnTtsHelper.speak(_items[_idx].textEn, rate: 0.6);
  }

  bool _listening = false;
  String? _transcript;
  double? _similarity;

  void _startRecording() {
    if (_listening) return;
    // UX: ger guhdarkirina model hîna dixebite, pêşî bisekinîne.
    EnTtsHelper.cancel();

    // A11y: li ser webê ne bîrokirinê destnîşan bike.
    if (!kIsWeb) {
      setState(() {
        _transcript =
            'Mîkrofon tenê li gerok (Chrome/Edge) dixebite. Ji kerema xwe bi "Min got" bişopîne.';
      });
      return;
    }

    if (!SpeechRecognitionService.isSupported) {
      setState(() {
        _transcript =
            'Gerokê te piştgirî nade dengnasînê. Chrome an Edge biceribîne.';
      });
      return;
    }

    setState(() {
      _listening = true;
      _transcript = null;
      _similarity = null;
      _attempts++;
    });
    // Hedef, dinleme başladığı andaki cümle — sonuç geç gelse de doğru
    // cümleyle karşılaştırılır.
    final target = _items[_idx].textEn;
    SpeechRecognitionService.start(
      language: 'en-US',
      onResult: (t) {
        if (!mounted) return;
        final sim = SpeechRecognitionService.similarity(t, target);
        setState(() {
          _listening = false;
          _transcript = t;
          _similarity = sim;
          if (sim >= 0.7) {
            _done = true;
            _score += (sim * 15).round();
            markSkillCompletedAndNotify(ref,
                module: 'en', skill: 'speaking');
          }
        });
      },
      onError: (err) {
        if (!mounted) return;
        setState(() {
          _listening = false;
          _transcript = _humanizeError(err);
        });
      },
    );
  }

  /// Peyama xeletiyê ji Kurmancî-hêsan re bike.
  String _humanizeError(String err) {
    final low = err.toLowerCase();
    if (low.contains('not-allowed') || low.contains('denied')) {
      return 'Destûra mîkrofonê hate redkirin. Ji sazkirinên gerokê destûrê bide paşê dîsa biceribîne.';
    }
    if (low.contains('no-speech')) {
      return 'Tu deng nehate bihîstin. Nêzîkî mîkrofonê bibêje û dîsa biceribîne.';
    }
    if (low.contains('network')) {
      return 'Pêwendiya torê qels e. Internetê kontrol bike.';
    }
    if (low.contains('timeout') || low.contains('zeman qediya')) {
      return 'Dem qediya. Dîsa bişkoja qeydê bikirtîne.';
    }
    return 'Xeletî: $err. Dîsa biceribîne.';
  }

  /// Zarif durdurma: mikrofon kapanır ama söylenenler kaybolmaz —
  /// `onResult` toplanan metinle çağrılır, `_listening` orada kapanır
  /// (Ekim 2026: eskiden "Bisekine" sonucu çöpe atıyordu).
  void _stopRecording() {
    if (!_listening) return;
    SpeechRecognitionService.stop();
  }

  void _iDid() {
    setState(() {
      _done = true;
      _score += 10;
    });
    // BUG FIX: markCompleted dihate gotin lê skillCompletedProvider /
    // skillTotalXpProvider invalidate nedibû — dashboard stale dida nîşan.
    markSkillCompletedAndNotify(ref, module: 'en', skill: 'speaking');
  }

  void _retry() {
    setState(() {
      _transcript = null;
      _similarity = null;
    });
  }

  void _next() {
    if (_idx + 1 >= _items.length) {
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Row(children: [
            const Text('🎉', style: TextStyle(fontSize: 28)),
            const SizedBox(width: 8),
            Text('Pîroz be!',
                style: AppTypography.title
                    .copyWith(fontWeight: FontWeight.w800)),
          ]),
          content: Text(
            'Te $_score XP bi dest xist. Axaftin her roj bi kar bîne — tenê bi temrînê baş dibe.',
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
      return;
    }
    // Yeni cümle: eski dinleme hâlâ açıksa iptal et.
    SpeechRecognitionService.cancel();
    setState(() {
      _idx++;
      _done = false;
      _listening = false;
      _transcript = null;
      _similarity = null;
      _attempts = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = _items[_idx];
    final a11y = ref.watch(accessibilitySettingsProvider);
    return Scaffold(
      backgroundColor: a11y.background.color ?? AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: a11y.background.color ?? AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          tooltip: 'Derkeve',
          onPressed: () => context.canPop()
              ? context.pop()
              : context.go(AppRoutes.enHome),
        ),
        title: Row(children: [
          // A11Y: decorative emoji.
          ExcludeSemantics(
            child: const Text('🗣️', style: TextStyle(fontSize: 22)),
          ),
          const SizedBox(width: 8),
          Semantics(
            header: true,
            child: Text('Axaftin',
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
        ]),
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
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color:
                            const Color(0xFFD81B60).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('${q.level} · ${q.type}',
                          style: TextStyle(
                              color: const Color(0xFFD81B60),
                              fontWeight: FontWeight.w800,
                              fontSize: 11)),
                    ),
                    const SizedBox(height: 12),
                    Text(q.promptKu,
                        style: a11y.applyFont(
                          AppTypography.bodyLarge.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary),
                        )),
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
                        border: Border.all(
                            color: const Color(0xFFD81B60)
                                .withValues(alpha: 0.3)),
                      ),
                      child: Column(children: [
                        Semantics(
                          label: 'Nivîsa mebest bi Îngilîzî: ${q.textEn}',
                          child: Text(q.textEn,
                              style: a11y.applyFont(
                                AppTypography.title.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary),
                              ),
                              textAlign: TextAlign.center),
                        ),
                        if (q.ipa != null) ...[
                          const SizedBox(height: 6),
                          // A11Y: IPA is a technical notation; keep upright.
                          // Italics removed — dyslexia best practice.
                          Semantics(
                            label: 'Phonetic transcription: ${q.ipa!}',
                            child: Text(q.ipa!,
                                style: AppTypography.body.copyWith(
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.3)),
                          ),
                        ],
                      ]),
                    ),
                    const SizedBox(height: 12),
                    // Audio buttons
                    Row(children: [
                      Expanded(
                          child: ElevatedButton.icon(
                        onPressed: _playModel,
                        icon: const Icon(Icons.volume_up),
                        label: const Text('Guhdarî bike'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD81B60),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 52)),
                      )),
                      const SizedBox(width: 8),
                      Expanded(
                          child: OutlinedButton.icon(
                        onPressed: _playSlow,
                        icon: const Icon(Icons.slow_motion_video),
                        label: const Text('Hêdî'),
                        style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFFD81B60),
                            side: const BorderSide(
                                color: Color(0xFFD81B60)),
                            minimumSize: const Size(0, 52)),
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
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('💡'),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Text(q.tipKu,
                                    style: a11y.applyFont(
                                      AppTypography.bodySmall.copyWith(
                                          color: const Color(0xFF7B5E00),
                                          height: 1.4),
                                    ))),
                          ]),
                    ),
                    const SizedBox(height: 16),
                    // Recording controls — destûr + rewş diyar
                    Center(
                      child: Column(children: [
                        Semantics(
                          button: true,
                          label: _listening
                              ? 'Mîkrofon dinivîse — bişkoj bikirtîne ji bo rawestandinê'
                              : 'Qeydê bide destpêkirin û bi Îngilîzî bibêje',
                          child: ElevatedButton.icon(
                            onPressed: _listening
                                ? _stopRecording
                                : _startRecording,
                            icon: Icon(_listening
                                ? Icons.stop_circle
                                : Icons.mic_none),
                            label: Text(_listening
                                ? 'Bisekine'
                                : 'Qeydê bide destpêkirin'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _listening
                                  ? Colors.red
                                  : const Color(0xFFD81B60),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(220, 52),
                            ),
                          ),
                        ),
                        if (_listening) ...[
                          const SizedBox(height: 8),
                          Row(mainAxisSize: MainAxisSize.min, children: [
                            const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xFFD81B60)),
                            ),
                            const SizedBox(width: 8),
                            Text('Guhdarî dikim... bi awayekî xweş bibêje',
                                style: AppTypography.caption.copyWith(
                                    color: AppColors.textSecondary)),
                          ]),
                        ] else if (!kIsWeb)
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              'Mîkrofon tenê li ser gerokê (web) heye.',
                              style: AppTypography.caption.copyWith(
                                  color: AppColors.textSecondary),
                            ),
                          ),
                      ]),
                    ),
                    if (_transcript != null) ...[
                      const SizedBox(height: 10),
                      // A11Y: liveRegion announces transcript result
                      // automatically. Uses semantic colors (success/warning)
                      // rather than raw Colors.green — better on Windows
                      // high-contrast mode.
                      Semantics(
                      liveRegion: true,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _similarity != null && _similarity! >= 0.7
                              ? AppColors.success.withValues(alpha: 0.12)
                              : AppColors.warning.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _similarity != null && _similarity! >= 0.7
                                ? AppColors.success.withValues(alpha: 0.3)
                                : AppColors.warning.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Te got: "$_transcript"',
                                style: a11y.applyFont(
                                  AppTypography.bodySmall.copyWith(
                                      fontWeight: FontWeight.w700),
                                )),
                            if (_similarity != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                  'Hevşibî: %${(_similarity! * 100).toStringAsFixed(0)}',
                                  // A11Y: semantic colors survive high-contrast.
                                  style: TextStyle(
                                      color: _similarity! >= 0.7
                                          ? AppColors.success
                                          : AppColors.warning,
                                      fontWeight: FontWeight.w800)),
                              const SizedBox(height: 8),
                              if (_similarity! < 0.7)
                                Row(children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: _retry,
                                      icon: const Icon(Icons.refresh, size: 18),
                                      label: const Text('Dîsa biceribîne'),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor:
                                            const Color(0xFFD81B60),
                                        side: const BorderSide(
                                            color: Color(0xFFD81B60)),
                                        minimumSize: const Size(0, 40),
                                      ),
                                    ),
                                  ),
                                  if (_attempts >= 2) ...[
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: _iDid,
                                        icon: const Icon(Icons.skip_next,
                                            size: 18),
                                        label: const Text('Derbas bike'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.textSecondary,
                                          foregroundColor: Colors.white,
                                          minimumSize: const Size(0, 40),
                                        ),
                                      ),
                                    ),
                                  ],
                                ]),
                            ],
                          ],
                        ),
                      ),
                      ),
                    ],
                    const Spacer(),
                    Row(children: [
                      Expanded(
                          child: OutlinedButton(
                        onPressed: _next,
                        style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 52)),
                        child: const Text('Derbas bike'),
                      )),
                      const SizedBox(width: 8),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: _done ? _next : _iDid,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _done
                                ? Colors.green
                                : const Color(0xFFD81B60),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 52)),
                        child: Text(_done ? 'Berdewam' : 'Min got ✓',
                            style: const TextStyle(
                                fontWeight: FontWeight.w800)),
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
