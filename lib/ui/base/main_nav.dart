import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aura_app/core/theme/colors.dart';
import 'package:aura_app/providers/cart_provider.dart';

class MainNav extends ConsumerWidget {
  final Widget child;
  const MainNav({super.key, required this.child});

  static const _routes = ['/', '/explore', '/cart', '/wishlist', '/profile'];

  int _idx(String loc) {
    for (int i = _routes.length - 1; i >= 0; i--) {
      if (loc.startsWith(_routes[i])) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = GoRouterState.of(context).matchedLocation;
    final cur = _idx(loc);
    final count = ref.watch(cartCountProvider);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: context.colors.white,
          border: Border(top: BorderSide(color: context.colors.border, width: 1)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, -4))
          ],
        ),
        child: SafeArea(
            child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavItem(Icons.home_outlined, Icons.home, 'Home', cur == 0,
                        () => context.go('/'), null),
                    _NavItem(Icons.grid_view_outlined, Icons.grid_view,
                        'Explore', cur == 1, () => context.go('/explore'), null),
                    _NavItem(
                        Icons.shopping_bag_outlined,
                        Icons.shopping_bag,
                        'Cart',
                        cur == 2,
                        () => context.go('/cart'),
                        count > 0 ? count : null),
                    _NavItem(
                        Icons.favorite_border_rounded,
                        Icons.favorite_rounded,
                        'Saved',
                        cur == 3,
                        () => context.go('/wishlist'),
                        null),
                    _NavItem(Icons.person_outline_rounded, Icons.person_rounded,
                        'Profile', cur == 4, () => context.go('/profile'), null),
                  ],
                ))),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData ic, ica;
  final String lbl;
  final bool active;
  final VoidCallback tap;
  final int? badge;

  const _NavItem(
      this.ic, this.ica, this.lbl, this.active, this.tap, this.badge);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: tap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
            width: 64,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(clipBehavior: Clip.none, children: [
                  Icon(active ? ica : ic,
                      size: 22, color: active ? context.colors.ink : context.colors.n400),
                  if (badge != null)
                    Positioned(
                        right: -6,
                        top: -6,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: context.colors.gold, shape: BoxShape.circle),
                          constraints:
                              const BoxConstraints(minWidth: 16, minHeight: 16),
                          child: Text('$badge',
                              style: TextStyle(
                                  color: context.colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center),
                        )),
                ]),
                const SizedBox(height: 4),
                Text(lbl,
                    style: GoogleFonts.dmSans(
                        fontSize: 10,
                        fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                        color: active ? context.colors.ink : context.colors.n400)),
                if (active)
                  Container(
                      margin: const EdgeInsets.only(top: 3),
                      width: 16,
                      height: 2,
                      decoration: BoxDecoration(
                          color: context.colors.gold,
                          borderRadius: BorderRadius.circular(1))),
              ],
            )),
      );
}
