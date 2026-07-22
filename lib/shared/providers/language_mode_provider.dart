import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Uygulama dil modu — Kurmancî track için yardım dili seçimi.
///
/// [kuTr] — Kurmancî + Türkçe (varsayılan; TR anadilli öğrenenler)
/// [kuEn] — Kurmancî + İngîlîzî (İngilizce anadilli / heritage speakers)
///
/// Eski `kuOnly` değeri kaldırıldı; önceki pref değerleri `kuEn`'e haritalanır.
enum LanguageMode { kuTr, kuEn }

extension LanguageModeLabels on LanguageMode {
  /// Kısaltma rozeti: "KU/TR" veya "KU/EN".
  String get badge => switch (this) {
        LanguageMode.kuTr => 'KU/TR',
        LanguageMode.kuEn => 'KU/EN',
      };

  /// Kullanıcıya gösterilecek tam etiket (Kurmancî).
  String get labelKu => switch (this) {
        LanguageMode.kuTr => 'Kurmancî / Tirkî',
        LanguageMode.kuEn => 'Kurmancî / Îngîlîzî',
      };
}

class LanguageModeNotifier extends StateNotifier<LanguageMode> {
  LanguageModeNotifier() : super(LanguageMode.kuTr) {
    _load();
  }

  static const _key = 'language_mode';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final val = prefs.getString(_key);
    // Eski 'kuOnly' değeri → yeni 'kuEn' olarak yorumla (geri uyumluluk).
    if (val == 'kuEn' || val == 'kuOnly') {
      state = LanguageMode.kuEn;
    } else {
      state = LanguageMode.kuTr;
    }
  }

  Future<void> setMode(LanguageMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.name);
  }

  void toggle() {
    setMode(state == LanguageMode.kuTr ? LanguageMode.kuEn : LanguageMode.kuTr);
  }
}

final languageModeProvider =
    StateNotifierProvider<LanguageModeNotifier, LanguageMode>(
  (_) => LanguageModeNotifier(),
);

/// Yardımcı: Türkçe mi gösterilecek? (kuTr modu)
final showTurkishProvider = Provider<bool>((ref) {
  return ref.watch(languageModeProvider) == LanguageMode.kuTr;
});

/// Yardımcı: İngilizce mi gösterilecek? (kuEn modu)
final showEnglishTranslationProvider = Provider<bool>((ref) {
  return ref.watch(languageModeProvider) == LanguageMode.kuEn;
});
