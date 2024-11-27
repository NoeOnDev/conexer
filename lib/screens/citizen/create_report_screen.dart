import 'package:flutter/material.dart';
import '../../widgets/form_template.dart';
import '../../widgets/labeled_text_field.dart';
import '../../widgets/labeled_dropdown.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/location_input.dart';
import '../../models/report.dart';
import '../../services/report_service.dart';

class CreateReportScreen extends StatefulWidget {
  final String token;
  final ReportService reportService;

  const CreateReportScreen({
    super.key,
    required this.token,
    required this.reportService,
  });

  @override
  CreateReportScreenState createState() => CreateReportScreenState();
}

class CreateReportScreenState extends State<CreateReportScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final localityController = TextEditingController();
  final streetController = TextEditingController();
  String? selectedCategory;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    localityController.dispose();
    streetController.dispose();
    super.dispose();
  }

  void _createReport() async {
    if (formKey.currentState!.validate()) {
      final now = DateTime.now().toIso8601String();
      final report = Report(
        title: titleController.text,
        category: selectedCategory!,
        description: descriptionController.text,
        locality: localityController.text,
        street: streetController.text,
        createdAt: now,
      );

      try {
        await widget.reportService.createReport(widget.token, report);
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/report-history');
      } catch (e) {
        // Handle error
      }
    }
  }

  void _cancel() {
    Navigator.pop(context);
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Title is required';
            }
            if (value.length < 5 || value.length > 30) {
              return 'Title must be between 5 and 30 characters';
            }
            if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
              return 'Title can only contain letters and numbers';
            }
            return null;
          },
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Category is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Description:',
          controller: descriptionController,
          maxLines: 8,
          labelColor: Colors.white,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Description is required';
            }
            if (value.length < 10 || value.length > 200) {
              return 'Description must be between 10 and 200 characters';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        LocationInput(
          localityController: localityController,
          streetController: streetController,
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
