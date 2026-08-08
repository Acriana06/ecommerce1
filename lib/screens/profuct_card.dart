
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
final theme = Theme.of(context);

return Card(

margin: const EdgeInsets.symmetric(
horizontal: 12,
vertical: 8,
),
elevation: 3,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(50),
),
child: Padding(
padding: const EdgeInsets.all(12),
child: Row(
children: [
// Product image
Container(
width: 105,
height: 115,
padding: const EdgeInsets.all(10),
decoration: BoxDecoration(
color: Colors.purple[900],
borderRadius: BorderRadius.circular(16),
),
child: Image.network(
product.image,
fit: BoxFit.contain,
errorBuilder: (context, error, stackTrace) {
return const Icon(
Icons.image_not_supported_outlined,
size: 40,
color: Colors.grey,
);
},
loadingBuilder: (context, child, progress) {
if (progress == null) {
return child;
}

return const Center(
child: CircularProgressIndicator(
strokeWidth: 2,
),
);
},
),
),

const SizedBox(width: 14),

// Product information
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
product.title,
maxLines: 2,
overflow: TextOverflow.ellipsis,
style: const TextStyle(
fontSize: 15,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 8),

// Rating
Row(
children: [
const Icon(
Icons.star_rounded,
color: Colors.amber,
size: 20,
),
const SizedBox(width: 4),
Text(
product.rating.toString(),
style: const TextStyle(
fontWeight: FontWeight.w600,
),
),
],
),

const SizedBox(height: 10),

// Price and cart button
Row(
mainAxisAlignment:
MainAxisAlignment.spaceBetween,
children: [
Text(
"\$${product.price.toStringAsFixed(2)}",
style: TextStyle(
fontSize: 19,
fontWeight: FontWeight.bold,
color: theme.colorScheme.primary,
),
),

Container(
decoration: BoxDecoration(
color: theme.colorScheme.primary,
borderRadius:
BorderRadius.circular(12),
),
child: IconButton(
onPressed: () {
// Add to cart later
},
icon: const Icon(
Icons.shopping_cart_outlined,
color: Colors.white,
),
),
),
],
),
],
),
),
],
),
),
);
}
}
