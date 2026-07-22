// LÛTKE — Pages Functions middleware.
// Same-origin since lutke.app calls /api/* on itself → no CORS needed.
// But add basic security headers for API responses.

export const onRequest: PagesFunction = async (context) => {
  const response = await context.next();

  // Only modify API responses
  if (!new URL(context.request.url).pathname.startsWith("/api/")) {
    return response;
  }

  // Clone with security headers
  const headers = new Headers(response.headers);
  headers.set("X-Content-Type-Options", "nosniff");
  headers.set("X-Frame-Options", "DENY");
  headers.set("Referrer-Policy", "strict-origin-when-cross-origin");
  // HTTPS zorunlu — tarayıcı bir kez gördükten sonra HTTP denemez.
  headers.set(
    "Strict-Transport-Security",
    "max-age=31536000; includeSubDomains",
  );
  // API yanıtları cache'lenmesin (jsonResponse zaten no-store setler;
  // bu, header setlemeyen olası yanıtlar için güvenlik ağı).
  if (!headers.has("Cache-Control")) {
    headers.set("Cache-Control", "no-store");
  }

  return new Response(response.body, {
    status: response.status,
    statusText: response.statusText,
    headers,
  });
};
