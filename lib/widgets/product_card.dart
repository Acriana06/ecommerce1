import 'package:flutter/material.dart';
import 'package:ecommerce/models/product.dart';
 
class ProductCard extends StatelessWidget {
final Product product;

 const ProductCard({
  super.key,
   required this.product,
});


@override
Widget build(BuildContext context) {
  return Card(
    margin: const EdgeInsets.all(15),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Image.network(
            product.image,
            height: 120,
            width: 120,
          ),

          const SizedBox(height: 10),

          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "\$${product.price}",
          ),

          const SizedBox(height: 8),

          Text(
            "⭐ Rating: ${product.rating}",
            style: const TextStyle(
              fontSize: 18,
            ),
          ),

        ],
      ),
    ),
  );
}}