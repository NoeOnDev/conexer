import 'package:flutter/material.dart';
import '../../widgets/labeled_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/location_input.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';
import '../../utils/validators.dart';

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
                'Localidad y Calle son requeridas. Por favor use el botón "Obtener Ubicación" para llenarlos.'),
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
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
        role: widget.role,
        locality: localityController.text.trim(),
        street: streetController.text.trim(),
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
                          'Completar Registro',
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
                        label: 'Nombre de Usuario:',
                        controller: usernameController,
                        validator: Validators.validateUsername,
                      ),
                      const SizedBox(height: 16),
                      LabeledTextField(
                        label: 'Contraseña:',
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        obscureText: true,
                        validator: Validators.validatePassword,
                      ),
                      const SizedBox(height: 20),
                      LocationInput(
                        localityController: localityController,
                        streetController: streetController,
                        labelColor: Colors.black,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'Completar Registro',
                        backgroundColor: const Color(0xFF324A5F),
                        onPressed: _completeRegistration,
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
