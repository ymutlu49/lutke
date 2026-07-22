// LÛTKE PWA service worker — minimal passthrough.
//
// Amaç: PWA install prompt için zorunlu olan SW kaydını sağlamak
// (manifest + SW kayıt + HTTPS = Chrome "Install app" prompt'u).
//
// Cache YAPMAZ. Eski Flutter default SW agresif cache yapıyordu ve
// yeni JS bundle'lar deploy edildiğinde kullanıcılar eski cache'te
// kilitleniyordu (Mayıs 2026 auth migration sorunu). Bu SW fetch
// event'ine müdahale etmiyor; tüm istekler normal ağ + browser HTTP
// cache + Cloudflare _headers (max-age) ile yönetiliyor.

self.addEventListener('install', function (event) {
  // Hemen aktif ol — eski SW'leri (varsa) bekleme.
  self.skipWaiting();
});

self.addEventListener('activate', function (event) {
  // Mevcut sekmeleri hemen kontrol et.
  event.waitUntil(self.clients.claim());
});

// fetch event handler intentionally omitted.
// Tarayıcı normal ağ akışını kullanır.
