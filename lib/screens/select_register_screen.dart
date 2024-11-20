import 'package:flutter/material.dart';
import '../widgets/link_text.dart';

class SelectRegisterScreen extends StatelessWidget {
  const SelectRegisterScreen({super.key});

  void _navigateToRegister(
      BuildContext context, String role, String imagePath) {
    Navigator.pushNamed(
      context,
      '/register',
      arguments: {'role': role, 'imagePath': imagePath},
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/');
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Select Registration Type',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Image.asset(
                      'assets/img/img_select_register.png',
                      width: 250,
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => _navigateToRegister(context, 'Citizen',
                            'assets/img/img_register_role_citizen.png'),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/img/img_citizen.png',
                                    width: 120,
                                    height: 120,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Citizen',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _navigateToRegister(
                            context,
                            'Representative',
                            'assets/img/img_register_role_representative.png'),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/img/img_representative.png',
                                    width: 120,
                                    height: 120,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Ejidatario',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  LinkText(
                    text: 'Already have an account?',
                    onTap: () => _navigateToLogin(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
