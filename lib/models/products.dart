import 'package:json_annotation/json_annotation.dart';

part 'products.g.dart';

@JsonSerializable()
class Products {
  final int? id;
  final String? title;
  final String? description;
  final num? price;
  final num? discountPercentage;
  final num? rating;
  final int? stock;
  final String? brand;
  final String? category;
  final String? thumbnail;
  final List<String>? images;

  Products({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  // factory Products.fromJson(Map<String, dynamic> json) {
  //   return Products(
  //     id: json['id'],
  //     title: json['title'],
  //     description: json['description'],
  //     price: json['price'],
  //     discountPercentage: json['discountPercentage'],
  //     rating: json['rating'],
  //     stock: json['stock'],
  //     brand: json['brand'],
  //     category: json['category'],
  //     thumbnail: json['thumbnail'],
  //     images: json['images'],
  //   );
  // }
  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}
