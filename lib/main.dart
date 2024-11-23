import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/complete_registration_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/verify_account_screen.dart';
import 'screens/auth/verify_password_screen.dart';
import 'screens/auth/verify_2fa_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/select_register_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/reset_password_screen.dart';
import 'screens/citizen/home_screen.dart';
import 'screens/citizen/create_report_screen.dart';
import 'screens/citizen/schedule_appointment_screen.dart';
import 'screens/citizen/profile_screen.dart';
import 'screens/citizen/report_history_screen.dart';
import 'screens/citizen/appointments_screen.dart';
import 'screens/citizen/news_screen.dart';
import 'screens/representative/home_representative_screen.dart';
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
        'https://241a-2806-262-3487-34f-401c-1b3f-6f4a-ad4c.ngrok-free.app';

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
            return FutureBuilder<String?>(
              future: SharedPreferences.getInstance().then(
                (prefs) => prefs.getString('user_role'),
              ),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.hasData) {
                  if (roleSnapshot.data == 'Citizen') {
                    return const HomeScreen();
                  } else if (roleSnapshot.data == 'Representative') {
                    return const HomeRepresentativeScreen();
                  }
                }
                return LoginScreen(userService: UserService(baseUrl: baseUrl));
              },
            );
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
        '/home-representative': (context) => const HomeRepresentativeScreen(),
        '/create-report': (context) => const CreateReportScreen(),
        '/schedule-appointment': (context) => const ScheduleAppointmentScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/report-history': (context) => const ReportHistoryScreen(),
        '/appointments': (context) => const AppointmentsScreen(),
        '/news': (context) => const NewsScreen(),
      },
    );
  }
}
