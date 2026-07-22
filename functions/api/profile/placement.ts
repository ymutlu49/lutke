// LÛTKE — /api/profile/placement
// Düzey belirleme testi sonucunu kullanıcı hesabına yazar
// (account + TRACK bazlı test-once: Kurmancî ve İngilizce ayrı sinyaller).
//
// POST Body: { level: "a1".."c2", track?: "ku" | "en" }  (track yoksa "ku" —
//            eski client'lar kırılmaz, geriye uyumlu)
// POST Returns: 200 { user } | 400 invalid | 401 unauthorized
//
// GET  Returns: 200 { placementLevel, placementLevelEn } | 401 unauthorized
//   Client login/me sonrası hesaptaki track-bazlı seviyeleri çekip
//   SharedPreferences'a senkronlamak için kullanır (cihaz/tarayıcı değişiminde
//   localStorage otomatik dolar).

import {
  errorResponse,
  getAuthFromRequest,
  jsonResponse,
  type Env,
} from "../../lib/http";
import { findUserById, setPlacementLevel, type UserRow } from "../../lib/db";

const ALLOWED = new Set(["a1", "a2", "b1", "b2", "c1", "c2"]);
const ALLOWED_TRACKS = new Set(["ku", "en"]);

/// Public user JSON — placementLevel (KU) alanı MEVCUT şekliyle korunur
/// (geriye uyumluluk), placementLevelEn track-bazlı yeni alan.
function userJson(user: UserRow) {
  return {
    id: user.id,
    email: user.email,
    displayName: user.display_name,
    emailVerified: user.email_verified === 1,
    isOwner: user.is_owner === 1,
    currentLevel: user.current_level,
    targetLevel: user.target_level,
    isHeritage: user.is_heritage === 1,
    dailyGoal: user.daily_goal,
    placementLevel: user.placement_level,
    placementLevelEn: user.placement_level_en,
  };
}

export const onRequestPost: PagesFunction<Env> = async ({ request, env }) => {
  const auth = await getAuthFromRequest(request, env);
  if (!auth) return errorResponse("Oturum yok.", 401, "unauthorized");

  let body: { level?: string; track?: string };
  try {
    body = (await request.json()) as { level?: string; track?: string };
  } catch {
    return errorResponse("Geçersiz istek.", 400, "bad_request");
  }

  const level = (body.level ?? "").toLowerCase().trim();
  if (!ALLOWED.has(level)) {
    return errorResponse("Geçersiz seviye.", 400, "invalid_level");
  }

  // track opsiyonel — eski client'lar göndermez → "ku" varsayılır.
  const track = (body.track ?? "ku").toLowerCase().trim();
  if (!ALLOWED_TRACKS.has(track)) {
    return errorResponse("Geçersiz track.", 400, "invalid_track");
  }

  await setPlacementLevel(env.DB, auth.userId, level, track as "ku" | "en");

  const user = await findUserById(env.DB, auth.userId);
  if (!user) return errorResponse("Kullanıcı bulunamadı.", 404, "not_found");

  return jsonResponse({ user: userJson(user) });
};

// GET /api/profile/placement — hesaptaki track-bazlı placement seviyeleri.
// /api/auth/me yanıtı placementLevelEn içermiyorsa client bu endpoint'le
// tamamlar (auth dosyalarına dokunmadan cihazlar arası senkron garanti edilir).
export const onRequestGet: PagesFunction<Env> = async ({ request, env }) => {
  const auth = await getAuthFromRequest(request, env);
  if (!auth) return errorResponse("Oturum yok.", 401, "unauthorized");

  const user = await findUserById(env.DB, auth.userId);
  if (!user) return errorResponse("Kullanıcı bulunamadı.", 404, "not_found");

  return jsonResponse({
    placementLevel: user.placement_level,
    placementLevelEn: user.placement_level_en,
  });
};
