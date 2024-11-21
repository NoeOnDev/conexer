import 'package:flutter/material.dart';
import '../widgets/citizen_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CitizenScaffold(
      body: Center(
        child: Text(
          'Welcome!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
