# -*- coding: utf-8 -*-
"""İçerik düzeltmelerini bir tablodan uygular, günlüğe yazar, sesi kopanları listeler.

Neden araç: bir düzeltme tek alanla bitmez (cinsiyet -> `cins`, `ez`, not, örnek
cümleler) ve hazır ses metnin kendisiyle eşleşir; cümlede tek harf değişince
ses kopar. Elle yapılan düzeltme iz bırakmaz. Bu araç her değişikliği
gerekçesiyle kaydeder.

Girdi: sekmeyle ayrılmış tablo, sütunlar

    kimlik   kelime kimliği (a1_750) ya da `@lib/.../dosya.dart` (dosyada ham arama)
    alan     cins | ez | ku | tr | en | kat | not | her | gen   (`@dosya` için boş)
    eski     alanın içinde aranacak metin (tam eşleşme)
    yeni     yerine konacak metin
    kural    cins | izafe | anlam | yazim | norm | ergatif | atif | ...
    gerekce  kısa gerekçe ve kanıt

Kullanım:
    python tools/qa/duzelt.py docs/duzeltme/girdi/<tablo>.tsv            # kuru çalıştırma
    python tools/qa/duzelt.py docs/duzeltme/girdi/<tablo>.tsv --uygula

Kuru çalıştırma hiçbir şey yazmaz; bulunamayan her satırı gösterir ve 1 ile çıkar.
`--uygula` yalnız bütün satırlar bulunduysa (ya da zaten uygulanmışsa) yazar.

Çıktılar:
    docs/duzeltme/duzeltme.tsv     birikimli günlük
    docs/olcum/ses_bekleyen.tsv    hazır sesi olan ama metni değiştiği için sesi kopan cümleler
    Kurmanci/Ziman/xeleti.tsv      ortak hata kaydı (varsa; `gotar` sütunu `lutke:<kimlik>`)

Uyguladıktan sonra: `dart run tool/export_content.dart`, `icerik.py --sinama`,
`ziman_denetim.py --kapi`, `olcum.py`, `flutter test`.
"""

import csv
import datetime
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import icerik  # noqa: E402

PROJE = icerik.PROJE
KURMANCI = PROJE.parents[2]
DOMAIN = PROJE / "lib" / "features" / "lessons" / "domain"
GUNLUK = PROJE / "docs" / "duzeltme" / "duzeltme.tsv"
SES_BEKLEYEN = PROJE / "docs" / "olcum" / "ses_bekleyen.tsv"
XELETI = KURMANCI / "Ziman" / "xeleti.tsv"
ALANLAR = ["id", "ku", "tr", "en", "cins", "ez", "kat", "zor", "not", "her", "gen"]
SUTUN = ["kimlik", "alan", "eski", "yeni", "kural", "gerekce"]
BUGUN = datetime.date.today().isoformat()


def oku(yol: Path) -> str:
    # Satır sonları korunur (bazı dosyalar CRLF): newline="" çeviri yapmaz.
    with yol.open(encoding="utf-8", newline="") as f:
        return f.read()


def yaz(yol: Path, metin: str) -> None:
    with yol.open("w", encoding="utf-8", newline="") as f:
        f.write(metin)


def kayit_araligi(metin: str, kimlik: str):
    m = re.search(r"\(\s*id:\s*(['\"])" + re.escape(kimlik) + r"\1", metin)
    if not m:
        return None
    n = re.search(r"\(\s*id:\s*['\"]", metin[m.end():])
    return m.start(), (m.end() + n.start() if n else len(metin))


def alan_araligi(kayit: str, alan: str):
    b = re.search(r"(?:^|[\s,(])" + alan + r":", kayit)
    if not b:
        return None
    bas = b.end()
    son = len(kayit)
    for a in ALANLAR[ALANLAR.index(alan) + 1:]:
        n = re.search(r"[\s,]" + a + r":", kayit[bas:])
        if n:
            son = bas + n.start()
            break
    return bas, son


def bicimler(s: str) -> list:
    """Düz metnin Dart yazımları: olduğu gibi, \\' kaçışlı, \\\" kaçışlı."""
    return [s, s.replace("'", "\\'"), s.replace('"', '\\"')]


def degistir(parca: str, eski: str, yeni: str):
    """(yeni parça, durum). durum: 'ok' | 'zaten' | 'yok'"""
    for e, y in zip(bicimler(eski), bicimler(yeni)):
        if e and e in parca:
            return parca.replace(e, y), "ok"
    # `yeni` boşsa (silme) "zaten uygulanmış" ayırt edilemez; bulunamadı sayılır.
    if any(y and y in parca for y in bicimler(yeni)):
        return parca, "zaten"
    return parca, "yok"


def ses_anahtarlari() -> set:
    m = (PROJE / "lib/core/services/tts_asset_manifest.dart").read_text(encoding="utf-8")
    return {icerik._coz(x, 1) for x in re.finditer(r"^\s*" + icerik._STR + r"\s*:\s*'assets/", m, re.M)}


def ses_var(s: str, E: set) -> bool:
    """`tts_asset_manifest.dart::lookup` + `tts_service.dart` deneme sırasının eşi (bkz. olcum.py::ses)."""
    a = icerik.nfc(" ".join(s.split())).lower()
    b = re.sub(r"[.,!?]+$", "", a).strip()
    tam = re.sub(r"^[\W_]+|[\W_]+$", "", b)
    return any(x in E for x in (a, b, tam, a + ".", b.replace("’", "'"), tam.replace("’", "'")))


def metinler(kel: dict) -> dict:
    return {k["id"]: (k["ku"], tuple(k["her"]), tuple(k["gen"])) for d in kel for k in kel[d]}


def ekle(yol: Path, baslik: list, satirlar: list) -> None:
    yol.parent.mkdir(parents=True, exist_ok=True)
    yeni = not yol.exists()
    with yol.open("a", encoding="utf-8", newline="") as f:
        y = csv.writer(f, delimiter="\t", lineterminator="\n")
        if yeni:
            y.writerow(baslik)
        y.writerows(satirlar)


def main() -> int:
    arg = [a for a in sys.argv[1:] if not a.startswith("--")]
    if not arg:
        print(__doc__)
        return 2
    uygula = "--uygula" in sys.argv
    with open(arg[0], encoding="utf-8", newline="") as f:
        satirlar = [r for r in csv.DictReader(f, delimiter="\t") if (r.get("kimlik") or "").strip()
                    and not r["kimlik"].startswith("#")]

    dosyalar = {p: oku(p) for p in sorted(DOMAIN.glob("*_kelime_db.dart"))}
    once = metinler(icerik.kelimeler(cocuk=True))
    say = {"ok": 0, "zaten": 0, "yok": 0}
    eksik, gunluk = [], []

    for r in satirlar:
        kimlik, alan, eski, yeni = r["kimlik"].strip(), (r.get("alan") or "").strip(), r["eski"], r["yeni"]
        durum = "yok"
        if kimlik.startswith("@"):
            p = PROJE / kimlik[1:]
            if p.exists():
                if p not in dosyalar:
                    dosyalar[p] = oku(p)
                dosyalar[p], durum = degistir(dosyalar[p], eski, yeni)
        else:
            for p, metin in dosyalar.items():
                ar = kayit_araligi(metin, kimlik)
                if not ar:
                    continue
                kayit = metin[ar[0]:ar[1]]
                al = alan_araligi(kayit, alan) if alan else (0, len(kayit))
                if al:
                    parca, durum = degistir(kayit[al[0]:al[1]], eski, yeni)
                    kayit = kayit[:al[0]] + parca + kayit[al[1]:]
                    dosyalar[p] = metin[:ar[0]] + kayit + metin[ar[1]:]
                break
        say[durum] += 1
        if durum == "yok":
            eksik.append(r)
        elif durum == "ok":
            gunluk.append([BUGUN, kimlik, alan, eski, yeni, r.get("kural", ""), r.get("gerekce", "")])

    print(f"{len(satirlar)} satır: uygulanacak {say['ok']}, zaten uygulanmış {say['zaten']}, bulunamayan {say['yok']}")
    for r in eksik:
        print(f"  BULUNAMADI  {r['kimlik']}  {r.get('alan', '')}  «{r['eski']}»")
    if eksik:
        print("Bulunamayan satır var; hiçbir şey yazılmadı.")
        return 1
    if not uygula:
        print("Kuru çalıştırma: hiçbir şey yazılmadı. Uygulamak için --uygula.")
        return 0

    asil = {p: oku(p) for p in dosyalar}
    for p, metin in dosyalar.items():
        if metin != asil[p]:
            yaz(p, metin)
    ekle(GUNLUK, ["tarih", *SUTUN], gunluk)
    if XELETI.parent.exists():
        ekle(XELETI, ["dîrok", "gotar", "şaş", "rast", "kural", "not"],
             [[t, "lutke:" + k, e, y, kural, g] for t, k, _, e, y, kural, g in gunluk])

    # Sesi kopan cümleler: önce hazır sesi vardı, yeni metnin yok.
    icerik._onbellek.clear()
    sonra = metinler(icerik.kelimeler(cocuk=True))
    E = ses_anahtarlari()
    kopan = []
    for kimlik, (ku0, her0, gen0) in once.items():
        ku1, her1, gen1 = sonra.get(kimlik, (ku0, her0, gen0))
        ciftler = [("ku", ku0, ku1)] + [("her", a, b) for a, b in zip(her0, her1)] + [("gen", a, b) for a, b in zip(gen0, gen1)]
        for alan, a, b in ciftler:
            if a != b and ses_var(a, E) and not ses_var(b, E):
                kopan.append([BUGUN, kimlik, alan, a, b])
    ekle(SES_BEKLEYEN, ["tarih", "kimlik", "alan", "eski_metin", "yeni_metin"], kopan)
    print(f"Yazıldı. Günlük: {len(gunluk)} satır -> {GUNLUK.relative_to(PROJE)}; sesi kopan {len(kopan)} metin -> {SES_BEKLEYEN.relative_to(PROJE)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
