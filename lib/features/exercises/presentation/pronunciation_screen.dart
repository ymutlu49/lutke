import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../core/services/sound_service.dart';
import '../../../shared/widgets/speak_button.dart';
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

  @override
  void initState() {
    super.initState();
    _items = _generateItems();
  }

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

                      const SizedBox(height: 32),
                      _buildNextButton('Hevokê jî biceribîne', () {
                        setState(() => _phase = 1);
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

                      const SizedBox(height: 32),
                      _buildNextButton('Xwe binirxîne', () {
                        setState(() => _phase = 2);
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
                            const SizedBox(height: 24),
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
                                setState(() => _phase = 0);
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
    setState(() {
      _currentIndex++;
      _phase = 0;
    });
  }

  Widget _buildResultScreen() {
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
