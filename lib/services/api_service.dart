import 'package:ecommerce/models/product.dart';
import 'package:http/http.dart' as http;
import'dart:convert';
class ApiService{
  Future<List<Product>> fetchProducts() async{
    final response = await http.get(
        Uri.parse("https://fakestoreapi.com/products")
    );

    if (response.statusCode== 200 ){
      final data = jsonDecode(response.body);
      List<Product> products = (data as List)
          .map((item) {
        final product = Product.fromJson(item);


        return product;
      })
          .toList();
      return products;
    } else {
    throw Exception("Failed to load products");    }
  }
}
