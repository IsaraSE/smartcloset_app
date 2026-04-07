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

final authProvider =
    AsyncNotifierProvider<AuthNotifier, AppUser?>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() async {
    // Simulate auth check — in production, read from secure storage
    await Future.delayed(const Duration(milliseconds: 800));
    return null;
  }

  Future<bool> signIn(String email, String password) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));
    if (email.isNotEmpty && password.length >= 6) {
      state = AsyncData(_makeUser(email));
      return true;
    }
    state = const AsyncData(null);
    return false;
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));
    state = AsyncData(AppUser(
      id: 'g001',
      name: 'Alex Johnson',
      email: 'alex@gmail.com',
      addresses: [_defaultAddress()],
    ));
  }

  Future<bool> signUp(String name, String email, String password) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));
    state = AsyncData(AppUser(
        id: 'u_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        email: email));
    return true;
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(milliseconds: 400));
    state = const AsyncData(null);
  }

  AppUser _makeUser(String email) => AppUser(
        id: 'u001',
        name: email
            .split('@')
            .first
            .split('.')
            .map(
                (w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
            .join(' '),
        email: email,
        addresses: [_defaultAddress()],
      );

  Address _defaultAddress() => const Address(
        id: 'a01',
        name: 'Home',
        phone: '+1 234 567 8900',
        line1: '247 Fifth Avenue',
        line2: 'Apt 12B',
        city: 'New York',
        state: 'NY',
        zip: '10001',
        country: 'USA',
        isDefault: true,
      );
}

// ── Filter ─────────────────────────────────────────────────
