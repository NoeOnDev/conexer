import 'package:flutter/material.dart';
import 'screens/register_screen.dart';
import 'screens/complete_registration_screen.dart';
import 'screens/verify_account_screen.dart';
import 'screens/login_screen.dart';
import 'screens/select_register_screen.dart';
import 'services/contact_service.dart';
import 'services/user_service.dart';
import 'services/verify_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String baseUrl =
        'https://c906-2806-262-3487-34f-c70b-c327-78f0-84d2.ngrok-free.app';

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
        '/': (context) => const LoginScreen(),
        '/select-register': (context) => const SelectRegisterScreen(),
        '/register': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return RegisterScreen(
            contactService: ContactService(baseUrl: baseUrl),
            role: args['role'],
          );
        },
        '/complete-registration': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return CompleteRegistrationScreen(
              contactId: args['contactId']!,
              userService: UserService(baseUrl: baseUrl));
        },
        '/verify-account': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return VerifyAccountScreen(
              userId: args['userId']!,
              verifyService: VerifyService(baseUrl: baseUrl));
        },
      },
    );
  }
}