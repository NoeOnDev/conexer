import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<void> registerUser(User user) async {
    final url = Uri.parse('$baseUrl/api/v1/users/contacts');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      // Handle successful response
    } else {
      // Handle error response
      throw Exception('Failed to register user');
    }
  }
}