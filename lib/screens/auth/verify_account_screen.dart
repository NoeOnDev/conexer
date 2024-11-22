import 'package:flutter/material.dart';
import '../../widgets/verify_code_template.dart';
import '../../services/verify_service.dart';

class VerifyAccountScreen extends StatelessWidget {
  final String token;
  final VerifyService verifyService;

  const VerifyAccountScreen({
    super.key,
    required this.token,
    required this.verifyService,
  });

  @override
  Widget build(BuildContext context) {
    return VerifyCodeTemplate(
      title: 'Verify Your Account',
      message: 'A 5-digit code has been sent to your WhatsApp number.',
      onConfirmCode: (code) async {
        await verifyService.validateToken(token, code);
        // Handle successful verification
        if (context.mounted) {
          Navigator.pushNamed(context, '/');
        }
      },
      onResendCode: () async {
        await verifyService.resendNotification(token);
        // Handle successful resend
      },
    );
  }
}
