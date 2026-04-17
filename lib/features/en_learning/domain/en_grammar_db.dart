// ════════════════════════════════════════════════════════════════
// LÛTKE — İngilizce Dilbilgisi Notları (Kurmancî açıklamalı)
//
// Kurmancî anadilli öğrenenlere İngilizce gramer kuralları.
// CEFR seviyelerine göre düzenli — A1'den C2'ye.
// ════════════════════════════════════════════════════════════════

class EnGrammarTopic {
  final String id;
  final String level; // A1, A2, B1, B2, C1, C2
  final String titleEn;
  final String titleKu;
  final String emoji;
  final String summaryKu; // Kısa Kurmancî özet
  final List<EnGrammarRule> rules;

  const EnGrammarTopic({
    required this.id,
    required this.level,
    required this.titleEn,
    required this.titleKu,
    required this.emoji,
    required this.summaryKu,
    required this.rules,
  });
}

class EnGrammarRule {
  final String ruleKu; // Kural Kurmancî açıklaması
  final List<EnGrammarExample> examples;
  final String? noteKu; // Ek not (Kurmancî L1 için yaygın hata uyarısı)

  const EnGrammarRule({
    required this.ruleKu,
    required this.examples,
    this.noteKu,
  });
}

class EnGrammarExample {
  final String en;
  final String ku;

  const EnGrammarExample({required this.en, required this.ku});
}

const List<EnGrammarTopic> kEnGrammarTopics = [
  // ═══ A1 — Başlangıç ══════════════════════════════════════════
  EnGrammarTopic(
    id: 'a1_be',
    level: 'A1',
    titleEn: 'The Verb "Be" (am/is/are)',
    titleKu: 'Lekerê "Be" — bûn',
    emoji: '🔵',
    summaryKu: 'Lekerê "be" sê forman digire: am (ez), is (ew), are (em/hûn/ew pirjimar). Bingeha hevokên Îngilîzî ye.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Ez = I am | Tu = You are | Ew (mêr/jin) = He/She is | Em = We are | Ew (pirjimar) = They are',
        examples: [
          EnGrammarExample(en: 'I am happy.', ku: 'Ez kêfxweş im.'),
          EnGrammarExample(en: 'She is a teacher.', ku: 'Ew mamoste ye.'),
          EnGrammarExample(en: 'They are friends.', ku: 'Ew heval in.'),
        ],
        noteKu: 'Kurmancî de "ez im / tu yî / ew e" bi cuda dixebite. Îngilîzî de jî heman.',
      ),
      EnGrammarRule(
        ruleKu: 'Olumsuz: am not / is not (isn\'t) / are not (aren\'t)',
        examples: [
          EnGrammarExample(en: 'I am not tired.', ku: 'Ez ne westiyayî me.'),
          EnGrammarExample(en: 'He isn\'t here.', ku: 'Ew ne li vir e.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Soru: Am I? / Is he? / Are they? — özne ile fiil yer değiştirir',
        examples: [
          EnGrammarExample(en: 'Are you ready?', ku: 'Tu amade yî?'),
          EnGrammarExample(en: 'Is she at home?', ku: 'Ew li mal e?'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'a1_articles',
    level: 'A1',
    titleEn: 'Articles: a, an, the',
    titleKu: 'Belirteç (Article): a, an, the',
    emoji: '🅰️',
    summaryKu: 'Kurmancî de yok — Îngilîzî de ZORUNLU. Tek isimler önünde belirteç gerekir.',
    rules: [
      EnGrammarRule(
        ruleKu: '"a" — sayılabilir tekil isimler önünde, ünsüz ile başlayan: a book, a cat, a dog',
        examples: [
          EnGrammarExample(en: 'I have a cat.', ku: 'Pisîkek min heye.'),
          EnGrammarExample(en: 'She is a doctor.', ku: 'Ew bijîşk e.'),
        ],
        noteKu: 'Kurmancî de "pisîk" derek, "pisîkek" yek pisîk demek. Îngilîzî "a cat".',
      ),
      EnGrammarRule(
        ruleKu: '"an" — ünlü ile başlayan tekil isimler önünde: an apple, an egg, an idea',
        examples: [
          EnGrammarExample(en: 'I eat an apple.', ku: 'Ez sêvekê dixwim.'),
          EnGrammarExample(en: 'She has an idea.', ku: 'Fikirek wê heye.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: '"the" — bilinen, daha önce bahsedilen veya tek olan şeyler önünde',
        examples: [
          EnGrammarExample(en: 'The sun is bright.', ku: 'Roj geş e.'),
          EnGrammarExample(en: 'The book on the table.', ku: 'Pirtûka li ser maseyê.'),
        ],
        noteKu: 'EN YAYGIN HATA: Kurmancî konuşurları "a/an/the"yi unutur. "He is teacher" yerine "He is a teacher" doğru.',
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'a1_present_simple',
    level: 'A1',
    titleEn: 'Present Simple Tense',
    titleKu: 'Demê Niha (Present Simple)',
    emoji: '⏰',
    summaryKu: 'Her gün yapılan işler, alışkanlıklar, gerçekler için. 3. tekil şahısta (he/she/it) fiile -s/-es eklenir.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Olumlu: I/You/We/They + verb. He/She/It + verb-s.',
        examples: [
          EnGrammarExample(en: 'I drink water.', ku: 'Ez avê vedixwim.'),
          EnGrammarExample(en: 'She drinks tea.', ku: 'Ew çayê vedixwe.'),
          EnGrammarExample(en: 'We work every day.', ku: 'Em her roj dixebitin.'),
        ],
        noteKu: '3. şahıs -s kuralı KRİTİK: he eats, she goes, it works.',
      ),
      EnGrammarRule(
        ruleKu: 'Olumsuz: do not (don\'t) / does not (doesn\'t) + verb',
        examples: [
          EnGrammarExample(en: 'I don\'t smoke.', ku: 'Ez cixarê nakişînim.'),
          EnGrammarExample(en: 'He doesn\'t eat meat.', ku: 'Ew goşt naxwe.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Soru: Do I? / Does he? + verb',
        examples: [
          EnGrammarExample(en: 'Do you speak English?', ku: 'Tu bi Îngilîzî dipeyivî?'),
          EnGrammarExample(en: 'Does she like coffee?', ku: 'Ew ji qehweyê hez dike?'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'a1_pronouns',
    level: 'A1',
    titleEn: 'Personal Pronouns',
    titleKu: 'Cinavkên Şexsî',
    emoji: '👤',
    summaryKu: 'I, you, he, she, it, we, they — özne formları. me, you, him, her, it, us, them — nesne formları.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Özne (subject): I, you, he, she, it, we, they',
        examples: [
          EnGrammarExample(en: 'I am here.', ku: 'Ez li vir im.'),
          EnGrammarExample(en: 'They are friends.', ku: 'Ew heval in.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Nesne (object): me, you, him, her, it, us, them',
        examples: [
          EnGrammarExample(en: 'She helps me.', ku: 'Ew alîkariya min dike.'),
          EnGrammarExample(en: 'I see them.', ku: 'Ez wan dibînim.'),
        ],
        noteKu: 'Kurmancî de "min/te/wê/wî" oblique form. Îngilîzî "me/you/him/her".',
      ),
      EnGrammarRule(
        ruleKu: 'İyelik (possessive): my, your, his, her, its, our, their',
        examples: [
          EnGrammarExample(en: 'My book is here.', ku: 'Pirtûka min li vir e.'),
          EnGrammarExample(en: 'Their house is big.', ku: 'Mala wan mezin e.'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'a1_plural',
    level: 'A1',
    titleEn: 'Plural Nouns',
    titleKu: 'Pirjimara Navan (Plural)',
    emoji: '➕',
    summaryKu: 'Çoğul yapma kuralları: çoğu isim -s alır. Bazı düzensizler farklı.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Çoğu isim: + s. book → books, car → cars',
        examples: [
          EnGrammarExample(en: 'Two books.', ku: 'Du pirtûk.'),
          EnGrammarExample(en: 'Many cars.', ku: 'Gelek erebe.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: '-s, -ss, -sh, -ch, -x, -o ile bitenler: + es. bus → buses, box → boxes',
        examples: [
          EnGrammarExample(en: 'Three buses.', ku: 'Sê otobûs.'),
          EnGrammarExample(en: 'Two boxes.', ku: 'Du qutî.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Düzensiz çoğullar: man → men, woman → women, child → children, foot → feet, tooth → teeth, mouse → mice',
        examples: [
          EnGrammarExample(en: 'Two men and three women.', ku: 'Du mêr û sê jin.'),
          EnGrammarExample(en: 'Five children.', ku: 'Pênc zarok.'),
        ],
        noteKu: 'Bu düzensizler ezberlenmeli — çok yaygın kelimeler.',
      ),
    ],
  ),

  // ═══ A2 — Pre-intermediate ═══════════════════════════════════
  EnGrammarTopic(
    id: 'a2_past_simple',
    level: 'A2',
    titleEn: 'Past Simple Tense',
    titleKu: 'Demê Borî ya Sade',
    emoji: '⏪',
    summaryKu: 'Geçmişte tamamlanmış olaylar için. Düzenli fiiller -ed alır, düzensizler ezberlenir.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Düzenli fiiller: + ed. work → worked, play → played, watch → watched',
        examples: [
          EnGrammarExample(en: 'I worked yesterday.', ku: 'Min duh xebitî.'),
          EnGrammarExample(en: 'She played football.', ku: 'Wê futbol lîst.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Düzensiz fiiller: go → went, come → came, see → saw, eat → ate, take → took, give → gave, have → had',
        examples: [
          EnGrammarExample(en: 'I went to school.', ku: 'Ez çûm dibistanê.'),
          EnGrammarExample(en: 'He saw a film.', ku: 'Wî fîlmek dît.'),
        ],
        noteKu: 'Kurmancî ergatîfê de "min dît" gibi. Îngilîzî "I saw" — özne değişmez.',
      ),
      EnGrammarRule(
        ruleKu: 'Olumsuz: did not (didn\'t) + verb (1. form)',
        examples: [
          EnGrammarExample(en: 'I didn\'t go.', ku: 'Ez neçûm.'),
          EnGrammarExample(en: 'She didn\'t see me.', ku: 'Wê ez nedîtim.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Soru: Did + subject + verb?',
        examples: [
          EnGrammarExample(en: 'Did you eat?', ku: 'Te xwar?'),
          EnGrammarExample(en: 'Where did she go?', ku: 'Ew çû ku?'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'a2_present_continuous',
    level: 'A2',
    titleEn: 'Present Continuous',
    titleKu: 'Demê Niha ya Berdewam',
    emoji: '🔄',
    summaryKu: 'Şu an yapılan işler için: am/is/are + verb-ing.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Yapı: am/is/are + verb-ing',
        examples: [
          EnGrammarExample(en: 'I am eating.', ku: 'Ez dixwim (niha).'),
          EnGrammarExample(en: 'She is working.', ku: 'Ew dixebite (niha).'),
          EnGrammarExample(en: 'They are playing.', ku: 'Ew dilîzin (niha).'),
        ],
        noteKu: 'Kurmancî de hem "dixwim" şimdiki, hem "her gün xwarinê dixwim" geniş zaman. Îngilîzî bunu ayırır: "I am eating" (now) vs "I eat" (every day).',
      ),
      EnGrammarRule(
        ruleKu: '-ing kuralı: e ile bitenler "e" düşer (write → writing). Çift ünsüz (run → running).',
        examples: [
          EnGrammarExample(en: 'He is writing a letter.', ku: 'Ew nameyekê dinivîse.'),
          EnGrammarExample(en: 'They are running.', ku: 'Ew dibezin.'),
        ],
      ),
    ],
  ),

  // ═══ B1 — Intermediate ═══════════════════════════════════════
  EnGrammarTopic(
    id: 'b1_present_perfect',
    level: 'B1',
    titleEn: 'Present Perfect',
    titleKu: 'Demê Niha ya Têkûz',
    emoji: '✅',
    summaryKu: 'Geçmişte başlamış, şu ana etkisi olan veya henüz tamamlanmış olaylar: have/has + past participle (3. form).',
    rules: [
      EnGrammarRule(
        ruleKu: 'Yapı: have/has + verb (3. form). I have eaten. She has gone.',
        examples: [
          EnGrammarExample(en: 'I have lived here for 5 years.', ku: 'Ez 5 sal in li vir dijîm.'),
          EnGrammarExample(en: 'She has finished her work.', ku: 'Wê karê xwe qedand.'),
        ],
        noteKu: 'Kurmancî de "min kiriye" yapısına yakın. "Min xwendiye" = "I have read".',
      ),
      EnGrammarRule(
        ruleKu: 'for (süre) + since (başlangıç noktası) ile sıkça kullanılır',
        examples: [
          EnGrammarExample(en: 'I have known him for 10 years.', ku: '10 sal in ez wî dizanim.'),
          EnGrammarExample(en: 'She has lived here since 2020.', ku: 'Ji 2020 ve ew li vir dijî.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'just, already, yet, ever, never zaman zarflarıyla yaygın',
        examples: [
          EnGrammarExample(en: 'I have just arrived.', ku: 'Ez nû gihîştim.'),
          EnGrammarExample(en: 'Have you ever been to Paris?', ku: 'Tu çû Parîsê?'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'b1_modals',
    level: 'B1',
    titleEn: 'Modal Verbs (can, must, should, may)',
    titleKu: 'Lekerên Modal',
    emoji: '🔧',
    summaryKu: 'Yardımcı fiiller — yetenek, zorunluluk, izin, olasılık ifade eder.',
    rules: [
      EnGrammarRule(
        ruleKu: 'can = -ebilmek (yetenek). I can swim.',
        examples: [
          EnGrammarExample(en: 'I can speak English.', ku: 'Ez dikarim bi Îngilîzî bipeyivim.'),
          EnGrammarExample(en: 'She can\'t come today.', ku: 'Ew nikare îro were.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'must = mecbur olmak / kesinlikle. should = -meli/-malı (öneri).',
        examples: [
          EnGrammarExample(en: 'You must study.', ku: 'Tu divê bixwînî.'),
          EnGrammarExample(en: 'You should rest.', ku: 'Divê tu bêhna xwe vedî.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'may / might = belki (olasılık). may = izin de demek.',
        examples: [
          EnGrammarExample(en: 'It may rain.', ku: 'Belkî baran bibare.'),
          EnGrammarExample(en: 'May I come in?', ku: 'Destûra min heye werim hundir?'),
        ],
      ),
    ],
  ),

  // ═══ B2 — Upper-intermediate ═════════════════════════════════
  EnGrammarTopic(
    id: 'b2_conditionals',
    level: 'B2',
    titleEn: 'Conditional Sentences (if-clauses)',
    titleKu: 'Hevokên Şertî (if)',
    emoji: '🔀',
    summaryKu: '4 tip şart cümlesi: zero, first, second, third. Her biri farklı zaman/olasılık ifade eder.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Type 0 (gerçek): If + present, present. "If you heat water, it boils."',
        examples: [
          EnGrammarExample(en: 'If you heat water, it boils.', ku: 'Ger tu avê germ bikî, ew dikele.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Type 1 (gerçek olası): If + present, will + verb',
        examples: [
          EnGrammarExample(en: 'If it rains, I will stay home.', ku: 'Ger baran bibare, ez ê li mal bimînim.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Type 2 (gerçek olmayan, şu anki): If + past, would + verb',
        examples: [
          EnGrammarExample(en: 'If I had money, I would travel.', ku: 'Ger pereyên min hebûna, ez ê biçim geştê.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Type 3 (gerçek olmayan, geçmiş): If + past perfect, would have + past participle',
        examples: [
          EnGrammarExample(en: 'If I had studied, I would have passed.', ku: 'Ger min xwendibûya, min ê derbas bibûya.'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'b2_passive',
    level: 'B2',
    titleEn: 'Passive Voice',
    titleKu: 'Edilgen Yapı (Passive)',
    emoji: '↩️',
    summaryKu: 'Eylemi yapan değil, etkilenen önemli olduğunda kullanılır: be + past participle.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Aktif → Pasif: özne ve nesne yer değiştirir. "John builds the house" → "The house is built by John"',
        examples: [
          EnGrammarExample(en: 'The book was written by Hemingway.', ku: 'Pirtûk ji aliyê Hemingway hat nivîsîn.'),
          EnGrammarExample(en: 'English is spoken here.', ku: 'Li vir Îngilîzî tê axaftin.'),
        ],
        noteKu: 'Kurmancî ergatîfê pasif benzeri yapı: "Min nan xwar" = "The bread was eaten by me" benzeri.',
      ),
      EnGrammarRule(
        ruleKu: 'Tüm zamanlarda kullanılabilir: is built / was built / has been built / will be built',
        examples: [
          EnGrammarExample(en: 'The bridge will be opened tomorrow.', ku: 'Pirê dê sibê were vekirin.'),
          EnGrammarExample(en: 'The car has been repaired.', ku: 'Ereb hat tamîr kirin.'),
        ],
      ),
    ],
  ),

  // ═══ C1 — Advanced ═══════════════════════════════════════════
  EnGrammarTopic(
    id: 'c1_relative_clauses',
    level: 'C1',
    titleEn: 'Relative Clauses (who, which, that, whose)',
    titleKu: 'Hevokên Têkilîdar',
    emoji: '🔗',
    summaryKu: 'who (insan), which (nesne), that (her ikisi), whose (iyelik) ile alt cümleler kurulur.',
    rules: [
      EnGrammarRule(
        ruleKu: 'who → insan; which → nesne/hayvan; that → her ikisi (informal)',
        examples: [
          EnGrammarExample(en: 'The man who lives here is my uncle.', ku: 'Mêrê ku li vir dijî mamê min e.'),
          EnGrammarExample(en: 'The book which I read was good.', ku: 'Pirtûka ku min xwend baş bû.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'whose → iyelik (insan veya nesne)',
        examples: [
          EnGrammarExample(en: 'A boy whose name is Ali.', ku: 'Lawekî ku navê wî Alî ye.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Defining vs non-defining: virgülle ayrılan (non-defining) ek bilgi verir',
        examples: [
          EnGrammarExample(en: 'My brother, who lives in London, is a doctor.', ku: 'Birayê min, ku li Londonê dijî, bijîşk e.'),
        ],
      ),
    ],
  ),

  // ═══ C2 — Mastery ════════════════════════════════════════════
  EnGrammarTopic(
    id: 'c2_inversion',
    level: 'C2',
    titleEn: 'Inversion (Edebî Devrik)',
    titleKu: 'Inversion — Devrik Yapı',
    emoji: '🎭',
    summaryKu: 'Olumsuz/sınırlayıcı zarflarla başlayan cümlelerde özne-fiil yer değiştirir. Edebî / formal.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Never, rarely, seldom, hardly, scarcely, no sooner ile başlayınca devrik',
        examples: [
          EnGrammarExample(en: 'Never have I seen such beauty.', ku: 'Min qet xweşiyek wisa nedîtî.'),
          EnGrammarExample(en: 'Rarely does he speak.', ku: 'Pir kêm ew dipeyive.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Not only ... but also yapısında devrik',
        examples: [
          EnGrammarExample(en: 'Not only did he sing, but he also danced.', ku: 'Ne tenê wî stira, lê belê reqisand jî.'),
        ],
      ),
    ],
  ),
];
