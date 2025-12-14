import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiClient {
  final http.Client client;

  ApiClient({required this.client});

  Future<http.Response> post(String path, Map<String, dynamic> body) async {
    try {
      final uri = Uri.parse('$baseUrl$path');
      final response = await client.post(
        uri, 
        body: json.encode(body), 
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      
      print('🌐 API Request: $uri');
      print('📤 Request Body: ${json.encode(body)}');
      print('📥 Response Status: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');
      
      return response;
    } catch (e) {
      print('❌ API Error: $e');
      rethrow;
    }
  }

  Future<http.Response> get(String path) async {
    try {
      final uri = Uri.parse('$baseUrl$path');
      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      
      print('🌐 API GET: $uri');
      print('📥 Response Status: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');
      
      return response;
    } catch (e) {
      print('❌ API Error: $e');
      rethrow;
    }
  }
}