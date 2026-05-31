// LÛTKE — İçerik dışa aktarma aracı (Dart → JSON)
//
// Tüm kelime DB'lerini (A1–C2, app'in kullandığı aggregator'lar + ID dedup),
// ders tanımlarını (egzersizleriyle) ve heritage diyaloglarını web sitesinin
// tüketebileceği tek bir JSON'a döker — uygulamadaki LessonRepository ile
// aynı kaynak listeleri kullanır, böylece site = app içeriği.
//
// Çalıştırma:  dart run tool/export_content.dart
// Çıktı:       website/data/content.json
//
// Saf Dart (Flutter import etmez): lesson_entities → fsrs_algorithm → dart:math.

import 'dart:convert';
import 'dart:io';

import 'package:lutke/features/lessons/domain/lesson_entities.dart';
// Kelime aggregator'ları (app'in LessonRepository.allWords ile aynı kaynaklar)
import 'package:lutke/features/lessons/domain/a1_kelime_db.dart' show kA1TamListe;
import 'package:lutke/features/lessons/domain/a2_kelime_db.dart' show kA2TamListe;
import 'package:lutke/features/lessons/domain/b1_kelime_db.dart' show kB1Temam;
import 'package:lutke/features/lessons/domain/b2_kelime_db.dart' show kB2All;
import 'package:lutke/features/lessons/domain/c1_kelime_db.dart' show kC1All;
import 'package:lutke/features/lessons/domain/c2_kelime_db.dart'
    show kC2All, kC2_Cegerxwin;
// Ders tanımları
import 'package:lutke/features/lessons/domain/a1_lesson_definitions.dart';
import 'package:lutke/features/lessons/domain/a2_lesson_definitions.dart';
import 'package:lutke/features/lessons/domain/b1_lesson_definitions.dart';
import 'package:lutke/features/lessons/domain/b2_lesson_definitions.dart';
import 'package:lutke/features/lessons/domain/c1_lesson_definitions.dart';
import 'package:lutke/features/lessons/domain/c2_lesson_definitions.dart';
// Diyaloglar — iki dosya AYRI DialogueLine sınıflarına sahip → prefix'li import
import 'package:lutke/features/lessons/domain/heritage_dialogues.dart' as hd;
import 'package:lutke/features/lessons/domain/heritage_c_dialogues.dart' as hc;
// Çand (kültür) — hepsi saf Dart, CulturalItem modeli (cultural_entities.dart)
import 'package:lutke/features/cultural_content/cultural_entities.dart';
import 'package:lutke/features/cultural_content/domain/gotinen_pesiyan_db.dart';
import 'package:lutke/features/cultural_content/domain/dil_motivasyon_db.dart';
import 'package:lutke/features/cultural_content/domain/kurdish_poems_full_db.dart';
import 'package:lutke/features/cultural_content/domain/kurdish_songs_full_db.dart';
import 'package:lutke/features/cultural_content/domain/kurdish_legends_db.dart';
import 'package:lutke/features/cultural_content/domain/kurdish_foods_db.dart';
import 'package:lutke/features/cultural_content/domain/kurdish_historical_figures_db.dart';
import 'package:lutke/features/cultural_content/domain/kurdish_celebrations_db.dart';
import 'package:lutke/features/cultural_content/domain/kurdish_folk_dances_db.dart';
import 'package:lutke/features/cultural_content/domain/kurdish_artists_db.dart';
import 'package:lutke/features/cultural_content/domain/kurdish_architecture_db.dart';
import 'package:lutke/features/cultural_content/domain/kurdish_events_db.dart';

// Kelime record tipi — 6 ana seviye aynı şekli paylaşır.
typedef WordRec = ({
  String id,
  String ku,
  String tr,
  String en,
  String cins,
  String? ez,
  String kat,
  double zor,
  String not,
  List<String> her,
  List<String> gen,
});

String levelFromId(String id) {
  final m = RegExp(r'^([abc][12])_').firstMatch(id.toLowerCase());
  return m != null ? m.group(1)! : 'other';
}

Map<String, dynamic> wordToJson(WordRec w) => {
      'id': w.id,
      'ku': w.ku,
      'tr': w.tr,
      'en': w.en,
      'cins': w.cins,
      'ez': w.ez,
      'kat': w.kat,
      'zor': w.zor,
      'not': w.not,
      'her': w.her,
      'gen': w.gen,
    };

Map<String, dynamic> exerciseToJson(ExerciseModel e) => {
      'id': e.id,
      'type': e.type.name,
      'kurmanjPrompt': e.kurmanjPrompt,
      'turkishPrompt': e.turkishPrompt,
      'options': e.options,
      'correctAnswer': e.correctAnswer,
      'correctIndex': e.correctIndex,
      'grammarNote': e.grammarNote,
      'culturalNote': e.culturalNote,
      'xpReward': e.xpReward,
      'cardId': e.cardId,
      'audioAsset': e.audioAsset,
    };

Map<String, dynamic> lessonToJson(LessonModel l) => {
      'id': l.id,
      'kurmanjTitle': l.kurmanjTitle,
      'turkishTitle': l.turkishTitle,
      'unitNumber': l.unitNumber,
      'lessonNumber': l.lessonNumber,
      'level': l.level,
      'path': l.path.name,
      'estimatedMinutes': l.estimatedMinutes,
      'totalXP': l.totalXP,
      'emoji': l.emoji,
      'culturalRewardId': l.culturalRewardId,
      'targetCardIds': l.targetCardIds,
      'exercises': l.exercises.map(exerciseToJson).toList(),
    };

Map<String, dynamic> dialogueAbToJson(hd.HeritageDialogue d) => {
      'id': d.id,
      'kurmanjTitle': d.kurmanjTitle,
      'turkishTitle': d.turkishTitle,
      'scene': d.scene,
      'culturalContext': d.culturalContext,
      'keyWords': d.keyWords,
      'lessonId': d.lessonId,
      'lines': d.lines
          .map((ln) => {
                'speaker': ln.speaker,
                'speakerRole': ln.speakerRole,
                'kurmanci': ln.kurmanci,
                'turkish': ln.turkish,
                'grammarNote': ln.grammarNote,
                'culturalNote': ln.culturalNote,
              })
          .toList(),
    };

Map<String, dynamic> dialogueCToJson(hc.HeritageDialogue d) {
  // speakerId → görünen ad eşlemesi (karakterlerden)
  final names = <String, String>{
    for (final c in d.characters) c.id: c.name,
  };
  return {
    'id': d.id,
    'kurmanjTitle': d.title,
    'turkishTitle': d.turkishTitle,
    'scene': '',
    'culturalContext': '',
    'keyWords': const <String>[],
    'lessonId': d.lessonId,
    'lines': d.lines
        .map((ln) => {
              'speaker': names[ln.speakerId] ?? ln.speakerId,
              'speakerRole': names[ln.speakerId] ?? ln.speakerId,
              'kurmanci': ln.kurmanci,
              'turkish': ln.turkish,
              'grammarNote': ln.grammarNote,
              'culturalNote': ln.culturalNote,
            })
        .toList(),
  };
}

Map<String, dynamic> culturalRewardToJson(CulturalReward c) => {
      'id': c.id,
      'textKu': c.textKu,
      'textTr': c.textTr,
      'source': c.source,
      'type': c.type.name,
    };

// ── Çand: CulturalItem → JSON ──
Map<String, dynamic> culturalItemToJson(CulturalItem c) => {
      'id': c.id,
      'type': c.type.name,
      'typeLabel': c.typeLabel,
      'typeTurkish': c.typeTurkish,
      'group': groupOf(c.type).name,
      'kurmanjTitle': c.kurmanjTitle,
      'turkishTitle': c.turkishTitle,
      'kurmanjContent': c.kurmanjContent,
      'turkishContent': c.turkishContent,
      'backgroundNote': c.backgroundNote,
      'level': c.level,
      'keywords': c.keywords,
    };

// Grammar topic'i `grammar_tips_screen.dart`'tan regex ile çıkar (saf-Dart değil:
// private sınıf + IconData/Color → import edilemez; metin olarak parse edilir).
List<Map<String, dynamic>> parseGrammarTopics(String projectRoot) {
  final f = File(
      '$projectRoot/lib/features/grammar/grammar_tips_screen.dart');
  if (!f.existsSync()) return [];
  final src = f.readAsStringSync();
  // _grammarTopics = <_GrammarTopic>[ ... ]; bloğunu al
  final blockStart = src.indexOf('const _grammarTopics');
  if (blockStart < 0) return [];
  final open = src.indexOf('[', blockStart);
  // Eşleşen kapanış ']' (basit derinlik sayacı)
  var depth = 0, end = -1;
  for (var i = open; i < src.length; i++) {
    final ch = src[i];
    if (ch == '[') depth++;
    if (ch == ']') {
      depth--;
      if (depth == 0) { end = i; break; }
    }
  }
  if (end < 0) return [];
  final block = src.substring(open, end);

  String? grab(String chunk, String field) {
    // field: '...'  (tek tırnak, kaçış yok varsayımı)
    final m = RegExp("$field:\\s*'((?:[^'\\\\]|\\\\.)*)'").firstMatch(chunk);
    if (m == null) return null;
    return m.group(1)!.replaceAll("\\'", "'").replaceAll('\\n', '\n');
  }

  List<String> grabList(String chunk, String field) {
    final m = RegExp('$field:\\s*\\[').firstMatch(chunk);
    if (m == null) return [];
    final s = m.end - 1;
    var d = 0, e = -1;
    for (var i = s; i < chunk.length; i++) {
      if (chunk[i] == '[') d++;
      if (chunk[i] == ']') { d--; if (d == 0) { e = i; break; } }
    }
    if (e < 0) return [];
    final inner = chunk.substring(s + 1, e);
    return RegExp("'((?:[^'\\\\]|\\\\.)*)'")
        .allMatches(inner)
        .map((x) => x.group(1)!.replaceAll("\\'", "'").replaceAll('\\n', '\n'))
        .toList();
  }

  // Her _GrammarTopic( ... ) girişini ayır
  final topics = <Map<String, dynamic>>[];
  final re = RegExp(r'_GrammarTopic\(');
  final starts = re.allMatches(block).map((m) => m.start).toList();
  for (var i = 0; i < starts.length; i++) {
    final s = starts[i];
    final eTopic = (i + 1 < starts.length) ? starts[i + 1] : block.length;
    final chunk = block.substring(s, eTopic);
    final titleKu = grab(chunk, 'titleKu');
    if (titleKu == null) continue;
    // examples bloğu (örnek ku/tr çiftleri)
    final examples = <Map<String, dynamic>>[];
    final exBlockM = RegExp(r'examples:\s*\[').firstMatch(chunk);
    if (exBlockM != null) {
      var d = 0, exEnd = -1; final es = exBlockM.end - 1;
      for (var j = es; j < chunk.length; j++) {
        if (chunk[j] == '[') d++;
        if (chunk[j] == ']') { d--; if (d == 0) { exEnd = j; break; } }
      }
      if (exEnd > 0) {
        final exInner = chunk.substring(es, exEnd);
        for (final em in RegExp(r'_GrammarExample\(').allMatches(exInner)) {
          final eChunkEnd = exInner.indexOf(')', em.start);
          final eChunk = exInner.substring(
              em.start, eChunkEnd > 0 ? eChunkEnd + 1 : exInner.length);
          final ku = grab(eChunk, 'ku');
          if (ku != null) {
            examples.add({'ku': ku, 'tr': grab(eChunk, 'tr'), 'note': grab(eChunk, 'note')});
          }
        }
      }
    }
    topics.add({
      'titleKu': titleKu,
      'titleTr': grab(chunk, 'titleTr'),
      'level': grab(chunk, 'level') ?? 'A1',
      'rules': grabList(chunk, 'rules'),
      'tip': grab(chunk, 'tip'),
      'examples': examples,
    });
  }
  return topics;
}

void main() {
  // ── Kelimeler: app'in aggregator'larını birleştir, ID'ye göre tekilleştir ──
  final combined = <WordRec>[
    ...kA1TamListe,
    ...kA2TamListe,
    ...kB1Temam,
    ...kB2All,
    ...kC1All,
    ...kC2All,
    ...kC2_Cegerxwin,
  ];
  final seen = <String>{};
  final words = <String, List<Map<String, dynamic>>>{
    'a1': [], 'a2': [], 'b1': [], 'b2': [], 'c1': [], 'c2': [], 'other': [],
  };
  for (final w in combined) {
    if (!seen.add(w.id)) continue; // ilk görüleni tut (app ile aynı)
    final lvl = levelFromId(w.id);
    (words[lvl] ??= []).add(wordToJson(w));
  }
  words.removeWhere((k, v) => v.isEmpty);
  final wordTotal = words.values.fold<int>(0, (s, l) => s + l.length);

  // ── Dersler + egzersizler ──
  final lessons = <String, List<LessonModel>>{
    'a1': kA1Lessons,
    'a2': kA2Lessons,
    'b1': kB1Lessons,
    'b2': kB2Lessons,
    'c1': kC1Lessons,
    'c2': kC2Lessons,
  };
  final lessonsJson = <String, dynamic>{};
  var lessonTotal = 0;
  var exerciseTotal = 0;
  for (final entry in lessons.entries) {
    lessonsJson[entry.key] = entry.value.map(lessonToJson).toList();
    lessonTotal += entry.value.length;
    for (final l in entry.value) {
      exerciseTotal += l.exercises.length;
    }
  }

  // ── Diyaloglar (A1–B1 + C1–C2) ──
  final dialogues = <Map<String, dynamic>>[
    ...hd.kHeritageDiyaloglar.map(dialogueAbToJson),
    ...hc.kHeritageDiyaloglarC.map(dialogueCToJson),
  ];

  // ── Kültürel içerik (atasözü/şiir ödülleri) ──
  final cultural =
      CulturalReward.defaults.values.map(culturalRewardToJson).toList();

  // ── ÇAND (kültür) — kategorilere göre ──
  // CulturalItem koleksiyonları (uygulamadaki Çand sekmesiyle aynı kaynaklar)
  final culturalCollections = <String, List<CulturalItem>>{
    'poems': kKurdishPoemsFullText,
    'songs': kKurdishSongsFullText,
    'legends': kKurdishLegends,
    'foods': kKurdishFoods,
    'figures': kKurdishHistoricalFigures,
    'celebrations': kKurdishCelebrations,
    'dances': kKurdishFolkDances,
    'artists': kKurdishSingers,
    'architecture': kKurdishArchitecture,
    'events': kKurdishEvents,
    'seed': kCulturalItems, // birim-bağlantılı seed (şiir/atasözü/şarkı karışık)
  };
  final seenCultId = <String>{};
  final cand = <String, List<Map<String, dynamic>>>{};
  var candTotal = 0;
  for (final entry in culturalCollections.entries) {
    final list = <Map<String, dynamic>>[];
    for (final item in entry.value) {
      if (!seenCultId.add(item.id)) continue;
      list.add(culturalItemToJson(item));
    }
    if (list.isNotEmpty) { cand[entry.key] = list; candTotal += list.length; }
  }

  // Atasözleri (3361) — kompakt, harfe göre gruplu
  final proverbs = kGotinenPesiyan
      .map((g) => {'letter': g.letter, 'num': g.num, 'ku': g.ku, 'tr': g.tr})
      .toList();

  // Dil/motivasyon sözleri (35)
  final motivation = kDilMotivasyonGotin
      .map((m) => {'ku': m.ku, 'tr': m.tr, 'source': m.source})
      .toList();

  // ── RÊZIMAN (gramer) — 10 konu, ekrandan parse ──
  final grammar = parseGrammarTopics(Directory.current.path);

  final out = <String, dynamic>{
    'meta': {
      'wordTotal': wordTotal,
      'lessonTotal': lessonTotal,
      'exerciseTotal': exerciseTotal,
      'dialogueTotal': dialogues.length,
      'culturalTotal': cultural.length,
      'candTotal': candTotal,
      'proverbTotal': proverbs.length,
      'motivationTotal': motivation.length,
      'grammarTotal': grammar.length,
      'levels': ['a1', 'a2', 'b1', 'b2', 'c1', 'c2'],
      'wordsByLevel': {for (final e in words.entries) e.key: e.value.length},
      'candByGroup': {for (final e in cand.entries) e.key: e.value.length},
    },
    'words': words,
    'lessons': lessonsJson,
    'dialogues': dialogues,
    'cultural': cultural,
    'cand': cand,
    'proverbs': proverbs,
    'motivation': motivation,
    'grammar': grammar,
  };

  final file = File('website/data/content.json');
  file.parent.createSync(recursive: true);
  file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(out));

  stdout.writeln('[export] words=$wordTotal '
      '(${out['meta']['wordsByLevel']}) lessons=$lessonTotal '
      'exercises=$exerciseTotal dialogues=${dialogues.length} '
      'cultural=${cultural.length}');
  stdout.writeln('[export] cand=$candTotal '
      '(${out['meta']['candByGroup']}) proverbs=${proverbs.length} '
      'motivation=${motivation.length} grammar=${grammar.length}');
  stdout.writeln('[export] wrote website/data/content.json '
      '(${(file.lengthSync() / 1024).round()} KB)');
}
