import 'dart:convert';
  import 'package:http/http.dart' as http;
  import 'package:shared_preferences/shared_preferences.dart';

  class AuthService {
    static const String baseUrl = 'https://t3r-c0d3-backend-405e3ea959d7.herokuapp.com/';

    static Future<bool> registerTelegram(String telegramId) async {
      final response = await http.post(
        Uri.parse('$baseUrl/register/telegram'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'telegram_id': telegramId}),
      );
      if (response.statusCode == 200) {
        final token = jsonDecode(response.body)['access_token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        return true;
      }
      return false;
    }

    static Future<bool> loginTelegram(String telegramId) async {
      final response = await http.post(
        Uri.parse('$baseUrl/login/telegram'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'telegram_id': telegramId}),
      );
      if (response.statusCode == 200) {
        final token = jsonDecode(response.body)['access_token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        return true;
      }
      return false;
    }

    static Future<String?> getToken() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('token');
    }

    static Future<void> logout() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
    }
  }