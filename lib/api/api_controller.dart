import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiController {
  static const String _baseUrl = "http://192.168.43.7:3000"; // Mobile hotspot
  // "http://192.168.0.106:3000";

  /// Helper method to get token and userId from SharedPreferences
  static Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final userId = prefs.getString('userId') ?? '';

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'User-Id': userId,
    };
  }

  static Future<http.Response> post(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    final headers = await _getHeaders();

    return await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> put(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    final headers = await _getHeaders();

    return await http.put(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    final headers = await _getHeaders();

    return await http.get(
      url,
      headers: headers,
    );
  }
}
