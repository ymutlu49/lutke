import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart' show GlobalKey;
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

// ────────────────────────────────────────────────────────────────
// Web-only imports: conditional imports used so file compiles on
// mobile/desktop too. dart:html tree-shaken out on non-web.
// ────────────────────────────────────────────────────────────────
import 'certificate_service_web_stub.dart'
    if (dart.library.html) 'certificate_service_web.dart' as web_downloader;

import 'dart:io' as io;

/// Sertifika ve paylaşım kartı için ortak PNG üretim + dağıtım servisi.
class CertificateService {
  CertificateService._();

  // ── PNG ÜRETİMİ ─────────────────────────────────────────────

  /// [key] ile bağlı [RepaintBoundary]'yi yakalar ve PNG bytes döner.
  /// [pixelRatio] yüksek değer = daha keskin görüntü (önerilen: 3.0).
  static Future<Uint8List?> capture(
    GlobalKey key, {
    double pixelRatio = 3.0,
  }) async {
    try {
      final boundary = key.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) return null;

      // Asset yüklenme gecikmesi için kısa bir microtask bekleme.
      await Future<void>.delayed(const Duration(milliseconds: 50));

      final image = await boundary.toImage(pixelRatio: pixelRatio);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (_) {
      return null;
    }
  }

  // ── İNDİRME ─────────────────────────────────────────────────

  /// PNG'yi platforma göre indirir.
  ///  • Web: `<a download>` tetikler, dosyayı indirir.
  ///  • Mobile: geçici dosyaya yazar + share sheet açar.
  static Future<void> download({
    required Uint8List bytes,
    required String fileName,
  }) async {
    if (kIsWeb) {
      web_downloader.downloadPng(bytes: bytes, fileName: fileName);
      return;
    }
    // Mobile fallback — share sheet ile kaydet/paylaş.
    try {
      final tempDir = await getTemporaryDirectory();
      final file = io.File('${tempDir.path}/$fileName');
      await file.writeAsBytes(bytes);
      await Share.shareXFiles(
        [XFile(file.path, name: fileName, mimeType: 'image/png')],
      );
    } catch (_) {/* sessiz */}
  }

  // ── SERTİFİKA DOĞRULAMA KODU ────────────────────────────────

  /// userId + level + date → 10 karakterlik kısa hash (doğrulama kimliği).
  /// Kriptografik değil, sadece görünür bir ID. Deterministik.
  static String buildCertificateId({
    required String userId,
    required String level,
    required DateTime date,
  }) {
    final payload = '$userId|${level.toUpperCase()}|'
        '${date.year}-${_pad(date.month)}-${_pad(date.day)}';
    // FNV-1a 32-bit → base32 kısaltma. JS-safe (int 2^53 sınırı), deterministik.
    int hash = 0x811c9dc5;
    for (final code in payload.codeUnits) {
      hash ^= code;
      hash = (hash * 0x01000193) & 0xFFFFFFFF;
    }
    // 10 karakter base32 (RFC 4648 alfabesi altküme). 2. kısım için hash'i
    // yeniden karıştır, böylece çıktı hâlâ 10 karakter uzun.
    const alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final chars = <String>[];
    int h = hash;
    for (int i = 0; i < 10; i++) {
      if (i == 6) {
        // İkinci yarıda farklı bit bölgelerini kullan
        h = (hash ^ (hash >> 16)) & 0xFFFFFFFF;
      }
      chars.add(alphabet[h & 0x1F]);
      h >>= 5;
    }
    return chars.join();
  }

  static String _pad(int v) => v.toString().padLeft(2, '0');

  // ── Dosya adı üretimi ───────────────────────────────────────

  static String buildCertificateFileName({
    required String userName,
    required String level,
  }) {
    final safe = _sanitize(userName);
    return 'LUTKE_${safe}_${level.toUpperCase()}.png';
  }

  static String buildShareCardFileName({
    required String title,
  }) {
    final safe = _sanitize(title);
    return 'LUTKE_Share_$safe.png';
  }

  static String _sanitize(String raw) {
    // Diaktritik Kurmancî karakterlerini ASCII-ish'e indirge, özel karakterleri sil.
    const map = {
      'ê': 'e', 'Ê': 'E', 'î': 'i', 'Î': 'I', 'û': 'u', 'Û': 'U',
      'ç': 'c', 'Ç': 'C', 'ş': 's', 'Ş': 'S',
      'ı': 'i', 'İ': 'I', 'ğ': 'g', 'Ğ': 'G', 'ö': 'o', 'Ö': 'O',
      'ü': 'u', 'Ü': 'U',
    };
    var s = raw;
    map.forEach((k, v) => s = s.replaceAll(k, v));
    final clean = s.replaceAll(RegExp(r'[^A-Za-z0-9_-]+'), '_');
    return clean.isEmpty ? 'user' : clean;
  }

  // ── Metin paylaşımı ─────────────────────────────────────────

  /// Çand kartı için düz metin paylaşımı (Instagram/WhatsApp fallback).
  static Future<void> shareText(String text) async {
    try {
      await Share.share(text);
    } catch (_) {/* sessiz */}
  }

  // ── Küçük yardımcı: base64 data URL (debug) ──────────────────

  static String toDataUrl(Uint8List bytes) =>
      'data:image/png;base64,${base64Encode(bytes)}';
}
