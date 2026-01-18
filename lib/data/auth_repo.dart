import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:m_one/data/user.dart';
import 'package:m_one/data/services/storage.dart';

class AuthResult {
  final bool ok;
  final String? error;
  final User? user;

  const AuthResult._({required this.ok, this.error, this.user});

  factory AuthResult.success(User user) => AuthResult._(ok: true, user: user);
  factory AuthResult.failure(String error) => AuthResult._(ok: false, error: error);
}

class LocalAuthRepository {
  final UserStorageService storage;

  LocalAuthRepository(this.storage);

  // hash pas
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  String _normalize(String s) => s.trim();

  String _normalizeLower(String s) => s.trim().toLowerCase();

  Future<AuthResult> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final u = _normalize(username);
    final e = _normalizeLower(email);
    final p = password;

    // validation
    if (u.isEmpty) return AuthResult.failure('Username is required');
    if (u.length < 4) return AuthResult.failure('Username must be at least 4 characters');
    if (e.isEmpty) return AuthResult.failure('Email is required');
    if (!e.contains('@')) return AuthResult.failure('Email looks invalid');
    if (p.length < 6) return AuthResult.failure('Password must be at least 6 characters');

    final users = await storage.getUsers();

    final existsUsername = users.any((x) => _normalizeLower(x.username) == _normalizeLower(u));
    if (existsUsername) return AuthResult.failure('Username already exists');

    final existsEmail = users.any((x) => _normalizeLower(x.email) == e);
    if (existsEmail) return AuthResult.failure('Email already exists');

    final newUser = User(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      username: u,
      email: e,
      passwordHash: _hashPassword(p),
    );

    users.add(newUser);
    await storage.saveUsers(users);

    //login after reg
    await storage.setSessionUserId(newUser.id);

    return AuthResult.success(newUser);
  }


  Future<AuthResult> login({
    required String username,
    required String password,
  }) async {
    final u = _normalizeLower(username);
    final p = password;

    print({
      "hello": 5
    });
    if (u.isEmpty) return AuthResult.failure('Username is required');
    if (p.isEmpty) return AuthResult.failure('Password is required');

    final users = await storage.getUsers();

    final user = users.cast<User?>().firstWhere(
          (x) => x != null && _normalizeLower(x.username) == u,
      orElse: () => null,
    );

    print(user?.toJson());
    if (user == null) return AuthResult.failure('User not found');

    final hash = _hashPassword(p);
    if (user.passwordHash != hash) return AuthResult.failure('Wrong password');

    await storage.setSessionUserId(user.id);
    return AuthResult.success(user);
  }

  Future<User?> getCurrentUser() async {
    final sessionId = await storage.getSessionUserId();
    if (sessionId == null) return null;

    final users = await storage.getUsers();
    for (final u in users) {
      if (u.id == sessionId) return u;
    }
    return null;
  }

  Future<void> logout() async {
    await storage.clearSession();
  }
}
