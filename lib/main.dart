import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/register_screen.dart';
import 'screens/complete_registration_screen.dart';
import 'screens/splash_screen.dart';
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
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final userToken = prefs.getString('token_user_verification');

  runApp(MyApp(isLoggedIn: userToken != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    const String baseUrl =
        'https://f494-2806-262-3487-34f-a408-59f5-4025-b9ca.ngrok-free.app';

    return MaterialApp(
      title: 'Conexer',
      theme: ThemeData(
        fontFamily: 'Hepta Slab',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x8077A1DD)),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: AuthService.isTokenValid(baseUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else if (snapshot.hasData && snapshot.data == true) {
            return const HomeScreen();
          } else {
            return LoginScreen(userService: UserService(baseUrl: baseUrl));
          }
        },
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/select-register': (context) => const SelectRegisterScreen(),
        '/register': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return RegisterScreen(
            contactService: ContactService(baseUrl: baseUrl),
            role: args['role'],
            imagePath: args['imagePath'],
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
