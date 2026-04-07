import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:aura_app/data/models/product.dart';
import 'package:aura_app/data/models/cart_item.dart';

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>((_) => CartNotifier());

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void add(Product p, String size, String color, {int qty = 1}) {
    final idx =
        state.indexWhere((i) => i.product.id == p.id && i.selectedSize == size);
    if (idx >= 0) {
      state = [
        ...state.sublist(0, idx),
        state[idx].copyWith(quantity: state[idx].quantity + qty),
        ...state.sublist(idx + 1),
      ];
    } else {
      state = [
        ...state,
        CartItem(
            id: '${p.id}_$size',
            product: p,
            quantity: qty,
            selectedSize: size,
            selectedColor: color)
      ];
    }
  }

  void remove(String id) => state = state.where((i) => i.id != id).toList();

  void updateQty(String id, int qty) {
    if (qty <= 0) {
      remove(id);
      return;
    }
    state =
        state.map((i) => i.id == id ? i.copyWith(quantity: qty) : i).toList();
  }

  void clear() => state = [];

  double get subtotal => state.fold(0, (s, i) => s + i.total);
  double get shipping => subtotal >= 100 ? 0 : 9.99;
  double get total => subtotal + shipping;
  int get count => state.fold(0, (s, i) => s + i.quantity);
}

// Use select to avoid unnecessary rebuilds
final cartCountProvider =
    Provider<int>((ref) => ref.watch(cartProvider.notifier).count);
final cartSubtotalProvider =
    Provider<double>((ref) => ref.watch(cartProvider.notifier).subtotal);
final cartTotalProvider =
    Provider<double>((ref) => ref.watch(cartProvider.notifier).total);

// ── Wishlist ───────────────────────────────────────────────
