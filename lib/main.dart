
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/services/auth_service.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:ecommerce/screens/home_screen.dart';

void main() {
runApp(
MultiProvider(
providers: [
ChangeNotifierProvider(
create: (_) => ProductProvider(),
),
ChangeNotifierProvider(
create: (_) => CartProvider(),
),
],
child: const MyApp(),
),
);
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    textTheme:
    GoogleFonts.poppinsTextTheme(),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
    ),
    scaffoldBackgroundColor: Colors.grey[100],
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
  ),
debugShowCheckedModeBanner: false,
title: 'E-Commerce',
home: const AuthCheck(),
);
}
}

class AuthCheck extends StatefulWidget {
const AuthCheck({super.key});

@override
State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
final AuthService _authService = AuthService();

@override
Widget build(BuildContext context) {
return FutureBuilder<bool>(
future: _authService.isLoggedIn(),

builder: (context, snapshot) {
if (snapshot.connectionState == ConnectionState.waiting) {
return const Scaffold(
body: Center(
child: CircularProgressIndicator(),
),
);
}

if (snapshot.hasData && snapshot.data == true) {
return const HomeScreen();
}

return const LoginScreen();
},
);
}
}
