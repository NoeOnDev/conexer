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
  bool isLoading = false;

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
      if (localityController.text.isEmpty || streetController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Locality and Street are required. Please use the "Get Location" button to fill them.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        isLoading = true;
      });

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
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
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
            if (value.length < 5 || value.length > 40) {
              return 'Title must be between 5 and 40 characters';
            }
            if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ0-9\s]+$').hasMatch(value)) {
              return 'Title can only contain letters, numbers, and spaces';
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
            if (value.length < 10 || value.length > 300) {
              return 'Description must be between 10 and 300 characters';
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
          enabled: !isLoading,
        ),
        const SizedBox(height: 10),
        CustomButton(
          text: 'Cancel',
          backgroundColor: const Color(0xFFC1121F),
          onPressed: _cancel,
          enabled: !isLoading,
        ),
      ],
    );
  }
}
