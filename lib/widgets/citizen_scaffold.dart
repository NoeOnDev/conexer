import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class CitizenScaffold extends StatelessWidget {
  final Widget body;

  const CitizenScaffold({super.key, required this.body});

  void _onMenuItemSelected(BuildContext context, String value) {
    switch (value) {
      case 'Home':
        Navigator.pushNamed(context, '/home');
        break;
      case 'Reports':
        Navigator.pushNamed(context, '/reports');
        break;
      case 'Appointments':
        Navigator.pushNamed(context, '/appointments');
        break;
      case 'News':
        Navigator.pushNamed(context, '/news');
        break;
      case 'Profile':
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0x8077A1DD),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage:
                          AssetImage('assets/img/img_logo_conexer.png'),
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => _onMenuItemSelected(context, 'Home'),
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Reports'),
              onTap: () => _onMenuItemSelected(context, 'Reports'),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Appointments'),
              onTap: () => _onMenuItemSelected(context, 'Appointments'),
            ),
            ListTile(
              leading: const Icon(Icons.article),
              title: const Text('News'),
              onTap: () => _onMenuItemSelected(context, 'News'),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () => _onMenuItemSelected(context, 'Profile'),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () => AuthService.logout(context),
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
