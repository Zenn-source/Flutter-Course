import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

const String _kAccessTokenKey = 'accessToken';
const String _kUserKey = 'user';

class UserService {
  final String host = 'https://dummyjson.com';

  Future<User> login(String username, String password) async {
    final uri = Uri.parse('$host/auth/login');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 60,
      }),
    );

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return User.fromJson(data);
    } else {
      throw Exception(data['message'] ?? 'Invalid username or password');
    }
  }

  Future<User> getAuthenticatedUser(String accessToken) async {
    final uri = Uri.parse('$host/auth/me');
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Session expired');
    }
  }

  Future<List<User>> getAllUsers({int limit = 0}) async {
    final uri = Uri.parse('$host/users?limit=$limit');
    final response = await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List usersJson = data['users'] ?? [];
      return usersJson.map((u) => User.fromJson(u)).toList();
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }

  static Future<void> saveSession(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kAccessTokenKey, user.accessToken ?? '');
    await prefs.setString(_kUserKey, jsonEncode(user.toJson()));
  }

  static Future<User?> getSavedSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_kUserKey);
    final token = prefs.getString(_kAccessTokenKey);

    if (userJson == null || token == null || token.isEmpty) {
      return null;
    }

    final data = Map<String, dynamic>.from(jsonDecode(userJson));
    data['accessToken'] = token;
    return User.fromJson(data);
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kAccessTokenKey);
    await prefs.remove(_kUserKey);
  }
}
