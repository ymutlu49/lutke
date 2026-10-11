# -*- coding: utf-8 -*-
"""LÛTKE içeriğini Dart kaynağından okur — ölçüm ve dil denetimi için ortak yükleyici.

İki görünüm vardır ve aynı değildir:

  uygulama  Ekranların kullandığı listeler (home_screen.dart `_getWordsForLevel`):
            kA1TamListe, kA2TamListe, kB1All, kB2All, kC1All, kC2All.
  web       `tool/export_content.dart`ın yazdığı `website/data/content.json`.
            B1 için `kB1Temam` kullanır; bu yüzden B1'de uygulamadan az kelime
            taşır.

Kelimeler Dart dosyalarından düzenli ifadeyle ayrıştırılır (liste tanımları
ve `...yayma` ifadeleri çözülür). Ders, diyalog, kültür ve dilbilgisi
içeriği `content.json`dan gelir; o dosya Dart kaynağından eskiyse uyarılır.

    python tools/qa/icerik.py            # sayım
    python tools/qa/icerik.py --sinama   # ayrıştırıcıyı content.json ile karşılaştır
"""

import json
import re
import sys
import unicodedata
from pathlib import Path

PROJE = Path(__file__).resolve().parents[2]
DOM = PROJE / "lib" / "features" / "lessons" / "domain"
ICERIK_JSON = PROJE / "website" / "data" / "content.json"

DUZEYLER = ["a1", "a2", "b1", "b2", "c1", "c2"]
# home_screen.dart::_getWordsForLevel ve lesson_repository.dart::_wordsForLevel
UYGULAMA_LISTESI = {"a1": "kA1TamListe", "a2": "kA2TamListe", "b1": "kB1All",
                    "b2": "kB2All", "c1": "kC1All", "c2": "kC2All",
                    "child_a1": "kChildA1Kelimeler", "child_a2": "kChildA2Kelimeler"}

_STR = r"""(?:'((?:[^'\\]|\\.)*)'|"((?:[^"\\]|\\.)*)")"""
_TANIM = re.compile(r"^(?:final|const)\s+(k\w+)\s*=\s*\[", re.M)
_KAYIT = re.compile(r"\(\s*id:\s*" + _STR + r"\s*,\s*ku:\s*" + _STR, re.S)
_YAYMA = re.compile(r"\.\.\.(k\w+)")
_HERSTR = re.compile(_STR)


def nfc(s: str) -> str:
    return unicodedata.normalize("NFC", s)


def _coz(m, i: int):
    """Tek ya da çift tırnaklı Dart dizgisinin içeriği (kaçışları açılmış)."""
    v = m.group(i) if m.group(i) is not None else m.group(i + 1)
    if v is None:
        return None
    return nfc(re.sub(r"\\(.)", lambda k: {"n": "\n", "t": "\t"}.get(k.group(1), k.group(1)), v))


def _alan(govde: str, ad: str):
    m = re.search(r"\b" + ad + r":\s*" + _STR, govde)
    return _coz(m, 1) if m else None


def _liste(govde: str, ad: str) -> list:
    m = re.search(r"\b" + ad + r":\s*\[(.*?)\]", govde, re.S)
    return [_coz(x, 1) for x in _HERSTR.finditer(m.group(1))] if m else []


def _dosya_listeleri(metin: str, dosya: str) -> dict:
    """ad -> [('kayit', {...}) | ('yayma', ad), …]  (metindeki sırayla)"""
    tanimlar = list(_TANIM.finditer(metin))
    listeler = {}
    for i, t in enumerate(tanimlar):
        son = tanimlar[i + 1].start() if i + 1 < len(tanimlar) else len(metin)
        parca = metin[t.end():son]
        ogeler = []
        kayitlar = list(_KAYIT.finditer(parca))
        for j, k in enumerate(kayitlar):
            govde = parca[k.end():kayitlar[j + 1].start() if j + 1 < len(kayitlar) else len(parca)]
            ez = re.search(r"\bez:\s*(null|" + _STR + ")", govde)
            zor = re.search(r"\bzor:\s*([\d.]+)", govde)
            ogeler.append((k.start(), "kayit", {
                "id": _coz(k, 1), "ku": _coz(k, 3),
                "tr": _alan(govde, "tr"), "en": _alan(govde, "en"),
                "cins": _alan(govde, "cins"),
                "ez": None if (not ez or ez.group(1) == "null") else _coz(ez, 2),
                "kat": _alan(govde, "kat"),
                "zor": float(zor.group(1)) if zor else None,
                "not": _alan(govde, "not"),
                "her": _liste(govde, "her"), "gen": _liste(govde, "gen"),
                "liste": t.group(1), "dosya": dosya,
                "satir": metin.count("\n", 0, t.end() + k.start()) + 1,
            }))
        # yayma ifadeleri yalnız kayıtların dışında aranır (not: alanlarında "..." geçebilir)
        dis = parca if not kayitlar else parca[:kayitlar[0].start()]
        for y in _YAYMA.finditer(dis):
            ogeler.append((y.start(), "yayma", y.group(1)))
        listeler[t.group(1)] = [(tip, v) for _, tip, v in sorted(ogeler, key=lambda o: o[0])]
    return listeler


_onbellek = {}


def tum_listeler() -> dict:
    if "l" not in _onbellek:
        hepsi = {}
        for p in sorted(DOM.glob("*_kelime_db.dart")):
            hepsi.update(_dosya_listeleri(p.read_text(encoding="utf-8"), p.name))
        _onbellek["l"] = hepsi
    return _onbellek["l"]


def cozumle(ad: str, _yol=()) -> list:
    """Bir listeyi yaymalarıyla birlikte düz kayıt listesine çevirir."""
    listeler = tum_listeler()
    if ad not in listeler or ad in _yol:
        return []
    cikti = []
    for tip, v in listeler[ad]:
        cikti += [v] if tip == "kayit" else cozumle(v, _yol + (ad,))
    return cikti


def kelimeler(cocuk: bool = False) -> dict:
    """düzey -> uygulamanın kullandığı kayıtlar (yinelenen kimlikler dahil)."""
    duzeyler = DUZEYLER + (["child_a1", "child_a2"] if cocuk else [])
    return {d: cozumle(UYGULAMA_LISTESI[d]) for d in duzeyler}


def web() -> dict:
    """content.json; Dart kaynağından eskiyse `_eski` anahtarı True olur."""
    if "w" not in _onbellek:
        d = json.loads(ICERIK_JSON.read_text(encoding="utf-8"))
        json_t = ICERIK_JSON.stat().st_mtime
        d["_eski"] = any(p.stat().st_mtime > json_t for p in DOM.glob("*.dart"))
        _onbellek["w"] = d
    return _onbellek["w"]


# ── Kelime dışındaki Kurmancî metinler ───────────────────────────────────────

# (dosya, [Kurmancî alanlar]) — content.json'a girmeyen veritabanları
EK_DOSYALAR = [
    ("lib/features/exercises/domain/listening_exercise_db.dart", ["audioText", "question"]),
    ("lib/features/exercises/domain/ku_speaking_db.dart", ["textKu"]),
    ("lib/features/exercises/domain/ku_writing_db.dart", ["correctAnswer"]),
    ("lib/features/cultural_content/domain/character_stories_db.dart",
     ["textKu", "questionKu", "titleKu", "synopsisKu"]),
    ("lib/features/lessons/domain/child_a1_lesson_definitions.dart", ["titleKu", "sentenceWithBlank"]),
    ("lib/features/lessons/domain/child_a2_lesson_definitions.dart", ["titleKu", "sentenceWithBlank"]),
    ("lib/features/onboarding/placement_test_screen.dart", ["prompt"]),
]


def ek_metinler() -> list:
    """[(grup, kimlik, alan, metin)] — Dart'tan alan adıyla çekilen dizgiler."""
    cikti = []
    for yol, alanlar in EK_DOSYALAR:
        p = PROJE / yol
        if not p.exists():
            continue
        metin = p.read_text(encoding="utf-8")
        if "placement_test" in yol:      # dosyada İngilizce soru seti de var
            bas = metin.find("_kuQuestions")
            son = metin.find("_enQuestions", bas + 1) if bas >= 0 else -1
            metin_k = metin[bas:son] if bas >= 0 and son > bas else metin[bas:] if bas >= 0 else ""
            kayma = bas if bas >= 0 else 0
        else:
            metin_k, kayma = metin, 0
        for alan in alanlar:
            for m in re.finditer(r"\b" + alan + r":\s*" + _STR, metin_k):
                # Yazma alıştırmasında `translate_tr` türünün yanıtı Türkçedir.
                if alan == "correctAnswer" and "'translate_tr'" in metin_k[max(0, m.start() - 200):m.start()]:
                    continue
                satir = metin.count("\n", 0, kayma + m.start()) + 1
                cikti.append((p.stem, f"{p.name}:{satir}", alan, _coz(m, 1)))
    return cikti


def tum_metinler(cocuk: bool = True) -> list:
    """Denetlenecek bütün Kurmancî metinler: [(grup, kimlik, alan, metin, karisik)].

    `karisik`: metin Türkçe açıklama da içerir (dilbilgisi kuralları gibi);
    denetimden önce Türkçe parçalar ayıklanır.
    """
    c = []
    for d, kayitlar in kelimeler(cocuk=cocuk).items():
        gorulen = set()
        for k in kayitlar:
            if k["id"] in gorulen:
                continue
            gorulen.add(k["id"])
            c.append((f"peyv_{d}", k["id"], "ku", k["ku"], False))
            for i, s in enumerate(k["her"]):
                c.append((f"peyv_{d}", k["id"], f"her{i + 1}", s, False))
            for i, s in enumerate(k["gen"]):
                c.append((f"peyv_{d}", k["id"], f"gen{i + 1}", s, False))
    w = web()
    for d, dersler in w["lessons"].items():
        for ders in dersler:
            c.append((f"ders_{d}", ders["id"], "kurmanjTitle", ders.get("kurmanjTitle") or "", False))
            for e in ders.get("exercises") or []:
                c.append((f"ders_{d}", e["id"], "kurmanjPrompt", e.get("kurmanjPrompt") or "", True))
    for g in w["dialogues"]:
        for i, ln in enumerate(g["lines"]):
            c.append(("diyalog", f"{g['id']}:{i + 1}", "kurmanci", ln.get("kurmanci") or "", False))
    for grup, ogeler in w["cand"].items():
        for o in ogeler:
            c.append((f"cand_{grup}", o["id"], "kurmanjTitle", o.get("kurmanjTitle") or "", False))
            c.append((f"cand_{grup}", o["id"], "kurmanjContent", o.get("kurmanjContent") or "", False))
    for i, g in enumerate(w["grammar"]):
        for j, r in enumerate(g.get("rules") or []):
            c.append(("reziman", f"konu{i + 1}:{j + 1}", "rules", r, True))
    for p in w["proverbs"]:
        c.append(("gotin", f"{p['letter']}.{p['num']}", "ku", p["ku"], False))
    for grup, kimlik, alan, metin in ek_metinler():
        c.append((grup, kimlik, alan, metin or "", alan in ("question", "prompt", "sentenceWithBlank")))
    return [x for x in c if x[3] and x[3].strip()]


def _sinama() -> int:
    """Ayrıştırıcıyı dışa aktarımla karşılaştırır (Dart'ın kendi gördüğü veri)."""
    w = web()
    hata = 0
    alt = {"b1": "kB1Temam"}          # dışa aktarımın B1 için kullandığı liste
    for d in DUZEYLER:
        bizim = {k["id"]: k for k in cozumle(alt.get(d, UYGULAMA_LISTESI[d]))}
        if d == "c2":                  # dışa aktarım kC2_Cegerxwin'i ayrıca ekler
            bizim.update({k["id"]: k for k in cozumle("kC2_Cegerxwin")})
        onlar = {x["id"]: x for x in w["words"][d]}
        eksik, fazla = set(onlar) - set(bizim), set(bizim) - set(onlar)
        fark = [(i, a) for i in set(onlar) & set(bizim)
                for a in ("ku", "cins", "ez", "kat", "her", "gen")
                if (bizim[i][a] or None) != (nfc_derin(onlar[i].get(a)) or None)]
        durum = "OK" if not (eksik or fazla or fark) else "FARK"
        print(f"  {d}: ayrıştırılan {len(bizim)} · dışa aktarım {len(onlar)} · "
              f"eksik {len(eksik)} · fazla {len(fazla)} · alan farkı {len(fark)}  {durum}")
        for i, a in fark[:3]:
            print(f"      {i}.{a}: {bizim[i][a]!r} != {onlar[i].get(a)!r}")
        hata += bool(eksik or fazla or fark)
    return hata


def nfc_derin(v):
    if isinstance(v, str):
        return nfc(v)
    if isinstance(v, list):
        return [nfc_derin(x) for x in v]
    return v


def main() -> None:
    if "--sinama" in sys.argv:
        print("Ayrıştırıcı sınaması (content.json ile):")
        sys.exit(1 if _sinama() else 0)
    if web()["_eski"]:
        print("UYARI: content.json Dart kaynağından eski — `dart run tool/export_content.dart`")
    k = kelimeler(cocuk=True)
    for d, kayit in k.items():
        print(f"  {d:9} kayıt {len(kayit):5} · benzersiz kimlik {len({x['id'] for x in kayit}):5} "
              f"· benzersiz madde {len({x['ku'].lower() for x in kayit}):5}")
    print(f"  denetlenecek metin: {len(tum_metinler()):,}")


if __name__ == "__main__":
    main()
