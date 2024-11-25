import 'package:flutter/material.dart';
import '../../widgets/view_template.dart';

class CitizenAppointmentsScreen extends StatelessWidget {
  const CitizenAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ViewTemplate(
      title: 'Citizen Appointments',
      scaffoldType: ScaffoldType.representative,
      content: Center(
        child: Text(
          'Content for Citizen Appointments',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }
}