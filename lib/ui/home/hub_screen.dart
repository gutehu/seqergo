import 'package:flutter/material.dart';

import '../../domain/observation_mode.dart';
import '../protocol/protocol_list_screen.dart';
import '../protocol/protocol_setup_screen.dart';
import '../results/results_screen.dart';
import 'observation_mode_card.dart';

class HubScreen extends StatelessWidget {
  const HubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
            children: [
              Text(
                'SEQERGO',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      letterSpacing: 2.4,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'Observation',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Configurez un protocole, relancez-en un existant, '
                'ou consultez les actogrammes.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 28),
              _HubCard(
                icon: Icons.add_chart,
                title: 'Nouveau protocole',
                subtitle: 'Choisir les modes, puis enregistrer la recette.',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const NewProtocolScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              _HubCard(
                icon: Icons.folder_open_outlined,
                title: 'Mes protocoles',
                subtitle: 'Retrouver, modifier ou relancer une observation.',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const ProtocolListScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              _HubCard(
                icon: Icons.insights_outlined,
                title: 'Résultats',
                subtitle: 'Actogrammes synchronisés de vos sessions.',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const ResultsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HubCard extends StatelessWidget {
  const _HubCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0x1F64748B)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 16, 18),
          child: Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFF94A3B8)),
            ],
          ),
        ),
      ),
    );
  }
}

class NewProtocolScreen extends StatefulWidget {
  const NewProtocolScreen({super.key});

  @override
  State<NewProtocolScreen> createState() => _NewProtocolScreenState();
}

class _NewProtocolScreenState extends State<NewProtocolScreen> {
  var _selection = const ProtocolSelection();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nouveau protocole')),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
                    children: [
                      Text(
                        'Cochez un ou plusieurs modes : ils tourneront ensemble '
                        'dans la même session et le même actogramme.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      for (final mode in ObservationMode.values) ...[
                        ObservationModeCard(
                          mode: mode,
                          selected: _selection.isSelected(mode),
                          onTap: () {
                            setState(() => _selection = _selection.toggle(mode));
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _selection.isEmpty
                          ? null
                          : () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => ProtocolSetupScreen(
                                    selection: _selection,
                                  ),
                                ),
                              );
                            },
                      icon: const Icon(Icons.tune),
                      label: const Text('Configurer le protocole'),
                    ),
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
