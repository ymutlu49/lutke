import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:easy_localization/easy_localization.dart';

import 'core/constants/app_theme.dart';
import 'core/constants/child_theme.dart';
import 'core/router/app_router.dart';
import 'core/services/accessibility_settings.dart';
import 'core/services/en_tts_helper.dart';
import 'core/services/sound_service.dart';
import 'core/services/tts_service.dart';
import 'core/utils/accessibility_helpers.dart';
import 'shared/providers/learning_track_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── Web URL stratejisi: hash (/#/...) yerine path (/...) ──
  // E-posta linkleri (reset-password, verify-email) path-based gelir;
  // hash mode'da splash'a düşüyordu. usePathUrlStrategy() düzeltir.
  if (kIsWeb) {
    usePathUrlStrategy();
  }

  // ── Hata yakalama ────────────────────────────────────────
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kDebugMode) debugPrint('Flutter error: ${details.exception}');
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    if (kDebugMode) debugPrint('Unhandled: $error');
    return true;
  };

  // ── Firebase — henüz yapılandırılmadı, atla ─────────────
  // Firebase yapılandırıldığında bu bölüm aktif edilecek:
  // try {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // } catch (_) {}

  // ── Lokalizasyon ─────────────────────────────────────────
  await EasyLocalization.ensureInitialized();

  // ── Ses servisi — mute tercihini yükle ──────────────────
  await SoundService.init();

  // ── Ekran yönü: dikey ────────────────────────────────────
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [
          Locale('ku'),
          Locale('tr'),
          Locale('en'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('tr'),
        startLocale: const Locale('tr'),
        child: const LutkeApp(),
      ),
    ),
  );
}

class LutkeApp extends ConsumerStatefulWidget {
  const LutkeApp({super.key});

  @override
  ConsumerState<LutkeApp> createState() => _LutkeAppState();
}

class _LutkeAppState extends ConsumerState<LutkeApp> {
  @override
  void initState() {
    super.initState();
    // TTS warm-up: HF Space uykudan uyandır (arka planda, beklemiyor).
    // Kullanıcı ilk seslendirme butonuna bastığında cold start gecikmesini
    // azaltır. Başarısız olursa sessiz geçer.
    Future<void>.microtask(() {
      ref.read(ttsServiceProvider).warmUp();
    });
    // INTEGRATION FIX (Nisan 2026 — EN audit):
    // Browser SpeechSynthesis voices lazy yüklenir — ilk EN "Listen" click
    // bazen ses üretmezdi (voices boş). WarmUp voices cache'ini prime eder.
    // No-op if not web. Non-blocking.
    EnTtsHelper.warmUp();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    // Theme/Title artık TEK kaynak currentTrackProvider'dan okunur.
    // Böylece 4 track arasında görsel ayrım net ve karışmaz:
    //   Kurmancî Mezinan → LÛTKE + AppTheme
    //   Kurmancî Zarokan → LÛTKE ZAROK + ChildAppTheme
    //   Îngilîzî Mezinan → LÛTKE + AppTheme
    //   Îngilîzî Zarokan → LÛTKE KIDS + ChildAppTheme
    final track = ref.watch(currentTrackProvider);
    final isChild = track.isChild;
    final title = track.isChild
        ? (track.isEnglish ? 'LÛTKE KIDS' : 'LÛTKE ZAROK')
        : (track.isEnglish ? 'LÛTKE — English' : 'LÛTKE — Zimanê Kurdî');

    // PERF: a11y tema düzeyinde uygulanır — track veya a11y değişince
    // MaterialApp.router tekrar kurulur (router dahil). Ancak tema
    // hesaplaması yukarıda yapılıp AŞAĞIDAKİ Consumer'a delege edildi
    // (hem üst ağaçta hem builder'da iki ayrı watch vardı → her a11y
    // değişikliğinde iki ayrı subtree rebuild'ti; şimdi builder tarafı
    // sadece kendi Consumer'ı üzerinden yeniden kuruluyor).
    return Consumer(
      builder: (context, ref, _) {
        final a11ySettings = ref.watch(accessibilitySettingsProvider);
        final baseLight = isChild ? ChildAppTheme.light : AppTheme.light;
        final themedLight = baseLight.copyWith(
          textTheme: a11ySettings.applyToTextTheme(baseLight.textTheme),
          colorScheme: a11ySettings.applyToColorScheme(baseLight.colorScheme),
        );
        final baseDark = AppTheme.dark;
        final themedDark = isChild
            ? null
            : baseDark.copyWith(
                textTheme: a11ySettings.applyToTextTheme(baseDark.textTheme),
                colorScheme: a11ySettings.applyToColorScheme(baseDark.colorScheme),
              );

        return MaterialApp.router(
          title: title,
          theme: themedLight,
          darkTheme: themedDark,
          themeMode: isChild ? ThemeMode.light : ThemeMode.system,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          // PERF: builder a11y'yi ayrı Consumer'a kapsatıyor, böylece
          // MaterialApp kendisini yeniden inşa etmek yerine sadece
          // iç frame rebuild olur (router dahil değil).
          builder: (context, child) =>
              _A11yFrame(child: child ?? const SizedBox.shrink()),
        );
      },
    );
  }
}

/// Erişilebilirlik katmanı — `MaterialApp.router.builder` içinde çalışır.
///
/// PERF: Ayrı widget + Consumer olduğu için `accessibilitySettingsProvider`
/// değiştiğinde yalnızca bu ağaç yeniden kurulur; yukarıdaki `MaterialApp`
/// (ve dolayısıyla router) dokunulmaz kalır.
class _A11yFrame extends ConsumerWidget {
  const _A11yFrame({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final a11y = ref.watch(accessibilitySettingsProvider);
    final baseScaler = MediaQuery.textScalerOf(context);
    final effectiveScaler = baseScaler.clamp(
      minScaleFactor: 0.85 * a11y.textScale,
      maxScaleFactor: 2.0 * a11y.textScale,
    );
    final bgOverride = a11y.background.color;
    final isWide = MediaQuery.of(context).size.width > 480;

    final framed = Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 480),
        decoration: BoxDecoration(
          color: bgOverride ?? Theme.of(context).scaffoldBackgroundColor,
          boxShadow: isWide
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 32,
                  ),
                ]
              : null,
        ),
        // ReadingRulerOverlay — disleksi odaklı okuma cetveli.
        // State'te var olan a11y.readingRuler artık gerçek UI
        // overlay olarak render edilir (Rello & Baeza-Yates 2013).
        child: ReadingRulerOverlay(
          enabled: a11y.readingRuler,
          child: child,
        ),
      ),
    );

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: effectiveScaler,
        disableAnimations: a11y.reduceAnimations,
      ),
      child: framed,
    );
  }
}
