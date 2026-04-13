import 'package:flutter/material.dart';
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
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';
import '../services/auth_service.dart';
import '../../features/cultural_content/cultural_entities.dart';

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
  static const admin            = '/admin';
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

      if (isOnSplash) return null;
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
                builder: (_, __) => const _CulturePlaceholder(),
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
// KÜLTÜR PLACEHOLDER
// ════════════════════════════════════════════════════════════════

class _CulturePlaceholder extends StatelessWidget {
  const _CulturePlaceholder();

  @override
  Widget build(BuildContext context) {
    final items = kCulturalItems;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        title: Row(
          children: [
            ClipOval(child: Image.asset('assets/images/logo_128.png', width: 44, height: 44, fit: BoxFit.cover,
              filterQuality: FilterQuality.medium)),
            const SizedBox(width: 10),
            Text('Çand — Kültür',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text('${items.length} içerik',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _CultureCard(item: item);
        },
      ),
    );
  }
}

class _CultureCard extends StatefulWidget {
  final CulturalItem item;
  const _CultureCard({required this.item});

  @override
  State<_CultureCard> createState() => _CultureCardState();
}

class _CultureCardState extends State<_CultureCard> {
  bool _expanded = false;

  IconData _typeIcon(CulturalContentType type) => switch (type) {
    CulturalContentType.proverb => Icons.format_quote_rounded,
    CulturalContentType.song => Icons.music_note_rounded,
    CulturalContentType.celebration => Icons.celebration_rounded,
    CulturalContentType.poem => Icons.auto_stories_rounded,
    CulturalContentType.story => Icons.menu_book_rounded,
    CulturalContentType.foodTradition => Icons.restaurant_rounded,
    CulturalContentType.culturalNote => Icons.info_outline_rounded,
  };

  Color _typeColor(CulturalContentType type) => switch (type) {
    CulturalContentType.proverb => const Color(0xFF4CAF50),
    CulturalContentType.song => const Color(0xFFE91E63),
    CulturalContentType.celebration => const Color(0xFFFF9800),
    CulturalContentType.poem => const Color(0xFF9C27B0),
    CulturalContentType.story => const Color(0xFF2196F3),
    CulturalContentType.foodTradition => const Color(0xFF795548),
    CulturalContentType.culturalNote => const Color(0xFF607D8B),
  };

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final color = _typeColor(item.type);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withOpacity(0.15)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(_typeIcon(item.type), color: color, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.kurmanjTitle,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 2),
                        Text(item.turkishTitle,
                          style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  Icon(_expanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.textSecondary),
                ],
              ),

              if (_expanded) ...[
                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 12),

                // Kurmancî içerik
                Text(item.kurmanjContent,
                  style: const TextStyle(fontSize: 14, height: 1.6)),

                const SizedBox(height: 12),

                // Türkçe içerik
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundSecondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(item.turkishContent,
                    style: TextStyle(fontSize: 13, height: 1.5,
                      color: AppColors.textSecondary)),
                ),

                if (item.backgroundNote != null) ...[
                  const SizedBox(height: 8),
                  Text('📝 ${item.backgroundNote!}',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic)),
                ],

                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(item.typeLabel,
                        style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(width: 8),
                    Text('Seviye ${item.level}',
                      style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
