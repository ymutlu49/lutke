import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'core/constants/app_theme.dart';
import 'core/router/app_router.dart';
import 'features/lessons/data/lesson_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── Hata yakalama katmanı ────────────────────────────────
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kDebugMode) debugPrint('Flutter error: ${details.exception}');
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    if (kDebugMode) debugPrint('Unhandled error: $error\n$stack');
    return true;
  };

  // ── Firebase başlat ──────────────────────────────────────
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (kDebugMode) debugPrint('Firebase init hatası: $e');
    // Firebase olmadan da çalışabilir (offline-first mimari)
  }

  // ── Lokalizasyon başlat ──────────────────────────────────
  await EasyLocalization.ensureInitialized();

  // ── Ekran yönü: sadece dikey ─────────────────────────────
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ── Status bar ───────────────────────────────────────────
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [
          Locale('ku'), // Kurmancî — birincil
          Locale('tr'), // Türkçe — ikincil
          Locale('en'), // İngilizce — üçüncül
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
  bool _seedError = false;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  /// İlk açılışta veritabanını seed et.
  /// Hata durumunda uygulama kapanmaz — kullanıcıya bilgi verilir.
  Future<void> _initData() async {
    try {
      final repo = ref.read(lessonRepositoryProvider);
      await repo.seedAllLevels();
    } catch (e) {
      if (kDebugMode) debugPrint('Seed hatası: $e');
      if (mounted) setState(() => _seedError = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'LÛTKE — Zimanê Kurdî',

      // Temalar
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,

      // Lokalizasyon
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      // Router
      routerConfig: router,

      // Debug banner kapalı
      debugShowCheckedModeBanner: false,

      // Uygulama genelinde hata yakalama (widget hatası)
      builder: (context, child) {
        if (_seedError) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Banner(
              message: 'Seed hatası',
              location: BannerLocation.topEnd,
              color: Colors.orange,
              child: child!,
            ),
          );
        }
        return child!;
      },
    );
  }
}
