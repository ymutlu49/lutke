"""Kurmancî linguistic linter — extended Bedirxan-Lescot rule set (Round 3).

Detects:
  1. Common misspellings (peyvên ku gelek caran şaş tên nivîsîn)
  2. Diacritic errors (i vs î, e vs ê, u vs û missing where required)
  3. Joined future-tense forms (Ezê/Tuê/Ewê/Emê → MUST be separate per Bedirxan-Lescot)
  4. Past-tense ergativity violations (Wan/Min/Te/Wê + present indicative)
  5. Turkish calques (ki vs ku, çay kirin, lazim, etc.)
  6. Bedirxan-Hawar standard violations
  7. Common loanword/calque issues
  8. Ezafe/oblique confusion in `ez` field of vocab entries
  9. Reciprocal pronoun agreement (`hev` requires plural verb)

Reference: tools/qa/refs/KURMANCI_RULES.md (Bedirxan-Lescot canonical spec).
"""
import os, re, sys, collections
sys.stdout.reconfigure(encoding='utf-8')

KU_FILES = [
    'lib/features/lessons/domain/a1_lesson_definitions.dart',
    'lib/features/lessons/domain/a1_kelime_db.dart',
    'lib/features/lessons/domain/a2_lesson_definitions.dart',
    'lib/features/lessons/domain/a2_kelime_db.dart',
    'lib/features/lessons/domain/b1_lesson_definitions.dart',
    'lib/features/lessons/domain/b1_kelime_db.dart',
    'lib/features/lessons/domain/b2_lesson_definitions.dart',
    'lib/features/lessons/domain/b2_kelime_db.dart',
    'lib/features/lessons/domain/c1_lesson_definitions.dart',
    'lib/features/lessons/domain/c1_kelime_db.dart',
    'lib/features/lessons/domain/c2_lesson_definitions.dart',
    'lib/features/lessons/domain/c2_kelime_db.dart',
    'lib/features/lessons/domain/heritage_dialogues.dart',
    'lib/features/lessons/domain/heritage_c_dialogues.dart',
    'lib/features/lessons/domain/child_a1_kelime_db.dart',
    'lib/features/lessons/domain/child_a1_lesson_definitions.dart',
    'lib/features/lessons/domain/child_a2_kelime_db.dart',
    'lib/features/lessons/domain/child_a2_lesson_definitions.dart',
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
]

# Fields that should contain Kurmancî
KU_FIELDS = ['ku', 'kurmanjPrompt', 'kuPrompt', 'questionKu', 'kurmanji',
             'kurmanjiText', 'audioText', 'kurmanjTitle', 'storyKu',
             'storyText', 'before', 'after', 'kurmanj', 'textKu',
             'correctAnswer', 'titleKu', 'synopsisKu', 'kurmanci']

# Common errors with their corrections
SPELLING_ERRORS = {
    # Wrong: Right
    r'\bkurd[iî]\s+kurmanc[iî]\b': 'kurdiya kurmancî / kurmancî',
    r'\bdibistan[iî]ye\b': 'dibistanê (oblique)',
    # Country names in Kurmanji are valid proper nouns; we don't flag them
    # (rule removed — was generating false positives on legitimate vocab entries).
    r'\binternet\b': 'Înternet (with Î — ödünç ama Bedirxan ayarlamaya tabi)',
    r'\btiv\b': 'tu (typo)',
    r'\bcim cizire\b': 'cizîr (proper noun)',
    r'\bdes pê kirin\b': 'dest pê kirin',
    r'\bdest peki\b': 'dest pêkir',
    r'\bnehêja\b': 'ne-hêja / nehêjayî',
    r'\btim\s+û\s+tim\b': 'her dem (preferred Bedirxan native)',
    r'\bnivîskêr\b': 'nivîskar (Bedirxan canonical)',
    r'\bkîtêb\b': 'kelime başında uzun "î" yok — "kitêb" (kısa i) ya da yerli "pirtûk" tercih edilir.',
}

# CRITICAL: Joined future-tense forms — MUST be separate per Bedirxan-Lescot §185
# These are the most pedagogically important fixes
JOINED_FUTURE = {
    r'\bEzê\b(?!\w)': 'Ez ê (AYRI yazılır — Bedirxan-Lescot §185)',
    r'\bezê\b(?!\w)': 'ez ê (AYRI yazılır — Bedirxan-Lescot §185)',
    r'\bTuê\b(?!\w)': 'Tu yê / Tê (AYRI yazılır — Bedirxan-Lescot §185)',
    r'\btuê\b(?!\w)': 'tu yê / tê (AYRI yazılır)',
    r'\bEmê\b(?!\w)': 'Em ê (AYRI yazılır)',
    r'\bemê\b(?!\w)(?!.*"Emê")': 'em ê (AYRI yazılır — istisna: şarkı adı "Emê")',
    r'\bEwê\b(?!\w)': 'Ew ê (AYRI yazılır — pl. ya da sg. 3.kişi)',
    r'\bewê\b(?!\w)': 'ew ê (AYRI yazılır)',
    r'\bHûnê\b(?!\w)': 'Hûn ê (AYRI yazılır)',
    r'\bhûnê\b(?!\w)': 'hûn ê (AYRI yazılır)',
    r'\btuyê\b(?!\w)': 'tu yê / tê (AYRI yazılır)',
}

# Diacritic missing patterns (heuristic — needs context)
DIACRITIC_HEURISTICS = {
    # 'word' that often appears without proper diacritics
    r'\bsibe\b(?![\w])': 'should likely be "sibê"',
}

# Suspicious patterns (likely Turkish loan calques)
TURKISH_CALQUES = [
    (r'\bki\b(?![\w])', 'In Kurmancî use "ku" not "ki" (Turkish ki ≠ Kurmancî ku)'),
    (r'\bçay\s+kirin\b', '"çay kirin" Turkish calque ("çay yapmak"). Native Kurmancî: "çay çêkirin" / "çay danîn".'),
    (r'\bçay\s+bikim\b', '"çay bikim" → "çayekê çêkim" (Kurmancî tercih)'),
    (r'\blazim\s+(?:nebû|nîne|bû)\b', '"lazim" Arabic-Turkish loan; Kurmancî tercih: "pêwîst nebû / hewce nebû"'),
]

# Past ergativity check — narrowed to UNAMBIGUOUS person-mismatch cases only.
# Past imperfective forms (di- prefix + past stem) overlap morphologically with
# present indicative; we only flag clear person mismatches:
#   - Min (1sg ergative agent) + verb with 1sg present ending (-im)
#   - Te (2sg ergative agent) + verb with 2sg present ending (-î) ← but this overlaps
#     with past imperfective 3sg patient agreement, so we skip
# Result: only "Min ... -im" pattern is unambiguously a violation.
ERGATIVE_VIOLATIONS = [
    (r'\bMin\s+(?:\w+\s+){0,3}\b(?:dixwim|dikim|dibim|dikevim|dilîzim|dibêjim|dibînim|'
     r'dixwînim|dinivîsim|dixwazim|diçim|tême|têm|hatim|naxwazim|nakim)\b',
     'Likely ergative violation: "Min" (oblique) + 1sg present-indicative verb. '
     'Use "Ez" for present, or past stem ("Min nan xwar") for past.'),
]

# Reciprocal pronoun agreement — `hev` (each other) needs plural verb
RECIPROCAL_AGREEMENT = [
    (r'\b(Wan|Em|Hûn|Ew)\s+hev\s+\w+t\b(?!\w)',
     'Reciprocal "hev" with plural subject typically needs plural verb. E.g., "Wan hev dîtin" not "Wan hev dît".'),
]

# Ezafe vs oblique confusion in vocab `ez` field
# Pattern: cins:'mê' followed by ez:'<word>ê' (oblique form, should be -a/-ya)
EZAFE_OBLIQUE_CONFUSION = [
    (r"cins:\s*['\"]mê['\"]\s*,\s*ez:\s*['\"](\w+)ê['\"]",
     'Feminine noun: ez field should hold EZAFE (-a/-ya) not OBLIQUE (-ê). Bedirxan-Lescot §145.'),
    # masculine + ez ending in -a
    (r"cins:\s*['\"]nêr['\"]\s*,\s*ez:\s*['\"](\w+)a['\"](?!\w)",
     'Masculine noun: ez should be ezafe -ê/-yê, not -a/-ya.'),
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
                    items.append((pos, opts_block[pos+1:end]))
                    pos = end + 1
                    break
                else:
                    end += 1
            else:
                break
        else:
            pos += 1
    return items

def lint_file(filepath):
    with open(filepath, encoding='utf-8') as f:
        content = f.read()

    findings = collections.defaultdict(list)

    # ── 1. Field-level checks: extract KU field values ───────────────────
    for key in KU_FIELDS:
        # Single-quoted strings after key:
        pattern = rf"\b{key}:\s*'((?:[^'\\]|\\.)*)'"
        for m in re.finditer(pattern, content):
            val = m.group(1)
            line = content[:m.start()].count('\n') + 1
            # Run all spelling checks
            for bad_re, hint in SPELLING_ERRORS.items():
                if re.search(bad_re, val, re.IGNORECASE):
                    findings['spelling'].append((line, key, val[:80], hint))
            # Joined future tense
            for bad_re, hint in JOINED_FUTURE.items():
                if re.search(bad_re, val):
                    # Skip song titles / proper nouns in cultural content
                    if '"Emê"' in val or '"Emê Gozê"' in val or '"Ezê biçim li ber pencerê' in val:
                        continue
                    findings['joined_future'].append((line, key, val[:80], hint))
            # Diacritic
            for bad_re, hint in DIACRITIC_HEURISTICS.items():
                if re.search(bad_re, val):
                    findings['diacritic'].append((line, key, val[:80], hint))
            # Turkish calque
            for bad_re, hint in TURKISH_CALQUES:
                if re.search(bad_re, val):
                    # Quick filter: is the rest of the text Kurmancî?
                    if any(c in val for c in 'îêûÎÊÛ') or len(val.split()) > 3:
                        findings['turkish_calque'].append((line, key, val[:80], hint))
            # Ergativity violations
            for bad_re, hint in ERGATIVE_VIOLATIONS:
                if re.search(bad_re, val):
                    findings['ergativity'].append((line, key, val[:80], hint))
            # Reciprocal agreement
            for bad_re, hint in RECIPROCAL_AGREEMENT:
                if re.search(bad_re, val):
                    findings['reciprocal'].append((line, key, val[:80], hint))

    # ── 2. Vocab record-level: ezafe/oblique confusion in tuple records ──
    for bad_re, hint in EZAFE_OBLIQUE_CONFUSION:
        for m in re.finditer(bad_re, content):
            line = content[:m.start()].count('\n') + 1
            # Show the surrounding tuple
            ctx_start = max(0, m.start() - 60)
            ctx = content[ctx_start:m.end()+10].replace('\n', ' ')
            findings['ezafe_obl'].append((line, 'cins+ez', ctx[:100], hint))

    return findings

# === RUN ===
print("=" * 70)
print("KURMANCÎ LINGUISTIC LINTER (extended — Round 3)")
print("=" * 70)

total = collections.Counter()
all_findings = {}
for f in KU_FILES:
    if not os.path.exists(f):
        continue
    findings = lint_file(f)
    if any(findings.values()):
        all_findings[f] = findings
        for k, v in findings.items():
            total[k] += len(v)

print(f"\nTotal issues: {dict(total)}")

categories = ['joined_future', 'ergativity', 'reciprocal', 'spelling', 'diacritic',
              'turkish_calque', 'ezafe_obl']
for category in categories:
    if total.get(category, 0) == 0:
        continue
    print(f"\n{'='*70}")
    print(f"{category.upper()} ({total[category]} hits)")
    print('='*70)
    for f, fnd in all_findings.items():
        items = fnd.get(category, [])
        if items:
            print(f"\n{f}:")
            seen = set()
            for line, key, val, hint in items[:15]:
                k = (val, hint)
                if k in seen:
                    continue
                seen.add(k)
                print(f"  L{line:5d}  {key}: {val}")
                print(f"           hint: {hint}")
            if len(items) > 15:
                print(f"  ... +{len(items)-15} more")

# NOTE on ezafe_obl: The project's `ez` field has been historically used to store
# the OBLIQUE form (-ê for both genders) rather than the EZAFE form (m. -ê / f. -a).
# For feminine nouns this is technically inconsistent with the field docstring
# ("ezafe formu") but the data is used as oblique throughout. The 500+ ezafe_obl
# warnings below represent a systematic convention question, not per-line bugs:
# the project must decide to either (a) update the docstring to "oblik formu",
# or (b) migrate all feminine entries to true ezafe -a forms.
# For now, ezafe_obl warnings are reported but do NOT fail the QA gate.
print("\nNOTE: 'ezafe_obl' findings represent a convention-vs-data inconsistency")
print("for feminine nouns. Field docstring says 'ezafe formu' but data stores")
print("oblique (-ê) form. Decision pending — do not auto-fix until project")
print("convention is finalized.\n")

# Exit code: non-zero if any "joined_future" or "ergativity" findings (these are
# hard errors — pedagogical content must respect Bedirxan-Lescot §185 and ergativity).
hard_errors = total.get('joined_future', 0) + total.get('ergativity', 0)
if hard_errors > 0:
    print(f"\n=== {hard_errors} hard errors (joined_future + ergativity) ===")
    sys.exit(1)
print("\n=== Linguistic lint PASSED (ezafe_obl convention warnings non-fatal) ===")
