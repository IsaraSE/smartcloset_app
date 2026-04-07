import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:noir_app/core/theme/colors.dart';
import 'package:noir_app/providers/auth_provider.dart';

class AddressesScreen extends ConsumerWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).valueOrNull;
    final addresses = user?.addresses ?? [];

    return Scaffold(
      backgroundColor: context.colors.canvas,
      appBar: AppBar(
        title: const Text('My Addresses'),
        backgroundColor: context.colors.white,
      ),
      body: addresses.isEmpty
          ? _EmptyAddresses()
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: addresses.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (ctx, i) => _AddressCard(addresses[i]),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Add New Address flow coming soon!')));
        },
        backgroundColor: context.colors.ink,
        child: Icon(Icons.add_rounded, color: context.colors.white),
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final dynamic addr;
  const _AddressCard(this.addr);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: addr.isDefault ? context.colors.gold : context.colors.border,
              width: addr.isDefault ? 1.5 : 1),
          boxShadow: [BoxShadow(color: context.colors.shadow, blurRadius: 6)],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(Icons.home_outlined,
                color: addr.isDefault ? context.colors.gold : context.colors.ink,
                size: 20),
            const SizedBox(width: 10),
            Text(addr.name,
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700, fontSize: 15)),
            const Spacer(),
            if (addr.isDefault)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: context.colors.goldLight,
                    borderRadius: BorderRadius.circular(4)),
                child: Text('DEFAULT',
                    style: GoogleFonts.dmSans(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: context.colors.gold,
                        letterSpacing: 0.5)),
              ),
          ]),
          const SizedBox(height: 12),
          Text(addr.phone,
              style: GoogleFonts.dmSans(fontSize: 13, color: context.colors.n600)),
          const SizedBox(height: 4),
          Text('${addr.line1}${addr.line2 != null ? ", ${addr.line2}" : ""}',
              style: GoogleFonts.dmSans(fontSize: 14, color: context.colors.n800)),
          Text('${addr.city}, ${addr.state} ${addr.zip}',
              style: GoogleFonts.dmSans(fontSize: 14, color: context.colors.n800)),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          Row(children: [
            _ActionBtn(Icons.edit_outlined, 'Edit', () {}),
            const SizedBox(width: 20),
            _ActionBtn(Icons.delete_outline_rounded, 'Delete', () {}),
          ]),
        ]),
      );
}

class _ActionBtn extends StatelessWidget {
  final IconData ic;
  final String label;
  final VoidCallback onTap;
  const _ActionBtn(this.ic, this.label, this.onTap);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Row(children: [
          Icon(ic, size: 16, color: context.colors.n500),
          const SizedBox(width: 6),
          Text(label,
              style: GoogleFonts.dmSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: context.colors.n600)),
        ]),
      );
}

class _EmptyAddresses extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.location_off_outlined, color: context.colors.n200, size: 64),
        const SizedBox(height: 16),
        Text('No Addresses Saved',
            style: GoogleFonts.cormorantGaramond(
                fontSize: 22, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text('Add a delivery address to get started.',
            style: GoogleFonts.dmSans(color: context.colors.n500, fontSize: 14)),
      ]));
}
