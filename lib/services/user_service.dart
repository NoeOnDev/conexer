import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'base_service.dart';

class UserService extends BaseService {
  UserService({required super.baseUrl});

  Future<Map<String, dynamic>> registerUser(User user) async {
    final url = Uri.parse('$baseUrl/api/v1/users/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future<Map<String, dynamic>> requestPasswordChange(String email) async {
    final url = Uri.parse('$baseUrl/api/v1/users/request-password-change');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to request password change');
    }
  }
}
