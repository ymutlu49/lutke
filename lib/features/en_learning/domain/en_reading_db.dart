// LÛTKE — İngilizce Okuma Pasajları (Kurmancî açıklamalı)
// 30 pasaj (A1-B2).

import 'en_word.dart';

class EnReadingPassage {
  final String id;
  final String level;
  final String titleEn;
  final String titleKu;
  final String passage;
  final String translationKu;
  final List<EnReadingQuestion> questions;
  final String emoji;

  const EnReadingPassage({
    required this.id,
    required this.level,
    required this.titleEn,
    required this.titleKu,
    required this.passage,
    required this.translationKu,
    required this.questions,
    required this.emoji,
  });
}

class EnReadingQuestion {
  final String questionEn;
  final String correctAnswer;
  final List<String> options;
  final String explanationKu;

  const EnReadingQuestion({
    required this.questionEn,
    required this.correctAnswer,
    required this.options,
    required this.explanationKu,
  });
}

const List<EnReadingPassage> kEnReadingPassages = [
  EnReadingPassage(
    id: 'en_read_001',
    level: 'A1',
    titleEn: 'My Family',
    titleKu: 'Malbata min',
    passage: 'This is my family. I have a mother and a father. I also have one brother. His name is Ali. We live in a small house. My mother is a teacher. My father works in an office.',
    translationKu: 'Ev malbata min e. Dayîk û bavekî min heye. Herwiha birayekî min heye. Navê wî Alî ye. Em li xaniyekî biçûk dijîn. Dayika min mamoste ye. Bavê min li nivîsgehekê dixebite.',
    questions: [
      EnReadingQuestion(
        questionEn: 'How many people are in the family?',
        correctAnswer: '4',
        options: ['4', '3', '5', '2'],
        explanationKu: 'Dayîk, bav, xwendevan û Alî = 4 kes.',
      ),
      EnReadingQuestion(
        questionEn: 'What does the mother do?',
        correctAnswer: 'She is a teacher.',
        options: ['She is a teacher.', 'She works in office.', 'She is a doctor.', 'She is a student.'],
        explanationKu: '"My mother is a teacher" = Dayika min mamoste ye.',
      ),
      EnReadingQuestion(
        questionEn: 'Where do they live?',
        correctAnswer: 'In a small house.',
        options: ['In a small house.', 'In a big house.', 'In a flat.', 'In a village.'],
        explanationKu: '"Small house" = xaniyekî biçûk.',
      ),
    ],
    emoji: '👨‍👩‍👦',
  ),
  EnReadingPassage(
    id: 'en_read_002',
    level: 'A1',
    titleEn: 'My Morning',
    titleKu: 'Sibeha min',
    passage: 'I wake up at seven every day. I wash my face and brush my teeth. Then I drink tea with bread and cheese. I like black tea very much. After breakfast, I walk to school. School starts at eight.',
    translationKu: 'Ez her roj di seet heftan de şiyar dibim. Ez rûyê xwe dişom û diranên xwe firçe dikim. Paşê ez çayê bi nan û penîr vedixwim. Ez ji çaya reş gelek hez dikim. Piştî taştê, ez peya diçim dibistanê. Dibistan di seet heştan de dest pê dike.',
    questions: [
      EnReadingQuestion(
        questionEn: 'What time does he wake up?',
        correctAnswer: 'At seven.',
        options: ['At seven.', 'At eight.', 'At six.', 'At nine.'],
        explanationKu: '"I wake up at seven" = ez di seet heftan de şiyar dibim.',
      ),
      EnReadingQuestion(
        questionEn: 'What does he drink?',
        correctAnswer: 'Black tea.',
        options: ['Black tea.', 'Coffee.', 'Milk.', 'Water.'],
        explanationKu: '"I like black tea" = ez ji çaya reş hez dikim.',
      ),
      EnReadingQuestion(
        questionEn: 'How does he go to school?',
        correctAnswer: 'He walks.',
        options: ['He walks.', 'By bus.', 'By car.', 'By bike.'],
        explanationKu: '"I walk to school" = ez peya diçim dibistanê.',
      ),
    ],
    emoji: '🌅',
  ),
  EnReadingPassage(
    id: 'en_read_003',
    level: 'A1',
    titleEn: 'My Village',
    titleKu: 'Gundê min',
    passage: 'My village is in the mountains. It is very beautiful. There are green trees and a small river. In summer, the weather is nice. My grandfather lives there. He has sheep and goats. I visit him every month.',
    translationKu: 'Gundê min li çiyayan e. Ew pir xweşik e. Dar û darên kesk û çemekî biçûk hene. Di havînê de, hewa xweş e. Kalikê min li wir dijî. Mih û bizinên wî hene. Ez her meh serdana wî dikim.',
    questions: [
      EnReadingQuestion(
        questionEn: 'Where is the village?',
        correctAnswer: 'In the mountains.',
        options: ['In the mountains.', 'By the sea.', 'In the city.', 'In a desert.'],
        explanationKu: '"My village is in the mountains" = gundê min li çiyayan e.',
      ),
      EnReadingQuestion(
        questionEn: 'What animals does the grandfather have?',
        correctAnswer: 'Sheep and goats.',
        options: ['Sheep and goats.', 'Cows and horses.', 'Dogs and cats.', 'Chickens.'],
        explanationKu: '"He has sheep and goats" = mih û bizinên wî hene.',
      ),
      EnReadingQuestion(
        questionEn: 'How often does he visit?',
        correctAnswer: 'Every month.',
        options: ['Every month.', 'Every week.', 'Every year.', 'Every day.'],
        explanationKu: '"Every month" = her meh.',
      ),
    ],
    emoji: '🏔️',
  ),
  EnReadingPassage(
    id: 'en_read_004',
    level: 'A1',
    titleEn: 'My Favorite Food',
    titleKu: 'Xwarina min a bijarte',
    passage: 'My favorite food is dolma. It has rice, meat and vegetables. My mother cooks it on Fridays. We eat it with yogurt. I also like kebab. My father makes kebab in the garden in summer.',
    translationKu: 'Xwarina min a bijarte dolme ye. Tê de birinc, goşt û sebze hene. Dayika min wê roja înê çêdike. Em wê bi mastî dixwin. Ez ji kebabê jî hez dikim. Bavê min di havînê de li baxçe kebab çêdike.',
    questions: [
      EnReadingQuestion(
        questionEn: 'What is in dolma?',
        correctAnswer: 'Rice, meat and vegetables.',
        options: ['Rice, meat and vegetables.', 'Only rice.', 'Bread and cheese.', 'Fish and potato.'],
        explanationKu: '"Rice, meat and vegetables" = birinc, goşt û sebze.',
      ),
      EnReadingQuestion(
        questionEn: 'When does the mother cook dolma?',
        correctAnswer: 'On Fridays.',
        options: ['On Fridays.', 'On Mondays.', 'On Sundays.', 'Every day.'],
        explanationKu: '"On Fridays" = roja înê.',
      ),
      EnReadingQuestion(
        questionEn: 'Where does father make kebab?',
        correctAnswer: 'In the garden.',
        options: ['In the garden.', 'In the kitchen.', 'In the office.', 'At school.'],
        explanationKu: '"In the garden" = li baxçe.',
      ),
    ],
    emoji: '🍲',
  ),
  EnReadingPassage(
    id: 'en_read_005',
    level: 'A1',
    titleEn: 'My School Bag',
    titleKu: 'Çenteyê min ê dibistanê',
    passage: 'My school bag is blue. It has many things. There are five books and three notebooks. I have a red pen and a yellow pencil. My lunch box is inside. It has a sandwich and an apple.',
    translationKu: 'Çenteyê min ê dibistanê şîn e. Tiştên gelek tê de hene. Pênc pirtûk û sê defter hene. Pênûseke sor û qelemeke zer a min heye. Qutiya nîvroyê ya min tê de ye. Sandwîçek û sêvek tê de hene.',
    questions: [
      EnReadingQuestion(
        questionEn: 'What color is the bag?',
        correctAnswer: 'Blue.',
        options: ['Blue.', 'Red.', 'Yellow.', 'Green.'],
        explanationKu: '"My school bag is blue" = çenteyê min şîn e.',
      ),
      EnReadingQuestion(
        questionEn: 'How many books are there?',
        correctAnswer: 'Five.',
        options: ['Five.', 'Three.', 'Four.', 'Two.'],
        explanationKu: '"Five books" = pênc pirtûk.',
      ),
      EnReadingQuestion(
        questionEn: 'What is in the lunch box?',
        correctAnswer: 'A sandwich and an apple.',
        options: ['A sandwich and an apple.', 'Rice and meat.', 'Bread and cheese.', 'Tea and cake.'],
        explanationKu: '"A sandwich and an apple" = sandwîçek û sêvek.',
      ),
    ],
    emoji: '🎒',
  ),
  EnReadingPassage(
    id: 'en_read_006',
    level: 'A1',
    titleEn: 'My Cat',
    titleKu: 'Pisîka min',
    passage: 'I have a cat. Her name is Mîra. She is white and small. She sleeps on my bed. She likes milk and fish. Every morning she plays in the garden. My sister loves her too.',
    translationKu: 'Pisîkeke min heye. Navê wê Mîra ye. Ew spî û biçûk e. Ew li ser nivîna min radizê. Ew ji şîr û masî hez dike. Her sibeh ew li baxçe dilîze. Xwişka min jî jê hez dike.',
    questions: [
      EnReadingQuestion(
        questionEn: 'What is the cat\'s name?',
        correctAnswer: 'Mîra.',
        options: ['Mîra.', 'Ali.', 'Rozerîn.', 'Berfîn.'],
        explanationKu: '"Her name is Mîra" = navê wê Mîra ye.',
      ),
      EnReadingQuestion(
        questionEn: 'What does she like to eat?',
        correctAnswer: 'Milk and fish.',
        options: ['Milk and fish.', 'Bread and cheese.', 'Meat and rice.', 'Fruits.'],
        explanationKu: '"Milk and fish" = şîr û masî.',
      ),
      EnReadingQuestion(
        questionEn: 'Where does she sleep?',
        correctAnswer: 'On the bed.',
        options: ['On the bed.', 'In the garden.', 'Under the table.', 'On the chair.'],
        explanationKu: '"On my bed" = li ser nivîna min.',
      ),
    ],
    emoji: '🐱',
  ),
  EnReadingPassage(
    id: 'en_read_007',
    level: 'A1',
    titleEn: 'At the Market',
    titleKu: 'Li bazarê',
    passage: 'On Saturday, I go to the market with my mother. We buy vegetables and fruits. Tomatoes are red and cheap. My mother buys grapes for me. I carry a big bag. The market is very busy.',
    translationKu: 'Roja şemiyê, ez bi dayika xwe re diçim bazarê. Em sebze û fêkî dikirin. Firingî sor û erzan in. Dayika min ji min re tirî dikire. Ez çenteyekî mezin hildigirim. Bazar gelek qelebalix e.',
    questions: [
      EnReadingQuestion(
        questionEn: 'When do they go to the market?',
        correctAnswer: 'On Saturday.',
        options: ['On Saturday.', 'On Sunday.', 'On Monday.', 'On Friday.'],
        explanationKu: '"On Saturday" = roja şemiyê.',
      ),
      EnReadingQuestion(
        questionEn: 'What does mother buy for him?',
        correctAnswer: 'Grapes.',
        options: ['Grapes.', 'Apples.', 'Bread.', 'Fish.'],
        explanationKu: '"She buys grapes" = tirî dikire.',
      ),
      EnReadingQuestion(
        questionEn: 'How is the market?',
        correctAnswer: 'Busy.',
        options: ['Busy.', 'Empty.', 'Small.', 'Closed.'],
        explanationKu: '"Very busy" = gelek qelebalix.',
      ),
    ],
    emoji: '🛒',
  ),
  EnReadingPassage(
    id: 'en_read_008',
    level: 'A1',
    titleEn: 'My Bedroom',
    titleKu: 'Odeya min a raketinê',
    passage: 'My bedroom is not big. There is a bed and a small desk. The walls are yellow. I have many books on the shelf. My window looks at the garden. I can see birds every morning.',
    translationKu: 'Odeya min a raketinê ne mezin e. Nivînek û masekî biçûk hene. Dîwar zer in. Li ser refê gelek pirtûkên min hene. Pencereya min li baxçe dinêre. Ez her sibeh teyran dibînim.',
    questions: [
      EnReadingQuestion(
        questionEn: 'What color are the walls?',
        correctAnswer: 'Yellow.',
        options: ['Yellow.', 'Blue.', 'White.', 'Green.'],
        explanationKu: '"The walls are yellow" = dîwar zer in.',
      ),
      EnReadingQuestion(
        questionEn: 'What is on the shelf?',
        correctAnswer: 'Books.',
        options: ['Books.', 'Toys.', 'Clothes.', 'Plates.'],
        explanationKu: '"Many books on the shelf" = li ser refê gelek pirtûk.',
      ),
      EnReadingQuestion(
        questionEn: 'What does he see from the window?',
        correctAnswer: 'Birds.',
        options: ['Birds.', 'Cars.', 'People.', 'Trees.'],
        explanationKu: '"I can see birds" = ez teyran dibînim.',
      ),
    ],
    emoji: '🛏️',
  ),
  EnReadingPassage(
    id: 'en_read_009',
    level: 'A1',
    titleEn: 'My Weekend',
    titleKu: 'Dawiya hefteya min',
    passage: 'On Sunday I do not go to school. I stay at home. I help my mother in the kitchen. We make bread together. In the afternoon, I play football with my friends. In the evening, I watch TV.',
    translationKu: 'Roja yekşemê ez naçim dibistanê. Ez li malê dimînim. Ez li metbexê alîkariya dayika xwe dikim. Em bi hev re nan çêdikin. Piştî nîvro, ez bi hevalên xwe re futbolê dilîzim. Êvarê, ez televîzyonê temaşe dikim.',
    questions: [
      EnReadingQuestion(
        questionEn: 'What does he do on Sunday morning?',
        correctAnswer: 'He helps his mother.',
        options: ['He helps his mother.', 'He goes to school.', 'He plays football.', 'He sleeps all day.'],
        explanationKu: '"I help my mother" = alîkariya dayika xwe dikim.',
      ),
      EnReadingQuestion(
        questionEn: 'What do they make?',
        correctAnswer: 'Bread.',
        options: ['Bread.', 'Cake.', 'Soup.', 'Rice.'],
        explanationKu: '"We make bread" = em nan çêdikin.',
      ),
      EnReadingQuestion(
        questionEn: 'What does he do in the evening?',
        correctAnswer: 'Watches TV.',
        options: ['Watches TV.', 'Reads book.', 'Plays football.', 'Sleeps early.'],
        explanationKu: '"I watch TV" = televîzyonê temaşe dikim.',
      ),
    ],
    emoji: '📺',
  ),
  EnReadingPassage(
    id: 'en_read_010',
    level: 'A1',
    titleEn: 'The Weather',
    titleKu: 'Hewa',
    passage: 'Today the weather is cold. It is raining outside. I wear my jacket and boots. I take an umbrella. In winter, sometimes it snows. Children are very happy. They play in the snow.',
    translationKu: 'Îro hewa sar e. Li derve baran dibare. Ez qapûtê xwe û solên xwe li xwe dikim. Ez çeterekê hildigirim. Di zivistanê de, carinan berf dibare. Zarok pir kêfxweş in. Ew li berfê dilîzin.',
    questions: [
      EnReadingQuestion(
        questionEn: 'How is the weather today?',
        correctAnswer: 'Cold and rainy.',
        options: ['Cold and rainy.', 'Hot and sunny.', 'Warm and windy.', 'Snowy.'],
        explanationKu: '"Cold" û "raining" = sar û baranî.',
      ),
      EnReadingQuestion(
        questionEn: 'What does he take?',
        correctAnswer: 'An umbrella.',
        options: ['An umbrella.', 'A book.', 'A bag.', 'A ball.'],
        explanationKu: '"An umbrella" = çeter.',
      ),
      EnReadingQuestion(
        questionEn: 'What do children do in snow?',
        correctAnswer: 'They play.',
        options: ['They play.', 'They cry.', 'They sleep.', 'They read.'],
        explanationKu: '"They play in the snow" = li berfê dilîzin.',
      ),
    ],
    emoji: '☔',
  ),
  EnReadingPassage(
    id: 'en_read_011',
    level: 'A2',
    titleEn: 'My Trip to Amed',
    titleKu: 'Gera min a Amedê',
    passage: 'Last summer, I visited Amed with my family. We stayed there for five days. The old city has black stone walls. We walked on them and took many photos. I have never seen such beautiful walls before. We also ate traditional food in small restaurants. I bought a silk scarf for my grandmother. She was very happy when I gave it to her.',
    translationKu: 'Havîna par, min bi malbata xwe re serdana Amedê kir. Em pênc rojan li wir man. Bajarê kevn xwedî dîwarên kevirên reş e. Em li ser wan geriyan û gelek wêne girtin. Min berê qet dîwarên wilo xweşik nedîtibûn. Em li xwaringehên biçûk xwarina kevneşopî jî xwar. Min ji bo dapîra xwe şaleke hevrîşim kirî. Gava min da wê, ew pir kêfxweş bû.',
    questions: [
      EnReadingQuestion(
        questionEn: 'How long did they stay?',
        correctAnswer: 'Five days.',
        options: ['Five days.', 'Three days.', 'One week.', 'Two weeks.'],
        explanationKu: '"Five days" = pênc roj.',
      ),
      EnReadingQuestion(
        questionEn: 'What color are the walls?',
        correctAnswer: 'Black.',
        options: ['Black.', 'White.', 'Red.', 'Grey.'],
        explanationKu: '"Black stone walls" = dîwarên kevirên reş.',
      ),
      EnReadingQuestion(
        questionEn: 'What did he buy for grandmother?',
        correctAnswer: 'A silk scarf.',
        options: ['A silk scarf.', 'A book.', 'A ring.', 'A bag.'],
        explanationKu: '"A silk scarf" = şaleke hevrîşim.',
      ),
    ],
    emoji: '🏛️',
  ),
  EnReadingPassage(
    id: 'en_read_012',
    level: 'A2',
    titleEn: 'My First Day at School',
    titleKu: 'Roja min a yekem li dibistanê',
    passage: 'I will never forget my first day at school. I was six years old. My mother took me to the door. I cried a little because I did not want to leave her. The teacher was very kind. She gave me a small notebook. I met a boy named Baran. He became my best friend. We have been friends for ten years now.',
    translationKu: 'Ez ê roja xwe ya yekem a dibistanê çu carî ji bîr nekim. Ez şeş salî bûm. Dayika min ez birim ber derî. Ji ber ku min nedixwest wê bihêlim, ez hinekî giriyam. Mamoste pir dilovan bû. Wê defterekî biçûk da min. Min lawekî bi navê Baran nas kir. Ew bû hevalê min ê herî baş. Niha deh sal in em heval in.',
    questions: [
      EnReadingQuestion(
        questionEn: 'How old was he?',
        correctAnswer: 'Six years old.',
        options: ['Six years old.', 'Five years old.', 'Seven years old.', 'Eight years old.'],
        explanationKu: '"Six years old" = şeş salî.',
      ),
      EnReadingQuestion(
        questionEn: 'Why did he cry?',
        correctAnswer: 'He did not want to leave his mother.',
        options: ['He did not want to leave his mother.', 'He was hungry.', 'He was lost.', 'He fell down.'],
        explanationKu: '"I did not want to leave her" = nedixwest wê bihêlim.',
      ),
      EnReadingQuestion(
        questionEn: 'Who is Baran?',
        correctAnswer: 'His best friend.',
        options: ['His best friend.', 'His teacher.', 'His brother.', 'His cousin.'],
        explanationKu: '"My best friend" = hevalê min ê herî baş.',
      ),
    ],
    emoji: '🏫',
  ),
  EnReadingPassage(
    id: 'en_read_013',
    level: 'A2',
    titleEn: 'Newroz Celebration',
    titleKu: 'Pîrozbahiya Newrozê',
    passage: 'Newroz is the most important festival for Kurds. It is on the 21st of March. Last year, I went to the celebration with my friends. People lit a big fire in the field. We all jumped over the small flames. Everyone wore colorful clothes. Women danced in a long line. I have attended Newroz many times, but last year was the best. Music played until midnight.',
    translationKu: 'Newroz ji bo kurdan cejna herî girîng e. Ew di 21ê adarê de ye. Sala par, ez bi hevalên xwe re çûm pîrozbahiyê. Xelkê li zeviyê agirekî mezin dadan. Em hemî li ser pêtên biçûk bazdan. Her kesî cilên rengîn li xwe kiribûn. Jinan di rêzeke dirêj de govend girtibû. Min gelek caran Newroz temaşe kiriye, lê ya sala par a herî baş bû. Muzîk heta nîvê şevê lê hate xistin.',
    questions: [
      EnReadingQuestion(
        questionEn: 'When is Newroz?',
        correctAnswer: '21st of March.',
        options: ['21st of March.', '1st of January.', '15th of May.', '10th of April.'],
        explanationKu: '"21st of March" = 21ê adarê.',
      ),
      EnReadingQuestion(
        questionEn: 'What did people do over the flames?',
        correctAnswer: 'They jumped.',
        options: ['They jumped.', 'They cooked.', 'They sat.', 'They slept.'],
        explanationKu: '"We all jumped" = em hemî bazdan.',
      ),
      EnReadingQuestion(
        questionEn: 'Until when did music play?',
        correctAnswer: 'Midnight.',
        options: ['Midnight.', 'Morning.', 'Sunset.', 'Noon.'],
        explanationKu: '"Until midnight" = heta nîvê şevê.',
      ),
    ],
    emoji: '🔥',
  ),
  EnReadingPassage(
    id: 'en_read_014',
    level: 'A2',
    titleEn: 'The Lost Sheep',
    titleKu: 'Miha winda',
    passage: 'One morning, a shepherd counted his sheep. One was missing. He looked everywhere but could not find it. He walked up the mountain for hours. Finally, he heard a small sound behind a rock. The little sheep was there, scared and tired. The shepherd carried it home. His wife made warm milk for the animal. The sheep has been healthy since that day.',
    translationKu: 'Sibehekê, şivanekî mihên xwe jimartin. Yek kêm bû. Li her derê geriya lê nedît. Çend saetan berjêr çiya çû. Di dawiyê de, wî li paş kevirekî dengekî biçûk bihîst. Berxa biçûk li wir bû, tirsiyayî û westiyayî. Şivan ew anî malê. Jina wî ji bo heywanê şîrê germ çêkir. Ji wê rojê ve mih saxlem e.',
    questions: [
      EnReadingQuestion(
        questionEn: 'What did the shepherd do?',
        correctAnswer: 'Counted his sheep.',
        options: ['Counted his sheep.', 'Sold his sheep.', 'Bought new sheep.', 'Fed his sheep.'],
        explanationKu: '"Counted his sheep" = mihên xwe jimartin.',
      ),
      EnReadingQuestion(
        questionEn: 'Where did he find the sheep?',
        correctAnswer: 'Behind a rock.',
        options: ['Behind a rock.', 'In the river.', 'In the village.', 'Under a tree.'],
        explanationKu: '"Behind a rock" = li paş kevirekî.',
      ),
      EnReadingQuestion(
        questionEn: 'What did the wife make?',
        correctAnswer: 'Warm milk.',
        options: ['Warm milk.', 'Bread.', 'Soup.', 'Tea.'],
        explanationKu: '"Warm milk" = şîrê germ.',
      ),
    ],
    emoji: '🐑',
  ),
  EnReadingPassage(
    id: 'en_read_015',
    level: 'A2',
    titleEn: 'A Rainy Day',
    titleKu: 'Rojeke baranî',
    passage: 'Yesterday it rained all day. I could not go out, so I stayed home. I read a book about old Kurdish stories. My sister painted a picture of mountains. My mother baked a warm cake. The smell filled the whole house. We sat together and drank tea. I have not spent such a nice day with my family for a long time. The rain finally stopped in the evening.',
    translationKu: 'Duh tevahiya rojê baran barî. Ez nekarim derkevim, lewma ez li malê mam. Min pirtûkek li ser çîrokên kurdî yên kevn xwend. Xwişka min wêneyê çiyayan nîgar kir. Dayika min kulîçeyeke germ pijand. Bêhn tevahiya xanî dagirt. Em bi hev re rûniştin û çay vexwar. Demeke dirêj bû min wilo rojeke xweş bi malbata xwe re derbas nekiribû. Baran di dawiyê de êvarê sekinî.',
    questions: [
      EnReadingQuestion(
        questionEn: 'What did he read about?',
        correctAnswer: 'Old Kurdish stories.',
        options: ['Old Kurdish stories.', 'Modern science.', 'Travel.', 'Food recipes.'],
        explanationKu: '"Old Kurdish stories" = çîrokên kurdî yên kevn.',
      ),
      EnReadingQuestion(
        questionEn: 'What did his sister do?',
        correctAnswer: 'Painted a picture.',
        options: ['Painted a picture.', 'Read a book.', 'Made tea.', 'Watched TV.'],
        explanationKu: '"Painted a picture" = wêne nîgar kir.',
      ),
      EnReadingQuestion(
        questionEn: 'When did the rain stop?',
        correctAnswer: 'In the evening.',
        options: ['In the evening.', 'At noon.', 'In the morning.', 'At night.'],
        explanationKu: '"In the evening" = êvarê.',
      ),
    ],
    emoji: '🌧️',
  ),
  EnReadingPassage(
    id: 'en_read_016',
    level: 'A2',
    titleEn: 'A Journey by Train',
    titleKu: 'Gereke bi trênê',
    passage: 'Two years ago, I traveled by train for the first time. The journey was long but exciting. I sat next to a window and watched the villages pass by. I saw green fields and small rivers. An old man sat next to me. He told me stories about his youth. He had worked as a teacher for forty years. I have never forgotten his kind face. We shared bread and cheese during the trip.',
    translationKu: 'Du sal berê, min yekem car bi trênê gerek kir. Gerek dirêj lê dilkêş bû. Ez li ba pencereyekê rûniştim û gundan temaşe kirin ku derbas dibûn. Min zeviyên kesk û çemên biçûk dîtin. Pîrekî li cem min rûnişt. Ew li ser ciwaniya xwe çîrok ji min re gotin. Ew çil salan wek mamoste xebitîbû. Min rûyê wî yê dilovan tu carî ji bîr nekir. Di rêwîtiyê de me nan û penîr parve kir.',
    questions: [
      EnReadingQuestion(
        questionEn: 'Where did the narrator sit?',
        correctAnswer: 'Next to a window.',
        options: ['Next to a window.', 'Near the door.', 'In the middle.', 'By the driver.'],
        explanationKu: '"Next to a window" = ba pencereyekê.',
      ),
      EnReadingQuestion(
        questionEn: 'What was the old man\'s job?',
        correctAnswer: 'Teacher.',
        options: ['Teacher.', 'Doctor.', 'Farmer.', 'Driver.'],
        explanationKu: '"Worked as a teacher" = wek mamoste xebitîbû.',
      ),
      EnReadingQuestion(
        questionEn: 'What did they share?',
        correctAnswer: 'Bread and cheese.',
        options: ['Bread and cheese.', 'Tea and cake.', 'Fruits.', 'Water.'],
        explanationKu: '"Bread and cheese" = nan û penîr.',
      ),
    ],
    emoji: '🚆',
  ),
  EnReadingPassage(
    id: 'en_read_017',
    level: 'A2',
    titleEn: 'My Grandmother\'s Kitchen',
    titleKu: 'Metbexa dapîra min',
    passage: 'My grandmother\'s kitchen is always warm. She has cooked traditional food there for fifty years. Last week I visited her. She was making savar with yogurt. The smell was wonderful. She taught me how to shape the bulgur. I burned my hand a little, but she laughed and helped me. She has a small garden behind the kitchen. All her vegetables come from there. I love spending time with her.',
    translationKu: 'Metbexa dapîra min her tim germ e. Wê li wir pêncî salan xwarina kevneşopî çêkiriye. Hefteya borî min serdana wê kir. Wê savar bi mastî çêdikir. Bêhn pir xweş bû. Wê fêrî min kir ka çawa savarê rû bidim. Destê min hinekî şewitî, lê ew keniya û alîkariya min kir. Li paş metbexê baxçeyekî biçûk hebû. Hemî sebzeyên wê ji wir tên. Ez ji demên bi wê re hez dikim.',
    questions: [
      EnReadingQuestion(
        questionEn: 'How long has she cooked there?',
        correctAnswer: 'Fifty years.',
        options: ['Fifty years.', 'Twenty years.', 'Ten years.', 'One hundred years.'],
        explanationKu: '"Fifty years" = pêncî sal.',
      ),
      EnReadingQuestion(
        questionEn: 'What was she making?',
        correctAnswer: 'Savar with yogurt.',
        options: ['Savar with yogurt.', 'Bread.', 'Rice.', 'Dolma.'],
        explanationKu: '"Savar with yogurt" = savar bi mastî.',
      ),
      EnReadingQuestion(
        questionEn: 'Where do the vegetables come from?',
        correctAnswer: 'Her small garden.',
        options: ['Her small garden.', 'The market.', 'The neighbor.', 'The city.'],
        explanationKu: '"A small garden behind" = baxçeyekî biçûk li paş.',
      ),
    ],
    emoji: '👵',
  ),
  EnReadingPassage(
    id: 'en_read_018',
    level: 'A2',
    titleEn: 'The New Phone',
    titleKu: 'Telefona nû',
    passage: 'Last month I bought a new phone. I had saved money for six months. I wanted a phone with a good camera. In the shop, the seller showed me three models. I chose the blue one because it was the lightest. Since I got it, I have taken many pictures of my city. I also talk to my cousin in Germany every week. Technology has made our lives easier.',
    translationKu: 'Meha borî min telefoneke nû kirî. Ez şeş mehan drav tevhev kiribû. Min telefonek bi kameraya baş dixwest. Di firoşgehê de, firoşkar sê modelan nîşanî min kirin. Min ya şîn hilbijart ji ber ku ew ya herî sivik bû. Ji dema ku min ew standiye, min gelek wêneyên bajarê xwe girtine. Herwiha her hefte ez bi pismamê xwe yê li Almanyayê re diaxivim. Teknolojiyê jiyana me hêsantir kiriye.',
    questions: [
      EnReadingQuestion(
        questionEn: 'How long did he save money?',
        correctAnswer: 'Six months.',
        options: ['Six months.', 'One year.', 'Three months.', 'One month.'],
        explanationKu: '"Six months" = şeş meh.',
      ),
      EnReadingQuestion(
        questionEn: 'Why did he choose the blue one?',
        correctAnswer: 'It was the lightest.',
        options: ['It was the lightest.', 'It was the cheapest.', 'It was the biggest.', 'It was the newest.'],
        explanationKu: '"The lightest" = ya herî sivik.',
      ),
      EnReadingQuestion(
        questionEn: 'Where does his cousin live?',
        correctAnswer: 'Germany.',
        options: ['Germany.', 'France.', 'Turkey.', 'Sweden.'],
        explanationKu: '"Cousin in Germany" = pismamê li Almanyayê.',
      ),
    ],
    emoji: '📱',
  ),
  EnReadingPassage(
    id: 'en_read_019',
    level: 'A2',
    titleEn: 'A Day at the Lake',
    titleKu: 'Rojek li golê',
    passage: 'Lake Van is one of the biggest lakes in the region. Last summer, my family drove there for a picnic. The water was blue and clean. We sat under a large tree. My father grilled fish on the fire. I swam for a long time with my brothers. A small boat passed by us. We have been to many places, but this was special. We went home happy but very tired.',
    translationKu: 'Gola Wanê yek ji golên herî mezin ên herêmê ye. Havîna par, malbata min bi otomobîlê çû wir ji bo pîknîkê. Av şîn û paqij bû. Em li bin darekî mezin rûniştin. Bavê min li ser agir masî biraştin. Ez demeke dirêj bi birayên xwe re melevanî kirim. Belemeke biçûk ji cem me derbas bû. Em çûn gelek cihan, lê ev taybet bû. Em kêfxweş lê pir westiyayî vegeriyan malê.',
    questions: [
      EnReadingQuestion(
        questionEn: 'How was the water?',
        correctAnswer: 'Blue and clean.',
        options: ['Blue and clean.', 'Cold and dirty.', 'Warm and dark.', 'Green and muddy.'],
        explanationKu: '"Blue and clean" = şîn û paqij.',
      ),
      EnReadingQuestion(
        questionEn: 'What did father cook?',
        correctAnswer: 'Fish.',
        options: ['Fish.', 'Chicken.', 'Meat.', 'Vegetables.'],
        explanationKu: '"Grilled fish" = masî biraşt.',
      ),
      EnReadingQuestion(
        questionEn: 'How did they feel at the end?',
        correctAnswer: 'Happy but tired.',
        options: ['Happy but tired.', 'Sad and bored.', 'Angry.', 'Hungry.'],
        explanationKu: '"Happy but very tired" = kêfxweş lê westiyayî.',
      ),
    ],
    emoji: '🏞️',
  ),
  EnReadingPassage(
    id: 'en_read_020',
    level: 'A2',
    titleEn: 'My Uncle\'s Music',
    titleKu: 'Muzîka apê min',
    passage: 'My uncle plays the tembûr. He has played it since he was a child. The tembûr is a traditional Kurdish instrument with a long neck. Every Friday evening, my uncle comes to our house. He sings old songs about love and mountains. My father claps along with him. I have learned two short songs from him. He says music keeps our culture alive. I want to play like him one day.',
    translationKu: 'Apê min tembûrê lê dide. Ji dema ku ew zarok bû, ew lê dixe. Tembûr sazeke kevneşopî ya kurdî ye ku stûyê wê dirêj e. Her êvara înê, apê min tê mala me. Ew stranên kevn ên derheqê evîn û çiyayan distirê. Bavê min bi wî re çepikan lê dide. Min du stranên kurt jê fêr bûne. Ew dibêje muzîk çanda me zindî dihêle. Ez dixwazim rojekê mîna wî lê bixim.',
    questions: [
      EnReadingQuestion(
        questionEn: 'What does his uncle play?',
        correctAnswer: 'Tembûr.',
        options: ['Tembûr.', 'Piano.', 'Drum.', 'Flute.'],
        explanationKu: '"Tembûr" = saza kurdî.',
      ),
      EnReadingQuestion(
        questionEn: 'When does the uncle come?',
        correctAnswer: 'Friday evening.',
        options: ['Friday evening.', 'Sunday morning.', 'Every day.', 'Saturday afternoon.'],
        explanationKu: '"Friday evening" = êvara înê.',
      ),
      EnReadingQuestion(
        questionEn: 'What does the uncle say about music?',
        correctAnswer: 'It keeps culture alive.',
        options: ['It keeps culture alive.', 'It is easy to learn.', 'It is only for old people.', 'It is boring.'],
        explanationKu: '"Music keeps our culture alive" = muzîk çandê zindî dihêle.',
      ),
    ],
    emoji: '🎵',
  ),
  EnReadingPassage(
    id: 'en_read_021',
    level: 'B1',
    titleEn: 'Why I Love Reading',
    titleKu: 'Çima ez ji xwendinê hez dikim',
    passage: 'Reading has been my favorite hobby since I was a child. When I was seven years old, my father gave me a book of Kurdish folk tales. I could not stop reading it. Since then, I have explored many different worlds through books. Novels take me to places I have never visited. Poetry helps me understand my own feelings better. I believe that people who read regularly develop stronger imagination and empathy. Nowadays, many young people prefer social media, but I still think a quiet hour with a good book is priceless. Next year, I plan to start writing my own short stories in Kurmancî.',
    translationKu: 'Xwendin ji dema ku ez zarok bûm, jixwe hobiya min a bijarte ye. Dema ku ez heft salî bûm, bavê min pirtûkeke çîrokên kurdî yên gelêrî da min. Min nikarîbû xwendina wê rawestîne. Ji wê demê vir ve, min bi rêya pirtûkan gelek cîhanên cihê keşf kirine. Roman min dibin cihên ku min qet serdan nekirine. Helbest alîkariya min dike ku hestên xwe baştir fam bikim. Ez bawer dikim ku mirovên ku bi rêkûpêk dixwînin, xeyal û hestyariyeke xurttir pêşdixin. Van rojan, gelek ciwan medyaya civakî tercîh dikin, lê dîsa jî ez difikirim ku saetek bêdeng bi pirtûkeke baş re bêhempa ye. Sala bê, ez plan dikim ku dest bi nivîsandina çîrokên xwe yên kurt bi kurmancî bikim.',
    questions: [
      EnReadingQuestion(
        questionEn: 'What was his first book?',
        correctAnswer: 'Kurdish folk tales.',
        options: ['Kurdish folk tales.', 'Science fiction.', 'History.', 'Math book.'],
        explanationKu: '"A book of Kurdish folk tales" = pirtûka çîrokên gelêrî.',
      ),
      EnReadingQuestion(
        questionEn: 'What does poetry help him with?',
        correctAnswer: 'Understanding feelings.',
        options: ['Understanding feelings.', 'Learning history.', 'Making money.', 'Writing essays.'],
        explanationKu: '"Understand my own feelings" = hestên xwe fam bikim.',
      ),
      EnReadingQuestion(
        questionEn: 'What is his future plan?',
        correctAnswer: 'Writing short stories.',
        options: ['Writing short stories.', 'Moving abroad.', 'Opening a library.', 'Teaching English.'],
        explanationKu: '"Writing my own short stories" = nivîsandina çîrokên xwe yên kurt.',
      ),
    ],
    emoji: '📚',
  ),
  EnReadingPassage(
    id: 'en_read_022',
    level: 'B1',
    titleEn: 'Living in a Big City',
    titleKu: 'Jiyana li bajarekî mezin',
    passage: 'I moved from my village to Stenbol three years ago. At first, the city shocked me. The streets were always crowded and the noise never stopped. I missed the silence of my mountains deeply. However, as time passed, I learned to appreciate city life. There are libraries where I can study any subject and theaters where I have watched Kurdish plays. I have made friends from different backgrounds. Still, every summer I go back to my village. I think both places have shaped who I am. The village gave me roots, and the city gave me wings. I would not want to live without either one.',
    translationKu: 'Sê sal berê ez ji gundê xwe çûm Stenbolê. Di destpêkê de, bajar ez matmayî hiştim. Kolan her tim qelebalix bûn û deng tu carî nesekinî. Min bêdengiya çiyayên xwe gelek hiz dikir. Lê belê, her ku dem derbas bû, ez fêr bûm ku qedrê jiyana bajêr bigirim. Pirtûkxane hene ku ez dikarim li wan her babetê bixwînim û şano hene ku min li wan şanoyên kurdî temaşe kirine. Min ji paşxaneyên cuda re heval çêkirine. Dîsa jî, her havîn ez vedigerim gundê xwe. Ez difikirim ku her du cih min çêkirine. Gund ji min re reh da, bajêr ji min re bask da. Ez nexwazim bê yek ji wan bijîm.',
    questions: [
      EnReadingQuestion(
        questionEn: 'How did the city feel at first?',
        correctAnswer: 'Shocking.',
        options: ['Shocking.', 'Beautiful.', 'Boring.', 'Familiar.'],
        explanationKu: '"The city shocked me" = bajar ez matmayî hiştim.',
      ),
      EnReadingQuestion(
        questionEn: 'What has he watched in theaters?',
        correctAnswer: 'Kurdish plays.',
        options: ['Kurdish plays.', 'Italian operas.', 'Foreign movies.', 'Concerts.'],
        explanationKu: '"Kurdish plays" = şanoyên kurdî.',
      ),
      EnReadingQuestion(
        questionEn: 'What does the village give him?',
        correctAnswer: 'Roots.',
        options: ['Roots.', 'Money.', 'Job.', 'Fame.'],
        explanationKu: '"The village gave me roots" = gund ji min re reh da.',
      ),
    ],
    emoji: '🌆',
  ),
  EnReadingPassage(
    id: 'en_read_023',
    level: 'B1',
    titleEn: 'Learning a New Language',
    titleKu: 'Fêrbûna zimanekî nû',
    passage: 'Learning English as a Kurmancî speaker has been a fascinating journey for me. At first, I thought the grammar would be very difficult, but I soon realized that Kurmancî and English share more than I expected. Both languages use similar sentence structures in simple present tense. Of course, pronunciation was another story. I had to practice English sounds for months before my friends could understand me clearly. What helped me most was watching movies with subtitles and reading children\'s books. If someone asks me for advice, I always say that consistency matters more than talent. You cannot learn a language in a week, but you can surely master it in a few years.',
    translationKu: 'Fêrbûna îngilîzî wekî axaftvanekî kurmancî ji bo min gereke dilkêş bûye. Di destpêkê de, min difikirî ku rêziman pir zehmet be, lê zû min fêm kir ku kurmancî û îngilîzî ji ya min hêvî kir zêdetir tiştan parve dikin. Her du ziman di dema niha ya sade de avahiyên hevokî yên wekhev bi kar tînin. Bê guman, bilêvkirin çîrokeke din bû. Gerek bû ez mehên dirêj dengên îngilîzî temrîn bikim berî ku hevalên min bi zelalî min fam bikin. Tiştê ku herî zêde alîkariya min kir, temaşekirina fîlman bi jêrnivîsan û xwendina pirtûkên zarokan bû. Eger kesek ji min pêşniyarê bixwaze, ez her tim dibêjim ku domdarî ji behremendiyê girîngtir e. Tu nikarî di hefteyekê de zimanekî fêr bibî, lê bêguman dikarî wî di çend salan de serwer bikî.',
    questions: [
      EnReadingQuestion(
        questionEn: 'What did he first think about grammar?',
        correctAnswer: 'Very difficult.',
        options: ['Very difficult.', 'Very easy.', 'Boring.', 'Useless.'],
        explanationKu: '"Grammar would be very difficult" = rêziman pir zehmet.',
      ),
      EnReadingQuestion(
        questionEn: 'What helped him most?',
        correctAnswer: 'Movies and children\'s books.',
        options: ['Movies and children\'s books.', 'Private teacher.', 'Grammar books only.', 'Traveling abroad.'],
        explanationKu: '"Movies with subtitles and children\'s books" = fîlm û pirtûkên zarokan.',
      ),
      EnReadingQuestion(
        questionEn: 'What matters more than talent?',
        correctAnswer: 'Consistency.',
        options: ['Consistency.', 'Money.', 'Age.', 'Memory.'],
        explanationKu: '"Consistency matters more" = domdarî girîngtir.',
      ),
    ],
    emoji: '🌍',
  ),
  EnReadingPassage(
    id: 'en_read_024',
    level: 'B1',
    titleEn: 'The Power of Traditional Clothes',
    titleKu: 'Hêza cilên kevneşopî',
    passage: 'Every culture has its own traditional clothing, and for Kurds, traditional dress carries deep meaning. My grandmother still wears her long colorful dress almost every day. She has kept this habit for her entire life. When I was younger, I did not fully understand why she refused modern clothes. Now I see that her dress is more than fabric. Each pattern tells a story about her region. Young Kurds today are rediscovering traditional clothes, especially during Newroz. Social media has helped, because people proudly share photos of their outfits. I believe that keeping our traditions alive does not mean rejecting the modern world. We can wear jeans on Monday and kiras on Sunday.',
    translationKu: 'Her çandek cilûbergên xwe yên kevneşopî hene, û ji bo kurdan, cila kevneşopî watayeke kûr hildigire. Dapîra min hîn jî hema her roj fîstaneke xwe ya dirêj û rengîn li xwe dike. Wê ev adet tevahiya jiyana xwe parastiye. Gava ez biçûktir bûm, min bi temamî fêm nedikir çima wê cilên modern red dikirin. Niha ez dibînim ku fîstana wê tiştek ji qumaşê zêdetir e. Her nexş çîrokek li ser herêma wê dibêje. Ciwanên kurd ên îro cilên kevneşopî ji nû ve keşf dikin, nemaze di dema Newrozê de. Medyaya civakî alîkarî kiriye, ji ber ku xelk bi serbilindî wêneyên cilên xwe parve dikin. Ez bawer dikim ku zindî hiştina kevneşopiyên me wateya redkirina cîhana modern nade. Em dikarin roja duşemê jîn li xwe bikin û roja yekşemê kiras.',
    questions: [
      EnReadingQuestion(
        questionEn: 'What does grandmother wear?',
        correctAnswer: 'Long colorful dress.',
        options: ['Long colorful dress.', 'Jeans.', 'Black suit.', 'Sport clothes.'],
        explanationKu: '"Long colorful dress" = fîstaneke dirêj û rengîn.',
      ),
      EnReadingQuestion(
        questionEn: 'What do patterns tell?',
        correctAnswer: 'Stories about her region.',
        options: ['Stories about her region.', 'Prices.', 'Ages.', 'Nothing.'],
        explanationKu: '"Tells a story about her region" = li ser herêma wê çîrok dibêje.',
      ),
      EnReadingQuestion(
        questionEn: 'What is the writer\'s opinion?',
        correctAnswer: 'We can wear both modern and traditional.',
        options: ['We can wear both modern and traditional.', 'Modern clothes are better.', 'Traditional clothes are old-fashioned.', 'Everyone should wear the same.'],
        explanationKu: '"Jeans on Monday, kiras on Sunday" = her du celeb cil derbasdar in.',
      ),
    ],
    emoji: '👗',
  ),
  EnReadingPassage(
    id: 'en_read_025',
    level: 'B1',
    titleEn: 'A Summer Without Internet',
    titleKu: 'Havînek bê înternet',
    passage: 'Two summers ago, I spent three weeks at my cousin\'s farm where there was no internet connection. At first, I felt lost. I kept reaching for my phone out of habit. By the third day, something strange happened. I started noticing details I had never seen before: the color of the sunrise, the sound of insects at night, the way my aunt\'s hands moved while she was making bread. I read two full novels in those weeks. I had long conversations with my cousins about our dreams and fears. When I returned to the city, I realized that constant connection had been stealing my attention for years. Now I try to have one offline day every week. It has completely changed how I experience time.',
    translationKu: 'Du havîn berê, min sê hefte li cotkariya pismamê xwe derbas kirin ku lê pêwendiya înternetê tunebû. Di destpêkê de, min xwe winda hîs kir. Ez ji ber adetê destê xwe dibirim bal telefona xwe. Roja sêyem, tiştekî ecêb qewimî. Min dest pê kir hûrgiliyên ku min berê qet nedîtibûn bibînim: rengê rojhilatê, dengê kêzikan bi şev, awayê ku destên metika min dilivîn dema ku wê nan çêdikir. Min di wan hefteyan de du romanên tekûz xwendin. Min bi pismamên xwe re axaftinên dirêj kirin li ser xewn û tirsên me. Gava ez vegeriyam bajêr, min fêm kir ku girêdana domdar salan balkêşiya min didizî. Niha ez hewl didim her hefte rojekê bê înternet bim. Ev bi tevahî guhertiye ka ez dem çawa diceribînim.',
    questions: [
      EnReadingQuestion(
        questionEn: 'How did he feel first without internet?',
        correctAnswer: 'Lost.',
        options: ['Lost.', 'Happy.', 'Sleepy.', 'Sick.'],
        explanationKu: '"I felt lost" = xwe winda hîs kir.',
      ),
      EnReadingQuestion(
        questionEn: 'What did he notice?',
        correctAnswer: 'Small details around him.',
        options: ['Small details around him.', 'News on TV.', 'Traffic.', 'New apps.'],
        explanationKu: '"Noticing details" = hûrgilî dîtin.',
      ),
      EnReadingQuestion(
        questionEn: 'What does he do now every week?',
        correctAnswer: 'One offline day.',
        options: ['One offline day.', 'Watches movies.', 'Travels to village.', 'Buys new phone.'],
        explanationKu: '"One offline day every week" = rojekê bê înternet.',
      ),
    ],
    emoji: '🏕️',
  ),
  EnReadingPassage(
    id: 'en_read_026',
    level: 'B1',
    titleEn: 'The Old Storyteller',
    titleKu: 'Dengbêjê kevn',
    passage: 'In the small coffeehouse of our town, an old man named Apê Reşo tells stories every evening. People call him a dengbêj. He has been performing for almost sixty years, yet his voice still carries the same strength. When he sings about lost lovers and ancient battles, even the noisy children become silent. My father took me there when I was eight, and I have attended his performances regularly since then. What amazes me is that he never uses paper. He has memorized hundreds of songs, each one thousands of lines long. Recently, a university started recording his work to preserve it. I am glad they did. If we lose our dengbêjs, we lose a part of our memory that no book can truly replace.',
    translationKu: 'Di qehwexaneya biçûk a bajarokê me de, pîrekî bi navê Apê Reşo her êvar çîrokan dibêje. Xelkê jê re dibêjin dengbêj. Ew nêzîkî şêst salan e distirê, lê dîsa jî dengê wî heman hêzê hildigire. Dema ku ew li ser evîndarên winda û şerên kevnar distirê, hetta zarokên qîrîn jî bêdeng dibin. Bavê min ez tam heyştsalî bûm birime wir, û ji wê demê ve bi rêkûpêk ez serdana performansên wî dikim. Tiştê ku ez mat dihêlim ev e ku ew qet kaxez bi kar naîne. Wî sedan stran ezber kirine, her yek bi hezaran rêzan. Van demên dawî, zanîngehek dest pê kir ku xebatên wî tomar bike da ku wan biparêze. Ez kêfxweş im ku wan ev kir. Eger em dengbêjên xwe wenda bikin, em beşek ji bîra xwe wenda dikin ku tu pirtûk bi rastî nikare cîhê wê bigire.',
    questions: [
      EnReadingQuestion(
        questionEn: 'How long has he performed?',
        correctAnswer: 'Almost sixty years.',
        options: ['Almost sixty years.', 'Ten years.', 'One hundred years.', 'Twenty years.'],
        explanationKu: '"Almost sixty years" = nêzîkî şêst salan.',
      ),
      EnReadingQuestion(
        questionEn: 'Does he use paper?',
        correctAnswer: 'No, he memorizes.',
        options: ['No, he memorizes.', 'Yes, always.', 'Sometimes.', 'Only at night.'],
        explanationKu: '"He never uses paper" = qet kaxez bi kar naîne.',
      ),
      EnReadingQuestion(
        questionEn: 'Why is recording important?',
        correctAnswer: 'To preserve cultural memory.',
        options: ['To preserve cultural memory.', 'To make money.', 'To entertain tourists.', 'To compete with others.'],
        explanationKu: '"Lose part of our memory" = beşek ji bîrê wenda kirin.',
      ),
    ],
    emoji: '🎤',
  ),
  EnReadingPassage(
    id: 'en_read_027',
    level: 'B1',
    titleEn: 'My First Job',
    titleKu: 'Karê min ê yekem',
    passage: 'When I was nineteen, I started working at a small bookshop in the city. The owner, Mr. Azad, had run the shop for thirty years. I thought selling books would be easy, but I was wrong. During my first week, I could not find anything on the shelves. Mr. Azad had his own system which nobody could understand except him. Slowly, I learned the places of different authors. More importantly, I learned how to listen to customers. Some came looking for a specific book, while others just wanted to talk about literature. That job taught me that people value attention almost as much as the product itself. Even now, after five years, I still visit the shop whenever I can.',
    translationKu: 'Gava ez nozdeh salî bûm, min dest bi xebatê kir di pirtûkfiroşeke biçûk a bajêr de. Xwedî, Birêz Azad, sî salan pirtûkfiroş meşandibû. Min difikirî ku firotina pirtûkan hêsan be, lê ez xelet bûm. Di hefteya xwe ya yekem de, min nikarîbû li ser refan tiştek bibînim. Birêz Azad xwedî sîstemeke xwe ya taybet bû ku ji wî pê ve tu kesî ew fêm nedikir. Hêdî hêdî, ez fêrî cihên nivîskarên cuda bûm. Ya girîngtir, ez fêr bûm çawa guhdariya xerîdaran bikim. Hinan li pirtûkeke diyar digeriyan, hinên din jî tenê dixwestin li ser edebiyatê biaxivin. Ew kar fêrî min kir ku mirov hema bi qasî hilberê bixwe qedrê balkêşiyê digirin. Hîn niha jî, piştî pênc salan, kengî ez bikaribim ez serdana dikanê dikim.',
    questions: [
      EnReadingQuestion(
        questionEn: 'What was the owner\'s name?',
        correctAnswer: 'Mr. Azad.',
        options: ['Mr. Azad.', 'Mr. Reşo.', 'Mr. Baran.', 'Mr. Alî.'],
        explanationKu: '"Mr. Azad" = Birêz Azad.',
      ),
      EnReadingQuestion(
        questionEn: 'What problem did he have at first?',
        correctAnswer: 'Finding books on shelves.',
        options: ['Finding books on shelves.', 'Counting money.', 'Cleaning shop.', 'Speaking to owner.'],
        explanationKu: '"Could not find anything" = nekarî tiştek bibîne.',
      ),
      EnReadingQuestion(
        questionEn: 'What did the job teach him?',
        correctAnswer: 'People value attention.',
        options: ['People value attention.', 'Books are cheap.', 'Customers are rude.', 'Work is boring.'],
        explanationKu: '"People value attention" = xelk qedrê balkêşiyê digirin.',
      ),
    ],
    emoji: '📖',
  ),
  EnReadingPassage(
    id: 'en_read_028',
    level: 'B2',
    titleEn: 'The Role of Language in Identity',
    titleKu: 'Rola zimên di nasnameyê de',
    passage: 'Language is far more than a communication tool. It is the living memory of a people, a bridge between generations, and often the clearest mirror of cultural identity. For many Kurds, speaking Kurmancî is not merely a linguistic choice but a political and emotional statement. My grandfather, who grew up in a period when speaking Kurdish at school was forbidden, used to whisper lullabies to me in Kurmancî at night. Those whispers planted something in me that decades of schooling in another language could never uproot. Linguists argue that when a language disappears, an entire worldview vanishes with it. I have come to believe this personally. Each word in Kurmancî carries centuries of mountains, rivers, migrations, and songs. When young Kurds today debate whether to invest time in learning their mother tongue, I wish they understood that they are not just learning vocabulary. They are inheriting an ancient conversation between their ancestors and the land itself. Losing that conversation would impoverish not only Kurds but all of humanity.',
    translationKu: 'Ziman ji amûreke ragihandinê pir zêdetir e. Ew bîra zindî ya gelekî ye, pirek di navbera nifşan de ye, û gelek caran neynika herî zelal a nasnameya çandî ye. Ji bo gelek kurdan, axaftina bi kurmancî ne tenê hilbijardineke zimanî ye, lê daxuyaniyeke siyasî û hestyarî ye. Bapîrê min, ku di demeke de mezin bûbû ku axaftina kurdî li dibistanê qedexe bû, bi şev bi kurmancî lorî ji min re dipistandin. Wan pistandinan tiştek di min de çand ku dehan salên xwendina bi zimanekî din tu carî nikarîbû bikişîne. Zimanzan dibêjin dema ku zimanek winda dibe, temamiya dîtineke cîhanê bi wî re dinamîne. Ez bi xwe bi vê bawer bûme. Her peyvek di kurmancî de sedsalên çiya, çem, koçberî û stranan hildigire. Dema ku ciwanên kurd îro nîqaş dikin ka dem li fêrbûna zimanê dayikê bidin an na, ez hêvî dikim ku ew fêm bikin ku ew ne tenê peyvan fêr dibin. Ew mîrateyê ji axaftineke kevnar a di navbera bav û kalên xwe û bi xwe axê de digirin. Winda kirina wê axaftinê dê ne tenê kurdan, lê tevahiya mirovahiyê belengaztir bike.',
    questions: [
      EnReadingQuestion(
        questionEn: 'What did the grandfather do at night?',
        correctAnswer: 'Whispered lullabies in Kurmancî.',
        options: ['Whispered lullabies in Kurmancî.', 'Told scary stories.', 'Sang loudly.', 'Read newspapers.'],
        explanationKu: '"Whisper lullabies in Kurmancî" = bi kurmancî lorî pistandin.',
      ),
      EnReadingQuestion(
        questionEn: 'What do linguists argue?',
        correctAnswer: 'A worldview vanishes with a lost language.',
        options: ['A worldview vanishes with a lost language.', 'All languages are equal.', 'English is the future.', 'Children learn fastest.'],
        explanationKu: '"Worldview vanishes" = dîtina cîhanê dinamîne.',
      ),
      EnReadingQuestion(
        questionEn: 'What is the main message?',
        correctAnswer: 'Learning mother tongue preserves ancient conversation.',
        options: ['Learning mother tongue preserves ancient conversation.', 'Language is just grammar.', 'Only old people speak Kurmancî.', 'We should forget the past.'],
        explanationKu: '"Ancient conversation" = axaftineke kevnar.',
      ),
    ],
    emoji: '🗣️',
  ),
  EnReadingPassage(
    id: 'en_read_029',
    level: 'B2',
    titleEn: 'Technology and Human Connection',
    titleKu: 'Teknolojî û girêdana mirovî',
    passage: 'The past two decades have transformed how human beings relate to one another. Smartphones, social networks, and instant messaging promised to bring us closer, and in many ways they have succeeded. A grandmother in a mountain village can now see her grandchildren studying in Europe every Sunday on a video call, something my parents could never have imagined. However, an uncomfortable paradox has emerged. Surveys consistently show that despite being more connected than ever, young people today report higher rates of loneliness than any previous generation. I suspect the reason is that digital communication often replaces presence rather than supplementing it. A message cannot fully substitute the warmth of sitting together with tea and silence. Technology is neither inherently good nor bad. It is a powerful tool whose effect depends on how thoughtfully we wield it. If we allow algorithms designed to maximize engagement to shape our attention, we lose the slow, patient art of being with each other. Perhaps the wisest approach is to treat connection as something sacred: online when necessary, offline whenever possible.',
    translationKu: 'Du dehsalên borî awayê ku mirov bi hev re têkilîdar in guhertin. Telefonên biaqil, toryên civakî û peyaman ji me re soz dan ku me nêzîktir bikin, û di gelek aliyan de wan ev kiriye. Dapîrekê li gundekî çiyayî niha dikare neviyên xwe yên li Ewropayê yên ku dixwînin her roja yekşemê di bangeweyeke vîdeoyî de bibîne, tiştekî ku dêûbavên min qet nikarîbûn xeyal bikin. Lê belê, paradoksek nerihet derketiye holê. Anket her tim nîşan didin ku tevî ku ji her demê zêdetir girêdayî ne, ciwanên îro nerxên tenêtiyê ji her nifşa berê bilindtir ragihînin. Ez guman dikim ku sedem ew e ku ragihandina dîjîtal gelek caran li şûna amadebûnê diçe, ne ku wê temam bike. Peyam nikare bi tevahî li şûna germahiya bi hev re rûniştin bi çay û bêdengiyê bê. Teknolojî ne ji cewherê xwe baş an xirab e. Ew amûreke bi hêz e ku bandora wê bi awayê ku em bi bîrewerî bi kar tînin ve girêdayî ye. Eger em dihêlin algorîtmayên ku ji bo zêdekirina beşdariyê hatine sêwirandin balkêşiya me ava bikin, em hunera hêdî û bisebir a bi hev re bûnê winda dikin. Belkî nêzîkatiya herî biaqil ev e ku em girêdanê wek tiştekî pîroz bisekinin: serhêl gava hewce be, ne serhêl kengî mimkun be.',
    questions: [
      EnReadingQuestion(
        questionEn: 'What paradox exists today?',
        correctAnswer: 'More connected but lonelier.',
        options: ['More connected but lonelier.', 'Less connected and happier.', 'More friends but less money.', 'Faster internet but slower phones.'],
        explanationKu: '"More connected, higher loneliness" = girêdayîtir lê tenêtir.',
      ),
      EnReadingQuestion(
        questionEn: 'What can a message not replace?',
        correctAnswer: 'Warmth of being together.',
        options: ['Warmth of being together.', 'Phone calls.', 'Emails.', 'Letters.'],
        explanationKu: '"Warmth of sitting together" = germahiya bi hev re rûniştinê.',
      ),
      EnReadingQuestion(
        questionEn: 'What does the author recommend?',
        correctAnswer: 'Online when necessary, offline when possible.',
        options: ['Online when necessary, offline when possible.', 'Always offline.', 'Always online.', 'Delete all apps.'],
        explanationKu: '"Online when necessary, offline whenever possible" = pêşniyara dawî.',
      ),
    ],
    emoji: '💻',
  ),
  EnReadingPassage(
    id: 'en_read_030',
    level: 'B2',
    titleEn: 'Mountains as Teachers',
    titleKu: 'Çiya wek mamoste',
    passage: 'For centuries, poets and wanderers have written about the mountains as if they were alive. Among Kurds, this relationship goes beyond metaphor. Mountains have been refuge, home, witness, and teacher. My grandfather used to say that a person who has not climbed a mountain slowly, breath by breath, does not truly understand patience. I used to find this statement romantic and slightly exaggerated, until I hiked to the summit of Cûdî one autumn morning. The ascent taught me more about discipline than any classroom ever had. Each step required me to negotiate with my own limitations, to listen to the silent conversation between my body and the stone path. Near the peak, I encountered an old shepherd who offered me water. He had lived on those slopes for over fifty years. When I asked him what the mountains had taught him, he paused for a long moment and replied simply that mountains teach you to remain yourself. Cities change people, he said, but mountains strip away everything that is not essential. I have carried those words with me ever since. In a world increasingly obsessed with speed, noise, and performance, perhaps we all need a mountain to climb, not to conquer it, but to be reminded of who we really are.',
    translationKu: 'Sedsalan e ku helbestvan û rêwî li ser çiyayan wek ku zindî bin dinivîsin. Di nav kurdan de, ev têkilî ji metaforê wêdetir diçe. Çiya penaberî, mal, şahid û mamoste bûne. Bapîrê min digot ku kesekî ku çiyayek bi hêdî, nefes bi nefes hilnegerandiye, bi rastî sebrê fêm nake. Min ev gotin romantîk û hinekî zêde dît, heta ku min di sibeheke payîzê de derket ser lûtkeya Cûdî. Hilkişîn ji her polê de bêhtir qaîdeyên dîsîplînê hînî min kirin. Her gavek hewce dikir ku ez bi sînorên xwe re danûstandinan bikim, guhdarî axaftina bêdeng a di navbera bedena xwe û riya kevirî de bikim. Nêzîkî lûtkeyê, ez bi şivanekî kal re rastî hev hatim ku av pêşkêşî min kir. Ew ji pêncî salan zêdetir li wan şîlikan jiya bû. Gava min ji wî pirsî ku çiyayan çi fêrî wî kirine, ew demeke dirêj sekinî û bi sadegî bersiv da ku çiya te fêr dikin ku tu xwe bimînî. Bajar mirovan diguherînin, wî got, lê çiya her tiştê ku ne bingehîn e ji holê radikin. Ji wê demê ve min ew peyv bi xwe re hilgirtine. Di cîhaneke ku her ku diçe bi lez, qîreqîr û performansê ve mijûl dibe, belkî me hemûyan hewceyî çiyayek hilkişînê heye, ne ji bo ku em wê bigirin, lê ji bo ku em bên bibîranîn kê em bi rastî ne.',
    questions: [
      EnReadingQuestion(
        questionEn: 'What did grandfather say about patience?',
        correctAnswer: 'Mountain climbing teaches it.',
        options: ['Mountain climbing teaches it.', 'Books teach it.', 'Age brings it.', 'Only God gives it.'],
        explanationKu: '"Climbed slowly, breath by breath" = bi hêdî hilkişiya.',
      ),
      EnReadingQuestion(
        questionEn: 'What did the old shepherd say mountains do?',
        correctAnswer: 'Help you remain yourself.',
        options: ['Help you remain yourself.', 'Make you stronger physically.', 'Give you wealth.', 'Teach you languages.'],
        explanationKu: '"Remain yourself" = xwe bimînî.',
      ),
      EnReadingQuestion(
        questionEn: 'What is the final message?',
        correctAnswer: 'We need reminders of who we truly are.',
        options: ['We need reminders of who we truly are.', 'Cities are evil.', 'Everyone should move to mountains.', 'Shepherds know everything.'],
        explanationKu: '"Reminded of who we really are" = bîra me bê ku em kî ne.',
      ),
    ],
    emoji: '⛰️',
  )
];
