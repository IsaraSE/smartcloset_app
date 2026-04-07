import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:noir_app/core/theme/colors.dart';
import 'package:noir_app/core/constants/mock_data.dart';
import 'package:noir_app/ui/widgets/empty_view.dart';
import 'package:noir_app/ui/widgets/product_card.dart';

class RackProductsScreen extends ConsumerWidget {
  final String rackId;
  final Object? extra;
  const RackProductsScreen({super.key, required this.rackId, this.extra});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rackName =
        extra is String ? extra as String : kRackNames[rackId] ?? 'Rack';
    final ids = kRackMap[rackId] ?? [];
    final products = kProducts.where((p) => ids.contains(p.id)).toList();

    return Scaffold(
      backgroundColor: context.colors.canvas,
      appBar: AppBar(
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Rack Items',
                style: GoogleFonts.dmSans(
                    fontSize: 16, fontWeight: FontWeight.w700, color: context.colors.ink)),
            Text(rackName,
                style: GoogleFonts.dmSans(
                    fontSize: 11, color: context.colors.gold, fontWeight: FontWeight.w500)),
          ]),
          backgroundColor: context.colors.white,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
              onPressed: () => context.pop()),
          actions: [
            IconButton(
                icon: Icon(Icons.qr_code_scanner_rounded, color: context.colors.gold),
                onPressed: () => context.pushReplacement('/qr-scanner')),
          ]),
      body: products.isEmpty
          ? const EmptyView(
              icon: Icons.checkroom_outlined,
              title: 'No items on this rack',
              desc: 'This rack appears to be empty.')
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12),
              itemCount: products.length,
              itemBuilder: (_, i) =>
                  RepaintBoundary(child: ProductCard(products[i]))),
    );
  }
}
