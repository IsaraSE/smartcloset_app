import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:camera/camera.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:aura_app/core/theme/colors.dart';
import 'package:aura_app/core/theme/app_theme.dart';
import 'package:aura_app/core/constants/mock_data.dart';
import 'package:aura_app/data/models/product.dart';
import 'package:aura_app/data/models/cart_item.dart';
import 'package:aura_app/data/models/address.dart';
import 'package:aura_app/data/models/user.dart';
import 'package:aura_app/data/models/order.dart';
import 'package:aura_app/data/models/banner_category.dart';
import 'package:aura_app/providers/auth_provider.dart';
import 'package:aura_app/providers/filter_provider.dart';
import 'package:aura_app/providers/cart_provider.dart';
import 'package:aura_app/providers/wishlist_provider.dart';
import 'package:aura_app/providers/recently_viewed_provider.dart';
import 'package:aura_app/providers/orders_provider.dart';
import 'package:aura_app/router/app_router.dart';
import 'package:aura_app/app.dart';
import 'package:aura_app/ui/widgets/shared_buttons.dart';
import 'package:aura_app/ui/widgets/shared_image.dart';
import 'package:aura_app/ui/widgets/badges.dart';
import 'package:aura_app/ui/widgets/empty_view.dart';
import 'package:aura_app/ui/widgets/sections.dart';
import 'package:aura_app/ui/widgets/brand.dart';
import 'package:aura_app/ui/widgets/product_card.dart';
import 'package:aura_app/ui/base/main_nav.dart';
import 'package:aura_app/ui/screens/splash_screen.dart';
import 'package:aura_app/ui/screens/auth/login_screen.dart';
import 'package:aura_app/ui/screens/auth/register_screen.dart';
import 'package:aura_app/ui/screens/home_screen.dart';
import 'package:aura_app/ui/screens/explore_screen.dart';
import 'package:aura_app/ui/screens/product_detail_screen.dart';
import 'package:aura_app/ui/screens/cart_screen.dart';
import 'package:aura_app/ui/screens/wishlist_screen.dart';
import 'package:aura_app/ui/screens/checkout_screen.dart';
import 'package:aura_app/ui/screens/order_success_screen.dart';
import 'package:aura_app/ui/screens/orders_screen.dart';
import 'package:aura_app/ui/screens/profile_screen.dart';
import 'package:aura_app/ui/screens/try_on_screen.dart';
import 'package:aura_app/ui/screens/qr_scanner_screen.dart';
import 'package:aura_app/ui/screens/rack_products_screen.dart';

final ordersProvider = StateNotifierProvider<OrdersNotifier, List<AppOrder>>(
    (_) => OrdersNotifier());

class OrdersNotifier extends StateNotifier<List<AppOrder>> {
  OrdersNotifier()
      : super([
          AppOrder(
            id: 'o1',
            orderNumber: 'NR-2025-001',
            items: [],
            subtotal: 329.98,
            shipping: 0,
            total: 329.98,
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
            subtotal: 249.99,
            shipping: 0,
            total: 249.99,
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
    final ship = sub >= 100 ? 0.0 : 9.99;
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
