import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/login_screen.dart';
void main() {
  runApp(
      MultiProvider(
        providers: [

          ChangeNotifierProvider(
            create: (context) => ProductProvider(),
          ),

          ChangeNotifierProvider(
            create: (context) => CartProvider(),
          ),

        ],

        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce',
      home: const LoginScreen(),
    );
  }
}