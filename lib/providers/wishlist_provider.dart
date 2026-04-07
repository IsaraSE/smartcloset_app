import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:noir_app/data/models/product.dart';

final wishlistProvider = StateNotifierProvider<WishlistNotifier, List<Product>>(
    (_) => WishlistNotifier());

class WishlistNotifier extends StateNotifier<List<Product>> {
  WishlistNotifier() : super([]);
  void toggle(Product p) => state = state.any((x) => x.id == p.id)
      ? state.where((x) => x.id != p.id).toList()
      : [...state, p];
  bool has(String id) => state.any((x) => x.id == id);
}

final inWishlistProvider = Provider.family<bool, String>((ref, id) {
  final items = ref.watch(wishlistProvider);
  return items.any((x) => x.id == id);
});

// ── Recently Viewed ────────────────────────────────────────
