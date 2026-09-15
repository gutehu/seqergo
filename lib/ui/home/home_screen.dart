import 'package:flutter/material.dart';

import '../../domain/observation_mode.dart';
import '../protocol/protocol_setup_screen.dart';
import 'observation_mode_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selection = const ProtocolSelection();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                    children: [
                      const _Header(),
                      const SizedBox(height: 20),
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SEQERGO',
          style: textTheme.labelLarge?.copyWith(
            letterSpacing: 2.4,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text("Type d'observation", style: textTheme.headlineMedium),
        const SizedBox(height: 6),
        Text(
          'Cochez un ou plusieurs modes : ils tourneront ensemble '
          'dans la même session et le même actographe.',
          style: textTheme.bodyLarge,
        ),
      ],
    );
  }
}
