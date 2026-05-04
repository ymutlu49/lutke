# LÛTKE — AUDIT OF CULTURAL CONTENT DATABASES

Sampled audit (2026-05-04) of Kurmanji-Kurdish cultural content databases.
Reference: KURMANCI_RULES.md (Bedirxan-Lescot 1932 standard) + bedirxan_lescot.txt.
Files audited (sampled, not full):
- kurdish_artists_db.dart (lines 1-200, 500-700, 1000-1100)
- kurdish_historical_figures_db.dart (lines 1-300, 500-700)
- kurdish_legends_db.dart (lines 1-200, 400-600)
- kurdish_foods_db.dart (lines 1-300)
- gotinen_pesiyan_db.dart (lines 1-100, 1500-1700, 3200-3300)

Severity: minor (cosmetic/style) / moderate (clear writing bug) / major (factual error).

---

## A. FACTUAL ERRORS — Kurdish history/culture

### [FILE: kurdish_historical_figures_db.dart, LINE: 140-141]
**Field**: kurmanjContent (h_013 Idrîsê Bedlîsî)
**Current**: `'• Piştî hatina Selçûqîyan (1501), çû dîwana Sultan Beyazîdê\n  II\'an li Stenbolê.\n'`
**Issue**: Major factual error. In 1501 the Safavids (Sefewîyan) came to power in Iran under Şah Ismail, not the Seljuks (Selçûqîyan); the Seljuk dynasty had ended in the 13th century. İdris-i Bidlisi left the Aq-Qoyunlu/Safavid orbit because of the Safavid takeover. The Turkish text below at line 162 already says "Selçukluların gelişinden sonra" — which carries the same error.
**Fix**: Replace `Selçûqîyan` with `Sefewîyan` in Kurmanji and `Selçukluların` with `Safevilerin` in Turkish.
**Severity**: major

### [FILE: kurdish_historical_figures_db.dart, LINE: 271]
**Field**: kurmanjContent (h_015 Şêx Ubeydullahê Nehrî)
**Current**: `'• Bajarên Mehabad, Mîyando Av, Sereiş girtin.\n'`
**Issue**: City names garbled. The 1880 Şêx Ubeydullah uprising in Iran captured Mahabad, Miandoab (Mîyandoab) and Saqqez (Seqiz / Saqqız) — not "Mîyando Av" (which looks like a broken transcription of Miyando Ab/Miandoab) or "Sereiş" (which should be Saqqez). Turkish version at line 298 says "Saqqız", confirming the intended city, but renders "Mîyando Av" oddly too.
**Fix**: Use `Mehabad, Miyandoab, Seqiz` in Kurmanji and `Mahabad, Miyandoab, Saqqız` in Turkish.
**Severity**: major

### [FILE: kurdish_historical_figures_db.dart, LINE: 23]
**Field**: kurmanjTitle (h_011 Selahaddin)
**Current**: `'Selahaddinê Eyyûbî (1137–1193)'`
**Issue**: Birth year 1137 is the most commonly cited but some scholarly sources give 1138. Not a clear error — accept as-is. (No-op finding; included to confirm sample was checked.)
**Fix**: none required.
**Severity**: minor

### [FILE: kurdish_historical_figures_db.dart, LINE: 142]
**Field**: kurmanjContent (h_013 Idrîsê Bedlîsî, "Heşt Beheşt")
**Current**: `'• Wek dîrokzan, "Heşt Beheşt" (Sekiz Cennet) — tarîxa Osmanî,\n  ya yekem bi Farisî — nivîsî.\n'`
**Issue**: Claim "ya yekem bi Farisî" ("the first in Persian") is misleading. Heşt Beheşt is one of several Persian-language Ottoman histories of its era; calling it the first Persian-language Ottoman history is overstated. Better phrasing: "yek ji yekem dîrokên Osmanî yên bi Farisî" ("one of the first Ottoman histories in Persian").
**Fix**: Soften claim; same in Turkish line 165.
**Severity**: moderate

### [FILE: kurdish_historical_figures_db.dart, LINE: 153]
**Field**: kurmanjContent (h_013, autonomy length)
**Current**: `'Ev peyman 300 salan otonomiya Kurd parast (1514–1839).\n'`
**Issue**: 1514 → 1839 is 325 years, not 300; rounding is fine but the 1839 endpoint conflates Tanzimat decree with actual abolition of mîreks (Bedirxan revolt 1843–47, full abolition through 1840s). Acceptable simplification but worth a footnote-level adjustment.
**Fix**: "Sêsed salan" → "zêdetir ji 300 salan" (more than 300 years) and adjust Turkish accordingly.
**Severity**: minor

---

## B. KURMANJI WRITING ERRORS — Bedirxan/Lescot violations

### [FILE: kurdish_artists_db.dart, LINE: 29]
**Field**: kurmanjContent (s_001 Şivan Perwer)
**Current**: `'Şivan Perwer, ji navçeya Vîranşar a Riha ye.\n'`
**Issue**: "Vîranşar" — the standard Kurmanji form is `Wêranşar` (or `Wêranşehr`); "Vîran-" reuses the Turkish "Viran-" with V (Kurmanji uses W in this position by Bedirxan standard). Same in keywords at line 52.
**Fix**: `Wêranşar` (or keep loanform but add canonical variant in keyword).
**Severity**: moderate

### [FILE: kurdish_artists_db.dart, LINE: 209] (h_014 Bedirxan)
**Field**: kurmanjContent
**Current**: `'• Bedirxan teslîm bû. Hate sirgûn kirin Stembol, paşê Şamê.\n'`
**Issue**: "Stembol" — in Bedirxan-Hawar standard Istanbul is consistently spelled `Stembol` or `Stenbol`; the file mixes `Stembol` (line 209) with `Stenbolê` (line 263, oblique). Pick one. The Hawar tradition has both attested but `Stenbol` is more frequent in modern Kurmanji. The same line should also use `sirgûnî Stenbolê kirin` (with iz. ending) rather than the bare "sirgûn kirin Stembol".
**Fix**: Standardise to `Stenbol`/`Stenbolê` across the DB; reword "sirgûnî Stenbolê û paşê Şamê hate kirin".
**Severity**: moderate

### [FILE: kurdish_historical_figures_db.dart, LINE: 27]
**Field**: kurmanjContent (h_011 Selahaddin)
**Current**: `'Ji Tikrîtê (Iraqa nûjen) hatibû\ndinyayê'`
**Issue**: "Iraqa" vs "Iraqê" — Iraq is feminine in Kurmanji and izafe should be `Iraqa`, that part is fine. But the noun is unmarked at the start: "Iraqa nûjen" should idiomatically be "Iraqa îroyîn / niha". "Nûjen" usually means "modern" in the cultural sense, while geographically you'd write "ya îro" or "ya niha" to mean "modern-day Iraq". Stylistic.
**Fix**: `Iraqa îro` or `Iraqa îroyîn` for clarity.
**Severity**: minor

### [FILE: kurdish_historical_figures_db.dart, LINE: 98]
**Field**: kurmanjContent (h_012 Şerefxan)
**Current**: `'El-yazma Bibliothèque Nationale de France\'ê\n(Pariş) tê parastin.'`
**Issue**: "El-yazma" is a Turkish loanword (el yazması = manuscript) inappropriate for a Kurmanji passage. Kurmanji has `destnivîs` (manuscript). Also, capital city of France in Kurmanji is `Parîs`, not `Pariş` — "Pariş" with -ş is a Turkish-flavored spelling.
**Fix**: `Destnivîsa wê li Bibliothèque Nationale de France'ê (Parîs) tê parastin.`
**Severity**: moderate

### [FILE: kurdish_historical_figures_db.dart, LINE: 84]
**Field**: kurmanjContent (h_012 Şerefxan)
**Current**: `'• Li dîwana Şahê Sefewî mezin bû (Tehran).\n'`
**Issue**: "Tehran" should be `Tehran` or `Tehranê`; placement in parentheses without izafe is OK as a city tag, but Şerefxan was raised at the Safavid court at Qazvin, not Tehran (Tehran became capital only under the Qajars in the late 18th c.). Major historical error.
**Fix**: Replace `Tehran` with `Qezwîn` (and Turkish `Tahran` → `Kazvin`) at line 104.
**Severity**: major

### [FILE: kurdish_historical_figures_db.dart, LINE: 92]
**Field**: kurmanjContent (h_012 Şerefxan)
**Current**: `'3. Bedlîsê û pîramidên wê.\n'`
**Issue**: "Pîramidên" — Bidlis has no pyramids. The Şerefname's third book is on the *mîrekiyên* (principalities) of *Bedlîsê* OR (more accurately) on the Bidlisi rulers' lineage. "Pîramid" appears to be a copy-paste error for something like "mîrên" or "şecere" (lineage). Confirmed by Turkish at line 111 ("Bidlis ve piramitleri") which is also wrong.
**Fix**: `3. Mîrên Bedlîsê û şecereya wan.` and `3. Bidlis hâkimleri ve şecereleri.`
**Severity**: major

### [FILE: kurdish_historical_figures_db.dart, LINE: 29]
**Field**: kurmanjContent (h_011 Selahaddin)
**Current**: `'ji malbateke kurd a ji Dwînê (Ermenistan).\n'`
**Issue**: "Dwîn" — historically the Eyyubid family is from Dvin, but the standard Kurmanji rendering varies. "Dwîn" is acceptable; however "Ermenistan" is anachronistic — Dvin in the 11th–12th c. was in the Bagratid Armenian kingdom and later Seljuk territory, not modern Armenia. Use "deşta Ermeniyan" or "herêma Ermeniyan a wê demê" for accuracy.
**Fix**: `ji malbateke kurd a Dwînî (li Ermenistana wê demê).`
**Severity**: minor

---

## C. CALQUES / LOANWORD ISSUES

### [FILE: kurdish_artists_db.dart, LINE: 89-91]
**Field**: keywords (s_003 Ayşe Şan)
**Current**: keywords include `'Amed'` but kurmanjContent line 91 says `'Ayşe Şan li Diyarbekirê (Amed) ji dayîk bûye.'` — both forms used.
**Issue**: Inconsistency: `Diyarbekir` and `Amed` are both used. In Kurmanji learning material the canonical Kurdish name is `Amed`; using both with parenthesis in Kurmanji text is redundant — one or the other.
**Fix**: Use `Amed (Diyarbekir)` form once at first mention; thereafter `Amed` only. Keep keyword list consistent.
**Severity**: minor

### [FILE: kurdish_legends_db.dart, LINE: 64]
**Field**: kurmanjContent (l_002 Şahmaran)
**Current**: `'Şahmaran, şahbanûya marên bi aqil e: serê wê serê jinekê \nye, beden û dûvê wê yê mar.'`
**Issue**: "yê mar" — gender mismatch. `beden û dûv` are both feminine/neuter and the linker after the conjoined NP should agree as plural izafe `ên` not singular masc `yê`. Read: `serê jinekê ye, beden û dûvê wê yên marî ne` (or `mar in`).
**Fix**: `... beden û dûvê wê wek ên marî ne.`
**Severity**: moderate

### [FILE: kurdish_legends_db.dart, LINE: 122-126]
**Field**: backgroundNote (l_003 Ristem)
**Current**: `'Kurdish bölgesindeki "Zal", "Rustem"\nisimleri bu mirastan gelir.'`
**Issue**: English word "Kurdish" left in Turkish text — should be `Kürt` ("Kürt bölgesindeki"). Mixed-language artifact, likely from drafting.
**Fix**: `Kürt bölgesinde "Zal", "Rustem" isimleri bu mirastan gelir.`
**Severity**: moderate

### [FILE: kurdish_foods_db.dart, LINE: 169]
**Field**: kurmanjContent (f_005 Birîyanî)
**Current**: `'... baharatên\ngerm (zincebîl, kimîn, dirêjberg) û rûnê heywanan tê çêkirin.'`
**Issue**: Turkish at line 180 lists `(zencefil, kimyon, tarçın)`. Three problems: (a) `zincebîl` (ginger) is not a typical Hekarî biryani spice — biryani uses cardamom/cinnamon; (b) `kimîn` for cumin is OK; (c) `dirêjberg` literally "long-leaf" is an idiosyncratic coining for tarçın (cinnamon) — the standard Kurmanji is `darçîn`. The Turkish 'tarçın' = `darçîn`, not `dirêjberg`.
**Fix**: Replace `dirêjberg` with `darçîn` (lines 169, 211); reconsider `zincebîl` vs more appropriate spice (e.g. `hêl` cardamom).
**Severity**: moderate

### [FILE: kurdish_foods_db.dart, LINE: 211]
**Field**: kurmanjContent (f_006 Harîse)
**Current**: `'• Av, xwê, baharat (kimîn, dirêjberg).\n'`
**Issue**: Same `dirêjberg` issue — should be `darçîn`. Inconsistency: Turkish at line 223 says `tarçın`.
**Fix**: `darçîn`.
**Severity**: moderate

### [FILE: kurdish_foods_db.dart, LINE: 244]
**Field**: kurmanjContent (f_007 Awxa)
**Current**: `'Awxa, şorbeya kevneşopî ye ji mast, savar û nehniyê.'`
**Issue**: "nehniyê" — standard Kurmanji for mint is `pûng` or `nanê`, not `nehniyê` (which seems to be a colloquial or dialectal form, possibly conflating Arabic na'na'/Turkish nane). For a learning DB the standard form should appear at least once.
**Fix**: Use `pûng` (or `pûng/nanê`) and gloss the dialect form if needed.
**Severity**: moderate

---

## D. SPELLING / DIACRITIC INCONSISTENCY

### [FILE: kurdish_historical_figures_db.dart, LINE: 69 vs 23]
**Field**: keywords vs kurmanjTitle
**Current**: title `Selahaddinê Eyyûbî` (line 23) vs keyword `Selahaddîn` with circumflex on first î (line 69).
**Issue**: Inconsistent diacritics — title has no circumflex on first 'i' (`Selahaddin-`) but keyword has `Selahaddîn`. Pick one form.
**Fix**: Bedirxan-Hawar standard: `Selahedînê Eyûbî` (without doubled letters) or `Selahaddînê Eyyûbî` (Arabic-faithful). Whichever is chosen, apply consistently.
**Severity**: minor

### [FILE: kurdish_historical_figures_db.dart, LINE: 132]
**Field**: kurmanjTitle (h_013)
**Current**: `'Idrîsê Bedlîsî (1452–1520)'`
**Issue**: "Idrîs" — the proper name in Kurmanji can be `Îdrîs` (with leading Î-circumflex per Bedirxan-Lescot vowel-initial rule) rather than bare `Idrîs`. In the Bedirxan-Lescot system, word-initial /i/ at the start of names is typically `Î`. Inconsistent across the DB. (See also line 138, 145.)
**Fix**: `Îdrîsê Bedlîsî` (or document the choice).
**Severity**: minor

### [FILE: kurdish_artists_db.dart, LINE: 209]
**Field**: kurmanjContent (h_014)
**Current**: `'• Bedirxan teslîm bû. Hate sirgûn kirin Stembol, paşê Şamê.\n'`
**Issue**: This entry is in `kurdish_historical_figures_db.dart` not artists; correction noted. (See finding under section B for Stenbol/Stembol.)
**Fix**: see B.
**Severity**: see B.

---

## E. PROVERBS — gotinen_pesiyan_db.dart

Note per the audit instructions: non-Bedirxan colloquial forms in proverbs are intentionally preserved as folk authenticity. Only flagging clear typographical errors and duplicates.

### [FILE: gotinen_pesiyan_db.dart, LINE: 22]
**Field**: ku
**Current**: `'Agire bin kaye ye'`
**Issue**: Likely intended `Agirê binê kayê ye` ("It's the fire under the straw"); current form lacks circumflexes on the iz. vowels. As folk material this can be preserved, but if standardisation is desired this is an example.
**Fix**: optional; preserve as folk if policy.
**Severity**: minor

### [FILE: gotinen_pesiyan_db.dart, LINES: 33–37]
**Field**: ku entries
**Current**: Five near-duplicate entries (A.33, A.34, A.35, A.36, A.37) all variations of "Agir xweş e lê arî/xwelî jê çêdibe / çêneba". Four of these (33, 34, 35, 36) carry the same Turkish translation "Ateş güzel/iyi de, külü olmasa".
**Issue**: Excessive duplication of one proverb with minor variant spellings. Either consolidate or label them as "variant" entries.
**Fix**: Keep one canonical form; move the rest to a "variants" sublist or delete near-identical typo variants (A.34 `çêneba` looks like a typo of A.33 `çêdibe`).
**Severity**: minor

### [FILE: gotinen_pesiyan_db.dart, LINE: 36]
**Field**: ku (A.22)
**Current**: `'Agir girte mala yekî, ye din got: "Tu bi Xwede venemirîne, da ku (ez) kewen xwe bibirêjim'`
**Issue**: Truncated string — closing quotation mark missing. Also `bibirêjim` looks like `bibirêjim`/`bibirjînim` (= "to fry/grill"); intended sense is "may fry my kebab on it" — keep but close the quotation.
**Fix**: `'Agir girte mala yekî, yê din got: "Tu bi Xwedê venemirîne, da ku ez kewên xwe bibirêjim"'`
**Severity**: moderate

---

## F. ADDITIONAL FINDINGS — second batch of samples

### [FILE: kurdish_artists_db.dart, LINE: 1032]
**Field**: kurmanjContent (p_004 Ali Herîrî, sample poem)
**Current**: `'"Ezê biçim li ber pencerê,\nÇavên xwe bidim asîman.\n'`
**Issue**: `Ezê` is the joined future-tense form prohibited by Bedirxan-Lescot — should be split: `Ez ê biçim`. As this is the only quoted poetic line of Ali Herîrî attributed in the DB, also note: no extant Ali Herîrî manuscript actually contains this line (it appears constructed). Both issues compound.
**Fix**: Replace `Ezê biçim` with `Ez ê biçim`. If the verse is reconstructed/illustrative, mark it as such (e.g. `(şopa hêmavî)` or "stilîze") to avoid misattribution.
**Severity**: moderate

### [FILE: kurdish_artists_db.dart, LINE: 1056]
**Field**: kurmanjTitle (p_005)
**Current**: `'Cigerxwîn (1903–1984)'`
**Issue**: The poet's pen-name appears as both `Cigerxwîn` (here, p_005) and the audit reference standard reads `Cegerxwîn`. The Hawar/Bedirxan pronunciation favors `Cegerxwîn` (with -e- in "ceger" = liver); `Cigerxwîn` reflects Turkish vowel orthography (ciğer). The Kurmanji form should use -e-.
**Fix**: Standardise to `Cegerxwîn` (per Bedirxan); update title, content, keywords, backgroundNote (line 1075).
**Severity**: moderate

### [FILE: kurdish_artists_db.dart, LINE: 1059]
**Field**: kurmanjContent (p_005 Cegerxwîn origin)
**Current**: `'Ji Hesarî (Mêrdîn), helbestvanê neteweyî yê modern.\n'`
**Issue**: Cegerxwîn was born in **Hesar**, a village in the **Gercüş** (Kercewş) district of Mêrdîn, and the Turkish gloss at line 1067 should read "Hesar (Mardin/Gercüş)" not just "Hesar (Mardin)". The audit reference also flags Gerger as a known mis-attribution to watch for; this entry uses the correct broad region but elides the Gercüş subprovince.
**Fix**: `'Ji Hesarê (Gercüş, Mêrdîn), helbestvanê neteweyî yê nûjen.'`
**Severity**: minor

### [FILE: kurdish_artists_db.dart, LINE: 1061-1064]
**Field**: kurmanjContent (p_005 Cegerxwîn poem excerpt)
**Current**: `'"Kîme ez? Kurd im, ez Kurd im,\nWelatê min Kurdistan e.\nZimanê min Kurdî ye,\nÊdî bes e şerm û nefret im."'`
**Issue**: Last line `'Êdî bes e şerm û nefret im'` is grammatically broken in Kurmanji — `şerm û nefret im` would mean "I am shame and hatred". The original Cegerxwîn line in "Kî me ez?" reads roughly `Êdî bes e şerm û fedî` ("enough of shame and disgrace") — the manuscript text differs. Likely transcription error / paraphrase.
**Fix**: Verify against published Cegerxwîn editions; replace with canonical line. Suggested: `'Êdî bes e şerm û fedî.'`
**Severity**: moderate (mis-quote of canonical poet)

### [FILE: kurdish_artists_db.dart, LINE: 1090]
**Field**: kurmanjContent (p_006 Hejar Mukriyanî)
**Current**: `'Ji Soranî diaxive lê Kurmancî jî dipejirand û dipeyivî.\n'`
**Issue**: Tense/aspect inconsistency: `diaxive` (present) followed by `dipejirand û dipeyivî` (past continuous) for the same person who died in 1991. Also, "Soranî" and "Kurmancî" are dialects/varieties — `bi Soranî` (in Soranî) is the proper construction, not `Ji Soranî`. The phrase reads as if he "speaks from Soranî", which doesn't make sense.
**Fix**: `'Bi Soranî dinivîsî, lê Kurmancî jî dizanibû û dipeyivî.'`
**Severity**: moderate

### [FILE: kurdish_artists_db.dart, LINE: 521-522]
**Field**: kurmanjContent (s_019 Mikail Aslan)
**Current**: `'Mikail Aslan, li Dêrsimê ji dayîk bû.\nDengbêjê mezin ê Kirmanckî (Zazakî) û Kurmancî ye;\n'`
**Issue**: Mikail Aslan primarily performs in **Kirmanckî/Zazakî**; calling him a major Kurmancî dengbêj is misleading. He covers some Kurmancî pieces but is not a Kurmancî repertoire dengbêj. Better to write "stranbêjê Kirmanckî/Zazakî yê navdar, ku gelek caran bi Kurmancî jî dixwîne".
**Fix**: Rephrase to acknowledge Zazakî as primary.
**Severity**: moderate

### [FILE: kurdish_artists_db.dart, LINE: 552]
**Field**: kurmanjTitle (s_020 Evdalê Zeynikê)
**Current**: `'Evdalê Zeynikê (1800–1913)'`
**Issue**: Evdalê Zeynikê's birth/death are **traditionally cited as 1800–1913** (113 years) — but academic consensus puts dates closer to 1800–1907 or 1801–1913 with significant uncertainty. The 113-year lifespan is folk tradition, plausible but unverified. As-is is acceptable but should optionally be flagged "(li gor rivayetan)" / "(per tradition)".
**Fix**: optional; add caveat `(li gor rivayetan)`.
**Severity**: minor

### [FILE: kurdish_artists_db.dart, LINE: 696-699]
**Field**: id (s_021 Reşîdê Baso)
**Current**: id `'s_021'` reused — this is the second occurrence of `s_021` (first was Egîdê Cimo at line 588).
**Issue**: Major data integrity error: duplicate ID `s_021` between Egîdê Cimo (line 588) and Reşîdê Baso (line 696). One of them must be re-numbered or one record will be silently overwritten in any map keyed by `id`.
**Fix**: Renumber later record to next free ID (e.g. `s_024`). Audit all IDs in artists DB for further duplicates.
**Severity**: major

### [FILE: kurdish_historical_figures_db.dart, LINE: 542]
**Field**: kurmanjContent (h_019 Sara Xatun)
**Current**: `'• Wek nûnera siyasî, çû Tehranê ji bo peymana hevkariyê.\n'`
**Issue**: Major factual error. Sara Xatun (15th c., not 14th — see next finding) is famous for diplomatic missions to **Trabzon** (to meet Mehmet II Fatih) on behalf of Uzun Hasan of the Aq Qoyunlu, NOT to Tehran. Tehran was a small village in the 15th c. and not yet a capital. The Turkish text at line 560 mirrors the same error.
**Fix**: Replace `Tehranê` with `Trabzonê` (or `Trabzon`); same in Turkish.
**Severity**: major

### [FILE: kurdish_historical_figures_db.dart, LINE: 528]
**Field**: kurmanjTitle (h_019 Sara Xatun)
**Current**: `'Sara Xatun (sedsala 14)'`
**Issue**: Sara Hatun lived in the **15th century** (c. 1390s–1470s), not the 14th. Her son was Uzun Hasan (1423–1478), and she famously met Mehmet II in 1473. The "sedsala 14" assignment is wrong by a century. Same in Turkish at line 529.
**Fix**: `'Sara Xatun (sedsala 15)'` and `'Sara Hatun (15. yüzyıl)'`.
**Severity**: major

### [FILE: kurdish_historical_figures_db.dart, LINE: 533]
**Field**: kurmanjContent (h_019 Sara Xatun)
**Current**: `'Jina Mîr Bohtanê — paşê wek serdarê siyasî hate\npejirandin.'`
**Issue**: Historical conflation: Sara Xatun was the **mother of Uzun Hasan** of the Aq Qoyunlu confederation, and traditionally associated with Bayındırlı Türkmen origin (with Kurdish lineage claimed in some sources). She was *not* the wife of "Mîr Bohtan" — that's a different historical figure. This entry mixes Sara Hatun (Aq Qoyunlu) with a different Bohtan figure. The whole entry needs verification.
**Fix**: Verify against Şerefname and contemporary scholarship; clarify her Aq Qoyunlu role versus Bohtan affiliation. If the entry is meant to depict the Aq Qoyunlu Sara Hatun, remove the "Jina Mîr Bohtanê" line entirely.
**Severity**: major

### [FILE: kurdish_historical_figures_db.dart, LINE: 584]
**Field**: kurmanjContent (h_020 Leyla Qasim)
**Current**: `'Leyla Qasim, xwendekara zankoya Bexdayê û aktîvîsta yekem\n'`
**Issue**: `zankoya` is the **Soranî** word for "university"; the Kurmanji standard is `zaningeha`. Just five lines later (line 589) the same entry uses `zaningeha`. Internal inconsistency.
**Fix**: Use `zaningeha Bexdayê` consistently.
**Severity**: moderate

### [FILE: kurdish_historical_figures_db.dart, LINE: 588]
**Field**: kurmanjContent (h_020 Leyla Qasim origin)
**Current**: `'• Ji Xanaqînê hatibû dinyayê (rojhilatê Iraqê).\n'`
**Issue**: `Xanaqîn` — the standard Kurmanji is `Xaneqîn` (mirroring Arabic Khānaqīn). Both forms occur in Kurmanji literature, but the Hawar tradition uses `Xaneqîn`. Note Turkish at line 614 says "Hanekin" (Turkish-mediated form).
**Fix**: `Xaneqîn` (Bedirxan-standard).
**Severity**: minor

### [FILE: kurdish_legends_db.dart, LINE: 421]
**Field**: kurmanjContent (l_011 Mem û Zîn)
**Current**: `'di sala 1694an de\n(sala hicrî 1106), Ehmedê Xanî ew wekî helbesteke nûjen — \n"Mem û Zîn" — nivîsand.'`
**Issue**: Date wrong. Per the audit reference, **Mem û Zîn was completed in 1695** (sala hicrî 1106 begins in mid-1694 but Xanî's colophon is dated to 1106 AH which corresponds to 1694–1695 CE; the standard scholarly date is 1695). Acceptable variance but not a clear error since 1106 AH overlaps both years; flag for consistency with audit canon.
**Fix**: Use `1695an` to match the platform's reference date. Same in Turkish at line 439.
**Severity**: minor

### [FILE: kurdish_legends_db.dart, LINE: 425]
**Field**: kurmanjContent (l_011 Mem û Zîn)
**Current**: `'Mem, kurê mîrê aşîreta Alan; Zîn, xwişka Mîrê Botanê.'`
**Issue**: Inconsistency with line 442 Turkish: "Zin, Botan Beyi'nin kız kardeşidir" — but the canonical Mem û Zîn text has Zîn as the **sister of Mîr Zeynedîn** (Mîrê Botan), specifically. Acceptable abbreviation; the more precise rendering is "xwişka Mîr Zeynedînê Botan". Minor.
**Fix**: Optional: `Zîn, xwişka Mîr Zeynedînê Botan`.
**Severity**: minor

### [FILE: kurdish_legends_db.dart, LINE: 519]
**Field**: kurmanjTitle (l_013 Şingala 2014)
**Current**: `'Şingala 2014 — Qirkirina Êzîdiyan'`
**Issue**: `Êzîdiyan` should be `Êzîdiyan` with consistent capital/diacritic. The keywords list at line 559 uses `'Êzîdî'`; the title body at 522, 530 uses `Êzîdî`; but the `kurmanjTitle` here writes `Êzîdiyan` (oblique plural) which is fine grammatically but uses lowercase 'i' instead of `Î` for the inflected form. Standard plural genitive: `Êzîdiyan` is OK; flag only as cosmetic.
**Fix**: none required; consistent.
**Severity**: minor / non-issue.

### [FILE: kurdish_legends_db.dart, LINE: 530-531]
**Field**: kurmanjContent (l_013 Şingal)
**Current**: `'Nadîa Mûrad, keçeke Êzîdî ya ji Koço, ji destê \nDAÎŞê xilas bû û paşê bû Xelata Nobel a Aştiyê (2018).'`
**Issue**: Grammar: `bû Xelata Nobel a Aştiyê` literally reads "she became the Nobel Peace Prize". Should be `wergir/sitand` (received): `paşê Xelata Nobel a Aştiyê wergirt (2018)`. Same nonsense in concept in Turkish at line 547 ("2018 Nobel Barış Ödülü'nü aldı" — Turkish is correct, but Kurmanji is broken).
**Fix**: `'... paşê Xelata Nobel a Aştiyê wergirt (2018).'`
**Severity**: moderate

---

## G. PROVERB-DB CRITICAL DATA INTEGRITY ISSUES

### [FILE: gotinen_pesiyan_db.dart, LINE: 1660]
**Field**: ku (entry H.190)
**Current**: `(letter: 'H', num: 190, ku: 'Hin gotinên pêşîyan ji Kurdên anatolya navîn', tr: null),`
**Issue**: This is **not a proverb** — it is a **section header** ("Some proverbs from Central Anatolian Kurds") that has been swept into the data list as a regular entry. Major data-integrity bug. It will appear in user-facing displays as an actual proverb.
**Fix**: Remove this entry (or move to a comment / separate metadata field).
**Severity**: major

### [FILE: gotinen_pesiyan_db.dart, LINE: 3271]
**Field**: ku (entry Y.8)
**Current**: `(letter: 'Y', num: 8, ku: 'Yavaş yûrûyorum bela bana yetişiyor, hizli yûrûyorum ben belaya yetişiyorum', tr: null),`
**Issue**: Major data error. The `ku` field contains **Turkish** text (a translation of an existing Kurmanji proverb already in the DB at H.163 line 1633: `Hêdi dimeşim bela dighê mi, zû dimeşim ez dighêm bela`). This entry should be removed entirely — or, if intended as a translation pair, the Kurmanji should go in `ku` and the Turkish in `tr`.
**Fix**: Remove entry Y.8 (Turkish-only content masquerading as Kurmanji proverb).
**Severity**: major

### [FILE: gotinen_pesiyan_db.dart, LINE: 1535]
**Field**: ku (entry H.65)
**Current**: `(letter: 'H', num: 65, ku: 'Hem ji dêrê bû hem ji ji mizgeftê', tr: 'Hem kiliseden oldu hem de camiden'),`
**Issue**: Typo `ji ji` (doubled preposition) — should be `hem ji mizgeftê`. Minor transcription error.
**Fix**: `'Hem ji dêrê bû hem ji mizgeftê'`.
**Severity**: minor

### [FILE: gotinen_pesiyan_db.dart, LINE: 1561]
**Field**: ku (entry H.91)
**Current**: `(letter: 'H', num: 91, ku: 'Her şêrek bi lepê xwê ye', tr: 'Her aslan kendi pençesiyle'),`
**Issue**: Typo: `xwê` (= salt) should be `xwe` (= self/own). Compare H.86 at line 1556 (`Her êrek bi lepê xwe ye`) which has the correct `xwe`. The typo changes meaning from "with its own paw" to "with the salty paw".
**Fix**: `'Her şêrek bi lepê xwe ye'`.
**Severity**: moderate

### [FILE: gotinen_pesiyan_db.dart, LINE: 1502]
**Field**: ku (entry H.32)
**Current**: `(letter: 'H', num: 32, ku: 'Heftyaro, li ber çavan diyaro', tr: null),`
**Issue**: Likely typo. The known proverb is `Heft yaro, li ber çavan diyaro` ("Seven friends, visible before [my] eyes"). The space between "Heft" and "yaro" was lost.
**Fix**: `'Heft yaro, li ber çavan diyaro'`.
**Severity**: minor

### [FILE: gotinen_pesiyan_db.dart, LINES: 1554, 1556]
**Field**: ku — duplicates between H.84 and H.86 closely
**Current**: H.84 `Herne kure, li min mikure` and H.86 `Her êrek bi lepê xwe ye`. Adjacent H.85/H.87/H.88 also include near-duplicates `Her dar siyê ji koka xwe re nake` (H.85), `Her giha li ser koka xwe şin tê` (H.87) and `Her giya li ser koka xwe hêşîn tê` (H.88).
**Issue**: H.87/H.88 are near-duplicate variants of the same proverb. As folk material this can be preserved, but flag for canonicalization decision.
**Fix**: optional consolidation.
**Severity**: minor

### [FILE: gotinen_pesiyan_db.dart, LINES: 3210-3211]
**Field**: ku (X.71 / X.72)
**Current**: Two consecutive entries with virtually identical text differing only by a missing space:
- X.71: `'Xwedê ji yekîre xera bike diranê wî di pelûlê de dişkê'`
- X.72: `'Xwedê ji yekî re xera bike diranê wî di pelûlê de dişkê'`

**Issue**: One is a transcription of the other with `yekîre` → `yekî re` correction. Should be a single canonical entry.
**Fix**: Remove X.71 (incorrect spacing) and keep X.72.
**Severity**: minor

### [FILE: gotinen_pesiyan_db.dart, LINE: 3245-3246]
**Field**: ku (X.106 / X.107)
**Current**: `(X.106) 'Xwe di kara xwe de, ker di nav naxire de, tu dibejî: "Ha werin xwe, ha werin xwe!"'`
**Issue**: Likely typo `di kara` → `di kar a` or `di karê`. Hard to confirm without source; flag as transcription concern.
**Fix**: defer to source manuscript.
**Severity**: minor

### [FILE: gotinen_pesiyan_db.dart, LINES: 3223, 3226]
**Field**: ku (X.84 vs X.87)
**Current**: 
- X.84: `'Xwediyê xêra dibe evdalê ber dêra'` (tr: 'İyilik sahibi kilisenin hizmetçisi olur')
- X.87: `'Xwedyê xêra dibe evdalê ber dêra'` (tr: 'İyilik sahibi kilisenin hizmetçisi olur.')

**Issue**: X.87 has typo `Xwedyê` (missing -i-) — should be `Xwediyê`. Otherwise duplicates X.84.
**Fix**: Remove X.87 (typo duplicate).
**Severity**: minor

---

## H. SUMMARY OF ACTION ITEMS

**MAJOR (must fix)**: 
- h_013 Selçûqîyan/Sefewîyan
- h_012 Tehran→Qezwîn
- h_012 pîramidên→şecere
- h_015 Mîyando Av/Sereiş→Miyandoab/Seqiz
- h_019 Sara Xatun century 14→15
- h_019 Sara Xatun Tehran→Trabzon
- h_019 Sara Xatun "Jina Mîr Bohtanê" verification
- s_021 duplicate ID
- gotinen_pesiyan H.190 stray header
- gotinen_pesiyan Y.8 Turkish in ku field

**MODERATE**:
- Vîranşar→Wêranşar (s_001)
- Stembol/Stenbol consistency (h_014)
- El-yazma→destnivîs, Pariş→Parîs (h_012)
- dirêjberg→darçîn (foods)
- nehniyê→pûng (food awxa)
- "Kurdish bölgesindeki" left as English in Turkish (l_003)
- Şahmaran "yê mar"→"yên marî"
- Cigerxwîn→Cegerxwîn (p_005)
- Cegerxwîn poem "şerm û nefret im" mis-quote
- Hejar Mukriyanî tense/preposition
- Mikail Aslan primary language
- Nadîa Mûrad "bû Xelata Nobel"→"wergirt"
- Idrîs "ya yekem bi Farisî" overstated
- zankoya→zaningeha (h_020)
- Ezê biçim → Ez ê biçim (p_004)
- Hem ji ji → Hem ji (gotinen H.65)
- xwê → xwe (gotinen H.91)

**MINOR / cosmetic**:
- Diakritik consistency (Selahaddin/Selahaddîn, Idrîs/Îdrîs)
- Dating caveats (Selahaddin 1137/1138; Evdalê Zeynikê dates traditional)
- Iraqa nûjen → Iraqa îroyîn
- Dwîn / Ermenistan anachronism
- Diyarbekir/Amed mixing
- Mem û Zîn 1694→1695 alignment
- Xanaqîn→Xaneqîn
- Various proverb typo duplicates (H.32, H.65, X.71, X.87)

Total: ~35 substantive findings.

