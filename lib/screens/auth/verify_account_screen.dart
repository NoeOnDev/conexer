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
      title: 'Verifique su Cuenta',
      message: 'Se ha enviado un código de 5 dígitos a su número de WhatsApp.',
      onConfirmCode: (code) async {
        await verifyService.validateToken(token, code);
        if (context.mounted) {
          Navigator.pushNamed(context, '/');
        }
      },
      onResendCode: () async {
        await verifyService.resendNotification(token);
      },
    );
  }
}
