import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aura_app/core/theme/colors.dart';
import 'package:aura_app/providers/filter_provider.dart';
import 'package:aura_app/ui/widgets/shared_buttons.dart';
import 'package:aura_app/ui/widgets/empty_view.dart';
import 'package:aura_app/ui/widgets/product_card.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreState();
}

class _ExploreState extends ConsumerState<ExploreScreen> {
  final _sc = TextEditingController();

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    final products = ref.watch(filteredProductsProvider);
    final filter = ref.watch(filterProvider);

    return Scaffold(
      backgroundColor: C.canvas,
      body: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          backgroundColor: C.white,
          automaticallyImplyLeading: false,
          title: Text('Explore',
              style: GoogleFonts.cormorantGaramond(
                  fontSize: 22, fontWeight: FontWeight.w700, color: C.ink)),
          actions: [
            PopupMenuButton<String>(
                icon: const Icon(Icons.sort_rounded),
                onSelected: (v) => ref
                    .read(filterProvider.notifier)
                    .update((s) => s.copyWith(sortBy: v)),
                itemBuilder: (_) => const [
                      PopupMenuItem(
                          value: 'popularity', child: Text('Popularity')),
                      PopupMenuItem(
                          value: 'price_low',
                          child: Text('Price: Low to High')),
                      PopupMenuItem(
                          value: 'price_high',
                          child: Text('Price: High to Low')),
                      PopupMenuItem(
                          value: 'newest', child: Text('Newest First')),
                      PopupMenuItem(value: 'rating', child: Text('Top Rated')),
                    ]),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Row(children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: C.n100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: C.border)),
                  child: TextField(
                      controller: _sc,
                      onChanged: (q) => ref
                          .read(filterProvider.notifier)
                          .update(
                              (s) => s.copyWith(search: q.isEmpty ? null : q)),
                      style: GoogleFonts.dmSans(fontSize: 14, color: C.ink),
                      decoration: InputDecoration(
                        hintText: 'Search brands, styles...',
                        hintStyle:
                            GoogleFonts.dmSans(fontSize: 14, color: C.n400),
                        prefixIcon: const Icon(Icons.search_rounded,
                            color: C.n400, size: 20),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 13),
                        suffixIcon: _sc.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear,
                                    size: 18, color: C.n400),
                                onPressed: () {
                                  _sc.clear();
                                  ref.read(filterProvider.notifier).update(
                                      (s) => s.copyWith(clearSearch: true));
                                  setState(() {});
                                })
                            : null,
                      )),
                )),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _showFilters(ctx),
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          color: filter.hasFilters ? C.ink : C.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: filter.hasFilters ? C.ink : C.border)),
                      child: Icon(Icons.tune_rounded,
                          color: filter.hasFilters ? C.white : C.n700,
                          size: 21)),
                ),
              ]),
            ),
          ),
        ),

        // Category chips
        SliverToBoxAdapter(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          physics: const BouncingScrollPhysics(),
          child: Row(children: [
            _CatChip(
                'All',
                filter.category == null,
                () => ref
                    .read(filterProvider.notifier)
                    .update((s) => s.copyWith(clearCategory: true))),
            ..._cats.map((c) => _CatChip(
                c,
                filter.category == c,
                () => ref
                    .read(filterProvider.notifier)
                    .update((s) => s.copyWith(category: c)))),
          ]),
        )),

        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Text('${products.length} items',
              style: GoogleFonts.dmSans(fontSize: 12, color: C.n500)),
        )),

        products.isEmpty
            ? SliverFillRemaining(
                child: EmptyView(
                    icon: Icons.search_off_rounded,
                    title: 'No results found',
                    desc: 'Try adjusting your search or filters',
                    btnLabel: 'Clear Filters',
                    onBtn: () => ref
                        .read(filterProvider.notifier)
                        .update((_) => const PFilter())))
            : SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                      (c, i) =>
                          RepaintBoundary(child: ProductCard(products[i])),
                      childCount: products.length),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12),
                )),
      ]),
    );
  }

  static const _cats = ['Men', 'Women', 'Kids', 'Accessories'];

  void _showFilters(BuildContext ctx) => showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _FilterSheet());
}

class _CatChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _CatChip(this.label, this.selected, this.onTap);

  @override
  Widget build(BuildContext ctx) => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? C.ink : C.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: selected ? C.ink : C.border),
            ),
            child: Text(label,
                style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: selected ? C.white : C.n700))),
      );
}

class _FilterSheet extends ConsumerStatefulWidget {
  const _FilterSheet();

  @override
  ConsumerState<_FilterSheet> createState() => _FSState();
}

class _FSState extends ConsumerState<_FilterSheet> {
  late PFilter _f;

  @override
  void initState() {
    super.initState();
    _f = ref.read(filterProvider);
  }

  void _toggleSize(String s) => setState(() => _f = _f.copyWith(
      sizes: _f.sizes.contains(s)
          ? _f.sizes.where((x) => x != s).toList()
          : [..._f.sizes, s]));

  @override
  Widget build(BuildContext ctx) => Container(
        decoration: const BoxDecoration(
            color: C.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
              Center(
                  child: Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                          color: C.n200,
                          borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Filters',
                    style: GoogleFonts.cormorantGaramond(
                        fontSize: 24, fontWeight: FontWeight.w700)),
                TextButton(
                    onPressed: () => setState(() => _f = const PFilter()),
                    child: Text('Clear All',
                        style: GoogleFonts.dmSans(
                            color: C.gold, fontWeight: FontWeight.w600))),
              ]),
              const SizedBox(height: 20),
              Text('Sizes',
                  style: GoogleFonts.dmSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: C.n700,
                      letterSpacing: 0.3)),
              const SizedBox(height: 10),
              Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: ['XS', 'S', 'M', 'L', 'XL', 'XXL']
                      .map((s) => GestureDetector(
                            onTap: () => _toggleSize(s),
                            child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 46,
                                height: 46,
                                decoration: BoxDecoration(
                                    color:
                                        _f.sizes.contains(s) ? C.ink : C.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: _f.sizes.contains(s)
                                            ? C.ink
                                            : C.n300)),
                                child: Center(
                                    child: Text(s,
                                        style: GoogleFonts.dmSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: _f.sizes.contains(s)
                                                ? C.white
                                                : C.ink)))),
                          ))
                      .toList()),
              const SizedBox(height: 20),
              Text('Price Range',
                  style: GoogleFonts.dmSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: C.n700,
                      letterSpacing: 0.3)),
              RangeSlider(
                  values: RangeValues(_f.minPrice ?? 0, _f.maxPrice ?? 500),
                  min: 0,
                  max: 500,
                  activeColor: C.ink,
                  inactiveColor: C.n200,
                  onChanged: (v) => setState(() =>
                      _f = _f.copyWith(minPrice: v.start, maxPrice: v.end))),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('\$${(_f.minPrice ?? 0).toInt()}',
                    style: GoogleFonts.dmSans(fontSize: 13, color: C.n600)),
                Text('\$${(_f.maxPrice ?? 500).toInt()}',
                    style: GoogleFonts.dmSans(fontSize: 13, color: C.n600)),
              ]),
              const SizedBox(height: 24),
              Btn(
                  text: 'Apply Filters',
                  onPressed: () {
                    ref.read(filterProvider.notifier).state = _f;
                    Navigator.pop(ctx);
                  }),
            ])),
      );
}
