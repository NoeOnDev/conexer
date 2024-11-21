import 'package:flutter/material.dart';
import '../widgets/citizen_scaffold.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _reportIssue() {
    // Navegar a la pantalla de reportes
    // Navigator.pushNamed(context, '/report-issue');
  }

  void _viewEvents() {
    // Navegar a la pantalla de eventos
    // Navigator.pushNamed(context, '/events');
  }

  void _viewNews() {
    // Navegar a la pantalla de noticias
    // Navigator.pushNamed(context, '/news');
  }

  @override
  Widget build(BuildContext context) {
    return CitizenScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Image.asset(
                    'assets/img/img_home.png',
                    width: 300,
                    height: 250,
                  ),
                ),
                const SizedBox(height: 16),
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
                  onPressed: _reportIssue,
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
                  onPressed: _viewEvents,
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
                  onPressed: _viewNews,
                  textSize: 16.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
