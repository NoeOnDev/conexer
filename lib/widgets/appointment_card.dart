import 'package:flutter/material.dart';
import 'custom_button.dart';

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
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _getTextColor(),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Citizen: $userName',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _getTextColor(),
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
                        color: _getTextColor(),
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Date: $dateTime',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _getTextColor(),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Status: $status',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _getTextColor(),
                  ),
                ),
              ),
              if (status != 'ACCEPTED' &&
                  status != 'REJECTED' &&
                  onAccepted != null &&
                  onRejected != null) ...[
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomButton(
                          text: 'Accept',
                          textSize: 15,
                          backgroundColor: Colors.green,
                          onPressed: onAccepted!,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomButton(
                          text: 'Reject',
                          textSize: 15,
                          backgroundColor: Colors.red,
                          onPressed: onRejected!,
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
                'Description',
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
                  text: 'Close',
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
