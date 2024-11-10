import 'package:flutter/material.dart';
import 'screens/register_screen.dart';
import 'screens/complete_registration_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conexer',
      theme: ThemeData(
        fontFamily: 'Hepta Slab',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const RegisterScreen(),
        '/complete-registration': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return CompleteRegistrationScreen(contactId: args['contactId']!);
        },
      },
    );
  }
}
