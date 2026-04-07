import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:aura_app/core/theme/colors.dart';
import 'package:aura_app/core/constants/mock_data.dart';

class QrScannerScreen extends ConsumerStatefulWidget {
  const QrScannerScreen({super.key});

  @override
  ConsumerState<QrScannerScreen> createState() => _QRState();
}

class _QRState extends ConsumerState<QrScannerScreen>
    with SingleTickerProviderStateMixin {
  bool _scanned = false;
  String? _scannedRack;
  late AnimationController _scanCtrl;
  late Animation<double> _scanAnim;
  final _camCtrl = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _scanCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
    _scanAnim = Tween<double>(begin: 0, end: 1).animate(_scanCtrl);
  }

  @override
  void dispose() {
    _scanCtrl.dispose();
    _camCtrl.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_scanned) return;
    for (final bc in capture.barcodes) {
      if (bc.rawValue != null) {
        String rackId = bc.rawValue!;
        if (!kRackNames.containsKey(rackId)) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Demo: Using default rack for "$rackId"'),
              backgroundColor: context.colors.gold,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2)));
          rackId = kRackNames.keys.first;
        }
        setState(() {
          _scanned = true;
          _scannedRack = rackId;
        });
        HapticFeedback.heavyImpact();
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.colors.black,
        body: Stack(children: [
          Positioned.fill(
              child: MobileScanner(controller: _camCtrl, onDetect: _onDetect)),

          Positioned.fill(child: CustomPaint(painter: _QRPainter(_scanAnim, context.colors))),

          // Top bar
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(children: [
                        GestureDetector(
                            onTap: () => context.pop(),
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle),
                                child: Icon(Icons.close,
                                    color: context.colors.white, size: 20))),
                        const SizedBox(width: 12),
                        Text('Rack Scanner',
                            style: GoogleFonts.dmSans(
                                color: context.colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16)),
                      ])))),

          Positioned(
              top: 110,
              left: 0,
              right: 0,
              child: Text('Point camera at the QR code on a clothing rack',
                  style: GoogleFonts.dmSans(
                      color: Colors.white.withValues(alpha: 0.75), fontSize: 13),
                  textAlign: TextAlign.center)),

          // Result overlay
          if (_scanned && _scannedRack != null)
            Positioned.fill(
                child: Container(
              color: Colors.black.withValues(alpha: 0.7),
              child: Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.check_circle_rounded,
                        color: context.colors.success, size: 68)
                    .animate()
                    .scale(duration: 500.ms, curve: Curves.elasticOut),
                const SizedBox(height: 16),
                Text('Rack Found!',
                        style: GoogleFonts.cormorantGaramond(
                            color: context.colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24))
                    .animate()
                    .fadeIn(delay: 200.ms),
                const SizedBox(height: 6),
                Text(kRackNames[_scannedRack]!,
                        style: GoogleFonts.dmSans(
                            color: context.colors.gold,
                            fontSize: 16,
                            fontWeight: FontWeight.w600))
                    .animate()
                    .fadeIn(delay: 300.ms),
                const SizedBox(height: 28),
                ElevatedButton.icon(
                        onPressed: () => context.pushReplacement(
                            '/rack/$_scannedRack',
                            extra: kRackNames[_scannedRack]),
                        icon: const Icon(Icons.grid_view_rounded),
                        label: const Text('View Rack Items'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: context.colors.gold,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))))
                    .animate()
                    .fadeIn(delay: 400.ms),
                const SizedBox(height: 14),
                TextButton(
                    onPressed: () => setState(() {
                          _scanned = false;
                          _scannedRack = null;
                        }),
                    child: Text('Scan Again',
                        style: GoogleFonts.dmSans(color: context.colors.white))),
              ])),
            )),
        ]),
      );
}

class _QRPainter extends CustomPainter {
  final Animation<double> anim;
  final AppColors colors;
  _QRPainter(this.anim, this.colors) : super(repaint: anim);

  @override
  void paint(Canvas canvas, Size sz) {
    final cx = sz.width / 2, cy = sz.height / 2;
    const s = 220.0, r = 16.0;

    // Dim overlay
    canvas.drawPath(
        Path.combine(
            PathOperation.difference,
            Path()..addRect(Offset.zero & sz),
            Path()
              ..addRRect(RRect.fromRectAndRadius(
                  Rect.fromCenter(center: Offset(cx, cy), width: s, height: s),
                  const Radius.circular(r)))),
        Paint()..color = Colors.black.withValues(alpha: 0.65));

    // Corner brackets
    final p = Paint()
      ..color = colors.gold
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    const l = s / 2, bl = 26.0;
    for (final c in [
      Offset(cx - l + r, cy - l + r),
      Offset(cx + l - r, cy - l + r),
      Offset(cx - l + r, cy + l - r),
      Offset(cx + l - r, cy + l - r),
    ]) {
      final dx = c.dx < cx ? -1.0 : 1.0;
      final dy = c.dy < cy ? -1.0 : 1.0;
      canvas.drawPath(
          Path()
            ..moveTo(c.dx + dx * bl, c.dy)
            ..lineTo(c.dx, c.dy)
            ..lineTo(c.dx, c.dy + dy * bl),
          p);
    }

    // Scan line
    final scanY = cy - l + r + (s - 2 * r) * anim.value;
    canvas.drawLine(
        Offset(cx - l + r + 4, scanY),
        Offset(cx + l - r - 4, scanY),
        Paint()
          ..color = colors.gold
          ..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(_QRPainter o) => true;
}
