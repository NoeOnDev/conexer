import 'package:flutter/material.dart';
import '../../widgets/form_template.dart';
import '../../widgets/labeled_text_field.dart';
import '../../widgets/labeled_dropdown.dart';
import '../../widgets/custom_button.dart';

class CreateReportScreen extends StatefulWidget {
  const CreateReportScreen({super.key});

  @override
  CreateReportScreenState createState() => CreateReportScreenState();
}

class CreateReportScreenState extends State<CreateReportScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final municipalityController = TextEditingController();
  final streetController = TextEditingController();
  String? selectedCategory;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    municipalityController.dispose();
    streetController.dispose();
    super.dispose();
  }

  void _createReport() {
    if (formKey.currentState!.validate()) {
      // Handle report creation logic
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _captureLocation() {
    // Handle location capture logic
  }

  @override
  Widget build(BuildContext context) {
    return FormTemplate(
      title: 'Create Report',
      scaffoldType: ScaffoldType.citizen,
      formKey: formKey,
      fields: [
        LabeledTextField(
          label: 'Title:',
          controller: titleController,
          labelColor: Colors.white,
        ),
        const SizedBox(height: 16),
        LabeledDropdown(
          label: 'Category:',
          value: selectedCategory,
          items: const ['Light', 'Water', 'Infrastructure', 'Trash'],
          onChanged: (value) {
            setState(() {
              selectedCategory = value;
            });
          },
          labelColor: Colors.white,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Description:',
          controller: descriptionController,
          maxLines: 8,
          labelColor: Colors.white,
        ),
        const SizedBox(height: 20),
        CustomButton(
          text: 'Capture Location',
          backgroundColor: Colors.grey.shade300,
          onPressed: _captureLocation,
          textSize: 16.0,
          textColor: Colors.black,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Municipality or Colony:',
          controller: municipalityController,
          labelColor: Colors.white,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Street:',
          controller: streetController,
          labelColor: Colors.white,
        ),
      ],
      buttons: [
        CustomButton(
          text: 'Create Report',
          backgroundColor: const Color(0x8077A1DD),
          onPressed: _createReport,
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
