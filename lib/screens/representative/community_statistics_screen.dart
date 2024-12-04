import 'package:flutter/material.dart';
import '../../widgets/view_template.dart';

class CommunityStatisticsScreen extends StatelessWidget {
  const CommunityStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ViewTemplate(
      title: 'Estadísticas de la Comunidad',
      scaffoldType: ScaffoldType.representative,
      content: Center(
        child: Text(
          'Contenido para Estadísticas de la Comunidad',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }
}
