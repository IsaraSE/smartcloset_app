import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:aura_app/core/theme/colors.dart';
import 'package:aura_app/core/constants/mock_data.dart';
import 'package:aura_app/providers/auth_provider.dart';
import 'package:aura_app/providers/filter_provider.dart';
import 'package:aura_app/ui/widgets/shared_image.dart';
import 'package:aura_app/ui/widgets/sections.dart';
import 'package:aura_app/ui/widgets/brand.dart';
import 'package:aura_app/ui/widgets/product_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).valueOrNull;
    final featured = kProducts.where((p) => p.isFeatured).toList();
    final newArrs = kProducts.where((p) => p.isNew).toList();
    final menItems = kProducts.where((p) => p.category == 'Men').toList();
    final womenItems = kProducts.where((p) => p.category == 'Women').toList();
    final accessories =
        kProducts.where((p) => p.category == 'Accessories').toList();

    return Scaffold(
      backgroundColor: context.colors.canvas,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── AppBar ──────────────────────────────────────
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: context.colors.white,
            automaticallyImplyLeading: false,
            title: const NoirLogo(size: 30),
            actions: [
              IconButton(
                  icon: const Icon(Icons.qr_code_scanner_rounded, size: 22),
                  onPressed: () => context.push('/qr-scanner'),
                  tooltip: 'Rack Scanner'),
              IconButton(
                  icon: const Icon(Icons.search_rounded, size: 22),
                  onPressed: () => context.go('/explore')),
              const SizedBox(width: 4),
            ],
          ),

          SliverToBoxAdapter(
              child: Column(children: [
            // ── Location Bar ──────────────────────────────
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                  decoration: BoxDecoration(
                    color: context.colors.white,
                    border: Border.all(color: context.colors.border),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(children: [
                    Icon(Icons.location_on_outlined,
                        color: context.colors.gold, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text('Deliver to',
                              style: GoogleFonts.dmSans(
                                  fontSize: 10,
                                  color: context.colors.n400,
                                  fontWeight: FontWeight.w500)),
                          Text(
                              user?.defaultAddress?.short ??
                                  'Set delivery address',
                              style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  color: context.colors.ink,
                                  fontWeight: FontWeight.w600)),
                        ])),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                          color: context.colors.ink, borderRadius: BorderRadius.circular(4)),
                      child: Text('Change',
                          style: GoogleFonts.dmSans(
                              color: context.colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                  ]),
                )),

            // ── Banner Slider ─────────────────────────────
            const SizedBox(height: 16),
            const _BannerSlider(),

            // ── Category Grid ─────────────────────────────
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: Column(children: [
                  SecHeader(
                      title: 'Shop by Category',
                      onAll: () => context.go('/explore')),
                  const SizedBox(height: 14),
                  Row(
                      children: kCategories
                          .map((cat) => Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    final catName = cat.name;
                                    ref.read(filterProvider.notifier).update(
                                        (s) => s.copyWith(category: catName));
                                    context.go('/explore');
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: context.colors.border),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Stack(children: [
                                        Img(cat.imageUrl,
                                            w: double.infinity, h: 90),
                                        Container(
                                            color:
                                                Colors.black.withOpacity(0.42)),
                                        Center(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                              Text(cat.emoji,
                                                  style: const TextStyle(
                                                      fontSize: 20)),
                                              const SizedBox(height: 3),
                                              Text(cat.name,
                                                  style: GoogleFonts.dmSans(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: context.colors.white)),
                                            ])),
                                      ]),
                                    ),
                                  ),
                                ),
                              ))
                          .toList()),
                ])),

            // ── Featured Collection ────────────────────────
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SecHeader(
                          title: 'Featured', onAll: () => context.go('/explore')),
                      const SizedBox(height: 14),
                      SizedBox(
                          height: 260,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            itemCount: featured.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 12),
                            itemBuilder: (_, i) => RepaintBoundary(
                                child: ProductCard(featured[i], wide: true)),
                          )),
                    ])),

            // ── New Arrivals ───────────────────────────────
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SecHeader(
                          title: 'New Arrivals',
                          onAll: () => context.go('/explore')),
                      const SizedBox(height: 14),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.72,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12),
                        itemCount: newArrs.take(6).length,
                        itemBuilder: (_, i) =>
                            RepaintBoundary(child: ProductCard(newArrs[i])),
                      ),
                    ])),

            // ── Men's Edit ────────────────────────────────
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SecHeader(
                          title: "Men's Edit",
                          onAll: () {
                            ref
                                .read(filterProvider.notifier)
                                .update((s) => s.copyWith(category: 'Men'));
                            context.go('/explore');
                          }),
                      const SizedBox(height: 14),
                      SizedBox(
                          height: 260,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            itemCount: menItems.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 12),
                            itemBuilder: (_, i) => RepaintBoundary(
                                child: ProductCard(menItems[i], wide: true)),
                          )),
                    ])),

            // ── Editorial Banner ───────────────────────────
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
                child: _EditorialBanner()),

            // ── Women's Collection ─────────────────────────
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SecHeader(
                          title: "Women's Collection",
                          onAll: () {
                            ref
                                .read(filterProvider.notifier)
                                .update((s) => s.copyWith(category: 'Women'));
                            context.go('/explore');
                          }),
                      const SizedBox(height: 14),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.72,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12),
                        itemCount: womenItems.take(6).length,
                        itemBuilder: (_, i) =>
                            RepaintBoundary(child: ProductCard(womenItems[i])),
                      ),
                    ])),

            // ── Accessories ────────────────────────────────
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 28, 16, 24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SecHeader(
                          title: 'Accessories',
                          onAll: () {
                            ref.read(filterProvider.notifier).update(
                                (s) => s.copyWith(category: 'Accessories'));
                            context.go('/explore');
                          }),
                      const SizedBox(height: 14),
                      SizedBox(
                          height: 260,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            itemCount: accessories.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 12),
                            itemBuilder: (_, i) => RepaintBoundary(
                                child: ProductCard(accessories[i], wide: true)),
                          )),
                    ])),
          ])),
        ],
      ),
    );
  }
}

// ── Banner Slider ──────────────────────────────────────────
class _BannerSlider extends StatefulWidget {
  const _BannerSlider();

  @override
  State<_BannerSlider> createState() => _BSState();
}

class _BSState extends State<_BannerSlider> {
  final _ctrl = PageController();
  int _cur = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final next = (_cur + 1) % kBanners.length;
      _ctrl.animateToPage(next,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          SizedBox(
              height: 195,
              child: PageView.builder(
                controller: _ctrl,
                itemCount: kBanners.length,
                onPageChanged: (i) => setState(() => _cur = i),
                itemBuilder: (_, i) {
                  final b = kBanners[i];
                  return GestureDetector(
                    onTap: () => context.go(b.route),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(children: [
                        CachedNetworkImage(
                          imageUrl: b.imageUrl,
                          width: double.infinity,
                          height: 195,
                          fit: BoxFit.cover,
                          placeholder: (c, u) => Container(color: context.colors.n200),
                          errorWidget: (c, u, e) => Container(
                              color: context.colors.n900,
                              child: Center(
                                  child: Icon(Icons.image_outlined,
                                      color: context.colors.n600, size: 40))),
                        ),
                        Container(
                            decoration:
                                const BoxDecoration(gradient: C.heroGrad)),
                        Padding(
                            padding: const EdgeInsets.all(22),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 9, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: context.colors.gold,
                                        borderRadius: BorderRadius.circular(2)),
                                    child: Text(b.tag,
                                        style: GoogleFonts.dmSans(
                                            color: context.colors.white,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1.2)),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(b.title,
                                      style: GoogleFonts.cormorantGaramond(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w700,
                                          color: context.colors.white,
                                          height: 1.1)),
                                  const SizedBox(height: 5),
                                  Text(b.subtitle,
                                      style: GoogleFonts.dmSans(
                                          fontSize: 12,
                                          color:
                                              Colors.white.withOpacity(0.8))),
                                  const SizedBox(height: 14),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 7),
                                    decoration: BoxDecoration(
                                        color: context.colors.white,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Text(b.actionLabel,
                                        style: GoogleFonts.dmSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: context.colors.ink)),
                                  ),
                                ])),
                      ]),
                    ),
                  );
                },
              )),
          const SizedBox(height: 10),
          AnimatedSmoothIndicator(
              activeIndex: _cur,
              count: kBanners.length,
              effect: WormEffect(
                  dotHeight: 5,
                  dotWidth: 5,
                  activeDotColor: context.colors.gold,
                  dotColor: context.colors.n300,
                  spacing: 6)),
        ]),
      );
}

// ── Editorial Banner ───────────────────────────────────────
class _EditorialBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(children: [
          CachedNetworkImage(
            imageUrl:
                'https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=900&q=85',
            width: double.infinity,
            height: 160,
            fit: BoxFit.cover,
            placeholder: (c, u) => Container(height: 160, color: context.colors.n200),
            errorWidget: (c, u, e) => Container(height: 160, color: context.colors.n800),
          ),
          Container(height: 160, color: Colors.black.withOpacity(0.48)),
          Positioned.fill(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text('NOIR Editorial',
                        style: GoogleFonts.dmSans(
                            color: context.colors.gold,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5)),
                    const SizedBox(height: 6),
                    Text('Style Guide\nSS 2025',
                        style: GoogleFonts.cormorantGaramond(
                            color: context.colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            height: 1.1)),
                  ])),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: context.colors.gold,
                      foregroundColor: context.colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  child: Text('Read',
                      style: GoogleFonts.dmSans(fontWeight: FontWeight.w700))),
            ]),
          )),
        ]),
      );
}
