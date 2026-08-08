import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';
import "../providers/cart_provider.dart";
import '../screens/cart_screen.dart';
 class ProductDetailsScreen extends StatelessWidget {
   final Product product;
   
    const ProductDetailsScreen({
     super.key,
      required this.product
 });
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: const Text("Product Details"),

         actions: [
           IconButton(
             icon: const Icon(Icons.shopping_cart),

             onPressed: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => const CartScreen(),
                 ),
               );
             },
           ),
         ],
         backgroundColor: Colors.purple[100],

       ),
       body: Padding(
           padding: EdgeInsets.all(25),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Center(
             child: Image.network(product.image, height: 200,),
             
           ),
           const SizedBox(height: 20,),
           Text(product.title,
             style: const TextStyle(
               fontSize: 22,
               fontWeight: FontWeight.bold,
             ),),
            const SizedBox(height: 10,),
           Text("\$${product.price}", style: const TextStyle(
             fontSize: 18,
           ),),
           const SizedBox(
             height: 10,
           ),
           
           Row(
             children: [
               const Icon(Icons.star, color: Colors.amber,),
               Text("${product.rating}")
             ],
             
           ),
           const SizedBox(height: 20,),
           Text(product.description),
           const SizedBox(height: 20),

           SizedBox(
             width: double.infinity,

             child: ElevatedButton(
               style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.purple[900],
                 foregroundColor: Colors.white               ),
               onPressed: () {

                 context.read<CartProvider>()
                     .addToCart(product);

                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(
                     content: Text("Added to cart  "),
                   ),
                 );

               },

               child: const Text(
                 "Add to Cart",
               ),

             ),
           ),
         ],
         
       ),
         
         
       
       
       ),
       
       
         
     );
   }
 }
 