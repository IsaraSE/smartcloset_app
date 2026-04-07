import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aura_app/core/theme/colors.dart';
import 'package:aura_app/ui/widgets/shared_buttons.dart';

class EmptyView extends StatelessWidget {
  final IconData icon;
  final String title, desc;
  final String? btnLabel;
  final VoidCallback? onBtn;

  const EmptyView({
    super.key,
    required this.icon,
    required this.title,
    required this.desc,
    this.btnLabel,
    this.onBtn,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
            padding: const EdgeInsets.all(40),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                      color: context.colors.n100, shape: BoxShape.circle),
                  child: Icon(icon, size: 36, color: context.colors.n300)),
              const SizedBox(height: 20),
              Text(title,
                  style: GoogleFonts.cormorantGaramond(
                      fontSize: 22, fontWeight: FontWeight.w600, color: context.colors.ink),
                  textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(desc,
                  style: GoogleFonts.dmSans(
                      fontSize: 14, color: context.colors.n500, height: 1.5),
                  textAlign: TextAlign.center),
              if (btnLabel != null && onBtn != null) ...[
                const SizedBox(height: 28),
                Btn(text: btnLabel!, onPressed: onBtn, w: 180),
              ],
            ])),
      );
}
