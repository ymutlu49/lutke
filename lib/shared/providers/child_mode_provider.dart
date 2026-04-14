import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Çocuk Modu Provider
//
// Uygulama genelinde çocuk modunun aktif olup olmadığını yönetir.
// SharedPreferences ile önbellek, UserProfile ile senkron.
//
// NOT (Nisan 2026): Ebeveyn PIN sistemi kaldırıldı. LÛTKE bir dil
// öğrenme uygulaması; kısıtlama aracı değil.
// ════════════════════════════════════════════════════════════════

/// Çocuk modunun aktif olup olmadığını döndürür.
final isChildModeProvider = StateNotifierProvider<ChildModeNotifier, bool>(
  (ref) => ChildModeNotifier(),
);

class ChildModeNotifier extends StateNotifier<bool> {
  ChildModeNotifier() : super(false) {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('is_child_mode') ?? false;
  }

  Future<void> setChildMode(bool value) async {
    state = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_child_mode', value);
  }

  Future<void> toggle() async => setChildMode(!state);
}

/// Çocuk yaş grubu — 7-10 yaş.
final childAgeProvider = StateProvider<int?>((ref) => null);
