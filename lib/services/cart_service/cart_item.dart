import 'package:rodenberg/modals/product.dart';

class CartItem{
  String productId;
  int quantity = 0;
  double unitPrice;
  double originalPrice;
  Product product;
  int stock;

  CartItem({required this.productId, required this.unitPrice, required this.product, required this.stock, required this.originalPrice});
}