import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Uygulama dil modu.
///
/// [kuTr] — Kurmancî + Türkçe açıklamalar (varsayılan, öğrenmeye başlayanlar)
/// [kuOnly] — Tenê Kurmancî (sadece Kürtçe, ileri seviye)
enum LanguageMode { kuTr, kuOnly }

class LanguageModeNotifier extends StateNotifier<LanguageMode> {
  LanguageModeNotifier() : super(LanguageMode.kuTr) {
    _load();
  }

  static const _key = 'language_mode';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final val = prefs.getString(_key);
    if (val == 'kuOnly') state = LanguageMode.kuOnly;
  }

  Future<void> setMode(LanguageMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.name);
  }

  void toggle() {
    setMode(state == LanguageMode.kuTr ? LanguageMode.kuOnly : LanguageMode.kuTr);
  }
}

final languageModeProvider =
    StateNotifierProvider<LanguageModeNotifier, LanguageMode>(
  (_) => LanguageModeNotifier(),
);

/// Yardımcı: Türkçe gösterilecek mi?
final showTurkishProvider = Provider<bool>((ref) {
  return ref.watch(languageModeProvider) == LanguageMode.kuTr;
});
