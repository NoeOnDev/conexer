import 'package:flutter/material.dart';
import '../../widgets/form_template.dart';
import '../../widgets/labeled_text_field.dart';
import '../../widgets/custom_button.dart';

class ScheduleAppointmentScreen extends StatefulWidget {
  const ScheduleAppointmentScreen({super.key});

  @override
  ScheduleAppointmentScreenState createState() =>
      ScheduleAppointmentScreenState();
}

class ScheduleAppointmentScreenState extends State<ScheduleAppointmentScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  void _scheduleAppointment() {
    if (formKey.currentState!.validate()) {
      // Handle appointment scheduling logic
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FormTemplate(
      title: 'Schedule Appointment',
      scaffoldType: ScaffoldType.citizen,
      formKey: formKey,
      fields: [
        LabeledTextField(
          label: 'Title:',
          controller: titleController,
          labelColor: Colors.white,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Description:',
          controller: descriptionController,
          maxLines: 8,
          labelColor: Colors.white,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Date:',
          controller: dateController,
          labelColor: Colors.white,
          keyboardType: TextInputType.datetime,
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Time:',
          controller: timeController,
          labelColor: Colors.white,
          keyboardType: TextInputType.datetime,
        ),
      ],
      buttons: [
        CustomButton(
          text: 'Schedule Appointment',
          backgroundColor: const Color(0x8077A1DD),
          onPressed: _scheduleAppointment,
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
