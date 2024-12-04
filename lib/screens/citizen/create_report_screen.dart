import 'package:flutter/material.dart';
import '../../widgets/form_template.dart';
import '../../widgets/labeled_text_field.dart';
import '../../widgets/labeled_dropdown.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/location_input.dart';
import '../../models/report.dart';
import '../../services/report_service.dart';
import '../../utils/validators.dart';

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

  final Map<String, String> categoryTranslations = {
    'Luz': 'Light',
    'Agua': 'Water',
    'Infraestructura': 'Infrastructure',
    'Basura': 'Trash',
  };

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
                'Localidad y Calle son requeridas. Por favor use el botón "Obtener Ubicación" para llenarlos.'),
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
        category: categoryTranslations[selectedCategory] ?? 'None',
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
      title: 'Crear Reporte',
      scaffoldType: ScaffoldType.citizen,
      formKey: formKey,
      fields: [
        LabeledTextField(
          label: 'Título:',
          controller: titleController,
          labelColor: Colors.white,
          validator: (value) =>
              Validators.validateTextWithAccents(value, 'Título', 5, 40),
        ),
        const SizedBox(height: 16),
        LabeledDropdown(
          label: 'Categoría:',
          value: selectedCategory,
          items: categoryTranslations.keys.toList(),
          onChanged: (value) {
            setState(() {
              selectedCategory = value;
            });
          },
          labelColor: Colors.white,
          validator: (value) => Validators.validateRequired(value, 'Categoría'),
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Descripción:',
          controller: descriptionController,
          maxLines: 8,
          labelColor: Colors.white,
          validator: (value) =>
              Validators.validateDescription(value, 'Descripción', 10, 300),
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
          text: 'Crear Reporte',
          backgroundColor: const Color(0x8077A1DD),
          onPressed: _createReport,
          enabled: !isLoading,
        ),
        const SizedBox(height: 10),
        CustomButton(
          text: 'Cancelar',
          backgroundColor: const Color(0xFFC1121F),
          onPressed: _cancel,
          enabled: !isLoading,
        ),
      ],
    );
  }
}
