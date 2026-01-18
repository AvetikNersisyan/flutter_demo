import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:m_one/data/user.dart';

class UserStorageService {
  static const String usersKey = 'users';
  static const String sessionUserIdKey = 'session_user_id';

  SharedPreferences? _prefs;

  Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> saveString(String key, String value) async {
    final prefs = await _getPrefs();
    await prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await _getPrefs();
    return prefs.getString(key);
  }

  Future<void> removeKey(String key) async {
    final prefs = await _getPrefs();
    await prefs.remove(key);
  }

  // all users
  Future<List<User>> getUsers() async {
    print({
      'barev'
    });
    final prefs = await _getPrefs();
    print(prefs);
    final raw = prefs.getString(usersKey);
    print({
      'test'
    });
    if (raw == null || raw.trim().isEmpty) return [];

    try {
      final decoded = jsonDecode(raw);

      if (decoded is! List) return [];

      final users = <User>[];
      for (final item in decoded) {
        if (item is Map<String, dynamic>) {
          users.add(User.fromJson(item));
        } else if (item is Map) {
          users.add(User.fromJson(Map<String, dynamic>.from(item)));
        }
      }
      return users;
    } catch (_) {
      return [];
    }
  }

  Future<void> saveUsers(List<User> users) async {
    final prefs = await _getPrefs();
    final raw = jsonEncode(users.map((u) => u.toJson()).toList());
    await prefs.setString(usersKey, raw);
  }

  Future<String?> getSessionUserId() async {
    final prefs = await _getPrefs();
    final id = prefs.getString(sessionUserIdKey);
    if (id == null || id.trim().isEmpty) return null;
    return id;
  }

  Future<void> setSessionUserId(String userId) async {
    final prefs = await _getPrefs();
    await prefs.setString(sessionUserIdKey, userId);
  }

  Future<void> clearSession() async {
    final prefs = await _getPrefs();
    await prefs.remove(sessionUserIdKey);
  }
}
