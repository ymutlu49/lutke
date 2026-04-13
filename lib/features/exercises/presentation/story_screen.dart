// ════════════════════════════════════════════════════════════════
// LÛTKE — Mini Story / Dialog Reading Exercise
//
// Duolingo benzeri "Stories" özelliği.
// Kısa Kurmancî diyalogları okuma + anlama soruları.
//
// Özellikler:
// ✓ Sohbet baloncuğu stili (sol/sağ konuşmacıya göre)
// ✓ Satır satır gösterim (tap ile ilerleme)
// ✓ Anlama soruları (çoktan seçmeli)
// ✓ Kelime vurgusu (tıklanabilir tooltip)
// ✓ Skor ekranı
// ════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../shared/providers/language_mode_provider.dart';
import '../../lessons/domain/heritage_dialogues.dart';

// ════════════════════════════════════════════════════════════════
// COMPREHENSION QUESTION MODEL
// ════════════════════════════════════════════════════════════════

class ComprehensionQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;

  const ComprehensionQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

class StoryData {
  final HeritageDialogue dialogue;
  final List<ComprehensionQuestion> questions;

  const StoryData({
    required this.dialogue,
    required this.questions,
  });
}

// ════════════════════════════════════════════════════════════════
// STORY VERILERI — 4 diyalog + anlama soruları
// ════════════════════════════════════════════════════════════════

final List<StoryData> kStoryList = [
  // ── 1: Çayê Dapîrê ─────────────────────────────────────────
  StoryData(
    dialogue: kDialoguePiree,
    questions: [
      const ComprehensionQuestion(
        question: 'Kî got "Rûne, rûne! Ezê çay bikim"?',
        options: ['Elif', 'Dapîr', 'Dê'],
        correctIndex: 1,
      ),
      const ComprehensionQuestion(
        question: 'Elif çi hîn dibe?',
        options: ['Tirkî', 'Kurmancî', 'Farisî'],
        correctIndex: 1,
      ),
    ],
  ),

  // ── 2: Li Sifrê ────────────────────────────────────────────
  StoryData(
    dialogue: kDialogueSifre,
    questions: [
      const ComprehensionQuestion(
        question: 'Li sifrê çi xwarin heye?',
        options: ['Şorba', 'Goşt û birinc', 'Makarna'],
        correctIndex: 1,
      ),
      const ComprehensionQuestion(
        question: 'Kî got "Ez gelek birçî me!"?',
        options: ['Dê', 'Bav', 'Mehmet'],
        correctIndex: 2,
      ),
    ],
  ),

  // ── 3: Bi Telefon ──────────────────────────────────────────
  StoryData(
    dialogue: kDialogueTelefon,
    questions: [
      const ComprehensionQuestion(
        question: 'Zeynep bi kî re dipeyive?',
        options: ['Dapîr', 'Dê', 'Bav'],
        correctIndex: 1,
      ),
      const ComprehensionQuestion(
        question: 'Zeynep sibê çi dike?',
        options: ['Dibistanê diçe', 'Tê malê', 'Dersê dixwîne'],
        correctIndex: 1,
      ),
    ],
  ),

  // ── 4: Malbat Tê ───────────────────────────────────────────
  StoryData(
    dialogue: kDialogueMalbat,
    questions: [
      const ComprehensionQuestion(
        question: 'Malbat serdana kê dike?',
        options: ['Dê', 'Dapîr', 'Heval'],
        correctIndex: 1,
      ),
      const ComprehensionQuestion(
        question: 'Kî got "Lazim nebû!"?',
        options: ['Hasan', 'Jina Hasan', 'Dapîr'],
        correctIndex: 2,
      ),
    ],
  ),
];

// ════════════════════════════════════════════════════════════════
// VOCABULARY DEFINITIONS — anahtar kelime açıklamaları
// ════════════════════════════════════════════════════════════════

const Map<String, String> _kVocabDefinitions = {
  'silav': 'Merhaba',
  'pîrê': 'Buyukanne (hitap)',
  'çay': 'Cay',
  'spas': 'Tesekkurler',
  'baş': 'Iyi, guzel',
  'germ': 'Sicak',
  'xweş': 'Guzel, hos',
  'hîn bûn': 'Ogrenmek',
  'nan': 'Ekmek',
  'xwarin': 'Yemek',
  'birçî': 'Ac',
  'av': 'Su',
  'goşt': 'Et',
  'nûş be': 'Afiyet olsun',
  'destê te xweş be': 'Elinize saglik',
  'malbat': 'Aile',
  'sibê': 'Yarin',
  'Kurmancî': 'Kurtce (Kurmanci)',
  'keyf xweş': 'Keyifli',
  'bi xêr hatîn': 'Hos geldiniz',
  'rûne': 'Otur',
  'kur': 'Ogul, erkek cocuk',
  'keç': 'Kiz',
  'ji bo te': 'Senin icin',
  'ser çavim': 'Bas ustune',
  'hîn': 'Ogrenmek (kisa)',
  'rast': 'Dogru',
  'mamosta': 'Ogretmen',
  'çi ye': 'Bu ne?',
  'erê': 'Evet',
  'lê': 'Ama',
  'gelek': 'Cok',
  'jî': 'De, da',
  'dê': 'Anne',
  'dêyê': 'Annecigim',
};

// ════════════════════════════════════════════════════════════════
// SPEAKER COLORS — konuşmacılara renk atama
// ════════════════════════════════════════════════════════════════

const List<Color> _kSpeakerColors = [
  AppColors.primary,
  AppColors.accent,
  Color(0xFF6B5CA5),    // mor
  Color(0xFF2D9E4F),    // yeşil
  Color(0xFFE07B5A),    // mercan
];

// ════════════════════════════════════════════════════════════════
// STORY SCREEN — Ana ekran
// ════════════════════════════════════════════════════════════════

class StoryScreen extends ConsumerStatefulWidget {
  const StoryScreen({super.key});

  @override
  ConsumerState<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends ConsumerState<StoryScreen> {
  int _currentStoryIndex = 0;
  int _revealedLineCount = 0;
  bool _storyComplete = false;
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  int? _selectedOption;
  bool _answered = false;
  bool _quizComplete = false;

  StoryData get _currentStory => kStoryList[_currentStoryIndex];
  HeritageDialogue get _dialogue => _currentStory.dialogue;
  List<ComprehensionQuestion> get _questions => _currentStory.questions;

  // Konuşmacı -> renk eşlemesi
  late Map<String, Color> _speakerColorMap;
  late List<String> _speakers;

  @override
  void initState() {
    super.initState();
    _buildSpeakerMap();
    // İlk satırı hemen göster
    _revealedLineCount = 1;
  }

  void _buildSpeakerMap() {
    _speakerColorMap = {};
    _speakers = [];
    int colorIdx = 0;
    for (final line in _dialogue.lines) {
      if (!_speakerColorMap.containsKey(line.speaker)) {
        _speakers.add(line.speaker);
        _speakerColorMap[line.speaker] =
            _kSpeakerColors[colorIdx % _kSpeakerColors.length];
        colorIdx++;
      }
    }
  }

  void _revealNextLine() {
    if (_revealedLineCount < _dialogue.lines.length) {
      setState(() {
        _revealedLineCount++;
      });
    } else {
      // Tüm satırlar gösterildi — quiz'e geç
      setState(() {
        _storyComplete = true;
      });
    }
  }

  void _selectAnswer(int index) {
    if (_answered) return;
    setState(() {
      _selectedOption = index;
      _answered = true;
      if (index == _questions[_currentQuestionIndex].correctIndex) {
        _correctAnswers++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOption = null;
        _answered = false;
      });
    } else {
      setState(() {
        _quizComplete = true;
      });
    }
  }

  void _nextStory() {
    if (_currentStoryIndex < kStoryList.length - 1) {
      setState(() {
        _currentStoryIndex++;
        _revealedLineCount = 1;
        _storyComplete = false;
        _currentQuestionIndex = 0;
        _correctAnswers = 0;
        _selectedOption = null;
        _answered = false;
        _quizComplete = false;
      });
      _buildSpeakerMap();
    } else {
      // Tüm hikayeler bitti
      context.pop();
    }
  }

  void _restartStories() {
    setState(() {
      _currentStoryIndex = 0;
      _revealedLineCount = 1;
      _storyComplete = false;
      _currentQuestionIndex = 0;
      _correctAnswers = 0;
      _selectedOption = null;
      _answered = false;
      _quizComplete = false;
    });
    _buildSpeakerMap();
  }

  @override
  Widget build(BuildContext context) {
    final showTurkish = ref.watch(showTurkishProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Cirok',
          style: AppTypography.headline.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        actions: [
          // Hikaye ilerleme göstergesi
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: Center(
              child: Text(
                '${_currentStoryIndex + 1}/${kStoryList.length}',
                style: AppTypography.label.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── İlerleme çubuğu ──────────────────────────────────
          _StoryProgressBar(
            storyProgress: _currentStoryIndex / kStoryList.length,
            lineProgress: _storyComplete
                ? 1.0
                : _revealedLineCount / _dialogue.lines.length,
          ),

          // ── İçerik ───────────────────────────────────────────
          Expanded(
            child: _quizComplete
                ? _ScoreView(
                    correct: _correctAnswers,
                    total: _questions.length,
                    storyTitle: _dialogue.kurmanjTitle,
                    isLastStory:
                        _currentStoryIndex >= kStoryList.length - 1,
                    onNext: _nextStory,
                    onRestart: _restartStories,
                  )
                : _storyComplete
                    ? _QuizView(
                        question: _questions[_currentQuestionIndex],
                        questionIndex: _currentQuestionIndex,
                        totalQuestions: _questions.length,
                        selectedOption: _selectedOption,
                        answered: _answered,
                        onSelect: _selectAnswer,
                        onNext: _nextQuestion,
                      )
                    : _StoryView(
                        dialogue: _dialogue,
                        revealedCount: _revealedLineCount,
                        speakerColorMap: _speakerColorMap,
                        speakers: _speakers,
                        showTurkish: showTurkish,
                        onTap: _revealNextLine,
                      ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// PROGRESS BAR
// ════════════════════════════════════════════════════════════════

class _StoryProgressBar extends StatelessWidget {
  final double storyProgress;
  final double lineProgress;

  const _StoryProgressBar({
    required this.storyProgress,
    required this.lineProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: ClipRRect(
        borderRadius: AppRadius.full,
        child: LinearProgressIndicator(
          value: storyProgress + (lineProgress / kStoryList.length),
          backgroundColor: AppColors.borderLight,
          valueColor:
              const AlwaysStoppedAnimation<Color>(AppColors.primary),
          minHeight: 6,
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// STORY VIEW — Diyalog baloncukları
// ════════════════════════════════════════════════════════════════

class _StoryView extends StatelessWidget {
  final HeritageDialogue dialogue;
  final int revealedCount;
  final Map<String, Color> speakerColorMap;
  final List<String> speakers;
  final bool showTurkish;
  final VoidCallback onTap;

  const _StoryView({
    required this.dialogue,
    required this.revealedCount,
    required this.speakerColorMap,
    required this.speakers,
    required this.showTurkish,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isAllRevealed = revealedCount >= dialogue.lines.length;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          // ── Hikaye Başlığı ──────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                Text(
                  dialogue.kurmanjTitle,
                  style: AppTypography.kurmanjiLarge,
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 400.ms),
                if (showTurkish) ...[
                  const SizedBox(height: 4),
                  Text(
                    dialogue.turkishTitle,
                    style: AppTypography.translation,
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 100.ms, duration: 300.ms),
                ],
              ],
            ),
          ),

          // ── Diyalog Baloncukları ────────────────────────────
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              itemCount: revealedCount,
              itemBuilder: (context, index) {
                final line = dialogue.lines[index];
                final isLeft =
                    speakers.indexOf(line.speaker) % 2 == 0;
                final color = speakerColorMap[line.speaker] ??
                    AppColors.primary;

                return _ChatBubble(
                  line: line,
                  isLeft: isLeft,
                  speakerColor: color,
                  showTurkish: showTurkish,
                  keyWords: dialogue.keyWords,
                ).animate().fadeIn(duration: 350.ms).slideY(
                      begin: 0.15,
                      duration: 350.ms,
                      curve: Curves.easeOut,
                    );
              },
            ),
          ),

          // ── Devam et ipucu ──────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: isAllRevealed
                ? _PulsingButton(
                    label: 'Pirs bide!',
                    icon: Icons.quiz_rounded,
                    onTap: onTap,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.touch_app_rounded,
                        size: 18,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Ji bo rista din bitikine',
                        style: AppTypography.caption,
                      ),
                    ],
                  )
                      .animate(
                        onPlay: (c) => c.repeat(reverse: true),
                      )
                      .fadeIn(duration: 600.ms)
                      .then()
                      .fadeOut(duration: 600.ms),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// CHAT BUBBLE — Sohbet baloncuğu
// ════════════════════════════════════════════════════════════════

class _ChatBubble extends StatelessWidget {
  final DialogueLine line;
  final bool isLeft;
  final Color speakerColor;
  final bool showTurkish;
  final List<String> keyWords;

  const _ChatBubble({
    required this.line,
    required this.isLeft,
    required this.speakerColor,
    required this.showTurkish,
    required this.keyWords,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        mainAxisAlignment:
            isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isLeft) _Avatar(name: line.speaker, color: speakerColor),
          if (isLeft) const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Column(
              crossAxisAlignment: isLeft
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                // Konuşmacı adı
                Padding(
                  padding: EdgeInsets.only(
                    left: isLeft ? 4 : 0,
                    right: isLeft ? 0 : 4,
                    bottom: 2,
                  ),
                  child: Text(
                    line.speaker,
                    style: AppTypography.labelSmall.copyWith(
                      color: speakerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // Balon
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.72,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm + 2,
                  ),
                  decoration: BoxDecoration(
                    color: isLeft
                        ? AppColors.backgroundSecondary
                        : speakerColor.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          isLeft ? AppSpacing.radiusXs : AppSpacing.radiusLg),
                      topRight: Radius.circular(
                          isLeft ? AppSpacing.radiusLg : AppSpacing.radiusXs),
                      bottomLeft:
                          const Radius.circular(AppSpacing.radiusLg),
                      bottomRight:
                          const Radius.circular(AppSpacing.radiusLg),
                    ),
                    border: Border.all(
                      color: isLeft
                          ? AppColors.borderLight
                          : speakerColor.withOpacity(0.2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Kurmancî metin — anahtar kelimeler vurgulu
                      _HighlightedText(
                        text: line.kurmanci,
                        keyWords: keyWords,
                        style: AppTypography.kurmanjiCard,
                      ),
                      if (showTurkish) ...[
                        const SizedBox(height: 4),
                        Text(
                          line.turkish,
                          style: AppTypography.translation.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                      // Gramer notu (varsa)
                      if (line.grammarNote != null && showTurkish) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primarySurface,
                            borderRadius: AppRadius.sm,
                          ),
                          child: Text(
                            line.grammarNote!,
                            style: AppTypography.caption.copyWith(
                              fontSize: 10,
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isLeft) const SizedBox(width: AppSpacing.sm),
          if (!isLeft) _Avatar(name: line.speaker, color: speakerColor),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// AVATAR — Konuşmacı baş harfi
// ════════════════════════════════════════════════════════════════

class _Avatar extends StatelessWidget {
  final String name;
  final Color color;

  const _Avatar({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.4), width: 1.5),
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: AppTypography.label.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// HIGHLIGHTED TEXT — Anahtar kelimeler tıklanabilir
// ════════════════════════════════════════════════════════════════

class _HighlightedText extends StatelessWidget {
  final String text;
  final List<String> keyWords;
  final TextStyle style;

  const _HighlightedText({
    required this.text,
    required this.keyWords,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    // Kelimeleri parçala ve eşleşenleri vurgula
    final words = text.split(' ');
    final spans = <InlineSpan>[];

    for (int i = 0; i < words.length; i++) {
      final word = words[i];
      final cleanWord =
          word.replaceAll(RegExp(r'[.,!?;:]'), '').toLowerCase();

      final isKeyWord = keyWords.any(
        (kw) => kw.toLowerCase() == cleanWord ||
            cleanWord.startsWith(kw.toLowerCase()),
      );

      if (isKeyWord) {
        spans.add(
          WidgetSpan(
            child: _TappableWord(
              word: word,
              cleanWord: cleanWord,
              style: style,
            ),
          ),
        );
      } else {
        spans.add(TextSpan(text: word, style: style));
      }

      if (i < words.length - 1) {
        spans.add(TextSpan(text: ' ', style: style));
      }
    }

    return Text.rich(TextSpan(children: spans));
  }
}

class _TappableWord extends StatelessWidget {
  final String word;
  final String cleanWord;
  final TextStyle style;

  const _TappableWord({
    required this.word,
    required this.cleanWord,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Tanımı bul
        String? definition;
        for (final entry in _kVocabDefinitions.entries) {
          if (cleanWord == entry.key.toLowerCase() ||
              cleanWord.startsWith(entry.key.toLowerCase())) {
            definition = entry.value;
            break;
          }
        }
        if (definition != null) {
          _showVocabTooltip(context, word, definition);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.primary.withOpacity(0.5),
              width: 1.5,
            ),
          ),
        ),
        child: Text(
          word,
          style: style.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

void _showVocabTooltip(
    BuildContext context, String word, String definition) {
  showDialog(
    context: context,
    barrierColor: Colors.black26,
    builder: (_) => _VocabTooltipDialog(
      word: word,
      definition: definition,
    ),
  );
}

class _VocabTooltipDialog extends StatelessWidget {
  final String word;
  final String definition;

  const _VocabTooltipDialog({
    required this.word,
    required this.definition,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 48),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: AppRadius.lg,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  word.replaceAll(RegExp(r'[.,!?;:]'), ''),
                  style: AppTypography.kurmanjiLarge,
                ),
                const SizedBox(height: 8),
                Container(
                  width: 32,
                  height: 3,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: AppRadius.full,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  definition,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ).animate().scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.0, 1.0),
                duration: 200.ms,
                curve: Curves.easeOut,
              ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// QUIZ VIEW — Anlama soruları
// ════════════════════════════════════════════════════════════════

class _QuizView extends StatelessWidget {
  final ComprehensionQuestion question;
  final int questionIndex;
  final int totalQuestions;
  final int? selectedOption;
  final bool answered;
  final ValueChanged<int> onSelect;
  final VoidCallback onNext;

  const _QuizView({
    required this.question,
    required this.questionIndex,
    required this.totalQuestions,
    required this.selectedOption,
    required this.answered,
    required this.onSelect,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.lg),

          // Soru numarası
          Text(
            'Pirs ${questionIndex + 1} / $totalQuestions',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textTertiary,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 300.ms),

          const SizedBox(height: AppSpacing.md),

          // Soru metni
          Container(
            padding: AppSpacing.cardPadding,
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: AppRadius.lg,
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.help_outline_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    question.question,
                    style: AppTypography.kurmanji.copyWith(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(
                begin: 0.1,
                duration: 400.ms,
                curve: Curves.easeOut,
              ),

          const SizedBox(height: AppSpacing.lg),

          // Seçenekler
          ...List.generate(question.options.length, (i) {
            final isSelected = selectedOption == i;
            final isCorrect = i == question.correctIndex;

            Color bgColor = AppColors.backgroundSecondary;
            Color borderColor = AppColors.borderLight;
            Color textColor = AppColors.textPrimary;

            if (answered) {
              if (isCorrect) {
                bgColor = AppColors.successSurface;
                borderColor = AppColors.success;
                textColor = AppColors.success;
              } else if (isSelected && !isCorrect) {
                bgColor = AppColors.errorSurface;
                borderColor = AppColors.errorSoft;
                textColor = AppColors.errorSoft;
              }
            } else if (isSelected) {
              bgColor = AppColors.primarySurface;
              borderColor = AppColors.primary;
            }

            return Padding(
              padding:
                  const EdgeInsets.only(bottom: AppSpacing.sm),
              child: GestureDetector(
                onTap: () => onSelect(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.md,
                  ),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: AppRadius.md,
                    border: Border.all(
                      color: borderColor,
                      width: isSelected || (answered && isCorrect)
                          ? 2
                          : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Harf etiketi
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: answered && isCorrect
                              ? AppColors.success
                              : answered && isSelected && !isCorrect
                                  ? AppColors.errorSoft
                                  : isSelected
                                      ? AppColors.primary
                                      : AppColors.backgroundTertiary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: answered && isCorrect
                              ? const Icon(Icons.check,
                                  color: Colors.white, size: 18)
                              : answered &&
                                      isSelected &&
                                      !isCorrect
                                  ? const Icon(Icons.close,
                                      color: Colors.white,
                                      size: 18)
                                  : Text(
                                      String.fromCharCode(
                                          65 + i), // A, B, C
                                      style: AppTypography.label
                                          .copyWith(
                                        color: isSelected
                                            ? Colors.white
                                            : AppColors
                                                .textSecondary,
                                        fontWeight:
                                            FontWeight.w700,
                                      ),
                                    ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          question.options[i],
                          style:
                              AppTypography.kurmanjiCard.copyWith(
                            color: textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(
                    delay: Duration(milliseconds: 100 + i * 80),
                    duration: 300.ms,
                  ),
            );
          }),

          const Spacer(),

          // Devam butonu
          if (answered)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.md,
                  ),
                  elevation: 0,
                ),
                child: Text(
                  questionIndex < totalQuestions - 1
                      ? 'Pirsa din'
                      : 'Encam',
                  style: AppTypography.labelLarge.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 300.ms).slideY(
                  begin: 0.2,
                  duration: 300.ms,
                  curve: Curves.easeOut,
                ),

          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// SCORE VIEW — Skor ekranı
// ════════════════════════════════════════════════════════════════

class _ScoreView extends StatelessWidget {
  final int correct;
  final int total;
  final String storyTitle;
  final bool isLastStory;
  final VoidCallback onNext;
  final VoidCallback onRestart;

  const _ScoreView({
    required this.correct,
    required this.total,
    required this.storyTitle,
    required this.isLastStory,
    required this.onNext,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    final isPerfect = correct == total;
    final percentage = total > 0 ? (correct / total * 100).round() : 0;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),

          // Skor dairesi
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isPerfect
                  ? AppColors.successSurface
                  : AppColors.primarySurface,
              border: Border.all(
                color: isPerfect ? AppColors.success : AppColors.primary,
                width: 3,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$correct/$total',
                  style: AppTypography.display.copyWith(
                    color: isPerfect
                        ? AppColors.success
                        : AppColors.primary,
                    fontSize: 32,
                  ),
                ),
                Text(
                  '%$percentage',
                  style: AppTypography.label.copyWith(
                    color: isPerfect
                        ? AppColors.success
                        : AppColors.primary,
                  ),
                ),
              ],
            ),
          ).animate().scale(
                begin: const Offset(0.5, 0.5),
                end: const Offset(1.0, 1.0),
                duration: 500.ms,
                curve: Curves.elasticOut,
              ),

          const SizedBox(height: AppSpacing.lg),

          // Mesaj
          Text(
            isPerfect ? 'Pir başî!' : 'Başî!',
            style: AppTypography.kurmanjiLarge.copyWith(
              color: isPerfect ? AppColors.success : AppColors.primary,
            ),
          ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

          const SizedBox(height: AppSpacing.sm),

          Text(
            '"$storyTitle" qediya.',
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

          if (isPerfect) ...[
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.accentSurface,
                borderRadius: AppRadius.full,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🌟', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 6),
                  Text(
                    '+10 XP',
                    style: AppTypography.xpCounter.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 600.ms).scale(
                  begin: const Offset(0.8, 0.8),
                  duration: 300.ms,
                ),
          ],

          const Spacer(),

          // Butonlar
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadius.md,
                ),
                elevation: 0,
              ),
              child: Text(
                isLastStory ? 'Biqedine' : 'Çîroka din',
                style: AppTypography.labelLarge.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ).animate().fadeIn(delay: 500.ms).slideY(
                begin: 0.2,
                duration: 300.ms,
              ),

          if (isLastStory) ...[
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: onRestart,
              child: Text(
                'Ji nû ve dest pê bike',
                style: AppTypography.label.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ).animate().fadeIn(delay: 600.ms),
          ],

          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// PULSING BUTTON — Dikkat çekici buton
// ════════════════════════════════════════════════════════════════

class _PulsingButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _PulsingButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: AppRadius.full,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTypography.labelLarge.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .scale(
          begin: const Offset(1.0, 1.0),
          end: const Offset(1.05, 1.05),
          duration: 800.ms,
        );
  }
}
