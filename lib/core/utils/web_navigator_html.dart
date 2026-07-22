// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// Web platformunda hard reload + URL replace.
/// Tarayici cache, service worker, Riverpod state bypass'lar.
void replaceLocation(String url) {
  html.window.location.replace(url);
}
