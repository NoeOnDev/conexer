import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/report.dart';
import '../models/report_response.dart';
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

  Future<List<ReportResponse>> getUserReports(String token) async {
    final url = Uri.parse('$baseUrl/api/v1/cases/user');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => ReportResponse.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('error')) {
        throw Exception(responseData['error']);
      } else {
        throw Exception('Failed to load user reports');
      }
    } else {
      throw Exception('Failed to load user reports');
    }
  }

  Future<List<ReportResponse>> getAllReports(String token) async {
    final url = Uri.parse('$baseUrl/api/v1/cases');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => ReportResponse.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('error')) {
        throw Exception(responseData['error']);
      } else {
        throw Exception('Failed to load all reports');
      }
    } else {
      throw Exception('Failed to load all reports');
    }
  }

  Future<void> updateReportStatus(
      String token, String reportId, String status) async {
    final url = Uri.parse('$baseUrl/api/v1/cases/status');
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'reportId': reportId,
        'status': status,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update report status');
    }
  }
}
