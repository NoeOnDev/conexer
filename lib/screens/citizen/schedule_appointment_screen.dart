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

  @override
  Widget build(BuildContext context) {
    return FormTemplate(
      title: 'Schedule Appointment',
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
      ],
    );
  }
}
