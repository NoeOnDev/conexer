class NewsResponse {
  final String id;
  final String title;
  final String description;
  final String locality;
  final String userId;
  final String createdAt;

  NewsResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.locality,
    required this.userId,
    required this.createdAt,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      id: json['id']['value'],
      title: json['title'],
      description: json['description'],
      locality: json['locality'],
      userId: json['userId']['value'],
      createdAt: json['createdAt'],
    );
  }
}
