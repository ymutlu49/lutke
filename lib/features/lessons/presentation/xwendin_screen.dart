// Okuma ("Xwendin") — iyileştirme planı Faz 5.
//
// İki ekran:
//   XwendinListScreen  düzeyin okuma metinleri
//   XwendinScreen      bir metin: önce okuma, sonra anlama soruları
//
// Sorular elle yazılmış derslerle aynı ekranda (WaneScreen) oynanır; metnin
// soru dersi `xwendin_<kimlik>` kimliğiyle katalogdan gelir. Sorusu olmayan
// metin "Min xwend" ile tamamlanır.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/nav_guard.dart';
import '../../../core/utils/web_navigator_stub.dart'
    if (dart.library.html) '../../../core/utils/web_navigator_html.dart';
import '../../../shared/providers/activity_outcome.dart';
import '../../../shared/providers/language_mode_provider.dart';
import '../../../shared/providers/lesson_progress_provider.dart';
import '../domain/gotar_baglanti_db.dart';
import '../domain/xwendin_catalog.dart';

class XwendinListScreen extends ConsumerWidget {
  final String level;
  const XwendinListScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showTr = ref.watch(showTurkishProvider);
    final puanlar = ref.watch(lessonProgressProvider);
    final metinler = xwendinForLevel(level);
    // Gotar köprüsü (Faz 7): gavbigav.com'daki makaleler B2 ve üstünde.
    // Ölçüm: B2 söz varlığı bu metinlerin yaklaşık %80'ini kapsıyor.
    final gotar = kGotarDuzeyleri.contains(level.toUpperCase())
        ? kGotarBaglantilari
        : const <(String, String)>[];

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textSecondary),
          onPressed: () => context.canPop() ? context.pop() : context.go(AppRoutes.home),
        ),
        title: Text(
          'Xwendin · ${level.toUpperCase()}',
          style: AppTypography.title.copyWith(color: AppColors.primary),
        ),
        centerTitle: true,
      ),
      body: metinler.isEmpty && gotar.isEmpty
          ? Center(
              child: Text('Metn tune ye.',
                  style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary)),
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.xl),
              itemCount: metinler.length + (gotar.isEmpty ? 0 : gotar.length + 1),
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, i) {
                if (i == metinler.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.md, bottom: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gotar · gavbigav.com',
                          style: AppTypography.label.copyWith(
                              color: AppColors.primary, fontWeight: FontWeight.w700),
                        ),
                        if (showTr)
                          Text('Uygulama dışında açılır; ileri düzey okuma.',
                              style: AppTypography.caption),
                      ],
                    ),
                  );
                }
                if (i > metinler.length) {
                  final (sernav, url) = gotar[i - metinler.length - 1];
                  return Material(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                      // Web'de yeni sekme; mobilde paylaşım sayfası (tarayıcıda aç / kopyala).
                      onTap: () {
                        if (!openInNewTab(url)) Share.share('$sernav — $url');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                sernav,
                                style: AppTypography.label
                                    .copyWith(color: AppColors.textPrimary),
                              ),
                            ),
                            const Icon(Icons.open_in_new_rounded,
                                size: 18, color: AppColors.textSecondary),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                final m = metinler[i];
                final puan = puanlar[m.dersKimligi];
                final gecti = puan != null && puan >= 70;
                final renk = gecti ? AppColors.success : AppColors.primary;
                return Material(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                    onTap: () => NavGuard.guard(() =>
                        context.push(AppRoutes.xwendinRead, extra: {'id': m.id})),
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                        border: Border.all(color: renk.withOpacity(0.25), width: 1.5),
                      ),
                      child: Row(
                        children: [
                          Text(m.emoji, style: const TextStyle(fontSize: 28)),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  m.titleKu,
                                  style: AppTypography.label.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w700),
                                ),
                                if (showTr)
                                  Text(m.titleTr, style: AppTypography.caption),
                                const SizedBox(height: 2),
                                Text(
                                  '${m.sozcukSayisi} peyv'
                                  '${m.sorular.isEmpty ? '' : ' · ${m.sorular.length} pirs'}',
                                  style: AppTypography.caption
                                      .copyWith(color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),
                          if (gecti)
                            const Icon(Icons.check_circle_rounded, color: AppColors.success),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class XwendinScreen extends ConsumerStatefulWidget {
  final String id;
  const XwendinScreen({super.key, required this.id});

  @override
  ConsumerState<XwendinScreen> createState() => _XwendinScreenState();
}

class _XwendinScreenState extends ConsumerState<XwendinScreen> {
  late final XwendinMetni? _metin = xwendinById(widget.id);

  /// Çeviri başta kapalıdır: önce Kurmancîsi okunur.
  bool _ceviriAcik = false;

  void _tamamla() {
    final m = _metin!;
    ref.read(lessonProgressProvider.notifier).record(m.dersKimligi, 100);
    ActivityOutcome.report(const ActivityOutcome.completed());
    if (context.canPop()) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final m = _metin;
    if (m == null) {
      // Bilinmeyen kimlik yolu kilitlemesin.
      ActivityOutcome.reportNoContent();
      return Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        appBar: AppBar(backgroundColor: AppColors.backgroundPrimary, elevation: 0),
        body: Center(
          child: Text('Metn tune ye.',
              style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary)),
        ),
      );
    }
    final showTr = ref.watch(showTurkishProvider);
    final puan = ref.watch(lessonProgressProvider)[m.dersKimligi];
    final gecti = puan != null && puan >= 70;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textSecondary),
          onPressed: () => context.canPop() ? context.pop() : context.go(AppRoutes.home),
        ),
        title: Text(
          m.titleKu,
          style: AppTypography.title.copyWith(color: AppColors.primary),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        actions: [
          if (showTr)
            TextButton(
              onPressed: () => setState(() => _ceviriAcik = !_ceviriAcik),
              child: Text(_ceviriAcik ? 'Wergerê veşêre' : 'Werger'),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.xl),
        children: [
          if (m.ozetKu != null)
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              margin: const EdgeInsets.only(bottom: AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.06),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(m.ozetKu!,
                      style: AppTypography.body.copyWith(color: AppColors.textPrimary)),
                  if (showTr && _ceviriAcik && m.ozetTr != null)
                    Text(m.ozetTr!, style: AppTypography.caption),
                ],
              ),
            ),
          for (final s in m.satirlar)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (s.konusan != null)
                    Text(
                      s.konusan!,
                      style: AppTypography.caption.copyWith(
                          color: AppColors.primary, fontWeight: FontWeight.w700),
                    ),
                  Text(
                    s.ku,
                    style: AppTypography.bodyLarge
                        .copyWith(color: AppColors.textPrimary, height: 1.5),
                  ),
                  if (showTr && _ceviriAcik)
                    Text(
                      s.tr,
                      style: AppTypography.caption
                          .copyWith(color: AppColors.textSecondary, height: 1.4),
                    ),
                ],
              ),
            ),
          if (m.kaynak != null)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Text('Çavkanî: ${m.kaynak}', style: AppTypography.caption),
            ),
          const SizedBox(height: AppSpacing.sm),
          if (gecti)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 20),
                  const SizedBox(width: 6),
                  Text('Te ev metn qedand.',
                      style: AppTypography.caption.copyWith(color: AppColors.success)),
                ],
              ),
            ),
          // Uygulama teması düğmeye tam genişlik verir; liste içinde güvenli.
          ElevatedButton(
            onPressed: m.sorular.isEmpty
                ? _tamamla
                : () => NavGuard.guard(() => context.push(AppRoutes.wanePlay,
                    extra: {'lessonId': m.dersKimligi})),
            child: Text(m.sorular.isEmpty ? 'Min xwend' : 'Pirs (${m.sorular.length})'),
          ),
        ],
      ),
    );
  }
}
