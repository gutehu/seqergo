import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/auth_scope.dart';
import '../../data/database_scope.dart';
import '../../data/manual_repository.dart';
import '../../domain/activity_engine.dart';
import '../../domain/manual_models.dart';
import '../../domain/observation_mode.dart';
import '../../domain/reach_zone_models.dart';
import '../activity/activity_library_panel.dart';
import '../manual/manual_session_screen.dart';
import '../manual/manual_taxonomy_panel.dart';
import '../results/results_screen.dart';
import 'reach_zone_panel.dart';

class ProtocolSetupScreen extends StatefulWidget {
  const ProtocolSetupScreen({
    super.key,
    this.selection,
    this.protocolId,
  });

  final ProtocolSelection? selection;
  final int? protocolId;

  @override
  State<ProtocolSetupScreen> createState() => _ProtocolSetupScreenState();
}

class _ProtocolSetupScreenState extends State<ProtocolSetupScreen> {
  late ManualRepository _repo;
  late Stream<List<ObservableClassItem>> _taxonomy;
  late Stream<List<LearnedActivityItem>> _activities;
  late Stream<List<ReachZoneRecipeItem>> _recipes;
  final _name = TextEditingController();
  final _clipUrl = TextEditingController(text: 'http://192.168.1.20:8765');
  var _engine = ActivityEngineKind.knn;
  var _selection = const ProtocolSelection();
  int? _protocolId;
  var _ready = false;
  var _bootstrapped = false;

  @override
  void initState() {
    super.initState();
    _selection = widget.selection ?? const ProtocolSelection();
    _loadClipUrl();
  }

  Future<void> _loadClipUrl() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString('clip_base_url');
      if (saved != null && saved.isNotEmpty && mounted) {
        _clipUrl.text = saved;
      }
    } catch (_) {}
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_bootstrapped) return;
    _bootstrapped = true;
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final db = DatabaseScope.of(context);
    final userId = AuthScope.of(context).user.id;
    final existingId = widget.protocolId;
    if (existingId != null) {
      final loaded = await ManualRepository(db).getProtocol(existingId);
      if (!mounted) return;
      _protocolId = existingId;
      if (loaded != null) {
        _name.text = loaded.name;
        _engine = ActivityEngineKindCodec.fromStorage(loaded.activityEngine);
        _selection = ProtocolSelection(
          manual: loaded.useManual,
          reachZones: loaded.useReachZones,
          activity: loaded.useActivity,
        );
      }
    } else {
      final id = await ManualRepository(db).createProtocol(
        userId: userId,
        name: 'Protocole ${DateTime.now().day}/${DateTime.now().month}',
        useManual: _selection.manual,
        useReachZones: _selection.reachZones,
        useActivity: _selection.activity,
        activityEngine: _selection.activity ? _engine : ActivityEngineKind.observer,
      );
      if (!mounted) return;
      _protocolId = id;
      _name.text = 'Protocole ${DateTime.now().day}/${DateTime.now().month}';
    }
    _repo = ManualRepository(db, userId: userId, protocolId: _protocolId);
    _taxonomy = _repo.watchTaxonomy();
    _activities = _repo.watchActivities();
    _recipes = _repo.watchReachRecipes();
    _ready = true;
    setState(() {});
  }

  Future<void> _persist() async {
    final id = _protocolId;
    if (id == null) return;
    await _repo.updateProtocol(
      id: id,
      name: _name.text,
      activityEngine: _selection.activity ? _engine : ActivityEngineKind.observer,
    );
  }

  @override
  void dispose() {
    _name.dispose();
    _clipUrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Protocole'),
        actions: [
          IconButton(
            tooltip: 'Résultats',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const ResultsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.insights_outlined),
          ),
        ],
      ),
      body: StreamBuilder<List<ObservableClassItem>>(
        stream: _taxonomy,
        builder: (context, classSnap) {
          return StreamBuilder<List<LearnedActivityItem>>(
            stream: _activities,
            builder: (context, activitySnap) {
              return StreamBuilder<List<ReachZoneRecipeItem>>(
                stream: _recipes,
                builder: (context, recipeSnap) {
              final classes = classSnap.data ?? const <ObservableClassItem>[];
              final activities =
                  activitySnap.data ?? const <LearnedActivityItem>[];
              final recipes = recipeSnap.data ?? const <ReachZoneRecipeItem>[];
              final canStart = _canStart(classes, activities, recipes);
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      children: [
                        TextField(
                          controller: _name,
                          decoration: const InputDecoration(
                            labelText: 'Nom du protocole',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          onChanged: (_) => _persist(),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _selection.modeSummary,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        if (_selection.manual) ...[
                          ManualTaxonomyPanel(classes: classes, repo: _repo),
                          const SizedBox(height: 20),
                        ],
                        if (_selection.activity) ...[
                          ActivityLibraryPanel(
                            activities: activities,
                            repo: _repo,
                            engine: _engine,
                            onEngineChanged: (value) {
                              setState(() => _engine = value);
                              _persist();
                            },
                            clipUrlController: _clipUrl,
                          ),
                          const SizedBox(height: 20),
                        ],
                        if (_selection.reachZones) ...[
                          ReachZonePanel(recipes: recipes, repo: _repo),
                          const SizedBox(height: 20),
                        ],
                      ],
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () async {
                                await _persist();
                                if (context.mounted) Navigator.of(context).pop();
                              },
                              child: const Text('Enregistrer'),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: canStart ? _start : null,
                              icon: const Icon(Icons.play_arrow),
                              label: const Text("Démarrer l'observation"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
                },
              );
            },
          );
        },
      ),
    );
  }

  bool _canStart(
    List<ObservableClassItem> classes,
    List<LearnedActivityItem> activities,
    List<ReachZoneRecipeItem> recipes,
  ) {
    if (_selection.manual && !classes.any((c) => c.subclasses.isNotEmpty)) {
      return false;
    }
    if (_selection.activity) {
      if (_engine == ActivityEngineKind.knn) {
        final trained = activities.where((a) => a.sampleCount > 0).length;
        if (trained < 1) return false;
      } else if (_engine == ActivityEngineKind.clip) {
        if (activities.where((a) => a.isPrompt).isEmpty) return false;
      } else if (activities.isEmpty) {
        return false;
      }
    }
    if (_selection.reachZones && recipes.isEmpty) {
      return false;
    }
    return !_selection.isEmpty;
  }

  Future<void> _start() async {
    final userId = AuthScope.of(context).user.id;
    await _persist();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('clip_base_url', _clipUrl.text.trim());
    } catch (_) {}
    final id = await _repo.startSession(
      useManual: _selection.manual,
      useReachZones: _selection.reachZones,
      useActivity: _selection.activity,
      activityEngine: _selection.activity
          ? _engine
          : ActivityEngineKind.observer,
      protocolId: _protocolId,
      userId: userId,
    );
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ManualSessionScreen(
          sessionId: id,
          clipBaseUrl: _clipUrl.text.trim(),
        ),
      ),
    );
  }
}

extension on ProtocolSelection {
  String get modeSummary {
    final parts = <String>[
      if (manual) 'Manuel',
      if (reachZones) "Zones d'atteinte",
      if (activity) 'Activités',
    ];
    return parts.isEmpty ? '' : 'Modes : ${parts.join(' · ')}';
  }
}
