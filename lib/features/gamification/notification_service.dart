// PERF 2026-04: Bu servis kullanılmıyordu — LutkeNotificationService
// hiçbir yerden çağrılmıyor (grep 0 hit), provider'a bağlanmamış.
// `flutter_local_notifications` + `timezone` paketleri pubspec'ten
// kaldırıldı. Servisin kendisi de stub'lanarak import ağacı kırıldı.
//
// Bildirim altyapısı gerekli olduğunda:
//   1. pubspec.yaml'a flutter_local_notifications + timezone ekle
//   2. Bu dosyayı git history'den geri getir: git log -- notification_service.dart
//   3. Provider ile bağla ve main.dart'ta initialize() çağır

/// Placeholder — bildirim servisi şu anda devre dışı.
class LutkeNotificationService {
  const LutkeNotificationService._();

  /// Stub — gerçek bildirim yayını yok.
  static Future<void> initialize() async {}

  /// Stub — günlük hatırlatıcı kurulmaz.
  static Future<void> scheduleDailyReminder({String? userName}) async {}

  /// Stub — haftalık hatırlatıcı kurulmaz.
  static Future<void> scheduleWeeklyReminder() async {}

  /// Stub — rozet kazanıldığında bildirim atılmaz.
  static Future<void> showBadgeEarned(String badgeName) async {}

  /// Stub — tüm planlı bildirimleri iptal eder (no-op).
  static Future<void> cancelAll() async {}
}
