import 'package:ecommerce/providers/product_provider.dart';
import 'package:flutter/cupertino.dart';
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


          return Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(10),

                child: TextField(
                  cursorColor: Colors.blue,
                  decoration: const InputDecoration(
                    hintText: "Search products...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius. all(Radius. circular(50.0))),
                  ),

                  onChanged: (value) {
                    provider.searchProducts(value);
                  },

                ),
              ),
              SizedBox(
                height: 50,

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,

                  itemCount: provider.categories.length,

                  itemBuilder: (context, index) {

                    final category = provider.categories[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),

                      child: ElevatedButton(

                        onPressed: () {
                          provider.filterByCategory(category);
                        },

                        child: Text(category),
                      ),
                    );

                  },
                ),
              ),


              Expanded(
                child: ListView.builder(

                  itemCount: provider.products.length,

                  itemBuilder: (context, index) {

                    final product = provider.products[index];

                    return ProductCard(
                      product: product,
                    );

                  },
                ),
              ),

            ],
          );
        },
      ),
    );
  }
}