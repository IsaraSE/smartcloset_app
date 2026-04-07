import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:noir_app/core/theme/colors.dart';

ThemeData buildTheme() => _build(AppColors.light(), Brightness.light);
ThemeData buildDarkTheme() => _build(AppColors.dark(), Brightness.dark);

ThemeData _build(AppColors colors, Brightness brightness) {
  TextStyle dm(double sz, FontWeight w, Color col, {double ls = 0, double? h}) =>
      GoogleFonts.dmSans(
          fontSize: sz,
          fontWeight: w,
          color: col,
          letterSpacing: ls,
          height: h);

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: ColorScheme.fromSeed(
      seedColor: colors.ink,
      brightness: brightness,
      primary: colors.ink,
      secondary: colors.gold,
      surface: colors.white,
      error: colors.error,
      onPrimary: colors.canvas,
      onSecondary: colors.white,
      onSurface: colors.ink,
    ),
    scaffoldBackgroundColor: colors.canvas,
    extensions: [colors],
    textTheme: TextTheme(
      displayLarge: GoogleFonts.cormorantGaramond(
          fontSize: 36, fontWeight: FontWeight.w700, color: colors.ink, height: 1.1, letterSpacing: -0.5),
      displayMedium: GoogleFonts.cormorantGaramond(
          fontSize: 28, fontWeight: FontWeight.w700, color: colors.ink, height: 1.15),
      displaySmall: GoogleFonts.cormorantGaramond(
          fontSize: 24, fontWeight: FontWeight.w600, color: colors.ink),
      headlineLarge: dm(20, FontWeight.w700, colors.ink),
      headlineMedium: dm(18, FontWeight.w600, colors.ink),
      headlineSmall: dm(16, FontWeight.w600, colors.ink),
      titleLarge: dm(16, FontWeight.w600, colors.ink),
      titleMedium: dm(14, FontWeight.w500, colors.ink),
      titleSmall: dm(12, FontWeight.w500, colors.n700),
      bodyLarge: dm(16, FontWeight.w400, colors.n800, h: 1.6),
      bodyMedium: dm(14, FontWeight.w400, colors.n700, h: 1.55),
      bodySmall: dm(12, FontWeight.w400, colors.n500),
      labelLarge: dm(14, FontWeight.w600, colors.canvas, ls: 0.5), 
      labelMedium: dm(12, FontWeight.w500, colors.n600),
      labelSmall: dm(10, FontWeight.w500, colors.n500, ls: 0.5),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: colors.ink, size: 22),
      titleTextStyle: GoogleFonts.dmSans(
          fontSize: 17, fontWeight: FontWeight.w700, color: colors.ink),
      systemOverlayStyle: brightness == Brightness.light ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.ink,
        foregroundColor: colors.canvas,
        elevation: 0,
        disabledBackgroundColor: colors.n200,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        textStyle: GoogleFonts.dmSans(
            fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colors.ink,
        side: BorderSide(color: colors.ink, width: 1),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        textStyle: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colors.n100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: colors.border)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: colors.ink, width: 1.5)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: colors.error)),
      hintStyle: GoogleFonts.dmSans(fontSize: 14, color: colors.n400),
      labelStyle: GoogleFonts.dmSans(fontSize: 14, color: colors.n500),
    ),
    cardTheme: CardThemeData(
      color: colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      margin: EdgeInsets.zero,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: colors.ink,
      contentTextStyle: GoogleFonts.dmSans(color: colors.canvas, fontSize: 13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      behavior: SnackBarBehavior.floating,
    ),
    dividerTheme: DividerThemeData(color: colors.border, thickness: 1, space: 1),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? colors.ink : colors.n200),
      checkColor: WidgetStateProperty.all(colors.canvas),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: colors.gold),
    sliderTheme: SliderThemeData(
        activeTrackColor: colors.ink, thumbColor: colors.ink, inactiveTrackColor: colors.n200),
  );
}
