import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:aura_app/data/models/product.dart';

final recentlyViewedProvider =
    StateNotifierProvider<RecentlyViewedNotifier, List<Product>>(
        (_) => RecentlyViewedNotifier());

class RecentlyViewedNotifier extends StateNotifier<List<Product>> {
  RecentlyViewedNotifier() : super([]);
  void add(Product p) =>
      state = [p, ...state.where((x) => x.id != p.id)].take(10).toList();
}

// ── Orders ─────────────────────────────────────────────────
