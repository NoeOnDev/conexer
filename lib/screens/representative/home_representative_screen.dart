import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/home_template.dart';

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
    return HomeTemplate(
      title: 'Welcome',
      imagePath: 'assets/img/img_home.png',
      texts: const [
        'Interested in the statistics of your community? Want to see the community statistics?',
        'Would you like to create a news update for your community?',
        'Want to see all the reports submitted by the citizens of your community?',
      ],
      buttons: [
        CustomButton(
          text: 'View Community Statistics',
          backgroundColor: const Color(0xFF324A5F),
          onPressed: () => _viewStatistics(context),
          textSize: 16.0,
        ),
        CustomButton(
          text: 'Create News',
          backgroundColor: const Color(0xFF324A5F),
          onPressed: () => _createNews(context),
          textSize: 16.0,
        ),
        CustomButton(
          text: 'View Citizen Reports',
          backgroundColor: const Color(0xFF324A5F),
          onPressed: () => _viewReports(context),
          textSize: 16.0,
        ),
      ],
      scaffoldType: ScaffoldType.representative,
    );
  }
}
