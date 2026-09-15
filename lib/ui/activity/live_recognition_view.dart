import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/activity_engine.dart';
import '../../domain/manual_models.dart';
import '../../vision/camera_lifecycle.dart';
import '../../vision/camera_rgb.dart';
import '../../vision/clip_client.dart';
import '../../vision/detection_smoother.dart';
import '../../vision/knn_classifier.dart';
import '../../vision/mobilenet_embedder.dart';
import '../widgets/safe_camera_preview.dart';

class LiveRecognitionView extends StatefulWidget {
  const LiveRecognitionView({
    super.key,
    required this.engine,
    required this.activities,
    required this.knn,
    required this.clipBaseUrl,
    required this.onDetected,
  });

  final ActivityEngineKind engine;
  final List<LearnedActivityItem> activities;
  final KnnClassifier knn;
  final String clipBaseUrl;
  final ValueChanged<int?> onDetected;

  @override
  State<LiveRecognitionView> createState() => _LiveRecognitionViewState();
}

class _LiveRecognitionViewState extends State<LiveRecognitionView> {
  CameraController? _controller;
  MobileNetEmbedder? _embedder;
  ClipClient? _clip;
  final _smoother = DetectionSmoother();
  var _ready = false;
  var _busy = false;
  String _overlay = 'Démarrage de la détection…';
  int? _lastSent;
  Future<void>? _shutdown;

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    try {
      if (widget.engine == ActivityEngineKind.knn) {
        final embedder = MobileNetEmbedder();
        await embedder.load(
          onStatus: (s) {
            if (mounted && _shutdown == null) setState(() => _overlay = s);
          },
        );
        if (!mounted || _shutdown != null) {
          embedder.dispose();
          return;
        }
        _embedder = embedder;
      } else {
        _clip = ClipClient(baseUrl: widget.clipBaseUrl);
        final ok = await _clip!.ping();
        if (!ok) {
          setState(() => _overlay = 'Service CLIP injoignable (${widget.clipBaseUrl}).');
        }
      }
      final granted = await Permission.camera.request();
      if (!granted.isGranted) {
        setState(() => _overlay = 'Caméra refusée.');
        return;
      }
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
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await controller.initialize();
      if (!mounted || _shutdown != null) {
        await disposeCameraController(controller);
        return;
      }
      await controller.startImageStream(_onFrame);
      if (!mounted || _shutdown != null) {
        await disposeCameraController(controller);
        return;
      }
      setState(() {
        _controller = controller;
        _ready = true;
        _overlay = 'Détection en cours…';
      });
    } catch (error) {
      if (mounted) setState(() => _overlay = error.toString());
    }
  }

  Future<void> _onFrame(CameraImage image) async {
    if (_busy || !mounted || _shutdown != null) return;
    _busy = true;
    try {
      int? id;
      var label = '—';
      var confidence = 0.0;
      if (widget.engine == ActivityEngineKind.knn) {
        final embedder = _embedder;
        if (embedder == null || !embedder.isReady || _shutdown != null) return;
        final rgb = cameraImageToMobileNetInput(image, size: embedder.inputSize);
        if (rgb == null) return;
        final prediction = widget.knn.predict(embedder.infer(rgb));
        if (prediction != null) {
          id = prediction.id;
          label = prediction.label;
          confidence = prediction.confidence;
        }
      } else {
        final jpeg = cameraImageToJpeg(image);
        final client = _clip;
        if (jpeg == null || client == null) return;
        final trained = [
          for (final a in widget.activities) a.name,
        ];
        if (trained.isEmpty) return;
        final result = await client.analyzeFrame(
          jpeg: jpeg,
          labels: ClipClient.labelsWithUnknown(trained),
        );
        final recognized = ClipClient.recognizedLabel(result, trained);
        if (recognized != null) {
          label = recognized;
          confidence = result.confidence;
          for (final a in widget.activities) {
            if (a.name == recognized) id = a.id;
          }
        }
      }
      final smooth = _smoother.update(
        now: DateTime.now(),
        id: id,
        label: label,
        confidence: confidence,
      );
      if (!mounted || _shutdown != null) return;
      setState(() {
        _overlay = smooth.id == null
            ? 'aucune activité'
            : '${smooth.label} · ${(smooth.confidence * 100).round()} %';
      });
      if (smooth.id != _lastSent) {
        _lastSent = smooth.id;
        widget.onDetected(smooth.id);
      }
    } catch (error) {
      if (mounted) setState(() => _overlay = error.toString());
    } finally {
      await Future<void>.delayed(
        Duration(
          milliseconds: widget.engine == ActivityEngineKind.clip ? 350 : 60,
        ),
      );
      _busy = false;
    }
  }

  Future<void> _releaseResources() {
    return _shutdown ??= () async {
      final controller = _controller;
      _controller = null;
      if (mounted) {
        setState(() => _ready = false);
        await Future<void>.delayed(Duration.zero);
      }
      await waitWhileBusy(() => _busy);
      await disposeCameraController(controller);
      await waitWhileBusy(() => _busy);
      _embedder?.dispose();
      _embedder = null;
    }();
  }

  @override
  void dispose() {
    _releaseResources();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ColoredBox(
        color: const Color(0xFF0F172A),
        child: SizedBox(
          height: 180,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (_ready && controller != null)
                SafeCameraPreview(controller)
              else
                const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  color: const Color(0xCC0F172A),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    _overlay,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
