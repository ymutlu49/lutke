import 'package:flutter/material.dart';

import '../../../core/utils/fsrs_algorithm.dart';
import '../../../shared/widgets/exercise_widgets.dart';
import '../../lessons/domain/entities/exercise.dart';
import 'widgets/fill_in_blank_widget.dart';
import 'widgets/minimal_pair_widget.dart';
import 'widgets/speaking_practice_widget.dart';

// ════════════════════════════════════════════════════════════════
// EGZERSİZ DİSPATCHER — Strategy Pattern
//
// Sealed class + switch ile derleme zamanı güvenliği:
// yeni bir egzersiz tipi eklendiğinde derleyici
// burada bir case eksik olduğunu bildirir.
//
// ExerciseModel'deki dev switch/if yerine tek bir dispatch noktası.
// ════════════════════════════════════════════════════════════════

typedef OnRatingCallback = void Function(Rating rating);

/// Her egzersiz tipini doğru widget'a yönlendirir.
///
/// Yeni egzersiz tipi eklemek:
///   1. exercise.dart'a yeni sealed alt sınıf ekle
///   2. Bu dosyada case ekle
///   3. Widget'ı yaz
///   Derleyici adım 2'yi unutmanı engelleyecektir.
class ExerciseDispatcher extends StatelessWidget {
  final Exercise exercise;
  final OnRatingCallback onRating;

  const ExerciseDispatcher({
    super.key,
    required this.exercise,
    required this.onRating,
  });

  @override
  Widget build(BuildContext context) {
    return switch (exercise) {
      ListenAndSelectExercise ex => MultipleChoiceExercise(
        question: ex.kurmanjiText,
        options: ex.options,
        correctIndex: ex.correctIndex,
        onRating: onRating,
      ),

      MultipleChoiceExercise ex => MultipleChoiceExercise(
        question: ex.prompt,
        options: ex.options,
        correctIndex: ex.correctIndex,
        onRating: onRating,
      ),

      TypingExercise ex => TypingExercise(
        prompt: ex.promptTr,
        answer: ex.correctKurmanji,
        onRating: onRating,
      ),

      SentenceOrderExercise ex => SentenceOrderExercise(
        wordTokens: ex.shuffledWords,
        correctOrder: ex.correctOrder,
        onRating: onRating,
      ),

      FillInBlankExercise ex => FillInBlankWidget(
        exercise: ex,
        onRating: onRating,
      ),

      MinimalPairExercise ex => MinimalPairWidget(
        exercise: ex,
        onRating: onRating,
      ),

      SpeakingPracticeExercise ex => SpeakingPracticeWidget(
        exercise: ex,
        onRating: onRating,
      ),

      CulturalContentExercise ex => _CulturalCard(
        exercise: ex,
        onRating: onRating,
      ),
    };
  }
}

// ── Kültürel İçerik Kartı (basit — mevcut cultural_widgets'a köprü) ─

class _CulturalCard extends StatelessWidget {
  final CulturalContentExercise exercise;
  final OnRatingCallback onRating;

  const _CulturalCard({required this.exercise, required this.onRating});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Tip ikonu
          Icon(
            switch (exercise.contentType) {
              CulturalType.proverb => Icons.format_quote_rounded,
              CulturalType.poem => Icons.auto_stories_rounded,
              CulturalType.song => Icons.music_note_rounded,
              CulturalType.story => Icons.menu_book_rounded,
            },
            size: 40,
            color: const Color(0xFFD4783A),
          ),
          const SizedBox(height: 24),

          // Kurmancî metin — büyük, belirgin
          Text(
            exercise.contentKu,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A2A4A),
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Türkçe çeviri — küçük
          Text(
            exercise.contentTr,
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF4A5A6A).withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),

          // Kaynak
          if (exercise.source != null) ...[
            const SizedBox(height: 12),
            Text(
              '— ${exercise.source}',
              style: TextStyle(
                fontSize: 12,
                color: const Color(0xFF4A5A6A).withOpacity(0.6),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],

          const Spacer(),

          // Devam butonu
          ElevatedButton(
            onPressed: () => onRating(Rating.good),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A7B6B),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Dûv re',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
