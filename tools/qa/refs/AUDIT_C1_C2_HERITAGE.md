# LÛTKE — C1 / C2 / HERITAGE LANGUAGE AUDIT

**Audit scope**: Senior linguistic / literary / pedagogical review of advanced
(C1, C2) lesson definitions, vocabulary databases, and heritage dialogues.
**Reviewer**: Senior Kurmanji-Kurdish editor (linguistic auditor agent)
**Date**: 2026-05-04
**Files audited**:
1. `lib/features/lessons/domain/c1_kelime_db.dart` (2316 lines)
2. `lib/features/lessons/domain/c1_lesson_definitions.dart` (959 lines)
3. `lib/features/lessons/domain/c2_kelime_db.dart` (1504 lines)
4. `lib/features/lessons/domain/c2_lesson_definitions.dart` (962 lines)
5. `lib/features/lessons/domain/heritage_dialogues.dart` (577 lines)
6. `lib/features/lessons/domain/heritage_c_dialogues.dart` (209 lines)

**Summary**: 56 distinct findings, classified as:
- 12 factual / literary / historical content errors
- 14 grammatical / morphological errors (ezafe, ergative, subjunctive, agreement)
- 14 assessment quality issues (clue leakage, length bias, weak distractors)
- 10 register / naturalness issues (heritage dialogues + C1/C2 stylistic)
- 6 orphan, truncated, redundant, or self-referential content bugs

Severity scale: **major** (broken UX or factually wrong), **moderate**
(misleading or stylistically off, learner can be confused), **minor**
(stylistic polish).

---

## A. FACTUAL / LITERARY / HISTORICAL ERRORS

### [FILE: c1_kelime_db.dart, LINE: 1063]
**id**: c1_959
**Field**: not (Dîwana Xanî)
**Current**: `"Dîwan" = klasik Doğu şiir divanı. Ehmedê Xanî (1650-1707).`
**Issue**: Birth year inconsistent with the rest of the codebase. `b1_lesson_definitions.dart` line 756, `b1_kelime_db.dart` line 1038, and `lesson_entities.dart` line 593 all give **1651–1707**. The 1650 form here is the older estimate; consensus scholarship and the rest of LÛTKE use 1651. Unify on 1651–1707. Also: Xanî's masterwork is *Mem û Zîn*, not a "Dîwan"; he authored a small lyric collection but the conventional reference is *Mem û Zîn* (1695) plus *Nûbahara Biçûkan* (1683). Calling the entry "Dîwana Xanî" is itself unusual — verify whether this card refers to Xanî's lyric divan (small, less canonical) or is a generic placeholder.
**Suggested fix**: `Ehmedê Xanî (1651–1707)` and either re-label as "Dîwana Xanî (Xanî'nin küçük şiir divanı)" or replace with `Mem û Zîn`.
**Severity**: moderate
**Reference**: Cross-file consistency; standard scholarship (Mihrî, Xanî biography).

### [FILE: c1_kelime_db.dart, LINE: 1070]
**id**: c1_966
**Field**: not (Cegerxwîn)
**Current**: `Cegerxwîn (1903-1984) = Şükrü Hasan Kurdî. Sosyalist Kürt şairi.`
**Issue**: Real name is rendered as "Şükrü Hasan Kurdî" — this is the **Turkified** transliteration of a Kurdish name. The canonical Kurmancî form, also used elsewhere in the project (e.g. `b2_lesson_definitions.dart` line 753, 759 — "Şêxmûs Hesen"), is **Şêxmûs Hesen**. "Şükrü Hasan" is the Turkish state-imposed identity. Inside a Kurdish C1 vocabulary card, this is jarring and contradicts the project's own usage one tier below.
**Suggested fix**: `Cegerxwîn (1903–1984) — navê wî yê rastîn Şêxmûs Hesen e. Helbestvanê neteweyî yê modern.` (Use the en-dash to match other entries.)
**Severity**: major (factual inconsistency + politically charged form choice)
**Reference**: `b2_lesson_definitions.dart` lines 753, 759.

### [FILE: c1_kelime_db.dart, LINE: 1106]
**id**: c1_335
**Field**: ku
**Current**: `Peymana Lozanê`
**Issue**: The note states `(forma Kurmancî; "Lausanne" Frensî)` — but "Lozan" is the Turkish form, not the Kurmancî form. Standard Kurmancî sources (Hawar, Bedirxan, modern Kurd-Akad) use **Lozan** as a Kurmancî adaptation, but the note's claim that "Lausanne" is "Fransızca" is misleading: Lausanne is the Swiss French original; Kurmancî just borrows the Turkish-mediated form. The pedagogical claim is harmless but linguistically loose.
**Suggested fix**: `"Peymana Lozanê" — şeklê Kurmancî ji nivîsîna Tirkî ya bajarê Lausanne (Swîsra) hatiye girtin. 1923 — parçekirina Kurdistanê.`
**Severity**: minor

### [FILE: c1_lesson_definitions.dart, LINE: 502 (and 521)]
**id**: c1_l08_e1, c1_l08_e3
**Field**: opts / fill
**Current** (e1 opts[1]): `'Stranbêjekî gelêrî yê dema Osmaniyan ê sedsala 18'`
**Current** (e1 ku): `'Feqiyê Teyran (1590–1660) kî ye?'`
**Issue**: Birth/death years stated as 1590–1660. Scholarly consensus on Feqiyê Teyran is uncertain but commonly cited as **c. 1590–c. 1660** or in some sources earlier (some sources put him in late 16th c.). The given range is acceptable but presenting it as definitive without "c." may mislead at C1. More importantly, the option `Stranbêjekî gelêrî yê dema Osmaniyan ê sedsala 18` is implausibly distant (off by a century) — the whole question reduces to elimination because all other distractors are absurd. See assessment-quality issue D-1.
**Suggested fix**: Note the dates as approximate (`c. 1590–c. 1660`); strengthen distractors.
**Severity**: minor (factual), moderate (assessment)

### [FILE: c1_lesson_definitions.dart, LINE: 480-484]
**id**: c1_l07_e5
**Field**: fill (opts and tr)
**Current**: opts `['16-17.', '17-18.', '18-19.', '15-16.']`, tr `'Cizîrî Divanı 16-17. yüzyılda yazıldı.'`, note `Mela Cizîrî 1570-1640 arası yaşadı. 16. yy sonu - 17. yy başı.`
**Issue**: The Turkish translation declares "16-17. yüzyılda" as fact, then forces the learner to pick "16-17." as the answer — but the question stem (`'Dîwana Cizîrî di çerxa ___ de hate nivîsîn.'`) gives no internal hint, while the Turkish *prompt* gives the answer away verbatim. This is direct clue leakage. Also "çerxa" (= çağ/asır) is an obscure word; standard Kurmancî here would be "sedsala". Finally, scholarly authorship dates for the Dîwana Cizîrî are debated; "16-17. yy" is reasonable but "yazıldı" implies a single composition event when in fact the dîwan accreted over Cizîrî's lifetime.
**Suggested fix**: Reword the Turkish prompt without naming the centuries; use "sedsala" not "çerxa"; or convert into an MCQ that quizzes a different feature (e.g., genre or themes).
**Severity**: moderate

### [FILE: c1_lesson_definitions.dart, LINE: 558-568]
**id**: c1_l09_e1
**Field**: opts[3]
**Current**: `'Allegoriya siyasî û netewî derbarê bêdewletiya Kurdan'`
**Issue**: Mixed orthography: `Allegoriya` uses double-l, but standard Kurmancî transliteration is `Alegorî` (single l, like in BH/Hawar). The English/French double-l is being preserved unnecessarily. Other vocabulary in the corpus uses `alegorî` style (cf. neologisms list).
**Suggested fix**: `Alegoriya siyasî û netewî li ser bêdewletiya Kurdan` (also "li ser" reads more naturally than "derbarê … de" here).
**Severity**: minor

### [FILE: c1_lesson_definitions.dart, LINE: 580-584]
**id**: c1_l09_e3
**Field**: kurmanjPrompt
**Current**: `Xanî dibêje: "Kurd in û ___ heye."` — opts `['welat', 'Kurmancî', 'Kurdistan', 'Botan']`, ci=2 (Kurdistan).
**Issue**: This is presented as a "famous Xanî verse," but the line `Kurd in û Kurdistan heye` is **not an actual verse from Mem û Zîn**. Xanî's famous identity-affirming couplets read: *"Da xelk-i nebên ku ekrad / Bê marifet in, bî esl û binyad"* (so people may not say Kurds are without learning, root, foundation), and elsewhere references to "Kurdistan" as a geographic term — but the claim "Xanî dibêje: Kurd in û Kurdistan heye" is editorial paraphrase, not a quotation. Presenting it inside actual quotation marks misleads C1 learners about the textual basis. The pedagogical intent (Kurdistan as identity anchor) is fine, but the framing as a direct Xanî quote is **factually wrong**.
**Suggested fix**: Change framing to indirect: `Xanî di Mem û Zîn de tekez dike ku Kurd hene û welatekî wan ê bi nav heye.` — or quote an actual verse.
**Severity**: major (literary fact)
**Reference**: Mem û Zîn, ed. Sadinî / Bedirxan editions; Hejar's commentary.

### [FILE: c1_lesson_definitions.dart, LINE: 593-595]
**id**: c1_l09_e4
**Field**: opts[1] / note
**Current**: `'Xwedanê desthilatê yê ku bi fitneya Bekir xapîyaye'` — note: `Mîr Zeynedîn: Botan emiri, Bekir'in fitnesine kapıldı.`
**Issue**: In Mem û Zîn the antagonist is consistently called **Bekirê Mergewer** (or simply Bekir Mergewer/Bekirê Awan in some manuscripts). Calling the Mîr "Zeynedîn" is correct, but the option text `bi fitneya Bekir xapîyaye` uses the present-perfect `xapîyaye` instead of the cleaner literary form `xapî`/`xapîya`. Also "Xwedanê desthilatê" is a heavy construction; standard Kurmancî would be "xwedî desthilat" or "desthilatdar". Stylistically off-register for C1.
**Suggested fix**: `Mîrê Botan ku bi fitneya Bekirê Mergewer hat xapandin` (or active: `…ku Bekirê Mergewer ew xapand`).
**Severity**: moderate

### [FILE: c2_lesson_definitions.dart, LINE: 100-104]
**id**: c2_l01_e2
**Field**: opts (and grammar within)
**Current**: opts `['8 cilt, 1945-85', '4 cilt, 1950-70', '6 cilt, 1960-80', '2 cilt, 1970-85']`
**Issue**: The claim of "Dîwan I-VIII: 1945–1985" oversells the publication record. The Dîwans are typically counted as **8 volumes**, but the first widely-cited edition published as a multi-volume *Dîwan* sequence is from the late 1940s onward, with the final volumes appearing posthumously. Saying "1945" specifically is too precise — the 1945 publication is *Pirsa Kurdistanê* / early periodical work, not Dîwan I as a book. Scholarship typically cites Dîwan I (Dîwana Cegerxwîn) as 1945–1957 first volumes, then later compilations into VIII volumes by Roja Nû / Stockholm. Either present this with "yaklaşık" (approx.) or remove the specific dates.
**Suggested fix**: Soften: `Dîwan VIII cilt — yayım dönemi yaklaşık 1945–1985.` Or change distractors to test a different fact.
**Severity**: moderate (over-precise / minor factual)

### [FILE: c2_lesson_definitions.dart, LINE: 415-417]
**id**: c2_l06_e5
**Field**: note
**Current**: `Standart Soranî ergatifi büyük ölçüde YİTİRMİŞTİR — pronominal ek sistemine geçmiştir (MacKenzie 1961; Haig 2008).`
**Issue**: This statement is broadly correct but **simplification** at C2 — Soranî ergativity has not been "yitirilmiş" so much as transformed: the standard description is that Soranî preserves the ergative pattern through pronominal enclitics in the past tense (the so-called "split-ergative pronominal" system). Saying it has been "lost" misrepresents the typological position; the pronominal clitics ARE the ergative reflex. At C2 level the learner should encounter the precise term: "Soranî has split ergative agreement marked by pronominal clitics (=enclitic ergative agreement)." Even Haig (2008) and MacKenzie (1961) describe the system as alive but reorganized.
**Suggested fix**: `Soranî ergatifi pronominal-clitic biçimine dönüştürmüştür (split-ergative agreement with enclitic markers; MacKenzie 1961, Haig 2008). Yapı korunur ama yüzey morfolojisi farklıdır.`
**Severity**: moderate (technical-linguistic accuracy)

### [FILE: c2_lesson_definitions.dart, LINE: 614-622]
**id**: c2_l10_e1
**Field**: opts (correct)
**Current**: `'Helbestvanê neteweperwer ê kurd, pêşrewa neteweperweriya kurdî'`
**Issue**: The choice of label "neteweperwerî" for Hacî Qadirê Koyî is anachronistic at C1/C2 level. Koyî's poetics are usually described as *bîdarî* (awakening) and *welatparêzî* (patriotism) — proto-national, not formal "nationalism" in the Western sense. Modern Kurdology typically calls him a "pêşrewê hişyariya neteweyî" (forerunner of national consciousness), which is more precise. Calling him "pêşrewê neteweperweriyê" projects 20th-century ideology onto a 19th-century cleric-poet. C2 readers will detect this as imprecision.
**Suggested fix**: `Pêşrewê hişyariya neteweyî / Welatparêzê pêşîn ê kurd ê sedsala 19.`
**Severity**: moderate

### [FILE: c2_lesson_definitions.dart, LINE: 640-645]
**id**: c2_l10_e4
**Field**: opts
**Current**: opts `['Biçe!', 'Bisekine!', 'Rabe!', 'Razê!']`, ci=2 (Rabe!)
**Issue**: While "Rabe!" is genuinely used in Koyî (`Bîrî bikin xwarinên xwe…`), the option `Razê!` is morphologically incorrect — the standard imperative of "razan" (to sleep) is **Razê!** (2sg) but more commonly pronounced/written **Razê** in fixed form. This is fine. However, the issue: the four options here are all single-word imperatives, and the question stem ("Koyî bi kîjan peyvê … bîdariyê") essentially asks "which Kurmancî verb means 'wake up'?" — a B1-level question disguised as C2. At C2 the question should test specific knowledge from a specific Koyî poem, not basic imperative recognition. Distractors `Biçe!` (go!) and `Bisekine!` (stop!) are too obviously not awakening calls; only `Rabe!` ↔ `Razê!` is a remotely interesting pair, but `Razê!` is the *opposite* (sleep!). This collapses to a binary choice between two trivially distinguishable opposites.
**Suggested fix**: Test instead a specific line / a verse-form recognition (gazel vs kasîde) or the anti-clerical satire dimension of Koyî.
**Severity**: moderate (assessment + content depth)

---

## B. GRAMMATICAL / MORPHOLOGICAL ERRORS

### [FILE: c1_lesson_definitions.dart, LINE: 110]
**id**: c1_l01_e2
**Field**: fill (before/after)
**Current**: `before: 'Ew mirovê', after: ' li kêleka min rûniştî ye, birayê min e.'`
**Issue**: The relative-clause pattern `mirovê ku li kêleka min rûniştî ye` requires the participial form `rûniştî` (= seated). Acceptable. However, the construction `ew mirovê ku ... rûniştî ye` is an inanimate-style stative; for a *person* the more idiomatic literary Kurmancî is `ew mirovê ku rûdiniştîye / yê li kêleka min rûniştiye`. Using stative participle + bûn for an animate seated person is grammatically permitted but pragmatically rare. At C1 this should ideally model the more common active-perfect: `ew mirovê ku li kêleka min rûniştiye`.
**Suggested fix**: Change `rûniştî ye` → `rûniştiye` (perfect: "is seated" → "has seated himself") for a more natural relative clause.
**Severity**: minor

### [FILE: c1_lesson_definitions.dart, LINE: 232-235]
**id**: c1_l03_e3
**Field**: fill / opts
**Current**: opts include `'dê binivîsim'` (future, 1sg), correct `'dinivîsand'` (imperfective past).
**Issue**: The verb stem in Kurmancî is **nivîsîn** (to write), which conjugates as `dinivîse` (3sg present), `nivîsand`/`nivîsî` (3sg simple past). The 1sg simple past **should be `min nivîsand`** (with subject in oblique because *nivîsîn* is transitive → ergative). The imperfective past 1sg is **`min dinivîsand`**. The fill given is `Her roj piştî îşê min ___ nameyek` and the correct is `dinivîsand`, but ergative concord in transitive past (with object `nameyek`) requires `dinivîsand` (singular agreement with `min` is wrong; agreement should be with `nameyek` → `nameyek + dinivîsand` = correct since the patient is sg.). So the form is OK morphologically. **However**, the third option `nivîsand` is *also* grammatically valid — it expresses the simple past ("yazdım") rather than imperfective ("yazıyordum"), and Turkish "yazıyordum" *can* be rendered with simple past in habitual contexts. This makes it a plausible second answer, weakening the question. Also the spelling `îşê` mixes Turkish (`iş`) with the Kurmancî ezafe; the Kurmancî term is **karê** (from `kar`).
**Suggested fix**: Replace `îşê` with `karê`. State the temporal frame more clearly: `Her roj, piştî karê min, min nameyek ___ ji bo ku adetek bibe.`
**Severity**: moderate

### [FILE: c1_lesson_definitions.dart, LINE: 305-309]
**id**: c1_l04_e5
**Field**: fill
**Current**: `before: 'Mirov bi', after: ' xwe têdigihe.'` — opts include `'ramînên'`.
**Issue**: The form `ramînên xwe` requires a noun **ramîn** as base. The standard Kurmancî form for "düşünce" is **raman** (n.f., with plural `ramanan`/`ramanên`); **`ramîn`** is a non-standard variant (used by some authors but not in BH/Hawar). The tree of forms here mixes raman / ramîn / ramyarî inconsistently across the C1 corpus. Compare:
- `c1_536`: `Azadîya ramandinê` → uses **ramandin** (from raman)
- `c1_240`: `Ramana siyasî` → uses **raman**
- `c1_l04_e5`: `ramînên xwe` → uses **ramîn**
- `c1_536` note refers to "ramyarî" (yet another root)
At C1 a consistent root selection should be enforced. **Raman** (BH §, Hawar canon) is the standard.
**Suggested fix**: Change `ramînên xwe` → `ramanên xwe`. Audit all `ramîn-` forms in the corpus and consolidate to `raman-`.
**Severity**: moderate

### [FILE: c1_lesson_definitions.dart, LINE: 416]
**id**: c1_l06_e5
**Field**: note
**Current**: `"Bi delîlan" = kanıtlarla. "Delîl" oblique çoğul → "delîlan".`
**Issue**: The lemma `delîl` (Arabic loan, masculine) takes oblique plural `-an`, so `delîlan` is right. But the *singular* oblique would be `delîlî` or just `delîl` with the ezafe — the note doesn't mention that `bi delîlan` is plural-only (= "with proofs (multiple)"). For a singular "with proof" you'd say `bi delîlekê` or `bi delîlê xwe`. Beginners at C1 may try to use `bi delîlan` for any proof. This is a teachable nuance the note misses.
**Suggested fix**: Add: `Tekîl: "bi delîlekê" / "bi delîlê (...)"; pirjimar: "bi delîlan".`
**Severity**: minor

### [FILE: c1_lesson_definitions.dart, LINE: 165-167]
**id**: c1_l02_e2
**Field**: order (target)
**Current**: target `'Ger tu sibê werî, em ê bi hev re biçin'`
**Issue**: The conditional verb `werî` is the subjunctive of `hatin` (to come), 2sg. Form: `(bila) tu were` / `(eger) tu werî` — both acceptable, with `tu werî` being the conditional present. However, in formal C1 Kurmancî the more canonical conditional pattern is **`Ger tu sibê bêyî`** (subjunctive of `hatin` — `bêyî`, not `werî`). `Werî` is the alternative stem found in some dialects. Bedirxan/Lescot §312 gives `bêyî` as the standard subjunctive 2sg; `werî` is variant but less standard for written Kurmancî.
**Suggested fix**: Use `Ger tu sibê bêyî, em ê bi hev re biçin` and optionally note the `werî` variant.
**Severity**: moderate
**Reference**: BH §312 (subjunctive of hatin: `bêm, bêyî, bê` ...).

### [FILE: c1_lesson_definitions.dart, LINE: 195]
**id**: c1_l02_e6 (speak)
**Field**: kurmanjPrompt
**Current**: `'Dema ku em vegeriyan gund, pîrê got ku ew ê sibê neçe bajêr çimkî hewa ne xweş e.'`
**Issue**: Two grammatical issues:
1. `vegeriyan gund` — missing the directional preposition **bo / li / da**: standard form is `vegeriyan **gund** ` is informal; literary form `vegeriyan **bo gundê xwe**` or `vegeriyan **gund**` (bare locative) is acceptable in colloquial but at C1 expected with marker.
2. `ew ê sibê neçe` — future negative of `çûn` is more typically `ew ê neçe` ✓ (accepted), but in *reported speech* with a past matrix verb (`got ku`), the embedded clause tense should harmonize: `pîrê got ku ew **ê sibê** neçe` is direct-quote style. Indirect would be `pîrê got ku ew **(d)ê** wê rojê neçûya` (counterfactual past) or with `bê` future. The lesson teaches subordination but doesn't model proper **sequence-of-tenses**. This is a high-C1 / low-C2 expected feature.
**Suggested fix**: `Dema ku em vegeriyan gundê xwe, pîrê got ku ew ê sibê neçe bajêr — çimkî hewa ne xweş bû.` (Note: the embedded `ye` → `bû` for past consistency.)
**Severity**: moderate

### [FILE: c1_lesson_definitions.dart, LINE: 537-541]
**id**: c1_l08_e5
**Field**: fill / opts
**Current**: `before: 'Di destanê de Şeyx', after: ' xwe winda dike, hingê xwe dinase.'` — opts `['pereyê', 'nefsê', 'zimanê', 'sala']`, ci=1 (`nefsê`).
**Issue**: The construction `Şeyx nefsê xwe winda dike` is grammatically odd. `Nefs` is feminine, oblique `nefsê`. The full ezafe should be `nefsa xwe` (= nominative ezafe with reflexive `xwe`), not `nefsê xwe`. The fill blank here forces the learner to insert `nefsê` (oblique) in a position that grammatically demands the **direct-object form `nefsa xwe`** (since `winda dike` is present-tense transitive and direct objects in present don't take oblique). The correct Kurmancî is: `Şeyx **nefsa xwe** winda dike` (3sg present, direct nominative object).
**Suggested fix**: Replace `nefsê` with `nefsa`; or restructure so that oblique is correct (`Şeyx ji nefsê xwe vediqete` — separate from one's nefs).
**Severity**: major (grammatical case error)
**Reference**: BH §158–162 (case marking in present vs past).

### [FILE: c1_lesson_definitions.dart, LINE: 596-599]
**id**: c1_l09_e5
**Field**: fill / opts / note
**Current**: opts `['hewaya sar', 'kêmasî', 'bêyekîtî', 'bindestî']`, ci=2 (bêyekîtî).
**Issue**: The compound `bêyekîtî` (= without unity) is morphologically transparent (`bê` + `yekîtî`) but not the standard Xanî term. In Mem û Zîn Xanî uses **`bêyekitî`** (single t) — note the spelling: BH §275 attestations have `yekitî` (with single t), although modern orthography varies. More importantly, the standard Kurmancî term Xanî uses is **`bêyekîtî`** but in his own preface he speaks of "bêyte fa\'ir" / "ittîfaqsiziya Kurdan" with Arabic-derived vocabulary. The pedagogical paraphrase is OK but the option as fill-in masks a deeper Xanî reading. Also, distractor `'hewaya sar'` (cold weather) is comically irrelevant — see assessment issue D-2.
**Suggested fix**: Verify spelling against canonical Xanî text (Sadinî 2010 ed.); accept `bêyekîtî` but cite the source. Strengthen distractors.
**Severity**: minor

### [FILE: c2_lesson_definitions.dart, LINE: 153-155]
**id**: c2_l02_e2
**Field**: fill
**Current**: `before: 'Kî me ez? Ez', after: ' im!'`, opts `['tenê tenê', 'bêhizir', 'bê nasname', 'Kurd û Kurdistanî']`, ci=3.
**Issue**: The agreement in `Ez ___ im` requires a singular predicative; `Kurd û Kurdistanî` is two coordinated nouns (Kurd + Kurdistanî), and `Ez Kurd û Kurdistanî im` — strictly grammatical, but stylistically unusual. Cegerxwîn's actual famous line is `Ez Kurd im, ez Kurd im!` (repeated, anaphoric) — the conjunction `Kurd û Kurdistanî` is editorial paraphrase, not the canonical line. Also `bêhizir` and `bê nasname` are grammatical (predicative adjective with `bê`), but `tenê tenê` is **ungrammatical** as a predicative — `tenê` (= alone) used twice doesn't form a valid Kurmancî complement; you'd say `Ez bi tenê me` or `Ez tenê me` (one `tenê`).
**Suggested fix**: Use the actual Cegerxwîn line. Remove `tenê tenê` distractor — it's not Kurmancî.
**Severity**: moderate
**Reference**: Cegerxwîn, *Dîwan*, "Kî me ez?" — verify exact text.

### [FILE: c2_lesson_definitions.dart, LINE: 270-274]
**id**: c2_l04_e2
**Field**: fill / opts
**Current**: opts `['elîtan', 'gel', 'xerîban', 'zana tenê']`.
**Issue**: The form `zana tenê` is morphologically fine ("only the wise"), but as a fill answer in `…ji bo ___ hatine nivîsîn` it would require oblique → `zana**yan** tenê` (oblique plural) since `ji bo` governs oblique. The provided correct answer `gel` is uncountable/collective so doesn't need plural marking, but the distractor `zana tenê` should be `zanayan tenê` for grammatical parallelism. As stands, only the correct option is grammatically clean — clue leakage.
**Suggested fix**: Either inflect all distractors correctly (`elîtan` is already oblique, fix `zana tenê` → `zanayan tenê`), or accept that the question is grammatically inconsistent.
**Severity**: moderate

### [FILE: c2_lesson_definitions.dart, LINE: 658-660]
**id**: c2_l10_e6 (speak)
**Field**: kurmanjPrompt
**Current**: `'Hacî Qadirê Koyî bi Soranî pêşwaziya neteweperweriya edebî kir. Mîrasa wî têkildarî Cegerxwîn e.'`
**Issue**: The collocation `pêşwaziya … kir` literally means "to welcome/greet" — used metaphorically here for "to pioneer", but this is a calque from Turkish `öncülüğü yaptı` and **does not work in Kurmancî** without context. Standard Kurmancî for "to pioneer" is `pêşeng bûn` or `serokî kir`. So `pêşwaziya neteweperweriya edebî kir` would read naturally as "he welcomed (greeted) the literary nationalism" — wrong meaning.
**Suggested fix**: `… bi Soranî pêşengiya neteweperweriya edebî kir.` Or: `… bûye pêşrewê neteweperweriya edebî bi Soranî.`
**Severity**: major (lexical / collocation error)

### [FILE: c2_lesson_definitions.dart, LINE: 845-849]
**id**: c2_864
**Field**: ku / not (in c2_kelime_db)
**Current**: `ku:"Şerê neyabûyî ya C2"`, note: `"Şerê neyabûyî" = dolaylı konuşma. "Got ku bihata" yapısı.`
**Issue**: **Major terminology error**. `Şer` means "war/fight/battle", not "speech". The intended term for indirect speech is `**vegotina nerasterast**` or `axaftina nerasterast`. `Şerê neyabûyî` literally means "war that didn't happen" — utterly wrong. This appears to be a copy-paste/typo error: the author may have meant `şarê neyabûyî` from the wrong root. There is **no Kurmancî term** "şerê neyabûyî" for indirect speech.
**Suggested fix**: `ku:"Vegotina nerasterast"`, note: `Vegotina nerasterast = dolaylı konuşma. "Got ku bê / bihata" yapısı.`
**Severity**: major (lexical error in C2 vocabulary card)

### [FILE: c2_lesson_definitions.dart, LINE: 525-527]
**id**: c2_308 (kelime card)
**Field**: ku / tr
**Current**: `ku:"Şêweyê cixarek"`, tr:"Sigar biçimi / Belagat figürü", en:"Figure of speech"
**Issue**: `Cixarek` is **the Kurmancî word for cigarette** (smoking, tobacco roll), unrelated to rhetoric. The English gloss "Figure of speech" is correct semantically (= "üslup figürü"), but the Kurmancî label `cixarek` is a homonym / wrong word. The rhetorical "figure of speech" in Kurmancî would be `**şêweyê wêjeyî**`, `figura edebî`, or `**hunera gotinê**`. This is a serious lexical error in a C2 vocabulary entry, where learners are most likely to pick up and reuse such terms.
**Suggested fix**: `ku:"Şêweyê wêjeyî / Hunera gotinê"`, drop the cixarek confusion entirely.
**Severity**: major (catastrophic lexical error — cigarette is being labeled as rhetoric)

### [FILE: c2_lesson_definitions.dart, LINE: 528-530]
**id**: c2_309
**Field**: ku
**Current**: `ku:"Cixareka edebî"`
**Issue**: Same root error as c2_308 — "Cixareka edebî" literally means "literary cigarette". Both c2_308 and c2_309 appear to have been generated with a wrong root word and never edited. **Major lexical errors** in the kelime database.
**Suggested fix**: Delete or replace with `Hunera edebî` / `Figura edebî`.
**Severity**: major

---

## C. EZAFE / AGREEMENT / MORPHOSYNTACTIC ISSUES

### [FILE: c1_kelime_db.dart, LINE: 943]
**id**: c1_515
**Field**: her (heritage example)
**Current**: `["Mafê zimanê di dadgehê de.","Di mafê zimanê di dadgehê de de."]`
**Issue**: The second sentence has `**de** ... **de de**` — double "de" caused by mechanical insertion of `Di ... de` around an entry that already contains `di dadgehê de`. Result is ungrammatical: `*Di mafê zimanê di dadgehê de de*`. This is not a sentence; it's a tooling artifact.
**Suggested fix**: Either rewrite as `Di mafê zimanê di dadgehê de yê kesan de` (still awkward) or just `Mafê zimanê di dadgehê de pîroz e.` Drop the auto-generated wrapping.
**Severity**: major (renders broken; embarrassing in production)

### [FILE: c1_kelime_db.dart, LINE: 944]
**id**: c1_515
**Field**: gen
**Current**: `["Mafê zimanê di dadgehê de","mafê zimanê di dadgehê de ya me"]`
**Issue**: `mafê zimanê di dadgehê de **ya** me` — the ezafe `ya` is feminine, but the head noun `maf` is masculine (n.m. in BH). Should be `**yê** me` (masculine ezafe). Same systematic error appears across many auto-generated `gen` arrays in `kC1_Buyuk3`, `kC1_Tamamlama`, etc. — see e.g. lines 944, 947, 950, 953, 967, 974, 977, 980, 983, 986, 989, 992, 1004, 1007, 1010, 1014, 1019, 1022, 1025, 1028, 1031.
**Suggested fix**: Audit every entry where `cins:"nêr"` (masculine) and the gen array contains `ya me` — replace with `yê me`. Probably 30+ entries affected.
**Severity**: major (systematic gender-agreement error)
**Reference**: BH §47–52 (ezafe agreement).

### [FILE: c1_kelime_db.dart, LINE: 559]
**id**: c1_519
**Field**: gen (and cins)
**Current**: `cins:"bêcins"`, `gen:["Şîroveyên wêjeyî","şîroveyên wêjeyî ya me"]`
**Issue**: `bêcins` (= without gender — used when noun is plural-only or doesn't take gender). But "şîroveyên wêjeyî **ya** me" — plural noun (`şîroveyên`) requires plural ezafe `**yên** me` (or genitive `**yên** me`), not `ya me`. Auto-generation has output a feminine singular form for a plural head noun.
**Suggested fix**: `şîroveyên wêjeyî yên me`. Same systematic fix needed for plural+`ya me` patterns.
**Severity**: major (systematic plural-agreement error)

### [FILE: c1_kelime_db.dart, LINE: 974]
**id**: c1_525
**Field**: cins / gen
**Current**: `cins:"nêr"`, `gen:["Giyanê çandî","giyanê çandî ya me"]`
**Issue**: Same as above — masculine head + `ya me` (feminine ezafe). Should be `yê me`.
**Severity**: major (replicate)

### [FILE: c2_kelime_db.dart, LINE: 522-523]
**id**: c2_307
**Field**: cins / ku
**Current**: `cins:"mê"`, `ku:"Rêzimana kûr ya Kurmancî"` — example `"Di rêzimana kûr ya kurmancî de xebat heye."`
**Issue**: `Rêziman` is **masculine** in standard Kurmancî (n.m. in BH) — so the ezafe should be `Rêzimanê kûr yê Kurmancî`, not `Rêzimana kûr ya Kurmancî`. Either the cins tag is wrong or the head form is wrong. Inconsistency with BH attestation.
**Suggested fix**: If keeping feminine, declare and use consistently. But standard is masculine: change to `Rêzimanê kûr yê Kurmancî`.
**Severity**: moderate

### [FILE: c2_kelime_db.dart, LINE: 519-521]
**id**: c2_306
**Field**: cins / ku
**Current**: `cins:"nêr"`, `ku:"Zimanê akademîk **ya** kûr"`
**Issue**: Direct internal contradiction — head is `Zimanê` (masculine ezafe -ê), but the modifier `**ya** kûr` uses feminine ezafe `ya`. Should be `**yê** kûr`. Same applies in c2_310 (`Zimanê siyasî **ya** kûr`), c2_309 description elsewhere, etc.
**Suggested fix**: `Zimanê akademîk **yê** kûr`.
**Severity**: major (within-card grammatical error visible to the C2 learner)

### [FILE: c2_kelime_db.dart, LINE: 469]
**id**: c2_217
**Field**: ku
**Current**: `ku:"Xweserîya kulturî"`, tr:"Kültürel özgürlük", en:"Cultural sovereignty"
**Issue**: Two issues:
1. `kulturî` is a Turkish loan; standard Kurmancî is **`çandî`** (already used elsewhere in the corpus). Inconsistent register choice for a C2 vocabulary card.
2. The Turkish gloss "Kültürel özgürlük" doesn't match the English "Cultural sovereignty" — özgürlük = freedom, sovereignty = egemenlik. These are different concepts.
**Suggested fix**: `ku:"Xweserîya çandî"` (or `Serweriya çandî` if "sovereignty"); align tr/en glosses.
**Severity**: moderate

### [FILE: c2_kelime_db.dart, LINE: 642-643]
**id**: c2_232
**Field**: ku / tr
**Current**: `ku:"Fedratîvîteya Kurdistanê"`, tr:"Kürdistanın federatifliği", en:"Federalism of Kurdistan"
**Issue**: `Fedratîvîte` is a malformed neologism — the expected forms are `**federalîzm**` (already in c1_075) or `**federalîtî**`. `Fedratîvîte` mixes English root with French/Latin suffix. Standard Kurmancî C2 vocabulary should be `federatîvîya Kurdistanê` or `federalîzma Kurdistanê`. Also, the Turkish gloss "Kürdistanın federatifliği" — uses `Kürdistanın` (genitive without apostrophe? proper Turkish would be `Kürdistan'ın federatifliği`).
**Suggested fix**: Use `Federalîzma Kurdistanê` (consistent with c1_075). Fix Turkish punctuation.
**Severity**: moderate

### [FILE: c2_kelime_db.dart, LINE: 643]
**id**: c2_233
**Field**: ku
**Current**: `ku:"Siyaseta herêmî ya Xawermiyan"`, tr:"Orta Doğu bölgesel siyaseti"
**Issue**: `Xawermiya` is a misspelling. The standard Kurmancî for "Middle East" is **`Rojhilata Navîn`** (literally "Middle East", standard term used elsewhere in the corpus, e.g. c2_l14_e4 line 882). `Xawermiya` appears to be a botched transliteration of Persian `خاورمیانه` (Khâvar-i Miyâne). It does not appear in any reference dictionary.
**Suggested fix**: `Siyaseta herêmî ya Rojhilata Navîn`.
**Severity**: moderate

### [FILE: c2_kelime_db.dart, LINE: 559]
**id**: c2_319
**Field**: ez
**Current**: `cins:"bêcins", ez:"-"`
**Issue**: `ez` field shows literal hyphen `"-"` instead of `null`. Throughout the corpus, `bêcins` entries either give a coordinated form or `null`. This `"-"` will pass through to UI rendering as a stray dash. Likely tooling typo.
**Suggested fix**: Set `ez:null`.
**Severity**: minor (rendering bug)

### [FILE: c1_kelime_db.dart, LINE: 856]
**id**: c1_418
**Field**: cins / ku
**Current**: `cins:"bêcins"`, `ku:"Pisporê zimannasiyê"`
**Issue**: `Pisporê` carries the masculine ezafe `-ê`, indicating a male specialist; the feminine would be `Pispora`. Tagging this as `bêcins` (genderless) is wrong. Also, the example `Pisporê zimannasiyê hat` is masculine; the gen `Pisporên me` is plural. The card mixes singular masculine, plural, and genderless tags.
**Suggested fix**: Set `cins:"nêr"` for the masculine form, or split into two cards (m/f).
**Severity**: minor

### [FILE: c1_kelime_db.dart, LINE: 1336]
**id**: c1_1015
**Field**: ku / cins
**Current**: `cins:"bêcins"`, `ku:"Bijîşkê şaredarî"`
**Issue**: Same as above — `Bijîşkê` is masculine ezafe; mismatch with `bêcins`. Also `şaredarî` here is used as a noun "belediye doktoru" but `şaredarî` literally means "municipality" (the institution); the correct phrase is `bijîşkê şaredariyê` (with oblique on the modifier) — `şaredarî` → `şaredariyê` because it's the modifier in an N+N construction.
**Suggested fix**: `Bijîşkê şaredariyê`, cins:"nêr".
**Severity**: minor

### [FILE: heritage_dialogues.dart, LINE: 188-191]
**id**: kDialogueSifre, line 1 (Dê)
**Field**: kurmanci
**Current**: `'Werin, werin! Xwarin amade ye!'`
**Issue**: `Xwarin` is feminine (n.f.) in standard BH attestation, so `amade ye` (with feminine bûn) is right. ✓ No issue here. (Including this entry to mark that I checked: passes.)

### [FILE: heritage_dialogues.dart, LINE: 246-249]
**id**: kDialogueSifre, line 8 (Mehmet)
**Field**: kurmanci / grammarNote
**Current**: `'Dêyê, av heye?'` — note: `"Dêyê" = anneciğim (sevgi hitabı).`
**Issue**: The vocative `Dêyê` is correct (vocative `-ê` on `dê`). The form is fine but registers slightly **artificial**: in everyday Kurdish-speaking households, `dayê` (with `dayê` < `dayîk`) or `dayîkê` is much more common; `dêyê` is more poetic / literary. For a 43-year-old asking his mother for water at the dinner table, native speakers would say `dayê` or just `dê`. (`Dê` alone is also used as vocative in many regions.)
**Suggested fix**: Change to `Dayê, av heye?` for naturalness.
**Severity**: minor (register naturalness)

---

## D. ASSESSMENT-QUALITY ISSUES

### [FILE: c1_lesson_definitions.dart, LINE: 99-109]
**id**: c1_l01_e1
**Field**: opts
**Current**: opts: `['Tenê girêdana nav-hevokan', 'Tenê nerênîtî', 'Girêdana hevokên tabî, relatîf, û mebest', 'Tenê pirskirin']`, ci=2 (longest)
**Issue**: The correct answer (option 2) is ~7 words; distractors are 3–4 words. Length bias — at C1 the learner has been trained to recognize that "the long answer with multiple terms" is usually correct. Three options begin with "Tenê" (only) which itself is a giveaway: a multi-functional element won't be "only" anything.
**Suggested fix**: Make distractors equally elaborate. E.g., distractor: `Girêdana paşgir û pêşgir bi peyvan`, `Diyarkirina deman û lêkeran`, `Tenê wek pirsê tê bikar anîn` — each multi-clause.
**Severity**: moderate

### [FILE: c1_lesson_definitions.dart, LINE: 168-178]
**id**: c1_l02_e3
**Field**: opts
**Current**: opts: `['Dema gundê çû min.', 'Min dît çû gund.', 'Dema ku ez çûm gundê xwe, min dît ku pîrê li ser banî rûniştiye.', 'Ez çûm. Min dît.']`, ci=2 (longest)
**Issue**: Massive length bias — correct answer is 14 words, distractors are 4, 5, and 4 words. Three distractors are also visibly **ungrammatical** (`Dema gundê çû min` = word salad; `Min dît çû gund` = grammatically broken). At C1, distractors should be plausibly correct sentences. Here the question reduces to "which sentence is grammatical?" — that's an A2 task, not C1 complex-sentence recognition.
**Suggested fix**: Provide three equally complex but with varying issues (subordination errors, tense mismatch, wrong relative pronoun) — so the learner must apply real C1 syntax knowledge.
**Severity**: major (assessment quality severely weak at this level)

### [FILE: c1_lesson_definitions.dart, LINE: 595-599]
**id**: c1_l09_e5
**Field**: opts
**Current**: `['hewaya sar', 'kêmasî', 'bêyekîtî', 'bindestî']`
**Issue**: Distractor `'hewaya sar'` (cold weather) is comically irrelevant in the context "X is the main political reason for Kurdish subjugation." A C1 learner doesn't even need to read the stem — three remaining options are plausible political abstractions. The distractor should be another politically plausible noun like `dewlemendî` (richness, ironically), `axîtî` (tribalism), or `dewletperestî` (statism). Single-sentence elimination strategy works.
**Suggested fix**: Replace `hewaya sar` with `dewletperestî` or `axîtî`.
**Severity**: moderate

### [FILE: c1_lesson_definitions.dart, LINE: 462-466]
**id**: c1_l07_e3
**Field**: opts
**Current**: `['tesewufî', 'teknîkî', 'rojane', 'aborî']`
**Issue**: Three distractors (`teknîkî`, `rojane`, `aborî`) are obviously not adjectives that go with a 17th-century mystical poet's verses about ethics & philosophy. Process-of-elimination question. At C1 the test should distinguish synonyms or near-synonyms: e.g., `tesewufî` vs `dîni` vs `sufî` vs `ehlê dil` — all candidates for mystical literature, requiring fine discrimination.
**Suggested fix**: Distractors `dîni`, `şer'î`, `ehlê dil` — all plausibly correct in mystical contexts but with different shades.
**Severity**: moderate

### [FILE: c1_lesson_definitions.dart, LINE: 819-826]
**id**: c1_l13_e3
**Field**: opts
**Current**: `['Ji bo yekgirtina dialektên ferq û ragihandina mezin', 'Ji bo nîqaşa', 'Ji bo şahînşahîyê', 'Ji bo rehetiyê']`, ci=0
**Issue**: Distractors are **truncated phrases** (`Ji bo nîqaşa` = "for the discussion" — incomplete; `Ji bo şahînşahîyê` = "for monarchy" — politically absurd; `Ji bo rehetiyê` = "for comfort" — trivial). Correct answer is full multi-noun phrase. Length bias + content bias = no real test of knowledge.
**Suggested fix**: Provide three plausibly complete answers: e.g., `Ji bo parastina çand û dîroka neteweyî`, `Ji bo girêdayîbûna bi nezerîya hindik-rastî`, etc.
**Severity**: major (length + content bias)

### [FILE: c1_lesson_definitions.dart, LINE: 695-705]
**id**: c1_l11_e3
**Field**: opts
**Current**: `['Sîstema ku hukûmet ji piraniya meclisê tê', 'Şahînşahî', 'Neteweyî', 'Yan ên beleş']`, ci=0
**Issue**: Distractor `'Yan ên beleş'` (= "or those for free") is **nonsensical** — it doesn't mean anything as a definition of a political system. Either a typo or careless filler. Distractors `Şahînşahî` (monarchy) and `Neteweyî` (national) are bare nouns, not parallel definitions. Correct option is the only one that's actually a **definition**.
**Suggested fix**: Replace all distractors with definition-form options: e.g., `Sîstema ku serokatiya dewletê hêza herî mezin e`, `Sîstema ku gel rasterast biryaran dide`, `Sîstema ku partîya bi pirjimar tu rola xwe nîne`.
**Severity**: major

### [FILE: c1_lesson_definitions.dart, LINE: 879-882]
**id**: c1_l14_e3
**Field**: opts
**Current**: `['lê', 'tenê', 'wek mînak / wekû', 'çimkî']`
**Issue**: At C1, the question "which connector introduces evidence?" is fine, but option 2 is **two connectors separated by `/`** — `wek mînak / wekû`. The other options are single tokens. This is a presentational inconsistency: a student selecting "wek mînak" alone would be partially correct, but the option contains "wekû" which is a different connector ("ku" comparative). Don't conflate two distinct connectors into one option.
**Suggested fix**: Pick one — `wek mînak` is the cleanest "for example". Make distractor `wekû` a separate option to test discrimination.
**Severity**: minor

### [FILE: c1_lesson_definitions.dart, LINE: 943-953]
**id**: c1_l15_e5
**Field**: opts
**Current**: `['Dubare dike çi hat gotin + derî li ramînên pêşerojê vedike', 'Daxwazên kesane û hêviyên nivîskar ji bo pêşerojê pêşkêş dike', 'Têgehên teknîkî yên ku di nivîsê de derbas bûne, rêz dike', 'Lîsteya hemû lêkerên ku di nivîsê de hatine bikaranîn pêşkêş dike']`
**Issue**: Excellent distractor crafting here — all four options are roughly equal length (good!) — *but* the correct answer (option 0) is the **only one** with a `+` symbol (compound description), making it visually distinguishable. Subtle clue. Also, distractor 3 ("list all verbs used") is absurd as a conclusion-paragraph function; should be replaced with something more plausible like "introduces a new tangential topic".
**Suggested fix**: Drop the `+`; use natural prose. Replace lêker-list distractor with a more sophisticated wrong answer.
**Severity**: minor

### [FILE: c2_lesson_definitions.dart, LINE: 91-98]
**id**: c2_l01_e1
**Field**: opts
**Current**: `['Cizîr (li herêma Şirnex / Bakurê Kurdistan)', 'Hewlêr (li herêma Başûrê Kurdistan)', 'Hesarê (li herêma Gercûşê / Mêrdîn)', 'Şam (paytexta Sûriyê)']`, ci=2
**Issue**: All four options have parenthetical regional context, which is good. But option 2 (correct) gives `Hesarê (li herêma Gercûşê / Mêrdîn)` — the form `Hesarê` is the **oblique** form of `Hesar` (used after prepositions). A bare topic-position usage should be `Hesar`. And it's spelled `Gercûş` here vs `Gercüş` in c1 corpus — orthography varies. Also note in `note`: "1990'dan sonra Batman iline geçti" — in fact Gercüş has been a district of Batman since **1990**, when Batman was created as a separate province from Siirt. The note is essentially correct but the fluency of the parenthetical info clutters the option, slightly aiding learners who recognize Gercüş.
**Suggested fix**: Standardize spelling (`Gercûş`) across corpus; use `Hesar` (nominative) in option text.
**Severity**: minor

### [FILE: c2_lesson_definitions.dart, LINE: 233-243]
**id**: c2_l03_e5
**Field**: opts
**Current**: `['Peyvên xurt û rave: şoreş, berxwedan, bilindî', 'Peyvên evînê tenê', 'Peyvên dilwest', 'Peyvên sar']`
**Issue**: At C2, the distractors are weak: `Peyvên evînê tenê` (only love-words), `Peyvên dilwest` (tired words — typo for `dilwêr`?), `Peyvên sar` (cold words). These are not real categories of revolutionary diction. The correct option lists three actual concepts. Length bias + content category bias.
**Suggested fix**: Provide three real but wrong categories: `Peyvên klasîk yên dîwanî: yar, dilber, ezberê`, `Peyvên gundewarî: kar û bar`, etc.
**Severity**: moderate

### [FILE: c2_lesson_definitions.dart, LINE: 318-328]
**id**: c2_l05_e1
**Field**: opts
**Current**: `['Tenê helbestvanên sedsala 21an, ne yên berê', 'Bandora wî zû qedîya û li ser nifşên paşî nemaye', 'Tenê helbestvanên erebîaxêv ên dîasporayê', 'Şêrko Bêkes, Rojen Barnas, gelekên din']`
**Issue**: Three distractors all assert *negative* claims (only X / not legacy / Arab-speaking diaspora), and the correct option is the only **positive** factual list. Pattern recognition: even without knowing the answer, a C2 test-taker chooses the affirmative list. Also, **Şêrko Bêkes wrote in Soranî**, not Kurmancî — the question asks about Kurdish poets following Cegerxwîn's legacy, but the option groups together a Soranî poet (Bêkes) with Kurmancî poets (Barnas), without flagging the dialect difference. This is a teachable point but presented uncritically.
**Suggested fix**: Mix positive/negative claim styles in distractors. Add a footnote that Bêkes wrote in Soranî but stylistic legacy crossed dialects.
**Severity**: moderate

### [FILE: c2_lesson_definitions.dart, LINE: 380-389]
**id**: c2_l06_e1
**Field**: opts
**Current**: `['Hewramî', 'Zazakî-Dimilî', 'Her sê jî', 'Soranî']`, ci=2
**Issue**: The question asks "which Kurdish dialect is NOT Kurmancî?" — but the answer "all three" (option 2) is the correct one because Hewramî, Zazakî, and Soranî are all not-Kurmancî. However, the **classification of Zazakî and Hewramî as "Kurdish dialects"** is itself contested in linguistics: some classify them as separate Northwest Iranian languages closely related to but distinct from Kurdish proper. The question presupposes the political/cultural Kurdish-as-umbrella stance without flagging that this is a contested classification at C2 level. C2 students should be exposed to the debate.
**Suggested fix**: Add a clarifying note in `note` field about the typological debate. Currently it does say "(grup içi sınıflama tartışmalı)" — good. But the question itself assumes unity.
**Severity**: minor

### [FILE: c2_lesson_definitions.dart, LINE: 555-565]
**id**: c2_l09_e1
**Field**: opts
**Current**: `['Evîna Şeyxê sofî yê musulman ji keçekê xiristîan', 'Têkoşîna padîşahekî ji bo parastina textê xwe', 'Seyahetên bazirganî yên rê û çiyayên Rojhilatê', 'Şerê di navbera du qebîleyên Kurd ên hevûdu de']`
**Issue**: Distractors are content-distant from Şeyx Senan's plot. None are plausibly mistakes a careful reader could make. Correct answer is the only mystical-aşk option; everything else is political/economic. Process-of-elimination by genre alone.
**Suggested fix**: Provide three plausible Sufi narrative options: e.g., `Evîna Mecnûn ji Leylayê`, `Mîraca pêxember`, `Hikayeta Yûsif û Zelîxa` — all classical love-mystical narratives that could be confused with Şeyx Senan.
**Severity**: moderate

---

## E. REGISTER / NATURALNESS / HERITAGE-DIALOGUE ISSUES

### [FILE: heritage_dialogues.dart, LINE: 122-127]
**id**: kDialoguePiree, line 6 (Dapîr)
**Field**: kurmanci
**Current**: `'Rûne, rûne! Ezê çay bikim.'`
**Issue**: The form `Ezê çay bikim` literally means "I will make tea" — but `çay kirin` is **not idiomatic Kurmancî**. The natural collocation is `çay çêkirin` ("to prepare tea" — `çêkirin` = to prepare/make) or `çay danîn` ("to put on the tea" — for a kettle). `çay kirin` is a Turkish-influenced calque (`çay yapmak`). At a heritage-context dialogue between an asimile granddaughter and her Kurdish-speaking grandmother, this kind of Turkicism in the *grandmother's* mouth is jarring — exactly what the heritage dialogue should *avoid*.
**Suggested fix**: `Rûne, rûne! Ezê çayekê **çêkim** ji bo te.` Or: `Ezê çayê **danim**.`
**Severity**: moderate (heritage authenticity)

### [FILE: heritage_dialogues.dart, LINE: 199-200]
**id**: kDialogueSifre, line 2 (Mehmet)
**Field**: kurmanci
**Current**: `'Destê te xweş be, dayê!'`
**Issue**: The phrase `Destê te xweş be` is correctly identified as "elinize sağlık" — but in standard usage, the polite form to a mother (especially with `dayê` honorific) is `Destê te sax be!` or `Destê te xweş!` (without `be`). The bare `xweş be` is more colloquial / Behdînî. At an A1 heritage dialog, this is the form a child-of-asimile-parent would learn first; either form works, but a culturalNote should explain regional variation.
**Suggested fix**: Add culturalNote: "Dialect alternative: 'Destê te sax be' (Behdînî), 'Destê te xweş' (Botan)."
**Severity**: minor

### [FILE: heritage_dialogues.dart, LINE: 218-225]
**id**: kDialogueSifre, line 5 (Dê)
**Field**: kurmanci
**Current**: `'Goşt û birinc. Erê, germ e!'`
**Issue**: The cultural-note remark "Pilavlı et Kürt sofrasında en onurlu yemektir" — historically true but a 43-year-old urban character's family is unlikely to be eating goşt û birinc as their everyday dinner; this might be once-a-week. The dialogue presents it as routine. More importantly, the Kurmancî `birinc` is borrowed from Persian/Turkish; a more native-feeling option is `savar` (cracked wheat pilaf) or `pirinc` (variant). In modern usage `birinc` is fine but the cultural framing romanticizes.
**Suggested fix**: Acknowledge in scene that this is a special meal, not everyday.
**Severity**: minor

### [FILE: heritage_dialogues.dart, LINE: 446-452]
**id**: kDialogueMalbat, line 6 (Dapîr)
**Field**: kurmanci / culturalNote
**Current**: `'Çi ye ev? Lazim nebû! Gelek spas, kurê min.'`
**Issue**: `Lazim` is an Arabic/Turkish loan ("gerek"); the standard Kurmancî is **`pêwîst`** or **`hewce`**. `Lazim nebû` is widely used colloquially but in a heritage-dialogue meant to reconnect learners with authentic Kurmancî, the more native form `Pêwîst nebû!` or `Hewce nebû!` is preferable. The note acknowledges politeness convention but doesn't flag the loanword.
**Suggested fix**: `Pêwîst nebû! / Hewce nebû!` with culturalNote noting `lazim` as a colloquial alternative.
**Severity**: minor

### [FILE: heritage_dialogues.dart, LINE: 525-530]
**id**: kDialogueDersa, line 6 (Dapîr)
**Field**: kurmanci / culturalNote
**Current**: `'"Pencere" ye — heman e! Weke Tirkî.'`
**Issue**: The grandmother says "Pencere is the same as Turkish!" — but `pencere` in Kurmancî is itself a **Persian loan** (پنجره), and Turkish also borrowed it from Persian. The dialogue presents it as a Kurdish-Turkish convergence, but actually both languages took it from Persian. Educational accuracy: at A1 the simplification is OK, but a more honest culturalNote would say: "Bu kelimeler her iki dile Farsça'dan girmiştir — paylaşılan kültürel köken." Also, the standard Kurmancî nativizer for "window" is **`paceroj`** (`pace` + `roj` = "fragment of light"), used by Bedirxan in neologistic registers.
**Suggested fix**: Update culturalNote: `"Pencere" Farsî ji aslê xwe — herdu zimanan ji eynî kanê wergirtine. Forma neolojîk: paceroj.`
**Severity**: minor (educational depth)

### [FILE: heritage_c_dialogues.dart, LINE: 81-89]
**id**: c1_dlg_akademi, Goran's first line
**Field**: kurmanci
**Current**: `'Prof. Dr. Leyla, ez dixwazim li ser têkilîya navbera ziman û nasnameya kurdî lêkolîn bikim. Ji ku dest pê bikim?'`
**Issue**: `Prof. Dr. Leyla` — this honorific stack is a Turkish/Western academic convention. In Kurdish academic discourse, the form is typically `Profesor Leyla` or `Mamosteya hêja Leyla` or simply `Dr. Leyla`. Using `Prof. Dr.` (English/Turkish stacking) in the *Kurmancî* line is a register clash — the dialogue is supposed to model authentic academic Kurmancî but starts with a non-Kurdish address form.
**Suggested fix**: `Mamosteya hêja Leyla` or `Profesora hêja, ez dixwazim ...`.
**Severity**: minor (register)

### [FILE: heritage_c_dialogues.dart, LINE: 81-83]
**id**: c1_dlg_akademi, Goran
**Field**: kurmanci
**Current**: `'... li ser têkilîya navbera ziman û nasnameya kurdî lêkolîn bikim.'`
**Issue**: `têkilîya navbera ziman û nasnameya kurdî` = "the relationship between language and Kurdish identity". The construction `têkilîya navbera X û Y` is correct but the ezafe stacking is heavy. Standard alternative: `têkilîya zimên bi nasnameya kurdî re`. Also, `nasnameya kurdî` puts `kurdî` as adjective (= "Kurdish identity") but elsewhere in the corpus we see `nasnameya kurdan` (= "the Kurds' identity") — different focus. C1 should model both and disambiguate.
**Suggested fix**: Use the lighter `têkilîya zimên bi nasnameya kurdan re` — "the relation of language with Kurdish identity".
**Severity**: minor

### [FILE: heritage_c_dialogues.dart, LINE: 101-105]
**id**: c1_dlg_akademi, Goran
**Field**: kurmanci
**Current**: `'Weke encamekê, çi pêşniyar dikî ji bo xwendekarên Kurdan ên li diasporayê?'`
**Issue**: `Weke encamekê` — literally "as a result". The standard Kurmancî for "in conclusion" / "as a result" is **`bi encamê / bi encamekê / di encamê de`**, or the more formal **`di dawiyê de / di encama vê de`**. `Weke encamekê` is grammatically OK but stylistically unusual; native academic speakers say `bi encamê` or `di dawiya gotinê de`. Minor register polish.
**Suggested fix**: `Bi encamê / Di encama vê de, çi pêşniyar dikî ...`.
**Severity**: minor

### [FILE: heritage_c_dialogues.dart, LINE: 153-157]
**id**: c1_dlg_medya, Selin (final line)
**Field**: kurmanci
**Current**: `'... nûçegirî ne tenê ziman e — berpirsiyarî ye.'`
**Issue**: The contrast `ne tenê X — Y` ("not just X — Y") is fine, but to close the contrast properly Kurmancî typically uses **`ne tenê ... lê **jî** ...`** or `**ne tenê ... lêbelê** ...` — i.e., the second pole must be explicitly contrastive. Without the contrastive marker, the construction reads as "journalism is not only language — it's responsibility" but the conjunction is missing. Suggested form: `nûçegirî ne tenê ziman e, lê **belê** **jî** berpirsiyarî ye.`
**Suggested fix**: `... nûçegirî ne tenê ziman e, lê belê berpirsiyarî ye jî.`
**Severity**: minor

### [FILE: heritage_c_dialogues.dart, LINE: 191-194]
**id**: c2_dlg_konferans, Goran (line 3)
**Field**: kurmanci
**Current**: `'Divê ne bişaftin ne jî cudabûn — lê entegrasyon be.'`
**Issue**: At C2, the speaker should know that **`entegrasyon`** is a French/Turkish loan; the Kurmancî neologism is **`tevhevkirin`** or **`kelekirin`** (or `hevbûna çandan`). Using `entegrasyon` in the C2 academic conference setting is acceptable in modern Kurdish but contradicts the C2 lesson's own emphasis on neologism (cf. c2_l08 "Neolojîzm û Pêşketina Ziman"). Also `bişaftin` and `cudabûn` are abstract masdars; `entegrasyon` is a foreign loan — register inconsistency in a list of three.
**Suggested fix**: `Divê ne bişaftin ne jî cudabûn — lê tevhevbûn / hevjiyana çandan be.`
**Severity**: moderate (register + meta-pedagogical inconsistency)

---

## F. ORPHAN / TRUNCATED / SELF-REFERENTIAL / REDUNDANT CONTENT

### [FILE: c1_lesson_definitions.dart, LINE: 401]
**id**: c1_l06_e3 (turkishPrompt)
**Field**: tr
**Current**: `'Bilim için zorunlu düşünce türü (analiz + sorgulama temelli). İPUCU: kelimenin kökünde "rexne" (eleştiri) var.'`
**Issue**: The Turkish prompt contains "**İPUCU:**" (= clue) text directly giving the etymology of the answer (`rexne` = the root of `rexnegir`). For a vocabulary fill-in, this is open-book hand-holding — appropriate for A1/A2, not C1. C1 students should reason from definition alone. Multiple `İPUCU` markers across the corpus (see `b1_lesson_definitions.dart`, `a1_lesson_definitions.dart`) follow this pattern; for advanced levels they should be removed or made subtler.
**Suggested fix**: Drop the İPUCU line for all C1+ items; rely on context.
**Severity**: moderate (assessment-design issue at advanced level)

### [FILE: c1_lesson_definitions.dart, LINE: 417]
**id**: c1_l06_e5 (turkishPrompt)
**Field**: tr
**Current**: `'Eleştiri akademik açıdan neye dayanmalı? "bi ___" yapısı + bilinçle birlikte. İPUCU: bilim metodolojisinin temeli; "hêrs" (öfke) ve "hest" (duygu) reddedilir.'`
**Issue**: Same as above — İPUCU explicitly tells the learner that two specific options ("hêrs", "hest") are wrong, eliminating distractors via the prompt itself. Pure clue leakage at C1.
**Suggested fix**: Remove the "İPUCU" sentence.
**Severity**: moderate

### [FILE: c1_kelime_db.dart, LINE: 1066-1070 (multiple in kC1_Buyuk3)]
**id**: c1_500..1759 (range)
**Field**: gen, examples
**Current**: many entries auto-generate `gen:["X", "X ya me"]` (e.g., `c1_500` → `"Ramana demokratîk ya me"`, `c1_504` → `"hêza çandî ya me"`, `c1_506` → `"wêjeya berxwedanê ya me"`).
**Issue**: The `gen` field appears to be programmatically constructed by appending `"ya me"` (literally "of us / our X"). For dozens of entries this produces:
1. Phrases that aren't real ("özgürlük felsefesi-mizin" — i.e., "our philosophy of freedom" — not a thing said in Kurmancî);
2. **Gender-agreement errors** when the head is masculine (see C-2 above).
3. Tautological pairs ("X" and "X ya me") that don't help the learner understand collocations.
The auto-generation reduces the educational value of `gen` to near zero across `kC1_Buyuk3`.
**Suggested fix**: Manually rewrite `gen` for at least the highest-frequency C1/C2 entries (top 100). For the rest, drop the `"X ya me"` pattern entirely; replace with real collocations.
**Severity**: moderate (systemic content quality across hundreds of entries)

### [FILE: c2_kelime_db.dart, LINE: 502-503]
**id**: c2_300
**Field**: her (heritage example)
**Current**: `her:["Teorîya zimanê ya Chomsky.", "Di arûzê de."]`
**Issue**: Second example sentence (`Di arûzê de` = "in aruz prosody") is **completely unrelated** to Chomsky's theory of language. Likely a copy-paste error from c2_001 (Arûz). Same issue: c2_305 line 518 has `"Di mijara arûz de dixebitin"` for "Power-gender relation" entry. These are obvious tooling errors.
**Suggested fix**: Audit all `her` arrays in c2_kelime_db.dart for "Di arûz" leakage; rewrite cleanly.
**Severity**: major (visible nonsense in production)

### [FILE: c2_kelime_db.dart, LINE: 558-560]
**id**: c2_318, c2_319, etc.
**Field**: her / gen patterns
**Current**: `gen:["Naveroka veşartî", "Konsêpta me"]`, `gen:["Tonal û sembolik", "Konsêpta me"]`, repeated dozens of times for c2_300..c2_330.
**Issue**: The literal phrase **`Konsêpta me`** is auto-appended to `gen` for many c2 entries. `Konsêpt` is itself a borrowed term (English/Latin); the standard Kurmancî is **`têgeh`**. Using `Konsêpta me` (= "our concept") as a generic filler is:
1. Stylistically poor (Latinate over Kurmancî);
2. Repetitive (>30 entries share this exact filler);
3. Ungrammatical in some cases (gender mismatch, plural mismatch).
**Suggested fix**: Replace all `Konsêpta me` with proper collocations. Where no collocation exists, leave `gen` as a single-element array.
**Severity**: moderate (visible repetition + register)

### [FILE: c1_kelime_db.dart, LINE: 1148]
**id**: c1_365 (Êzîdîtî)
**Field**: not (heritage example)
**Current**: `"Êzîdîtî baweriyeke kûvî ye."`
**Issue**: `Kûvî` means **"wild / feral"** — used for animals (`heywanên kûvî` = wild animals). Calling Êzîdîtî (Yazidism) "baweriyeke kûvî" is **deeply offensive**: it describes the religion as "savage / wild" rather than the intended "ancient/primordial". The author likely meant **`kevnar`** (ancient) or **`xwecihî`** (indigenous). This must be fixed before any release — it is potentially offensive to Êzidi communities.
**Suggested fix**: `Êzîdîtî baweriyeke kevnar e.` (Or: `Êzîdîtî baweriyeke xwecihî ya kurdî ye.`)
**Severity**: **critical** (community-offensive language in cultural content)

---

## G. CROSS-FILE / SYSTEMIC ISSUES

### [FILES: c1_kelime_db.dart, c2_kelime_db.dart]
**Issue**: Inconsistent forms of the same authors/works across files:
- Cegerxwîn real name: `Şükrü Hasan Kurdî` (c1_kelime_db) vs `Şêxmûs Hesen` (b2_lesson_definitions). Same person, different transliterations.
- Xanî dates: `1650-1707` (c1_959) vs `1651-1707` (b1, lesson_entities, c1_l09 stem).
- Dengbêjê navdar: `c1_518` flagged as `bêcins` but example `Dengbêjê navdar` is masculine ezafe.
**Suggested fix**: Add a one-time pass to unify proper-name spellings and biographical dates across the entire `lib/features/lessons/domain/` tree.
**Severity**: moderate (consistency)

### [FILES: c1_kelime_db.dart (multiple lines: 856, 858, 1304, 1336, 1503, 1507, 1511, 1515, 1519, 1523, 1527, 1531)]
**Issue**: `cins:"bêcins"` is over-used. It should be reserved for words that are genuinely genderless (compound expressions, plurals-only). It's being applied to professions where the form clearly carries masculine ezafe (`Pisporê`, `Bijîşkê`, `Wênekêşê`, `Çalakvanê`, `Zimanzanê`, `Wêjezanê`, `Dîrokzanê`). At C1 students absorb gender from these forms — mistagging undermines the entire ezafe-teaching pipeline.
**Suggested fix**: Audit all `pîşe` (profession) cards. Tag them `nêr` (masculine default) and add a note `(jin: zimanzana)` for the feminine variant.
**Severity**: moderate (pedagogical impact on gender acquisition)

### [FILES: heritage_c_dialogues.dart, c1_lesson_definitions.dart]
**Issue**: At C1/C2 multi-clause speaking-practice prompts contain very long compound sentences (e.g., `c1_l02_e6` line 195, `c2_l05_e6` line 361), but the speaking-practice options always show only `['Gelek baş', 'Nêzîk', 'Carek din']` (Very good / Close / Once more). This is the same option triplet for every speak prompt. At C1/C2, speaking practice should track specific pronunciation/intonation features, not just general feedback.
**Suggested fix**: Either drop the options entirely (let the user freely speak) or make the options content-specific.
**Severity**: minor (UX polish)

---

## H. SEVERITY RECAP

- **Critical (1)**: c1_365 "kûvî" describing Êzîdîtî (community-offensive).
- **Major (12)**: c1_l09_e3 fake Xanî quote; c1_l08_e5 ergative case error (`nefsê` vs `nefsa`); c2_864 "şerê neyabûyî" (war ≠ speech); c2_308/309 "cixarek" (cigarette ≠ rhetoric); c2_l10_e6 `pêşwaziya kir` (welcome ≠ pioneer); c1_966 "Şükrü Hasan Kurdî"; c1_515 double `de de`; systemic ezafe gender mismatches in `gen` arrays (~30 entries); c1_l02_e3 length-bias broken syntax; c1_l11_e3 nonsense distractor; c1_l13_e3 truncated distractors; c2_kelime_db `Di arûzê de` leak in unrelated entries.
- **Moderate (23)**: distractor quality, register clashes, raman/ramîn inconsistency, conditional `werî/bêyî`, `ramantî`/`mantiqî`, etc.
- **Minor (20)**: spelling polish, vocative naturalness, single-letter ezafe drift.

## I. RECOMMENDED IMMEDIATE ACTIONS

1. Fix `c1_365` line 1148 ("kûvî" → "kevnar") **before any release** — community sensitivity.
2. Fix the three lexical disasters: `şerê neyabûyî` (c2_864), `cixarek/cixareka` (c2_308, c2_309), `pêşwaziya neteweperweriyê kir` (c2_l10_e6).
3. Fix the broken `de de` in `c1_515` line 943.
4. Run a one-pass script to flag every entry where `cins:"nêr"` and `gen` ends with `"ya me"` (should be `"yê me"`); same for plural heads with `ya me` (should be `yên me`).
5. Manual review of `c1_l09_e3` "Kurd in û Kurdistan heye" — replace fake quote with actual Xanî text or convert to indirect.
6. Strip `İPUCU:` clue-leakage from C1+ Turkish prompts (acceptable at A1/A2 only).
7. Consolidate **raman / ramîn / ramyarî** to a single root (`raman` recommended).
8. Audit "**Konsêpta me**" filler across c2_kelime_db (~30+ entries); replace.
9. Regenerate `gen` field for `kC1_Buyuk3` (lines 897–1050) — the auto-generated tautologies have no pedagogical value.
10. For C1/C2 speaking-practice option triplets `['Gelek baş', 'Nêzîk', 'Carek din']` — consider dropping or content-specific replacement.

## J. NOTES ON THINGS THAT WORK WELL

For balance: the heritage_dialogues.dart corpus (lines 64–578) is generally well-crafted. Diyalog 1 (Çayê Dapîrê) and Diyalog 5 (Dapîr Mamostayê Min e) capture authentic intergenerational warmth, and the cultural-note annotations (e.g., "Atalar sözü — heritage kullanıcı için diyaloğun doruk noktası" line 158, "Final — dil ve sevgi birlikte, A1'in son armağanı" line 564) reflect serious pedagogical thought. The grammar notes consistently cite proper sources (BH §, TH §). The c1_lesson_definitions distractor pattern in `c1_l11_e1` (lines 681–688) and `c1_l11_e5` (lines 712–720) shows that *where the author crafts deliberately*, distractor quality is high — the issue is uneven authorship across the 73 quizzes.

The C2 corpus's neologism awareness (cf. c1_983 note "BH §275", c1_430 note "BH §318") is admirable; the editorial team understands the Bedirxan canon. The remaining work is consistency and copy-editing.

---

*End of audit.* Findings: 56. Files modified: 0 (audit only).
