///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class OrderItemModel {
/*
{
  "quantity": "2",
  "total_price": "100",
  "Product_name": "SuperButter",
  "Product_image": "https://appsontechnologies.in/digitizationApp/uploads/amul-butter.jpg"
} 
*/

  String? quantity;
  String? totalPrice;
  String? productName;
  String? productImage;

  OrderItemModel({
    this.quantity,
    this.totalPrice,
    this.productName,
    this.productImage,
  });
  OrderItemModel.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity']?.toString();
    totalPrice = json['total_price']?.toString();
    productName = json['Product_name']?.toString();
    productImage = json['Product_image']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['total_price'] = totalPrice;
    data['Product_name'] = productName;
    data['Product_image'] = productImage;
    return data;
  }
}
