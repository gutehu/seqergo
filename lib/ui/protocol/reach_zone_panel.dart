import 'package:flutter/material.dart';

import '../../data/manual_repository.dart';
import '../../domain/reach_zone_models.dart';

class ReachZonePanel extends StatelessWidget {
  const ReachZonePanel({
    super.key,
    required this.recipes,
    required this.repo,
  });

  final List<ReachZoneRecipeItem> recipes;
  final ManualRepository repo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Zones d'atteinte (Screening SEQOIA)",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Mode manuel SEQOIA : une caméra mesure les angles pendant '
          "l'observation. Chaque articulation est suivie à gauche et à droite. "
          'Atteinte = seuil. Chrono = plage en degrés.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final family in ReachJointFamily.values)
              ActionChip(
                avatar: const Icon(Icons.add, size: 18),
                label: Text(family.label),
                onPressed: () => _promptAdd(context, family),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (recipes.isEmpty)
          Text(
            'Ajoutez au moins une zone pour démarrer.',
            style: Theme.of(context).textTheme.bodyMedium,
          )
        else
          for (final recipe in recipes)
            Card(
              margin: const EdgeInsets.only(bottom: 8),
              elevation: 0,
              color: Colors.white,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: recipe.color.withValues(alpha: 0.18),
                  child: Text(
                    recipe.joint.side.short,
                    style: TextStyle(
                      color: recipe.color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                title: Text(recipe.label),
                subtitle: Text(
                  recipe.kind == ReachRecipeKind.validate
                      ? 'Atteinte · ${recipe.joint.side.label}'
                      : 'Chrono · ${recipe.joint.side.label}',
                ),
                trailing: IconButton(
                  tooltip: 'Supprimer',
                  onPressed: () => repo.deleteReachRecipe(recipe.id),
                  icon: const Icon(Icons.delete_outline),
                ),
              ),
            ),
      ],
    );
  }

  Future<void> _promptAdd(BuildContext context, ReachJointFamily family) async {
    final result = await showDialog<_ReachRecipeDraft>(
      context: context,
      builder: (context) => _ReachRecipeDialog(family: family),
    );
    if (result == null) return;
    await repo.addReachRecipe(
      joint: ReachJointInfo.of(family, result.side),
      kind: result.kind,
      validateAngle: result.validateAngle,
      zoneMin: result.kind == ReachRecipeKind.chrono ? result.zoneMin : null,
      zoneMax: result.kind == ReachRecipeKind.chrono ? result.zoneMax : null,
    );
  }
}

class _ReachRecipeDraft {
  const _ReachRecipeDraft({
    required this.side,
    required this.kind,
    required this.validateAngle,
    required this.zoneMin,
    required this.zoneMax,
  });

  final ReachSide side;
  final ReachRecipeKind kind;
  final double validateAngle;
  final double zoneMin;
  final double zoneMax;
}

class _ReachRecipeDialog extends StatefulWidget {
  const _ReachRecipeDialog({required this.family});

  final ReachJointFamily family;

  @override
  State<_ReachRecipeDialog> createState() => _ReachRecipeDialogState();
}

class _ReachRecipeDialogState extends State<_ReachRecipeDialog> {
  var _side = ReachSide.droit;
  var _kind = ReachRecipeKind.validate;
  final _threshold = TextEditingController(text: '90');
  final _min = TextEditingController(text: '85');
  final _max = TextEditingController(text: '95');

  @override
  void dispose() {
    _threshold.dispose();
    _min.dispose();
    _max.dispose();
    super.dispose();
  }

  void _submit() {
    Navigator.pop(
      context,
      _ReachRecipeDraft(
        side: _side,
        kind: _kind,
        validateAngle:
            double.tryParse(_threshold.text.replaceAll(',', '.')) ?? 90,
        zoneMin: double.tryParse(_min.text.replaceAll(',', '.')) ?? 85,
        zoneMax: double.tryParse(_max.text.replaceAll(',', '.')) ?? 95,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Zone ${widget.family.label}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SegmentedButton<ReachSide>(
            segments: const [
              ButtonSegment(
                value: ReachSide.gauche,
                label: Text('Gauche'),
              ),
              ButtonSegment(
                value: ReachSide.droit,
                label: Text('Droit'),
              ),
            ],
            selected: {_side},
            onSelectionChanged: (value) {
              setState(() => _side = value.first);
            },
          ),
          const SizedBox(height: 12),
          SegmentedButton<ReachRecipeKind>(
            segments: const [
              ButtonSegment(
                value: ReachRecipeKind.validate,
                label: Text('Atteinte'),
              ),
              ButtonSegment(
                value: ReachRecipeKind.chrono,
                label: Text('Chrono'),
              ),
            ],
            selected: {_kind},
            onSelectionChanged: (value) {
              setState(() => _kind = value.first);
            },
          ),
          const SizedBox(height: 12),
          if (_kind == ReachRecipeKind.validate)
            TextField(
              controller: _threshold,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Angle seuil (°)',
                filled: true,
                fillColor: Colors.white,
              ),
            )
          else ...[
            TextField(
              controller: _min,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Angle bas (°)',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _max,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Angle haut (°)',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('Ajouter'),
        ),
      ],
    );
  }
}
