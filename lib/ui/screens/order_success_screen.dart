import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:aura_app/core/theme/colors.dart';
import 'package:aura_app/data/models/order.dart';
import 'package:aura_app/ui/widgets/summary_row.dart';
import 'package:aura_app/ui/widgets/shared_buttons.dart';

class OrderSuccessScreen extends StatelessWidget {
  final AppOrder order;
  const OrderSuccessScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.colors.white,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                              width: 96,
                              height: 96,
                              decoration: const BoxDecoration(
                                  color: Color(0xFFF0FDF4),
                                  shape: BoxShape.circle),
                              child: Icon(Icons.check_rounded,
                                  color: context.colors.success, size: 52))
                          .animate()
                          .scale(
                              delay: 200.ms,
                              duration: 600.ms,
                              curve: Curves.elasticOut),
                      const SizedBox(height: 24),
                      Text('Order Placed!',
                              style: GoogleFonts.cormorantGaramond(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: context.colors.ink))
                          .animate()
                          .fadeIn(delay: 400.ms),
                      const SizedBox(height: 8),
                      Text('${order.orderNumber} has been confirmed.',
                              style: GoogleFonts.dmSans(
                                  fontSize: 14, color: context.colors.n600, height: 1.5),
                              textAlign: TextAlign.center)
                          .animate()
                          .fadeIn(delay: 500.ms),
                      const SizedBox(height: 32),
                      Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: context.colors.n50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: context.colors.border)),
                          child: Column(children: [
                            SumRow('Order', order.orderNumber),
                            SumRow('Payment', order.paymentMethod),
                            SumRow('Est. Delivery',
                                '${order.estimatedDelivery?.day}/${order.estimatedDelivery?.month}/${order.estimatedDelivery?.year}'),
                            const Divider(height: 16),
                            SumRow(
                                'Total', '\$${order.total.toStringAsFixed(2)}',
                                bold: true),
                          ])).animate().fadeIn(delay: 600.ms),
                      const SizedBox(height: 32),
                      Btn(
                              text: 'Track My Order',
                              onPressed: () => context.pushReplacement('/orders'))
                          .animate()
                          .fadeIn(delay: 700.ms),
                      const SizedBox(height: 12),
                      OutBtn(
                              text: 'Continue Shopping',
                              onPressed: () => context.go('/'))
                          .animate()
                          .fadeIn(delay: 800.ms),
                    ]))),
      );
}
