import 'package:rodenberg/modals/category.dart';
import 'package:rodenberg/modals/delivery_slot.dart';
import 'package:rodenberg/modals/offer.dart';
import 'package:rodenberg/modals/order_history.dart';
import 'package:rodenberg/modals/order_item.dart';
import 'package:rodenberg/modals/product.dart';
import 'package:rodenberg/modals/user.dart';

class BaseResponse<T>{
  bool status;
  String msg;
  T? data;
  BaseResponse(this.status, this.msg,{this.data});
}

class LoginResponse extends BaseResponse<User?>{
  String token;
  LoginResponse(bool status, String msg,  {this.token = "", User? user}) : super(status, msg,data: user);

}

class ProfileResponse extends BaseResponse<User?>{

  ProfileResponse(bool status, String msg, { User? user}) : super(status, msg,data: user);

}

class CategoryListResponse extends BaseResponse<List<Category>>{
  CategoryListResponse(bool status, String msg, {List<Category> list = const []}) : super(status, msg,data: list);

}

class ProductListResponse extends BaseResponse<List<Product>>{
  ProductListResponse(bool status, String msg, {List<Product> list = const []}) : super(status, msg,data: list);
}

class OfferListResponse extends BaseResponse<List<Offer>>{
  OfferListResponse(bool status, String msg, {List<Offer> list = const []}) : super(status, msg,data: list);

}

class DeliverySlotsResponse extends BaseResponse<List<DeliverySlotModel>>{
  DeliverySlotsResponse(bool status, String msg, {List<DeliverySlotModel> list = const []}) : super(status, msg,data: list);

}

class OrderHistoryResponse extends BaseResponse<List<OrderHistoryModel>>{
  OrderHistoryResponse(bool status, String msg, {List<OrderHistoryModel> list = const []}) : super(status, msg,data: list);
}

class OrderItemsResponse extends BaseResponse<List<OrderItemModel>>{
  OrderItemsResponse(bool status, String msg, {List<OrderItemModel> list = const []}) : super(status, msg,data: list);
}

class TaxRateResponse extends BaseResponse<int>{
  TaxRateResponse(bool status, String msg, {int rate = 0}): super(status,msg, data:rate);
}

class MinOrderValueResponse extends BaseResponse<int>{
  MinOrderValueResponse(bool status, String msg, {int amount = 0}): super(status,msg, data:amount);
}