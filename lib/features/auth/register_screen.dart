import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/router/app_router.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/cloudflare_auth_service.dart';
import '../../core/services/google_signin.dart' as gsi;
import '../../core/services/local_auth_service.dart';
import '../../shared/widgets/lutke_logo.dart';

// ════════════════════════════════════════════════════════════════
// KAYIT / GİRİŞ EKRANI — LÛTKE
//
// İlke §1.1: Yargılamayan, destekleyici ton
// İlke §0.5: Kurmancî birincil dil
// İlke §2: Anonim giriş seçeneği (bariyer yok)
// İlke §9: Misyon öncelikli — ödeme duvarı engel değil
// ════════════════════════════════════════════════════════════════

class RegisterScreen extends ConsumerStatefulWidget {
  final bool isLogin;
  const RegisterScreen({super.key, this.isLogin = false});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  // Odak sırası — Enter/Next ile alan alan ilerleme (web + mobil klavye).
  // Suffix ikonlarına (şifre göz butonu) odak kaçmasın diye explicit node'lar.
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();
  final _confirmFocus = FocusNode();

  bool _loading = false;
  bool _isLogin = false;
  String? _errorMsg;
  String? _errorCode; // backend kodu — email_not_verified için "tekrar gönder" UI'sı
  bool _passVisible = false;
  bool _confirmVisible = false;
  bool _googleReady = false;

  @override
  void initState() {
    super.initState();
    _isLogin = widget.isLogin;
    _initGoogleSignIn();
  }

  Future<void> _initGoogleSignIn({bool isRetry = false}) async {
    try {
      final config = await ref
          .read(cloudflareAuthServiceProvider)
          .fetchPublicConfig();
      final clientId = config['googleClientId'] as String?;
      if (clientId == null || clientId.isEmpty) {
        // /api/public-config erişilemedi (yavaş ağ / geçici hata) —
        // bir kez, kısa gecikmeyle yeniden dene; buton kalıcı kaybolmasın.
        if (!isRetry && mounted) {
          await Future<void>.delayed(const Duration(seconds: 3));
          if (mounted) await _initGoogleSignIn(isRetry: true);
        }
        return;
      }
      final ok = await gsi.initGoogleSignIn(clientId);
      if (!mounted) return;
      if (ok) {
        setState(() => _googleReady = true);
      } else if (!isRetry) {
        // GIS script'i henüz yüklenmemiş olabilir (async defer) — tek retry.
        await Future<void>.delayed(const Duration(seconds: 3));
        if (mounted) await _initGoogleSignIn(isRetry: true);
      }
    } catch (_) {
      // Google Sign-In opsiyonel — başarısızlıkta sessiz geç.
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  // ── KAYIT (Cloudflare-native + yerel mirror) ────────────────
  //
  // Mayıs 2026: Firebase yerine Cloudflare Pages Functions + D1.
  // Akış:
  //   1. POST /api/auth/signup (CloudflareAuthService)
  //   2. Sunucu kullanıcı yaratır + doğrulama maili gönderir.
  //   3. Mevcut UI provider'ları (isOwnerLocalProvider vs.) için
  //      yerel mirror tutulur.
  //   4. Doğrulama mailini onaylamadıysa → email-verification ekranı.
  //
  // Owner email kontrolü artık BACKEND'de (env.OWNER_EMAIL).

  Future<void> _register() async {
    if (_loading) return; // Çift tıklama / Enter spam koruması
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _errorMsg = null; _errorCode = null; });

    final email = _emailCtrl.text.trim();
    final password = _passCtrl.text;
    final displayName = _nameCtrl.text.trim();

    try {
      final cf = ref.read(cloudflareAuthServiceProvider);
      final result = await cf.signup(
        email: email,
        password: password,
        displayName: displayName,
      );

      if (!result.isSuccess) {
        if (!mounted) return;
        setState(() {
          _loading = false;
          _errorCode = result.errorCode;
          _errorMsg = _humanizeApiError(result.errorCode, result.error,
              isLogin: false);
        });
        return;
      }

      // Yerel mirror — mevcut UI/Provider zinciri çalışmaya devam etsin.
      await _mirrorToLocal(
        email: email,
        password: password,
        displayName: displayName,
        isOwner: result.user?.isOwner ?? false,
      );

      if (!mounted) return;
      setState(() => _loading = false);
      TextInput.finishAutofillContext(shouldSave: true);

      // Provider'ları yenile.
      ref.invalidate(cloudflareCurrentUserProvider);
      ref.invalidate(localCurrentUserProvider);
      await refreshLocalOwnerState(ref);

      // KAYIT SONRASI ZORUNLU DOĞRULAMA AKIŞI:
      // Kullanıcı verify-email ekranına yönlendirilir; doğrulamadan
      // app'in geri kalanına erişemez (router redirect kuralı bunu
      // app-wide enforce eder).
      // Owner ise muaf — direkt intro'ya gider.
      final isOwner = result.user?.isOwner ?? false;
      if (isOwner) {
        context.go(AppRoutes.introFlow);
      } else {
        context.go(AppRoutes.emailVerification);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _errorMsg = _humanizeApiError(null, e.toString(), isLogin: false);
      });
    }
  }

  // ── GİRİŞ ───────────────────────────────────────────────────

  Future<void> _login() async {
    if (_loading) return; // Çift tıklama / Enter spam koruması
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _errorMsg = null; _errorCode = null; });

    final email = _emailCtrl.text.trim();
    final password = _passCtrl.text;

    try {
      final cf = ref.read(cloudflareAuthServiceProvider);
      final result = await cf.login(email: email, password: password);

      if (!result.isSuccess) {
        // Sunucu erişilebilir değilse — yerel offline cache'i dene.
        if (result.errorCode == 'network') {
          final localUser = await ref.read(localAuthServiceProvider).login(
                email: email,
                password: password,
              );
          if (localUser != null) {
            // Offline mod — yerel kullanıcıyla devam et.
            if (!mounted) return;
            setState(() => _loading = false);
            await refreshLocalOwnerState(ref);
            ref.invalidate(localCurrentUserProvider);
            TextInput.finishAutofillContext(shouldSave: true);
            context.go(AppRoutes.introFlow);
            return;
          }
        }
        if (!mounted) return;
        setState(() {
          _loading = false;
          _errorCode = result.errorCode;
          _errorMsg = _humanizeApiError(result.errorCode, result.error,
              isLogin: true);
        });
        return;
      }

      // Yerel mirror — UI Provider zinciri için.
      await _mirrorToLocal(
        email: email,
        password: password,
        displayName: result.user?.displayName ?? '',
        isOwner: result.user?.isOwner ?? false,
      );

      if (!mounted) return;
      TextInput.finishAutofillContext(shouldSave: true);

      // Provider'ları yenile + Future'ları bekle (race fix — Mayıs 2026).
      ref.invalidate(cloudflareCurrentUserProvider);
      ref.invalidate(localCurrentUserProvider);
      try {
        await ref.read(cloudflareCurrentUserProvider.future);
      } catch (_) {}
      await refreshLocalOwnerState(ref);
      if (!mounted) return;
      setState(() => _loading = false);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      if (!mounted) return;
      context.go(AppRoutes.introFlow);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _errorMsg = _humanizeApiError(null, e.toString(), isLogin: true);
      });
    }
  }

  /// Cloudflare auth sonuç verilerini yerel cache'e mirror et.
  /// Mevcut isOwnerLocalProvider, isLoggedInLocalProvider ve diğer
  /// Riverpod zincirleri yerel kullanıcıdan okuduğu için zorunlu.
  Future<void> _mirrorToLocal({
    required String email,
    required String password,
    required String displayName,
    required bool isOwner,
  }) async {
    try {
      final localAuth = ref.read(localAuthServiceProvider);
      // Aynı email mevcut → güncellenecek; değilse yeni kayıt olur.
      // (LocalAuthService Owner için register'ı yeniden çalıştırır.)
      await localAuth.register(
        email: email,
        password: password,
        displayName: displayName,
      );
    } catch (_) {
      // Mirror başarısızlığı login akışını kırmamalı; cloud token zaten
      // SharedPreferences'ta. Sessizce yut.
    }
  }

  /// API hatalarını kullanıcı diline çevir — İKİ DİLLİ (Kurmancî + Türkçe).
  /// Auth ekranları login ÖNCESİ olduğundan track/dil henüz seçilmemiş
  /// olabilir; İngilizce modülü kullanıcıları da aynı ekranı kullanır.
  /// Bu yüzden her mesaj: Kurmancî satır + Türkçe satır.
  /// errorCode: backend'in döndürdüğü makine-okunabilir kod
  ///   (email_taken, invalid_credentials, weak_password, network, …)
  String _humanizeApiError(String? code, String? raw, {required bool isLogin}) {
    final c = code ?? '';
    final m = (raw ?? '').toLowerCase();

    if (c == 'network' || m.contains('socket') || m.contains('timeout') ||
        m.contains('connection') || m.contains('xmlhttprequest')) {
      return 'Girêdana înternetê tune. Girêdana xwe kontrol bike.\n'
          'İnternet bağlantısı yok. Bağlantını kontrol et.';
    }
    if (c == 'email_taken' || m.contains('exist') || m.contains('already') ||
        m.contains('duplicate')) {
      return 'Ev e-nav berê hatiye tomarkirin — bi şîfreya xwe têkeve.\n'
          'Bu e-posta zaten kayıtlı — şifrenle giriş yap.';
    }
    if (c == 'invalid_credentials') {
      return 'E-nav an şîfre ne rast e. Hesabê te tune be, "Tomar bibe" bitikîne.\n'
          'E-posta veya şifre hatalı. Hesabın yoksa "Tomar bibe"ye dokun.';
    }
    if (c == 'weak_password' || m.contains('weak')) {
      return 'Şîfre pir kurt e — herî kêm 8 tîp pêwîst in.\n'
          'Şifre çok kısa — en az 8 karakter olmalı.';
    }
    if (c == 'rate_limited') {
      return 'Pir gelek hewl. Çend deqe bisekine û paşê biceribîne.\n'
          'Çok fazla deneme. Birkaç dakika bekleyip tekrar dene.';
    }
    if (c == 'invalid_email') {
      return 'E-naveke rast binivîse (mînak: nav@minak.com).\n'
          'Geçerli bir e-posta yaz (örnek: ad@ornek.com).';
    }
    if (c == 'email_not_verified') {
      return 'Divê tu e-nava xwe piştrast bikî — inboxa xwe kontrol bike.\n'
          'E-postanı doğrulaman gerekiyor — gelen kutunu (ve spam) kontrol et.';
    }
    return isLogin
        ? 'Têketin bi ser neket. Ji kerema xwe dîsa biceribîne.\n'
            'Giriş başarısız oldu. Lütfen tekrar dene.'
        : 'Tomarkirin bi ser neket. Ji kerema xwe dîsa biceribîne.\n'
            'Kayıt başarısız oldu. Lütfen tekrar dene.';
  }

  // ── Google Sign-In ──────────────────────────────────────────
  Future<void> _signInWithGoogle() async {
    if (_loading) return; // Çift tıklama koruması
    setState(() {
      _loading = true;
      _errorMsg = null;
      _errorCode = null;
    });
    try {
      final idToken = await gsi.promptGoogleSignIn();
      if (idToken == null) {
        if (!mounted) return;
        setState(() => _loading = false);
        return; // Kullanıcı vazgeçti — sessiz.
      }
      final cf = ref.read(cloudflareAuthServiceProvider);
      final result = await cf.signInWithGoogle(idToken);
      if (!result.isSuccess) {
        if (!mounted) return;
        setState(() {
          _loading = false;
          _errorCode = result.errorCode;
          _errorMsg = _humanizeApiError(result.errorCode, result.error,
              isLogin: true);
        });
        return;
      }
      // Yerel mirror — Google kullanıcısı için dummy şifre kullan; mevcut
      // local provider zinciri için kayıt yeterli.
      await _mirrorToLocal(
        email: result.user!.email,
        password: 'google-oauth-${result.user!.id.substring(0, 8)}',
        displayName: result.user?.displayName ?? '',
        isOwner: result.user?.isOwner ?? false,
      );
      if (!mounted) return;
      // KRİTİK: Provider'ları invalidate et + Future'ları bekle.
      // Aksi halde router redirect bayat cfUser değeriyle çalışıp
      // intro yerine başka yere yönlendirebilir (Mayıs 2026 race fix).
      ref.invalidate(cloudflareCurrentUserProvider);
      ref.invalidate(localCurrentUserProvider);
      try {
        await ref.read(cloudflareCurrentUserProvider.future);
      } catch (_) {}
      await refreshLocalOwnerState(ref);
      if (!mounted) return;
      setState(() => _loading = false);
      // Settle frame — Riverpod rebuild + GoRouter redirect döngüsü tamamlansın.
      await Future<void>.delayed(const Duration(milliseconds: 50));
      if (!mounted) return;
      context.go(AppRoutes.introFlow);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _errorMsg = 'Têketina bi Google bi ser neket. Dîsa biceribîne.\n'
            'Google ile giriş başarısız oldu. Tekrar dene.';
      });
    }
  }

  // ── Doğrulama mailini tekrar gönder ─────────────────────────
  Future<void> _resendVerification() async {
    if (_loading) return; // Çift tıklama koruması
    setState(() => _loading = true);
    final cf = ref.read(cloudflareAuthServiceProvider);
    // /api/auth/resend-verification authenticated bir endpoint (Bearer token).
    // Token yalnızca signup sonrası persist edilir; login 403 (email_not_verified)
    // döndüğünde persist EDİLMEZ. Yani farklı bir cihazdan giriş deneyen
    // doğrulanmamış kullanıcı buradan yeni lînk İSTEYEMEZ — bilinen backend
    // sınırı (bkz. rapor: e-posta ile unauthenticated resend endpoint önerisi).
    // Kullanıcıya dürüst ve yol gösteren iki dilli mesaj göster.
    final token = await cf.getStoredToken();
    if (token == null) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _errorMsg =
            'Lînka piştrastkirinê ya di e-nava te de bikar bîne — an jî li ser '
            'amûra ku te tomar kiribû dîsa biceribîne.\n'
            'Kayıt olurken gönderilen doğrulama e-postasındaki linki kullan — '
            'veya kayıt olduğun cihazdan tekrar dene.';
      });
      return;
    }
    final result = await cf.resendVerification();
    if (!mounted) return;
    setState(() => _loading = false);
    if (result.isSuccess) {
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Lînk hate şandin',
              style: TextStyle(fontWeight: FontWeight.w800)),
          content: const Text(
              'Lînka piştrastkirinê dîsa hate şandin. Inboxa xwe '
              '(û peldanka spam) kontrol bike.\n\n'
              'Doğrulama linki tekrar gönderildi. Gelen kutunu '
              '(ve spam klasörünü) kontrol et.'),
          actions: [
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Baş e',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      );
    } else {
      setState(() => _errorMsg =
          'Lînk nehate şandin — paşê dîsa biceribîne.\n'
          'Link gönderilemedi — daha sonra tekrar dene.'
          '${result.error != null ? '\n(${result.error})' : ''}');
    }
  }

  // NOT (Nisan 2026): Anonim/misafir giriş kaldırıldı.
  // Firebase yapılandırması tamamlanmadığı için anonim giriş hata
  // veriyordu. Şimdi sadece email + şifre kayıt/giriş açık.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Form(
            key: _formKey,
            child: AutofillGroup(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xl),

                // Logo ve başlık — Kurmancî önce (İlke §0.5)
                _Header(isLogin: _isLogin),

                const SizedBox(height: AppSpacing.xl),

                // Ad — sadece kayıtta
                if (!_isLogin) ...[
                  _buildField(
                    ctrl: _nameCtrl,
                    label: 'Nav',
                    hint: 'Navê xwe binivîse',
                    icon: Icons.person_outline,
                    keyboardType: TextInputType.name,
                    autofillHints: const [AutofillHints.name],
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => _emailFocus.requestFocus(),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Navê xwe binivîse · Adını yaz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],

                // E-nav
                _buildField(
                  ctrl: _emailCtrl,
                  focusNode: _emailFocus,
                  label: 'E-nav',
                  hint: 'e-nav@mînak.com',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [
                    AutofillHints.username,
                    AutofillHints.email,
                  ],
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => _passFocus.requestFocus(),
                  validator: (v) {
                    // RegExp ji bo domain + TLD pejirandinê — toleranslı.
                    final val = v?.trim() ?? '';
                    if (val.isEmpty) {
                      return 'E-nava xwe binivîse · E-postanı yaz';
                    }
                    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                        .hasMatch(val);
                    if (!ok) {
                      return 'E-naveke rast binivîse · Geçerli bir e-posta yaz';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppSpacing.md),

                // Şifre
                _buildField(
                  ctrl: _passCtrl,
                  focusNode: _passFocus,
                  label: 'Şîfre',
                  hint: '••••••••',
                  icon: Icons.lock_outline,
                  obscure: !_passVisible,
                  autofillHints: _isLogin
                      ? const [AutofillHints.password]
                      : const [AutofillHints.newPassword],
                  textInputAction:
                      _isLogin ? TextInputAction.done : TextInputAction.next,
                  onFieldSubmitted: (_) {
                    // Kayıtta Enter → şifre tekrar alanına geç;
                    // girişte Enter → direkt submit. (finishAutofillContext
                    // yalnız BAŞARILI auth sonrası çağrılır — geçersiz formda
                    // tarayıcıya "şifreyi kaydet" prompt'u açtırma.)
                    if (_isLogin) {
                      _login();
                    } else {
                      _confirmFocus.requestFocus();
                    }
                  },
                  suffix: IconButton(
                    tooltip: _passVisible
                        ? 'Şîfreyê veşêre · Şifreyi gizle'
                        : 'Şîfreyê nîşan bide · Şifreyi göster',
                    icon: Icon(
                      _passVisible ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () => setState(() => _passVisible = !_passVisible),
                  ),
                  validator: (v) {
                    if (_isLogin) {
                      // Giriş: sadece boş kontrolü — uzunluk şartını backend
                      // zaten invalid_credentials olarak yanıtlar.
                      if (v == null || v.isEmpty) {
                        return 'Şîfreya xwe binivîse · Şifreni yaz';
                      }
                      return null;
                    }
                    // Kayıt: backend validatePassword ile aynı kural (min 8).
                    if (v == null || v.length < 8) {
                      return 'Şîfre herî kêm 8 tîp · Şifre en az 8 karakter';
                    }
                    return null;
                  },
                ),

                // Şifre tekrar — sadece kayıtta (yazım hatasına karşı koruma)
                if (!_isLogin) ...[
                  const SizedBox(height: AppSpacing.md),
                  _buildField(
                    ctrl: _confirmCtrl,
                    focusNode: _confirmFocus,
                    label: 'Şîfre (cardin)',
                    hint: '••••••••',
                    icon: Icons.lock_outline,
                    obscure: !_confirmVisible,
                    autofillHints: const [AutofillHints.newPassword],
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _register(),
                    suffix: IconButton(
                      tooltip: _confirmVisible
                          ? 'Şîfreyê veşêre · Şifreyi gizle'
                          : 'Şîfreyê nîşan bide · Şifreyi göster',
                      icon: Icon(
                        _confirmVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () =>
                          setState(() => _confirmVisible = !_confirmVisible),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Şîfreyê cardin binivîse · Şifreni tekrar yaz';
                      }
                      if (v != _passCtrl.text) {
                        return 'Şîfre ne wek hev in · Şifreler eşleşmiyor';
                      }
                      return null;
                    },
                  ),
                ],

                // Şifremi unuttum — sadece girişte
                if (_isLogin) ...[
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _forgotPassword,
                      child: Text(
                        'Şîfreya xwe ji bîr kir? · Şifreni mi unuttun?',
                        style: AppTypography.caption
                            .copyWith(color: AppColors.primary),
                      ),
                    ),
                  ),
                ],

                // Hata mesajı — nazik ton (İlke §1.1)
                // A11Y (19 Nisan): Semantics liveRegion → ekran okuyucu
                // otomatik okur, user odaklanmak zorunda kalmaz.
                if (_errorMsg != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  // email_not_verified durumunda farklı renk + tekrar gönder butonu.
                  if (_errorCode == 'email_not_verified')
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFA726).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color(0xFFFFA726).withOpacity(0.4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.mark_email_unread_outlined,
                                  color: Color(0xFFE65100), size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _errorMsg!,
                                  style: AppTypography.caption.copyWith(
                                      color: const Color(0xFFE65100)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          OutlinedButton.icon(
                            onPressed: _loading ? null : _resendVerification,
                            icon: const Icon(Icons.refresh, size: 18),
                            label: const Text('Lînkê dîsa bişîne'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFFE65100),
                              side: const BorderSide(color: Color(0xFFE65100)),
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (_errorCode == 'email_taken')
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppColors.primary.withOpacity(0.4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.alternate_email,
                                  color: AppColors.primary, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _errorMsg!,
                                  style: AppTypography.caption.copyWith(
                                      color: AppColors.primary),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          ElevatedButton.icon(
                            onPressed: _loading
                                ? null
                                : () => setState(() {
                                      _isLogin = true;
                                      _errorMsg = null;
                                      _errorCode = null;
                                      // Ad alanı gizleneceği için temizle —
                                      // şîfre + e-nav korunur, kullanıcı
                                      // direkt "Têkeve" basabilsin.
                                      _nameCtrl.clear();
                                      _confirmCtrl.clear();
                                    }),
                            icon: const Icon(Icons.login, size: 18),
                            label: const Text('Têkeve →'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              minimumSize: const Size(double.infinity, 44),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Semantics(
                    liveRegion: true,
                    label: 'Xeletî: ${_errorMsg!}',
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF5350).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color(0xFFEF5350).withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: Color(0xFFEF5350), size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _errorMsg!,
                              style: AppTypography.caption.copyWith(
                                  color: const Color(0xFFEF5350)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: AppSpacing.lg),

                // Ana buton
                ElevatedButton(
                  onPressed: _loading
                      ? null
                      : (_isLogin ? _login : _register),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: _loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : Text(
                          _isLogin ? 'Têkeve' : 'Tomar bibe',
                          style: AppTypography.labelLarge.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                ),

                // ── Google Sign-In — opsiyonel, GIS yüklendi ve clientId varsa görünür ──
                if (_googleReady) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'an jî · veya',
                          style: AppTypography.caption
                              .copyWith(color: AppColors.textSecondary),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  OutlinedButton.icon(
                    onPressed: _loading ? null : _signInWithGoogle,
                    icon: const _GoogleGIcon(),
                    label: const Text(
                      'Bi Google re têkeve',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF1F1F1F),
                      backgroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 52),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ],

                const SizedBox(height: AppSpacing.md),

                // Geçiş linki
                TextButton(
                  onPressed: () => setState(() {
                    _isLogin = !_isLogin;
                    _errorMsg = null;
                    _errorCode = null;
                    // Kayda özgü alanlar gizlenirken içerikleri de sıfırlansın.
                    _confirmCtrl.clear();
                  }),
                  child: Text(
                    _isLogin
                        ? 'Hesabê te tune? Tomar bibe →\nHesabın yok mu? Kayıt ol'
                        : 'Hesabê te heye? Têkeve →\nHesabın var mı? Giriş yap',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textSecondary),
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Gizlilik notu
                Text(
                  'Agahiyên te bi ewlehî tên parastin.',
                  style: AppTypography.caption
                      .copyWith(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController ctrl,
    required String label,
    required String hint,
    required IconData icon,
    bool obscure = false,
    TextInputType? keyboardType,
    Widget? suffix,
    String? Function(String?)? validator,
    Iterable<String>? autofillHints,
    TextInputAction? textInputAction,
    void Function(String)? onFieldSubmitted,
    FocusNode? focusNode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTypography.labelMedium
                .copyWith(color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        TextFormField(
          // Giriş ve kayıt aynı formu paylaşır; alanlar sırayla eşleştiği için
          // anahtarsız bırakılınca bir kipteki doğrulama hatası öteki kipte
          // yanlış alanın altında görünüyordu (girişte boş gönderim → kayıtta
          // "Nav" altında "E-postanı yaz"). Anahtar kipe ve alana bağlı:
          // kip değişince alan durumu yenilenir, yazılan metin denetleyicide kalır.
          key: ValueKey('${_isLogin ? 'tekeve' : 'tomar'}:$label'),
          controller: ctrl,
          focusNode: focusNode,
          obscureText: obscure,
          keyboardType: keyboardType,
          validator: validator,
          autofillHints: autofillHints,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          style: AppTypography.bodyMedium
              .copyWith(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.bodyMedium
                .copyWith(color: AppColors.textSecondary.withOpacity(0.5)),
            prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
            suffixIcon: suffix,
            filled: true,
            fillColor: AppColors.backgroundSecondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFEF5350), width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  Future<void> _forgotPassword() async {
    if (_loading) return; // Çift tıklama koruması
    final email = _emailCtrl.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      setState(() => _errorMsg =
          'Pêşî e-nava xwe binivîse, paşê dîsa biceribîne.\n'
          'Önce e-postanı yaz, sonra tekrar dene.');
      return;
    }
    // Loading dialog — kullanıcı butonu spam'lemesin, durum belli olsun.
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    // Cloudflare-native: backend her zaman 200 döner (enumeration prevent).
    await ref.read(cloudflareAuthServiceProvider).requestPasswordReset(email);
    // Eski Firebase yedeği (varsa) — hata yutar.
    try {
      await ref.read(authServiceProvider).sendPasswordReset(email);
    } catch (_) {}
    if (!mounted) return;
    Navigator.of(context).pop(); // loading dialog'u kapat
    if (!mounted) return;
    // Confirmation dialog — kullanıcının kesinlikle göreceği görünür onay.
    // SnackBar yerine AlertDialog: küçük ekranlarda gözden kaçmıyor + e-posta
    // adresini açık gösteriyor + "spam klasörüne bak" notu içeriyor.
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.mark_email_read_rounded,
                  color: AppColors.primary, size: 26),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'E-nav hate şandin',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Heke $email qeydkirî be, lînka guhertina şîfreyê hate şandin.\n'
              'Eğer $email kayıtlıysa, şifre sıfırlama linki gönderildi.',
              style: AppTypography.bodyMedium
                  .copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 12),
            Text(
              'E-nava xwe (û peldanka spam) kontrol bike. Lînk 1 saetê derbasdar e.\n'
              'Gelen kutunu (ve spam klasörünü) kontrol et. Link 1 saat geçerli.',
              style: AppTypography.caption
                  .copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size(120, 44),
            ),
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Baş e',
                style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// GOOGLE "G" İKON — official multicolor "G" rendered without external assets.
// Tek widget: 4 colored arc segments + blue stem. ~22dp.
// ════════════════════════════════════════════════════════════════

class _GoogleGIcon extends StatelessWidget {
  const _GoogleGIcon();

  @override
  Widget build(BuildContext context) {
    // Resmi Google logosu CDN'den yükleme yerine — şirin, basit "G" yeterli.
    // Marka rengi: Google blue.
    return Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFF4285F4), Color(0xFF34A853)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Text(
        'G',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 14,
          height: 1.0,
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// BAŞLIK — Kurmancî önce (İlke §0.5)
// ════════════════════════════════════════════════════════════════

class _Header extends StatelessWidget {
  final bool isLogin;
  const _Header({required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LutkeLogo.brand(iconSize: 72, animated: true),

        const SizedBox(height: AppSpacing.md),

        Text(
          isLogin
              ? 'Bi xêr hatî dîsa'
              : 'Bê ziman, mirov bê kok e!',
          style: AppTypography.bodyMedium
              .copyWith(color: AppColors.textSecondary),
        ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
      ],
    );
  }
}
