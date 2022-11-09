///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class OrderHistoryModel {
/*
{
  "Order_id": "73",
  "total_item": "2",
  "order_date": "2022-02-24",
  "delivery_date": "2022-03-02",
  "order_amount": "100",
  "tax_rate": "19"

}
*/

  String? orderId;
  String? totalItem;
  String? orderDate;
  String? deliveryDate;
  String? orderstatus;
  double? orderAmount;
  int? taxRate;

  OrderHistoryModel({
    this.orderId,
    this.totalItem,
    this.orderDate,
    this.deliveryDate,
    this.orderAmount,
    this.orderstatus,
    this.taxRate,
  });
  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    orderId = json['id']?.toString();
    totalItem = json['total_item']?.toString();
    orderstatus = json['order_status']?.toString();
    orderDate = json['order_date']?.toString();
    deliveryDate = json['delivery_date']?.toString();
    orderAmount = double.parse(json['order_amount']?.toString() ?? "0");
    taxRate = int.parse(json['tax_rate']?.toString() ?? "0");
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = orderId;
    data['total_item'] = totalItem;
    data['order_status'] = orderstatus;
    data['order_date'] = orderDate;
    data['delivery_date'] = deliveryDate;
    data['order_amount'] = orderAmount;
    data['tax_rate'] = taxRate;
    return data;
  }
}
