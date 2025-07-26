import 'package:dummyjson_api_workshop/models/products.dart';
import 'package:dummyjson_api_workshop/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductsRow extends StatelessWidget {
  const ProductsRow({super.key, required this.currentProduct});
  final Products currentProduct;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        currentProduct.images!.first,
        width: 75,
        fit: BoxFit.fitWidth,
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) =>
                ProductDetailScreen(productId: currentProduct.id!.toString()),
          ),
        );
      },
      title: Text(currentProduct.title!),
      subtitle: Text(currentProduct.description!),
      trailing: Text(currentProduct.price.toString()),
    );
  }
}
