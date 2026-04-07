import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:noir_app/core/theme/colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.canvas,
      appBar: AppBar(
        title: const Text('About NOIR'),
        backgroundColor: context.colors.white,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            // Logo
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  color: context.colors.gold, borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text('N',
                      style: GoogleFonts.cormorantGaramond(
                          color: context.colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.w700))),
            ),
            const SizedBox(height: 16),
            Text('NOIR Fashion',
                style: GoogleFonts.dmSans(
                    fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: 2)),
            Text('Version 1.0.0 (Build 124)',
                style: GoogleFonts.dmSans(fontSize: 12, color: context.colors.n400)),

            const SizedBox(height: 48),

            // Story
            const _AboutSection(
              title: 'Our Story',
              content:
                  'Founded in 2025, NOIR was born from a vision to blend high-fashion elegance with modern accessibility. We believe that true style is timeless and that every individual deserves to feel premium, every day.',
            ),

            const SizedBox(height: 32),

            // Links
            _LinkTile('Privacy Policy', () {}),
            _LinkTile('Terms of Service', () {}),
            _LinkTile('Cookie Policy', () {}),
            _LinkTile('Licenses', () {}),

            const SizedBox(height: 48),

            // Socials
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _SocialIcon(Icons.facebook_outlined),
              SizedBox(width: 24),
              _SocialIcon(Icons.camera_alt_outlined),
              SizedBox(width: 24),
              _SocialIcon(Icons.mail_outline_rounded),
            ]),

            const SizedBox(height: 32),
            Text('© 2025 NOIR Premium Store. All Rights Reserved.',
                style: GoogleFonts.dmSans(fontSize: 10, color: context.colors.n400)),
          ])),
    );
  }
}

class _AboutSection extends StatelessWidget {
  final String title, content;
  const _AboutSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(),
              style: GoogleFonts.dmSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: context.colors.gold,
                  letterSpacing: 1.5)),
          const SizedBox(height: 12),
          Text(content,
              style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: context.colors.n700,
                  height: 1.6,
                  fontWeight: FontWeight.w400)),
        ],
      );
}

class _LinkTile extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _LinkTile(this.label, this.onTap);

  @override
  Widget build(BuildContext context) => ListTile(
      title: Text(label,
          style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w500)),
      trailing:
          Icon(Icons.chevron_right_rounded, color: context.colors.n300, size: 20));
}

class _SocialIcon extends StatelessWidget {
  final IconData ic;
  const _SocialIcon(this.ic);

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: context.colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: context.colors.border)),
      child: Icon(ic, size: 20, color: context.colors.n800));
}
