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
  final localityController = TextEditingController();
  final streetController = TextEditingController();
  String? selectedHobby;

  final Map<String, String> hobbyTranslations = {
    'Chef': 'Chef',
    'Merchandise Trade': 'Comercio de Mercancías',
    'Craftsman': 'Artesano',
    'Community Volunteering': 'Voluntariado Comunitario',
    'Arts and Culture Promotion': 'Promoción de Arte y Cultura',
    'Community Educator': 'Educador Comunitario',
    'Health and Wellness': 'Salud y Bienestar',
    'None': 'Ninguno',
  };

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
        localityController.text = userInfo['address']['locality'];
        streetController.text = userInfo['address']['street'];
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
    localityController.dispose();
    streetController.dispose();
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
      title: 'Perfil',
      scaffoldType: ScaffoldType.citizen,
      formKey: formKey,
      fields: [
        LabeledTextField(
          label: 'Nombre:',
          controller: firstNameController,
          labelColor: Colors.white,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Apellido:',
          controller: lastNameController,
          labelColor: Colors.white,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Teléfono:',
          keyboardType: TextInputType.phone,
          controller: phoneController,
          labelColor: Colors.white,
          enabled: false,
        ),
        const SizedBox(height: 16),
        LabeledDropdown(
          label: 'Pasatiempo:',
          value: hobbyTranslations[selectedHobby],
          items: hobbyTranslations.values.toList(),
          onChanged: (value) {
            setState(() {
              selectedHobby = hobbyTranslations.keys.firstWhere(
                (key) => hobbyTranslations[key] == value,
                orElse: () => 'None',
              );
            });
          },
          labelColor: Colors.white,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Nombre de Usuario:',
          controller: usernameController,
          labelColor: Colors.white,
          enabled: false,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Correo Electrónico:',
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          labelColor: Colors.white,
          enabled: false,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Localidad:',
          controller: localityController,
          labelColor: Colors.white,
          enabled: false,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Calle:',
          controller: streetController,
          labelColor: Colors.white,
          enabled: false,
        )
      ],
      buttons: [
        CustomButton(
          text: 'Guardar Cambios',
          backgroundColor: const Color(0x8077A1DD),
          onPressed: _saveChanges,
        ),
        const SizedBox(height: 10),
        CustomButton(
          text: 'Cancelar',
          backgroundColor: const Color(0xFFC1121F),
          onPressed: _cancel,
        ),
      ],
    );
  }
}
