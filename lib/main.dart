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
import 'screens/citizen/home_citizen_screen.dart';
import 'screens/citizen/create_report_screen.dart';
import 'screens/citizen/schedule_appointment_screen.dart';
import 'screens/citizen/profile_citizen_screen.dart';
import 'screens/citizen/report_history_screen.dart';
import 'screens/citizen/appointments_screen.dart';
import 'screens/citizen/news_screen.dart';
import 'screens/representative/create_news_screen.dart';
import 'screens/representative/home_representative_screen.dart';
import 'screens/representative/profile_representative_screen.dart';
import 'screens/representative/news_history_screen.dart';
import 'screens/representative/citizen_appointments_screen.dart';
import 'screens/representative/citizen_reports_screen.dart';
import 'screens/representative/community_statistics_screen.dart';
import 'services/contact_service.dart';
import 'services/user_service.dart';
import 'services/verify_service.dart';
import 'services/auth_service.dart';
import 'services/report_service.dart';
import 'services/appointment_service.dart';
import 'services/news_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final userToken = prefs.getString('token_user_verification');

  runApp(MyApp(isLoggedIn: userToken != null, userToken: userToken));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? userToken;

  const MyApp({super.key, required this.isLoggedIn, this.userToken});

  @override
  Widget build(BuildContext context) {
    const String baseUrl =
        'https://3816-2806-262-3487-34f-a13a-fd68-2180-54f.ngrok-free.app';

    if (userToken == null) {
      return MaterialApp(
        title: 'Conexer',
        theme: ThemeData(
          fontFamily: 'Hepta Slab',
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x8077A1DD)),
          useMaterial3: true,
        ),
        home: LoginScreen(userService: UserService(baseUrl: baseUrl)),
        debugShowCheckedModeBanner: false,
        routes: _buildRoutes(baseUrl, null),
      );
    }

    return MaterialApp(
      title: 'Conexer',
      theme: ThemeData(
        fontFamily: 'Hepta Slab',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x8077A1DD)),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: AuthService.isTokenValid(baseUrl, userToken!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else if (snapshot.hasData && snapshot.data == true) {
            return FutureBuilder<String?>(
              future: SharedPreferences.getInstance().then(
                (prefs) => prefs.getString('user_role'),
              ),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                } else if (roleSnapshot.hasData) {
                  if (roleSnapshot.data == 'Citizen') {
                    return const HomeCitizenScreen();
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
      routes: _buildRoutes(baseUrl, userToken),
    );
  }

  Map<String, WidgetBuilder> _buildRoutes(String baseUrl, String? token) {
    return {
      '/select-register': (context) => const SelectRegisterScreen(),
      '/register': (context) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        return RegisterScreen(
          contactService: ContactService(baseUrl: baseUrl),
          role: args['role'],
          imagePath: args['imagePath'],
        );
      },
      '/complete-registration': (context) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        return CompleteRegistrationScreen(
            contactId: args['contactId']!,
            role: args['role']!,
            userService: UserService(baseUrl: baseUrl));
      },
      '/verify-account': (context) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        return VerifyAccountScreen(
            token: args['token']!,
            verifyService: VerifyService(baseUrl: baseUrl));
      },
      '/forgot-password': (context) => ForgotPasswordScreen(
            userService: UserService(baseUrl: baseUrl),
          ),
      '/verify-password': (context) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        return VerifyPasswordScreen(
            token: args['token']!,
            verifyService: VerifyService(baseUrl: baseUrl));
      },
      '/reset-password': (context) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        return ResetPasswordScreen(
            jwtToken: args['jwtToken']!,
            userService: UserService(baseUrl: baseUrl));
      },
      '/verify-2fa': (context) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        return Verify2FAScreen(
            token: args['token']!,
            verifyService: VerifyService(baseUrl: baseUrl));
      },
      '/home': (context) => const HomeCitizenScreen(),
      '/home-representative': (context) => const HomeRepresentativeScreen(),
      '/create-report': (context) => FutureBuilder<String?>(
            future: SharedPreferences.getInstance()
                .then((prefs) => prefs.getString('token_user_verification')),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              } else if (snapshot.hasData) {
                return CreateReportScreen(
                  token: snapshot.data!,
                  reportService: ReportService(baseUrl: baseUrl),
                );
              } else {
                return const SplashScreen();
              }
            },
          ),
      '/schedule-appointment': (context) => FutureBuilder<String?>(
            future: SharedPreferences.getInstance()
                .then((prefs) => prefs.getString('token_user_verification')),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              } else if (snapshot.hasData) {
                return ScheduleAppointmentScreen(
                  token: snapshot.data!,
                  appointmentService: AppointmentService(baseUrl: baseUrl),
                );
              } else {
                return const SplashScreen();
              }
            },
          ),
      '/profile-citizen': (context) => FutureBuilder<String?>(
            future: SharedPreferences.getInstance()
                .then((prefs) => prefs.getString('token_user_verification')),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              } else if (snapshot.hasData) {
                return ProfileCitizenScreen(
                  token: snapshot.data!,
                  userService: UserService(baseUrl: baseUrl),
                  contactService: ContactService(baseUrl: baseUrl),
                );
              } else {
                return const SplashScreen();
              }
            },
          ),
      '/profile-representative': (context) => FutureBuilder<String?>(
            future: SharedPreferences.getInstance()
                .then((prefs) => prefs.getString('token_user_verification')),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              } else if (snapshot.hasData) {
                return ProfileRepresentativeScreen(
                  token: snapshot.data!,
                  userService: UserService(baseUrl: baseUrl),
                  contactService: ContactService(baseUrl: baseUrl),
                );
              } else {
                return const SplashScreen();
              }
            },
          ),
      '/report-history': (context) => FutureBuilder<String?>(
            future: SharedPreferences.getInstance()
                .then((prefs) => prefs.getString('token_user_verification')),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              } else if (snapshot.hasData) {
                return ReportHistoryScreen(
                  token: snapshot.data!,
                  reportService: ReportService(baseUrl: baseUrl),
                );
              } else {
                return const SplashScreen();
              }
            },
          ),
      '/appointments': (context) => FutureBuilder<String?>(
            future: SharedPreferences.getInstance()
                .then((prefs) => prefs.getString('token_user_verification')),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              } else if (snapshot.hasData) {
                return AppointmentsScreen(
                  token: snapshot.data!,
                  appointmentService: AppointmentService(baseUrl: baseUrl),
                );
              } else {
                return const SplashScreen();
              }
            },
          ),
      '/news': (context) => FutureBuilder<String?>(
            future: SharedPreferences.getInstance()
                .then((prefs) => prefs.getString('token_user_verification')),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              } else if (snapshot.hasData) {
                return NewsScreen(
                  token: snapshot.data!,
                  newsService: NewsService(baseUrl: baseUrl),
                );
              } else {
                return const SplashScreen();
              }
            },
          ),
      '/create-news': (context) => FutureBuilder<String?>(
            future: SharedPreferences.getInstance()
                .then((prefs) => prefs.getString('token_user_verification')),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              } else if (snapshot.hasData) {
                return CreateNewsScreen(
                  token: snapshot.data!,
                  newsService: NewsService(baseUrl: baseUrl),
                );
              } else {
                return const SplashScreen();
              }
            },
          ),
      '/news-history': (context) => FutureBuilder<String?>(
            future: SharedPreferences.getInstance()
                .then((prefs) => prefs.getString('token_user_verification')),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              } else if (snapshot.hasData) {
                return NewsHistoryScreen(
                  token: snapshot.data!,
                  newsService: NewsService(baseUrl: baseUrl),
                );
              } else {
                return const SplashScreen();
              }
            },
          ),
      '/citizen-appointments': (context) => FutureBuilder<String?>(
            future: SharedPreferences.getInstance()
                .then((prefs) => prefs.getString('token_user_verification')),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              } else if (snapshot.hasData) {
                return CitizenAppointmentsScreen(
                  token: snapshot.data!,
                  appointmentService: AppointmentService(baseUrl: baseUrl),
                  isLocalityAppointments: true,
                );
              } else {
                return const SplashScreen();
              }
            },
          ),
      '/citizen-reports': (context) => FutureBuilder<String?>(
            future: SharedPreferences.getInstance()
                .then((prefs) => prefs.getString('token_user_verification')),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              } else if (snapshot.hasData) {
                return CitizenReportsScreen(
                  token: snapshot.data!,
                  reportService: ReportService(baseUrl: baseUrl),
                );
              } else {
                return const SplashScreen();
              }
            },
          ),
      '/community-statistics': (context) => const CommunityStatisticsScreen(),
    };
  }
}
