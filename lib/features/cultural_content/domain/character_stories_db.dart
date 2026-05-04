/// LÛTKE — Character Stories (Duolingo Story formatı uyarlaması)
///
/// Kurmancî klasik + modern edebiyatından mini hikayeler.
/// Her hikaye: 2-3 dakikalık pasif dinleme + aktif kavrama soruları.
/// TTS ile seslendirilir (HF Kurmancî). Metin vurgusu karaoke modu.

enum StoryLevel { a1, a2, b1, b2, c1, c2 }

class StoryLine {
  final String speaker;       // 'Narrator' | 'Mem' | 'Cegerxwîn' | 'Pîrê' vb.
  final String textKu;
  final String textTr;
  final String? emotion;      // opsiyonel duygu ipucu
  final String? emoji;

  const StoryLine({
    required this.speaker,
    required this.textKu,
    required this.textTr,
    this.emotion,
    this.emoji,
  });
}

class StoryQuestion {
  final String questionKu;
  final String questionTr;
  final List<String> options;
  final int correctIndex;

  const StoryQuestion({
    required this.questionKu,
    required this.questionTr,
    required this.options,
    required this.correctIndex,
  });
}

class CharacterStory {
  final String id;
  final String titleKu;
  final String titleTr;
  final StoryLevel level;
  final String emoji;
  final String themeColor;    // hex
  final String synopsisKu;
  final String synopsisTr;
  final List<StoryLine> lines;
  final List<StoryQuestion> questions;
  final String? source;
  final int xpReward;

  const CharacterStory({
    required this.id,
    required this.titleKu,
    required this.titleTr,
    required this.level,
    required this.emoji,
    required this.themeColor,
    required this.synopsisKu,
    required this.synopsisTr,
    required this.lines,
    required this.questions,
    this.source,
    this.xpReward = 40,
  });
}

// ════════════════════════════════════════════════════════════════
// HİKAYELER
// ════════════════════════════════════════════════════════════════

const kCharacterStories = <CharacterStory>[

  // ── 1. Pîrê û Çay (A1) ────────────────────────────────────
  CharacterStory(
    id: 'story_001',
    titleKu: 'Pîrê û Çay',
    titleTr: 'Büyükanne ve Çay',
    level: StoryLevel.a1,
    emoji: '☕',
    themeColor: '#D4A574',
    synopsisKu: 'Karik tê cem pîrê, pîrê jê re çay çêdike.',
    synopsisTr: 'Karik büyükannesine gelir, büyükanne ona çay yapar.',
    lines: [
      StoryLine(
        speaker: 'Narrator',
        textKu: 'Sibe ye. Karik tê cem pîra xwe.',
        textTr: 'Sabah. Karik büyükannesinin yanına gelir.',
        emoji: '🌅',
      ),
      StoryLine(
        speaker: 'Karik',
        textKu: 'Silav, pîrê!',
        textTr: 'Merhaba, büyükanne!',
        emoji: '👋',
        emotion: 'happy',
      ),
      StoryLine(
        speaker: 'Pîrê',
        textKu: 'Silav karikê min. Tu çayê dixwazî?',
        textTr: 'Merhaba yavrum. Çay ister misin?',
        emoji: '☕',
        emotion: 'warm',
      ),
      StoryLine(
        speaker: 'Karik',
        textKu: 'Erê, spas!',
        textTr: 'Evet, teşekkürler!',
      ),
      StoryLine(
        speaker: 'Pîrê',
        textKu: 'Kerem ke, vexwe, çay germ e.',
        textTr: 'Buyur, iç, çay sıcak.',
      ),
      StoryLine(
        speaker: 'Karik',
        textKu: 'Çay xweş e. Gelek spas, pîrê!',
        textTr: 'Çay güzel. Çok teşekkürler, büyükanne!',
        emotion: 'happy',
      ),
    ],
    questions: [
      StoryQuestion(
        questionKu: 'Karik çi dixwaze?',
        questionTr: 'Karik ne ister?',
        options: ['Av', 'Nan', 'Şîr', 'Çay'],
        correctIndex: 3,
      ),
      StoryQuestion(
        questionKu: 'Pîrê çawa ye?',
        questionTr: 'Büyükanne nasıl?',
        options: ['Sar û dûr', 'Aciz û bêdil', 'Bêdeng û tirsnak', 'Germ û dilovan'],
        correctIndex: 3,
      ),
    ],
    xpReward: 30,
  ),

  // ── 2. Newroza Kawa (A2) ──────────────────────────────────
  CharacterStory(
    id: 'story_002',
    titleKu: 'Kawayê Hesinker',
    titleTr: 'Demirci Kawa',
    level: StoryLevel.a2,
    emoji: '🔥',
    themeColor: '#E74C3C',
    synopsisKu: 'Efsaneya Newrozê — Kawa zordariyê hilweşand.',
    synopsisTr: 'Nevruz efsanesi — Kawa zulmü yıktı.',
    source: 'Efsaneya Kurdî',
    lines: [
      StoryLine(
        speaker: 'Narrator',
        textKu: 'Demekê, padîşahekî zordar hebû. Navê wî Dehak bû.',
        textTr: 'Bir zamanlar zalim bir padişah vardı. Adı Dehak\'tı.',
      ),
      StoryLine(
        speaker: 'Narrator',
        textKu: 'Dehak her roj du xortan dikuşt. Gel hêrs bû.',
        textTr: 'Dehak her gün iki genci öldürürdü. Halk öfkelendi.',
        emotion: 'sad',
      ),
      StoryLine(
        speaker: 'Narrator',
        textKu: 'Hesinkerekî bi navê Kawa hebû. Wî biryar da ku serî hilde.',
        textTr: 'Kawa adında bir demirci vardı. O ayağa kalkmaya karar verdi.',
      ),
      StoryLine(
        speaker: 'Kawa',
        textKu: 'Em ê êdî netirsin! Em ê bi hev re rabin!',
        textTr: 'Artık korkmayacağız! Birlikte ayağa kalkacağız!',
        emotion: 'brave',
        emoji: '🔨',
      ),
      StoryLine(
        speaker: 'Narrator',
        textKu: 'Kawa û gel Dehak hilweşandin. Li ser çiyayan agirê mezin pêxistin.',
        textTr: 'Kawa ve halk Dehak\'ı yıktılar. Dağlarda büyük ateş yaktılar.',
      ),
      StoryLine(
        speaker: 'Narrator',
        textKu: 'Ji wê rojê ve, 21ê Adarê Newroz e. Cejna azadiyê ye.',
        textTr: 'O günden beri 21 Mart Nevruz\'dur. Özgürlük bayramıdır.',
        emoji: '🎆',
      ),
    ],
    questions: [
      StoryQuestion(
        questionKu: 'Padîşahê zordar kî bû?',
        questionTr: 'Zalim padişah kimdi?',
        options: ['Dehak', 'Kawa', 'Xanî', 'Cegerxwîn'],
        correctIndex: 0,
      ),
      StoryQuestion(
        questionKu: 'Kawa çi kar dikir?',
        questionTr: 'Kawa\'nın mesleği neydi?',
        options: ['Cotkarî', 'Stranbêjî', 'Padîşahî', 'Hesinkerî'],
        correctIndex: 3,
      ),
      StoryQuestion(
        questionKu: 'Newroz çi ye?',
        questionTr: 'Nevruz nedir?',
        options: [
          'Roja padîşahan',
          'Cejna azadiyê û biharê',
          'Roja sala nû',
          'Cejna baranê'
        ],
        correctIndex: 1,
      ),
    ],
    xpReward: 40,
  ),

  // ── 3. Xanî: Ji Mem û Zîn (B1) ────────────────────────────
  CharacterStory(
    id: 'story_003',
    titleKu: 'Ji "Mem û Zîn"ê: Evîna Mem',
    titleTr: 'Mem û Zîn\'den: Mem\'in Aşkı',
    level: StoryLevel.b1,
    emoji: '💔',
    themeColor: '#9B59B6',
    synopsisKu: 'Parçeyek ji destana Xanî — Mem ji Zînê hez dike.',
    synopsisTr: 'Xanî destanından bir parça — Mem Zîn\'i seviyor.',
    source: 'Ehmedê Xanî, Mem û Zîn (1695)',
    lines: [
      StoryLine(
        speaker: 'Narrator',
        textKu: 'Li Cizîra Botan, xortekî bi navê Mem hebû.',
        textTr: 'Cizira Botan\'da Mem adında bir genç vardı.',
      ),
      StoryLine(
        speaker: 'Narrator',
        textKu: 'Roja Newrozê, Memî Zîn dît. Dilê wî pêket.',
        textTr: 'Nevruz günü, Mem Zîn\'i gördü. Kalbi tutuştu.',
        emotion: 'romantic',
      ),
      StoryLine(
        speaker: 'Mem',
        textKu: 'Ey Zîn, te bi nihêrîna çavan ez kuştim!',
        textTr: 'Ey Zîn, gözlerinin bakışıyla beni öldürdün!',
        emoji: '❤️',
      ),
      StoryLine(
        speaker: 'Zîn',
        textKu: 'Ez jî te nas dikim, Mem. Lê mîr nahêle em bibin yek.',
        textTr: 'Ben de seni tanıyorum, Mem. Ama mir birleşmemize izin vermiyor.',
        emotion: 'sad',
      ),
      StoryLine(
        speaker: 'Narrator',
        textKu: 'Bekirê Mergaver di navbera wan de fesadî kir.',
        textTr: 'Bekirê Mergaver onların arasında fesatlık çıkardı.',
      ),
      StoryLine(
        speaker: 'Narrator',
        textKu: 'Mîr Zeynedîn xapiya. Mem ket zîndanê.',
        textTr: 'Mir Zeynedîn aldandı. Mem zindana düştü.',
      ),
      StoryLine(
        speaker: 'Mem',
        textKu: 'Zînê, ez ê bi xeyala te bimirim.',
        textTr: 'Zîn, senin hayalinle öleceğim.',
        emotion: 'tragic',
      ),
      StoryLine(
        speaker: 'Narrator',
        textKu: 'Mem mir. Zîn jî li ser gora wî çû ser dilovaniya Xwedê.',
        textTr: 'Mem öldü. Zîn de onun mezarı başında vefat etti.',
        emoji: '🥀',
      ),
      StoryLine(
        speaker: 'Xanî',
        textKu: 'Xanî dibêje: "Bêyekîtiya Kurdan ji bo wan derd e."',
        textTr: 'Xanî der ki: "Kürtlerin birliksizliği onların derdidir."',
      ),
    ],
    questions: [
      StoryQuestion(
        questionKu: 'Mem Zînê kengî dît?',
        questionTr: 'Mem Zîn\'i ne zaman gördü?',
        options: ['Payîzê', 'Roja Newrozê', 'Zivistan', 'Şeva Newrozê'],
        correctIndex: 1,
      ),
      StoryQuestion(
        questionKu: 'Kî fitne çêkir?',
        questionTr: 'Fitneyi kim çıkardı?',
        options: ['Bekirê Mergaver', 'Zîn', 'Mîr', 'Tacdîn'],
        correctIndex: 0,
      ),
      StoryQuestion(
        questionKu: 'Xanî çi peyamê dide?',
        questionTr: 'Xanî hangi mesajı verir?',
        options: [
          'Pere û dewlemendî bingehê civakê ne',
          'Bêyekîtiya Kurdan ji wan re derd e',
          'Demên kevnar ji nû ve tên jiyandin',
          'Evîna serbest ji her zordestiyê bilindtir e'
        ],
        correctIndex: 1,
      ),
    ],
    xpReward: 50,
  ),

  // ── 4. Cegerxwîn: Kî Me Ez? (B2) ─────────────────────────
  CharacterStory(
    id: 'story_004',
    titleKu: 'Cegerxwîn: "Kî me ez?"',
    titleTr: 'Cegerxwîn: "Ben Kimim?"',
    level: StoryLevel.b2,
    emoji: '🌟',
    themeColor: '#2C3E50',
    synopsisKu: 'Cegerxwîn li nasnameya xwe digere — helbest û jiyan.',
    synopsisTr: 'Cegerxwîn kimliğini arıyor — şiir ve hayat.',
    source: 'Cegerxwîn, Dîwan III (1960s)',
    lines: [
      StoryLine(
        speaker: 'Narrator',
        textKu: 'Cegerxwîn di sala 1903an de li gundê Hesarê (Gercûş, Mêrdîn) hat dinyayê.',
        textTr: 'Cegerxwîn 1903\'te Hesar köyünde (Gercüş ilçesi, Mardin) dünyaya geldi.',
      ),
      StoryLine(
        speaker: 'Narrator',
        textKu: 'Paşê çû Sûriyê, dûv re jî Swêdê.',
        textTr: 'Sonra Suriye\'ye, ardından İsveç\'e gitti.',
      ),
      StoryLine(
        speaker: 'Cegerxwîn',
        textKu: 'Kî me ez? Li xwe digerim.',
        textTr: 'Ben kimim? Kendimi arıyorum.',
        emotion: 'reflective',
      ),
      StoryLine(
        speaker: 'Cegerxwîn',
        textKu: 'Ez Kurd im, ji Kurdistanê me.',
        textTr: 'Kürdüm ben, Kürdistanlıyım.',
        emoji: '🌄',
      ),
      StoryLine(
        speaker: 'Cegerxwîn',
        textKu: 'Zimanê min Kurmancî ye, rûmeta min serbilind e.',
        textTr: 'Dilim Kurmancî, onurum başı dik.',
      ),
      StoryLine(
        speaker: 'Narrator',
        textKu: 'Wî bi zimanê gel dinivîsî, ne bi zimanê elîtan.',
        textTr: 'Halkın diliyle yazardı, elitlerin diliyle değil.',
      ),
      StoryLine(
        speaker: 'Narrator',
        textKu: 'Helbestên wî yên 8 cildî hê jî dijîn.',
        textTr: '8 ciltlik şiirleri hâlâ yaşıyor.',
      ),
      StoryLine(
        speaker: 'Cegerxwîn',
        textKu: 'Welat di dilê min de ye. Ziman, gelê min e.',
        textTr: 'Vatan kalbimdedir. Dil, halkımdır.',
        emotion: 'proud',
      ),
    ],
    questions: [
      StoryQuestion(
        questionKu: 'Cegerxwîn li ku hat dinyayê?',
        questionTr: 'Cegerxwîn nerede doğdu?',
        options: ['Amedê', 'Şamê', 'Hewlêrê', 'Hesarê (Gercûş)'],
        correctIndex: 3,
      ),
      StoryQuestion(
        questionKu: 'Pirsa bingehî ya Cegerxwîn çi ye?',
        questionTr: 'Cegerxwîn\'in temel sorusu nedir?',
        options: [
          'Çawa ye hewa?',
          'Kî me ez?',
          'Ku ne welatê min?',
          'Kengî tê kar?'
        ],
        correctIndex: 1,
      ),
      StoryQuestion(
        questionKu: 'Dîwana wî ji çend cildan pêk tê?',
        questionTr: 'Divanı kaç ciltten oluşur?',
        options: ['4', '6', '8', '10'],
        correctIndex: 2,
      ),
    ],
    xpReward: 55,
  ),
];

/// Seviye filtresi.
List<CharacterStory> storiesForLevel(StoryLevel level) =>
    kCharacterStories.where((s) => s.level == level).toList();

/// Track kontrolü — Kurmancî klasik hikayeler yalnız Kurmancî track'te.
/// Çocuk track'te A1-A2 hikayeler (Pîrê-Çay, Kawa), yetişkin C1-C2 değil.
List<CharacterStory> storiesForTrack({
  required bool isEnglish,
  required bool isChild,
}) {
  if (isEnglish) return const [];
  if (isChild) {
    return kCharacterStories
        .where((s) => s.level == StoryLevel.a1 || s.level == StoryLevel.a2)
        .toList();
  }
  return kCharacterStories;
}
