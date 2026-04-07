import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:aura_app/core/constants/mock_data.dart';
import 'package:aura_app/data/models/product.dart';

class PFilter {
  final String? category, subCategory, search, sortBy;
  final List<String> sizes, colors;
  final double? minPrice, maxPrice;

  const PFilter({
    this.category,
    this.subCategory,
    this.search,
    this.sortBy = 'popularity',
    this.sizes = const [],
    this.colors = const [],
    this.minPrice,
    this.maxPrice,
  });

  bool get hasFilters =>
      category != null ||
      sizes.isNotEmpty ||
      colors.isNotEmpty ||
      minPrice != null ||
      maxPrice != null ||
      search != null;

  PFilter copyWith({
    String? category,
    String? subCategory,
    String? search,
    String? sortBy,
    List<String>? sizes,
    List<String>? colors,
    double? minPrice,
    double? maxPrice,
    bool clearCategory = false,
    bool clearSearch = false,
  }) =>
      PFilter(
        category: clearCategory ? null : category ?? this.category,
        subCategory: subCategory ?? this.subCategory,
        search: clearSearch ? null : search ?? this.search,
        sortBy: sortBy ?? this.sortBy,
        sizes: sizes ?? this.sizes,
        colors: colors ?? this.colors,
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
      );
}

final filterProvider = StateProvider<PFilter>((_) => const PFilter());

final filteredProductsProvider = Provider<List<Product>>((ref) {
  final f = ref.watch(filterProvider);
  var list = kProducts.where((p) {
    if (f.category != null && p.category != f.category) return false;
    if (f.subCategory != null && p.subCategory != f.subCategory) return false;
    if (f.sizes.isNotEmpty && !p.sizes.any(f.sizes.contains)) return false;
    if (f.colors.isNotEmpty && !p.colors.any(f.colors.contains)) return false;
    if (f.minPrice != null && p.price < f.minPrice!) return false;
    if (f.maxPrice != null && p.price > f.maxPrice!) return false;
    if (f.search != null && f.search!.isNotEmpty) {
      final q = f.search!.toLowerCase();
      return p.name.toLowerCase().contains(q) ||
          p.brand.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q) ||
          p.subCategory.toLowerCase().contains(q);
    }
    return true;
  }).toList();

  switch (f.sortBy) {
    case 'price_low':
      list.sort((a, b) => a.price.compareTo(b.price));
    case 'price_high':
      list.sort((a, b) => b.price.compareTo(a.price));
    case 'newest':
      list.sort((a, b) => b.isNew ? 1 : -1);
    case 'rating':
      list.sort((a, b) => b.rating.compareTo(a.rating));
    default:
      list.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
  }
  return list;
});

// ── Cart ───────────────────────────────────────────────────
