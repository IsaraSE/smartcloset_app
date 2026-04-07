import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aura_app/core/theme/colors.dart';
import 'package:aura_app/providers/auth_provider.dart';
import 'package:aura_app/providers/wishlist_provider.dart';
import 'package:aura_app/providers/orders_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext ctx, WidgetRef ref) {
    final user = ref.watch(authProvider).valueOrNull;
    return Scaffold(
      backgroundColor: C.canvas,
      appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: C.white,
          automaticallyImplyLeading: false),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            // Profile card
            Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                    color: C.ink, borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  Container(
                      width: 58,
                      height: 58,
                      decoration: const BoxDecoration(
                          color: C.gold, shape: BoxShape.circle),
                      child: Center(
                          child: Text(
                              user?.name.isNotEmpty == true
                                  ? user!.name[0].toUpperCase()
                                  : '?',
                              style: GoogleFonts.cormorantGaramond(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: C.white)))),
                  const SizedBox(width: 16),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(user?.name ?? 'Guest',
                            style: GoogleFonts.cormorantGaramond(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: C.white)),
                        Text(user?.email ?? '',
                            style: GoogleFonts.dmSans(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.6))),
                        const SizedBox(height: 8),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                                color: C.gold.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: C.gold.withOpacity(0.4))),
                            child: Text('NOIR Member',
                                style: GoogleFonts.dmSans(
                                    color: C.gold,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600))),
                      ])),
                ])),
            const SizedBox(height: 14),

            // Stats
            Row(children: [
              _StatCard('Orders', ref.watch(ordersProvider).length.toString(),
                  Icons.receipt_long_outlined),
              const SizedBox(width: 12),
              _StatCard('Saved', ref.watch(wishlistProvider).length.toString(),
                  Icons.favorite_border_rounded),
              const SizedBox(width: 12),
              const _StatCard('Points', '1,240', Icons.star_border_rounded),
            ]),
            const SizedBox(height: 16),

            _MenuSection('Shopping', [
              _MenuItem(Icons.receipt_long_outlined, 'My Orders',
                  () => ctx.push('/orders')),
              _MenuItem(Icons.favorite_border_rounded, 'Saved Items',
                  () => ctx.go('/wishlist')),
              _MenuItem(Icons.location_on_outlined, 'Addresses', () {}),
              _MenuItem(Icons.local_offer_outlined, 'Promo Codes', () {}),
            ]),
            const SizedBox(height: 14),
            _MenuSection('Features', [
              _MenuItem(Icons.camera_alt_outlined, 'Virtual Try-On',
                  () => ctx.push('/try-on')),
              _MenuItem(Icons.qr_code_scanner_rounded, 'Rack Scanner',
                  () => ctx.push('/qr-scanner')),
            ]),
            const SizedBox(height: 14),
            _MenuSection('Account', [
              _MenuItem(
                  Icons.notifications_none_rounded, 'Notifications', () {}),
              _MenuItem(Icons.help_outline_rounded, 'Help & Support', () {}),
              _MenuItem(Icons.info_outline_rounded, 'About NOIR', () {}),
            ]),
            const SizedBox(height: 14),
            Container(
                decoration: BoxDecoration(
                    color: C.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: C.border),
                    boxShadow: const [
                      BoxShadow(color: C.shadow, blurRadius: 6)
                    ]),
                child: ListTile(
                    leading: const Icon(Icons.logout_rounded, color: C.error),
                    title: Text('Sign Out',
                        style: GoogleFonts.dmSans(
                            color: C.error, fontWeight: FontWeight.w600)),
                    onTap: () => ref.read(authProvider.notifier).signOut())),
            const SizedBox(height: 32),
          ])),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label, val;
  final IconData ic;
  const _StatCard(this.label, this.val, this.ic);

  @override
  Widget build(BuildContext ctx) => Expanded(
      child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: C.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: C.border),
              boxShadow: const [BoxShadow(color: C.shadow, blurRadius: 6)]),
          child: Column(children: [
            Icon(ic, color: C.gold, size: 22),
            const SizedBox(height: 6),
            Text(val,
                style: GoogleFonts.cormorantGaramond(
                    fontWeight: FontWeight.w700, fontSize: 20, color: C.ink)),
            Text(label, style: GoogleFonts.dmSans(fontSize: 11, color: C.n500)),
          ])));
}

Widget _MenuSection(String title, List<Widget> items) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(title.toUpperCase(),
              style: GoogleFonts.dmSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: C.n400,
                  letterSpacing: 1))),
      Container(
          decoration: BoxDecoration(
              color: C.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: C.border),
              boxShadow: const [BoxShadow(color: C.shadow, blurRadius: 6)]),
          child: Column(
              children: items
                  .asMap()
                  .entries
                  .map((e) => Column(children: [
                        e.value,
                        if (e.key < items.length - 1)
                          const Divider(height: 1, indent: 52),
                      ]))
                  .toList())),
    ]);

class _MenuItem extends StatelessWidget {
  final IconData ic;
  final String label;
  final VoidCallback onTap;
  const _MenuItem(this.ic, this.label, this.onTap);

  @override
  Widget build(BuildContext ctx) => ListTile(
      leading: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
              color: C.goldLight, borderRadius: BorderRadius.circular(8)),
          child: Icon(ic, color: C.gold, size: 18)),
      title: Text(label,
          style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w500)),
      trailing:
          const Icon(Icons.chevron_right_rounded, color: C.n300, size: 20),
      onTap: onTap);
}
