import 'package:flutter/material.dart';
import '../widgets/labeled_text_field.dart';
import '../widgets/custom_button.dart';
import '../services/user_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String userId;
  final UserService userService;

  const ResetPasswordScreen({
    super.key,
    required this.userId,
    required this.userService,
  });

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() async {
    if (formKey.currentState!.validate()) {
      if (newPasswordController.text != confirmPasswordController.text) {
        return;
      }

      try {
        await widget.userService.updatePassword(
          widget.userId,
          newPasswordController.text,
        );
        // Handle successful password update
        if (!mounted) return;
        Navigator.pushNamed(context, '/');
      } catch (e) {
        // Handle error
      }
    }
  }

  void _cancelResetPassword() {
    Navigator.pop(context);
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
                        'Reset Password',
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
                      'Please enter your new password and confirm it below. Make sure your password is strong and secure.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    LabeledTextField(
                      label: 'New Password:',
                      keyboardType: TextInputType.visiblePassword,
                      controller: newPasswordController,
                    ),
                    const SizedBox(height: 16),
                    LabeledTextField(
                      label: 'Confirm Password:',
                      keyboardType: TextInputType.visiblePassword,
                      controller: confirmPasswordController,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'Reset Password',
                      backgroundColor: const Color(0xFF324A5F),
                      onPressed: _resetPassword,
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: 'Cancel',
                      backgroundColor: const Color(0xFFC1121F),
                      onPressed: _cancelResetPassword,
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
