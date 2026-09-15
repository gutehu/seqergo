import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/database_scope.dart';
import '../../data/manual_repository.dart';
import '../../domain/activity_engine.dart';
import '../../domain/manual_models.dart';
import '../../domain/metric_kind.dart';
import '../../domain/reach_zone_models.dart';
import '../../vision/knn_classifier.dart';
import '../activity/activity_name_dialog.dart';
import '../activity/session_camera_preview.dart';
import '../session/session_vision_host.dart';
import 'actograph_screen.dart';
import 'time_format.dart';

class ManualSessionScreen extends StatefulWidget {
  const ManualSessionScreen({
    super.key,
    required this.sessionId,
    this.clipBaseUrl = '',
  });

  final int sessionId;
  final String clipBaseUrl;

  @override
  State<ManualSessionScreen> createState() => _ManualSessionScreenState();
}

class _ManualSessionScreenState extends State<ManualSessionScreen> {
  Timer? _ticker;
  late ManualRepository _repo;
  late Stream<SessionTimeline> _session;
  var _knn = KnnClassifier();
  var _ready = false;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_ready) return;
    _repo = ManualRepository(DatabaseScope.of(context));
    _session = _repo.watchLiveSession(widget.sessionId);
    _ready = true;
    _repo.watchLiveSession(widget.sessionId).first.then((timeline) {
      return _repo.loadKnnClassifier(protocolId: timeline.session.protocolId);
    }).then((knn) {
      if (mounted) setState(() => _knn = knn);
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SessionTimeline>(
      stream: _session,
      builder: (context, snapshot) {
        final data = snapshot.data;
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) return;
            _stop();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Observation'),
              automaticallyImplyLeading: false,
              actions: [
                TextButton(
                  onPressed: data == null
                      ? null
                      : () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  ActographScreen(sessionId: widget.sessionId),
                            ),
                          );
                        },
                  child: const Text('Actographe'),
                ),
              ],
            ),
            body: data == null
                ? const Center(child: CircularProgressIndicator())
                : _SessionBody(
                    timeline: data,
                    now: DateTime.now(),
                    knn: _knn,
                    repo: _repo,
                    clipBaseUrl: widget.clipBaseUrl,
                    onManualTap: _onTap,
                    onActivityTap: _onActivityTap,
                    onAutoDetected: (id) {
                      _repo.applyDetectedActivity(
                        sessionId: widget.sessionId,
                        activityId: id,
                      );
                    },
                  ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: FilledButton.tonalIcon(
                  onPressed: _stop,
                  icon: const Icon(Icons.stop),
                  label: const Text("Arrêter l'observation"),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onTap(ObservableSubclassItem sub) {
    if (sub.metricType == MetricKind.count) {
      return _repo.recordCount(sessionId: widget.sessionId, subclassId: sub.id);
    }
    return _repo.toggleDuration(sessionId: widget.sessionId, subclassId: sub.id);
  }

  Future<void> _onActivityTap(LearnedActivityItem activity) {
    return _repo.toggleActivityInterval(
      sessionId: widget.sessionId,
      activityId: activity.id,
    );
  }

  Future<void> _stop() async {
    await _repo.endSession(widget.sessionId);
    if (!mounted) return;
    final timeline = await _repo.watchLiveSession(widget.sessionId).first;
    if (!mounted) return;
    final name = await promptActivityName(
      context,
      title: "Nommer l'enregistrement",
      confirmLabel: 'Enregistrer',
      cancelLabel: 'Passer',
      label: "Nom de l'enregistrement",
      hint: 'Ex. opérateur A — matin',
      initial: timeline.session.name.trim().isEmpty
          ? null
          : timeline.session.name,
    );
    if (name != null && name.isNotEmpty) {
      await _repo.renameSession(widget.sessionId, name);
    }
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => ActographScreen(sessionId: widget.sessionId),
      ),
    );
  }
}

class _SessionBody extends StatelessWidget {
  const _SessionBody({
    required this.timeline,
    required this.now,
    required this.knn,
    required this.repo,
    required this.clipBaseUrl,
    required this.onManualTap,
    required this.onActivityTap,
    required this.onAutoDetected,
  });

  final SessionTimeline timeline;
  final DateTime now;
  final KnnClassifier knn;
  final ManualRepository repo;
  final String clipBaseUrl;
  final ValueChanged<ObservableSubclassItem> onManualTap;
  final ValueChanged<LearnedActivityItem> onActivityTap;
  final ValueChanged<int?> onAutoDetected;

  @override
  Widget build(BuildContext context) {
    final autoActivity = timeline.session.useActivity &&
        (timeline.session.activityEngine == ActivityEngineKind.knn ||
            timeline.session.activityEngine == ActivityEngineKind.clip);
    final shareCamera = autoActivity || timeline.session.useReachZones;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        Text(
          '${timeline.session.modeLabel} · ${formatClock(timeline.session.startedAt)} · ${formatElapsed(now.difference(timeline.session.startedAt))}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        Text(
          'Toutes les observables restent visibles : plusieurs actions peuvent tourner en même temps.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        if (shareCamera) ...[
          const SizedBox(height: 12),
          SessionVisionHost(
            sessionId: timeline.session.id,
            repo: repo,
            useReachZones: timeline.session.useReachZones,
            recipes: timeline.reachRecipes,
            useActivity: autoActivity,
            engine: timeline.session.activityEngine,
            activities: timeline.session.activityEngine == ActivityEngineKind.clip
                ? timeline.activities.where((a) => a.isPrompt).toList()
                : timeline.activities.where((a) => a.sampleCount > 0).toList(),
            knn: knn,
            clipBaseUrl: clipBaseUrl,
            onActivityDetected: onAutoDetected,
          ),
          const SizedBox(height: 8),
          _LiveCameraBanner(
            engine: timeline.session.activityEngine,
            zones: timeline.session.useReachZones,
          ),
        ] else if (timeline.session.useActivity) ...[
          const SizedBox(height: 12),
          const SessionCameraPreview(),
          const SizedBox(height: 8),
          _LiveCameraBanner(engine: timeline.session.activityEngine),
        ],
        if (timeline.session.useActivity) ...[
          const SizedBox(height: 12),
          Text("Activités apprises", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final activity in timeline.activities)
                _ActivityPad(
                  activity: activity,
                  running: timeline.activityIsRunning(activity.id),
                  elapsed: timeline.activityElapsed(activity.id, now),
                  onTap: () => onActivityTap(activity),
                ),
            ],
          ),
          const SizedBox(height: 16),
        ],
        if (timeline.session.useReachZones && timeline.reachRecipes.isNotEmpty) ...[
          Text("Zones SEQOIA", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final recipe in timeline.reachRecipes)
                _ZonePad(
                  recipe: recipe,
                  running: timeline.reachIsRunning(recipe.id),
                  elapsed: timeline.reachElapsed(recipe.id, now),
                ),
            ],
          ),
          const SizedBox(height: 16),
        ],
        if (timeline.session.useManual)
        for (final klass in timeline.classes) ...[
          Text(klass.name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          if (klass.subclasses.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Pas de sous-classe',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final sub in klass.subclasses)
                    _SubclassPad(
                      subclass: sub,
                      timeline: timeline,
                      now: now,
                      onTap: () => onManualTap(sub),
                    ),
                ],
              ),
            ),
        ],
      ],
    );
  }
}

class _SubclassPad extends StatelessWidget {
  const _SubclassPad({
    required this.subclass,
    required this.timeline,
    required this.now,
    required this.onTap,
  });

  final ObservableSubclassItem subclass;
  final SessionTimeline timeline;
  final DateTime now;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final running = timeline.intervals.any(
      (i) => i.subclassId == subclass.id && i.isOpen,
    );
    final count = timeline.countEvents.where((e) => e.subclassId == subclass.id).length;
    final totalDuration = timeline.intervals
        .where((i) => i.subclassId == subclass.id)
        .fold<Duration>(Duration.zero, (sum, i) => sum + i.elapsed(now));

    final metric = subclass.metricType == MetricKind.count
        ? '× $count'
        : formatElapsed(totalDuration);

    return Material(
      color: running ? subclass.color : Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: subclass.color, width: running ? 0 : 1.4),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 148, minHeight: 96),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  subclass.metricType == MetricKind.count
                      ? Icons.plus_one
                      : Icons.timer_outlined,
                  color: running ? Colors.white : subclass.color,
                ),
                const SizedBox(height: 8),
                Text(
                  subclass.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: running ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  metric,
                  style: TextStyle(
                    fontFeatures: const [FontFeature.tabularFigures()],
                    color: running ? Colors.white70 : const Color(0xFF64748B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActivityPad extends StatelessWidget {
  const _ActivityPad({
    required this.activity,
    required this.running,
    required this.elapsed,
    required this.onTap,
  });

  final LearnedActivityItem activity;
  final bool running;
  final Duration elapsed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: running ? activity.color : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: activity.color, width: running ? 0 : 1.4),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 148, minHeight: 96),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.timer_outlined,
                  color: running ? Colors.white : activity.color,
                ),
                const SizedBox(height: 8),
                Text(
                  activity.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: running ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formatElapsed(elapsed),
                  style: TextStyle(
                    fontFeatures: const [FontFeature.tabularFigures()],
                    color: running ? Colors.white70 : const Color(0xFF64748B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ZonePad extends StatelessWidget {
  const _ZonePad({
    required this.recipe,
    required this.running,
    required this.elapsed,
  });

  final ReachZoneRecipeItem recipe;
  final bool running;
  final Duration elapsed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: running ? recipe.color : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: recipe.color, width: running ? 0 : 1.4),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 148, minHeight: 96),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.straighten,
                color: running ? Colors.white : recipe.color,
              ),
              const SizedBox(height: 4),
              Text(
                recipe.joint.side.label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: running
                      ? Colors.white.withValues(alpha: 0.85)
                      : recipe.color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                recipe.label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: running ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                formatElapsed(elapsed),
                style: TextStyle(
                  fontFeatures: const [FontFeature.tabularFigures()],
                  color: running ? Colors.white70 : const Color(0xFF64748B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiveCameraBanner extends StatelessWidget {
  const _LiveCameraBanner({
    this.engine = ActivityEngineKind.observer,
    this.zones = false,
  });

  final ActivityEngineKind engine;
  final bool zones;

  @override
  Widget build(BuildContext context) {
    final parts = <String>[
      if (zones)
        'Une seule caméra : Screening SEQOIA chronomètre chaque articulation à gauche et à droite.',
      if (engine == ActivityEngineKind.knn)
        'KNN en direct sur le même flux. Une plage n’est écrite que si un modèle entraîné est reconnu.',
      if (engine == ActivityEngineKind.clip)
        'CLIP en direct (PC) sur le même flux.',
      if (!zones && engine == ActivityEngineKind.observer)
        'Tapez une activité pour démarrer le chrono, tapez encore pour l’arrêter.',
    ];
    return Card(
      elevation: 0,
      color: const Color(0xFFFFF7ED),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          parts.join(' '),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
