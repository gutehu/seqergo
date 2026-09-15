import 'package:camera/camera.dart';

/// Arrête le flux d'images puis libère le contrôleur, sans faire planter le natif.
Future<void> disposeCameraController(CameraController? controller) async {
  if (controller == null) return;
  try {
    if (controller.value.isInitialized && controller.value.isStreamingImages) {
      await controller.stopImageStream();
    }
  } catch (_) {}
  try {
    await controller.dispose();
  } catch (_) {}
}

Future<void> waitWhileBusy(bool Function() busy, {int tries = 40}) async {
  for (var i = 0; i < tries && busy(); i++) {
    await Future<void>.delayed(const Duration(milliseconds: 25));
  }
}
