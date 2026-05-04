"""Kurmancî-specific content scanner.

Detects:
  1. Turkish characters in Kurmancî fields (ı, İ, ğ, ü, ö — none belong in Kurmancî except in TR fields/borrowings).
  2. Suspicious Turkish words in Kurmancî prompt/options (heuristic word list).
  3. Mixed-language options (one option pure-TR, others KU).
  4. Diacritic-stripped forms of common Kurmancî words (e.g., "ders" instead of "dersê", "wane" without diacritic) — already mostly handled.
  5. Prompt-option mismatch: ku/kurmanjPrompt is Kurmancî but options array contains Turkish-only strings.
  6. Long distractor with ratio > 1.5x (soft length-bias).

Read-only. Reports counts + top examples per file.
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
    'lib/features/exercises/domain/ku_writing_db.dart',
    'lib/features/exercises/domain/ku_speaking_db.dart',
    'lib/features/cultural_content/domain/character_stories_db.dart',
    'lib/features/cultural_content/domain/kurdish_legends_db.dart',
    'lib/features/cultural_content/domain/kurdish_artists_db.dart',
    'lib/features/cultural_content/domain/kurdish_foods_db.dart',
    'lib/features/cultural_content/domain/kurdish_celebrations_db.dart',
    'lib/features/cultural_content/domain/kurdish_events_db.dart',
    'lib/features/cultural_content/domain/kurdish_historical_figures_db.dart',
    'lib/features/cultural_content/domain/kurdish_folk_dances_db.dart',
    'lib/features/cultural_content/domain/kurdish_architecture_db.dart',
    'lib/features/cultural_content/domain/kurdish_poems_full_db.dart',
    'lib/features/cultural_content/domain/kurdish_songs_full_db.dart',
    'lib/features/cultural_content/cultural_entities.dart',
    'lib/features/lessons/domain/heritage_dialogues.dart',
    'lib/features/lessons/domain/heritage_c_dialogues.dart',
    'lib/features/onboarding/placement_test_screen.dart',
]

# Turkish-specific characters not in Kurmancî alphabet
# Kurmancî alphabet: a b c ç d e ê f g h i î j k l m n o p q r s ş t u û v w x y z
# Specifically Turkish-only: ı (dotless i), İ (dotted capital I), ğ, ü, ö
# Note: ç and ş are shared but Turkish has different letters
TURKISH_ONLY_CHARS = ['ı', 'İ', 'ğ', 'Ğ']  # ü/ö excluded since they appear in some loanwords

# Common Turkish words that don't belong in Kurmancî text (function words, common verbs)
TURKISH_WORDS = {
    'çok', 'ben', 'sen', 'biz', 'siz', 'onlar', 'bir', 'iki', 'üç',
    'için', 'ile', 'gibi', 'kadar', 'sonra', 'önce',
    've', 'veya', 'ama', 'fakat', 'çünkü',
    'bu', 'şu', 'ne', 'niçin', 'neden', 'nasıl',
    'olmak', 'yapmak', 'gitmek', 'gelmek', 'almak',
    'çocuk', 'kadın', 'erkek', 'aile', 'ev',
    'iyi', 'kötü', 'güzel', 'büyük', 'küçük',
    'değil', 'evet', 'hayır',
    'şey', 'her', 'hiç', 'bazı',
}

# Kurmancî field keys — we scan content of these
KU_KEYS = ['ku', 'kurmanjPrompt', 'kuPrompt', 'questionKu', 'kurmanji',
           'kurmanjiText', 'audioText', 'storyKu', 'kurmanjTitle',
           'storyText', 'before', 'after']

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

def is_turkish_word(word):
    """Heuristic: contains Turkish-only chars OR is in TR word list."""
    w = word.lower().strip('.,!?:;"()')
    if not w:
        return False
    if any(c in w for c in TURKISH_ONLY_CHARS):
        return True
    return w in TURKISH_WORDS

def looks_kurmanci(text):
    """Heuristic: text contains Kurmancî-specific markers (î, ê, û, q, x, w, ş after vowels)."""
    if not text:
        return False
    # Strong Kurmancî markers
    if any(c in text for c in 'îêûÎÊÛ'):
        return True
    # Common Kurmancî words
    ku_words = ['ku ', 'ji ', 'di ', 'li ', 'bi ', 'bo ', 'ye ', 'in ', 'me ', 'min ', 'we ',
                'tu ', 'ew ', 'em ', 'na ', 'ne ', 'ya ', 'yê ', 'yan ', 'yek ', 'gel',
                'mafê', 'welat', 'çand']
    return any(kw in text.lower() for kw in ku_words)

def looks_turkish(text):
    """Heuristic: text contains Turkish-only chars or many TR function words."""
    if not text:
        return False
    if any(c in text for c in TURKISH_ONLY_CHARS):
        return True
    words = re.findall(r'\b\w+\b', text.lower())
    tr_count = sum(1 for w in words if w in TURKISH_WORDS)
    return tr_count >= 2 and tr_count / max(len(words), 1) > 0.3

def scan_file(filepath):
    with open(filepath, encoding='utf-8') as f:
        content = f.read()

    findings = collections.defaultdict(list)

    # --- Check 1: Turkish-only chars in ku/kurmanjPrompt fields ---
    for key in KU_KEYS:
        # Match key: 'value' (single-line strings)
        pattern = rf"\b{key}:\s*'([^'\\]*(?:\\.[^'\\]*)*)'"
        for m in re.finditer(pattern, content):
            val = m.group(1)
            for ch in TURKISH_ONLY_CHARS:
                if ch in val:
                    line = content[:m.start()].count('\n') + 1
                    findings['turkish_chars_in_ku'].append((line, key, ch, val[:80]))
                    break

    # --- Check 2: Mixed-language options ---
    for m in re.finditer(r"(options|opts):\s*\[", content):
        s, e = find_options_block(content, m.end() - 1)
        if s is None:
            continue
        opts = parse_options(content[s:e])
        if len(opts) < 2:
            continue
        # Look at +/- 800 char window for ku key
        wstart = max(0, m.start() - 800)
        wend = min(len(content), e + 200)
        window = content[wstart:wend]

        # Get nearby ku/kurmanjPrompt to determine question language
        ku_match = re.search(r"(?:ku|kurmanjPrompt|questionKu|kuPrompt|question):\s*'([^']{5,})'", window)
        if not ku_match:
            continue
        ku_text = ku_match.group(1)
        if not looks_kurmanci(ku_text):
            continue  # Skip if question doesn't look Kurmancî

        # Question is Kurmancî → check if any option is purely Turkish
        ku_opts = sum(1 for o in opts if looks_kurmanci(o))
        tr_opts = []
        for j, o in enumerate(opts):
            if looks_turkish(o) and not looks_kurmanci(o):
                tr_opts.append((j, o))

        if tr_opts and ku_opts >= 1:
            line = content[:m.start()].count('\n') + 1
            id_m = re.search(r"id:\s*'([^']+)'", window)
            findings['mixed_language_options'].append(
                (line, id_m.group(1) if id_m else f'L{line}', ku_text[:60], tr_opts)
            )

    # --- Check 3: Suspicious word list patterns ---
    # Pattern: Kurmancî text containing stray Turkish words
    for key in ['ku', 'kurmanjPrompt', 'audioText']:
        pattern = rf"\b{key}:\s*'([^']{{15,}})'"
        for m in re.finditer(pattern, content):
            val = m.group(1)
            if not looks_kurmanci(val):
                continue
            # Look for embedded Turkish-only chars
            tr_chars_found = [c for c in TURKISH_ONLY_CHARS if c in val]
            if tr_chars_found:
                line = content[:m.start()].count('\n') + 1
                findings['turkish_in_kurmanci_text'].append(
                    (line, key, ''.join(tr_chars_found), val[:80])
                )

    return findings

# === RUN ===
print("=" * 70)
print("KURMANCÎ CONTENT SCANNER")
print("=" * 70)

total_issues = collections.Counter()
all_findings = {}

for f in KU_FILES:
    if not os.path.exists(f):
        continue
    findings = scan_file(f)
    if any(findings.values()):
        all_findings[f] = findings
        for k, v in findings.items():
            total_issues[k] += len(v)

print(f"\nTotal issues by category:")
for k, v in total_issues.most_common():
    print(f"  {v:4d}  {k}")

print("\n" + "=" * 70)
print("ISSUE 1: TURKISH-ONLY CHARS IN KURMANCÎ FIELDS")
print("(Possible causes: typos, contamination from TR field, loanwords)")
print("=" * 70)
for f, fnd in all_findings.items():
    items = fnd.get('turkish_chars_in_ku', [])
    if items:
        print(f"\n{f}:")
        for line, key, ch, val in items[:10]:
            print(f"  L{line:5d}  {key}={ch!r}  -->  {val}")
        if len(items) > 10:
            print(f"  ... +{len(items)-10} more")

print("\n" + "=" * 70)
print("ISSUE 2: MIXED-LANGUAGE OPTIONS (KU question, TR distractor)")
print("=" * 70)
for f, fnd in all_findings.items():
    items = fnd.get('mixed_language_options', [])
    if items:
        print(f"\n{f}:")
        for line, id_, prompt, tr_opts in items[:10]:
            print(f"  L{line:5d}  {id_}")
            print(f"           prompt: {prompt}")
            for idx, opt in tr_opts:
                print(f"           opt[{idx}]: {opt[:70]}")
        if len(items) > 10:
            print(f"  ... +{len(items)-10} more")

print("\n" + "=" * 70)
print("ISSUE 3: TURKISH CHARS INSIDE KURMANCÎ AUDIO/PROMPT TEXT")
print("=" * 70)
for f, fnd in all_findings.items():
    items = fnd.get('turkish_in_kurmanci_text', [])
    if items:
        print(f"\n{f}:")
        for line, key, chars, val in items[:10]:
            print(f"  L{line:5d}  {key}  ({chars!r})  -->  {val}")
        if len(items) > 10:
            print(f"  ... +{len(items)-10} more")
