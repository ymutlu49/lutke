import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/asr_service.dart';
import '../../../core/services/sound_service.dart';
import '../../../shared/providers/learning_module_provider.dart';
import '../../../shared/services/skill_progress_service.dart';
import '../../../shared/widgets/speak_button.dart';
import '../../en_learning/presentation/en_coming_soon_screen.dart';
import '../../gamification/gamification_provider.dart';
import '../../lessons/domain/a1_kelime_db.dart';
import '../../lessons/domain/a2_kelime_db.dart';
import '../../lessons/domain/b1_kelime_db.dart';
import '../../lessons/domain/b2_kelime_db.dart';
import '../../lessons/domain/c1_kelime_db.dart';
import '../../lessons/domain/c2_kelime_db.dart';

// ════════════════════════════════════════════════════════════════
// BILÊVKİRIN — Telaffuz Pratiği
//
// Kullanıcı kelime ve cümleleri dinler, tekrar eder,
// kendini değerlendirir. TTS ile model telaffuz sağlanır.
//
// Akış: Dinle → Yavaş dinle → Tekrar et → Öz değerlendir
//
// YENİ (Temmuz 2026): Opsiyonel otomatik mikrofon kontrolü (deneysel).
// AsrService (tarayıcı SpeechRecognition, tr-TR yakın fallback) ile
// telaffuz otomatik skorlanır. Hata/destek yoksa SESSİZCE mevcut
// öz-değerlendirme akışı devam eder — otomatik kontrol sadece ek katman.
//
// Araştırma: Babbel repetition drills + self-assessment
// ════════════════════════════════════════════════════════════════

class PronunciationScreen extends ConsumerStatefulWidget {
  final String? category;
  final String level;

  const PronunciationScreen({super.key, this.category, this.level = 'A1'});

  @override
  ConsumerState<PronunciationScreen> createState() =>
      _PronunciationScreenState();
}

class _PronunciationScreenState extends ConsumerState<PronunciationScreen> {
  late List<_PronunciationItem> _items;
  int _currentIndex = 0;
  int _phase = 0; // 0: kelime, 1: cümle, 2: öz değerlendirme
  int _goodCount = 0;
  int _totalAttempts = 0;

  // Otomatik telaffuz kontrolü (deneysel) — hata durumunda sessizce
  // öz-değerlendirme akışına düşülür, kullanıcıya engel olmaz.
  bool _isListening = false;
  PronunciationResult? _asrResult;
  int _checkSeq = 0; // Geç dönen eski ASR future'larını ayıklamak için
  bool _progressRecorded = false; // Tek seferlik oturum sonu ilerleme kaydı

  @override
  void initState() {
    super.initState();
    _items = _generateItems();
  }

  @override
  void dispose() {
    AsrService.cancel();
    super.dispose();
  }

  /// Mikrofonla otomatik telaffuz kontrolü başlat/iptal et.
  Future<void> _startAutoCheck(String target) async {
    if (_isListening) {
      AsrService.cancel();
      setState(() => _isListening = false);
      return;
    }
    final seq = ++_checkSeq;
    setState(() {
      _isListening = true;
      _asrResult = null;
    });
    // Kurmancî için tarayıcı dili yok — tr-TR yakın fallback (yaklaşık).
    final result = await AsrService.assess(target: target);
    // Ekran kapandıysa veya bu arada yeni bir dinleme başladıysa dokunma
    if (!mounted || seq != _checkSeq) return;
    setState(() {
      _isListening = false;
      // null = hata/destek yok → kart gösterilmez, akış aynen devam eder
      _asrResult = result;
    });
    if (result != null &&
        result.verdict == PronunciationVerdict.excellent) {
      SoundService.playCorrect();
    }
  }

  /// Faz değiştir — aktif dinlemeyi iptal eder.
  /// [keepResult]: öz-değerlendirme fazında son skoru özet olarak göster.
  void _changePhase(int phase, {bool keepResult = false}) {
    AsrService.cancel();
    setState(() {
      _phase = phase;
      _isListening = false;
      if (!keepResult) _asrResult = null;
    });
  }

  String _verdictKu(PronunciationVerdict v) => switch (v) {
        PronunciationVerdict.excellent => 'Pir baş',
        PronunciationVerdict.close => 'Nêzîk bû',
        PronunciationVerdict.tryAgain => 'Dîsa biceribîne',
      };

  List<_PronunciationItem> _generateItems() {
    final words = _wordsForLevel(widget.level);
    final rng = Random();

    var pool = words.toList();
    if (widget.category != null && widget.category!.isNotEmpty) {
      final filtered = pool.where((w) => w.kat == widget.category).toList();
      if (filtered.length >= 3) pool = filtered;
    }

    final withSentences = pool
        .where(
            (w) => (w.her as List).isNotEmpty && (w.ku as String).length > 1)
        .toList()
      ..shuffle(rng);

    return withSentences.take(8).map((w) {
      final herList = (w.her as List).cast<String>();
      return _PronunciationItem(
        word: w.ku as String,
        translation: w.tr as String,
        sentence: herList[rng.nextInt(herList.length)],
      );
    }).toList();
  }

  void _safePop() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ── TRACK-AWARE GUARD ──────────────────────────────────
    // Bilêvkirin KU kelime + cümle havuzu — EN track için uygun değil.
    final isEn = ref.watch(isEnglishModuleProvider);
    if (isEn) {
      return const EnComingSoonScreen(
        activityKu: 'Bilêvkirin',
        suggestedRoute: '/en/speaking',
        suggestedLabel: 'EN Speaking',
      );
    }

    if (_items.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundPrimary, elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.close), onPressed: _safePop),
        ),
        body: Center(
          child: Text('Vê beşê de peyv bes nine.',
              style: AppTypography.body
                  .copyWith(color: AppColors.textSecondary)),
        ),
      );
    }

    if (_currentIndex >= _items.length) return _buildResultScreen();

    final item = _items[_currentIndex];

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _safePop,
                    child: Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                          color: AppColors.surface, shape: BoxShape.circle),
                      child: const Icon(Icons.close,
                          size: 18, color: AppColors.textSecondary),
                    ),
                  ),
                  const Spacer(),
                  Text('${_currentIndex + 1} / ${_items.length}',
                      style: AppTypography.label
                          .copyWith(color: AppColors.textSecondary)),
                ],
              ),
            ),

            // İlerleme
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (_currentIndex + 1) / _items.length,
                  backgroundColor: AppColors.primary.withOpacity(0.12),
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  minHeight: 6,
                ),
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Faz başlığı
                    Text(
                      switch (_phase) {
                        0 => 'Vê peyvê bilêv bike',
                        1 => 'Vê hevokê bilêv bike',
                        _ => 'Xwe binirxîne',
                      },
                      style: AppTypography.title.copyWith(
                          color: AppColors.primary, fontWeight: FontWeight.w700),
                    ).animate().fadeIn(),

                    const SizedBox(height: 32),

                    // Faz 0: Kelime telaffuzu
                    if (_phase == 0) ...[
                      _PronunciationCard(
                        text: item.word,
                        isLarge: true,
                      ).animate().fadeIn(delay: 200.ms),

                      const SizedBox(height: 24),

                      // Dinle butonları
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _ListenButton(
                            text: item.word,
                            label: 'Normal',
                            icon: Icons.volume_up_rounded,
                            slow: false,
                          ),
                          const SizedBox(width: 20),
                          _ListenButton(
                            text: item.word,
                            label: 'Hêdî',
                            icon: Icons.slow_motion_video_rounded,
                            slow: true,
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      Text('Guhdarî bike û dubare bike',
                          style: AppTypography.caption),

                      // Otomatik telaffuz kontrolü (deneysel, sadece web)
                      if (AsrService.isSupported) ...[
                        const SizedBox(height: 24),
                        _MicCheckButton(
                          isListening: _isListening,
                          onTap: () => _startAutoCheck(item.word),
                        ),
                        if (_asrResult != null) ...[
                          const SizedBox(height: 12),
                          _AsrFeedbackCard(result: _asrResult!),
                        ],
                      ],

                      const SizedBox(height: 32),
                      _buildNextButton('Hevokê jî biceribîne', () {
                        _changePhase(1);
                      }),
                    ],

                    // Faz 1: Cümle telaffuzu
                    if (_phase == 1) ...[
                      _PronunciationCard(
                        text: item.sentence,
                        isLarge: false,
                      ).animate().fadeIn(delay: 200.ms),

                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _ListenButton(
                            text: item.sentence,
                            label: 'Normal',
                            icon: Icons.volume_up_rounded,
                            slow: false,
                          ),
                          const SizedBox(width: 20),
                          _ListenButton(
                            text: item.sentence,
                            label: 'Hêdî',
                            icon: Icons.slow_motion_video_rounded,
                            slow: true,
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      Text('Guhdarî bike û bi dengê bilind dubare bike',
                          style: AppTypography.caption),

                      // Otomatik telaffuz kontrolü (deneysel, sadece web)
                      if (AsrService.isSupported) ...[
                        const SizedBox(height: 24),
                        _MicCheckButton(
                          isListening: _isListening,
                          onTap: () => _startAutoCheck(item.sentence),
                        ),
                        if (_asrResult != null) ...[
                          const SizedBox(height: 12),
                          _AsrFeedbackCard(result: _asrResult!),
                        ],
                      ],

                      const SizedBox(height: 32),
                      _buildNextButton('Xwe binirxîne', () {
                        // Son otomatik skor öz-değerlendirmede özet olarak kalsın
                        _changePhase(2, keepResult: true);
                      }),
                    ],

                    // Faz 2: Öz değerlendirme
                    if (_phase == 2) ...[
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: Column(
                          children: [
                            Text('Bilêvkirina te çawa bû?',
                                style: AppTypography.title),
                            const SizedBox(height: 8),
                            // Pedagojik not: öz-değerlendirme ölçme değil,
                            // alıştırma amaçlıdır. Kullanıcıyı bilgilendir.
                            Text(
                              'Ev ceribandinek e — dengê xwe bi modelê re bide ber hev.',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            // Otomatik kontrol yapıldıysa son skoru özetle
                            if (_asrResult != null) ...[
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Mîkrofon: %${_asrResult!.percent} — '
                                  '${_verdictKu(_asrResult!.verdict)}',
                                  style: AppTypography.caption
                                      .copyWith(color: AppColors.primary),
                                ),
                              ),
                            ],
                            const SizedBox(height: 16),
                            _AssessmentButton(
                              emoji: '😊',
                              label: 'Baş bû',
                              desc: 'Min baş bilêv kir',
                              color: AppColors.success,
                              onTap: () {
                                SoundService.playCorrect();
                                _goodCount++;
                                _totalAttempts++;
                                _nextItem();
                              },
                            ),
                            const SizedBox(height: 12),
                            _AssessmentButton(
                              emoji: '🤔',
                              label: 'Navîn bû',
                              desc: 'Divê ez bêtir biceribînim',
                              color: AppColors.warning,
                              onTap: () {
                                SoundService.playTap();
                                _totalAttempts++;
                                _nextItem();
                              },
                            ),
                            const SizedBox(height: 12),
                            _AssessmentButton(
                              emoji: '😅',
                              label: 'Dijwar bû',
                              desc: 'Divê ez dîsa guhdarî bikim',
                              color: AppColors.errorSoft,
                              onTap: () {
                                SoundService.playTap();
                                _totalAttempts++;
                                // Kelimeye geri dön
                                _changePhase(0);
                              },
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 200.ms),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(String label, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(label,
            style: AppTypography.labelLarge.copyWith(color: Colors.white)),
      ),
    );
  }

  void _nextItem() {
    AsrService.cancel();
    setState(() {
      _currentIndex++;
      _phase = 0;
      _isListening = false;
      _asrResult = null;
    });
  }

  Widget _buildResultScreen() {
    // İLERLEME FIX: Bilêvkirin oturumu tamamlanınca hiçbir XP/istatistik
    // yazılmıyordu — kullanıcı "hiç ilerleme olmuyor" görüyordu. Oturum
    // sonunda bir kez XP + beceri panosu ('speaking' / Axaftin) kaydı yazılır.
    if (!_progressRecorded) {
      _progressRecorded = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        // Taban 10 XP + her "Baş bû" için konuşma bonusu (XPRules.speakingPractice)
        ref
            .read(gamificationProvider.notifier)
            .addXP(10 + _goodCount * XPRules.speakingPractice);
        markSkillCompletedAndNotify(ref,
            module: 'ku', skill: 'speaking', xp: 10);
      });
    }
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🎤', style: TextStyle(fontSize: 64))
                  .animate()
                  .scale(begin: const Offset(0.5, 0.5),
                      curve: Curves.elasticOut),
              const SizedBox(height: 24),
              Text('Pîroz be!',
                  style: AppTypography.display
                      .copyWith(color: AppColors.primary))
                  .animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 12),
              Text(
                '$_goodCount / $_totalAttempts baş bilêv kirin',
                style: AppTypography.headline
                    .copyWith(color: AppColors.textSecondary),
              ).animate().fadeIn(delay: 500.ms),
              const SizedBox(height: 8),
              Text(
                '${_items.length} peyv û hevok biceribîn',
                style: AppTypography.body
                    .copyWith(color: AppColors.textTertiary),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _safePop,
                child: const Text('Vegere'),
              ).animate().fadeIn(delay: 700.ms),
            ],
          ),
        ),
      ),
    );
  }

  List<dynamic> _wordsForLevel(String level) =>
      switch (level.toUpperCase()) {
        'A1' => kA1TamListe,
        'A2' => kA2TamListe,
        'B1' => kB1All,
        'B2' => kB2All,
        'C1' => kC1All,
        'C2' => kC2All,
        _ => kA1TamListe,
      };
}

// ── Telaffuz Kartı ──────────────────────────────────────────

class _PronunciationCard extends StatelessWidget {
  final String text;
  final bool isLarge;

  const _PronunciationCard({required this.text, required this.isLarge});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: 24, vertical: isLarge ? 32 : 20),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Text(
        text,
        style: (isLarge ? AppTypography.kurmanjiLarge : AppTypography.kurmanji)
            .copyWith(color: AppColors.primary),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// ── Dinle Butonu ─────────────────────────────────────────────

class _ListenButton extends StatelessWidget {
  final String text;
  final String label;
  final IconData icon;
  final bool slow;

  const _ListenButton({
    required this.text,
    required this.label,
    required this.icon,
    required this.slow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpeakButton(text: text, size: 56, slow: slow),
        const SizedBox(height: 6),
        Text(label, style: AppTypography.caption.copyWith(fontSize: 12)),
      ],
    );
  }
}

// ── Öz Değerlendirme Butonu ─────────────────────────────────

class _AssessmentButton extends StatelessWidget {
  final String emoji;
  final String label;
  final String desc;
  final Color color;
  final VoidCallback onTap;

  const _AssessmentButton({
    required this.emoji,
    required this.label,
    required this.desc,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: AppTypography.label.copyWith(color: color)),
                  Text(desc, style: AppTypography.caption.copyWith(
                      fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Mikrofon Kontrol Butonu (otomatik değerlendirme) ────────

class _MicCheckButton extends StatelessWidget {
  final bool isListening;
  final VoidCallback onTap;

  const _MicCheckButton({required this.isListening, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = isListening ? const Color(0xFFEF5350) : AppColors.accent;
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 64, height: 64,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: color.withOpacity(isListening ? 0.6 : 0.3),
                width: 2,
              ),
            ),
            child: Icon(
              isListening ? Icons.graphic_eq_rounded : Icons.mic_rounded,
              size: 30,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          isListening ? 'Guhdarî dikim...' : 'Bêje — otomatîk kontrol',
          style: AppTypography.caption.copyWith(fontSize: 12, color: color),
        ),
      ],
    );
  }
}

// ── Otomatik Değerlendirme Geri Bildirim Kartı ──────────────

class _AsrFeedbackCard extends StatelessWidget {
  final PronunciationResult result;

  const _AsrFeedbackCard({required this.result});

  @override
  Widget build(BuildContext context) {
    final (color, emoji, label) = switch (result.verdict) {
      PronunciationVerdict.excellent => (AppColors.success, '🎉', 'Pir baş!'),
      PronunciationVerdict.close => (AppColors.warning, '👍', 'Nêzîk bû!'),
      PronunciationVerdict.tryAgain =>
        (AppColors.errorSoft, '💪', 'Dîsa biceribîne'),
    };
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(
                '$label  %${result.percent}',
                style: AppTypography.label
                    .copyWith(color: color, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          if (result.transcript.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              'Me bihîst: "${result.transcript}"',
              style: AppTypography.caption.copyWith(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
          if (result.isApproximate) ...[
            const SizedBox(height: 4),
            Text(
              'Nirxandina otomatîk nêzîkî ye (ceribandin)',
              style: AppTypography.caption.copyWith(
                fontSize: 10,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 250.ms);
  }
}

class _PronunciationItem {
  final String word;
  final String translation;
  final String sentence;

  const _PronunciationItem({
    required this.word,
    required this.translation,
    required this.sentence,
  });
}
