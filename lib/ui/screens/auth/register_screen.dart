import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:aura_app/core/theme/colors.dart';
import 'package:aura_app/providers/auth_provider.dart';
import 'package:aura_app/ui/widgets/shared_buttons.dart';
import 'package:aura_app/ui/widgets/brand.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegState();
}

class _RegState extends ConsumerState<RegisterScreen> {
  final _fk = GlobalKey<FormState>();
  final _nc = TextEditingController();
  final _ec = TextEditingController();
  final _pc = TextEditingController();
  final _cc = TextEditingController();
  bool _hp = true, _hc = true, _load = false, _agreed = false;

  @override
  void dispose() {
    _nc.dispose();
    _ec.dispose();
    _pc.dispose();
    _cc.dispose();
    super.dispose();
  }

  Future<void> _reg() async {
    if (!_fk.currentState!.validate()) return;
    if (!_agreed) {
      snack(context, 'Please agree to Terms', err: true);
      return;
    }
    setState(() => _load = true);
    await ref
        .read(authProvider.notifier)
        .signUp(_nc.text.trim(), _ec.text.trim(), _pc.text);
    if (mounted) setState(() => _load = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.colors.white,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            backgroundColor: context.colors.white,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                onPressed: () => context.pop()),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 0, 28, 48),
              child: Form(
                  key: _fk,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const NoirLogo(),
                        const SizedBox(height: 20),
                        Text('Create Account',
                                style: GoogleFonts.cormorantGaramond(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    color: context.colors.ink))
                            .animate()
                            .fadeIn()
                            .slideX(begin: -0.15, end: 0),
                        const SizedBox(height: 6),
                        Text('Join NOIR and discover your style',
                                style: GoogleFonts.dmSans(
                                    fontSize: 14, color: context.colors.n500))
                            .animate()
                            .fadeIn(delay: 100.ms),
                        const SizedBox(height: 32),
                        const FieldLabel('Full Name'),
                        const SizedBox(height: 6),
                        TextFormField(
                            controller: _nc,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                hintText: 'Your name',
                                prefixIcon:
                                    Icon(Icons.person_outline, size: 19)),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Name required';
                              }
                              return null;
                            }),
                        const SizedBox(height: 16),
                        const FieldLabel('Email'),
                        const SizedBox(height: 6),
                        TextFormField(
                            controller: _ec,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                hintText: 'your@email.com',
                                prefixIcon:
                                    Icon(Icons.email_outlined, size: 19)),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Email required';
                              }
                              if (!v.contains('@')) return 'Invalid email';
                              return null;
                            }),
                        const SizedBox(height: 16),
                        const FieldLabel('Password'),
                        const SizedBox(height: 6),
                        TextFormField(
                            controller: _pc,
                            obscureText: _hp,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                hintText: '••••••••',
                                prefixIcon:
                                    const Icon(Icons.lock_outline, size: 19),
                                suffixIcon: IconButton(
                                    icon: Icon(
                                        _hp
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: context.colors.n400),
                                    onPressed: () =>
                                        setState(() => _hp = !_hp))),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Password required';
                              }
                              if (v.length < 6) return 'Minimum 6 characters';
                              return null;
                            }),
                        const SizedBox(height: 16),
                        const FieldLabel('Confirm Password'),
                        const SizedBox(height: 6),
                        TextFormField(
                            controller: _cc,
                            obscureText: _hc,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                hintText: '••••••••',
                                prefixIcon:
                                    const Icon(Icons.lock_outline, size: 19),
                                suffixIcon: IconButton(
                                    icon: Icon(
                                        _hc
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: context.colors.n400),
                                    onPressed: () =>
                                        setState(() => _hc = !_hc))),
                            validator: (v) {
                              if (v != _pc.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            }),
                        const SizedBox(height: 20),
                        Row(children: [
                          Checkbox(
                              value: _agreed,
                              onChanged: (v) =>
                                  setState(() => _agreed = v ?? false)),
                          Expanded(
                              child: RichText(
                                  text: TextSpan(
                                      text: 'I agree to the ',
                                      style: GoogleFonts.dmSans(
                                          fontSize: 13, color: context.colors.n600),
                                      children: [
                                TextSpan(
                                    text: 'Terms of Service',
                                    style: TextStyle(
                                        color: context.colors.gold,
                                        fontWeight: FontWeight.w600)),
                                const TextSpan(text: ' & '),
                                TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                        color: context.colors.gold,
                                        fontWeight: FontWeight.w600)),
                              ]))),
                        ]),
                        const SizedBox(height: 24),
                        Btn(
                                text: 'Create Account',
                                loading: _load,
                                onPressed: _reg)
                            .animate()
                            .fadeIn(delay: 400.ms),
                        const SizedBox(height: 24),
                        Center(
                            child: RichText(
                                text: TextSpan(
                          text: 'Already have an account? ',
                          style:
                              GoogleFonts.dmSans(fontSize: 14, color: context.colors.n500),
                          children: [
                            WidgetSpan(
                                child: GestureDetector(
                              onTap: () => context.pop(),
                              child: Text('Sign In',
                                  style: GoogleFonts.dmSans(
                                      fontSize: 14,
                                      color: context.colors.gold,
                                      fontWeight: FontWeight.w700)),
                            ))
                          ],
                        ))),
                      ])),
            ),
          ),
        ]),
      );
}
