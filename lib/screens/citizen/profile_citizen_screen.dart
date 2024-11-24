import 'package:flutter/material.dart';
import '../../widgets/form_template.dart';
import '../../widgets/labeled_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/labeled_dropdown.dart';
import '../../services/user_service.dart';
import '../../services/contact_service.dart';
import '../../models/update_contact.dart';

class ProfileCitizenScreen extends StatefulWidget {
  final String token;
  final UserService userService;
  final ContactService contactService;

  const ProfileCitizenScreen({
    super.key,
    required this.token,
    required this.userService,
    required this.contactService,
  });

  @override
  ProfileCitizenScreenState createState() => ProfileCitizenScreenState();
}

class ProfileCitizenScreenState extends State<ProfileCitizenScreen> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  String? selectedHobby;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      final userInfo = await widget.userService.getUserInfo(widget.token);
      setState(() {
        firstNameController.text = userInfo['contact']['firstName'];
        lastNameController.text = userInfo['contact']['lastName'];
        phoneController.text = userInfo['contact']['phone'];
        usernameController.text = userInfo['username'];
        emailController.text = userInfo['contact']['email'];
        selectedHobby = userInfo['contact']['hobby']['value'];
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _saveChanges() async {
    if (formKey.currentState!.validate()) {
      final contact = UpdateContact(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        hobby: selectedHobby ?? 'None',
      );

      try {
        await widget.contactService.updateContact(widget.token, contact);
        // Handle successful update
      } catch (e) {
        // Handle update error
      }
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FormTemplate(
      title: 'Profile',
      scaffoldType: ScaffoldType.citizen,
      formKey: formKey,
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
          enabled: false,
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
          enabled: false,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Email:',
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          labelColor: Colors.white,
          enabled: false,
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