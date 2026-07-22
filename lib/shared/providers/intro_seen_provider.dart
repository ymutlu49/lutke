// LÛTKE — intro_seen_v2 flag provider
//
// Yeni kullanıcı intro slide'larını görür; ikinci girişten itibaren splash CTA
// onları doğrudan track-select'e gönderir. IntroFlowScreen tamamlanınca
// `markIntroSeen()` çağrılır → SharedPreferences flag set edilir.
//
// v2: önceki test sürümlerinde flag set edilmiş olabilir (v1) — fresh key.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kIntroSeenKey = 'intro_seen_v2';

/// Intro daha önce görüldü mü? Async (cold start'ta SharedPrefs'tan yüklenir).
/// Cold start: AsyncValue.loading → splash bekler. Resolved: bool.
final introSeenProvider = FutureProvider<bool>((ref) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kIntroSeenKey) ?? false;
  } catch (_) {
    return false;
  }
});

/// Intro tamamlandığında çağır. Provider invalidate edilir → tüketenler
/// (splash CTA) bir sonraki render'da doğru değeri okur.
Future<void> markIntroSeen(WidgetRef ref) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kIntroSeenKey, true);
  } catch (_) {}
  ref.invalidate(introSeenProvider);
}
