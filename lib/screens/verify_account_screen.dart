import 'package:flutter/material.dart';
import '../widgets/verify_code_template.dart';
import '../services/verify_service.dart';
import '../models/verify.dart';

class VerifyAccountScreen extends StatelessWidget {
  final String userId;
  final VerifyService verifyService;

  const VerifyAccountScreen({
    super.key,
    required this.userId,
    required this.verifyService,
  });

  @override
  Widget build(BuildContext context) {
    return VerifyCodeTemplate(
      title: 'Verify Your Account',
      message: 'A 5-digit code has been sent to your WhatsApp number.',
      onConfirmCode: (code) async {
        final verify = Verify(userId: userId, code: code);
        await verifyService.validateToken(verify);
        // Handle successful verification
      },
    );
  }
}
