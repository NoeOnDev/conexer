import 'package:flutter/material.dart';
import 'base_card.dart';

class ReportCard extends StatelessWidget {
  final String title;
  final String category;
  final String description;
  final String date;
  final String status;
  final String locality;
  final String street;
  final Widget image;
  final VoidCallback? onResolved;
  final VoidCallback? onUnresolved;

  ReportCard({
    super.key,
    required this.title,
    required this.category,
    required this.description,
    required this.date,
    required this.status,
    required this.locality,
    required this.street,
    required this.image,
    this.onResolved,
    this.onUnresolved,
  });

  final Map<String, String> categoryTranslations = {
    'Light': 'Luz',
    'Water': 'Agua',
    'Infrastructure': 'Infraestructura',
    'Trash': 'Basura',
  };

  Color _getBackgroundColor() {
    switch (status) {
      case 'RESOLVED':
        return Colors.green.withOpacity(0.2);
      case 'UNRESOLVED':
        return Colors.red.withOpacity(0.2);
      default:
        return const Color(0xFF324A5F);
    }
  }

  Color _getTextColor() {
    switch (status) {
      case 'RESOLVED':
      case 'UNRESOLVED':
        return Colors.black;
      default:
        return Colors.white;
    }
  }

  String _translateStatus(String status) {
    switch (status) {
      case 'RESOLVED':
        return 'Resuelto';
      case 'UNRESOLVED':
        return 'No Resuelto';
      case 'PENDING':
        return 'Pendiente';
      default:
        return status;
    }
  }

  String _translateCategory(String category) {
    return categoryTranslations[category] ?? category;
  }

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      title: title,
      subtitle: 'Categoría: ${_translateCategory(category)}',
      description: description,
      date: date,
      image: image,
      status: _translateStatus(status),
      backgroundColor: _getBackgroundColor(),
      textColor: _getTextColor(),
      onPrimaryAction: status == 'PENDING' ? onResolved : null,
      onSecondaryAction: status == 'PENDING' ? onUnresolved : null,
      primaryActionText: 'Resuelto',
      secondaryActionText: 'No Resuelto',
      additionalInfo: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_on, color: _getTextColor()),
          const SizedBox(width: 4),
          Text(
            '$locality, $street',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _getTextColor(),
            ),
          ),
        ],
      ),
    );
  }
}
