import 'package:foodify/model/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get price => product.price;
  String get title => product.title;
  String get image => product.images;
  int get id => product.id;

  // ---- Total Price ----
  double get totalPrice => product.price * quantity;
}
