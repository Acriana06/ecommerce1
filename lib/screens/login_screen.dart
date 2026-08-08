
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

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

bool isLoading = false;
bool obscurePassword = true;
String? errorMessage;

Future<void> login() async {
if (!_formKey.currentState!.validate()) {
return;
}

setState(() {
isLoading = true;
errorMessage = null;
});

try {
final token = await _authService.login(
_usernameController.text.trim(),
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
body: SafeArea(
child: Center(
child: SingleChildScrollView(
padding: const EdgeInsets.all(24),

child: Form(
key: _formKey,

child: Column(
children: [

const Icon(
Icons.shopping_bag_outlined,
color: Colors.white,
size: 80,
),

const SizedBox(height: 20),

const Text(
"Welcome Back!",
style: TextStyle(
  color: Colors.white,
fontSize: 28,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 8),

const Text(
"Login to continue shopping",
style: TextStyle(
color: Colors.white,
),
),

const SizedBox(height: 35),

TextFormField(
controller: _usernameController,

decoration: const InputDecoration(
labelText: "Username",
hintText: "Enter your username",
prefixIcon: Icon(Icons.person_outline),

border: OutlineInputBorder(

),
),

validator: (value) {
if (value == null || value.trim().isEmpty) {
return "Please enter your username";
}

return null;
},
),

const SizedBox(height: 18),

TextFormField(
controller: _passwordController,
obscureText: obscurePassword,

decoration: InputDecoration(
labelText: "Password",
hintText: "Enter your password",
prefixIcon: const Icon(Icons.lock_outline),

suffixIcon: IconButton(
icon: Icon(
obscurePassword
? Icons.visibility_off
    : Icons.visibility,
),

onPressed: () {
setState(() {
obscurePassword = !obscurePassword;
});
},
),

border: const OutlineInputBorder(),
),

validator: (value) {
if (value == null || value.isEmpty) {
return "Please enter your password";
}

return null;
},
),

const SizedBox(height: 15),

if (errorMessage != null)
Text(
errorMessage!,
style: const TextStyle(
color: Colors.red,
),
),

const SizedBox(height: 20),

SizedBox(
width: double.infinity,
height: 52,

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
fontSize: 17,
),
),
),
),

const SizedBox(height: 20),


],
),
),
),
),
),
);
}
}

