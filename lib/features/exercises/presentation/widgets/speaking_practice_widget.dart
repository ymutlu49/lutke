import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/services/asr_service.dart';
import '../../../../core/services/audio_service.dart';
import '../../../../core/services/tts_service.dart';
import '../../../../core/services/tts_source_preferences.dart';
import '../../../../core/utils/fsrs_algorithm.dart';
import '../../../../shared/providers/language_mode_provider.dart';
import '../../../../shared/services/skill_progress_service.dart';
import '../../../lessons/domain/entities/exercise.dart';

// ════════════════════════════════════════════════════════════════
// KONUŞMA PRATİĞİ — LÛTKE
//
// İlke §5.5 (MVP versiyonu):
//   1. Anadil konuşucusu sesini dinle
//   2. Konuş — mikrofon otomatik dinler (web SpeechRecognition)
//   3. Otomatik skor + transkript göster (deneysel, tr-TR yakın fallback)
//   4. Kullanıcı öz-değerlendirmeyi onaylar/değiştirir (son söz onda)
//
// Otomatik değerlendirme (Temmuz 2026): AsrService ile tarayıcı
// SpeechRecognition kullanılır. Destek/izin/ağ hatası durumunda SESSİZCE
// eski akışa düşülür: sahte kayıt toggle + öz-değerlendirme.
// İlke §3.1: Heritage kullanıcı "yanlış" yerine "çok yakın" tonu.
// ════════════════════════════════════════════════════════════════

class SpeakingPracticeWidget extends ConsumerStatefulWidget {
  final SpeakingPracticeExercise exercise;
  final void Function(Rating rating) onRating;

  const SpeakingPracticeWidget({
    super.key,
    required this.exercise,
    required this.onRating,
  });

  @override
  ConsumerState<SpeakingPracticeWidget> createState() =>
      _SpeakingPracticeWidgetState();
}

class _SpeakingPracticeWidgetState
    extends ConsumerState<SpeakingPracticeWidget> {
  _SpeakingPhase _phase = _SpeakingPhase.listen;
  bool _isRecording = false;
  int? _selfAssessment; // 0=kötü, 1=yakın, 2=iyi
  bool _isShadowReading = false; // Shadow reading mode
  String? _encouragementMessage; // Kurmanci encouragement after attempt

  // Otomatik telaffuz değerlendirmesi (deneysel).
  // null = ASR yapılamadı → eski öz-değerlendirme akışı aynen çalışır.
  PronunciationResult? _asrResult;

  // Tek seferlik ilerleme kaydı — beceri panosundaki 'speaking' sayacı
  // bu egzersiz tamamlanınca da beslensin (İLERLEME FIX).
  bool _progressRecorded = false;

  // Kurmancî encouragement messages (Kurmancî-only, no Turkish)
  static const _encouragements = [
    'Pir baş!',          // Very good!
    'Berdewam bike!',    // Keep going!
    'Dengê te xweş e!',  // Your voice is nice!
    'Pîroz be!',         // Well done!
    'Bes baş e!',        // Good enough!
  ];

  SpeakingPracticeExercise get _ex => widget.exercise;

  /// Kurmancî TTS — yalnızca HuggingFace amedcj/kmr_tts kullanır.
  /// Türkçe veya başka browser fallback YOKTUR (yanlış telaffuz olmasın).
  /// HF başarısızsa sessiz geçer; UI kullanıcıyı rahatsız etmez.
  Future<void> _playKurmanciTts(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    try {
      final tts = ref.read(ttsServiceProvider);
      // Kullanıcı TTS kaynak tercihini senkronize et (default assetFirst).
      // Profîl'den assetOnly/geminiFenrir seçilmişse bu widget'in de onurlandırması için.
      tts.source = ref.read(ttsSourceProvider);
      final audioUrl = await tts.synthesize(trimmed);
      if (audioUrl == null || !mounted) return;
      final audio = ref.read(audioServiceProvider.notifier);
      if (audioUrl.startsWith('asset:')) {
        await audio.playAsset(audioUrl.substring('asset:'.length));
      } else {
        await audio.playUrl(audioUrl);
      }
    } catch (_) {
      // Sessiz geç — yanlış telaffuz yerine susmak tercih edilir
    }
  }

  void _playReference() {
    if (_ex.audioAsset != null) {
      ref.read(audioServiceProvider.notifier).playAsset(_ex.audioAsset!);
    }
    setState(() {
      if (_phase == _SpeakingPhase.listen) {
        _phase = _SpeakingPhase.record;
      }
    });
  }

  void _toggleRecording() {
    if (_isRecording) {
      // Elle durduruldu — aktif ASR varsa iptal, öz-değerlendirmeye düş
      AsrService.cancel();
      _finishRecording(null);
      return;
    }
    setState(() {
      _isRecording = true;
      _encouragementMessage = null;
      _asrResult = null;
    });
    if (AsrService.isSupported) {
      // Otomatik değerlendirme: mikrofonu dinle, hedefle karşılaştır.
      // Konuşma bitince (sessizlik) tarayıcı kendiliğinden durur.
      _runAutoAssess();
    }
    // Desteklenmiyorsa eski davranış: ikinci dokunuş compare'e geçirir.
  }

  /// Tarayıcı SpeechRecognition ile otomatik skor (deneysel).
  /// Her türlü hatada sessizce skorsuz devam edilir.
  Future<void> _runAutoAssess() async {
    // Kurmancî için tarayıcı dili yok — tr-TR yakın fallback (yaklaşık).
    final result = await AsrService.assess(target: _ex.targetText);
    if (!mounted || !_isRecording) return; // iptal edildi / ekran kapandı
    if (result == null) {
      // Sessiz fallback: mikrofon izni/destek/ağ hatası — kayıt modunda
      // kal, kullanıcı eski akıştaki gibi elle durdurup öz-değerlendirir.
      return;
    }
    _finishRecording(result);
  }

  /// Kayıt aşamasını bitir, karşılaştırma fazına geç.
  /// [result] null ise otomatik skor yok — eski öz-değerlendirme akışı.
  void _finishRecording(PronunciationResult? result) {
    setState(() {
      _isRecording = false;
      _asrResult = result;
      if (result != null) {
        // Otomatik skor → öz-değerlendirme önerisi (kullanıcı değiştirebilir)
        _selfAssessment = switch (result.verdict) {
          PronunciationVerdict.excellent => 2,
          PronunciationVerdict.close => 1,
          PronunciationVerdict.tryAgain => 0,
        };
        // Heritage tonu (§3.1): "yanlış" deme, cesaretlendir
        _encouragementMessage = switch (result.verdict) {
          PronunciationVerdict.excellent => 'Pir baş! 🎉',
          PronunciationVerdict.close => 'Nêzîk bû — berdewam bike!',
          PronunciationVerdict.tryAgain => 'Dîsa biceribîne — hêdî hêdî',
        };
      } else {
        _encouragementMessage =
            _encouragements[Random().nextInt(_encouragements.length)];
      }
      _phase = _SpeakingPhase.compare;
    });
  }

  /// Karşılaştırma fazından kayıt fazına geri dön (yeniden dene).
  void _retryRecording() {
    AsrService.cancel();
    setState(() {
      _phase = _SpeakingPhase.record;
      _isRecording = false;
      _asrResult = null;
      _selfAssessment = null;
      _encouragementMessage = null;
    });
  }

  @override
  void dispose() {
    AsrService.cancel();
    super.dispose();
  }

  /// Start shadow reading: TTS plays, user repeats simultaneously
  void _startShadowReading() {
    setState(() => _isShadowReading = true);
    _playKurmanciTts(_ex.targetText);
    // Reset after estimated duration
    final words = _ex.targetText.split(' ').length;
    final durationSec = ((words * 0.6 + 2.0)).clamp(3.0, 10.0).toInt();
    Future.delayed(Duration(seconds: durationSec), () {
      if (mounted) setState(() => _isShadowReading = false);
    });
  }

  void _assess(int score) {
    setState(() => _selfAssessment = score);
  }

  @override
  Widget build(BuildContext context) {
    final audioState = ref.watch(audioServiceProvider);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          // Başlık
          Text(
            'Bêje û guhdarî bike',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            ref.watch(showTurkishProvider)
                ? 'Söyle ve dinle'
                : 'Speak and listen',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary.withOpacity(0.6),
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppSpacing.xl),

          // Hedef metin kartı
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  _ex.targetText,
                  style: AppTypography.displayMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (_ex.targetTranslation != null &&
                    ref.watch(showTurkishProvider)) ...[
                  const SizedBox(height: 8),
                  Text(
                    _ex.targetTranslation!,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Encouragement message (shown after recording attempt)
          if (_encouragementMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF4CAF50).withOpacity(0.3),
                  ),
                ),
                child: Text(
                  _encouragementMessage!,
                  style: AppTypography.kurmanji.copyWith(
                    color: const Color(0xFF4CAF50),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ).animate().fadeIn(duration: 300.ms).scale(
                  begin: const Offset(0.8, 0.8),
                  duration: 400.ms,
                  curve: Curves.elasticOut,
                ),

          // 3 aşamalı akış
          _PhaseIndicator(phase: _phase),

          const SizedBox(height: AppSpacing.lg),

          // Aşamaya göre içerik
          Expanded(
            child: switch (_phase) {
              _SpeakingPhase.listen => _ListenPhase(
                  onPlay: _playReference,
                  isPlaying: audioState.isPlaying,
                  showTurkish: ref.watch(showTurkishProvider),
                ),
              _SpeakingPhase.record => _RecordPhase(
                  onToggleRecord: _toggleRecording,
                  isRecording: _isRecording,
                  isShadowReading: _isShadowReading,
                  onPlayReference: _playReference,
                  onShadowRead: _startShadowReading,
                  showTurkish: ref.watch(showTurkishProvider),
                ),
              _SpeakingPhase.compare => _ComparePhase(
                  onPlayReference: _playReference,
                  onRetry: _retryRecording,
                  asrResult: _asrResult,
                  assessment: _selfAssessment,
                  onAssess: _assess,
                  showTurkish: ref.watch(showTurkishProvider),
                  targetText: _ex.targetText,
                ),
            },
          ),

          // FSRS derecelendirme (sadece değerlendirme yapıldıysa)
          if (_selfAssessment != null)
            _buildRatingFromAssessment()
          else if (_phase == _SpeakingPhase.compare)
            const SizedBox.shrink()
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildRatingFromAssessment() {
    // Kullanıcının öz-değerlendirmesini FSRS'e dönüştür
    final rating = switch (_selfAssessment!) {
      0 => Rating.again,
      1 => Rating.hard,
      _ => Rating.good,
    };

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: ElevatedButton(
        onPressed: () {
          // İLERLEME FIX: Konuşma pratiği beceri panosuna hiç işlenmiyordu —
          // değerlendirme onaylanınca 'speaking' (Axaftin) sayacına yazılır.
          if (!_progressRecorded) {
            _progressRecorded = true;
            markSkillCompletedAndNotify(ref,
                module: 'ku', skill: 'speaking', xp: 8);
          }
          widget.onRating(rating);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          'Dûv re',
          style: AppTypography.labelLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// ── Aşama Enum ────────────────────────────────────────────────

enum _SpeakingPhase { listen, record, compare }

// ── Aşama Göstergesi ──────────────────────────────────────────

class _PhaseIndicator extends StatelessWidget {
  final _SpeakingPhase phase;
  const _PhaseIndicator({required this.phase});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _dot('Guhdarî bike', 0, phase.index),
        _line(phase.index >= 1),
        _dot('Tomar bike', 1, phase.index),
        _line(phase.index >= 2),
        _dot('Bide ber hev', 2, phase.index),
      ],
    );
  }

  Widget _dot(String label, int step, int current) {
    final isActive = step <= current;
    return Column(
      children: [
        Container(
          width: 28, height: 28,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.backgroundSecondary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${step + 1}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isActive ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
              fontSize: 9,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
            )),
      ],
    );
  }

  Widget _line(bool active) {
    return Container(
      width: 30, height: 2,
      margin: const EdgeInsets.only(bottom: 16),
      color: active ? AppColors.primary : AppColors.border,
    );
  }
}

// ── Dinleme Aşaması ───────────────────────────────────────────

class _ListenPhase extends StatelessWidget {
  final VoidCallback onPlay;
  final bool isPlaying;
  final bool showTurkish;

  const _ListenPhase({required this.onPlay, required this.isPlaying, required this.showTurkish});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            showTurkish
                ? 'Anadil konuşucusunu dinle:'
                : 'Listen to the native speaker:',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          GestureDetector(
            onTap: onPlay,
            child: Container(
              width: 96, height: 96,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                    color: AppColors.primary.withOpacity(0.3), width: 2),
              ),
              child: Icon(
                isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                size: 48,
                color: AppColors.primary,
              ),
            ),
          ).animate(
            onComplete: (controller) => controller.repeat(reverse: true),
          ).scale(
            begin: const Offset(1, 1),
            end: const Offset(1.06, 1.06),
            duration: 1200.ms,
          ),
        ],
      ),
    );
  }
}

// ── Kayıt Aşaması ─────────────────────────────────────────────

class _RecordPhase extends StatelessWidget {
  final VoidCallback onToggleRecord;
  final bool isRecording;
  final bool isShadowReading;
  final VoidCallback onPlayReference;
  final VoidCallback onShadowRead;
  final bool showTurkish;

  const _RecordPhase({
    required this.onToggleRecord,
    required this.isRecording,
    required this.isShadowReading,
    required this.onPlayReference,
    required this.onShadowRead,
    required this.showTurkish,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isRecording
                ? (showTurkish ? 'Dinliyorum...' : 'Guhdarî dikim...')
                : isShadowReading
                    ? (showTurkish ? 'Birlikte tekrarla!' : 'Bi hev re dubare bike!')
                    : (showTurkish ? 'Şimdi sen söyle:' : 'Niha tu bêje:'),
            style: AppTypography.bodyMedium.copyWith(
              color: isRecording
                  ? AppColors.accent
                  : isShadowReading
                      ? AppColors.primary
                      : AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          GestureDetector(
            onTap: onToggleRecord,
            child: Container(
              width: 96, height: 96,
              decoration: BoxDecoration(
                color: isRecording
                    ? const Color(0xFFEF5350).withOpacity(0.1)
                    : AppColors.accent.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isRecording
                      ? const Color(0xFFEF5350)
                      : AppColors.accent.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Icon(
                isRecording ? Icons.stop_rounded : Icons.mic_rounded,
                size: 48,
                color: isRecording
                    ? const Color(0xFFEF5350)
                    : AppColors.accent,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Action buttons row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Yeniden dinle butonu
              TextButton.icon(
                onPressed: onPlayReference,
                icon: Icon(Icons.replay, size: 16, color: AppColors.primary),
                label: Text(
                  'Dîsa guhdarî bike',
                  style: AppTypography.caption.copyWith(color: AppColors.primary),
                ),
              ),
              const SizedBox(width: 8),
              // Shadow reading button
              TextButton.icon(
                onPressed: isShadowReading ? null : onShadowRead,
                icon: Icon(
                  Icons.record_voice_over_rounded,
                  size: 16,
                  color: isShadowReading
                      ? AppColors.primary.withOpacity(0.4)
                      : AppColors.accent,
                ),
                label: Text(
                  isShadowReading ? 'Bi hev re...' : 'Bi hev re bixwîne',
                  style: AppTypography.caption.copyWith(
                    color: isShadowReading
                        ? AppColors.accent.withOpacity(0.4)
                        : AppColors.accent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Karşılaştırma Aşaması ─────────────────────────────────────

class _ComparePhase extends StatelessWidget {
  final VoidCallback onPlayReference;
  final VoidCallback onRetry;
  final PronunciationResult? asrResult;
  final int? assessment;
  final ValueChanged<int> onAssess;
  final bool showTurkish;
  final String targetText;

  const _ComparePhase({
    required this.onPlayReference,
    required this.onRetry,
    required this.asrResult,
    required this.assessment,
    required this.onAssess,
    required this.showTurkish,
    required this.targetText,
  });

  /// Split text into syllable-like chunks for highlighting
  List<String> _splitSyllables(String text) {
    final words = text.split(' ');
    final syllables = <String>[];
    for (final word in words) {
      if (word.length <= 3) {
        syllables.add(word);
      } else {
        // Simple syllable split: every 2-3 chars
        int i = 0;
        while (i < word.length) {
          final remaining = word.length - i;
          final chunkLen = remaining <= 4 ? remaining : (remaining > 5 ? 3 : 2);
          syllables.add(word.substring(i, i + chunkLen));
          i += chunkLen;
        }
        // Add space marker after word (except last)
        if (word != words.last) syllables.add(' ');
      }
      if (word != words.last && (word.length <= 3)) {
        syllables.add(' ');
      }
    }
    return syllables;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Syllable-highlighted target text
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: _splitSyllables(targetText).asMap().entries.map((entry) {
                final idx = entry.key;
                final syl = entry.value;
                if (syl == ' ') return const SizedBox(width: 6);
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08 + (idx % 3) * 0.04),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.15),
                    ),
                  ),
                  child: Text(
                    syl,
                    style: AppTypography.kurmanji.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ).animate().fadeIn(
                      delay: Duration(milliseconds: idx * 60),
                      duration: 200.ms,
                    );
              }).toList(),
            ),
          ),

          // Otomatik değerlendirme sonucu (varsa)
          if (asrResult != null) ...[
            _AsrResultCard(result: asrResult!, showTurkish: showTurkish),
            const SizedBox(height: AppSpacing.md),
          ],

          Text(
            showTurkish ? 'İkisini karşılaştır:' : 'Herduyan bide ber hev:',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Referans dinle + yeniden dene butonları
          // (Kayıt playback'i yok — SpeechRecognition ham sesi vermez;
          //  ölü "Dengê te" butonu yerine dürüst "yeniden dene" akışı.)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _compareBtn(
                showTurkish ? 'Anadil' : 'Zimanê zikmakî',
                Icons.record_voice_over_outlined,
                AppColors.primary,
                onPlayReference,
              ),
              _compareBtn(
                showTurkish ? 'Tekrar söyle' : 'Dîsa bêje',
                Icons.mic_outlined,
                AppColors.accent,
                onRetry,
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.xl),

          // Oz degerlendirme
          Text(
            showTurkish ? 'Nasıl hissettirdi?' : 'Çawa hîs kir?',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _assessBtn(0, 'Dîsa biceribîne',
                  showTurkish ? 'Tekrar dene' : 'Dîsa biceribîne',
                  const Color(0xFFFF9800), Icons.replay_rounded),
              const SizedBox(width: 12),
              _assessBtn(1, 'Nêzîk bû',
                  showTurkish ? 'Yakındı' : 'Nêzîk bû',
                  AppColors.primary, Icons.thumb_up_outlined),
              const SizedBox(width: 12),
              _assessBtn(2, 'Gelek baş!',
                  showTurkish ? 'Çok iyi!' : 'Gelek baş!',
                  const Color(0xFF4CAF50), Icons.stars_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _compareBtn(
      String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Icon(icon, size: 28, color: color),
          ),
          const SizedBox(height: 6),
          Text(label,
              style: AppTypography.caption.copyWith(color: color)),
        ],
      ),
    );
  }

  Widget _assessBtn(
      int score, String labelKu, String labelTr,
      Color color, IconData icon) {
    final isSelected = assessment == score;
    return GestureDetector(
      onTap: () => onAssess(score),
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.15) : color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : color.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(labelKu,
                style: TextStyle(
                    fontSize: 11, fontWeight: FontWeight.w700, color: color)),
            if (showTurkish)
              Text(labelTr,
                  style: TextStyle(
                      fontSize: 9, color: color.withOpacity(0.7))),
          ],
        ),
      ),
    );
  }
}

// ── Otomatik Değerlendirme Sonuç Kartı (deneysel) ─────────────

class _AsrResultCard extends StatelessWidget {
  final PronunciationResult result;
  final bool showTurkish;

  const _AsrResultCard({required this.result, required this.showTurkish});

  @override
  Widget build(BuildContext context) {
    // Heritage tonu (§3.1): kırmızı "yanlış" yok, cesaretlendirici renkler
    final (color, label) = switch (result.verdict) {
      PronunciationVerdict.excellent =>
        (const Color(0xFF4CAF50), 'Pir baş! 🎉'),
      PronunciationVerdict.close => (const Color(0xFFFF9800), 'Nêzîk bû!'),
      PronunciationVerdict.tryAgain =>
        (const Color(0xFFFF9800), 'Dîsa biceribîne'),
    };
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            '$label  %${result.percent}',
            style: AppTypography.bodyMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          if (result.transcript.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              showTurkish
                  ? 'Duyduğumuz: "${result.transcript}"'
                  : 'Me bihîst: "${result.transcript}"',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (result.isApproximate) ...[
            const SizedBox(height: 4),
            Text(
              showTurkish
                  ? 'Otomatik değerlendirme yaklaşıktır (deneysel)'
                  : 'Nirxandina otomatîk nêzîkî ye (ceribandin)',
              style: AppTypography.caption.copyWith(
                fontSize: 10,
                color: AppColors.textSecondary.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 250.ms);
  }
}
