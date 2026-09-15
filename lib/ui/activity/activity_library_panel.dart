import 'package:flutter/material.dart';

import '../../data/manual_repository.dart';
import '../../domain/activity_engine.dart';
import '../../domain/manual_models.dart';
import '../../vision/clip_client.dart';
import 'activity_name_dialog.dart';
import 'activity_record_screen.dart';
import 'engine_test_buttons.dart';
import 'knn_capture_screen.dart';

class ActivityLibraryPanel extends StatelessWidget {
  const ActivityLibraryPanel({
    super.key,
    required this.activities,
    required this.repo,
    required this.engine,
    required this.onEngineChanged,
    required this.clipUrlController,
  });

  final List<LearnedActivityItem> activities;
  final ManualRepository repo;
  final ActivityEngineKind engine;
  final ValueChanged<ActivityEngineKind> onEngineChanged;
  final TextEditingController clipUrlController;

  static const Color _accent = Color(0xFFC2410C);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reconnaissance d'activité",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        EngineTestButtons(selected: engine, onSelected: onEngineChanged),
        const SizedBox(height: 16),
        if (engine == ActivityEngineKind.knn) ...[
          Text(
            'Nommez chaque activité, puis captez des exemples '
            '(appui maintenu). Un seul modèle suffit. '
            "Si la scène ne correspond à aucun modèle, rien n'est chronométré.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => _capture(context),
              style: FilledButton.styleFrom(
                backgroundColor: _accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.fiber_manual_record),
              label: const Text('Enregistrer des exemples'),
            ),
          ),
        ] else if (engine == ActivityEngineKind.clip) ...[
          Text(
            'Saisissez une ou plusieurs descriptions visuelles. '
            'Lancez le service Python sur le PC, puis indiquez son URL. '
            "Si aucune description ne correspond, rien n'est chronométré.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: clipUrlController,
            decoration: const InputDecoration(
              labelText: 'URL du service CLIP',
              hintText: 'http://192.168.1.20:8765',
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () => _pingClip(context),
              icon: const Icon(Icons.wifi_tethering),
              label: const Text('Tester la connexion'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => _addPrompt(context),
              icon: const Icon(Icons.add),
              label: const Text('Ajouter un prompt'),
            ),
          ),
        ] else ...[
          Text(
            'Relevé manuel : enregistrez un modèle caméra, puis tapez '
            "pendant l'observation pour chronométrer.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => _recordVideo(context),
              style: FilledButton.styleFrom(
                backgroundColor: _accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.fiber_manual_record),
              label: const Text('Enregistrer une activité'),
            ),
          ),
        ],
        const SizedBox(height: 16),
        if (activities.isEmpty)
          Text(
            'Aucune activité enregistrée.',
            style: Theme.of(context).textTheme.bodyMedium,
          )
        else
          for (final activity in activities)
            Card(
              margin: const EdgeInsets.only(bottom: 8),
              elevation: 0,
              color: Colors.white,
              child: ListTile(
                onTap: engine == ActivityEngineKind.knn && !activity.isPrompt
                    ? () => _capture(context, activity: activity)
                    : null,
                leading: CircleAvatar(
                  backgroundColor: activity.color.withValues(alpha: 0.18),
                  child: Icon(
                    activity.isPrompt ? Icons.notes : Icons.videocam,
                    color: activity.color,
                  ),
                ),
                title: Text(activity.name),
                subtitle: Text(
                  activity.isPrompt
                      ? 'Prompt CLIP'
                      : engine == ActivityEngineKind.knn
                          ? activity.sampleCount > 0
                              ? '${activity.sampleCount} exemple(s) KNN'
                              : 'Aucun exemple pour l’instant'
                          : 'Modèle caméra enregistré',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: 'Renommer',
                      visualDensity: VisualDensity.compact,
                      onPressed: () => _rename(context, activity),
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      tooltip: 'Supprimer',
                      visualDensity: VisualDensity.compact,
                      onPressed: () => repo.deleteActivity(activity.id),
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }

  Future<void> _capture(
    BuildContext context, {
    LearnedActivityItem? activity,
  }) async {
    try {
      var activityId = activity?.id;
      var name = activity?.name;
      if (activity == null) {
        name = await promptActivityName(
          context,
          title: 'Nouvelle activité',
          confirmLabel: 'Enregistrer des exemples',
        );
        if (name == null) return;
        activityId = await repo.addActivity(name: name, kind: 'visual');
      }
      if (!context.mounted) return;
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => KnnCaptureScreen(
            repo: repo,
            activityId: activityId,
            initialName: name ?? 'Activité',
          ),
        ),
      );
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Impossible d’ouvrir la capture : $error')),
      );
    }
  }

  Future<void> _rename(
    BuildContext context,
    LearnedActivityItem activity,
  ) async {
    final name = await promptActivityName(
      context,
      title: "Renommer l'activité",
      initial: activity.name,
    );
    if (name == null || name == activity.name) return;
    await repo.renameActivity(activity.id, name);
  }

  Future<void> _recordVideo(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ActivityRecordScreen(repo: repo),
      ),
    );
  }

  Future<void> _addPrompt(BuildContext context) async {
    final name = await promptActivityName(
      context,
      title: 'Nouveau prompt',
      confirmLabel: 'Ajouter',
      label: 'Description visuelle',
      hint: 'personne qui saisit un carton',
      maxLines: 3,
    );
    if (name == null || name.isEmpty) return;
    await repo.addActivity(name: name, kind: 'prompt');
  }

  Future<void> _pingClip(BuildContext context) async {
    final ok = await ClipClient(baseUrl: clipUrlController.text).ping();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? 'Service CLIP joignable.'
              : 'Pas de réponse. Lancez le service sur le PC et vérifiez l’URL.',
        ),
      ),
    );
  }
}
