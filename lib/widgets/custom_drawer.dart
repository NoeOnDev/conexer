import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class CustomDrawer extends StatelessWidget {
  final List<String> options;
  final Map<String, String> routes;

  const CustomDrawer({super.key, required this.options, required this.routes});

  void _onMenuItemSelected(BuildContext context, String value) {
    final route = routes[value];
    if (route != null) {
      Navigator.pushNamed(context, route);
    } else if (value == 'Logout') {
      AuthService.logout(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          for (var option in options)
            ListTile(
              leading: Icon(
                _getIconForOption(option),
                color: option == 'Logout' ? Colors.red : null,
              ),
              title: Text(
                option,
                style: TextStyle(
                  color: option == 'Logout' ? Colors.red : null,
                ),
              ),
              onTap: () => _onMenuItemSelected(context, option),
            ),
        ],
      ),
    );
  }

  IconData _getIconForOption(String option) {
    switch (option) {
      case 'Home':
        return Icons.home;
      case 'Reports':
        return Icons.assignment;
      case 'Appointments':
        return Icons.calendar_today;
      case 'News':
        return Icons.article;
      case 'Profile':
        return Icons.person;
      case 'Statistics':
        return Icons.bar_chart;
      case 'Logout':
        return Icons.logout;
      default:
        return Icons.help;
    }
  }
}
