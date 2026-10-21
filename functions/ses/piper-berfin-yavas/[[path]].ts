// LÛTKE — eski Kurmancî ses klasörü (/ses/piper-berfin-yavas/…).
//
// 2026-10-21'den beri site Kurmancî sesleri birleşik klasörden yayımlar (/ses/lutke-kurmanci/:
// ElevenLabs Sarah + Sarah'da olmayan birkaç Piper; Ziman/ses/fabrika/karma.py). Eski klasör siteye konmaz:
// iki klasör birden Pages'in 20.000 dosya sınırını aşar. Ama Android 1.0.1+5 (2026-10-15) sesleri
// hâlâ eski adresten ister. Bu işlev eski adı yeni dosyaya çevirir:
//   - tabloda varsa (sesi değişen metin) → yeni dosya
//   - yoksa aynı ad yeni klasörde aranır (değişmeyen Piper dosyaları birleşik klasörde aynı adı taşır)
// Yönlendirme değil, aynı adreste yanıt: kalıcı (301) yönlendirme önbelleğe girer ve sesler düzey düzey
// değiştikçe eskimiş bir hedefi gösterirdi. Tablo: fabrika/lutke_esitle.py → functions/lib/eski_ses_klasoru.json.
import eskiKlasor from "../../lib/eski_ses_klasoru.json";

const tablo = eskiKlasor as { eski: string; taban: string; dosya: Record<string, string> };
const AD = /^[0-9a-f]{2}\/[0-9a-f]{16}\.mp3$/;

export const onRequest: PagesFunction = async (context) => {
  const { request } = context;
  if (request.method !== "GET" && request.method !== "HEAD") {
    return new Response(null, { status: 405, headers: { Allow: "GET, HEAD" } });
  }
  const url = new URL(request.url);
  const ad = url.pathname.slice(`/ses/${tablo.eski}/`.length);
  if (!AD.test(ad)) {
    return new Response("Not found", { status: 404 });
  }
  const hedef = new URL(tablo.taban + (tablo.dosya[ad] ?? ad), url);
  const yanit = await context.env.ASSETS.fetch(new Request(hedef, request));
  // Pages bulunamayan dosyada kökteki index.html'i 200 ile döndürür; ses değilse yok say.
  if (!yanit.ok || !(yanit.headers.get("Content-Type") ?? "").startsWith("audio/")) {
    return new Response("Not found", { status: 404 });
  }
  const basliklar = new Headers(yanit.headers);
  // Bir gün: hedef dosya içerikten adlandırılır ama eski adın hedefi ses değiştikçe değişir.
  basliklar.set("Cache-Control", "public, max-age=86400");
  basliklar.set("Access-Control-Allow-Origin", "*");
  return new Response(yanit.body, { status: yanit.status, headers: basliklar });
};
