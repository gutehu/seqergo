import 'package:flutter/material.dart';

import '../../domain/observation_mode.dart';

class ObservationModeCard extends StatelessWidget {
  const ObservationModeCard({
    super.key,
    required this.mode,
    required this.selected,
    required this.onTap,
  });

  final ObservationMode mode;
  final bool selected;
  final VoidCallback onTap;

  static const Color _border = Color(0x1F64748B);

  @override
  Widget build(BuildContext context) {
    final accent = mode.accent;

    return Material(
      color: selected ? accent.withValues(alpha: 0.08) : Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: selected ? accent : _border,
          width: selected ? 1.6 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 12, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(mode.icon, color: accent, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      mode.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      mode.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                selected ? Icons.check_circle : Icons.circle_outlined,
                color: selected ? accent : const Color(0xFF94A3B8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
