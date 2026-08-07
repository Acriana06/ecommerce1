import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {

  const CartScreen({super.key});


  @override
  Widget build(BuildContext context) {

    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),

      body: cart.items.isEmpty
          ? const Center(
        child: Text("Your cart is empty"),
      )

          : Column(
        children: [

          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,

              itemBuilder: (context, index) {

                final item = cart.items[index];

                return ListTile(

                  leading: Image.network(
                    item.product.image,
                    width: 50,
                  ),

                  title: Text(
                    item.product.title,
                  ),

                  subtitle: Text(
                    "Quantity: ${item.quantity}",
                  ),

                  trailing: Text(
                    "\$${item.totalPrice}",
                  ),

                );
              },
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(15),

            child: Text(
              "Total: \$${cart.totalPrice}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        ],
      ),
    );
  }
}