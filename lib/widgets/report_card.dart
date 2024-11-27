import 'package:flutter/material.dart';
import 'base_card.dart';

class ReportCard extends StatelessWidget {
  final String title;
  final String category;
  final String description;
  final String date;
  final String status;
  final Widget image;
  final VoidCallback? onResolved;
  final VoidCallback? onUnresolved;

  const ReportCard({
    super.key,
    required this.title,
    required this.category,
    required this.description,
    required this.date,
    required this.status,
    required this.image,
    this.onResolved,
    this.onUnresolved,
  });

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

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      title: title,
      subtitle: 'Category: $category',
      description: description,
      date: date,
      image: image,
      status: status,
      backgroundColor: _getBackgroundColor(),
      textColor: _getTextColor(),
      onPrimaryAction: status == 'PENDING' ? onResolved : null,
      onSecondaryAction: status == 'PENDING' ? onUnresolved : null,
      primaryActionText: 'Resolved',
      secondaryActionText: 'Unresolved',
    );
  }
}
