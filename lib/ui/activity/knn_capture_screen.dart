import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/manual_repository.dart';
import '../../vision/camera_lifecycle.dart';
import '../../vision/camera_rgb.dart';
import '../../vision/mobilenet_embedder.dart';
import '../widgets/safe_camera_preview.dart';
import 'activity_name_dialog.dart';

class KnnCaptureScreen extends StatefulWidget {
  const KnnCaptureScreen({
    super.key,
    required this.repo,
    this.activityId,
    this.initialName = 'Nouvelle activité',
  });

  final ManualRepository repo;
  final int? activityId;
  final String initialName;

  @override
  State<KnnCaptureScreen> createState() => _KnnCaptureScreenState();
}

class _KnnCaptureScreenState extends State<KnnCaptureScreen> {
  final _embedder = MobileNetEmbedder();
  CameraController? _controller;
  var _ready = false;
  var _holding = false;
  var _busy = false;
  var _samples = 0;
  var _allowPop = false;
  int? _activityId;
  late String _label;
  String? _status;
  String? _error;
  DateTime _lastSample = DateTime.fromMillisecondsSinceEpoch(0);
  Future<void>? _shutdown;

  @override
  void initState() {
    super.initState();
    _label = widget.initialName.trim().isEmpty
        ? 'Activité'
        : widget.initialName.trim();
    _activityId = widget.activityId;
    _prepare();
  }

  Future<void> _prepare() async {
    try {
      await _embedder.load(
        onStatus: (s) {
          if (mounted) setState(() => _status = s);
        },
      );
      if (_shutdown != null) return;
      final granted = await Permission.camera.request();
      if (!granted.isGranted) {
        if (mounted) {
          setState(() => _error = "L'accès à la caméra est nécessaire.");
        }
        return;
      }
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        if (mounted) setState(() => _error = 'Aucune caméra disponible.');
        return;
      }
      if (_shutdown != null) return;
      final back = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      final controller = CameraController(
        back,
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
        _status = 'Restez appuyé pour capter des exemples.';
      });
    } catch (error) {
      if (mounted && _shutdown == null) {
        setState(() => _error = error.toString());
      }
    }
  }

  Future<void> _onFrame(CameraImage image) async {
    if (_shutdown != null || !_holding || _busy || !_embedder.isReady) return;
    final now = DateTime.now();
    if (now.difference(_lastSample) < const Duration(milliseconds: 220)) {
      return;
    }
    _busy = true;
    _lastSample = now;
    try {
      final rgb = cameraImageToMobileNetInput(image, size: _embedder.inputSize);
      if (rgb == null || _shutdown != null || !_embedder.isReady) return;
      final vector = _embedder.infer(rgb);
      if (_shutdown != null) return;
      final id = await _ensureActivity();
      if (_shutdown != null) return;
      await widget.repo.addEmbedding(activityId: id, vector: vector);
      if (mounted && _shutdown == null) setState(() => _samples += 1);
    } catch (error) {
      if (mounted && _shutdown == null) setState(() => _error = error.toString());
    } finally {
      _busy = false;
    }
  }

  Future<int> _ensureActivity() async {
    final existing = _activityId;
    if (existing != null) return existing;
    final id = await widget.repo.addActivity(name: _label, kind: 'visual');
    _activityId = id;
    return id;
  }

  Future<void> _rename() async {
    if (_holding || _shutdown != null) return;
    final name = await promptActivityName(
      context,
      title: "Renommer l'activité",
      initial: _label,
    );
    if (name == null || !mounted || _shutdown != null) return;
    final id = _activityId;
    if (id != null) {
      await widget.repo.renameActivity(id, name);
    }
    if (!mounted || _shutdown != null) return;
    setState(() => _label = name);
  }

  Future<void> _releaseResources() {
    return _shutdown ??= () async {
      _holding = false;
      final controller = _controller;
      _controller = null;
      if (mounted) {
        setState(() => _ready = false);
        await Future<void>.delayed(Duration.zero);
      }
      await waitWhileBusy(() => _busy);
      await disposeCameraController(controller);
      await waitWhileBusy(() => _busy);
      _embedder.dispose();
    }();
  }

  Future<void> _leave() async {
    await _releaseResources();
    if (!mounted) return;
    setState(() => _allowPop = true);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _releaseResources();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return PopScope(
      canPop: _allowPop,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _leave();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_label),
          actions: [
            IconButton(
              tooltip: 'Renommer',
              onPressed: _holding || _shutdown != null ? null : _rename,
              icon: const Icon(Icons.edit_outlined),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ColoredBox(
                color: Colors.black,
                child: _error != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            _error!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : !_ready || controller == null
                        ? Center(
                            child: Text(
                              _status ?? 'Chargement…',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          )
                        : SizedBox.expand(
                            child: SafeCameraPreview(controller),
                          ),
              ),
            ),
            Material(
              color: Colors.white,
              elevation: 8,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
                  child: Column(
                    children: [
                      Text(
                        _holding
                            ? 'Capture… $_samples exemple(s)'
                            : '$_samples exemple(s) · restez appuyé pour en ajouter',
                        textAlign: TextAlign.center,
                      ),
                      if (_status != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          _status!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                      const SizedBox(height: 16),
                      Listener(
                        onPointerDown: _ready && _error == null && _shutdown == null
                            ? (_) => setState(() => _holding = true)
                            : null,
                        onPointerUp: (_) => setState(() => _holding = false),
                        onPointerCancel: (_) => setState(() => _holding = false),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 120),
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _holding
                                ? const Color(0xFFC2410C)
                                : const Color(0xFF0F766E),
                          ),
                          child: Icon(
                            _holding
                                ? Icons.fiber_manual_record
                                : Icons.psychology_alt,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: (_samples > 0 || _activityId != null) &&
                                  _shutdown == null
                              ? _leave
                              : null,
                          child: const Text('Terminé'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
