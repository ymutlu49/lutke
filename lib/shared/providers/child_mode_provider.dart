import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Çocuk Modu Provider
//
// Uygulama genelinde çocuk modunun aktif olup olmadığını yönetir.
// SharedPreferences ile önbellek, UserProfile ile senkron.
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

/// PIN doğrulama yardımcıları.
///
/// Basit hash — çocuğun kazara erişimini önleme amaçlı,
/// kriptografik güvenlik gerekmiyor.
abstract class PinHelper {
  /// 4 haneli PIN'i basit hash ile hashler.
  static String hashPin(String pin) {
    final bytes = utf8.encode('lutke_zarok_$pin');
    // Basit hash: base64 encode (güvenlik amacı yok, sadece gizleme)
    return base64Encode(bytes);
  }

  /// Girilen PIN'i hash ile karşılaştırır.
  static bool verifyPin(String input, String storedHash) {
    return hashPin(input) == storedHash;
  }
}

/// Çocuk yaş grubu — 7-10 yaş.
final childAgeProvider = StateProvider<int?>((ref) => null);

/// Ebeveyn PIN hash'i.
final parentPinHashProvider = StateProvider<String?>((ref) => null);
