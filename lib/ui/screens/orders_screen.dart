import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aura_app/core/theme/colors.dart';
import 'package:aura_app/data/models/order.dart';
import 'package:aura_app/providers/orders_provider.dart';
import 'package:aura_app/ui/widgets/empty_view.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);
    return Scaffold(
      backgroundColor: context.colors.canvas,
      appBar: AppBar(
          title: const Text('My Orders'),
          backgroundColor: context.colors.white,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
              onPressed: () => context.pop())),
      body: orders.isEmpty
          ? const EmptyView(
              icon: Icons.receipt_long_outlined,
              title: 'No orders yet',
              desc: 'Your order history will appear here.')
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              itemCount: orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _OrderCard(orders[i])),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final AppOrder o;
  const _OrderCard(this.o);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: context.colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.colors.border),
            boxShadow: [
              BoxShadow(color: context.colors.shadowMd, blurRadius: 8, offset: const Offset(0, 3))
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(o.orderNumber,
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700, fontSize: 14, color: context.colors.ink)),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: o.status.color.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(o.status.label,
                    style: GoogleFonts.dmSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: o.status.color))),
          ]),
          const SizedBox(height: 6),
          Text('${o.createdAt.day}/${o.createdAt.month}/${o.createdAt.year}',
              style: GoogleFonts.dmSans(fontSize: 12, color: context.colors.n500)),
          const SizedBox(height: 14),
          if (o.status != OrderStatus.cancelled) ...[
            Row(
                children: List.generate(4, (i) {
              final active = o.status.step >= i;
              return Expanded(
                  child: Row(children: [
                Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: active ? context.colors.ink : context.colors.n200, shape: BoxShape.circle),
                    child: Center(
                        child: Icon(Icons.check,
                            size: 12, color: active ? context.colors.white : context.colors.n400))),
                if (i < 3)
                  Expanded(
                      child: Container(
                          height: 2,
                          color: active && o.status.step > i ? context.colors.ink : context.colors.n200)),
              ]));
            })),
            const SizedBox(height: 5),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ['Placed', 'Processing', 'Shipped', 'Delivered']
                    .map((s) => Text(s,
                        style: GoogleFonts.dmSans(fontSize: 9, color: context.colors.n400)))
                    .toList()),
            const SizedBox(height: 14),
          ],
          const Divider(),
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Total',
                style: GoogleFonts.dmSans(fontSize: 14, color: context.colors.n600)),
            Text('\$${o.total.toStringAsFixed(2)}',
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700, fontSize: 16, color: context.colors.ink)),
          ]),
        ]),
      );
}
