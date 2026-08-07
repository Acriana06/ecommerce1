import 'package:ecommerce/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      print("Calling provider");
      context.read<ProductProvider>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Commerce"),
      ),

      body: Builder(
        builder: (context){
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (provider.errorMessage != null) {
            return Center(
              child: Text(provider.errorMessage!),
            );
          }

          return ListView.builder(
              itemBuilder: (context, index){
                final product = provider.products[index];

                return ListTile(
                  leading: Image.network(
                    product.image,
                    width: 50,
                  ),
                  title: Text(product.title),
                  subtitle: Text("\$${product.price}"),

                );


              });

          }

      )
    );
  }
}