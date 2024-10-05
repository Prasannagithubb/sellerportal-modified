import 'package:flowkit/model/shopping_cart_data.dart';
import 'package:flowkit/model/shopping_product_data.dart';

class ShoppingCache {
  static List<ShoppingProduct>? products;
  static List<ShoppingCart>? carts;

  static bool isFirstTime = true;
}
