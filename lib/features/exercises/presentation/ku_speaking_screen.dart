import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../shared/providers/language_mode_provider.dart';
import '../../../shared/widgets/speak_button.dart';
import '../domain/ku_speaking_db.dart';

/// Kurmancî konuşma/telaffuz ekranı.
/// HuggingFace Kurmancî TTS ile model ses + self-check.
class KuSpeakingScreen extends ConsumerStatefulWidget {
  const KuSpeakingScreen({super.key});
  @override
  ConsumerState<KuSpeakingScreen> createState() => _KuSpeakingScreenState();
}

class _KuSpeakingScreenState extends ConsumerState<KuSpeakingScreen> {
  late List<KuSpeakingExercise> _items;
  int _idx = 0;
  bool _done = false;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _items = List.from(kKuSpeakingExercises)..shuffle(Random());
    _items = _items.take(10).toList();
  }

  void _iDid() => setState(() { _done = true; _score += 10; });

  void _next() {
    if (_idx + 1 >= _items.length) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('🎙️ Temam!'),
          content: Text('$_score XP. Axaftinê her roj meşq bike.'),
          actions: [TextButton(
            onPressed: () { Navigator.pop(context); context.pop(); },
            child: const Text('Derkeve'))],
        ),
      );
      return;
    }
    setState(() { _idx++; _done = false; });
  }

  @override
  Widget build(BuildContext context) {
    final showTr = ref.watch(showTurkishProvider);
    final q = _items[_idx];
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
        title: Row(children: [
          const Text('🗣️', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 8),
          Text('Axaftin', style: AppTypography.headingSmall.copyWith(
            color: AppColors.textPrimary, fontWeight: FontWeight.w800)),
          const Spacer(),
          Text('${_idx+1}/${_items.length}', style: AppTypography.caption),
        ]),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('${q.level} · ${q.type}',
                    style: TextStyle(color: AppColors.primary,
                      fontWeight: FontWeight.w800, fontSize: 11)),
                ),
                const SizedBox(height: 12),
                if (showTr)
                  Text(q.promptTr, style: AppTypography.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 16),
                // Target text card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      AppColors.primary.withValues(alpha: 0.15),
                      AppColors.primary.withValues(alpha: 0.05),
                    ]),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                  ),
                  child: Column(children: [
                    Text(q.textKu,
                      style: AppTypography.title.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary),
                      textAlign: TextAlign.center),
                    const SizedBox(height: 6),
                    Text(q.ipa, style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary, fontStyle: FontStyle.italic)),
                  ]),
                ),
                const SizedBox(height: 12),
                // Speak buttons (HF TTS)
                Center(child: SpeakButton(text: q.textKu, size: 72)),
                const SizedBox(height: 8),
                Center(child: Text('Guhdarî bike (uzun bas = yavaş)',
                  style: AppTypography.caption)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('💡'),
                    const SizedBox(width: 8),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(q.tipKu, style: AppTypography.bodySmall.copyWith(
                          color: const Color(0xFF7B5E00), height: 1.4,
                          fontWeight: FontWeight.w600)),
                        if (showTr) ...[
                          const SizedBox(height: 4),
                          Text(q.tipTr, style: AppTypography.caption.copyWith(
                            color: const Color(0xFF7B5E00), height: 1.4,
                            fontStyle: FontStyle.italic)),
                        ],
                      ],
                    )),
                  ]),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundSecondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(children: [
                    const Icon(Icons.mic, size: 20, color: AppColors.textSecondary),
                    const SizedBox(width: 8),
                    Expanded(child: Text(
                      'Niha tu bibêje. Bi modelê re bide ber hev.',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary, height: 1.4))),
                  ]),
                ),
                const Spacer(),
                Row(children: [
                  Expanded(child: OutlinedButton(
                    onPressed: _next,
                    style: OutlinedButton.styleFrom(minimumSize: const Size(0, 48)),
                    child: const Text('Derbas bike'),
                  )),
                  const SizedBox(width: 8),
                  Expanded(child: ElevatedButton(
                    onPressed: _done ? _next : _iDid,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _done ? Colors.green : AppColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 48)),
                    child: Text(_done ? 'Berdewam' : 'Min got ✓',
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                  )),
                ]),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
