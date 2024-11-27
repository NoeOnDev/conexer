import 'package:flutter/material.dart';
import '../../widgets/labeled_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/labeled_dropdown.dart';
import '../../models/contact.dart';
import '../../services/contact_service.dart';

class RegisterScreen extends StatefulWidget {
  final ContactService contactService;
  final String role;
  final String imagePath;

  const RegisterScreen({
    super.key,
    required this.contactService,
    required this.role,
    required this.imagePath,
  });

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  String? selectedHobby;
  String countryCode = '+52';

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
        phone: '$countryCode${phoneController.text}',
        hobby: selectedHobby ?? 'None',
      );

      try {
        final contactId = await widget.contactService.registerContact(contact);
        if (!mounted) return;
        Navigator.pushNamed(
          context,
          '/complete-registration',
          arguments: {
            'contactId': contactId,
            'role': widget.role,
          },
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
                          widget.imagePath,
                          width: 250,
                          height: 200,
                        ),
                      ),
                      const SizedBox(height: 16),
                      LabeledTextField(
                        label: 'First Name:',
                        controller: firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'First name is required';
                          }
                          if (!RegExp(
                                  r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ]+(?: [a-zA-ZáéíóúÁÉÍÓÚñÑ]+)*$')
                              .hasMatch(value)) {
                            return 'Enter a valid first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      LabeledTextField(
                        label: 'Last Name:',
                        controller: lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Last name is required';
                          }
                          if (!RegExp(
                                  r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ]+(?: [a-zA-ZáéíóúÁÉÍÓÚñÑ]+)*$')
                              .hasMatch(value)) {
                            return 'Enter a valid last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      LabeledTextField(
                        label: 'Email:',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      LabeledTextField(
                        label: 'Phone:',
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        prefixText: '$countryCode ',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required';
                          }
                          if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Enter a valid 10-digit phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      LabeledDropdown(
                        label: 'Hobby:',
                        value: selectedHobby,
                        items: const [
                          'Chef',
                          'Merchandise Trade',
                          'Craftsman',
                          'Community Volunteering',
                          'Arts and Culture Promotion',
                          'Community Educator',
                          'Health and Wellness',
                          'None',
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedHobby = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Hobby is required';
                          }
                          return null;
                        },
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
      ),
    );
  }
}
