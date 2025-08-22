import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// Save token after login
Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("auth_token", token);
}

// Get token whenever needed
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("auth_token");
}

// Remove token on logout
Future<void> clearToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove("auth_token");
}
Map<String, dynamic> decodeJwtPayload(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception("Invalid token format");
  }

  final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
  return jsonDecode(payload);
}