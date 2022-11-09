import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:rodenberg/controller/order_controller.dart';
import 'package:rodenberg/modals/product.dart';
import 'package:rodenberg/services/cart_service/cart_item.dart';
import 'package:rodenberg/utils/helper.dart';

class CartService extends GetxController {
  static CartService get to => Get.find();

  RxList<CartItem> cartItems = (<CartItem>[]).obs;

  RxInt grandTotal = 0.obs;
  RxInt totalBeforeTax = 0.obs;
  RxDouble discountTotal = 0.0.obs;
  RxInt taxValue = 0.obs;
  RxInt subTotal = 0.obs;

  increaseQuantity(Product product) {
    var index =
        cartItems.indexWhere((element) => element.productId == product.id);
    if (index == -1) {
      if (product.stock <= 0) {
        Helper.showSnackbar("Error".tr(), "Not in stock".tr());
        return;
      }
      CartItem item = CartItem(
          productId: product.id!,
          unitPrice: double.parse(product.price!) - product.discountPrice!,
          product: product,
          stock: product.stock,
          originalPrice: double.parse(product.price!));
      item.quantity++;
      cartItems.add(item);
    } else {
      if (product.stock < (cartItems[index].quantity + 1)) {
        Helper.showSnackbar("Error".tr(), "Not enough in stock".tr());
        return;
      }
      cartItems[index].quantity++;
    }
    calculateTotal();
  }

  setQuantity(Product product, int quantity) {
    if (product.stock < quantity) {
      Helper.showSnackbar("Error".tr(), "Not enough in stock".tr());
      return;
    }
    var index =
        cartItems.indexWhere((element) => element.productId == product.id);
    if (index == -1) return;
    if (quantity <= 0) {
      cartItems.removeAt(index);
    } else {
      cartItems[index].quantity = quantity;
    }
    calculateTotal();
  }

  decreaseQuantity(Product product) {
    var index =
        cartItems.indexWhere((element) => element.productId == product.id);
    if (index == -1) return;

    if (cartItems[index].quantity == 1) {
      cartItems.removeAt(index);
    } else {
      cartItems[index].quantity--;
    }

    cartItems.refresh();
    calculateTotal();
  }

  getQuantity(Product product) {
    var index =
        cartItems.indexWhere((element) => element.productId == product.id);
    return (index == -1) ? 0 : cartItems[index].quantity;
  }

  calculateTotal() {
    double sub = 0;
    double grand = 0;
    double discount = 0;
    for (var element in cartItems) {
      grand += element.quantity * element.unitPrice;
      discount += element.quantity * element.unitPrice;
      sub += element.quantity * element.originalPrice;
    }
    print(discount);
    print(sub);
    subTotal.value = sub.toInt();
    discountTotal.value = discount.toPrecision(2);
    totalBeforeTax.value = grand.toInt();
    taxValue.value = ((sub * OrderController.to.taxRate) / 100).toInt();
    grandTotal.value = ((sub - grand) + taxValue.value).toInt();
    print('GRAND ==== ${grandTotal.value}');
    print('TEX ==== ${taxValue.value}');
    print('SUB ==== ${subTotal.value}');
    print('DISCOUNT ==== ${discountTotal.value}');
  }
}
