import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/auth_repository.dart';
import 'data/auth_scope.dart';
import 'data/database.dart';
import 'data/database_scope.dart';
import 'theme/app_theme.dart';
import 'ui/auth/login_screen.dart';
import 'ui/home/hub_screen.dart';

class SeqErgoApp extends StatefulWidget {
  const SeqErgoApp({super.key, required this.database});

  final AppDatabase database;

  @override
  State<SeqErgoApp> createState() => _SeqErgoAppState();
}

class _SeqErgoAppState extends State<SeqErgoApp> {
  AuthUser? _user;
  var _ready = false;
  var _hasUsers = false;

  @override
  void initState() {
    super.initState();
    _restore();
  }

  Future<void> _restore() async {
    final auth = AuthRepository(widget.database);
    final hasUsers = await auth.userCount() > 0;
    AuthUser? user;
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getInt('current_user_id');
      if (id != null) {
        user = await auth.findUser(id);
      }
    } catch (_) {}
    if (!mounted) return;
    setState(() {
      _hasUsers = hasUsers;
      _user = user;
      _ready = true;
    });
  }

  Future<void> _onAuthenticated(AuthUser user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('current_user_id', user.id);
    } catch (_) {}
    if (!mounted) return;
    setState(() {
      _user = user;
      _hasUsers = true;
    });
  }

  Future<void> _logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('current_user_id');
    } catch (_) {}
    if (!mounted) return;
    setState(() => _user = null);
  }

  @override
  Widget build(BuildContext context) {
    return DatabaseScope(
      database: widget.database,
      child: MaterialApp(
        title: 'SeqErgo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        builder: (context, child) {
          if (_user == null) return child ?? const SizedBox.shrink();
          return AuthScope(
            user: _user!,
            onLogout: _logout,
            child: child!,
          );
        },
        home: !_ready
            ? const Scaffold(body: Center(child: CircularProgressIndicator()))
            : _user == null
                ? LoginScreen(
                    forceRegister: !_hasUsers,
                    onAuthenticated: _onAuthenticated,
                  )
                : _MainShell(username: _user!.username, onLogout: _logout),
      ),
    );
  }
}

class _MainShell extends StatelessWidget {
  const _MainShell({required this.username, required this.onLogout});

  final String username;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
        actions: [
          IconButton(
            tooltip: 'Déconnexion',
            onPressed: onLogout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const HubScreen(),
    );
  }
}
