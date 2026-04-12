/// Barrel export — tüm domain entity'leri tek import ile erişilebilir.
///
/// Kullanım:
///   import 'package:lutke/features/lessons/domain/entities/entities.dart';
///
/// Bu sayede:
///   - VocabularyCard, CEFRLevel, WordGender
///   - Exercise (sealed), tüm alt tipler
///   - Lesson, LessonPath, LessonSessionState, ExerciseResult
///   - UserProfile, UserSegment, UserMotivation
///
/// tek bir import ile kullanılabilir.

export 'vocabulary_card.dart';
export 'exercise.dart';
export 'lesson.dart';
export 'user_profile.dart';
