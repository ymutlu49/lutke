import 'package:flutter_test/flutter_test.dart';
import 'package:lutke/core/services/ses_manifest.dart';

/// Ses fabrikası (Ziman/ses/fabrika/uret.py: anahtar) ile Lütke'nin arama kuralı
/// birebir aynı olmalı; yoksa sesi olan metin sessiz kalır.
void main() {
  group('SesManifest.anahtar', () {
    test('boşluk, büyük harf ve sondaki noktalama sadeleşir', () {
      expect(SesManifest.anahtar('  Aboriya   welatê me baş nîne.  '),
          'aboriya welatê me baş nîne');
      expect(SesManifest.anahtar('Av!?'), 'av');
    });

    test('tipografik kesme işareti düz kesmeye döner', () {
      expect(SesManifest.anahtar('ji ber ’ku’'), "ji ber 'ku'");
    });
  });

  group('SesManifest.url', () {
    test('manifestteki metin sitedeki MP3 adresine çıkar', () {
      final url = SesManifest.url('Aborî');
      expect(url, isNotNull);
      expect(url, startsWith(SesManifest.taban));
      expect(url, endsWith('.mp3'));
    });

    test('noktalama ve büyük harf farkı aynı sese gider', () {
      expect(SesManifest.url('aborî'), SesManifest.url('ABORÎ.'));
    });

    test('manifestte olmayan metin null döner', () {
      expect(SesManifest.url('bu metin hiçbir yerde yok 12345'), isNull);
    });

    test('taban adresi https ve kendi alan adımız', () {
      expect(SesManifest.taban, startsWith('https://lutke.app/ses/'));
      expect(SesManifest.entries.length, greaterThan(10000));
    });
  });
}
