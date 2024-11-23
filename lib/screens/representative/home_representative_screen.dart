import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/view_template.dart';

class HomeRepresentativeScreen extends StatelessWidget {
  const HomeRepresentativeScreen({super.key});

  void _reportIssue(BuildContext context) {
    Navigator.pushNamed(context, '/create-report');
  }

  void _scheduleAppointment(BuildContext context) {
    Navigator.pushNamed(context, '/schedule-appointment');
  }

  void _viewNews(BuildContext context) {
    Navigator.pushNamed(context, '/news-representative');
  }

  @override
  Widget build(BuildContext context) {
    return ViewTemplate(
      title: 'Welcome',
      scaffoldType: ScaffoldType.representative,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/img/img_home.png',
              width: 370,
              height: 260,
            ),
          ),
          const Text(
            'Any issues in your community? Want to report them?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Report an Issue',
            backgroundColor: const Color(0xFF324A5F),
            onPressed: () => _reportIssue(context),
            textSize: 16.0,
          ),
          const SizedBox(height: 32),
          const Text(
            'Would you like to schedule an appointment?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Schedule Appointment',
            backgroundColor: const Color(0xFF324A5F),
            onPressed: () => _scheduleAppointment(context),
            textSize: 16.0,
          ),
          const SizedBox(height: 32),
          const Text(
            'Want to see community news?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'View News',
            backgroundColor: const Color(0xFF324A5F),
            onPressed: () => _viewNews(context),
            textSize: 16.0,
          ),
        ],
      ),
    );
  }
}
