/// LÛTKE — Dinleme Egzersizi Veritabanı (Guhdarî-Bikaranîn)
///
/// Her seviyeye göre TTS ile seslendirilen kısa Kurmancî
/// metinler ve kavrama soruları içerir.
///
/// Model: ListeningExerciseModel
/// Ses kaynağı: HuggingFace amedcj-kmr-tts (runtime).
/// audioAsset null — metin runtime TTS ile okunur.
///
/// Dağılım: A1:25 · A2:25 · B1:20 · B2:15 · C1:10 · C2:10 ≈ 105

// ════════════════════════════════════════════════════════════════
// MODEL
// ════════════════════════════════════════════════════════════════

enum ListeningDifficulty { kolay, normal, zor }

class ListeningExerciseModel {
  final String id;
  final String level;          // A1, A2, B1, B2, C1, C2
  final String audioText;      // TTS ile okunacak Kurmancî metin
  final String question;       // Kavrama sorusu (Kurmancî)
  final String? questionTr;    // Türkçe yardımcı
  final List<String> options;  // 4 seçenek (Kurmancî)
  final int correctIndex;
  final ListeningDifficulty difficulty;
  final String category;       // konu: diyalog, haber, evî, atasözü, edebî
  final String? context;       // opsiyonel arka plan açıklama (Türkçe)

  const ListeningExerciseModel({
    required this.id,
    required this.level,
    required this.audioText,
    required this.question,
    this.questionTr,
    required this.options,
    required this.correctIndex,
    this.difficulty = ListeningDifficulty.normal,
    this.category = 'diyalog',
    this.context,
  });

  String get correctAnswer => options[correctIndex];
}

// ════════════════════════════════════════════════════════════════
// A1 — 25 Exercise (Basit diyalog, selamlaşma, aile, sayı)
// ════════════════════════════════════════════════════════════════

const kListeningA1 = <ListeningExerciseModel>[
  ListeningExerciseModel(
    id: 'ls_a1_001',
    level: 'A1',
    audioText: 'Silav. Navê min Azad e. Tu çawa yî?',
    question: 'Axaftvan navê xwe çi gotiye?',
    questionTr: 'Konuşmacının adı ne?',
    options: ['Baran', 'Zîlan', 'Delal', 'Azad'],
    correctIndex: 3,
    category: 'diyalog',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_002',
    level: 'A1',
    audioText: 'Ez baş im, spas. Tu çawa yî, heval?',
    question: 'Axaftvan çawa ye?',
    questionTr: 'Konuşmacı nasıl?',
    options: ['Baş', 'Westayî', 'Birçî', 'Xemgîn'],
    correctIndex: 0,
    category: 'diyalog',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_003',
    level: 'A1',
    audioText: 'Ev diya min e. Navê wê Gulan e.',
    question: 'Navê diya axaftvan çi ye?',
    questionTr: 'Anne adı nedir?',
    options: ['Gulê', 'Dîlan', 'Gulan', 'Roj'],
    correctIndex: 2,
    category: 'aile',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_004',
    level: 'A1',
    audioText: 'Du bira û sê xwişkên min hene.',
    question: 'Axaftvan çend xwişkên wî/wê hene?',
    questionTr: 'Kaç kız kardeş var?',
    options: ['Yek', 'Du', 'Sê', 'Çar'],
    correctIndex: 2,
    category: 'aile',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_005',
    level: 'A1',
    audioText: 'Ez li Amedê dimînim. Bajarê min xweş e.',
    question: 'Axaftvan li ku dimîne?',
    questionTr: 'Nerede yaşıyor?',
    options: ['Hewlêr', 'Wan', 'Amed', 'Stenbol'],
    correctIndex: 2,
    category: 'şehir',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_006',
    level: 'A1',
    audioText: 'Îro sêşem e. Ez diçim dibistanê.',
    question: 'Îro kîjan roj e?',
    questionTr: 'Bugün hangi gün?',
    options: ['Duşem', 'Çarşem', 'Sêşem', 'Yekşem'],
    correctIndex: 2,
    category: 'dem',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_007',
    level: 'A1',
    audioText: 'Ez nan û av dixwim. Çay jî vedixwim.',
    question: 'Axaftvan çi vedixwe?',
    questionTr: 'Ne içiyor?',
    options: ['Şîr', 'Av', 'Çay', 'Ava pirteqalî'],
    correctIndex: 2,
    category: 'yemek',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_008',
    level: 'A1',
    audioText: 'Mala me mezin e. Sê odeyên me hene.',
    question: 'Çend ode hene?',
    questionTr: 'Kaç oda var?',
    options: ['Du', 'Sê', 'Çar', 'Pênc'],
    correctIndex: 1,
    category: 'ev',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_009',
    level: 'A1',
    audioText: 'Pîra min kek çêdike. Kek xweş e.',
    question: 'Pîra axaftvan çi çêdike?',
    questionTr: 'Büyükanne ne yapıyor?',
    options: ['Nan', 'Kek', 'Şîr', 'Çay'],
    correctIndex: 1,
    category: 'yemek',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_010',
    level: 'A1',
    audioText: 'Roj baş! Navê te çi ye?',
    question: 'Dem çi ye?',
    questionTr: 'Zaman dilimi ne?',
    options: ['Êvar', 'Şev', 'Nîvroj', 'Sibe'],
    correctIndex: 3,
    category: 'selamlaşma',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_011',
    level: 'A1',
    audioText: 'Pisîk li ser masê ye. Kûçik li bin textî ye.',
    question: 'Kûçik li ku ye?',
    questionTr: 'Köpek nerede?',
    options: ['Di odê de', 'Li bin textî', 'Li derve', 'Li ser masê'],
    correctIndex: 1,
    category: 'mekan',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_012',
    level: 'A1',
    audioText: 'Hewa îro sar e. Berf dibare.',
    question: 'Hewa çawa ye?',
    questionTr: 'Hava nasıl?',
    options: ['Sar', 'Ewrî', 'Baranî', 'Germ'],
    correctIndex: 0,
    category: 'hava',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_013',
    level: 'A1',
    audioText: 'Ez xwarinê dixwazim. Ez birçî me.',
    question: 'Axaftvan çawa ye?',
    questionTr: 'Konuşmacı nasıl hissediyor?',
    options: ['Xemgîn', 'Têhnî', 'Şa', 'Birçî'],
    correctIndex: 3,
    category: 'duygu',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_014',
    level: 'A1',
    audioText: 'Ez pirtûkê dixwînim. Pirtûk xweş e.',
    question: 'Axaftvan çi dike?',
    questionTr: 'Ne yapıyor?',
    options: ['Dinivîse', 'Diçe', 'Dixwîne', 'Distirîne'],
    correctIndex: 2,
    category: 'günlük',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_015',
    level: 'A1',
    audioText: 'Birayê min neh salî ye. Xwişka min heft salî ye.',
    question: 'Birayê axaftvan çend salî ye?',
    questionTr: 'Erkek kardeş kaç yaşında?',
    options: ['Heft', 'Heşt', 'Neh', 'Deh'],
    correctIndex: 2,
    category: 'aile',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_016',
    level: 'A1',
    audioText: 'Min sêvek xwar. Sêv sor bû.',
    question: 'Reng çi bû?',
    questionTr: 'Renk neydi?',
    options: ['Zer', 'Kesk', 'Şîn', 'Sor'],
    correctIndex: 3,
    category: 'renk',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_017',
    level: 'A1',
    audioText: 'Ez diçim bazarê. Dixwazim meyweyan bikirim.',
    question: 'Axaftvan li ku diçe?',
    questionTr: 'Nereye gidiyor?',
    options: ['Malê', 'Parkê', 'Bazarê', 'Dibistanê'],
    correctIndex: 2,
    category: 'mekan',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_018',
    level: 'A1',
    audioText: 'Saet şeş e. Ez dereng bûm.',
    question: 'Saet çend e?',
    questionTr: 'Saat kaç?',
    options: ['Pênc', 'Şeş', 'Heft', 'Heşt'],
    correctIndex: 1,
    category: 'dem',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_019',
    level: 'A1',
    audioText: 'Bavê min karmend e. Ew diçe karê xwe.',
    question: 'Bavê axaftvan çi karî dike?',
    questionTr: 'Baba ne iş yapar?',
    options: ['Mamoste', 'Bijîşk', 'Karmend', 'Cotkar'],
    correctIndex: 2,
    category: 'meslek',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_020',
    level: 'A1',
    audioText: 'Ev pirtûka min e. Ew pirtûka te ye.',
    question: 'Kîjan pirtûka axaftvan e?',
    questionTr: 'Hangisi konuşmacının?',
    options: ['Ev', 'Her du', 'Ew', 'Wê'],
    correctIndex: 0,
    category: 'gündelik',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_021',
    level: 'A1',
    audioText: 'Ez ji sêvan hez dikim. Sêv meyweyeke xweş e.',
    question: 'Axaftvan ji çi hez dike?',
    questionTr: 'Neyi seviyor?',
    options: ['Sêvan', 'Tiriyan', 'Mûzan', 'Gûzan'],
    correctIndex: 0,
    category: 'yemek',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_022',
    level: 'A1',
    audioText: 'Xewa te xweş be! Şev baş.',
    question: 'Dem çi ye?',
    questionTr: 'Hangi zaman?',
    options: ['Nîvroj', 'Sibe', 'Êvar', 'Şev'],
    correctIndex: 3,
    category: 'selamlaşma',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_023',
    level: 'A1',
    audioText: 'Dûr nîne, nêzîk e. Tenê deh deqîqe ye.',
    question: 'Cih çawa ye?',
    questionTr: 'Yer nasıl?',
    options: ['Biçûk', 'Hişk', 'Nêzîk', 'Dûr'],
    correctIndex: 2,
    category: 'mekan',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_024',
    level: 'A1',
    audioText: 'Hewa îro xweş e. Ez diçim parkê.',
    question: 'Hewa çawa ye?',
    questionTr: 'Hava nasıl?',
    options: ['Germ', 'Baranî', 'Sar', 'Xweş'],
    correctIndex: 3,
    category: 'hava',
  ),
  ListeningExerciseModel(
    id: 'ls_a1_025',
    level: 'A1',
    audioText: 'Xwişka min stranê dibêje. Ez guhdarî dikim.',
    question: 'Xwişk çi dike?',
    questionTr: 'Kız kardeş ne yapıyor?',
    options: ['Dixwîne', 'Distirîne', 'Dikene', 'Dinivîse'],
    correctIndex: 1,
    category: 'günlük',
  ),
];

// ════════════════════════════════════════════════════════════════
// A2 — 25 Exercise (Genişleyen diyalog, alışveriş, hava, zaman)
// ════════════════════════════════════════════════════════════════

const kListeningA2 = <ListeningExerciseModel>[
  ListeningExerciseModel(
    id: 'ls_a2_001',
    level: 'A2',
    audioText: 'Duh ez çûm bazarê. Min sêv, mûz û nan kirîn.',
    question: 'Axaftvanî duh çi kirîn?',
    questionTr: 'Dün ne satın aldı?',
    options: ['Sêv, mûz û nan', 'Penîr, mast û rûn', 'Şîr, çay û qehwe', 'Tirî, hingiv û şekir'],
    correctIndex: 0,
    category: 'alışveriş',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_002',
    level: 'A2',
    audioText: 'Dema ez biçûk bûm, ez li gund dijiyam. Niha li bajêr dijîm.',
    question: 'Axaftvan niha li ku ye?',
    questionTr: 'Şimdi nerede?',
    options: ['Bajar', 'Gund', 'Çiya', 'Deryayê'],
    correctIndex: 0,
    category: 'biyografi',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_003',
    level: 'A2',
    audioText: 'Sibê dê hewa ewrî be. Dibe ku baran bibare.',
    question: 'Sibê hewa çawa dê be?',
    questionTr: 'Yarın hava nasıl olacak?',
    options: ['Berfî', 'Ewrî', 'Rohnî', 'Germ'],
    correctIndex: 1,
    category: 'hava',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_004',
    level: 'A2',
    audioText: 'Dîlan li zanîngehê dixwîne. Ew dixwaze bibe mamoste.',
    question: 'Dîlan dixwaze çi bibe?',
    questionTr: 'Dîlan ne olmak istiyor?',
    options: ['Endezyar', 'Mamoste', 'Bijîşk', 'Hunermend'],
    correctIndex: 1,
    category: 'meslek',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_005',
    level: 'A2',
    audioText: 'Li ser maseyê penîr, zeytûn û nan hene. Taştê amade ye.',
    question: 'Ev kîjan xwarin e?',
    questionTr: 'Hangi yemek?',
    options: ['Taştê', 'Şîv', 'Paşîv', 'Firavîn'],
    correctIndex: 0,
    category: 'yemek',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_006',
    level: 'A2',
    audioText: 'Ez bi otobûsê diçim dibistanê. Rê nîv saet e.',
    question: 'Axaftvan bi çi diçe dibistanê?',
    questionTr: 'Nasıl gidiyor?',
    options: ['Bi otobûsê', 'Bi erebê', 'Bi bisîkletê', 'Bi peyatî'],
    correctIndex: 0,
    category: 'ulaşım',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_007',
    level: 'A2',
    audioText: 'Hevalê min Baran li Almanyayê dijî. Ew kurdî, tirkî û almanî dizane.',
    question: 'Baran çend zimanan dizane?',
    questionTr: 'Kaç dil biliyor?',
    options: ['Yek', 'Du', 'Sê', 'Çar'],
    correctIndex: 2,
    category: 'biyografi',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_008',
    level: 'A2',
    audioText: 'Dema min wane dixwend, telefona min lê xist.',
    question: 'Dema wanê dixwend çi bû?',
    questionTr: 'Ders çalışırken ne oldu?',
    options: [
      'Tu tişt nebû',
      'Telefon lê xist',
      'Kesek hat',
      'Baran bariya'
    ],
    correctIndex: 1,
    category: 'günlük',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_009',
    level: 'A2',
    audioText: 'Ez difikirim ku ev pirtûk girîng e. Tu çi difikirî?',
    question: 'Axaftvan çi difikire?',
    questionTr: 'Ne düşünüyor?',
    options: [
      'Pirtûk dirêj e',
      'Pirtûk kêm e',
      'Pirtûk girîng e',
      'Pirtûk nexweş e'
    ],
    correctIndex: 2,
    category: 'fikir',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_010',
    level: 'A2',
    audioText: 'Em ê roja şemiyê biçin piknîkê. Tu jî werî?',
    question: 'Kengî dê herin?',
    questionTr: 'Ne zaman?',
    options: ['Sibê', 'Şemî', 'Îro', 'Yekşem'],
    correctIndex: 1,
    category: 'plan',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_011',
    level: 'A2',
    audioText: 'Serê min diêşe. Ez ê herim cem bijîşkî.',
    question: 'Axaftvan ê biçe ku?',
    questionTr: 'Nereye gidecek?',
    options: ['Cem bijîşk', 'Dibistanê', 'Bazarê', 'Malê'],
    correctIndex: 0,
    category: 'sağlık',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_012',
    level: 'A2',
    audioText: 'Ev erebe ji min mezintir e. Erebeya te kîjan e?',
    question: 'Ev erebe çawa ye?',
    questionTr: 'Bu araba nasıl?',
    options: ['Mezintir', 'Biçûktir', 'Nû', 'Kevin'],
    correctIndex: 0,
    category: 'karşılaştırma',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_013',
    level: 'A2',
    audioText: 'Dîroka îro çend e? Min ji bîr kiriye.',
    question: 'Axaftvan çi ji bîr kiriye?',
    questionTr: 'Neyi unuttu?',
    options: ['Rê', 'Nav', 'Saet', 'Dîrok'],
    correctIndex: 3,
    category: 'dem',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_014',
    level: 'A2',
    audioText: 'Wexta min hebe, ez ê pirtûkê bixwînim.',
    question: 'Çi divê hebe?',
    questionTr: 'Ne olmalı?',
    options: ['Wext', 'Pirtûk', 'Heval', 'Pere'],
    correctIndex: 0,
    category: 'şart',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_015',
    level: 'A2',
    audioText: 'Bapîrê min bi kurmancî û erebî diaxive. Ew mamosteyê ziman e.',
    question: 'Bapîrê axaftvan bi çend zimanan diaxive?',
    questionTr: 'Büyükbaba kaç dil biliyor?',
    options: ['Yek', 'Du', 'Sê', 'Çar'],
    correctIndex: 1,
    category: 'aile',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_016',
    level: 'A2',
    audioText: 'Fîlm ne xweş bû. Ez bi temamî westiyam.',
    question: 'Fîlm çawa bû?',
    questionTr: 'Film nasıldı?',
    options: ['Xweş', 'Ne xweş', 'Normal', 'Dirêj'],
    correctIndex: 1,
    category: 'fikir',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_017',
    level: 'A2',
    audioText: 'Divê ez îşev karê xwe biqedînim. Gelek wane hene.',
    question: 'Axaftvan divê çi bike?',
    questionTr: 'Ne yapması lazım?',
    options: ['Karê xwe biqedîne', 'Razê', 'Xew keve', 'Biçe'],
    correctIndex: 0,
    category: 'görev',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_018',
    level: 'A2',
    audioText: 'Bajarê Amedê dîrokî ye. Sûrê wî yê reş gelek kevn e.',
    question: 'Amed bi çi navdar e?',
    questionTr: 'Amed ne ile ünlü?',
    options: [
      'Bi çiyayê',
      'Bi keştiyê',
      'Bi deryayê',
      'Bi sûrê reş'
    ],
    correctIndex: 3,
    category: 'şehir',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_019',
    level: 'A2',
    audioText: 'Ez gelek caran li Stenbolê bûm. Bajarekî mezin e.',
    question: 'Axaftvan çend caran çûye?',
    questionTr: 'Kaç kez gitmiş?',
    options: ['Yek car', 'Qet', 'Gelek caran', 'Çar caran'],
    correctIndex: 2,
    category: 'biyografi',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_020',
    level: 'A2',
    audioText: 'Pîvana piyê min 42 ye. Ev sol ji bo min biçûk in.',
    question: 'Sol çawa ne?',
    questionTr: 'Ayakkabılar nasıl?',
    options: ['Mezin', 'Kevn', 'Biçûk', 'Rast'],
    correctIndex: 2,
    category: 'alışveriş',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_021',
    level: 'A2',
    audioText: 'Dîlan dibêje ku ew dikare bi îngilîzî biaxive.',
    question: 'Dîlan bi kîjan zimanî dizane?',
    questionTr: 'Dîlan hangi dili biliyor?',
    options: ['Îngilîzî', 'Erebî', 'Almanî', 'Fransî'],
    correctIndex: 0,
    category: 'fikir',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_022',
    level: 'A2',
    audioText: 'Dema ez gihîştim malê, pîrik di xew de bû.',
    question: 'Dema hat çi dît?',
    questionTr: 'Geldiğinde ne gördü?',
    options: ['Pîrik distira', 'Pîrik diçû', 'Pîrik dixwar', 'Pîrik di xew de bû'],
    correctIndex: 3,
    category: 'günlük',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_023',
    level: 'A2',
    audioText: 'Pirtûka ku min xwend, derbarê dîroka kurdî bû.',
    question: 'Pirtûk li ser çi bû?',
    questionTr: 'Kitap ne hakkında?',
    options: ['Stran', 'Dîroka kurdî', 'Fenî', 'Aborî'],
    correctIndex: 1,
    category: 'kültür',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_024',
    level: 'A2',
    audioText: 'Ger baran nebariya, em ê biçûna parkê.',
    question: 'Çima neçûn parkê?',
    questionTr: 'Parka neden gitmediler?',
    options: ['Dereng bû', 'Baran bariya', 'Dûr bû', 'Westayî bûn'],
    correctIndex: 1,
    category: 'sebep',
  ),
  ListeningExerciseModel(
    id: 'ls_a2_025',
    level: 'A2',
    audioText: 'Min got ku ez ê sibê bêm. Lê nehatim ji ber ku nexweş bûm.',
    question: 'Çima nehat?',
    questionTr: 'Neden gelmedi?',
    options: ['Neçû', 'Dereng bû', 'Ji bîr kir', 'Nexweş bû'],
    correctIndex: 3,
    category: 'sebep',
  ),
];

// ════════════════════════════════════════════════════════════════
// B1 — 20 Exercise (Hikaye, fikir beyanı, şart)
// ════════════════════════════════════════════════════════════════

const kListeningB1 = <ListeningExerciseModel>[
  ListeningExerciseModel(
    id: 'ls_b1_001',
    level: 'B1',
    audioText: 'Pîrika min ji min re got ku dema ew biçûk bû, çîrokên Mem û Zînê ji bavê xwe bihîstine.',
    question: 'Pîrikê çîrok ji kê bihîstiye?',
    questionTr: 'Büyükanne hikayeyi kimden duymuş?',
    options: ['Ji bavê xwe', 'Ji birayê xwe', 'Ji bavê pîrikê', 'Ji diya xwe'],
    correctIndex: 0,
    category: 'edebiyat',
  ),
  ListeningExerciseModel(
    id: 'ls_b1_002',
    level: 'B1',
    audioText: 'Ger tu werî, em ê bi hev re biçin sînemayê. Ger neyê, ez ê bi tenê biçim.',
    question: 'Gava "tu" neyê, axaftvan ê çi bike?',
    questionTr: 'O gelmezse ne yapacak?',
    options: ['Radikeve', 'Bi tenê diçe', 'Namîne', 'Diçe dibistanê'],
    correctIndex: 1,
    category: 'şart',
    difficulty: ListeningDifficulty.normal,
  ),
  ListeningExerciseModel(
    id: 'ls_b1_003',
    level: 'B1',
    audioText: 'Zimanê min ê dayikê kurmancî ye. Min li dibistanê du zimanên biyanî jî fêr bûne. Niha bi hemûyan dikarim biaxivim.',
    question: 'Axaftvan bi hemûyî çend zimanan dizane?',
    questionTr: 'Kaç dil biliyor? (ana dil + öğrendikleri)',
    options: ['Du', 'Sê', 'Çar', 'Pênc'],
    correctIndex: 1,
    category: 'biyografi',
    context: 'Zimanê dayikê (kurmancî) + 2 zimanên biyanî = 3',
  ),
  ListeningExerciseModel(
    id: 'ls_b1_004',
    level: 'B1',
    audioText: 'Bavê min digot: "Bê ziman, netew dimire." Ji ber vê yekê ez fêrî Kurmancî dibim.',
    question: 'Çima fêrî Kurmancî dibe?',
    questionTr: 'Neden Kurmancî öğreniyor?',
    options: [
      'Ji ber şîreta bav û parastina ziman',
      'Ji bo rêwîtiyê',
      'Ji bo xebatê',
      'Ji bo kêfê'
    ],
    correctIndex: 0,
    category: 'kimlik',
  ),
  ListeningExerciseModel(
    id: 'ls_b1_005',
    level: 'B1',
    audioText: 'Xanî di "Mem û Zîn"ê de nîşan dide ku bêyekîtiya Kurdan sedema bindestiyê ye.',
    question: 'Xanî sedema bindestiyê çi dibîne?',
    questionTr: 'Xanî tutsaklığın sebebini ne görüyor?',
    options: [
      'Bêyekîtî',
      'Kêmbûna pereyan',
      'Kêmasiya xebatê',
      'Hewaya sar'
    ],
    correctIndex: 0,
    category: 'edebiyat',
  ),
  ListeningExerciseModel(
    id: 'ls_b1_006',
    level: 'B1',
    audioText: 'Dema ez ê biçûma bajêr, min biryara xwe guhert. Hewaya sar min qayîl kir ku nemînim.',
    question: 'Çima neçû?',
    questionTr: 'Neden gitmedi?',
    options: ['Saet dereng', 'Hewaya sar', 'Dûr bû', 'Kesek nehat'],
    correctIndex: 1,
    category: 'sebep',
  ),
  ListeningExerciseModel(
    id: 'ls_b1_007',
    level: 'B1',
    audioText: 'Cegerxwîn di sala 1903an de li Hesarê (nêzîkî Batmanê) hat dinyayê. Ew helbestvanekî mezin bû.',
    question: 'Kengî hat dinyayê?',
    questionTr: 'Ne zaman doğdu?',
    options: ['1890', '1903', '1920', '1950'],
    correctIndex: 1,
    category: 'biyografi',
  ),
  ListeningExerciseModel(
    id: 'ls_b1_008',
    level: 'B1',
    audioText: 'Salên dirêj qedexe bû, lê piştî salên 1990î deriyên fêrbûna kurmancî hinek vebûn.',
    question: 'Kengî deriyên fêrbûna kurmancî vebûn?',
    questionTr: 'Kapılar ne zaman açıldı?',
    options: ['1970', '1980', '1990', '2000'],
    correctIndex: 2,
    category: 'tarih',
  ),
  ListeningExerciseModel(
    id: 'ls_b1_009',
    level: 'B1',
    audioText: 'Dibe ku sibê baran bibare. Em ê piknîkê paş bixin.',
    question: 'Piknîk kengî dê be?',
    questionTr: 'Piknik ne zaman olacak?',
    options: ['Îşev', 'Duhe', 'Sibê', 'Paşê'],
    correctIndex: 3,
    category: 'plan',
  ),
  ListeningExerciseModel(
    id: 'ls_b1_010',
    level: 'B1',
    audioText: 'Ez bawer dikim ku perwerde girîngtirîn maf e. Ziman beşek ji vî mafî ye.',
    question: 'Axaftvan perwerdeyê çawa dibîne?',
    questionTr: 'Eğitimi nasıl görüyor?',
    options: ['Ne girîng', 'Bi tenê', 'Girîngtirîn maf', 'Kêm girîng'],
    correctIndex: 2,
    category: 'fikir',
  ),
  ListeningExerciseModel(
    id: 'ls_b1_011',
    level: 'B1',
    audioText: 'Berî ku em werin, pîrikê nan pijandibû. Mala me bi bêhna nên dagirtî bû.',
    question: 'Pîrikê beriya hatinê çi kiribû?',
    questionTr: 'Büyükanne ne yapmıştı?',
    options: ['Nan pijandibû', 'Xwarin çêkiribû', 'Çay çêkiribû', 'Xwe xemilandibû'],
    correctIndex: 0,
    category: 'hikaye',
  ),
  ListeningExerciseModel(
    id: 'ls_b1_012',
    level: 'B1',
    audioText: 'Çîroka Newrozê ji bo Kurdan girîng e. Kawayê Hesinkar zordariya Dehaq hilweşand.',
    question: 'Kî serî rakir?',
    questionTr: 'Kim ayağa kalktı?',
    options: ['Dehak', 'Kawa', 'Cegerxwîn', 'Xanî'],
    correctIndex: 1,
    category: 'kültür',
  ),
  ListeningExerciseModel(
    id: 'ls_b1_013',
    level: 'B1',
    audioText: 'Li gor lêkolînan, Kurmancî ji aliyê 15 heta 20 milyon kesan ve tê axaftin.',
    question: 'Çend mirov Kurmancî diaxivin?',
    questionTr: 'Kurmancî\'yi kaç kişi konuşur?',
    options: ['5-10 milyon', '25-30 milyon', '15-20 milyon', 'Çend sed hezar'],
    correctIndex: 2,
    category: 'fennî',
  ),
  ListeningExerciseModel(
    id: 'ls_b1_014',
    level: 'B1',
    audioText: 'Her çend ku kar zor bû jî, wî dest jê berneda. Di dawiyê de serket.',
    question: 'Wî di dawiyê de çi kir?',
    questionTr: 'Sonunda ne yaptı?',
    options: ['Dev jê berda', 'Revî', 'Serket', 'Hêrs bû'],
    correctIndex: 2,
    category: 'hikaye',
  ),
  ListeningExerciseModel(
    id: 'ls_b1_015',
    level: 'B1',
    audioText: 'Bi baweriya min, divê mirov timî rast bêje. Derew aştiyê wêran dike.',
    question: 'Axaftvan çi dibêje?',
    questionTr: 'Ne söylüyor?',
    options: [
      'Hêrs xweş e',
      'Derew rast e',
      'Mirov divê timî rast bêje',
      'Bêdengî baş e'
    ],
    correctIndex: 2,
    category: 'ahlak',
  ),
  ListeningExerciseModel(
    id: 'ls_b1_016',
    level: 'B1',
    audioText: 'Gundê me dibe bajarokekî nû. Rêyên nû, mal û dibistan tên çêkirin.',
    question: 'Çi diguhere?',
    questionTr: 'Ne değişiyor?',
    options: [
      'Gund dibe bajarok',
      'Gundî diçin',
      'Hewa sar dibe',
      'Gund winda dibe'
    ],
    correctIndex: 0,
    category: 'gelişim',
  ),
  ListeningExerciseModel(
    id: 'ls_b1_017',
    level: 'B1',
    audioText: 'Ez dixwazim fêrî piyanoyê bibim. Ji ber ku mûzîk dilê min hênik dike.',
    question: 'Çima fêrî piyano dibe?',
    questionTr: 'Neden piyano öğreniyor?',
    options: [
      'Ji bo pereyê',
      'Mûzîk dilê wî hênik dike',
      'Hevalan gotin',
      'Ji bo pispor bibe'
    ],
    correctIndex: 1,
    category: 'sebep',
  ),
  ListeningExerciseModel(
    id: 'ls_b1_018',
    level: 'B1',
    audioText: 'Piştî ku min ew dît, min pirsa xwe ji wî kir. Wî bi dilfirehî bersiv da.',
    question: 'Çawa bersiv da?',
    questionTr: 'Nasıl cevap verdi?',
    options: ['Bi bêdengî', 'Bi hêrsê', 'Bi dilfirehî', 'Bi tirsê'],
    correctIndex: 2,
    category: 'hikaye',
  ),
  ListeningExerciseModel(
    id: 'ls_b1_019',
    level: 'B1',
    audioText: 'Yek ji gotinên pêşiyan: "Ziman dermanê dilê mirov e." Ev gotin her roj rast e.',
    question: 'Gotina pêşiyan çi dibêje?',
    questionTr: 'Atasözü ne diyor?',
    options: [
      'Ziman dijminê dil e',
      'Dil bê ziman nîne',
      'Ziman dermanê dilê mirov e',
      'Dil ezîmê mirov e'
    ],
    correctIndex: 2,
    category: 'atasözü',
  ),
  ListeningExerciseModel(
    id: 'ls_b1_020',
    level: 'B1',
    audioText: 'Dema ez li ser vê mijarê difikirim, ez digihêjim encamê ku pêkanîn zehmet e.',
    question: 'Axaftvan gihiştiye kîjan encamê?',
    questionTr: 'Hangi sonuca vardı?',
    options: [
      'Pêkanîn zehmet e',
      'Bêhêz e',
      'Hêsan e',
      'Ne girîng e'
    ],
    correctIndex: 0,
    category: 'akademik',
  ),
];

// ════════════════════════════════════════════════════════════════
// B2 — 15 Exercise (akademik-haber, argüman)
// ════════════════════════════════════════════════════════════════

const kListeningB2 = <ListeningExerciseModel>[
  ListeningExerciseModel(
    id: 'ls_b2_001',
    level: 'B2',
    audioText: 'Di nûçeyê de tê gotin ku Kurmancî di çend welatan de fermî hatiye pejirandin. Ev pêşketineke girîng e.',
    question: 'Nûçe li ser çi ye?',
    questionTr: 'Haber ne hakkında?',
    options: [
      'Pejirandina fermî ya Kurmancî',
      'Aboriya welatan a sala 2024',
      'Festîvalên stranbêjiya gelêrî',
      'Şerê di navbera du dewletan de'
    ],
    correctIndex: 0,
    category: 'nûçe',
    difficulty: ListeningDifficulty.zor,
  ),
  ListeningExerciseModel(
    id: 'ls_b2_002',
    level: 'B2',
    audioText: 'Divê em bala xwe bidin vê rastiyê: perwerdeya bi zimanê dayikê maf e, ne îmtiyaz.',
    question: 'Axaftvan çi diparêze?',
    questionTr: 'Neyi savunuyor?',
    options: [
      'Kêmasiya perwerdeyê',
      'Derewê',
      'Perwerdeya bi zimanê dayikê wekî maf',
      'Îmtiyazê'
    ],
    correctIndex: 2,
    category: 'argüman',
  ),
  ListeningExerciseModel(
    id: 'ls_b2_003',
    level: 'B2',
    audioText: 'Ger hikûmet zimanê hindikahiyan biparêze, nifşên pêşerojê dê ji vê mîrasê sûd werbigirin.',
    question: 'Encam dê çi be?',
    questionTr: 'Sonuç ne olacak?',
    options: [
      'Nifşên pêşerojê dê sûd werbigirin',
      'Tu encam dê nebe',
      'Hikûmet dê neke',
      'Nifş dê winda bibin'
    ],
    correctIndex: 0,
    category: 'argüman',
  ),
  ListeningExerciseModel(
    id: 'ls_b2_004',
    level: 'B2',
    audioText: 'Ev pêvajo tenê bi hevkariya sazî û civakê bi dawî dibe. Bê hevkarî pêk nayê.',
    question: 'Çi pêwîst e?',
    questionTr: 'Ne gerekli?',
    options: ['Hevkarî', 'Tirs', 'Pere', 'Peyva nû'],
    correctIndex: 0,
    category: 'fikir',
  ),
  ListeningExerciseModel(
    id: 'ls_b2_005',
    level: 'B2',
    audioText: 'Ji aliyê zanyaran ve hat piştrastkirin ku zarok dema bi zimanê dayikê fêr dibin, baştir pêş dikevin.',
    question: 'Çi hate piştrastkirin?',
    questionTr: 'Ne kanıtlandı?',
    options: [
      'Perwerde zor e',
      'Di zimanê dayikê de baştir pêşketin',
      'Zarok kêm hîn dibin',
      'Ziman ne girîng e'
    ],
    correctIndex: 1,
    category: 'zanist',
  ),
  ListeningExerciseModel(
    id: 'ls_b2_006',
    level: 'B2',
    audioText: 'Rojnameyeke navdar digot ku berxwedana çandî ji ya siyasî kêmtir ne girîng e.',
    question: 'Li gor rojnameyê berxwedana çandî çawa ye?',
    questionTr: 'Gazete kültürel direnişi nasıl görüyor?',
    options: [
      'Kêm girîng',
      'Bêkêr',
      'Ne lazim',
      'Ji ya siyasî kêmtir ne girîng e'
    ],
    correctIndex: 3,
    category: 'medya',
  ),
  ListeningExerciseModel(
    id: 'ls_b2_007',
    level: 'B2',
    audioText: 'Her çend pirsgirêk zêde bin jî, em ê rê lê bigerin. Veşartina pirsgirêkê ne çareserî ye.',
    question: 'Axaftvan çi pêşniyar dike?',
    questionTr: 'Ne öneriyor?',
    options: [
      'Dev jê berdan',
      'Veşartina pirsgirêkê',
      'Rê lê gerîn',
      'Hêrs bûn li pirsgirêkê'
    ],
    correctIndex: 2,
    category: 'fikir',
  ),
  ListeningExerciseModel(
    id: 'ls_b2_008',
    level: 'B2',
    audioText: 'Di civakê de rola jinan her ku diçe zêdetir dibe. Divê ev pêşketin berdewam be.',
    question: 'Çi diguhere?',
    questionTr: 'Ne değişiyor?',
    options: [
      'Hewaya bajêr',
      'Rêyên nû',
      'Aboriya gundan',
      'Rola jinan'
    ],
    correctIndex: 3,
    category: 'civak',
  ),
  ListeningExerciseModel(
    id: 'ls_b2_009',
    level: 'B2',
    audioText: 'Lêkolîneran nîşan da ku guhertina avhewayê bandorê li cotkariyê dike. Berhem kêm dibin.',
    question: 'Guhertin li ser çi bandor dike?',
    questionTr: 'Değişim neyi etkiliyor?',
    options: ['Huner', 'Mûzîk', 'Wêne', 'Cotkarî'],
    correctIndex: 3,
    category: 'ekoloji',
  ),
  ListeningExerciseModel(
    id: 'ls_b2_010',
    level: 'B2',
    audioText: 'Li gor peymana navneteweyî, divê mafê xwendinê bi zimanê dayikê were parastin.',
    question: 'Peyman çi pêşniyar dike?',
    questionTr: 'Anlaşma neyi öneriyor?',
    options: [
      'Parastina mafê xwendinê',
      'Qedexekirina zimên',
      'Windakirina çandê',
      'Bêkêrî'
    ],
    correctIndex: 0,
    category: 'hukuk',
  ),
  ListeningExerciseModel(
    id: 'ls_b2_011',
    level: 'B2',
    audioText: 'Li gor îstatîstîkan, rêjeya xwendinê di salên dawî de zêde bûye. Ev nîşana pêşketinê ye.',
    question: 'Çi bûye?',
    questionTr: 'Ne olmuş?',
    options: [
      'Xwendin kêm bû',
      'Dibistan hate girtin',
      'Rêjeya xwendinê zêde bû',
      'Kitêb winda bûn'
    ],
    correctIndex: 2,
    category: 'fennî',
  ),
  ListeningExerciseModel(
    id: 'ls_b2_012',
    level: 'B2',
    audioText: 'Digel pirsgirêkên aborî, çalakiya çandî bi hêz berdewam dike. Ev nîşana hêviyê ye.',
    question: 'Digel pirsgirêkê, çi berdewam dike?',
    questionTr: 'Sorunlara rağmen ne devam ediyor?',
    options: [
      'Bêhêziya civakê li hember pirsgirêkan',
      'Veguhastina aboriya welêt',
      'Şerê navxweyî di navbera komên cuda de',
      'Çalakiya çandî'
    ],
    correctIndex: 3,
    category: 'çand',
  ),
  ListeningExerciseModel(
    id: 'ls_b2_013',
    level: 'B2',
    audioText: 'Di raporê de hate diyarkirin ku cihêrengiya zimanan serwetek e, ne pirsgirêk.',
    question: 'Cihêrengiya zimanan çawa tê dîtin?',
    questionTr: 'Dil çeşitliliği nasıl görülüyor?',
    options: [
      'Zehmet',
      'Bêkêr',
      'Pirsgirêk',
      'Serwetek'
    ],
    correctIndex: 3,
    category: 'ziman',
  ),
  ListeningExerciseModel(
    id: 'ls_b2_014',
    level: 'B2',
    audioText: 'Divê em bizanibin ku hemû ziman wekhev in. Tu ziman ji yekî din bilindtir nîne.',
    question: 'Axaftvan çi dibêje?',
    questionTr: 'Ne söylüyor?',
    options: [
      'Îngilîzî kêmtir e',
      'Ziman cuda ne',
      'Hemû ziman wekhev in',
      'Tirkî bilindtir e'
    ],
    correctIndex: 2,
    category: 'ahlak',
  ),
  ListeningExerciseModel(
    id: 'ls_b2_015',
    level: 'B2',
    audioText: 'Em ji vê lêkolînê fêm dikin ku mirov dikare bi hêsanî zimanekî nû fêr bibe.',
    question: 'Lêkolîn çi nîşan dide?',
    questionTr: 'Araştırma ne gösteriyor?',
    options: [
      'Ziman bi dem naye',
      'Ziman hîn jî zehmet e',
      'Bi hêsanî mirov fêr dibe',
      'Ziman bêkêr e'
    ],
    correctIndex: 2,
    category: 'zanist',
  ),
];

// ════════════════════════════════════════════════════════════════
// C1 — 10 Exercise (akademik, edebiyat analizi)
// ════════════════════════════════════════════════════════════════

const kListeningC1 = <ListeningExerciseModel>[
  ListeningExerciseModel(
    id: 'ls_c1_001',
    level: 'C1',
    audioText: 'Di "Mem û Zîn"ê de Xanî bi hişmendî nîşan dide ku bêyekîtî û nebûna dewleta serbixwe, sedemên sereke yên bindestiya Kurdan in.',
    question: 'Xanî kîjan du sedeman diyar dike?',
    questionTr: 'Xanî hangi iki nedeni belirtiyor?',
    options: [
      'Bêyekîtî û nebûna dewletê',
      'Hewa û ziman',
      'Aborî û dîrok',
      'Bîr û bav'
    ],
    correctIndex: 0,
    category: 'edebî',
    difficulty: ListeningDifficulty.zor,
  ),
  ListeningExerciseModel(
    id: 'ls_c1_002',
    level: 'C1',
    audioText: 'Têgeha "postkolonyalîzm" li ser encamên dûrdirêj ên kolonyalîzmê disekine, bi taybetî di warên ziman, çand û desthilatê de.',
    question: 'Postkolonyalîzm li ser çi disekine?',
    questionTr: 'Postkolonyalizm neye odaklanır?',
    options: [
      'Tenê dîrok',
      'Huner',
      'Encamên dûrdirêj: ziman, çand, desthilat',
      'Aborî'
    ],
    correctIndex: 2,
    category: 'akademik',
  ),
  ListeningExerciseModel(
    id: 'ls_c1_003',
    level: 'C1',
    audioText: 'Cegerxwîn bi helbestên xwe mîrateya edebî ya serdema nûjen ava kir. Wî bi zimanekî sade xwestiye xwe bigihîne gel.',
    question: 'Çima zimanê sade bi kar anî?',
    questionTr: 'Neden sade dil kullandı?',
    options: [
      'Ji bo gihîştina gel',
      'Ji bo elîtan',
      'Bêsedem',
      'Ji bo navdariyê'
    ],
    correctIndex: 0,
    category: 'edebî',
  ),
  ListeningExerciseModel(
    id: 'ls_c1_004',
    level: 'C1',
    audioText: 'Li gor Foucault, "zanîn" û "desthilat" bi hev ve girêdayî ne. Kî zanînê dihilberîne, ew desthilatê jî bi dest dixe.',
    question: 'Di ramana Foucault de çi girîng e?',
    questionTr: 'Foucault\'ta ne önemli?',
    options: [
      'Tenê dîrok',
      'Huner',
      'Girêdana zanîn-desthilat',
      'Aborî'
    ],
    correctIndex: 2,
    category: 'felsefe',
  ),
  ListeningExerciseModel(
    id: 'ls_c1_005',
    level: 'C1',
    audioText: 'Demokrasiya nûjen li ser sê stûnan rawestiyaye: veqetandina desthilatê, civaka sivîl û hilbijartinên zelal.',
    question: 'Demokrasiya nûjen çend stûnên wê hene?',
    questionTr: 'Modern demokrasinin kaç sütunu var?',
    options: ['Du', 'Sê', 'Çar', 'Pênc'],
    correctIndex: 1,
    category: 'siyaset',
  ),
  ListeningExerciseModel(
    id: 'ls_c1_006',
    level: 'C1',
    audioText: 'Pergala ergatîf di Kurmancî de taybetmendiyek e ku di zimannasiyê de bal dikişîne. Di dema borî ya lêkerên gerguhêz de kirde di rewşa tewangê de ye.',
    question: 'Di ergatîfê de kirde di kîjan rewşê de ye?',
    questionTr: 'Ergatifte özne hangi halde?',
    options: ['Xwerû', 'Tewang', 'Çemandî', 'Pirsyar'],
    correctIndex: 1,
    category: 'rêziman',
  ),
  ListeningExerciseModel(
    id: 'ls_c1_007',
    level: 'C1',
    audioText: 'Feqiyê Teyran di destana "Şêxê Sen\'an"ê de têgeha "fena" – winda bûna xwe di evînê de – bi awayekî şîrîn vedibêje.',
    question: 'Feqiyê Teyran kîjan têgehê vedibêje?',
    questionTr: 'Hangi kavramı anlatıyor?',
    options: ['Zanist', 'Fena', 'Aborî', 'Şer'],
    correctIndex: 1,
    category: 'edebî',
  ),
  ListeningExerciseModel(
    id: 'ls_c1_008',
    level: 'C1',
    audioText: 'Divê em bala xwe bidin rexneya Edward Said a ku dibêje dîskura rojavayî Rojhilatê wekî "dîtir/din" (other) ava dike.',
    question: 'Said rexneyê li kîjan dîskurê digire?',
    questionTr: 'Said hangi söylemi eleştiriyor?',
    options: [
      'Dîskura Rojhilatî',
      'Dîskura Erebî',
      'Dîskura rojavayî ya li ser Rojhilatê',
      'Dîskura Amerîkî'
    ],
    correctIndex: 2,
    category: 'postkolonyal',
  ),
  ListeningExerciseModel(
    id: 'ls_c1_009',
    level: 'C1',
    audioText: 'Li gor têgeha Benedict Anderson, netew "civakeke xeyalî" ye ku bi rêya ziman, çap û çandê ava dibe.',
    question: 'Anderson netewê çawa pênase dike?',
    questionTr: 'Anderson ulusu nasıl tanımlar?',
    options: [
      'Dîrokek tenê',
      'Aboriyeke hevpar',
      'Saziyek leşkerî',
      'Civakeke xeyalî'
    ],
    correctIndex: 3,
    category: 'akademik',
  ),
  ListeningExerciseModel(
    id: 'ls_c1_010',
    level: 'C1',
    audioText: 'Peymana Neteweyên Yekbûyî, zimên wekî beşek ji mafên bingehîn ên mirovan pejirandiye.',
    question: 'Ziman çi tê hesibandin?',
    questionTr: 'Dil ne kabul ediliyor?',
    options: [
      'Bêwate',
      'Kar',
      'Îmtiyazek',
      'Mafekî bingehîn'
    ],
    correctIndex: 3,
    category: 'hukuk',
  ),
];

// ════════════════════════════════════════════════════════════════
// C2 — 10 Exercise (edebî analiz, felsefî)
// ════════════════════════════════════════════════════════════════

const kListeningC2 = <ListeningExerciseModel>[
  ListeningExerciseModel(
    id: 'ls_c2_001',
    level: 'C2',
    audioText: 'Cegerxwîn di helbesta "Kî me ez?" de bi pirsên retorîkî lêgerîneke hişmendane ya nasnameyê pêşkêş dike û bi vê yekê di heman demê de rexneyê li jibîrkirina civakî digire.',
    question: 'Helbesta "Kî me ez?" çi dike?',
    questionTr: 'Şiir ne yapıyor?',
    options: [
      'Pesnê şer dide',
      'Tenê stran e',
      'Lêgerîna nasnameyê + rexne li jibîrkirinê',
      'Behsa aboriyê dike'
    ],
    correctIndex: 2,
    category: 'edebî',
    difficulty: ListeningDifficulty.zor,
  ),
  ListeningExerciseModel(
    id: 'ls_c2_002',
    level: 'C2',
    audioText: 'Baudrillard bi têgeha "hîperrastî" nîşan dide ku di serdema medyaya mezin de, simulasyon cihê rastiyê digire û cudahî kêm dibe.',
    question: 'Hîperrastî çi ye?',
    questionTr: 'Hiperrealite nedir?',
    options: [
      'Tu rastî nîne',
      'Rastiyeke teknîkî',
      'Simulasyon cihê rastiyê digire',
      'Rastiyeke bilindtir'
    ],
    correctIndex: 2,
    category: 'felsefî',
  ),
  ListeningExerciseModel(
    id: 'ls_c2_003',
    level: 'C2',
    audioText: 'Dema mirov li fonolojiya Kurmancî dinêre, dibîne ku dengên wekî "ç, ş, x, q" di pergala dengsazî ya Kurmancî de xwedî rol in û ji aliyê tîpan ve nîşaneyên wê ne.',
    question: 'Çi taybetmendiya Kurmancî ye?',
    questionTr: 'Kurmancî özelliği ne?',
    options: [
      'Tenê dengên erebî',
      'Tenê dengên Latîn',
      'Dengên ç, ş, x, q yên taybet',
      'Tu dengekî nîne'
    ],
    correctIndex: 2,
    category: 'dengnasî',
  ),
  ListeningExerciseModel(
    id: 'ls_c2_004',
    level: 'C2',
    audioText: 'Derbarê standardkirina Kurmancî de, divê cihêrengiya zaraveyan neyê paşguhkirin, belê modeleke federatîf a zaraveyî were pêşniyarkirin.',
    question: 'Kîjan model tê pêşniyarkirin?',
    questionTr: 'Hangi model öneriliyor?',
    options: [
      'Yek-zaraveyî',
      'Modela federatîf a zaraveyan',
      'Tenê Behdînî',
      'Bê-standard'
    ],
    correctIndex: 1,
    category: 'ziman',
  ),
  ListeningExerciseModel(
    id: 'ls_c2_005',
    level: 'C2',
    audioText: 'Helbestên Melayê Cizîrî bi sembolên tesewufî wek "yar, dilber, şem\'" evîneke îlahî temsîl dikin, ku di edebiyata klasîk de rêya sofîtiyê ye.',
    question: 'Sembolîzma Cizîrî li ser çi ye?',
    questionTr: 'Cizîrî sembolizmi ne hakkında?',
    options: [
      'Evîneke îlahî ya tesewufî',
      'Evîna maddî',
      'Aborî',
      'Şer'
    ],
    correctIndex: 0,
    category: 'edebî',
  ),
  ListeningExerciseModel(
    id: 'ls_c2_006',
    level: 'C2',
    audioText: 'Gayatri Spivak di gotara "Can the Subaltern Speak?" de dibêje ku dengên marjînalîzekirî di dîskura desthilatê de nayên bihîstin.',
    question: 'Spivak li ser kê diaxive?',
    questionTr: 'Spivak kimden bahsediyor?',
    options: [
      'Koma bêdengkirî (subaltern)',
      'Hikûmetê',
      'Rêxistinên mezin',
      'Artêşê'
    ],
    correctIndex: 0,
    category: 'postkolonyal',
  ),
  ListeningExerciseModel(
    id: 'ls_c2_007',
    level: 'C2',
    audioText: 'Dengbêjî ji bo civaka Kurd ne tenê huner e, lê arşîveke devkî ya dîrok, ziman û nirxan e. Dibêjin: "Dengbêjî bîra gel e."',
    question: 'Dengbêjî çi fonksiyonê digire?',
    questionTr: 'Dengbêjlik ne işlev görür?',
    options: [
      'Tenê lîstikek e',
      'Karê aborî ye',
      'Tenê şahî ye',
      'Arşîveke devkî ya dîrok û nirxan e'
    ],
    correctIndex: 3,
    category: 'çand',
  ),
  ListeningExerciseModel(
    id: 'ls_c2_008',
    level: 'C2',
    audioText: 'Nêrîna Herder-Fichte ya ku netewe ji ziman û koka etnîkî ava dibe, îro ji aliyê gelek nêrînên konstruktîvîst ve tê rexnekirin.',
    question: 'Çi tê rexnekirin?',
    questionTr: 'Ne eleştiriliyor?',
    options: [
      'Nêrîna Herder-Fichte ya etno-zimanî',
      'Modela Anderson',
      'Aborî',
      'Postmodernîzm'
    ],
    correctIndex: 0,
    category: 'felsefî',
  ),
  ListeningExerciseModel(
    id: 'ls_c2_009',
    level: 'C2',
    audioText: 'Têgeha "fena" di tesewufê de bi wateya winda bûna xwe di evîna îlahî de tê. Şêxê Sen\'an nimûneyeke wê pêk tîne.',
    question: '"Fena" çi tê wateyê?',
    questionTr: '"Fena" ne anlama gelir?',
    options: [
      'Navdarî',
      'Winda bûna xwe di evîna îlahî de',
      'Dewlemendî',
      'Pêşketin'
    ],
    correctIndex: 1,
    category: 'tesewuf',
  ),
  ListeningExerciseModel(
    id: 'ls_c2_010',
    level: 'C2',
    audioText: 'Di teza doktorayê de divê pirs zelal, rêbaz şefaf û encam orîjînal bin. Bêyî van, xebat nagihêje asta akademîk.',
    question: 'Çend pêwîstî divê hebin?',
    questionTr: 'Kaç gereklilik var?',
    options: ['Du', 'Sê', 'Çar', 'Pênc'],
    correctIndex: 1,
    category: 'akademik',
  ),
];

// ════════════════════════════════════════════════════════════════
// Global aggregator
// ════════════════════════════════════════════════════════════════

const kListeningAll = <ListeningExerciseModel>[
  ...kListeningA1,
  ...kListeningA2,
  ...kListeningB1,
  ...kListeningB2,
  ...kListeningC1,
  ...kListeningC2,
];

/// Seviye filtresiyle exercise döndürür. `level=null` tümünü verir.
List<ListeningExerciseModel> listeningForLevel(String? level) {
  if (level == null || level.isEmpty) return kListeningAll;
  final l = level.toUpperCase();
  return kListeningAll.where((e) => e.level == l).toList();
}

/// Kategori filtresi.
List<ListeningExerciseModel> listeningForCategory(String category) =>
    kListeningAll.where((e) => e.category == category).toList();
