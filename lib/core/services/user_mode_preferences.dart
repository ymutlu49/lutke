import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Kullanıcı Modu Tercihleri
//
// Prof. Dr. Mutlu (akademisyen) ve Zeynep (disleksi) gibi
// farklı kullanıcı profillerine uyum. Ryan-Deci SDT + overjustification
// araştırmasına göre bazı kullanıcılar extrinsic reward'dan rahatsız.
//
// 3 mod:
//   - gamified  (varsayılan) — XP, seviye, rozet, streak, maskot
//   - academic  — sade: sadece progress + kelime sayısı, gamification gizli
//   - child     — tam gamified + variable reward (chest, sticker)
// ════════════════════════════════════════════════════════════════

enum UserMode {
  gamified(
    labelKu: 'Modê Lîstikî',
    labelTr: 'Oyunlu',
    descriptionKu: 'XP, ast, rozet, streak — giştî',
    descriptionTr: 'Standart: XP, seviye, rozet',
  ),
  academic(
    labelKu: 'Modê Akademîk',
    labelTr: 'Sade / Akademik',
    descriptionKu: 'Hejmar-girêdayî, gamification veşartî',
    descriptionTr: 'Sayı odaklı, oyunlaştırma gizli',
  ),
  child(
    labelKu: 'Modê Zarokan',
    labelTr: 'Zarok',
    descriptionKu: 'Tam anîmasyon + xelatê ecêb',
    descriptionTr: 'Çocuk: tam animasyon + sürpriz ödül',
  );

  final String labelKu;
  final String labelTr;
  final String descriptionKu;
  final String descriptionTr;
  const UserMode({
    required this.labelKu,
    required this.labelTr,
    required this.descriptionKu,
    required this.descriptionTr,
  });
}

class UserModePreferences {
  static const _kKey = 'user_mode_preference_v1';

  static Future<UserMode> get() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kKey) ?? 'gamified';
    return UserMode.values.firstWhere(
      (m) => m.name == raw,
      orElse: () => UserMode.gamified,
    );
  }

  static Future<void> set(UserMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kKey, mode.name);
  }
}

class UserModeNotifier extends StateNotifier<UserMode> {
  UserModeNotifier() : super(UserMode.gamified) {
    _load();
  }

  Future<void> _load() async {
    state = await UserModePreferences.get();
  }

  Future<void> setMode(UserMode m) async {
    state = m;
    await UserModePreferences.set(m);
  }
}

final userModeProvider =
    StateNotifierProvider<UserModeNotifier, UserMode>(
  (ref) => UserModeNotifier(),
);

/// Convenience: gamification UI gizlenmeli mi?
/// Academic modda XP/level/rozet kartları gizlenir.
bool hideGamificationFor(UserMode mode) => mode == UserMode.academic;
