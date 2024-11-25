import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/report.dart';
import 'base_service.dart';

class ReportService extends BaseService {
  ReportService({required super.baseUrl});

  Future<void> createReport(String token, Report report) async {
    final url = Uri.parse('$baseUrl/api/v1/cases');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(report.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create report');
    }
  }
}
