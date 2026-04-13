import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'core/constants/app_theme.dart';
import 'core/constants/child_theme.dart';
import 'core/router/app_router.dart';
import 'shared/providers/child_mode_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

class LutkeApp extends ConsumerWidget {
  const LutkeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final isChild = ref.watch(isChildModeProvider);

    return MaterialApp.router(
      title: isChild ? 'LÛTKE ZAROK' : 'LÛTKE — Zimanê Kurdî',
      theme: isChild ? ChildAppTheme.light : AppTheme.light,
      darkTheme: isChild ? null : AppTheme.dark,
      themeMode: isChild ? ThemeMode.light : ThemeMode.system,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
      debugShowCheckedModeBanner: false,

      builder: (context, child) {
        // Web'de mobil genişlik sınırlaması (telefon ekranı)
        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: MediaQuery.of(context).size.width > 480
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 32,
                      ),
                    ]
                  : null,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
