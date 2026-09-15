import 'package:flutter/material.dart';

import '../../data/database_scope.dart';
import '../../data/manual_repository.dart';
import '../../domain/manual_models.dart';
import 'actograph_screen.dart';
import 'time_format.dart';

class SessionHistoryScreen extends StatefulWidget {
  const SessionHistoryScreen({super.key});

  @override
  State<SessionHistoryScreen> createState() => _SessionHistoryScreenState();
}

class _SessionHistoryScreenState extends State<SessionHistoryScreen> {
  late Stream<List<SessionSummary>> _sessions;
  var _ready = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_ready) return;
    _sessions = ManualRepository(DatabaseScope.of(context)).watchSessions();
    _ready = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sessions')),
      body: StreamBuilder<List<SessionSummary>>(
        stream: _sessions,
        builder: (context, snapshot) {
          final sessions = snapshot.data ?? const <SessionSummary>[];
          if (sessions.isEmpty) {
            return const Center(child: Text('Aucune session enregistrée.'));
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
                  '${formatSessionStamp(session.startedAt)} · ${session.modeLabel} · ${session.isOpen ? 'En cours' : 'Terminée'}',
                ),
                trailing: const Icon(Icons.chevron_right),
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
