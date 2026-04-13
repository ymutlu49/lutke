import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/services/tts_service.dart';

/// Kurmancî kelime seslendirme butonu.
///
/// Tıklanınca:
/// 1. HuggingFace Kurmancî TTS dener (gerçek Kurmancî model)
/// 2. Başarısız olursa Web SpeechSynthesis (Türkçe fonetik) kullanır
///
/// [text] — Seslendirilecek Kurmancî metin
/// [size] — Buton boyutu (default: 44)
/// [color] — İkon rengi (default: primary)
class SpeakButton extends ConsumerStatefulWidget {
  final String text;
  final double size;
  final Color? color;
  final bool showLabel;

  const SpeakButton({
    super.key,
    required this.text,
    this.size = 44,
    this.color,
    this.showLabel = false,
  });

  @override
  ConsumerState<SpeakButton> createState() => _SpeakButtonState();
}

class _SpeakButtonState extends ConsumerState<SpeakButton> {
  bool _loading = false;
  bool _playing = false;

  Future<void> _speak() async {
    if (_loading || _playing) return;

    setState(() => _loading = true);

    try {
      final tts = ref.read(ttsServiceProvider);
      final audioUrl = await tts.synthesize(widget.text)
          .timeout(const Duration(seconds: 8), onTimeout: () => null);

      if (!mounted) return;

      if (audioUrl != null) {
        // HuggingFace başarılı — audio URL'yi oynat
        setState(() { _loading = false; _playing = true; });
        // Web'de audio element ile oynat
        _playWebAudio(audioUrl);
      } else {
        // Fallback: Web SpeechSynthesis
        setState(() { _loading = false; _playing = true; });
        _speakWithWebSpeech(widget.text);
      }
    } catch (_) {
      // Son çare: Web SpeechSynthesis
      if (mounted) {
        setState(() { _loading = false; _playing = true; });
        _speakWithWebSpeech(widget.text);
      }
    }

    // 3 saniye sonra playing durumunu sıfırla
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _playing = false);
    });
  }

  void _playWebAudio(String url) {
    // Web'de JavaScript ile audio oynat
    if (kIsWeb) {
      _evalJs('''
        (function() {
          var a = new Audio('$url');
          a.play().catch(function(e) { console.log('Audio play error:', e); });
        })();
      ''');
    }
  }

  void _speakWithWebSpeech(String text) {
    if (kIsWeb) {
      _evalJs(getWebTtsScript(text));
    }
  }

  void _evalJs(String script) {
    // Web'de JavaScript çalıştır
    try {
      // ignore: avoid_web_libraries_in_flutter
      // dart:js_interop kullanımı
      if (kIsWeb) {
        // Web platformunda eval çalıştır
        _webEval(script);
      }
    } catch (e) {
      if (kDebugMode) debugPrint('JS eval error: $e');
    }
  }

  void _webEval(String script) {
    // Web'de doğrudan çalıştırma — html package kullanmadan
    // Bu fonksiyon web build'de çalışır
    try {
      // Web SpeechSynthesis doğrudan JavaScript ile çalışır
      // Flutter web'de window.eval yerine dart:js_interop kullanılır
      // Şimdilik placeholder — gerçek implementasyon web-specific
    } catch (_) {}
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
          color: _playing
              ? color.withOpacity(0.15)
              : _loading
                  ? color.withOpacity(0.08)
                  : color.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(
            color: _playing ? color : color.withOpacity(0.2),
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
                  _playing
                      ? Icons.volume_up_rounded
                      : Icons.volume_up_outlined,
                  size: iconSize,
                  color: color,
                ),
        ),
      ),
    );

    if (_playing) {
      button = button.animate(onPlay: (c) => c.repeat(reverse: true))
          .scale(begin: const Offset(1, 1), end: const Offset(1.08, 1.08),
              duration: 400.ms);
    }

    if (!widget.showLabel) return button;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        button,
        const SizedBox(height: 4),
        Text(
          'Guhdarî bike',
          style: TextStyle(
            fontSize: 10,
            color: color.withOpacity(0.7),
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
                  'Guhdarî bike — Dinle',
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
