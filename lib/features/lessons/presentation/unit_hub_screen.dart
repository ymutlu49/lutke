import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/nav_guard.dart';
import '../../../shared/providers/activity_outcome.dart';
import '../../../shared/providers/language_mode_provider.dart';
import '../../../shared/providers/learning_module_provider.dart';
import '../../../shared/providers/lesson_progress_provider.dart';
import '../../../shared/providers/progression_provider.dart';
import '../domain/lesson_catalog.dart';
import '../domain/lesson_entities.dart';
import 'wane_list_screen.dart';
import '../../en_learning/domain/en_to_quiz_adapter.dart';
import '../domain/a1_kelime_db.dart';
import '../domain/a2_kelime_db.dart';
import '../domain/b1_kelime_db.dart';
import '../domain/b2_kelime_db.dart';
import '../domain/c1_kelime_db.dart';
import '../domain/c2_kelime_db.dart';

// ════════════════════════════════════════════════════════════════
// BİRİM HUB EKRANI — Durak tıklandığında açılır
//
// Etkinlikler kolaydan zora sıralı:
//   1. Peld (Flashcard) — Tanıma
//   2. Ceribandin (Quiz) — Anlama testi
//   3. Guhdarêkirin (Dinleme) — Duyma + seçme
//   4. Lîhevhatên (Eşleştirme) — Anlam ilişkileri
//   5. Hevokê çêke (Cümle Kur) — Sözdizimi
//   6. Hevpeyvîn (Diyalog) — Üretim
//   7. Bilêvkirin (Telaffuz) — Sesli üretim
//
// Her etkinlik bir basamak — tamamlanmadan sonraki açılmaz.
// ════════════════════════════════════════════════════════════════

/// Etkinlik tanımları — kolaydan zora sıralı.
class _ActivityDef {
  final int index;
  final String emoji;
  final String titleKu;
  final String descKu;
  final String descTr;
  final String titleEn;
  final String descEn;
  final Color color;
  final String route;

  const _ActivityDef({
    required this.index,
    required this.emoji,
    required this.titleKu,
    required this.descKu,
    required this.descTr,
    required this.titleEn,
    required this.descEn,
    required this.color,
    required this.route,
  });
}

const _activities = [
  _ActivityDef(
    index: 1, emoji: '🃏', titleKu: 'Peld', route: '/activity/flashcard',
    descKu: 'Bi peldan fêr bibe', descTr: 'Kartlarla öğren',
    titleEn: 'Flashcards', descEn: 'Learn with cards',
    color: Color(0xFFD4783A),
  ),
  _ActivityDef(
    index: 2, emoji: '📝', titleKu: 'Ceribandin', route: '/activity/quiz',
    descKu: 'Zanîna xwe biceribîne', descTr: 'Bilgini test et',
    titleEn: 'Quiz', descEn: 'Test your knowledge',
    color: Color(0xFF1A7B6B),
  ),
  _ActivityDef(
    index: 3, emoji: '🔊', titleKu: 'Guhdarêkirin', route: '/activity/listening',
    descKu: 'Guh bide û hilbijêre', descTr: 'Dinle ve seç',
    titleEn: 'Listening', descEn: 'Listen and choose',
    color: Color(0xFF2196F3),
  ),
  _ActivityDef(
    index: 4, emoji: '🔗', titleKu: 'Lîhevhatên', route: '/activity/word-match',
    descKu: 'Peyv û wateyan li hev bîne', descTr: 'Kelime eşleştir',
    titleEn: 'Word Match', descEn: 'Match word and meaning',
    color: Color(0xFFFF5722),
  ),
  _ActivityDef(
    index: 5, emoji: '🧩', titleKu: 'Hevokê çêke', route: '/activity/sentence-builder',
    descKu: 'Peyvan bi rêz bike', descTr: 'Cümle kur',
    titleEn: 'Sentence Builder', descEn: 'Build sentences',
    color: Color(0xFF9C27B0),
  ),
  _ActivityDef(
    index: 6, emoji: '💬', titleKu: 'Hevpeyvîn', route: '/activity/dialogue',
    descKu: 'Diyalog û axaftin', descTr: 'Sohbet ve konuşma',
    titleEn: 'Dialogue', descEn: 'Conversation practice',
    color: Color(0xFF00BCD4),
  ),
  _ActivityDef(
    index: 7, emoji: '🎤', titleKu: 'Bilêvkirin', route: '/activity/pronunciation',
    descKu: 'Telaffuz û dubarekirin', descTr: 'Telaffuz pratiği',
    titleEn: 'Pronunciation', descEn: 'Repeat and practice',
    color: Color(0xFFE91E63),
  ),
];

class UnitHubScreen extends ConsumerWidget {
  final String category;
  final String titleKu;
  final String titleTr;
  final IconData icon;
  final int wordCount;
  final String level;

  const UnitHubScreen({
    super.key,
    required this.category,
    required this.titleKu,
    this.titleTr = '',
    this.icon = Icons.menu_book_rounded,
    this.wordCount = 0,
    this.level = 'A1',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showTr = ref.watch(showTurkishProvider);
    // TRACK-AWARE FIX: EN track'te Kurmancî labels ve KU DB gösterilmesin.
    final isEn = ref.watch(isEnglishModuleProvider);
    final completed = ref.watch(progressionProvider);
    final progression = ref.read(progressionProvider.notifier);
    final words = _loadCategoryWords(category, level, isEn: isEn);
    final completedCount = progression.completedCountForStop(level, category);
    final dersler =
        isEn ? const <LessonModel>[] : lessonsForUnit(level, category);
    final dersPuanlari = ref.watch(lessonProgressProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // ── Üst bar ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.canPop() ? context.pop() : context.go('/home'),
                    child: Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 4)],
                      ),
                      child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.textSecondary),
                    ),
                  ),
                  const Spacer(),
                  // İlerleme göstergesi
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isEn
                          ? '$completedCount / $kActivityCount done'
                          : '$completedCount / $kActivityCount temam',
                      style: AppTypography.label.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Başlık ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Column(
                children: [
                  Container(
                    width: 72, height: 72,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withOpacity(0.15),
                          AppColors.accent.withOpacity(0.08),
                        ],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary.withOpacity(0.25), width: 2),
                    ),
                    child: Icon(icon, size: 36, color: AppColors.primary),
                  ),
                  const SizedBox(height: 12),
                  Text(titleKu, style: AppTypography.headline.copyWith(color: AppColors.primary)),
                  if (showTr && titleTr.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(titleTr, style: AppTypography.translation),
                  ],
                  const SizedBox(height: 8),
                  // İlerleme çubuğu
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: completedCount / kActivityCount,
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isEn ? '${words.length} words' : '${words.length} peyv',
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms),

            // ── Bölüm tekrarı (Dubare) ───────────────────
            // Zayıf kelimeleri YALNIZCA bu bölümle sınırlı tekrar et.
            // Kullanıcı geri bildirimi (Temmuz 2026): global tekrarda
            // "diğer bölümlerin kelimeleri karşıma çıkıyor" — SmartReview'a
            // eklenen bölüm filtresinin uygulama içi giriş noktası budur.
            // (EN track'te SmartReview kapsam dışı — buton gizli.)
            if (!isEn)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.push(
                      '/home/review',
                      extra: {
                        'level': level,
                        'category': category,
                        'title': titleKu,
                      },
                    ),
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: Text(
                      showTr
                          ? 'Dubare bike — Bu bölümü tekrar et'
                          : 'Dubare bike (ev beş)',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(
                          color: AppColors.primary.withOpacity(0.4)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 150.ms),

            const SizedBox(height: 16),

            // ── Dersler + Etkinlik Basamakları ───────────
            // Birimin elle yazılmış dersi (varsa) en üstte durur: dilbilgisi
            // notu ve yazılmış egzersizler. Etkinlikleri kilitlemez; sıra
            // önerilir. (EN izinin kendi dersleri yok.)
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: dersler.length + _activities.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  if (index < dersler.length) {
                    final ders = dersler[index];
                    return WaneCard(
                      lesson: ders,
                      puan: dersPuanlari[ders.id],
                      showTr: showTr,
                    );
                  }
                  final i = index - dersler.length;
                  final act = _activities[i];
                  final lessonId = ProgressionNotifier.makeLessonId(level, category, act.index);
                  final isCompleted = completed.contains(lessonId);
                  final isUnlocked = progression.isActivityUnlocked(level, category, act.index);
                  final isActive = isUnlocked && !isCompleted;
                  final delay = (100 + i * 80).ms;

                  return _ActivityStepCard(
                    activity: act,
                    stepNumber: act.index,
                    isCompleted: isCompleted,
                    isLocked: !isUnlocked,
                    isActive: isActive,
                    showTr: showTr,
                    isEn: isEn,
                    onTap: isUnlocked
                        ? () => NavGuard.guardAsync(() async {
                            // NAV FIX: Çift tıklama koruması — aksi halde
                            // kullanıcı etkinlik kartına hızla iki kez basınca
                            // iki kez push olur ve markComplete iki defa çalışır.
                            ActivityOutcome.clear();
                            await context.push(
                              act.route,
                              extra: {
                                'level': level,
                                'category': category,
                                'lessonId': lessonId,
                              },
                            );
                            if (!context.mounted) return;
                            // Etkinlik yalnız oturum bitirilip eşik geçildiyse
                            // tamamlanmış sayılır (bkz. ActivityOutcome).
                            // İngilizce izinde etkinliklerin bir bölümü henüz
                            // yok ("yakında" ekranı) ya da ayrı ekranlara
                            // yönleniyor; ölçüt orada uygulanmaz.
                            final outcome = ActivityOutcome.take();
                            if (isEn || (outcome != null && outcome.passed)) {
                              ref.read(progressionProvider.notifier)
                                  .markComplete(lessonId);
                            } else if (!isCompleted) {
                              _showNotPassed(context, outcome,
                                  showTr: showTr, isEn: isEn);
                            }
                          })
                        : null,
                  ).animate().fadeIn(delay: delay).slideX(begin: 0.03);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Etkinlikten dönüldü ama basamak tamamlanmadı: nedenini söyle.
  /// `outcome == null` → oturum bitirilmeden çıkıldı; aksi halde eşik altı.
  void _showNotPassed(BuildContext context, ActivityOutcome? outcome,
      {required bool showTr, required bool isEn}) {
    const esik = 70; // ActivityOutcome.passRatio
    final String mesaj;
    if (outcome == null) {
      mesaj = isEn
          ? 'Finish the activity to complete this step.'
          : showTr
              ? 'Çalakî neqediya — etkinliği sonuna kadar bitir.'
              : 'Çalakî neqediya. Heta dawiyê bidomîne.';
    } else {
      final p = outcome.percent;
      mesaj = isEn
          ? '$p% correct — $esik% needed. Try again.'
          : showTr
              ? 'Ji sedî $p rast e — geçmek için %$esik gerekli. Bir daha dene.'
              : 'Ji sedî $p rast e — ji sedî $esik pêwîst e. Careke din biceribîne.';
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(mesaj),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ));
  }

  List<_SimpleWord> _loadCategoryWords(String category, String level,
      {bool isEn = false}) {
    // TRACK-AWARE: İngilizce track'te getEnWordsForLevel (adapter tr=Kurmancî).
    // Aksi halde Kurmancî DB.
    if (isEn) {
      return getEnWordsForLevel(level.toUpperCase())
          .where((w) => w.kat == category)
          .map<_SimpleWord>((w) => _SimpleWord(w.ku, w.tr))
          .toList();
    }
    final all = switch (level.toUpperCase()) {
      'A1' => kA1TamListe,
      'A2' => kA2TamListe,
      'B1' => kB1All,
      'B2' => kB2All,
      'C1' => kC1All,
      'C2' => kC2All,
      _ => kA1TamListe,
    };
    return (all as List)
        .where((w) => w.kat == category)
        .map((w) => _SimpleWord(w.ku as String, w.tr as String))
        .toList();
  }
}

class _SimpleWord {
  final String ku;
  final String tr;
  const _SimpleWord(this.ku, this.tr);
}

// ── Etkinlik Basamak Kartı ─────────────────────────────────

class _ActivityStepCard extends StatelessWidget {
  final _ActivityDef activity;
  final int stepNumber;
  final bool isCompleted;
  final bool isLocked;
  final bool isActive;
  final bool showTr;
  final bool isEn;
  final VoidCallback? onTap;

  const _ActivityStepCard({
    required this.activity,
    required this.stepNumber,
    required this.isCompleted,
    required this.isLocked,
    required this.isActive,
    required this.showTr,
    this.isEn = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isLocked ? Colors.grey.shade400 : activity.color;

    Widget card = GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isLocked
              ? null
              : LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    isCompleted
                        ? AppColors.success.withOpacity(0.08)
                        : color.withOpacity(0.1),
                    isCompleted
                        ? AppColors.success.withOpacity(0.02)
                        : color.withOpacity(0.03),
                  ],
                ),
          color: isLocked ? Colors.grey.shade50 : null,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCompleted
                ? AppColors.success.withOpacity(0.3)
                : isLocked
                    ? Colors.grey.shade200
                    : color.withOpacity(0.25),
            width: isActive ? 2 : 1.5,
          ),
          boxShadow: isLocked
              ? null
              : [
                  BoxShadow(
                    color: (isCompleted ? AppColors.success : color)
                        .withOpacity(0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          children: [
            // Adım numarası / durum
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? AppColors.success
                    : isLocked
                        ? Colors.grey.shade200
                        : color.withOpacity(0.15),
                border: isActive
                    ? Border.all(color: color, width: 2)
                    : null,
              ),
              child: Center(
                child: isCompleted
                    ? const Icon(Icons.check_rounded, color: Colors.white, size: 20)
                    : isLocked
                        ? Icon(Icons.lock_rounded, color: Colors.grey.shade400, size: 18)
                        : Text(
                            '$stepNumber',
                            style: AppTypography.labelLarge.copyWith(
                              color: color,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
              ),
            ),
            const SizedBox(width: 14),

            // Emoji
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: isLocked
                    ? Colors.grey.shade100
                    : color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  activity.emoji,
                  style: TextStyle(
                    fontSize: 24,
                    color: isLocked ? Colors.grey : null,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Başlık + açıklama — track-aware
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEn ? activity.titleEn : activity.titleKu,
                    style: AppTypography.title.copyWith(
                      color: isLocked ? Colors.grey.shade400 : color,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isEn
                        ? activity.descEn
                        : (showTr ? activity.descTr : activity.descKu),
                    style: AppTypography.caption.copyWith(
                      fontSize: 12,
                      color: isLocked ? Colors.grey.shade400 : null,
                    ),
                  ),
                ],
              ),
            ),

            // Sağ ikon
            if (isCompleted)
              Icon(Icons.check_circle_rounded,
                  color: AppColors.success, size: 22)
            else if (isActive)
              Container(
                width: 28, height: 28,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.play_arrow_rounded, size: 16, color: color),
              )
            else
              Icon(Icons.lock_outline_rounded,
                  size: 18, color: Colors.grey.shade400),
          ],
        ),
      ),
    );

    // Aktif basamak: hafif pulse
    if (isActive) {
      card = card
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scale(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.01, 1.01),
            duration: 1500.ms,
          );
    }

    return card;
  }
}
