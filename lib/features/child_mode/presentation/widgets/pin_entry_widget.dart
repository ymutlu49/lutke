import 'package:flutter/material.dart';

import '../../../../core/constants/child_theme.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — PIN Giriş Widget'ı
//
// 4 haneli PIN girişi, büyük dairesel butonlarla.
// Ebeveyn kontrol paneline erişim için kullanılır.
// ════════════════════════════════════════════════════════════════

class PinEntryWidget extends StatefulWidget {
  final ValueChanged<String> onComplete;
  final String? errorMessage;

  const PinEntryWidget({
    super.key,
    required this.onComplete,
    this.errorMessage,
  });

  @override
  State<PinEntryWidget> createState() => _PinEntryWidgetState();
}

class _PinEntryWidgetState extends State<PinEntryWidget> {
  String _pin = '';

  void _addDigit(String digit) {
    if (_pin.length >= 4) return;
    setState(() => _pin += digit);
    if (_pin.length == 4) {
      widget.onComplete(_pin);
    }
  }

  void _removeDigit() {
    if (_pin.isEmpty) return;
    setState(() => _pin = _pin.substring(0, _pin.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── PIN gösterimi ───────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (i) {
            final isFilled = i < _pin.length;
            return Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isFilled ? ChildColors.primary : Colors.transparent,
                border: Border.all(
                  color: ChildColors.primary,
                  width: 2,
                ),
              ),
            );
          }),
        ),

        if (widget.errorMessage != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.errorMessage!,
            style: TextStyle(color: ChildColors.encourage, fontSize: 14),
          ),
        ],

        const SizedBox(height: 24),

        // ── Sayı tuşları ────────────────────────────────────
        ...List.generate(3, (row) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (col) {
                final digit = '${row * 3 + col + 1}';
                return _PinButton(
                  label: digit,
                  onTap: () => _addDigit(digit),
                );
              }),
            ),
          );
        }),

        // Son satır: boş, 0, sil
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 72 + 12), // Boş alan
            _PinButton(
              label: '0',
              onTap: () => _addDigit('0'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: SizedBox(
                width: 72,
                height: 72,
                child: IconButton(
                  onPressed: _removeDigit,
                  icon: const Icon(Icons.backspace_rounded, size: 28),
                  color: ChildColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PinButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PinButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: SizedBox(
        width: 72,
        height: 72,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: ChildColors.backgroundTertiary,
            foregroundColor: ChildColors.textPrimary,
            elevation: 0,
            shape: const CircleBorder(),
            padding: EdgeInsets.zero,
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
