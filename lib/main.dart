import 'package:flutter/material.dart';
import 'screens/register_screen.dart';
import 'screens/complete_registration_screen.dart';
import 'screens/verify_account_screen.dart';
import 'screens/verify_2fa_screen.dart';
import 'screens/change_password_screen.dart';
import 'services/contact_service.dart';
import 'services/user_service.dart';

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
        '/': (context) =>
            RegisterScreen(contactService: ContactService(baseUrl: baseUrl)),
        '/complete-registration': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return CompleteRegistrationScreen(
              contactId: args['contactId']!,
              userService: UserService(baseUrl: baseUrl));
        },
        '/verify-account': (context) => const VerifyAccountScreen(),
        '/verify-2fa': (context) => const Verify2FAScreen(),
        '/change-password': (context) => const ChangePasswordScreen(),
      },
    );
  }
}
