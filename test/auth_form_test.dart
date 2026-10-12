// Giriş / kayıt formu (RegisterScreen): iki kip aynı formu paylaşır.
//
// Canlıda görülen kusur (12 Ekim 2026): giriş ekranında boş gönderimden sonra
// "Tomar bibe"ye geçilince doğrulama hataları kayıt formunda yanlış alanların
// altında görünüyordu ("Nav" altında "E-postanı yaz"). Alanlar anahtarsızdı;
// Flutter alan durumunu sıraya göre eşleştiriyordu.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lutke/core/constants/app_theme.dart';
import 'package:lutke/features/auth/register_screen.dart';

const _epostaHatasi = 'E-nava xwe binivîse · E-postanı yaz';
const _sifreHatasi = 'Şîfreya xwe binivîse · Şifreni yaz';

void main() {
  Future<void> ac(WidgetTester tester, {required bool giris}) async {
    SharedPreferences.setMockInitialValues({});
    tester.view.physicalSize = const Size(480, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(theme: AppTheme.light, home: RegisterScreen(isLogin: giris)),
    ));
    await tester.pump(const Duration(seconds: 1));
  }

  testWidgets('giriş: boş gönderimde iki alan da uyarı verir, istek gitmez', (tester) async {
    await ac(tester, giris: true);
    expect(find.text('Têkeve'), findsOneWidget);
    await tester.tap(find.text('Têkeve'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text(_epostaHatasi), findsOneWidget);
    expect(find.text(_sifreHatasi), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
  });

  testWidgets('girişteki doğrulama hataları kayıt formuna taşınmaz', (tester) async {
    await ac(tester, giris: true);
    await tester.tap(find.text('Têkeve'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text(_epostaHatasi), findsOneWidget);

    await tester.tap(find.textContaining('Tomar bibe →'));
    await tester.pump(const Duration(milliseconds: 500));

    // Kayıt formu açıldı; hiçbir alanın altında eski uyarı yok.
    expect(find.text('Nav'), findsOneWidget);
    expect(find.text('Şîfre (cardin)'), findsOneWidget);
    expect(find.text(_epostaHatasi), findsNothing);
    expect(find.text(_sifreHatasi), findsNothing);
    await tester.pump(const Duration(seconds: 2));
  });

  testWidgets('kip değişince yazılan e-posta kaybolmaz', (tester) async {
    await ac(tester, giris: true);
    await tester.enterText(find.byType(TextFormField).first, 'mînak@example.org');
    await tester.tap(find.textContaining('Tomar bibe →'));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('mînak@example.org'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
  });
}
