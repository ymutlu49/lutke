"""Improved QA validator — better parsing of multi-line options arrays."""
import os, re, sys, collections
sys.stdout.reconfigure(encoding='utf-8')

FILES = [
    'lib/features/onboarding/placement_test_screen.dart',
    'lib/features/exercises/domain/listening_exercise_db.dart',
    'lib/features/exercises/domain/ku_writing_db.dart',
    'lib/features/lessons/domain/a1_lesson_definitions.dart',
    'lib/features/lessons/domain/a2_lesson_definitions.dart',
    'lib/features/lessons/domain/b1_lesson_definitions.dart',
    'lib/features/lessons/domain/b2_lesson_definitions.dart',
    'lib/features/lessons/domain/c1_lesson_definitions.dart',
    'lib/features/lessons/domain/c2_lesson_definitions.dart',
    'lib/features/cultural_content/domain/character_stories_db.dart',
    'lib/features/en_learning/domain/en_quiz_items.dart',
    'lib/features/en_learning/domain/en_grammar_db.dart',
    'lib/features/en_learning/domain/en_listening_db.dart',
]

def parse_options(opts_block):
    """Robust string-literal extraction from a list block."""
    # Match single-quoted and double-quoted strings (handle \' escapes)
    items = []
    # Find balanced strings:
    pos = 0
    while pos < len(opts_block):
        ch = opts_block[pos]
        if ch == "'":
            # Find matching '
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
        elif ch == '"':
            end = pos + 1
            while end < len(opts_block):
                if opts_block[end] == '\\':
                    end += 2
                elif opts_block[end] == '"':
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
    """Given start of 'options:' [, find matching closing ]."""
    # Skip whitespace and find [
    i = opts_start
    while i < len(content) and content[i] != '[':
        i += 1
    if i == len(content):
        return None, None
    # Find matching ]
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
            # skip string
            j += 1
            while j < len(content) and content[j] != "'":
                if content[j] == '\\':
                    j += 1
                j += 1
        elif content[j] == '"':
            j += 1
            while j < len(content) and content[j] != '"':
                if content[j] == '\\':
                    j += 1
                j += 1
        j += 1
    return None, None

# Find each options/opts: occurrence with proper bracket parsing
items = []
for f in FILES:
    if not os.path.exists(f):
        continue
    with open(f, encoding='utf-8') as fh:
        content = fh.read()

    # Match options: or opts: followed by [
    for m in re.finditer(r"(options|opts):\s*\[", content):
        opts_start = m.end() - 1  # the [
        start, end = find_options_block(content, opts_start)
        if start is None:
            continue
        opts_block = content[start:end]
        options = parse_options(opts_block)
        if not options:
            continue

        # Look at +/- 500 chars window for ci, id, prompt
        wstart = max(0, m.start() - 500)
        wend = min(len(content), end + 500)
        window = content[wstart:wend]

        ci_m = re.search(r"(?:correctIndex|ci):\s*(\d+)", window)
        id_m = re.search(r"id:\s*['\"]([^'\"]+)['\"]", window)
        prompt_m = re.search(
            r"(?:prompt|promptEn|kurmanjPrompt|questionKu|question|kuPrompt|stem|kurmanjiText|ku):\s*['\"]([^'\"]+)['\"]",
            window
        )
        line_num = content[:m.start()].count('\n') + 1

        items.append({
            'file': f,
            'line': line_num,
            'id': id_m.group(1) if id_m else f'L{line_num}',
            'prompt': prompt_m.group(1) if prompt_m else '',
            'options': options,
            'correctIndex': int(ci_m.group(1)) if ci_m else None,
        })

print(f"Extracted {len(items)} items via robust parsing")

# Distribution stats per file
print("\n" + "="*60)
print("POSITION BIAS ANALYSIS (correct answer index distribution)")
print("="*60)

file_groups = collections.defaultdict(list)
for it in items:
    if it['correctIndex'] is not None:
        file_groups[it['file']].append(it['correctIndex'])

for f, indices in sorted(file_groups.items()):
    if len(indices) < 5:
        continue
    counter = collections.Counter(indices)
    total = len(indices)
    dist = " ".join(f"i{i}={counter.get(i,0):3d}" for i in range(4))
    most_common, freq = counter.most_common(1)[0]
    pct = freq / total * 100
    flag = "⚠️ BIAS" if pct > 40 else "OK"
    print(f"  {flag:8s} | {dist} | n={total:4d} | max={pct:5.1f}% | {f}")

# Real duplicates (no false positives)
print("\n" + "="*60)
print("REAL DUPLICATE OPTIONS (within single question)")
print("="*60)
dup_count = 0
for it in items:
    seen = []
    dups = []
    for o in it['options']:
        norm = o.strip().lower()
        if not norm:
            continue
        if norm in seen:
            dups.append(o)
        seen.append(norm)
    if dups:
        dup_count += 1
        print(f"  {it['file']}:{it['line']} {it['id']}: dup={dups}")
        if dup_count >= 20:
            break
print(f"\nTotal items with duplicate options: {dup_count}")

# Empty/placeholder options
print("\n" + "="*60)
print("EMPTY/PLACEHOLDER OPTIONS")
print("="*60)
empty_count = 0
for it in items:
    for j, o in enumerate(it['options']):
        if not o.strip() or o.strip() in ['...', '___']:
            print(f"  {it['file']}:{it['line']} {it['id']}: empty option idx {j}")
            empty_count += 1
            if empty_count >= 10:
                break
    if empty_count >= 10:
        break
print(f"Total: {empty_count} (showing first 10)")

# Out-of-bounds correctIndex
print("\n" + "="*60)
print("OUT-OF-BOUNDS correctIndex")
print("="*60)
oob = 0
for it in items:
    ci = it['correctIndex']
    if ci is not None and (ci < 0 or ci >= len(it['options'])):
        print(f"  {it['file']}:{it['line']} {it['id']}: ci={ci}, opts={len(it['options'])}")
        oob += 1
print(f"Total: {oob}")

# Length-bias: correct option much longer than distractor mean (cue leakage)
print("\n" + "="*60)
print("LENGTH-BIAS (correct option longer than distractor mean)")
print("="*60)
lb_per_file = collections.Counter()
lb_examples = collections.defaultdict(list)
RATIO_HARD = 2.0   # correct >= 2x mean of distractors → strong bias
RATIO_SOFT = 1.5   # 1.5x → soft bias

for it in items:
    ci = it['correctIndex']
    opts = it['options']
    if ci is None or ci < 0 or ci >= len(opts) or len(opts) < 2:
        continue
    correct_len = len(opts[ci])
    distractors = [len(o) for j, o in enumerate(opts) if j != ci and o.strip()]
    if not distractors or min(distractors) < 3:
        continue
    mean_d = sum(distractors) / len(distractors)
    if mean_d == 0:
        continue
    ratio = correct_len / mean_d
    if ratio >= RATIO_HARD:
        lb_per_file[it['file']] += 1
        lb_examples[it['file']].append((ratio, it))

for f, count in sorted(lb_per_file.items(), key=lambda x: -x[1]):
    total = len([i for i in items if i['file'] == f and i['correctIndex'] is not None])
    pct = count / total * 100 if total else 0
    flag = "⚠️ BIAS" if pct > 15 else "OK"
    print(f"  {flag:8s} | n={count:3d}/{total:4d} ({pct:4.1f}%) | {f}")

print("\nWorst offenders (top 15, ratio >= 2.0):")
all_lb = []
for f, exs in lb_examples.items():
    for ratio, it in exs:
        all_lb.append((ratio, it))
all_lb.sort(key=lambda x: -x[0])
for ratio, it in all_lb[:15]:
    print(f"  {ratio:.1f}x | {it['file'].split('/')[-1]}:{it['line']} {it['id']}")
    print(f"        prompt: {it['prompt'][:80]}")
    print(f"        correct[{it['correctIndex']}]: {it['options'][it['correctIndex']][:80]}")

# CI gate — exit non-zero if any hard defect present
import sys as _sys
fail = False
if dup_count > 0:
    print(f"\n❌ FAIL: {dup_count} duplicate-option items")
    fail = True
if empty_count > 0:
    print(f"\n❌ FAIL: {empty_count} empty-option items")
    fail = True
if oob > 0:
    print(f"\n❌ FAIL: {oob} out-of-bounds correctIndex")
    fail = True
# Position bias > 40%
for f, indices in file_groups.items():
    if len(indices) < 5:
        continue
    counter = collections.Counter(indices)
    pct = counter.most_common(1)[0][1] / len(indices) * 100
    if pct > 50:
        print(f"\n❌ FAIL: position bias {pct:.1f}% in {f}")
        fail = True

if fail:
    print("\n=== QA gate FAILED ===")
    _sys.exit(1)
else:
    print("\n=== QA gate PASSED ===")
