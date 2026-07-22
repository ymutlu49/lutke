import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/audio_service.dart';

// ════════════════════════════════════════════════════════════════
// GUHDARÎ — PÎLOT (izole değerlendirme ekranı)
//
// Azadiya Welat Kurmancî ses kliplerini gerçek ortamda denemek için.
// Müfredata / dispatcher'a / ExerciseModel'e BAĞLI DEĞİL — sadece
// LutkeAudioService kullanır. Erişim: /listening-pilot
// Klipler: assets/audio/listening/  (kaynak: HF muzaffercky/azadiya-welat...)
//
// Pilot kararı sonrası bu dosya + route + asset'ler tek seferde silinebilir.
// ════════════════════════════════════════════════════════════════

class _PilotClip {
  final String asset;
  final String ku;
  final String tr;
  final double seconds;
  const _PilotClip(this.asset, this.ku, this.tr, this.seconds);
}

const _clips = <_PilotClip>[
  _PilotClip(
    'assets/audio/listening/listening_01.wav',
    'Ziman, amûrê sereke yê jiyanê ye.',
    'Dil, hayatın temel aracıdır.',
    2.2,
  ),
  _PilotClip(
    'assets/audio/listening/listening_02.wav',
    'Hiş, aqil, fikir û raman bi ziman tên bilêvkirin.',
    'Bilinç, akıl, düşünce ve fikirler dille ifade edilir.',
    3.5,
  ),
  _PilotClip(
    'assets/audio/listening/listening_03.wav',
    'Heke ziman tune be, hebûna mirov jî nakokî ye.',
    'Dil yoksa, insanın varlığı da çelişkilidir.',
    2.8,
  ),
];

class ListeningPilotScreen extends ConsumerStatefulWidget {
  const ListeningPilotScreen({super.key});

  @override
  ConsumerState<ListeningPilotScreen> createState() =>
      _ListeningPilotScreenState();
}

class _ListeningPilotScreenState extends ConsumerState<ListeningPilotScreen> {
  final Set<int> _revealed = {};

  @override
  void dispose() {
    // Ekrandan çıkınca çalan sesi durdur.
    try {
      ref.read(audioServiceProvider.notifier).stop();
    } catch (_) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audio = ref.watch(audioServiceProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F0),
      appBar: AppBar(
        title: const Text('Guhdarî — Pîlot'),
        backgroundColor: const Color(0xFF1A7B6B),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Ezmûna deng — Azadiya Welat',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A2A4A),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Guhdarî bike, paşê nivîsê nîşan bide. (Pîlot: 3 klip)',
            style: TextStyle(fontSize: 13, color: Color(0xFF4A5A6A)),
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < _clips.length; i++) _buildCard(i, _clips[i], audio),
          const SizedBox(height: 8),
          const Divider(),
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              'Deng: Azadiya Welat · Berhevkar: muzaffercky (HuggingFace)',
              style: TextStyle(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: Color(0xFF8A93A0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(int i, _PilotClip clip, AudioPlayerState audio) {
    final isThis = audio.currentAsset == clip.asset;
    final isPlaying = isThis && audio.isPlaying;
    final isLoading = isThis && audio.isLoading;
    final revealed = _revealed.contains(i);
    final notifier = ref.read(audioServiceProvider.notifier);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2DED6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFFEAF4F1),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A7B6B),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${clip.seconds.toStringAsFixed(1)} çirke',
                style: const TextStyle(fontSize: 12, color: Color(0xFF8A93A0)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _btn(
                icon: isLoading
                    ? Icons.hourglass_empty_rounded
                    : (isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded),
                label: isPlaying ? 'Rawestîne' : 'Bibihîze',
                color: const Color(0xFF1A7B6B),
                onTap: () =>
                    isPlaying ? notifier.stop() : notifier.playAsset(clip.asset),
              ),
              const SizedBox(width: 10),
              _btn(
                icon: Icons.slow_motion_video_rounded,
                label: 'Hêdî (0.7x)',
                color: const Color(0xFFD4783A),
                onTap: () => notifier.playSlow(clip.asset),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (revealed) ...[
            Text(
              clip.ku,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A2A4A),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              clip.tr,
              style: const TextStyle(fontSize: 13, color: Color(0xFF4A5A6A)),
            ),
          ] else
            TextButton.icon(
              onPressed: () => setState(() => _revealed.add(i)),
              icon: const Icon(Icons.visibility_rounded, size: 18),
              label: const Text('Nivîsê nîşan bide'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF1A7B6B),
              ),
            ),
        ],
      ),
    );
  }

  Widget _btn({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 20),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
