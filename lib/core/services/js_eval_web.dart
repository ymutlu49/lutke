import 'dart:js_interop';

/// Web implementation — calls JavaScript eval() via dart:js_interop.
@JS('eval')
external void _jsEval(JSString code);

void evalJs(String script) {
  _jsEval(script.toJS);
}
