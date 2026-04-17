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

  // ═══ B2 — Upper-intermediate (Berfireh) ══════════════════════
  EnGrammarTopic(
    id: 'b2_reported_speech',
    level: 'B2',
    titleEn: 'Reported Speech',
    titleKu: 'Axaftina Neqilkirî',
    emoji: '💬',
    summaryKu: 'Gotinek kesek din tê neqil kirin: dem paşde diçe, cînav diguhere. "I am happy" → He said he was happy.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Dem guhartin: present → past, past → past perfect, will → would, can → could',
        examples: [
          EnGrammarExample(en: 'She said she was tired.', ku: 'Wê got ku ew westiyayî bû.'),
          EnGrammarExample(en: 'He told me he had finished.', ku: 'Wî ji min re got ku wî qedandibû.'),
          EnGrammarExample(en: 'They said they would come.', ku: 'Wan got ku ew ê bên.'),
        ],
        noteKu: 'Kurmancî de "wî got ku..." forma rasterast heye, lê dem guhartin wek Îngilîzî nîne. Ev cudahiyeke girîng e.',
      ),
      EnGrammarRule(
        ruleKu: 'Pirs: if/whether bi kar tîne, peyivan wek hevoka normal rêz dike',
        examples: [
          EnGrammarExample(en: 'She asked if I was ready.', ku: 'Wê pirsî ku gelo ez amade me.'),
          EnGrammarExample(en: 'He asked where I lived.', ku: 'Wî pirsî ku ez li ku dijîm.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Ferman/daxwaz: tell/ask + object + to + verb',
        examples: [
          EnGrammarExample(en: 'She told me to wait.', ku: 'Wê ji min re got ku ez bisekinim.'),
          EnGrammarExample(en: 'He asked her not to leave.', ku: 'Wî jê xwest ku neçe.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Zaman/cih peyvên diguherin: now → then, today → that day, here → there, tomorrow → the next day',
        examples: [
          EnGrammarExample(en: 'He said he would come the next day.', ku: 'Wî got ku ew ê roja din were.'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'b2_gerund_infinitive',
    level: 'B2',
    titleEn: 'Gerunds vs Infinitives',
    titleKu: 'Gerund (-ing) û Infinitive (to + verb)',
    emoji: '🔁',
    summaryKu: 'Piştî hin lekeran -ing (gerund), piştî hinan jî to + verb (infinitive) tê. Divê ferq were zanîn.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Gerund (-ing) piştî: enjoy, avoid, finish, mind, suggest, consider, deny, admit',
        examples: [
          EnGrammarExample(en: 'I enjoy reading books.', ku: 'Ez ji xwendina pirtûkan hez dikim.'),
          EnGrammarExample(en: 'She avoided answering the question.', ku: 'Wê ji bersivdana pirsê dûr ket.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Infinitive (to + verb) piştî: want, need, decide, hope, promise, offer, agree, refuse',
        examples: [
          EnGrammarExample(en: 'I want to learn English.', ku: 'Ez dixwazim Îngilîzî hîn bibim.'),
          EnGrammarExample(en: 'He decided to stay.', ku: 'Wî biryar da ku bimîne.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Herdu jî dibe bi ferqa wateyê: remember, forget, try, stop, regret',
        examples: [
          EnGrammarExample(en: 'I stopped smoking. (nema dikişandim)', ku: 'Min cixare kişandin raweste kir.'),
          EnGrammarExample(en: 'I stopped to smoke. (rawestiyam ku bikişînim)', ku: 'Ez rawestiyam ku cixare bikişînim.'),
          EnGrammarExample(en: 'Remember to lock the door.', ku: 'Bîr neke ku derî kilît bikî.'),
        ],
        noteKu: 'Kurmancî de vê ferq bi veqetandekên zemanî tê çareser kirin, ne bi forma lekerê. Divê haydar be.',
      ),
      EnGrammarRule(
        ruleKu: 'Piştî daçekan (prepositions) her tim gerund (-ing) tê',
        examples: [
          EnGrammarExample(en: 'She is good at singing.', ku: 'Ew di stiranê de jêhatî ye.'),
          EnGrammarExample(en: 'Thank you for helping me.', ku: 'Spas ji bo alîkariya te.'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'b2_modals_past',
    level: 'B2',
    titleEn: 'Advanced Modals (must have, could have, should have)',
    titleKu: 'Modalên Pêşketî (must have, could have, should have)',
    emoji: '🎯',
    summaryKu: 'Modal + have + past participle: li ser bûyerên borî texmîn, poşmanî, îmkan an rexne tînin ziman.',
    rules: [
      EnGrammarRule(
        ruleKu: 'must have + V3: texmîna piştrast ya borî (teqez wisa bûye)',
        examples: [
          EnGrammarExample(en: 'She must have left already.', ku: 'Teqez ew berê çûye.'),
          EnGrammarExample(en: 'You must have been tired.', ku: 'Divê tu westiyayî bûyî.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'could have + V3: îmkan hebû lê nebû; might have: belkî bû',
        examples: [
          EnGrammarExample(en: 'You could have told me!', ku: 'Te dikarîbû ji min re bigota!'),
          EnGrammarExample(en: 'He might have forgotten.', ku: 'Belkî ew ji bîr kiribe.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'should have + V3: diviyabû lê nebû (poşmanî/rexne)',
        examples: [
          EnGrammarExample(en: 'I should have studied harder.', ku: 'Min diviyabû baştir bixwenda.'),
          EnGrammarExample(en: 'You shouldn\'t have said that.', ku: 'Diviyabû te ew negota.'),
        ],
        noteKu: 'Kurmancî de "diviyabû..." forma pêşniyarê ya borî heye. Bi taybet "should have" pê re hevweşîn e.',
      ),
      EnGrammarRule(
        ruleKu: 'can\'t have + V3: nebûyîna teqez ya borî (ne mumkin e ku bûbe)',
        examples: [
          EnGrammarExample(en: 'She can\'t have seen us.', ku: 'Ne mumkin e wê em dîtibin.'),
          EnGrammarExample(en: 'They can\'t have arrived yet.', ku: 'Hê ne mumkin e ew gihîştibin.'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'b2_future_perfect',
    level: 'B2',
    titleEn: 'Future Perfect Tense',
    titleKu: 'Demê Dahatû ya Têkûz',
    emoji: '🔮',
    summaryKu: 'Berî demek di pêşerojê de karek dê qediyabe: will have + past participle.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Avakirin: subject + will have + V3',
        examples: [
          EnGrammarExample(en: 'By 2030, I will have graduated.', ku: 'Heta 2030, ez ê dibistanê qedandibim.'),
          EnGrammarExample(en: 'She will have finished by then.', ku: 'Heta wê demê, wê qedandibe.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Bi "by" (heta), "by the time" (heta ku) pir tê bikaranîn',
        examples: [
          EnGrammarExample(en: 'By the time you arrive, we will have eaten.', ku: 'Heta ku tu bigihêjî, me xwarin xwaribe.'),
          EnGrammarExample(en: 'By next year, they will have moved.', ku: 'Heta sala bê, ew barkiribin.'),
        ],
        noteKu: 'Kurmancî de "heta ew demê ez ê... bikim" forma nêzîk heye, lê ji bo pêşeroja têkûz peyveke tam tune.',
      ),
      EnGrammarRule(
        ruleKu: 'Pirs û neyînî: Will you have finished? / I won\'t have finished.',
        examples: [
          EnGrammarExample(en: 'Will you have read it by Monday?', ku: 'Heta Duşemê te ew xwendibe?'),
          EnGrammarExample(en: 'I won\'t have done it by then.', ku: 'Heta wê demê min ew nekiribe.'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'b2_past_perfect_continuous',
    level: 'B2',
    titleEn: 'Past Perfect Continuous',
    titleKu: 'Demê Borî yê Têkûz yê Berdewam',
    emoji: '⏳',
    summaryKu: 'Karek ku berî demek borî dest pê kiribû û heta wê demê berdewam bû: had been + verb-ing.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Avakirin: had been + V-ing',
        examples: [
          EnGrammarExample(en: 'She had been working for 5 hours when I arrived.', ku: 'Dema ku ez gihîştim, 5 demjimêr bû ew dixebitî.'),
          EnGrammarExample(en: 'We had been waiting for an hour.', ku: 'Demjimêrek bû em li bendê bûn.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Wateya giştî: berdewamî + sedem-encam di demê borî de',
        examples: [
          EnGrammarExample(en: 'He was tired because he had been running.', ku: 'Ew westiyayî bû çimkî bezîbû.'),
          EnGrammarExample(en: 'Her eyes were red; she had been crying.', ku: 'Çavên wê sor bûn; ew giriyabû.'),
        ],
        noteKu: 'Kurmancî de "demek dirêj bû ku ez dixwendim" dişibihe, lê forma gramatîk ne wek Îngilîzî zelal e.',
      ),
      EnGrammarRule(
        ruleKu: 'Bi "for" (demê dirêj) û "since" (ji kengî) re tê bikaranîn',
        examples: [
          EnGrammarExample(en: 'They had been living there since 2010.', ku: 'Ji 2010 ve li wir dijiyan.'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'b2_mixed_conditionals',
    level: 'B2',
    titleEn: 'Mixed Conditionals',
    titleKu: 'Hevokên Şertî yên Tevlihev',
    emoji: '🧩',
    summaryKu: 'Dema ku şert û encam di demên cuda de ne: borî bi niha, an niha bi borî re tê tevlihev kirin.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Şert borî, encam niha: If + past perfect, would + verb',
        examples: [
          EnGrammarExample(en: 'If I had studied medicine, I would be a doctor now.', ku: 'Ger min bijîşkî xwendibûya, ez ê niha bijîşk bama.'),
          EnGrammarExample(en: 'If she had left earlier, she would be here.', ku: 'Ger ew zûtir derketibûya, ew ê niha li vir bûya.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Şert niha, encam borî: If + past, would have + V3',
        examples: [
          EnGrammarExample(en: 'If I were rich, I would have bought that house.', ku: 'Ger ez dewlemend bama, min ê ew xanî kirîbûya.'),
          EnGrammarExample(en: 'If he knew English, he would have passed.', ku: 'Ger wî Îngilîzî bizaniya, wî ê derbas bikira.'),
        ],
        noteKu: 'Ev forma pir hûrgilî ye; Kurmancî de ew qas demên cuda di yek hevokê de nayên hev. Pir tê xebitandin.',
      ),
      EnGrammarRule(
        ruleKu: 'Wate: encamên niha yên biryarên borî, an berovajî',
        examples: [
          EnGrammarExample(en: 'If I had taken that job, I would be in London now.', ku: 'Ger min ew kar qebûl kiribûya, ez ê niha li Londonê bama.'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'b2_participle_clauses',
    level: 'B2',
    titleEn: 'Participle Clauses (having done)',
    titleKu: 'Hevokên Partîsîp (having done)',
    emoji: '✂️',
    summaryKu: 'Ji bo kurtkirina du hevokan yek dibe: "Having + V3" wateya "piştî ku..." dide.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Having + V3: tiştek berî çalakiya sereke qediyaye',
        examples: [
          EnGrammarExample(en: 'Having finished the work, he went home.', ku: 'Piştî ku wî kar qedand, çû malê.'),
          EnGrammarExample(en: 'Having eaten, we left.', ku: 'Piştî ku me xwar, em derketin.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'V-ing (present participle): dema ku du çalakî hemdem in',
        examples: [
          EnGrammarExample(en: 'Walking home, I saw an old friend.', ku: 'Dema ez diçûm malê, min hevalekî kevn dît.'),
          EnGrammarExample(en: 'Smiling, she opened the door.', ku: 'Bi ken, wê derî vekir.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'V3 (past participle): wateya pasîf dide',
        examples: [
          EnGrammarExample(en: 'Written in 1920, the book is still popular.', ku: 'Pirtûk ku di 1920 de hatî nivîsîn, hê populer e.'),
          EnGrammarExample(en: 'Shocked by the news, she sat down.', ku: 'Ji nûçeyê şaşwaz bû, ew rûnişt.'),
        ],
        noteKu: 'Kurmancî de ev forma kurtkirin bi cuda ye — bi "ku" an "dema ku" tê avakirin. Îngilîzî kurttir e.',
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'b2_passive_modals',
    level: 'B2',
    titleEn: 'Passive with Modals',
    titleKu: 'Passive bi Modalan re',
    emoji: '🔐',
    summaryKu: 'Modal + be + past participle: tişt divê/dikare/dibe were kirin.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Avakirin: modal + be + V3',
        examples: [
          EnGrammarExample(en: 'This must be done today.', ku: 'Divê ev îro were kirin.'),
          EnGrammarExample(en: 'The door can be opened easily.', ku: 'Derî bi hêsanî dikare vebe.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Bi forma borî: modal + have been + V3',
        examples: [
          EnGrammarExample(en: 'The letter should have been sent yesterday.', ku: 'Diviyabû name duh bihata şandin.'),
          EnGrammarExample(en: 'It might have been stolen.', ku: 'Belkî hatibe dizîn.'),
        ],
        noteKu: 'Kurmancî ergatîfê nêzîkî passive ye, lê bi modalan re avakirin pir cuda ye.',
      ),
      EnGrammarRule(
        ruleKu: 'Di talîmat û nivîsên fermî de pir tê bikaranîn',
        examples: [
          EnGrammarExample(en: 'Forms must be submitted by Friday.', ku: 'Divê form heta Înê bêne şandin.'),
          EnGrammarExample(en: 'The machine should not be used without training.', ku: 'Divê makîn bêyî perwerdehiyê neyê bikaranîn.'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'b2_subjunctive',
    level: 'B2',
    titleEn: 'Subjunctive Mood (I suggest that he be...)',
    titleKu: 'Subjunctive — Forma Pêşniyar/Daxwazê',
    emoji: '🙏',
    summaryKu: 'Piştî lekerên wek suggest, insist, demand, recommend: that + subject + base form (bêyî -s).',
    rules: [
      EnGrammarRule(
        ruleKu: 'Avakirin: suggest/demand/insist + that + S + base verb (ne is/was; tenê "be")',
        examples: [
          EnGrammarExample(en: 'I suggest that he be on time.', ku: 'Ez pêşniyar dikim ku ew li ser wextê be.'),
          EnGrammarExample(en: 'She demanded that he leave.', ku: 'Wê daxwaz kir ku ew biçe.'),
          EnGrammarExample(en: 'I insist that she come with us.', ku: 'Ez israr dikim ku ew bi me re bê.'),
        ],
        noteKu: 'EN ZEHMET: 3. kes de "he comes" NE, "he come" tê gotin. Pir xerîb xuya dike lê rast e.',
      ),
      EnGrammarRule(
        ruleKu: 'Piştî rengdêrên "important, necessary, essential, vital": It is important that S + base verb',
        examples: [
          EnGrammarExample(en: 'It is important that he be informed.', ku: 'Girîng e ku ew were agahdar kirin.'),
          EnGrammarExample(en: 'It is necessary that she know the truth.', ku: 'Pêwîst e ku ew rastiyê bizane.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Forma fermî ye; di axaftina rojane de "should" jî tê bikaranîn',
        examples: [
          EnGrammarExample(en: 'I suggest that he should come. (less formal)', ku: 'Ez pêşniyar dikim ku ew were.'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'b2_causative',
    level: 'B2',
    titleEn: 'Causative (have something done)',
    titleKu: 'Causative — Bi yekî din bikin',
    emoji: '🛠️',
    summaryKu: 'Dema em tiştekî bi kesekî din dikin, ne bi xwe: have/get + object + V3.',
    rules: [
      EnGrammarRule(
        ruleKu: 'have + object + V3: em xwe nakin, kesek din dike',
        examples: [
          EnGrammarExample(en: 'I had my car repaired.', ku: 'Min ereba xwe da tamîr kirin.'),
          EnGrammarExample(en: 'She had her hair cut.', ku: 'Wê porê xwe da birîn.'),
        ],
        noteKu: 'FERQA GIRÎNG: "I cut my hair" = ez bi xwe birîm. "I had my hair cut" = min da birîn (berberî).',
      ),
      EnGrammarRule(
        ruleKu: 'get + object + V3: eynî wate, nefermîtir',
        examples: [
          EnGrammarExample(en: 'I got my phone fixed.', ku: 'Min telefona xwe da tamîr kirin.'),
          EnGrammarExample(en: 'We got the house painted.', ku: 'Me xanî da boyax kirin.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'have/make + someone + base verb: yekî mecbûr bike tiştekî bike (active)',
        examples: [
          EnGrammarExample(en: 'I had him clean the room.', ku: 'Min bi wî re ode paqij kir.'),
          EnGrammarExample(en: 'The teacher made us study.', ku: 'Mamoste em mecbûr kirin ku bixwînin.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Forma borî ya ne-dilxwaz: had + object + V3 (serhat/qeza)',
        examples: [
          EnGrammarExample(en: 'He had his wallet stolen.', ku: 'Cûzdana wî hat dizîn.'),
          EnGrammarExample(en: 'She had her phone taken.', ku: 'Telefona wê hat girtin.'),
        ],
      ),
    ],
  ),

  // ═══ C1 — Advanced (Pêşketî) ═════════════════════════════════
  EnGrammarTopic(
    id: 'c1_inversion_advanced',
    level: 'C1',
    titleEn: 'Advanced Inversion (Had I known, Not only)',
    titleKu: 'Inversion ya Pêşketî (Had I known...)',
    emoji: '🎩',
    summaryKu: 'Ji bo giraniyê an di nivîsa edebî de: "Had I known" = "If I had known", "Not only did he..."',
    rules: [
      EnGrammarRule(
        ruleKu: 'Had + S + V3 = If + S + had + V3 (conditional without "if")',
        examples: [
          EnGrammarExample(en: 'Had I known, I would have come.', ku: 'Min zanibûya, ez ê hatibama.'),
          EnGrammarExample(en: 'Had she studied, she would have passed.', ku: 'Wê xwendibûya, wê ê derbas bikira.'),
        ],
        noteKu: 'Forma pir edebî/resmî; di axaftinê de "If I had known" tê bikaranîn.',
      ),
      EnGrammarRule(
        ruleKu: 'Not only ... but also: her du beş devrik dibin',
        examples: [
          EnGrammarExample(en: 'Not only did he win, but he also broke the record.', ku: 'Ne tenê wî qezenc kir, wî rekor jî şikand.'),
          EnGrammarExample(en: 'Not only is she smart, but she is also kind.', ku: 'Ne tenê ew jîr e, lê dilovan jî ye.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Should + S + V (formal conditional): Should you need help, call me.',
        examples: [
          EnGrammarExample(en: 'Should you need help, call me.', ku: 'Ger tu hewceyî alîkariyê bibî, gazî min bike.'),
          EnGrammarExample(en: 'Were I to win, I would be happy.', ku: 'Ger ez qezenc bikim, ez ê kêfxweş bim.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Only + time/place: "Only then did I realize..."',
        examples: [
          EnGrammarExample(en: 'Only then did I understand.', ku: 'Tenê wê gavê min fam kir.'),
          EnGrammarExample(en: 'Only after the meeting did she speak.', ku: 'Tenê piştî civînê ew peyivî.'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'c1_cleft_sentences',
    level: 'C1',
    titleEn: 'Cleft Sentences (It was X who...)',
    titleKu: 'Hevokên Dabeşkirî (Cleft)',
    emoji: '🔦',
    summaryKu: 'Ji bo giranîdana li ser beşek taybet a hevokê: It was X who/that... / What I need is...',
    rules: [
      EnGrammarRule(
        ruleKu: 'It-cleft: It + be + X + who/that... (giranî li X)',
        examples: [
          EnGrammarExample(en: 'It was John who broke the window.', ku: 'Yê ku cam şikand John bû.'),
          EnGrammarExample(en: 'It is money that he wants.', ku: 'Ya ku ew dixwaze pere ye.'),
          EnGrammarExample(en: 'It was yesterday that she arrived.', ku: 'Duh bû ku ew gihîşt.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Wh-cleft: What + clause + is/was + X',
        examples: [
          EnGrammarExample(en: 'What I need is a break.', ku: 'Ya ku ez jê re hewce me bêhnvedan e.'),
          EnGrammarExample(en: 'What she said was shocking.', ku: 'Ya ku wê got şaşwaz bû.'),
        ],
        noteKu: 'Kurmancî de bi "ya ku..." forma dişibe, lê wekheviya tam nîne. Ji bo giraniyê pir bi fêde.',
      ),
      EnGrammarRule(
        ruleKu: 'All-cleft: All (that) + S + V + is/was + X',
        examples: [
          EnGrammarExample(en: 'All I want is peace.', ku: 'Tenê ya ku ez dixwazim aşitî ye.'),
          EnGrammarExample(en: 'All he did was complain.', ku: 'Tevahiya ya ku wî kir gilî bû.'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'c1_emphasis_do',
    level: 'C1',
    titleEn: 'Emphatic Do (do + verb)',
    titleKu: 'Giranîdan bi "do" re',
    emoji: '💥',
    summaryKu: 'Ji bo giranîdana li ser lekerê: do/does/did + base verb. "I do like it" = bi rastî ez jê hez dikim.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Avakirin: do/does/did + base verb (ne soru, ne neyînî)',
        examples: [
          EnGrammarExample(en: 'I do love you.', ku: 'Bi rastî ez ji te hez dikim.'),
          EnGrammarExample(en: 'She does understand.', ku: 'Bi rastî ew fam dike.'),
          EnGrammarExample(en: 'He did call yesterday.', ku: 'Bi rastî wî duh gazî kir.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Bi gelemperî ji bo red kirina tiştek/beraberî tê bikaranîn',
        examples: [
          EnGrammarExample(en: 'You don\'t listen! — I DO listen!', ku: 'Tu guhdarî nakî! — Bi rastî ez guhdarî dikim!'),
          EnGrammarExample(en: 'He did try, but he failed.', ku: 'Wî bi rastî hewl da, lê serneket.'),
        ],
        noteKu: 'Kurmancî de bi "bi rastî", "teqez" peyvan giranî tê dayîn. Îngilîzî "do" di nav hevokê de ev karî dike.',
      ),
      EnGrammarRule(
        ruleKu: 'Di fermanan de jî: Do come in! (kerem bike were hundir!)',
        examples: [
          EnGrammarExample(en: 'Do come in!', ku: 'Kerem bike were hundir!'),
          EnGrammarExample(en: 'Do tell me more.', ku: 'Kerem bike zêdetir ji min re bêje.'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'c1_fronting',
    level: 'C1',
    titleEn: 'Fronting (Pêşxistina Beş)',
    titleKu: 'Fronting — Pêşxistina Beşek',
    emoji: '⬅️',
    summaryKu: 'Beşek hevokê tê pêş (object, adverbial) ji bo giranîdan an girêdana nivîsê.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Object fronting: nesne tê pêş — "This book I love."',
        examples: [
          EnGrammarExample(en: 'This book I really enjoyed.', ku: 'Ji vê pirtûkê min bi rastî kêf kir.'),
          EnGrammarExample(en: 'His honesty I admire.', ku: 'Ji durustiya wî ez heyret dikim.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Adverbial fronting: zarf/cih tê pêş — "In the corner sat an old man."',
        examples: [
          EnGrammarExample(en: 'In the garden stood a huge tree.', ku: 'Li baxçe darek pir mezin hebû.'),
          EnGrammarExample(en: 'Down the street came a parade.', ku: 'Ji kolanê pêşengek hat.'),
        ],
        noteKu: 'Forma pir edebî; di nivîsên fiction/povest de zêde tê dîtin.',
      ),
      EnGrammarRule(
        ruleKu: 'Ji bo girêdana nivîsê: tiştê ku berê hatî gotin, niha li dest dikeve',
        examples: [
          EnGrammarExample(en: 'Such behavior we cannot accept.', ku: 'Em nikarin tevgerek wiha qebûl bikin.'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'c1_ellipsis',
    level: 'C1',
    titleEn: 'Ellipsis (Peyvên Ji Nav Derketin)',
    titleKu: 'Ellipsis — Dergirtina Peyvan',
    emoji: '✂️',
    summaryKu: 'Di axaftinê û nivîsê de peyvên ku tên fam kirin tên derxistin: "She can sing and (she can) dance."',
    rules: [
      EnGrammarRule(
        ruleKu: 'Subject ellipsis: dema du lekerên eynî kes in, duyemîn bê kes',
        examples: [
          EnGrammarExample(en: 'She sings and dances.', ku: 'Ew distire û direqise.'),
          EnGrammarExample(en: 'He came in and sat down.', ku: 'Ew hat hundir û rûnişt.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Auxiliary ellipsis: alîkar leker tê dergirtin',
        examples: [
          EnGrammarExample(en: 'She can swim better than I can (swim).', ku: 'Ew ji min çêtir dikare avjenî bike.'),
          EnGrammarExample(en: 'I haven\'t finished, but he has (finished).', ku: 'Min neqedand, lê wî qedand.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Bi hev-peyvan: "and so do I" / "neither do I" forma kurt',
        examples: [
          EnGrammarExample(en: 'I love coffee. — So do I.', ku: 'Ez ji qehweyê hez dikim. — Ez jî.'),
          EnGrammarExample(en: 'She doesn\'t smoke. — Neither do I.', ku: 'Ew cixarê nakişîne. — Ez jî na.'),
        ],
        noteKu: 'Kurmancî de "ez jî", "ez jî na" formên kurt hene û gelekî nêzîkî Îngilîzî ne.',
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'c1_advanced_connectors',
    level: 'C1',
    titleEn: 'Advanced Connectors (notwithstanding, albeit, whereas)',
    titleKu: 'Girêdekên Pêşketî',
    emoji: '🔗',
    summaryKu: 'Di nivîsa akademîk û fermî de girêdekên pêşketî: notwithstanding, albeit, whereas, nevertheless.',
    rules: [
      EnGrammarRule(
        ruleKu: 'notwithstanding = bi rağmen (formal)',
        examples: [
          EnGrammarExample(en: 'Notwithstanding the rain, we went out.', ku: 'Tevî baranê, em derketin.'),
          EnGrammarExample(en: 'Notwithstanding his efforts, he failed.', ku: 'Tevî hewldanên xwe, ew serneket.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'albeit = her çiqas, tevî ku (kurt ji "although it be")',
        examples: [
          EnGrammarExample(en: 'The project was successful, albeit expensive.', ku: 'Proje bi ser ket, her çiqas biha bû.'),
          EnGrammarExample(en: 'He accepted, albeit reluctantly.', ku: 'Wî qebûl kir, her çiqas bi dudilî.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'whereas = lê / bi berovajî (ji bo berawirdkirinê)',
        examples: [
          EnGrammarExample(en: 'He is quiet, whereas his brother is loud.', ku: 'Ew bêdeng e, lê birayê wî qerebalix e.'),
          EnGrammarExample(en: 'Some people love it, whereas others hate it.', ku: 'Hinek jê hez dikin, lê yên din jê nefret dikin.'),
        ],
        noteKu: 'Van girêdekan di axaftinê de hindik tên bikaranîn — bi taybetî di nivîsên akademîk de.',
      ),
      EnGrammarRule(
        ruleKu: 'nevertheless / nonetheless = tevî wê jî, lê belê',
        examples: [
          EnGrammarExample(en: 'It was hard; nevertheless, he succeeded.', ku: 'Zehmet bû; tevî wê, ew bi ser ket.'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'c1_phrasal_verbs_3',
    level: 'C1',
    titleEn: 'Phrasal Verbs with 3 Particles',
    titleKu: 'Lekerên Frazal bi 3 Perçeyan',
    emoji: '🧱',
    summaryKu: 'Verb + adverb + preposition: look forward to, put up with, come up with, get away with.',
    rules: [
      EnGrammarRule(
        ruleKu: 'look forward to = li hêviyê bûn (piştre gerund tê)',
        examples: [
          EnGrammarExample(en: 'I look forward to seeing you.', ku: 'Ez li hêviya dîtina te me.'),
          EnGrammarExample(en: 'She looks forward to meeting him.', ku: 'Ew li hêviya civîna bi wî re ye.'),
        ],
        noteKu: 'XETA MEZIN: "to" li vir daçek e, ne infinitive! Piştî wê -ing tê, ne base verb.',
      ),
      EnGrammarRule(
        ruleKu: 'put up with = tehemul kirin',
        examples: [
          EnGrammarExample(en: 'I can\'t put up with this noise.', ku: 'Ez nikarim vê dengê tehemul bikim.'),
          EnGrammarExample(en: 'She puts up with a lot.', ku: 'Ew gelek tiştan tehemul dike.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'come up with = peyda kirin (ramanek/çareyek)',
        examples: [
          EnGrammarExample(en: 'He came up with a great idea.', ku: 'Wî ramanek mezin peyda kir.'),
          EnGrammarExample(en: 'We need to come up with a solution.', ku: 'Divê em çareyekê peyda bikin.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'get away with = xilas bûn ji (cezayê tiştê xirab)',
        examples: [
          EnGrammarExample(en: 'He got away with cheating.', ku: 'Ew ji cezayê xapandinê xilas bû.'),
          EnGrammarExample(en: 'You can\'t get away with this.', ku: 'Tu nikarî vê xilas bikî.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'run out of = xilas bûn / neman',
        examples: [
          EnGrammarExample(en: 'We ran out of milk.', ku: 'Şîrê me xilas bû.'),
          EnGrammarExample(en: 'I\'m running out of time.', ku: 'Dema min xilas dibe.'),
        ],
      ),
    ],
  ),

  // ═══ C2 — Mastery (Asta Herî Bilind) ═════════════════════════
  EnGrammarTopic(
    id: 'c2_archaic_forms',
    level: 'C2',
    titleEn: 'Literary/Archaic Forms (lest, whence, thither)',
    titleKu: 'Formên Edebî/Kevnare',
    emoji: '📜',
    summaryKu: 'Di nivîsa edebî, qanûnî, an dînî de: lest, whence, whither, thither, forsooth, hitherto.',
    rules: [
      EnGrammarRule(
        ruleKu: 'lest = ji ber tirsa ku... nebe (+ subjunctive)',
        examples: [
          EnGrammarExample(en: 'He whispered lest he be heard.', ku: 'Wî pisînî kir da ku neyê bihîstin.'),
          EnGrammarExample(en: 'She wrote it down lest she forget.', ku: 'Wê nivîsand da ku ji bîr neke.'),
        ],
        noteKu: 'Pir kevn/edebî ye; di axaftinê de "so that ... doesn\'t" tê bikaranîn.',
      ),
      EnGrammarRule(
        ruleKu: 'whence = ji ku ve / whither = bo ku / thither = ber bi wir',
        examples: [
          EnGrammarExample(en: 'Return whence you came.', ku: 'Vegere ji ku ve tu hatî.'),
          EnGrammarExample(en: 'Whither are you going?', ku: 'Tu bo ku diçî?'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'hitherto = heta niha / thenceforth = ji wê ve',
        examples: [
          EnGrammarExample(en: 'Hitherto unknown facts emerged.', ku: 'Heta niha rastiyên nenas derketin holê.'),
          EnGrammarExample(en: 'Thenceforth, he lived in peace.', ku: 'Ji wê demê ve, ew di aşitiyê de jiya.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Thou/thee/thy (kevn) = you/your — di Încîl û Shakespeare de',
        examples: [
          EnGrammarExample(en: 'Thou shalt not kill.', ku: 'Tu nabe yê bikujî.'),
          EnGrammarExample(en: 'What sayest thou?', ku: 'Tu çi dibêjî?'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'c2_formal_subjunctive',
    level: 'C2',
    titleEn: 'Subjunctive in Formal Writing',
    titleKu: 'Subjunctive di Nivîsa Fermî de',
    emoji: '✍️',
    summaryKu: 'Di nivîsa fermî, qanûnî, akademîk de forma subjunctive pir tê bikaranîn — were, be, have forma binyad.',
    rules: [
      EnGrammarRule(
        ruleKu: 'If I were you (ne "was") — forma subjunctive ya fermî',
        examples: [
          EnGrammarExample(en: 'If I were you, I would resign.', ku: 'Ger ez tu bama, ez ê îstifa bidama.'),
          EnGrammarExample(en: 'I wish I were taller.', ku: 'Xwezî ez dirêjtir bama.'),
        ],
        noteKu: 'Di axaftinê de "If I was" tê dîtin lê di nivîsa fermî de "If I were" rast e.',
      ),
      EnGrammarRule(
        ruleKu: 'Be it... / Come what may / Suffice it to say — îfadeyên fikse',
        examples: [
          EnGrammarExample(en: 'Be it known to all...', ku: 'Ji herkesî re were zanîn ku...'),
          EnGrammarExample(en: 'Come what may, we will succeed.', ku: 'Çi bibe, em ê bi ser bikevin.'),
          EnGrammarExample(en: 'Suffice it to say, he resigned.', ku: 'Bese ku bê gotin, wî îstifa kir.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Di nameyên fermî de: "May it please the court..."',
        examples: [
          EnGrammarExample(en: 'May it please the court to consider...', ku: 'Xwezî dadgeh bixwaze bifikire...'),
          EnGrammarExample(en: 'Long live the king!', ku: 'Padîşah biji!'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Di qanûn û biryaran de: "The court orders that he be released."',
        examples: [
          EnGrammarExample(en: 'The court orders that he be released immediately.', ku: 'Dadgeh biryar dide ku ew yekser were berdan.'),
          EnGrammarExample(en: 'We ask that the matter be reviewed.', ku: 'Em daxwaz dikin ku mijar were nirxandin.'),
        ],
      ),
    ],
  ),

  EnGrammarTopic(
    id: 'c2_nominalization',
    level: 'C2',
    titleEn: 'Complex Nominalization',
    titleKu: 'Nominalîzasyona Tevlihev',
    emoji: '🏛️',
    summaryKu: 'Guhertina lekeran û rengdêran bo navdêran di nivîsa akademîk de: "They decided" → "Their decision was..."',
    rules: [
      EnGrammarRule(
        ruleKu: 'Leker → Navdêr: decide → decision, analyze → analysis, imply → implication',
        examples: [
          EnGrammarExample(en: 'Their decision to leave was sudden.', ku: 'Biryara wan a ku herin ji nişka ve bû.'),
          EnGrammarExample(en: 'The analysis of the data showed trends.', ku: 'Analîza daneyan meylan nîşan da.'),
        ],
        noteKu: 'Di nivîsa akademîk de nominalîzasyon giranî dide objektîvî û fermîtî. Lê zêde bikaranîn hevokan giran dike.',
      ),
      EnGrammarRule(
        ruleKu: 'Rengdêr → Navdêr: happy → happiness, difficult → difficulty, able → ability',
        examples: [
          EnGrammarExample(en: 'The difficulty of the task was underestimated.', ku: 'Zehmetiya erkê hate kêmtexmîn kirin.'),
          EnGrammarExample(en: 'His ability to learn quickly impressed us.', ku: 'Şiyana wî ya zû hîn bûnê me heyret kir.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Forma passive + nominalization di zimanê akademîk de pir berfireh',
        examples: [
          EnGrammarExample(en: 'The implementation of the policy resulted in improvements.', ku: 'Cîbicîkirina sîyasetê bi başbûnan encam da.'),
          EnGrammarExample(en: 'A reduction in costs was observed.', ku: 'Kêmbûnek di lêçûnan de hate dîtin.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Zincîrên navdêrî (noun phrases) dirêj: "the evaluation of student performance criteria"',
        examples: [
          EnGrammarExample(en: 'The evaluation of student performance criteria is essential.', ku: 'Nirxandina pîvanên performansa xwendekaran pêwîst e.'),
          EnGrammarExample(en: 'Government policy implementation strategies vary.', ku: 'Stratejiyên cîbicîkirina sîyaseta hikûmetê diguherin.'),
        ],
        noteKu: 'Ev zincîrên dirêj di Kurmancî de bi "ya/yê + navdêr" tên avakirin. Xwendin û nivîsa akademîk dixwazin vê şîyanê.',
      ),
    ],
  ),
];
