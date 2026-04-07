import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noir_app/core/theme/colors.dart';

class SumRow extends StatelessWidget {
  final String label, value;
  final Color? valueColor;
  final bool bold;

  const SumRow(this.label, this.value, {super.key, this.valueColor, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, 
            style: GoogleFonts.dmSans(
              fontSize: 14, 
              color: context.colors.n600, 
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400
            )),
          Text(value, 
            style: GoogleFonts.dmSans(
              fontSize: 14, 
              color: valueColor ?? context.colors.ink, 
              fontWeight: bold ? FontWeight.w700 : FontWeight.w600
            )),
        ],
      ),
    );
  }
}
