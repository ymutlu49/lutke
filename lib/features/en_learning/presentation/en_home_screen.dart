import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../lessons/presentation/home_screen.dart';

/// LÛTKE — İngilizce öğrenme modülü ana sayfası.
///
/// Mevcut Kurmancî HomeScreen ile aynı UI/UX. Veriler `learningModuleProvider`
/// üzerinden otomatik İngilizce kelime havuzuna yönlendirilir.
///
/// Bu wrapper sadece route ayrıştırması için var — gerçek render HomeScreen.
/// Kurmancî modülünden farkı: sadece data feed (EnWord adaptörü).
class EnHomeScreen extends ConsumerWidget {
  const EnHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const HomeScreen();
  }
}
