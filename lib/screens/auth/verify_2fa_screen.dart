import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/verify_code_template.dart';
import '../../services/verify_service.dart';

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
        final role = response['role'];
        // Handle successful verification
        if (context.mounted) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token_user_verification', jwtToken);
          await prefs.setString('user_role', role);
          if (context.mounted) {
            if (role == 'Citizen') {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (Route<dynamic> route) => false,
              );
            } else if (role == 'Representative') {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home-representative',
                (Route<dynamic> route) => false,
              );
            }
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
