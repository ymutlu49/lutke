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
import '../../../shared/providers/language_mode_provider.dart';
import '../../../shared/widgets/speak_button.dart';
import '../../lessons/domain/a1_kelime_db.dart';
import '../../lessons/domain/a2_kelime_db.dart';
import '../../lessons/domain/b1_kelime_db.dart';
import '../../lessons/domain/b2_kelime_db.dart';
import '../../lessons/domain/c1_kelime_db.dart';
import '../../lessons/domain/c2_kelime_db.dart';

// ════════════════════════════════════════════════════════════════
// HEVPEYVîN — Diyalog / Sohbet Etkinliği
//
// Kategorideki kelimelerin heritage cümlelerinden mini diyalog
// oluşturur. Kullanıcı:
//   1. Diyaloğu dinler (TTS ile)
//   2. Kendi rolünü tekrar eder (telaffuz pratiği)
//   3. Boşlukları doldurur (anlama kontrolü)
//
// Araştırma temelli: Babbel role-play + Duolingo scaffolding
// ════════════════════════════════════════════════════════════════

class DialogueScreen extends ConsumerStatefulWidget {
  final String? category;
  final String level;

  const DialogueScreen({super.key, this.category, this.level = 'A1'});

  @override
  ConsumerState<DialogueScreen> createState() => _DialogueScreenState();
}

class _DialogueScreenState extends ConsumerState<DialogueScreen> {
  late List<_DialogueExchange> _exchanges;
  int _currentIndex = 0;
  int _phase = 0; // 0: dinle, 1: tekrar et, 2: boşluk doldur
  bool _answered = false;
  bool _isCorrect = false;
  String? _selectedAnswer;
  int _correctCount = 0;

  @override
  void initState() {
    super.initState();
    _exchanges = _generateDialogues();
  }

  List<_DialogueExchange> _generateDialogues() {
    final words = _wordsForLevel(widget.level);
    final showTr = ref.read(showTurkishProvider);
    final rng = Random();

    // Kategoriye göre filtrele
    var pool = words.toList();
    if (widget.category != null && widget.category!.isNotEmpty) {
      final filtered = pool.where((w) => w.kat == widget.category).toList();
      if (filtered.length >= 3) pool = filtered;
    }

    // Heritage cümleleri olan kelimeleri seç
    final withSentences = pool
        .where((w) => (w.her as List).isNotEmpty && (w.ku as String).length > 1)
        .toList()
      ..shuffle(rng);

    final exchanges = <_DialogueExchange>[];
    final count = withSentences.length.clamp(0, 6);

    for (var i = 0; i < count; i++) {
      final w = withSentences[i];
      final herList = (w.her as List).cast<String>();
      final sentence = herList[rng.nextInt(herList.length)];
      final ku = w.ku as String;
      final tr = w.tr as String;

      // Cümleden kelimeyi maskeleyerek boşluk oluştur
      final masked = sentence.replaceAll(ku, '____');
      final hasMask = masked != sentence;

      // Distractor seçenekler (aynı kategoriden)
      final distractors = withSentences
          .where((d) => d.ku != ku)
          .take(2)
          .map((d) => d.ku as String)
          .toList();

      exchanges.add(_DialogueExchange(
        targetWord: ku,
        translation: showTr ? tr : '',
        fullSentence: sentence,
        maskedSentence: hasMask ? masked : '$ku...',
        options: hasMask ? ([ku, ...distractors]..shuffle(rng)) : [],
        speakerEmoji: i.isEven ? '👩' : '👨',
        speakerName: i.isEven ? 'Leyla' : 'Azad',
      ));
    }

    return exchanges;
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
    if (_exchanges.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundPrimary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _safePop,
          ),
        ),
        body: Center(
          child: Text('Vê beşê de hevpeyvîn bes nine.',
              style: AppTypography.body.copyWith(color: AppColors.textSecondary)),
        ),
      );
    }

    if (_currentIndex >= _exchanges.length) {
      return _buildResultScreen();
    }

    final exchange = _exchanges[_currentIndex];

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            _buildTopBar(),

            // İlerleme
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (_currentIndex + 1) / _exchanges.length,
                  backgroundColor: AppColors.primary.withOpacity(0.12),
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  minHeight: 6,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Diyalog kartı
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Faz başlığı
                    Text(
                      switch (_phase) {
                        0 => 'Guhdarî bike',
                        1 => 'Dubare bike',
                        _ => 'Cihê vala dagire',
                      },
                      style: AppTypography.title.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ).animate().fadeIn(),

                    const SizedBox(height: 20),

                    // Diyalog balonu
                    _DialogueBubble(
                      exchange: exchange,
                      phase: _phase,
                      showTranslation: ref.watch(showTurkishProvider),
                    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.05),

                    const SizedBox(height: 20),

                    // Faz 0: Dinle butonu
                    if (_phase == 0) ...[
                      Center(
                        child: Column(
                          children: [
                            SpeakButton(text: exchange.fullSentence, size: 64),
                            const SizedBox(height: 12),
                            Text('Guhdarî bike û fêm bike',
                                style: AppTypography.caption),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildPhaseButton('Fêm kir, dûv re', () {
                        setState(() => _phase = 1);
                      }),
                    ],

                    // Faz 1: Tekrar et
                    if (_phase == 1) ...[
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.primarySurface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: AppColors.primary.withOpacity(0.2)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                exchange.fullSentence,
                                style: AppTypography.kurmanji.copyWith(
                                    fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SpeakButton(
                                      text: exchange.fullSentence, size: 48),
                                  const SizedBox(width: 16),
                                  // Yavaş dinle
                                  SpeakButton(
                                    text: exchange.fullSentence,
                                    size: 48,
                                    slow: true,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text('Guhdarî bike û dubare bike',
                                  style: AppTypography.caption),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildPhaseButton(
                        exchange.options.isNotEmpty
                            ? 'Dubare kir, dûv re'
                            : 'Temam',
                        () {
                          if (exchange.options.isNotEmpty) {
                            setState(() => _phase = 2);
                          } else {
                            _correctCount++;
                            _nextExchange();
                          }
                        },
                      ),
                    ],

                    // Faz 2: Boşluk doldur
                    if (_phase == 2) ...[
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.borderLight),
                          ),
                          child: Text(
                            exchange.maskedSentence,
                            style: AppTypography.kurmanji.copyWith(
                                fontSize: 18, height: 1.6),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...exchange.options.map((option) {
                        final isSelected = _selectedAnswer == option;
                        final isCorrectOption = option == exchange.targetWord;

                        Color bg = AppColors.surface;
                        Color border = AppColors.borderLight;

                        if (_answered) {
                          if (isCorrectOption) {
                            bg = AppColors.successSurface;
                            border = AppColors.success;
                          } else if (isSelected && !isCorrectOption) {
                            bg = AppColors.errorSurface;
                            border = AppColors.errorSoft;
                          }
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: _answered
                                ? null
                                : () {
                                    SoundService.playTap();
                                    setState(() {
                                      _selectedAnswer = option;
                                      _answered = true;
                                      _isCorrect =
                                          option == exchange.targetWord;
                                      if (_isCorrect) {
                                        _correctCount++;
                                        SoundService.playCorrect();
                                      } else {
                                        SoundService.playWrong();
                                      }
                                    });
                                  },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                              decoration: BoxDecoration(
                                color: bg,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: border),
                              ),
                              child: Text(option,
                                  style: AppTypography.kurmanjiCard),
                            ),
                          ),
                        );
                      }),
                      if (_answered) ...[
                        const SizedBox(height: 16),
                        _buildPhaseButton('Dûv re', _nextExchange),
                      ],
                    ],

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: _safePop,
            child: Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: AppColors.surface, shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 18,
                  color: AppColors.textSecondary),
            ),
          ),
          const Spacer(),
          Text(
            '${_currentIndex + 1} / ${_exchanges.length}',
            style: AppTypography.label
                .copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildPhaseButton(String label, VoidCallback onTap) {
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
        child: Text(label, style: AppTypography.labelLarge.copyWith(
            color: Colors.white)),
      ),
    );
  }

  void _nextExchange() {
    setState(() {
      _currentIndex++;
      _phase = 0;
      _answered = false;
      _isCorrect = false;
      _selectedAnswer = null;
    });
  }

  Widget _buildResultScreen() {
    final accuracy = _exchanges.isNotEmpty
        ? _correctCount / _exchanges.length
        : 0.0;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                accuracy >= 0.8 ? 'Pîroz be!' : 'Baş e!',
                style: AppTypography.display.copyWith(
                    color: AppColors.primary),
              ).animate().fadeIn().scale(
                  begin: const Offset(0.8, 0.8),
                  curve: Curves.elasticOut),
              const SizedBox(height: 16),
              Text(
                '$_correctCount / ${_exchanges.length} rast',
                style: AppTypography.headline.copyWith(
                    color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _safePop,
                child: const Text('Vegere'),
              ),
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

// ── Diyalog Veri Modeli ─────────────────────────────────────

class _DialogueExchange {
  final String targetWord;
  final String translation;
  final String fullSentence;
  final String maskedSentence;
  final List<String> options;
  final String speakerEmoji;
  final String speakerName;

  const _DialogueExchange({
    required this.targetWord,
    required this.translation,
    required this.fullSentence,
    required this.maskedSentence,
    required this.options,
    required this.speakerEmoji,
    required this.speakerName,
  });
}

// ── Diyalog Balonu ──────────────────────────────────────────

class _DialogueBubble extends StatelessWidget {
  final _DialogueExchange exchange;
  final int phase;
  final bool showTranslation;

  const _DialogueBubble({
    required this.exchange,
    required this.phase,
    required this.showTranslation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(exchange.speakerEmoji,
                  style: const TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exchange.speakerName,
                  style: AppTypography.label.copyWith(
                      color: AppColors.primary),
                ),
                const SizedBox(height: 4),
                Text(
                  exchange.fullSentence,
                  style: AppTypography.kurmanjiCard.copyWith(
                    fontSize: 17, height: 1.5),
                ),
                if (showTranslation && exchange.translation.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(exchange.translation,
                      style: AppTypography.translation),
                ],
              ],
            ),
          ),
          // TTS butonu
          SpeakButton(text: exchange.fullSentence, size: 32),
        ],
      ),
    );
  }
}
