import 'package:flutter/material.dart';


class C {
  C._();
  // ── Core ──────────────────────────────────────────────────
  static const ink = Color(0xFF0A0A0A); // Near-black text & primary
  static const canvas = Color(0xFFFAFAFA); // App background
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  // ── Brand Gold ────────────────────────────────────────────
  static const gold = Color(0xFFC4A265); // Champagne gold — main accent
  static const goldLight = Color(0xFFF5EDD8); // Gold tint for backgrounds
  static const goldDark = Color(0xFF8B6F3E); // Deep gold for pressed states
  // ── Neutrals ──────────────────────────────────────────────
  static const n50 = Color(0xFFFAFAFA);
  static const n100 = Color(0xFFF5F5F5);
  static const n200 = Color(0xFFE8E8E8);
  static const n300 = Color(0xFFD4D4D4);
  static const n400 = Color(0xFFA3A3A3);
  static const n500 = Color(0xFF737373);
  static const n600 = Color(0xFF525252);
  static const n700 = Color(0xFF404040);
  static const n800 = Color(0xFF262626);
  static const n900 = Color(0xFF171717);
  // ── Semantic ──────────────────────────────────────────────
  static const success = Color(0xFF22C55E);
  static const error = Color(0xFFEF4444);
  static const warning = Color(0xFFF59E0B);
  // ── Utility ───────────────────────────────────────────────
  static const surface = Color(0xFFFFFFFF);
  static const border = Color(0xFFE8E8E8);
  static const shadow = Color(0x08000000);
  static const shadowMd = Color(0x12000000);

  // ── Gradients ─────────────────────────────────────────────
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
