import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiController {
  static const String _baseUrl =
      "http://192.168.43.7:3000"; // Change to your real backend

  static Future<http.Response> post(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    return await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
  }
}
