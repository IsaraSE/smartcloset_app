import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import 'package:noir_app/core/theme/colors.dart';
import 'package:noir_app/core/constants/mock_data.dart';
import 'package:noir_app/data/models/product.dart';
import 'package:noir_app/providers/cart_provider.dart';
import 'package:noir_app/providers/wishlist_provider.dart';
import 'package:noir_app/ui/widgets/shared_buttons.dart';
import 'package:noir_app/ui/widgets/badges.dart';
import 'package:noir_app/core/utils/currency_utils.dart';

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
  Widget build(BuildContext context) {
    final p = widget.product;
    if (p == null) {
      return const Scaffold(body: Center(child: Text('Product not found')));
    }
    final inWish = ref.watch(inWishlistProvider(p.id));
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: context.colors.white,
      body: Stack(children: [
        CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.52,
            pinned: true,
            backgroundColor: context.colors.white,
            leading: GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: context.colors.white.withValues(alpha: 0.92),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: context.colors.shadowMd, blurRadius: 8)
                        ]),
                    child: Icon(Icons.arrow_back_ios_new_rounded,
                        size: 17, color: context.colors.ink))),
            actions: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: WishBtn(
                    isWished: inWish,
                    onTap: () {
                      ref.read(wishlistProvider.notifier).toggle(p);
                      HapticFeedback.lightImpact();
                      snack(
                          context,
                          inWish
                              ? 'Removed from wishlist'
                              : 'Added to wishlist',
                          action: inWish ? null : 'View',
                          onAction: inWish ? null : () => context.go('/wishlist'));
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
                      color: context.colors.n50,
                      child: p.images[i].startsWith('http')
                          ? CachedNetworkImage(
                              imageUrl: p.images[i],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: size.height * 0.52,
                              placeholder: (c, u) => Shimmer.fromColors(
                                  baseColor: context.colors.n200,
                                  highlightColor: context.colors.n100,
                                  child: Container(color: context.colors.n200)),
                              errorWidget: (c, u, e) => Container(
                                  color: context.colors.n100,
                                  child: Icon(Icons.image_outlined,
                                      size: 48, color: context.colors.n300)))
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
                          color: Colors.black.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('${_imgIdx + 1}/${p.images.length}',
                          style: GoogleFonts.dmSans(
                              color: context.colors.white,
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
                        color: context.colors.n100, borderRadius: BorderRadius.circular(4)),
                    child: Text(p.brand.toUpperCase(),
                        style: GoogleFonts.dmSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: context.colors.n600,
                            letterSpacing: 1.2))),
                Stars(rating: p.rating, count: p.reviewCount, sz: 13),
              ]),
              const SizedBox(height: 10),

              // Name
              Text(p.name,
                  style: GoogleFonts.cormorantGaramond(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: context.colors.ink,
                      height: 1.2)),
              const SizedBox(height: 12),

              // Price row
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(p.price.formatPrice(),
                    style: GoogleFonts.dmSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: context.colors.ink)),
                if (p.hasDiscount) ...[
                  const SizedBox(width: 10),
                  Text(p.originalPrice!.formatPrice(),
                      style: GoogleFonts.dmSans(
                          fontSize: 14,
                          color: context.colors.n400,
                          decoration: TextDecoration.lineThrough)),
                  const SizedBox(width: 8),
                  SaleBadge(pct: p.discount),
                ],
                const Spacer(),
                if (p.soldCount > 0)
                  Text('${p.soldCount}+ sold',
                      style: GoogleFonts.dmSans(fontSize: 12, color: context.colors.n500)),
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
                        color: context.colors.gold,
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
                                    color: _selSize == s ? context.colors.ink : context.colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: _selSize == s ? context.colors.ink : context.colors.n300,
                                        width: _selSize == s ? 2 : 1)),
                                child: Center(
                                    child: Text(s,
                                        style: GoogleFonts.dmSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: _selSize == s
                                                ? context.colors.white
                                                : context.colors.n700)))),
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
                    final col = colorMap[c] ?? context.colors.n400;
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
                                        ? context.colors.gold
                                        : (isLight
                                            ? context.colors.n300
                                            : Colors.transparent),
                                    width: sel ? 2.5 : 1),
                                boxShadow: sel
                                    ? [
                                        BoxShadow(
                                            color: context.colors.gold.withValues(alpha: 0.4),
                                            blurRadius: 8,
                                            spreadRadius: 1)
                                      ]
                                    : [],
                              ),
                              child: sel
                                  ? Icon(Icons.check_rounded,
                                      color: isLight ? context.colors.ink : context.colors.white,
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
                      fontSize: 14, color: context.colors.n600, height: 1.7)),
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
                        color: context.colors.n50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: context.colors.border)),
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
                                                color: context.colors.n500))),
                                    Expanded(
                                        child: Text(e.value,
                                            style: GoogleFonts.dmSans(
                                                fontSize: 12, color: context.colors.ink))),
                                  ]),
                                ))
                            .toList())),
                const SizedBox(height: 20),
              ],

              // Try-On Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: context.colors.goldLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: context.colors.gold.withValues(alpha: 0.3))),
                child: Row(children: [
                  Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                          color: context.colors.gold, shape: BoxShape.circle),
                      child: Icon(Icons.camera_alt_rounded,
                          color: context.colors.white, size: 22)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text('Virtual Try-On',
                            style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w700,
                                color: context.colors.ink,
                                fontSize: 14)),
                        Text('See how it looks on you',
                            style: GoogleFonts.dmSans(
                                color: context.colors.goldDark, fontSize: 12)),
                      ])),
                  ElevatedButton(
                      onPressed: () => context.push('/try-on', extra: p),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: context.colors.gold,
                          foregroundColor: context.colors.white,
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
                color: context.colors.white,
                border: Border(top: BorderSide(color: context.colors.border)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
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
                                  color: context.colors.ink)),
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
                            context.push('/checkout');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: context.colors.gold,
                              foregroundColor: context.colors.white,
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
