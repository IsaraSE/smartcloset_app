import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:noir_app/core/theme/colors.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.canvas,
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: context.colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Search help
          TextField(
            decoration: InputDecoration(
              hintText: 'Search FAQ...',
              prefixIcon: Icon(Icons.search_rounded, color: context.colors.n400),
              filled: true,
              fillColor: context.colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: context.colors.border)),
            ),
          ),
          const SizedBox(height: 24),

          // Quick Contact Tiles
          Text('Contact Us',
              style: GoogleFonts.dmSans(
                  fontSize: 14, fontWeight: FontWeight.w700, color: context.colors.ink)),
          const SizedBox(height: 12),
          Row(children: [
            _ContactTile(Icons.chat_bubble_outline_rounded, 'Live Chat', () {}),
            const SizedBox(width: 12),
            _ContactTile(Icons.call_outlined, 'Call Us', () {}),
            const SizedBox(width: 12),
            _ContactTile(Icons.mark_as_unread_outlined, 'Email', () {}),
          ]),

          const SizedBox(height: 32),

          // FAQ Section
          Text('Frequently Asked Questions',
              style: GoogleFonts.dmSans(
                  fontSize: 14, fontWeight: FontWeight.w700, color: context.colors.ink)),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _kFAQs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (ctx, i) => _FAQTile(_kFAQs[i]),
          ),
          const SizedBox(height: 32),
        ]),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData ic;
  final String label;
  final VoidCallback onTap;
  const _ContactTile(this.ic, this.label, this.onTap);

  @override
  Widget build(BuildContext context) => Expanded(
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: context.colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.colors.border),
              boxShadow: [BoxShadow(color: context.colors.shadow, blurRadius: 6)],
            ),
            child: Column(children: [
              Icon(ic, color: context.colors.gold, size: 24),
              const SizedBox(height: 8),
              Text(label,
                  style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: context.colors.n800)),
            ]),
          ),
        ),
      );
}

class _FAQTile extends StatelessWidget {
  final Map<String, String> faq;
  const _FAQTile(this.faq);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: context.colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.colors.border),
        ),
        child: ExpansionTile(
          shape: const RoundedRectangleBorder(side: BorderSide.none),
          title: Text(faq['q']!,
              style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: context.colors.ink)),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(faq['a']!,
                  style: GoogleFonts.dmSans(
                      fontSize: 13, color: context.colors.n600, height: 1.5)),
            ),
          ],
        ),
      );
}

final _kFAQs = [
  {
    'q': 'How can I track my order?',
    'a': 'You can track your order status in the "My Orders" section of your profile. Once dispatched, you will receive a tracking link via email.',
  },
  {
    'q': 'What is your return policy?',
    'a': 'We offer a 30-day return policy for all unworn and unwashed items with tags attached. You can initiate a return through the order details page.',
  },
  {
    'q': 'How do I use a promo code?',
    'a': 'You can apply a promo code during checkout in the "Coupon" field or apply it directly in your "Promo Codes" section in the profile.',
  },
];
