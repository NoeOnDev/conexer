import 'package:flutter/material.dart';
import '../../widgets/appointment_card.dart';
import '../../widgets/view_template.dart';
import '../../services/appointment_service.dart';
import '../../models/appointment_response.dart';

class CitizenAppointmentsScreen extends StatefulWidget {
  final String token;
  final AppointmentService appointmentService;
  final bool isLocalityAppointments;

  const CitizenAppointmentsScreen({
    super.key,
    required this.token,
    required this.appointmentService,
    this.isLocalityAppointments = false,
  });

  @override
  CitizenAppointmentsScreenState createState() =>
      CitizenAppointmentsScreenState();
}

class CitizenAppointmentsScreenState extends State<CitizenAppointmentsScreen> {
  late Future<List<AppointmentResponse>> _appointmentsFuture;

  @override
  void initState() {
    super.initState();
    _appointmentsFuture = widget.isLocalityAppointments
        ? widget.appointmentService.getLocalityAppointments(widget.token)
        : widget.appointmentService.getUserAppointments(widget.token);
  }

  void _acceptAppointment(String appointmentId) async {
    try {
      await widget.appointmentService.updateAppointmentStatus(
        widget.token,
        appointmentId,
        'ACCEPTED',
      );
      setState(() {
        _appointmentsFuture = widget.isLocalityAppointments
            ? widget.appointmentService.getLocalityAppointments(widget.token)
            : widget.appointmentService.getUserAppointments(widget.token);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error accepting appointment'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _rejectAppointment(String appointmentId) async {
    try {
      await widget.appointmentService.updateAppointmentStatus(
        widget.token,
        appointmentId,
        'REJECTED',
      );
      setState(() {
        _appointmentsFuture = widget.isLocalityAppointments
            ? widget.appointmentService.getLocalityAppointments(widget.token)
            : widget.appointmentService.getUserAppointments(widget.token);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error rejecting appointment'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewTemplate(
      title: widget.isLocalityAppointments
          ? 'Locality Appointments'
          : 'Citizen Appointments',
      scaffoldType: widget.isLocalityAppointments
          ? ScaffoldType.representative
          : ScaffoldType.citizen,
      content: FutureBuilder<List<AppointmentResponse>>(
        future: _appointmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final errorMessage = snapshot.error.toString();
            if (errorMessage.contains('No appointments found')) {
              return const Center(
                child: Text('No appointments found.'),
              );
            } else {
              return Center(child: Text('Error: $errorMessage'));
            }
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No appointments found.'));
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
                      'assets/img/img_appointment.png',
                      fit: BoxFit.cover,
                    ),
                    onAccepted: widget.isLocalityAppointments
                        ? () => _acceptAppointment(appointment.id)
                        : null,
                    onRejected: widget.isLocalityAppointments
                        ? () => _rejectAppointment(appointment.id)
                        : null,
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
