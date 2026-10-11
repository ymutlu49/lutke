// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// Web platformunda hard reload + URL replace.
/// Tarayici cache, service worker, Riverpod state bypass'lar.
void replaceLocation(String url) {
  html.window.location.replace(url);
}

/// Bağlantıyı yeni sekmede açar; açıldıysa `true`.
bool openInNewTab(String url) {
  html.window.open(url, '_blank');
  return true;
}
