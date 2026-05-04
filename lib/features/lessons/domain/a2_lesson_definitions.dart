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
        ku:'Di dema niha de lêker çawa çêdibe?',
        tr:'Doğru açıklamayı seç',
        opts:['di- + rayek + paşgira kes','Tenê rayek tê bikar anîn','Raveker + paşgira kes','Rayek + -a/-e'],
        ci: 0, note:'"Di-xw-im" = yiyorum. Di + kök (xw) + im (1.tekil). [TH] §65'),
      _fill(id:'a2_l01_e2', before:'Ez nan', after:'.', tr:'Ben ekmek yiyorum.',
        opts:['xwar','dixware','xwim','dixwim'], ci: 3,
        note:'"Di-" şimdiki ön eki + "xw" kök + "-im" 1.tekil = dixwim'),
      _fill(id:'a2_l01_e3', before:'Tu çay', after:'?', tr:'Sen çay içiyor musun?',
        opts:['vedixwî','vedixwîn','vedixwim','vedixwe'], ci: 0,
        note:'"Tu" ile 2.tekil eki "-î": vedixwî. "Ve-di-xw-î"'),
      _fill(id:'a2_l01_e4', before:'Ew bi Kurmancî', after:'.', tr:'O Kurmancî konuşuyor.',
        opts:['dipeyivin','dipeyivî','dipeyive','dipeyivim'], ci: 2,
        note:'"Ew" ile 3.tekil eki "-e": dipeyive'),
      _mc(id:'a2_l01_e5',
        ku:'"Em diçin" çi wateyê dide?',
        tr:'Doğru çeviriyi seç',
        opts:['Biz gidiyoruz','Ben gidiyorum','O gidiyor','Sen gidiyorsun'],
        ci: 0, note:'"Em" = biz. 1.çoğul eki "-in": diçin'),
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
        ku:'Di dema niha de nerênîtî çawa tê çêkirin?',
        tr:'Doğru kuralı seç',
        opts:['Pêşgira na- tê zêde kirin','Lêker naguhere','Pêşgira ne- tê zêde kirin','Li dawiya hevokê "na" tê'],
        ci: 0, note:'"Na-" şimdiki olumsuz: "Naçim" = gitmiyorum. [TH] §63'),
      _fill(id:'a2_l02_e2', before:'Ez', after:'bajêr.', tr:'Ben şehre gitmiyorum.',
        opts:['naçe','naçim','neçûm','diçim'], ci: 1,
        note:'"Na-" + "çim" = naçim. "Di-" yerine "na-" gelir'),
      _fill(id:'a2_l02_e3', before:'Ew Kurmancî', after:'.', tr:'O Kurmancî bilmiyor.',
        opts:['naçe','naxwaze','dizane','nizane'], ci: 3,
        note:'"Ni-zanim" → "nizane" (3.tekil). "Di-" → "ni-"'),
      _mc(id:'a2_l02_e4',
        ku:'Nerênîtiya dema borî:',
        tr:'Doğru öneki seç',
        opts:['bê-','ni-','na-','ne-'], ci: 3,
        note:'"Ne-" geçmiş zaman olumsuz: "Nehat" = gelmedi. [TH] §64'),
      _fill(id:'a2_l02_e5', before:'Pîrê duh', after:'.', tr:'Büyükanne dün gelmedi.',
        opts:['nahat','nehat','hat','dihat'], ci: 1,
        note:'"Ne-" + geçmiş "hat" = "nehat". Dün = duh → geçmiş zaman'),
      _speak(id:'a2_l02_e6', ku:'Ez naçim. Ez nizanim. Ez nehatim.',
        tr:'Gitmiyorum. Bilmiyorum. Gelmedim.'),
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
        ku:'Dema bê çawa tê çêkirin?',
        tr:'Doğru yapıyı seç',
        opts:['Rayek + -ê','dê + forma dema niha','Tenê dê','Raveker + ê'],
        ci: 1, note:'"Dê" + şimdiki form: "Ew dê bê" = o gelecek. [BH] §185'),
      _fill(id:'a2_l03_e2', before:'Ez', after:'malê.', tr:'Ben eve gideceğim.',
        opts:['naçim','dê biçim','çûm','diçim'], ci: 1,
        note:'"Dê biçim" = gideceğim. Eşdeğer "Ez ê biçim" de doğru (Bedirxan-Lescot: cînavk + AYRI ê).'),
      _fill(id:'a2_l03_e3', before:'Pîrê sibê', after:'.', tr:'Büyükanne yarın gelecek.',
        opts:['dihat','hat','tê','dê bê'], ci: 3,
        note:'"Dê bê" = gelecek (3.tekil). "Sibê" = yarın ile gelecek uyumlu'),
      _mc(id:'a2_l03_e4',
        ku:'"Dê nexwim" bi kîjan formê re hevwate ye?',
        tr:'"Dê nexwim" hangi formla aynı anlama gelir? Eşdeğer formu bul (gelecek olumsuz)',
        opts:['Ez naxwim','Ez ê bixwim','Min nexwar','Ez ê nexwim'],
        ci: 3, note:'"Dê nexwim" = "Ez ê nexwim". "Dê" + "ne-" + şimdiki form = gelecek olumsuz; kişi açıkça belirtildiğinde "Ez ê / Tu yê / Ew ê / Em ê" — Bedirxan-Lescot standardına göre AYRI yazılır.'),
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
    culturalRewardId: 'proverb_2',  // FIX 2026-04: orphan → mevcut ID
    estimatedMinutes: 9,
    exercises: [
      _ls(id:'a2_l04_e1', ku:'Bazar', tr:'Ne anlama geliyor?',
        opts:['Çarşı/Pazar','Hastane','Park','Okul'], ci: 0,
        audio:'assets/audio/a2/bazar.mp3',
        note:'"Bazar" = pazar/çarşı. Eş anlamlı "Sûk" de kullanılır.'),
      _ls(id:'a2_l04_e2', ku:'Nexweşxane', tr:'Nereye gidilir?',
        opts:['Ji bo nexweş tê çûn','Ji bo kirrînê','Ji bo dibistanê','Ji bo parkê'], ci: 0,
        audio:'assets/audio/a2/nexwesxane.mp3'),
      _fill(id:'a2_l04_e3', before:'Mizgeft li', after:'ye.', tr:'Cami merkezde.',
        opts:['malê','gundê','navendê','bajêr'], ci: 2,
        note:'"Li navendê" = merkezde. Edat "li" + oblique (mê → -ê). "Navend" (mê) → oblique "navendê".'),
      _mc(id:'a2_l04_e4',
        ku:'"Dermangeh" çi ye?',
        tr:'Doğru tanımı bul',
        opts:['Dibistan','Qereqol','Cihê dermanan','Nexweşxane'],
        ci: 2, note:'"Derman" (ilaç) + "-geh" (yer) = eczane'),
      _fill(id:'a2_l04_e5', before:'Em diçin', after:'.', tr:'Biz pazara gidiyoruz.',
        opts:['bazarê','parkê','sinifê','malê'], ci: 0),
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
        ku:'"Li ser mêzê" çi wateyê dide?',
        tr:'Doğru çeviriyi seç',
        opts:['Li ser mêzê','Li bin mêzê','Li tenişta mêzê','Li pişt mêzê'],
        ci: 0, note:'"Li ser" = üstünde. [TH] §40'),
      _mc(id:'a2_l05_e2',
        ku:'"Li bin kursiyê" çi wateyê dide?',
        tr:'Doğru çeviriyi seç',
        opts:['Li pêşberî kursiyê','Li ser kursiyê','Li bin kursiyê','Li kursiyê'],
        ci: 2, note:'"Li bin" = altında'),
      _fill(id:'a2_l05_e3', before:'Pirtûk', after:'mêzê ye.', tr:'Kitap masanın üstünde.',
        opts:['li pêş','li ser','li bin','li paş'], ci: 1),
      _fill(id:'a2_l05_e4', before:'Pişîk', after:'kursiyê ye.', tr:'Kedi sandalyenin altında.',
        opts:['li kêlekê','li ser','li bin','li cem'], ci: 2,
        note:'"Pişîk" (mê) = kedi. Özgün Kurmancî — "Kedî" Türkçe alıntıdır, tercih edilmez'),
      _mc(id:'a2_l05_e5',
        ku:'"Di navbera mal û bazarê de" çi wateyê dide?',
        tr:'Doğru çeviriyi seç',
        opts:['Di navbera mal û bazarê de','Li ser mal û bazarê','Ji malê heta bazarê','Piştî malê, bazar'],
        ci: 0, note:'"Di navbera … de" = arasında. [TH] §42'),
      _speak(id:'a2_l05_e6', ku:'Pirtûk li ser mêzê ye. Pişîk li bin kursiyê ye.',
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
        opts:['Tren istasyonu','Otobüs durağı','Liman','Havalimanı'], ci: 3,
        audio:'assets/audio/a2/balafirgeh.mp3',
        note:'"Balafir" (uçak) + "-geh" (yer) = havalimanı. Paralel: "Rawestgeh" = durak, "Stasyon" = istasyon'),
      _mc(id:'a2_l06_e2',
        ku:'Pirsa "Bilet bi çendê ye?" li kû tê pirsîn?',
        tr:'Doğru bağlamı seç',
        opts:['Li firoşgehê','Li gîşeya biletê','Li dibistanê','Li nexweşxaneyê'], ci: 1),
      _fill(id:'a2_l06_e3', before:'Ez bi', after:'diçim bajêr.', tr:'Otobüsle şehre gidiyorum.',
        opts:['erebe','balafirê','trênê','basê'], ci: 3,
        note:'"Bi basê" = otobüsle. "Bi erebe" = arabayla'),
      _fill(id:'a2_l06_e4', before:'Balafir kengî', after:'?', tr:'Uçak ne zaman kalkıyor?',
        opts:['tê','e','diçe','difire'], ci: 3),
      _speak(id:'a2_l06_e5', ku:'Bilet dixwazim. Balafir kengî difire?',
        tr:'Bilet istiyorum. Uçak ne zaman kalkıyor?'),
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
        ku:'Dema ku tu ji kesekî xatir dixwazî, çi dibêjî?',
        tr:'Doğru seçeneği bul',
        opts:['Bi xêr hatî','Nûş be','Destê te xweş be','Seferê te baş be'],
        ci: 3, note:'"Seferê te baş be!" = iyi yolculuklar (veda selâmı)'),
      _fill(id:'a2_l07_e2', before:'Pasaport û bilet', after:'?', tr:'Pasaport ve bilet hazır mı?',
        opts:['têne','hatin','ne','amade ne'], ci: 3),
      _mc(id:'a2_l07_e3',
        ku:'"Rêwîtî" çi wateyê dide?',
        tr:'Doğru çeviriyi seç',
        opts:['Yol','Yolculuk / Sefer','Uçak','Yolcu'], ci: 1,
        note:'"Rêwî" = yolcu, "Rê" = yol, "Rêwîtî" = yolculuk. -tî eki "durum/iş" ifade eder'),
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
    culturalRewardId: 'proverb_1',  // FIX 2026-04: orphan → mevcut ID
    estimatedMinutes: 9,
    exercises: [
      _ls(id:'a2_l08_e1', ku:'Zewicîn', tr:'Ne anlama gelir?',
        opts:['Görmek','Ayrılmak','Nişanlanmak','Evlenmek'], ci: 3,
        note:'"Zewicîn" = evlenmek. "Dergîstin" = nişanlanmak; "Jêbûn" = ayrılmak; "Dîtin" = görmek'),
      _mc(id:'a2_l08_e2',
        ku:'"Zewacê we pîroz be!" kengî tê gotin?',
        tr:'Doğru bağlamı seç',
        opts:['Li ser xwarinê','Di dawetê de','Di nexweşiyê de','Di şîna de'],
        ci: 1, note:'"Pîroz be" = kutlu olsun. Düğün kutlaması'),
      _fill(id:'a2_l08_e3', before:'Zarokên', after:'çend in?', tr:'Çocukların kaç tane?',
        opts:['te','we','me','min'], ci: 0,
        note:'"Zarokên te" = senin çocukların (ezafe + eğik)'),
      _mc(id:'a2_l08_e4',
        ku:'Cudahiya "kurik" û "keçik" çi ye?',
        tr:'Doğru çifti seç',
        opts:['Herdu jî zarok in','Berovajî','Kurik = kurik, keçik = keç','Bi temen ve girêdayî'],
        ci: 2),
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
        opts:['Özür dilerim','Teşekkürler','Tamam','Lütfen'], ci: 3,
        audio:'assets/audio/a2/ji_kerema_xwe.mp3',
        note:'"Ji kerema xwe" = lütfen (kibar talep). "Spas" = teşekkür, "Bibore" = özür'),
      _fill(id:'a2_l09_e2', before:'', after:', arîkariyê bike.', tr:'Lütfen yardım et.',
        opts:['Erê','Ji kerema xwe','Spas','Bibore'], ci: 1),
      _mc(id:'a2_l09_e3',
        ku:'"Bi hev re" çi wateyê dide?',
        tr:'Doğru çeviriyi seç',
        opts:['Ayrı ayrı','Birlikte','Bazen','Tek başına'],
        ci: 1, note:'"Bi hev re" = birlikte (hev = birbiri, bi...re = ile). "Bi tenê" = yalnız başına'),
      _fill(id:'a2_l09_e4', before:'Arîkariya', after:'lazim e?', tr:'Yardıma ihtiyacın var mı?',
        opts:['te','wî','me','min'], ci: 0),
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
    culturalRewardId: 'newroz_1',  // FIX 2026-04: orphan → mevcut ID
    estimatedMinutes: 9,
    exercises: [
      _mc(id:'a2_l10_e1',
        ku:'"Hewa ewrî ye" çi wateyê dide?',
        tr:'Doğru çeviriyi seç',
        opts:['Hewa rojane ye','Hewa ewrî ye','Hewa germ e','Hewa sar e'],
        ci: 1, note:'"Ewrî" = bulutlu sıfatı'),
      _fill(id:'a2_l10_e2', before:'Derve baran', after:', dernekeve.', tr:'Dışarıda yağmur yağıyor, çıkma.',
        opts:['dihat','dibare','dibe','dikeve'], ci: 1,
        note:'"Baran dibare" = yağmur yağıyor (sabit ifade). "Dernekeve" = "derketin" (çıkmak) fiilinin olumsuz emri'),
      _mc(id:'a2_l10_e3',
        ku:'Li gor demsalê kîjan hewa tê pîvan?',
        tr:'Doğru eşleştirmeyi seç',
        opts:['Bihar = sar','Havîn = germ','Zivistan = germ','Payîz = berf'],
        ci: 1, note:'"Havîn" = yaz → "germ" (sıcak). Mantıklı eşleştirme'),
      _fill(id:'a2_l10_e4', before:'Tav', after:', em diçin derve.', tr:'Güneş vuruyor, dışarı gidiyoruz.',
        opts:['tê','dibare','derdikeve','dide'], ci: 3,
        note:'"Tav dide" = güneş vuruyor (tav + dan fiili). Distractors: "tê" (gelir, hatin), "dibare" (yağıyor), "derdikeve" (çıkıyor — güneşin doğuşu için).'),
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
    culturalRewardId: 'proverb_2',  // FIX 2026-04: orphan → mevcut ID
    estimatedMinutes: 10,
    exercises: [
      _ls(id:'a2_l11_e1', ku:'Ev bi çendê ye?', tr:'Bu ne anlama gelir?',
        opts:['Ev xweş e','Ev li ku ye?','Ev çiqas e?','Ev çend kîlo ye?'], ci: 2,
        audio:'assets/audio/a2/bi_cende.mp3'),
      _mc(id:'a2_l11_e2',
        ku:'"Erzan" û "giran" dijber in?',
        tr:'Doğru cevabı seç',
        opts:['Na — wekhev','Erê — mezin/biçûk','Na — herdu jî erzan in','Erê — erzan/giran'],
        ci: 3, note:'"Erzan" = ucuz. "Giran/biha" = pahalı. Zıt anlamlı'),
      _fill(id:'a2_l11_e3', before:'Du kîlo nan', after:'?', tr:'İki kilo ekmek ne kadar?',
        opts:['çawa ye','bi çendê ye','kî ye','ku ye'], ci: 1),
      _fill(id:'a2_l11_e4', before:'Pareyên min', after:'.', tr:'Param yok.',
        opts:['nîne','hene','heye','tune ye'], ci: 0,
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
        opts:['Ayakkabı','Gömlek','Şalvar','Çorap'], ci: 1,
        audio:'assets/audio/a2/kiras.mp3',
        note:'"Kiras" = gömlek. "Kinc" = genel giysi/kıyafet. "Şalwar" = pantolon'),
      _mc(id:'a2_l12_e2',
        ku:'"Kumik" çi wateyê dide?',
        tr:'Doğru çeviriyi bul',
        opts:['Çorap','Ceket','Başlık/Şapka','Ayakkabı'], ci: 2,
        note:'"Kumik" (nêr) = şapka/başlık. Ezafe: "kumikê min" = benim şapkam'),
      _fill(id:'a2_l12_e3', before:'Kirasê', after:'çi reng e?', tr:'Gömleğin rengi ne?',
        opts:['min','me','te','wî'], ci: 2),
      _mc(id:'a2_l12_e4',
        ku:'"Cil û berg" çi wateyê dide?',
        tr:'Doğru çeviriyi seç',
        opts:['Kıyafetler (genel)','Ayakkabı','Sadece gömlek','Sadece pantolon'],
        ci: 0, note:'"Cil û berg" = giysi ve elbise → genel olarak kıyafetler. İkili kalıp anlatım'),
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
        ku:'Li restoranê ji bo siparîşê çi dibêjî?',
        tr:'Doğru ifadeyi seç',
        opts:['Nûş be!','Destê te xweş be!','Werin!','Ez dixwazim…'],
        ci: 3, note:'"Ez dixwazim…" = istiyorum. Sipariş için temel ifade'),
      _fill(id:'a2_l13_e2', before:'Ez', after:'goştekî dixwazim.', tr:'Ben bir et yemeği istiyorum.',
        opts:['ji','li','bi','ji bo'], ci: 3,
        note:'"Ji bo min" = benim için. "Ji bo" = için'),
      _mc(id:'a2_l13_e3',
        ku:'"Nûş be" kengî tê gotin?',
        tr:'Doğru bağlamı seç',
        opts:['Di dawetê de','Piştî xwarinê','Serê sibehê','Berî xwarinê'],
        ci: 1, note:'"Nûş be" = afiyet olsun (yemek sonrası)'),
      _fill(id:'a2_l13_e4', before:'Av', after:'lazim e.', tr:'Su da lazım.',
        opts:['û','her','jî','pir'], ci: 2,
        note:'"Jî" = -de/da (dahil etme). "Av jî lazim e" = su da lazım'),
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
    culturalRewardId: 'proverb_2',  // FIX 2026-04: orphan → mevcut ID
    estimatedMinutes: 9,
    exercises: [
      _mc(id:'a2_l14_e1',
        ku:'"Xwarin çêkirin" çi wateyê dide?',
        tr:'Doğru çeviriyi seç',
        opts:['Xwarin xwarin','Xwarin firotin','Xwarin çêkirin','Xwarin xwestin'],
        ci: 2, note:'"Çêkirin" = yapmak/hazırlamak'),
      _fill(id:'a2_l14_e2', before:'Dêya min her êvarê xwarin', after:'.', tr:'Annem her akşam yemek yapıyor.',
        opts:['çêkir','çêdike','dixwe','difroşe'], ci: 1),
      _mc(id:'a2_l14_e3',
        ku:'"Malê paqij kirin" çi wateyê dide?',
        tr:'Doğru çeviriyi bul',
        opts:['Ketin malê','Mal kirê kirin','Mal firotin','Mal paqij kirin'],
        ci: 3),
      _fill(id:'a2_l14_e4', before:'Sibê ez', after:'dikim.', tr:'Yarın ev temizleyeceğim.',
        opts:['rêwîtî','malê paqij','kar','xwarin çê'], ci: 1),
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
        ku:'Di dema borî ya negerguhêz de kirde di kîjan halî de ye?',
        tr:'Doğru açıklamayı seç',
        opts:['Naguhere','Di halê rasterast de','Di halê oblîk de','Di herdu halan de'],
        ci: 1, note:'"Ew hat" = o geldi. Geçişsiz fiilde özne yalın halde. [BH] §170'),
      _mc(id:'a2_l15_e2',
        ku:'Di dema borî ya gerguhêz de kirde di kîjan halî de ye?',
        tr:'Doğru açıklamayı seç',
        opts:['Naguhere','Di halê rasterast de','Di halê oblîk de','Bi paşgira pirsê'],
        ci: 2, note:'KRİTİK: "Min nan xwar" = ben ekmek yedim. Min = ez\'nin EĞİK hali. [BH] §170'),
      _fill(id:'a2_l15_e3', before:'', after:'nan xwar.', tr:'Ben ekmek yedim.',
        opts:['Min','Ez','Me','Te'], ci: 0,
        note:'"Xwar" = yedi — geçişli fiil. Özne EĞİK hale girer: Ez → Min'),
      _fill(id:'a2_l15_e4', before:'', after:'çi got?', tr:'Sen ne dedin?',
        opts:['Min','Wî','Te','Tu'], ci: 2,
        note:'"Got" = dedi (geçişli/gerguhêz) → ergatif. "Tu" (serbixwe) → "Te" (oblîk/eğik).'),
      _mc(id:'a2_l15_e5',
        ku:'Di hevoka "Wî pirtûk xwand" de "wî" çima?',
        tr:'Doğru açıklamayı seç',
        opts:['Ji bo pirjimar','Çewt — divê ew be','Halê oblîk ê "ew" — borî ya gerguhêz','Ji bo mê'],
        ci: 2, note:'"Wî" = "ew"in eğik hali (eril). "Xwand" geçişli → ergatif zorunlu'),
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
      _fill(id:'a2_l16_e1', before:'', after:'lorî got.', tr:'O (büyükanne, dişil) ninni söyledi.',
        opts:['Ew','Wî','Wê','Me'], ci: 2,
        note:'"Got" geçişli → ergatif: "Ew" (serbixwe) → "Wê" (oblîk, mê) veya "Wî" (oblîk, nêr). Dişil refaransta "Wê".'),
      _fill(id:'a2_l16_e2', before:'', after:'çay vexwar.', tr:'Ben çay içtim.',
        opts:['Te','Ez','Me','Min'], ci: 3,
        note:'"Vexwar" = içti (geçişli) → özne eğik: Ez → Min'),
      _mc(id:'a2_l16_e3',
        ku:'"Me pîrê dît" rast e?',
        tr:'Dilbilgisel kontrolü yap',
        opts:['Erê — me halê oblîk ê "em" e','Na — divê em be','Erê lê kêm e','Na — divê min be'],
        ci: 0, note:'"Me" = "em"in eğik hali. "Dît" = gördü (geçişli) → ergatif'),
      _fill(id:'a2_l16_e4', before:'', after:'navê xwe got.', tr:'O (dişil) adını söyledi.',
        opts:['Wê','Ew','Me','Wî'], ci: 0),
      _speak(id:'a2_l16_e5', ku:'Min got, te bîst, wê kir!',
        tr:'Ben söyledim, sen duydun, o yaptı!'),
    ],
  ),

  LessonModel(
    id: 'a2_l17',
    kurmanjTitle: 'Wext û Dem',
    turkishTitle: 'Zaman İfadeleri / Zaman Zarfları',
    unitNumber: 8, lessonNumber: 3, level: 2,
    path: LessonPath.general,
    targetCardIds: _a2Cards(['dem']),
    estimatedMinutes: 10,
    exercises: [
      _mc(id:'a2_l17_e1',
        ku:'"Par" çi wateyê dide?',
        tr:'"Par" ne anlama gelir?',
        opts:['Sala bê','Vê mehê','Sala borî','Îsal'],
        ci: 2, note:'"Par" = sala borî (geçen yıl). "Îsal" = bu yıl. "Sala bê" = gelecek yıl'),
      _mc(id:'a2_l17_e2',
        ku:'"Piştî xwarinê" çi wateyê dide?',
        tr:'"Piştî xwarinê" ne anlama gelir?',
        opts:['Li şûna xwarinê','Dema xwarinê','Piştî xwarinê tê (sonra)','Berî xwarinê (önce)'],
        ci: 2, note:'"Piştî" = sonra. "Piştî xwarinê" = yemekten sonra. "Berî" = önce'),
      _fill(id:'a2_l17_e3', before:'', after:'xwarinê dest bişo.', tr:'Yemekten önce el yıka.',
        opts:['Berî','Piştî','Dema','Heta'], ci: 0,
        note:'"Berî" = önce. "Berî xwarinê" = yemekten önce'),
      _fill(id:'a2_l17_e4', before:'', after:'ez li malê me.', tr:'Şu an evdeyim.',
        opts:['Par','Berê','Niha','Sala bê'], ci: 2),
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
    culturalRewardId: 'proverb_1',  // FIX 2026-04: orphan → mevcut ID
    estimatedMinutes: 10,
    exercises: [
      _ls(id:'a2_l18_e1', ku:'Serêşî', tr:'Ne anlama gelir?',
        opts:['Tayî','Êşa piştê','Êşa zikê','Êşa serî'], ci: 3,
        audio:'assets/audio/a2/sereesi.mp3',
        note:'"Ser" (baş) + "êşî" (ağrı) = serêşî'),
      _mc(id:'a2_l18_e2',
        ku:'"Germahiya min heye" çi wateyê dide?',
        tr:'Doğru çeviriyi seç',
        opts:['Ez pir germ im','Hewa germ e','Tayî li min heye','Ez dixwazim germ bibim'],
        ci: 2, note:'"Germahî" = ateş (hastalık). [BH] bileşik: germ + -ahî'),
      _fill(id:'a2_l18_e3', before:'Bijîşk', after:'da min.', tr:'Doktor ilaç verdi.',
        opts:['bilet','arîkarî','xwarin','derman'], ci: 3,
        note:'"Derman" = ilaç. "Da" = verdi (geçmiş, geçişli → ergatif: "bijîşk" aktör)'),
      _mc(id:'a2_l18_e4',
        ku:'Hevoka bijîşk: "Ji penîsîlînê re alerjiya min heye" çi wateyê dide?',
        tr:'Doğru çeviriyi seç',
        opts:['Ez derman dixwazim','Ez baş nîn im','Li hember penîsîlînê alerjiya min heye','Pêdiviya min bi penîsîlînê heye'],
        ci: 2, note:'[AS] s.35\'te öne çıkan cümle'),
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
        ku:'"Lingê min diêşe" çi wateyê dide?',
        tr:'Doğru çeviriyi seç',
        opts:['Pişta min diêşe','Lingê min diêşe','Serê min diêşe','Destê min diêşe'],
        ci: 1, note:'"Lingê min" = ayağım/bacağım. "Diêşe" = ağrıyor'),
      _fill(id:'a2_l19_e2', before:'', after:'min diêşe.', tr:'Sırtım ağrıyor.',
        opts:['Pişta','Lingê','Milê','Guhê'], ci: 0,
        note:'"Pişt" dişil (mê) → ezafe -a: "Pişta min". Eril örnekler: "Lingê min", "Milê min"'),
      _mc(id:'a2_l19_e3',
        ku:'"Zirav" û "qelew" dijber in?',
        tr:'Doğru cevabı seç',
        opts:['Erê — kin/dirêj','Na','Erê — zirav/qelew','Na — herdu jî zirav in'],
        ci: 2),
      _fill(id:'a2_l19_e4', before:'Ew gelek', after:'ye, lê ez zirav im.', tr:'O çok şişman ama ben inceyim.',
        opts:['kovan','germ','qelew','bilind'], ci: 2),
      _speak(id:'a2_l19_e5', ku:'Pişta min diêşe. Bijîşk lazim e.',
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
    culturalRewardId: 'proverb_2',  // FIX 2026-04: orphan → mevcut ID
    estimatedMinutes: 10,
    exercises: [
      _mc(id:'a2_l20_e1',
        ku:'Cudahiya "Hîn bûn" û "fêr bûn" çi ye?',
        tr:'Doğru açıklamayı seç',
        opts:['Berovajî','Herdu jî lêhatin','Hîn bûn = fêrbûn, fêr bûn = lêhatin','Heman wate'],
        ci: 2, note:'"Hîn bûn" = öğrenmek. "Fêr bûn" = alışmak/öğrenmek (pratikle)'),
      _fill(id:'a2_l20_e2', before:'Sibê', after:'min heye.', tr:'Yarın sınavım var.',
        opts:['wane','pirtûk','îmtîhan','sinif'], ci: 2),
      _mc(id:'a2_l20_e3',
        ku:'Cudahiya "kitêb" û "pirtûk" çi ye?',
        tr:'Doğru açıklamayı seç',
        opts:['Bi tevahî cuda ye','Herdu jî pirtûk in — "pirtûk" formê hevdem zêdetir tê bikaranîn','Yek biçûk e, ya din mezin e','"Kitêb" formê klasîk e, lê tenê di metnan de'],
        ci: 1, note:'"Kitêb" (Erebî alıntı) klasik form, "pirtûk" saf Kurmancî ve günlük kullanımda yaygın. Kurmancî kelime başında "î" yerine kısa "i" kullanır.'),
      _fill(id:'a2_l20_e4', before:'Ez Kurmancî', after:'.', tr:'Ben Kurmancî öğreniyorum.',
        opts:['fêr dibim','hîn dibim','hîn bûm','fêr bûm'], ci: 1,
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
        ku:'Pirsa "Tu li kû dixebitî?" ji bo çi tê pirsîn?',
        tr:'Doğru anlamı seç',
        opts:['Cihê karê','Sedema karê','Cure karê','Saetên karê'],
        ci: 0, note:'"Li kû" = nerede → iş yeri (cihê karê)'),
      _fill(id:'a2_l21_e2', before:'Ez li şirketekê', after:'.', tr:'Bir şirkette çalışıyorum.',
        opts:['dixebitim','dixwim','dixwazim','diçim'], ci: 0,
        note:'"Xebitîn" (çalışmak) + di- + -im (1.tekil) = "dixebitim". 1.tekil eki -im, NOT -em'),
      _mc(id:'a2_l21_e3',
        ku:'"Serbixwe dixebite" çi wateyê dide?',
        tr:'Doğru çeviriyi seç',
        opts:['Bi serbestî dixebite','Li şîrketê dixebite','Naxebite','Pir dixebite'],
        ci: 0),
      _fill(id:'a2_l21_e4', before:'Mûçeya', after:'kêm e.', tr:'Maaşım az.',
        opts:['me','min','wî','te'], ci: 1),
      _speak(id:'a2_l21_e5', ku:'Ez serbixwe dixebitim. Karê min baş e.',
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
        opts:['Üzgün','Mutlu/Sevinçli','Korkmuş','Yorgun'], ci: 1,
        audio:'assets/audio/a2/sha.mp3',
        note:'"Şa" = mutlu/sevinçli. "Ez şa me" = mutluyum. Eş anlamlı: "Kêfxweş"'),
      _ls(id:'a2_l22_e2', ku:'Kovan', tr:'Ne anlama gelir?',
        opts:['Hüzünlü/Kederli','Sevinçli','Şaşkın','Öfkeli'], ci: 0,
        audio:'assets/audio/a2/kovan.mp3',
        note:'"Kovan" = hüzün/keder. Kürt şiirinin temel duygusu'),
      _mc(id:'a2_l22_e3',
        ku:'Wateya peyva "Xemgîn" çi ye?',
        tr:'Doğru çeviriyi bul',
        opts:['Mutlu','Yorgun','Heyecanlı','Üzgün/Kederli'],
        ci: 3, note:'"Xem" (keder) + "-gîn" (dolu). Kürt şiirinin temel kelimesi'),
      _fill(id:'a2_l22_e4', before:'Ez gelek', after:'ku pîrê hat!', tr:'Büyükanne geldiği için çok mutluyum!',
        opts:['xemgîn im','kovan im','ditirsim','şa me'], ci: 3),
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
        ku:'"Hêviya min heye" çi wateyê dide?',
        tr:'Doğru çeviriyi seç',
        opts:['Tirsa min heye','Hêviya min heye','Alîkariya min heye','Planê min heye'],
        ci: 1),
      _fill(id:'a2_l23_e2', before:'Ez ji', after:'ditirsim.', tr:'Kurtlardan korkuyorum.',
        opts:['guran','keçikan','bilbilan','roviyan'], ci: 0,
        note:'"Ji guran ditirsim" = kurtlardan korkuyorum. "Ji" + oblîk+pirjimar (-an) + ditirsim'),
      _mc(id:'a2_l23_e3',
        ku:'"Bê hêvî nebe!" ne demek?',
        tr:'Doğru çeviriyi seç',
        opts:['Xemgîn nebe!','Bi hêvî be!','Bê hêvî nebe!','Netirse!'],
        ci: 2, note:'"Bê" = -siz/sız. "Bê hêvî" = umutsuz. "Nebe" = olma'),
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
        ku:'Paşgira berawirdkirinê (daha) çi ye?',
        tr:'Karşılaştırma (comparative) eki nedir?',
        opts:['-kî','-tirîn','-tir','-ek'],
        ci: 2, note:'"Baş" → "baştir" (daha iyi). "-tir" karşılaştırma eki. [BH] §58'),
      _mc(id:'a2_l24_e2',
        ku:'Paşgira bilindahiyê (en) çi ye?',
        tr:'Üstünlük (superlative) eki nedir?',
        opts:['-ek','-tir','-an','-tirîn'],
        ci: 3, note:'"Baş" → "baştirîn" (en iyi). "-tirîn" üstünlük eki. [BH] §59'),
      _fill(id:'a2_l24_e3', before:'Ev xanî', after:'e.', tr:'Bu ev daha büyük.',
        opts:['pir mezin','mezintirîn','mezintir','mezin'], ci: 2),
      _fill(id:'a2_l24_e4', before:'Tu xwendekarê', after:'î!', tr:'Sen en iyi öğrencisin!',
        opts:['pir baş','baştirîn','baştir','baş'], ci: 1),
      _mc(id:'a2_l24_e5',
        ku:'Di Kurmancî de rengdêr çawa tên pîvan?',
        tr:'Doğru açıklamayı seç',
        opts:['Li dawî -tir/-tirîn tê zêde kirin','Li pêş "hîn zêdetir" tê','Tenê li pêş "pir" tê','Naguhere'],
        ci: 0),
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
    culturalRewardId: 'cegerxwin_1',  // FIX 2026-04: orphan → mevcut ID
    estimatedMinutes: 10,
    exercises: [
      _ls(id:'a2_l25_e1', ku:'Stran', tr:'Ne anlama gelir?',
        opts:['Şiir','Hikaye','Kitap','Türkü/Şarkı'], ci: 3,
        audio:'assets/audio/a2/stran.mp3',
        note:'"Stran" (mê) = türkü/şarkı. Eş anlamlı "Kilam". Ezafe: "strana min". [BH] s.56'),
      _ls(id:'a2_l25_e2', ku:'Dengbêj', tr:'Kim/Ne demek?',
        opts:['Okur','Öğretmen','Geleneksel halk ozanı','Şair'], ci: 2,
        audio:'assets/audio/a2/dengbej.mp3',
        note:'"Dengbêj" = ses+söyleyen → Kurd sözlü geleneğinin taşıyıcısı, halk ozanı'),
      _mc(id:'a2_l25_e3',
        ku:'"Wêje" ne demek?',
        tr:'Doğru çeviriyi seç',
        opts:['Edebiyat','Müzik','Resim','Halay'],
        ci: 0,
        note:'"Wêje" = edebiyat. "Muzîk" = müzik, "Wêne" = resim, "Govend" = halay'),
      _mc(id:'a2_l25_e4',
        ku:'Cegerxwîn kî ye?',
        tr:'Doğru açıklamayı seç',
        opts:['Dengbêj','Helbestvanê navdar ê Kurd (1903–1984)','Serokê Kurdan','Birayê Bedirxan'],
        ci: 1, note:'Cegerxwîn = modern Kurmancî şiirinin öncüsü'),
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
