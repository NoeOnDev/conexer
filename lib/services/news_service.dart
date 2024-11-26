import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news.dart';
import 'base_service.dart';

class NewsService extends BaseService {
  NewsService({required super.baseUrl});

  Future<void> createNews(String token, News news) async {
    final url = Uri.parse('$baseUrl/api/v1/cases/news');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(news.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create news');
    }
  }
}
