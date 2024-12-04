import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/home_template.dart';

class HomeRepresentativeScreen extends StatelessWidget {
  const HomeRepresentativeScreen({super.key});

  void _viewStatistics(BuildContext context) {
    Navigator.pushNamed(context, '/community-statistics');
  }

  void _createNews(BuildContext context) {
    Navigator.pushNamed(context, '/create-news');
  }

  void _viewReports(BuildContext context) {
    Navigator.pushNamed(context, '/citizen-reports');
  }

  @override
  Widget build(BuildContext context) {
    return HomeTemplate(
      title: 'Bienvenido',
      imagePath: 'assets/img/img_home.png',
      texts: const [
        '¿Interesado en las estadísticas de su comunidad? ¿Quiere ver las estadísticas de la comunidad?',
        '¿Le gustaría crear una actualización de noticias para su comunidad?',
        '¿Quiere ver todos los reportes enviados por los ciudadanos de su comunidad?',
      ],
      buttons: [
        CustomButton(
          text: 'Ver Estadísticas de la Comunidad',
          backgroundColor: const Color(0xFF324A5F),
          onPressed: () => _viewStatistics(context),
          textSize: 16.0,
        ),
        CustomButton(
          text: 'Crear Noticias',
          backgroundColor: const Color(0xFF324A5F),
          onPressed: () => _createNews(context),
          textSize: 16.0,
        ),
        CustomButton(
          text: 'Ver Reportes de Ciudadanos',
          backgroundColor: const Color(0xFF324A5F),
          onPressed: () => _viewReports(context),
          textSize: 16.0,
        ),
      ],
      scaffoldType: ScaffoldType.representative,
    );
  }
}
