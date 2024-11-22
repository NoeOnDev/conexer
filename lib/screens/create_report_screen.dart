import 'package:flutter/material.dart';
import '../widgets/citizen_scaffold.dart';
import '../widgets/labeled_text_field.dart';
import '../widgets/custom_button.dart';

class CreateReportScreen extends StatefulWidget {
  const CreateReportScreen({super.key});

  @override
  CreateReportScreenState createState() => CreateReportScreenState();
}

class CreateReportScreenState extends State<CreateReportScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  final municipalityController = TextEditingController();
  final streetController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    categoryController.dispose();
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

  void _captureLocation() {
    // Handle location capture logic
  }

  @override
  Widget build(BuildContext context) {
    return CitizenScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Create Report',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              color: const Color(0xFF324A5F),
              child: SafeArea(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF324A5F),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabeledTextField(
                            label: 'Title:',
                            controller: titleController,
                            labelColor: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          LabeledTextField(
                            label: 'Category:',
                            controller: categoryController,
                            labelColor: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          LabeledTextField(
                            label: 'Description:',
                            controller: descriptionController,
                            maxLines: 5,
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
                          const SizedBox(height: 20),
                          CustomButton(
                            text: 'Create Report',
                            backgroundColor: const Color(0x8077A1DD),
                            onPressed: _createReport,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
