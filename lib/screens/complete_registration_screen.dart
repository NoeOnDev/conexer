import 'package:flutter/material.dart';
import '../widgets/labeled_text_field.dart';
import '../widgets/custom_button.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class CompleteRegistrationScreen extends StatefulWidget {
  final String contactId;
  final String role;
  final UserService userService;

  const CompleteRegistrationScreen({
    super.key,
    required this.contactId,
    required this.role,
    required this.userService,
  });

  @override
  CompleteRegistrationScreenState createState() =>
      CompleteRegistrationScreenState();
}

class CompleteRegistrationScreenState
    extends State<CompleteRegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _completeRegistration() async {
    if (formKey.currentState!.validate()) {
      final user = User(
        contactId: widget.contactId,
        username: usernameController.text,
        password: passwordController.text,
        role: widget.role,
      );

      try {
        final token = await widget.userService.registerUser(user);
        if (!mounted) return;
        Navigator.pushNamed(
          context,
          '/verify-account',
          arguments: {'token': token},
        );
      } catch (e) {
        // Handle registration error
      }
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Complete Registration',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Image.asset(
                          'assets/img/img_register_user.png',
                          width: 250,
                          height: 200,
                        ),
                      ),
                      const SizedBox(height: 16),
                      LabeledTextField(
                        label: 'Username:',
                        controller: usernameController,
                      ),
                      const SizedBox(height: 16),
                      LabeledTextField(
                        label: 'Password:',
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Complete Registration',
                        backgroundColor: const Color(0xFF324A5F),
                        onPressed: _completeRegistration,
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: 'Cancel',
                        backgroundColor: const Color(0xFFC1121F),
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
