// LÛTKE — Password hashing using Web Crypto PBKDF2.
//
// Why PBKDF2 not bcrypt:
//   - Web Crypto API natively supports PBKDF2 (no WASM/dependency)
//   - Cloudflare Workers have CPU limits; bcrypt cost factor 10+
//     can hit them.
//
// Iteration count = 100_000:
//   - Cloudflare Workers Crypto API hard-caps PBKDF2 iterations at
//     100_000 (NotSupportedError above that). NIST SP 800-132 minimum
//     is 10_000; 100_000 still well above industry baseline. With a
//     32-byte random salt + SHA-256 derivation this gives ~16-18 bits
//     of attacker work amplification on commodity GPUs in 2026.
//
// Output format: "<salt_hex>:<hash_hex>" (64 char salt, 64 char hash)

const ITERATIONS = 100_000; // Cloudflare Workers max
const KEY_LEN = 32; // 256-bit derived key
const SALT_LEN = 32; // 256-bit salt

const enc = new TextEncoder();

function bytesToHex(bytes: Uint8Array): string {
  return Array.from(bytes)
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("");
}

function hexToBytes(hex: string): Uint8Array {
  const out = new Uint8Array(hex.length / 2);
  for (let i = 0; i < out.length; i++) {
    out[i] = parseInt(hex.substring(i * 2, i * 2 + 2), 16);
  }
  return out;
}

async function deriveKey(
  password: string,
  salt: Uint8Array,
): Promise<Uint8Array> {
  const baseKey = await crypto.subtle.importKey(
    "raw",
    enc.encode(password),
    { name: "PBKDF2" },
    false,
    ["deriveBits"],
  );
  // Cast salt to BufferSource
  const saltBuf = salt.buffer.slice(
    salt.byteOffset,
    salt.byteOffset + salt.byteLength,
  ) as ArrayBuffer;
  const derived = await crypto.subtle.deriveBits(
    {
      name: "PBKDF2",
      salt: saltBuf,
      iterations: ITERATIONS,
      hash: "SHA-256",
    },
    baseKey,
    KEY_LEN * 8,
  );
  return new Uint8Array(derived);
}

/**
 * Hash a password. Returns "<salt_hex>:<hash_hex>".
 */
export async function hashPassword(password: string): Promise<{
  hash: string;
  salt: string;
}> {
  const salt = crypto.getRandomValues(new Uint8Array(SALT_LEN));
  const hash = await deriveKey(password, salt);
  return {
    hash: bytesToHex(hash),
    salt: bytesToHex(salt),
  };
}

/**
 * Verify a password against stored hash + salt.
 */
export async function verifyPassword(
  password: string,
  storedHash: string,
  storedSalt: string,
): Promise<boolean> {
  const salt = hexToBytes(storedSalt);
  const computed = await deriveKey(password, salt);
  const stored = hexToBytes(storedHash);
  if (computed.length !== stored.length) return false;
  // Constant-time compare
  let diff = 0;
  for (let i = 0; i < computed.length; i++) {
    diff |= computed[i] ^ stored[i];
  }
  return diff === 0;
}

/**
 * Validate password strength. Returns null if OK, error message otherwise.
 */
export function validatePassword(password: string): string | null {
  if (password.length < 8) return "Şifre en az 8 karakter olmalı.";
  if (password.length > 128) return "Şifre çok uzun.";
  return null;
}
