import 'package:flutter/material.dart';
import '../../widgets/report_card.dart';
import '../../widgets/view_template.dart';

class ReportHistoryScreen extends StatelessWidget {
  const ReportHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewTemplate(
      title: 'Report History',
      scaffoldType: ScaffoldType.citizen,
      content: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ReportCard(
              title: 'Report #$index',
              category: 'Water',
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor, justo id tincidunt lacinia.',
              date: '00/00/0000',
              status: index % 2 == 0 ? 'Resolved' : 'In Progress',
              image: Image.asset(
                'assets/img/img_report_image.png',
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
