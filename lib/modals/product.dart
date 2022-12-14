///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class Product {
/*
{
  "id": "6",
  "name": "Amul cheese",
  "price": "10",
  "stock": "30",
  "image": "https://appsontechnologies.in/digitizationApp/uploads/104808_8-amul-cheese-slices.jpg",
  "description": "Amul cheese product double slice ",
  "is_stock": "avaliable"
}
*/

  String? id;
  String? name;
  String? price;
  late int stock;
  String? image;
  String? description;
  String? isStock;
  String? discountPercent;
  double? discountPrice;

  Product({
    this.id,
    this.name,
    this.price,
    required this.stock,
    this.image,
    this.description,
    this.isStock,
    this.discountPercent,
    this.discountPrice,
  });
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    price = json['price']?.toString();
    stock = int.parse(json['stock']?.toString()??"0");
    image = json['image']?.toString();
    description = json['description']?.toString();
    isStock = json['is_stock']?.toString();
    discountPercent = json['discount_percent']?.toString()??"0";
    discountPrice = json['discount_price']?.toDouble()??double.parse(price!);
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['stock'] = stock;
    data['image'] = image;
    data['description'] = description;
    data['is_stock'] = isStock;
    data['discount_percent'] = discountPercent;
    data['discount_price'] = discountPrice;
    return data;
  }
}
