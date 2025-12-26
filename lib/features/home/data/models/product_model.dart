// product_model.dart
import 'dart:convert';

List<ProductModel> productModelFromJson(String str) {
  final jsonData = json.decode(str);
  return List<ProductModel>.from(
    jsonData['products'].map((x) => ProductModel.fromJson(x)),
  );
}

String productModelToJson(List<ProductModel> data) =>
    json.encode({"products": List<dynamic>.from(data.map((x) => x.toJson()))});

class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final String? brand;
  final String image;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    this.brand,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      title: json["title"] ?? "No title",
      description: json["description"] ?? "",
      price: (json["price"] as num?)?.toDouble() ?? 0.0,
      rating: (json["rating"] as num?)?.toDouble() ?? 0.0,
      brand: json["brand"],
      image: json["thumbnail"] ?? "", // أو json["images"]?[0]
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "rating": rating,
    "brand": brand,
    "thumbnail": image,
  };
}
