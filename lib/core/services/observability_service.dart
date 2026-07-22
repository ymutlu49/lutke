import 'package:flutter/foundation.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Observability (Crashlytics + Analytics)
//
// Production'da:
//   • Firebase Crashlytics — çökme raporları
//   • Firebase Analytics — anonim kullanım metrikleri
//
// Şu an SCAFFOLD (yer tutucu) durumunda. Firebase yapılandırıldıktan
// sonra (firebase_options.dart gerçek değerlerle dolduktan sonra)
// aşağıdaki TODO bölümlerini aktif edin.
//
// pubspec.yaml'a eklenmesi gereken paketler:
//   firebase_crashlytics: ^4.1.3
//   firebase_analytics: ^11.3.3
//
// AKTIVASYON adımları:
//   1. firebase_options.dart'ı `flutterfire configure` ile doldurun
//   2. pubspec.yaml'a yukarıdaki 2 paketi ekleyin
//   3. Bu dosyada `// TODO: ENABLE` ile işaretli satırları açın
//   4. main.dart'ta ObservabilityService.init()'i çağırın
//   5. android/app/build.gradle'a Crashlytics plugin ekleyin
//
// COPPA: Çocuk modunda Analytics OTOMATIK kapalı kalır.
// ════════════════════════════════════════════════════════════════

class ObservabilityService {
  static bool _initialized = false;
  static bool _analyticsEnabled = false;
  static bool _crashlyticsEnabled = false;

  /// Servisi başlat. main.dart'ta runApp() öncesi çağırın.
  ///
  /// [allowAnalytics]: Çocuk modunda false olmalı (COPPA).
  static Future<void> init({bool allowAnalytics = true}) async {
    if (_initialized) return;
    _initialized = true;
    _analyticsEnabled = allowAnalytics;

    // ── Crashlytics ───────────────────────────────────────────
    // TODO: ENABLE — Firebase yapılandırıldığında:
    //
    // import 'package:firebase_crashlytics/firebase_crashlytics.dart';
    //
    // try {
    //   FlutterError.onError = (details) {
    //     FlutterError.presentError(details);
    //     FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    //   };
    //   PlatformDispatcher.instance.onError = (error, stack) {
    //     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    //     return true;
    //   };
    //   // Debug build'de raporlama kapalı (gürültü olmasın)
    //   await FirebaseCrashlytics.instance
    //       .setCrashlyticsCollectionEnabled(!kDebugMode);
    //   _crashlyticsEnabled = true;
    // } catch (e) {
    //   if (kDebugMode) debugPrint('Crashlytics init failed: $e');
    // }

    // ── Analytics ─────────────────────────────────────────────
    // TODO: ENABLE — Firebase yapılandırıldığında:
    //
    // import 'package:firebase_analytics/firebase_analytics.dart';
    //
    // try {
    //   await FirebaseAnalytics.instance
    //       .setAnalyticsCollectionEnabled(allowAnalytics && !kDebugMode);
    //   _analyticsEnabled = allowAnalytics;
    // } catch (e) {
    //   if (kDebugMode) debugPrint('Analytics init failed: $e');
    // }

    if (kDebugMode) {
      debugPrint('Observability: scaffold mode — '
          'analytics=$_analyticsEnabled, crashlytics=$_crashlyticsEnabled');
    }
  }

  /// Custom event log et (analytics).
  ///
  /// Önemli kullanım örnekleri:
  ///   • lesson_completed (level, lesson_id, duration_sec)
  ///   • exercise_attempted (type, level, correct)
  ///   • streak_milestone (days)
  ///   • placement_test_completed (cefr_level)
  ///   • subscription_started (plan, source)
  static Future<void> logEvent(
    String name, {
    Map<String, Object>? params,
  }) async {
    if (!_analyticsEnabled) return;
    // TODO: ENABLE
    // try {
    //   await FirebaseAnalytics.instance.logEvent(
    //     name: name,
    //     parameters: params,
    //   );
    // } catch (_) {}
    if (kDebugMode) {
      debugPrint('[Analytics] $name ${params ?? ''}');
    }
  }

  /// Hata raporla (Crashlytics).
  static Future<void> recordError(
    Object error,
    StackTrace? stack, {
    String? reason,
    bool fatal = false,
  }) async {
    if (!_crashlyticsEnabled) return;
    // TODO: ENABLE
    // try {
    //   await FirebaseCrashlytics.instance.recordError(
    //     error,
    //     stack,
    //     reason: reason,
    //     fatal: fatal,
    //   );
    // } catch (_) {}
    if (kDebugMode) {
      debugPrint('[Crashlytics] error=$error reason=$reason fatal=$fatal');
    }
  }

  /// Kullanıcı kimliği (anonim hash önerilir, gerçek email DEĞİL).
  static Future<void> setUserId(String? id) async {
    if (!_analyticsEnabled || !_crashlyticsEnabled) return;
    // TODO: ENABLE
    // try {
    //   await FirebaseAnalytics.instance.setUserId(id: id);
    //   if (id != null) {
    //     await FirebaseCrashlytics.instance.setUserIdentifier(id);
    //   }
    // } catch (_) {}
  }

  /// Çocuk modu aktifken analytics'i kapat (COPPA).
  static Future<void> setChildMode(bool isChild) async {
    _analyticsEnabled = !isChild;
    // TODO: ENABLE
    // await FirebaseAnalytics.instance
    //     .setAnalyticsCollectionEnabled(_analyticsEnabled && !kDebugMode);
  }

  /// Kullanıcı analytics opt-out yaptıysa (Profil → Mîheng → Analitik kapat)
  static Future<void> setAnalyticsEnabled(bool enabled) async {
    _analyticsEnabled = enabled;
    // TODO: ENABLE
    // await FirebaseAnalytics.instance
    //     .setAnalyticsCollectionEnabled(enabled && !kDebugMode);
  }
}
