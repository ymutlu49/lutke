// LÛTKE — GET /api/public-config
//
// Frontend startup'ta çağrılır. Yalnızca PUBLIC bilgileri döndürür
// (örn. Google OAuth client_id — public anyway).
//
// SECRET değerler (JWT_SECRET, DKIM key vb.) ASLA buraya eklenmez.

import { jsonResponse, type Env } from "../lib/http";

export const onRequestGet: PagesFunction<Env> = async ({ env }) => {
  return jsonResponse({
    googleClientId: env.GOOGLE_CLIENT_ID ?? null,
  });
};
