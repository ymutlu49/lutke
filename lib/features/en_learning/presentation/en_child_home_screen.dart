import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/child_theme.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/providers/learning_track_provider.dart';
import '../../child_mode/domain/bizer_evolution.dart';
import '../domain/en_child_a1_kelime_db.dart';
import '../domain/en_child_a2_kelime_db.dart';
import '../domain/en_word.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — English Child Home Screen
//
// Designed for 7-10 year olds learning English through Kurmancî.
// Primary UI is English (target language), with Kurmancî helper
// captions so a TR/KU caregiver or learner can support the child.
//
// Notes:
//   - Only rendered when the active track is `englishChild`.
//   - Deep-link ile /en/child/home'a girildiğinde activeTrackProvider
//     Kurmancî'de kalabilir. Bu nedenle EnChildHomeScreen ConsumerStateful
//     olarak ilk frame'de track'i englishChild'a senkronlar.
//   - Shares the bottom nav with the Kurmancî child shell.
// ════════════════════════════════════════════════════════════════

class EnChildHomeScreen extends ConsumerStatefulWidget {
  const EnChildHomeScreen({super.key});

  @override
  ConsumerState<EnChildHomeScreen> createState() => _EnChildHomeScreenState();
}

class _EnChildHomeScreenState extends ConsumerState<EnChildHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final current = ref.read(activeTrackProvider);
      if (current != LearningTrack.englishChild) {
        ref
            .read(activeTrackProvider.notifier)
            .setTrack(LearningTrack.englishChild);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const _EnChildHomeBody();
  }
}

class _EnChildHomeBody extends ConsumerWidget {
  const _EnChildHomeBody();

  // Brand purple used across the EN child theme.
  static const _enPrimary = Color(0xFF6A1B9A);
  static const _enPrimaryLight = Color(0xFFAB47BC);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessons = _buildLessons();
    // Karîk track-agnostik; stars ikisinden de besleniyor.
    final karikStars = ref.watch(karikEvolutionProvider).totalStars;
    // A11Y: Respect MediaQuery.disableAnimations (system-level dyslexia /
    // vestibular setting). If true, we skip flutter_animate enhancements.
    final reduceMotion = MediaQuery.of(context).disableAnimations;

    return Scaffold(
      backgroundColor: ChildColors.backgroundPrimary,
      body: SafeArea(
        child: CustomScrollView(
          // A11Y: Hint that this is a scrollable region for assistive tech.
          semanticChildCount: lessons.length,
          slivers: [
            // ── Header / Welcome ──────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Semantics(
                  // H1: page heading for screen readers.
                  header: true,
                  label: 'Welcome, friend! Bi xêr hatî, hevalê min',
                  child: Row(
                    children: [
                      _HeaderAvatar(reduceMotion: reduceMotion),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome, friend!',
                              style: ChildTypography.headline.copyWith(
                                color: _enPrimary,
                              ),
                            ),
                            // A11Y dyslexia: Italics degrade legibility.
                            // BDA Style Guide 2023 — avoid italics for body
                            // text. Keep upright, distinguish by color/weight.
                            Text(
                              'Bi xêr hatî, hevalê min!',
                              style: ChildTypography.body.copyWith(
                                color: ChildColors.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Question prompt ───────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                child: _MaybeAnimated(
                  reduceMotion: reduceMotion,
                  delayMs: 120,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: _enPrimary.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _enPrimary.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Semantics(
                      label:
                          'What will you learn today? Tu îro dê çi hîn bibî?',
                      container: true,
                      child: Row(
                        children: [
                          // Decorative emoji — hide from screen reader.
                          ExcludeSemantics(
                            child: const Text(
                              '💬',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'What will you learn today?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: _enPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                // A11Y: removed italics (BDA 2023).
                                Text(
                                  'Tu îro dê çi hîn bibî?',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: ChildColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ── Progress / Stats Banner ───────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: _MaybeAnimated(
                  reduceMotion: reduceMotion,
                  delayMs: 200,
                  child: Semantics(
                    label:
                        '${kEnChildA1Liste.length} A1 words, ${kEnChildA2Liste.length} A2 words, $karikStars stars',
                    container: true,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _enPrimaryLight.withValues(alpha: 0.12),
                            ChildColors.starYellow.withValues(alpha: 0.08),
                          ],
                        ),
                        borderRadius:
                            BorderRadius.circular(ChildSpacing.radiusLg),
                        border: Border.all(
                          color: _enPrimaryLight.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _Stat(
                            icon: '🔤',
                            value: '${kEnChildA1Liste.length}',
                            label: 'A1 Words',
                            labelKu: 'Peyvên A1',
                          ),
                          _sep(),
                          _Stat(
                            icon: '📚',
                            value: '${kEnChildA2Liste.length}',
                            label: 'A2 Words',
                            labelKu: 'Peyvên A2',
                          ),
                          _sep(),
                          _Stat(
                            icon: '⭐',
                            value: '$karikStars',
                            label: 'Stars',
                            labelKu: 'Stêr',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ── Play games CTA ────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                child: _MaybeAnimated(
                  reduceMotion: reduceMotion,
                  delayMs: 260,
                  child: _PlayGamesBanner(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Lîstik di rê de ne · Games coming soon!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // ── Lessons Section Header ────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 8),
                child: Semantics(
                  // H2: section heading.
                  header: true,
                  label: 'My Lessons — Waneyên min',
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ExcludeSemantics(
                        child: const Text('📝', style: TextStyle(fontSize: 22)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Lessons',
                              style: ChildTypography.title,
                            ),
                            // A11Y: removed italics per BDA guidance.
                            Text(
                              'Waneyên min',
                              style: TextStyle(
                                fontSize: 12,
                                color: ChildColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Lesson Cards ──────────────────────────────────
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList.builder(
                itemCount: lessons.length,
                itemBuilder: (_, i) {
                  final l = lessons[i];
                  final card = Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _EnChildLessonCard(
                      emoji: l.emoji,
                      titleEn: l.titleEn,
                      titleKu: l.titleKu,
                      wordCount: l.wordCount,
                      color: l.color,
                      onTap: () {
                        // UX FIX (Nisan 2026): Önceden sadece snackbar
                        // gösteriyordu — çocuk dersine hiç giremezdi.
                        // Artık KU ile ortak UnitHub'a gidiyor; hub track-aware.
                        context.push(
                          AppRoutes.childUnitHub,
                          extra: {
                            'category': l.categoryKey,
                            'titleKu': l.titleEn, // EN child için primary=EN
                            'titleTr': l.titleKu,
                            'emoji': l.emoji,
                            'level': 'A1',
                          },
                        );
                      },
                    ),
                  );
                  if (reduceMotion) return card;
                  return card.animate().fadeIn(
                        delay: Duration(milliseconds: 200 + i * 80),
                      );
                },
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  Widget _sep() => Container(
        width: 1,
        height: 40,
        color: _enPrimaryLight.withValues(alpha: 0.2),
      );

  List<_EnChildLesson> _buildLessons() {
    // Group A1 words by category.
    final byCategory = <String, List<EnWord>>{};
    for (final w in kEnChildA1Liste) {
      byCategory.putIfAbsent(w.kat, () => []).add(w);
    }

    // Category metadata: (emoji, English title, Kurmancî title, color).
    // Order shown to the child reflects the suggested learning sequence:
    // Greetings → Family → Colors → Animals → Numbers → Food → ...
    // NOT: Anahtarlar DB'deki `kat` değerleriyle birebir uyumlu olmalı.
    // (hejmar→jimar, las→beden, listik→leyîstik, hest→his düzeltildi)
    final categoryMeta = <String, (String, String, String, Color)>{
      'silav':     ('👋', 'Greetings',   'Silav',    Color(0xFF1A7B6B)),
      'selamlama': ('👋', 'Greetings',   'Silav',    Color(0xFF1A7B6B)),
      'malbat':    ('👨‍👩‍👧', 'Family',    'Malbat',   Color(0xFF7B1FA2)),
      'reng':      ('🎨', 'Colors',      'Reng',     Color(0xFFE91E63)),
      'heywan':    ('🐱', 'Animals',     'Heywan',   Color(0xFFD4783A)),
      'jimar':     ('🔢', 'Numbers',     'Jimar',    Color(0xFF2196F3)),
      'xwarin':    ('🍎', 'Food',        'Xwarin',   Color(0xFF2D9E4F)),
      'beden':     ('🧍', 'Body',        'Beden',    Color(0xFF00BCD4)),
      'dibistan':  ('🏫', 'School',      'Dibistan', Color(0xFFFF8F00)),
      'leyîstik':  ('⚽', 'Toys & Play', 'Leyîstik', Color(0xFFFF5722)),
      'his':       ('😊', 'Feelings',    'His',      Color(0xFFFF8FAB)),
      'cil':       ('👕', 'Clothes',     'Cil',      Color(0xFF6A1B9A)),
      'mal':       ('🏠', 'Home',        'Mal',      Color(0xFF8D6E63)),
      'xweza':     ('🌳', 'Nature',      'Xweza',    Color(0xFF388E3C)),
      'hewa':      ('☀️', 'Weather',     'Hewa',     Color(0xFF03A9F4)),
      'rengdêr':   ('✨', 'Describing',  'Rengdêr',  Color(0xFF9C27B0)),
      'leker':     ('🏃', 'Actions',     'Leker',    Color(0xFFEF6C00)),
    };

    // Avoid duplicates when a category has aliases (e.g. silav/selamlama).
    final seenTitles = <String>{};
    final lessons = <_EnChildLesson>[];
    for (final e in categoryMeta.entries) {
      final words = byCategory[e.key] ?? const <EnWord>[];
      if (words.isEmpty) continue;
      if (!seenTitles.add(e.value.$2)) continue;
      lessons.add(
        _EnChildLesson(
          emoji: e.value.$1,
          titleEn: e.value.$2,
          titleKu: e.value.$3,
          color: e.value.$4,
          wordCount: words.length,
          categoryKey: e.key,
        ),
      );
    }
    return lessons;
  }
}

class _Stat extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  final String? labelKu;

  const _Stat({
    required this.icon,
    required this.value,
    required this.label,
    this.labelKu,
  });

  @override
  Widget build(BuildContext context) {
    // A11Y: Merge stat + label into one semantic node and mute decorative emoji.
    return Semantics(
      label: labelKu != null ? '$value $labelKu · $label' : '$value $label',
      container: true,
      excludeSemantics: true,
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 2),
          Text(
            value,
            style: ChildTypography.headline.copyWith(
              color: const Color(0xFF6A1B9A),
            ),
          ),
          Text(
            label,
            style: ChildTypography.caption.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (labelKu != null)
            Text(
              labelKu!,
              style: ChildTypography.caption.copyWith(
                fontSize: 10,
                color: ChildColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }
}

// A11Y: Header avatar extracted so `.animate()` can be skipped when the
// user (or OS) requests reduced motion. Emoji is marked decorative.
class _HeaderAvatar extends StatelessWidget {
  final bool reduceMotion;
  const _HeaderAvatar({required this.reduceMotion});

  @override
  Widget build(BuildContext context) {
    const enPrimary = Color(0xFF6A1B9A);
    const enPrimaryLight = Color(0xFFAB47BC);
    final w = ExcludeSemantics(
      child: Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [enPrimaryLight, enPrimary],
          ),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text('🌍', style: TextStyle(fontSize: 28)),
        ),
      ),
    );
    if (reduceMotion) return w;
    return w
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .moveY(begin: 0, end: -4, duration: 1200.ms);
  }
}

/// A11Y helper: wraps a child with flutter_animate fadeIn/slideY unless the
/// OS-level `disableAnimations` flag is on (Android: Remove animations,
/// iOS: Reduce Motion, Windows: show animations off). For dyslexia &
/// vestibular accessibility — WCAG 2.3.3 Animation from Interactions.
class _MaybeAnimated extends StatelessWidget {
  final Widget child;
  final int delayMs;
  final bool reduceMotion;

  const _MaybeAnimated({
    required this.child,
    required this.delayMs,
    required this.reduceMotion,
  });

  @override
  Widget build(BuildContext context) {
    if (reduceMotion) return child;
    return child
        .animate()
        .fadeIn(delay: Duration(milliseconds: delayMs))
        .slideY(begin: 0.08);
  }
}

class _PlayGamesBanner extends StatelessWidget {
  final VoidCallback onTap;
  const _PlayGamesBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    // A11Y: GestureDetector is not keyboard-focusable and has no ink feedback.
    // Switched to Material + InkWell + Semantics button. Touch target is
    // inherently ≥48dp (padding 32 + font 18 = ~66dp high).
    return Semantics(
      button: true,
      label: 'Play games. Lîstikan bilîze — have fun while you learn',
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFB74D), Color(0xFFFF8F00)],
              ),
              borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF8F00).withValues(alpha: 0.25),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ExcludeSemantics(
              child: Row(
                children: [
                  const Text('🎮', style: TextStyle(fontSize: 32)),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Play games!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2),
                        // A11Y: removed italics (BDA 2023).
                        Text(
                          'Lîstikan bilîze · Have fun while you learn',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.play_arrow_rounded,
                    size: 32,
                    color: Colors.white,
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

class _EnChildLesson {
  final String emoji;
  final String titleEn;
  final String titleKu;
  final Color color;
  final int wordCount;
  final String categoryKey; // en_child DB'deki `kat` değeri (ör. 'heywan')

  const _EnChildLesson({
    required this.emoji,
    required this.titleEn,
    required this.titleKu,
    required this.color,
    required this.wordCount,
    required this.categoryKey,
  });
}

class _EnChildLessonCard extends StatelessWidget {
  final String emoji;
  final String titleEn;
  final String titleKu;
  final int wordCount;
  final Color color;
  final VoidCallback onTap;

  const _EnChildLessonCard({
    required this.emoji,
    required this.titleEn,
    required this.titleKu,
    required this.wordCount,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // A11Y: GestureDetector → Material+InkWell for focus ring & keyboard
    // activation. Whole card announced as single button with descriptive
    // label combining EN + KU titles + word count.
    return Semantics(
      button: true,
      label: '$titleEn, $titleKu, $wordCount peyv · words',
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
          child: Container(
            constraints: const BoxConstraints(minHeight: 88),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.14),
                  color.withValues(alpha: 0.04),
                ],
              ),
              borderRadius: BorderRadius.circular(ChildSpacing.radiusLg),
              border:
                  Border.all(color: color.withValues(alpha: 0.3), width: 2),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.15),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ExcludeSemantics(
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          color.withValues(alpha: 0.22),
                          color.withValues(alpha: 0.06),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                      child:
                          Text(emoji, style: const TextStyle(fontSize: 34)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titleEn,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: color,
                            height: 1.1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        // A11Y: italics removed — BDA / dyslexia guidance.
                        // Weight w500 keeps KU secondary but legible.
                        Text(
                          titleKu,
                          style: TextStyle(
                            fontSize: 13,
                            color: ChildColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '$wordCount peyv · words',
                            style: TextStyle(
                              fontSize: 11,
                              color: color,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: color,
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
