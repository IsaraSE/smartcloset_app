import 'package:flutter/material.dart';
import 'package:noir_app/data/models/cart_item.dart';
import 'package:noir_app/data/models/address.dart';

enum OrderStatus { placed, processing, shipped, delivered, cancelled }

extension OrderStatusX on OrderStatus {
  String get label => const {
        OrderStatus.placed: 'Order Placed',
        OrderStatus.processing: 'Processing',
        OrderStatus.shipped: 'Shipped',
        OrderStatus.delivered: 'Delivered',
        OrderStatus.cancelled: 'Cancelled',
      }[this]!;

  int get step => const {
        OrderStatus.placed: 0,
        OrderStatus.processing: 1,
        OrderStatus.shipped: 2,
        OrderStatus.delivered: 3,
        OrderStatus.cancelled: -1,
      }[this]!;

  Color get color => this == OrderStatus.delivered
      ? const Color(0xFF22C55E)
      : this == OrderStatus.cancelled
          ? const Color(0xFFEF4444)
          : const Color(0xFF0A0A0A);
}

class AppOrder {
  final String id, orderNumber, paymentMethod;
  final List<CartItem> items;
  final double subtotal, shipping, total, discount;
  final Address address;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? estimatedDelivery;

  const AppOrder({
    required this.id,
    required this.orderNumber,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.total,
    required this.address,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
    this.estimatedDelivery,
    this.discount = 0,
  });

  int get itemCount => items.fold(0, (s, i) => s + i.quantity);
}
