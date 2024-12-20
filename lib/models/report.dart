class Report {
  final String title;
  final String category;
  final String description;
  final String locality;
  final String street;
  final String createdAt;

  Report({
    required this.title,
    required this.category,
    required this.description,
    required this.locality,
    required this.street,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'description': description,
      'locality': locality,
      'street': street,
      'createdAt': createdAt,
    };
  }
}
