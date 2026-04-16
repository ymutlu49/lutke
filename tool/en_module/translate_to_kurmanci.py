"""İngilizce → Kurmancî batch çeviri.

Her İngilizce kelime için:
- Kurmancî karşılık (en yaygın 1)
- 2 örnek İngilizce cümle (CEFR A1 seviyesinde basit)
- Aynı cümlelerin Kurmancî çevirisi

Kullanım:
    export ANTHROPIC_API_KEY=sk-ant-...
    python tool/en_module/translate_to_kurmanci.py --level a1

Bağımlılık:
    pip install anthropic
"""
import argparse
import json
import os
import sys
import time
from pathlib import Path

PROJECT = Path(__file__).parent.parent.parent
SEED_DIR = Path(__file__).parent
OUTPUT_DIR = PROJECT / 'lib' / 'features' / 'en_learning' / 'domain'

# Sistem prompt'u — Kurmancî dilbilimci uzman olarak Claude'a rol ver
SYSTEM_PROMPT = """Sen bir Kurmancî (Kuzey Kürtçesi) dilbilimci uzmanısın. Bedir Han / Hawar ortografisini kullanırsın.

Görev: Her İngilizce kelimeyi Kurmancî'ye çevir, A1 seviyesinde 2 basit örnek cümle üret. Cümleler İngilizce öğrenen Kurmancî anadilli için olacak.

Cevabı SADECE şu JSON formatında ver, açıklama ekleme:
{
  "ku": "Kurmancî karşılık (tek kelime, en yaygın)",
  "notKu": "Kurmancî dilbilgisi notu (çok kısa: cins, çekim, telaffuz ipucu)",
  "her": ["Simple English sentence 1.", "Simple English sentence 2."],
  "herKu": ["Cümlenin Kurmancî çevirisi 1.", "Cümlenin Kurmancî çevirisi 2."]
}

Kurallar:
- Kurmancî çeviri Bedir Han standardına uygun (ê, î, û, ç, ş, q, x doğru kullan)
- Heritage cümleler A1 İngilizce: çok basit, present tense, max 6 kelime
- Heritage cümleleri illa kelimeyi içermeli
- "ku" alanı tek kelime olmalı (mümkünse), virgülle 2'den fazla varyant verme
- notKu max 60 karakter, sade
"""

USER_TEMPLATE = """Kelime: "{en}"
Telaffuz: {ipa}
Tür: {pos}
Kategori: {kat}
{emoji_line}"""


def call_claude(client, en, ipa, pos, kat, emoji):
    """Tek kelime için Claude API çağrısı."""
    emoji_line = f'Görsel ipucu: {emoji}' if emoji else ''
    msg = client.messages.create(
        model='claude-sonnet-4-5',
        max_tokens=400,
        system=SYSTEM_PROMPT,
        messages=[{
            'role': 'user',
            'content': USER_TEMPLATE.format(
                en=en, ipa=ipa, pos=pos, kat=kat, emoji_line=emoji_line,
            )
        }],
    )
    text = msg.content[0].text.strip()
    # JSON dışı blok varsa temizle
    if text.startswith('```'):
        text = text.split('```')[1].lstrip('json').strip()
    return json.loads(text)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--level', default='a1')
    parser.add_argument('--limit', type=int, default=0)
    parser.add_argument('--start', type=int, default=0)
    args = parser.parse_args()

    try:
        from anthropic import Anthropic
    except ImportError:
        print("ERROR: pip install anthropic")
        sys.exit(1)

    if not os.environ.get('ANTHROPIC_API_KEY'):
        print("ERROR: ANTHROPIC_API_KEY env değişkeni yok.")
        sys.exit(1)

    client = Anthropic()

    # Seed dosyasını yükle
    seed_module = f'oxford_{args.level}_seed'
    sys.path.insert(0, str(SEED_DIR))
    mod = __import__(seed_module)
    seed_var = f'{args.level.upper()}_SEED'
    seed = getattr(mod, seed_var)

    targets = seed[args.start:]
    if args.limit > 0:
        targets = targets[:args.limit]

    print(f'Hedef: {len(targets)} kelime, level={args.level}, start={args.start}')

    output_file = OUTPUT_DIR / f'en_{args.level}_translated.json'
    existing = {}
    if output_file.exists():
        existing = json.loads(output_file.read_text(encoding='utf-8'))
    print(f'Mevcut çeviri: {len(existing)} kayıt')

    fail = 0
    for i, (en, ipa, pos, kat, emoji) in enumerate(targets, 1):
        key = en.lower()
        if key in existing:
            print(f'[{i}/{len(targets)}] SKIP {en}')
            continue
        try:
            result = call_claude(client, en, ipa, pos, kat, emoji)
            existing[key] = {
                'en': en, 'ipa': ipa, 'pos': pos, 'kat': kat,
                'emoji': emoji,
                **result,
            }
            print(f'[{i}/{len(targets)}] {en} → {result.get("ku", "?")}')
        except Exception as e:
            fail += 1
            print(f'[{i}/{len(targets)}] FAIL {en}: {type(e).__name__}: {str(e)[:80]}')
            time.sleep(2)
            continue
        # Her 10'da bir kaydet
        if i % 10 == 0:
            output_file.write_text(
                json.dumps(existing, ensure_ascii=False, indent=2),
                encoding='utf-8',
            )
            print(f'  → kaydedildi ({len(existing)})')

    output_file.write_text(
        json.dumps(existing, ensure_ascii=False, indent=2),
        encoding='utf-8',
    )
    print(f'\n== BİTTİ ==')
    print(f'  Çevrilen: {len(existing)}')
    print(f'  Hatalı: {fail}')
    print(f'  Output: {output_file}')


if __name__ == '__main__':
    main()
