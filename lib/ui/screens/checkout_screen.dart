import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aura_app/core/theme/colors.dart';
import 'package:aura_app/data/models/cart_item.dart';
import 'package:aura_app/data/models/address.dart';
import 'package:aura_app/providers/auth_provider.dart';
import 'package:aura_app/providers/cart_provider.dart';
import 'package:aura_app/providers/orders_provider.dart';
import 'package:aura_app/ui/widgets/shared_buttons.dart';
import 'package:aura_app/ui/widgets/shared_image.dart';
import 'package:aura_app/ui/widgets/summary_row.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _COState();
}

class _COState extends ConsumerState<CheckoutScreen> {
  int _step = 0, _payment = 0;
  bool _placing = false;
  static const _payments = ['Card Payment', 'Cash on Delivery'];

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).valueOrNull;
    final items = ref.watch(cartProvider);
    final sub = ref.read(cartProvider.notifier).subtotal;
    final ship = ref.read(cartProvider.notifier).shipping;
    final tot = sub + ship;
    final addr = user?.defaultAddress;

    return Scaffold(
      backgroundColor: context.colors.canvas,
      appBar: AppBar(
          title: Text('Checkout',
              style: GoogleFonts.cormorantGaramond(
                  fontSize: 20, fontWeight: FontWeight.w700)),
          backgroundColor: context.colors.white,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
              onPressed: () => context.pop())),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Stepper
            Row(
                children: ['Address', 'Payment', 'Review']
                    .asMap()
                    .entries
                    .map((e) => Expanded(
                            child: Row(children: [
                          Expanded(
                              child: Column(children: [
                            Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                    color: _step >= e.key ? context.colors.ink : context.colors.n200,
                                    shape: BoxShape.circle),
                                child: Center(
                                    child: _step > e.key
                                        ? Icon(Icons.check,
                                            color: context.colors.white, size: 14)
                                        : Text('${e.key + 1}',
                                            style: TextStyle(
                                                color: _step >= e.key
                                                    ? context.colors.white
                                                    : context.colors.n500,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700)))),
                            const SizedBox(height: 4),
                            Text(e.value,
                                style: GoogleFonts.dmSans(
                                    fontSize: 10,
                                    color: _step >= e.key ? context.colors.ink : context.colors.n400,
                                    fontWeight: FontWeight.w500)),
                          ])),
                          if (e.key < 2)
                            Expanded(
                                child: Container(
                                    height: 1.5,
                                    color: _step > e.key ? context.colors.ink : context.colors.n200)),
                        ])))
                    .toList()),
            const SizedBox(height: 28),

            if (_step == 0) ..._addressStep(addr),
            if (_step == 1) ..._paymentStep(context),
            if (_step == 2) ..._reviewStep(context, items, sub, ship, tot, addr),
          ])),
    );
  }

  List<Widget> _addressStep(Address? addr) => [
        Text('Delivery Address',
            style: GoogleFonts.cormorantGaramond(
                fontSize: 22, fontWeight: FontWeight.w700)),
        const SizedBox(height: 14),
        if (addr != null)
          Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: context.colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: context.colors.gold, width: 1.5),
                  boxShadow: [BoxShadow(color: context.colors.shadow, blurRadius: 6)]),
              child: Row(children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: context.colors.goldLight, shape: BoxShape.circle),
                    child: Icon(Icons.location_on_outlined,
                        color: context.colors.gold, size: 20)),
                const SizedBox(width: 12),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(addr.name,
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w700, fontSize: 14)),
                      const SizedBox(height: 2),
                      Text(addr.full,
                          style: GoogleFonts.dmSans(
                              fontSize: 12, color: context.colors.n600, height: 1.5)),
                      Text(addr.phone,
                          style:
                              GoogleFonts.dmSans(fontSize: 12, color: context.colors.n500)),
                    ])),
                Icon(Icons.check_circle_rounded, color: context.colors.gold),
              ])),
        const SizedBox(height: 28),
        Btn(
            text: 'Continue to Payment',
            onPressed: () => setState(() => _step = 1)),
      ];

  List<Widget> _paymentStep(BuildContext context) => [
        Text('Payment Method',
            style: GoogleFonts.cormorantGaramond(
                fontSize: 22, fontWeight: FontWeight.w700)),
        const SizedBox(height: 14),
        ..._payments.asMap().entries.map((e) => GestureDetector(
            onTap: () => setState(() => _payment = e.key),
            child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: context.colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: _payment == e.key ? context.colors.gold : context.colors.border,
                        width: _payment == e.key ? 1.5 : 1),
                    boxShadow: [
                      BoxShadow(color: context.colors.shadow, blurRadius: 6)
                    ]),
                child: Row(children: [
                  Icon(
                      _payment == e.key
                          ? Icons.radio_button_checked_rounded
                          : Icons.radio_button_unchecked_rounded,
                      color: _payment == e.key ? context.colors.gold : context.colors.n400),
                  const SizedBox(width: 12),
                  Icon(
                      e.key == 0
                          ? Icons.credit_card_rounded
                          : Icons.local_shipping_outlined,
                      color: context.colors.n700),
                  const SizedBox(width: 10),
                  Text(e.value,
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w500, fontSize: 14)),
                ])))),
        const SizedBox(height: 4),
        Row(children: [
          Expanded(
              child: OutBtn(
                  text: 'Back', onPressed: () => setState(() => _step = 0))),
          const SizedBox(width: 12),
          Expanded(
              flex: 2,
              child: Btn(
                  text: 'Review Order',
                  onPressed: () => setState(() => _step = 2))),
        ]),
      ];

  List<Widget> _reviewStep(BuildContext context, List<CartItem> items, double sub,
          double ship, double tot, Address? addr) =>
      [
        Text('Order Summary',
            style: GoogleFonts.cormorantGaramond(
                fontSize: 22, fontWeight: FontWeight.w700)),
        const SizedBox(height: 14),
        ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: context.colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: context.colors.border),
                    boxShadow: [
                      BoxShadow(color: context.colors.shadow, blurRadius: 6)
                    ]),
                child: Row(children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Img(item.product.images.first, w: 56, h: 64)),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(item.product.name,
                            style: GoogleFonts.dmSans(
                                fontSize: 13, fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        Text('${item.selectedSize} × ${item.quantity}',
                            style: GoogleFonts.dmSans(
                                fontSize: 12, color: context.colors.n500)),
                      ])),
                  Text('\$${item.total.toStringAsFixed(2)}',
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w700, fontSize: 14)),
                ])))),
        Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: context.colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: context.colors.border),
                boxShadow: [BoxShadow(color: context.colors.shadow, blurRadius: 6)]),
            child: Column(children: [
              SumRow('Subtotal', '\$${sub.toStringAsFixed(2)}'),
              SumRow('Shipping',
                  ship == 0 ? 'FREE' : '\$${ship.toStringAsFixed(2)}',
                  valueColor: ship == 0 ? context.colors.success : null),
              const Divider(height: 16),
              SumRow('Total', '\$${tot.toStringAsFixed(2)}', bold: true),
            ])),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(
              child: OutBtn(
                  text: 'Back', onPressed: () => setState(() => _step = 1))),
          const SizedBox(width: 12),
          Expanded(
              flex: 2,
              child: Btn(
                  text: 'Place Order',
                  loading: _placing,
                  bg: context.colors.gold,
                  onPressed: () async {
                    setState(() => _placing = true);
                    if (addr == null) {
                      setState(() => _placing = false);
                      return;
                    }
                    final router = GoRouter.of(context);
                    final order = await ref.read(ordersProvider.notifier).place(
                        items: items,
                        address: addr,
                        payment: _payments[_payment]);
                    ref.read(cartProvider.notifier).clear();
                    setState(() => _placing = false);
                    router.pushReplacement('/order-success', extra: order);
                  })),
        ]),
      ];
}
