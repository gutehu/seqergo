import 'package:flutter/material.dart';

import 'auth_repository.dart';

class AuthScope extends InheritedWidget {
  const AuthScope({
    super.key,
    required this.user,
    required this.onLogout,
    required super.child,
  });

  final AuthUser user;
  final VoidCallback onLogout;

  static AuthScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AuthScope>();
    assert(scope != null, 'AuthScope introuvable');
    return scope!;
  }

  @override
  bool updateShouldNotify(AuthScope oldWidget) => oldWidget.user.id != user.id;
}
