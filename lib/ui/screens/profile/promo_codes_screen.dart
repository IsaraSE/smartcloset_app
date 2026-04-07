import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aura_app/core/theme/colors.dart';

class PromoCodesScreen extends StatelessWidget {
  const PromoCodesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.canvas,
      appBar: AppBar(
        title: const Text('Promo Codes'),
        backgroundColor: context.colors.white,
      ),
      body: Column(children: [
        // Top section: Apply new code
        Container(
          padding: const EdgeInsets.all(20),
          color: context.colors.white,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Apply a new code',
                    style: GoogleFonts.dmSans(
                        fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter code here...',
                        filled: true,
                        fillColor: context.colors.n50,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: context.colors.border)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: const Text('Apply')),
                ]),
              ]),
        ),

        const SizedBox(height: 12),

        // List of available codes
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _kPromoCodes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (ctx, i) => _PromoCard(_kPromoCodes[i]),
          ),
        ),
      ]),
    );
  }
}

class _PromoCard extends StatelessWidget {
  final Map<String, dynamic> promo;
  const _PromoCard(this.promo);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: context.colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: context.colors.shadow, blurRadius: 10)],
          border: Border.all(color: context.colors.border),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: context.colors.goldLight,
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.local_offer_rounded,
                    color: context.colors.gold, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(promo['title'],
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: context.colors.ink)),
                    const SizedBox(height: 4),
                    Text(promo['desc'],
                        style: GoogleFonts.dmSans(
                            fontSize: 12, color: context.colors.n600)),
                  ])),
            ]),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(children: [
              Text('CODE: ',
                  style: GoogleFonts.dmSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: context.colors.n400)),
              Text(promo['code'],
                  style: GoogleFonts.dmSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: context.colors.gold,
                      letterSpacing: 0.5)),
              const Spacer(),
              _CopyBtn(promo['code']),
            ]),
          ),
        ]),
      );
}

class _CopyBtn extends StatelessWidget {
  final String code;
  const _CopyBtn(this.code);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          Clipboard.setData(ClipboardData(text: code));
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Code $code copied to clipboard!')));
        },
        child: Text('COPY',
            style: GoogleFonts.dmSans(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: context.colors.ink)),
      );
}

final _kPromoCodes = [
  {
    'title': 'Welcome Offer',
    'desc': 'Unlock 15% off your first purchase above \$100.',
    'code': 'NOIRFIRST15',
    'type': 'welcome',
  },
  {
    'title': 'Summer 2025 Drop',
    'desc': 'Get \$20 off on our new seasonal collection.',
    'code': 'SUMMER25',
    'type': 'seasonal',
  },
  {
    'title': 'Members Exclusive',
    'desc': 'Free shipping on all orders for NOIR members.',
    'code': 'SHIPFREE',
    'type': 'loyalty',
  },
];
