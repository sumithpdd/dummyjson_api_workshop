// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  description: json['description'] as String?,
  price: json['price'] as num?,
  discountPercentage: json['discountPercentage'] as num?,
  rating: json['rating'] as num?,
  stock: (json['stock'] as num?)?.toInt(),
  brand: json['brand'] as String?,
  category: json['category'] as String?,
  thumbnail: json['thumbnail'] as String?,
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'price': instance.price,
  'discountPercentage': instance.discountPercentage,
  'rating': instance.rating,
  'stock': instance.stock,
  'brand': instance.brand,
  'category': instance.category,
  'thumbnail': instance.thumbnail,
  'images': instance.images,
};
