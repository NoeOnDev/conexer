import 'package:flutter/material.dart';
import '../widgets/verify_code_template.dart';
import '../services/verify_service.dart';
import '../models/verify.dart';

class VerifyPasswordScreen extends StatelessWidget {
  final String userId;
  final VerifyService verifyService;

  const VerifyPasswordScreen({
    super.key,
    required this.userId,
    required this.verifyService,
  });

  @override
  Widget build(BuildContext context) {
    return VerifyCodeTemplate(
      title: 'Verify Password Change',
      message: 'A 5-digit code has been sent to your email address.',
      onConfirmCode: (code) async {
        final verify = Verify(
            userId: userId, code: code, eventType: 'user_change_password');
        await verifyService.validateToken(verify);
        // Handle successful verification
        if (context.mounted) {
          Navigator.pushNamed(context, '/');
        }
      },
      onResendCode: () async {
        final resendNotification = ResendNotification(
          userId: userId,
          notificationType: 'user_change_password',
        );
        await verifyService.resendNotification(resendNotification);
        // Handle successful resend
      },
    );
  }
}
