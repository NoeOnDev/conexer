import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/home_template.dart';

class HomeCitizenScreen extends StatelessWidget {
  const HomeCitizenScreen({super.key});

  void _reportIssue(BuildContext context) {
    Navigator.pushNamed(context, '/create-report');
  }

  void _scheduleAppointment(BuildContext context) {
    Navigator.pushNamed(context, '/schedule-appointment');
  }

  void _viewNews(BuildContext context) {
    Navigator.pushNamed(context, '/news');
  }

  @override
  Widget build(BuildContext context) {
    return HomeTemplate(
      title: 'Welcome',
      imagePath: 'assets/img/img_home.png',
      texts: const [
        'Any issues in your community? Want to report them?',
        'Would you like to schedule an appointment?',
        'Want to see community news?',
      ],
      buttons: [
        CustomButton(
          text: 'Report an Issue',
          backgroundColor: const Color(0xFF324A5F),
          onPressed: () => _reportIssue(context),
          textSize: 16.0,
        ),
        CustomButton(
          text: 'Schedule Appointment',
          backgroundColor: const Color(0xFF324A5F),
          onPressed: () => _scheduleAppointment(context),
          textSize: 16.0,
        ),
        CustomButton(
          text: 'View News',
          backgroundColor: const Color(0xFF324A5F),
          onPressed: () => _viewNews(context),
          textSize: 16.0,
        ),
      ],
      scaffoldType: ScaffoldType.citizen,
    );
  }
}
