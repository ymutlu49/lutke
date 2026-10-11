# LÛTKE — Quiz QA Toolkit

Static-analysis tools that scan all activity/quiz items in the codebase and flag
quality defects (position bias, duplicate options, empty/placeholder options,
out-of-bounds `correctIndex`, length anomalies, ambiguous distractors).

## Files

- `quiz_qa_validator.py` — psychometric defects (position/length bias, schema integrity).
  Exits non-zero on hard defects.
- `kurmanci_scanner.py` — Kurmancî content correctness: Turkish characters in KU fields,
  mixed-language options, contamination of audio/prompt text.
- `kurmanci_lint.py` — Kurmancî linguistic linter: misspellings, diacritic errors,
  Turkish calques.
- `assessment_quality.py` — assessment-validity heuristics: weak/evasive distractors
  ("tu ferq nîne", "tu kes", etc.) that test-savvy learners trivially eliminate.
- `shuffle_correct_index.py` — deterministic option shuffler. Uses `md5(item_id)`
  as a seed so the result is reproducible across runs and CI.

## Content measurement and the shared language layer (October 2026)

Three newer tools sit beside the quiz checks. Their docstrings and reports are in Turkish.

- `icerik.py` — shared loader. Parses the word lists out of the Dart sources the way the
  app uses them (`kB1All`, not the smaller `kB1Temam` the website export uses) and collects
  every Kurmancî string from the other databases. `--sinama` cross-checks the parser against
  `website/data/content.json`; CI runs it, so a Dart content edit without a re-export fails.
- `ziman_denetim.py` — runs the workspace's shared linter
  (`Kurmanci/Ziman/araclar/kontrol.py`, rules in `Kurmanci/Ziman/REBER.md`) over all of that
  text. It needs the corpus, which cannot live in this repo, so it runs **locally only** and
  skips cleanly when the layer is absent. `--kapi` fails on flags that are not already
  recorded in `docs/olcum/ziman_isaret.tsv`; reviewed false positives go in
  `ziman_muaf.tsv` with a reason.
- `olcum.py` — writes `docs/olcum/olcum.md`: inventory, example-sentence quality,
  attestation, core-vocabulary coverage, noun gender against two sources, linter flags,
  pre-rendered audio coverage. See `docs/olcum/README.md` for method and limits.

`kurmanci_lint.py` stays as the lightweight CI gate. Where it and
`refs/KURMANCI_RULES.md` differ from `REBER.md`, `REBER.md` wins; the differences are
listed in `docs/norm_uzlasmasi.md`.

Before a release that touches content, locally:

```bash
python tools/qa/ziman_denetim.py --kapi
python tools/qa/olcum.py
```

## Run

From `lutke_flutter_project/`:

```bash
python tools/qa/quiz_qa_validator.py
```

The validator scans these sources (extend the `FILES` list as new content is added):

- `lib/features/onboarding/placement_test_screen.dart`
- `lib/features/exercises/domain/listening_exercise_db.dart`
- `lib/features/exercises/domain/ku_writing_db.dart`
- `lib/features/lessons/domain/{a1,a2,b1,b2,c1,c2}_lesson_definitions.dart`
- `lib/features/cultural_content/domain/character_stories_db.dart`
- `lib/features/en_learning/domain/en_quiz_items.dart`
- `lib/features/en_learning/domain/en_grammar_db.dart`
- `lib/features/en_learning/domain/en_listening_db.dart`

## What gets flagged

| Check | Threshold | Why |
|---|---|---|
| Position bias | any index > 40% of items | Test-takers exploit "answer is always B" |
| Duplicate options within a question | any | Always a content bug |
| Empty / placeholder options | any | Always a content bug |
| `correctIndex` out of bounds | any | Crash risk |
| Length anomaly (correct option much longer than distractors) | correct >2x distractor mean | Cue leakage |

## When to run

- Before every release build
- After bulk content edits (new lessons, new levels)
- Before submitting Play Store updates that touch quiz content

## Re-running the shuffler

If new items are added and bias creeps back, run:

```bash
python tools/qa/shuffle_correct_index.py
```

The seed is `md5(item.id)` so the same input always produces the same output —
diff-friendly and CI-safe.

## Correctness tools (Faz 2, October 2026)

| Tool | What it does |
|---|---|
| `cins_kanit.py` | Gender evidence for every noun from four sources (Wîkîferheng tag, corpus ezafe counts, Farqînî in-entry ezafe examples, suffix rule). `python tools/qa/cins_kanit.py <word>` shows one word |
| `duzelt.py` | Applies a correction table to the Dart content (dry run by default), logs every change to `docs/duzeltme/duzeltme.tsv` and lists sentences whose pre-rendered audio was orphaned |
| `anlam_denetim.py` | Compares each headword's Turkish gloss with dictionary data and lists mismatches for reading (`docs/olcum/anlam_supheli.tsv`) |
| `cumle.py` | Sentence pool (Faz 3): measures full-sentence coverage per level, mines corpus candidates (written outside the repo), validates `docs/cumle/havuz.tsv` and turns it into a correction table plus the Dart translation map. Workflow: `docs/cumle/README.md` |
| `fiil.py` | Verb table (Faz 4.2): transitivity from Wîkîferheng, past form and sample conjugations selected from attested corpus forms, with pronoun-evidence counts. Writes `docs/olcum/fiil.tsv` and `lib/features/lessons/domain/fiil_db.dart` |
| `cins_kanit.py --dart` | Writes the verified-gender table used by the generated ezafe drill (`cins_kanit_db.dart`). Rerun after any gender correction |
| `sozvarligi.py` | Core lemmas that have no record of their own, and duplicate headwords by class (`cekirdek_madde_eksik.tsv`, `yinelenen.tsv`) |
| `metin.py` | Level fit of connected texts (Faz 5): share of a text's words covered by headwords taught up to a level; `--dosya <path> --duzey b1` measures any text file |
| `fermat.py` | FerMat bridge (Faz 7): generates the A2 "Matematîk" unit from the shared term base (`Ziman/terim.tsv`); definitions and examples are taken verbatim, terms failing the linter are left out and listed in `docs/olcum/fermat.tsv` |
| `gotar_bag.py` | Gotar bridge: writes the list of published portal articles linked from the reading list (`gotar_baglanti_db.dart`). Rerun when a new article is published |

`ziman_denetim.py` now passes LÛTKE's own gender tags to the linter's ezafe rule, so a
sentence that puts the wrong ezafe on a tagged noun is flagged wherever it occurs.
Workflow and outputs: `docs/duzeltme/README.md`. All three need the `Kurmanci/Ziman`
layer and run locally only.
