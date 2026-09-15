import 'package:flutter/material.dart';

import '../../domain/activity_engine.dart';

class EngineTestButtons extends StatelessWidget {
  const EngineTestButtons({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final ActivityEngineKind selected;
  final ValueChanged<ActivityEngineKind> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Moteurs de test',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        Text(
          'Deux approches à comparer : exemples visuels on-device, '
          'ou descriptions texte via CLIP sur le PC.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        _EngineButton(
          selected: selected == ActivityEngineKind.knn,
          icon: Icons.psychology_alt_outlined,
          title: 'Apprentissage visuel',
          subtitle: 'MobileNet + KNN sur le téléphone',
          color: const Color(0xFF0F766E),
          onTap: () => onSelected(ActivityEngineKind.knn),
        ),
        const SizedBox(height: 10),
        _EngineButton(
          selected: selected == ActivityEngineKind.clip,
          icon: Icons.notes_outlined,
          title: 'Prompts texte',
          subtitle: 'CLIP zero-shot (service Python)',
          color: const Color(0xFF4F46E5),
          onTap: () => onSelected(ActivityEngineKind.clip),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () => onSelected(ActivityEngineKind.observer),
            child: Text(
              selected == ActivityEngineKind.observer
                  ? 'Relevé manuel actif'
                  : 'Relevé manuel (chrono au tap)',
            ),
          ),
        ),
      ],
    );
  }
}

class _EngineButton extends StatelessWidget {
  const _EngineButton({
    required this.selected,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final bool selected;
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? color.withValues(alpha: 0.10) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: selected ? color : const Color(0x1F64748B), width: selected ? 1.6 : 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          child: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                    Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              Icon(
                selected ? Icons.check_circle : Icons.circle_outlined,
                color: selected ? color : const Color(0xFF94A3B8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
