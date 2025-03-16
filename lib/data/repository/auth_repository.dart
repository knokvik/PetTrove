import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:pettrove/models/pets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {

  Future<bool> authenticate({required String email, required String password}) async {
  try {
    final url = Uri.parse('https://clever-shape-81254.pktriot.net/auth/authenticate'); // Replace with your server URL

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
      print(responseBody['pets']);
      await prefs.setString('currentUser', jsonEncode({
        'id': responseBody['userId'],
        'name': responseBody['name'],
        'email': responseBody['email'],
        'pets': responseBody['pets'],
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

  Future<bool> resetPass(String email, String newPassword) async {
  try {
    print(email);
    print(newPassword);

    // Prepare the body data
    final body = json.encode({
      'email': email,
      'pass': newPassword,
    });

    final response = await http.post(
      Uri.parse('https://clever-shape-81254.pktriot.net/auth/reset-password'),  // API endpoint for password reset
      headers: {
        'Content-Type': 'application/json',  // Setting the header to application/json
      },
      body: body,  // Passing the body as JSON-encoded data
    );

    if (response.statusCode == 200) {
      // Handle success response
      print('Password reset successfully');
      return true;
    } else {
      // Handle failure response
      print('Failed to reset password');
      return false;
    }
  } catch (e) {
    // Handle error
    print('Error: $e');
    return false;
  }
}
  
  Future<Map<String, dynamic>> sendForgetRequest(String email) async {
  try {
    print("Sending request for email: $email");

    final url = Uri.parse('https://clever-shape-81254.pktriot.net/auth/getForgetRequest');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email.trim()}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {"success": true, "phone": data["phone"]}; // ✅ Return both values
    } else {
      return {"success": false, "phone": null}; // ✅ Return failure case
    }
  } catch (e) {
    print('Request error: $e');
    return {"success": false, "phone": null}; // ✅ Return failure case
  }
}

  Future<bool> mailVerification(String email) async {
  try {
    print("Sending request for email: $email");

    final url = Uri.parse('https://clever-shape-81254.pktriot.net/auth/emailVerification');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email.trim()}),
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      return true; 
    } else {
      return false; 
    }
  } catch (e) {
    print('Request error: $e');
    return false;
  }
}

  Future<bool> verifyOtp({required String email, required String otp}) async {
  try {
    final url = Uri.parse('https://clever-shape-81254.pktriot.net/auth/verify-otp');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email.trim(),
        'otp': otp.trim(),
      }),
    );

    if (response.statusCode == 200) {
      // OTP verified successfully
      return true;
    } else {
      // OTP verification failed
      return false;
    }
  } catch (e) {
    print('OTP verification error: $e');
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
  required List<Pet> pets
}) async {
  try {
    final url = Uri.parse('https://clever-shape-81254.pktriot.net/auth/register'); // Replace with your server URL

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
        'pets': pets,
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
        'pets': responseBody['pets'],
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
