// Non-web stub — `certificate_service.dart` içinden conditional import ile
// yalnızca web DERLEMESİNDE gerçek dosya kullanılır; mobile/desktop burada
// hiçbir şey yapmaz. Bu dosya dart:html'e bağımsızdır, bu yüzden
// platform-agnostik derlemede hata çıkmaz.

import 'dart:typed_data';

/// No-op — mobil/desktop üzerinde dart:html mevcut değil. Gerçek indirme
/// share_plus XFile ile `certificate_service.dart` içinde yapılır.
void downloadPng({required Uint8List bytes, required String fileName}) {
  // Intentionally empty on non-web platforms.
}
