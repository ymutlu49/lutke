import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/nav_guard.dart';
import '../../../shared/providers/language_mode_provider.dart';
import '../../../shared/providers/lesson_progress_provider.dart';
import '../domain/lesson_catalog.dart';
import '../../../shared/providers/learning_track_provider.dart';
import '../domain/bicim_alistirma.dart';
import '../domain/en_ders.dart';
import '../domain/lesson_entities.dart';
import '../domain/olcme.dart';

// ════════════════════════════════════════════════════════════════
// WANE LİSTESİ — bir düzeyin elle yazılmış dersleri, yazıldıkları sırayla
//
// Dersler kilitli değildir: sıra önerilir, dayatılmaz. Derslerin birim
// ağacındaki yeri (önce ders mi, önce kelime mi) ayrı bir karar; bu ekran
// o karardan bağımsız olarak bütün dersleri erişilir kılar.
// ════════════════════════════════════════════════════════════════

class WaneListScreen extends ConsumerWidget {
  final String level;
  const WaneListScreen({super.key, this.level = 'A1'});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showTr = ref.watch(showTurkishProvider);
    final puanlar = ref.watch(lessonProgressProvider);
    // İngilizce yol (Ekim 2026): elle yazılmış dersi yok; listede dilbilgisi
    // alıştırmaları ve İngilizce düzey sınavı durur (en_ders.dart).
    final english = ref.watch(currentTrackProvider).isEnglish;
    final dersler = english ? const <LessonModel>[] : lessonsForLevel(level);
    // Veriden üretilen biçim alıştırmaları (Faz 4.6): listenin başında.
    final rahenan = [
      for (final id in english ? enBicimDersKimlikleri(level) : bicimDersKimlikleri(level))
        if ((english ? enBicimDersi(id) : bicimDersi(id)) case final d?) d,
    ];
    // Düzey sınavı (Faz 6.2): listenin sonunda. Sertifika buna bağlı.
    final ezmun = english
        ? ezmunEnDersi(ezmunEnKimligi(level))
        : ezmunDersi(ezmunKimligi(level));
    // Sayaç: Kurmancîde elle yazılmış dersler, İngilizcede alıştırmalar.
    final sayilan = english ? rahenan : dersler;
    final gecilen = sayilan.where((d) => lessonPassed(puanlar, d.id)).length;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded,
              color: AppColors.textSecondary),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go(AppRoutes.home),
        ),
        title: Text(
          'Wane · ${level.toUpperCase()}',
          style: AppTypography.title.copyWith(color: AppColors.primary),
        ),
        centerTitle: true,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: AppSpacing.md),
              child: Text(
                '$gecilen / ${sayilan.length}',
                style: AppTypography.label.copyWith(
                    color: AppColors.primary, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
      body: dersler.isEmpty && rahenan.isEmpty && ezmun == null
          ? Center(
              child: Text('Wane tune ye.',
                  style: AppTypography.bodyLarge
                      .copyWith(color: AppColors.textSecondary)),
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.xl),
              itemCount: rahenan.length + dersler.length + (ezmun == null ? 0 : 1),
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, i) {
                if (i < rahenan.length) {
                  return WaneCard(
                    lesson: rahenan[i],
                    puan: puanlar[rahenan[i].id],
                    showTr: showTr,
                  );
                }
                final j = i - rahenan.length;
                if (j >= dersler.length) {
                  return WaneCard(
                    lesson: ezmun!,
                    puan: puanlar[ezmun.id],
                    showTr: showTr,
                  );
                }
                return WaneCard(
                  lesson: dersler[j],
                  sira: j + 1,
                  puan: puanlar[dersler[j].id],
                  showTr: showTr,
                );
              },
            ),
    );
  }
}

/// Tek bir dersin kartı. Liste ekranında ve birim merkezinde kullanılır.
class WaneCard extends StatelessWidget {
  final LessonModel lesson;
  final int? sira;
  final int? puan; // en iyi başarı yüzdesi; hiç oynanmadıysa null
  final bool showTr;

  const WaneCard({
    super.key,
    required this.lesson,
    this.sira,
    this.puan,
    this.showTr = true,
  });

  @override
  Widget build(BuildContext context) {
    final gecti = puan != null && puan! >= 70;
    final renk = gecti ? AppColors.success : AppColors.primary;
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        onTap: () => NavGuard.guard(() =>
            context.push(AppRoutes.wanePlay, extra: {'lessonId': lesson.id})),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(color: renk.withOpacity(0.25), width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: gecti ? AppColors.success : renk.withOpacity(0.12),
                ),
                child: Center(
                  child: gecti
                      ? const Icon(Icons.check_rounded,
                          color: Colors.white, size: 20)
                      : sira != null
                          ? Text('$sira',
                              style: AppTypography.labelLarge.copyWith(
                                  color: renk, fontWeight: FontWeight.w800))
                          : Icon(Icons.menu_book_rounded,
                              color: renk, size: 20),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.kurmanjTitle,
                      style: AppTypography.title.copyWith(
                          color: AppColors.textPrimary, fontSize: 16),
                    ),
                    if (showTr && lesson.turkishTitle.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(lesson.turkishTitle, style: AppTypography.caption),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      '${lesson.exercises.length} pirs · '
                      '${lesson.estimatedMinutes} deqe'
                      '${puan != null ? ' · ji sedî $puan' : ''}',
                      style: AppTypography.caption
                          .copyWith(color: AppColors.textTertiary),
                    ),
                  ],
                ),
              ),
              Icon(
                gecti
                    ? Icons.replay_rounded
                    : Icons.play_circle_fill_rounded,
                color: renk,
                size: gecti ? 20 : 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
