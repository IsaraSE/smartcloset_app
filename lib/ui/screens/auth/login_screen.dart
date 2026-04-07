import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:aura_app/core/theme/colors.dart';
import 'package:aura_app/providers/auth_provider.dart';
import 'package:aura_app/ui/widgets/shared_buttons.dart';
import 'package:aura_app/ui/widgets/brand.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginState();
}

class _LoginState extends ConsumerState<LoginScreen> {
  final _fk = GlobalKey<FormState>();
  final _ec = TextEditingController();
  final _pc = TextEditingController();
  bool _hide = true, _loading = false;

  @override
  void dispose() {
    _ec.dispose();
    _pc.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_fk.currentState!.validate()) return;
    setState(() => _loading = true);
    final ok =
        await ref.read(authProvider.notifier).signIn(_ec.text.trim(), _pc.text);
    if (mounted) setState(() => _loading = false);
    if (!ok && mounted) snack(context, 'Invalid credentials', err: true);
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: context.colors.ink,
      body: Stack(children: [
        // ── Fashion image half ──────────────────────────────
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: h * 0.45,
          child: Stack(children: [
            CachedNetworkImage(
              imageUrl:
                  'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=800&q=85',
              fit: BoxFit.cover,
              width: double.infinity,
              height: h * 0.45,
              placeholder: (c, u) => Container(color: context.colors.n800),
              errorWidget: (c, u, e) => Container(color: context.colors.n800),
            ),
            // Dark overlay gradient
            Container(
                decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.black.withValues(alpha: 0.0),
                  context.colors.ink,
                ],
                stops: const [0.0, 0.55, 1.0],
              ),
            )),
            // Logo top-left
            Positioned(
              top: MediaQuery.of(context).padding.top + 20,
              left: 24,
              child: const NoirLogo(size: 32, dark: true)
                  .animate()
                  .fadeIn(duration: 600.ms),
            ),
          ]),
        ),

        // ── Form card ──────────────────────────────────────
        Positioned(
          top: h * 0.38,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: context.colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 32, 28, 40),
              child: Form(
                key: _fk,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome back',
                          style: GoogleFonts.cormorantGaramond(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: context.colors.ink)),
                      const SizedBox(height: 4),
                      Text('Sign in to continue',
                          style:
                              GoogleFonts.dmSans(fontSize: 14, color: context.colors.n500)),
                      const SizedBox(height: 28),

                      // Email
                      const FieldLabel('Email address'),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _ec,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.dmSans(fontSize: 14, color: context.colors.ink),
                        decoration: InputDecoration(
                          hintText: 'your@email.com',
                          prefixIcon: Icon(Icons.email_outlined,
                              size: 19, color: context.colors.n400),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Email required';
                          if (!v.contains('@')) return 'Invalid email';
                          return null;
                        },
                      )
                          .animate()
                          .fadeIn(delay: 150.ms)
                          .slideY(begin: 0.1, end: 0),
                      const SizedBox(height: 16),

                      // Password
                      const FieldLabel('Password'),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _pc,
                        obscureText: _hide,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _login(),
                        style: GoogleFonts.dmSans(fontSize: 14, color: context.colors.ink),
                        decoration: InputDecoration(
                          hintText: '••••••••',
                          prefixIcon: Icon(Icons.lock_outline,
                              size: 19, color: context.colors.n400),
                          suffixIcon: IconButton(
                              icon: Icon(
                                  _hide
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: context.colors.n400,
                                  size: 19),
                              onPressed: () => setState(() => _hide = !_hide)),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Password required';
                          }
                          if (v.length < 6) return 'Minimum 6 characters';
                          return null;
                        },
                      )
                          .animate()
                          .fadeIn(delay: 220.ms)
                          .slideY(begin: 0.1, end: 0),

                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                foregroundColor: context.colors.gold,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8)),
                            child: Text('Forgot password?',
                                style: GoogleFonts.dmSans(
                                    fontSize: 13, fontWeight: FontWeight.w500)),
                          )),
                      const SizedBox(height: 4),

                      // Sign in button
                      Btn(text: 'Sign In', loading: _loading, onPressed: _login)
                          .animate()
                          .fadeIn(delay: 300.ms),
                      const SizedBox(height: 20),

                      // Divider
                      Row(children: [
                        const Expanded(child: Divider()),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text('or',
                                style: GoogleFonts.dmSans(
                                    fontSize: 13, color: context.colors.n400))),
                        const Expanded(child: Divider()),
                      ]),
                      const SizedBox(height: 20),

                      // Google
                      SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton(
                            onPressed: _loading
                                ? null
                                : ref
                                    .read(authProvider.notifier)
                                    .signInWithGoogle,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 20,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color(0xFF4285F4),
                                            Color(0xFF34A853),
                                            Color(0xFFFBBC05),
                                            Color(0xFFEA4335)
                                          ]),
                                          shape: BoxShape.circle),
                                      child: Center(
                                          child: Text('G',
                                              style: TextStyle(
                                                  color: context.colors.white,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 11)))),
                                  const SizedBox(width: 10),
                                  Text('Continue with Google',
                                      style: GoogleFonts.dmSans(
                                          color: context.colors.ink,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14)),
                                ]),
                          )).animate().fadeIn(delay: 380.ms),

                      const SizedBox(height: 28),
                      Center(
                          child: RichText(
                              text: TextSpan(
                        text: "Don't have an account? ",
                        style: GoogleFonts.dmSans(fontSize: 14, color: context.colors.n500),
                        children: [
                          WidgetSpan(
                              child: GestureDetector(
                            onTap: () => context.push('/register'),
                            child: Text('Create Account',
                                style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    color: context.colors.gold,
                                    fontWeight: FontWeight.w700)),
                          ))
                        ],
                      ))),
                    ]),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

// FieldLabel moved to shared_buttons.dart
