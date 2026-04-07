import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aura_app/core/theme/colors.dart';

ThemeData buildTheme() {
  // Cormorant Garamond for display — editorial, luxury feel
  // DM Sans for body — clean, modern, readable
  TextStyle dm(double sz, FontWeight w, Color col,
          {double ls = 0, double? h}) =>
      GoogleFonts.dmSans(
          fontSize: sz,
          fontWeight: w,
          color: col,
          letterSpacing: ls,
          height: h);

  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: C.ink,
      primary: C.ink,
      secondary: C.gold,
      surface: C.white,
      error: C.error,
      onPrimary: C.white,
      onSecondary: C.ink,
      onSurface: C.ink,
    ),
    scaffoldBackgroundColor: C.canvas,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.cormorantGaramond(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: C.ink,
          height: 1.1,
          letterSpacing: -0.5),
      displayMedium: GoogleFonts.cormorantGaramond(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: C.ink,
          height: 1.15),
      displaySmall: GoogleFonts.cormorantGaramond(
          fontSize: 24, fontWeight: FontWeight.w600, color: C.ink),
      headlineLarge: dm(20, FontWeight.w700, C.ink),
      headlineMedium: dm(18, FontWeight.w600, C.ink),
      headlineSmall: dm(16, FontWeight.w600, C.ink),
      titleLarge: dm(16, FontWeight.w600, C.ink),
      titleMedium: dm(14, FontWeight.w500, C.ink),
      titleSmall: dm(12, FontWeight.w500, C.n700),
      bodyLarge: dm(16, FontWeight.w400, C.n800, h: 1.6),
      bodyMedium: dm(14, FontWeight.w400, C.n700, h: 1.55),
      bodySmall: dm(12, FontWeight.w400, C.n500),
      labelLarge: dm(14, FontWeight.w600, C.white, ls: 0.5),
      labelMedium: dm(12, FontWeight.w500, C.n600),
      labelSmall: dm(10, FontWeight.w500, C.n500, ls: 0.5),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: C.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: const IconThemeData(color: C.ink, size: 22),
      titleTextStyle: GoogleFonts.dmSans(
          fontSize: 17, fontWeight: FontWeight.w700, color: C.ink),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: C.ink,
        foregroundColor: C.white,
        elevation: 0,
        disabledBackgroundColor: C.n200,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        textStyle: GoogleFonts.dmSans(
            fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: C.ink,
        side: const BorderSide(color: C.ink, width: 1),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        textStyle:
            GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: C.n100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: C.border)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: C.ink, width: 1.5)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: C.error)),
      hintStyle: GoogleFonts.dmSans(fontSize: 14, color: C.n400),
      labelStyle: GoogleFonts.dmSans(fontSize: 14, color: C.n500),
    ),
    cardTheme: CardThemeData(
      color: C.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      margin: EdgeInsets.zero,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: C.ink,
      contentTextStyle: GoogleFonts.dmSans(color: C.white, fontSize: 13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      behavior: SnackBarBehavior.floating,
    ),
    dividerTheme:
        const DividerThemeData(color: C.border, thickness: 1, space: 1),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? C.ink : C.n200),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: C.gold),
    sliderTheme: const SliderThemeData(
        activeTrackColor: C.ink, thumbColor: C.ink, inactiveTrackColor: C.n200),
  );
}
