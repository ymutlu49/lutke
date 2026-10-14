// Kayıt / giriş akışı — Ekim 2026 denetiminde bulunan kusurların sınamaları.
//
//   1. Yönlendirme kuralları (saf işlev) ve router'ın oturum değişince
//      yeniden KURULMAMASI (eskiden her değişiklikte açılış ekranına atıyordu).
//   2. Şifre tarayıcı deposuna yazılmaz; eski kurulumdaki düz metin silinir.
//   3. Giriş: sunucu yeni doğrulama e-postası gönderdiyse kullanıcıya söylenir.
//   4. Form: düzeltilen alanın uyarısı düğmeye yeniden basmadan kalkar.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lutke/core/constants/app_theme.dart';
import 'package:lutke/core/router/app_router.dart';
import 'package:lutke/core/services/auth_service.dart';
import 'package:lutke/core/services/cloudflare_auth_service.dart';
import 'package:lutke/core/services/local_auth_service.dart';
import 'package:lutke/features/auth/register_screen.dart';

CloudflareUser _kullanici({bool dogrulandi = false, bool sahip = false}) => CloudflareUser(
      id: 'u1',
      email: 'mînak@example.org',
      emailVerified: dogrulandi,
      isOwner: sahip,
    );

final _oturum = StateProvider<bool>((_) => false);
final _hesap = StateProvider<CloudflareUser?>((_) => null);

void main() {
  group('yönlendirme kuralları', () {
    String? yon(String loc, {bool oturum = false, AsyncValue<CloudflareUser?>? hesap, String query = ''}) =>
        appRedirect(
          loc: loc,
          query: query,
          isLoggedIn: oturum,
          cfUserAsync: hesap ?? const AsyncData<CloudflareUser?>(null),
        );

    test('oturumsuz: giriş ve kayıt ekranları yerinde kalır', () {
      expect(yon(AppRoutes.login), isNull);
      expect(yon(AppRoutes.register), isNull);
      expect(yon(AppRoutes.splash), isNull);
    });

    test('doğrulanmamış kullanıcı uygulama içi her yoldan doğrulama ekranına gider', () {
      final h = AsyncData<CloudflareUser?>(_kullanici());
      expect(yon('/home', oturum: true, hesap: h), AppRoutes.emailVerification);
      expect(yon(AppRoutes.introFlow, oturum: true, hesap: h), AppRoutes.emailVerification);
      expect(yon(AppRoutes.placementTest, oturum: true, hesap: h), AppRoutes.emailVerification);
      // Doğrulama ve şifre sıfırlama ekranları her zaman açık.
      expect(yon(AppRoutes.emailVerification, oturum: true, hesap: h), isNull);
      expect(yon(AppRoutes.resetPassword, oturum: true, hesap: h), isNull);
    });

    test('kayıttan hemen sonra: hesap yüklenirken karar verilmez, yüklenince doğrulama ekranı', () {
      // Yerel oturum hazır, Cloudflare kullanıcısı henüz yükleniyor.
      expect(yon(AppRoutes.register, oturum: true, hesap: const AsyncLoading<CloudflareUser?>()), isNull);
      // Yüklendi: doğrulanmamış → tanıtıma uğramadan doğrulama ekranı.
      expect(
        yon(AppRoutes.register, oturum: true, hesap: AsyncData<CloudflareUser?>(_kullanici())),
        AppRoutes.emailVerification,
      );
    });

    test('doğrulanmış (ya da sahip) kullanıcı giriş ekranından tanıtım akışına gider', () {
      expect(
        yon(AppRoutes.login, oturum: true, hesap: AsyncData<CloudflareUser?>(_kullanici(dogrulandi: true))),
        AppRoutes.introFlow,
      );
      expect(
        yon(AppRoutes.login, oturum: true, hesap: AsyncData<CloudflareUser?>(_kullanici(sahip: true))),
        AppRoutes.introFlow,
      );
      // Sahip, doğrulanmamış olsa da uygulamaya kilitlenmez.
      expect(yon('/home', oturum: true, hesap: AsyncData<CloudflareUser?>(_kullanici(sahip: true))), isNull);
    });

    test('yönetici paneli yalnız sahibe; hesap yüklenirken karar verilmez', () {
      final kullanici = AsyncData<CloudflareUser?>(_kullanici(dogrulandi: true));
      final sahip = AsyncData<CloudflareUser?>(_kullanici(dogrulandi: true, sahip: true));
      expect(yon('/admin', oturum: true, hesap: kullanici), AppRoutes.home);
      expect(yon('/admin/content', oturum: true, hesap: kullanici), AppRoutes.home);
      expect(yon('/admin'), AppRoutes.home);
      expect(yon('/admin', oturum: true, hesap: sahip), isNull);
      expect(yon('/admin/content', oturum: true, hesap: sahip), isNull);
      expect(yon('/admin', oturum: true, hesap: const AsyncLoading<CloudflareUser?>()), isNull);
      expect(
        appRedirect(loc: '/admin', query: '', isLoggedIn: true, cfUserAsync: kullanici, isLocalOwner: true),
        isNull,
      );
    });

    test('eski e-posta bağlantısı /verify-email belirteciyle yeni yola taşınır', () {
      expect(yon('/verify-email', query: 'token=abc'), '${AppRoutes.emailVerification}?token=abc');
    });
  });

  test('router oturum değişince yeniden kurulmaz (tek örnek)', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer(overrides: [
      isAnyLoggedInProvider.overrideWith((ref) => ref.watch(_oturum)),
      cloudflareCurrentUserProvider.overrideWith((ref) async => ref.watch(_hesap)),
    ]);
    addTearDown(container.dispose);
    final abone = container.listen(appRouterProvider, (_, __) {});
    addTearDown(abone.close);

    final ilk = container.read(appRouterProvider);
    container.read(_oturum.notifier).state = true;
    container.read(_hesap.notifier).state = _kullanici();
    await container.read(cloudflareCurrentUserProvider.future);
    await Future<void>.delayed(Duration.zero);
    expect(identical(container.read(appRouterProvider), ilk), isTrue);

    container.read(_hesap.notifier).state = _kullanici(dogrulandi: true);
    await container.read(cloudflareCurrentUserProvider.future);
    await Future<void>.delayed(Duration.zero);
    expect(identical(container.read(appRouterProvider), ilk), isTrue);
  });

  group('yerel kimlik: şifre saklanmaz', () {
    test('kayıtta şifre depoya yazılmaz; kullanıcı kaydı yazılır', () async {
      SharedPreferences.setMockInitialValues({});
      final s = LocalAuthService();
      await s.register(email: 'Mînak@Example.org', password: 'gizli-sifre-123', displayName: 'Mînak');
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('lutke_local_user_v1'), isNotNull);
      expect(prefs.containsKey('lutke_local_pass_v1'), isFalse);
      for (final k in prefs.getKeys()) {
        expect(prefs.get(k).toString(), isNot(contains('gizli-sifre-123')), reason: k);
      }
      expect((await s.currentUser())?.email, 'mînak@example.org');
    });

    test('eski kurulumdan kalan düz metin şifre ilk okumada silinir', () async {
      SharedPreferences.setMockInitialValues({
        'lutke_local_user_v1': '{"email":"a@example.org","displayName":"A","isOwner":false,"registeredAt":"2026-01-01T00:00:00.000"}',
        'lutke_local_pass_v1': 'eski-duz-metin',
      });
      final s = LocalAuthService();
      expect((await s.currentUser())?.email, 'a@example.org');
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.containsKey('lutke_local_pass_v1'), isFalse);
    });

    test('çevrimdışı girişte saklı şifreyle eşleştirme yoktur', () async {
      SharedPreferences.setMockInitialValues({});
      final s = LocalAuthService();
      await s.register(email: 'a@example.org', password: 'gizli-sifre-123', displayName: 'A');
      expect(await s.login(email: 'a@example.org', password: 'gizli-sifre-123'), isNull);
    });
  });

  test('giriş sonucu: sunucunun "yeni bağlantı gönderildi" bilgisi taşınır', () {
    const yok = CloudflareAuthResult.failure(error: 'x', errorCode: 'email_not_verified');
    const var_ = CloudflareAuthResult.failure(error: 'x', errorCode: 'email_not_verified', verificationSent: true);
    expect(yok.verificationSent, isFalse);
    expect(var_.verificationSent, isTrue);
    expect(var_.isSuccess, isFalse);
  });

  testWidgets('form: düzeltilen alanın uyarısı düğmeye yeniden basmadan kalkar', (tester) async {
    SharedPreferences.setMockInitialValues({});
    tester.view.physicalSize = const Size(480, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(theme: AppTheme.light, home: const RegisterScreen(isLogin: true)),
    ));
    await tester.pump(const Duration(seconds: 1));

    const epostaHatasi = 'E-nava xwe binivîse · E-postanı yaz';
    await tester.tap(find.text('Têkeve'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text(epostaHatasi), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, 'mînak@example.org');
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text(epostaHatasi), findsNothing);
    // Şifre alanına dokunulmadı; onun uyarısı duruyor.
    expect(find.text('Şîfreya xwe binivîse · Şifreni yaz'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
  });
}
