import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noir_app/data/models/cart_item.dart';
import 'package:noir_app/data/models/address.dart';
import 'package:noir_app/data/models/order.dart';

final ordersProvider = StateNotifierProvider<OrdersNotifier, List<AppOrder>>(
    (_) => OrdersNotifier());

class OrdersNotifier extends StateNotifier<List<AppOrder>> {
  OrdersNotifier()
      : super([
          AppOrder(
            id: 'o1',
            orderNumber: 'NR-2025-001',
            items: [],
            subtotal: 98995.0,
            shipping: 0,
            total: 98995.0,
            address: const Address(
                id: 'a1',
                name: 'Home',
                phone: '+1 234 567 8900',
                line1: '247 Fifth Avenue',
                city: 'New York',
                state: 'NY',
                zip: '10001',
                country: 'USA',
                isDefault: true),
            paymentMethod: 'Card Payment',
            status: OrderStatus.delivered,
            createdAt: DateTime.now().subtract(const Duration(days: 15)),
            estimatedDelivery: DateTime.now().subtract(const Duration(days: 5)),
          ),
          AppOrder(
            id: 'o2',
            orderNumber: 'NR-2025-002',
            items: [],
            subtotal: 74995.0,
            shipping: 0,
            total: 74995.0,
            address: const Address(
                id: 'a1',
                name: 'Home',
                phone: '+1 234 567 8900',
                line1: '247 Fifth Avenue',
                city: 'New York',
                state: 'NY',
                zip: '10001',
                country: 'USA',
                isDefault: true),
            paymentMethod: 'Cash on Delivery',
            status: OrderStatus.shipped,
            createdAt: DateTime.now().subtract(const Duration(days: 3)),
            estimatedDelivery: DateTime.now().add(const Duration(days: 2)),
          ),
        ]);

  Future<AppOrder> place({
    required List<CartItem> items,
    required Address address,
    required String payment,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    final sub = items.fold<double>(0, (s, i) => s + i.total);
    final ship = sub >= 10000 ? 0.0 : 500.0;
    final order = AppOrder(
      id: 'o_${DateTime.now().millisecondsSinceEpoch}',
      orderNumber: 'NR-2025-${(state.length + 1).toString().padLeft(3, '0')}',
      items: items,
      subtotal: sub,
      shipping: ship,
      total: sub + ship,
      address: address,
      paymentMethod: payment,
      status: OrderStatus.placed,
      createdAt: DateTime.now(),
      estimatedDelivery: DateTime.now().add(const Duration(days: 5)),
    );
    state = [order, ...state];
    return order;
  }
}
