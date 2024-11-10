import 'package:flutter/material.dart';
import '../widgets/verify_code_template.dart';

class Verify2FAScreen extends StatelessWidget {
  const Verify2FAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const VerifyCodeTemplate(
      title: 'Two-Factor Authentication',
      message: 'A 5-digit code has been sent to your phone for 2FA.',
    );
  }
}
