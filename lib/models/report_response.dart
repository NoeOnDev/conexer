class ReportResponse {
  final String id;
  final String title;
  final String category;
  final String description;
  final String locality;
  final String street;
  final String status;
  final String createdAt;

  ReportResponse({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.locality,
    required this.street,
    required this.status,
    required this.createdAt,
  });

  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    return ReportResponse(
      id: json['id']['value'],
      title: json['title'],
      category: json['category']['value'],
      description: json['description'],
      locality: json['address']['locality'],
      street: json['address']['street'],
      status: json['status']['value'],
      createdAt: json['createdAt'],
    );
  }
}
