"""A2 lesson definitions dosyasındaki Türkçe quiz seçeneklerini Kurmancî'ye çevirir."""
import os
import re
import sys
import io

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")

# Türkçe → Kurmancî çeviri haritası (A2 seviyesine uygun)
TRANSLATIONS = {
    # Gramer terimleri
    "Sadece kök kullanılır": "Tenê rayek tê bikar anîn",
    "di- + kök + kişi eki": "di- + rayek + paşgira kes",
    "Mastar + kişi eki": "Raveker + paşgira kes",
    "Kök + -a/-e": "Rayek + -a/-e",
    "ne- öneki eklenir": "Pêşgira ne- tê zêde kirin",
    "na- öneki eklenir": "Pêşgira na- tê zêde kirin",
    'Cümle sonuna "na" gelir': 'Li dawiya hevokê "na" tê',
    "Fiil değişmez": "Lêker naguhere",
    "Mastar + ê": "Raveker + ê",
    "dê + şimdiki zaman formu": "dê + forma dema niha",
    "Kök + -ê": "Rayek + -ê",
    "Sadece dê": "Tenê dê",
    # Zaman formları
    "Yiyeceğim": "Ez ê bixwim",
    "Yemiyorum": "Ez naxwim",
    "Yemedim": "Min nexwar",
    "Yemeyeceğim": "Ez ê nexwim",
    # Yerler
    "Hastane": "Nexweşxane",
    "Pazar/Çarşı": "Bazar/Sûk",
    "Okul": "Dibistan",
    "Park": "Park",
    # Amaçlar
    "Alışveriş için": "Ji bo kirrînê",
    "Okul için": "Ji bo dibistanê",
    "Hastaya gidilir": "Ji bo nexweş tê çûn",
    "Park için": "Ji bo parkê",
    # Pozisyon
    "Masanın altında": "Li bin mêzê",
    "Masanın yanında": "Li tenişta mêzê",
    "Masanın üstünde": "Li ser mêzê",
    "Masanın arkasında": "Li pişt mêzê",
    "Sandalyenin üstünde": "Li ser kursiyê",
    "Sandalyenin altında": "Li bin kursiyê",
    "Sandalyenin önünde": "Li pêşberî kursiyê",
    "Sandalyede": "Li kursiyê",
    "Ev ve pazarın üstünde": "Li ser mal û bazarê",
    "Ev ile pazar arasında": "Di navbera mal û bazarê de",
    "Evden pazara kadar": "Ji malê heta bazarê",
    "Evden sonra pazar": "Piştî malê, bazar",
    # Ulaşım
    "Otobüs durağı": "Rawestgeha otobusê",
    "Tren garı": "Stasyona trênê",
    "Havalimanı": "Balafirgeh",
    "Liman": "Benderxane",
    # Kutlamalar
    "Hastalıkta": "Di nexweşiyê de",
    "Düğünde": "Di dawetê de",
    "Cenazen": "Di merasîma mirinê de",
    # İlişki
    "İkisi de çocuk": "Herdu jî zarok in",
    "Kurik = erkek çocuk, keçik = kız çocuk": "Kurik = kurik, keçik = keç",
    "Tersine": "Berovajî",
    "Yaşla ilgili": "Bi temen ve girêdayî",
    # Kibarlık
    "Teşekkürler": "Spas",
    "Lütfen": "Ji kerema xwe",
    "Özür dilerim": "Bibore",
    "Tamam": "Baş e",
    # Birliktelik
    "Yalnız": "Bi tenê",
    "Birlikte": "Bi hev re",
    "Ayrı ayrı": "Cuda cuda",
    "Bazen": "Carinan",
    # Hava
    "Hava sıcak": "Hewa germ e",
    "Hava soğuk": "Hewa sar e",
    "Hava bulutlu": "Hewa ewrî ye",
    "Hava güneşli": "Hewa rojane ye",
    # Güzel
    "Bu güzel": "Ev xweş e",
    "Bu kaç kilo?": "Ev çend kîlo ye?",
    "Bu ne kadar?": "Ev çiqas e?",
    "Bu nerede?": "Ev li ku ye?",
    # Zıt
    "Evet — ucuz/pahalı": "Erê — erzan/giran",
    "Hayır — ikisi de ucuz": "Na — herdu jî erzan in",
    "Evet — büyük/küçük": "Erê — mezin/biçûk",
    "Hayır — aynı": "Na — wekhev",
    # Giyim
    "Pantolon": "Şalwar",
    "Çorap": "Gore",
    "Gömlek/Elbise": "Kiras/Kinc",
    "Ayakkabı": "Sol",
    "Şapka": "Kumê serî",
    "Ceket": "Çakêt",
    "Sadece gömlek": "Tenê kiras",
    "Kıyafet/Elbise (genel)": "Cil û berg (giştî)",
    "Sadece pantolon": "Tenê şalwar",
    # Yemek
    "Yemekten önce": "Berî xwarinê",
    "Yemekten sonra": "Piştî xwarinê",
    "Yemek sırasında": "Di xwarinê de",
    "Yemek yerine": "Li şûna xwarinê",
    "Sabah": "Serê sibehê",
    # Gramer (ergative)
    "Eğik halde": "Di halê oblîk de",
    "Yalın halde": "Di halê rasterast de",
    "Her ikisinde": "Di herdu halan de",
    "Değişmez": "Naguhere",
    "Soru ekiyle": "Bi paşgira pirsê",
    "Yanlış — ew olmalı": "Çewt — divê ew be",
    "Hayır — em olmalı": "Na — divê em be",
    # Zaman
    "Bu yıl": "Vê salê",
    "Geçen yıl": "Par",
    "Gelecek yıl": "Sala bê",
    "Bu ay": "Vê mehê",
    # Ağrı
    "Mide ağrısı": "Êşa zikê",
    "Baş ağrısı": "Êşa serî",
    "Sırt ağrısı": "Êşa piştê",
    "Ateş": "Tayî",
    "Ateşim var": "Tayî li min heye",
    "Çok sıcağım": "Ez pir germ im",
    "Isınmak istiyorum": "Ez dixwazim germ bibim",
    "İlaç istiyorum": "Ez derman dixwazim",
    "Penisiline alerjim var": "Li hember penîsîlînê alerjiya min heye",
    "Penisiline ihtiyacım var": "Pêdiviya min bi penîsîlînê heye",
    "İyi değilim": "Ez baş nîn im",
    "Elim ağrıyor": "Destê min diêşe",
    "Sırtım ağrıyor": "Pişta min diêşe",
    "Ayağım/Bacağım ağrıyor": "Lingê min diêşe",
    "Başım ağrıyor": "Serê min diêşe",
    # Bedensel özellikler
    "Evet — ince/şişman": "Erê — zirav/qelew",
    "Hayır — ikisi de ince": "Na — herdu jî zirav in",
    "Evet — kısa/uzun": "Erê — kin/dirêj",
    # Öğrenme
    "Aynı anlam": "Heman wate",
    "Hîn bûn = öğrenmek, fêr bûn = alışmak": "Hîn bûn = fêrbûn, fêr bûn = lêhatin",
    "İkisi de alışmak": "Herdu jî lêhatin",
    "İkisi de kitap — pirtûk daha yaygın": "Herdu jî pirtûk in — pirtûk zêdetir tê bikar anîn",
    "Kîtêb daha yaygın": "Kîtêb zêdetir tê bikar anîn",
    "Tamamen farklı anlam": "Bi tevahî cuda ye",
    "Biri küçük diğeri büyük": "Yek biçûk e, ya din mezin e",
    # İş
    "Ne iş yapıyorsun?": "Tu çi kar dikî?",
    "Nerede çalışıyorsun?": "Tu li kû dixebitî?",
    "Kaç saat çalışıyorsun?": "Tu çend saetan dixebitî?",
    "Neden çalışıyorsun?": "Tu çima dixebitî?",
    "Çok çalışıyor": "Pir dixebite",
    "Serbest/Freelance çalışıyor": "Bi serbestî dixebite",
    "Şirkette çalışıyor": "Li şîrketê dixebite",
    "Çalışmıyor": "Naxebite",
    # Duygu
    "Üzgün": "Xemgîn",
    "Korkmuş": "Tirsiyayî",
    "Mutlu/Sevinçli": "Kêfxweş/Şa",
    "Yorgun": "Westiyayî",
    "Mutlu": "Kêfxweş",
    "Kızgın": "Hêrskirî",
    "Şaşkın": "Şaşbûyî",
    "Kederli/Hüzünlü": "Xemgîn/Tarî",
    "Heyecanlı": "Biheyecan",
    # Umut
    "Korkum var": "Tirsa min heye",
    "Umudum var": "Hêviya min heye",
    "Planım var": "Planê min heye",
    "Yardımım var": "Alîkariya min heye",
    "Umutlu ol!": "Bi hêvî be!",
    "Umutsuz olma!": "Bê hêvî nebe!",
    "Korkma!": "Netirse!",
    "Üzülme!": "Xemgîn nebe!",
    # Derece
    'Önüne "pir" gelir sadece': 'Tenê li pêş "pir" tê',
    'Önüne "daha" gelir': 'Li pêş "hîn zêdetir" tê',
    "Sona -tir/-tirîn eklenir": "Li dawî -tir/-tirîn tê zêde kirin",
    # Edebiyat
    "Kitap": "Pirtûk",
    "Şarkı/Türkü": "Kilam/Stran",
    "Şiir": "Helbest",
    "Hikaye": "Çîrok",
    "Okuyucu": "Xwendevan",
    "Halk ozanı/Dengbêj": "Dengbêj",
    "Şair": "Helbestvan",
    "Öğretmen": "Mamoste",
    "Müzik": "Muzîk",
    "Edebiyat": "Wêje",
    "Resim": "Wêne",
    "Dans": "Govend",
    "Kürt başkanı": "Serokê Kurdan",
    "Ünlü Kürt şairi (1903–1984)": "Helbestvanê navdar ê Kurd (1903–1984)",
    "Dengbêj": "Dengbêj",
    "Bedir Han": "Bedirxan",
}


def main():
    path = "lib/features/lessons/domain/a2_lesson_definitions.dart"
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    original = content
    replaced = 0
    not_found = []
    for tr, ku in TRANSLATIONS.items():
        # Tam string eşleşmesi
        tr_quoted = f"'{tr}'"
        ku_quoted = f"'{ku}'"
        if tr_quoted in content:
            content = content.replace(tr_quoted, ku_quoted)
            replaced += 1
        else:
            not_found.append(tr)

    # Virgül sonundaki '\n' kaçışlı olan "Cenazen\" "," vs garip olanlar
    # manuel düzeltmeler
    manual = {
        "'Cenazen\\n          ','',": "'Di merasîma mirinê de',''",
        "'Ew\\n          ','',": "'Ew',''",
        "'Evet — me = em\\n          ','',": "'Erê — me = em',''",
        "'Bedir Han\\": "'Bedirxan\\",
    }
    for a, b in manual.items():
        if a in content:
            content = content.replace(a, b)

    if content != original:
        with open(path, "w", encoding="utf-8") as f:
            f.write(content)
        print(f"{path}: {replaced} çeviri uygulandı")
    else:
        print("No changes")

    if not_found:
        print(f"\nBulunmayanlar ({len(not_found)}):")
        for nf in not_found[:10]:
            print(f"  · {nf}")


if __name__ == "__main__":
    main()
