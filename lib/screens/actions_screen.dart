import 'package:flutter/material.dart';
import '../widgets/citizen_scaffold.dart';
import '../widgets/custom_button.dart';
import '../widgets/selection_template.dart';

class ActionsScreen extends StatelessWidget {
  const ActionsScreen({super.key});

  void _reportIssue(BuildContext context) {
    Navigator.pushNamed(context, '/create-report');
  }

  void _proposeEvent() {
    // Navegar a la pantalla de proponer eventos
    // Navigator.pushNamed(context, '/propose-event');
  }

  void _scheduleAppointment() {
    // Navegar a la pantalla de agendar citas
    // Navigator.pushNamed(context, '/schedule-appointment');
  }

  @override
  Widget build(BuildContext context) {
    return CitizenScaffold(
      body: SelectionTemplate(
        title: 'Actions',
        imagePath: 'assets/img/img_actions.png',
        buttons: [
          CustomButton(
            text: 'Report an Issue',
            backgroundColor: const Color(0xFF324A5F),
            onPressed: () => _reportIssue(context),
            textSize: 18.0,
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Propose an Event',
            backgroundColor: const Color(0xFF324A5F),
            onPressed: _proposeEvent,
            textSize: 18.0,
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Schedule an Appointment',
            backgroundColor: const Color(0xFF324A5F),
            onPressed: _scheduleAppointment,
            textSize: 18.0,
          ),
        ],
      ),
    );
  }
}
