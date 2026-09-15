import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Aperçu caméra sans [AspectRatio] à 0 (Fold / premier frame).
class SafeCameraPreview extends StatelessWidget {
  const SafeCameraPreview(this.controller, {super.key, this.overlay});

  final CameraController controller;

  /// Dessiné dans le même recadrage que l’image (BoxFit.cover).
  final Widget? overlay;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CameraValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final previewSize = value.previewSize;
        if (!value.isInitialized ||
            previewSize == null ||
            previewSize.width <= 0 ||
            previewSize.height <= 0) {
          return const ColoredBox(
            color: Colors.black,
            child: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }

        Widget preview = controller.buildPreview();
        if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
          preview = RotatedBox(
            quarterTurns: _quarterTurns(value),
            child: preview,
          );
        }
        if (overlay != null) {
          preview = Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(child: preview),
              Positioned.fill(child: overlay!),
            ],
          );
        }

        return ClipRect(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: previewSize.height,
              height: previewSize.width,
              child: preview,
            ),
          ),
        );
      },
    );
  }

  static int _quarterTurns(CameraValue value) {
    final orientation = value.isRecordingVideo
        ? (value.recordingOrientation ?? value.deviceOrientation)
        : (value.previewPauseOrientation ??
            value.lockedCaptureOrientation ??
            value.deviceOrientation);
    switch (orientation) {
      case DeviceOrientation.portraitUp:
        return 0;
      case DeviceOrientation.landscapeRight:
        return 1;
      case DeviceOrientation.portraitDown:
        return 2;
      case DeviceOrientation.landscapeLeft:
        return 3;
    }
  }
}
