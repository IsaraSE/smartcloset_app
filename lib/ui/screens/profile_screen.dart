import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aura_app/core/theme/colors.dart';
import 'package:aura_app/providers/theme_provider.dart';
import 'package:aura_app/providers/auth_provider.dart';
import 'package:aura_app/providers/wishlist_provider.dart';
import 'package:aura_app/providers/orders_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).valueOrNull;
    return Scaffold(
      backgroundColor: context.colors.canvas,
      appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: context.colors.white,
          automaticallyImplyLeading: false),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            // Profile card
            Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                    color: context.colors.ink, borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                          color: context.colors.gold, shape: BoxShape.circle),
                      child: Center(
                          child: Text(
                              user?.name.isNotEmpty == true
                                  ? user!.name[0].toUpperCase()
                                  : '?',
                              style: GoogleFonts.cormorantGaramond(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: context.colors.white)))),
                  const SizedBox(width: 16),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(user?.name ?? 'Guest',
                            style: GoogleFonts.cormorantGaramond(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: context.colors.white)),
                        Text(user?.email ?? '',
                            style: GoogleFonts.dmSans(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.6))),
                        const SizedBox(height: 8),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                                color: context.colors.gold.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: context.colors.gold.withValues(alpha: 0.4))),
                            child: Text('NOIR Member',
                                style: GoogleFonts.dmSans(
                                    color: context.colors.gold,
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

            _menuSection(context, 'Shopping', [
              _MenuItem(Icons.receipt_long_outlined, 'My Orders',
                  () => context.push('/orders')),
              _MenuItem(Icons.favorite_border_rounded, 'Saved Items',
                  () => context.go('/wishlist')),
              _MenuItem(Icons.location_on_outlined, 'Addresses',
                  () => context.push('/addresses')),
              _MenuItem(Icons.local_offer_outlined, 'Promo Codes',
                  () => context.push('/promo-codes')),
            ]),
            const SizedBox(height: 14),
            _menuSection(context, 'Features', [
              _MenuItem(Icons.camera_alt_outlined, 'Virtual Try-On',
                  () => context.push('/try-on')),
              _MenuItem(Icons.qr_code_scanner_rounded, 'Rack Scanner',
                  () => context.push('/qr-scanner')),
            ]),
            const SizedBox(height: 14),
            _menuSection(context, 'Account', [
              _MenuItem(Icons.notifications_none_rounded, 'Notifications',
                  () => context.push('/notifications')),
              _MenuItem(Icons.dark_mode_outlined, 'Toggle Theme Mode', () {
                ref.read(themeProvider.notifier).toggleMode();
              }),
              _MenuItem(Icons.help_outline_rounded, 'Help & Support',
                  () => context.push('/help')),
              _MenuItem(Icons.info_outline_rounded, 'About NOIR',
                  () => context.push('/about')),
            ]),
            const SizedBox(height: 14),
            Container(
                decoration: BoxDecoration(
                    color: context.colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: context.colors.border),
                    boxShadow: [
                      BoxShadow(color: context.colors.shadow, blurRadius: 6)
                    ]),
                child: ListTile(
                    leading: Icon(Icons.logout_rounded, color: context.colors.error),
                    title: Text('Sign Out',
                        style: GoogleFonts.dmSans(
                            color: context.colors.error, fontWeight: FontWeight.w600)),
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
  Widget build(BuildContext context) => Expanded(
      child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: context.colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.colors.border),
              boxShadow: [BoxShadow(color: context.colors.shadow, blurRadius: 6)]),
          child: Column(children: [
            Icon(ic, color: context.colors.gold, size: 22),
            const SizedBox(height: 6),
            Text(val,
                style: GoogleFonts.cormorantGaramond(
                    fontWeight: FontWeight.w700, fontSize: 20, color: context.colors.ink)),
            Text(label, style: GoogleFonts.dmSans(fontSize: 11, color: context.colors.n500)),
          ])));
}

Widget _menuSection(BuildContext context, String title, List<Widget> items) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(title.toUpperCase(),
              style: GoogleFonts.dmSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: context.colors.n400,
                  letterSpacing: 1))),
      Container(
          decoration: BoxDecoration(
              color: context.colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.colors.border),
              boxShadow: [BoxShadow(color: context.colors.shadow, blurRadius: 6)]),
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
  Widget build(BuildContext context) => ListTile(
      leading: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
              color: context.colors.goldLight, borderRadius: BorderRadius.circular(8)),
          child: Icon(ic, color: context.colors.gold, size: 18)),
      title: Text(label,
          style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w500)),
      trailing:
          Icon(Icons.chevron_right_rounded, color: context.colors.n300, size: 20),
      onTap: onTap);
}
