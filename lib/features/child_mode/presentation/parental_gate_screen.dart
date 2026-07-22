import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/child_theme.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE ZAROK — VELİ KAPISI (Parental Gate)
//
// Play Store "Designed for Families" + COPPA gereksinimi:
//   • Çocuk modu öncesi VERİFİED PARENTAL CONSENT
//   • Math gate (Google'ın onayladığı yöntem):
//     küçük çocuğun çözemeyeceği ama yetişkinin kolayca çözeceği
//     bir aritmetik soru. Sahte (fake) onay yeterli değildir;
//     gerçek bir kapı olması zorunludur.
//
// Akış:
//   1. Veli kapısı (math soru, 3 deneme hakkı)
//   2. Kullanım onayı (gizlilik kabulü)
//   3. → Child onboarding (yaş seçimi)
//
// Kaynak: developer.android.com/guide/topics/policies/play-families
// ════════════════════════════════════════════════════════════════

class ParentalGateScreen extends StatefulWidget {
  /// Başarılı onaydan sonra ne yapılacak
  final VoidCallback onConsent;

  /// Vazgeçilirse ne yapılacak (genelde önceki ekrana dön)
  final VoidCallback? onCancel;

  const ParentalGateScreen({
    super.key,
    required this.onConsent,
    this.onCancel,
  });

  @override
  State<ParentalGateScreen> createState() => _ParentalGateScreenState();
}

class _ParentalGateScreenState extends State<ParentalGateScreen> {
  late int _a;
  late int _b;
  late int _correctAnswer;
  final _ctrl = TextEditingController();
  int _failCount = 0;
  String? _errorMsg;
  bool _consentChecked = false;
  bool _showConsent = false;
  static const _maxAttempts = 3;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    final rng = Random();
    // 3 basamaklı + 2 basamaklı toplama (örn. 247 + 89 = 336).
    // 7-10 yaş çocuklar zihinden çözemez; bir yetişkin için kolay.
    // COPPA / Play Designed for Families: gate "non-trivial for children".
    // Eski (11+11..99+49) iki basamaklı çok kolaydı — yükseltildi.
    _a = 100 + rng.nextInt(800); // 100..899
    _b = 25 + rng.nextInt(75);   // 25..99
    _correctAnswer = _a + _b;
    _ctrl.clear();
    _errorMsg = null;
    setState(() {});
  }

  void _verify() {
    final input = int.tryParse(_ctrl.text.trim());
    if (input == null) {
      setState(() => _errorMsg = 'Hejmarekê binivîse · Lütfen bir sayı girin');
      return;
    }

    if (input == _correctAnswer) {
      // Doğru — onay ekranına geç
      HapticFeedback.lightImpact();
      setState(() {
        _showConsent = true;
        _errorMsg = null;
      });
    } else {
      _failCount++;
      HapticFeedback.heavyImpact();
      if (_failCount >= _maxAttempts) {
        // 3 yanlış → çocuk modunu engelle
        setState(() {
          _errorMsg = 'Pir bersivên çewt. Ji kerema xwe paşê dîsa biceribîne.\n'
              'Çok fazla yanlış cevap. Lütfen daha sonra tekrar deneyin.';
        });
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) widget.onCancel?.call();
        });
      } else {
        setState(() {
          _errorMsg = 'Çewt. ${_maxAttempts - _failCount} mafê dimînin · '
              'Yanlış. ${_maxAttempts - _failCount} hak kaldı.';
          _generateQuestion();
        });
      }
    }
  }

  Future<void> _giveConsent() async {
    if (!_consentChecked) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('parental_consent_given', true);
    await prefs.setInt(
        'parental_consent_at', DateTime.now().millisecondsSinceEpoch);
    if (mounted) widget.onConsent();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChildColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: ChildColors.backgroundPrimary,
        elevation: 0,
        leading: widget.onCancel != null
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: widget.onCancel,
              )
            : null,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _showConsent ? _buildConsent() : _buildMathGate(),
        ),
      ),
    );
  }

  // ── Aşama 1: Math gate ──────────────────────────────────────────

  Widget _buildMathGate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: ChildColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.lock_outline, color: ChildColors.primary, size: 40),
        ).animate().scale(curve: Curves.elasticOut, duration: 500.ms),
        const SizedBox(height: 16),
        const Text(
          'Kontrola Dê û Bav',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: ChildColors.textPrimary,
          ),
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 4),
        const Text(
          'Veli Kontrolü',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: ChildColors.textSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Ji bo vekirina moda zarokan, erêkirina dê an bavan pêwîst e.\n'
          'Ji kerema xwe pirsa jêrîn bersivîne.\n\n'
          'Çocuk modunu açmak için bir velinin onayı gerekiyor.\n'
          'Lütfen aşağıdaki soruyu cevaplayın.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: ChildColors.textSecondary,
            height: 1.5,
          ),
        ).animate().fadeIn(delay: 300.ms),
        const SizedBox(height: 36),
        // Math soru
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: ChildColors.primary.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                '$_a + $_b = ?',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: ChildColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _ctrl,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                autofocus: true,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  hintText: '?',
                  errorText: _errorMsg,
                ),
                onSubmitted: (_) => _verify(),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
        const SizedBox(height: 24),
        Semantics(
          button: true,
          label: 'Onayla · Erêkirin',
          child: ElevatedButton(
            onPressed: _failCount >= _maxAttempts ? null : _verify,
            style: ElevatedButton.styleFrom(
              backgroundColor: ChildColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Erêkirin · Onayla',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }

  // ── Aşama 2: Veli rıza onayı ───────────────────────────────────

  Widget _buildConsent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_circle_outline,
                color: Colors.green, size: 40),
          ).animate().scale(curve: Curves.elasticOut, duration: 500.ms),
          const SizedBox(height: 16),
          const Text(
            'Erêkirina Dê û Bav · Veli Onayı',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: ChildColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Agahdarî · Çocuk Modu Bilgilendirme',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: ChildColors.textPrimary,
                  ),
                ),
                SizedBox(height: 12),
                _ConsentItem(
                  '✓ Tenê astê temenê (7-10) tê berhevkirin',
                  'Sadece yaş aralığı (7-10) toplanır',
                ),
                _ConsentItem(
                  '✓ Nav, e-peyam, agahiya kesane nayên berhevkirin',
                  'Ad, e-posta, kişisel veri toplanmaz',
                ),
                _ConsentItem(
                  '✓ Reklam nayê nîşandan, şopa kesên sêyem tune',
                  'Reklam gösterilmez, üçüncü taraf izleme yoktur',
                ),
                _ConsentItem(
                  '✓ Dê/bav her dem dikare daneyê jêbirin',
                  'Veli istediği zaman veriyi silebilir',
                ),
                _ConsentItem(
                  '✓ COPPA (ABD) û KVKK (TR) lihevhatî',
                  'COPPA ve KVKK uyumlu',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            value: _consentChecked,
            onChanged: (v) => setState(() => _consentChecked = v ?? false),
            title: const Text(
              'Wek dê/bavê zarokê min, ez bikaranîna Moda Zarokan û '
              'Polîtîkaya Nepenî dixwînim û qebûl dikim.\n'
              'Velisi olduğum çocuk için Çocuk Modu kullanımını ve '
              'Gizlilik Politikasını okuyup onayladığımı kabul ederim.',
              style: TextStyle(fontSize: 12, height: 1.4),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: ChildColors.primary,
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 24),
          Semantics(
            button: true,
            label: 'Berdewam bike · Devam Et',
            child: ElevatedButton(
              onPressed: _consentChecked ? _giveConsent : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: ChildColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                disabledBackgroundColor: Colors.grey.shade300,
              ),
              child: const Text(
                'Berdewam bike · Devam Et',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: widget.onCancel,
            child: const Text(
              'Vegere · Vazgeç',
              style: TextStyle(color: ChildColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConsentItem extends StatelessWidget {
  final String textKu;
  final String textTr;
  const _ConsentItem(this.textKu, this.textTr);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textKu,
            style: const TextStyle(
              fontSize: 12,
              color: ChildColors.textSecondary,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 1),
            child: Text(
              textTr,
              style: TextStyle(
                fontSize: 11,
                color: ChildColors.textSecondary.withOpacity(0.65),
                fontStyle: FontStyle.italic,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Yardımcı: Veli onayı verildi mi? ────────────────────────────

class ParentalConsent {
  static Future<bool> isGiven() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('parental_consent_given') ?? false;
  }

  /// Onayı geri al (ayar değişiklikleri için)
  static Future<void> revoke() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('parental_consent_given');
    await prefs.remove('parental_consent_at');
  }
}
