import 'package:flutter/material.dart';
import '../../widgets/view_template.dart';

class NewsHistoryScreen extends StatelessWidget {
  const NewsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ViewTemplate(
      title: 'News History',
      scaffoldType: ScaffoldType.representative,
      content: Center(
        child: Text(
          'Content for News History',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }
}
