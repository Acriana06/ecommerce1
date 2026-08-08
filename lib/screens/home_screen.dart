
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/widgets/product_card.dart';
import 'package:ecommerce/screens/profile_screen.dart';

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
backgroundColor: const Color(0xFFF7F7F9),

appBar: AppBar(
backgroundColor: Colors.purple[100],
elevation: 0,

title: const Text(
"Shopora",
style: TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
),
),

actions: [
IconButton(
icon: const Icon(
Icons.person_outline,
size: 28,
),

onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => const ProfileScreen(),
),
);
},
),

const SizedBox(width: 8),
],
),

body: Builder(
builder: (context) {
// Loading
if (provider.isLoading) {
return const Center(
child: CircularProgressIndicator(),
);
}

// Error
if (provider.errorMessage != null) {
return Center(
child: Padding(
padding: const EdgeInsets.all(20),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Icon(
Icons.error_outline,
size: 50,
color: Colors.redAccent,
),

const SizedBox(height: 12),

Text(
provider.errorMessage!,
textAlign: TextAlign.center,
),
],
),
),
);
}

// Empty
if (provider.products.isEmpty) {
return const Center(
child: Text(
"No products found",
style: TextStyle(
fontSize: 18,
),
),
);
}

return Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text("Welcome to Shopora!🛍",style: TextStyle(fontSize: 20, color: Colors.purple[900]),),
      SizedBox(height: 10,),
      Text("Your all-in-one Shopping App.",style: TextStyle(fontSize: 18, color: Colors.purple[800]),),
    ],
  ),
),// SEARCH BAR
Padding(
padding: const EdgeInsets.fromLTRB(
16,
16,
16,
10,
),

child: TextField(
cursorColor: Colors.deepPurple,

decoration: InputDecoration(
hintText: "Search products...",

prefixIcon: const Icon(
Icons.search,
),

filled: true,
fillColor: Colors.white,

contentPadding:
const EdgeInsets.symmetric(
vertical: 15,
),

border: OutlineInputBorder(
borderRadius:
BorderRadius.circular(30),

borderSide: BorderSide.none,
),
),

onChanged: (value) {
provider.searchProducts(value);
},
),
),

// CATEGORIES TITLE
const Padding(
padding: EdgeInsets.symmetric(
horizontal: 16,
),

child: Text(
"Categories",
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
),

const SizedBox(height: 8),

// CATEGORIES
SizedBox(
height: 45,

child: ListView.builder(
scrollDirection: Axis.horizontal,

padding: const EdgeInsets.symmetric(
horizontal: 12,
),

itemCount: provider.categories.length,

itemBuilder: (context, index) {
final category =
provider.categories[index];

return Padding(
padding:
const EdgeInsets.symmetric(
horizontal: 4,
),

child: ElevatedButton(
onPressed: () {
provider.filterByCategory(
category,
);
},

style: ElevatedButton.styleFrom(
elevation: 0,

backgroundColor:
Colors.deepPurple,

foregroundColor:
Colors.white,

shape:
RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(
20,
),
),
),

child: Text(
category,
style: const TextStyle(
fontSize: 13,
),
),
),
);
},
),
),

// PRODUCTS TITLE
const Padding(
padding: EdgeInsets.fromLTRB(
16,
16,
16,
8,
),

child: Text(
"Products Available",
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
),
),
),

// PRODUCT LIST
Expanded(
child: ListView.builder(
padding: const EdgeInsets.only(
bottom: 15,
),

itemCount:
provider.products.length,

itemBuilder: (context, index) {
final product =
provider.products[index];

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
