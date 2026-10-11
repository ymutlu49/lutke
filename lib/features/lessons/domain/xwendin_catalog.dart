/// Okuma metinleri kataloğu ("Xwendin") — iyileştirme planı Faz 5.
///
/// Uygulamada yazılmış ama hiçbir ekrandan açılmayan bağlı metinleri tek
/// biçimde toplar:
///
///   - dört karakter hikâyesi (A1–B2), anlama sorularıyla
///   - üç C1–C2 diyaloğu (soruları yok; yalnız okuma)
///
/// Anlama soruları elle yazılmış dersler gibi oynanır: metnin soru dersi
/// `xwendin_<metin kimliği>` kimliğiyle `lessonById` üzerinden bulunur.
/// Okuma ilerlemesi de aynı kimlikle `lessonProgressProvider`da tutulur.
///
/// Saf Dart; Flutter içe aktarmaz.
library;

import '../../cultural_content/domain/character_stories_db.dart';
import 'heritage_c_dialogues.dart' as cd;
import 'lesson_entities.dart';

const String kXwendinOneki = 'xwendin_';

/// Gotar bağlantılarının gösterildiği düzeyler (bkz. gotar_baglanti_db.dart).
const Set<String> kGotarDuzeyleri = {'B2', 'C1', 'C2'};

class XwendinSatiri {
  /// Konuşan kişi; anlatıcı satırında `null`.
  final String? konusan;
  final String ku;
  final String tr;
  const XwendinSatiri({this.konusan, required this.ku, required this.tr});
}

class XwendinMetni {
  final String id;
  final String level; // 'A1' … 'C2'
  final String titleKu;
  final String titleTr;
  final String emoji;
  final String? ozetKu;
  final String? ozetTr;
  final List<XwendinSatiri> satirlar;
  final List<ExerciseModel> sorular;
  final String? kaynak;

  const XwendinMetni({
    required this.id,
    required this.level,
    required this.titleKu,
    required this.titleTr,
    required this.emoji,
    this.ozetKu,
    this.ozetTr,
    required this.satirlar,
    this.sorular = const [],
    this.kaynak,
  });

  /// Soru dersinin ve ilerleme kaydının kimliği.
  String get dersKimligi => '$kXwendinOneki$id';

  /// Metindeki Kurmancî sözcük sayısı (boşlukla ayrılmış).
  int get sozcukSayisi =>
      satirlar.fold(0, (n, s) => n + s.ku.trim().split(RegExp(r'\s+')).length);
}

const List<String> _duzeyAdlari = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

XwendinMetni _hikayeden(CharacterStory h) => XwendinMetni(
      id: h.id,
      level: h.level.name.toUpperCase(),
      titleKu: h.titleKu,
      titleTr: h.titleTr,
      emoji: h.emoji,
      ozetKu: h.synopsisKu,
      ozetTr: h.synopsisTr,
      satirlar: [
        for (final s in h.lines)
          XwendinSatiri(
            konusan: s.speaker == 'Narrator' ? null : s.speaker,
            ku: s.textKu,
            tr: s.textTr,
          ),
      ],
      sorular: [
        for (var i = 0; i < h.questions.length; i++)
          ExerciseModel(
            id: '$kXwendinOneki${h.id}_q${i + 1}',
            type: ExerciseType.multipleChoice,
            kurmanjPrompt: h.questions[i].questionKu,
            turkishPrompt: h.questions[i].questionTr,
            options: h.questions[i].options,
            correctAnswer: h.questions[i].options[h.questions[i].correctIndex],
            correctIndex: h.questions[i].correctIndex,
          ),
      ],
      kaynak: h.source,
    );

XwendinMetni _diyalogdan(cd.HeritageDialogue d) {
  final adlar = {for (final k in d.characters) k.id: k.name};
  return XwendinMetni(
    id: d.id,
    level: _duzeyAdlari[(d.level - 1).clamp(0, 5)],
    titleKu: d.title,
    titleTr: d.turkishTitle,
    emoji: '💬',
    satirlar: [
      for (final s in d.lines)
        XwendinSatiri(konusan: adlar[s.speakerId] ?? s.speakerId, ku: s.kurmanci, tr: s.turkish),
    ],
  );
}

/// Bütün okuma metinleri, düzey sırasıyla.
final List<XwendinMetni> kXwendinMetinleri = [
  for (final h in kCharacterStories) _hikayeden(h),
  for (final d in cd.kHeritageDiyaloglarC) _diyalogdan(d),
]..sort((a, b) => _duzeyAdlari.indexOf(a.level).compareTo(_duzeyAdlari.indexOf(b.level)));

List<XwendinMetni> xwendinForLevel(String level) =>
    [for (final m in kXwendinMetinleri) if (m.level == level.toUpperCase()) m];

XwendinMetni? xwendinById(String id) {
  for (final m in kXwendinMetinleri) {
    if (m.id == id) return m;
  }
  return null;
}

/// `xwendin_story_001` gibi bir kimlikten metnin soru dersi; metin yoksa ya
/// da sorusu yoksa `null`.
LessonModel? xwendinDersi(String dersKimligi) {
  if (!dersKimligi.startsWith(kXwendinOneki)) return null;
  final m = xwendinById(dersKimligi.substring(kXwendinOneki.length));
  if (m == null || m.sorular.isEmpty) return null;
  return LessonModel(
    id: m.dersKimligi,
    kurmanjTitle: m.titleKu,
    turkishTitle: m.titleTr,
    unitNumber: 0,
    lessonNumber: 0,
    level: _duzeyAdlari.indexOf(m.level) + 1,
    path: LessonPath.cultural,
    exercises: m.sorular,
    estimatedMinutes: 2,
    emoji: m.emoji,
  );
}
