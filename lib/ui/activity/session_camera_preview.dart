import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/safe_camera_preview.dart';

class SessionCameraPreview extends StatefulWidget {
  const SessionCameraPreview({super.key});

  @override
  State<SessionCameraPreview> createState() => _SessionCameraPreviewState();
}

class _SessionCameraPreviewState extends State<SessionCameraPreview> {
  CameraController? _controller;
  var _ready = false;

  @override
  void initState() {
    super.initState();
    _open();
  }

  Future<void> _open() async {
    final granted = await Permission.camera.request();
    if (!granted.isGranted || !mounted) return;
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;
      final cam = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      final controller = CameraController(
        cam,
        ResolutionPreset.low,
        enableAudio: false,
      );
      await controller.initialize();
      if (!mounted) {
        await controller.dispose();
        return;
      }
      setState(() {
        _controller = controller;
        _ready = true;
      });
    } catch (_) {
      // aperçu optionnel : on n'empêche pas la session
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ColoredBox(
        color: const Color(0xFF0F172A),
        child: SizedBox(
          height: 140,
          width: double.infinity,
          child: !_ready || _controller == null
              ? const Center(
                  child: Text(
                    'Aperçu caméra',
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : SafeCameraPreview(_controller!),
        ),
      ),
    );
  }
}
