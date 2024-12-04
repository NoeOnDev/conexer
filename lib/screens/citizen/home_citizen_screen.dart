import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/home_template.dart';

class HomeCitizenScreen extends StatelessWidget {
  const HomeCitizenScreen({super.key});

  void _reportIssue(BuildContext context) {
    Navigator.pushNamed(context, '/create-report');
  }

  void _scheduleAppointment(BuildContext context) {
    Navigator.pushNamed(context, '/schedule-appointment');
  }

  void _viewNews(BuildContext context) {
    Navigator.pushNamed(context, '/news');
  }

  @override
  Widget build(BuildContext context) {
    return HomeTemplate(
      title: 'Bienvenido',
      imagePath: 'assets/img/img_home.png',
      texts: const [
        '¿Algún problema en su comunidad? ¿Quiere reportarlo?',
        '¿Le gustaría agendar una cita?',
        '¿Quiere ver noticias de la comunidad?',
      ],
      buttons: [
        CustomButton(
          text: 'Reportar un Problema',
          backgroundColor: const Color(0xFF324A5F),
          onPressed: () => _reportIssue(context),
          textSize: 16.0,
        ),
        CustomButton(
          text: 'Agendar Cita',
          backgroundColor: const Color(0xFF324A5F),
          onPressed: () => _scheduleAppointment(context),
          textSize: 16.0,
        ),
        CustomButton(
          text: 'Ver Noticias',
          backgroundColor: const Color(0xFF324A5F),
          onPressed: () => _viewNews(context),
          textSize: 16.0,
        ),
      ],
      scaffoldType: ScaffoldType.citizen,
    );
  }
}
