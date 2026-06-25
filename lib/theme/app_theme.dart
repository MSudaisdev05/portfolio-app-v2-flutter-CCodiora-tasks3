import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ── Light Palette ────────────────────────────────────────────────────────
  static const Color background    = Color(0xFFFBF8F3);
  static const Color surface       = Color(0xFFFFFFFF);
  static const Color surfaceAlt    = Color(0xFFF1ECE2);
  static const Color accent        = Color(0xFF7F77DD);
  static const Color accentWarm    = Color(0xFFD4537E);
  static const Color accentGreen   = Color(0xFF3B6D11);
  static const Color textPrimary   = Color(0xFF2C2825);
  static const Color textSecondary = Color(0xFF6B6258);
  static const Color textMuted     = Color(0xFF9C8F7E);
  static const Color divider       = Color(0xFFE8E2D6);
  static const Color tagBg         = Color(0xFFEFEAF9);

  // ── Dark Palette ─────────────────────────────────────────────────────────
  static const Color darkBackground    = Color(0xFF111118);
  static const Color darkSurface       = Color(0xFF1C1C28);
  static const Color darkSurfaceAlt    = Color(0xFF252535);
  static const Color darkAccent        = Color(0xFF9D96F0);
  static const Color darkAccentWarm    = Color(0xFFE06A8E);
  static const Color darkAccentGreen   = Color(0xFF5DA832);
  static const Color darkTextPrimary   = Color(0xFFF0EDE8);
  static const Color darkTextSecondary = Color(0xFFADA8A0);
  static const Color darkTextMuted     = Color(0xFF6E6A65);
  static const Color darkDivider       = Color(0xFF2E2E3E);
  static const Color darkTagBg         = Color(0xFF252040);

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentWarm],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [background, surfaceAlt, background],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ── Light ThemeData ───────────────────────────────────────────────────────
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: background,
    colorScheme: const ColorScheme.light(
      primary: accent,
      secondary: accentWarm,
      surface: surface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textPrimary,
    ),
    textTheme: _buildTextTheme(textPrimary, textSecondary, textMuted),
    appBarTheme: AppBarTheme(
      backgroundColor: background,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary,
      ),
      iconTheme: const IconThemeData(color: textPrimary),
    ),
    inputDecorationTheme: _inputTheme(surfaceAlt, textMuted, textSecondary, accent),
    dividerColor: divider,
    cardColor: surface,
  );

  // ── Dark ThemeData ────────────────────────────────────────────────────────
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: darkAccent,
      secondary: darkAccentWarm,
      surface: darkSurface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: darkTextPrimary,
    ),
    textTheme: _buildTextTheme(darkTextPrimary, darkTextSecondary, darkTextMuted),
    appBarTheme: AppBarTheme(
      backgroundColor: darkBackground,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 18, fontWeight: FontWeight.w600, color: darkTextPrimary,
      ),
      iconTheme: const IconThemeData(color: darkTextPrimary),
    ),
    inputDecorationTheme: _inputTheme(darkSurfaceAlt, darkTextMuted, darkTextSecondary, darkAccent),
    dividerColor: darkDivider,
    cardColor: darkSurface,
  );

  static TextTheme _buildTextTheme(Color primary, Color secondary, Color muted) =>
    TextTheme(
      displayLarge: GoogleFonts.spaceGrotesk(fontSize: 40, fontWeight: FontWeight.w700, color: primary, letterSpacing: -1.5),
      displayMedium: GoogleFonts.spaceGrotesk(fontSize: 32, fontWeight: FontWeight.w700, color: primary, letterSpacing: -1.0),
      displaySmall: GoogleFonts.spaceGrotesk(fontSize: 24, fontWeight: FontWeight.w600, color: primary, letterSpacing: -0.5),
      headlineMedium: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w600, color: primary),
      headlineSmall: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w600, color: primary),
      bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: secondary, height: 1.6),
      bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: secondary, height: 1.5),
      bodySmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, color: muted),
      labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: primary, letterSpacing: 0.5),
    );

  static InputDecorationTheme _inputTheme(Color fill, Color hint, Color label, Color focused) =>
    InputDecorationTheme(
      filled: true,
      fillColor: fill,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: focused, width: 1.5)),
      hintStyle: GoogleFonts.inter(color: hint, fontSize: 14),
      labelStyle: GoogleFonts.inter(color: label, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
    );
}
