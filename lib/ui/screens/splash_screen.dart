import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aura_app/core/theme/colors.dart';
import 'package:aura_app/providers/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashState();
}

class _SplashState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<double> _scale;
  late Animation<double> _taglineFade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400));

    _fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _ctrl, curve: const Interval(0, 0.5, curve: Curves.easeOut)));

    _scale = Tween<double>(begin: 0.88, end: 1).animate(CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0, 0.6, curve: Curves.easeOutBack)));

    _taglineFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _ctrl, curve: const Interval(0.5, 1.0, curve: Curves.easeOut)));

    _ctrl.forward();

    // Navigate after auth check
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (!mounted) return;
      final auth = ref.read(authProvider).valueOrNull;
      if (auth != null) {
        context.go('/');
      } else {
        context.go('/login');
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.colors.ink,
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // ── Logo ─────────────────────────────────────────────
            FadeTransition(
              opacity: _fade,
              child: ScaleTransition(
                scale: _scale,
                child: Column(children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: context.colors.gold,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                            color: context.colors.gold.withOpacity(0.4),
                            blurRadius: 32,
                            spreadRadius: 4)
                      ],
                    ),
                    child: Center(
                        child: Text('N',
                            style: GoogleFonts.cormorantGaramond(
                                color: context.colors.white,
                                fontSize: 46,
                                fontWeight: FontWeight.w700))),
                  ),
                  const SizedBox(height: 18),
                  Text('NOIR',
                      style: GoogleFonts.dmSans(
                          color: context.colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 10)),
                ]),
              ),
            ),
            const SizedBox(height: 12),
            // ── Tagline ───────────────────────────────────────────
            FadeTransition(
                opacity: _taglineFade,
                child: Text('Premium Fashion',
                    style: GoogleFonts.cormorantGaramond(
                        color: context.colors.gold.withOpacity(0.8),
                        fontSize: 14,
                        letterSpacing: 3,
                        fontStyle: FontStyle.italic))),
            const SizedBox(height: 64),
            // ── Loader ────────────────────────────────────────────
            FadeTransition(
                opacity: _fade,
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    valueColor: AlwaysStoppedAnimation(context.colors.gold.withOpacity(0.7)),
                  ),
                )),
          ]),
        ),
      );
}
