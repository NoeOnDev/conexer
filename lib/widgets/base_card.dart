import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'custom_button.dart';

class BaseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String date;
  final Widget image;
  final String? status;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;
  final String primaryActionText;
  final String secondaryActionText;
  final Widget? additionalInfo;

  const BaseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.date,
    required this.image,
    this.status,
    required this.backgroundColor,
    required this.textColor,
    this.onPrimaryAction,
    this.onSecondaryAction,
    this.primaryActionText = '',
    this.secondaryActionText = '',
    this.additionalInfo,
  });

  String _formatDate(String dateTime) {
    final DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }

  String _formatTime(String dateTime) {
    final DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('HH:mm:ss').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDescriptionModal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: image,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (additionalInfo != null)
                Center(
                  child: additionalInfo!,
                ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Fecha: ${_formatDate(date)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  Text(
                    'Hora: ${_formatTime(date)}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              if (status != null)
                Center(
                  child: Text(
                    'Estado: $status',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
              if (status == 'Pendiente' &&
                  onPrimaryAction != null &&
                  onSecondaryAction != null) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomButton(
                          text: primaryActionText,
                          textSize: 15,
                          backgroundColor: Colors.green,
                          onPressed: onPrimaryAction!,
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomButton(
                          text: secondaryActionText,
                          textSize: 15,
                          backgroundColor: Colors.red,
                          onPressed: onSecondaryAction!,
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showDescriptionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Descripción',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: CustomButton(
                  text: 'Cerrar',
                  backgroundColor: const Color(0xFF324A5F),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
