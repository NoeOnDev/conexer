class Appointment {
  final String title;
  final String description;
  final String dateTime;

  Appointment({
    required this.title,
    required this.description,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'dateTime': dateTime,
    };
  }
}
