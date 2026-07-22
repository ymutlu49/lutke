"""Kurmancî kapsamlı denetim — SADECE Kurmancî olması gereken alanlarda tarama."""
import os
import re
import sys
import io

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")

# Türkçe-özel karakterler (Kurmancî'de yok)
TR_CHARS = set("öğüıİÖĞÜ")

# Türkçe kelime göstergeleri (ku: alanı bu ibareler içermemeli)
TR_WORDS = [
    r"\bne zaman\b", r"\bdoğru mu\b", r"\bne anlama gelir\b",
    r"\bnedir\?", r"\bnasıl\b", r"\bhangi\b", r"\bhangisi\b",
    r"\bçünkü\b", r"\bfakat\b", r"\byani\b", r"\bama\b",
    r"\bgerçek\b", r"\bbirkaç\b", r"\böğren\b", r"\böyle\b",
]


def scan_db_files():
    """Kelime DB'leri ve lesson definitions'ta Kurmancî alanları tarar."""
    issues = {}
    base = os.path.join("lib", "features", "lessons", "domain")
    child_base = os.path.join("lib", "features", "child_mode", "domain")

    for folder in [base, child_base]:
        if not os.path.exists(folder):
            continue
        for fn in os.listdir(folder):
            if not fn.endswith(".dart"):
                continue
            path = os.path.join(folder, fn).replace(os.sep, "/")
            with open(path, "r", encoding="utf-8") as f:
                content = f.read()

            # ku:, her:, gen:, opts: alanları Kurmancî olmalı
            for field_pat in [
                (r"ku:'([^']*)'", "ku"),
                (r"her:\[([^\]]*)\]", "her"),
                (r"gen:\[([^\]]*)\]", "gen"),
                (r"opts:\[([^\]]*)\]", "opts"),
            ]:
                pat, fld = field_pat
                for m in re.finditer(pat, content):
                    txt = m.group(1)
                    if any(c in TR_CHARS for c in txt):
                        ln = content[:m.start()].count("\n") + 1
                        issues.setdefault(path, []).append(
                            (ln, fld, txt[:120])
                        )
    return issues


def scan_ui_files():
    """UI ekranlarında Kurmancî olması gereken string'lerde TR taraması.

    SADECE: widget string'lerinde Türkçe-özel karakter taraması.
    Atla: tr: field, en: field, yorum, Türkçe-pozisyonlu hatch ('_showTurkish ? ... : ...)
    """
    issues = {}
    ui_dirs = [
        "features/lessons/presentation",
        "features/exercises/presentation",
        "features/child_mode/presentation",
        "features/profile",
        "features/gamification",
        "features/onboarding",
        "features/cultural_content",
        "features/grammar",
        "shared/widgets",
    ]
    for root in ui_dirs:
        full = os.path.join("lib", root)
        if not os.path.exists(full):
            continue
        for dp, _, fns in os.walk(full):
            for fn in fns:
                if not fn.endswith(".dart"):
                    continue
                path = os.path.join(dp, fn).replace(os.sep, "/")
                with open(path, "r", encoding="utf-8") as f:
                    lines = f.readlines()
                for i, line in enumerate(lines, 1):
                    stripped = line.strip()
                    if stripped.startswith("//") or stripped.startswith("*") \
                       or stripped.startswith("/*"):
                        continue
                    # tr: veya motivationalTr = ... gibi satırları atla
                    if re.search(r"^\s*(tr\s*:|.*Tr\s*=|_showTurkish\s*\?)", line):
                        continue
                    # İçinde ku: ile başlayan Dart struct literal varsa zaten taranıyor
                    if "tr:'" in line or "tr: '" in line:
                        continue
                    # Widget metin alanları
                    for m in re.finditer(
                        r"(?:Text|label|title|hintText|tooltip|subtitle|Tooltip)"
                        r"\s*:?\s*[\(]?\s*[\'\"]"
                        r"([^\'\"]{4,250})[\'\"]",
                        line,
                    ):
                        txt = m.group(1)
                        if any(c in TR_CHARS for c in txt):
                            issues.setdefault(path, []).append((i, txt[:120]))
    return issues


def main():
    print("━━━ DB/LESSON ALANLARI ━━━")
    db_issues = scan_db_files()
    db_total = sum(len(v) for v in db_issues.values())
    print(f"TOPLAM: {db_total} sızıntı · {len(db_issues)} dosya\n")
    top = sorted(db_issues.items(), key=lambda x: -len(x[1]))[:15]
    for path, items in top:
        print(f"{path} ({len(items)})")
        for ln, fld, txt in items[:3]:
            print(f"  L{ln} {fld}: {txt}")

    print("\n━━━ UI EKRAN'LARI ━━━")
    ui_issues = scan_ui_files()
    ui_total = sum(len(v) for v in ui_issues.values())
    print(f"TOPLAM: {ui_total} sızıntı · {len(ui_issues)} dosya\n")
    top = sorted(ui_issues.items(), key=lambda x: -len(x[1]))[:15]
    for path, items in top:
        print(f"{path} ({len(items)})")
        for ln, txt in items[:3]:
            print(f"  L{ln}: {txt}")


if __name__ == "__main__":
    main()
