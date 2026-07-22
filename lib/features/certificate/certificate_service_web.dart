// Web-only download implementation.
// dart:html is deprecated for pure Flutter, but for a download trigger
// (no DOM manipulation beyond AnchorElement click) it remains the simplest
// and stable API. ignore_for_file comment gates the lint.

// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

/// Browser üzerinden PNG indir.
void downloadPng({required Uint8List bytes, required String fileName}) {
  final base64 = base64Encode(bytes);
  final url = 'data:image/png;base64,$base64';
  final anchor = html.AnchorElement(href: url)
    ..download = fileName
    ..style.display = 'none';
  html.document.body?.children.add(anchor);
  anchor.click();
  anchor.remove();
}
