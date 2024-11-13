import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/verify.dart';
import 'base_service.dart';

class VerifyService extends BaseService {
  VerifyService({required super.baseUrl});

  Future<Map<String, dynamic>> validateToken(Verify verify) async {
    final url = Uri.parse('$baseUrl/api/v1/notifications/token/validate');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(verify.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to validate token');
    }
  }

  Future<void> resendNotification(ResendNotification resendNotification) async {
    final url = Uri.parse('$baseUrl/api/v1/users/resend-notification');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(resendNotification.toJson()),
    );

    if (response.statusCode == 200) {
      // Handle successful response
    } else {
      throw Exception('Failed to resend notification');
    }
  }
}
