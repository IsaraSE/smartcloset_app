import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:noir_app/core/theme/colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.canvas,
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: context.colors.white,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Mark all as read',
                style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: context.colors.gold)),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _kNotifs.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (ctx, i) => _NotifTile(_kNotifs[i]),
      ),
    );
  }
}

class _NotifTile extends StatelessWidget {
  final Map<String, dynamic> n;
  const _NotifTile(this.n);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: n['isRead'] ? context.colors.white : context.colors.n50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.colors.border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                    color: _getIconCol(context, n['type']),
                    shape: BoxShape.circle),
                child: Icon(_getIcon(n['type']),
                    color: context.colors.white, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(n['title'],
                                style: GoogleFonts.dmSans(
                                    fontWeight: n['isRead']
                                        ? FontWeight.w600
                                        : FontWeight.w700,
                                    fontSize: 14)),
                          ),
                          Text(n['time'],
                              style: GoogleFonts.dmSans(
                                  fontSize: 10, color: context.colors.n400)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(n['desc'],
                          style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: context.colors.n600,
                              height: 1.4)),
                    ]),
              ),
            ],
          ),
        ),
      );

  IconData _getIcon(String type) => switch (type) {
        'order' => Icons.shopping_bag_outlined,
        'promo' => Icons.local_offer_outlined,
        'alert' => Icons.notifications_none_rounded,
        _ => Icons.info_outline_rounded,
      };

  Color _getIconCol(BuildContext context, String type) => switch (type) {
        'order' => context.colors.gold,
        'promo' => context.colors.success,
        'alert' => context.colors.error,
        _ => context.colors.ink,
      };
}

final _kNotifs = [
  {
    'title': 'Order Dispatched!',
    'desc':
        'Your order #NR-2025-001 has been dispatched and is on its way to you.',
    'time': '2h ago',
    'type': 'order',
    'isRead': false,
  },
  {
    'title': 'New Exclusive Drop',
    'desc': 'Discover the Noir Summer Collection—available only for members.',
    'time': 'Yesterday',
    'type': 'promo',
    'isRead': true,
  },
  {
    'title': 'Price Drop Alert',
    'desc': 'Items in your wishlist have successfully dropped in price!',
    'time': '2 days ago',
    'type': 'alert',
    'isRead': true,
  },
];
