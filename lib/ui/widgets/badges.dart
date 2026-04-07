import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aura_app/core/theme/colors.dart';

class Stars extends StatelessWidget {
  final double rating;
  final int count;
  final double sz;

  const Stars({super.key, required this.rating, this.count = 0, this.sz = 13});

  @override
  Widget build(BuildContext ctx) =>
      Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.star_rounded, color: C.gold, size: sz),
        const SizedBox(width: 2),
        Text(rating.toStringAsFixed(1),
            style: GoogleFonts.dmSans(
                fontSize: sz - 1, fontWeight: FontWeight.w600, color: C.n700)),
        if (count > 0)
          Text(' ($count)',
              style: GoogleFonts.dmSans(fontSize: sz - 1, color: C.n400)),
      ]);
}

class SaleBadge extends StatelessWidget {
  final double pct;
  const SaleBadge({super.key, required this.pct});

  @override
  Widget build(BuildContext ctx) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
            color: C.gold, borderRadius: BorderRadius.circular(2)),
        child: Text('-${pct.toInt()}%',
            style: GoogleFonts.dmSans(
                color: C.white, fontSize: 9, fontWeight: FontWeight.w700)),
      );
}

class NewBadge extends StatelessWidget {
  const NewBadge({super.key});

  @override
  Widget build(BuildContext ctx) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration:
            BoxDecoration(color: C.ink, borderRadius: BorderRadius.circular(2)),
        child: Text('NEW',
            style: GoogleFonts.dmSans(
                color: C.white,
                fontSize: 9,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8)),
      );
}
