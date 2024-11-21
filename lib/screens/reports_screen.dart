import 'package:flutter/material.dart';
import '../widgets/citizen_scaffold.dart';
import '../widgets/custom_button.dart';
import '../widgets/selection_template.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  void _createReportOrAppointment(BuildContext context) {
    Navigator.pushNamed(context, '/actions');
  }

  void _viewReportHistory() {
    // Navegar a la pantalla de historial de reportes
    // Navigator.pushNamed(context, '/report-history');
  }

  @override
  Widget build(BuildContext context) {
    return CitizenScaffold(
      body: SelectionTemplate(
        title: 'Reports and Appointments',
        imagePath: 'assets/img/img_reports.png',
        buttons: [
          CustomButton(
            text: 'Report or Appointment',
            backgroundColor: const Color(0xFF324A5F),
            onPressed: () => _createReportOrAppointment(context),
            textSize: 18.0,
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'View Report History',
            backgroundColor: const Color(0xFF324A5F),
            onPressed: _viewReportHistory,
            textSize: 18.0,
          ),
        ],
      ),
    );
  }
}
