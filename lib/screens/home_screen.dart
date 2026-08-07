import 'package:ecommerce/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/widgets/product_card.dart';

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
      context.read<ProductProvider>().fetchProducts();
    });
  }


  @override
  Widget build(BuildContext context) {

    final provider = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: const Text("E-Commerce"),
      ),
backgroundColor: Colors.blueGrey[200],
      body: Builder(
        builder: (context) {

          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }


          if (provider.errorMessage != null) {
            return Center(
              child: Text(provider.errorMessage!),
            );
          }


          if (provider.products.isEmpty) {
            return const Center(
              child: Text("No products found"),
            );
          }


          return ListView.builder(
            itemCount: provider.products.length,

            itemBuilder: (context, index) {

              final product = provider.products[index];

              return ProductCard(
                product: product,
              );

            },
          );
        },
      ),
    );
  }
}