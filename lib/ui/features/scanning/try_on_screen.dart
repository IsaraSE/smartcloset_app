import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';

import 'package:noir_app/core/theme/colors.dart';
import 'package:noir_app/data/models/product.dart';
import 'package:noir_app/ui/widgets/shared_buttons.dart';
import 'package:noir_app/ui/widgets/shared_image.dart';

class TryOnScreen extends ConsumerStatefulWidget {
  final Product? product;
  const TryOnScreen({super.key, this.product});

  @override
  ConsumerState<TryOnScreen> createState() => _TOState();
}

class _TOState extends ConsumerState<TryOnScreen> {
  bool _captured = false;
  double _scale = 1.0, _ox = 0, _oy = 0, _rot = 0;
  double _startScale = 1.0, _startRot = 0;
  CameraController? _cam;
  List<CameraDescription>? _cameras;
  int _camIndex = 0;

  @override
  void initState() {
    super.initState();
    _initCam();
  }

  Future<void> _initCam() async {
    try {
      _cameras = await availableCameras();
      if (_cameras!.isNotEmpty) {
        _camIndex = _cameras!
            .indexWhere((c) => c.lensDirection == CameraLensDirection.front);
        if (_camIndex == -1) _camIndex = 0;
        _startCamera(_cameras![_camIndex]);
      }
    } catch (e) {
      debugPrint('Camera error: $e');
    }
  }

  Future<void> _startCamera(CameraDescription d) async {
    final c = CameraController(d, ResolutionPreset.high, enableAudio: false);
    await c.initialize();
    if (mounted) setState(() => _cam = c);
  }

  void _flipCam() {
    if (_cameras == null || _cameras!.length < 2) return;
    _camIndex = (_camIndex + 1) % _cameras!.length;
    _cam?.dispose();
    setState(() => _cam = null);
    _startCamera(_cameras![_camIndex]);
  }

  @override
  void dispose() {
    _cam?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return Scaffold(
      backgroundColor: context.colors.black,
      body: Stack(children: [
        if (_cam != null && _cam!.value.isInitialized)
          Positioned.fill(child: CameraPreview(_cam!))
        else
          Positioned.fill(
              child: Center(child: CircularProgressIndicator(color: context.colors.gold))),

        if (p != null)
          Positioned.fill(
              child: GestureDetector(
            onScaleStart: (d) {
              _startScale = _scale;
              _startRot = _rot;
            },
            onScaleUpdate: (d) => setState(() {
              _scale = (_startScale * d.scale).clamp(0.5, 3.5);
              _rot = _startRot + d.rotation;
              _ox += d.focalPointDelta.dx;
              _oy += d.focalPointDelta.dy;
            }),
            child: Container(
                color: Colors.transparent,
                child: Center(
                    child: Transform.translate(
                        offset: Offset(_ox, _oy),
                        child: Transform.scale(
                            scale: _scale,
                            child: Transform.rotate(
                                angle: _rot,
                                child: Img(p.images.first,
                                    w: 220, fit: BoxFit.contain)))))),
          )),

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
                      Expanded(
                          child: Text('AR Try-On',
                              style: GoogleFonts.dmSans(
                                  color: context.colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16))),
                      GestureDetector(
                          onTap: _flipCam,
                          child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle),
                              child: Icon(Icons.cameraswitch_rounded,
                                  color: context.colors.white, size: 20))),
                    ])))),

        // Hint
        Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center(
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text('Drag · Pinch to resize · Two-finger rotate',
                        style: GoogleFonts.dmSans(
                            color: context.colors.white, fontSize: 11))))),

        if (_captured) Positioned.fill(child: Container(color: context.colors.white)),

        // Controls
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _TBtn(Icons.remove, () {
                              if (_scale > 0.5) setState(() => _scale -= 0.15);
                            }, 'Smaller'),
                            const SizedBox(width: 24),
                            _TBtn(
                                Icons.refresh_rounded,
                                () => setState(() {
                                      _scale = 1;
                                      _rot = 0;
                                      _ox = 0;
                                      _oy = 0;
                                    }),
                                'Reset'),
                            const SizedBox(width: 24),
                            _TBtn(Icons.add, () {
                              if (_scale < 3.5) setState(() => _scale += 0.15);
                            }, 'Larger'),
                          ]),
                      const SizedBox(height: 20),
                      GestureDetector(
                          onTap: () {
                            setState(() => _captured = true);
                            Future.delayed(const Duration(milliseconds: 200),
                                () {
                              if (mounted) setState(() => _captured = false);
                            });
                            snack(context, 'Snapshot captured! 📸');
                          },
                          child: Container(
                              width: 68,
                              height: 68,
                              decoration: BoxDecoration(
                                  color: context.colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: context.colors.n300, width: 3)),
                              child: Center(
                                  child: Icon(Icons.camera_alt_rounded,
                                      color: context.colors.ink, size: 28)))),
                    ])))),
      ]),
    );
  }
}

class _TBtn extends StatelessWidget {
  final IconData ic;
  final VoidCallback onTap;
  final String label;
  const _TBtn(this.ic, this.onTap, this.label);

  @override
  Widget build(BuildContext context) =>
      Column(mainAxisSize: MainAxisSize.min, children: [
        GestureDetector(
            onTap: onTap,
            child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    color: Colors.black54, shape: BoxShape.circle),
                child: Icon(ic, color: context.colors.white, size: 22))),
        const SizedBox(height: 4),
        Text(label, style: GoogleFonts.dmSans(color: context.colors.white, fontSize: 10)),
      ]);
}
