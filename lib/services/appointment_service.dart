import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/appointment.dart';
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
}
