import 'package:dummyjson_api_workshop/models/products.dart';
import 'package:dummyjson_api_workshop/services/api_endpoints.dart';
import 'package:dummyjson_api_workshop/services/networking.dart';
import 'package:dummyjson_api_workshop/widgets/product_row.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  List<Products> _products = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      getAllProducts();
    });
  }

  Future<void> getAllProducts() async {
    final response = await Networking().getRequest(
      url: ApiEndpoints.GET_ALL_PRODUCTS,
    );
    _products = response['products']
        .map<Products>((json) => Products.fromJson(json))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Products')),
      body: Center(
        child: _products.isNotEmpty
            ? ListView.separated(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final currentProduct = _products[index];
                  return ProductsRow(currentProduct: currentProduct);
                },
                separatorBuilder: (context, index) => const Divider(),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
