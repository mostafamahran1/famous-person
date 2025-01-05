import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = '2dfe23358236069710a379edd4c65a6b';

  Future<List<dynamic>> getPopularPersons() async {
    final response = await http.get(Uri.parse('$baseUrl/person/popular?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load popular persons');
    }
  }

  Future<Map<String, dynamic>> getPersonDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/person/$id?api_key=$apiKey'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load person details');
    }
  }

  Future<List<dynamic>> getPersonImages(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/person/$id/images?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['profiles'];
    } else {
      throw Exception('Failed to load person images');
    }
  }
}
