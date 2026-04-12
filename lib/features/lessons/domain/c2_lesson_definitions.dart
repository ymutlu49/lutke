// LÛTKE — C2 DERS TANIMLARI
// Düzey: C2 (Ustalık / Sertî)

import '../domain/lesson_entities.dart';

final kC2Lessons = [

  // UNİTE 1: KLASİK METİN ÜRETİMİ (3 ders)

  LessonModel(
    id: 'c2_l01', level: 6, unitNumber: 1, lessonNumber: 1,
    kurmanjTitle: 'Nivîsandina Wêjeyî',
    turkishTitle: 'Edebi Yazı Üretimi',
    description: 'Özgün Kürtçe edebi metin üretme — helbest, çîrok, gotar',
    vocabulary: ['c2_001','c2_002','c2_003','c2_006','c2_007'],
    grammarNote: 'C2 üretim: helbest (şiir), çîrok (hikaye), gotar (makale). Arûz vezni ve hece vezni. Qafiye türleri: serêqafiye (baş uyak), encamqafiye (son uyak). Özgün yaratım için model: klasik açık, modern yorum.',
    culturalNote: 'C2 = Kürt kültürünün üreticisi. Artık tüketici değil, üretici.',
    exercises: [
      LessonExercise(id:'c2_l01_e1', type:ExerciseType.speak,
        content:'Helbestek bi kurmancî binivîse.', correctAnswer:'', options:[]),
      LessonExercise(id:'c2_l01_e2', type:ExerciseType.speak,
        content:'Çîrokeke kurt binivîse.', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'c2_l02', level: 6, unitNumber: 1, lessonNumber: 2,
    kurmanjTitle: 'Wergerandina Wêjeyî',
    turkishTitle: 'Edebi Çeviri',
    description: 'Türkçe/İngilizceden Kürtçeye edebi çeviri pratiği',
    vocabulary: ['c2_030','c2_031','c2_032','c2_033','c2_034'],
    grammarNote: 'Çeviri ilkeleri: "Wate bo wate" (anlam anlama) değil "ruh bo ruh" (ruh ruha). Kültürel eşdeğer bulma. Kurmanji\'de yok olan kavramları açıklama. Doğrudan çeviri tuzaklarını tanıma.',
    culturalNote: 'Wergerandin = dil köprüsü. Kürt çevirmenlerin rolü kritik.',
    exercises: [
      LessonExercise(id:'c2_l02_e1', type:ExerciseType.translate,
        content:'The mountains are our only friends. (Kürt atasözü)',
        correctAnswer:'Çiya tenê dostên me ne.', options:[]),
      LessonExercise(id:'c2_l02_e2', type:ExerciseType.speak,
        content:'Wergerandin ji kîjanî dijwartir e? Çima?', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'c2_l03', level: 6, unitNumber: 1, lessonNumber: 3,
    kurmanjTitle: 'Rexneya Wêjeyî',
    turkishTitle: 'Edebi Eleştiri',
    description: 'Edebi eleştiri metni yazma — Xanî veya Cegerxwîn üzerine',
    vocabulary: ['c2_041','c2_042','c2_043','c2_040'],
    grammarNote: 'Edebi eleştiri yapisi: 1) Bağlam (dövran û nivîskar) 2) İçerik özeti (navok) 3) Tema analizi (mijar) 4) Dil analizi (ziman û şêwe) 5) Tarihsel önemi (girîngî) 6) Kişisel değerlendirme (nirxandina min).',
    culturalNote: 'Akademik Kürtçe eleştiri yazısı — diaspora gençliği için önemli.',
    exercises: [
      LessonExercise(id:'c2_l03_e1', type:ExerciseType.speak,
        content:'Li ser Mem û Zîn rexneyeke kurt binivîse.', correctAnswer:'', options:[]),
    ],
  ),

  // UNİTE 2: AKADEMİK ARAŞTIRMA (3 ders)

  LessonModel(
    id: 'c2_l04', level: 6, unitNumber: 2, lessonNumber: 1,
    kurmanjTitle: 'Metodolojîya Lêkolînê',
    turkishTitle: 'Araştırma Metodolojisi',
    description: 'Kürtçe akademik araştırma tasarımı',
    vocabulary: ['c2_010','c2_011','c2_012','c2_013','c2_014'],
    grammarNote: 'Araştirma tasarimi Kürtçe: "Pirsên lêkolînê" (araştirma sorulari), "Armanca lêkolînê" (amaç), "Rêbaza lêkolînê" (yöntem), "Berhemên sereke" (birincil kaynaklar), "Encam û pêşniyar" (sonuç ve öneri).',
    culturalNote: 'Kürtçe akademik üretim — hem dil hem bilim katkısı.',
    exercises: [
      LessonExercise(id:'c2_l04_e1', type:ExerciseType.speak,
        content:'Lêkolînek bi kurmancî pêşkêş bike.', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'c2_l05', level: 6, unitNumber: 2, lessonNumber: 2,
    kurmanjTitle: 'Nivîsandina Gotara Zanistî',
    turkishTitle: 'Bilimsel Makale Yazımı',
    description: 'Kürtçe bilimsel makale yazma — tam yapı',
    vocabulary: ['c2_060','c2_061','c2_062','c2_063','c2_064'],
    grammarNote: 'Makale yapisi: Serî (başlik) + Kurtegotar (özet) + Destpêk + Pêşxistin + Encam + Çavkanî (kaynakça). APA atif Kürtçe: "Li gorî [navê nivîskar] ([sal]), ...", "Weke ku [navê nivîskar] diyar kiriye..." Başlik: kisa, açiklayici, anahtar kelimeler.',
    culturalNote: 'Kürtçe ilk bilimsel makalelerden biri: 1932 Hawar dergisi.',
    exercises: [
      LessonExercise(id:'c2_l05_e1', type:ExerciseType.speak,
        content:'Gotareke zanistî bi kurmancî dest pê bike.', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'c2_l06', level: 6, unitNumber: 2, lessonNumber: 3,
    kurmanjTitle: 'Pêşkêşîya Akademîk',
    turkishTitle: 'Akademik Sunum',
    description: 'Konferansta Kürtçe sunum yapma',
    vocabulary: ['c2_060','c2_061','c2_082'],
    grammarNote: 'Sunum yapisi: "Silav û şikir" + "Em ê li ser [mijar] biaxivin" + ana noktalar + "Encam" + "Pirsên we hene?" Geçiş ifadeleri: "Vêga biçin ser..." "Ji alîyê din ve..." "Weke encamekê..."',
    culturalNote: '',
    exercises: [
      LessonExercise(id:'c2_l06_e1', type:ExerciseType.speak,
        content:'Di konferansekê de bi kurmancî pêşkêşî bike.', correctAnswer:'', options:[]),
    ],
  ),

  // UNİTE 3: SİYASİ VE MEDYA (3 ders)

  LessonModel(
    id: 'c2_l07', level: 6, unitNumber: 3, lessonNumber: 1,
    kurmanjTitle: 'Jeopolîtîka Kurdistanê',
    turkishTitle: 'Kürdistan Jeopolitiği',
    description: 'Kürdistan\'ın jeopolitik konumu — dört parçalı gerçeklik',
    vocabulary: ['c2_020','c2_021','c2_022','c2_023','c2_024'],
    grammarNote: 'Dört bölge: Bakurê Kurdistanê (Türkiye), Başûrê Kurdistanê (Irak), Rojhilatê Kurdistanê (İran), Rojavayê Kurdistanê (Suriye). Jeopolitik kavramlar: sînor (sınır), hêz (güç), peymanname (antlaşma), navnetewî (uluslararası).',
    culturalNote: '1923 Lozan Antlaşması — Kürdistan parçalandı. Bu gerçek C2\'nin çekirdeği.',
    exercises: [
      LessonExercise(id:'c2_l07_e1', type:ExerciseType.speak,
        content:'Jeopolîtîka Kurdistanê li gor te çawa ye?', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'c2_l08', level: 6, unitNumber: 3, lessonNumber: 2,
    kurmanjTitle: 'Nûçegirîya Lêkolînî',
    turkishTitle: 'Araştırmacı Gazetecilik',
    description: 'Kürtçe araştırmacı gazetecilik — yöntem ve etik',
    vocabulary: ['c1_050','c2_080','c2_081'],
    grammarNote: 'Araştirmaci gazetecilik soruları (5N1K Kurmancî): Kî? (Kim) Çi? (Ne) Kengî? (Ne zaman) Ku? (Nerede) Çima? (Neden) Çawa? (Nasil). Kaynak doğrulama: "Çavkanîyên pêbawer" (güvenilir kaynaklar). Etik: "Bêalîgirî" (tarafsızlık).',
    culturalNote: 'Kürtçe gazetecilik ve sansür sorunu.',
    exercises: [
      LessonExercise(id:'c2_l08_e1', type:ExerciseType.speak,
        content:'Nûçeyeke lêkolînî bi kurmancî amade bike.', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'c2_l09', level: 6, unitNumber: 3, lessonNumber: 3,
    kurmanjTitle: 'Axaftina Giştî',
    turkishTitle: 'Kamuoyu Konuşması',
    description: 'Halka açık konuşma — retorik ve ikna',
    vocabulary: ['c2_060','c2_062','c2_063'],
    grammarNote: 'Retorik araçlar: Tekrar (dubare kirin), Soru (pirsîn), Zıtlık (dijberî), Metafor (şibandin). Giriş: "Heval û hogirên hêja..." Kapanış: "Xwedê xêr bide, spas." İkna: "Li gorî daneyê..." "Mînak..."',
    culturalNote: 'Kürt siyasi hitabetin geleneği.',
    exercises: [
      LessonExercise(id:'c2_l09_e1', type:ExerciseType.speak,
        content:'Li ser zimanê kurdî axaftineke giştî bike.', correctAnswer:'', options:[]),
    ],
  ),

  // UNİTE 4: DİL VE KÜLTÜR ÜRETİMİ (3 ders)

  LessonModel(
    id: 'c2_l10', level: 6, unitNumber: 4, lessonNumber: 1,
    kurmanjTitle: 'Peyvsazîya Kurdî',
    turkishTitle: 'Kürtçe Kelime Türetme',
    description: 'Yeni Kürtçe kelimeler türetme — modern kavramlar için',
    vocabulary: ['c2_031','c2_032','c2_072'],
    grammarNote: 'Türetme ekleri: -vanî (uğraş), -zan (bilen), -dar (sahip), -ger (yapan), -geh (yer), -name (yazı), -î (soyutlama). Örnekler: Kompîtur + vanî = Kompîturvanî (bilgisayarcılık). Hewa + geh = Hewageh (hava durumu). Rêwî + tî = Rêwîtî (yolculuk). Kural: Önce özgün Kurmancî dene, yoksa uluslararası al.',
    culturalNote: 'Peyvsazî = dil üretimi. Kürtçenin geleceği bu kelimelere bağlı.',
    exercises: [
      LessonExercise(id:'c2_l10_e1', type:ExerciseType.speak,
        content:'Ji bo "artificial intelligence" peyveke bi kurmancî çêke.', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'c2_l11', level: 6, unitNumber: 4, lessonNumber: 2,
    kurmanjTitle: 'Standardkirina Zimanî',
    turkishTitle: 'Dil Standardizasyonu',
    description: 'Kurmancî yazım kuralları ve standartlaştırma',
    vocabulary: ['c2_083','c2_031','c2_032'],
    grammarNote: 'Standart Kurmancî yazım (Hawar alfabesi, 1932): Latin bazlı, 31 harf. Tartişmali noktalar: "bira" mi "birê" mi? "diçe" mi "diçê" mi? Dialekt farkları: Kuzey (Serhedê) vs. Güney (Botan). Kural: Edebi standart baskın, ama diyalekti yok say ma.',
    culturalNote: 'Bedir Han (1932) Latin alfabesi getirdi. Bu devrimdi.',
    exercises: [
      LessonExercise(id:'c2_l11_e1', type:ExerciseType.speak,
        content:'Standardkirina zimanî çima girîng e?', correctAnswer:'', options:[]),
    ],
  ),

  LessonModel(
    id: 'c2_l12', level: 6, unitNumber: 4, lessonNumber: 3,
    kurmanjTitle: 'Bernameya Zimanî',
    turkishTitle: 'Dil Planlaması',
    description: 'Kürtçenin geleceği için dil planlaması',
    vocabulary: ['c2_083','c2_072','c2_071'],
    grammarNote: 'Dil planlaması türleri: Peywsazî (kelime türetme), Perwerdehî (eğitimde Kürtçe), Medya (yayın), Hiqûq (yasal statü), Teknolojî (dijital varlık). Hedefler: 2030\'a kadar dijital ortamda tam Kürtçe içerik. Engeller: parçalanmış coğrafya, siyasi baskı.',
    culturalNote: 'Welsh modeli: Okullarda zorunlu. Kürtçe için model olabilir.',
    exercises: [
      LessonExercise(id:'c2_l12_e1', type:ExerciseType.speak,
        content:'Zimanê kurdî ji bo pêşerojê çawa were pêşvexistin?', correctAnswer:'', options:[]),
    ],
  ),

];

// ════════════════════════════════════════════════════════════════
// C2 DERS EGZERSİZLERİ
// ════════════════════════════════════════════════════════════════

List<ExerciseModel> getC2Exercises(String lessonId) {
  return switch (lessonId) {

    'c2_l01' => [
      ExerciseModel(
        id: 'c2_l01_e1',
        type: ExerciseType.multipleChoice,
        kurmanjPrompt: '"Zimanzaniya berhevdanê" çi ye?',
        options: ['Karşılaştırmalı dilbilim', 'Şiir yazımı', 'Tarih bilimi', 'Felsefe'],
        correctAnswer: 'Karşılaştırmalı dilbilim',
        correctIndex: 0,
        grammarNote: '"zimanzanî" (dilbilim) + "berhevdan" (karşılaştırma)',
        xpReward: 20,
        cardId: 'c2_701',
      ),
      ExerciseModel(
        id: 'c2_l01_e2',
        type: ExerciseType.typing,
        kurmanjPrompt: 'Karşılaştırmalı dilbilimi Kurmancî yaz:',
        turkishPrompt: 'zimanzaniya berhevdanê',
        options: [],
        correctAnswer: 'zimanzaniya berhevdanê',
        xpReward: 25,
        cardId: 'c2_701',
      ),
    ],

    'c2_l02' => [
      ExerciseModel(
        id: 'c2_l02_e1',
        type: ExerciseType.multipleChoice,
        kurmanjPrompt: '"Ontolojîya zimanî" kî got?',
        turkishPrompt: '"Dil varlığın evidir" kimin sözüdür?',
        options: ['Heidegger', 'Saussure', 'Chomsky', 'Foucault'],
        correctAnswer: 'Heidegger',
        correctIndex: 0,
        culturalNote: 'Heidegger: "Ziman mala hebûnê ye" — Dil varlığın evidir.',
        xpReward: 20,
        cardId: 'c2_312',
      ),
    ],

    _ => [
      ExerciseModel(
        id: '${lessonId}_default',
        type: ExerciseType.flashcard,
        kurmanjPrompt: 'Têgeha nû bixwîne',
        turkishPrompt: 'Yeni kavramı oku',
        options: [],
        correctAnswer: '',
        xpReward: 10,
      ),
    ],
  };
}
