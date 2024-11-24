import 'package:flutter/material.dart';
import '../../widgets/view_template.dart';

class CommunityStatisticsScreen extends StatelessWidget {
  const CommunityStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ViewTemplate(
      title: 'Community Statistics',
      scaffoldType: ScaffoldType.representative,
      content: Center(
        child: Text(
          'Content for Community Statistics',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }
}
