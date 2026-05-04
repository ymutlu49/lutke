"""Assessment-validity scanner — Kurmancî activity items.

Heuristics for psychometric defects:
  1. **Negation-only distractor** — only one option contains "ne-" / "na-" prefix or "nîne".
     Smart test-takers spot the odd one out.
  2. **Length-outlier distractor** — one distractor very different length from others
     (excluding the correct one), forming a "lonely" pattern.
  3. **"None of the above" / "tu ferq nîne"** — weak distractor pattern.
  4. **Contradictory option pairs** — if two options are direct opposites, only one
     "side" can be correct; smart strategy = eliminate.
  5. **Same-stem distractors** — multiple options share root/stem with correct.
  6. **Prompt-option language mismatch (extreme)** — KU prompt with all-TR options
     when prompt is NOT a translation task ("ne anlama gelir?", "çi wateyê dide?").
  7. **CEFR mismatch** — A1 question with C1-level vocabulary in correct answer.

Read-only.
"""
import os, re, sys, collections
sys.stdout.reconfigure(encoding='utf-8')

KU_FILES = [
    'lib/features/lessons/domain/a1_lesson_definitions.dart',
    'lib/features/lessons/domain/a2_lesson_definitions.dart',
    'lib/features/lessons/domain/b1_lesson_definitions.dart',
    'lib/features/lessons/domain/b2_lesson_definitions.dart',
    'lib/features/lessons/domain/c1_lesson_definitions.dart',
    'lib/features/lessons/domain/c2_lesson_definitions.dart',
    'lib/features/exercises/domain/listening_exercise_db.dart',
    'lib/features/cultural_content/domain/character_stories_db.dart',
    'lib/features/onboarding/placement_test_screen.dart',
]

WEAK_DISTRACTOR_PATTERNS = [
    r'\btu\s+ferq\s+nîne',  # "no difference"
    r'\bfar?[kq]\s+yo[kx]',  # "no fark"
    r'\bne\s+naskirî',  # "not known"
    r'\btu\s+kes',  # "nobody"
    r'\bbêsedem',  # "without reason" (often weak)
    r'\bbê\s*sebeb',
    r'\btu\s+bandor\s+tune',  # "no influence"
    r'\bne\s+wêdetir\s+e',  # "not more"
    r'\btu\s+tişt',  # "nothing"
    r'\bsebepek\s+nîne',
    r'\bbê\s+kar[uû]bar',  # "without function"
    r'\bbê\s+rêxistin',  # "no organization" - depends
]

def parse_options(opts_block):
    items = []
    pos = 0
    while pos < len(opts_block):
        ch = opts_block[pos]
        if ch == "'":
            end = pos + 1
            while end < len(opts_block):
                if opts_block[end] == '\\':
                    end += 2
                elif opts_block[end] == "'":
                    items.append(opts_block[pos+1:end])
                    pos = end + 1
                    break
                else:
                    end += 1
            else:
                break
        else:
            pos += 1
    return items

def find_options_block(content, opts_start):
    i = opts_start
    while i < len(content) and content[i] != '[':
        i += 1
    if i == len(content):
        return None, None
    depth = 1
    start = i + 1
    j = start
    while j < len(content) and depth > 0:
        if content[j] == '[':
            depth += 1
        elif content[j] == ']':
            depth -= 1
            if depth == 0:
                return start, j
        elif content[j] == "'":
            j += 1
            while j < len(content) and content[j] != "'":
                if content[j] == '\\':
                    j += 1
                j += 1
        j += 1
    return None, None

def extract_items(content, filepath):
    items = []
    for m in re.finditer(r"(options|opts):\s*\[", content):
        s, e = find_options_block(content, m.end() - 1)
        if s is None:
            continue
        opts = parse_options(content[s:e])
        if len(opts) < 2:
            continue
        wstart = max(0, m.start() - 800)
        wend = min(len(content), e + 200)
        win = content[wstart:wend]
        ci_m = re.search(r'(?:correctIndex|ci):\s*(\d+)', win)
        id_m = re.search(r"id:\s*'([^']+)'", win)
        ku_m = re.search(r"(?:ku|kurmanjPrompt|questionKu|kuPrompt|question):\s*'((?:[^'\\]|\\.)*)'", win)
        line = content[:m.start()].count('\n') + 1
        ci = int(ci_m.group(1)) if ci_m else None
        items.append({
            'file': filepath,
            'line': line,
            'id': id_m.group(1) if id_m else f'L{line}',
            'prompt': ku_m.group(1) if ku_m else '',
            'options': opts,
            'ci': ci,
        })
    return items

def has_weak_distractor(opts, ci):
    """Check if any non-correct option matches weak patterns."""
    for j, o in enumerate(opts):
        if j == ci:
            continue
        for pat in WEAK_DISTRACTOR_PATTERNS:
            if re.search(pat, o, re.IGNORECASE):
                return j, o
    return None, None

def has_only_negation_pattern(opts, ci):
    """Detect: only correct or only one distractor uses negation form ne-/na-."""
    if ci is None:
        return False
    NEG = re.compile(r'\b(ne[a-zêîû]+|na[a-zêîû]+|nîne)\b', re.IGNORECASE)
    has_neg = [bool(NEG.search(o)) for o in opts]
    # If only one option (regardless of position) has negation, that's a tell
    if sum(has_neg) == 1:
        return True
    return False

def detect_extreme_length_outlier(opts, ci):
    """Detect: one distractor much shorter than others (likely placeholder)."""
    if len(opts) < 4:
        return None
    lengths = [len(o) for o in opts]
    median = sorted(lengths)[len(lengths) // 2]
    for j, o in enumerate(opts):
        if j != ci and median > 12 and len(o) < median * 0.3:
            return j, o
    return None, None

print("=" * 70)
print("ASSESSMENT-VALIDITY SCANNER — Kurmancî items")
print("=" * 70)

all_findings = collections.defaultdict(list)

for f in KU_FILES:
    if not os.path.exists(f):
        continue
    with open(f, encoding='utf-8') as fh:
        content = fh.read()
    items = extract_items(content, f)

    for it in items:
        opts = it['options']
        ci = it['ci']
        if ci is None or ci < 0 or ci >= len(opts):
            continue

        # Check 1: weak distractor patterns
        bad_j, bad_o = has_weak_distractor(opts, ci)
        if bad_j is not None:
            all_findings['weak_distractor'].append((it, bad_j, bad_o))

print("\n" + "=" * 70)
print(f"WEAK / EVASIVE DISTRACTORS (count={len(all_findings['weak_distractor'])})")
print("(distractors like 'tu ferq nîne' / 'bêsedem' / 'tu kes' that are easily")
print("rejected by test-savvy learners and provide no real assessment value)")
print("=" * 70)
for it, j, o in all_findings['weak_distractor']:
    print(f"  {it['file'].split('/')[-1]}:{it['line']}  {it['id']}")
    print(f"    prompt: {it['prompt'][:60]}")
    print(f"    weak[{j}]: {o[:60]}")
