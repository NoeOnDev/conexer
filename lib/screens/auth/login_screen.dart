import 'package:flutter/material.dart';
import '../../widgets/labeled_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/link_text.dart';
import '../../services/user_service.dart';
import '../../utils/validators.dart';

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
  bool isLoading = false;

  @override
  void dispose() {
    usernameOrEmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final token = await widget.userService.login(
          usernameOrEmailController.text.trim(),
          passwordController.text.trim(),
        );
        // Handle successful login
        if (!mounted) return;
        Navigator.pushNamed(
          context,
          '/verify-2fa',
          arguments: {'token': token},
        );
      } catch (e) {
        // Handle login error
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
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
      body: SafeArea(
        child: Padding(
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
                          'Iniciar Sesión',
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
                        label: 'Usuario o Correo Electrónico:',
                        controller: usernameOrEmailController,
                        validator: (value) => Validators.validateRequired(
                            value?.trim(), 'Usuario o Correo Electrónico'),
                      ),
                      const SizedBox(height: 16),
                      LabeledTextField(
                        label: 'Contraseña:',
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) => Validators.validateRequired(
                            value?.trim(), 'Contraseña'),
                      ),
                      const SizedBox(height: 8),
                      LinkText(
                        text: '¿Olvidó su contraseña?',
                        onTap: _navigateToForgotPassword,
                      ),
                      const SizedBox(height: 28),
                      CustomButton(
                        text: 'Iniciar Sesión',
                        backgroundColor: const Color(0xFF324A5F),
                        onPressed: _login,
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: 'Registrarse',
                        backgroundColor: const Color(0xFF6A6A6A),
                        onPressed: _navigateToRegister,
                        enabled: !isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
