import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/view_template.dart';

class HomeRepresentativeScreen extends StatelessWidget {
  const HomeRepresentativeScreen({super.key});

  void _viewStatistics(BuildContext context) {
    Navigator.pushNamed(context, '/community-statistics');
  }

  void _createNews(BuildContext context) {
    Navigator.pushNamed(context, '/create-news');
  }

  void _viewReports(BuildContext context) {
    Navigator.pushNamed(context, '/citizen-reports');
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
            'Interested in the statistics of your community? Want to see the community statistics?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'View Community Statistics',
            backgroundColor: const Color(0xFF324A5F),
            onPressed: () => _viewStatistics(context),
            textSize: 16.0,
          ),
          const SizedBox(height: 32),
          const Text(
            'Would you like to create a news update for your community?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Create News',
            backgroundColor: const Color(0xFF324A5F),
            onPressed: () => _createNews(context),
            textSize: 16.0,
          ),
          const SizedBox(height: 32),
          const Text(
            'Want to see all the reports submitted by the citizens of your community?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'View Citizen Reports',
            backgroundColor: const Color(0xFF324A5F),
            onPressed: () => _viewReports(context),
            textSize: 16.0,
          ),
        ],
      ),
    );
  }
}
