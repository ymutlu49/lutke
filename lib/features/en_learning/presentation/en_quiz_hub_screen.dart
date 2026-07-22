import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../domain/en_quiz_items.dart';
import 'en_special_quiz_screen.dart';

/// Quiz tipi seçici — 8 kategori arasından birini seç.
class EnQuizHubScreen extends StatelessWidget {
  const EnQuizHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Tiplere göre sayım
    final counts = <String, int>{};
    for (final q in kEnQuizItems) {
      counts[q.type] = (counts[q.type] ?? 0) + 1;
    }

    final categories = [
      _QuizCat('article', '🅰️', 'Artîkel', 'a / an / the', counts['article'] ?? 0),
      _QuizCat('past', '⏪', 'Dema borî', 'go → went, see → saw', counts['past'] ?? 0),
      _QuizCat('plural', '➕', 'Pirjimar', 'child → children', counts['plural'] ?? 0),
      _QuizCat('prep', '📍', 'Daçek', 'in / on / at', counts['prep'] ?? 0),
      _QuizCat('phrasal', '🔗', 'Lêkerên frazî', 'get up, look for', counts['phrasal'] ?? 0),
      _QuizCat('collocation', '🤝', 'Hevaheng', 'make / do / say / tell', counts['collocation'] ?? 0),
      _QuizCat('compare', '📊', 'Berawirdkirin', 'bigger / biggest', (counts['compare'] ?? 0) + (counts['superlative'] ?? 0) + (counts['as_as'] ?? 0)),
      _QuizCat('synonym', '≈', 'Hevwate û Dijwate', 'big ≈ large, hot ↔ cold', (counts['synonym'] ?? 0) + (counts['antonym'] ?? 0)),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          tooltip: 'Vegere',
          onPressed: () => context.canPop() ? context.pop() : context.go(AppRoutes.enHome),
        ),
        title: Semantics(
          // A11Y: screen-level heading for assistive tech.
          header: true,
          label: 'Testên Îngilîzî — English tests',
          child: Row(
            children: [
              // A11Y: decorative emoji.
              ExcludeSemantics(
                child: const Text('🎯', style: TextStyle(fontSize: 22)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Testên Îngilîzî',
                  style: AppTypography.headingSmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
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
                  // A11Y: left-aligned — dyslexia best practice.
                  Text(
                    'Tu dixwazî li ser kîjan mijarê test bikî?',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Expanded(
                    // A11Y: MediaQuery.textScaler check — at large text
                    // scales we loosen childAspectRatio to avoid cut-off.
                    child: Builder(
                      builder: (context) {
                        final scale =
                            MediaQuery.textScalerOf(context).scale(14) / 14;
                        // When users scale ≥1.3× (common for dyslexic
                        // learners), give each card more vertical room.
                        final aspect = scale >= 1.3 ? 0.78 : 0.95;
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: aspect,
                          ),
                          itemCount: categories.length,
                          itemBuilder: (_, i) {
                            final c = categories[i];
                            return _QuizCard(
                              cat: c,
                              onTap: () {
                                // NAV FIX (Nisan 2026): Navigator.of(context).push
                                // MaterialPageRoute bi go_router re ne li hev dikir —
                                // state stack nedihate şopandin, back-handler xelet
                                // dişopand. Ji bo tutarlılık, rootNavigator:false ile
                                // push — GoRouter Navigator'ı tanır û pop'u doğru
                                // handle dike.
                                Navigator.of(context, rootNavigator: false).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) =>
                                        EnSpecialQuizScreen(type: c.id),
                                    settings: RouteSettings(
                                      name: '${AppRoutes.enQuizHub}/${c.id}',
                                    ),
                                  ),
                                );
                              },
                            );
                          },
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

class _QuizCat {
  final String id;
  final String emoji;
  final String title;
  final String example;
  final int count;
  const _QuizCat(this.id, this.emoji, this.title, this.example, this.count);
}

class _QuizCard extends StatelessWidget {
  final _QuizCat cat;
  final VoidCallback onTap;
  const _QuizCard({required this.cat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isEmpty = cat.count == 0;
    final label = isEmpty
        ? '${cat.title} — hê pirs tune'
        : '${cat.title}, ${cat.count} pirs';
    return Semantics(
      label: label,
      button: true,
      enabled: !isEmpty,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEmpty ? null : onTap,
          borderRadius: BorderRadius.circular(16),
          // A11Y: keyboard focus ring color.
          focusColor: AppColors.accent.withValues(alpha: 0.25),
          child: Opacity(
            opacity: isEmpty ? 0.55 : 1.0,
            child: Container(
              // A11Y: ensure ≥48dp even at minimum text scales.
              constraints: const BoxConstraints(minHeight: 48),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.accent.withValues(alpha: 0.12),
                    AppColors.accent.withValues(alpha: 0.04),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // A11Y: emoji decorative — parent Semantics carries label.
                  ExcludeSemantics(
                    child: Text(
                      cat.emoji,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cat.title,
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cat.example,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isEmpty ? 'Bê pirs' : '${cat.count} pirs',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                      ),
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
