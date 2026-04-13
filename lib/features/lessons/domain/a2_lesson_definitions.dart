import 'lesson_entities.dart';
import 'a2_kelime_db.dart';

// ════════════════════════════════════════════════════════════════
// A2 — 25 DERS TANIMI (Temel / Bingehîn)
//
// Pedagoji ilkeleri:
// - Şimdiki zaman tam sistem (di-...-e/im/î/in)
// - Geçmiş zaman geçişsiz (kök + kişi eki)
// - Geçmiş zaman geçişli = ERGATİF giriş (A2 kritik konusu)
// - Gelecek zaman (dê + şimdiki)
// - Olumsuzluk (na-/ne-)
// - Bileşik edatlar (di navbera, ber bi, li ser, li bin)
// - Karşılaştırma (-tir / -tirîn)
// ════════════════════════════════════════════════════════════════

List<String> _a2Cards(List<String> katlar) => kA2TamListe
    .where((k) => katlar.contains(k.kat))
    .map((k) => k.id)
    .toList();

ExerciseModel _mc({
  required String id, required String ku, required String tr,
  required List<String> opts, required int ci,
  String? note, int xp = 10,
}) => ExerciseModel(
  id: id, type: ExerciseType.multipleChoice,
  kurmanjPrompt: ku, turkishPrompt: tr,
  options: opts, correctAnswer: opts[ci], correctIndex: ci,
  grammarNote: note, xpReward: xp,
);

ExerciseModel _ls({
  required String id, required String ku, required String tr,
  required List<String> opts, required int ci,
  String? audio, String? note, int xp = 10,
}) => ExerciseModel(
  id: id, type: ExerciseType.listenAndSelect,
  kurmanjPrompt: ku, turkishPrompt: tr,
  options: opts, correctAnswer: opts[ci], correctIndex: ci,
  audioAsset: audio, grammarNote: note, xpReward: xp,
);

ExerciseModel _fill({
  required String id, required String before, required String after,
  required String tr, required List<String> opts, required int ci,
  String? note, int xp = 12,
}) => ExerciseModel(
  id: id, type: ExerciseType.fillInBlank,
  kurmanjPrompt: '$before ___ $after', turkishPrompt: tr,
  options: opts, correctAnswer: opts[ci], correctIndex: ci,
  grammarNote: note, xpReward: xp,
  wordPieces: [before.trim(), after.trim()],
);

ExerciseModel _speak({
  required String id, required String ku, required String tr,
  String? audio, int xp = 15,
}) => ExerciseModel(
  id: id, type: ExerciseType.speakingPractice,
  kurmanjPrompt: ku, turkishPrompt: tr,
  audioAsset: audio, xpReward: xp,
  options: ['Gelek baş', 'Nêzîk', 'Carek din'],
  correctAnswer: ku,
);

// ════════════════════════════════════════════════════════════════
// 25 DERS
// ════════════════════════════════════════════════════════════════

final kA2Lessons = <LessonModel>[

  // ─────────────────────────────────────────────────────────────
  // Bİrim 1 — Êvara Baş: Şimdiki Zaman Tam Sistemi (3 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a2_l01',
    kurmanjTitle: 'Di-...-im: Şimdiki Zaman',
    turkishTitle: 'Şimdiki Zaman Sistemi',
    unitNumber: 1, lessonNumber: 1, level: 2,
    path: LessonPath.general,
    targetCardIds: _a2Cards(['silav', 'leker']).take(8).toList(),
    estimatedMinutes: 10,
    exercises: [
      _mc(id:'a2_l01_e1',
        ku:'Şimdiki zamanda fiil nasıl kurulur?',
        tr:'Doğru açıklamayı seç',
        opts:['Sadece kök kullanılır','di- + kök + kişi eki','Mastar + kişi eki','Kök + -a/-e'],
        ci:1, note:'"Di-xw-im" = yiyorum. Di + kök (xw) + im (1.tekil). [TH] §65'),
      _fill(id:'a2_l01_e2', before:'Ez nan', after:'.', tr:'Ben ekmek yiyorum.',
        opts:['xwim','dixwim','dixware','xwar'], ci:1,
        note:'"Di-" şimdiki ön eki + "xw" kök + "-im" 1.tekil = dixwim'),
      _fill(id:'a2_l01_e3', before:'Tu çay', after:'?', tr:'Sen çay içiyor musun?',
        opts:['vedixwî','vedixwim','vedixwe','vedixwîn'], ci:0,
        note:'"Tu" ile 2.tekil eki "-î": vedixwî. "Ve-di-xw-î"'),
      _fill(id:'a2_l01_e4', before:'Ew bi Kurmancî', after:'.', tr:'O Kurmancî konuşuyor.',
        opts:['dipeyivim','dipeyivî','dipeyive','dipeyivin'], ci:2,
        note:'"Ew" ile 3.tekil eki "-e": dipeyive'),
      _mc(id:'a2_l01_e5',
        ku:'"Em diçin" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Ben gidiyorum','Sen gidiyorsun','O gidiyor','Biz gidiyoruz'],
        ci:3, note:'"Em" = biz. 1.çoğul eki "-in": diçin'),
      _speak(id:'a2_l01_e6', ku:'Ez dixwim, tu vedixwî, ew dipeyive.',
        tr:'Ben yiyorum, sen içiyorsun, o konuşuyor.'),
    ],
  ),

  LessonModel(
    id: 'a2_l02',
    kurmanjTitle: 'Naçim! Olumsuzluk',
    turkishTitle: 'Olumsuz Cümleler',
    unitNumber: 1, lessonNumber: 2, level: 2,
    path: LessonPath.general,
    targetCardIds: _a2Cards(['neyekî']),
    estimatedMinutes: 10,
    exercises: [
      _mc(id:'a2_l02_e1',
        ku:'Şimdiki zamanda olumsuzluk nasıl yapılır?',
        tr:'Doğru kuralı seç',
        opts:['ne- öneki eklenir','na- öneki eklenir','Cümle sonuna "na" gelir','Fiil değişmez'],
        ci:1, note:'"Na-" şimdiki olumsuz: "Naçim" = gitmiyorum. [TH] §63'),
      _fill(id:'a2_l02_e2', before:'Ez', after:'bajêr.', tr:'Ben şehre gitmiyorum.',
        opts:['diçim','naçim','neçûm','naçe'], ci:1,
        note:'"Na-" + "çim" = naçim. "Di-" yerine "na-" gelir'),
      _fill(id:'a2_l02_e3', before:'Ew Kurmancî', after:'.', tr:'O Kurmancî bilmiyor.',
        opts:['dizane','naxwaze','nizane','naçe'], ci:2,
        note:'"Ni-zanim" → "nizane" (3.tekil). "Di-" → "ni-"'),
      _mc(id:'a2_l02_e4',
        ku:'Geçmiş zamanda olumsuzluk:',
        tr:'Doğru öneki seç',
        opts:['na-','ni-','ne-','bê-'], ci:2,
        note:'"Ne-" geçmiş zaman olumsuz: "Nehat" = gelmedi. [TH] §64'),
      _fill(id:'a2_l02_e5', before:'Pîrê duh', after:'.', tr:'Büyükanne dün gelmedi.',
        opts:['hat','dihat','nehat','nahat'], ci:2,
        note:'"Ne-" + geçmiş "hat" = "nehat". Dün = duh → geçmiş zaman'),
      _speak(id:'a2_l02_e6', ku:'Ez naçim. Nizanim. Nexwestim.',
        tr:'Gitmiyorum. Bilmiyorum. İstemedim.'),
    ],
  ),

  LessonModel(
    id: 'a2_l03',
    kurmanjTitle: 'Dê bêm: Gelecek Zaman',
    turkishTitle: 'Gelecek Zaman',
    unitNumber: 1, lessonNumber: 3, level: 2,
    path: LessonPath.general,
    targetCardIds: _a2Cards(['leker']).where((id) => id.startsWith('a2_03')).toList(),
    estimatedMinutes: 10,
    exercises: [
      _mc(id:'a2_l03_e1',
        ku:'Gelecek zaman nasıl yapılır?',
        tr:'Doğru yapıyı seç',
        opts:['Mastar + ê','dê + şimdiki zaman formu','Kök + -ê','Sadece dê'],
        ci:1, note:'"Dê" + şimdiki form: "Ew dê bê" = o gelecek. [BH] §185'),
      _fill(id:'a2_l03_e2', before:'Ez', after:'malê.', tr:'Ben eve gideceğim.',
        opts:['diçim','çûm','dê biçim','naçim'], ci:2,
        note:'"Dê biçim" = gideceğim. "Ezê biçim" de doğru'),
      _fill(id:'a2_l03_e3', before:'Pîrê sibê', after:'.', tr:'Büyükanne yarın gelecek.',
        opts:['tê','hat','dê bê','dihat'], ci:2,
        note:'"Dê bê" = gelecek (3.tekil). "Sibê" = yarın ile gelecek uyumlu'),
      _mc(id:'a2_l03_e4',
        ku:'"Dê nexwim" ne anlama gelir?',
        tr:'Doğru çeviriyi bul',
        opts:['Yiyeceğim','Yemiyorum','Yemedim','Yemeyeceğim'],
        ci:3, note:'"Dê" + "ne-" + şimdiki = gelecek olumsuz'),
      _speak(id:'a2_l03_e5', ku:'Sibê ez dê biçim bajêr. Tu dê bêyî?',
        tr:'Yarın şehre gideceğim. Sen gelecek misin?'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // Bİrim 2 — Bajêr: Şehir ve Yer (2 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a2_l04',
    kurmanjTitle: 'Li Bajêr',
    turkishTitle: 'Şehirde',
    unitNumber: 2, lessonNumber: 1, level: 2,
    path: LessonPath.general,
    targetCardIds: _a2Cards(['cih']).take(10).toList(),
    culturalRewardId: 'c_006',
    estimatedMinutes: 9,
    exercises: [
      _ls(id:'a2_l04_e1', ku:'Bazar', tr:'Ne anlama geliyor?',
        opts:['Hastane','Pazar/Çarşı','Okul','Park'], ci:1,
        audio:'assets/audio/a2/bazar.mp3'),
      _ls(id:'a2_l04_e2', ku:'Nexweşxane', tr:'Nereye gidilir?',
        opts:['Alışveriş için','Okul için','Hastaya gidilir','Park için'], ci:2,
        audio:'assets/audio/a2/nexwesxane.mp3'),
      _fill(id:'a2_l04_e3', before:'Mizgeft li', after:'ye.', tr:'Cami merkezde.',
        opts:['bajêr','gundê','navend','malê'], ci:2,
        note:'"Li navendê" = merkezde. Edat "li" + yer'),
      _mc(id:'a2_l04_e4',
        ku:'"Dermangeh" nedir?',
        tr:'Doğru tanımı bul',
        opts:['Hastane','Okul','Eczane','Karakol'],
        ci:2, note:'"Derman" (ilaç) + "-geh" (yer) = eczane'),
      _fill(id:'a2_l04_e5', before:'Em diçin', after:'.', tr:'Biz pazara gidiyoruz.',
        opts:['malê','bazarê','parkê','sinifê'], ci:1),
      _speak(id:'a2_l04_e6', ku:'Bazar li kû ye? Dermangeh li navendê ye.',
        tr:'Pazar nerede? Eczane merkezde.'),
    ],
  ),

  LessonModel(
    id: 'a2_l05',
    kurmanjTitle: 'Li Ser, Li Bin: Edatlar',
    turkishTitle: 'Yer Edatları',
    unitNumber: 2, lessonNumber: 2, level: 2,
    path: LessonPath.general,
    targetCardIds: _a2Cards(['daçek']),
    estimatedMinutes: 10,
    exercises: [
      _mc(id:'a2_l05_e1',
        ku:'"Li ser mêzê" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Masanın altında','Masanın yanında','Masanın üstünde','Masanın arkasında'],
        ci:2, note:'"Li ser" = üstünde. [TH] §40'),
      _mc(id:'a2_l05_e2',
        ku:'"Li bin kursiyê" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Sandalyenin üstünde','Sandalyenin altında','Sandalyenin önünde','Sandalyede'],
        ci:1, note:'"Li bin" = altında'),
      _fill(id:'a2_l05_e3', before:'Pirtûk', after:'mêzê ye.', tr:'Kitap masanın üstünde.',
        opts:['li ser','li bin','li pêş','li paş'], ci:0),
      _fill(id:'a2_l05_e4', before:'Kedî', after:'kursiyê ye.', tr:'Kedi sandalyenin altında.',
        opts:['li ser','li bin','li kêlekê','li cem'], ci:1),
      _mc(id:'a2_l05_e5',
        ku:'"Di navbera mal û bazarê de" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Ev ve pazarın üstünde','Ev ile pazar arasında','Evden pazara kadar','Evden sonra pazar'],
        ci:1, note:'"Di navbera … de" = arasında. [TH] §42'),
      _speak(id:'a2_l05_e6', ku:'Pirtûk li ser mêzê ye. Kedî li bin kursiyê ye.',
        tr:'Kitap masanın üstünde. Kedi sandalyenin altında.'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // Bİrim 3 — Rêwîtî: Seyahat (2 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a2_l06',
    kurmanjTitle: 'Bi Basê Diçim',
    turkishTitle: 'Otobüsle Gidiyorum',
    unitNumber: 3, lessonNumber: 1, level: 2,
    path: LessonPath.general,
    targetCardIds: _a2Cards(['rêwîtî']).take(8).toList(),
    estimatedMinutes: 9,
    exercises: [
      _ls(id:'a2_l06_e1', ku:'Balafirgeh', tr:'Ne anlama gelir?',
        opts:['Otobüs durağı','Tren garı','Havalimanı','Liman'], ci:2,
        audio:'assets/audio/a2/balafirgeh.mp3'),
      _mc(id:'a2_l06_e2',
        ku:'"Bilet bi çendê ye?" sorusu nerede sorulur?',
        tr:'Doğru bağlamı seç',
        opts:['Hastanede','Bilet gişesinde','Markette','Okul'], ci:1),
      _fill(id:'a2_l06_e3', before:'Ez bi', after:'diçim bajêr.', tr:'Otobüsle şehre gidiyorum.',
        opts:['erebe','basê','balafirê','trênê'], ci:1,
        note:'"Bi basê" = otobüsle. "Bi erebe" = arabayla'),
      _fill(id:'a2_l06_e4', before:'Rêwîtî kengî', after:'?', tr:'Balafir kengî?',
        opts:['ye','e','tê','diçe'], ci:0),
      _speak(id:'a2_l06_e5', ku:'Bilet dixwazim. Balafir kengî difire?',
        tr:'Bilet istiyorum. Balafir kengî?'),
    ],
  ),

  LessonModel(
    id: 'a2_l07',
    kurmanjTitle: 'Rêwîtiya Baş!',
    turkishTitle: 'İyi Yolculuklar!',
    unitNumber: 3, lessonNumber: 2, level: 2,
    path: LessonPath.heritage,
    targetCardIds: _a2Cards(['rêwîtî']).skip(3).toList(),
    estimatedMinutes: 9,
    exercises: [
      _mc(id:'a2_l07_e1',
        ku:'Birine veda ederken ne dersin?',
        tr:'Doğru seçeneği bul',
        opts:['Bi xêr hatî','Seferê te baş be','Destê te xweş be','Nûş be'],
        ci:1, note:'"Seferê te baş be!" = iyi yolculuklar (veda selâmı)'),
      _fill(id:'a2_l07_e2', before:'Pasaport û bilet', after:'?', tr:'Pasaport ve bilet hazır mı?',
        opts:['hatin','amade ne','ne','têne'], ci:1),
      _mc(id:'a2_l07_e3',
        ku:'"Rêwîtî" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Yolcu','Yolculuk/Seyahat','Yol','Uçak'], ci:1),
      _speak(id:'a2_l07_e4', ku:'Rêwîtiya te baş be! Xweş here û were!',
        tr:'Yolculuğun güzel olsun! Seferin iyi olsun!'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // Bİrim 4 — Malbat û Civak: Aile ve Sosyal Hayat (2 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a2_l08',
    kurmanjTitle: 'Zewac û Malbat',
    turkishTitle: 'Evlilik ve Aile',
    unitNumber: 4, lessonNumber: 1, level: 2,
    path: LessonPath.heritage,
    targetCardIds: _a2Cards(['malbat']),
    culturalRewardId: 'c_002',
    estimatedMinutes: 9,
    exercises: [
      _ls(id:'a2_l08_e1', ku:'Zewicîn', tr:'Ne anlama gelir?',
        opts:['Boşanmak','Evlenmek','Nişanlanmak','Buluşmak'], ci:1),
      _mc(id:'a2_l08_e2',
        ku:'"Zewacê we pîroz be!" ne zaman söylenir?',
        tr:'Doğru bağlamı seç',
        opts:['Hastalıkta','Düğünde','Cenazen\'de','Yemekte'],
        ci:1, note:'"Pîroz be" = kutlu olsun. Düğün kutlaması'),
      _fill(id:'a2_l08_e3', before:'Zarokên', after:'çend in?', tr:'Çocukların kaç tane?',
        opts:['min','me','te','we'], ci:2,
        note:'"Zarokên te" = senin çocukların (ezafe + eğik)'),
      _mc(id:'a2_l08_e4',
        ku:'"Kurik" ve "keçik" farkı nedir?',
        tr:'Doğru çifti seç',
        opts:['İkisi de çocuk','Kurik = erkek çocuk, keçik = kız çocuk','Tersine','Yaşla ilgili'],
        ci:1),
      _speak(id:'a2_l08_e5', ku:'Birê min zewicî. Zewacê wan pîroz be!',
        tr:'Erkek kardeşim evlendi. Düğünleri kutlu olsun!'),
    ],
  ),

  LessonModel(
    id: 'a2_l09',
    kurmanjTitle: 'Arîkarî û Hevkarî',
    turkishTitle: 'Yardım ve Dayanışma',
    unitNumber: 4, lessonNumber: 2, level: 2,
    path: LessonPath.general,
    targetCardIds: _a2Cards(['civakî']).take(10).toList(),
    estimatedMinutes: 9,
    exercises: [
      _ls(id:'a2_l09_e1', ku:'Ji kerema xwe', tr:'Ne anlama gelir?',
        opts:['Teşekkürler','Lütfen','Özür dilerim','Tamam'], ci:1,
        audio:'assets/audio/a2/ji_kerema_xwe.mp3'),
      _fill(id:'a2_l09_e2', before:'', after:', arîkariyê bike.', tr:'Lütfen yardım et.',
        opts:['Spas','Bibore','Ji kerema xwe','Erê'], ci:2),
      _mc(id:'a2_l09_e3',
        ku:'"Bi hev re" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Yalnız','Birlikte','Ayrı ayrı','Bazen'],
        ci:1, note:'"Bi hev re" = birlikte — Kürt kültüründe hevkarî değeri'),
      _fill(id:'a2_l09_e4', before:'Arîkariya', after:'lazim e?', tr:'Yardıma ihtiyacın var mı?',
        opts:['min','te','wî','me'], ci:1),
      _speak(id:'a2_l09_e5', ku:'Ji kerema xwe, arîkariyê bike. Bi hev re baş e.',
        tr:'Lütfen yardım et. Birlikte daha iyi.'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // Bİrim 5 — Rewşa Hewayê: Hava (1 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a2_l10',
    kurmanjTitle: 'Hewa Çawa Ye?',
    turkishTitle: 'Hava Nasıl?',
    unitNumber: 5, lessonNumber: 1, level: 2,
    path: LessonPath.general,
    targetCardIds: _a2Cards(['hewa']),
    culturalRewardId: 'c_newroz',
    estimatedMinutes: 9,
    exercises: [
      _mc(id:'a2_l10_e1',
        ku:'"Hewa ewrî ye" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Hava sıcak','Hava soğuk','Hava bulutlu','Hava güneşli'],
        ci:2, note:'"Ewrî" = bulutlu sıfatı'),
      _fill(id:'a2_l10_e2', before:'Derve baran', after:',nekeve.', tr:'Dışarıda yağmur yağıyor, çıkma.',
        opts:['dibe','dibare','dihat','dikeve'], ci:1,
        note:'"Baran dibare" = yağmur yağıyor. Sabit ifade'),
      _mc(id:'a2_l10_e3',
        ku:'Mevsime göre hangi hava beklenir?',
        tr:'Doğru eşleştirmeyi seç',
        opts:['Zivistan = germ','Bihar = sar','Havîn = germ','Payîz = berf'],
        ci:2, note:'"Havîn" = yaz → "germ" (sıcak). Mantıklı eşleştirme'),
      _fill(id:'a2_l10_e4', before:'Tav', after:',em diçin derve.', tr:'Güneş vuruyor, dışarı gidiyoruz.',
        opts:['dibare','dide','diçe','dihê'], ci:1),
      _speak(id:'a2_l10_e5', ku:'Hewa çawa ye? Baran dibare û sar e.',
        tr:'Hava nasıl? Yağmur yağıyor ve soğuk.'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // Bİrim 6 — Kirîn û Firotin: Alışveriş (2 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a2_l11',
    kurmanjTitle: 'Li Bazarê',
    turkishTitle: 'Pazarda',
    unitNumber: 6, lessonNumber: 1, level: 2,
    path: LessonPath.heritage,
    targetCardIds: _a2Cards(['bazirganî']).take(8).toList(),
    culturalRewardId: 'c_004',
    estimatedMinutes: 10,
    exercises: [
      _ls(id:'a2_l11_e1', ku:'Ev bi çendê ye?', tr:'Bu ne anlama gelir?',
        opts:['Bu güzel','Bu kaç kilo?','Bu ne kadar?','Bu nerede?'], ci:2,
        audio:'assets/audio/a2/bi_cende.mp3'),
      _mc(id:'a2_l11_e2',
        ku:'"Erzan" ve "giran" zıt mı?',
        tr:'Doğru cevabı seç',
        opts:['Evet — ucuz/pahalı','Hayır — ikisi de ucuz','Evet — büyük/küçük','Hayır — aynı'],
        ci:0, note:'"Erzan" = ucuz. "Giran/biha" = pahalı. Zıt anlamlı'),
      _fill(id:'a2_l11_e3', before:'Du kîlo nan', after:'?', tr:'İki kilo ekmek ne kadar?',
        opts:['bi çendê ye','çawa ye','kî ye','ku ye'], ci:0),
      _fill(id:'a2_l11_e4', before:'Pareyên min', after:'.', tr:'Param yok.',
        opts:['hene','nîne','heye','tune ye'], ci:1,
        note:'"Nîne" = yok. "Tu malbat nîne" veya kısaca "nîne"'),
      _speak(id:'a2_l11_e5', ku:'Ev bi çendê ye? Pir giran e! Erzan bike.',
        tr:'Bu ne kadar? Çok pahalı! Ucuzlat.'),
    ],
  ),

  LessonModel(
    id: 'a2_l12',
    kurmanjTitle: 'Cil û Berg Dikirin',
    turkishTitle: 'Kıyafet Alışverişi',
    unitNumber: 6, lessonNumber: 2, level: 2,
    path: LessonPath.general,
    targetCardIds: _a2Cards(['cil']),
    estimatedMinutes: 9,
    exercises: [
      _ls(id:'a2_l12_e1', ku:'Kiras', tr:'Ne anlama gelir?',
        opts:['Pantolon','Çorap','Gömlek/Elbise','Ayakkabı'], ci:2,
        audio:'assets/audio/a2/kiras.mp3'),
      _mc(id:'a2_l12_e2',
        ku:'"Kêlav" ne demek?',
        tr:'Doğru çeviriyi bul',
        opts:['Çorap','Ayakkabı','Şapka','Ceket'], ci:1),
      _fill(id:'a2_l12_e3', before:'Kirasê', after:'çi reng e?', tr:'Gömleğin rengi ne?',
        opts:['te','min','wî','me'], ci:0),
      _mc(id:'a2_l12_e4',
        ku:'"Cil û berg" ne demek?',
        tr:'Doğru çeviriyi seç',
        opts:['Sadece gömlek','Kıyafet/Elbise (genel)','Sadece pantolon','Ayakkabı'],
        ci:1, note:'"Cil û berg" = kıyafetler genel. [AS] s.54 başlığı'),
      _speak(id:'a2_l12_e5', ku:'Ez kirasekî nû dixwazim. Ev bi çendê ye?',
        tr:'Yeni bir gömlek istiyorum. Bu ne kadar?'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // Bİrim 7 — Xwarin û Restoran (2 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a2_l13',
    kurmanjTitle: 'Li Restoranê',
    turkishTitle: 'Restoranda',
    unitNumber: 7, lessonNumber: 1, level: 2,
    path: LessonPath.heritage,
    targetCardIds: _a2Cards(['jiyan']).take(6).toList(),
    estimatedMinutes: 10,
    exercises: [
      _mc(id:'a2_l13_e1',
        ku:'Restorana sipariş etmek için ne dersin?',
        tr:'Doğru ifadeyi seç',
        opts:['Nûş be!','Ez dixwazim…','Destê te xweş be!','Werin!'],
        ci:1, note:'"Ez dixwazim…" = istiyorum. Sipariş için temel ifade'),
      _fill(id:'a2_l13_e2', before:'Ez', after:'goştekî dixwazim.', tr:'Ben bir et yemeği istiyorum.',
        opts:['ji','ji bo','li','bi'], ci:1,
        note:'"Ji bo min" = benim için. "Ji bo" = için'),
      _mc(id:'a2_l13_e3',
        ku:'"Nûş be" ne zaman söylenir?',
        tr:'Doğru bağlamı seç',
        opts:['Yemekten önce','Düğünde','Yemekten sonra','Sabah'],
        ci:2, note:'"Nûş be" = afiyet olsun (yemek sonrası)'),
      _fill(id:'a2_l13_e4', before:'Av', after:'lazim e.', tr:'Su lazım.',
        opts:['jî','jî','û','pir'], ci:0,
        note:'Basit talep: "Av lazim e" yeterli'),
      _speak(id:'a2_l13_e5', ku:'Ez goştekî û şorbeyekî dixwazim. Spas!',
        tr:'Bir et ve bir çorba istiyorum. Teşekkürler!'),
    ],
  ),

  LessonModel(
    id: 'a2_l14',
    kurmanjTitle: 'Xwarin Çêkirin',
    turkishTitle: 'Yemek Yapma',
    unitNumber: 7, lessonNumber: 2, level: 2,
    path: LessonPath.heritage,
    targetCardIds: _a2Cards(['jiyan']).skip(3).toList(),
    culturalRewardId: 'c_004',
    estimatedMinutes: 9,
    exercises: [
      _mc(id:'a2_l14_e1',
        ku:'"Xwarin çêkirin" ne demek?',
        tr:'Doğru çeviriyi seç',
        opts:['Yemek yemek','Yemek yapmak','Yemek satmak','Yemek istemek'],
        ci:1, note:'"Çêkirin" = yapmak/hazırlamak'),
      _fill(id:'a2_l14_e2', before:'Dêya min her êvarê xwarin', after:'.', tr:'Annem her akşam yemek yapıyor.',
        opts:['çêdike','çêkir','dixwe','difroşe'], ci:0),
      _mc(id:'a2_l14_e3',
        ku:'"Malê paqij kirin" ne demek?',
        tr:'Doğru çeviriyi bul',
        opts:['Ev kiralamak','Ev temizlemek','Ev satmak','Eve girmek'],
        ci:1),
      _fill(id:'a2_l14_e4', before:'Sibê ez', after:'dikim.', tr:'Yarın ev temizleyeceğim.',
        opts:['malê paqij','xwarin çê','kar','rêwîtî'], ci:0),
      _speak(id:'a2_l14_e5', ku:'Dêya min xwarin çêdike. Destê te xweş be, dayê!',
        tr:'Annem yemek yapıyor. Elinize sağlık anneciğim!'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // Bİrim 8 — ERGATIF — A2 KRİTİK KONUSU (3 ders)
  // [BH] §170–180 + [TH] §75–80
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a2_l15',
    kurmanjTitle: 'Min Xwar — Ergatif Giriş',
    turkishTitle: 'Ergatif Yapı: Geçişli Geçmiş',
    unitNumber: 8, lessonNumber: 1, level: 2,
    path: LessonPath.general,
    targetCardIds: _a2Cards(['ergatif']),
    estimatedMinutes: 12,
    exercises: [
      _mc(id:'a2_l15_e1',
        ku:'Geçişsiz geçmişte özne hangi halde?',
        tr:'Doğru açıklamayı seç',
        opts:['Eğik halde','Yalın halde','Her ikisinde','Değişmez'],
        ci:1, note:'"Ew hat" = o geldi. Geçişsiz fiilde özne yalın halde. [BH] §170'),
      _mc(id:'a2_l15_e2',
        ku:'GEÇİŞLİ geçmişte özne hangi halde?',
        tr:'Doğru açıklamayı seç',
        opts:['Yalın halde','Eğik halde','Soru ekiyle','Değişmez'],
        ci:1, note:'KRİTİK: "Min nan xwar" = ben ekmek yedim. Min = ez\'nin EĞİK hali. [BH] §170'),
      _fill(id:'a2_l15_e3', before:'', after:'nan xwar.', tr:'Ben ekmek yedim.',
        opts:['Ez','Min','Me','Te'], ci:1,
        note:'"Xwar" = yedi — geçişli fiil. Özne EĞİK hale girer: Ez → Min'),
      _fill(id:'a2_l15_e4', before:'', after:'çi got?', tr:'Sen ne dedin?',
        opts:['Tu','Te','Ti','Ta'], ci:1,
        note:'"Got" = dedi — geçişli. Tu → Te (eğik hali)'),
      _mc(id:'a2_l15_e5',
        ku:'"Wî pirtûk xwand" cümlesinde "wî" neden?',
        tr:'Doğru açıklamayı seç',
        opts:['Yanlış — ew olmalı','Ew\'in eğik hali — geçişli geçmiş','Çoğul için','Dişil için'],
        ci:1, note:'"Wî" = "ew"in eğik hali (eril). "Xwand" geçişli → ergatif zorunlu'),
      _speak(id:'a2_l15_e6', ku:'Min nan xwar. Te çi xwar? Wî got.',
        tr:'Ben ekmek yedim. Sen ne yedin? O dedi.'),
    ],
  ),

  LessonModel(
    id: 'a2_l16',
    kurmanjTitle: 'Wê Got — Ergatif Pratik',
    turkishTitle: 'Ergatif Alıştırmaları',
    unitNumber: 8, lessonNumber: 2, level: 2,
    path: LessonPath.heritage,
    targetCardIds: _a2Cards(['ergatif']),
    estimatedMinutes: 12,
    exercises: [
      _fill(id:'a2_l16_e1', before:'Pîrêya min', after:'lorî got.', tr:'Büyükannem ninni söyledi.',
        opts:['wê','ew','wî','me'], ci:0,
        note:'"Pîrê" dişil → eğik hali "wê". "Got" = söyledi (geçişli)'),
      _fill(id:'a2_l16_e2', before:'', after:'çay vexwar.', tr:'Ben çay içtim.',
        opts:['Ez','Min','Me','Te'], ci:1,
        note:'"Vexwar" = içti (geçişli) → özne eğik: Ez → Min'),
      _mc(id:'a2_l16_e3',
        ku:'"Me pîrê dît" doğru mu?',
        tr:'Dilbilgisel kontrolü yap',
        opts:['Hayır — em olmalı','Evet — me = em\'in eğik hali','Hayır — min olmalı','Evet ama eksik'],
        ci:1, note:'"Me" = "em"in eğik hali. "Dît" = gördü (geçişli) → ergatif'),
      _fill(id:'a2_l16_e4', before:'', after:'navê xwe got.', tr:'O (dişil) adını söyledi.',
        opts:['Ew','Wê','Wî','Me'], ci:1),
      _speak(id:'a2_l16_e5', ku:'Min got, te bîst, wê kir!',
        tr:'Ben söyledim, sen duydun, o yaptı!'),
    ],
  ),

  LessonModel(
    id: 'a2_l17',
    kurmanjTitle: 'Wext û Dem — Zaman İfadeleri',
    turkishTitle: 'Zaman Zarfları',
    unitNumber: 8, lessonNumber: 3, level: 2,
    path: LessonPath.general,
    targetCardIds: _a2Cards(['dem']),
    estimatedMinutes: 10,
    exercises: [
      _mc(id:'a2_l17_e1',
        ku:'"Par" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Bu yıl','Geçen yıl','Gelecek yıl','Bu ay'],
        ci:1, note:'"Par" = geçen yıl. "Îsal" = bu yıl'),
      _mc(id:'a2_l17_e2',
        ku:'"Piştî xwarinê" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Yemekten önce','Yemek sırasında','Yemekten sonra','Yemek yerine'],
        ci:2, note:'"Piştî" = sonra. "Piştî xwarinê" = yemekten sonra'),
      _fill(id:'a2_l17_e3', before:'', after:'xwarinê dest bişo.', tr:'Yemekten önce el yıka.',
        opts:['Piştî','Berî','Dema','Heta'], ci:1,
        note:'"Berî" = önce. "Berî xwarinê" = yemekten önce'),
      _fill(id:'a2_l17_e4', before:'', after:'ez li malê me.', tr:'Şu an evdeyim.',
        opts:['Berê','Par','Niha','Sala bê'], ci:2),
      _speak(id:'a2_l17_e5', ku:'Berê li gundê dijiyam. Niha li bajêr im.',
        tr:'Eskiden köyde yaşıyordum. Şimdi şehirdeyim.'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // Bİrim 9 — Tenduristî: Sağlık (2 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a2_l18',
    kurmanjTitle: 'Bijîşkê Min',
    turkishTitle: 'Doktorum',
    unitNumber: 9, lessonNumber: 1, level: 2,
    path: LessonPath.general,
    targetCardIds: _a2Cards(['tendurist']).take(8).toList(),
    culturalRewardId: 'c_009',
    estimatedMinutes: 10,
    exercises: [
      _ls(id:'a2_l18_e1', ku:'Serêşî', tr:'Ne anlama gelir?',
        opts:['Mide ağrısı','Baş ağrısı','Sırt ağrısı','Ateş'], ci:1,
        audio:'assets/audio/a2/sereesi.mp3',
        note:'"Ser" (baş) + "êşî" (ağrı) = serêşî'),
      _mc(id:'a2_l18_e2',
        ku:'"Germahiya min heye" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Hava sıcak','Ateşim var','Çok sıcağım','Isınmak istiyorum'],
        ci:1, note:'"Germahî" = ateş (hastalık). [BH] bileşik: germ + -ahî'),
      _fill(id:'a2_l18_e3', before:'Bijîşk', after:'da min.', tr:'Doktor ilaç verdi.',
        opts:['xwarin','derman','arîkarî','bilet'], ci:1,
        note:'"Derman" = ilaç. "Da" = verdi (geçmiş, geçişli → ergatif: "bijîşk" aktör)'),
      _mc(id:'a2_l18_e4',
        ku:'Doktora cümlesi: "Ji penîsîlînê re alerjiya min heye" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['İlaç istiyorum','Penisiline alerjim var','Penisiline ihtiyacım var','İyi değilim'],
        ci:1, note:'[AS] s.35\'te öne çıkan cümle'),
      _speak(id:'a2_l18_e5', ku:'Bijîşk, serêşiya min heye û germahî jî heye.',
        tr:'Doktor, baş ağrım var ve ateşim de var.'),
    ],
  ),

  LessonModel(
    id: 'a2_l19',
    kurmanjTitle: 'Laş û Êş',
    turkishTitle: 'Beden ve Ağrı',
    unitNumber: 9, lessonNumber: 2, level: 2,
    path: LessonPath.general,
    targetCardIds: _a2Cards(['beden', 'tendurist']).take(10).toList(),
    estimatedMinutes: 10,
    exercises: [
      _mc(id:'a2_l19_e1',
        ku:'"Lingê min diêşe" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Elim ağrıyor','Sırtım ağrıyor','Ayağım/Bacağım ağrıyor','Başım ağrıyor'],
        ci:2, note:'"Lingê min" = ayağım/bacağım. "Diêşe" = ağrıyor'),
      _fill(id:'a2_l19_e2', before:'', after:'min diêşe.', tr:'Sırtım ağrıyor.',
        opts:['Lingê','Piştê','Milê','Guhê'], ci:1),
      _mc(id:'a2_l19_e3',
        ku:'"Zirav" ve "qelew" zıt mı?',
        tr:'Doğru cevabı seç',
        opts:['Evet — ince/şişman','Hayır — ikisi de ince','Evet — kısa/uzun','Hayır'],
        ci:0),
      _fill(id:'a2_l19_e4', before:'Ew gelek', after:'ye, lê ez zirav im.', tr:'O çok şişman ama ben inceyim.',
        opts:['bilind','qelew','kovan','germ'], ci:1),
      _speak(id:'a2_l19_e5', ku:'Piştê min diêşe. Bijîşk lazim e.',
        tr:'Sırtım ağrıyor. Doktor lazım.'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // Bİrim 10 — Kar û Perwerde: İş ve Eğitim (2 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a2_l20',
    kurmanjTitle: 'Li Xwendegehê',
    turkishTitle: 'Okulda',
    unitNumber: 10, lessonNumber: 1, level: 2,
    path: LessonPath.general,
    targetCardIds: _a2Cards(['perwerde']),
    culturalRewardId: 'c_008',
    estimatedMinutes: 10,
    exercises: [
      _mc(id:'a2_l20_e1',
        ku:'"Hîn bûn" ile "fêr bûn" farkı nedir?',
        tr:'Doğru açıklamayı seç',
        opts:['Aynı anlam','Hîn bûn = öğrenmek, fêr bûn = alışmak','Tersine','İkisi de alışmak'],
        ci:1, note:'"Hîn bûn" = öğrenmek. "Fêr bûn" = alışmak/öğrenmek (pratikle)'),
      _fill(id:'a2_l20_e2', before:'Sibê', after:'min heye.', tr:'Yarın sınavım var.',
        opts:['wane','îmtîhan','sinif','pirtûk'], ci:1),
      _mc(id:'a2_l20_e3',
        ku:'"Kîtêb" ile "pirtûk" farkı nedir?',
        tr:'Doğru açıklamayı seç',
        opts:['İkisi de kitap — pirtûk daha yaygın','Kîtêb daha yaygın','Tamamen farklı anlam','Biri küçük diğeri büyük'],
        ci:0, note:'"Kîtêb" klasik form, "pirtûk" günlük kullanım'),
      _fill(id:'a2_l20_e4', before:'Ez Kurmancî', after:'.', tr:'Ben Kurmancî öğreniyorum.',
        opts:['hîn dibim','fêr dibim','hîn bûm','fêr bûm'], ci:0,
        note:'"Hîn dibim" = öğreniyorum (şimdiki zaman)'),
      _speak(id:'a2_l20_e5', ku:'Ez Kurmancî hîn dibim û gelek kêfxweş im!',
        tr:'Kurmancî öğreniyorum ve çok mutluyum!'),
    ],
  ),

  LessonModel(
    id: 'a2_l21',
    kurmanjTitle: 'Li Karê Min',
    turkishTitle: 'İşimde',
    unitNumber: 10, lessonNumber: 2, level: 2,
    path: LessonPath.general,
    targetCardIds: _a2Cards(['kar']),
    estimatedMinutes: 9,
    exercises: [
      _mc(id:'a2_l21_e1',
        ku:'"Tu li kû dixebitî?" sorusu ne soruyor?',
        tr:'Doğru anlamı seç',
        opts:['Ne iş yapıyorsun?','Nerede çalışıyorsun?','Kaç saat çalışıyorsun?','Neden çalışıyorsun?'],
        ci:1),
      _fill(id:'a2_l21_e2', before:'Ez li şirketekê', after:'.', tr:'Bir şirkette çalışıyorum.',
        opts:['dixwim','dixebitem','dixwazim','diçim'], ci:1),
      _mc(id:'a2_l21_e3',
        ku:'"Serbixwe dixebite" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Çok çalışıyor','Serbest/Freelance çalışıyor','Şirkette çalışıyor','Çalışmıyor'],
        ci:1),
      _fill(id:'a2_l21_e4', before:'Mûçeya', after:'kêm e.', tr:'Maaşım az.',
        opts:['te','min','me','wî'], ci:1),
      _speak(id:'a2_l21_e5', ku:'Ez serbixwe dixebitem. Karê min baş e.',
        tr:'Serbest çalışıyorum. İşim iyi.'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // Bİrim 11 — Duygu ve İfade (2 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a2_l22',
    kurmanjTitle: 'Ez Şa Me!',
    turkishTitle: 'Ben Mutluyum!',
    unitNumber: 11, lessonNumber: 1, level: 2,
    path: LessonPath.heritage,
    targetCardIds: _a2Cards(['his']).take(8).toList(),
    estimatedMinutes: 9,
    exercises: [
      _ls(id:'a2_l22_e1', ku:'Şa', tr:'Ne anlama gelir?',
        opts:['Üzgün','Korkmuş','Mutlu/Sevinçli','Yorgun'], ci:2,
        audio:'assets/audio/a2/sha.mp3'),
      _ls(id:'a2_l22_e2', ku:'Kovan', tr:'Ne anlama gelir?',
        opts:['Mutlu','Üzgün','Kızgın','Şaşkın'], ci:1,
        audio:'assets/audio/a2/kovan.mp3'),
      _mc(id:'a2_l22_e3',
        ku:'"Xemgîn" kelimesinin anlamı?',
        tr:'Doğru çeviriyi bul',
        opts:['Mutlu','Kederli/Hüzünlü','Heyecanlı','Yorgun'],
        ci:1, note:'"Xem" (keder) + "-gîn" (dolu). Kürt şiirinin temel kelimesi'),
      _fill(id:'a2_l22_e4', before:'Ez gelek', after:'ku pîrê hat!', tr:'Büyükanne geldiği için çok mutluyum!',
        opts:['kovan im','şa me','xemgîn im','ditirsim'], ci:1),
      _speak(id:'a2_l22_e5', ku:'Ez şa me! Pîrê hat û em bi hev re ne.',
        tr:'Mutluyum! Büyükanne geldi ve birlikteyiz.'),
    ],
  ),

  LessonModel(
    id: 'a2_l23',
    kurmanjTitle: 'Hêvî û Tirs',
    turkishTitle: 'Umut ve Korku',
    unitNumber: 11, lessonNumber: 2, level: 2,
    path: LessonPath.general,
    targetCardIds: _a2Cards(['his']).skip(4).toList(),
    estimatedMinutes: 9,
    exercises: [
      _mc(id:'a2_l23_e1',
        ku:'"Hêviya min heye" ne anlama gelir?',
        tr:'Doğru çeviriyi seç',
        opts:['Korkum var','Umudum var','Planım var','Yardımım var'],
        ci:1),
      _fill(id:'a2_l23_e2', before:'Ez ji', after:'ditirsim.', tr:'Kurttan korkuyorum.',
        opts:['keçikan','guran','bilbilan','roviya'], ci:1,
        note:'"Ji guran ditirsim" = kurtlardan korkuyorum. Ji + isim + ditirsim'),
      _mc(id:'a2_l23_e3',
        ku:'"Bê hêvî nebe!" ne demek?',
        tr:'Doğru çeviriyi seç',
        opts:['Umutlu ol!','Umutsuz olma!','Korkma!','Üzülme!'],
        ci:1, note:'"Bê" = -siz/sız. "Bê hêvî" = umutsuz. "Nebe" = olma'),
      _speak(id:'a2_l23_e4', ku:'Hêviya min heye. Bê hêvî nebe!',
        tr:'Umudum var. Umutsuz olma!'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // Bİrim 12 — Karşılaştırma (1 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a2_l24',
    kurmanjTitle: 'Baştir û Baştirîn',
    turkishTitle: 'Daha İyi ve En İyi',
    unitNumber: 12, lessonNumber: 1, level: 2,
    path: LessonPath.general,
    targetCardIds: _a2Cards(['rengder']),
    estimatedMinutes: 10,
    exercises: [
      _mc(id:'a2_l24_e1',
        ku:'Karşılaştırma eki nedir?',
        tr:'Doğru eki seç',
        opts:['-tir','-tirîn','-kî','-ek'],
        ci:0, note:'"Baş" → "baştir" (daha iyi). "-tir" karşılaştırma. [BH] §58'),
      _mc(id:'a2_l24_e2',
        ku:'Üstünlük eki nedir?',
        tr:'Doğru eki seç',
        opts:['-tir','-tirîn','-an','-ek'],
        ci:1, note:'"Baş" → "baştirîn" (en iyi). "-tirîn" üstünlük'),
      _fill(id:'a2_l24_e3', before:'Ev xanî', after:'e.', tr:'Bu ev daha büyük.',
        opts:['mezin','mezintir','mezintirîn','pir mezin'], ci:1),
      _fill(id:'a2_l24_e4', before:'Tu xwendekarê', after:'î!', tr:'Sen en iyi öğrencisin!',
        opts:['baş','baştir','baştirîn','pir baş'], ci:2),
      _mc(id:'a2_l24_e5',
        ku:'Kurmancîde sıfatlar nasıl derecelendirilir?',
        tr:'Doğru açıklamayı seç',
        opts:['Önüne "pir" gelir sadece','Önüne "daha" gelir','Sona -tir/-tirîn eklenir','Değişmez'],
        ci:2),
      _speak(id:'a2_l24_e6', ku:'Ev baştir e! Û tu baştirîn î!',
        tr:'Bu daha iyi! Ve sen en iyisin!'),
    ],
  ),

  // ─────────────────────────────────────────────────────────────
  // Bİrim 13 — Kültür ve Edebiyat (1 ders)
  // ─────────────────────────────────────────────────────────────

  LessonModel(
    id: 'a2_l25',
    kurmanjTitle: 'Wêje û Çand',
    turkishTitle: 'Edebiyat ve Kültür',
    unitNumber: 13, lessonNumber: 1, level: 2,
    path: LessonPath.heritage,
    targetCardIds: _a2Cards(['çand']),
    culturalRewardId: 'c_a2_001',
    estimatedMinutes: 10,
    exercises: [
      _ls(id:'a2_l25_e1', ku:'Stran', tr:'Ne anlama gelir?',
        opts:['Kitap','Şarkı/Türkü','Şiir','Hikaye'], ci:1,
        audio:'assets/audio/a2/stran.mp3',
        note:'Dişil — [BH] p.56: "Stran, şarkı : stranê, stranan"'),
      _ls(id:'a2_l25_e2', ku:'Dengbêj', tr:'Kim/Ne demek?',
        opts:['Okuyucu','Halk ozanı/Dengbêj','Şair','Öğretmen'], ci:1,
        audio:'assets/audio/a2/dengbej.mp3'),
      _mc(id:'a2_l25_e3',
        ku:'"Wêje" ne demek?',
        tr:'Doğru çeviriyi seç',
        opts:['Müzik','Edebiyat','Resim','Dans'],
        ci:1),
      _mc(id:'a2_l25_e4',
        ku:'Cegerxwîn kimdir?',
        tr:'Doğru açıklamayı seç',
        opts:['Kürt başkanı','Ünlü Kürt şairi (1903–1984)','Dengbêj','Bedir Han\'ın kardeşi'],
        ci:1, note:'Cegerxwîn = modern Kurmancî şiirinin öncüsü'),
      _speak(id:'a2_l25_e5', ku:'Ez stranên kurdî hez dikim. Dengbêj gelek girîng e.',
        tr:'Kürt türkülerini seviyorum. Dengbêj çok önemlidir.'),
    ],
  ),

]; // kA2Lessons son

// ── Yardımcı ─────────────────────────────────────────────────────
LessonModel? getA2LessonById(String id) {
  try { return kA2Lessons.firstWhere((l) => l.id == id); }
  catch (_) { return null; }
}
List<LessonModel> getA2LessonsForUnit(int unit) =>
    kA2Lessons.where((l) => l.unitNumber == unit).toList();
