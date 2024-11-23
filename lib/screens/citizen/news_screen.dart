import 'package:flutter/material.dart';
import '../../widgets/view_template.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ViewTemplate(
      title: 'Community News',
      scaffoldType: ScaffoldType.citizen,
      content: Center(
        child: Text(
          'Content for Community News',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
        ),
      ),
    );
  }
}
