import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/services/audio_service.dart';
import '../../../../core/utils/fsrs_algorithm.dart';
import '../../../../shared/providers/language_mode_provider.dart';
import '../../../lessons/domain/entities/exercise.dart';

// ════════════════════════════════════════════════════════════════
// KONUŞMA PRATİĞİ — LÛTKE
//
// İlke §5.5 (MVP versiyonu):
//   1. Anadil konuşucusu sesini dinle
//   2. Kendi sesini kaydet
//   3. İkisini karşılaştır
//   4. Kullanıcı kendi değerlendirmesini yapar
//
// İlke §0.4 (Katman 2): Otomatik ses analizi Faz 3+'da.
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
  bool _hasRecording = false;
  int? _selfAssessment; // 0=kötü, 1=yakın, 2=iyi

  SpeakingPracticeExercise get _ex => widget.exercise;

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
    setState(() {
      if (_isRecording) {
        _isRecording = false;
        _hasRecording = true;
        _phase = _SpeakingPhase.compare;
      } else {
        _isRecording = true;
      }
    });
    // TODO: record paketi ile gerçek kayıt
  }

  void _playRecording() {
    // TODO: Kaydedilen sesi çal
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
                  onPlayReference: _playReference,
                  showTurkish: ref.watch(showTurkishProvider),
                ),
              _SpeakingPhase.compare => _ComparePhase(
                  onPlayReference: _playReference,
                  onPlayRecording: _playRecording,
                  assessment: _selfAssessment,
                  onAssess: _assess,
                  showTurkish: ref.watch(showTurkishProvider),
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
        onPressed: () => widget.onRating(rating),
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
  final VoidCallback onPlayReference;
  final bool showTurkish;

  const _RecordPhase({
    required this.onToggleRecord,
    required this.isRecording,
    required this.onPlayReference,
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
                ? (showTurkish ? 'Dinliyorum...' : 'Listening...')
                : (showTurkish ? 'Şimdi sen söyle:' : 'Now you speak:'),
            style: AppTypography.bodyMedium.copyWith(
              color: isRecording ? AppColors.accent : AppColors.textSecondary,
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
          // Yeniden dinle butonu
          TextButton.icon(
            onPressed: onPlayReference,
            icon: Icon(Icons.replay, size: 16, color: AppColors.primary),
            label: Text(
              'Dîsa guhdarî bike',
              style: AppTypography.caption.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Karşılaştırma Aşaması ─────────────────────────────────────

class _ComparePhase extends StatelessWidget {
  final VoidCallback onPlayReference;
  final VoidCallback onPlayRecording;
  final int? assessment;
  final ValueChanged<int> onAssess;
  final bool showTurkish;

  const _ComparePhase({
    required this.onPlayReference,
    required this.onPlayRecording,
    required this.assessment,
    required this.onAssess,
    required this.showTurkish,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          showTurkish ? 'İkisini karşılaştır:' : 'Compare the two:',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // İki ses butonu
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _compareBtn(
              showTurkish ? 'Anadil' : 'Native',
              Icons.record_voice_over_outlined,
              AppColors.primary,
              onPlayReference,
            ),
            _compareBtn(
              showTurkish ? 'Senin sesin' : 'Your voice',
              Icons.mic_outlined,
              AppColors.accent,
              onPlayRecording,
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        // Öz değerlendirme
        Text(
          showTurkish ? 'Nasıl hissettirdi?' : 'How did it feel?',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _assessBtn(0, 'Dîsa bicerib',
                showTurkish ? 'Tekrar dene' : 'Try again',
                const Color(0xFFFF9800), Icons.replay_rounded),
            const SizedBox(width: 12),
            _assessBtn(1, 'Nêzîk bû',
                showTurkish ? 'Yakındı' : 'Close',
                AppColors.primary, Icons.thumb_up_outlined),
            const SizedBox(width: 12),
            _assessBtn(2, 'Gelek baş!',
                showTurkish ? 'Çok iyi!' : 'Very good!',
                const Color(0xFF4CAF50), Icons.stars_rounded),
          ],
        ),
      ],
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
            Text(labelTr,
                style: TextStyle(
                    fontSize: 9, color: color.withOpacity(0.7))),
          ],
        ),
      ),
    );
  }
}
