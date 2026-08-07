
import 'package:flutter/material.dart';
import 'package:ecommerce/services/auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
const LoginScreen({super.key});

@override
State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
final AuthService _authService = AuthService();

final TextEditingController _usernameController =
TextEditingController();

final TextEditingController _passwordController =
TextEditingController();

bool isLoading = false;
String? errorMessage;

Future<void> login() async {
setState(() {
isLoading = true;
errorMessage = null;
});

try {
final token = await _authService.login(
_usernameController.text,
_passwordController.text,
);

print("Login successful: $token");

if (!mounted) return;

Navigator.pushReplacement(
context,
MaterialPageRoute(
builder: (context) => const HomeScreen(),
),
);
} catch (e) {
if (!mounted) return;

setState(() {
errorMessage = "Invalid username or password";
});
} finally {
if (!mounted) return;

setState(() {
isLoading = false;
});
}
}

@override
void dispose() {
_usernameController.dispose();
_passwordController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Login"),
),

body: Padding(
padding: const EdgeInsets.all(20),

child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [

const Icon(
Icons.shopping_bag,
size: 70,
),

const SizedBox(height: 30),

TextField(
controller: _usernameController,
decoration: const InputDecoration(
labelText: "Username",
border: OutlineInputBorder(),
prefixIcon: Icon(Icons.person),
),
),

const SizedBox(height: 15),

TextField(
controller: _passwordController,
obscureText: true,
decoration: const InputDecoration(
labelText: "Password",
border: OutlineInputBorder(),
prefixIcon: Icon(Icons.lock),
),
),

const SizedBox(height: 20),

if (errorMessage != null)
Text(
errorMessage!,
style: const TextStyle(
color: Colors.red,
),
),

const SizedBox(height: 15),

SizedBox(
width: double.infinity,
height: 50,

child: ElevatedButton(
onPressed: isLoading ? null : login,

child: isLoading
? const SizedBox(
width: 24,
height: 24,
child: CircularProgressIndicator(),
)
    : const Text(
"Login",
style: TextStyle(
fontSize: 16,
),
),
),
),

const SizedBox(height: 15),

const Text(
"Demo login: admin / 1234",
style: TextStyle(
color: Colors.grey,
),
),
],
),
),
);
}
}
