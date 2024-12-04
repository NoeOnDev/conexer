import 'package:flutter/material.dart';
import '../../widgets/view_template.dart';
import '../../widgets/appointment_card.dart';
import '../../services/appointment_service.dart';
import '../../models/appointment_response.dart';

class AppointmentsScreen extends StatefulWidget {
  final String token;
  final AppointmentService appointmentService;

  const AppointmentsScreen({
    super.key,
    required this.token,
    required this.appointmentService,
  });

  @override
  AppointmentsScreenState createState() => AppointmentsScreenState();
}

class AppointmentsScreenState extends State<AppointmentsScreen> {
  late Future<List<AppointmentResponse>> _appointmentsFuture;

  @override
  void initState() {
    super.initState();
    _appointmentsFuture =
        widget.appointmentService.getUserAppointments(widget.token);
  }

  void _scheduleAppointment(BuildContext context) {
    Navigator.pushNamed(context, '/schedule-appointment');
  }

  @override
  Widget build(BuildContext context) {
    return ViewTemplate(
      title: 'Historial de Citas',
      scaffoldType: ScaffoldType.citizen,
      content: FutureBuilder<List<AppointmentResponse>>(
        future: _appointmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final errorMessage = snapshot.error.toString();
            if (errorMessage.contains('No appointments found for user ID')) {
              return const Center(
                child: Text('Aún no ha creado ninguna cita.'),
              );
            } else {
              return Center(child: Text('Error: $errorMessage'));
            }
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron citas.'));
          } else {
            final appointments = snapshot.data!;
            return Column(
              children: appointments.map((appointment) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: AppointmentCard(
                    title: appointment.title,
                    userName: appointment.userName,
                    description: appointment.description,
                    dateTime: appointment.dateTime,
                    status: appointment.status,
                    image: Image.asset(
                      'assets/img/img_report_image.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scheduleAppointment(context),
        backgroundColor: const Color(0x8077A1DD),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
