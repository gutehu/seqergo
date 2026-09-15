import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

InputImage? inputImageFromCameraImage(
  CameraImage image,
  CameraDescription camera,
) {
  if (image.planes.isEmpty || image.width == 0 || image.height == 0) {
    return null;
  }
  final rotation = InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
      InputImageRotation.rotation0deg;

  if (Platform.isAndroid) {
    final nv21 = _yuv420ToNv21(image);
    if (nv21 == null) return null;
    return InputImage.fromBytes(
      bytes: nv21,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: InputImageFormat.nv21,
        bytesPerRow: image.planes[0].bytesPerRow,
      ),
    );
  }

  if (Platform.isIOS) {
    return InputImage.fromBytes(
      bytes: Uint8List.fromList(image.planes[0].bytes),
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: InputImageFormat.bgra8888,
        bytesPerRow: image.planes[0].bytesPerRow,
      ),
    );
  }
  return null;
}

Uint8List? _yuv420ToNv21(CameraImage image) {
  if (image.planes.length < 3) return null;
  final yPlane = image.planes[0];
  final uPlane = image.planes[1];
  final vPlane = image.planes[2];
  final y = Uint8List.fromList(yPlane.bytes);
  final u = Uint8List.fromList(uPlane.bytes);
  final v = Uint8List.fromList(vPlane.bytes);
  if (y.isEmpty || u.isEmpty || v.isEmpty) return null;
  final yRowStride = yPlane.bytesPerRow;
  final uRowStride = uPlane.bytesPerRow;
  final vRowStride = vPlane.bytesPerRow;
  final uPixelStride = uPlane.bytesPerPixel ?? 1;
  final vPixelStride = vPlane.bytesPerPixel ?? 1;
  final w = image.width;
  final h = image.height;
  final nv21 = Uint8List(w * h + (w * h ~/ 2));
  var pos = 0;
  for (var row = 0; row < h; row++) {
    for (var col = 0; col < w; col++) {
      final i = row * yRowStride + col;
      nv21[pos++] = y[i.clamp(0, y.length - 1)];
    }
  }
  for (var row = 0; row < h ~/ 2; row++) {
    for (var col = 0; col < w ~/ 2; col++) {
      final vi = row * vRowStride + col * vPixelStride;
      final ui = row * uRowStride + col * uPixelStride;
      nv21[pos++] = v[vi.clamp(0, v.length - 1)];
      nv21[pos++] = u[ui.clamp(0, u.length - 1)];
    }
  }
  return nv21;
}
