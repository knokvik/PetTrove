import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future<bool> authenticate({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));  // Simulate network delay

    // Trim to avoid whitespace issues
    if (email.trim() == "test@example.com" && password.trim() == "password123") {
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setBool('isLoggedIn', true);  // Save login state
      return true;
    }
    return false;
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {

      print("$name\n$email\n$password\n$phone");
      
      await Future.delayed(const Duration(seconds: 2));

    return true;  
  }
}
