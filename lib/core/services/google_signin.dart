// LÛTKE — Google Sign-In façade.
// Conditional import: web build'de gerçek implementasyon, mobile'da stub.

export 'google_signin_stub.dart'
    if (dart.library.js_interop) 'google_signin_web.dart';
