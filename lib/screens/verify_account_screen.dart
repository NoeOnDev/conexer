import 'package:flutter/material.dart';
import '../widgets/verify_code_template.dart';

class VerifyAccountScreen extends StatelessWidget {
  const VerifyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const VerifyCodeTemplate(
      title: 'Verify Your Account',
      message: 'A 5-digit code has been sent to your WhatsApp number.',
    );
  }
}
