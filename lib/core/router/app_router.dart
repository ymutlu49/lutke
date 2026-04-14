import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/admin/admin_panel_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/lessons/presentation/home_screen.dart';
import '../../features/lessons/presentation/lesson_screen.dart';
import '../../features/lessons/presentation/vocabulary_browse_screen.dart';
import '../../features/lessons/presentation/word_detail_screen.dart';
import '../../features/onboarding/splash_screen.dart';
import '../../features/onboarding/passive_test_screen.dart';
import '../../features/onboarding/motivation_anchor_screen.dart';
import '../../features/onboarding/onboarding_screens.dart';
import '../../features/onboarding/first_lesson_screen.dart';
import '../../features/onboarding/welcome_flow_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';
import '../services/auth_service.dart';
import '../services/sound_service.dart';
import '../../features/cultural_content/culture_screen.dart';
import '../../features/exercises/presentation/flashcard_screen.dart';
import '../../features/exercises/presentation/quiz_screen.dart';
import '../../features/exercises/presentation/sentence_builder_screen.dart';
import '../../features/exercises/presentation/word_match_screen.dart';
import '../../features/exercises/presentation/story_screen.dart';
import '../../features/grammar/grammar_tips_screen.dart';
import '../../features/exercises/presentation/smart_review_screen.dart';
import '../../features/lessons/presentation/progress_map_screen.dart';
import '../../features/exercises/presentation/listening_screen.dart';
import '../../features/lessons/presentation/unit_hub_screen.dart';
import '../../features/child_mode/presentation/mode_selection_screen.dart';
import '../../features/child_mode/presentation/child_home_screen.dart';
import '../../features/child_mode/presentation/child_vocabulary_screen.dart';
import '../../features/child_mode/presentation/child_profile_screen.dart';
import '../../features/child_mode/presentation/child_onboarding_screen.dart';
import '../../features/child_mode/presentation/child_progress_map_screen.dart';
import '../../features/child_mode/presentation/parental_controls_screen.dart';
import '../../features/child_mode/presentation/widgets/child_mode_wrapper.dart';
import '../../shared/providers/child_mode_provider.dart';

part 'app_router.g.dart';

// ════════════════════════════════════════════════════════════════
// ROTALAR — LÛTKE
// ════════════════════════════════════════════════════════════════

abstract class AppRoutes {
  static const splash           = '/';
  static const passiveTest      = '/onboarding/passive-test';
  static const motivationAnchor = '/onboarding/motivation';
  static const dialectSelect    = '/onboarding/dialect';
  static const scenarioSelect   = '/onboarding/scenario';
  static const goalSelect       = '/onboarding/goal';
  static const firstLesson      = '/onboarding/first-lesson';
  static const register         = '/auth/register';
  static const login            = '/auth/login';
  static const modeSelect       = '/mode-select';
  static const home             = '/home';
  static const vocabulary       = '/vocabulary';
  static const culture          = '/culture';
  static const profile          = '/profile';
  static const lesson           = '/home/lesson';
  static const settings         = '/settings';
  static const welcome          = '/welcome';
  static const admin            = '/admin';
  static const wordDetail       = '/word-detail';
  static const flashcard         = '/home/flashcard';
  static const quiz              = '/home/quiz';
  static const sentenceBuilder   = '/home/sentence-builder';
  static const wordMatch         = '/home/word-match';
  static const grammar           = '/grammar';
  static const story             = '/home/story';
  static const review            = '/home/review';
  static const progressMap       = '/progress-map';
  static const listening         = '/home/listening';

  static const unitHub               = '/unit-hub';

  // ── Lûtke Zarok (Çocuk Modu) ────────────────────────────────
  static const childOnboarding       = '/child/onboarding';
  static const childHome             = '/child/home';
  static const childWords            = '/child/words';
  static const childProfile          = '/child/profile';
  static const childLesson           = '/child/home/lesson';
  static const childParentalControls = '/child/parental-controls';
  static const childProgressMap      = '/child/progress-map';
}

// ════════════════════════════════════════════════════════════════
// SHELL — Kalıcı alt navigasyon
// ════════════════════════════════════════════════════════════════

final _shellKey = GlobalKey<NavigatorState>();
final _rootKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: false,

    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final isOnAuth = state.matchedLocation.startsWith('/auth');
      final isOnSplash = state.matchedLocation == AppRoutes.splash;
      final isOnWelcome = state.matchedLocation == AppRoutes.welcome;

      if (isOnSplash || isOnWelcome) return null;
      if (isLoggedIn && isOnAuth) return AppRoutes.modeSelect;
      return null;
    },

    routes: [
      // ── Splash & Onboarding (shell dışı) ───────────────────
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.modeSelect,
        builder: (_, __) => const ModeSelectionScreen(),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (_, __) => const WelcomeFlowScreen(),
      ),
      GoRoute(
        path: AppRoutes.passiveTest,
        builder: (_, __) => const PassiveTestScreen(),
      ),
      GoRoute(
        path: AppRoutes.motivationAnchor,
        builder: (_, __) => const MotivationAnchorScreen(),
      ),
      GoRoute(
        path: AppRoutes.dialectSelect,
        builder: (_, __) => const DialectSelectScreen(),
      ),
      GoRoute(
        path: AppRoutes.scenarioSelect,
        builder: (_, __) => const ScenarioSelectScreen(),
      ),
      GoRoute(
        path: AppRoutes.goalSelect,
        builder: (_, __) => const GoalSelectScreen(),
      ),
      GoRoute(
        path: AppRoutes.firstLesson,
        builder: (_, __) => const FirstLessonScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (_, __) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (_, __) => const RegisterScreen(isLogin: true),
      ),

      // ── Ana uygulama — Shell ile kalıcı bottom nav ─────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => _AppShell(shell: shell),
        branches: [
          // Tab 0: Fêrbûn (Ana sayfa + quiz/flashcard alt sayfaları)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (_, __) => const HomeScreen(),
                routes: [
                  GoRoute(
                    path: 'quiz',
                    builder: (_, state) {
                      final extra = state.extra as Map<String, dynamic>?;
                      return QuizScreen(
                        level: extra?['level'] as String? ?? 'A1',
                        category: extra?['category'] as String?,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'flashcard',
                    builder: (_, state) {
                      final extra = state.extra as Map<String, dynamic>?;
                      return FlashcardScreen(
                        category: extra?['category'] as String?,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'sentence-builder',
                    builder: (_, state) {
                      final extra = state.extra as Map<String, dynamic>?;
                      return SentenceBuilderScreen(
                        category: extra?['category'] as String?,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'word-match',
                    builder: (_, state) {
                      final extra = state.extra as Map<String, dynamic>?;
                      return WordMatchScreen(
                        category: extra?['category'] as String?,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'story',
                    builder: (_, __) => const StoryScreen(),
                  ),
                  GoRoute(
                    path: 'review',
                    builder: (_, __) => const SmartReviewScreen(),
                  ),
                  GoRoute(
                    path: 'listening',
                    builder: (_, state) {
                      final extra = state.extra as Map<String, dynamic>?;
                      return ListeningScreen(
                        category: extra?['category'] as String?,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'lesson',
                    builder: (_, state) {
                      final extra = state.extra as Map<String, dynamic>?;
                      return LessonScreen(
                        mode: extra?['mode'] as String? ?? 'lesson',
                        lessonId: extra?['lessonId'] as String?,
                        userId: extra?['userId'] as String? ?? 'anonymous',
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // Tab 1: Peyv (Kelimeler)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.vocabulary,
                builder: (_, __) => const VocabularyBrowseScreen(),
              ),
            ],
          ),

          // Tab 2: Rêziman (Gramer)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.grammar,
                builder: (_, __) => const GrammarTipsScreen(),
              ),
            ],
          ),

          // Tab 3: Çand (Kültür)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.culture,
                builder: (_, __) => const CultureScreen(),
              ),
            ],
          ),

          // Tab 4: Profîl
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (_, __) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // ── Etkinlikler (shell dışı — unit hub'dan erişim) ─────
      GoRoute(
        path: '/activity/quiz',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return QuizScreen(
            level: extra?['level'] as String? ?? 'A1',
            category: extra?['category'] as String?,
          );
        },
      ),
      GoRoute(
        path: '/activity/flashcard',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return FlashcardScreen(
            category: extra?['category'] as String?,
            level: extra?['level'] as String? ?? 'A1',
          );
        },
      ),
      GoRoute(
        path: '/activity/listening',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return ListeningScreen(
            category: extra?['category'] as String?,
            level: extra?['level'] as String? ?? 'A1',
          );
        },
      ),
      GoRoute(
        path: '/activity/sentence-builder',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return SentenceBuilderScreen(
            category: extra?['category'] as String?,
            level: extra?['level'] as String? ?? 'A1',
          );
        },
      ),
      GoRoute(
        path: '/activity/word-match',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return WordMatchScreen(
            category: extra?['category'] as String?,
            level: extra?['level'] as String? ?? 'A1',
          );
        },
      ),

      // ── Birim Hub — Durak detay ekranı ────────────────────
      GoRoute(
        path: AppRoutes.unitHub,
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return UnitHubScreen(
            category: extra['category'] as String? ?? '',
            titleKu: extra['titleKu'] as String? ?? '',
            titleTr: extra['titleTr'] as String? ?? '',
            icon: extra['icon'] as IconData? ?? Icons.menu_book_rounded,
            wordCount: extra['wordCount'] as int? ?? 0,
            level: extra['level'] as String? ?? 'A1',
          );
        },
      ),

      // ── Lûtke Zarok — Çocuk Onboarding ────────────────────
      GoRoute(
        path: AppRoutes.childOnboarding,
        builder: (_, __) => const ChildOnboardingScreen(),
      ),

      // ── Lûtke Zarok — 3 sekmeli çocuk navigasyonu ────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => ChildModeWrapper(
          child: _ChildAppShell(shell: shell),
        ),
        branches: [
          // Tab 0: Lîstik (Oyna)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.childHome,
                builder: (_, __) => const ChildHomeScreen(),
                routes: [
                  GoRoute(
                    path: 'lesson',
                    builder: (_, state) {
                      final extra = state.extra as Map<String, dynamic>?;
                      return LessonScreen(
                        mode: 'child',
                        lessonId: extra?['lessonId'] as String?,
                        userId: extra?['userId'] as String? ?? 'anonymous',
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // Tab 1: Peyvên min (Kelimelerim)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.childWords,
                builder: (_, __) => const ChildVocabularyScreen(),
              ),
            ],
          ),

          // Tab 2: Ez (Profilim)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.childProfile,
                builder: (_, __) => const ChildProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // ── Çocuk — Ebeveyn Kontrol Paneli ────────────────────
      GoRoute(
        path: AppRoutes.childParentalControls,
        builder: (_, __) => const ParentalControlsScreen(),
      ),
      GoRoute(
        path: AppRoutes.childProgressMap,
        builder: (_, __) => const ChildProgressMapScreen(),
      ),

      // ── Shell dışı sayfalar ─────────────────────────────────
      GoRoute(
        path: AppRoutes.admin,
        builder: (_, __) => const AdminPanelScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (_, __) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.wordDetail,
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>;
          return WordDetailScreen(
            word: extra['word'],
            levelColor: extra['levelColor'] as Color? ?? AppColors.primary,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.progressMap,
        builder: (_, __) => const ProgressMapScreen(),
      ),
    ],

    errorBuilder: (_, state) => ErrorScreen(error: state.error),
  );
}

// ════════════════════════════════════════════════════════════════
// APP SHELL — 4 sekmeli kalıcı navigasyon
// ════════════════════════════════════════════════════════════════

class _AppShell extends StatelessWidget {
  final StatefulNavigationShell shell;
  const _AppShell({required this.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: _PersistentBottomNav(
        currentIndex: shell.currentIndex,
        onTap: (i) {
          SoundService.playClick();
          shell.goBranch(i, initialLocation: i == shell.currentIndex);
        },
      ),
    );
  }
}

class _PersistentBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _PersistentBottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              _Tab(
                icon: Icons.menu_book_rounded,
                label: 'Fêrbûn',
                isActive: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              _Tab(
                icon: Icons.translate_rounded,
                label: 'Peyv',
                isActive: currentIndex == 1,
                onTap: () => onTap(1),
              ),
              _Tab(
                icon: Icons.auto_stories_rounded,
                label: 'Rêziman',
                isActive: currentIndex == 2,
                onTap: () => onTap(2),
              ),
              _Tab(
                icon: Icons.music_note_rounded,
                label: 'Çand',
                isActive: currentIndex == 3,
                onTap: () => onTap(3),
              ),
              _Tab(
                icon: Icons.person_rounded,
                label: 'Profîl',
                isActive: currentIndex == 4,
                onTap: () => onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _Tab({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 48,
              height: 28,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary.withOpacity(0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                size: 22,
                color: isActive ? AppColors.primary : Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? AppColors.primary : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// CHILD APP SHELL — 3 sekmeli çocuk navigasyonu
// ════════════════════════════════════════════════════════════════

class _ChildAppShell extends StatelessWidget {
  final StatefulNavigationShell shell;
  const _ChildAppShell({required this.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: _ChildBottomNav(
        currentIndex: shell.currentIndex,
        onTap: (i) {
          SoundService.playClick();
          shell.goBranch(i, initialLocation: i == shell.currentIndex);
        },
      ),
    );
  }
}

class _ChildBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _ChildBottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              _ChildTab(
                icon: Icons.play_circle_filled_rounded,
                label: 'Lîstik',
                isActive: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              _ChildTab(
                icon: Icons.auto_stories_rounded,
                label: 'Peyvên min',
                isActive: currentIndex == 1,
                onTap: () => onTap(1),
              ),
              _ChildTab(
                icon: Icons.face_rounded,
                label: 'Ez',
                isActive: currentIndex == 2,
                onTap: () => onTap(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChildTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ChildTab({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 56,
              height: 36,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary.withOpacity(0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                icon,
                size: 28,
                color: isActive ? AppColors.primary : Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? AppColors.primary : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// KÜLTÜR EKRANI -> culture_screen.dart'a taşındı
// ════════════════════════════════════════════════════════════════

