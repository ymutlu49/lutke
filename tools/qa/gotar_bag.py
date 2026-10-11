# -*- coding: utf-8 -*-
"""Gotar köprüsü: portalda yayımlanmış makalelerin bağlantı listesini üretir.

İyileştirme planı Faz 7. Kaynak `Kurmanci/jimaro-portal/src/content/gotar/`
(oraya yalnız `amade` ve `weşandî` makaleler gider; elle düzenlenmez).
LÛTKE'nin okuma listesi B2–C2 düzeylerinde bu makalelere bağlantı verir.

    python tools/qa/gotar_bag.py        # gotar_baglanti_db.dart yaz

Yeni makale yayımlanınca yeniden çalıştırılır.
"""

import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import icerik  # noqa: E402

PROJE = icerik.PROJE
GOTAR = PROJE.parents[2] / "jimaro-portal" / "src" / "content" / "gotar"
DART = PROJE / "lib" / "features" / "lessons" / "domain" / "gotar_baglanti_db.dart"
BINGEH = "https://gavbigav.com/gotar/"


def q(s: str) -> str:
    return "'" + s.replace(chr(92), chr(92) * 2).replace("'", chr(92) + "'") + "'"


def main() -> None:
    if not GOTAR.exists():
        print("Portal içeriği bulunamadı.")
        return
    makaleler = []
    for p in sorted(GOTAR.glob("*.mdx")):
        t = icerik.nfc(p.read_text(encoding="utf-8"))
        on = t.split("---")[1] if t.startswith("---") else ""
        m = re.search(r"^sernav:\s*[\"']?(.+?)[\"']?\s*$", on, re.M)
        if m:
            makaleler.append((m.group(1).strip(), p.stem))
    d = ["// LÛTKE — Gotar bağlantıları (OTOMATİK ÜRETİLMİŞTİR)",
         "//",
         "// `python tools/qa/gotar_bag.py` üzerine yazar; elle düzenleme.",
         "// Kaynak: jimaro-portal/src/content/gotar (yayımlanmış makaleler).",
         "",
         "const String kGotarBingeh = " + q(BINGEH) + ";",
         "",
         "/// (başlık, bağlantı)",
         "const List<(String, String)> kGotarBaglantilari = ["]
    d += [f"  ({q(ad)}, {q(BINGEH + slug + '/')})," for ad, slug in makaleler]
    d += ["];", ""]
    DART.write_text(chr(10).join(d), encoding="utf-8", newline=chr(10))
    print(f"{len(makaleler)} makale -> {DART.relative_to(PROJE)}")


if __name__ == "__main__":
    main()
