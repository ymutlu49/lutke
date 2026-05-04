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
