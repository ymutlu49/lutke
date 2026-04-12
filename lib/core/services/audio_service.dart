import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

// ════════════════════════════════════════════════════���═══════════
// SES SERVİSİ — LÛTKE
//
// İlke §7.3: 44.1kHz OPUS, yavaş + normal + cümle içinde
// İlke §5.5: Ses dinle → seç ⭐⭐⭐ Heritage önceliği
//
// just_audio ile hem asset hem URL'den ses çalma.
// Singleton pattern: tek AudioPlayer instance, bellek tasarrufu.
// ════════════════════════════════════════════════════════════════

/// Ses oynatma durumu.
enum AudioState { idle, loading, playing, paused, error }

/// Ses servisinin durumu — Riverpod ile reaktif.
class AudioPlayerState {
  final AudioState state;
  final Duration position;
  final Duration duration;
  final String? currentAsset;
  final String? errorMessage;

  const AudioPlayerState({
    this.state = AudioState.idle,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.currentAsset,
    this.errorMessage,
  });

  double get progress =>
      duration.inMilliseconds > 0
          ? position.inMilliseconds / duration.inMilliseconds
          : 0.0;

  bool get isPlaying => state == AudioState.playing;
  bool get isLoading => state == AudioState.loading;

  AudioPlayerState copyWith({
    AudioState? state,
    Duration? position,
    Duration? duration,
    String? currentAsset,
    String? errorMessage,
  }) => AudioPlayerState(
    state: state ?? this.state,
    position: position ?? this.position,
    duration: duration ?? this.duration,
    currentAsset: currentAsset ?? this.currentAsset,
    errorMessage: errorMessage,
  );
}

/// Uygulama genelinde ses çalma yöneticisi.
///
/// Hem kelime sesleri hem kültürel içerik (türkü, şiir) için kullanılır.
/// Asset dosyaları `assets/audio/{level}/{word}.mp3` formatında.
class LutkeAudioService extends StateNotifier<AudioPlayerState> {
  final AudioPlayer _player;

  LutkeAudioService()
      : _player = AudioPlayer(),
        super(const AudioPlayerState()) {
    _listenToPlayerState();
  }

  void _listenToPlayerState() {
    _player.playerStateStream.listen((playerState) {
      if (!mounted) return;

      final audioState = switch (playerState.processingState) {
        ProcessingState.loading || ProcessingState.buffering => AudioState.loading,
        ProcessingState.ready => playerState.playing
            ? AudioState.playing
            : AudioState.paused,
        ProcessingState.completed => AudioState.idle,
        ProcessingState.idle => AudioState.idle,
      };

      state = state.copyWith(state: audioState);
    });

    _player.positionStream.listen((position) {
      if (!mounted) return;
      state = state.copyWith(position: position);
    });

    _player.durationStream.listen((duration) {
      if (!mounted) return;
      if (duration != null) {
        state = state.copyWith(duration: duration);
      }
    });
  }

  /// Asset dosyasından ses çal.
  /// Örnek: `assets/audio/a1/silav.mp3`
  Future<void> playAsset(String assetPath) async {
    try {
      state = state.copyWith(
        state: AudioState.loading,
        currentAsset: assetPath,
        errorMessage: null,
      );

      await _player.setAsset(assetPath);
      await _player.play();
    } catch (e) {
      state = state.copyWith(
        state: AudioState.error,
        errorMessage: 'Deng nehate lêdan: $e',
      );
    }
  }

  /// URL'den ses çal (Firebase Storage gibi).
  Future<void> playUrl(String url) async {
    try {
      state = state.copyWith(
        state: AudioState.loading,
        currentAsset: url,
        errorMessage: null,
      );

      await _player.setUrl(url);
      await _player.play();
    } catch (e) {
      state = state.copyWith(
        state: AudioState.error,
        errorMessage: 'Deng nehate lêdan: $e',
      );
    }
  }

  /// Yavaş hızda çal (0.7x) — İlke §7.3
  Future<void> playSlow(String assetPath) async {
    try {
      state = state.copyWith(
        state: AudioState.loading,
        currentAsset: assetPath,
      );
      await _player.setAsset(assetPath);
      await _player.setSpeed(0.7);
      await _player.play();
    } catch (e) {
      state = state.copyWith(
        state: AudioState.error,
        errorMessage: 'Deng nehate lêdan: $e',
      );
    }
  }

  /// Durdur.
  Future<void> pause() async {
    await _player.pause();
  }

  /// Devam ettir.
  Future<void> resume() async {
    await _player.play();
  }

  /// Tamamen durdur ve sıfırla.
  Future<void> stop() async {
    await _player.stop();
    await _player.setSpeed(1.0);
    state = const AudioPlayerState();
  }

  /// Belirli pozisyona git.
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}

// ═══════════════════════════════════════════════���════════════════
// RIVERPOD PROVIDERS
// ════════════════════════════════════════════════════════════════

final audioServiceProvider =
    StateNotifierProvider<LutkeAudioService, AudioPlayerState>((ref) {
  final service = LutkeAudioService();
  ref.onDispose(service.dispose);
  return service;
});
