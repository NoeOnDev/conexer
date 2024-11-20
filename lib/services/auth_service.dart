import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
}
