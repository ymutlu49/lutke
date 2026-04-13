// Conditional import: web vs native
export 'native.dart' if (dart.library.js_interop) 'web.dart';
