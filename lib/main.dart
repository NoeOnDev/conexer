import 'package:flutter/material.dart';
import 'screens/register_screen.dart';
import 'screens/complete_registration_screen.dart';
import 'screens/verify_account_screen.dart';
import 'screens/verify_password_screen.dart';
import 'screens/verify_2fa_screen.dart';
import 'screens/login_screen.dart';
import 'screens/select_register_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/home_screen.dart';
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
        'https://8b6a-2806-262-3487-34f-ed35-164c-9e0a-6ac9.ngrok-free.app';

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
            LoginScreen(userService: UserService(baseUrl: baseUrl)),
        '/select-register': (context) => const SelectRegisterScreen(),
        '/register': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return RegisterScreen(
            contactService: ContactService(baseUrl: baseUrl),
            role: args['role'],
          );
        },
        '/complete-registration': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return CompleteRegistrationScreen(
              contactId: args['contactId']!,
              role: args['role']!,
              userService: UserService(baseUrl: baseUrl));
        },
        '/verify-account': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return VerifyAccountScreen(
              token: args['token']!,
              verifyService: VerifyService(baseUrl: baseUrl));
        },
        '/forgot-password': (context) => ForgotPasswordScreen(
              userService: UserService(baseUrl: baseUrl),
            ),
        '/verify-password': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return VerifyPasswordScreen(
              token: args['token']!,
              verifyService: VerifyService(baseUrl: baseUrl));
        },
        '/reset-password': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return ResetPasswordScreen(
              jwtToken: args['jwtToken']!,
              userService: UserService(baseUrl: baseUrl));
        },
        '/verify-2fa': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return Verify2FAScreen(
              token: args['token']!,
              verifyService: VerifyService(baseUrl: baseUrl));
        },
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
