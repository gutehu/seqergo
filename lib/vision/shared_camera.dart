import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'camera_lifecycle.dart';

/// Une seule caméra pour la session : preview + flux d'images.
class SharedCameraSession {
  CameraController? controller;
  CameraDescription? description;
  var ready = false;
  String? error;
  Future<void>? _shutdown;

  Future<void> start({
    required void Function(CameraImage image) onFrame,
    VoidCallback? onChanged,
  }) async {
    if (_shutdown != null) return;
    try {
      final granted = await Permission.camera.request();
      if (!granted.isGranted) {
        error = "L'accès à la caméra est nécessaire.";
        onChanged?.call();
        return;
      }
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        error = 'Aucune caméra disponible.';
        onChanged?.call();
        return;
      }
      if (_shutdown != null) return;
      final back = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      final next = CameraController(
        back,
        ResolutionPreset.low,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await next.initialize();
      if (_shutdown != null) {
        await disposeCameraController(next);
        return;
      }
      await next.startImageStream(onFrame);
      if (_shutdown != null) {
        await disposeCameraController(next);
        return;
      }
      controller = next;
      description = back;
      ready = true;
      error = null;
      onChanged?.call();
    } catch (e) {
      error = e.toString();
      onChanged?.call();
    }
  }

  Future<void> stop() {
    return _shutdown ??= () async {
      ready = false;
      final cam = controller;
      controller = null;
      await disposeCameraController(cam);
    }();
  }
}
