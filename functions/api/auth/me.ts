// LÛTKE — GET /api/auth/me
// Bearer token verification + user lookup.
// Returns: 200 { user } | 401 unauthorized

import {
  errorResponse,
  getAuthFromRequest,
  jsonResponse,
  type Env,
} from "../../lib/http";
import { findUserById } from "../../lib/db";

export const onRequestGet: PagesFunction<Env> = async ({ request, env }) => {
  const auth = await getAuthFromRequest(request, env);
  if (!auth) return errorResponse("Oturum yok.", 401, "unauthorized");

  const user = await findUserById(env.DB, auth.userId);
  if (!user) return errorResponse("Kullanıcı bulunamadı.", 404, "not_found");

  return jsonResponse({
    user: {
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
      createdAt: user.created_at,
      lastLoginAt: user.last_login_at,
    },
  });
};
