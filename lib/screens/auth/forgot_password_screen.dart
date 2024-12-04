import 'package:flutter/material.dart';
import '../../widgets/labeled_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../services/user_service.dart';
import '../../utils/validators.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final UserService userService;

  const ForgotPasswordScreen({super.key, required this.userService});

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _requestPasswordReset() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final token = await widget.userService
            .requestPasswordChange(emailController.text);
        // Handle successful password change request
        if (!mounted) return;
        Navigator.pushNamed(
          context,
          '/verify-password',
          arguments: {'token': token},
        );
      } catch (e) {
        // Handle error
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  void _cancel() {
    Navigator.pop(context);
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
                          'Olvidó su Contraseña',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Image.asset(
                          'assets/img/img_forgot_password.png',
                          width: 250,
                          height: 200,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Por favor ingrese su dirección de correo electrónico para solicitar un restablecimiento de contraseña.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      LabeledTextField(
                        label: 'Correo Electrónico:',
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: Validators.validateEmail,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Solicitar',
                        backgroundColor: const Color(0xFF324A5F),
                        onPressed: _requestPasswordReset,
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: 'Cancelar',
                        backgroundColor: const Color(0xFFC1121F),
                        onPressed: _cancel,
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
