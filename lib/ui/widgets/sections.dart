import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aura_app/core/theme/colors.dart';

class SecHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onAll;

  const SecHeader({super.key, required this.title, this.onAll});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: GoogleFonts.cormorantGaramond(
                  fontSize: 22, fontWeight: FontWeight.w700, color: context.colors.ink)),
          if (onAll != null)
            TextButton(
              onPressed: onAll,
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: Text('See All',
                  style: GoogleFonts.dmSans(
                      fontSize: 13,
                      color: context.colors.gold,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3)),
            ),
        ],
      );
}
