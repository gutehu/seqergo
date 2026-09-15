import 'package:flutter/material.dart';

import '../../data/manual_repository.dart';
import '../../domain/manual_models.dart';
import '../../domain/metric_kind.dart';

class ManualTaxonomyPanel extends StatelessWidget {
  const ManualTaxonomyPanel({
    super.key,
    required this.classes,
    required this.repo,
  });

  final List<ObservableClassItem> classes;
  final ManualRepository repo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Manuel',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            TextButton.icon(
              onPressed: () => _addClass(context),
              icon: const Icon(Icons.add),
              label: const Text('Classe'),
            ),
          ],
        ),
        const SizedBox(height: 4),
        if (classes.isEmpty)
          Text(
            "Créez une classe d'observables, puis des sous-classes "
            '(comptage ou chronomètre).',
            style: Theme.of(context).textTheme.bodyMedium,
          )
        else
          for (final item in classes) _ClassCard(item: item, repo: repo),
      ],
    );
  }

  Future<void> _addClass(BuildContext context) async {
    final name = await promptName(context, title: "Nouvelle classe d'observables");
    if (name == null || name.isEmpty) return;
    await repo.addClass(name);
  }
}

class _ClassCard extends StatelessWidget {
  const _ClassCard({required this.item, required this.repo});

  final ObservableClassItem item;
  final ManualRepository repo;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  tooltip: 'Renommer',
                  onPressed: () async {
                    final name = await promptName(
                      context,
                      title: 'Renommer la classe',
                      initial: item.name,
                    );
                    if (name == null || name.isEmpty) return;
                    await repo.renameClass(item.id, name);
                  },
                  icon: const Icon(Icons.edit_outlined),
                ),
                IconButton(
                  tooltip: 'Supprimer la classe',
                  onPressed: () => repo.deleteClass(item.id),
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
            if (item.subclasses.isEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Aucune sous-classe',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            for (final sub in item.subclasses)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: sub.color.withValues(alpha: 0.18),
                  child: Icon(
                    sub.metricType == MetricKind.count
                        ? Icons.plus_one
                        : Icons.timer_outlined,
                    color: sub.color,
                    size: 20,
                  ),
                ),
                title: Text(sub.name),
                subtitle: Text(sub.metricType.label),
                trailing: IconButton(
                  onPressed: () => repo.deleteSubclass(sub.id),
                  icon: const Icon(Icons.close),
                ),
              ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => _addSubclass(context),
                icon: const Icon(Icons.add),
                label: const Text('Sous-classe'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addSubclass(BuildContext context) async {
    final result = await showDialog<(String, MetricKind)>(
      context: context,
      builder: (context) => const _SubclassDialog(),
    );
    if (result == null) return;
    await repo.addSubclass(
      classId: item.id,
      name: result.$1,
      metricType: result.$2,
    );
  }
}

class _SubclassDialog extends StatefulWidget {
  const _SubclassDialog();

  @override
  State<_SubclassDialog> createState() => _SubclassDialogState();
}

class _SubclassDialogState extends State<_SubclassDialog> {
  final _controller = TextEditingController();
  MetricKind _kind = MetricKind.count;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nouvelle sous-classe'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Nom'),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 16),
            RadioGroup<MetricKind>(
              groupValue: _kind,
              onChanged: (value) {
                if (value == null) return;
                setState(() => _kind = value);
              },
              child: const Column(
                children: [
                  RadioListTile<MetricKind>(
                    value: MetricKind.count,
                    title: Text("Nombre d'actions"),
                    subtitle: Text('Chaque clic incrémente le compteur'),
                  ),
                  RadioListTile<MetricKind>(
                    value: MetricKind.duration,
                    title: Text('Temps passé'),
                    subtitle: Text('Clic pour démarrer, clic pour arrêter'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Ajouter')),
      ],
    );
  }

  void _submit() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    Navigator.pop(context, (name, _kind));
  }
}

Future<String?> promptName(
  BuildContext context, {
  required String title,
  String? initial,
}) {
  return showDialog<String>(
    context: context,
    builder: (context) {
      final controller = TextEditingController(text: initial);
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Nom'),
          onSubmitted: (value) => Navigator.pop(context, value.trim()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
