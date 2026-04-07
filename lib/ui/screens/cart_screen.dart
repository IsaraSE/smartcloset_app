import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aura_app/core/theme/colors.dart';
import 'package:aura_app/data/models/cart_item.dart';
import 'package:aura_app/providers/cart_provider.dart';
import 'package:aura_app/ui/widgets/shared_buttons.dart';
import 'package:aura_app/ui/widgets/shared_image.dart';
import 'package:aura_app/ui/widgets/empty_view.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartState();
}

class _CartState extends ConsumerState<CartScreen> {
  final _promoCtrl = TextEditingController();
  double _discount = 0;

  @override
  void dispose() {
    _promoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    final items = ref.watch(cartProvider);
    final notifier = ref.read(cartProvider.notifier);
    final sub = notifier.subtotal;
    final ship = notifier.shipping;
    final tot = sub - _discount + ship;

    if (items.isEmpty) {
      return Scaffold(
          backgroundColor: C.canvas,
          appBar: AppBar(
              title: const Text('My Cart'), automaticallyImplyLeading: false),
          body: EmptyView(
              icon: Icons.shopping_bag_outlined,
              title: 'Your cart is empty',
              desc: "Browse our collection and add items you love.",
              btnLabel: 'Start Shopping',
              onBtn: () => ctx.go('/explore')));
    }

    return Scaffold(
      backgroundColor: C.canvas,
      appBar: AppBar(
          title: Text('My Cart (${items.length})',
              style: GoogleFonts.cormorantGaramond(
                  fontSize: 20, fontWeight: FontWeight.w700, color: C.ink)),
          backgroundColor: C.white,
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
                onPressed: () {
                  ref.read(cartProvider.notifier).clear();
                  setState(() => _discount = 0);
                },
                child: Text('Clear All',
                    style: GoogleFonts.dmSans(color: C.error, fontSize: 13))),
          ]),
      body: Column(children: [
        Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final item = items[i];
                  return _CartTile(item,
                      onRemove: () =>
                          ref.read(cartProvider.notifier).remove(item.id),
                      onQtyChange: (q) => ref
                          .read(cartProvider.notifier)
                          .updateQty(item.id, q));
                })),

        // ── Order summary ─────────────────────────────────
        Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            decoration: BoxDecoration(
              color: C.white,
              border: const Border(top: BorderSide(color: C.border)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, -4))
              ],
            ),
            child: Column(children: [
              // Promo code
              Row(children: [
                Expanded(
                    child: TextField(
                  controller: _promoCtrl,
                  style: GoogleFonts.dmSans(fontSize: 14),
                  decoration: InputDecoration(
                      hintText: 'Promo code',
                      hintStyle:
                          GoogleFonts.dmSans(color: C.n400, fontSize: 14),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: C.border)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(color: C.border)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide:
                              const BorderSide(color: C.ink, width: 1.5))),
                )),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      if (_promoCtrl.text == 'NOIR20') {
                        setState(() => _discount = sub * 0.2);
                        snack(ctx, '20% discount applied!');
                      } else {
                        snack(ctx, 'Invalid promo code', err: true);
                      }
                    },
                    child: const Text('Apply')),
              ]),
              const SizedBox(height: 16),
              SumRow('Subtotal', '\$${sub.toStringAsFixed(2)}'),
              if (_discount > 0)
                SumRow(
                    'Discount (NOIR20)', '-\$${_discount.toStringAsFixed(2)}',
                    valueColor: C.success),
              SumRow('Shipping',
                  ship == 0 ? 'FREE' : '\$${ship.toStringAsFixed(2)}',
                  valueColor: ship == 0 ? C.success : null),
              const Divider(height: 20),
              SumRow('Total', '\$${tot.toStringAsFixed(2)}', bold: true),
              const SizedBox(height: 14),
              SafeArea(
                  child: Btn(
                      text: 'Proceed to Checkout',
                      onPressed: () => ctx.push('/checkout'))),
              const SizedBox(height: 8),
            ])),
      ]),
    );
  }
}

Widget SumRow(String label, String val,
        {Color? valueColor, bool bold = false}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label,
            style: GoogleFonts.dmSans(
                fontSize: 14,
                color: C.n600,
                fontWeight: bold ? FontWeight.w600 : FontWeight.w400)),
        Text(val,
            style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
                color: valueColor ?? C.ink)),
      ]),
    );

class _CartTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;
  final ValueChanged<int> onQtyChange;

  const _CartTile(this.item,
      {required this.onRemove, required this.onQtyChange});

  @override
  Widget build(BuildContext ctx) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: C.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: C.border),
          boxShadow: const [
            BoxShadow(color: C.shadow, blurRadius: 6, offset: Offset(0, 2))
          ],
        ),
        child: Row(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Img(item.product.images.first, w: 80, h: 90)),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(item.product.brand,
                    style: GoogleFonts.dmSans(
                        fontSize: 10, color: C.n400, letterSpacing: 0.3)),
                Text(item.product.name,
                    style: GoogleFonts.dmSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: C.ink),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text('${item.selectedSize} · ${item.selectedColor}',
                    style: GoogleFonts.dmSans(fontSize: 11, color: C.n500)),
                const SizedBox(height: 6),
                Text('\$${item.product.price.toStringAsFixed(2)}',
                    style: GoogleFonts.dmSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: C.ink)),
              ])),
          Column(children: [
            IconButton(
                icon: const Icon(Icons.delete_outline_rounded,
                    color: C.n300, size: 19),
                onPressed: onRemove,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints()),
            const SizedBox(height: 8),
            Row(children: [
              _QBtn(Icons.remove, () => onQtyChange(item.quantity - 1)),
              SizedBox(
                  width: 32,
                  child: Text('${item.quantity}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w700, fontSize: 14))),
              _QBtn(Icons.add, () => onQtyChange(item.quantity + 1)),
            ]),
          ]),
        ]),
      );
}

class _QBtn extends StatelessWidget {
  final IconData ic;
  final VoidCallback onTap;
  const _QBtn(this.ic, this.onTap);

  @override
  Widget build(BuildContext ctx) => GestureDetector(
      onTap: onTap,
      child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
              color: C.n100, borderRadius: BorderRadius.circular(4)),
          child: Icon(ic, size: 16, color: C.ink)));
}
