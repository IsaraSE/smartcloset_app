import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noir_app/core/theme/colors.dart';
import 'package:noir_app/data/models/product.dart';
import 'package:noir_app/providers/wishlist_provider.dart';
import 'package:noir_app/providers/recently_viewed_provider.dart';
import 'package:noir_app/ui/widgets/shared_image.dart';
import 'package:noir_app/ui/widgets/badges.dart';
import 'package:noir_app/ui/widgets/shared_buttons.dart';
import 'package:noir_app/core/utils/currency_utils.dart';

class ProductCard extends ConsumerWidget {
  final Product p;
  final bool wide;

  const ProductCard(this.p, {super.key, this.wide = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inWish = ref.watch(inWishlistProvider(p.id));

    return GestureDetector(
      onTap: () {
        ref.read(recentlyViewedProvider.notifier).add(p);
        context.push('/product/${p.id}', extra: p);
      },
      child: Container(
        width: wide ? 165 : null,
        decoration: BoxDecoration(
          color: context.colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.colors.border),
          boxShadow: [
            BoxShadow(color: context.colors.shadowMd, blurRadius: 8, offset: const Offset(0, 3))
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ── Image ────────────────────────────────────────
          Stack(children: [
            ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
                child: Img(p.images.first,
                    w: double.infinity, h: wide ? 155 : 150)),
            // Badges
            Positioned(
                top: 8,
                left: 8,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (p.hasDiscount) SaleBadge(pct: p.discount),
                      if (p.isNew) ...[
                        const SizedBox(height: 4),
                        const NewBadge()
                      ],
                    ])),
            // Wishlist button
            Positioned(
                top: 6,
                right: 6,
                child: WishBtn(
                  isWished: inWish,
                  onTap: () {
                    ref.read(wishlistProvider.notifier).toggle(p);
                    HapticFeedback.lightImpact();
                  },
                  size: 15,
                )),
          ]),
          // ── Info ─────────────────────────────────────────
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(p.brand,
                      style: GoogleFonts.dmSans(
                          fontSize: 10,
                          color: context.colors.n400,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3),
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(p.name,
                      style: GoogleFonts.dmSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: context.colors.ink),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Row(children: [
                    Icon(Icons.star_rounded, color: context.colors.gold, size: 11),
                    const SizedBox(width: 2),
                    Text(p.rating.toStringAsFixed(1),
                        style: GoogleFonts.dmSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: context.colors.n700)),
                  ]),
                  const Spacer(),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(p.price.formatPrice(),
                            style: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: context.colors.ink)),
                        if (p.hasDiscount) ...[
                          const SizedBox(width: 5),
                          Text(p.originalPrice!.formatPrice(),
                              style: GoogleFonts.dmSans(
                                  fontSize: 10,
                                  color: context.colors.n400,
                                  decoration: TextDecoration.lineThrough)),
                        ],
                      ]),
                ]),
          )),
        ]),
      ),
    );
  }
}
