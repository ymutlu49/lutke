import 'dart:js_interop';

/// Web implementation — calls JavaScript eval() via dart:js_interop.
@JS('eval')
external JSAny? _jsEval(JSString code);

void evalJs(String script) {
  _jsEval(script.toJS);
}

/// Synchronous eval returning the result as Dart object (string typically).
dynamic evalJsSync(String script) {
  final r = _jsEval(script.toJS);
  return r?.toString();
}
