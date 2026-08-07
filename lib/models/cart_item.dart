import 'product.dart';

class CartItem{
  final Product product;

  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
});
  double get totalPrice => product.price*quantity;

  Map<String, dynamic> toJson() {
    return {
      "id": product.id,
      "quantity": quantity,
    };
  }

  factory CartItem.fromJson(
      Map<String, dynamic> json,
      Product product,
      ) {
    return CartItem(
      product: product,
      quantity: json["quantity"],
    );
  }
}
