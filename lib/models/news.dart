class News {
  final String title;
  final String description;
  final String createdAt;

  News({
    required this.title,
    required this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'createdAt': createdAt,
    };
  }
}
