import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/router/app_router.dart';
import '../../core/services/cloudflare_auth_service.dart';
import '../providers/learning_track_provider.dart';

// ════════════════════════════════════════════════════════════════
// DÜZEY TESTİNE GÖNÜLLÜ DAVET — ana ekran kartı
//
// Ekim 2026: düzey belirleme testi girişin koşulu olmaktan çıktı. Kullanıcı
// uygulamaya doğrudan girer ve A1'den başlar; düzeyini seçiciden kendisi
// değiştirebilir. Testi isteyen bu karttan (ya da düzey seçicisinden /
// profilden) açar.
//
// Kart yalnız şu durumda görünür: etkin yol için düzey testi hiç yapılmamış
// (hesapta da cihazda da sonuç yok) VE kullanıcı daveti "Paşê" ile
// kapatmamış. Kapatma yol bazında saklanır; testin kalıcı girişleri
// (düzey seçicisi, profil) yerinde durur.
// ════════════════════════════════════════════════════════════════

/// Düzey testi sonucu her yazıldığında artar. Ana ekran testten dönüşte aynı
/// örnek olarak kalır; davet kartı bunu dinleyerek kendini yeniden değerlendirir.
final placementRevisionProvider = StateProvider<int>((_) => 0);

/// "Paşê" ile kapatılan davetin anahtarı — yol dili bazında.
String placementInviteDismissedKeyFor(String languageCode) =>
    'placement_invite_dismissed_$languageCode';

class PlacementInviteCard extends ConsumerStatefulWidget {
  const PlacementInviteCard({super.key});

  @override
  ConsumerState<PlacementInviteCard> createState() =>
      _PlacementInviteCardState();
}

class _PlacementInviteCardState extends ConsumerState<PlacementInviteCard> {
  /// Kararı verilen yol dili; yol değişince yeniden bakılır.
  String? _kararDili;
  bool _goster = false;

  Future<void> _karar(String languageCode) async {
    var goster = false;
    try {
      final prefs = await SharedPreferences.getInstance();
      final kapatildi =
          prefs.getBool(placementInviteDismissedKeyFor(languageCode)) ?? false;
      if (!kapatildi) {
        goster = !(await hasPlacementForTrack(ref, languageCode));
      }
    } catch (_) {
      goster = false;
    }
    if (!mounted) return;
    setState(() {
      _kararDili = languageCode;
      _goster = goster;
    });
  }

  Future<void> _kapat(String languageCode) async {
    setState(() => _goster = false);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(placementInviteDismissedKeyFor(languageCode), true);
    } catch (_) {}
  }

  Future<void> _testiAc(String languageCode) async {
    await context.push(AppRoutes.placementTest);
    // Testten geri dönüldü (kapatma). Sonuç yazıldıysa kart zaten
    // placementRevisionProvider üzerinden kalkmıştır; burada bir kez daha bak.
    if (mounted) await _karar(languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final track = ref.watch(currentTrackProvider);
    final dil = track.languageCode;
    // Test sonucu yazıldı (bu karttan ya da başka bir girişten): yeniden bak.
    ref.listen<int>(placementRevisionProvider, (_, __) {
      _karar(ref.read(currentTrackProvider).languageCode);
    });
    if (_kararDili != dil) {
      // Karar eşzamansız; gelene kadar (ve yol değişince) kart gizli.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _kararDili != dil) _karar(dil);
      });
      return const SizedBox.shrink();
    }
    if (!_goster || track.isChild) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.assessment_outlined,
                  color: AppColors.primary, size: 22),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Asta xwe bibîne',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            // Kurmancî satır var olan metinlerden: test ekranının başlığı ve
            // sonuç ekranındaki "öneridir, emir değil" cümlesi.
            track.isEnglish
                ? 'Diyarkirina astê · CEFR A1–C2. Ev pêşniyar e, ne ferman.'
                : 'Diyarkirina astê · CEFR A1–C2. Ev pêşniyar e, ne ferman.\n'
                    'Düzey testi isteğe bağlıdır; istersen şimdi, istersen '
                    'sonra yapabilirsin.',
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              FilledButton(
                onPressed: () => _testiAc(dil),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, AppSpacing.touchMin),
                ),
                child: const Text('Dest pê bike'),
              ),
              const SizedBox(width: AppSpacing.sm),
              TextButton(
                onPressed: () => _kapat(dil),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                  minimumSize: const Size(0, AppSpacing.touchMin),
                ),
                child: const Text('Paşê'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
