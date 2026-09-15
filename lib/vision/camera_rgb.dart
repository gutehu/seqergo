import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;

/// Convertit une frame caméra en RGB 224×224, valeurs [0, 1].
Float32List? cameraImageToMobileNetInput(CameraImage image, {int size = 224}) {
  if (image.planes.isEmpty) return null;
  try {
    if (image.planes.length >= 3) {
      return _yuv420ToInput(image, size);
    }
    final decoded = _decode(image);
    if (decoded == null) return null;
    final resized = img.copyResize(
      decoded,
      width: size,
      height: size,
      interpolation: img.Interpolation.linear,
    );
    final out = Float32List(size * size * 3);
    var i = 0;
    for (var y = 0; y < size; y++) {
      for (var x = 0; x < size; x++) {
        final p = resized.getPixel(x, y);
        out[i++] = p.r / 255.0;
        out[i++] = p.g / 255.0;
        out[i++] = p.b / 255.0;
      }
    }
    return out;
  } catch (_) {
    return null;
  }
}

Uint8List? cameraImageToJpeg(CameraImage image, {int quality = 70}) {
  try {
    if (image.format.group == ImageFormatGroup.jpeg) {
      return image.planes[0].bytes;
    }
    final rgb = cameraImageToMobileNetInput(image, size: 256);
    if (rgb == null) return null;
    final im = img.Image(width: 256, height: 256);
    var i = 0;
    for (var y = 0; y < 256; y++) {
      for (var x = 0; x < 256; x++) {
        im.setPixelRgb(
          x,
          y,
          (rgb[i++] * 255).round(),
          (rgb[i++] * 255).round(),
          (rgb[i++] * 255).round(),
        );
      }
    }
    return Uint8List.fromList(img.encodeJpg(im, quality: quality));
  } catch (_) {
    return null;
  }
}

img.Image? _decode(CameraImage image) {
  if (image.format.group == ImageFormatGroup.bgra8888) {
    return img.Image.fromBytes(
      width: image.width,
      height: image.height,
      bytes: image.planes[0].bytes.buffer,
      order: img.ChannelOrder.bgra,
    );
  }
  if (image.format.group == ImageFormatGroup.jpeg) {
    return img.decodeJpg(image.planes[0].bytes);
  }
  return null;
}

Float32List _yuv420ToInput(CameraImage image, int size) {
  final width = image.width;
  final height = image.height;
  final yPlane = image.planes[0];
  final uPlane = image.planes[1];
  final vPlane = image.planes[2];
  final yBytes = Uint8List.fromList(yPlane.bytes);
  final uBytes = Uint8List.fromList(uPlane.bytes);
  final vBytes = Uint8List.fromList(vPlane.bytes);
  if (yBytes.isEmpty || uBytes.isEmpty || vBytes.isEmpty || width <= 0 || height <= 0) {
    throw StateError('Frame caméra invalide');
  }
  final uvPixelStride = uPlane.bytesPerPixel ?? 1;
  final out = Float32List(size * size * 3);
  var i = 0;
  for (var oy = 0; oy < size; oy++) {
    final sy = oy * height ~/ size;
    final uvRow = uPlane.bytesPerRow * (sy >> 1);
    for (var ox = 0; ox < size; ox++) {
      final sx = ox * width ~/ size;
      final yp = yBytes[(sy * yPlane.bytesPerRow + sx).clamp(0, yBytes.length - 1)];
      final uvIndex = uvRow + (sx >> 1) * uvPixelStride;
      final up = uBytes[uvIndex.clamp(0, uBytes.length - 1)];
      final vp = vBytes[uvIndex.clamp(0, vBytes.length - 1)];
      final r = (yp + 1.370705 * (vp - 128)).clamp(0, 255) / 255.0;
      final g =
          (yp - 0.337633 * (up - 128) - 0.698001 * (vp - 128)).clamp(0, 255) /
              255.0;
      final b = (yp + 1.732446 * (up - 128)).clamp(0, 255) / 255.0;
      out[i++] = r;
      out[i++] = g;
      out[i++] = b;
    }
  }
  return out;
}
