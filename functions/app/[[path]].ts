// LÛTKE — /app/* derin bağlantıları (Flutter SPA kabuğu).
//
// Flutter uygulaması yol tabanlı adres kullanır (usePathUrlStrategy):
// /app/home, /app/auth/login, /app/legal/privacy ... Bunlar dosya değildir;
// hepsinde uygulamanın kabuğu (/app/index.html) dönmelidir. Yoksa Pages
// bulunamayan yol için KÖKTEKİ index.html'i (tanıtım sitesi) 200 ile döndürür:
// sayfayı yenileyen ya da yer imiyle gelen kullanıcı tanıtım sayfasına düşer.
//
// Bu iş _redirects ile yapılamıyor:
//   /app/*  /app/index.html  200  → wrangler kuralı dağıtımda "Infinite loop
//                                    detected" diyerek atar (hedef /index.html).
//   /app/*  /app/            200  → yeniden yazma dosya aramasından ÖNCE
//                                    uygulanır; /app/main.dart.js dahil her
//                                    isteği kabuğa çevirir.

// İçinde uzantısız dosya da bulunabilen klasörler (ör. assets/NOTICES).
const ASSET_DIRS = ["assets", "canvaskit", "icons"];

function isAppRoute(pathname: string): boolean {
  const rest = pathname.slice("/app/".length);
  if (rest === "") return false; // /app ve /app/ → kabuğun kendisi
  const segments = rest.split("/");
  if (ASSET_DIRS.includes(segments[0])) return false;
  // Son parçada nokta varsa dosyadır (main.dart.js, version.json ...).
  return !segments[segments.length - 1].includes(".");
}

// Eski Kurmancî ses dosyaları (assets/audio/words/*.wav, 1,3 GB) siteden kaldırıldı;
// sesler artık /ses/<ses>/… altında MP3 (Jimaro ses fabrikası, Ziman/ses/fabrika).
// Güncellenmemiş Android sürümleri hâlâ eski .wav adreslerini ister: aynı cümlenin
// yeni sesine yönlendirilir. Eşleme: tool/ses_esleme.py → functions/lib/eski_ses.json.
import eskiSes from "../lib/eski_ses.json";
const ESKI_WAV = /^\/app\/assets\/assets\/audio\/words\/([^/]+\.wav)$/;

export const onRequest: PagesFunction = async (context) => {
  const { request } = context;
  const url = new URL(request.url);
  const isRead = request.method === "GET" || request.method === "HEAD";

  const eski = isRead ? ESKI_WAV.exec(url.pathname) : null;
  if (eski) {
    const yeni = (eskiSes as { taban: string; dosya: Record<string, string> }).dosya[eski[1]];
    if (yeni) {
      return Response.redirect(new URL(eskiSes.taban + yeni, url).toString(), 301);
    }
  }

  if (!isRead || !isAppRoute(url.pathname)) {
    return context.next();
  }

  // Adres çubuğu değişmez; yalnız yanıtın gövdesi kabuktan gelir.
  return context.env.ASSETS.fetch(new Request(new URL("/app/", url), request));
};
