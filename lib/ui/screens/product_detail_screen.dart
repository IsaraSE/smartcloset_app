import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import 'package:aura_app/core/theme/colors.dart';
import 'package:aura_app/core/constants/mock_data.dart';
import 'package:aura_app/data/models/product.dart';
import 'package:aura_app/providers/cart_provider.dart';
import 'package:aura_app/providers/wishlist_provider.dart';
import 'package:aura_app/ui/widgets/shared_buttons.dart';
import 'package:aura_app/ui/widgets/badges.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product? product;
  const ProductDetailScreen({super.key, this.product});

  @override
  ConsumerState<ProductDetailScreen> createState() => _PDState();
}

class _PDState extends ConsumerState<ProductDetailScreen> {
  int _imgIdx = 0;
  String? _selSize;
  String? _selColor;
  late PageController _pc;

  @override
  void initState() {
    super.initState();
    _pc = PageController();
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    final p = widget.product;
    if (p == null) {
      return const Scaffold(body: Center(child: Text('Product not found')));
    }
    final inWish = ref.watch(inWishlistProvider(p.id));
    final size = MediaQuery.of(ctx).size;

    return Scaffold(
      backgroundColor: C.white,
      body: Stack(children: [
        CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.52,
            pinned: true,
            backgroundColor: C.white,
            leading: GestureDetector(
                onTap: () => ctx.pop(),
                child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: C.white.withOpacity(0.92),
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(color: C.shadowMd, blurRadius: 8)
                        ]),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        size: 17, color: C.ink))),
            actions: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: WishBtn(
                    isWished: inWish,
                    onTap: () {
                      ref.read(wishlistProvider.notifier).toggle(p);
                      HapticFeedback.lightImpact();
                      snack(
                          ctx,
                          inWish
                              ? 'Removed from wishlist'
                              : 'Added to wishlist',
                          action: inWish ? null : 'View',
                          onAction: inWish ? null : () => ctx.go('/wishlist'));
                    },
                    size: 19,
                    shadow: true,
                  )),
              const SizedBox(width: 4),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(children: [
                PageView.builder(
                  controller: _pc,
                  itemCount: p.images.length,
                  onPageChanged: (i) => setState(() => _imgIdx = i),
                  itemBuilder: (_, i) => Container(
                      color: C.n50,
                      child: p.images[i].startsWith('http')
                          ? CachedNetworkImage(
                              imageUrl: p.images[i],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: size.height * 0.52,
                              placeholder: (c, u) => Shimmer.fromColors(
                                  baseColor: C.n200,
                                  highlightColor: C.n100,
                                  child: Container(color: C.n200)),
                              errorWidget: (c, u, e) => Container(
                                  color: C.n100,
                                  child: const Icon(Icons.image_outlined,
                                      size: 48, color: C.n300)))
                          : Image.asset(p.images[i],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: size.height * 0.52)),
                ),
                // Image counter
                Positioned(
                    bottom: 14,
                    left: 0,
                    right: 0,
                    child: Center(
                        child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('${_imgIdx + 1}/${p.images.length}',
                          style: GoogleFonts.dmSans(
                              color: C.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    ))),
              ]),
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 120),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Brand
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                        color: C.n100, borderRadius: BorderRadius.circular(4)),
                    child: Text(p.brand.toUpperCase(),
                        style: GoogleFonts.dmSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: C.n600,
                            letterSpacing: 1.2))),
                Stars(rating: p.rating, count: p.reviewCount, sz: 13),
              ]),
              const SizedBox(height: 10),

              // Name
              Text(p.name,
                  style: GoogleFonts.cormorantGaramond(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: C.ink,
                      height: 1.2)),
              const SizedBox(height: 12),

              // Price row
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text('\$${p.price.toStringAsFixed(2)}',
                    style: GoogleFonts.dmSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: C.ink)),
                if (p.hasDiscount) ...[
                  const SizedBox(width: 10),
                  Text('\$${p.originalPrice!.toStringAsFixed(2)}',
                      style: GoogleFonts.dmSans(
                          fontSize: 14,
                          color: C.n400,
                          decoration: TextDecoration.lineThrough)),
                  const SizedBox(width: 8),
                  SaleBadge(pct: p.discount),
                ],
                const Spacer(),
                if (p.soldCount > 0)
                  Text('${p.soldCount}+ sold',
                      style: GoogleFonts.dmSans(fontSize: 12, color: C.n500)),
              ]),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 18),

              // Size
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Size',
                    style: GoogleFonts.dmSans(
                        fontSize: 14, fontWeight: FontWeight.w600)),
                Text('Size Guide',
                    style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: C.gold,
                        fontWeight: FontWeight.w600)),
              ]),
              const SizedBox(height: 10),
              Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: p.sizes
                      .map((s) => GestureDetector(
                            onTap: () => setState(() => _selSize = s),
                            child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                    color: _selSize == s ? C.ink : C.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: _selSize == s ? C.ink : C.n300,
                                        width: _selSize == s ? 2 : 1)),
                                child: Center(
                                    child: Text(s,
                                        style: GoogleFonts.dmSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: _selSize == s
                                                ? C.white
                                                : C.n700)))),
                          ))
                      .toList()),
              const SizedBox(height: 20),

              // Color
              Text('Colour',
                  style: GoogleFonts.dmSans(
                      fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  children: p.colors.map((c) {
                    final col = colorMap[c] ?? C.n400;
                    final sel = _selColor == c;
                    final isLight = col.computeLuminance() > 0.75;
                    return GestureDetector(
                      onTap: () => setState(() => _selColor = c),
                      child: Tooltip(
                          message: c,
                          child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: col,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: sel
                                        ? C.gold
                                        : (isLight
                                            ? C.n300
                                            : Colors.transparent),
                                    width: sel ? 2.5 : 1),
                                boxShadow: sel
                                    ? [
                                        BoxShadow(
                                            color: C.gold.withOpacity(0.4),
                                            blurRadius: 8,
                                            spreadRadius: 1)
                                      ]
                                    : [],
                              ),
                              child: sel
                                  ? Icon(Icons.check_rounded,
                                      color: isLight ? C.ink : C.white,
                                      size: 16)
                                  : null)),
                    );
                  }).toList()),
              const SizedBox(height: 22),
              const Divider(),
              const SizedBox(height: 18),

              // Description
              Text('Description',
                  style: GoogleFonts.dmSans(
                      fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(p.description,
                  style: GoogleFonts.dmSans(
                      fontSize: 14, color: C.n600, height: 1.7)),
              const SizedBox(height: 20),

              // Details
              if (p.details.isNotEmpty) ...[
                Text('Product Details',
                    style: GoogleFonts.dmSans(
                        fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: C.n50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: C.border)),
                    child: Column(
                        children: p.details.entries
                            .map((e) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(children: [
                                    SizedBox(
                                        width: 90,
                                        child: Text(e.key,
                                            style: GoogleFonts.dmSans(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: C.n500))),
                                    Expanded(
                                        child: Text(e.value,
                                            style: GoogleFonts.dmSans(
                                                fontSize: 12, color: C.ink))),
                                  ]),
                                ))
                            .toList())),
                const SizedBox(height: 20),
              ],

              // Try-On Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: C.goldLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: C.gold.withOpacity(0.3))),
                child: Row(children: [
                  Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                          color: C.gold, shape: BoxShape.circle),
                      child: const Icon(Icons.camera_alt_rounded,
                          color: C.white, size: 22)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text('Virtual Try-On',
                            style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w700,
                                color: C.ink,
                                fontSize: 14)),
                        Text('See how it looks on you',
                            style: GoogleFonts.dmSans(
                                color: C.goldDark, fontSize: 12)),
                      ])),
                  ElevatedButton(
                      onPressed: () => ctx.push('/try-on', extra: p),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: C.gold,
                          foregroundColor: C.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          elevation: 0),
                      child: Text('Try It',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w700, fontSize: 12))),
                ]),
              ),
            ]),
          )),
        ]),

        // ── Bottom CTA ─────────────────────────────────────
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: C.white,
                border: const Border(top: BorderSide(color: C.border)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, -4))
                ],
              ),
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: SafeArea(
                  child: Row(children: [
                Expanded(
                    child: SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () {
                            if (_selSize == null) {
                              snack(context, 'Please select a size', err: true);
                              return;
                            }
                            ref
                                .read(cartProvider.notifier)
                                .add(p, _selSize!, _selColor ?? p.colors.first);
                            snack(context, 'Added to cart',
                                action: 'View Cart',
                                onAction: () => context.go('/cart'));
                          },
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4))),
                          child: Text('Add to Cart',
                              style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: C.ink)),
                        ))),
                const SizedBox(width: 12),
                Expanded(
                    child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_selSize == null) {
                              snack(context, 'Please select a size', err: true);
                              return;
                            }
                            ref
                                .read(cartProvider.notifier)
                                .add(p, _selSize!, _selColor ?? p.colors.first);
                            ctx.push('/checkout');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: C.gold,
                              foregroundColor: C.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              elevation: 0),
                          child: Text('Buy Now',
                              style: GoogleFonts.dmSans(
                                  fontSize: 13, fontWeight: FontWeight.w600)),
                        ))),
              ])),
            )),
      ]),
    );
  }
}
