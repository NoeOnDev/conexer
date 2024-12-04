import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';

class AuthService {
  static Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token_user_verification');
    await prefs.remove('user_role');
    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MyApp(isLoggedIn: false),
      ),
      (route) => false,
    );
  }

  static Future<bool> isTokenValid(String baseUrl, String token) async {
    final url = Uri.parse('$baseUrl/api/v1/users/id');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final prefs = await SharedPreferences.getInstance();
        final currentRole = prefs.getString('user_role');
        final newRole = responseData['role']['value'];
        if (currentRole != newRole) {
          await prefs.setString('user_role', newRole);
        }

        return true;
      } else if (response.statusCode == 404) {
        await _clearCredentials();
        return false;
      } else {
        await _clearCredentials();
        return false;
      }
    } catch (e) {
      await _clearCredentials();
      return false;
    }
  }

  static Future<void> _clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token_user_verification');
    await prefs.remove('user_role');
  }
}
