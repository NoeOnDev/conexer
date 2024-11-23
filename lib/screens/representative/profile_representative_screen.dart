import 'package:flutter/material.dart';
import '../../widgets/form_template.dart';
import '../../widgets/labeled_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/labeled_dropdown.dart';

class ProfileRepresentativeScreen extends StatefulWidget {
  const ProfileRepresentativeScreen({super.key});

  @override
  ProfileRepresentativeScreenState createState() =>
      ProfileRepresentativeScreenState();
}

class ProfileRepresentativeScreenState
    extends State<ProfileRepresentativeScreen> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  String? selectedHobby;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (formKey.currentState!.validate()) {
      // Handle save changes logic
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FormTemplate(
      title: 'Profile',
      scaffoldType: ScaffoldType.representative,
      fields: [
        LabeledTextField(
          label: 'First Name:',
          controller: firstNameController,
          labelColor: Colors.white,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Last Name:',
          controller: lastNameController,
          labelColor: Colors.white,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Phone:',
          keyboardType: TextInputType.phone,
          controller: phoneController,
          labelColor: Colors.white,
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
          labelColor: Colors.white,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Username:',
          controller: usernameController,
          labelColor: Colors.white,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Email:',
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          labelColor: Colors.white,
        ),
      ],
      buttons: [
        CustomButton(
          text: 'Save Changes',
          backgroundColor: const Color(0x8077A1DD),
          onPressed: _saveChanges,
        ),
        const SizedBox(height: 10),
        CustomButton(
          text: 'Cancel',
          backgroundColor: const Color(0xFFC1121F),
          onPressed: _cancel,
        ),
      ],
    );
  }
}
