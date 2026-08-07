import 'package:flutter/material.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/services/api_service.dart';

class ProductProvider extends ChangeNotifier {

  final ApiService _apiService = ApiService();

  List<Product> _products = [];
  List<Product> _filteredProducts = [];

  bool _isLoading = false;
  String? _errorMessage;


  List<Product> get products => _filteredProducts;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;


  Future<void> fetchProducts() async {

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();


    try {

      _products = await _apiService.fetchProducts();

      _filteredProducts = _products;

      print("Loaded ${_products.length} products");


    } catch(e) {

      print(e);
      _errorMessage = e.toString();


    } finally {

      _isLoading = false;
      notifyListeners();

    }
  }


  void searchProducts(String query) {

    if (query.isEmpty) {

      _filteredProducts = _products;

    } else {

      _filteredProducts = _products
          .where(
            (product) => product.title
            .toLowerCase()
            .contains(query.toLowerCase()),
      )
          .toList();

    }

    notifyListeners();

  }

void filterByCategory (String category){
    if (category =="All"){
      _filteredProducts = _products;

    } else{
      _filteredProducts = _products
          .where(
          (product)=>product.category==category
      )
          .toList();
    }
    notifyListeners();
}
List<String> get categories{
    return [
      "All",
      ..._products
      .map((product)=> product.category)
      .toSet()
      .toList(),
    ];
}
}