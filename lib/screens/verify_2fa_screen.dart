import 'package:flutter/material.dart';
import '../widgets/verify_code_template.dart';
import '../services/verify_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Verify2FAScreen extends StatelessWidget {
  final String token;
  final VerifyService verifyService;

  const Verify2FAScreen({
    super.key,
    required this.token,
    required this.verifyService,
  });

  @override
  Widget build(BuildContext context) {
    return VerifyCodeTemplate(
      title: 'Verify Your Login',
      message: 'A 5-digit code has been sent to your WhatsApp number.',
      onConfirmCode: (code) async {
        final response = await verifyService.validateToken(token, code);
        final jwtToken = response['jwtToken'];
        // Handle successful verification
        if (context.mounted) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('jwtToken', jwtToken);
          if (context.mounted) {
            Navigator.pushNamed(context, '/home');
          }
        }
      },
      onResendCode: () async {
        await verifyService.resendNotification(token);
        // Handle successful resend
      },
    );
  }
}