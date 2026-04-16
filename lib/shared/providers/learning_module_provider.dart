import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// LÛTKE — Öğrenme modülü seçimi.
///
/// [kurmanci] — Kurmancî öğreniyor (Türkçe konuşan ve heritage konuşmacılar için)
/// [english]  — İngilizce öğreniyor (Kurmancî anadilli için)
///
/// Modüle göre tüm route'lar, içerik kaynakları ve dil mantığı değişir.
enum LearningModule { kurmanci, english }

class LearningModuleNotifier extends StateNotifier<LearningModule> {
  LearningModuleNotifier() : super(LearningModule.kurmanci) {
    _load();
  }

  static const _key = 'learning_module';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final val = prefs.getString(_key);
    if (val == 'english') state = LearningModule.english;
  }

  Future<void> setModule(LearningModule m) async {
    state = m;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, m.name);
  }

  void toggle() {
    setModule(state == LearningModule.kurmanci
        ? LearningModule.english
        : LearningModule.kurmanci);
  }
}

final learningModuleProvider =
    StateNotifierProvider<LearningModuleNotifier, LearningModule>(
  (_) => LearningModuleNotifier(),
);

/// Yardımcı: aktif modül İngilizce mi?
final isEnglishModuleProvider = Provider<bool>(
  (ref) => ref.watch(learningModuleProvider) == LearningModule.english,
);
