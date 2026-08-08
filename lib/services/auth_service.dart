
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web/web.dart' as web;

class AuthService {
Future<String> login(String username, String password) async {
final response = await http.post(
Uri.parse("https://fakestoreapi.com/auth/login"),
headers: {
"Content-Type": "application/json",
},
body: jsonEncode({
"username": username.trim(),
"password": password,
}),
);

print("Status: ${response.statusCode}");
print("Response: ${response.body}");

if (response.statusCode == 200 ||
response.statusCode == 201) {
final data = jsonDecode(response.body);

final token = data["token"];

// Save token in browser localStorage
web.window.localStorage.setItem("token", token);

print("Token saved: ${web.window.localStorage.getItem("token")}");

return token;
}

throw Exception(
"Login failed: ${response.body}",
);
}

Future<bool> isLoggedIn() async {
final token = web.window.localStorage.getItem("token");

print("Stored token: $token");

return token != null && token.isNotEmpty;
}

Future<void> logout() async {
web.window.localStorage.removeItem("token");

print("Token removed");
}
}

