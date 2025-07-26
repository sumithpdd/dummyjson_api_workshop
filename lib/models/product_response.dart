import 'package:json_annotation/json_annotation.dart';
import 'products.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  final List<Products>? products;
  final int? total;
  final int? skip;
  final int? limit;

  ProductResponse({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}
