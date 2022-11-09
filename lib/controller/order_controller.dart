import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';
import 'package:rodenberg/controller/user_controller.dart';
import 'package:rodenberg/helper/location_helper.dart';
import 'package:rodenberg/modals/delivery_slot.dart';
import 'package:rodenberg/modals/place_order.dart';
import 'package:rodenberg/screens/order/order_placed_screen.dart';
import 'package:rodenberg/services/api_service/api_service.dart';
import 'package:rodenberg/services/api_service/urls.dart';
import 'package:rodenberg/services/cart_service/cart_service.dart';
import 'package:rodenberg/utils/helper.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find();

  Rx<DeliverySlotModel> selectedDeliverySlot =
      Rx(DeliverySlotModel(deliveryDate: "", deliveryDay: ""));

  RxList<DeliverySlotModel> deliverySlots = RxList();

  int minOrderValue = 0;
  int taxRate = 0;

  String addressLine = "";
  String city = "";
  String country = "";
  String state = "";
  String region = "";
  String references = "";
  String latitude = "";
  String longitude = "";
  String rut = "";
  String businessName = "";
  String phone = "";
  String email = "";

  @override
  void onInit() {
    super.onInit();
    asyncInit();
  }

  asyncInit() async {
    minOrderValue = (await APIService.instance.getMinOrderValue()).data ?? 0;
    taxRate = (await APIService.instance.getMinTaxRate()).data ?? 0;
  }

  getDeliverySlots() async {
    selectedDeliverySlot.value =
        DeliverySlotModel(deliveryDate: "", deliveryDay: "");
    var res = await APIService.instance.getDeliverySlots({
      "location": city,
      'token': UserController.to.token,
      "latitude": LocationHelper.currentLocation.latitude.toString(),
      "longitude": LocationHelper.currentLocation.longitude.toString()
    });
    deliverySlots.clear();
    deliverySlots.addAll(res.data!);
  }

  onlinePayment() async {
    List<OrderProductModel> products = [];
    for (var element in CartService.to.cartItems) {
      OrderProductModel prod = OrderProductModel(
          productId: element.productId,
          quantity: element.quantity.toString(),
          disAmount: element.unitPrice.toInt().toString(),
          totalPrice: element.product.discountPrice != null
              ? element.product.discountPrice.toString()
              : '0',
          totalDiscount:
              (element.unitPrice.toInt() * element.quantity).toString(),
          totalAmount: element.originalPrice.toInt().toString());
      products.add(prod);
    }
    PlaceOrderModel placeOrderModel = PlaceOrderModel(
        token: UserController.to.token,
        product: jsonEncode(products),
        totalItems: products.length.toString(),
        totalAmount: CartService.to.grandTotal.toInt().toString(),
        city: city,
        state: state,
        country: country,
        region: region,
        references: references,
        deliveryAddress: addressLine,
        deliveryLocation: city);
    final dioClient = Dio();
    try {
      print(placeOrderModel.totalAmount!);
      final response = await dioClient.post(
          "https://api.mercadopago.com/checkout/preferences?access_token=${URLS.MERCADO_ACCESS_TOKEN}",
          data: {
            "items": [
              {
                "title": "Purchase Item",
                "description": "Multicolor Item",
                "quantity": 1,
                "currency_id": "CLP",
                "unit_price": int.parse(placeOrderModel.totalAmount!)
              }
            ],
            // "items": [
            //   {
            //     "title": "Dummy Item",
            //     "description": "Multicolor Item",
            //     "quantity": 1,
            //     "currency_id": "USD",
            //     "unit_price": 10.0
            //   }
            // ],
            "payer": {"email": "payer@email.com"}
          });

      PaymentResult result = await MercadoPagoMobileCheckout.startCheckout(
        URLS.MERCADO_public_KEY,
        response.data['id'],
      );
      if (result.status!.contains('approved')) {
        var res = await APIService.instance.placeOrder({
          'token': placeOrderModel.token!,
          'product': jsonEncode(products),
          'total_amount': placeOrderModel.totalAmount!,
          'total_item': placeOrderModel.totalItems!,
          'city': placeOrderModel.city!,
          'state': placeOrderModel.state!,
          'country': placeOrderModel.country!,
          'region': placeOrderModel.region!,
          'region_id': 0,
          'references': placeOrderModel.references!,
          'current_location': LocationHelper.currentCity,
          'delivery_date': selectedDeliverySlot.value.deliveryDate!,
          'delivery_address': placeOrderModel.deliveryAddress!,
          'delivery_location': placeOrderModel.deliveryLocation!,
          "rut": rut,
          "business_name": businessName,
          "email": email,
          "phone": phone,
          "tax_rate": OrderController.to.taxRate,
          "payment_id": 2
        });

        if (res.status) {
          Get.to(() => const OrderPlacedScreen(),
              opaque: false, fullscreenDialog: true);
        } else {
          Helper.showSnackbar("Error".tr(), res.msg);
        }
      } else {
        Helper.showSnackbar("Error".tr(), 'Payment decline');
      }
    } catch (e) {
      print('ERROR $e');
      Helper.showSnackbar("Error".tr(), 'Payment decline');
    }
  }

  placeOrder() async {
    List<OrderProductModel> products = [];
    for (var element in CartService.to.cartItems) {
      OrderProductModel prod = OrderProductModel(
          productId: element.productId,
          quantity: element.quantity.toString(),
          disAmount: element.unitPrice.toInt().toString(),
          totalPrice: element.product.discountPrice != null
              ? element.product.discountPrice.toString()
              : '0',
          totalDiscount:
              (element.unitPrice.toInt() * element.quantity).toString(),
          totalAmount: element.originalPrice.toInt().toString());
      products.add(prod);
    }
    print(CartService.to.grandTotal.toInt());
    print(CartService.to.taxValue.toInt());
    print(CartService.to.discountTotal.toInt());
    print(CartService.to.subTotal.toInt());

    PlaceOrderModel placeOrderModel = PlaceOrderModel(
        token: UserController.to.token,
        product: jsonEncode(products),
        totalItems: products.length.toString(),
        totalAmount: CartService.to.grandTotal.toString(),
        city: city,
        state: state,
        country: country,
        region: region,
        references: references,
        deliveryAddress: addressLine,
        deliveryLocation: city);

    var res = await APIService.instance.placeOrder({
      'token': placeOrderModel.token!,
      'product': jsonEncode(products),
      'total_amount': placeOrderModel.totalAmount!,
      'total_item': placeOrderModel.totalItems!,
      'city': placeOrderModel.city!,
      'state': placeOrderModel.state!,
      'country': placeOrderModel.country!,
      'region': placeOrderModel.region!,
      'region_id': 0,
      'references': placeOrderModel.references!,
      'current_location': LocationHelper.currentCity,
      'delivery_date': selectedDeliverySlot.value.deliveryDate!,
      'delivery_address': placeOrderModel.deliveryAddress!,
      'delivery_location': placeOrderModel.deliveryLocation!,
      "business_name": businessName,
      "rut": rut,
      "email": email,
      "phone": phone,
      "tax_rate": OrderController.to.taxRate,
      "payment_id": 1,
    });
    print('RES === ${{
      'token': placeOrderModel.token!,
      'product': jsonEncode(products),
      'total_amount': placeOrderModel.totalAmount!,
      'total_item': placeOrderModel.totalItems!,
      'city': placeOrderModel.city!,
      'state': placeOrderModel.state!,
      'country': placeOrderModel.country!,
      'region': placeOrderModel.region!,
      'region_id': 0,
      'references': placeOrderModel.references!,
      'current_location': LocationHelper.currentCity,
      'delivery_date': selectedDeliverySlot.value.deliveryDate!,
      'delivery_address': placeOrderModel.deliveryAddress!,
      'delivery_location': placeOrderModel.deliveryLocation!,
      "business_name": businessName,
      "rut": rut,
      "email": email,
      "phone": phone,
      "tax_rate": OrderController.to.taxRate,
      "payment_id": 1,
    }}');
    if (res.status) {
      Get.to(() => const OrderPlacedScreen(),
          opaque: false, fullscreenDialog: true);
    } else {
      Helper.showSnackbar("Error".tr(), res.msg);
    }
  }
}
