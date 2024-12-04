import 'package:flutter/material.dart';
import '../../widgets/labeled_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../services/user_service.dart';
import '../../utils/validators.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String jwtToken;
  final UserService userService;

  const ResetPasswordScreen({
    super.key,
    required this.jwtToken,
    required this.userService,
  });

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() async {
    if (formKey.currentState!.validate()) {
      if (newPasswordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Las contraseñas no coinciden.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        isLoading = true;
      });

      try {
        await widget.userService.updatePassword(
          widget.jwtToken,
          newPasswordController.text,
        );
        // Handle successful password update
        if (!mounted) return;
        Navigator.pushNamed(context, '/');
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

  void _cancelResetPassword() {
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
                          'Restablecer Contraseña',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,

                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Image.asset(
                          'assets/img/img_reset_password.png',
                          width: 250,
                          height: 200,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Por favor ingrese su nueva contraseña y confírmela a continuación. Asegúrese de que su contraseña sea fuerte y segura.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      LabeledTextField(
                        label: 'Nueva Contraseña:',
                        keyboardType: TextInputType.visiblePassword,
                        controller: newPasswordController,
                        obscureText: true,
                        validator: Validators.validatePassword,
                      ),
                      const SizedBox(height: 16),
                      LabeledTextField(
                        label: 'Confirmar Contraseña:',
                        keyboardType: TextInputType.visiblePassword,
                        controller: confirmPasswordController,
                        obscureText: true,
                        validator: (value) => Validators.validateRequired(
                            value, 'Confirmar Contraseña'),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Restablecer Contraseña',
                        backgroundColor: const Color(0xFF324A5F),
                        onPressed: _resetPassword,
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: 'Cancelar',
                        backgroundColor: const Color(0xFFC1121F),
                        onPressed: _cancelResetPassword,
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
