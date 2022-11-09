
class Category {
/*
{
  "id": "1",
  "sub_category_id": "0",
  "name": "Butter",
  "image": "https://appsontechnologies.in/digitizationApp/uploads/amul-butter.jpg",
  "description": "Butter Product",
  "soft_delete": "not_deleted"
} 
*/

  String? id;
  String? subCategoryId;
  String? name;
  String? image;
  String? description;
  String? softDelete;

  Category({
    this.id,
    this.subCategoryId,
    this.name,
    this.image,
    this.description,
    this.softDelete,
  });
  Category.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    subCategoryId = json['sub_category_id']?.toString();
    name = json['name']?.toString();
    image = json['image']?.toString();
    description = json['description']?.toString();
    softDelete = json['soft_delete']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['sub_category_id'] = subCategoryId;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['soft_delete'] = softDelete;
    return data;
  }
}
