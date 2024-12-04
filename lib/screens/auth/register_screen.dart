import 'package:flutter/material.dart';
import '../../widgets/labeled_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/labeled_dropdown.dart';
import '../../models/contact.dart';
import '../../services/contact_service.dart';
import '../../utils/validators.dart';

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
  bool isLoading = false;

  final Map<String, String> hobbyTranslations = {
    'Chef': 'Chef',
    'Comercio de Mercancías': 'Merchandise Trade',
    'Artesano': 'Craftsman',
    'Voluntariado Comunitario': 'Community Volunteering',
    'Promoción de Arte y Cultura': 'Arts and Culture Promotion',
    'Educador Comunitario': 'Community Educator',
    'Salud y Bienestar': 'Health and Wellness',
    'Ninguno': 'None',
  };

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
      setState(() {
        isLoading = true;
      });

      final contact = Contact(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phone: '$countryCode${phoneController.text.trim()}',
        hobby: hobbyTranslations[selectedHobby] ?? 'None',
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
                          'Registrarse',
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
                        label: 'Nombre:',
                        controller: firstNameController,
                        validator: (value) =>
                            Validators.validateTextWithAccents(
                                value, 'Nombre', 3, 30),
                      ),
                      const SizedBox(height: 16),
                      LabeledTextField(
                        label: 'Apellido:',
                        controller: lastNameController,
                        validator: (value) =>
                            Validators.validateTextWithAccents(
                                value, 'Apellido', 3, 30),
                      ),
                      const SizedBox(height: 16),
                      LabeledTextField(
                        label: 'Correo Electrónico:',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail,
                      ),
                      const SizedBox(height: 16),
                      LabeledTextField(
                        label: 'Teléfono:',
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        prefixText: '$countryCode ',
                        validator: (value) =>
                            Validators.validatePhoneNumber(value, 'Teléfono'),
                      ),
                      const SizedBox(height: 16),
                      LabeledDropdown(
                        label: 'Pasatiempo:',
                        value: selectedHobby,
                        items: hobbyTranslations.keys.toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedHobby = value;
                          });
                        },
                        validator: (value) =>
                            Validators.validateRequired(value, 'Pasatiempo'),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Registrarse',
                        backgroundColor: const Color(0xFF324A5F),
                        onPressed: _register,
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: 'Cancelar',
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
