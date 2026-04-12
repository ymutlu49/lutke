// LÛTKE — C1 DERS TANIMLARI
// Düzey: C1 (İleri / Pêşkeftî)
// 15 ders tamamlandı, 15 ders yapı hazır

import '../domain/lesson_entities.dart';

final kC1Lessons = [

  // UNİTE 1: KLASİK EDEBİYAT (4 ders)

  LessonModel(
    id: 'c1_l01', level: 5, unitNumber: 1, lessonNumber: 1,
    kurmanjTitle: 'Ehmedê Xanî û Mem û Zîn',
    turkishTitle: 'Xanî ve Mem û Zîn',
    description: 'Kürt klasik edebiyatinin zirvesi',
    vocabulary: ['c1_040','c1_001','c1_005','c1_006','c1_002'],
    grammarNote: 'Xanî (1651-1707) Mem û Zîn\'i 1695\'te yazdı. Pêşgotinda (önsözde): "Kurd çima di nav gelan de paşde mane?" Cevap: yekîtî tune ye.',
    culturalNote: 'Mem û Zîn = Kürt ulusal destani. Romeo ve Juliet\'e benzese de siyasi mesaji çok daha derin.',
    exercises: [
      LessonExercise(id:'c1_l01_e1', type:ExerciseType.fillBlank,
        content:'Mem û Zîn destana ___ ya kurdî ye.',
        correctAnswer:'evînê', options:['evînê','xemê','azadiyê']),
      LessonExercise(id:'c1_l01_e2', type:ExerciseType.translate,
        content:'Xanî Kürt birliğini savundu.',
        correctAnswer:'Xanî yekîtîya kurdî parast.', options:[]),
      LessonExercise(id:'c1_l01_e3', type:ExerciseType.speak,
        content:'Ev berhem ji bo çi hatiye nivîsandin?',
        correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'c1_l02', level: 5, unitNumber: 1, lessonNumber: 2,
    kurmanjTitle: 'Melayê Cizîrî û Şiîrê Tasawwufî',
    turkishTitle: 'Melayê Cizîrî ve Tasavvuf Şiiri',
    description: 'Kürt tasavvuf şiirinin dili ve sembolleri',
    vocabulary: ['c1_001','c1_002','c1_003','c1_005','c1_006'],
    grammarNote: 'Klasik semboller: Bilbil = aşik/şair, Gul = sevgili/Tanri, Baxçe = cennet/Kürdistan. Mela (1570-1640) Arapça/Farsça sözdizimini Kurmanciye aktardi.',
    culturalNote: 'Divana Mela — hem dini hem dünyevi aşk.',
    exercises: [
      LessonExercise(id:'c1_l02_e1', type:ExerciseType.fillBlank,
        content:'Bilbil li ser ___ distirê.',
        correctAnswer:'gulê', options:['gulê','darê','çemê']),
      LessonExercise(id:'c1_l02_e2', type:ExerciseType.speak,
        content:'Melayê Cizîrî kê ye?',
        correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'c1_l03', level: 5, unitNumber: 1, lessonNumber: 3,
    kurmanjTitle: 'Cegerxwîn û Helbesta Siyasî',
    turkishTitle: 'Cegerxwîn ve Siyasi Şiir',
    description: 'Cegerxwîn\'in dili: halk şiiri + siyasi mesaj',
    vocabulary: ['c1_070','c1_071','c1_044','c1_042'],
    grammarNote: 'Cegerxwîn (1903-1984): "Ev Welat a Me" — tekrarlı yapılar, açik siyasi mesaj. "Ez diçim, ez diçim, rê dirêj e... Lê dilê min li vir maye."',
    culturalNote: 'Cegerxwîn = modern Kürt şiirinin babasi. Hem şair hem devrimci.',
    exercises: [
      LessonExercise(id:'c1_l03_e1', type:ExerciseType.translate,
        content:'Bu ülke kimin?',
        correctAnswer:'Ev welat ji kê re ye?', options:[]),
      LessonExercise(id:'c1_l03_e2', type:ExerciseType.speak,
        content:'Cegerxwîn çima girîng e?',
        correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'c1_l04', level: 5, unitNumber: 1, lessonNumber: 4,
    kurmanjTitle: 'Dengbêjîya Kurdî',
    turkishTitle: 'Kürt Dengbêjliği',
    description: 'Dengbêj geleneğinin dili, hafizasi ve önemi',
    vocabulary: ['c1_009','c1_008','c1_003','c1_004'],
    grammarNote: 'Dengbêj dili: uzun cümleler, tekrarlı kaliplar ("Wey lo lo"), zaman birleşimi. Yapisi: Vakit + karakter + olay + figan.',
    culturalNote: 'UNESCO 2022: Dengbêjlik somut olmayan kültürel miras.',
    exercises: [
      LessonExercise(id:'c1_l04_e1', type:ExerciseType.speak,
        content:'Dengbêjî çi ye û çima girîng e?',
        correctAnswer:'', options:[]),
      LessonExercise(id:'c1_l04_e2', type:ExerciseType.fillBlank,
        content:'Dengbêj ___ û kelamê diparêze.',
        correctAnswer:'hafizayê', options:['hafizayê','xemê','evînê']),
    ],
  ),

  // UNİTE 2: FELSEFİ VE AKADEMİK DİL (4 ders)

  LessonModel(
    id: 'c1_l05', level: 5, unitNumber: 2, lessonNumber: 1,
    kurmanjTitle: 'Zimannasîya Kurdî',
    turkishTitle: 'Kürt Dilbilimi',
    description: 'Kurmancî\'nin yapısal özellikleri dilbilimsel açidan',
    vocabulary: ['c1_030','c1_031','c1_032','c1_033','c1_034'],
    grammarNote: 'Kurmancî özellikleri: Split Ergativity, cinsiyet sistemi (eril/dişil), Ezafe yapisi, SOV eğilimi. Terminoloji: Ergatîvî, Morfolojî, Sentaks, Semantîk, Pragmatîk.',
    culturalNote: 'Kurmancî Hind-Avrupa ailesinden, İran dalinda. Farsçadan daha eski yapilar korumuş.',
    exercises: [
      LessonExercise(id:'c1_l05_e1', type:ExerciseType.translate,
        content:'Kurmancî ergatif bir dildir.',
        correctAnswer:'Kurmancî zimanekî ergatîvî ye.', options:[]),
      LessonExercise(id:'c1_l05_e2', type:ExerciseType.speak,
        content:'Kurmancîya ergatîvî çi ye?',
        correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'c1_l06', level: 5, unitNumber: 2, lessonNumber: 2,
    kurmanjTitle: 'Felsefeya Zimên û Nasname',
    turkishTitle: 'Dil Felsefesi ve Kimlik',
    description: 'Dil-kimlik ilişkisi felsefi perspektiften',
    vocabulary: ['c1_011','c1_012','c1_015','c1_101','c1_163'],
    grammarNote: 'Temel cümleler: "Ziman nasnameya mezintirîn e." "Bêyî ziman, civak tune ye." Wittgenstein: "Zimanê min sînorê cîhana min e."',
    culturalNote: 'Kürtçe yasaği (1991 öncesi Türkiye) — dil hem kültürel hem siyasi kimlik.',
    exercises: [
      LessonExercise(id:'c1_l06_e1', type:ExerciseType.speak,
        content:'Ziman û nasname çawa têkildar in?',
        correctAnswer:'', options:[]),
      LessonExercise(id:'c1_l06_e2', type:ExerciseType.translate,
        content:'Dil kimliğin en büyük parçasidir.',
        correctAnswer:'Ziman beşê herî mezin ê nasnameyê ye.', options:[]),
    ],
  ),

  LessonModel(
    id: 'c1_l07', level: 5, unitNumber: 2, lessonNumber: 3,
    kurmanjTitle: 'Nivîsandina Akademîk',
    turkishTitle: 'Akademik Yazı',
    description: 'Kürtçe akademik metin yazimi',
    vocabulary: ['c1_150','c1_151','c1_152','c1_140','c1_141'],
    grammarNote: 'Yapi: Destpêk (hevoka bingehîn) + Pêşxistin (arguman) + Encam. Atif: "Li gorî [yazar]..." "Weke ku diyar kiriye..." "Lêkolîna nîşan dide ku..."',
    culturalNote: 'Kürtçe akademik yazinin tarihi bastirimi — C1\'de yeniden inşa.',
    exercises: [
      LessonExercise(id:'c1_l07_e1', type:ExerciseType.speak,
        content:'Gotareke akademîk çawa tê nivîsandin?',
        correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'c1_l08', level: 5, unitNumber: 2, lessonNumber: 4,
    kurmanjTitle: 'Rexne û Analîz',
    turkishTitle: 'Eleştiri ve Analiz',
    description: 'Edebi ve siyasi metinleri eleştirel okuma',
    vocabulary: ['c1_043','c1_044','c1_142','c1_161','c1_162'],
    grammarNote: 'Sorular: "Nivîskar çi dixwaze bêje?" "Argumana bingehîn çi ye?" "Delîl hene?" Kaliplar: "Ev text nîşan dide ku..." "Ji alîyê din ve..."',
    culturalNote: '',
    exercises: [
      LessonExercise(id:'c1_l08_e1', type:ExerciseType.speak,
        content:'Tekstekî akademîk çawa tê analîz kirin?',
        correctAnswer:'', options:[]),
    ],
  ),

  // UNİTE 3: SİYASİ VE TOPLUMSAL SÖYLEM (5 ders)

  LessonModel(
    id: 'c1_l09', level: 5, unitNumber: 3, lessonNumber: 1,
    kurmanjTitle: 'Pirsgirêka Kurdî',
    turkishTitle: 'Kürt Meselesi',
    description: 'Kürt meselesinin tarihi arka plani ve çözüm önerileri',
    vocabulary: ['c1_070','c1_072','c1_073','c1_074','c1_075'],
    grammarNote: 'Tartişma kaliplari: "Pirsgirêk çi ye?" "Çareserî divê?" "Hin kesan bawer dikin ku... Lê yên din..." Argüman: Ji ber ku -> lewre -> encam -> pêşniyar.',
    culturalNote: 'Siyasi tartişma = C1 seviyesinin özü.',
    exercises: [
      LessonExercise(id:'c1_l09_e1', type:ExerciseType.speak,
        content:'Pirsgirêka kurdî çi ye?', correctAnswer:'', options:[]),
      LessonExercise(id:'c1_l09_e2', type:ExerciseType.speak,
        content:'Çareserîyek pêşniyar bike.', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'c1_l10', level: 5, unitNumber: 3, lessonNumber: 2,
    kurmanjTitle: 'Mafên Mirovî û Kurd',
    turkishTitle: 'İnsan Haklari ve Kürtler',
    description: 'İnsan haklari söylemi Kürt perspektifinden',
    vocabulary: ['c1_023','c1_024','c1_025','c1_120','c1_121'],
    grammarNote: 'BM bildirgesinden: "Her mirov bi azad û wekhev di mafan de ji dayik dibin." Talep: "Em daxwaz dikin ku..." "Mafê me ye ku..." "Divê were pejirandin ku..."',
    culturalNote: 'Kürt dil hakki, eğitim hakki, kültürel ifade özgürlüğü.',
    exercises: [
      LessonExercise(id:'c1_l10_e1', type:ExerciseType.translate,
        content:'Eğitim temel bir insan hakkirdir.',
        correctAnswer:'Perwerde mafekî bingehîn ê mirovî ye.', options:[]),
    ],
  ),

  LessonModel(
    id: 'c1_l11', level: 5, unitNumber: 3, lessonNumber: 3,
    kurmanjTitle: 'Diaspora û Nasname',
    turkishTitle: 'Diaspora ve Kimlik',
    description: 'Diaspora koşullarinda kimlik ve dil',
    vocabulary: ['c1_100','c1_101','c1_102','c1_103'],
    grammarNote: 'Diaspora dili: "Di diasporayê de..." "Hem... hem jî..." "Di navbera du cîhanan de." C1: "Dilê min Kurmancî ye, lê zimanê jiyanê min îngilîzî ye."',
    culturalNote: 'Heritage learner\'in gerçekliği.',
    exercises: [
      LessonExercise(id:'c1_l11_e1', type:ExerciseType.speak,
        content:'Tu çawa diasporayê pênase dikî?', correctAnswer:'', options:[]),
      LessonExercise(id:'c1_l11_e2', type:ExerciseType.speak,
        content:'Nasnameya te çawa ye?', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'c1_l12', level: 5, unitNumber: 3, lessonNumber: 4,
    kurmanjTitle: 'Kolonîyalîzm û Ziman',
    turkishTitle: 'Sömürgecilik ve Dil',
    description: 'Sömürge dil politikalari ve Kürtçe',
    vocabulary: ['c1_073','c1_025','c1_122'],
    grammarNote: 'Aşamalar: Yasak (qedexe) -> asimilasyon (bişaftin) -> canlanma (vejîn). Pasif: "Hat qedexe kirin." "Hat şafandin." "Tê rojê dike."',
    culturalNote: '1991 öncesi Türkiye: Kürtçe tamamen yasak.',
    exercises: [
      LessonExercise(id:'c1_l12_e1', type:ExerciseType.speak,
        content:'Ziman çawa wek çek hate bikar anîn?', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'c1_l13', level: 5, unitNumber: 3, lessonNumber: 5,
    kurmanjTitle: 'Vejîna Zimanî',
    turkishTitle: 'Dil Canlanmasi',
    description: 'Kürtçenin yeniden canlanmasi',
    vocabulary: ['c1_071','c1_072','c1_130'],
    grammarNote: 'Terminoloji: vejîna zimanî, standardkirin, peyvsazîya nû. Motive: "Ziman dijî!" "Her peyvek ku dibêjî, dirûşmek e." "Tu têkoşêrî."',
    culturalNote: 'Ibranice, Welsh, Baskça başarili canlanma örnekleri.',
    exercises: [
      LessonExercise(id:'c1_l13_e1', type:ExerciseType.speak,
        content:'Vejîna zimanê kurdî çawa ye?', correctAnswer:'', options:[]),
    ],
  ),

  // UNİTE 4: GAZETE VE MEDYA DİLİ (3 ders)

  LessonModel(
    id: 'c1_l14', level: 5, unitNumber: 4, lessonNumber: 1,
    kurmanjTitle: 'Nûçeya Kurdî',
    turkishTitle: 'Kürtçe Haber',
    description: 'Kürtçe haber metni okuma ve yazma',
    vocabulary: ['c1_050','c1_051','c1_052','c1_053'],
    grammarNote: 'Haber dili: pasif yoğun ("Hat ragihandin ku..."), kaynak ("Li gorî çavkaniyên..."), tarih ("Di Çarşema berê de..."). Başlik: kisa, güçlü fiil sonu.',
    culturalNote: 'Rudaw, Kurdistan24, ANF News — Kürtçe medya.',
    exercises: [
      LessonExercise(id:'c1_l14_e1', type:ExerciseType.speak,
        content:'Nûçeyek bi kurmancî binivîse.', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'c1_l15', level: 5, unitNumber: 4, lessonNumber: 2,
    kurmanjTitle: 'Gotar û Rexne',
    turkishTitle: 'Makale ve Eleştiri',
    description: 'Görüş makalesi ve eleştiri yazisi',
    vocabulary: ['c1_142','c1_044','c1_151','c1_152'],
    grammarNote: 'Yapi: Para.1 giriş + Para.2-4 argümanlar + Para.5 karşi görüş + Para.6 sonuç. Kaliplar: "Li gorî min..." "Hinekan bawer dikin ku... lê ez..." "Weke encamekê..."',
    culturalNote: '',
    exercises: [
      LessonExercise(id:'c1_l15_e1', type:ExerciseType.speak,
        content:'Li ser pirsgirêkeke civakî gotarekê binivîse.', correctAnswer:'', options:[]),
    ],
  ),

];

// ════════════════════════════════════════════════════════════════
// C1 DERS EGZERSİZLERİ — TAMAMLAMA
// İlke §5: Çeşitli egzersiz tipleri
// ════════════════════════════════════════════════════════════════

/// C1 derslerine egzersiz ekler (lesson_screen tarafından kullanılır)
List<ExerciseModel> getC1Exercises(String lessonId) {
  return switch (lessonId) {

    // ── Ders 1: Ehmedê Xanî û Mem û Zîn ──────────────────────
    'c1_l01' => [
      ExerciseModel(
        id: 'c1_l01_e1',
        type: ExerciseType.multipleChoice,
        kurmanjPrompt: '"Mem û Zîn" çi ye?',
        turkishPrompt: '"Mem û Zîn" nedir?',
        options: ['Ehmedê Xanî\'nin eseri', 'Bir atasözü', 'Dengbêj türküsü', 'Dilbilgisi kitabı'],
        correctAnswer: 'Ehmedê Xanî\'nin eseri',
        correctIndex: 0,
        grammarNote: 'Eril isim "Xanî" — oblique: "Xaniyê"',
        culturalNote: 'Mem û Zîn (1695) — Kürt klasik edebiyatının zirvesi. Evrensel sevgi ve özgürlük teması.',
        xpReward: 15,
        cardId: 'c1_301',
      ),
      ExerciseModel(
        id: 'c1_l01_e2',
        type: ExerciseType.flashcard,
        kurmanjPrompt: 'Dîwana Xanî',
        turkishPrompt: 'Xani\'nin Divanı',
        options: [],
        correctAnswer: 'Dîwana Xanî',
        culturalNote: 'Ehmedê Xanî (1650-1707) — Kurmancî edebi geleneğinin kurucusu.',
        xpReward: 10,
        cardId: 'c1_302',
      ),
      ExerciseModel(
        id: 'c1_l01_e3',
        type: ExerciseType.typing,
        kurmanjPrompt: 'Xanî = Kürt klasik edebiyatının hangi şairinin adı?',
        turkishPrompt: 'Kurmancî yazın: "Ehmedê Xanî"',
        options: [],
        correctAnswer: 'Ehmedê Xanî',
        grammarNote: 'Özel isim — büyük harfle başlar',
        xpReward: 20,
        cardId: 'c1_302',
      ),
    ],

    // ── Ders 2: Melayê Cizîrî ────────────────────────────────
    'c1_l02' => [
      ExerciseModel(
        id: 'c1_l02_e1',
        type: ExerciseType.multipleChoice,
        kurmanjPrompt: '"Tasawwuf" çi ye?',
        options: ['Mistisizm / Sufizm', 'Savaş şiiri', 'Halk müziği', 'Dilbilgisi'],
        correctAnswer: 'Mistisizm / Sufizm',
        correctIndex: 0,
        culturalNote: 'Melayê Cizîrî (1570-1640) — Sufî şiir geleneğinin Kurmancî temsilcisi.',
        xpReward: 15,
        cardId: 'c1_303',
      ),
      ExerciseModel(
        id: 'c1_l02_e2',
        type: ExerciseType.flashcard,
        kurmanjPrompt: 'Helbestên xemgîn',
        turkishPrompt: 'Hüzünlü şiirler',
        options: [],
        correctAnswer: 'Helbestên xemgîn',
        culturalNote: 'Kürt lirik geleneğinde hüzün ve özlem merkezi temalar.',
        xpReward: 10,
        cardId: 'c1_304',
      ),
    ],

    // ── Ders 3: Cegerxwîn ─────────────────────────────────────
    'c1_l03' => [
      ExerciseModel(
        id: 'c1_l03_e1',
        type: ExerciseType.multipleChoice,
        kurmanjPrompt: 'Cegerxwîn kengî jiyan kir?',
        turkishPrompt: 'Cegerxwîn hangi dönemde yaşadı?',
        options: ['1903-1984', '1650-1707', '1800-1850', '1950-2000'],
        correctAnswer: '1903-1984',
        correctIndex: 0,
        culturalNote: 'Cegerxwîn — gerçek adı Şükrü Hasan Kurdî. Sosyalist Kürt şairi.',
        xpReward: 15,
        cardId: 'c1_308',
      ),
      ExerciseModel(
        id: 'c1_l03_e2',
        type: ExerciseType.typing,
        kurmanjPrompt: 'Sosyalist Kürt şairini Kurmancî yaz:',
        turkishPrompt: 'Cegerxwîn',
        options: [],
        correctAnswer: 'Cegerxwîn',
        grammarNote: '"Ceger" (kalp/ciğer) + "xwîn" (kan) = Kanlı yürek',
        xpReward: 20,
        cardId: 'c1_308',
      ),
    ],

    // ── Ders 4: Akademik Yazım ───────────────────────────────
    'c1_l04' => [
      ExerciseModel(
        id: 'c1_l04_e1',
        type: ExerciseType.multipleChoice,
        kurmanjPrompt: '"Argumansaziya akademîk" çi tê wateya?',
        options: ['Akademik tartışma sanatı', 'Sözlük yazımı', 'Şiir yazımı', 'Ses kaydı'],
        correctAnswer: 'Akademik tartışma sanatı',
        correctIndex: 0,
        grammarNote: '"arguman" (Latince) + "sazî" (yapım eki)',
        xpReward: 15,
        cardId: 'c1_409',
      ),
      ExerciseModel(
        id: 'c1_l04_e2',
        type: ExerciseType.sentenceOrder,
        kurmanjPrompt: 'Cümleyi sırala:',
        options: ['lazim', 'akademîk', 'Argumansaziya', 'e'],
        correctAnswer: 'Argumansaziya akademîk lazim e.',
        xpReward: 20,
        cardId: 'c1_409',
      ),
    ],

    // Diğer dersler için genel egzersiz seti
    _ => [
      ExerciseModel(
        id: '${lessonId}_e1',
        type: ExerciseType.flashcard,
        kurmanjPrompt: 'Vê waneyê bişkîne',
        turkishPrompt: 'Bu dersi incele',
        options: [],
        correctAnswer: '',
        xpReward: 10,
      ),
    ],
  };
}
