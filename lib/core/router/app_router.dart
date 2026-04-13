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
import '../../features/cultural_content/culture_screen.dart';
import '../../features/exercises/presentation/flashcard_screen.dart';
import '../../features/exercises/presentation/quiz_screen.dart';

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
  static const home             = '/home';
  static const vocabulary       = '/vocabulary';
  static const culture          = '/culture';
  static const profile          = '/profile';
  static const lesson           = '/lesson';
  static const settings         = '/settings';
  static const welcome          = '/welcome';
  static const admin            = '/admin';
  static const wordDetail       = '/word-detail';
  static const flashcard        = '/flashcard';
  static const quiz             = '/quiz';
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
      if (isLoggedIn && isOnAuth) return AppRoutes.home;
      return null;
    },

    routes: [
      // ── Splash & Onboarding (shell dışı) ───────────────────
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, __) => const SplashScreen(),
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
          // Tab 0: Fêrbûn (Ana sayfa)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (_, __) => const HomeScreen(),
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

          // Tab 2: Çand (Kültür)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.culture,
                builder: (_, __) => const CultureScreen(),
              ),
            ],
          ),

          // Tab 3: Profîl
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

      // ── Shell dışı sayfalar (tam ekran) ─────────────────────
      GoRoute(
        path: AppRoutes.lesson,
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return LessonScreen(
            mode: extra?['mode'] as String? ?? 'lesson',
            lessonId: extra?['lessonId'] as String?,
            userId: extra?['userId'] as String? ?? 'anonymous',
          );
        },
      ),
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
        path: AppRoutes.flashcard,
        builder: (_, __) => const FlashcardScreen(),
      ),
      GoRoute(
        path: AppRoutes.quiz,
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final level = extra?['level'] as String? ?? 'A1';
          return QuizScreen(level: level);
        },
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
        onTap: (i) => shell.goBranch(i, initialLocation: i == shell.currentIndex),
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
                icon: Icons.music_note_rounded,
                label: 'Çand',
                isActive: currentIndex == 2,
                onTap: () => onTap(2),
              ),
              _Tab(
                icon: Icons.person_rounded,
                label: 'Profîl',
                isActive: currentIndex == 3,
                onTap: () => onTap(3),
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
// KÜLTÜR EKRANI -> culture_screen.dart'a taşındı
// ════════════════════════════════════════════════════════════════

