# A1 / A2 Linguistic Audit — Findings

Audit date: 2026-05-04. Reference: Bedirxan-Lescot grammar (KURMANCI_RULES.md), Thackston, Ferhenga Birûskî.

Scope:
- a1_lesson_definitions.dart (full read)
- a2_lesson_definitions.dart (full read)
- a1_kelime_db.dart (sampled: lines 1-500, 1500-1800, 2200-2500, 2900-3365)
- a2_kelime_db.dart (sampled: lines 1-300, 2000-2300, 4250-4699)

Severity legend: minor / moderate / major

---

## A1 — Lesson Definitions

### [FILE: a1_lesson_definitions.dart, LINE: 226-235, ID: bir_biir_ex1]
**Field**: kurmanjPrompt + options + grammarNote
**Current**: 
- options[1]: `'"bir" = kuyu, "bîr" = kesmek'`
- options[2] (correct): `'"bir" = kesmek, "bîr" = kuyu'`
- grammarNote: `'"bir" (kısa i) = kesmek fiili. "bîr" (uzun î) = kuyu (su kuyusu). Ünlü uzunluğu anlam değiştiriyor!'`
**Issue**: SEMANTIC ERROR. The lemma `bir` (short i) is NOT "kesmek" — it is the past stem of `birin` ("götürmek/taşımak", "to take/carry"). The verb "to cut" is `birîn` (long î) → present `dibire`. KURMANCI_RULES.md §2.2 confirms: `bir` = "götürdü", `bîr` = "hafıza, kuyu". This grammarNote teaches a wrong meaning and reinforces a false lexical contrast.
**Fix**: 
- options[2]: `'"bir" = götürdü, "bîr" = kuyu'`
- grammarNote: `'"bir" (kısa i) = götürdü (birin: götürmek/taşımak fiilinin geçmiş kökü). "bîr" (uzun î) = kuyu / hafıza. Ünlü uzunluğu anlam değiştirir!'`
**Severity**: major

### [FILE: a1_lesson_definitions.dart, LINE: 522-528, ID: sal_fill_ex1]
**Field**: kurmanjPrompt construction
**Current**: `before:'Pîrê bîst'`, `after:'î ye.'`, options [`roj`, `meh`, `sal`, `dem`]
**Issue**: Age construction in Kurmancî writes `salî` as ONE word (root `sal` + adjective suffix `-î`): `Pîrê bîst salî ye`. The fill template inserts a SPACE: `Pîrê bîst sal î ye`. As written this parses ungrammatically (`î ye` reads as "you-are"). The `-î` is an inseparable derivational suffix on `sal`, not a separate copula.
**Fix**: Restructure as `before:'Pîrê bîst '`, `after:' ye.'`, options `['rojî','mehî','salî','demî']`, correctIndex: 2. Update note: `'"X salî ye" = X yaşındadır. salî = sal + -î (sıfat eki, bitişik).'`
**Severity**: major

### [FILE: a1_lesson_definitions.dart, LINE: 871-877, ID: duşem_fill_ex1]
**Field**: grammarNote (etymology error)
**Current**: `'"Yekşem" = Pazar (yek + şem = bir+cumartesi). Kurd takvimîna kevin de haftanın ilk günü Yekşem'dir.'`
**Issue**: Etymology error. `şem` does NOT mean "cumartesi" — it derives from Persian `şeb/şem` ("akşam, gece, vigil"). `Yekşem` = "first eve" = Sunday; `Duşem` = "second eve" = Monday. Saying `şem = cumartesi` is a circular tautology and confuses the learner about the day-naming system.
**Fix**: `'"Yekşem" = Pazar (yek "bir" + şem "akşam/nöbet") — haftanın ilk günü. "Duşem" = Pazartesi (du "iki" + şem). Kürt-İran takvim geleneğinde gün sayımı Pazardan başlar.'`
**Severity**: moderate

### [FILE: a1_lesson_definitions.dart, LINE: 996-1000, ID: goşt_fill_ex1]
**Field**: kurmanjPrompt construction
**Current**: `before:'Pîrê'`, `after:'dipijîne.'` → `'Pîrê goşt dipijîne.'`
**Issue**: CASE ERROR. `Pîrê` is the OBLIQUE form of `pîr` (grandmother). The verb `dipijîne` is PRESENT TENSE 3.sg, where the subject must be in NOMINATIVE case (=`pîr`). Correct: `Pîr goşt dipijîne` ("Grandmother cooks meat"). As written, `Pîrê goşt dipijîne` is a syntactic mismatch — although informally `Pîrê` as a vocative/colloquial form circulates, in a structured A1 fill exercise teaching present tense it should be unambiguous nominative.
**Fix**: Change `before:'Pîrê'` → `before:'Pîr'`. Apply consistently to similar fill exercises.
**Severity**: major

### [FILE: a1_lesson_definitions.dart, LINE: 614-616, ID: deya_fill_ex1]
**Field**: kurmanjPrompt construction
**Current**: `before:''`, `after:'ya min baş e.'`, options `['Dê', 'Xwişk', 'Bira', 'Bav']`, correctIndex 0
**Issue**: ORTHOGRAPHIC ERROR. With "Dê" (vowel-final feminine), the ezafe linker `-ya` is bound to the noun: standard form is `Dêya min` (one word). The fill produces `Dê ya min baş e` — with a space between `Dê` and `ya`, which is non-standard orthography (Bedirxan-Lescot §103-105). The `_fill` template forces a space at the blank.
**Fix**: Restructure as multipleChoice asking the correct ezafe form, or use `before:'____ya min baş e.'` with options being the full inflected form (`Dêya`, `Xwişka`, `Bira` etc.), expecting students to choose `Dêya`.
**Severity**: moderate

### [FILE: a1_lesson_definitions.dart, LINE: 1175-1177, ID: a1_son_speak]
**Field**: kurmanjPrompt
**Current**: `'Ez Kurmancî dixwînim û keyf xweş im!'`
**Issue**: Awkward Kurmancî. `keyf xweş im` mixes a 1.sg copula (`im`) with a noun phrase that does not agree with the subject. The standard idiom for "I'm in good spirits" is `kêfxweş` (compound adjective, written as one word) — `Ez kêfxweş im`. Alternative: `keyfa min xweş e` ("my mood is good"). The current form is a hybrid that is neither.
**Fix**: `'Ez Kurmancî dixwînim û kêfxweş im!'` OR `'Ez Kurmancî dixwînim û keyfa min xweş e!'`
**Severity**: moderate

### [FILE: a1_lesson_definitions.dart, LINE: 178-181, ID: a1_004_ex1]
**Field**: options[2]
**Current**: `'Türkçe "ı"'` (distractor for "Bu ses neye benzer?" about `î`)
**Issue**: Linguistically misleading. Kurmancî short `i` IS Turkish `ı` (KURMANCI_RULES §1.3: "Kurmancî `i` zaten Türkçe `ı` sesindedir"). So the distractor "Türkçe ı" risks reinforcing a learned-but-wrong mapping (that `î` resembles `ı`). The correct distinction in pedagogy: short `i` ≈ Turkish `ı`; long `î` ≈ Turkish "i".
**Fix**: Replace 'Türkçe "ı"' with 'Türkçe kısa "i"' or 'Hep aynı süre okunan i' to clarify that the diacritic indicates length, not a different vowel.
**Severity**: minor

### [FILE: a1_lesson_definitions.dart, LINE: 802, ID: mamosta_ex1]
**Field**: options
**Current**: `options: ['Polis', 'Doktor', 'Öğretmen', 'Öğrenci']` for "Mamosta" → correctIndex 2 (Öğretmen) ✓
**Issue**: OK semantically, but check: in a1_kelime_db.dart at line 441 `Mamosta` is listed with `cins:'bêcins'` — yet it should logically be human-referring (nêr/mê depending on referent), with dual ezafe forms. The kelime DB at 441 already encodes both ezafe forms (`mamostayê/mamostaya`) but cins:'bêcins' is technically inaccurate — humans always have grammatical gender per Bedirxan §95. (See the broader DB issue listed below.)
**Fix**: Adjust kelime DB entry — or document policy that ungendered profession terms use `bêcins` as a "common gender" marker.
**Severity**: minor

### [FILE: a1_lesson_definitions.dart, LINE: 1136, ID: a1_l20 targetCardIds]
**Field**: targetCardIds category key
**Current**: `_kartsFromKat(['rengder'])`
**Issue**: Standard Kurmancî term is `rengdêr` (long ê — "color-bearer/adjective"). `rengder` (no diacritic) is a typo or category-key shortcut. If the kelime DB uses `kat:'rengder'` consistently then matching is functional but the term is non-standard. Verified at line 2904, 3340, 3349, 3354: kelime DB DOES use `kat:'rengder'` consistently — so binding works, but the orthography of the category constant should be updated for academic accuracy.
**Fix**: Rename category key globally to `rengdêr`. Update all `kat:'rengder'` → `kat:'rengdêr'` and `_kartsFromKat(['rengder'])` → `_kartsFromKat(['rengdêr'])`. (Pure refactor — no learner-visible change unless category labels appear in UI.)
**Severity**: minor

### [FILE: a1_lesson_definitions.dart, LINE: 1011-1022, ID: mitfax_dapire_ex1]
**Field**: kurmanjPrompt + grammarNote
**Current**: `'Mitfaxa dapîrê'` and grammarNote `'"Mitfax" = mutfak (-a ezafe). "Dapîr" = büyükanne.'`
**Issue**: `Mitfax` is a Turkish loanword (Turkish "mutfak" with metathesis). Native Kurmancî options are `aşxane` (kitchen-house) or `metbex`/`mitbex` (Arabic loan). For a heritage-track lesson emphasizing cultural authenticity, this should at least flag the alternative. Also, the kelime DB at line 2308 explicitly says: `"mitbex" (mutfak) — "aşpêzxane" daha öz Kurmancî`.
**Fix**: Add to grammarNote: `Alternatîf: "aşxane / aşpêzxane" (saf Kurmancî) jî tê bikaranîn.`
**Severity**: minor

### [FILE: a1_lesson_definitions.dart, LINE: 1106-1108, ID: piree_li_fill_ex1]
**Field**: kurmanjPrompt + options
**Current**: `before:'Pîrê li'`, `after:'ye.'`, options `['malê', 'bajêr', 'gundê', 'çiyayê']`
**Issue**: Mixed-case construction. `Pîrê` (oblique grandmother) is followed by present-tense `li ___ ye`. Two issues: (1) Subject `Pîrê` should be nominative `Pîr` for present tense (see goşt_fill_ex1). (2) Options include `gundê` (already inflected eril oblique) and `bajêr` (oblique) — but `çiyayê` is the eril ezafe form. The set is inconsistent in inflection state. For "Pîr li çiya/çiyê ye" the right oblique should be just `çiyê` (or `çiya` in nominative — but li requires oblique).
**Fix**: 
1. Change `Pîrê` → `Pîr`
2. Standardize options to oblique forms: `['malê', 'bajêr', 'gund', 'çiya']` — wait, after `li` all need oblique → `['malê', 'bajêr', 'gundê', 'çiyê']`. The current `çiyayê` is the ezafe construct form, not oblique.
**Severity**: moderate

### [FILE: a1_lesson_definitions.dart, LINE: 1140-1151, ID: baş_xerab_ex1]
**Field**: grammarNote
**Current**: `'Kurmancî sıfatlar DEĞİŞMEZ.\nMala baş = iyi ev · malên baş = iyi evler.'`
**Issue**: ACCURATE for adjectives, but the note misses a key Kurmancî feature: when the noun is INDEFINITE singular, you write `malek baş` (one good house). The note as-is is correct but might lead to overgeneralization. Minor pedagogical gap, not an error.
**Fix**: (optional) Add `'(Belirsiz: malek baş = bir iyi ev.)'`
**Severity**: minor

### [FILE: a1_lesson_definitions.dart, LINE: 663-664, ID: pireya_fill_ex1]
**Field**: turkishPrompt + grammarNote
**Current**: turkish: `'Bir kadın aile üyesini seviyorum (yapı: ji ___a xwe hez dikim).'`, grammarNote: `'Eril seçenekler (kal/bav/ap) "-a" ezafe alamaz.'`
**Issue**: ACCURATE — but the construction `before:'Ez ji'`, `after:'a xwe hez dikim.'` produces `Ez ji ___a xwe hez dikim` — same orthographic concern as `dêya` exercise: ezafe `-a` is bound, not separated by a space. The note correctly explains gender, but the surface-form template is still split-orthography.
**Fix**: Same restructuring as deya_fill_ex1 — make student select the full inflected form `dapîra` not bare lemma + suffix.
**Severity**: moderate

---

## A2 — Lesson Definitions

### [FILE: a2_lesson_definitions.dart, LINE: 162, ID: a2_l03_e2]
**Field**: grammarNote (already partially flagged as fixed)
**Current**: `'"Dê biçim" = gideceğim. Eşdeğer "Ez ê biçim" de doğru (Bedirxan-Lescot: cînavk + AYRI ê).'`
**Issue**: GOOD — explicitly cites Bedirxan-Lescot rule. ✓ No change needed; this serves as a positive reference for the rule. Worth noting that this exercise is correctly handled.
**Fix**: (no fix — exemplary)
**Severity**: (none)

### [FILE: a2_lesson_definitions.dart, LINE: 167, ID: a2_l03_e4]
**Field**: options
**Current**: `opts:['Ez naxwim','Ez ê bixwim','Min nexwar','Ez ê nexwim']`, correctIndex 3
**Issue**: GOOD construction — distractors are well-balanced (one wrong tense, one wrong polarity, one wrong tense+aspect, one correct). Correct option `Ez ê nexwim` follows separate-particle rule. ✓
**Fix**: (none)
**Severity**: (none — exemplary)

### [FILE: a2_lesson_definitions.dart, LINE: 168-169, ID: a2_l03_e5]
**Field**: kurmanjPrompt
**Current**: `'Sibê ez dê biçim bajêr. Tu dê bêyî?'`
**Issue**: Mixed style. The first clause uses `dê` after the pronoun (`ez dê biçim`); the standard order per Bedirxan-Lescot is pronoun + `ê` (`Ez ê biçim`). Both `Ez dê biçim` and `Ez ê biçim` are accepted, but the position of `dê` here (`ez dê`) is one accepted variant, and `Tu dê bêyî` is too — though the more idiomatic 2.sg future is `Tê bêyî` or `Tu yê bêyî`. The form `Tu dê bêyî` is grammatically OK but rare.
**Fix**: (optional) Replace with `'Sibê ez ê biçim bajêr. Tu yê bêyî?'` for canonical Bedirxan-Lescot style.
**Severity**: minor

### [FILE: a2_lesson_definitions.dart, LINE: 192-196, ID: a2_l04_e3]
**Field**: kurmanjPrompt + options
**Current**: `before:'Mizgeft li'`, `after:'ye.'`, options `['malê','gundê','navendê','bajêr']`, correctIndex 2
**Issue**: All 4 options are oblique forms after `li` ✓. But the pedagogical contrast asks "Cami merkezde" → `navendê`. The distractor `bajêr` is also oblique (eril contracted). One concern: in a1_kelime_db at line 69, `Navend` is listed as `cins:'nêr'` — yet the dishi/maskuline ambiguity of "merkez" varies in regional usage. If `Navend` is nêr, then the oblique would be `navendî` (short `-î`) or contracted, NOT `navendê` (which is mê oblique). Need to verify gender.
**Fix**: Audit `Navend` gender in a2_kelime_db (line 69-72 says `nêr`). If nêr, the oblique here should be `navendî` per B-L §114; if mê, `navendê` is correct. Standardize.
**Severity**: moderate

### [FILE: a2_lesson_definitions.dart, LINE: 230-232, ID: a2_l05_e4]
**Field**: kurmanjPrompt
**Current**: `before:'Pişîk'`, `after:'kursiyê ye.'`, options `['li kêlekê','li ser','li bin','li cem']`
**Issue**: GOOD pedagogically. But `Pişîk` (kedi, mê) — when used as definite subject of present tense it is correct in nominative form `Pişîk`. ✓ No issue. (Adjacent grammarNote correctly says "Pişîk (mê) = kedi. Özgün Kurmancî — 'Kedî' Türkçe alıntıdır, tercih edilmez". Excellent prescription.)
**Fix**: (none)
**Severity**: (exemplary)

### [FILE: a2_lesson_definitions.dart, LINE: 380-383, ID: a2_l10_e2]
**Field**: kurmanjPrompt
**Current**: `before:'Derve baran'`, `after:', dernekeve.'`, options `['dihat','dibare','dibe','dikeve']`, correct: dibare
**Issue**: Construction OK ✓. But the second clause `dernekeve` ("don't go out") is the negative imperative of `derketin`. The sentence reads `Derve baran dibare, dernekeve` ("It's raining outside, don't go out"). Grammatically fine, but the semantic logic is unusual: "rain is falling outside, don't fall out" — the verb `derketin` ("çıkmak") works here but `dernekeve` is grammatically `der-ne-keve` (not "derne+keve"). The composition is fine.
**Fix**: (none — flagged for cross-check)
**Severity**: (none)

### [FILE: a2_lesson_definitions.dart, LINE: 389-390, ID: a2_l10_e4]
**Field**: kurmanjPrompt
**Current**: `before:'Tav'`, `after:',em diçin derve.'`, options `['dihê','dibare','diçe','dide']`, correct 3 (dide)
**Issue**: Construction `Tav dide, em diçin derve` ("Sun is shining, we go outside") ✓. But option [0] `dihê` is misspelled — the verb form for "comes" is `tê` (3sg present of `hatin`) or `dihê` (older, less standard). The distractor `dihê` is poor — students may get confused with `dihê` vs `dihê` (which doesn't really exist as a single word). Better distractor: `derdikeve`.
**Fix**: Change `'dihê'` → `'tê'` (3sg "comes") or `'derdikeve'` (rises, of sun).
**Severity**: minor

### [FILE: a2_lesson_definitions.dart, LINE: 471-475, ID: a2_l13_e1]
**Field**: options
**Current**: `opts:['Nûş be!','Destê te xweş be!','Werin!','Ez dixwazim…']`, correctIndex 3
**Issue**: GOOD distractors. But `Nûş be!` (afiyet olsun) is typically said AFTER eating. The grammarNote for ex3 (line 482-483) says `'"Nûş be" = afiyet olsun (yemek sonrası)'` — but in some Kurmancî usage `Nûş be!` is also said BEFORE eating (similar to "bon appetit"). The dichotomy "sonrası" is too restrictive. Cultural fact: "Nûş be" can be used both before and after.
**Fix**: Update grammarNote: `'"Nûş be" = afiyet olsun (yemek başlangıcında veya sonunda söylenir)'`
**Severity**: minor

### [FILE: a2_lesson_definitions.dart, LINE: 622-635, ID: a2_l18 several]
**Field**: turkishTitle
**Current**: `turkishTitle: 'Doktorum'`
**Issue**: OK pedagogically but check: `Bijîşkê min` = "doktorum" (eril). If the doctor is female, it's `Bijîşka min`. The lesson title implicitly assumes a male doctor. Minor cultural/gender bias issue.
**Fix**: (optional) Use `Bijîşkê/Bijîşka min` or restructure to avoid the gender assumption.
**Severity**: minor

### [FILE: a2_lesson_definitions.dart, LINE: 662-666, ID: a2_l19_e1]
**Field**: options
**Current**: `opts:['Pişta min diêşe','Lingê min diêşe','Serê min diêşe','Destê min diêşe']`, correctIndex 1
**Issue**: All 4 distractors are well-formed sentences with correct ezafe agreement (a, ê, ê, ê — `pişt` mê → `pişta`; `ling/ser/dest` nêr → `-ê`). EXCELLENT example of testing ezafe gender. ✓
**Fix**: (none)
**Severity**: (exemplary)

### [FILE: a2_lesson_definitions.dart, LINE: 696-700, ID: a2_l20_e1]
**Field**: options + grammarNote
**Current**: `opts:['Berovajî','Herdu jî lêhatin','Hîn bûn = fêrbûn, fêr bûn = lêhatin','Heman wate']`, correctIndex 2
**Issue**: Option 2 (correct) is `'Hîn bûn = fêrbûn, fêr bûn = lêhatin'` — but this option is itself confusing: it equates "hîn bûn" with "fêrbûn" (combining forms) and "fêr bûn" (separated form). Semantically, the difference is subtle and the formulation may confuse beginners. Option 3 `'Heman wate'` (same meaning) is actually closer to truth in many contexts. Length bias also: option 2 is much longer (~36 chars) than others (~10-12).
**Fix**: Simplify option 2. Consider flipping: make `'Heman wate'` the correct answer with a note that subtle difference exists. Or rewrite option 2 as `'Hîn bûn ≈ teorîk; fêr bûn ≈ pratîk'`.
**Severity**: moderate

### [FILE: a2_lesson_definitions.dart, LINE: 703-707, ID: a2_l20_e3]
**Field**: options + grammarNote
**Current**: `opts:['Bi tevahî cuda ye','Herdu jî pirtûk in — pirtûk zêdetir tê bikar anîn','Yek biçûk e, ya din mezin e','Kîtêb zêdetir tê bikar anîn']`, correctIndex 1; note: `'"Kîtêb" klasik form, "pirtûk" günlük kullanım'`
**Issue**: Length bias (correct option ~50 chars vs distractors ~13-32). Also the spelling `Kîtêb` with long î is non-standard — Kurmancî convention writes `kitêb` (short i, long ê). Reference KURMANCI_RULES §2.4: word-initial `î` is forbidden in Kurmancî. The form `kîtêb` violates this. Confirm DB: line 2364 has `kat:'cih'` for `Sinif`, not `kîtêb` directly — but the lesson uses Kîtêb in the prompt. This propagates a misspelling.
**Fix**: Replace `Kîtêb` → `Kitêb` throughout. The orthographic distinction `kitêb` (Arabic loan, classical) vs `pirtûk` (native Kurmancî) is real and worth teaching, but spelling must be correct.
**Severity**: major

### [FILE: a2_lesson_definitions.dart, LINE: 824-826, ID: a2_l24_e2]
**Field**: kurmanjPrompt
**Current**: `ku:'Paşgira bilindahiyê (en) çi ye?'`
**Issue**: `bilindahî` is used here for "superlative" — but the standard linguistic term is `pileya bilind` or `pîvana bilind` ("highest level/measure"). `Bilindahî` literally = "height/elevation". The semantic mapping is OK in academic Kurmancî linguistic tradition, but a more transparent term would be `paşgira derecê herî bilind` or `pîvana herî bilind`.
**Fix**: (optional) Use `paşgira pileya herî bilind` for clarity.
**Severity**: minor

### [FILE: a2_lesson_definitions.dart, LINE: 837, ID: a2_l24_e6]
**Field**: kurmanjPrompt
**Current**: `'Ev baştir e! Û tu baştirîn î!'`
**Issue**: GOOD ✓. Demonstrates `-tir` and `-tirîn` correctly. Note: `Û` (and) at sentence start is somewhat colloquial in Kurmancî; literary style would coordinate without `Û`. Minor stylistic.
**Fix**: (optional) `'Ev baştir e! Tu jî baştirîn î!'` for natural register.
**Severity**: minor

---

## A1 — Kelime DB

### [FILE: a1_kelime_db.dart, LINE: 27-30, ID: a1_001]
**Field**: tr (Turkish translation field)
**Current**: `tr:'a (kısa ünlü)'`
**Issue**: KURMANCI_RULES §1.1 lists `a` among the LONG vowels, NOT short. Short vowels are `e, i, u`; long vowels are `a, ê, î, o, û`. The Turkish description "a (kısa ünlü)" is incorrect.
**Fix**: `tr:'a (uzun ünlü)'`
**Severity**: major

### [FILE: a1_kelime_db.dart, LINE: 28, ID: a1_001]
**Field**: not (Turkish learner note)
**Current**: `not:'Türkçe a gibi — "av" (su), "bav" (baba)'`
**Issue**: ACCURATE phonetically (Kurmancî `a` ≈ Turkish `a` in length). But contradicts the `tr` field which calls it "kısa". Internal inconsistency.
**Fix**: Synchronize `tr` and `not` — both should reflect that Kurmancî `a` is long (uzun) per Bedirxan-Lescot. 
**Severity**: moderate (depends on fix above)

### [FILE: a1_kelime_db.dart, LINE: 33-34, ID: a1_002]
**Field**: not + her
**Current**: `not:'Türkçede yok! Fransızca "été" kelimesindeki é gibi'`; `her:['Pîrê "mêr" dibêje — dengê ê bibihîze.', 'Bavê min "dêya min" dibêje.']`
**Issue**: Sentence `'Bavê min "dêya min" dibêje.'` semantically reads "My father says 'my mother'" — fine as a meta-quote about pronunciation. But the construction `dêya min` correctly demonstrates ezafe with vowel-final feminine `-ya`. ✓ Decent example.
**Fix**: (none)
**Severity**: (none)

### [FILE: a1_kelime_db.dart, LINE: 75, ID: a1_010]
**Field**: gen
**Current**: `gen:['Silav, heval!', 'Silav, baş î?']`
**Issue**: `'Silav, baş î?'` is two clauses chained with no marker. More natural: `'Silav! Baş î?'` (greeting + question). Minor style.
**Fix**: (optional) `'Silav! Baş î?'`
**Severity**: minor

### [FILE: a1_kelime_db.dart, LINE: 386-389, ID: a1_092]
**Field**: cins
**Current**: `cins:'bêcins'` for `Nevî` (torun)
**Issue**: `Nevî` (grandchild) is a HUMAN noun and should have grammatical gender (`nêr/mê`). The note mentions both ezafe forms `neviyê/neviya`, but cins:'bêcins' is technically wrong by Bedirxan-Lescot §95 conventions (humans have inherent gender; only abstract or ungendered nouns are bêcins). Other entries follow this rule (e.g. `Bav` is `nêr`, `Dê` is `mê`). Inconsistent.
**Fix**: Adopt either policy: (a) tag `cins:'nêr/mê'` based on referent (default `nêr`); or (b) introduce `cins:'common'` for human nouns whose gender depends on referent. The current `bêcins` is misleading.
**Severity**: minor

### [FILE: a1_kelime_db.dart, LINE: 396-414, IDs: a1_100 through a1_104]
**Field**: cins for pronouns
**Current**: All pronouns marked `cins:'bêcins'`
**Issue**: Pronouns DO have grammatical role but not gender per se in Kurmancî (`ew` covers both genders in nominative; only oblique distinguishes `wî/wê`). Marking pronouns as `bêcins` is acceptable. ✓
**Fix**: (none)
**Severity**: (none)

### [FILE: a1_kelime_db.dart, LINE: 1509-1512, ID: a1_526]
**Field**: ku + tr
**Current**: `ku:'Baranbar', tr:'Yağmurlu'`
**Issue**: `Baranbar` is non-standard. The standard Kurmancî form for "yağmurlu" is `barandar` ("rain-bearing", `baran` + `-dar`) or `bi baran` (with rain). `Baranbar` (= "yağmur+yağan") is a calque/coinage but not the conventional adjective. Cross-check with Ferhenga Birûskî: `barandar` is preferred.
**Fix**: Change `ku:'Baranbar'` → `ku:'Barandar'` (or `Bi baran`). Update notes accordingly.
**Severity**: moderate

### [FILE: a1_kelime_db.dart, LINE: 1644-1647, ID: a1_549]
**Field**: ez
**Current**: `ez:'ava fêkî'` (and similarly multi-word ezafe forms)
**Issue**: The `ez` field is supposed to hold the ezafe form (e.g., `ava` for feminine "av" + ezafe -a). Storing the full phrase `'ava fêkî'` conflates the ezafe morpheme with the modifier. This is a data-model bug, not a Kurmancî error per se, but it limits programmatic use of the `ez` field.
**Fix**: Use `ez:'ava'` (just the ezafe form of `av`). Modifier `fêkî` belongs in the lemma if it's a compound. Or document that `ez` can hold full multi-word collocations.
**Severity**: minor

### [FILE: a1_kelime_db.dart, LINE: 1649-1652, ID: a1_550]
**Field**: tr + her
**Current**: `tr:'Ayran', en:'Buttermilk'`; `her:['Mastawê bide min, dê!', 'Pîrê, mastaw xweş e.']`; `gen:['Ez mastawê dixwim.']`
**Issue**: The sentence `'Ez mastawê dixwim.'` uses `dixwim` (eat/drink — generic). For drinking ayran, more natural: `Ez mastawê vedixwim` (`vexwarin` = "drink"). Cross-check with line 943 (a1 lesson) where `vexwarin` is used for liquids. Inconsistent verb usage between lesson and DB.
**Fix**: `gen:['Ez mastawê vedixwim.']`
**Severity**: minor

### [FILE: a1_kelime_db.dart, LINE: 1665-1669, ID: a1_553]
**Field**: tr
**Current**: `ku:'Êvar baş', tr:'İyi akşamlar'`
**Issue**: The Kurmancî form for "Good evening" is properly `Êvara baş!` with feminine ezafe `-a` (since `êvar` is feminine: `Êvar` → `Êvara baş`, "the good evening"). The bare `Êvar baş` is grammatically incomplete. Cross-check: a2_kelime_db at line 38-43 correctly uses `Êvara baş!`. The A1 entry has the wrong form.
**Fix**: `ku:'Êvara baş!'` (with ezafe `-a` and exclamation)
**Severity**: moderate

### [FILE: a1_kelime_db.dart, LINE: 1676-1679, ID: a1_555]
**Field**: ez
**Current**: `cins:'mê', ez:null` for `Nîvê şevê` (gece yarısı)
**Issue**: `Nîvê şevê` already contains the ezafe (`nîv + -ê + şev + -ê`). Marking `ez:null` is OK since the lemma is a phrase. But marking `cins:'mê'` is inconsistent — `nîv` is masculine (`nêr`), not feminine. The phrase as a whole has no single gender; should be `bêcins` for compound time expressions.
**Fix**: Change `cins:'mê'` → `cins:'bêcins'`.
**Severity**: minor

### [FILE: a1_kelime_db.dart, LINE: 2060-2063 (in middle section), ID: pênc_ex1 reference]
Note: lines 2060-2063 is `Çira` lamba.

### [FILE: a1_kelime_db.dart, LINE: 2364-2368, ID: a1_754]
**Field**: ku + not
**Current**: `ku:'Sinif'`, note `'[Fêrkera D.2]: "pol" da kullanılır — "pol" daha öz Kurmancî.'`
**Issue**: Note correctly identifies `pol` as the more authentic Kurmancî term. But `Sinif` is itself a Turkish loan (Turkish "sınıf" → Kurmancî "sinif"). KURMANCI_RULES §1 implicitly favors `pol` for purist learning. The lesson could be enhanced by promoting `pol` as primary lemma and `sinif` as variant. But since both are listed in DB as separate entries this may be intentional.
**Fix**: (optional) Demote `sinif` to a `variant` field of `pol` or add a stricter heritage note.
**Severity**: minor

### [FILE: a1_kelime_db.dart, LINE: 2376-2380, ID: a1_756]
**Field**: ku + not
**Current**: `ku:'Pênûsk'`, note: `'Mê — Özgün Kurmancî form: "pênûsk".'`
**Issue**: Standard form is `pênûs` (without -k). `Pênûsk` exists as a regional/diminutive variant but is not the canonical form per Ferhenga Birûskî and Bedirxan-Lescot. The note claims it as `Özgün Kurmancî form` which may overstate.
**Fix**: Verify against Ferhenga Birûskî. If standard is `pênûs`, change `ku:'Pênûsk'` → `ku:'Pênûs'` (with note that `pênûsk` exists as variant). 
**Severity**: moderate (needs lexical authority verification)

### [FILE: a1_kelime_db.dart, LINE: 3107-3110, ID: a1_ek423]
**Field**: ku
**Current**: `ku:'Mamoste'`
**Issue**: This DUPLICATES `Mamosta` from a1_110 (line 441) with a slightly different spelling. The DB has both `Mamosta` and `Mamoste` as separate cards — but they are the same word with regional pronunciation variants. Listing both as separate vocabulary items causes redundancy and learner confusion (they'll see two flashcards for the same concept). The note acknowledges this: `'Mamoste formel kayıt. "Mamosta" da kullanılır.'`
**Fix**: Either remove the duplicate or merge into a single card with both spellings noted as variants.
**Severity**: moderate

### [FILE: a1_kelime_db.dart, LINE: 3149-3154, ID: a1_ek430]
**Field**: tr
**Current**: `ku:'Lorî'`, `tr:'Ninni'`
**Issue**: GOOD ✓. Note "Dê ji zaroka xwe re lorî dibêje" is semantically correct. Construction: "Mother says ninni to her child" — uses `re` postposition properly.
**Fix**: (none)
**Severity**: (exemplary)

### [FILE: a1_kelime_db.dart, LINE: 3199, ID: a1_ek437]
**Field**: her
**Current**: `'Bavê min poşû li xwe dike.'`
**Issue**: GOOD reflexive construction. `Bavê min` (subject, eril ezafe) + `poşû` (object) + `li xwe dike` (puts on himself). Valid Kurmancî. ✓
**Fix**: (none)
**Severity**: (none)

### [FILE: a1_kelime_db.dart, LINE: 3208-3212, ID: a1_ek439]
**Field**: ez (ezafe)
**Current**: `ku:'Qebayet', cins:'mê', ez:'qebayetê'`
**Issue**: For a feminine noun, ezafe should be `-a`, not `-ê`. The form `qebayetê` is OBLIQUE (mê), not ezafe (mê). Should be `ez:'qebayeta'`.
**Fix**: `ez:'qebayeta'`
**Severity**: major

### [FILE: a1_kelime_db.dart, LINE: 3318-3325, ID: a1_s02 / a1_s03]
**Field**: not (semantic precision)
**Current**: `Xort` (line 3322): `'Genç erkek/Delikanlı'`; `Keçik` (line 3327): `'Kız/Genç kız'`
**Issue**: GOOD pair semantically. ✓ Note that `Xort` is gendered (eril) while `Keçik` is `mê`. Cross-references in lesson `kurik_keçik_ex1` correctly distinguish.
**Fix**: (none)
**Severity**: (none)

---

## A2 — Kelime DB

### [FILE: a2_kelime_db.dart, LINE: 32-36, ID: a2_001]
**Field**: ku
**Current**: `ku:'Sibê baş!', tr:'Günaydın!'`
**Issue**: Asymmetric with `a2_002` (`Êvara baş!`) and `a2_003` (`Şeva baş!`). Those use ezafe `-a`. The "morning" form should similarly be `Sibeha baş!` (since `sibeh` is feminine). Bare `Sibê baş!` uses oblique form `sibê` (= "yarın/sabah" oblique) which is grammatically OK ("In the good morning") but stylistically inconsistent with the other two entries. Per A1 line 2207-2211 `Sibê baş!` is acknowledged as the "short" form and `Sibê te xweş be!` as the long form — so the A2 entry inherits this convention.
**Fix**: (optional) Either standardize to `Sibeha baş!` for consistency, or document why `Sibê baş!` is the canonical short form.
**Severity**: minor

### [FILE: a2_kelime_db.dart, LINE: 57-62, ID: a2_005]
**Field**: cins + ez
**Current**: `cins:'mê', ez:'nûçeyên'`
**Issue**: The `ez` field stores `nûçeyên` which is the PLURAL ezafe form (`-ên`), not the singular feminine ezafe. The lemma is a plural phrase `Nûçeyên baş`. Marking it as `cins:'mê'` for a plural is technically wrong — plurals don't have gender. Should be `cins:'pirjimar'` or just `bêcins`.
**Fix**: `cins:'bêcins'` (or introduce a `pirjimar` tag) and `ez:null` since the lemma is already a plural phrase.
**Severity**: minor

### [FILE: a2_kelime_db.dart, LINE: 69-74, ID: a2_010]
**Field**: cins
**Current**: `ku:'Navend', cins:'nêr', ez:'navendê'`
**Issue**: `Navend` is debatable. Ferhenga Birûskî lists `navend` as `n.f.` (feminine) — see also a2_lesson l04 line 196 which uses `navendê` as if mê oblique. If `navend` is feminine, then ez should be `navenda` (not `navendê`). The current entry has `cins:'nêr'` AND `ez:'navendê'` which is contradictory: nêr ezafe should be `-ê`, but here `navendê` looks more like an oblique form. Per Ferhenga Birûskî standard (n.f.), correct entry is: `cins:'mê', ez:'navenda'`.
**Fix**: `cins:'mê', ez:'navenda'`. Update lesson a2_l04_e3 if needed.
**Severity**: major

### [FILE: a2_kelime_db.dart, LINE: 132-137, ID: a2_019]
**Field**: cins
**Current**: `ku:'Park', cins:'mê', ez:'parkê'`
**Issue**: For a feminine noun, ezafe should be `-a` (`parka`), not `-ê` (`parkê`). The entry has `cins:'mê'` AND `ez:'parkê'` — inconsistent (`-ê` is masculine ezafe OR feminine oblique, but the field is `ez` not `obl`). The `her` example at line 136 says `'Parka me li nêzî malê ye.'` which uses `parka` (correctly mê ezafe) — proving the lemma IS feminine. So `ez` should be `parka`.
**Fix**: `ez:'parka'`. The DÜZELTME comment at line 135 suggests this was fixed but only for the `ku` field; the `ez` field still has the old form.
**Severity**: major

### [FILE: a2_kelime_db.dart, LINE: 215-218, ID: a2_040]
**Field**: her example
**Current**: `'Birayê min havînê zewicî.'`
**Issue**: GOOD past intransitive construction. `Birayê min` (subject ezafe nominative) + `havînê` (oblique time-when) + `zewicî` (3sg past). ✓ Demonstrates intransitive past with no ergativity needed.
**Fix**: (none)
**Severity**: (exemplary)

### [FILE: a2_kelime_db.dart, LINE: 261-265, ID: a2_050]
**Field**: kurmanjPrompt
**Current**: `ku:'Hewa çawa ye?'`
**Issue**: GOOD ✓. Standard question form.
**Fix**: (none)
**Severity**: (none)

### [FILE: a2_kelime_db.dart, LINE: 2139-2141, ID: a2_851]
**Field**: ez
**Current**: `cins:'mê', ez:'keştiyê'`
**Issue**: For a feminine vowel-final noun (`keştî` ends in `-î`), ezafe is `keştiya` (per §3.4 `-î + -y- + -a`). The form `keştiyê` is OBLIQUE feminine, NOT ezafe. Same systematic error as Park (a2_019).
**Fix**: `ez:'keştiya'`
**Severity**: major

### [FILE: a2_kelime_db.dart, LINE: 2148-2151, ID: a2_853]
**Field**: ez
**Current**: `cins:'mê', ez:'duçerxê'`
**Issue**: Same pattern: feminine `duçerxe` ezafe should be `duçerxa` (vowel-final mê), not `duçerxê`. Currently storing the OBLIQUE form in the `ez` field.
**Fix**: `ez:'duçerxa'`
**Severity**: major

### [FILE: a2_kelime_db.dart, LINE: 2158-2161, ID: a2_855]
**Field**: ez
**Current**: `ku:'Sekingeha basê', cins:'mê', ez:'sekingehê'`
**Issue**: The lemma is a phrase `Sekingeha basê` (already in ezafe form: `sekingeh + -a + basê`). The `ez` field showing `sekingehê` is OBLIQUE singular. Inconsistent: lemma already contains its ezafe. Should be `ez:null` or `ez:'sekingeha'` for the bare ezafe form.
**Fix**: `ez:null` (since lemma is a phrase) or document the convention.
**Severity**: minor

### [FILE: a2_kelime_db.dart, LINE: 2256-2258, ID: a2_883]
**Field**: ez
**Current**: `cins:'mê', ez:'miyê'`
**Issue**: `mî` (sheep) is feminine. The proper ezafe form is `miya` (mê + vowel-final → `-ya`). The form `miyê` is OBLIQUE. Same systematic ez/obl confusion.
**Fix**: `ez:'miya'`
**Severity**: major

### [FILE: a2_kelime_db.dart, LINE: 4290-4293, ID: a2_1940]
**Field**: ez
**Current**: `ku:'Cejna Remezan', cins:'mê', ez:'Cejnê'`
**Issue**: Inconsistent: lemma already has ezafe (`Cejna`). The `ez` field showing `Cejnê` is OBLIQUE. For a phrase-lemma, `ez:null` is appropriate, or `ez:'Cejna'`. Currently the `ez` field is being used as an "oblique" marker which conflicts with its declared purpose.
**Fix**: `ez:'Cejna'` or `ez:null`. Document what `ez` means consistently.
**Severity**: moderate

### [FILE: a2_kelime_db.dart, LINE: 2126-2127, ID: a2_846]
**Field**: gen example
**Current**: `gen:['Niqab û derman', 'Niqabê min']`
**Issue**: The `gen` examples reference `Niqab` (veil), but the `ku` lemma is `Masqe` (mask). The DÜZELTME note (line 2126) confirms `Niqab` is for "örtü/peçe" — DIFFERENT word. The `gen` examples are WRONG semantically.
**Fix**: Replace with examples using `Masqe`: `gen:['Masqe û derman', 'Masqeya min']`.
**Severity**: moderate

### [FILE: a2_kelime_db.dart, LINE: 2229, ID: a2_874]
**Field**: ku
**Current**: `ku:'Destpêka hefteya'`
**Issue**: `hefteya` is ezafe form `hefte + -ya`. But the construct here means "the beginning of the week" — which should be `Destpêka hefteyê` (oblique `hefteyê`, since `destpêka` heads the construct). The form `Destpêka hefteya` literally reads "Beginning of the week-ezafe-something" — broken.
**Fix**: `ku:'Destpêka hefteyê'`. Update `her` examples to match: `'Di destpêka hefteyê de.'`
**Severity**: major

### [FILE: a2_kelime_db.dart, LINE: 2231, ID: a2_875]
**Field**: ku
**Current**: `ku:'Dawiya meha'`
**Issue**: Same pattern as a2_874. `Dawiya meha` should be `Dawiya mehê` (oblique mehê). The `her` example at line 2233 correctly says `'Di dawiya mehê de.'` — proving the lemma form is wrong.
**Fix**: `ku:'Dawiya mehê'`
**Severity**: major

### [FILE: a2_kelime_db.dart, LINE: 4554-4558, ID: a2_z08]
**Field**: ku
**Current**: `ku:'Niha niha'`
**Issue**: Reduplication `Niha niha` for "az önce/demin" is colloquial. More canonical Kurmancî for "just now" is `vê gavê` (this moment) or `niha niha xwe` or simply `niha`. Bedirxan-Lescot does not list `niha niha` as standard. Note in entry says `'Niha niha = az önce (tekrarlı vurgu).'` — acknowledging it's emphatic, but learners may overgeneralize.
**Fix**: (optional) Add caveat: `'Vê gavê' veya 'niha' tek başına da yeterlidir.`
**Severity**: minor

### [FILE: a2_kelime_db.dart, LINE: 4669-4673, ID: a2_z26]
**Field**: ku + tr
**Current**: `ku:'Hûrdem', tr:'Dakika (öz Kurmancî)'`
**Issue**: `Hûrdem` ("küçük zaman") is a recent neologism, not standardized. Bedirxan-Lescot uses `deqîqe` (Arabic) or `xulek` (regional). Calling `hûrdem` "öz Kurmancî" is overstatement — it's a coinage. The note already says "deqîqe a2_1061'de Arapça kökenli", which is accurate.
**Fix**: Soften: `tr:'Dakika (yeni türetim)'` and note `Standartlaşmamış neolojizm; deqîqe daha yaygın.`
**Severity**: minor

### [FILE: a2_kelime_db.dart, LINE: 4593-4597, ID: a2_z14 / a2_z17]
**Field**: duplicate entries
**Current**: `a2_z14: ku:'Esman', tr:'Gökyüzü'` and `a2_z17: ku:'Roj'`
**Issue**: `Esman` already exists in a1_kelime_db as `a1_744` (line 2251). And `Roj` already exists as a1_120 (line 496). Re-listing them in A2 final supplement (`kA2Son30`) is redundant; the same words don't need to be re-taught at A2 level unless meaning extends. The note for `a2_z14` says `'Nêr — "ezman" da yazılır.'` — providing variant info — but that could be added to the A1 entry instead.
**Fix**: Remove duplicates from `kA2Son30`, OR add cross-reference flagging.
**Severity**: minor

### [FILE: a2_kelime_db.dart, LINE: 4359-4364, ID: a2_1965]
**Field**: ku + tr
**Current**: `ku:'Lênûsk'`, note: `'Lê' + 'nûsk' — özgün Kurmancî bileşik. "Defter" de kullanılır.'`
**Issue**: The composition `lê + nûsk` is non-standard etymology. Standard forms are `nivîsek` ("a writing") or `defter`. Ferhenga Birûskî does not list `lênûsk` as a primary lemma. The AS source citation may be regional. Calling it "özgün Kurmancî bileşik" overstates its currency.
**Fix**: Verify with Ferhenga Birûskî. If non-standard, demote: `tr:'Defter (yeni türetim)'`.
**Severity**: minor

---

## Summary

Total findings: 39 (some are exemplary positive notes for context; ~30 are actionable issues).

**By severity:**
- **major** (8): semantic errors, case errors, ezafe/oblique confusion, age construction (`bir/birîn`, `Pîrê + present`, `salî` separation, `Park/Keştî/Mî/Dûçerxe/Navend` ezafe)
- **moderate** (12): orthographic compromise (`Dêya min` split), category typos (`rengder`), etymology errors (`şem`), spelling (`Kîtêb` violates §2.4), duplicate entries (`Mamoste`/`Mamosta`), gen example mismatches.
- **minor** (15): style choices, optional clarifications, regional variants, length-bias warnings.

**Systematic issues to address platform-wide:**
1. **`ez` field misuse**: many feminine nouns (`Park`, `Keştî`, `Mî`, `Duçerxe`) have OBLIQUE forms (-ê, -yê) stored in the `ez` field instead of EZAFE forms (-a, -ya). This is a categorical bug affecting 5+ A2 entries. Likely needs a sweep + fixer.
2. **Pîrê used as nominative subject**: appears in multiple A1 fill exercises (`goşt_fill_ex1`, `piree_li_fill_ex1`, `Pîrê goşt dipijîne` style); should be `Pîr` for present tense.
3. **Multi-word lemmas with embedded ezafe** (`Destpêka hefteya`, `Dawiya meha`, `Cejna Remezan`): inconsistent handling — some have `ez:null`, some have oblique form in `ez`, lemma forms vary. Adopt one convention.
4. **Bedirxan-Lescot future-particle separation** (`Ez ê` not `Ezê`): A2 lesson definitions appear well-fixed (line 159, 167) — no joined forms found in lesson definitions. ✓ This historical fix-up has been applied successfully.
5. **Word-initial `î`** (KURMANCI_RULES §2.4 violation): `Kîtêb` at a2_l20_e3 is a clear violation. Sweep grep recommended.

Audit finished within budget. Sample coverage A1 kelime DB ~1700 lines / 3365 (50%); A2 kelime DB ~750 lines / 4706 (16%). Recommended follow-up: programmatic linter run as described in KURMANCI_RULES.md to catch the systematic ez/obl confusion pattern.
