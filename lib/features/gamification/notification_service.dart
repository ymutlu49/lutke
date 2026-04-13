import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

/// LÛTKE Bildirim Servisi
///
/// Araştırma Bulgusu #2: Motivasyon çapası — bildirimler
/// kullanıcının girdiği isimle kişiselleştirilir.
///
/// "Fatma için bugün 10 dakika pratik yaptın!" gibi.
///
/// Araştırma Bulgusu #3: Haftalık ritim modeli.
/// Günlük baskı yok, haftalık hatırlatıcı var.

class LutkeNotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  // Bildirim kanalları
  static const _dailyChannelId = 'lutke_daily';
  static const _weeklyChannelId = 'lutke_weekly';
  static const _badgeChannelId = 'lutke_badge';

  // Bildirim ID'leri
  static const _dailyNotifId = 1;
  static const _weeklyNotifId = 2;
  static const _badgeNotifId = 3;

  static Future<void> initialize() async {
    if (_initialized) return;

    tz_data.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
    );

    _initialized = true;
  }

  // ── İzin İsteme ───────────────────────────────────────────────

  static Future<bool> requestPermission() async {
    final ios = await _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    final android = await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    return (ios ?? false) || (android ?? false);
  }

  // ── Günlük Bildirim Kur ────────────────────────────────────────

  /// Araştırma: Motivasyon çapası adıyla kişiselleştirilmiş günlük.
  /// Zeynep: TikTok arası — öğle / Mehmet: metro — sabah erken.
  static Future<void> scheduleDailyReminder({
    required int hour,
    required int minute,
    String? anchorName,
  }) async {
    await _plugin.cancel(_dailyNotifId);

    final title = 'LÛTKE — Zimanê Kurdî';
    final body = anchorName != null && anchorName.isNotEmpty
        ? '$anchorName ji te hêviyê dike — îro pratîk bike!'
        : 'Îro jî bi Kurmancî bimîne!';

    await _plugin.zonedSchedule(
      _dailyNotifId,
      title,
      body,
      _nextInstanceOf(hour, minute),
      NotificationDetails(
        android: AndroidNotificationDetails(
          _dailyChannelId,
          'Bîranîna Rojane',
          channelDescription: 'Agahdariya pratîka rojane ya LÛTKE',
          importance: Importance.high,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(body),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // ── Haftalık Özet Bildirimi ────────────────────────────────────

  /// Pazar günleri haftalık özet.
  static Future<void> scheduleWeeklySummary({
    String? anchorName,
    int activeDays = 0,
  }) async {
    await _plugin.cancel(_weeklyNotifId);

    final title = 'Kurteya heftanê — LÛTKE';
    String body;

    if (activeDays >= WeeklyGoal.targetDays) {
      body = anchorName != null
          ? '$anchorName — vê heftê armanc hat temamkirin! 🎉 $activeDays roj çalak'
          : 'Armanca heftanê hat temamkirin! 🎉 $activeDays roj çalak bûyî';
    } else {
      final remaining = WeeklyGoal.targetDays - activeDays;
      body = anchorName != null
          ? '$anchorName — $activeDays roj çalak bûyî. $remaining roj din bêkêmasî bûya!'
          : 'Vê heftê $activeDays roj çalak bûyî. Heftê tu dikarî çêtir bikî!';
    }

    // Her Pazar 19:00'da
    await _plugin.zonedSchedule(
      _weeklyNotifId,
      title,
      body,
      _nextSunday(19, 0),
      NotificationDetails(
        android: AndroidNotificationDetails(
          _weeklyChannelId,
          'Kurteya Heftanê',
          channelDescription: 'Kurteya pêşveçûna heftane ya LÛTKE',
          importance: Importance.defaultImportance,
          styleInformation: BigTextStyleInformation(body),
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  // ── Rozet Bildirimi ───────────────────────────────────────────

  static Future<void> showBadgeNotification({
    required String badgeKurmanjiName,
    required String badgeTurkishName,
  }) async {
    await _plugin.show(
      _badgeNotifId,
      'Xelat hat! — Nîşan hat bidestxistin!',
      'Te nîşana $badgeKurmanjiName ($badgeTurkishName) bi dest xist! 🏆',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _badgeChannelId,
          'Rozetler',
          channelDescription: 'LÛTKE rozet bildirimleri',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  // ── Tüm Bildirimleri İptal Et ─────────────────────────────────

  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  // ── Yardımcı Fonksiyonlar ─────────────────────────────────────

  static tz.TZDateTime _nextInstanceOf(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  static tz.TZDateTime _nextSunday(int hour, int minute) {
    var now = tz.TZDateTime.now(tz.local);
    // DateTime.sunday = 7
    final daysUntilSunday = (7 - now.weekday) % 7;
    final nextSunday = now.add(Duration(
      days: daysUntilSunday == 0 ? 7 : daysUntilSunday,
    ));
    return tz.TZDateTime(
      tz.local,
      nextSunday.year,
      nextSunday.month,
      nextSunday.day,
      hour,
      minute,
    );
  }

  // ── Kullanıcı Tercihi Kaydet / Yükle ─────────────────────────

  static Future<void> savePreferences({
    required int hour,
    required int minute,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('notif_hour', hour);
    await prefs.setInt('notif_minute', minute);
  }

  static Future<({int hour, int minute})> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return (
      hour: prefs.getInt('notif_hour') ?? 19,    // Varsayılan: 19:00
      minute: prefs.getInt('notif_minute') ?? 0,
    );
  }
}

/// Haftalık hedef sabiti
abstract class WeeklyGoal {
  static const int targetDays = 4;
}
