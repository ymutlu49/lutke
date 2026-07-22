import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/router/app_router.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/cloudflare_auth_service.dart';
import '../../core/services/local_auth_service.dart';
import '../../shared/widgets/lutke_goat_icon.dart';

// ════════════════════════════════════════════════════════════════
// E-NAV PIŞTRASTKIRINA EKRANÊ — LÛTKE
//
// Cloudflare auth pipeline'ında signup sonrası gönderilen
// verification email'i için landing screen.
//
// Akış:
//   1. Kullanıcı email'deki linke tıklar → /auth/verify-email?token=…
//   2. Bu ekran token'ı parse eder, /api/auth/verify-email POST eder
//   3. Sonuç: success / token_expired / token_invalid
//
// Not: Token URL parametresinden gelir (deep-link uyumlu).
// ════════════════════════════════════════════════════════════════

class EmailVerificationScreen extends ConsumerStatefulWidget {
  final String? token;
  const EmailVerificationScreen({super.key, this.token});

  @override
  ConsumerState<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
  _VerifyState _state = _VerifyState.idle;
  String? _errorMsg;
  bool _resendBusy = false;
  bool _resendDone = false;
  bool _checkBusy = false;

  // "Dîsa bişîne" cooldown'u — spam engeli + kullanıcıya net geri bildirim.
  // Backend'de resend rate-limit yok; client tarafında 60 sn bekletiyoruz.
  static const int _resendCooldownSecs = 60;
  int _cooldownLeft = 0;
  Timer? _cooldownTimer;

  @override
  void initState() {
    super.initState();
    final t = widget.token;
    if (t != null && t.isNotEmpty) {
      // Token varsa otomatik doğrula.
      WidgetsBinding.instance.addPostFrameCallback((_) => _verify(t));
    }
  }

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    _cooldownTimer?.cancel();
    setState(() => _cooldownLeft = _resendCooldownSecs);
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        _cooldownLeft--;
        if (_cooldownLeft <= 0) t.cancel();
      });
    });
  }

  Future<void> _verify(String token) async {
    setState(() {
      _state = _VerifyState.busy;
      _errorMsg = null;
    });
    final cf = ref.read(cloudflareAuthServiceProvider);
    final result = await cf.verifyEmailWithToken(token);
    if (!mounted) return;
    if (result.isSuccess) {
      setState(() => _state = _VerifyState.success);
      ref.invalidate(cloudflareCurrentUserProvider);
    } else {
      setState(() {
        _state = _VerifyState.failure;
        _errorMsg = _humanize(result.errorCode, result.error);
      });
    }
  }

  Future<void> _resend() async {
    if (_resendBusy || _cooldownLeft > 0) return; // spam koruması
    setState(() {
      _resendBusy = true;
      _resendDone = false;
      _errorMsg = null;
    });
    final result =
        await ref.read(cloudflareAuthServiceProvider).resendVerification();
    if (!mounted) return;
    setState(() {
      _resendBusy = false;
      _resendDone = result.isSuccess;
      if (!result.isSuccess) {
        _errorMsg = _humanize(result.errorCode, result.error);
      }
    });
    if (result.isSuccess) _startCooldown();
  }

  /// "Min piştrast kir" — kullanıcı linki başka sekmede/cihazda tıkladıysa
  /// server'dan taze durumu çekip yönlendir. Router gate'inin bayat cache
  /// yüzünden kullanıcıyı kilitlemesini önler.
  Future<void> _checkVerified() async {
    if (_checkBusy) return;
    setState(() {
      _checkBusy = true;
      _errorMsg = null;
    });
    final fresh =
        await ref.read(cloudflareAuthServiceProvider).refreshMe();
    if (!mounted) return;
    setState(() => _checkBusy = false);
    if (fresh != null && fresh.emailVerified) {
      ref.invalidate(cloudflareCurrentUserProvider);
      context.go(AppRoutes.introFlow);
    } else {
      setState(() => _errorMsg =
          'Hê piştrastkirî xuya nake. Lînka di e-nava xwe de bitikîne, '
          'paşê dîsa kontrol bike.\n'
          'Henüz doğrulanmamış görünüyor. E-postandaki linke tıkla, '
          'sonra tekrar kontrol et.');
    }
  }

  /// Yanlış hesapla kayıt olunduysa / farklı hesapla girilecekse çıkış yolu.
  /// Eski "Paşê bike" → /home linki router'ın verification gate'i yüzünden
  /// geri sekiyordu (dead-end); yerine gerçekten çalışan bir aksiyon.
  Future<void> _switchAccount() async {
    await ref.read(cloudflareAuthServiceProvider).logout();
    try {
      await ref.read(localAuthServiceProvider).logout();
    } catch (_) {}
    if (!mounted) return;
    ref.invalidate(cloudflareCurrentUserProvider);
    ref.invalidate(localCurrentUserProvider);
    await refreshLocalOwnerState(ref);
    if (!mounted) return;
    context.go(AppRoutes.login);
  }

  /// İKİ DİLLİ hata mesajları (Kurmancî + Türkçe) — auth ekranları login
  /// öncesi olduğundan dil/track seçimi henüz yapılmamış olabilir.
  String _humanize(String? code, String? raw) {
    final c = code ?? '';
    final m = (raw ?? '').toLowerCase();
    if (c == 'token_expired') {
      return 'Lînk demborî bûye. Ji bo lînka nû "Dîsa bişîne"yê bitikîne.\n'
          'Linkin süresi dolmuş. Yeni link için "Dîsa bişîne"ye dokun.';
    }
    if (c == 'token_invalid' || c == 'invalid_token' || c == 'token_missing') {
      return 'Ev lînk ne derbasdar e. Ji bo lînka nû "Dîsa bişîne"yê bitikîne.\n'
          'Bu link geçersiz. Yeni link için "Dîsa bişîne"ye dokun.';
    }
    if (c == 'rate_limited') {
      return 'Pir gelek hewl. Çend deqe bisekine.\n'
          'Çok fazla deneme. Birkaç dakika bekle.';
    }
    if (c == 'unauthorized') {
      return 'Pêşî têkeve, paşê e-navê piştrast bike.\n'
          'Önce giriş yap, sonra e-postanı doğrula.';
    }
    if (c == 'email_failed') {
      return 'E-nav nehate şandin — paşê dîsa biceribîne.\n'
          'E-posta gönderilemedi — daha sonra tekrar dene.';
    }
    if (c == 'network' || m.contains('socket') || m.contains('timeout')) {
      return 'Girêdana înternetê tune. Ji kerema xwe biceribîne.\n'
          'İnternet bağlantısı yok. Lütfen tekrar dene.';
    }
    return 'Tiştek xelet bû. Ji kerema xwe dîsa biceribîne.\n'
        'Bir şeyler ters gitti. Lütfen tekrar dene.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Center(
            child: SingleChildScrollView(
              child: _buildContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_state) {
      case _VerifyState.busy:
        return _buildBusy();
      case _VerifyState.success:
        return _buildSuccess();
      case _VerifyState.failure:
        return _buildFailure();
      case _VerifyState.idle:
        return _buildIdle();
    }
  }

  Widget _buildBusy() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const LutkeGoatIcon(size: 80),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'E-nav tê piştrastkirin…',
          style: AppTypography.headingSmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const CircularProgressIndicator(strokeWidth: 2),
      ],
    );
  }

  Widget _buildSuccess() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_circle_outline,
              color: Color(0xFF4CAF50), size: 56),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'E-nav hate piştrastkirin!',
          style: AppTypography.headingSmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Spas ji bo piştrastkirinê. Niha hesabê te bi tevahî aktîf e.\n'
          'Doğrulama tamamlandı. Hesabın artık tamamen aktif.',
          style: AppTypography.bodyMedium
              .copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xl),
        ElevatedButton(
          // Doğrulama başarılı → ilk kez giriş introsu (ardından track-select).
          // Kullanıcı uygulamayı tanıma fırsatını yakalayacak.
          onPressed: () => context.go(AppRoutes.introFlow),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
          ),
          child: Text(
            'Berdewam bike',
            style: AppTypography.labelLarge.copyWith(
                color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  Widget _buildFailure() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: const Color(0xFFEF5350).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.error_outline,
              color: Color(0xFFEF5350), size: 56),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Piştrastkirin bi ser neket',
          style: AppTypography.headingSmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          _errorMsg ?? 'Tiştek xelet bû. Ji kerema xwe dîsa biceribîne.',
          style: AppTypography.bodyMedium
              .copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xl),
        ElevatedButton.icon(
          onPressed: (_resendBusy || _cooldownLeft > 0) ? null : _resend,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
          ),
          icon: _resendBusy
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
              : const Icon(Icons.mail_outline, size: 18),
          label: Text(
            _cooldownLeft > 0
                ? 'Hate şandin — ${_cooldownLeft}s'
                : (_resendDone ? 'Lînk hate şandin' : 'Lînka nû bişîne'),
            style: AppTypography.labelLarge
                .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildCheckVerifiedButton(),
        const SizedBox(height: AppSpacing.xs),
        _buildSwitchAccountButton(),
      ],
    );
  }

  /// "Min piştrast kir → kontrol bike" — server'dan taze durum çek.
  Widget _buildCheckVerifiedButton() {
    return OutlinedButton.icon(
      onPressed: _checkBusy ? null : _checkVerified,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        minimumSize: const Size(double.infinity, 48),
        side: BorderSide(color: AppColors.primary.withOpacity(0.5)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      icon: _checkBusy
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.task_alt_rounded, size: 18),
      label: Text(
        'Min piştrast kir — kontrol bike',
        style: AppTypography.labelLarge.copyWith(
            color: AppColors.primary, fontWeight: FontWeight.w700),
      ),
    );
  }

  /// Farklı hesapla giriş — eski dead-end "Paşê bike"nin yerini aldı.
  Widget _buildSwitchAccountButton() {
    return TextButton(
      onPressed: _switchAccount,
      child: Text(
        'Bi hesabekî din têkeve · Farklı hesapla gir',
        style:
            AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
      ),
    );
  }

  Widget _buildIdle() {
    // Kayıtlı e-posta adresi — kullanıcı hangi kutuya bakacağını bilsin.
    final email = ref
        .watch(cloudflareCurrentUserProvider)
        .valueOrNull
        ?.email;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const LutkeGoatIcon(size: 96),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'E-nava xwe piştrast bike',
          style: AppTypography.headingSmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          email == null
              ? 'Me lînkek piştrastkirinê ji bo e-nava te şand. '
                  'Inboxa xwe kontrol bike û li ser lînkê bitikîne.\n'
                  'Doğrulama linki e-postana gönderildi. '
                  'Gelen kutunu kontrol et ve linke tıkla.'
              : 'Me lînkek piştrastkirinê şand bo:\n$email\n'
                  'Inboxa xwe kontrol bike û li ser lînkê bitikîne. · '
                  'Gelen kutunu kontrol et ve linke tıkla.',
          style: AppTypography.bodyMedium
              .copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.lg),

        // Spam pop-up'ı bilgilendirme
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline,
                  color: AppColors.primary, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'E-nav nehat? Pelika "Spam" jî kontrol bike.\n'
                  'E-posta gelmediyse "Spam" klasörüne de bak.',
                  style: AppTypography.caption
                      .copyWith(color: AppColors.textPrimary),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        if (_errorMsg != null) ...[
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: const Color(0xFFEF5350).withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFEF5350).withOpacity(0.3)),
            ),
            child: Text(
              _errorMsg!,
              style: AppTypography.caption
                  .copyWith(color: const Color(0xFFEF5350)),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        if (_resendDone) ...[
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle_outline,
                    color: Color(0xFF4CAF50), size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Lînka nû hate şandin. Inboxa xwe kontrol bike.\n'
                    'Yeni link gönderildi. Gelen kutunu kontrol et.',
                    style: AppTypography.caption
                        .copyWith(color: const Color(0xFF4CAF50)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        ElevatedButton.icon(
          onPressed: (_resendBusy || _cooldownLeft > 0) ? null : _resend,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
          ),
          icon: _resendBusy
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
              : const Icon(Icons.refresh_rounded, size: 18),
          label: Text(
            _cooldownLeft > 0
                ? 'Hate şandin — ${_cooldownLeft}s'
                : 'Lînkê dîsa bişîne',
            style: AppTypography.labelLarge
                .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        _buildCheckVerifiedButton(),

        const SizedBox(height: AppSpacing.xs),

        _buildSwitchAccountButton(),
      ],
    );
  }
}

enum _VerifyState { idle, busy, success, failure }

// ════════════════════════════════════════════════════════════════
// BANNER — diğer ekranlarda göstermek için reusable widget.
//
// Ana ekranlarda (home, profile) cloudflareCurrentUserProvider'a
// bakar, emailVerified=false ise bu banner görünür.
// ════════════════════════════════════════════════════════════════

class EmailVerificationBanner extends ConsumerWidget {
  const EmailVerificationBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(cloudflareCurrentUserProvider);
    return asyncUser.maybeWhen(
      data: (user) {
        if (user == null || user.emailVerified) {
          return const SizedBox.shrink();
        }
        return Container(
          margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: const Color(0xFFFFA726).withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: const Color(0xFFFFA726).withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.mark_email_unread_outlined,
                  color: Color(0xFFFFA726), size: 20),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'E-nava xwe piştrast bike',
                      style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Lînka di e-nava te de bitikîne.',
                      style: AppTypography.caption
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () => context.push(AppRoutes.emailVerification),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFFFA726),
                ),
                child: Text(
                  'Veke',
                  style: AppTypography.caption.copyWith(
                      color: const Color(0xFFFFA726),
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}
