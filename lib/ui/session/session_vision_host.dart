import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import '../../data/manual_repository.dart';
import '../../domain/activity_engine.dart';
import '../../domain/manual_models.dart';
import '../../domain/reach_zone_models.dart';
import '../../vision/camera_lifecycle.dart';
import '../../vision/camera_rgb.dart';
import '../../vision/clip_client.dart';
import '../../vision/detection_smoother.dart';
import '../../vision/joint_angles.dart';
import '../../vision/knn_classifier.dart';
import '../../vision/mobilenet_embedder.dart';
import '../../vision/pose_input_image.dart';
import '../../vision/reach_zone_engine.dart';
import '../../vision/shared_camera.dart';
import '../widgets/safe_camera_preview.dart';
import 'pose_skeleton_painter.dart';

class SessionVisionHost extends StatefulWidget {
  const SessionVisionHost({
    super.key,
    required this.sessionId,
    required this.repo,
    required this.useReachZones,
    required this.recipes,
    required this.useActivity,
    required this.engine,
    required this.activities,
    required this.knn,
    required this.clipBaseUrl,
    required this.onActivityDetected,
  });

  final int sessionId;
  final ManualRepository repo;
  final bool useReachZones;
  final List<ReachZoneRecipeItem> recipes;
  final bool useActivity;
  final ActivityEngineKind engine;
  final List<LearnedActivityItem> activities;
  final KnnClassifier knn;
  final String clipBaseUrl;
  final ValueChanged<int?> onActivityDetected;

  @override
  State<SessionVisionHost> createState() => _SessionVisionHostState();
}

class _SessionVisionHostState extends State<SessionVisionHost> {
  final _camera = SharedCameraSession();
  final _smoother = DetectionSmoother();
  PoseDetector? _pose;
  MobileNetEmbedder? _embedder;
  ClipClient? _clip;
  ReachZoneEngine? _zones;
  var _poseBusy = false;
  var _actBusy = false;
  var _closing = false;
  String _activityOverlay = '';
  String _zoneOverlay = 'Zones SEQOIA…';
  int? _lastActivityId;
  PoseOverlayFrame? _poseFrame;

  bool get _needActivity =>
      widget.useActivity &&
      (widget.engine == ActivityEngineKind.knn ||
          widget.engine == ActivityEngineKind.clip);

  bool get _needZones => widget.useReachZones && widget.recipes.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _zones = ReachZoneEngine(widget.recipes);
    _boot();
  }

  @override
  void didUpdateWidget(SessionVisionHost oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_sameRecipes(oldWidget.recipes, widget.recipes)) {
      _zones = ReachZoneEngine(widget.recipes);
    }
  }

  bool _sameRecipes(
    List<ReachZoneRecipeItem> a,
    List<ReachZoneRecipeItem> b,
  ) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].id != b[i].id ||
          a[i].kind != b[i].kind ||
          a[i].validateAngle != b[i].validateAngle ||
          a[i].zoneMin != b[i].zoneMin ||
          a[i].zoneMax != b[i].zoneMax) {
        return false;
      }
    }
    return true;
  }

  Future<void> _boot() async {
    try {
      if (_needActivity && widget.engine == ActivityEngineKind.knn) {
        final embedder = MobileNetEmbedder();
        await embedder.load(
          onStatus: (s) {
            if (mounted && !_closing) setState(() => _activityOverlay = s);
          },
        );
        if (_closing) {
          embedder.dispose();
          return;
        }
        _embedder = embedder;
      } else if (_needActivity && widget.engine == ActivityEngineKind.clip) {
        _clip = ClipClient(baseUrl: widget.clipBaseUrl);
        final ok = await _clip!.ping();
        if (!ok && mounted) {
          setState(
            () => _activityOverlay =
                'Service CLIP injoignable (${widget.clipBaseUrl}).',
          );
        }
      }
      if (_needZones) {
        _pose = PoseDetector(
          options: PoseDetectorOptions(
            model: PoseDetectionModel.base,
            mode: PoseDetectionMode.stream,
          ),
        );
      }
      if (_closing) return;
      await _camera.start(
        onFrame: _onFrame,
        onChanged: () {
          if (mounted) setState(() {});
        },
      );
      if (mounted && !_closing) {
        setState(() {
          if (_needActivity) _activityOverlay = 'Détection en cours…';
          if (_needZones) _zoneOverlay = 'Screening SEQOIA (manuel)';
        });
      }
    } catch (error) {
      if (mounted) setState(() => _activityOverlay = error.toString());
    }
  }

  void _onFrame(CameraImage image) {
    if (_closing) return;
    final cam = _camera.description;
    if (cam == null) return;

    InputImage? poseInput;
    if (_needZones && !_poseBusy && _pose != null) {
      poseInput = inputImageFromCameraImage(image, cam);
    }
    Float32List? rgb;
    Uint8List? jpeg;
    if (_needActivity && !_actBusy) {
      if (widget.engine == ActivityEngineKind.knn && _embedder != null) {
        rgb = cameraImageToMobileNetInput(image, size: _embedder!.inputSize);
      } else if (widget.engine == ActivityEngineKind.clip) {
        jpeg = cameraImageToJpeg(image);
      }
    }

    if (poseInput != null) {
      _poseBusy = true;
      unawaited(
        _runPose(
          poseInput,
          Size(image.width.toDouble(), image.height.toDouble()),
          cam,
        ).whenComplete(() => _poseBusy = false),
      );
    }
    if (rgb != null || jpeg != null) {
      _actBusy = true;
      unawaited(_runActivity(rgb, jpeg).whenComplete(() => _actBusy = false));
    }
  }

  Future<void> _runPose(
    InputImage input,
    Size imageSize,
    CameraDescription cam,
  ) async {
    final detector = _pose;
    if (detector == null || _closing) return;
    try {
      final poses = await detector.processImage(input);
      if (_closing || poses.isEmpty) return;
      final pose = poses.first;
      JointPoint? pt(PoseLandmarkType type) {
        final lm = pose.landmarks[type];
        if (lm == null || lm.likelihood < 0.35) return null;
        return JointPoint(lm.x, lm.y);
      }

      final body = BodyPoints(
        leftHip: pt(PoseLandmarkType.leftHip),
        rightHip: pt(PoseLandmarkType.rightHip),
        leftKnee: pt(PoseLandmarkType.leftKnee),
        rightKnee: pt(PoseLandmarkType.rightKnee),
        leftAnkle: pt(PoseLandmarkType.leftAnkle),
        rightAnkle: pt(PoseLandmarkType.rightAnkle),
        leftShoulder: pt(PoseLandmarkType.leftShoulder),
        rightShoulder: pt(PoseLandmarkType.rightShoulder),
        leftElbow: pt(PoseLandmarkType.leftElbow),
        rightElbow: pt(PoseLandmarkType.rightElbow),
        leftWrist: pt(PoseLandmarkType.leftWrist),
        rightWrist: pt(PoseLandmarkType.rightWrist),
      );
      final angles = <ReachJoint, double?>{};
      for (final recipe in widget.recipes) {
        angles[recipe.joint] ??= angleForJoint(recipe.joint, body);
      }
      final changes = _zones?.update(angles) ?? const <int, bool>{};
      for (final entry in changes.entries) {
        await widget.repo.applyReachZone(
          sessionId: widget.sessionId,
          recipeId: entry.key,
          inZone: entry.value,
        );
      }
      if (!mounted || _closing) return;
      final parts = <String>[];
      final active = <ReachJoint>{};
      for (final recipe in widget.recipes) {
        final a = angles[recipe.joint];
        final inside = _zones?.current[recipe.id] ?? false;
        if (inside) active.add(recipe.joint);
        parts.add(
          '${recipe.label}: ${a == null ? "—" : "${a.round()}°"}${inside ? " ●" : ""}',
        );
      }
      final points = <PoseLandmarkType, Offset>{};
      for (final entry in pose.landmarks.entries) {
        if (entry.value.likelihood < 0.2) continue;
        points[entry.key] = Offset(entry.value.x, entry.value.y);
      }
      setState(() {
        _zoneOverlay = parts.join('  ·  ');
        _poseFrame = PoseOverlayFrame(
          imageSize: imageSize,
          rotationDeg: cam.sensorOrientation,
          mirrorX: cam.lensDirection == CameraLensDirection.front,
          isIos: Platform.isIOS,
          points: points,
          observedJoints: {for (final recipe in widget.recipes) recipe.joint},
          activeJoints: active,
        );
      });
    } catch (_) {}
  }

  Future<void> _runActivity(Float32List? rgb, Uint8List? jpeg) async {
    if (_closing) return;
    try {
      int? id;
      var label = '—';
      var confidence = 0.0;
      if (widget.engine == ActivityEngineKind.knn) {
        final embedder = _embedder;
        if (embedder == null || !embedder.isReady || rgb == null) return;
        final prediction = widget.knn.predict(embedder.infer(rgb));
        if (prediction != null) {
          id = prediction.id;
          label = prediction.label;
          confidence = prediction.confidence;
        }
      } else {
        final client = _clip;
        final trained = [for (final a in widget.activities) a.name];
        if (jpeg == null || client == null || trained.isEmpty) return;
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
      if (!mounted || _closing) return;
      setState(() {
        _activityOverlay = smooth.id == null
            ? 'aucune activité'
            : '${smooth.label} · ${(smooth.confidence * 100).round()} %';
      });
      if (smooth.id != _lastActivityId) {
        _lastActivityId = smooth.id;
        widget.onActivityDetected(smooth.id);
      }
    } catch (error) {
      if (mounted && !_closing) {
        setState(() => _activityOverlay = error.toString());
      }
    } finally {
      await Future<void>.delayed(
        Duration(
          milliseconds: widget.engine == ActivityEngineKind.clip ? 350 : 60,
        ),
      );
    }
  }

  @override
  void dispose() {
    _closing = true;
    final pose = _pose;
    _pose = null;
    unawaited(() async {
      await waitWhileBusy(() => _poseBusy || _actBusy);
      await pose?.close();
      _embedder?.dispose();
      await _camera.stop();
    }());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _camera.controller;
    final lines = <String>[
      if (_needActivity) _activityOverlay,
      if (_needZones) _zoneOverlay,
    ];
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ColoredBox(
        color: const Color(0xFF0F172A),
        child: SizedBox(
          height: _needZones ? 360 : 200,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (_camera.ready && controller != null)
                SafeCameraPreview(
                  controller,
                  overlay: _needZones && _poseFrame != null
                      ? IgnorePointer(
                          child: CustomPaint(
                            painter: PoseSkeletonPainter(_poseFrame!),
                            child: const SizedBox.expand(),
                          ),
                        )
                      : null,
                )
              else
                Center(
                  child: Text(
                    _camera.error ?? 'Caméra…',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  color: const Color(0xCC0F172A),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    lines.where((l) => l.isNotEmpty).join('\n'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
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
