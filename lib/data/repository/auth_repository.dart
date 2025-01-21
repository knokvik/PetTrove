import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future<bool> authenticate({required String email, required String password}) async {
  try {
    final url = Uri.parse('https://clever-shape-81254.pktriot.net/authenticate/'); // Replace with your server URL

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json', // ✅ Correct header
      },
      body: jsonEncode({
        'email': email.trim(),
        'password': password.trim(),
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('currentUser', jsonEncode({
        'id': responseBody['userId'],
        'name': responseBody['name'],
        'email': responseBody['email'],
      }));
      await prefs.setBool('isLoggedIn', true);
      return true;
    }
    return false;

  } catch (e) {
    print('Authentication error: $e');
    return false;
  }
}


  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('currentUser');
  }

  Future<bool> register({
  required String name,
  required String email,
  required String password,
  required String phone,
}) async {
  try {
    final url = Uri.parse('https://clever-shape-81254.pktriot.net/register'); // Replace with your server URL

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name.trim(),
        'email': email.trim(),
        'password': password.trim(),
        'phone': phone.trim(),
      }),
    );

     if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('currentUser', jsonEncode({
        'id': responseBody['userId'],
        'name': responseBody['name'],
        'email': responseBody['email'],
      }));
      print("User logged in: ${responseBody['name']}");
      return true;
      } else {
      print("Registration Failed: ${response.body}");
      return false;
    }
  } catch (e) {
    print('Registration error: $e');
    return false;
  }
}
}
