import 'dart:convert';
import 'package:http/http.dart' as http;
import 'base_service.dart';

class VerifyService extends BaseService {
  VerifyService({required super.baseUrl});

  Future<Map<String, dynamic>> validateToken(String token, String code) async {
    final url = Uri.parse('$baseUrl/api/v1/notifications/token/validate');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'code': code}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to validate token');
    }
  }

  Future<void> resendNotification(String token) async {
    final url = Uri.parse('$baseUrl/api/v1/users/resend-notification');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Handle successful response
    } else {
      throw Exception('Failed to resend notification');
    }
  }
}
