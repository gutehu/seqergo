import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

import 'database.dart';

class AuthException implements Exception {
  AuthException(this.message);
  final String message;

  @override
  String toString() => message;
}

class AuthUser {
  const AuthUser({required this.id, required this.username});
  final int id;
  final String username;
}

class AuthRepository {
  AuthRepository(this._db);

  final AppDatabase _db;

  Future<int> userCount() async {
    final rows = await _db.select(_db.appUsers).get();
    return rows.length;
  }

  Future<AuthUser?> findUser(int id) async {
    final row = await (_db.select(
      _db.appUsers,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) return null;
    return AuthUser(id: row.id, username: row.username);
  }

  Future<AuthUser> register({
    required String username,
    required String password,
  }) async {
    final name = username.trim();
    if (name.length < 2) {
      throw AuthException("Le nom d'utilisateur est trop court.");
    }
    if (password.length < 6) {
      throw AuthException('Le mot de passe doit faire au moins 6 caractères.');
    }
    final existing = await (_db.select(
      _db.appUsers,
    )..where((t) => t.username.equals(name))).getSingleOrNull();
    if (existing != null) {
      throw AuthException("Ce nom d'utilisateur existe déjà.");
    }
    final salt = _salt();
    final id = await _db
        .into(_db.appUsers)
        .insert(
          AppUsersCompanion.insert(
            username: name,
            passwordHash: _hash(password, salt),
            salt: salt,
            createdAt: DateTime.now(),
          ),
        );
    return AuthUser(id: id, username: name);
  }

  Future<AuthUser> login({
    required String username,
    required String password,
  }) async {
    final row = await (_db.select(
      _db.appUsers,
    )..where((t) => t.username.equals(username.trim()))).getSingleOrNull();
    if (row == null || row.passwordHash != _hash(password, row.salt)) {
      throw AuthException('Identifiant ou mot de passe incorrect.');
    }
    return AuthUser(id: row.id, username: row.username);
  }

  static String _salt() {
    final bytes = List<int>.generate(16, (_) => Random.secure().nextInt(256));
    return base64Url.encode(bytes);
  }

  static String _hash(String password, String salt) {
    return sha256.convert(utf8.encode('$salt:$password')).toString();
  }
}
