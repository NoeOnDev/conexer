import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets/form_template.dart';
import '../../widgets/labeled_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../models/appointment.dart';
import '../../services/appointment_service.dart';

class ScheduleAppointmentScreen extends StatefulWidget {
  final String token;
  final AppointmentService appointmentService;

  const ScheduleAppointmentScreen({
    super.key,
    required this.token,
    required this.appointmentService,
  });

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dateController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = TimeOfDay.now();
      if (picked.hour < now.hour ||
          (picked.hour == now.hour && picked.minute < now.minute)) {
      } else {
        final dateTime = _convertTimeOfDayToDateTime(picked);
        setState(() {
          timeController.text = DateFormat('HH:mm').format(dateTime);
        });
      }
    }
  }

  DateTime _convertTimeOfDayToDateTime(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  void _scheduleAppointment() async {
    if (formKey.currentState!.validate()) {
      final selectedDate = DateTime.parse(dateController.text);
      final selectedTime = TimeOfDay(
        hour: int.parse(timeController.text.split(':')[0]),
        minute: int.parse(timeController.text.split(':')[1]),
      );
      final now = DateTime.now();

      if (selectedDate.isBefore(now) ||
          (selectedDate.isAtSameMomentAs(now) &&
              (selectedTime.hour < now.hour ||
                  (selectedTime.hour == now.hour &&
                      selectedTime.minute < now.minute)))) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Please select a date and time later than the current date and time.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final dateTime = '${dateController.text}T${timeController.text}:00Z';

      final appointment = Appointment(
        title: titleController.text,
        description: descriptionController.text,
        dateTime: dateTime,
      );

      try {
        await widget.appointmentService.scheduleAppointment(
          widget.token,
          appointment,
        );
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/appointments');
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
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: LabeledTextField(
              label: 'Date:',
              controller: dateController,
              labelColor: Colors.white,
              keyboardType: TextInputType.datetime,
              prefixIcon: const Icon(Icons.calendar_today),
            ),
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => _selectTime(context),
          child: AbsorbPointer(
            child: LabeledTextField(
              label: 'Time:',
              controller: timeController,
              labelColor: Colors.white,
              keyboardType: TextInputType.datetime,
              prefixIcon: const Icon(Icons.access_time),
            ),
          ),
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
