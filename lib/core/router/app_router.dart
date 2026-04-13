import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/admin/admin_panel_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/lessons/presentation/home_screen.dart';
import '../../features/lessons/presentation/lesson_screen.dart';
import '../../features/lessons/presentation/vocabulary_browse_screen.dart';
import '../../features/onboarding/splash_screen.dart';
import '../../features/onboarding/passive_test_screen.dart';
import '../../features/onboarding/motivation_anchor_screen.dart';
import '../../features/onboarding/onboarding_screens.dart';
import '../../features/onboarding/first_lesson_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../services/auth_service.dart';

// Otomatik oluşturulan kod: dart run build_runner build
part 'app_router.g.dart';

// ════════════════════════════════════════════════════════════════
// ROTALAR — LÛTKE
// İlke §2: Onboarding → Heritage/Genel yol ayrımı
// İlke §0.5: Her yol Kurmancî dünyasında başlar
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
  static const lesson           = '/lesson';
  static const profile          = '/profile';
  static const settings         = '/settings';
  static const vocabulary       = '/vocabulary';
  static const admin            = '/admin';
}

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: false,

    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final isOnAuth = state.matchedLocation.startsWith('/auth');
      final isOnSplash = state.matchedLocation == AppRoutes.splash;

      if (isOnSplash) return null;
      if (isLoggedIn && isOnAuth) return AppRoutes.home;
      return null;
    },

    routes: [

      // ── SPLASH ─────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // ── ONBOARDING ─────────────────────────────────────────
      // §2: "Feel first, play second"
      // §9b bulgu #1: pasif anlama testi
      GoRoute(
        path: AppRoutes.passiveTest,
        builder: (context, state) => const PassiveTestScreen(),
      ),
      GoRoute(
        path: AppRoutes.motivationAnchor,
        builder: (context, state) => const MotivationAnchorScreen(),
      ),
      GoRoute(
        path: AppRoutes.dialectSelect,
        builder: (context, state) => const DialectSelectScreen(),
      ),
      GoRoute(
        path: AppRoutes.scenarioSelect,
        builder: (context, state) => const ScenarioSelectScreen(),
      ),
      GoRoute(
        path: AppRoutes.goalSelect,
        builder: (context, state) => const GoalSelectScreen(),
      ),
      GoRoute(
        path: AppRoutes.firstLesson,
        builder: (context, state) => const FirstLessonScreen(),
      ),

      // ── AUTH ───────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const RegisterScreen(isLogin: true),
      ),

      // ── ANA UYGULAMA ───────────────────────────────────────
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),

      GoRoute(
        path: AppRoutes.lesson,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return LessonScreen(
            mode: extra?['mode'] as String? ?? 'lesson',
            lessonId: extra?['lessonId'] as String?,
            userId: extra?['userId'] as String? ?? 'anonymous',
          );
        },
      ),

      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),

      GoRoute(
        path: AppRoutes.vocabulary,
        builder: (context, state) => const VocabularyBrowseScreen(),
      ),

      GoRoute(
        path: AppRoutes.admin,
        builder: (context, state) => const AdminPanelScreen(),
      ),

      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],

    errorBuilder: (context, state) => ErrorScreen(error: state.error),
  );
}
