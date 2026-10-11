/// Mobile/desktop platformlari icin no-op stub.
/// Conditional import ile dart:html olmayan platformlarda kullanilir.
void replaceLocation(String url) {
  // Mobile platformda hard reload mantikli degil — Navigator zaten state
  // tutar; conditional import ile bu fonksiyon cagrilmaz.
}

/// Web dışında yeni sekme yok; çağıran paylaşım sayfasına düşer.
bool openInNewTab(String url) => false;
