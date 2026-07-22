// LÛTKE — Google Sign-In bridge (web only)
//
// JS bridge `window.LutkeGoogleSignIn` web/index.html'de tanımlı.
// Bu Dart wrapper sadece o bridge'e çağrı yapar.
//
// Akış:
//   1. await initGoogleSignIn(clientId) — GIS'i ayarlar
//   2. await promptGoogleSignIn() — popup açar, ID token döner (veya null)
//   3. Token → CloudflareAuthService.signInWithGoogle(token)

import 'dart:async';
import 'dart:js_interop';
import 'package:flutter/foundation.dart';

@JS('LutkeGoogleSignIn')
external _LutkeBridge? get _bridge;

extension type _LutkeBridge._(JSObject _) implements JSObject {
  external JSPromise<JSAny?> init(String clientId);
  external JSPromise<JSAny?> prompt();
  external bool isAvailable();
}

bool isGoogleSignInAvailable() {
  if (!kIsWeb) return false;
  final b = _bridge;
  if (b == null) return false;
  try {
    return b.isAvailable();
  } catch (_) {
    return false;
  }
}

Future<bool> initGoogleSignIn(String? clientId) async {
  if (!kIsWeb) return false;
  if (clientId == null || clientId.isEmpty) return false;
  final b = _bridge;
  if (b == null) return false;
  try {
    final result = await b.init(clientId).toDart;
    return (result?.dartify() == true);
  } catch (_) {
    return false;
  }
}

Future<String?> promptGoogleSignIn() async {
  if (!kIsWeb) return null;
  final b = _bridge;
  if (b == null) return null;
  try {
    final result = await b.prompt().toDart;
    final v = result?.dartify();
    if (v is String && v.isNotEmpty) return v;
    return null;
  } catch (_) {
    return null;
  }
}
