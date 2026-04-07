import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:noir_app/data/models/product.dart';
import 'package:noir_app/data/models/order.dart';
import 'package:noir_app/providers/auth_provider.dart';
import 'package:noir_app/ui/base/main_nav.dart';
import 'package:noir_app/ui/features/home/splash_screen.dart';
import 'package:noir_app/ui/features/auth/login_screen.dart';
import 'package:noir_app/ui/features/auth/register_screen.dart';
import 'package:noir_app/ui/features/home/home_screen.dart';
import 'package:noir_app/ui/features/explore/explore_screen.dart';
import 'package:noir_app/ui/features/product/product_detail_screen.dart';
import 'package:noir_app/ui/features/cart/cart_screen.dart';
import 'package:noir_app/ui/features/explore/wishlist_screen.dart';
import 'package:noir_app/ui/features/checkout/checkout_screen.dart';
import 'package:noir_app/ui/features/checkout/order_success_screen.dart';
import 'package:noir_app/ui/features/orders/orders_screen.dart';
import 'package:noir_app/ui/features/profile/profile_screen.dart';
import 'package:noir_app/ui/features/profile/addresses_screen.dart';
import 'package:noir_app/ui/features/profile/promo_codes_screen.dart';
import 'package:noir_app/ui/features/profile/notifications_screen.dart';
import 'package:noir_app/ui/features/profile/help_support_screen.dart';
import 'package:noir_app/ui/features/profile/about_screen.dart';
import 'package:noir_app/ui/features/scanning/try_on_screen.dart';
import 'package:noir_app/ui/features/scanning/qr_scanner_screen.dart';
import 'package:noir_app/ui/features/product/rack_products_screen.dart';

final _rootKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/splash',
    redirect: (ctx, state) {
      final isSplash = state.matchedLocation == '/splash';
      if (isSplash) return null; // Always let splash render

      final loggedIn = auth.valueOrNull != null;
      final isAuthRoute = state.matchedLocation.startsWith('/login') ||
          state.matchedLocation.startsWith('/register');

      if (!loggedIn && !isAuthRoute) return '/login';
      if (loggedIn && isAuthRoute) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        pageBuilder: (c, s) => _fade(s, const SplashScreen()),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (c, s) => _fade(s, const LoginScreen()),
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (c, s) => _slide(s, const RegisterScreen()),
      ),
      ShellRoute(
        navigatorKey: _shellKey,
        builder: (c, s, child) => MainNav(child: child),
        routes: [
          GoRoute(
              path: '/', pageBuilder: (c, s) => _none(s, const HomeScreen())),
          GoRoute(
              path: '/explore',
              pageBuilder: (c, s) => _none(s, const ExploreScreen())),
          GoRoute(
              path: '/cart',
              pageBuilder: (c, s) => _none(s, const CartScreen())),
          GoRoute(
              path: '/wishlist',
              pageBuilder: (c, s) => _none(s, const WishlistScreen())),
          GoRoute(
              path: '/profile',
              pageBuilder: (c, s) => _none(s, const ProfileScreen())),
        ],
      ),
      GoRoute(
        path: '/product/:id',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) =>
            _slideUp(s, ProductDetailScreen(product: s.extra as Product?)),
      ),
      GoRoute(
        path: '/checkout',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) => _slideUp(s, const CheckoutScreen()),
      ),
      GoRoute(
        path: '/orders',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) => _slide(s, const OrdersScreen()),
      ),
      GoRoute(
        path: '/try-on',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) =>
            _fade(s, TryOnScreen(product: s.extra as Product?)),
      ),
      GoRoute(
        path: '/qr-scanner',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) => _fade(s, const QrScannerScreen()),
      ),
      GoRoute(
        path: '/rack/:id',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) => _slide(
            s,
            RackProductsScreen(
                rackId: s.pathParameters['id']!, extra: s.extra)),
      ),
      GoRoute(
        path: '/order-success',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) =>
            _slideUp(s, OrderSuccessScreen(order: s.extra as AppOrder)),
      ),
      GoRoute(
        path: '/addresses',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) => _slide(s, const AddressesScreen()),
      ),
      GoRoute(
        path: '/promo-codes',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) => _slide(s, const PromoCodesScreen()),
      ),
      GoRoute(
        path: '/notifications',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) => _slide(s, const NotificationsScreen()),
      ),
      GoRoute(
        path: '/help',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) => _slide(s, const HelpSupportScreen()),
      ),
      GoRoute(
        path: '/about',
        parentNavigatorKey: _rootKey,
        pageBuilder: (c, s) => _slide(s, const AboutScreen()),
      ),
    ],
  );
});

Page<dynamic> _fade(GoRouterState s, Widget c) => CustomTransitionPage(
    key: s.pageKey,
    child: c,
    transitionsBuilder: (ctx, a, b, ch) =>
        FadeTransition(opacity: a, child: ch));
Page<dynamic> _none(GoRouterState s, Widget c) =>
    NoTransitionPage(key: s.pageKey, child: c);
Page<dynamic> _slide(GoRouterState s, Widget c) => CustomTransitionPage(
    key: s.pageKey,
    child: c,
    transitionsBuilder: (ctx, a, b, ch) => SlideTransition(
        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
        child: ch));
Page<dynamic> _slideUp(GoRouterState s, Widget c) => CustomTransitionPage(
    key: s.pageKey,
    child: c,
    transitionsBuilder: (ctx, a, b, ch) => SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
            .animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
        child: ch));
