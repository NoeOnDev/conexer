class AppointmentResponse {
  final String id;
  final String title;
  final String userName;
  final String userId;
  final String description;
  final String dateTime;
  final String locality;
  final String status;

  AppointmentResponse({
    required this.id,
    required this.title,
    required this.userName,
    required this.userId,
    required this.description,
    required this.dateTime,
    required this.locality,
    required this.status,
  });

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentResponse(
      id: json['id']['value'],
      title: json['title'],
      userName: json['userName'],
      userId: json['userId']['value'],
      description: json['description'],
      dateTime: json['dateTime'],
      locality: json['locality'],
      status: json['status']['value'],
    );
  }
}
