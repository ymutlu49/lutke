// İngilizce ses yolu (Ekim 2026): önce hazır dosya (EnSesManifest), yoksa
// cihaz TTS'i. Yönlendirme kararı sahte arka uçla (dikiş) doğrulanır —
// eklenti / ağ / tarayıcı gerekmez.

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:lutke/core/services/en_ses_manifest.dart';
import 'package:lutke/core/services/en_tts_helper.dart';

/// Çağrıları kaydeden sahte arka uç.
class _SahteArkaUc implements EnSesArkaUcu {
  final List<String> kayit = [];

  /// `false` → dosya yüklenemedi (ağ yok / 404) benzetimi.
  bool dosyaYuklenir = true;

  /// Doluysa dosyaCal bu tamamlayıcıyı bekler (yavaş ağ benzetimi).
  Completer<void>? yukleme;

  /// Son dosyaCal'ın yükleme sonrası "hâlâ geçerli mi" yanıtı.
  bool? sonHala;

  @override
  Future<bool> dosyaCal(String url, double hiz, bool Function() hala) async {
    kayit.add('dosya $url @$hiz');
    if (yukleme != null) await yukleme!.future;
    sonHala = hala();
    return dosyaYuklenir;
  }

  @override
  Future<void> dosyaDurdur() async => kayit.add('dosyaDurdur');

  @override
  Future<void> cihazTts(String text, double rate, bool Function() hala) async =>
      kayit.add('tts $text @$rate');

  @override
  Future<void> cihazTtsDurdur() async => kayit.add('ttsDurdur');
}

void main() {
  const taban = 'https://lutke.app/ses/test/';
  const sahteManifest = {'hello': 'ab/hello.mp3', 'good morning': 'cd/gm.mp3'};

  late _SahteArkaUc arka;
  late EnSesArkaUcu eskiArka;
  late String? Function(String) eskiAdres;

  setUp(() {
    eskiArka = EnTtsHelper.arkaUc;
    eskiAdres = EnTtsHelper.sesAdresi;
    arka = _SahteArkaUc();
    EnTtsHelper.arkaUc = arka;
    // Gerçek anahtar kuralı + sahte tablo.
    EnTtsHelper.sesAdresi = (m) {
      final d = sahteManifest[EnSesManifest.anahtar(m)];
      return d == null ? null : '$taban$d';
    };
  });

  tearDown(() {
    EnTtsHelper.arkaUc = eskiArka;
    EnTtsHelper.sesAdresi = eskiAdres;
  });

  group('EnTtsHelper yönlendirme', () {
    test('manifestte olan metin → hazır dosya, TTS çalışmaz', () async {
      await EnTtsHelper.seslendir('Hello!');
      expect(arka.kayit, ['ttsDurdur', 'dosya ${taban}ab/hello.mp3 @1.0']);
      expect(arka.kayit.where((k) => k.startsWith('tts ')), isEmpty);
    });

    test('anahtar kuralı: büyük harf / boşluk / sondaki nokta aynı dosya',
        () async {
      await EnTtsHelper.seslendir('  Good   Morning.  ');
      expect(arka.kayit.last, 'dosya ${taban}cd/gm.mp3 @1.0');
    });

    test('manifestte olmayan metin → cihaz TTS (rate aynen), dosya durur',
        () async {
      await EnTtsHelper.seslendir('Unknown sentence here.', rate: 0.85);
      expect(arka.kayit, [
        'dosyaDurdur',
        'tts Unknown sentence here. @0.85',
      ]);
    });

    test('dosya yüklenemezse cihaz TTS yedeğine düşer', () async {
      arka.dosyaYuklenir = false;
      await EnTtsHelper.seslendir('hello', rate: 0.7);
      expect(arka.kayit, [
        'ttsDurdur',
        'dosya ${taban}ab/hello.mp3 @${EnTtsHelper.oynatmaHizi(0.7)}',
        'tts hello @0.7',
      ]);
    });

    test('yükleme sürerken iptal → çalınmaz, TTS yedeğine de düşmez',
        () async {
      arka.dosyaYuklenir = false; // iptal sonrası hata gelse bile
      arka.yukleme = Completer<void>();
      final is1 = EnTtsHelper.seslendir('hello');
      EnTtsHelper.cancel();
      arka.yukleme!.complete();
      await is1;
      expect(arka.sonHala, isFalse);
      expect(arka.kayit.where((k) => k.startsWith('tts ')), isEmpty);
      expect(arka.kayit, containsAll(['dosyaDurdur', 'ttsDurdur']));
    });

    test('yeni istek eskisini bayatlatır (bayat ses çalmaz)', () async {
      final yavas = Completer<void>();
      arka.dosyaYuklenir = false; // eski istek yedeğe de düşmemeli
      arka.yukleme = yavas;
      final eski = EnTtsHelper.seslendir('hello');
      arka.yukleme = null;
      await EnTtsHelper.seslendir('Something new');
      yavas.complete(); // eski yükleme ŞİMDİ bitiyor
      await eski;
      expect(arka.sonHala, isFalse);
      expect(arka.kayit, contains('tts Something new @1.0'));
      expect(arka.kayit, isNot(contains('tts hello @1.0')));
    });

    test('boş metin hiçbir şey yapmaz', () async {
      await EnTtsHelper.seslendir('   ');
      expect(arka.kayit, isEmpty);
    });

    test('cancel her iki yolu da durdurur', () {
      EnTtsHelper.cancel();
      expect(arka.kayit, ['dosyaDurdur', 'ttsDurdur']);
    });

    test('arka uç hatası dışarı sızmaz, dosya hatası TTS yedeğine düşer',
        () async {
      EnTtsHelper.arkaUc = _PatlayanArkaUc();
      await EnTtsHelper.seslendir('hello');
      await EnTtsHelper.seslendir('not in manifest');
      EnTtsHelper.cancel();
    });
  });

  group('EnTtsHelper.oynatmaHizi', () {
    test('normal hız değişmez', () {
      expect(EnTtsHelper.oynatmaHizi(1.0), 1.0);
    });

    test('yavaş hızlar yavaşlatır ama yumuşatılır, sıralama korunur', () {
      final h06 = EnTtsHelper.oynatmaHizi(0.6);
      final h07 = EnTtsHelper.oynatmaHizi(0.7);
      final h085 = EnTtsHelper.oynatmaHizi(0.85);
      final h09 = EnTtsHelper.oynatmaHizi(0.9);
      expect(h06, closeTo(0.68, 1e-9));
      expect(h085, closeTo(0.88, 1e-9));
      expect(h06 < h07 && h07 < h085 && h085 < h09 && h09 < 1.0, isTrue);
      expect(h06, greaterThan(0.6)); // germe yumuşatıldı
    });

    test('hızlı oran hızlandırır; uç değerler sınırlanır', () {
      expect(EnTtsHelper.oynatmaHizi(1.1), closeTo(1.08, 1e-9));
      expect(EnTtsHelper.oynatmaHizi(0.0), greaterThanOrEqualTo(0.5));
      expect(EnTtsHelper.oynatmaHizi(5.0), lessThanOrEqualTo(2.0));
    });
  });

  group('EnSesManifest', () {
    test('anahtar kuralı SesManifest ile aynı', () {
      expect(EnSesManifest.anahtar('  Hello,   World!? '), 'hello, world');
      expect(EnSesManifest.anahtar('It’s fine.'), "it's fine");
    });

    test('adres tabana bağlanır; olmayan metin null', () {
      expect(EnSesManifest.taban, startsWith('https://lutke.app/ses/'));
      expect(EnSesManifest.url('bu metin hiçbir yerde yok 12345'), isNull);
      for (final e in EnSesManifest.entries.entries.take(3)) {
        expect(EnSesManifest.url(e.key), '${EnSesManifest.taban}${e.value}');
      }
    });
  });
}

/// Her çağrıda hata fırlatan arka uç — helper hatayı yutmalı.
class _PatlayanArkaUc implements EnSesArkaUcu {
  @override
  Future<bool> dosyaCal(String url, double hiz, bool Function() hala) async =>
      throw StateError('ağ yok');
  @override
  Future<void> dosyaDurdur() async => throw StateError('oynatıcı yok');
  @override
  Future<void> cihazTts(String text, double rate, bool Function() hala) async =>
      throw StateError('TTS motoru yok');
  @override
  Future<void> cihazTtsDurdur() async => throw StateError('TTS motoru yok');
}
