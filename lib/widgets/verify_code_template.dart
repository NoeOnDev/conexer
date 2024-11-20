import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class VerifyCodeTemplate extends StatefulWidget {
  final String title;
  final String message;
  final Future<void> Function(String code) onConfirmCode;
  final Future<void> Function() onResendCode;

  const VerifyCodeTemplate({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirmCode,
    required this.onResendCode,
  });

  @override
  VerifyCodeTemplateState createState() => VerifyCodeTemplateState();
}

class VerifyCodeTemplateState extends State<VerifyCodeTemplate> {
  final formKey = GlobalKey<FormState>();
  final codeControllers = List.generate(5, (_) => TextEditingController());
  final focusNodes = List.generate(5, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in codeControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 4) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      }
    } else {
      if (index > 0) {
        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
      }
    }
  }

  void _confirmCode() async {
    if (formKey.currentState!.validate()) {
      final code = codeControllers.map((controller) => controller.text).join();
      try {
        await widget.onConfirmCode(code);
        // Handle successful confirmation
      } catch (e) {
        // Handle error
      }
    }
  }

  void _resendCode() async {
    try {
      await widget.onResendCode();
      // Handle successful resend
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0x8077A1DD),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Image.asset(
                          'assets/img/img_verify_code.png',
                          width: 250,
                          height: 200,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Enter the 5-digit code:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(5, (index) {
                          return SizedBox(
                            width: 50,
                            child: TextFormField(
                              controller: codeControllers[index],
                              focusNode: focusNodes[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              onChanged: (value) => _onChanged(value, index),
                              decoration: InputDecoration(
                                counterText: '',
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.deepPurple),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Resend Code',
                        backgroundColor: const Color(0xFF6A6A6A),
                        onPressed: _resendCode,
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: 'Confirm Code',
                        backgroundColor: const Color(0xFF324A5F),
                        onPressed: _confirmCode,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
