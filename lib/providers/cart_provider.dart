import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {

  final List<CartItem> _items = [];

  List<CartItem> get items => _items;


  void addToCart(Product product) {

    final existingIndex = _items.indexWhere(
          (item) => item.product.id == product.id,
    );


    if (existingIndex >= 0) {

      _items[existingIndex].quantity++;

    } else {

      _items.add(
        CartItem(product: product),
      );

    }

    notifyListeners();
  }


  void removeFromCart(Product product) {

    _items.removeWhere(
          (item) => item.product.id == product.id,
    );

    notifyListeners();
  }


  void increaseQuantity(Product product) {

    final index = _items.indexWhere(
          (item) => item.product.id == product.id,
    );

    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }


  void decreaseQuantity(Product product) {

    final index = _items.indexWhere(
          (item) => item.product.id == product.id,
    );

    if (index >= 0) {

      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }

      notifyListeners();
    }
  }


  double get totalPrice {

    double total = 0;

    for (var item in _items) {
      total += item.totalPrice;
    }

    return total;
  }

}