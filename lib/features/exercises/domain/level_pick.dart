/// Beceri alıştırmaları için düzeye göre seçim.
///
/// Konuşma ve yazma ekranları önceden bütün düzeylerden rastgele 10 öge
/// çekiyordu; A1 öğrencisine B2 cümlesi düşebiliyordu. Seçim artık öğrencinin
/// düzeyinden başlar; o düzeyde yeterli öge yoksa önce alt düzeylerle
/// (tekrar), sonra üst düzeylerle tamamlanır.
library;

import 'dart:math';

const List<String> _kDuzeySirasi = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

List<T> pickForLevel<T>(
  List<T> hepsi,
  String? level,
  String Function(T) duzeyi, {
  int adet = 10,
  Random? rng,
}) {
  final r = rng ?? Random();
  final hedef = _kDuzeySirasi.indexOf((level ?? '').toUpperCase());
  if (hedef < 0) {
    return (List<T>.from(hepsi)..shuffle(r)).take(adet).toList();
  }
  // Öncelik: hedef düzey, sonra aşağı doğru, en son yukarı doğru.
  final sira = <int>[
    hedef,
    for (int i = hedef - 1; i >= 0; i--) i,
    for (int i = hedef + 1; i < _kDuzeySirasi.length; i++) i,
  ];
  final secilen = <T>[];
  for (final i in sira) {
    if (secilen.length >= adet) break;
    final buDuzey = hepsi
        .where((x) => duzeyi(x).toUpperCase() == _kDuzeySirasi[i])
        .toList()
      ..shuffle(r);
    secilen.addAll(buDuzey.take(adet - secilen.length));
  }
  return secilen;
}
