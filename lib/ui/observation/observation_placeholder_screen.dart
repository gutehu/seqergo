import 'package:flutter/material.dart';

import '../../domain/observation_mode.dart';

class ObservationPlaceholderScreen extends StatelessWidget {
  const ObservationPlaceholderScreen({super.key, required this.mode});

  final ObservationMode mode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(mode.title)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: mode.accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(mode.icon, color: mode.accent, size: 36),
            ),
            const SizedBox(height: 28),
            Text(mode.title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 12),
            Text(mode.subtitle, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 24),
            Text(
              'Le protocole de ce mode sera défini dans le prochain cahier des charges. '
              'Wolopi et SeqOIA seront branchés ensuite.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
