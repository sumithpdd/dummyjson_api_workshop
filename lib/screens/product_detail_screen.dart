import 'package:dummyjson_api_workshop/models/products.dart';
import 'package:dummyjson_api_workshop/repositories/product_repository.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});
  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductRepository _repository = ProductRepository();
  Products? _product;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    try {
      final product = await _repository.getProductById(widget.productId);
      setState(() {
        _product = product;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text('Error: $_error'))
          : _product != null
          ? ProductsDetailsWidget(product: _product!)
          : const Center(child: Text('Product not found')),
    );
  }
}

class ProductsDetailsWidget extends StatelessWidget {
  const ProductsDetailsWidget({super.key, required this.product});

  final Products product;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(product.title!),
          Image.network(product.images!.first, width: 200, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.description!),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Add To Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
