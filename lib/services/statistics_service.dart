import 'dart:convert';
import 'package:http/http.dart' as http;

class StatisticsService {
  final String url = 'http://98.82.41.126:5000/predict';

  Future<Map<String, dynamic>> getPredictions() async {
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load predictions');
    }
  }
}