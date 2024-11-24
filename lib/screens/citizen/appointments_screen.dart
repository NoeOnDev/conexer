import 'package:flutter/material.dart';
import '../../widgets/view_template.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ViewTemplate(
      title: 'Appointments',
      scaffoldType: ScaffoldType.citizen,
      content: Center(
        child: Text(
          'Content for Appointments',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }
}
