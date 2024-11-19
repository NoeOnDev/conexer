import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'base_service.dart';

class UserService extends BaseService {
  UserService({required super.baseUrl});

  Future<String> registerUser(User user) async {
    final url = Uri.parse('$baseUrl/api/v1/users/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      return responseData['token'];
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future<String> requestPasswordChange(String email) async {
    final url = Uri.parse('$baseUrl/api/v1/users/request-password-change');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['token'];
    } else {
      throw Exception('Failed to request password change');
    }
  }

  Future<String> login(String identifier, String password) async {
    final url = Uri.parse('$baseUrl/api/v1/users/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'identifier': identifier, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['token'];
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> updatePassword(String jwtToken, String newPassword) async {
    final url = Uri.parse('$baseUrl/api/v1/users/update-password');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode({'newPassword': newPassword}),
    );

    if (response.statusCode == 200) {
      // Handle successful response
    } else {
      throw Exception('Failed to update password');
    }
  }
}
