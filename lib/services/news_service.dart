import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news.dart';
import '../models/news_response.dart';
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

  Future<List<NewsResponse>> getUserNews(String token) async {
    final url = Uri.parse('$baseUrl/api/v1/cases/news/user');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => NewsResponse.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('error')) {
        throw Exception(responseData['error']);
      } else {
        throw Exception('Failed to load user news');
      }
    } else {
      throw Exception('Failed to load user news');
    }
  }

  Future<List<NewsResponse>> getLocalityNews(String token) async {
    final url = Uri.parse('$baseUrl/api/v1/cases/news/locality');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => NewsResponse.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('error')) {
        throw Exception(responseData['error']);
      } else {
        throw Exception('Failed to load locality news');
      }
    } else {
      throw Exception('Failed to load locality news');
    }
  }
}
