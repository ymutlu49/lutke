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
  final List<EnQuizQuestion> quizQuestions;

  const EnGrammarTopic({
    required this.id,
    required this.level,
    required this.titleEn,
    required this.titleKu,
    required this.emoji,
    required this.summaryKu,
    required this.rules,
    this.quizQuestions = const [],
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

class EnQuizQuestion {
  final String questionEn;
  final String? questionKu;
  final List<String> options;
  final int correctIndex;
  const EnQuizQuestion({
    required this.questionEn,
    this.questionKu,
    required this.options,
    required this.correctIndex,
  });
}

// ════════════════════════════════════════════════════════════════
// QUIZ BANKS — 10 questions per topic (rule recognition / fill-in / error / transformation / applied)
// ════════════════════════════════════════════════════════════════

const List<EnQuizQuestion> _qA1Be = [
  EnQuizQuestion(questionEn: 'I ___ a student.', options: ['are', 'is', 'am'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'She ___ my sister.', options: ['is', 'am', 'are'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'They ___ at home.', options: ['is', 'am', 'are'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'He ___ not tired.', options: ['are', 'is', 'am'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'We ___ ready.', options: ['are', 'am', 'is'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['She is happy.', 'She are happy.', 'She am happy.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['I is not busy.', 'I am not busy.', 'I are not busy.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Make a question: "You are ready."', options: ['Are you ready?', 'You are ready?', 'Is you ready?'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Make negative: "He is here."', options: ['He isn\'t here.', 'He not is here.', 'He don\'t here.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Choose the best reply: "How are you?"', options: ['Yes, I am.', 'I is fine.', 'I am fine, thanks.'], correctIndex: 2),
];

const List<EnQuizQuestion> _qA1Articles = [
  EnQuizQuestion(questionEn: 'I have ___ apple.', options: ['an', 'a', 'the'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'She is ___ teacher.', options: ['an', 'a', 'the'], correctIndex: 1),
  EnQuizQuestion(questionEn: '___ sun is bright today.', options: ['An', 'The', 'A'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'He bought ___ umbrella yesterday.', options: ['an', 'a', 'the'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'I saw ___ cat in the garden.', options: ['a', 'the', 'an'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['He is the teacher of all.', 'He is teacher.', 'He is a teacher.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['I eat an apple.', 'I eat apple.', 'I eat a apple.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Rewrite correctly: "She has idea."', options: ['She has an idea.', 'She has a idea.', 'She has the idea.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Fill in: "I saw a dog. ___ dog was friendly."', options: ['An', 'A', 'The'], correctIndex: 2, questionKu: 'Cara duyem — pirtûk/tişta diyarkirî tê → "the".'),
  EnQuizQuestion(questionEn: 'Choose: "I play ___ guitar."', options: ['the', 'an', 'a'], correctIndex: 0),
];

const List<EnQuizQuestion> _qA1PresentSimple = [
  EnQuizQuestion(questionEn: 'She ___ English every day.', options: ['studies', 'studys', 'study'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'They ___ football on Sundays.', options: ['plays', 'playes', 'play'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'He ___ coffee in the morning.', options: ['drink', 'drinken', 'drinks'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'I ___ to school by bus.', options: ['goes', 'go', 'going'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'My dog ___ every night.', options: ['barking', 'barks', 'bark'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['He doesn\'t likes tea.', 'He doesn\'t like tea.', 'He don\'t like tea.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['Do she work here?', 'Does she work here?', 'Does she works here?'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Rewrite as a question: "She likes pizza."', options: ['Do she like pizza?', 'Does she like pizza?', 'Does she likes pizza?'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Make negative: "They live in Paris."', options: ['They doesn\'t live in Paris.', 'They not live in Paris.', 'They don\'t live in Paris.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which sentence talks about a habit?', options: ['I ate yesterday.', 'I am eating now.', 'I eat breakfast every morning.'], correctIndex: 2),
];

const List<EnQuizQuestion> _qA1Pronouns = [
  EnQuizQuestion(questionEn: 'Subject pronoun for "Ali": ___ is my friend.', options: ['His', 'He', 'Him'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Object pronoun: "I saw ___ at school."', options: ['she', 'hers', 'her'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Possessive: "This is ___ book." (belongs to me)', options: ['my', 'me', 'I'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Fill in: "___ are my classmates."', options: ['Them', 'Their', 'They'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Fill in: "She helps ___ every weekend."', options: ['us', 'our', 'we'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['I and John went home.', 'Me and John went home.', 'John and I went home.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['Give the pen to my.', 'Give the pen to I.', 'Give the pen to me.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Change to possessive: "This book belongs to him."', options: ['This is his book.', 'This is he book.', 'This is him book.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Change the underlined to a pronoun: "Ali and Sara are here." → ___ are here.', options: ['Their', 'They', 'Them'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Fill in: "Our car is red. ___ is blue." (referring to their car)', options: ['Theirs', 'They', 'Them'], correctIndex: 0),
];

const List<EnQuizQuestion> _qA1Plural = [
  EnQuizQuestion(questionEn: 'Plural of "book":', options: ['bookes', 'books', 'bookies'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Plural of "box":', options: ['boxies', 'boxs', 'boxes'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Plural of "child":', options: ['children', 'childes', 'childs'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Plural of "man":', options: ['men', 'mens', 'mans'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Plural of "bus":', options: ['buses', 'bus', 'buss'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['Two feets.', 'Two foots.', 'Two feet.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['Three womans.', 'Three womens.', 'Three women.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Singular → plural: "tooth" → ___', options: ['teeths', 'teeth', 'tooths'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Singular → plural: "mouse" (animal) → ___', options: ['mouses', 'mices', 'mice'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Fill in: "I have many ___."', options: ['friends', 'friendes', 'friend'], correctIndex: 0),
];

const List<EnQuizQuestion> _qA1ThereIs = [
  EnQuizQuestion(questionEn: '___ a book on the table.', options: ['It is', 'There are', 'There is'], correctIndex: 2),
  EnQuizQuestion(questionEn: '___ many people here.', options: ['They are', 'There is', 'There are'], correctIndex: 2),
  EnQuizQuestion(questionEn: '___ any milk in the fridge?', options: ['Are there', 'There is', 'Is there'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'There ___ two cats in the garden.', options: ['is', 'am', 'are'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'There ___ a problem.', options: ['are', 'has', 'is'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['There are three books.', 'There is three books.', 'Is three books.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['There is a man at the door.', 'It is a man at the door.', 'Has a man at the door.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Make negative: "There is some sugar."', options: ['There no is sugar.', 'There hasn\'t sugar.', 'There isn\'t any sugar.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Make question: "There are some chairs."', options: ['Is there chairs?', 'There are any chairs?', 'Are there any chairs?'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Choose: "___ any bread?"', options: ['Have there', 'Is there', 'Are there'], correctIndex: 1),
];

const List<EnQuizQuestion> _qA1PossessiveS = [
  EnQuizQuestion(questionEn: 'This is ___ car. (Ali)', options: ['Ali\'s', 'of Ali', 'Alis'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'That is my ___ book. (brother)', options: ['brother\'s', 'of brother', 'brothers'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Plural: "the ___ room" (boys)', options: ['boys', 'boy\'s', 'boys\''], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Irregular plural: "the ___ coats" (children)', options: ['children\'s', 'childrens', 'childrens\''], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['Today\'s weather is nice.', 'The today weather is nice.', 'The weather of today is nice.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['Ali\'s book is here.', 'The book of Ali is here.', 'Ali book is here.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Rewrite: "The car belongs to John."', options: ['Car of John', 'John\'s car', 'Johns car'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Choose: "___ house is big." (my parents)', options: ['My parent\'s', 'My parents\'', 'My parents'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Fill in: "The ___ tail is long." (cat)', options: ['cat\'s', 'cat of', 'cats'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which sentence is WRONG?', options: ['This is my sister\'s phone.', 'This is Ana\'s pen.', 'This is my sisters phone.'], correctIndex: 2),
];

const List<EnQuizQuestion> _qA2GoingTo = [
  EnQuizQuestion(questionEn: 'I ___ visit my grandmother tomorrow. (plan)', options: ['go', 'will', 'am going to'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Look at those dark clouds! It ___ rain.', options: ['rains', 'will', 'is going to'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'She ___ start a new job next month.', options: ['go', 'wills', 'is going to'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'We ___ buy a new car soon.', options: ['is going to', 'are going to', 'will to'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'He ___ study medicine.', options: ['are going to', 'is going to', 'going to'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['I am going to sleep.', 'I going to sleep.', 'I am going sleep.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['She is going to tell him.', 'She is going to tells him.', 'She is go to tell him.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Make negative: "I am going to leave."', options: ['I am going not to leave.', 'I am not going to leave.', 'I don\'t going to leave.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Make question: "You are going to study."', options: ['You are going to study?', 'Do you going to study?', 'Are you going to study?'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Choose: "Be careful! You ___ fall!"', options: ['will', 'go to', 'are going to'], correctIndex: 2),
];

const List<EnQuizQuestion> _qA2CountableUncountable = [
  EnQuizQuestion(questionEn: 'Choose: "How ___ water do you drink?"', options: ['many', 'much', 'any'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Choose: "How ___ friends do you have?"', options: ['lot', 'many', 'much'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'There isn\'t ___ milk.', options: ['much', 'few', 'many'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'I have ___ books.', options: ['a much', 'a lot of', 'much'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is uncountable?', options: ['apple', 'water', 'book'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['I want a bread.', 'I want a breads.', 'I want some bread.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['There are a little apples.', 'There is few apples.', 'There are a few apples.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Choose: "I have ___ time." (not enough)', options: ['few', 'a little', 'a few'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Choose: "We need ___ eggs."', options: ['much', 'a little', 'some'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Fill: "There is ___ sugar in my tea."', options: ['too few', 'too many', 'too much'], correctIndex: 2),
];

const List<EnQuizQuestion> _qA2PastSimple = [
  EnQuizQuestion(questionEn: 'Past of "work":', options: ['worken', 'worked', 'working'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Past of "go":', options: ['went', 'gone', 'goed'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'I ___ (eat) an apple yesterday.', options: ['ate', 'eated', 'eat'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'She ___ (see) a film last night.', options: ['seen', 'seed', 'saw'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'They ___ (play) tennis on Monday.', options: ['play', 'plays', 'played'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['I didn\'t go.', 'I didn\'t went.', 'I didn\'t gone.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['Did she see him?', 'Did she saw him?', 'Does she saw him?'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Change to past: "I take the bus."', options: ['I taked the bus.', 'I took the bus.', 'I taken the bus.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Change to past: "She has a cat."', options: ['She has a cat.', 'She had a cat.', 'She haved a cat.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which time expression fits past simple?', options: ['tomorrow', 'now', 'yesterday'], correctIndex: 2),
];

const List<EnQuizQuestion> _qA2PresentContinuous = [
  EnQuizQuestion(questionEn: 'I ___ (read) a book now.', options: ['am reading', 'was reading', 'read'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'She ___ (write) a letter at the moment.', options: ['is writing', 'writing', 'writes'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'They ___ (run) in the park.', options: ['running', 'are running', 'is running'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'We ___ (study) for the exam.', options: ['are studying', 'is studying', 'studies'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'The baby ___ (sleep) now.', options: ['is sleeping', 'sleeps', 'sleeping'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['He is write a letter.', 'He writing a letter.', 'He is writing a letter.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['They are running.', 'They are runing.', 'They runing.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Change to continuous: "I eat lunch."', options: ['I am eating lunch.', 'I am eat lunch.', 'I eating lunch.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Change to continuous: "She works."', options: ['She is working.', 'She working.', 'She is work.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Choose the sentence about now:', options: ['I am eating breakfast right now.', 'I ate breakfast.', 'I eat breakfast every day.'], correctIndex: 0),
];

const List<EnQuizQuestion> _qA2Comparatives = [
  EnQuizQuestion(questionEn: 'Comparative of "tall":', options: ['tallest', 'more tall', 'taller'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Superlative of "big":', options: ['the biggest', 'the most big', 'the bigest'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'He is ___ than me. (old)', options: ['more old', 'older', 'oldest'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'This dress is ___ than that one. (beautiful)', options: ['more beautiful', 'beautifuler', 'most beautiful'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'She is the ___ student in the class. (good)', options: ['better', 'gooder', 'best'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['He is tall than me.', 'He is taller than me.', 'He is more taller than me.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['This is the best book.', 'This is the most good book.', 'This is the better book.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Change to superlative: "That car is expensive."', options: ['That car is expensiver.', 'That car is more expensive.', 'That car is the most expensive.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Irregular: "bad" → comparative?', options: ['worse', 'badder', 'worst'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Choose: "My English is ___ than yours."', options: ['better', 'gooder', 'best'], correctIndex: 0),
];

const List<EnQuizQuestion> _qA2CanMust = [
  EnQuizQuestion(questionEn: 'I ___ swim very well.', options: ['has to', 'must', 'can'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'You ___ wear a seatbelt in the car.', options: ['can', 'may', 'must'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'She ___ drive; she has a license.', options: ['must', 'can', 'has'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'I ___ work tomorrow. (it is required)', options: ['have to', 'can', 'may'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'He ___ speak three languages.', options: ['must', 'can', 'cans'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['She cans drive.', 'She can drive.', 'She can drives.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['You must not smoke here.', 'You must not to smoke here.', 'You not must smoke here.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Change to negative: "I can come."', options: ['I can\'t come.', 'I not can come.', 'I don\'t can come.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Past of "can":', options: ['can have', 'canned', 'could'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Choose: "Students ___ arrive on time."', options: ['may', 'can', 'must'], correctIndex: 2),
];

const List<EnQuizQuestion> _qB1FirstConditional = [
  EnQuizQuestion(questionEn: 'If it ___ (rain), I will stay home.', options: ['rains', 'rained', 'will rain'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'If you study, you ___ pass the test.', options: ['would', 'will', 'are'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'I will call you if I ___ (have) time.', options: ['will have', 'have', 'had'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'If she ___ (come) early, we can start.', options: ['comes', 'came', 'will come'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'If you need help, ___ me.', options: ['will ask', 'ask', 'asked'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['If I see him, I will tell him.', 'If I saw him, I will tell him.', 'If I will see him, I will tell him.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['If it will rain, I will stay home.', 'If it rains, I stay home.', 'If it rains, I will stay home.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Rewrite: "You eat a lot. You will be ill."', options: ['If you will eat a lot, you will be ill.', 'If you ate a lot, you will be ill.', 'If you eat a lot, you will be ill.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Modal variant: "If you ___ early, you can leave." (finish)', options: ['finish', 'finished', 'will finish'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Match the meaning: "If I miss the bus..."', options: ['I was late.', 'I am impossible to be late.', 'I will be late.'], correctIndex: 2),
];

const List<EnQuizQuestion> _qB1PassiveIntro = [
  EnQuizQuestion(questionEn: 'Present passive of "speak": "English ___ here."', options: ['are spoken', 'is spoken', 'speaks'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Past passive of "build": "The house ___ in 1990."', options: ['was built', 'built', 'is built'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'The letter ___ yesterday. (send)', options: ['is sent', 'sent', 'was sent'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'These cars ___ in Germany. (make)', options: ['is made', 'make', 'are made'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'My bike ___ last night. (steal)', options: ['was stolen', 'stole', 'is stolen'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['The book was written by him.', 'The book was wrote by him.', 'The book is write by him.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['The window was broken.', 'The window was broke.', 'The window is break.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Active → Passive: "They build houses."', options: ['Houses build.', 'Houses is built.', 'Houses are built.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Active → Passive: "She wrote the letter."', options: ['The letter was written.', 'The letter was wrote.', 'The letter is written.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Choose the passive sentence:', options: ['John is building the house.', 'The house was built by John.', 'John built the house.'], correctIndex: 1),
];

const List<EnQuizQuestion> _qB1ReportedSpeechIntro = [
  EnQuizQuestion(questionEn: 'She said, "I am tired." → She said she ___ tired.', options: ['was', 'is', 'were'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'He said, "I will come." → He said he ___ come.', options: ['came', 'would', 'will'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'She said, "I can help." → She said she ___ help.', options: ['can', 'may', 'could'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'He said, "I live in Paris." → He said he ___ in Paris.', options: ['lived', 'living', 'lives'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'She said, "My name is Ana." → She said ___ name was Ana.', options: ['his', 'her', 'my'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['He told me that he is happy.', 'He told to me that he was happy.', 'He told me that he was happy.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct? (Direct speech reported)', options: ['She told me she was late.', 'She said me she was late.', 'She said to me she was late.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Reported: "I see Ali." (She said)', options: ['She said that she saw Ali.', 'She said she see Ali.', 'She said that she sees Ali.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Reported: "We are leaving." (They said)', options: ['They said they were leaving.', 'They said they are leaving.', 'They said we are leaving.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Choose: "She ___ me she was tired." (correct verb)', options: ['say', 'told', 'said'], correctIndex: 1),
];

const List<EnQuizQuestion> _qB1PresentPerfect = [
  EnQuizQuestion(questionEn: 'I ___ (live) here for 5 years.', options: ['lived', 'live', 'have lived'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'She ___ (finish) her homework.', options: ['finished', 'have finished', 'has finished'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'We ___ (know) each other since 2015.', options: ['know', 'have known', 'knew'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'He ___ just ___ (arrive).', options: ['have / arrived', 'is / arrived', 'has / arrived'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'They ___ never ___ (be) to Paris.', options: ['have / been', 'have / gone', 'has / been'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['I have seen that film.', 'I have saw that film.', 'I have see that film.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['She has lived here since 3 years.', 'She lives here for 3 years.', 'She has lived here for 3 years.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which word signals present perfect?', options: ['tomorrow', 'already', 'yesterday'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Change to present perfect: "I wrote a letter."', options: ['I have written a letter.', 'I have wrote a letter.', 'I has written a letter.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Choose: "Have you ever ___ sushi?" (eat)', options: ['ate', 'eat', 'eaten'], correctIndex: 2),
];

const List<EnQuizQuestion> _qB1Modals = [
  EnQuizQuestion(questionEn: 'You ___ rest; you look tired. (advice)', options: ['must', 'can', 'should'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'It ___ rain later. (possibility)', options: ['should', 'must', 'may'], correctIndex: 2),
  EnQuizQuestion(questionEn: '___ I come in? (polite permission)', options: ['Must', 'Should', 'May'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'You ___ study for the exam. (strong obligation)', options: ['must', 'can', 'may'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'She ___ speak three languages. (ability)', options: ['must', 'can', 'should'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['You shoulds rest.', 'You should rest.', 'You should to rest.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['It may rain.', 'It may to rain.', 'It may rains.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Change to advice: "Rest more."', options: ['You should rest more.', 'You must rest more.', 'You may rest more.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Change to possibility: "It will rain."', options: ['It must rain.', 'It should rain.', 'It may rain.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Choose: "You ___ smoke here. It is forbidden."', options: ['must not', 'may not', 'should not'], correctIndex: 0),
];

const List<EnQuizQuestion> _qB2Conditionals = [
  EnQuizQuestion(questionEn: 'Type 0: "If you heat water, it ___."', options: ['will boil', 'boils', 'boiled'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Type 1: "If it rains, I ___ home."', options: ['would stay', 'stay', 'will stay'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Type 2: "If I ___ rich, I would travel."', options: ['were', 'will be', 'am'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Type 3: "If I had studied, I ___ the exam." (pass)', options: ['will pass', 'would pass', 'would have passed'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Type 2: "If I had money, I ___ a car."', options: ['would buy', 'had bought', 'will buy'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct? (Type 2)', options: ['If I were you, I would apologize.', 'If I am you, I would apologize.', 'If I was you, I would apologize.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct? (Type 3)', options: ['If he came, we would have left.', 'If he had come, we would have left.', 'If he had come, we would had left.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Identify the type: "If he has time, he will help."', options: ['Type 2', 'Type 1', 'Type 0'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Identify the type: "If I knew the answer, I would tell you."', options: ['Type 2', 'Type 1', 'Type 3'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Choose: "If the ice ___, the boat will sink." (melt)', options: ['melted', 'melts', 'will melt'], correctIndex: 1),
];

const List<EnQuizQuestion> _qB2Passive = [
  EnQuizQuestion(questionEn: 'Present perfect passive: "The car ___ (repair)."', options: ['is repaired', 'has repaired', 'has been repaired'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Future passive: "The bridge ___ next year. (open)"', options: ['will be opened', 'will open', 'will opened'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Passive with agent: "The letter was written ___ her."', options: ['with', 'by', 'from'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Past continuous passive: "The house ___ when I called."', options: ['was built', 'was being built', 'is built'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Fill: "My car ___ yesterday." (repair, past passive)', options: ['has repaired', 'is repaired', 'was repaired'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['The news is reported daily.', 'The news reports daily.', 'The news are reported daily.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['English is spoke in many countries.', 'English is speaken in many countries.', 'English is spoken in many countries.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Active → Passive: "They have completed the project."', options: ['The project has been completed.', 'The project is completed.', 'The project was completed.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Active → Passive: "Someone will fix the computer."', options: ['The computer is fixed.', 'The computer will be fixed.', 'The computer will fix.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Choose: "This song ___ by many people."', options: ['loves', 'is loving', 'is loved'], correctIndex: 2),
];

const List<EnQuizQuestion> _qC1RelativeClauses = [
  EnQuizQuestion(questionEn: 'The man ___ lives here is my uncle.', options: ['who', 'which', 'whose'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'The book ___ I read was great.', options: ['whose', 'who', 'which'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'A girl ___ name is Ana called me.', options: ['whose', 'who', 'which'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'The house ___ we live in is old.', options: ['which', 'whose', 'who'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'She met a man ___ works for the UN.', options: ['who', 'which', 'whose'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['The car who is red is mine.', 'The car whose is red is mine.', 'The car which is red is mine.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['The boy whose father is a doctor.', 'The boy whose his father is a doctor.', 'The boy who father is a doctor.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Combine: "I know a woman. She speaks five languages."', options: ['I know a woman which speaks five languages.', 'I know a woman whose speaks five languages.', 'I know a woman who speaks five languages.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which sentence is non-defining (adds extra info)?', options: ['The book that I read was good.', 'My brother, who lives in London, is a doctor.', 'The man who called me was polite.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Choose: "This is the place ___ I was born."', options: ['whose', 'where', 'which'], correctIndex: 1),
];

const List<EnQuizQuestion> _qC2Inversion = [
  EnQuizQuestion(questionEn: 'Never ___ such beauty.', options: ['have I seen', 'I have seen', 'I had seen'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Rarely ___ he speak in public.', options: ['does', 'is', 'do'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Hardly ___ we arrived when the rain started.', options: ['have', 'has', 'had'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'No sooner ___ the bell rung than they ran out.', options: ['have', 'had', 'did'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Not only ___ he sing, but he also danced.', options: ['do', 'did', 'has'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['Never do I will forget this.', 'Never will I forget this.', 'Never I will forget this.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['Seldom does he come late.', 'Seldom he comes late.', 'Seldom is he come late.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Transform: "I had never seen such a view."', options: ['Never had I seen such a view.', 'Never did I see such a view.', 'Never I had seen such a view.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Transform: "He not only sings but also dances."', options: ['Not only does he sing but also dances.', 'Not only sings he but also dances.', 'Not only he sings but also dances.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Choose: "Scarcely ___ we sat down when the phone rang."', options: ['were', 'did', 'had'], correctIndex: 2),
];

const List<EnQuizQuestion> _qB2ReportedSpeech = [
  EnQuizQuestion(questionEn: 'She said, "I have finished." → She said she ___ finished.', options: ['had', 'has', 'have'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'He said, "I saw him yesterday." → He said he ___ seen him ___.', options: ['has / yesterday', 'had / the day before', 'had / yesterday'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'She asked, "Are you ready?" → She asked ___ I was ready.', options: ['what', 'that', 'if'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'He said, "Don\'t go." → He told me ___ go.', options: ['don\'t', 'not to', 'to not'], correctIndex: 1),
  EnQuizQuestion(questionEn: '"Where do you live?" → She asked where I ___.', options: ['lived', 'live', 'living'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['He said that he would come.', 'He said he will comes.', 'He said that he will come.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['She asked if I am tired.', 'She asked that I was tired.', 'She asked if I was tired.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Transform: "I will call you tomorrow." (He said...)', options: ['He said he would call me the next day.', 'He said he will call me tomorrow.', 'He said he would call me tomorrow.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Transform: "Please wait here." (She asked)', options: ['She said wait there.', 'She asked me to wait there.', 'She asked me wait here.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Choose: "He ___ us to be quiet."', options: ['told', 'say', 'said'], correctIndex: 0),
];

const List<EnQuizQuestion> _qB2GerundInfinitive = [
  EnQuizQuestion(questionEn: 'I enjoy ___ (read) books.', options: ['reading', 'to read', 'read'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'She wants ___ (learn) French.', options: ['to learn', 'learning', 'learn'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'He decided ___ (stay) at home.', options: ['staying', 'stay', 'to stay'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'They avoided ___ (answer) the question.', options: ['answering', 'answered', 'to answer'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'She is good at ___ (sing).', options: ['sing', 'singing', 'to sing'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['I want going home.', 'I want go home.', 'I want to go home.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['He finished to write the report.', 'He finished wrote the report.', 'He finished writing the report.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Meaning difference: "He stopped smoking" means...', options: ['He no longer smokes.', 'He stopped to light a cigarette.', 'He is a smoker.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Choose: "Remember ___ (lock) the door."', options: ['locking', 'lock', 'to lock'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Choose: "Thank you for ___ (help) me."', options: ['helping', 'help', 'to help'], correctIndex: 0),
];

const List<EnQuizQuestion> _qB2ModalsPast = [
  EnQuizQuestion(questionEn: 'She ___ left already; the lights are off.', options: ['should have', 'must have', 'could'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'You ___ told me! (regret/criticism)', options: ['should have', 'must have', 'could have'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'He ___ forgotten the meeting. (possibility)', options: ['might have', 'should have', 'must have'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'They ___ seen us; they were far away.', options: ['must have', 'should have', 'can\'t have'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'I ___ studied harder; I failed the test.', options: ['should have', 'must have', 'could have'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['She must has gone home.', 'She must went home.', 'She must have gone home.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['You should have come.', 'You should has come.', 'You should have came.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Rewrite: "It is certain that she left." → She ___ left.', options: ['could have', 'must have', 'should have'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Rewrite: "It is impossible that he did it." → He ___ done it.', options: ['might have', 'can\'t have', 'must have'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Choose: "I regret not going." → I ___ gone.', options: ['must have', 'could have', 'should have'], correctIndex: 2),
];

const List<EnQuizQuestion> _qB2FuturePerfect = [
  EnQuizQuestion(questionEn: 'By 2030, I ___ (graduate).', options: ['graduated', 'will graduate', 'will have graduated'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'By the time you arrive, we ___ (eat).', options: ['will eat', 'have eaten', 'will have eaten'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'She ___ (finish) the book by Monday.', options: ['will have finished', 'will finish', 'finishes'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'By next year, they ___ (move) to Rome.', options: ['will have moved', 'moved', 'will move'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'He ___ (live) here for 10 years by June.', options: ['lives', 'will live', 'will have lived'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['By 2030, I have graduated.', 'By 2030, I will have graduated.', 'By 2030, I will graduated.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['By Friday, she will have finished.', 'By Friday, she will has finished.', 'By Friday, she will finish.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Rewrite: "I finish by noon."', options: ['I will have finished by noon.', 'I will finished by noon.', 'I have finished by noon.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Question form: "___ you ___ read it by Monday?"', options: ['Will / have read', 'Have / read', 'Will / read'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Choose: "We ___ (save) enough money by 2026."', options: ['will have saved', 'saved', 'will save'], correctIndex: 0),
];

const List<EnQuizQuestion> _qB2PastPerfectContinuous = [
  EnQuizQuestion(questionEn: 'She ___ (work) for 5 hours when I arrived.', options: ['was working', 'worked', 'had been working'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'We ___ (wait) for an hour before the bus came.', options: ['had been waiting', 'waited', 'were waiting'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'His eyes were red; he ___ (cry).', options: ['had cried', 'was crying', 'had been crying'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'They ___ (live) there since 2010 when they moved.', options: ['have lived', 'had been living', 'were living'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'I was tired because I ___ (run).', options: ['have been running', 'had been running', 'was running'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['He has been working when I called.', 'He was been working when I called.', 'He had been working when I called.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['She been studying all night.', 'She had been studying all night.', 'She had being studying all night.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Rewrite: "I was waiting for two hours and then he came."', options: ['I had waited for two hours and then he came.', 'I was been waiting when he came.', 'I had been waiting for two hours when he came.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Choose time expression for past perfect continuous:', options: ['for / since', 'now', 'tomorrow'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Choose: "By 2020, they ___ (live) abroad for a decade."', options: ['have been living', 'were living', 'had been living'], correctIndex: 2),
];

const List<EnQuizQuestion> _qB1UsedTo = [
  EnQuizQuestion(questionEn: 'I ___ smoke, but I quit last year.', options: ['use to', 'used to', 'am used to'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'She ___ live in Paris when she was young.', options: ['was used to', 'used to', 'using to'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['He don\'t used to drink.', 'He didn\'t use to drink coffee.', 'He didn\'t used to drink coffee.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['Did you use to play football?', 'Did you play to used?', 'Did you used to play football?'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'I ___ working at night now. (I am accustomed)', options: ['use to', 'used to', 'am used to'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Meaning: "I used to play tennis" means...', options: ['I am accustomed to tennis.', 'I play tennis now.', 'I played tennis in the past but not now.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Meaning: "I am used to the noise" means...', options: ['I never hear noise.', 'I am accustomed to the noise now.', 'I used to hear noise before.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Fill: "I ___ to waking up early." (present habit)', options: ['used', 'got use', 'am used'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Transform: "I smoked when I was young, now I don\'t."', options: ['I am used to smoking.', 'I used to smoke.', 'I was used to smoke.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Choose: "She ___ (get / accustomed) to the new job."', options: ['used got', 'got used', 'got use'], correctIndex: 1),
];

const List<EnQuizQuestion> _qB2Wish = [
  EnQuizQuestion(questionEn: 'I wish I ___ more money. (but I don\'t)', options: ['would have', 'have', 'had'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'She wishes she ___ taller.', options: ['is', 'were', 'was'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'I wish I ___ harder last year. (regret past)', options: ['had studied', 'would study', 'studied'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'I wish he ___ stop talking. (annoying present)', options: ['would', 'will', 'had'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'I wish I ___ gone to the party yesterday.', options: ['could have', 'had', 'can have'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['I wish I were rich.', 'Both are acceptable; (b) is more formal.', 'I wish I was rich.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct? (regret past)', options: ['I wish I hadn\'t said that.', 'I wish I didn\'t said that.', 'I wish I don\'t say that.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Meaning: "I wish I had studied" = ?', options: ['I am studying now.', 'I regret not studying in the past.', 'I want to study.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Transform: "I don\'t speak French, but I want to."', options: ['I wish I speak French.', 'I wish I can speak French.', 'I wish I spoke French.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Choose: "I wish you ___ tell me the truth." (annoyance)', options: ['would', 'will', 'had'], correctIndex: 0),
];

const List<EnQuizQuestion> _qB2MixedConditionals = [
  EnQuizQuestion(questionEn: 'Past → Present: "If I ___ studied, I would be a doctor now."', options: ['would have', 'had', 'have'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Past → Present: "If she ___ left earlier, she would be here."', options: ['had', 'left', 'has'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Present → Past: "If I ___ rich, I would have bought that house." (be)', options: ['were', 'am', 'had been'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Fill: "If I had taken that job, I ___ (be) in Paris now."', options: ['would have been', 'will be', 'would be'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Fill: "If he knew English, he ___ (pass) the test yesterday."', options: ['would have passed', 'would pass', 'passed'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['If I studied, I would be a doctor.', 'If I have studied, I would be doctor.', 'If I had studied, I would be a doctor.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['If I were taller, I would have play basketball.', 'If I was taller, I would play basketball yesterday.', 'If I were taller, I would have played basketball.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Identify: "If I had slept, I wouldn\'t be tired now." is...', options: ['mixed (present → past)', 'mixed (past → present)', 'standard Type 3'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Identify: "If I spoke French, I would have got the job." is...', options: ['standard Type 2', 'mixed (past → present)', 'mixed (present → past)'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Choose: "If we had left earlier, we ___ (not miss) the flight."', options: ['would not miss', 'will not miss', 'would not have missed'], correctIndex: 2),
];

const List<EnQuizQuestion> _qB2ParticipleClauses = [
  EnQuizQuestion(questionEn: '___ finished the work, he went home. (having)', options: ['Having', 'Have', 'Had'], correctIndex: 0),
  EnQuizQuestion(questionEn: '___ home, I saw an old friend. (walk)', options: ['Walking', 'Walk', 'Walked'], correctIndex: 0),
  EnQuizQuestion(questionEn: '___ in 1920, the book is still popular. (write)', options: ['Writing', 'Wrote', 'Written'], correctIndex: 2),
  EnQuizQuestion(questionEn: '___ eaten, we left the restaurant. (have)', options: ['Having', 'Have', 'Had'], correctIndex: 0),
  EnQuizQuestion(questionEn: '___ by the news, she sat down. (shock)', options: ['Shock', 'Shocked', 'Shocking'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['Having seen the film, we discussed it.', 'Having saw the film, we discussed it.', 'Having see the film, we discussed it.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['Smiled, she opened the door.', 'Smile, she opened the door.', 'Smiling, she opened the door.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Rewrite: "After he ate, he slept."', options: ['Having eaten, he slept.', 'Eating, he slept.', 'Ate, he slept.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Rewrite: "The book, which was written in 1920, is popular."', options: ['Wrote in 1920, the book is popular.', 'Written in 1920, the book is popular.', 'Writing in 1920, the book is popular.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Choose: "___ tired, he continued to work." (feel)', options: ['Feel', 'Felt', 'Feeling'], correctIndex: 2),
];

const List<EnQuizQuestion> _qB2PassiveModals = [
  EnQuizQuestion(questionEn: 'This ___ (do) today. (must)', options: ['must be done', 'must done', 'must do'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'The door ___ (open) easily. (can)', options: ['can opened', 'can open', 'can be opened'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'The letter ___ (send) yesterday. (should have)', options: ['should be sent', 'should have sent', 'should have been sent'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'It ___ (steal). (might have)', options: ['might have been stolen', 'might have stolen', 'might be stolen'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Forms ___ (submit) by Friday. (must)', options: ['must be submitted', 'must submit', 'must submitted'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['This machine should not be used without training.', 'This machine should not used without training.', 'This machine should not been used.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['The cake can be eat now.', 'The cake can eaten now.', 'The cake can be eaten now.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Active → Passive: "They must finish it."', options: ['It must finish.', 'It must be finished.', 'It must been finished.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Active → Passive: "Someone should have told her."', options: ['She should have told.', 'She should be told.', 'She should have been told.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Choose: "The homework ___ by Monday." (must / finish)', options: ['must be finished', 'must finish', 'must finished'], correctIndex: 0),
];

const List<EnQuizQuestion> _qB2Subjunctive = [
  EnQuizQuestion(questionEn: 'I suggest that he ___ on time.', options: ['was', 'is', 'be'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'She demanded that he ___.', options: ['left', 'leave', 'leaves'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'It is important that she ___ informed.', options: ['was', 'is', 'be'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'I insist that he ___ with us.', options: ['come', 'came', 'comes'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'It is necessary that they ___ the truth. (know)', options: ['knew', 'knows', 'know'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct (formal subjunctive)?', options: ['I suggest that she coming early.', 'I suggest that she comes early.', 'I suggest that she come early.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct (formal subjunctive)?', options: ['It is essential that he is here.', 'It is essential that he be here.', 'It is essential that he was here.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Rewrite formally: "I suggest that he should come." → "I suggest that he ___."', options: ['came', 'come', 'comes'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Rewrite formally: "She should arrive on time." (with demand)', options: ['I demand that she arrived on time.', 'I demand that she arrive on time.', 'I demand that she arrives on time.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Choose: "It is vital that he ___ aware of the risks." (be)', options: ['be', 'is', 'being'], correctIndex: 0),
];

const List<EnQuizQuestion> _qB2Causative = [
  EnQuizQuestion(questionEn: 'I had my car ___ (repair).', options: ['repair', 'repairing', 'repaired'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'She had her hair ___ (cut).', options: ['cutting', 'cut', 'cuts'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'I got my phone ___ (fix).', options: ['fixing', 'fixed', 'fix'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'He had them ___ (clean) the room. (active causative)', options: ['cleaned', 'clean', 'cleaning'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'The teacher made us ___ (study). (active causative)', options: ['study', 'to study', 'studying'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct? (Someone cut her hair)', options: ['She had cut her hair.', 'She had her hair cutting.', 'She had her hair cut.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct? (Someone stole his wallet)', options: ['He had his wallet stolen.', 'He had his wallet stole.', 'He had his wallet steal.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Meaning: "I cut my hair" vs "I had my hair cut" — which is done by a barber?', options: ['I cut my hair.', 'Both equally.', 'I had my hair cut.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Rewrite: "A mechanic repaired my car." → I ___.', options: ['had repaired my car', 'had my car repaired', 'have my car repaired'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Choose: "We got the house ___ (paint) last week."', options: ['painting', 'paint', 'painted'], correctIndex: 2),
];

const List<EnQuizQuestion> _qC1InversionAdvanced = [
  EnQuizQuestion(questionEn: 'Had I known, I ___ come. (conditional without if)', options: ['will have', 'would', 'would have'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Not only ___ he win, but he also broke the record.', options: ['did', 'was', 'do'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Should you need help, ___ me.', options: ['call', 'calls', 'called'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Only then ___ I understand.', options: ['had', 'did', 'do'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Were I ___ win the lottery, I would travel. (formal)', options: ['have', 'of', 'to'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['Had I had known, I would have told you.', 'Had I know, I would have told you.', 'Had I known, I would have told you.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['Not only she does sing, but dances also.', 'Not only does she sing, but she also dances.', 'Not only she sings, but also dances.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Rewrite formally: "If I had known, I would have come." → ___.', options: ['Should I know, I would have come.', 'Were I to know, I would have come.', 'Had I known, I would have come.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Rewrite formally: "If you need help, call me." → ___.', options: ['Should you need help, call me.', 'Have you need help, call me.', 'Were you need help, call me.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Choose: "Only after the meeting ___ she speak."', options: ['had', 'does', 'did'], correctIndex: 2),
];

const List<EnQuizQuestion> _qC1CleftSentences = [
  EnQuizQuestion(questionEn: 'It was John ___ broke the window.', options: ['who', 'which', 'whose'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'What I need ___ a break.', options: ['are', 'is', 'was'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'All I want ___ peace.', options: ['are', 'be', 'is'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'It ___ yesterday that she arrived.', options: ['were', 'is', 'was'], correctIndex: 2),
  EnQuizQuestion(questionEn: '___ he said was shocking. (What)', options: ['That', 'Which', 'What'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['It was money that he wanted.', 'It money that he wanted.', 'It was money what he wanted.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['What I want are peace and quiet.', 'What I wanting is peace and quiet.', 'What I want is peace and quiet.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Emphasise "John": "John broke the window." → ___.', options: ['The John broke the window.', 'John it was broke the window.', 'It was John who broke the window.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Emphasise "a break": "I need a break." → ___.', options: ['A break is what I need it.', 'I a break need.', 'What I need is a break.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Choose: "All ___ did was complain." (he)', options: ['that he', 'he', 'who he'], correctIndex: 1),
];

const List<EnQuizQuestion> _qC1EmphasisDo = [
  EnQuizQuestion(questionEn: 'I ___ love this song! (emphasis)', options: ['very', 'do', 'am'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'She ___ understand the situation. (emphasis)', options: ['is', 'do', 'does'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'He ___ call yesterday, I remember. (emphasis)', options: ['do', 'did', 'does'], correctIndex: 1),
  EnQuizQuestion(questionEn: '___ come in! (polite emphasis invitation)', options: ['Do', 'Did', 'Does'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'I ___ try, but I failed. (emphasis)', options: ['did', 'do', 'done'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct? (emphasis)', options: ['I do love you.', 'I am do love you.', 'I do loves you.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct? (emphasis)', options: ['She does understands.', 'She is does understand.', 'She does understand.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Emphasise: "I like tea."', options: ['I am like tea.', 'I does like tea.', 'I do like tea.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Emphasise: "He called yesterday."', options: ['He did call yesterday.', 'He doing call yesterday.', 'He does call yesterday.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Choose: "You don\'t listen! — I ___ listen!"', options: ['am', 'did', 'do'], correctIndex: 2),
];

const List<EnQuizQuestion> _qC1Fronting = [
  EnQuizQuestion(questionEn: 'Object fronting: "This book I ___ enjoyed." (emphasis)', options: ['very', 'really', 'more'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Adverbial fronting: "In the garden ___ a huge tree."', options: ['is stood', 'stood', 'was standing'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Adverbial fronting: "Down the street ___ a parade."', options: ['came', 'comes', 'come'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Object fronting: "His honesty I ___."', options: ['do admire', 'admire', 'admired'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Fronting: "Such behavior we cannot ___."', options: ['accepted', 'accepting', 'accept'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct (object fronting)?', options: ['This book I enjoy really.', 'This book really I enjoyed.', 'This book I really enjoyed.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct (adverbial fronting)?', options: ['An old man in the corner sat.', 'In the corner an old man sat.', 'In the corner sat an old man.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Rewrite with fronting: "I admire his courage."', options: ['His courage admires I.', 'I admire courage his.', 'His courage I admire.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Rewrite with fronting: "A parade came down the street."', options: ['Down the street came a parade.', 'Down the street a parade came.', 'Came down the street a parade.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Choose: "Rarely have I seen ___ a beautiful view."', options: ['those', 'such', 'that'], correctIndex: 1),
];

const List<EnQuizQuestion> _qC1Ellipsis = [
  EnQuizQuestion(questionEn: 'She sings and ___ dances.', options: ['is', 'she', '(nothing)'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'I love coffee. — So ___ I.', options: ['did', 'am', 'do'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'She doesn\'t smoke. — Neither ___ I.', options: ['did', 'am', 'do'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'I haven\'t finished, but he ___ .', options: ['have', 'had', 'has'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'She can swim better than I ___ .', options: ['could', 'can', 'cans'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['Both are acceptable, (b) uses ellipsis.', 'I can swim and dance.', 'I can swim and I can dance.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['She likes tea. — I do so.', 'She likes tea. — So I do.', 'She likes tea. — So do I.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Complete: "I don\'t drink coffee. — ___ ."', options: ['I neither do.', 'Neither do I.', 'Neither I do.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Shorten: "He came in and he sat down." → "He came in and ___ ."', options: ['sat down', 'seated down', 'he sat down'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Choose: "I play guitar. — So ___ my sister."', options: ['does', 'do', 'is'], correctIndex: 0),
];

const List<EnQuizQuestion> _qC1AdvancedConnectors = [
  EnQuizQuestion(questionEn: '"___ the rain, we went out." (despite — formal)', options: ['Because', 'Although', 'Notwithstanding'], correctIndex: 2),
  EnQuizQuestion(questionEn: '"The project was successful, ___ expensive." (although — short)', options: ['nevertheless', 'albeit', 'whereas'], correctIndex: 1),
  EnQuizQuestion(questionEn: '"He is quiet, ___ his brother is loud."', options: ['because', 'since', 'whereas'], correctIndex: 2),
  EnQuizQuestion(questionEn: '"It was hard; ___ , he succeeded."', options: ['while', 'however', 'nevertheless'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Fill in: "Some love it, ___ others hate it."', options: ['whereas', 'because', 'so'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['Whereas he was tired, he continued.', 'Albeit he was tired, he continued.', 'Although he was tired, he continued.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['Notwithstanding that his efforts, he failed.', 'Notwithstanding of his efforts, he failed.', 'Notwithstanding his efforts, he failed.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Rewrite formally: "Even though it rained, we went out."', options: ['Because the rain, we went out.', 'Notwithstanding the rain, we went out.', 'In contrast the rain, we went out.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Rewrite formally: "He accepted, but he was reluctant."', options: ['He accepted, albeit reluctantly.', 'He accepted, whereas reluctantly.', 'He accepted, notwithstanding reluctantly.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Choose: "The test was difficult; ___ , most students passed."', options: ['nonetheless', 'albeit', 'whereas'], correctIndex: 0),
];

const List<EnQuizQuestion> _qC1PhrasalVerbs3 = [
  EnQuizQuestion(questionEn: 'I look forward ___ you. (meet)', options: ['to meeting', 'to meet', 'meeting'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'I can\'t put up ___ this noise.', options: ['of', 'with', 'for'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'He came up ___ a great idea.', options: ['for', 'with', 'to'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'We ran out ___ milk.', options: ['with', 'from', 'of'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'He got away ___ cheating.', options: ['of', 'from', 'with'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['I look forward seeing you.', 'I look forward to seeing you.', 'I look forward to see you.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is correct?', options: ['I put up with this.', 'I put up with of this.', 'I put with up this.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Rewrite: "I hope to meet you soon." → "I look forward ___ you soon."', options: ['to meeting', 'meeting', 'to meet'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Rewrite: "We no longer have gas." → "We ___ of gas."', options: ['put up', 'ran out', 'came up'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Choose: "You can\'t ___ with this behavior." (escape punishment)', options: ['get away', 'run out', 'look forward'], correctIndex: 0),
];

const List<EnQuizQuestion> _qC2ArchaicForms = [
  EnQuizQuestion(questionEn: 'He whispered ___ he be heard. (so that he is not heard)', options: ['unless', 'albeit', 'lest'], correctIndex: 2),
  EnQuizQuestion(questionEn: '"___ shalt not kill." (you, archaic)', options: ['Thee', 'Thy', 'Thou'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Return ___ you came. (from where)', options: ['whence', 'whither', 'where'], correctIndex: 0),
  EnQuizQuestion(questionEn: '"___ unknown facts emerged." (until now)', options: ['Thenceforth', 'Hitherto', 'Hence'], correctIndex: 1),
  EnQuizQuestion(questionEn: '"___ are you going?" (to where)', options: ['Thence', 'Whither', 'Whence'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Which is archaic/literary?', options: ['Thou art my friend.', 'You were my friend.', 'You are my friend.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which sentence is correct in old English?', options: ['Thee shall not kill.', 'Thy shall not kill.', 'Thou shalt not kill.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Modernize: "She wrote it down lest she forget."', options: ['She wrote it down so she wouldn\'t forget.', 'She wrote it down unless she forgot.', 'She wrote it down because she forgot.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Modernize: "Whither thou goest?"', options: ['When are you going?', 'Why are you going?', 'Where are you going?'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Choose: "___ , he lived in peace." (from that time onward)', options: ['Thenceforth', 'Whence', 'Hitherto'], correctIndex: 0),
];

const List<EnQuizQuestion> _qC2FormalSubjunctive = [
  EnQuizQuestion(questionEn: 'If I ___ you, I would resign. (formal)', options: ['be', 'were', 'was'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'I wish I ___ taller. (formal subjunctive)', options: ['were', 'am', 'was'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'The court orders that he ___ released. (subjunctive)', options: ['be', 'is', 'was'], correctIndex: 0),
  EnQuizQuestion(questionEn: '"Long ___ the king!" (fixed expression)', options: ['live', 'lived', 'lives'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'We ask that the matter ___ reviewed.', options: ['is', 'was', 'be'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which is correct (formal writing)?', options: ['If I were you, I would leave.', 'If I be you, I would leave.', 'If I was you, I would leave.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is correct (formal order)?', options: ['The court orders that he be released.', 'The court orders that he was released.', 'The court orders that he is released.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Rewrite formally: "I want the meeting to be delayed."', options: ['I ask the meeting is delayed.', 'I ask that the meeting is delayed.', 'I ask that the meeting be delayed.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Rewrite formally: "Whatever happens, we will succeed."', options: ['Come what will, we will succeed.', 'Come what may, we will succeed.', 'Come what shall, we will succeed.'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Choose (formal legal): "We request that the document ___ signed."', options: ['was', 'be', 'is'], correctIndex: 1),
];

const List<EnQuizQuestion> _qC2Nominalization = [
  EnQuizQuestion(questionEn: 'Verb → noun: "decide" → ?', options: ['decisive', 'deciding', 'decision'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Verb → noun: "analyze" → ?', options: ['analytic', 'analysis', 'analyzing'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Adjective → noun: "happy" → ?', options: ['happily', 'happiness', 'happier'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Adjective → noun: "able" → ?', options: ['ableness', 'abled', 'ability'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Verb → noun: "imply" → ?', options: ['implied', 'implying', 'implication'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Which sentence uses nominalization?', options: ['Their decision to leave was sudden.', 'They were deciding to leave.', 'They decided to leave.'], correctIndex: 0),
  EnQuizQuestion(questionEn: 'Which is more academic?', options: ['The task is difficult.', 'It is difficult, the task.', 'The difficulty of the task is high.'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Rewrite formally: "We analyze the data." → "The ___ of the data is important."', options: ['analyze', 'analysis', 'analyzing'], correctIndex: 1),
  EnQuizQuestion(questionEn: 'Rewrite formally: "They decided quickly." → "Their ___ was quick."', options: ['deciding', 'decide', 'decision'], correctIndex: 2),
  EnQuizQuestion(questionEn: 'Choose: "The ___ of the policy resulted in improvements." (verb: implement)', options: ['implementing', 'implementation', 'implement'], correctIndex: 1),
];


const List<EnGrammarTopic> kEnGrammarTopics = [
  // ═══ A1 — Başlangıç ══════════════════════════════════════════
  EnGrammarTopic(
    id: 'a1_be',
    level: 'A1',
    titleEn: 'The Verb "Be" (am/is/are)',
    titleKu: 'Lekera "Be" — bûn',
    emoji: '🔵',
    summaryKu: 'Lekera "be" sê forman digire: am (ez), is (ew/yek kes an tişt), are (tu / em / hûn / ew pirjimar). Bingeha hevokên Îngilîzî ye.',
    rules: [
      EnGrammarRule(
        ruleKu: 'I → am | You → are (yek û pirjimar herdu) | He/She/It → is | We/You/They → are',
        examples: [
          EnGrammarExample(en: 'I am happy.', ku: 'Ez kêfxweş im.'),
          EnGrammarExample(en: 'You are my friend.', ku: 'Tu hevalê min î.'),
          EnGrammarExample(en: 'She is a teacher.', ku: 'Ew mamoste ye.'),
          EnGrammarExample(en: 'It is cold today.', ku: 'Îro sar e.'),
          EnGrammarExample(en: 'We are students.', ku: 'Em xwendekar in.'),
          EnGrammarExample(en: 'They are friends.', ku: 'Ew heval in.'),
        ],
        noteKu: 'Hişyarî: di Îngilîzî de "you" hem ji bo yek kesî hem jî ji bo pirjimarê tê bikaranîn — her tim "are" digire, ne "is". Kurmancî "tu yî / hûn in" cuda dike, lê Îngilîzî ferq nake.',
      ),
      EnGrammarRule(
        ruleKu: 'Forma kurt (contractions): I\'m, you\'re, he\'s, she\'s, it\'s, we\'re, they\'re — di axaftin û nivîsa nefermî de pir tên bikaranîn.',
        examples: [
          EnGrammarExample(en: 'I\'m a doctor.', ku: 'Ez bijîşk im.'),
          EnGrammarExample(en: 'She\'s my sister.', ku: 'Ew xwişka min e.'),
          EnGrammarExample(en: 'They\'re at school.', ku: 'Ew li dibistanê ne.'),
        ],
        noteKu: 'XETA: "it\'s" = "it is" an "it has"; lê "its" (bê apostrof) xwedîtî ye. Ev du peyv cuda ne.',
      ),
      EnGrammarRule(
        ruleKu: 'Neyînî: am not / is not (isn\'t) / are not (aren\'t). "I amn\'t" tune — her tim "I\'m not".',
        examples: [
          EnGrammarExample(en: 'I am not tired. / I\'m not tired.', ku: 'Ez ne westiyayî me.'),
          EnGrammarExample(en: 'He isn\'t here.', ku: 'Ew ne li vir e.'),
          EnGrammarExample(en: 'They aren\'t ready.', ku: 'Ew ne amade ne.'),
        ],
        noteKu: 'Ji bo I kes, "amn\'t" di Îngilîziya standard de tune. Tenê "I\'m not" tê bikaranîn.',
      ),
      EnGrammarRule(
        ruleKu: 'Pirs: "be" tê pêş — Am I? / Is he? / Are they? Bersiva kurt: "Yes, I am." / "No, she isn\'t."',
        examples: [
          EnGrammarExample(en: 'Are you ready?', ku: 'Tu amade yî?'),
          EnGrammarExample(en: 'Is she at home?', ku: 'Ew li mal e?'),
          EnGrammarExample(en: 'Am I late? — Yes, you are.', ku: 'Ez dereng mam? — Erê, tu dereng mayî.'),
        ],
        noteKu: 'Hişyarî: di bersiva kurt de leker nayê kurtkirin: "Yes, I am." (ne "Yes, I\'m.")',
      ),
    ],
    quizQuestions: _qA1Be,
  ),

  EnGrammarTopic(
    id: 'a1_articles',
    level: 'A1',
    titleEn: 'Articles: a, an, the',
    titleKu: 'Artîkl: a, an, the',
    emoji: '🅰️',
    summaryKu: 'Di Kurmancî de artîklên wiha tune ne — di Îngilîzî de pir caran MECBÛRÎ ne. Li ber navdêrên yekjimar ên hejmarbar (countable) divê "a/an/the" were bikaranîn.',
    rules: [
      EnGrammarRule(
        ruleKu: '"a" — ji bo navdêrên yekjimar ên hejmarbar ku bi dengê dengdarekî (consonant) dest pê dikin: a book, a cat, a dog, a university (bi dengê "y" dest pê dike).',
        examples: [
          EnGrammarExample(en: 'I have a cat.', ku: 'Pisîkek min heye.'),
          EnGrammarExample(en: 'She is a doctor.', ku: 'Ew bijîşkek e.'),
          EnGrammarExample(en: 'He bought a car.', ku: 'Wî erebeyek kirî.'),
          EnGrammarExample(en: 'It\'s a university.', ku: 'Zanîngehek e. (ji ber ku "university" bi dengê "yu" dest pê dike, "a" digire.)'),
        ],
        noteKu: 'HIŞYARÎ: Bi dengê peyvê ve girêdayî ye, ne bi tîpê. "a university" (deng: /ju/) lê "an hour" (bêdeng "h", deng bi "a" dest pê dike).',
      ),
      EnGrammarRule(
        ruleKu: '"an" — ji bo navdêrên ku bi dengê dengdêrekî (vowel) dest pê dikin: an apple, an egg, an idea, an hour ("h" bê deng).',
        examples: [
          EnGrammarExample(en: 'I eat an apple every day.', ku: 'Ez her roj sêvekê dixwim.'),
          EnGrammarExample(en: 'She has an idea.', ku: 'Fikrek wê heye.'),
          EnGrammarExample(en: 'We waited an hour.', ku: 'Em demjimêrek li bendê man. ("hour" — h nayê telefûz kirin)'),
        ],
      ),
      EnGrammarRule(
        ruleKu: '"the" — ji bo tiştên diyar, naskirî, an yekane: tiştê em behs dikin herdu kes dizanin kî/çi ye.',
        examples: [
          EnGrammarExample(en: 'The sun is bright today.', ku: 'Îro roj geş e. (roj yek e — yekane)'),
          EnGrammarExample(en: 'I saw a dog. The dog was barking.', ku: 'Min kûçikek dît. Kûçik direyand. (cara 2yem "the" — em kûçika diyar dizanin)'),
          EnGrammarExample(en: 'Open the door, please.', ku: 'Ji kerema xwe derî veke. (derîyê diyar)'),
        ],
        noteKu: 'QAÎDE: Cara pêşîn "a/an" (nediyar), cara duyem "the" (diyar). "I bought a book. The book is interesting."',
      ),
      EnGrammarRule(
        ruleKu: 'Bê artîkl (zero article): Navdêrên pirjimar ên giştî, navdêrên nehejmarbar (water, music, love), nav û welat, zimanan: I love music. She speaks English.',
        examples: [
          EnGrammarExample(en: 'I love music.', ku: 'Ez ji muzîkê hez dikim. (ne "the music")'),
          EnGrammarExample(en: 'She speaks English and French.', ku: 'Ew bi Îngilîzî û Frensî dipeyive.'),
          EnGrammarExample(en: 'Dogs are loyal.', ku: 'Kûçik dilsoz in. (kûçik bi giştî)'),
          EnGrammarExample(en: 'I live in Turkey.', ku: 'Ez li Tirkiyê dijîm. (bê "the" — welat)'),
        ],
        noteKu: 'HIŞYARÎ: "the United States", "the UK", "the Netherlands" — welatên bi nav pirjimar an bi "state/kingdom" de "the" digirin. Lê "Turkey", "Germany" bê artîkl.',
      ),
      EnGrammarRule(
        ruleKu: 'XETA HERÎ MEZIN A KURMANCÎAXÊVAN: ji bo karê kesekî "a/an" pêwîst e. "He is teacher" ÇEWT e — "He is a teacher" rast.',
        examples: [
          EnGrammarExample(en: 'He is a teacher. (NE: He is teacher.)', ku: 'Ew mamoste ye.'),
          EnGrammarExample(en: 'She is an engineer.', ku: 'Ew endezyar e.'),
          EnGrammarExample(en: 'My father is a doctor.', ku: 'Bavê min bijîşk e.'),
        ],
        noteKu: 'Ji ber ku Kurmancî bê artîkl e, mejiyê me "He is teacher" dibêje. Divê em "a/an" li pişt xwe bi zorê bi cih bikin.',
      ),
    ],
    quizQuestions: _qA1Articles,
  ),

  EnGrammarTopic(
    id: 'a1_present_simple',
    level: 'A1',
    titleEn: 'Present Simple Tense',
    titleKu: 'Dema Niha ya Sade (Present Simple)',
    emoji: '⏰',
    summaryKu: 'Ji bo karên rojane, adet, rastî, û rûdanên daîmî. Di kesê sêyem ê yekjimar (he/she/it) de -s/-es li lekerê zêde dibe.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Erênî: I/You/We/They + leker (forma binyad). He/She/It + leker-s.',
        examples: [
          EnGrammarExample(en: 'I drink water.', ku: 'Ez avê vedixwim.'),
          EnGrammarExample(en: 'You speak fast.', ku: 'Tu zû dipeyivî.'),
          EnGrammarExample(en: 'She drinks tea.', ku: 'Ew çayê vedixwe.'),
          EnGrammarExample(en: 'We work every day.', ku: 'Em her roj dixebitin.'),
          EnGrammarExample(en: 'They live in Istanbul.', ku: 'Ew li Stenbolê dijîn.'),
        ],
        noteKu: 'QAÎDEYA -s ya KESÊ 3EM KRÎTÎK E: he eats, she goes, it works. Xetaya herî zêde: Kurmancîaxêv "-s"yê ji bîr dike.',
      ),
      EnGrammarRule(
        ruleKu: 'Qaîdeyên nivîsîna -s/-es: piraniya lekeran +s; piştî -s, -ss, -sh, -ch, -x, -o: +es (watches, goes); piştî dengdar + y: y → ies (study → studies); piştî dengdêr + y: tenê +s (plays).',
        examples: [
          EnGrammarExample(en: 'He watches TV.', ku: 'Ew televîzyonê temaşe dike.'),
          EnGrammarExample(en: 'She goes to work.', ku: 'Ew diçe karî.'),
          EnGrammarExample(en: 'He studies English.', ku: 'Ew Îngilîzî dixwîne.'),
          EnGrammarExample(en: 'She plays piano.', ku: 'Ew piyanoyê lê dide.'),
        ],
        noteKu: 'Awarte: have → has (ne "haves"). "She has a car." (ne "She haves")',
      ),
      EnGrammarRule(
        ruleKu: 'Neyînî: do not (don\'t) + leker. Ji bo he/she/it: does not (doesn\'t) + leker (BÊ -s, ji ber ku -s berê li "does" heye!).',
        examples: [
          EnGrammarExample(en: 'I don\'t smoke.', ku: 'Ez cixareyê nakişînim.'),
          EnGrammarExample(en: 'He doesn\'t eat meat.', ku: 'Ew goşt naxwe.'),
          EnGrammarExample(en: 'She doesn\'t like coffee. (NE: She doesn\'t likes)', ku: 'Ew ji qehweyê hez nake.'),
        ],
        noteKu: 'XETA HERÎ MEZIN: "She doesn\'t likes" ÇEWT e. "Doesn\'t" berê -s digire, loma leker BÊ -s dimîne: "She doesn\'t like".',
      ),
      EnGrammarRule(
        ruleKu: 'Pirs: Do I/you/we/they + leker? Does he/she/it + leker? (dîsa BÊ -s)',
        examples: [
          EnGrammarExample(en: 'Do you speak English?', ku: 'Tu bi Îngilîzî dipeyivî?'),
          EnGrammarExample(en: 'Does she like coffee? (NE: Does she likes)', ku: 'Gelo ew ji qehweyê hez dike?'),
          EnGrammarExample(en: 'Where do you live?', ku: 'Tu li ku derê dijî?'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Zarfên pêjnê/qewlê (adverbs of frequency): always, usually, often, sometimes, rarely, never — berî lekerê tên; lê piştî "be": She is always late.',
        examples: [
          EnGrammarExample(en: 'I always drink coffee in the morning.', ku: 'Ez her sibê qehwe vedixwim.'),
          EnGrammarExample(en: 'She never eats meat.', ku: 'Ew tu caran goşt naxwe.'),
          EnGrammarExample(en: 'He is usually late.', ku: 'Ew bi gelemperî dereng dimîne.'),
        ],
        noteKu: 'HIŞYARÎ: "never" bi serê xwe neyîniyê çêdike — carekê din "not" neyê zêdekirin: "I never eat" (ne "I don\'t never eat").',
      ),
    ],
    quizQuestions: _qA1PresentSimple,
  ),

  EnGrammarTopic(
    id: 'a1_pronouns',
    level: 'A1',
    titleEn: 'Personal Pronouns',
    titleKu: 'Cînavkên Kesî',
    emoji: '👤',
    summaryKu: 'I, you, he, she, it, we, they — formên kirdeyî (subject). me, you, him, her, it, us, them — formên bireserî (object). my, your, his, her, its, our, their — xwedîtî (possessive).',
    rules: [
      EnGrammarRule(
        ruleKu: 'Kirde (subject): I, you, he, she, it, we, they — berî lekerê tên, kar dikin.',
        examples: [
          EnGrammarExample(en: 'I am here.', ku: 'Ez li vir im.'),
          EnGrammarExample(en: 'You are my friend.', ku: 'Tu hevalê min î.'),
          EnGrammarExample(en: 'He works in Ankara.', ku: 'Ew li Enqereyê dixebite.'),
          EnGrammarExample(en: 'We are students.', ku: 'Em xwendekar in.'),
          EnGrammarExample(en: 'They are friends.', ku: 'Ew heval in.'),
        ],
        noteKu: 'Di Kurmancî de "ez/tu/ew/em/hûn/ew" heye. Lê Îngilîzî ji bo mêr "he" û ji bo jinê "she" cuda dike — Kurmancî nake. Ji bo tiştan "it" tê bikaranîn.',
      ),
      EnGrammarRule(
        ruleKu: 'Bireser (object): me, you, him, her, it, us, them — piştî lekerê an daçekê tên.',
        examples: [
          EnGrammarExample(en: 'She helps me.', ku: 'Ew alîkariya min dike.'),
          EnGrammarExample(en: 'I see him.', ku: 'Ez wî dibînim.'),
          EnGrammarExample(en: 'Give it to her.', ku: 'Ji wê re bide.'),
          EnGrammarExample(en: 'They invited us.', ku: 'Wan em vexwendin.'),
          EnGrammarExample(en: 'I see them.', ku: 'Ez wan dibînim.'),
        ],
        noteKu: 'XETA MEZIN: piştî daçeka "to" her tim forma bireserî tê: "Give it to me" (ne "to I"). "Between you and me" (ne "you and I").',
      ),
      EnGrammarRule(
        ruleKu: 'Xwedîtî (possessive adjective): my, your, his, her, its, our, their — berî navdêrê tên.',
        examples: [
          EnGrammarExample(en: 'My book is here.', ku: 'Pirtûka min li vir e.'),
          EnGrammarExample(en: 'Your car is fast.', ku: 'Ereba te zû ye.'),
          EnGrammarExample(en: 'Her name is Ana.', ku: 'Navê wê Ana ye.'),
          EnGrammarExample(en: 'Our house is big.', ku: 'Mala me mezin e.'),
          EnGrammarExample(en: 'Their house is big.', ku: 'Mala wan mezin e.'),
        ],
        noteKu: 'HIŞYARÎ: "its" (bê apostrof) = xwedîtî. "it\'s" (bi apostrof) = "it is". Xetaya herî yekem a Îngilîzîaxêvan jî.',
      ),
      EnGrammarRule(
        ruleKu: 'Cînavkên xwedîtî (possessive pronoun): mine, yours, his, hers, ours, theirs — bê navdêr dixebitin: "This book is mine."',
        examples: [
          EnGrammarExample(en: 'This book is mine.', ku: 'Ev pirtûk ya min e.'),
          EnGrammarExample(en: 'That pen is yours.', ku: 'Ew pênûs ya te ye.'),
          EnGrammarExample(en: 'The red car is hers.', ku: 'Ereba sor ya wê ye.'),
          EnGrammarExample(en: 'Those are theirs.', ku: 'Ew yên wan in.'),
        ],
        noteKu: 'FERQ: "my book" (bi navdêr) vs "mine" (bê navdêr). "Her car" vs "hers". Xeta: "This is hers book" ÇEWT e — an "her book" an "hers" (bê navdêr).',
      ),
      EnGrammarRule(
        ruleKu: 'Rêzkirina rêzdarî: gava te xwe û yekî din nav digire, di kirdeyê de "name and I": "John and I went." Di bireserê de "and me": "She saw John and me."',
        examples: [
          EnGrammarExample(en: 'John and I went home. (subject)', ku: 'Ez û John çûn malê.'),
          EnGrammarExample(en: 'She saw John and me. (object)', ku: 'Wê John û ez dîtin.'),
          EnGrammarExample(en: 'Between you and me, he is wrong.', ku: 'Di navbera min û te de, ew şaş e.'),
        ],
        noteKu: 'XETA: "Me and John went" di axaftina nefermî de tê bihîstin lê di nivîsê de çewt e. Standard: "John and I went".',
      ),
    ],
    quizQuestions: _qA1Pronouns,
  ),

  EnGrammarTopic(
    id: 'a1_plural',
    level: 'A1',
    titleEn: 'Plural Nouns',
    titleKu: 'Navdêrên Pirjimar',
    emoji: '➕',
    summaryKu: 'Qaîdeyên pirjimarkirinê: piraniya navdêran -s digirin. Hinek awarte (irregular) hene ku divê bên ezberkirin.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Qaîdeya giştî: + s. book → books, car → cars, friend → friends.',
        examples: [
          EnGrammarExample(en: 'I have two books.', ku: 'Du pirtûkên min hene.'),
          EnGrammarExample(en: 'Many cars are in the street.', ku: 'Gelek erebe li kolanê ne.'),
          EnGrammarExample(en: 'She has three friends.', ku: 'Sê hevalên wê hene.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Piştî -s, -ss, -sh, -ch, -x, -z: + es. bus → buses, box → boxes, church → churches, dish → dishes.',
        examples: [
          EnGrammarExample(en: 'Three buses arrived.', ku: 'Sê otobûs gihîştin.'),
          EnGrammarExample(en: 'Two boxes of books.', ku: 'Du qutiyên pirtûkan.'),
          EnGrammarExample(en: 'She washes the dishes.', ku: 'Ew firaxan dişo.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Piştî dengdar + y: y → ies. baby → babies, city → cities, story → stories. Lê piştî dengdêr + y: tenê +s. boy → boys, day → days.',
        examples: [
          EnGrammarExample(en: 'Two babies are crying.', ku: 'Du pitik digirîn.'),
          EnGrammarExample(en: 'Many cities are busy.', ku: 'Gelek bajar qerebalix in.'),
          EnGrammarExample(en: 'Three boys played football.', ku: 'Sê lawan futbol lîstin.'),
        ],
        noteKu: 'HIŞYARÎ: "boy" → "boys" NE "boies", ji ber ku piştî dengdêr "o". Lê "baby" → "babies" ji ber piştî "b" (dengdar).',
      ),
      EnGrammarRule(
        ruleKu: 'Piştî -f, -fe: ofte f → ves. leaf → leaves, wife → wives, knife → knives, life → lives. Lê hinek awarte: roof → roofs, chief → chiefs.',
        examples: [
          EnGrammarExample(en: 'The leaves are yellow.', ku: 'Pelên darê zer in.'),
          EnGrammarExample(en: 'Two knives are on the table.', ku: 'Du kêr li ser maseyê ne.'),
          EnGrammarExample(en: 'Their lives changed.', ku: 'Jiyanên wan guherîn.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Pirjimarên awarte (irregular): man → men, woman → women, child → children, foot → feet, tooth → teeth, mouse → mice, person → people.',
        examples: [
          EnGrammarExample(en: 'Two men and three women.', ku: 'Du mêr û sê jin.'),
          EnGrammarExample(en: 'Five children are playing.', ku: 'Pênc zarok dilîzin.'),
          EnGrammarExample(en: 'My feet hurt.', ku: 'Lingên min diêşin.'),
          EnGrammarExample(en: 'Many people came.', ku: 'Gelek mirov hatin.'),
        ],
        noteKu: 'HIŞYARÎ: "people" bi serê xwe pirjimar e: "People are kind" (ne "is"). "Persons" tenê di zimanê fermî/qanûnî de tê bikaranîn.',
      ),
      EnGrammarRule(
        ruleKu: 'Hinek navdêr bê guhertin pirjimar dibin: fish → fish, sheep → sheep, deer → deer, aircraft → aircraft.',
        examples: [
          EnGrammarExample(en: 'I saw two fish in the river.', ku: 'Min du masî di çêm de dîtin.'),
          EnGrammarExample(en: 'Five sheep are in the field.', ku: 'Pênc pez di zeviyê de ne.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Hinek navdêr tenê pirjimar in: trousers, scissors, glasses, jeans, clothes. Ji bo yek, "a pair of" tê bikaranîn: a pair of trousers.',
        examples: [
          EnGrammarExample(en: 'My trousers are new.', ku: 'Pantolê min nû ne.'),
          EnGrammarExample(en: 'Where are my glasses?', ku: 'Berçavkên min li ku ne?'),
          EnGrammarExample(en: 'I need a pair of scissors.', ku: 'Ji min re cotek meqes lazim e.'),
        ],
      ),
    ],
    quizQuestions: _qA1Plural,
  ),

  EnGrammarTopic(
    id: 'a1_there_is',
    level: 'A1',
    titleEn: 'There is / There are',
    titleKu: '"There is / There are" — Hebûn û Nebûn',
    emoji: '📍',
    summaryKu: 'Ji bo gotina ku tiştek heye an tune: "There is" (yekjimar) / "There are" (pirjimar). Bi Kurmancî "... heye / hene". Piştî bireserê bi gelemperî cih an dem tê.',
    rules: [
      EnGrammarRule(
        ruleKu: 'There is + navdêra yekjimar (an nehejmarbar). There are + navdêra pirjimar.',
        examples: [
          EnGrammarExample(en: 'There is a book on the table.', ku: 'Pirtûkek li ser maseyê heye.'),
          EnGrammarExample(en: 'There are many people here.', ku: 'Gelek mirov li vir hene.'),
          EnGrammarExample(en: 'There is some milk in the fridge.', ku: 'Hinek şîr di sarkerê de heye.'),
        ],
        noteKu: 'HIŞYARÎ: Bi navdêra nehejmarbar (water, milk, bread, music) hergav "There is" tê bikaranîn — ne "There are".',
      ),
      EnGrammarRule(
        ruleKu: 'Neyînî: There isn\'t / There aren\'t. Pirs: Is there ...? / Are there ...?',
        examples: [
          EnGrammarExample(en: 'There isn\'t any sugar.', ku: 'Şekir tune.'),
          EnGrammarExample(en: 'There aren\'t many students today.', ku: 'Îro xwendekarên zêde tune ne.'),
          EnGrammarExample(en: 'Is there a problem?', ku: 'Gelo pirsgirêk heye?'),
          EnGrammarExample(en: 'Are there any questions?', ku: 'Gelo pirsên we hene?'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'FERQ: "there is" (hebûn/nebûn) vs "it is" (diyarkirin). "There is a cat." (cat exists) vs "It is a cat." (what it is).',
        examples: [
          EnGrammarExample(en: 'There is a dog in the garden. (existence)', ku: 'Kûçikek di baxçe de heye.'),
          EnGrammarExample(en: 'It is a nice dog. (description — referring back)', ku: 'Ew kûçikekî xweş e.'),
          EnGrammarExample(en: 'There is someone at the door. (NE: It is someone)', ku: 'Yek li ber derî ye.'),
        ],
        noteKu: 'XETA HERÎ MEZIN JI BO KURMANCÎAXÊVAN: Di Kurmancî de "kûçikek heye" strukturek sade ye. Di Îngilîzî de divê "There is/are" bi kar bîne — tenê "A dog is in the garden" gelek xerîb xuya dike.',
      ),
      EnGrammarRule(
        ruleKu: 'Forma borî: There was (yekjimar) / There were (pirjimar). Pêşeroj: There will be. Present perfect: There has been / There have been.',
        examples: [
          EnGrammarExample(en: 'There was a party last night.', ku: 'Şeva borî partiyek hebû.'),
          EnGrammarExample(en: 'There were 20 people at the meeting.', ku: '20 kes li civînê hebûn.'),
          EnGrammarExample(en: 'There will be rain tomorrow.', ku: 'Sibê dê baran hebe.'),
        ],
      ),
    ],
    quizQuestions: _qA1ThereIs,
  ),

  EnGrammarTopic(
    id: 'a1_possessive_s',
    level: 'A1',
    titleEn: 'Possessive \'s (Saxon Genitive)',
    titleKu: 'Xwedîtî bi \'s',
    emoji: '🔑',
    summaryKu: 'Ji bo xwedîtiya kesan an heywanan: nav + \'s + tiştê xwedî. "Ali\'s car" = ereba Alî.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Kes/heywan + \'s + tişt: Ali\'s book, the dog\'s tail, my brother\'s car.',
        examples: [
          EnGrammarExample(en: 'This is Ali\'s car.', ku: 'Ev ereba Alî ye.'),
          EnGrammarExample(en: 'The dog\'s tail is long.', ku: 'Boqa kûçik dirêj e.'),
          EnGrammarExample(en: 'My sister\'s name is Ana.', ku: 'Navê xwişka min Ana ye.'),
        ],
        noteKu: 'FERQ ji apostrof: "Ali\'s book" (xwedîtî), "It\'s cold" (= it is), "books" (pirjimar, bê apostrof).',
      ),
      EnGrammarRule(
        ruleKu: 'Pirjimar bi -s: tenê apostrof, bê "s" ya duyem. "the boys\' room" (ne "the boys\'s").',
        examples: [
          EnGrammarExample(en: 'The boys\' room is upstairs.', ku: 'Odeya lawan li jor e.'),
          EnGrammarExample(en: 'My parents\' house is big.', ku: 'Mala dê û bavê min mezin e.'),
          EnGrammarExample(en: 'The students\' desks are new.', ku: 'Masên xwendekaran nû ne.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Pirjimarên awarte (bê -s): \'s normal tê. "children\'s", "men\'s", "women\'s".',
        examples: [
          EnGrammarExample(en: 'The children\'s toys are here.', ku: 'Pêlîstokên zarokan li vir in.'),
          EnGrammarExample(en: 'The men\'s clothes are on sale.', ku: 'Cilên mêran bi êrzanî têne firotin.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Ji bo tiştan bi gelemperî "of" tê bikaranîn, ne \'s: "the leg of the table" (ne "the table\'s leg").',
        examples: [
          EnGrammarExample(en: 'The leg of the table is broken.', ku: 'Pêya maseyê şikestî ye.'),
          EnGrammarExample(en: 'The roof of the house is red.', ku: 'Banê xaniyê sor e.'),
        ],
        noteKu: 'LÊ: ji bo dem, pîvan, û rêxistin ket forma \'s dibe: "today\'s newspaper", "a day\'s work", "the company\'s policy".',
      ),
      EnGrammarRule(
        ruleKu: 'FERQA "Ali\'s" (xwedîtî) vs "Ali\'s" (= Ali is/has): wate ji hevokê tê fêmkirin.',
        examples: [
          EnGrammarExample(en: 'Ali\'s car is red. (= Ali owns the car)', ku: 'Ereba Alî sor e.'),
          EnGrammarExample(en: 'Ali\'s tired. (= Ali is tired)', ku: 'Alî westiyayî ye.'),
          EnGrammarExample(en: 'Ali\'s gone home. (= Ali has gone)', ku: 'Alî çûye malê.'),
        ],
      ),
    ],
    quizQuestions: _qA1PossessiveS,
  ),

  // ═══ A2 — Pre-intermediate ═══════════════════════════════════
  EnGrammarTopic(
    id: 'a2_past_simple',
    level: 'A2',
    titleEn: 'Past Simple Tense',
    titleKu: 'Dema Borî ya Sade',
    emoji: '⏪',
    summaryKu: 'Ji bo rûdanên ku di demek borî de qediyane. Lekerên birêkûpêk (regular) -ed digirin; lekerên awarte (irregular) divê bên ezberkirin.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Lekerên birêkûpêk: + ed. work → worked, play → played, watch → watched. Heman form ji bo hemû kesan: I/you/he/she/we/they worked.',
        examples: [
          EnGrammarExample(en: 'I worked yesterday.', ku: 'Min duh xebitand. / Ez duh xebitîm.'),
          EnGrammarExample(en: 'She played football.', ku: 'Wê futbol lîst.'),
          EnGrammarExample(en: 'They watched a film.', ku: 'Wan fîlmek temaşe kir.'),
        ],
        noteKu: 'Di Kurmancî ergatîfê de (lekerên têper di borî de) kirde "min/te/wî/wê" dibe. Îngilîzî ergatîfê nizane — kirde her tim "I/she/he" dimîne, lê leker diguhere.',
      ),
      EnGrammarRule(
        ruleKu: 'Qaîdeyên nivîsîna -ed: piştî -e: tenê +d (live → lived). Piştî dengdar + y: y → ied (study → studied). Piştî dengdêra kurt + dengdar: dubare + ed (stop → stopped).',
        examples: [
          EnGrammarExample(en: 'She lived in Paris.', ku: 'Ew li Parîsê jiya.'),
          EnGrammarExample(en: 'He studied all night.', ku: 'Wî hemû şev xwend.'),
          EnGrammarExample(en: 'The car stopped suddenly.', ku: 'Ereb ji nişkê ve sekinî.'),
        ],
        noteKu: 'HIŞYARÎ: "played" (piştî dengdêr +y tenê +ed) lê "studied" (piştî dengdar +y, y → ied).',
      ),
      EnGrammarRule(
        ruleKu: 'Lekerên awarte (divê bên ezberkirin): go → went, come → came, see → saw, eat → ate, take → took, give → gave, have → had, buy → bought, do → did, say → said.',
        examples: [
          EnGrammarExample(en: 'I went to school.', ku: 'Ez çûm dibistanê.'),
          EnGrammarExample(en: 'He saw a film.', ku: 'Wî fîlmek dît.'),
          EnGrammarExample(en: 'We had dinner at 8.', ku: 'Me şîv di saet 8an de xwar.'),
          EnGrammarExample(en: 'She bought a new dress.', ku: 'Wê kirasekî nû kirî.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Neyînî: did not (didn\'t) + leker (forma binyad, BÊ -ed/awarte). "I didn\'t go" (NE "I didn\'t went").',
        examples: [
          EnGrammarExample(en: 'I didn\'t go to the party.', ku: 'Ez neçûm partiyê.'),
          EnGrammarExample(en: 'She didn\'t see me.', ku: 'Wê ez nedîtim.'),
          EnGrammarExample(en: 'They didn\'t eat anything.', ku: 'Wan tiştek nexwar.'),
        ],
        noteKu: 'XETA HERÎ MEZIN: "I didn\'t went" ÇEWT e! "Did" demê paşde dibe, loma leker dimîne sade: "didn\'t go", "didn\'t see", "didn\'t eat".',
      ),
      EnGrammarRule(
        ruleKu: 'Pirs: Did + kirde + leker (forma binyad)? "Did you eat?" (NE "Did you ate?"). Bi peyva pirsê: "Where did she go?"',
        examples: [
          EnGrammarExample(en: 'Did you eat breakfast?', ku: 'Te taştê xwar?'),
          EnGrammarExample(en: 'Where did she go?', ku: 'Ew çû ku derê?'),
          EnGrammarExample(en: 'When did they arrive?', ku: 'Ew kengî gihîştin?'),
          EnGrammarExample(en: 'Why did he leave?', ku: 'Çima ew çû?'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Hevokên demî ên sereke: yesterday, last week/month/year, in 2010, two days ago, when I was young.',
        examples: [
          EnGrammarExample(en: 'I saw her yesterday.', ku: 'Min ew duh dît.'),
          EnGrammarExample(en: 'We met in 2010.', ku: 'Em di 2010an de hev dîtin.'),
          EnGrammarExample(en: 'He called me two days ago.', ku: 'Du roj berê wî telefonî min kir.'),
        ],
        noteKu: 'HIŞYARÎ: "ago" hertim piştî demê tê: "two days ago", "a year ago" (ne "ago two days"). Ji bo Present Perfect "ago" NAYÊ bikaranîn — tenê Past Simple.',
      ),
    ],
    quizQuestions: _qA2PastSimple,
  ),

  EnGrammarTopic(
    id: 'a2_present_continuous',
    level: 'A2',
    titleEn: 'Present Continuous',
    titleKu: 'Dema Niha ya Berdewam',
    emoji: '🔄',
    summaryKu: 'Ji bo karên ku niha, vê gavê, an di vê demê de diqewimin: am/is/are + leker-ing. Cuda ji Present Simple (adet/rastiya giştî).',
    rules: [
      EnGrammarRule(
        ruleKu: 'Avakirin: subject + am/is/are + leker-ing. I am + -ing | He/She/It is + -ing | You/We/They are + -ing.',
        examples: [
          EnGrammarExample(en: 'I am eating lunch right now.', ku: 'Ez niha firavînê dixwim.'),
          EnGrammarExample(en: 'She is working at the moment.', ku: 'Niha ew dixebite.'),
          EnGrammarExample(en: 'They are playing in the garden.', ku: 'Ew di baxçe de dilîzin.'),
        ],
        noteKu: 'XETA KURMANCÎAXÊVAN: Di Kurmancî de "ez dixwim" hem ji bo "niha" hem ji bo "her roj" bi kar tê. Lê Îngilîzî du forman cuda dike: "I am eating" (niha) / "I eat" (her roj).',
      ),
      EnGrammarRule(
        ruleKu: 'Qaîdeyên nivîsîna -ing: piştî -e bêdeng: -e dikeve (write → writing, make → making). Piştî dengdêra kurt + dengdar: dubare (run → running, swim → swimming). Piştî -ie: ie → y (lie → lying).',
        examples: [
          EnGrammarExample(en: 'He is writing a letter.', ku: 'Ew nameyekê dinivîse.'),
          EnGrammarExample(en: 'They are running in the park.', ku: 'Ew di parkê de direvin.'),
          EnGrammarExample(en: 'The baby is lying on the bed.', ku: 'Zarok li ser cîhê raza ye.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Neyînî: am/is/are + not + V-ing. Pirs: leker "be" tê pêş — Am I -ing? Is she -ing?',
        examples: [
          EnGrammarExample(en: 'I am not working today.', ku: 'Ez îro naxebitim.'),
          EnGrammarExample(en: 'She isn\'t coming.', ku: 'Ew nayê.'),
          EnGrammarExample(en: 'Are you listening to me?', ku: 'Tu guhdariya min dikî?'),
          EnGrammarExample(en: 'What is he doing?', ku: 'Ew çi dike?'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Bikaranîn 2: ji bo guhertinên demkurt an rewşa demî: "I am learning English this year" (ne her tim, vê salê).',
        examples: [
          EnGrammarExample(en: 'I am learning English this year.', ku: 'Vê salê ez Îngilîzî hîn dibim.'),
          EnGrammarExample(en: 'She is staying with friends this week.', ku: 'Vê hefteyê ew li cem hevalan dimîne.'),
          EnGrammarExample(en: 'The weather is getting colder.', ku: 'Hewa sar û sartir dibe.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Bikaranîn 3: ji bo pêşeroja diyarkirî (arranged future): "I am meeting Ana tomorrow." Pir tê bikaranîn!',
        examples: [
          EnGrammarExample(en: 'I am meeting Ana tomorrow at 5.', ku: 'Sibê di saet 5an de ez ê bi Ana re hev bibînim.'),
          EnGrammarExample(en: 'We are flying to London next week.', ku: 'Hefteya bê em ê bi balafirê biçin Londonê.'),
        ],
        noteKu: 'Bi hevokên demî yên pêşerojê (tomorrow, next week, at 5pm) wateyê pêşeroja plankirî dide — ev bikaranîneke girîng e.',
      ),
      EnGrammarRule(
        ruleKu: 'LEKERÊN REWŞÊ (state verbs): know, believe, love, like, hate, want, need, understand, remember, own, belong, seem, mean — BI GIŞTÎ di forma -ing de NAYÊN bikaranîn.',
        examples: [
          EnGrammarExample(en: 'I know the answer. (NE: I am knowing)', ku: 'Ez bersivê dizanim.'),
          EnGrammarExample(en: 'She loves music. (NE: She is loving)', ku: 'Ew ji muzîkê hez dike.'),
          EnGrammarExample(en: 'Do you understand? (NE: Are you understanding)', ku: 'Tu fêm dikî?'),
          EnGrammarExample(en: 'This belongs to me. (NE: This is belonging)', ku: 'Ev yê min e.'),
        ],
        noteKu: 'XETA HERÎ BELAV: "I am understanding" ÇEWT e — "I understand" rast e. Kurmancî "fêm dikim" bikaranîna berdewam dişibîne, lê Îngilîzî ji bo lekerên rewşê tenê Present Simple bikar tîne.',
      ),
      EnGrammarRule(
        ruleKu: 'Peyvên nîşankirinê: now, right now, at the moment, currently, today, this week, these days, Look!, Listen!',
        examples: [
          EnGrammarExample(en: 'Look! The children are dancing.', ku: 'Binêre! Zarok direqisin.'),
          EnGrammarExample(en: 'Listen! Someone is knocking.', ku: 'Guhdarî bike! Yek lê dixe derî.'),
          EnGrammarExample(en: 'These days, I\'m reading a lot.', ku: 'Van rojan, ez pir dixwînim.'),
        ],
      ),
    ],
    quizQuestions: _qA2PresentContinuous,
  ),

  EnGrammarTopic(
    id: 'a2_comparatives',
    level: 'A2',
    titleEn: 'Comparatives & Superlatives',
    titleKu: 'Berawirdkirin (Comparative & Superlative)',
    emoji: '📊',
    summaryKu: 'Ji bo berawirdkirina du tiştan: rengdêr-er + than (taller than). Ji bo sê an zêdetir: the + rengdêr-est (the tallest). Ji bo rengdêrên dirêjtir: more / the most.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Rengdêrên yek-kîteyî (1 syllable): + er. tall → taller, fast → faster, old → older. Piştî dengdêra kurt + dengdar: dubare (big → bigger, hot → hotter).',
        examples: [
          EnGrammarExample(en: 'He is taller than me.', ku: 'Ew ji min dirêjtir e.'),
          EnGrammarExample(en: 'This box is bigger than that one.', ku: 'Ev qutî ji ya wê mezintir e.'),
          EnGrammarExample(en: 'Today is hotter than yesterday.', ku: 'Îro ji duh germtir e.'),
        ],
        noteKu: 'Di Kurmancî de "ji ... -tir" forma sabit. Di Îngilîzî de her tim "than" tê piştî formê berawirdkirinê.',
      ),
      EnGrammarRule(
        ruleKu: 'Rengdêrên du-kîteyî yên bi -y diqedin: y → ier. happy → happier, easy → easier, busy → busier.',
        examples: [
          EnGrammarExample(en: 'She is happier now.', ku: 'Niha ew bextewartir e.'),
          EnGrammarExample(en: 'This exam is easier than the last one.', ku: 'Ev îmtîhan ji ya berê hêsantir e.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Rengdêrên dirêjtir (2+ kîte, bê -y): more + rengdêr. beautiful → more beautiful, expensive → more expensive, important → more important.',
        examples: [
          EnGrammarExample(en: 'This dress is more beautiful than that one.', ku: 'Ev kiras ji yê wê delaltir e.'),
          EnGrammarExample(en: 'My car is more expensive than his.', ku: 'Ereba min ji ya wî bihatir e.'),
          EnGrammarExample(en: 'Health is more important than money.', ku: 'Tenduristî ji dirav giringtir e.'),
        ],
        noteKu: 'XETA MEZIN: "more taller" ÇEWT e! Tenê yek awa: an "taller" AN "more tall" (lê "more tall" ne standard e). Tenê "taller".',
      ),
      EnGrammarRule(
        ruleKu: 'Formên superlatîv: yek-kîteyî: the + rengdêr-est (the tallest, the biggest). Dirêjtir: the most + rengdêr (the most beautiful). Bi -y: the + -iest (the happiest).',
        examples: [
          EnGrammarExample(en: 'She is the tallest in the class.', ku: 'Ew di polê de ya herî dirêj e.'),
          EnGrammarExample(en: 'This is the most beautiful park in the city.', ku: 'Ev di bajêr de parka herî xweş e.'),
          EnGrammarExample(en: 'He is the happiest person I know.', ku: 'Ew mirovê herî bextewar ê ku ez dizanim.'),
        ],
        noteKu: 'HIŞYARÎ: "the" berî superlatîvê MECBÛRÎ ye — "She is tallest" ne standard e; "She is the tallest" rast e.',
      ),
      EnGrammarRule(
        ruleKu: 'Formên awarte (irregular): good → better → the best | bad → worse → the worst | far → farther/further → the farthest/furthest | little → less → the least | much/many → more → the most.',
        examples: [
          EnGrammarExample(en: 'My English is better than yours.', ku: 'Îngilîziya min ji ya te baştir e.'),
          EnGrammarExample(en: 'She is the best student.', ku: 'Ew xwendekara herî baş e.'),
          EnGrammarExample(en: 'This is worse than I thought.', ku: 'Ev ji tiştê ku min digot xirabtir e.'),
          EnGrammarExample(en: 'I have less time today.', ku: 'Îro dema min kêmtir e.'),
        ],
        noteKu: 'Van formên awarte divê bên ezberkirin — pir tên bikaranîn. "More" hem ji bo zêdekirinê hem ji bo rengdêran tê bikaranîn.',
      ),
      EnGrammarRule(
        ruleKu: 'Avakirinên din: as ... as (heman qas) — as tall as me. not as ... as (ne qasî) — not as tall as him. Binirxandin: twice as big, much bigger, a bit taller.',
        examples: [
          EnGrammarExample(en: 'She is as tall as her sister.', ku: 'Ew bi qasî xwişka xwe dirêj e.'),
          EnGrammarExample(en: 'This book is not as interesting as that one.', ku: 'Ev pirtûk ne bi qasî wê balkêş e.'),
          EnGrammarExample(en: 'This car is much faster.', ku: 'Ev ereb pir zûtir e.'),
          EnGrammarExample(en: 'He is a bit younger than me.', ku: 'Ew piçekî ji min ciwantir e.'),
        ],
      ),
    ],
    quizQuestions: _qA2Comparatives,
  ),

  EnGrammarTopic(
    id: 'a2_can_must',
    level: 'A2',
    titleEn: 'Modal Verbs A2 (can, must, have to)',
    titleKu: 'Modalên Bingehîn (can, must, have to)',
    emoji: '🛡️',
    summaryKu: 'can = karîn, must = divê / pêwîst e (xurt), have to = pêwîst e (ji der ve). Qaîdeyên hevpar: modal + leker-a binyadî (bê -s, bê "to").',
    rules: [
      EnGrammarRule(
        ruleKu: 'QAÎDEYÊN HEMÛ MODALAN: (1) Piştî modalê leker-a binyadî (infinitive bê "to"), (2) -s di kesê 3em de nayê zêdekirin, (3) ji bo neyînî: modal + not, (4) ji bo pirs: modal tê pêş.',
        examples: [
          EnGrammarExample(en: 'She can drive. (NE: She cans / She can to drive / She can drives)', ku: 'Ew dikare ajotinê bike.'),
          EnGrammarExample(en: 'He must study. (NE: He musts / He must to study)', ku: 'Divê ew bixwîne.'),
          EnGrammarExample(en: 'Can she swim?', ku: 'Ew dikare avjeniyê bike?'),
        ],
        noteKu: 'XETA HERÎ MEZIN JI BO KURMANCÎAXÊVAN: piştî modalê "to" NAYÊ! "I can to swim" ÇEWT e — "I can swim" rast e. Dibe ji Kurmancî "dikarim ... bikim" biguhere.',
      ),
      EnGrammarRule(
        ruleKu: 'can: karîn / şiyan. Ji bo şiyana rojane, îmkan, an destûra nefermî. Forma neyînî: cannot / can\'t.',
        examples: [
          EnGrammarExample(en: 'I can speak two languages.', ku: 'Ez dikarim bi du zimanan bipeyivim.'),
          EnGrammarExample(en: 'She can play the guitar.', ku: 'Ew dikare gîtarê lê bide.'),
          EnGrammarExample(en: 'Can I use your phone?', ku: 'Ez dikarim têlefona te bi kar bînim?'),
          EnGrammarExample(en: 'I can\'t come tomorrow.', ku: 'Ez nikarim sibê werim.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'could: forma borî ya "can" (şiyana giştî di borî de) an formeke nermtir ji bo daxwaz / îmkanê.',
        examples: [
          EnGrammarExample(en: 'He could read at age four. (past ability)', ku: 'Ew di çar saliyê de dikarîbû bixwîne.'),
          EnGrammarExample(en: 'Could you help me, please? (polite request)', ku: 'Gelo tu dikarî alîkariya min bikî, ji kerema xwe?'),
          EnGrammarExample(en: 'It could rain later. (possibility)', ku: 'Dibe ku paşê baran bibare.'),
        ],
        noteKu: 'HIŞYARÎ: ji bo şiyana yek carekê di borî de (not general), "was/were able to" tê bikaranîn: "I was able to finish the race" (ne "I could finish").',
      ),
      EnGrammarRule(
        ruleKu: 'must: pêwîstiya xurt an biryara kesane; her weha texmîna piştrast (logical deduction). Forma pirs û borî kêm e — şûna "have to".',
        examples: [
          EnGrammarExample(en: 'You must wear a seatbelt.', ku: 'Divê tu qemberê ewlehiyê li xwe bikî.'),
          EnGrammarExample(en: 'I must call my mother.', ku: 'Divê ez telefonî diya xwe bikim.'),
          EnGrammarExample(en: 'She must be tired. (logical conclusion)', ku: 'Teqez ew westiyayî ye.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'must not (mustn\'t) vs don\'t have to — FERQA HERÎ GIRÎNG: "mustn\'t" = qedexe ye; "don\'t have to" = ne pêwîst e.',
        examples: [
          EnGrammarExample(en: 'You mustn\'t smoke here. (forbidden)', ku: 'Divê tu li vir cixareyê nekişînî. (qedexe ye)'),
          EnGrammarExample(en: 'You don\'t have to come if you don\'t want. (not necessary)', ku: 'Ne pêwîst e ku tu bêyî ger tu naxwazî. (serbest e)'),
        ],
        noteKu: 'FERQ A KRÎTÎK: "You mustn\'t go" = negere (qedexe)! "You don\'t have to go" = ger tu naxwazî neçe (serbest). Kurmancî "divê neçî" (xurt) vs "ne pêwîst e tu herî" (nerm).',
      ),
      EnGrammarRule(
        ruleKu: 'have to / has to / had to: pêwîstiya ji der ve (qaîde, qanûn, rewş). Di hemû deman de tê bikaranîn (berovajî "must" ku tenê niha ye).',
        examples: [
          EnGrammarExample(en: 'I have to work tomorrow.', ku: 'Pêwîst e ez sibê bixebitim.'),
          EnGrammarExample(en: 'She has to study for the exam.', ku: 'Pêwîst e ew ji bo îmtîhanê bixwîne.'),
          EnGrammarExample(en: 'We had to wait two hours.', ku: 'Em mecbûr bûn du demjimêran li bendê bimînin.'),
          EnGrammarExample(en: 'Do I have to come? (question)', ku: 'Pêwîst e ez werim?'),
        ],
        noteKu: 'CUDAHÎ: "must" = biryara hundirîn (ez xwe mecbûr dikim). "have to" = ji der ve (zagon, patron, qaîde). Nimûne: "I must call my mom" (ez dixwazim) / "I have to work Sundays" (patronê min dibêje).',
      ),
      EnGrammarRule(
        ruleKu: 'should / shouldn\'t: şîret / pêşniyar (ne xurt wekî "must"). Ji bo tiştê ku baş e.',
        examples: [
          EnGrammarExample(en: 'You should drink more water.', ku: 'Divê tu avê zêdetir vexwî.'),
          EnGrammarExample(en: 'You shouldn\'t smoke.', ku: 'Divê tu cixareyê nekişînî.'),
          EnGrammarExample(en: 'Should I apologize?', ku: 'Divê ez lêborîn bixwazim?'),
        ],
      ),
    ],
    quizQuestions: _qA2CanMust,
  ),

  EnGrammarTopic(
    id: 'a2_going_to',
    level: 'A2',
    titleEn: 'Future with "going to"',
    titleKu: 'Pêşeroja bi "going to"',
    emoji: '🔜',
    summaryKu: 'Ji bo plan, niyet, an texmînê ku em li gorî delîlên niha dikin: am/is/are + going to + leker-a binyad. Bi Kurmancî "ez ê ... bikim" nêzîk e.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Avakirin: subject + am/is/are + going to + leker-a binyad.',
        examples: [
          EnGrammarExample(en: 'I am going to visit my grandmother tomorrow.', ku: 'Ez ê sibê serdana dapîra xwe bikim.'),
          EnGrammarExample(en: 'She is going to start a new job.', ku: 'Ew ê karekî nû dest pê bike.'),
          EnGrammarExample(en: 'They are going to move to London.', ku: 'Ew ê bar bikin Londonê.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Bikaranîn 1: plan û niyetên niha ji bo pêşerojê (biryar berê hatiye dayîn).',
        examples: [
          EnGrammarExample(en: 'I\'m going to study medicine.', ku: 'Ez ê bijîşkiyê bixwînim.'),
          EnGrammarExample(en: 'We are going to have a party next week.', ku: 'Em ê hefteya din partiyek li dar bixin.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Bikaranîn 2: texmîn li gorî delîlên em niha dibînin. "Look at those clouds! It\'s going to rain."',
        examples: [
          EnGrammarExample(en: 'Look at those dark clouds! It\'s going to rain.', ku: 'Li wan ewrên reş binêre! Dê baran bibare.'),
          EnGrammarExample(en: 'Be careful! You\'re going to fall!', ku: 'Hişyar be! Tu yê bikevî!'),
        ],
        noteKu: 'FERQA "going to" vs "will": "going to" = li gorî delîl an planek berê; "will" = biryar di dema axaftinê de an texmîna giştî.',
      ),
      EnGrammarRule(
        ruleKu: 'Neyînî: am/is/are + not + going to. Pirs: Am/Is/Are + subject + going to...?',
        examples: [
          EnGrammarExample(en: 'I\'m not going to wait anymore.', ku: 'Ez êdî li bendê namînim.'),
          EnGrammarExample(en: 'Is she going to come?', ku: 'Ew ê were?'),
          EnGrammarExample(en: 'What are you going to do?', ku: 'Tu yê çi bikî?'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Bi "go" xwe re dikeve formek kêmtir xerîb: "going to go" → pir caran "going" tenê tê bikaranîn.',
        examples: [
          EnGrammarExample(en: 'I\'m going to the store. (= going to go to)', ku: 'Ez diçim dikanê.'),
          EnGrammarExample(en: 'We\'re going home.', ku: 'Em diçin malê.'),
        ],
      ),
    ],
    quizQuestions: _qA2GoingTo,
  ),

  EnGrammarTopic(
    id: 'a2_countable_uncountable',
    level: 'A2',
    titleEn: 'Countable & Uncountable Nouns',
    titleKu: 'Navdêrên Hejmarbar û Nehejmarbar',
    emoji: '🔢',
    summaryKu: 'Navdêrên hejmarbar (countable): dikarin bên hejmarîn — a cat, two cats. Navdêrên nehejmarbar (uncountable): nayên hejmarîn — water, music, information. Her cure bi qaîdeyên cuda dixebite.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Navdêrên nehejmarbar (bi gelemperî): water, milk, tea, bread, sugar, salt, rice, music, information, advice, news, knowledge, money, time, furniture, luggage, homework, weather.',
        examples: [
          EnGrammarExample(en: 'I drink water every day.', ku: 'Ez her roj avê vedixwim.'),
          EnGrammarExample(en: 'I need some advice. (NE: an advice)', ku: 'Ji min re şîret lazim e.'),
          EnGrammarExample(en: 'The news is interesting. (NE: news are)', ku: 'Nûçe balkêş e.'),
        ],
        noteKu: 'HIŞYARÎ: Di Îngilîzî de hin peyv di Kurmancî de hejmarbar xuya dikin lê di Îngilîzî de nehejmarbar in: information, advice, news, knowledge, furniture, luggage, homework, work, research. "An information" ÇEWT — "a piece of information" rast.',
      ),
      EnGrammarRule(
        ruleKu: 'Much (nehejmarbar) vs Many (hejmarbar): "How much water?" / "How many books?" Forma erênî bi "a lot of" (her du cure).',
        examples: [
          EnGrammarExample(en: 'How much water do you drink?', ku: 'Tu çiqas av vedixwî?'),
          EnGrammarExample(en: 'How many books do you have?', ku: 'Çend pirtûkên te hene?'),
          EnGrammarExample(en: 'I have a lot of friends.', ku: 'Gelek hevalên min hene.'),
          EnGrammarExample(en: 'There isn\'t much milk.', ku: 'Şîr zêde nîne.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'A few (hejmarbar, erênî — "hinek") vs Few (hejmarbar, neyînî — "kêm"). A little (nehejmarbar, erênî) vs Little (nehejmarbar, neyînî).',
        examples: [
          EnGrammarExample(en: 'I have a few friends here. (some — positive)', ku: 'Hinek hevalên min li vir hene.'),
          EnGrammarExample(en: 'I have few friends. (not many — negative tone)', ku: 'Kêm hevalên min hene.'),
          EnGrammarExample(en: 'I have a little time. (some — positive)', ku: 'Hinek dema min heye.'),
          EnGrammarExample(en: 'I have little time. (not enough — negative)', ku: 'Dema min kêm e.'),
        ],
        noteKu: 'FERQA WATEYÊ: "a few/a little" = hinek (erênî). "few/little" = kêm (neyînî, ne têrê). Bê "a" bingehek neyînî heye.',
      ),
      EnGrammarRule(
        ruleKu: 'Some (erênî / daxwaz) vs Any (neyînî / pirs). Bi her du cureyan tê: "some milk" / "some books".',
        examples: [
          EnGrammarExample(en: 'I have some money. (positive)', ku: 'Hinek pereyên min hene.'),
          EnGrammarExample(en: 'I don\'t have any money. (negative)', ku: 'Pereyên min tune ne.'),
          EnGrammarExample(en: 'Do you have any questions? (question)', ku: 'Pirsên we hene?'),
          EnGrammarExample(en: 'Would you like some tea? (offer — "some" in offers/requests)', ku: 'Tu çay dixwazî?'),
        ],
        noteKu: 'AWARTE: "some" di pirs/daxwazê de jî tê dema em bersivek erênî li bendê ne: "Would you like some coffee?" (daxwaz — "some" dipejirîne).',
      ),
      EnGrammarRule(
        ruleKu: 'Navdêrên nehejmarbar dikarin bi "piece of", "cup of", "bottle of" re bibin hejmarbar: a piece of advice, a cup of tea, a bottle of water.',
        examples: [
          EnGrammarExample(en: 'I need a piece of advice.', ku: 'Ji min re şîretek lazim e.'),
          EnGrammarExample(en: 'Two cups of coffee, please.', ku: 'Du fincan qehwe, ji kerema xwe.'),
          EnGrammarExample(en: 'She bought three bottles of water.', ku: 'Wê sê şûşe av kirîn.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Hin navdêr dikarin herdu be — bi wate cuda: hair (por, nehejmarbar) / a hair (tayek mû, hejmarbar); time (dem) / times (cara); coffee (qehwe) / a coffee (fincanek qehwe).',
        examples: [
          EnGrammarExample(en: 'Her hair is long. (uncountable)', ku: 'Porê wê dirêj e.'),
          EnGrammarExample(en: 'There\'s a hair in my soup. (a single hair)', ku: 'Mûyek di şorbeya min de heye.'),
          EnGrammarExample(en: 'Would you like a coffee? (= a cup of coffee)', ku: 'Tu fincanek qehwe dixwazî?'),
        ],
      ),
    ],
    quizQuestions: _qA2CountableUncountable,
  ),

  // ═══ B1 — Intermediate ═══════════════════════════════════════
  EnGrammarTopic(
    id: 'b1_first_conditional',
    level: 'B1',
    titleEn: 'First Conditional (If + present, will)',
    titleKu: 'Şertê Yekem (If + present, will)',
    emoji: '🎲',
    summaryKu: 'Ji bo şertên rast/mimkin di pêşerojê de: If + present simple, will + leker-a binyad. Encamek gengaz heye.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Avakirin: If + kirde + present simple, kirde + will + leker-a binyadî.',
        examples: [
          EnGrammarExample(en: 'If it rains, I will stay home.', ku: 'Ger baran bibare, ez ê li malê bimînim.'),
          EnGrammarExample(en: 'If you study, you will pass.', ku: 'Ger tu bixwînî, tu yê derbas bibî.'),
          EnGrammarExample(en: 'If she calls, I will answer.', ku: 'Ger ew telefonê bike, ez ê bersivê bidim.'),
        ],
        noteKu: 'XETA HERÎ MEZIN: piştî "if" "will" NAYÊ! "If I will go" ÇEWT e. "If I go" rast. Di klozê şertê de her tim dema niha ye.',
      ),
      EnGrammarRule(
        ruleKu: 'Cihê klozên (main/if) diguhere: If-kloze dikare berê an paşê were. Ger pêşîn be, vîrgul pêdivî ye; ger paşîn be, vîrgul nayê.',
        examples: [
          EnGrammarExample(en: 'If you need help, ask me.', ku: 'Ger tu hewceyî alîkariyê bî, ji min bipirse.'),
          EnGrammarExample(en: 'Ask me if you need help. (bê vîrgul)', ku: 'Ji min bipirse ger tu hewceyî alîkariyê bî.'),
          EnGrammarExample(en: 'I will call you if I have time.', ku: 'Ez ê telefonî te bikim ger dema min hebe.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Alternatîvên ji bo "will": can (şiyan), may/might (îhtîmal), should (pêşniyar), must (mecbûrî), imperative (ferman) dikarin bên bikaranîn.',
        examples: [
          EnGrammarExample(en: 'If you finish early, you can leave.', ku: 'Ger tu zû biqedînî, tu dikarî biçî.'),
          EnGrammarExample(en: 'If it snows, it might be cold.', ku: 'Ger berf bibare, dibe ku sar bibe.'),
          EnGrammarExample(en: 'If she calls, tell her I\'m busy. (imperative)', ku: 'Ger ew telefonê bike, jê re bêje ku ez mijûl im.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: '"when" vs "if": "if" — ne teqez; "when" — teqez dibe, tenê dema wê ne zelal.',
        examples: [
          EnGrammarExample(en: 'If I see her, I will tell her. (maybe I see her)', ku: 'Ger ez wê bibînim, ez ê jê re bibêjim.'),
          EnGrammarExample(en: 'When I see her, I will tell her. (I will see her)', ku: 'Dema ku ez wê bibînim, ez ê jê re bibêjim.'),
        ],
        noteKu: 'Qaîde her du de eynî ye: "when" jî dema niha digire, "will" nagire! "When I will see her" ÇEWT e.',
      ),
      EnGrammarRule(
        ruleKu: 'Formên neyînî: If + S + don\'t/doesn\'t + V, S + won\'t + V. Herdu kloz dikarin neyînî bibin.',
        examples: [
          EnGrammarExample(en: 'If you don\'t study, you won\'t pass.', ku: 'Ger tu nexwîne, tu yê derbas nebî.'),
          EnGrammarExample(en: 'If it doesn\'t rain, we will go out.', ku: 'Ger baran nebare, em ê derkevin.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: '"unless" = "if ... not". Di cihê "if not" de tê bikaranîn, lê tenê bi klozên erênî: "Unless you hurry, you\'ll miss the bus."',
        examples: [
          EnGrammarExample(en: 'Unless you hurry, you will miss the bus.', ku: 'Ger tu zû negerî, tu yê otobûsê ji dest bidî.'),
          EnGrammarExample(en: 'I won\'t go unless you come with me.', ku: 'Ez neçim ger tu bi min re neyê.'),
        ],
      ),
    ],
    quizQuestions: _qB1FirstConditional,
  ),

  EnGrammarTopic(
    id: 'b1_passive_intro',
    level: 'B1',
    titleEn: 'Passive Voice (Introduction)',
    titleKu: 'Forma Pasîv — Destpêk',
    emoji: '↪️',
    summaryKu: 'Gava kirde (kê çêkir) ne girîng e, an em nizanin kê kir, an em li ser bireserê radiwestin: be + past participle (V3). Li vir tenê Present Simple û Past Simple.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Koka pasîvê: aktîv = kirde lekerê dike. pasîv = bireser dibe kirde. "John writes letters" → "Letters are written (by John)".',
        examples: [
          EnGrammarExample(en: 'Active: John writes letters. | Passive: Letters are written by John.', ku: 'Aktîv: John nameyan dinivîse. | Pasîv: Name ji aliyê John de tên nivîsandin.'),
          EnGrammarExample(en: 'Active: They built the bridge. | Passive: The bridge was built.', ku: 'Aktîv: Wan pir çêkir. | Pasîv: Pir hat çêkirin.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Present Simple Passive: am/is/are + V3. "English is spoken here." (yekjimar — is; pirjimar — are).',
        examples: [
          EnGrammarExample(en: 'English is spoken in many countries.', ku: 'Îngilîzî di gelek welatan de tê axaftin.'),
          EnGrammarExample(en: 'These cars are made in Germany.', ku: 'Ev ereb li Almanyayê tên çêkirin.'),
          EnGrammarExample(en: 'The news is reported every hour. ("news" yekjimar e!)', ku: 'Nûçe her saet tê ragihandin.'),
        ],
        noteKu: 'HIŞYARÎ: "news", "information" di Îngilîzî de yekjimar in — "is", ne "are". "The news is..." rast.',
      ),
      EnGrammarRule(
        ruleKu: 'Past Simple Passive: was/were + V3. "was" yekjimar, "were" pirjimar. "The letter was sent." / "The letters were sent."',
        examples: [
          EnGrammarExample(en: 'The letter was sent yesterday.', ku: 'Name duh hat şandin.'),
          EnGrammarExample(en: 'The houses were built in 1990.', ku: 'Xanî di 1990an de hatin avakirin.'),
          EnGrammarExample(en: 'My bike was stolen last night.', ku: 'Bisiklêta min şeva borî hat dizîn.'),
        ],
        noteKu: '"by + kirde" tê dawiyê dema em dixwazin kirde diyar bikin: "The book was written by Orwell." Lê piraniya caran kirde tê derxistin.',
      ),
      EnGrammarRule(
        ruleKu: 'Dema forma pasîv tê bikaranîn: (1) dema kirde ne zelal/ne girîng e, (2) dema em li ser bireserê radiwestin, (3) di nivîsên zanistî, fermî û medya de.',
        examples: [
          EnGrammarExample(en: 'My bike was stolen last night. (we don\'t know by whom)', ku: 'Bisiklêta min şeva borî hat dizîn.'),
          EnGrammarExample(en: 'This temple was built 2000 years ago. (focus on temple)', ku: 'Ev perestgeh 2000 sal berê hat avakirin.'),
          EnGrammarExample(en: 'The suspect was arrested. (news style)', ku: 'Gumanbar hat girtin.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Guhertina aktîv → pasîv: Bireser → kirde. Leker → be + V3. Kirdeyê kevn dibe "by + ...".',
        examples: [
          EnGrammarExample(en: 'They build houses. → Houses are built (by them).', ku: 'Ew xaniyan çêdikin. → Xanî tên çêkirin.'),
          EnGrammarExample(en: 'She wrote the letter. → The letter was written (by her).', ku: 'Wê name nivîsand. → Name hat nivîsandin.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'XETA BI V3: Past participle forms — lekerên awarte divê bên ezberkirin. write → written (NE wrote), speak → spoken (NE spoke), break → broken (NE broke), steal → stolen.',
        examples: [
          EnGrammarExample(en: 'The book was written by Orwell. (NE: was wrote)', ku: 'Pirtûk ji aliyê Orwell ve hat nivîsandin.'),
          EnGrammarExample(en: 'The window was broken. (NE: was broke)', ku: 'Pencere hat şikandin.'),
          EnGrammarExample(en: 'English is spoken here. (NE: is spoke)', ku: 'Li vir Îngilîzî tê axaftin.'),
        ],
        noteKu: 'Xeta herî belav: "was wrote" / "was spoke" / "was broke". Rast: was WRITTEN, was SPOKEN, was BROKEN (formên V3).',
      ),
    ],
    quizQuestions: _qB1PassiveIntro,
  ),

  EnGrammarTopic(
    id: 'b1_reported_speech_intro',
    level: 'B1',
    titleEn: 'Reported Speech (Basics)',
    titleKu: 'Axaftina Neqilkirî — Bingeh',
    emoji: '🗣️',
    summaryKu: 'Dema em gotinên kesekî din neqil dikin, dem bi gelemperî gavek paşde diçe (backshift). "I am tired" → He said he was tired.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Guhertina demê (backshift): present simple → past simple, present continuous → past continuous, present perfect → past perfect, past simple → past perfect, will → would, can → could, may → might.',
        examples: [
          EnGrammarExample(en: '"I am happy." → She said she was happy.', ku: '"Ez kêfxweş im." → Wê got ku ew kêfxweş bû.'),
          EnGrammarExample(en: '"I will come." → He said he would come.', ku: '"Ez ê werim." → Wî got ku ew ê bê.'),
          EnGrammarExample(en: '"I can help." → They said they could help.', ku: '"Ez dikarim alîkarî bikim." → Wan got ku ew dikarin alîkariyê bikin.'),
          EnGrammarExample(en: '"I have finished." → She said she had finished.', ku: '"Min qedand." → Wê got ku wê qedandibû.'),
        ],
        noteKu: 'Di Kurmancî de dem kêm diguhere di axaftina neqilkirî de — Îngilîzî de guhertin (backshift) mecbûr e dema kitima sereke di borî de be (said, told).',
      ),
      EnGrammarRule(
        ruleKu: 'Cînavk û xwedîtî jî tên guhertin: I → he/she, my → his/her, we → they, our → their — li gorî kesê ku diaxive û kesê ku tê neqilkirin.',
        examples: [
          EnGrammarExample(en: 'Ali said, "I am tired." → Ali said he was tired.', ku: 'Alî got: "Ez westiyame." → Alî got ku ew westiyayî bû.'),
          EnGrammarExample(en: 'She said, "My car is broken." → She said her car was broken.', ku: 'Wê got: "Ereba min xerab e." → Wê got ku ereba wê xerab bû.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Peyvên demê û cih diguherin: now → then, today → that day, yesterday → the day before / the previous day, tomorrow → the next day / the following day, here → there, this → that.',
        examples: [
          EnGrammarExample(en: '"I\'ll see you tomorrow." → She said she would see me the next day.', ku: '"Ez ê sibê te bibînim." → Wê got ku ew ê roja din min bibîne.'),
          EnGrammarExample(en: '"I saw him yesterday." → He said he had seen him the day before.', ku: '"Min ew duh dît." → Wî got ku wî roja berê ew dîtibû.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'FERQA "say" vs "tell": "tell" her tim bi bireser re tê (tell someone); "say" bê bireser an bi "to + someone" re tê.',
        examples: [
          EnGrammarExample(en: 'She told me she was tired.', ku: 'Wê ji min re got ku ew westiyayî ye.'),
          EnGrammarExample(en: 'She said (that) she was tired.', ku: 'Wê got ku ew westiyayî ye.'),
          EnGrammarExample(en: 'She said to me that she was tired. (kêm tê bikaranîn)', ku: 'Wê ji min re got ku ew westiyayî ye.'),
        ],
        noteKu: 'XETA HERÎ BELAV: "She said me" ÇEWT e! Ji bo "ji yekî re gotin" an "tell someone" an "say to someone" tê bikaranîn. "said me" di Îngilîzî de tune.',
      ),
      EnGrammarRule(
        ruleKu: 'Dema ku kitima sereke di dema niha de be (says/tells), backshift NAYÊ: guhertin nayê kirin.',
        examples: [
          EnGrammarExample(en: 'She says she is tired. (no backshift)', ku: 'Ew dibêje ku ew westiyayî ye.'),
          EnGrammarExample(en: 'He tells me he will come. (no backshift)', ku: 'Ew ji min re dibêje ku ew ê bê.'),
        ],
      ),
    ],
    quizQuestions: _qB1ReportedSpeechIntro,
  ),

  EnGrammarTopic(
    id: 'b1_present_perfect',
    level: 'B1',
    titleEn: 'Present Perfect',
    titleKu: 'Dema Niha ya Têkûz',
    emoji: '✅',
    summaryKu: 'Ji bo: (1) tiştê ku di borî de dest pê kiriye û heta niha berdewam e, (2) tiştê ku demek nîne qediyaye û bandora wê heye, (3) serpêhatiyên jiyanê bê dema diyarkirî: have/has + past participle (forma 3em).',
    rules: [
      EnGrammarRule(
        ruleKu: 'Avakirin: subject + have/has + past participle (V3). I/you/we/they + have; he/she/it + has.',
        examples: [
          EnGrammarExample(en: 'I have lived here for 5 years.', ku: 'Ez 5 sal in li vir dijîm.'),
          EnGrammarExample(en: 'She has finished her work.', ku: 'Wê kara xwe qedandiye.'),
          EnGrammarExample(en: 'They have gone to Paris.', ku: 'Ew çûne Parîsê.'),
        ],
        noteKu: 'Past participle: lekerên birêkûpêk = V + ed (worked, lived); lekerên awarte divê bên ezberkirin (go → gone, see → seen, write → written, take → taken).',
      ),
      EnGrammarRule(
        ruleKu: 'Bikaranîn 1: ji bo rewşek ku di borî de dest pê kiriye û heta niha berdewam dike. Bi "for" (dema dirêj) û "since" (xala destpêk) re.',
        examples: [
          EnGrammarExample(en: 'I have known him for 10 years.', ku: '10 sal in ez wî dinasim.'),
          EnGrammarExample(en: 'She has lived here since 2020.', ku: 'Ji 2020an ve ew li vir dijî.'),
          EnGrammarExample(en: 'We have been married for 20 years.', ku: '20 sal in em zewicî ne.'),
        ],
        noteKu: 'FERQ: "for" + pîvana demê (for 5 years, for a month). "since" + xala destpêkê (since 2020, since Monday, since I was a child).',
      ),
      EnGrammarRule(
        ruleKu: 'Bikaranîn 2: tiştê ku nû qediyaye û bandora wê niha heye. Bi "just", "already", "yet", "recently" re pir tê bikaranîn.',
        examples: [
          EnGrammarExample(en: 'I have just arrived.', ku: 'Ez niha gihîştim.'),
          EnGrammarExample(en: 'She has already eaten.', ku: 'Wê berê jî xwariye.'),
          EnGrammarExample(en: 'Have you finished yet?', ku: 'Gelo te qedandiye hê?'),
          EnGrammarExample(en: 'He hasn\'t called yet.', ku: 'Wî hê telefonê nekiriye.'),
        ],
        noteKu: 'CIH: "just" û "already" di navbera have/has û V3 de ne. "yet" di dawiyê de — tenê di neyînî û pirsê de.',
      ),
      EnGrammarRule(
        ruleKu: 'Bikaranîn 3: serpêhatiyên jiyanê — "ever", "never", "before". Dem ne diyar e.',
        examples: [
          EnGrammarExample(en: 'Have you ever been to Paris?', ku: 'Gelo tu qet çûyî Parîsê?'),
          EnGrammarExample(en: 'I have never eaten sushi.', ku: 'Min qet sûşî nexwariye.'),
          EnGrammarExample(en: 'I have seen that film before.', ku: 'Min ew fîlim berê dîtiye.'),
        ],
        noteKu: 'HIŞYARÎ: "have been to" = çûme û vegeriyame. "have gone to" = çûme û hê li wir im/me.',
      ),
      EnGrammarRule(
        ruleKu: 'FERQA HERÎ GIRÎNG: Present Perfect vs Past Simple. Hişyar be: Past Simple bi demek diyarkirî tê (yesterday, last week, in 2010, ago); Present Perfect bi demê VEKIRÎ tê.',
        examples: [
          EnGrammarExample(en: 'I have visited Paris. (lifetime experience)', ku: 'Min Parîs dîtiye. (di jiyana xwe de)'),
          EnGrammarExample(en: 'I visited Paris in 2015. (specific time — past simple)', ku: 'Min di 2015an de Parîs dît.'),
          EnGrammarExample(en: 'She has lived here since 2020. (still lives here)', ku: 'Ji 2020an ve ew li vir dijî (hê jî).'),
          EnGrammarExample(en: 'She lived here from 2018 to 2020. (finished period)', ku: 'Ew ji 2018 heta 2020 li vir jiya.'),
        ],
        noteKu: 'XETAYA HERÎ BELAV: "I have seen him yesterday" ÇEWT e! Piştî "yesterday/ago/in 2020" her tim Past Simple tê: "I saw him yesterday".',
      ),
      EnGrammarRule(
        ruleKu: 'XETA KURMANCÎAXÊVAN: "since" ≠ "for". Kurmancî "ji ... ve" her du jî dikare bide. "since 5 years" ÇEWT e — "for 5 years" rast.',
        examples: [
          EnGrammarExample(en: 'I have lived here for 5 years. (NE: since 5 years)', ku: 'Ez 5 sal in li vir dijîm.'),
          EnGrammarExample(en: 'I have lived here since 2020. (NE: for 2020)', ku: 'Ji 2020an ve ez li vir dijîm.'),
        ],
      ),
    ],
    quizQuestions: _qB1PresentPerfect,
  ),

  EnGrammarTopic(
    id: 'b1_used_to',
    level: 'B1',
    titleEn: 'used to / be used to / get used to',
    titleKu: 'used to — Kirinên Kevn û Adetbûn',
    emoji: '🕰️',
    summaryKu: 'Sê struktur pir dişibin hev lê wate cuda ne: (1) used to + leker = kirina kevn a borî ya ku êdî nayê kirin. (2) be used to + -ing = adetbûna niha. (3) get used to + -ing = adet bûyîn.',
    rules: [
      EnGrammarRule(
        ruleKu: 'used to + leker-a binyad = adetek borî an rewşek borî ku êdî ne rast e. "I used to smoke" = min berê cixare dikişand, niha nakişînim.',
        examples: [
          EnGrammarExample(en: 'I used to smoke, but I quit last year.', ku: 'Min berê cixare dikişand, lê sala borî min cigareyê berda.'),
          EnGrammarExample(en: 'She used to live in Paris when she was young.', ku: 'Gava ew ciwan bû, li Parîsê dijiya.'),
          EnGrammarExample(en: 'There used to be a cinema here.', ku: 'Li vir berê sînemayek hebû.'),
        ],
        noteKu: 'Ev yek wateya borî ye, ne niha — wate dide ku tiştê borî êdî ne rast e.',
      ),
      EnGrammarRule(
        ruleKu: 'Neyînî û pirs: didn\'t use to (NE "didn\'t used to") + leker. Did you use to ...? (dîsa "use" bê -d, ji ber ku "did" hemqas demê paşde dibe).',
        examples: [
          EnGrammarExample(en: 'I didn\'t use to like coffee. (NE: didn\'t used to)', ku: 'Min berê ji qehweyê hez nedikir.'),
          EnGrammarExample(en: 'Did you use to play football?', ku: 'Te berê futbol dilîst?'),
          EnGrammarExample(en: 'He didn\'t use to exercise.', ku: 'Wî berê werziş nedikir.'),
        ],
        noteKu: 'XETA HERÎ BELAV: "didn\'t used to" ÇEWT e! Ji ber ku "did" demê diyar dike, "use" bê -d dimîne: "didn\'t use to".',
      ),
      EnGrammarRule(
        ruleKu: 'be used to + -ing / navdêr = adetbûna niha / ez hîn bûme. "I am used to driving" = ez hîn bûme ajotinê.',
        examples: [
          EnGrammarExample(en: 'I am used to working at night.', ku: 'Ez hîn bûme şevê bixebitim.'),
          EnGrammarExample(en: 'She is used to the cold weather.', ku: 'Ew hîn bûye hewaya sar.'),
          EnGrammarExample(en: 'He isn\'t used to spicy food.', ku: 'Ew ne hîn bûye xwarina tûj.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'get used to + -ing = pêvajoya hîn bûnê: nû dest pê dikî hîn bibî. "I\'m getting used to the new job" = ez hîn dibim.',
        examples: [
          EnGrammarExample(en: 'I\'m getting used to the new schedule.', ku: 'Ez hîn dibim cedwela nû.'),
          EnGrammarExample(en: 'You\'ll get used to the weather here.', ku: 'Tu yê hîn bibî hewaya li vir.'),
        ],
        noteKu: 'FERQA HERÎ GIRÎNG: "used to + leker" (borî, êdî na) vs "be used to + -ing" (adetbûna niha) vs "get used to + -ing" (pêvajoya adetbûnê).',
      ),
    ],
    quizQuestions: _qB1UsedTo,
  ),

  EnGrammarTopic(
    id: 'b1_modals',
    level: 'B1',
    titleEn: 'Modal Verbs (can, must, should, may, might)',
    titleKu: 'Lekerên Modal (niha û pêşeroj)',
    emoji: '🔧',
    summaryKu: 'Lekerên alîkar ên ku wateyên hûrgilî didin: şiyan, mecbûrî, destûr, îhtîmal, şîret. Qaîde: modal + leker-a binyad (bê "to", bê "-s").',
    rules: [
      EnGrammarRule(
        ruleKu: 'can / could — şiyan (ability), îhtîmal (possibility), destûr (permission), daxwaz (request).',
        examples: [
          EnGrammarExample(en: 'I can speak English. (ability)', ku: 'Ez dikarim bi Îngilîzî bipeyivim.'),
          EnGrammarExample(en: 'She can\'t come today. (ability — negative)', ku: 'Ew nikare îro were.'),
          EnGrammarExample(en: 'Could you help me, please? (polite request)', ku: 'Gelo tu dikarî alîkariya min bikî, ji kerema xwe?'),
          EnGrammarExample(en: 'It could rain later. (possibility)', ku: 'Dibe ku paşê baran bibare.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'must / have to — pêwîstî. FERQ: "must" biryara şexsî/hundirîn, "have to" pêwîstiya ji der ve (qanûn, qaîde).',
        examples: [
          EnGrammarExample(en: 'I must call my mother. (personal decision)', ku: 'Divê ez telefonî diya xwe bikim.'),
          EnGrammarExample(en: 'I have to work on Sundays. (external rule)', ku: 'Pêwîst e ez rojên Yekşemê bixebitim.'),
          EnGrammarExample(en: 'You must study harder.', ku: 'Divê tu xurtir bixwîne.'),
        ],
        noteKu: 'FERQA ESASÎ DI NEYÎNÎ DE: "mustn\'t" = qedexe ye (forbidden). "don\'t have to" = ne pêwîst e (not necessary). Ev du wateyên pir cuda ne!',
      ),
      EnGrammarRule(
        ruleKu: 'should / ought to / had better — şîret, pêşniyar. "should" herî berbelav; "ought to" hinekî fermîtir; "had better" bi hişyariyek re.',
        examples: [
          EnGrammarExample(en: 'You should rest.', ku: 'Divê tu bêhna xwe vedî.'),
          EnGrammarExample(en: 'You ought to apologize.', ku: 'Divê tu lêborîn bixwazî.'),
          EnGrammarExample(en: 'You had better leave now. (stronger — with warning)', ku: 'Çêtir e tu niha derkevî.'),
        ],
        noteKu: 'HIŞYARÎ: "had better" + leker-a binyad (ne "to"): "You had better go" (ne "You had better to go"). Her weha di forma borî de bi kar tê, ne di dema niha de.',
      ),
      EnGrammarRule(
        ruleKu: 'may / might — îhtîmal (possibility). "may" hinek piştrastir ji "might", lê her du jî di dema niha/pêşerojê de dibin. Her weha "may" = destûra fermî.',
        examples: [
          EnGrammarExample(en: 'It may rain later.', ku: 'Dibe ku paşê baran bibare.'),
          EnGrammarExample(en: 'She might be at home.', ku: 'Dibe ku ew li malê be.'),
          EnGrammarExample(en: 'May I come in? (formal permission)', ku: 'Ez dikarim bêm hundir?'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'will / would — pêşbînî, biryar di dema axaftinê de, daxwaz. "would" forma hawîn / fermî ya "will".',
        examples: [
          EnGrammarExample(en: 'I think it will rain.', ku: 'Ez texmîn dikim ku baran bibare.'),
          EnGrammarExample(en: 'I\'ll call you later. (decision at moment of speaking)', ku: 'Ez ê paşê telefonî te bikim.'),
          EnGrammarExample(en: 'Would you like some tea? (polite offer)', ku: 'Tu çay dixwazî?'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'QAÎDEYÊN ESASÎ JI BO HEMÛ MODALAN: (1) Li pey modalê leker-a binyad (bê "to"), (2) Bê "-s" di kesê 3em de, (3) Ji bo neyînî: modal + not, (4) Pirs: modal tê pêş. Modal du li hev nayên — "He must can" ÇEWT.',
        examples: [
          EnGrammarExample(en: 'She must study. (NE: She musts / She must to study)', ku: 'Divê ew bixwîne.'),
          EnGrammarExample(en: 'He can\'t come. (negative)', ku: 'Ew nikare were.'),
          EnGrammarExample(en: 'Can you help me? (question)', ku: 'Tu dikarî alîkariya min bikî?'),
          EnGrammarExample(en: 'He must be able to swim. (NE: He must can swim)', ku: 'Divê ew bikare avjeniyê bike.'),
        ],
        noteKu: 'DU MODAL BI HEV NAYÊN: "He will can swim" ÇEWT. Ji bo ku du wateyan bidî, modala duyem bibe forma zêdegav: "He will be able to swim" (ne "will can").',
      ),
    ],
    quizQuestions: _qB1Modals,
  ),

  // ═══ B2 — Upper-intermediate ═════════════════════════════════
  EnGrammarTopic(
    id: 'b2_conditionals',
    level: 'B2',
    titleEn: 'Conditional Sentences (if-clauses)',
    titleKu: 'Hevokên Şertî (if)',
    emoji: '🔀',
    summaryKu: 'Çar cureyên hevokên şertî (0, 1, 2, 3), her yek ji bo wateyek cuda ya rastiyê / îhtîmalê / hîpotezê. Jimara cureyê, dem û wateyê diyar dike.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Type 0 — rastiyên giştî / rewşên her tim rast: If + present simple, present simple. Ev şert her tim derbas dibe.',
        examples: [
          EnGrammarExample(en: 'If you heat water to 100°C, it boils.', ku: 'Ger tu avê heta 100°C germ bikî, ew dikele.'),
          EnGrammarExample(en: 'If I eat peanuts, I get sick.', ku: 'Ger ez fistiq bixwim, ez nexweş dibim.'),
          EnGrammarExample(en: 'If it snows in winter, children are happy.', ku: 'Ger di zivistanê de berf bibare, zarok kêfxweş in.'),
        ],
        noteKu: '"when" jî li şûna "if" dibe: "When you heat water, it boils." Her du jî rast in ji bo rastiyên giştî.',
      ),
      EnGrammarRule(
        ruleKu: 'Type 1 — şertên mimkin / rastî di pêşerojê de: If + present simple, will + leker-a binyad. Ev şert gengaz e ku pêk bê.',
        examples: [
          EnGrammarExample(en: 'If it rains, I will stay home.', ku: 'Ger baran bibare, ez ê li malê bimînim.'),
          EnGrammarExample(en: 'If you study hard, you will pass the exam.', ku: 'Ger tu xurt bixwîne, tu yê di îmtîhanê de derbas bibî.'),
          EnGrammarExample(en: 'If she calls, I will answer.', ku: 'Ger ew telefonê bike, ez ê bersivê bidim.'),
        ],
        noteKu: 'Piştî "if" "will" NAYÊ bikaranîn. "If it will rain" ÇEWT e.',
      ),
      EnGrammarRule(
        ruleKu: 'Type 2 — rewşên hîpotetîk / ne-rast ên niha an pêşerojê: If + past simple, would + leker-a binyad. Rewş ne rast e an ne mimkin e.',
        examples: [
          EnGrammarExample(en: 'If I had money, I would travel the world.', ku: 'Ger pereyên min hebûna, ez ê li dor cîhanê bigeriyama. (lê min tune)'),
          EnGrammarExample(en: 'If I were you, I would apologize.', ku: 'Ger ez li şûna te bama, ez ê lêborîn bixwesta.'),
          EnGrammarExample(en: 'If she spoke French, she could work in Paris.', ku: 'Ger wê Frensî bizaniya, wê dikarîbû li Parîsê bixebite.'),
        ],
        noteKu: 'XETA GIRÎNG: Di Type 2 de, bi "I/he/she/it" re her tim "were" tê bikaranîn (ne "was") di nivîsa fermî de: "If I were rich" (NE "If I was rich"). "If I was" di axaftinê de tê dîtin lê ne standard e.',
      ),
      EnGrammarRule(
        ruleKu: 'Type 3 — rewşên ne-rast ên borî (paşmanî / nirxandina borî): If + past perfect (had + V3), would have + V3. Tiştê ku NEBÛ — lê ger bûya...',
        examples: [
          EnGrammarExample(en: 'If I had studied, I would have passed the exam.', ku: 'Ger min xwendibûya, minê derbas bikira. (lê min nexwend)'),
          EnGrammarExample(en: 'If she had called me, I would have helped her.', ku: 'Ger wê telefonî min bikira, min ê alîkariya wê bikira.'),
          EnGrammarExample(en: 'If we had left earlier, we wouldn\'t have missed the train.', ku: 'Ger em zûtir derketibûna, me nedikarîbû tren ji dest bidin.'),
        ],
        noteKu: 'XETA HERÎ MEZIN: "would have" + V3 (ne V2): "would have gone" rast, "would have went" ÇEWT. Piştî "have" her tim past participle tê.',
      ),
      EnGrammarRule(
        ruleKu: 'Alternatîvên ji bo "will/would": can/could, may/might, should. Van îhtîmal an destûrê zêde dikin.',
        examples: [
          EnGrammarExample(en: 'If you finish early, you can leave. (Type 1)', ku: 'Ger tu zû biqedînî, tu dikarî biçî.'),
          EnGrammarExample(en: 'If I had more time, I could help you. (Type 2)', ku: 'Ger dema min zêdetir hebûya, min dikarîbû alîkariya te bikira.'),
          EnGrammarExample(en: 'If he had worked harder, he might have succeeded. (Type 3)', ku: 'Ger wî xurtir bixebitiyaya, dibe ku wî biserketa.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Navberî: "unless" = if not. Bi tenê bi klozên erênî re tê bikaranîn.',
        examples: [
          EnGrammarExample(en: 'Unless you hurry, you will miss the bus. (= If you don\'t hurry)', ku: 'Ger tu zû negerî, tu yê otobûsê ji dest bidî.'),
          EnGrammarExample(en: 'I wouldn\'t go unless she invited me.', ku: 'Ez nediçûm ger wê ez venexwandibama.'),
        ],
      ),
    ],
    quizQuestions: _qB2Conditionals,
  ),

  EnGrammarTopic(
    id: 'b2_passive',
    level: 'B2',
    titleEn: 'Passive Voice (All Tenses)',
    titleKu: 'Forma Pasîv (Hemû Dem)',
    emoji: '↩️',
    summaryKu: 'Forma pasîv di hemû deman de: her dem xwedî forma xwe ye. Bingehîn = be (di wê demê de) + V3.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Tabela demên pasîvê: Present Simple (is/are + V3) | Past Simple (was/were + V3) | Present Continuous (is/are being + V3) | Present Perfect (has/have been + V3) | Past Perfect (had been + V3) | Future (will be + V3) | Future Perfect (will have been + V3).',
        examples: [
          EnGrammarExample(en: 'Present Simple: English is spoken here.', ku: 'Li vir Îngilîzî tê axaftin.'),
          EnGrammarExample(en: 'Past Simple: The book was written in 1950.', ku: 'Pirtûk di 1950 de hat nivîsandin.'),
          EnGrammarExample(en: 'Present Continuous: The house is being built.', ku: 'Xanî tê çêkirin (niha).'),
          EnGrammarExample(en: 'Present Perfect: The car has been repaired.', ku: 'Ereb hatiye tamîr kirin.'),
          EnGrammarExample(en: 'Past Perfect: The letter had been sent.', ku: 'Name hatibû şandin.'),
          EnGrammarExample(en: 'Future: The bridge will be opened tomorrow.', ku: 'Pir dê sibê were vekirin.'),
        ],
        noteKu: 'Forma pasîv di Future Continuous (will be being + V3) û Past Continuous Perfect de kêm tê bikaranîn — hişk û xerîb xuya dikin. Bi gelemperî aktîv tê hilbijartin.',
      ),
      EnGrammarRule(
        ruleKu: 'Present Continuous Passive: is/are + being + V3. Ji bo tiştê ku niha tê kirin.',
        examples: [
          EnGrammarExample(en: 'The house is being built now.', ku: 'Niha xanî tê çêkirin.'),
          EnGrammarExample(en: 'The road is being repaired this week.', ku: 'Vê hefteyê rê tê tamîr kirin.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Present Perfect Passive: has/have + been + V3. Ji bo tiştê ku qediyaye û bandora wê heye.',
        examples: [
          EnGrammarExample(en: 'The project has been completed.', ku: 'Proje hatiye qedandin.'),
          EnGrammarExample(en: 'Many changes have been made.', ku: 'Gelek guhertin hatine kirin.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Modal Passive: modal + be + V3 (niha) an modal + have been + V3 (borî).',
        examples: [
          EnGrammarExample(en: 'This must be done today.', ku: 'Divê ev îro were kirin.'),
          EnGrammarExample(en: 'The letter should have been sent.', ku: 'Diviyabû name bihata şandin.'),
          EnGrammarExample(en: 'It might have been stolen.', ku: 'Dibe ku hatibe dizîn.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Lekerên bi du biresera (give, send, tell, show, offer) dikarin du formên pasîv hebin: "John was given a book." / "A book was given to John."',
        examples: [
          EnGrammarExample(en: 'Active: They gave me a book. | Passive 1: I was given a book. | Passive 2: A book was given to me.', ku: 'Aktîv: Wan pirtûkek da min. | Pasîv 1: Pirtûkek hat dayîn min. | Pasîv 2: Pirtûkek ji min re hat dayîn.'),
          EnGrammarExample(en: 'She was offered a job.', ku: 'Karek jê re hat pêşkêşkirin.'),
        ],
        noteKu: 'Pasîv bi kirdeyê kesane (I was given) di Îngilîzî de pir belav e, lê di Kurmancî de kêmtir e — ev ji bo Kurmancîaxêvan xerîb xuya dike.',
      ),
      EnGrammarRule(
        ruleKu: 'Lekerên ku nayên pasîv kirin: lekerên bê bireser (intransitive) — arrive, die, happen, live, sleep, go, come, stay, fall. "The accident was happened" ÇEWT.',
        examples: [
          EnGrammarExample(en: 'The accident happened yesterday. (NE: was happened)', ku: 'Qeza duh qewimî.'),
          EnGrammarExample(en: 'He died in 1990. (NE: was died)', ku: 'Ew di 1990 de mir.'),
          EnGrammarExample(en: 'She arrived at 6. (NE: was arrived)', ku: 'Ew di saet 6an de gihîşt.'),
        ],
        noteKu: 'HIŞYARÎ: Lekerên bê bireser (ne transitive) forma pasîvê tune! "Happen", "die", "arrive", "fall" — hemû aktîv in.',
      ),
    ],
    quizQuestions: _qB2Passive,
  ),

  // ═══ C1 — Advanced ═══════════════════════════════════════════
  EnGrammarTopic(
    id: 'b2_relative_clauses',
    level: 'B2',
    titleEn: 'Relative Clauses (who, which, that, whose)',
    titleKu: 'Hevokên Têkildar',
    emoji: '🔗',
    summaryKu: 'Hevokên têkildar bi cînavkên têkildar tên: who (mirov), which (tişt/heywan), that (herdu), whose (xwedîtî), where (cih), when (dem), why (sebeb).',
    rules: [
      EnGrammarRule(
        ruleKu: 'who → ji bo mirov. which → ji bo tişt/heywanan. that → ji bo herdu (nefermîtir), bi gelemperî di hevokên defining de.',
        examples: [
          EnGrammarExample(en: 'The man who lives here is my uncle.', ku: 'Zilamê ku li vir dijî, mamê min e.'),
          EnGrammarExample(en: 'The book which I read was good.', ku: 'Pirtûka ku min xwend, baş bû.'),
          EnGrammarExample(en: 'The man that called was my father.', ku: 'Zilamê ku telefon kir, bavê min bû.'),
        ],
        noteKu: 'HIŞYARÎ: Di hevokên non-defining (bi vîrgul) de "that" NAYÊ bikaranîn — tenê "who" an "which". "My father, that lives in Ankara" ÇEWT e.',
      ),
      EnGrammarRule(
        ruleKu: 'whose → xwedîtî (ji bo mirov, tişt, an heywanan). "The boy whose name is Ali" = lawê navê wî Alî ye.',
        examples: [
          EnGrammarExample(en: 'A boy whose name is Ali came in.', ku: 'Kurikê ku navê wî Alî ye hat hundir.'),
          EnGrammarExample(en: 'The company whose products we buy is American.', ku: 'Şîrketa ku em berhemên wê dikirin Emerîkî ye.'),
        ],
        noteKu: 'XETA: "The boy whose his name is Ali" ÇEWT e! "whose" berê xwe bi xwe xwedîtiyê dide — "his" dubare ye. Rast: "whose name is Ali".',
      ),
      EnGrammarRule(
        ruleKu: 'where (cih), when (dem), why (sebeb): şûna "which" + daçek dikare bigire. "The place where I was born" = "The place in which I was born".',
        examples: [
          EnGrammarExample(en: 'This is the house where I was born.', ku: 'Ev xaniyê ku ez lê ji dayik bûm e.'),
          EnGrammarExample(en: 'I remember the day when we met.', ku: 'Roja ku em hev dîtin bi bîra min tê.'),
          EnGrammarExample(en: 'Tell me the reason why you left.', ku: 'Sedema çûyîna xwe ji min re bibêje.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Defining vs non-defining (qaîdeya krîtîk): Defining — ji bo diyarkirin kê/çi, BÊ VÎRGUL. Non-defining — agahiyek zêde, BI VÎRGUL, û "that" nabe.',
        examples: [
          EnGrammarExample(en: 'The man who called me is my boss. (defining — which man?)', ku: 'Zilamê ku telefonî min kir, patronê min e.'),
          EnGrammarExample(en: 'My brother, who lives in London, is a doctor. (non-defining — extra info)', ku: 'Birayê min, ku li Londonê dijî, bijîşk e.'),
          EnGrammarExample(en: 'The car, which was red, belonged to him.', ku: 'Ereb, ya ku sor bû, ya wî bû.'),
        ],
        noteKu: 'TESTA VÎRGULÊ: Ger agahî tê derxistin hevok hê jî fam dibe → non-defining (bi vîrgul). Ger bê agahî wate tê xera kirin → defining (bê vîrgul).',
      ),
      EnGrammarRule(
        ruleKu: 'Dergirtina cînavka têkildar: dema cînavk bireser e di klozê de, dikare bê derxistin (tenê di defining de). "The book (that) I read" = "The book I read".',
        examples: [
          EnGrammarExample(en: 'The book (that) I read was good.', ku: 'Pirtûka (ku) min xwend baş bû.'),
          EnGrammarExample(en: 'The man (who/whom) I met yesterday.', ku: 'Zilamê (ku) min duh dît.'),
        ],
        noteKu: 'Qaîde: dema cînavk kirde ye (subject), NAYÊ derxistin: "The man who called" (ne "The man called"). Dema bireser e (object), dikare bê derxistin.',
      ),
      EnGrammarRule(
        ruleKu: 'Formên kurt bi participle: Lekerên têkildar dikarin bi participle biguherin. "The book which was written in 1920" → "The book written in 1920".',
        examples: [
          EnGrammarExample(en: 'The book written in 1920 is still popular.', ku: 'Pirtûka ku di 1920an de hatiye nivîsîn, hê jî populer e.'),
          EnGrammarExample(en: 'The man sitting there is my uncle.', ku: 'Zilamê ku li wir rûniştî ye, mamê min e.'),
        ],
      ),
    ],
    quizQuestions: _qC1RelativeClauses,
  ),

  // ═══ C2 — Mastery ════════════════════════════════════════════
  EnGrammarTopic(
    id: 'c1_inversion_negative',
    level: 'C1',
    titleEn: 'Inversion with Negative Adverbials',
    titleKu: 'Inversion bi Zarfên Neyînî',
    emoji: '🎭',
    summaryKu: 'Gava zarfek neyînî an tixûbdar li destpêka hevokê be, kirde û alîkarê leker cih diguherin (mînanî pirsê). Forma fermî / edebî.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Zarfên neyînî yên sereke: Never, Rarely, Seldom, Hardly ever, Scarcely, Little, Nowhere, Under no circumstances, On no account. Piştî van, alîkarê leker (do/does/did/have/has/had/be) tê berî kirdeyê.',
        examples: [
          EnGrammarExample(en: 'Never have I seen such beauty.', ku: 'Min qet rindiyek weha nedîtiye.'),
          EnGrammarExample(en: 'Rarely does he speak in public.', ku: 'Pir kêm caran ew li aliyê giştî dipeyive.'),
          EnGrammarExample(en: 'Seldom do we see such dedication.', ku: 'Kêm caran em dilsoziyek wiha dibînin.'),
          EnGrammarExample(en: 'Under no circumstances should you leave.', ku: 'Di tu şert û mercan de divê tu neçe.'),
        ],
        noteKu: 'XETA: Ger alîkarê leker tune be (Present/Past Simple), "do/does/did" zêde dibe: "Rarely he speaks" ÇEWT, "Rarely does he speak" rast.',
      ),
      EnGrammarRule(
        ruleKu: 'Hardly / Scarcely / No sooner + past perfect ... when/than + past simple: ji bo du bûyerên li pey hev di borî de.',
        examples: [
          EnGrammarExample(en: 'Hardly had we arrived when the rain started.', ku: 'Hema em gihîştibûn ku baran dest pê kir.'),
          EnGrammarExample(en: 'No sooner had the bell rung than they ran out.', ku: 'Hema zengil lêdan ku ew bi bez derketin.'),
          EnGrammarExample(en: 'Scarcely had she sat down when the phone rang.', ku: 'Hema ew rûnişt ku telefon lêxist.'),
        ],
        noteKu: 'FORMEL ZELAL: Hardly + had + V3 ... when + past simple. No sooner + had + V3 ... than + past simple. Têkildarên: "when" bi "hardly/scarcely", "than" bi "no sooner".',
      ),
      EnGrammarRule(
        ruleKu: 'Not only ... but also: herdu beş dikarin inversion hebin. "Not only did he sing, but he also danced."',
        examples: [
          EnGrammarExample(en: 'Not only did he win, but he also broke the record.', ku: 'Ne tenê wî qezenc kir, lê wî rekor jî şikand.'),
          EnGrammarExample(en: 'Not only is she smart, but she is also kind.', ku: 'Ne tenê ew jîr e, ew dilovan jî ye.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Only + hevoka demê/cihê: Only then, Only after, Only when, Only in, Only by. Inversion li klozê sereke tê (ne li klozê "only").',
        examples: [
          EnGrammarExample(en: 'Only then did I understand.', ku: 'Tenê wê demê min fêm kir.'),
          EnGrammarExample(en: 'Only after the meeting did she speak.', ku: 'Tenê piştî civînê ew peyivî.'),
          EnGrammarExample(en: 'Only by working hard can we succeed.', ku: 'Tenê bi xebata dijwar em dikarin bi serbikevin.'),
        ],
      ),
    ],
    quizQuestions: _qC2Inversion,
  ),

  // ═══ B2 — Upper-intermediate (Berfireh) ══════════════════════
  EnGrammarTopic(
    id: 'b2_reported_speech',
    level: 'B2',
    titleEn: 'Reported Speech (Advanced)',
    titleKu: 'Axaftina Neqilkirî (Pêşketî)',
    emoji: '💬',
    summaryKu: 'Neqilkirina gotin, pirs, ferman û daxwazan. Guhertinên dem, cînavk, peyvên demê/cihê pêwîst in. Formên pêşketî: pirs, ferman, û formên awarte.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Guhertinên hûrgilî yên demê: present simple → past simple, present continuous → past continuous, present perfect → past perfect, past simple → past perfect, will → would, can → could, may → might, must → had to, should/would/could → bê guhertin.',
        examples: [
          EnGrammarExample(en: '"I am tired." → She said she was tired.', ku: '"Ez westiyayî me." → Wê got ku ew westiyayî ye.'),
          EnGrammarExample(en: '"I have finished." → He said he had finished.', ku: '"Min qedand." → Wî got ku wî qedandibû.'),
          EnGrammarExample(en: '"I saw him yesterday." → He said he had seen him the day before.', ku: '"Min ew duh dît." → Wî got ku wî ew roja berê dîtibû.'),
          EnGrammarExample(en: '"I will come." → They said they would come.', ku: '"Ez ê werim." → Wan got ku ew ê bên.'),
        ],
        noteKu: 'HIŞYARÎ: "must" di reported de tê "had to": "You must go" → He said I had to go. "should" naguhere: "You should rest" → She said I should rest.',
      ),
      EnGrammarRule(
        ruleKu: 'Pirsên yes/no: if an whether tê bikaranîn; rêzkirin wekî hevoka erênî ye (ne mînanî pirsê), alîkarê leker "do/does/did" TÊ DERXISTIN.',
        examples: [
          EnGrammarExample(en: '"Are you ready?" → She asked if I was ready.', ku: '"Gelo tu amade yî?" → Wê pirsî gelo ez amade me.'),
          EnGrammarExample(en: '"Do you speak French?" → He asked whether I spoke French. (NE: "did I speak")', ku: '"Tu bi Frensî dipeyivî?" → Wî pirsî gelo ez bi Frensî dipeyivim.'),
          EnGrammarExample(en: '"Did she leave?" → They asked if she had left.', ku: '"Gelo ew çû?" → Wan pirsî gelo ew çûbû.'),
        ],
        noteKu: 'XETA HERÎ MEZIN: Di reported questions de, RÊZKIRIN guherîn nake, alîkarê pirsê nayê: "She asked if I was tired" (ne "She asked was I tired" an "She asked if I were tired" an "She asked if did I be tired").',
      ),
      EnGrammarRule(
        ruleKu: 'Pirsên bi peyva pirsê (wh-): peyva pirsê tê parastin + rêzkirina hevoka erênî (ne wek pirs).',
        examples: [
          EnGrammarExample(en: '"Where do you live?" → She asked where I lived. (NE: where did I live)', ku: '"Tu li ku derê dijî?" → Wê pirsî ez li ku derê dijîm.'),
          EnGrammarExample(en: '"What time is it?" → He asked what time it was.', ku: '"Saet çend e?" → Wî pirsî saet çend e.'),
          EnGrammarExample(en: '"Why did you leave?" → They asked why I had left.', ku: '"Çima tu çûyî?" → Wan pirsî çima ez çûme.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Ferman û daxwaz: tell/ask/order + bireser + to + leker. Ji bo neyînî: not to + leker.',
        examples: [
          EnGrammarExample(en: '"Wait here." → She told me to wait there.', ku: '"Li vir bimîne." → Wê ji min re got ku ez li wir bimînim.'),
          EnGrammarExample(en: '"Don\'t leave." → He asked her not to leave.', ku: '"Neçe." → Wî ji wê xwest neçe.'),
          EnGrammarExample(en: '"Please help me." → I asked him to help me.', ku: '"Ji kerema xwe alîkariya min bike." → Min jê xwest ku alîkariya min bike.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Peyvên demê/cihê diguherin: now → then, today → that day, tomorrow → the next day, yesterday → the day before, this → that, here → there, ago → before.',
        examples: [
          EnGrammarExample(en: '"I\'ll call you tomorrow." → He said he would call me the next day.', ku: '"Ez ê sibê telefon bikim." → Wî got ku ew ê roja din telefon bike.'),
          EnGrammarExample(en: '"I was here yesterday." → She said she had been there the day before.', ku: '"Ez duh li vir bûm." → Wê got ku ew roja berê li wir bûbû.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Dema backshift NAYÊ kirin: (1) dema rastiyek giştî tê gotin, (2) dema kitima sereke di dema niha de be, (3) dema rewş hê jî rast be.',
        examples: [
          EnGrammarExample(en: 'She said the sun is bigger than the moon. (general truth)', ku: 'Wê got ku roj ji hîvê mezintir e.'),
          EnGrammarExample(en: 'He says he is tired. (reporting verb in present)', ku: 'Ew dibêje ku ew westiyayî ye.'),
          EnGrammarExample(en: 'She told me she is pregnant. (still pregnant now — some grammarians allow)', ku: 'Wê ji min re got ku ew duhcan e.'),
        ],
      ),
    ],
    quizQuestions: _qB2ReportedSpeech,
  ),

  EnGrammarTopic(
    id: 'b2_gerund_infinitive',
    level: 'B2',
    titleEn: 'Gerunds vs Infinitives',
    titleKu: 'Gerund (-ing) û Infinitive (to + leker)',
    emoji: '🔁',
    summaryKu: 'Piştî hin lekeran -ing (gerund), piştî hinan to + leker (infinitive), piştî hinan jî herdu dibin bi ferqa wateyê. Divê liste ezberbûn.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Lekerên ku bi tenê gerund (-ing) li pey digirin: enjoy, avoid, finish, mind, suggest, consider, deny, admit, keep, practice, postpone, miss, risk, recommend, imagine, involve.',
        examples: [
          EnGrammarExample(en: 'I enjoy reading books.', ku: 'Ez ji xwendina pirtûkan hez dikim.'),
          EnGrammarExample(en: 'She avoided answering the question.', ku: 'Wê bersivdana pirsê neda.'),
          EnGrammarExample(en: 'Would you mind opening the window?', ku: 'Gelo tu dikarî pencereyê vekî?'),
          EnGrammarExample(en: 'I recommend trying this restaurant.', ku: 'Ez pêşniyar dikim vê xwaringehê biceribînî.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Lekerên ku bi tenê infinitive (to + leker) li pey digirin: want, need, decide, hope, promise, offer, agree, refuse, expect, plan, manage, pretend, seem, tend, afford, fail, learn.',
        examples: [
          EnGrammarExample(en: 'I want to learn English.', ku: 'Ez dixwazim Îngilîzî hîn bibim.'),
          EnGrammarExample(en: 'He decided to stay.', ku: 'Wî biryar da ku bimîne.'),
          EnGrammarExample(en: 'She promised to help me.', ku: 'Wê soz da ku alîkariya min bike.'),
          EnGrammarExample(en: 'We can\'t afford to buy a new car.', ku: 'Em nikarin ereba nû bikirin.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Lekerên ku herdu jî digirin — BÊYÎ ferqa wateyê: begin, start, continue, love, like, hate, prefer, can\'t stand. "I love reading / to read" heman wate.',
        examples: [
          EnGrammarExample(en: 'She started crying. / She started to cry.', ku: 'Wê dest bi girîn kir.'),
          EnGrammarExample(en: 'I love swimming. / I love to swim.', ku: 'Ez ji avjeniyê hez dikim.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Lekerên ku herdu jî digirin — BI ferqa WATEYÊ: remember, forget, stop, try, regret, mean, need.',
        examples: [
          EnGrammarExample(en: 'I stopped smoking. (no longer smoke — gave up)', ku: 'Min cixare kişandin raweste kir. (nema dikişînim)'),
          EnGrammarExample(en: 'I stopped to smoke. (stopped in order to smoke)', ku: 'Ez rawestiyam ku cixare bikişînim. (rawestiyam da bikişînim)'),
          EnGrammarExample(en: 'Remember to lock the door. (do not forget — future task)', ku: 'Bîr neke ku derî qûfil bikî.'),
          EnGrammarExample(en: 'I remember locking the door. (recall past action)', ku: 'Tê bîra min ku min derî qûfil kir.'),
          EnGrammarExample(en: 'She tried to open the door. (made an attempt)', ku: 'Wê hewl da ku derî veke.'),
          EnGrammarExample(en: 'She tried opening the door. (experimented as a method)', ku: 'Wê ceriband ku derî veke (wekî rêbazekê).'),
        ],
        noteKu: 'Ferqa krîtîk: stop + -ing = karekî kevn bi dawî anîn. stop + to = rawestandin DA KU tiştekî din bikî. remember/forget + to = ji bo pêşerojê. + -ing = serpêhatiya borî.',
      ),
      EnGrammarRule(
        ruleKu: 'Piştî daçekan (prepositions) her tim gerund (-ing) tê — ne infinitive: "good at singing", "tired of waiting", "interested in learning".',
        examples: [
          EnGrammarExample(en: 'She is good at singing.', ku: 'Ew di stranê de jêhatî ye.'),
          EnGrammarExample(en: 'Thank you for helping me.', ku: 'Spas ji te re ji bo alîkariya te.'),
          EnGrammarExample(en: 'He is tired of waiting.', ku: 'Ew ji benda westiyayî ye.'),
          EnGrammarExample(en: 'I look forward to meeting you.', ku: 'Ez li hêviya dîtina te me.'),
        ],
        noteKu: 'XETA BELAV: "look forward to" — "to" li vir DAÇEK e, ne infinitive! Piştî wê gerund tê: "look forward to seeing you" (NE "to see"). Heman: "be used to doing", "get used to driving".',
      ),
      EnGrammarRule(
        ruleKu: 'Gerund wekî kirdê (subject) an biresera hevokê: "Smoking is bad" / "Her favorite activity is reading".',
        examples: [
          EnGrammarExample(en: 'Smoking is bad for your health.', ku: 'Cixarekişandin ji tenduristiyê re xerab e.'),
          EnGrammarExample(en: 'Swimming is my favorite sport.', ku: 'Avjenî werzişê min ê bijarte ye.'),
          EnGrammarExample(en: 'Learning English takes time.', ku: 'Fêrbûna Îngilîzî demê digire.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Infinitive bê "to" (bare infinitive): Piştî modalan (can, must, should...), piştî "let", "make", "see/hear/feel" (di wateya rasterast de).',
        examples: [
          EnGrammarExample(en: 'Let me help you.', ku: 'Bihêle ez alîkariya te bikim.'),
          EnGrammarExample(en: 'She made me laugh.', ku: 'Wê ez kenandim.'),
          EnGrammarExample(en: 'I saw him leave. (saw the whole action)', ku: 'Min dît ku ew çû.'),
        ],
      ),
    ],
    quizQuestions: _qB2GerundInfinitive,
  ),

  EnGrammarTopic(
    id: 'b2_modals_past',
    level: 'B2',
    titleEn: 'Modals of Past Deduction & Regret',
    titleKu: 'Modalên Borî: Texmîn û Poşmanî',
    emoji: '🎯',
    summaryKu: 'Modal + have + past participle (V3): li ser bûyerên borî texmîn, poşmanî, îmkan an rexne tînin ziman. Forma hevpar: modal + have + V3.',
    rules: [
      EnGrammarRule(
        ruleKu: 'must have + V3 — texmîna piştrast (strong deduction): "Teqez wiha bûye" — li gorî delîlên em dibînin.',
        examples: [
          EnGrammarExample(en: 'The ground is wet. It must have rained.', ku: 'Erd şil e. Teqez baran bariyaye.'),
          EnGrammarExample(en: 'She looks tired. She must have worked late.', ku: 'Ew westiyayî xuya dike. Teqez heta dereng xebitiye.'),
          EnGrammarExample(en: 'She must have left already; the lights are off.', ku: 'Teqez ew berê çûye; elektrîk vekirî nîne.'),
        ],
        noteKu: 'FERQ: "must" ji bo niha = pêwîstî. "must have + V3" ji bo borî = texmîna piştrast (ne pêwîstiya borî).',
      ),
      EnGrammarRule(
        ruleKu: 'may/might/could have + V3 — îhtîmala borî (possibility): dibe bûbe, lê em ne piştrast in.',
        examples: [
          EnGrammarExample(en: 'He might have forgotten the meeting.', ku: 'Dibe ku wî civîn ji bîr kiribe.'),
          EnGrammarExample(en: 'She may have missed the train.', ku: 'Dibe ku wê tren ji dest dayê.'),
          EnGrammarExample(en: 'They could have gone home already.', ku: 'Dibe ku ew berê çûbin malê.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'could have + V3 — bi îmkan hebû lê nebû. Ji bo tiştê ku mimkin bû lê pêk nehat.',
        examples: [
          EnGrammarExample(en: 'You could have told me! (but you didn\'t)', ku: 'Te dikarîbû ji min re bigotaya! (lê nagote)'),
          EnGrammarExample(en: 'She could have won, but she didn\'t try.', ku: 'Wê dikarîbû bi ser bikeve, lê hewl neda.'),
        ],
        noteKu: 'Du wate: (1) "He could have been there" = îhtîmal. (2) "You could have told me" = ne-qewimandina ku diviyabû biqewime.',
      ),
      EnGrammarRule(
        ruleKu: 'should/ought to have + V3 — poşmanî an rexne. Ji bo tiştê ku diviyabû bûbûya lê nebû.',
        examples: [
          EnGrammarExample(en: 'I should have studied harder. (I didn\'t, and I regret it)', ku: 'Diviyabû ez xurtir bixwenda. (min nekir, poşman im)'),
          EnGrammarExample(en: 'You shouldn\'t have said that. (but you did)', ku: 'Diviyabû te ew negotaya. (lê te got)'),
          EnGrammarExample(en: 'They ought to have arrived by now.', ku: 'Diviyabû ew heta niha gihîştibûn.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'can\'t / couldn\'t have + V3 — berevajiya "must have": îmkanek tune ku wiha bûbe.',
        examples: [
          EnGrammarExample(en: 'She can\'t have seen us; she was far away.', ku: 'Ne mimkin e wê em dîtibe; ew dûr bû.'),
          EnGrammarExample(en: 'They couldn\'t have finished so quickly.', ku: 'Ne mimkin e wan ew qas zû qedandibe.'),
        ],
        noteKu: 'SÎSTEM: "must have" = 95% piştrast erê. "might/may/could have" = 30-50% îhtîmal. "can\'t / couldn\'t have" = 95% piştrast na. Van rêzikan pir girîng in ji bo texmînê.',
      ),
      EnGrammarRule(
        ruleKu: 'needn\'t have + V3 vs didn\'t need to + V — FERQ GIRÎNG: needn\'t have = te kir lê ne pêwîst bû; didn\'t need to = ne pêwîst bû, nekir.',
        examples: [
          EnGrammarExample(en: 'You needn\'t have bought bread. (you did, but it wasn\'t needed)', ku: 'Te nan nekirîba. (te kirî, lê ne pêwîst bû)'),
          EnGrammarExample(en: 'I didn\'t need to buy bread. (I didn\'t buy, not needed)', ku: 'Ne pêwîst bû ez nan bikirim. (min nekirî jî)'),
        ],
      ),
    ],
    quizQuestions: _qB2ModalsPast,
  ),

  EnGrammarTopic(
    id: 'b2_future_perfect',
    level: 'B2',
    titleEn: 'Future Perfect Tense',
    titleKu: 'Dema Dahatû ya Têkûz',
    emoji: '🔮',
    summaryKu: 'Ji bo karek ku berî demek diyar di pêşerojê de dê qediyabe: will have + past participle (V3). Bi gelemperî bi "by + dem" re tê.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Avakirin: subject + will have + V3. Ji bo hemû kesan heman: I/you/he/she/we/they will have finished.',
        examples: [
          EnGrammarExample(en: 'By 2030, I will have graduated.', ku: 'Heta 2030an, ez ê ji zanîngehê derketibim.'),
          EnGrammarExample(en: 'She will have finished the book by Monday.', ku: 'Heta roja Duşemê, wê dê pirtûk qedandibe.'),
          EnGrammarExample(en: 'They will have built the bridge by next year.', ku: 'Heta sala bê, ew ê pirê çêkiribin.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Hevokên demî yên sereke: by + dem (heta), by the time (heta ku). NOT: piştî "by the time" DEMA NIHA tê, ne pêşeroj!',
        examples: [
          EnGrammarExample(en: 'By the time you arrive, we will have eaten.', ku: 'Heta ku tu bigihêjî, em ê xwaribin.'),
          EnGrammarExample(en: 'By the time she finishes school, she will have learned three languages.', ku: 'Heta ku ew dibistanê biqedîne, wê dê sê ziman hîn bûbin.'),
        ],
        noteKu: 'XETA: "By the time you will arrive" ÇEWT e! Piştî "by the time" dema niha tê: "By the time you arrive..." (wekî qaîdeya "after/when").',
      ),
      EnGrammarRule(
        ruleKu: 'Pirs û neyînî: Will + kirde + have + V3? / ... + won\'t have + V3.',
        examples: [
          EnGrammarExample(en: 'Will you have finished the report by Friday?', ku: 'Tu yê raporê heta Îniyê qedandibe?'),
          EnGrammarExample(en: 'I won\'t have done it by then.', ku: 'Heta wê demê min ê ew nekiribe.'),
          EnGrammarExample(en: 'How long will you have been there by tomorrow?', ku: 'Heta sibê tu yê çiqas li wir mabî?'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Future Perfect Continuous: will have been + V-ing. Ji bo dirêjahiya karek ku heta demek diyar dê berdewam be.',
        examples: [
          EnGrammarExample(en: 'By June, I will have been living here for 10 years.', ku: 'Heta Hezîranê, ez ê 10 sal bin li vir dijiyame.'),
          EnGrammarExample(en: 'By next week, she will have been working on this for a month.', ku: 'Heta hefteya bê, ew ê mehek be li ser vê yekê xebitiye.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Wateya sereke: nêrînek paşde ji xaleke pêşerojê — em xwe dixin demek pêşerojê û li borîya wê demê dinêrin.',
        examples: [
          EnGrammarExample(en: 'By the end of this year, I will have saved \$5000.', ku: 'Heta dawiya vê salê, ez ê \$5000 berhev kiribim.'),
          EnGrammarExample(en: 'In two months, we will have been married for 20 years.', ku: 'Du mehan din em ê 20 sal be zewicî bin.'),
        ],
      ),
    ],
    quizQuestions: _qB2FuturePerfect,
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
    quizQuestions: _qB2PastPerfectContinuous,
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
    quizQuestions: _qB2MixedConditionals,
  ),

  EnGrammarTopic(
    id: 'b2_wish',
    level: 'B2',
    titleEn: 'I wish / If only',
    titleKu: 'I wish / If only — Xwezî',
    emoji: '💭',
    summaryKu: 'Ji bo nerazîbûn an arezû: "I wish / If only" + demê paşde. Forma demê wateyê diyar dike: niha, pêşeroj, an poşmaniya borî.',
    rules: [
      EnGrammarRule(
        ruleKu: 'I wish + past simple = nerazîbûn/arezû ji niha re (rewş ne rast e). "I wish I had more time" = xwezî dema min zêdetir bûya.',
        examples: [
          EnGrammarExample(en: 'I wish I had more money. (but I don\'t)', ku: 'Xwezî pereyên min zêdetir bûna. (lê tune)'),
          EnGrammarExample(en: 'I wish I spoke French.', ku: 'Xwezî min bi Frensî bizaniya.'),
          EnGrammarExample(en: 'She wishes she lived closer to work.', ku: 'Ew daxwaz dike ku nêzîkî karî bijiya.'),
        ],
        noteKu: 'HIŞYARÎ: Piştî "I wish" bi "I/he/she/it" re "were" tê (ne "was") di nivîsa fermî de: "I wish I were taller".',
      ),
      EnGrammarRule(
        ruleKu: 'I wish + past perfect = poşmaniya ji borî re (tiştê ku bû, xwezî nebûya an berovajî).',
        examples: [
          EnGrammarExample(en: 'I wish I had studied harder. (I didn\'t — regret)', ku: 'Xwezî min xurtir xwendibûya. (nexwendim — poşman im)'),
          EnGrammarExample(en: 'I wish I hadn\'t said that.', ku: 'Xwezî min ew negotibûya.'),
          EnGrammarExample(en: 'She wishes she had gone to the party.', ku: 'Ew poşman e ku neçû partiyê.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'I wish + would + leker = nerazîbûn ji rewşek domdar (bi gelemperî ji ber kesekî din) an arezû ji bo guhertinê.',
        examples: [
          EnGrammarExample(en: 'I wish he would stop talking. (annoyed)', ku: 'Xwezî ew bisekine ji peyivînê.'),
          EnGrammarExample(en: 'I wish it would stop raining.', ku: 'Xwezî baran bisekine.'),
          EnGrammarExample(en: 'I wish you would listen to me!', ku: 'Xwezî tu guhdariya min bikira!'),
        ],
        noteKu: 'HIŞYARÎ: "I wish I would" bi xwe NAYÊ bikaranîn — em nikarin tiştek ji xwe daxwaz bikin. "I wish I could" rast e ji bo şiyana hîpotetîk.',
      ),
      EnGrammarRule(
        ruleKu: 'If only: heman bikaranîna "I wish", lê bi hêztir û gilîtir.',
        examples: [
          EnGrammarExample(en: 'If only I had more time! (stronger than "I wish")', ku: 'Xwezî dema min zêdetir bûya!'),
          EnGrammarExample(en: 'If only she had called me.', ku: 'Xwezî wê telefon bikira.'),
          EnGrammarExample(en: 'If only I could fly!', ku: 'Xwezî min bikaribûya bifire!'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'XWENDINA DEMÊN: wish + past = niha (ne rast). wish + past perfect = borî (poşman). wish + would = daxwaza guhertinê (nerazî).',
        examples: [
          EnGrammarExample(en: 'I wish I was/were younger. (present state)', ku: 'Xwezî ez ciwantir bama.'),
          EnGrammarExample(en: 'I wish I had been younger then. (past state regret)', ku: 'Xwezî ez wê demê ciwantir bama.'),
          EnGrammarExample(en: 'I wish he would call me. (complaint about behavior)', ku: 'Xwezî ew telefonî min bike.'),
        ],
      ),
    ],
    quizQuestions: _qB2Wish,
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
    quizQuestions: _qB2ParticipleClauses,
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
    quizQuestions: _qB2PassiveModals,
  ),

  EnGrammarTopic(
    id: 'b2_subjunctive',
    level: 'B2',
    titleEn: 'Subjunctive Mood',
    titleKu: 'Raweya Subjunctive (Pêşniyar/Daxwaz)',
    emoji: '🙏',
    summaryKu: 'Subjunctive: forma lekerê ku wateyên pêşniyar, daxwaz, rexne, an rewşên hîpotetîk dide. Forma sereke: forma binyadî ya lekerê (base form) — bê -s, bê guhertin.',
    rules: [
      EnGrammarRule(
        ruleKu: 'Subjunctive ya niha (present subjunctive): piştî lekerên "suggest, insist, demand, recommend, require, request, propose" + that + kirde + leker-a binyad. Kesê 3em jî BÊ -s dimîne.',
        examples: [
          EnGrammarExample(en: 'I suggest that he be on time.', ku: 'Ez pêşniyar dikim ku ew li ser wextê be.'),
          EnGrammarExample(en: 'She demanded that he leave immediately.', ku: 'Wê daxwaz kir ku ew yekser biçe.'),
          EnGrammarExample(en: 'I insist that she come with us.', ku: 'Ez li ser israrê me ku ew bi me re bê.'),
          EnGrammarExample(en: 'The committee recommended that the project be approved.', ku: 'Komîteyê pêşniyar kir ku proje were pesend kirin.'),
        ],
        noteKu: 'EN ZEHMET: Di kesê 3em de "he comes" NAYÊ; "he come" tê gotin. Pir xerîb xuya dike lê di Îngilîziya Emerîkî de standard e. Di Îngilîziya Brîtanî de "should" bi alternatîvî tê: "I suggest that he should come".',
      ),
      EnGrammarRule(
        ruleKu: 'Piştî rengdêrên "important, necessary, essential, vital, crucial, imperative" + that + kirde + leker-a binyad.',
        examples: [
          EnGrammarExample(en: 'It is important that he be informed.', ku: 'Girîng e ku ew were agahdar kirin.'),
          EnGrammarExample(en: 'It is necessary that she know the truth.', ku: 'Pêwîst e ku ew rastiyê bizane.'),
          EnGrammarExample(en: 'It is essential that every student attend the meeting.', ku: 'Pêwîst e ku her xwendekar beşdarî civînê bibe.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Forma neyînî ya subjunctive: that + kirde + NOT + leker-a binyad (bê do/does).',
        examples: [
          EnGrammarExample(en: 'I suggest that he not be late. (NE: that he doesn\'t be late)', ku: 'Ez pêşniyar dikim ku ew dereng nemîne.'),
          EnGrammarExample(en: 'It is important that she not forget.', ku: 'Girîng e ku ew ji bîr neke.'),
        ],
        noteKu: 'XETA: "I suggest that he doesn\'t come" di axaftinê de tê dîtin, lê forma fermî ya subjunctive "that he not come" e. "Doesn\'t" do-support e — subjunctive bê do-support dixebite.',
      ),
      EnGrammarRule(
        ruleKu: 'Subjunctive bi "were" — Past subjunctive: piştî "if", "wish", "as if", "as though", "if only" di rewşên hîpotetîk de. Forma "were" ji bo her kesî (I were, he were, she were).',
        examples: [
          EnGrammarExample(en: 'If I were you, I would apologize. (NE: If I was)', ku: 'Ger ez li şûna te bama, ez ê lêborîn bixwesta.'),
          EnGrammarExample(en: 'I wish I were taller.', ku: 'Xwezî ez dirêjtir bûma.'),
          EnGrammarExample(en: 'She acts as if she were the boss.', ku: 'Ew xwe wekî patron dide nîşandan.'),
        ],
        noteKu: 'Di axaftinê de "If I was" pir tê bihîstin, lê di nivîsa fermî û standard de "If I were" rast e. Ev forma subjunctive ya borî ya "be" ye.',
      ),
      EnGrammarRule(
        ruleKu: 'Forma nefermî — bi "should": ji bo ku subjunctive asantir be, "should" dikeve navbera "that" û leker. Ev forma Brîtanî ye.',
        examples: [
          EnGrammarExample(en: 'I suggest that he should come. (British, less formal)', ku: 'Ez pêşniyar dikim ku ew were.'),
          EnGrammarExample(en: 'It\'s important that she should know. (British)', ku: 'Girîng e ku ew bizane.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Îfadeyên sabit ên subjunctive: "Long live the king!", "Come what may", "Be that as it may", "Suffice it to say", "God save the Queen!" — ev nayên guhertin.',
        examples: [
          EnGrammarExample(en: 'Long live the king!', ku: 'Bila padîşah bijî!'),
          EnGrammarExample(en: 'Come what may, I will try.', ku: 'Çi bibe, ez ê hewl bidim.'),
          EnGrammarExample(en: 'Suffice it to say, he resigned.', ku: 'Bes e bê gotin, wî îstifa kir.'),
        ],
      ),
    ],
    quizQuestions: _qB2Subjunctive,
  ),

  EnGrammarTopic(
    id: 'b2_causative',
    level: 'B2',
    titleEn: 'Causative (have/get something done)',
    titleKu: 'Causative — Bi yekî din kirin',
    emoji: '🛠️',
    summaryKu: 'Dema em tiştek bi kesekî/a din dikin, ne bi xwe: have/get + bireser + V3. Formên din: make/have/let + kes + leker (active causative).',
    rules: [
      EnGrammarRule(
        ruleKu: 'Pasîv causative: have + bireser + V3 — kesek din (berber, tamîrkar, hwd.) karê me dike. Em bireserê di forma V3 de bi kar tînin.',
        examples: [
          EnGrammarExample(en: 'I had my car repaired. (someone repaired it for me)', ku: 'Min ereba xwe da tamîrkirin.'),
          EnGrammarExample(en: 'She had her hair cut.', ku: 'Wê porê xwe da jêkirin.'),
          EnGrammarExample(en: 'They are having their house painted.', ku: 'Ew xaniyê xwe didin boyaxkirin.'),
        ],
        noteKu: 'FERQA ESASÎ: "I cut my hair" = min bi xwe jê kir. "I had my hair cut" = min da berber jê bike. Ev du wate pir cuda ne!',
      ),
      EnGrammarRule(
        ruleKu: 'get + bireser + V3: heman wate wekî "have + ... + V3", lê nefermîtir û di axaftina rojane de belavtir.',
        examples: [
          EnGrammarExample(en: 'I got my phone fixed.', ku: 'Min têlefona xwe da tamîrkirin.'),
          EnGrammarExample(en: 'We got the house painted last week.', ku: 'Hefteya borî me xanî da boyaxkirin.'),
          EnGrammarExample(en: 'She got her teeth whitened.', ku: 'Wê diranên xwe da spîkirin.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Aktîv causative: make + kes + leker-a binyad (BÊ "to") = yekî mecbûr kirin. have + kes + leker-a binyad (BÊ "to") = daxwaz kirin (fermî). get + kes + TO + leker = razî kirin.',
        examples: [
          EnGrammarExample(en: 'The teacher made us study. (forced)', ku: 'Mamosteyî em mecbûr kirin ku bixwînin.'),
          EnGrammarExample(en: 'I had him clean the room. (gave instruction)', ku: 'Min ji wî re got ku odeyê paqij bike.'),
          EnGrammarExample(en: 'I got her to help me. (persuaded)', ku: 'Min ew razî kir ku alîkariya min bike.'),
        ],
        noteKu: 'FERQ GIRÎNG: "make" û "have" BÊ "to" ne (make him go, have him go). Lê "get" BI "to" ye (get him to go). Hem "let" jî BÊ "to": "She let him go".',
      ),
      EnGrammarRule(
        ruleKu: 'Forma borî ya ne-dilxwaz (adversative): had + bireser + V3 ji bo serhat/qezayan. "He had his wallet stolen" = cûzdana wî hat dizîn (qeza).',
        examples: [
          EnGrammarExample(en: 'He had his wallet stolen.', ku: 'Cûzdana wî hat dizîn.'),
          EnGrammarExample(en: 'She had her phone taken.', ku: 'Têlefona wê hat girtin.'),
          EnGrammarExample(en: 'They had their car damaged in the accident.', ku: 'Ereba wan di qeza de zirar dît.'),
        ],
      ),
      EnGrammarRule(
        ruleKu: 'Demê causative: dikare di hemû deman de xebitîne: had/has/will have/am having/had had ... + V3.',
        examples: [
          EnGrammarExample(en: 'I have my car washed every week.', ku: 'Her hefte ez ereba xwe didim şûştin.'),
          EnGrammarExample(en: 'She is having her hair cut now.', ku: 'Niha ew porê xwe dide jêkirin.'),
          EnGrammarExample(en: 'I will have my laptop repaired tomorrow.', ku: 'Ez ê sibê laptopa xwe bidim tamîrkirin.'),
        ],
      ),
    ],
    quizQuestions: _qB2Causative,
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
    quizQuestions: _qC1InversionAdvanced,
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
          EnGrammarExample(en: 'It was John who broke the window.', ku: 'Yê ku pencere şikand John bû.'),
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
    quizQuestions: _qC1CleftSentences,
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
    quizQuestions: _qC1EmphasisDo,
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
    quizQuestions: _qC1Fronting,
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
    quizQuestions: _qC1Ellipsis,
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
    quizQuestions: _qC1AdvancedConnectors,
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
    quizQuestions: _qC1PhrasalVerbs3,
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
        ruleKu: 'Cînavka kevn: thou (tu) = kirde, thee (te) = bireser, thy/thine (yê te) = xwedîtî. Lekerên wan: thou art (= you are), thou hast (= you have), thou shalt (= you shall), thou dost (= you do).',
        examples: [
          EnGrammarExample(en: 'Thou shalt not kill. (Biblical)', ku: 'Tu nekuje.'),
          EnGrammarExample(en: 'What sayest thou? (Shakespearean)', ku: 'Tu çi dibêjî?'),
          EnGrammarExample(en: 'I love thee. (poetic)', ku: 'Ez ji te hez dikim.'),
          EnGrammarExample(en: 'Thine eyes are beautiful.', ku: 'Çavên te xweş in.'),
        ],
        noteKu: 'Van formên kevn tenê di edebiyata kevn (Shakespeare, Kitêba Pîroz a Kinga James), stran û helbestan de têne dîtin. Di Îngilîziya nûjen de tune ne — tenê fêmkirin pêwîst e.',
      ),
    ],
    quizQuestions: _qC2ArchaicForms,
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
          EnGrammarExample(en: 'If I were you, I would resign.', ku: 'Ger ez li şûna te bama, min ê îstifa bikira.'),
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
          EnGrammarExample(en: 'May it please the court to consider...', ku: 'Bila ji dadgehê re xweş be ku bifikire...'),
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
    quizQuestions: _qC2FormalSubjunctive,
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
    quizQuestions: _qC2Nominalization,
  ),
];
