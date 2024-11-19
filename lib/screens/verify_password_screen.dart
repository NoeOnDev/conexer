import 'package:flutter/material.dart';
import '../widgets/verify_code_template.dart';
import '../services/verify_service.dart';

class VerifyPasswordScreen extends StatelessWidget {
  final String token;
  final VerifyService verifyService;

  const VerifyPasswordScreen({
    super.key,
    required this.token,
    required this.verifyService,
  });

  @override
  Widget build(BuildContext context) {
    return VerifyCodeTemplate(
      title: 'Verify Password Change',
      message: 'A 5-digit code has been sent to your email address.',
      onConfirmCode: (code) async {
        await verifyService.validateToken(token, code);
        // Handle successful verification
        if (context.mounted) {
          Navigator.pushNamed(
            context,
            '/reset-password',
            arguments: {'token': token},
          );
        }
      },
      onResendCode: () async {
        await verifyService.resendNotification(token);
        // Handle successful resend
      },
    );
  }
}