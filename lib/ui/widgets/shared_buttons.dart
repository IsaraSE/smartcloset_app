import 'package:flutter/material.dart';

import 'package:aura_app/core/theme/colors.dart';

class Btn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  final double? w;
  final IconData? icon;
  final Color? bg, fg;
  final double h;

  const Btn({
    super.key,
    required this.text,
    this.onPressed,
    this.loading = false,
    this.w,
    this.icon,
    this.bg,
    this.fg,
    this.h = 52,
  });

  @override
  Widget build(BuildContext ctx) => SizedBox(
        width: w ?? double.infinity,
        height: h,
        child: ElevatedButton(
          onPressed: loading ? null : onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: bg ?? C.ink,
              foregroundColor: fg ?? C.white,
              disabledBackgroundColor: C.n200),
          child: loading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: fg ?? C.white))
              : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18),
                    const SizedBox(width: 8),
                  ],
                  Text(text),
                ]),
        ),
      );
}

class GoldBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? w;

  const GoldBtn({super.key, required this.text, this.onPressed, this.w});

  @override
  Widget build(BuildContext ctx) =>
      Btn(text: text, onPressed: onPressed, w: w, bg: C.gold, fg: C.white);
}

class OutBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? w;

  const OutBtn({super.key, required this.text, this.onPressed, this.w});

  @override
  Widget build(BuildContext ctx) => SizedBox(
      width: w ?? double.infinity,
      height: 52,
      child: OutlinedButton(onPressed: onPressed, child: Text(text)));
}

/// Section header with optional "See All" link
void snack(BuildContext ctx, String msg,
        {bool err = false, String? action, VoidCallback? onAction}) =>
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: err ? C.error : C.ink,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      action: action != null
          ? SnackBarAction(
              label: action, textColor: C.gold, onPressed: onAction ?? () {})
          : null,
    ));

// ── Animated Wishlist Heart Button ─────────────────────────
class WishBtn extends StatefulWidget {
  final bool isWished;
  final VoidCallback onTap;
  final double size;
  final bool shadow;

  const WishBtn({
    super.key,
    required this.isWished,
    required this.onTap,
    this.size = 15,
    this.shadow = false,
  });

  @override
  State<WishBtn> createState() => WishBtnState();
}

class WishBtnState extends State<WishBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.35), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.35, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(WishBtn old) {
    super.didUpdateWidget(old);
    if (widget.isWished && !old.isWished) _ctrl.forward(from: 0);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) => GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: widget.size + 22,
          height: widget.size + 22,
          decoration: BoxDecoration(
            color: C.white.withOpacity(0.92),
            shape: BoxShape.circle,
            boxShadow: widget.shadow
                ? const [BoxShadow(color: C.shadowMd, blurRadius: 8)]
                : [],
          ),
          child: Center(
              child: ScaleTransition(
            scale: _scale,
            child: Icon(
                widget.isWished
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: widget.isWished ? C.gold : C.n400,
                size: widget.size),
          )),
        ),
      );
}

// ── Logo Widget ────────────────────────────────────────────
