import 'package:flutter/material.dart';
import '../widgets/labeled_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/link_text.dart';
import '../services/user_service.dart';

class LoginScreen extends StatefulWidget {
  final UserService userService;

  const LoginScreen({super.key, required this.userService});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final usernameOrEmailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameOrEmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (formKey.currentState!.validate()) {
      try {
        final response = await widget.userService.login(
          usernameOrEmailController.text,
          passwordController.text,
        );
        // Handle successful login
      } catch (e) {
        // Handle login error
      }
    }
  }

  void _navigateToRegister() {
    Navigator.pushNamed(context, '/select-register');
  }

  void _navigateToForgotPassword() {
    Navigator.pushNamed(context, '/forgot-password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0x8077A1DD),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Image.asset(
                        'assets/img/img_login.png',
                        width: 250,
                        height: 200,
                      ),
                    ),
                    const SizedBox(height: 16),
                    LabeledTextField(
                      label: 'Username or Email:',
                      controller: usernameOrEmailController,
                    ),
                    const SizedBox(height: 16),
                    LabeledTextField(
                      label: 'Password:',
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 8),
                    LinkText(
                      text: 'Forgot your password?',
                      onTap: _navigateToForgotPassword,
                    ),
                    const SizedBox(height: 28),
                    CustomButton(
                      text: 'Login',
                      backgroundColor: const Color(0xFF324A5F),
                      onPressed: _login,
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: 'Register',
                      backgroundColor: const Color(0xFF6A6A6A),
                      onPressed: _navigateToRegister,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
