import 'package:http/http.dart' as http;
import 'dart:convert';
class AuthService {
  Future<String> login(String username, String password) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (username.trim() == "admin" &&
        password.trim() == "1234") {
      return "demo_token";
    }

    throw Exception("Invalid username or password");
  }
}
