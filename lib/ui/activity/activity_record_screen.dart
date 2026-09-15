import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/manual_repository.dart';
import '../widgets/safe_camera_preview.dart';

class ActivityRecordScreen extends StatefulWidget {
  const ActivityRecordScreen({
    super.key,
    required this.repo,
    this.initialName = 'Nouvelle activité',
  });

  final ManualRepository repo;
  final String initialName;

  @override
  State<ActivityRecordScreen> createState() => _ActivityRecordScreenState();
}

class _ActivityRecordScreenState extends State<ActivityRecordScreen> {
  late final TextEditingController _name;
  CameraController? _controller;
  var _ready = false;
  var _recording = false;
  var _busy = false;
  var _hold = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.initialName);
    _name.addListener(() {
      if (mounted) setState(() {});
    });
    _initCamera();
  }

  Future<void> _initCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      if (mounted) {
        setState(() => _error = "L'accès à la caméra est nécessaire.");
      }
      return;
    }
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() => _error = 'Aucune caméra disponible.');
        return;
      }
      final back = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      final controller = CameraController(
        back,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
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
      if (mounted) {
        setState(() => _error = "Impossible d'ouvrir la caméra.");
      }
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _startHold() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized || _busy) return;
    if (controller.value.isRecordingVideo) return;
    _hold = true;
    setState(() {
      _busy = true;
      _recording = true;
      _error = null;
    });
    try {
      await controller.startVideoRecording();
      if (!_hold && controller.value.isRecordingVideo) {
        await _saveRecording();
      }
    } catch (_) {
      _hold = false;
      if (mounted) {
        setState(() {
          _recording = false;
          _error = "L'enregistrement n'a pas pu démarrer.";
        });
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _stopHold() async {
    _hold = false;
    final controller = _controller;
    if (controller == null || !controller.value.isRecordingVideo) {
      if (mounted) setState(() => _recording = false);
      return;
    }
    await _saveRecording();
  }

  Future<void> _saveRecording() async {
    final controller = _controller;
    if (controller == null || !controller.value.isRecordingVideo) return;
    setState(() => _busy = true);
    try {
      final file = await controller.stopVideoRecording();
      final label = _name.text.trim();
      if (label.isEmpty) {
        if (mounted) {
          setState(() {
            _error = "Donnez un nom à cette activité avant d'enregistrer.";
          });
        }
        return;
      }
      final docs = await getApplicationDocumentsDirectory();
      final dir = Directory(p.join(docs.path, 'activities'));
      await dir.create(recursive: true);
      final dest = p.join(
        dir.path,
        'activity_${DateTime.now().millisecondsSinceEpoch}.mp4',
      );
      await File(file.path).copy(dest);
      await widget.repo.addActivity(name: label, clipPath: dest);
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (_) {
      if (mounted) {
        setState(() => _error = "L'enregistrement n'a pas pu être sauvé.");
      }
    } finally {
      if (mounted) {
        setState(() {
          _recording = false;
          _busy = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final named = _name.text.trim().isNotEmpty;
    final canHold = named && _ready && _controller != null && (!_busy || _recording);
    return Scaffold(
      appBar: AppBar(title: const Text('Enregistrer une activité')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _name,
              enabled: !_recording,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: "Nom de l'observable",
                hintText: 'Ex. saisir une pièce',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Expanded(child: _preview()),
          Material(
            elevation: 10,
            color: Colors.white,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
                child: Column(
                  children: [
                    if (_error != null) ...[
                      Text(
                        _error!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFFB91C1C),
                            ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    Text(
                      _recording
                          ? 'Enregistrement des images… relâchez pour terminer'
                          : 'Restez appuyé pour enregistrer les images de la caméra',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    _HoldRecordButton(
                      recording: _recording,
                      enabled: canHold,
                      onStart: _startHold,
                      onStop: _stopHold,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _preview() {
    final controller = _controller;
    if (!_ready || controller == null) {
      return ColoredBox(
        color: Colors.black,
        child: Center(
          child: _error != null && !_ready
              ? Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    _error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              : const CircularProgressIndicator(),
        ),
      );
    }
    return ColoredBox(
      color: Colors.black,
      child: SafeCameraPreview(controller),
    );
  }
}

class _HoldRecordButton extends StatelessWidget {
  const _HoldRecordButton({
    required this.recording,
    required this.enabled,
    required this.onStart,
    required this.onStop,
  });

  final bool recording;
  final bool enabled;
  final VoidCallback onStart;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    final color = !enabled
        ? const Color(0xFF94A3B8)
        : recording
            ? const Color(0xFFC2410C)
            : const Color(0xFF0F766E);
    return Semantics(
      button: true,
      enabled: enabled,
      label: 'Rester appuyé pour enregistrer les images',
      child: Listener(
        onPointerDown: enabled ? (_) => onStart() : null,
        onPointerUp: enabled ? (_) => onStop() : null,
        onPointerCancel: enabled ? (_) => onStop() : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.35),
                blurRadius: recording ? 18 : 8,
              ),
            ],
          ),
          child: Icon(
            recording ? Icons.fiber_manual_record : Icons.videocam,
            color: Colors.white,
            size: 36,
          ),
        ),
      ),
    );
  }
}
