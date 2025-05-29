import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'https://TU_API_HEROKU_URL';

  static Future<bool> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: {'email': email, 'password': password},
    );
    return response.statusCode == 200;
  }

  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'email': email, 'password': password},
    );
    return response.statusCode == 200;
  }
}