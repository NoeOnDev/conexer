import 'package:flutter/material.dart';
import '../../widgets/labeled_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/location_input.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';

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
  final localityController = TextEditingController();
  final streetController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    localityController.dispose();
    streetController.dispose();
    super.dispose();
  }

  void _completeRegistration() async {
    if (formKey.currentState!.validate()) {
      if (localityController.text.isEmpty || streetController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Locality and Street are required. Please use the "Get Location" button to fill them.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        isLoading = true;
      });

      final user = User(
        contactId: widget.contactId,
        username: usernameController.text,
        password: passwordController.text,
        role: widget.role,
        locality: localityController.text,
        street: streetController.text,
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
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username is required';
                          }
                          if (value.length < 3 || value.length > 30) {
                            return 'Username must be between 3 and 30 characters';
                          }
                          if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                            return 'Username can only contain letters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      LabeledTextField(
                        label: 'Password:',
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$')
                              .hasMatch(value)) {
                            return 'Password must contain at least one uppercase letter, one lowercase letter, and one number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      LocationInput(
                        localityController: localityController,
                        streetController: streetController,
                        labelColor: Colors.black,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Complete Registration',
                        backgroundColor: const Color(0xFF324A5F),
                        onPressed: _completeRegistration,
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: 'Cancel',
                        backgroundColor: const Color(0xFFC1121F),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        enabled: !isLoading,
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
