import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aura_app/core/theme/colors.dart';
import 'package:aura_app/providers/wishlist_provider.dart';
import 'package:aura_app/ui/widgets/empty_view.dart';
import 'package:aura_app/ui/widgets/product_card.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(wishlistProvider);
    return Scaffold(
      backgroundColor: context.colors.canvas,
      appBar: AppBar(
          title: Text('Saved (${items.length})',
              style: GoogleFonts.cormorantGaramond(
                  fontSize: 20, fontWeight: FontWeight.w700)),
          backgroundColor: context.colors.white,
          automaticallyImplyLeading: false),
      body: items.isEmpty
          ? EmptyView(
              icon: Icons.favorite_border_rounded,
              title: 'Nothing saved yet',
              desc: 'Tap ♡ on any item to save it here.',
              btnLabel: 'Explore Now',
              onBtn: () => context.go('/explore'))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12),
              itemCount: items.length,
              itemBuilder: (_, i) =>
                  RepaintBoundary(child: ProductCard(items[i]))),
    );
  }
}
