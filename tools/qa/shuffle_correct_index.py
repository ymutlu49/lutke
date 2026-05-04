"""Shuffle options + correctIndex to fix position bias.

Uses deterministic seeding (per-item id hash) so same item always gets
same permutation — reproducible builds.

Skips:
  - Numerical sequences (chronological/ordered)
  - Single-letter options (likely A/B/C answer keys)
  - reorder/sequential exercises
"""
import os, re, sys, random, hashlib
sys.stdout.reconfigure(encoding='utf-8')

# Files that need shuffling (high position bias)
TARGET_FILES = [
    'lib/features/cultural_content/domain/character_stories_db.dart',
    'lib/features/exercises/domain/listening_exercise_db.dart',
    'lib/features/lessons/domain/a1_lesson_definitions.dart',
    'lib/features/lessons/domain/a2_lesson_definitions.dart',
    'lib/features/lessons/domain/b1_lesson_definitions.dart',
    'lib/features/lessons/domain/b2_lesson_definitions.dart',
    'lib/features/lessons/domain/c1_lesson_definitions.dart',
    'lib/features/lessons/domain/c2_lesson_definitions.dart',
    'lib/features/en_learning/domain/en_grammar_db.dart',
]

# Skip patterns — don't shuffle these
def is_ordered_options(opts):
    """Detect chronological / numerical / alphabetical sequences."""
    if len(opts) < 4:
        return False
    # All look like dates / years
    if all(re.fullmatch(r'\d{4}', o.strip()) for o in opts):
        return True
    # All single digits or short numbers
    if all(re.fullmatch(r'\d{1,3}', o.strip()) for o in opts):
        return True
    # All letters (A, B, C, D)
    if all(len(o.strip()) == 1 and o.strip().isalpha() for o in opts):
        return True
    # Yek/Du/Sê/Çar (Kurmancî numbers — order matters)
    kurmancî_nums = ['yek', 'du', 'sê', 'çar', 'pênc', 'şeş', 'heft', 'heşt', 'neh', 'deh']
    if all(o.strip().lower() in kurmancî_nums for o in opts):
        return True
    return False

def find_options_block(content, opts_start_marker_end):
    """Find [...] starting at or after marker. Returns (start, end) of [ and ]."""
    i = opts_start_marker_end
    while i < len(content) and content[i] != '[':
        i += 1
    if i == len(content):
        return None, None
    bracket_start = i
    depth = 1
    j = i + 1
    while j < len(content) and depth > 0:
        ch = content[j]
        if ch == '[':
            depth += 1
        elif ch == ']':
            depth -= 1
            if depth == 0:
                return bracket_start, j
        elif ch == "'":
            j += 1
            while j < len(content) and content[j] != "'":
                if content[j] == '\\':
                    j += 1
                j += 1
        elif ch == '"':
            j += 1
            while j < len(content) and content[j] != '"':
                if content[j] == '\\':
                    j += 1
                j += 1
        j += 1
    return None, None

def parse_string_literals(s):
    """Extract string literals with their positions in s."""
    items = []
    pos = 0
    while pos < len(s):
        ch = s[pos]
        if ch == "'":
            end = pos + 1
            while end < len(s):
                if s[end] == '\\':
                    end += 2
                elif s[end] == "'":
                    items.append({'start': pos, 'end': end+1, 'value': s[pos+1:end], 'quote': "'"})
                    pos = end + 1
                    break
                else:
                    end += 1
            else:
                pos = len(s)
        elif ch == '"':
            end = pos + 1
            while end < len(s):
                if s[end] == '\\':
                    end += 2
                elif s[end] == '"':
                    items.append({'start': pos, 'end': end+1, 'value': s[pos+1:end], 'quote': '"'})
                    pos = end + 1
                    break
                else:
                    end += 1
            else:
                pos = len(s)
        else:
            pos += 1
    return items

def derive_id(window_text, fallback_pos):
    m = re.search(r"id:\s*['\"]([^'\"]+)['\"]", window_text)
    return m.group(1) if m else f"pos_{fallback_pos}"

# Process each file
total_shuffles = 0
total_skipped = 0
file_stats = {}

for filepath in TARGET_FILES:
    if not os.path.exists(filepath):
        continue

    with open(filepath, encoding='utf-8') as f:
        content = f.read()

    # Find each `options:` or `opts:` followed by [
    out = []
    pos = 0
    shuffles_in_file = 0
    skipped_in_file = 0

    pattern = re.compile(r"(options|opts):\s*\[")
    last_end = 0

    matches = list(pattern.finditer(content))

    for m in matches:
        if m.start() < last_end:
            continue  # skip overlap
        # Append unchanged content up to start of options:
        out.append(content[last_end:m.start()])

        # Find options block
        opts_field = m.group(0)  # e.g., "options: ["
        bracket_start, bracket_end = find_options_block(content, m.end() - 1)
        if bracket_start is None:
            out.append(content[m.start():m.end()])
            last_end = m.end()
            continue

        # Find correctIndex AFTER this options block (within reasonable window)
        win_end = min(len(content), bracket_end + 600)
        ci_match = re.search(
            r"(correctIndex|ci):\s*(\d+)",
            content[bracket_end:win_end]
        )
        if not ci_match:
            # No correctIndex found — keep as is
            out.append(content[m.start():bracket_end+1])
            last_end = bracket_end + 1
            continue

        ci_value = int(ci_match.group(2))

        # Get id from window (look back too)
        window_back = content[max(0, m.start()-500):m.start()]
        item_id = derive_id(window_back + content[m.start():bracket_end+1], m.start())

        # Parse options
        opts_block = content[bracket_start+1:bracket_end]
        literals = parse_string_literals(opts_block)
        opts = [lit['value'] for lit in literals]

        if not opts or len(opts) < 2:
            out.append(content[m.start():bracket_end+1])
            last_end = bracket_end + 1
            continue

        if ci_value < 0 or ci_value >= len(opts):
            out.append(content[m.start():bracket_end+1])
            last_end = bracket_end + 1
            continue

        # Skip if options are ordered (numbers, letters, etc.)
        if is_ordered_options(opts):
            skipped_in_file += 1
            out.append(content[m.start():bracket_end+1])
            last_end = bracket_end + 1
            continue

        # Generate deterministic shuffle
        seed = int(hashlib.md5(item_id.encode()).hexdigest(), 16) % (2**32)
        rng = random.Random(seed)
        indices = list(range(len(opts)))
        rng.shuffle(indices)

        # If shuffle results in same order, swap two positions
        if indices == list(range(len(opts))):
            indices[0], indices[1] = indices[1], indices[0]

        # New options + new correctIndex
        new_opts = [opts[i] for i in indices]
        new_ci = indices.index(ci_value)

        # Reconstruct options block — replace each literal value with new value
        # while preserving spacing/quotes
        new_block_parts = []
        prev_end = 0
        for j, lit in enumerate(literals):
            new_block_parts.append(opts_block[prev_end:lit['start']])
            # Use original quote style
            new_block_parts.append(f"{lit['quote']}{new_opts[j]}{lit['quote']}")
            prev_end = lit['end']
        new_block_parts.append(opts_block[prev_end:])
        new_opts_block = ''.join(new_block_parts)

        # Output: from match start until [ , then new options inside, then close
        out.append(content[m.start():bracket_start+1])
        out.append(new_opts_block)
        out.append(']')

        # Now we need to replace the correctIndex with new value
        # Find the next correctIndex/ci occurrence after bracket_end and replace
        ci_abs_pos = bracket_end + ci_match.start()
        ci_abs_end = bracket_end + ci_match.end()
        # Append content from ] to ci start
        out.append(content[bracket_end+1:ci_abs_pos])
        # Append updated ci
        out.append(f"{ci_match.group(1)}: {new_ci}")
        last_end = ci_abs_end
        shuffles_in_file += 1

    out.append(content[last_end:])
    new_content = ''.join(out)

    # Write back if changes made
    if shuffles_in_file > 0:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        file_stats[filepath] = (shuffles_in_file, skipped_in_file)
        total_shuffles += shuffles_in_file
        total_skipped += skipped_in_file

print(f"\n=== Shuffle Summary ===")
for f, (sh, sk) in sorted(file_stats.items()):
    print(f"  {f}: shuffled {sh}, skipped (ordered) {sk}")
print(f"\nTOTAL: {total_shuffles} items shuffled, {total_skipped} skipped (ordered)")
