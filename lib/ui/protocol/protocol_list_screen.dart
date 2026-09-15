import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/auth_scope.dart';
import '../../data/database_scope.dart';
import '../../data/manual_repository.dart';
import '../../domain/protocol_models.dart';
import '../manual/manual_session_screen.dart';
import '../manual/time_format.dart';
import 'protocol_setup_screen.dart';

class ProtocolListScreen extends StatefulWidget {
  const ProtocolListScreen({super.key});

  @override
  State<ProtocolListScreen> createState() => _ProtocolListScreenState();
}

class _ProtocolListScreenState extends State<ProtocolListScreen> {
  late ManualRepository _repo;
  late Stream<List<ProtocolItem>> _protocols;
  var _ready = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_ready) return;
    final userId = AuthScope.of(context).user.id;
    _repo = ManualRepository(DatabaseScope.of(context), userId: userId);
    _protocols = _repo.watchProtocols(userId);
    _ready = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mes protocoles')),
      body: StreamBuilder<List<ProtocolItem>>(
        stream: _protocols,
        builder: (context, snapshot) {
          final items = snapshot.data ?? const <ProtocolItem>[];
          if (items.isEmpty) {
            return const Center(
              child: Text('Aucun protocole enregistré.'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final protocol = items[index];
              return Card(
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(protocol.name),
                        subtitle: Text(
                          '${protocol.modeLabel} · ${protocol.sessionCount} session(s)\n'
                          'Modifié ${formatSessionStamp(protocol.updatedAt)}',
                        ),
                        isThreeLine: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Wrap(
                          spacing: 8,
                          children: [
                            FilledButton.tonalIcon(
                              onPressed: () => _edit(protocol),
                              icon: const Icon(Icons.edit_outlined),
                              label: const Text('Modifier'),
                            ),
                            FilledButton.icon(
                              onPressed: () => _restart(protocol),
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('Relancer'),
                            ),
                            if (protocol.sessionCount == 0)
                              IconButton(
                                tooltip: 'Supprimer',
                                onPressed: () => _repo.deleteProtocol(protocol.id),
                                icon: const Icon(Icons.delete_outline),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _edit(ProtocolItem protocol) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ProtocolSetupScreen(protocolId: protocol.id),
      ),
    );
  }

  Future<void> _restart(ProtocolItem protocol) async {
    var clipUrl = '';
    try {
      final prefs = await SharedPreferences.getInstance();
      clipUrl = prefs.getString('clip_base_url') ?? '';
    } catch (_) {}
    final id = await _repo.startSessionFromProtocol(protocol);
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ManualSessionScreen(
          sessionId: id,
          clipBaseUrl: clipUrl,
        ),
      ),
    );
  }
}
