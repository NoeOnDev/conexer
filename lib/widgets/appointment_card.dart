import 'package:flutter/material.dart';
import 'base_card.dart';

class AppointmentCard extends StatelessWidget {
  final String title;
  final String userName;
  final String description;
  final String dateTime;
  final String status;
  final Widget image;
  final VoidCallback? onAccepted;
  final VoidCallback? onRejected;

  const AppointmentCard({
    super.key,
    required this.title,
    required this.userName,
    required this.description,
    required this.dateTime,
    required this.status,
    required this.image,
    this.onAccepted,
    this.onRejected,
  });

  Color _getBackgroundColor() {
    switch (status) {
      case 'ACCEPTED':
        return Colors.green.withOpacity(0.2);
      case 'REJECTED':
        return Colors.red.withOpacity(0.2);
      default:
        return const Color(0xFF324A5F);
    }
  }

  Color _getTextColor() {
    switch (status) {
      case 'ACCEPTED':
      case 'REJECTED':
        return Colors.black;
      default:
        return Colors.white;
    }
  }

  String _translateStatus(String status) {
    switch (status) {
      case 'ACCEPTED':
        return 'Aceptado';
      case 'REJECTED':
        return 'Rechazado';
      case 'PENDING':
        return 'Pendiente';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      title: title,
      subtitle: 'Ciudadano: $userName',
      description: description,
      date: dateTime,
      image: image,
      status: _translateStatus(status),
      backgroundColor: _getBackgroundColor(),
      textColor: _getTextColor(),
      onPrimaryAction: status == 'PENDING' ? onAccepted : null,
      onSecondaryAction: status == 'PENDING' ? onRejected : null,
      primaryActionText: 'Aceptar',
      secondaryActionText: 'Rechazar',
    );
  }
}
