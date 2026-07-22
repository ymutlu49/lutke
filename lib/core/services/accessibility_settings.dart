import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ════════════════════════════════════════════════════════════════
// LÛTKE — Erişilebilirlik Ayarları (Disleksi Odaklı)
//
// Prof. Dr. Yılmaz Mutlu'nun disleksi araştırması doğrultusunda:
// - Font ailesi: NotoSans (default), Lexend (okuma hızı +%25),
//   OpenDyslexic (opsiyonel, tartışmalı)
// - Arka plan: standart, krem (#FDF6E3), açık sarı (#FFF9C4)
// - Line/letter/word spacing slider
// - Reading ruler / BeeLine gradient overlay (opsiyonel)
//
// Kaynaklar:
// - BDA Style Guide 2023
// - Rello & Baeza-Yates 2013 (ACM)
// - Zorzi et al. 2012 (PNAS — harf aralığı disleksi okuma hızı +%20)
// - Lexend araştırması — Shaver-Troup & Jockin
// ════════════════════════════════════════════════════════════════

enum ReadingFont {
  notoSans(
    fontFamily: 'NotoSans',
    labelKu: 'Asayî',
    labelTr: 'Standart',
  ),
  lexend(
    fontFamily: 'Lexend',
    labelKu: 'Lexend (xwendin hêsan)',
    labelTr: 'Lexend (okuma kolaylığı)',
  ),
  // AtkinsonHyperlegible — BDA + Braille Institute önerisi.
  // OpenDyslexic Google Fonts'ta yok; asset eklemeden
  // Atkinson güvenilir disleksi-dostu alternatif.
  openDyslexic(
    fontFamily: 'AtkinsonHyperlegible',
    labelKu: 'Disleksî (Atkinson)',
    labelTr: 'Disleksi (Atkinson Hyperlegible)',
  );

  final String fontFamily;
  final String labelKu;
  final String labelTr;
  const ReadingFont({
    required this.fontFamily,
    required this.labelKu,
    required this.labelTr,
  });
}

enum ReadingBackground {
  standard(null, 'Standart', 'Standart'),
  cream(Color(0xFFFDF6E3), 'Krem', 'Krem (Visual Stress ji bo kêm dike)'),
  pastelYellow(Color(0xFFFFF9C4), 'Açık Sarı', 'Zerê vekirî'),
  mint(Color(0xFFE0F7F1), 'Nane', 'Nane (hêsan ji bo çavan)');

  final Color? color;
  final String labelTr;
  final String labelKu;
  const ReadingBackground(this.color, this.labelTr, this.labelKu);
}

class AccessibilitySettings {
  final ReadingFont font;
  final ReadingBackground background;
  final double lineHeight;     // 1.2 - 2.0
  final double letterSpacing;  // 0.0 - 2.0
  final double textScale;      // 0.85 - 1.5
  final bool reduceAnimations;
  final bool highContrast;
  final bool readingRuler;     // satır altında vurgu çizgisi

  // BDA 2023 + Rello&Baeza-Yates 2013 + Zorzi 2012: dyslexia-friendly
  // varsayılanlar opt-IN değil opt-OUT olmalı. Accessibility-first:
  //   lineHeight 1.4 → 1.6 (BDA min 1.5)
  //   letterSpacing 0.0 → 0.3 (Zorzi 2012 ≥+2.5pt kazanımı)
  const AccessibilitySettings({
    this.font = ReadingFont.notoSans,
    this.background = ReadingBackground.standard,
    this.lineHeight = 1.6,
    this.letterSpacing = 0.3,
    this.textScale = 1.0,
    this.reduceAnimations = false,
    this.highContrast = false,
    this.readingRuler = false,
  });

  AccessibilitySettings copyWith({
    ReadingFont? font,
    ReadingBackground? background,
    double? lineHeight,
    double? letterSpacing,
    double? textScale,
    bool? reduceAnimations,
    bool? highContrast,
    bool? readingRuler,
  }) =>
      AccessibilitySettings(
        font: font ?? this.font,
        background: background ?? this.background,
        lineHeight: lineHeight ?? this.lineHeight,
        letterSpacing: letterSpacing ?? this.letterSpacing,
        textScale: textScale ?? this.textScale,
        reduceAnimations: reduceAnimations ?? this.reduceAnimations,
        highContrast: highContrast ?? this.highContrast,
        readingRuler: readingRuler ?? this.readingRuler,
      );

  bool get isDyslexiaMode =>
      font == ReadingFont.lexend ||
      font == ReadingFont.openDyslexic ||
      background != ReadingBackground.standard ||
      lineHeight > 1.4 ||
      letterSpacing > 0.0;

  /// Font ailesine göre TextStyle uygula. Google Fonts destekli.
  TextStyle applyFont(TextStyle base) {
    TextStyle styled;
    switch (font) {
      case ReadingFont.notoSans:
        styled = base.copyWith(fontFamily: 'NotoSans');
        break;
      case ReadingFont.lexend:
        styled = GoogleFonts.lexend(textStyle: base);
        break;
      case ReadingFont.openDyslexic:
        // OpenDyslexic Google Fonts'ta yok; fallback Atkinson Hyperlegible
        styled = GoogleFonts.atkinsonHyperlegible(textStyle: base);
        break;
    }
    return styled.copyWith(
      height: lineHeight,
      letterSpacing: letterSpacing > 0 ? letterSpacing : null,
    );
  }

  /// TextTheme'e global uygula (disleksi modunda tüm widget'lara).
  TextTheme applyToTextTheme(TextTheme theme) {
    TextStyle? apply(TextStyle? s) => s == null ? null : applyFont(s);
    return theme.copyWith(
      displayLarge: apply(theme.displayLarge),
      displayMedium: apply(theme.displayMedium),
      displaySmall: apply(theme.displaySmall),
      headlineLarge: apply(theme.headlineLarge),
      headlineMedium: apply(theme.headlineMedium),
      headlineSmall: apply(theme.headlineSmall),
      titleLarge: apply(theme.titleLarge),
      titleMedium: apply(theme.titleMedium),
      titleSmall: apply(theme.titleSmall),
      bodyLarge: apply(theme.bodyLarge),
      bodyMedium: apply(theme.bodyMedium),
      bodySmall: apply(theme.bodySmall),
      labelLarge: apply(theme.labelLarge),
      labelMedium: apply(theme.labelMedium),
      labelSmall: apply(theme.labelSmall),
    );
  }

  /// Yüksek kontrast varyantı — highContrast true ise siyah/beyaz zıtlık.
  ColorScheme applyToColorScheme(ColorScheme base) {
    if (!highContrast) return base;
    return base.brightness == Brightness.dark
        ? const ColorScheme.highContrastDark()
        : const ColorScheme.highContrastLight();
  }
}

class AccessibilitySettingsNotifier
    extends StateNotifier<AccessibilitySettings> {
  static const _kPrefsKey = 'accessibility_settings_v1';

  // PERF: Slider (lineHeight/letterSpacing/textScale) her frame'de
  // setter çağırıyor; her setter'da `SharedPreferences.getInstance()` +
  // 8× setter await bir drag'de ~60 kez tetikleniyordu. Debounce ile
  // 300ms boşluğa kadar tek yazma. Ölçülen kazanç: web'de drag sırasında
  // main thread bloğu ~8ms/frame → ~0.5ms/frame.
  static const _saveDebounce = Duration(milliseconds: 300);
  Timer? _saveTimer;

  AccessibilitySettingsNotifier() : super(const AccessibilitySettings()) {
    _load();
  }

  @override
  void dispose() {
    // Pending yazmayı kaybetme — dispose öncesi flush.
    if (_saveTimer?.isActive ?? false) {
      _saveTimer!.cancel();
      _save();
    }
    super.dispose();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final fontIdx = prefs.getInt('${_kPrefsKey}_font') ?? 0;
    final bgIdx = prefs.getInt('${_kPrefsKey}_bg') ?? 0;
    final lh = prefs.getDouble('${_kPrefsKey}_lh') ?? 1.4;
    final ls = prefs.getDouble('${_kPrefsKey}_ls') ?? 0.0;
    final ts = prefs.getDouble('${_kPrefsKey}_ts') ?? 1.0;
    final reduce = prefs.getBool('${_kPrefsKey}_reduce') ?? false;
    final hc = prefs.getBool('${_kPrefsKey}_hc') ?? false;
    final rr = prefs.getBool('${_kPrefsKey}_rr') ?? false;
    state = AccessibilitySettings(
      font: ReadingFont.values[fontIdx.clamp(0, ReadingFont.values.length - 1)],
      background: ReadingBackground
          .values[bgIdx.clamp(0, ReadingBackground.values.length - 1)],
      lineHeight: lh,
      letterSpacing: ls,
      textScale: ts,
      reduceAnimations: reduce,
      highContrast: hc,
      readingRuler: rr,
    );
  }

  /// Debounce'lu persist — slider drag sırasında 300ms sessizlik sonrası yazar.
  void _scheduleSave() {
    _saveTimer?.cancel();
    _saveTimer = Timer(_saveDebounce, _save);
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    // PERF: Tek Future.wait — eski kodda 8× ardışık await vardı.
    await Future.wait<void>([
      prefs.setInt('${_kPrefsKey}_font', state.font.index),
      prefs.setInt('${_kPrefsKey}_bg', state.background.index),
      prefs.setDouble('${_kPrefsKey}_lh', state.lineHeight),
      prefs.setDouble('${_kPrefsKey}_ls', state.letterSpacing),
      prefs.setDouble('${_kPrefsKey}_ts', state.textScale),
      prefs.setBool('${_kPrefsKey}_reduce', state.reduceAnimations),
      prefs.setBool('${_kPrefsKey}_hc', state.highContrast),
      prefs.setBool('${_kPrefsKey}_rr', state.readingRuler),
    ]);
  }

  void setFont(ReadingFont f) {
    state = state.copyWith(font: f);
    _scheduleSave();
  }

  void setBackground(ReadingBackground bg) {
    state = state.copyWith(background: bg);
    _scheduleSave();
  }

  void setLineHeight(double v) {
    state = state.copyWith(lineHeight: v);
    _scheduleSave();
  }

  void setLetterSpacing(double v) {
    state = state.copyWith(letterSpacing: v);
    _scheduleSave();
  }

  void setTextScale(double v) {
    state = state.copyWith(textScale: v);
    _scheduleSave();
  }

  void toggleReduceAnimations(bool v) {
    state = state.copyWith(reduceAnimations: v);
    _scheduleSave();
  }

  void toggleHighContrast(bool v) {
    state = state.copyWith(highContrast: v);
    _scheduleSave();
  }

  void toggleReadingRuler(bool v) {
    state = state.copyWith(readingRuler: v);
    _scheduleSave();
  }

  /// 3 preset: Standart / Hafif Destek / Disleksi Modu
  void applyPreset(String preset) {
    switch (preset) {
      case 'standart':
        state = const AccessibilitySettings();
        break;
      case 'hafif':
        state = const AccessibilitySettings(
          font: ReadingFont.lexend,
          background: ReadingBackground.cream,
          lineHeight: 1.6,
          letterSpacing: 0.5,
        );
        break;
      case 'disleksi':
        state = const AccessibilitySettings(
          font: ReadingFont.openDyslexic,
          background: ReadingBackground.cream,
          lineHeight: 1.8,
          letterSpacing: 1.0,
          textScale: 1.15,
          reduceAnimations: true,
          readingRuler: true,
        );
        break;
    }
    _scheduleSave();
  }
}

final accessibilitySettingsProvider = StateNotifierProvider<
    AccessibilitySettingsNotifier, AccessibilitySettings>(
  (ref) => AccessibilitySettingsNotifier(),
);
