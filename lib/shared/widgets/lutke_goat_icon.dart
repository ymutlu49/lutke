import 'package:flutter/material.dart';

/// LÛTKE — Karîk (dağ keçisi) ikon widget.
///
/// Kurmancî dil rozeti / aksesuvar olarak küçük boyutlarda kullanılır.
/// Kürdistan bayrağı yerine projenin logo karakteri ile marka tutarlılığı
/// sağlar.
///
/// Kullanım:
/// ```dart
/// const LutkeGoatIcon(size: 16)
/// ```
class LutkeGoatIcon extends StatelessWidget {
  final double size;

  const LutkeGoatIcon({super.key, this.size = 16});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        // 64'lük varyant — küçük render boyutlarında en az detay kaybı
        'assets/images/mascot_64.png',
        fit: BoxFit.contain,
        filterQuality: FilterQuality.medium,
      ),
    );
  }
}
