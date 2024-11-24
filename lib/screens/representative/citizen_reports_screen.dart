import 'package:flutter/material.dart';
import '../../widgets/view_template.dart';

class CitizenReportsScreen extends StatelessWidget {
  const CitizenReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ViewTemplate(
      title: 'Citizen Reports',
      scaffoldType: ScaffoldType.representative,
      content: Center(
        child: Text(
          'Content for Citizen Reports',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
        ),
      ),
    );
  }
}
