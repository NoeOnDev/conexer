import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/verify.dart';
import 'base_service.dart';

class VerifyService extends BaseService {
  VerifyService({required super.baseUrl});

  Future<void> validateToken(Verify verify) async {
    final url = Uri.parse('$baseUrl/api/v1/notifications/token/validate');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(verify.toJson()),
    );

    if (response.statusCode == 200) {
      // Handle successful response
    } else {
      // Handle error response
      throw Exception('Failed to validate token');
    }
  }
}
