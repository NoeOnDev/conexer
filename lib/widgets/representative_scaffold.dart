import 'package:flutter/material.dart';
import 'custom_drawer.dart';

class RepresentativeScaffold extends StatelessWidget {
  final Widget body;

  const RepresentativeScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conexer',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0x8077A1DD),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: const Center(
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                ),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const CustomDrawer(
        options: [
          'Inicio',
          'Estadísticas',
          'Reportes',
          'Citas',
          'Noticias',
          'Perfil',
          'Cerrar Sesión'
        ],
        routes: {
          'Inicio': '/home-representative',
          'Estadísticas': '/community-statistics',
          'Reportes': '/citizen-reports',
          'Citas': '/citizen-appointments',
          'Noticias': '/news-history',
          'Perfil': '/profile-representative',
        },
      ),
      body: body,
    );
  }
}
