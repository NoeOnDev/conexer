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
        timeController.clear();
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    if (dateController.text.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a date first.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final DateTime selectedDate = DateTime.parse(dateController.text);
    final DateTime now = DateTime.now();
    final TimeOfDay initialTime = TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null) {
      final DateTime pickedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        picked.hour,
        picked.minute,
      );

      if (selectedDate
          .isAtSameMomentAs(DateTime(now.year, now.month, now.day))) {
        final DateTime minAllowedTime = now.add(const Duration(hours: 2));
        if (pickedDateTime.isBefore(minAllowedTime)) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select a time at least 2 hours from now.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
      }

      setState(() {
        timeController.text = DateFormat('HH:mm').format(pickedDateTime);
      });
    }
  }

  DateTime _combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  void _scheduleAppointment() async {
    if (formKey.currentState!.validate()) {
      final selectedDate = DateTime.parse(dateController.text);
      final selectedTime = TimeOfDay(
        hour: int.parse(timeController.text.split(':')[0]),
        minute: int.parse(timeController.text.split(':')[1]),
      );
      final now = DateTime.now();
      final selectedDateTime = _combineDateAndTime(selectedDate, selectedTime);

      if (selectedDateTime.isBefore(now.add(const Duration(hours: 2)))) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Please select a date and time at least 2 hours from now.'),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Date is required';
                }
                return null;
              },
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Time is required';
                }
                if (dateController.text.isNotEmpty) {
                  final selectedDate = DateTime.parse(dateController.text);
                  final now = DateTime.now();
                  final selectedTime = TimeOfDay(
                    hour: int.parse(value.split(':')[0]),
                    minute: int.parse(value.split(':')[1]),
                  );
                  final selectedDateTime = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );
                  if (selectedDate.isAtSameMomentAs(
                      DateTime(now.year, now.month, now.day))) {
                    final minAllowedTime = now.add(const Duration(hours: 2));
                    if (selectedDateTime.isBefore(minAllowedTime)) {
                      return 'Please select a time at least 2 hours from now.';
                    }
                  }
                }
                return null;
              },
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
