import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/services/sound_service.dart';
import '../../core/services/tts_service.dart';
import '../providers/language_mode_provider.dart';

// Conditional import: web uses dart:js_interop, other platforms get a no-op stub
import '../../core/services/js_eval_stub.dart'
    if (dart.library.html) '../../core/services/js_eval_web.dart'
    as js_bridge;

/// Kurmancî kelime seslendirme butonu.
///
/// HuggingFace Kurmancî TTS modelini kullanır.
/// Türkçe fallback YOKTUR — yanlış telaffuz olmasın diye.
/// Başarısız olursa kullanıcıya bilgi verir.
class SpeakButton extends ConsumerStatefulWidget {
  final String text;
  final double size;
  final Color? color;
  final bool showLabel;
  final bool slow;

  const SpeakButton({
    super.key,
    required this.text,
    this.size = 44,
    this.color,
    this.showLabel = false,
    this.slow = false,
  });

  @override
  ConsumerState<SpeakButton> createState() => _SpeakButtonState();
}

class _SpeakButtonState extends ConsumerState<SpeakButton> {
  bool _loading = false;
  bool _playing = false;
  bool _failed = false;
  bool _showColdHint = false; // Cold start uzun sürerse gösterilir

  Future<void> _speak() async {
    if (_loading || _playing) return;

    setState(() { _loading = true; _failed = false; _showColdHint = false; });

    final tts = ref.read(ttsServiceProvider);
    final isCold = tts.isColdStart;

    // 5 saniye sonra hâlâ yükleniyorsa "ilk seferde uyandırılıyor" ipucu
    if (isCold) {
      Future<void>.delayed(const Duration(seconds: 5), () {
        if (mounted && _loading) {
          setState(() => _showColdHint = true);
        }
      });
    }

    try {
      // Cold start için 90sn, normal için 30sn timeout
      final timeout = isCold
          ? const Duration(seconds: 90)
          : const Duration(seconds: 30);
      final audioUrl = await tts.synthesize(widget.text)
          .timeout(timeout, onTimeout: () => null);

      if (!mounted) return;

      if (!mounted) return;

      if (audioUrl != null) {
        setState(() {
          _loading = false;
          _playing = true;
          _showColdHint = false;
        });
        SoundService.playClick();
        _playWebAudio(audioUrl);
      } else {
        // Ses üretilemedi — kullanıcıya görsel bilgi
        setState(() {
          _loading = false;
          _failed = true;
          _showColdHint = false;
        });
        // 4 saniye sonra failed durumunu temizle
        Future<void>.delayed(const Duration(seconds: 4), () {
          if (mounted) setState(() => _failed = false);
        });
        return;
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _loading = false;
          _failed = true;
          _showColdHint = false;
        });
        Future<void>.delayed(const Duration(seconds: 4), () {
          if (mounted) setState(() => _failed = false);
        });
        return;
      }
    }

    // Tahmini ses süresi sonrası playing durumunu kapat
    final estimatedDuration = (widget.text.split(' ').length * 0.5 + 1.5)
        .clamp(2.0, 8.0)
        .toInt();
    Future.delayed(Duration(seconds: estimatedDuration), () {
      if (mounted) setState(() => _playing = false);
    });
  }

  void _playWebAudio(String url) {
    if (kIsWeb) {
      _evalJs('''
        (function() {
          var a = new Audio('$url');
          a.play().catch(function(e) { console.log('Audio play error:', e); });
        })();
      ''');
    }
  }

  void _evalJs(String script) {
    if (!kIsWeb) return;
    try {
      js_bridge.evalJs(script);
    } catch (e) {
      if (kDebugMode) debugPrint('JS eval error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? AppColors.primary;
    final iconSize = widget.size * 0.5;

    Widget button = GestureDetector(
      onTap: _speak,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: _failed
              ? AppColors.errorSoft.withOpacity(0.12)
              : _playing
                  ? color.withOpacity(0.15)
                  : _loading
                      ? color.withOpacity(0.08)
                      : color.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(
            color: _failed
                ? AppColors.errorSoft
                : _playing ? color : color.withOpacity(0.2),
            width: _playing ? 2 : 1,
          ),
        ),
        child: Center(
          child: _loading
              ? SizedBox(
                  width: iconSize * 0.7,
                  height: iconSize * 0.7,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: color,
                  ),
                )
              : Icon(
                  _failed
                      ? Icons.volume_off_rounded
                      : _playing
                          ? Icons.volume_up_rounded
                          : Icons.volume_up_outlined,
                  size: iconSize,
                  color: _failed ? AppColors.errorSoft : color,
                ),
        ),
      ),
    );

    if (_playing) {
      button = button
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scale(
            begin: const Offset(1, 1),
            end: const Offset(1.12, 1.12),
            duration: 500.ms,
            curve: Curves.easeInOut,
          )
          .then()
          .shimmer(
            duration: 800.ms,
            color: color.withOpacity(0.3),
          );
    }

    if (!widget.showLabel && !_showColdHint) return button;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        button,
        const SizedBox(height: 4),
        Text(
          _failed
              ? 'Deng tune'
              : _showColdHint
                  ? 'Amade dibe…'    // "Hazırlanıyor..." (cold start)
                  : 'Guhdarî bike',
          style: TextStyle(
            fontSize: 10,
            color: _failed
                ? AppColors.errorSoft.withOpacity(0.7)
                : _showColdHint
                    ? color.withOpacity(0.85)
                    : color.withOpacity(0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

/// Büyük seslendirme butonu — kelime detay ekranı için
class LargeSpeakButton extends ConsumerWidget {
  final String text;
  final String? subtitle;

  const LargeSpeakButton({
    super.key,
    required this.text,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.12)),
      ),
      child: Row(
        children: [
          SpeakButton(text: text, size: 52, color: AppColors.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  ref.watch(showTurkishProvider)
                      ? 'Guhdarî bike — Dinle'
                      : 'Guhdarî bike',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.primary.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
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
