import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/appointment.dart';
import '../models/appointment_response.dart';
import 'base_service.dart';

class AppointmentService extends BaseService {
  AppointmentService({required super.baseUrl});

  Future<void> scheduleAppointment(
      String token, Appointment appointment) async {
    final url = Uri.parse('$baseUrl/api/v1/cases/appointments');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(appointment.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to schedule appointment');
    }
  }

  Future<List<AppointmentResponse>> getUserAppointments(String token) async {
    final url = Uri.parse('$baseUrl/api/v1/cases/appointments/user');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData
          .map((json) => AppointmentResponse.fromJson(json))
          .toList();
    } else if (response.statusCode == 404) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('error')) {
        throw Exception(responseData['error']);
      } else {
        throw Exception('Failed to load user appointments');
      }
    } else {
      throw Exception('Failed to load user appointments');
    }
  }

  Future<List<AppointmentResponse>> getLocalityAppointments(
      String token) async {
    final url = Uri.parse('$baseUrl/api/v1/cases/appointments/locality');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData
          .map((json) => AppointmentResponse.fromJson(json))
          .toList();
    } else if (response.statusCode == 404) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('error')) {
        throw Exception(responseData['error']);
      } else {
        throw Exception('Failed to load locality appointments');
      }
    } else {
      throw Exception('Failed to load locality appointments');
    }
  }

  Future<void> updateAppointmentStatus(
      String token, String appointmentId, String status) async {
    final url = Uri.parse('$baseUrl/api/v1/cases/appointments/status');
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'appointmentId': appointmentId,
        'status': status,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update appointment status');
    }
  }
}
