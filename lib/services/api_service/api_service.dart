import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:rodenberg/controller/user_controller.dart';
import 'package:rodenberg/modals/category.dart';
import 'package:rodenberg/modals/delivery_slot.dart';
import 'package:rodenberg/modals/offer.dart';
import 'package:rodenberg/modals/order_history.dart';
import 'package:rodenberg/modals/order_item.dart';
import 'package:rodenberg/modals/product.dart';
import 'package:rodenberg/modals/user.dart';
import 'package:rodenberg/services/api_service/urls.dart';

import 'base_response.dart';

class APIService {
  // static APIService get to{
  //
  //   return APIService();
  // }
  static APIService instance = APIService();

  Dio? _dio;
  APIService() {
    BaseOptions options = BaseOptions(
      baseUrl: URLS.BASE_URL,
      validateStatus: (status) => status! < 500,
      //headers: {"content-type":Headers.formUrlEncodedContentType},

      responseType: ResponseType.json,
    );

    _dio = Dio(options);
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio?.interceptors.add(LogInterceptor(
      requestHeader: false,
      requestBody: true,
      error: false,
      responseHeader: false,
      responseBody: true,
    ));
    _dio?.interceptors.add(InterceptorsWrapper(onResponse: (response, handler) {
      response.data = response.data;

      handler.next(response);
    }));
  }

  Options _getOptions(String token) {
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  Future<CategoryListResponse> getCategoryList() async {
    try {
      Response? response = await _dio?.get(URLS.CATEGORY_LIST);

      if ((response?.data) == null || (response?.data)["status"] != 200) {
        return CategoryListResponse(false, response?.data["message"]);
      }
      List<Category> list = (response?.data["data"] as List)
          .map((e) => Category.fromJson(e))
          .toList();
      return CategoryListResponse(true, "Category list fetched successful",
          list: list);
    } on DioError catch (error, stacktrace) {
      return CategoryListResponse(false, "Something went wrong".tr());
    }
  }

  Future<ProductListResponse> getHomeProductList(
      Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);
      final response = await http
          .post(Uri.parse(URLS.BASE_URL + URLS.ALL_PRODUCT_LIST), body: data);
      final decodedRes = json.decode(response.body);

      if ((decodedRes) == null || (decodedRes)["status"] != 200) {
        return ProductListResponse(false, decodedRes["message"]);
      }
      List<Product> list =
          (decodedRes["data"] as List).map((e) => Product.fromJson(e)).toList();
      return ProductListResponse(true, "Product list fetched successful",
          list: list);
    } on DioError catch (error, stacktrace) {
      return ProductListResponse(false, "Something went wrong".tr());
    }
  }

  Future<OfferListResponse> getOfferList(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);
      Response? response = await _dio?.post(URLS.OFFERS_LIST, data: formData);

      if ((response?.data) == null || (response?.data)["status"] != 200) {
        return OfferListResponse(false, response?.data["message"]);
      }
      List<Offer> list = (response?.data["data"] as List)
          .map((e) => Offer.fromJson(e))
          .toList();
      return OfferListResponse(true, "Offer list fetched successful",
          list: list);
    } on DioError catch (error, stacktrace) {
      return OfferListResponse(false, "Something went wrong".tr());
    }
  }

  Future<BaseResponse> signup(Map<String, dynamic> data) async {
    try {
      print(data);
      FormData formData = FormData.fromMap(data);
      Response? response = await _dio?.post(URLS.SIGNUP, data: formData);

      if ((response?.data) == null || (response?.data)["status"] != 200) {
        return BaseResponse(false, response?.data["message"]);
      }
      return BaseResponse(true, "Signup successful");
    } on DioError catch (error, stacktrace) {
      print(error);
      return BaseResponse(false, "Something went wrong".tr());
    }
  }

  Future<LoginResponse> login(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);
      Response? response = await _dio?.post(URLS.LOGIN, data: formData);

      if ((response?.data) == null || (response?.data)["status"] != 200) {
        return LoginResponse(false, response?.data["message"]);
      }
      return LoginResponse(true, "Login successful",
          token: response?.data["token"],
          user: User.fromJson(response?.data["data"]));
    } on DioError catch (error, stacktrace) {
      return LoginResponse(false, "Something went wrong".tr());
    }
  }

  Future<BaseResponse> forgotPassword(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);
      Response? response =
          await _dio?.post(URLS.FORGOT_PASSWORD, data: formData);

      if ((response?.data) == null || (response?.data)["status"] != 200) {
        return BaseResponse(false, response?.data["message"]);
      }
      return BaseResponse(true, "Reset mail sent successful");
    } on DioError catch (error, stacktrace) {
      return BaseResponse(false, "Something went wrong".tr());
    }
  }

  Future<ProfileResponse> getProfile(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);
      Response? response = await _dio?.post(URLS.GET_PROFILE, data: formData);

      if ((response?.data) == null || (response?.data)["status"] != 200) {
        return ProfileResponse(false, response?.data["message"]);
      }
      return ProfileResponse(true, "Profile fetched successful",
          user: User.fromJson(response?.data["data"]));
    } on DioError catch (error, stacktrace) {
      return ProfileResponse(false, "Something went wrong".tr());
    }
  }

  Future<BaseResponse> updateAddress(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);
      Response? response = await _dio?.post(URLS.SAVE_ADDRESS, data: formData);

      if ((response?.data) == null || (response?.data)["status"] != 200) {
        return BaseResponse(false, response?.data["message"]);
      }
      return BaseResponse(true, "Address saved successful");
    } on DioError catch (error, stacktrace) {
      return BaseResponse(false, "Something went wrong".tr());
    }
  }

  Future<BaseResponse> updateDeliveryAddress(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);
      Response? response =
          await _dio?.post(URLS.SAVE_DELIVERY_ADDRESS, data: formData);

      if ((response?.data) == null || (response?.data)["status"] != 200) {
        return BaseResponse(false, response?.data["message"]);
      }
      return BaseResponse(true, "Address saved successful");
    } on DioError catch (error, stacktrace) {
      return BaseResponse(false, "Something went wrong".tr());
    }
  }

  Future<BaseResponse> updateProfile(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);
      Response? response = await _dio?.post(URLS.ADD_DETAILS, data: formData);

      if ((response?.data) == null || (response?.data)["status"] != 200) {
        return BaseResponse(false, response?.data["message"]);
      }
      return BaseResponse(true, "Profile saved successful");
    } on DioError catch (error, stacktrace) {
      return BaseResponse(false, "Something went wrong".tr());
    }
  }

  Future<ProductListResponse> getCategoryProductList(
      Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);
      Response? response =
          await _dio?.post(URLS.CATEGORY_PRODUCT_LIST, data: formData);

      if ((response?.data) == null || (response?.data)["status"] != 200) {
        return ProductListResponse(false, response?.data["message"]);
      }
      List<Product> list = (response?.data["data"] as List)
          .map((e) => Product.fromJson(e))
          .toList();
      return ProductListResponse(true, "Product list fetched successful",
          list: list);
    } on DioError catch (error, stacktrace) {
      return ProductListResponse(false, "Something went wrong".tr());
    }
  }

  Future<ProductListResponse> getOfferProductList(
      Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);
      Response? response =
          await _dio?.post(URLS.ALL_PRODUCT_LIST, data: formData);

      if ((response?.data) == null || (response?.data)["status"] != 200) {
        return ProductListResponse(false, response?.data["message"]);
      }
      List<Product> list = (response?.data["data"] as List)
          .map((e) => Product.fromJson(e))
          .toList();
      return ProductListResponse(true, "Product list fetched successful",
          list: list);
    } on DioError catch (error, stacktrace) {
      return ProductListResponse(false, "Something went wrong".tr());
    }
  }

  Future<DeliverySlotsResponse> getDeliverySlots(
      Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);
      Response? response =
          await _dio?.post(URLS.DELIVERY_SLOTS, data: formData);

      if ((response?.data) == null || (response?.data)["status"] != 200) {
        return DeliverySlotsResponse(false, response?.data["message"]);
      }
      List<DeliverySlotModel> list = (response?.data["data"] as List)
          .map((e) => DeliverySlotModel.fromJson(e))
          .toList();
      return DeliverySlotsResponse(true, "Delivery slots fetched successful",
          list: list);
    } on DioError catch (error, stacktrace) {
      return DeliverySlotsResponse(false, "Something went wrong".tr());
    }
  }

  Future<OrderHistoryResponse> getOrderHistory(
      Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);
      Response? response = await _dio?.post(URLS.ORDER_HISTORY, data: formData);

      if ((response?.data) == null || (response?.data)["status"] != 200) {
        return OrderHistoryResponse(false, response?.data["message"]);
      }
      List<OrderHistoryModel> list = (response?.data["response"] as List)
          .map((e) => OrderHistoryModel.fromJson(e))
          .toList();
      return OrderHistoryResponse(true, "Order history fetched successful",
          list: list);
    } on DioError catch (error, stacktrace) {
      return OrderHistoryResponse(false, "Something went wrong".tr());
    }
  }

  Future<OrderItemsResponse> getOrderItems(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);
      Response? response =
          await _dio?.post(URLS.ORDER_PRODUCT_URL, data: formData);

      if ((response?.data) == null || (response?.data)["status"] != 200) {
        return OrderItemsResponse(false, response?.data["message"]);
      }
      List<OrderItemModel> list = (response?.data["data"] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList();
      return OrderItemsResponse(true, "Order item fetched successful",
          list: list);
    } on DioError catch (error, stacktrace) {
      return OrderItemsResponse(false, "Something went wrong".tr());
    }
  }

  Future<BaseResponse> placeOrder(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);

      print(formData.fields);
      Response? response = await _dio?.post(URLS.PLACE_ORDER, data: formData);

      if ((response?.data) == null || (response?.data)["status"] != 200) {
        return BaseResponse(false, response?.data["message"]);
      }
      return BaseResponse(true, "Order placed successful");
    } on DioError catch (error, stacktrace) {
      return BaseResponse(false, "Something went wrong".tr());
    }
  }

  Future<TaxRateResponse> getMinTaxRate() async {
    try {
      Response? response = await _dio?.get(URLS.MINIMUM_TAX_RATE,
          queryParameters: {'token': UserController.to.token});

      if ((response?.data) == null || (response?.data)["status"] != 200) {
        return TaxRateResponse(false, response?.data["message"]);
      }
      if (response?.data["data"].length > 0 &&
          response?.data['data'][0]['tax_rate'] != null) {
        print('TEXT RATE ===${response?.data['data'][0]['tax_rate']}');
        return TaxRateResponse(true, "Tax rate fetched",
            rate: response?.data['data'][0]['tax_rate']);
      }
      return TaxRateResponse(false, "Something went wrong".tr());
    } on DioError catch (error, stacktrace) {
      return TaxRateResponse(false, "Something went wrong".tr());
    }
  }

  Future<MinOrderValueResponse> getMinOrderValue() async {
    try {
      Response? response = await _dio?.get(URLS.MINIMUM_ORDER_VALUE,
          queryParameters: {'token': UserController.to.token});

      if ((response?.data) == null || (response?.data)["status"] != 200) {
        return MinOrderValueResponse(false, response?.data["message"]);
      }
      if (response?.data["data"].length > 0 &&
          response?.data['data'][0]['order_value'] != null) {
        return MinOrderValueResponse(true, "Min order value fetched",
            amount: response?.data['data'][0]['order_value']);
      }
      return MinOrderValueResponse(false, "Something went wrong".tr());
    } on DioError catch (error, stacktrace) {
      return MinOrderValueResponse(false, "Something went wrong".tr());
    }
  }
}
