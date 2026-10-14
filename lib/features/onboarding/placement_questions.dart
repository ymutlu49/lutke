import 'dart:math';

import '../lessons/domain/lesson_entities.dart';
import '../lessons/domain/olcme.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Düzey belirleme testinin soruları
//
// Test aşamalıdır (bkz. olcme.dart, "Aşamalı yerleştirme"): bantlar A1'den
// yukarı sırayla sorulur, bant başına [kBantSoruSayisi] soru. Geçilemeyen ilk
// bant başlanacak düzeydir.
//
//   Kurmancî  : elle yazılmış 10 soru (bant başına 2; C1 ve C2'de 1) +
//               kalanlar düzeyin KENDİ içeriğinden üretilir: kelime
//               listesinden örneklenen kelime soruları ve veriden üretilen
//               bir biçim sorusu (izafe / ergatif). Her açılışta yeniden
//               örneklenir. Yeni Kurmancî cümle yazılmaz; her sorunun
//               doğru cevabı veritabanındaki kayıttır.
//   İngilizce : bant başına 6 soruluk elle yazılmış havuzdan her açılışta
//               rastgele [kEnElSayisi] dilbilgisi sorusu + kalanı düzeyin
//               İngilizce kelime listesinden üretilen kelime soruları
//               (seçenekler veritabanındaki Kurmancî karşılıklar). Kurmancî
//               testle aynı yaklaşım (Ekim 2026).
// ════════════════════════════════════════════════════════════════

/// "a1" | "a2" | "b1" | "b2" | "c1" | "c2"
enum PlacementCefr { a1, a2, b1, b2, c1, c2 }

extension PlacementCefrX on PlacementCefr {
  String get label => switch (this) {
        PlacementCefr.a1 => 'A1',
        PlacementCefr.a2 => 'A2',
        PlacementCefr.b1 => 'B1',
        PlacementCefr.b2 => 'B2',
        PlacementCefr.c1 => 'C1',
        PlacementCefr.c2 => 'C2',
      };

  String get code => label.toLowerCase();

  /// Asta navîn şirovekirin — pure Kurmancî (Bedirxan-Hawar).
  String get descKu => switch (this) {
        PlacementCefr.a1 =>
          'Bingehîn: silavên hêsan û naskirina hejmaran. Tu yê ji destpêkê dest pê bikî.',
        PlacementCefr.a2 =>
          'Destpêka pêşketî: hevokên hêsan, dema borî/niha. Pratîka rojane.',
        PlacementCefr.b1 =>
          'Asta navîn: hevokên kompozît, dem-form. Axaftina serbesttir.',
        PlacementCefr.b2 =>
          'Navîn-jor: îdyom, rêzimanên kompleks. Bikaranîna hilbijartî.',
        PlacementCefr.c1 =>
          'Pêşketî: peyvên abstrakt, nivîsên edebî. Asta pîşeyî.',
        PlacementCefr.c2 =>
          'Pispor: nuansên akademîk/edebî, herikbarî temam. Nêzîkî zimanê dayikê.',
      };
}

class PlacementQuestion {
  final String id;
  final String prompt;

  /// Sorunun altındaki yardımcı satır. Üretilen sorularda Türkçe ipucu
  /// ("Türkçesi hangisi?", "Pantolon (benim)"); elle yazılanlarda yok.
  final String? subPrompt;
  final PlacementCefr cefr;
  final List<String> options;
  final int correctIndex;

  /// Cevap anahtarında gösterilen kısa Kurmancî açıklama; boş olabilir.
  final String explanationKu;

  const PlacementQuestion({
    required this.id,
    required this.prompt,
    this.subPrompt,
    required this.cefr,
    required this.options,
    required this.correctIndex,
    this.explanationKu = '',
  });

  /// Düzeyin içeriğinden üretilen soru (kelime ya da biçim).
  factory PlacementQuestion.fromExercise(ExerciseModel e, PlacementCefr cefr) {
    return PlacementQuestion(
      id: e.id,
      prompt: e.kurmanjPrompt,
      subPrompt: e.turkishPrompt,
      cefr: cefr,
      options: e.options,
      correctIndex: e.correctIndex ?? e.options.indexOf(e.correctAnswer),
    );
  }
}

// ── Kurmancî: elle yazılmış sorular (10) ────────────────────────
// Bant başına kalan sorular düzeyin kendi içeriğinden üretilir
// (bkz. buildPlacementQuestions).
// Dağılım: 2×A1 + 2×A2 + 2×B1 + 2×B2 + 1×C1 + 1×C2 = 10
// Tîpolojî (Mayîs 2026): Tev pirs û bersiv bi Kurmancî ne, bê tirkî.
// Bedirxan-Hawar standardîya termînolojî. correctIndex dağılımı dengeli:
// her pozîsyon (0,1,2,3) deqîqayekî ye, biaseyekî tunebe.
const List<PlacementQuestion> kPlacementKuEl = [
  // ─── A1 — Bingehîn (2) ─────────────────────────────────────
  PlacementQuestion(
    id: 'ku-1',
    prompt: '"Silav" kengê tê bikaranîn?',
    cefr: PlacementCefr.a1,
    options: [
      'Dema dîtina kesekî',
      'Dema xwarinê',
      'Dema xewê',
      'Dema xwendinê',
    ],
    correctIndex: 0,
    explanationKu: '"Silav" peyveke silavkirinê ye.',
  ),
  PlacementQuestion(
    id: 'ku-2',
    prompt: 'Kîjan rêz ji endamên malbatê pêk tê?',
    cefr: PlacementCefr.a1,
    options: [
      'sêv, hêjîr, gûz',
      'erd, av, agir',
      'kitêb, qelem, defter',
      'dayik, bav, bira',
    ],
    correctIndex: 3,
    explanationKu: 'Endamên malbatê: dayik, bav, bira, xwişk, ap, met, ...',
  ),
  // ─── A2 — Hevokên hêsan (2) ──────────────────────────────
  PlacementQuestion(
    id: 'ku-3',
    prompt: 'Forma rast: "Ez her roj ___ dibistanê."',
    cefr: PlacementCefr.a2,
    options: [
      'çûm',
      'diçim',
      'biçim',
      'çû',
    ],
    correctIndex: 1,
    explanationKu: 'Dema niha, kesê yekem yekjimar: ez di-ç-im. '
        '"çûm" borî ye, "biçim" subjûnktîv, "çû" kesê sêyem.',
  ),
  PlacementQuestion(
    id: 'ku-4',
    prompt: '"Tu ji ku derê yî?" — bersiva rast kîjan e?',
    cefr: PlacementCefr.a2,
    options: [
      'Ez ji Amedê me',
      'Ez baş im',
      'Ez naxwazim',
      'Ez westiyam',
    ],
    correctIndex: 0,
    explanationKu: '"Ji ku derê" derbarê eslê (cihê ji-derketinê) ye. '
        'Bersiv: "ji [navê cih]ê me".',
  ),
  // ─── B1 — Hevoka komplêks / ergatîvî (2) ─────────────────
  PlacementQuestion(
    id: 'ku-5',
    prompt: '"Min pirtûk xwend" — di vê hevokê de "min" çi ye?',
    cefr: PlacementCefr.b1,
    options: [
      'Bireser',
      'Cihê pêkhatinê',
      'Kirdeya tewandî',
      'Xwedîtî',
    ],
    correctIndex: 2,
    explanationKu: 'Avahiya ergatîv: di lêkerên derbasdar ên dema borî de '
        'kirde tewandî dibe (min, te, wî/wê, me, we, wan). '
        'Loma "min" li vir kirdeya tewandî ye, ne bireser.',
  ),
  PlacementQuestion(
    id: 'ku-6',
    prompt: '"Ger baran bibare, ez ê neyêm" — ev hevok çi nîşan dide?',
    cefr: PlacementCefr.b1,
    options: [
      'Bibîranînek ji dema rabirdûyê',
      'Diyarkirineke gelemperî ya rastiyê',
      'Hewildaneke neguherbar a berdewam',
      'Şertekî pêşerojê û encama neyînî',
    ],
    correctIndex: 3,
    explanationKu: '"Ger ... bibare" = şertê pêşerojê (subjûnktîv). '
        '"Ez ê neyêm" = encama neyînî ya pêşerojê.',
  ),
  // ─── B2 — Gotin / kompoze (2) ───────────────────────────
  PlacementQuestion(
    id: 'ku-7',
    prompt: '"Dilê min geş e" — wateya rast kîjan e?',
    cefr: PlacementCefr.b2,
    options: [
      'Ez xemgîn im',
      'Ez bextiyar im',
      'Ez aciz im',
      'Ez bêhêvî me',
    ],
    correctIndex: 1,
    explanationKu: 'Gotineke îmajîner: "dilê min ronî/geş e" → kêfxweşî.',
  ),
  PlacementQuestion(
    id: 'ku-8',
    prompt: '"Ez ji xewê şiyar bûm" — "ji" di vê hevokê de çi diyar dike?',
    cefr: PlacementCefr.b2,
    options: [
      'Hevkarî',
      'Armanc',
      'Çavkanî',
      'Xwedîtî',
    ],
    correctIndex: 2,
    explanationKu: '"ji" daçeka çavkanî / dûrketinê ye. '
        'Mînak: ji malê derketin, ji xewê şiyar bûn.',
  ),
  // ─── C1 — Abstrakt / edebî (1) ───────────────────────────
  PlacementQuestion(
    id: 'ku-9',
    prompt: '"Civak bêyî ziman namîne; ziman jî bêyî civak namîne." '
        'Wateya giştî ya vê gotinê kîjan e?',
    cefr: PlacementCefr.c1,
    options: [
      'Ziman ji civakê girîngtir e',
      'Ziman û civak bi hev ve girêdayî ne',
      'Civak ziman çêdike',
      'Ziman çarenûsa civakê diyar dike',
    ],
    correctIndex: 1,
    explanationKu: 'Têkiliyeke dualî: ne diyarker e, ne jî yek-jêhatî — '
        'her du jî bi hev re hene yan jî bi hev re ji holê radibin.',
  ),
  // ─── C2 — Pisporî / akademîk (1) ─────────────────────────
  PlacementQuestion(
    id: 'ku-10',
    prompt: '"Zimannasî" kîjan disîplîna akademîk e?',
    cefr: PlacementCefr.c2,
    options: [
      'Lêkolîna edebiyatê',
      'Lêkolîna dîrokê',
      'Lêkolîna felsefeyê',
      'Lêkolîna ziman',
    ],
    correctIndex: 3,
    explanationKu: 'ziman (dil) + -nasî (zanyarî) = lêkolîna sîstema ziman. '
        'Termê standart yê Kurmancî (Bedirxan-Hawar).',
  ),
];

// ── English soru seti (36) ──────────────────────────────────────
// Dağılım: bant başına 6 (A1…C2). İlk 10 soru Mayıs 2026 setidir; 26 soru
// Ekim 2026'da eklendi. Yeni soruların kökleri var olan Kurmancî kalıpları
// aynen kullanır ("Hevoka rast:", "Wateya gotina … çi ye?", …); yeni
// Kurmancî cümle yazılmadı.
// Tîpolojî (Mayîs 2026): Pirsiyar bi Kurmancî ne, bersiv bi îngilîzî ne.
// Hîç peyveke Tirkî tune. Kurmancî zimanê fêrkirinê ye → bikarhêner divê
// dikare bi Kurmancî pirsê fêm bike, û rastiya gramerê/peyvê ya îngilîzî
// hilbijêre.
const List<PlacementQuestion> kPlacementEn = [
  // ─── A1 — Bingehîn (2) ─────────────────────────────────────
  PlacementQuestion(
    id: 'en-1',
    prompt: 'Hevwateya peyva "Hello" çi ye?',
    cefr: PlacementCefr.a1,
    options: ['Hi', 'Goodbye', 'Thanks', 'Sorry'],
    correctIndex: 0,
    explanationKu: '"Hello" û "Hi" her du jî silavên hevwate ne. '
        '"Goodbye" ji bo veqetînê ye.',
  ),
  PlacementQuestion(
    id: 'en-2',
    prompt: 'Hevoka rast: "I ___ a student."',
    cefr: PlacementCefr.a1,
    options: ['be', 'is', 'am', 'are'],
    correctIndex: 2,
    explanationKu: '"To be" bi kesê yekem yekjimar (I) re → "am".',
  ),
  // ─── A2 — Hevokên hêsan (2) ──────────────────────────────
  PlacementQuestion(
    id: 'en-3',
    prompt: 'Forma rast a borî: "Yesterday I ___ to the park."',
    cefr: PlacementCefr.a2,
    options: ['go', 'gone', 'going', 'went'],
    correctIndex: 3,
    explanationKu: 'Borîya hêsan: "go → went". "gone" V3, "going" gerund.',
  ),
  PlacementQuestion(
    id: 'en-4',
    prompt: 'Hevoka rast: "There ___ three apples on the table."',
    cefr: PlacementCefr.a2,
    options: ['be', 'is', 'am', 'are'],
    correctIndex: 3,
    explanationKu: '"There + to be" pirjimar → "are". '
        'Mînak: There is one apple / There are three apples.',
  ),
  // ─── B1 — Gramer navîn (2) ───────────────────────────────
  PlacementQuestion(
    id: 'en-5',
    prompt: 'Forma rast: "I have lived here ___ 2020."',
    cefr: PlacementCefr.b1,
    options: ['for', 'since', 'from', 'at'],
    correctIndex: 1,
    explanationKu: 'Present perfect: "since" + xala destpêkê ya diyar (2020). '
        '"for" + dirêjahiya demê (5 years).',
  ),
  PlacementQuestion(
    id: 'en-6',
    prompt: 'Hevoka rast: "If I had more time, I ___ travel more."',
    cefr: PlacementCefr.b1,
    options: ['will', 'shall', 'would', 'do'],
    correctIndex: 2,
    explanationKu: 'Şertê 2yem (unreal present): if + past simple, '
        'apodosîs: would + bingeh.',
  ),
  // ─── B2 — Gramera bilind / gotin (2) ────────────────────
  PlacementQuestion(
    id: 'en-7',
    prompt: 'Wateya gotina "hit the books" çi ye?',
    cefr: PlacementCefr.b2,
    options: [
      'to sell books',
      'to dislike books',
      'to study hard',
      'to tear pages',
    ],
    correctIndex: 2,
    explanationKu: '"li pirtûkan dan" → dema xwendin/lêkolîna giran.',
  ),
  PlacementQuestion(
    id: 'en-8',
    prompt: 'Hevoka rast: "Had I known earlier, I ___ differently."',
    cefr: PlacementCefr.b2,
    options: [
      'will act',
      'acted',
      'would have acted',
      'would act',
    ],
    correctIndex: 2,
    explanationKu:
        '"Had I known" = inversion of "If I had known" → 3rd conditional. '
        'Apodosîs: would have + V3.',
  ),
  // ─── C1 — Abstrakt / edebî (1) ───────────────────────────
  PlacementQuestion(
    id: 'en-9',
    prompt:
        '"He gave a cursory glance at the document." Wateya "cursory" çi ye?',
    cefr: PlacementCefr.c1,
    options: [
      'quick and superficial',
      'thorough and in-depth',
      'careful and attentive',
      'slow and long-lasting',
    ],
    correctIndex: 0,
    explanationKu: '"cursory" = bilez û ne kûr, bê detay. '
        '"in-depth" û "careful" dijber in.',
  ),
  // ─── C2 — Pisporî / akademîk (1) ─────────────────────────
  PlacementQuestion(
    id: 'en-10',
    prompt:
        '"The committee\'s decision was a fait accompli." Ev gotin çi diyar dike?',
    cefr: PlacementCefr.c2,
    options: [
      'a newly drafted proposal',
      'an openly debated decision',
      'a partial interim result',
      'an irreversible done deal',
    ],
    correctIndex: 3,
    explanationKu: '"fait accompli" (Fransî → îngilîzî) = '
        'kar berê hatiye qedandin, vegera gengaz nîne.',
  ),
  // ─── Ekim 2026: bant başına 6 soruya tamamlayan 26 soru ───────
  PlacementQuestion(
    id: 'en-11',
    prompt: 'Hevoka rast: "She ___ a teacher."',
    cefr: PlacementCefr.a1,
    options: ['am', 'are', 'be', 'is'],
    correctIndex: 3,
  ),
  PlacementQuestion(
    id: 'en-12',
    prompt: 'Hevoka rast: "I have two ___."',
    cefr: PlacementCefr.a1,
    options: ['brothers', 'brother', 'brotheres', "brother's"],
    correctIndex: 0,
  ),
  PlacementQuestion(
    id: 'en-13',
    prompt: 'Hevoka rast: "___ is your name?"',
    cefr: PlacementCefr.a1,
    options: ['Who', 'What', 'Where', 'When'],
    correctIndex: 1,
  ),
  PlacementQuestion(
    id: 'en-14',
    prompt: 'Hevoka rast: "This is ___ apple."',
    cefr: PlacementCefr.a1,
    options: ['a', 'some', 'an', 'two'],
    correctIndex: 2,
  ),
  PlacementQuestion(
    id: 'en-15',
    prompt: 'Hevoka rast: "She ___ like coffee."',
    cefr: PlacementCefr.a2,
    options: ["don't", "doesn't", "isn't", "aren't"],
    correctIndex: 1,
  ),
  PlacementQuestion(
    id: 'en-16',
    prompt: 'Hevoka rast: "My house is ___ than yours."',
    cefr: PlacementCefr.a2,
    options: ['bigger', 'big', 'biggest', 'more big'],
    correctIndex: 0,
  ),
  PlacementQuestion(
    id: 'en-17',
    prompt: 'Hevoka rast: "Look! It ___ now."',
    cefr: PlacementCefr.a2,
    options: ['rains', 'rained', 'is raining', 'rain'],
    correctIndex: 2,
  ),
  PlacementQuestion(
    id: 'en-18',
    prompt: 'Hevoka rast: "We ___ visit our grandmother next week."',
    cefr: PlacementCefr.a2,
    options: ['went to', 'goes to', 'going', 'are going to'],
    correctIndex: 3,
  ),
  PlacementQuestion(
    id: 'en-19',
    prompt: 'Hevoka rast: "This bridge ___ in 1900."',
    cefr: PlacementCefr.b1,
    options: ['built', 'has built', 'was built', 'is building'],
    correctIndex: 2,
  ),
  PlacementQuestion(
    id: 'en-20',
    prompt: 'Hevoka rast: "I ___ TV when the phone rang."',
    cefr: PlacementCefr.b1,
    options: ['was watching', 'watch', 'have watched', 'am watching'],
    correctIndex: 0,
  ),
  PlacementQuestion(
    id: 'en-21',
    prompt: 'Hevoka rast: "She asked me where I ___."',
    cefr: PlacementCefr.b1,
    options: ['do live', 'am living', 'live', 'lived'],
    correctIndex: 3,
  ),
  PlacementQuestion(
    id: 'en-22',
    prompt: 'Hevoka rast: "You ___ smoke here; it is forbidden."',
    cefr: PlacementCefr.b1,
    options: ["don't have to", "mustn't", "needn't", 'might not'],
    correctIndex: 1,
  ),
  PlacementQuestion(
    id: 'en-23',
    prompt: 'Hevoka rast: "I wish I ___ more time last year."',
    cefr: PlacementCefr.b2,
    options: ['have', 'would have', 'had had', 'has'],
    correctIndex: 2,
  ),
  PlacementQuestion(
    id: 'en-24',
    prompt: 'Hevoka rast: "By next June, she ___ her degree."',
    cefr: PlacementCefr.b2,
    options: ['will have finished', 'finishes', 'has finished', 'is finishing'],
    correctIndex: 0,
  ),
  PlacementQuestion(
    id: 'en-25',
    prompt: 'Hevoka rast: "The man ___ car was stolen called the police."',
    cefr: PlacementCefr.b2,
    options: ['who', 'whom', 'which', 'whose'],
    correctIndex: 3,
  ),
  PlacementQuestion(
    id: 'en-26',
    prompt: 'Wateya gotina "once in a blue moon" çi ye?',
    cefr: PlacementCefr.b2,
    options: ['every night', 'very rarely', 'at midnight', 'very quickly'],
    correctIndex: 1,
  ),
  PlacementQuestion(
    id: 'en-27',
    prompt: 'Hevoka rast: "Not only ___ late, but he also forgot the documents."',
    cefr: PlacementCefr.c1,
    options: ['he arrived', 'he did arrive', 'did he arrive', 'arrived he'],
    correctIndex: 2,
  ),
  PlacementQuestion(
    id: 'en-28',
    prompt: '"Her argument was compelling." Wateya "compelling" çi ye?',
    cefr: PlacementCefr.c1,
    options: ['confusing', 'boring', 'aggressive', 'convincing'],
    correctIndex: 3,
  ),
  PlacementQuestion(
    id: 'en-29',
    prompt: 'Hevoka rast: "The new law will come into ___ next month."',
    cefr: PlacementCefr.c1,
    options: ['effect', 'affect', 'result', 'action'],
    correctIndex: 0,
  ),
  PlacementQuestion(
    id: 'en-30',
    prompt: 'Wateya gotina "to beat around the bush" çi ye?',
    cefr: PlacementCefr.c1,
    options: ['to work in the garden', 'to avoid the main point', 'to win easily', 'to hide in a forest'],
    correctIndex: 1,
  ),
  PlacementQuestion(
    id: 'en-31',
    prompt: '"The report was riddled with errors." Wateya "riddled with" çi ye?',
    cefr: PlacementCefr.c1,
    options: ['free of', 'written about', 'full of', 'checked for'],
    correctIndex: 2,
  ),
  PlacementQuestion(
    id: 'en-32',
    prompt: '"His remarks were deliberately obfuscatory." Wateya "obfuscatory" çi ye?',
    cefr: PlacementCefr.c2,
    options: ['meant to praise', 'clearly stated', 'intended to confuse', 'politely apologetic'],
    correctIndex: 2,
  ),
  PlacementQuestion(
    id: 'en-33',
    prompt: 'Hevoka rast: "Little ___ that the decision would change everything."',
    cefr: PlacementCefr.c2,
    options: ['did he know', 'he knew', 'he did know', 'knew he'],
    correctIndex: 0,
  ),
  PlacementQuestion(
    id: 'en-34',
    prompt: '"She has a penchant for understatement." Wateya "penchant" çi ye?',
    cefr: PlacementCefr.c2,
    options: ['a deep fear', 'a strong liking', 'a rare talent', 'a legal right'],
    correctIndex: 1,
  ),
  PlacementQuestion(
    id: 'en-35',
    prompt: 'Wateya gotina "a Pyrrhic victory" çi ye?',
    cefr: PlacementCefr.c2,
    options: ['a quick and easy victory', 'a victory celebrated with fire', 'a victory no one expected', 'a victory won at too great a cost'],
    correctIndex: 3,
  ),
  PlacementQuestion(
    id: 'en-36',
    prompt: '"The findings corroborate the earlier study." Wateya "corroborate" çi ye?',
    cefr: PlacementCefr.c2,
    options: ['contradict', 'summarise', 'confirm', 'replace'],
    correctIndex: 2,
  ),
];

/// İngilizce testte bant başına elle yazılmış (dilbilgisi) soru sayısı;
/// bandın kalanı kelime sorusudur.
const int kEnElSayisi = 3;

/// Testin soruları, bant sırasıyla (A1 → C2), bant başına [kBantSoruSayisi].
/// Bant içi sıra karıştırılır. [rng] verilirse aynı tohum aynı testi üretir.
///
/// Kurmancî: elle yazılmış sorular (bant başına 1–2) + düzeyin içeriğinden
/// üretilenler. İngilizce: elle yazılmış 6'lık havuzdan rastgele
/// [kEnElSayisi] + düzeyin İngilizce kelime listesinden üretilenler; üretim
/// yetmezse havuzun kalanıyla tamamlanır (bant hep 6 soru).
List<PlacementQuestion> buildPlacementQuestions({
  required bool english,
  Random? rng,
}) {
  final r = rng ?? Random();
  final sorular = <PlacementQuestion>[];
  for (final c in PlacementCefr.values) {
    final List<PlacementQuestion> bant;
    if (english) {
      final el = [for (final q in kPlacementEn) if (q.cefr == c) q]..shuffle(r);
      bant = el.take(kEnElSayisi).toList();
      for (final e in enYerlestirmeBandi(c.label, kBantSoruSayisi - bant.length, r)) {
        bant.add(PlacementQuestion.fromExercise(e, c));
      }
      for (final q in el.skip(kEnElSayisi)) {
        if (bant.length >= kBantSoruSayisi) break;
        bant.add(q);
      }
    } else {
      bant = [for (final q in kPlacementKuEl) if (q.cefr == c) q];
      if (bant.length < kBantSoruSayisi) {
        for (final e in yerlestirmeBandi(c.label, kBantSoruSayisi - bant.length, r)) {
          bant.add(PlacementQuestion.fromExercise(e, c));
        }
      }
    }
    bant.shuffle(r);
    sorular.addAll(bant.take(kBantSoruSayisi));
  }
  return sorular;
}
