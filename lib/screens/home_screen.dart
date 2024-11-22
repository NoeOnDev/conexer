import 'package:flutter/material.dart';
import '../widgets/citizen_scaffold.dart';
import '../widgets/custom_button.dart';
import '../widgets/selection_template.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _reportIssue(BuildContext context) {
    Navigator.pushNamed(context, '/create-report');
  }

  void _viewEvents(BuildContext context) {
    Navigator.pushNamed(context, '/events');
  }

  void _viewNews(BuildContext context) {
    Navigator.pushNamed(context, '/news');
  }

  @override
  Widget build(BuildContext context) {
    return CitizenScaffold(
      body: SelectionTemplate(
        title: 'Welcome',
        imagePath: 'assets/img/img_home.png',
        buttons: [
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
            'Want to see nearby events?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'View Events',
            backgroundColor: const Color(0xFF324A5F),
            onPressed: () => _viewEvents(context),
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
