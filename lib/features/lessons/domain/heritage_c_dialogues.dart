// ════════════════════════════════════════════════════════════════
// HERİTAGE DİYALOG MODELLERİ
// ════════════════════════════════════════════════════════════════

class DialogueCharacter {
  final String id;
  final String name;
  final int age;
  final String description;
  final String avatarAsset;
  final bool isHeritage;

  const DialogueCharacter({
    required this.id,
    required this.name,
    required this.age,
    required this.description,
    required this.avatarAsset,
    this.isHeritage = false,
  });
}

class DialogueLine {
  final String speakerId;
  final String kurmanci;
  final String turkish;
  final String? grammarNote;
  final String? culturalNote;
  final String? audioAsset;

  const DialogueLine({
    required this.speakerId,
    required this.kurmanci,
    required this.turkish,
    this.grammarNote,
    this.culturalNote,
    this.audioAsset,
  });
}

class HeritageDialogue {
  final String id;
  final String title;
  final String turkishTitle;
  final int level;
  final String lessonId;
  final List<DialogueCharacter> characters;
  final List<DialogueLine> lines;

  const HeritageDialogue({
    required this.id,
    required this.title,
    required this.turkishTitle,
    required this.level,
    required this.lessonId,
    required this.characters,
    required this.lines,
  });
}

// ════════════════════════════════════════════════════════════════
// C1-C2 HERİTAGE DİYALOGLARI (3 sahne)
// ════════════════════════════════════════════════════════════════

// C1 Sahne 1: Akademik tartışma — Goran (35) vs. Prof. Leyla
const kDialogueC1Akademi = HeritageDialogue(
  id: 'c1_dlg_akademi',
  title: 'Zimannasî û Nasname',
  turkishTitle: 'Dilbilim ve Kimlik Tartışması',
  level: 5,
  lessonId: 'c1_l06',
  characters: [
    DialogueCharacter(id:'goran35', name:'Goran', age:35,
      description:'Hollanda doğumlu araştirmacı — doktora öğrencisi',
      avatarAsset:'assets/avatars/goran.png', isHeritage:true),
    DialogueCharacter(id:'prof_leyla', name:'Prof. Dr. Leyla', age:52,
      description:'Kürt dilbilim profesörü',
      avatarAsset:'assets/avatars/prof_leyla.png', isHeritage:false),
  ],
  lines: [
    DialogueLine(speakerId:'goran35',
      kurmanci:'Prof. Dr. Leyla, ez dixwazim li ser têkilîya navbera ziman û nasnameya kurdî lêkolîn bikim. Ji ku dest pê bikim?',
      turkish:'Prof. Dr. Leyla, dil ve Kürt kimliği arasındaki ilişki üzerine araştırmak istiyorum. Nereden başlayayım?',
      grammarNote:'"Ji ku dest pê bikim?" = Nereden başlayayım? (subjunctive). "Li ser têkilîya navbera" = üzerine ilişkiyi.',
      audioAsset:'assets/audio/heritage/c1_akademi_1.mp3'),
    DialogueLine(speakerId:'prof_leyla',
      kurmanci:'Destpêk bike ji Xanî. Di pêşgotina Mem û Zîn de, Xanî bi zelal diyar dike ku ziman û yekîtî ji hev nayên veqetandin. Ev çarçoweya teorîkî ya herî xurt e.',
      turkish:'Xanî\'den başla. Mem û Zîn\'in önsözünde Xanî açıkça belirtir ki dil ve birlik birbirinden ayrılamaz. Bu en güçlü teorik çerçeve.',
      grammarNote:'"Bi zelal diyar dike ku..." = açıkça belirtir ki (pasif değil, aktif). "Ji hev nayên veqetandin" = birbirinden ayrılamaz (pasif olumsuz).',
      audioAsset:'assets/audio/heritage/c1_akademi_2.mp3'),
    DialogueLine(speakerId:'goran35',
      kurmanci:'Rast e. Lê di diasporayê de ziman û nasname ji hev dûr dikevin. Hin Kurd hene ku zimanê wan tune ye, lê nasnameya wan kurd e.',
      turkish:'Doğru. Ama diasporada dil ve kimlik birbirinden uzaklaşıyor. Dili olmayan ama kimliği Kürt olan Kürtler var.',
      grammarNote:'"Ji hev dûr dikevin" = birbirinden uzaklaşıyor (zaman). "Hin... hene ku..." = ... olanlar var ki...',
      audioAsset:'assets/audio/heritage/c1_akademi_3.mp3'),
    DialogueLine(speakerId:'prof_leyla',
      kurmanci:'Ev pirsgirêkeke cidî ye. Lê ji perspektîfa zimannasiyê, ziman û nasname têkilîyeke diyalektîk e — yek bi ya din mezin dibe, lê dibe jî ji hev veqete.',
      turkish:'Bu ciddi bir sorun. Ama dilbilim perspektifinden, dil ve kimlik diyalektik bir ilişkidir — biri diğeriyle büyür ama ayrışabilir de.',
      grammarNote:'"Ji perspektîfa zimannasiyê" = dilbilim perspektifinden (C2 kalıbı). "Têkilîyeke diyalektîk" = diyalektik bir ilişki.',
      audioAsset:'assets/audio/heritage/c1_akademi_4.mp3'),
    DialogueLine(speakerId:'goran35',
      kurmanci:'Weke encamekê, çi pêşniyar dikî ji bo xwendekarên Kurdan ên li diasporayê?',
      turkish:'Sonuç olarak, diasporadaki Kürt öğrenciler için ne öneriyorsun?',
      grammarNote:'"Weke encamekê" = sonuç olarak (C1 kalıbı). "Çi pêşniyar dikî" = ne öneriyorsun.',
      audioAsset:'assets/audio/heritage/c1_akademi_5.mp3'),
    DialogueLine(speakerId:'prof_leyla',
      kurmanci:'Bi kûrbûnî hem ziman hem çand fêr bibin. Ziman bi tenê bes nake — çanda Kurdistanê, dengbêjî, wêje jî divê. Weke ku Xanî gotibû: yekîtî ne tenê siyasî ye, çandî jî ye.',
      turkish:'Derinlemesine hem dil hem kültür öğrenin. Dil tek başına yetmez — Kürdistan kültürü, dengbêjlik, edebiyat da gerekli. Xanî\'nin dediği gibi: birlik sadece siyasi değil, kültürel de.',
      grammarNote:'"Bi kûrbûnî" = derinlemesine (C2 zarfı). "Bi tenê bes nake" = tek başına yetmez. "Weke ku Xanî gotibû" = Xanî\'nin dediği gibi (geçmiş mükemmel).',
      culturalNote:'C1-C2 diyaloğunun sonucu: Ziman + çand + nasname = tam Kürtlük.',
      audioAsset:'assets/audio/heritage/c1_akademi_6.mp3'),
  ],
);

// C1 Sahne 2: Gazeteci röportajı — Selin (27) ile Kürt gazeteci
const kDialogueC1Medya = HeritageDialogue(
  id: 'c1_dlg_medya',
  title: 'Rojnameger û Ziman',
  turkishTitle: 'Gazeteci ve Dil',
  level: 5,
  lessonId: 'c1_l14',
  characters: [
    DialogueCharacter(id:'selin27', name:'Selin', age:27,
      description:'Medya alanında çalışıyor — Kürtçe öğreniyor',
      avatarAsset:'assets/avatars/selin.png', isHeritage:true),
    DialogueCharacter(id:'rojnameger', name:'Rojnameger Zîlan', age:38,
      description:'Kürtçe yayın yapan gazeteci',
      avatarAsset:'assets/avatars/zilan.png', isHeritage:false),
  ],
  lines: [
    DialogueLine(speakerId:'selin27',
      kurmanci:'Zîlan xanim, ez di medyayê de dixebitim û dixwazim bi kurmancî nûçe amade bikim. Lê ne dizanim ji ku dest pê bikim.',
      turkish:'Zîlan hanım, medyada çalışıyorum ve Kürtçe haber hazırlamak istiyorum. Ama nereden başlayacağımı bilmiyorum.',
      grammarNote:'"Di medyayê de dixebitim" = medyada çalışıyorum (şimdiki). "Ne dizanim ji ku dest pê bikim" = nereden başlayacağımı bilmiyorum (bağımlı soru).',
      audioAsset:'assets/audio/heritage/c1_medya_1.mp3'),
    DialogueLine(speakerId:'rojnameger',
      kurmanci:'Baş e! Berî her tiştî, divê tu zimanê nûçeyê fêr bibî. Zimanê nûçeyê ji zimanê rojane cuda ye — kurtir, zelaltir, bê xeyalî.',
      turkish:'İyi! Her şeyden önce haber dilini öğrenmelisin. Haber dili günlük dilden farklıdır — daha kısa, daha açık, mecazsız.',
      grammarNote:'"Berî her tiştî, divê tu... fêr bibî" = Her şeyden önce... öğrenmelisin (divê + subjunctive). "Kurtir, zelaltir, bê xeyalî" — karşılaştırmalı sıfatlar.',
      audioAsset:'assets/audio/heritage/c1_medya_2.mp3'),
    DialogueLine(speakerId:'selin27',
      kurmanci:'Hevpeyvîn kêrî ye. Li gorî te, pirsên herî girîng ên hevpeyvînê çi ne?',
      turkish:'Röportaj yararlı. Sana göre, röportajın en önemli soruları nelerdir?',
      grammarNote:'"Li gorî te" = sana göre. "Pirsên herî girîng... çi ne?" = en önemli sorular... nelerdir?',
      audioAsset:'assets/audio/heritage/c1_medya_3.mp3'),
    DialogueLine(speakerId:'rojnameger',
      kurmanci:'5N1K: Kî, Çi, Kengî, Ku, Çima, Çawa. Bi vî awayî, nûçeya te tam dibe. Û tiştê herî girîng: çavkanîyên xwe kontrol bike.',
      turkish:'5N1K: Kim, Ne, Ne zaman, Nerede, Neden, Nasıl. Bu şekilde haberin tam olur. Ve en önemli şey: kaynaklarını kontrol et.',
      grammarNote:'"Bi vî awayî, nûçeya te tam dibe" = Bu şekilde haberin tam olur. "Kontrol bike" = kontrol et (emir).',
      audioAsset:'assets/audio/heritage/c1_medya_4.mp3'),
    DialogueLine(speakerId:'selin27',
      kurmanci:'Gelek spas. Min tiştekî girîng fêr bû: nûçegirî ne tenê ziman e — berpirsiyarî ye.',
      turkish:'Çok teşekkür ederim. Önemli bir şey öğrendim: gazetecilik sadece dil değil — sorumluluktur.',
      grammarNote:'"Min tiştekî girîng fêr bû" = önemli bir şey öğrendim (ergatif + geçmiş). "Ne tenê... — jî..." = sadece... değil — ... da...',
      culturalNote:'C1 sonucu: Kürtçe medya = hem dil hem etik sorumluluk.',
      audioAsset:'assets/audio/heritage/c1_medya_5.mp3'),
  ],
);

// C2 Sahne: Goran (35) — Akademik konferans sunumu
const kDialogueC2Konferans = HeritageDialogue(
  id: 'c2_dlg_konferans',
  title: 'Konferansa Zimannasiyê',
  turkishTitle: 'Dilbilim Konferansı',
  level: 6,
  lessonId: 'c2_l06',
  characters: [
    DialogueCharacter(id:'goran35', name:'Goran', age:35,
      description:'Dilbilim konferansında sunum yapıyor',
      avatarAsset:'assets/avatars/goran.png', isHeritage:true),
    DialogueCharacter(id:'seyirci', name:'Seyirciler', age:0,
      description:'Konferans katilimcilari',
      avatarAsset:'assets/avatars/crowd.png', isHeritage:false),
  ],
  lines: [
    DialogueLine(speakerId:'goran35',
      kurmanci:'Heval û hogirên hêja, silav û rêzên min ji we re. Îro em ê li ser têkilîya navbera zimanê zikmakî û nasnameya Kurdan ên li diasporayê biaxivin.',
      turkish:'Değerli dostlar ve meslektaşlar, hepinize saygılarımı sunarım. Bugün diasporadaki Kürtlerin anadili ve kimliği arasındaki ilişki hakkında konuşacağız.',
      grammarNote:'"Heval û hogirên hêja" = değerli dostlar (hitap). "Em ê... biaxivin" = konuşacağız (gelecek + subjunctive). "Zimanê zikmakî" = anadil.',
      audioAsset:'assets/audio/heritage/c2_konferans_1.mp3'),
    DialogueLine(speakerId:'goran35',
      kurmanci:'Lêkolîna me nîşan dide ku xwendekarên Kurdan ên li Ewropayê du cureyên nasnameya zimanî di xwe de vedihewîne: nasnameya zimanê zikmakî û nasnameya zimanê mêvandar.',
      turkish:'Araştırmamız gösteriyor ki Avrupa\'daki Kürt öğrenciler iki tür dilsel kimliği kendi içinde barındırıyor: anadil kimliği ve ev sahibi dil kimliği.',
      grammarNote:'"Lêkolîna me nîşan dide ku..." = araştırmamız gösteriyor ki (C2 kanıt kalıbı). "Du cureyên... vedihewîne" = iki tür... barındırıyor.',
      audioAsset:'assets/audio/heritage/c2_konferans_2.mp3'),
    DialogueLine(speakerId:'goran35',
      kurmanci:'Ji perspektîfa zimannasiyê, ev xeteredar e: ger ziman wenda bibe, beşek ji nasname jî wenda dibe. Lê ji perspektîfeke din, ev nû ye — nasnameyeke cot a dewlemend.',
      turkish:'Dilbilim perspektifinden bu tehlikelidir: dil kaybolursa kimliğin bir parçası da kaybolur. Ama başka bir perspektiften bu yenidir — zengin bir çift kimlik.',
      grammarNote:'"Ji perspektîfa... — ji perspektîfeke din" = ... perspektifinden — başka bir perspektiften. "Ger... wenda bibe... jî... wenda dibe" = eğer kaybolursa... da kaybolur (şartlı).',
      audioAsset:'assets/audio/heritage/c2_konferans_3.mp3'),
    DialogueLine(speakerId:'goran35',
      kurmanci:'Weke encamekê, em pêşniyar dikin ku siyaseta zimên divê her du aliyên nasnameya zimanî nas bike û bişixulîne. Divê ne bişaftin ne jî cudabûn — lê entegrasyon be.',
      turkish:'Sonuç olarak, dil politikasının her iki dilsel kimlik boyutunu tanıması ve çalıştırması gerektiğini öneriyoruz. Ne asimilasyon ne de ayrışma olmalı — entegrasyon olmalı.',
      grammarNote:'"Weke encamekê, em pêşniyar dikin ku..." = Sonuç olarak, öneriyoruz ki (C2 sonuç kalıbı). "Ne... ne jî... lê..." = Ne... ne de... ama...',
      audioAsset:'assets/audio/heritage/c2_konferans_4.mp3'),
    DialogueLine(speakerId:'goran35',
      kurmanci:'Pirsên we hene? Ez amade me ku bersiv bidim. Spas ji bo guhdariya we.',
      turkish:'Sorularınız var mı? Cevap vermeye hazırım. Dinlediğiniz için teşekkürler.',
      grammarNote:'"Pirsên we hene?" = sorularınız var mı? "Ez amade me ku bersiv bidim" = cevap vermeye hazırım (subjunctive). "Ji bo guhdariya we" = dinlemeniz için.',
      culturalNote:'C2\'nin zirvesi: Kürtçe akademik konferans sunumu. Diaspora öğrencisi artık üretici.',
      audioAsset:'assets/audio/heritage/c2_konferans_5.mp3'),
  ],
);

const kHeritageDiyaloglarC = [
  kDialogueC1Akademi,
  kDialogueC1Medya,
  kDialogueC2Konferans,
];
