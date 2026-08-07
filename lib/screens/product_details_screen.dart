import 'package:flutter/material.dart';
import '../models/product.dart';
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
           Text(product.description)
         ],
         
       ),
         
         
       
       
       ),
       
       
         
     );
   }
 }
 