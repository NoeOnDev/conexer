import 'package:flutter/material.dart';
import '../widgets/labeled_text_field.dart';
import '../widgets/custom_button.dart';
import '../models/contact.dart';
import '../services/contact_service.dart';

class RegisterScreen extends StatefulWidget {
  final ContactService contactService;
  final String role;

  const RegisterScreen(
      {super.key, required this.contactService, required this.role});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _register() async {
    if (formKey.currentState!.validate()) {
      final contact = Contact(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phone: phoneController.text,
      );

      try {
        final contactId = await widget.contactService.registerContact(contact);
        if (!mounted) return;
        Navigator.pushNamed(
          context,
          '/complete-registration',
          arguments: {'contactId': contactId},
        );
      } catch (e) {
        // Handle registration error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                        'Register',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Image.asset(
                        'assets/img/img_register_contact.png',
                        width: 250,
                        height: 200,
                      ),
                    ),
                    const SizedBox(height: 16),
                    LabeledTextField(
                      label: 'First Name:',
                      controller: firstNameController,
                    ),
                    const SizedBox(height: 16),
                    LabeledTextField(
                      label: 'Last Name:',
                      controller: lastNameController,
                    ),
                    const SizedBox(height: 16),
                    LabeledTextField(
                      label: 'Email:',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    const SizedBox(height: 16),
                    LabeledTextField(
                      label: 'Phone:',
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'Register',
                      backgroundColor: const Color(0xFF324A5F),
                      onPressed: _register,
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
    );
  }
}
