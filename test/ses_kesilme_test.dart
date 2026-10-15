// "Ses yarıda kesiliyor" hataları (Ekim 2026):
//   1) İngilizce TTS — uzun metin parçalanıp sırayla okunur (chunkText).
//   2) Konuşma kaydı — sürekli kipte gelen segmentler birleştirilir
//      (mergeCandidates); JS betiği sürekli kip + sessizlik bitişi kurar.

import 'package:flutter_test/flutter_test.dart';
import 'package:lutke/core/services/en_tts_helper.dart';
import 'package:lutke/core/services/web_speech_session.dart';

void main() {
  group('EnTtsHelper.chunkText', () {
    test('kısa metin tek parça kalır', () {
      expect(
        EnTtsHelper.chunkText('Hello, how are you?'),
        ['Hello, how are you?'],
      );
    });

    test('boş / yalnız boşluk → parça yok', () {
      expect(EnTtsHelper.chunkText(''), isEmpty);
      expect(EnTtsHelper.chunkText('   \n\n  '), isEmpty);
    });

    test('cümle sonlarından bölünür, boşluklar sadeleşir', () {
      expect(
        EnTtsHelper.chunkText('I like tea.  Do you?\nYes!  "Great." Bye…  ok'),
        ['I like tea.', 'Do you?', 'Yes!', '"Great."', 'Bye…', 'ok'],
      );
    });

    test('ondalık sayı ve kısaltma bölünmez', () {
      expect(
        EnTtsHelper.chunkText('Mr. Smith paid 3.5 dollars. Dr. Lee did too.'),
        ['Mr. Smith paid 3.5 dollars.', 'Dr. Lee did too.'],
      );
      expect(
        EnTtsHelper.chunkText('Bring fruit, e.g. apples. Then go.'),
        ['Bring fruit, e.g. apples.', 'Then go.'],
      );
    });

    test('uzun cümle önce virgülden, sınırı aşmadan bölünür', () {
      final clause = 'the quick brown fox jumps over the lazy dog';
      final sentence = List.filled(6, clause).join(', ');
      final chunks = EnTtsHelper.chunkText(sentence, maxLength: 100);
      expect(chunks.length, greaterThan(1));
      for (final c in chunks) {
        expect(c.length, lessThanOrEqualTo(100));
      }
      // Hiçbir sözcük kaybolmaz / bölünmez.
      expect(chunks.join(' '), sentence);
      // Virgül sınırında bölündü: her parça virgülle ya da cümle sonuyla biter.
      for (final c in chunks.take(chunks.length - 1)) {
        expect(c.endsWith(','), isTrue, reason: c);
      }
    });

    test('noktalamasız çok uzun metin sözcük sınırından bölünür', () {
      final words = List.generate(80, (i) => 'word$i');
      final text = words.join(' ');
      final chunks = EnTtsHelper.chunkText(text, maxLength: 60);
      for (final c in chunks) {
        expect(c.length, lessThanOrEqualTo(60));
        expect(c, isNot(startsWith(' ')));
      }
      expect(chunks.join(' ').split(' '), words);
    });

    test('sınırdan uzun tek "sözcük" sert kesilir ama kaybolmaz', () {
      final url = 'x' * 130;
      final chunks = EnTtsHelper.chunkText('See $url now', maxLength: 50);
      for (final c in chunks) {
        expect(c.length, lessThanOrEqualTo(50));
      }
      expect(chunks.join().replaceAll(' ', ''), 'See${url}now');
    });

    test('okuma parçası gerçekçi pasajda varsayılan sınırı aşmaz', () {
      const passage =
          'Maria lives in a small town near the mountains. Every morning, '
          'she walks to the bakery, buys fresh bread, and talks with her '
          'neighbours about the weather, the market, the school, and the '
          'football match that everyone in the town has been waiting for '
          'since the beginning of the summer holidays.\n\n'
          'In the evening she reads.';
      final chunks = EnTtsHelper.chunkText(passage);
      expect(chunks.first, 'Maria lives in a small town near the mountains.');
      expect(chunks.last, 'In the evening she reads.');
      for (final c in chunks) {
        expect(c.length, lessThanOrEqualTo(EnTtsHelper.defaultMaxChunk));
      }
      expect(chunks.join(' '), passage.replaceAll(RegExp(r'\s+'), ' '));
    });
  });

  group('WebSpeechSession.mergeCandidates', () {
    test('tek segment → tarayıcının alternatif listesi aynen', () {
      expect(
        WebSpeechSession.mergeCandidates([
          ['bav', 'baf', 'bab'],
        ]),
        ['bav', 'baf', 'bab'],
      );
    });

    test('duraksamayla gelen segmentler biriktirilir (kesilmez)', () {
      expect(
        WebSpeechSession.mergeCandidates([
          ['I would like'],
          [' a cup of tea'],
        ]).first,
        'I would like a cup of tea',
      );
    });

    test('birden çok segmentte alternatifler varyant üretir', () {
      final c = WebSpeechSession.mergeCandidates([
        ['ez diçim', 'ez dicim'],
        ['malê', 'male'],
      ]);
      expect(c, [
        'ez diçim malê',
        'ez dicim malê',
        'ez diçim male',
      ]);
    });

    test('Android birikimli sonuçları yinelemez', () {
      expect(
        WebSpeechSession.mergeCandidates([
          ['hello'],
          ['hello how are'],
          ['hello how are you'],
        ]),
        ['hello how are you'],
      );
    });

    test('birebir tekrar segment atılır, boş segment yok sayılır', () {
      expect(
        WebSpeechSession.mergeCandidates([
          ['good morning'],
          [''],
          ['Good morning.'],
          ['teacher'],
        ]).first,
        'good morning teacher',
      );
    });

    test('hiç konuşma yok → aday yok', () {
      expect(WebSpeechSession.mergeCandidates([]), isEmpty);
      expect(
        WebSpeechSession.mergeCandidates([
          ['  '],
        ]),
        isEmpty,
      );
    });

    test('aday sayısı sınırlıdır', () {
      final segs = List.generate(
        5,
        (i) => List.generate(5, (j) => 's${i}a$j'),
      );
      expect(
        WebSpeechSession.mergeCandidates(segs, maxCandidates: 7).length,
        7,
      );
    });
  });

  group('WebSpeechSnapshot', () {
    test('JSON çözülür; metin varsa geç gelen hata yok sayılır', () {
      final snap = WebSpeechSnapshot.fromJson({
        'done': true,
        'error': 'network',
        'segments': [
          {
            'f': true,
            'a': ['ez', 'es'],
          },
          {
            'f': false,
            'a': ['hatim'],
          },
        ],
      });
      final out = snap.toOutcome();
      expect(snap.done, isTrue);
      expect(out.error, isEmpty);
      expect(out.transcript, 'ez hatim');
      expect(out.candidates, contains('es hatim'));
    });

    test('metin yoksa hata korunur', () {
      final out = WebSpeechSnapshot.fromJson({
        'done': true,
        'error': 'not-allowed',
        'segments': [],
      }).toOutcome();
      expect(out.hasSpeech, isFalse);
      expect(out.error, 'not-allowed');
    });
  });

  group('WebSpeechSession.startScript', () {
    final js = WebSpeechSession.startScript(
      key: '_lutkeAsr',
      language: 'tr-TR',
      maxAlternatives: 5,
      silence: const Duration(milliseconds: 1800),
      budget: const Duration(seconds: 15),
    );

    test('sürekli kip + ara sonuçlar açık', () {
      expect(js, contains('r.continuous = true'));
      expect(js, contains('r.interimResults = true'));
      expect(js, isNot(contains('continuous = false')));
    });

    test('window anahtarı ayrı, dil ve süreler gömülü', () {
      expect(js, contains("'_lutkeAsrState'"));
      expect(js, contains('"tr-TR"'));
      expect(js, contains('SILENCE = 1800'));
      expect(js, contains('BUDGET = 15000'));
    });

    test('durdurma/iptal betikleri doğru anahtarı hedefler', () {
      expect(
        WebSpeechSession.stopScript('_lutkeSpeech'),
        contains('window._lutkeSpeechState'),
      );
      expect(
        WebSpeechSession.abortScript('_lutkeAsr'),
        contains('window._lutkeAsrState'),
      );
    });
  });
}
