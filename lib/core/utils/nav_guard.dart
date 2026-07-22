// ════════════════════════════════════════════════════════════════
// NAV GUARD — LÛTKE
//
// Çift tıklama korumasi. Kullanıcı bir ders kartına çabuk iki kez
// dokunursa, iki ayrı ekran basılır ve ders iki kez açılır.
// NavGuard.guard(action) içinde 600ms pencerede ikinci tıklamayı yutar.
//
// Kullanım:
//   onTap: () => NavGuard.guard(() => context.push('/home/lesson'));
// ════════════════════════════════════════════════════════════════

class NavGuard {
  static DateTime _lastTriggered = DateTime.fromMillisecondsSinceEpoch(0);
  static const _cooldown = Duration(milliseconds: 600);

  /// Verilen eylemi çalıştırır, fakat _cooldown içinde gelen ikinci
  /// çağrıyı sessiz atar. Basit web UI'da çift render'ı engeller.
  static void guard(void Function() action) {
    final now = DateTime.now();
    if (now.difference(_lastTriggered) < _cooldown) return;
    _lastTriggered = now;
    action();
  }

  /// Async sürümü — sonucu bekleyen çağrıcılar için.
  static Future<void> guardAsync(Future<void> Function() action) async {
    final now = DateTime.now();
    if (now.difference(_lastTriggered) < _cooldown) return;
    _lastTriggered = now;
    await action();
  }
}
