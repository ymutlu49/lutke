import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/services/audio_service.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/services/en_tts_helper.dart';
import '../../core/services/sound_service.dart';
import '../../core/services/tts_asset_manifest.dart';
import '../../core/services/tts_service.dart';
import '../../core/services/tts_source_preferences.dart';
import '../providers/language_mode_provider.dart';

// Conditional import: web uses dart:js_interop, other platforms get a no-op stub
import '../../core/services/js_eval_stub.dart'
    if (dart.library.html) '../../core/services/js_eval_web.dart'
    as js_bridge;

/// Kelime seslendirme butonu.
///
/// **Dil seçimi metne bağlıdır**, aktif modüle değil:
///   - `lang: 'ku'` (default) → HuggingFace Kurmancî TTS (amedcj/kmr_tts)
///   - `lang: 'en'` → Browser SpeechSynthesis (native İngilizce voice)
///
/// Kurmancî için Türkçe/İngilizce fallback YOKTUR — yanlış telaffuz
/// olmasın diye. Başarısız olursa kullanıcıya görsel bilgi verir.
///
/// **ÖNEMLİ:** Kullanıcının aktif modülüne (`learningModuleProvider`)
/// bakmayın — bir ekranda hem KU hem EN metinleri olabilir. Her
/// çağrıda metnin kendi dilini açıkça belirtin.
class SpeakButton extends ConsumerStatefulWidget {
  final String text;
  final double size;
  final Color? color;
  final bool showLabel;
  final bool slow;

  /// Metnin dili: `'ku'` (Kurmancî, default) veya `'en'` (İngilizce).
  /// Kurmancî için HF TTS, İngilizce için browser TTS kullanılır.
  final String lang;

  /// True ise widget ilk göründüğünde ses BİR KEZ otomatik çalınır
  /// (dinleme soruları için). `text` değişirse yeni kelime için bir kez
  /// daha tetiklenir. Sonsuz döngü riski yok: yalnızca initState ve
  /// didUpdateWidget(text değişimi) anlarında post-frame tetiklenir.
  final bool autoPlay;

  const SpeakButton({
    super.key,
    required this.text,
    this.size = 44,
    this.color,
    this.showLabel = false,
    this.slow = false,
    this.lang = 'ku',
    this.autoPlay = false,
  });

  /// Çalan / kuyruktaki TTS sesini GLOBAL olarak durdurur.
  ///
  /// Quiz'de sonraki soruya geçişte çağrılır — önceki sorunun sesi
  /// (HF cold-start gecikmesiyle geç başlasa bile) kesilir, "bayat ses"
  /// bir sonraki sorunun üzerine çalmaz. Hem Kurmancî web audio'yu
  /// (`window.__lutkeAudio`) hem İngilizce browser TTS kuyruğunu keser.
  static void stopAll() {
    if (!kIsWeb) return;
    try {
      js_bridge.evalJs('''
        (function() {
          try {
            if (window.__lutkeAudio) {
              try { window.__lutkeAudio.pause(); } catch (e) {}
              window.__lutkeAudio = null;
            }
          } catch (e) {}
        })();
      ''');
    } catch (_) {}
    EnTtsHelper.cancel();
  }

  @override
  ConsumerState<SpeakButton> createState() => _SpeakButtonState();
}

class _SpeakButtonState extends ConsumerState<SpeakButton> {
  bool _loading = false;
  bool _playing = false;
  bool _failed = false;
  bool _showColdHint = false; // Cold start uzun sürerse gösterilir
  bool _showLongColdHint = false; // 15sn+ — snackbar eşiği
  bool _slowMode = false; // Uzun basınca aktif olur — 0.75x hız

  /// Bayat-istek nesli sayacı. Her yeni `_speak()` çağrısı ve her `text`
  /// değişimi nesli artırır. HF cold-start (90sn'e kadar) sürerken
  /// kullanıcı sonraki soruya geçtiyse eski future çözüldüğünde nesil
  /// eskimiş olur → ESKİ kelimenin sesi ÇALINMAZ (bayat ses yarışı fix'i).
  int _generation = 0;

  @override
  void initState() {
    super.initState();
    _scheduleAutoPlay();
  }

  @override
  void didUpdateWidget(covariant SpeakButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      // Metin değişti → uçuştaki istekler bayat: nesli artır, durumu sıfırla.
      _generation++;
      setState(() {
        _loading = false;
        _playing = false;
        _failed = false;
        _showColdHint = false;
        _showLongColdHint = false;
      });
      // Yeni kelime için autoplay bir kez daha tetiklenir.
      _scheduleAutoPlay();
    }
  }

  @override
  void dispose() {
    _generation++;
    // Bu buton ses yüklerken/çalarken ağaçtan kalkıyorsa KENDİ sesini kes.
    // Bilinçli olarak global stopAll() DEĞİL: AnimatedSwitcher eski soruyu
    // ~300ms geç dispose eder; koşulsuz global durdurma yeni sorunun henüz
    // başlayan sesini de keserdi. lutkeKey eşleşmesi ile yalnızca bu
    // widget'ın başlattığı ses durdurulur.
    if (_loading || _playing) _stopIfCurrent();
    super.dispose();
  }

  /// autoPlay=true ise sesi post-frame'de bir kez çal — build sırasında
  /// setState çağrılmasın diye ertelenir.
  void _scheduleAutoPlay() {
    if (!widget.autoPlay) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _speak();
    });
  }

  /// JS string literal'ine gömülecek metni güvenli hale getir.
  String _escapeForJs(String s) =>
      s.replaceAll('\\', '\\\\').replaceAll("'", "\\'").replaceAll('\n', ' ');

  /// Yalnızca BU butonun başlattığı ses hâlâ aktifse durdur
  /// (lutkeKey damgası `_playWebAudio` içinde vurulur).
  void _stopIfCurrent() {
    if (!kIsWeb) return;
    final key = _escapeForJs(widget.text);
    _evalJs('''
      (function() {
        try {
          if (window.__lutkeAudio && window.__lutkeAudio.lutkeKey === '$key') {
            try { window.__lutkeAudio.pause(); } catch (e) {}
            window.__lutkeAudio = null;
          }
        } catch (e) {}
      })();
    ''');
  }

  /// Metne göre dili otomatik algıla:
  /// 1. Widget.lang explicit 'en' → İngilizce
  /// 2. Text Kurmancî diakritik (ê/î/û/ç/ş) içeriyor → Kurmancî
  /// 3. Text saf ASCII ve learningModuleProvider == english → İngilizce
  /// 4. Aksi → Kurmancî (default)
  ///
  /// Bu yanlış yönlendirmeyi önler: İngilizce modda İngilizce kelimeler
  /// HF Kurmancî TTS'e değil, browser speechSynthesis'e gönderilir.
  String _resolvedLang() {
    // Öncelik: çağıranın açıkça verdiği dil (widget.lang).
    // 'ku' ve 'en' değerleri olduğu gibi kullanılır.
    //
    // Eski heuristik (ASCII + englishModule → 'en') kaldırıldı:
    // silav, malbat, jimar, bav gibi Kurmancî kelimeler ASCII'dir ve
    // modül provider bir deep-link'ten sonra 'english'te kalmış olabilir.
    // Bu kombinasyon Kurmancî kelimeleri İngilizce TTS'e gönderiyordu
    // (yanlış aksan). Explicit widget.lang='ku' her zaman Kurmancî TTS'e gider.
    if (widget.lang == 'en') return 'en';
    if (widget.lang == 'ku') return 'ku';
    // Bilinmeyen/açık olmayan değerler için yalnızca diakritik varsa 'ku'.
    final hasKurmanciDiacritic =
        RegExp(r'[êîûçşÊÎÛÇŞ]').hasMatch(widget.text);
    if (hasKurmanciDiacritic) return 'ku';
    return widget.lang;
  }

  Future<void> _speak({bool slow = false}) async {
    if (_loading || _playing) return;

    // Bu isteğin neslini ve metnini yakala — await sonrası nesil
    // değiştiyse (yeni soru, dispose, yeni istek) sonuç iptal edilir.
    final gen = ++_generation;
    final requestText = widget.text;

    _slowMode = slow || widget.slow;
    setState(() {
      _loading = true;
      _failed = false;
      _showColdHint = false;
      _showLongColdHint = false;
    });

    final lang = _resolvedLang();

    // İngilizce metin → browser native speechSynthesis (hızlı, ücretsiz)
    // Kurmancî metin → HF TTS (aşağıda). Metnin dili karar verir.
    if (lang == 'en' && kIsWeb) {
      _speakEnglishBrowser(requestText);
      setState(() { _loading = false; _playing = true; });
      SoundService.playClick();
      // Tahmini süre sonra playing'i kapat (nesil eskimişse dokunma)
      final estimated = (requestText.split(' ').length * 0.4 + 1.0)
          .clamp(1.5, 6.0).toInt();
      Future.delayed(Duration(seconds: estimated), () {
        if (mounted && gen == _generation) setState(() => _playing = false);
      });
      return;
    }

    final tts = ref.read(ttsServiceProvider);
    // Kullanıcı kaynak tercihini TTS service'e yansıt
    tts.source = ref.read(ttsSourceProvider);
    final isCold = tts.isColdStart;

    // Offline guard: eğer bağlantı yoksa VE asset elimizde yoksa,
    // 30-90s HF bekleyişini es geç — doğrudan fail-state göster.
    // Asset varsa synthesize() zaten asset path döner, sorun olmaz.
    final isOnline = ref.read(isOnlineProvider);
    if (!isOnline) {
      final stripped = requestText
          .toLowerCase()
          .trim()
          .replaceAll(RegExp(r'[.,!?]+$'), '');
      final hasAsset = TtsAssetManifest.lookup(stripped) != null;
      if (!hasAsset) {
        setState(() {
          _loading = false;
          _failed = true;
        });
        final messenger = ScaffoldMessenger.maybeOf(context);
        messenger?.showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 3),
            content: Text('Bê girêdan — ev peyv jixwe dakêşandî nîne.'),
          ),
        );
        Future<void>.delayed(const Duration(seconds: 4), () {
          if (mounted) setState(() => _failed = false);
        });
        return;
      }
    }

    // UX FIX #2: Cold start görünürlüğü iki aşamalı:
    //  - 3sn: alt etiket "Amade dibe… (~60s)" + süre beklentisi
    //  - 15sn: SnackBar ile açıklama — "kullanıcı donduğunu sanmasın"
    // 60sn'lik HF uyanması sırasında sessiz kalmak en büyük UX tuzağı.
    if (isCold) {
      Future<void>.delayed(const Duration(seconds: 3), () {
        if (mounted && _loading && gen == _generation) {
          setState(() => _showColdHint = true);
        }
      });
      Future<void>.delayed(const Duration(seconds: 15), () {
        if (!mounted || !_loading || _showLongColdHint) return;
        if (gen != _generation) return; // İstek bayatladı — hint gereksiz
        setState(() => _showLongColdHint = true);
        final messenger = ScaffoldMessenger.maybeOf(context);
        messenger?.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 6),
            backgroundColor: AppColors.primary,
            content: const Text(
              'Dengê yekem tê amadekirin (~60s). Kerem bike bisekine.',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      });
    }

    try {
      // Cold start için 90sn, normal için 30sn timeout
      final timeout = isCold
          ? const Duration(seconds: 90)
          : const Duration(seconds: 30);
      final audioUrl = await tts.synthesize(requestText)
          .timeout(timeout, onTimeout: () => null);

      if (!mounted) return;
      // BAYAT İSTEK GUARD'I: await sırasında soru/metin değişti veya yeni
      // bir istek başladıysa ESKİ kelimenin sesi çalınmaz (HF cold-start
      // 90sn sürebilir; kullanıcı çoktan sonraki soruya geçmiş olabilir).
      if (gen != _generation || requestText != widget.text) return;

      if (audioUrl != null) {
        setState(() {
          _loading = false;
          _playing = true;
          _showColdHint = false;
        });
        SoundService.playClick();
        if (kIsWeb) {
          _playWebAudio(audioUrl);
        } else {
          // Mobil: just_audio üzerinden çal (asset: öneki mobilde gelmez —
          // tts_service manifest hit'lerini uzak URL'ye çevirir).
          final audio = ref.read(audioServiceProvider.notifier);
          final rate = _slowMode ? 0.75 : 1.0;
          if (audioUrl.startsWith('asset:')) {
            audio.playAsset(audioUrl.substring('asset:'.length), speed: rate);
          } else {
            audio.playUrl(audioUrl, speed: rate);
          }
        }
      } else {
        // Ses üretilemedi — kullanıcıya görsel + metin bilgi
        setState(() {
          _loading = false;
          _failed = true;
          _showColdHint = false;
        });
        // FAILURE FEEDBACK (Mayıs 2026): user "neden çalmadı" anlayabilsin.
        // Sessiz fail yerine snackbar ile açıklama. HF cold start veya
        // network problemi olabilir; tekrar denemesi için bilgi.
        final messenger = ScaffoldMessenger.maybeOf(context);
        messenger?.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
            // Kontrast: beyaz metin errorSoft üzerinde WCAG AA altında
            // kalıyordu — koyu zemin + tema beyaz metni okunur.
            backgroundColor: AppColors.textPrimary,
            content: const Text(
              'Deng nehate amadekirin. Kerem bike çend çirkeyan paşê dîsa biceribîne.',
            ),
          ),
        );
        Future<void>.delayed(const Duration(seconds: 4), () {
          if (mounted) setState(() => _failed = false);
        });
        return;
      }
    } catch (e) {
      if (mounted && gen == _generation) {
        setState(() {
          _loading = false;
          _failed = true;
          _showColdHint = false;
        });
        if (kDebugMode) debugPrint('SpeakButton error: $e');
        final messenger = ScaffoldMessenger.maybeOf(context);
        messenger?.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
            // Kontrast: beyaz metin errorSoft üzerinde WCAG AA altında
            // kalıyordu — koyu zemin + tema beyaz metni okunur.
            backgroundColor: AppColors.textPrimary,
            content: const Text(
              'Çêbûna deng bi ser neket. Girêdana înternetê kontrol bike.',
            ),
          ),
        );
        Future<void>.delayed(const Duration(seconds: 4), () {
          if (mounted) setState(() => _failed = false);
        });
        return;
      }
    }

    // Tahmini ses süresi sonrası playing durumunu kapat.
    // Nesil kontrolü: eski sorunun timer'ı yeni sorunun playing
    // animasyonunu söndürmesin.
    final estimatedDuration = (requestText.split(' ').length * 0.5 + 1.5)
        .clamp(2.0, 8.0)
        .toInt();
    Future.delayed(Duration(seconds: estimatedDuration), () {
      if (mounted && gen == _generation) setState(() => _playing = false);
    });
  }

  /// İngilizce için: browser'ın yerleşik speechSynthesis API'sini kullan.
  /// Tek merkezi helper (EnTtsHelper) üzerinden akar — DRY.
  void _speakEnglishBrowser(String text) {
    final rate = _slowMode ? 0.7 : 1.0;
    EnTtsHelper.speak(text, rate: rate);
  }

  void _playWebAudio(String url) {
    if (!kIsWeb) return;
    // Flutter web asset yapısı: build/web/assets/assets/audio/words/X.wav
    // yani pubspec'teki "assets/audio/..." runtime'da "assets/assets/audio/..."
    // olarak sunulur. Primary URL bu olur; fallback tek katman.
    String primary = url;
    String? fallback;
    if (url.startsWith('asset:')) {
      final assetPath = url.substring('asset:'.length);
      // Primary: çift katman (Flutter web gerçek konvansiyonu)
      primary = assetPath.startsWith('assets/')
          ? 'assets/$assetPath'
          : 'assets/$assetPath';
      // Fallback: tek katman (bazı hosting konfigürasyonlarında)
      fallback = assetPath;
    }
    final rate = _slowMode ? 0.75 : 1.0;
    // lutkeKey: bu sesi başlatan metnin damgası — dispose'ta yalnızca
    // kendi sesini durdurabilmek için (_stopIfCurrent).
    final key = _escapeForJs(widget.text);
    // Concurrency: window.__lutkeAudio'da önceki oynatma varsa durdur.
    // Bu sayede kullanıcı butona hızlı hızlı bassa ses üst üste binmez.
    // preservesPitch=true → perde korunur, sadece hız değişir.
    // Error olursa fallback URL'e geç.
    _evalJs('''
      (function() {
        try {
          if (window.__lutkeAudio) {
            try { window.__lutkeAudio.pause(); } catch(e){}
            try { window.__lutkeAudio.currentTime = 0; } catch(e){}
            window.__lutkeAudio = null;
          }
        } catch(e) {}
        var a = new Audio('$primary');
        a.playbackRate = $rate;
        a.preservesPitch = true;
        a.mozPreservesPitch = true;
        a.webkitPreservesPitch = true;
        a.lutkeKey = '$key';
        window.__lutkeAudio = a;
        a.onerror = function() {
          ${fallback != null ? '''
          var b = new Audio('$fallback');
          b.playbackRate = $rate;
          b.preservesPitch = true;
          b.mozPreservesPitch = true;
          b.webkitPreservesPitch = true;
          b.lutkeKey = '$key';
          window.__lutkeAudio = b;
          b.play().catch(function(e) { console.log('Audio fallback error:', e); });
          ''' : "console.log('Audio error — no fallback');"}
        };
        a.play().catch(function(e) { console.log('Audio play error:', e); });
      })();
    ''');
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

    // WCAG 2.1 4.1.2 — Screen reader için Semantic etiketi
    final lang = _resolvedLang();
    final semanticLabel = lang == 'en'
        ? 'Listen to English: ${widget.text}'
        : 'Dengê peyvê bibihîze: ${widget.text}';
    final tooltipMsg = lang == 'en'
        ? 'Tap: normal speed\nLong-press: slow (0.70x)'
        : 'Bitikîne: leza normal\nDirêj bigire: hêdî (0.75x)';

    Widget button = Semantics(
      button: true,
      label: semanticLabel,
      enabled: !_loading,
      child: GestureDetector(
        onTap: () => _speak(slow: false),
        onLongPress: () => _speak(slow: true),
        child: Tooltip(
          message: tooltipMsg,
          waitDuration: const Duration(milliseconds: 800),
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
              ? 'Deng tune — dîsa biceribîne'
              : _showColdHint
                  ? 'Amade dibe… (~60s)' // İlk seslendirme HF uyanmasını bekler
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
  final String lang; // 'ku' (default) veya 'en'

  const LargeSpeakButton({
    super.key,
    required this.text,
    this.subtitle,
    this.lang = 'ku',
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
          SpeakButton(text: text, size: 52, color: AppColors.primary, lang: lang),
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
