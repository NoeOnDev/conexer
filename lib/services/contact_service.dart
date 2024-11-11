import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/contact.dart';
import 'base_service.dart';

class ContactService extends BaseService {
  ContactService({required super.baseUrl});

  Future<String> registerContact(Contact contact) async {
    final url = Uri.parse('$baseUrl/api/v1/users/contacts');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(contact.toJson()),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      return responseData['id'];
    } else {
      throw Exception('Failed to register contact');
    }
  }
}