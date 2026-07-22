import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — Çocuk Ses Efektleri Servisi
//
// Çocuk moduna özel ses efektlerini yönetir.
// Mevcut SoundService'i genişletir.
//
// Ses Tipleri:
//   - correct: Doğru cevap (neşeli melodi)
//   - encourage: Yanlış cevap (yumuşak teşvik)
//   - lessonComplete: Ders tamamlama (zafer fanfar)
//   - starEarned: Yıldız kazanma (pırıltı)
//   - stickerEarned: Çıkartma kazanma (açma sesi)
//   - tap: Dokunma geri bildirimi
//
// MVP NOTE (Nisan 2026): Ses dosyaları henüz mevcut değil.
// Çocuk geri bildirimi olmadan kalmasın diye HAPTIC FEEDBACK
// fallback olarak kullanılır. Ses asset'leri eklendiğinde
// `just_audio` ile çalınacak (TODO play() metodunda).
// ════════════════════════════════════════════════════════════════

enum ChildSoundType {
  correct('assets/sounds/child_correct.mp3'),
  encourage('assets/sounds/child_encourage.mp3'),
  lessonComplete('assets/sounds/child_lesson_complete.mp3'),
  starEarned('assets/sounds/child_star.mp3'),
  stickerEarned('assets/sounds/child_sticker.mp3'),
  tap('assets/sounds/child_tap.mp3');

  final String assetPath;
  const ChildSoundType(this.assetPath);
}

/// Çocuk ses efektleri servisi.
///
/// MVP: Ses dosyaları henüz mevcut değil.
/// Placeholder olarak haptic feedback kullanılabilir.
/// Ses dosyaları eklendiğinde just_audio ile çalınacak.
class ChildSoundService {
  bool _enabled = true;

  /// Ses efektlerini aç/kapat.
  void setEnabled(bool value) => _enabled = value;

  /// Ses çal (placeholder — ses dosyaları eklendiğinde aktifleşir).
  /// Şu anda HAPTIC FEEDBACK ile yedek geri bildirim verir.
  Future<void> play(ChildSoundType type) async {
    if (!_enabled) return;

    // Haptic fallback — ses dosyaları gelene kadar dokunsal geri bildirim.
    // Çocuk hiçbir cevap almasaydı motivasyon kaybı olurdu.
    switch (type) {
      case ChildSoundType.correct:
      case ChildSoundType.lessonComplete:
      case ChildSoundType.starEarned:
      case ChildSoundType.stickerEarned:
        // Pozitif olaylar — orta şiddetli haptic
        await HapticFeedback.mediumImpact();
        break;
      case ChildSoundType.encourage:
        // Yumuşak teşvik — hafif haptic
        await HapticFeedback.lightImpact();
        break;
      case ChildSoundType.tap:
        await HapticFeedback.selectionClick();
        break;
    }

    // TODO: Ses dosyaları eklendiğinde just_audio ile çalınacak
    // final player = AudioPlayer();
    // await player.setAsset(type.assetPath);
    // await player.play();
    // await player.dispose();
  }

  /// Doğru cevap sesi.
  Future<void> playCorrect() => play(ChildSoundType.correct);

  /// Teşvik sesi (yanlış cevap).
  Future<void> playEncourage() => play(ChildSoundType.encourage);

  /// Ders tamamlama sesi.
  Future<void> playLessonComplete() => play(ChildSoundType.lessonComplete);

  /// Yıldız kazanma sesi.
  Future<void> playStarEarned() => play(ChildSoundType.starEarned);

  /// Çıkartma kazanma sesi.
  Future<void> playStickerEarned() => play(ChildSoundType.stickerEarned);

  /// Dokunma sesi (UI feedback).
  Future<void> playTap() => play(ChildSoundType.tap);
}

/// Riverpod provider.
final childSoundServiceProvider = Provider<ChildSoundService>((ref) {
  return ChildSoundService();
});
