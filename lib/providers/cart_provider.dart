import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {

  final List<CartItem> _items = [];

  List<CartItem> get items => _items;


  Future<void> addToCart(Product product) async {

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

    await saveCart();
    notifyListeners();
  }


  Future<void> removeFromCart(Product product) async {

    _items.removeWhere(
          (item) => item.product.id == product.id,
    );

    await saveCart();
    notifyListeners();

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

  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();

    final cartJson = _items
        .map((item) => item.toJson())
        .toList();

    await prefs.setString(
      "cart",
      jsonEncode(cartJson),
    );
  }

  Future<void> increaseQuantity(Product product) async {

    final index = _items.indexWhere(
          (item) => item.product.id == product.id,
    );

    if (index >= 0) {

      _items[index].quantity++;

      await saveCart();

      notifyListeners();

    }
  }
}