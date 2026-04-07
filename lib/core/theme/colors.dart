import 'package:flutter/material.dart';

class C {
  C._();

  static const LinearGradient inkGrad = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A1A1A), Color(0xFF0A0A0A)],
  );
  
  static const LinearGradient goldGrad = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD4A96A), Color(0xFFC4A265), Color(0xFF8B6F3E)],
  );
  
  static const LinearGradient heroGrad = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Color(0xE0000000)],
    stops: [0.3, 1.0],
  );
}

class AppColors extends ThemeExtension<AppColors> {
  final Color ink;
  final Color canvas;
  final Color white;
  final Color black;
  final Color gold;
  final Color goldLight;
  final Color goldDark;
  final Color n50;
  final Color n100;
  final Color n200;
  final Color n300;
  final Color n400;
  final Color n500;
  final Color n600;
  final Color n700;
  final Color n800;
  final Color n900;
  final Color success;
  final Color error;
  final Color warning;
  final Color surface;
  final Color border;
  final Color shadow;
  final Color shadowMd;

  const AppColors({
    required this.ink,
    required this.canvas,
    required this.white,
    required this.black,
    required this.gold,
    required this.goldLight,
    required this.goldDark,
    required this.n50,
    required this.n100,
    required this.n200,
    required this.n300,
    required this.n400,
    required this.n500,
    required this.n600,
    required this.n700,
    required this.n800,
    required this.n900,
    required this.success,
    required this.error,
    required this.warning,
    required this.surface,
    required this.border,
    required this.shadow,
    required this.shadowMd,
  });

  factory AppColors.light() => const AppColors(
    ink: Color(0xFF0A0A0A),
    canvas: Color(0xFFFFFFFF),
    white: Color(0xFFFFFFFF),
    black: Color(0xFF000000),
    gold: Color(0xFFC4A265),
    goldLight: Color(0xFFF5EDD8),
    goldDark: Color(0xFF8B6F3E),
    n50: Color(0xFFFAFAFA),
    n100: Color(0xFFF5F5F5),
    n200: Color(0xFFE8E8E8),
    n300: Color(0xFFD4D4D4),
    n400: Color(0xFFA3A3A3),
    n500: Color(0xFF737373),
    n600: Color(0xFF525252),
    n700: Color(0xFF404040),
    n800: Color(0xFF262626),
    n900: Color(0xFF171717),
    success: Color(0xFF22C55E),
    error: Color(0xFFEF4444),
    warning: Color(0xFFF59E0B),
    surface: Color(0xFFFFFFFF),
    border: Color(0xFFE8E8E8),
    shadow: Color(0x08000000),
    shadowMd: Color(0x12000000),
  );

  factory AppColors.dark() => const AppColors(
    ink: Color(0xFFF5F5F5),
    canvas: Color(0xFF0A0A0A),
    white: Color(0xFF171717),
    black: Color(0xFFFFFFFF),
    gold: Color(0xFFD4A96A),
    goldLight: Color(0xFF382D1D),
    goldDark: Color(0xFFE3C38B),
    n50: Color(0xFF121212),
    n100: Color(0xFF1A1A1A),
    n200: Color(0xFF262626),
    n300: Color(0xFF404040),
    n400: Color(0xFF525252),
    n500: Color(0xFF737373),
    n600: Color(0xFFA3A3A3),
    n700: Color(0xFFD4D4D4),
    n800: Color(0xFFE8E8E8),
    n900: Color(0xFFF5F5F5),
    success: Color(0xFF22C55E),
    error: Color(0xFFEF4444),
    warning: Color(0xFFF59E0B),
    surface: Color(0xFF171717),
    border: Color(0xFF262626),
    shadow: Color(0x20000000),
    shadowMd: Color(0x40000000),
  );

  @override
  AppColors copyWith({
    Color? ink,
    Color? canvas,
    Color? white,
    Color? black,
    Color? gold,
    Color? goldLight,
    Color? goldDark,
    Color? n50,
    Color? n100,
    Color? n200,
    Color? n300,
    Color? n400,
    Color? n500,
    Color? n600,
    Color? n700,
    Color? n800,
    Color? n900,
    Color? success,
    Color? error,
    Color? warning,
    Color? surface,
    Color? border,
    Color? shadow,
    Color? shadowMd,
  }) {
    return AppColors(
      ink: ink ?? this.ink,
      canvas: canvas ?? this.canvas,
      white: white ?? this.white,
      black: black ?? this.black,
      gold: gold ?? this.gold,
      goldLight: goldLight ?? this.goldLight,
      goldDark: goldDark ?? this.goldDark,
      n50: n50 ?? this.n50,
      n100: n100 ?? this.n100,
      n200: n200 ?? this.n200,
      n300: n300 ?? this.n300,
      n400: n400 ?? this.n400,
      n500: n500 ?? this.n500,
      n600: n600 ?? this.n600,
      n700: n700 ?? this.n700,
      n800: n800 ?? this.n800,
      n900: n900 ?? this.n900,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      surface: surface ?? this.surface,
      border: border ?? this.border,
      shadow: shadow ?? this.shadow,
      shadowMd: shadowMd ?? this.shadowMd,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      ink: Color.lerp(ink, other.ink, t)!,
      canvas: Color.lerp(canvas, other.canvas, t)!,
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      gold: Color.lerp(gold, other.gold, t)!,
      goldLight: Color.lerp(goldLight, other.goldLight, t)!,
      goldDark: Color.lerp(goldDark, other.goldDark, t)!,
      n50: Color.lerp(n50, other.n50, t)!,
      n100: Color.lerp(n100, other.n100, t)!,
      n200: Color.lerp(n200, other.n200, t)!,
      n300: Color.lerp(n300, other.n300, t)!,
      n400: Color.lerp(n400, other.n400, t)!,
      n500: Color.lerp(n500, other.n500, t)!,
      n600: Color.lerp(n600, other.n600, t)!,
      n700: Color.lerp(n700, other.n700, t)!,
      n800: Color.lerp(n800, other.n800, t)!,
      n900: Color.lerp(n900, other.n900, t)!,
      success: Color.lerp(success, other.success, t)!,
      error: Color.lerp(error, other.error, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      border: Color.lerp(border, other.border, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      shadowMd: Color.lerp(shadowMd, other.shadowMd, t)!,
    );
  }
}

extension ThemeContext on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
