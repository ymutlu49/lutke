// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// Web platformunda hard reload + URL replace.
/// Tarayici cache, service worker, Riverpod state bypass'lar.
void replaceLocation(String url) {
  html.window.location.replace(url);
}

/// Uygulama içi bir yolun tam adresi. Uygulama /app/ altında sunulur
/// (`<base href="/app/">`); "/" ile başlayan adres tanıtım sitesine gider.
String appUrl(String relative) {
  final base = html.document.baseUri ?? html.window.location.href;
  return Uri.parse(base).resolve(relative).toString();
}

/// Bağlantıyı yeni sekmede açar; açıldıysa `true`.
bool openInNewTab(String url) {
  html.window.open(url, '_blank');
  return true;
}
