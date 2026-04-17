import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../domain/en_grammar_db.dart';
import '../domain/en_quiz_items.dart';
import '../domain/en_reading_db.dart';
import '../domain/en_writing_db.dart';
import '../domain/en_listening_db.dart';
import '../domain/en_speaking_db.dart';

/// 5 dil becerisi hub — İngilizce modülü için
/// 1. Gramer 2. Yazma 3. Okuma 4. Dinleme 5. Konuşma
class EnSkillsHubScreen extends StatelessWidget {
  const EnSkillsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = [
      _Skill('📘', 'Gramer', 'Grammar', 'Rêziman — ${kEnGrammarTopics.length} mijar',
          AppRoutes.enGrammar, const Color(0xFF3F51B5)),
      _Skill('🎯', 'Test', 'Quiz', 'Testên taybet — ${kEnQuizItems.length} pirs',
          AppRoutes.enQuizHub, const Color(0xFF43A047)),
      _Skill('📖', 'Xwendin', 'Reading', 'Deqên xwendinê — ${kEnReadingPassages.length} pasaj',
          AppRoutes.enReading, const Color(0xFFEF6C00)),
      _Skill('✍️', 'Nivîsîn', 'Writing', 'Nivîsîn/dîkte — ${kEnWritingExercises.length} kar',
          AppRoutes.enWriting, const Color(0xFF7B1FA2)),
      _Skill('👂', 'Guhdarîkirin', 'Listening', 'Guhdarîkirin — ${kEnListeningExercises.length} kar',
          AppRoutes.enListening, const Color(0xFF00838F)),
      _Skill('🗣️', 'Axaftin', 'Speaking', 'Axaftin û telafuz — ${kEnSpeakingExercises.length} kar',
          AppRoutes.enSpeaking, const Color(0xFFD81B60)),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            const Text('🌍', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Text('Jêhatîyên Îngilîzî',
                style: AppTypography.headingSmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                )),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kîjan jêhatîyê dixwazî meşq bikî?',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Expanded(
                    child: ListView.builder(
                      itemCount: skills.length,
                      itemBuilder: (_, i) {
                        final s = skills[i];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _SkillCard(skill: s),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Skill {
  final String emoji;
  final String titleKu;
  final String titleEn;
  final String subtitle;
  final String route;
  final Color color;
  const _Skill(this.emoji, this.titleKu, this.titleEn, this.subtitle,
      this.route, this.color);
}

class _SkillCard extends StatelessWidget {
  final _Skill skill;
  const _SkillCard({required this.skill});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push(skill.route),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                skill.color.withValues(alpha: 0.15),
                skill.color.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border:
                Border.all(color: skill.color.withValues(alpha: 0.3), width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: skill.color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(skill.emoji,
                    style: const TextStyle(fontSize: 28)),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(skill.titleKu,
                            style: AppTypography.title.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w800,
                            )),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: skill.color.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(skill.titleEn,
                              style: TextStyle(
                                color: skill.color,
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(skill.subtitle,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        )),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded,
                  color: skill.color, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
