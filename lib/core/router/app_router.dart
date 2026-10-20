import 'package:flutter/foundation.dart' show kIsWeb, visibleForTesting;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/admin/admin_panel_screen.dart';
import '../../features/admin/presentation/content_editor_screen.dart';
import '../../features/auth/email_verification_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/auth/reset_password_screen.dart';
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
import '../../features/onboarding/intro_flow_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/certificate/certificate_screen.dart';
import '../constants/app_colors.dart';
import '../services/auth_service.dart';
import '../services/cloudflare_auth_service.dart';
import '../services/sound_service.dart';
import '../../features/cultural_content/culture_screen.dart';
import '../../features/cultural_content/presentation/gotinen_pesiyan_screen.dart';
import '../../features/exercises/presentation/flashcard_screen.dart';
import '../../features/exercises/presentation/quiz_screen.dart';
import '../../features/exercises/presentation/sentence_builder_screen.dart';
import '../../features/exercises/presentation/word_match_screen.dart';
import '../../features/exercises/presentation/story_screen.dart';
import '../../features/grammar/grammar_tips_screen.dart';
import '../../features/exercises/presentation/smart_review_screen.dart';
import '../../features/lessons/presentation/progress_map_screen.dart';
import '../../features/exercises/presentation/listening_screen.dart';
import '../../features/exercises/presentation/listening_pilot_screen.dart';
import '../../features/lessons/presentation/unit_hub_screen.dart';
import '../../features/lessons/presentation/wane_list_screen.dart';
import '../../features/lessons/presentation/wane_screen.dart';
import '../../features/lessons/presentation/xwendin_screen.dart';
import '../../features/en_learning/presentation/en_home_screen.dart';
import '../../features/en_learning/presentation/en_grammar_screen.dart';
import '../../features/en_learning/presentation/en_quiz_hub_screen.dart';
import '../../features/en_learning/presentation/en_skills_hub_screen.dart';
import '../../features/en_learning/presentation/en_reading_screen.dart';
import '../../features/en_learning/presentation/en_writing_screen.dart';
import '../../features/en_learning/presentation/en_listening_screen.dart';
import '../../features/en_learning/presentation/en_speaking_screen.dart';
import '../../features/exercises/presentation/ku_speaking_screen.dart';
import '../../features/exercises/presentation/ku_writing_screen.dart';
import '../../features/exercises/presentation/dialogue_screen.dart';
import '../../features/exercises/presentation/pronunciation_screen.dart';
import '../../features/child_mode/presentation/child_home_screen.dart';
import '../../features/child_mode/presentation/child_vocabulary_screen.dart';
import '../../features/child_mode/presentation/child_profile_screen.dart';
import '../../features/child_mode/presentation/child_onboarding_screen.dart';
import '../../features/child_mode/presentation/child_unit_hub_screen.dart';
import '../../features/child_mode/presentation/child_progress_map_screen.dart';
import '../../features/child_mode/presentation/child_rewards_screen.dart';
import '../../features/content_review/presentation/review_hub_screen.dart';
import '../../features/content_review/presentation/admin_review_panel.dart';
import '../../features/en_learning/presentation/en_child_home_screen.dart';
import '../../features/onboarding/track_select_screen.dart';
import '../../features/onboarding/placement_test_screen.dart';
import '../../features/legal/legal_screen.dart';
import '../../features/admin/presentation/editor_management_screen.dart';
import '../../shared/providers/learning_module_provider.dart';
import '../../shared/providers/learning_track_provider.dart';
import '../../features/child_mode/presentation/widgets/child_mode_wrapper.dart';

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
  static const emailVerification = '/auth/verify-email';
  static const resetPassword     = '/reset-password';
  // DEPRECATED: /mode-select ve /module-select rotaları track-select'e yönleniyor.
  // Eski linkleri kırmamak için redirect map'te tanımlı.
  static const modeSelect       = '/mode-select';
  static const moduleSelect     = '/module-select';
  static const enHome           = '/en/home'; // İngilizce öğrenme ana sayfası
  static const enGrammar        = '/en/grammar';
  static const enQuizHub        = '/en/quiz-hub';
  static const enSkillsHub      = '/en/skills-hub';
  static const enReading        = '/en/reading';
  static const enWriting        = '/en/writing';
  static const enListening      = '/en/listening';
  static const enSpeaking       = '/en/speaking';
  static const speaking         = '/home/speaking'; // Kurmancî konuşma
  static const writing          = '/home/writing';  // Kurmancî yazma dedicated
  static const home             = '/home';
  static const vocabulary       = '/vocabulary';
  static const culture          = '/culture';
  static const gotinenPesiyan   = '/culture/gotinen-pesiyan';
  static const profile          = '/profile';
  static const lesson           = '/home/lesson';
  static const settings         = '/settings';
  static const welcome          = '/welcome';
  static const admin            = '/admin';
  static const contentEditor    = '/admin/content';
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
  static const listeningPilot    = '/listening-pilot'; // PÎLOT: Azadiya Welat ses denemesi (izole)

  static const unitHub               = '/unit-hub';
  // Elle yazılmış dersler (wane): düzey listesi ve ders oynatıcı.
  static const wane                  = '/wane';
  static const wanePlay              = '/wane/play';
  static const xwendin               = '/xwendin';
  static const xwendinRead           = '/xwendin/read';

  // ── Lûtke Zarok (Çocuk Modu) ────────────────────────────────
  static const childOnboarding       = '/child/onboarding';
  static const childHome             = '/child/home';
  static const childWords            = '/child/words';
  static const childProfile          = '/child/profile';
  static const childLesson           = '/child/home/lesson';
  static const childProgressMap      = '/child/progress-map';
  static const childUnitHub          = '/child/unit-hub';
  static const childRewards          = '/child/rewards';

  // ── Dil Uzmanı Review Sistemi ─────────────────────────────
  static const reviewHub             = '/review';
  static const reviewPanel           = '/review/panel';

  // ── 4-Yol (Track) Seçimi ──────────────────────────────────
  static const trackSelect           = '/track-select';
  static const enChildHome           = '/en/child/home';

  // ── Düzey Belirleme Testi (CEFR Placement) ────────────────
  static const placementTest         = '/placement-test';

  // ── Pêşkêşkirin (Intro / Explanation) ─────────────────────
  // Akış: register/login → intro → placement → track-select → home
  static const introFlow             = '/onboarding/intro';

  // ── Sertifika (CEFR Level Completion) ─────────────────────
  static const certificate           = '/certificate'; // /:level

  // ── Yasal / Hakkında (Play Store gereksinimi) ─────────────
  static const legalIndex            = '/legal';
  static const privacyPolicy         = '/legal/privacy';
  static const termsOfService        = '/legal/terms';
  static const aboutLegal            = '/legal/about';


  // ── Yönetici: Alt-editör yönetimi ────────────────────────
  static const editorManagement      = '/admin/editors';
}

// ════════════════════════════════════════════════════════════════
// SHELL — Kalıcı alt navigasyon
// ════════════════════════════════════════════════════════════════

final _rootKey = GlobalKey<NavigatorState>();

/// Router rebuild koruması — `appRouter` provider auth durumu değişiminde
/// (ref.watch) yeniden hesaplanır → YENİ GoRouter instance yaratılır →
/// `initialLocation`'dan başlar. Token bazlı deep-link ekranları
/// (reset-password, verify-email) bu rebuild'de kaybolmamalı.
///
/// BUG (2026-05-16): Kullanıcı e-postadaki şifre sıfırlama linkine
/// (`/reset-password?token=…`) tıklayınca form bir an görünüp kayboluyor,
/// giriş sayfasına düşüyordu. Sebep: cloudflareCurrentUserProvider async
/// resolve olunca router rebuild → yeni instance splash'tan başlıyordu.
///
/// Çözüm: rebuild anında mevcut browser URL'i bir token route ise onu
/// initialLocation yap — yeni instance da aynı ekranda kalsın.
String _resolveInitialLocation() {
  if (!kIsWeb) return AppRoutes.splash;
  final p = Uri.base.path;
  final isTokenRoute = p.startsWith('/reset-password') ||
      p.startsWith('/auth/verify-email') ||
      p == '/verify-email';
  if (isTokenRoute) {
    final q = Uri.base.query;
    return q.isNotEmpty ? '$p?$q' : p;
  }
  return AppRoutes.splash;
}

/// Yönlendirme kuralları — saf işlev (GoRouter'dan bağımsız sınanır).
///
/// [loc] eşleşen konum (`state.matchedLocation`), [query] adresin sorgu
/// bölümü. Dönen değer yönlendirilecek konum; `null` → yerinde kal.
@visibleForTesting
String? appRedirect({
  required String loc,
  required String query,
  required bool isLoggedIn,
  required AsyncValue<CloudflareUser?> cfUserAsync,
  bool isLocalOwner = false,
}) {
  final cfUser = cfUserAsync.valueOrNull;
  final isOnAuth = loc.startsWith('/auth');
  final isOnSplash = loc == AppRoutes.splash;
  final isOnWelcome = loc == AppRoutes.welcome;

  // Eski mode/module ekranları → unified track seçim ekranına
  if (loc == AppRoutes.modeSelect || loc == AppRoutes.moduleSelect) {
    return AppRoutes.trackSelect;
  }

  // BACKWARDS COMPAT (Mayıs 2026): Önceki signup mailleri /verify-email?token=...
  // URL'siyle gitmişti — Flutter'da bu route yoktu. Eski kullanıcıların hâlâ
  // doğrulayabilmesi için yeni route'a redirect — query parametreleri
  // (token=...) korunur.
  if (loc == '/verify-email') {
    final qp = query.isNotEmpty ? '?$query' : '';
    return '${AppRoutes.emailVerification}$qp';
  }

  // /en/home ve /en/child/home route'ları KALDI (redirect yok):
  // EnHomeScreen ve EnChildHomeScreen wrapper'ları initState'te
  // activeTrackProvider'ı İngilizce'ye senkronlar. Redirect yapılırsa
  // module set edilmez ve deep-link Kurmancî render eder (bug).

  if (isOnSplash || isOnWelcome) return null;

  // Yönetici paneli (ve /admin altındaki her şey) yalnız sahibe (Ekim 2026).
  // Hesap bilgisi yüklenirken karar verilmez; sahip doğrudan adresle
  // geldiğinde yanlışlıkla ana ekrana atılmasın.
  if (loc == AppRoutes.admin || loc.startsWith('${AppRoutes.admin}/')) {
    if (cfUserAsync.isLoading) return null;
    if (!(cfUser?.isOwner ?? false) && !isLocalOwner) return AppRoutes.home;
  }
  // Email verification + reset-password ekranları her zaman ulaşılabilir
  // olmalı — auth redirect'inden hariç tut. (Mayıs 2026 — Cloudflare auth)
  final isOnVerifyEmail = loc.startsWith(AppRoutes.emailVerification);
  final isOnResetPassword = loc.startsWith(AppRoutes.resetPassword);
  if (isOnResetPassword) return null;

  // ── EMAIL VERIFICATION GATE (router-level) ─────────────
  // Cloudflare auth ile login olmuş ama email_verified=false olan
  // user'lar için tüm app-içi route'lar verify-email'e yönlendirilir.
  // Owner muafiyeti login.ts ile aynı; sen admin olarak kilitlenmezsin.
  // (Mayıs 2026 — kayıt sonrası zorunlu doğrulama)
  if (cfUser != null && !cfUser.emailVerified && !cfUser.isOwner) {
    if (!isOnVerifyEmail && !isOnResetPassword && !isOnAuth) {
      return AppRoutes.emailVerification;
    }
  }

  // Logged-in user on /auth → akış: intro → track-select → home.
  // Eski yönlendirme track-select idi; şimdi intro pêşkêşkirina LÛTKE'yê
  // pêşî tê. (Nisan 2026)
  //
  // Hesap bilgisi yüklenirken karar verilmez: kayıttan hemen sonra yerel
  // oturum hazır, Cloudflare kullanıcısı ise henüz yüklenmemiş olur;
  // o an karar verilirse doğrulanmamış kullanıcı önce tanıtıma düşer,
  // sonra doğrulama ekranına sekerdi. Yükleme bitince kural yeniden
  // çalışır (refreshListenable).
  if (isLoggedIn && isOnAuth && !isOnVerifyEmail) {
    if (cfUserAsync.isLoading) return null;
    if (cfUser != null && !cfUser.emailVerified && !cfUser.isOwner) {
      return AppRoutes.emailVerification;
    }
    return AppRoutes.introFlow;
  }
  return null;
}

/// Oturum durumu değişince yönlendirme kurallarını yeniden çalıştırır.
class _AuthRefresh extends ChangeNotifier {
  void ping() => notifyListeners();
}

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  // TEK ROUTER (Ekim 2026). Eskiden oturum sağlayıcıları burada `ref.watch`
  // ile izleniyordu: her oturum değişikliğinde (kayıt, giriş, doğrulama
  // denetimi, düzey kaydı) bu sağlayıcı yeniden çalışıyor, YENİ bir GoRouter
  // kuruluyor ve gezinme baştan başlıyordu. Sonuç: "Tomar bibe"den sonra
  // doğrulama ekranı yerine açılış ekranı; girişten sonra yine açılış ekranı;
  // ekranların kendi `context.go` çağrıları (ekran o anda söküldüğü için)
  // boşa düşüyordu. Kod bunu yer yer bekleme ve yeniden deneme ile
  // dolanıyordu (bkz. register_screen "race fix", placement "router rebuild
  // fix").
  //
  // Artık router bir kez kurulur. Oturum sağlayıcıları `ref.listen` ile
  // dinlenir ve yalnız `refreshListenable` tetiklenir: GoRouter bulunduğu
  // konumda `redirect` kurallarını yeniden değerlendirir, ekranlar yerinde
  // kalır. Kuralların kendisi değişmedi.
  final refresh = _AuthRefresh();
  ref.onDispose(refresh.dispose);
  // Firebase + yerel auth birlikte. Yalnızca Firebase'e bakan eski redirect
  // yerel-authed kullanıcılarda çalışmazdı (authStateProvider null döndüğü
  // için splash'ta "oturum yok" sanılırdı).
  ref.listen(isAnyLoggedInProvider, (_, __) => refresh.ping());
  // Cloudflare user (email_verified + isOwner) — verification gate için.
  ref.listen(cloudflareCurrentUserProvider, (_, __) => refresh.ping());

  final router = GoRouter(
    navigatorKey: _rootKey,
    initialLocation: _resolveInitialLocation(),
    debugLogDiagnostics: false,
    refreshListenable: refresh,

    redirect: (context, state) => appRedirect(
      loc: state.matchedLocation,
      query: state.uri.query,
      isLoggedIn: ref.read(isAnyLoggedInProvider),
      cfUserAsync: ref.read(cloudflareCurrentUserProvider),
      isLocalOwner: ref.read(isOwnerProvider),
    ),

    routes: [
      // ── Splash & Onboarding (shell dışı) ───────────────────
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      // NOT: /mode-select ve /module-select rotaları dead redirect
      // olarak `redirect` fonksiyonunda /track-select'e yönlendiriliyor.
      // Ayrı GoRoute gerekmez — aşağıdaki iki silinmiş tanım 2026-04 temizlik.
      GoRoute(
        path: AppRoutes.enHome,
        builder: (_, __) => const EnHomeScreen(),
      ),
      // PÎLOT — Azadiya Welat ses denemesi (izole, shell dışı). Doğrudan
      // /listening-pilot ile açılır; değerlendirme sonrası kaldırılacak.
      GoRoute(
        path: AppRoutes.listeningPilot,
        builder: (_, __) => const ListeningPilotScreen(),
      ),
      GoRoute(
        path: AppRoutes.enGrammar,
        builder: (_, __) => const EnGrammarScreen(),
      ),
      GoRoute(
        path: AppRoutes.enQuizHub,
        builder: (_, __) => const EnQuizHubScreen(),
      ),
      GoRoute(
        path: AppRoutes.enSkillsHub,
        builder: (_, __) => const EnSkillsHubScreen(),
      ),
      GoRoute(
        path: AppRoutes.enReading,
        builder: (_, state) => EnReadingScreen(
          level: (state.extra as Map<String, dynamic>?)?['level'] as String?,
        ),
      ),
      GoRoute(
        path: AppRoutes.enWriting,
        builder: (_, state) => EnWritingScreen(
          level: (state.extra as Map<String, dynamic>?)?['level'] as String?,
        ),
      ),
      GoRoute(
        path: AppRoutes.enListening,
        builder: (_, state) => EnListeningScreen(
          level: (state.extra as Map<String, dynamic>?)?['level'] as String?,
        ),
      ),
      GoRoute(
        path: AppRoutes.enSpeaking,
        builder: (_, state) => EnSpeakingScreen(
          level: (state.extra as Map<String, dynamic>?)?['level'] as String?,
        ),
      ),
      GoRoute(
        path: AppRoutes.speaking,
        builder: (_, state) => KuSpeakingScreen(
          level: (state.extra as Map<String, dynamic>?)?['level'] as String?,
        ),
      ),
      GoRoute(
        path: AppRoutes.writing,
        builder: (_, state) => KuWritingScreen(
          level: (state.extra as Map<String, dynamic>?)?['level'] as String?,
        ),
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
      GoRoute(
        path: AppRoutes.emailVerification,
        builder: (context, state) {
          // Token query param ile gelen email link'i için.
          // /auth/verify-email?token=… → otomatik doğrula.
          // Param yoksa → "inboxa kontrol bike" sayfası.
          final token = state.uri.queryParameters['token'];
          return EmailVerificationScreen(
            token: token,
            sendFailed: state.uri.queryParameters['sent'] == '0',
          );
        },
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) {
          // /reset-password?token=… — şifre sıfırlama formu.
          // Auth gerekmez (token zaten kimlik kanıtı).
          final token = state.uri.queryParameters['token'];
          return ResetPasswordScreen(token: token);
        },
      ),
      GoRoute(
        path: AppRoutes.introFlow,
        builder: (_, __) => const IntroFlowScreen(),
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
                    builder: (_, state) {
                      // Opsiyonel bölüm filtresi — extra map (uygulama içi)
                      // veya query param (web deep link) üzerinden gelir.
                      // Filtre yoksa global tekrar (tüm bölümler) davranışı.
                      final extra = state.extra as Map<String, dynamic>?;
                      final qp = state.uri.queryParameters;
                      return SmartReviewScreen(
                        filterLevel:
                            extra?['level'] as String? ?? qp['level'],
                        filterCategory:
                            extra?['category'] as String? ?? qp['category'],
                        filterTitle:
                            extra?['title'] as String? ?? qp['title'],
                      );
                    },
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

          // Tab 1: Peyv / Words — Kurmancî track → VocabularyBrowseScreen,
          // English track → EnReadingScreen (EN reading practice ≈ vocab exposure).
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.vocabulary,
                builder: (_, __) => const _TrackAwareVocab(),
              ),
            ],
          ),

          // Tab 2: Rêziman / Grammar — Kurmancî track → GrammarTipsScreen,
          // English track → EnGrammarScreen. Track-aware wrapper.
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.grammar,
                builder: (_, __) => const _TrackAwareGrammar(),
              ),
            ],
          ),

          // Tab 3: Çand / Culture — Kurmancî kültürel içerik KU track'a özgüdür.
          // English track için İngilizce Skills Hub (reading/writing/speaking).
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.culture,
                builder: (_, __) => const _TrackAwareCulture(),
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
            isChildMode: extra?['isChildMode'] as bool? ?? false,
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

      GoRoute(
        path: '/activity/dialogue',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return DialogueScreen(
            category: extra?['category'] as String?,
            level: extra?['level'] as String? ?? 'A1',
          );
        },
      ),
      GoRoute(
        path: '/activity/pronunciation',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return PronunciationScreen(
            category: extra?['category'] as String?,
            level: extra?['level'] as String? ?? 'A1',
          );
        },
      ),

      // ── Wane — elle yazılmış dersler ──────────────────────
      GoRoute(
        path: AppRoutes.wane,
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return WaneListScreen(level: extra?['level'] as String? ?? 'A1');
        },
      ),
      GoRoute(
        path: AppRoutes.wanePlay,
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return WaneScreen(lessonId: extra?['lessonId'] as String? ?? '');
        },
      ),

      // ── Xwendin — okuma metinleri ───────────────────────
      GoRoute(
        path: AppRoutes.xwendin,
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return XwendinListScreen(level: extra?['level'] as String? ?? 'A1');
        },
      ),
      GoRoute(
        path: AppRoutes.xwendinRead,
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return XwendinScreen(id: extra?['id'] as String? ?? '');
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

      // ── Lûtke Zarok — Çocuk Unit Hub ─────────────────────
      GoRoute(
        path: AppRoutes.childUnitHub,
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return ChildUnitHubScreen(
            category: extra['category'] as String? ?? '',
            titleKu: extra['titleKu'] as String? ?? '',
            titleTr: extra['titleTr'] as String? ?? '',
            emoji: extra['emoji'] as String? ?? '📚',
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
                builder: (_, __) => const _TrackAwareChildHome(),
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

      // NOT (Nisan 2026): Ebeveyn kontrol paneli kaldırıldı.
      // LÛTKE bir dil öğrenme uygulamasıdır; çocuk modunda kısıtlama
      // yerine sağlıklı alışkanlık önerisi sunulur (bkz. TimeUpScreen).
      GoRoute(
        path: AppRoutes.childProgressMap,
        builder: (_, __) => const ChildProgressMapScreen(),
      ),
      GoRoute(
        path: AppRoutes.childRewards,
        builder: (_, __) => const ChildRewardsScreen(),
      ),
      GoRoute(
        path: AppRoutes.reviewHub,
        builder: (_, __) => const ReviewHubScreen(),
      ),
      GoRoute(
        path: AppRoutes.reviewPanel,
        builder: (_, __) => const AdminReviewPanel(),
      ),

      // ── 4-Yol sistemi ──────────────────────────────────
      GoRoute(
        path: AppRoutes.trackSelect,
        builder: (_, __) => const TrackSelectScreen(),
      ),
      GoRoute(
        path: AppRoutes.placementTest,
        // extra {'retake': true} → profilden bilinçli tekrar test; ekran
        // içi "zaten yerleşmiş" guard'ı atlanır (push ile gelen akışlar
        // canPop üzerinden de tanınır — bkz. PlacementTestScreen.initState).
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return PlacementTestScreen(retake: extra?['retake'] == true);
        },
      ),
      GoRoute(
        path: AppRoutes.enChildHome,
        // Deep-link /en/child/home → englishChild track set + shell'e
        // yönlendirme (/child/home). Shell bottom nav görünür kalsın.
        builder: (_, __) => const _EnChildHomeEntry(),
      ),

      // ── Shell dışı sayfalar ─────────────────────────────────
      GoRoute(
        path: AppRoutes.admin,
        builder: (_, __) => const AdminPanelScreen(),
      ),
      GoRoute(
        path: AppRoutes.contentEditor,
        builder: (_, __) => const ContentEditorScreen(),
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
      GoRoute(
        path: AppRoutes.gotinenPesiyan,
        builder: (_, __) => const GotinenPesiyanScreen(),
      ),

      // ── Sertifika — CEFR seviye tamamlama belgesi ─────────
      GoRoute(
        path: '${AppRoutes.certificate}/:level',
        builder: (_, state) {
          final level = state.pathParameters['level'] ?? 'A1';
          return CertificateScreen(level: level);
        },
      ),

      // ── Yasal — Privacy Policy / Terms / About ────────────
      // Play Store gereksinimi: Gizlilik politikası uygulama içinden
      // erişilebilir olmalı. Profile/Settings menüsünden erişilir.
      GoRoute(
        path: AppRoutes.legalIndex,
        builder: (_, __) => const LegalIndexScreen(),
      ),
      GoRoute(
        path: AppRoutes.privacyPolicy,
        builder: (_, __) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: AppRoutes.termsOfService,
        builder: (_, __) => const TermsOfServiceScreen(),
      ),
      GoRoute(
        path: AppRoutes.aboutLegal,
        builder: (_, __) => const AboutScreen(),
      ),

      // ── Yönetici: Alt-editör yönetimi ─────────────────────
      GoRoute(
        path: AppRoutes.editorManagement,
        builder: (_, __) => const EditorManagementScreen(),
      ),
    ],

    errorBuilder: (_, state) => ErrorScreen(error: state.error),
  );
  ref.onDispose(router.dispose);
  return router;
}

// ════════════════════════════════════════════════════════════════
// TRACK-AWARE HOME BUILDERS
// /child/home rotası, aktif track'e göre doğru home'u render eder.
// ════════════════════════════════════════════════════════════════

class _TrackAwareChildHome extends ConsumerWidget {
  const _TrackAwareChildHome();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final track = ref.watch(currentTrackProvider);
    if (track.isEnglish) return const EnChildHomeScreen();
    return const ChildHomeScreen();
  }
}

/// /en/child/home entry wrapper — track'i englishChild'a senkronlar
/// ve child shell'e (/child/home) yönlendirir. Shell bottom nav aktif kalsın.
class _EnChildHomeEntry extends ConsumerStatefulWidget {
  const _EnChildHomeEntry();

  @override
  ConsumerState<_EnChildHomeEntry> createState() => _EnChildHomeEntryState();
}

class _EnChildHomeEntryState extends ConsumerState<_EnChildHomeEntry> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      final current = ref.read(activeTrackProvider);
      if (current != LearningTrack.englishChild) {
        await ref
            .read(activeTrackProvider.notifier)
            .setTrack(LearningTrack.englishChild);
      }
      if (!mounted) return;
      context.go(AppRoutes.childHome);
    });
  }

  @override
  Widget build(BuildContext context) {
    // INTEGRATION FIX (Nisan 2026 — EN audit):
    // Branded splash (emoji + çift dilli mesaj) + A11Y liveRegion.
    // Önceden yalnızca spinner vardı — deep-link deneyiminde app "donmuş"
    // izlenimi veriyordu.
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Center(
          child: Semantics(
            label: 'Tê barkirin — English child track · Loading',
            liveRegion: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('🌍', style: TextStyle(fontSize: 48)),
                SizedBox(height: 12),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  semanticsLabel: 'Loading English child track',
                ),
                SizedBox(height: 16),
                Text(
                  'Tê barkirin…',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Vocab tab: Kurmancî → VocabularyBrowseScreen, İngilizce → EnReadingScreen.
class _TrackAwareVocab extends ConsumerWidget {
  const _TrackAwareVocab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEn = ref.watch(isEnglishModuleProvider);
    if (isEn) return const EnReadingScreen();
    return const VocabularyBrowseScreen();
  }
}

/// Grammar tab: English track → EnGrammarScreen, Kurmancî → GrammarTipsScreen.
class _TrackAwareGrammar extends ConsumerWidget {
  const _TrackAwareGrammar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEn = ref.watch(isEnglishModuleProvider);
    if (isEn) return const EnGrammarScreen();
    return const GrammarTipsScreen();
  }
}

/// Culture tab: English track → EnSkillsHubScreen (reading/writing/speaking).
/// Kurmancî → CultureScreen (türkü, gotinên pêşiyan, heritage).
class _TrackAwareCulture extends ConsumerWidget {
  const _TrackAwareCulture();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEn = ref.watch(isEnglishModuleProvider);
    if (isEn) return const EnSkillsHubScreen();
    return const CultureScreen();
  }
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
      // Hata bildirim FAB artık MaterialApp builder'ında global overlay
      // olarak render ediliyor (GlobalBugFab). Burada tekrara gerek yok.
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

class _PersistentBottomNav extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _PersistentBottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEn = ref.watch(isEnglishModuleProvider);
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
                label: isEn ? 'Learn' : 'Fêrbûn',
                isActive: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              _Tab(
                icon: Icons.translate_rounded,
                label: isEn ? 'Words' : 'Peyv',
                isActive: currentIndex == 1,
                onTap: () => onTap(1),
              ),
              _Tab(
                icon: Icons.auto_stories_rounded,
                label: isEn ? 'Grammar' : 'Rêziman',
                isActive: currentIndex == 2,
                onTap: () => onTap(2),
              ),
              // Çand / Culture sekmesi yalnızca Kurmancî track'ında görünür.
              // İngilizce track'ında "Culture" Skills Hub'ı Grammar ile büyük
              // ölçüde örtüşüyor — çıkarıldı, kullanıcı kafa karışıklığı önlendi.
              if (!isEn)
                _Tab(
                  icon: Icons.music_note_rounded,
                  label: 'Çand',
                  isActive: currentIndex == 3,
                  onTap: () => onTap(3),
                ),
              _Tab(
                icon: Icons.person_rounded,
                label: isEn ? 'Profile' : 'Profîl',
                isActive: currentIndex == 4,
                onTap: () => onTap(4),
              ),
              // Mod değiştirici (Nisan 2026): "yetişkin kısmında da buna
              // ihtiyaç var" — yetişkin nav'a Karik (zarokan) sekmesi.
              // Aksiyon butonu — branch değil; tıklandığında onaylı
              // çocuk moduna geçer.
              _Tab(
                icon: Icons.child_care_rounded,
                label: isEn ? 'Kids' : 'Karik',
                isActive: false,
                onTap: () => _confirmSwitchToChild(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmSwitchToChild(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Derbasî Zarokan?'),
        content: const Text(
          'Tu yê derbasî riya zarokan bibî.\n\n'
          'Çocuklar moduna geçilecek. Devam edilsin mi?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Na / Hayır'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Erê / Evet'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    final current = ref.read(currentTrackProvider);
    final newTrack = LearningTrack.from(
      isEnglish: current.isEnglish,
      isChild: true,
    );
    await ref.read(activeTrackProvider.notifier).setTrack(newTrack);
    if (!context.mounted) return;
    context.go(newTrack.nativeHomePath);
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

  // Her sekme kendi rengiyle — logo palette. Hem KU hem EN etiket eşleştirilir.
  Color get _tabColor => switch (label) {
    'Fêrbûn' || 'Learn' => const Color(0xFF1A7B6B), // teal primary
    'Peyv' || 'Words' => const Color(0xFF0277BD), // mavi
    'Rêziman' || 'Grammar' => const Color(0xFF7B1FA2), // mor
    'Çand' || 'Culture' => const Color(0xFFD4783A), // turuncu accent
    'Profîl' || 'Profile' => const Color(0xFF455A64), // koyu gri-mavi
    'Karik' || 'Kids' => const Color(0xFFE91E63), // pembe — çocuk vurgusu
    _ => AppColors.primary,
  };

  @override
  Widget build(BuildContext context) {
    final color = isActive ? _tabColor : Colors.grey.shade500;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 52,
              height: 30,
              decoration: BoxDecoration(
                gradient: isActive
                    ? LinearGradient(
                        colors: [
                          _tabColor.withOpacity(0.18),
                          _tabColor.withOpacity(0.06),
                        ],
                      )
                    : null,
                color: isActive ? null : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                size: 22,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: color,
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

class _ChildBottomNav extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _ChildBottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              // Çıkış tabı: Mezinan moduna hızlı geçiş.
              // Kullanıcı geri bildirimi (Nisan 2026): "çocuk kısmından
              // çıkış için bir sekme ver" — küçük AppBar chip yetersizdi,
              // bottom nav'da görünür sekme eklendi.
              _ChildTab(
                icon: Icons.logout_rounded,
                label: 'Mezin',
                isActive: false, // Aksiyon butonu — branch değil
                onTap: () => _confirmSwitchToAdult(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmSwitchToAdult(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Derbasî Mezinan?'),
        content: const Text(
          'Tu yê ji riya zarokan derkevî û here riya mezinan.\n\n'
          'Kürtçe Yetişkinler moduna geçilecek. Devam edilsin mi?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Na / Hayır'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Erê / Evet'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    final current = ref.read(currentTrackProvider);
    final newTrack = LearningTrack.from(
      isEnglish: current.isEnglish,
      isChild: false,
    );
    await ref.read(activeTrackProvider.notifier).setTrack(newTrack);
    if (!context.mounted) return;
    context.go(newTrack.nativeHomePath);
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

