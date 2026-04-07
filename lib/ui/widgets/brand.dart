import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aura_app/core/theme/colors.dart';

class NoirLogo extends StatelessWidget {
  final double size;
  final bool dark;
  const NoirLogo({super.key, this.size = 36, this.dark = false});

  @override
  Widget build(BuildContext ctx) =>
      Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              color: dark ? C.white : C.ink,
              borderRadius: BorderRadius.circular(size * 0.22)),
          child: Center(
              child: Text('N',
                  style: GoogleFonts.cormorantGaramond(
                      color: dark ? C.ink : C.white,
                      fontSize: size * 0.6,
                      fontWeight: FontWeight.w700))),
        ),
        const SizedBox(width: 10),
        Text('NOIR',
            style: GoogleFonts.dmSans(
                color: dark ? C.white : C.ink,
                fontWeight: FontWeight.w700,
                fontSize: size * 0.47,
                letterSpacing: 2)),
      ]);
}
