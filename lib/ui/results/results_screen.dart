import 'package:flutter/material.dart';

import '../../data/auth_scope.dart';
import '../../data/database_scope.dart';
import '../../data/manual_repository.dart';
import '../../domain/manual_models.dart';
import '../activity/activity_name_dialog.dart';
import '../manual/actograph_screen.dart';
import '../manual/time_format.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late ManualRepository _repo;
  late Stream<List<SessionSummary>> _sessions;
  var _ready = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_ready) return;
    final userId = AuthScope.of(context).user.id;
    _repo = ManualRepository(
      DatabaseScope.of(context),
      userId: userId,
    );
    _sessions = _repo.watchSessions(userId: userId);
    _ready = true;
  }

  Future<void> _rename(SessionSummary session) async {
    final name = await promptActivityName(
      context,
      title: "Nommer l'enregistrement",
      confirmLabel: 'Enregistrer',
      cancelLabel: 'Annuler',
      label: "Nom de l'enregistrement",
      hint: 'Ex. opérateur A — matin',
      initial: session.name.trim().isEmpty ? session.displayName : session.name,
    );
    if (name == null || name.isEmpty) return;
    await _repo.renameSession(session.id, name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Résultats')),
      body: StreamBuilder<List<SessionSummary>>(
        stream: _sessions,
        builder: (context, snapshot) {
          final sessions = snapshot.data ?? const <SessionSummary>[];
          if (sessions.isEmpty) {
            return const Center(child: Text('Aucun résultat pour le moment.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: sessions.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final session = sessions[index];
              return ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: Text(session.displayName),
                subtitle: Text(
                  [
                    if (session.name.trim().isNotEmpty &&
                        session.protocolName != null &&
                        session.protocolName != session.displayName)
                      session.protocolName!,
                    formatSessionStamp(session.startedAt),
                    session.modeLabel,
                    if (session.isOpen) 'en cours',
                  ].join(' · '),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: 'Renommer',
                      visualDensity: VisualDensity.compact,
                      onPressed: () => _rename(session),
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    const Icon(Icons.show_chart),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => ActographScreen(sessionId: session.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
