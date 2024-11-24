import 'package:flutter/material.dart';
import '../../widgets/view_template.dart';

class ReportHistoryScreen extends StatelessWidget {
  const ReportHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ViewTemplate(
      title: 'Report History',
      scaffoldType: ScaffoldType.citizen,
      content: Center(
        child: Text(
          'Content for Report History',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }
}
