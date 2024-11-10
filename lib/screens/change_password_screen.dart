import 'package:flutter/material.dart';
import '../widgets/verify_code_template.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const VerifyCodeTemplate(
      title: 'Change Password',
      message:
          'A 5-digit code has been sent to your phone to change your password.',
    );
  }
}
