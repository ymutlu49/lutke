// LÛTKE — Google Sign-In stub (non-web platforms).
// Web olmayan derlemelerde no-op. google_signin.dart conditional import yapar.

bool isGoogleSignInAvailable() => false;
Future<bool> initGoogleSignIn(String? clientId) async => false;
Future<String?> promptGoogleSignIn() async => null;
