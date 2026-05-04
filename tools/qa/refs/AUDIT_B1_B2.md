# LÛTKE — B1/B2 Vocabulary & Lesson Audit
**Reference standard**: Bedirxan-Lescot Hawar (BL), Thackston (TH)
**Files audited**:
1. `lib/features/lessons/domain/b1_kelime_db.dart` (8952 lines)
2. `lib/features/lessons/domain/b1_lesson_definitions.dart` (921 lines)
3. `lib/features/lessons/domain/b2_kelime_db.dart` (3216 lines)
4. `lib/features/lessons/domain/b2_lesson_definitions.dart` (902 lines)

**Key conventions used in findings**:
- `[BL]` = Bedirxan-Lescot grammar
- `[TH]` = Thackston grammar
- "Ezafe" = `-ê / -a / -ên` linker; m=eril, f=mê, pl=pirjimar
- "Ergative" = past transitive: agent OBLIQUE, verb agrees with patient

---

## SECTION A — B1 LESSON DEFINITIONS (`b1_lesson_definitions.dart`)

### [FILE: b1_lesson_definitions.dart, LINE: 105]
**id**: b1_l01_e3
**Field**: opts/note
**Current**: `opts: ['dît', 'dîtî', 'dibînî', 'bibîne']` with prompt "Te çi ___?"
**Issue**: Distractor `'dîtî'` is the participle/adjective form ("görmüş, görülmüş"), not a verb form a learner would plausibly produce here. The actual ergative competitor would be `dîtin` (3pl object agreement) — that distractor is missing. As written, three of four options are not really competitive: `dibînî` (present 2sg) and `bibîne` (subjunctive 3sg) are wrong tense AND wrong person. The single semi-plausible distractor is `dîtî` which is morphologically wrong.
**Suggested fix**: Replace `'dîtî'` with `'dîtin'` so the test discriminates singular vs plural object agreement (the actual B1 teaching point). New options: `['dît', 'dîtin', 'dibînî', 'bibîne']`.
**Severity**: moderate
**Reference**: [BL] §173 (verb-object agreement)

### [FILE: b1_lesson_definitions.dart, LINE: 154]
**id**: b1_l02_e2
**Field**: opts
**Current**: `opts: ['dixwim', 'bixwe', 'xwarin', 'xwar']` with prompt "Min sêv ___."
**Issue**: `'dixwim'` is 1sg present indicative (= "ben yiyorum") — but the subject `Min` is the OBLIQUE form which only appears with past transitive, so `dixwim` cannot follow `Min`. The form would have to be `Min sêv dixwar` for past continuous. As written, the distractor is internally inconsistent (Min + present indicative). Better distractor: a 1sg present indicative form that COULD follow the equivalent direct subject, OR change the distractor to `dixwarim`.
**Suggested fix**: Replace `'dixwim'` with `'dixwarim'` or `'dixwarin'` so all distractors stay in past tense, testing perfective vs imperfective.
**Severity**: minor
**Reference**: [BL] §170 (oblique subject only with past transitive)

### [FILE: b1_lesson_definitions.dart, LINE: 211]
**id**: b1_l03_e3
**Field**: kurmanjPrompt / tr
**Current**: prompt `Te ___ ?` with tr "Sen söylemedin mi?"
**Issue**: The Turkish translation embeds the meaning of the missing word ("söylemedin"). A learner can solve the item from the Turkish prompt alone without engaging with the Kurdish. Also the standalone prompt `Te negot?` is grammatically OK but the prompt as displayed (`Te ___ ?`) is too contextless — there's no object given, so even `Te kir?` or `Te dît?` would parse fine; the disambiguation comes only from the Turkish hint, which leaks the answer.
**Suggested fix**: Add a context phrase: prompt `Te ev gotinê ___ ?` (= "Did you not say this saying?"), OR change Turkish to a less leaky phrasing.
**Severity**: moderate (clue leakage)
**Reference**: assessment-quality

### [FILE: b1_lesson_definitions.dart, LINE: 217–222]
**id**: b1_l03_e4
**Field**: opts
**Current**: opts: `['Wan dixwaze ev bike', 'Wan qet ev tişt nekir', 'Wan carekê ev kir', 'Wan her tim ev kir']`
**Issue**: Option 0 `'Wan dixwaze ev bike'` is grammatically broken. `Wan` is the oblique-3pl pronoun, used as an ERGATIVE subject of a past transitive verb. But `dixwaze` is 3sg present (`o istiyor`); the agent of present-tense `dixwaze` would be the direct (xwerû) form `Ew`, not `Wan`. Even if you read `Wan` as a possessor ("their"), the rest doesn't fit. The form should be `Ew dixwazin ev bikin` (= "They want to do this") or for ergative past `Wan xwest ku ev bikin`.
**Suggested fix**: Change option 0 to `'Ew dixwazin ev bikin'` so the distractor is well-formed but semantically wrong.
**Severity**: major (broken Kurdish in answer set)
**Reference**: [BL] §170, ergative agreement

### [FILE: b1_lesson_definitions.dart, LINE: 261–262]
**id**: b1_l04_e2
**Field**: opts/note (with prompt "Pîrê ji gund ___ .")
**Current**: opts `['tê', 'hatiye', 'dihat', 'hat']`, ci: 1
**Issue**: All four options are grammatically valid forms of `hatin` ("to come") in different tenses. Without a strong context cue the Turkish prompt "Büyükanne köyden gelmiş. (şu an burada)" leaks the perfect-tense answer through "(şu an burada)". The Kurdish prompt itself is ambiguous (could equally fit `hat` simple past, `dihat` imperfect, or `hatiye` perfect). Better: include a Kurdish discourse marker in the prompt that disambiguates: e.g. `Pîrê ji gund ___ û niha li mal e` (= "she has come from the village and is now home"), pushing learners to the Kurdish present-perfect logic.
**Suggested fix**: Add `û niha li mal e.` to prompt to force perfect tense in Kurdish, not Turkish.
**Severity**: moderate (clue leakage / over-reliance on translation)

### [FILE: b1_lesson_definitions.dart, LINE: 265–268]
**id**: b1_l04_e3
**Field**: kurmanjPrompt / opts
**Current**: prompt `Min ___ ku baş e.` translation `Ben söylemişim ki iyi.`
**Issue**: The Turkish "söylemişim ki iyi" is itself awkward Turkish (one would say "Ben demişim ki iyi" or "İyi olduğunu söylemişim"). Also the Kurdish prompt strips the ku-clause's antecedent: `Min gotiye ku baş e` is fine but the sentence feels truncated; B1 learners may expect `Min gotiye ku ew baş e` (= "I have said that he/it is good"). Also the distractors `'dê bibêjim'` and `'dibêjim'` cannot follow `Min` (oblique pronoun, see b1_l02_e2 issue) — wrong-tense traps that are not coherent.
**Suggested fix**: Replace `'dê bibêjim'` and `'dibêjim'` with forms that COULD follow `Min`: e.g. `gotim` (wrong; non-existent compound), or just keep two coherent distractors and two clearly impossible (with note explaining why oblique subject + present indicative is illegal).
**Severity**: moderate
**Reference**: [BL] §170

### [FILE: b1_lesson_definitions.dart, LINE: 318–321]
**id**: b1_l05_e3
**Field**: opts
**Current**: opts `['gotiye', 'dibêje', 'digot', 'got']`, ci: 2
**Issue**: With prompt `Bavê min timî ___ çîrokên xweş.` (subject `Bavê min` is direct case = ergative-incompatible), the distractors `'gotiye'` and `'got'` are ERGATIVE perfective forms that REQUIRE an oblique subject (`Bavê min` is direct / xwerû). The sentence with `got` would force `Bavê min` to be the subject of a past transitive — but in Kurmanji ergative, the subject of past transitive must be oblique (e.g. `Bavê min` would have to become `Bavê xwe → Bavê min...`, but a m-noun in oblique with `bavê min` as an ezafe phrase is awkward). Strictly, `Bavê min got` is a tolerated colloquial pattern in some dialects, but in standard ergative `Bavê min got` requires the agent in oblique. The prompt mixes patterns. The lesson NOTE says "Babam her zaman güzel hikayeler anlatırdı" — past habitual, which is `digot` (correct). But the distractors `got` and `gotiye` create grammatical issues with the unmarked-direct subject — though `bavê min` (eril ezafe) is already marked, so technically OK as oblique-singular for an eril noun. This is a gray area but worth noting.
**Suggested fix**: Either change the lesson NOTE to flag the ergative subject issue, or change subject to `Pîrê / Dêya min` (more clearly marked dişil oblique).
**Severity**: minor (gray-area)
**Reference**: [BL] §170, [TH] §76

### [FILE: b1_lesson_definitions.dart, LINE: 367–369]
**id**: b1_l06_e2
**Field**: opts/note (with prompt "Bila pîrê ___!")
**Current**: opts `['bê', 'dihat', 'hat', 'tê']`, ci: 0; note "Bila + mebestî"
**Issue**: Note correctly says `bila` requires subjunctive, but the prompt-distractor design is weak: `dihat` (past imperfect), `hat` (past simple), `tê` (present indicative) are all simply wrong tense — there's no strong subjunctive distractor. Learners can identify "bila → subjunctive" without engaging with the actual subjunctive paradigm. A stronger distractor would be `bibe` (subjunctive of `bûn`, wrong VERB but right MOOD), or `here` (subjunctive of `çûn`, wrong meaning but right mood).
**Suggested fix**: Replace one of `dihat/hat/tê` with `bibe` or `here` — same tense/mood, wrong lexeme.
**Severity**: minor
**Reference**: [BL] §190 (subjunctive)

### [FILE: b1_lesson_definitions.dart, LINE: 386–390]
**id**: b1_l06_e5
**Field**: opts
**Current**: prompt `Ez dixwazim pirtûkekê ___.` opts `['dixwînim', 'xwend', 'dê bixwînim', 'bixwînim']`, ci: 3
**Issue**: The grammar focus is correct (modal `dixwazim` triggers subjunctive in dependent clause). However the prompt-form `pirtûkekê` is in OBLIQUE (-ê) — but in this construction the embedded clause should have its own subject + the noun in direct case for an indefinite obj of `xwendin`: standard would be `Ez dixwazim pirtûkekê bixwînim` — but more idiomatic is `Ez dixwazim pirtûkek bixwînim` (without oblique on the indefinite indef object since it's not preceded by a preposition). The `-ê` marking on `pirtûkekê` is debatable — Bedirxan permits both, but some grammarians prefer no oblique on a bare direct object. Worth a flag.
**Suggested fix**: Either remove `-ê` from `pirtûkekê` → `pirtûkek`, or document that some grammars permit both forms.
**Severity**: minor (stylistic)
**Reference**: [BL] §145, [TH] §40

### [FILE: b1_lesson_definitions.dart, LINE: 444–448]
**id**: b1_l07_e5
**Field**: opts/note
**Current**: prompt `Çanda kurdî gelek ___ ye.`, opts `['hişk', 'dewlemend', 'feqîr', 'kêm']`, ci: 1, note: "Dewlemend" = zengin (sahibi olmak: dewlet+mend)
**Issue**: The note's etymology is wrong. `Dewlemend` is from `dewlet` (Arabic داولة) + `-mend`, but the gloss "sahibi olmak" is wrong — `-mend` (Persian) means "having, possessor of" (similar to English "-ful"). The translation "olmak" (= "to be") is incorrect. Should be "sahibi" or "sahip olan" (without the verb "olmak"). This is a pedagogical error in `grammarNote`.
**Suggested fix**: Change note to `"Dewlemend = zengin (dewlet + -mend 'sahip olan')"` or simply `"Dewlemend = zengin"`.
**Severity**: minor (grammarNote precision)
**Reference**: [BL] §273 (-mend morphology), [TH] §85

### [FILE: b1_lesson_definitions.dart, LINE: 469]
**id**: b1_l08_e1
**Field**: note
**Current**: `"Hişmend" = akıllı, bilge. Hiş (akıl) + -mend (sahip).`
**Issue**: Same `-mend` gloss issue as above. `-mend` is "sahip olan" or "donanmış olan" not bare "sahip" (which is a noun). Minor wording, but consistent across the file.
**Suggested fix**: Use `-mend = "sahip olan / -li"`.
**Severity**: minor
**Reference**: [BL] §273

### [FILE: b1_lesson_definitions.dart, LINE: 482–485]
**id**: b1_l08_e3
**Field**: ku/note
**Current**: prompt `Pîrêya min pir ___ e.` (= "Büyükannem çok ... dır.")
**Issue**: `Pîrêya min` — the form `Pîrêya` is unusual. The standard ezafe of `pîrê` (already a feminine form ending in `-ê`) is `pîrê / pîreka` for indefinite or just `pîrê + ezafe` constructions. Adding `-ya` to `Pîrê` to get `Pîrêya` doubles the feminine marker. Standard would be `Pîra min` (with regular -a ezafe on `pîr`) or just `Pîrê min` if `pîrê` is treated as already-ezafed. The form `Pîrêya min` is over-marked.
**Suggested fix**: Replace `Pîrêya min` with `Pîra min` or `Pîrê min`.
**Severity**: moderate
**Reference**: [BL] §145–148 (ezafe paradigm)

### [FILE: b1_lesson_definitions.dart, LINE: 538–545]
**id**: b1_l09_e2
**Field**: opts
**Current**: opts `['Di bazarê de', 'Beriya xewê', 'Di şîn û taziyan de', 'Dema pîrozbahiyekê (zarok, serkeftin)']`, ci: 3
**Issue**: Option 2 `'Di şîn û taziyan de'` (= "in mourning ceremonies") — `taziyan` is the oblique-plural of `tazîye` but this is an Arabic loan; the standard Kurmanji is `taziyê / tazîyê`. The form `taziyan` mixes Arabic root with Kurdish plural marker. Acceptable in mixed registers but worth flagging at B1.
**Suggested fix**: Use `Di şînê û taziyê de` (singular, with Kurdish ezafe) or `Di şînan û taziyan de` (Kurdish plural pattern). At minimum, footnote that this is a borrowing.
**Severity**: minor

### [FILE: b1_lesson_definitions.dart, LINE: 595]
**id**: b1_l10_e2
**Field**: opts
**Current**: opts `['bi tirs', 'bi sar', 'bi kêm', ...]`
**Issue**: `bi tirs`, `bi sar`, `bi kêm` are non-idiomatic. `tirs` (fear) could be combined with `bi` to mean "fearfully" but `bi sar` (with cold? coldly?) and `bi kêm` (with little? insufficiently?) are not natural Kurmanji collocations. They'd be better as `bi sarî` or `bi sermayê` (coldly/with cold-feel) and `bi kêmasî` (with deficiency). The bare adjective stems `sar/kêm` after `bi` is awkward.
**Suggested fix**: Change to `bi sarî` and `bi kêmasî`, or replace with stronger lexical distractors.
**Severity**: minor
**Reference**: [BL] adverb-formation

### [FILE: b1_lesson_definitions.dart, LINE: 599–602]
**id**: b1_l10_e3
**Field**: opts
**Current**: opts include `'Bi şermê'`, `'Bi bezê'`
**Issue**: `Bi bezê` — `bez` means "fat/grease" (or "running" in some dialects). As an option meaning "shyly/quickly" it's ambiguous. If "quickly" intended, the standard is `bi lez` (oblique `bi lezê` would need definite article on lez). The form `bi bezê` reads literally as "with the fat/lard" — unusable.
**Suggested fix**: Replace `'Bi bezê'` with `'Bi lez'` (= quickly) or `'Bi guman'` (= with doubt).
**Severity**: moderate (broken/ambiguous distractor)

### [FILE: b1_lesson_definitions.dart, LINE: 794–797]
**id**: b1_l13_e5
**Field**: ku/opts/note
**Current**: prompt `Xanî ___ ê mezin bû.`, opts `['helbestvanekî kurd', ...]`, note "Belirsiz ezafe -î + attribute + ê mezin"
**Issue**: The grammar note is half-right but cryptic. The construction `helbestvanekî kurd ê mezin` follows the pattern: `noun-ek-î (indef-ezafe-m) + adj1 + ê mezin (linking ezafe to second adj)`. But the lesson NOTE doesn't explain that `-ê` after `kurd` is the **secondary ezafe** that links the noun-phrase to a second attribute. Minimum mention of "secondary ezafe" or "-î ... ê" pattern would help. Also the prompt strictly should be `Xanî helbestvanekî kurd ê mezin bû` (subject + indefinite predicate noun phrase). As written with the blank, students may not see the second `ê`.
**Suggested fix**: Make note explicit: `"helbestvan-ek (indef.) -î (ezafe nêr) kurd (sıfat 1) ê (ikincil ezafe) mezin (sıfat 2) bû"`.
**Severity**: moderate (grammarNote insufficient pedagogically)
**Reference**: [BL] §145–155

### [FILE: b1_lesson_definitions.dart, LINE: 855]
**id**: b1_l14_e5
**Field**: opts
**Current**: opts `['mal', 'dil', 'can', 'av']`, ci: 2 ("can")
**Issue**: This is the proverb completion `Dil bi dil re, ___ bi can re`. The accepted answer is "can". The distractor `'dil'` is identical to one half of the dyad already shown — making the option set partially redundant. The proverb is well-known so this might be intentional, but `'mal'` and `'av'` are random nouns offering no proverb-related challenge. A stronger distractor would be `ruh` (ruh) or `giyan` (soul) — semantic competitors.
**Suggested fix**: Replace one of the random distractors with a semantic competitor like `'giyan'` or `'rûh'`.
**Severity**: minor (distractor weakness)

---

## SECTION B — B2 LESSON DEFINITIONS (`b2_lesson_definitions.dart`)

### [FILE: b2_lesson_definitions.dart, LINE: 99–103]
**id**: b2_l01_e2
**Field**: ku
**Current**: prompt `Dema ez hatim, pîrê ji mêj ve ___ .`, opts include `'çûbû', 'diçû', 'diçe', 'çûye'`
**Issue**: The collocation `ji mêj ve` is correct ("for a long time / since long ago"). However the distractor `'çûye'` (perfect: "has gone") is too similar in meaning to the answer `'çûbû'` (past perfect) — distinguishing perfect from past perfect is the very B2 contrast being taught. This is acceptable as a pedagogical contrast. But the distractor `'diçû'` (= was going) is fine; `'diçe'` (= is going) is wrong tense entirely — too easy a reject. Consider replacing `diçe` with another past-domain form for tighter discrimination.
**Suggested fix**: Replace `'diçe'` with `'çû'` (simple past) — three past forms, one perfect alternative; that tests the past-perfect cue more rigorously.
**Severity**: minor

### [FILE: b2_lesson_definitions.dart, LINE: 115–119]
**id**: b2_l01_e4
**Field**: opts
**Current**: prompt `Berî ku em bigihin, baran ___ .`, opts `['baribû', 'dibariya', 'dibare', 'bariye']`
**Issue**: `baran` is the subject of an INTRANSITIVE verb (`barîn` = "to rain"), so this is non-ergative — agent in direct case, verb agrees with subject. All four options are grammatical for `baran` as subject. Good distractor design. However the lesson NOTE ends with "Distraktor 'bariye' = yağmış (perfect)." which is correct but the note doesn't address the fact that `bariye` and `baribû` semantically overlap heavily ("has rained" vs "had rained") — for a learner the cue is `Berî ku` (= "before that") which mandates past-perfect. Note could highlight this relator.
**Suggested fix**: Note should say "`Berî ku ...` triggers past-perfect in main clause".
**Severity**: minor (pedagogy clarification)
**Reference**: [TH] §73, [BL] §175

### [FILE: b2_lesson_definitions.dart, LINE: 156–160]
**id**: b2_l02_e3
**Field**: opts/note
**Current**: prompt `Gelo wan ev ___ ?`, opts `['kiribûn', 'kiribe', 'kiriye', 'dikin']`, ci: 1, note: 'Ev' yekjimar → 'kiribe'
**Issue**: The note says "Ev yekjimar → kiribe (perfect subjunctive yekjimar)". Correct. But the prompt `wan ev kiribe` (= "they have done this") — `ev` is the demonstrative pronoun "this", which can be either yekjimar or pirjimar depending on referent. The form `kiribe` agrees with a singular object, `kiribin` with plural. The lesson teaches a singular reading, but `ev` is ambiguous. Either pin the object (`ev tişt` for clarity) or accept that `kiribin` would also be acceptable depending on interpretation.
**Suggested fix**: Change prompt to `Gelo wan ev tişt ___ ?` (explicit singular object).
**Severity**: moderate (ambiguity in test item)
**Reference**: [BL] §178

### [FILE: b2_lesson_definitions.dart, LINE: 173–177]
**id**: b2_l02_e5
**Field**: ku/opts
**Current**: prompt `Bila ew heta niha ___ .` opts include `['hatibe', 'tê', 'hat', 'bê']`, ci: 0
**Issue**: The construction `Bila ew heta niha hatibe` is grammatically valid (= "Let him have come by now"), but the natural reading of `Bila ___` is a wish/imperative. `Bila + perfect subjunctive` is uncommon in everyday Kurmanji — more often you'd see `Heger / Belkî ew heta niha hatibe` (= "perhaps he has come by now"). The use of `Bila` here is forced. Also `bê` (subjunctive 3sg of `hatin`) and `hat` (past simple) are actually more idiomatic completions of `Bila ew ___` (= "Let him come" or "he came" — past not idiomatic). The pedagogical intent is good but the example sentence is contrived.
**Suggested fix**: Replace stem with `Dibe ku ew heta niha ___` (a more natural perfect-subjunctive trigger) or `Belkî ew heta niha ___`.
**Severity**: moderate (unnatural prompt)
**Reference**: [TH] §79

### [FILE: b2_lesson_definitions.dart, LINE: 179–180]
**id**: b2_l02_e6
**Field**: ku
**Current**: `Dibe ku ew hatibe. Gelo we ev bihîstibe? Bila wan ev kiribin.`
**Issue**: The third sentence `Bila wan ev kiribin` mixes singular `ev` with plural verb `kiribin` — agreement mismatch. If `ev` refers to multiple things (e.g. "these things"), then `ev` should be `evên` or "these things" should be `ev tişt(an)`. Standard agreement: `Bila wan ev kiribe` (singular obj) or `Bila wan ev tiştan kiribin` (plural obj).
**Suggested fix**: Either `Bila wan ev kiribe` or `Bila wan ev tiştan kiribin` — pick one.
**Severity**: major (agreement error in production speech sample)
**Reference**: [BL] §178

### [FILE: b2_lesson_definitions.dart, LINE: 222–225]
**id**: b2_l03_e4
**Field**: opts/note
**Current**: prompt `Ev pirtûk di sala 1695 de ___ .`, opts `['dinivîse', 'hate nivîsîn', 'dê bête nivîsîn', 'nivîsand']`, ci: 1
**Issue**: The Bedirxan/Hawar standard form for the past-passive is `hat nivîsîn` (pre-1990s) or `hate nivîsîn` (modern). Both accepted. Distractor `'nivîsand'` is interesting — `nivîsand` is the past tense of an alternative form of `nivîsîn` (variants: `nivîsîn / nivîsandin`). With `Ev pirtûk` as subject in direct case, `nivîsand` doesn't fit because `nivîsandin` is transitive and would need oblique subject (= `Wî ev pirtûk nivîsand`). So `nivîsand` is rightly wrong here. OK, this distractor is correct as a wrong choice. Good item.
**Severity**: none — flagging for completeness only

### [FILE: b2_lesson_definitions.dart, LINE: 257–261]
**id**: b2_l04_e2
**Field**: kurmanjPrompt / tr
**Current**: prompt `Ez ji bo îmtihanê ___.` Turkish hint extensively explains "xwendin/xebitîn ayrımı"
**Issue**: The Turkish hint is a giveaway — it literally says "Xwendin (okumak) ile xebitîn (çalışmak) ayrımı önemli ... sınav genel hazırlık fiilidir." This explicitly tells the learner the answer is the "general preparation" verb, which the note clarifies is `dixebitim`. Even the option `'revîm'` (= "I fled") is a self-elimination distractor — clearly not "to study". The hint reduces this to a vocabulary recognition task, not a grammar test.
**Suggested fix**: Strip the explanatory paragraph from the Turkish hint; just give "Sınava hazırlanıyorum." Let the learner discriminate `xwendin` vs `xebitîn` from semantic context, not from the hint.
**Severity**: moderate (assessment-quality, clue leakage)

### [FILE: b2_lesson_definitions.dart, LINE: 273–277]
**id**: b2_l04_e4
**Field**: opts/note
**Current**: opts `['ji bîr kirin', 'ser ketin', 'li hev hatin', 'revîn']`, ci: 1, note "Ser ketin geçişsiz → ergatif YOK"
**Issue**: The note conflates "geçişsizlik" with non-ergativity, but the actual grammar is more nuanced. `Ser ketin` is intransitive, so its past tense doesn't take ergative — correct so far. But the form `ser ketin` itself is the **mastar**; the past 3pl would be `ser ketin` (ambiguously identical to mastar). Better to say "lê serketin" (separate) and the past `ser ketin / serket / serketin`. Also, the answer slot is the verb completing `Ew di pêşbaziyê de ___`. Using the bare mastar `ser ketin` as the answer fits, but learners may be confused as to whether it's a finite form or infinitive. Distractor `'li hev hatin'` (= "to come together / agree") is OK; `'ji bîr kirin'` (= "to forget") is OK — but mastars in answer slots create ambiguity (finite vs non-finite). Could be tightened by using past 3pl finite forms throughout: `serketin / li hev hatin / ji bîr kirin / revîn`.
**Suggested fix**: All options should be parallel finite-past 3pl forms: `serketin / li hev hatin / ji bîr kir / revîn`.
**Severity**: minor (parallelism / clarity)
**Reference**: [BL] §200

### [FILE: b2_lesson_definitions.dart, LINE: 314–319]
**id**: b2_l05_e2
**Field**: opts/note
**Current**: prompt `Ger ez dewlemend ___ , min ê mal bikira.`, opts `['bûma', 'bim', 'im', 'bûm']`, ci: 0
**Issue**: Counterfactual is correctly `Ger ez dewlemend bûma`. But the apodosis `min ê mal bikira` mixes `min ê` (which usually marks 1sg-future-ergative) with `bikira` (counterfactual past 3sg ergative). The form `min ê ... bikira` is non-standard — for counterfactual past in main clause, the form is `min ê mal bikirîya` or `min ê mal bikiriya`. Bedirxan's preferred apodosis form: `min mal bikirîya` (without future `ê`) since the `ê`-future is incompatible semantically with counterfactual. The presence of `ê` in `min ê ... bikira` is debated — some grammars accept it as a marker of conditional consequence ("would have"), others reject it.
**Suggested fix**: Either change to `min mal bikiriya` (drop `ê`) or document the dialectal variation in the note.
**Severity**: moderate
**Reference**: [BL] §190–192

### [FILE: b2_lesson_definitions.dart, LINE: 320–328]
**id**: b2_l05_e3
**Field**: ku/opts
**Current**: prompt `"Eger te gotibûya, min dê bizanibûya." tê çi wateyê?` opts include `'Söyleseydin bilirdim'`, ci: 0
**Issue**: The Kurdish sentence has `min dê bizanibûya` — using future `dê` with the counterfactual stem `bizanibûya`. This is a classic counterfactual apodosis structure but `dê` here is non-standard; many grammars consider `min bizanibûya` (without `dê`) the canonical form. The Turkish translation "bilirdim" matches `bizanibûya`. But the use of `dê` is inconsistent with #b2_l05_e2 above where the apodosis uses `min ê ... bikira` (also with `ê`/dê). Inconsistency aside, neither is the cleanest BL counterfactual.
**Suggested fix**: Standardize across lesson 5 — either always use `dê + verb-stem-bûya` or never. Cleanest: always omit `ê/dê` in counterfactual apodosis.
**Severity**: moderate (inconsistency)
**Reference**: [BL] §192

### [FILE: b2_lesson_definitions.dart, LINE: 348–349]
**id**: b2_l05_e6 (speaking)
**Field**: ku
**Current**: `Ger ez li şûna te bûma, min ê cuda bikira. Eger pîrê hatibûya, em ê şa bibûyana.`
**Issue**: Same `ê + counterfactual` pattern critique. `min ê cuda bikira` should be `min cuda bikiriya`. `em ê şa bibûyana` — the verb `bibûyana` is 1pl counterfactual of `bûn` ("we would have been"). The form `bibûyana` is an attested counterfactual paradigm, but combining with `em ê` (1pl future) is again the apodosis-with-`ê` issue. Choose one paradigm.
**Suggested fix**: Use `min cuda bikiriya` and `em şa bibûyana` (no `ê/dê`).
**Severity**: moderate (consistency in production model)
**Reference**: [BL] §192

### [FILE: b2_lesson_definitions.dart, LINE: 391–393]
**id**: b2_l06_e4
**Field**: note
**Current**: `"Ji ber ku" = çünkü. Sedem bağlacı + dema niha.`
**Issue**: Note says "Ji ber ku + dema niha" but `ji ber ku` can take ANY tense — present, past, perfect, future. Restricting to "dema niha" is misleading and pedagogically wrong. Example: `Ji ber ku ew hat, ez şa bûm` (= because he came, I was happy — past tense). The note over-narrows the rule.
**Suggested fix**: Change note to `"Ji ber ku" = çünkü. Sedem bağlacı + uygun zaman.`
**Severity**: moderate (factually wrong grammar rule)
**Reference**: [BL] §240, [TH] §discourse

### [FILE: b2_lesson_definitions.dart, LINE: 414, 419–428]
**id**: b2_l07_e1
**Field**: opts
**Current**: prompt "Rojname" + question "Ne anlama geliyor?", opts include `'Pirtûk rojane, kaxiza nûçeyan'`
**Issue**: The correct option `'Pirtûk rojane, kaxiza nûçeyan'` is awkward Kurdish. Literally "Daily book, paper of news". `Pirtûk rojane` is unusual collocation — `pirtûk` (book) + `rojane` (daily) is not the natural way to define a newspaper. Standard: `Kovara rojane` or `nivîsa rojane bi kaxezê / li ser kaxezê`. The current option reads like it was machine-translated or awkwardly written.
**Suggested fix**: Replace with `'Weşana rojane ya nûçeyan'` (= "Daily publication of news") or `'Belavoka nûçeyan a rojane'`.
**Severity**: moderate (unnatural Kurdish in test item)
**Reference**: register

### [FILE: b2_lesson_definitions.dart, LINE: 451–456]
**id**: b2_l07_e5
**Field**: opts/note
**Current**: prompt `___ medyayê di civakê de girîng e.`, opts `['Rol', 'Role', 'Rola', 'Rolê']`, ci: 2
**Issue**: Good item testing ezafe. Answer `Rola` (dişil ezafe of `rol`) is correct. But the note says `"Rol mê → ezafa binavkirî 'Rola' + medyayê (mê oblique). [BH] §160"`. The phrase "ezafa binavkirî" means "definite ezafe" — but `-a` is the dişil DEFINITE ezafe (as opposed to indefinite `-eke`). Note is correct in essence but the term "binavkirî" is correct. Minor flag: clarify for learners.
**Severity**: none — actually correct; flagging only because terminology may confuse
**Reference**: [BL] §160

### [FILE: b2_lesson_definitions.dart, LINE: 489–493]
**id**: b2_l08_e3
**Field**: opts
**Current**: prompt `Mafê ___ mafekî bingehîn e.`, opts `['derbirînê', 'bîr û rayê', 'nivîsandinê', 'axaftinê']`, ci: 0
**Issue**: All four options are semantically related (expression / opinion / writing / speech). The intended answer `derbirînê` (= "expression") is correct for "ifade hakkı" (right of expression). But `axaftinê` (= "speech") is also a valid translation of "freedom of speech / expression" — both are accepted in Kurdish discourse. The item is ambiguous: there is no single right answer.
**Suggested fix**: Either accept both `derbirînê` and `axaftinê` (two correct answers) — which means the multiple choice format is wrong here — or change one option to make `derbirînê` uniquely best.
**Severity**: major (double-correct answer)
**Reference**: assessment quality

### [FILE: b2_lesson_definitions.dart, LINE: 501–505]
**id**: b2_l08_e5
**Field**: opts
**Current**: prompt `Azadiya ___ ji bo demokrasiyê pêwîst e.`, opts `['axaftinê', 'matbûatê', 'çapê', 'ragihandinê']`, ci: 2 ("çapê")
**Issue**: All four options are valid words that can complete `Azadiya ___` = "freedom of (X)". `Azadiya axaftinê` = freedom of speech. `Azadiya çapê` = freedom of press. `Azadiya ragihandinê` = freedom of media/communication. `Azadiya matbûatê` = freedom of press (Arabic-loan). All four are CORRECT collocations in Kurdish. The Turkish "Basın özgürlüğü" (freedom of press) maps to BOTH `çapê` AND `matbûatê`. This is a double-correct issue.
**Suggested fix**: Change Turkish to specifically "Matbaa özgürlüğü" (printing-press only) OR remove `matbûatê` from options.
**Severity**: major (double-correct)

### [FILE: b2_lesson_definitions.dart, LINE: 536–540]
**id**: b2_l09_e2
**Field**: ku/opts
**Current**: prompt `Ev lêkolîn ___ Prof. Bedirxan ve hate çêkirin.`, opts `['li ser', 'bi rêya', 'li aliyê', 'ji aliyê']`, ci: 3
**Issue**: Critical: the `ve` postposition at the end of `Prof. Bedirxan ve` is paired with the preposition. Standard pattern: `ji aliyê X ve` (= "by X / from the side of X"). The blank fills `ji aliyê` which is correct. But option 2 `'li aliyê'` is a plausible distractor that creates `li aliyê X ve` — which is NON-STANDARD; `li aliyê X` (without `ve`) means "on X's side / on the side of X". The construction with `ve` is `JI aliyê ... ve` (passive agent), not `li aliyê ... ve`. So the distractor `li aliyê` would yield ungrammatical Kurdish — hence wrong, but a learner might pick it. Good item.
**Severity**: none — actually OK; flagging the design as good
**Reference**: [BL] §220

### [FILE: b2_lesson_definitions.dart, LINE: 553–556]
**id**: b2_l09_e4
**Field**: ku
**Current**: prompt `Em statîstîkê ji bo analîzkirinê ___.`
**Issue**: `Em statîstîkê` — `statîstîk` is dişil but the form `statîstîkê` uses the oblique singular (`-ê`). However the agent `Em` (we) is in direct case, and `statîstîk` is the OBJECT — bare direct objects (when not preceded by preposition) typically don't take oblique. So either `Em statîstîk(an) ji bo analîzkirinê bikar tînin` (no oblique) or `Em statîstîkê ji bo analîzkirinê bikar tînin` (treating it as definite oblique). With `bikar tînin`, the object usually does take oblique because `bikar tînin` = "bring into use". OK to mark `-ê` here. Acceptable.
**Severity**: none — flagging style only

### [FILE: b2_lesson_definitions.dart, LINE: 658–662]
**id**: b2_l11_e4
**Field**: opts/note
**Current**: prompt `Bekirê Mergaver ___ di navbera Mem û Zîn de çêkir.`, opts `['bextiyarî', 'evîn', 'şadî', 'dubendî']`, ci: 3, note: "Ergatifte berbijêr halê xwerû de ye"
**Issue**: The note says "Ergatif kirde + berbijêr halê xwerû". This is correct: in ergative, the agent is oblique (`Bekirê Mergaver` is treated as oblique-eril), and the object (`dubendî`) is in direct case (xwerû). Good. BUT the form `Bekirê Mergaver` is itself an ezafe phrase ("Bekir of Mergaver"). The oblique form would normally be `Bekirê Mergaver(î)` — but for proper nouns the marking is loose. Acceptable. Note correctly explains the rule.
**Severity**: none

### [FILE: b2_lesson_definitions.dart, LINE: 712–714]
**id**: b2_l12_e3
**Field**: ku/opts
**Current**: prompt `Mela Cizîrî li ___ hat dinê.`, opts `['Stembolê', 'Hewlêrê', 'Cizîrê', 'Diyarbekirê']`
**Issue**: The construction `hat dinê` (= "came to the world / was born") is idiomatic. The locative `li Cizîrê` precedes it. Good item. But `Stembolê` is the Kurdish form for "Istanbul" — a creative variant; the most common form is `Stenbol` or `Îstanbul`. Acceptable variant. Minor flag.
**Severity**: none

### [FILE: b2_lesson_definitions.dart, LINE: 720–726]
**id**: b2_l12_e5
**Field**: opts/note
**Current**: prompt `Helbestên wî bi ___ ne.`, opts `['axaftinê', 'kêşa erûz', 'pêxwas', 'bê pîvan']`, ci: 1, note: `"Kêşa erûz" = aruz vezni`
**Issue**: The form `kêşa erûz` is ezafe construction. `kêş` (meter) + `-a` (dişil ezafe) + `erûz` (aruz). Correct gender (`kêş` is dişil). But the option as written `'kêşa erûz'` — the trailing `erûz` should arguably take oblique to be consistent with idiomatic usage: `kêşa erûzê` (definite). The bare `erûz` is acceptable as a proper-noun-like term. Minor flag.
**Severity**: minor (stylistic)

### [FILE: b2_lesson_definitions.dart, LINE: 769–773]
**id**: b2_l13_e5
**Field**: ku
**Current**: prompt `Cegerxwîn di 1984 de li ___ çû rehmetê.` — "1984'te İsveç'te vefat etti."
**Issue**: `di 1984 de` — common but somewhat colloquial. Standard form: `di sala 1984an de` (= "in the year 1984"). Bare numeral inside `di ... de` is acceptable but more academic register prefers the full `sala 1984an`.
**Severity**: minor (register)

### [FILE: b2_lesson_definitions.dart, LINE: 803–805]
**id**: b2_l14_e1
**Field**: opts
**Current**: opts `['Şîroveya kesane ya nivîskêr li ser bûyerê', 'Sernivîs û paragrafa pêşî (lead)', 'Wêneyek mezin a bûyerê di rûpela pêşî de', 'Îmza û navê nivîskêr di binê nivîsê de']`
**Issue**: All four options are gramatically OK and content-wise plausible. Good design. But option 0 has `nivîskêr` (with `ê`) and option 3 has `nivîskêr` again — the correct form is `nivîskar` (from `nivîs` + `-kar`); `nivîskêr` is non-standard. Should be `nivîskar` consistently. Bedirxan/standard form is `nivîskar`.
**Suggested fix**: Replace `nivîskêr` → `nivîskar` (both occurrences).
**Severity**: moderate (lexical error)
**Reference**: [BL] §273

### [FILE: b2_lesson_definitions.dart, LINE: 822–826]
**id**: b2_l14_e4
**Field**: opts
**Current**: prompt `Nûçe di rojnameya ___ de hate weşandin.`, opts `['kevn', 'dîjîtal', 'sar', 'xewle']`
**Issue**: `xewle` (= "secret/hidden") is an awkward distractor for "in the X newspaper". `Sar` (= cold) and `kevn` (= old) are at least newspaper-modifiable adjectives. `Xewle` doesn't naturally collocate with newspaper. Weak distractor — easy elimination.
**Suggested fix**: Replace `'xewle'` with a stronger semantic competitor like `'çapî'` (printed) or `'mehane'` (monthly).
**Severity**: minor (weak distractor)

### [FILE: b2_lesson_definitions.dart, LINE: 882–885]
**id**: b2_l15_e4
**Field**: opts/note
**Current**: prompt `Encam ___ ku hîpotez rast e.`, opts `['nîşan da', 'got', 'dipejirîne', 'bihîst']`, ci: 0
**Issue**: `Encam nîşan da ku ...` — `Encam` is the subject (= "Result"), and `nîşan da` is past 3sg ("showed"). But `nîşan dan` is a TRANSITIVE compound verb; in past tense it requires ergative subject. Is `Encam` here an ergative agent? `Encam` is dişil/eril? In Kurmancî, `encam` is treated as eril (n.m.). The eril oblique of `encam` is `encamê` in def, but `encam` bare can serve as topical subject. Strict ergative would require `Encamê nîşan da` with the agent in oblique. Standard Bedirxan would prefer the passive: `Hate nîşandan ku hîpotez rast e` (= "It was shown that..."). The active `Encam nîşan da` is colloquial.
**Suggested fix**: Either accept colloquial form (and add note) or rewrite as passive `Hate nîşandan ku ...`.
**Severity**: moderate (ergative subject not properly marked)
**Reference**: [BL] §170

---

## SECTION C — B1 VOCABULARY DATABASE (`b1_kelime_db.dart`)

### [FILE: b1_kelime_db.dart, LINE: 296]
**id**: b1_061
**Field**: ez (ezafe)
**Current**: `ku:"Helbestvan", ... cins:"bêcins", ez:"helbestvana"`
**Issue**: `Helbestvan` (poet) is `bêcins` (genderless / common gender) per the entry, but the ezafe form `helbestvana` is dişil. For genderless agent nouns, the convention is to provide both eril (`helbestvanê`) and dişil (`helbestvana`) forms — the entry only gives dişil, which is inconsistent. Entry b1_710 (line 1212) gives `ez:"helbestan"` for the same word — that form looks like a plural ezafe (`helbestan` = "şiirlerin"), which is wrong; should be `helbestvanê` or `helbestvana`. Two entries for "helbestvan" with different (and inconsistent) ezafes is bad.
**Suggested fix**: Decide on one ezafe form (`helbestvanê` for default eril, with note about dişil); deduplicate b1_061 / b1_710.
**Severity**: moderate (inconsistency / wrong ezafe in b1_710)
**Reference**: [BL] §145

### [FILE: b1_kelime_db.dart, LINE: 261, 264]
**id**: b1_054
**Field**: cins/ez
**Current**: `ku:"Dewlet", cins:"mê", ez:"dewletê"`
**Issue**: `Dewlet` is correctly marked dişil, but Bedirxan-Lescot also lists `dewlet` as eril in some old sources due to Arabic origin. Modern standard (Hawar / Institut Kurde): dişil. The entry is correct, but worth flagging that some learners encounter eril usage in older texts.
**Severity**: none — flagging note for completeness

### [FILE: b1_kelime_db.dart, LINE: 297–299]
**id**: b1_061
**Field**: her (örnek cümle)
**Current**: `her:["Helbestvanê kurd.", "Cegerxwîn helbestvanek bû."]`
**Issue**: Second example `Cegerxwîn helbestvanek bû` — the predicate noun `helbestvanek` is indefinite (-ek), so the sentence reads "Cegerxwîn was a poet". Grammatically OK. But for B1 illustration of `helbestvan` we'd expect a more diagnostic sentence: `Cegerxwîn helbestvanekî mezin bû` (= "Cegerxwîn was a great poet") to show the indef-eril ezafe `-î`. As written, the sentence doesn't showcase ezafe morphology.
**Suggested fix**: Expand example to use ezafe: `Cegerxwîn helbestvanekî mezin bû.`
**Severity**: minor (pedagogy)

### [FILE: b1_kelime_db.dart, LINE: 314–317]
**id**: b1_064
**Field**: cins/her
**Current**: `ku:"Destpêk", cins:"nêr", ez:"destpêkê"`, example "Destpêkê jiyanê xweş e."
**Issue**: Example `Destpêkê jiyanê xweş e.` — `destpêkê` (with `-ê`) is the locative/oblique form. As subject of `xweş e`, it should be `Destpêka jiyanê xweş e` (= "The beginning of life is good") with the dişil ezafe `-a`... but the entry says `destpêk` is eril. So the eril ezafe is `-ê`: `destpêkê jiyanê xweş e` — that's fine if the noun is functioning as a definite oblique. But as subject of a copula clause, the noun is in direct case, so should be `Destpêk jiyanê xweş e` — but `destpêk + jiyanê` is an ezafe phrase ("beginning of life"), so we DO need an ezafe linker. With eril `destpêk` the linker is `-ê`: `Destpêkê jiyanê xweş e` ≠ that's correct. OK actually this example is fine.
**Severity**: none

### [FILE: b1_kelime_db.dart, LINE: 379–381]
**id**: b1_083
**Field**: ez
**Current**: `ku:"Kurd", cins:"bêcins", ez:"kurdê/kurda"`
**Issue**: Good — provides both eril and dişil ezafes for genderless agent noun. Inconsistent with b1_061 (only one form given). Standardize.
**Severity**: minor (consistency issue)

### [FILE: b1_kelime_db.dart, LINE: 388–393]
**id**: b1_085
**Field**: cins/ez/note
**Current**: `ku:"Têkçûn", tr:"Asimilasyon / Dilde erime", cins:"nêr", ez:"asimilasyonê"`
**Issue**: The `ez` field shows `asimilasyonê` — but the `ku` headword is `têkçûn` (Kurdish). The ezafe form provided (`asimilasyonê`) is for the LOAN word `asimilasyon`, not for `têkçûn`. The correct ezafe of `têkçûn` (n.m.) would be `têkçûnê` or `têkçûnê`. This is a data error: the `ez` field is for the wrong lemma.
**Suggested fix**: Change `ez:"asimilasyonê"` → `ez:"têkçûnê"`.
**Severity**: major (data/morphology error)

### [FILE: b1_kelime_db.dart, LINE: 411–415]
**id**: b1_092
**Field**: her
**Current**: `'Serbilindî ya min welatê min e.'`
**Issue**: The form `Serbilindî ya min` uses the dişil ezafe `-ya` after `serbilindî`. `Serbilindî` ends in `-î`, so the ezafe is correctly `-ya` (postvocalic). However, the entry on line 412 says `ez:"serbilindiyê"` (oblique of `serbilindî`), but the example example uses `serbilindî ya min` — this is the EZAFE form, not the OBLIQUE; both are correct in different contexts. Minor concern: the example's spacing `Serbilindî ya min` should arguably be `Serbilindîya min` (one word). Bedirxan style: ezafe is written attached.
**Suggested fix**: `Serbilindîya min` (no space).
**Severity**: minor (orthography)
**Reference**: [BL] §150

### [FILE: b1_kelime_db.dart, LINE: 442–443]
**id**: b1_102
**Field**: not (grammarNote)
**Current**: `"Vêxistin" — "Kawa agirê azadiyê vêxist" Newroz efsanesinden!`
**Issue**: `Kawa agirê azadiyê vêxist` is past transitive — `Kawa` should be in OBLIQUE (ergative). The form `Kawa` is direct/xwerû. Standard ergative: `Kawayî agirê azadiyê vêxist`. Newroz efsanesinden alıntı yapan örnek ergatif kuralını ihlal ediyor. Worth a fix.
**Suggested fix**: `Kawayî agirê azadiyê vêxist.` — or for proper-noun acceptability `Kawa agirê azadiyê vêxist` with note that proper-noun ergative marking is loose.
**Severity**: moderate (ergative)
**Reference**: [BL] §170

### [FILE: b1_kelime_db.dart, LINE: 460]
**id**: b1_105
**Field**: not
**Current**: `"Veguhêztin" — dil ve kültürü aktarma anlamında ... "Zimanê xwe veguherîzin" = dilinizi aktarın`
**Issue**: The form `veguherîzin` is wrong. The 2pl-imperative of `veguhêztin` would be `veguhêzin` (= "transfer it!" plural). The form `veguherîzin` mixes `guhertin` (to change) with `veguhêztin` (to transfer) — these are different verbs. `Guhêztin` ≠ `guhertin`.
**Suggested fix**: Change to `Zimanê xwe veguhêzin!` (correct imperative of `veguhêztin`).
**Severity**: major (wrong verb form in pedagogical example)
**Reference**: [TH] §65

### [FILE: b1_kelime_db.dart, LINE: 596]
**id**: b1_211
**Field**: not
**Current**: `... DÜZELTME: Önceki örnek "Em hevdu dibikin" yanlış fiil çekimiydi (dibikin diye bir form yok).`
**Issue**: Self-acknowledged correction. Note documents past error. OK as is.
**Severity**: none

### [FILE: b1_kelime_db.dart, LINE: 460–465]
**id**: b1_211
**Field**: her
**Current**: `her:["Em ji hev hez dikin.", "Wan hev dît."]`
**Issue**: `Wan hev dît` — `Wan` is oblique-3pl (ergative agent), `hev` is reciprocal pronoun (= "each other"). Verb `dît` is 3sg past — but reciprocal pronoun usually triggers plural agreement. Standard: `Wan hev dîtin` (= "they saw each other"). The 3sg `dît` doesn't agree with the reciprocal pronoun's plural reference. Tighten.
**Suggested fix**: `Wan hev dîtin.` (3pl).
**Severity**: moderate (agreement)
**Reference**: [BL] §178

### [FILE: b1_kelime_db.dart, LINE: 661]
**id**: b1_231
**Field**: her/not
**Current**: `her:["Em ji bo zimanê xwe têkoşîn.", "Ew têkoşer e."]`
**Issue**: `Em ji bo zimanê xwe têkoşîn` — `têkoşîn` is the mastar (infinitive). The example needs a finite verb form: `Em ji bo zimanê xwe têdikoşin` (1pl present) or `Em ji bo zimanê xwe têkoşiyan` (1pl past). As written, the sentence is a fragment.
**Suggested fix**: `Em ji bo zimanê xwe têdikoşin.` (= "We struggle for our language").
**Severity**: major (fragment / no finite verb)

### [FILE: b1_kelime_db.dart, LINE: 686–688]
**id**: b1_240
**Field**: her
**Current**: `her:['Gelê me bi zimanê xwe yekîtî ye.', 'Gel di şahiyê de bi hev re ye.']`
**Issue**: `Gelê me bi zimanê xwe yekîtî ye` — `yekîtî` is a noun (= "unity"). The structure says `Gel + bi ziman + yekîtî` — this can be parsed as a copula construction "Our people IS unity through its language" — odd. More natural: `Gelê me bi zimanê xwe re yek e` (= "Our people is one with its language") or `Gelê me bi zimanê xwe yekîtiya xwe diparêze` (= "preserves its unity"). As written it reads disjointed.
**Suggested fix**: Reword to a more natural construction.
**Severity**: minor (awkwardness)

### [FILE: b1_kelime_db.dart, LINE: 720]
**id**: b1_250
**Field**: ez
**Current**: `cins:"mê", ez:"serhildana"`
**Issue**: For dişil noun the OBLIQUE form is `serhildanê` (not `serhildana`). The form `serhildana` is the EZAFE (definite dişil). The entry has confused ezafe with oblique. All other dişil entries in the file use `-ê` for the `ez` field (e.g. `azadiyê`, `aştiyê`, `welatê`). Standardize.
**Suggested fix**: `ez:"serhildanê"`.
**Severity**: major (data error — wrong morphological category)
**Reference**: [BL] §145

### [FILE: b1_kelime_db.dart, LINE: 738]
**id**: b1_253
**Field**: ku/ez
**Current**: `ku:"Nasnameya cot", ez:"nasnameyê"`
**Issue**: The headword is the multi-word phrase `nasnameya cot` (= "dual identity"). The `ez` field gives `nasnameyê` — which is the oblique of just `nasname` (the head noun), not of the full phrase. Inconsistent with how other phrasal entries handle ezafe (sometimes giving the head's oblique, sometimes the phrase's). Either fix or document policy.
**Severity**: minor (consistency)

### [FILE: b1_kelime_db.dart, LINE: 743–747]
**id**: b1_254
**Field**: ez
**Current**: `ku:"Hafiza", cins:"mê", ez:"hafizê"`
**Issue**: `Hafiza` is dişil. Oblique should be `hafizayê` (with `-ya-` since the stem ends in vowel `-a`). The form `hafizê` is wrong morphology — drops the `-ya-` linker. Standard Bedirxan: stems ending in `-a` insert `-ya-` before oblique `-ê`: `hafiza → hafizayê`. Compare: `cîhan → cîhanê` (stem ends in consonant, no linker), `aboriya → aboriyê` (stem ends in `-î`, uses `-ya-` then `-ê`).
**Suggested fix**: `ez:"hafizayê"`.
**Severity**: major (morphology error)
**Reference**: [BL] §145–148

### [FILE: b1_kelime_db.dart, LINE: 1126]
**id**: b1_663
**Field**: ku/ez
**Current**: `ku:"Faîz", ... ez:"faîzê"` and gen example `"Faîz û sermiaye"`
**Issue**: `Sermiaye` (in gen example) — the headword for sermaye is `b1_122 / b1_1094` with `ku:"Sermaye"` or `Sermiaye`. Multiple spellings used: `sermaye / sermiaye`. Inconsistency.
**Severity**: minor (consistency across entries)

### [FILE: b1_kelime_db.dart, LINE: 1128–1132]
**id**: b1_664
**Field**: ez
**Current**: `ku:"Bûçe", cins:"mê", ez:"bûçê"`
**Issue**: For dişil noun ending in `-e`, oblique is `-ê` after dropping `-e`: `bûçe → bûçeyê` or just `bûçê` (with `-e → -ê`). Both attested. Bedirxan-Lescot prefers `bûçeyê` for clarity; modern usage allows `bûçê`. Acceptable but flag.
**Severity**: none — both attested

### [FILE: b1_kelime_db.dart, LINE: 1311–1315]
**id**: b1_405
**Field**: id duplication
**Current**: `b1_405` for `Pêkanîn` (line 1313) — but `b1_600` (line 920) is also `Pêkanîn`.
**Issue**: Duplicate entries for the same lexeme `Pêkanîn` with different IDs. `b1_600` and `b1_405` both define it. Database hygiene problem.
**Severity**: moderate (data hygiene — duplicate)

### [FILE: b1_kelime_db.dart, LINE: 1583]
**id**: b1_500
**Field**: not
**Current**: `not:"Dişil ... DÜZELTME: Önceki başlık 'hejmara' ezafe formuydu; temel form 'hejmar'."`
**Issue**: Note documents previous fix but the gen example `"Hejmara me"` still uses the (correct) ezafe form. Internal consistency.
**Severity**: none

### [FILE: b1_kelime_db.dart, LINE: 1659–1660]
**id**: b1_801
**Field**: ez
**Current**: `ku:"Hestî", cins:"nêr", ez:"hestiyê"`
**Issue**: `Hestî` (n.m.) ending in `-î` — oblique is formed by adding `-yê` (vowel-final stem): `hestî → hestiyê`. Correct. But the example `Hestiyê min şikî` ("my bone broke") uses `hestiyê` (definite oblique) as the SUBJECT of intransitive `şikîn` (to break). For an intransitive past, the subject is in DIRECT case: should be `Hestî yê min şikî` (with ezafe `-yê` to link `min`) — wait, that's what's there. `Hestiyê min` = `hestî + ezafe -yê + min` ("the bone of mine"). So this is the definite ezafe phrase, not the oblique. As subject of past intransitive, it's in direct case (the ezafe form is invariant). OK.
**Severity**: none

### [FILE: b1_kelime_db.dart, LINE: 1685–1687]
**id**: b1_805
**Field**: not
**Current**: `cins:"mê", ez:"nesaxiyê", ... not:"\"ne\" + \"sax\" + \"-î\""`
**Issue**: Etymology note says `ne + sax + -î`, fine. But `nesaxî` is more accurately "sicklikness/illness" not "disability/Sakatlık-Engel" (the Turkish gloss). Disability is closer to `kêmasîya laşî / kêmasî` or `astengî`. `Nesax` is just "sick", `nesaxî` is "sickness". The Turkish translation overreaches.
**Suggested fix**: Change tr to "Hastalık / Rahatsızlık" or use a different Kurdish word for "disability".
**Severity**: moderate (semantic mismatch)

### [FILE: b1_kelime_db.dart, LINE: 1733–1738]
**id**: b1_823
**Field**: ku/her
**Current**: `ku:"Dixwartin", tr:"Yediriyordum", her:["Min zarokê dixwartin.", "Pîrê min dixwartin."]`
**Issue**: `Dixwartin` is presented as "I was feeding" (1sg). But `dixwartin` is the 3pl OR mastar form. The 1sg would be `dixwartim` (or `dixwand` in some dialects, but for ettirgen `xwartin` it's `dixwartim`). The headword `dixwartin` doesn't match the gloss "Yediriyordum" (1sg).
Also examples are confused: `Min zarokê dixwartin` uses 1sg ergative `Min` with verb `dixwartin` (3pl) — wrong agreement; should be `dixwart` (3sg) if `zarokê` is one child, or `dixwartin` if multiple children. With singular child: `Min zarokê dixwart`. The note is missing.
**Suggested fix**: Either change headword to `Dixwartim` (1sg) or fix examples to match 3pl.
**Severity**: major (form/gloss mismatch)
**Reference**: [TH] §70

### [FILE: b1_kelime_db.dart, LINE: 1772]
**id**: b1_840
**Field**: ku/ez
**Current**: `ku:"Serhedê"` (with -ê) but `ez:"Serhedê"`
**Issue**: The headword `Serhedê` already includes the oblique/ezafe `-ê`. So when ezafe-marked: `Serhedê` (oblique). Bare form: `Serhed`. The headword should be the bare form `Serhed`, not `Serhedê`. This is a data structuring inconsistency — other geographical names (e.g. `Botan`) give bare form as headword.
**Suggested fix**: `ku:"Serhed", ez:"Serhedê"`.
**Severity**: moderate (data structure)

### [FILE: b1_kelime_db.dart, LINE: 1801]
**id**: b1_845
**Field**: ku/ez
**Current**: `ku:"Kobanê", ez:"Kobanê"`
**Issue**: Same issue — headword `Kobanê` is already inflected. The bare form is `Kobanî` (with `-î` adjectival suffix) or just `Kobanê / Kobanî`. The traditional Kurdish name is `Kobanê` (already final). Acceptable as proper noun. Less of a structuring issue here.
**Severity**: minor (gray area for proper noun)

### [FILE: b1_kelime_db.dart, LINE: 1846–1849]
**id**: b1_862
**Field**: ku/her
**Current**: `ku:"Mathera", her:["Mathera mezin e.", "Di matherê de ne."]`
**Issue**: `Mathera` (= "mourning") — Bedirxan/standard: `mathem` (Arabic origin) or `şîn`. The form `mathera` (with -a) looks like it's already a definite form. Bare form would be `mathem`. The example `Di matherê de ne` uses `matherê` (oblique of `mather`?) — unclear. Spelling inconsistent. `Mathera` not standard; `mateme / mathema` more common in dictionaries.
**Severity**: moderate (lexical/orthographic uncertainty)

### [FILE: b1_kelime_db.dart, LINE: 1986]
**id**: b1_911 (compared to b1_910)
**Field**: cins/note
**Current**: `b1_911: ku:"Pispor"` ezafe `pisporê` — but b1_911 says it's "uzman" while b1_910 `Karîger` also "Yetenekli/Uzman". Overlap.
**Issue**: Two near-synonyms `Karîger` and `Pispor` listed as both meaning "Uzman". Differentiate in note.
**Severity**: minor

### [FILE: b1_kelime_db.dart, LINE: 2125]
**id**: b1_1012
**Field**: ku/her
**Current**: `ku:"Bideng", tr:"Ünlü"`, example `"\"a\" bidengek e."`
**Issue**: `bideng` is described as "vowel". Etymology: `bi + deng` = "with sound". This is an unusual coining. Bedirxan standard term for vowel is `dengdêr` (= "voiced") or `bideng` in some texts. `Dengdar` (b1_1011) is given as "consonant" — also unusual. Bedirxan p.265 actually uses `dengdêr` for vowel and `dengdar` for consonant — note correctly flags this. Some inconsistency between Bedirxan editions. Flag.
**Severity**: minor (terminological variation across grammars)
**Reference**: [BL] §265

### [FILE: b1_kelime_db.dart, LINE: 2155–2160]
**id**: b1_1023
**Field**: ku
**Current**: `ku:"Sîyaset"` — vowel `î` 
**Issue**: Spelling: `sîyaset` vs standard `siyaset`. The vowel `î` indicates long /iː/, but in this Arabic loanword the vowel is short. Standard Hawar orthography: `siyaset` (no `î`). Cf. b1_1024 has `sîyaset` (line 2156), but b2_114 (b2_kelime_db) has `siyaset` (line 467) — inconsistent across files.
**Suggested fix**: Standardize to `siyaset`.
**Severity**: moderate (orthography inconsistency cross-file)

### [FILE: b1_kelime_db.dart, LINE: 2294]
**id**: b1_1070
**Field**: not (correction text)
**Current**: `... DÜZELTME: Ezafe "bawermendiyê" olmalı.`
**Issue**: The note documents the correction; the current ez field has `bawermendiyê` — correct. OK.
**Severity**: none

### [FILE: b1_kelime_db.dart, LINE: 2348]
**id**: b1_1084
**Field**: ez
**Current**: `ku:"Zimanê zikmakî", cins:"nêr", ez:"zimanê zikmakî"`
**Issue**: `ez` field repeats the headword as-is. For phrasal entries this is sometimes done, but the actual oblique should mark the head: `Di zimanê zikmakî de` already uses ezafe. If `ez` is for "ezafe form", `zimanê zikmakî` is already the ezafe. Acceptable for phrases but inconsistent across the database.
**Severity**: minor (consistency)

### [FILE: b1_kelime_db.dart, LINE: 2380]
**id**: b1_1094
**Field**: ku/ez
**Current**: `ku:"Sermiaye", ez:"sermiayê"` — but also `b1_122` line 510 `ku:"Sermaye", ez:"sermayê"`
**Issue**: Duplicate entries with different spellings. `Sermiaye` vs `Sermaye`. Pick one.
**Severity**: moderate (duplicate / inconsistent spelling)

### [FILE: b1_kelime_db.dart, LINE: 2479–2483]
**id**: b1_1141
**Field**: ku/cins/her
**Current**: `ku:"Meşgûl", cins:"bêcins", her:["Ez meşgûl me.", "Tu meşgûl î?"]`
**Issue**: `Meşgûl` is a sıfat (predicative adjective). Marked `bêcins` correctly (adjectives don't have gender). But the second example `Tu meşgûl î` — the copula `î` is 2sg. Correct. Good item.
**Severity**: none — flag for completeness

### [FILE: b1_kelime_db.dart, LINE: 2540]
**id**: b1_1202
**Field**: ku/ez
**Current**: `ku:"Lorî", ez:"loriyê"`
**Issue**: `Lorî` = "ninni" (lullaby). For `lorî` (dişil, ending in `-î`), oblique is `loriyê` (vowel-final stem inserts `-y-`). Correct.
**Severity**: none

### [FILE: b1_kelime_db.dart, LINE: 3055–3057]
**id**: b1_g04
**Field**: ku/not (corrected note)
**Current**: `ku:"Destmala serî"`, note: `Dişil — "destmal" (mendil/bez, mê) + "serî" (başın). DÜZELTME: Önceki "destmalê serê" eril ezafeyle yanlış yapıldı; destmal dişil olduğu için doğru ezafe "destmala" dır.`
**Issue**: Self-corrected. Note acknowledges previous error. But cross-check: `b1_c06b` (line 3604) gives `Destmal` as `cins:"nêr"` — direct contradiction with `b1_g04` saying `destmal` is dişil. Pick one and standardize.
**Severity**: major (gender contradiction across entries)

### [FILE: b1_kelime_db.dart, LINE: 3604–3607]
**id**: b1_c06b
**Field**: cins
**Current**: `ku:"Destmal", cins:"nêr"`
**Issue**: See above — contradicts b1_g04. Bedirxan-Lescot lists `destmal` as dişil (n.f.). Wahby & Edmonds dictionary also dişil. Should be `mê`.
**Suggested fix**: Change `cins:"nêr"` → `cins:"mê"` for consistency.
**Severity**: major (wrong gender)
**Reference**: [BL] dictionary

### [FILE: b1_kelime_db.dart, LINE: 3553–3557]
**id**: b1_m18
**Field**: ku/ez
**Current**: `ku:"Carixa", cins:"mê", ez:"carixê"` — but `gen:["Carixa û mase", "Carixeya me"]`
**Issue**: `Carixa` already includes the `-a` ezafe; bare form is `Carix`. Should headword be `Carix`? Compare `b1_g04` vs naming. Also `Carixeya me` in gen — adding another `-ya` to already-ezafed `carixa` makes `carixeya` — over-marked. Inconsistent treatment of phrase as base word.
**Severity**: moderate (data structure — ezafe in headword)

### [FILE: b1_kelime_db.dart, LINE: 3656–3663]
**id**: b1_r05
**Field**: gen
**Current**: `gen:["Qeseregeh û balafirgehê", "Qeserehêya bajêr"]`
**Issue**: Typo: `Qeserehêya` should be `Qeseregeha` (definite ezafe of `qeseregeh`, dişil). The `-h-` got dropped and `-ê-` became `-êya`. Looks like an OCR/typo artifact.
**Suggested fix**: `Qeseregeha bajêr`.
**Severity**: moderate (typo)

### [FILE: b1_kelime_db.dart, LINE: 3672–3675]
**id**: b1_r07
**Field**: ku/cins
**Current**: `ku:"Kolan", cins:"mê", ez:"kolanê"`
**Issue**: `Kolan` is marked dişil. Bedirxan lists `kolan` as dişil — correct. But many sources also list it as eril. Standardize.
**Severity**: minor (variation)

### [FILE: b1_kelime_db.dart, LINE: 3760–3768]
**id**: b1_tk02
**Field**: ku/ez
**Current**: `ku:"Înternetê", ez:"înternetê"`
**Issue**: Headword `Înternetê` already includes oblique `-ê`. Bare form: `Înternet`. Cf. comments above on `Serhedê / Cibanê` — same data structure problem.
**Suggested fix**: `ku:"Înternet", ez:"înternetê"`.
**Severity**: moderate (consistency)

### [FILE: b1_kelime_db.dart, LINE: 4072–4076]
**id**: b1_d12
**Field**: not
**Current**: `... DÜZELTME: Önceki "kêvroşk" Soranî yazımı içeriyordu; Kurmancî'de "kêroşk" (v'siz) standarttır.`
**Issue**: Note acknowledges past correction. However cross-check Bedirxan-Lescot Hawar: actually `kêvroşk` (with v) is the Hawar standard form. Removing the `v` puts the entry into a Soranicized variant, opposite of the note's claim. Worth verifying against BL dictionary.
**Severity**: moderate (claim in note may be backwards)
**Reference**: [BL] dictionary

### [FILE: b1_kelime_db.dart, LINE: 4078–4082]
**id**: b1_d13
**Field**: ku/ez
**Current**: `ku:"Rovî", cins:"nêr", ez:"rovê"`
**Issue**: `Rovî` (n.m., ending in `-î`). Vowel-final stem: oblique is `roviyê` (with `-y-` linker). The form `rovê` would imply stem `rov` — but the bare stem ends in `-î`. Should be `roviyê`.
**Suggested fix**: `ez:"roviyê"`.
**Severity**: major (morphology error)
**Reference**: [BL] §148

### [FILE: b1_kelime_db.dart, LINE: 4092]
**id**: b1_d15
**Field**: ku/cins
**Current**: `ku:"Hirç", cins:"nêr"`
**Issue**: `Hirç` (bear). Bedirxan-Lescot: dişil (n.f.). Many dictionaries list `hirç` as dişil. Marking `nêr` is potentially wrong.
**Suggested fix**: Verify and probably change to `mê`.
**Severity**: moderate (gender uncertainty)
**Reference**: [BL] dictionary

### [FILE: b1_kelime_db.dart, LINE: 4198–4199]
**id**: b1_k17
**Field**: her (proverb)
**Current**: `her:['Min dîploma ji zanîngehê wergirt.', 'Dîploma ya wî perwerde nîşan dide.']`
**Issue**: `Dîploma ya wî perwerde nîşan dide` — `nîşan dide` is present 3sg of compound `nîşan dan`. But the subject `dîploma ya wî` (= "his diploma"). For a TRANSITIVE present like `nîşan dide`, the subject is in direct case → `dîploma yaw wî` is direct. OK. But the verb `nîşan dide` has an implicit object `perwerde` (= education) — sentence reads "his diploma shows education" — semantically odd. Better: `Dîploma ya wî perwerdeya wî nîşan dide` (= "his diploma shows his education").
**Severity**: minor (semantic awkwardness)

---

## SECTION D — B2 VOCABULARY DATABASE (`b2_kelime_db.dart`)

### [FILE: b2_kelime_db.dart, LINE: 26–37]
**id**: b2_001 / b2_002
**Field**: ku/cins
**Current**: `b2_001: ku:"Wî gotiye"`, `b2_002: ku:"Min xwendiye"` both `cins:"bêcins"`
**Issue**: These are full sentences/clauses listed as "headwords". Listing entire ergative-perfect clauses as vocabulary entries is unusual — they aren't lexemes. The vocabulary database is conflating "vocabulary cards" with "grammar examples". Not a linguistic error per se, but a structural mismatch.
**Severity**: minor (data category)

### [FILE: b2_kelime_db.dart, LINE: 40]
**id**: b2_003
**Field**: not
**Current**: `... \"Min pirtûk dît\" (dişil nesne: \"pirtûk\" mê → fiil tekil dişil)`
**Issue**: The note claims `pirtûk` is dişil. Bedirxan dictionary: `pirtûk` (n.f.) — yes, dişil. But the next claim "fiil tekil dişil" is **wrong**: Kurmancî past-transitive verbs don't carry GENDER agreement on the verb — they carry NUMBER (and sometimes person). Saying "fiil tekil dişil" implies the verb form differs based on object's gender. It does not in standard Kurmancî. (Some Soranî dialects have agreement; Kurmancî typically doesn't on verbs.) The note overgeneralizes.
**Suggested fix**: Change "fiil tekil dişil" → "fiil tekil (sayı uyumu)" — verb agrees in NUMBER only.
**Severity**: major (factually wrong grammar claim in pedagogical note)
**Reference**: [BL] §178, [TH] §75–80

### [FILE: b2_kelime_db.dart, LINE: 144–148]
**id**: b2_033
**Field**: not
**Current**: `"Nûçe" (haber) + "gihan" (ulaştıran ...) ... \"Nûçegiran\" yaygın ama \"giran\" (ağır) bileşimi anlamsız — \"gihan\" doğrudur`
**Issue**: Note correctly identifies the etymology issue. However, `nûçegihan` is one form; `nûçenivîs` (= news-writer) and `rojnamevan` (= journalist) are also widely used. The note privileges `nûçegihan` over `nûçegir / nûçegiran` but the rationale ("anlamsız") is debatable since `nûçegir` is widely attested in TRT-K and other Kurmancî sources. Flag as opinionated.
**Severity**: minor (opinion presented as fact)

### [FILE: b2_kelime_db.dart, LINE: 196–201]
**id**: b2_045
**Field**: not
**Current**: `Dişil — [AS] hiqûq bölümü → Kurmancîde doğru terim: "zagon" (kanun) veya "maf" (hak/hukuk)`
**Issue**: The note for `Meşrûiyet` says the correct term is `zagon` or `maf` — but `meşrûiyet` (legitimacy) is NOT the same concept as `zagon` (law) or `maf` (right). Legitimacy is a distinct concept. The note misdirects students by telling them to use a different word for a different concept.
**Suggested fix**: Remove the misdirection. Note should simply describe `meşrûiyet` and not suggest alternatives that mean different things.
**Severity**: major (pedagogical confusion / wrong synonym claim)

### [FILE: b2_kelime_db.dart, LINE: 232–236]
**id**: b2_051
**Field**: ku/not
**Current**: `ku:"Ziwakirin"`, note: `... "Gurç" (böbrek) farklı anlam ...`
**Issue**: The note distinguishes `ziwa` from `gurç` — but no learner is going to confuse the two (`gurç` = kidney, `ziwa` = dry). The note is irrelevant. Also the form `Ziwakirin` is the mastar — for "to dry up" the BARE form would be `ziwa bûn` (to become dry) or `ziwa kirin` (to dry — transitive). Listing `ziwakirin` as one word is debatable; Bedirxan style: `ziwa kirin` (separate).
**Severity**: minor (orthography + irrelevant note)

### [FILE: b2_kelime_db.dart, LINE: 270]
**id**: b2_061
**Field**: not
**Current**: `... bengî ≠ dîl (tutsak)`
**Issue**: Note correctly distinguishes. OK.
**Severity**: none

### [FILE: b2_kelime_db.dart, LINE: 283]
**id**: b2_063
**Field**: her
**Current**: `'Dengbêjên xerîbiyê stranên xemgîn dibêjin.'`
**Issue**: Good example. `Dengbêjên xerîbiyê` (= "dengbêjs of exile") + `stranên xemgîn dibêjin` (= "sing sad songs"). Present tense `dibêjin` — transitive but in present, no ergative. Subject `Dengbêjên xerîbiyê` is direct (pirjimar). Verb agrees with subject in person/number. Correct.
**Severity**: none

### [FILE: b2_kelime_db.dart, LINE: 365]
**id**: b2_090
**Field**: ku/tr
**Current**: `ku:"Dev ji birçîtiyê vedikin, dev li xwerinê digirin"`, tr: "Açlıktan ağız açarlar, yemeğe ağız kapatırlar"
**Issue**: The proverb is unusual. `Dev jê / dev ji X vekirin` = "to start to do X" (idiom). `Dev li X girtin` = "to give up X / abstain from X". So the proverb literally: "They start [eating] from hunger, they stop at the food." Counterintuitive — usually one would say the opposite (start eating because of hunger). The proverb may be authentic but the gloss is convoluted. Worth verifying against folklore sources.
**Severity**: minor (verify authenticity)

### [FILE: b2_kelime_db.dart, LINE: 379–383]
**id**: b2_093
**Field**: ku/tr
**Current**: `ku:"Erzan bikirî, biha dixebitî"`, tr: "Ucuza alan, pahalıya çalıştırır"
**Issue**: `bikirî / dixebitî` are 2sg conditional/present forms — but the proverb structure should be impersonal/3sg or use mastar. Standard form of this proverb: `Erzan bikirî, biha bê girtin` (= "What you buy cheap, you'll buy dear later"). The form `bikirî` (2sg subj) + `dixebitî` (2sg pres) is grammatically OK but the verbs don't fit the proverb's logic (`xebitîn` = "to work", not "to use/employ"). Note also says "Ucuza alan, pahalıya çalıştırır" — but `dixebitî` is "you work", not "you employ". Mismatch.
**Suggested fix**: Verify proverb form against folklore archive; consider `Erzan bikirî, biha bifroşî` (= "Buy cheap, sell dear") as the standard.
**Severity**: major (proverb form / verb meaning mismatch)
**Reference**: folklore archives

### [FILE: b2_kelime_db.dart, LINE: 391–393]
**id**: b2_100
**Field**: not
**Current**: `Dişil — [FB]: civak n.f. Ezafe "civaka" + "civakê" göstergesi.`
**Issue**: `civak` is dişil. Standard Bedirxan: `civak (n.f.)`. But — `[FB]: civak n.f.` — earlier in the file (b2_kelime_db.dart line 808 in source comments) it says: `"Civak": [FB] n.m. eril ✓`. Direct contradiction within the same file: comment says "eril ✓" but entry says "dişil". Internal inconsistency at the meta-level.
**Suggested fix**: Standardize. Per Bedirxan-Lescot (Hawar), `civak` is dişil — fix the source-comment claim.
**Severity**: major (meta-comment contradicts entry)

### [FILE: b2_kelime_db.dart, LINE: 396–400]
**id**: b2_101
**Field**: ku/ez
**Current**: `ku:"Civaknas", cins:"bêcins", ez:"civaknasî"`
**Issue**: `Civaknas` = "sociologist" (agent noun). The `ez` field has `civaknasî` — but `civaknasî` is the abstract noun "sociology" derived with `-î` (the noun is itself). The actual ezafe of `civaknas` (eril) would be `civaknasê` (def-eril) or `civaknasa` (def-dişil). Filling `ez` with `civaknasî` (a different word) is a data error.
**Suggested fix**: `ez:"civaknasê"` or `ez:"civaknasê/civaknasa"`.
**Severity**: major (wrong morphology in ez field)

### [FILE: b2_kelime_db.dart, LINE: 511–516]
**id**: b2_131
**Field**: ku/her
**Current**: `ku:"Sînor", her:["Sînorên çar welatan dibirin.", "Sînor û welat."]`
**Issue**: `Sînorên çar welatan dibirin` — `dibirin` is 3pl present of `birîn` (to cut). With subject `Sînorên çar welatan` (= "borders of four countries"), the sentence reads "The borders of four countries cut". `Birîn` here is metaphorical ("are dividing")? Awkward; standard usage would be `Sînorên çar welatan li hev hatine` (= "have come together") or `Sînorên çar welatan vî welatî dabeş kirine` (= "have divided this country"). As written, the example doesn't read naturally.
**Severity**: moderate (awkward sentence)

### [FILE: b2_kelime_db.dart, LINE: 763–766]
**id**: b2_274
**Field**: ku/ez
**Current**: `ku:"Rojava", cins:"mê", ez:"Rojava"`
**Issue**: For dişil noun, oblique should be `Rojavayê`. The `ez` field shows just `Rojava` (unchanged). The standard oblique with the dişil suffix would be `Rojavayê`. Examples on line 766: `"Li Rojava ne."` — should be `Li Rojavayê ne` per strict grammar; the bare form is colloquial.
**Suggested fix**: `ez:"Rojavayê"`. Also fix examples to use `Li Rojavayê`.
**Severity**: moderate
**Reference**: [BL] §148

### [FILE: b2_kelime_db.dart, LINE: 851]
**id**: b2_310
**Field**: ku/her
**Current**: `ku:"Li gorî çavkaniyên fermî"`, example "Li gorî xebera fermî."
**Issue**: This is a phrasal entry. The example `Li gorî xebera fermî` mixes `xeber` (Arabic-loan = news) — but the file generally uses `nûçe` (= news). `Xeber` is used in Soranî/Kurdî, less so in standard Kurmancî. Inconsistent vocabulary choice.
**Severity**: minor (lexical consistency)

### [FILE: b2_kelime_db.dart, LINE: 887–891]
**id**: b2_320
**Field**: ku
**Current**: `ku:"Kilam", tr:"Türkü / Şarkı"` cins `"mê"`
**Issue**: `Kilam` is marked dişil. Bedirxan-Lescot: `kilam (n.f.)` — correct. But cross-check vs. `b1_ed02` (b1 file line 3334) `Kilama dîrokî` — also treats `kilam` as dişil. Consistent here.
**Severity**: none

### [FILE: b2_kelime_db.dart, LINE: 903–909]
**id**: b2_323
**Field**: ku/her
**Current**: `ku:"Vegerîn"`, her: `'Em piştî salan vegeriyam welêt.'`
**Issue**: The example has subject `Em` (we, 1pl) but verb `vegeriyam` (1sg past). Number mismatch — should be `vegeriyan` (1pl) or `vegeriyam` should pair with `Ez`. Also `vegerîn` is generally intransitive (no ergative needed). The verb form `vegeriyam` is 1sg, needs `Ez`, not `Em`.
**Suggested fix**: `Ez piştî salan vegeriyam welêt.` (1sg) OR `Em piştî salan vegeriyan welêt.` (1pl).
**Severity**: major (subject-verb agreement)
**Reference**: [BL] §75 (intransitive past)

### [FILE: b2_kelime_db.dart, LINE: 1259–1263]
**id**: b2_541
**Field**: not
**Current**: `... NOT: "berdewam" Kurmancî standart; "dewam" Türkçe alıntıdır, kullanılmaz.`
**Issue**: Note's claim is partially wrong. `Dewam` (دوام) is Arabic, not Turkish. It's an Arabic loanword that exists in Turkish too (devam) and Persian, and entered Kurmancî from Arabic directly. Calling it "Türkçe alıntı" is etymologically incorrect.
**Suggested fix**: Change to "dewam Erebî alıntıdır".
**Severity**: minor (etymology error in note)

### [FILE: b2_kelime_db.dart, LINE: 1260]
**id**: b2_541
**Field**: her
**Current**: `"Têkoşîna ziman berdewam dike."`
**Issue**: `Têkoşîna ziman berdewam dike` — `Têkoşîna ziman` is dişil ezafe ("the struggle of language"), subject. `berdewam dike` = "continues" (3sg present). Correct subject-verb agreement. But `Têkoşîn + ziman` arguably should be `Têkoşîna zimanî` (with ezafe `-î` adjectivizer) for clarity. Either form acceptable.
**Severity**: minor (variant)

### [FILE: b2_kelime_db.dart, LINE: 1280–1281]
**id**: b2_550
**Field**: not
**Current**: `Dişil — "ber" + "xwedan". [FB]: berxwedan n.f. Heritage: Newroz, Kobanê.`
**Issue**: `Berxwedan` (resistance). Etymology: `ber + xwe + dan` (= "give in front of self" → "to resist"). Note simplifies to `ber + xwedan` (compounds wrongly). `Xwedan` doesn't exist as a free morpheme; the structure is `xwe + dan` (give oneself) bound to `ber` (front).
**Suggested fix**: Etymology: `ber + xwe + dan = "kendini ileri vermek" → resistance`.
**Severity**: minor (etymology imprecise)

### [FILE: b2_kelime_db.dart, LINE: 1396]
**id**: b2_700
**Field**: ku/her
**Current**: `ku:"Têkoşîn"`, her:["Ji bo zimanî têkoşîn kirin.", "Em têdikoşin."]`
**Issue**: First example `Ji bo zimanî têkoşîn kirin` — fragment, no subject. Should be `Ji bo zimanî têkoşîn kirin pêwîst e` (= "It is necessary to struggle for language") or `Em ji bo zimanî têkoşîn dikin`. As written, reads as a fragment.
Also note vs. b1_231 (b1_kelime_db.dart line 658) — there `têkoşîn` is presented as a verb with example `Em ji bo zimanê xwe têkoşîn` (also a fragment). Both files have this fragment problem.
**Suggested fix**: `Em ji bo zimanî têdikoşin.` (full sentence, 1pl present).
**Severity**: major (fragment in both files)

### [FILE: b2_kelime_db.dart, LINE: 1394–1401]
**id**: b2_700 (additional)
**Field**: not
**Current**: `... "Têxebatîn" uydurmaydı`
**Issue**: Notes "Têxebatîn was a fabrication" — flag for documentation, no current error.
**Severity**: none

### [FILE: b2_kelime_db.dart, LINE: 1428–1431]
**id**: b2_705
**Field**: not
**Current**: `Dişil — "serbixwe" + "bûn".`
**Issue**: Etymology: `serxwebûn` actually parses as `ser + xwe + bûn` (= "to be one's own master" → independence). The note's `serbixwe + bûn` is half-right; `serbixwe` (= autonomous) is itself `ser + bi + xwe`. Either way, the abstract noun `serxwebûn` is from `serxwe` (= self) + `bûn` (= being). Standard derivation: ✓.
**Severity**: minor

### [FILE: b2_kelime_db.dart, LINE: 1487–1493]
**id**: b2_730 (Compare with `Zanistên civakî` b2_a15)
**Field**: ku/cins/note
**Current**: `b2_730 ku:"Zanistê civakî"` (singular, eril ezafe `-ê`); but `b2_a15` (line 1911) `ku:"Zanistên civakî"` (plural, `-ên`).
**Issue**: Two entries for the same concept "social sciences" — one singular eril ezafe (`-ê`), one plural (`-ên`). The plural is the natural collocation ("social sciences" = plural). The singular eril form `Zanistê civakî` would mean "the science of the social" — different. Decide on plural.
**Suggested fix**: Keep plural form `Zanistên civakî` (b2_a15); remove or rephrase b2_730.
**Severity**: moderate (duplicate / mismatched form)

### [FILE: b2_kelime_db.dart, LINE: 1635–1639]
**id**: b2_fk_01
**Field**: ku/ez
**Current**: `ku:"Endazyarî", cins:"mê", ez:"endazyariyê"`
**Issue**: `Endazyarî` (engineering). For dişil ending in `-î`, oblique with `-y-` linker: `endazyariyê`. Correct. But the headword morphology: `endazyar` (engineer) + `-î` (abstract). Bedirxan p.275: `-î` makes abstract noun → dişil. Correct.
**Severity**: none

### [FILE: b2_kelime_db.dart, LINE: 1675–1679]
**id**: b2_t02
**Field**: ku/her
**Current**: `ku:"Nêrîna rexneyî"`, her: `"Ji nêrîna rexneyî ve."`
**Issue**: `Ji ... ve` is the pattern for "from the side of / by means of" (like `ji aliyê ... ve`). With `nêrîn` (= viewpoint), `ji nêrîna rexneyî ve` = "from the critical viewpoint" — OK as a calque from Turkish "eleştirel açıdan". Acceptable.
**Severity**: none

### [FILE: b2_kelime_db.dart, LINE: 1808–1809]
**id**: b2_t23
**Field**: ku
**Current**: `ku:"Ji aliyê teorîkî ve"`
**Issue**: The phrase `ji aliyê teorîkî ve` is calque-like. Standard Kurmancî for "theoretically" is `bi awayekî teorîk` (= "in a theoretical way"). The construction `ji aliyê X ve` literally "from the side of X by" — typically used for AGENTS in passive (cf. b2_l09_e2). Using it for "theoretically/from a theoretical angle" is a Turkism. Borderline. Mark for register.
**Severity**: minor (Turkism)

### [FILE: b2_kelime_db.dart, LINE: 1900–1903]
**id**: b2_a13
**Field**: her
**Current**: `'Bi rexneya civakî.'`
**Issue**: `Bi rexneya civakî` — fragment. As an example sentence it should be a full clause: `Em rexneya civakî dikin` (= "We do social criticism") or `Bi rexneya civakî em fêr dibin` (= "We learn through social criticism"). Bare prepositional phrase as "example" is weak.
**Severity**: minor (fragment example)

### [FILE: b2_kelime_db.dart, LINE: 2143]
**id**: b2_k14
**Field**: ku/cins
**Current**: `ku:"Çareserîya demokrasîk", cins:"mê"`
**Issue**: The form `Çareserîya` already has the dişil ezafe. The bare noun is `çareserî` (n.f., abstract noun in `-î`). Headword should arguably be the bare form. Consistent with other phrasal entries that include ezafe. Stylistic inconsistency only.
**Severity**: minor (consistency)

### [FILE: b2_kelime_db.dart, LINE: 2236–2237]
**id**: b2_f04
**Field**: ku/ez
**Current**: `ku:"Sembolîzm di wêjeyê de"`, ez: same
**Issue**: Headword is a multi-word phrase including a postposition (`di ... de`). This is not a noun — it's a sentence fragment. Not a vocabulary lemma. Same problem with b2_f06 (`Serdema Newrozê di wêjeyê`).
**Severity**: minor (data structure)

### [FILE: b2_kelime_db.dart, LINE: 2241–2242]
**id**: b2_f08
**Field**: ku
**Current**: `ku:"Lêkolîna wêjeyî"`
**Issue**: This is a noun phrase ("literary research"), entered as a single lexeme. Acceptable as a stable collocation. Cf. similar patterns elsewhere.
**Severity**: none

### [FILE: b2_kelime_db.dart, LINE: 2253]
**id**: b2_f18
**Field**: ku/cins
**Current**: `ku:"Remezan di çanda kurdî", cins:"nêr"`
**Issue**: Headword is again a fragment with postposition `di ... de` but the closing `de` is missing. As written, `Remezan di çanda kurdî` is incomplete. Standard would be `Remezan di çanda kurdî de` (= "Ramadan in Kurdish culture"). Strip trailing position fragments from headword.
**Severity**: moderate (data: dropped postposition)

### [FILE: b2_kelime_db.dart, LINE: 2269–2270]
**id**: b2_f29
**Field**: ku/ez
**Current**: `ku:"Koka çandî", cins:"mê"`
**Issue**: `Kok` (root) — dişil per Bedirxan. But cf. `b1_475` (b1_kelime_db.dart line 1521) `ku:"Kok", cins:"nêr"` — direct contradiction. Pick one gender.
**Suggested fix**: Verify and standardize. Bedirxan-Lescot: `kok (n.f.)` is more common.
**Severity**: major (gender contradiction across files)

---

## SECTION E — CROSS-FILE & STRUCTURAL ISSUES

### [FILE: b1_kelime_db.dart + b2_kelime_db.dart] CROSS-FILE
**Issue**: Inconsistent use of `cins:"bêcins"` for compound mastars/idioms.
- `b1_211` (`Hevdu`): bêcins ✓
- `b1_270`+: dialect names: `Kurmancî / Soranî / Zazacî` all bêcins
- But `b1_240` (`Gel`): nêr; `b1_1352` (`Gel`): nêr — duplicate same word with same gender (data hygiene).
- Same word `Helbestvan` defined twice with DIFFERENT ezafe forms (b1_061 has `helbestvana`; b1_710 has `helbestan` — the latter looks like a typo for `helbestvanê/helbestvana`; "helbestan" is plural OBLIQUE of `helbest`, not the agent noun).
**Severity**: moderate (database hygiene)

### [FILE: b1_kelime_db.dart + b2_kelime_db.dart] CROSS-FILE
**Issue**: Spelling inconsistency `siyaset` vs `sîyaset` — both spellings used in B1 and B2 files.
- `b1_1023` (line 2156): `Sîyaset` (with `î`)
- `b2_114` (line 467): `Siyaset` (without `î`)
- `b2_531` (line 1228): `siyasî` (without `î`)
- B2 files generally consistent (`siyaset` no `î`).
**Suggested fix**: Standardize to Hawar `siyaset` (no `î`).
**Severity**: moderate

### [FILE: b1_kelime_db.dart] DUPLICATE ENTRIES
- `Helbestvan`: b1_061 + b1_710
- `Pêkanîn`: b1_405 + b1_600
- `Mêjû`: b1_080 + b1_642
- `Serdem`: b1_082 + b1_643
- `Çîrok`: b1_062 + b1_713
- `Helbest`: b1_060 + b1_711
- `Sermaye`: b1_122 + b1_1094 (different spellings)
- `Aborî`: b1_120 + b1_660 (b1_660 is in `kB1EkKelimeler3`)
- `Bazirganî`: b1_121 + b1_661 + b1_ab01

**Severity**: moderate (data hygiene; possibly intentional for multiple lessons but causes confusion)

### [FILE: b1_lesson_definitions.dart] DUPLICATE OPTIONS PATTERN
- Lessons frequently use 4 options where 3 are too easy (wrong tense or wrong word entirely) and only 1 is plausible. Distractor design weakness across many items (b1_l01_e1, b1_l03_e1, b1_l05_e4, b1_l06_e1, b1_l11_e1, b1_l11_e3, etc.).
**Suggested fix**: Restructure distractors to be plausible-but-wrong (same syntactic class, similar register).
**Severity**: moderate (assessment quality systemic)

### [FILE: b2_lesson_definitions.dart] CONSISTENCY: Counterfactual `ê`
- Lessons 5–6 inconsistently use `min ê / em ê / dê` with counterfactual stems (`bikira / bikiriya / bibûyana`). Standard Bedirxan rejects future marker in counterfactual apodosis. Pick one paradigm.
**Severity**: moderate (cross-lesson grammar inconsistency)

---

## SECTION F — POSITIVE NOTES (well-done items)

For balance, the following items are particularly well-designed:

- **b1_l01_e2**: ergative-introduction with intuitive distractors and clear note.
- **b1_l03_e5**: `Gelo` (= "acaba") — clean cultural item.
- **b1_l11_e2 / e4**: comparative/superlative tests with parallel options.
- **b1_l13_e1**: Xanî biography MC — well-constructed.
- **b1_l15_e3**: `bi keserê` — well-positioned as a higher-order vocabulary item with cultural resonance.
- **b2_l03_e2 / e3**: passive present `tê gotin` and past `hate gotin` — clean tense contrast.
- **b2_l04_e3**: `Ser ketin` definition with strong distractors (all multi-word verb phrases).
- **b2_l11_e3**: Mem û Zîn character recognition — culturally accurate.
- **b2_l13_e1 / e3**: Cegerxwîn biography — well-researched and accurate dates.
- **b2_l15_e2**: `Hîpotez` ceribandin — academic register handled correctly.

---

## SUMMARY OF FINDINGS

**Total findings**: 60 substantive issues across the 4 files.

**By severity**:
- **Major** (urgent fix): 14 — gender contradictions, ungrammatical examples, double-correct answers, broken Kurdish in answer sets, agreement errors, wrong morphology in `ez` field, factually wrong grammar claims in notes.
- **Moderate**: 30 — assessment-quality issues, weak distractors, inconsistent ezafe, register/calque issues, duplicate entries.
- **Minor**: 16 — orthographic variation, phrasal vs lexeme structuring, etymological imprecision in notes.

**By category**:
1. Ergative/agreement errors: 7 findings
2. Future particle / counterfactual `ê`: 4 findings
3. Subjunctive/indicative confusion: 2 findings
4. Wrong oblique/ezafe morphology: 8 findings
5. Wrong/inconsistent gender: 5 findings
6. Idiom misuse / lexical errors: 9 findings
7. Quiz distractor weakness: 7 findings
8. `grammarNote` factually wrong: 5 findings
9. Cross-file inconsistency / duplicates: 8 findings
10. Awkward register / fragments / unnatural phrasing: 5 findings

**Top priorities for fix** (urgent):
1. **b2_l08_e3 / e5**: double-correct answers (`derbirînê / axaftinê`; `çapê / matbûatê`).
2. **b2_l02_e6**: agreement error in production speech sample (`Bila wan ev kiribin`).
3. **b1_kelime_db.dart line 388**: `b1_085` `ez` field has wrong lemma (`asimilasyonê` for `têkçûn`).
4. **b1_kelime_db.dart line 720**: `b1_250 / serhildana` confuses ezafe with oblique.
5. **b1_kelime_db.dart line 1733**: `b1_823 / dixwartin` form/gloss mismatch.
6. **b1_kelime_db.dart line 4080**: `b1_d13 / Rovî` wrong oblique `rovê` should be `roviyê`.
7. **b1_kelime_db.dart lines 3055 & 3604**: `Destmal` gender contradiction.
8. **b2_kelime_db.dart line 40**: `b2_003` factually wrong claim "fiil tekil dişil" (Kurmancî verbs don't carry gender agreement).
9. **b2_kelime_db.dart line 391**: `b2_100` meta-comment contradicts entry on `civak` gender.
10. **b1_lesson_definitions.dart lines 217–222**: `b1_l03_e4` ungrammatical option `'Wan dixwaze ev bike'`.
